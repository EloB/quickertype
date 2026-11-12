import * as z from "zod";


export const CookiesSchema = z.object({
});
export type Cookies = z.infer<typeof CookiesSchema>;

export const TopLevelSchema = z.object({
    "cookies": CookiesSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
