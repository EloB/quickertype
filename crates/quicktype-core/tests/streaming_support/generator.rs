//! A seeded generator of JSON documents that stress type inference: enum
//! thresholds, transformed strings, number edges, maps around 500 keys,
//! duplicate keys, `$ref` objects, `__proto__`, deep nesting, unicode
//! keys, empty containers and mixed types. Documents are written as text,
//! so that number literals, escapes, duplicate keys and whitespace are as
//! chosen here.

use std::fmt::Write as _;

/// SplitMix64.
#[derive(Clone)]
pub struct Rng(u64);

impl Rng {
    pub fn new(seed: u64) -> Self {
        let mut rng = Rng(seed);
        rng.next();
        rng
    }

    pub fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }

    /// `0..n` (0 if `n` is 0).
    pub fn below(&mut self, n: u64) -> u64 {
        if n == 0 { 0 } else { self.next() % n }
    }

    /// `lo..=hi`.
    pub fn range(&mut self, lo: u64, hi: u64) -> u64 {
        lo + self.below(hi - lo + 1)
    }

    pub fn chance(&mut self, percent: u64) -> bool {
        self.below(100) < percent
    }

    pub fn pick<'a, T>(&mut self, xs: &'a [T]) -> &'a T {
        &xs[self.below(xs.len() as u64) as usize]
    }
}

/// What the generator may produce.
#[derive(Clone, Copy, Debug)]
pub struct Limits {
    /// Allow lone surrogates in `\u` escapes (the TypeScript CLI keeps
    /// them, the port reads them as U+FFFD: a known gap, so not for
    /// comparisons with TypeScript).
    pub lone_surrogates: bool,
    /// The deepest nesting of shapes.
    pub max_depth: u32,
    /// Allow maps with more than 500 keys.
    pub big_maps: bool,
    /// About the largest sample: past it, arrays end and the values of
    /// big maps are `0`.
    pub max_bytes: usize,
    /// Chance per thousand of a sample nested around inference's depth
    /// limit (TypeScript's `RangeError: Maximum call stack size exceeded`)
    /// or far beyond it.
    pub deep_permille: u64,
}

/// Transformed string kinds and their look-alikes.
#[derive(Clone, Copy, Debug)]
enum Format {
    Date,
    Time,
    DateTime,
    Uuid,
    IntegerString,
    BoolString,
    Uri,
    /// Almost a format: fails one check.
    NearMiss,
}

#[derive(Clone, Debug)]
enum Strings {
    /// Cases from a pool of this many (an enum candidate).
    Enum(Vec<String>),
    Format(Format),
    /// Free text of various lengths around the 64-unit interning limit.
    Free,
    /// Any of the above per value.
    Mixed(Vec<String>),
}

#[derive(Clone, Debug)]
enum Shape {
    Null,
    Bool,
    Integer,
    Double,
    String(Strings),
    Object {
        properties: Vec<(String, Shape, u64)>,
        /// Percent chance per object of repeating one of its keys.
        duplicates: u64,
    },
    /// An object with many generated keys.
    Map {
        keys: u64,
        value: Box<Shape>,
    },
    Array {
        item: Box<Shape>,
        max_len: u64,
    },
    OneOf(Vec<Shape>),
    /// `{"$ref": "#/..."}`.
    Ref,
    /// An empty object or array, or `[[]]`.
    Empty,
}

const KEYS: &[&str] = &[
    "id",
    "name",
    "a",
    "b",
    "c",
    "type",
    "value",
    "items",
    "data",
    "$ref",
    "__proto__",
    "constructor",
    "toString",
    "hasOwnProperty",
    "length",
    "",
    " ",
    "0",
    "12",
    "-1",
    "é",
    "日本",
    "🙂",
    "a.b",
    "with space",
    "UPPER",
    "kebab-case",
    "snake_case",
    "camelCase",
    "x/y",
    "tab\there",
    "quote\"d",
];

const WORDS: &[&str] = &[
    "red",
    "green",
    "blue",
    "alpha",
    "beta",
    "gamma",
    "delta",
    "north",
    "south",
    "east",
    "west",
    "small",
    "large",
    "on",
    "off",
    "yes",
    "no",
    "high",
    "low",
    "",
    "1.5",
    "+3",
    "007",
    "-0.5",
    "Ålborg",
    "naïve",
    "日本語",
    "🙂x",
    "null",
    "true ",
    "x y",
    "A",
    "a",
];

