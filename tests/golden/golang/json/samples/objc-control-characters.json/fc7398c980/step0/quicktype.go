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
	Literal string  `json:"literal"`
	The11   int64   `json:"#{1+1}"`
	Values  []Value `json:"values"`
}

type Value string

const (
	C0 Value = "c0\u0001\u001b\u001f"
	C1 Value = "c1\u007f\u0080\u0085\u009f"
)

type invalidValue string
func (x invalidValue) Error() string { return "invalid Value: " + string(x) }

func (x *Value) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Value(value) {
	case C0, C1: *x = Value(value); return nil
	}
	return invalidValue(value)
}
