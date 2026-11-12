import * as z from "zod";


export const StatusSchema = z.enum([
    "active",
    "inactive",
]);
export type Status = z.infer<typeof StatusSchema>;

export const FacetsSchema = z.object({
});
export type Facets = z.infer<typeof FacetsSchema>;

export const ResultSchema = z.object({
    "acronym": z.union([z.null(), z.string()]),
    "activity_consult_committees": z.string(),
    "activity_eu_legislative": z.string(),
    "activity_expert_groups": z.string(),
    "activity_high_level_groups": z.string(),
    "activity_industry_forums": z.string(),
    "activity_inter_groups": z.string(),
    "activity_other": z.union([z.null(), z.string()]),
    "activity_relevant_comm": z.string(),
    "be_office_country": z.string().optional(),
    "be_office_lat": z.union([z.null(), z.number()]).optional(),
    "be_office_lon": z.union([z.null(), z.number()]).optional(),
    "be_office_phone": z.string().optional(),
    "be_office_post_code": z.union([z.null(), z.string().regex(/^-?\d+$/)]).optional(),
    "be_office_postbox": z.union([z.null(), z.string().regex(/^-?\d+$/)]).optional(),
    "be_office_street": z.string().optional(),
    "be_office_town": z.string().optional(),
    "code_of_conduct": z.string(),
    "contact_country": z.number().int(),
    "created_at": z.string().pipe(z.coerce.date()),
    "entity": z.string(),
    "goals": z.string(),
    "head": z.string(),
    "head_office_country": z.string(),
    "head_office_lat": z.union([z.null(), z.number()]),
    "head_office_lon": z.union([z.null(), z.number()]),
    "head_office_phone": z.string(),
    "head_office_post_code": z.union([z.null(), z.string()]),
    "head_office_postbox": z.union([z.null(), z.string()]),
    "head_office_street": z.string(),
    "head_office_town": z.string(),
    "id": z.string(),
    "identification_code": z.string(),
    "info_members": z.string(),
    "last_update_date": z.string().pipe(z.coerce.date()),
    "legal": z.string(),
    "legal_status": z.string(),
    "main_category": z.number().int(),
    "main_category_title": z.string(),
    "members": z.number().int(),
    "members_100": z.union([z.null(), z.number().int()]),
    "members_25": z.union([z.null(), z.number().int()]),
    "members_50": z.union([z.null(), z.number().int()]),
    "members_75": z.union([z.null(), z.number().int()]),
    "members_fte": z.number(),
    "name": z.string(),
    "native_name": z.null(),
    "networking": z.union([z.null(), z.string()]),
    "number_of_natural_persons": z.union([z.null(), z.number().int()]),
    "other_code_of_conduct": z.union([z.null(), z.string()]),
    "registration_date": z.string().pipe(z.coerce.date()),
    "status": StatusSchema,
    "structure_members": z.string(),
    "sub_category": z.number().int(),
    "sub_category_title": z.string(),
    "updated_at": z.string().pipe(z.coerce.date()),
    "uri": z.string(),
    "web_site_url": z.union([z.null(), z.string()]),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "count": z.number().int(),
    "facets": FacetsSchema,
    "limit": z.number().int(),
    "next": z.string(),
    "offset": z.number().int(),
    "previous": z.boolean(),
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
