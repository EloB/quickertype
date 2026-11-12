import * as z from "zod";


export const ErrorsSchema = z.object({
});
export type Errors = z.infer<typeof ErrorsSchema>;

export const TopLevelSchema = z.object({
    "code": z.string(),
    "column_names": z.array(z.string()),
    "data": z.array(z.array(z.union([z.null(), z.number(), z.string()]))),
    "description": z.string(),
    "display_url": z.string(),
    "errors": ErrorsSchema,
    "frequency": z.string(),
    "from_date": z.string(),
    "id": z.number().int(),
    "name": z.string(),
    "premium": z.boolean(),
    "source_code": z.string(),
    "source_name": z.string(),
    "to_date": z.string(),
    "type": z.string(),
    "updated_at": z.string().pipe(z.coerce.date()),
    "urlize_name": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
