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
    Report: Report;
}

export interface Report {
    properties: Properties;
}

export interface Properties {
    click_url:       ClickURL;
    country:         ClickURL;
    description:     ClickURL;
    expiration_date: ClickURL;
    id:              ClickURL;
    industry:        ClickURL;
    report_type:     ClickURL;
    source_industry: ClickURL;
    title:           ClickURL;
    url:             ClickURL;
}

export interface ClickURL {
    description: string;
    type:        Type;
}

export type Type = "string";

export interface Info {
    description: string;
    title:       string;
    version:     string;
}

export interface Paths {
    "/market_research_library/search": MarketResearchLibrarySearch;
}

export interface MarketResearchLibrarySearch {
    get: Get;
}

export interface Get {
    description: string;
    parameters:  Parameter[];
    responses:   Responses;
    summary:     string;
    tags:        string[];
}

export interface Parameter {
    description: string;
    format:      Type;
    in:          string;
    name:        string;
    required:    boolean;
    type:        Type;
}

export interface Responses {
    "200": The200;
}

export interface The200 {
    description: string;
    schema:      Schema;
}

export interface Schema {
    items: Items;
    type:  string;
}

export interface Items {
    $ref: string;
}
