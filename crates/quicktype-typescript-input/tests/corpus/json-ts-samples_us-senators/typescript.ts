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

export type Party = "Democrat" | "Republican" | "Independent";

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

export type Gender = "female" | "male";

export type GenderLabel = "Female" | "Male";

export type Namemod = "" | "Jr." | "III";

export type RoleType = "senator";

export type RoleTypeLabel = "Senator";

export type SenatorClass = "class1" | "class2" | "class3";

export type SenatorClassLabel = "Class 1" | "Class 2" | "Class 3";

export type SenatorRank = "junior" | "senior";

export type SenatorRankLabel = "Junior" | "Senior";

export type Title = "Sen.";
