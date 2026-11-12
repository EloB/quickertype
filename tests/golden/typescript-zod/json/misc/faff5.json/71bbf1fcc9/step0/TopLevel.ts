import * as z from "zod";


export const ResponseSchema = z.object({
    "player_count": z.number().int(),
    "result": z.number().int(),
});
export type Response = z.infer<typeof ResponseSchema>;

export const TopLevelSchema = z.object({
    "response": ResponseSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
