import * as z from "zod";


export const TypeSchema = z.enum([
    "string",
]);
export type Type = z.infer<typeof TypeSchema>;

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
    "in": z.string(),
    "name": z.string(),
    "required": z.boolean(),
    "type": TypeSchema,
});
export type Parameter = z.infer<typeof ParameterSchema>;

export const ItemsSchema = z.object({
    "$ref": z.string(),
});
export type Items = z.infer<typeof ItemsSchema>;

export const RateSchema = z.object({
    "properties": z.record(z.string(), PropertySchema),
});
export type Rate = z.infer<typeof RateSchema>;

export const SchemaSchema = z.object({
    "items": ItemsSchema,
    "type": z.string(),
});
export type Schema = z.infer<typeof SchemaSchema>;

export const DefinitionsSchema = z.object({
    "Rate": RateSchema,
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

export const TariffRatesSearchSchema = z.object({
    "get": GetSchema,
});
export type TariffRatesSearch = z.infer<typeof TariffRatesSearchSchema>;

export const PathsSchema = z.object({
    "/tariff_rates/search": TariffRatesSearchSchema,
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
