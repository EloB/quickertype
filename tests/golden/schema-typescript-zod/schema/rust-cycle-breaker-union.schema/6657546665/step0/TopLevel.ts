import * as z from "zod";


export type Node = {
    "next"?: Node | null | string;
    "value": string;
};
export const NodeSchema: z.ZodType<Node> = z.lazy(() =>
    z.object({
        "next": z.union([z.null(), NodeSchema, z.string()]).optional(),
        "value": z.string(),
    })
);

export const TopLevelSchema = z.object({
    "next": z.union([z.null(), NodeSchema, z.string()]).optional(),
    "value": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
