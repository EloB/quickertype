//! Not a quicktype file: where a large top-level JSON array can be split
//! between its elements, or JSON Lines between their values, for reading
//! them on several threads ([`parallel_read`](super::parallel_read)). A scan that knows strings
//! and escapes, 64 bytes at a time: simdjson's first stage, with
//! eight-byte words where simdjson has SIMD registers (the workspace has
//! no unsafe code, so no intrinsics).
//!
//! The scan only proposes the split points. Every part is then read by the
//! stream tokenizer, which accepts it only if it reads as the sequential
//! reading does, so a wrong split point can make the parallel reading fall
//! back to reading in one go, but never change a result (see
//! `parallel_read`). For valid JSON the scan is exact: it finds exactly the
//! commas between the top-level array's elements.
//!
//! Three things are tracked from the start of the input: whether a byte is
//! escaped (it follows a backslash that is not itself escaped), whether it
//! is in a string (between unescaped quotes), and the depth (the brackets
//! outside strings). A *range* of the input can be scanned without knowing
//! the state at its start: whether its first byte is escaped follows from
//! the backslashes just before it (or, after a long run of them, from the
//! ranges before it: a summary for each case), the quotes in it flip the
//! string state (so the range's strings are those of one of two cases,
//! starting outside a string or in one, [`Summary`]), and its brackets
//! change the depth by the same amount from any depth. Summaries of
//! consecutive ranges then give the exact state at each range's start, in
//! order, and from there each range's first comma at depth 1
//! ([`ScanState::find_split`]), or for JSON Lines its first line feed at
//! depth 0 ([`Separator`]): a raw line feed can only be whitespace, and
//! outside every value it ends a line between two of them.

/// Each byte of a word set to 1.
const ONES: u64 = u64::from_ne_bytes([1; 8]);
/// The high bit of each byte.
const HIGH: u64 = ONES << 7;
/// Every bit but each byte's high bit.
const LOW: u64 = !HIGH;
/// The odd bits of a block's masks.
const ODD_BITS: u64 = 0xAAAA_AAAA_AAAA_AAAA;

/// The bytes scanned at a time: one bit of a `u64` mask each.
pub(crate) const BLOCK: usize = 64;

/// The high bit of each byte of `word` that equals `b`; exact for every
/// byte (no borrow crosses a byte).
#[inline(always)]
fn equal(word: u64, b: u8) -> u64 {
    let x = word ^ (ONES * u64::from(b));
    // A byte's low seven bits plus 0x7F set its high bit unless they are
    // all zero, and never carry out of it.
    !(((x & LOW) + LOW) | x) & HIGH
}

/// The high bits of a word's bytes (as [`equal`] makes them), gathered into
/// eight bits, byte `i`'s at bit `i`.
#[inline(always)]
fn gather(high_bits: u64) -> u64 {
    // Bit 8i + 7 lands on bit 56 + i; no two products meet, so nothing
    // carries.
    high_bits.wrapping_mul(0x0002_0408_1020_4081) >> 56
}

/// [`gather`] of a block's eight words: one bit per byte of the block.
#[inline(always)]
fn gather_words(high_bits: &[u64; 8]) -> u64 {
    let mut bits = 0;
    for (i, &word) in high_bits.iter().enumerate() {
        bits |= gather(word) << (8 * i);
    }
    bits
}

/// `x` with each bit replaced by the XOR of it and all bits below it: the
/// bits after an odd number of quotes, counting the quote that starts them.
#[inline(always)]
fn prefix_xor(mut x: u64) -> u64 {
    x ^= x << 1;
    x ^= x << 2;
    x ^= x << 4;
    x ^= x << 8;
    x ^= x << 16;
    x ^= x << 32;
    x
}

/// One block's bytes of each kind that matters, one bit per byte.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
struct Masks {
    quote: u64,
    backslash: u64,
    /// `[` and `{` (and `_` and DEL, which valid JSON has only in strings).
    open: u64,
    /// `]` and `}` (and `Y` and `y`, which valid JSON has only in strings).
    close: u64,
}