impl Shape {
    fn random(rng: &mut Rng, depth: u32, limits: &Limits) -> Shape {
        let deep = depth >= limits.max_depth;
        let roll = rng.below(if deep { 6 } else { 14 });
        match roll {
            0 => Shape::Null,
            1 => Shape::Bool,
            2 => Shape::Integer,
            3 => Shape::Double,
            4 | 5 => Shape::String(Strings::random(rng)),
            6..=8 => {
                let n = rng.range(0, 7);
                let mut properties = Vec::new();
                for _ in 0..n {
                    let key = if rng.chance(85) {
                        (*rng.pick(KEYS)).to_owned()
                    } else {
                        random_key(rng)
                    };
                    let shape = Shape::random(rng, depth + 1, limits);
                    let presence = *rng.pick(&[100, 100, 100, 90, 50, 10]);
                    properties.push((key, shape, presence));
                }
                Shape::Object {
                    properties,
                    duplicates: *rng.pick(&[0, 0, 0, 5, 30]),
                }
            }
            9 => {
                let keys = if limits.big_maps && rng.chance(30) {
                    *rng.pick(&[250, 499, 500, 501, 502, 520, 700])
                } else {
                    rng.range(1, 40)
                };
                Shape::Map {
                    keys,
                    value: Box::new(Shape::random(rng, depth + 1, limits)),
                }
            }
            10 | 11 => Shape::Array {
                item: Box::new(Shape::random(rng, depth + 1, limits)),
                max_len: *rng.pick(&[0, 1, 3, 5, 9, 10, 11, 17, 26, 40]),
            },
            12 => {
                let n = rng.range(2, 4);
                Shape::OneOf(
                    (0..n)
                        .map(|_| Shape::random(rng, depth + 1, limits))
                        .collect(),
                )
            }
            _ => {
                if rng.chance(50) {
                    Shape::Ref
                } else {
                    Shape::Empty
                }
            }
        }
    }

    /// Varies a shape a little, for another sample of the same top-level.
    fn vary(&self, rng: &mut Rng, limits: &Limits) -> Shape {
        if rng.chance(10) {
            return Shape::random(rng, 2, limits);
        }
        match self {
            Shape::Object {
                properties,
                duplicates,
            } => {
                let mut properties: Vec<(String, Shape, u64)> = properties
                    .iter()
                    .map(|(k, s, p)| (k.clone(), s.vary(rng, limits), *p))
                    .collect();
                if rng.chance(30) {
                    properties.push(((*rng.pick(KEYS)).to_owned(), Shape::Integer, 100));
                }
                if rng.chance(20) && !properties.is_empty() {
                    let i = rng.below(properties.len() as u64) as usize;
                    properties.remove(i);
                }
                Shape::Object {
                    properties,
                    duplicates: *duplicates,
                }
            }
            Shape::Array { item, max_len } => Shape::Array {
                item: Box::new(item.vary(rng, limits)),
                max_len: *max_len,
            },
            other => other.clone(),
        }
    }
}

impl Strings {
    fn random(rng: &mut Rng) -> Strings {
        match rng.below(8) {
            0..=2 => {
                // Pool sizes around sqrt of the usual value counts (enum
                // inference needs fewer cases than sqrt(values)).
                let n = *rng.pick(&[1, 2, 3, 4, 5, 6, 9, 10, 25]);
                Strings::Enum(pool(rng, n))
            }
            3 | 4 => Strings::Format(*rng.pick(&[
                Format::Date,
                Format::Time,
                Format::DateTime,
                Format::Uuid,
                Format::IntegerString,
                Format::BoolString,
                Format::Uri,
                Format::NearMiss,
            ])),
            5 => Strings::Free,
            _ => {
                let n = rng.range(1, 6);
                Strings::Mixed(pool(rng, n))
            }
        }
    }
}

fn pool(rng: &mut Rng, n: u64) -> Vec<String> {
    let mut cases = Vec::new();
    for i in 0..n {
        if rng.chance(70) {
            cases.push((*rng.pick(WORDS)).to_owned());
        } else {
            cases.push(format!("case{i}"));
        }
    }
    cases
}

