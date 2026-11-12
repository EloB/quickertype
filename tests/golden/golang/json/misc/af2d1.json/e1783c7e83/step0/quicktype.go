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
	CRS           CRS              `json:"crs"`
	Features      []FeatureElement `json:"features"`
	TotalFeatures int64            `json:"totalFeatures"`
	Type          string           `json:"type"`
}

type CRS struct {
	Properties CRSProperties `json:"properties"`
	Type       string        `json:"type"`
}

type CRSProperties struct {
	Name string `json:"name"`
}

type FeatureElement struct {
	Geometry     Geometry          `json:"geometry"`
	GeometryName GeometryName      `json:"geometry_name"`
	ID           string            `json:"id"`
	Properties   FeatureProperties `json:"properties"`
	Type         FeatureType       `json:"type"`
}

type Geometry struct {
	Coordinates [][][][]float64 `json:"coordinates"`
	Type        GeometryType    `json:"type"`
}

type FeatureProperties struct {
	AddImprov  *AddImprov      `json:"add_improv"`
	Area       float64         `json:"area_"`
	AssetNumb  string          `json:"asset_numb"`
	Comments   *string         `json:"comments"`
	Condition  int64           `json:"condition"`
	Constructi *string         `json:"constructi"`
	Createdate interface{}     `json:"createdate"`
	Createuser interface{}     `json:"createuser"`
	DisposalD  interface{}     `json:"disposal_d"`
	Documents  string          `json:"documents"`
	DrawingNu  *string         `json:"drawing_nu"`
	FileNumbe  *string         `json:"file_numbe"`
	FolderNum  *string         `json:"folder_num"`
	FundingBa  *FundingBa      `json:"funding_ba"`
	HistoricC  int64           `json:"historic_c"`
	Inspection string          `json:"inspection"`
	Inspectors interface{}     `json:"inspectors"`
	LastUpdat  interface{}     `json:"last_updat"`
	LevelAccu  *LevelAccu      `json:"level_accu"`
	Material   Material        `json:"material"`
	MiPrinx    int64           `json:"mi_prinx"`
	MiSymbolo  MiSymbolo       `json:"mi_symbolo"`
	NumberLAN  int64           `json:"number_lan"`
	Owner      *string         `json:"owner"`
	Positional *LevelAccu      `json:"positional"`
	ProjectNu  *string         `json:"project_nu"`
	RecID      int64           `json:"rec_id"`
	RecordCre  *string         `json:"record_cre"`
	ShapeArea  float64         `json:"shape_area"`
	ShapeLeng  float64         `json:"shape_leng"`
	Status     Status          `json:"status"`
	SurveyNum  interface{}     `json:"survey_num"`
	ToeRl      float64         `json:"toe_rl"`
	TopRl      float64         `json:"top_rl"`
	Type       *PropertiesType `json:"type"`
	UpdateDAT  string          `json:"update_dat"`
	Updatedate interface{}     `json:"updatedate"`
	Updateuser interface{}     `json:"updateuser"`
}

type GeometryType string

const (
	MultiPolygon GeometryType = "MultiPolygon"
)

type invalidGeometryType string
func (x invalidGeometryType) Error() string { return "invalid GeometryType: " + string(x) }

func (x *GeometryType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GeometryType(value) {
	case MultiPolygon: *x = GeometryType(value); return nil
	}
	return invalidGeometryType(value)
}

type GeometryName string

const (
	Geom GeometryName = "geom"
)

type invalidGeometryName string
func (x invalidGeometryName) Error() string { return "invalid GeometryName: " + string(x) }

func (x *GeometryName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GeometryName(value) {
	case Geom: *x = GeometryName(value); return nil
	}
	return invalidGeometryName(value)
}

type AddImprov string

const (
	F          AddImprov = "f"
	AddImprovF AddImprov = "F"
	T          AddImprov = "t"
)

type invalidAddImprov string
func (x invalidAddImprov) Error() string { return "invalid AddImprov: " + string(x) }

func (x *AddImprov) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch AddImprov(value) {
	case F, AddImprovF, T: *x = AddImprov(value); return nil
	}
	return invalidAddImprov(value)
}

type FundingBa string

const (
	NonGCCC    FundingBa = "Non GCCC"
	Capex      FundingBa = "Capex"
	Initial    FundingBa = "Initial"
	Contribute FundingBa = "Contribute"
)

type invalidFundingBa string
func (x invalidFundingBa) Error() string { return "invalid FundingBa: " + string(x) }

func (x *FundingBa) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FundingBa(value) {
	case NonGCCC, Capex, Initial, Contribute: *x = FundingBa(value); return nil
	}
	return invalidFundingBa(value)
}

type LevelAccu string

const (
	GPSCorrected10M LevelAccu = "GPS Corrected 1.0M"
	Approx          LevelAccu = "APPROX"
	GPSCOrrected10M LevelAccu = "GPS COrrected 1.0M"
)

type invalidLevelAccu string
func (x invalidLevelAccu) Error() string { return "invalid LevelAccu: " + string(x) }

func (x *LevelAccu) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch LevelAccu(value) {
	case GPSCorrected10M, Approx, GPSCOrrected10M: *x = LevelAccu(value); return nil
	}
	return invalidLevelAccu(value)
}

type Material string

const (
	Gravel             Material = "Gravel"
	Concrete           Material = "Concrete"
	Bitumen            Material = "Bitumen"
	InterlockConcBlock Material = "Interlock Conc Block"
	Other              Material = "Other"
	Earth              Material = "Earth"
)

type invalidMaterial string
func (x invalidMaterial) Error() string { return "invalid Material: " + string(x) }

func (x *Material) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Material(value) {
	case Gravel, Concrete, Bitumen, InterlockConcBlock, Other, Earth: *x = Material(value); return nil
	}
	return invalidMaterial(value)
}

type MiSymbolo string

const (
	Pen2265535Brush1016777215 MiSymbolo = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"
)

type invalidMiSymbolo string
func (x invalidMiSymbolo) Error() string { return "invalid MiSymbolo: " + string(x) }

func (x *MiSymbolo) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MiSymbolo(value) {
	case Pen2265535Brush1016777215: *x = MiSymbolo(value); return nil
	}
	return invalidMiSymbolo(value)
}

type Status string

const (
	Current Status = "CURRENT"
)

type invalidStatus string
func (x invalidStatus) Error() string { return "invalid Status: " + string(x) }

func (x *Status) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Status(value) {
	case Current: *x = Status(value); return nil
	}
	return invalidStatus(value)
}

type PropertiesType string

const (
	BoatRamp PropertiesType = "Boat Ramp"
)

type invalidPropertiesType string
func (x invalidPropertiesType) Error() string { return "invalid PropertiesType: " + string(x) }

func (x *PropertiesType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PropertiesType(value) {
	case BoatRamp: *x = PropertiesType(value); return nil
	}
	return invalidPropertiesType(value)
}

type FeatureType string

const (
	Feature FeatureType = "Feature"
)

type invalidFeatureType string
func (x invalidFeatureType) Error() string { return "invalid FeatureType: " + string(x) }

func (x *FeatureType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FeatureType(value) {
	case Feature: *x = FeatureType(value); return nil
	}
	return invalidFeatureType(value)
}
