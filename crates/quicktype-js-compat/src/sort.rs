//! Sorting exactly like JavaScript: UTF-16 string order and V8's
//! `Array.prototype.sort`.
//!
//! Two things make JavaScript sorting differ from Rust's:
//!
//! - **String order.** JavaScript compares strings by UTF-16 code units; Rust
//!   compares `str`s by UTF-8 bytes, i.e. by code point. The two disagree when
//!   a character above U+FFFF meets one in U+E000–U+FFFF: JavaScript puts the
//!   astral character first (its high surrogate, U+D800–U+DBFF, is smaller).
//!   Use [`compare_utf16`].
//! - **The algorithm.** V8 sorts with a stable TimSort
//!   (`third_party/v8/builtins/array-sort.tq`). For a consistent comparator
//!   every stable sort gives the same result, but quicktype has comparators
//!   that are not consistent (mixing numbers and strings under JavaScript's
//!   `<`), and then only V8's exact sequence of comparisons reproduces its
//!   output. [`sort_by`] is a faithful port of that TimSort; unlike
//!   [`slice::sort_by`], it never panics on an inconsistent comparator.

use std::cmp::Ordering;

/// Compares two strings the way JavaScript's `<`/`>` and the default
/// `Array.prototype.sort()` do: by UTF-16 code units.
pub fn compare_utf16(a: &str, b: &str) -> Ordering {
    let mut a_chars = a.chars();
    let mut b_chars = b.chars();
    loop {
        match (a_chars.next(), b_chars.next()) {
            (None, None) => return Ordering::Equal,
            (None, Some(_)) => return Ordering::Less,
            (Some(_), None) => return Ordering::Greater,
            (Some(x), Some(y)) if x == y => {}
            (Some(x), Some(y)) => return utf16_key(x).cmp(&utf16_key(y)),
        }
    }
}

/// The UTF-16 encoding of `c`, padded with 0 for a BMP character. Comparing
/// keys compares the code-unit sequences: the first units always differ
/// between a BMP and an astral character, since BMP characters are never
/// surrogates.
fn utf16_key(c: char) -> [u16; 2] {
    let mut units = [0; 2];
    c.encode_utf16(&mut units);
    units
}

/// The result of a sort comparator.
///
/// V8 converts a comparator's return value to a number, treats `NaN` as 0 and
/// only ever asks whether it is negative, so that is all this trait exposes.
pub trait CompareResult {
    /// Whether the result counts as "less than" (`order < 0`).
    fn is_less(&self) -> bool;
}

impl CompareResult for Ordering {
    fn is_less(&self) -> bool {
        *self == Ordering::Less
    }
}

impl CompareResult for f64 {
    /// `NaN` is not less than 0, exactly as V8 maps it to 0.
    fn is_less(&self) -> bool {
        *self < 0.0
    }
}

macro_rules! compare_result_for_signed {
    ($($t:ty),*) => {$(
        impl CompareResult for $t {
            fn is_less(&self) -> bool {
                *self < 0
            }
        }
    )*};
}
compare_result_for_signed!(i8, i16, i32, i64, isize);

/// `Array.prototype.sort(comparefn)` as V8 implements it: a stable TimSort
/// that calls `compare` in exactly the same sequence as V8 does.
///
/// `compare(a, b)` returns a negative result if `a` sorts before `b`. Any
/// comparator is accepted, including inconsistent ones; the result then
/// matches V8's, and this never panics. (JavaScript's `undefined` elements and
/// holes, which V8 moves to the end without comparing, have no counterpart
/// here.)
pub fn sort_by<T, R, F>(v: &mut [T], mut compare: F)
where
    R: CompareResult,
    F: FnMut(&T, &T) -> R,
{
    if v.len() < 2 {
        return;
    }
    let order = {
        let elements: &[T] = v;
        let mut sort = TimSort {
            work: (0..elements.len()).collect(),
            temp: Vec::new(),
            runs: Vec::new(),
            min_gallop: MIN_GALLOP_WINS,
            less: |a: usize, b: usize| compare(&elements[a], &elements[b]).is_less(),
        };
        sort.sort();
        sort.work
    };
    apply_permutation(v, order);
}

