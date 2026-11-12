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
	IssPosition IssPosition `json:"iss_position"`
	Message     string      `json:"message"`
	Timestamp   int64       `json:"timestamp"`
}

type IssPosition struct {
	Latitude  string `json:"latitude"`
	Longitude string `json:"longitude"`
}
