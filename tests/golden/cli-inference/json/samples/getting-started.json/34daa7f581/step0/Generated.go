// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    generated, err := UnmarshalGenerated(bytes)
//    bytes, err = generated.Marshal()

package main

import "encoding/json"

func UnmarshalGenerated(data []byte) (Generated, error) {
	var r Generated
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Generated) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type Generated struct {
	Greeting     string   `json:"greeting"`
	Instructions []string `json:"instructions"`
}
