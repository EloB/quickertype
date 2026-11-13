//! Typed requests to the TypeScript 7 checker API.
//!
//! Port of the parts of `typescript/dist/api/sync/api.js` (TypeScript
//! 7.0.2) that the schema generator needs. Symbols and types are numeric
//! handles that stay valid for the snapshot; their eagerly sent data is
//! cached by id, and related objects are fetched lazily with `{objectId}`
//! requests, exactly like the JavaScript client's object registries.

use std::cell::RefCell;
use std::collections::HashMap;
use std::path::Path;
use std::rc::Rc;

use serde::Deserialize;
use serde::de::DeserializeOwned;
use serde_json::{Value as Json, json};

use super::ast::{Node, SourceFile};
use super::channel::{Channel, VirtualFiles};
use crate::error::{Error, Result};

/// A node handle: `index.kind.path`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct NodeHandle {
    /// Index in the file's binary AST.
    pub index: usize,
    /// The file's canonical path.
    pub path: String,
}

impl NodeHandle {
    fn parse(s: &str) -> Option<NodeHandle> {
        let (index, rest) = s.split_once('.')?;
        let (_kind, path) = rest.split_once('.')?;
        Some(NodeHandle {
            index: index.parse().ok()?,
            path: path.to_owned(),
        })
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

/// A loaded program and its checker, backed by one `tsc --api` process.
pub struct Session {
    channel: RefCell<Channel>,
    snapshot: u64,
    project: String,
    case_sensitive: bool,
    symbols: RefCell<HashMap<u64, Rc<Symbol>>>,
    types: RefCell<HashMap<u64, Rc<Type>>>,
    files: RefCell<HashMap<String, Rc<SourceFile>>>,
    default_lib: RefCell<HashMap<String, bool>>,
    number_type: RefCell<Option<u64>>,
}

impl Session {
    /// Starts the compiler and opens the project `config` (served from
    /// `files` when it is one of them).
    pub fn open(exe: &Path, cwd: &Path, config: &str, files: VirtualFiles) -> Result<Session> {
        let channel = Channel::spawn(exe, cwd, files)?;
        let mut session = Session {
            channel: RefCell::new(channel),
            snapshot: 0,
            project: String::new(),
            case_sensitive: true,
            symbols: RefCell::default(),
            types: RefCell::default(),
            files: RefCell::default(),
            default_lib: RefCell::default(),
            number_type: RefCell::default(),
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
        Ok(session)
    }

    /// Whether the host file system is case-sensitive.
    pub fn case_sensitive(&self) -> bool {
        self.case_sensitive
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

    fn opt_symbol(&self, method: &str, params: Json) -> Result<Option<Rc<Symbol>>> {
        let v: Option<SymbolResponse> = self.call_as(method, params)?;
        Ok(v.map(|r| self.symbol_from(r)))
    }

    fn opt_type(&self, method: &str, params: Json) -> Result<Option<Rc<Type>>> {
        let v: Option<TypeResponse> = self.call_as(method, params)?;
        Ok(v.map(|r| self.type_from(r)))
    }

    fn type_list(&self, method: &str, params: Json) -> Result<Vec<Rc<Type>>> {
        let v: Option<Vec<TypeResponse>> = self.call_as(method, params)?;
        Ok(v.unwrap_or_default()
            .into_iter()
            .map(|r| self.type_from(r))
            .collect())
    }

    fn symbol_list(&self, method: &str, params: Json) -> Result<Vec<Rc<Symbol>>> {
        let v: Option<Vec<SymbolResponse>> = self.call_as(method, params)?;
        Ok(v.unwrap_or_default()
            .into_iter()
            .map(|r| self.symbol_from(r))
            .collect())
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

    /// Whether the file at canonical `path` is a default library file.
    pub fn is_default_library(&self, path: &str) -> Result<bool> {
        if let Some(b) = self.default_lib.borrow().get(path) {
            return Ok(*b);
        }
        let meta = self.call("getSourceFileMetadata", json!({ "file": path }))?;
        let b = meta["isDefaultLibrary"].as_bool().unwrap_or(false);
        self.default_lib.borrow_mut().insert(path.to_owned(), b);
        Ok(b)
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
        self.opt_symbol("getSymbolAtLocation", json!({ "location": node.handle() }))
    }

    /// `getSymbolAtLocation` for many nodes in one request.
    pub fn symbols_at(&self, nodes: &[Node]) -> Result<Vec<Option<Rc<Symbol>>>> {
        let locations: Vec<String> = nodes.iter().map(Node::handle).collect();
        let v: Vec<Option<SymbolResponse>> =
            self.call_as("getSymbolsAtLocations", json!({ "locations": locations }))?;
        Ok(v.into_iter()
            .map(|r| r.map(|r| self.symbol_from(r)))
            .collect())
    }

    /// `getTypeAtLocation`.
    pub fn type_at(&self, node: &Node) -> Result<Option<Rc<Type>>> {
        self.opt_type("getTypeAtLocation", json!({ "location": node.handle() }))
    }

    /// `getTypeAtLocation` for many nodes in one request.
    pub fn types_at(&self, nodes: &[Node]) -> Result<Vec<Option<Rc<Type>>>> {
        let locations: Vec<String> = nodes.iter().map(Node::handle).collect();
        let v: Vec<Option<TypeResponse>> =
            self.call_as("getTypeAtLocations", json!({ "locations": locations }))?;
        Ok(v.into_iter()
            .map(|r| r.map(|r| self.type_from(r)))
            .collect())
    }

    /// `getTypeOfSymbol`.
    pub fn type_of_symbol(&self, s: &Symbol) -> Result<Rc<Type>> {
        self.opt_type("getTypeOfSymbol", json!({ "symbol": s.id }))?
            .ok_or_else(|| protocol("getTypeOfSymbol", ""))
    }

    /// `getTypeOfSymbolAtLocation`.
    pub fn type_of_symbol_at(&self, s: &Symbol, node: &Node) -> Result<Rc<Type>> {
        self.opt_type(
            "getTypeOfSymbolAtLocation",
            json!({ "symbol": s.id, "location": node.handle() }),
        )?
        .ok_or_else(|| protocol("getTypeOfSymbolAtLocation", ""))
    }

    /// `getPropertiesOfType`.
    pub fn properties_of_type(&self, t: &Type) -> Result<Vec<Rc<Symbol>>> {
        self.symbol_list("getPropertiesOfType", json!({ "type": t.id }))
    }

    /// `getIndexInfosOfType`.
    pub fn index_infos_of_type(&self, t: &Type) -> Result<Vec<IndexInfo>> {
        let v: Option<Vec<IndexInfoResponse>> =
            self.call_as("getIndexInfosOfType", json!({ "type": t.id }))?;
        Ok(v.unwrap_or_default()
            .into_iter()
            .map(|i| IndexInfo {
                key_type: self.type_from(i.key_type),
                value_type: self.type_from(i.value_type),
            })
            .collect())
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
        let t = self
            .opt_type("getNumberType", json!({}))?
            .ok_or_else(|| protocol("getNumberType", ""))?;
        *self.number_type.borrow_mut() = Some(t.id);
        Ok(t.id)
    }

    /// `getBaseTypes` (empty unless `t` is a class or interface).
    pub fn base_types(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.type_list("getBaseTypes", json!({ "type": t.id }))
    }

    /// `getTypeArguments`.
    pub fn type_arguments(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.type_list("getTypeArguments", json!({ "type": t.id }))
    }

    /// `getAliasedSymbol`.
    pub fn aliased_symbol(&self, s: &Symbol) -> Result<Rc<Symbol>> {
        self.opt_symbol("getAliasedSymbol", json!({ "symbol": s.id }))?
            .ok_or_else(|| protocol("getAliasedSymbol", ""))
    }

    /// `getConstantValue` of an enum member.
    pub fn constant_value(&self, node: &Node) -> Result<Option<LiteralValue>> {
        Ok(
            match self.call("getConstantValue", json!({ "location": node.handle() }))? {
                Json::String(s) => Some(LiteralValue::String(s)),
                Json::Number(n) => n.as_f64().map(LiteralValue::Number),
                _ => None,
            },
        )
    }

    /// `typeToString(type, undefined, flags)`.
    pub fn type_to_string(&self, t: &Type, flags: Option<u32>) -> Result<String> {
        let mut params = json!({ "type": t.id });
        if let Some(f) = flags {
            params["flags"] = json!(f);
        }
        Ok(self
            .call("typeToString", params)?
            .as_str()
            .unwrap_or_default()
            .to_owned())
    }

    /// `typeToTypeNode(type)`, decoded.
    pub fn type_to_type_node(&self, t: &Type) -> Result<Option<Node>> {
        let bytes = self.raw(
            "typeToTypeNode",
            &json!({ "snapshot": self.snapshot, "project": self.project, "type": t.id }),
        )?;
        Ok(SourceFile::parse(bytes).map(|sf| sf.root()))
    }

    /// `getJsDocTags` of a symbol.
    pub fn js_doc_tags(&self, s: &Symbol) -> Result<Vec<JsDocTag>> {
        self.call_as::<Option<Vec<JsDocTag>>>("getJsDocTags", json!({ "symbol": s.id }))
            .map(Option::unwrap_or_default)
    }

    /// `getDocumentationComment` of a symbol (rendered as one string).
    pub fn documentation_comment(&self, s: &Symbol) -> Result<String> {
        Ok(self
            .call("getDocumentationComment", json!({ "symbol": s.id }))?
            .as_str()
            .unwrap_or_default()
            .to_owned())
    }

    // ---- lazily fetched related objects -----------------------------------

    fn related_symbol(
        &self,
        method: &str,
        object: u64,
        handle: Option<u64>,
    ) -> Result<Option<Rc<Symbol>>> {
        let Some(h) = handle else { return Ok(None) };
        if let Some(s) = self.symbols.borrow().get(&h) {
            return Ok(Some(Rc::clone(s)));
        }
        self.opt_symbol(method, json!({ "objectId": object }))
    }

    /// `type.getSymbol()`.
    pub fn symbol_of_type(&self, t: &Type) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol("getSymbolOfType", t.id, t.symbol)
    }

    /// `type.aliasSymbol`.
    pub fn alias_symbol_of_type(&self, t: &Type) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol("getAliasSymbolOfType", t.id, t.alias_symbol)
    }

    /// `symbol.parent`.
    pub fn parent_of_symbol(&self, s: &Symbol) -> Result<Option<Rc<Symbol>>> {
        self.related_symbol("getParentOfSymbol", s.id, s.parent)
    }

    /// `symbol.members`, as a list.
    pub fn members_of_symbol(&self, s: &Symbol) -> Result<Vec<Rc<Symbol>>> {
        self.symbol_list("getMembersOfSymbol", json!({ "objectId": s.id }))
    }

    /// `type.target`.
    pub fn target_of_type(&self, t: &Type) -> Result<Option<Rc<Type>>> {
        let Some(h) = t.target else { return Ok(None) };
        if let Some(t) = self.types.borrow().get(&h) {
            return Ok(Some(Rc::clone(t)));
        }
        self.opt_type("getTargetOfType", json!({ "objectId": t.id }))
    }

    /// `type.types` of unions, intersections and template literals.
    pub fn types_of_type(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.type_list("getTypesOfType", json!({ "objectId": t.id }))
    }

    /// `type.aliasTypeArguments`.
    pub fn alias_type_arguments(&self, t: &Type) -> Result<Vec<Rc<Type>>> {
        self.type_list("getAliasTypeArgumentsOfType", json!({ "objectId": t.id }))
    }
}

fn protocol(method: &str, detail: &str) -> Error {
    Error::Tsc(format!(
        "unexpected response to `{method}` from the TypeScript compiler: {detail}"
    ))
}
