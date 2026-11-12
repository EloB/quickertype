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
	Data       []Datum    `json:"data"`
	Meta       Meta       `json:"meta"`
	Pagination Pagination `json:"pagination"`
}

type Datum struct {
	BitlyGIFURL      string `json:"bitly_gif_url"`
	BitlyURL         string `json:"bitly_url"`
	ContentURL       string `json:"content_url"`
	EmbedURL         string `json:"embed_url"`
	ID               string `json:"id"`
	Images           Images `json:"images"`
	ImportDatetime   string `json:"import_datetime"`
	IsIndexable      int64  `json:"is_indexable"`
	Rating           Rating `json:"rating"`
	Slug             string `json:"slug"`
	Source           string `json:"source"`
	SourcePostURL    string `json:"source_post_url"`
	SourceTLD        string `json:"source_tld"`
	TrendingDatetime string `json:"trending_datetime"`
	Type             Type   `json:"type"`
	URL              string `json:"url"`
	User             *User  `json:"user,omitempty"`
	Username         string `json:"username"`
}

type Images struct {
	Downsized              Downsized      `json:"downsized"`
	DownsizedLarge         Downsized      `json:"downsized_large"`
	DownsizedMedium        Downsized      `json:"downsized_medium"`
	DownsizedSmall         DownsizedSmall `json:"downsized_small"`
	DownsizedStill         Downsized      `json:"downsized_still"`
	FixedHeight            FixedHeight    `json:"fixed_height"`
	FixedHeightDownsampled FixedHeight    `json:"fixed_height_downsampled"`
	FixedHeightSmall       FixedHeight    `json:"fixed_height_small"`
	FixedHeightSmallStill  Downsized      `json:"fixed_height_small_still"`
	FixedHeightStill       Downsized      `json:"fixed_height_still"`
	FixedWidth             FixedHeight    `json:"fixed_width"`
	FixedWidthDownsampled  FixedHeight    `json:"fixed_width_downsampled"`
	FixedWidthSmall        FixedHeight    `json:"fixed_width_small"`
	FixedWidthSmallStill   Downsized      `json:"fixed_width_small_still"`
	FixedWidthStill        Downsized      `json:"fixed_width_still"`
	Looping                Looping        `json:"looping"`
	Original               FixedHeight    `json:"original"`
	OriginalMp4            DownsizedSmall `json:"original_mp4"`
	OriginalStill          Downsized      `json:"original_still"`
	Preview                DownsizedSmall `json:"preview"`
	PreviewGIF             Downsized      `json:"preview_gif"`
	PreviewWebp            Downsized      `json:"preview_webp"`
}

type Downsized struct {
	Height string  `json:"height"`
	Size   *string `json:"size,omitempty"`
	URL    string  `json:"url"`
	Width  string  `json:"width"`
}

type DownsizedSmall struct {
	Height  string `json:"height"`
	Mp4     string `json:"mp4"`
	Mp4Size string `json:"mp4_size"`
	Width   string `json:"width"`
}

type FixedHeight struct {
	Frames   *string `json:"frames,omitempty"`
	Height   string  `json:"height"`
	Mp4      *string `json:"mp4,omitempty"`
	Mp4Size  *string `json:"mp4_size,omitempty"`
	Size     string  `json:"size"`
	URL      string  `json:"url"`
	Webp     string  `json:"webp"`
	WebpSize string  `json:"webp_size"`
	Width    string  `json:"width"`
}

type Looping struct {
	Mp4     string `json:"mp4"`
	Mp4Size string `json:"mp4_size"`
}

type User struct {
	AvatarURL   string `json:"avatar_url"`
	BannerURL   string `json:"banner_url"`
	DisplayName string `json:"display_name"`
	ProfileURL  string `json:"profile_url"`
	Twitter     string `json:"twitter"`
	Username    string `json:"username"`
}

type Meta struct {
	Msg        string `json:"msg"`
	ResponseID string `json:"response_id"`
	Status     int64  `json:"status"`
}

type Pagination struct {
	Count      int64 `json:"count"`
	Offset     int64 `json:"offset"`
	TotalCount int64 `json:"total_count"`
}

type Rating string

const (
	G    Rating = "g"
	PG   Rating = "pg"
	Y    Rating = "y"
	PG13 Rating = "pg-13"
)

type invalidRating string
func (x invalidRating) Error() string { return "invalid Rating: " + string(x) }

func (x *Rating) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Rating(value) {
	case G, PG, Y, PG13: *x = Rating(value); return nil
	}
	return invalidRating(value)
}

type Type string

const (
	GIF Type = "gif"
)

type invalidType string
func (x invalidType) Error() string { return "invalid Type: " + string(x) }

func (x *Type) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Type(value) {
	case GIF: *x = Type(value); return nil
	}
	return invalidType(value)
}