/// The [`Masks`] of a block.
#[inline(always)]
fn masks(block: &[u8; BLOCK]) -> Masks {
    let mut m = Masks::default();
    let (words, _) = block.as_chunks::<8>();
    for (i, word) in words.iter().enumerate() {
        let w = u64::from_le_bytes(*word);
        let shift = 8 * i;
        m.quote |= gather(equal(w, b'"')) << shift;
        m.backslash |= gather(equal(w, b'\\')) << shift;
        // `[`, `]`, `{` and `}` differ only in bits 1, 2 and 5; four other
        // bytes share the rest (`Y`, `_`, `y`, DEL), none of which valid
        // JSON has outside strings. Of the brackets, the opening ones
        // have bit 1 set.
        let bracket = equal(w & (ONES * 0xD9), 0x59);
        let opening = (w << 6) & HIGH;
        m.open |= gather(bracket & opening) << shift;
        m.close |= gather(bracket & !opening) << shift;
    }
    m
}

/// The bytes of a block that are `b`, one bit per byte.
#[inline(always)]
fn bytes_equal(block: &[u8; BLOCK], b: u8) -> u64 {
    let (words, _) = block.as_chunks::<8>();
    let mut found = 0;
    for (i, word) in words.iter().enumerate() {
        found |= gather(equal(u64::from_le_bytes(*word), b)) << (8 * i);
    }
    found
}

/// What separates the values a sample is split between: a byte outside
/// strings, at a depth.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) struct Separator {
    byte: u8,
    depth: i64,
}

impl Separator {
    /// A comma at depth 1: between the elements of a top-level array.
    pub(crate) const ARRAY: Separator = Separator {
        byte: b',',
        depth: 1,
    };
    /// A line feed at depth 0: between the values of JSON Lines.
    pub(crate) const LINES: Separator = Separator {
        byte: b'\n',
        depth: 0,
    };
}

/// The escaped bytes of a block (each byte right after a backslash that is
/// not itself escaped), given its backslashes. `carry` says whether the
/// block's first byte is escaped, and is set to whether the next block's
/// is. simdjson's `json_escape_scanner::next`: in a run of backslashes,
/// every other one escapes the next byte, counting from the run's start.
#[inline(always)]
fn escaped(backslash: u64, carry: &mut u64) -> u64 {
    if backslash == 0 {
        return std::mem::take(carry);
    }
    // A backslash that is escaped escapes nothing.
    let potential_escape = backslash & !*carry;
    // Subtracting each run's backslashes from the odd bits (and the bits
    // after the runs) leaves, after the XOR, the escapes of runs that
    // start on an even bit and the escaped bytes of runs that start on an
    // odd one, flipped: the XOR below sorts them out.
    let escape_and_terminal_code =
        ((potential_escape << 1) | ODD_BITS).wrapping_sub(potential_escape) ^ ODD_BITS;
    let escaped = escape_and_terminal_code ^ (backslash | *carry);
    let escape = escape_and_terminal_code & backslash;
    *carry = escape >> 63;
    escaped
}

/// What a range of the input does to the scan's state, from either string
/// state at its start (see the module).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) struct Summary {
    /// Whether the range's first byte is escaped, which the backslashes
    /// before it decide.
    pub(crate) escaped_in: bool,
    /// Whether the byte after the range is escaped, which the backslashes
    /// it ends with decide (and, if it is all backslashes, `escaped_in`).
    pub(crate) escaped_out: bool,
    /// Whether the range has an odd number of unescaped quotes, which
    /// flips the string state.
    pub(crate) odd_quotes: bool,
    /// By the string state at the range's start (outside a string, in
    /// one): how much deeper the range ends than it starts, and a bound of
    /// the depths in it relative to its start (each block's lowest depth
    /// is at least its depth before it less its closing brackets).
    pub(crate) depth_change: [i64; 2],
    pub(crate) lowest: [i64; 2],
}

/// Scans the range whose bytes `blocks` gives, block by block (the last
/// one padded with spaces, which change nothing), where `escaped_in` says
/// whether its first byte is escaped.
pub(crate) struct Summarizer {
    summary: Summary,
    /// Whether the next byte is escaped, as a mask bit.
    escape_carry: u64,
    /// The string state the case of a range that starts outside a string
    /// has after the bytes so far, as a mask (the other case's is its
    /// complement).
    in_string: u64,
}

impl Summarizer {
    pub(crate) fn new(escaped_in: bool) -> Self {
        Summarizer {
            summary: Summary {
                escaped_in,
                escaped_out: escaped_in,
                odd_quotes: false,
                depth_change: [0; 2],
                lowest: [0; 2],
            },
            escape_carry: u64::from(escaped_in),
            in_string: 0,
        }
    }

