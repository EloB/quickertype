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
	Message      []interface{} `json:"message"`
	ResponseTime int64         `json:"responseTime"`
	Results      Results       `json:"Results"`
	Status       string        `json:"status"`
}

type Results struct {
	Series []Series `json:"series"`
}

type Series struct {
	Data     []Datum `json:"data"`
	SeriesID string  `json:"seriesID"`
}

type Datum struct {
	Footnotes  []Footnote `json:"footnotes"`
	Period     string     `json:"period"`
	PeriodName string     `json:"periodName"`
	Value      string     `json:"value"`
	Year       string     `json:"year"`
}

type Footnote struct {
	Code *string `json:"code,omitempty"`
	Text *string `json:"text,omitempty"`
}
