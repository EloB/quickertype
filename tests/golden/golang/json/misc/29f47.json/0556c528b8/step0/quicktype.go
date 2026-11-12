// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "bytes"
import "errors"

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
	Distinguished         Distinguished         `json:"distinguished"`
	Domain                Domain                `json:"domain"`
	Downs                 int64                 `json:"downs"`
	Edited                *Edited               `json:"edited"`
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
	Media                 interface{}           `json:"media"`
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
	SecureMedia           interface{}           `json:"secure_media"`
	SecureMediaEmbed      MediaEmbed            `json:"secure_media_embed"`
	Selftext              string                `json:"selftext"`
	SelftextHTML          *string               `json:"selftext_html"`
	Spoiler               bool                  `json:"spoiler"`
	Stickied              bool                  `json:"stickied"`
	Subreddit             Subreddit             `json:"subreddit"`
	SubredditID           SubredditID           `json:"subreddit_id"`
	SubredditNamePrefixed SubredditNamePrefixed `json:"subreddit_name_prefixed"`
	SubredditType         SubredditType         `json:"subreddit_type"`
	SuggestedSort         *string               `json:"suggested_sort"`
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

type MediaEmbed struct {
}

type Preview struct {
	Enabled bool           `json:"enabled"`
	Images  []ImageElement `json:"images"`
}

type ImageElement struct {
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
	GIF *GIF `json:"gif,omitempty"`
	Mp4 *GIF `json:"mp4,omitempty"`
}

type GIF struct {
	Resolutions []Source `json:"resolutions"`
	Source      Source   `json:"source"`
}

type Distinguished string

const (
	Admin Distinguished = "admin"
)

type invalidDistinguished string
func (x invalidDistinguished) Error() string { return "invalid Distinguished: " + string(x) }

func (x *Distinguished) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Distinguished(value) {
	case Admin: *x = Distinguished(value); return nil
	}
	return invalidDistinguished(value)
}

type Domain string

const (
	SelfAnnouncements Domain = "self.announcements"
	IReddIt           Domain = "i.redd.it"
)

type invalidDomain string
func (x invalidDomain) Error() string { return "invalid Domain: " + string(x) }

func (x *Domain) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Domain(value) {
	case SelfAnnouncements, IReddIt: *x = Domain(value); return nil
	}
	return invalidDomain(value)
}

type PostHint string

const (
	Self  PostHint = "self"
	Image PostHint = "image"
)

type invalidPostHint string
func (x invalidPostHint) Error() string { return "invalid PostHint: " + string(x) }

func (x *PostHint) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PostHint(value) {
	case Self, Image: *x = PostHint(value); return nil
	}
	return invalidPostHint(value)
}

type Subreddit string

const (
	Announcements Subreddit = "announcements"
)

type invalidSubreddit string
func (x invalidSubreddit) Error() string { return "invalid Subreddit: " + string(x) }

func (x *Subreddit) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Subreddit(value) {
	case Announcements: *x = Subreddit(value); return nil
	}
	return invalidSubreddit(value)
}

type SubredditID string

const (
	T52R0Ij SubredditID = "t5_2r0ij"
)

type invalidSubredditID string
func (x invalidSubredditID) Error() string { return "invalid SubredditID: " + string(x) }

func (x *SubredditID) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditID(value) {
	case T52R0Ij: *x = SubredditID(value); return nil
	}
	return invalidSubredditID(value)
}

type SubredditNamePrefixed string

const (
	RAnnouncements SubredditNamePrefixed = "r/announcements"
)

type invalidSubredditNamePrefixed string
func (x invalidSubredditNamePrefixed) Error() string { return "invalid SubredditNamePrefixed: " + string(x) }

func (x *SubredditNamePrefixed) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditNamePrefixed(value) {
	case RAnnouncements: *x = SubredditNamePrefixed(value); return nil
	}
	return invalidSubredditNamePrefixed(value)
}

type SubredditType string

const (
	Restricted SubredditType = "restricted"
)

type invalidSubredditType string
func (x invalidSubredditType) Error() string { return "invalid SubredditType: " + string(x) }

func (x *SubredditType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubredditType(value) {
	case Restricted: *x = SubredditType(value); return nil
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

type Edited struct {
	Bool   *bool
	Double *float64
}

func (x *Edited) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Edited) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
}

func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
			*pi = nil
	}
	if pf != nil {
			*pf = nil
	}
	if pb != nil {
			*pb = nil
	}
	if ps != nil {
			*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
			return false, err
	}

	switch v := tok.(type) {
	case json.Number:
			if pi != nil {
					i, err := v.Int64()
					if err == nil {
							*pi = &i
							return false, nil
					}
			}
			if pf != nil {
					f, err := v.Float64()
					if err == nil {
							*pf = &f
							return false, nil
					}
					return false, errors.New("Unparsable number")
			}
			return false, errors.New("Union does not contain number")
	case float64:
			return false, errors.New("Decoder should not return float64")
	case bool:
			if pb != nil {
					*pb = &v
					return false, nil
			}
			return false, errors.New("Union does not contain bool")
	case string:
			if haveEnum {
					return false, json.Unmarshal(data, pe)
			}
			if ps != nil {
					*ps = &v
					return false, nil
			}
			return false, errors.New("Union does not contain string")
	case nil:
			if nullable {
					return false, nil
			}
			return false, errors.New("Union does not contain null")
	case json.Delim:
			if v == '{' {
					if haveObject {
							return true, json.Unmarshal(data, pc)
					}
					if haveMap {
							return false, json.Unmarshal(data, pm)
					}
					return false, errors.New("Union does not contain object")
			}
			if v == '[' {
					if haveArray {
							return false, json.Unmarshal(data, pa)
					}
					return false, errors.New("Union does not contain array")
			}
			return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")
}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
			return json.Marshal(*pi)
	}
	if pf != nil {
			return json.Marshal(*pf)
	}
	if pb != nil {
			return json.Marshal(*pb)
	}
	if ps != nil {
			return json.Marshal(*ps)
	}
	if haveArray {
			return json.Marshal(pa)
	}
	if haveObject {
			return json.Marshal(pc)
	}
	if haveMap {
			return json.Marshal(pm)
	}
	if haveEnum {
			return json.Marshal(pe)
	}
	if nullable {
			return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}
