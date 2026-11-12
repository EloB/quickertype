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
	Prizes []Prize `json:"prizes"`
}

type Prize struct {
	Category          Category   `json:"category"`
	Laureates         []Laureate `json:"laureates"`
	OverallMotivation *string    `json:"overallMotivation,omitempty"`
	Year              string     `json:"year"`
}

type Laureate struct {
	Firstname  string  `json:"firstname"`
	ID         string  `json:"id"`
	Motivation *string `json:"motivation,omitempty"`
	Share      string  `json:"share"`
	Surname    string  `json:"surname"`
}

type Category string

const (
	Physics    Category = "physics"
	Chemistry  Category = "chemistry"
	Medicine   Category = "medicine"
	Literature Category = "literature"
	Peace      Category = "peace"
	Economics  Category = "economics"
)

type invalidCategory string
func (x invalidCategory) Error() string { return "invalid Category: " + string(x) }

func (x *Category) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Category(value) {
	case Physics, Chemistry, Medicine, Literature, Peace, Economics: *x = Category(value); return nil
	}
	return invalidCategory(value)
}
