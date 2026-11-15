//! Not a quicktype file: the parts a large top-level JSON array, or large
//! JSON Lines, is read in, and reading them where the CLI's threads are
//! not: in the WebAssembly engine, on several Web Workers, each with an
//! engine instance of its own (quickertype-core's `src/native/parallel.ts`,
//! which the playground uses).
//!
//! [`Plan`] cuts a sample into ranges, as the CLI's parallel reader
//! (`parallel_read`, which uses it too) does. In the engine, the steps are
//! that reader's, each a call on some instance: each range is summarized
//! ([`summarize`], `json_split`), the summaries are resolved in order to
//! the state at each range's start ([`resolve`]), each range that may hold
//! a split is searched for its first one ([`find_split`]: a comma between
//! the top-level array's elements, a line feed between JSON Lines'
//! values), and the parts between consecutive splits ([`form_parts`]) are
//! read into tallies ([`PartTallies::read`]), whose trees go, as bytes
//! ([`PartTallies::export`]), to the instance that appends them in order
//! ([`PartTallies::append`]). Where the CLI would read a sample in one go
//! (no split, JSON Lines without one in their first MiB, a part too long
//! to read beside others, trees far larger than their text: [`form_parts`]
//! and [`decide`]), so does the engine.
//!
//! The reader differs: the engine reads samples with `JSON.parse`
//! semantics, the JavaScript API's, within its limits (`quicktype-wasm`'s
//! `samples.rs`), and so each part is read by that reader (`from_string`):
//! `[` + part + `]` (`[` + part for the last part, which holds the
//! array's `]`), or as JSON Lines (where only the first part may start
//! with a byte order mark). That reader is a state machine too: after `[`
//! it is where it is after a comma between elements, but for an empty
//! array; at a line feed outside every value, between two values. So the
//! CLI's argument holds as it is (`docs/STREAMING-INFERENCE.md`, "Why it
//! is exact"): parts that read, none of them empty or starting with `]`,
//! appended in order, are the tree of reading the sample in one go. A
//! part that does not read (it is not JSON there, holds a value the
//! engine declines, or is not UTF-8) is no error here: the caller reads
//! the whole sample in one go, which then gives what it always gives,
//! errors and their messages included. So does a part whose bytes are
//! not valid UTF-8: a sample split between ASCII bytes is UTF-8 exactly
//! when each part is.
//!
//! Each part's tree is the tree of reading its elements on their own; the
//! engine's one-go reading tallies the compressed form instead, which
//! gives the same types (the streaming fuzzer's `Path::All`), and the
//! sample's root value, which the JavaScript API keeps, is the one
//! TypeScript gives the array: its index is the number of arrays in the
//! sample but one ([`PartTallies::root_index`]).

use std::rc::Rc;

use super::compressed_json::{
    CompressedJson, Framing, StringSampleLimits, read_string_sample_into,
};
use super::json_split::{self, RangeSummarizer, ScanState, Separator, escaped_after};
use super::tallies::{NodeId, PortableTree, RunningTallies, TallyBuilder};
use crate::messages::Result;
use crate::support::support::panic;

/// The default range size: large enough that the tallies of a part, and
/// appending them, cost little next to reading it, small enough that the
/// threads share the work evenly (see docs/BENCHMARKS.md).
pub const DEFAULT_RANGE: usize = 4 << 20;

/// The least range size for a sample that the default ranges would cut
/// into too few parts.
pub const MIN_RANGE: usize = 256 << 10;

/// How many parts each thread should get, at least, for the work to be
/// shared evenly: where the default ranges give fewer, they are smaller.
pub const PARTS_PER_THREAD: usize = 4;

/// The default smallest sample read on several threads: below it, reading
/// on several threads saves at most a millisecond or two, at two to three
/// times the CPU time (see docs/BENCHMARKS.md).
pub const DEFAULT_MIN_LEN: u64 = 8 << 20;

/// The least the trees of the parts being read on other threads may take
/// together by default (see `parallel_read`'s `Reading::coordinate`);
/// otherwise the threads that read times the range size.
pub const TREE_BUDGET: u64 = 32 << 20;

/// The most threads that read a sample, whatever the options ask for.
pub const MAX_THREADS: usize = 1024;

/// The most ranges a sample is cut into, whatever the options ask for:
/// what is kept for each takes about 100 bytes.
pub const MAX_RANGES: usize = 1 << 16;

/// Parts shorter than this tell little about how large other parts' trees
/// are (a single element has a tree as large as its text, many share
/// theirs).
pub const PROBE_LEN: u64 = 64 << 10;

/// Where the first parts' trees are more than this many times their text
/// (elements of distinct keys; measured on PROBE_LEN of text, in samples
/// of 4 MiB or more), the rest is read in one go: appending such trees on
/// the reading thread costs about as much as reading them, so the threads
/// would only add memory. (Measured: trees 4.3 times their
/// text read 2.5 times as fast on 12 threads, 9.5 and 27 times 1.3 and 1.15
/// times as slow; see docs/BENCHMARKS.md.)
pub const MAX_RATIO: f64 = 8.0;

/// How near its start JSON Lines must have a line feed between two values
/// to be read on several threads; otherwise they are read in one go. A
/// first value longer than this is rare, and a stray `[` or `{` at the
/// start, which leaves no line feed at depth 0 anywhere (an error reading
/// in one go reports at once), would otherwise have the ranges scanned
/// until a part as long as the budget allows (half of it). Arrays have no
/// such bound: their first element may be that long.
pub const FIRST_LINE_MAX: u64 = 1 << 20;

/// How a sample is read in parts, for its size: the size of its ranges and
/// how many there are, the threads (or workers) that read it, and the
/// budget for the parts' trees.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Plan {
    /// The ranges' size.
    pub range: u64,
    /// The first range's size: shorter, so that the first parts, which
    /// are read where the parts are appended to measure the trees, are.
    pub head: u64,
    /// How many ranges there are.
    pub ranges: usize,
    /// How much text the first parts hold, at least, when their tree
    /// gives the first ratio of tree to text.
    pub probe: u64,
    /// How many threads (or workers) read.
    pub threads: usize,
    /// The bytes the parts' trees under way may take together.
    pub budget: u64,
    /// The sample's length.
    pub len: u64,
}

