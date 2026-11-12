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
	Centrodesmose      string                    `json:"centrodesmose"`
	Cerograph          []CerographElement        `json:"cerograph"`
	Chemotherapeutics  []ChemotherapeuticElement `json:"chemotherapeutics"`
	Cimelia            []CimeliaElement          `json:"cimelia"`
	Citrated           int64                     `json:"citrated"`
	Clinodome          []Clinodome               `json:"clinodome"`
	Coadjust           []CoadjustElement         `json:"coadjust"`
	Consilience        []Consilience             `json:"consilience"`
	Constructor        []Constructor             `json:"constructor"`
	Continuative       []Continuative            `json:"continuative"`
	Credulity          []CredulityElement        `json:"credulity"`
	Creviced           []Creviced                `json:"creviced"`
	Cubiculum          [][]*int64                `json:"cubiculum"`
	Deruralize         []DeruralizeElement       `json:"deruralize"`
	Diaereses          []DiaereseElement         `json:"diaereses"`
	Dissolution        [][]interface{}           `json:"dissolution"`
	Downstroke         []Downstroke              `json:"downstroke"`
	Electrotautomerism []*float64                `json:"electrotautomerism"`
	Eleutheromania     []Eleutheromania          `json:"eleutheromania"`
	Encrust            Encrust                   `json:"encrust"`
	Entomoid           []Entomoid                `json:"entomoid"`
	Epipaleolithic     []Epipaleolithic          `json:"epipaleolithic"`
	Expropriable       []Expropriable            `json:"expropriable"`
	Faggingly          []FagginglyElement        `json:"faggingly"`
	Fenks              []FenkElement             `json:"fenks"`
	Flagmaking         []FlagmakingElement       `json:"flagmaking"`
	Fluorometer        []Fluorometer             `json:"fluorometer"`
	Fulsome            []*int64                  `json:"fulsome"`
	Fuzzy              []Fuzzy                   `json:"fuzzy"`
	Gardenwards        []Gardenward              `json:"gardenwards"`
	Generalissimo      []Generalissimo           `json:"generalissimo"`
	Habeas             []map[string]int64        `json:"habeas"`
	Hemicrystalline    []Hemicrystalline         `json:"hemicrystalline"`
	Hemocoele          []HemocoeleElement        `json:"hemocoele"`
	Hoister            []Hoister                 `json:"hoister"`
	Hyperpiesis        []Hyperpiesi              `json:"hyperpiesis"`
	Hyppish            []Hyppish                 `json:"hyppish"`
	Idealizer          []Idealizer               `json:"idealizer"`
	Incrustator        []Incrustator             `json:"incrustator"`
	Intentiveness      []Intentiveness           `json:"intentiveness"`
	Interacinar        Interacinar               `json:"interacinar"`
	Intercorrelation   [][]int64                 `json:"intercorrelation"`
	Jacutinga          []Jacutinga               `json:"jacutinga"`
}

type CerographClass struct {
	Apotropaion        interface{} `json:"apotropaion"`
	Casuary            interface{} `json:"casuary"`
	Creaker            interface{} `json:"creaker"`
	Disqualification   interface{} `json:"disqualification"`
	Imperatorious      interface{} `json:"imperatorious"`
	Impermeabilize     interface{} `json:"impermeabilize"`
	Metastoma          interface{} `json:"metastoma"`
	Noctidiurnal       interface{} `json:"noctidiurnal"`
	Nonreserve         interface{} `json:"nonreserve"`
	Ophthalmotonometry interface{} `json:"ophthalmotonometry"`
	Pailful            interface{} `json:"pailful"`
	Pigfish            interface{} `json:"pigfish"`
	Pongee             interface{} `json:"pongee"`
	Prosodical         interface{} `json:"prosodical"`
	Scrofuloderm       interface{} `json:"scrofuloderm"`
	Storekeeping       interface{} `json:"storekeeping"`
	Therologist        interface{} `json:"therologist"`
	Tolowa             interface{} `json:"Tolowa"`
	Tradeful           interface{} `json:"tradeful"`
	Unriveting         interface{} `json:"unriveting"`
}

