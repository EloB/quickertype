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
	Data   *Data    `json:"data"`
	Errors *[]Error `json:"errors,omitempty"`
}

type Data struct {
	Resource *UniformResourceLocatable `json:"resource"`
}

type UniformResourceLocatable struct {
	URL   string  `json:"url"`
	Login *string `json:"login,omitempty"`
}

type Error struct {
	Message string `json:"message"`
}