impl Plan {
    /// How a sample of `size` bytes is read with at most `threads` threads,
    /// ranges of at most `range` bytes but at least `least`, if it has
    /// `min_len` bytes or more, with `budget` for the parts' trees (or the
    /// default); `None` for in one go.
    pub(crate) fn with(
        threads: usize,
        range: u64,
        least: u64,
        min_len: u64,
        budget: Option<u64>,
        size: u64,
    ) -> Option<Plan> {
        if threads < 2 {
            return None;
        }
        let threads = threads.min(MAX_THREADS);
        let share = size / threads.saturating_mul(PARTS_PER_THREAD) as u64;
        let range = range
            .min(share.max(MIN_RANGE as u64))
            .max(least)
            .max(size.div_ceil(MAX_RANGES as u64 - 1));
        if size < min_len || size <= range {
            return None;
        }
        // PROBE_LEN, or a 64th of a smaller sample; the first range twice
        // that, if the ranges are longer.
        let probe = PROBE_LEN.min(size / 64).max(1);
        let head = range.min(2 * probe);
        let ranges = 1 + usize::try_from((size - head).div_ceil(range)).ok()?;
        // No more threads than the ranges give PARTS_PER_THREAD each (more
        // would wait for work, and the default budget grows with them); a
        // single one would only add the scan to reading in one go.
        let threads = threads.min(ranges.div_ceil(PARTS_PER_THREAD));
        if threads < 2 {
            return None;
        }
        Some(Plan {
            range,
            head,
            ranges,
            probe,
            threads,
            budget: budget
                .unwrap_or_else(|| (threads as u64).saturating_mul(range).max(TREE_BUDGET)),
            len: size,
        })
    }

    /// How the WebAssembly engine's workers read a sample of `size` bytes:
    /// at most `workers` of them, if it has `min_len` bytes or more, with
    /// the CLI's ranges, or ranges of at most `range` bytes, down to one,
    /// if it is given (for tests: as the CLI's internal
    /// `QUICKTYPE_READ_CHUNK`); `None` for in one go.
    pub fn for_workers(
        size: u64,
        workers: usize,
        min_len: u64,
        range: Option<u64>,
    ) -> Option<Plan> {
        match range {
            Some(range) => Self::with(workers, range, 1, min_len, None, size),
            None => Self::with(
                workers,
                DEFAULT_RANGE as u64,
                MIN_RANGE as u64,
                min_len,
                None,
                size,
            ),
        }
    }

    /// Range `k`: from where to where.
    pub fn bounds(&self, k: usize) -> (u64, u64) {
        let (from, to) = match k {
            0 => (0, self.head),
            k => {
                let from = self.head + (k as u64 - 1) * self.range;
                (from, from + self.range)
            }
        };
        (from, to.min(self.len))
    }
}

/// What a range does to the split search's state (`json_split`), from
/// either string state at its start, and, where the bytes before it do
/// not tell whether its first byte is escaped, for both cases.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct RangeSummary(json_split::RangeSummary);

impl RangeSummary {
    /// How many numbers [`to_numbers`](Self::to_numbers) gives.
    pub const NUMBERS: usize = 15;

    /// The summary as numbers (for JavaScript): whether it is known (1) or
    /// for both cases of the first byte (0), then each case's escapes in
    /// and out, odd quotes, depth changes and lowest depths.
    pub fn to_numbers(&self) -> [f64; Self::NUMBERS] {
        let (known, both) = match self.0 {
            json_split::RangeSummary::Known(s) => (true, [s, s]),
            json_split::RangeSummary::Either(both) => (false, both),
        };
        let mut out = [0.0; Self::NUMBERS];
        out[0] = f64::from(u8::from(known));
        for (i, s) in both.iter().enumerate() {
            let at = 1 + 7 * i;
            out[at] = f64::from(u8::from(s.escaped_in));
            out[at + 1] = f64::from(u8::from(s.escaped_out));
            out[at + 2] = f64::from(u8::from(s.odd_quotes));
            out[at + 3] = s.depth_change[0] as f64;
            out[at + 4] = s.depth_change[1] as f64;
            out[at + 5] = s.lowest[0] as f64;
            out[at + 6] = s.lowest[1] as f64;
        }
        out
    }

    /// The summary [`to_numbers`](Self::to_numbers) gave `numbers`, if
    /// they are such numbers.
    pub fn from_numbers(numbers: &[f64]) -> Option<Self> {
        let [known, rest @ ..] = numbers else {
            return None;
        };
        if rest.len() != 14 {
            return None;
        }
        let flag = |x: f64| match x {
            0.0 => Some(false),
            1.0 => Some(true),
            _ => None,
        };
        let depth = |x: f64| (x.fract() == 0.0 && x.abs() <= 2f64.powi(53)).then_some(x as i64);
        let summary = |s: &[f64]| -> Option<json_split::Summary> {
            Some(json_split::Summary {
                escaped_in: flag(s[0])?,
                escaped_out: flag(s[1])?,
                odd_quotes: flag(s[2])?,
                depth_change: [depth(s[3])?, depth(s[4])?],
                lowest: [depth(s[5])?, depth(s[6])?],
            })
        };
        let (first, second) = (summary(&rest[..7])?, summary(&rest[7..])?);
        Some(RangeSummary(if flag(*known)? {
            json_split::RangeSummary::Known(first)
        } else {
            json_split::RangeSummary::Either([first, second])
        }))
    }
}

/// The summary of range `range` of a sample, of which `before` are the
/// bytes just before it (up to 64 of them; fewer only at the sample's
/// start, `at_start`).
pub fn summarize(before: &[u8], at_start: bool, range: &[u8]) -> RangeSummary {
    let mut summarizer = RangeSummarizer::new(escaped_after(before, at_start));
    summarizer.piece(range);
    RangeSummary(summarizer.finish())
}

/// The split search's state at a range's start: whether the byte there is
/// escaped, whether it is in a string, and the brackets open there.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct SplitState {
    pub escaped: bool,
    pub in_string: bool,
    pub depth: i64,
}

impl From<ScanState> for SplitState {
    fn from(s: ScanState) -> Self {
        SplitState {
            escaped: s.escaped,
            in_string: s.in_string,
            depth: s.depth,
        }
    }
}

impl From<SplitState> for ScanState {
    fn from(s: SplitState) -> Self {
        ScanState {
            escaped: s.escaped,
            in_string: s.in_string,
            depth: s.depth,
        }
    }
}

