// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "time"

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
	Dummy int64 `json:"dummy"`
	Obj1  Obj1  `json:"obj1"`
	Obj2  Obj2  `json:"obj2"`
	Obj3  Obj3  `json:"obj3"`
	Obj4  Obj4  `json:"obj4"`
	Obj5  Obj5  `json:"obj5"`
	Obj6  Obj6  `json:"obj6"`
}

type Obj1 struct {
	ASM            ASM            `json:"asm"`
	Abstract       Abstract       `json:"abstract"`
	Alignas        Alignas        `json:"alignas"`
	Alignof        Alignof        `json:"alignof"`
	And            And            `json:"and"`
	AndEq          AndEq          `json:"and_eq"`
	Any            Any            `json:"Any"`
	Array          Array          `json:"array"`
	ArrayNode      ArrayNode      `json:"ArrayNode"`
	As             As             `json:"as"`
	Assert         Assert         `json:"assert"`
	Associatedtype Associatedtype `json:"associatedtype"`
	Associativity  Associativity  `json:"associativity"`
	Async          Async          `json:"async"`
	Atomic         Atomic         `json:"atomic"`
	AtomicCancel   AtomicCancel   `json:"atomic_cancel"`
	AtomicCommit   AtomicCommit   `json:"atomic_commit"`
	AtomicNoexcept AtomicNoexcept `json:"atomic_noexcept"`
	Auto           Auto           `json:"auto"`
	Await          Await          `json:"await"`
	Base           Base           `json:"base"`
	Bitand         Bitand         `json:"bitand"`
	Bitor          Bitor          `json:"bitor"`
	Bool           Bool           `json:"BOOL"`
	Boolean        Boolean        `json:"boolean"`
	BooleanNode    BooleanNode    `json:"BooleanNode"`
	Break          Break          `json:"break"`
	Bycopy         Bycopy         `json:"bycopy"`
	Byref          Byref          `json:"byref"`
	Byte           Byte           `json:"byte"`
	Calendar       Calendar       `json:"Calendar"`
	Case           Case           `json:"case"`
	Catch          Catch          `json:"catch"`
	Chan           Chan           `json:"chan"`
	Char           Char           `json:"char"`
	Char16T        Char16T        `json:"char16_t"`
	Char32T        Char32T        `json:"char32_t"`
	Checked        Checked        `json:"checked"`
	Class          Class          `json:"Class"`
	Clone          Clone          `json:"clone"`
	CoAwait        CoAwait        `json:"co_await"`
	CoReturn       CoReturn       `json:"co_return"`
	CoYield        CoYield        `json:"co_yield"`
	Codable        Codable        `json:"Codable"`
	CodingKey      CodingKey      `json:"CodingKey"`
	CodingKeys     CodingKeys     `json:"CodingKeys"`
	Compl          Compl          `json:"compl"`
	Complex        Complex        `json:"_Complex"`
	Concept        Concept        `json:"concept"`
	Console        Console        `json:"console"`
	Const          Const          `json:"const"`
	ConstCast      ConstCast      `json:"const_cast"`
	Constexpr      Constexpr      `json:"constexpr"`
	Constructor    Constructor    `json:"constructor"`
	Continue       Continue       `json:"continue"`
	Convenience    Convenience    `json:"convenience"`
	Convert        Convert        `json:"convert"`
	Converter      Converter      `json:"converter"`
	Dummy          int64          `json:"dummy"`
	Empty          Empty          `json:"_"`
	Imaginery      Imaginery      `json:"_Imaginery"`
	Obj1Any        AnyClass       `json:"any"`
	Obj1Bool       BoolClass      `json:"_Bool"`
	Obj1Class      ClassClass     `json:"class"`
	PurpleBool     Obj1Bool       `json:"bool"`
}

type ASM struct {
	ASM int64 `json:"asm"`
}

type Abstract struct {
	Abstract int64 `json:"abstract"`
}

type Alignas struct {
	Alignas int64 `json:"alignas"`
}

type Alignof struct {
	Alignof int64 `json:"alignof"`
}

type And struct {
	And int64 `json:"and"`
}

type AndEq struct {
	AndEq int64 `json:"and_eq"`
}

type Any struct {
	Any int64 `json:"Any"`
}

type Array struct {
	Array int64 `json:"array"`
}

type ArrayNode struct {
	ArrayNode int64 `json:"ArrayNode"`
}

type As struct {
	As int64 `json:"as"`
}

type Assert struct {
	Assert int64 `json:"assert"`
}

type Associatedtype struct {
	Associatedtype int64 `json:"associatedtype"`
}

type Associativity struct {
	Associativity int64 `json:"associativity"`
}

type Async struct {
	Async int64 `json:"async"`
}

type Atomic struct {
	Atomic int64 `json:"atomic"`
}

type AtomicCancel struct {
	AtomicCancel int64 `json:"atomic_cancel"`
}

type AtomicCommit struct {
	AtomicCommit int64 `json:"atomic_commit"`
}

type AtomicNoexcept struct {
	AtomicNoexcept int64 `json:"atomic_noexcept"`
}

type Auto struct {
	Auto int64 `json:"auto"`
}

type Await struct {
	Await int64 `json:"await"`
}

type Base struct {
	Base int64 `json:"base"`
}

type Bitand struct {
	Bitand int64 `json:"bitand"`
}

type Bitor struct {
	Bitor int64 `json:"bitor"`
}

type Bool struct {
	Bool int64 `json:"BOOL"`
}

type Boolean struct {
	Boolean int64 `json:"boolean"`
}

type BooleanNode struct {
	BooleanNode int64 `json:"BooleanNode"`
}

type Break struct {
	Break int64 `json:"break"`
}

type Bycopy struct {
	Bycopy int64 `json:"bycopy"`
}

