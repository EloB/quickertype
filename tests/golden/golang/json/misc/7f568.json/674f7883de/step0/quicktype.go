// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	Comments    int64           `json:"comments"`
	CommentsURL string          `json:"comments_url"`
	CommitsURL  string          `json:"commits_url"`
	CreatedAt   time.Time       `json:"created_at"`
	Description *string         `json:"description"`
	Files       map[string]File `json:"files"`
	ForksURL    string          `json:"forks_url"`
	GitPullURL  string          `json:"git_pull_url"`
	GitPushURL  string          `json:"git_push_url"`
	HTMLURL     string          `json:"html_url"`
	ID          string          `json:"id"`
	Public      bool            `json:"public"`
	Truncated   bool            `json:"truncated"`
	URL         string          `json:"url"`
	UpdatedAt   time.Time       `json:"updated_at"`
	User        interface{}     `json:"user"`
}

type File struct {
	Filename string    `json:"filename"`
	Language *Language `json:"language"`
	RawURL   string    `json:"raw_url"`
	Size     int64     `json:"size"`
	Type     Type      `json:"type"`
}

type Language string

const (
	Markdown Language = "Markdown"
)

type invalidLanguage string
func (x invalidLanguage) Error() string { return "invalid Language: " + string(x) }

func (x *Language) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Language(value) {
	case Markdown: *x = Language(value); return nil
	}
	return invalidLanguage(value)
}

type Type string

const (
	TextPlain Type = "text/plain"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case TextPlain: *x = Type(value); return nil
	}
	return invalidType(value)
}
