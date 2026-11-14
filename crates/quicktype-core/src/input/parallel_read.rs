//! Not a quicktype file: reading a large top-level JSON array on several
//! threads, into the same tallies as reading it in one go. The CLI reads
//! its regular files this way (see `docs/STREAMING-INFERENCE.md`, "Reading
//! on several threads", for the design and why it is exact).
//!
//! The sample is cut into ranges of equal size. In parallel, each range is
//! summarized ([`json_split`](super::json_split)): what its quotes and
//! brackets do to the string state and the depth, from either string
//! state at its start. In order, the summaries give the exact state at
//! each range's start, and each range whose depths may reach 1 is
//! searched, in parallel, for its first comma at depth 1: a comma between
//! two of the top-level array's elements. Between consecutive such commas
//! lie the *parts*, which are tallied in parallel, each as an array of its
//! elements (`[` + part + `]`) by the stream tokenizer into tallies of its
//! own. Their trees are appended in order to the sample's tree, which is
//! then the tree of reading the sample in one go (`Tallies::merge` is
//! reading on).
//!
//! Every part is read by the same tokenizer as the whole sample, so it
//! only succeeds if it reads as the sample's elements there do. Anything
//! else (a part that fails, one that does not start with a value, a read
//! that fails) ends the reading on several threads: the parts before it
//! are the tree of the sample so far, and the rest is read in one go on
//! into it, from the comma after them, as reading the whole sample in one
//! go reads it from there ([`read_sample`]); a first part that fails, or
//! a file that changes, makes the whole sample read in one go from its
//! start. That reading then reports exactly what it always reports.
//! Nothing the scan finds can change a result.
//!
//! The parts read on other threads hold trees of their own, so how many
//! are under way at once is bounded by the memory their trees take
//! ([`Reading::coordinate`]): where a single part's would take too much,
//! the rest is read in one go into the sample's tree.

use std::cell::Cell;
use std::collections::{BTreeMap, VecDeque};
use std::io::{self, Read};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Condvar, Mutex, OnceLock, mpsc};
use std::thread;

use super::compressed_json::{CompressedJson, Framing, ParseError};
use super::compressed_json_from_stream::{
    is_whitespace, parse_array_rest_into, parse_stream_reader_into,
};
use super::json_split::{
    BLOCK, ScanState, Summarizer, Summary, blocks, escaped_after, trailing_backslashes,
};
use super::tallies::{NodeId, PortableTree, RunningTallies, TallyBuilder};
use crate::date_time::DateTimeRecognizer;
use crate::input::io::node_io::stream_read_error;

/// The bytes of a sample that can be read at any offset, from several
/// threads at once.
pub(crate) enum Positional {
    /// A regular file.
    #[cfg(all(any(unix, windows), feature = "fs"))]
    File(std::fs::File),
    /// Bytes in memory (for tests and fuzzing).
    Memory(Vec<u8>),
}

impl Positional {
    fn len(&self) -> io::Result<u64> {
        match self {
            #[cfg(all(any(unix, windows), feature = "fs"))]
            Positional::File(file) => Ok(file.metadata()?.len()),
            Positional::Memory(bytes) => Ok(bytes.len() as u64),
        }
    }

    /// Reads into `buf` from `offset`: all of it, or up to the end.
    fn read_at(&self, mut buf: &mut [u8], mut offset: u64) -> io::Result<usize> {
        let mut total = 0;
        while !buf.is_empty() {
            let n = match self {
                #[cfg(all(any(unix, windows), feature = "fs"))]
                Positional::File(file) => match read_file_at(file, buf, offset) {
                    Ok(n) => n,
                    Err(e) if e.kind() == io::ErrorKind::Interrupted => continue,
                    Err(e) => return Err(e),
                },
                Positional::Memory(bytes) => {
                    let start = usize::try_from(offset).map_or(bytes.len(), |o| o.min(bytes.len()));
                    let n = buf.len().min(bytes.len() - start);
                    buf[..n].copy_from_slice(&bytes[start..start + n]);
                    n
                }
            };
            if n == 0 {
                break;
            }
            total += n;
            offset += n as u64;
            buf = &mut buf[n..];
        }
        Ok(total)
    }
}

/// Reads `file` into `buf` from `offset`, from any thread: `pread` on Unix.
#[cfg(all(unix, feature = "fs"))]
fn read_file_at(file: &std::fs::File, buf: &mut [u8], offset: u64) -> io::Result<usize> {
    std::os::unix::fs::FileExt::read_at(file, buf, offset)
}

/// Reads `file` into `buf` from `offset`, from any thread: `seek_read` on
/// Windows, which also moves the file's position (reading it in one go
/// seeks first, see [`StreamFrom`]).
#[cfg(all(windows, feature = "fs"))]
fn read_file_at(file: &std::fs::File, buf: &mut [u8], offset: u64) -> io::Result<usize> {
    std::os::windows::fs::FileExt::seek_read(file, buf, offset)
}

/// A sample whose bytes can be read at any offset: a regular file the CLI
/// reads, which it reads on several threads when it is a large top-level
/// array ([`read`]), and otherwise in one go
/// ([`into_reader`](Self::into_reader)).
pub(crate) struct PositionalSample {
    source: Positional,
    /// Where the sample starts.
    start: u64,
    /// The options to read with; `None` for those of the environment
    /// ([`ParallelOptions::from_env`]).
    options: Option<ParallelOptions>,
}

impl PositionalSample {
    /// The regular file `file`, from its start.
    #[cfg(all(any(unix, windows), feature = "fs"))]
    pub(crate) fn file(file: std::fs::File) -> Self {
        PositionalSample {
            source: Positional::File(file),
            start: 0,
            options: None,
        }
    }

    /// Standard input redirected from the regular file `file`, from where
    /// it is: when read whole on several threads, it is left at its end,
    /// as reading it in one go leaves it. `None` if where it is cannot be
    /// told.
    #[cfg(all(unix, feature = "fs"))]
    pub(crate) fn stdin(mut file: std::fs::File) -> Option<Self> {
        let start = io::Seek::stream_position(&mut file).ok()?;
        Some(PositionalSample {
            source: Positional::File(file),
            start,
            options: None,
        })
    }

    /// Moves a file to its end, where reading it in one go leaves it (for
    /// standard input, which another sample may read again).
    fn seek_to_end(&self) {
        #[cfg(all(any(unix, windows), feature = "fs"))]
        if let Positional::File(file) = &self.source {
            let _ = io::Seek::seek(&mut &*file, io::SeekFrom::End(0));
        }
    }

    /// `bytes`, read with `options`.
    pub(crate) fn memory(bytes: Vec<u8>, options: ParallelOptions) -> Self {
        PositionalSample {
            source: Positional::Memory(bytes),
            start: 0,
            options: Some(options),
        }
    }

    /// The sample as a byte stream from its start, to read it in one go.
    pub(crate) fn into_reader(self) -> Box<dyn Read> {
        let start = self.start;
        self.into_reader_from(start)
    }

    /// The sample as a byte stream from `from`. (Reading on several threads
    /// reads at offsets, which leaves a file's position where it was.)
    fn into_reader_from(self, from: u64) -> Box<dyn Read> {
        match self.source {
            #[cfg(all(any(unix, windows), feature = "fs"))]
            Positional::File(file) => Box::new(StreamFrom {
                inner: file,
                seek_to: Some(from),
            }),
            Positional::Memory(bytes) => Box::new(StreamFrom {
                inner: io::Cursor::new(bytes),
                seek_to: Some(from),
            }),
        }
    }
}

/// A reader from `seek_to`, whose failed reads are reported as Node
/// reports them, as the CLI's other streams' are
/// ([`stream_read_error`]).
struct StreamFrom<R> {
    inner: R,
    /// Where to read from, before the first read.
    seek_to: Option<u64>,
}

