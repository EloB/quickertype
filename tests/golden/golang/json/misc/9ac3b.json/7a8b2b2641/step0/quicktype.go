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
	CreatedAt time.Time `json:"created_at"`
	Entity    string    `json:"entity"`
	FirstName string    `json:"first_name"`
	ID        string    `json:"id"`
	LastName  string    `json:"last_name"`
	Name      string    `json:"name"`
	Position  *string   `json:"position"`
	Status    Status    `json:"status"`
	Title     *Title    `json:"title"`
	URI       string    `json:"uri"`
	UpdatedAt time.Time `json:"updated_at"`
}

type Status string

const (
	Inactive Status = "inactive"
	Active   Status = "active"
)

type invalidStatus string
func (x invalidStatus) Error() string { return "invalid Status: " + string(x) }

func (x *Status) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Status(value) {
	case Inactive, Active: *x = Status(value); return nil
	}
	return invalidStatus(value)
}

type Title string

const (
	Mr Title = "Mr"
	MS Title = "Ms"
)

type invalidTitle string
func (x invalidTitle) Error() string { return "invalid Title: " + string(x) }

func (x *Title) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Title(value) {
	case Mr, MS: *x = Title(value); return nil
	}
	return invalidTitle(value)
}
