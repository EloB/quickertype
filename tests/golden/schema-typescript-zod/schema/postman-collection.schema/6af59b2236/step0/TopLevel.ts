import * as z from "zod";


export type TopLevel = {
    "item"?: Array<TopLevel>;
    "name"?: string;
    "response"?: Array<Response>;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "item": z.array(TopLevelSchema).optional(),
        "name": z.string().optional(),
        "response": z.array(ResponseSchema).optional(),
    })
);

export const ResponseSchema = z.object({
    "body": z.string().optional(),
});
export type Response = z.infer<typeof ResponseSchema>;