fn separator(framing: Framing) -> Separator {
    match framing {
        Framing::Value => Separator::ARRAY,
        Framing::Lines => Separator::LINES,
    }
}

/// The ranges of `summaries` (all of a sample's, in order), resolved in
/// order: each one's state at its start, and whether it may hold a split
/// (a comma between the top-level array's elements, or with `lines` a line
/// feed between values), by the bound of its depths.
pub fn resolve(summaries: &[RangeSummary], lines: bool) -> Vec<(SplitState, bool)> {
    let separator = separator(if lines {
        Framing::Lines
    } else {
        Framing::Value
    });
    let mut state = ScanState::default();
    summaries
        .iter()
        .map(|summary| {
            let start = state;
            let (may_split, after) = state.through(summary.0, separator);
            state = after;
            (start.into(), may_split)
        })
        .collect()
}

/// The first split in `range`, which starts in state `state`: its index in
/// the range, if it has one.
pub fn find_split(range: &[u8], state: SplitState, lines: bool) -> Option<usize> {
    let separator = separator(if lines {
        Framing::Lines
    } else {
        Framing::Value
    });
    ScanState::from(state).split_in(range, separator)
}

/// Where a top-level array's first part starts in a sample whose bytes
/// begin with `head`: right after the array's `[`, which only JSON's
/// whitespace may come before (and a byte order mark first, which is not
/// part of the text a `TextDecoder` gives); `None` if the sample's value
/// is not an array, or `head` ends before its first byte.
pub fn array_start(head: &[u8]) -> Option<u64> {
    let text = head.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(head);
    let skipped = head.len() - text.len();
    let at = text.iter().position(|b| !is_json_whitespace(*b))?;
    (text[at] == b'[').then_some((skipped + at + 1) as u64)
}

/// `JSON.parse`'s whitespace.
fn is_json_whitespace(b: u8) -> bool {
    matches!(b, b' ' | b'\t' | b'\n' | b'\r')
}

/// Why a sample is read in one go, where the CLI would read it so
/// ([`form_parts`], [`decide`]).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum InOneGo {
    /// No split at all: an array of one element (or none), JSON Lines of
    /// one value.
    NoSplit,
    /// JSON Lines without a split in the ranges that start within
    /// [`FIRST_LINE_MAX`] of the start.
    NoEarlyLineFeed,
    /// A part whose tree would take more than half the budget.
    PartTooLong,
    /// The first parts' trees are more than [`MAX_RATIO`] times their text.
    TreesTooLarge,
}

impl InOneGo {
    /// What the reason is, in words.
    pub fn message(self) -> &'static str {
        match self {
            InOneGo::NoSplit => "no split",
            InOneGo::NoEarlyLineFeed => "no line feed between values in the first MiB",
            InOneGo::PartTooLong => "a part too long to read beside others",
            InOneGo::TreesTooLarge => "trees far larger than their text",
        }
    }

    /// Whether it holds of the sample whatever the plan (the threads, the
    /// ranges, the budget): a sample with no split has no separator
    /// anywhere (the first one would be some range's first split), and the
    /// probe measures the same first parts under any plan of a sample this
    /// size (the first range is twice the probe long, whatever the others
    /// are). Which ranges start in the first MiB, and the budget, are the
    /// plan's: another plan may read the sample in parts.
    pub fn always(self) -> bool {
        matches!(self, InOneGo::NoSplit | InOneGo::TreesTooLarge)
    }
}

/// A part of a sample: from `from` to the split at `to` (a comma, or a
/// line feed), after which the next part starts, or to the end of the
/// sample.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Part {
    pub from: u64,
    pub to: Option<u64>,
    /// Whether it is the first part, which starts right after the array's
    /// `[` (JSON Lines': with the sample); every other one starts after a
    /// split.
    pub first: bool,
}

impl Part {
    /// How many bytes it has, in a sample of `len` bytes.
    pub fn len(&self, len: u64) -> u64 {
        self.to.unwrap_or(len) - self.from
    }

    /// Whether it has no bytes.
    pub fn is_empty(&self, len: u64) -> bool {
        self.len(len) == 0
    }
}

/// The parts of a sample read with `plan`, between consecutive splits:
/// from `first` (where the first part starts) and `splits`, each range's
/// first split if it has one (where it is in the sample), in order. `Err`
/// says why the sample is read in one go instead, where the CLI would read
/// it so: no split at all; JSON Lines (`lines`) whose first split is not
/// in a range that starts within [`FIRST_LINE_MAX`] of the start; or a
/// part longer than half the budget (a tree at least as large as its text
/// would not be read beside others). The last part is checked once the
/// trees are measured ([`decide`]).
pub fn form_parts(
    plan: &Plan,
    first: u64,
    splits: &[Option<u64>],
    lines: bool,
) -> std::result::Result<Vec<Part>, InOneGo> {
    let mut parts: Vec<Part> = Vec::new();
    let mut next_from = first;
    for (k, split) in splits.iter().enumerate() {
        if lines && parts.is_empty() && plan.bounds(k).0 >= FIRST_LINE_MAX {
            return Err(InOneGo::NoEarlyLineFeed);
        }
        let Some(split) = *split else {
            continue;
        };
        // (A split the scan placed before the first part's start, or two in
        // one place, is no split: the scan is exact for valid JSON, and a
        // part around such a place would not read.)
        if split < next_from {
            continue;
        }
        let part = Part {
            from: next_from,
            to: Some(split),
            first: parts.is_empty(),
        };
        if part.len(plan.len) as f64 * 2.0 > plan.budget as f64 {
            return Err(InOneGo::PartTooLong);
        }
        parts.push(part);
        next_from = split + 1;
    }
    if parts.is_empty() {
        return Err(InOneGo::NoSplit);
    }
    parts.push(Part {
        from: next_from,
        to: None,
        first: false,
    });
    Ok(parts)
}

/// What the first parts' trees told: the text they hold, their trees'
/// bytes together, and the smallest tree.
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct Probe {
    pub text: u64,
    pub trees: u64,
    pub smallest: u64,
}

