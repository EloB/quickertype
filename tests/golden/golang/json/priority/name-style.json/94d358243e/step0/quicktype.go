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
	AnEasyOne                      int64  `json:"anEasyOne"`
	IsMNISTLetter                  bool   `json:"isMNISTLetter"`
	JSONString                     string `json:"JSONString"`
	PrettyEasyToo                  bool   `json:"PrettyEasyToo"`
	ShouldKnowThatIDIsAnInitialism string `json:"should_know_that_id_is_an_initialism"`
	SpacesAreSeparatorsToo         bool   `json:"   spaces are separators  too  "`
	ZsrHhDemo3Delmatnr             bool   `json:"ZSR_HH_DEMO3_DELMATNR"`
}
