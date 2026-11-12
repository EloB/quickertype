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
	Enum *Enum `json:"enum"`
}

type Enum string

const (
	Foo Enum = "foo"
	Bar Enum = "bar"
)

type invalidEnum string
func (x invalidEnum) Error() string { return "invalid Enum: " + string(x) }

func (x *Enum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Enum(value) {
	case Foo, Bar: *x = Enum(value); return nil
	}
	return invalidEnum(value)
}
