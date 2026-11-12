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
	Attendance           int64                `json:"attendance"`
	Clock                string               `json:"clock"`
	DisableMatch         int64                `json:"disableMatch"`
	InOT                 int64                `json:"inOT"`
	Leaddata             [][]LeaddatumElement `json:"leaddata"`
	OfficialsReferee1    string               `json:"officials_referee1"`
	OfficialsReferee2    string               `json:"officials_referee2"`
	OfficialsReferee3    string               `json:"officials_referee3"`
	Othermatches         []Othermatch         `json:"othermatches"`
	Pbp                  []Pbp                `json:"pbp"`
	Period               int64                `json:"period"`
	PeriodLengthOVERTIME int64                `json:"periodLengthOVERTIME"`
	PeriodLengthREGULAR  int64                `json:"periodLengthREGULAR"`
	PeriodType           PerType              `json:"periodType"`
	PeriodsMax           int64                `json:"periodsMax"`
	Scorers              map[string][]Scorer  `json:"scorers"`
	Timeline             []interface{}        `json:"timeline"`
	Tm                   map[string]Tm        `json:"tm"`
	TotalTimeAdded       int64                `json:"totalTimeAdded"`
	Totallds             Totallds             `json:"totallds"`
}

type Othermatch struct {
	Clock           string  `json:"clock"`
	CompetitionName string  `json:"competitionName"`
	ID              string  `json:"id"`
	Period          int64   `json:"period"`
	PeriodType      PerType `json:"periodType"`
	Team1           Team    `json:"team1"`
	Team1Name       string  `json:"team1Name"`
	Team1Score      int64   `json:"team1Score"`
	Team2           Team    `json:"team2"`
	Team2Name       string  `json:"team2Name"`
	Team2Score      int64   `json:"team2Score"`
}

type Team struct {
	TeamCode              string `json:"teamCode"`
	TeamCodeInternational string `json:"teamCodeInternational"`
	TeamName              string `json:"teamName"`
	TeamNameInternational string `json:"teamNameInternational"`
}

type Pbp struct {
	ActionType                     ActionType          `json:"actionType"`
	FamilyName                     *string             `json:"familyName,omitempty"`
	FamilyNameInitial              *FamilyNameInitial  `json:"familyNameInitial,omitempty"`
	FirstName                      *string             `json:"firstName,omitempty"`
	FirstNameInitial               *FirstNameInitial   `json:"firstNameInitial,omitempty"`
	Gt                             string              `json:"gt"`
	InternationalFamilyName        *string             `json:"internationalFamilyName,omitempty"`
	InternationalFamilyNameInitial *FamilyNameInitial  `json:"internationalFamilyNameInitial,omitempty"`
	InternationalFirstName         *string             `json:"internationalFirstName,omitempty"`
	InternationalFirstNameInitial  *FirstNameInitial   `json:"internationalFirstNameInitial,omitempty"`
	Lead                           int64               `json:"lead"`
	Period                         int64               `json:"period"`
	PeriodType                     PerType             `json:"periodType"`
	Player                         string              `json:"player"`
	Pno                            int64               `json:"pno"`
	Qualifier                      string              `json:"qualifier"`
	S1                             int64               `json:"s1"`
	S2                             int64               `json:"s2"`
	ScoreboardName                 *ScoreboardNameEnum `json:"scoreboardName,omitempty"`
	Scoring                        int64               `json:"scoring"`
	ShirtNumber                    string              `json:"shirtNumber"`
	SubType                        string              `json:"subType"`
	Success                        int64               `json:"success"`
	Tno                            int64               `json:"tno"`
}

