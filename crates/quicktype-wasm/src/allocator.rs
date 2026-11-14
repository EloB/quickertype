//! The global allocator of the WebAssembly engine: small blocks from slabs
//! of their own size, everything else from Rust's own allocator (dlmalloc),
//! which grows the memory ahead of need.
//!
//! # Small blocks
//!
//! Nearly all of the engine's allocations are small: of the 14,500 in a
//! run on pokedex (82 KB of JSON), 98% are of 256 bytes or less and almost
//! half of 8 bytes or less. dlmalloc is slow at those in WebAssembly: it
//! merges every freed chunk with its free neighbours and files the result
//! in its bins (sorted trees from 256 bytes up), and the next allocation
//! takes that apart again. Its `malloc` and `free` and their helpers took
//! about a sixth of a warm pokedex run in Chrome.
//!
//! So blocks of up to [`SMALL_MAX`] bytes (aligned to at most 8) come from
//! *slabs*: blocks of 64 KiB that this allocator takes from dlmalloc,
//! aligned to 64 KiB, each cut into blocks of one size (a multiple of 8). A
//! slab starts with a [`Slab`] header, so the slab of a block is its
//! address rounded down to 64 KiB. A freed block goes on its slab's free
//! list, and an allocation of its size takes the first free block of the
//! size's first slab, or the slab's next untouched one: a few loads and
//! stores, without searching or merging.
//!
//! Each size has a list of its slabs that have room. A slab that fills up
//! leaves the list when an allocation finds it full, and goes back to the
//! front of it when one of its blocks is freed. A slab whose blocks are all
//! free leaves its list for a pool of empty slabs, which any size takes
//! from (the lowest first) before asking dlmalloc for a new one. The pool
//! keeps the [`POOL`] lowest of them and gives the others back to dlmalloc,
//! so the slabs it holds sit low in the heap, out of the way of large
//! blocks. What a large run used for small blocks is free for anything
//! once the blocks are freed, and the memory grows about as far as with
//! dlmalloc alone (docs/BENCHMARKS.md, "Small blocks from slabs").
//!
//! A slab is 8 bytes short of 64 KiB: dlmalloc puts a chunk's 8-byte header
//! before it, so slabs taken one after the other from the top of the heap
//! lie back to back, with nothing left over between them.
//!
//! # Growing the memory
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
//! Where objects go changes nothing a run computes: no output depends on
//! addresses.
//!
//! With the `heap-stats` feature, it also counts the bytes in use and
//! their peak ([`in_use`], [`peak`]): the memory itself never shrinks, so
//! only these show what the engine holds and what an operation needed.
//! They count the bytes callers asked for, not the slabs. Counting costs
//! about 2% of a run's time, so release builds leave it out.

// A global allocator cannot be written without unsafe code (`GlobalAlloc`
// is an unsafe trait, and it calls `System`'s unsafe methods): the one
// module in the workspace that allows it, against the workspace's `deny`
// (Cargo.toml, [workspace.lints.rust]).
#![allow(unsafe_code)]

use std::alloc::{GlobalAlloc, Layout, System};
use std::arch::wasm32::memory_size;
use std::cell::UnsafeCell;
use std::ptr::null_mut;
use std::sync::atomic::AtomicU32;
#[cfg(feature = "heap-stats")]
use std::sync::atomic::AtomicUsize;
use std::sync::atomic::Ordering;

/// The WebAssembly page size.
const PAGE: usize = 64 * 1024;

/// The largest block that comes from a slab.
const SMALL_MAX: usize = 256;

/// The sizes of small blocks: 8, 16, ..., [`SMALL_MAX`] bytes.
const CLASSES: usize = SMALL_MAX / 8;

/// A slab's size and alignment.
const SLAB: usize = 64 * 1024;

/// The bytes of a slab asked of dlmalloc (see the module documentation).
const SLAB_BYTES: usize = SLAB - 8;

/// How a slab is allocated from dlmalloc.
const SLAB_LAYOUT: Layout = match Layout::from_size_align(SLAB_BYTES, SLAB) {
    Ok(layout) => layout,
    Err(_) => panic!("the slab layout"),
};

/// How many empty slabs the pool keeps.
const POOL: usize = 32;

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

/// Whether a block comes from a slab.
#[inline(always)]
fn is_small(size: usize, align: usize) -> bool {
    size <= SMALL_MAX && align <= 8
}

/// The size class of a small block of `size` bytes (not 0).
#[inline(always)]
fn class(size: usize) -> usize {
    (size - 1) >> 3
}

/// The start of a slab, cut into blocks of one size.
#[repr(C)]
struct Slab {
    /// The first freed block (each holds the address of the next).
    free: *mut u8,
    /// The next block never handed out.
    bump: usize,
    /// The last address a block can start at.
    limit: usize,
    /// The size of the blocks.
    size: usize,
    /// How many blocks are handed out.
    used: u32,
    /// Whether the slab is on its size's list.
    listed: bool,
    /// The neighbours on that list.
    next: *mut Slab,
    prev: *mut Slab,
}

