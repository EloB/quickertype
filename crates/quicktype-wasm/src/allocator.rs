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
//! *slabs*: blocks of 16 KiB that this allocator takes from dlmalloc,
//! aligned to 16 KiB, each cut into blocks of one size (a multiple of 8). A
//! slab starts with a [`Slab`] header, so the slab of a block is its
//! address rounded down to 16 KiB. A freed block goes on its slab's free
//! list. An allocation takes the first free block of its size's current
//! slab, or the slab's next untouched one: a few loads and stores, without
//! searching or merging.
//!
//! Each size has a list of its slabs that have room, the current one first.
//! When the current slab fills up, it leaves the list, and the fullest of
//! the next [`PICK`] becomes current: allocations go where blocks are
//! already in use, and the emptier slabs get a chance to empty. A full slab
//! goes back on the list, second, when one of its blocks is freed. A slab
//! whose blocks are all free leaves its list for a pool of empty slabs,
//! unless it is its size's last one (so that allocating and freeing one
//! block over and over stays on the fast paths). Any size takes from the
//! pool, the lowest first, before asking dlmalloc for a new slab. The pool
//! keeps the [`POOL`] lowest and gives the others back to dlmalloc, so the
//! slabs it holds sit low in the heap, out of the way of large blocks. What
//! a large run used for small blocks is free for anything once the blocks
//! are freed, and the memory grows about as far as with dlmalloc alone
//! (docs/BENCHMARKS.md, "Small blocks from slabs").
//!
//! A slab is 8 bytes short of 16 KiB: dlmalloc puts a chunk's 8-byte header
//! before it, so slabs taken one after the other from the top of the heap
//! lie back to back, with nothing left over between them. Each size takes a
//! slab when it is first used, and even a run on `{"a":1}` uses 27 of the
//! 32: with 16 KiB slabs that is 432 KiB (64 KiB slabs were as fast, but
//! held 1.7 MiB after such a run, and the memory over many runs varied
//! more).
//!
//! The slabs and the dispatch between them and dlmalloc ([`Heap`]) build
//! for the host too, where its tests run over the host's allocator.
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
#[cfg(target_arch = "wasm32")]
use std::arch::wasm32::memory_size;
#[cfg(target_arch = "wasm32")]
use std::cell::UnsafeCell;
use std::ptr::null_mut;
#[cfg(target_arch = "wasm32")]
use std::sync::atomic::AtomicU32;
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
use std::sync::atomic::AtomicUsize;
#[cfg(target_arch = "wasm32")]
use std::sync::atomic::Ordering;

/// The WebAssembly page size.
#[cfg(target_arch = "wasm32")]
const PAGE: usize = 64 * 1024;

/// The largest block that comes from a slab.
const SMALL_MAX: usize = 256;

/// The sizes of small blocks: 8, 16, ..., [`SMALL_MAX`] bytes.
const CLASSES: usize = SMALL_MAX / 8;

/// A slab's size and alignment.
const SLAB: usize = 16 * 1024;

/// The bytes of a slab asked of dlmalloc (see the module documentation).
const SLAB_BYTES: usize = SLAB - 8;

/// How a slab is allocated from dlmalloc.
const SLAB_LAYOUT: Layout = match Layout::from_size_align(SLAB_BYTES, SLAB) {
    Ok(layout) => layout,
    Err(_) => panic!("the slab layout"),
};

/// How many empty slabs the pool keeps.
const POOL: usize = 32;

/// How many slabs of a list are compared for the next current one.
const PICK: usize = 8;

/// How often the memory grew (for the facade's tests).
#[cfg(target_arch = "wasm32")]
static GROWTHS: AtomicU32 = AtomicU32::new(0);

/// Bytes allocated and not freed (as the callers asked for them), and the
/// most there were since [`reset_peak`] (`heap-stats` only).
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
static IN_USE: AtomicUsize = AtomicUsize::new(0);
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
static PEAK: AtomicUsize = AtomicUsize::new(0);