type Byref struct {
	Byref int64 `json:"byref"`
}

type Byte struct {
	Byte int64 `json:"byte"`
}

type Calendar struct {
	Calendar int64 `json:"Calendar"`
}

type Case struct {
	Case int64 `json:"case"`
}

type Catch struct {
	Catch int64 `json:"catch"`
}

type Chan struct {
	Chan int64 `json:"chan"`
}

type Char struct {
	Char int64 `json:"char"`
}

type Char16T struct {
	Char16T int64 `json:"char16_t"`
}

type Char32T struct {
	Char32T int64 `json:"char32_t"`
}

type Checked struct {
	Checked int64 `json:"checked"`
}

type Class struct {
	Class int64 `json:"Class"`
}

type Clone struct {
	Clone int64 `json:"clone"`
}

type CoAwait struct {
	CoAwait int64 `json:"co_await"`
}

type CoReturn struct {
	CoReturn int64 `json:"co_return"`
}

type CoYield struct {
	CoYield int64 `json:"co_yield"`
}

type Codable struct {
	Codable int64 `json:"Codable"`
}

type CodingKey struct {
	CodingKey int64 `json:"CodingKey"`
}

type CodingKeys struct {
	CodingKeys int64 `json:"CodingKeys"`
}

type Compl struct {
	Compl int64 `json:"compl"`
}

type Complex struct {
	Complex int64 `json:"_Complex"`
}

type Concept struct {
	Concept int64 `json:"concept"`
}

type Console struct {
	Console int64 `json:"console"`
}

type Const struct {
	Const int64 `json:"const"`
}

type ConstCast struct {
	ConstCast int64 `json:"const_cast"`
}

type Constexpr struct {
	Constexpr int64 `json:"constexpr"`
}

type Constructor struct {
	Constructor int64 `json:"constructor"`
}

type Continue struct {
	Continue int64 `json:"continue"`
}

type Convenience struct {
	Convenience int64 `json:"convenience"`
}

type Convert struct {
	Convert int64 `json:"convert"`
}

type Converter struct {
	Converter int64 `json:"converter"`
}

type Empty struct {
	Empty int64 `json:"_"`
}

type Imaginery struct {
	Imaginery int64 `json:"_Imaginery"`
}

type AnyClass struct {
	Any int64 `json:"any"`
}

type BoolClass struct {
	Bool int64 `json:"_Bool"`
}

type ClassClass struct {
	Class int64 `json:"class"`
}

type Obj1Bool struct {
	Bool int64 `json:"bool"`
}

type Obj2 struct {
	CultureInfo            CultureInfo            `json:"CultureInfo"`
	Date                   Date                   `json:"date"`
	DateFormatter          DateFormatter          `json:"DateFormatter"`
	DateOnly               DateOnly               `json:"DateOnly"`
	DateOnlyConverter      DateOnlyConverter      `json:"DateOnlyConverter"`
	DateParseHandling      DateParseHandling      `json:"date_parse_handling"`
	DateTime               DateTime               `json:"DateTime"`
	DateTimeStyles         DateTimeStyles         `json:"DateTimeStyles"`
	Debugger               Debugger               `json:"debugger"`
	Decimal                Decimal                `json:"decimal"`
	Declare                Declare                `json:"declare"`
	Decltype               Decltype               `json:"decltype"`
	DecodeString           DecodeString           `json:"decode_string"`
	Decoder                Decoder                `json:"Decoder"`
	DecodingError          DecodingError          `json:"DecodingError"`
	Def                    Def                    `json:"def"`
	Default                Default                `json:"default"`
	Defer                  Defer                  `json:"defer"`
	Deinit                 Deinit                 `json:"deinit"`
	Del                    Del                    `json:"del"`
	Delegate               Delegate               `json:"delegate"`
	Delete                 Delete                 `json:"delete"`
	DeserializationFeature DeserializationFeature `json:"DeserializationFeature"`
	Dict                   Dict                   `json:"dict"`
	Dictionary             Dictionary             `json:"dictionary"`
	DidSet                 DidSet                 `json:"didSet"`
	Do                     Do                     `json:"do"`
	Double                 Double                 `json:"double"`
	DoubleNode             DoubleNode             `json:"DoubleNode"`
	Dummy                  int64                  `json:"dummy"`
	Dynamic                Dynamic                `json:"dynamic"`
	DynamicCast            DynamicCast            `json:"dynamic_cast"`
	Elif                   Elif                   `json:"elif"`
	Else                   Else                   `json:"else"`
	EncodeQuickType        EncodeQuickType        `json:"encode_quick_type"`
	Encoder                Encoder                `json:"Encoder"`
	Enum                   Enum                   `json:"enum"`
	EnumValues             EnumValues             `json:"EnumValues"`
	EqualityContract       EqualityContract       `json:"equalityContract"`
	Equatable              Equatable              `json:"Equatable"`
	Event                  Event                  `json:"event"`
	Except                 Except                 `json:"except"`
	Exception              Exception              `json:"exception"`
	Explicit               Explicit               `json:"explicit"`
	Export                 Export                 `json:"export"`
	Exposing               Exposing               `json:"exposing"`
	Extends                Extends                `json:"extends"`
	Extension              Extension              `json:"extension"`
	Extern                 Extern                 `json:"extern"`
	Fallthrough            Fallthrough            `json:"fallthrough"`
	False                  False                  `json:"False"`
	Fileprivate            Fileprivate            `json:"fileprivate"`
	Final                  Final                  `json:"final"`
	Finally                Finally                `json:"finally"`
	Fixed                  Fixed                  `json:"fixed"`
	Float                  Float                  `json:"float"`
	For                    For                    `json:"for"`
	Foreach                Foreach                `json:"foreach"`
	FormatException        FormatException        `json:"FormatException"`
	Friend                 Friend                 `json:"friend"`
	From                   From                   `json:"from"`
	FromDict               FromDict               `json:"from_dict"`
	FromJSON               FromJSON               `json:"from_json"`
	Func                   Func                   `json:"func"`
	Obj2False              FalseClass             `json:"false"`
}

