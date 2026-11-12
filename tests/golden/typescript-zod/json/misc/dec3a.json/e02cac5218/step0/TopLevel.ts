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

export const HiringOrgSchema = z.object({
    "name": z.string(),
    "uuid": z.string().uuid(),
});
export type HiringOrg = z.infer<typeof HiringOrgSchema>;

export const LocationSchema = z.object({
    "administrative_area": z.string(),
    "country": z.string(),
    "fax_number": z.string(),
    "locality": z.string(),
    "mobile_number": z.string(),
    "phone_number": z.string(),
    "phone_number_extension": z.string(),
    "postal_code": z.string().regex(/^-?\d+$/),
    "sub_premise": z.null(),
    "thoroughfare": z.string(),
});
export type Location = z.infer<typeof LocationSchema>;

export const MetadataSchema = z.object({
    "executionTime": z.number(),
    "responseInfo": ResponseInfoSchema,
    "resultset": ResultsetSchema,
});
export type Metadata = z.infer<typeof MetadataSchema>;

export const ResultSchema = z.object({
    "about_office": z.string(),
    "application_process": z.string(),
    "body": z.string(),
    "changed": z.string().regex(/^-?\d+$/),
    "created": z.string().regex(/^-?\d+$/),
    "deadline": z.null(),
    "hiring_office": z.null(),
    "hiring_org": HiringOrgSchema,
    "job_id": z.null(),
    "language": z.string(),
    "location": LocationSchema,
    "num_positions": z.string().regex(/^-?\d+$/),
    "position": z.string(),
    "practice_area": z.string(),
    "qualifications": z.string(),
    "relocation_expenses": z.null(),
    "salary": z.string(),
    "title": z.string(),
    "travel": z.string(),
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
