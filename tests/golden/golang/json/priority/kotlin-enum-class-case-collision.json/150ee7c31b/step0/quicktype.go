// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	Category CategoryEnum `json:"category"`
}

type CategoryEnum string

const (
	Empty    CategoryEnum = " "
	Category CategoryEnum = ""
)

type invalidCategoryEnum string
func (x invalidCategoryEnum) Error() string { return "invalid CategoryEnum: " + string(x) }

func (x *CategoryEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch CategoryEnum(value) {
	case Empty, Category: *x = CategoryEnum(value); return nil
	}
	return invalidCategoryEnum(value)
}
