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
	Category              Category         `json:"category"`
	Details               Details          `json:"details"`
	Match                 string           `json:"match"`
	Page                  int64            `json:"page"`
	Product               []ProductElement `json:"product"`
	Schk                  bool             `json:"schk"`
	Totallooseoffers      int64            `json:"totallooseoffers"`
	Totalpages            int64            `json:"totalpages"`
	Totalresultsavailable int64            `json:"totalresultsavailable"`
	Totalresultsreturned  int64            `json:"totalresultsreturned"`
}

type Category struct {
	Concatenatecategoryname bool              `json:"concatenatecategoryname"`
	Hasoffer                bool              `json:"hasoffer"`
	ID                      int64             `json:"id"`
	Isfinal                 bool              `json:"isfinal"`
	Links                   []LinkElement     `json:"links"`
	Name                    string            `json:"name"`
	Parentcategoryid        int64             `json:"parentcategoryid"`
	Thumbnail               CategoryThumbnail `json:"thumbnail"`
}

type LinkElement struct {
	Link LinkLink `json:"link"`
}

type LinkLink struct {
	Type string `json:"type"`
	URL  string `json:"url"`
}

type CategoryThumbnail struct {
	URL string `json:"url"`
}

type Details struct {
	Applicationid      string `json:"applicationid"`
	Applicationversion string `json:"applicationversion"`
	Code               int64  `json:"code"`
	Date               Date   `json:"date"`
	Elapsedtime        int64  `json:"elapsedtime"`
	Message            string `json:"message"`
	Status             string `json:"status"`
}

type Date struct {
	Day           int64         `json:"day"`
	Eonandyear    Eonandyear    `json:"eonandyear"`
	Hour          int64         `json:"hour"`
	Millisecond   int64         `json:"millisecond"`
	Minute        int64         `json:"minute"`
	Month         int64         `json:"month"`
	Second        int64         `json:"second"`
	Timezone      int64         `json:"timezone"`
	Valid         bool          `json:"valid"`
	Xmlschematype Xmlschematype `json:"xmlschematype"`
	Year          int64         `json:"year"`
}

type Eonandyear struct {
	Lowestsetbit int64 `json:"lowestsetbit"`
}

type Xmlschematype struct {
	Localpart    string `json:"localpart"`
	Namespaceuri string `json:"namespaceuri"`
	Prefix       string `json:"prefix"`
}

type ProductElement struct {
	Product ProductProduct `json:"product"`
}

type ProductProduct struct {
	Categoryid      int64         `json:"categoryid"`
	Currency        Currency      `json:"currency"`
	Eco             bool          `json:"eco"`
	Fulldescription bool          `json:"fulldescription"`
	Hasmetasearch   bool          `json:"hasmetasearch"`
	ID              int64         `json:"id"`
	Links           []LinkElement `json:"links"`
	Numoffers       int64         `json:"numoffers"`
	Pricemax        string        `json:"pricemax"`
	Pricemin        string        `json:"pricemin"`
	Productname     string        `json:"productname"`
	Quantity        int64         `json:"quantity"`
	Rating          Rating        `json:"rating"`
	Specification   Specification `json:"specification"`
	Thumbnail       FormatsClass  `json:"thumbnail"`
	Totalsellers    int64         `json:"totalsellers"`
}

type Currency struct {
	Abbreviation string `json:"abbreviation"`
}

type Rating struct {
	Useraveragerating Useraveragerating `json:"useraveragerating"`
}

type Useraveragerating struct {
	Links       []LinkElement `json:"links"`
	Numcomments int64         `json:"numcomments"`
	Rating      string        `json:"rating"`
}

type Specification struct {
	Links []LinkElement `json:"links"`
}

type Format struct {
	Formats FormatsClass `json:"formats"`
}

type FormatsClass struct {
	Formats *[]Format `json:"formats,omitempty"`
	Height  int64     `json:"height"`
	URL     string    `json:"url"`
	Width   int64     `json:"width"`
}
