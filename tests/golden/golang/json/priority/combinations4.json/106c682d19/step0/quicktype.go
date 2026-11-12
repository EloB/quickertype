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
	Protrusive         []Protrusive           `json:"protrusive"`
	Pulpitism          []PulpitismElement     `json:"pulpitism"`
	Pyodermia          []PyodermiaElement     `json:"pyodermia"`
	Quebrachine        []QuebrachineElement   `json:"quebrachine"`
	Querier            []Querier              `json:"querier"`
	Rebarbative        []Rebarbative          `json:"rebarbative"`
	Reimagine          []Reimagine            `json:"reimagine"`
	Ressaut            Ressaut                `json:"ressaut"`
	Retrocervical      []Retrocervical        `json:"retrocervical"`
	Revert             []Revert               `json:"revert"`
	Rewrite            []RewriteElement       `json:"rewrite"`
	Saccoderm          []Saccoderm            `json:"saccoderm"`
	Santir             []SantirElement        `json:"santir"`
	Saprophilous       []Saprophilous         `json:"saprophilous"`
	Saxten             []SaxtenElement        `json:"saxten"`
	Scatty             []*Scatty              `json:"scatty"`
	Scoffer            []Scoffer              `json:"scoffer"`
	Scrampum           []Scrampum             `json:"scrampum"`
	Semantic           float64                `json:"semantic"`
	Serpentinic        []Serpentinic          `json:"serpentinic"`
	Shadowable         []Shadowable           `json:"shadowable"`
	Sistering          []SisteringElement     `json:"sistering"`
	Staghunting        []Staghunting          `json:"staghunting"`
	Stagmometer        []Stagmometer          `json:"stagmometer"`
	Stimulability      []Stimulability        `json:"stimulability"`
	Strangleable       []Strangleable         `json:"strangleable"`
	Strenuosity        []StrenuosityElement   `json:"strenuosity"`
	Tabaxir            []Tabaxir              `json:"tabaxir"`
	Talpiform          []Talpiform            `json:"talpiform"`
	Thwack             []Thwack               `json:"thwack"`
	To                 []*float64             `json:"to"`
	Tortricine         []Tortricine           `json:"tortricine"`
	Truantcy           []TruantcyElement      `json:"truantcy"`
	Turgesce           []string               `json:"turgesce"`
	Unbeginning        []Unbeginning          `json:"unbeginning"`
	Underdunged        []float64              `json:"underdunged"`
	Undesirability     []Undesirability       `json:"undesirability"`
	Unerasing          []Unerasing            `json:"unerasing"`
	Unguentarium       []Unguentarium         `json:"unguentarium"`
	Unimpeachably      []UnimpeachablyElement `json:"unimpeachably"`
	Unmortgaged        []Unmortgaged          `json:"unmortgaged"`
	Unobstructed       []Unobstructed         `json:"unobstructed"`
	Unreceptivity      []Unreceptivity        `json:"unreceptivity"`
	Unsatisfactoriness []Unsatisfactoriness   `json:"unsatisfactoriness"`
	Unsecurity         []int64                `json:"unsecurity"`
	Unstressed         []UnstressedElement    `json:"unstressed"`
	Untasked           []Untasked             `json:"untasked"`
	Unvarying          []Unvarying            `json:"unvarying"`
	Vehemently         []Vehemently           `json:"vehemently"`
	Warriorship        map[string]bool        `json:"warriorship"`
	Whitepot           []Whitepot             `json:"whitepot"`
	Wrothy             []WrothyElement        `json:"wrothy"`
}

type PulpitismClass struct {
	Abnet           interface{} `json:"abnet"`
	Buckhorn        interface{} `json:"buckhorn"`
	Calciform       interface{} `json:"calciform"`
	Chelophore      interface{} `json:"chelophore"`
	Cogitation      interface{} `json:"cogitation"`
	Decreeable      interface{} `json:"decreeable"`
	Despicable      interface{} `json:"despicable"`
	Isodiazo        interface{} `json:"isodiazo"`
	Jadedly         interface{} `json:"jadedly"`
	Leptochlorite   interface{} `json:"leptochlorite"`
	Nursling        interface{} `json:"nursling"`
	Palamedean      interface{} `json:"palamedean"`
	Photoheliograph interface{} `json:"photoheliograph"`
	Pipewood        interface{} `json:"pipewood"`
	Roberd          interface{} `json:"roberd"`
	Statable        interface{} `json:"statable"`
	Superassume     interface{} `json:"superassume"`
	Syllabe         interface{} `json:"syllabe"`
	Toughhead       interface{} `json:"toughhead"`
	Underburn       interface{} `json:"underburn"`
}

