export interface TopLevel {
    booster:            Booster[];
    border:             string;
    cards:              Card[];
    code:               string;
    gathererCode:       string;
    magicCardsInfoCode: string;
    mkm_id:             number;
    mkm_name:           string;
    name:               string;
    releaseDate:        Date;
    type:               string;
}

export type Booster = "rare" | "uncommon" | "common";

export interface Card {
    artist:         string;
    cmc:            number;
    colorIdentity?: ColorIdentity[];
    colors?:        Color[];
    flavor?:        string;
    id:             string;
    imageName:      string;
    layout:         Layout;
    legalities:     LegalityElement[];
    manaCost?:      string;
    mciNumber?:     string;
    multiverseid:   number;
    name:           string;
    originalText?:  string;
    originalType:   string;
    power?:         string;
    printings:      string[];
    rarity:         Rarity;
    reserved?:      boolean;
    rulings?:       Ruling[];
    subtypes?:      string[];
    supertypes?:    Supertype[];
    text?:          string;
    toughness?:     string;
    type:           string;
    types:          Type[];
    variations?:    number[];
}

export type ColorIdentity = "U" | "B" | "W" | "G" | "R";

export type Color = "Blue" | "Black" | "White" | "Green" | "Red";

export type Layout = "normal";

export interface LegalityElement {
    format:   Format;
    legality: LegalityEnum;
}

export type Format = "Commander" | "Legacy" | "Modern" | "Vintage" | "Time Spiral Block" | "Ravnica Block" | "Ice Age Block" | "Tempest Block" | "Onslaught Block" | "Masques Block" | "Mirage Block" | "Urza Block" | "Scars of Mirrodin Block" | "Mirrodin Block" | "Amonkhet Block" | "Battle for Zendikar Block" | "Innistrad Block" | "Invasion Block" | "Kaladesh Block" | "Kamigawa Block" | "Khans of Tarkir Block" | "Lorwyn-Shadowmoor Block" | "Odyssey Block" | "Return to Ravnica Block" | "Shadows over Innistrad Block" | "Shards of Alara Block" | "Standard" | "Theros Block" | "Un-Sets" | "Zendikar Block";

export type LegalityEnum = "Legal" | "Banned" | "Restricted";

export type Rarity = "Uncommon" | "Rare" | "Common" | "Basic Land";

export interface Ruling {
    date: Date;
    text: string;
}

export type Supertype = "Basic";

export type Type = "Creature" | "Instant" | "Enchantment" | "Artifact" | "Sorcery" | "Land";
