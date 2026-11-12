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
	Free               float64 `json:"free"`
	Intersection       float64 `json:"intersection"`
	Max                float64 `json:"max"`
	Min                float64 `json:"min"`
	Minmax             float64 `json:"minmax"`
	MinMaxIntersection float64 `json:"minMaxIntersection"`
	MinMaxUnion        float64 `json:"minMaxUnion"`
	Union              float64 `json:"union"`
}
