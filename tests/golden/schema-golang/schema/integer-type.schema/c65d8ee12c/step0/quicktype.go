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
	AboveI32Max   int64 `json:"above_i32_max"`
	BelowI32Min   int64 `json:"below_i32_min"`
	I32Range      int64 `json:"i32_range"`
	LargeBounds   int64 `json:"large_bounds"`
	OnlyMaximum   int64 `json:"only_maximum"`
	OnlyMinimum   int64 `json:"only_minimum"`
	SmallNegative int64 `json:"small_negative"`
	SmallPositive int64 `json:"small_positive"`
	Unbounded     int64 `json:"unbounded"`
}
