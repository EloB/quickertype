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
	Weekdays Weekdays `json:"weekdays"`
}

type Weekdays string

const (
	Monday    Weekdays = "Monday"
	Tuesday   Weekdays = "Tuesday"
	Wednesday Weekdays = "Wednesday"
	Thursday  Weekdays = "Thursday"
	Friday    Weekdays = "Friday"
	Saturday  Weekdays = "Saturday"
	Sunday    Weekdays = "Sunday"
)

type invalidWeekdays string
func (x invalidWeekdays) Error() string { return "invalid Weekdays: " + string(x) }

func (x *Weekdays) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Weekdays(value) {
	case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday: *x = Weekdays(value); return nil
	}
	return invalidWeekdays(value)
}