impl<R: Read + io::Seek> Read for StreamFrom<R> {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        let mut read = || {
            if let Some(at) = self.seek_to.take() {
                self.inner.seek(io::SeekFrom::Start(at))?;
            }
            self.inner.read(buf)
        };
        read().map_err(stream_read_error)
    }
}

/// How a sample is read on several threads. Internal, for tests and
/// benchmarks: the CLI takes them from the environment
/// ([`from_env`](Self::from_env)).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct ParallelOptions {
    /// The most threads that read (besides the one that reads the
    /// sample): fewer for samples with fewer than [`PARTS_PER_THREAD`]
    /// ranges for each, and at most [`MAX_THREADS`]. With fewer than two,
    /// the sample is read in one go.
    pub threads: usize,
    /// The largest size of the ranges the sample is cut into, in bytes; a
    /// part between two splits is about this long. Ranges are smaller for
    /// samples that would not give each thread [`PARTS_PER_THREAD`] of
    /// them, down to [`MIN_RANGE`].
    pub range: usize,
    /// Samples shorter than this (in bytes) are read in one go.
    pub min_len: u64,
    /// How many bytes the trees of the parts being read on other threads
    /// may take together (see [`Reading::coordinate`]); by default
    /// (`None`), the threads that read times the range size, or
    /// [`TREE_BUDGET`].
    pub budget: Option<u64>,
    /// A fault to inject, to check that the checks catch it (for tests).
    #[doc(hidden)]
    pub fault: Option<Fault>,
}

/// A fault [`ParallelOptions::fault`] injects.
#[doc(hidden)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Fault {
    /// Merges each part's tree in front of the parts' before it instead of
    /// after them: the trees merged out of order.
    Prepend,
}

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
/// together by default (see [`Reading::coordinate`]); otherwise the
/// threads that read times the range size.
pub const TREE_BUDGET: u64 = 32 << 20;

/// The most threads that read a sample, whatever the options ask for.
pub const MAX_THREADS: usize = 1024;

/// Parts shorter than this tell little about how large other parts' trees
/// are (a single element has a tree as large as its text, many share
/// theirs).
const PROBE_LEN: u64 = 64 << 10;

impl ParallelOptions {
    /// The options of the environment (read once): as many threads as the
    /// machine runs at once, or `QUICKTYPE_READ_THREADS`, and ranges of
    /// [`DEFAULT_RANGE`] bytes for samples of [`DEFAULT_MIN_LEN`] or more,
    /// or of `QUICKTYPE_READ_CHUNK` bytes for any sample; the parts' trees
    /// may take the threads times the range size, or [`TREE_BUDGET`], or
    /// `QUICKTYPE_READ_BUDGET` bytes. The variables are internal, for tests
    /// and benchmarks: there is no CLI option, and the output does not
    /// depend on them.
    pub fn from_env() -> ParallelOptions {
        static OPTIONS: OnceLock<ParallelOptions> = OnceLock::new();
        *OPTIONS.get_or_init(|| {
            let number = |name: &str| {
                std::env::var(name)
                    .ok()
                    .and_then(|v| v.trim().parse::<usize>().ok())
            };
            let threads = number("QUICKTYPE_READ_THREADS")
                .unwrap_or_else(|| thread::available_parallelism().map_or(1, usize::from));
            let (range, min_len) = match number("QUICKTYPE_READ_CHUNK") {
                Some(range) => (range.max(1), 0),
                None => (DEFAULT_RANGE, DEFAULT_MIN_LEN),
            };
            ParallelOptions {
                threads,
                range,
                min_len,
                budget: number("QUICKTYPE_READ_BUDGET").map(|budget| budget as u64),
                fault: None,
            }
        })
    }
}

/// A sample of `bytes` (a [`JsonSample::Reader`](crate::JsonSample::Reader)),
/// read with `options` (for tests and fuzzing).
pub fn parallel_sample(bytes: Vec<u8>, options: ParallelOptions) -> crate::SampleReader {
    crate::SampleReader::positional(PositionalSample::memory(bytes, options))
}

/// A sample of the regular file `file` (a
/// [`JsonSample::Reader`](crate::JsonSample::Reader)), read with `options`
/// (for tests).
#[cfg(all(any(unix, windows), feature = "fs"))]
pub fn parallel_file_sample(file: std::fs::File, options: ParallelOptions) -> crate::SampleReader {
    crate::SampleReader::positional(PositionalSample {
        source: Positional::File(file),
        start: 0,
        options: Some(options),
    })
}

/// How samples were read on several threads.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct ParallelReads {
    /// Read whole on several threads.
    pub whole: usize,
    /// Read in part on several threads, and the rest in one go.
    pub in_part: usize,
    /// Begun on several threads, then read in one go from the start.
    pub again: usize,
}

/// Whether starting reading thread `i` is to fail, as when the system
/// refuses another thread (for tests).
#[cfg(test)]
fn spawn_fails(i: usize) -> bool {
    SPAWN_FAILS.with(Cell::get) == Some(i)
}

#[cfg(not(test))]
fn spawn_fails(_: usize) -> bool {
    false
}

#[cfg(test)]
thread_local! {
    /// The reading thread that fails to start (for tests).
    static SPAWN_FAILS: Cell<Option<usize>> = const { Cell::new(None) };
    /// A part to read slowly, and how slowly (for tests): see
    /// `trees_waiting_for_a_slow_part_stay_within_the_budget`.
    static SLOW_PART: Cell<Option<(usize, std::time::Duration)>> = const { Cell::new(None) };
    /// A part whose reading thread panics (for tests).
    static PANIC_PART: Cell<Option<usize>> = const { Cell::new(None) };
    /// The most bytes the parts given out held at once in the last reading
    /// on this thread, and the largest part's tree (for tests).
    static HELD: Cell<(u64, u64)> = const { Cell::new((0, 0)) };
    /// How many bytes of ranges the last reading on this thread had
    /// summarized (for tests).
    static SCANNED: Cell<u64> = const { Cell::new(0) };
    /// The most parts given out and not appended yet at once in the last
    /// reading on this thread (for tests).
    static AHEAD: Cell<usize> = const { Cell::new(0) };
}

thread_local! {
    static READS: Cell<ParallelReads> = const {
        Cell::new(ParallelReads { whole: 0, in_part: 0, again: 0 })
    };
}

/// How this thread read samples on several threads (for tests).
pub fn parallel_reads() -> ParallelReads {
    READS.with(Cell::get)
}

fn count_read(count: impl FnOnce(&mut ParallelReads)) {
    READS.with(|r| {
        let mut reads = r.get();
        count(&mut reads);
        r.set(reads);
    });
}

/// How a sample is read on several threads, for its size: the size of its
/// ranges and how many there are, the threads that read it, the budget
/// for the parts' trees, and the fault to inject.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Plan {
    range: u64,
    ranges: usize,
    threads: usize,
    budget: u64,
    fault: Option<Fault>,
}

impl Plan {
    /// How a sample of `size` bytes is read with `options`; `None` for in
    /// one go.
    fn new(options: ParallelOptions, size: u64) -> Option<Plan> {
        if options.threads < 2 {
            return None;
        }
        let threads = options.threads.min(MAX_THREADS);
        let share = size / threads.saturating_mul(PARTS_PER_THREAD) as u64;
        let range = (options.range as u64)
            .min(share.max(MIN_RANGE as u64))
            .max(1);
        if size < options.min_len || size <= range {
            return None;
        }
        let ranges = usize::try_from(size.div_ceil(range)).ok()?;
        // No more threads than the ranges give PARTS_PER_THREAD each (more
        // would wait for work, and the default budget grows with them).
        let threads = threads.min(ranges.div_ceil(PARTS_PER_THREAD));
        Some(Plan {
            range,
            ranges,
            threads,
            budget: options
                .budget
                .unwrap_or_else(|| (threads as u64).saturating_mul(range).max(TREE_BUDGET)),
            fault: options.fault,
        })
    }
}

