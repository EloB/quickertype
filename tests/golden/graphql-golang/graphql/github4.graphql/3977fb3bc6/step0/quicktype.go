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
	Viewer User `json:"viewer"`
}

type User struct {
	Login      string      `json:"login"`
	Name       *string     `json:"name"`
	Repository *Repository `json:"repository"`
}

type Repository struct {
	PullRequests PullRequestConnection `json:"pullRequests"`
}

type PullRequestConnection struct {
	Nodes []*PullRequest `json:"nodes"`
}

type PullRequest struct {
	State PullRequestState `json:"state"`
}

type Error struct {
	Message string `json:"message"`
}

type PullRequestState string

const (
	Open   PullRequestState = "OPEN"
	Closed PullRequestState = "CLOSED"
	Merged PullRequestState = "MERGED"
)

type invalidPullRequestState string
func (x invalidPullRequestState) Error() string { return "invalid PullRequestState: " + string(x) }

func (x *PullRequestState) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PullRequestState(value) {
	case Open, Closed, Merged: *x = PullRequestState(value); return nil
	}
	return invalidPullRequestState(value)
}
