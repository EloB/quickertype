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
	Name     string    `json:"name"`
	Shortcut *Shortcut `json:"shortcut,omitempty"`
}

type Shortcut string

const (
	Hidden  Shortcut = "hidden"
	Visible Shortcut = "visible"
)

type invalidShortcut string
func (x invalidShortcut) Error() string { return "invalid Shortcut: " + string(x) }

func (x *Shortcut) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Shortcut(value) {
	case Hidden, Visible: *x = Shortcut(value); return nil
	}
	return invalidShortcut(value)
}