/// What reading a sample on several threads came to.
enum Outcome {
    /// The sample's tree: all of it was read.
    Whole(NodeId),
    /// The tree of its first parts, and where the rest begins, after a
    /// comma between the top-level array's elements: the rest is to be
    /// read in one go, on into that tree.
    InPart(NodeId, u64),
}

/// Reads `sample` into `tallies`, as reading it in one go does: on several
/// threads as far as it can (see the module), and the rest in one go,
/// which then decides the result (errors included).
pub(crate) fn read_sample(
    sample: PositionalSample,
    tallies: &mut RunningTallies,
    config: &CompressedJson,
) -> Result<NodeId, ParseError> {
    match read(&sample, tallies, config) {
        Some(Outcome::Whole(tree)) => {
            count_read(|r| r.whole += 1);
            sample.seek_to_end();
            Ok(tree)
        }
        // (The parts' tree always has the array's elements.)
        Some(Outcome::InPart(tree, from))
            if tallies.tallies.node(tree).is_ok_and(|n| n.items.is_some()) =>
        {
            count_read(|r| r.in_part += 1);
            let mut builder =
                TallyBuilder::in_array(tallies, config, tree).map_err(ParseError::Quicktype)?;
            parse_array_rest_into(&mut builder, &mut *sample.into_reader_from(from))
        }
        Some(Outcome::InPart(tree, _)) => {
            tallies.tallies.free_tree(tree);
            count_read(|r| r.again += 1);
            parse_stream_reader_into(
                &mut TallyBuilder::new(tallies, config),
                &mut *sample.into_reader(),
                Framing::Value,
            )
        }
        None => parse_stream_reader_into(
            &mut TallyBuilder::new(tallies, config),
            &mut *sample.into_reader(),
            Framing::Value,
        ),
    }
}

/// Reads `sample` into `tallies` on several threads, if it is a large
/// top-level array and `config`'s date/time recognizer can be copied to
/// other threads. `None` leaves `tallies` as they were (but for the text
/// of keys and strings), and the sample is to be read in one go.
fn read(
    sample: &PositionalSample,
    tallies: &mut RunningTallies,
    config: &CompressedJson,
) -> Option<Outcome> {
    let options = sample.options.unwrap_or_else(ParallelOptions::from_env);
    if options.threads < 2 {
        return None;
    }
    let len = sample.source.len().ok()?;
    let plan = Plan::new(options, len.checked_sub(sample.start)?)?;
    let configs = (0..plan.threads)
        .map(|_| {
            Some(ThreadConfig {
                recognizer: config.date_time_recognizer().thread_copy()?,
                handle_refs: config.handle_refs(),
                integer_range: config.supported_integer_range().cloned(),
            })
        })
        .collect::<Option<Vec<_>>>()?;
    // The top-level value must be an array.
    let (open, b) = first_byte(&sample.source, sample.start, len)?;
    if b != b'[' {
        return None;
    }
    let reading = Reading {
        source: &sample.source,
        start: sample.start,
        len,
        range: plan.range,
        ranges: plan.ranges,
        queue: Mutex::new(Queue::default()),
        ready: Condvar::new(),
        abort: AtomicBool::new(false),
        #[cfg(test)]
        slow_part: SLOW_PART.with(Cell::get),
        #[cfg(test)]
        panic_part: PANIC_PART.with(Cell::get),
    };
    let outcome = thread::scope(|scope| {
        let (sender, results) = mpsc::channel();
        // The threads stop when the reading ends, however it ends (were
        // this thread to panic, the scope would wait for them).
        let mut close = Closing(&reading, true);
        for (i, config) in configs.into_iter().enumerate() {
            let (reading, sender) = (&reading, sender.clone());
            let started = !spawn_fails(i)
                && thread::Builder::new()
                    .spawn_scoped(scope, move || {
                        reading.work(config.into_compressed_json(), &sender);
                    })
                    .is_ok();
            // The system would not start another thread: in one go (the
            // threads started stop as the reading closes).
            if !started {
                return None;
            }
        }
        drop(sender);
        let outcome = reading.coordinate(open, tallies, config, &results, plan);
        // Whatever is under way is not needed any more.
        close.1 = !matches!(outcome, Some(Outcome::Whole(_)));
        outcome
    });
    match outcome {
        // Reading in one go reads to the end of the file, which must not
        // have changed.
        Some(Outcome::Whole(tree)) if sample.source.len().ok() != Some(len) => {
            tallies.tallies.free_tree(tree);
            count_read(|r| r.again += 1);
            None
        }
        None => {
            count_read(|r| r.again += 1);
            None
        }
        outcome => outcome,
    }
}

/// The first byte from `at` to `end` that is not whitespace, and where.
fn first_byte(source: &Positional, mut at: u64, end: u64) -> Option<(u64, u8)> {
    let mut buffer = [0u8; 4096];
    while at < end {
        let want = usize::try_from(end - at).map_or(buffer.len(), |n| n.min(buffer.len()));
        let n = source.read_at(&mut buffer[..want], at).ok()?;
        if n == 0 {
            return None;
        }
        if let Some(i) = buffer[..n].iter().position(|&b| !is_whitespace(b)) {
            return Some((at + i as u64, buffer[i]));
        }
        at += n as u64;
    }
    None
}

/// What a thread needs to read as `config` reads: a copy of its date/time
/// recognizer, its `$ref` handling and integer range.
struct ThreadConfig {
    recognizer: Box<dyn DateTimeRecognizer + Send>,
    handle_refs: bool,
    integer_range: Option<crate::support::integer_range::IntegerRange>,
}

impl ThreadConfig {
    fn into_compressed_json(self) -> CompressedJson {
        CompressedJson::new(self.recognizer, self.handle_refs, self.integer_range)
    }
}

/// A part of the sample: from `from` to the comma at `to` (the next
/// part's start), or to the end of the sample.
#[derive(Clone, Copy, Debug)]
struct Part {
    from: u64,
    to: Option<u64>,
    /// Whether it is the first part, which starts right after the
    /// array's `[`; every other one starts after a comma.
    first: bool,
}

enum Job {
    /// Summarize range `k`.
    Summarize(usize),
    /// Find the first comma at depth 1 in range `k`, which starts in this
    /// state.
    Split(usize, ScanState),
    /// Tally part `i`.
    Tally(usize, Part),
}

enum Done {
    Summary(usize, io::Result<RangeSummary>),
    Split(usize, io::Result<Option<u64>>),
    /// A part's tree, or `None` if it did not read as the sample's
    /// elements there do.
    Part(usize, Option<PortableTree>),
    /// A job panicked, with this payload; its thread stops.
    Panicked(Box<dyn std::any::Any + Send>),
}

/// A range's summary, or, where the bytes just before it are all
/// backslashes, one for each case of its first byte: escaped or not, which
/// the ranges before it then tell ([`Summary::escaped_out`]). (Looking
/// further back for where the run starts would read a long run again for
/// every range in it.)
#[derive(Clone, Copy)]
enum RangeSummary {
    Known(Summary),
    Either([Summary; 2]),
}

impl RangeSummary {
    /// The summary for a range whose first byte is `escaped` or not.
    fn given(self, escaped: bool) -> Summary {
        match self {
            RangeSummary::Known(summary) => summary,
            RangeSummary::Either(both) => both[usize::from(escaped)],
        }
    }
}

/// The jobs waiting: scans first, which the parts wait for.
#[derive(Default)]
struct Queue {
    scans: VecDeque<Job>,
    parts: VecDeque<Job>,
    closed: bool,
}

/// Closes a reading when dropped, aborting what is under way if `.1`.
struct Closing<'r, 's>(&'r Reading<'s>, bool);

