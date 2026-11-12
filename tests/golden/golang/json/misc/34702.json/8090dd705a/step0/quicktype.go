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
	Coordinates []float64    `json:"coordinates"`
	Type        GeometryType `json:"type"`
}

type FeatureProperties struct {
	Division  string          `json:"division"`
	Fax       float64         `json:"fax"`
	FireBanR  *FireBanR       `json:"fire_ban_r"`
	Latitude  float64         `json:"latitude"`
	LocalGovt string          `json:"local_govt"`
	Longitude float64         `json:"longitude"`
	No        *string         `json:"no"`
	PSA       string          `json:"psa"`
	Phone     float64         `json:"phone"`
	Postcode  int64           `json:"postcode"`
	Region    Region          `json:"region"`
	Station   string          `json:"station"`
	Street    string          `json:"street"`
	Suburb    string          `json:"suburb"`
	Type      *PropertiesType `json:"type"`
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

type FireBanR string

const (
	NorthCentral       FireBanR = "North Central"
	Central            FireBanR = "Central"
	SouthWest          FireBanR = "South West"
	Wimmera            FireBanR = "Wimmera"
	NorthernCountry    FireBanR = "Northern Country"
	EastGippsland      FireBanR = "East Gippsland"
	NorthEast          FireBanR = "North East"
	Mallee             FireBanR = "Mallee"
	WestSouthGippsland FireBanR = "West &South Gippsland"
	Ballarat           FireBanR = "Ballarat"
)

type invalidFireBanR string
func (x invalidFireBanR) Error() string { return "invalid FireBanR: " + string(x) }

func (x *FireBanR) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FireBanR(value) {
	case NorthCentral, Central, SouthWest, Wimmera, NorthernCountry, EastGippsland, NorthEast, Mallee, WestSouthGippsland, Ballarat: *x = FireBanR(value); return nil
	}
	return invalidFireBanR(value)
}

type Region string

const (
	Eastern       Region = "Eastern"
	NorthernMetro Region = "Northern Metro"
	Western       Region = "Western"
	SouthernMetro Region = "Southern Metro"
)

type invalidRegion string
func (x invalidRegion) Error() string { return "invalid Region: " + string(x) }

func (x *Region) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Region(value) {
	case Eastern, NorthernMetro, Western, SouthernMetro: *x = Region(value); return nil
	}
	return invalidRegion(value)
}

type PropertiesType string

const (
	Street    PropertiesType = "STREET"
	Avenue    PropertiesType = "AVENUE"
	Road      PropertiesType = "ROAD"
	Highway   PropertiesType = "HIGHWAY"
	Boulevard PropertiesType = "BOULEVARD"
	Court     PropertiesType = "COURT"
	Way       PropertiesType = "WAY"
	Drive     PropertiesType = "DRIVE"
	South     PropertiesType = "SOUTH"
	Hill      PropertiesType = "HILL"
	Lane      PropertiesType = "LANE"
	Close     PropertiesType = "CLOSE"
	Parade    PropertiesType = "PARADE"
	TypeRoad  PropertiesType = "Road"
	Place     PropertiesType = "PLACE"
	RD        PropertiesType = "RD"
)

type invalidPropertiesType string
func (x invalidPropertiesType) Error() string { return "invalid PropertiesType: " + string(x) }

func (x *PropertiesType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PropertiesType(value) {
	case Street, Avenue, Road, Highway, Boulevard, Court, Way, Drive, South, Hill, Lane, Close, Parade, TypeRoad, Place, RD: *x = PropertiesType(value); return nil
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
