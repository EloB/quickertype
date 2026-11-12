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
	Count    int64       `json:"count"`
	Next     string      `json:"next"`
	Previous interface{} `json:"previous"`
	Results  []Result    `json:"results"`
}

type Result struct {
	Code         string       `json:"code"`
	English      string       `json:"english"`
	Fav          bool         `json:"fav"`
	Group        Group        `json:"group"`
	Location     LocationEnum `json:"location"`
	MinScreens   int64        `json:"min_screens"`
	NumViews     int64        `json:"num_views"`
	Showtimes    string       `json:"showtimes"`
	Stars        int64        `json:"stars"`
	Tel          TelEnum      `json:"tel"`
	Thai         string       `json:"thai"`
	TodayScreens int64        `json:"today_screens"`
	URL          string       `json:"url"`
	Website      string       `json:"website"`
}

type Group struct {
	Code    Code    `json:"code"`
	English English `json:"english"`
	Thai    Thai    `json:"thai"`
	Website string  `json:"website"`
}

type Code string

const (
	Sf Code = "sf"
)

type invalidCode string
func (x invalidCode) Error() string { return "invalid Code: " + string(x) }

func (x *Code) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Code(value) {
	case Sf: *x = Code(value); return nil
	}
	return invalidCode(value)
}

type English string

const (
	EnglishSF English = "SF"
)

type invalidEnglish string
func (x invalidEnglish) Error() string { return "invalid English: " + string(x) }

func (x *English) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch English(value) {
	case EnglishSF: *x = English(value); return nil
	}
	return invalidEnglish(value)
}

type Thai string

const (
	เอสเอฟ Thai = "เอสเอฟ"
)

type invalidThai string
func (x invalidThai) Error() string { return "invalid Thai: " + string(x) }

func (x *Thai) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Thai(value) {
	case เอสเอฟ: *x = Thai(value); return nil
	}
	return invalidThai(value)
}

type LocationEnum string

const (
	Location         LocationEnum = ""
	The5ThFLEmporium LocationEnum = "5th Fl. Emporium"
)

type invalidLocationEnum string
func (x invalidLocationEnum) Error() string { return "invalid LocationEnum: " + string(x) }

func (x *LocationEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch LocationEnum(value) {
	case Location, The5ThFLEmporium: *x = LocationEnum(value); return nil
	}
	return invalidLocationEnum(value)
}

type TelEnum string

const (
	Tel          TelEnum = ""
	The022688899 TelEnum = "02-268-8899"
)

type invalidTelEnum string
func (x invalidTelEnum) Error() string { return "invalid TelEnum: " + string(x) }

func (x *TelEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TelEnum(value) {
	case Tel, The022688899: *x = TelEnum(value); return nil
	}
	return invalidTelEnum(value)
}
