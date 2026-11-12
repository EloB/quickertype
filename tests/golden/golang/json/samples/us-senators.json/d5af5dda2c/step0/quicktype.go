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
	Caucus            *Party            `json:"caucus"`
	CongressNumbers   []int64           `json:"congress_numbers"`
	Current           bool              `json:"current"`
	Description       string            `json:"description"`
	District          interface{}       `json:"district"`
	Enddate           string            `json:"enddate"`
	Extra             Extra             `json:"extra"`
	LeadershipTitle   *string           `json:"leadership_title"`
	Party             Party             `json:"party"`
	Person            Person            `json:"person"`
	Phone             string            `json:"phone"`
	RoleType          RoleType          `json:"role_type"`
	RoleTypeLabel     RoleTypeLabel     `json:"role_type_label"`
	SenatorClass      SenatorClass      `json:"senator_class"`
	SenatorClassLabel SenatorClassLabel `json:"senator_class_label"`
	SenatorRank       SenatorRank       `json:"senator_rank"`
	SenatorRankLabel  SenatorRankLabel  `json:"senator_rank_label"`
	Startdate         string            `json:"startdate"`
	State             string            `json:"state"`
	Title             Title             `json:"title"`
	TitleLong         RoleTypeLabel     `json:"title_long"`
	Website           string            `json:"website"`
}

type Extra struct {
	Address     string  `json:"address"`
	ContactForm string  `json:"contact_form"`
	Fax         *string `json:"fax,omitempty"`
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
	Lastname    string      `json:"lastname"`
	Link        string      `json:"link"`
	Middlename  string      `json:"middlename"`
	Name        string      `json:"name"`
	Namemod     Namemod     `json:"namemod"`
	Nickname    string      `json:"nickname"`
	Osid        string      `json:"osid"`
	Pvsid       string      `json:"pvsid"`
	Sortname    string      `json:"sortname"`
	Twitterid   *string     `json:"twitterid"`
	Youtubeid   *string     `json:"youtubeid"`
}

type Party string

const (
	Democrat    Party = "Democrat"
	Republican  Party = "Republican"
	Independent Party = "Independent"
)

type invalidParty string
func (x invalidParty) Error() string { return "invalid Party: " + string(x) }

func (x *Party) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Party(value) {
	case Democrat, Republican, Independent: *x = Party(value); return nil
	}
	return invalidParty(value)
}

type Gender string

const (
	Female Gender = "female"
	Male   Gender = "male"
)

type invalidGender string
func (x invalidGender) Error() string { return "invalid Gender: " + string(x) }

func (x *Gender) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Gender(value) {
	case Female, Male: *x = Gender(value); return nil
	}
	return invalidGender(value)
}

type GenderLabel string

const (
	GenderLabelFemale GenderLabel = "Female"
	GenderLabelMale   GenderLabel = "Male"
)

type invalidGenderLabel string
func (x invalidGenderLabel) Error() string { return "invalid GenderLabel: " + string(x) }

func (x *GenderLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GenderLabel(value) {
	case GenderLabelFemale, GenderLabelMale: *x = GenderLabel(value); return nil
	}
	return invalidGenderLabel(value)
}

type Namemod string

const (
	Empty Namemod = ""
	Jr    Namemod = "Jr."
	Iii   Namemod = "III"
)

type invalidNamemod string
func (x invalidNamemod) Error() string { return "invalid Namemod: " + string(x) }

func (x *Namemod) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Namemod(value) {
	case Empty, Jr, Iii: *x = Namemod(value); return nil
	}
	return invalidNamemod(value)
}

type RoleType string

const (
	Senator RoleType = "senator"
)

type invalidRoleType string
func (x invalidRoleType) Error() string { return "invalid RoleType: " + string(x) }

func (x *RoleType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RoleType(value) {
	case Senator: *x = RoleType(value); return nil
	}
	return invalidRoleType(value)
}

type RoleTypeLabel string

const (
	RoleTypeLabelSenator RoleTypeLabel = "Senator"
)

type invalidRoleTypeLabel string
func (x invalidRoleTypeLabel) Error() string { return "invalid RoleTypeLabel: " + string(x) }

func (x *RoleTypeLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RoleTypeLabel(value) {
	case RoleTypeLabelSenator: *x = RoleTypeLabel(value); return nil
	}
	return invalidRoleTypeLabel(value)
}

type SenatorClass string

const (
	Class1 SenatorClass = "class1"
	Class2 SenatorClass = "class2"
	Class3 SenatorClass = "class3"
)

type invalidSenatorClass string
func (x invalidSenatorClass) Error() string { return "invalid SenatorClass: " + string(x) }

func (x *SenatorClass) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SenatorClass(value) {
	case Class1, Class2, Class3: *x = SenatorClass(value); return nil
	}
	return invalidSenatorClass(value)
}

type SenatorClassLabel string

const (
	SenatorClassLabelClass1 SenatorClassLabel = "Class 1"
	SenatorClassLabelClass2 SenatorClassLabel = "Class 2"
	SenatorClassLabelClass3 SenatorClassLabel = "Class 3"
)

type invalidSenatorClassLabel string
func (x invalidSenatorClassLabel) Error() string { return "invalid SenatorClassLabel: " + string(x) }

func (x *SenatorClassLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SenatorClassLabel(value) {
	case SenatorClassLabelClass1, SenatorClassLabelClass2, SenatorClassLabelClass3: *x = SenatorClassLabel(value); return nil
	}
	return invalidSenatorClassLabel(value)
}

type SenatorRank string

const (
	Junior SenatorRank = "junior"
	Senior SenatorRank = "senior"
)

type invalidSenatorRank string
func (x invalidSenatorRank) Error() string { return "invalid SenatorRank: " + string(x) }

func (x *SenatorRank) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SenatorRank(value) {
	case Junior, Senior: *x = SenatorRank(value); return nil
	}
	return invalidSenatorRank(value)
}

type SenatorRankLabel string

const (
	SenatorRankLabelJunior SenatorRankLabel = "Junior"
	SenatorRankLabelSenior SenatorRankLabel = "Senior"
)

type invalidSenatorRankLabel string
func (x invalidSenatorRankLabel) Error() string { return "invalid SenatorRankLabel: " + string(x) }

func (x *SenatorRankLabel) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SenatorRankLabel(value) {
	case SenatorRankLabelJunior, SenatorRankLabelSenior: *x = SenatorRankLabel(value); return nil
	}
	return invalidSenatorRankLabel(value)
}

type Title string

const (
	Sen Title = "Sen."
)

type invalidTitle string
func (x invalidTitle) Error() string { return "invalid Title: " + string(x) }

func (x *Title) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Title(value) {
	case Sen: *x = Title(value); return nil
	}
	return invalidTitle(value)
}
