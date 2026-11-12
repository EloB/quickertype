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
	Login               string               `json:"login"`
	StarredRepositories Connection           `json:"starredRepositories"`
	Repositories        RepositoryConnection `json:"repositories"`
}

type RepositoryConnection struct {
	Edges []*RepositoryEdge `json:"edges"`
}

type RepositoryEdge struct {
	Node *Repository `json:"node"`
}

type Repository struct {
	Name       string     `json:"name"`
	Stargazers Connection `json:"stargazers"`
	Forks      Connection `json:"forks"`
	Watchers   Connection `json:"watchers"`
	Issues     Connection `json:"issues"`
}

type Connection struct {
	TotalCount int64 `json:"totalCount"`
}

type Error struct {
	Message string `json:"message"`
}
