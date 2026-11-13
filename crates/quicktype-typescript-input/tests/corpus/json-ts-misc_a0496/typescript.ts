export interface TopLevel {
    code:         string;
    column_names: string[];
    data:         Array<Array<Date | number | null>>;
    description:  string;
    display_url:  string;
    errors:       object;
    frequency:    string;
    from_date:    Date;
    id:           number;
    name:         string;
    premium:      boolean;
    source_code:  string;
    source_name:  string;
    to_date:      Date;
    type:         string;
    updated_at:   Date;
    urlize_name:  string;
}
