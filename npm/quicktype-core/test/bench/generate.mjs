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

const SETS = Array.from({ length: 40 }, (_, i) => `s${hex(i * 7919 + 4099, 3)}`);
const LEGALITY_FORMATS = [
    "standard", "future", "historic", "timeless", "gladiator", "pioneer", "modern", "legacy", "pauper", "vintage", "penny",
    "commander", "oathbreaker", "standardbrawl", "brawl", "alchemy", "paupercommander", "duel", "oldschool", "premodern", "predh",
];
const LEGALITIES = ["legal", "not_legal", "not_legal", "not_legal", "restricted", "banned"];
const TYPES = ["Creature — Elf Warrior", "Instant", "Sorcery", "Artifact", "Enchantment — Aura", "Land", "Legendary Creature — Human Wizard"];
const COLORS = ["W", "U", "B", "R", "G"];
const IMAGE_SIZES = [
    ["small", "jpg"], ["normal", "jpg"], ["large", "jpg"], ["png", "png"], ["art_crop", "jpg"], ["border_crop", "jpg"],
    ["thumb", "webp"], ["grid", "webp"], ["display", "webp"], ["art", "webp"], ["crop", "webp"], ["jpeg", "jpg"],
];
/** The ids of the tokens and other cards that cards refer to (`all_parts`). */
const PARTS = Array.from({ length: 300 }, (_, i) => `${hex(i * 2654435761 % 4294967296, 8)}-0000-4000-8000-${hex(i, 12)}`);

/** A slug of a card name, as in a URI path. */
const slug = (name) => name.toLowerCase().replaceAll(" ", "-");

/** A price: a decimal string, or null. */
const price = (r) => (r.chance(30) ? "null" : `"${r.below(200)}.${two(r.below(100))}"`);

/**
 * A JSON document shaped like a public dump of trading cards: a top-level
 * array of `records` cards, one per line, about 4.4 KB each. What makes
 * such data slow to infer is in each card: about 27 URIs, four in five of
 * them found in no other card (image links by the card's id, with a file
 * extension and a query; API links; search links with percent-encoded
 * queries), with a nested object of two dozen enum-valued keys, prices,
 * short names and type lines (interned as enum cases; some type lines have
 * a non-ASCII dash), longer rules and flavor text (not interned), UUIDs,
 * dates and small arrays.
 */
