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
	Callsign Callsign `json:"callsign"`
	Priority Priority `json:"priority"`
}

type Callsign string

const (
	Alpha    Callsign = "alpha"
	Bravo    Callsign = "bravo"
	Charlie  Callsign = "charlie"
	Delta    Callsign = "delta"
	Echo     Callsign = "echo"
	Foxtrot  Callsign = "foxtrot"
	Golf     Callsign = "golf"
	Hotel    Callsign = "hotel"
	India    Callsign = "india"
	Juliett  Callsign = "juliett"
	Kilo     Callsign = "kilo"
	Lima     Callsign = "lima"
	Mike     Callsign = "mike"
	November Callsign = "november"
	Oscar    Callsign = "oscar"
	Papa     Callsign = "papa"
	Quebec   Callsign = "quebec"
	Romeo    Callsign = "romeo"
	Sierra   Callsign = "sierra"
	Tango    Callsign = "tango"
)

type invalidCallsign string
func (x invalidCallsign) Error() string { return "invalid Callsign: " + string(x) }

func (x *Callsign) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Callsign(value) {
	case Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India, Juliett, Kilo, Lima, Mike, November, Oscar, Papa, Quebec, Romeo, Sierra, Tango: *x = Callsign(value); return nil
	}
	return invalidCallsign(value)
}

type Priority string

const (
	Low    Priority = "low"
	Medium Priority = "medium"
	High   Priority = "high"
)

type invalidPriority string
func (x invalidPriority) Error() string { return "invalid Priority: " + string(x) }

func (x *Priority) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Priority(value) {
	case Low, Medium, High: *x = Priority(value); return nil
	}
	return invalidPriority(value)
}
