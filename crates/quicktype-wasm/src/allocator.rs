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

#![allow(unsafe_code)]

use std::alloc::{GlobalAlloc, Layout, System};
use std::arch::wasm32::memory_size;
use std::sync::atomic::{AtomicU32, Ordering};

/// The WebAssembly page size.
const PAGE: usize = 64 * 1024;

/// How often the memory grew (for the facade's tests).
static GROWTHS: AtomicU32 = AtomicU32::new(0);

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
        Self::after(before);
        ptr
    }

    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc_zeroed(layout) };
        Self::after(before);
        ptr
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        // SAFETY: the caller's contract.
        unsafe { System.dealloc(ptr, layout) }
    }

    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.realloc(ptr, layout, new_size) };
        Self::after(before);
        ptr
    }
}

#[global_allocator]
static ALLOCATOR: GrowAhead = GrowAhead;
