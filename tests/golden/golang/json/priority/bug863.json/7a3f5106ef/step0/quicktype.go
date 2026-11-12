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
	Alienlevel        int64         `json:"ALIENLEVEL"`
	Breed             Breed         `json:"BREED"`
	CharDimension     int64         `json:"CHAR_DIMENSION"`
	CharInstance      int64         `json:"CHAR_INSTANCE"`
	DefenderRankTitle string        `json:"DEFENDER_RANK_TITLE"`
	Firstname         FIRSTNAMEEnum `json:"FIRSTNAME"`
	Headid            int64         `json:"HEADID"`
	Lastname          LASTNAMEEnum  `json:"LASTNAME"`
	Levelx            int64         `json:"LEVELX"`
	Name              string        `json:"NAME"`
	Prof              string        `json:"PROF"`
	ProfTitle         string        `json:"PROF_TITLE"`
	Pvprating         int64         `json:"PVPRATING"`
	Pvptitle          Pvptitle      `json:"PVPTITLE"`
	Rank              int64         `json:"RANK"`
	RankTitle         RankTitle     `json:"RANK_TITLE"`
	Sex               Sex           `json:"SEX"`
}

type FluffyTopLevel struct {
	Adventurercount int64   `json:"ADVENTURERCOUNT"`
	Agentcount      int64   `json:"AGENTCOUNT"`
	Atroxcount      int64   `json:"ATROXCOUNT"`
	Avglvl          float64 `json:"AVGLVL"`
	Btcount         int64   `json:"BTCOUNT"`
	Description     string  `json:"DESCRIPTION"`
	Doctorcount     int64   `json:"DOCTORCOUNT"`
	Enfcount        int64   `json:"ENFCOUNT"`
	Engineeercount  int64   `json:"ENGINEEERCOUNT"`
	Femalecount     int64   `json:"FEMALECOUNT"`
	Fixercount      int64   `json:"FIXERCOUNT"`
	Governingname   string  `json:"GOVERNINGNAME"`
	History         string  `json:"HISTORY"`
	Keepercount     int64   `json:"KEEPERCOUNT"`
	Macount         int64   `json:"MACOUNT"`
	Malecount       int64   `json:"MALECOUNT"`
	Maxlvl          int64   `json:"MAXLVL"`
	Metacount       int64   `json:"METACOUNT"`
	Minlvl          int64   `json:"MINLVL"`
	Monstercount    int64   `json:"MONSTERCOUNT"`
	Name            string  `json:"NAME"`
	Nanocount       int64   `json:"NANOCOUNT"`
	Nanoracecount   int64   `json:"NANORACECOUNT"`
	Neutercount     int64   `json:"NEUTERCOUNT"`
	Nummembers      int64   `json:"NUMMEMBERS"`
	Objective       string  `json:"OBJECTIVE"`
	Opifexcount     int64   `json:"OPIFEXCOUNT"`
	OrgDimension    int64   `json:"ORG_DIMENSION"`
	OrgInstance     int64   `json:"ORG_INSTANCE"`
	Shadecount      int64   `json:"SHADECOUNT"`
	Side            int64   `json:"SIDE"`
	SideName        string  `json:"SIDE_NAME"`
	Solidercount    int64   `json:"SOLIDERCOUNT"`
	Solituscount    int64   `json:"SOLITUSCOUNT"`
	Tradercount     int64   `json:"TRADERCOUNT"`
}

type Breed string

const (
	Atrox   Breed = "Atrox"
	Solitus Breed = "Solitus"
	Opifex  Breed = "Opifex"
	Nano    Breed = "Nano"
)

type invalidBreed string
func (x invalidBreed) Error() string { return "invalid Breed: " + string(x) }

func (x *Breed) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Breed(value) {
	case Atrox, Solitus, Opifex, Nano: *x = Breed(value); return nil
	}
	return invalidBreed(value)
}

type FIRSTNAMEEnum string

const (
	Firstname FIRSTNAMEEnum = ""
	Chi       FIRSTNAMEEnum = "Chi"
)

type invalidFIRSTNAMEEnum string
func (x invalidFIRSTNAMEEnum) Error() string { return "invalid FIRSTNAMEEnum: " + string(x) }

func (x *FIRSTNAMEEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FIRSTNAMEEnum(value) {
	case Firstname, Chi: *x = FIRSTNAMEEnum(value); return nil
	}
	return invalidFIRSTNAMEEnum(value)
}

type LASTNAMEEnum string

const (
	Lastname LASTNAMEEnum = ""
	Washko   LASTNAMEEnum = "Washko"
)

type invalidLASTNAMEEnum string
func (x invalidLASTNAMEEnum) Error() string { return "invalid LASTNAMEEnum: " + string(x) }

func (x *LASTNAMEEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch LASTNAMEEnum(value) {
	case Lastname, Washko: *x = LASTNAMEEnum(value); return nil
	}
	return invalidLASTNAMEEnum(value)
}

type Pvptitle string

const (
	Freshman Pvptitle = "Freshman"
)

type invalidPvptitle string
func (x invalidPvptitle) Error() string { return "invalid Pvptitle: " + string(x) }

func (x *Pvptitle) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Pvptitle(value) {
	case Freshman: *x = Pvptitle(value); return nil
	}
	return invalidPvptitle(value)
}

type RankTitle string

const (
	President RankTitle = "President"
	Advisor   RankTitle = "Advisor"
	Veteran   RankTitle = "Veteran"
	Applicant RankTitle = "Applicant"
)

type invalidRankTitle string
func (x invalidRankTitle) Error() string { return "invalid RankTitle: " + string(x) }

func (x *RankTitle) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RankTitle(value) {
	case President, Advisor, Veteran, Applicant: *x = RankTitle(value); return nil
	}
	return invalidRankTitle(value)
}

type Sex string

const (
	Neuter Sex = "Neuter"
	Male   Sex = "Male"
	Female Sex = "Female"
)

type invalidSex string
func (x invalidSex) Error() string { return "invalid Sex: " + string(x) }

func (x *Sex) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Sex(value) {
	case Neuter, Male, Female: *x = Sex(value); return nil
	}
	return invalidSex(value)
}

type TopLevelUnion struct {
	FluffyTopLevel      *FluffyTopLevel
	PurpleTopLevelArray []PurpleTopLevel
	String              *string
}

func (x *TopLevelUnion) UnmarshalJSON(data []byte) error {
	x.PurpleTopLevelArray = nil
	x.FluffyTopLevel = nil
	var c FluffyTopLevel
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.PurpleTopLevelArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FluffyTopLevel = &c
	}
	return nil
}

func (x *TopLevelUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.PurpleTopLevelArray != nil, x.PurpleTopLevelArray, x.FluffyTopLevel != nil, x.FluffyTopLevel, false, nil, false, nil, false)
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