/// `Array.prototype.sort()` without a comparator, for strings: ascending
/// UTF-16 code-unit order, stable.
pub fn sort_strings<S: AsRef<str>>(v: &mut [S]) {
    sort_by(v, |a, b| compare_utf16(a.as_ref(), b.as_ref()));
}

/// Reorders `v` so that position `k` holds the element that was at
/// `order[k]`.
fn apply_permutation<T>(v: &mut [T], mut order: Vec<usize>) {
    const DONE: usize = usize::MAX;
    for start in 0..order.len() {
        if order[start] == DONE {
            continue;
        }
        let mut j = start;
        loop {
            let next = order[j];
            order[j] = DONE;
            if next == start || next == DONE {
                break;
            }
            v.swap(j, next);
            j = next;
        }
    }
}

/// `kMinGallopWins`: the initial galloping threshold.
const MIN_GALLOP_WINS: usize = 7;

#[derive(Clone, Copy)]
struct Run {
    base: usize,
    len: usize,
}

/// State of one sort (V8's `SortState`). The work array holds indices into the
/// caller's slice; `less(a, b)` is `Compare(a, b) < 0`.
struct TimSort<L> {
    work: Vec<usize>,
    temp: Vec<usize>,
    runs: Vec<Run>,
    min_gallop: usize,
    less: L,
}

/// How a merge finished (the `Succeed` / `CopyA` / `CopyB` labels in V8).
enum MergeExit {
    Succeed,
    CopyRest,
}

/// `ComputeMinRunLength`.
fn compute_min_run_length(mut n: usize) -> usize {
    let mut r = 0; // Becomes 1 if any 1 bits are shifted off.
    while n >= 64 {
        r |= n & 1;
        n >>= 1;
    }
    n + r
}

impl<L: FnMut(usize, usize) -> bool> TimSort<L> {
    /// `ArrayTimSortImpl`.
    fn sort(&mut self) {
        let length = self.work.len();
        if length < 2 {
            return;
        }
        let mut remaining = length;
        let mut low = 0;
        let min_run_length = compute_min_run_length(remaining);
        while remaining != 0 {
            let mut current_run_length = self.count_and_make_run(low, low + remaining);
            if current_run_length < min_run_length {
                let forced_run_length = min_run_length.min(remaining);
                self.binary_insertion_sort(low, low + current_run_length, low + forced_run_length);
                current_run_length = forced_run_length;
            }
            self.runs.push(Run {
                base: low,
                len: current_run_length,
            });
            self.merge_collapse();
            low += current_run_length;
            remaining -= current_run_length;
        }
        self.merge_force_collapse();
    }

    /// `CountAndMakeRun`: the length of the run starting at `low_arg`; a
    /// strictly descending run is reversed in place.
    fn count_and_make_run(&mut self, low_arg: usize, high: usize) -> usize {
        let low = low_arg + 1;
        if low == high {
            return 1;
        }
        let mut run_length = 2;
        let element_low = self.work[low];
        let element_low_pre = self.work[low - 1];
        let is_descending = (self.less)(element_low, element_low_pre);

        let mut previous_element = element_low;
        for idx in low + 1..high {
            let current_element = self.work[idx];
            let order_is_less = (self.less)(current_element, previous_element);
            if is_descending {
                if !order_is_less {
                    break;
                }
            } else if order_is_less {
                break;
            }
            previous_element = current_element;
            run_length += 1;
        }

        if is_descending {
            self.work[low_arg..low_arg + run_length].reverse();
        }
        run_length
    }

