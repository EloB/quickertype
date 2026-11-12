// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	Designation   string     `json:"designation"`
	DiscoveryDate time.Time  `json:"discovery_date"`
	HMag          *string    `json:"h_mag,omitempty"`
	IDeg          string     `json:"i_deg"`
	MoidAu        string     `json:"moid_au"`
	OrbitClass    OrbitClass `json:"orbit_class"`
	PeriodYr      *string    `json:"period_yr,omitempty"`
	Pha           Pha        `json:"pha"`
	QAu1          string     `json:"q_au_1"`
	QAu2          *string    `json:"q_au_2,omitempty"`
}

type OrbitClass string

const (
	Apollo                       OrbitClass = "Apollo"
	Amor                         OrbitClass = "Amor"
	Aten                         OrbitClass = "Aten"
	Comet                        OrbitClass = "Comet"
	JupiterFamilyComet           OrbitClass = "Jupiter-family Comet"
	HalleyTypeComet              OrbitClass = "Halley-type Comet*"
	ParabolicComet               OrbitClass = "Parabolic Comet"
	OrbitClassJupiterFamilyComet OrbitClass = "Jupiter-family Comet*"
	EnckeTypeComet               OrbitClass = "Encke-type Comet"
)

type invalidOrbitClass string
func (x invalidOrbitClass) Error() string { return "invalid OrbitClass: " + string(x) }

func (x *OrbitClass) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch OrbitClass(value) {
	case Apollo, Amor, Aten, Comet, JupiterFamilyComet, HalleyTypeComet, ParabolicComet, OrbitClassJupiterFamilyComet, EnckeTypeComet: *x = OrbitClass(value); return nil
	}
	return invalidOrbitClass(value)
}

type Pha string

const (
	Y  Pha = "Y"
	N  Pha = "N"
	NA Pha = "n/a"
)

type invalidPha string
func (x invalidPha) Error() string { return "invalid Pha: " + string(x) }

func (x *Pha) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Pha(value) {
	case Y, N, NA: *x = Pha(value); return nil
	}
	return invalidPha(value)
}