type PyodermiaClass struct {
	Aphoristically interface{} `json:"aphoristically"`
	Apophyllous    interface{} `json:"apophyllous"`
	Cognize        interface{} `json:"cognize"`
	Dermonosology  interface{} `json:"dermonosology"`
	Gyppo          interface{} `json:"Gyppo"`
	Ither          interface{} `json:"ither"`
	Juglandaceous  interface{} `json:"juglandaceous"`
	Litho          interface{} `json:"litho"`
	Macropterous   interface{} `json:"macropterous"`
	Photographer   interface{} `json:"photographer"`
	Romancing      interface{} `json:"romancing"`
	Rumness        interface{} `json:"rumness"`
	Somniloquist   interface{} `json:"somniloquist"`
	Stressfully    interface{} `json:"stressfully"`
	Tactically     interface{} `json:"tactically"`
	Tracheophony   interface{} `json:"tracheophony"`
	Unappositely   interface{} `json:"unappositely"`
	Unclothedly    interface{} `json:"unclothedly"`
	Unimplied      interface{} `json:"unimplied"`
	Unsyncopated   interface{} `json:"unsyncopated"`
}

type QuebrachineClass struct {
	Catharticalness float64     `json:"catharticalness"`
	Chirotherium    int64       `json:"Chirotherium"`
	Disdiapason     string      `json:"disdiapason"`
	Homocerc        bool        `json:"homocerc"`
	Nonbookish      interface{} `json:"nonbookish"`
}

