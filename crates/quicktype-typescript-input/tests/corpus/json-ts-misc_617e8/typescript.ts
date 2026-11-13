export interface TopLevel {
    data: Array<Array<number | null | string>>;
    meta: Meta;
}

export interface Meta {
    view: View;
}

export interface View {
    attribution:              string;
    attributionLink:          string;
    averageRating:            number;
    category:                 string;
    columns:                  Column[];
    createdAt:                number;
    description:              string;
    displayType:              string;
    downloadCount:            number;
    flags:                    string[];
    grants:                   Grant[];
    hideFromCatalog:          boolean;
    hideFromDataJson:         boolean;
    id:                       string;
    indexUpdatedAt:           number;
    locale:                   string;
    metadata:                 Metadata;
    name:                     string;
    newBackend:               boolean;
    numberOfComments:         number;
    oid:                      number;
    owner:                    Owner;
    provenance:               string;
    publicationAppendEnabled: boolean;
    publicationDate:          number;
    publicationGroup:         number;
    publicationStage:         string;
    query:                    Query;
    rights:                   string[];
    rowsUpdatedAt:            number;
    rowsUpdatedBy:            string;
    tableAuthor:              Owner;
    tableId:                  number;
    tags:                     string[];
    totalTimesRated:          number;
    viewCount:                number;
    viewLastModified:         number;
    viewType:                 string;
}

export interface Column {
    cachedContents?: CachedContents;
    dataTypeName:    TypeName;
    description?:    string;
    fieldName:       string;
    flags?:          string[];
    format:          Format;
    id:              number;
    name:            string;
    position:        number;
    renderTypeName:  TypeName;
    tableColumnId?:  number;
    width?:          number;
}

export interface CachedContents {
    largest:  string;
    non_null: number;
    null:     number;
    smallest: string;
    top:      Top[];
}

export interface Top {
    count: number;
    item:  string;
}

export type TypeName = "meta_data" | "calendar_date" | "text";

export interface Format {
    align?: string;
    view?:  string;
}

export interface Grant {
    flags:     string[];
    inherited: boolean;
    type:      string;
}

export interface Metadata {
    attachments:           Attachment[];
    availableDisplayTypes: string[];
    custom_fields:         CustomFields;
    jsonQuery:             JSONQuery;
    rdfSubject:            string;
    renderTypeConfig:      RenderTypeConfig;
}

export interface Attachment {
    assetId:  string;
    blobId:   string;
    filename: string;
    name:     string;
}

export interface CustomFields {
    "Additional Resources": AdditionalResources;
    "Common Core":          CommonCore;
    "Dataset Information":  DatasetInformation;
    "Dataset Summary":      DatasetSummary;
    Notes:                  Notes;
}

export interface AdditionalResources {
    "See Also": string;
}

export interface CommonCore {
    "Contact Email": string;
    "Contact Name":  string;
    Publisher:       string;
}

export interface DatasetInformation {
    Agency: string;
}

export interface DatasetSummary {
    "Contact Information": string;
    Coverage:              string;
    "Data Frequency":      string;
    "Dataset Owner":       string;
    Granularity:           string;
    Organization:          string;
    "Posting Frequency":   string;
    "Time Period":         string;
}

export interface Notes {
    Notes: string;
}

export interface JSONQuery {
    order: Order[];
}

export interface Order {
    ascending:       boolean;
    columnFieldName: string;
}

export interface RenderTypeConfig {
    visible: Visible;
}

export interface Visible {
    table: boolean;
}

export interface Owner {
    displayName:           string;
    id:                    string;
    profileImageUrlLarge:  string;
    profileImageUrlMedium: string;
    profileImageUrlSmall:  string;
    rights:                string[];
    roleName:              string;
    screenName:            string;
}

export interface Query {
    orderBys: OrderBy[];
}

export interface OrderBy {
    ascending:  boolean;
    expression: Expression;
}

export interface Expression {
    columnId: number;
    type:     string;
}
