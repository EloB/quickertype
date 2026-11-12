import * as z from "zod";


export const AddressSchema = z.object({
    "city": z.string(),
    "country": z.string(),
    "street": z.string(),
});
export type Address = z.infer<typeof AddressSchema>;

export const ItemSchema = z.object({
    "address": AddressSchema.optional(),
    "created_at": z.string().pipe(z.coerce.date()).optional(),
    "name": z.string(),
    "sex": z.union([z.null(), z.number().int()]),
});
export type Item = z.infer<typeof ItemSchema>;

export const TopLevelSchema = z.object({
    "item": z.array(ItemSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
