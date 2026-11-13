//! Port of `packages/quicktype-core/src/MarkovChain.ts`.
//!
//! A third-order Markov chain over property-name characters. `InferMaps`
//! uses [`evaluate`] to tell names that look like words (`firstName`) from
//! names that look like data (`2BTZIqw0ntH9MvilQ3ewNY`), which decides whether
//! an object becomes a class or a map.
//!
//! The trained chain ships as a base91 string (`EncodedMarkovChain.ts`,
//! copied verbatim into `encoded_markov_chain.txt`) holding an rANS-coded,
//! 5-level quantized table of 65³ trigram probabilities. Decoding is integer
//! only; evaluation follows JavaScript exactly: indices are UTF-16 code
//! units, code units outside the alphabet are unseen, the product is
//! accumulated left to right in `f64`, and the geometric mean uses V8's `**`
//! ([`quicktype_js_compat::number::pow`]).

use std::sync::LazyLock;

use quicktype_js_compat::json::{self, IndexMap, JsonValue};
use quicktype_js_compat::{number, utf16};

const ALPHABET: &[u8] = b" -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz";
const ALPHABET_SIZE: usize = ALPHABET.len();
const BASE91_ALPHABET: &[u8] =
    b"!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}";
const UNSEEN_PROBABILITY: f64 = 0.0001;
const DEPTH: usize = 3;

/// The encoded chain: the string literal of `EncodedMarkovChain.ts`.
const ENCODED_MARKOV_CHAIN: &str = include_str!("encoded_markov_chain.txt");

/// `characterIndexes`: the alphabet position of each ASCII code, or -1.
const CHARACTER_INDEXES: [i8; 128] = {
    let mut indexes = [-1i8; 128];
    let mut i = 0;
    while i < ALPHABET_SIZE {
        indexes[ALPHABET[i] as usize] = i as i8;
        i += 1;
    }
    indexes
};

/// `base91Indexes`: the digit value of each ASCII code (0 if not a digit).
const BASE91_INDEXES: [u8; 128] = {
    let mut indexes = [0u8; 128];
    let mut i = 0;
    while i < BASE91_ALPHABET.len() {
        indexes[BASE91_ALPHABET[i] as usize] = i as u8;
        i += 1;
    }
    indexes
};

/// `MarkovChain`: the decoded chain.
#[derive(Debug, Clone, PartialEq)]
pub struct MarkovChain {
    /// The chain's order plus one; always 3.
    pub depth: usize,
    /// Dense `[first][second][third]` indexes into `probabilities`, by
    /// alphabet position. Code zero is the fixed unseen probability.
    pub probability_codes: Vec<u8>,
    /// The quantized probability levels, as single-precision floats.
    pub probabilities: Vec<f32>,
}

/// `decodeBase91`.
fn decode_base91(encoded: &str) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(encoded.len() * 14 / 16 + 1);
    let mut value: Option<u32> = None;
    let mut bits: u32 = 0;
    let mut bit_count: u32 = 0;

    for &code in encoded.as_bytes() {
        let digit = u32::from(BASE91_INDEXES.get(usize::from(code)).copied().unwrap_or(0));
        let Some(low) = value else {
            value = Some(digit);
            continue;
        };
        let pair = low + digit * 91;
        bits |= pair << bit_count;
        bit_count += if (pair & 8191) > 88 { 13 } else { 14 };
        while bit_count >= 8 {
            bytes.push((bits & 0xFF) as u8);
            bits >>= 8;
            bit_count -= 8;
        }
        value = None;
    }
    if let Some(low) = value {
        bytes.push(((bits | (low << bit_count)) & 0xFF) as u8);
    }
    bytes
}

/// `RansDecoder`.
struct RansDecoder<'a> {
    bytes: &'a [u8],
    state: u64,
    position: usize,
    scale: u64,
    symbol_count: usize,
}

impl<'a> RansDecoder<'a> {
    fn new(bytes: &'a [u8], offset: usize, scale: u64, symbol_count: usize) -> Option<Self> {
        let state = u64::from(read_u32(bytes, offset)?);
        Some(RansDecoder {
            bytes,
            state,
            position: offset + 4,
            scale,
            symbol_count,
        })
    }

