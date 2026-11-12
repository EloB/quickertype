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
	Repository *Repository `json:"repository"`
}

type Repository struct {
	NameWithOwner string              `json:"nameWithOwner"`
	N303          *IssueOrPullRequest `json:"n303"`
	N307          *IssueOrPullRequest `json:"n307"`
}

type IssueOrPullRequest struct {
	Title  *string     `json:"title,omitempty"`
	State  *IssueState `json:"state,omitempty"`
	Merged *bool       `json:"merged,omitempty"`
}

type Error struct {
	Message string `json:"message"`
}

type IssueState string

const (
	Open   IssueState = "OPEN"
	Closed IssueState = "CLOSED"
)

type invalidIssueState string
func (x invalidIssueState) Error() string { return "invalid IssueState: " + string(x) }

func (x *IssueState) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch IssueState(value) {
	case Open, Closed: *x = IssueState(value); return nil
	}
	return invalidIssueState(value)
}
