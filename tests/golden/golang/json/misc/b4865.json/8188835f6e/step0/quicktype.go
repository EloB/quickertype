// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

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
	ComputedRegionCbhkFwbd *string      `json:":@computed_region_cbhk_fwbd,omitempty"`
	ComputedRegionNnqa25F4 *string      `json:":@computed_region_nnqa_25f4,omitempty"`
	Fall                   Fall         `json:"fall"`
	Geolocation            *Geolocation `json:"geolocation,omitempty"`
	ID                     string       `json:"id"`
	Mass                   *string      `json:"mass,omitempty"`
	Name                   string       `json:"name"`
	Nametype               Nametype     `json:"nametype"`
	Recclass               string       `json:"recclass"`
	Reclat                 *string      `json:"reclat,omitempty"`
	Reclong                *string      `json:"reclong,omitempty"`
	Year                   *time.Time   `json:"year,omitempty"`
}

type Geolocation struct {
	Coordinates []float64 `json:"coordinates"`
	Type        Type      `json:"type"`
}

type Fall string

const (
	Fell  Fall = "Fell"
	Found Fall = "Found"
)

type invalidFall string
func (x invalidFall) Error() string { return "invalid Fall: " + string(x) }

func (x *Fall) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Fall(value) {
	case Fell, Found: *x = Fall(value); return nil
	}
	return invalidFall(value)
}

type Type string

const (
	Point Type = "Point"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case Point: *x = Type(value); return nil
	}
	return invalidType(value)
}

type Nametype string

const (
	Valid Nametype = "Valid"
)

type invalidNametype string
func (x invalidNametype) Error() string { return "invalid Nametype: " + string(x) }

func (x *Nametype) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Nametype(value) {
	case Valid: *x = Nametype(value); return nil
	}
	return invalidNametype(value)
}
