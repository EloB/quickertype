export interface TopLevel {
    basePath:    string;
    definitions: Definitions;
    host:        string;
    info:        Info;
    paths:       Paths;
    produces:    string[];
    schemes:     string[];
    swagger:     string;
}

export interface Definitions {
    Article:            Article;
    Center:             Article;
    DeMinimis:          DeMinimis;
    Event:              Article;
    FAQ:                FAQ;
    Lead:               Article;
    List:               Article;
    MarketIntelligence: Article;
    Office:             Article;
    Provider:           Article;
    Rate:               Article;
    Report:             Report;
    Taxonomy:           Taxonomy;
}

export interface Article {
    properties: { [key: string]: Property };
}

export interface Property {
    description: string;
    type:        FormatEnum;
}

export type FormatEnum = "string";

export interface DeMinimis {
    properties: DeMinimisProperties;
}

export interface DeMinimisProperties {
    countries:           Property;
    country:             Property;
    de_minimis_currency: Property;
    de_minimis_value:    Property;
    notes:               Property;
    vat_amount:          Property;
    vat_currency:        Property;
}

export interface FAQ {
    properties: FAQProperties;
}

export interface FAQProperties {
    answer:               Property;
    countries:            Property;
    first_published_date: Property;
    id:                   Property;
    industries:           Property;
    last_published_date:  Property;
    question:             Property;
    topics:               Property;
    trade_regions:        Property;
    url:                  Property;
    world_regions:        Property;
}

export interface Report {
    properties: ReportProperties;
}

export interface ReportProperties {
    countries:       Property;
    description:     Property;
    expiration_date: Property;
    id:              Property;
    industries:      Property;
    ita_industries:  Property;
    report_type:     Property;
    title:           Property;
    url:             Property;
}

export interface Taxonomy {
    properties: TaxonomyProperties;
}

export interface TaxonomyProperties {
    annotations:         Property;
    datatype_properties: Property;
    id:                  Property;
    label:               Property;
    sub_class_of:        Property;
    type:                Property;
}

export interface Info {
    description: string;
    title:       string;
    version:     string;
}

export interface Paths {
    "/business_service_providers/search":  BusinessServiceProvidersSearchClass;
    "/consolidated_screening_list/search": ConsolidatedScreeningListSearchClass;
    "/de_minimis/search":                  ConsolidatedScreeningListSearchClass;
    "/ita_faqs/search":                    ConsolidatedScreeningListSearchClass;
    "/ita_office_locations/search":        ConsolidatedScreeningListSearchClass;
    "/ita_taxonomies/search":              BusinessServiceProvidersSearchClass;
    "/ita_zipcode_to_post/search":         BusinessServiceProvidersSearchClass;
    "/market_intelligence/search":         ConsolidatedScreeningListSearchClass;
    "/market_research_library/search":     ConsolidatedScreeningListSearchClass;
    "/tariff_rates/search":                ConsolidatedScreeningListSearchClass;
    "/trade_articles/search":              ConsolidatedScreeningListSearchClass;
    "/trade_events/search":                ConsolidatedScreeningListSearchClass;
    "/trade_leads/search":                 ConsolidatedScreeningListSearchClass;
}

export interface BusinessServiceProvidersSearchClass {
    get: BusinessServiceProvidersSearchGet;
}

export interface BusinessServiceProvidersSearchGet {
    description: string;
    parameters:  Parameter[];
    responses:   PurpleResponses;
    summary:     string;
    tags:        string[];
}

export interface Parameter {
    description: string;
    format:      FormatEnum;
    in:          In;
    name:        string;
    required:    boolean;
    type:        FormatEnum;
}

export type In = "query";

export interface PurpleResponses {
    "200": Purple200;
}

export interface Purple200 {
    description: string;
    schema:      ItemsClass;
}

export interface ItemsClass {
    $ref: string;
}

export interface ConsolidatedScreeningListSearchClass {
    get: ConsolidatedScreeningListSearchGet;
}

export interface ConsolidatedScreeningListSearchGet {
    description: string;
    parameters:  Parameter[];
    responses:   FluffyResponses;
    summary:     string;
    tags:        string[];
}

export interface FluffyResponses {
    "200": Fluffy200;
}

export interface Fluffy200 {
    description: string;
    schema:      PurpleSchema;
}

export interface PurpleSchema {
    items: ItemsClass;
    type:  SchemaType;
}

export type SchemaType = "array";
