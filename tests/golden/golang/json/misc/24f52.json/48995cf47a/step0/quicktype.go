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
	City    string  `json:"city"`
	Delay   string  `json:"delay"`
	Iata    string  `json:"IATA"`
	Icao    string  `json:"ICAO"`
	Name    string  `json:"name"`
	State   string  `json:"state"`
	Status  Status  `json:"status"`
	Weather Weather `json:"weather"`
}

type Status struct {
	AvgDelay     string `json:"avgDelay"`
	ClosureBegin string `json:"closureBegin"`
	ClosureEnd   string `json:"closureEnd"`
	EndTime      string `json:"endTime"`
	MaxDelay     string `json:"maxDelay"`
	MinDelay     string `json:"minDelay"`
	Reason       string `json:"reason"`
	Trend        string `json:"trend"`
	Type         string `json:"type"`
}

type Weather struct {
	Meta       Meta    `json:"meta"`
	Temp       string  `json:"temp"`
	Visibility float64 `json:"visibility"`
	Weather    string  `json:"weather"`
	Wind       string  `json:"wind"`
}

type Meta struct {
	Credit  string `json:"credit"`
	URL     string `json:"url"`
	Updated string `json:"updated"`
}
