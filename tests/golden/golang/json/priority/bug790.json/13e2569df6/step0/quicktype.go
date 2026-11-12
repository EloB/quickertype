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
	ChildrenData []TopLevel `json:"children_data"`
	ID           int64      `json:"id"`
	IsActive     bool       `json:"is_active"`
	Level        int64      `json:"level"`
	Name         string     `json:"name"`
	ParentID     int64      `json:"parent_id"`
	Position     int64      `json:"position"`
	ProductCount int64      `json:"product_count"`
}