    fn read(
        &mut self,
        model: usize,
        frequencies: &[u16],
        cumulative: &[u16],
        symbols: &[u8],
    ) -> Option<u8> {
        let slot = self.state % self.scale;
        let symbol = *symbols.get(model * self.scale as usize + slot as usize)?;
        let index = model * self.symbol_count + usize::from(symbol);
        let frequency = u64::from(*frequencies.get(index)?);
        let start = u64::from(*cumulative.get(index)?);
        self.state = (frequency * (self.state / self.scale) + slot).checked_sub(start)?;
        while self.state < 1 << 23 {
            self.state = self.state * 256 + u64::from(*self.bytes.get(self.position)?);
            self.position += 1;
        }
        Some(symbol)
    }
}

fn read_u16(bytes: &[u8], offset: usize) -> Option<u16> {
    Some(u16::from_le_bytes(
        bytes.get(offset..offset + 2)?.try_into().ok()?,
    ))
}

fn read_u32(bytes: &[u8], offset: usize) -> Option<u32> {
    Some(u32::from_le_bytes(
        bytes.get(offset..offset + 4)?.try_into().ok()?,
    ))
}

fn read_f32(bytes: &[u8], offset: usize) -> Option<f32> {
    Some(f32::from_le_bytes(
        bytes.get(offset..offset + 4)?.try_into().ok()?,
    ))
}

/// `makeEntropyTables`: cumulative frequencies and the slot → symbol table
/// of each model.
fn make_entropy_tables(
    frequencies: &[u16],
    model_count: usize,
    symbol_count: usize,
    scale: usize,
) -> (Vec<u16>, Vec<u8>) {
    let mut cumulative = vec![0u16; frequencies.len()];
    let mut symbols = vec![0u8; model_count * scale];
    for model in 0..model_count {
        let mut sum = 0usize;
        for symbol in 0..symbol_count {
            let index = model * symbol_count + symbol;
            let frequency = usize::from(frequencies.get(index).copied().unwrap_or(0));
            if let Some(slot) = cumulative.get_mut(index) {
                *slot = sum as u16; // Uint16Array storage.
            }
            // TypedArray.prototype.fill clamps the range.
            let start = (model * scale + sum).min(symbols.len());
            let end = (model * scale + sum + frequency).min(symbols.len());
            symbols[start..end].fill(symbol as u8);
            sum += frequency;
        }
    }
    (cumulative, symbols)
}

/// `decode`: decodes an encoded chain; `None` if the data is truncated or
/// malformed (the embedded chain is neither).
fn decode(encoded: &str) -> Option<MarkovChain> {
    let bytes = decode_base91(encoded);
    let level_count = usize::from(*bytes.first()?);
    let model_count = usize::from(*bytes.get(1)?);
    let scale_bits = *bytes.get(2)?;
    if model_count == 0 || scale_bits > 30 {
        return None;
    }
    let scale = 1usize << scale_bits;
    let mut offset = 4;

    let mut probabilities = vec![0f32; level_count + 1];
    probabilities[0] = UNSEEN_PROBABILITY as f32;
    for probability in probabilities.iter_mut().skip(1) {
        *probability = read_f32(&bytes, offset)?;
        offset += 4;
    }

    // Uint16Array storage: the derived last frequency wraps modulo 2^16.
    let mut data_frequencies = vec![0u16; model_count * (level_count + 1)];
    for model in 0..model_count {
        let mut sum = 0usize;
        for symbol in 0..level_count {
            let frequency = read_u16(&bytes, offset)?;
            offset += 2;
            data_frequencies[model * (level_count + 1) + symbol] = frequency;
            sum += usize::from(frequency);
        }
        data_frequencies[model * (level_count + 1) + level_count] = scale.wrapping_sub(sum) as u16;
    }

    let mut model_frequencies = vec![0u16; model_count];
    let mut model_frequency_sum = 0usize;
    for frequency in model_frequencies.iter_mut().take(model_count - 1) {
        *frequency = read_u16(&bytes, offset)?;
        offset += 2;
        model_frequency_sum += usize::from(*frequency);
    }
    model_frequencies[model_count - 1] = scale.wrapping_sub(model_frequency_sum) as u16;
    let model_stream_length = read_u32(&bytes, offset)? as usize;
    offset += 4;

    let (model_cumulative, model_symbols) =
        make_entropy_tables(&model_frequencies, 1, model_count, scale);
    let mut model_decoder = RansDecoder::new(&bytes, offset, scale as u64, model_count)?;
    let mut column_models = vec![0u8; ALPHABET_SIZE * ALPHABET_SIZE];
    for column in column_models.iter_mut() {
        *column = model_decoder.read(0, &model_frequencies, &model_cumulative, &model_symbols)?;
    }

    let (data_cumulative, data_symbols) =
        make_entropy_tables(&data_frequencies, model_count, level_count + 1, scale);
    let mut data_decoder = RansDecoder::new(
        &bytes,
        offset + model_stream_length,
        scale as u64,
        level_count + 1,
    )?;
    let mut probability_codes = vec![0u8; ALPHABET_SIZE * ALPHABET_SIZE * ALPHABET_SIZE];
    for second in 0..ALPHABET_SIZE {
        for character in 0..ALPHABET_SIZE {
            let model = usize::from(column_models[second * ALPHABET_SIZE + character]);
            for first in 0..ALPHABET_SIZE {
                probability_codes[(first * ALPHABET_SIZE + second) * ALPHABET_SIZE + character] =
                    data_decoder.read(model, &data_frequencies, &data_cumulative, &data_symbols)?;
            }
        }
    }

    Some(MarkovChain {
        depth: DEPTH,
        probability_codes,
        probabilities,
    })
}