/// Where blocks start in a slab: after the header, aligned to 8.
const FIRST: usize = (std::mem::size_of::<Slab>() + 7) & !7;

/// The slabs of every size, and the pool.
struct Slabs {
    /// Each size's slabs not known to be full, the one last started or
    /// freed into first.
    lists: [*mut Slab; CLASSES],
    /// Empty slabs, for any size: the lowest ones.
    pool: [*mut Slab; POOL],
    pooled: usize,
}

/// [`Slabs`], for the one thread a `wasm32-unknown-unknown` instance has.
struct SlabsCell(UnsafeCell<Slabs>);

// SAFETY: the engine is built without the `atomics` target feature: one
// thread, and allocations do not reenter the allocator.
unsafe impl Sync for SlabsCell {}

// The slabs have no lock.
#[cfg(target_feature = "atomics")]
compile_error!("the engine's allocator assumes a single thread (no `atomics`)");

static SLABS: SlabsCell = SlabsCell(UnsafeCell::new(Slabs {
    lists: [null_mut(); CLASSES],
    pool: [null_mut(); POOL],
    pooled: 0,
}));

impl Slabs {
    /// The allocator's slabs.
    ///
    /// # Safety
    ///
    /// No other reference to them is alive (the allocator's methods do not
    /// call each other while they hold one).
    #[inline(always)]
    #[allow(clippy::mut_from_ref)]
    unsafe fn get() -> &'static mut Slabs {
        // SAFETY: the caller's contract.
        unsafe { &mut *SLABS.0.get() }
    }

    /// A block of size class `c`, or null if there is no memory for a slab.
    #[inline(always)]
    unsafe fn alloc(&mut self, c: usize) -> *mut u8 {
        let s = self.lists[c];
        if !s.is_null() {
            // SAFETY: a listed slab is live.
            if let Some(block) = unsafe { Self::take(s) } {
                return block;
            }
        }
        // SAFETY: as for `take`.
        unsafe { self.alloc_slow(c) }
    }

    /// A block of slab `s`, if it has room.
    ///
    /// # Safety
    ///
    /// `s` is a live slab.
    #[inline(always)]
    unsafe fn take(s: *mut Slab) -> Option<*mut u8> {
        // SAFETY: the caller's contract; a free block holds the address of
        // the next.
        unsafe {
            let block = (*s).free;
            if !block.is_null() {
                (*s).free = *block.cast::<*mut u8>();
                (*s).used += 1;
                return Some(block);
            }
            let bump = (*s).bump;
            if bump <= (*s).limit {
                (*s).bump = bump + (*s).size;
                (*s).used += 1;
                return Some(bump as *mut u8);
            }
            None
        }
    }

    /// The size's first slab is full or there is none: drops full slabs
    /// from its list, and starts a slab when none is left.
    #[cold]
    #[inline(never)]
    unsafe fn alloc_slow(&mut self, c: usize) -> *mut u8 {
        // SAFETY: listed and pooled slabs are live.
        unsafe {
            loop {
                let s = self.lists[c];
                if s.is_null() {
                    break;
                }
                if let Some(block) = Self::take(s) {
                    return block;
                }
                // Full: off the list until one of its blocks is freed.
                self.lists[c] = (*s).next;
                if !(*s).next.is_null() {
                    (*(*s).next).prev = null_mut();
                }
                (*s).listed = false;
                (*s).next = null_mut();
            }
            let s = if self.pooled == 0 {
                let before = memory_size::<0>();
                let slab = System.alloc(SLAB_LAYOUT);
                GrowAhead::after(before);
                if slab.is_null() {
                    return null_mut();
                }
                slab.cast::<Slab>()
            } else {
                // The lowest.
                let pool = &mut self.pool[..self.pooled];
                let mut low = 0;
                for (i, &p) in pool.iter().enumerate() {
                    if p < pool[low] {
                        low = i;
                    }
                }
                let s = pool[low];
                pool[low] = pool[pool.len() - 1];
                self.pooled -= 1;
                s
            };
            let size = (c + 1) * 8;
            let first = s as usize + FIRST;
            s.write(Slab {
                free: null_mut(),
                bump: first + size,
                limit: s as usize + SLAB_BYTES - size,
                size,
                used: 1,
                listed: true,
                next: null_mut(),
                prev: null_mut(),
            });
            self.lists[c] = s;
            first as *mut u8
        }
    }

    /// Frees `block`, of size class `c`.
    ///
    /// # Safety
    ///
    /// `block` came from [`Slabs::alloc`] with `c` and is not freed yet.
    #[inline(always)]
    unsafe fn free(&mut self, block: *mut u8, c: usize) {
        // SAFETY: the caller's contract: the block lies in a live slab,
        // whose header is at the block's address rounded down to a slab.
        unsafe {
            let s = (block as usize & !(SLAB - 1)) as *mut Slab;
            block.cast::<*mut u8>().write((*s).free);
            (*s).free = block;
            (*s).used -= 1;
            if !(*s).listed || (*s).used == 0 {
                self.freed_into(s, c);
            }
        }
    }

    /// A block was freed into slab `s` (of size class `c`), which was full
    /// or is now empty: back on its list, or off to the pool or dlmalloc.
    #[cold]
    #[inline(never)]
    unsafe fn freed_into(&mut self, s: *mut Slab, c: usize) {
        // SAFETY: `s` and the slabs on its list are live.
        unsafe {
            if !(*s).listed {
                let head = self.lists[c];
                (*s).next = head;
                (*s).prev = null_mut();
                if !head.is_null() {
                    (*head).prev = s;
                }
                self.lists[c] = s;
                (*s).listed = true;
                if (*s).used != 0 {
                    return;
                }
            }
            // Empty: off its list.
            if (*s).prev.is_null() {
                self.lists[c] = (*s).next;
            } else {
                (*(*s).prev).next = (*s).next;
            }
            if !(*s).next.is_null() {
                (*(*s).next).prev = (*s).prev;
            }
            // Into the pool, which keeps the lowest empty slabs; the highest
            // goes back to dlmalloc.
            if self.pooled < POOL {
                self.pool[self.pooled] = s;
                self.pooled += 1;
                return;
            }
            let mut high = s;
            for p in &mut self.pool {
                if *p > high {
                    std::mem::swap(p, &mut high);
                }
            }
            System.dealloc(high.cast(), SLAB_LAYOUT);
        }
    }
}