type CultureInfo struct {
	CultureInfo int64 `json:"CultureInfo"`
}

type Date struct {
	Date int64 `json:"date"`
}

type DateFormatter struct {
	DateFormatter int64 `json:"DateFormatter"`
}

type DateOnly struct {
	DateOnly int64 `json:"DateOnly"`
}

type DateOnlyConverter struct {
	DateOnlyConverter int64 `json:"DateOnlyConverter"`
}

type DateParseHandling struct {
	DateParseHandling int64 `json:"date_parse_handling"`
}

type DateTime struct {
	DateTime time.Time `json:"DateTime"`
}

type DateTimeStyles struct {
	DateTimeStyles int64 `json:"DateTimeStyles"`
}

type Debugger struct {
	Debugger int64 `json:"debugger"`
}

type Decimal struct {
	Decimal int64 `json:"decimal"`
}

type Declare struct {
	Declare int64 `json:"declare"`
}

type Decltype struct {
	Decltype int64 `json:"decltype"`
}

type DecodeString struct {
	DecodeString int64 `json:"decode_string"`
}

type Decoder struct {
	Decoder int64 `json:"Decoder"`
}

type DecodingError struct {
	DecodingError int64 `json:"DecodingError"`
}

type Def struct {
	Def int64 `json:"def"`
}

type Default struct {
	Default int64 `json:"default"`
}

type Defer struct {
	Defer int64 `json:"defer"`
}

type Deinit struct {
	Deinit int64 `json:"deinit"`
}

type Del struct {
	Del int64 `json:"del"`
}

type Delegate struct {
	Delegate int64 `json:"delegate"`
}

type Delete struct {
	Delete int64 `json:"delete"`
}

type DeserializationFeature struct {
	DeserializationFeature int64 `json:"DeserializationFeature"`
}

type Dict struct {
	Dict int64 `json:"dict"`
}

type Dictionary struct {
	Dictionary int64 `json:"dictionary"`
}

type DidSet struct {
	DidSet int64 `json:"didSet"`
}

type Do struct {
	Do int64 `json:"do"`
}

type Double struct {
	Double int64 `json:"double"`
}

type DoubleNode struct {
	DoubleNode int64 `json:"DoubleNode"`
}

type Dynamic struct {
	Dynamic int64 `json:"dynamic"`
}

type DynamicCast struct {
	DynamicCast int64 `json:"dynamic_cast"`
}

type Elif struct {
	Elif int64 `json:"elif"`
}

type Else struct {
	Else int64 `json:"else"`
}

type EncodeQuickType struct {
	EncodeQuickType int64 `json:"encode_quick_type"`
}

type Encoder struct {
	Encoder int64 `json:"Encoder"`
}

type Enum struct {
	Enum int64 `json:"enum"`
}

type EnumValues struct {
	EnumValues []EnumValue `json:"EnumValues"`
}

type EqualityContract struct {
	EqualityContract int64 `json:"equalityContract"`
}

type Equatable struct {
	Equatable int64 `json:"Equatable"`
}

type Event struct {
	Event int64 `json:"event"`
}

type Except struct {
	Except int64 `json:"except"`
}

type Exception struct {
	Exception int64 `json:"exception"`
}

type Explicit struct {
	Explicit int64 `json:"explicit"`
}

type Export struct {
	Export int64 `json:"export"`
}

type Exposing struct {
	Exposing int64 `json:"exposing"`
}

type Extends struct {
	Extends int64 `json:"extends"`
}

type Extension struct {
	Extension int64 `json:"extension"`
}

type Extern struct {
	Extern int64 `json:"extern"`
}

type Fallthrough struct {
	Fallthrough int64 `json:"fallthrough"`
}

type False struct {
	False int64 `json:"False"`
}

type Fileprivate struct {
	Fileprivate int64 `json:"fileprivate"`
}

type Final struct {
	Final int64 `json:"final"`
}

type Finally struct {
	Finally int64 `json:"finally"`
}

type Fixed struct {
	Fixed int64 `json:"fixed"`
}

type Float struct {
	Float int64 `json:"float"`
}

type For struct {
	For int64 `json:"for"`
}

type Foreach struct {
	Foreach int64 `json:"foreach"`
}

type FormatException struct {
	FormatException int64 `json:"FormatException"`
}

type Friend struct {
	Friend int64 `json:"friend"`
}

type From struct {
	From int64 `json:"from"`
}

type FromDict struct {
	FromDict int64 `json:"from_dict"`
}

type FromJSON struct {
	FromJSON int64 `json:"from_json"`
}

type Func struct {
	Func int64 `json:"func"`
}

type FalseClass struct {
	False int64 `json:"false"`
}

