// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "bytes"
import "errors"

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
	Laureates []Laureate `json:"laureates"`
}

type Laureate struct {
	Born            string  `json:"born"`
	BornCity        *string `json:"bornCity,omitempty"`
	BornCountry     *string `json:"bornCountry,omitempty"`
	BornCountryCode *string `json:"bornCountryCode,omitempty"`
	Died            string  `json:"died"`
	DiedCity        *string `json:"diedCity,omitempty"`
	DiedCountry     *string `json:"diedCountry,omitempty"`
	DiedCountryCode *string `json:"diedCountryCode,omitempty"`
	Firstname       *string `json:"firstname,omitempty"`
	Gender          Gender  `json:"gender"`
	ID              string  `json:"id"`
	Prizes          []Prize `json:"prizes"`
	Surname         *string `json:"surname,omitempty"`
}

type Prize struct {
	Affiliations      []AffiliationElement `json:"affiliations"`
	Category          *Category            `json:"category,omitempty"`
	Motivation        *string              `json:"motivation,omitempty"`
	OverallMotivation *string              `json:"overallMotivation,omitempty"`
	Share             *string              `json:"share,omitempty"`
	Year              *string              `json:"year,omitempty"`
}

type AffiliationClass struct {
	City    *string `json:"city,omitempty"`
	Country *string `json:"country,omitempty"`
	Name    *string `json:"name,omitempty"`
}

type Gender string

const (
	Male   Gender = "male"
	Female Gender = "female"
	Org    Gender = "org"
)

type invalidGender string
func (x invalidGender) Error() string { return "invalid Gender: " + string(x) }

func (x *Gender) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Gender(value) {
	case Male, Female, Org: *x = Gender(value); return nil
	}
	return invalidGender(value)
}

type Category string

const (
	Physics    Category = "physics"
	Chemistry  Category = "chemistry"
	Peace      Category = "peace"
	Medicine   Category = "medicine"
	Literature Category = "literature"
	Economics  Category = "economics"
)

type invalidCategory string
func (x invalidCategory) Error() string { return "invalid Category: " + string(x) }

func (x *Category) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Category(value) {
	case Physics, Chemistry, Peace, Medicine, Literature, Economics: *x = Category(value); return nil
	}
	return invalidCategory(value)
}

type AffiliationElement struct {
	AffiliationClass *AffiliationClass
	AnythingArray    []interface{}
}

func (x *AffiliationElement) UnmarshalJSON(data []byte) error {
	x.AnythingArray = nil
	x.AffiliationClass = nil
	var c AffiliationClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.AnythingArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AffiliationClass = &c
	}
	return nil
}

func (x *AffiliationElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.AnythingArray != nil, x.AnythingArray, x.AffiliationClass != nil, x.AffiliationClass, false, nil, false, nil, false)
}

func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
			*pi = nil
	}
	if pf != nil {
			*pf = nil
	}
	if pb != nil {
			*pb = nil
	}
	if ps != nil {
			*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
			return false, err
	}

	switch v := tok.(type) {
	case json.Number:
			if pi != nil {
					i, err := v.Int64()
					if err == nil {
							*pi = &i
							return false, nil
					}
			}
			if pf != nil {
					f, err := v.Float64()
					if err == nil {
							*pf = &f
							return false, nil
					}
					return false, errors.New("Unparsable number")
			}
			return false, errors.New("Union does not contain number")
	case float64:
			return false, errors.New("Decoder should not return float64")
	case bool:
			if pb != nil {
					*pb = &v
					return false, nil
			}
			return false, errors.New("Union does not contain bool")
	case string:
			if haveEnum {
					return false, json.Unmarshal(data, pe)
			}
			if ps != nil {
					*ps = &v
					return false, nil
			}
			return false, errors.New("Union does not contain string")
	case nil:
			if nullable {
					return false, nil
			}
			return false, errors.New("Union does not contain null")
	case json.Delim:
			if v == '{' {
					if haveObject {
							return true, json.Unmarshal(data, pc)
					}
					if haveMap {
							return false, json.Unmarshal(data, pm)
					}
					return false, errors.New("Union does not contain object")
			}
			if v == '[' {
					if haveArray {
							return false, json.Unmarshal(data, pa)
					}
					return false, errors.New("Union does not contain array")
			}
			return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")
}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
			return json.Marshal(*pi)
	}
	if pf != nil {
			return json.Marshal(*pf)
	}
	if pb != nil {
			return json.Marshal(*pb)
	}
	if ps != nil {
			return json.Marshal(*ps)
	}
	if haveArray {
			return json.Marshal(pa)
	}
	if haveObject {
			return json.Marshal(pc)
	}
	if haveMap {
			return json.Marshal(pm)
	}
	if haveEnum {
			return json.Marshal(pe)
	}
	if nullable {
			return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}
