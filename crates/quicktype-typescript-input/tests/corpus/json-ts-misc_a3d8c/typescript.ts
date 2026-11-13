export interface TopLevel {
    data: Array<Array<number | null | string>>;
    meta: Meta;
}

export interface Meta {
    view: View;
}

export interface View {
    averageRating:            number;
    category:                 string;
    columns:                  Column[];
    createdAt:                number;
    displayType:              string;
    downloadCount:            number;
    flags:                    string[];
    grants:                   Grant[];
    hideFromCatalog:          boolean;
    hideFromDataJson:         boolean;
    id:                       string;
    indexUpdatedAt:           number;
    license:                  License;
    licenseId:                string;
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
    query:                    object;
    rights:                   string[];
    rowClass:                 string;
    rowsUpdatedAt:            number;
    rowsUpdatedBy:            string;
    tableAuthor:              Owner;
    tableId:                  number;
    totalTimesRated:          number;
    viewCount:                number;
    viewLastModified:         number;
    viewType:                 string;
}

export interface Column {
    cachedContents?: CachedContents;
    dataTypeName:    TypeName;
    fieldName:       string;
    flags?:          string[];
    format:          object;
    id:              number;
    name:            string;
    position:        number;
    renderTypeName:  TypeName;
    tableColumnId?:  number;
    width?:          number;
}

export interface CachedContents {
    average?: string;
    largest:  string;
    non_null: number;
    null:     number;
    smallest: string;
    sum?:     string;
    top:      Top[];
}

export interface Top {
    count: number;
    item:  string;
}

export type TypeName = "meta_data" | "number" | "text";

export interface Grant {
    flags:     string[];
    inherited: boolean;
    type:      string;
}

export interface License {
    name: string;
}

export interface Metadata {
    availableDisplayTypes: string[];
    rdfClass:              string;
    rdfSubject:            string;
    renderTypeConfig:      RenderTypeConfig;
    rowIdentifier:         string;
}

export interface RenderTypeConfig {
    visible: Visible;
}

export interface Visible {
    table: boolean;
}

export interface Owner {
    displayName: string;
    id:          string;
    screenName:  string;
}
