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
	Count    int64    `json:"count"`
	Facets   Facets   `json:"facets"`
	Limit    int64    `json:"limit"`
	Next     string   `json:"next"`
	Offset   int64    `json:"offset"`
	Previous bool     `json:"previous"`
	Results  []Result `json:"results"`
}

type Facets struct {
}

type Result struct {
	Code      string    `json:"code"`
	CreatedAt time.Time `json:"created_at"`
	ID        int64     `json:"id"`
	Name      string    `json:"name"`
	URI       string    `json:"uri"`
	UpdatedAt time.Time `json:"updated_at"`
}