type Obj3 struct {
	Dummy                      int64                      `json:"dummy"`
	Function                   Function                   `json:"function"`
	Get                        Get                        `json:"get"`
	Global                     Global                     `json:"global"`
	Go                         Go                         `json:"go"`
	Goto                       Goto                       `json:"goto"`
	Guard                      Guard                      `json:"guard"`
	HasOwnProperty             HasOwnProperty             `json:"hasOwnProperty"`
	HashCode                   HashCode                   `json:"hashCode"`
	Hashable                   Hashable                   `json:"Hashable"`
	Hasher                     Hasher                     `json:"Hasher"`
	ID                         ID                         `json:"id"`
	ISODateTimeOffsetConverter ISODateTimeOffsetConverter `json:"IsoDateTimeOffsetConverter"`
	If                         If                         `json:"if"`
	Imp                        Imp                        `json:"IMP"`
	Implements                 Implements                 `json:"implements"`
	Implicit                   Implicit                   `json:"implicit"`
	Import                     Import                     `json:"import"`
	In                         In                         `json:"in"`
	Indirect                   Indirect                   `json:"indirect"`
	Infix                      Infix                      `json:"infix"`
	Init                       Init                       `json:"init"`
	Inline                     Inline                     `json:"inline"`
	Inout                      Inout                      `json:"inout"`
	Instanceof                 Instanceof                 `json:"instanceof"`
	Int                        Int                        `json:"int"`
	IntNode                    IntNode                    `json:"IntNode"`
	Interface                  Interface                  `json:"interface"`
	Internal                   Internal                   `json:"internal"`
	Is                         Is                         `json:"is"`
	Iterable                   Iterable                   `json:"iterable"`
	JSON                       JSON                       `json:"json"`
	JSONAny                    JSONAny                    `json:"JSONAny"`
	JSONCodingKey              JSONCodingKey              `json:"JSONCodingKey"`
	JSONConverter              JSONConverter              `json:"json_converter"`
	JSONDecoder                JSONDecoder                `json:"JSONDecoder"`
	JSONEncoder                JSONEncoder                `json:"JSONEncoder"`
	JSONException              JSONException              `json:"JsonException"`
	JSONGenerator              JSONGenerator              `json:"JsonGenerator"`
	JSONNode                   JSONNode                   `json:"JsonNode"`
	JSONNull                   JSONNull                   `json:"JSONNull"`
	JSONParser                 JSONParser                 `json:"JsonParser"`
	JSONReader                 JSONReader                 `json:"JsonReader"`
	JSONSerializer             JSONSerializer             `json:"json_serializer"`
	JSONToken                  JSONToken                  `json:"json_token"`
	JSONTokenType              JSONTokenType              `json:"JsonTokenType"`
	JSONWriter                 JSONWriter                 `json:"json_writer"`
	Jdec                       Jdec                       `json:"jdec"`
	Jenc                       Jenc                       `json:"jenc"`
	Jpipe                      Jpipe                      `json:"jpipe"`
	Lambda                     Lambda                     `json:"lambda"`
	Lazy                       Lazy                       `json:"lazy"`
	Left                       Left                       `json:"left"`
	Let                        Let                        `json:"let"`
	List                       List                       `json:"list"`
	LocalDate                  LocalDate                  `json:"LocalDate"`
	Locale                     Locale                     `json:"Locale"`
	Lock                       Lock                       `json:"lock"`
	Long                       Long                       `json:"long"`
	LongNode                   LongNode                   `json:"LongNode"`
	Map                        Map                        `json:"map"`
	MapEntry                   MapEntry                   `json:"MapEntry"`
	MarshalJSON                MarshalJSON                `json:"MarshalJSON"`
	MetadataPropertyHandling   MetadataPropertyHandling   `json:"metadata_property_handling"`
	Module                     Module                     `json:"module"`
}

type Function struct {
	Function int64 `json:"function"`
}

type Get struct {
	Get int64 `json:"get"`
}

type Global struct {
	Global int64 `json:"global"`
}

type Go struct {
	Go int64 `json:"go"`
}

type Goto struct {
	Goto int64 `json:"goto"`
}

type Guard struct {
	Guard int64 `json:"guard"`
}

type HasOwnProperty struct {
	HasOwnProperty int64 `json:"hasOwnProperty"`
}

type HashCode struct {
	HashCode int64 `json:"hashCode"`
}

type Hashable struct {
	Hashable int64 `json:"Hashable"`
}

type Hasher struct {
	Hasher int64 `json:"Hasher"`
}

type ID struct {
	ID int64 `json:"id"`
}

type ISODateTimeOffsetConverter struct {
	ISODateTimeOffsetConverter int64 `json:"IsoDateTimeOffsetConverter"`
}

type If struct {
	If int64 `json:"if"`
}

type Imp struct {
	Imp int64 `json:"IMP"`
}

type Implements struct {
	Implements int64 `json:"implements"`
}

type Implicit struct {
	Implicit int64 `json:"implicit"`
}

type Import struct {
	Import int64 `json:"import"`
}

type In struct {
	In int64 `json:"in"`
}

type Indirect struct {
	Indirect int64 `json:"indirect"`
}

type Infix struct {
	Infix int64 `json:"infix"`
}

type Init struct {
	Init int64 `json:"init"`
}

type Inline struct {
	Inline int64 `json:"inline"`
}

type Inout struct {
	Inout int64 `json:"inout"`
}

type Instanceof struct {
	Instanceof int64 `json:"instanceof"`
}

type Int struct {
	Int int64 `json:"int"`
}

type IntNode struct {
	IntNode int64 `json:"IntNode"`
}

type Interface struct {
	Interface int64 `json:"interface"`
}

type Internal struct {
	Internal int64 `json:"internal"`
}

type Is struct {
	Is int64 `json:"is"`
}

type Iterable struct {
	Iterable int64 `json:"iterable"`
}

type JSON struct {
	JSON int64 `json:"json"`
}

type JSONAny struct {
	JSONAny interface{} `json:"JSONAny"`
}

type JSONCodingKey struct {
	JSONCodingKey int64 `json:"JSONCodingKey"`
}

type JSONConverter struct {
	JSONConverter int64 `json:"json_converter"`
}

type JSONDecoder struct {
	JSONDecoder int64 `json:"JSONDecoder"`
}

type JSONEncoder struct {
	JSONEncoder int64 `json:"JSONEncoder"`
}

type JSONException struct {
	JSONException int64 `json:"JsonException"`
}

type JSONGenerator struct {
	JSONGenerator int64 `json:"JsonGenerator"`
}

