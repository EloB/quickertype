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
	Juror            []JurorElement            `json:"juror"`
	Kongoni          []Kongoni                 `json:"kongoni"`
	Ladronism        []LadronismElement        `json:"ladronism"`
	Landlubberly     []LandlubberlyElement     `json:"landlubberly"`
	Listener         []Listener                `json:"listener"`
	Lupus            []LupusElement            `json:"lupus"`
	Maslin           []Maslin                  `json:"maslin"`
	Monazite         []MonaziteElement         `json:"monazite"`
	Monoliteral      []Monoliteral             `json:"monoliteral"`
	Monotheistically []MonotheisticallyElement `json:"monotheistically"`
	Montage          []Montage                 `json:"montage"`
	Moralness        []Moralness               `json:"moralness"`
	Mowra            []*MonaziteClass          `json:"mowra"`
	Mulishly         []Mulishly                `json:"mulishly"`
	Myoscope         []Myoscope                `json:"myoscope"`
	Nach             [][]*int64                `json:"nach"`
	Neuromastic      []Neuromastic             `json:"neuromastic"`
	Noncontributing  []Noncontributing         `json:"noncontributing"`
	Nonnervous       []Nonnervous              `json:"nonnervous"`
	Nonvaluation     []Nonvaluation            `json:"nonvaluation"`
	Occupationalist  []OccupationalistElement  `json:"occupationalist"`
	Outrival         []OutrivalElement         `json:"outrival"`
	Paleographically []Paleographically        `json:"paleographically"`
	Pamphletwise     []Pamphletwise            `json:"pamphletwise"`
	Pediatrics       []Pediatric               `json:"pediatrics"`
	Perceptive       []bool                    `json:"perceptive"`
	Piaculum         []PiaculumElement         `json:"piaculum"`
	Piccadilly       []Piccadilly              `json:"piccadilly"`
	Piffler          []Piffler                 `json:"piffler"`
	Pithful          []Pithful                 `json:"pithful"`
	Placuntitis      []Placuntiti              `json:"placuntitis"`
	Plectopterous    []Plectopterous           `json:"plectopterous"`
	Pneumocele       []*Pneumocele             `json:"pneumocele"`
	Poliorcetic      []Poliorcetic             `json:"poliorcetic"`
	Poormaster       []Poormaster              `json:"poormaster"`
	Potwhisky        []PotwhiskyElement        `json:"potwhisky"`
	Practicalizer    []Practicalizer           `json:"practicalizer"`
	Prefreshman      []PrefreshmanElement      `json:"prefreshman"`
	Prehensility     []Prehensility            `json:"prehensility"`
	Prevoidance      []Prevoidance             `json:"prevoidance"`
	Probant          []map[string]*int64       `json:"probant"`
	Protext          []Protext                 `json:"protext"`
}

type JurorClass struct {
	Adipsy          interface{} `json:"adipsy"`
	Auxiliator      interface{} `json:"auxiliator"`
	Benda           interface{} `json:"benda"`
	Benjamin        interface{} `json:"benjamin"`
	Brandling       interface{} `json:"brandling"`
	Epicurishly     interface{} `json:"epicurishly"`
	Eremochaetous   interface{} `json:"eremochaetous"`
	Marten          interface{} `json:"marten"`
	Monocline       interface{} `json:"monocline"`
	Olea            interface{} `json:"Olea"`
	Palgat          interface{} `json:"palgat"`
	Pennyworth      interface{} `json:"pennyworth"`
	Pioury          interface{} `json:"pioury"`
	Pragmatistic    interface{} `json:"pragmatistic"`
	Stylelessness   interface{} `json:"stylelessness"`
	Systematical    interface{} `json:"systematical"`
	Thready         interface{} `json:"thready"`
	Uncontemporary  interface{} `json:"uncontemporary"`
	Uncouched       interface{} `json:"uncouched"`
	Uninhabitedness interface{} `json:"uninhabitedness"`
}

