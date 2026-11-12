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
	Bar []Bar `json:"bar"`
	Foo []Bar `json:"foo"`
}

type Bar struct {
	X X `json:"x"`
}

type X string

const (
	Three X = "three"
	One   X = "one"
	Two   X = "two"
)

type invalidX string
func (x invalidX) Error() string { return "invalid X: " + string(x) }

func (x *X) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch X(value) {
	case Three, One, Two: *x = X(value); return nil
	}
	return invalidX(value)
}
