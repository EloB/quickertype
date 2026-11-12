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
	CostAbsolute                 *int64         `json:"cost_absolute"`
	CostMax                      *int64         `json:"cost_max"`
	CostMin                      *int64         `json:"cost_min"`
	CreatedAt                    time.Time      `json:"created_at"`
	CustomIncomes                []CustomIncome `json:"customIncomes"`
	DirectRepCostsMax            interface{}    `json:"direct_rep_costs_max"`
	DirectRepCostsMin            interface{}    `json:"direct_rep_costs_min"`
	EndDate                      time.Time      `json:"end_date"`
	EurSourcesGrants             int64          `json:"eur_sources_grants"`
	EurSourcesGrantsSrc          *string        `json:"eur_sources_grants_src"`
	EurSourcesProcurement        int64          `json:"eur_sources_procurement"`
	EurSourcesProcurementSrc     *string        `json:"eur_sources_procurement_src"`
	ID                           string         `json:"id"`
	NewOrganisation              interface{}    `json:"new_organisation"`
	NoClients                    *string        `json:"no_clients"`
	OtherFinancialInformation    *string        `json:"other_financial_information"`
	OtherSourcesContributions    *int64         `json:"other_sources_contributions"`
	OtherSourcesDonation         *int64         `json:"other_sources_donation"`
	OtherSourcesTotal            *int64         `json:"other_sources_total"`
	PublicFinancingInfranational *int64         `json:"public_financing_infranational"`
	PublicFinancingNational      *int64         `json:"public_financing_national"`
	PublicFinancingTotal         *int64         `json:"public_financing_total"`
	Representative               string         `json:"representative"`
	StartDate                    time.Time      `json:"start_date"`
	Status                       Status         `json:"status"`
	TotalBudget                  *int64         `json:"total_budget"`
	TurnoverAbsolute             *int64         `json:"turnover_absolute"`
	TurnoverMax                  *int64         `json:"turnover_max"`
	TurnoverMin                  *int64         `json:"turnover_min"`
	Type                         ResultType     `json:"type"`
	URI                          string         `json:"uri"`
	UpdatedAt                    time.Time      `json:"updated_at"`
}

type CustomIncome struct {
	Amount    int64            `json:"amount"`
	CreatedAt time.Time        `json:"created_at"`
	ID        string           `json:"id"`
	Name      string           `json:"name"`
	Status    Status           `json:"status"`
	Type      CustomIncomeType `json:"type"`
	URI       string           `json:"uri"`
	UpdatedAt time.Time        `json:"updated_at"`
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

type CustomIncomeType string

const (
	Public CustomIncomeType = "public"
	Other  CustomIncomeType = "other"
)

type invalidCustomIncomeType string
func (x invalidCustomIncomeType) Error() string { return "invalid CustomIncomeType: " + string(x) }

func (x *CustomIncomeType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch CustomIncomeType(value) {
	case Public, Other: *x = CustomIncomeType(value); return nil
	}
	return invalidCustomIncomeType(value)
}

type ResultType string

const (
	FinancialDataNGO              ResultType = "FinancialDataNGO"
	FinancialDataLawyer           ResultType = "FinancialDataLawyer"
	FinancialDataTradeAssociation ResultType = "FinancialDataTradeAssociation"
)

type invalidResultType string
func (x invalidResultType) Error() string { return "invalid ResultType: " + string(x) }

func (x *ResultType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ResultType(value) {
	case FinancialDataNGO, FinancialDataLawyer, FinancialDataTradeAssociation: *x = ResultType(value); return nil
	}
	return invalidResultType(value)
}