type ChemotherapeuticClass struct {
	Angioneurotic     interface{} `json:"angioneurotic"`
	Availment         interface{} `json:"availment"`
	Bladelet          interface{} `json:"bladelet"`
	Catharticalness   *float64    `json:"catharticalness,omitempty"`
	Caulis            interface{} `json:"caulis"`
	Chalcus           interface{} `json:"chalcus"`
	Chirotherium      *int64      `json:"Chirotherium,omitempty"`
	Disdiapason       *string     `json:"disdiapason,omitempty"`
	Enteradenological interface{} `json:"enteradenological"`
	Homocerc          *bool       `json:"homocerc,omitempty"`
	Imporosity        interface{} `json:"imporosity"`
	Insistently       interface{} `json:"insistently"`
	Intraparietal     interface{} `json:"intraparietal"`
	Ivied             interface{} `json:"ivied"`
	Maureen           interface{} `json:"Maureen"`
	Nonbookish        interface{} `json:"nonbookish"`
	Nostochine        interface{} `json:"nostochine"`
	Nutcracker        interface{} `json:"nutcracker"`
	Ofttimes          interface{} `json:"ofttimes"`
	Phenocryst        interface{} `json:"phenocryst"`
	Precoincident     interface{} `json:"precoincident"`
	Ramiferous        interface{} `json:"ramiferous"`
	Stagmometer       interface{} `json:"stagmometer"`
	Tetherball        interface{} `json:"tetherball"`
	Unshy             interface{} `json:"unshy"`
}

type CimeliaClass struct {
	Catharticalness float64     `json:"catharticalness"`
	Chirotherium    int64       `json:"Chirotherium"`
	Disdiapason     string      `json:"disdiapason"`
	Homocerc        bool        `json:"homocerc"`
	Nonbookish      interface{} `json:"nonbookish"`
}

type CoadjustClass struct {
	Amidosulphonal   interface{} `json:"amidosulphonal"`
	Benny            interface{} `json:"Benny"`
	Catharticalness  *float64    `json:"catharticalness,omitempty"`
	Chirotherium     *int64      `json:"Chirotherium,omitempty"`
	Disdiapason      *string     `json:"disdiapason,omitempty"`
	Ensnare          interface{} `json:"ensnare"`
	Homocerc         *bool       `json:"homocerc,omitempty"`
	Hybridizer       interface{} `json:"hybridizer"`
	Leastwise        interface{} `json:"leastwise"`
	Lof              interface{} `json:"lof"`
	Monkhood         interface{} `json:"monkhood"`
	Netherlandish    interface{} `json:"Netherlandish"`
	Nonbookish       interface{} `json:"nonbookish"`
	Peonism          interface{} `json:"peonism"`
	Phonelescope     interface{} `json:"Phonelescope"`
	Porphyrogeniture interface{} `json:"porphyrogeniture"`
	Preindemnify     interface{} `json:"preindemnify"`
	Rosal            interface{} `json:"rosal"`
	Scalenous        interface{} `json:"scalenous"`
	Scopine          interface{} `json:"scopine"`
	Sedaceae         interface{} `json:"Sedaceae"`
	Suberinize       interface{} `json:"suberinize"`
	Symbiot          interface{} `json:"symbiot"`
	Tablefellow      interface{} `json:"tablefellow"`
	Unchargeable     interface{} `json:"unchargeable"`
}

type CredulityClass struct {
	Ammonolytic          interface{} `json:"ammonolytic"`
	Bushmaster           interface{} `json:"bushmaster"`
	Considering          interface{} `json:"considering"`
	Consuetudinary       interface{} `json:"consuetudinary"`
	Embarras             interface{} `json:"embarras"`
	Fineness             interface{} `json:"fineness"`
	Flaithship           interface{} `json:"flaithship"`
	Flavia               interface{} `json:"Flavia"`
	Gruffly              interface{} `json:"gruffly"`
	Hedychium            interface{} `json:"Hedychium"`
	Leadwort             interface{} `json:"leadwort"`
	Overseriously        interface{} `json:"overseriously"`
	Parabola             interface{} `json:"parabola"`
	Pectinatodenticulate interface{} `json:"pectinatodenticulate"`
	Popean               interface{} `json:"Popean"`
	Pornocrat            interface{} `json:"pornocrat"`
	Quadrisect           interface{} `json:"quadrisect"`
	Seriality            interface{} `json:"seriality"`
	Vamphorn             interface{} `json:"vamphorn"`
	Wharp                interface{} `json:"wharp"`
}

