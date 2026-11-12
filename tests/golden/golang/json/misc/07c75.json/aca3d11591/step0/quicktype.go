// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	ID           string        `json:"id"`
	Identifiers  []Identifier  `json:"identifiers"`
	Keywords     []string      `json:"keywords"`
	Links        []Link        `json:"links"`
	Name         string        `json:"name"`
	OtherNames   []interface{} `json:"other_names"`
	SupersededBy interface{}   `json:"superseded_by"`
	Text         []Text        `json:"text"`
}

type Identifier struct {
	Identifier string `json:"identifier"`
	Scheme     string `json:"scheme"`
}

type Link struct {
	Note string `json:"note"`
	URL  string `json:"url"`
}

type Text struct {
	MediaType string `json:"media_type"`
	Title     string `json:"title"`
	URL       string `json:"url"`
}
