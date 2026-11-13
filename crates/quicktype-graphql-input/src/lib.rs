//! Port of `packages/quicktype-graphql-input/src/index.ts`.
//!
//! GraphQL as an input language: [`GraphQlInput`] takes GraphQL queries
//! together with the schema they run against (the JSON result of an
//! introspection query, as `--graphql-schema` files hold it) and builds the
//! types of the queries' results: one top-level per query, a class
//! `{ data, errors? }`, with a class per selection set.
//!
//! ```
//! use quicktype_core::{InputData, Options, get_target_language, quicktype_multi_file_sync};
//! use quicktype_graphql_input::{GraphQlInput, GraphQlSourceData};
//! use quicktype_js_compat::json;
//!
//! let schema = json::parse(
//!     r#"{"data": {"__schema": {
//!         "queryType": {"name": "Query"}, "mutationType": null,
//!         "types": [
//!             {"kind": "OBJECT", "name": "Query", "fields": [
//!                 {"name": "greeting", "args": [], "type": {"kind": "SCALAR", "name": "String"}}
//!             ]},
//!             {"kind": "SCALAR", "name": "String"}
//!         ]}}}"#,
//! )
//! .unwrap();
//! let mut input = GraphQlInput::new();
//! input.add_source_sync(GraphQlSourceData {
//!     name: "Hello".to_owned(),
//!     schema,
//!     query: "query { greeting }".to_owned(),
//! });
//! let mut input_data = InputData::new();
//! input_data.add_input(input);
//!
//! let lang = get_target_language("typescript")?;
//! let files = quicktype_multi_file_sync(Options::new(lang, input_data))?;
//! let code = files["stdout"].lines.join("\n");
//! assert!(code.contains("data:    Data | null;"));
//! assert!(code.contains("greeting: null | string;"));
//! # Ok::<(), quicktype_core::QuickTypeError>(())
//! ```
//!
//! # How it follows TypeScript
//!
//! The query is parsed with a port of graphql-js 16.14.2's parser
//! ([`graphql`]), so syntax errors read exactly like graphql-js's. The
//! schema is read with JavaScript's semantics (module `js`): a malformed schema
//! fails with the `TypeError` the TypeScript fails with. The types are
//! built in the same order with the same `TypeBuilder` calls, so the graph
//! (type indexes, names, unreachable leftovers included) is identical.
//!
//! Where the TypeScript never terminates (a fragment that spreads itself),
//! the port reports an error instead; see `docs/PARITY.md`, Known gaps.

pub mod graphql;
pub mod graphql_schema;
mod js;

use std::cell::RefCell;
use std::collections::HashMap;

use indexmap::{IndexMap, IndexSet};
use quicktype_core::attributes::string_types::StringTypes;
use quicktype_core::attributes::type_attributes::{
    AttributeKind, TypeAttributes, empty_type_attributes,
};
use quicktype_core::attributes::type_names::{
    NamesTypeAttributeKind, TypeNames, make_names_type_attributes,
};
use quicktype_core::messages::{ErrorKind, message_assert};
use quicktype_core::support::recursion::{grow_stack, stack_overflow};
use quicktype_core::support::support::{assert_never, panic};
use quicktype_core::ty::transformed_string_type::TypeKind as IrTypeKind;
use quicktype_core::ty::ty::ClassProperty;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_ref::TypeRef;
use quicktype_core::{Input, Result, RunContext};
use quicktype_js_compat::json::JsonValue;

use crate::graphql::ast::{
    Definition, FragmentDefinition, OperationDefinition, OperationType, Selection, SelectionSet,
};
use crate::graphql_schema::TypeKind;
use crate::js::{JsVal, object_prototype_function, type_error};

// ---- The schema (`GQLSchemaFromJSON`) ---------------------------------------

/// What a `GQLType`-typed value holds: one of the schema's type objects,
/// or what `types[name]` finds on `Object.prototype` (a function, or
/// `Object.prototype` itself for `__proto__`) when the schema has no type
/// of that name.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum GqlTypeRef {
    /// A type object, by index.
    Type(usize),
    /// A function of `Object.prototype`, by its `name`.
    Builtin(&'static str),
    /// `Object.prototype`.
    ObjectPrototype,
}

/// A field (`Field`), as much as the query side reads.
#[derive(Debug)]
struct GqlField<'a> {
    name: JsVal<'a>,
    ty: GqlTypeRef,
}

/// A type object (`GQLType`): the raw `kind` and `name`, and the parts the
/// query side reads.
#[derive(Debug)]
struct GqlType<'a> {
    kind: JsVal<'a>,
    name: JsVal<'a>,
    fields: Option<Vec<GqlField<'a>>>,
    enum_values: Option<Vec<JsVal<'a>>>,
    of_type: Option<GqlTypeRef>,
}

