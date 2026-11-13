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
    Rate: Rate;
}

export interface Rate {
    properties: { [key: string]: Property };
}

export interface Property {
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
    "/tariff_rates/search": TariffRatesSearch;
}

export interface TariffRatesSearch {
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
