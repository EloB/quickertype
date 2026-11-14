//! The slabs and the dispatch of [`Heap`], on the host's allocator.

use super::*;

/// A small deterministic generator (a 64-bit LCG, the high bits).
struct Lcg(u64);

impl Lcg {
    fn below(&mut self, n: usize) -> usize {
        self.0 = self
            .0
            .wrapping_mul(6_364_136_223_846_793_005)
            .wrapping_add(1_442_695_040_888_963_407);
        ((self.0 >> 33) % n as u64) as usize
    }
}

fn layout(size: usize, align: usize) -> Layout {
    Layout::from_size_align(size, align).unwrap()
}

/// The slab a small block lies in.
fn slab_of(block: *mut u8) -> *mut Slab {
    (block as usize & !(SLAB - 1)) as *mut Slab
}

/// Checks that a small block lies within its slab's blocks.
fn in_its_slab(p: *mut u8, size: usize, align: usize) {
    if is_small(size, align) {
        let s = slab_of(p) as usize;
        assert!(p as usize >= s + FIRST && p as usize + size <= s + SLAB_BYTES);
        assert_eq!((p as usize - s - FIRST) % ((class(size) + 1) * 8), 0);
    }
}

/// How many blocks of `size` bytes a slab holds.
fn per_slab(size: usize) -> usize {
    (SLAB_BYTES - FIRST) / size
}

/// Fills `size` bytes at `ptr` with a pattern of `tag`.
unsafe fn fill(ptr: *mut u8, size: usize, tag: usize) {
    for i in 0..size {
        unsafe { ptr.add(i).write((tag.wrapping_add(i * 31)) as u8) };
    }
}

/// Whether the first `size` bytes at `ptr` hold the pattern of `tag`.
unsafe fn holds(ptr: *mut u8, size: usize, tag: usize) -> bool {
    (0..size).all(|i| unsafe { ptr.add(i).read() } == (tag.wrapping_add(i * 31)) as u8)
}

/// Gives back the slabs a heap still holds, all of whose blocks are freed:
/// each size's last slab and the pool. Fails if any is still in use or
/// any other slab is left.
fn release(heap: &mut Heap) {
    unsafe {
        for c in 0..CLASSES {
            let s = heap.lists[c];
            if !s.is_null() {
                assert_eq!((*s).used, 0, "class {c}: blocks still in use");
                assert!((*s).next.is_null(), "class {c}: more than one slab left");
                system::dealloc(s.cast(), SLAB_LAYOUT);
                heap.lists[c] = null_mut();
                heap.held -= 1;
            }
        }
        for &s in &heap.pool[..heap.pooled] {
            system::dealloc(s.cast(), SLAB_LAYOUT);
            heap.held -= 1;
        }
        heap.pooled = 0;
    }
    assert_eq!(heap.held, 0, "slabs neither listed nor pooled");
}

#[test]
fn freeing_many_slabs_keeps_the_lowest_in_the_pool() {
    let mut heap = Heap::new();
    let size = 64;
    let c = class(size);
    let n = per_slab(size);
    let slabs = 40;
    let blocks: Vec<*mut u8> = (0..slabs * n)
        .map(|_| unsafe { heap.alloc(layout(size, 8)) })
        .collect();
    assert!(blocks.iter().all(|b| !b.is_null()));
    assert_eq!(heap.held, slabs);
    let mut all: Vec<*mut Slab> = blocks.iter().map(|&b| slab_of(b)).collect();
    all.dedup();
    assert_eq!(all.len(), slabs);
    for &b in &blocks {
        unsafe { heap.dealloc(b, layout(size, 8)) };
    }
    // The last slab to empty stays its size's; the pool keeps the 32
    // lowest of the others, and the rest went back.
    let kept = heap.lists[c];
    assert_eq!(kept, all[slabs - 1]);
    assert_eq!(heap.pooled, POOL);
    assert_eq!(heap.held, POOL + 1);
    let mut others: Vec<*mut Slab> = all.iter().copied().filter(|&s| s != kept).collect();
    others.sort();
    let mut pooled = heap.pool.to_vec();
    pooled.sort();
    assert_eq!(pooled, others[..POOL]);
    release(&mut heap);
}

