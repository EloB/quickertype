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
	// Comment delimiters:     
	// */                      
	// {-                      
	// -}                      
	// """                     
	// }                       
	// }                       
	Kind                  Kind `json:"kind"`
}

// Comment delimiters:
// */
// {-
// -}
// """
// }
// }
type Kind string

const (
	Ok Kind = "ok"
)

type invalidKind string
func (x invalidKind) Error() string { return "invalid Kind: " + string(x) }

func (x *Kind) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Kind(value) {
	case Ok: *x = Kind(value); return nil
	}
	return invalidKind(value)
}