type DeruralizeClass struct {
	Bockerel       interface{} `json:"bockerel"`
	Boulder        interface{} `json:"boulder"`
	Churrus        interface{} `json:"churrus"`
	Counterdigged  interface{} `json:"counterdigged"`
	Dialogite      interface{} `json:"dialogite"`
	Digenic        interface{} `json:"digenic"`
	Dunbird        interface{} `json:"dunbird"`
	Ergatogyne     interface{} `json:"ergatogyne"`
	Fiendful       interface{} `json:"fiendful"`
	Jackrod        interface{} `json:"jackrod"`
	Jehovistic     interface{} `json:"Jehovistic"`
	Paninean       interface{} `json:"Paninean"`
	Panther        interface{} `json:"panther"`
	Placentigerous interface{} `json:"placentigerous"`
	Romney         interface{} `json:"Romney"`
	Sparm          interface{} `json:"sparm"`
	Tocsin         interface{} `json:"tocsin"`
	Unnicked       interface{} `json:"unnicked"`
	Unstavable     interface{} `json:"unstavable"`
	Windfirm       interface{} `json:"windfirm"`
}

type DiaereseClass struct {
	Amoreuxia         interface{} `json:"Amoreuxia"`
	Ani               interface{} `json:"ani"`
	Bernicle          interface{} `json:"bernicle"`
	Blackwasher       interface{} `json:"blackwasher"`
	Blowhard          interface{} `json:"blowhard"`
	Broma             interface{} `json:"broma"`
	Closecross        interface{} `json:"closecross"`
	Congregationalism interface{} `json:"congregationalism"`
	Grayly            interface{} `json:"grayly"`
	Historically      interface{} `json:"historically"`
	Hoast             interface{} `json:"hoast"`
	Irretentive       interface{} `json:"irretentive"`
	Parcener          interface{} `json:"parcener"`
	Pedder            interface{} `json:"pedder"`
	Pseudoanatomic    interface{} `json:"pseudoanatomic"`
	Rhizocarpian      interface{} `json:"rhizocarpian"`
	Samel             interface{} `json:"samel"`
	Silker            interface{} `json:"silker"`
	Subdentated       interface{} `json:"subdentated"`
	Subobscure        interface{} `json:"subobscure"`
}

type Encrust struct {
	Comradely       interface{} `json:"comradely"`
	Diacanthous     interface{} `json:"diacanthous"`
	Feminineness    interface{} `json:"feminineness"`
	Gossamered      interface{} `json:"gossamered"`
	Hibernia        interface{} `json:"Hibernia"`
	Hibiscus        interface{} `json:"Hibiscus"`
	Lepidosauria    interface{} `json:"Lepidosauria"`
	Lollingly       interface{} `json:"lollingly"`
	Manager         interface{} `json:"manager"`
	Mechanic        interface{} `json:"mechanic"`
	Overminuteness  interface{} `json:"overminuteness"`
	Papelonne       interface{} `json:"papelonne"`
	Plebification   interface{} `json:"plebification"`
	Pugmiller       interface{} `json:"pugmiller"`
	Recoveror       interface{} `json:"recoveror"`
	Spermatoblastic interface{} `json:"spermatoblastic"`
	Syllidae        interface{} `json:"Syllidae"`
	Ungyved         interface{} `json:"ungyved"`
	Whirlabout      interface{} `json:"whirlabout"`
	Woodenware      interface{} `json:"woodenware"`
}

type FagginglyClass struct {
	Abranchian      interface{} `json:"abranchian"`
	Aculeiform      interface{} `json:"aculeiform"`
	Adiaphoristic   interface{} `json:"adiaphoristic"`
	Adoptionism     interface{} `json:"adoptionism"`
	Anglic          interface{} `json:"Anglic"`
	Antrotomy       interface{} `json:"antrotomy"`
	Coerciveness    interface{} `json:"coerciveness"`
	Decorist        interface{} `json:"decorist"`
	Duckhood        interface{} `json:"duckhood"`
	Heteromeri      interface{} `json:"Heteromeri"`
	Hypochnose      interface{} `json:"hypochnose"`
	Lochage         interface{} `json:"lochage"`
	Melee           interface{} `json:"melee"`
	Nonconformitant interface{} `json:"nonconformitant"`
	Poinsettia      interface{} `json:"Poinsettia"`
	Putatively      interface{} `json:"putatively"`
	Semivolatile    interface{} `json:"semivolatile"`
	Soleas          interface{} `json:"soleas"`
	Unfastenable    interface{} `json:"unfastenable"`
	Unmillinered    interface{} `json:"unmillinered"`
}

