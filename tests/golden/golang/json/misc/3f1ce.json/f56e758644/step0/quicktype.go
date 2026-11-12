// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

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
	Query Query `json:"query"`
}

type Query struct {
	Count   int64     `json:"count"`
	Created time.Time `json:"created"`
	Lang    string    `json:"lang"`
	Results Results   `json:"results"`
}

type Results struct {
	Channel Channel `json:"channel"`
}

type Channel struct {
	Astronomy     Astronomy  `json:"astronomy"`
	Atmosphere    Atmosphere `json:"atmosphere"`
	Description   string     `json:"description"`
	Image         Image      `json:"image"`
	Item          Item       `json:"item"`
	Language      string     `json:"language"`
	LastBuildDate string     `json:"lastBuildDate"`
	Link          string     `json:"link"`
	Location      Location   `json:"location"`
	TTL           string     `json:"ttl"`
	Title         string     `json:"title"`
	Units         Units      `json:"units"`
	Wind          Wind       `json:"wind"`
}

type Astronomy struct {
	Sunrise string `json:"sunrise"`
	Sunset  string `json:"sunset"`
}

type Atmosphere struct {
	Humidity   string `json:"humidity"`
	Pressure   string `json:"pressure"`
	Rising     string `json:"rising"`
	Visibility string `json:"visibility"`
}

type Image struct {
	Height string `json:"height"`
	Link   string `json:"link"`
	Title  string `json:"title"`
	URL    string `json:"url"`
	Width  string `json:"width"`
}

type Item struct {
	Condition   Condition  `json:"condition"`
	Description string     `json:"description"`
	Forecast    []Forecast `json:"forecast"`
	GUID        GUID       `json:"guid"`
	Lat         string     `json:"lat"`
	Link        string     `json:"link"`
	Long        string     `json:"long"`
	PubDate     string     `json:"pubDate"`
	Title       string     `json:"title"`
}

type Condition struct {
	Code string `json:"code"`
	Date string `json:"date"`
	Temp string `json:"temp"`
	Text string `json:"text"`
}

type Forecast struct {
	Code string `json:"code"`
	Date string `json:"date"`
	Day  string `json:"day"`
	High string `json:"high"`
	Low  string `json:"low"`
	Text Text   `json:"text"`
}

type GUID struct {
	IsPermaLink string `json:"isPermaLink"`
}

type Location struct {
	City    string `json:"city"`
	Country string `json:"country"`
	Region  string `json:"region"`
}

type Units struct {
	Distance    string `json:"distance"`
	Pressure    string `json:"pressure"`
	Speed       string `json:"speed"`
	Temperature string `json:"temperature"`
}

type Wind struct {
	Chill     string `json:"chill"`
	Direction string `json:"direction"`
	Speed     string `json:"speed"`
}

type Text string

const (
	Thunderstorms Text = "Thunderstorms"
)

type invalidText string
func (x invalidText) Error() string { return "invalid Text: " + string(x) }

func (x *Text) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Text(value) {
	case Thunderstorms: *x = Text(value); return nil
	}
	return invalidText(value)
}
