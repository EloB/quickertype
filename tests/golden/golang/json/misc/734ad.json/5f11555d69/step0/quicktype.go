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
	Count    int64    `json:"count"`
	Facets   Facets   `json:"facets"`
	Limit    int64    `json:"limit"`
	Next     string   `json:"next"`
	Offset   int64    `json:"offset"`
	Previous bool     `json:"previous"`
	Results  []Result `json:"results"`
}

type Facets struct {
}

type Result struct {
	Acronym                   *string     `json:"acronym"`
	ActivityConsultCommittees string      `json:"activity_consult_committees"`
	ActivityEuLegislative     string      `json:"activity_eu_legislative"`
	ActivityExpertGroups      string      `json:"activity_expert_groups"`
	ActivityHighLevelGroups   string      `json:"activity_high_level_groups"`
	ActivityIndustryForums    string      `json:"activity_industry_forums"`
	ActivityInterGroups       string      `json:"activity_inter_groups"`
	ActivityOther             *string     `json:"activity_other"`
	ActivityRelevantComm      string      `json:"activity_relevant_comm"`
	BeOfficeCountry           *string     `json:"be_office_country,omitempty"`
	BeOfficeLat               *float64    `json:"be_office_lat"`
	BeOfficeLon               *float64    `json:"be_office_lon"`
	BeOfficePhone             *string     `json:"be_office_phone,omitempty"`
	BeOfficePostCode          *string     `json:"be_office_post_code"`
	BeOfficePostbox           *string     `json:"be_office_postbox"`
	BeOfficeStreet            *string     `json:"be_office_street,omitempty"`
	BeOfficeTown              *string     `json:"be_office_town,omitempty"`
	CodeOfConduct             string      `json:"code_of_conduct"`
	ContactCountry            int64       `json:"contact_country"`
	CreatedAt                 time.Time   `json:"created_at"`
	Entity                    string      `json:"entity"`
	Goals                     string      `json:"goals"`
	Head                      string      `json:"head"`
	HeadOfficeCountry         string      `json:"head_office_country"`
	HeadOfficeLat             *float64    `json:"head_office_lat"`
	HeadOfficeLon             *float64    `json:"head_office_lon"`
	HeadOfficePhone           string      `json:"head_office_phone"`
	HeadOfficePostCode        *string     `json:"head_office_post_code"`
	HeadOfficePostbox         *string     `json:"head_office_postbox"`
	HeadOfficeStreet          string      `json:"head_office_street"`
	HeadOfficeTown            string      `json:"head_office_town"`
	ID                        string      `json:"id"`
	IdentificationCode        string      `json:"identification_code"`
	InfoMembers               string      `json:"info_members"`
	LastUpdateDate            time.Time   `json:"last_update_date"`
	Legal                     string      `json:"legal"`
	LegalStatus               string      `json:"legal_status"`
	MainCategory              int64       `json:"main_category"`
	MainCategoryTitle         string      `json:"main_category_title"`
	Members                   int64       `json:"members"`
	Members100                *int64      `json:"members_100"`
	Members25                 *int64      `json:"members_25"`
	Members50                 *int64      `json:"members_50"`
	Members75                 *int64      `json:"members_75"`
	MembersFte                float64     `json:"members_fte"`
	Name                      string      `json:"name"`
	NativeName                interface{} `json:"native_name"`
	Networking                *string     `json:"networking"`
	NumberOfNaturalPersons    *int64      `json:"number_of_natural_persons"`
	OtherCodeOfConduct        *string     `json:"other_code_of_conduct"`
	RegistrationDate          time.Time   `json:"registration_date"`
	Status                    Status      `json:"status"`
	StructureMembers          string      `json:"structure_members"`
	SubCategory               int64       `json:"sub_category"`
	SubCategoryTitle          string      `json:"sub_category_title"`
	URI                       string      `json:"uri"`
	UpdatedAt                 time.Time   `json:"updated_at"`
	WebSiteURL                *string     `json:"web_site_url"`
}

type Status string

const (
	Active   Status = "active"
	Inactive Status = "inactive"
)

type invalidStatus string
func (x invalidStatus) Error() string { return "invalid Status: " + string(x) }

func (x *Status) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Status(value) {
	case Active, Inactive: *x = Status(value); return nil
	}
	return invalidStatus(value)
}