type LadronismClass struct {
	Acclaimer     interface{} `json:"acclaimer"`
	Achree        interface{} `json:"achree"`
	Base          interface{} `json:"base"`
	Conundrumize  interface{} `json:"conundrumize"`
	Degerminator  interface{} `json:"degerminator"`
	Describable   interface{} `json:"describable"`
	Exasperatedly interface{} `json:"exasperatedly"`
	Heroine       interface{} `json:"heroine"`
	Indazin       interface{} `json:"indazin"`
	Luteous       interface{} `json:"luteous"`
	Papular       interface{} `json:"papular"`
	Pritch        interface{} `json:"pritch"`
	Prodenia      interface{} `json:"Prodenia"`
	Seege         interface{} `json:"seege"`
	Shopgirl      interface{} `json:"shopgirl"`
	Tragedietta   interface{} `json:"tragedietta"`
	Unsparse      interface{} `json:"unsparse"`
	Uplook        interface{} `json:"uplook"`
	Vermiformis   interface{} `json:"vermiformis"`
	Whafabout     interface{} `json:"whafabout"`
}

type LandlubberlyClass struct {
	Acropoleis      interface{} `json:"acropoleis"`
	Aminate         interface{} `json:"aminate"`
	Amyraldism      interface{} `json:"Amyraldism"`
	Bipenniform     interface{} `json:"bipenniform"`
	Bugre           interface{} `json:"bugre"`
	Calycule        interface{} `json:"calycule"`
	Caoutchouc      interface{} `json:"caoutchouc"`
	Disprover       interface{} `json:"disprover"`
	Fitroot         interface{} `json:"fitroot"`
	Fulgently       interface{} `json:"fulgently"`
	Kickup          interface{} `json:"kickup"`
	Laevoversion    interface{} `json:"laevoversion"`
	Moter           interface{} `json:"moter"`
	Objectivity     interface{} `json:"objectivity"`
	Posterity       interface{} `json:"posterity"`
	Postnuptial     interface{} `json:"postnuptial"`
	Precedentary    interface{} `json:"precedentary"`
	Saddling        interface{} `json:"saddling"`
	Subcurrent      interface{} `json:"subcurrent"`
	Unrecriminative interface{} `json:"unrecriminative"`
}

type LupusClass struct {
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Chlorioninae    *int64      `json:"Chlorioninae,omitempty"`
	Corvinae        *int64      `json:"Corvinae,omitempty"`
	Crassina        *int64      `json:"Crassina,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Exiguity        *int64      `json:"exiguity,omitempty"`
	Farcist         *int64      `json:"farcist,omitempty"`
	Holographical   *int64      `json:"holographical,omitempty"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Ichthyophagan   *int64      `json:"ichthyophagan,omitempty"`
	Implacable      *int64      `json:"implacable,omitempty"`
	Nonbookish      interface{} `json:"nonbookish"`
	Outshiner       *int64      `json:"outshiner,omitempty"`
	Overweather     *int64      `json:"overweather,omitempty"`
	Protonegroid    *int64      `json:"protonegroid,omitempty"`
	Shallowish      *int64      `json:"shallowish,omitempty"`
	Snoke           *int64      `json:"snoke,omitempty"`
	Snout           *int64      `json:"snout,omitempty"`
	Surveillance    *int64      `json:"surveillance,omitempty"`
	Threshingtime   *int64      `json:"threshingtime,omitempty"`
	Thysanocarpus   *int64      `json:"Thysanocarpus,omitempty"`
	Unsignificantly *int64      `json:"unsignificantly,omitempty"`
	Unsnap          *int64      `json:"unsnap,omitempty"`
	Vendible        *int64      `json:"vendible,omitempty"`
}

