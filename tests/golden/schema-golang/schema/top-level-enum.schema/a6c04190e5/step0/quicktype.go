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

type TopLevel string

const (
	One   TopLevel = "one"
	Three TopLevel = "three"
	Two   TopLevel = "two"
)

type invalidTopLevel string
func (x invalidTopLevel) Error() string { return "invalid TopLevel: " + string(x) }

func (x *TopLevel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TopLevel(value) {
	case One, Three, Two: *x = TopLevel(value); return nil
	}
	return invalidTopLevel(value)
}
