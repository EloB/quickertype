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
	Args    Args    `json:"args"`
	Data    string  `json:"data"`
	Files   Args    `json:"files"`
	Form    Args    `json:"form"`
	Headers Headers `json:"headers"`
	Origin  string  `json:"origin"`
	URL     string  `json:"url"`
}

type Args struct {
}

type Headers struct {
	AcceptEncoding string `json:"Accept-Encoding"`
	Connection     string `json:"Connection"`
	Host           string `json:"Host"`
	UserAgent      string `json:"User-Agent"`
}