type Reimagine struct {
	Adducible       interface{} `json:"adducible"`
	Anabolin        interface{} `json:"anabolin"`
	Brainy          interface{} `json:"brainy"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Chrysamine      interface{} `json:"chrysamine"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Fluxweed        interface{} `json:"fluxweed"`
	Glaucine        interface{} `json:"glaucine"`
	Grobianism      interface{} `json:"grobianism"`
	Hermo           interface{} `json:"Hermo"`
	Hieroglyphist   interface{} `json:"hieroglyphist"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Icteroid        interface{} `json:"icteroid"`
	Immortal        interface{} `json:"immortal"`
	Impetulant      interface{} `json:"impetulant"`
	Irrigate        interface{} `json:"irrigate"`
	Myxedema        interface{} `json:"myxedema"`
	Nonbookish      interface{} `json:"nonbookish"`
	Onyx            interface{} `json:"onyx"`
	Repasser        interface{} `json:"repasser"`
	Septomarginal   interface{} `json:"septomarginal"`
	Subdie          interface{} `json:"subdie"`
	Tibiometatarsal interface{} `json:"tibiometatarsal"`
	Waltzlike       interface{} `json:"waltzlike"`
}

type Ressaut struct {
	Apperceptive    string `json:"apperceptive"`
	Cuttoo          string `json:"cuttoo"`
	Douser          string `json:"douser"`
	Drinkproof      string `json:"drinkproof"`
	Forementioned   string `json:"forementioned"`
	Freesia         string `json:"Freesia"`
	Genevieve       string `json:"Genevieve"`
	Hyperdiabolical string `json:"hyperdiabolical"`
	Hypocone        string `json:"hypocone"`
	Irreverentially string `json:"irreverentially"`
	Jumart          string `json:"jumart"`
	Mimosaceae      string `json:"Mimosaceae"`
	Mollicrush      string `json:"mollicrush"`
	Nedder          string `json:"nedder"`
	Retinasphalt    string `json:"retinasphalt"`
	Sough           string `json:"sough"`
	Steading        string `json:"steading"`
	Theopaschitism  string `json:"Theopaschitism"`
	Undurableness   string `json:"undurableness"`
	Unmingleable    string `json:"unmingleable"`
}

type RewriteClass struct {
	Accountancy      interface{} `json:"accountancy"`
	Cacotrophic      interface{} `json:"cacotrophic"`
	Contest          interface{} `json:"contest"`
	Couthily         interface{} `json:"couthily"`
	Falculate        interface{} `json:"falculate"`
	Foreseize        interface{} `json:"foreseize"`
	Hyades           interface{} `json:"Hyades"`
	Lemnad           interface{} `json:"lemnad"`
	Monotheistically interface{} `json:"monotheistically"`
	Nonflying        interface{} `json:"nonflying"`
	Ptenoglossa      interface{} `json:"Ptenoglossa"`
	Repatch          interface{} `json:"repatch"`
	Rodman           interface{} `json:"rodman"`
	Strung           interface{} `json:"strung"`
	Titmal           interface{} `json:"titmal"`
	Twalpennyworth   interface{} `json:"twalpennyworth"`
	Unblamable       interface{} `json:"unblamable"`
	Vertical         interface{} `json:"vertical"`
	Whiggification   interface{} `json:"Whiggification"`
	Yardman          interface{} `json:"yardman"`
}

type SantirClass struct {
	Admiredly       interface{} `json:"admiredly"`
	Demicaponier    interface{} `json:"demicaponier"`
	Epitympanic     interface{} `json:"epitympanic"`
	Investitor      interface{} `json:"investitor"`
	Lupiform        interface{} `json:"lupiform"`
	Monoflagellate  interface{} `json:"monoflagellate"`
	Paleoethnic     interface{} `json:"paleoethnic"`
	Prediscountable interface{} `json:"prediscountable"`
	Rhetoricals     interface{} `json:"rhetoricals"`
	Roomth          interface{} `json:"roomth"`
	Saccharose      interface{} `json:"saccharose"`
	Septonasal      interface{} `json:"septonasal"`
	Serpenticide    interface{} `json:"serpenticide"`
	Setarious       interface{} `json:"setarious"`
	Spaework        interface{} `json:"spaework"`
	Stylite         interface{} `json:"stylite"`
	Suessiones      interface{} `json:"Suessiones"`
	Timelily        interface{} `json:"timelily"`
	Unprofaned      interface{} `json:"unprofaned"`
	Vorticular      interface{} `json:"vorticular"`
}

type SaxtenClass struct {
	Algarrobilla    interface{} `json:"algarrobilla"`
	Bowgrace        interface{} `json:"bowgrace"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Centaurid       interface{} `json:"Centaurid"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Flix            interface{} `json:"flix"`
	Germanely       interface{} `json:"germanely"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Inhume          interface{} `json:"inhume"`
	Lepidote        interface{} `json:"lepidote"`
	Megalochirous   interface{} `json:"megalochirous"`
	Ninepenny       interface{} `json:"ninepenny"`
	Nonbookish      interface{} `json:"nonbookish"`
	Nondeist        interface{} `json:"nondeist"`
	Nymphaeaceous   interface{} `json:"nymphaeaceous"`
	Parietofrontal  interface{} `json:"parietofrontal"`
	Sancyite        interface{} `json:"sancyite"`
	Subjectivist    interface{} `json:"subjectivist"`
	Tibiad          interface{} `json:"tibiad"`
	Transonic       interface{} `json:"transonic"`
	Tripetalous     interface{} `json:"tripetalous"`
	Trunchman       interface{} `json:"trunchman"`
	Urger           interface{} `json:"urger"`
	Withdrawnness   interface{} `json:"withdrawnness"`
}

type Scatty struct {
	Aeriferous         interface{} `json:"aeriferous"`
	Antical            interface{} `json:"antical"`
	Antighostism       interface{} `json:"antighostism"`
	Arcanum            interface{} `json:"arcanum"`
	Autotrophy         interface{} `json:"autotrophy"`
	Baronial           interface{} `json:"baronial"`
	Caffeine           interface{} `json:"caffeine"`
	Gorgoniacean       interface{} `json:"gorgoniacean"`
	Heroical           interface{} `json:"heroical"`
	Hydropical         interface{} `json:"hydropical"`
	Mechanology        interface{} `json:"mechanology"`
	Musicopoetic       interface{} `json:"musicopoetic"`
	Officiality        interface{} `json:"officiality"`
	Oftentimes         interface{} `json:"oftentimes"`
	Ophthalmotonometer interface{} `json:"ophthalmotonometer"`
	Reflectively       interface{} `json:"reflectively"`
	Springer           interface{} `json:"springer"`
	Tabasco            interface{} `json:"Tabasco"`
	Teleianthous       interface{} `json:"teleianthous"`
	Uncombated         interface{} `json:"uncombated"`
}

