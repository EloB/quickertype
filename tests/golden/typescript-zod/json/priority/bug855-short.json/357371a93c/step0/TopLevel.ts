import * as z from "zod";


export const TopLevelValueSchema = z.object({
    "channel_id": z.string().regex(/^-?\d+$/),
    "channel_name": z.string(),
    "code": z.string(),
    "emoticon_set": z.number().int(),
    "id": z.number().int(),
});
export type TopLevelValue = z.infer<typeof TopLevelValueSchema>;

export const TopLevelSchema = z.record(z.string(), TopLevelValueSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
