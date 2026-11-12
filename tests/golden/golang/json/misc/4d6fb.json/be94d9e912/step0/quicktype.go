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
	Data TopLevelData `json:"data"`
	Kind string       `json:"kind"`
}

type TopLevelData struct {
	After    string      `json:"after"`
	Before   interface{} `json:"before"`
	Children []Child     `json:"children"`
	Modhash  string      `json:"modhash"`
}

type Child struct {
	Data ChildData `json:"data"`
	Kind Kind      `json:"kind"`
}

type ChildData struct {
	ApprovedAtUTC         interface{}           `json:"approved_at_utc"`
	ApprovedBy            interface{}           `json:"approved_by"`
	Archived              bool                  `json:"archived"`
	Author                string                `json:"author"`
	AuthorFlairCSSClass   interface{}           `json:"author_flair_css_class"`
	AuthorFlairText       interface{}           `json:"author_flair_text"`
	BannedAtUTC           interface{}           `json:"banned_at_utc"`
	BannedBy              interface{}           `json:"banned_by"`
	BrandSafe             bool                  `json:"brand_safe"`
	CanGild               bool                  `json:"can_gild"`
	CanModPost            bool                  `json:"can_mod_post"`
	Clicked               bool                  `json:"clicked"`
	ContestMode           bool                  `json:"contest_mode"`
	Created               float64               `json:"created"`
	CreatedUTC            float64               `json:"created_utc"`
	Distinguished         interface{}           `json:"distinguished"`
	Domain                string                `json:"domain"`
	Downs                 int64                 `json:"downs"`
	Edited                bool                  `json:"edited"`
	Gilded                int64                 `json:"gilded"`
	Hidden                bool                  `json:"hidden"`
	HideScore             bool                  `json:"hide_score"`
	ID                    string                `json:"id"`
	IsSelf                bool                  `json:"is_self"`
	IsVideo               bool                  `json:"is_video"`
	Likes                 interface{}           `json:"likes"`
	LinkFlairCSSClass     interface{}           `json:"link_flair_css_class"`
	LinkFlairText         interface{}           `json:"link_flair_text"`
	Locked                bool                  `json:"locked"`
	Media                 *Media                `json:"media"`
	MediaEmbed            MediaEmbed            `json:"media_embed"`
	ModReports            []interface{}         `json:"mod_reports"`
	Name                  string                `json:"name"`
	NumComments           int64                 `json:"num_comments"`
	NumReports            interface{}           `json:"num_reports"`
	Over18                bool                  `json:"over_18"`
	Permalink             string                `json:"permalink"`
	PostHint              *PostHint             `json:"post_hint,omitempty"`
	Preview               *Preview              `json:"preview,omitempty"`
	Quarantine            bool                  `json:"quarantine"`
	RemovalReason         interface{}           `json:"removal_reason"`
	ReportReasons         interface{}           `json:"report_reasons"`
	Saved                 bool                  `json:"saved"`
	Score                 int64                 `json:"score"`
	SecureMedia           *Media                `json:"secure_media"`
	SecureMediaEmbed      MediaEmbed            `json:"secure_media_embed"`
	Selftext              string                `json:"selftext"`
	SelftextHTML          interface{}           `json:"selftext_html"`
	Spoiler               bool                  `json:"spoiler"`
	Stickied              bool                  `json:"stickied"`
	Subreddit             Subreddit             `json:"subreddit"`
	SubredditID           SubredditID           `json:"subreddit_id"`
	SubredditNamePrefixed SubredditNamePrefixed `json:"subreddit_name_prefixed"`
	SubredditType         SubredditType         `json:"subreddit_type"`
	SuggestedSort         interface{}           `json:"suggested_sort"`
	Thumbnail             string                `json:"thumbnail"`
	ThumbnailHeight       *int64                `json:"thumbnail_height"`
	ThumbnailWidth        *int64                `json:"thumbnail_width"`
	Title                 string                `json:"title"`
	UPS                   int64                 `json:"ups"`
	URL                   string                `json:"url"`
	UserReports           []interface{}         `json:"user_reports"`
	ViewCount             interface{}           `json:"view_count"`
	Visited               bool                  `json:"visited"`
}