type Maslin struct {
	Alicant         *int64      `json:"Alicant,omitempty"`
	Antiatonement   interface{} `json:"antiatonement"`
	Anticorrosive   *int64      `json:"anticorrosive,omitempty"`
	Aphidozer       interface{} `json:"aphidozer"`
	Bakuninist      interface{} `json:"Bakuninist"`
	Be              *int64      `json:"be,omitempty"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Chub            *int64      `json:"chub,omitempty"`
	Cuprosilicon    *int64      `json:"cuprosilicon,omitempty"`
	Curtailedly     *int64      `json:"curtailedly,omitempty"`
	Dellenite       *int64      `json:"dellenite,omitempty"`
	Dimitry         *int64      `json:"Dimitry,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Edifying        interface{} `json:"edifying"`
	Ethmoiditis     *int64      `json:"ethmoiditis,omitempty"`
	Gastralgy       interface{} `json:"gastralgy"`
	Goatherd        *int64      `json:"goatherd,omitempty"`
	Hammerdress     *int64      `json:"hammerdress,omitempty"`
	Hangfire        interface{} `json:"hangfire"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Lacunosity      *int64      `json:"lacunosity,omitempty"`
	Longiloquence   interface{} `json:"longiloquence"`
	Mameliere       *int64      `json:"mameliere,omitempty"`
	Motherless      interface{} `json:"motherless"`
	Nonbookish      interface{} `json:"nonbookish"`
	Noncorrodible   interface{} `json:"noncorrodible"`
	Nonsensicality  interface{} `json:"nonsensicality"`
	Oafishly        *int64      `json:"oafishly,omitempty"`
	Pfund           interface{} `json:"pfund"`
	Preadvisory     interface{} `json:"preadvisory"`
	Retroflexed     interface{} `json:"retroflexed"`
	Saccharulmic    *int64      `json:"saccharulmic,omitempty"`
	Scowlful        *int64      `json:"scowlful,omitempty"`
	Secluded        interface{} `json:"secluded"`
	Slackage        interface{} `json:"slackage"`
	Sphaeridial     *int64      `json:"sphaeridial,omitempty"`
	Spondulics      interface{} `json:"spondulics"`
	Subsecive       *int64      `json:"subsecive,omitempty"`
	Swellmobsman    interface{} `json:"swellmobsman"`
	Trachyglossate  *int64      `json:"trachyglossate,omitempty"`
	Trialogue       interface{} `json:"trialogue"`
	Unassuaged      *int64      `json:"unassuaged,omitempty"`
	Ungross         interface{} `json:"ungross"`
	Unjudiciously   interface{} `json:"unjudiciously"`
}

type MonaziteClass struct {
	Catharticalness float64     `json:"catharticalness"`
	Chirotherium    int64       `json:"Chirotherium"`
	Disdiapason     string      `json:"disdiapason"`
	Homocerc        bool        `json:"homocerc"`
	Nonbookish      interface{} `json:"nonbookish"`
}

type MonotheisticallyClass struct {
	Blaspheme          interface{} `json:"blaspheme"`
	Catharticalness    *float64    `json:"catharticalness,omitempty"`
	Celiosalpingectomy interface{} `json:"celiosalpingectomy"`
	Chirotherium       *int64      `json:"Chirotherium,omitempty"`
	Consummativeness   interface{} `json:"consummativeness"`
	Disdiapason        *string     `json:"disdiapason,omitempty"`
	Egestive           interface{} `json:"egestive"`
	Enchylema          interface{} `json:"enchylema"`
	Gasconade          interface{} `json:"gasconade"`
	Holidayer          interface{} `json:"holidayer"`
	Homocerc           *bool       `json:"homocerc,omitempty"`
	Intuitionalism     interface{} `json:"intuitionalism"`
	Lophiostomate      interface{} `json:"lophiostomate"`
	Nonbookish         interface{} `json:"nonbookish"`
	Nonvolition        interface{} `json:"nonvolition"`
	Palatableness      interface{} `json:"palatableness"`
	Pimpery            interface{} `json:"pimpery"`
	Previolation       interface{} `json:"previolation"`
	Reconveyance       interface{} `json:"reconveyance"`
	Registership       interface{} `json:"registership"`
	Rhyacolite         interface{} `json:"rhyacolite"`
	Smithereens        interface{} `json:"smithereens"`
	Superedification   interface{} `json:"superedification"`
	Trust              interface{} `json:"trust"`
	Whitestone         interface{} `json:"whitestone"`
}

type Noncontributing struct {
	Estevin     string      `json:"estevin"`
	Jolterhead  float64     `json:"jolterhead"`
	Sauternes   int64       `json:"sauternes"`
	Sparsely    bool        `json:"sparsely"`
	Unrequested interface{} `json:"unrequested"`
}

type OccupationalistClass struct {
	Beholdable       interface{} `json:"beholdable"`
	Brotuliform      interface{} `json:"brotuliform"`
	Chimakum         interface{} `json:"Chimakum"`
	Doodler          interface{} `json:"doodler"`
	Emulsin          interface{} `json:"emulsin"`
	Fin              interface{} `json:"Fin"`
	Flourishing      interface{} `json:"flourishing"`
	Flueless         interface{} `json:"flueless"`
	Furtively        interface{} `json:"furtively"`
	Gritter          interface{} `json:"gritter"`
	Interwish        interface{} `json:"interwish"`
	Monoxylic        interface{} `json:"monoxylic"`
	Myristic         interface{} `json:"myristic"`
	Nightwear        interface{} `json:"nightwear"`
	Peruser          interface{} `json:"peruser"`
	Theoastrological interface{} `json:"theoastrological"`
	Thumby           interface{} `json:"thumby"`
	Tingitid         interface{} `json:"tingitid"`
	Trailless        interface{} `json:"trailless"`
	Unpocketed       interface{} `json:"unpocketed"`
}

type OutrivalClass struct {
	Adroitly        interface{} `json:"adroitly"`
	Bridehood       interface{} `json:"bridehood"`
	Castoroides     interface{} `json:"Castoroides"`
	Czechoslovak    interface{} `json:"Czechoslovak"`
	Diagenesis      interface{} `json:"diagenesis"`
	Dihexahedron    interface{} `json:"dihexahedron"`
	Dopester        interface{} `json:"dopester"`
	Eumerism        interface{} `json:"eumerism"`
	Flyness         interface{} `json:"flyness"`
	Fouler          interface{} `json:"fouler"`
	Laudanosine     interface{} `json:"laudanosine"`
	Lingulidae      interface{} `json:"Lingulidae"`
	Minutary        interface{} `json:"minutary"`
	Mitra           interface{} `json:"mitra"`
	Opisthorchiasis interface{} `json:"opisthorchiasis"`
	Pensively       interface{} `json:"pensively"`
	Pubigerous      interface{} `json:"pubigerous"`
	Rebellious      interface{} `json:"rebellious"`
	Recodify        interface{} `json:"recodify"`
	Unpaced         interface{} `json:"unpaced"`
}

type PiaculumClass struct {
	Alada           *int64      `json:"alada,omitempty"`
	Amphistomous    *int64      `json:"amphistomous,omitempty"`
	Boysenberry     *int64      `json:"boysenberry,omitempty"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Decardinalize   *int64      `json:"decardinalize,omitempty"`
	Discouragement  *int64      `json:"discouragement,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Doitrified      *int64      `json:"doitrified,omitempty"`
	Hexaspermous    *int64      `json:"hexaspermous,omitempty"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Insinking       *int64      `json:"insinking,omitempty"`
	Loathfulness    *int64      `json:"loathfulness,omitempty"`
	Miasmatical     *int64      `json:"miasmatical,omitempty"`
	Neurofibril     *int64      `json:"neurofibril,omitempty"`
	Nonbookish      interface{} `json:"nonbookish"`
	Phonendoscope   *int64      `json:"phonendoscope,omitempty"`
	Pilferment      *int64      `json:"pilferment,omitempty"`
	Predismissory   *int64      `json:"predismissory,omitempty"`
	Preinscription  *int64      `json:"preinscription,omitempty"`
	Quotative       *int64      `json:"quotative,omitempty"`
	Sienna          *int64      `json:"sienna,omitempty"`
	Thorax          *int64      `json:"thorax,omitempty"`
	Yachting        *int64      `json:"yachting,omitempty"`
	Zipper          *int64      `json:"Zipper,omitempty"`
}

