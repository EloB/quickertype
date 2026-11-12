import * as S from "effect/Schema";


export const Booster = S.Literal(
    "rare",
    "uncommon",
    "common",
);
export type Booster = S.Schema.Type<typeof Booster>;


export const ColorIdentity = S.Literal(
    "U",
    "B",
    "W",
    "G",
    "R",
);
export type ColorIdentity = S.Schema.Type<typeof ColorIdentity>;


export const Color = S.Literal(
    "Blue",
    "Black",
    "White",
    "Green",
    "Red",
);
export type Color = S.Schema.Type<typeof Color>;


export const Layout = S.Literal(
    "normal",
);
export type Layout = S.Schema.Type<typeof Layout>;


export const Format = S.Literal(
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
);
export type Format = S.Schema.Type<typeof Format>;


export const LegalityEnum = S.Literal(
    "Legal",
    "Banned",
    "Restricted",
);
export type LegalityEnum = S.Schema.Type<typeof LegalityEnum>;


export const Rarity = S.Literal(
    "Uncommon",
    "Rare",
    "Common",
    "Basic Land",
);
export type Rarity = S.Schema.Type<typeof Rarity>;


export const Supertype = S.Literal(
    "Basic",
);
export type Supertype = S.Schema.Type<typeof Supertype>;


export const Type = S.Literal(
    "Creature",
    "Instant",
    "Enchantment",
    "Artifact",
    "Sorcery",
    "Land",
);
export type Type = S.Schema.Type<typeof Type>;

export class Ruling extends S.Class<Ruling>("Ruling")({
    "date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "text": S.String,
}) {}

export class LegalityElement extends S.Class<LegalityElement>("LegalityElement")({
    "format": Format,
    "legality": LegalityEnum,
}) {}

export class Card extends S.Class<Card>("Card")({
    "artist": S.String,
    "cmc": S.Int,
    "colorIdentity": S.optional(S.Array(ColorIdentity)),
    "colors": S.optional(S.Array(Color)),
    "flavor": S.optional(S.String),
    "id": S.String,
    "imageName": S.String,
    "layout": Layout,
    "legalities": S.Array(LegalityElement),
    "manaCost": S.optional(S.String),
    "mciNumber": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "multiverseid": S.Int,
    "name": S.String,
    "originalText": S.optional(S.String),
    "originalType": S.String,
    "power": S.optional(S.String),
    "printings": S.Array(S.String),
    "rarity": Rarity,
    "reserved": S.optional(S.Boolean),
    "rulings": S.optional(S.Array(Ruling)),
    "subtypes": S.optional(S.Array(S.String)),
    "supertypes": S.optional(S.Array(Supertype)),
    "text": S.optional(S.String),
    "toughness": S.optional(S.String),
    "type": S.String,
    "types": S.Array(Type),
    "variations": S.optional(S.Array(S.Int)),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "booster": S.Array(Booster),
    "border": S.String,
    "cards": S.Array(Card),
    "code": S.String,
    "gathererCode": S.String,
    "magicCardsInfoCode": S.String,
    "mkm_id": S.Int,
    "mkm_name": S.String,
    "name": S.String,
    "releaseDate": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "type": S.String,
}) {}
