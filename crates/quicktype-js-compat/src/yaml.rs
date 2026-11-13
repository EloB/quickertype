//! `YAML.parse(text)` of the npm package `yaml` 2.9.0 with its default
//! options, as quicktype's `parseJSON` falls back to it.
//!
//! The defaults are YAML 1.2 with the core schema, unique keys, no merge
//! keys, at most 100 alias expansions per anchor, and plain JavaScript
//! objects as maps. The syntax is parsed by `saphyr-parser` (a YAML 1.2
//! parser that passes the YAML test suite, like `yaml` does); this module
//! does what `yaml`'s composer and `toJS` do on top of it:
//!
//! - **Scalars** are resolved with the core schema's tags in their order:
//!   only plain scalars are tested, against `null` (`~`, `null`, `Null`,
//!   `NULL`, empty), `bool` (`true`/`True`/`TRUE`, likewise `false`), `int`
//!   (`0o` octal, decimal, `0x` hex), `float` (`.inf`/`.nan` forms,
//!   exponents, decimals); everything else, and every quoted or block
//!   scalar, is a string. An explicit core tag (`!!int 12`) resolves with
//!   that tag's tests, falling back to a string; `!` and unknown tags give
//!   strings.
//! - **Maps** become JavaScript objects ([`JsonValue::Object`] in property
//!   order: array-index keys first). Keys are converted to strings the way
//!   `yaml` does (`String(value)`, `null` → `""`). Two keys whose scalar
//!   values are `===` are an error (`Map keys must be unique`).
//! - **Aliases** expand to a copy of their anchor's value, with `yaml`'s
//!   resource-exhaustion limit.
//! - **Several documents** are an error; an empty stream is `null`.
//!
//! Known differences (none of which quicktype's inputs exercise): error
//! messages are `saphyr`'s, not `yaml`'s; `yaml`'s warnings (written to
//! stderr by Node with a process id) are not emitted; a `%YAML 1.1`
//! directive, which makes `yaml` switch to its YAML 1.1 schema (`yes` is
//! `true`, `1_000` is 1000, timestamps are dates), is ignored; the YAML 1.1 tags
//! `yaml` knows by name (`!!binary`, `!!timestamp`, `!!set`, `!!omap`,
//! `!!pairs`) are treated like unknown tags; collection-valued keys are
//! stringified approximately; recursive aliases (which `yaml` turns into
//! cyclic objects) and values nesting deeper than [`MAX_DEPTH`] (also
//! through aliases) are errors. `saphyr-parser` counts flow nesting in a
//! `u8`: more than 255 nested flow collections fail with `YAMLParseError:
//! recursion limit exceeded at line 1, column 256` (for `[[[…`), where
//! `yaml` overflows the JavaScript stack somewhere between about 750 and
//! 1,200 levels (`Maximum call stack size exceeded`). On
//! malformed input the two lexers disagree in a few corner cases: a tag or
//! anchor directly followed by a quoted scalar or collection (`!"x"`, `![`),
//! `?` or `:` directly before a flow collection inside a flow sequence, and
//! `{?}`. Over 6,182 inputs (mostly seeded mutations of JSON files) those
//! were the only 12 differences.

use std::fmt;

use indexmap::IndexMap;
use saphyr_parser::{Event, Parser, ScalarStyle, ScanError};

use crate::json::{JsonValue, insert_js_property};
use crate::number;

/// The deepest nesting of collections accepted. JavaScript would run out of
/// stack somewhere beyond this in quicktype's recursive schema walks; here a
/// deeper document is an error instead of a Rust stack overflow.
pub const MAX_DEPTH: usize = 1000;

/// `yaml`'s `maxAliasCount` default.
const MAX_ALIAS_COUNT: u64 = 100;

/// A `YAMLParseError` (or the `ReferenceError` alias expansion throws).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct YamlError {
    name: &'static str,
    message: String,
}

