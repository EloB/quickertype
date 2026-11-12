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
	Data   *Data    `json:"data"`
	Errors *[]Error `json:"errors,omitempty"`
}

type Data struct {
	AddReaction *AddReactionPayload `json:"addReaction"`
}

type AddReactionPayload struct {
	ClientMutationID *string   `json:"clientMutationId"`
	Reaction         Reaction  `json:"reaction"`
	Subject          Reactable `json:"subject"`
}

type Reaction struct {
	Content ReactionContent `json:"content"`
}

type Reactable struct {
	ViewerCanReact bool       `json:"viewerCanReact"`
	ReactionGroups []Reaction `json:"reactionGroups"`
}

type Error struct {
	Message string `json:"message"`
}

type ReactionContent string

const (
	ThumbsUp   ReactionContent = "THUMBS_UP"
	ThumbsDown ReactionContent = "THUMBS_DOWN"
	Laugh      ReactionContent = "LAUGH"
	Hooray     ReactionContent = "HOORAY"
	Confused   ReactionContent = "CONFUSED"
	Heart      ReactionContent = "HEART"
)

type invalidReactionContent string
func (x invalidReactionContent) Error() string { return "invalid ReactionContent: " + string(x) }

func (x *ReactionContent) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ReactionContent(value) {
	case ThumbsUp, ThumbsDown, Laugh, Hooray, Confused, Heart: *x = ReactionContent(value); return nil
	}
	return invalidReactionContent(value)
}
