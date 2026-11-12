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
	BasePath    string      `json:"basePath"`
	Definitions Definitions `json:"definitions"`
	Host        string      `json:"host"`
	Info        Info        `json:"info"`
	Paths       Paths       `json:"paths"`
	Produces    []string    `json:"produces"`
	Schemes     []string    `json:"schemes"`
	Swagger     string      `json:"swagger"`
}

type Definitions struct {
	List List `json:"List"`
}

type List struct {
	Properties map[string]Property `json:"properties"`
}

type Property struct {
	Description string `json:"description"`
	Type        Type   `json:"type"`
}

type Info struct {
	Description string `json:"description"`
	Title       string `json:"title"`
	Version     string `json:"version"`
}

type Paths struct {
	ConsolidatedScreeningListSearch ConsolidatedScreeningListSearch `json:"/consolidated_screening_list/search"`
}

type ConsolidatedScreeningListSearch struct {
	Get Get `json:"get"`
}

type Get struct {
	Description string      `json:"description"`
	Parameters  []Parameter `json:"parameters"`
	Responses   Responses   `json:"responses"`
	Summary     string      `json:"summary"`
	Tags        []string    `json:"tags"`
}

type Parameter struct {
	Description string `json:"description"`
	Format      Type   `json:"format"`
	In          In     `json:"in"`
	Name        string `json:"name"`
	Required    bool   `json:"required"`
	Type        Type   `json:"type"`
}

type Responses struct {
	The200 The200 `json:"200"`
}

type The200 struct {
	Description string `json:"description"`
	Schema      Schema `json:"schema"`
}

type Schema struct {
	Items Items  `json:"items"`
	Type  string `json:"type"`
}

type Items struct {
	Ref string `json:"$ref"`
}

type Type string

const (
	String Type = "string"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case String: *x = Type(value); return nil
	}
	return invalidType(value)
}

type In string

const (
	Query In = "query"
)

type invalidIn string
func (x invalidIn) Error() string { return "invalid In: " + string(x) }

func (x *In) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch In(value) {
	case Query: *x = In(value); return nil
	}
	return invalidIn(value)
}
