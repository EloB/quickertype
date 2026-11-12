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
	Meta    Meta     `json:"meta"`
	Objects []Object `json:"objects"`
}

type Meta struct {
	Limit      int64 `json:"limit"`
	Offset     int64 `json:"offset"`
	TotalCount int64 `json:"total_count"`
}

type Object struct {
	Caucus          interface{}   `json:"caucus"`
	CongressNumbers []int64       `json:"congress_numbers"`
	Current         bool          `json:"current"`
	Description     string        `json:"description"`
	District        int64         `json:"district"`
	Enddate         string        `json:"enddate"`
	Extra           Extra         `json:"extra"`
	ID              int64         `json:"id"`
	LeadershipTitle *string       `json:"leadership_title"`
	Party           Party         `json:"party"`
	Person          Person        `json:"person"`
	Phone           string        `json:"phone"`
	RoleType        RoleType      `json:"role_type"`
	RoleTypeLabel   RoleTypeLabel `json:"role_type_label"`
	SenatorClass    interface{}   `json:"senator_class"`
	SenatorRank     interface{}   `json:"senator_rank"`
	Startdate       string        `json:"startdate"`
	State           string        `json:"state"`
	Title           Title         `json:"title"`
	TitleLong       RoleTypeLabel `json:"title_long"`
	Website         string        `json:"website"`
}

type Extra struct {
	Address     string  `json:"address"`
	ContactForm *string `json:"contact_form,omitempty"`
	Fax         *string `json:"fax"`
	Office      string  `json:"office"`
	RSSURL      *string `json:"rss_url,omitempty"`
}

type Person struct {
	Bioguideid  string      `json:"bioguideid"`
	Birthday    string      `json:"birthday"`
	Cspanid     int64       `json:"cspanid"`
	Firstname   string      `json:"firstname"`
	Gender      Gender      `json:"gender"`
	GenderLabel GenderLabel `json:"gender_label"`
	ID          int64       `json:"id"`
	Lastname    string      `json:"lastname"`
	Link        string      `json:"link"`
	Middlename  string      `json:"middlename"`
	Name        string      `json:"name"`
	Namemod     Namemod     `json:"namemod"`
	Nickname    string      `json:"nickname"`
	Osid        string      `json:"osid"`
	Pvsid       *string     `json:"pvsid"`
	Sortname    string      `json:"sortname"`
	Twitterid   *string     `json:"twitterid"`
	Youtubeid   *string     `json:"youtubeid"`
}

type Party string

const (
	Republican Party = "Republican"
	Democrat   Party = "Democrat"
)

type invalidParty string
func (x invalidParty) Error() string { return "invalid Party: " + string(x) }

func (x *Party) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Party(value) {
	case Republican, Democrat: *x = Party(value); return nil
	}
	return invalidParty(value)
}

type Gender string

const (
	Male   Gender = "male"
	Female Gender = "female"
)

type invalidGender string
func (x invalidGender) Error() string { return "invalid Gender: " + string(x) }

func (x *Gender) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Gender(value) {
	case Male, Female: *x = Gender(value); return nil
	}
	return invalidGender(value)
}

type GenderLabel string

const (
	GenderLabelMale   GenderLabel = "Male"
	GenderLabelFemale GenderLabel = "Female"
)

type invalidGenderLabel string
func (x invalidGenderLabel) Error() string { return "invalid GenderLabel: " + string(x) }

func (x *GenderLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GenderLabel(value) {
	case GenderLabelMale, GenderLabelFemale: *x = GenderLabel(value); return nil
	}
	return invalidGenderLabel(value)
}

type Namemod string

const (
	Empty Namemod = ""
	Jr    Namemod = "Jr."
	Ii    Namemod = "II"
	Iii   Namemod = "III"
	Iv    Namemod = "IV"
)

type invalidNamemod string
func (x invalidNamemod) Error() string { return "invalid Namemod: " + string(x) }

func (x *Namemod) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Namemod(value) {
	case Empty, Jr, Ii, Iii, Iv: *x = Namemod(value); return nil
	}
	return invalidNamemod(value)
}

type RoleType string

const (
	Representative RoleType = "representative"
)

type invalidRoleType string
func (x invalidRoleType) Error() string { return "invalid RoleType: " + string(x) }

func (x *RoleType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RoleType(value) {
	case Representative: *x = RoleType(value); return nil
	}
	return invalidRoleType(value)
}

type RoleTypeLabel string

const (
	RoleTypeLabelRepresentative RoleTypeLabel = "Representative"
	Delegate                    RoleTypeLabel = "Delegate"
	ResidentCommissioner        RoleTypeLabel = "Resident Commissioner"
)

type invalidRoleTypeLabel string
func (x invalidRoleTypeLabel) Error() string { return "invalid RoleTypeLabel: " + string(x) }

func (x *RoleTypeLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RoleTypeLabel(value) {
	case RoleTypeLabelRepresentative, Delegate, ResidentCommissioner: *x = RoleTypeLabel(value); return nil
	}
	return invalidRoleTypeLabel(value)
}

type Title string

const (
	Rep     Title = "Rep."
	Commish Title = "Commish."
)

type invalidTitle string
func (x invalidTitle) Error() string { return "invalid Title: " + string(x) }

func (x *Title) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Title(value) {
	case Rep, Commish: *x = Title(value); return nil
	}
	return invalidTitle(value)
}