type Scorer struct {
	FamilyName                     *string             `json:"familyName,omitempty"`
	FamilyNameInitial              *FamilyNameInitial  `json:"familyNameInitial,omitempty"`
	FirstName                      *string             `json:"firstName,omitempty"`
	FirstNameInitial               *FirstNameInitial   `json:"firstNameInitial,omitempty"`
	Gt                             *string             `json:"gt,omitempty"`
	InternationalFamilyName        *string             `json:"internationalFamilyName,omitempty"`
	InternationalFamilyNameInitial *FamilyNameInitial  `json:"internationalFamilyNameInitial,omitempty"`
	InternationalFirstName         *string             `json:"internationalFirstName,omitempty"`
	InternationalFirstNameInitial  *FirstNameInitial   `json:"internationalFirstNameInitial,omitempty"`
	Name                           *string             `json:"name,omitempty"`
	Per                            *int64              `json:"per,omitempty"`
	PerType                        *PerType            `json:"perType,omitempty"`
	Player                         *string             `json:"player,omitempty"`
	Pno                            int64               `json:"pno"`
	ScoreboardName                 *ScoreboardNameEnum `json:"scoreboardName,omitempty"`
	ShirtNumber                    string              `json:"shirtNumber"`
	Summary                        *string             `json:"summary,omitempty"`
	Times                          *[]Time             `json:"times,omitempty"`
	Tno                            int64               `json:"tno"`
	Tot                            *int64              `json:"tot,omitempty"`
}

type Time struct {
	Gt      string  `json:"gt"`
	Per     int64   `json:"per"`
	PerType PerType `json:"perType"`
}

type Tm struct {
	Code                        string        `json:"code"`
	CodeInternational           string        `json:"codeInternational"`
	Fouls                       int64         `json:"fouls"`
	FullScore                   int64         `json:"full_score"`
	Lds                         Lds           `json:"lds"`
	Logo                        string        `json:"logo"`
	Name                        string        `json:"name"`
	NameInternational           string        `json:"nameInternational"`
	P1Score                     int64         `json:"p1_score"`
	P2Score                     int64         `json:"p2_score"`
	P3Score                     int64         `json:"p3_score"`
	P4Score                     int64         `json:"p4_score"`
	Pl                          map[string]Pl `json:"pl"`
	Score                       int64         `json:"score"`
	Scoring                     []Scorer      `json:"scoring"`
	ShortName                   string        `json:"shortName"`
	ShortNameInternational      string        `json:"shortNameInternational"`
	Shot                        []Shot        `json:"shot"`
	Timeouts                    int64         `json:"timeouts"`
	TotEFF1                     int64         `json:"tot_eff_1"`
	TotEFF2                     int64         `json:"tot_eff_2"`
	TotEFF3                     float64       `json:"tot_eff_3"`
	TotEFF4                     int64         `json:"tot_eff_4"`
	TotEFF5                     int64         `json:"tot_eff_5"`
	TotEFF6                     int64         `json:"tot_eff_6"`
	TotEFF7                     int64         `json:"tot_eff_7"`
	TotSAssists                 int64         `json:"tot_sAssists"`
	TotSBenchPoints             int64         `json:"tot_sBenchPoints"`
	TotSBiggestLead             int64         `json:"tot_sBiggestLead"`
	TotSBiggestScoringRun       int64         `json:"tot_sBiggestScoringRun"`
	TotSBlocks                  int64         `json:"tot_sBlocks"`
	TotSBlocksReceived          int64         `json:"tot_sBlocksReceived"`
	TotSFieldGoalsAttempted     int64         `json:"tot_sFieldGoalsAttempted"`
	TotSFieldGoalsMade          int64         `json:"tot_sFieldGoalsMade"`
	TotSFieldGoalsPercentage    int64         `json:"tot_sFieldGoalsPercentage"`
	TotSFoulsOn                 int64         `json:"tot_sFoulsOn"`
	TotSFoulsPersonal           int64         `json:"tot_sFoulsPersonal"`
	TotSFoulsTeam               int64         `json:"tot_sFoulsTeam"`
	TotSFreeThrowsAttempted     int64         `json:"tot_sFreeThrowsAttempted"`
	TotSFreeThrowsMade          int64         `json:"tot_sFreeThrowsMade"`
	TotSFreeThrowsPercentage    int64         `json:"tot_sFreeThrowsPercentage"`
	TotSLeadChanges             int64         `json:"tot_sLeadChanges"`
	TotSMinutes                 int64         `json:"tot_sMinutes"`
	TotSPoints                  int64         `json:"tot_sPoints"`
	TotSPointsFastBreak         int64         `json:"tot_sPointsFastBreak"`
	TotSPointsFromTurnovers     int64         `json:"tot_sPointsFromTurnovers"`
	TotSPointsInThePaint        int64         `json:"tot_sPointsInThePaint"`
	TotSPointsSecondChance      int64         `json:"tot_sPointsSecondChance"`
	TotSReboundsDefensive       int64         `json:"tot_sReboundsDefensive"`
	TotSReboundsOffensive       int64         `json:"tot_sReboundsOffensive"`
	TotSReboundsTeam            int64         `json:"tot_sReboundsTeam"`
	TotSReboundsTeamDefensive   int64         `json:"tot_sReboundsTeamDefensive"`
	TotSReboundsTeamOffensive   int64         `json:"tot_sReboundsTeamOffensive"`
	TotSReboundsTotal           int64         `json:"tot_sReboundsTotal"`
	TotSSteals                  int64         `json:"tot_sSteals"`
	TotSThreePointersAttempted  int64         `json:"tot_sThreePointersAttempted"`
	TotSThreePointersMade       int64         `json:"tot_sThreePointersMade"`
	TotSThreePointersPercentage int64         `json:"tot_sThreePointersPercentage"`
	TotSTimeLeading             float64       `json:"tot_sTimeLeading"`
	TotSTimesScoresLevel        int64         `json:"tot_sTimesScoresLevel"`
	TotSTurnovers               int64         `json:"tot_sTurnovers"`
	TotSTurnoversTeam           int64         `json:"tot_sTurnoversTeam"`
	TotSTwoPointersAttempted    int64         `json:"tot_sTwoPointersAttempted"`
	TotSTwoPointersMade         int64         `json:"tot_sTwoPointersMade"`
	TotSTwoPointersPercentage   int64         `json:"tot_sTwoPointersPercentage"`
}