/// Bytes allocated and not freed.
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
pub fn in_use() -> usize {
    IN_USE.load(Ordering::Relaxed)
}

/// The most bytes in use at once since [`reset_peak`] (or the start).
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
pub fn peak() -> usize {
    PEAK.load(Ordering::Relaxed)
}

/// Starts measuring [`peak`] from the bytes in use now.
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
pub fn reset_peak() {
    PEAK.store(in_use(), Ordering::Relaxed);
}

/// Counts `added` bytes more in use (wrapping: a negative change).
#[cfg(all(target_arch = "wasm32", feature = "heap-stats"))]
fn count(added: usize) {
    let now = IN_USE.load(Ordering::Relaxed).wrapping_add(added);
    IN_USE.store(now, Ordering::Relaxed);
    if now > PEAK.load(Ordering::Relaxed) {
        PEAK.store(now, Ordering::Relaxed);
    }
}

#[cfg(all(target_arch = "wasm32", not(feature = "heap-stats")))]
#[inline(always)]
fn count(_: usize) {}

/// How often the memory grew since the instance started: allocations
/// during which it grew (dlmalloc grows it at most once per allocation),
/// and growing ahead when that grew it.
#[cfg(target_arch = "wasm32")]
pub fn growths() -> u32 {
    GROWTHS.load(Ordering::Relaxed)
}

/// After an allocation during which the memory grew from `pages_before`
/// pages: grows it by a quarter more, if possible.
#[cfg(target_arch = "wasm32")]
fn grow_ahead(pages_before: usize) {
    let pages = memory_size::<0>();
    if pages == pages_before {
        return;
    }
    GROWTHS.fetch_add(1, Ordering::Relaxed);
    // A quarter of the memory, in pages first: 65,536 pages (4 GiB) times
    // the page size would overflow `usize`.
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

/// [`System`] (dlmalloc in WebAssembly, where it grows the memory ahead).
mod system {
    use super::{GlobalAlloc, Layout, System};
    #[cfg(target_arch = "wasm32")]
    use super::{grow_ahead, memory_size};

    /// `System.alloc`.
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::alloc`].
    #[inline]
    pub(super) unsafe fn alloc(layout: Layout) -> *mut u8 {
        #[cfg(target_arch = "wasm32")]
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc(layout) };
        #[cfg(target_arch = "wasm32")]
        grow_ahead(before);
        ptr
    }

    /// `System.alloc_zeroed`.
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::alloc_zeroed`].
    #[inline]
    pub(super) unsafe fn alloc_zeroed(layout: Layout) -> *mut u8 {
        #[cfg(target_arch = "wasm32")]
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let ptr = unsafe { System.alloc_zeroed(layout) };
        #[cfg(target_arch = "wasm32")]
        grow_ahead(before);
        ptr
    }

    /// `System.realloc`.
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::realloc`].
    #[inline]
    pub(super) unsafe fn realloc(ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        #[cfg(target_arch = "wasm32")]
        let before = memory_size::<0>();
        // SAFETY: the caller's contract.
        let new = unsafe { System.realloc(ptr, layout, new_size) };
        #[cfg(target_arch = "wasm32")]
        grow_ahead(before);
        new
    }

    /// `System.dealloc`.
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::dealloc`].
    #[inline]
    pub(super) unsafe fn dealloc(ptr: *mut u8, layout: Layout) {
        // SAFETY: the caller's contract.
        unsafe { System.dealloc(ptr, layout) }
    }
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

/// Small blocks from slabs, the others from [`System`].
pub(crate) struct Heap {
    /// Each size's slabs with room, the current one first. Only the current
    /// one can be full (until an allocation finds it so).
    lists: [*mut Slab; CLASSES],
    /// Empty slabs, for any size: the lowest ones.
    pool: [*mut Slab; POOL],
    pooled: usize,
    /// Slabs taken from [`System`] and not given back.
    held: usize,
}