type SisteringClass struct {
	Amphicarpic      interface{} `json:"amphicarpic"`
	Chianti          interface{} `json:"Chianti"`
	Frigorific       interface{} `json:"frigorific"`
	Haplomi          interface{} `json:"Haplomi"`
	Hyperkinesis     interface{} `json:"hyperkinesis"`
	Laudable         interface{} `json:"laudable"`
	Madwoman         interface{} `json:"madwoman"`
	Maimedly         interface{} `json:"maimedly"`
	Micropterygidae  interface{} `json:"Micropterygidae"`
	Microrhabdus     interface{} `json:"microrhabdus"`
	Nondense         interface{} `json:"nondense"`
	Phlebemphraxis   interface{} `json:"phlebemphraxis"`
	Redsear          interface{} `json:"redsear"`
	Schismatical     interface{} `json:"schismatical"`
	Tartryl          interface{} `json:"tartryl"`
	Unabhorred       interface{} `json:"unabhorred"`
	Undeliberateness interface{} `json:"undeliberateness"`
	Unmixable        interface{} `json:"unmixable"`
	Untruckling      interface{} `json:"untruckling"`
	Vineal           interface{} `json:"vineal"`
}

type Staghunting struct {
	Calorimetric       *int64      `json:"calorimetric,omitempty"`
	Canid              *int64      `json:"canid,omitempty"`
	Catharticalness    *float64    `json:"catharticalness,omitempty"`
	Chirotherium       *int64      `json:"Chirotherium,omitempty"`
	Disdiapason        *string     `json:"disdiapason,omitempty"`
	Ditriglyphic       *int64      `json:"ditriglyphic,omitempty"`
	Floriferousness    *int64      `json:"floriferousness,omitempty"`
	Gamelike           *int64      `json:"gamelike,omitempty"`
	Grig               *int64      `json:"grig,omitempty"`
	Homocerc           *bool       `json:"homocerc,omitempty"`
	Interloan          *int64      `json:"interloan,omitempty"`
	Lithotomy          *int64      `json:"lithotomy,omitempty"`
	Loric              *int64      `json:"loric,omitempty"`
	Membranocoriaceous *int64      `json:"membranocoriaceous,omitempty"`
	Membranogenic      *int64      `json:"membranogenic,omitempty"`
	Nonbookish         interface{} `json:"nonbookish"`
	Overtrump          *int64      `json:"overtrump,omitempty"`
	Scotino            *int64      `json:"scotino,omitempty"`
	Seasonable         *int64      `json:"seasonable,omitempty"`
	Sephen             *int64      `json:"sephen,omitempty"`
	Stigmarioid        *int64      `json:"stigmarioid,omitempty"`
	Tired              *int64      `json:"tired,omitempty"`
	Trifid             *int64      `json:"trifid,omitempty"`
	Undefeatedly       *int64      `json:"undefeatedly,omitempty"`
	Ungirlish          *int64      `json:"ungirlish,omitempty"`
}