impl YamlError {
    fn parse(message: impl Into<String>) -> Self {
        YamlError {
            name: "YAMLParseError",
            message: message.into(),
        }
    }

    fn reference(message: impl Into<String>) -> Self {
        YamlError {
            name: "ReferenceError",
            message: message.into(),
        }
    }

    fn from_scan(e: &ScanError) -> Self {
        let marker = e.marker();
        YamlError::parse(format!(
            "{} at line {}, column {}",
            e.info(),
            marker.line(),
            marker.col() + 1
        ))
    }

    /// The JavaScript error's `name` (`YAMLParseError` or `ReferenceError`).
    pub fn name(&self) -> &str {
        self.name
    }

    /// The error message.
    pub fn message(&self) -> &str {
        &self.message
    }
}

/// `Error.prototype.toString`: `name: message`.
impl fmt::Display for YamlError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.name, self.message)
    }
}

impl std::error::Error for YamlError {}

/// A resolved scalar.
#[derive(Clone, Debug)]
enum Scalar {
    Null,
    Bool(bool),
    Number(f64),
    String(String),
}

impl Scalar {
    /// JavaScript `===` between the values.
    fn strict_equals(&self, other: &Scalar) -> bool {
        match (self, other) {
            (Scalar::Null, Scalar::Null) => true,
            (Scalar::Bool(a), Scalar::Bool(b)) => a == b,
            (Scalar::Number(a), Scalar::Number(b)) => a == b,
            (Scalar::String(a), Scalar::String(b)) => a == b,
            _ => false,
        }
    }

    fn to_js(&self) -> JsonValue {
        match self {
            Scalar::Null => JsonValue::Null,
            Scalar::Bool(b) => JsonValue::Bool(*b),
            Scalar::Number(n) => JsonValue::Number(*n),
            Scalar::String(s) => JsonValue::String(s.clone()),
        }
    }
}

/// A node of the composed document. Collections refer to their children by
/// index into [`Document::nodes`].
#[derive(Debug)]
enum Node {
    Scalar {
        value: Scalar,
        /// The source text and style, for stringifying collection keys.
        source: String,
        plain: bool,
    },
    Seq(Vec<usize>),
    Map(Vec<(usize, usize)>),
    /// An alias to the node with this index.
    Alias(usize),
}

#[derive(Debug, Default)]
struct Document {
    nodes: Vec<Node>,
    /// Whether the node has an anchor (and so is tracked for aliases).
    anchored: Vec<bool>,
}

/// An open collection while composing.
enum Open {
    Seq(usize, Vec<usize>),
    /// The map's index, its pairs, and a key waiting for its value.
    Map(usize, Vec<(usize, usize)>, Option<usize>),
}

/// The scalar's value under the core schema's implicit resolution
/// (`findScalarTagByTest`).
fn resolve_plain(s: &str) -> Scalar {
    if let Some(v) = resolve_null(s) {
        return v;
    }
    if let Some(v) = resolve_bool(s) {
        return v;
    }
    if let Some(v) = resolve_int(s) {
        return v;
    }
    if let Some(v) = resolve_float(s) {
        return v;
    }
    Scalar::String(s.to_owned())
}

/// `nullTag`: `/^(?:~|[Nn]ull|NULL)?$/`.
fn resolve_null(s: &str) -> Option<Scalar> {
    matches!(s, "" | "~" | "null" | "Null" | "NULL").then_some(Scalar::Null)
}

/// `boolTag`: `/^(?:[Tt]rue|TRUE|[Ff]alse|FALSE)$/`.
fn resolve_bool(s: &str) -> Option<Scalar> {
    match s {
        "true" | "True" | "TRUE" => Some(Scalar::Bool(true)),
        "false" | "False" | "FALSE" => Some(Scalar::Bool(false)),
        _ => None,
    }
}

