// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "bytes"
import "errors"

import "encoding/json"

type TopLevel []TopLevelUnion

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type PurpleTopLevel struct {
	Adminregion Adminregion `json:"adminregion"`
	CapitalCity string      `json:"capitalCity"`
	ID          string      `json:"id"`
	IncomeLevel Adminregion `json:"incomeLevel"`
	Iso2Code    string      `json:"iso2Code"`
	Latitude    string      `json:"latitude"`
	LendingType Adminregion `json:"lendingType"`
	Longitude   string      `json:"longitude"`
	Name        string      `json:"name"`
	Region      Adminregion `json:"region"`
}

type Adminregion struct {
	ID    IDEnum    `json:"id"`
	Value ValueEnum `json:"value"`
}

type FluffyTopLevel struct {
	Page    int64  `json:"page"`
	Pages   int64  `json:"pages"`
	PerPage string `json:"per_page"`
	Total   int64  `json:"total"`
}

type IDEnum string

const (
	ID  IDEnum = ""
	SAS IDEnum = "SAS"
	SSA IDEnum = "SSA"
	Eca IDEnum = "ECA"
	Lac IDEnum = "LAC"
	EAP IDEnum = "EAP"
	Mna IDEnum = "MNA"
	Hic IDEnum = "HIC"
	Lic IDEnum = "LIC"
	Na  IDEnum = "NA"
	Lmc IDEnum = "LMC"
	Umc IDEnum = "UMC"
	Lnx IDEnum = "LNX"
	Idx IDEnum = "IDX"
	Ibd IDEnum = "IBD"
	Idb IDEnum = "IDB"
	Lcn IDEnum = "LCN"
	Ssf IDEnum = "SSF"
	Ecs IDEnum = "ECS"
	Mea IDEnum = "MEA"
	EAS IDEnum = "EAS"
	Nac IDEnum = "NAC"
)

type invalidIDEnum string
func (x invalidIDEnum) Error() string { return "invalid IDEnum: " + string(x) }

func (x *IDEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch IDEnum(value) {
	case ID, SAS, SSA, Eca, Lac, EAP, Mna, Hic, Lic, Na, Lmc, Umc, Lnx, Idx, Ibd, Idb, Lcn, Ssf, Ecs, Mea, EAS, Nac: *x = IDEnum(value); return nil
	}
	return invalidIDEnum(value)
}

type ValueEnum string

const (
	Value                                    ValueEnum = ""
	SouthAsia                                ValueEnum = "South Asia"
	SubSaharanAfricaExcludingHighIncome      ValueEnum = "Sub-Saharan Africa (excluding high income)"
	EuropeCentralAsiaExcludingHighIncome     ValueEnum = "Europe & Central Asia (excluding high income)"
	LatinAmericaCaribbeanExcludingHighIncome ValueEnum = "Latin America & Caribbean (excluding high income)"
	EastAsiaPacificExcludingHighIncome       ValueEnum = "East Asia & Pacific (excluding high income)"
	MiddleEastNorthAfricaExcludingHighIncome ValueEnum = "Middle East & North Africa (excluding high income)"
	HighIncome                               ValueEnum = "High income"
	LowIncome                                ValueEnum = "Low income"
	Aggregates                               ValueEnum = "Aggregates"
	LowerMiddleIncome                        ValueEnum = "Lower middle income"
	UpperMiddleIncome                        ValueEnum = "Upper middle income"
	NotClassified                            ValueEnum = "Not classified"
	Ida                                      ValueEnum = "IDA"
	Ibrd                                     ValueEnum = "IBRD"
	Blend                                    ValueEnum = "Blend"
	LatinAmericaCaribbean                    ValueEnum = "Latin America & Caribbean "
	SubSaharanAfrica                         ValueEnum = "Sub-Saharan Africa "
	EuropeCentralAsia                        ValueEnum = "Europe & Central Asia"
	MiddleEastNorthAfrica                    ValueEnum = "Middle East & North Africa"
	EastAsiaPacific                          ValueEnum = "East Asia & Pacific"
	NorthAmerica                             ValueEnum = "North America"
)

type invalidValueEnum string
func (x invalidValueEnum) Error() string { return "invalid ValueEnum: " + string(x) }

func (x *ValueEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ValueEnum(value) {
	case Value, SouthAsia, SubSaharanAfricaExcludingHighIncome, EuropeCentralAsiaExcludingHighIncome, LatinAmericaCaribbeanExcludingHighIncome, EastAsiaPacificExcludingHighIncome, MiddleEastNorthAfricaExcludingHighIncome, HighIncome, LowIncome, Aggregates, LowerMiddleIncome, UpperMiddleIncome, NotClassified, Ida, Ibrd, Blend, LatinAmericaCaribbean, SubSaharanAfrica, EuropeCentralAsia, MiddleEastNorthAfrica, EastAsiaPacific, NorthAmerica: *x = ValueEnum(value); return nil
	}
	return invalidValueEnum(value)
}

type TopLevelUnion struct {
	FluffyTopLevel      *FluffyTopLevel
	PurpleTopLevelArray []PurpleTopLevel
}

func (x *TopLevelUnion) UnmarshalJSON(data []byte) error {
	x.PurpleTopLevelArray = nil
	x.FluffyTopLevel = nil
	var c FluffyTopLevel
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.PurpleTopLevelArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FluffyTopLevel = &c
	}
	return nil
}

func (x *TopLevelUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.PurpleTopLevelArray != nil, x.PurpleTopLevelArray, x.FluffyTopLevel != nil, x.FluffyTopLevel, false, nil, false, nil, false)
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
