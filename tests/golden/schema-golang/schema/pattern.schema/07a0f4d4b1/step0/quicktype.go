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
	Pattern1 string  `json:"pattern1"`
	Pattern2 string  `json:"pattern2"`
	RegExp   *RegExp `json:"RegExp,omitempty"`
	Union    string  `json:"union"`
}

type RegExp struct {
	Pattern3 string `json:"pattern3"`
}