/// `intOct` (`/^0o[0-7]+$/`), `int` (`/^[-+]?[0-9]+$/`) and `intHex`
/// (`/^0x[0-9a-fA-F]+$/`), resolved with `parseInt`.
fn resolve_int(s: &str) -> Option<Scalar> {
    if let Some(digits) = s.strip_prefix("0o")
        && !digits.is_empty()
        && digits.bytes().all(|b| (b'0'..=b'7').contains(&b))
    {
        return Some(Scalar::Number(number::string_to_number(s)));
    }
    let unsigned = s.strip_prefix(['-', '+']).unwrap_or(s);
    if !unsigned.is_empty() && unsigned.bytes().all(|b| b.is_ascii_digit()) {
        // `parseInt(s, 10)`, correctly rounded like V8; "-0" is -0.
        return Some(Scalar::Number(s.parse().unwrap_or(f64::NAN)));
    }
    if let Some(digits) = s.strip_prefix("0x")
        && !digits.is_empty()
        && digits.bytes().all(|b| b.is_ascii_hexdigit())
    {
        return Some(Scalar::Number(number::string_to_number(s)));
    }
    None
}

/// `floatNaN` (`/^(?:[-+]?\.(?:inf|Inf|INF)|\.nan|\.NaN|\.NAN)$/`),
/// `floatExp` (`/^[-+]?(?:\.[0-9]+|[0-9]+(?:\.[0-9]*)?)[eE][-+]?[0-9]+$/`)
/// and `float` (`/^[-+]?(?:\.[0-9]+|[0-9]+\.[0-9]*)$/`), resolved with
/// `parseFloat`.
fn resolve_float(s: &str) -> Option<Scalar> {
    match s {
        ".inf" | ".Inf" | ".INF" | "+.inf" | "+.Inf" | "+.INF" => {
            return Some(Scalar::Number(f64::INFINITY));
        }
        "-.inf" | "-.Inf" | "-.INF" => return Some(Scalar::Number(f64::NEG_INFINITY)),
        ".nan" | ".NaN" | ".NAN" => return Some(Scalar::Number(f64::NAN)),
        _ => {}
    }
    let unsigned = s.strip_prefix(['-', '+']).unwrap_or(s);
    let matches = match unsigned.find(['e', 'E']) {
        Some(i) => {
            let exponent = &unsigned[i + 1..];
            let exponent = exponent.strip_prefix(['-', '+']).unwrap_or(exponent);
            is_float_mantissa(&unsigned[..i], false) && is_digits(exponent)
        }
        None => is_float_mantissa(unsigned, true),
    };
    matches.then(|| Scalar::Number(number::string_to_number(s)))
}

/// One or more ASCII digits.
fn is_digits(s: &str) -> bool {
    !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit())
}

/// `\.[0-9]+` or `[0-9]+\.[0-9]*`; without `require_dot`, also `[0-9]+`.
fn is_float_mantissa(m: &str, require_dot: bool) -> bool {
    if let Some(fraction) = m.strip_prefix('.') {
        return is_digits(fraction);
    }
    match m.split_once('.') {
        Some((int_part, fraction)) => {
            is_digits(int_part) && fraction.bytes().all(|b| b.is_ascii_digit())
        }
        None => !require_dot && is_digits(m),
    }
}

/// The value of a scalar with an explicit tag (`findScalarTagByName`).
fn resolve_tagged(s: &str, tag: &str) -> Scalar {
    let resolved = match tag {
        "tag:yaml.org,2002:str" | "!" => None,
        "tag:yaml.org,2002:null" => resolve_null(s),
        "tag:yaml.org,2002:bool" => resolve_bool(s),
        "tag:yaml.org,2002:int" => resolve_int(s),
        "tag:yaml.org,2002:float" => resolve_float(s),
        // Unresolved tags (a warning in `yaml`) give the source string.
        _ => None,
    };
    resolved.unwrap_or_else(|| Scalar::String(s.to_owned()))
}

