//! Typed requests to the TypeScript 7 checker API.
//!
//! Port of the parts of `typescript/dist/api/sync/api.js` (TypeScript
//! 7.0.2) that the schema generator needs. Symbols and types are numeric
//! handles that stay valid for the snapshot; their eagerly sent data is
//! cached by id, and related objects are fetched lazily with `{objectId}`
//! requests, exactly like the JavaScript client's object registries.

use std::cell::{Cell, RefCell};
use std::collections::{BTreeMap, HashMap, HashSet};
use std::path::Path;
use std::rc::Rc;

use serde::Deserialize;
use serde::de::DeserializeOwned;
use serde_json::{Value as Json, json};

use super::ast::{Node, SourceFile};
use super::channel::{Channel, VirtualFiles};
use super::generated::{node_flags, symbol_flags as sf, syntax_kind as sk};
use crate::error::{Error, Result};
use crate::js::quote;
use crate::testing;

/// A node handle: `index.kind.path`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct NodeHandle {
    /// Index in the file's binary AST.
    pub index: usize,
    /// The node's `SyntaxKind`.
    pub kind: u32,
    /// The file's canonical path.
    pub path: String,
}

impl NodeHandle {
    fn parse(s: &str) -> Option<NodeHandle> {
        let (index, rest) = s.split_once('.')?;
        let (kind, path) = rest.split_once('.')?;
        Some(NodeHandle {
            index: index.parse().ok()?,
            kind: kind.parse().ok()?,
            path: path.to_owned(),
        })
    }

    /// The handle as the checker API takes it, as [`Node::handle`] gives it
    /// for the node (without loading its file).
    pub fn to_handle(&self) -> String {
        format!("{}.{}.{}", self.index, self.kind, self.path)
    }
}

#[derive(Deserialize)]
#[serde(rename_all = "camelCase")]
struct SymbolResponse {
    id: u64,
    name: String,
    flags: u32,
    #[serde(default)]
    declarations: Vec<String>,
    value_declaration: Option<String>,
    parent: Option<u64>,
}

/// A checker symbol.
#[derive(Debug)]
pub struct Symbol {
    /// Handle.
    pub id: u64,
    /// `escapedName`.
    pub escaped_name: String,
    /// `name` (escaped leading underscores removed).
    pub name: String,
    /// `SymbolFlags`.
    pub flags: u32,
    /// Declaration nodes.
    pub declarations: Vec<NodeHandle>,
    /// `valueDeclaration`.
    pub value_declaration: Option<NodeHandle>,
    /// Handle of the parent symbol.
    pub parent: Option<u64>,
}

/// A literal type's value.
#[derive(Clone, Debug, PartialEq)]
pub enum LiteralValue {
    /// String literal (or string enum member).
    String(String),
    /// Number literal (or numeric enum member).
    Number(f64),
    /// Boolean literal (TS 7 sends the value, not `intrinsicName`).
    Bool(bool),
}

#[derive(Deserialize)]
#[serde(rename_all = "camelCase")]
struct TypeResponse {
    id: u64,
    flags: u32,
    #[serde(default)]
    object_flags: u32,
    #[serde(default)]
    value: Json,
    intrinsic_name: Option<String>,
    symbol: Option<u64>,
    alias_symbol: Option<u64>,
    target: Option<u64>,
    #[serde(default)]
    element_flags: Vec<u32>,
    fixed_length: Option<u32>,
    texts: Option<Vec<String>>,
}

/// A checker type.
#[derive(Debug)]
pub struct Type {
    /// Handle (also the identity typescript-json-schema keys names by).
    pub id: u64,
    /// `TypeFlags`.
    pub flags: u32,
    /// `ObjectFlags`.
    pub object_flags: u32,
    /// Literal value.
    pub value: Option<LiteralValue>,
    /// `intrinsicName` of intrinsic types.
    pub intrinsic_name: Option<String>,
    /// Handle of `symbol`.
    pub symbol: Option<u64>,
    /// Handle of `aliasSymbol`.
    pub alias_symbol: Option<u64>,
    /// Handle of `target` (type references).
    pub target: Option<u64>,
    /// Tuple target `elementFlags`.
    pub element_flags: Vec<u32>,
    /// Tuple target `fixedLength`.
    pub fixed_length: Option<u32>,
    /// Template literal `texts`.
    pub texts: Option<Vec<String>>,
}

/// An index signature of a type.
#[derive(Clone, Debug)]
pub struct IndexInfo {
    /// Key type.
    pub key_type: Rc<Type>,
    /// Value type.
    pub value_type: Rc<Type>,
}

#[derive(Deserialize)]
struct IndexInfoResponse {
    #[serde(rename = "keyType")]
    key_type: TypeResponse,
    #[serde(rename = "valueType")]
    value_type: TypeResponse,
}

/// A diagnostic, with its message chain.
#[derive(Clone, Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Diagnostic {
    /// File the diagnostic is in, if any.
    pub file_name: Option<String>,
    /// Start (UTF-16 units), `-1` without a location.
    #[serde(default)]
    pub pos: i64,
    /// End.
    #[serde(default)]
    pub end: i64,
    /// Diagnostic code.
    #[serde(default)]
    pub code: i64,
    /// `DiagnosticCategory`.
    #[serde(default)]
    pub category: u32,
    /// The message.
    #[serde(default)]
    pub text: String,
    /// Chained explanations.
    #[serde(default)]
    pub message_chain: Vec<Diagnostic>,
}

/// A JSDoc tag as `getJsDocTags` reports it.
#[derive(Clone, Debug, Deserialize)]
pub struct JsDocTag {
    /// Tag name without `@`.
    pub name: String,
    /// The tag's text.
    #[serde(default)]
    pub text: Option<String>,
}

