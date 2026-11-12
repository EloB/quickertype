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
	Pairs      map[string]Pair `json:"pairs"`
	ServerTime int64           `json:"server_time"`
}

type Pair struct {
	DecimalPlaces int64   `json:"decimal_places"`
	Fee           float64 `json:"fee"`
	Hidden        int64   `json:"hidden"`
	MaxAmount     int64   `json:"max_amount"`
	MaxPrice      int64   `json:"max_price"`
	MinAmount     float64 `json:"min_amount"`
	MinPrice      float64 `json:"min_price"`
	MinTotal      float64 `json:"min_total"`
}
