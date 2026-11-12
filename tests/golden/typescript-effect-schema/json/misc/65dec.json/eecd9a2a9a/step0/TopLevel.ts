import * as S from "effect/Schema";


export const ColorIdentity = S.Literal(
    "W",
    "R",
    "B",
    "G",
    "U",
);
export type ColorIdentity = S.Schema.Type<typeof ColorIdentity>;


export const Watermark = S.Literal(
    "White",
    "Red",
    "Black",
    "Green",
    "Blue",
);
export type Watermark = S.Schema.Type<typeof Watermark>;


export const Layout = S.Literal(
    "normal",
);
export type Layout = S.Schema.Type<typeof Layout>;


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


export const Type = S.Literal(
    "Creature",
    "Artifact",
    "Instant",
    "Land",
    "Enchantment",
    "Sorcery",
);
export type Type = S.Schema.Type<typeof Type>;

export class Ruling extends S.Class<Ruling>("Ruling")({
    "date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "text": S.String,
}) {}

export class LegalityElement extends S.Class<LegalityElement>("LegalityElement")({
    "format": S.String,
    "legality": LegalityEnum,
}) {}

export class Card extends S.Class<Card>("Card")({
    "artist": S.String,
    "cmc": S.Int,
    "colorIdentity": S.optional(S.Array(ColorIdentity)),
    "colors": S.optional(S.Array(Watermark)),
    "flavor": S.optional(S.String),
    "id": S.String,
    "imageName": S.String,
    "layout": Layout,
    "legalities": S.Array(LegalityElement),
    "manaCost": S.optional(S.String),
    "mciNumber": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "multiverseid": S.Int,
    "name": S.String,
    "originalText": S.String,
    "originalType": S.String,
    "power": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "printings": S.Array(S.String),
    "rarity": Rarity,
    "reserved": S.optional(S.Boolean),
    "rulings": S.optional(S.Array(Ruling)),
    "subtypes": S.optional(S.Array(S.String)),
    "supertypes": S.optional(S.Array(S.String)),
    "text": S.optional(S.String),
    "toughness": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "type": S.String,
    "types": S.Array(Type),
    "variations": S.optional(S.Array(S.Int)),
    "watermark": S.optional(Watermark),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "booster": S.Array(S.String),
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
