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
    caucus:              Party | null;
    congress_numbers:    number[];
    current:             boolean;
    description:         string;
    district:            null;
    enddate:             Date;
    extra:               Extra;
    id:                  number;
    leadership_title:    null | string;
    party:               Party;
    person:              Person;
    phone:               string;
    role_type:           RoleType;
    role_type_label:     RoleTypeLabel;
    senator_class:       SenatorClass;
    senator_class_label: SenatorClassLabel;
    senator_rank:        SenatorRank;
    senator_rank_label:  SenatorRankLabel;
    startdate:           Date;
    state:               string;
    title:               Title;
    title_long:          RoleTypeLabel;
    website:             string;
}

export type Party = "Republican" | "Democrat" | "Independent";

export interface Extra {
    address:      string;
    contact_form: string;
    fax?:         string;
    office:       string;
    rss_url?:     string;
}

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
    pvsid:        string;
    sortname:     string;
    twitterid:    null | string;
    youtubeid:    null | string;
}

export type Gender = "male" | "female";

export type GenderLabel = "Male" | "Female";

export type Namemod = "" | "III" | "Jr.";

export type RoleType = "senator";

export type RoleTypeLabel = "Senator";

export type SenatorClass = "class2" | "class1" | "class3";

export type SenatorClassLabel = "Class 2" | "Class 1" | "Class 3";

export type SenatorRank = "senior" | "junior";

export type SenatorRankLabel = "Senior" | "Junior";

export type Title = "Sen.";
