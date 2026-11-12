import * as z from "zod";


export const TopLevelSchema = z.object({
    "anEasyOne": z.number().int(),
    "isMNISTLetter": z.boolean(),
    "JSONString": z.string(),
    "PrettyEasyToo": z.boolean(),
    "should_know_that_id_is_an_initialism": z.string(),
    "   spaces are separators  too  ": z.boolean(),
    "ZSR_HH_DEMO3_DELMATNR": z.boolean(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
