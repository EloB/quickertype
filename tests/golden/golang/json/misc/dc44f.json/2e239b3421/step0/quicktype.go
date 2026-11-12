// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevel struct {
	Booster            []Booster `json:"booster"`
	Border             string    `json:"border"`
	Cards              []Card    `json:"cards"`
	Code               string    `json:"code"`
	GathererCode       string    `json:"gathererCode"`
	MagicCardsInfoCode string    `json:"magicCardsInfoCode"`
	MkmID              int64     `json:"mkm_id"`
	MkmName            string    `json:"mkm_name"`
	Name               string    `json:"name"`
	ReleaseDate        string    `json:"releaseDate"`
	Type               string    `json:"type"`
}

type Card struct {
	Artist        string            `json:"artist"`
	Cmc           int64             `json:"cmc"`
	ColorIdentity *[]ColorIdentity  `json:"colorIdentity,omitempty"`
	Colors        *[]Color          `json:"colors,omitempty"`
	Flavor        *string           `json:"flavor,omitempty"`
	ID            string            `json:"id"`
	ImageName     string            `json:"imageName"`
	Layout        Layout            `json:"layout"`
	Legalities    []LegalityElement `json:"legalities"`
	ManaCost      *string           `json:"manaCost,omitempty"`
	MciNumber     *string           `json:"mciNumber,omitempty"`
	Multiverseid  int64             `json:"multiverseid"`
	Name          string            `json:"name"`
	OriginalText  *string           `json:"originalText,omitempty"`
	OriginalType  string            `json:"originalType"`
	Power         *string           `json:"power,omitempty"`
	Printings     []string          `json:"printings"`
	Rarity        Rarity            `json:"rarity"`
	Reserved      *bool             `json:"reserved,omitempty"`
	Rulings       *[]Ruling         `json:"rulings,omitempty"`
	Subtypes      *[]string         `json:"subtypes,omitempty"`
	Supertypes    *[]Supertype      `json:"supertypes,omitempty"`
	Text          *string           `json:"text,omitempty"`
	Toughness     *string           `json:"toughness,omitempty"`
	Type          string            `json:"type"`
	Types         []Type            `json:"types"`
	Variations    *[]int64          `json:"variations,omitempty"`
}

type LegalityElement struct {
	Format   Format       `json:"format"`
	Legality LegalityEnum `json:"legality"`
}

type Ruling struct {
	Date string `json:"date"`
	Text string `json:"text"`
}

type Booster string

const (
	Rare     Booster = "rare"
	Uncommon Booster = "uncommon"
	Common   Booster = "common"
)

type invalidBooster string
func (x invalidBooster) Error() string { return "invalid Booster: " + string(x) }

func (x *Booster) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Booster(value) {
	case Rare, Uncommon, Common: *x = Booster(value); return nil
	}
	return invalidBooster(value)
}

type ColorIdentity string

const (
	U ColorIdentity = "U"
	B ColorIdentity = "B"
	W ColorIdentity = "W"
	G ColorIdentity = "G"
	R ColorIdentity = "R"
)

type invalidColorIdentity string
func (x invalidColorIdentity) Error() string { return "invalid ColorIdentity: " + string(x) }

func (x *ColorIdentity) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ColorIdentity(value) {
	case U, B, W, G, R: *x = ColorIdentity(value); return nil
	}
	return invalidColorIdentity(value)
}

type Color string

const (
	Blue  Color = "Blue"
	Black Color = "Black"
	White Color = "White"
	Green Color = "Green"
	Red   Color = "Red"
)

type invalidColor string
func (x invalidColor) Error() string { return "invalid Color: " + string(x) }

func (x *Color) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Color(value) {
	case Blue, Black, White, Green, Red: *x = Color(value); return nil
	}
	return invalidColor(value)
}

type Layout string

const (
	Normal Layout = "normal"
)

type invalidLayout string
func (x invalidLayout) Error() string { return "invalid Layout: " + string(x) }

func (x *Layout) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Layout(value) {
	case Normal: *x = Layout(value); return nil
	}
	return invalidLayout(value)
}

type Format string

