import * as z from "zod";


export const FormatEnumSchema = z.enum([
    "string",
]);
export type FormatEnum = z.infer<typeof FormatEnumSchema>;


export const InSchema = z.enum([
    "query",
]);
export type In = z.infer<typeof InSchema>;


export const SchemaTypeSchema = z.enum([
    "array",
]);
export type SchemaType = z.infer<typeof SchemaTypeSchema>;

export const PropertySchema = z.object({
    "description": z.string(),
    "type": FormatEnumSchema,
});
export type Property = z.infer<typeof PropertySchema>;

export const DeMinimisPropertiesSchema = z.object({
    "countries": PropertySchema,
    "country": PropertySchema,
    "de_minimis_currency": PropertySchema,
    "de_minimis_value": PropertySchema,
    "notes": PropertySchema,
    "vat_amount": PropertySchema,
    "vat_currency": PropertySchema,
});
export type DeMinimisProperties = z.infer<typeof DeMinimisPropertiesSchema>;

export const FaqPropertiesSchema = z.object({
    "answer": PropertySchema,
    "countries": PropertySchema,
    "first_published_date": PropertySchema,
    "id": PropertySchema,
    "industries": PropertySchema,
    "last_published_date": PropertySchema,
    "question": PropertySchema,
    "topics": PropertySchema,
    "trade_regions": PropertySchema,
    "url": PropertySchema,
    "world_regions": PropertySchema,
});
export type FaqProperties = z.infer<typeof FaqPropertiesSchema>;

export const ReportPropertiesSchema = z.object({
    "countries": PropertySchema,
    "description": PropertySchema,
    "expiration_date": PropertySchema,
    "id": PropertySchema,
    "industries": PropertySchema,
    "ita_industries": PropertySchema,
    "report_type": PropertySchema,
    "title": PropertySchema,
    "url": PropertySchema,
});
export type ReportProperties = z.infer<typeof ReportPropertiesSchema>;

export const TaxonomyPropertiesSchema = z.object({
    "annotations": PropertySchema,
    "datatype_properties": PropertySchema,
    "id": PropertySchema,
    "label": PropertySchema,
    "sub_class_of": PropertySchema,
    "type": PropertySchema,
});
export type TaxonomyProperties = z.infer<typeof TaxonomyPropertiesSchema>;

export const InfoSchema = z.object({
    "description": z.string(),
    "title": z.string(),
    "version": z.string(),
});
export type Info = z.infer<typeof InfoSchema>;

export const ParameterSchema = z.object({
    "description": z.string(),
    "format": FormatEnumSchema,
    "in": InSchema,
    "name": z.string(),
    "required": z.boolean(),
    "type": FormatEnumSchema,
});
export type Parameter = z.infer<typeof ParameterSchema>;

export const ItemsClassSchema = z.object({
    "$ref": z.string(),
});
export type ItemsClass = z.infer<typeof ItemsClassSchema>;

export const PurpleSchemaSchema = z.object({
    "items": ItemsClassSchema,
    "type": SchemaTypeSchema,
});
export type PurpleSchema = z.infer<typeof PurpleSchemaSchema>;

export const ArticleSchema = z.object({
    "properties": z.record(z.string(), PropertySchema),
});
export type Article = z.infer<typeof ArticleSchema>;

export const DeMinimisSchema = z.object({
    "properties": DeMinimisPropertiesSchema,
});
export type DeMinimis = z.infer<typeof DeMinimisSchema>;

export const FaqSchema = z.object({
    "properties": FaqPropertiesSchema,
});
export type Faq = z.infer<typeof FaqSchema>;

export const ReportSchema = z.object({
    "properties": ReportPropertiesSchema,
});
export type Report = z.infer<typeof ReportSchema>;

export const TaxonomySchema = z.object({
    "properties": TaxonomyPropertiesSchema,
});
export type Taxonomy = z.infer<typeof TaxonomySchema>;

export const Purple200Schema = z.object({
    "description": z.string(),
    "schema": ItemsClassSchema,
});
export type Purple200 = z.infer<typeof Purple200Schema>;

export const Fluffy200Schema = z.object({
    "description": z.string(),
    "schema": PurpleSchemaSchema,
});
export type Fluffy200 = z.infer<typeof Fluffy200Schema>;

export const DefinitionsSchema = z.object({
    "Article": ArticleSchema,
    "Center": ArticleSchema,
    "DeMinimis": DeMinimisSchema,
    "Event": ArticleSchema,
    "FAQ": FaqSchema,
    "Lead": ArticleSchema,
    "List": ArticleSchema,
    "MarketIntelligence": ArticleSchema,
    "Office": ArticleSchema,
    "Provider": ArticleSchema,
    "Rate": ArticleSchema,
    "Report": ReportSchema,
    "Taxonomy": TaxonomySchema,
});
export type Definitions = z.infer<typeof DefinitionsSchema>;

export const PurpleResponsesSchema = z.object({
    "200": Purple200Schema,
});
export type PurpleResponses = z.infer<typeof PurpleResponsesSchema>;

export const FluffyResponsesSchema = z.object({
    "200": Fluffy200Schema,
});
export type FluffyResponses = z.infer<typeof FluffyResponsesSchema>;

export const BusinessServiceProvidersSearchGetSchema = z.object({
    "description": z.string(),
    "parameters": z.array(ParameterSchema),
    "responses": PurpleResponsesSchema,
    "summary": z.string(),
    "tags": z.array(z.string()),
});
export type BusinessServiceProvidersSearchGet = z.infer<typeof BusinessServiceProvidersSearchGetSchema>;

export const ConsolidatedScreeningListSearchGetSchema = z.object({
    "description": z.string(),
    "parameters": z.array(ParameterSchema),
    "responses": FluffyResponsesSchema,
    "summary": z.string(),
    "tags": z.array(z.string()),
});
export type ConsolidatedScreeningListSearchGet = z.infer<typeof ConsolidatedScreeningListSearchGetSchema>;

export const BusinessServiceProvidersSearchClassSchema = z.object({
    "get": BusinessServiceProvidersSearchGetSchema,
});
export type BusinessServiceProvidersSearchClass = z.infer<typeof BusinessServiceProvidersSearchClassSchema>;

export const ConsolidatedScreeningListSearchClassSchema = z.object({
    "get": ConsolidatedScreeningListSearchGetSchema,
});
export type ConsolidatedScreeningListSearchClass = z.infer<typeof ConsolidatedScreeningListSearchClassSchema>;

export const PathsSchema = z.object({
    "/business_service_providers/search": BusinessServiceProvidersSearchClassSchema,
    "/consolidated_screening_list/search": ConsolidatedScreeningListSearchClassSchema,
    "/de_minimis/search": ConsolidatedScreeningListSearchClassSchema,
    "/ita_faqs/search": ConsolidatedScreeningListSearchClassSchema,
    "/ita_office_locations/search": ConsolidatedScreeningListSearchClassSchema,
    "/ita_taxonomies/search": BusinessServiceProvidersSearchClassSchema,
    "/ita_zipcode_to_post/search": BusinessServiceProvidersSearchClassSchema,
    "/market_intelligence/search": ConsolidatedScreeningListSearchClassSchema,
    "/market_research_library/search": ConsolidatedScreeningListSearchClassSchema,
    "/tariff_rates/search": ConsolidatedScreeningListSearchClassSchema,
    "/trade_articles/search": ConsolidatedScreeningListSearchClassSchema,
    "/trade_events/search": ConsolidatedScreeningListSearchClassSchema,
    "/trade_leads/search": ConsolidatedScreeningListSearchClassSchema,
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
