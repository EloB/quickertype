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
	MissionSpecs map[string]MissionSpec `json:"mission_specs"`
}

type MissionSpec struct {
	Objectives map[string]Objective `json:"objectives"`
}

type Objective struct {
	Rewards map[string]Reward `json:"rewards"`
}

type Reward struct {
}
