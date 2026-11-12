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
	BasePath    string      `json:"basePath"`
	Definitions Definitions `json:"definitions"`
	Host        string      `json:"host"`
	Info        Info        `json:"info"`
	Paths       Paths       `json:"paths"`
	Produces    []string    `json:"produces"`
	Schemes     []string    `json:"schemes"`
	Swagger     string      `json:"swagger"`
}

type Definitions struct {
	Article            Article   `json:"Article"`
	Center             Article   `json:"Center"`
	DeMinimis          DeMinimis `json:"DeMinimis"`
	Event              Article   `json:"Event"`
	FAQ                FAQ       `json:"FAQ"`
	Lead               Article   `json:"Lead"`
	List               Article   `json:"List"`
	MarketIntelligence Article   `json:"MarketIntelligence"`
	Office             Article   `json:"Office"`
	Provider           Article   `json:"Provider"`
	Rate               Article   `json:"Rate"`
	Report             Report    `json:"Report"`
	Taxonomy           Taxonomy  `json:"Taxonomy"`
}

type Article struct {
	Properties map[string]Property `json:"properties"`
}

type Property struct {
	Description string     `json:"description"`
	Type        FormatEnum `json:"type"`
}

type DeMinimis struct {
	Properties DeMinimisProperties `json:"properties"`
}

type DeMinimisProperties struct {
	Countries         Property `json:"countries"`
	Country           Property `json:"country"`
	DeMinimisCurrency Property `json:"de_minimis_currency"`
	DeMinimisValue    Property `json:"de_minimis_value"`
	Notes             Property `json:"notes"`
	VatAmount         Property `json:"vat_amount"`
	VatCurrency       Property `json:"vat_currency"`
}

type FAQ struct {
	Properties FAQProperties `json:"properties"`
}

type FAQProperties struct {
	Answer             Property `json:"answer"`
	Countries          Property `json:"countries"`
	FirstPublishedDate Property `json:"first_published_date"`
	ID                 Property `json:"id"`
	Industries         Property `json:"industries"`
	LastPublishedDate  Property `json:"last_published_date"`
	Question           Property `json:"question"`
	Topics             Property `json:"topics"`
	TradeRegions       Property `json:"trade_regions"`
	URL                Property `json:"url"`
	WorldRegions       Property `json:"world_regions"`
}

type Report struct {
	Properties ReportProperties `json:"properties"`
}

type ReportProperties struct {
	Countries      Property `json:"countries"`
	Description    Property `json:"description"`
	ExpirationDate Property `json:"expiration_date"`
	ID             Property `json:"id"`
	Industries     Property `json:"industries"`
	ItaIndustries  Property `json:"ita_industries"`
	ReportType     Property `json:"report_type"`
	Title          Property `json:"title"`
	URL            Property `json:"url"`
}

type Taxonomy struct {
	Properties TaxonomyProperties `json:"properties"`
}

type TaxonomyProperties struct {
	Annotations        Property `json:"annotations"`
	DatatypeProperties Property `json:"datatype_properties"`
	ID                 Property `json:"id"`
	Label              Property `json:"label"`
	SubClassOf         Property `json:"sub_class_of"`
	Type               Property `json:"type"`
}

type Info struct {
	Description string `json:"description"`
	Title       string `json:"title"`
	Version     string `json:"version"`
}

type Paths struct {
	BusinessServiceProvidersSearch  BusinessServiceProvidersSearchClass  `json:"/business_service_providers/search"`
	ConsolidatedScreeningListSearch ConsolidatedScreeningListSearchClass `json:"/consolidated_screening_list/search"`
	DeMinimisSearch                 ConsolidatedScreeningListSearchClass `json:"/de_minimis/search"`
	ItaFaqsSearch                   ConsolidatedScreeningListSearchClass `json:"/ita_faqs/search"`
	ItaOfficeLocationsSearch        ConsolidatedScreeningListSearchClass `json:"/ita_office_locations/search"`
	ItaTaxonomiesSearch             BusinessServiceProvidersSearchClass  `json:"/ita_taxonomies/search"`
	ItaZipcodeToPostSearch          BusinessServiceProvidersSearchClass  `json:"/ita_zipcode_to_post/search"`
	MarketIntelligenceSearch        ConsolidatedScreeningListSearchClass `json:"/market_intelligence/search"`
	MarketResearchLibrarySearch     ConsolidatedScreeningListSearchClass `json:"/market_research_library/search"`
	TariffRatesSearch               ConsolidatedScreeningListSearchClass `json:"/tariff_rates/search"`
	TradeArticlesSearch             ConsolidatedScreeningListSearchClass `json:"/trade_articles/search"`
	TradeEventsSearch               ConsolidatedScreeningListSearchClass `json:"/trade_events/search"`
	TradeLeadsSearch                ConsolidatedScreeningListSearchClass `json:"/trade_leads/search"`
}

type BusinessServiceProvidersSearchClass struct {
	Get BusinessServiceProvidersSearchGet `json:"get"`
}

type BusinessServiceProvidersSearchGet struct {
	Description string          `json:"description"`
	Parameters  []Parameter     `json:"parameters"`
	Responses   PurpleResponses `json:"responses"`
	Summary     string          `json:"summary"`
	Tags        []string        `json:"tags"`
}

type Parameter struct {
	Description string     `json:"description"`
	Format      FormatEnum `json:"format"`
	In          In         `json:"in"`
	Name        string     `json:"name"`
	Required    bool       `json:"required"`
	Type        FormatEnum `json:"type"`
}

type PurpleResponses struct {
	The200 Purple200 `json:"200"`
}

type Purple200 struct {
	Description string     `json:"description"`
	Schema      ItemsClass `json:"schema"`
}

type ItemsClass struct {
	Ref string `json:"$ref"`
}

type ConsolidatedScreeningListSearchClass struct {
	Get ConsolidatedScreeningListSearchGet `json:"get"`
}

type ConsolidatedScreeningListSearchGet struct {
	Description string          `json:"description"`
	Parameters  []Parameter     `json:"parameters"`
	Responses   FluffyResponses `json:"responses"`
	Summary     string          `json:"summary"`
	Tags        []string        `json:"tags"`
}

type FluffyResponses struct {
	The200 Fluffy200 `json:"200"`
}

type Fluffy200 struct {
	Description string       `json:"description"`
	Schema      PurpleSchema `json:"schema"`
}

type PurpleSchema struct {
	Items ItemsClass `json:"items"`
	Type  SchemaType `json:"type"`
}

type FormatEnum string

const (
	String FormatEnum = "string"
)

type invalidFormatEnum string
func (x invalidFormatEnum) Error() string { return "invalid FormatEnum: " + string(x) }

func (x *FormatEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FormatEnum(value) {
	case String: *x = FormatEnum(value); return nil
	}
	return invalidFormatEnum(value)
}

type In string

const (
	Query In = "query"
)

type invalidIn string
func (x invalidIn) Error() string { return "invalid In: " + string(x) }

func (x *In) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch In(value) {
	case Query: *x = In(value); return nil
	}
	return invalidIn(value)
}

type SchemaType string

const (
	Array SchemaType = "array"
)

type invalidSchemaType string
func (x invalidSchemaType) Error() string { return "invalid SchemaType: " + string(x) }

func (x *SchemaType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SchemaType(value) {
	case Array: *x = SchemaType(value); return nil
	}
	return invalidSchemaType(value)
}