impl Drop for Closing<'_, '_> {
    fn drop(&mut self) {
        self.0.close(self.1);
    }
}

/// What the reading threads share.
struct Reading<'s> {
    source: &'s Positional,
    start: u64,
    len: u64,
    range: u64,
    ranges: usize,
    queue: Mutex<Queue>,
    ready: Condvar,
    /// Set when the reading is given up: the jobs under way stop early.
    abort: AtomicBool,
    #[cfg(test)]
    slow_part: Option<(usize, std::time::Duration)>,
    #[cfg(test)]
    panic_part: Option<usize>,
}

/// How many bytes a thread scans at a time (a multiple of 64): what the
/// tokenizer reads at a time.
const SCAN_PIECE: usize = 64 << 10;

/// What a range's split search found.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Split {
    /// Not known yet.
    Unknown,
    /// Being searched.
    Searching,
    /// Its first comma at depth 1, or none.
    Found(Option<u64>),
}

impl Reading<'_> {
    fn push(&self, job: Job) {
        let mut queue = self.queue.lock().unwrap_or_else(|e| e.into_inner());
        match job {
            Job::Tally(..) => queue.parts.push_back(job),
            _ => queue.scans.push_back(job),
        }
        drop(queue);
        self.ready.notify_one();
    }

    /// Stops the threads: no more jobs are taken, and with `abort` those
    /// under way stop early.
    fn close(&self, abort: bool) {
        if abort {
            self.abort.store(true, Ordering::Relaxed);
        }
        self.queue.lock().unwrap_or_else(|e| e.into_inner()).closed = true;
        self.ready.notify_all();
    }

    /// A scan job waiting, if any (for the reading thread, which does no
    /// tallies but its first part's).
    fn take_scan(&self) -> Option<Job> {
        let mut queue = self.queue.lock().unwrap_or_else(|e| e.into_inner());
        if queue.closed {
            return None;
        }
        queue.scans.pop_front()
    }

    fn next_job(&self) -> Option<Job> {
        let mut queue = self.queue.lock().unwrap_or_else(|e| e.into_inner());
        loop {
            if queue.closed {
                return None;
            }
            if let Some(job) = queue.scans.pop_front().or_else(|| queue.parts.pop_front()) {
                return Some(job);
            }
            queue = self.ready.wait(queue).unwrap_or_else(|e| e.into_inner());
        }
    }

    /// A reading thread: does jobs until the reading is closed. A job that
    /// panics is reported, with its payload, to the thread that reads the
    /// sample, which raises it (see [`coordinate`](Self::coordinate)): it
    /// would otherwise wait for the job's result forever.
    fn work(&self, config: CompressedJson, results: &mpsc::Sender<Done>) {
        let mut buffer = vec![0u8; SCAN_PIECE];
        while let Some(job) = self.next_job() {
            let done = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                self.run(job, &config, &mut buffer)
            }));
            let panicked = done.is_err();
            if results.send(done.unwrap_or_else(Done::Panicked)).is_err() || panicked {
                break;
            }
        }
    }

    /// Does `job`, reading as `config` reads.
    fn run(&self, job: Job, config: &CompressedJson, buffer: &mut [u8]) -> Done {
        match job {
            Job::Summarize(k) => Done::Summary(k, self.summarize(k, buffer)),
            Job::Split(k, state) => Done::Split(k, self.split(k, state, buffer)),
            Job::Tally(i, part) => {
                #[cfg(test)]
                if let Some((slow, delay)) = self.slow_part
                    && slow == i
                {
                    thread::sleep(delay);
                }
                #[cfg(test)]
                if self.panic_part == Some(i) {
                    panic!("a part panicked (a test hook)");
                }
                Done::Part(i, self.tally(part, config))
            }
        }
    }

    /// Range `k`: from where to where.
    fn bounds(&self, k: usize) -> (u64, u64) {
        let from = self.start + k as u64 * self.range;
        (from, (from + self.range).min(self.len))
    }

    fn aborted(&self) -> io::Result<()> {
        if self.abort.load(Ordering::Relaxed) {
            return Err(io::Error::other("the parallel reading was given up"));
        }
        Ok(())
    }

    /// Feeds the bytes from `from` to `to` to `f`, a buffer at a time,
    /// until it returns a value.
    fn pieces<T>(
        &self,
        from: u64,
        to: u64,
        buffer: &mut [u8],
        mut f: impl FnMut(u64, &[u8]) -> Option<T>,
    ) -> io::Result<Option<T>> {
        let mut at = from;
        while at < to {
            self.aborted()?;
            let want = usize::try_from(to - at).map_or(buffer.len(), |n| n.min(buffer.len()));
            let n = self.source.read_at(&mut buffer[..want], at)?;
            if n < want {
                return Err(io::ErrorKind::UnexpectedEof.into());
            }
            if let Some(found) = f(at, &buffer[..n]) {
                return Ok(Some(found));
            }
            at += n as u64;
        }
        Ok(None)
    }

    /// Feeds the bytes from `from` to `to` to `f`, block by block (the last
    /// one padded with spaces), until it returns a value.
    fn scan<T>(
        &self,
        from: u64,
        to: u64,
        buffer: &mut [u8],
        mut f: impl FnMut(u64, &[u8; BLOCK]) -> Option<T>,
    ) -> io::Result<Option<T>> {
        self.pieces(from, to, buffer, |at, piece| {
            blocks(piece)
                .enumerate()
                .find_map(|(j, block)| f(at + (j * BLOCK) as u64, &block))
        })
    }

    /// Whether the byte at `at` is escaped, by the run of backslashes just
    /// before it; `None` if the bytes just before it are all backslashes.
    fn escaped_at(&self, at: u64) -> io::Result<Option<bool>> {
        let from = at.saturating_sub(BLOCK as u64).max(self.start);
        let mut before = [0u8; BLOCK];
        let before = &mut before[..usize::try_from(at - from).unwrap_or(0)];
        if self.source.read_at(before, from)? < before.len() {
            return Err(io::ErrorKind::UnexpectedEof.into());
        }
        Ok(escaped_after(before, from == self.start))
    }

    /// Range `k`'s summary: for the case its first byte has, or, where the
    /// bytes just before it do not tell, for both.
    fn summarize(&self, k: usize, buffer: &mut [u8]) -> io::Result<RangeSummary> {
        let (from, to) = self.bounds(k);
        let escaped = self.escaped_at(from)?;
        let mut summarizer = Summarizer::new(escaped.unwrap_or(false));
        let mut escaped_one = escaped.is_none().then(|| Summarizer::new(true));
        // The backslashes the range ends with, so far.
        let mut run = 0;
        self.pieces::<()>(from, to, buffer, |_, piece| {
            let tail = trailing_backslashes(piece);
            run = if tail == piece.len() {
                run + tail
            } else {
                tail
            };
            for block in blocks(piece) {
                summarizer.block(&block);
            }
            if let Some(escaped_one) = &mut escaped_one {
                for block in blocks(piece) {
                    escaped_one.block(&block);
                }
            }
            None
        })?;
        let (len, run) = (to - from, run as u64);
        let summary = summarizer.finish(len, run);
        Ok(match escaped_one {
            Some(escaped_one) => RangeSummary::Either([summary, escaped_one.finish(len, run)]),
            None => RangeSummary::Known(summary),
        })
    }

    fn split(&self, k: usize, mut state: ScanState, buffer: &mut [u8]) -> io::Result<Option<u64>> {
        let (from, to) = self.bounds(k);
        self.scan(from, to, buffer, |offset, block| {
            state.find_split(block).map(|i| offset + i as u64)
        })
    }

    /// Reads `part` as the array of its elements into `running`: its tree,
    /// or `None` if it does not read as the sample's elements there do (or
    /// a read fails), which leaves nothing behind.
    fn read_part(
        &self,
        part: Part,
        running: &mut RunningTallies,
        config: &CompressedJson,
    ) -> Option<NodeId> {
        let end = part.to.unwrap_or(self.len);
        // Before and after a comma comes a value: the part's array must not
        // be empty (its first byte not `]`, and not nothing), unless it is
        // the whole array.
        if !(part.first && part.to.is_none()) {
            match first_byte(self.source, part.from, end) {
                Some((_, b)) if b != b']' => {}
                _ => return None,
            }
        }
        let mut reader = PartReader {
            reading: self,
            open: true,
            at: part.from,
            end,
            close: part.to.is_some(),
        };
        parse_stream_reader_into(
            &mut TallyBuilder::new(running, config),
            &mut reader,
            Framing::Value,
        )
        .ok()
    }

    /// Tallies `part` on this thread, to append elsewhere.
    fn tally(&self, part: Part, config: &CompressedJson) -> Option<PortableTree> {
        let mut running = RunningTallies::new();
        let tree = self.read_part(part, &mut running, config)?;
        let RunningTallies {
            tallies, strings, ..
        } = running;
        PortableTree::new(tallies, strings, tree).ok()
    }

    /// The thread that reads the sample: forms the parts as the summaries
    /// and splits come in, reads the first part itself and has the others
    /// read on the other threads, and appends their trees in order to the
    /// first's.
    ///
    /// The parts being read elsewhere hold trees of their own, which take
    /// as much memory as the tallies of their text: for most samples a
    /// fraction of the text, but as much as all of a sample's tallies for
    /// elements as large as a part with distinct keys or strings. So the
    /// parts given out and not appended yet, while they are read (their
    /// trees estimated by the largest ratio of tree to text seen, and at
    /// least the smallest tree seen) and once read (their trees, waiting
    /// for the parts before them), may hold together at most
    /// [`ParallelOptions::budget`], and there are at most a few per thread.
    /// Where a part's tree alone would take half of the budget, the rest is
    /// read in one go instead, which shares the tallies. The first part,
    /// read here straight into the tallies, is the first estimate. The
    /// ranges are summarized only a few ahead of the next part to give out
    /// (so at most a few parts and ranges ahead of the first part not
    /// appended yet), so that their text is read again while it is still
    /// cached, and where they hold no split for as long as such a part,
    /// not at all: the rest is read in one go.
    fn coordinate(
        &self,
        open: u64,
        running: &mut RunningTallies,
        config: &CompressedJson,
        results: &mpsc::Receiver<Done>,
        plan: Plan,
    ) -> Option<Outcome> {
        let Plan {
            threads,
            budget,
            fault,
            ..
        } = plan;
        let n = self.ranges;
        let mut summaries: Vec<Option<RangeSummary>> = vec![None; n];
        let mut splits = vec![Split::Unknown; n];
        // The state at the start of the first range not resolved yet.
        let (mut resolved, mut state) = (0, ScanState::default());
        // The first range whose split is not known yet, and the last
        // split before it (the array's `[` at first).
        let (mut formed, mut last_split) = (0, open);
        let mut summarized = 0;
        let mut parts: Vec<Part> = Vec::new();
        let mut all_formed = false;
        // Parts given to other threads (the first is read here), and
        // appended; the trees waiting to be, and the bytes each part given
        // out holds until it is appended (estimated while it is read).
        let (mut dispatched, mut appended) = (1, 0);
        let mut waiting: BTreeMap<usize, PortableTree> = BTreeMap::new();
        let mut held: BTreeMap<usize, u64> = BTreeMap::new();
        // The largest ratio of tree to text seen (of parts long enough), and
        // the smallest tree.
        let mut ratio: f64 = 1.0;
        let mut smallest = 0u64;
        let parts_ahead = 2 * threads + 2;
        #[cfg(test)]
        {
            HELD.with(|h| h.set((0, 0)));
            AHEAD.with(|a| a.set(0));
        }
        let mut root: Option<NodeId> = None;
        let mut buffer = vec![0u8; SCAN_PIECE];
        // Jobs given out and not done yet.
        let mut pending = 0usize;
        let part_len = |part: &Part| part.to.unwrap_or(self.len) - part.from;
        // The tree so far and where the parts not appended yet begin, to
        // read the rest in one go (or none, and the tree freed).
        let rest =
            |running: &mut RunningTallies, root: Option<NodeId>, parts: &[Part], appended| {
                let from = parts[..appended].last().and_then(|p| p.to);
                match (root, from) {
                    (Some(root), Some(comma)) => Some(Outcome::InPart(root, comma + 1)),
                    (Some(root), None) => {
                        running.tallies.free_tree(root);
                        None
                    }
                    (None, _) => None,
                }
            };
        loop {
            let before = (summarized, resolved, formed, parts.len(), dispatched);
            // Summaries a few ranges past those formed into parts; while
            // parts wait to be given out (whose number the budget bounds),
            // not much past the next; and not past where a stretch without
            // a split ends the reading (below).
            let limit = parts
                .get(dispatched)
                .map_or(u64::MAX, |next| {
                    next.from.saturating_add(parts_ahead as u64 * self.range)
                })
                .min(
                    last_split.saturating_add((budget as f64 / (2.0 * ratio)) as u64 + self.range),
                );
            while summarized < n
                && summarized < formed + 2 * threads + 2
                && self.bounds(summarized).0 < limit
            {
                #[cfg(test)]
                SCANNED.with(|s| {
                    let (from, to) = self.bounds(summarized);
                    s.set(if summarized == 0 { 0 } else { s.get() } + (to - from));
                });
                self.push(Job::Summarize(summarized));
                pending += 1;
                summarized += 1;
            }
            // Resolve the states in order, and search the ranges that may
            // split.
            while resolved < n {
                // (Whether the range's first byte is escaped, the state
                // says, from the ranges before it.)
                let Some(summary) = summaries[resolved].map(|s| s.given(state.escaped)) else {
                    break;
                };
                if state.may_split(&summary) {
                    splits[resolved] = Split::Searching;
                    self.push(Job::Split(resolved, state));
                    pending += 1;
                } else {
                    splits[resolved] = Split::Found(None);
                }
                state = state.after(&summary);
                resolved += 1;
            }
            // Form the parts in order, between consecutive splits.
            while formed < n {
                let Split::Found(found) = splits[formed] else {
                    break;
                };
                if let Some(comma) = found {
                    parts.push(Part {
                        from: last_split + 1,
                        to: Some(comma),
                        first: parts.is_empty(),
                    });
                    last_split = comma;
                }
                formed += 1;
            }
            if formed == n && !all_formed {
                parts.push(Part {
                    from: last_split + 1,
                    to: None,
                    first: parts.is_empty(),
                });
                all_formed = true;
            }
            // A stretch without a split as long as a part the budget would
            // not read beside others (below): the part there will be read
            // in one go anyway, so the rest is, without scanning on (a
            // whole sample whose first element is that long).
            let scanned = if formed < n {
                self.bounds(formed).0
            } else {
                self.len
            };
            let stretch = scanned.saturating_sub(last_split) as f64;
            if !all_formed && stretch * ratio * 2.0 > budget as f64 {
                if parts.is_empty() {
                    return None;
                }
                if appended == parts.len() {
                    return rest(running, root, &parts, appended);
                }
            }
            // The first part, here.
            if appended == 0 && !parts.is_empty() {
                let part = parts[0];
                let first = self.read_part(part, running, config)?;
                root = Some(first);
                if part_len(&part) >= PROBE_LEN {
                    // As a part read elsewhere would hold it.
                    let size = running.tallies.portable_size(&running.strings, first);
                    let Ok(size) = size else {
                        return rest(running, root, &parts, 1);
                    };
                    ratio = ratio.max(size as f64 / part_len(&part) as f64);
                }
                appended = 1;
            }
            // The others, elsewhere, as the budget allows.
            while appended > 0 && dispatched < parts.len() && dispatched < appended + parts_ahead {
                let estimate = ((ratio * part_len(&parts[dispatched]) as f64) as u64).max(smallest);
                if estimate.saturating_mul(2) > budget {
                    // Too large to read beside others: the rest in one go,
                    // once the parts before it are appended.
                    if appended == dispatched {
                        return rest(running, root, &parts, appended);
                    }
                    break;
                }
                if held.values().sum::<u64>() + estimate > budget && !held.is_empty() {
                    break;
                }
                self.push(Job::Tally(dispatched, parts[dispatched]));
                held.insert(dispatched, estimate);
                pending += 1;
                dispatched += 1;
                #[cfg(test)]
                AHEAD.with(|a| a.set(a.get().max(dispatched - appended)));
            }
            if all_formed && appended == parts.len() {
                return root.map(Outcome::Whole);
            }
            // Each step may let another one go on.
            if (summarized, resolved, formed, parts.len(), dispatched) != before {
                continue;
            }
            if pending == 0 {
                debug_assert!(false, "the parallel reading has nothing to wait for");
                return rest(running, root, &parts, appended);
            }
            pending -= 1;
            // While no result is in, this thread scans too.
            let done = match results.try_recv() {
                Err(mpsc::TryRecvError::Empty) => match self.take_scan() {
                    Some(job) => Ok(self.run(job, config, &mut buffer)),
                    None => results.recv().map_err(|_| ()),
                },
                done => done.map_err(|_| ()),
            };
            match done {
                Ok(Done::Summary(k, Ok(summary))) => summaries[k] = Some(summary),
                Ok(Done::Split(k, Ok(found))) => splits[k] = Split::Found(found),
                Ok(Done::Part(i, Some(tree))) => {
                    // The tree holds its bytes until it is appended.
                    let bytes = tree.heap_size() as u64;
                    held.insert(i, bytes);
                    smallest = if smallest == 0 {
                        bytes
                    } else {
                        smallest.min(bytes)
                    };
                    if part_len(&parts[i]) >= PROBE_LEN {
                        ratio = ratio.max(bytes as f64 / part_len(&parts[i]) as f64);
                    }
                    waiting.insert(i, tree);
                    // What the trees waiting hold, and the parts under way.
                    #[cfg(test)]
                    HELD.with(|h| {
                        let parked: u64 = waiting.values().map(|t| t.heap_size() as u64).sum();
                        let under_way: u64 = held
                            .iter()
                            .filter(|(k, _)| !waiting.contains_key(k))
                            .map(|(_, b)| b)
                            .sum();
                        let (peak, largest) = h.get();
                        h.set((peak.max(parked + under_way), largest.max(bytes)));
                    });
                    // Append the trees in order.
                    while let Some(tree) = waiting.remove(&appended) {
                        let so_far = root?;
                        let imported = match running.tallies.import(&mut running.strings, tree) {
                            Ok(imported) => imported,
                            Err(_) => return rest(running, Some(so_far), &parts, appended),
                        };
                        // (The fault merges the tree so far into this one.)
                        let (into, from) = match fault {
                            Some(Fault::Prepend) => (imported, so_far),
                            None => (so_far, imported),
                        };
                        // A failed merge changes nothing, and frees what it
                        // was given.
                        if running.tallies.merge(into, from).is_err() {
                            return rest(running, Some(into), &parts, appended);
                        }
                        root = Some(into);
                        held.remove(&appended);
                        appended += 1;
                    }
                }
                // A job that panicked panics here, as reading in one go
                // would (the threads stop as the reading closes).
                Ok(Done::Panicked(payload)) => std::panic::resume_unwind(payload),
                // A part that did not read as the sample's elements, a read
                // that failed, or the threads gone: the rest in one go.
                _ => return rest(running, root, &parts, appended),
            }
        }
    }
}