    /// Adds the next block of the range. (What [`masks`] finds, but only
    /// what the block has: most blocks have no backslash, and many no
    /// bracket.)
    #[inline]
    pub(crate) fn block(&mut self, block: &[u8; BLOCK]) {
        let (words, _) = block.as_chunks::<8>();
        let [mut quotes, mut backslashes, mut opens, mut closes] = [[0u64; 8]; 4];
        let (mut any_backslash, mut any_bracket) = (0, 0);
        for (i, word) in words.iter().enumerate() {
            let w = u64::from_le_bytes(*word);
            quotes[i] = equal(w, b'"');
            backslashes[i] = equal(w, b'\\');
            // As in `masks`.
            let bracket = equal(w & (ONES * 0xD9), 0x59);
            let opening = (w << 6) & HIGH;
            opens[i] = bracket & opening;
            closes[i] = bracket & !opening;
            any_backslash |= backslashes[i];
            any_bracket |= bracket;
        }
        let mut quote = gather_words(&quotes);
        if any_backslash != 0 || self.escape_carry != 0 {
            quote &= !escaped(gather_words(&backslashes), &mut self.escape_carry);
        }
        let inside = prefix_xor(quote) ^ self.in_string;
        self.in_string = ((inside as i64) >> 63) as u64;
        if any_bracket == 0 {
            return;
        }
        let (open, close) = (gather_words(&opens), gather_words(&closes));
        // Outside a string in the case that starts outside one, and the
        // rest in the case that starts in one.
        let (open_out, close_out) = (
            i64::from((open & !inside).count_ones()),
            i64::from((close & !inside).count_ones()),
        );
        let (opens, closes) = (i64::from(open.count_ones()), i64::from(close.count_ones()));
        let s = &mut self.summary;
        for (case, (open, close)) in [
            (open_out, close_out),
            (opens - open_out, closes - close_out),
        ]
        .into_iter()
        .enumerate()
        {
            let depth = s.depth_change[case];
            s.lowest[case] = s.lowest[case].min(depth - close);
            s.depth_change[case] = depth + open - close;
        }
    }

    /// The summary of the blocks added, which hold `len` bytes (and then
    /// padding) that end with `run` backslashes ([`trailing_backslashes`]).
    pub(crate) fn finish(mut self, len: u64, run: u64) -> Summary {
        self.summary.odd_quotes = self.in_string != 0;
        // In a run of backslashes every other one escapes the next byte,
        // counting from the run's start; a run that is the whole range
        // starts after its first byte if that is escaped.
        let escaped_in = self.summary.escaped_in;
        self.summary.escaped_out = if len == 0 {
            escaped_in
        } else if run == len {
            (run - u64::from(escaped_in)) % 2 == 1
        } else {
            run % 2 == 1
        };
        self.summary
    }
}

/// The scan's state at a point of the input.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub(crate) struct ScanState {
    /// Whether the byte here is escaped.
    pub(crate) escaped: bool,
    /// Whether the byte here is in a string.
    pub(crate) in_string: bool,
    /// The number of brackets open here (outside strings).
    pub(crate) depth: i64,
}

impl ScanState {
    /// The state after a range with summary `summary` that starts in this
    /// state.
    pub(crate) fn after(self, summary: &Summary) -> ScanState {
        let case = usize::from(self.in_string);
        ScanState {
            escaped: summary.escaped_out,
            in_string: self.in_string != summary.odd_quotes,
            depth: self.depth + summary.depth_change[case],
        }
    }

    /// Whether a range with summary `summary` that starts in this state
    /// may have `separator` (by the bound of its depths).
    pub(crate) fn may_split(self, summary: &Summary, separator: Separator) -> bool {
        self.depth + summary.lowest[usize::from(self.in_string)] <= separator.depth
    }

