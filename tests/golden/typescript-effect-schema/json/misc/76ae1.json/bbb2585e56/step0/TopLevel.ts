import * as S from "effect/Schema";


export const FormatEnum = S.Literal(
    "string",
);
export type FormatEnum = S.Schema.Type<typeof FormatEnum>;


export const In = S.Literal(
    "query",
);
export type In = S.Schema.Type<typeof In>;


export const SchemaType = S.Literal(
    "array",
);
export type SchemaType = S.Schema.Type<typeof SchemaType>;

export class ItemsClass extends S.Class<ItemsClass>("ItemsClass")({
    "$ref": S.String,
}) {}

export class Purple200 extends S.Class<Purple200>("Purple200")({
    "description": S.String,
    "schema": ItemsClass,
}) {}

export class PurpleResponses extends S.Class<PurpleResponses>("PurpleResponses")({
    "200": Purple200,
}) {}

export class Parameter extends S.Class<Parameter>("Parameter")({
    "description": S.String,
    "format": FormatEnum,
    "in": In,
    "name": S.String,
    "required": S.Boolean,
    "type": FormatEnum,
}) {}

export class BusinessServiceProvidersSearchGet extends S.Class<BusinessServiceProvidersSearchGet>("BusinessServiceProvidersSearchGet")({
    "description": S.String,
    "parameters": S.Array(Parameter),
    "responses": PurpleResponses,
    "summary": S.String,
    "tags": S.Array(S.String),
}) {}

export class BusinessServiceProvidersSearchClass extends S.Class<BusinessServiceProvidersSearchClass>("BusinessServiceProvidersSearchClass")({
    "get": BusinessServiceProvidersSearchGet,
}) {}

export class Paths extends S.Class<Paths>("Paths")({
    "/business_service_providers/search": BusinessServiceProvidersSearchClass,
    "/consolidated_screening_list/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/de_minimis/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/ita_faqs/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/ita_office_locations/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/ita_taxonomies/search": BusinessServiceProvidersSearchClass,
    "/ita_zipcode_to_post/search": BusinessServiceProvidersSearchClass,
    "/market_intelligence/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/market_research_library/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/tariff_rates/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/trade_articles/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/trade_events/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
    "/trade_leads/search": S.suspend(() => ConsolidatedScreeningListSearchClass),
}) {}

export class Info extends S.Class<Info>("Info")({
    "description": S.String,
    "title": S.String,
    "version": S.String,
}) {}

export class Property extends S.Class<Property>("Property")({
    "description": S.String,
    "type": FormatEnum,
}) {}

export class Article extends S.Class<Article>("Article")({
    "properties": S.Record({ key: S.String, value: Property}),
}) {}

export class Definitions extends S.Class<Definitions>("Definitions")({
    "Article": Article,
    "Center": Article,
    "DeMinimis": S.suspend(() => DeMinimis),
    "Event": Article,
    "FAQ": S.suspend(() => Faq),
    "Lead": Article,
    "List": Article,
    "MarketIntelligence": Article,
    "Office": Article,
    "Provider": Article,
    "Rate": Article,
    "Report": S.suspend(() => Report),
    "Taxonomy": S.suspend(() => Taxonomy),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "basePath": S.String,
    "definitions": Definitions,
    "host": S.String,
    "info": Info,
    "paths": Paths,
    "produces": S.Array(S.String),
    "schemes": S.Array(S.String),
    "swagger": S.String,
}) {}

export class TaxonomyProperties extends S.Class<TaxonomyProperties>("TaxonomyProperties")({
    "annotations": Property,
    "datatype_properties": Property,
    "id": Property,
    "label": Property,
    "sub_class_of": Property,
    "type": Property,
}) {}

export class Taxonomy extends S.Class<Taxonomy>("Taxonomy")({
    "properties": TaxonomyProperties,
}) {}

export class ReportProperties extends S.Class<ReportProperties>("ReportProperties")({
    "countries": Property,
    "description": Property,
    "expiration_date": Property,
    "id": Property,
    "industries": Property,
    "ita_industries": Property,
    "report_type": Property,
    "title": Property,
    "url": Property,
}) {}

export class Report extends S.Class<Report>("Report")({
    "properties": ReportProperties,
}) {}

export class FaqProperties extends S.Class<FaqProperties>("FaqProperties")({
    "answer": Property,
    "countries": Property,
    "first_published_date": Property,
    "id": Property,
    "industries": Property,
    "last_published_date": Property,
    "question": Property,
    "topics": Property,
    "trade_regions": Property,
    "url": Property,
    "world_regions": Property,
}) {}

export class Faq extends S.Class<Faq>("Faq")({
    "properties": FaqProperties,
}) {}

export class DeMinimisProperties extends S.Class<DeMinimisProperties>("DeMinimisProperties")({
    "countries": Property,
    "country": Property,
    "de_minimis_currency": Property,
    "de_minimis_value": Property,
    "notes": Property,
    "vat_amount": Property,
    "vat_currency": Property,
}) {}

export class DeMinimis extends S.Class<DeMinimis>("DeMinimis")({
    "properties": DeMinimisProperties,
}) {}

export class PurpleSchema extends S.Class<PurpleSchema>("PurpleSchema")({
    "items": ItemsClass,
    "type": SchemaType,
}) {}

export class Fluffy200 extends S.Class<Fluffy200>("Fluffy200")({
    "description": S.String,
    "schema": PurpleSchema,
}) {}

export class FluffyResponses extends S.Class<FluffyResponses>("FluffyResponses")({
    "200": Fluffy200,
}) {}

export class ConsolidatedScreeningListSearchGet extends S.Class<ConsolidatedScreeningListSearchGet>("ConsolidatedScreeningListSearchGet")({
    "description": S.String,
    "parameters": S.Array(Parameter),
    "responses": FluffyResponses,
    "summary": S.String,
    "tags": S.Array(S.String),
}) {}

export class ConsolidatedScreeningListSearchClass extends S.Class<ConsolidatedScreeningListSearchClass>("ConsolidatedScreeningListSearchClass")({
    "get": ConsolidatedScreeningListSearchGet,
}) {}
