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
    created_at:        Date;
    id:                string;
    person_id:         string;
    representative_id: string;
    status:            Status;
    updated_at:        Date;
}

export type Status = "inactive" | "active";