    /// Scans `block`, which starts in this state, for `separator` outside
    /// strings at its depth (a comma between the top-level array's
    /// elements, a line feed between JSON Lines' values): returns its
    /// index in the block, or `None` and moves this state past the block.
    #[inline]
    pub(crate) fn find_split(
        &mut self,
        block: &[u8; BLOCK],
        separator: Separator,
    ) -> Option<usize> {
        let m = masks(block);
        let mut escape_carry = u64::from(self.escaped);
        let quote = m.quote & !escaped(m.backslash, &mut escape_carry);
        let carry = if self.in_string { u64::MAX } else { 0 };
        let inside = prefix_xor(quote) ^ carry;
        let outside = !inside;
        let (open, close) = (m.open & outside, m.close & outside);
        let (opens, closes) = (i64::from(open.count_ones()), i64::from(close.count_ones()));
        // Only a block whose depths may reach the separator's is looked at
        // separator by separator.
        let target = separator.depth;
        if self.depth - closes <= target && self.depth + opens >= target {
            let separators = bytes_equal(block, separator.byte) & outside;
            if separators != 0 {
                let mut depth = self.depth;
                let mut bits = open | close | separators;
                while bits != 0 {
                    let bit = bits & bits.wrapping_neg();
                    bits ^= bit;
                    if open & bit != 0 {
                        depth += 1;
                    } else if close & bit != 0 {
                        depth -= 1;
                    } else if depth == target {
                        return Some(bit.trailing_zeros() as usize);
                    }
                }
            }
        }
        self.escaped = escape_carry != 0;
        self.in_string = (inside as i64) < 0;
        self.depth += opens - closes;
        None
    }
}

/// Whether the byte after `before` (the bytes that precede it, at least
/// back to a byte that is not a backslash, or to the start of the input)
/// is escaped: in a run of backslashes, every other one escapes the next
/// byte, counting from the run's start. `None` if every byte of `before`
/// is a backslash and more may precede them.
pub(crate) fn escaped_after(before: &[u8], at_start: bool) -> Option<bool> {
    let run = trailing_backslashes(before);
    (run < before.len() || at_start).then_some(run % 2 == 1)
}

/// How many backslashes `bytes` ends with.
pub(crate) fn trailing_backslashes(bytes: &[u8]) -> usize {
    bytes.iter().rev().take_while(|&&b| b == b'\\').count()
}

/// A range's summary, or, where the bytes just before it are all
/// backslashes, one for each case of its first byte: escaped or not, which
/// the ranges before it then tell ([`Summary::escaped_out`]). (Looking
/// further back for where the run starts would read a long run again for
/// every range in it.)
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum RangeSummary {
    Known(Summary),
    Either([Summary; 2]),
}

impl RangeSummary {
    /// The summary for a range whose first byte is `escaped` or not.
    pub(crate) fn given(self, escaped: bool) -> Summary {
        match self {
            RangeSummary::Known(summary) => summary,
            RangeSummary::Either(both) => both[usize::from(escaped)],
        }
    }
}

/// Summarizes a range piece by piece ([`RangeSummary`]): the CLI's reading
/// threads read it 64 KiB at a time, the WebAssembly engine's workers hand
/// it over whole.
pub(crate) struct RangeSummarizer {
    summarizer: Summarizer,
    /// The case of a first byte that is escaped, where the bytes before the
    /// range do not tell.
    escaped_one: Option<Summarizer>,
    /// The bytes so far, and the backslashes they end with.
    len: u64,
    run: u64,
}

impl RangeSummarizer {
    /// A range whose first byte is escaped or not, if the bytes before it
    /// tell ([`escaped_after`]); for both cases if they do not (`None`).
    pub(crate) fn new(escaped: Option<bool>) -> Self {
        RangeSummarizer {
            summarizer: Summarizer::new(escaped.unwrap_or(false)),
            escaped_one: escaped.is_none().then(|| Summarizer::new(true)),
            len: 0,
            run: 0,
        }
    }

    /// The next bytes of the range; every piece but the last must be a
    /// multiple of [`BLOCK`] long (the last block of a piece is padded).
    pub(crate) fn piece(&mut self, piece: &[u8]) {
        let tail = trailing_backslashes(piece) as u64;
        self.run = if tail == piece.len() as u64 {
            self.run + tail
        } else {
            tail
        };
        self.len += piece.len() as u64;
        for block in blocks(piece) {
            self.summarizer.block(&block);
        }
        if let Some(escaped_one) = &mut self.escaped_one {
            for block in blocks(piece) {
                escaped_one.block(&block);
            }
        }
    }

    /// The range's summary.
    pub(crate) fn finish(self) -> RangeSummary {
        let summary = self.summarizer.finish(self.len, self.run);
        match self.escaped_one {
            Some(escaped_one) => {
                RangeSummary::Either([summary, escaped_one.finish(self.len, self.run)])
            }
            None => RangeSummary::Known(summary),
        }
    }
}