impl<'a> GqlType<'a> {
    fn new(kind: JsVal<'a>, name: JsVal<'a>) -> Self {
        GqlType {
            kind,
            name,
            fields: None,
            enum_values: None,
            of_type: None,
        }
    }
}

/// The plain object `types` (`{ [name: string]: GQLType }`): own
/// properties, then `Object.prototype`. Assigning `types["__proto__"]`
/// sets the prototype instead.
#[derive(Debug, Default)]
struct TypesObject {
    own: HashMap<String, usize>,
    prototype: Option<usize>,
}

impl TypesObject {
    fn set(&mut self, key: String, index: usize) {
        if key == "__proto__" {
            self.prototype = Some(index);
        } else {
            self.own.insert(key, index);
        }
    }

    /// `types[key]`, `None` for `undefined`.
    fn get(&self, key: &str) -> Option<GqlTypeRef> {
        if let Some(&index) = self.own.get(key) {
            return Some(GqlTypeRef::Type(index));
        }
        if key == "__proto__" {
            return Some(
                self.prototype
                    .map_or(GqlTypeRef::ObjectPrototype, GqlTypeRef::Type),
            );
        }
        object_prototype_function(key).map(GqlTypeRef::Builtin)
    }
}

/// How many list or non-null wrappers `makeType` unwraps (recursively)
/// before Node's stack overflows: the quicktype CLI (Node 24) reads a field
/// type nested in 7,459 `LIST`s and fails at 7,460 with `RangeError:
/// Maximum call stack size exceeded`, also when no query selects the field.
const MAKE_TYPE_MAX_DEPTH: usize = 7_459;

/// `GQLSchemaFromJSON`: the introspection result as type objects.
#[derive(Debug)]
struct GqlSchema<'a> {
    arena: Vec<GqlType<'a>>,
    types: TypesObject,
    query_type: GqlTypeRef,
    mutation_type: Option<GqlTypeRef>,
    /// The wrappers [`make_type`](Self::make_type) is unwrapping.
    wrapper_depth: usize,
}

impl<'a> GqlSchema<'a> {
    /// `new GQLSchemaFromJSON(json)`.
    fn new(json: &'a JsonValue) -> Result<Self> {
        let mut schema = GqlSchema {
            arena: Vec::new(),
            types: TypesObject::default(),
            query_type: GqlTypeRef::ObjectPrototype,
            mutation_type: None,
            wrapper_depth: 0,
        };
        let data = JsVal::Json(json).get("data")?;
        let query_type_name = || data.get("__schema")?.get("queryType")?.get("name");
        if query_type_name()?.is_null() {
            return panic("Query type doesn't have a name.");
        }
        let types = data.get("__schema")?.get("types")?;
        for t in types.iterate("schema.__schema.types")? {
            let name = t.get("name")?;
            if !name.truthy() {
                return panic("No top-level type name given");
            }
            let kind = t.get("kind")?;
            t.get("description")?;
            schema.arena.push(GqlType::new(kind, name));
            let index = schema.arena.len() - 1;
            schema.types.set(name.to_js_string()?, index);
        }
        for t in types.iterate("schema.__schema.types")? {
            let name = t.get("name")?;
            if !name.truthy() {
                return panic("This cannot happen");
            }
            let target = schema.types.get(&name.to_js_string()?);
            schema.add_type_fields(target, t)?;
        }

        let Some(query_type) = schema.types.get(&query_type_name()?.to_js_string()?) else {
            return panic("Query type not found.");
        };
        schema.query_type = query_type;

        let mutation_type = data.get("__schema")?.get("mutationType")?;
        if mutation_type.is_null() {
            return Ok(schema);
        }
        let mutation_type_name = mutation_type.get("name")?;
        if mutation_type_name.is_null() {
            return panic("Mutation type doesn't have a name.");
        }
        let Some(mutation_type) = schema.types.get(&mutation_type_name.to_js_string()?) else {
            return panic("Mutation type not found.");
        };
        schema.mutation_type = Some(mutation_type);
        Ok(schema)
    }