type FenkClass struct {
	Apoise        interface{} `json:"apoise"`
	Astronomize   interface{} `json:"astronomize"`
	Cockhorse     interface{} `json:"cockhorse"`
	Copular       interface{} `json:"copular"`
	Dagomba       interface{} `json:"Dagomba"`
	Draffy        interface{} `json:"draffy"`
	Foreigner     interface{} `json:"foreigner"`
	Guyandot      interface{} `json:"Guyandot"`
	Neurogliosis  interface{} `json:"neurogliosis"`
	Osmious       interface{} `json:"osmious"`
	Palpitate     interface{} `json:"palpitate"`
	Rebukeable    interface{} `json:"rebukeable"`
	Reinwardtia   interface{} `json:"Reinwardtia"`
	Reservatory   interface{} `json:"reservatory"`
	Scalt         interface{} `json:"scalt"`
	Scripturalize interface{} `json:"scripturalize"`
	Tintometer    interface{} `json:"tintometer"`
	Tritoness     interface{} `json:"Tritoness"`
	Undergrade    interface{} `json:"undergrade"`
	Undermountain interface{} `json:"undermountain"`
}

type FlagmakingClass struct {
	Albarco           interface{} `json:"albarco"`
	Bunodonta         interface{} `json:"Bunodonta"`
	Hornify           interface{} `json:"hornify"`
	Hydrocorisae      interface{} `json:"Hydrocorisae"`
	Hypoglossus       interface{} `json:"hypoglossus"`
	Inexpiably        interface{} `json:"inexpiably"`
	Ingratitude       interface{} `json:"ingratitude"`
	Ladyfly           interface{} `json:"ladyfly"`
	Medicament        interface{} `json:"medicament"`
	Monogrammatic     interface{} `json:"monogrammatic"`
	Nobbut            interface{} `json:"nobbut"`
	Notacanthidae     interface{} `json:"Notacanthidae"`
	Polyplacophore    interface{} `json:"polyplacophore"`
	Proexercise       interface{} `json:"proexercise"`
	Protoplast        interface{} `json:"protoplast"`
	Puzzling          interface{} `json:"puzzling"`
	Splanchnoskeleton interface{} `json:"splanchnoskeleton"`
	Unloveliness      interface{} `json:"unloveliness"`
	Unquarantined     interface{} `json:"unquarantined"`
	Unrenounceable    interface{} `json:"unrenounceable"`
}

type HemocoeleClass struct {
	Acrogamy          interface{} `json:"acrogamy"`
	Amelification     interface{} `json:"amelification"`
	Autobiographic    interface{} `json:"autobiographic"`
	Berat             interface{} `json:"berat"`
	Catharticalness   *float64    `json:"catharticalness,omitempty"`
	Chirotherium      *int64      `json:"Chirotherium,omitempty"`
	Disdiapason       *string     `json:"disdiapason,omitempty"`
	Disproportionably interface{} `json:"disproportionably"`
	Erythrite         interface{} `json:"erythrite"`
	Graphic           interface{} `json:"graphic"`
	Hepatological     interface{} `json:"hepatological"`
	Homocerc          *bool       `json:"homocerc,omitempty"`
	Incommensurably   interface{} `json:"incommensurably"`
	Misaffirm         interface{} `json:"misaffirm"`
	Nonbookish        interface{} `json:"nonbookish"`
	Pocketbook        interface{} `json:"pocketbook"`
	Sclerometric      interface{} `json:"sclerometric"`
	Stambouline       interface{} `json:"stambouline"`
	Stickpin          interface{} `json:"stickpin"`
	Tubulure          interface{} `json:"tubulure"`
	Undelated         interface{} `json:"undelated"`
	Unsalt            interface{} `json:"unsalt"`
	Untutelar         interface{} `json:"untutelar"`
	Vagrant           interface{} `json:"vagrant"`
	Walt              interface{} `json:"Walt"`
}