impl ScanState {
    /// The first `separator` in `piece` (outside strings, at its depth),
    /// which starts in this state: its index, or `None` and this state
    /// moved past the piece. Every piece of a scan but the last must be a
    /// multiple of [`BLOCK`] long (the last block of a piece is padded with
    /// spaces, which change nothing).
    pub(crate) fn split_in(&mut self, piece: &[u8], separator: Separator) -> Option<usize> {
        blocks(piece)
            .enumerate()
            .find_map(|(k, block)| self.find_split(&block, separator).map(|i| k * BLOCK + i))
    }

    /// For the range of summary `summary` that starts in this state:
    /// whether it may hold `separator` (by the bound of its depths), and
    /// the state after it. (Whether its first byte is escaped, this state
    /// says, from the ranges before it.)
    pub(crate) fn through(self, summary: RangeSummary, separator: Separator) -> (bool, ScanState) {
        let summary = summary.given(self.escaped);
        (self.may_split(&summary, separator), self.after(&summary))
    }
}

/// The input as a sequence of blocks: `bytes`, the last block padded
/// with spaces.
pub(crate) fn blocks(bytes: &[u8]) -> impl Iterator<Item = [u8; BLOCK]> + '_ {
    let (whole, rest) = bytes.as_chunks::<BLOCK>();
    whole.iter().copied().chain((!rest.is_empty()).then(|| {
        let mut last = [b' '; BLOCK];
        last[..rest.len()].copy_from_slice(rest);
        last
    }))
}

#[cfg(test)]
pub(crate) mod tests {
    use super::*;

    /// The scan's state at `at`, byte by byte from the start, by its rules
    /// for any bytes: a backslash that is not escaped escapes the next byte
    /// (valid JSON has backslashes only in strings), a quote that is not
    /// escaped starts or ends a string, and outside strings `[`, `{`, `_`
    /// and DEL open and `]`, `}`, `Y` and `y` close (valid JSON has only
    /// brackets there).
    pub(crate) fn bytewise_state(bytes: &[u8], at: usize) -> ScanState {
        let mut state = ScanState::default();
        for &b in &bytes[..at] {
            bytewise_step(&mut state, b);
        }
        state
    }

    /// Moves `state` past `b`.
    fn bytewise_step(state: &mut ScanState, b: u8) {
        let escaped = state.escaped;
        state.escaped = !escaped && b == b'\\';
        if b == b'"' && !escaped {
            state.in_string = !state.in_string;
        } else if !state.in_string {
            match b {
                b'[' | b'{' | b'_' | 0x7F => state.depth += 1,
                b']' | b'}' | b'Y' | b'y' => state.depth -= 1,
                _ => {}
            }
        }
    }

    /// The `separator`s outside strings at its depth, byte by byte.
    pub(crate) fn bytewise_separators(bytes: &[u8], separator: Separator) -> Vec<usize> {
        let mut state = ScanState::default();
        let mut found = Vec::new();
        for (i, &b) in bytes.iter().enumerate() {
            if b == separator.byte && !state.in_string && state.depth == separator.depth {
                found.push(i);
            }
            bytewise_step(&mut state, b);
        }
        found
    }

    /// The first `separator` at or after `from`, found block by block from
    /// the state there; the state after the bytes if there is none.
    fn scanned_split(bytes: &[u8], from: usize, separator: Separator) -> Result<usize, ScanState> {
        let mut state = bytewise_state(bytes, from);
        for (k, block) in blocks(&bytes[from..]).enumerate() {
            if let Some(i) = state.find_split(&block, separator) {
                return Ok(from + k * BLOCK + i);
            }
        }
        Err(state)
    }

    /// The escaped bytes, byte by byte.
    fn bytewise_escaped(backslash: u64, mut carry: bool) -> (u64, bool) {
        let mut escaped = 0;
        for i in 0..64 {
            let is_escaped = carry;
            if is_escaped {
                escaped |= 1 << i;
            }
            carry = !is_escaped && backslash & (1 << i) != 0;
        }
        (escaped, carry)
    }

    /// A small deterministic generator (xorshift).
    pub(crate) struct Rng(pub(crate) u64);

    impl Rng {
        pub(crate) fn next(&mut self) -> u64 {
            self.0 ^= self.0 << 13;
            self.0 ^= self.0 >> 7;
            self.0 ^= self.0 << 17;
            self.0
        }