type Lds struct {
	SAssists       map[string]Scorer `json:"sAssists"`
	SBlocks        SBlocks           `json:"sBlocks"`
	SPoints        map[string]Scorer `json:"sPoints"`
	SReboundsTotal map[string]Scorer `json:"sReboundsTotal"`
	SSteals        map[string]Scorer `json:"sSteals"`
}

type SBlocks struct {
	The1 Scorer `json:"1"`
}

type Pl struct {
	Active                         int64             `json:"active"`
	Captain                        *int64            `json:"captain,omitempty"`
	Comp                           *Comp             `json:"comp,omitempty"`
	EFF1                           int64             `json:"eff_1"`
	EFF2                           int64             `json:"eff_2"`
	EFF3                           float64           `json:"eff_3"`
	EFF4                           float64           `json:"eff_4"`
	EFF5                           int64             `json:"eff_5"`
	EFF6                           int64             `json:"eff_6"`
	EFF7                           int64             `json:"eff_7"`
	FamilyName                     string            `json:"familyName"`
	FamilyNameInitial              FamilyNameInitial `json:"familyNameInitial"`
	FirstName                      string            `json:"firstName"`
	FirstNameInitial               FirstNameInitial  `json:"firstNameInitial"`
	InternationalFamilyName        string            `json:"internationalFamilyName"`
	InternationalFamilyNameInitial FamilyNameInitial `json:"internationalFamilyNameInitial"`
	InternationalFirstName         string            `json:"internationalFirstName"`
	InternationalFirstNameInitial  FirstNameInitial  `json:"internationalFirstNameInitial"`
	Name                           string            `json:"name"`
	PlayingPosition                string            `json:"playingPosition"`
	SAssists                       int64             `json:"sAssists"`
	SBlocks                        int64             `json:"sBlocks"`
	SBlocksReceived                int64             `json:"sBlocksReceived"`
	SFieldGoalsAttempted           int64             `json:"sFieldGoalsAttempted"`
	SFieldGoalsMade                int64             `json:"sFieldGoalsMade"`
	SFieldGoalsPercentage          int64             `json:"sFieldGoalsPercentage"`
	SFoulsOn                       int64             `json:"sFoulsOn"`
	SFoulsPersonal                 int64             `json:"sFoulsPersonal"`
	SFreeThrowsAttempted           int64             `json:"sFreeThrowsAttempted"`
	SFreeThrowsMade                int64             `json:"sFreeThrowsMade"`
	SFreeThrowsPercentage          int64             `json:"sFreeThrowsPercentage"`
	SMinutes                       *SMinutes         `json:"sMinutes"`
	SPlusMinusPoints               int64             `json:"sPlusMinusPoints"`
	SPoints                        int64             `json:"sPoints"`
	SPointsFastBreak               int64             `json:"sPointsFastBreak"`
	SPointsInThePaint              int64             `json:"sPointsInThePaint"`
	SPointsSecondChance            int64             `json:"sPointsSecondChance"`
	SReboundsDefensive             int64             `json:"sReboundsDefensive"`
	SReboundsOffensive             int64             `json:"sReboundsOffensive"`
	SReboundsTotal                 int64             `json:"sReboundsTotal"`
	SSteals                        int64             `json:"sSteals"`
	SThreePointersAttempted        int64             `json:"sThreePointersAttempted"`
	SThreePointersMade             int64             `json:"sThreePointersMade"`
	SThreePointersPercentage       int64             `json:"sThreePointersPercentage"`
	STurnovers                     int64             `json:"sTurnovers"`
	STwoPointersAttempted          int64             `json:"sTwoPointersAttempted"`
	STwoPointersMade               int64             `json:"sTwoPointersMade"`
	STwoPointersPercentage         int64             `json:"sTwoPointersPercentage"`
	ShirtNumber                    string            `json:"shirtNumber"`
	Starter                        int64             `json:"starter"`
}