type StrenuosityClass struct {
	Bliss           *int64      `json:"bliss,omitempty"`
	Buccate         *int64      `json:"buccate,omitempty"`
	Bulletproof     *int64      `json:"bulletproof,omitempty"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Crumblingness   *int64      `json:"crumblingness,omitempty"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Engagedly       *int64      `json:"engagedly,omitempty"`
	Fightable       *int64      `json:"fightable,omitempty"`
	Hoariness       *int64      `json:"hoariness,omitempty"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Hypopodium      *int64      `json:"hypopodium,omitempty"`
	Luxurist        *int64      `json:"luxurist,omitempty"`
	Mechanician     *int64      `json:"mechanician,omitempty"`
	Nonbookish      interface{} `json:"nonbookish"`
	Onopordon       *int64      `json:"Onopordon,omitempty"`
	Podgily         *int64      `json:"podgily,omitempty"`
	Reformableness  *int64      `json:"reformableness,omitempty"`
	Scatterbrains   *int64      `json:"scatterbrains,omitempty"`
	Seminuria       *int64      `json:"seminuria,omitempty"`
	Sodomite        *int64      `json:"Sodomite,omitempty"`
	Tramp           *int64      `json:"tramp,omitempty"`
	Undueness       *int64      `json:"undueness,omitempty"`
	Worthily        *int64      `json:"worthily,omitempty"`
	Yankeeist       *int64      `json:"Yankeeist,omitempty"`
}

type TruantcyClass struct {
	Alfiona         interface{} `json:"alfiona"`
	Ascaridiasis    interface{} `json:"ascaridiasis"`
	Bungey          interface{} `json:"bungey"`
	Catharticalness *float64    `json:"catharticalness,omitempty"`
	Ceroxyle        interface{} `json:"ceroxyle"`
	Chirotherium    *int64      `json:"Chirotherium,omitempty"`
	Chorology       interface{} `json:"chorology"`
	Disdiapason     *string     `json:"disdiapason,omitempty"`
	Enmarble        interface{} `json:"enmarble"`
	Epeira          interface{} `json:"Epeira"`
	Eurylaimi       interface{} `json:"Eurylaimi"`
	Germination     interface{} `json:"germination"`
	Hallelujah      interface{} `json:"hallelujah"`
	Homocerc        *bool       `json:"homocerc,omitempty"`
	Lev             interface{} `json:"lev"`
	Mouthing        interface{} `json:"mouthing"`
	Nonbookish      interface{} `json:"nonbookish"`
	Philliloo       interface{} `json:"philliloo"`
	Planetal        interface{} `json:"planetal"`
	Poney           interface{} `json:"poney"`
	Punctualist     interface{} `json:"punctualist"`
	Returnlessly    interface{} `json:"returnlessly"`
	Skelder         interface{} `json:"skelder"`
	Windwaywardly   interface{} `json:"windwaywardly"`
	Yuman           interface{} `json:"Yuman"`
}

type UnimpeachablyClass struct {
	Acerin             *int64      `json:"acerin,omitempty"`
	Bobadil            *int64      `json:"Bobadil,omitempty"`
	Catharticalness    *float64    `json:"catharticalness,omitempty"`
	Chirotherium       *int64      `json:"Chirotherium,omitempty"`
	Chlorophylligenous *int64      `json:"chlorophylligenous,omitempty"`
	Conversational     *int64      `json:"conversational,omitempty"`
	Demiowl            *int64      `json:"demiowl,omitempty"`
	Disdiapason        *string     `json:"disdiapason,omitempty"`
	Ectorhinal         *int64      `json:"ectorhinal,omitempty"`
	Gamblesomeness     *int64      `json:"gamblesomeness,omitempty"`
	Homocerc           *bool       `json:"homocerc,omitempty"`
	Irrorate           *int64      `json:"irrorate,omitempty"`
	Kindergartening    *int64      `json:"kindergartening,omitempty"`
	Lateritic          *int64      `json:"lateritic,omitempty"`
	Mespil             *int64      `json:"mespil,omitempty"`
	Misconfiguration   *int64      `json:"misconfiguration,omitempty"`
	Nonbookish         interface{} `json:"nonbookish"`
	Planometry         *int64      `json:"planometry,omitempty"`
	Quiina             *int64      `json:"Quiina,omitempty"`
	Robert             *int64      `json:"Robert,omitempty"`
	Rot                *int64      `json:"rot,omitempty"`
	Subcinctorium      *int64      `json:"subcinctorium,omitempty"`
	Tussocker          *int64      `json:"tussocker,omitempty"`
	Ultraproud         *int64      `json:"ultraproud,omitempty"`
	Unsuggestedness    *int64      `json:"unsuggestedness,omitempty"`
}

type UnstressedClass struct {
	Alain           interface{} `json:"Alain"`
	Amphirhina      interface{} `json:"Amphirhina"`
	Antimachinery   interface{} `json:"antimachinery"`
	Coldish         interface{} `json:"coldish"`
	Crantara        interface{} `json:"crantara"`
	Distinguishing  interface{} `json:"distinguishing"`
	Elytroposis     interface{} `json:"elytroposis"`
	Gentianwort     interface{} `json:"gentianwort"`
	Heliosis        interface{} `json:"heliosis"`
	Instrumental    interface{} `json:"instrumental"`
	Introinflection interface{} `json:"introinflection"`
	Kala            interface{} `json:"kala"`
	Lincolnian      interface{} `json:"Lincolnian"`
	Metad           interface{} `json:"metad"`
	Sarcophilus     interface{} `json:"Sarcophilus"`
	Swingingly      interface{} `json:"swingingly"`
	Unconformity    interface{} `json:"unconformity"`
	Undecreed       interface{} `json:"undecreed"`
	Venerable       interface{} `json:"venerable"`
	Vowellessness   interface{} `json:"vowellessness"`
}

type WrothyClass struct {
	Aeschynanthus    interface{} `json:"Aeschynanthus"`
	Aquiferous       interface{} `json:"aquiferous"`
	Cheapener        interface{} `json:"cheapener"`
	Enumeration      interface{} `json:"enumeration"`
	Ephesine         interface{} `json:"Ephesine"`
	Escadrille       interface{} `json:"escadrille"`
	Estrous          interface{} `json:"estrous"`
	Interestedly     interface{} `json:"interestedly"`
	Katakinetomer    interface{} `json:"katakinetomer"`
	Mortification    interface{} `json:"mortification"`
	Morula           interface{} `json:"morula"`
	Orthosymmetrical interface{} `json:"orthosymmetrical"`
	Overbark         interface{} `json:"overbark"`
	Politist         interface{} `json:"politist"`
	Qualified        interface{} `json:"qualified"`
	Sphenomalar      interface{} `json:"sphenomalar"`
	Throatful        interface{} `json:"throatful"`
	Transhumance     interface{} `json:"transhumance"`
	Triandrian       interface{} `json:"triandrian"`
	Unbooked         interface{} `json:"unbooked"`
}

type Protrusive struct {
	Double     *float64
	UnionArray []*int64
}

func (x *Protrusive) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.UnionArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Protrusive) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.UnionArray != nil, x.UnionArray, false, nil, false, nil, false, nil, false)
}

type PulpitismElement struct {
	Double         *float64
	IntegerArray   []int64
	PulpitismClass *PulpitismClass
}

func (x *PulpitismElement) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.PulpitismClass = nil
	var c PulpitismClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PulpitismClass = &c
	}
	return nil
}

func (x *PulpitismElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, x.PulpitismClass != nil, x.PulpitismClass, false, nil, false, nil, false)
}

type PyodermiaElement struct {
	Integer        *int64
	PyodermiaClass *PyodermiaClass
}

func (x *PyodermiaElement) UnmarshalJSON(data []byte) error {
	x.PyodermiaClass = nil
	var c PyodermiaClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PyodermiaClass = &c
	}
	return nil
}

func (x *PyodermiaElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.PyodermiaClass != nil, x.PyodermiaClass, false, nil, false, nil, false)
}

type QuebrachineElement struct {
	Bool             *bool
	QuebrachineClass *QuebrachineClass
}

func (x *QuebrachineElement) UnmarshalJSON(data []byte) error {
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *QuebrachineElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, true)
}

type Querier struct {
	Bool       *bool
	IntegerMap map[string]int64
}

func (x *Querier) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Querier) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Rebarbative struct {
	Bool         *bool
	Double       *float64
	IntegerArray []int64
}

func (x *Rebarbative) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Rebarbative) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Retrocervical struct {
	Integer    *int64
	UnionArray []*int64
}

func (x *Retrocervical) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.UnionArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Retrocervical) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.UnionArray != nil, x.UnionArray, false, nil, false, nil, false, nil, false)
}

type Revert struct {
	Bool   *bool
	String *string
}

func (x *Revert) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Revert) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type RewriteElement struct {
	Double       *float64
	NullArray    []interface{}
	RewriteClass *RewriteClass
}

func (x *RewriteElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.RewriteClass = nil
	var c RewriteClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.RewriteClass = &c
	}
	return nil
}

func (x *RewriteElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, x.RewriteClass != nil, x.RewriteClass, false, nil, false, nil, false)
}

type Saccoderm struct {
	IntegerArray []int64
	String       *string
}

func (x *Saccoderm) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.IntegerArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Saccoderm) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, true)
}

type SantirElement struct {
	Double      *float64
	SantirClass *SantirClass
}

func (x *SantirElement) UnmarshalJSON(data []byte) error {
	x.SantirClass = nil
	var c SantirClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SantirClass = &c
	}
	return nil
}

func (x *SantirElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SantirClass != nil, x.SantirClass, false, nil, false, nil, false)
}

type Saprophilous struct {
	IntegerMap map[string]int64
	String     *string
}

func (x *Saprophilous) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Saprophilous) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type SaxtenElement struct {
	SaxtenClass *SaxtenClass
	String      *string
}

func (x *SaxtenElement) UnmarshalJSON(data []byte) error {
	x.SaxtenClass = nil
	var c SaxtenClass
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SaxtenClass = &c
	}
	return nil
}

func (x *SaxtenElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, false, nil, x.SaxtenClass != nil, x.SaxtenClass, false, nil, false, nil, false)
}

type Scoffer struct {
	IntegerMap map[string]int64
	NullArray  []interface{}
}

func (x *Scoffer) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Scoffer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type Scrampum struct {
	Bool         *bool
	IntegerArray []int64
}

func (x *Scrampum) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Scrampum) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, true)
}

type Serpentinic struct {
	Double       *float64
	IntegerArray []int64
}

func (x *Serpentinic) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Serpentinic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type Shadowable struct {
	Bool       *bool
	UnionArray []*int64
}

func (x *Shadowable) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.UnionArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Shadowable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.UnionArray != nil, x.UnionArray, false, nil, false, nil, false, nil, false)
}

type SisteringElement struct {
	Integer        *int64
	NullArray      []interface{}
	SisteringClass *SisteringClass
}

func (x *SisteringElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.SisteringClass = nil
	var c SisteringClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SisteringClass = &c
	}
	return nil
}

func (x *SisteringElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.NullArray != nil, x.NullArray, x.SisteringClass != nil, x.SisteringClass, false, nil, false, nil, false)
}

type Stagmometer struct {
	String     *string
	UnionArray []*int64
}

func (x *Stagmometer) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.UnionArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Stagmometer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.UnionArray != nil, x.UnionArray, false, nil, false, nil, false, nil, false)
}

type Stimulability struct {
	Bool       *bool
	Integer    *int64
	IntegerMap map[string]int64
}

func (x *Stimulability) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Stimulability) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Strangleable struct {
	Double    *float64
	NullArray []interface{}
}

func (x *Strangleable) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Strangleable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type StrenuosityElement struct {
	NullArray        []interface{}
	StrenuosityClass *StrenuosityClass
}

func (x *StrenuosityElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.StrenuosityClass = nil
	var c StrenuosityClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.StrenuosityClass = &c
	}
	return nil
}

func (x *StrenuosityElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.StrenuosityClass != nil, x.StrenuosityClass, false, nil, false, nil, false)
}

type Tabaxir struct {
	Bool   *bool
	Double *float64
}

func (x *Tabaxir) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Tabaxir) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, false, nil, false, nil, false, nil, false)
}

type Talpiform struct {
	Double           *float64
	QuebrachineClass *QuebrachineClass
}

func (x *Talpiform) UnmarshalJSON(data []byte) error {
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *Talpiform) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, true)
}

type Thwack struct {
	Bool             *bool
	Double           *float64
	QuebrachineClass *QuebrachineClass
}

func (x *Thwack) UnmarshalJSON(data []byte) error {
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *Thwack) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, false)
}

type Tortricine struct {
	QuebrachineClass *QuebrachineClass
	UnionArray       []*int64
}

func (x *Tortricine) UnmarshalJSON(data []byte) error {
	x.UnionArray = nil
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.UnionArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *Tortricine) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.UnionArray != nil, x.UnionArray, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, false)
}

type TruantcyElement struct {
	Bool          *bool
	TruantcyClass *TruantcyClass
}

func (x *TruantcyElement) UnmarshalJSON(data []byte) error {
	x.TruantcyClass = nil
	var c TruantcyClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TruantcyClass = &c
	}
	return nil
}

func (x *TruantcyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.TruantcyClass != nil, x.TruantcyClass, false, nil, false, nil, false)
}

type Unbeginning struct {
	IntegerMap map[string]int64
	NullArray  []interface{}
	String     *string
}

func (x *Unbeginning) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unbeginning) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Undesirability struct {
	IntegerArray []int64
	IntegerMap   map[string]int64
	String       *string
}

func (x *Undesirability) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, nil, nil, &x.String, true, &x.IntegerArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Undesirability) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, x.String, x.IntegerArray != nil, x.IntegerArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Unerasing struct {
	Integer    *int64
	IntegerMap map[string]int64
	NullArray  []interface{}
}

func (x *Unerasing) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unerasing) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Unguentarium struct {
	Integer   *int64
	NullArray []interface{}
}

func (x *Unguentarium) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, true, &x.NullArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unguentarium) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, true)
}

type UnimpeachablyElement struct {
	Bool               *bool
	UnimpeachablyClass *UnimpeachablyClass
}

func (x *UnimpeachablyElement) UnmarshalJSON(data []byte) error {
	x.UnimpeachablyClass = nil
	var c UnimpeachablyClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.UnimpeachablyClass = &c
	}
	return nil
}

func (x *UnimpeachablyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, false, nil, x.UnimpeachablyClass != nil, x.UnimpeachablyClass, false, nil, false, nil, false)
}

type Unmortgaged struct {
	Double     *float64
	IntegerMap map[string]int64
}

func (x *Unmortgaged) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unmortgaged) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, true)
}

type Unobstructed struct {
	Integer          *int64
	QuebrachineClass *QuebrachineClass
}

func (x *Unobstructed) UnmarshalJSON(data []byte) error {
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, nil, false, nil, true, &c, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *Unobstructed) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, nil, false, nil, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, true)
}

type Unreceptivity struct {
	Integer   *int64
	NullArray []interface{}
	String    *string
}

func (x *Unreceptivity) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, true, &x.NullArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unreceptivity) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, false)
}

type Unsatisfactoriness struct {
	Bool         *bool
	Integer      *int64
	IntegerArray []int64
}

func (x *Unsatisfactoriness) UnmarshalJSON(data []byte) error {
	x.IntegerArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, &x.Bool, nil, true, &x.IntegerArray, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unsatisfactoriness) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, x.Bool, nil, x.IntegerArray != nil, x.IntegerArray, false, nil, false, nil, false, nil, false)
}

type UnstressedElement struct {
	Bool            *bool
	String          *string
	UnstressedClass *UnstressedClass
}

func (x *UnstressedElement) UnmarshalJSON(data []byte) error {
	x.UnstressedClass = nil
	var c UnstressedClass
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.UnstressedClass = &c
	}
	return nil
}

func (x *UnstressedElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, x.String, false, nil, x.UnstressedClass != nil, x.UnstressedClass, false, nil, false, nil, false)
}

type Untasked struct {
	Double     *float64
	IntegerMap map[string]int64
	NullArray  []interface{}
}

func (x *Untasked) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, true, &x.NullArray, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Untasked) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, x.NullArray != nil, x.NullArray, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Unvarying struct {
	Bool       *bool
	Double     *float64
	IntegerMap map[string]int64
}

func (x *Unvarying) UnmarshalJSON(data []byte) error {
	x.IntegerMap = nil
	object, err := unmarshalUnion(data, nil, &x.Double, &x.Bool, nil, false, nil, false, nil, true, &x.IntegerMap, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Unvarying) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, x.Bool, nil, false, nil, false, nil, x.IntegerMap != nil, x.IntegerMap, false, nil, false)
}

type Vehemently struct {
	Bool      *bool
	NullArray []interface{}
}

func (x *Vehemently) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	object, err := unmarshalUnion(data, nil, nil, &x.Bool, nil, true, &x.NullArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Vehemently) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, x.Bool, nil, x.NullArray != nil, x.NullArray, false, nil, false, nil, false, nil, true)
}

type Whitepot struct {
	Double           *float64
	QuebrachineClass *QuebrachineClass
}

func (x *Whitepot) UnmarshalJSON(data []byte) error {
	x.QuebrachineClass = nil
	var c QuebrachineClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.QuebrachineClass = &c
	}
	return nil
}

func (x *Whitepot) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.QuebrachineClass != nil, x.QuebrachineClass, false, nil, false, nil, false)
}

type WrothyElement struct {
	NullArray   []interface{}
	WrothyClass *WrothyClass
}

func (x *WrothyElement) UnmarshalJSON(data []byte) error {
	x.NullArray = nil
	x.WrothyClass = nil
	var c WrothyClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, true, &x.NullArray, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.WrothyClass = &c
	}
	return nil
}

func (x *WrothyElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, x.NullArray != nil, x.NullArray, x.WrothyClass != nil, x.WrothyClass, false, nil, false, nil, false)
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
