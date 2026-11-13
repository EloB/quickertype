//! Port of `packages/quicktype-core/src/input/JSONSchemaInput.ts`.
//!
//! Turns JSON Schema documents into a type graph:
//!
//! - **Addresses.** Every schema document, `$ref` and `$id` is a urijs URI
//!   ([`quicktype_js_compat::uri`]); a [`Ref`] is a normalized address plus
//!   a path into the document (the fragment). Windows paths are first
//!   turned into `file:` URIs.
//! - **`$id`s.** A `Canonizer` walks every document the first time it is
//!   fetched and maps each `$id`-introduced ("virtual") location to its
//!   canonical one.
//! - **Resolution.** A `Resolver` fetches documents lazily from a
//!   [`JsonSchemaStore`], *while* types are being built, exactly where the
//!   TypeScript awaits them: which `$id`s are known when, the
//!   `--debug print-schema-resolving` trace and which error is reported
//!   first all depend on that order.
//! - **Types.** Each schema becomes a unique intersection of the types its
//!   keywords describe (a union for `type`/`properties`/`items`/`enum`/
//!   `const`, the `$ref` target, `allOf` cases, the `oneOf` and `anyOf`
//!   unions); rewrites resolve those later. The attribute producers add
//!   descriptions, accessor names, defaults, constraints, ….
//!
//! [`JsonSchemaInput`] is the input itself: `addSource`, and `addTypes` as
//! [`JsonSchemaInput::add_types`], which takes the parts of TypeScript's
//! `RunContext` it uses as parameters.
//!
//! JavaScript exceptions that TypeScript lets escape (a urijs `URIError` or
//! `TypeError`, a `TypeError` from reading a property of `null`) are
//! [`JsException`](crate::messages::JsException)s with the same name and
//! message.

use std::cell::RefCell;
use std::fmt;
use std::future::Future;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};
use quicktype_js_compat::sort::{compare_utf16, sort_by};
use quicktype_js_compat::uri::{Uri, UriError, decode_uri_component};
use quicktype_js_compat::{number, utf16};

use crate::attributes::accessor_names::accessor_names_attribute_producer;
use crate::attributes::constraints::{
    min_max_attribute_producer, min_max_items_attribute_producer,
    min_max_length_attribute_producer, pattern_attribute_producer,
};
use crate::attributes::default_value::default_value_attribute_producer;
use crate::attributes::description::description_attribute_producer;
use crate::attributes::enum_values::enum_values_attribute_producer;
use crate::attributes::string_types::StringTypes;
use crate::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributes, combine_type_attributes2,
    make_type_attributes_inferred,
};
use crate::attributes::type_names::{
    NamesTypeAttributeKind, TypeNames, make_names_type_attributes, modify_type_names,
    singularize_type_names,
};
use crate::attributes::uri_attributes::uri_schema_attributes_producer;
use crate::input::inputs::Input;
use crate::input::io::{GrowStack, LocalBoxFuture, grow_stack};
use crate::input::json_schema_store::{JsonSchema, JsonSchemaStore, SchemaCache};
use crate::input::path_element::PathElement;
use crate::messages::{
    ErrorKind, JsErrorName, MessageValue, QuickTypeError, Result, message_error,
};
use crate::run::RunContext;
use crate::support::collection_utils::{EqualityMap, JsEquals, JsHash, add_hash_code, hash_string};
use crate::support::fast_hash::{HashMap, HashSet};
use crate::support::parse_json::parse_json;
use crate::support::recursion::stack_overflow;
use crate::support::support::{assert, console_log, defined, panic};
use crate::support::windows_paths::fix_windows_path;
use crate::ty::transformed_string_type::{TypeKind, transformed_string_type_targets};
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_ref::TypeRef;

// ---------------------------------------------------------------------------
// JavaScript exceptions

/// A JavaScript `TypeError` (reading a property of `null`, calling a
/// non-function), which TypeScript lets escape.
pub(crate) fn type_error(message: impl Into<String>) -> QuickTypeError {
    QuickTypeError::js_exception(JsErrorName::TypeError, message)
}

/// A urijs (or `decodeURIComponent`) exception, with its own name.
fn uri_error(e: UriError) -> QuickTypeError {
    let name = JsErrorName::from_name(e.name()).unwrap_or(JsErrorName::Error);
    QuickTypeError::js_exception(name, e.message())
}

/// `withRef(ref, props)`: the `ref` property first, then the others.
fn with_ref(
    r: &Ref,
    props: Vec<(&'static str, MessageValue)>,
) -> Vec<(&'static str, MessageValue)> {
    let mut properties = vec![("ref", r.message_value())];
    properties.extend(props);
    properties
}

/// `checkJSONSchemaObject(x, refOrLoc)`: `x` as an object, or an error for
/// arrays, `null` and other non-objects.
fn check_json_schema_object(
    x: &JsonSchema,
    r: impl FnOnce() -> Result<Ref>,
) -> Result<&Rc<IndexMap<String, JsonSchema>>> {
    match x {
        JsonSchema::Object(map) => Ok(map),
        JsonSchema::Array(_) => message_error(
            ErrorKind::SchemaArrayIsInvalidSchema,
            with_ref(&r()?, vec![]),
        ),
        JsonSchema::Null => message_error(
            ErrorKind::SchemaNullIsInvalidSchema,
            with_ref(&r()?, vec![]),
        ),
        other => message_error(
            ErrorKind::SchemaInvalidJSONSchemaType,
            with_ref(&r()?, vec![("type", other.type_of().into())]),
        ),
    }
}

/// `checkJSONSchema(x, refOrLoc)`: a boolean or an object.
fn check_json_schema(x: &JsonSchema, r: impl FnOnce() -> Result<Ref>) -> Result<()> {
    if let JsonSchema::Bool(_) = x {
        return Ok(());
    }
    check_json_schema_object(x, r).map(|_| ())
}

/// `/^[0-9]+$/`.
fn is_number_string(s: &str) -> bool {
    !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit())
}

thread_local! {
    /// `normalizeURI` is a pure function of the URI; quicktype calls it for
    /// every `Ref` it creates.
    static NORMALIZED: RefCell<HashMap<Uri, std::result::Result<Uri, UriError>>> =
        RefCell::new(HashMap::default());
}

/// `normalizeURI(uri)`: `new URI(URI.decode(uri.clone().normalize().toString()))`.
/// The decoding is what lets addresses be read as files, and it throws on a
/// malformed escape (`URI malformed`).
fn normalize_uri(uri: &Uri) -> Result<Uri> {
    if let Some(cached) = NORMALIZED.with(|m| m.borrow().get(uri).cloned()) {
        return cached.map_err(uri_error);
    }
    let result = (|| {
        let mut normalized = uri.js_clone();
        normalized.normalize()?;
        Uri::parse(&decode_uri_component(&normalized.to_string())?)
    })();
    NORMALIZED.with(|m| {
        let mut m = m.borrow_mut();
        if m.len() > 100_000 {
            m.clear();
        }
        m.insert(uri.clone(), result.clone());
    });
    result.map_err(uri_error)
}

/// `normalizeURI(string)`: parse (after `fixWindowsPath`), then normalize.
fn normalize_uri_string(uri: &str) -> Result<Uri> {
    normalize_uri(&Uri::parse(&fix_windows_path(uri)).map_err(uri_error)?)
}

// ---------------------------------------------------------------------------
// Ref

/// `Ref`: a location in a schema document, as an address (a normalized URI
/// without fragment, absent only for `Ref.root(undefined)`) and a path.
#[derive(Clone, Debug)]
pub struct Ref {
    address_uri: Option<Uri>,
    path: Vec<PathElement>,
}

impl Ref {
    /// `Ref.root(address)`: the root of the document at `address`, with an
    /// empty path.
    pub fn root(address: Option<&str>) -> Result<Ref> {
        let uri = match address {
            Some(a) => Some(Uri::parse(&fix_windows_path(a)).map_err(uri_error)?),
            None => None,
        };
        Ref::new(uri, Vec::new())
    }

    /// `Ref.parsePath(path)`: a leading `/` is `Root`, the rest is split on
    /// `/` without any unescaping.
    fn parse_path(path: &str) -> Vec<PathElement> {
        let mut elements = Vec::new();
        let path = match path.strip_prefix('/') {
            Some(rest) => {
                elements.push(PathElement::Root);
                rest
            }
            None => path,
        };
        if !path.is_empty() {
            elements.extend(
                path.split('/')
                    .map(|part| PathElement::KeyOrIndex(part.to_owned())),
            );
        }
        elements
    }

    /// `Ref.parseURI(uri)`: the fragment is the path; an empty fragment of a
    /// URI with a host or file name is the root (`/`).
    pub fn parse_uri(uri: &Uri) -> Result<Ref> {
        let mut uri = uri.js_clone();
        let mut path = uri.fragment().to_owned();
        uri.set_fragment("");
        if (!uri.host().is_empty() || !uri.filename().is_empty()) && path.is_empty() {
            path = "/".to_owned();
        }
        let elements = Ref::parse_path(&path);
        Ref::new(Some(uri), elements)
    }

    /// `Ref.parse(ref)`: a `$ref`/`$id` string (after `fixWindowsPath`).
    pub fn parse(r: &str) -> Result<Ref> {
        Ref::parse_uri(&Uri::parse(&fix_windows_path(r)).map_err(uri_error)?)
    }

    /// `new Ref(addressURI, path)`: normalizes the address, which must not
    /// have a fragment.
    pub fn new(address_uri: Option<Uri>, path: Vec<PathElement>) -> Result<Ref> {
        let address_uri = match address_uri {
            Some(uri) => {
                assert(
                    uri.fragment().is_empty(),
                    &format!("Ref URI with fragment is not allowed: {uri}"),
                )?;
                Some(normalize_uri(&uri)?)
            }
            None => None,
        };
        Ok(Ref { address_uri, path })
    }

    /// `addressURI`.
    pub fn address_uri(&self) -> Option<&Uri> {
        self.address_uri.as_ref()
    }

    /// `path`.
    pub fn path(&self) -> &[PathElement] {
        &self.path
    }

    /// `hasAddress`.
    pub fn has_address(&self) -> bool {
        self.address_uri.is_some()
    }

    /// `address`: the address as a string (an internal error without one).
    pub fn address(&self) -> Result<String> {
        Ok(defined(self.address_uri.as_ref())?.to_string())
    }