    /// `BinaryInsertionSort`: sorts `[low, high)` given that `[low, start)` is
    /// already sorted.
    fn binary_insertion_sort(&mut self, low: usize, start_arg: usize, high: usize) {
        let mut start = if low == start_arg {
            start_arg + 1
        } else {
            start_arg
        };
        while start < high {
            let mut left = low;
            let mut right = start;
            let pivot = self.work[start];
            while left < right {
                let mid = left + ((right - left) >> 1);
                if (self.less)(pivot, self.work[mid]) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            self.work.copy_within(left..start, left + 1);
            self.work[left] = pivot;
            start += 1;
        }
    }

    /// `RunInvariantEstablished`: `len(n - 2) > len(n - 1) + len(n)`.
    fn run_invariant_established(&self, n: usize) -> bool {
        if n < 2 {
            return true;
        }
        let a = self.runs[n - 2].len;
        let b = self.runs[n - 1].len;
        let c = self.runs[n].len;
        a > b + c
    }

    /// `MergeCollapse`.
    fn merge_collapse(&mut self) {
        while self.runs.len() > 1 {
            let mut n = self.runs.len() - 2;
            if !self.run_invariant_established(n + 1) || !self.run_invariant_established(n) {
                // Only reachable with n >= 1: both checks pass for n == 0.
                if n > 0 && self.runs[n - 1].len < self.runs[n + 1].len {
                    n -= 1;
                }
                self.merge_at(n);
            } else if self.runs[n].len <= self.runs[n + 1].len {
                self.merge_at(n);
            } else {
                break;
            }
        }
    }

    /// `MergeForceCollapse`.
    fn merge_force_collapse(&mut self) {
        while self.runs.len() > 1 {
            let mut n = self.runs.len() - 2;
            if n > 0 && self.runs[n - 1].len < self.runs[n + 1].len {
                n -= 1;
            }
            self.merge_at(n);
        }
    }

    /// `MergeAt`: merges the runs at stack indices `i` and `i + 1`.
    fn merge_at(&mut self, i: usize) {
        let Run {
            base: mut base_a,
            len: mut length_a,
        } = self.runs[i];
        let Run {
            base: base_b,
            len: mut length_b,
        } = self.runs[i + 1];
        self.runs[i].len = length_a + length_b;
        self.runs.remove(i + 1);

        // Where does b start in a? Elements in a before that are in place.
        let key_right = self.work[base_b];
        let k = gallop_right(&mut self.less, &self.work, key_right, base_a, length_a, 0);
        base_a += k;
        length_a -= k;
        if length_a == 0 {
            return;
        }

        // Where does a end in b? Elements in b after that are in place.
        let key_left = self.work[base_a + length_a - 1];
        length_b = gallop_left(
            &mut self.less,
            &self.work,
            key_left,
            base_b,
            length_b,
            length_b - 1,
        );
        if length_b == 0 {
            return;
        }

        if length_a <= length_b {
            self.merge_low(base_a, length_a, base_b, length_b);
        } else {
            self.merge_high(base_a, length_a, base_b, length_b);
        }
    }

    /// `MergeLow`: merges `[base_a, base_a + length_a)` and the following
    /// `length_b` elements left to right, buffering run A.
    fn merge_low(
        &mut self,
        base_a: usize,
        mut length_a: usize,
        base_b: usize,
        mut length_b: usize,
    ) {
        self.temp.clear();
        self.temp
            .extend_from_slice(&self.work[base_a..base_a + length_a]);

        let mut dest = base_a;
        let mut cursor_temp = 0;
        let mut cursor_b = base_b;

        self.work[dest] = self.work[cursor_b];
        dest += 1;
        cursor_b += 1;

        let exit = 'merge: {
            length_b -= 1;
            if length_b == 0 {
                break 'merge MergeExit::Succeed;
            }
            if length_a == 1 {
                break 'merge MergeExit::CopyRest;
            }

            let mut min_gallop = self.min_gallop;
            loop {
                let mut nof_wins_a = 0; // # of times A won in a row.
                let mut nof_wins_b = 0; // # of times B won in a row.

                // Straightforward merging until one run wins consistently.
                loop {
                    if (self.less)(self.work[cursor_b], self.temp[cursor_temp]) {
                        self.work[dest] = self.work[cursor_b];
                        dest += 1;
                        cursor_b += 1;
                        nof_wins_b += 1;
                        length_b -= 1;
                        nof_wins_a = 0;
                        if length_b == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                        if nof_wins_b >= min_gallop {
                            break;
                        }
                    } else {
                        self.work[dest] = self.temp[cursor_temp];
                        dest += 1;
                        cursor_temp += 1;
                        nof_wins_a += 1;
                        length_a -= 1;
                        nof_wins_b = 0;
                        if length_a == 1 {
                            break 'merge MergeExit::CopyRest;
                        }
                        if nof_wins_a >= min_gallop {
                            break;
                        }
                    }
                }

                // Gallop until neither run wins consistently anymore.
                min_gallop += 1;
                let mut first_iteration = true;
                while nof_wins_a >= MIN_GALLOP_WINS
                    || nof_wins_b >= MIN_GALLOP_WINS
                    || first_iteration
                {
                    first_iteration = false;
                    min_gallop = min_gallop.saturating_sub(1).max(1);
                    self.min_gallop = min_gallop;

                    let key = self.work[cursor_b];
                    nof_wins_a =
                        gallop_right(&mut self.less, &self.temp, key, cursor_temp, length_a, 0);
                    if nof_wins_a > 0 {
                        self.work[dest..dest + nof_wins_a]
                            .copy_from_slice(&self.temp[cursor_temp..cursor_temp + nof_wins_a]);
                        dest += nof_wins_a;
                        cursor_temp += nof_wins_a;
                        length_a -= nof_wins_a;
                        if length_a == 1 {
                            break 'merge MergeExit::CopyRest;
                        }
                        // Impossible for a consistent comparator, but possible here.
                        if length_a == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                    }
                    self.work[dest] = self.work[cursor_b];
                    dest += 1;
                    cursor_b += 1;
                    length_b -= 1;
                    if length_b == 0 {
                        break 'merge MergeExit::Succeed;
                    }

                    let key = self.temp[cursor_temp];
                    nof_wins_b =
                        gallop_left(&mut self.less, &self.work, key, cursor_b, length_b, 0);
                    if nof_wins_b > 0 {
                        self.work.copy_within(cursor_b..cursor_b + nof_wins_b, dest);
                        dest += nof_wins_b;
                        cursor_b += nof_wins_b;
                        length_b -= nof_wins_b;
                        if length_b == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                    }
                    self.work[dest] = self.temp[cursor_temp];
                    dest += 1;
                    cursor_temp += 1;
                    length_a -= 1;
                    if length_a == 1 {
                        break 'merge MergeExit::CopyRest;
                    }
                }
                min_gallop += 1; // Penalize it for leaving galloping mode.
                self.min_gallop = min_gallop;
            }
        };

        match exit {
            MergeExit::Succeed => {
                if length_a > 0 {
                    self.work[dest..dest + length_a]
                        .copy_from_slice(&self.temp[cursor_temp..cursor_temp + length_a]);
                }
            }
            MergeExit::CopyRest => {
                // The last element of run A belongs at the end of the merge.
                self.work.copy_within(cursor_b..cursor_b + length_b, dest);
                self.work[dest + length_b] = self.temp[cursor_temp];
            }
        }
    }

