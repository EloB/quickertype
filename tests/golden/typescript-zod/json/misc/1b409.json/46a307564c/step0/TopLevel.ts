import * as z from "zod";


export const PartySchema = z.enum([
    "Republican",
    "Democrat",
]);
export type Party = z.infer<typeof PartySchema>;


export const GenderSchema = z.enum([
    "male",
    "female",
]);
export type Gender = z.infer<typeof GenderSchema>;


export const GenderLabelSchema = z.enum([
    "Male",
    "Female",
]);
export type GenderLabel = z.infer<typeof GenderLabelSchema>;


export const NamemodSchema = z.enum([
    "",
    "Jr.",
    "II",
    "III",
    "IV",
]);
export type Namemod = z.infer<typeof NamemodSchema>;


export const RoleTypeSchema = z.enum([
    "representative",
]);
export type RoleType = z.infer<typeof RoleTypeSchema>;


export const RoleTypeLabelSchema = z.enum([
    "Representative",
    "Delegate",
    "Resident Commissioner",
]);
export type RoleTypeLabel = z.infer<typeof RoleTypeLabelSchema>;


export const TitleSchema = z.enum([
    "Rep.",
    "Commish.",
]);
export type Title = z.infer<typeof TitleSchema>;

export const MetaSchema = z.object({
    "limit": z.number().int(),
    "offset": z.number().int(),
    "total_count": z.number().int(),
});
export type Meta = z.infer<typeof MetaSchema>;

export const ExtraSchema = z.object({
    "address": z.string(),
    "contact_form": z.string().optional(),
    "fax": z.union([z.null(), z.string()]).optional(),
    "office": z.string(),
    "rss_url": z.string().optional(),
});
export type Extra = z.infer<typeof ExtraSchema>;

export const PersonSchema = z.object({
    "bioguideid": z.string(),
    "birthday": z.string(),
    "cspanid": z.number().int(),
    "firstname": z.string(),
    "gender": GenderSchema,
    "gender_label": GenderLabelSchema,
    "id": z.number().int(),
    "lastname": z.string(),
    "link": z.string(),
    "middlename": z.string(),
    "name": z.string(),
    "namemod": NamemodSchema,
    "nickname": z.string(),
    "osid": z.string(),
    "pvsid": z.union([z.null(), z.string().regex(/^-?\d+$/)]),
    "sortname": z.string(),
    "twitterid": z.union([z.null(), z.string()]),
    "youtubeid": z.union([z.null(), z.string()]),
});
export type Person = z.infer<typeof PersonSchema>;

export const ObjectElementSchema = z.object({
    "caucus": z.null(),
    "congress_numbers": z.array(z.number().int()),
    "current": z.boolean(),
    "description": z.string(),
    "district": z.number().int(),
    "enddate": z.string(),
    "extra": ExtraSchema,
    "id": z.number().int(),
    "leadership_title": z.union([z.null(), z.string()]),
    "party": PartySchema,
    "person": PersonSchema,
    "phone": z.string(),
    "role_type": RoleTypeSchema,
    "role_type_label": RoleTypeLabelSchema,
    "senator_class": z.null(),
    "senator_rank": z.null(),
    "startdate": z.string(),
    "state": z.string(),
    "title": TitleSchema,
    "title_long": RoleTypeLabelSchema,
    "website": z.string(),
});
export type ObjectElement = z.infer<typeof ObjectElementSchema>;

export const TopLevelSchema = z.object({
    "meta": MetaSchema,
    "objects": z.array(ObjectElementSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