type JSONNode struct {
	JSONNode int64 `json:"JsonNode"`
}

type JSONNull struct {
	JSONNull int64 `json:"JSONNull"`
}

type JSONParser struct {
	JSONParser int64 `json:"JsonParser"`
}

type JSONReader struct {
	JSONReader int64 `json:"JsonReader"`
}

type JSONSerializer struct {
	JSONSerializer int64 `json:"json_serializer"`
}

type JSONToken struct {
	JSONToken int64 `json:"json_token"`
}

type JSONTokenType struct {
	JSONTokenType int64 `json:"JsonTokenType"`
}

type JSONWriter struct {
	JSONWriter int64 `json:"json_writer"`
}

type Jdec struct {
	Jdec int64 `json:"jdec"`
}

type Jenc struct {
	Jenc int64 `json:"jenc"`
}

type Jpipe struct {
	Jpipe int64 `json:"jpipe"`
}

type Lambda struct {
	Lambda int64 `json:"lambda"`
}

type Lazy struct {
	Lazy int64 `json:"lazy"`
}

type Left struct {
	Left int64 `json:"left"`
}

type Let struct {
	Let int64 `json:"let"`
}

type List struct {
	List int64 `json:"list"`
}

type LocalDate struct {
	LocalDate int64 `json:"LocalDate"`
}

type Locale struct {
	Locale int64 `json:"Locale"`
}

type Lock struct {
	Lock int64 `json:"lock"`
}

type Long struct {
	Long int64 `json:"long"`
}

type LongNode struct {
	LongNode int64 `json:"LongNode"`
}

type Map struct {
	Map int64 `json:"map"`
}

type MapEntry struct {
	MapEntry int64 `json:"MapEntry"`
}

type MarshalJSON struct {
	MarshalJSON int64 `json:"MarshalJSON"`
}

type MetadataPropertyHandling struct {
	MetadataPropertyHandling int64 `json:"metadata_property_handling"`
}

type Module struct {
	Module int64 `json:"module"`
}

type Obj4 struct {
	Dummy           int64           `json:"dummy"`
	Mutable         Mutable         `json:"mutable"`
	Mutating        Mutating        `json:"mutating"`
	NSError         NSError         `json:"NSError"`
	NSObject        NSObject        `json:"NSObject"`
	NSString        NSString        `json:"NSString"`
	Namespace       Namespace       `json:"namespace"`
	Native          Native          `json:"native"`
	New             New             `json:"new"`
	Newtonsoft      Newtonsoft      `json:"newtonsoft"`
	Nil             Nil             `json:"nil"`
	No              No              `json:"NO"`
	NoSuchMethod    NoSuchMethod    `json:"noSuchMethod"`
	Noexcept        Noexcept        `json:"noexcept"`
	Nonatomic       Nonatomic       `json:"nonatomic"`
	None            None            `json:"None"`
	Nonlocal        Nonlocal        `json:"nonlocal"`
	Nonmutating     Nonmutating     `json:"nonmutating"`
	Not             Not             `json:"not"`
	NotEq           NotEq           `json:"not_eq"`
	Null            Null            `json:"NULL"`
	NullNode        NullNode        `json:"NullNode"`
	Nullptr         Nullptr         `json:"nullptr"`
	Number          Number          `json:"number"`
	Obj4None        NoneClass       `json:"none"`
	Obj4Null        NullClass       `json:"null"`
	Obj4Protocol    ProtocolClass   `json:"protocol"`
	Object          Object          `json:"object"`
	ObjectMapper    ObjectMapper    `json:"ObjectMapper"`
	ObjectNode      ObjectNode      `json:"ObjectNode"`
	ObjectReader    ObjectReader    `json:"ObjectReader"`
	ObjectWriter    ObjectWriter    `json:"ObjectWriter"`
	Of              Of              `json:"of"`
	OffsetDateTime  OffsetDateTime  `json:"OffsetDateTime"`
	OffsetTime      OffsetTime      `json:"OffsetTime"`
	Oneway          Oneway          `json:"oneway"`
	Open            Open            `json:"open"`
	Operator        Operator        `json:"operator"`
	Optional        Optional        `json:"optional"`
	Or              Or              `json:"or"`
	OrEq            OrEq            `json:"or_eq"`
	Out             Out             `json:"out"`
	Override        Override        `json:"override"`
	Package         Package         `json:"package"`
	Params          Params          `json:"params"`
	Pass            Pass            `json:"pass"`
	Port            Port            `json:"port"`
	Postfix         Postfix         `json:"postfix"`
	Precedence      Precedence      `json:"precedence"`
	Prefix          Prefix          `json:"prefix"`
	Print           Print           `json:"print"`
	PrintMembers    PrintMembers    `json:"printMembers"`
	Printf          Printf          `json:"printf"`
	Private         Private         `json:"private"`
	Protected       Protected       `json:"protected"`
	Protocol        Protocol        `json:"Protocol"`
	Public          Public          `json:"public"`
	Quicktype       Quicktype       `json:"quicktype"`
	Raise           Raise           `json:"raise"`
	Range           Range           `json:"range"`
	Readonly        Readonly        `json:"readonly"`
	Ref             Ref             `json:"ref"`
	RegExp          RegExp          `json:"RegExp"`
	Register        Register        `json:"register"`
	ReinterpretCast ReinterpretCast `json:"reinterpret_cast"`
}

type Mutable struct {
	Mutable int64 `json:"mutable"`
}

type Mutating struct {
	Mutating int64 `json:"mutating"`
}

type NSError struct {
	NSError int64 `json:"NSError"`
}

type NSObject struct {
	NSObject int64 `json:"NSObject"`
}

type NSString struct {
	NSString int64 `json:"NSString"`
}

type Namespace struct {
	Namespace int64 `json:"namespace"`
}