impl Heap {
    /// A heap with no slabs.
    pub(crate) const fn new() -> Heap {
        Heap {
            lists: [null_mut(); CLASSES],
            pool: [null_mut(); POOL],
            pooled: 0,
            held: 0,
        }
    }

    /// As [`GlobalAlloc::alloc`].
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::alloc`].
    #[inline]
    pub(crate) unsafe fn alloc(&mut self, layout: Layout) -> *mut u8 {
        if is_small(layout.size(), layout.align()) {
            // SAFETY: a non-zero size (the caller's contract).
            unsafe { self.alloc_small(class(layout.size())) }
        } else {
            // SAFETY: the caller's contract.
            unsafe { system::alloc(layout) }
        }
    }

    /// As [`GlobalAlloc::alloc_zeroed`].
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::alloc_zeroed`].
    #[inline]
    pub(crate) unsafe fn alloc_zeroed(&mut self, layout: Layout) -> *mut u8 {
        if is_small(layout.size(), layout.align()) {
            // SAFETY: the caller's contract; a block from a slab may hold
            // what was freed in it.
            unsafe {
                let ptr = self.alloc_small(class(layout.size()));
                if !ptr.is_null() {
                    ptr.write_bytes(0, layout.size());
                }
                ptr
            }
        } else {
            // SAFETY: the caller's contract.
            unsafe { system::alloc_zeroed(layout) }
        }
    }

    /// As [`GlobalAlloc::dealloc`].
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::dealloc`]: `ptr` came from this heap with `layout`.
    #[inline]
    pub(crate) unsafe fn dealloc(&mut self, ptr: *mut u8, layout: Layout) {
        if is_small(layout.size(), layout.align()) {
            // SAFETY: the caller's contract: `ptr` came from a slab of its
            // size class.
            unsafe { self.free_small(ptr, class(layout.size())) }
        } else {
            // SAFETY: the caller's contract.
            unsafe { system::dealloc(ptr, layout) }
        }
    }

    /// As [`GlobalAlloc::realloc`]: within a size class, the same block;
    /// between sizes above [`SMALL_MAX`], `System`'s `realloc` (which can
    /// grow a block in place); otherwise a new block and a copy.
    ///
    /// # Safety
    ///
    /// As [`GlobalAlloc::realloc`]: `ptr` came from this heap with `layout`.
    #[inline]
    pub(crate) unsafe fn realloc(
        &mut self,
        ptr: *mut u8,
        layout: Layout,
        new_size: usize,
    ) -> *mut u8 {
        let small = is_small(layout.size(), layout.align());
        let new_small = is_small(new_size, layout.align());
        if small && new_small && class(new_size) == class(layout.size()) {
            return ptr;
        }
        if !small && !new_small {
            // SAFETY: the caller's contract.
            return unsafe { system::realloc(ptr, layout, new_size) };
        }
        // Into or out of a slab, or to another size class: copied.
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

    /// A block of size class `c`, or null if there is no memory for a slab.
    ///
    /// # Safety
    ///
    /// `c` is below [`CLASSES`].
    #[inline(always)]
    unsafe fn alloc_small(&mut self, c: usize) -> *mut u8 {
        let s = self.lists[c];
        if !s.is_null() {
            // SAFETY: a listed slab is live; a free block holds the address
            // of the next.
            unsafe {
                let block = (*s).free;
                if !block.is_null() {
                    (*s).free = *block.cast::<*mut u8>();
                    (*s).used += 1;
                    return block;
                }
                let bump = (*s).bump;
                if bump <= (*s).limit {
                    (*s).bump = bump + (*s).size;
                    (*s).used += 1;
                    return bump as *mut u8;
                }
            }
        }
        // SAFETY: as above.
        unsafe { self.alloc_from_next(c) }
    }

    /// The size's current slab is full, or there is none: drops it from
    /// the list, makes the fullest of the next [`PICK`] slabs current (or a
    /// slab from the pool or from `System`), and takes a block from it.
    #[cold]
    #[inline(never)]
    unsafe fn alloc_from_next(&mut self, c: usize) -> *mut u8 {
        // SAFETY: listed and pooled slabs are live; listed slabs other than
        // the current one have room.
        unsafe {
            let full = self.lists[c];
            if !full.is_null() {
                self.unlink(full, c);
                (*full).listed = false;
            }
            let mut s = self.lists[c];
            if s.is_null() {
                s = self.start_slab(c);
                if s.is_null() {
                    return null_mut();
                }
            } else {
                let mut fullest = s;
                let mut other = (*s).next;
                for _ in 1..PICK {
                    if other.is_null() {
                        break;
                    }
                    if (*other).used > (*fullest).used {
                        fullest = other;
                    }
                    other = (*other).next;
                }
                if fullest != s {
                    self.unlink(fullest, c);
                    self.push_front(fullest, c);
                }
                s = fullest;
            }
            // It has room.
            let block = (*s).free;
            if !block.is_null() {
                (*s).free = *block.cast::<*mut u8>();
                (*s).used += 1;
                return block;
            }
            let bump = (*s).bump;
            (*s).bump = bump + (*s).size;
            (*s).used += 1;
            bump as *mut u8
        }
    }

    /// A new current slab for size class `c`, whose list is empty: the
    /// lowest from the pool, or one from `System` (null if there is no
    /// memory for one). It has no blocks handed out yet.
    unsafe fn start_slab(&mut self, c: usize) -> *mut Slab {
        // SAFETY: pooled slabs are live; a new one is a fresh block of
        // `SLAB_LAYOUT`.
        unsafe {
            let s = if self.pooled == 0 {
                let slab = system::alloc(SLAB_LAYOUT);
                if slab.is_null() {
                    return null_mut();
                }
                self.held += 1;
                slab.cast::<Slab>()
            } else {
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
            s.write(Slab {
                free: null_mut(),
                bump: s as usize + FIRST,
                limit: s as usize + SLAB_BYTES - size,
                size,
                used: 0,
                listed: true,
                next: null_mut(),
                prev: null_mut(),
            });
            self.lists[c] = s;
            s
        }
    }

    /// Frees `block`, of size class `c`.
    ///
    /// # Safety
    ///
    /// `block` came from [`Heap::alloc_small`] with `c` and is not freed
    /// yet.
    #[inline(always)]
    unsafe fn free_small(&mut self, block: *mut u8, c: usize) {
        // SAFETY: the caller's contract: the block lies in a live slab,
        // whose header is at the block's address rounded down to a slab.
        unsafe {
            let s = (block as usize & !(SLAB - 1)) as *mut Slab;
            block.cast::<*mut u8>().write((*s).free);
            (*s).free = block;
            let used = (*s).used - 1;
            (*s).used = used;
            // Back on the list, or empty and not the size's last slab.
            if !(*s).listed || (used == 0 && !((*s).prev.is_null() && (*s).next.is_null())) {
                self.freed_into(s, c);
            }
        }
    }

    /// A block was freed into slab `s` (of size class `c`), which was full
    /// or is now empty: back on its list (second), or off to the pool or
    /// `System`, unless it is its size's last slab.
    #[cold]
    #[inline(never)]
    unsafe fn freed_into(&mut self, s: *mut Slab, c: usize) {
        // SAFETY: `s` and the slabs on its list are live.
        unsafe {
            if !(*s).listed {
                let current = self.lists[c];
                if current.is_null() {
                    self.push_front(s, c);
                } else {
                    // After the current slab, which keeps filling.
                    let next = (*current).next;
                    (*s).prev = current;
                    (*s).next = next;
                    (*current).next = s;
                    if !next.is_null() {
                        (*next).prev = s;
                    }
                }
                (*s).listed = true;
                if (*s).used != 0 {
                    return;
                }
            }
            // Empty. The size's last slab stays.
            if (*s).prev.is_null() && (*s).next.is_null() {
                return;
            }
            self.unlink(s, c);
            // Into the pool, which keeps the lowest empty slabs; the highest
            // goes back to `System`.
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
            system::dealloc(high.cast(), SLAB_LAYOUT);
            self.held -= 1;
        }
    }

    /// Takes listed slab `s` off size class `c`'s list.
    ///
    /// # Safety
    ///
    /// `s` is live and on that list.
    unsafe fn unlink(&mut self, s: *mut Slab, c: usize) {
        // SAFETY: the caller's contract; its neighbours are live.
        unsafe {
            let (prev, next) = ((*s).prev, (*s).next);
            if prev.is_null() {
                self.lists[c] = next;
            } else {
                (*prev).next = next;
            }
            if !next.is_null() {
                (*next).prev = prev;
            }
            (*s).prev = null_mut();
            (*s).next = null_mut();
        }
    }

    /// Puts slab `s` first on size class `c`'s list.
    ///
    /// # Safety
    ///
    /// `s` is live and on no list.
    unsafe fn push_front(&mut self, s: *mut Slab, c: usize) {
        // SAFETY: the caller's contract; the head is live.
        unsafe {
            let head = self.lists[c];
            (*s).prev = null_mut();
            (*s).next = head;
            if !head.is_null() {
                (*head).prev = s;
            }
            self.lists[c] = s;
        }
    }
}

/// [`Heap`], for the one thread a `wasm32-unknown-unknown` instance has.
#[cfg(target_arch = "wasm32")]
struct HeapCell(UnsafeCell<Heap>);

// SAFETY: the engine is built without the `atomics` target feature: one
// thread, and allocations do not reenter the allocator.
#[cfg(target_arch = "wasm32")]
unsafe impl Sync for HeapCell {}

// The heap has no lock.
#[cfg(all(target_arch = "wasm32", target_feature = "atomics"))]
compile_error!("the engine's allocator assumes a single thread (no `atomics`)");

#[cfg(target_arch = "wasm32")]
static HEAP: HeapCell = HeapCell(UnsafeCell::new(Heap::new()));

/// The engine's heap.
///
/// # Safety
///
/// No other reference to it is alive (the global allocator's methods do
/// not call each other).
#[cfg(target_arch = "wasm32")]
#[inline(always)]
unsafe fn heap() -> &'static mut Heap {
    // SAFETY: the caller's contract.
    unsafe { &mut *HEAP.0.get() }
}

/// The global allocator: [`Heap`], counting the bytes in use with the
/// `heap-stats` feature.
#[cfg(target_arch = "wasm32")]
pub struct Global;

// SAFETY: `Heap` hands out each small block once until it is freed,
// aligned to 8 and in memory `System` gave its slab, and passes other calls
// to `System` with the caller's arguments; growing ahead only allocates and
// frees a block of its own.
#[cfg(target_arch = "wasm32")]
unsafe impl GlobalAlloc for Global {
    #[inline]
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        // SAFETY: the caller's contract; no other reference to the heap.
        let ptr = unsafe { heap().alloc(layout) };
        if !ptr.is_null() {
            count(layout.size());
        }
        ptr
    }

    #[inline]
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        // SAFETY: as for `alloc`.
        let ptr = unsafe { heap().alloc_zeroed(layout) };
        if !ptr.is_null() {
            count(layout.size());
        }
        ptr
    }

    #[inline]
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        count(layout.size().wrapping_neg());
        // SAFETY: as for `alloc`.
        unsafe { heap().dealloc(ptr, layout) }
    }

    #[inline]
    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        // SAFETY: as for `alloc`.
        let new = unsafe { heap().realloc(ptr, layout, new_size) };
        if !new.is_null() {
            count(new_size.wrapping_sub(layout.size()));
        }
        new
    }
}

#[cfg(target_arch = "wasm32")]
#[global_allocator]
static ALLOCATOR: Global = Global;

#[cfg(test)]
mod tests;
