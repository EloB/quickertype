// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

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
	Item []Item `json:"item"`
}

type Item struct {
	Address   *Address   `json:"address,omitempty"`
	CreatedAt *time.Time `json:"created_at,omitempty"`
	Name      string     `json:"name"`
	Sex       *int64     `json:"sex"`
}

type Address struct {
	City    string `json:"city"`
	Country string `json:"country"`
	Street  string `json:"street"`
}
