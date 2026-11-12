import * as S from "effect/Schema";


export const Party = S.Literal(
    "Republican",
    "Democrat",
    "Independent",
);
export type Party = S.Schema.Type<typeof Party>;


export const Gender = S.Literal(
    "male",
    "female",
);
export type Gender = S.Schema.Type<typeof Gender>;


export const GenderLabel = S.Literal(
    "Male",
    "Female",
);
export type GenderLabel = S.Schema.Type<typeof GenderLabel>;


export const Namemod = S.Literal(
    "",
    "III",
    "Jr.",
);
export type Namemod = S.Schema.Type<typeof Namemod>;


export const RoleType = S.Literal(
    "senator",
);
export type RoleType = S.Schema.Type<typeof RoleType>;


export const RoleTypeLabel = S.Literal(
    "Senator",
);
export type RoleTypeLabel = S.Schema.Type<typeof RoleTypeLabel>;


export const SenatorClass = S.Literal(
    "class2",
    "class1",
    "class3",
);
export type SenatorClass = S.Schema.Type<typeof SenatorClass>;


export const SenatorClassLabel = S.Literal(
    "Class 2",
    "Class 1",
    "Class 3",
);
export type SenatorClassLabel = S.Schema.Type<typeof SenatorClassLabel>;


export const SenatorRank = S.Literal(
    "senior",
    "junior",
);
export type SenatorRank = S.Schema.Type<typeof SenatorRank>;


export const SenatorRankLabel = S.Literal(
    "Senior",
    "Junior",
);
export type SenatorRankLabel = S.Schema.Type<typeof SenatorRankLabel>;


export const Title = S.Literal(
    "Sen.",
);
export type Title = S.Schema.Type<typeof Title>;

export class Person extends S.Class<Person>("Person")({
    "bioguideid": S.String,
    "birthday": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "cspanid": S.Int,
    "firstname": S.String,
    "gender": Gender,
    "gender_label": GenderLabel,
    "id": S.Int,
    "lastname": S.String,
    "link": S.String,
    "middlename": S.String,
    "name": S.String,
    "namemod": Namemod,
    "nickname": S.String,
    "osid": S.String,
    "pvsid": S.String.pipe(S.pattern(/^-?\d+$/)),
    "sortname": S.String,
    "twitterid": S.NullOr(S.String),
    "youtubeid": S.NullOr(S.String),
}) {}

export class Extra extends S.Class<Extra>("Extra")({
    "address": S.String,
    "contact_form": S.String,
    "fax": S.optional(S.String),
    "office": S.String,
    "rss_url": S.optional(S.String),
}) {}

export class ObjectElement extends S.Class<ObjectElement>("ObjectElement")({
    "caucus": S.NullOr(Party),
    "congress_numbers": S.Array(S.Int),
    "current": S.Boolean,
    "description": S.String,
    "district": S.Null,
    "enddate": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "extra": Extra,
    "id": S.Int,
    "leadership_title": S.NullOr(S.String),
    "party": Party,
    "person": Person,
    "phone": S.String,
    "role_type": RoleType,
    "role_type_label": RoleTypeLabel,
    "senator_class": SenatorClass,
    "senator_class_label": SenatorClassLabel,
    "senator_rank": SenatorRank,
    "senator_rank_label": SenatorRankLabel,
    "startdate": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "state": S.String,
    "title": Title,
    "title_long": RoleTypeLabel,
    "website": S.String,
}) {}

export class Meta extends S.Class<Meta>("Meta")({
    "limit": S.Int,
    "offset": S.Int,
    "total_count": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "meta": Meta,
    "objects": S.Array(ObjectElement),
}) {}
