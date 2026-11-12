import * as z from "zod";


export const TypeSchema = z.enum([
    "string",
]);
export type Type = z.infer<typeof TypeSchema>;

export const ClickUrlSchema = z.object({
    "description": z.string(),
    "type": TypeSchema,
});
export type ClickUrl = z.infer<typeof ClickUrlSchema>;

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

export const PropertiesSchema = z.object({
    "click_url": ClickUrlSchema,
    "country": ClickUrlSchema,
    "description": ClickUrlSchema,
    "expiration_date": ClickUrlSchema,
    "id": ClickUrlSchema,
    "industry": ClickUrlSchema,
    "report_type": ClickUrlSchema,
    "source_industry": ClickUrlSchema,
    "title": ClickUrlSchema,
    "url": ClickUrlSchema,
});
export type Properties = z.infer<typeof PropertiesSchema>;

export const SchemaSchema = z.object({
    "items": ItemsSchema,
    "type": z.string(),
});
export type Schema = z.infer<typeof SchemaSchema>;

export const ReportSchema = z.object({
    "properties": PropertiesSchema,
});
export type Report = z.infer<typeof ReportSchema>;

export const The200Schema = z.object({
    "description": z.string(),
    "schema": SchemaSchema,
});
export type The200 = z.infer<typeof The200Schema>;

export const DefinitionsSchema = z.object({
    "Report": ReportSchema,
});
export type Definitions = z.infer<typeof DefinitionsSchema>;

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

export const MarketResearchLibrarySearchSchema = z.object({
    "get": GetSchema,
});
export type MarketResearchLibrarySearch = z.infer<typeof MarketResearchLibrarySearchSchema>;

export const PathsSchema = z.object({
    "/market_research_library/search": MarketResearchLibrarySearchSchema,
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
