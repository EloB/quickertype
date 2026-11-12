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
	Metadata Metadata `json:"metadata"`
	Results  []Result `json:"results"`
}

type Metadata struct {
	ExecutionTime float64      `json:"executionTime"`
	ResponseInfo  ResponseInfo `json:"responseInfo"`
	Resultset     Resultset    `json:"resultset"`
}

type ResponseInfo struct {
	DeveloperMessage string `json:"developerMessage"`
	Status           int64  `json:"status"`
}

type Resultset struct {
	Count    int64 `json:"count"`
	Page     int64 `json:"page"`
	Pagesize int64 `json:"pagesize"`
}

type Result struct {
	AboutOffice        string      `json:"about_office"`
	ApplicationProcess string      `json:"application_process"`
	Body               string      `json:"body"`
	Changed            string      `json:"changed"`
	Created            string      `json:"created"`
	Deadline           interface{} `json:"deadline"`
	HiringOffice       interface{} `json:"hiring_office"`
	HiringOrg          HiringOrg   `json:"hiring_org"`
	JobID              interface{} `json:"job_id"`
	Language           string      `json:"language"`
	Location           Location    `json:"location"`
	NumPositions       string      `json:"num_positions"`
	Position           string      `json:"position"`
	PracticeArea       string      `json:"practice_area"`
	Qualifications     string      `json:"qualifications"`
	RelocationExpenses interface{} `json:"relocation_expenses"`
	Salary             string      `json:"salary"`
	Title              string      `json:"title"`
	Travel             string      `json:"travel"`
	URL                string      `json:"url"`
	UUID               string      `json:"uuid"`
	Vuuid              string      `json:"vuuid"`
}

type HiringOrg struct {
	Name string `json:"name"`
	UUID string `json:"uuid"`
}

type Location struct {
	AdministrativeArea   string      `json:"administrative_area"`
	Country              string      `json:"country"`
	FaxNumber            string      `json:"fax_number"`
	Locality             string      `json:"locality"`
	MobileNumber         string      `json:"mobile_number"`
	PhoneNumber          string      `json:"phone_number"`
	PhoneNumberExtension string      `json:"phone_number_extension"`
	PostalCode           string      `json:"postal_code"`
	SubPremise           interface{} `json:"sub_premise"`
	Thoroughfare         string      `json:"thoroughfare"`
}