/// Whether the parts after the first `probed` of them (which the probe
/// measured) are read beside each other, as the CLI decides: `Err` says
/// why the sample is read in one go instead (the first parts' trees are
/// more than [`MAX_RATIO`] times their text, or a part's tree, estimated
/// by that ratio, would take more than half the budget).
pub fn decide(
    plan: &Plan,
    parts: &[Part],
    probed: usize,
    probe: Probe,
) -> std::result::Result<(), InOneGo> {
    let ratio = (probe.trees as f64 / probe.text.max(1) as f64).max(1.0);
    if ratio > MAX_RATIO && probe.text >= PROBE_LEN {
        return Err(InOneGo::TreesTooLarge);
    }
    for part in parts.iter().skip(probed) {
        let estimate = ((ratio * part.len(plan.len) as f64) as u64).max(probe.smallest);
        if estimate.saturating_mul(2) > plan.budget {
            return Err(InOneGo::PartTooLong);
        }
    }
    Ok(())
}

/// Why a part was not read into tallies: the sample is to be read in one
/// go, which reports what is wrong, if anything.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum NotRead {
    /// Its bytes are not UTF-8.
    NotUtf8,
    /// It is empty, or starts with `]`, where a value must come first; or
    /// it starts with a byte order mark where only the first part may.
    NotAPart,
    /// The reader failed on it, or declined it (deeper than the limits,
    /// a lone surrogate).
    NotRead,
    /// Appending it failed, or its tree would take more than allowed.
    NotAppended,
}

/// The tallies of the parts of a sample read so far, appended in order: a
/// worker reads its parts into them, and hands them over as bytes; the
/// instance that appends every part's tree keeps them for the runs on the
/// sample ([`into_shared`](Self::into_shared)).
pub struct PartTallies {
    running: RunningTallies,
    /// How samples are read: the date/time recognizer, `$ref` handling and
    /// integer range.
    config: CompressedJson,
    /// The parts' tree so far.
    root: Option<NodeId>,
    /// The arrays in the parts so far but each part's own: the sample's,
    /// but for its root.
    inner_arrays: u64,
    limits: StringSampleLimits,
}

/// What the bytes of parts' tallies start with (and the version of their
/// format); the tree's own bytes follow the parts' counts.
const MAGIC: &[u8] = b"qtParts1\n";

impl PartTallies {
    /// No parts yet, read as `config` reads samples, within `limits`.
    pub fn new(config: CompressedJson, limits: StringSampleLimits) -> Self {
        PartTallies {
            running: RunningTallies::new(),
            config,
            root: None,
            inner_arrays: 0,
            limits,
        }
    }

    /// Reads part `bytes` (the sample's bytes of one part, without the
    /// splits around it) and appends it to the parts so far, which must be
    /// the parts before it: as the elements of an array, or (`lines`) as
    /// JSON Lines. `first` is the sample's first part: JSON Lines' starts
    /// with the sample, whose byte order mark, if any, is not part of the
    /// text (as for `TextDecoder`); then the reader skips another. `last`
    /// is its last part, which runs to the end of the sample (an array's
    /// holds its `]`). Nothing is appended if it is not read.
    pub fn read(
        &mut self,
        bytes: &[u8],
        lines: bool,
        first: bool,
        last: bool,
    ) -> std::result::Result<(), NotRead> {
        let (tree, arrays) = read_part(
            &mut self.running,
            &self.config,
            self.limits,
            bytes,
            lines,
            first,
            last,
        )?;
        self.append_tree(tree, arrays)
    }

    /// [`read`](Self::read), as the CLI reads the first parts to measure
    /// their trees: into tallies of its own, whose tree, made portable, is
    /// then appended. Returns the bytes of that tree.
    pub fn read_measured(
        &mut self,
        bytes: &[u8],
        lines: bool,
        first: bool,
        last: bool,
    ) -> std::result::Result<u64, NotRead> {
        let mut part = RunningTallies::new();
        let (tree, arrays) = read_part(
            &mut part,
            &self.config,
            self.limits,
            bytes,
            lines,
            first,
            last,
        )?;
        let RunningTallies {
            tallies, strings, ..
        } = part;
        let portable =
            PortableTree::new(tallies, strings, tree).map_err(|_| NotRead::NotAppended)?;
        let size = portable.heap_size() as u64;
        let tree = self
            .running
            .tallies
            .import(&mut self.running.strings, portable)
            .map_err(|_| NotRead::NotAppended)?;
        self.append_tree(tree, arrays)?;
        Ok(size)
    }

    /// Appends `tree`, of a part with `arrays` arrays (its own included).
    fn append_tree(&mut self, tree: NodeId, arrays: u64) -> std::result::Result<(), NotRead> {
        match self.root {
            None => self.root = Some(tree),
            // A failed merge changes nothing, and frees what it was given.
            Some(root) => self
                .running
                .tallies
                .merge(root, tree)
                .map_err(|_| NotRead::NotAppended)?,
        }
        self.inner_arrays += arrays.saturating_sub(1);
        Ok(())
    }

    /// About how many bytes these tallies hold.
    pub fn heap_size(&self) -> usize {
        self.running.tallies.heap_size() + self.running.strings.heap_size()
    }

    /// The index TypeScript's `CompressedJSON` gives the root array of a
    /// sample whose parts are all appended (it interns arrays as they end,
    /// so the root comes last): the number of arrays in the sample but one.
    pub fn root_index(&self) -> u64 {
        self.inner_arrays
    }

    /// The parts' tree as bytes, for [`append`](Self::append) in another
    /// instance; an error if no part was read.
    pub fn export(self) -> Result<Vec<u8>> {
        let Some(root) = self.root else {
            return panic("No part was read");
        };
        let RunningTallies {
            tallies, strings, ..
        } = self.running;
        let tree = PortableTree::new(tallies, strings, root)?.to_bytes();
        let mut out = Vec::with_capacity(MAGIC.len() + 10 + tree.len());
        out.extend_from_slice(MAGIC);
        let mut n = self.inner_arrays;
        while n >= 0x80 {
            out.push((n as u8) | 0x80);
            n >>= 7;
        }
        out.push(n as u8);
        out.extend_from_slice(&tree);
        Ok(out)
    }