        pub(crate) fn below(&mut self, n: usize) -> usize {
            (self.next() % n as u64) as usize
        }
    }

    #[test]
    fn equal_and_gather_every_byte() {
        for b in 0..=255u8 {
            for at in 0..8 {
                for fill in [0u8, b'"', 0x7F, 0x80, 0xFF, b.wrapping_add(1), b ^ 0x80] {
                    let mut word = [fill; 8];
                    word[at] = b;
                    let w = u64::from_le_bytes(word);
                    for target in [b, b'"', b'\\', 0, 0x80] {
                        let expected: u64 = word
                            .iter()
                            .enumerate()
                            .filter(|&(_, &x)| x == target)
                            .map(|(i, _)| 1 << i)
                            .sum();
                        assert_eq!(gather(equal(w, target)), expected, "{word:?} {target}");
                    }
                }
            }
        }
    }

    #[test]
    fn brackets_are_classified() {
        for b in 0..=255u8 {
            for at in [0, 5, 31, 63] {
                let mut block = [b'a'; BLOCK];
                block[at] = b;
                let m = masks(&block);
                let (open, close) = (m.open >> at & 1 == 1, m.close >> at & 1 == 1);
                match b {
                    b'[' | b'{' | b'_' | 0x7F => assert!(open && !close, "{b}"),
                    b']' | b'}' | b'Y' | b'y' => assert!(close && !open, "{b}"),
                    _ => assert!(!open && !close, "{b}"),
                }
                assert_eq!(m.quote >> at & 1 == 1, b == b'"');
                assert_eq!(m.backslash >> at & 1 == 1, b == b'\\');
                for separator in *b",\n" {
                    let found = bytes_equal(&block, separator) >> at & 1 == 1;
                    assert_eq!(found, b == separator);
                }
                // Only that byte.
                assert!(m.quote.count_ones() + m.backslash.count_ones() <= 1);
                assert!((m.open | m.close).count_ones() <= 1);
            }
        }
    }

    #[test]
    fn escapes_match_bytewise() {
        let mut rng = Rng(0x9E37_79B9_7F4A_7C15);
        // Runs of backslashes of every length at every position, and
        // random masks, dense and sparse.
        let mut cases = Vec::new();
        for len in 1..=64u32 {
            for at in 0..=64 - len {
                let run = if len == 64 {
                    u64::MAX
                } else {
                    ((1u64 << len) - 1) << at
                };
                cases.push(run);
            }
        }
        for _ in 0..20_000 {
            let a = rng.next();
            cases.push(a);
            cases.push(a & rng.next());
            cases.push(a & rng.next() & rng.next());
            cases.push(a | rng.next());
        }
        for backslash in cases {
            for carry in [false, true] {
                let mut c = u64::from(carry);
                let got = escaped(backslash, &mut c);
                assert_eq!(
                    (got, c == 1),
                    bytewise_escaped(backslash, carry),
                    "{backslash:064b} {carry}"
                );
            }
        }
    }

    /// A random string of bytes that matter to the scan, the separators
    /// included (and a few that do not).
    pub(crate) fn random_bytes(rng: &mut Rng, len: usize) -> Vec<u8> {
        const ALPHABET: &[u8] = b"\"\"\"\\\\,,,\n\n[]{}:a 1Yy_\x7f\xc3\r";
        (0..len)
            .map(|_| ALPHABET[rng.below(ALPHABET.len())])
            .collect()
    }

