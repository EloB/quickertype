import * as z from "zod";


export const TypeSchema = z.enum([
    "string",
]);
export type Type = z.infer<typeof TypeSchema>;


export const InSchema = z.enum([
    "query",
]);
export type In = z.infer<typeof InSchema>;

export const PropertySchema = z.object({
    "description": z.string(),
    "type": TypeSchema,
});
export type Property = z.infer<typeof PropertySchema>;

export const InfoSchema = z.object({
    "description": z.string(),
    "title": z.string(),
    "version": z.string(),
});
export type Info = z.infer<typeof InfoSchema>;

export const ParameterSchema = z.object({
    "description": z.string(),
    "format": TypeSchema,
    "in": InSchema,
    "name": z.string(),
    "required": z.boolean(),
    "type": TypeSchema,
});
export type Parameter = z.infer<typeof ParameterSchema>;

export const ItemsSchema = z.object({
    "$ref": z.string(),
});
export type Items = z.infer<typeof ItemsSchema>;

export const ListSchema = z.object({
    "properties": z.record(z.string(), PropertySchema),
});
export type List = z.infer<typeof ListSchema>;

export const SchemaSchema = z.object({
    "items": ItemsSchema,
    "type": z.string(),
});
export type Schema = z.infer<typeof SchemaSchema>;

export const DefinitionsSchema = z.object({
    "List": ListSchema,
});
export type Definitions = z.infer<typeof DefinitionsSchema>;

export const The200Schema = z.object({
    "description": z.string(),
    "schema": SchemaSchema,
});
export type The200 = z.infer<typeof The200Schema>;

export const ResponsesSchema = z.object({
    "200": The200Schema,
});
export type Responses = z.infer<typeof ResponsesSchema>;

export const GetSchema = z.object({
    "description": z.string(),
    "parameters": z.array(ParameterSchema),
    "responses": ResponsesSchema,
    "summary": z.string(),
    "tags": z.array(z.string()),
});
export type Get = z.infer<typeof GetSchema>;

export const ConsolidatedScreeningListSearchSchema = z.object({
    "get": GetSchema,
});
export type ConsolidatedScreeningListSearch = z.infer<typeof ConsolidatedScreeningListSearchSchema>;

export const PathsSchema = z.object({
    "/consolidated_screening_list/search": ConsolidatedScreeningListSearchSchema,
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
