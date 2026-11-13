//! Port of `packages/quicktype-core/src/language/JSONSchema/JSONSchemaRenderer.ts`.
//!
//! Renders the type graph back to a draft-06 JSON Schema: the top-level's
//! schema with every class, object, named union and enum under
//! `definitions`. The schema is built as JavaScript objects ([`SchemaObject`],
//! keys in JavaScript property order, `undefined` kept) and written with
//! `JSON.stringify(schema, undefined, "    ")`.

use quicktype_js_compat::json::{self, JsonValue};

use crate::attributes::description::add_description_to_schema;
use crate::attributes::type_attributes::{
    SchemaObject, schema_object_to_json, set_schema_property,
};
use crate::convenience_renderer::prelude::*;
use crate::support::recursion::guard;
use crate::support::support::{defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::transformed_string_type::transformed_string_type_targets;

use super::utils::naming_function;

/// `Schema`: a JSON Schema object under construction.
type Schema = SchemaObject;

/// A schema object literal: `entries` in order, `None` for `undefined`.
fn schema_of<const N: usize>(entries: [(&str, Option<JsonValue>); N]) -> Schema {
    let mut schema = Schema::new();
    for (key, value) in entries {
        set_schema_property(&mut schema, key, value);
    }
    schema
}

/// `{ type: kind }`.
fn type_schema(kind: &str) -> Schema {
    schema_of([("type", Some(JsonValue::String(kind.to_owned())))])
}

/// Whether `schema[key] === undefined`.
fn is_undefined(schema: &Schema, key: &str) -> bool {
    !matches!(schema.get(key), Some(Some(_)))
}

/// `JSONSchemaRenderer`.
pub struct JsonSchemaRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    /// `namingFunction` (a module-level singleton in TypeScript).
    naming_function: Namer,
}

impl std::fmt::Debug for JsonSchemaRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("JsonSchemaRenderer").finish_non_exhaustive()
    }
}

impl<'a> JsonSchemaRenderer<'a> {
    /// `new JSONSchemaRenderer(targetLanguage, renderContext)`.
    pub fn new(target_language: &'a dyn TargetLanguage, render_context: RenderContext<'a>) -> Self {
        JsonSchemaRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            naming_function: naming_function(),
        }
    }

    /// `nameForType(t)`: the assigned name of a named type.
    fn name_for_type(&self, t: TypeRef) -> Result<String> {
        self.assigned_name(self.name_for_named_type(t)?)
    }

    /// `makeOneOf(types)`: the only type's schema, or `anyOf` all of them.
    fn make_one_of(&self, types: &[TypeRef]) -> Result<Schema> {
        let Some(&first) = types.first() else {
            return panic("Must have at least one type for oneOf");
        };

        if types.len() == 1 {
            return self.schema_for_type(first);
        }

        let any_of = types
            .iter()
            .map(|&t| Ok(schema_object_to_json(self.schema_for_type(t)?)))
            .collect::<Result<Vec<_>>>()?;
        Ok(schema_of([("anyOf", Some(JsonValue::Array(any_of)))]))
    }

    /// `makeRef(t)`: `{ $ref: "#/definitions/<name>" }`.
    fn make_ref(&self, t: TypeRef) -> Result<Schema> {
        let reference = format!("#/definitions/{}", self.name_for_type(t)?);
        Ok(schema_of([("$ref", Some(JsonValue::String(reference)))]))
    }

    /// `addAttributesToSchema(t, schema)`: every attribute of `t`, in
    /// attribute order, adds its keywords.
    fn add_attributes_to_schema(&self, t: TypeRef, schema: &mut Schema) -> Result<()> {
        let graph = self.type_graph();
        let kind = graph.kind(t)?;
        for attribute in graph.attributes(t)?.iter() {
            attribute.add_to_schema(schema, kind);
        }
        Ok(())
    }

    /// `schemaForType(t)`.
    fn schema_for_type(&self, t: TypeRef) -> Result<Schema> {
        // Endless on a cycle through a nullable union (V8 overflows its stack).
        guard(|| {
            let graph = self.type_graph();
            let ty = graph.type_at(t)?;
            let mut schema = match ty.kind() {
                TypeKind::None => return panic("none type should have been replaced"),
                TypeKind::Any => Schema::new(),
                TypeKind::Null => type_schema("null"),
                TypeKind::Bool => type_schema("boolean"),
                TypeKind::Integer => type_schema("integer"),
                TypeKind::Double => type_schema("number"),
                TypeKind::String => type_schema("string"),
                TypeKind::Array => {
                    let items = schema_object_to_json(self.schema_for_type(ty.items()?)?);
                    schema_of([
                        ("type", Some(JsonValue::String("array".to_owned()))),
                        ("items", Some(items)),
                    ])
                }
                TypeKind::Class | TypeKind::Object | TypeKind::Enum => self.make_ref(t)?,
                TypeKind::Map => self.definition_for_object(t, None)?,
                TypeKind::Union => {
                    if self.union_needs_name(t)? {
                        self.make_ref(t)?
                    } else {
                        self.definition_for_union(t, None)?
                    }
                }
                TypeKind::Intersection => return panic("Unknown type intersection"),
                kind => {
                    let Some(target) = transformed_string_type_targets(kind) else {
                        return panic(format!("Unknown transformed string type {kind}"));
                    };
                    schema_of([
                        ("type", Some(JsonValue::String("string".to_owned()))),
                        (
                            "format",
                            Some(JsonValue::String(target.json_schema.to_owned())),
                        ),
                    ])
                }
            };
            if is_undefined(&schema, "$ref") {
                self.add_attributes_to_schema(t, &mut schema)?;
            }

            Ok(schema)
        })
    }

    /// `definitionForObject(o, title)`.
    fn definition_for_object(&self, o: TypeRef, title: Option<&str>) -> Result<Schema> {
        let graph = self.type_graph();
        let ty = graph.type_at(o)?;
        let properties = ty.properties()?;
        let (properties, required) = if properties.is_empty() {
            (None, None)
        } else {
            let mut props = Schema::new();
            let mut req: Vec<String> = Vec::new();
            for (name, p) in properties {
                let mut prop = self.schema_for_type(p.type_ref)?;
                if is_undefined(&prop, "description") {
                    let description = self.description_for_class_property(o, name)?;
                    add_description_to_schema(&mut prop, description.as_ref());
                }

                set_schema_property(&mut props, name, Some(schema_object_to_json(prop)));
                if !p.is_optional {
                    req.push(name.clone());
                }
            }

            quicktype_js_compat::sort::sort_strings(&mut req);
            let required = req.into_iter().map(JsonValue::String).collect();
            (
                Some(schema_object_to_json(props)),
                Some(JsonValue::Array(required)),
            )
        };

        let additional_properties = match ty.additional_properties()? {
            Some(additional) => schema_object_to_json(self.schema_for_type(additional)?),
            None => JsonValue::Bool(false),
        };
        let mut schema = schema_of([
            ("type", Some(JsonValue::String("object".to_owned()))),
            ("additionalProperties", Some(additional_properties)),
            ("properties", properties),
            ("required", required),
            ("title", title.map(|t| JsonValue::String(t.to_owned()))),
        ]);
        self.add_attributes_to_schema(o, &mut schema)?;
        Ok(schema)
    }

    /// `definitionForUnion(u, title)`.
    fn definition_for_union(&self, u: TypeRef, title: Option<&str>) -> Result<Schema> {
        let sorted_members: Vec<TypeRef> = self
            .type_graph()
            .non_attribute_children(u)?
            .into_iter()
            .collect();
        let mut one_of = self.make_one_of(&sorted_members)?;
        if let Some(title) = title {
            set_schema_property(
                &mut one_of,
                "title",
                Some(JsonValue::String(title.to_owned())),
            );
        }

        self.add_attributes_to_schema(u, &mut one_of)?;
        Ok(one_of)
    }

    /// `definitionForEnum(e, title)`.
    fn definition_for_enum(&self, e: TypeRef, title: &str) -> Result<Schema> {
        let cases = self
            .type_graph()
            .type_at(e)?
            .cases()?
            .iter()
            .map(|c| JsonValue::String(c.clone()))
            .collect();
        let mut schema = schema_of([
            ("type", Some(JsonValue::String("string".to_owned()))),
            ("enum", Some(JsonValue::Array(cases))),
            ("title", Some(JsonValue::String(title.to_owned()))),
        ]);
        self.add_attributes_to_schema(e, &mut schema)?;
        Ok(schema)
    }

    /// `names.get(name)`, which must be assigned.
    fn assigned_name(&self, name: Name) -> Result<String> {
        Ok(defined(self.names()?.get(name))?.to_owned())
    }
}