impl Document {
    fn push(&mut self, node: Node, anchored: bool) -> usize {
        self.nodes.push(node);
        self.anchored.push(anchored);
        self.nodes.len() - 1
    }

    /// `getAliasCount(doc, node, anchors)`.
    fn alias_count(&self, node: usize, anchors: &IndexMap<usize, AnchorData>, depth: usize) -> u64 {
        if depth > MAX_DEPTH {
            return 0;
        }
        stacker::maybe_grow(256 * 1024, 4 * 1024 * 1024, || {
            self.alias_count_unchecked(node, anchors, depth)
        })
    }

    fn alias_count_unchecked(
        &self,
        node: usize,
        anchors: &IndexMap<usize, AnchorData>,
        depth: usize,
    ) -> u64 {
        match &self.nodes[node] {
            Node::Alias(target) => anchors
                .get(target)
                .map_or(0, |a| a.count.saturating_mul(a.alias_count)),
            Node::Seq(items) => items
                .iter()
                .map(|&i| self.alias_count(i, anchors, depth + 1))
                .max()
                .unwrap_or(0),
            Node::Map(pairs) => pairs
                .iter()
                .map(|&(k, v)| {
                    self.alias_count(k, anchors, depth + 1)
                        .max(self.alias_count(v, anchors, depth + 1))
                })
                .max()
                .unwrap_or(0),
            Node::Scalar { .. } => 1,
        }
    }
}

/// `ctx.anchors` entries of `toJS`.
struct AnchorData {
    count: u64,
    alias_count: u64,
    /// The anchored node's value and its nesting height.
    res: Option<(JsonValue, usize)>,
}

struct ToJs<'d> {
    doc: &'d Document,
    anchors: IndexMap<usize, AnchorData>,
}

