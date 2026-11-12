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
	Health Health `json:"health"`
}

type Health string

const (
	Ok    Health = "ok"
	Error Health = "error"
)

type invalidHealth string
func (x invalidHealth) Error() string { return "invalid Health: " + string(x) }

func (x *Health) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Health(value) {
	case Ok, Error: *x = Health(value); return nil
	}
	return invalidHealth(value)
}
