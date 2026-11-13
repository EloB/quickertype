export interface TopLevel {
    meta:    Meta;
    objects: Object[];
}

export interface Meta {
    limit:       number;
    offset:      number;
    total_count: number;
}

export interface Object {
    caucus:           null;
    congress_numbers: number[];
    current:          boolean;
    description:      string;
    district:         number;
    enddate:          Date;
    extra:            Extra;
    id:               number;
    leadership_title: null | string;
    party:            Party;
    person:           Person;
    phone:            string;
    role_type:        RoleType;
    role_type_label:  RoleTypeLabel;
    senator_class:    null;
    senator_rank:     null;
    startdate:        Date;
    state:            string;
    title:            Title;
    title_long:       RoleTypeLabel;
    website:          string;
}

export interface Extra {
    address:       string;
    contact_form?: string;
    fax?:          null | string;
    office:        string;
    rss_url?:      string;
}

export type Party = "Republican" | "Democrat";

export interface Person {
    bioguideid:   string;
    birthday:     Date;
    cspanid:      number;
    firstname:    string;
    gender:       Gender;
    gender_label: GenderLabel;
    id:           number;
    lastname:     string;
    link:         string;
    middlename:   string;
    name:         string;
    namemod:      Namemod;
    nickname:     string;
    osid:         string;
    pvsid:        null | string;
    sortname:     string;
    twitterid:    null | string;
    youtubeid:    null | string;
}

export type Gender = "male" | "female";

export type GenderLabel = "Male" | "Female";

export type Namemod = "" | "Jr." | "II" | "III" | "IV";

export type RoleType = "representative";

export type RoleTypeLabel = "Representative" | "Delegate" | "Resident Commissioner";

export type Title = "Rep." | "Commish.";
