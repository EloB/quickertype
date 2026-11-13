// The decoder of the shipped Markov chain: `decode` of
// `packages/quicktype-core/src/MarkovChain.ts` and its helpers.
//
// This is a module of `markov_chain`, and the crate's build script
// `include!`s it to decode the chain ahead of time (see
// `markov_chain::shared`). So it uses only `core` and `std`, and its
// comments are not inner doc comments.

/// The size of the chain's alphabet (`markov_chain::ALPHABET`).
pub const ALPHABET_SIZE: usize = 65;
/// The probability of a trigram the chain has not seen.
pub const UNSEEN_PROBABILITY: f64 = 0.0001;
const BASE91_ALPHABET: &[u8] =
    b"!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}";
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

/// `decode`: decodes an encoded chain into its probability codes and
/// probability levels (see [`MarkovChain`](super::MarkovChain)); `None` if
/// the data is truncated or malformed (the embedded chain is neither).
pub fn decode(encoded: &str) -> Option<(Vec<u8>, Vec<f32>)> {
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

    Some((probability_codes, probabilities))
}
