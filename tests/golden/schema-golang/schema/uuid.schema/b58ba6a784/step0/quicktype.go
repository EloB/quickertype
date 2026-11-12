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
	ArrNullable   *[]*string `json:"arrNullable,omitempty"`
	ArrOne        *[]string  `json:"arrOne,omitempty"`
	Nullable      *string    `json:"nullable"`
	One           string     `json:"one"`
	Optional      *string    `json:"optional,omitempty"`
	UnionWithEnum string     `json:"unionWithEnum"`
}
