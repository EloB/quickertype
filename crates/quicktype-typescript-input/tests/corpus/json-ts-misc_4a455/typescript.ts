export interface TopLevel {
    crs:           CRS;
    features:      Feature[];
    totalFeatures: number;
    type:          string;
}

export interface CRS {
    properties: CRSProperties;
    type:       string;
}

export interface CRSProperties {
    name: string;
}

export interface Feature {
    geometry:      Geometry;
    geometry_name: GeometryName;
    id:            string;
    properties:    FeatureProperties;
    type:          FeatureType;
}

export interface Geometry {
    coordinates: Array<number[]>;
    type:        GeometryType;
}

export type GeometryType = "MultiPoint";

export type GeometryName = "geom";

export interface FeatureProperties {
    facebookaccount:    string;
    frequencyfinderurl: string;
    name:               string;
    siteurl:            string;
    streetaddress:      string;
    twitteraccount:     string;
}

export type FeatureType = "Feature";
