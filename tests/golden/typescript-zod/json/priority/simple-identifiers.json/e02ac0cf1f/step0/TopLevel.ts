import * as z from "zod";


export const TopLevelSchema = z.object({
    "continue": z.string(),
    "": z.string(),
    "null": z.string(),
    "x'": z.string(),
    "{}": z.string(),
    "x\"": z.string(),
    "undefined": z.string(),
    "x": z.string(),
    "x y": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