type Interacinar struct {
	Assapan        float64     `json:"assapan"`
	Benefactorship bool        `json:"benefactorship"`
	Triseriatim    string      `json:"triseriatim"`
	Tubbing        int64       `json:"tubbing"`
	Untrimmed      interface{} `json:"untrimmed"`
}

type CerographElement struct {
	CerographClass *CerographClass
	String         *string
}

func (x *CerographElement) UnmarshalJSON(data []byte) error {
	x.CerographClass = nil
	var c CerographClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.CerographClass = &c
	}
	return nil
}

func (x *CerographElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.CerographClass != nil, x.CerographClass, false, nil, false, nil, true)
}

type ChemotherapeuticElement struct {
	ChemotherapeuticClass *ChemotherapeuticClass
	Integer               *int64
}

func (x *ChemotherapeuticElement) UnmarshalJSON(data []byte) error {
	x.ChemotherapeuticClass = nil
	var c ChemotherapeuticClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ChemotherapeuticClass = &c
	}
	return nil
}

func (x *ChemotherapeuticElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.ChemotherapeuticClass != nil, x.ChemotherapeuticClass, false, nil, false, nil, false)
}

type CimeliaElement struct {
	CimeliaClass *CimeliaClass
	IntegerArray []int64
}

func (x *CimeliaElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *CimeliaElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, true)
}

type Clinodome struct {
	Double *float64
	String *string
}

func (x *Clinodome) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Clinodome) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type CoadjustElement struct {
	CoadjustClass *CoadjustClass
	Double        *float64
}

func (x *CoadjustElement) UnmarshalJSON(data []byte) error {
	x.CoadjustClass = nil
	var c CoadjustClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CoadjustClass = &c
	}
	return nil
}

func (x *CoadjustElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CoadjustClass != nil, x.CoadjustClass, false, nil, false, nil, false)
}

type Consilience struct {
	Double     *float64
	IntegerMap map[string]int64
}

func (x *Consilience) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Consilience) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Constructor struct {
	Bool     *bool
	UnionMap map[string]*int64
}

func (x *Constructor) UnmarshalJSON(data []byte) error {
	x.UnionMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Constructor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
}

type Continuative struct {
	IntegerMap map[string]int64
	String     *string
}

func (x *Continuative) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Continuative) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type CredulityElement struct {
	CredulityClass *CredulityClass
	Integer        *int64
	String         *string
}

func (x *CredulityElement) UnmarshalJSON(data []byte) error {
	x.CredulityClass = nil
	var c CredulityClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CredulityClass = &c
	}
	return nil
}

func (x *CredulityElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, x.CredulityClass != nil, x.CredulityClass, false, nil, false, nil, false)
}

type Creviced struct {
	Bool       *bool
	IntegerMap map[string]int64
	String     *string
}

func (x *Creviced) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Creviced) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type DeruralizeElement struct {
	Bool            *bool
	DeruralizeClass *DeruralizeClass
	NullArray       []interface{}
}

func (x *DeruralizeElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.DeruralizeClass = nil
	var c DeruralizeClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DeruralizeClass = &c
	}
	return nil
}

func (x *DeruralizeElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, x.DeruralizeClass != nil, x.DeruralizeClass, false, nil, false, nil, false)
}

type DiaereseElement struct {
	Bool          *bool
	DiaereseClass *DiaereseClass
	IntegerArray  []int64
}

func (x *DiaereseElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.DiaereseClass = nil
	var c DiaereseClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DiaereseClass = &c
	}
	return nil
}

func (x *DiaereseElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, x.DiaereseClass != nil, x.DiaereseClass, false, nil, false, nil, false)
}

type Downstroke struct {
	Bool      *bool
	NullArray []interface{}
	String    *string
}

func (x *Downstroke) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Downstroke) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type Eleutheromania struct {
	Double     *float64
	IntegerMap map[string]int64
	String     *string
}

func (x *Eleutheromania) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Eleutheromania) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Entomoid struct {
	CimeliaClass *CimeliaClass
	Integer      *int64
}

func (x *Entomoid) UnmarshalJSON(data []byte) error {
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Entomoid) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, false)
}

type Epipaleolithic struct {
	Double       *float64
	IntegerArray []int64
}