    /// `MergeHigh`: merges right to left, buffering run B.
    ///
    /// V8's `dest`, `cursorA` and `cursorTemp` point at the next slot and may
    /// reach -1; here they are kept as exclusive ends (`V8 value + 1`).
    fn merge_high(
        &mut self,
        base_a: usize,
        mut length_a: usize,
        base_b: usize,
        mut length_b: usize,
    ) {
        self.temp.clear();
        self.temp
            .extend_from_slice(&self.work[base_b..base_b + length_b]);

        let mut dest = base_b + length_b;
        let mut cursor_temp = length_b;
        let mut cursor_a = base_a + length_a;

        dest -= 1;
        cursor_a -= 1;
        self.work[dest] = self.work[cursor_a];

        let exit = 'merge: {
            length_a -= 1;
            if length_a == 0 {
                break 'merge MergeExit::Succeed;
            }
            if length_b == 1 {
                break 'merge MergeExit::CopyRest;
            }

            let mut min_gallop = self.min_gallop;
            loop {
                let mut nof_wins_a = 0; // # of times A won in a row.
                let mut nof_wins_b = 0; // # of times B won in a row.

                // Straightforward merging until one run wins consistently.
                loop {
                    if (self.less)(self.temp[cursor_temp - 1], self.work[cursor_a - 1]) {
                        dest -= 1;
                        cursor_a -= 1;
                        self.work[dest] = self.work[cursor_a];
                        nof_wins_a += 1;
                        length_a -= 1;
                        nof_wins_b = 0;
                        if length_a == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                        if nof_wins_a >= min_gallop {
                            break;
                        }
                    } else {
                        dest -= 1;
                        cursor_temp -= 1;
                        self.work[dest] = self.temp[cursor_temp];
                        nof_wins_b += 1;
                        length_b -= 1;
                        nof_wins_a = 0;
                        if length_b == 1 {
                            break 'merge MergeExit::CopyRest;
                        }
                        if nof_wins_b >= min_gallop {
                            break;
                        }
                    }
                }

                // Gallop until neither run wins consistently anymore.
                min_gallop += 1;
                let mut first_iteration = true;
                while nof_wins_a >= MIN_GALLOP_WINS
                    || nof_wins_b >= MIN_GALLOP_WINS
                    || first_iteration
                {
                    first_iteration = false;
                    min_gallop = min_gallop.saturating_sub(1).max(1);
                    self.min_gallop = min_gallop;

                    let key = self.temp[cursor_temp - 1];
                    let k = gallop_right(
                        &mut self.less,
                        &self.work,
                        key,
                        base_a,
                        length_a,
                        length_a - 1,
                    );
                    nof_wins_a = length_a - k;
                    if nof_wins_a > 0 {
                        dest -= nof_wins_a;
                        cursor_a -= nof_wins_a;
                        self.work.copy_within(cursor_a..cursor_a + nof_wins_a, dest);
                        length_a -= nof_wins_a;
                        if length_a == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                    }
                    dest -= 1;
                    cursor_temp -= 1;
                    self.work[dest] = self.temp[cursor_temp];
                    length_b -= 1;
                    if length_b == 1 {
                        break 'merge MergeExit::CopyRest;
                    }

                    let key = self.work[cursor_a - 1];
                    let k = gallop_left(&mut self.less, &self.temp, key, 0, length_b, length_b - 1);
                    nof_wins_b = length_b - k;
                    if nof_wins_b > 0 {
                        dest -= nof_wins_b;
                        cursor_temp -= nof_wins_b;
                        self.work[dest..dest + nof_wins_b]
                            .copy_from_slice(&self.temp[cursor_temp..cursor_temp + nof_wins_b]);
                        length_b -= nof_wins_b;
                        if length_b == 1 {
                            break 'merge MergeExit::CopyRest;
                        }
                        // Impossible for a consistent comparator, but possible here.
                        if length_b == 0 {
                            break 'merge MergeExit::Succeed;
                        }
                    }
                    dest -= 1;
                    cursor_a -= 1;
                    self.work[dest] = self.work[cursor_a];
                    length_a -= 1;
                    if length_a == 0 {
                        break 'merge MergeExit::Succeed;
                    }
                }
                min_gallop += 1;
                self.min_gallop = min_gallop;
            }
        };

