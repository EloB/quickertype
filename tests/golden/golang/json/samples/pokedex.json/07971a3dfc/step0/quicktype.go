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
	Pokemon []Pokemon `json:"pokemon"`
}

type Pokemon struct {
	AvgSpawns     float64      `json:"avg_spawns"`
	Candy         string       `json:"candy"`
	CandyCount    *int64       `json:"candy_count,omitempty"`
	Egg           Egg          `json:"egg"`
	Height        string       `json:"height"`
	ID            int64        `json:"id"`
	Img           string       `json:"img"`
	Multipliers   []float64    `json:"multipliers"`
	Name          string       `json:"name"`
	NextEvolution *[]Evolution `json:"next_evolution,omitempty"`
	Num           string       `json:"num"`
	PrevEvolution *[]Evolution `json:"prev_evolution,omitempty"`
	SpawnChance   float64      `json:"spawn_chance"`
	SpawnTime     string       `json:"spawn_time"`
	Type          []Type       `json:"type"`
	Weaknesses    []Type       `json:"weaknesses"`
	Weight        string       `json:"weight"`
}

type Evolution struct {
	Name string `json:"name"`
	Num  string `json:"num"`
}

type Egg string

const (
	The2KM       Egg = "2 km"
	NotInEggs    Egg = "Not in Eggs"
	The5KM       Egg = "5 km"
	The10KM      Egg = "10 km"
	OmanyteCandy Egg = "Omanyte Candy"
)

type invalidEgg string
func (x invalidEgg) Error() string { return "invalid Egg: " + string(x) }

func (x *Egg) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Egg(value) {
	case The2KM, NotInEggs, The5KM, The10KM, OmanyteCandy: *x = Egg(value); return nil
	}
	return invalidEgg(value)
}

type Type string

const (
	Fire     Type = "Fire"
	Ice      Type = "Ice"
	Flying   Type = "Flying"
	Psychic  Type = "Psychic"
	Water    Type = "Water"
	Ground   Type = "Ground"
	Rock     Type = "Rock"
	Electric Type = "Electric"
	Grass    Type = "Grass"
	Fighting Type = "Fighting"
	Poison   Type = "Poison"
	Bug      Type = "Bug"
	Fairy    Type = "Fairy"
	Ghost    Type = "Ghost"
	Dark     Type = "Dark"
	Steel    Type = "Steel"
	Dragon   Type = "Dragon"
	Normal   Type = "Normal"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case Fire, Ice, Flying, Psychic, Water, Ground, Rock, Electric, Grass, Fighting, Poison, Bug, Fairy, Ghost, Dark, Steel, Dragon, Normal: *x = Type(value); return nil
	}
	return invalidType(value)
}
