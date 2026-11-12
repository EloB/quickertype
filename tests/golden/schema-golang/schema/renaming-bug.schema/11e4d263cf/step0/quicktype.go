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
	Version  *string    `json:"version,omitempty"`
	Fruits   *[]Fruit   `json:"fruits,omitempty"`
	Vehicles *[]Vehicle `json:"vehicles,omitempty"`
}

type Fruit struct {
	Apple   *bool    `json:"apple,omitempty"`
	Berries *[]Berry `json:"berries,omitempty"`
	Orange  *bool    `json:"orange,omitempty"`
}

type Berry struct {
	Color  *Color   `json:"color,omitempty"`
	Name   *string  `json:"name,omitempty"`
	Shapes *[]Shape `json:"shapes,omitempty"`
}

type Color struct {
	RGB *float64 `json:"rgb,omitempty"`
}

type Shape struct {
	Geometry *Geometry `json:"geometry,omitempty"`
	History  *History  `json:"history,omitempty"`
}

type Geometry struct {
	RectShape     *RectShape       `json:"rectShape,omitempty"`
	CircularShape *[]CircularShape `json:"circularShape,omitempty"`
}

type CircularShape struct {
	ShapeName *string `json:"shapeName,omitempty"`
}

type RectShape struct {
	Parts *[]Part `json:"parts,omitempty"`
}

type Part struct {
	Depth  *string `json:"depth,omitempty"`
	Length *string `json:"length,omitempty"`
	Width  *string `json:"width,omitempty"`
}

type History struct {
	Class *string `json:"class,omitempty"`
}

type Vehicle struct {
	Brand     *string      `json:"brand,omitempty"`
	ID        *string      `json:"id,omitempty"`
	Speed     *Speed       `json:"speed,omitempty"`
	SubModule *bool        `json:"subModule,omitempty"`
	Type      *VehicleType `json:"type,omitempty"`
	Year      *string      `json:"year,omitempty"`
}

type Speed struct {
	Velocity *Limit `json:"velocity,omitempty"`
}

type Limit struct {
	Maximum *float64 `json:"maximum,omitempty"`
	Minimum *float64 `json:"minimum,omitempty"`
}

type VehicleType struct {
	Name   *Name `json:"name,omitempty"`
	Width  *Axis `json:"width,omitempty"`
	Length *Axis `json:"length,omitempty"`
}

type Axis string

const (
	X  Axis = "X"
	Y  Axis = "Y"
	Z  Axis = "Z"
	Xy Axis = "XY"
	Yz Axis = "YZ"
	Zx Axis = "ZX"
)

type invalidAxis string
func (x invalidAxis) Error() string { return "invalid Axis: " + string(x) }

func (x *Axis) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Axis(value) {
	case X, Y, Z, Xy, Yz, Zx: *x = Axis(value); return nil
	}
	return invalidAxis(value)
}

type Name string

const (
	Truck     Name = "truck"
	Bus       Name = "bus"
	Car       Name = "car"
	Van       Name = "van"
	Train     Name = "train"
	Bike      Name = "Bike"
	Aeroplane Name = "Aeroplane"
	Jeep      Name = "Jeep"
	Trolley   Name = "Trolley"
)

type invalidName string
func (x invalidName) Error() string { return "invalid Name: " + string(x) }

func (x *Name) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Name(value) {
	case Truck, Bus, Car, Van, Train, Bike, Aeroplane, Jeep, Trolley: *x = Name(value); return nil
	}
	return invalidName(value)
}