const (
	Commander                 Format = "Commander"
	Legacy                    Format = "Legacy"
	Modern                    Format = "Modern"
	Vintage                   Format = "Vintage"
	TimeSpiralBlock           Format = "Time Spiral Block"
	RavnicaBlock              Format = "Ravnica Block"
	IceAgeBlock               Format = "Ice Age Block"
	TempestBlock              Format = "Tempest Block"
	OnslaughtBlock            Format = "Onslaught Block"
	MasquesBlock              Format = "Masques Block"
	MirageBlock               Format = "Mirage Block"
	UrzaBlock                 Format = "Urza Block"
	ScarsOfMirrodinBlock      Format = "Scars of Mirrodin Block"
	MirrodinBlock             Format = "Mirrodin Block"
	AmonkhetBlock             Format = "Amonkhet Block"
	BattleForZendikarBlock    Format = "Battle for Zendikar Block"
	InnistradBlock            Format = "Innistrad Block"
	InvasionBlock             Format = "Invasion Block"
	KaladeshBlock             Format = "Kaladesh Block"
	KamigawaBlock             Format = "Kamigawa Block"
	KhansOfTarkirBlock        Format = "Khans of Tarkir Block"
	LorwynShadowmoorBlock     Format = "Lorwyn-Shadowmoor Block"
	OdysseyBlock              Format = "Odyssey Block"
	ReturnToRavnicaBlock      Format = "Return to Ravnica Block"
	ShadowsOverInnistradBlock Format = "Shadows over Innistrad Block"
	ShardsOfAlaraBlock        Format = "Shards of Alara Block"
	Standard                  Format = "Standard"
	TherosBlock               Format = "Theros Block"
	UnSets                    Format = "Un-Sets"
	ZendikarBlock             Format = "Zendikar Block"
)

type invalidFormat string
func (x invalidFormat) Error() string { return "invalid Format: " + string(x) }

func (x *Format) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Format(value) {
	case Commander, Legacy, Modern, Vintage, TimeSpiralBlock, RavnicaBlock, IceAgeBlock, TempestBlock, OnslaughtBlock, MasquesBlock, MirageBlock, UrzaBlock, ScarsOfMirrodinBlock, MirrodinBlock, AmonkhetBlock, BattleForZendikarBlock, InnistradBlock, InvasionBlock, KaladeshBlock, KamigawaBlock, KhansOfTarkirBlock, LorwynShadowmoorBlock, OdysseyBlock, ReturnToRavnicaBlock, ShadowsOverInnistradBlock, ShardsOfAlaraBlock, Standard, TherosBlock, UnSets, ZendikarBlock: *x = Format(value); return nil
	}
	return invalidFormat(value)
}

type LegalityEnum string

const (
	Legal      LegalityEnum = "Legal"
	Banned     LegalityEnum = "Banned"
	Restricted LegalityEnum = "Restricted"
)

type invalidLegalityEnum string
func (x invalidLegalityEnum) Error() string { return "invalid LegalityEnum: " + string(x) }

func (x *LegalityEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch LegalityEnum(value) {
	case Legal, Banned, Restricted: *x = LegalityEnum(value); return nil
	}
	return invalidLegalityEnum(value)
}

type Rarity string

const (
	RarityUncommon Rarity = "Uncommon"
	RarityRare     Rarity = "Rare"
	RarityCommon   Rarity = "Common"
	BasicLand      Rarity = "Basic Land"
)

type invalidRarity string
func (x invalidRarity) Error() string { return "invalid Rarity: " + string(x) }

func (x *Rarity) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Rarity(value) {
	case RarityUncommon, RarityRare, RarityCommon, BasicLand: *x = Rarity(value); return nil
	}
	return invalidRarity(value)
}

type Supertype string

const (
	Basic Supertype = "Basic"
)

type invalidSupertype string
func (x invalidSupertype) Error() string { return "invalid Supertype: " + string(x) }

func (x *Supertype) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Supertype(value) {
	case Basic: *x = Supertype(value); return nil
	}
	return invalidSupertype(value)
}

type Type string

const (
	Creature    Type = "Creature"
	Instant     Type = "Instant"
	Enchantment Type = "Enchantment"
	Artifact    Type = "Artifact"
	Sorcery     Type = "Sorcery"
	Land        Type = "Land"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case Creature, Instant, Enchantment, Artifact, Sorcery, Land: *x = Type(value); return nil
	}
	return invalidType(value)
}
