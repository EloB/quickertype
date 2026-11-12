import * as z from "zod";


export const FacetsSchema = z.object({
});
export type Facets = z.infer<typeof FacetsSchema>;

export const ResultSchema = z.object({
    "created_at": z.string().pipe(z.coerce.date()),
    "id": z.number().int(),
    "items": z.number().int(),
    "name": z.string(),
    "parent": z.union([z.null(), z.number().int()]),
    "updated_at": z.string().pipe(z.coerce.date()),
    "uri": z.string(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "count": z.number().int(),
    "facets": FacetsSchema,
    "limit": z.number().int(),
    "next": z.boolean(),
    "offset": z.number().int(),
    "previous": z.boolean(),
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