/// A question about one object that the [`Session`] answers once per
/// snapshot. [`Session::prefetch`] asks many of them in one pipelined batch;
/// the accessors below ask the ones still missing one at a time.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum Query {
    /// `getPropertiesOfType`.
    PropertiesOfType(u64),
    /// `getIndexInfosOfType`.
    IndexInfosOfType(u64),
    /// `getBaseTypes`.
    BaseTypes(u64),
    /// `getTypeArguments`.
    TypeArguments(u64),
    /// `type.types`.
    TypesOfType(u64),
    /// `type.aliasTypeArguments`.
    AliasTypeArguments(u64),
    /// `typeToString(type, undefined, flags)`.
    TypeToString(u64, Option<u32>),
    /// `type.getSymbol()`.
    SymbolOfType(u64),
    /// `type.aliasSymbol`.
    AliasSymbolOfType(u64),
    /// `type.target`.
    TargetOfType(u64),
    /// `symbol.parent`.
    ParentOfSymbol(u64),
    /// `symbol.members`.
    MembersOfSymbol(u64),
    /// `getAliasedSymbol`.
    AliasedSymbol(u64),
    /// `getJsDocTags`.
    JsDocTags(u64),
    /// `getDocumentationComment`.
    DocumentationComment(u64),
    /// `getTypeOfSymbol` (batched as `getTypesOfSymbols`).
    TypeOfSymbol(u64),
    /// `getTypeOfSymbolAtLocation` with a node handle.
    TypeOfSymbolAt(u64, String),
    /// `getSymbolAtLocation` (batched as `getSymbolsAtLocations`).
    SymbolAt(String),
    /// `getTypeAtLocation` (batched as `getTypeAtLocations`).
    TypeAt(String),
    /// `getConstantValue` of a node.
    ConstantValue(String),
    /// `isDefaultLibrary` of a file's metadata, by canonical path.
    IsDefaultLibrary(String),
    /// `typeToTypeNode(type, undefined, flags)`.
    TypeToTypeNode(u64, u32),
}

impl Query {
    /// The method that asks it on its own.
    fn method(&self) -> &'static str {
        match self {
            Query::PropertiesOfType(_) => "getPropertiesOfType",
            Query::IndexInfosOfType(_) => "getIndexInfosOfType",
            Query::BaseTypes(_) => "getBaseTypes",
            Query::TypeArguments(_) => "getTypeArguments",
            Query::TypesOfType(_) => "getTypesOfType",
            Query::AliasTypeArguments(_) => "getAliasTypeArgumentsOfType",
            Query::TypeToString(..) => "typeToString",
            Query::SymbolOfType(_) => "getSymbolOfType",
            Query::AliasSymbolOfType(_) => "getAliasSymbolOfType",
            Query::TargetOfType(_) => "getTargetOfType",
            Query::ParentOfSymbol(_) => "getParentOfSymbol",
            Query::MembersOfSymbol(_) => "getMembersOfSymbol",
            Query::AliasedSymbol(_) => "getAliasedSymbol",
            Query::JsDocTags(_) => "getJsDocTags",
            Query::DocumentationComment(_) => "getDocumentationComment",
            Query::TypeOfSymbol(_) => "getTypeOfSymbol",
            Query::TypeOfSymbolAt(..) => "getTypeOfSymbolAtLocation",
            Query::SymbolAt(_) => "getSymbolAtLocation",
            Query::TypeAt(_) => "getTypeAtLocation",
            Query::ConstantValue(_) => "getConstantValue",
            Query::IsDefaultLibrary(_) => "getSourceFileMetadata",
            Query::TypeToTypeNode(..) => "typeToTypeNode",
        }
    }
}

/// What a [`Query`] returned.
#[derive(Clone, Debug)]
pub(crate) enum Answer {
    Types(Vec<Rc<Type>>),
    Symbols(Vec<Rc<Symbol>>),
    IndexInfos(Vec<IndexInfo>),
    Type(Option<Rc<Type>>),
    Symbol(Option<Rc<Symbol>>),
    Text(String),
    Tags(Vec<JsDocTag>),
    Constant(Option<LiteralValue>),
    Bool(bool),
    Node(Option<Node>),
}

impl Answer {
    /// Whether two answers say the same: the same objects by handle, the
    /// same text.
    fn same(&self, other: &Answer) -> bool {
        let ids =
            |a: &[Rc<Type>], b: &[Rc<Type>]| a.iter().map(|t| t.id).eq(b.iter().map(|t| t.id));
        match (self, other) {
            (Answer::Types(a), Answer::Types(b)) => ids(a, b),
            (Answer::Symbols(a), Answer::Symbols(b)) => {
                a.iter().map(|s| s.id).eq(b.iter().map(|s| s.id))
            }
            (Answer::Type(a), Answer::Type(b)) => {
                a.as_ref().map(|t| t.id) == b.as_ref().map(|t| t.id)
            }
            (Answer::Symbol(a), Answer::Symbol(b)) => {
                a.as_ref().map(|s| s.id) == b.as_ref().map(|s| s.id)
            }
            (Answer::Text(a), Answer::Text(b)) => a == b,
            (Answer::Tags(a), Answer::Tags(b)) => {
                a.len() == b.len()
                    && a.iter()
                        .zip(b)
                        .all(|(x, y)| x.name == y.name && x.text == y.text)
            }
            (Answer::Constant(a), Answer::Constant(b)) => a == b,
            (Answer::Bool(a), Answer::Bool(b)) => a == b,
            _ => false,
        }
    }
}

/// The kinds of value an [`Answer`] holds.
pub(crate) trait FromAnswer: Sized {
    fn from_answer(a: Answer) -> Option<Self>;
}

