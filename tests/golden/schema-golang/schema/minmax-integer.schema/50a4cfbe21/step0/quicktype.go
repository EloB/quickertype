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
	Free               int64 `json:"free"`
	Intersection       int64 `json:"intersection"`
	Max                int64 `json:"max"`
	Min                int64 `json:"min"`
	Minmax             int64 `json:"minmax"`
	MinMaxIntersection int64 `json:"minMaxIntersection"`
	MinMaxUnion        int64 `json:"minMaxUnion"`
	Union              int64 `json:"union"`
}
