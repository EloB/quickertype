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
	Category        string        `json:"category"`
	Context         string        `json:"context"`
	ID              int64         `json:"id"`
	Location        Location      `json:"location"`
	LocationSubtype string        `json:"location_subtype"`
	LocationType    string        `json:"location_type"`
	Month           string        `json:"month"`
	OutcomeStatus   OutcomeStatus `json:"outcome_status"`
	PersistentID    string        `json:"persistent_id"`
}

type Location struct {
	Latitude  string `json:"latitude"`
	Longitude string `json:"longitude"`
	Street    Street `json:"street"`
}

type Street struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

type OutcomeStatus struct {
	Category string `json:"category"`
	Date     string `json:"date"`
}