fn random_key(rng: &mut Rng) -> String {
    const CHARS: &[char] = &[
        'a', 'b', 'c', 'x', 'y', 'z', '0', '1', '9', '_', '-', ' ', 'é', '日', '🙂',
    ];
    let len = rng.range(0, 10);
    (0..len).map(|_| *rng.pick(CHARS)).collect()
}

/// A sample's text and the places in it, for `$ref`s.
pub struct Writer<'r> {
    rng: &'r mut Rng,
    limits: Limits,
    out: String,
    /// The JSON pointer of the value being written.
    path: Vec<String>,
    /// Pointers seen so far.
    paths: Vec<String>,
}

impl<'r> Writer<'r> {
    fn new(rng: &'r mut Rng, limits: Limits) -> Self {
        Writer {
            rng,
            limits,
            out: String::new(),
            path: Vec::new(),
            paths: Vec::new(),
        }
    }

    fn space(&mut self) {
        if self.rng.chance(3) {
            let ws = *self.rng.pick(&[" ", "\n", "\t", "\r\n", "  "]);
            self.out.push_str(ws);
        }
    }

    fn string(&mut self, s: &str) {
        self.out.push('"');
        for c in s.chars() {
            match c {
                '"' => self.out.push_str("\\\""),
                '\\' => self.out.push_str("\\\\"),
                c if (c as u32) < 0x20 => {
                    let _ = write!(self.out, "\\u{:04x}", c as u32);
                }
                '/' if self.rng.chance(20) => self.out.push_str("\\/"),
                c if !c.is_ascii() && self.rng.chance(15) => {
                    let mut units = [0u16; 2];
                    for u in c.encode_utf16(&mut units) {
                        let _ = write!(self.out, "\\u{u:04x}");
                    }
                }
                c => self.out.push(c),
            }
        }
        if self.limits.lone_surrogates && self.rng.chance(1) {
            self.out.push_str("\\ud800");
        }
        self.out.push('"');
    }

    fn integer(&mut self) {
        let literal: String = match self.rng.below(10) {
            0 => (*self.rng.pick(&[
                "9223372036854775807",
                "9223372036854775808",
                "-9223372036854775808",
                "-9223372036854775809",
                "2147483647",
                "2147483648",
                "-2147483649",
                "9007199254740991",
                "9007199254740993",
                "123456789012345678901234567890",
                "-0",
                "0",
            ]))
            .to_owned(),
            1 => format!("-{}", self.rng.below(1000)),
            _ => self.rng.below(1000).to_string(),
        };
        self.out.push_str(&literal);
    }

    fn double(&mut self) {
        let literal: String = match self.rng.below(6) {
            0 => (*self.rng.pick(&[
                "1.0", "-0.0", "1e5", "1E5", "1e-7", "2.5e+3", "1e400", "0.1", "-1.5",
            ]))
            .to_owned(),
            _ => format!("{}.{}", self.rng.below(100), self.rng.below(100)),
        };
        self.out.push_str(&literal);
    }

    fn formatted(&mut self, format: Format) -> String {
        let r = &mut *self.rng;
        match format {
            Format::Date => format!(
                "20{:02}-{:02}-{:02}",
                r.below(30),
                r.range(1, 12),
                r.range(1, 28)
            ),
            Format::Time => {
                let zone = *r.pick(&["Z", "z", "+01:00", "-05:30", "", ".25Z"]);
                format!(
                    "{:02}:{:02}:{:02}{zone}",
                    r.below(24),
                    r.below(60),
                    r.below(60)
                )
            }
            Format::DateTime => {
                let fraction = if r.chance(30) { ".123" } else { "" };
                let zone = *r.pick(&["Z", "+02:00", "-0530", ""]);
                format!(
                    "20{:02}-{:02}-{:02}T{:02}:{:02}:{:02}{fraction}{zone}",
                    r.below(30),
                    r.range(1, 12),
                    r.range(1, 28),
                    r.below(24),
                    r.below(60),
                    r.below(60)
                )
            }
            Format::Uuid => format!(
                "{:08x}-{:04x}-{:04x}-{:04x}-{:012x}",
                r.next() as u32,
                r.below(0x10000),
                r.below(0x10000),
                r.below(0x10000),
                r.next() & 0xFFFF_FFFF_FFFF
            ),
            Format::IntegerString => (*r.pick(&[
                "0",
                "1",
                "-12",
                "2147483647",
                "2147483648",
                "-2147483648",
                "-2147483649",
                "42",
            ]))
            .to_owned(),
            Format::BoolString => (*r.pick(&["true", "false"])).to_owned(),
            Format::Uri => {
                let scheme = *r.pick(&["http", "https", "ftp", "HTTPS"]);
                let ext = *r.pick(&["", ".png", ".JPG", ".tar.gz", "/", ".html", ".x"]);
                let port = *r.pick(&["", "", ":8080", ":99999"]);
                format!("{scheme}://example.com{port}/p{}{ext}", r.below(5))
            }
            Format::NearMiss => (*r.pick(&[
                "2020-13-01",
                "25:00:00",
                "2020-01-01T25:00:00Z",
                "0123",
                "True",
                "1e5",
                "00000000-0000-0000-0000-00000000000G",
                "http://{x}",
                "mailto:a@b.c",
                "-",
                "t",
            ]))
            .to_owned(),
        }
    }

