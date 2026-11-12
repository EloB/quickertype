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
	OptionalDate     *string    `json:"optional-date,omitempty"`
	OptionalDateTime *time.Time `json:"optional-date-time,omitempty"`
	OptionalTime     *string    `json:"optional-time,omitempty"`
	RequiredDate     string     `json:"required-date"`
	RequiredDateTime time.Time  `json:"required-date-time"`
	RequiredTime     string     `json:"required-time"`
}