export function generateCards(records, seed = 0x5eed0000 + records) {
    const r = new Rng(seed);
    const parts = ["["];
    for (let i = 0; i < records; i++) {
        const id = uuid(r).slice(1, -1);
        const oracle = uuid(r);
        const set = r.pick(SETS);
        const number = 1 + r.below(400);
        const name = `${r.pick(WORDS)[0].toUpperCase()}${r.pick(WORDS).slice(1)} ${r.pick(WORDS)}`;
        const stamp = 1500000000 + r.below(300000000);
        const image = (size, ext, face) => `"https://cards.example.io/${size}/${face}/${id[0]}/${id[1]}/${id}.${ext}?${stamp}"`;
        const colors = COLORS.filter(() => r.chance(25));
        const list = (items) => `[${items.map((x) => `"${x}"`).join(",")}]`;
        let o = `{"object":"card","id":"${id}","oracle_id":${oracle},"multiverse_ids":[${r.below(700000)}]`;
        if (r.chance(60)) o += `,"mtgo_id":${r.below(130000)}`;
        o += `,"tcgplayer_id":${r.below(600000)},"name":"${name}","lang":"${r.chance(90) ? "en" : r.pick(["de", "fr", "ja"])}"`;
        o += `,"released_at":"20${two(r.below(25))}-${two(1 + r.below(12))}-${two(1 + r.below(28))}"`;
        o += `,"uri":"https://api.example.com/cards/${id}","web_uri":"https://example.com/card/${set}/${number}/${slug(name)}?utm_source=api"`;
        o += `,"layout":"normal","highres_image":${r.chance(80)},"image_status":"${r.pick(["highres_scan", "lowres", "placeholder"])}"`;
        const images = (face) =>
            `{${IMAGE_SIZES.map(([size, ext]) => `"${size}":${image(size, ext, face)}`).join(",")}}`;
        o += `,"image_uris":${images("front")}`;
        if (r.chance(15)) {
            const face = (side) =>
                `{"object":"card_face","name":"${r.pick(WORDS)} ${r.pick(WORDS)}","mana_cost":"","type_line":"${r.pick(TYPES)}","oracle_text":${JSON.stringify(text(r, 6 + r.below(20)))},"image_uris":${images(side)}}`;
            o += `,"card_faces":[${face("front")},${face("back")}]`;
        }

        if (r.chance(20)) {
            const part = () => `{"object":"related_card","id":${uuid(r)},"component":"${r.pick(["token", "combo_piece"])}","name":"${r.pick(WORDS)}","uri":"https://api.example.com/cards/${r.pick(PARTS)}"}`;
            o += `,"all_parts":[${part()},${part()}]`;
        }
        o += `,"mana_cost":"{${r.below(8)}}{${r.pick(COLORS)}}","cmc":${r.below(9)}.0,"type_line":"${r.pick(TYPES)}"`;
        o += `,"oracle_text":${JSON.stringify(text(r, 6 + r.below(40)))}`;
        if (r.chance(50)) o += `,"power":"${r.below(8)}","toughness":"${r.below(8)}"`;
        o += `,"colors":${list(colors)},"color_identity":${list(colors)},"keywords":${list(r.chance(30) ? [r.pick(["Flying", "Trample", "Haste"])] : [])}`;
        o += `,"legalities":{${LEGALITY_FORMATS.map((f) => `"${f}":"${r.pick(LEGALITIES)}"`).join(",")}}`;
        o += `,"games":${list(r.chance(50) ? ["paper", "mtgo"] : ["paper"])},"reserved":false,"foil":${r.chance(50)},"nonfoil":true,"finishes":${list(["nonfoil", "foil"])}`;
        o += `,"oversized":false,"promo":${r.chance(10)},"reprint":${r.chance(40)},"variation":false`;
        o += `,"set_id":${uuid(r)},"set":"${set}","set_name":"${r.pick(WORDS)} ${r.pick(WORDS)}","set_type":"${r.pick(["expansion", "core", "masters", "promo"])}"`;
        o += `,"set_uri":"https://api.example.com/sets/${set}","set_search_uri":"https://api.example.com/cards/search?order=set&q=e%3A${set}&unique=prints"`;
        o += `,"set_web_uri":"https://example.com/sets/${set}?utm_source=api","rulings_uri":"https://api.example.com/cards/${id}/rulings"`;
        o += `,"prints_search_uri":"https://api.example.com/cards/search?order=released&q=oracleid%3A${oracle.slice(1, -1)}&unique=prints"`;
        o += `,"collector_number":"${number}","digital":false,"rarity":"${r.pick(["common", "uncommon", "rare", "mythic"])}"`;
        if (r.chance(70)) o += `,"flavor_text":${JSON.stringify(text(r, 5 + r.below(20)))}`;
        o += `,"artist":"${r.pick(WORDS)} ${r.pick(WORDS)}","border_color":"black","frame":"${r.pick(["1993", "2003", "2015"])}","full_art":false,"textless":false,"booster":true`;
        o += `,"prices":{"usd":${price(r)},"usd_foil":${price(r)},"eur":${price(r)},"tix":${price(r)}}`;
        o += `,"related_uris":{"gatherer":"https://gatherer.example.com/Pages/Card/Details.aspx?multiverseid=${r.below(700000)}","edhrec":"https://edhrec.example.com/route/?cc=${encodeURIComponent(name)}"}`;
        o += `,"purchase_uris":{"tcgplayer":"https://partner.example.com/c/${r.below(10000)}/${r.below(10000)}?u=https%3A%2F%2Fshop.example.com%2Fproduct%2F${r.below(600000)}","cardmarket":"https://www.example.eu/Products/Search?searchString=${encodeURIComponent(name)}&utm_campaign=card_prices"}}`;
        parts.push((i > 0 ? ",\n" : "\n") + o);
    }

    parts.push("\n]\n");
    return parts.join("");
}