    /// `isRoot`: the path is exactly the root.
    pub fn is_root(&self) -> bool {
        self.path == [PathElement::Root]
    }

    fn push_element(&self, element: PathElement) -> Result<Ref> {
        let mut path = self.path.clone();
        path.push(element);
        Ref::new(self.address_uri.clone(), path)
    }

    /// `push(...keys)`.
    pub fn push(&self, keys: &[&str]) -> Result<Ref> {
        let mut r = self.clone();
        for key in keys {
            r = r.push_element(PathElement::KeyOrIndex((*key).to_owned()))?;
        }
        Ok(r)
    }

    /// `pushObject()`.
    pub fn push_object(&self) -> Result<Ref> {
        self.push_element(PathElement::Object)
    }

    /// `pushType(index)`.
    pub fn push_type(&self, index: usize) -> Result<Ref> {
        self.push_element(PathElement::Type(index))
    }

    /// `resolveAgainst(base)`: this address resolved against the base's
    /// (urijs `absoluteTo`), or the base's address if this has none.
    pub fn resolve_against(&self, base: Option<&Ref>) -> Result<Ref> {
        let mut address_uri = self.address_uri.clone();
        if let Some(base_uri) = base.and_then(|b| b.address_uri.as_ref()) {
            address_uri = Some(match &address_uri {
                None => base_uri.clone(),
                Some(uri) => uri.absolute_to(base_uri).map_err(uri_error)?,
            });
        }
        Ref::new(address_uri, self.path.clone())
    }

    /// `name`: the last all-digit key of the path, else the address's file
    /// name without its suffix (`Something` if that is empty).
    pub fn name(&self) -> Result<String> {
        for element in self.path.iter().rev() {
            match element {
                PathElement::Root => break,
                PathElement::KeyOrIndex(key) => {
                    if is_number_string(key) {
                        return Ok(key.clone());
                    }
                }
                PathElement::Type(_) | PathElement::Object => {
                    return panic("We shouldn't try to get the name of Type or Object refs");
                }
            }
        }
        let (mut name, suffix) = match &self.address_uri {
            Some(uri) => (uri.filename().to_owned(), uri.suffix()),
            None => (String::new(), ""),
        };
        if utf16::len(&name) > suffix.len() + 1 {
            // The suffix and its dot are ASCII.
            name.truncate(name.len() - suffix.len() - 1);
        }
        if name.is_empty() {
            return Ok("Something".to_owned());
        }
        Ok(name)
    }

    /// `definitionName`: the last key, if the one before it is
    /// `definitions` or `$defs`.
    pub fn definition_name(&self) -> Option<&str> {
        let len = self.path.len();
        let parent = self.path.get(len.checked_sub(2)?)?.key_or_index();
        if parent == Some("definitions") || parent == Some("$defs") {
            return self.path.last()?.key_or_index();
        }
        None
    }

    /// The `Ref` as a message property (it has its own `toString`).
    pub fn message_value(&self) -> MessageValue {
        MessageValue::Display(self.to_string())
    }

    /// `lookup(local, path, root)`.
    fn lookup(
        &self,
        local: &JsonSchema,
        path: &[PathElement],
        root: &JsonSchema,
    ) -> Result<JsonSchema> {
        grow_stack(|| self.lookup_step(local, path, root))
    }

    /// One step of [`lookup`](Self::lookup).
    fn lookup_step(
        &self,
        local: &JsonSchema,
        path: &[PathElement],
        root: &JsonSchema,
    ) -> Result<JsonSchema> {
        let ref_maker = || Ref::new(self.address_uri.clone(), path.to_vec());
        let Some((first, rest)) = path.split_first() else {
            check_json_schema(local, ref_maker)?;
            return Ok(local.clone());
        };
        match first {
            PathElement::Root => self.lookup(root, rest, root),
            PathElement::KeyOrIndex(key) => {
                if let JsonSchema::Array(items) = local {
                    if !is_number_string(key) {
                        return message_error(
                            ErrorKind::SchemaCannotIndexArrayWithNonNumber,
                            with_ref(&ref_maker()?, vec![("actual", key.as_str().into())]),
                        );
                    }
                    // `Number.parseInt(key, 10)`.
                    let index: f64 = key.parse().unwrap_or(f64::INFINITY);
                    if index >= items.len() as f64 {
                        return message_error(
                            ErrorKind::SchemaIndexNotInArray,
                            with_ref(&ref_maker()?, vec![("index", MessageValue::Number(index))]),
                        );
                    }
                    return self.lookup(&items[index as usize], rest, root);
                }
                if !has_own_property(local, key) {
                    return message_error(
                        ErrorKind::SchemaKeyNotInObject,
                        with_ref(&ref_maker()?, vec![("key", key.as_str().into())]),
                    );
                }
                let object = check_json_schema_object(local, ref_maker)?;
                let value = object
                    .get(key.as_str())
                    .cloned()
                    .unwrap_or(JsonSchema::Null);
                self.lookup(&value, rest, root)
            }
            PathElement::Type(_) => panic("Cannot look up path that indexes \"type\""),
            PathElement::Object => panic("Cannot look up path that indexes \"object\""),
        }
    }

    /// `lookupRef(root)`: the schema this ref's path designates in `root`.
    pub fn lookup_ref(&self, root: &JsonSchema) -> Result<JsonSchema> {
        self.lookup(root, &self.path, root)
    }
}

/// `hasOwnProperty(x, key)` (collection-utils): own keys of objects; for
/// strings, `length` and the indexes of their UTF-16 code units.
fn has_own_property(x: &JsonSchema, key: &str) -> bool {
    match x {
        JsonSchema::Object(map) => map.contains_key(key),
        JsonSchema::String(s) => {
            key == "length"
                || (quicktype_js_compat::json::is_array_index(key)
                    && key.parse::<usize>().is_ok_and(|i| i < utf16::len(s)))
        }
        _ => false,
    }
}

/// `toString()`: `address#path`, with path elements joined by `/`.
impl fmt::Display for Ref {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if let Some(uri) = &self.address_uri {
            write!(f, "{uri}")?;
        }
        f.write_str("#")?;
        for (i, element) in self.path.iter().enumerate() {
            if i > 0 {
                f.write_str("/")?;
            }
            write!(f, "{element}")?;
        }
        Ok(())
    }
}

impl JsHash for Ref {
    /// `hashCode()`.
    fn hash_code(&self) -> i64 {
        let mut acc = self.address_uri.as_ref().map(|u| u.to_string()).hash_code();
        for element in &self.path {
            acc = add_hash_code(acc, element.kind());
            match element {
                PathElement::Type(index) => acc = add_hash_code(acc, *index as i64),
                PathElement::KeyOrIndex(key) => {
                    acc = add_hash_code(acc, i64::from(hash_string(key)))
                }
                _ => {}
            }
        }
        acc
    }
}

impl JsEquals for Ref {
    /// `equals(other)`: urijs `equals` on the addresses (normalized, query
    /// parameters in any order) and equal paths. urijs can only throw here
    /// for addresses that could not have been constructed; that counts as
    /// unequal.
    fn js_equals(&self, other: &Self) -> bool {
        let addresses_equal = match (&self.address_uri, &other.address_uri) {
            (Some(a), Some(b)) => a.equals(b).unwrap_or(false),
            (None, None) => true,
            _ => false,
        };
        addresses_equal && self.path == other.path
    }
}

// ---------------------------------------------------------------------------
// Location, Canonizer, Resolver

/// `Location`: where a schema is, canonically (its document and path) and
/// virtually (relative to the innermost `$id`).
#[derive(Clone, Debug)]
struct Location {
    canonical_ref: Ref,
    virtual_ref: Ref,
    have_id: bool,
}

impl Location {
    fn new(canonical_ref: Ref, virtual_ref: Option<Ref>, have_id: bool) -> Location {
        let virtual_ref = virtual_ref.unwrap_or_else(|| canonical_ref.clone());
        Location {
            canonical_ref,
            virtual_ref,
            have_id,
        }
    }

    /// `updateWithID(id)`: a string `$id` starts a new virtual location.
    fn update_with_id(&self, id: Option<&JsonSchema>) -> Result<Location> {
        let Some(JsonSchema::String(id)) = id else {
            return Ok(self.clone());
        };
        let parsed = Ref::parse(id)?;
        let virtual_ref = if self.have_id {
            parsed.resolve_against(Some(&self.virtual_ref))?
        } else {
            parsed
        };
        if !self.have_id && !virtual_ref.has_address() {
            return message_error(
                ErrorKind::SchemaIDMustHaveAddress,
                with_ref(&self.canonical_ref, vec![("id", id.as_str().into())]),
            );
        }
        Ok(Location::new(
            self.canonical_ref.clone(),
            Some(virtual_ref),
            true,
        ))
    }

    fn push(&self, keys: &[&str]) -> Result<Location> {
        Ok(Location::new(
            self.canonical_ref.push(keys)?,
            Some(self.virtual_ref.push(keys)?),
            self.have_id,
        ))
    }
}

impl fmt::Display for Location {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} ({})", self.virtual_ref, self.canonical_ref)
    }
}

/// `Canonizer`: maps the virtual locations `$id`s introduce to canonical
/// ones.
struct Canonizer {
    map: EqualityMap<Ref, Location>,
    schema_addresses_added: HashSet<String>,
    debug_print_schema_resolving: bool,
}

impl Canonizer {
    fn new(debug_print_schema_resolving: bool) -> Self {
        Canonizer {
            map: EqualityMap::new(),
            schema_addresses_added: HashSet::default(),
            debug_print_schema_resolving,
        }
    }

    /// `addIDs(schema, loc)`: walks objects and arrays in property order.
    /// `depth` is the number of enclosing `addIDs` calls; like Node, it
    /// overflows the stack past [`ADD_IDS_DEPTH_LIMIT`].
    fn add_ids(&mut self, schema: &JsonSchema, loc: &Location, depth: usize) -> Result<()> {
        if depth > ADD_IDS_DEPTH_LIMIT {
            return Err(stack_overflow());
        }
        grow_stack(|| match schema {
            JsonSchema::Array(items) => {
                for (i, item) in items.iter().enumerate() {
                    self.add_ids(item, &loc.push(&[&i.to_string()])?, depth + 1)?;
                }
                Ok(())
            }
            JsonSchema::Object(map) => {
                let loc_without_id = loc;
                let mut loc = loc.clone();
                if let Some(id @ JsonSchema::String(_)) = map.get("$id") {
                    loc = loc.update_with_id(Some(id))?;
                }
                if loc.have_id {
                    if self.debug_print_schema_resolving {
                        console_log(&format!("adding mapping {loc}"));
                    }
                    self.map
                        .set(loc.virtual_ref.clone(), loc_without_id.clone());
                }
                for (property, value) in map.iter() {
                    self.add_ids(value, &loc.push(&[property])?, depth + 1)?;
                }
                Ok(())
            }
            _ => Ok(()),
        })
    }