/// A part's bytes as the array of its elements: `[`, the part, and `]`
/// unless the part runs to the end of the sample (where the array's own
/// `]` is). Reading stops early when the reading is given up.
struct PartReader<'r, 's> {
    reading: &'r Reading<'s>,
    /// Whether the `[` is still to be read.
    open: bool,
    at: u64,
    end: u64,
    /// Whether a `]` is to be read after the part.
    close: bool,
}

impl Read for PartReader<'_, '_> {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        self.reading.aborted()?;
        let mut n = 0;
        if self.open && !buf.is_empty() {
            buf[0] = b'[';
            self.open = false;
            n = 1;
        }
        if self.at < self.end && n < buf.len() {
            let want =
                usize::try_from(self.end - self.at).map_or(buf.len() - n, |r| r.min(buf.len() - n));
            let read = self
                .reading
                .source
                .read_at(&mut buf[n..n + want], self.at)?;
            if read < want {
                return Err(io::ErrorKind::UnexpectedEof.into());
            }
            self.at += read as u64;
            n += read;
        }
        if self.at == self.end && self.close && n < buf.len() {
            buf[n] = b']';
            self.close = false;
            n += 1;
        }
        Ok(n)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;
    use crate::input::compressed_json_from_stream::parse_stream_into;
    use crate::input::json_split::tests::{Rng, random_json};

