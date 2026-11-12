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
	Bbox     []float64        `json:"bbox"`
	Features []FeatureElement `json:"features"`
	Metadata Metadata         `json:"metadata"`
	Type     string           `json:"type"`
}

type FeatureElement struct {
	Geometry   Geometry    `json:"geometry"`
	ID         string      `json:"id"`
	Properties Properties  `json:"properties"`
	Type       FeatureType `json:"type"`
}

type Geometry struct {
	Coordinates []float64    `json:"coordinates"`
	Type        GeometryType `json:"type"`
}

type Properties struct {
	Alert   interface{}    `json:"alert"`
	Cdi     interface{}    `json:"cdi"`
	Code    string         `json:"code"`
	Detail  string         `json:"detail"`
	Dmin    *float64       `json:"dmin"`
	Felt    interface{}    `json:"felt"`
	Gap     *int64         `json:"gap"`
	IDS     string         `json:"ids"`
	MMI     interface{}    `json:"mmi"`
	Mag     float64        `json:"mag"`
	MagType MagType        `json:"magType"`
	Net     string         `json:"net"`
	Nst     *int64         `json:"nst"`
	Place   string         `json:"place"`
	RMS     float64        `json:"rms"`
	Sig     int64          `json:"sig"`
	Sources string         `json:"sources"`
	Status  Status         `json:"status"`
	Time    int64          `json:"time"`
	Title   string         `json:"title"`
	Tsunami int64          `json:"tsunami"`
	Type    PropertiesType `json:"type"`
	Types   string         `json:"types"`
	Tz      int64          `json:"tz"`
	URL     string         `json:"url"`
	Updated int64          `json:"updated"`
}

type Metadata struct {
	API       string `json:"api"`
	Count     int64  `json:"count"`
	Generated int64  `json:"generated"`
	Status    int64  `json:"status"`
	Title     string `json:"title"`
	URL       string `json:"url"`
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

type MagType string

const (
	Md MagType = "md"
	Ml MagType = "ml"
	MB MagType = "mb"
)

type invalidMagType string
func (x invalidMagType) Error() string { return "invalid MagType: " + string(x) }

func (x *MagType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MagType(value) {
	case Md, Ml, MB: *x = MagType(value); return nil
	}
	return invalidMagType(value)
}

type Status string

const (
	Automatic Status = "automatic"
	Reviewed  Status = "reviewed"
)

type invalidStatus string
func (x invalidStatus) Error() string { return "invalid Status: " + string(x) }

func (x *Status) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Status(value) {
	case Automatic, Reviewed: *x = Status(value); return nil
	}
	return invalidStatus(value)
}

type PropertiesType string

const (
	Earthquake PropertiesType = "earthquake"
)

type invalidPropertiesType string
func (x invalidPropertiesType) Error() string { return "invalid PropertiesType: " + string(x) }

func (x *PropertiesType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PropertiesType(value) {
	case Earthquake: *x = PropertiesType(value); return nil
	}
	return invalidPropertiesType(value)
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
