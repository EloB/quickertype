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
	Metadata Metadata `json:"metadata"`
	Results  []Result `json:"results"`
}

type Metadata struct {
	ExecutionTime float64      `json:"executionTime"`
	ResponseInfo  ResponseInfo `json:"responseInfo"`
	Resultset     Resultset    `json:"resultset"`
}

type ResponseInfo struct {
	DeveloperMessage string `json:"developerMessage"`
	Status           int64  `json:"status"`
}

type Resultset struct {
	Count    int64 `json:"count"`
	Page     int64 `json:"page"`
	Pagesize int64 `json:"pagesize"`
}

type Result struct {
	Attachment []interface{} `json:"attachment"`
	Body       string        `json:"body"`
	Changed    string        `json:"changed"`
	Component  []Component   `json:"component"`
	Created    string        `json:"created"`
	Date       string        `json:"date"`
	Image      []interface{} `json:"image"`
	Number     interface{}   `json:"number"`
	Teaser     interface{}   `json:"teaser"`
	Title      string        `json:"title"`
	Topic      []interface{} `json:"topic"`
	URL        string        `json:"url"`
	UUID       string        `json:"uuid"`
	Vuuid      string        `json:"vuuid"`
}

type Component struct {
	Name string `json:"name"`
	UUID string `json:"uuid"`
}
