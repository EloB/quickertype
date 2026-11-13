// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    foo, err := UnmarshalFoo(bytes)
//    bytes, err = foo.Marshal()

package main

import "encoding/json"

func UnmarshalFoo(data []byte) (Foo, error) {
	var r Foo
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Foo) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type Foo struct {
	Greeting     string   `json:"greeting"`
	Instructions []string `json:"instructions"`
}