/// `load()`: decodes the chain that ships with quicktype.
pub fn load() -> MarkovChain {
    decode(ENCODED_MARKOV_CHAIN.trim_end()).expect("the embedded Markov chain decodes")
}

/// The chain that ships with quicktype, decoded once (`InferMaps` caches
/// `load()` the same way).
pub fn shared() -> &'static MarkovChain {
    static CHAIN: LazyLock<MarkovChain> = LazyLock::new(load);
    &CHAIN
}

/// `characterIndexes[code]`, where codes from 128 up read `undefined`, which
/// compares like -1.
fn character_index(unit: u16) -> i32 {
    CHARACTER_INDEXES
        .get(usize::from(unit))
        .map_or(-1, |&i| i32::from(i))
}

/// The probability of the trigram ending at `third`, or the unseen
/// probability.
fn score(mc: &MarkovChain, first: i32, second: i32, third: i32) -> f64 {
    if first >= 0 && second >= 0 && third >= 0 {
        let prefix = first as usize * ALPHABET_SIZE + second as usize;
        let code = mc
            .probability_codes
            .get(prefix * ALPHABET_SIZE + third as usize)
            .copied()
            .unwrap_or(0);
        if code != 0 {
            return mc
                .probabilities
                .get(usize::from(code))
                .map_or(f64::NAN, |&p| f64::from(p));
        }
    }
    UNSEEN_PROBABILITY
}

/// The loop `evaluate` and `evaluateFull` share: walks the trigrams of
/// `word`'s UTF-16 code units, passes each score to `on_score` and returns
/// their product, multiplied left to right.
fn trigram_product(mc: &MarkovChain, word: &str, mut on_score: impl FnMut(f64)) -> f64 {
    let mut units = word.encode_utf16();
    // `characterIndexes[word.charCodeAt(i)]` is undefined past the end,
    // which compares like -1.
    let mut first = units.next().map_or(-1, character_index);
    let mut second = units.next().map_or(-1, character_index);
    let mut probability = 1.0;
    for unit in units {
        let third = character_index(unit);
        let score = score(mc, first, second, third);
        on_score(score);
        probability *= score;
        first = second;
        second = third;
    }
    probability
}

/// `evaluateFull(mc, word)`: the geometric mean of the trigram probabilities
/// of `word`, and the individual probabilities. Words shorter than three
/// UTF-16 code units score 1.
pub fn evaluate_full(mc: &MarkovChain, word: &str) -> (f64, Vec<f64>) {
    if utf16::len(word) < mc.depth {
        return (1.0, Vec::new());
    }
    let mut scores = Vec::new();
    let probability = trigram_product(mc, word, |score| scores.push(score));
    (number::pow(probability, 1.0 / scores.len() as f64), scores)
}

/// `evaluate(mc, word)`: the geometric mean of the trigram probabilities of
/// `word`; see [`evaluate_full`].
pub fn evaluate(mc: &MarkovChain, word: &str) -> f64 {
    let length = utf16::len(word);
    if length < mc.depth {
        return 1.0;
    }
    let probability = trigram_product(mc, word, |_| {});
    number::pow(probability, 1.0 / (length as f64 - 2.0))
}

/// `SubTrie`: one slot of a training [`Trie`].
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SubTrie {
    /// No sequence went through this slot (`null`).
    Null,
    /// The number of sequences ending here.
    Count(u64),
    /// Longer sequences.
    Trie(Box<Trie>),
}

/// `Trie`: training counts, indexed by ASCII code (non-ASCII units count
/// as code 0).
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Trie {
    /// One slot per code 0..128.
    pub arr: Vec<SubTrie>,
    /// The number of sequences counted directly in this node's slots.
    pub count: u64,
}

