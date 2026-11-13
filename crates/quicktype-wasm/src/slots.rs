//! Tables of values the facade refers to by id: the runs in flight
//! ([`crate::start`]), the compressed JSON samples
//! ([`crate::samples`]) and the runs' hold on them.
//!
//! An id is a slot and that slot's *generation*, which counts how often
//! the slot was emptied. Freed slots are reused, but never with an id
//! that was handed out before: an id kept after its value was removed (by
//! the facade, or by a stale callback) finds nothing, never the value that
//! took its slot later. Ids are JavaScript numbers, exact up to 2^53: the
//! slot is in the low [`SLOT_BITS`] bits and the generation, up to 2^32 - 1,
//! above them; a slot whose generation is used up is retired.

/// Bits of an id that are the slot.
const SLOT_BITS: u32 = 21;

/// The most slots in use at once.
const MAX_SLOTS: usize = 1 << SLOT_BITS;

struct Entry<T> {
    generation: u32,
    value: Option<T>,
}

/// Values by id (see the module documentation).
pub struct Slots<T> {
    entries: Vec<Entry<T>>,
    /// Empty slots that can be reused, last freed last.
    free: Vec<u32>,
    len: usize,
}

impl<T> Default for Slots<T> {
    fn default() -> Self {
        Self::new()
    }
}

impl<T> Slots<T> {
    pub const fn new() -> Self {
        Slots {
            entries: Vec::new(),
            free: Vec::new(),
            len: 0,
        }
    }

    /// How many values there are.
    pub fn len(&self) -> usize {
        self.len
    }

    pub fn is_empty(&self) -> bool {
        self.len == 0
    }

    /// Whether every slot is taken: [`insert`](Self::insert) would give its
    /// value back.
    pub fn is_full(&self) -> bool {
        self.free.is_empty() && self.entries.len() >= MAX_SLOTS
    }

    /// Adds `value`; returns its id, or gives `value` back if all
    /// [`MAX_SLOTS`] slots are taken.
    pub fn insert(&mut self, value: T) -> Result<f64, T> {
        let slot = match self.free.pop() {
            Some(slot) => slot as usize,
            None if self.entries.len() < MAX_SLOTS => {
                self.entries.push(Entry {
                    generation: 0,
                    value: None,
                });
                self.entries.len() - 1
            }
            None => return Err(value),
        };
        let entry = &mut self.entries[slot];
        entry.value = Some(value);
        self.len += 1;
        Ok(id(slot, entry.generation))
    }

    /// The slot of `id`, if its value is still there.
    fn slot(&self, id: f64) -> Option<usize> {
        let (slot, generation) = split(id)?;
        let entry = self.entries.get(slot)?;
        (entry.generation == generation && entry.value.is_some()).then_some(slot)
    }

    pub fn get(&self, id: f64) -> Option<&T> {
        let slot = self.slot(id)?;
        self.entries[slot].value.as_ref()
    }

    pub fn get_mut(&mut self, id: f64) -> Option<&mut T> {
        let slot = self.slot(id)?;
        self.entries[slot].value.as_mut()
    }

    /// Takes the value of `id` out; its id is never valid again.
    pub fn remove(&mut self, id: f64) -> Option<T> {
        let slot = self.slot(id)?;
        let entry = &mut self.entries[slot];
        let value = entry.value.take();
        self.len -= 1;
        if entry.generation < u32::MAX {
            entry.generation += 1;
            self.free.push(slot as u32);
        }
        value
    }
}

fn id(slot: usize, generation: u32) -> f64 {
    (u64::from(generation) << SLOT_BITS | slot as u64) as f64
}

/// The slot and generation of `id`, if it is one.
fn split(id: f64) -> Option<(usize, u32)> {
    // Below 2^53, every whole number is exact.
    if !(0.0..9_007_199_254_740_992.0).contains(&id) || id.fract() != 0.0 {
        return None;
    }
    let id = id as u64;
    Some((
        (id & (MAX_SLOTS as u64 - 1)) as usize,
        (id >> SLOT_BITS) as u32,
    ))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_reused_slot_gets_a_new_id() {
        let mut slots = Slots::new();
        let a = slots.insert("a").unwrap();
        let b = slots.insert("b").unwrap();
        assert_eq!(slots.remove(a), Some("a"));
        assert_eq!(slots.remove(a), None);
        let c = slots.insert("c").unwrap();
        assert_ne!(c, a);
        assert_eq!(split(c).unwrap().0, split(a).unwrap().0);
        assert_eq!(slots.get(a), None);
        assert_eq!(slots.get(c), Some(&"c"));
        assert_eq!(slots.get(b), Some(&"b"));
        *slots.get_mut(b).unwrap() = "B";
        assert_eq!(slots.remove(b), Some("B"));
        assert_eq!(slots.len(), 1);
        for bad in [-1.0, 0.5, f64::NAN, f64::INFINITY, 1e300] {
            assert_eq!(slots.get(bad), None);
        }
    }

    #[test]
    fn a_used_up_slot_is_retired() {
        let mut slots = Slots::new();
        let a = slots.insert(1).unwrap();
        slots.entries[0].generation = u32::MAX;
        let a_last = id(0, u32::MAX);
        slots.entries[0].value = Some(2);
        assert_eq!(slots.remove(a_last), Some(2));
        assert_eq!(slots.get(a), None);
        // Not reused: the next value takes a new slot.
        let b = slots.insert(3).unwrap();
        assert_eq!(split(b), Some((1, 0)));
        assert!(id(MAX_SLOTS - 1, u32::MAX) < 9_007_199_254_740_992.0);
    }

    #[test]
    fn a_full_table_gives_the_value_back() {
        let mut slots = Slots::new();
        let mut ids = Vec::new();
        while !slots.is_full() {
            ids.push(slots.insert(()).unwrap());
        }
        assert_eq!(ids.len(), MAX_SLOTS);
        assert_eq!(slots.insert(()), Err(()));
        slots.remove(ids[7]);
        assert!(!slots.is_full());
        assert!(slots.insert(()).is_ok());
        assert!(slots.is_full());
    }
}