impl ToJs<'_> {
    /// `toJS(node)`.
    fn value(&mut self, node: usize, depth: usize) -> Result<JsonValue, YamlError> {
        self.value_and_height(node, depth).map(|(value, _)| value)
    }

    /// `toJS(node)` and how deeply the value nests. Aliases can make a value
    /// nest deeper than the document; past [`MAX_DEPTH`] that is an error.
    fn value_and_height(
        &mut self,
        node: usize,
        depth: usize,
    ) -> Result<(JsonValue, usize), YamlError> {
        if depth > MAX_DEPTH {
            return Err(YamlError::parse("Nesting too deep"));
        }
        stacker::maybe_grow(256 * 1024, 4 * 1024 * 1024, || {
            self.value_unchecked(node, depth)
        })
    }

    fn value_unchecked(
        &mut self,
        node: usize,
        depth: usize,
    ) -> Result<(JsonValue, usize), YamlError> {
        if self.doc.anchored[node] {
            self.anchors.insert(
                node,
                AnchorData {
                    count: 1,
                    alias_count: 0,
                    res: None,
                },
            );
        }
        let (res, height) = match &self.doc.nodes[node] {
            Node::Scalar { value, .. } => (value.to_js(), 0),
            Node::Seq(items) => {
                let mut values = Vec::with_capacity(items.len());
                let mut height = 0;
                for &item in items {
                    let (value, h) = self.value_and_height(item, depth + 1)?;
                    values.push(value);
                    height = height.max(h + 1);
                }
                (JsonValue::Array(values), height.max(1))
            }
            Node::Map(pairs) => {
                let mut map = IndexMap::new();
                let mut height = 0;
                for &(key, value) in pairs {
                    let js_key = self.value(key, depth + 1)?;
                    let string_key = self.stringify_key(key, &js_key);
                    let (js_value, h) = self.value_and_height(value, depth + 1)?;
                    insert_js_property(&mut map, string_key, js_value);
                    height = height.max(h + 1);
                }
                (JsonValue::Object(map), height.max(1))
            }
            Node::Alias(target) => return self.alias(*target, depth),
        };
        if height > MAX_DEPTH {
            return Err(YamlError::parse("Nesting too deep"));
        }
        if let Some(data) = self.anchors.get_mut(&node) {
            data.res = Some((deep_clone(&res), height));
        }
        Ok((res, height))
    }

    /// `Alias.toJSON`.
    fn alias(&mut self, target: usize, depth: usize) -> Result<(JsonValue, usize), YamlError> {
        if !self.anchors.contains_key(&target) {
            self.value(target, depth + 1)?;
        }
        let Some(data) = self.anchors.get_mut(&target).filter(|d| d.res.is_some()) else {
            // The anchor's own value is still being built: a recursive
            // alias, which `yaml` turns into a cyclic object.
            return Err(YamlError::reference("Recursive alias"));
        };
        data.count += 1;
        if data.alias_count == 0 {
            let alias_count = self.doc.alias_count(target, &self.anchors, 0);
            if let Some(data) = self.anchors.get_mut(&target) {
                data.alias_count = alias_count;
            }
        }
        let data = self
            .anchors
            .get(&target)
            .ok_or_else(|| YamlError::reference("Alias anchor was not resolved"))?;
        if data.count.saturating_mul(data.alias_count) > MAX_ALIAS_COUNT {
            return Err(YamlError::reference(
                "Excessive alias count indicates a resource exhaustion attack",
            ));
        }
        match &data.res {
            Some((value, height)) => Ok((deep_clone(value), *height)),
            None => Err(YamlError::reference("Alias anchor was not resolved")),
        }
    }

    /// `stringifyKey(key, jsKey)`.
    fn stringify_key(&self, key: usize, js_key: &JsonValue) -> String {
        match js_key {
            JsonValue::Null => String::new(),
            JsonValue::Bool(b) => b.to_string(),
            JsonValue::Number(n) => number::to_string(*n),
            JsonValue::String(s) => s.clone(),
            JsonValue::Array(_) | JsonValue::Object(_) => self.flow_string(key, 0),
        }
    }

    /// An approximation of `yaml`'s flow stringification of a collection
    /// key.
    fn flow_string(&self, node: usize, depth: usize) -> String {
        if depth > MAX_DEPTH {
            return String::new();
        }
        match &self.doc.nodes[node] {
            Node::Scalar { source, plain, .. } => {
                if *plain {
                    source.clone()
                } else {
                    crate::json::quote(source)
                }
            }
            Node::Seq(items) if items.is_empty() => "[]".to_owned(),
            Node::Seq(items) => format!(
                "[ {} ]",
                items
                    .iter()
                    .map(|&i| self.flow_string(i, depth + 1))
                    .collect::<Vec<_>>()
                    .join(", ")
            ),
            Node::Map(pairs) if pairs.is_empty() => "{}".to_owned(),
            Node::Map(pairs) => format!(
                "{{ {} }}",
                pairs
                    .iter()
                    .map(|&(k, v)| {
                        let key = self.flow_string(k, depth + 1);
                        match &self.doc.nodes[v] {
                            // A key without a value (`{ a, b }`).
                            Node::Scalar {
                                source,
                                plain: true,
                                ..
                            } if source.is_empty() => key,
                            _ => format!("{key}: {}", self.flow_string(v, depth + 1)),
                        }
                    })
                    .collect::<Vec<_>>()
                    .join(", ")
            ),
            Node::Alias(target) => self.flow_string(*target, depth + 1),
        }
    }
}