impl Trie {
    fn new() -> Self {
        Trie {
            arr: vec![SubTrie::Null; 128],
            count: 0,
        }
    }

    fn to_json(&self) -> JsonValue {
        let arr = self
            .arr
            .iter()
            .map(|slot| match slot {
                SubTrie::Null => JsonValue::Null,
                SubTrie::Count(n) => JsonValue::Number(*n as f64),
                SubTrie::Trie(trie) => trie.to_json(),
            })
            .collect();
        let mut object = IndexMap::new();
        object.insert("count".to_owned(), JsonValue::Number(self.count as f64));
        object.insert("arr".to_owned(), JsonValue::Array(arr));
        JsonValue::Object(object)
    }
}

/// `TrainingMarkovChain`: the result of [`train`].
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct TrainingMarkovChain {
    /// The sequence length counted.
    pub depth: usize,
    /// The counts.
    pub trie: Trie,
}

impl TrainingMarkovChain {
    /// `JSON.stringify(mc)`, as `quicktype --build-markov-chain` prints it.
    pub fn to_json(&self) -> String {
        let mut object = IndexMap::new();
        object.insert("trie".to_owned(), self.trie.to_json());
        object.insert("depth".to_owned(), JsonValue::Number(self.depth as f64));
        json::stringify(&JsonValue::Object(object), None)
    }
}

/// `increment(t, seq, i)`.
fn increment(t: &mut Trie, seq: &[u16], i: usize) {
    let Some(&unit) = seq.get(i) else {
        // Only for an empty sequence (depth 0), where JavaScript stores the
        // count under a "NaN" property that JSON never shows.
        t.count += 1;
        return;
    };
    let first = if unit >= 128 { 0 } else { usize::from(unit) };

    if i + 1 >= seq.len() {
        match &mut t.arr[first] {
            slot @ SubTrie::Null => *slot = SubTrie::Count(1),
            SubTrie::Count(n) => *n += 1,
            // "Malformed trie": impossible, all sequences have one length.
            SubTrie::Trie(_) => return,
        }
        t.count += 1;
        return;
    }

    if let SubTrie::Null = t.arr[first] {
        t.arr[first] = SubTrie::Trie(Box::new(Trie::new()));
    }
    if let SubTrie::Trie(sub) = &mut t.arr[first] {
        increment(sub, seq, i + 1);
    }
}

/// `train(lines, depth)`: counts every `depth`-unit substring of the lines.
pub fn train(lines: &[&str], depth: usize) -> TrainingMarkovChain {
    let mut trie = Trie::new();
    for line in lines {
        let units: Vec<u16> = line.encode_utf16().collect();
        for i in depth..=units.len() {
            increment(&mut trie, &units[i - depth..i], 0);
        }
    }
    TrainingMarkovChain { depth, trie }
}