type Pneumocele struct {
	Carbonarism     interface{} `json:"Carbonarism"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Cineolic        interface{} `json:"cineolic"`
	Cobbly          interface{} `json:"cobbly"`
	Conchyliferous  interface{} `json:"conchyliferous"`
	Congregation    interface{} `json:"congregation"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Enterotomy      interface{} `json:"enterotomy"`
	Entophytal      interface{} `json:"entophytal"`
	Fewtrils        interface{} `json:"fewtrils"`
	Herem           interface{} `json:"herem"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Koniga          interface{} `json:"Koniga"`
	Meticulosity    interface{} `json:"meticulosity"`
	Micky           interface{} `json:"Micky"`
	Mismarriage     interface{} `json:"mismarriage"`
	Neurotrophic    interface{} `json:"neurotrophic"`
	Nonbookish      interface{} `json:"nonbookish"`
	Persuasively    interface{} `json:"persuasively"`
	Replaceable     interface{} `json:"replaceable"`
	Silex           interface{} `json:"silex"`
	Taillight       interface{} `json:"taillight"`
	Unjealous       interface{} `json:"unjealous"`
	Visitorial      interface{} `json:"visitorial"`
}

type PotwhiskyClass struct {
	Arciform          interface{} `json:"arciform"`
	Cresolin          interface{} `json:"cresolin"`
	Disheartener      interface{} `json:"disheartener"`
	Disproportionable interface{} `json:"disproportionable"`
	Euchorda          interface{} `json:"Euchorda"`
	Ferryway          interface{} `json:"ferryway"`
	Filamentiferous   interface{} `json:"filamentiferous"`
	Flemish           interface{} `json:"flemish"`
	Forgainst         interface{} `json:"forgainst"`
	Grainering        interface{} `json:"grainering"`
	Irrevoluble       interface{} `json:"irrevoluble"`
	Kindredship       interface{} `json:"kindredship"`
	Pinguitudinous    interface{} `json:"pinguitudinous"`
	Simpletonic       interface{} `json:"simpletonic"`
	Singsong          interface{} `json:"singsong"`
	Submergement      interface{} `json:"submergement"`
	Supraoesophagal   interface{} `json:"supraoesophagal"`
	Thrashel          interface{} `json:"thrashel"`
	Tyremesis         interface{} `json:"tyremesis"`
	Yoruba            interface{} `json:"Yoruba"`
}

type PrefreshmanClass struct {
	Azorubine     interface{} `json:"azorubine"`
	Choroiditis   interface{} `json:"choroiditis"`
	Coagulatory   interface{} `json:"coagulatory"`
	Cyclorama     interface{} `json:"cyclorama"`
	Dolphus       interface{} `json:"Dolphus"`
	Duckhearted   interface{} `json:"duckhearted"`
	Ficus         interface{} `json:"Ficus"`
	Gemaric       interface{} `json:"Gemaric"`
	Jugation      interface{} `json:"jugation"`
	Myoliposis    interface{} `json:"myoliposis"`
	Nonnomination interface{} `json:"nonnomination"`
	Palay         interface{} `json:"palay"`
	Pentactinal   interface{} `json:"pentactinal"`
	Phaet         interface{} `json:"Phaet"`
	Piquant       interface{} `json:"piquant"`
	Registration  interface{} `json:"registration"`
	Remancipation interface{} `json:"remancipation"`
	Scutatiform   interface{} `json:"scutatiform"`
	Theodolite    interface{} `json:"theodolite"`
	Underward     interface{} `json:"underward"`
}

type JurorElement struct {
	Bool       *bool
	JurorClass *JurorClass
}

func (x *JurorElement) UnmarshalJSON(data []byte) error {
	x.JurorClass = nil
	var c JurorClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JurorClass = &c
	}
	return nil
}

func (x *JurorElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.JurorClass != nil, x.JurorClass, false, nil, false, nil, false)
}

type Kongoni struct {
	IntegerArray []int64
	IntegerMap   map[string]int64
}

func (x *Kongoni) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Kongoni) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type LadronismElement struct {
	Double         *float64
	LadronismClass *LadronismClass
	String         *string
}

func (x *LadronismElement) UnmarshalJSON(data []byte) error {
	x.LadronismClass = nil
	var c LadronismClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LadronismClass = &c
	}
	return nil
}

func (x *LadronismElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, x.LadronismClass != nil, x.LadronismClass, false, nil, false, nil, false)
}

type LandlubberlyElement struct {
	Bool              *bool
	Integer           *int64
	LandlubberlyClass *LandlubberlyClass
}

func (x *LandlubberlyElement) UnmarshalJSON(data []byte) error {
	x.LandlubberlyClass = nil
	var c LandlubberlyClass
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LandlubberlyClass = &c
	}
	return nil
}

func (x *LandlubberlyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, false, nil, x.LandlubberlyClass != nil, x.LandlubberlyClass, false, nil, false, nil, false)
}

type Listener struct {
	Integer   *int64
	NullArray []interface{}
}

func (x *Listener) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Listener) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type LupusElement struct {
	Integer    *int64
	LupusClass *LupusClass
}

func (x *LupusElement) UnmarshalJSON(data []byte) error {
	x.LupusClass = nil
	var c LupusClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LupusClass = &c
	}
	return nil
}

func (x *LupusElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.LupusClass != nil, x.LupusClass, false, nil, false, nil, false)
}

type MonaziteElement struct {
	Double        *float64
	MonaziteClass *MonaziteClass
}

func (x *MonaziteElement) UnmarshalJSON(data []byte) error {
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *MonaziteElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type Monoliteral struct {
	Bool      *bool
	NullArray []interface{}
}

func (x *Monoliteral) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Monoliteral) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type MonotheisticallyElement struct {
	MonotheisticallyClass *MonotheisticallyClass
	NullArray             []interface{}
}

func (x *MonotheisticallyElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.MonotheisticallyClass = nil
	var c MonotheisticallyClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonotheisticallyClass = &c
	}
	return nil
}

func (x *MonotheisticallyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.MonotheisticallyClass != nil, x.MonotheisticallyClass, false, nil, false, nil, false)
}

type Montage struct {
	Double    *float64
	NullArray []interface{}
	String    *string
}

func (x *Montage) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Montage) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type Moralness struct {
	Double    *float64
	NullArray []interface{}
}

func (x *Moralness) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Moralness) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, true)
}

type Mulishly struct {
	Double       *float64
	IntegerArray []int64
}

func (x *Mulishly) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Mulishly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, true)
}

type Myoscope struct {
	Bool      *bool
	Integer   *int64
	NullArray []interface{}
}

func (x *Myoscope) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Myoscope) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type Neuromastic struct {
	Double    *float64
	NullArray []interface{}
}

func (x *Neuromastic) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Neuromastic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type Nonnervous struct {
	Bool    *bool
	Integer *int64
}

func (x *Nonnervous) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Nonnervous) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
}

type Nonvaluation struct {
	Bool      *bool
	Double    *float64
	NullArray []interface{}
}

func (x *Nonvaluation) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Nonvaluation) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type OccupationalistElement struct {
	NullArray            []interface{}
	OccupationalistClass *OccupationalistClass
}

func (x *OccupationalistElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.OccupationalistClass = nil
	var c OccupationalistClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.OccupationalistClass = &c
	}
	return nil
}

func (x *OccupationalistElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.OccupationalistClass != nil, x.OccupationalistClass, false, nil, false, nil, true)
}

type OutrivalElement struct {
	Double        *float64
	OutrivalClass *OutrivalClass
}

func (x *OutrivalElement) UnmarshalJSON(data []byte) error {
	x.OutrivalClass = nil
	var c OutrivalClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.OutrivalClass = &c
	}
	return nil
}

func (x *OutrivalElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.OutrivalClass != nil, x.OutrivalClass, false, nil, false, nil, true)
}

type Paleographically struct {
	Double   *float64
	UnionMap map[string]*int64
}

func (x *Paleographically) UnmarshalJSON(data []byte) error {
	x.UnionMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, false, nil, true, &x.UnionMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Paleographically) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, false, nil, x.UnionMap != nil, x.UnionMap, false, nil, false)
}

type Pamphletwise struct {
	Integer    *int64
	IntegerMap map[string]int64
	String     *string
}

func (x *Pamphletwise) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Pamphletwise) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Pediatric struct {
	Bool   *bool
	Double *float64
}

func (x *Pediatric) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Pediatric) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, true)
}

type PiaculumElement struct {
	Double        *float64
	PiaculumClass *PiaculumClass
}

func (x *PiaculumElement) UnmarshalJSON(data []byte) error {
	x.PiaculumClass = nil
	var c PiaculumClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PiaculumClass = &c
	}
	return nil
}

func (x *PiaculumElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PiaculumClass != nil, x.PiaculumClass, false, nil, false, nil, false)
}

type Piccadilly struct {
	Double *float64
	String *string
}

func (x *Piccadilly) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, nil, &x.String, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Piccadilly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, x.String, false, nil, false, nil, false, nil, false, nil, true)
}

type Piffler struct {
	MonaziteClass *MonaziteClass
	NullArray     []interface{}
}

func (x *Piffler) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Piffler) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type Pithful struct {
	Bool    *bool
	Integer *int64
}

func (x *Pithful) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Pithful) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, true)
}

type Placuntiti struct {
	Integer    *int64
	IntegerMap map[string]int64
}

func (x *Placuntiti) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Placuntiti) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Plectopterous struct {
	Double     *float64
	IntegerMap map[string]int64
}

func (x *Plectopterous) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Plectopterous) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Poliorcetic struct {
	Bool          *bool
	MonaziteClass *MonaziteClass
}

func (x *Poliorcetic) UnmarshalJSON(data []byte) error {
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Poliorcetic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type Poormaster struct {
	IntegerArray []int64
	IntegerMap   map[string]int64
}

func (x *Poormaster) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Poormaster) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type PotwhiskyElement struct {
	Integer        *int64
	PotwhiskyClass *PotwhiskyClass
}

func (x *PotwhiskyElement) UnmarshalJSON(data []byte) error {
	x.PotwhiskyClass = nil
	var c PotwhiskyClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.PotwhiskyClass = &c
	}
	return nil
}

func (x *PotwhiskyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.PotwhiskyClass != nil, x.PotwhiskyClass, false, nil, false, nil, true)
}

type Practicalizer struct {
	MonaziteClass *MonaziteClass
	NullArray     []interface{}
	String        *string
}

func (x *Practicalizer) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Practicalizer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.NullArray != nil, x.NullArray, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type PrefreshmanElement struct {
	NullArray        []interface{}
	PrefreshmanClass *PrefreshmanClass
	String           *string
}

func (x *PrefreshmanElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.PrefreshmanClass = nil
	var c PrefreshmanClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PrefreshmanClass = &c
	}
	return nil
}

func (x *PrefreshmanElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.NullArray != nil, x.NullArray, x.PrefreshmanClass != nil, x.PrefreshmanClass, false, nil, false, nil, false)
}

type Prehensility struct {
	Bool          *bool
	MonaziteClass *MonaziteClass
	NullArray     []interface{}
}

func (x *Prehensility) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Prehensility) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type Prevoidance struct {
	Integer       *int64
	IntegerArray  []int64
	MonaziteClass *MonaziteClass
}

func (x *Prevoidance) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Prevoidance) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
}

type Protext struct {
	Bool          *bool
	IntegerArray  []int64
	MonaziteClass *MonaziteClass
}

func (x *Protext) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.MonaziteClass = nil
	var c MonaziteClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MonaziteClass = &c
	}
	return nil
}

func (x *Protext) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, x.MonaziteClass != nil, x.MonaziteClass, false, nil, false, nil, false)
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