macro_rules! from_answer {
    ($($t:ty => $variant:ident),* $(,)?) => {$(
        impl FromAnswer for $t {
            fn from_answer(a: Answer) -> Option<Self> {
                match a {
                    Answer::$variant(v) => Some(v),
                    _ => None,
                }
            }
        }
    )*};
}

from_answer! {
    Vec<Rc<Type>> => Types,
    Vec<Rc<Symbol>> => Symbols,
    Vec<IndexInfo> => IndexInfos,
    Option<Rc<Type>> => Type,
    Option<Rc<Symbol>> => Symbol,
    String => Text,
    Vec<JsDocTag> => Tags,
    Option<LiteralValue> => Constant,
    bool => Bool,
    Option<Node> => Node,
}

/// Most queries a batch merges into one array request.
const MERGED_BATCH: usize = 10_000;

/// A loaded program and its checker, backed by one `tsc --api` process.
pub struct Session {
    channel: RefCell<Channel>,
    snapshot: u64,
    project: String,
    /// `{"snapshot":…,"project":…` of every checker request.
    prefix: String,
    case_sensitive: bool,
    symbols: RefCell<HashMap<u64, Rc<Symbol>>>,
    types: RefCell<HashMap<u64, Rc<Type>>>,
    files: RefCell<HashMap<String, Rc<SourceFile>>>,
    number_type: RefCell<Option<u64>>,
    answers: RefCell<HashMap<Query, Answer>>,
    /// Whether [`Session::prefetch`] sends anything (off: every question is
    /// asked when the generator needs it, one at a time).
    pipelining: bool,
    /// Set when the prefetch is done: from then on a question the compiler
    /// has to answer is one the prefetch did not foresee.
    warmed: Cell<bool>,
    misses: RefCell<BTreeMap<&'static str, u64>>,
    /// Methods whose answers in a batch are dropped, as if the compiler had
    /// answered them with an error.
    #[cfg(test)]
    pub(crate) fail_in_batches: RefCell<HashSet<&'static str>>,
}

/// The `SyntaxKind` in a node handle (`index.kind.path`).
fn handle_kind(handle: &str) -> Option<u32> {
    handle.split('.').nth(1)?.parse().ok()
}

fn parse_json<T: DeserializeOwned>(method: &str, bytes: &[u8]) -> Result<Option<T>> {
    if bytes.is_empty() {
        return Ok(None);
    }
    serde_json::from_slice(bytes).map_err(|e| protocol(method, &e.to_string()))
}

impl Session {
    /// Starts the compiler and opens the project `config` (served from
    /// `files` when it is one of them). With `pipelining` off,
    /// [`Session::prefetch`] does nothing.
    pub fn open(
        exe: &Path,
        cwd: &Path,
        config: &str,
        files: VirtualFiles,
        pipelining: bool,
    ) -> Result<Session> {
        let channel = Channel::spawn(exe, cwd, files)?;
        let mut session = Session {
            channel: RefCell::new(channel),
            snapshot: 0,
            project: String::new(),
            prefix: String::new(),
            case_sensitive: true,
            symbols: RefCell::default(),
            types: RefCell::default(),
            files: RefCell::default(),
            number_type: RefCell::default(),
            answers: RefCell::default(),
            pipelining,
            warmed: Cell::new(false),
            misses: RefCell::default(),
            #[cfg(test)]
            fail_in_batches: RefCell::default(),
        };
        let init = session.raw_json("initialize", &Json::Null)?;
        session.case_sensitive = init["useCaseSensitiveFileNames"].as_bool().unwrap_or(true);
        let snap = session.raw_json("updateSnapshot", &json!({ "openProjects": [config] }))?;
        session.snapshot = snap["snapshot"]
            .as_u64()
            .ok_or_else(|| protocol("updateSnapshot", "no snapshot"))?;
        session.project = snap["projects"][0]["id"]
            .as_str()
            .ok_or_else(|| protocol("updateSnapshot", "no project"))?
            .to_owned();
        session.prefix = format!(
            "{{\"snapshot\":{},\"project\":{}",
            session.snapshot,
            quote(&session.project)
        );
        Ok(session)
    }

    /// Whether the host file system is case-sensitive.
    pub fn case_sensitive(&self) -> bool {
        self.case_sensitive
    }

    /// What the channel has done so far.
    pub fn stats(&self) -> super::channel::Stats {
        self.channel.borrow().stats()
    }

    /// Whether the compiler called back during a pipelined batch, which the
    /// protocol cannot serve: the session is closed, and the conversion has
    /// to be redone without pipelining.
    pub fn called_back_in_batch(&self) -> bool {
        self.channel.borrow().called_back_in_batch()
    }

    /// Whether [`Session::prefetch`] sends requests.
    pub fn pipelining(&self) -> bool {
        self.pipelining
    }

    /// Marks the prefetch as done; see [`Session::misses`].
    pub fn finish_prefetch(&self) {
        self.warmed.set(true);
    }