/// `generate(mc, state, unseenWeight)`: draws the character that follows the
/// two-unit `state`, using `random` in place of `Math.random`. `None` where
/// TypeScript fails an assertion (`state` is not two UTF-16 units long, or
/// `random` returns values outside `[0, 1)`).
pub fn generate(
    mc: &MarkovChain,
    state: &str,
    unseen_weight: f64,
    mut random: impl FnMut() -> f64,
) -> Option<String> {
    let units: Vec<u16> = state.encode_utf16().collect();
    if units.len() + 1 != mc.depth {
        return None;
    }
    let mut random_int = |lower: f64, upper: f64| lower + (random() * (upper - lower)).floor();
    let from_char_code = |code: f64| char::from_u32(code as u32).map(String::from);

    let first = character_index(units[0]);
    let second = character_index(units[1]);
    if first < 0 || second < 0 {
        return from_char_code(random_int(32.0, 127.0));
    }

    let prefix = first as usize * ALPHABET_SIZE + second as usize;
    let mut weights = [0f64; 128];
    let mut total = 0.0;
    for (code, weight) in weights.iter_mut().enumerate() {
        let index = CHARACTER_INDEXES[code];
        let probability_code = if index < 0 {
            0
        } else {
            mc.probability_codes
                .get(prefix * ALPHABET_SIZE + index as usize)
                .copied()
                .unwrap_or(0)
        };
        *weight = if probability_code == 0 {
            if code == 0 { 0.0 } else { unseen_weight }
        } else {
            mc.probabilities
                .get(usize::from(probability_code))
                .map_or(f64::NAN, |&p| f64::from(p))
                * 1_000_000.0
        };
        total += *weight;
    }

    let choice = random_int(0.0, total);
    let mut sum = 0.0;
    for (code, weight) in weights.iter().enumerate() {
        sum += weight;
        if choice < sum {
            return from_char_code(code as f64);
        }
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    // Ported from test/unit/markov-chain.test.ts, describe("Markov chain").

    /// "decodes the compact probability table"
    #[test]
    fn decodes_the_compact_probability_table() {
        let chain = load();
        assert_eq!(chain.probability_codes.len(), 65usize.pow(3));
        assert_eq!(chain.probabilities.len(), 6);
        assert!((f64::from(chain.probabilities[0]) - 0.0001).abs() < 0.5e-2);
    }

    /// "keeps representative inference scores stable"
    #[test]
    fn keeps_representative_inference_scores_stable() {
        let chain = load();
        let (probability, scores) = evaluate_full(&chain, "contactInformation");
        assert_eq!(probability, 0.10493792217669691);
        assert_eq!(
            scores,
            [
                0.1738850325345993,
                0.043580953031778336,
                0.1738850325345993,
                0.043580953031778336,
                0.1738850325345993,
                0.0008568746852688491,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
                0.1738850325345993,
            ]
        );
        assert_eq!(evaluate(&chain, "contactInformation"), probability);
    }

    /// "treats non-corpus characters as unseen"
    #[test]
    fn treats_non_corpus_characters_as_unseen() {
        let chain = load();
        assert_eq!(
            evaluate_full(&chain, "aébc"),
            (0.0001, vec![0.0001, 0.0001])
        );
        assert_eq!(evaluate(&chain, "id"), 1.0);
    }

    /// "scores representative property names"
    #[test]
    fn scores_representative_property_names() {
        let chain = load();
        let words = [
            "url",
            "json",
            "my_property",
            "ordinary",
            "different",
            "189512",
            "2BTZIqw0ntH9MvilQ3ewNY",
            "0uBTNdNGb2OY5lou41iYL52LcDq2",
            "-KpqHmWuDOUnr1hmAhxp",
            "granularity",
            "coverage",
            "postingFrequency",
            "dataFrequency",
            "units",
            "datasetOwner",
            "organization",
            "timePeriod",
            "contactInformation",
            "\u{1f6be} \u{1f192} \u{1f193} \u{1f195} \u{1f196} \u{1f197} \u{1f199} \u{1f3e7}",
        ];
        for word in words {
            let probability = evaluate(&chain, word);
            assert!(probability.is_finite(), "{word}");
            assert!(probability > 0.0, "{word}");
        }
    }

    /// "preserves map-inference decisions near the score boundary"
    #[test]
    fn preserves_map_inference_decisions_near_the_score_boundary() {
        let chain = load();
        let score = |names: &[&str]| {
            let product = names
                .iter()
                .fold(1.0, |product, name| product * evaluate(&chain, name));
            number::pow(product, 1.0 / names.len() as f64)
        };
        let limit = |property_count: usize| {
            let exponent = 5.0;
            let scale = number::pow(22.0, exponent);
            number::pow(property_count as f64 + 2.0, exponent) / scale
                + (0.0025 - number::pow(3.0, exponent) / scale)
        };
        let original_classes: [&[&str]; 3] = [
            &[
                "designation",
                "discovery_date",
                "h_mag",
                "i_deg",
                "moid_au",
                "orbit_class",
                "period_yr",
                "pha",
                "q_au_1",
                "q_au_2",
            ],
            &[
                "id",
                "name",
                "dataTypeName",
                "description",
                "fieldName",
                "position",
                "renderTypeName",
                "tableColumnId",
                "width",
                "cachedContents",
                "format",
            ],
            &[
                "product",
                "totallooseoffers",
                "schk",
                "match",
                "details",
                "page",
                "totalpages",
                "totalresultsreturned",
                "totalresultsavailable",
                "category",
            ],
        ];
        let closest_map = [
            "ita_contact_email",
            "company_name",
            "company_phone",
            "company_address",
            "company_website",
            "company_description",
            "company_email",
            "ita_office",
            "contact_title",
            "contact_name",
            "category",
        ];

        for names in original_classes {
            assert!(score(names) > limit(names.len()));
        }
        assert!(score(&closest_map) < limit(closest_map.len()));
    }

    #[test]
    fn trains_counts_as_json() {
        let chain = train(&["abcd"], 3);
        let json = chain.to_json();
        assert!(json.starts_with(r#"{"trie":{"count":0,"arr":[null,"#));
        assert!(json.ends_with(r#"]},"depth":3}"#));
    }

    #[test]
    fn generate_requires_a_two_unit_state() {
        assert_eq!(generate(shared(), "abc", 0.0, || 0.5), None);
    }
}
