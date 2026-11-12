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
	Data        map[string]Datum `json:"data"`
	Description Description      `json:"description"`
}

type Datum struct {
	Anomaly string `json:"anomaly"`
	Value   string `json:"value"`
}

type Description struct {
	BasePeriod string `json:"base_period"`
	Missing    int64  `json:"missing"`
	Title      string `json:"title"`
	Units      string `json:"units"`
}