    /// `addTypeFields(target, source)`. Only the fields and enum values are
    /// kept (the query side reads nothing else), but interfaces, possible
    /// types and input fields are built all the same, for their errors.
    fn add_type_fields(&mut self, target: Option<GqlTypeRef>, source: JsVal<'a>) -> Result<()> {
        let fields = source.get("fields")?;
        if fields.truthy() {
            let mut built = Vec::new();
            for f in fields.map_elements("source.fields")? {
                let f = JsVal::Json(f);
                let name = f.get("name")?;
                f.get("description")?;
                let ty = self.make_type(f.get("type")?)?;
                for arg in f.get("args")?.map_elements("f.args")? {
                    self.make_input_value(JsVal::Json(arg))?;
                }
                built.push(GqlField { name, ty });
            }
            if let Some(t) = self.type_mut(target)? {
                t.fields = Some(built);
            }
        }
        let interfaces = source.get("interfaces")?;
        if interfaces.truthy() {
            for t in interfaces.map_elements("source.interfaces")? {
                self.make_type(JsVal::Json(t))?;
            }
        }
        let possible_types = source.get("possibleTypes")?;
        if possible_types.truthy() {
            for t in possible_types.map_elements("source.possibleTypes")? {
                self.make_type(JsVal::Json(t))?;
            }
        }
        let input_fields = source.get("inputFields")?;
        if input_fields.truthy() {
            for iv in input_fields.map_elements("source.inputFields")? {
                self.make_input_value(JsVal::Json(iv))?;
            }
        }
        let enum_values = source.get("enumValues")?;
        if enum_values.truthy() {
            let mut built = Vec::new();
            for ev in enum_values.map_elements("source.enumValues")? {
                let ev = JsVal::Json(ev);
                let name = ev.get("name")?;
                ev.get("description")?;
                built.push(name);
            }
            if let Some(t) = self.type_mut(target)? {
                t.enum_values = Some(built);
            }
        }
        Ok(())
    }

    /// The type object to add fields to. `undefined` targets (no such
    /// type) fail like assigning a property of `undefined`; functions
    /// and `Object.prototype` take the property, which nothing reads.
    fn type_mut(&mut self, target: Option<GqlTypeRef>) -> Result<Option<&mut GqlType<'a>>> {
        match target {
            Some(GqlTypeRef::Type(index)) => Ok(self.arena.get_mut(index)),
            Some(_) => Ok(None),
            None => Err(type_error(
                "Cannot set properties of undefined (setting 'fields')",
            )),
        }
    }

    /// `makeInputValue(iv)`.
    fn make_input_value(&mut self, iv: JsVal<'a>) -> Result<()> {
        iv.get("name")?;
        iv.get("description")?;
        self.make_type(iv.get("type")?)?;
        iv.get("defaultValue")?;
        Ok(())
    }

    /// `makeType(t)`: a named type's object, or a new object for a list or
    /// non-null wrapper.
    fn make_type(&mut self, t: JsVal<'a>) -> Result<GqlTypeRef> {
        grow_stack(|| {
            let name = t.get("name")?;
            if name.truthy() {
                return match self.types.get(&name.to_js_string()?) {
                    Some(named_type) => Ok(named_type),
                    None => panic(format!("Type {} not found", name.to_js_string()?)),
                };
            }
            let of_type = t.get("ofType")?;
            if !of_type.truthy() {
                return panic(format!(
                    "Type of kind {} has neither name nor ofType",
                    t.get("kind")?.to_js_string()?
                ));
            }
            let kind = t.get("kind")?;
            t.get("description")?;
            if self.wrapper_depth >= MAKE_TYPE_MAX_DEPTH {
                return Err(stack_overflow());
            }
            self.wrapper_depth += 1;
            let of_type = self.make_type(of_type);
            self.wrapper_depth -= 1;
            let of_type = of_type?;
            let mut wrapper = GqlType::new(kind, JsVal::Undefined);
            wrapper.of_type = Some(of_type);
            self.arena.push(wrapper);
            let index = GqlTypeRef::Type(self.arena.len() - 1);
            self.add_type_fields(Some(index), t)?;
            Ok(index)
        })
    }

    fn get(&self, t: GqlTypeRef) -> Option<&GqlType<'a>> {
        match t {
            GqlTypeRef::Type(index) => self.arena.get(index),
            _ => None,
        }
    }

    /// `t.kind`.
    fn kind(&self, t: GqlTypeRef) -> JsVal<'a> {
        self.get(t).map_or(JsVal::Undefined, |t| t.kind)
    }

    /// `t.kind` as a `TypeKind`, if it is one.
    fn type_kind(&self, t: GqlTypeRef) -> Option<TypeKind> {
        self.kind(t).as_str().and_then(TypeKind::from_value)
    }

    /// `t.name` (a function's own name).
    fn name(&self, t: GqlTypeRef) -> JsVal<'a> {
        match t {
            GqlTypeRef::Type(index) => self.arena.get(index).map_or(JsVal::Undefined, |t| t.name),
            GqlTypeRef::Builtin(name) => JsVal::Str(name),
            GqlTypeRef::ObjectPrototype => JsVal::Undefined,
        }
    }

    /// `types[name]` for a type condition.
    fn type_named(&self, name: &str) -> Option<GqlTypeRef> {
        self.types.get(name)
    }
}

