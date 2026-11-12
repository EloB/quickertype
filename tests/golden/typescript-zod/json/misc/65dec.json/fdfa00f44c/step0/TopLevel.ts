import * as z from "zod";


export const ColorIdentitySchema = z.enum([
    "W",
    "R",
    "B",
    "G",
    "U",
]);
export type ColorIdentity = z.infer<typeof ColorIdentitySchema>;


export const WatermarkSchema = z.enum([
    "White",
    "Red",
    "Black",
    "Green",
    "Blue",
]);
export type Watermark = z.infer<typeof WatermarkSchema>;


export const LayoutSchema = z.enum([
    "normal",
]);
export type Layout = z.infer<typeof LayoutSchema>;


export const LegalityEnumSchema = z.enum([
    "Legal",
    "Banned",
    "Restricted",
]);
export type LegalityEnum = z.infer<typeof LegalityEnumSchema>;


export const RaritySchema = z.enum([
    "Uncommon",
    "Rare",
    "Common",
    "Basic Land",
]);
export type Rarity = z.infer<typeof RaritySchema>;


export const TypeSchema = z.enum([
    "Creature",
    "Artifact",
    "Instant",
    "Land",
    "Enchantment",
    "Sorcery",
]);
export type Type = z.infer<typeof TypeSchema>;

export const LegalityElementSchema = z.object({
    "format": z.string(),
    "legality": LegalityEnumSchema,
});
export type LegalityElement = z.infer<typeof LegalityElementSchema>;

export const RulingSchema = z.object({
    "date": z.string(),
    "text": z.string(),
});
export type Ruling = z.infer<typeof RulingSchema>;

export const CardSchema = z.object({
    "artist": z.string(),
    "cmc": z.number().int(),
    "colorIdentity": z.array(ColorIdentitySchema).optional(),
    "colors": z.array(WatermarkSchema).optional(),
    "flavor": z.string().optional(),
    "id": z.string(),
    "imageName": z.string(),
    "layout": LayoutSchema,
    "legalities": z.array(LegalityElementSchema),
    "manaCost": z.string().optional(),
    "mciNumber": z.string().regex(/^-?\d+$/).optional(),
    "multiverseid": z.number().int(),
    "name": z.string(),
    "originalText": z.string(),
    "originalType": z.string(),
    "power": z.string().regex(/^-?\d+$/).optional(),
    "printings": z.array(z.string()),
    "rarity": RaritySchema,
    "reserved": z.boolean().optional(),
    "rulings": z.array(RulingSchema).optional(),
    "subtypes": z.array(z.string()).optional(),
    "supertypes": z.array(z.string()).optional(),
    "text": z.string().optional(),
    "toughness": z.string().regex(/^-?\d+$/).optional(),
    "type": z.string(),
    "types": z.array(TypeSchema),
    "variations": z.array(z.number().int()).optional(),
    "watermark": WatermarkSchema.optional(),
});
export type Card = z.infer<typeof CardSchema>;

export const TopLevelSchema = z.object({
    "booster": z.array(z.string()),
    "border": z.string(),
    "cards": z.array(CardSchema),
    "code": z.string(),
    "gathererCode": z.string(),
    "magicCardsInfoCode": z.string(),
    "mkm_id": z.number().int(),
    "mkm_name": z.string(),
    "name": z.string(),
    "releaseDate": z.string(),
    "type": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
