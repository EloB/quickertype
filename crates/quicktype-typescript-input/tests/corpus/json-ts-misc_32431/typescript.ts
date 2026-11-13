export interface TopLevel {
    bbox:     number[];
    features: Feature[];
    metadata: Metadata;
    type:     string;
}

export interface Feature {
    geometry:   Geometry;
    id:         string;
    properties: Properties;
    type:       FeatureType;
}

export interface Geometry {
    coordinates: number[];
    type:        GeometryType;
}

export type GeometryType = "Point";

export interface Properties {
    alert:   null;
    cdi:     null;
    code:    string;
    detail:  string;
    dmin:    number | null;
    felt:    null;
    gap:     number | null;
    ids:     string;
    mag:     number;
    magType: MagType;
    mmi:     null;
    net:     string;
    nst:     number | null;
    place:   string;
    rms:     number;
    sig:     number;
    sources: string;
    status:  Status;
    time:    number;
    title:   string;
    tsunami: number;
    type:    PropertiesType;
    types:   string;
    tz:      number;
    updated: number;
    url:     string;
}

export type MagType = "md" | "ml" | "mb";

export type Status = "automatic" | "reviewed";

export type PropertiesType = "earthquake";

export type FeatureType = "Feature";

export interface Metadata {
    api:       string;
    count:     number;
    generated: number;
    status:    number;
    title:     string;
    url:       string;
}