type Native struct {
	Native int64 `json:"native"`
}

type New struct {
	New int64 `json:"new"`
}

type Newtonsoft struct {
	Newtonsoft int64 `json:"newtonsoft"`
}

type Nil struct {
	Nil int64 `json:"nil"`
}

type No struct {
	No int64 `json:"NO"`
}

type NoSuchMethod struct {
	NoSuchMethod int64 `json:"noSuchMethod"`
}

type Noexcept struct {
	Noexcept int64 `json:"noexcept"`
}

type Nonatomic struct {
	Nonatomic int64 `json:"nonatomic"`
}

type None struct {
	None int64 `json:"None"`
}

type Nonlocal struct {
	Nonlocal int64 `json:"nonlocal"`
}

type Nonmutating struct {
	Nonmutating int64 `json:"nonmutating"`
}

type Not struct {
	Not int64 `json:"not"`
}

type NotEq struct {
	NotEq int64 `json:"not_eq"`
}

type Null struct {
	Null int64 `json:"NULL"`
}

type NullNode struct {
	NullNode int64 `json:"NullNode"`
}

type Nullptr struct {
	Nullptr int64 `json:"nullptr"`
}

type Number struct {
	Number int64 `json:"number"`
}

type NoneClass struct {
	None int64 `json:"none"`
}

type NullClass struct {
	Null int64 `json:"null"`
}

type ProtocolClass struct {
	Protocol int64 `json:"protocol"`
}

type Object struct {
	Object int64 `json:"object"`
}

type ObjectMapper struct {
	ObjectMapper int64 `json:"ObjectMapper"`
}

type ObjectNode struct {
	ObjectNode int64 `json:"ObjectNode"`
}

type ObjectReader struct {
	ObjectReader int64 `json:"ObjectReader"`
}

type ObjectWriter struct {
	ObjectWriter int64 `json:"ObjectWriter"`
}

type Of struct {
	Of int64 `json:"of"`
}

type OffsetDateTime struct {
	OffsetDateTime int64 `json:"OffsetDateTime"`
}

type OffsetTime struct {
	OffsetTime int64 `json:"OffsetTime"`
}

type Oneway struct {
	Oneway int64 `json:"oneway"`
}

type Open struct {
	Open int64 `json:"open"`
}

type Operator struct {
	Operator int64 `json:"operator"`
}

type Optional struct {
	Optional int64 `json:"optional"`
}

type Or struct {
	Or int64 `json:"or"`
}

type OrEq struct {
	OrEq int64 `json:"or_eq"`
}

type Out struct {
	Out int64 `json:"out"`
}

type Override struct {
	Override int64 `json:"override"`
}

type Package struct {
	Package int64 `json:"package"`
}

type Params struct {
	Params int64 `json:"params"`
}

type Pass struct {
	Pass int64 `json:"pass"`
}

type Port struct {
	Port int64 `json:"port"`
}

type Postfix struct {
	Postfix int64 `json:"postfix"`
}

type Precedence struct {
	Precedence int64 `json:"precedence"`
}

type Prefix struct {
	Prefix int64 `json:"prefix"`
}

type Print struct {
	Print int64 `json:"print"`
}

type PrintMembers struct {
	PrintMembers int64 `json:"printMembers"`
}

type Printf struct {
	Printf int64 `json:"printf"`
}

type Private struct {
	Private int64 `json:"private"`
}

type Protected struct {
	Protected int64 `json:"protected"`
}

type Protocol struct {
	Protocol int64 `json:"Protocol"`
}

type Public struct {
	Public int64 `json:"public"`
}

type Quicktype struct {
	Quicktype int64 `json:"quicktype"`
}

type Raise struct {
	Raise int64 `json:"raise"`
}

type Range struct {
	Range int64 `json:"range"`
}

type Readonly struct {
	Readonly int64 `json:"readonly"`
}

type Ref struct {
	Ref int64 `json:"ref"`
}

type RegExp struct {
	RegExp string `json:"RegExp"`
}

type Register struct {
	Register int64 `json:"register"`
}

type ReinterpretCast struct {
	ReinterpretCast int64 `json:"reinterpret_cast"`
}

