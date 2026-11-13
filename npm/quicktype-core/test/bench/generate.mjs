// The generated JSON inputs of the benchmarks: a port of `generate_json`
// in xtask/src/bench.rs (the same SplitMix64 and record shape: nested
// classes, arrays of classes, a map with random keys, enums, dates, UUIDs,
// URIs, integer strings, nullable and optional properties and a
// number/string union), about 730 bytes per record.

const M = (1n << 64n) - 1n;

/** SplitMix64. */
class Rng {
    constructor(seed) {
        this.s = BigInt(seed) & M;
    }

    next() {
        this.s = (this.s + 0x9e3779b97f4a7c15n) & M;
        let z = this.s;
        z = ((z ^ (z >> 30n)) * 0xbf58476d1ce4e5b9n) & M;
        z = ((z ^ (z >> 27n)) * 0x94d049bb133111ebn) & M;
        return z ^ (z >> 31n);
    }

    below(n) {
        return Number(this.next() % BigInt(n));
    }

    chance(percent) {
        return this.below(100) < percent;
    }

    pick(items) {
        return items[this.below(items.length)];
    }
}

const WORDS = [
    "alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet",
    "kilo", "lima", "mike", "november", "oscar", "papa", "quebec", "romeo", "sierra", "tango",
    "uniform", "victor", "whiskey", "xray", "yankee", "zulu", "amber", "birch", "cedar", "dune",
];
const CITIES = ["Stockholm", "Lisbon", "Osaka", "Denver", "Nairobi", "Lima", "Oslo", "Perth", "Quito", "Riga"];
const STATUSES = ["active", "inactive", "pending", "suspended", "archived"];
const COUNTRIES = ["SE", "PT", "JP", "US", "KE", "PE", "NO", "AU", "EC", "LV"];

const two = (n) => String(n).padStart(2, "0");
const hex = (n, width) => n.toString(16).padStart(width, "0");

const timestamp = (r) =>
    `"20${two(10 + r.below(15))}-${two(1 + r.below(12))}-${two(1 + r.below(28))}T${two(r.below(24))}:${two(r.below(60))}:${two(r.below(60))}Z"`;

function uuid(r) {
    const a = r.next();
    const b = r.next();
    return `"${hex(a >> 32n, 8)}-${hex((a >> 16n) & 0xffffn, 4)}-4${hex(a & 0xfffn, 3)}-8${hex(b >> 52n, 3)}-${hex(b & 0xffffffffffffn, 12)}"`;
}

function key(r) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    let s = '"';
    for (let i = 0; i < 10; i++) s += chars[r.below(chars.length)];
    return `${s}"`;
}

