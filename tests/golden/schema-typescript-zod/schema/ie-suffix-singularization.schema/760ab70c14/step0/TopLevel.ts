import * as z from "zod";


export const CookieSchema = z.object({
    "name": z.string(),
    "value": z.string(),
});
export type Cookie = z.infer<typeof CookieSchema>;

export const TopLevelSchema = z.object({
    "cookies": z.array(CookieSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