/// `getField(t, name)`: the field's type.
fn get_field(schema: &GqlSchema<'_>, t: Option<GqlTypeRef>, name: &str) -> Result<GqlTypeRef> {
    let Some(t) = t else {
        return Err(type_error(
            "Cannot read properties of undefined (reading 'fields')",
        ));
    };
    let Some(fields) = schema.get(t).and_then(|t| t.fields.as_ref()) else {
        return panic(format!(
            "Required field {name} in type {} which doesn't have fields.",
            schema.name(t).to_js_string()?
        ));
    };
    for f in fields {
        if f.name.as_str() == Some(name) {
            return Ok(f.ty);
        }
    }
    panic(format!(
        "Required field {name} not defined on type {}.",
        schema.name(t).to_js_string()?
    ))
}

// ---- Building types ----------------------------------------------------------

/// `makeNames(name, fieldName, containingTypeName)`: `name`, with the field
/// name and combinations with the containing type's name as alternatives.
/// Empty strings stand for `null` (both are falsy).
fn make_names(name: &str, field_name: &str, containing_type_name: &str) -> TypeAttributes {
    let mut alternatives = IndexSet::new();
    if !field_name.is_empty() {
        alternatives.insert(field_name.to_owned());
    }
    if !containing_type_name.is_empty() {
        alternatives.insert(format!("{containing_type_name}_{name}"));
    }
    if !field_name.is_empty() && !containing_type_name.is_empty() {
        alternatives.insert(format!("{containing_type_name}_{field_name}"));
    }
    NamesTypeAttributeKind.make_attributes(TypeNames::make(
        [name.to_owned()].into_iter().collect(),
        Some(alternatives),
        false,
    ))
}

/// `removeNullFromUnion(t)` on a union in the builder: the `null` member,
/// if any, and the other members.
fn remove_null_from_union(
    builder: &TypeBuilder<'_>,
    t: TypeRef,
) -> Result<(Option<TypeRef>, IndexSet<TypeRef>)> {
    let members = builder.type_at_index(t.index())?.members()?.clone();
    let mut null_type = None;
    for &m in &members {
        if builder.type_at_index(m.index())?.kind() == IrTypeKind::Null {
            null_type = Some(m);
            break;
        }
    }
    let Some(null_type) = null_type else {
        return Ok((None, members));
    };
    let mut non_nulls = IndexSet::new();
    for m in members {
        if builder.type_at_index(m.index())?.kind() != IrTypeKind::Null {
            non_nulls.insert(m);
        }
    }
    Ok((Some(null_type), non_nulls))
}

fn is_union(builder: &TypeBuilder<'_>, t: TypeRef) -> Result<bool> {
    Ok(builder.type_at_index(t.index())?.is_union())
}

fn null_type(builder: &mut TypeBuilder<'_>) -> Result<TypeRef> {
    builder.get_primitive_type(IrTypeKind::Null, empty_type_attributes(), None)
}

/// `makeNullable(builder, tref, name, fieldName, containingTypeName)`.
fn make_nullable(
    builder: &mut TypeBuilder<'_>,
    tref: TypeRef,
    name: &str,
    field_name: &str,
    containing_type_name: &str,
) -> Result<TypeRef> {
    let type_names = make_names(name, field_name, containing_type_name);
    if !is_union(builder, tref)? {
        let null = null_type(builder)?;
        return builder.get_union_type(type_names, [tref, null].into_iter().collect(), None);
    }
    let (maybe_null, mut non_nulls) = remove_null_from_union(builder, tref)?;
    if maybe_null.is_some() {
        return Ok(tref);
    }
    non_nulls.insert(null_type(builder)?);
    builder.get_union_type(type_names, non_nulls, None)
}

/// `removeNull(builder, tref)`: the type without `null`. Making a type
/// non-nullable leaves the nullable union behind, unreachable, as in
/// TypeScript.
fn remove_null(builder: &mut TypeBuilder<'_>, tref: TypeRef) -> Result<TypeRef> {
    if !is_union(builder, tref)? {
        return Ok(tref);
    }
    let non_nulls = remove_null_from_union(builder, tref)?.1;
    let Some(&first) = non_nulls.first() else {
        return panic("Trying to remove null results in empty union.");
    };
    if non_nulls.len() == 1 {
        return Ok(first);
    }
    let attributes = builder.attributes_at(tref)?.clone();
    builder.get_union_type(attributes, non_nulls, None)
}

/// `makeScalar(builder, ft)`.
fn make_scalar(builder: &mut TypeBuilder<'_>, name: JsVal<'_>) -> Result<TypeRef> {
    let kind = match name.as_str() {
        Some("Boolean") => IrTypeKind::Bool,
        Some("Int") => IrTypeKind::Integer,
        Some("Float") => IrTypeKind::Double,
        // FIXME (TS): support ID specifically?
        _ => {
            return builder.get_string_type(
                empty_type_attributes(),
                Some(StringTypes::unrestricted()),
                None,
            );
        }
    };
    builder.get_primitive_type(kind, empty_type_attributes(), None)
}

