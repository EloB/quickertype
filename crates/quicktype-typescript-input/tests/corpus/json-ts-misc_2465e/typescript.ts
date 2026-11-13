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
    Taxonomy: Taxonomy;
}

export interface Taxonomy {
    properties: Properties;
}

export interface Properties {
    annotations:         Annotations;
    datatype_properties: Annotations;
    id:                  Annotations;
    label:               Annotations;
    sub_class_of:        Annotations;
    type:                Annotations;
}

export interface Annotations {
    description: string;
    type:        string;
}

export interface Info {
    description: string;
    title:       string;
    version:     string;
}

export interface Paths {
    "/ita_taxonomies/search": ItaTaxonomiesSearch;
}

export interface ItaTaxonomiesSearch {
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
    format:      string;
    in:          string;
    name:        string;
    required:    boolean;
    type:        string;
}

export interface Responses {
    "200": The200;
}

export interface The200 {
    description: string;
    schema:      Schema;
}

export interface Schema {
    $ref: string;
}
