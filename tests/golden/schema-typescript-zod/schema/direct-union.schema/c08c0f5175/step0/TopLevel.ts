import * as z from "zod";


export const ArrayNodeSchema = z.object({
});
export type ArrayNode = z.infer<typeof ArrayNodeSchema>;

export const BooleanNodeSchema = z.object({
});
export type BooleanNode = z.infer<typeof BooleanNodeSchema>;

export const DoubleNodeSchema = z.object({
});
export type DoubleNode = z.infer<typeof DoubleNodeSchema>;

export const IntNodeSchema = z.object({
});
export type IntNode = z.infer<typeof IntNodeSchema>;

export const LongNodeSchema = z.object({
});
export type LongNode = z.infer<typeof LongNodeSchema>;

export const NullNodeSchema = z.object({
});
export type NullNode = z.infer<typeof NullNodeSchema>;

export const ObjectNodeSchema = z.object({
});
export type ObjectNode = z.infer<typeof ObjectNodeSchema>;

export const ThingSchema = z.object({
    "optional": z.union([z.null(), z.array(z.any()), z.boolean(), z.number(), z.number().int(), z.record(z.string(), z.any()), z.string()]).optional(),
    "required": z.union([z.null(), z.array(z.any()), z.boolean(), z.number(), z.number().int(), z.record(z.string(), z.any()), z.string()]),
});
export type Thing = z.infer<typeof ThingSchema>;

export const TextNodeSchema = z.object({
});
export type TextNode = z.infer<typeof TextNodeSchema>;

export const TopLevelSchema = z.object({
    "arrayNode": ArrayNodeSchema.optional(),
    "booleanNode": BooleanNodeSchema.optional(),
    "doubleNode": DoubleNodeSchema.optional(),
    "intNode": IntNodeSchema.optional(),
    "longNode": LongNodeSchema.optional(),
    "nullNode": NullNodeSchema.optional(),
    "objectNode": ObjectNodeSchema.optional(),
    "stuff": z.record(z.string(), ThingSchema),
    "textNode": TextNodeSchema.optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
