import * as z from "zod";


export const BoosterSchema = z.enum([
    "rare",
    "uncommon",
    "common",
]);
export type Booster = z.infer<typeof BoosterSchema>;


export const ColorIdentitySchema = z.enum([
    "U",
    "B",
    "W",
    "G",
    "R",
]);
export type ColorIdentity = z.infer<typeof ColorIdentitySchema>;


export const ColorSchema = z.enum([
    "Blue",
    "Black",
    "White",
    "Green",
    "Red",
]);
export type Color = z.infer<typeof ColorSchema>;


export const LayoutSchema = z.enum([
    "normal",
]);
export type Layout = z.infer<typeof LayoutSchema>;


export const FormatSchema = z.enum([
    "Commander",
    "Legacy",
    "Modern",
    "Vintage",
    "Time Spiral Block",
    "Ravnica Block",
    "Ice Age Block",
    "Tempest Block",
    "Onslaught Block",
    "Masques Block",
    "Mirage Block",
    "Urza Block",
    "Scars of Mirrodin Block",
    "Mirrodin Block",
    "Amonkhet Block",
    "Battle for Zendikar Block",
    "Innistrad Block",
    "Invasion Block",
    "Kaladesh Block",
    "Kamigawa Block",
    "Khans of Tarkir Block",
    "Lorwyn-Shadowmoor Block",
    "Odyssey Block",
    "Return to Ravnica Block",
    "Shadows over Innistrad Block",
    "Shards of Alara Block",
    "Standard",
    "Theros Block",
    "Un-Sets",
    "Zendikar Block",
]);
export type Format = z.infer<typeof FormatSchema>;


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


export const SupertypeSchema = z.enum([
    "Basic",
]);
export type Supertype = z.infer<typeof SupertypeSchema>;


export const TypeSchema = z.enum([
    "Creature",
    "Instant",
    "Enchantment",
    "Artifact",
    "Sorcery",
    "Land",
]);
export type Type = z.infer<typeof TypeSchema>;

export const LegalityElementSchema = z.object({
    "format": FormatSchema,
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
    "colors": z.array(ColorSchema).optional(),
    "flavor": z.string().optional(),
    "id": z.string(),
    "imageName": z.string(),
    "layout": LayoutSchema,
    "legalities": z.array(LegalityElementSchema),
    "manaCost": z.string().optional(),
    "mciNumber": z.string().regex(/^-?\d+$/).optional(),
    "multiverseid": z.number().int(),
    "name": z.string(),
    "originalText": z.string().optional(),
    "originalType": z.string(),
    "power": z.string().optional(),
    "printings": z.array(z.string()),
    "rarity": RaritySchema,
    "reserved": z.boolean().optional(),
    "rulings": z.array(RulingSchema).optional(),
    "subtypes": z.array(z.string()).optional(),
    "supertypes": z.array(SupertypeSchema).optional(),
    "text": z.string().optional(),
    "toughness": z.string().optional(),
    "type": z.string(),
    "types": z.array(TypeSchema),
    "variations": z.array(z.number().int()).optional(),
});
export type Card = z.infer<typeof CardSchema>;

export const TopLevelSchema = z.object({
    "booster": z.array(BoosterSchema),
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