#[test]
fn realloc_keeps_the_contents_across_classes_and_to_and_from_the_system() {
    let mut heap = Heap::new();
    unsafe {
        let mut size = 5;
        let mut ptr = heap.alloc(layout(size, 1));
        fill(ptr, size, 7);
        // Within a class: the same block.
        let same = heap.realloc(ptr, layout(size, 1), 8);
        assert_eq!(same, ptr);
        assert!(holds(same, size, 7));
        fill(same, 8, 7);
        size = 8;
        for (new_size, small) in [
            (20, true),
            (300, false),
            (4_000, false),
            (100, true),
            (256, true),
            (257, false),
            (1, true),
        ] {
            let new = heap.realloc(ptr, layout(size, 1), new_size);
            assert!(!new.is_null());
            assert!(holds(new, size.min(new_size), 7), "{size} -> {new_size}");
            assert_eq!(is_small(new_size, 1), small);
            if small {
                assert_eq!((*slab_of(new)).size, (class(new_size) + 1) * 8);
            }
            fill(new, new_size, 7);
            ptr = new;
            size = new_size;
        }
        heap.dealloc(ptr, layout(size, 1));
        // Aligned to 16: never from a slab.
        let p = heap.alloc(layout(32, 16));
        assert_eq!(p as usize % 16, 0);
        fill(p, 32, 3);
        let q = heap.realloc(p, layout(32, 16), 48);
        assert!(holds(q, 32, 3));
        heap.dealloc(q, layout(48, 16));
    }
    release(&mut heap);
}

#[test]
fn an_empty_slab_serves_another_class() {
    let mut heap = Heap::new();
    let (a, b) = (24, 200);
    let n = per_slab(a);
    unsafe {
        // One full slab of `a`, and a block of a second.
        let first: Vec<*mut u8> = (0..n).map(|_| heap.alloc(layout(a, 8))).collect();
        let s1 = slab_of(first[0]);
        assert!(first.iter().all(|&p| slab_of(p) == s1));
        let extra = heap.alloc(layout(a, 8));
        assert_ne!(slab_of(extra), s1);
        assert!(!(*s1).listed);
        for &p in &first {
            heap.dealloc(p, layout(a, 8));
        }
        assert_eq!(heap.pooled, 1);
        assert_eq!(heap.pool[0], s1);
        // `b` takes it, with a new header.
        let held = heap.held;
        let m = per_slab(b);
        let blocks: Vec<*mut u8> = (0..m).map(|_| heap.alloc(layout(b, 8))).collect();
        assert_eq!(heap.held, held);
        assert_eq!(heap.pooled, 0);
        assert_eq!((*s1).size, b);
        assert_eq!((*s1).used as usize, m);
        assert!(blocks.iter().all(|&p| slab_of(p) == s1));
        for (k, &p) in blocks.iter().enumerate() {
            fill(p, b, k);
        }
        for (k, &p) in blocks.iter().enumerate() {
            assert!(holds(p, b, k));
            heap.dealloc(p, layout(b, 8));
        }
        heap.dealloc(extra, layout(a, 8));
    }
    release(&mut heap);
}

#[test]
fn allocating_and_freeing_one_block_keeps_its_slab() {
    let mut heap = Heap::new();
    let l = layout(248, 8);
    unsafe {
        let p = heap.alloc(l);
        heap.dealloc(p, l);
        let s = slab_of(p);
        for _ in 0..1_000 {
            let q = heap.alloc(l);
            assert_eq!(q, p);
            heap.dealloc(q, l);
        }
        assert_eq!(heap.lists[class(248)], s);
        assert_eq!(heap.held, 1);
        assert_eq!(heap.pooled, 0);
    }
    release(&mut heap);
}

#[test]
fn a_full_slab_comes_back_with_an_eighth_free_and_the_fullest_goes_next() {
    let mut heap = Heap::new();
    let size = 128;
    let n = per_slab(size);
    let eighth = (n / 8).max(1);
    let l = layout(size, 8);
    unsafe {
        let blocks: Vec<*mut u8> = (0..4 * n).map(|_| heap.alloc(l)).collect();
        let slabs: Vec<*mut Slab> = (0..4).map(|k| slab_of(blocks[k * n])).collect();
        // The fourth is current and full. Freeing in the first: it stays
        // off its list until an eighth of it is free.
        for (k, &p) in blocks[..eighth].iter().enumerate() {
            assert!(!(*slabs[0]).listed);
            heap.dealloc(p, l);
            assert_eq!((*slabs[0]).listed, k + 1 == eighth);
        }
        // A quarter of the second; a block of the third (off its list).
        let mut freed: Vec<*mut u8> = blocks[..eighth].to_vec();
        freed.extend_from_slice(&blocks[n..n + n / 4]);
        freed.push(blocks[2 * n]);
        for &p in &freed[eighth..] {
            heap.dealloc(p, l);
        }
        assert!(!(*slabs[2]).listed);
        assert_eq!(heap.lists[class(size)], slabs[3]);
        let held = heap.held;
        let mut again = Vec::new();
        let mut alloc = |again: &mut Vec<*mut u8>| {
            let p = heap.alloc(l);
            again.push(p);
            slab_of(p)
        };
        // The first (fullest), then the second; then a new slab, not the
        // third.
        for _ in 0..eighth {
            assert_eq!(alloc(&mut again), slabs[0]);
        }
        for _ in 0..n / 4 {
            assert_eq!(alloc(&mut again), slabs[1]);
        }
        let new = alloc(&mut again);
        assert!(!slabs.contains(&new));
        assert_eq!(heap.held, held + 1);
        for p in again
            .into_iter()
            .chain(blocks.iter().copied().filter(|b| !freed.contains(b)))
        {
            heap.dealloc(p, l);
        }
    }
    release(&mut heap);
}

