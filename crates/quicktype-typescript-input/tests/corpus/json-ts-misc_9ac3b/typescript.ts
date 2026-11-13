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
    created_at: Date;
    entity:     string;
    first_name: string;
    id:         string;
    last_name:  string;
    name:       string;
    position:   null | string;
    status:     Status;
    title:      Title | null;
    updated_at: Date;
    uri:        string;
}

export type Status = "inactive" | "active";

export type Title = "Mr" | "Ms";