type Comp struct {
	SAssistsAverage       float64 `json:"sAssistsAverage"`
	SMinutesAverage       string  `json:"sMinutesAverage"`
	SPointsAverage        float64 `json:"sPointsAverage"`
	SReboundsTotalAverage float64 `json:"sReboundsTotalAverage"`
}

type Shot struct {
	ActionType  ActionType `json:"actionType"`
	P           int64      `json:"p"`
	Per         int64      `json:"per"`
	PerType     PerType    `json:"perType"`
	Player      string     `json:"player"`
	Pno         int64      `json:"pno"`
	R           int64      `json:"r"`
	ShirtNumber string     `json:"shirtNumber"`
	SubType     SubType    `json:"subType"`
	Tno         int64      `json:"tno"`
	X           int64      `json:"x"`
	Y           int64      `json:"y"`
}

type Totallds struct {
	SAssists       map[string]Scorer `json:"sAssists"`
	SBlocks        map[string]Scorer `json:"sBlocks"`
	SPoints        map[string]Scorer `json:"sPoints"`
	SReboundsTotal map[string]Scorer `json:"sReboundsTotal"`
	SSteals        map[string]Scorer `json:"sSteals"`
}

type LeaddatumEnum string

const (
	Leaddatum LeaddatumEnum = ""
	P1        LeaddatumEnum = "P1"
	P2        LeaddatumEnum = "P2"
	P3        LeaddatumEnum = "P3"
	P4        LeaddatumEnum = "P4"
)

type PerType string

const (
	Regular PerType = "REGULAR"
)

type invalidPerType string
func (x invalidPerType) Error() string { return "invalid PerType: " + string(x) }

func (x *PerType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PerType(value) {
	case Regular: *x = PerType(value); return nil
	}
	return invalidPerType(value)
}

type ActionType string

const (
	Game         ActionType = "game"
	Period       ActionType = "period"
	The3Pt       ActionType = "3pt"
	The2Pt       ActionType = "2pt"
	Rebound      ActionType = "rebound"
	Timeout      ActionType = "timeout"
	Foulon       ActionType = "foulon"
	Foul         ActionType = "foul"
	Assist       ActionType = "assist"
	Substitution ActionType = "substitution"
	Freethrow    ActionType = "freethrow"
	Steal        ActionType = "steal"
	Turnover     ActionType = "turnover"
	Block        ActionType = "block"
	Jumpball     ActionType = "jumpball"
)

type invalidActionType string
func (x invalidActionType) Error() string { return "invalid ActionType: " + string(x) }

func (x *ActionType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ActionType(value) {
	case Game, Period, The3Pt, The2Pt, Rebound, Timeout, Foulon, Foul, Assist, Substitution, Freethrow, Steal, Turnover, Block, Jumpball: *x = ActionType(value); return nil
	}
	return invalidActionType(value)
}

type FamilyNameInitial string