#[test]
fn a_size_with_an_empty_last_slab_takes_a_lower_one_going_to_the_pool() {
    let mut heap = Heap::new();
    let (a, b) = (layout(8, 8), layout(32, 8));
    let n = per_slab(32);
    unsafe {
        // Size `a` keeps an empty slab.
        let p = heap.alloc(a);
        heap.dealloc(p, a);
        let y = heap.lists[class(8)];
        // Size `b`: a full slab, and a block in a second; the full one
        // empties, and goes to the pool.
        let first: Vec<*mut u8> = (0..n).map(|_| heap.alloc(b)).collect();
        let extra = heap.alloc(b);
        let x = slab_of(first[0]);
        for &q in &first {
            heap.dealloc(q, b);
        }
        // `a` keeps the lower of the two, the pool has the other.
        assert_eq!(heap.lists[class(8)], x.min(y));
        assert_eq!((*x.min(y)).size, 8);
        assert_eq!(heap.pool[..heap.pooled], [x.max(y)]);
        // Allocating and freeing one block of `a` stays on that slab.
        let q = heap.alloc(a);
        assert_eq!(slab_of(q), x.min(y));
        for _ in 0..100 {
            heap.dealloc(q, a);
            assert_eq!(heap.alloc(a), q);
        }
        heap.dealloc(q, a);
        heap.dealloc(extra, b);
        assert_eq!(heap.pool[..heap.pooled], [x.max(y)]);
    }
    release(&mut heap);
}

#[test]
fn random_allocations_keep_their_contents_and_never_overlap() {
    let mut heap = Heap::new();
    let mut rng = Lcg(42);
    // (address, size, alignment, tag)
    let mut live: Vec<(*mut u8, usize, usize, usize)> = Vec::new();
    let size_of = |rng: &mut Lcg| match rng.below(10) {
        0..=6 => 1 + rng.below(64),
        7..=8 => 65 + rng.below(236),
        _ => 301 + rng.below(4_700),
    };
    let check_all = |live: &[(*mut u8, usize, usize, usize)]| {
        let mut spans: Vec<(usize, usize)> = live
            .iter()
            .map(|&(p, size, _, _)| (p as usize, size))
            .collect();
        spans.sort();
        for w in spans.windows(2) {
            assert!(w[0].0 + w[0].1 <= w[1].0, "blocks overlap");
        }
        for &(p, size, _, tag) in live {
            assert!(unsafe { holds(p, size, tag) });
        }
    };
    for step in 0..30_000 {
        let op = rng.below(20);
        if live.is_empty() || op < 9 {
            let size = size_of(&mut rng);
            let align = [1, 2, 4, 8, 8, 8, 16][rng.below(7)];
            let zeroed = rng.below(10) == 0;
            let p = unsafe {
                if zeroed {
                    heap.alloc_zeroed(layout(size, align))
                } else {
                    heap.alloc(layout(size, align))
                }
            };
            assert!(!p.is_null());
            assert_eq!(p as usize % align, 0);
            if zeroed {
                assert!((0..size).all(|i| unsafe { p.add(i).read() } == 0));
            }
            in_its_slab(p, size, align);
            unsafe { fill(p, size, step) };
            live.push((p, size, align, step));
        } else if op < 16 {
            let (p, size, align, tag) = live.swap_remove(rng.below(live.len()));
            assert!(unsafe { holds(p, size, tag) });
            unsafe { heap.dealloc(p, layout(size, align)) };
        } else {
            let k = rng.below(live.len());
            let (p, size, align, tag) = live[k];
            let new_size = size_of(&mut rng);
            let q = unsafe { heap.realloc(p, layout(size, align), new_size) };
            assert!(!q.is_null());
            assert_eq!(q as usize % align, 0);
            in_its_slab(q, new_size, align);
            assert!(unsafe { holds(q, size.min(new_size), tag) });
            unsafe { fill(q, new_size, step) };
            live[k] = (q, new_size, align, step);
        }
        if step % 1_000 == 0 {
            check_all(&live);
        }
    }
    check_all(&live);
    for (p, size, align, _) in live {
        unsafe { heap.dealloc(p, layout(size, align)) };
    }
    release(&mut heap);
}
