export interface TopLevel {
    metadata: Metadata;
    results:  Result[];
}

export interface Metadata {
    executionTime: number;
    responseInfo:  ResponseInfo;
    resultset:     Resultset;
}

export interface ResponseInfo {
    developerMessage: string;
    status:           number;
}

export interface Resultset {
    count:    number;
    page:     number;
    pagesize: number;
}

export interface Result {
    about_office:        string;
    application_process: string;
    body:                string;
    changed:             string;
    created:             string;
    deadline:            null;
    hiring_office:       null;
    hiring_org:          HiringOrg;
    job_id:              null;
    language:            string;
    location:            Location;
    num_positions:       string;
    position:            string;
    practice_area:       string;
    qualifications:      string;
    relocation_expenses: null;
    salary:              string;
    title:               string;
    travel:              string;
    url:                 string;
    uuid:                string;
    vuuid:               string;
}

export interface HiringOrg {
    name: string;
    uuid: string;
}

export interface Location {
    administrative_area:    string;
    country:                string;
    fax_number:             string;
    locality:               string;
    mobile_number:          string;
    phone_number:           string;
    phone_number_extension: string;
    postal_code:            string;
    sub_premise:            null;
    thoroughfare:           string;
}