type Media struct {
	Oembed Oembed `json:"oembed"`
	Type   string `json:"type"`
}

type Oembed struct {
	AuthorName      string `json:"author_name"`
	AuthorURL       string `json:"author_url"`
	HTML            string `json:"html"`
	Height          int64  `json:"height"`
	ProviderName    string `json:"provider_name"`
	ProviderURL     string `json:"provider_url"`
	ThumbnailHeight int64  `json:"thumbnail_height"`
	ThumbnailURL    string `json:"thumbnail_url"`
	ThumbnailWidth  int64  `json:"thumbnail_width"`
	Title           string `json:"title"`
	Type            string `json:"type"`
	Version         string `json:"version"`
	Width           int64  `json:"width"`
}

type MediaEmbed struct {
	Content   *string `json:"content,omitempty"`
	Height    *int64  `json:"height,omitempty"`
	Scrolling *bool   `json:"scrolling,omitempty"`
	Width     *int64  `json:"width,omitempty"`
}

type Preview struct {
	Enabled bool    `json:"enabled"`
	Images  []Image `json:"images"`
}

type Image struct {
	ID          string   `json:"id"`
	Resolutions []Source `json:"resolutions"`
	Source      Source   `json:"source"`
	Variants    Variants `json:"variants"`
}

type Source struct {
	Height int64  `json:"height"`
	URL    string `json:"url"`
	Width  int64  `json:"width"`
}

type Variants struct {
}

type PostHint string

const (
	RichVideo PostHint = "rich:video"
	Link      PostHint = "link"
)

type invalidPostHint string
func (x invalidPostHint) Error() string { return "invalid PostHint: " + string(x) }

func (x *PostHint) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PostHint(value) {
	case RichVideo, Link: *x = PostHint(value); return nil
	}
	return invalidPostHint(value)
}

type Subreddit string

const (
	Todayilearned Subreddit = "todayilearned"
)

type invalidSubreddit string
func (x invalidSubreddit) Error() string { return "invalid Subreddit: " + string(x) }

func (x *Subreddit) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Subreddit(value) {
	case Todayilearned: *x = Subreddit(value); return nil
	}
	return invalidSubreddit(value)
}

type SubredditID string

const (
	T52Qqjc SubredditID = "t5_2qqjc"
)

type invalidSubredditID string
func (x invalidSubredditID) Error() string { return "invalid SubredditID: " + string(x) }

func (x *SubredditID) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditID(value) {
	case T52Qqjc: *x = SubredditID(value); return nil
	}
	return invalidSubredditID(value)
}

type SubredditNamePrefixed string

const (
	RTodayilearned SubredditNamePrefixed = "r/todayilearned"
)

type invalidSubredditNamePrefixed string
func (x invalidSubredditNamePrefixed) Error() string { return "invalid SubredditNamePrefixed: " + string(x) }

func (x *SubredditNamePrefixed) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditNamePrefixed(value) {
	case RTodayilearned: *x = SubredditNamePrefixed(value); return nil
	}
	return invalidSubredditNamePrefixed(value)
}

type SubredditType string

const (
	Public SubredditType = "public"
)

type invalidSubredditType string
func (x invalidSubredditType) Error() string { return "invalid SubredditType: " + string(x) }

func (x *SubredditType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditType(value) {
	case Public: *x = SubredditType(value); return nil
	}
	return invalidSubredditType(value)
}

type Kind string

const (
	T3 Kind = "t3"
)

type invalidKind string
func (x invalidKind) Error() string { return "invalid Kind: " + string(x) }

func (x *Kind) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Kind(value) {
	case T3: *x = Kind(value); return nil
	}
	return invalidKind(value)
}
