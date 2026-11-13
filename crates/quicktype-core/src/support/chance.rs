//! Port of `packages/quicktype-core/src/support/Chance.ts`.
//!
//! quicktype's seeded random generator: a Mersenne Twister (MT19937) and the
//! few `chance.js` functions quicktype uses (`city()`, `animal()`). It feeds
//! the random type names of `TooManyTypeNames`, so it must be bit-exact and
//! consumed in exactly the same order as in TypeScript. The word lists are
//! generated from the TypeScript source into `chance_data.rs` by
//! `xtask/core-type-graph/gen-chance-data.mjs`.

#[allow(clippy::all)]
mod data {
    include!("chance_data.rs");
}

const N: usize = 624;
const M: usize = 397;
const MATRIX_A: u32 = 0x9908_b0df;
const UPPER_MASK: u32 = 0x8000_0000;
const LOWER_MASK: u32 = 0x7fff_ffff;

/// MT19937, as in the `MersenneTwister` class of `Chance.ts`.
#[derive(Clone, Debug)]
struct MersenneTwister {
    mt: Box<[u32; N]>,
    mti: usize,
}

impl MersenneTwister {
    fn new(seed: u32) -> Self {
        let mut twister = MersenneTwister {
            mt: Box::new([0; N]),
            mti: N + 1,
        };
        twister.init_genrand(seed);
        twister
    }

    fn init_genrand(&mut self, seed: u32) {
        self.mt[0] = seed;
        for i in 1..N {
            let s = self.mt[i - 1] ^ (self.mt[i - 1] >> 30);
            self.mt[i] = 1_812_433_253u32.wrapping_mul(s).wrapping_add(i as u32);
        }
        self.mti = N;
    }

    fn genrand_int32(&mut self) -> u32 {
        let mag01 = [0u32, MATRIX_A];
        if self.mti >= N {
            if self.mti == N + 1 {
                self.init_genrand(5489);
            }
            let mut kk = 0;
            while kk < N - M {
                let y = (self.mt[kk] & UPPER_MASK) | (self.mt[kk + 1] & LOWER_MASK);
                self.mt[kk] = self.mt[kk + M] ^ (y >> 1) ^ mag01[(y & 1) as usize];
                kk += 1;
            }
            while kk < N - 1 {
                let y = (self.mt[kk] & UPPER_MASK) | (self.mt[kk + 1] & LOWER_MASK);
                self.mt[kk] = self.mt[kk + M - N] ^ (y >> 1) ^ mag01[(y & 1) as usize];
                kk += 1;
            }
            let y = (self.mt[N - 1] & UPPER_MASK) | (self.mt[0] & LOWER_MASK);
            self.mt[N - 1] = self.mt[M - 1] ^ (y >> 1) ^ mag01[(y & 1) as usize];
            self.mti = 0;
        }

        let mut y = self.mt[self.mti];
        self.mti += 1;
        y ^= y >> 11;
        y ^= (y << 7) & 0x9d2c_5680;
        y ^= (y << 15) & 0xefc6_0000;
        y ^= y >> 18;
        y
    }

    /// A number in `[0, 1)`.
    fn random(&mut self) -> f64 {
        f64::from(self.genrand_int32()) * (1.0 / 4_294_967_296.0)
    }
}

/// The `Chance` class of `Chance.ts`: a seeded generator of random cities and
/// animals.
#[derive(Clone, Debug)]
pub struct Chance {
    mt: MersenneTwister,
}

impl Chance {
    /// A generator seeded with `seed` (`new Chance(seed)`).
    pub fn new(seed: u32) -> Self {
        Chance {
            mt: MersenneTwister::new(seed),
        }
    }

    /// `random()`: a number in `[0, 1)`.
    pub fn random(&mut self) -> f64 {
        self.mt.random()
    }

    /// `integer({min, max})`, both bounds included.
    pub fn integer(&mut self, min: f64, max: f64) -> f64 {
        (self.random() * (max - min + 1.0) + min).floor()
    }

    /// `natural({max})`.
    pub fn natural(&mut self, max: f64) -> f64 {
        self.integer(0.0, max)
    }

    /// `pick(arr)`. Returns `None` for an empty slice, where `chance.js`
    /// throws a `RangeError`.
    pub fn pick<'a, T>(&mut self, items: &'a [T]) -> Option<&'a T> {
        if items.is_empty() {
            return None;
        }
        let index = self.natural((items.len() - 1) as f64);
        items.get(index as usize)
    }

    /// `animal()`: a random animal of a random animal type.
    pub fn animal(&mut self) -> &'static str {
        let kind = self.pick(data::ANIMAL_TYPES).copied().unwrap_or("");
        self.pick(data::animals(kind)).copied().unwrap_or("")
    }

    /// `city()`: a random city.
    pub fn city(&mut self) -> &'static str {
        self.pick(data::CITIES).copied().unwrap_or("")
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::support::js_shim::number_to_string;

    /// `chance.txt` is generated from the reference implementation by
    /// `xtask/core-type-graph/gen-fixtures.mjs`.
    #[test]
    fn matches_reference_sequence() {
        let fixture = include_str!("../../tests/fixtures/core-type-graph/chance.txt");
        let mut names = Chance::new(31415);
        let mut raw = Chance::new(1);
        for line in fixture.lines() {
            if let Some(expected) = line.strip_prefix("random ") {
                assert_eq!(number_to_string(raw.random()), expected);
            } else {
                let name = format!("{} {}", names.city(), names.animal());
                assert_eq!(name, line);
            }
        }
    }
}