type Obj5 struct {
	Dummy                int64                `json:"dummy"`
	KSerializer          KSerializer          `json:"KSerializer"`
	Obj5Self             SelfClass            `json:"self"`
	Obj5True             TrueClass            `json:"true"`
	PrimitiveKind        PrimitiveKind        `json:"PrimitiveKind"`
	Repeat               Repeat               `json:"repeat"`
	Require              Require              `json:"require"`
	Required             Required             `json:"required"`
	Requires             Requires             `json:"requires"`
	Restrict             Restrict             `json:"restrict"`
	Retain               Retain               `json:"retain"`
	Rethrows             Rethrows             `json:"rethrows"`
	Return               Return               `json:"return"`
	Right                Right                `json:"right"`
	RuntimeType          RuntimeType          `json:"runtimeType"`
	S                    S                    `json:"s"`
	Sbyte                Sbyte                `json:"sbyte"`
	Sealed               Sealed               `json:"sealed"`
	Sel                  Sel                  `json:"SEL"`
	Select               Select               `json:"select"`
	Self                 Self                 `json:"Self"`
	Sendable             Sendable             `json:"Sendable"`
	SerialDescriptor     SerialDescriptor     `json:"SerialDescriptor"`
	SerialName           SerialName           `json:"SerialName"`
	Serializable         Serializable         `json:"Serializable"`
	SerializationFeature SerializationFeature `json:"SerializationFeature"`
	Serialize            Serialize            `json:"serialize"`
	SerializerProvider   SerializerProvider   `json:"SerializerProvider"`
	Set                  Set                  `json:"set"`
	Short                Short                `json:"short"`
	Signed               Signed               `json:"signed"`
	SimpleModule         SimpleModule         `json:"SimpleModule"`
	Sizeof               Sizeof               `json:"sizeof"`
	Stackalloc           Stackalloc           `json:"stackalloc"`
	Standards            Standards            `json:"Standards"`
	Static               Static               `json:"static"`
	StaticAssert         StaticAssert         `json:"static_assert"`
	StaticCast           StaticCast           `json:"static_cast"`
	StdDeserializer      StdDeserializer      `json:"StdDeserializer"`
	StdSerializer        StdSerializer        `json:"StdSerializer"`
	Strictfp             Strictfp             `json:"strictfp"`
	String               String               `json:"string"`
	Struct               Struct               `json:"struct"`
	Subscript            Subscript            `json:"subscript"`
	Super                Super                `json:"super"`
	Switch               Switch               `json:"switch"`
	Symbol               Symbol               `json:"symbol"`
	Synchronized         Synchronized         `json:"synchronized"`
	System               System               `json:"system"`
	Template             Template             `json:"template"`
	TextNode             TextNode             `json:"TextNode"`
	Then                 Then                 `json:"then"`
	This                 This                 `json:"this"`
	ThreadLocal          ThreadLocal          `json:"thread_local"`
	Throw                Throw                `json:"throw"`
	Throws               Throws               `json:"throws"`
	TimeOnly             TimeOnly             `json:"TimeOnly"`
	TimeOnlyConverter    TimeOnlyConverter    `json:"TimeOnlyConverter"`
	TimeZone             TimeZone             `json:"TimeZone"`
	ToDict               ToDict               `json:"to_dict"`
	ToJSON               ToJSON               `json:"to_json"`
	ToString             ToString             `json:"toString"`
	TopLevel             TopLevelClass        `json:"top_level"`
	Transient            Transient            `json:"transient"`
	True                 True                 `json:"True"`
}

type KSerializer struct {
	KSerializer int64 `json:"KSerializer"`
}

type SelfClass struct {
	Self int64 `json:"self"`
}

type TrueClass struct {
	True int64 `json:"true"`
}

type PrimitiveKind struct {
	PrimitiveKind int64 `json:"PrimitiveKind"`
}

type Repeat struct {
	Repeat int64 `json:"repeat"`
}

type Require struct {
	Require int64 `json:"require"`
}

type Required struct {
	Required int64 `json:"required"`
}

type Requires struct {
	Requires int64 `json:"requires"`
}

type Restrict struct {
	Restrict int64 `json:"restrict"`
}

type Retain struct {
	Retain int64 `json:"retain"`
}

type Rethrows struct {
	Rethrows int64 `json:"rethrows"`
}

type Return struct {
	Return int64 `json:"return"`
}

type Right struct {
	Right int64 `json:"right"`
}

type RuntimeType struct {
	RuntimeType int64 `json:"runtimeType"`
}

type S struct {
	S int64 `json:"s"`
}

type Sbyte struct {
	Sbyte int64 `json:"sbyte"`
}

type Sealed struct {
	Sealed int64 `json:"sealed"`
}

type Sel struct {
	Sel int64 `json:"SEL"`
}

type Select struct {
	Select int64 `json:"select"`
}

type Self struct {
	Self int64 `json:"Self"`
}

type Sendable struct {
	Sendable int64 `json:"Sendable"`
}

type SerialDescriptor struct {
	SerialDescriptor int64 `json:"SerialDescriptor"`
}

type SerialName struct {
	SerialName int64 `json:"SerialName"`
}

type Serializable struct {
	Serializable int64 `json:"Serializable"`
}

type SerializationFeature struct {
	SerializationFeature int64 `json:"SerializationFeature"`
}

type Serialize struct {
	Serialize int64 `json:"serialize"`
}

type SerializerProvider struct {
	SerializerProvider int64 `json:"SerializerProvider"`
}

type Set struct {
	Set int64 `json:"set"`
}

type Short struct {
	Short int64 `json:"short"`
}

type Signed struct {
	Signed int64 `json:"signed"`
}

type SimpleModule struct {
	SimpleModule int64 `json:"SimpleModule"`
}

type Sizeof struct {
	Sizeof int64 `json:"sizeof"`
}

type Stackalloc struct {
	Stackalloc int64 `json:"stackalloc"`
}

type Standards struct {
	Standards int64 `json:"Standards"`
}

type Static struct {
	Static int64 `json:"static"`
}

type StaticAssert struct {
	StaticAssert int64 `json:"static_assert"`
}

type StaticCast struct {
	StaticCast int64 `json:"static_cast"`
}

type StdDeserializer struct {
	StdDeserializer int64 `json:"StdDeserializer"`
}

type StdSerializer struct {
	StdSerializer int64 `json:"StdSerializer"`
}

type Strictfp struct {
	Strictfp int64 `json:"strictfp"`
}

type String struct {
	String int64 `json:"string"`
}

type Struct struct {
	Struct int64 `json:"struct"`
}

type Subscript struct {
	Subscript int64 `json:"subscript"`
}

type Super struct {
	Super int64 `json:"super"`
}

type Switch struct {
	Switch int64 `json:"switch"`
}

type Symbol struct {
	Symbol int64 `json:"symbol"`
}

type Synchronized struct {
	Synchronized int64 `json:"synchronized"`
}

type System struct {
	System int64 `json:"system"`
}

type Template struct {
	Template int64 `json:"template"`
}

type TextNode struct {
	TextNode int64 `json:"TextNode"`
}

type Then struct {
	Then int64 `json:"then"`
}

type This struct {
	This int64 `json:"this"`
}

type ThreadLocal struct {
	ThreadLocal int64 `json:"thread_local"`
}

type Throw struct {
	Throw int64 `json:"throw"`
}

type Throws struct {
	Throws int64 `json:"throws"`
}