/// `hasOptionalDirectives(directives)`: `@include` or `@skip`.
fn has_optional_directives(directives: &[String]) -> bool {
    directives.iter().any(|d| d == "include" || d == "skip")
}

/// The fragments being expanded, with the nesting level (in selection
/// sets, one per field) of each expansion. Used only to stop where
/// TypeScript would loop or recurse forever: a fragment spread inside its
/// own expansion.
#[derive(Debug, Default)]
struct ActiveFragments {
    levels: HashMap<String, usize>,
}

/// What the TypeScript does with a fragment spread inside its own
/// expansion.
enum Cycle {
    /// It loops forever, expanding the fragment again and again.
    Loop,
    /// It recurses through fields until the stack overflows.
    Recursion,
}

impl ActiveFragments {
    /// Whether spreading `fragment` at `level` repeats an expansion in
    /// progress, and how.
    fn cycle(&self, fragment: &str, level: usize) -> Option<Cycle> {
        self.levels.get(fragment).map(|&l| {
            if l == level {
                Cycle::Loop
            } else {
                Cycle::Recursion
            }
        })
    }
}

/// A selection to process (`Selection` in TypeScript). The type is
/// `None` (`undefined`) for the selections of a fragment on a type the
/// schema lacks, which TypeScript carries along when the fragment is
/// optional anyway.
struct PendingSelection<'q> {
    selection: &'q Selection,
    in_type: Option<GqlTypeRef>,
    optional: bool,
}

/// `expandSelectionSet(selectionSet, inType, optional)`: the selections in
/// reverse, so that popping them yields source order.
fn expand_selection_set(
    selection_set: &SelectionSet,
    in_type: Option<GqlTypeRef>,
    optional: bool,
) -> impl Iterator<Item = PendingSelection<'_>> {
    selection_set
        .selections
        .iter()
        .rev()
        .map(move |s| PendingSelection {
            selection: s,
            in_type,
            optional: optional || has_optional_directives(s.directives()),
        })
}

/// A fragment as `_fragments[name]` finds it.
enum FragmentLookup<'q> {
    /// A fragment definition.
    Fragment(&'q FragmentDefinition),
    /// A value that is not a fragment but truthy: a function of
    /// `Object.prototype`, `Object.prototype`, or a property of the
    /// fragment named `__proto__` (which became the prototype).
    Other,
}

/// `GQLQuery`: a parsed query document against a schema.
struct GqlQuery<'s, 'a> {
    schema: &'s GqlSchema<'a>,
    fragments: HashMap<String, FragmentDefinition>,
    /// The fragment named `__proto__`, which assigning made the prototype
    /// of `_fragments`.
    fragments_prototype: Option<FragmentDefinition>,
    queries: Vec<OperationDefinition>,
    active: RefCell<ActiveFragments>,
}

impl<'s, 'a> GqlQuery<'s, 'a> {
    /// `new GQLQuery(schema, queryString)`.
    fn new(schema: &'s GqlSchema<'a>, query_string: &str) -> Result<Self> {
        let query_document = graphql::parse(query_string)?;
        let mut query = GqlQuery {
            schema,
            fragments: HashMap::new(),
            fragments_prototype: None,
            queries: Vec::new(),
            active: RefCell::default(),
        };
        for def in query_document.definitions {
            match def {
                Definition::Operation(op) => {
                    if matches!(op.operation, OperationType::Query | OperationType::Mutation) {
                        query.queries.push(op);
                    }
                }
                Definition::Fragment(fragment) => {
                    if fragment.name == "__proto__" {
                        query.fragments_prototype = Some(fragment);
                    } else {
                        query.fragments.insert(fragment.name.clone(), fragment);
                    }
                }
                Definition::TypeSystem => {}
            }
        }
        message_assert(
            !query.queries.is_empty(),
            ErrorKind::GraphQLNoQueriesDefined,
            Vec::<(&str, _)>::new(),
        )?;
        Ok(query)
    }

