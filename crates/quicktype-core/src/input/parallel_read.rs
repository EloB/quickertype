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
use super::json_split::{BLOCK, ScanState, Summarizer, Summary, blocks, escaped_after};
use super::tallies::{NodeId, PortableTree, RunningTallies, TallyBuilder};
use crate::date_time::DateTimeRecognizer;
use crate::input::io::node_io::stream_read_error;

/// The bytes of a sample that can be read at any offset, from several
/// threads at once.
pub(crate) enum Positional {
    /// A regular file.
    #[cfg(all(unix, feature = "fs"))]
    File(std::fs::File),
    /// Bytes in memory (for tests and fuzzing).
    Memory(Vec<u8>),
}

impl Positional {
    fn len(&self) -> io::Result<u64> {
        match self {
            #[cfg(all(unix, feature = "fs"))]
            Positional::File(file) => Ok(file.metadata()?.len()),
            Positional::Memory(bytes) => Ok(bytes.len() as u64),
        }
    }

    /// Reads into `buf` from `offset`: all of it, or up to the end.
    fn read_at(&self, mut buf: &mut [u8], mut offset: u64) -> io::Result<usize> {
        let mut total = 0;
        while !buf.is_empty() {
            let n = match self {
                #[cfg(all(unix, feature = "fs"))]
                Positional::File(file) => {
                    match std::os::unix::fs::FileExt::read_at(file, buf, offset) {
                        Ok(n) => n,
                        Err(e) if e.kind() == io::ErrorKind::Interrupted => continue,
                        Err(e) => return Err(e),
                    }
                }
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
    #[cfg(all(unix, feature = "fs"))]
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
        #[cfg(all(unix, feature = "fs"))]
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
            #[cfg(all(unix, feature = "fs"))]
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
    /// The threads that read; with fewer than two, the sample is read in
    /// one go.
    pub threads: usize,
    /// The largest size of the ranges the sample is cut into, in bytes; a
    /// part between two splits is about this long. Ranges are smaller for
    /// samples that would not give each thread [`PARTS_PER_THREAD`] of
    /// them, down to [`MIN_RANGE`].
    pub range: usize,
    /// Samples shorter than this (in bytes) are read in one go.
    pub min_len: u64,
    /// How many bytes the trees of the parts being read on other threads
    /// may take together (see [`Reading::coordinate`]).
    pub budget: u64,
    /// A fault to inject, to check that the checks catch it (for tests).
    #[doc(hidden)]
    pub fault: Option<Fault>,
}

/// A fault [`ParallelOptions::fault`] injects.
#[doc(hidden)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Fault {
    /// Reads the first two parts read on other threads each with the
    /// other's text, which appends their trees the wrong way round.
    SwapParts,
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
/// threads times the range size.
pub const TREE_BUDGET: u64 = 32 << 20;

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
                budget: number("QUICKTYPE_READ_BUDGET").map_or_else(
                    || {
                        (threads as u64)
                            .saturating_mul(range as u64)
                            .max(TREE_BUDGET)
                    },
                    |budget| budget as u64,
                ),
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
    let size = len.checked_sub(sample.start)?;
    let share = size / (options.threads * PARTS_PER_THREAD) as u64;
    let range = (options.range as u64)
        .min(share.max(MIN_RANGE as u64))
        .max(1);
    if size < options.min_len || size <= range {
        return None;
    }
    let configs = (0..options.threads)
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
        range,
        ranges: usize::try_from(size.div_ceil(range)).ok()?,
        queue: Mutex::new(Queue::default()),
        ready: Condvar::new(),
        abort: AtomicBool::new(false),
    };
    let outcome = thread::scope(|scope| {
        let (sender, results) = mpsc::channel();
        for config in configs {
            let (reading, sender) = (&reading, sender.clone());
            scope.spawn(move || reading.work(config.into_compressed_json(), &sender));
        }
        drop(sender);
        // The threads stop when the reading ends, however it ends (were
        // this thread to panic, the scope would wait for them).
        let mut close = Closing(&reading, true);
        let outcome = reading.coordinate(open, tallies, config, &results, options);
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
    Summary(usize, io::Result<Summary>),
    Split(usize, io::Result<Option<u64>>),
    /// A part's tree, or `None` if it did not read as the sample's
    /// elements there do.
    Part(usize, Option<PortableTree>),
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

    /// A reading thread: does jobs until the reading is closed.
    fn work(&self, config: CompressedJson, results: &mpsc::Sender<Done>) {
        let mut buffer = vec![0u8; SCAN_PIECE];
        while let Some(job) = self.next_job() {
            if results.send(self.run(job, &config, &mut buffer)).is_err() {
                break;
            }
        }
    }

    /// Does `job`, reading as `config` reads.
    fn run(&self, job: Job, config: &CompressedJson, buffer: &mut [u8]) -> Done {
        match job {
            Job::Summarize(k) => Done::Summary(k, self.summarize(k, buffer)),
            Job::Split(k, state) => Done::Split(k, self.split(k, state, buffer)),
            Job::Tally(i, part) => Done::Part(i, self.tally(part, config)),
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

    /// Feeds the bytes from `from` to `to` to `f`, block by block (the last
    /// one padded with spaces), until it returns a value.
    fn scan<T>(
        &self,
        from: u64,
        to: u64,
        buffer: &mut [u8],
        mut f: impl FnMut(u64, &[u8; BLOCK]) -> Option<T>,
    ) -> io::Result<Option<T>> {
        let mut at = from;
        while at < to {
            self.aborted()?;
            let want = usize::try_from(to - at).map_or(buffer.len(), |n| n.min(buffer.len()));
            let n = self.source.read_at(&mut buffer[..want], at)?;
            if n < want {
                return Err(io::ErrorKind::UnexpectedEof.into());
            }
            for (j, block) in blocks(&buffer[..n]).enumerate() {
                if let Some(found) = f(at + (j * BLOCK) as u64, &block) {
                    return Ok(Some(found));
                }
            }
            at += n as u64;
        }
        Ok(None)
    }

    /// Whether the byte at `at` is escaped: by the run of backslashes
    /// before it, if any.
    fn escaped_at(&self, at: u64) -> io::Result<bool> {
        let mut back = 64;
        loop {
            let from = at.saturating_sub(back).max(self.start);
            let mut before = vec![0u8; usize::try_from(at - from).unwrap_or(0)];
            if self.source.read_at(&mut before, from)? < before.len() {
                return Err(io::ErrorKind::UnexpectedEof.into());
            }
            if let Some(escaped) = escaped_after(&before, from == self.start) {
                return Ok(escaped);
            }
            back *= 16;
        }
    }

    fn summarize(&self, k: usize, buffer: &mut [u8]) -> io::Result<Summary> {
        let (from, to) = self.bounds(k);
        let mut summarizer = Summarizer::new(self.escaped_at(from)?);
        self.scan::<()>(from, to, buffer, |_, block| {
            summarizer.block(block);
            None
        })?;
        Ok(summarizer.finish())
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
        PortableTree::new(&tallies, strings, tree).ok()
    }

    /// The thread that reads the sample: forms the parts as the summaries
    /// and splits come in, reads the first part itself and has the others
    /// read on the other threads, and appends their trees in order to the
    /// first's.
    ///
    /// The parts being read elsewhere hold trees of their own, which take
    /// as much memory as the tallies of their text: for most samples a
    /// fraction of the text, but as much as all of a sample's tallies for
    /// elements as large as a part with distinct keys or strings. So these
    /// trees, estimated by the largest ratio of tree to text seen, may take
    /// together at most [`ParallelOptions::budget`]. Where a part's alone
    /// would take half of that, the rest is read in one go instead, which
    /// shares the tallies. The first part, read here straight into the
    /// tallies, is the first estimate. The ranges are summarized a few
    /// ahead of the parts given out, so that their text is read again
    /// while it is still cached.
    fn coordinate(
        &self,
        open: u64,
        running: &mut RunningTallies,
        config: &CompressedJson,
        results: &mpsc::Receiver<Done>,
        options: ParallelOptions,
    ) -> Option<Outcome> {
        let threads = options.threads;
        let n = self.ranges;
        let budget = options.budget;
        let mut summaries: Vec<Option<Summary>> = vec![None; n];
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
        // appended; the trees waiting to be, and the estimated bytes of
        // those under way.
        let (mut dispatched, mut appended) = (1, 0);
        let mut waiting: BTreeMap<usize, PortableTree> = BTreeMap::new();
        let mut estimates: BTreeMap<usize, u64> = BTreeMap::new();
        // The largest ratio of tree to text seen (of parts long enough).
        let mut ratio: f64 = 1.0;
        let mut root: Option<NodeId> = None;
        let mut buffer = vec![0u8; SCAN_PIECE];
        // Whether the fault swapped the first parts given out.
        let mut swapped = false;
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
            // Summaries a few ranges past those formed into parts, and
            // while parts wait to be given out, not much past the next
            // (unless the fault holds it back until the one after forms).
            let held = options.fault == Some(Fault::SwapParts)
                && dispatched == 1
                && parts.len() <= 2
                && !all_formed;
            let limit = match parts.get(dispatched) {
                Some(next) if !held => next
                    .from
                    .saturating_add((2 * threads + 2) as u64 * self.range),
                _ => u64::MAX,
            };
            while summarized < n
                && summarized < formed + 2 * threads + 2
                && self.bounds(summarized).0 < limit
            {
                self.push(Job::Summarize(summarized));
                pending += 1;
                summarized += 1;
            }
            // Resolve the states in order, and search the ranges that may
            // split.
            while resolved < n {
                let Some(summary) = summaries[resolved] else {
                    break;
                };
                state.escaped = summary.escaped_in;
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
            // The first part, here.
            if appended == 0 && !parts.is_empty() {
                let part = parts[0];
                let before = running.tallies.heap_size() + running.strings.heap_size();
                root = Some(self.read_part(part, running, config)?);
                let after = running.tallies.heap_size() + running.strings.heap_size();
                if part_len(&part) >= PROBE_LEN {
                    ratio = after.saturating_sub(before) as f64 / part_len(&part) as f64;
                }
                appended = 1;
            }
            // The others, elsewhere, as the budget allows.
            while appended > 0 && dispatched < parts.len() {
                let estimate = (ratio * part_len(&parts[dispatched]) as f64) as u64;
                if estimate.saturating_mul(2) > budget {
                    // Too large to read beside others: the rest in one go,
                    // once the parts before it are appended.
                    if appended == dispatched {
                        return rest(running, root, &parts, appended);
                    }
                    break;
                }
                if estimates.values().sum::<u64>() + estimate > budget && !estimates.is_empty() {
                    break;
                }
                let mut part = parts[dispatched];
                if options.fault == Some(Fault::SwapParts) {
                    // Parts 1 and 2 the wrong way round, once both are formed.
                    match dispatched {
                        1 if parts.len() > 2 => {
                            part = parts[2];
                            swapped = true;
                        }
                        1 if !all_formed => break,
                        2 if swapped => part = parts[1],
                        _ => {}
                    }
                }
                self.push(Job::Tally(dispatched, part));
                estimates.insert(dispatched, estimate);
                pending += 1;
                dispatched += 1;
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
                    estimates.remove(&i);
                    if part_len(&parts[i]) >= PROBE_LEN {
                        ratio = ratio.max(tree.heap_size() as f64 / part_len(&parts[i]) as f64);
                    }
                    waiting.insert(i, tree);
                    // Append the trees in order.
                    while let Some(tree) = waiting.remove(&appended) {
                        let root = root?;
                        let imported = match running.tallies.import(&mut running.strings, &tree) {
                            Ok(imported) => imported,
                            Err(_) => return rest(running, Some(root), &parts, appended),
                        };
                        // A failed merge changes nothing, and frees what it
                        // was given.
                        if running.tallies.merge(root, imported).is_err() {
                            return rest(running, Some(root), &parts, appended);
                        }
                        appended += 1;
                    }
                }
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
            budget: TREE_BUDGET,
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
        let documents: [&[u8]; 6] = [
            br#"[1,"a,]","b\"],[",{"c":[1,2,{"d":"]}"}]},[],{},null,true,-1.5e3,"\\",["x",["y"]]]"#,
            b" \n[ 1 , 2 ,\t3\r\n, \"x\" ] \n ",
            br##"[{"a":1},{"a":"x","b":[1,{"__proto__":2}]},{"$ref":"#/a"}]"##,
            b"[[],[[]],[[],[]]]",
            b"[\"\\u00e9\\ud83d\\ude00\", \"caf\xc3\xa9\", \"2020-01-01\", \"http://h/x.png\"]",
            b"[\"\\\\\\\"\",\"\\\\\",\"\\\"\"]",
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
        options.budget = 4 << 20;
        let (result, how) = read_with(&config, bytes.as_bytes(), options);
        assert_eq!(result, expected);
        assert_eq!(how.in_part, 1, "{how:?}");
    }

    /// The fault is caught: appending the first two parts read elsewhere
    /// the other way round gives another tree.
    #[test]
    fn swapped_parts_are_caught() {
        let config = config(false);
        let bytes = br#"[{"z":0},{"a":1},{"b":"x"},{"c":null}]"#;
        let mut options = options(2, 1);
        let expected = in_one_go(&config, bytes);
        assert_eq!(read_with(&config, bytes, options).0, expected);
        options.fault = Some(Fault::SwapParts);
        assert_ne!(read_with(&config, bytes, options).0, expected);
    }
}
