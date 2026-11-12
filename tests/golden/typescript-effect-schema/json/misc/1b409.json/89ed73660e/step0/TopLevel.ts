import * as S from "effect/Schema";


export const Party = S.Literal(
    "Republican",
    "Democrat",
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
    "Jr.",
    "II",
    "III",
    "IV",
);
export type Namemod = S.Schema.Type<typeof Namemod>;


export const RoleType = S.Literal(
    "representative",
);
export type RoleType = S.Schema.Type<typeof RoleType>;


export const RoleTypeLabel = S.Literal(
    "Representative",
    "Delegate",
    "Resident Commissioner",
);
export type RoleTypeLabel = S.Schema.Type<typeof RoleTypeLabel>;


export const Title = S.Literal(
    "Rep.",
    "Commish.",
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
    "pvsid": S.NullOr(S.String.pipe(S.pattern(/^-?\d+$/))),
    "sortname": S.String,
    "twitterid": S.NullOr(S.String),
    "youtubeid": S.NullOr(S.String),
}) {}

export class Extra extends S.Class<Extra>("Extra")({
    "address": S.String,
    "contact_form": S.optional(S.String),
    "fax": S.optional(S.NullOr(S.String)),
    "office": S.String,
    "rss_url": S.optional(S.String),
}) {}

export class ObjectElement extends S.Class<ObjectElement>("ObjectElement")({
    "caucus": S.Null,
    "congress_numbers": S.Array(S.Int),
    "current": S.Boolean,
    "description": S.String,
    "district": S.Int,
    "enddate": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "extra": Extra,
    "id": S.Int,
    "leadership_title": S.NullOr(S.String),
    "party": Party,
    "person": Person,
    "phone": S.String,
    "role_type": RoleType,
    "role_type_label": RoleTypeLabel,
    "senator_class": S.Null,
    "senator_rank": S.Null,
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