    /// `getFragment(name)`.
    fn get_fragment(&self, name: &str) -> Result<FragmentLookup<'_>> {
        if let Some(fragment) = self.fragments.get(name) {
            return Ok(FragmentLookup::Fragment(fragment));
        }
        let prototype = self.fragments_prototype.as_ref();
        if name == "__proto__" {
            return Ok(prototype.map_or(FragmentLookup::Other, FragmentLookup::Fragment));
        }
        if let Some(prototype) = prototype {
            // The own properties of a `FragmentDefinitionNode`.
            match name {
                "kind" | "name" | "typeCondition" | "directives" | "selectionSet" | "loc" => {
                    return Ok(FragmentLookup::Other);
                }
                "description" if prototype.has_description => return Ok(FragmentLookup::Other),
                "description" => {
                    return panic(format!("Fragment {name} is not defined."));
                }
                _ => {}
            }
        }
        if object_prototype_function(name).is_some() {
            return Ok(FragmentLookup::Other);
        }
        panic(format!("Fragment {name} is not defined."))
    }

    /// `t.name` of a type object that may be `undefined`.
    fn name_of(&self, t: Option<GqlTypeRef>) -> Result<JsVal<'a>> {
        match t {
            Some(t) => Ok(self.schema.name(t)),
            None => Err(type_error(
                "Cannot read properties of undefined (reading 'name')",
            )),
        }
    }

    /// `makeIRTypeFromFieldNode(builder, fieldNode, fieldType,
    /// containingTypeName)`.
    fn make_ir_type_from_field_node(
        &self,
        builder: &mut TypeBuilder<'_>,
        field_node: &crate::graphql::ast::Field,
        field_type: GqlTypeRef,
        containing_type_name: &str,
        level: usize,
    ) -> Result<TypeRef> {
        grow_stack(|| {
            let schema = self.schema;
            let field_name = field_node.name.as_str();
            let mut optional = has_optional_directives(&field_node.directives);
            let mut result = match schema.type_kind(field_type) {
                Some(TypeKind::SCALAR) => {
                    optional = true;
                    make_scalar(builder, schema.name(field_type))?
                }
                Some(TypeKind::OBJECT | TypeKind::INTERFACE | TypeKind::UNION) => {
                    let Some(selection_set) = &field_node.selection_set else {
                        return panic("No selection set on object or interface");
                    };
                    let class = self.make_ir_type_from_selection_set(
                        builder,
                        selection_set,
                        field_type,
                        field_name,
                        containing_type_name,
                        None,
                        level + 1,
                    )?;
                    return make_nullable(builder, class, field_name, "", containing_type_name);
                }
                Some(TypeKind::ENUM) => {
                    let Some(enum_values) =
                        schema.get(field_type).and_then(|t| t.enum_values.as_ref())
                    else {
                        return panic("Enum type doesn't have values");
                    };
                    let values: IndexSet<String> = enum_values
                        .iter()
                        .map(|v| v.to_js_string())
                        .collect::<Result<_>>()?;
                    let type_name = schema.name(field_type);
                    let (name, enum_field_name) = if type_name.truthy() {
                        (type_name.to_js_string()?, field_name)
                    } else {
                        (field_name.to_owned(), "")
                    };
                    optional = true;
                    builder.get_enum_type(
                        make_names(&name, enum_field_name, containing_type_name),
                        values,
                        None,
                    )?
                }
                // FIXME (TS): Support input objects
                Some(TypeKind::INPUT_OBJECT) => return panic("Input objects not supported"),
                Some(TypeKind::LIST) => {
                    let Some(of_type) = schema.get(field_type).and_then(|t| t.of_type) else {
                        return panic("No type for list");
                    };
                    optional = true;
                    let items = self.make_ir_type_from_field_node(
                        builder,
                        field_node,
                        of_type,
                        containing_type_name,
                        level,
                    )?;
                    builder.get_array_type(empty_type_attributes(), items, None)?
                }
                Some(TypeKind::NON_NULL) => {
                    let Some(of_type) = schema.get(field_type).and_then(|t| t.of_type) else {
                        return panic("No type for non-null");
                    };
                    let inner = self.make_ir_type_from_field_node(
                        builder,
                        field_node,
                        of_type,
                        containing_type_name,
                        level,
                    )?;
                    remove_null(builder, inner)?
                }
                None => return assert_never(schema.kind(field_type).to_js_string()?),
            };
            if optional {
                result = make_nullable(builder, result, field_name, "", containing_type_name)?;
            }
            Ok(result)
        })
    }

    /// `makeIRTypeFromSelectionSet(builder, selectionSet, gqlType,
    /// containingFieldName, containingTypeName, overrideName)`. Empty
    /// strings stand for `null` names; `level` is the nesting in selection
    /// sets (for [`ActiveFragments`]).
    #[allow(clippy::too_many_arguments)]
    fn make_ir_type_from_selection_set(
        &self,
        builder: &mut TypeBuilder<'_>,
        selection_set: &SelectionSet,
        gql_type: GqlTypeRef,
        containing_field_name: &str,
        containing_type_name: &str,
        override_name: Option<&str>,
        level: usize,
    ) -> Result<TypeRef> {
        let schema = self.schema;
        if !matches!(
            schema.type_kind(gql_type),
            Some(TypeKind::OBJECT | TypeKind::INTERFACE | TypeKind::UNION)
        ) {
            return panic("Type for selection set is not object, interface, or union.");
        }
        let gql_name = schema.name(gql_type);
        if !gql_name.truthy() {
            return panic("Object, interface, or union type doesn't have a name.");
        }
        let name_or_override = match override_name {
            Some(name) => name.to_owned(),
            None => gql_name.to_js_string()?,
        };
        let mut properties: IndexMap<String, ClassProperty> = IndexMap::new();
        let mut selections: Vec<PendingSelection<'_>> =
            expand_selection_set(selection_set, Some(gql_type), false).collect();
        // The fragment expansions in progress here, each with the stack
        // height its selections start at: once the stack is below that,
        // the expansion is done.
        let mut expansions: Vec<(&str, usize)> = Vec::new();
        while let Some(next_item) = selections.pop() {
            let height = selections.len();
            while let Some(&(name, start)) = expansions.last()
                && start > height
            {
                self.active.borrow_mut().levels.remove(name);
                expansions.pop();
            }
            let PendingSelection {
                selection,
                optional,
                in_type,
            } = next_item;
            match selection {
                Selection::Field(field) => {
                    let given_name = field.alias.as_ref().unwrap_or(&field.name);
                    let field_gql_type = get_field(schema, in_type, &field.name)?;
                    let field_type = self.make_ir_type_from_field_node(
                        builder,
                        field,
                        field_gql_type,
                        &name_or_override,
                        level,
                    )?;
                    properties.insert(
                        given_name.clone(),
                        builder.make_class_property(field_type, optional),
                    );
                }
                Selection::FragmentSpread(spread) => {
                    let fragment = match self.get_fragment(&spread.name)? {
                        FragmentLookup::Fragment(fragment) => fragment,
                        FragmentLookup::Other => {
                            return Err(type_error(
                                "Cannot read properties of undefined (reading 'name')",
                            ));
                        }
                    };
                    let fragment_type = schema.type_named(&fragment.type_condition);
                    // `fragmentType.name` is read only if not optional.
                    let fragment_optional = optional
                        || !self
                            .name_of(fragment_type)?
                            .strict_equals(self.name_of(in_type)?);
                    match self.active.borrow().cycle(&spread.name, level) {
                        Some(Cycle::Recursion) => return Err(stack_overflow()),
                        Some(Cycle::Loop) => {
                            return panic(format!(
                                "Fragment {} spreads itself, which never terminates.",
                                spread.name
                            ));
                        }
                        None => {}
                    }
                    self.active
                        .borrow_mut()
                        .levels
                        .insert(spread.name.clone(), level);
                    expansions.push((&spread.name, height));
                    selections.extend(expand_selection_set(
                        &fragment.selection_set,
                        fragment_type,
                        fragment_optional,
                    ));
                }
                Selection::InlineFragment(inline) => {
                    // FIXME (TS): support type conditions with discriminated unions
                    let fragment_type = match &inline.type_condition {
                        Some(name) => schema.type_named(name),
                        None => in_type,
                    };
                    let fragment_optional = optional
                        || !self
                            .name_of(fragment_type)?
                            .strict_equals(self.name_of(in_type)?)
                        || has_optional_directives(&inline.directives);
                    selections.extend(expand_selection_set(
                        &inline.selection_set,
                        fragment_type,
                        fragment_optional,
                    ));
                }
            }
        }
        let mut active = self.active.borrow_mut();
        for (name, _) in expansions {
            active.levels.remove(name);
        }
        drop(active);
        builder.get_class_type(
            make_names(
                &name_or_override,
                containing_field_name,
                containing_type_name,
            ),
            properties,
            None,
        )
    }

    /// `makeType(builder, query, queryName)`: the type of the query's
    /// `data`.
    fn make_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        query: &OperationDefinition,
        query_name: &str,
    ) -> Result<TypeRef> {
        let root = match query.operation {
            OperationType::Query => self.schema.query_type,
            OperationType::Mutation => match self.schema.mutation_type {
                Some(mutation_type) => mutation_type,
                None => return panic("This GraphQL endpoint has no mutations."),
            },
            OperationType::Subscription => {
                return panic(format!(
                    "Unknown query operation type: \"{}\"",
                    query.operation.as_str()
                ));
            }
        };
        self.make_ir_type_from_selection_set(
            builder,
            &query.selection_set,
            root,
            "",
            query_name,
            Some("data"),
            0,
        )
    }
}

