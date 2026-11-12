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
	Details string      `json:"details"`
	Rates   []Rate      `json:"rates"`
	Version interface{} `json:"version"`
}

type Rate struct {
	Code        string   `json:"code"`
	CountryCode string   `json:"country_code"`
	Name        string   `json:"name"`
	Periods     []Period `json:"periods"`
}

type Period struct {
	EffectiveFrom string `json:"effective_from"`
	Rates         Rates  `json:"rates"`
}

type Rates struct {
	Parking      *float64 `json:"parking,omitempty"`
	Reduced      *float64 `json:"reduced,omitempty"`
	Reduced1     *float64 `json:"reduced1,omitempty"`
	Reduced2     *float64 `json:"reduced2,omitempty"`
	Standard     float64  `json:"standard"`
	SuperReduced *float64 `json:"super_reduced,omitempty"`
}