function record(r, id) {
    const first = r.pick(WORDS);
    const last = r.pick(WORDS);
    let o = `{"id":${id},"uuid":${uuid(r)}`;
    o += `,"name":"${first} ${last}","email":"${first}.${last}${r.below(1000)}@example.com","createdAt":${timestamp(r)}`;
    o += `,"score":${r.below(100)}.${r.below(100)},"visits":${r.below(100000)},"active":${r.chance(50)},"status":"${r.pick(STATUSES)}","homepage":"https://example.com/users/${id}"`;
    o += ',"tags":[';
    const tags = r.below(5);
    for (let i = 0; i < tags; i++) o += `${i > 0 ? "," : ""}"${r.pick(WORDS)}"`;
    o += `],"address":{"street":"${r.below(999) + 1} ${r.pick(WORDS)} Street","city":"${r.pick(CITIES)}","zip":"${String(r.below(100000)).padStart(5, "0")}","country":"${r.pick(COUNTRIES)}","geo":{"lat":${r.below(90)}.${r.below(1000000)},"lng":${r.below(180)}.${r.below(1000000)}}}`;
    o += ',"orders":[';
    const orders = r.below(4);
    for (let i = 0; i < orders; i++) {
        o += `${i > 0 ? "," : ""}{"orderId":${r.below(1000000)},"sku":"SKU-${r.below(10000)}","quantity":${1 + r.below(9)},"unitPrice":${r.below(500)}.${two(r.below(100))},"shippedAt":`;
        o += r.chance(30) ? "null" : timestamp(r);
        if (r.chance(20)) {
            o += `,"note":"Please leave the parcel with the ${r.pick(WORDS)} at the ${r.pick(WORDS)} entrance, thank you very much"`;
        }

        o += "}";
    }

    o += '],"preferences":{';
    const preferences = 1 + r.below(6);
    for (let i = 0; i < preferences; i++) o += `${i > 0 ? "," : ""}${key(r)}:${r.below(1000)}`;
    o += '},"manager":';
    o += r.chance(40)
        ? "null"
        : `{"id":${r.below(1000)},"name":"${r.pick(WORDS)} ${r.pick(WORDS)}","since":"20${two(10 + r.below(15))}-${two(1 + r.below(12))}-${two(1 + r.below(28))}"}`;
    o += ',"rating":';
    switch (r.below(4)) {
        case 0:
            o += `${r.below(6)}`;
            break;
        case 1:
            o += `${r.below(5)}.5`;
            break;
        case 2:
            o += '"n/a"';
            break;
        default:
            o += "null";
    }

    return `${o}}`;
}

/** A JSON document of `records` records (seeded as in xtask). */
export function generateJson(records, seed = 0x5eed0000 + records) {
    const r = new Rng(seed);
    const parts = ['{"generatedAt":"2024-01-01T00:00:00Z","records":[\n'];
    for (let id = 0; id < records; id++) parts.push((id > 0 ? ",\n" : "") + record(r, id));
    parts.push("\n]}\n");
    return parts.join("");
}

const SENTENCE_WORDS = [
    "the", "card", "creature", "spell", "ability", "player", "controller", "battlefield", "graveyard", "library",
    "counter", "token", "damage", "turn", "phase", "step", "trigger", "resolves", "target", "opponent",
    "mana", "cost", "copy", "effect", "permanent", "until", "end", "of", "if", "you", "it", "its", "that",
    "would", "instead", "can't", "may", "each", "with", "and", "or", "a", "an", "to", "from", "is", "are",
    "this", "when", "enters", "leaves", "becomes", "attacking", "blocking", "exile", "hand", "draw", "discard",
];

/** A sentence-like text of about `words` words. */
function text(r, words) {
    let s = "";
    for (let i = 0; i < words; i++) {
        const word = r.pick(SENTENCE_WORDS);
        s += i === 0 ? word[0].toUpperCase() + word.slice(1) : ` ${word}`;
        if (i > 0 && i % 12 === 11) s += r.chance(50) ? "." : ",";
    }

    return `${s}.`;
}

/**
 * A JSON document shaped like a public dump of card rulings: a top-level
 * array of `records` small objects (`object`, an `oracle_id` UUID, a
 * `source` out of two, a `published_at` date and a `comment` of 8 to 37
 * words), about 260 bytes each.
 */
export function generateRulings(records, seed = 0x5eed0000 + records) {
    const r = new Rng(seed);
    const parts = ["["];
    let oracle = uuid(r);
    for (let i = 0; i < records; i++) {
        // Several rulings per card, as in such a dump.
        if (r.chance(35)) oracle = uuid(r);
        const record =
            `{"object":"ruling","oracle_id":${oracle},"source":"${r.chance(70) ? "wotc" : "scryfall"}",` +
            `"published_at":"20${two(4 + r.below(21))}-${two(1 + r.below(12))}-${two(1 + r.below(28))}",` +
            `"comment":${JSON.stringify(text(r, 8 + r.below(30)))}}`;
        parts.push((i > 0 ? ",\n" : "\n") + record);
    }

    parts.push("\n]\n");
    return parts.join("");
}
