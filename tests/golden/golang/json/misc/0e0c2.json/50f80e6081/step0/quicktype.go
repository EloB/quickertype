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
	Count    int64       `json:"count"`
	Next     string      `json:"next"`
	Previous interface{} `json:"previous"`
	Results  []Result    `json:"results"`
}

type Result struct {
	ActiveScreens int64          `json:"active_screens"`
	Collections   []Collection   `json:"collections"`
	Details       []Detail       `json:"details"`
	Duration      int64          `json:"duration"`
	FavMovie      FavMovie       `json:"fav_movie"`
	ID            int64          `json:"id"`
	Images        []Image        `json:"images"`
	Language      ResultLanguage `json:"language"`
	ReleaseDate   string         `json:"release_date"`
	Stars         int64          `json:"stars"`
	Tags          []interface{}  `json:"tags"`
	Title         string         `json:"title"`
	Videos        []Video        `json:"videos"`
	VoteScore     VoteScore      `json:"vote_score"`
	Watches       int64          `json:"watches"`
}

type Collection struct {
	ID     int64   `json:"id"`
	Movies []int64 `json:"movies"`
	Name   string  `json:"name"`
	Slug   string  `json:"slug"`
}

type Detail struct {
	Cast      string         `json:"cast"`
	Director  string         `json:"director"`
	ID        int64          `json:"id"`
	Language  DetailLanguage `json:"language"`
	Storyline string         `json:"storyline"`
	Tagline   string         `json:"tagline"`
	Title     string         `json:"title"`
}

type FavMovie struct {
	Follow  bool `json:"follow"`
	Star    bool `json:"star"`
	Watched bool `json:"watched"`
}

type Image struct {
	Favs      int64  `json:"favs"`
	ID        int64  `json:"id"`
	Thumbnail string `json:"thumbnail"`
	Type      Type   `json:"type"`
	URL       string `json:"url"`
}

type Video struct {
	Kind     string         `json:"kind"`
	Language ResultLanguage `json:"language"`
	Source   string         `json:"source"`
	URL      string         `json:"url"`
}

type VoteScore struct {
	Avg   int64 `json:"avg"`
	Score int64 `json:"score"`
	Total int64 `json:"total"`
}

type DetailLanguage string

const (
	PurpleEn DetailLanguage = "en"
	Th       DetailLanguage = "th"
)

type invalidDetailLanguage string
func (x invalidDetailLanguage) Error() string { return "invalid DetailLanguage: " + string(x) }

func (x *DetailLanguage) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch DetailLanguage(value) {
	case PurpleEn, Th: *x = DetailLanguage(value); return nil
	}
	return invalidDetailLanguage(value)
}

type Type string

const (
	Poster   Type = "Poster"
	Backdrop Type = "Backdrop"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case Poster, Backdrop: *x = Type(value); return nil
	}
	return invalidType(value)
}

type ResultLanguage string

const (
	FluffyEn ResultLanguage = "en"
	Empty    ResultLanguage = "-"
)

type invalidResultLanguage string
func (x invalidResultLanguage) Error() string { return "invalid ResultLanguage: " + string(x) }

func (x *ResultLanguage) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ResultLanguage(value) {
	case FluffyEn, Empty: *x = ResultLanguage(value); return nil
	}
	return invalidResultLanguage(value)
}