/// `yaml`'s "Comments must be separated from other tokens by white space
/// characters": a `#` right after a `:` or `,` indicator starts a comment
/// for `saphyr` but is an error for `yaml`. `spans` are the character
/// ranges of the scalars, where a `#` is content.
fn check_comment_separation(text: &str, spans: &[(usize, usize)]) -> Result<(), YamlError> {
    let mut spans = spans.iter().peekable();
    let mut previous: Option<char> = None;
    let mut in_comment = false;
    for (index, c) in text.chars().enumerate() {
        while spans.next_if(|&&(_, end)| end <= index).is_some() {}
        let in_scalar = spans
            .peek()
            .is_some_and(|&&(start, end)| start <= index && index < end);
        if c == '\n' || c == '\r' {
            in_comment = false;
        } else if !in_comment && !in_scalar && c == '#' {
            match previous {
                Some(':' | ',') => {
                    return Err(YamlError::parse(
                        "Comments must be separated from other tokens by white space characters",
                    ));
                }
                _ => in_comment = true,
            }
        }
        previous = Some(c);
    }
    Ok(())
}

/// Clones a value of at most [`MAX_DEPTH`] levels; `Clone` recurses once per
/// level, so it runs where at least 2 MB of stack are free.
fn deep_clone(value: &JsonValue) -> JsonValue {
    stacker::maybe_grow(2 * 1024 * 1024, 8 * 1024 * 1024, || value.clone())
}