impl<'a> ConvenienceRenderer<'a> for JsonSchemaRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    fn make_named_type_namer(&mut self) -> Namer {
        self.naming_function.clone()
    }

    fn namer_for_object_property(
        &mut self,
        _o: TypeRef,
        _p: &ClassProperty,
    ) -> Result<Option<Namer>> {
        Ok(None)
    }

    fn make_union_member_namer(&mut self) -> Option<Namer> {
        None
    }

    fn make_enum_case_namer(&mut self) -> Option<Namer> {
        None
    }

    fn emit_source_structure(&mut self, _given_output_filename: &str) -> Result<()> {
        // FIXME: Find a good way to do multiple top-levels.  Maybe multiple files?
        let top_level_type = if self.top_levels().len() == 1 {
            let (_, &t) = defined(self.top_levels().first())?;
            self.schema_for_type(t)?
        } else {
            Schema::new()
        };
        // `{ $schema: ..., ...topLevelType }`: the spread copies every own
        // property, `undefined` ones included.
        let mut schema = schema_of([(
            "$schema",
            Some(JsonValue::String(
                "http://json-schema.org/draft-06/schema#".to_owned(),
            )),
        )]);
        for (key, value) in top_level_type {
            json::insert_js_property(&mut schema, key, value);
        }

        let mut definitions = Schema::new();
        self.for_each_object(BlankLinePosition::None, |r, o, name, _| {
            let title = r.assigned_name(name)?;
            let definition = r.definition_for_object(o, Some(&title))?;
            set_schema_property(
                &mut definitions,
                &title,
                Some(schema_object_to_json(definition)),
            );
            Ok(())
        })?;
        self.for_each_union(BlankLinePosition::None, |r, u, name, _| {
            if !r.union_needs_name(u)? {
                return Ok(());
            }
            let title = r.assigned_name(name)?;
            let definition = r.definition_for_union(u, Some(&title))?;
            set_schema_property(
                &mut definitions,
                &title,
                Some(schema_object_to_json(definition)),
            );
            Ok(())
        })?;
        self.for_each_enum(BlankLinePosition::None, |r, e, name, _| {
            let title = r.assigned_name(name)?;
            let definition = r.definition_for_enum(e, &title)?;
            set_schema_property(
                &mut definitions,
                &title,
                Some(schema_object_to_json(definition)),
            );
            Ok(())
        })?;
        set_schema_property(
            &mut schema,
            "definitions",
            Some(schema_object_to_json(definitions)),
        );

        let text = json::stringify(&schema_object_to_json(schema), Some("    "));
        self.emit_multiline(&text)
    }
}