/// Small blocks from slabs, the rest from [`System`] (dlmalloc), growing
/// the memory geometrically (see the module documentation).
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

// SAFETY: small blocks come from slabs, which hand out each block once
// until it is freed, aligned to 8 and in memory dlmalloc gave the slab;
// other calls go to `System` with the caller's arguments, and growing ahead
// only allocates and frees a block of its own.
unsafe impl GlobalAlloc for GrowAhead {
    #[inline]
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let ptr = if is_small(layout.size(), layout.align()) {
            // SAFETY: no other reference to the slabs is alive.
            unsafe { Slabs::get().alloc(class(layout.size())) }
        } else {
            let before = memory_size::<0>();
            // SAFETY: the caller's contract.
            let ptr = unsafe { System.alloc(layout) };
            Self::after(before);
            ptr
        };
        if !ptr.is_null() {
            count(layout.size());
        }
        ptr
    }

    #[inline]
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        if is_small(layout.size(), layout.align()) {
            // SAFETY: the caller's contract; a block from a slab may hold
            // what was freed in it.
            unsafe {
                let ptr = self.alloc(layout);
                if !ptr.is_null() {
                    ptr.write_bytes(0, layout.size());
                }
                return ptr;
            }
        }
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc_zeroed(layout) };
        if !ptr.is_null() {
            count(layout.size());
        }
        Self::after(before);
        ptr
    }

    #[inline]
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        count(layout.size().wrapping_neg());
        if is_small(layout.size(), layout.align()) {
            // SAFETY: the caller's contract: `ptr` came from `alloc` with
            // this layout, so from a slab of its size class.
            unsafe { Slabs::get().free(ptr, class(layout.size())) }
        } else {
            // SAFETY: the caller's contract.
            unsafe { System.dealloc(ptr, layout) }
        }
    }

    #[inline]
    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        let small = is_small(layout.size(), layout.align());
        let new_small = is_small(new_size, layout.align());
        if small && new_small && class(new_size) == class(layout.size()) {
            count(new_size.wrapping_sub(layout.size()));
            return ptr;
        }
        if !small && !new_small {
            let before = memory_size::<0>();
            // SAFETY: the caller's contract.
            let new = unsafe { System.realloc(ptr, layout, new_size) };
            if !new.is_null() {
                count(new_size.wrapping_sub(layout.size()));
            }
            Self::after(before);
            return new;
        }
        // Into or out of a slab: copied.
        // SAFETY: the caller's contract (a non-zero `new_size` that does
        // not overflow with the alignment); the blocks do not overlap.
        unsafe {
            let new = self.alloc(Layout::from_size_align_unchecked(new_size, layout.align()));
            if !new.is_null() {
                ptr.copy_to_nonoverlapping(new, layout.size().min(new_size));
                self.dealloc(ptr, layout);
            }
            new
        }
    }
}

#[global_allocator]
static ALLOCATOR: GrowAhead = GrowAhead;
