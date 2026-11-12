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
	Keywords     []Keyword     `json:"keywords"`
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

type Keyword string

const (
	Discouraged Keyword = "discouraged"
	Retired     Keyword = "retired"
	OSIApproved Keyword = "osi-approved"
)

type invalidKeyword string
func (x invalidKeyword) Error() string { return "invalid Keyword: " + string(x) }

func (x *Keyword) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Keyword(value) {
	case Discouraged, Retired, OSIApproved: *x = Keyword(value); return nil
	}
	return invalidKeyword(value)
}