const (
	FamilyNameInitialR FamilyNameInitial = "R"
	M                  FamilyNameInitial = "M"
	S                  FamilyNameInitial = "s"
	FamilyNameInitialC FamilyNameInitial = "C"
	FamilyNameInitialO FamilyNameInitial = "O"
	W                  FamilyNameInitial = "W"
	FamilyNameInitialA FamilyNameInitial = "A"
	P                  FamilyNameInitial = "P"
	V                  FamilyNameInitial = "V"
	I                  FamilyNameInitial = "I"
	FamilyNameInitialJ FamilyNameInitial = "J"
	FamilyNameInitialS FamilyNameInitial = "S"
	FamilyNameInitialH FamilyNameInitial = "H"
	FamilyNameInitialB FamilyNameInitial = "B"
)

type invalidFamilyNameInitial string
func (x invalidFamilyNameInitial) Error() string { return "invalid FamilyNameInitial: " + string(x) }

func (x *FamilyNameInitial) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FamilyNameInitial(value) {
	case FamilyNameInitialR, M, S, FamilyNameInitialC, FamilyNameInitialO, W, FamilyNameInitialA, P, V, I, FamilyNameInitialJ, FamilyNameInitialS, FamilyNameInitialH, FamilyNameInitialB: *x = FamilyNameInitial(value); return nil
	}
	return invalidFamilyNameInitial(value)
}

type FirstNameInitial string

const (
	D                 FirstNameInitial = "D"
	FirstNameInitialJ FirstNameInitial = "J"
	T                 FirstNameInitial = "T"
	FirstNameInitialC FirstNameInitial = "C"
	FirstNameInitialO FirstNameInitial = "O"
	FirstNameInitialH FirstNameInitial = "H"
	L                 FirstNameInitial = "L"
	FirstNameInitialA FirstNameInitial = "A"
	K                 FirstNameInitial = "K"
	FirstNameInitialR FirstNameInitial = "R"
	FirstNameInitialB FirstNameInitial = "B"
	N                 FirstNameInitial = "N"
)

type invalidFirstNameInitial string
func (x invalidFirstNameInitial) Error() string { return "invalid FirstNameInitial: " + string(x) }

func (x *FirstNameInitial) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FirstNameInitial(value) {
	case D, FirstNameInitialJ, T, FirstNameInitialC, FirstNameInitialO, FirstNameInitialH, L, FirstNameInitialA, K, FirstNameInitialR, FirstNameInitialB, N: *x = FirstNameInitial(value); return nil
	}
	return invalidFirstNameInitial(value)
}

type ScoreboardNameEnum string

const (
	ScoreboardName ScoreboardNameEnum = ""
	TS             ScoreboardNameEnum = "T. s"
	RIhata         ScoreboardNameEnum = "R. Ihata"
	DJones         ScoreboardNameEnum = "D. Jones"
	BValentine     ScoreboardNameEnum = "B. Valentine"
)

type invalidScoreboardNameEnum string
func (x invalidScoreboardNameEnum) Error() string { return "invalid ScoreboardNameEnum: " + string(x) }

func (x *ScoreboardNameEnum) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ScoreboardNameEnum(value) {
	case ScoreboardName, TS, RIhata, DJones, BValentine: *x = ScoreboardNameEnum(value); return nil
	}
	return invalidScoreboardNameEnum(value)
}

type SubType string

const (
	Jumpshot SubType = "jumpshot"
	Layup    SubType = "layup"
	Dunk     SubType = "dunk"
)

type invalidSubType string
func (x invalidSubType) Error() string { return "invalid SubType: " + string(x) }

func (x *SubType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch SubType(value) {
	case Jumpshot, Layup, Dunk: *x = SubType(value); return nil
	}
	return invalidSubType(value)
}

type LeaddatumElement struct {
	Enum    *LeaddatumEnum
	Integer *int64
}

func (x *LeaddatumElement) UnmarshalJSON(data []byte) error {
	x.Enum = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, false, nil, false, nil, true, &x.Enum, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *LeaddatumElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, false, nil, false, nil, x.Enum != nil, x.Enum, false)
}

type SMinutes struct {
	Integer *int64
	String  *string
}

func (x *SMinutes) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *SMinutes) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, false, nil, false, nil, false)
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
