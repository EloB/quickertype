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

// Nested block comment openers:
// {-
// /*
// This text must remain inside the generated documentation comment.
type TopLevel struct {
	// Nested property block comment openers:                                           
	// {-                                                                               
	// /*                                                                               
	// This text must remain inside the generated property documentation comment.       
	Value                                                                        string `json:"value"`
}