    /// `addSchema(schema, address)`: registers a document's `$id`s the
    /// first time its address is seen; whether it was new.
    fn add_schema(&mut self, schema: &JsonSchema, address: &str) -> Result<bool> {
        if self.schema_addresses_added.contains(address) {
            return Ok(false);
        }
        self.add_ids(
            schema,
            &Location::new(Ref::root(Some(address))?, Some(Ref::root(None)?), false),
            0,
        )?;
        self.schema_addresses_added.insert(address.to_owned());
        Ok(true)
    }

    /// `canonize(base, ref)`: the canonical location of `ref` seen from
    /// `base`.
    fn canonize(&self, base: &Location, r: &Ref) -> Result<Location> {
        let virtual_ref = r.resolve_against(Some(&base.virtual_ref))?;
        if let Some(loc) = self.map.get(&virtual_ref) {
            return Ok(loc.clone());
        }
        let canonical_ref = if virtual_ref.address_uri.is_none() {
            Ref::new(
                base.canonical_ref.address_uri.clone(),
                virtual_ref.path.clone(),
            )?
        } else {
            virtual_ref.clone()
        };
        Ok(Location::new(
            canonical_ref,
            Some(Ref::new(None, virtual_ref.path)?),
            false,
        ))
    }
}

/// `schemaFetchError(base, address)`.
fn schema_fetch_error<T>(base: Option<&Location>, address: String) -> Result<T> {
    match base {
        None => message_error(
            ErrorKind::SchemaFetchErrorTopLevel,
            vec![("address", address.into())],
        ),
        Some(base) => message_error(
            ErrorKind::SchemaFetchError,
            vec![
                ("address", address.into()),
                ("base", base.canonical_ref.message_value()),
            ],
        ),
    }
}

/// `Resolver`: finds the schema a ref designates, fetching documents as
/// needed.
struct Resolver<'a> {
    debug_print_schema_resolving: bool,
    store: &'a mut dyn JsonSchemaStore,
    canonizer: Canonizer,
}

impl Resolver<'_> {
    /// `tryResolveVirtualRef(fetchBase, lookupBase, virtualRef)`.
    async fn try_resolve_virtual_ref(
        &mut self,
        fetch_base: &Location,
        lookup_base: &Location,
        virtual_ref: &Ref,
    ) -> Result<(Option<JsonSchema>, Location)> {
        let mut did_add = false;
        // A document seen for the first time may have `$id`s that change
        // where the ref leads, so register them and canonize again.
        loop {
            let loc = self.canonizer.canonize(fetch_base, virtual_ref)?;
            let canonical = &loc.canonical_ref;
            assert(
                canonical.has_address(),
                "Canonical ref can't be resolved without an address",
            )?;
            let address = canonical.address()?;
            let schema = if canonical.address_uri.is_none() {
                None
            } else {
                self.store
                    .get(&address, self.debug_print_schema_resolving)
                    .await?
            };
            let Some(schema) = schema else {
                return Ok((None, loc));
            };
            if self.canonizer.add_schema(&schema, &address)? {
                assert(!did_add, "We can't add a schema twice")?;
                did_add = true;
            } else {
                let lookup_loc = self.canonizer.canonize(lookup_base, virtual_ref)?;
                let lookup_loc = Location::new(
                    Ref::new(
                        loc.canonical_ref.address_uri.clone(),
                        lookup_loc.canonical_ref.path.clone(),
                    )?,
                    Some(lookup_loc.virtual_ref),
                    lookup_loc.have_id,
                );
                let resolved = lookup_loc.canonical_ref.lookup_ref(&schema)?;
                return Ok((Some(resolved), lookup_loc));
            }
        }
    }

    /// `resolveVirtualRef(base, virtualRef)`: with the virtual base first,
    /// then with the canonical address and the virtual path.
    async fn resolve_virtual_ref(
        &mut self,
        base: &Location,
        virtual_ref: &Ref,
    ) -> Result<(JsonSchema, Location)> {
        if self.debug_print_schema_resolving {
            console_log(&format!("resolving {virtual_ref} relative to {base}"));
        }
        let (schema, loc) = self
            .try_resolve_virtual_ref(base, base, virtual_ref)
            .await?;
        if let Some(schema) = schema {
            if self.debug_print_schema_resolving {
                console_log(&format!("resolved to {loc}"));
            }
            return Ok((schema, loc));
        }
        let alt_base = Location::new(
            base.canonical_ref.clone(),
            Some(Ref::new(
                base.canonical_ref.address_uri.clone(),
                base.virtual_ref.path.clone(),
            )?),
            base.have_id,
        );
        let (schema, loc) = self
            .try_resolve_virtual_ref(&alt_base, base, virtual_ref)
            .await?;
        if let Some(schema) = schema {
            if self.debug_print_schema_resolving {
                console_log(&format!("resolved to {loc}"));
            }
            return Ok((schema, loc));
        }
        schema_fetch_error(Some(base), virtual_ref.to_string())
    }

    /// `resolveTopLevelRef(ref)`.
    async fn resolve_top_level_ref(&mut self, r: &Ref) -> Result<(JsonSchema, Location)> {
        self.resolve_virtual_ref(
            &Location::new(Ref::new(r.address_uri.clone(), Vec::new())?, None, false),
            &Ref::new(None, r.path.clone())?,
        )
        .await
    }
}

// ---------------------------------------------------------------------------
// Attribute producers

/// `JSONSchemaType`: the JSON Schema type names, in `schemaTypeDict` order.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum JsonSchemaType {
    /// `null`
    Null,
    /// `boolean`
    Boolean,
    /// `string`
    String,
    /// `integer`
    Integer,
    /// `number`
    Number,
    /// `array`
    Array,
    /// `object`
    Object,
}

impl JsonSchemaType {
    /// `schemaTypes`: all of them, in order.
    pub const ALL: [JsonSchemaType; 7] = [
        JsonSchemaType::Null,
        JsonSchemaType::Boolean,
        JsonSchemaType::String,
        JsonSchemaType::Integer,
        JsonSchemaType::Number,
        JsonSchemaType::Array,
        JsonSchemaType::Object,
    ];

    /// The type's name in JSON Schema.
    pub fn as_str(self) -> &'static str {
        match self {
            JsonSchemaType::Null => "null",
            JsonSchemaType::Boolean => "boolean",
            JsonSchemaType::String => "string",
            JsonSchemaType::Integer => "integer",
            JsonSchemaType::Number => "number",
            JsonSchemaType::Array => "array",
            JsonSchemaType::Object => "object",
        }
    }
}

/// `JSONSchemaAttributes`: what an attribute producer contributes, by the
/// kind of type it applies to.
#[derive(Clone, Debug, Default)]
pub struct JsonSchemaAttributes {
    /// `forArray`
    pub for_array: Option<TypeAttributes>,
    /// `forBoolean`
    pub for_boolean: Option<TypeAttributes>,
    /// `forCases`: one per `oneOf` case.
    pub for_cases: Option<Vec<TypeAttributes>>,
    /// `forNull`
    pub for_null: Option<TypeAttributes>,
    /// `forNumber`
    pub for_number: Option<TypeAttributes>,
    /// `forObject`
    pub for_object: Option<TypeAttributes>,
    /// `forString`
    pub for_string: Option<TypeAttributes>,
    /// `forType`: the whole type.
    pub for_type: Option<TypeAttributes>,
    /// `forUnion`: the `oneOf` union.
    pub for_union: Option<TypeAttributes>,
}

/// `JSONSchemaAttributeProducer(schema, canonicalRef, types, unionCases)`:
/// `unionCases` are the `oneOf` cases when called for a `oneOf`.
pub type JsonSchemaAttributeProducer = Rc<
    dyn Fn(
        &JsonSchema,
        &Ref,
        &IndexSet<JsonSchemaType>,
        Option<&[JsonSchema]>,
    ) -> Result<Option<JsonSchemaAttributes>>,
>;

/// The built-in producers, in the order `JSONSchemaInput`'s constructor
/// lists them.
fn default_attribute_producers() -> Vec<JsonSchemaAttributeProducer> {
    vec![
        Rc::new(description_attribute_producer),
        Rc::new(accessor_names_attribute_producer),
        Rc::new(default_value_attribute_producer),
        Rc::new(enum_values_attribute_producer),
        Rc::new(uri_schema_attributes_producer),
        Rc::new(min_max_attribute_producer),
        Rc::new(min_max_length_attribute_producer),
        Rc::new(min_max_items_attribute_producer),
        Rc::new(pattern_attribute_producer),
    ]
}

// ---------------------------------------------------------------------------
// Converting schemas to types

/// `checkTypeList(typeOrTypes, loc)`: the set of type names.
fn check_type_list(type_or_types: &JsonSchema, loc: &Location) -> Result<IndexSet<String>> {
    let set: IndexSet<String> = match type_or_types {
        JsonSchema::String(t) => [t.clone()].into_iter().collect(),
        JsonSchema::Array(items) => {
            let mut set = IndexSet::new();
            for t in items.iter() {
                let JsonSchema::String(t) = t else {
                    return message_error(
                        ErrorKind::SchemaTypeElementMustBeString,
                        with_ref(&loc.canonical_ref, vec![("element", t.to_message_value())]),
                    );
                };
                set.insert(t.clone());
            }
            set
        }
        other => {
            return message_error(
                ErrorKind::SchemaTypeMustBeStringOrStringArray,
                with_ref(
                    &loc.canonical_ref,
                    vec![("actual", other.to_message_value())],
                ),
            );
        }
    };
    if set.is_empty() {
        return message_error(
            ErrorKind::SchemaNoTypeSpecified,
            with_ref(&loc.canonical_ref, vec![]),
        );
    }
    if let Some(invalid) = set
        .iter()
        .find(|s| !JsonSchemaType::ALL.iter().any(|t| t.as_str() == s.as_str()))
    {
        return message_error(
            ErrorKind::SchemaInvalidType,
            with_ref(&loc.canonical_ref, vec![("type", invalid.as_str().into())]),
        );
    }
    Ok(set)
}