    /// Appends the parts whose tree another instance [`export`](Self::export)ed
    /// as `bytes`, which come right after the parts so far. If this
    /// fails, the parts so far are as they were.
    pub fn append(&mut self, bytes: &[u8]) -> Result<()> {
        let Some(mut rest) = bytes.strip_prefix(MAGIC) else {
            return panic("Not the bytes of parts' tallies");
        };
        let mut inner = 0u64;
        let mut shift = 0;
        loop {
            let Some((&b, after)) = rest.split_first() else {
                return panic("The bytes of parts' tallies end early");
            };
            rest = after;
            if shift >= 64 {
                return panic("Not the bytes of parts' tallies");
            }
            inner |= u64::from(b & 0x7F) << shift;
            shift += 7;
            if b & 0x80 == 0 {
                break;
            }
        }
        let tree = PortableTree::from_bytes(rest)?;
        let tree = self
            .running
            .tallies
            .import(&mut self.running.strings, tree)?;
        match self.root {
            None => self.root = Some(tree),
            Some(root) => self.running.tallies.merge(root, tree)?,
        }
        self.inner_arrays += inner;
        Ok(())
    }

    /// The tallies of every part, for the runs on the sample
    /// ([`JsonInput::from_tallies`](crate::input::inputs::JsonInput::from_tallies)),
    /// without what only reading more parts needs; `None` if no part was
    /// read.
    pub fn into_shared(self) -> Option<SharedTallies> {
        let root = self.root?;
        let mut running = self.running;
        running.trim();
        Some(SharedTallies {
            tallies: Rc::new(running),
            root,
        })
    }
}

/// Reads part `bytes` into `running` (see [`PartTallies::read`]): its tree
/// and the arrays in it (its own included).
fn read_part(
    running: &mut RunningTallies,
    config: &CompressedJson,
    limits: StringSampleLimits,
    bytes: &[u8],
    lines: bool,
    first: bool,
    last: bool,
) -> std::result::Result<(NodeId, u64), NotRead> {
    let bytes = match (lines, first) {
        // The decoder's byte order mark.
        (true, true) => bytes.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(bytes),
        // The reader's, which only the first part may have.
        (true, false) if bytes.starts_with(b"\xEF\xBB\xBF") => return Err(NotRead::NotAPart),
        _ => bytes,
    };
    let text = std::str::from_utf8(bytes).map_err(|_| NotRead::NotUtf8)?;
    let mut builder = TallyBuilder::new(running, config);
    let read = if lines {
        read_string_sample_into(&mut builder, text, limits, Framing::Lines)
    } else {
        // Before and after a comma comes a value: the part's array must not
        // be empty (its first byte not `]`, and not nothing), unless it is
        // the whole array.
        if !(first && last)
            && !matches!(text.bytes().find(|b| !is_json_whitespace(*b)), Some(b) if b != b']')
        {
            return Err(NotRead::NotAPart);
        }
        // `[`, the part, and `]` unless the part runs to the end of the
        // sample (where the array's own `]` is).
        let mut array = String::with_capacity(text.len() + 2);
        array.push('[');
        array.push_str(text);
        if !last {
            array.push(']');
        }
        read_string_sample_into(&mut builder, &array, limits, Framing::Value)
    };
    let arrays = builder.arrays();
    match read {
        Ok(tree) => Ok((tree, arrays)),
        Err(_) => Err(NotRead::NotRead),
    }
}

/// The tallies of a sample read in parts, which the runs on it share
/// ([`JsonInput::from_tallies`](crate::input::inputs::JsonInput::from_tallies)).
#[derive(Clone)]
pub struct SharedTallies {
    pub(crate) tallies: Rc<RunningTallies>,
    pub(crate) root: NodeId,
}

impl SharedTallies {
    /// About how many bytes they hold.
    pub fn heap_size(&self) -> usize {
        self.tallies.tallies.heap_size() + self.tallies.strings.heap_size()
    }
}

impl std::fmt::Debug for SharedTallies {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("SharedTallies")
            .field("tallies", &self.tallies)
            .finish_non_exhaustive()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;
    use crate::input::compressed_json::Value;
    use crate::input::json_split::tests::{Rng, random_json, random_lines};

    /// The WebAssembly engine's limits (`quicktype-wasm`'s `samples.rs`).
    const LIMITS: StringSampleLimits = StringSampleLimits {
        max_depth: Some(256),
        lone_surrogates: false,
    };

    const BOM: &[u8] = b"\xEF\xBB\xBF";

