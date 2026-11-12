import * as z from "zod";


export const AnnotationsSchema = z.object({
    "description": z.string(),
    "type": z.string(),
});
export type Annotations = z.infer<typeof AnnotationsSchema>;

export const InfoSchema = z.object({
    "description": z.string(),
    "title": z.string(),
    "version": z.string(),
});
export type Info = z.infer<typeof InfoSchema>;

export const ParameterSchema = z.object({
    "description": z.string(),
    "format": z.string(),
    "in": z.string(),
    "name": z.string(),
    "required": z.boolean(),
    "type": z.string(),
});
export type Parameter = z.infer<typeof ParameterSchema>;

export const SchemaSchema = z.object({
    "$ref": z.string(),
});
export type Schema = z.infer<typeof SchemaSchema>;

export const PropertiesSchema = z.object({
    "annotations": AnnotationsSchema,
    "datatype_properties": AnnotationsSchema,
    "id": AnnotationsSchema,
    "label": AnnotationsSchema,
    "sub_class_of": AnnotationsSchema,
    "type": AnnotationsSchema,
});
export type Properties = z.infer<typeof PropertiesSchema>;

export const The200Schema = z.object({
    "description": z.string(),
    "schema": SchemaSchema,
});
export type The200 = z.infer<typeof The200Schema>;

export const TaxonomySchema = z.object({
    "properties": PropertiesSchema,
});
export type Taxonomy = z.infer<typeof TaxonomySchema>;

export const ResponsesSchema = z.object({
    "200": The200Schema,
});
export type Responses = z.infer<typeof ResponsesSchema>;

export const DefinitionsSchema = z.object({
    "Taxonomy": TaxonomySchema,
});
export type Definitions = z.infer<typeof DefinitionsSchema>;

export const GetSchema = z.object({
    "description": z.string(),
    "parameters": z.array(ParameterSchema),
    "responses": ResponsesSchema,
    "summary": z.string(),
    "tags": z.array(z.string()),
});
export type Get = z.infer<typeof GetSchema>;

export const ItaTaxonomiesSearchSchema = z.object({
    "get": GetSchema,
});
export type ItaTaxonomiesSearch = z.infer<typeof ItaTaxonomiesSearchSchema>;

export const PathsSchema = z.object({
    "/ita_taxonomies/search": ItaTaxonomiesSearchSchema,
});
export type Paths = z.infer<typeof PathsSchema>;

export const TopLevelSchema = z.object({
    "basePath": z.string(),
    "definitions": DefinitionsSchema,
    "host": z.string(),
    "info": InfoSchema,
    "paths": PathsSchema,
    "produces": z.array(z.string()),
    "schemes": z.array(z.string()),
    "swagger": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