    fn free_text(&mut self) -> String {
        let r = &mut *self.rng;
        match r.below(6) {
            // Around the interning limit of 64 UTF-16 code units, some
            // with astral characters (two units each).
            0 => "x".repeat(r.range(60, 68) as usize),
            1 => format!(
                "{}{}",
                "🙂".repeat(r.range(30, 34) as usize),
                "x".repeat(r.below(3) as usize)
            ),
            2 => "long text ".repeat(r.range(7, 12) as usize),
            3 => format!("{} {}", r.pick(WORDS), r.below(100_000)),
            _ => (*r.pick(WORDS)).to_owned(),
        }
    }

    fn strings(&mut self, strings: &Strings) {
        let s = match strings {
            Strings::Enum(cases) => self.rng.pick(cases).clone(),
            Strings::Format(f) => self.formatted(*f),
            Strings::Free => self.free_text(),
            Strings::Mixed(cases) => match self.rng.below(4) {
                0 => self.rng.pick(cases).clone(),
                1 => {
                    let f = *self.rng.pick(&[
                        Format::Date,
                        Format::Uuid,
                        Format::Uri,
                        Format::IntegerString,
                        Format::BoolString,
                        Format::DateTime,
                    ]);
                    self.formatted(f)
                }
                2 => self.free_text(),
                _ => self.rng.pick(cases).clone(),
            },
        };
        self.string(&s);
    }

    fn reference(&mut self) {
        let target = if !self.paths.is_empty() && self.rng.chance(80) {
            let i = self.rng.below(self.paths.len() as u64) as usize;
            self.paths[i].clone()
        } else {
            (*self
                .rng
                .pick(&["#/", "#/a", "#/0", "#/items/0", "x", "#/a/b/c", "#/-1"]))
            .to_owned()
        };
        self.out.push('{');
        self.string("$ref");
        self.out.push(':');
        self.string(&target);
        self.out.push('}');
    }

    fn key(&mut self, key: &str) {
        self.space();
        self.string(key);
        self.space();
        self.out.push(':');
        self.space();
    }

    fn enter(&mut self, part: &str) {
        self.path.push(part.replace('~', "~0").replace('/', "~1"));
    }

    fn leave(&mut self) {
        self.path.pop();
    }

