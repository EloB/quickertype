//! The global allocator of the WebAssembly engine: Rust's own (dlmalloc),
//! growing the memory ahead of need.
//!
//! dlmalloc asks for more memory (`memory.grow`) in steps just large enough
//! for the allocation at hand, 64 KiB at a time. In V8 every `memory.grow`
//! costs about half a millisecond (several milliseconds once the memory is
//! past 2 GiB): a run that builds a heap of gigabytes, such as one that
//! renders millions of lines, grew it tens of thousands of times and spent
//! most of its time there, more the larger the heap (superlinear). So after
//! any allocation that grew the memory, this allocator grows it once more by
//! a quarter of its size, by allocating a block that large and freeing it
//! at once: dlmalloc merges the block into the top of its heap and takes
//! later allocations from there. The memory then grows geometrically, a few
//! dozen times on the way to gigabytes. The extra pages cost nothing until
//! they are used (V8 commits them on first touch), and if growing ahead
//! fails (near the 4 GiB limit) nothing happens.
//!
//! Allocations themselves are dlmalloc's, so where objects go and what a
//! run computes are unchanged.
//!
//! With the `heap-stats` feature, it also counts the bytes in use and
//! their peak ([`in_use`], [`peak`]): the memory itself never shrinks, so
//! only these show what the engine holds and what an operation needed.
//! Counting costs about 2% of a run's time, so release builds leave it out.

#![allow(unsafe_code)]

use std::alloc::{GlobalAlloc, Layout, System};
use std::arch::wasm32::memory_size;
use std::sync::atomic::AtomicU32;
#[cfg(feature = "heap-stats")]
use std::sync::atomic::AtomicUsize;
use std::sync::atomic::Ordering;

/// The WebAssembly page size.
const PAGE: usize = 64 * 1024;

/// How often the memory grew (for the facade's tests).
static GROWTHS: AtomicU32 = AtomicU32::new(0);

/// Bytes allocated and not freed (as the callers asked for them), and the
/// most there were since [`reset_peak`] (`heap-stats` only).
#[cfg(feature = "heap-stats")]
static IN_USE: AtomicUsize = AtomicUsize::new(0);
#[cfg(feature = "heap-stats")]
static PEAK: AtomicUsize = AtomicUsize::new(0);

/// Bytes allocated and not freed.
#[cfg(feature = "heap-stats")]
pub fn in_use() -> usize {
    IN_USE.load(Ordering::Relaxed)
}

/// The most bytes in use at once since [`reset_peak`] (or the start).
#[cfg(feature = "heap-stats")]
pub fn peak() -> usize {
    PEAK.load(Ordering::Relaxed)
}

/// Starts measuring [`peak`] from the bytes in use now.
#[cfg(feature = "heap-stats")]
pub fn reset_peak() {
    PEAK.store(in_use(), Ordering::Relaxed);
}

/// Counts `added` bytes more in use (wrapping: a negative change).
#[cfg(feature = "heap-stats")]
fn count(added: usize) {
    let now = IN_USE.load(Ordering::Relaxed).wrapping_add(added);
    IN_USE.store(now, Ordering::Relaxed);
    if now > PEAK.load(Ordering::Relaxed) {
        PEAK.store(now, Ordering::Relaxed);
    }
}

#[cfg(not(feature = "heap-stats"))]
#[inline(always)]
fn count(_: usize) {}

/// How often the memory grew since the instance started: allocations
/// during which it grew (dlmalloc grows it at most once per allocation),
/// and growing ahead when that grew it.
pub fn growths() -> u32 {
    GROWTHS.load(Ordering::Relaxed)
}

/// [`System`], growing the memory geometrically (see the module documentation).
pub struct GrowAhead;

impl GrowAhead {
    /// After an allocation during which the memory grew from `pages_before`
    /// pages: grows it by a quarter more, if possible.
    fn after(pages_before: usize) {
        let pages = memory_size::<0>();
        if pages == pages_before {
            return;
        }
        GROWTHS.fetch_add(1, Ordering::Relaxed);
        // A quarter of the memory, in pages first: 65,536 pages (4 GiB)
        // times the page size would overflow `usize`.
        let bytes = (pages / 4).saturating_mul(PAGE);
        if bytes == 0 {
            return;
        }
        let Ok(reserve) = Layout::from_size_align(bytes, 16) else {
            return;
        };
        // SAFETY: a non-zero-sized layout; the block is freed with the same
        // layout.
        unsafe {
            let block = System.alloc(reserve);
            if !block.is_null() {
                // dlmalloc may have had room for it already.
                if memory_size::<0>() != pages {
                    GROWTHS.fetch_add(1, Ordering::Relaxed);
                }
                System.dealloc(block, reserve);
            }
        }
    }
}

// SAFETY: every call goes to `System` with the caller's arguments; growing
// ahead only allocates and frees a block of its own.
unsafe impl GlobalAlloc for GrowAhead {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc(layout) };
        if !ptr.is_null() {
            count(layout.size());
        }
        Self::after(before);
        ptr
    }

    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc_zeroed(layout) };
        if !ptr.is_null() {
            count(layout.size());
        }
        Self::after(before);
        ptr
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        count(layout.size().wrapping_neg());
        // SAFETY: the caller's contract.
        unsafe { System.dealloc(ptr, layout) }
    }

    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let new = unsafe { System.realloc(ptr, layout, new_size) };
        if !new.is_null() {
            count(new_size.wrapping_sub(layout.size()));
        }
        Self::after(before);
        new
    }
}

#[global_allocator]
static ALLOCATOR: GrowAhead = GrowAhead;
