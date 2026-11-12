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
	Amount      float64   `json:"amount"`
	Frequency   Frequency `json:"frequency"`
	Description *string   `json:"description,omitempty"`
	Type        Type      `json:"type"`
}

type Frequency string

const (
	Weekly   Frequency = "Weekly"
	Monthly  Frequency = "Monthly"
	Annually Frequency = "Annually"
)

type invalidFrequency string
func (x invalidFrequency) Error() string { return "invalid Frequency: " + string(x) }

func (x *Frequency) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Frequency(value) {
	case Weekly, Monthly, Annually: *x = Frequency(value); return nil
	}
	return invalidFrequency(value)
}

type Type string

const (
	GrossSalaryAmount Type = "GrossSalaryAmount"
	Overtime          Type = "Overtime"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case GrossSalaryAmount, Overtime: *x = Type(value); return nil
	}
	return invalidType(value)
}
