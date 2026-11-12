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
	PC   PC `json:"pc"`
	Ps3  PC `json:"ps3"`
	Ps4  PC `json:"ps4"`
	Xbox PC `json:"xbox"`
	Xone PC `json:"xone"`
}

type PC struct {
	Count  int64  `json:"count"`
	Label  string `json:"label"`
	Peak24 int64  `json:"peak24"`
}