/// `checkRequiredArray(arr, loc)`.
fn check_required_array(arr: &JsonSchema, loc: &Location) -> Result<Vec<String>> {
    let JsonSchema::Array(items) = arr else {
        return message_error(
            ErrorKind::SchemaRequiredMustBeStringOrStringArray,
            with_ref(&loc.canonical_ref, vec![("actual", arr.to_message_value())]),
        );
    };
    items
        .iter()
        .map(|e| match e {
            JsonSchema::String(s) => Ok(s.clone()),
            other => message_error(
                ErrorKind::SchemaRequiredElementMustBeString,
                with_ref(
                    &loc.canonical_ref,
                    vec![("element", other.to_message_value())],
                ),
            ),
        })
        .collect()
}

/// `typeKindForJSONSchemaFormat(format)`.
fn type_kind_for_json_schema_format(format: Option<&JsonSchema>) -> Option<TypeKind> {
    let format = format?.as_str()?;
    [
        TypeKind::Date,
        TypeKind::Time,
        TypeKind::DateTime,
        TypeKind::Uuid,
        TypeKind::Uri,
        TypeKind::IntegerString,
        TypeKind::BoolString,
    ]
    .into_iter()
    .find(|&k| transformed_string_type_targets(k).is_some_and(|t| t.json_schema == format))
}

/// A sort key of `makeObject`: a property name's lower case, or its index
/// in `quicktypePropertyOrder`.
#[derive(Clone, Debug)]
enum SortKey {
    Number(f64),
    String(String),
}

/// collection-utils `compareKeys(a, b)` with JavaScript's `<`/`>`: strings
/// by UTF-16 code units, numbers numerically, a number against a string by
/// converting the string to a number.
fn compare_keys(a: &SortKey, b: &SortKey) -> i32 {
    let less = |a: &SortKey, b: &SortKey| match (a, b) {
        (SortKey::String(x), SortKey::String(y)) => compare_utf16(x, y).is_lt(),
        (SortKey::Number(x), SortKey::Number(y)) => x < y,
        (SortKey::Number(x), SortKey::String(y)) => *x < number::string_to_number(y),
        (SortKey::String(x), SortKey::Number(y)) => number::string_to_number(x) < *y,
    };
    if less(a, b) {
        -1
    } else if less(b, a) {
        1
    } else {
        0
    }
}

/// `order.indexOf(name)` for `quicktypePropertyOrder`: on an array, the
/// index of the equal string; on a string, the substring position.
fn index_of_in_order(order: &JsonSchema, name: &str) -> Result<Option<f64>> {
    match order {
        JsonSchema::Array(items) => Ok(items
            .iter()
            .position(|item| item.as_str() == Some(name))
            .map(|i| i as f64)),
        JsonSchema::String(s) => Ok(s.find(name).map(|i| utf16::len(&s[..i]) as f64)),
        _ => Err(type_error("order.indexOf is not a function")),
    }
}

/// The state of one `convertToType` call.
struct Conversion {
    schema: JsonSchema,
    object: Rc<IndexMap<String, JsonSchema>>,
    loc: Location,
    enum_array: Option<Rc<Vec<JsonSchema>>>,
    is_const: bool,
    type_set: Option<IndexSet<String>>,
    included_types: IndexSet<JsonSchemaType>,
    produced_for_no_cases: Option<Vec<JsonSchemaAttributes>>,
    type_attributes: TypeAttributes,
    inferred_attributes: TypeAttributes,
}

impl Conversion {
    fn get(&self, key: &str) -> Option<&JsonSchema> {
        self.object.get(key)
    }

    fn has(&self, key: &str) -> bool {
        self.object.contains_key(key)
    }
}

/// How much of Node's default stack (`JS_STACK_BUDGET`) one nesting level
/// of TypeScript's `toType` recursion uses, by the keyword it recurses
/// through. Measured with `xtask/core-json-schema-input/measure-stack-depth.mjs`
/// (a fresh Node 24 process per schema, the input stage only): a chain of
/// `items` overflows at 323 levels, a tuple chain at 199, `properties` at
/// 162, `allOf` at 201, `oneOf`/`anyOf` at 171, and `properties` plus
/// `items` per level at 108, which the costs add up to.
#[derive(Clone, Copy, Debug)]
enum Edge {
    /// A top-level, or a schema reached after an `await` (a `$ref` target).
    Fresh,
    /// `items` (an object or boolean), `additionalProperties`, the rest
    /// `items` of a tuple.
    Items,
    /// An element of a tuple (`prefixItems`, array `items`).
    Tuple,
    /// A property.
    Property,
    /// An `allOf` case.
    AllOf,
    /// A `oneOf` or `anyOf` case.
    OneOrAnyOf,
}

/// The modelled JavaScript stack, in the units of [`Edge::cost`].
const JS_STACK_BUDGET: u64 = 1_000_000;

/// How deeply `toType` may nest in Rust in all, including across the
/// `await`s after which TypeScript starts on a fresh stack (`$ref` chains,
/// `additionalProperties` chains). TypeScript has no such limit; see
/// "Known gaps" in `docs/PARITY.md`.
const NATIVE_DEPTH_LIMIT: usize = 10_000;

/// How deeply `Canonizer.addIDs` may recurse: Node overflows at 4,152
/// nested calls (a document nested 4,151 levels deep).
const ADD_IDS_DEPTH_LIMIT: usize = 4_151;

impl Edge {
    fn cost(self) -> u64 {
        match self {
            Edge::Fresh => 0,
            Edge::Items => 3_100,
            Edge::Tuple => 5_040,
            Edge::Property => 6_190,
            Edge::AllOf => 4_990,
            Edge::OneOrAnyOf => 5_860,
        }
    }
}

/// Awaits a step of the TypeScript `async` recursion. In JavaScript every
/// `await` resumes on a fresh stack (from the microtask queue), so the
/// modelled JavaScript stack starts over afterwards.
macro_rules! resumed {
    ($self:ident, $future:expr) => {{
        let result = $future.await;
        $self.js_stack = 0;
        result
    }};
}

/// `addTypesInSchema`: builds the types of the top-levels.
struct TypeAdder<'a, 'g> {
    resolver: Resolver<'a>,
    type_builder: &'a mut TypeBuilder<'g>,
    producers: &'a [JsonSchemaAttributeProducer],
    type_for_canonical_ref: EqualityMap<Ref, TypeRef>,
    /// The JavaScript stack the synchronous part of the recursion would use
    /// since the last `await` (see [`Edge`]).
    js_stack: u64,
    /// How deeply `to_type` is nested in Rust.
    native_depth: usize,
}

