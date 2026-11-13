// A small seeded PRNG (sfc32, seeded through splitmix32) and helpers. Every
// fuzz case is a pure function of its seed, so a seed reproduces its case on
// any machine.

function splitmix32(seed) {
    let state = seed >>> 0;
    return () => {
        state = (state + 0x9e3779b9) >>> 0;
        let z = state;
        z = Math.imul(z ^ (z >>> 16), 0x85ebca6b) >>> 0;
        z = Math.imul(z ^ (z >>> 13), 0xc2b2ae35) >>> 0;
        return (z ^ (z >>> 16)) >>> 0;
    };
}

export class Rng {
    constructor(seed) {
        const init = splitmix32(seed);
        this.a = init();
        this.b = init();
        this.c = init();
        this.d = init();
        for (let i = 0; i < 12; i++) this.u32();
    }

    u32() {
        const t = (((this.a + this.b) >>> 0) + this.d) >>> 0;
        this.d = (this.d + 1) >>> 0;
        this.a = this.b ^ (this.b >>> 9);
        this.b = (this.c + (this.c << 3)) >>> 0;
        this.c = (this.c << 21) | (this.c >>> 11);
        this.c = (this.c + t) >>> 0;
        return t;
    }

    /** A float in [0, 1). */
    float() {
        return this.u32() / 4294967296;
    }

    /** An integer in [0, n). */
    int(n) {
        return Math.floor(this.float() * n);
    }

    /** An integer in [lo, hi]. */
    range(lo, hi) {
        return lo + this.int(hi - lo + 1);
    }

    chance(p) {
        return this.float() < p;
    }

    pick(list) {
        return list[this.int(list.length)];
    }

    /** Picks from `[[weight, value], ...]`. */
    weighted(entries) {
        let total = 0;
        for (const [w] of entries) total += w;
        let x = this.float() * total;
        for (const [w, v] of entries) {
            x -= w;
            if (x < 0) return v;
        }
        return entries[entries.length - 1][1];
    }

    shuffle(list) {
        const a = list.slice();
        for (let i = a.length - 1; i > 0; i--) {
            const j = this.int(i + 1);
            [a[i], a[j]] = [a[j], a[i]];
        }
        return a;
    }

    /** `n` distinct elements of `list` (fewer if it is shorter), in random order. */
    sample(list, n) {
        return this.shuffle(list).slice(0, n);
    }

    /** A derived generator, so that one part of a case does not shift another. */
    fork() {
        return new Rng(this.u32());
    }
}
