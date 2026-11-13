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
	StringValue      string                  `json:"stringValue"`
	DateValue        string                  `json:"dateValue"`
	UUIDValue        string                  `json:"uuidValue"`
	NameWithSpaces   interface{}             `json:"name with spaces"`
	DoubleValue      float64                 `json:"doubleValue"`
	IntValue         int64                   `json:"intValue"`
	BooleanValue     bool                    `json:"booleanValue"`
	NullValue        interface{}             `json:"nullValue"`
	Tuples           [][]IntOrString         `json:"tuples"`
	Person           PurplePerson            `json:"person"`
	People           []PersonElement         `json:"people"`
	DifferentThings  []DifferentThingElement `json:"differentThings"`
	MapValue         map[string]*int64       `json:"mapValue"`
	NullableMapValue map[string]*int64       `json:"nullableMapValue"`
}