    fn config() -> CompressedJson {
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), true)
    }

    /// The sample read in one go, as the engine reads bytes (one byte order
    /// mark is the decoder's): its tree and the index TypeScript gives its
    /// root array; `None` if it is not read (not UTF-8, not JSON, declined).
    fn in_one_go(bytes: &[u8], lines: bool) -> Option<(String, u64)> {
        let text = std::str::from_utf8(bytes.strip_prefix(BOM).unwrap_or(bytes)).ok()?;
        let framing = if lines {
            Framing::Lines
        } else {
            Framing::Value
        };
        let reading = config();
        let mut running = RunningTallies::new();
        let mut builder = TallyBuilder::new(&mut running, &reading);
        let read = read_string_sample_into(&mut builder, text, LIMITS, framing);
        let arrays = builder.arrays();
        drop(builder);
        let mut cjson = config();
        let value = if lines {
            cjson.read_string_lines_sample(text, LIMITS)
        } else {
            cjson.read_string_sample(text, LIMITS)
        };
        match (read, value) {
            (Ok(tree), Ok(value)) => {
                // TypeScript's root value: the last array interned.
                assert_eq!(value, Value::Array(arrays as u32 - 1));
                Some((running.dump(tree), arrays - 1))
            }
            (Err(_), Err(_)) => None,
            (Ok(_), Err(e)) => panic!("read into tallies, but not into a form: {e:?}"),
            (Err(e), Ok(_)) => panic!("read into a form, but not into tallies: {e:?}"),
        }
    }

    /// The sample read in parts as the engine's workers read it, with
    /// `workers` of them and ranges of at most `range` bytes: the ranges
    /// summarized (the summaries through numbers, as through JavaScript),
    /// resolved, searched, the parts formed, the first ones read here to
    /// measure their trees, the others by the worker whose ranges they
    /// start in, each worker's parts appended here as bytes. `Err` says
    /// why it is to be read in one go.
    fn in_parts(
        bytes: &[u8],
        lines: bool,
        workers: usize,
        range: u64,
    ) -> std::result::Result<(String, u64), String> {
        let len = bytes.len() as u64;
        let plan = Plan::for_workers(len, workers, 0, Some(range)).ok_or("no plan")?;
        let first = if lines {
            0
        } else {
            array_start(&bytes[..bytes.len().min(4096)]).ok_or("not an array")?
        };
        let summaries: Vec<RangeSummary> = (0..plan.ranges)
            .map(|k| {
                let (from, to) = plan.bounds(k);
                let before = from.saturating_sub(64);
                let summary = summarize(
                    &bytes[before as usize..from as usize],
                    before == 0,
                    &bytes[from as usize..to as usize],
                );
                RangeSummary::from_numbers(&summary.to_numbers()).unwrap()
            })
            .collect();
        let splits: Vec<Option<u64>> = resolve(&summaries, lines)
            .into_iter()
            .enumerate()
            .map(|(k, (state, may_split))| {
                let (from, to) = plan.bounds(k);
                may_split
                    .then(|| find_split(&bytes[from as usize..to as usize], state, lines))
                    .flatten()
                    .map(|i| from + i as u64)
            })
            .collect();
        let parts = form_parts(&plan, first, &splits, lines).map_err(|e| e.message().to_owned())?;
        let part_bytes = |part: &Part| &bytes[part.from as usize..part.to.unwrap_or(len) as usize];
        let last = |i: usize| i + 1 == parts.len();
        let mut here = PartTallies::new(config(), LIMITS);
        let mut probe = Probe::default();
        let mut probed = 0;
        while probed < parts.len() && probe.text < plan.probe {
            let part = &parts[probed];
            let tree = here
                .read_measured(part_bytes(part), lines, part.first, last(probed))
                .map_err(|e| format!("{e:?}"))?;
            probe.text += part.len(len);
            probe.trees += tree;
            probe.smallest = if probe.smallest == 0 {
                tree
            } else {
                probe.smallest.min(tree)
            };
            probed += 1;
        }
        decide(&plan, &parts, probed, probe).map_err(|e| e.message().to_owned())?;
        // Each worker's ranges, in turn; a part goes to the worker whose
        // ranges it starts in.
        let block = plan.ranges.div_ceil(workers);
        for worker in 0..workers {
            let (from, _) = plan.bounds(worker * block);
            let to = if (worker + 1) * block >= plan.ranges {
                len + 1
            } else {
                plan.bounds((worker + 1) * block).0
            };
            let mut tallies = PartTallies::new(config(), LIMITS);
            let mut read = false;
            for (i, part) in parts.iter().enumerate().skip(probed) {
                if part.from >= from && part.from < to {
                    tallies
                        .read(part_bytes(part), lines, part.first, last(i))
                        .map_err(|e| format!("{e:?}"))?;
                    read = true;
                }
            }
            if read {
                here.append(&tallies.export().unwrap()).unwrap();
            }
        }
        let index = here.root_index();
        let shared = here.into_shared().unwrap();
        Ok((shared.tallies.dump(shared.root), index))
    }

    /// Reads `bytes` in parts every way asked and checks it against
    /// reading it in one go: whenever the parts read, they are the
    /// sample's tree and root, and the sample reads in one go. Returns how
    /// often they read.
    fn check(bytes: &[u8], lines: bool, ranges: &[u64], what: &str) -> usize {
        let one_go = in_one_go(bytes, lines);
        let mut read = 0;
        for &range in ranges {
            for workers in [2, 3, 5] {
                // (Not read in parts: read in one go, whatever it gives.)
                if let Ok(parts) = in_parts(bytes, lines, workers, range) {
                    let Some(one_go) = &one_go else {
                        panic!(
                            "{what}: read in parts but not in one go ({workers} workers, ranges of {range}): {:?}",
                            String::from_utf8_lossy(bytes)
                        );
                    };
                    assert_eq!(
                        &parts, one_go,
                        "{what}: {workers} workers, ranges of {range}"
                    );
                    read += 1;
                }
            }
        }
        read
    }

    /// Breaks `bytes` now and then: a byte left out, one put in, a byte
    /// order mark, the end cut off, garbage after it.
    fn broken(rng: &mut Rng, mut bytes: Vec<u8>) -> Vec<u8> {
        const ALPHABET: &[u8] = b"\"\\,\n[]{}: 1x\xff";
        match rng.below(6) {
            0 if !bytes.is_empty() => {
                bytes.remove(rng.below(bytes.len()));
            }
            1 => {
                let at = rng.below(bytes.len() + 1);
                bytes.insert(at, ALPHABET[rng.below(ALPHABET.len())]);
            }
            2 => {
                let at = rng.below(bytes.len() + 1);
                bytes.splice(at..at, BOM.iter().copied());
            }
            3 => bytes.truncate(rng.below(bytes.len() + 1)),
            4 => bytes.extend_from_slice(b" x"),
            _ => {}
        }
        bytes
    }

    #[test]
    fn arrays_read_in_parts_read_as_in_one_go() {
        let mut rng = Rng(2026);
        let (mut valid, mut read) = (0, 0);
        for round in 0..600 {
            let mut bytes = random_json(&mut rng, 1 + round % 40);
            if round % 7 == 0 {
                bytes.splice(0..0, BOM.iter().copied());
            }
            let intact = round % 3 != 0;
            if !intact {
                bytes = broken(&mut rng, bytes);
            }
            let n = check(&bytes, false, &[1, 3, 16, 64, 200], "an array");
            if intact {
                valid += 1;
                read += usize::from(n > 0);
            }
        }
        assert!(
            read * 10 >= valid * 9,
            "{read} of {valid} valid arrays read in parts"
        );
    }

    #[test]
    fn json_lines_read_in_parts_read_as_in_one_go() {
        let mut rng = Rng(4242);
        let (mut valid, mut read) = (0, 0);
        for round in 0..600 {
            let mut bytes = random_lines(&mut rng, 1 + round % 40);
            if round % 5 == 0 {
                bytes.splice(0..0, BOM.iter().copied());
            }
            if round % 11 == 0 {
                // A byte order mark of the text's own, after the decoder's.
                bytes.splice(0..0, BOM.iter().chain(BOM).copied());
            }
            let intact = round % 3 != 0;
            if !intact {
                bytes = broken(&mut rng, bytes);
            }
            let n = check(&bytes, true, &[1, 3, 16, 64, 200], "JSON Lines");
            if intact && round % 11 != 0 {
                valid += 1;
                read += usize::from(n > 0);
            }
        }
        assert!(
            read * 10 >= valid * 9,
            "{read} of {valid} valid JSON Lines read in parts"
        );
    }

    /// Records of every kind of value the tallies tell apart: dates,
    /// times, UUIDs, URIs, integer and boolean strings, numbers past the
    /// integer range, strings past 64 units, `__proto__` and `$ref`,
    /// repeated keys, nested arrays; arrays nested past the engine's
    /// limit, a lone surrogate, which the engine declines.
    #[test]
    fn records_read_in_parts_read_as_in_one_go() {
        let record = |i: usize| {
            let long = "x".repeat(60 + i % 10);
            format!(
                r##"{{"id":{i},"uuid":"6ba7b810-9dad-11d1-80b4-00c04fd430c{}","when":"2020-01-0{}T00:00:00Z","day":"2020-02-0{}","at":"12:0{}:00","uri":"https://h.example/{i}.png","n":"{}","b":"{}","big":{}e400,"s":"{long}","e":"{}","__proto__":{{"p":{}}},"$ref":"#/x{}","a":[[{}],[]],"o":{{"k":null,"k":true}},"m":{{"k{}":1}}}}"##,
                i % 10,
                1 + i % 9,
                1 + i % 9,
                i % 10,
                i * 7,
                i % 2 == 0,
                i,
                ["red", "green", "blue"][i % 3],
                i % 3,
                i % 4,
                i % 5,
                i,
            )
        };
        let records: Vec<String> = (0..300).map(record).collect();
        let array = format!("[{}]", records.join(",\n"));
        assert!(check(array.as_bytes(), false, &[97, 1024, 4096], "records") > 0);
        let lines = format!("{}\n", records.join("\r\n"));
        assert!(
            check(
                lines.as_bytes(),
                true,
                &[97, 1024, 4096],
                "records as JSON Lines"
            ) > 0
        );
        // Declined by the engine, in one go and in parts.
        let deep = format!("[1,{}{}]", "[".repeat(260), "]".repeat(260));
        assert_eq!(check(deep.as_bytes(), false, &[1, 64], "too deep"), 0);
        let lone = format!("[{},\"\\ud800\",{}]", records[0], records[1]);
        assert_eq!(
            check(lone.as_bytes(), false, &[1, 64], "a lone surrogate"),
            0
        );
    }

    /// The CLI's rules for reading in one go: no split, JSON Lines without
    /// one near their start, parts too long, trees far larger than their
    /// text.
    #[test]
    fn the_cli_s_rules_for_reading_in_one_go() {
        let plan = Plan::for_workers(10 << 20, 4, 0, None).unwrap();
        assert_eq!(
            form_parts(&plan, 1, &vec![None; plan.ranges], false),
            Err(InOneGo::NoSplit)
        );
        let mut splits = vec![None; plan.ranges];
        let far = (0..plan.ranges)
            .find(|&k| plan.bounds(k).0 >= FIRST_LINE_MAX)
            .unwrap();
        splits[far] = Some(plan.bounds(far).0 + 5);
        assert!(form_parts(&plan, 1, &splits, false).is_ok());
        assert_eq!(
            form_parts(&plan, 0, &splits, true),
            Err(InOneGo::NoEarlyLineFeed)
        );
        splits[far - 1] = Some(plan.bounds(far - 1).0 + 5);
        assert!(form_parts(&plan, 0, &splits, true).is_ok());
        // A part longer than half the budget (32 MiB).
        let large = Plan::for_workers(100 << 20, 2, 0, None).unwrap();
        assert_eq!(large.budget, TREE_BUDGET);
        let mut splits = vec![None; large.ranges];
        splits[0] = Some(10);
        splits[large.ranges - 1] = Some(large.bounds(large.ranges - 1).0);
        assert_eq!(
            form_parts(&large, 1, &splits, false),
            Err(InOneGo::PartTooLong)
        );
        // Parts of at most 16 MiB are not.
        for k in (0..large.ranges).step_by(4) {
            splits[k] = Some(large.bounds(k).0 + 10);
        }
        assert!(form_parts(&large, 1, &splits, false).is_ok());
        // Trees far larger than their text, and estimates past the budget.
        let parts = [
            Part {
                from: 1,
                to: Some(100_000),
                first: true,
            },
            Part {
                from: 100_001,
                to: Some(1 << 20),
                first: false,
            },
            Part {
                from: (1 << 20) + 1,
                to: Some(2 << 20),
                first: false,
            },
        ];
        let probe = |trees| Probe {
            text: 100_000,
            trees,
            smallest: trees,
        };
        assert_eq!(decide(&plan, &parts, 1, probe(100_000)), Ok(()));
        assert_eq!(
            decide(&plan, &parts, 1, probe(900_000)),
            Err(InOneGo::TreesTooLarge)
        );
        assert_eq!(
            decide(
                &plan,
                &parts,
                3,
                Probe {
                    text: 1000,
                    trees: 9000,
                    smallest: 9
                }
            ),
            Ok(())
        );
        let small = Plan::for_workers(10 << 20, 2, 0, None).unwrap();
        assert_eq!(
            decide(
                &small,
                &parts,
                1,
                Probe {
                    text: 100_000,
                    trees: 790_000,
                    smallest: 1
                }
            ),
            Ok(())
        );
        assert!(
            decide(
                &small,
                &parts,
                1,
                Probe {
                    text: 100_000,
                    trees: 790_000,
                    smallest: 20 << 20
                }
            )
            .is_err()
        );
        // Which reasons hold whatever the plan: no split, and the probe's
        // ratio, measured on the same first parts by every plan of a
        // sample (the first range and the probe are the same whatever the
        // workers), unlike the budget and which ranges start in the first
        // MiB.
        assert!(InOneGo::NoSplit.always() && InOneGo::TreesTooLarge.always());
        assert!(!InOneGo::NoEarlyLineFeed.always() && !InOneGo::PartTooLong.always());
        for size in [16u64 << 20, 100 << 20, 656 << 20, 2 << 30] {
            let firsts: Vec<(u64, u64)> = (2..=16)
                .filter_map(|workers| Plan::for_workers(size, workers, 0, None))
                .map(|plan| (plan.head, plan.probe))
                .collect();
            assert_eq!(firsts.len(), 15);
            assert!(
                firsts.iter().all(|&f| f == (2 * PROBE_LEN, PROBE_LEN)),
                "{size}: {firsts:?}"
            );
        }
        // Samples too small for parts.
        assert_eq!(Plan::for_workers(1 << 20, 4, 8 << 20, None), None);
        assert_eq!(Plan::for_workers(10 << 20, 1, 0, None), None);
    }

    /// Whole runs over tallies read in parts give the code of runs over
    /// the sample read in one go into a compressed form, the engine's path
    /// (`JsonInput::from_shared`): in several languages, with inference
    /// flags off and on, arrays and JSON Lines.
    #[test]
    fn runs_on_parts_are_runs_in_one_go() {
        use crate::input::inputs::{CompressedTopLevel, InputData, JsonInput};
        use crate::{
            Options, combine_render_results, get_target_language, quicktype_multi_file_sync,
        };

        let records: Vec<String> = (0..400)
            .map(|i| {
                format!(
                    r#"{{"id":{i},"name":"{}","tags":[{}],"seen":"2021-0{}-01","home":"https://h.example/{}/i.png","extra":{}}}"#,
                    ["Ann", "Bo", "Cy"][i % 3],
                    if i % 4 == 0 { "\"a\",\"b\"" } else { "" },
                    1 + i % 9,
                    i % 7,
                    if i % 5 == 0 { "null" } else { "{\"k\":1.5}" },
                )
            })
            .collect();
        let array = format!("[{}]", records.join(","));
        let lines = records.join("\n");
        for (text, lines) in [(array.as_str(), false), (lines.as_str(), true)] {
            let bytes = text.as_bytes();
            let len = bytes.len() as u64;
            let plan = Plan::for_workers(len, 3, 0, Some(1000)).unwrap();
            let first = if lines {
                0
            } else {
                array_start(bytes).unwrap()
            };
            let summaries: Vec<RangeSummary> = (0..plan.ranges)
                .map(|k| {
                    let (from, to) = plan.bounds(k);
                    let before = from.saturating_sub(64);
                    summarize(
                        &bytes[before as usize..from as usize],
                        before == 0,
                        &bytes[from as usize..to as usize],
                    )
                })
                .collect();
            let splits: Vec<Option<u64>> = resolve(&summaries, lines)
                .into_iter()
                .enumerate()
                .map(|(k, (state, may))| {
                    let (from, to) = plan.bounds(k);
                    may.then(|| find_split(&bytes[from as usize..to as usize], state, lines))
                        .flatten()
                        .map(|i| from + i as u64)
                })
                .collect();
            let parts = form_parts(&plan, first, &splits, lines).unwrap();
            assert!(parts.len() > 10);
            for (language, flags) in [
                ("typescript", true),
                ("rust", false),
                ("go", true),
                ("kotlin", false),
            ] {
                let lang = get_target_language(language).unwrap();
                let reading =
                    || CompressedJson::for_target_language(lang, false, &Default::default());
                let mut tallies = PartTallies::new(reading(), LIMITS);
                for (i, part) in parts.iter().enumerate() {
                    let at = &bytes[part.from as usize..part.to.unwrap_or(len) as usize];
                    // Every other part elsewhere, appended as bytes.
                    if i % 2 == 0 {
                        tallies
                            .read(at, lines, part.first, i + 1 == parts.len())
                            .unwrap();
                    } else {
                        let mut elsewhere = PartTallies::new(reading(), LIMITS);
                        elsewhere
                            .read(at, lines, part.first, i + 1 == parts.len())
                            .unwrap();
                        tallies.append(&elsewhere.export().unwrap()).unwrap();
                    }
                }
                let shared = tallies.into_shared().unwrap();
                let mut cjson = reading();
                let root = if lines {
                    cjson.read_string_lines_sample(text, LIMITS)
                } else {
                    cjson.read_string_sample(text, LIMITS)
                }
                .unwrap();
                let root = cjson.encode_value(root).unwrap();
                let run = |input: JsonInput| {
                    let mut input_data = InputData::new();
                    input_data.add_input(input);
                    let mut options = Options::new(lang, input_data);
                    options.inference_flags.infer_enums = flags;
                    options.inference_flags.infer_maps = flags;
                    options.inference_flags.infer_date_times = flags;
                    combine_render_results(quicktype_multi_file_sync(options).unwrap())
                        .lines
                        .join("\n")
                };
                let in_parts = run(JsonInput::from_tallies(
                    reading(),
                    "Records".to_owned(),
                    None,
                    &shared,
                ));
                let in_one_go = run(JsonInput::from_shared(
                    Rc::new(cjson),
                    vec![CompressedTopLevel {
                        name: "Records".to_owned(),
                        description: None,
                        samples: vec![root],
                    }],
                )
                .unwrap());
                assert_eq!(in_parts, in_one_go, "{language}, lines {lines}");
                assert!(in_parts.contains("Record"), "{language}");
            }
        }
    }

    #[test]
    fn where_an_array_starts() {
        assert_eq!(array_start(b"[1]"), Some(1));
        assert_eq!(array_start(b" \r\n\t [1]"), Some(6));
        assert_eq!(array_start(b"\xEF\xBB\xBF [1]"), Some(5));
        assert_eq!(array_start(b"\xEF\xBB\xBF\xEF\xBB\xBF[1]"), None);
        assert_eq!(array_start(b"{\"a\": [1]}"), None);
        assert_eq!(array_start(b"   "), None);
        assert_eq!(array_start(b"\x0c[1]"), None);
    }

    /// Summaries through numbers are the summaries; other numbers are none.
    #[test]
    fn summaries_as_numbers() {
        let bytes = br#"[{"a\\":"b\"]"},[1,2],"\\\\"]"#;
        for at_start in [true, false] {
            for before in [&b""[..], b"\\\\\\", b"x\\"] {
                let summary = summarize(before, at_start, bytes);
                assert_eq!(
                    RangeSummary::from_numbers(&summary.to_numbers()),
                    Some(summary)
                );
            }
        }
        let numbers = summarize(b"", true, bytes).to_numbers();
        assert_eq!(RangeSummary::from_numbers(&numbers[1..]), None);
        let mut odd = numbers;
        odd[2] = 0.5;
        assert_eq!(RangeSummary::from_numbers(&odd), None);
    }
}
