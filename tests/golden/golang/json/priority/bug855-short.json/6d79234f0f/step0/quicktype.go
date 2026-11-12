// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

type TopLevel map[string]TopLevelValue

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelValue struct {
	ChannelID   string `json:"channel_id"`
	ChannelName string `json:"channel_name"`
	Code        string `json:"code"`
	EmoticonSet int64  `json:"emoticon_set"`
	ID          int64  `json:"id"`
}