func (x *Epipaleolithic) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Epipaleolithic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Expropriable struct {
	CimeliaClass *CimeliaClass
	Double       *float64
	NullArray    []interface{}
}

func (x *Expropriable) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Expropriable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, false)
}

type FagginglyElement struct {
	Double         *float64
	FagginglyClass *FagginglyClass
}

func (x *FagginglyElement) UnmarshalJSON(data []byte) error {
	x.FagginglyClass = nil
	var c FagginglyClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FagginglyClass = &c
	}
	return nil
}

func (x *FagginglyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.FagginglyClass != nil, x.FagginglyClass, false, nil, false, nil, false)
}

type FenkElement struct {
	FenkClass *FenkClass
	String    *string
}

func (x *FenkElement) UnmarshalJSON(data []byte) error {
	x.FenkClass = nil
	var c FenkClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FenkClass = &c
	}
	return nil
}

func (x *FenkElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.FenkClass != nil, x.FenkClass, false, nil, false, nil, false)
}

type FlagmakingElement struct {
	Bool            *bool
	Double          *float64
	FlagmakingClass *FlagmakingClass
}

func (x *FlagmakingElement) UnmarshalJSON(data []byte) error {
	x.FlagmakingClass = nil
	var c FlagmakingClass
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FlagmakingClass = &c
	}
	return nil
}

func (x *FlagmakingElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, x.FlagmakingClass != nil, x.FlagmakingClass, false, nil, false, nil, false)
}

type Fluorometer struct {
	Integer *int64
	String  *string
}

func (x *Fluorometer) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Fluorometer) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, false, nil, false, nil, true)
}

type Fuzzy struct {
	Integer  *int64
	UnionMap map[string]*int64
}

func (x *Fuzzy) UnmarshalJSON(data []byte) error {
	x.UnionMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Fuzzy) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
}

type Gardenward struct {
	Bool         *bool
	IntegerArray []int64
	String       *string
}

func (x *Gardenward) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Gardenward) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Generalissimo struct {
	Bool       *bool
	IntegerMap map[string]int64
}

func (x *Generalissimo) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Generalissimo) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type Hemicrystalline struct {
	CimeliaClass *CimeliaClass
	String       *string
}

func (x *Hemicrystalline) UnmarshalJSON(data []byte) error {
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Hemicrystalline) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, false)
}

type HemocoeleElement struct {
	HemocoeleClass *HemocoeleClass
	IntegerArray   []int64
}

func (x *HemocoeleElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.HemocoeleClass = nil
	var c HemocoeleClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.HemocoeleClass = &c
	}
	return nil
}

func (x *HemocoeleElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.HemocoeleClass != nil, x.HemocoeleClass, false, nil, false, nil, false)
}

type Hoister struct {
	CimeliaClass *CimeliaClass
	String       *string
}

func (x *Hoister) UnmarshalJSON(data []byte) error {
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Hoister) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, true)
}

type Hyperpiesi struct {
	CimeliaClass *CimeliaClass
	NullArray    []interface{}
}

func (x *Hyperpiesi) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Hyperpiesi) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, true)
}

type Hyppish struct {
	Bool   *bool
	String *string
}

func (x *Hyppish) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Hyppish) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, false, nil, false, nil, false, nil, false, nil, true)
}

type Idealizer struct {
	CimeliaClass *CimeliaClass
	Integer      *int64
	NullArray    []interface{}
}

func (x *Idealizer) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Idealizer) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.NullArray != nil, x.NullArray, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, false)
}

type Incrustator struct {
	Integer      *int64
	IntegerArray []int64
	String       *string
}

func (x *Incrustator) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Incrustator) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Intentiveness struct {
	CimeliaClass *CimeliaClass
	Double       *float64
	String       *string
}

func (x *Intentiveness) UnmarshalJSON(data []byte) error {
	x.CimeliaClass = nil
	var c CimeliaClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CimeliaClass = &c
	}
	return nil
}

func (x *Intentiveness) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, x.CimeliaClass != nil, x.CimeliaClass, false, nil, false, nil, false)
}

type Jacutinga struct {
	IntegerArray []int64
	UnionMap     map[string]*int64
}

func (x *Jacutinga) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.UnionMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Jacutinga) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
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