/// `YAML.parse(text)`: the single document's value as JavaScript sees it.
pub fn parse(text: &str) -> Result<JsonValue, YamlError> {
    let mut doc = Document::default();
    let mut stack: Vec<Open> = Vec::new();
    // saphyr's anchor ids → node indexes.
    let mut anchors: IndexMap<usize, usize> = IndexMap::new();
    let mut root: Option<usize> = None;
    let mut documents = 0;

    // Character ranges of the scalars, for `check_comment_separation`.
    let mut scalar_spans: Vec<(usize, usize)> = Vec::new();

    let mut parser = Parser::new_from_str(text);
    while let Some(next) = parser.next_event() {
        let (event, span) = next.map_err(|e| YamlError::from_scan(&e))?;
        if matches!(event, Event::Scalar(..)) {
            scalar_spans.push((span.start.index(), span.end.index()));
        }
        let (node, anchor) = match event {
            Event::Nothing | Event::StreamStart | Event::StreamEnd | Event::DocumentEnd => continue,
            Event::DocumentStart(_) => {
                documents += 1;
                if documents > 1 {
                    return Err(YamlError::parse(
                        "Source contains multiple documents; please use YAML.parseAllDocuments()",
                    ));
                }
                continue;
            }
            Event::Alias(id) => {
                let target = *anchors.get(&id).ok_or_else(|| {
                    YamlError::reference(
                        "Unresolved alias (the anchor must be set before the alias)",
                    )
                })?;
                (doc.push(Node::Alias(target), false), 0)
            }
            Event::Scalar(value, style, anchor, tag) => {
                let resolved = match &tag {
                    Some(tag) => resolve_tagged(&value, &format!("{}{}", tag.handle, tag.suffix)),
                    None if style == ScalarStyle::Plain => resolve_plain(&value),
                    None => Scalar::String(value.to_string()),
                };
                let node = Node::Scalar {
                    value: resolved,
                    source: value.to_string(),
                    plain: style == ScalarStyle::Plain,
                };
                (doc.push(node, anchor != 0), anchor)
            }
            Event::SequenceStart(anchor, _tag) => {
                if stack.len() >= MAX_DEPTH {
                    return Err(YamlError::parse("Nesting too deep"));
                }
                let index = doc.push(Node::Seq(Vec::new()), anchor != 0);
                if anchor != 0 {
                    anchors.insert(anchor, index);
                }
                stack.push(Open::Seq(index, Vec::new()));
                continue;
            }
            Event::MappingStart(anchor, _tag) => {
                if stack.len() >= MAX_DEPTH {
                    return Err(YamlError::parse("Nesting too deep"));
                }
                let index = doc.push(Node::Map(Vec::new()), anchor != 0);
                if anchor != 0 {
                    anchors.insert(anchor, index);
                }
                stack.push(Open::Map(index, Vec::new(), None));
                continue;
            }
            Event::SequenceEnd | Event::MappingEnd => {
                let index = match stack.pop() {
                    Some(Open::Seq(index, items)) => {
                        doc.nodes[index] = Node::Seq(items);
                        index
                    }
                    Some(Open::Map(index, pairs, _)) => {
                        doc.nodes[index] = Node::Map(pairs);
                        index
                    }
                    None => return Err(YamlError::parse("Unbalanced collection end")),
                };
                // Already registered as an anchor at its start, if any.
                (index, 0)
            }
        };
        if anchor != 0 {
            anchors.insert(anchor, node);
        }
        match stack.last_mut() {
            None => root = Some(node),
            Some(Open::Seq(_, items)) => items.push(node),
            Some(Open::Map(_, pairs, pending)) => match pending.take() {
                None => {
                    // `mapIncludes`: a key equal (`===`) to an earlier one.
                    if let Node::Scalar { value, .. } = &doc.nodes[node] {
                        let duplicate = pairs.iter().any(|&(k, _)| {
                            matches!(&doc.nodes[k], Node::Scalar { value: other, .. } if other.strict_equals(value))
                        });
                        if duplicate {
                            return Err(YamlError::parse("Map keys must be unique"));
                        }
                    }
                    *pending = Some(node);
                }
                Some(key) => pairs.push((key, node)),
            },
        }
    }

    check_comment_separation(text, &scalar_spans)?;

    let Some(root) = root else {
        return Ok(JsonValue::Null);
    };
    let mut to_js = ToJs {
        doc: &doc,
        anchors: IndexMap::new(),
    };
    to_js.value(root, 0)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn js(text: &str) -> String {
        match parse(text) {
            Ok(v) => crate::json::stringify(&v, None),
            Err(e) => format!("error: {e}"),
        }
    }

    #[test]
    fn core_schema_scalars() {
        assert_eq!(
            js("[yes, on, ~, null, '', 0x1F, 0o17, 012, 1_000, 2001-12-14]"),
            r#"["yes","on",null,null,"",31,15,12,"1_000","2001-12-14"]"#
        );
        assert_eq!(
            js("[.inf, -.Inf, 1e3, 1., .5, '1', !!str 1, !!int '12', !!float 1, !foo 3]"),
            r#"[null,null,1000,1,0.5,"1","1",12,"1","3"]"#
        );
        assert_eq!(js("a: 1\n2: x\n1: y\n"), r#"{"1":"y","2":"x","a":1}"#);
        assert_eq!(js("{\"a\": 1, \"b\": [1, 2,],}"), r#"{"a":1,"b":[1,2]}"#);
        assert_eq!(js(""), "null");
        assert_eq!(js("<<: {a: 1}"), r#"{"<<":{"a":1}}"#);
        assert_eq!(js("? null\n: 1\n"), r#"{"":1}"#);
    }

    #[test]
    fn errors() {
        assert!(js("a: 1\na: 2\n").starts_with("error: YAMLParseError: Map keys must be unique"));
        assert!(js("{1: a, 1.0: b}").starts_with("error"));
        assert_eq!(js("{'1': a, 1: b}"), r#"{"1":"b"}"#);
        assert!(
            js("a\n---\nb\n")
                .starts_with("error: YAMLParseError: Source contains multiple documents")
        );
        assert!(js("query {\n  viewer {\n    realName: name\n  }\n}\n").starts_with("error"));
    }

    #[test]
    fn aliases() {
        assert_eq!(js("a: &x [1, 2]\nb: *x\n"), r#"{"a":[1,2],"b":[1,2]}"#);
        let many = format!("a: &x 1\nb: [{}]\n", vec!["*x"; 101].join(", "));
        assert!(js(&many).starts_with("error: ReferenceError: Excessive alias count"));
        let fine = format!("a: &x 1\nb: [{}]\n", vec!["*x"; 99].join(", "));
        assert!(!js(&fine).starts_with("error"));
    }
}
