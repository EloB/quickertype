import * as z from "zod";


export const ArgsSchema = z.object({
});
export type Args = z.infer<typeof ArgsSchema>;

export const HeadersSchema = z.object({
    "Accept-Encoding": z.string(),
    "Connection": z.string(),
    "Host": z.string(),
    "User-Agent": z.string(),
});
export type Headers = z.infer<typeof HeadersSchema>;

export const TopLevelSchema = z.object({
    "args": ArgsSchema,
    "data": z.string(),
    "files": ArgsSchema,
    "form": ArgsSchema,
    "headers": HeadersSchema,
    "origin": z.string(),
    "url": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