/// `makeGraphQLQueryTypes(topLevelName, builder, json, queryString)`: the
/// top-level type of each query, by query name.
fn make_graphql_query_types(
    top_level_name: &str,
    builder: &mut TypeBuilder<'_>,
    json: &JsonValue,
    query_string: &str,
) -> Result<IndexMap<String, TypeRef>> {
    let schema = GqlSchema::new(json)?;
    let query = GqlQuery::new(&schema, query_string)?;
    let mut types: IndexMap<String, TypeRef> = IndexMap::new();
    for odn in &query.queries {
        let query_name = odn.name.as_deref().unwrap_or(top_level_name);
        if types.contains_key(query_name) {
            return panic(format!("Duplicate query name {query_name}"));
        }
        let data_type = query.make_type(builder, odn, query_name)?;
        let null = null_type(builder)?;
        let data_or_null_type = builder.get_union_type(
            empty_type_attributes(),
            [data_type, null].into_iter().collect(),
            None,
        )?;
        let message_type = builder.get_string_type(
            empty_type_attributes(),
            Some(StringTypes::unrestricted()),
            None,
        )?;
        let error_type = builder.get_class_type(
            names_with_alternative("error", "graphQLError"),
            [(
                "message".to_owned(),
                builder.make_class_property(message_type, false),
            )]
            .into_iter()
            .collect(),
            None,
        )?;
        let error_array = builder.get_array_type(
            names_with_alternative("errors", "graphQLErrors"),
            error_type,
            None,
        )?;
        let t = builder.get_class_type(
            make_names_type_attributes(query_name, false),
            [
                (
                    "data".to_owned(),
                    builder.make_class_property(data_or_null_type, false),
                ),
                (
                    "errors".to_owned(),
                    builder.make_class_property(error_array, true),
                ),
            ]
            .into_iter()
            .collect(),
            None,
        )?;
        types.insert(query_name.to_owned(), t);
    }
    Ok(types)
}