    /// The questions asked of the compiler one at a time since
    /// [`Session::finish_prefetch`], by method: what the prefetch did not
    /// foresee.
    pub fn misses(&self) -> BTreeMap<&'static str, u64> {
        self.misses.borrow().clone()
    }

    fn raw(&self, method: &str, params: &Json) -> Result<Vec<u8>> {
        let payload = serde_json::to_vec(params).map_err(|e| Error::Tsc(e.to_string()))?;
        self.channel.borrow_mut().request(method, &payload)
    }

    fn raw_json(&self, method: &str, params: &Json) -> Result<Json> {
        let bytes = self.raw(method, params)?;
        if bytes.is_empty() {
            return Ok(Json::Null);
        }
        serde_json::from_slice(&bytes).map_err(|e| protocol(method, &e.to_string()))
    }

    /// A request in the current snapshot and project.
    fn call(&self, method: &str, mut params: Json) -> Result<Json> {
        params["snapshot"] = json!(self.snapshot);
        params["project"] = json!(self.project);
        self.raw_json(method, &params)
    }

    fn call_as<T: DeserializeOwned>(&self, method: &str, params: Json) -> Result<T> {
        let v = self.call(method, params)?;
        serde_json::from_value(v).map_err(|e| protocol(method, &e.to_string()))
    }

    /// A checker request payload: the snapshot and project, then `fields`.
    fn payload(&self, fields: &str) -> Vec<u8> {
        let mut p = String::with_capacity(self.prefix.len() + fields.len() + 2);
        p.push_str(&self.prefix);
        p.push(',');
        p.push_str(fields);
        p.push('}');
        p.into_bytes()
    }

    fn symbol_from(&self, r: SymbolResponse) -> Rc<Symbol> {
        if let Some(s) = self.symbols.borrow().get(&r.id) {
            return Rc::clone(s);
        }
        let name = match r.name.strip_prefix("___") {
            Some(rest) => format!("__{rest}"),
            None => r.name.clone(),
        };
        let s = Rc::new(Symbol {
            id: r.id,
            name,
            escaped_name: r.name,
            flags: r.flags,
            declarations: r
                .declarations
                .iter()
                .filter_map(|d| NodeHandle::parse(d))
                .collect(),
            value_declaration: r.value_declaration.as_deref().and_then(NodeHandle::parse),
            parent: r.parent,
        });
        self.symbols.borrow_mut().insert(s.id, Rc::clone(&s));
        s
    }

    fn type_from(&self, r: TypeResponse) -> Rc<Type> {
        if let Some(t) = self.types.borrow().get(&r.id) {
            return Rc::clone(t);
        }
        let value = match r.value {
            Json::String(s) => Some(LiteralValue::String(s)),
            Json::Number(n) => n.as_f64().map(LiteralValue::Number),
            Json::Bool(b) => Some(LiteralValue::Bool(b)),
            _ => None,
        };
        let t = Rc::new(Type {
            id: r.id,
            flags: r.flags,
            object_flags: r.object_flags,
            value,
            intrinsic_name: r.intrinsic_name,
            symbol: r.symbol,
            alias_symbol: r.alias_symbol,
            target: r.target,
            element_flags: r.element_flags,
            fixed_length: r.fixed_length,
            texts: r.texts,
        });
        self.types.borrow_mut().insert(t.id, Rc::clone(&t));
        t
    }

    // ---- queries -----------------------------------------------------------

    /// The payload that asks `q` on its own.
    fn payload_for(&self, q: &Query) -> Vec<u8> {
        match q {
            Query::PropertiesOfType(id)
            | Query::IndexInfosOfType(id)
            | Query::BaseTypes(id)
            | Query::TypeArguments(id)
            | Query::TypeToString(id, None) => self.payload(&format!("\"type\":{id}")),
            Query::TypeToString(id, Some(f)) | Query::TypeToTypeNode(id, f) => {
                self.payload(&format!("\"type\":{id},\"flags\":{f}"))
            }
            Query::TypesOfType(id)
            | Query::AliasTypeArguments(id)
            | Query::SymbolOfType(id)
            | Query::AliasSymbolOfType(id)
            | Query::TargetOfType(id)
            | Query::ParentOfSymbol(id)
            | Query::MembersOfSymbol(id) => self.payload(&format!("\"objectId\":{id}")),
            Query::AliasedSymbol(id)
            | Query::JsDocTags(id)
            | Query::DocumentationComment(id)
            | Query::TypeOfSymbol(id) => self.payload(&format!("\"symbol\":{id}")),
            Query::TypeOfSymbolAt(id, h) => {
                self.payload(&format!("\"symbol\":{id},\"location\":{}", quote(h)))
            }
            Query::SymbolAt(h) | Query::TypeAt(h) | Query::ConstantValue(h) => {
                self.payload(&format!("\"location\":{}", quote(h)))
            }
            Query::IsDefaultLibrary(path) => self.payload(&format!("\"file\":{}", quote(path))),
        }
    }

    /// Decodes the response to `q`.
    fn parse(&self, q: &Query, bytes: &[u8]) -> Result<Answer> {
        let method = q.method();
        let types = |v: Option<Vec<TypeResponse>>| {
            Answer::Types(
                v.unwrap_or_default()
                    .into_iter()
                    .map(|r| self.type_from(r))
                    .collect(),
            )
        };
        let symbols = |v: Option<Vec<SymbolResponse>>| {
            Answer::Symbols(
                v.unwrap_or_default()
                    .into_iter()
                    .map(|r| self.symbol_from(r))
                    .collect(),
            )
        };
        let text = |v: Option<Json>| {
            Answer::Text(
                v.as_ref()
                    .and_then(Json::as_str)
                    .unwrap_or_default()
                    .to_owned(),
            )
        };
        Ok(match q {
            Query::PropertiesOfType(_) | Query::MembersOfSymbol(_) => {
                symbols(parse_json(method, bytes)?)
            }
            Query::BaseTypes(_)
            | Query::TypeArguments(_)
            | Query::TypesOfType(_)
            | Query::AliasTypeArguments(_) => types(parse_json(method, bytes)?),
            Query::IndexInfosOfType(_) => {
                let v: Option<Vec<IndexInfoResponse>> = parse_json(method, bytes)?;
                Answer::IndexInfos(
                    v.unwrap_or_default()
                        .into_iter()
                        .map(|i| IndexInfo {
                            key_type: self.type_from(i.key_type),
                            value_type: self.type_from(i.value_type),
                        })
                        .collect(),
                )
            }
            Query::TypeToString(..) | Query::DocumentationComment(_) => {
                text(parse_json(method, bytes)?)
            }
            Query::SymbolOfType(_)
            | Query::AliasSymbolOfType(_)
            | Query::ParentOfSymbol(_)
            | Query::AliasedSymbol(_)
            | Query::SymbolAt(_) => {
                let v: Option<SymbolResponse> = parse_json(method, bytes)?;
                Answer::Symbol(v.map(|r| self.symbol_from(r)))
            }
            Query::TargetOfType(_)
            | Query::TypeOfSymbol(_)
            | Query::TypeOfSymbolAt(..)
            | Query::TypeAt(_) => {
                let v: Option<TypeResponse> = parse_json(method, bytes)?;
                Answer::Type(v.map(|r| self.type_from(r)))
            }
            Query::JsDocTags(_) => {
                let v: Option<Vec<JsDocTag>> = parse_json(method, bytes)?;
                Answer::Tags(v.unwrap_or_default())
            }
            Query::ConstantValue(_) => Answer::Constant(match parse_json(method, bytes)? {
                Some(Json::String(s)) => Some(LiteralValue::String(s)),
                Some(Json::Number(n)) => n.as_f64().map(LiteralValue::Number),
                _ => None,
            }),
            Query::TypeToTypeNode(..) => {
                Answer::Node(SourceFile::parse(bytes.to_vec()).map(|sf| sf.root()))
            }
            Query::IsDefaultLibrary(_) => {
                let v: Option<Json> = parse_json(method, bytes)?;
                Answer::Bool(
                    v.and_then(|m| m["isDefaultLibrary"].as_bool())
                        .unwrap_or(false),
                )
            }
        })
    }

    /// Asks the compiler `q` on its own.
    fn ask(&self, q: &Query) -> Result<Answer> {
        let payload = self.payload_for(q);
        let bytes = self.channel.borrow_mut().request(q.method(), &payload)?;
        self.parse(q, &bytes)
    }

    /// The answer to `q` when it is known without asking the compiler. Reads
    /// only what is cached, so it never sends a request.
    fn local_answer(&self, q: &Query) -> Option<Answer> {
        match q {
            Query::JsDocTags(id) => {
                let s = self.known_symbol(*id)?;
                self.no_jsdoc_tags(&s).then(|| Answer::Tags(Vec::new()))
            }
            Query::DocumentationComment(id) => {
                let s = self.known_symbol(*id)?;
                self.no_documentation(&s)
                    .then(|| Answer::Text(String::new()))
            }
            Query::TypeOfSymbolAt(id, h) => {
                let s = self.known_symbol(*id)?;
                if !type_at_is_declared_type(&s, h) {
                    return None;
                }
                match self.answers.borrow().get(&Query::TypeOfSymbol(*id)) {
                    Some(a @ Answer::Type(Some(_))) => Some(a.clone()),
                    _ => None,
                }
            }
            _ => None,
        }
    }

    /// In verify mode ([`testing::verify_local_answers`]), asks the compiler
    /// `q` too and panics if it does not answer `local`.
    fn verify(&self, q: &Query, local: &Answer) -> Result<()> {
        if testing::verifying() {
            let real = self.ask(q)?;
            assert!(
                local.same(&real),
                "the session answered {q:?} with {local:?}, the compiler with {real:?}"
            );
        }
        Ok(())
    }

    /// The answer to `q`, asking the compiler if it is not known yet.
    fn answer(&self, q: Query) -> Result<Answer> {
        if let Some(a) = self.answers.borrow().get(&q) {
            return Ok(a.clone());
        }
        let a = match self.local_answer(&q) {
            Some(a) => {
                self.verify(&q, &a)?;
                a
            }
            None => {
                if self.warmed.get() {
                    *self.misses.borrow_mut().entry(q.method()).or_default() += 1;
                    testing::record_miss(q.method());
                }
                self.ask(&q)?
            }
        };
        self.answers.borrow_mut().insert(q, a.clone());
        Ok(a)
    }

    /// The answer to `q` as a `T`, asking the compiler if it is not known
    /// yet; an answer of another kind is a protocol error.
    fn get<T: FromAnswer>(&self, q: Query) -> Result<T> {
        let method = q.method();
        T::from_answer(self.answer(q)?).ok_or_else(|| protocol(method, "an answer of another kind"))
    }

    /// The answer to `q` if it is known; never asks the compiler.
    pub(crate) fn cached<T: FromAnswer>(&self, q: &Query) -> Option<T> {
        self.answers
            .borrow()
            .get(q)
            .cloned()
            .and_then(T::from_answer)
    }

    /// Whether `q` is answered already.
    pub fn knows(&self, q: &Query) -> bool {
        self.answers.borrow().contains_key(q)
    }

    /// Answers `queries` with one pipelined batch of requests; the ones of
    /// a kind the protocol takes as arrays share array requests. Queries
    /// the compiler answers with an error stay unanswered, so the accessor
    /// that needs one asks again (and reports that error) as it would
    /// without the batch. Sends nothing when pipelining is off.
    pub fn prefetch(&self, queries: impl IntoIterator<Item = Query>) -> Result<()> {
        if !self.pipelining {
            return Ok(());
        }
        let mut seen = HashSet::new();
        let mut single = Vec::new();
        let (mut of_symbols, mut at_locations, mut types_at) = (Vec::new(), Vec::new(), Vec::new());
        for q in queries {
            if self.knows(&q) || !seen.insert(q.clone()) {
                continue;
            }
            if let Some(a) = self.local_answer(&q) {
                self.verify(&q, &a)?;
                self.answers.borrow_mut().insert(q, a);
                continue;
            }
            match q {
                Query::TypeOfSymbol(id) => of_symbols.push(id),
                Query::SymbolAt(h) => at_locations.push(h),
                Query::TypeAt(h) => types_at.push(h),
                q => single.push(q),
            }
        }
        enum Target {
            One(Query),
            TypesOfSymbols(Vec<u64>),
            SymbolsAt(Vec<String>),
            TypesAt(Vec<String>),
        }
        let mut targets = Vec::new();
        let mut requests = Vec::new();
        let handles = |hs: &[String]| hs.iter().map(|h| quote(h)).collect::<Vec<_>>().join(",");
        for chunk in of_symbols.chunks(MERGED_BATCH) {
            let ids: Vec<String> = chunk.iter().map(u64::to_string).collect();
            requests.push((
                "getTypesOfSymbols",
                self.payload(&format!("\"symbols\":[{}]", ids.join(","))),
            ));
            targets.push(Target::TypesOfSymbols(chunk.to_vec()));
        }
        for chunk in at_locations.chunks(MERGED_BATCH) {
            requests.push((
                "getSymbolsAtLocations",
                self.payload(&format!("\"locations\":[{}]", handles(chunk))),
            ));
            targets.push(Target::SymbolsAt(chunk.to_vec()));
        }
        for chunk in types_at.chunks(MERGED_BATCH) {
            requests.push((
                "getTypeAtLocations",
                self.payload(&format!("\"locations\":[{}]", handles(chunk))),
            ));
            targets.push(Target::TypesAt(chunk.to_vec()));
        }
        for q in single {
            requests.push((q.method(), self.payload_for(&q)));
            targets.push(Target::One(q));
        }
        if requests.is_empty() {
            return Ok(());
        }
        #[allow(unused_mut)]
        let mut replies = self.channel.borrow_mut().request_batch(&requests)?;
        #[cfg(test)]
        for ((method, _), reply) in requests.iter().zip(replies.iter_mut()) {
            if self.fail_in_batches.borrow().contains(method) {
                *reply = None;
            }
        }
        let mut answers = Vec::new();
        for ((target, (method, _)), reply) in targets.into_iter().zip(&requests).zip(replies) {
            let Some(bytes) = reply else { continue };
            match target {
                Target::One(q) => {
                    if let Ok(a) = self.parse(&q, &bytes) {
                        answers.push((q, a));
                    }
                }
                Target::TypesOfSymbols(ids) => {
                    let v: Vec<Option<TypeResponse>> = parse_json(method, &bytes)
                        .ok()
                        .flatten()
                        .unwrap_or_default();
                    if v.len() == ids.len() {
                        for (id, t) in ids.into_iter().zip(v) {
                            let t = t.map(|r| self.type_from(r));
                            answers.push((Query::TypeOfSymbol(id), Answer::Type(t)));
                        }
                    }
                }
                Target::SymbolsAt(hs) => {
                    let v: Vec<Option<SymbolResponse>> = parse_json(method, &bytes)
                        .ok()
                        .flatten()
                        .unwrap_or_default();
                    if v.len() == hs.len() {
                        for (h, s) in hs.into_iter().zip(v) {
                            let s = s.map(|r| self.symbol_from(r));
                            answers.push((Query::SymbolAt(h), Answer::Symbol(s)));
                        }
                    }
                }
                Target::TypesAt(hs) => {
                    let v: Vec<Option<TypeResponse>> = parse_json(method, &bytes)
                        .ok()
                        .flatten()
                        .unwrap_or_default();
                    if v.len() == hs.len() {
                        for (h, t) in hs.into_iter().zip(v) {
                            let t = t.map(|r| self.type_from(r));
                            answers.push((Query::TypeAt(h), Answer::Type(t)));
                        }
                    }
                }
            }
        }
        self.answers.borrow_mut().extend(answers);
        Ok(())
    }

    // ---- JSDoc that cannot exist ---------------------------------------------

    /// The declarations of `s`, when all of them are in loaded files that are
    /// not default libraries (as far as the cache knows).
    fn user_declarations(&self, s: &Symbol) -> Option<Vec<Node>> {
        if s.declarations.is_empty() {
            return None;
        }
        s.declarations
            .iter()
            .map(|d| {
                let lib = self.cached::<bool>(&Query::IsDefaultLibrary(d.path.clone()));
                if lib != Some(false) {
                    return None;
                }
                self.loaded(d)
            })
            .collect()
    }

    /// Whether `getJsDocTags` of `s` is certainly empty. The compiler
    /// (`GetSymbolJSDocTags`, `declarationJSDocTags`) collects the tags of
    /// the JSDoc on each declaration or on the hosts that
    /// `GetNextJSDocCommentLocation` walks to, which are its ancestors, and
    /// inherits none; so when neither a declaration, nor its initializer,
    /// nor any ancestor carries a JSDoc comment with tags, there are none.
    fn no_jsdoc_tags(&self, s: &Symbol) -> bool {
        let Some(decls) = self.user_declarations(s) else {
            return false;
        };
        let tagged = |n: &Node| n.js_doc().iter().any(|d| !d.named_list("tags").is_empty());
        for decl in decls {
            if decl.flags() & node_flags::JSDoc != 0
                || (sk::FirstJSDocNode..=sk::LastJSDocNode).contains(&decl.kind())
                || decl.named("initializer").is_some_and(|i| tagged(&i))
            {
                return false;
            }
            let mut node = Some(decl);
            while let Some(n) = node {
                if tagged(&n) {
                    return false;
                }
                node = n.parent();
            }
        }
        true
    }

    /// Whether `getDocumentationComment` of `s` is certainly empty. The
    /// compiler (`getDocumentationFromDeclaration`, `getJSDocOrTag`) writes
    /// the comment text of a declaration's last JSDoc, so a declaration
    /// whose last JSDoc has no comment (only tags) adds nothing. For a
    /// declaration without JSDoc of its own it only looks further for
    /// parameters, type parameters, variables, function-like declarations
    /// and initializers, overloads, and members of classes or interfaces
    /// with base types; none of those may be involved.
    fn no_documentation(&self, s: &Symbol) -> bool {
        let Some(decls) = self.user_declarations(s) else {
            return false;
        };
        for decl in decls {
            if decl.flags() & node_flags::Reparsed != 0 {
                return false;
            }
            if let Some(last) = decl.js_doc().last() {
                if last.has_comment() {
                    return false;
                }
                continue;
            }
            if decl.named("initializer").is_some() {
                return false;
            }
            match decl.kind() {
                sk::PropertySignature | sk::PropertyDeclaration => {
                    let inherits = decl.parent().is_some_and(|p| {
                        matches!(
                            p.kind(),
                            sk::ClassDeclaration | sk::ClassExpression | sk::InterfaceDeclaration
                        ) && !p.named_list("heritageClauses").is_empty()
                    });
                    if inherits {
                        return false;
                    }
                }
                sk::InterfaceDeclaration
                | sk::ClassDeclaration
                | sk::TypeAliasDeclaration
                | sk::EnumDeclaration
                | sk::EnumMember
                | sk::TypeLiteral => {}
                _ => return false,
            }
        }
        true
    }

    // ---- program ---------------------------------------------------------

    /// `program.getSourceFileNames()`, in program order.
    pub fn source_file_names(&self) -> Result<Vec<String>> {
        self.call_as::<Option<Vec<String>>>("getSourceFileNames", json!({}))
            .map(Option::unwrap_or_default)
    }

    /// The decoded AST of a file (by file name or canonical path).
    pub fn source_file(&self, file: &str) -> Result<Rc<SourceFile>> {
        if let Some(sf) = self.files.borrow().get(file) {
            return Ok(Rc::clone(sf));
        }
        let bytes = self.raw(
            "getSourceFile",
            &json!({ "snapshot": self.snapshot, "project": self.project, "file": file }),
        )?;
        let sf = SourceFile::parse(bytes).ok_or_else(|| protocol("getSourceFile", file))?;
        let mut files = self.files.borrow_mut();
        files.insert(file.to_owned(), Rc::clone(&sf));
        files.insert(sf.path(), Rc::clone(&sf));
        Ok(sf)
    }

    /// Resolves a node handle.
    pub fn resolve(&self, h: &NodeHandle) -> Result<Node> {
        self.source_file(&h.path)?
            .node(h.index)
            .ok_or_else(|| protocol("resolve", &h.path))
    }

    /// Resolves a node handle in a file already loaded; never asks.
    pub(crate) fn loaded(&self, h: &NodeHandle) -> Option<Node> {
        self.files.borrow().get(&h.path)?.node(h.index)
    }

    /// Whether the file at canonical `path` is a default library file.
    pub fn is_default_library(&self, path: &str) -> Result<bool> {
        self.get(Query::IsDefaultLibrary(path.to_owned()))
    }

    /// The diagnostics `getPreEmitDiagnostics` collects, unsorted.
    pub fn pre_emit_diagnostics(&self) -> Result<Vec<Diagnostic>> {
        let mut out = Vec::new();
        for method in [
            "getConfigFileParsingDiagnostics",
            "getProgramDiagnostics",
            "getSyntacticDiagnostics",
            "getGlobalDiagnostics",
            "getSemanticDiagnostics",
        ] {
            let v: Option<Vec<Diagnostic>> = self.call_as(method, json!({}))?;
            out.extend(v.unwrap_or_default());
        }
        Ok(out)
    }

    // ---- checker ---------------------------------------------------------

    /// `getSymbolAtLocation`.
    pub fn symbol_at(&self, node: &Node) -> Result<Option<Rc<Symbol>>> {
        self.get(Query::SymbolAt(node.handle()))
    }

    /// `getSymbolAtLocation` for many nodes in one request.
    pub fn symbols_at(&self, nodes: &[Node]) -> Result<Vec<Option<Rc<Symbol>>>> {
        let handles: Vec<String> = nodes.iter().map(Node::handle).collect();
        self.prefetch(handles.iter().cloned().map(Query::SymbolAt))?;
        handles
            .into_iter()
            .map(|h| self.get(Query::SymbolAt(h)))
            .collect()
    }

    /// `getTypeAtLocation`.
    pub fn type_at(&self, node: &Node) -> Result<Option<Rc<Type>>> {
        self.get(Query::TypeAt(node.handle()))
    }

    /// `getTypeAtLocation` for many nodes in one request.
    pub fn types_at(&self, nodes: &[Node]) -> Result<Vec<Option<Rc<Type>>>> {
        let handles: Vec<String> = nodes.iter().map(Node::handle).collect();
        self.prefetch(handles.iter().cloned().map(Query::TypeAt))?;
        handles
            .into_iter()
            .map(|h| self.get(Query::TypeAt(h)))
            .collect()
    }

    /// `getTypeOfSymbol`.
    pub fn type_of_symbol(&self, s: &Symbol) -> Result<Rc<Type>> {
        self.get::<Option<Rc<Type>>>(Query::TypeOfSymbol(s.id))?
            .ok_or_else(|| protocol("getTypeOfSymbol", ""))
    }

    /// `getTypeOfSymbolAtLocation`.
    pub fn type_of_symbol_at(&self, s: &Symbol, node: &Node) -> Result<Rc<Type>> {
        self.get::<Option<Rc<Type>>>(Query::TypeOfSymbolAt(s.id, node.handle()))?
            .ok_or_else(|| protocol("getTypeOfSymbolAtLocation", ""))
    }

    /// `getPropertiesOfType`.
    pub fn properties_of_type(&self, t: &Type) -> Result<Vec<Rc<Symbol>>> {
        self.get(Query::PropertiesOfType(t.id))
    }

    /// `getIndexInfosOfType`.
    pub fn index_infos_of_type(&self, t: &Type) -> Result<Vec<IndexInfo>> {
        self.get(Query::IndexInfosOfType(t.id))
    }

    /// `getIndexTypeOfType(t, IndexKind.Number)` of the TS 5 API.
    pub fn number_index_type(&self, t: &Type) -> Result<Option<Rc<Type>>> {
        let number = self.number_type()?;
        Ok(self
            .index_infos_of_type(t)?
            .into_iter()
            .find(|i| i.key_type.id == number)
            .map(|i| i.value_type))
    }

    fn number_type(&self) -> Result<u64> {
        if let Some(id) = *self.number_type.borrow() {
            return Ok(id);
        }
        let v: Option<TypeResponse> = self.call_as("getNumberType", json!({}))?;
        let t = v
            .map(|r| self.type_from(r))
            .ok_or_else(|| protocol("getNumberType", ""))?;
        *self.number_type.borrow_mut() = Some(t.id);
        Ok(t.id)
    }

    /// `getBaseTypes` (empty unless `t` is a class or interface).
    pub fn base_types(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.get(Query::BaseTypes(t.id))
    }

    /// `getTypeArguments`.
    pub fn type_arguments(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.get(Query::TypeArguments(t.id))
    }

    /// `getAliasedSymbol`.
    pub fn aliased_symbol(&self, s: &Symbol) -> Result<Rc<Symbol>> {
        self.get::<Option<Rc<Symbol>>>(Query::AliasedSymbol(s.id))?
            .ok_or_else(|| protocol("getAliasedSymbol", ""))
    }

    /// `getConstantValue` of an enum member.
    pub fn constant_value(&self, node: &Node) -> Result<Option<LiteralValue>> {
        self.get(Query::ConstantValue(node.handle()))
    }

    /// `typeToString(type, undefined, flags)`.
    pub fn type_to_string(&self, t: &Type, flags: Option<u32>) -> Result<String> {
        self.get(Query::TypeToString(t.id, flags))
    }

    /// `typeToTypeNode(type, undefined, flags)` (`NodeBuilderFlags`), decoded.
    pub fn type_to_type_node(&self, t: &Type, flags: u32) -> Result<Option<Node>> {
        self.get(Query::TypeToTypeNode(t.id, flags))
    }

    /// `getJsDocTags` of a symbol.
    pub fn js_doc_tags(&self, s: &Symbol) -> Result<Vec<JsDocTag>> {
        self.get(Query::JsDocTags(s.id))
    }

    /// `getDocumentationComment` of a symbol (rendered as one string).
    pub fn documentation_comment(&self, s: &Symbol) -> Result<String> {
        self.get(Query::DocumentationComment(s.id))
    }

    // ---- lazily fetched related objects -----------------------------------

    fn related_symbol(&self, q: Query, handle: Option<u64>) -> Result<Option<Rc<Symbol>>> {
        let Some(h) = handle else { return Ok(None) };
        if let Some(s) = self.known_symbol(h) {
            return Ok(Some(s));
        }
        self.get(q)
    }

    /// `type.getSymbol()`.
    pub fn symbol_of_type(&self, t: &Type) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol(Query::SymbolOfType(t.id), t.symbol)
    }

    /// `type.aliasSymbol`.
    pub fn alias_symbol_of_type(&self, t: &Type) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol(Query::AliasSymbolOfType(t.id), t.alias_symbol)
    }

    /// `symbol.parent`.
    pub fn parent_of_symbol(&self, s: &Symbol) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol(Query::ParentOfSymbol(s.id), s.parent)
    }

    /// `symbol.members`, as a list.
    pub fn members_of_symbol(&self, s: &Symbol) -> Result<Vec<Rc<Symbol>>> {
        self.get(Query::MembersOfSymbol(s.id))
    }

    /// `type.target`.
    pub fn target_of_type(&self, t: &Type) -> Result<Option<Rc<Type>>> {
        let Some(h) = t.target else { return Ok(None) };
        if let Some(t) = self.known_type(h) {
            return Ok(Some(t));
        }
        self.get(Query::TargetOfType(t.id))
    }

    /// The symbol with handle `id`, if a response has carried it.
    pub fn known_symbol(&self, id: u64) -> Option<Rc<Symbol>> {
        self.symbols.borrow().get(&id).cloned()
    }

    /// The type with handle `id`, if a response has carried it.
    pub fn known_type(&self, id: u64) -> Option<Rc<Type>> {
        self.types.borrow().get(&id).cloned()
    }

    /// `type.types` of unions, intersections and template literals.
    pub fn types_of_type(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.get(Query::TypesOfType(t.id))
    }

    /// `type.aliasTypeArguments`.
    pub fn alias_type_arguments(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.get(Query::AliasTypeArguments(t.id))
    }
}

/// Whether `getTypeOfSymbolAtLocation(s, location)` is `getTypeOfSymbol(s)`.
/// The checker (`GetTypeOfSymbolAtLocation`, a port of TypeScript's) narrows
/// only at identifiers and property accesses, and otherwise returns
/// `getNonMissingTypeOfSymbol`, which is the declared type unless
/// `exactOptionalPropertyTypes` is set (quicktype never sets it). Here the
/// location is the declaration of the class, interface or type literal the
/// property belongs to.
pub(crate) fn type_at_is_declared_type(s: &Symbol, location: &str) -> bool {
    s.flags & sf::Property != 0
        && s.flags & (sf::ExportValue | sf::Alias) == 0
        && matches!(
            handle_kind(location),
            Some(sk::InterfaceDeclaration | sk::ClassDeclaration | sk::TypeLiteral)
        )
}

fn protocol(method: &str, detail: &str) -> Error {
    Error::Tsc(format!(
        "unexpected response to `{method}` from the TypeScript compiler: {detail}"
    ))
}
