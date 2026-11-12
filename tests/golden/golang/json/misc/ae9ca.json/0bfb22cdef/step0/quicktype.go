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
	Features []FeatureElement `json:"features"`
	Name     string           `json:"name"`
	Type     string           `json:"type"`
}

type FeatureElement struct {
	Geometry   Geometry    `json:"geometry"`
	Properties Properties  `json:"properties"`
	Type       FeatureType `json:"type"`
}

type Geometry struct {
	Coordinates []float64    `json:"coordinates"`
	Type        GeometryType `json:"type"`
}

type Properties struct {
	Area                 string               `json:"Area"`
	CentralAssetID       string               `json:"Central Asset ID"`
	Class                Class                `json:"Class"`
	FeatureLocation      string               `json:"Feature Location"`
	Lat                  string               `json:"lat"`
	Long                 string               `json:"long"`
	MaintainingAuthority MaintainingAuthority `json:"Maintaining Authority"`
	Number               string               `json:"Number"`
	SiteName             string               `json:"Site Name"`
	Ward                 Ward                 `json:"Ward"`
}

type GeometryType string

const (
	Point GeometryType = "Point"
)

type invalidGeometryType string
func (x invalidGeometryType) Error() string { return "invalid GeometryType: " + string(x) }

func (x *GeometryType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GeometryType(value) {
	case Point: *x = GeometryType(value); return nil
	}
	return invalidGeometryType(value)
}

type Class string

const (
	NoCodeAllocated Class = "No Code Allocated"
	OSDistrict      Class = "OS-District"
	OSNeighbourhood Class = "OS-Neighbourhood"
	OSRegional      Class = "OS-Regional"
)

type invalidClass string
func (x invalidClass) Error() string { return "invalid Class: " + string(x) }

func (x *Class) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Class(value) {
	case NoCodeAllocated, OSDistrict, OSNeighbourhood, OSRegional: *x = Class(value); return nil
	}
	return invalidClass(value)
}

type MaintainingAuthority string

const (
	CityOfBallarat MaintainingAuthority = "City of Ballarat"
)

type invalidMaintainingAuthority string
func (x invalidMaintainingAuthority) Error() string { return "invalid MaintainingAuthority: " + string(x) }

func (x *MaintainingAuthority) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MaintainingAuthority(value) {
	case CityOfBallarat: *x = MaintainingAuthority(value); return nil
	}
	return invalidMaintainingAuthority(value)
}

type Ward string

const (
	South   Ward = "South"
	North   Ward = "North"
	Central Ward = "Central"
)

type invalidWard string
func (x invalidWard) Error() string { return "invalid Ward: " + string(x) }

func (x *Ward) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Ward(value) {
	case South, North, Central: *x = Ward(value); return nil
	}
	return invalidWard(value)
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