impl<'g> TypeAdder<'_, 'g> {
    /// `setTypeForLocation(loc, t)`.
    fn set_type_for_location(&mut self, loc: &Location, t: TypeRef) -> Result<()> {
        if let Some(existing) = self.type_for_canonical_ref.get(&loc.canonical_ref) {
            assert(*existing == t, "Trying to set path again to different type")?;
        }
        self.type_for_canonical_ref
            .set(loc.canonical_ref.clone(), t);
        Ok(())
    }

    /// `forEachProducedAttribute(cases, f)`: the producers' results, which
    /// are computed once for the case without union cases.
    fn produced_attributes(
        &self,
        conv: &mut Conversion,
        cases: Option<&[JsonSchema]>,
    ) -> Result<Vec<JsonSchemaAttributes>> {
        if cases.is_none()
            && let Some(produced) = &conv.produced_for_no_cases
        {
            return Ok(produced.clone());
        }
        let mut attributes = Vec::new();
        for producer in self.producers {
            if let Some(a) = producer(
                &conv.schema,
                &conv.loc.canonical_ref,
                &conv.included_types,
                cases,
            )? {
                attributes.push(a);
            }
        }
        if cases.is_none() {
            conv.produced_for_no_cases = Some(attributes.clone());
        }
        Ok(attributes)
    }

    /// `combineProducedAttributes(f)`.
    fn combine_produced_attributes(
        &self,
        conv: &mut Conversion,
        f: impl Fn(&JsonSchemaAttributes) -> Result<Option<TypeAttributes>>,
    ) -> Result<TypeAttributes> {
        let mut result = TypeAttributes::new();
        for attributes in self.produced_attributes(conv, None)? {
            if let Some(a) = f(&attributes)? {
                result = combine_type_attributes2(CombinationKind::Union, &result, &a)?;
            }
        }
        Ok(result)
    }

    /// `toType(schema, loc, typeAttributes)`, reached through `edge`.
    ///
    /// Fails with V8's `RangeError: Maximum call stack size exceeded` where
    /// Node's stack would overflow. The Rust recursion itself runs on a
    /// stack that grows as needed.
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `toType`
    fn to_type<'s>(
        &'s mut self,
        schema: JsonSchema,
        loc: Location,
        type_attributes: TypeAttributes,
        edge: Edge,
    ) -> LocalBoxFuture<'s, Result<TypeRef>> {
        Box::pin(GrowStack(Box::pin(async move {
            self.js_stack += edge.cost();
            if self.js_stack > JS_STACK_BUDGET || self.native_depth >= NATIVE_DEPTH_LIMIT {
                return Err(stack_overflow());
            }
            self.native_depth += 1;
            let result = self.to_type_unchecked(schema, loc, type_attributes).await;
            self.native_depth -= 1;
            result
        })))
    }

    /// The body of `toType`.
    #[allow(clippy::wrong_self_convention)] // named after TypeScript's `toType`
    async fn to_type_unchecked(
        &mut self,
        schema: JsonSchema,
        loc: Location,
        type_attributes: TypeAttributes,
    ) -> Result<TypeRef> {
        if let Some(t) = self.type_for_canonical_ref.get(&loc.canonical_ref) {
            return Ok(*t);
        }
        let (result, loc) = match &schema {
            JsonSchema::Bool(b) => {
                let kind = if *b { TypeKind::Any } else { TypeKind::None };
                let t = self
                    .type_builder
                    .get_primitive_type(kind, TypeAttributes::new(), None)?;
                (t, loc)
            }
            _ => {
                let loc = loc.update_with_id(schema.get("$id"))?;
                let t = resumed!(
                    self,
                    self.convert_to_type(schema.clone(), loc.clone(), type_attributes)
                )?;
                (t, loc)
            }
        };
        self.set_type_for_location(&loc, result)?;
        Ok(result)
    }

    /// `makeAttributes(attributes)` inside `convertToType`.
    fn make_attributes(
        &self,
        conv: &mut Conversion,
        attributes: TypeAttributes,
    ) -> Result<TypeAttributes> {
        let mut attributes = attributes;
        if !conv.has("oneOf") {
            let produced = self.combine_produced_attributes(conv, |a| {
                assert(
                    a.for_union.is_none() && a.for_cases.is_none(),
                    "We can't have attributes for unions and cases if we don't have a union",
                )?;
                Ok(a.for_type.clone())
            })?;
            attributes = combine_type_attributes2(CombinationKind::Union, &attributes, &produced)?;
        }
        let type_names = defined(NamesTypeAttributeKind.try_get_in_attributes(&attributes))?;
        if !type_names.are_inferred() {
            return Ok(attributes);
        }
        let title = match conv.get("title") {
            Some(JsonSchema::String(t)) => Some(t.clone()),
            _ => conv.loc.canonical_ref.definition_name().map(str::to_owned),
        };
        let new_names = match title {
            Some(title) => TypeNames::make(
                [title].into_iter().collect(),
                Some(IndexSet::new()),
                conv.has("$ref"),
            ),
            None => type_names.make_inferred(),
        };
        Ok(modify_type_names(&attributes, |_| Some(new_names)))
    }

    /// `convertToType(schema, loc, typeAttributes)`.
    async fn convert_to_type(
        &mut self,
        schema: JsonSchema,
        loc: Location,
        type_attributes: TypeAttributes,
    ) -> Result<TypeRef> {
        let object = match &schema {
            JsonSchema::Object(map) => Rc::clone(map),
            _ => return panic("convertToType needs an object schema"),
        };
        let enum_array = match object.get("enum") {
            Some(JsonSchema::Array(items)) => Some(Rc::clone(items)),
            _ => None,
        };
        let is_const = object.contains_key("const");
        let type_set = match object.get("type") {
            Some(t) => Some(check_type_list(t, &loc)?),
            None => None,
        };

        let included_types: IndexSet<JsonSchemaType> = JsonSchemaType::ALL
            .into_iter()
            .filter(|&name| {
                if let Some(set) = &type_set
                    && !set.contains(name.as_str())
                {
                    return false;
                }
                if let Some(values) = &enum_array {
                    return values.iter().any(|x| match name {
                        JsonSchemaType::Null => matches!(x, JsonSchema::Null),
                        JsonSchemaType::Integer => {
                            matches!(x, JsonSchema::Number(n) if *n == n.floor())
                        }
                        JsonSchemaType::Array => false,
                        _ => x.type_of() == name.as_str(),
                    });
                }
                if is_const {
                    // `name === (schema.type ?? typeof schema.const)`
                    return match object.get("type") {
                        Some(JsonSchema::Null) | None => object
                            .get("const")
                            .is_some_and(|c| c.type_of() == name.as_str()),
                        Some(JsonSchema::String(t)) => t == name.as_str(),
                        Some(_) => false,
                    };
                }
                true
            })
            .collect();

        let mut conv = Conversion {
            schema: schema.clone(),
            object: Rc::clone(&object),
            loc: loc.clone(),
            enum_array,
            is_const,
            type_set,
            included_types,
            produced_for_no_cases: None,
            type_attributes: TypeAttributes::new(),
            inferred_attributes: TypeAttributes::new(),
        };
        conv.type_attributes = self.make_attributes(&mut conv, type_attributes)?;
        conv.inferred_attributes = make_type_attributes_inferred(&conv.type_attributes)?;

        let intersection_type = self.type_builder.get_unique_intersection_type(
            conv.type_attributes.clone(),
            None,
            None,
        )?;
        self.set_type_for_location(&loc, intersection_type)?;

        let no_enum_or_const = conv.enum_array.is_none() && !conv.is_const;
        let include_object =
            no_enum_or_const && conv.type_set.as_ref().is_none_or(|s| s.contains("object"));
        let include_array =
            no_enum_or_const && conv.type_set.as_ref().is_none_or(|s| s.contains("array"));
        let enum_array_has_string = conv
            .enum_array
            .as_ref()
            .is_some_and(|values| values.iter().any(|x| matches!(x, JsonSchema::String(_))));
        let const_is_string =
            conv.is_const && matches!(object.get("const"), Some(JsonSchema::String(_)));
        let need_string_enum = conv.included_types.contains(&JsonSchemaType::String)
            && (enum_array_has_string || const_is_string);
        let need_union = conv.type_set.is_some()
            || [
                "properties",
                "additionalProperties",
                "unevaluatedProperties",
                "items",
                "prefixItems",
                "required",
            ]
            .iter()
            .any(|k| object.contains_key(*k))
            || conv.enum_array.is_some()
            || conv.is_const;

        let mut types: Vec<TypeRef> = Vec::new();

        if need_union {
            let mut union_types: Vec<TypeRef> = Vec::new();
            let number_attributes =
                self.combine_produced_attributes(&mut conv, |a| Ok(a.for_number.clone()))?;
            let boolean_attributes =
                self.combine_produced_attributes(&mut conv, |a| Ok(a.for_boolean.clone()))?;
            let null_attributes =
                self.combine_produced_attributes(&mut conv, |a| Ok(a.for_null.clone()))?;

            for (name, kind) in [
                (JsonSchemaType::Null, TypeKind::Null),
                (JsonSchemaType::Number, TypeKind::Double),
                (JsonSchemaType::Integer, TypeKind::Integer),
                (JsonSchemaType::Boolean, TypeKind::Bool),
            ] {
                if !conv.included_types.contains(&name) {
                    continue;
                }
                let attributes = match kind {
                    TypeKind::Double | TypeKind::Integer => number_attributes.clone(),
                    TypeKind::Bool => boolean_attributes.clone(),
                    _ => null_attributes.clone(),
                };
                union_types.push(
                    self.type_builder
                        .get_primitive_type(kind, attributes, None)?,
                );
            }

            let produced_string =
                self.combine_produced_attributes(&mut conv, |a| Ok(a.for_string.clone()))?;
            let string_attributes = combine_type_attributes2(
                CombinationKind::Union,
                &conv.inferred_attributes,
                &produced_string,
            )?;

            // FIXME (as in TypeScript): a non-string const never takes this
            // path, so it degrades to its plain primitive type.
            if need_string_enum {
                let cases: Vec<String> = if const_is_string {
                    vec![
                        object
                            .get("const")
                            .and_then(JsonSchema::as_str)
                            .unwrap_or("")
                            .to_owned(),
                    ]
                } else {
                    conv.enum_array
                        .iter()
                        .flat_map(|values| values.iter())
                        .filter_map(|x| x.as_str().map(str::to_owned))
                        .collect()
                };
                union_types.push(self.type_builder.get_string_type(
                    string_attributes,
                    Some(StringTypes::from_cases(&cases)),
                    None,
                )?);
            } else if conv.included_types.contains(&JsonSchemaType::String) {
                union_types.push(self.make_string_type(&conv, string_attributes)?);
            }

            if include_array {
                let array_attributes =
                    self.combine_produced_attributes(&mut conv, |a| Ok(a.for_array.clone()))?;
                union_types.push(resumed!(
                    self,
                    self.make_array_type(&conv, array_attributes)
                )?);
            }

            if include_object {
                union_types.push(resumed!(self, self.make_object_type(&mut conv))?);
            }

            types.push(self.type_builder.get_unique_union_type(
                conv.inferred_attributes.clone(),
                Some(union_types.into_iter().collect()),
                None,
            )?);
        }

        if let Some(r) = object.get("$ref") {
            let JsonSchema::String(r) = r else {
                return message_error(
                    ErrorKind::SchemaRefMustBeString,
                    with_ref(&loc.canonical_ref, vec![("actual", r.type_of().into())]),
                );
            };
            let virtual_ref = Ref::parse(r)?;
            let (target, new_loc) =
                resumed!(self, self.resolver.resolve_virtual_ref(&loc, &virtual_ref))?;
            let names =
                defined(NamesTypeAttributeKind.try_get_in_attributes(&conv.type_attributes))?;
            let attributes = if names.are_inferred() {
                let name = new_loc.canonical_ref.name()?;
                modify_type_names(&conv.type_attributes, |_| {
                    Some(TypeNames::make(
                        [name].into_iter().collect(),
                        Some(IndexSet::new()),
                        true,
                    ))
                })
            } else {
                conv.type_attributes.clone()
            };
            types.push(resumed!(
                self,
                self.to_type(target, new_loc, attributes, Edge::Fresh)
            )?);
        }

        if let Some(cases) = object.get("allOf") {
            types.extend(resumed!(
                self,
                self.make_types_from_cases(&conv, cases, "allOf")
            )?);
        }

        if let Some(cases) = object.get("oneOf") {
            types.push(resumed!(
                self,
                self.convert_one_or_any_of(&mut conv, intersection_type, cases, "oneOf")
            )?);
        }

        if let Some(cases) = object.get("anyOf") {
            types.push(resumed!(
                self,
                self.convert_one_or_any_of(&mut conv, intersection_type, cases, "anyOf")
            )?);
        }

        self.type_builder
            .set_set_operation_members(intersection_type, types.into_iter().collect())?;
        Ok(intersection_type)
    }

    /// `makeStringType(attributes)`: a transformed string type for a known
    /// `format`, else a plain string.
    fn make_string_type(
        &mut self,
        conv: &Conversion,
        attributes: TypeAttributes,
    ) -> Result<TypeRef> {
        match type_kind_for_json_schema_format(conv.get("format")) {
            None => self.type_builder.get_string_type(
                attributes,
                Some(StringTypes::unrestricted()),
                None,
            ),
            Some(kind) => self.type_builder.get_primitive_type(kind, attributes, None),
        }
    }

    /// `makeArrayType(arrayAttributes)`.
    async fn make_array_type(
        &mut self,
        conv: &Conversion,
        array_attributes: TypeAttributes,
    ) -> Result<TypeRef> {
        let singular_attributes =
            make_type_attributes_inferred(&singularize_type_names(&conv.type_attributes))?;
        let items = conv.get("items").cloned();
        // JSON Schema 2020-12 renamed the array (tuple) form of `items` to
        // `prefixItems`.
        let prefix_items = match conv.get("prefixItems") {
            Some(JsonSchema::Array(p)) => Some(Rc::clone(p)),
            _ => None,
        };
        let (tuple_items, tuple_key) = match &prefix_items {
            Some(p) => (Some(Rc::clone(p)), "prefixItems"),
            None => match &items {
                Some(JsonSchema::Array(i)) => (Some(Rc::clone(i)), "items"),
                _ => (None, "items"),
            },
        };
        let item_type = if let Some(tuple_items) = tuple_items {
            let items_loc = conv.loc.push(&[tuple_key])?;
            let mut item_types = Vec::with_capacity(tuple_items.len());
            for (i, item) in tuple_items.iter().enumerate() {
                let item_loc = items_loc.push(&[&i.to_string()])?;
                check_json_schema(item, || Ok(item_loc.canonical_ref.clone()))?;
                item_types.push(resumed!(
                    self,
                    self.to_type(
                        item.clone(),
                        item_loc,
                        singular_attributes.clone(),
                        Edge::Tuple
                    )
                )?);
            }
            // `await arrayMapSync(...)`/`await mapMapSync(...)` resume on a fresh
            // stack even when there is nothing to map.
            self.js_stack = 0;
            // An object `items` next to `prefixItems` is the rest of an open
            // tuple; it joins the union. A boolean `items` is ignored.
            if tuple_key == "prefixItems"
                && let Some(rest @ (JsonSchema::Object(_) | JsonSchema::Null)) = &items
            {
                let rest_loc = conv.loc.push(&["items"])?;
                check_json_schema(rest, || Ok(rest_loc.canonical_ref.clone()))?;
                item_types.push(resumed!(
                    self,
                    self.to_type(
                        rest.clone(),
                        rest_loc,
                        singular_attributes.clone(),
                        Edge::Items
                    )
                )?);
            }
            self.type_builder.get_union_type(
                TypeAttributes::new(),
                item_types.into_iter().collect(),
                None,
            )?
        } else if let Some(
            items @ (JsonSchema::Object(_)
            | JsonSchema::Null
            | JsonSchema::Array(_)
            | JsonSchema::Bool(_)),
        ) = &items
        {
            // `typeof items === "object" || typeof items === "boolean"`.
            let items_loc = conv.loc.push(&["items"])?;
            check_json_schema(items, || Ok(items_loc.canonical_ref.clone()))?;
            resumed!(
                self,
                self.to_type(
                    items.clone(),
                    items_loc,
                    singular_attributes.clone(),
                    Edge::Items
                )
            )?
        } else if let Some(items) = &items {
            return message_error(
                ErrorKind::SchemaArrayItemsMustBeStringOrArray,
                with_ref(
                    &conv.loc.canonical_ref,
                    vec![("actual", items.to_message_value())],
                ),
            );
        } else {
            self.type_builder
                .get_primitive_type(TypeKind::Any, TypeAttributes::new(), None)?
        };

        self.type_builder
            .add_attributes(item_type, &singular_attributes)?;
        self.type_builder
            .get_array_type(array_attributes, item_type, None)
    }

    /// `makeObjectType()`.
    async fn make_object_type(&mut self, conv: &mut Conversion) -> Result<TypeRef> {
        let mut required: Vec<String> = match conv.get("required") {
            None | Some(JsonSchema::Bool(_)) => Vec::new(),
            Some(r) => check_required_array(r, &conv.loc)?,
        };

        let properties: Rc<IndexMap<String, JsonSchema>> = match conv.get("properties") {
            None => Rc::new(IndexMap::new()),
            Some(p) => Rc::clone(check_json_schema_object(p, || {
                Ok(conv.loc.canonical_ref.clone())
            })?),
        };

        // In Schema Draft 3, `required` is `true` on a property that's required.
        for (p, prop_schema) in properties.iter() {
            if let JsonSchema::Null = prop_schema {
                return Err(type_error(
                    "Cannot read properties of null (reading 'required')",
                ));
            }
            if prop_schema.get("required") == Some(&JsonSchema::Bool(true)) && !required.contains(p)
            {
                required.push(p.clone());
            }
        }

        let mut additional_properties = conv.get("additionalProperties").cloned();
        // An incorrect hack (as in TypeScript) for a Go->Schema generator:
        // https://github.com/quicktype/quicktype/issues/976
        if additional_properties.is_none()
            && let Some(JsonSchema::Object(pattern_properties)) = conv.get("patternProperties")
            && let Some(p) = pattern_properties.get(".*")
        {
            additional_properties = Some(p.clone());
        }
        if additional_properties.is_none()
            && let Some(u) = conv.get("unevaluatedProperties")
        {
            additional_properties = Some(u.clone());
        }

        let produced_object =
            self.combine_produced_attributes(conv, |a| Ok(a.for_object.clone()))?;
        let object_attributes = combine_type_attributes2(
            CombinationKind::Union,
            &conv.inferred_attributes,
            &produced_object,
        )?;

        let order = conv
            .get("quicktypePropertyOrder")
            .filter(|o| o.is_truthy())
            .cloned();

        resumed!(
            self,
            self.make_object(
                &conv.loc,
                object_attributes,
                &properties,
                required,
                additional_properties,
                order.as_ref(),
            )
        )
    }

    /// `makeObject(loc, attributes, properties, requiredArray,
    /// additionalProperties, sortKey)`.
    async fn make_object(
        &mut self,
        loc: &Location,
        attributes: TypeAttributes,
        properties: &IndexMap<String, JsonSchema>,
        required_array: Vec<String>,
        additional_properties: Option<JsonSchema>,
        order: Option<&JsonSchema>,
    ) -> Result<TypeRef> {
        let required: IndexSet<String> = required_array.into_iter().collect();

        // `mapSortBy(mapFromObject(properties), (_, k) => sortKey(k))`, with
        // V8's sort (the keys can be inconsistent, mixing numbers and
        // strings). The sort key is only computed when there is something
        // to compare.
        let mut entries: Vec<(SortKey, &String, &JsonSchema)> =
            Vec::with_capacity(properties.len());
        for (name, schema) in properties.iter() {
            let key = if properties.len() < 2 {
                SortKey::String(String::new())
            } else {
                match order {
                    None => SortKey::String(name.to_lowercase()),
                    Some(order) => match index_of_in_order(order, name)? {
                        Some(index) => SortKey::Number(index),
                        None => SortKey::String(name.to_lowercase()),
                    },
                }
            };
            entries.push((key, name, schema));
        }
        sort_by(&mut entries, |a, b| compare_keys(&a.0, &b.0));

        let mut props: IndexMap<String, crate::ty::ty::ClassProperty> = IndexMap::new();
        for (_, prop_name, prop_schema) in entries {
            let prop_loc = loc.push(&["properties", prop_name])?;
            check_json_schema(prop_schema, || Ok(prop_loc.canonical_ref.clone()))?;
            let t = resumed!(
                self,
                self.to_type(
                    prop_schema.clone(),
                    prop_loc,
                    make_names_type_attributes(prop_name, true),
                    Edge::Property,
                )
            )?;
            let is_optional = !required.contains(prop_name);
            props.insert(
                prop_name.clone(),
                self.type_builder.make_class_property(t, is_optional),
            );
        }
        // `await arrayMapSync(...)`/`await mapMapSync(...)` resume on a fresh
        // stack even when there is nothing to map.
        self.js_stack = 0;

        let additional_properties_type = match additional_properties {
            None | Some(JsonSchema::Bool(true)) => Some(self.type_builder.get_primitive_type(
                TypeKind::Any,
                TypeAttributes::new(),
                None,
            )?),
            Some(JsonSchema::Bool(false)) => None,
            Some(additional) => {
                let additional_loc = loc.push(&["additionalProperties"])?;
                check_json_schema(&additional, || Ok(additional_loc.canonical_ref.clone()))?;
                Some(resumed!(
                    self,
                    self.to_type(
                        additional,
                        additional_loc,
                        singularize_type_names(&attributes),
                        Edge::Items,
                    )
                )?)
            }
        };

        let additional_required: Vec<&String> = required
            .iter()
            .filter(|r| !props.contains_key(*r))
            .collect();
        if !additional_required.is_empty() {
            let Some(t) = additional_properties_type else {
                return message_error(
                    ErrorKind::SchemaAdditionalTypesForbidRequired,
                    with_ref(&loc.canonical_ref, vec![]),
                );
            };
            for name in additional_required {
                props.insert(
                    name.clone(),
                    self.type_builder.make_class_property(t, false),
                );
            }
        }

        self.type_builder.get_unique_object_type(
            attributes,
            Some(props),
            additional_properties_type,
            None,
        )
    }

    /// `makeTypesFromCases(cases, kind)`.
    async fn make_types_from_cases(
        &mut self,
        conv: &Conversion,
        cases: &JsonSchema,
        kind: &str,
    ) -> Result<Vec<TypeRef>> {
        let kind_loc = conv.loc.push(&[kind])?;
        let JsonSchema::Array(cases) = cases else {
            return message_error(
                ErrorKind::SchemaSetOperationCasesIsNotArray,
                with_ref(
                    &kind_loc.canonical_ref,
                    vec![
                        ("operation", kind.into()),
                        ("cases", cases.to_message_value()),
                    ],
                ),
            );
        };
        let edge = if kind == "allOf" {
            Edge::AllOf
        } else {
            Edge::OneOrAnyOf
        };
        let mut result = Vec::with_capacity(cases.len());
        for (index, t) in cases.iter().enumerate() {
            let case_loc = kind_loc.push(&[&index.to_string()])?;
            check_json_schema(t, || Ok(case_loc.canonical_ref.clone()))?;
            let attributes = make_type_attributes_inferred(&conv.type_attributes)?;
            result.push(resumed!(
                self,
                self.to_type(t.clone(), case_loc, attributes, edge)
            )?);
        }
        // `await arrayMapSync(...)`/`await mapMapSync(...)` resume on a fresh
        // stack even when there is nothing to map.
        self.js_stack = 0;
        Ok(result)
    }

    /// `convertOneOrAnyOf(cases, kind)`.
    async fn convert_one_or_any_of(
        &mut self,
        conv: &mut Conversion,
        intersection_type: TypeRef,
        cases: &JsonSchema,
        kind: &str,
    ) -> Result<TypeRef> {
        let type_refs = resumed!(self, self.make_types_from_cases(conv, cases, kind))?;
        let mut union_attributes = make_type_attributes_inferred(&conv.type_attributes)?;
        if kind == "oneOf" {
            let case_schemas: Vec<JsonSchema> =
                cases.as_array().map(<[_]>::to_vec).unwrap_or_default();
            for a in self.produced_attributes(conv, Some(&case_schemas))? {
                if let Some(for_type) = &a.for_type {
                    self.type_builder
                        .add_attributes(intersection_type, for_type)?;
                }
                if let Some(for_union) = &a.for_union {
                    union_attributes = combine_type_attributes2(
                        CombinationKind::Union,
                        &union_attributes,
                        for_union,
                    )?;
                }
                if let Some(for_cases) = &a.for_cases {
                    assert(
                        for_cases.len() == type_refs.len(),
                        "Number of case attributes doesn't match number of cases",
                    )?;
                    for (t, attributes) in type_refs.iter().zip(for_cases) {
                        self.type_builder.add_attributes(*t, attributes)?;
                    }
                }
            }
        }
        let union_type = self
            .type_builder
            .get_unique_union_type(union_attributes, None, None)?;
        self.type_builder
            .set_set_operation_members(union_type, type_refs.into_iter().collect())?;
        Ok(union_type)
    }

    /// The main loop of `addTypesInSchema`.
    async fn add_top_levels(&mut self, references: &IndexMap<String, Ref>) -> Result<()> {
        for (top_level_name, top_level_ref) in references {
            let (target, loc) = resumed!(self, self.resolver.resolve_top_level_ref(top_level_ref))?;
            let t = resumed!(
                self,
                self.to_type(
                    target,
                    loc,
                    make_names_type_attributes(top_level_name, false),
                    Edge::Fresh,
                )
            )?;
            self.type_builder.add_top_level(top_level_name, t)?;
        }
        Ok(())
    }
}

