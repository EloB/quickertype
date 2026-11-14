//! Not a quicktype file: where a large top-level JSON array can be split
//! between its elements, for reading it on several threads
//! ([`parallel_read`](super::parallel_read)). A scan that knows strings
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
//! the backslashes just before it, the quotes in it flip the string state
//! (so the range's strings are those of one of two cases, starting outside
//! a string or in one, [`Summary`]), and its brackets change the depth by
//! the same amount from any depth. Summaries of consecutive ranges then
//! give the exact state at each range's start, in order, and from there
//! each range's first comma at depth 1 ([`ScanState::find_split`]).

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

/// The commas of a block, one bit per byte.
#[inline(always)]
fn commas(block: &[u8; BLOCK]) -> u64 {
    let (words, _) = block.as_chunks::<8>();
    let mut commas = 0;
    for (i, word) in words.iter().enumerate() {
        commas |= gather(equal(u64::from_le_bytes(*word), b',')) << (8 * i);
    }
    commas
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

    /// The summary of the blocks added.
    pub(crate) fn finish(mut self) -> Summary {
        self.summary.odd_quotes = self.in_string != 0;
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
    /// state, but for whether the next byte is escaped, which the next
    /// range's summary says ([`Summary::escaped_in`]).
    pub(crate) fn after(self, summary: &Summary) -> ScanState {
        let case = usize::from(self.in_string);
        ScanState {
            escaped: false,
            in_string: self.in_string != summary.odd_quotes,
            depth: self.depth + summary.depth_change[case],
        }
    }

    /// Whether a range with summary `summary` that starts in this state
    /// may have a comma at depth 1 (by the bound of its depths).
    pub(crate) fn may_split(self, summary: &Summary) -> bool {
        self.depth + summary.lowest[usize::from(self.in_string)] <= 1
    }

    /// Scans `block`, which starts in this state, for a comma outside
    /// strings at depth 1 (one between the top-level array's elements):
    /// returns its index in the block, or `None` and moves this state past
    /// the block.
    #[inline]
    pub(crate) fn find_split(&mut self, block: &[u8; BLOCK]) -> Option<usize> {
        let m = masks(block);
        let mut escape_carry = u64::from(self.escaped);
        let quote = m.quote & !escaped(m.backslash, &mut escape_carry);
        let carry = if self.in_string { u64::MAX } else { 0 };
        let inside = prefix_xor(quote) ^ carry;
        let outside = !inside;
        let (open, close) = (m.open & outside, m.close & outside);
        let (opens, closes) = (i64::from(open.count_ones()), i64::from(close.count_ones()));
        // Only a block whose depths may reach 1 is looked at comma by comma.
        if self.depth - closes <= 1 && self.depth + opens >= 1 {
            let commas = commas(block) & outside;
            if commas != 0 {
                let mut depth = self.depth;
                let mut bits = open | close | commas;
                while bits != 0 {
                    let bit = bits & bits.wrapping_neg();
                    bits ^= bit;
                    if open & bit != 0 {
                        depth += 1;
                    } else if close & bit != 0 {
                        depth -= 1;
                    } else if depth == 1 {
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
    let run = before.iter().rev().take_while(|&&b| b == b'\\').count();
    (run < before.len() || at_start).then_some(run % 2 == 1)
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
        state
    }

    /// The commas at depth 1 outside strings, byte by byte.
    pub(crate) fn bytewise_splits(bytes: &[u8]) -> Vec<usize> {
        (0..bytes.len())
            .filter(|&i| {
                let state = bytewise_state(bytes, i);
                bytes[i] == b',' && !state.in_string && state.depth == 1
            })
            .collect()
    }

    /// The first comma at depth 1 at or after `from`, found block by block
    /// from the state there; the state after the bytes if there is none.
    fn scanned_split(bytes: &[u8], from: usize) -> Result<usize, ScanState> {
        let mut state = bytewise_state(bytes, from);
        for (k, block) in blocks(&bytes[from..]).enumerate() {
            if let Some(i) = state.find_split(&block) {
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
                assert_eq!(commas(&block) >> at & 1 == 1, b == b',');
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

    /// A random string of bytes that matter to the scan (and a few that do
    /// not).
    pub(crate) fn random_bytes(rng: &mut Rng, len: usize) -> Vec<u8> {
        const ALPHABET: &[u8] = b"\"\"\"\\\\,,,[]{}:a 1Yy_\x7f\xc3";
        (0..len)
            .map(|_| ALPHABET[rng.below(ALPHABET.len())])
            .collect()
    }

    /// A random JSON document: an array of elements with strings (escapes,
    /// brackets and commas in them), nested arrays and objects.
    pub(crate) fn random_json(rng: &mut Rng, elements: usize) -> Vec<u8> {
        fn value(rng: &mut Rng, out: &mut Vec<u8>, depth: usize) {
            match rng.below(if depth > 4 { 3 } else { 6 }) {
                0 => out.extend_from_slice(b"123"),
                1 => {
                    out.push(b'"');
                    for _ in 0..rng.below(12) {
                        let pieces: [&[u8]; 13] = [
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
                            out.extend_from_slice(b", ");
                        }
                        value(rng, out, depth + 1);
                    }
                    out.push(b']');
                }
                _ => {
                    out.push(b'{');
                    for i in 0..rng.below(4) {
                        if i > 0 {
                            out.push(b',');
                        }
                        out.extend_from_slice(b"\"k\\\"\" : ");
                        value(rng, out, depth + 1);
                    }
                    out.push(b'}');
                }
            }
        }
        let mut out = b" [".to_vec();
        for i in 0..elements {
            if i > 0 {
                out.extend_from_slice(if rng.below(2) == 0 { b"," } else { b" ,\n" });
            }
            value(rng, &mut out, 1);
        }
        out.extend_from_slice(b"]\n");
        out
    }

    /// From any point and the state there, the scan finds the first comma
    /// at depth 1, or ends in the state after the bytes.
    #[test]
    fn find_split_matches_bytewise() {
        let mut rng = Rng(12345);
        for round in 0..1_500 {
            let bytes = if round % 2 == 0 {
                random_json(&mut rng, 1 + round % 40)
            } else {
                {
                    let len = rng.below(300);
                    random_bytes(&mut rng, len)
                }
            };
            let splits = bytewise_splits(&bytes);
            for from in 0..=bytes.len() {
                let expected = match splits.iter().find(|&&s| s >= from) {
                    Some(&s) => Ok(s),
                    None => Err(bytewise_state(&bytes, bytes.len())),
                };
                // The padding after the end may take an escape.
                let got = scanned_split(&bytes, from).map_err(|s| (s.in_string, s.depth));
                let expected = expected.map_err(|s| (s.in_string, s.depth));
                assert_eq!(
                    got,
                    expected,
                    "from {from}: {:?}",
                    String::from_utf8_lossy(&bytes)
                );
            }
        }
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
                // bytes before it.
                let escaped_in = escaped_after(&bytes[..from], true).unwrap();
                assert_eq!(escaped_in, exact.escaped, "escape at {from}");
                state.escaped = escaped_in;
                assert_eq!(state, exact, "state at {from}");
                let mut summarizer = Summarizer::new(escaped_in);
                for block in blocks(&bytes[from..to]) {
                    summarizer.block(&block);
                }
                let summary = summarizer.finish();
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

    #[test]
    fn escaped_after_counts_the_run() {
        assert_eq!(escaped_after(b"", true), Some(false));
        assert_eq!(escaped_after(b"a\\", false), Some(true));
        assert_eq!(escaped_after(b"a\\\\", false), Some(false));
        assert_eq!(escaped_after(b"\\\\\\", true), Some(true));
        assert_eq!(escaped_after(b"\\\\\\", false), None);
    }
}
