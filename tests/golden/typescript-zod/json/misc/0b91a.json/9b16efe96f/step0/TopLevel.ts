import * as z from "zod";


export const ResponseInfoSchema = z.object({
    "developerMessage": z.string(),
    "status": z.number().int(),
});
export type ResponseInfo = z.infer<typeof ResponseInfoSchema>;

export const ResultsetSchema = z.object({
    "count": z.number().int(),
    "page": z.number().int(),
    "pagesize": z.number().int(),
});
export type Resultset = z.infer<typeof ResultsetSchema>;

export const ComponentSchema = z.object({
    "name": z.string(),
    "uuid": z.string().uuid(),
});
export type Component = z.infer<typeof ComponentSchema>;

export const MetadataSchema = z.object({
    "executionTime": z.number(),
    "responseInfo": ResponseInfoSchema,
    "resultset": ResultsetSchema,
});
export type Metadata = z.infer<typeof MetadataSchema>;

export const ResultSchema = z.object({
    "attachment": z.array(z.any()),
    "body": z.string(),
    "changed": z.string().regex(/^-?\d+$/),
    "component": z.array(ComponentSchema),
    "created": z.string().regex(/^-?\d+$/),
    "date": z.string().regex(/^-?\d+$/),
    "image": z.array(z.any()),
    "number": z.null(),
    "teaser": z.null(),
    "title": z.string(),
    "topic": z.array(z.any()),
    "url": z.string(),
    "uuid": z.string().uuid(),
    "vuuid": z.string().uuid(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "metadata": MetadataSchema,
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
