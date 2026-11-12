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
	Taxonomy Taxonomy `json:"Taxonomy"`
}

type Taxonomy struct {
	Properties Properties `json:"properties"`
}

type Properties struct {
	Annotations        Annotations `json:"annotations"`
	DatatypeProperties Annotations `json:"datatype_properties"`
	ID                 Annotations `json:"id"`
	Label              Annotations `json:"label"`
	SubClassOf         Annotations `json:"sub_class_of"`
	Type               Annotations `json:"type"`
}

type Annotations struct {
	Description string `json:"description"`
	Type        string `json:"type"`
}

type Info struct {
	Description string `json:"description"`
	Title       string `json:"title"`
	Version     string `json:"version"`
}

type Paths struct {
	ItaTaxonomiesSearch ItaTaxonomiesSearch `json:"/ita_taxonomies/search"`
}

type ItaTaxonomiesSearch struct {
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
	Format      string `json:"format"`
	In          string `json:"in"`
	Name        string `json:"name"`
	Required    bool   `json:"required"`
	Type        string `json:"type"`
}

type Responses struct {
	The200 The200 `json:"200"`
}

type The200 struct {
	Description string `json:"description"`
	Schema      Schema `json:"schema"`
}

type Schema struct {
	Ref string `json:"$ref"`
}