        match exit {
            MergeExit::Succeed => {
                if length_b > 0 {
                    self.work[dest - length_b..dest].copy_from_slice(&self.temp[..length_b]);
                }
            }
            MergeExit::CopyRest => {
                // The first element of run B belongs at the front of the merge.
                dest -= length_a;
                cursor_a -= length_a;
                self.work.copy_within(cursor_a..cursor_a + length_a, dest);
                self.work[dest - 1] = self.temp[cursor_temp - 1];
            }
        }
    }
}

/// `offset = (offset << 1) + 1` (0, 1, 3, 7, 15, ...), falling back to
/// `max_ofs` on overflow as V8 does.
fn next_offset(offset: usize, max_ofs: usize) -> usize {
    offset
        .checked_mul(2)
        .and_then(|o| o.checked_add(1))
        .unwrap_or(max_ofs)
}

/// `GallopLeft`: the position `k` in the sorted `array[base..base + length]`
/// where `key` belongs, left of any equal elements:
/// `array[base + k - 1] < key <= array[base + k]`. `hint` (in
/// `0..length`) is where to start searching.
fn gallop_left<L: FnMut(usize, usize) -> bool>(
    less: &mut L,
    array: &[usize],
    key: usize,
    base: usize,
    length: usize,
    hint: usize,
) -> usize {
    let mut last_ofs: usize = 0;
    let mut offset: usize = 1;

    let (lo, hi) = if less(array[base + hint], key) {
        // a[hint] < key: gallop right until a[hint + lastOfs] < key <= a[hint + offset].
        let max_ofs = length - hint;
        while offset < max_ofs {
            if !less(array[base + hint + offset], key) {
                break;
            }
            last_ofs = offset;
            offset = next_offset(offset, max_ofs);
        }
        offset = offset.min(max_ofs);
        // Translate back to positive offsets relative to base.
        (hint + last_ofs + 1, hint + offset)
    } else {
        // key <= a[hint]: gallop left until a[hint - offset] < key <= a[hint - lastOfs].
        let max_ofs = hint + 1;
        while offset < max_ofs {
            if less(array[base + hint - offset], key) {
                break;
            }
            last_ofs = offset;
            offset = next_offset(offset, max_ofs);
        }
        offset = offset.min(max_ofs);
        // V8's lastOfs = hint - offset may be -1; the search starts one higher.
        (hint + 1 - offset, hint - last_ofs)
    };

    // Binary search with invariant a[lo - 1] < key <= a[hi].
    let (mut lo, mut hi) = (lo, hi);
    while lo < hi {
        let m = lo + ((hi - lo) >> 1);
        if less(array[base + m], key) {
            lo = m + 1;
        } else {
            hi = m;
        }
    }
    hi
}