// ---------------------------------------------------------------------------
// Top-level names

/// `removeExtension(fn)`: without `.json` or `.schema` (any case), unless
/// that leaves nothing.
fn remove_extension(name: &str) -> String {
    let lower = name.to_lowercase();
    for ext in [".json", ".schema"] {
        // The extensions are ASCII, so `lower` and `name` end alike.
        if lower.ends_with(ext)
            && name.len() > ext.len()
            && name.is_char_boundary(name.len() - ext.len())
        {
            return name[..name.len() - ext.len()].to_owned();
        }
    }
    name.to_owned()
}

/// `nameFromURI(uri)`: the last non-empty fragment component, else the
/// file name, without extension.
fn name_from_uri(uri: &Uri) -> Result<String> {
    let fragment = uri.fragment();
    if !fragment.is_empty() {
        let components: Vec<&str> = fragment.split('/').collect();
        let len = components.len();
        if !components[len - 1].is_empty() {
            return Ok(remove_extension(components[len - 1]));
        }
        if len > 1 && !components[len - 2].is_empty() {
            return Ok(remove_extension(components[len - 2]));
        }
    }
    let filename = uri.filename();
    if !filename.is_empty() {
        return Ok(remove_extension(filename));
    }
    message_error(
        ErrorKind::DriverCannotInferNameForSchema,
        vec![("uri", uri.to_string().into())],
    )
}