    /// A random JSON value, `depth` levels deep: strings and keys full of
    /// quotes, escapes, brackets and commas, nested arrays and objects,
    /// which now and then span lines (line feeds and CRLF as whitespace in
    /// them, at depth 1 and more).
    pub(crate) fn random_value(rng: &mut Rng, out: &mut Vec<u8>, depth: usize) {
        // Whitespace in arrays and objects, now and then lines.
        fn space(rng: &mut Rng, out: &mut Vec<u8>) {
            let spaces: [&[u8]; 6] = [b"", b" ", b"", b"\n", b"\r\n  ", b" \n\t"];
            out.extend_from_slice(spaces[rng.below(spaces.len())]);
        }
        match rng.below(if depth > 4 { 3 } else { 6 }) {
            0 => out.extend_from_slice(b"123"),
            1 => {
                out.push(b'"');
                for _ in 0..rng.below(12) {
                    let pieces: [&[u8]; 14] = [
                        b"a",
                        b"\\\"",
                        b"\\\\",
                        b"[",
                        b"]",
                        b"{",
                        b"}",
                        b",",
                        b"\\n",
                        b"\\\\\\\"",
                        b" ",
                        b"Yy_\x7f",
                        // Past 64 units: a place that absorbs strings.
                        b"long text long text long text long text long text long text long ",
                        "\u{e9}".as_bytes(),
                    ];
                    out.extend_from_slice(pieces[rng.below(pieces.len())]);
                }
                out.push(b'"');
            }
            2 => out.extend_from_slice(b"null"),
            3 => {
                out.push(b'[');
                for i in 0..rng.below(4) {
                    if i > 0 {
                        out.push(b',');
                    }
                    space(rng, out);
                    random_value(rng, out, depth + 1);
                }
                space(rng, out);
                out.push(b']');
            }
            _ => {
                out.push(b'{');
                for i in 0..rng.below(4) {
                    if i > 0 {
                        out.push(b',');
                    }
                    space(rng, out);
                    out.extend_from_slice(b"\"k\\\"\"");
                    space(rng, out);
                    out.extend_from_slice(b": ");
                    random_value(rng, out, depth + 1);
                }
                space(rng, out);
                out.push(b'}');
            }
        }
    }

    /// A random JSON document: an array of `elements` random values
    /// ([`random_value`]), between commas, some before a line feed.
    pub(crate) fn random_json(rng: &mut Rng, elements: usize) -> Vec<u8> {
        let mut out = b" [".to_vec();
        for i in 0..elements {
            if i > 0 {
                out.extend_from_slice(if rng.below(2) == 0 { b"," } else { b" ,\n" });
            }
            random_value(rng, &mut out, 1);
        }
        out.extend_from_slice(b"]\n");
        out
    }

    /// Random JSON Lines of `values` values (some spanning lines), with LF
    /// and CRLF line breaks, blank and whitespace-only lines, and
    /// whitespace before and after.
    pub(crate) fn random_lines(rng: &mut Rng, values: usize) -> Vec<u8> {
        let breaks: [&[u8]; 5] = [b"\n", b"\r\n", b"\n\n", b" \n\t", b"\r\n \r\n"];
        let mut out = if rng.below(3) == 0 {
            b"\n ".to_vec()
        } else {
            Vec::new()
        };
        for i in 0..values {
            if i > 0 {
                out.extend_from_slice(breaks[rng.below(breaks.len())]);
            }
            random_value(rng, &mut out, 0);
        }
        if rng.below(2) == 0 {
            out.extend_from_slice(breaks[rng.below(breaks.len())]);
        }
        out
    }

    /// From any point and the state there, the scan finds the first comma
    /// at depth 1 (or for JSON Lines, line feed at depth 0), or ends in the
    /// state after the bytes.
    #[test]
    fn find_split_matches_bytewise() {
        let mut rng = Rng(12345);
        // Line feeds that split JSON Lines, and those in their values,
        // which do not.
        let (mut line_splits, mut deep_line_feeds) = (0, 0);
        for round in 0..1_500 {
            let (bytes, separator) = match round % 4 {
                0 => (random_json(&mut rng, 1 + round % 40), Separator::ARRAY),
                1 => (random_lines(&mut rng, 1 + round % 40), Separator::LINES),
                _ => {
                    let len = rng.below(300);
                    let separator = [Separator::ARRAY, Separator::LINES][round % 4 - 2];
                    (random_bytes(&mut rng, len), separator)
                }
            };
            let splits = bytewise_separators(&bytes, separator);
            if separator == Separator::LINES {
                line_splits += splits.len();
                deep_line_feeds += bytes.iter().filter(|&&b| b == b'\n').count() - splits.len();
            }
            for from in 0..=bytes.len() {
                let expected = match splits.iter().find(|&&s| s >= from) {
                    Some(&s) => Ok(s),
                    None => Err(bytewise_state(&bytes, bytes.len())),
                };
                // The padding after the end may take an escape.
                let got =
                    scanned_split(&bytes, from, separator).map_err(|s| (s.in_string, s.depth));
                let expected = expected.map_err(|s| (s.in_string, s.depth));
                assert_eq!(
                    got,
                    expected,
                    "from {from}: {:?}",
                    String::from_utf8_lossy(&bytes)
                );
            }
        }
        assert!(
            line_splits > 1_000 && deep_line_feeds > 1_000,
            "{line_splits} line feeds between values, {deep_line_feeds} others"
        );
    }

