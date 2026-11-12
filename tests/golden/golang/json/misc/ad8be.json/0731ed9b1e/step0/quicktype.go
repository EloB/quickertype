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
	ID           string       `json:"id"`
	Identifiers  []Identifier `json:"identifiers"`
	Keywords     []Keyword    `json:"keywords"`
	Links        []Link       `json:"links"`
	Name         string       `json:"name"`
	OtherNames   []OtherName  `json:"other_names"`
	SupersededBy *string      `json:"superseded_by"`
	Text         []Text       `json:"text"`
}

type Identifier struct {
	Identifier string `json:"identifier"`
	Scheme     Scheme `json:"scheme"`
}

type Link struct {
	Note Note   `json:"note"`
	URL  string `json:"url"`
}

type OtherName struct {
	Name string  `json:"name"`
	Note *string `json:"note"`
}

type Text struct {
	MediaType MediaType `json:"media_type"`
	Title     Title     `json:"title"`
	URL       string    `json:"url"`
}

type Scheme string

const (
	Spdx  Scheme = "SPDX"
	Trove Scheme = "Trove"
	Dep5  Scheme = "DEP5"
)

type invalidScheme string
func (x invalidScheme) Error() string { return "invalid Scheme: " + string(x) }

func (x *Scheme) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Scheme(value) {
	case Spdx, Trove, Dep5: *x = Scheme(value); return nil
	}
	return invalidScheme(value)
}

type Keyword string

const (
	OSIApproved    Keyword = "osi-approved"
	Discouraged    Keyword = "discouraged"
	Redundant      Keyword = "redundant"
	Miscellaneous  Keyword = "miscellaneous"
	NonReusable    Keyword = "non-reusable"
	Obsolete       Keyword = "obsolete"
	Popular        Keyword = "popular"
	Permissive     Keyword = "permissive"
	Retired        Keyword = "retired"
	SpecialPurpose Keyword = "special-purpose"
	Copyleft       Keyword = "copyleft"
	International  Keyword = "international"
)

type invalidKeyword string
func (x invalidKeyword) Error() string { return "invalid Keyword: " + string(x) }

func (x *Keyword) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Keyword(value) {
	case OSIApproved, Discouraged, Redundant, Miscellaneous, NonReusable, Obsolete, Popular, Permissive, Retired, SpecialPurpose, Copyleft, International: *x = Keyword(value); return nil
	}
	return invalidKeyword(value)
}

type Note string

const (
	OSIPage            Note = "OSI Page"
	TlDRLegal          Note = "tl;dr legal"
	WikipediaPage      Note = "Wikipedia page"
	NoteWikipediaPage  Note = "Wikipedia Page"
	MozillaPage        Note = "Mozilla Page"
	OSETFoundationPage Note = "OSET Foundation Page"
)

type invalidNote string
func (x invalidNote) Error() string { return "invalid Note: " + string(x) }

func (x *Note) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Note(value) {
	case OSIPage, TlDRLegal, WikipediaPage, NoteWikipediaPage, MozillaPage, OSETFoundationPage: *x = Note(value); return nil
	}
	return invalidNote(value)
}

type MediaType string

const (
	TextHTML       MediaType = "text/html"
	TextPlain      MediaType = "text/plain"
	ApplicationPDF MediaType = "application/pdf"
)

type invalidMediaType string
func (x invalidMediaType) Error() string { return "invalid MediaType: " + string(x) }

func (x *MediaType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MediaType(value) {
	case TextHTML, TextPlain, ApplicationPDF: *x = MediaType(value); return nil
	}
	return invalidMediaType(value)
}

type Title string

const (
	HTML      Title = "HTML"
	PlainText Title = "Plain Text"
	PDF       Title = "PDF"
)

type invalidTitle string
func (x invalidTitle) Error() string { return "invalid Title: " + string(x) }

func (x *Title) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Title(value) {
	case HTML, PlainText, PDF: *x = Title(value); return nil
	}
	return invalidTitle(value)
}
