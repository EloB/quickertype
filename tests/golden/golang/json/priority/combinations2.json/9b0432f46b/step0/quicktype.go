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
	Abranchiata      []Abranchiata          `json:"Abranchiata"`
	Academe          []Academe              `json:"academe"`
	Acquirable       []Acquirable           `json:"acquirable"`
	Aerometry        []Aerometry            `json:"aerometry"`
	Alexin           []Alexin               `json:"alexin"`
	Alleviate        []AlleviateElement     `json:"alleviate"`
	Amaas            []Amaa                 `json:"amaas"`
	Ambassage        []Ambassage            `json:"ambassage"`
	Amphithyron      []*Amphithyron         `json:"amphithyron"`
	Andriana         []*string              `json:"Andriana"`
	Ankee            []AnkeeElement         `json:"ankee"`
	Annihilator      []map[string]*int64    `json:"annihilator"`
	Annulose         interface{}            `json:"annulose"`
	Ansarie          []AnsarieElement       `json:"Ansarie"`
	Aphasia          []Aphasia              `json:"aphasia"`
	Asprawl          []Asprawl              `json:"asprawl"`
	Attractive       []*bool                `json:"attractive"`
	Barksome         map[string]int64       `json:"barksome"`
	Bedesman         []Bedesman             `json:"bedesman"`
	Belard           []Belard               `json:"belard"`
	Bocking          []Bocking              `json:"bocking"`
	Brawlingly       []Brawlingly           `json:"brawlingly"`
	Brookie          []Brookie              `json:"brookie"`
	Bumboatman       []Bumboatman           `json:"bumboatman"`
	Bystreet         []interface{}          `json:"bystreet"`
	Calaverite       []Calaverite           `json:"calaverite"`
	Catallactic      []Catallactic          `json:"catallactic"`
	Cemental         []Cemental             `json:"cemental"`
	Chytridiaceae    []ChytridiaceaeElement `json:"Chytridiaceae"`
	Discordia        []DiscordiaElement     `json:"Discordia"`
	Endomyces        []Endomyce             `json:"Endomyces"`
	Epinephelidae    []Epinephelidae        `json:"Epinephelidae"`
	Eupatorium       []Eupatorium           `json:"Eupatorium"`
	Gryphosaurus     []GryphosaurusElement  `json:"Gryphosaurus"`
	Koryak           []Koryak               `json:"Koryak"`
	Lavinia          []LaviniaElement       `json:"Lavinia"`
	Oskar            []OskarElement         `json:"Oskar"`
	Rebecca          []RebeccaElement       `json:"Rebecca"`
	Rhomboganoidei   []Rhomboganoidei       `json:"Rhomboganoidei"`
	Rigsmal          bool                   `json:"Rigsmal"`
	Ruellia          []Ruellia              `json:"Ruellia"`
	School           []School               `json:"School"`
	Shakespearolater []Shakespearolater     `json:"Shakespearolater"`
	Svan             []float64              `json:"Svan"`
	Wayao            map[string]float64     `json:"Wayao"`
}

type AlleviateClass struct {
	Apriori         interface{} `json:"apriori"`
	Beggarer        interface{} `json:"beggarer"`
	Brokenheartedly interface{} `json:"brokenheartedly"`
	Debilitation    interface{} `json:"debilitation"`
	Frike           interface{} `json:"frike"`
	Gastrolith      interface{} `json:"gastrolith"`
	Hulsean         interface{} `json:"Hulsean"`
	Orthocentric    interface{} `json:"orthocentric"`
	Petaly          interface{} `json:"petaly"`
	Probudgeting    interface{} `json:"probudgeting"`
	Reacquire       interface{} `json:"reacquire"`
	Scow            interface{} `json:"scow"`
	Shutoff         interface{} `json:"shutoff"`
	Subcontiguous   interface{} `json:"subcontiguous"`
	Suffumigate     interface{} `json:"suffumigate"`
	Transformable   interface{} `json:"transformable"`
	Uncoroneted     interface{} `json:"uncoroneted"`
	Unparking       interface{} `json:"unparking"`
	Unvarnishedness interface{} `json:"unvarnishedness"`
	Wherewithal     interface{} `json:"wherewithal"`
}

type Rebecca struct {
	Catharticalness float64     `json:"catharticalness"`
	Chirotherium    int64       `json:"Chirotherium"`
	Disdiapason     string      `json:"disdiapason"`
	Homocerc        bool        `json:"homocerc"`
	Nonbookish      interface{} `json:"nonbookish"`
}

