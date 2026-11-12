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
	Age     int64   `json:"age"`
	Country Country `json:"country"`
	Females int64   `json:"females"`
	Males   int64   `json:"males"`
	Total   int64   `json:"total"`
	Year    int64   `json:"year"`
}

type Country string

const (
	UnitedStates Country = "United States"
)

type invalidCountry string
func (x invalidCountry) Error() string { return "invalid Country: " + string(x) }

func (x *Country) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Country(value) {
	case UnitedStates: *x = Country(value); return nil
	}
	return invalidCountry(value)
}
