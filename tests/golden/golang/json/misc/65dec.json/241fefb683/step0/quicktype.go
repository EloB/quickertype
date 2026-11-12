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
	Booster            []string `json:"booster"`
	Border             string   `json:"border"`
	Cards              []Card   `json:"cards"`
	Code               string   `json:"code"`
	GathererCode       string   `json:"gathererCode"`
	MagicCardsInfoCode string   `json:"magicCardsInfoCode"`
	MkmID              int64    `json:"mkm_id"`
	MkmName            string   `json:"mkm_name"`
	Name               string   `json:"name"`
	ReleaseDate        string   `json:"releaseDate"`
	Type               string   `json:"type"`
}

type Card struct {
	Artist        string            `json:"artist"`
	Cmc           int64             `json:"cmc"`
	ColorIdentity *[]ColorIdentity  `json:"colorIdentity,omitempty"`
	Colors        *[]Watermark      `json:"colors,omitempty"`
	Flavor        *string           `json:"flavor,omitempty"`
	ID            string            `json:"id"`
	ImageName     string            `json:"imageName"`
	Layout        Layout            `json:"layout"`
	Legalities    []LegalityElement `json:"legalities"`
	ManaCost      *string           `json:"manaCost,omitempty"`
	MciNumber     *string           `json:"mciNumber,omitempty"`
	Multiverseid  int64             `json:"multiverseid"`
	Name          string            `json:"name"`
	OriginalText  string            `json:"originalText"`
	OriginalType  string            `json:"originalType"`
	Power         *string           `json:"power,omitempty"`
	Printings     []string          `json:"printings"`
	Rarity        Rarity            `json:"rarity"`
	Reserved      *bool             `json:"reserved,omitempty"`
	Rulings       *[]Ruling         `json:"rulings,omitempty"`
	Subtypes      *[]string         `json:"subtypes,omitempty"`
	Supertypes    *[]string         `json:"supertypes,omitempty"`
	Text          *string           `json:"text,omitempty"`
	Toughness     *string           `json:"toughness,omitempty"`
	Type          string            `json:"type"`
	Types         []Type            `json:"types"`
	Variations    *[]int64          `json:"variations,omitempty"`
	Watermark     *Watermark        `json:"watermark,omitempty"`
}

type LegalityElement struct {
	Format   string       `json:"format"`
	Legality LegalityEnum `json:"legality"`
}

type Ruling struct {
	Date string `json:"date"`
	Text string `json:"text"`
}

type ColorIdentity string

const (
	W ColorIdentity = "W"
	R ColorIdentity = "R"
	B ColorIdentity = "B"
	G ColorIdentity = "G"
	U ColorIdentity = "U"
)

type invalidColorIdentity string
func (x invalidColorIdentity) Error() string { return "invalid ColorIdentity: " + string(x) }

func (x *ColorIdentity) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ColorIdentity(value) {
	case W, R, B, G, U: *x = ColorIdentity(value); return nil
	}
	return invalidColorIdentity(value)
}

type Watermark string

const (
	White Watermark = "White"
	Red   Watermark = "Red"
	Black Watermark = "Black"
	Green Watermark = "Green"
	Blue  Watermark = "Blue"
)

type invalidWatermark string
func (x invalidWatermark) Error() string { return "invalid Watermark: " + string(x) }

func (x *Watermark) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Watermark(value) {
	case White, Red, Black, Green, Blue: *x = Watermark(value); return nil
	}
	return invalidWatermark(value)
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
	Uncommon  Rarity = "Uncommon"
	Rare      Rarity = "Rare"
	Common    Rarity = "Common"
	BasicLand Rarity = "Basic Land"
)

type invalidRarity string
func (x invalidRarity) Error() string { return "invalid Rarity: " + string(x) }

func (x *Rarity) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Rarity(value) {
	case Uncommon, Rare, Common, BasicLand: *x = Rarity(value); return nil
	}
	return invalidRarity(value)
}

type Type string

const (
	Creature    Type = "Creature"
	Artifact    Type = "Artifact"
	Instant     Type = "Instant"
	Land        Type = "Land"
	Enchantment Type = "Enchantment"
	Sorcery     Type = "Sorcery"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case Creature, Artifact, Instant, Land, Enchantment, Sorcery: *x = Type(value); return nil
	}
	return invalidType(value)
}
