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
	SupersededBy *string       `json:"superseded_by"`
	Text         []Text        `json:"text"`
}

type Identifier struct {
	Identifier string `json:"identifier"`
	Scheme     Scheme `json:"scheme"`
}

type Link struct {
	Note string `json:"note"`
	URL  string `json:"url"`
}

type Text struct {
	MediaType MediaType `json:"media_type"`
	Title     Title     `json:"title"`
	URL       string    `json:"url"`
}

type Scheme string

const (
	Dep5  Scheme = "DEP5"
	Spdx  Scheme = "SPDX"
	Trove Scheme = "Trove"
)

type invalidScheme string
func (x invalidScheme) Error() string { return "invalid Scheme: " + string(x) }

func (x *Scheme) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Scheme(value) {
	case Dep5, Spdx, Trove: *x = Scheme(value); return nil
	}
	return invalidScheme(value)
}

type Keyword string

const (
	OSIApproved   Keyword = "osi-approved"
	Popular       Keyword = "popular"
	Copyleft      Keyword = "copyleft"
	International Keyword = "international"
)

type invalidKeyword string
func (x invalidKeyword) Error() string { return "invalid Keyword: " + string(x) }

func (x *Keyword) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Keyword(value) {
	case OSIApproved, Popular, Copyleft, International: *x = Keyword(value); return nil
	}
	return invalidKeyword(value)
}

type MediaType string

const (
	TextPlain MediaType = "text/plain"
	TextHTML  MediaType = "text/html"
)

type invalidMediaType string
func (x invalidMediaType) Error() string { return "invalid MediaType: " + string(x) }

func (x *MediaType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MediaType(value) {
	case TextPlain, TextHTML: *x = MediaType(value); return nil
	}
	return invalidMediaType(value)
}

type Title string

const (
	PlainText Title = "Plain Text"
	HTML      Title = "HTML"
)

type invalidTitle string
func (x invalidTitle) Error() string { return "invalid Title: " + string(x) }

func (x *Title) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Title(value) {
	case PlainText, HTML: *x = Title(value); return nil
	}
	return invalidTitle(value)
}
