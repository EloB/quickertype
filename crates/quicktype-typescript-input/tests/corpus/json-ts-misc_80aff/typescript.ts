export interface TopLevel {
    count:    number;
    facets:   object;
    limit:    number;
    next:     boolean;
    offset:   number;
    previous: boolean;
    results:  Result[];
}

export interface Result {
    created_at: Date;
    id:         number;
    items:      number;
    name:       string;
    parent:     number | null;
    updated_at: Date;
    uri:        string;
}