    fn value(&mut self, shape: &Shape) {
        if !self.path.is_empty() && self.rng.chance(2) {
            self.out.push_str("null");
            return;
        }
        let pointer = format!("#/{}", self.path.join("/"));
        if self.paths.len() < 64 && self.rng.chance(20) {
            self.paths.push(pointer);
        }
        match shape {
            Shape::Null => self.out.push_str("null"),
            Shape::Bool => self
                .out
                .push_str(if self.rng.chance(50) { "true" } else { "false" }),
            Shape::Integer => self.integer(),
            Shape::Double => self.double(),
            Shape::String(s) => self.strings(s),
            Shape::Object {
                properties,
                duplicates,
            } => {
                self.out.push('{');
                let mut first = true;
                let mut written: Vec<&str> = Vec::new();
                for (key, shape, presence) in properties {
                    if !self.rng.chance(*presence) {
                        continue;
                    }
                    if !first {
                        self.out.push(',');
                    }
                    first = false;
                    self.key(key);
                    self.enter(key);
                    self.value(shape);
                    self.leave();
                    written.push(key);
                }
                if !written.is_empty() && self.rng.chance(*duplicates) {
                    let i = self.rng.below(written.len() as u64) as usize;
                    let key = written[i].to_owned();
                    self.out.push(',');
                    self.key(&key);
                    if self.rng.chance(50) {
                        self.out.push_str("\"dup\"");
                    } else {
                        self.integer();
                    }
                }
                self.space();
                self.out.push('}');
            }
            Shape::Map { keys, value } => {
                self.out.push('{');
                let n = if *keys > 100 {
                    *keys
                } else {
                    self.rng.range(0, *keys)
                };
                for i in 0..n {
                    if i > 0 {
                        self.out.push(',');
                    }
                    let over = self.out.len() > self.limits.max_bytes;
                    let key = match self.rng.below(4) {
                        0 => format!("k{}", self.rng.below(*keys * 2 + 1)),
                        1 => format!("{}", self.rng.below(100_000)),
                        2 => self.formatted(Format::Uuid),
                        _ => random_key(self.rng),
                    };
                    self.key(&key);
                    if over {
                        self.out.push('0');
                        continue;
                    }
                    self.enter(&key);
                    self.value(value);
                    self.leave();
                }
                self.out.push('}');
            }
            Shape::Array { item, max_len } => {
                self.out.push('[');
                let n = if self.rng.chance(50) {
                    *max_len
                } else {
                    self.rng.range(0, *max_len)
                };
                for i in 0..n {
                    if self.out.len() > self.limits.max_bytes {
                        break;
                    }
                    if i > 0 {
                        self.out.push(',');
                    }
                    self.space();
                    self.enter(&i.to_string());
                    self.value(item);
                    self.leave();
                }
                self.out.push(']');
            }
            Shape::OneOf(shapes) => {
                let i = self.rng.below(shapes.len() as u64) as usize;
                self.value(&shapes[i]);
            }
            Shape::Ref => self.reference(),
            Shape::Empty => {
                let empty = *self.rng.pick(&["{}", "[]", "[[]]", "[{}]", "{\"a\":[]}"]);
                self.out.push_str(empty);
            }
        }
    }
}

