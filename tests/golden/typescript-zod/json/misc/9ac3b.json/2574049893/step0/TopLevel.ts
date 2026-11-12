import * as z from "zod";


export const StatusSchema = z.enum([
    "inactive",
    "active",
]);
export type Status = z.infer<typeof StatusSchema>;


export const TitleSchema = z.enum([
    "Mr",
    "Ms",
]);
export type Title = z.infer<typeof TitleSchema>;

export const FacetsSchema = z.object({
});
export type Facets = z.infer<typeof FacetsSchema>;

export const ResultSchema = z.object({
    "created_at": z.string().pipe(z.coerce.date()),
    "entity": z.string(),
    "first_name": z.string(),
    "id": z.string(),
    "last_name": z.string(),
    "name": z.string(),
    "position": z.union([z.null(), z.string()]),
    "status": StatusSchema,
    "title": z.union([z.null(), TitleSchema]),
    "updated_at": z.string().pipe(z.coerce.date()),
    "uri": z.string(),
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
