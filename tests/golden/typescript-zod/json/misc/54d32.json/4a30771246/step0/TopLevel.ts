import * as z from "zod";


export const StatusSchema = z.enum([
    "inactive",
    "active",
]);
export type Status = z.infer<typeof StatusSchema>;

export const FacetsSchema = z.object({
});
export type Facets = z.infer<typeof FacetsSchema>;

export const ResultSchema = z.object({
    "created_at": z.string().pipe(z.coerce.date()),
    "id": z.string(),
    "person_id": z.string(),
    "representative_id": z.string(),
    "status": StatusSchema,
    "updated_at": z.string().pipe(z.coerce.date()),
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
