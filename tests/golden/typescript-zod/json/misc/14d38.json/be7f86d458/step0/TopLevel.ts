import * as z from "zod";


export const HeadersSchema = z.object({
    "Accept-Encoding": z.string(),
    "Connection": z.string(),
    "Host": z.string(),
    "User-Agent": z.string(),
});
export type Headers = z.infer<typeof HeadersSchema>;

export const TopLevelSchema = z.object({
    "headers": HeadersSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
