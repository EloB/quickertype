import * as z from "zod";


export type UnionListClass = {
    "next": UnionListClass | number;
};
export const UnionListClassSchema: z.ZodType<UnionListClass> = z.lazy(() =>
    z.object({
        "next": z.union([UnionListClassSchema, z.number()]),
    })
);

export const TopLevelSchema = z.object({
    "list": z.union([UnionListClassSchema, z.number()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