/// `GallopRight`: like [`gallop_left`], but right of any equal elements:
/// `array[base + k - 1] <= key < array[base + k]`.
fn gallop_right<L: FnMut(usize, usize) -> bool>(
    less: &mut L,
    array: &[usize],
    key: usize,
    base: usize,
    length: usize,
    hint: usize,
) -> usize {
    let mut last_ofs: usize = 0;
    let mut offset: usize = 1;

    let (lo, hi) = if less(key, array[base + hint]) {
        // key < a[hint]: gallop left until a[hint - offset] <= key < a[hint - lastOfs].
        let max_ofs = hint + 1;
        while offset < max_ofs {
            if !less(key, array[base + hint - offset]) {
                break;
            }
            last_ofs = offset;
            offset = next_offset(offset, max_ofs);
        }
        offset = offset.min(max_ofs);
        (hint + 1 - offset, hint - last_ofs)
    } else {
        // a[hint] <= key: gallop right until a[hint + lastOfs] <= key < a[hint + offset].
        let max_ofs = length - hint;
        while offset < max_ofs {
            if less(key, array[base + hint + offset]) {
                break;
            }
            last_ofs = offset;
            offset = next_offset(offset, max_ofs);
        }
        offset = offset.min(max_ofs);
        (hint + last_ofs + 1, hint + offset)
    };

    // Binary search with invariant a[lo - 1] <= key < a[hi].
    let (mut lo, mut hi) = (lo, hi);
    while lo < hi {
        let m = lo + ((hi - lo) >> 1);
        if less(key, array[base + m]) {
            hi = m;
        } else {
            lo = m + 1;
        }
    }
    hi
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn utf16_order_puts_astral_before_high_bmp() {
        assert_eq!(compare_utf16("\u{FF61}", "\u{1F600}"), Ordering::Greater);
        assert_eq!(compare_utf16("a", "b"), Ordering::Less);
        assert_eq!(compare_utf16("ab", "a"), Ordering::Greater);
        assert_eq!(compare_utf16("", ""), Ordering::Equal);
        let mut v = vec!["\u{FF61}", "\u{1F600}", "b", "a"];
        sort_strings(&mut v);
        assert_eq!(v, ["a", "b", "\u{1F600}", "\u{FF61}"]);
    }

    #[test]
    fn stable_for_consistent_comparators() {
        let mut v: Vec<(u32, usize)> = (0..1000).map(|i| ((i * 7919 % 13) as u32, i)).collect();
        let mut expected = v.clone();
        expected.sort_by_key(|&(k, _)| k);
        sort_by(&mut v, |a, b| a.0.cmp(&b.0));
        assert_eq!(v, expected);
    }

    #[test]
    fn never_panics_on_inconsistent_comparators() {
        let mut state = 0x2545_F491_u32;
        for n in [0, 1, 2, 3, 63, 64, 65, 200, 1000] {
            let mut v: Vec<usize> = (0..n).collect();
            sort_by(&mut v, |_, _| {
                state ^= state << 13;
                state ^= state >> 17;
                state ^= state << 5;
                f64::from(state % 3) - 1.0
            });
            let mut sorted = v.clone();
            sorted.sort_unstable();
            assert_eq!(
                sorted,
                (0..n).collect::<Vec<_>>(),
                "result is a permutation"
            );
        }
    }

    #[test]
    fn nan_counts_as_equal() {
        let mut v = vec![3, 1, 2];
        sort_by(&mut v, |_, _| f64::NAN);
        assert_eq!(v, [3, 1, 2]);
    }
}
