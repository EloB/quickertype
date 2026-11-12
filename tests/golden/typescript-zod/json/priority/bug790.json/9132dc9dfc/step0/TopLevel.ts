import * as z from "zod";


export type TopLevel = {
    "children_data": Array<TopLevel>;
    "id": number;
    "is_active": boolean;
    "level": number;
    "name": string;
    "parent_id": number;
    "position": number;
    "product_count": number;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "children_data": z.array(TopLevelSchema),
        "id": z.number().int(),
        "is_active": z.boolean(),
        "level": z.number().int(),
        "name": z.string(),
        "parent_id": z.number().int(),
        "position": z.number().int(),
        "product_count": z.number().int(),
    })
);
