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
	CRS           CRS              `json:"crs"`
	Features      []FeatureElement `json:"features"`
	TotalFeatures int64            `json:"totalFeatures"`
	Type          string           `json:"type"`
}

type CRS struct {
	Properties CRSProperties `json:"properties"`
	Type       string        `json:"type"`
}

type CRSProperties struct {
	Name string `json:"name"`
}

type FeatureElement struct {
	Geometry     Geometry          `json:"geometry"`
	GeometryName GeometryName      `json:"geometry_name"`
	ID           string            `json:"id"`
	Properties   FeatureProperties `json:"properties"`
	Type         FeatureType       `json:"type"`
}

type Geometry struct {
	Coordinates [][]float64  `json:"coordinates"`
	Type        GeometryType `json:"type"`
}

type FeatureProperties struct {
	Facebookaccount    string `json:"facebookaccount"`
	Frequencyfinderurl string `json:"frequencyfinderurl"`
	Name               string `json:"name"`
	Siteurl            string `json:"siteurl"`
	Streetaddress      string `json:"streetaddress"`
	Twitteraccount     string `json:"twitteraccount"`
}

type GeometryType string

const (
	MultiPoint GeometryType = "MultiPoint"
)

type invalidGeometryType string
func (x invalidGeometryType) Error() string { return "invalid GeometryType: " + string(x) }

func (x *GeometryType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GeometryType(value) {
	case MultiPoint: *x = GeometryType(value); return nil
	}
	return invalidGeometryType(value)
}

type GeometryName string

const (
	Geom GeometryName = "geom"
)

type invalidGeometryName string
func (x invalidGeometryName) Error() string { return "invalid GeometryName: " + string(x) }

func (x *GeometryName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GeometryName(value) {
	case Geom: *x = GeometryName(value); return nil
	}
	return invalidGeometryName(value)
}

type FeatureType string

const (
	Feature FeatureType = "Feature"
)

type invalidFeatureType string
func (x invalidFeatureType) Error() string { return "invalid FeatureType: " + string(x) }

func (x *FeatureType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FeatureType(value) {
	case Feature: *x = FeatureType(value); return nil
	}
	return invalidFeatureType(value)
}