type TimeOnly struct {
	TimeOnly int64 `json:"TimeOnly"`
}

type TimeOnlyConverter struct {
	TimeOnlyConverter int64 `json:"TimeOnlyConverter"`
}

type TimeZone struct {
	TimeZone int64 `json:"TimeZone"`
}

type ToDict struct {
	ToDict int64 `json:"to_dict"`
}

type ToJSON struct {
	ToJSON int64 `json:"to_json"`
}

type ToString struct {
	ToString int64 `json:"toString"`
}

type TopLevelClass struct {
	TopLevel int64 `json:"top_level"`
}

type Transient struct {
	Transient int64 `json:"transient"`
}

type True struct {
	True int64 `json:"True"`
}

type Obj6 struct {
	Dummy          int64          `json:"dummy"`
	Obj6Type       TypeClass      `json:"type"`
	Try            Try            `json:"try"`
	Type           Type           `json:"Type"`
	Typealias      Typealias      `json:"typealias"`
	Typedef        Typedef        `json:"typedef"`
	Typeid         Typeid         `json:"typeid"`
	Typename       Typename       `json:"typename"`
	Typeof         Typeof         `json:"typeof"`
	UUID           UUID           `json:"UUID"`
	Uint           Uint           `json:"uint"`
	Ulong          Ulong          `json:"ulong"`
	Unchecked      Unchecked      `json:"unchecked"`
	Undefined      Undefined      `json:"undefined"`
	Union          Union          `json:"union"`
	UnmarshalJSON  UnmarshalJSON  `json:"UnmarshalJSON"`
	Unowned        Unowned        `json:"unowned"`
	Unsafe         Unsafe         `json:"unsafe"`
	Unsigned       Unsigned       `json:"unsigned"`
	UseSerializers UseSerializers `json:"UseSerializers"`
	Ushort         Ushort         `json:"ushort"`
	Using          Using          `json:"using"`
	Utf8JSONReader Utf8JSONReader `json:"Utf8JsonReader"`
	Utf8JSONWriter Utf8JSONWriter `json:"Utf8JsonWriter"`
	Var            Var            `json:"var"`
	Virtual        Virtual        `json:"virtual"`
	Void           Void           `json:"void"`
	Volatile       Volatile       `json:"volatile"`
	WcharT         WcharT         `json:"wchar_t"`
	Weak           Weak           `json:"weak"`
	Where          Where          `json:"where"`
	While          While          `json:"while"`
	WillSet        WillSet        `json:"willSet"`
	With           With           `json:"with"`
	Xor            Xor            `json:"xor"`
	XorEq          XorEq          `json:"xor_eq"`
	Yes            Yes            `json:"YES"`
	Yield          Yield          `json:"yield"`
}

type TypeClass struct {
	Type int64 `json:"type"`
}

type Try struct {
	Try int64 `json:"try"`
}

type Type struct {
	Type int64 `json:"Type"`
}

type Typealias struct {
	Typealias int64 `json:"typealias"`
}

type Typedef struct {
	Typedef int64 `json:"typedef"`
}

type Typeid struct {
	Typeid int64 `json:"typeid"`
}

type Typename struct {
	Typename int64 `json:"typename"`
}

type Typeof struct {
	Typeof int64 `json:"typeof"`
}

type UUID struct {
	UUID int64 `json:"UUID"`
}

type Uint struct {
	Uint int64 `json:"uint"`
}

type Ulong struct {
	Ulong int64 `json:"ulong"`
}

type Unchecked struct {
	Unchecked int64 `json:"unchecked"`
}

type Undefined struct {
	Undefined int64 `json:"undefined"`
}

type Union struct {
	Union int64 `json:"union"`
}

type UnmarshalJSON struct {
	UnmarshalJSON int64 `json:"UnmarshalJSON"`
}

type Unowned struct {
	Unowned int64 `json:"unowned"`
}

type Unsafe struct {
	Unsafe int64 `json:"unsafe"`
}

type Unsigned struct {
	Unsigned int64 `json:"unsigned"`
}

type UseSerializers struct {
	UseSerializers int64 `json:"UseSerializers"`
}

type Ushort struct {
	Ushort int64 `json:"ushort"`
}

type Using struct {
	Using int64 `json:"using"`
}

type Utf8JSONReader struct {
	Utf8JSONReader int64 `json:"Utf8JsonReader"`
}

type Utf8JSONWriter struct {
	Utf8JSONWriter int64 `json:"Utf8JsonWriter"`
}

type Var struct {
	Var int64 `json:"var"`
}

type Virtual struct {
	Virtual int64 `json:"virtual"`
}

type Void struct {
	Void int64 `json:"void"`
}

type Volatile struct {
	Volatile int64 `json:"volatile"`
}

type WcharT struct {
	WcharT int64 `json:"wchar_t"`
}

type Weak struct {
	Weak int64 `json:"weak"`
}

type Where struct {
	Where int64 `json:"where"`
}

type While struct {
	While int64 `json:"while"`
}

type WillSet struct {
	WillSet int64 `json:"willSet"`
}

type With struct {
	With int64 `json:"with"`
}

type Xor struct {
	Xor int64 `json:"xor"`
}

type XorEq struct {
	XorEq int64 `json:"xor_eq"`
}

type Yes struct {
	Yes int64 `json:"YES"`
}

type Yield struct {
	Yield int64 `json:"yield"`
}

type EnumValue string

const (
	Ready EnumValue = "ready"
	Done  EnumValue = "done"
)

type invalidEnumValue string
func (x invalidEnumValue) Error() string { return "invalid EnumValue: " + string(x) }

func (x *EnumValue) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch EnumValue(value) {
	case Ready, Done: *x = EnumValue(value); return nil
	}
	return invalidEnumValue(value)
}