/// `namesTypeAttributeKind.makeAttributes(TypeNames.make(new Set([name]),
/// new Set([alternative]), false))`.
fn names_with_alternative(name: &str, alternative: &str) -> TypeAttributes {
    NamesTypeAttributeKind.make_attributes(TypeNames::make(
        [name.to_owned()].into_iter().collect(),
        Some([alternative.to_owned()].into_iter().collect()),
        false,
    ))
}

// ---- The input ---------------------------------------------------------------

/// A GraphQL source (TS `GraphQLSourceData`): a query document and the
/// introspection result of the schema it queries.
#[derive(Clone, Debug, PartialEq)]
pub struct GraphQlSourceData {
    /// The top-level's name, used when the input has only this source.
    pub name: String,
    /// The query document.
    pub query: String,
    /// The introspection query result (`{"data": {"__schema": …}}`), as
    /// `parseJSON` read it.
    pub schema: JsonValue,
}

/// TS `GraphQLTopLevel`.
#[derive(Clone, Debug, PartialEq)]
struct GraphQlTopLevel {
    query: String,
    schema: JsonValue,
}

/// The GraphQL input (TS `GraphQLInput`), of kind `"graphql"`.
///
/// Each source's queries become top-levels. With a single source the
/// top-level takes the source's name (so a document with several queries
/// then fails, as in TypeScript); with several, each query's name (or the
/// source's name for an anonymous query).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct GraphQlInput {
    top_levels: IndexMap<String, GraphQlTopLevel>,
}

impl GraphQlInput {
    /// `new GraphQLInput()`.
    pub fn new() -> Self {
        Self::default()
    }

    /// `addSourceSync(source)`: stores the source (a later source of the
    /// same name replaces it, keeping its position).
    pub fn add_source_sync(&mut self, source: GraphQlSourceData) {
        self.top_levels.insert(
            source.name,
            GraphQlTopLevel {
                schema: source.schema,
                query: source.query,
            },
        );
    }

    /// `addTypesSync(ctx, typeBuilder)`: parses every source's schema and
    /// queries and adds their types and top-levels.
    pub fn add_types_sync(&self, type_builder: &mut TypeBuilder<'_>) -> Result<()> {
        for (name, top_level) in &self.top_levels {
            let new_top_levels =
                make_graphql_query_types(name, type_builder, &top_level.schema, &top_level.query)?;
            for (actual_name, t) in new_top_levels {
                let top_level_name = if self.top_levels.len() == 1 {
                    name
                } else {
                    &actual_name
                };
                type_builder.add_top_level(top_level_name, t)?;
            }
        }
        Ok(())
    }
}

impl Input for GraphQlInput {
    type Source = GraphQlSourceData;

    fn kind(&self) -> &str {
        "graphql"
    }

    fn need_ir(&self) -> bool {
        true
    }

    fn need_schema_processing(&self) -> bool {
        false
    }

    fn add_source_sync(&mut self, source: Self::Source) -> Result<()> {
        GraphQlInput::add_source_sync(self, source);
        Ok(())
    }

    fn add_types_sync(
        &mut self,
        _ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        _infer_maps: bool,
        _infer_enums: bool,
        _fixed_top_levels: bool,
    ) -> Result<()> {
        GraphQlInput::add_types_sync(self, type_builder)
    }

    fn single_string_schema_source(&self) -> Option<String> {
        None
    }
}