    fn config(handle_refs: bool) -> CompressedJson {
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs)
    }

    /// The tree of reading `bytes` in one go, or its error.
    fn in_one_go(config: &CompressedJson, bytes: &[u8]) -> Result<String, String> {
        let mut tallies = RunningTallies::new();
        let tree = parse_stream_into(
            &mut TallyBuilder::new(&mut tallies, config),
            bytes,
            Framing::Value,
        );
        tree.map(|tree| tallies.dump(tree))
            .map_err(|e| e.message().to_owned())
    }

    /// The tree (or error) of reading `bytes` as a positional sample with
    /// `options`, and how it was read.
    fn read_with(
        config: &CompressedJson,
        bytes: &[u8],
        options: ParallelOptions,
    ) -> (Result<String, String>, ParallelReads) {
        let before = parallel_reads();
        let mut tallies = RunningTallies::new();
        let sample = PositionalSample::memory(bytes.to_vec(), options);
        let result = read_sample(sample, &mut tallies, config)
            .map(|tree| {
                let dump = tallies.dump(tree);
                tallies.tallies.free_tree(tree);
                dump
            })
            .map_err(|e| e.message().to_owned());
        assert_eq!(tallies.tallies.live_nodes(), 0, "only the sample's tree");
        let after = parallel_reads();
        let how = ParallelReads {
            whole: after.whole - before.whole,
            in_part: after.in_part - before.in_part,
            again: after.again - before.again,
        };
        (result, how)
    }

    fn options(threads: usize, range: usize) -> ParallelOptions {
        ParallelOptions {
            threads,
            range,
            min_len: 0,
            budget: None,
            fault: None,
        }
    }

    /// A sample read on several threads reads as in one go, its tree or its
    /// error, for any range size and number of threads: whole, in part
    /// (the rest in one go after a part that does not read as the
    /// sample's elements), or again from the start.
    #[test]
    fn reading_in_parallel_is_reading_in_one_go() {
        let mut rng = Rng(4242);
        let config = config(true);
        let mut total = ParallelReads::default();
        for round in 0..400 {
            let mut bytes = random_json(&mut rng, 1 + round % 60);
            // Sometimes broken: cut, with something after it, or a value
            // replaced by something that is not one.
            match round % 8 {
                5 => bytes.truncate(rng.below(bytes.len())),
                6 => bytes.extend_from_slice(b" [1]"),
                7 => {
                    if let Some(at) = bytes.iter().rposition(|&b| b == b'3') {
                        bytes[at] = b'x';
                    }
                }
                _ => {}
            }
            let expected = in_one_go(&config, &bytes);
            for _ in 0..4 {
                let options = options(2 + rng.below(4), 1 + rng.below(200));
                let (result, how) = read_with(&config, &bytes, options);
                assert_eq!(
                    result,
                    expected,
                    "{options:?} {:?}",
                    String::from_utf8_lossy(&bytes)
                );
                total.whole += how.whole;
                total.in_part += how.in_part;
                total.again += how.again;
            }
        }
        assert!(total.whole > 500 && total.in_part > 100, "{total:?}");
    }

    /// Splits at every point between elements: strings with brackets,
    /// commas and escaped quotes across the ranges, nested values, empty
    /// arrays, whitespace.
    #[test]
    fn every_split_point() {
        let config = config(false);
        let documents: [&[u8]; 7] = [
            br#"[1,"a,]","b\"],[",{"c":[1,2,{"d":"]}"}]},[],{},null,true,-1.5e3,"\\",["x",["y"]]]"#,
            b" \n[ 1 , 2 ,\t3\r\n, \"x\" ] \n ",
            br##"[{"a":1},{"a":"x","b":[1,{"__proto__":2}]},{"$ref":"#/a"}]"##,
            b"[[],[[]],[[],[]]]",
            b"[\"\\u00e9\\ud83d\\ude00\", \"caf\xc3\xa9\", \"2020-01-01\", \"http://h/x.png\"]",
            b"[\"\\\\\\\"\",\"\\\\\",\"\\\"\"]",
            // Places whose strings come to absorb every string partway,
            // across parts: cases, then a string of more than 64 units,
            // then cases, URIs and dates again.
            br#"[{"s":"a","t":["b"]},{"s":"c"},{"s":"long text long text long text long text long text long text long text","t":["d"]},{"s":"e","t":["long text long text long text long text long text long text long text","f"]},{"s":"https://h/x.png"},{"s":"g","t":["2020-01-01","h"]}]"#,
        ];
        for bytes in documents {
            let expected = in_one_go(&config, bytes);
            assert!(expected.is_ok());
            for range in 1..bytes.len() {
                for threads in [2, 3] {
                    let (result, how) = read_with(&config, bytes, options(threads, range));
                    assert_eq!(
                        result,
                        expected,
                        "{range} {:?}",
                        String::from_utf8_lossy(bytes)
                    );
                    assert_eq!(how.whole, 1, "{range} {:?}", String::from_utf8_lossy(bytes));
                }
            }
        }
    }

    /// Whatever the error and wherever it is (in the first part, the last,
    /// one between, at a part's end), the error is the one reading in one
    /// go reports; so is the tree of what is not a broken array.
    #[test]
    fn errors_are_those_of_reading_in_one_go() {
        let config = config(false);
        let documents: [&[u8]; 22] = [
            b"[1,2,3,]",
            b"[,1,2,3]",
            b"[1,,2,3]",
            b"[1,2 3,4]",
            b"[1,2,3",
            b"[1,2,3,",
            b"[1,2,3] x",
            b"[1,2,3][4,5,6]",
            b"[1,2,3] [4,5,6] ",
            b"[1,\"2,3]",
            b"[1,\"\\x\",3]",
            b"[1,\"\x01\",3]",
            b"[1,{\"a\":1,},3]",
            b"[1,tru,3]",
            b"[1,2,3]]",
            b"\xef\xbb\xbf[1,2,3]",
            b"[1,\"\xe2\x82,\",2]",
            b"[1,\xff,2]",
            b"[[1,2],[3,4]",
            b"[{\"a\":[1,2]},{\"b\":[3,}]",
            b"[1,2,3]\n\n  \t",
            b"[]",
        ];
        let mut total = ParallelReads::default();
        for bytes in documents {
            let expected = in_one_go(&config, bytes);
            for range in 1..bytes.len() {
                for threads in [2, 4] {
                    let (result, how) = read_with(&config, bytes, options(threads, range));
                    assert_eq!(
                        result,
                        expected,
                        "{range} {:?}",
                        String::from_utf8_lossy(bytes)
                    );
                    total.whole += how.whole;
                    total.in_part += how.in_part;
                    total.again += how.again;
                }
            }
        }
        // Every way: the broken arrays fail in the first part (read again
        // from the start), or in a later one (the rest in one go).
        assert!(
            total.whole > 0 && total.in_part > 100 && total.again > 10,
            "{total:?}"
        );
        // Not arrays: read in one go.
        for bytes in [&b"{\"a\":[1,2,3]}"[..], b"\"[1,2]\"", b"   ", b"", b"1 2"] {
            let (result, how) = read_with(&config, bytes, options(2, 1));
            assert_eq!(result, in_one_go(&config, bytes));
            assert_eq!(how, ParallelReads::default());
        }
    }

    /// An array whose elements are all longer than a part the budget would
    /// read beside others is read in one go, after scanning as much (not
    /// all of it, as a single element has no split).
    #[test]
    fn long_elements_are_read_in_one_go_without_scanning_on() {
        let config = config(false);
        let element = format!("{{\"a\":[{}]}}", vec!["1"; 50_000].join(","));
        let bytes = format!("[{element},{element},{element}]");
        let expected = in_one_go(&config, bytes.as_bytes());
        let mut options = options(3, 1_000);
        options.budget = Some(64 << 10);
        let (result, how) = read_with(&config, bytes.as_bytes(), options);
        assert_eq!(result, expected);
        assert_eq!(how.again, 1, "{how:?}");
        let scanned = SCANNED.with(Cell::get);
        assert!(
            scanned < 200_000,
            "{scanned} of {} bytes scanned",
            bytes.len()
        );
        // With a first element as short as a part, the rest goes on in
        // one go from the first long one.
        let short = format!("[{{\"b\":1}},{element},{element}]");
        let (result, how) = read_with(&config, short.as_bytes(), options);
        assert_eq!(result, in_one_go(&config, short.as_bytes()));
        assert_eq!(how.in_part, 1, "{how:?}");
    }

    /// Where the parts' trees would take too much memory beside each
    /// other, the rest is read in one go into the first part's tree: here
    /// a first element with many distinct keys, as large as the budget.
    #[test]
    fn large_trees_are_read_on_in_one_go() {
        let config = config(false);
        let keys: Vec<String> = (0..20_000).map(|i| format!("\"key{i}\":{i}")).collect();
        let element = format!("{{{}}}", keys.join(","));
        let bytes = format!("[{element},{element},{element},{{\"x\":[1]}}]");
        let expected = in_one_go(&config, bytes.as_bytes());
        // The default budget is far more than these trees take: the parts
        // are read elsewhere.
        let (result, how) = read_with(&config, bytes.as_bytes(), options(3, 1000));
        assert_eq!(result, expected);
        assert_eq!(how.whole, 1);
        // Where it allows only one of these parts at a time, the rest is
        // read in one go.
        let mut options = options(3, 1000);
        options.budget = Some(4 << 20);
        let (result, how) = read_with(&config, bytes.as_bytes(), options);
        assert_eq!(result, expected);
        assert_eq!(how.in_part, 1, "{how:?}");
    }

    /// A part read slowly does not let the others' trees pile up behind it:
    /// the parts given out and not appended yet (their trees, once read)
    /// hold at most the budget, but for one part over it.
    #[test]
    fn trees_waiting_for_a_slow_part_stay_within_the_budget() {
        let config = config(false);
        // Parts of distinct keys and strings, whose trees take 64 KiB and
        // more each (the first block of their string tables).
        let elements: Vec<String> = (0..600)
            .map(|i| format!(r#"{{"k{i}":"v{i}","n":{i}}}"#))
            .collect();
        let bytes = format!("[{}]", elements.join(","));
        let mut options = options(4, 200);
        options.budget = Some(1 << 20);
        // The second part, the first read elsewhere, is read last.
        SLOW_PART.with(|s| s.set(Some((1, std::time::Duration::from_millis(300)))));
        let (result, how) = read_with(&config, bytes.as_bytes(), options);
        SLOW_PART.with(|s| s.set(None));
        assert_eq!(result, in_one_go(&config, bytes.as_bytes()));
        assert_eq!(how.whole, 1);
        let (peak, largest) = HELD.with(Cell::get);
        assert!(largest >= 64 << 10, "{largest}");
        let budget = options.budget.unwrap();
        assert!(
            peak <= budget + largest,
            "{peak} bytes held, over {budget} + {largest}"
        );
    }

    /// Parts longer than the ranges summarized ahead of the next part to
    /// give out are still read beside each other: behind a part read
    /// slowly, the parts after it are given out as the budget allows (with
    /// the ranges summarized ahead of the first part not appended, they
    /// were read one at a time).
    #[test]
    fn long_parts_are_read_beside_each_other() {
        let config = config(false);
        // Elements of 2 KB, ranges of 64 bytes: 6 ranges (2 x 2 + 2) are
        // less than a part.
        let elements: Vec<String> = (0..12)
            .map(|i| format!(r#"{{"text":"{}","n":{i}}}"#, "x".repeat(2000)))
            .collect();
        let bytes = format!("[{}]", elements.join(","));
        SLOW_PART.with(|s| s.set(Some((1, std::time::Duration::from_millis(200)))));
        let (result, how) = read_with(&config, bytes.as_bytes(), options(2, 64));
        SLOW_PART.with(|s| s.set(None));
        assert_eq!(result, in_one_go(&config, bytes.as_bytes()));
        assert_eq!(how.whole, 1);
        let ahead = AHEAD.with(Cell::get);
        assert!(ahead >= 4, "{ahead} parts given out at once");
    }

    /// Ranges in long runs of backslashes, whose first byte's escape only
    /// the ranges before them tell, are read whole on several threads, as
    /// in one go.
    #[test]
    fn runs_of_backslashes_are_read_as_in_one_go() {
        let config = config(false);
        let run = |n: usize| "\\".repeat(n);
        let bytes = format!(
            r#"[{{"a":"{}"}},{{"a":"{}\""}},"{}",{{"b":1}},"{}x"]"#,
            run(2_500),
            run(1_500),
            run(3_000),
            run(64),
        );
        let expected = in_one_go(&config, bytes.as_bytes());
        assert!(expected.is_ok(), "{expected:?}");
        for range in [1, 2, 3, 63, 64, 65, 100, 777, 2_048, 4_999] {
            for threads in [2, 3] {
                let (result, how) = read_with(&config, bytes.as_bytes(), options(threads, range));
                assert_eq!(result, expected, "ranges of {range}, {threads} threads");
                assert_eq!(how.whole, 1, "ranges of {range}, {threads} threads");
            }
        }
    }

    /// A reading thread that panics makes the reading panic with its
    /// payload, as reading in one go would, rather than wait for its part
    /// forever.
    #[test]
    fn a_panic_on_a_reading_thread_is_raised_here() {
        let (sender, receiver) = mpsc::channel();
        thread::spawn(move || {
            let config = config(false);
            let elements: Vec<String> = (0..200).map(|i| format!(r#"{{"a":{i}}}"#)).collect();
            let bytes = format!("[{}]", elements.join(","));
            PANIC_PART.with(|p| p.set(Some(2)));
            let read = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                read_with(&config, bytes.as_bytes(), options(3, 64))
            }));
            let payload = read
                .err()
                .map(|e| e.downcast_ref::<&str>().map(|s| s.to_string()));
            let _ = sender.send(payload);
        });
        let payload = receiver
            .recv_timeout(std::time::Duration::from_secs(60))
            .expect("the reading ends");
        assert_eq!(
            payload,
            Some(Some("a part panicked (a test hook)".to_owned()))
        );
    }

    /// The threads that read are as many as the ranges give
    /// PARTS_PER_THREAD each, at most MAX_THREADS whatever the options ask
    /// for, and the default budget is theirs.
    #[test]
    fn threads_are_as_many_as_the_ranges_keep_busy() {
        let plan = |threads, range, budget, size| {
            let options = ParallelOptions {
                threads,
                range,
                min_len: DEFAULT_MIN_LEN,
                budget,
                fault: None,
            };
            Plan::new(options, size).map(|p| (p.range, p.ranges, p.threads, p.budget))
        };
        const MIB: u64 = 1 << 20;
        // 8 MiB on 128 threads: ranges of 256 KiB, 32 of them, 8 threads.
        assert_eq!(
            plan(128, DEFAULT_RANGE, None, 8 * MIB),
            Some((256 << 10, 32, 8, TREE_BUDGET))
        );
        // 1 GiB on 128 threads: ranges of 2 MiB, all 128 threads.
        assert_eq!(
            plan(128, DEFAULT_RANGE, None, 1024 * MIB),
            Some((2 * MIB, 512, 128, 256 * MIB))
        );
        // 64 GiB, as many threads as can be asked for: MAX_THREADS.
        assert_eq!(
            plan(usize::MAX, DEFAULT_RANGE, None, 64 << 30),
            Some((4 * MIB, 16_384, MAX_THREADS, MAX_THREADS as u64 * 4 * MIB))
        );
        // The budget asked for is kept; under the threshold, in one go.
        assert_eq!(
            plan(12, DEFAULT_RANGE, Some(7), 267 * MIB).map(|p| p.3),
            Some(7)
        );
        assert_eq!(plan(12, DEFAULT_RANGE, None, 8 * MIB - 1), None);
        assert_eq!(plan(1, DEFAULT_RANGE, None, 267 * MIB), None);
        // A small sample with tiny ranges, on many threads: read as in one
        // go.
        let config = config(false);
        let elements: Vec<String> = (0..400).map(|i| format!(r#"{{"a":{i}}}"#)).collect();
        let bytes = format!("[{}]", elements.join(","));
        let expected = in_one_go(&config, bytes.as_bytes());
        for (threads, range) in [(64, 256), (usize::MAX, 64), (usize::MAX, 1)] {
            let (result, how) = read_with(&config, bytes.as_bytes(), options(threads, range));
            assert_eq!(result, expected, "{threads} threads, ranges of {range}");
            assert_eq!(how.whole, 1, "{threads} threads, ranges of {range}");
        }
    }

    /// Where the system refuses a reading thread, the sample is read in one
    /// go (and the threads started stop).
    #[test]
    fn a_thread_that_does_not_start_reads_in_one_go() {
        let config = config(false);
        let bytes = br#"[{"a":1},{"b":"x"},{"a":2.5},{"c":null},[1,2],"s"]"#;
        let expected = in_one_go(&config, bytes);
        for failing in [0, 1, 3] {
            SPAWN_FAILS.with(|f| f.set(Some(failing)));
            let (result, how) = read_with(&config, bytes, options(4, 4));
            SPAWN_FAILS.with(|f| f.set(None));
            assert_eq!(result, expected, "thread {failing}");
            let again = ParallelReads {
                again: 1,
                ..ParallelReads::default()
            };
            assert_eq!(how, again, "thread {failing}");
        }
        assert_eq!(read_with(&config, bytes, options(4, 4)).1.whole, 1);
    }

    /// The fault is caught: merging the parts' trees out of order gives
    /// another tree.
    #[test]
    fn merging_out_of_order_is_caught() {
        let config = config(false);
        let bytes = br#"[{"z":0},{"a":1},{"b":"x"},{"c":null}]"#;
        let mut options = options(2, 1);
        let expected = in_one_go(&config, bytes);
        assert_eq!(read_with(&config, bytes, options).0, expected);
        options.fault = Some(Fault::Prepend);
        assert_ne!(read_with(&config, bytes, options).0, expected);
    }
}