/// One sample: its text and how it is given to the input.
#[derive(Clone, Debug)]
pub struct Sample {
    pub text: String,
    pub encoding: Encoding,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Encoding {
    /// `JsonSample::Stream`: bytes, stream-json semantics.
    Stream,
    /// `JsonSample::Reader` over a reader returning chunks of 1 to this
    /// many bytes.
    Reader(u64),
    /// `JsonSample::String`: `JSON.parse` semantics.
    Text,
}

/// One `add_source` call.
#[derive(Clone, Debug)]
pub struct Source {
    pub name: String,
    pub description: Option<String>,
    pub samples: Vec<Sample>,
}

/// The sources of one run.
#[derive(Clone, Debug)]
pub struct Case {
    pub sources: Vec<Source>,
    /// `--no-ignore-json-refs`-like: strings under `$ref` are references.
    pub handle_refs: bool,
    /// Whether a sample is nested around the depth limit or beyond.
    pub deep: bool,
}

/// A whole sample of `shape`.
fn sample_text(rng: &mut Rng, shape: &Shape, limits: Limits) -> String {
    let mut writer = Writer::new(rng, limits);
    writer.space();
    writer.value(shape);
    writer.space();
    writer.out
}

/// The guarded depth of inference (`support::recursion::MAX_DEPTH`):
/// `inferType` recurses once per nesting level.
pub const MAX_DEPTH: usize = 1_000;

/// A value nested `depth` levels deep: arrays, objects or both.
pub fn nested(depth: usize, style: u64, inner: &str) -> String {
    let mut out = String::with_capacity(depth * 8 + inner.len());
    for level in 0..depth {
        match style {
            0 => out.push('['),
            1 => out.push_str(r#"{"a":"#),
            _ if level % 2 == 0 => out.push('['),
            _ => out.push_str(r#"{"b":"#),
        }
    }
    out.push_str(inner);
    for level in (0..depth).rev() {
        match style {
            0 => out.push(']'),
            1 => out.push('}'),
            _ if level % 2 == 0 => out.push(']'),
            _ => out.push('}'),
        }
    }
    out
}

/// A sample nested around the depth limit, or far beyond it.
fn deep_sample(rng: &mut Rng) -> String {
    let depth = match rng.below(10) {
        0 => rng.range(1, 50) as usize,
        9 => *rng.pick(&[5_000, 100_000]),
        _ => MAX_DEPTH - 3 + rng.below(6) as usize,
    };
    let inner = *rng.pick(&[
        "",
        "1",
        "\"x\"",
        "{}",
        "[]",
        "null",
        r#"{"k":[1.5,"2020-01-01"]}"#,
    ]);
    let style = rng.below(3);
    let text = nested(depth, style, inner);
    // An empty inner value is only valid inside an array.
    if inner.is_empty() && style != 0 {
        nested(depth, 0, "")
    } else {
        text
    }
}

/// Breaks a sample, so that reading it fails.
fn corrupt(rng: &mut Rng, text: &str) -> String {
    let cut = |rng: &mut Rng, s: &str| {
        let mut i = rng.below(s.len() as u64 + 1) as usize;
        while !s.is_char_boundary(i) {
            i -= 1;
        }
        i
    };
    match rng.below(4) {
        0 => text[..cut(rng, text)].to_owned(),
        1 => {
            let i = cut(rng, text);
            let junk = *rng.pick(&["}", "]", ",", ":", "x", "\"", "1.", "-", "tru", "\\"]);
            format!("{}{junk}{}", &text[..i], &text[i..])
        }
        2 => format!("{text} {text}"),
        _ => String::new(),
    }
}

/// The case for `seed`.
pub fn case(seed: u64, limits: Limits) -> Case {
    let mut rng = Rng::new(seed);
    let top_levels = rng.range(1, 3);
    let mut sources = Vec::new();
    let text_samples = rng.chance(25);
    let mut deep = false;
    for t in 0..top_levels {
        let name = (*rng.pick(&["TopLevel", "Root", "Data", "élan", "a b", "2x"])).to_owned()
            + &t.to_string();
        let mut shape = Shape::random(&mut rng, 0, &limits);
        // Mostly records in an array or a root object, as JSON usually is.
        if rng.chance(40) {
            shape = Shape::Array {
                item: Box::new(shape),
                max_len: *rng.pick(&[3, 9, 10, 11, 16, 17, 25, 26, 36, 50, 100]),
            };
        }
        let source_count = rng.range(1, 3);
        for s in 0..source_count {
            let description = rng.chance(10).then(|| format!("described {s}"));
            let sample_count = rng.range(1, 2);
            let mut samples = Vec::new();
            for _ in 0..sample_count {
                let sample_shape = if rng.chance(50) {
                    shape.clone()
                } else {
                    shape.vary(&mut rng, &limits)
                };
                let mut text = if rng.below(1000) < limits.deep_permille {
                    deep = true;
                    deep_sample(&mut rng)
                } else {
                    sample_text(&mut rng, &sample_shape, limits)
                };
                if rng.chance(3) {
                    text = corrupt(&mut rng, &text);
                }
                let encoding = if text_samples && rng.chance(60) {
                    Encoding::Text
                } else if rng.chance(50) {
                    Encoding::Reader(*rng.pick(&[1, 3, 7, 64, 4096]))
                } else {
                    Encoding::Stream
                };
                samples.push(Sample { text, encoding });
            }
            sources.push(Source {
                name: name.clone(),
                description,
                samples,
            });
        }
    }
    // Interleave the top-levels' sources sometimes.
    if rng.chance(30) {
        let n = sources.len();
        for i in 0..n {
            let j = rng.below(n as u64) as usize;
            sources.swap(i, j);
        }
    }
    Case {
        sources,
        handle_refs: rng.chance(20),
        deep,
    }
}

/// One document for comparing with the TypeScript CLI: a single sample,
/// valid JSON, no lone surrogates.
pub fn document(seed: u64) -> String {
    let limits = Limits {
        lone_surrogates: false,
        max_depth: 8,
        big_maps: true,
        max_bytes: 40_000,
        deep_permille: 0,
    };
    let mut rng = Rng::new(seed ^ 0xD0C5);
    let mut shape = Shape::random(&mut rng, 0, &limits);
    if rng.chance(60) {
        shape = Shape::Array {
            item: Box::new(shape),
            max_len: *rng.pick(&[3, 9, 10, 11, 16, 17, 25, 26, 36, 50, 100]),
        };
    }
    sample_text(&mut rng, &shape, limits)
}