/// What `refsInSchemaForURI` found: one named ref, or (for a fragment
/// ending in `/`) a ref per property.
enum SchemaRefs {
    Single(String, Ref),
    Many(IndexMap<String, Ref>),
}

/// `refsInSchemaForURI(resolver, uri, defaultName)`.
async fn refs_in_schema_for_uri(resolver: &mut Resolver<'_>, uri: &Uri) -> Result<SchemaRefs> {
    let mut uri = uri.js_clone();
    let fragment = uri.fragment().to_owned();
    let mut properties_are_types = fragment.ends_with('/');
    if properties_are_types {
        uri.set_fragment(&fragment[..fragment.len() - 1]);
    }
    let r = Ref::parse_uri(&uri)?;
    if r.is_root() {
        properties_are_types = false;
    }

    let (schema, _) = resolver.resolve_top_level_ref(&r).await?;

    if properties_are_types {
        let JsonSchema::Object(map) = &schema else {
            return message_error(
                ErrorKind::SchemaCannotGetTypesFromBoolean,
                vec![("ref", r.to_string().into())],
            );
        };
        let mut refs = IndexMap::new();
        for key in map.keys() {
            refs.insert(key.clone(), r.push(&[key])?);
        }
        return Ok(SchemaRefs::Many(refs));
    }

    let name = match schema.get("title") {
        Some(JsonSchema::String(title)) => title.clone(),
        _ => name_from_uri(&uri)?,
    };
    Ok(SchemaRefs::Single(name, r))
}

// ---------------------------------------------------------------------------
// Inline schema store

pub use crate::run::Timer;

/// `InputJSONSchemaStore`: serves the schemas given as text to
/// `addSource`, and delegates other addresses to the user's store's
/// `fetch`.
struct InputJsonSchemaStore {
    inputs: IndexMap<String, String>,
    timer: Option<Timer>,
    delegate: Option<Box<dyn JsonSchemaStore>>,
    cache: SchemaCache,
}

impl JsonSchemaStore for InputJsonSchemaStore {
    fn fetch<'a>(&'a mut self, address: &'a str) -> LocalBoxFuture<'a, Result<Option<JsonSchema>>> {
        Box::pin(async move {
            if let Some(input) = self.inputs.get(address) {
                let mut result = None;
                let mut parse = || {
                    result = Some((|| {
                        let schema =
                            JsonSchema::from(parse_json(input, "JSON Schema", Some(address))?);
                        check_json_schema(&schema, || Ref::root(Some(address)))?;
                        Ok(Some(schema))
                    })());
                };
                match &self.timer {
                    Some(timer) => timer("parse JSON Schema", &mut parse),
                    None => parse(),
                }
                return result.unwrap_or_else(|| panic("The timer did not run the parser"));
            }
            match &mut self.delegate {
                None => panic(format!(
                    "Schema URI {address} requested, but no store given"
                )),
                Some(delegate) => delegate.fetch(address).await,
            }
        })
    }

    fn cache(&mut self) -> &mut SchemaCache {
        &mut self.cache
    }
}

// ---------------------------------------------------------------------------
// JSONSchemaInput

/// `JSONSchemaSourceData`: a schema source, given by URIs (read through the
/// store), as text, or both (the text is then stored under the URIs).
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct JsonSchemaSourceData {
    /// `name`: the top-level name (used as is if it is the only source).
    pub name: String,
    /// `uris`: addresses, possibly with fragments (`x.json#/definitions/`
    /// makes each definition a top-level).
    pub uris: Option<Vec<String>>,
    /// `schema`: the schema text.
    pub schema: Option<String>,
    /// `isConverted`: the schema was converted from another input
    /// (TypeScript), so the input does not need the IR.
    pub is_converted: bool,
}

/// `JSONSchemaInput`: JSON Schema sources and the types they describe.
pub struct JsonSchemaInput {
    schema_store: Option<Box<dyn JsonSchemaStore>>,
    attribute_producers: Vec<JsonSchemaAttributeProducer>,
    schema_inputs: IndexMap<String, String>,
    schema_sources: Vec<(Uri, JsonSchemaSourceData)>,
    top_levels: IndexMap<String, Ref>,
    need_ir: bool,
    additional_schema_addresses: Vec<String>,
}

impl JsonSchemaInput {
    /// `kind`.
    pub const KIND: &'static str = "schema";

    /// `new JSONSchemaInput(schemaStore, additionalAttributeProducers,
    /// additionalSchemaAddresses)`: the built-in attribute producers run
    /// first, then `additional_attribute_producers`. The schemas at
    /// `additional_schema_addresses` are fetched first, so that their
    /// `$id`s are known (`--additional-schema`).
    pub fn new(
        schema_store: Option<Box<dyn JsonSchemaStore>>,
        additional_attribute_producers: Vec<JsonSchemaAttributeProducer>,
        additional_schema_addresses: Vec<String>,
    ) -> Self {
        let mut attribute_producers = default_attribute_producers();
        attribute_producers.extend(additional_attribute_producers);
        JsonSchemaInput {
            schema_store,
            attribute_producers,
            schema_inputs: IndexMap::new(),
            schema_sources: Vec::new(),
            top_levels: IndexMap::new(),
            need_ir: false,
            additional_schema_addresses,
        }
    }