    /// Summaries of ranges, cut anywhere, resolve to the states the bytes
    /// have at each cut, and bound the depths in each range.
    #[test]
    fn summaries_resolve_to_the_states_of_a_scan() {
        let mut rng = Rng(777);
        for round in 0..3_000 {
            let bytes = if round % 3 == 0 {
                {
                    let len = rng.below(600);
                    random_bytes(&mut rng, len)
                }
            } else {
                random_json(&mut rng, 1 + round % 30)
            };
            let mut cuts: Vec<usize> = (0..rng.below(8))
                .map(|_| rng.below(bytes.len() + 1))
                .collect();
            cuts.extend([0, bytes.len()]);
            cuts.sort_unstable();
            let mut state = ScanState::default();
            for pair in cuts.windows(2) {
                let (from, to) = (pair[0], pair[1]);
                let exact = bytewise_state(&bytes, from);
                // Whether the range's first byte is escaped, from the
                // bytes before it, and as the ranges before it chain it.
                let escaped_in = escaped_after(&bytes[..from], true).unwrap();
                assert_eq!(escaped_in, exact.escaped, "escape at {from}");
                assert_eq!(state, exact, "state at {from}");
                let summary = summarize(&bytes[from..to], escaped_in);
                let low = state.depth + summary.lowest[usize::from(state.in_string)];
                for at in from..=to {
                    let depth = bytewise_state(&bytes, at).depth;
                    assert!(low <= depth, "depth {depth} at {at}");
                }
                state = state.after(&summary);
            }
            let end = bytewise_state(&bytes, bytes.len());
            assert_eq!((state.in_string, state.depth), (end.in_string, end.depth));
        }
    }

    /// The summary of `bytes`, whose first byte is escaped or not.
    fn summarize(bytes: &[u8], escaped_in: bool) -> Summary {
        let mut summarizer = Summarizer::new(escaped_in);
        for block in blocks(bytes) {
            summarizer.block(&block);
        }
        let run = trailing_backslashes(bytes) as u64;
        summarizer.finish(bytes.len() as u64, run)
    }

    /// Long runs of backslashes, cut anywhere: whether each range's first
    /// byte is escaped follows from the ranges before it (each summarized
    /// for both cases), as from the bytes before it.
    #[test]
    fn escapes_chain_through_runs_of_backslashes() {
        let mut rng = Rng(4711);
        for round in 0..400 {
            // Strings of backslash runs, some escaping a quote.
            let mut bytes = b"[".to_vec();
            for i in 0..1 + round % 5 {
                if i > 0 {
                    bytes.push(b',');
                }
                bytes.push(b'"');
                for _ in 0..1 + rng.below(3) {
                    let longest = if rng.below(4) == 0 { 3_000 } else { 200 };
                    let run = 1 + rng.below(longest);
                    bytes.extend(std::iter::repeat_n(b'\\', run));
                    // An odd run escapes the quote after it; after an even
                    // one comes a bracket, in the string.
                    bytes.extend_from_slice(if run % 2 == 1 { b"\"x" } else { b"]x" });
                }
                bytes.push(b'"');
            }
            bytes.push(b']');
            let mut cuts: Vec<usize> = (0..rng.below(12))
                .map(|_| rng.below(bytes.len() + 1))
                .collect();
            cuts.extend([0, bytes.len()]);
            cuts.sort_unstable();
            let mut state = ScanState::default();
            for pair in cuts.windows(2) {
                let (from, to) = (pair[0], pair[1]);
                assert_eq!(state, bytewise_state(&bytes, from), "state at {from}");
                let both = [false, true].map(|e| summarize(&bytes[from..to], e));
                state = state.after(&both[usize::from(state.escaped)]);
            }
            assert_eq!(state, bytewise_state(&bytes, bytes.len()));
        }
    }

    #[test]
    fn escaped_after_counts_the_run() {
        assert_eq!(escaped_after(b"", true), Some(false));
        assert_eq!(escaped_after(b"a\\", false), Some(true));
        assert_eq!(escaped_after(b"a\\\\", false), Some(false));
        assert_eq!(escaped_after(b"\\\\\\", true), Some(true));
        assert_eq!(escaped_after(b"\\\\\\", false), None);
    }
}
