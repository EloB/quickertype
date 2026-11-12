import * as z from "zod";


export const PartySchema = z.enum([
    "Democrat",
    "Republican",
    "Independent",
]);
export type Party = z.infer<typeof PartySchema>;


export const GenderSchema = z.enum([
    "female",
    "male",
]);
export type Gender = z.infer<typeof GenderSchema>;


export const GenderLabelSchema = z.enum([
    "Female",
    "Male",
]);
export type GenderLabel = z.infer<typeof GenderLabelSchema>;


export const NamemodSchema = z.enum([
    "",
    "Jr.",
    "III",
]);
export type Namemod = z.infer<typeof NamemodSchema>;


export const RoleTypeSchema = z.enum([
    "senator",
]);
export type RoleType = z.infer<typeof RoleTypeSchema>;


export const RoleTypeLabelSchema = z.enum([
    "Senator",
]);
export type RoleTypeLabel = z.infer<typeof RoleTypeLabelSchema>;


export const SenatorClassSchema = z.enum([
    "class1",
    "class2",
    "class3",
]);
export type SenatorClass = z.infer<typeof SenatorClassSchema>;


export const SenatorClassLabelSchema = z.enum([
    "Class 1",
    "Class 2",
    "Class 3",
]);
export type SenatorClassLabel = z.infer<typeof SenatorClassLabelSchema>;


export const SenatorRankSchema = z.enum([
    "junior",
    "senior",
]);
export type SenatorRank = z.infer<typeof SenatorRankSchema>;


export const SenatorRankLabelSchema = z.enum([
    "Junior",
    "Senior",
]);
export type SenatorRankLabel = z.infer<typeof SenatorRankLabelSchema>;


export const TitleSchema = z.enum([
    "Sen.",
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
    "contact_form": z.string(),
    "fax": z.string().optional(),
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
    "lastname": z.string(),
    "link": z.string(),
    "middlename": z.string(),
    "name": z.string(),
    "namemod": NamemodSchema,
    "nickname": z.string(),
    "osid": z.string(),
    "pvsid": z.string().regex(/^-?\d+$/),
    "sortname": z.string(),
    "twitterid": z.union([z.null(), z.string()]),
    "youtubeid": z.union([z.null(), z.string()]),
});
export type Person = z.infer<typeof PersonSchema>;

export const ObjectElementSchema = z.object({
    "caucus": z.union([z.null(), PartySchema]),
    "congress_numbers": z.array(z.number().int()),
    "current": z.boolean(),
    "description": z.string(),
    "district": z.null(),
    "enddate": z.string(),
    "extra": ExtraSchema,
    "leadership_title": z.union([z.null(), z.string()]),
    "party": PartySchema,
    "person": PersonSchema,
    "phone": z.string(),
    "role_type": RoleTypeSchema,
    "role_type_label": RoleTypeLabelSchema,
    "senator_class": SenatorClassSchema,
    "senator_class_label": SenatorClassLabelSchema,
    "senator_rank": SenatorRankSchema,
    "senator_rank_label": SenatorRankLabelSchema,
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