    /// `kind`: `"schema"`.
    pub fn kind(&self) -> &'static str {
        Self::KIND
    }

    /// `needIR`: whether any source was not converted from another input.
    pub fn need_ir(&self) -> bool {
        self.need_ir
    }

    /// `needSchemaProcessing`: always.
    pub fn need_schema_processing(&self) -> bool {
        true
    }

    /// `addTopLevel(name, ref)`: a top-level for the schema at `ref`; a
    /// name given again keeps its position and takes the new ref.
    pub fn add_top_level(&mut self, name: String, r: Ref) {
        self.top_levels.insert(name, r);
    }

    /// `_topLevels`: the top-levels added with
    /// [`add_top_level`](Self::add_top_level) and by
    /// [`add_types`](Self::add_types), in insertion order.
    pub fn top_levels(&self) -> impl Iterator<Item = (&str, &Ref)> {
        self.top_levels.iter().map(|(name, r)| (name.as_str(), r))
    }

    /// `addTypes(ctx, typeBuilder)`: resolves every source and builds the
    /// types of its top-levels with `type_builder`.
    ///
    /// From TypeScript's `RunContext` this takes the
    /// `debugPrintSchemaResolving` flag (`--debug print-schema-resolving`
    /// traces go to [`console_log`]) and `time`, which wraps the parsing of
    /// schemas given as text (`parse JSON Schema`; `None` to not time it).
    pub async fn add_types(
        &mut self,
        type_builder: &mut TypeBuilder<'_>,
        debug_print_schema_resolving: bool,
        timer: Option<Timer>,
    ) -> Result<()> {
        if self.schema_sources.is_empty() {
            return Ok(());
        }

        if self.schema_inputs.is_empty() {
            if self.schema_store.is_none() {
                return panic("Must have a schema store to process JSON Schema");
            }
        } else {
            let delegate = self.schema_store.take();
            self.schema_store = Some(Box::new(InputJsonSchemaStore {
                inputs: self.schema_inputs.clone(),
                timer,
                delegate,
                cache: SchemaCache::new(),
            }));
        }
        let store: &mut dyn JsonSchemaStore = match self.schema_store.as_mut() {
            Some(store) => store.as_mut(),
            None => return panic("Defined value expected, but got undefined"),
        };

        let mut canonizer = Canonizer::new(debug_print_schema_resolving);
        for address in &self.additional_schema_addresses {
            let Some(schema) = store.get(address, debug_print_schema_resolving).await? else {
                return message_error(
                    ErrorKind::SchemaFetchErrorAdditional,
                    vec![("address", address.as_str().into())],
                );
            };
            canonizer.add_schema(&schema, address)?;
        }

        let mut resolver = Resolver {
            debug_print_schema_resolving,
            store,
            canonizer,
        };

        // `this.addTopLevel(…)` as each source resolves, so that a failure
        // leaves the top-levels found so far, as in TypeScript.
        let single_source = self.schema_sources.len() == 1;
        for (normalized_uri, source) in &self.schema_sources {
            match refs_in_schema_for_uri(&mut resolver, normalized_uri).await? {
                SchemaRefs::Single(name, r) => {
                    let name = if single_source {
                        source.name.clone()
                    } else {
                        name
                    };
                    self.top_levels.insert(name, r);
                }
                SchemaRefs::Many(refs) => {
                    for (name, r) in refs {
                        self.top_levels.insert(name, r);
                    }
                }
            }
        }

        let mut adder = TypeAdder {
            resolver,
            type_builder,
            producers: &self.attribute_producers,
            type_for_canonical_ref: EqualityMap::new(),
            js_stack: 0,
            native_depth: 0,
        };
        adder.add_top_levels(&self.top_levels).await
    }

    /// `addTypesSync()`: not supported, because schemas are fetched
    /// asynchronously.
    pub fn add_types_sync(&mut self) -> Result<()> {
        panic("addTypesSync not supported in JSONSchemaInput")
    }

    /// `addSource(schemaSource)`.
    pub async fn add_source(&mut self, schema_source: JsonSchemaSourceData) -> Result<()> {
        self.add_source_sync(schema_source)
    }

    /// `addSourceSync(schemaSource)`: normalizes the source's URIs (or uses
    /// the name as one), and stores schema text under each address,
    /// suffixing `-1`, `-2`, … to the path until the address is free.
    pub fn add_source_sync(&mut self, schema_source: JsonSchemaSourceData) -> Result<()> {
        if !schema_source.is_converted {
            self.need_ir = true;
        }

        let mut normalized_uris: Vec<Uri> = match &schema_source.uris {
            None => vec![Uri::parse(&schema_source.name).map_err(uri_error)?],
            Some(uris) => uris
                .iter()
                .map(|uri| {
                    let mut normalized = normalize_uri_string(uri)?;
                    let mut without_hash = normalized.js_clone();
                    without_hash.set_fragment("");
                    if without_hash.to_string().is_empty() {
                        normalized
                            .set_path(&schema_source.name)
                            .map_err(uri_error)?;
                    }
                    Ok(normalized)
                })
                .collect::<Result<_>>()?,
        };

        match &schema_source.schema {
            None => assert(
                schema_source.uris.is_some(),
                "URIs must be given if schema source is not specified",
            )?,
            Some(schema) => {
                for normalized in normalized_uris.iter_mut() {
                    let mut uri = normalized.js_clone();
                    uri.set_fragment("");
                    let path = uri.path().to_owned();
                    let mut suffix = 0;
                    loop {
                        if suffix > 0 {
                            uri.set_path(&format!("{path}-{suffix}"))
                                .map_err(uri_error)?;
                        }
                        suffix += 1;
                        if !self.schema_inputs.contains_key(&uri.to_string()) {
                            break;
                        }
                    }
                    self.schema_inputs.insert(uri.to_string(), schema.clone());
                    uri.set_fragment(&normalized.hash());
                    *normalized = uri;
                }
            }
        }

        for normalized in normalized_uris {
            self.schema_sources
                .push((normalized, schema_source.clone()));
        }
        Ok(())
    }

    /// Adds a source whose `addSource` already ran elsewhere: the
    /// JavaScript facade keeps TypeScript's own `JSONSchemaInput` (which
    /// normalizes the URIs and serves schema text through its own store)
    /// and hands over each `[normalizedURI, source]` pair of its
    /// `_schemaSources`. `normalized_uri` is the URI's `toString()`; it is
    /// parsed, not normalized again. The source's `schema` text is not
    /// stored: the store that came with [`JsonSchemaInput::new`] serves it.
    pub fn add_normalized_source(
        &mut self,
        normalized_uri: &str,
        schema_source: JsonSchemaSourceData,
    ) -> Result<()> {
        if !schema_source.is_converted {
            self.need_ir = true;
        }
        let uri = Uri::parse(normalized_uri).map_err(uri_error)?;
        self.schema_sources.push((uri, schema_source));
        Ok(())
    }

    /// `singleStringSchemaSource()`: the schema text, if every source has
    /// the same one.
    pub fn single_string_schema_source(&self) -> Option<String> {
        let mut schemas: IndexSet<&str> = IndexSet::new();
        for (_, source) in &self.schema_sources {
            schemas.insert(source.schema.as_deref()?);
        }
        if schemas.len() == 1 {
            schemas.first().map(|s| (*s).to_owned())
        } else {
            None
        }
    }
}

// ---------------------------------------------------------------------------
// The `Input` glue

impl Input for JsonSchemaInput {
    type Source = JsonSchemaSourceData;

    fn kind(&self) -> &str {
        JsonSchemaInput::kind(self)
    }

    fn need_ir(&self) -> bool {
        JsonSchemaInput::need_ir(self)
    }

    fn need_schema_processing(&self) -> bool {
        JsonSchemaInput::need_schema_processing(self)
    }

    fn add_source(&mut self, source: Self::Source) -> impl Future<Output = Result<()>> {
        JsonSchemaInput::add_source(self, source)
    }

    fn add_source_sync(&mut self, source: Self::Source) -> Result<()> {
        JsonSchemaInput::add_source_sync(self, source)
    }

    /// `addTypes(ctx, typeBuilder)`: takes `debugPrintSchemaResolving` and
    /// the timer from `ctx`; the inference flags only concern JSON input.
    fn add_types(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        _infer_maps: bool,
        _infer_enums: bool,
        _fixed_top_levels: bool,
    ) -> impl Future<Output = Result<()>> {
        let debug_print_schema_resolving = ctx.debug_print_schema_resolving;
        let timer = ctx.timer();
        Box::pin(JsonSchemaInput::add_types(
            self,
            type_builder,
            debug_print_schema_resolving,
            Some(timer),
        ))
    }

    fn add_types_sync(
        &mut self,
        _ctx: &RunContext,
        _type_builder: &mut TypeBuilder<'_>,
        _infer_maps: bool,
        _infer_enums: bool,
        _fixed_top_levels: bool,
    ) -> Result<()> {
        JsonSchemaInput::add_types_sync(self)
    }

    fn single_string_schema_source(&self) -> Option<String> {
        JsonSchemaInput::single_string_schema_source(self)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn refs_parse_and_print() {
        let r = Ref::parse("e1.schema#definitions/Nope").unwrap();
        assert_eq!(r.to_string(), "e1.schema#definitions/Nope");
        assert_eq!(r.name().unwrap(), "e1");
        assert_eq!(
            Ref::parse("#/definitions/Foo").unwrap().to_string(),
            "#/definitions/Foo"
        );
        assert_eq!(
            Ref::parse("#/definitions/Foo").unwrap().definition_name(),
            Some("Foo")
        );
        assert_eq!(Ref::parse("x.json").unwrap().to_string(), "x.json#");
        assert!(Ref::parse("x.json").unwrap().is_root());
        assert_eq!(Ref::parse("x.json#/a/0/b").unwrap().name().unwrap(), "0");
        assert_eq!(Ref::root(None).unwrap().to_string(), "#");
        assert_eq!(Ref::parse("#").unwrap().name().unwrap(), "Something");
        assert_eq!(
            Ref::parse("100%.schema").unwrap_err().user_message(),
            "URI malformed"
        );
        let a = Ref::parse("a/test2.json").unwrap();
        let b = Ref::parse("../b/test3.json#/foo").unwrap();
        assert_eq!(
            b.resolve_against(Some(&a)).unwrap().to_string(),
            "b/test3.json#/foo"
        );
    }

    #[test]
    fn javascript_exceptions_keep_their_names() {
        let malformed = Ref::parse("100%.schema").unwrap_err();
        let js = malformed.as_js_exception().unwrap();
        assert_eq!(
            (js.name(), js.message()),
            (JsErrorName::URIError, "URI malformed")
        );
        assert_eq!(format!("Error: {malformed}."), "Error: URI malformed.");
        let port = Ref::parse("http://x:99999/a.json").unwrap_err();
        let js = port.as_js_exception().unwrap();
        assert_eq!(js.name(), JsErrorName::TypeError);
        assert_eq!(
            format!("Error: {port}."),
            "Error: Port \"99999\" is not a valid port."
        );
        let order = index_of_in_order(&JsonSchema::Number(5.0), "a").unwrap_err();
        assert_eq!(
            order.as_js_exception().unwrap().name(),
            JsErrorName::TypeError
        );
        assert_eq!(order.message_name(), None);
    }

    #[test]
    fn names_from_uris() {
        let name = |s: &str| name_from_uri(&Uri::parse(s).unwrap());
        assert_eq!(name("a/b.schema").unwrap(), "b");
        assert_eq!(name("a/b.JSON").unwrap(), "b");
        assert_eq!(name("a/.json").unwrap(), ".json");
        assert_eq!(name("x#/definitions/Foo").unwrap(), "Foo");
        assert_eq!(name("x#/definitions/Foo/").unwrap(), "Foo");
        assert_eq!(
            name("http://h").unwrap_err().user_message(),
            "Cannot infer name for schema http://h/"
        );
    }

    #[test]
    fn sort_keys_compare_like_javascript() {
        let n = SortKey::Number;
        let s = |x: &str| SortKey::String(x.to_owned());
        assert_eq!(compare_keys(&n(3.0), &s("abc")), 0);
        assert_eq!(compare_keys(&n(3.0), &s("10")), -1);
        assert_eq!(compare_keys(&s("10"), &s("2")), -1);
        assert_eq!(compare_keys(&s("b"), &s("a")), 1);
    }
}