type Amphithyron struct {
	Akroasis        *int64      `json:"akroasis,omitempty"`
	Antiphonical    *int64      `json:"antiphonical,omitempty"`
	Basebred        *int64      `json:"basebred,omitempty"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Conductometric  *int64      `json:"conductometric,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Ensilation      *int64      `json:"ensilation,omitempty"`
	Eyebolt         *int64      `json:"eyebolt,omitempty"`
	Fistulated      *int64      `json:"fistulated,omitempty"`
	Heteropod       *int64      `json:"heteropod,omitempty"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Juniperus       *int64      `json:"Juniperus,omitempty"`
	Labyrinthically *int64      `json:"labyrinthically,omitempty"`
	Martyrization   *int64      `json:"martyrization,omitempty"`
	Mispolicy       *int64      `json:"mispolicy,omitempty"`
	Multipara       *int64      `json:"multipara,omitempty"`
	Nazirite        *int64      `json:"Nazirite,omitempty"`
	Nonbookish      interface{} `json:"nonbookish"`
	Possessorial    *int64      `json:"possessorial,omitempty"`
	Shamed          *int64      `json:"shamed,omitempty"`
	Shelfworn       *int64      `json:"shelfworn,omitempty"`
	Stagnum         *int64      `json:"stagnum,omitempty"`
	Those           *int64      `json:"Those,omitempty"`
	Undecimal       *int64      `json:"undecimal,omitempty"`
}

type AnkeeClass struct {
	Anomoean        interface{} `json:"Anomoean"`
	Barleyhood      interface{} `json:"barleyhood"`
	Befriender      interface{} `json:"befriender"`
	Brutishness     interface{} `json:"brutishness"`
	Cephalalgy      interface{} `json:"cephalalgy"`
	Cirurgian       interface{} `json:"cirurgian"`
	Conventionally  interface{} `json:"conventionally"`
	Jackshay        interface{} `json:"jackshay"`
	Milammeter      interface{} `json:"milammeter"`
	Naja            interface{} `json:"Naja"`
	Ombrological    interface{} `json:"ombrological"`
	Phonasthenia    interface{} `json:"phonasthenia"`
	Retrievableness interface{} `json:"retrievableness"`
	Snakily         interface{} `json:"snakily"`
	Swot            interface{} `json:"swot"`
	Tartlet         interface{} `json:"tartlet"`
	Thiofuran       interface{} `json:"thiofuran"`
	Tracheophone    interface{} `json:"tracheophone"`
	Tuglike         interface{} `json:"tuglike"`
	Unscratchingly  interface{} `json:"unscratchingly"`
}

type AnsarieClass struct {
	Accension      interface{} `json:"accension"`
	Alida          interface{} `json:"Alida"`
	Asteria        interface{} `json:"asteria"`
	Beriberic      interface{} `json:"beriberic"`
	Edgebone       interface{} `json:"edgebone"`
	Gastrodialysis interface{} `json:"gastrodialysis"`
	Geographic     interface{} `json:"geographic"`
	Ictonyx        interface{} `json:"Ictonyx"`
	Metrocele      interface{} `json:"metrocele"`
	Misgraft       interface{} `json:"misgraft"`
	Monteith       interface{} `json:"monteith"`
	Notcher        interface{} `json:"notcher"`
	Prorestriction interface{} `json:"prorestriction"`
	Ramist         interface{} `json:"Ramist"`
	Throatlet      interface{} `json:"throatlet"`
	Unfair         interface{} `json:"unfair"`
	Unsynonymous   interface{} `json:"unsynonymous"`
	Water          interface{} `json:"water"`
	Zestfully      interface{} `json:"zestfully"`
	Zincic         interface{} `json:"zincic"`
}

type ChytridiaceaeClass struct {
	Batidaceae     interface{} `json:"Batidaceae"`
	Brechites      interface{} `json:"Brechites"`
	Codespairer    interface{} `json:"codespairer"`
	Emery          interface{} `json:"Emery"`
	Enervative     interface{} `json:"enervative"`
	Excriminate    interface{} `json:"excriminate"`
	Goshenite      interface{} `json:"goshenite"`
	Grime          interface{} `json:"grime"`
	Gritten        interface{} `json:"gritten"`
	Hectorly       interface{} `json:"hectorly"`
	Intermediation interface{} `json:"intermediation"`
	Meeterly       interface{} `json:"meeterly"`
	Narraganset    interface{} `json:"Narraganset"`
	Onymatic       interface{} `json:"onymatic"`
	Paddlecock     interface{} `json:"paddlecock"`
	Thana          interface{} `json:"thana"`
	Thornily       interface{} `json:"thornily"`
	Uckia          interface{} `json:"uckia"`
	Unmettle       interface{} `json:"unmettle"`
	Vorticellid    interface{} `json:"vorticellid"`
}

type DiscordiaClass struct {
	Altaic           *int64      `json:"Altaic,omitempty"`
	Amoristic        *int64      `json:"amoristic,omitempty"`
	Blennophthalmia  *int64      `json:"blennophthalmia,omitempty"`
	Catharticalness  *float64    `json:"catharticalness,omitempty"`
	Chirotherium     *int64      `json:"Chirotherium,omitempty"`
	Disciplinability *int64      `json:"disciplinability,omitempty"`
	Disdiapason      *string     `json:"disdiapason,omitempty"`
	Goofer           *int64      `json:"goofer,omitempty"`
	Homocerc         *bool       `json:"homocerc,omitempty"`
	Laryngograph     *int64      `json:"laryngograph,omitempty"`
	Leucitis         *int64      `json:"leucitis,omitempty"`
	Lymphocyst       *int64      `json:"lymphocyst,omitempty"`
	Microcosmology   *int64      `json:"microcosmology,omitempty"`
	Nauseation       *int64      `json:"nauseation,omitempty"`
	Nonbookish       interface{} `json:"nonbookish"`
	Patarin          *int64      `json:"Patarin,omitempty"`
	Preliberal       *int64      `json:"preliberal,omitempty"`
	Prettifier       *int64      `json:"prettifier,omitempty"`
	Rangework        *int64      `json:"rangework,omitempty"`
	Redient          *int64      `json:"redient,omitempty"`
	Subfusiform      *int64      `json:"subfusiform,omitempty"`
	Suicidical       *int64      `json:"suicidical,omitempty"`
	Swow             *int64      `json:"swow,omitempty"`
	Wastrel          *int64      `json:"wastrel,omitempty"`
	Wingle           *int64      `json:"wingle,omitempty"`
}

type GryphosaurusClass struct {
	Amissibility    interface{} `json:"amissibility"`
	Burushaski      interface{} `json:"Burushaski"`
	Citronin        interface{} `json:"citronin"`
	Coplaintiff     interface{} `json:"coplaintiff"`
	Disquisitionary interface{} `json:"disquisitionary"`
	Enoplan         interface{} `json:"enoplan"`
	Faintness       interface{} `json:"faintness"`
	Hebetomy        interface{} `json:"hebetomy"`
	Islandry        interface{} `json:"islandry"`
	Lameduck        interface{} `json:"lameduck"`
	Overbattle      interface{} `json:"overbattle"`
	Overinterested  interface{} `json:"overinterested"`
	Phrenologic     interface{} `json:"phrenologic"`
	Rainband        interface{} `json:"rainband"`
	Shiningly       interface{} `json:"shiningly"`
	Stamineous      interface{} `json:"stamineous"`
	Subscapularis   interface{} `json:"subscapularis"`
	Tahami          interface{} `json:"Tahami"`
	Undaubed        interface{} `json:"undaubed"`
	Underntime      interface{} `json:"underntime"`
}

type LaviniaClass struct {
	Agitable          *int64      `json:"agitable,omitempty"`
	Asininity         *int64      `json:"asininity,omitempty"`
	Benefiter         *int64      `json:"benefiter,omitempty"`
	Bronzelike        *int64      `json:"bronzelike,omitempty"`
	Catharticalness   *float64    `json:"catharticalness,omitempty"`
	Chirotherium      *int64      `json:"Chirotherium,omitempty"`
	Cholesteatomatous *int64      `json:"cholesteatomatous,omitempty"`
	Deprivement       *int64      `json:"deprivement,omitempty"`
	Disdiapason       *string     `json:"disdiapason,omitempty"`
	Flippantness      *int64      `json:"flippantness,omitempty"`
	Fogproof          *int64      `json:"fogproof,omitempty"`
	Homocerc          *bool       `json:"homocerc,omitempty"`
	Merrymeeting      *int64      `json:"merrymeeting,omitempty"`
	Nonbookish        interface{} `json:"nonbookish"`
	Overcareful       *int64      `json:"overcareful,omitempty"`
	Panaris           *int64      `json:"panaris,omitempty"`
	Preacceptance     *int64      `json:"preacceptance,omitempty"`
	Quinoxaline       *int64      `json:"quinoxaline,omitempty"`
	Sig               *int64      `json:"sig,omitempty"`
	Superconfusion    *int64      `json:"superconfusion,omitempty"`
	Tacana            *int64      `json:"Tacana,omitempty"`
	Tillotter         *int64      `json:"tillotter,omitempty"`
	Tranquillize      *int64      `json:"tranquillize,omitempty"`
	Unquestionable    *int64      `json:"unquestionable,omitempty"`
	Uproute           *int64      `json:"uproute,omitempty"`
}

type OskarClass struct {
	Acrobates        interface{} `json:"Acrobates"`
	Beanshooter      interface{} `json:"beanshooter"`
	Bearhound        interface{} `json:"bearhound"`
	Cayuga           interface{} `json:"Cayuga"`
	Guarneri         interface{} `json:"guarneri"`
	Hypochondriacism interface{} `json:"hypochondriacism"`
	Indication       interface{} `json:"indication"`
	Jaculative       interface{} `json:"jaculative"`
	Nagana           interface{} `json:"nagana"`
	Netherlandish    interface{} `json:"Netherlandish"`
	Noctivagous      interface{} `json:"noctivagous"`
	Nonphysiological interface{} `json:"nonphysiological"`
	Praxis           interface{} `json:"praxis"`
	Provision        interface{} `json:"provision"`
	Subterhuman      interface{} `json:"subterhuman"`
	Sunlit           interface{} `json:"sunlit"`
	Syncraniate      interface{} `json:"syncraniate"`
	Teachment        interface{} `json:"teachment"`
	Unmutinous       interface{} `json:"unmutinous"`
	Unstoppable      interface{} `json:"unstoppable"`
}

type Abranchiata struct {
	Integer      *int64
	IntegerArray []int64
}

func (x *Abranchiata) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Abranchiata) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, true)
}

type Academe struct {
	Integer      *int64
	IntegerArray []int64
	IntegerMap   map[string]int64
}

func (x *Academe) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Academe) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Acquirable struct {
	IntegerMap map[string]int64
	UnionArray []*int64
}

func (x *Acquirable) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.UnionArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Acquirable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.UnionArray != nil, x.UnionArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Aerometry struct {
	Bool   *bool
	Double *float64
}

func (x *Aerometry) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Aerometry) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
}

type Alexin struct {
	Bool         *bool
	IntegerArray []int64
}

func (x *Alexin) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Alexin) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type AlleviateElement struct {
	AlleviateClass *AlleviateClass
	UnionArray     []*int64
}

func (x *AlleviateElement) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	x.AlleviateClass = nil
	var c AlleviateClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.UnionArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AlleviateClass = &c
	}
	return nil
}

func (x *AlleviateElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.UnionArray != nil, x.UnionArray, x.AlleviateClass != nil, x.AlleviateClass, false, nil, false, nil, false)
}

type Amaa struct {
	Bool    *bool
	Integer *int64
	Rebecca *Rebecca
}

func (x *Amaa) UnmarshalJSON(data []byte) error {
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *Amaa) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, false, nil, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type Ambassage struct {
	NullArray []interface{}
	String    *string
}

func (x *Ambassage) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Ambassage) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type AnkeeElement struct {
	AnkeeClass   *AnkeeClass
	Integer      *int64
	IntegerArray []int64
}

func (x *AnkeeElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.AnkeeClass = nil
	var c AnkeeClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AnkeeClass = &c
	}
	return nil
}

func (x *AnkeeElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.AnkeeClass != nil, x.AnkeeClass, false, nil, false, nil, false)
}

type AnsarieElement struct {
	AnsarieClass *AnsarieClass
	IntegerArray []int64
}

func (x *AnsarieElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.AnsarieClass = nil
	var c AnsarieClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.AnsarieClass = &c
	}
	return nil
}

func (x *AnsarieElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.AnsarieClass != nil, x.AnsarieClass, false, nil, false, nil, true)
}

type Aphasia struct {
	Integer      *int64
	IntegerArray []int64
}

func (x *Aphasia) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Aphasia) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Asprawl struct {
	Double *float64
	String *string
}

func (x *Asprawl) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Asprawl) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type Bedesman struct {
	Bool   *bool
	Double *float64
	String *string
}

func (x *Bedesman) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Bedesman) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type Belard struct {
	Double       *float64
	IntegerArray []int64
	Rebecca      *Rebecca
}

func (x *Belard) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *Belard) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type Bocking struct {
	Bool         *bool
	IntegerArray []int64
	IntegerMap   map[string]int64
}

func (x *Bocking) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Bocking) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Brawlingly struct {
	NullArray []interface{}
	UnionMap  map[string]*int64
}

func (x *Brawlingly) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.UnionMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Brawlingly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
}

type Brookie struct {
	IntegerArray []int64
	Rebecca      *Rebecca
}

func (x *Brookie) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *Brookie) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type Bumboatman struct {
	NullArray []interface{}
	String    *string
}

func (x *Bumboatman) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.NullArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Bumboatman) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, true)
}

type Calaverite struct {
	IntegerArray []int64
	String       *string
}

func (x *Calaverite) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Calaverite) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Catallactic struct {
	Bool       *bool
	IntegerMap map[string]int64
	NullArray  []interface{}
}

func (x *Catallactic) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Catallactic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Cemental struct {
	Double       *float64
	IntegerArray []int64
	IntegerMap   map[string]int64
}

func (x *Cemental) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Cemental) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type ChytridiaceaeElement struct {
	Bool               *bool
	ChytridiaceaeClass *ChytridiaceaeClass
}

func (x *ChytridiaceaeElement) UnmarshalJSON(data []byte) error {
	x.ChytridiaceaeClass = nil
	var c ChytridiaceaeClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.ChytridiaceaeClass = &c
	}
	return nil
}

func (x *ChytridiaceaeElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.ChytridiaceaeClass != nil, x.ChytridiaceaeClass, false, nil, false, nil, true)
}

type DiscordiaElement struct {
	DiscordiaClass *DiscordiaClass
	IntegerArray   []int64
}

func (x *DiscordiaElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.DiscordiaClass = nil
	var c DiscordiaClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DiscordiaClass = &c
	}
	return nil
}

func (x *DiscordiaElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.DiscordiaClass != nil, x.DiscordiaClass, false, nil, false, nil, false)
}

type Endomyce struct {
	Integer *int64
	String  *string
}

func (x *Endomyce) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Endomyce) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type Epinephelidae struct {
	Bool    *bool
	Integer *int64
	String  *string
}

func (x *Epinephelidae) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Epinephelidae) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type Eupatorium struct {
	IntegerMap map[string]int64
	NullArray  []interface{}
}

func (x *Eupatorium) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Eupatorium) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type GryphosaurusElement struct {
	GryphosaurusClass *GryphosaurusClass
	IntegerArray      []int64
	String            *string
}

func (x *GryphosaurusElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.GryphosaurusClass = nil
	var c GryphosaurusClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.GryphosaurusClass = &c
	}
	return nil
}

func (x *GryphosaurusElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, x.GryphosaurusClass != nil, x.GryphosaurusClass, false, nil, false, nil, false)
}

type Koryak struct {
	String   *string
	UnionMap map[string]*int64
}

func (x *Koryak) UnmarshalJSON(data []byte) error {
	x.UnionMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Koryak) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
}

type LaviniaElement struct {
	LaviniaClass *LaviniaClass
	String       *string
}

func (x *LaviniaElement) UnmarshalJSON(data []byte) error {
	x.LaviniaClass = nil
	var c LaviniaClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LaviniaClass = &c
	}
	return nil
}

func (x *LaviniaElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.LaviniaClass != nil, x.LaviniaClass, false, nil, false, nil, false)
}

type OskarElement struct {
	IntegerArray []int64
	OskarClass   *OskarClass
}

func (x *OskarElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.OskarClass = nil
	var c OskarClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.OskarClass = &c
	}
	return nil
}

func (x *OskarElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.OskarClass != nil, x.OskarClass, false, nil, false, nil, false)
}

type RebeccaElement struct {
	Integer *int64
	Rebecca *Rebecca
	String  *string
}

func (x *RebeccaElement) UnmarshalJSON(data []byte) error {
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *RebeccaElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type Rhomboganoidei struct {
	IntegerArray []int64
	Rebecca      *Rebecca
	String       *string
}

func (x *Rhomboganoidei) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *Rhomboganoidei) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type Ruellia struct {
	Bool    *bool
	Rebecca *Rebecca
	String  *string
}

func (x *Ruellia) UnmarshalJSON(data []byte) error {
	x.Rebecca = nil
	var c Rebecca
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rebecca = &c
	}
	return nil
}

func (x *Ruellia) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, false, nil, x.Rebecca != nil, x.Rebecca, false, nil, false, nil, false)
}

type School struct {
	Integer    *int64
	IntegerMap map[string]int64
}

func (x *School) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *School) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type Shakespearolater struct {
	Double       *float64
	IntegerArray []int64
	String       *string
}

func (x *Shakespearolater) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Shakespearolater) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
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
