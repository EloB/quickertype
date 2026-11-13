export interface TopLevel {
    count:    number;
    facets:   object;
    limit:    number;
    next:     string;
    offset:   number;
    previous: boolean;
    results:  Result[];
}

export interface Result {
    acronym:    null | string;
    created_at: Date;
    id:         string;
    name:       string;
    updated_at: Date;
    uri:        string;
}
