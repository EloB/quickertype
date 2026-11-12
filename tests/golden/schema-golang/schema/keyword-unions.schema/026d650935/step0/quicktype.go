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
	Empty                      *UnionUnion                      `json:"_"`
	TopLevelBool               *UnionBool                       `json:"_Bool"`
	Complex                    *UnionComplex                    `json:"_Complex"`
	Imaginery                  *UnionImaginery                  `json:"_Imaginery"`
	Abstract                   *UnionAbstract                   `json:"abstract"`
	Alignas                    *UnionAlignas                    `json:"alignas"`
	Alignof                    *UnionAlignof                    `json:"alignof"`
	And                        *UnionAnd                        `json:"and"`
	AndEq                      *UnionAndEq                      `json:"and_eq"`
	TopLevelAny                *UnionAnyUnion                   `json:"any"`
	Any                        *UnionAny                        `json:"Any"`
	Array                      *UnionArray                      `json:"array"`
	ArrayNode                  *UnionArrayNode                  `json:"ArrayNode"`
	As                         *UnionAs                         `json:"as"`
	ASM                        *UnionASM                        `json:"asm"`
	Assert                     *UnionAssert                     `json:"assert"`
	Associatedtype             *UnionAssociatedtype             `json:"associatedtype"`
	Associativity              *UnionAssociativity              `json:"associativity"`
	Async                      *UnionAsync                      `json:"async"`
	Atomic                     *UnionAtomic                     `json:"atomic"`
	AtomicCancel               *UnionAtomicCancel               `json:"atomic_cancel"`
	AtomicCommit               *UnionAtomicCommit               `json:"atomic_commit"`
	AtomicNoexcept             *UnionAtomicNoexcept             `json:"atomic_noexcept"`
	Auto                       *UnionAuto                       `json:"auto"`
	Await                      *UnionAwait                      `json:"await"`
	Base                       *UnionBase                       `json:"base"`
	Bitand                     *UnionBitand                     `json:"bitand"`
	Bitor                      *UnionBitor                      `json:"bitor"`
	Bool                       *UnionBOOL                       `json:"BOOL"`
	PurpleBool                 *UnionBoolUnion                  `json:"bool"`
	Boolean                    *UnionBoolean                    `json:"boolean"`
	BooleanNode                *UnionBooleanNode                `json:"BooleanNode"`
	Break                      *UnionBreak                      `json:"break"`
	Bycopy                     *UnionBycopy                     `json:"bycopy"`
	Byref                      *UnionByref                      `json:"byref"`
	Byte                       *UnionByte                       `json:"byte"`
	Calendar                   *UnionCalendar                   `json:"Calendar"`
	Case                       *UnionCase                       `json:"case"`
	Catch                      *UnionCatch                      `json:"catch"`
	Chan                       *UnionChan                       `json:"chan"`
	Char                       *UnionChar                       `json:"char"`
	Char16T                    *UnionChar16T                    `json:"char16_t"`
	Char32T                    *UnionChar32T                    `json:"char32_t"`
	Checked                    *UnionChecked                    `json:"checked"`
	TopLevelClass              *UnionClassUnion                 `json:"class"`
	Class                      *UnionClass                      `json:"Class"`
	Clone                      *UnionClone                      `json:"clone"`
	CoAwait                    *UnionCoAwait                    `json:"co_await"`
	CoReturn                   *UnionCoReturn                   `json:"co_return"`
	CoYield                    *UnionCoYield                    `json:"co_yield"`
	Codable                    *UnionCodable                    `json:"Codable"`
	CodingKey                  *UnionCodingKey                  `json:"CodingKey"`
	CodingKeys                 *UnionCodingKeys                 `json:"CodingKeys"`
	Compl                      *UnionCompl                      `json:"compl"`
	Concept                    *UnionConcept                    `json:"concept"`
	Console                    *UnionConsole                    `json:"console"`
	Const                      *UnionConst                      `json:"const"`
	ConstCast                  *UnionConstCast                  `json:"const_cast"`
	Constexpr                  *UnionConstexpr                  `json:"constexpr"`
	Constructor                *UnionConstructor                `json:"constructor"`
	Continue                   *UnionContinue                   `json:"continue"`
	Convenience                *UnionConvenience                `json:"convenience"`
	Convert                    *UnionConvert                    `json:"convert"`
	Converter                  *UnionConverter                  `json:"converter"`
	CultureInfo                *UnionCultureInfo                `json:"CultureInfo"`
	Date                       *UnionDate                       `json:"date"`
	DateParseHandling          *UnionDateParseHandling          `json:"date_parse_handling"`
	DateFormatter              *UnionDateFormatter              `json:"DateFormatter"`
	DateOnly                   *UnionDateOnly                   `json:"DateOnly"`
	DateOnlyConverter          *UnionDateOnlyConverter          `json:"DateOnlyConverter"`
	DateTime                   *UnionDateTime                   `json:"DateTime"`
	DateTimeStyles             *UnionDateTimeStyles             `json:"DateTimeStyles"`
	Debugger                   *UnionDebugger                   `json:"debugger"`
	Decimal                    *UnionDecimal                    `json:"decimal"`
	Declare                    *UnionDeclare                    `json:"declare"`
	Decltype                   *UnionDecltype                   `json:"decltype"`
	DecodeString               *UnionDecodeString               `json:"decode_string"`
	Decoder                    *UnionDecoder                    `json:"Decoder"`
	DecodingError              *UnionDecodingError              `json:"DecodingError"`
	Def                        *UnionDef                        `json:"def"`
	Default                    *UnionDefault                    `json:"default"`
	Defer                      *UnionDefer                      `json:"defer"`
	Deinit                     *UnionDeinit                     `json:"deinit"`
	Del                        *UnionDel                        `json:"del"`
	Delegate                   *UnionDelegate                   `json:"delegate"`
	Delete                     *UnionDelete                     `json:"delete"`
	DeserializationFeature     *UnionDeserializationFeature     `json:"DeserializationFeature"`
	Dict                       *UnionDict                       `json:"dict"`
	Dictionary                 *UnionDictionary                 `json:"dictionary"`
	DidSet                     *UnionDidSet                     `json:"didSet"`
	Do                         *UnionDo                         `json:"do"`
	Double                     *UnionDouble                     `json:"double"`
	DoubleNode                 *UnionDoubleNode                 `json:"DoubleNode"`
	Dummy                      *float64                         `json:"dummy,omitempty"`
	Dynamic                    *UnionDynamic                    `json:"dynamic"`
	DynamicCast                *UnionDynamicCast                `json:"dynamic_cast"`
	Elif                       *UnionElif                       `json:"elif"`
	Else                       *UnionElse                       `json:"else"`
	EncodeQuickType            *UnionEncodeQuickType            `json:"encode_quick_type"`
	Encoder                    *UnionEncoder                    `json:"Encoder"`
	Enum                       *UnionEnum                       `json:"enum"`
	EnumValues                 *UnionEnumValues                 `json:"EnumValues"`
	EqualityContract           *UnionEqualityContract           `json:"equalityContract"`
	Equatable                  *UnionEquatable                  `json:"Equatable"`
	Event                      *UnionEvent                      `json:"event"`
	Except                     *UnionExcept                     `json:"except"`
	Exception                  *UnionException                  `json:"exception"`
	Explicit                   *UnionExplicit                   `json:"explicit"`
	Export                     *UnionExport                     `json:"export"`
	Exposing                   *UnionExposing                   `json:"exposing"`
	Extends                    *UnionExtends                    `json:"extends"`
	Extension                  *UnionExtension                  `json:"extension"`
	Extern                     *UnionExtern                     `json:"extern"`
	Fallthrough                *UnionFallthrough                `json:"fallthrough"`
	TopLevelFalse              *UnionFalseUnion                 `json:"false"`
	False                      *UnionFalse                      `json:"False"`
	Fileprivate                *UnionFileprivate                `json:"fileprivate"`
	Final                      *UnionFinal                      `json:"final"`
	Finally                    *UnionFinally                    `json:"finally"`
	Fixed                      *UnionFixed                      `json:"fixed"`
	Float                      *UnionFloat                      `json:"float"`
	For                        *UnionFor                        `json:"for"`
	Foreach                    *UnionForeach                    `json:"foreach"`
	FormatException            *UnionFormatException            `json:"FormatException"`
	Friend                     *UnionFriend                     `json:"friend"`
	From                       *UnionFrom                       `json:"from"`
	FromDict                   *UnionFromDict                   `json:"from_dict"`
	FromJSON                   *UnionFromJSON                   `json:"from_json"`
	Func                       *UnionFunc                       `json:"func"`
	Function                   *UnionFunction                   `json:"function"`
	Get                        *UnionGet                        `json:"get"`
	Global                     *UnionGlobal                     `json:"global"`
	Go                         *UnionGo                         `json:"go"`
	Goto                       *UnionGoto                       `json:"goto"`
	Guard                      *UnionGuard                      `json:"guard"`
	Hashable                   *UnionHashable                   `json:"Hashable"`
	HashCode                   *UnionHashCode                   `json:"hashCode"`
	Hasher                     *UnionHasher                     `json:"Hasher"`
	HasOwnProperty             *UnionHasOwnProperty             `json:"hasOwnProperty"`
	ID                         *UnionID                         `json:"id"`
	If                         *UnionIf                         `json:"if"`
	Imp                        *UnionIMP                        `json:"IMP"`
	Implements                 *UnionImplements                 `json:"implements"`
	Implicit                   *UnionImplicit                   `json:"implicit"`
	Import                     *UnionImport                     `json:"import"`
	In                         *UnionIn                         `json:"in"`
	Indirect                   *UnionIndirect                   `json:"indirect"`
	Infix                      *UnionInfix                      `json:"infix"`
	Init                       *UnionInit                       `json:"init"`
	Inline                     *UnionInline                     `json:"inline"`
	Inout                      *UnionInout                      `json:"inout"`
	Instanceof                 *UnionInstanceof                 `json:"instanceof"`
	Int                        *UnionInt                        `json:"int"`
	Interface                  *UnionInterface                  `json:"interface"`
	Internal                   *UnionInternal                   `json:"internal"`
	IntNode                    *UnionIntNode                    `json:"IntNode"`
	Is                         *UnionIs                         `json:"is"`
	ISODateTimeOffsetConverter *UnionISODateTimeOffsetConverter `json:"IsoDateTimeOffsetConverter"`
	Iterable                   *UnionIterable                   `json:"iterable"`
	Jdec                       *UnionJdec                       `json:"jdec"`
	Jenc                       *UnionJenc                       `json:"jenc"`
	Jpipe                      *UnionJpipe                      `json:"jpipe"`
	JSON                       *UnionJSON                       `json:"json"`
	JSONConverter              *UnionJSONConverter              `json:"json_converter"`
	JSONSerializer             *UnionJSONSerializer             `json:"json_serializer"`
	JSONToken                  *UnionJSONToken                  `json:"json_token"`
	JSONWriter                 *UnionJSONWriter                 `json:"json_writer"`
	JSONAny                    *UnionJSONAny                    `json:"JSONAny"`
	JSONCodingKey              *UnionJSONCodingKey              `json:"JSONCodingKey"`
	JSONDecoder                *UnionJSONDecoder                `json:"JSONDecoder"`
	JSONEncoder                *UnionJSONEncoder                `json:"JSONEncoder"`
	JSONException              *UnionJSONException              `json:"JsonException"`
	JSONGenerator              *UnionJSONGenerator              `json:"JsonGenerator"`
	JSONNode                   *UnionJSONNode                   `json:"JsonNode"`
	JSONNull                   *UnionJSONNull                   `json:"JSONNull"`
	JSONParser                 *UnionJSONParser                 `json:"JsonParser"`
	JSONReader                 *UnionJSONReader                 `json:"JsonReader"`
	JSONTokenType              *UnionJSONTokenType              `json:"JsonTokenType"`
	KSerializer                *UnionKSerializer                `json:"KSerializer"`
	Lambda                     *UnionLambda                     `json:"lambda"`
	Lazy                       *UnionLazy                       `json:"lazy"`
	Left                       *UnionLeft                       `json:"left"`
	Let                        *UnionLet                        `json:"let"`
	List                       *UnionList                       `json:"list"`
	LocalDate                  *UnionLocalDate                  `json:"LocalDate"`
	Locale                     *UnionLocale                     `json:"Locale"`
	Lock                       *UnionLock                       `json:"lock"`
	Long                       *UnionLong                       `json:"long"`
	LongNode                   *UnionLongNode                   `json:"LongNode"`
	Map                        *UnionMap                        `json:"map"`
	MapEntry                   *UnionMapEntry                   `json:"MapEntry"`
	MarshalJSON                *UnionMarshalJSON                `json:"MarshalJSON"`
	MetadataPropertyHandling   *UnionMetadataPropertyHandling   `json:"metadata_property_handling"`
	Module                     *UnionModule                     `json:"module"`
	Mutable                    *UnionMutable                    `json:"mutable"`
	Mutating                   *UnionMutating                   `json:"mutating"`
	Namespace                  *UnionNamespace                  `json:"namespace"`
	Native                     *UnionNative                     `json:"native"`
	New                        *UnionNew                        `json:"new"`
	Newtonsoft                 *UnionNewtonsoft                 `json:"newtonsoft"`
	Nil                        *UnionNil                        `json:"nil"`
	No                         *UnionNO                         `json:"NO"`
	Noexcept                   *UnionNoexcept                   `json:"noexcept"`
	Nonatomic                  *UnionNonatomic                  `json:"nonatomic"`
	TopLevelNone               *UnionNoneUnion                  `json:"none"`
	None                       *UnionNone                       `json:"None"`
	Nonlocal                   *UnionNonlocal                   `json:"nonlocal"`
	Nonmutating                *UnionNonmutating                `json:"nonmutating"`
	NoSuchMethod               *UnionNoSuchMethod               `json:"noSuchMethod"`
	Not                        *UnionNot                        `json:"not"`
	NotEq                      *UnionNotEq                      `json:"not_eq"`
	NSError                    *UnionNSError                    `json:"NSError"`
	NSObject                   *UnionNSObject                   `json:"NSObject"`
	NSString                   *UnionNSString                   `json:"NSString"`
	Null                       *UnionNULL                       `json:"NULL"`
	TopLevelNull               *UnionNull                       `json:"null"`
	NullNode                   *UnionNullNode                   `json:"NullNode"`
	Nullptr                    *UnionNullptr                    `json:"nullptr"`
	Number                     *UnionNumber                     `json:"number"`
	Object                     *UnionObject                     `json:"object"`
	ObjectMapper               *UnionObjectMapper               `json:"ObjectMapper"`
	ObjectNode                 *UnionObjectNode                 `json:"ObjectNode"`
	ObjectReader               *UnionObjectReader               `json:"ObjectReader"`
	ObjectWriter               *UnionObjectWriter               `json:"ObjectWriter"`
	Of                         *UnionOf                         `json:"of"`
	OffsetDateTime             *UnionOffsetDateTime             `json:"OffsetDateTime"`
	OffsetTime                 *UnionOffsetTime                 `json:"OffsetTime"`
	Oneway                     *UnionOneway                     `json:"oneway"`
	Open                       *UnionOpen                       `json:"open"`
	Operator                   *UnionOperator                   `json:"operator"`
	Optional                   *UnionOptional                   `json:"optional"`
	Or                         *UnionOr                         `json:"or"`
	OrEq                       *UnionOrEq                       `json:"or_eq"`
	Out                        *UnionOut                        `json:"out"`
	Override                   *UnionOverride                   `json:"override"`
	Package                    *UnionPackage                    `json:"package"`
	Params                     *UnionParams                     `json:"params"`
	Pass                       *UnionPass                       `json:"pass"`
	Port                       *UnionPort                       `json:"port"`
	Postfix                    *UnionPostfix                    `json:"postfix"`
	Precedence                 *UnionPrecedence                 `json:"precedence"`
	Prefix                     *UnionPrefix                     `json:"prefix"`
	PrimitiveKind              *UnionPrimitiveKind              `json:"PrimitiveKind"`
	Print                      *UnionPrint                      `json:"print"`
	Printf                     *UnionPrintf                     `json:"printf"`
	PrintMembers               *UnionPrintMembers               `json:"printMembers"`
	Private                    *UnionPrivate                    `json:"private"`
	Protected                  *UnionProtected                  `json:"protected"`
	Protocol                   *UnionProtocol                   `json:"Protocol"`
	TopLevelProtocol           *UnionProtocolUnion              `json:"protocol"`
	Public                     *UnionPublic                     `json:"public"`
	Quicktype                  *UnionQuicktype                  `json:"quicktype"`
	Raise                      *UnionRaise                      `json:"raise"`
	Range                      *UnionRange                      `json:"range"`
	Readonly                   *UnionReadonly                   `json:"readonly"`
	Ref                        *UnionRef                        `json:"ref"`
	RegExp                     *UnionRegExp                     `json:"RegExp"`
	Register                   *UnionRegister                   `json:"register"`
	ReinterpretCast            *UnionReinterpretCast            `json:"reinterpret_cast"`
	Repeat                     *UnionRepeat                     `json:"repeat"`
	Require                    *UnionRequire                    `json:"require"`
	Required                   *UnionRequired                   `json:"required"`
	Requires                   *UnionRequires                   `json:"requires"`
	Restrict                   *UnionRestrict                   `json:"restrict"`
	Retain                     *UnionRetain                     `json:"retain"`
	Rethrows                   *UnionRethrows                   `json:"rethrows"`
	Return                     *UnionReturn                     `json:"return"`
	Right                      *UnionRight                      `json:"right"`
	RuntimeType                *UnionRuntimeType                `json:"runtimeType"`
	S                          *UnionS                          `json:"s"`
	Sbyte                      *UnionSbyte                      `json:"sbyte"`
	Sealed                     *UnionSealed                     `json:"sealed"`
	Sel                        *UnionSEL                        `json:"SEL"`
	Select                     *UnionSelect                     `json:"select"`
	Self                       *UnionSelf                       `json:"Self"`
	TopLevelSelf               *UnionSelfUnion                  `json:"self"`
	Sendable                   *UnionSendable                   `json:"Sendable"`
	SerialDescriptor           *UnionSerialDescriptor           `json:"SerialDescriptor"`
	Serializable               *UnionSerializable               `json:"Serializable"`
	SerializationFeature       *UnionSerializationFeature       `json:"SerializationFeature"`
	Serialize                  *UnionSerialize                  `json:"serialize"`
	SerializerProvider         *UnionSerializerProvider         `json:"SerializerProvider"`
	SerialName                 *UnionSerialName                 `json:"SerialName"`
	Set                        *UnionSet                        `json:"set"`
	Short                      *UnionShort                      `json:"short"`
	Signed                     *UnionSigned                     `json:"signed"`
	SimpleModule               *UnionSimpleModule               `json:"SimpleModule"`
	Sizeof                     *UnionSizeof                     `json:"sizeof"`
	Stackalloc                 *UnionStackalloc                 `json:"stackalloc"`
	Standards                  *UnionStandards                  `json:"Standards"`
	Static                     *UnionStatic                     `json:"static"`
	StaticAssert               *UnionStaticAssert               `json:"static_assert"`
	StaticCast                 *UnionStaticCast                 `json:"static_cast"`
	StdDeserializer            *UnionStdDeserializer            `json:"StdDeserializer"`
	StdSerializer              *UnionStdSerializer              `json:"StdSerializer"`
	Strictfp                   *UnionStrictfp                   `json:"strictfp"`
	String                     *UnionString                     `json:"string"`
	Struct                     *UnionStruct                     `json:"struct"`
	Subscript                  *UnionSubscript                  `json:"subscript"`
	Super                      *UnionSuper                      `json:"super"`
	Switch                     *UnionSwitch                     `json:"switch"`
	Symbol                     *UnionSymbol                     `json:"symbol"`
	Synchronized               *UnionSynchronized               `json:"synchronized"`
	System                     *UnionSystem                     `json:"system"`
	Template                   *UnionTemplate                   `json:"template"`
	TextNode                   *UnionTextNode                   `json:"TextNode"`
	Then                       *UnionThen                       `json:"then"`
	This                       *UnionThis                       `json:"this"`
	ThreadLocal                *UnionThreadLocal                `json:"thread_local"`
	Throw                      *UnionThrow                      `json:"throw"`
	Throws                     *UnionThrows                     `json:"throws"`
	TimeOnly                   *UnionTimeOnly                   `json:"TimeOnly"`
	TimeOnlyConverter          *UnionTimeOnlyConverter          `json:"TimeOnlyConverter"`
	TimeZone                   *UnionTimeZone                   `json:"TimeZone"`
	ToDict                     *UnionToDict                     `json:"to_dict"`
	ToJSON                     *UnionToJSON                     `json:"to_json"`
	TopLevel                   *UnionTopLevel                   `json:"top_level"`
	ToString                   *UnionToString                   `json:"toString"`
	Transient                  *UnionTransient                  `json:"transient"`
	True                       *UnionTrue                       `json:"True"`
	TopLevelTrue               *UnionTrueUnion                  `json:"true"`
	Try                        *UnionTry                        `json:"try"`
	Type                       *UnionType                       `json:"Type"`
	TopLevelType               *UnionTypeUnion                  `json:"type"`
	Typealias                  *UnionTypealias                  `json:"typealias"`
	Typedef                    *UnionTypedef                    `json:"typedef"`
	Typeid                     *UnionTypeid                     `json:"typeid"`
	Typename                   *UnionTypename                   `json:"typename"`
	Typeof                     *UnionTypeof                     `json:"typeof"`
	Uint                       *UnionUint                       `json:"uint"`
	Ulong                      *UnionUlong                      `json:"ulong"`
	Unchecked                  *UnionUnchecked                  `json:"unchecked"`
	Undefined                  *UnionUndefined                  `json:"undefined"`
	Union                      *UnionUnionUnion                 `json:"union"`
	UnmarshalJSON              *UnionUnmarshalJSON              `json:"UnmarshalJSON"`
	Unowned                    *UnionUnowned                    `json:"unowned"`
	Unsafe                     *UnionUnsafe                     `json:"unsafe"`
	Unsigned                   *UnionUnsigned                   `json:"unsigned"`
	UseSerializers             *UnionUseSerializers             `json:"UseSerializers"`
	Ushort                     *UnionUshort                     `json:"ushort"`
	Using                      *UnionUsing                      `json:"using"`
	Utf8JSONReader             *UnionUtf8JSONReader             `json:"Utf8JsonReader"`
	Utf8JSONWriter             *UnionUtf8JSONWriter             `json:"Utf8JsonWriter"`
	UUID                       *UnionUUID                       `json:"UUID"`
	Var                        *UnionVar                        `json:"var"`
	Virtual                    *UnionVirtual                    `json:"virtual"`
	Void                       *UnionVoid                       `json:"void"`
	Volatile                   *UnionVolatile                   `json:"volatile"`
	WcharT                     *UnionWcharT                     `json:"wchar_t"`
	Weak                       *UnionWeak                       `json:"weak"`
	Where                      *UnionWhere                      `json:"where"`
	While                      *UnionWhile                      `json:"while"`
	WillSet                    *UnionWillSet                    `json:"willSet"`
	With                       *UnionWith                       `json:"with"`
	Xor                        *UnionXor                        `json:"xor"`
	XorEq                      *UnionXorEq                      `json:"xor_eq"`
	Yes                        *UnionYES                        `json:"YES"`
	Yield                      *UnionYield                      `json:"yield"`
}

type ASM struct {
}

type Abstract struct {
}

type Alignas struct {
}

type Alignof struct {
}

type And struct {
}

type AndEq struct {
}

type Any struct {
}

type Array struct {
}

type ArrayNode struct {
}

type As struct {
}

type Assert struct {
}

type Associatedtype struct {
}

type Associativity struct {
}

type Async struct {
}

type Atomic struct {
}

type AtomicCancel struct {
}

type AtomicCommit struct {
}

type AtomicNoexcept struct {
}

type Auto struct {
}

type Await struct {
}

type Base struct {
}

type Bitand struct {
}

type Bitor struct {
}

type Bool struct {
}

type Boolean struct {
}

type BooleanNode struct {
}

type Break struct {
}

type Bycopy struct {
}

type Byref struct {
}

type Byte struct {
}

type Calendar struct {
}

type Case struct {
}

type Catch struct {
}

type Chan struct {
}

type Char struct {
}

type Char16T struct {
}

type Char32T struct {
}

type Checked struct {
}

type Class struct {
}

type Clone struct {
}

type CoAwait struct {
}

type CoReturn struct {
}

type CoYield struct {
}

type Codable struct {
}

type CodingKey struct {
}

type CodingKeys struct {
}

type Compl struct {
}

type Complex struct {
}

type Concept struct {
}

type Console struct {
}

type Const struct {
}

type ConstCast struct {
}

type Constexpr struct {
}

type Constructor struct {
}

type Continue struct {
}

type Convenience struct {
}

type Convert struct {
}

type Converter struct {
}

type CultureInfo struct {
}

type Date struct {
}

type DateFormatter struct {
}

type DateOnly struct {
}

type DateOnlyConverter struct {
}

type DateParseHandling struct {
}

type DateTime struct {
}

type DateTimeStyles struct {
}

type Debugger struct {
}

type Decimal struct {
}

type Declare struct {
}

type Decltype struct {
}

type DecodeString struct {
}

type Decoder struct {
}

type DecodingError struct {
}

type Def struct {
}

type Default struct {
}

type Defer struct {
}

type Deinit struct {
}

type Del struct {
}

type Delegate struct {
}

type Delete struct {
}

type DeserializationFeature struct {
}

type Dict struct {
}

type Dictionary struct {
}

type DidSet struct {
}

type Do struct {
}

type Double struct {
}

type DoubleNode struct {
}

type Dynamic struct {
}

type DynamicCast struct {
}

type Elif struct {
}

type Else struct {
}

type Empty struct {
}

type EncodeQuickType struct {
}

type Encoder struct {
}

type Enum struct {
}

type EnumValues struct {
}

type EqualityContract struct {
}

type Equatable struct {
}

type Event struct {
}

type Except struct {
}

type Exception struct {
}

type Explicit struct {
}

type Export struct {
}

type Exposing struct {
}

type Extends struct {
}

type Extension struct {
}

type Extern struct {
}

type Fallthrough struct {
}

type False struct {
}

type Fileprivate struct {
}

type Final struct {
}

type Finally struct {
}

type Fixed struct {
}

type Float struct {
}

type For struct {
}

type Foreach struct {
}

type FormatException struct {
}

type Friend struct {
}

type From struct {
}

type FromDict struct {
}

type FromJSON struct {
}

type Func struct {
}

type Function struct {
}

type Get struct {
}

type Global struct {
}

type Go struct {
}

type Goto struct {
}

type Guard struct {
}

type HasOwnProperty struct {
}

type HashCode struct {
}

type Hashable struct {
}

type Hasher struct {
}

type ID struct {
}

type ISODateTimeOffsetConverter struct {
}

type If struct {
}

type Imaginery struct {
}

type Imp struct {
}

type Implements struct {
}

type Implicit struct {
}

type Import struct {
}

type In struct {
}

type Indirect struct {
}

type Infix struct {
}

type Init struct {
}

type Inline struct {
}

type Inout struct {
}

type Instanceof struct {
}

type Int struct {
}

type IntNode struct {
}

type Interface struct {
}

type Internal struct {
}

type Is struct {
}

type Iterable struct {
}

type JSON struct {
}

type JSONAny struct {
}

type JSONCodingKey struct {
}

type JSONConverter struct {
}

type JSONDecoder struct {
}

type JSONEncoder struct {
}

type JSONException struct {
}

type JSONGenerator struct {
}

type JSONNode struct {
}

type JSONNull struct {
}

type JSONParser struct {
}

type JSONReader struct {
}

type JSONSerializer struct {
}

type JSONToken struct {
}

type JSONTokenType struct {
}

type JSONWriter struct {
}

type Jdec struct {
}

type Jenc struct {
}

type Jpipe struct {
}

type KSerializer struct {
}

type Lambda struct {
}

type Lazy struct {
}

type Left struct {
}

type Let struct {
}

type List struct {
}

type LocalDate struct {
}

type Locale struct {
}

type Lock struct {
}

type Long struct {
}

type LongNode struct {
}

type Map struct {
}

type MapEntry struct {
}

type MarshalJSON struct {
}

type MetadataPropertyHandling struct {
}

type Module struct {
}

type Mutable struct {
}

type Mutating struct {
}

type NSError struct {
}

type NSObject struct {
}

type NSString struct {
}

type Namespace struct {
}

type Native struct {
}

type New struct {
}

type Newtonsoft struct {
}

type Nil struct {
}

type No struct {
}

type NoSuchMethod struct {
}

type Noexcept struct {
}

type Nonatomic struct {
}

type None struct {
}

type Nonlocal struct {
}

type Nonmutating struct {
}

type Not struct {
}

type NotEq struct {
}

type Null struct {
}

type NullNode struct {
}

type Nullptr struct {
}

type Number struct {
}

type Object struct {
}

type ObjectMapper struct {
}

type ObjectNode struct {
}

type ObjectReader struct {
}

type ObjectWriter struct {
}

type Of struct {
}

type OffsetDateTime struct {
}

type OffsetTime struct {
}

type Oneway struct {
}

type Open struct {
}

type Operator struct {
}

type Optional struct {
}

type Or struct {
}

type OrEq struct {
}

type Out struct {
}

type Override struct {
}

type Package struct {
}

type Params struct {
}

type Pass struct {
}

type Port struct {
}

type Postfix struct {
}

type Precedence struct {
}

type Prefix struct {
}

type PrimitiveKind struct {
}

type Print struct {
}

type PrintMembers struct {
}

type Printf struct {
}

type Private struct {
}

type Protected struct {
}

type Protocol struct {
}

type Public struct {
}

type UnionBoolBool struct {
}

type Quicktype struct {
}

type Raise struct {
}

type Range struct {
}

type Readonly struct {
}

type Ref struct {
}

type RegExp struct {
}

type Register struct {
}

type ReinterpretCast struct {
}

type Repeat struct {
}

type Require struct {
}

type Required struct {
}

type Requires struct {
}

type Restrict struct {
}

type Retain struct {
}

type Rethrows struct {
}

type Return struct {
}

type Right struct {
}

type RuntimeType struct {
}

type S struct {
}

type Sbyte struct {
}

type Sealed struct {
}

type Sel struct {
}

type Select struct {
}

type Self struct {
}

type Sendable struct {
}

type SerialDescriptor struct {
}

type SerialName struct {
}

type Serializable struct {
}

type SerializationFeature struct {
}

type Serialize struct {
}

type SerializerProvider struct {
}

type Set struct {
}

type Short struct {
}

type Signed struct {
}

type SimpleModule struct {
}

type Sizeof struct {
}

type Stackalloc struct {
}

type Standards struct {
}

type Static struct {
}

type StaticAssert struct {
}

type StaticCast struct {
}

type StdDeserializer struct {
}

type StdSerializer struct {
}

type Strictfp struct {
}

type String struct {
}

type Struct struct {
}

type Subscript struct {
}

type Super struct {
}

type Switch struct {
}

type Symbol struct {
}

type Synchronized struct {
}

type System struct {
}

type Template struct {
}

type TextNode struct {
}

type Then struct {
}

type This struct {
}

type ThreadLocal struct {
}

type Throw struct {
}

type Throws struct {
}

type TimeOnly struct {
}

type TimeOnlyConverter struct {
}

type TimeZone struct {
}

type ToDict struct {
}

type ToJSON struct {
}

type ToString struct {
}

type TopLevelClass struct {
}

type AnyClass struct {
}

type BoolClass struct {
}

type ClassClass struct {
}

type FalseClass struct {
}

type NoneClass struct {
}

type NullClass struct {
}

type ProtocolClass struct {
}

type SelfClass struct {
}

type TrueClass struct {
}

type TypeClass struct {
}

type Transient struct {
}

type True struct {
}

type Try struct {
}

type Type struct {
}

type Typealias struct {
}

type Typedef struct {
}

type Typeid struct {
}

type Typename struct {
}

type Typeof struct {
}

type UUID struct {
}

type Uint struct {
}

type Ulong struct {
}

type Unchecked struct {
}

type Undefined struct {
}

type Union struct {
}

type UnmarshalJSON struct {
}

type Unowned struct {
}

type Unsafe struct {
}

type Unsigned struct {
}

type UseSerializers struct {
}

type Ushort struct {
}

type Using struct {
}

type Utf8JSONReader struct {
}

type Utf8JSONWriter struct {
}

type Var struct {
}

type Virtual struct {
}

type Void struct {
}

type Volatile struct {
}

type WcharT struct {
}

type Weak struct {
}

type Where struct {
}

type While struct {
}

type WillSet struct {
}

type With struct {
}

type Xor struct {
}

type XorEq struct {
}

type Yes struct {
}

type Yield struct {
}

type UnionASM struct {
	ASM    *ASM
	Double *float64
}

func (x *UnionASM) UnmarshalJSON(data []byte) error {
	x.ASM = nil
	var c ASM
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ASM = &c
	}
	return nil
}

func (x *UnionASM) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ASM != nil, x.ASM, false, nil, false, nil, false)
}

type UnionAbstract struct {
	Abstract *Abstract
	Double   *float64
}

func (x *UnionAbstract) UnmarshalJSON(data []byte) error {
	x.Abstract = nil
	var c Abstract
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Abstract = &c
	}
	return nil
}

func (x *UnionAbstract) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Abstract != nil, x.Abstract, false, nil, false, nil, false)
}

type UnionAlignas struct {
	Alignas *Alignas
	Double  *float64
}

func (x *UnionAlignas) UnmarshalJSON(data []byte) error {
	x.Alignas = nil
	var c Alignas
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Alignas = &c
	}
	return nil
}

func (x *UnionAlignas) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Alignas != nil, x.Alignas, false, nil, false, nil, false)
}

type UnionAlignof struct {
	Alignof *Alignof
	Double  *float64
}

func (x *UnionAlignof) UnmarshalJSON(data []byte) error {
	x.Alignof = nil
	var c Alignof
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Alignof = &c
	}
	return nil
}

func (x *UnionAlignof) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Alignof != nil, x.Alignof, false, nil, false, nil, false)
}

type UnionAnd struct {
	And    *And
	Double *float64
}

func (x *UnionAnd) UnmarshalJSON(data []byte) error {
	x.And = nil
	var c And
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.And = &c
	}
	return nil
}

func (x *UnionAnd) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.And != nil, x.And, false, nil, false, nil, false)
}

type UnionAndEq struct {
	AndEq  *AndEq
	Double *float64
}

func (x *UnionAndEq) UnmarshalJSON(data []byte) error {
	x.AndEq = nil
	var c AndEq
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AndEq = &c
	}
	return nil
}

func (x *UnionAndEq) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.AndEq != nil, x.AndEq, false, nil, false, nil, false)
}

type UnionAny struct {
	Any    *Any
	Double *float64
}

func (x *UnionAny) UnmarshalJSON(data []byte) error {
	x.Any = nil
	var c Any
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Any = &c
	}
	return nil
}

func (x *UnionAny) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Any != nil, x.Any, false, nil, false, nil, false)
}

type UnionArray struct {
	Array  *Array
	Double *float64
}

func (x *UnionArray) UnmarshalJSON(data []byte) error {
	x.Array = nil
	var c Array
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Array = &c
	}
	return nil
}

func (x *UnionArray) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Array != nil, x.Array, false, nil, false, nil, false)
}

type UnionArrayNode struct {
	ArrayNode *ArrayNode
	Double    *float64
}

func (x *UnionArrayNode) UnmarshalJSON(data []byte) error {
	x.ArrayNode = nil
	var c ArrayNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ArrayNode = &c
	}
	return nil
}

func (x *UnionArrayNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ArrayNode != nil, x.ArrayNode, false, nil, false, nil, false)
}

type UnionAs struct {
	As     *As
	Double *float64
}

func (x *UnionAs) UnmarshalJSON(data []byte) error {
	x.As = nil
	var c As
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.As = &c
	}
	return nil
}

func (x *UnionAs) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.As != nil, x.As, false, nil, false, nil, false)
}

type UnionAssert struct {
	Assert *Assert
	Double *float64
}

func (x *UnionAssert) UnmarshalJSON(data []byte) error {
	x.Assert = nil
	var c Assert
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Assert = &c
	}
	return nil
}

func (x *UnionAssert) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Assert != nil, x.Assert, false, nil, false, nil, false)
}

type UnionAssociatedtype struct {
	Associatedtype *Associatedtype
	Double         *float64
}

func (x *UnionAssociatedtype) UnmarshalJSON(data []byte) error {
	x.Associatedtype = nil
	var c Associatedtype
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Associatedtype = &c
	}
	return nil
}

func (x *UnionAssociatedtype) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Associatedtype != nil, x.Associatedtype, false, nil, false, nil, false)
}

type UnionAssociativity struct {
	Associativity *Associativity
	Double        *float64
}

func (x *UnionAssociativity) UnmarshalJSON(data []byte) error {
	x.Associativity = nil
	var c Associativity
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Associativity = &c
	}
	return nil
}

func (x *UnionAssociativity) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Associativity != nil, x.Associativity, false, nil, false, nil, false)
}

type UnionAsync struct {
	Async  *Async
	Double *float64
}

func (x *UnionAsync) UnmarshalJSON(data []byte) error {
	x.Async = nil
	var c Async
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Async = &c
	}
	return nil
}

func (x *UnionAsync) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Async != nil, x.Async, false, nil, false, nil, false)
}

type UnionAtomic struct {
	Atomic *Atomic
	Double *float64
}

func (x *UnionAtomic) UnmarshalJSON(data []byte) error {
	x.Atomic = nil
	var c Atomic
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Atomic = &c
	}
	return nil
}

func (x *UnionAtomic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Atomic != nil, x.Atomic, false, nil, false, nil, false)
}

type UnionAtomicCancel struct {
	AtomicCancel *AtomicCancel
	Double       *float64
}

func (x *UnionAtomicCancel) UnmarshalJSON(data []byte) error {
	x.AtomicCancel = nil
	var c AtomicCancel
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AtomicCancel = &c
	}
	return nil
}

func (x *UnionAtomicCancel) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.AtomicCancel != nil, x.AtomicCancel, false, nil, false, nil, false)
}

type UnionAtomicCommit struct {
	AtomicCommit *AtomicCommit
	Double       *float64
}

func (x *UnionAtomicCommit) UnmarshalJSON(data []byte) error {
	x.AtomicCommit = nil
	var c AtomicCommit
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AtomicCommit = &c
	}
	return nil
}

func (x *UnionAtomicCommit) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.AtomicCommit != nil, x.AtomicCommit, false, nil, false, nil, false)
}

type UnionAtomicNoexcept struct {
	AtomicNoexcept *AtomicNoexcept
	Double         *float64
}

func (x *UnionAtomicNoexcept) UnmarshalJSON(data []byte) error {
	x.AtomicNoexcept = nil
	var c AtomicNoexcept
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AtomicNoexcept = &c
	}
	return nil
}

func (x *UnionAtomicNoexcept) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.AtomicNoexcept != nil, x.AtomicNoexcept, false, nil, false, nil, false)
}

type UnionAuto struct {
	Auto   *Auto
	Double *float64
}

func (x *UnionAuto) UnmarshalJSON(data []byte) error {
	x.Auto = nil
	var c Auto
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Auto = &c
	}
	return nil
}

func (x *UnionAuto) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Auto != nil, x.Auto, false, nil, false, nil, false)
}

type UnionAwait struct {
	Await  *Await
	Double *float64
}

func (x *UnionAwait) UnmarshalJSON(data []byte) error {
	x.Await = nil
	var c Await
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Await = &c
	}
	return nil
}

func (x *UnionAwait) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Await != nil, x.Await, false, nil, false, nil, false)
}

type UnionBase struct {
	Base   *Base
	Double *float64
}

func (x *UnionBase) UnmarshalJSON(data []byte) error {
	x.Base = nil
	var c Base
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Base = &c
	}
	return nil
}

func (x *UnionBase) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Base != nil, x.Base, false, nil, false, nil, false)
}

type UnionBitand struct {
	Bitand *Bitand
	Double *float64
}

func (x *UnionBitand) UnmarshalJSON(data []byte) error {
	x.Bitand = nil
	var c Bitand
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Bitand = &c
	}
	return nil
}

func (x *UnionBitand) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Bitand != nil, x.Bitand, false, nil, false, nil, false)
}

type UnionBitor struct {
	Bitor  *Bitor
	Double *float64
}

func (x *UnionBitor) UnmarshalJSON(data []byte) error {
	x.Bitor = nil
	var c Bitor
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Bitor = &c
	}
	return nil
}

func (x *UnionBitor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Bitor != nil, x.Bitor, false, nil, false, nil, false)
}

type UnionBOOL struct {
	Bool   *Bool
	Double *float64
}

func (x *UnionBOOL) UnmarshalJSON(data []byte) error {
	x.Bool = nil
	var c Bool
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Bool = &c
	}
	return nil
}

func (x *UnionBOOL) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Bool != nil, x.Bool, false, nil, false, nil, false)
}

type UnionBoolean struct {
	Boolean *Boolean
	Double  *float64
}

func (x *UnionBoolean) UnmarshalJSON(data []byte) error {
	x.Boolean = nil
	var c Boolean
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Boolean = &c
	}
	return nil
}

func (x *UnionBoolean) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Boolean != nil, x.Boolean, false, nil, false, nil, false)
}

type UnionBooleanNode struct {
	BooleanNode *BooleanNode
	Double      *float64
}

func (x *UnionBooleanNode) UnmarshalJSON(data []byte) error {
	x.BooleanNode = nil
	var c BooleanNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.BooleanNode = &c
	}
	return nil
}

func (x *UnionBooleanNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.BooleanNode != nil, x.BooleanNode, false, nil, false, nil, false)
}

type UnionBreak struct {
	Break  *Break
	Double *float64
}

func (x *UnionBreak) UnmarshalJSON(data []byte) error {
	x.Break = nil
	var c Break
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Break = &c
	}
	return nil
}

func (x *UnionBreak) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Break != nil, x.Break, false, nil, false, nil, false)
}

type UnionBycopy struct {
	Bycopy *Bycopy
	Double *float64
}

func (x *UnionBycopy) UnmarshalJSON(data []byte) error {
	x.Bycopy = nil
	var c Bycopy
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Bycopy = &c
	}
	return nil
}

func (x *UnionBycopy) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Bycopy != nil, x.Bycopy, false, nil, false, nil, false)
}

type UnionByref struct {
	Byref  *Byref
	Double *float64
}

func (x *UnionByref) UnmarshalJSON(data []byte) error {
	x.Byref = nil
	var c Byref
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Byref = &c
	}
	return nil
}

func (x *UnionByref) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Byref != nil, x.Byref, false, nil, false, nil, false)
}

type UnionByte struct {
	Byte   *Byte
	Double *float64
}

func (x *UnionByte) UnmarshalJSON(data []byte) error {
	x.Byte = nil
	var c Byte
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Byte = &c
	}
	return nil
}

func (x *UnionByte) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Byte != nil, x.Byte, false, nil, false, nil, false)
}

type UnionCalendar struct {
	Calendar *Calendar
	Double   *float64
}

func (x *UnionCalendar) UnmarshalJSON(data []byte) error {
	x.Calendar = nil
	var c Calendar
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Calendar = &c
	}
	return nil
}

func (x *UnionCalendar) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Calendar != nil, x.Calendar, false, nil, false, nil, false)
}

type UnionCase struct {
	Case   *Case
	Double *float64
}

func (x *UnionCase) UnmarshalJSON(data []byte) error {
	x.Case = nil
	var c Case
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Case = &c
	}
	return nil
}

func (x *UnionCase) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Case != nil, x.Case, false, nil, false, nil, false)
}

type UnionCatch struct {
	Catch  *Catch
	Double *float64
}

func (x *UnionCatch) UnmarshalJSON(data []byte) error {
	x.Catch = nil
	var c Catch
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Catch = &c
	}
	return nil
}

func (x *UnionCatch) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Catch != nil, x.Catch, false, nil, false, nil, false)
}

type UnionChan struct {
	Chan   *Chan
	Double *float64
}

func (x *UnionChan) UnmarshalJSON(data []byte) error {
	x.Chan = nil
	var c Chan
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Chan = &c
	}
	return nil
}

func (x *UnionChan) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Chan != nil, x.Chan, false, nil, false, nil, false)
}

type UnionChar struct {
	Char   *Char
	Double *float64
}

func (x *UnionChar) UnmarshalJSON(data []byte) error {
	x.Char = nil
	var c Char
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Char = &c
	}
	return nil
}

func (x *UnionChar) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Char != nil, x.Char, false, nil, false, nil, false)
}

type UnionChar16T struct {
	Char16T *Char16T
	Double  *float64
}

func (x *UnionChar16T) UnmarshalJSON(data []byte) error {
	x.Char16T = nil
	var c Char16T
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Char16T = &c
	}
	return nil
}

func (x *UnionChar16T) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Char16T != nil, x.Char16T, false, nil, false, nil, false)
}

type UnionChar32T struct {
	Char32T *Char32T
	Double  *float64
}

func (x *UnionChar32T) UnmarshalJSON(data []byte) error {
	x.Char32T = nil
	var c Char32T
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Char32T = &c
	}
	return nil
}

func (x *UnionChar32T) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Char32T != nil, x.Char32T, false, nil, false, nil, false)
}

type UnionChecked struct {
	Checked *Checked
	Double  *float64
}

func (x *UnionChecked) UnmarshalJSON(data []byte) error {
	x.Checked = nil
	var c Checked
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Checked = &c
	}
	return nil
}

func (x *UnionChecked) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Checked != nil, x.Checked, false, nil, false, nil, false)
}

type UnionClass struct {
	Class  *Class
	Double *float64
}

func (x *UnionClass) UnmarshalJSON(data []byte) error {
	x.Class = nil
	var c Class
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Class = &c
	}
	return nil
}

func (x *UnionClass) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Class != nil, x.Class, false, nil, false, nil, false)
}

type UnionClone struct {
	Clone  *Clone
	Double *float64
}

func (x *UnionClone) UnmarshalJSON(data []byte) error {
	x.Clone = nil
	var c Clone
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Clone = &c
	}
	return nil
}

func (x *UnionClone) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Clone != nil, x.Clone, false, nil, false, nil, false)
}

type UnionCoAwait struct {
	CoAwait *CoAwait
	Double  *float64
}

func (x *UnionCoAwait) UnmarshalJSON(data []byte) error {
	x.CoAwait = nil
	var c CoAwait
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CoAwait = &c
	}
	return nil
}

func (x *UnionCoAwait) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CoAwait != nil, x.CoAwait, false, nil, false, nil, false)
}

type UnionCoReturn struct {
	CoReturn *CoReturn
	Double   *float64
}

func (x *UnionCoReturn) UnmarshalJSON(data []byte) error {
	x.CoReturn = nil
	var c CoReturn
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CoReturn = &c
	}
	return nil
}

func (x *UnionCoReturn) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CoReturn != nil, x.CoReturn, false, nil, false, nil, false)
}

type UnionCoYield struct {
	CoYield *CoYield
	Double  *float64
}

func (x *UnionCoYield) UnmarshalJSON(data []byte) error {
	x.CoYield = nil
	var c CoYield
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CoYield = &c
	}
	return nil
}

func (x *UnionCoYield) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CoYield != nil, x.CoYield, false, nil, false, nil, false)
}

type UnionCodable struct {
	Codable *Codable
	Double  *float64
}

func (x *UnionCodable) UnmarshalJSON(data []byte) error {
	x.Codable = nil
	var c Codable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Codable = &c
	}
	return nil
}

func (x *UnionCodable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Codable != nil, x.Codable, false, nil, false, nil, false)
}

type UnionCodingKey struct {
	CodingKey *CodingKey
	Double    *float64
}

func (x *UnionCodingKey) UnmarshalJSON(data []byte) error {
	x.CodingKey = nil
	var c CodingKey
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CodingKey = &c
	}
	return nil
}

func (x *UnionCodingKey) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CodingKey != nil, x.CodingKey, false, nil, false, nil, false)
}

type UnionCodingKeys struct {
	CodingKeys *CodingKeys
	Double     *float64
}

func (x *UnionCodingKeys) UnmarshalJSON(data []byte) error {
	x.CodingKeys = nil
	var c CodingKeys
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CodingKeys = &c
	}
	return nil
}

func (x *UnionCodingKeys) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CodingKeys != nil, x.CodingKeys, false, nil, false, nil, false)
}

type UnionCompl struct {
	Compl  *Compl
	Double *float64
}

func (x *UnionCompl) UnmarshalJSON(data []byte) error {
	x.Compl = nil
	var c Compl
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Compl = &c
	}
	return nil
}

func (x *UnionCompl) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Compl != nil, x.Compl, false, nil, false, nil, false)
}

type UnionComplex struct {
	Complex *Complex
	Double  *float64
}

func (x *UnionComplex) UnmarshalJSON(data []byte) error {
	x.Complex = nil
	var c Complex
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Complex = &c
	}
	return nil
}

func (x *UnionComplex) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Complex != nil, x.Complex, false, nil, false, nil, false)
}

type UnionConcept struct {
	Concept *Concept
	Double  *float64
}

func (x *UnionConcept) UnmarshalJSON(data []byte) error {
	x.Concept = nil
	var c Concept
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Concept = &c
	}
	return nil
}

func (x *UnionConcept) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Concept != nil, x.Concept, false, nil, false, nil, false)
}

type UnionConsole struct {
	Console *Console
	Double  *float64
}

func (x *UnionConsole) UnmarshalJSON(data []byte) error {
	x.Console = nil
	var c Console
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Console = &c
	}
	return nil
}

func (x *UnionConsole) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Console != nil, x.Console, false, nil, false, nil, false)
}

type UnionConst struct {
	Const  *Const
	Double *float64
}

func (x *UnionConst) UnmarshalJSON(data []byte) error {
	x.Const = nil
	var c Const
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Const = &c
	}
	return nil
}

func (x *UnionConst) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Const != nil, x.Const, false, nil, false, nil, false)
}

type UnionConstCast struct {
	ConstCast *ConstCast
	Double    *float64
}

func (x *UnionConstCast) UnmarshalJSON(data []byte) error {
	x.ConstCast = nil
	var c ConstCast
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ConstCast = &c
	}
	return nil
}

func (x *UnionConstCast) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ConstCast != nil, x.ConstCast, false, nil, false, nil, false)
}

type UnionConstexpr struct {
	Constexpr *Constexpr
	Double    *float64
}

func (x *UnionConstexpr) UnmarshalJSON(data []byte) error {
	x.Constexpr = nil
	var c Constexpr
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Constexpr = &c
	}
	return nil
}

func (x *UnionConstexpr) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Constexpr != nil, x.Constexpr, false, nil, false, nil, false)
}

type UnionConstructor struct {
	Constructor *Constructor
	Double      *float64
}

func (x *UnionConstructor) UnmarshalJSON(data []byte) error {
	x.Constructor = nil
	var c Constructor
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Constructor = &c
	}
	return nil
}

func (x *UnionConstructor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Constructor != nil, x.Constructor, false, nil, false, nil, false)
}

type UnionContinue struct {
	Continue *Continue
	Double   *float64
}

func (x *UnionContinue) UnmarshalJSON(data []byte) error {
	x.Continue = nil
	var c Continue
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Continue = &c
	}
	return nil
}

func (x *UnionContinue) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Continue != nil, x.Continue, false, nil, false, nil, false)
}

type UnionConvenience struct {
	Convenience *Convenience
	Double      *float64
}

func (x *UnionConvenience) UnmarshalJSON(data []byte) error {
	x.Convenience = nil
	var c Convenience
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Convenience = &c
	}
	return nil
}

func (x *UnionConvenience) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Convenience != nil, x.Convenience, false, nil, false, nil, false)
}

type UnionConvert struct {
	Convert *Convert
	Double  *float64
}

func (x *UnionConvert) UnmarshalJSON(data []byte) error {
	x.Convert = nil
	var c Convert
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Convert = &c
	}
	return nil
}

func (x *UnionConvert) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Convert != nil, x.Convert, false, nil, false, nil, false)
}

type UnionConverter struct {
	Converter *Converter
	Double    *float64
}

func (x *UnionConverter) UnmarshalJSON(data []byte) error {
	x.Converter = nil
	var c Converter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Converter = &c
	}
	return nil
}

func (x *UnionConverter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Converter != nil, x.Converter, false, nil, false, nil, false)
}

type UnionCultureInfo struct {
	CultureInfo *CultureInfo
	Double      *float64
}

func (x *UnionCultureInfo) UnmarshalJSON(data []byte) error {
	x.CultureInfo = nil
	var c CultureInfo
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.CultureInfo = &c
	}
	return nil
}

func (x *UnionCultureInfo) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.CultureInfo != nil, x.CultureInfo, false, nil, false, nil, false)
}

type UnionDate struct {
	Date   *Date
	Double *float64
}

func (x *UnionDate) UnmarshalJSON(data []byte) error {
	x.Date = nil
	var c Date
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Date = &c
	}
	return nil
}

func (x *UnionDate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Date != nil, x.Date, false, nil, false, nil, false)
}

type UnionDateFormatter struct {
	DateFormatter *DateFormatter
	Double        *float64
}

func (x *UnionDateFormatter) UnmarshalJSON(data []byte) error {
	x.DateFormatter = nil
	var c DateFormatter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateFormatter = &c
	}
	return nil
}

func (x *UnionDateFormatter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateFormatter != nil, x.DateFormatter, false, nil, false, nil, false)
}

type UnionDateOnly struct {
	DateOnly *DateOnly
	Double   *float64
}

func (x *UnionDateOnly) UnmarshalJSON(data []byte) error {
	x.DateOnly = nil
	var c DateOnly
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateOnly = &c
	}
	return nil
}

func (x *UnionDateOnly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateOnly != nil, x.DateOnly, false, nil, false, nil, false)
}

type UnionDateOnlyConverter struct {
	DateOnlyConverter *DateOnlyConverter
	Double            *float64
}

func (x *UnionDateOnlyConverter) UnmarshalJSON(data []byte) error {
	x.DateOnlyConverter = nil
	var c DateOnlyConverter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateOnlyConverter = &c
	}
	return nil
}

func (x *UnionDateOnlyConverter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateOnlyConverter != nil, x.DateOnlyConverter, false, nil, false, nil, false)
}

type UnionDateParseHandling struct {
	DateParseHandling *DateParseHandling
	Double            *float64
}

func (x *UnionDateParseHandling) UnmarshalJSON(data []byte) error {
	x.DateParseHandling = nil
	var c DateParseHandling
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateParseHandling = &c
	}
	return nil
}

func (x *UnionDateParseHandling) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateParseHandling != nil, x.DateParseHandling, false, nil, false, nil, false)
}

type UnionDateTime struct {
	DateTime *DateTime
	Double   *float64
}

func (x *UnionDateTime) UnmarshalJSON(data []byte) error {
	x.DateTime = nil
	var c DateTime
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateTime = &c
	}
	return nil
}

func (x *UnionDateTime) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateTime != nil, x.DateTime, false, nil, false, nil, false)
}

type UnionDateTimeStyles struct {
	DateTimeStyles *DateTimeStyles
	Double         *float64
}

func (x *UnionDateTimeStyles) UnmarshalJSON(data []byte) error {
	x.DateTimeStyles = nil
	var c DateTimeStyles
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DateTimeStyles = &c
	}
	return nil
}

func (x *UnionDateTimeStyles) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DateTimeStyles != nil, x.DateTimeStyles, false, nil, false, nil, false)
}

type UnionDebugger struct {
	Debugger *Debugger
	Double   *float64
}

func (x *UnionDebugger) UnmarshalJSON(data []byte) error {
	x.Debugger = nil
	var c Debugger
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Debugger = &c
	}
	return nil
}

func (x *UnionDebugger) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Debugger != nil, x.Debugger, false, nil, false, nil, false)
}

type UnionDecimal struct {
	Decimal *Decimal
	Double  *float64
}

func (x *UnionDecimal) UnmarshalJSON(data []byte) error {
	x.Decimal = nil
	var c Decimal
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Decimal = &c
	}
	return nil
}

func (x *UnionDecimal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Decimal != nil, x.Decimal, false, nil, false, nil, false)
}

type UnionDeclare struct {
	Declare *Declare
	Double  *float64
}

func (x *UnionDeclare) UnmarshalJSON(data []byte) error {
	x.Declare = nil
	var c Declare
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Declare = &c
	}
	return nil
}

func (x *UnionDeclare) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Declare != nil, x.Declare, false, nil, false, nil, false)
}

type UnionDecltype struct {
	Decltype *Decltype
	Double   *float64
}

func (x *UnionDecltype) UnmarshalJSON(data []byte) error {
	x.Decltype = nil
	var c Decltype
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Decltype = &c
	}
	return nil
}

func (x *UnionDecltype) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Decltype != nil, x.Decltype, false, nil, false, nil, false)
}

type UnionDecodeString struct {
	DecodeString *DecodeString
	Double       *float64
}

func (x *UnionDecodeString) UnmarshalJSON(data []byte) error {
	x.DecodeString = nil
	var c DecodeString
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DecodeString = &c
	}
	return nil
}

func (x *UnionDecodeString) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DecodeString != nil, x.DecodeString, false, nil, false, nil, false)
}

type UnionDecoder struct {
	Decoder *Decoder
	Double  *float64
}

func (x *UnionDecoder) UnmarshalJSON(data []byte) error {
	x.Decoder = nil
	var c Decoder
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Decoder = &c
	}
	return nil
}

func (x *UnionDecoder) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Decoder != nil, x.Decoder, false, nil, false, nil, false)
}

type UnionDecodingError struct {
	DecodingError *DecodingError
	Double        *float64
}

func (x *UnionDecodingError) UnmarshalJSON(data []byte) error {
	x.DecodingError = nil
	var c DecodingError
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DecodingError = &c
	}
	return nil
}

func (x *UnionDecodingError) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DecodingError != nil, x.DecodingError, false, nil, false, nil, false)
}

type UnionDef struct {
	Def    *Def
	Double *float64
}

func (x *UnionDef) UnmarshalJSON(data []byte) error {
	x.Def = nil
	var c Def
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Def = &c
	}
	return nil
}

func (x *UnionDef) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Def != nil, x.Def, false, nil, false, nil, false)
}

type UnionDefault struct {
	Default *Default
	Double  *float64
}

func (x *UnionDefault) UnmarshalJSON(data []byte) error {
	x.Default = nil
	var c Default
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Default = &c
	}
	return nil
}

func (x *UnionDefault) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Default != nil, x.Default, false, nil, false, nil, false)
}

type UnionDefer struct {
	Defer  *Defer
	Double *float64
}

func (x *UnionDefer) UnmarshalJSON(data []byte) error {
	x.Defer = nil
	var c Defer
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Defer = &c
	}
	return nil
}

func (x *UnionDefer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Defer != nil, x.Defer, false, nil, false, nil, false)
}

type UnionDeinit struct {
	Deinit *Deinit
	Double *float64
}

func (x *UnionDeinit) UnmarshalJSON(data []byte) error {
	x.Deinit = nil
	var c Deinit
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Deinit = &c
	}
	return nil
}

func (x *UnionDeinit) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Deinit != nil, x.Deinit, false, nil, false, nil, false)
}

type UnionDel struct {
	Del    *Del
	Double *float64
}

func (x *UnionDel) UnmarshalJSON(data []byte) error {
	x.Del = nil
	var c Del
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Del = &c
	}
	return nil
}

func (x *UnionDel) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Del != nil, x.Del, false, nil, false, nil, false)
}

type UnionDelegate struct {
	Delegate *Delegate
	Double   *float64
}

func (x *UnionDelegate) UnmarshalJSON(data []byte) error {
	x.Delegate = nil
	var c Delegate
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Delegate = &c
	}
	return nil
}

func (x *UnionDelegate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Delegate != nil, x.Delegate, false, nil, false, nil, false)
}

type UnionDelete struct {
	Delete *Delete
	Double *float64
}

func (x *UnionDelete) UnmarshalJSON(data []byte) error {
	x.Delete = nil
	var c Delete
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Delete = &c
	}
	return nil
}

func (x *UnionDelete) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Delete != nil, x.Delete, false, nil, false, nil, false)
}

type UnionDeserializationFeature struct {
	DeserializationFeature *DeserializationFeature
	Double                 *float64
}

func (x *UnionDeserializationFeature) UnmarshalJSON(data []byte) error {
	x.DeserializationFeature = nil
	var c DeserializationFeature
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DeserializationFeature = &c
	}
	return nil
}

func (x *UnionDeserializationFeature) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DeserializationFeature != nil, x.DeserializationFeature, false, nil, false, nil, false)
}

type UnionDict struct {
	Dict   *Dict
	Double *float64
}

func (x *UnionDict) UnmarshalJSON(data []byte) error {
	x.Dict = nil
	var c Dict
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Dict = &c
	}
	return nil
}

func (x *UnionDict) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Dict != nil, x.Dict, false, nil, false, nil, false)
}

type UnionDictionary struct {
	Dictionary *Dictionary
	Double     *float64
}

func (x *UnionDictionary) UnmarshalJSON(data []byte) error {
	x.Dictionary = nil
	var c Dictionary
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Dictionary = &c
	}
	return nil
}

func (x *UnionDictionary) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Dictionary != nil, x.Dictionary, false, nil, false, nil, false)
}

type UnionDidSet struct {
	DidSet *DidSet
	Double *float64
}

func (x *UnionDidSet) UnmarshalJSON(data []byte) error {
	x.DidSet = nil
	var c DidSet
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DidSet = &c
	}
	return nil
}

func (x *UnionDidSet) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DidSet != nil, x.DidSet, false, nil, false, nil, false)
}

type UnionDo struct {
	Do     *Do
	Double *float64
}

func (x *UnionDo) UnmarshalJSON(data []byte) error {
	x.Do = nil
	var c Do
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Do = &c
	}
	return nil
}

func (x *UnionDo) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Do != nil, x.Do, false, nil, false, nil, false)
}

type UnionDouble struct {
	Double       *float64
	PurpleDouble *Double
}

func (x *UnionDouble) UnmarshalJSON(data []byte) error {
	x.PurpleDouble = nil
	var c Double
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PurpleDouble = &c
	}
	return nil
}

func (x *UnionDouble) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PurpleDouble != nil, x.PurpleDouble, false, nil, false, nil, false)
}

type UnionDoubleNode struct {
	Double     *float64
	DoubleNode *DoubleNode
}

func (x *UnionDoubleNode) UnmarshalJSON(data []byte) error {
	x.DoubleNode = nil
	var c DoubleNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DoubleNode = &c
	}
	return nil
}

func (x *UnionDoubleNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DoubleNode != nil, x.DoubleNode, false, nil, false, nil, false)
}

type UnionDynamic struct {
	Double  *float64
	Dynamic *Dynamic
}

func (x *UnionDynamic) UnmarshalJSON(data []byte) error {
	x.Dynamic = nil
	var c Dynamic
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Dynamic = &c
	}
	return nil
}

func (x *UnionDynamic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Dynamic != nil, x.Dynamic, false, nil, false, nil, false)
}

type UnionDynamicCast struct {
	Double      *float64
	DynamicCast *DynamicCast
}

func (x *UnionDynamicCast) UnmarshalJSON(data []byte) error {
	x.DynamicCast = nil
	var c DynamicCast
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DynamicCast = &c
	}
	return nil
}

func (x *UnionDynamicCast) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.DynamicCast != nil, x.DynamicCast, false, nil, false, nil, false)
}

type UnionElif struct {
	Double *float64
	Elif   *Elif
}

func (x *UnionElif) UnmarshalJSON(data []byte) error {
	x.Elif = nil
	var c Elif
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Elif = &c
	}
	return nil
}

func (x *UnionElif) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Elif != nil, x.Elif, false, nil, false, nil, false)
}

type UnionElse struct {
	Double *float64
	Else   *Else
}

func (x *UnionElse) UnmarshalJSON(data []byte) error {
	x.Else = nil
	var c Else
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Else = &c
	}
	return nil
}

func (x *UnionElse) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Else != nil, x.Else, false, nil, false, nil, false)
}

type UnionUnion struct {
	Double *float64
	Empty  *Empty
}

func (x *UnionUnion) UnmarshalJSON(data []byte) error {
	x.Empty = nil
	var c Empty
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Empty = &c
	}
	return nil
}

func (x *UnionUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Empty != nil, x.Empty, false, nil, false, nil, false)
}

type UnionEncodeQuickType struct {
	Double          *float64
	EncodeQuickType *EncodeQuickType
}

func (x *UnionEncodeQuickType) UnmarshalJSON(data []byte) error {
	x.EncodeQuickType = nil
	var c EncodeQuickType
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.EncodeQuickType = &c
	}
	return nil
}

func (x *UnionEncodeQuickType) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.EncodeQuickType != nil, x.EncodeQuickType, false, nil, false, nil, false)
}

type UnionEncoder struct {
	Double  *float64
	Encoder *Encoder
}

func (x *UnionEncoder) UnmarshalJSON(data []byte) error {
	x.Encoder = nil
	var c Encoder
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Encoder = &c
	}
	return nil
}

func (x *UnionEncoder) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Encoder != nil, x.Encoder, false, nil, false, nil, false)
}

type UnionEnum struct {
	Double *float64
	Enum   *Enum
}

func (x *UnionEnum) UnmarshalJSON(data []byte) error {
	x.Enum = nil
	var c Enum
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Enum = &c
	}
	return nil
}

func (x *UnionEnum) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Enum != nil, x.Enum, false, nil, false, nil, false)
}

type UnionEnumValues struct {
	Double     *float64
	EnumValues *EnumValues
}

func (x *UnionEnumValues) UnmarshalJSON(data []byte) error {
	x.EnumValues = nil
	var c EnumValues
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.EnumValues = &c
	}
	return nil
}

func (x *UnionEnumValues) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.EnumValues != nil, x.EnumValues, false, nil, false, nil, false)
}

type UnionEqualityContract struct {
	Double           *float64
	EqualityContract *EqualityContract
}

func (x *UnionEqualityContract) UnmarshalJSON(data []byte) error {
	x.EqualityContract = nil
	var c EqualityContract
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.EqualityContract = &c
	}
	return nil
}

func (x *UnionEqualityContract) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.EqualityContract != nil, x.EqualityContract, false, nil, false, nil, false)
}

type UnionEquatable struct {
	Double    *float64
	Equatable *Equatable
}

func (x *UnionEquatable) UnmarshalJSON(data []byte) error {
	x.Equatable = nil
	var c Equatable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Equatable = &c
	}
	return nil
}

func (x *UnionEquatable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Equatable != nil, x.Equatable, false, nil, false, nil, false)
}

type UnionEvent struct {
	Double *float64
	Event  *Event
}

func (x *UnionEvent) UnmarshalJSON(data []byte) error {
	x.Event = nil
	var c Event
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Event = &c
	}
	return nil
}

func (x *UnionEvent) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Event != nil, x.Event, false, nil, false, nil, false)
}

type UnionExcept struct {
	Double *float64
	Except *Except
}

func (x *UnionExcept) UnmarshalJSON(data []byte) error {
	x.Except = nil
	var c Except
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Except = &c
	}
	return nil
}

func (x *UnionExcept) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Except != nil, x.Except, false, nil, false, nil, false)
}

type UnionException struct {
	Double    *float64
	Exception *Exception
}

func (x *UnionException) UnmarshalJSON(data []byte) error {
	x.Exception = nil
	var c Exception
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Exception = &c
	}
	return nil
}

func (x *UnionException) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Exception != nil, x.Exception, false, nil, false, nil, false)
}

type UnionExplicit struct {
	Double   *float64
	Explicit *Explicit
}

func (x *UnionExplicit) UnmarshalJSON(data []byte) error {
	x.Explicit = nil
	var c Explicit
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Explicit = &c
	}
	return nil
}

func (x *UnionExplicit) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Explicit != nil, x.Explicit, false, nil, false, nil, false)
}

type UnionExport struct {
	Double *float64
	Export *Export
}

func (x *UnionExport) UnmarshalJSON(data []byte) error {
	x.Export = nil
	var c Export
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Export = &c
	}
	return nil
}

func (x *UnionExport) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Export != nil, x.Export, false, nil, false, nil, false)
}

type UnionExposing struct {
	Double   *float64
	Exposing *Exposing
}

func (x *UnionExposing) UnmarshalJSON(data []byte) error {
	x.Exposing = nil
	var c Exposing
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Exposing = &c
	}
	return nil
}

func (x *UnionExposing) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Exposing != nil, x.Exposing, false, nil, false, nil, false)
}

type UnionExtends struct {
	Double  *float64
	Extends *Extends
}

func (x *UnionExtends) UnmarshalJSON(data []byte) error {
	x.Extends = nil
	var c Extends
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Extends = &c
	}
	return nil
}

func (x *UnionExtends) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Extends != nil, x.Extends, false, nil, false, nil, false)
}

type UnionExtension struct {
	Double    *float64
	Extension *Extension
}

func (x *UnionExtension) UnmarshalJSON(data []byte) error {
	x.Extension = nil
	var c Extension
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Extension = &c
	}
	return nil
}

func (x *UnionExtension) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Extension != nil, x.Extension, false, nil, false, nil, false)
}

type UnionExtern struct {
	Double *float64
	Extern *Extern
}

func (x *UnionExtern) UnmarshalJSON(data []byte) error {
	x.Extern = nil
	var c Extern
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Extern = &c
	}
	return nil
}

func (x *UnionExtern) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Extern != nil, x.Extern, false, nil, false, nil, false)
}

type UnionFallthrough struct {
	Double      *float64
	Fallthrough *Fallthrough
}

func (x *UnionFallthrough) UnmarshalJSON(data []byte) error {
	x.Fallthrough = nil
	var c Fallthrough
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Fallthrough = &c
	}
	return nil
}

func (x *UnionFallthrough) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Fallthrough != nil, x.Fallthrough, false, nil, false, nil, false)
}

type UnionFalse struct {
	Double *float64
	False  *False
}

func (x *UnionFalse) UnmarshalJSON(data []byte) error {
	x.False = nil
	var c False
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.False = &c
	}
	return nil
}

func (x *UnionFalse) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.False != nil, x.False, false, nil, false, nil, false)
}

type UnionFileprivate struct {
	Double      *float64
	Fileprivate *Fileprivate
}

func (x *UnionFileprivate) UnmarshalJSON(data []byte) error {
	x.Fileprivate = nil
	var c Fileprivate
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Fileprivate = &c
	}
	return nil
}

func (x *UnionFileprivate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Fileprivate != nil, x.Fileprivate, false, nil, false, nil, false)
}

type UnionFinal struct {
	Double *float64
	Final  *Final
}

func (x *UnionFinal) UnmarshalJSON(data []byte) error {
	x.Final = nil
	var c Final
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Final = &c
	}
	return nil
}

func (x *UnionFinal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Final != nil, x.Final, false, nil, false, nil, false)
}

type UnionFinally struct {
	Double  *float64
	Finally *Finally
}

func (x *UnionFinally) UnmarshalJSON(data []byte) error {
	x.Finally = nil
	var c Finally
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Finally = &c
	}
	return nil
}

func (x *UnionFinally) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Finally != nil, x.Finally, false, nil, false, nil, false)
}

type UnionFixed struct {
	Double *float64
	Fixed  *Fixed
}

func (x *UnionFixed) UnmarshalJSON(data []byte) error {
	x.Fixed = nil
	var c Fixed
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Fixed = &c
	}
	return nil
}

func (x *UnionFixed) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Fixed != nil, x.Fixed, false, nil, false, nil, false)
}

type UnionFloat struct {
	Double *float64
	Float  *Float
}

func (x *UnionFloat) UnmarshalJSON(data []byte) error {
	x.Float = nil
	var c Float
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Float = &c
	}
	return nil
}

func (x *UnionFloat) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Float != nil, x.Float, false, nil, false, nil, false)
}

type UnionFor struct {
	Double *float64
	For    *For
}

func (x *UnionFor) UnmarshalJSON(data []byte) error {
	x.For = nil
	var c For
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.For = &c
	}
	return nil
}

func (x *UnionFor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.For != nil, x.For, false, nil, false, nil, false)
}

type UnionForeach struct {
	Double  *float64
	Foreach *Foreach
}

func (x *UnionForeach) UnmarshalJSON(data []byte) error {
	x.Foreach = nil
	var c Foreach
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Foreach = &c
	}
	return nil
}

func (x *UnionForeach) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Foreach != nil, x.Foreach, false, nil, false, nil, false)
}

type UnionFormatException struct {
	Double          *float64
	FormatException *FormatException
}

func (x *UnionFormatException) UnmarshalJSON(data []byte) error {
	x.FormatException = nil
	var c FormatException
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FormatException = &c
	}
	return nil
}

func (x *UnionFormatException) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.FormatException != nil, x.FormatException, false, nil, false, nil, false)
}

type UnionFriend struct {
	Double *float64
	Friend *Friend
}

func (x *UnionFriend) UnmarshalJSON(data []byte) error {
	x.Friend = nil
	var c Friend
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Friend = &c
	}
	return nil
}

func (x *UnionFriend) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Friend != nil, x.Friend, false, nil, false, nil, false)
}

type UnionFrom struct {
	Double *float64
	From   *From
}

func (x *UnionFrom) UnmarshalJSON(data []byte) error {
	x.From = nil
	var c From
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.From = &c
	}
	return nil
}

func (x *UnionFrom) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.From != nil, x.From, false, nil, false, nil, false)
}

type UnionFromDict struct {
	Double   *float64
	FromDict *FromDict
}

func (x *UnionFromDict) UnmarshalJSON(data []byte) error {
	x.FromDict = nil
	var c FromDict
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FromDict = &c
	}
	return nil
}

func (x *UnionFromDict) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.FromDict != nil, x.FromDict, false, nil, false, nil, false)
}

type UnionFromJSON struct {
	Double   *float64
	FromJSON *FromJSON
}

func (x *UnionFromJSON) UnmarshalJSON(data []byte) error {
	x.FromJSON = nil
	var c FromJSON
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FromJSON = &c
	}
	return nil
}

func (x *UnionFromJSON) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.FromJSON != nil, x.FromJSON, false, nil, false, nil, false)
}

type UnionFunc struct {
	Double *float64
	Func   *Func
}

func (x *UnionFunc) UnmarshalJSON(data []byte) error {
	x.Func = nil
	var c Func
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Func = &c
	}
	return nil
}

func (x *UnionFunc) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Func != nil, x.Func, false, nil, false, nil, false)
}

type UnionFunction struct {
	Double   *float64
	Function *Function
}

func (x *UnionFunction) UnmarshalJSON(data []byte) error {
	x.Function = nil
	var c Function
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Function = &c
	}
	return nil
}

func (x *UnionFunction) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Function != nil, x.Function, false, nil, false, nil, false)
}

type UnionGet struct {
	Double *float64
	Get    *Get
}

func (x *UnionGet) UnmarshalJSON(data []byte) error {
	x.Get = nil
	var c Get
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Get = &c
	}
	return nil
}

func (x *UnionGet) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Get != nil, x.Get, false, nil, false, nil, false)
}

type UnionGlobal struct {
	Double *float64
	Global *Global
}

func (x *UnionGlobal) UnmarshalJSON(data []byte) error {
	x.Global = nil
	var c Global
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Global = &c
	}
	return nil
}

func (x *UnionGlobal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Global != nil, x.Global, false, nil, false, nil, false)
}

type UnionGo struct {
	Double *float64
	Go     *Go
}

func (x *UnionGo) UnmarshalJSON(data []byte) error {
	x.Go = nil
	var c Go
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Go = &c
	}
	return nil
}

func (x *UnionGo) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Go != nil, x.Go, false, nil, false, nil, false)
}

type UnionGoto struct {
	Double *float64
	Goto   *Goto
}

func (x *UnionGoto) UnmarshalJSON(data []byte) error {
	x.Goto = nil
	var c Goto
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Goto = &c
	}
	return nil
}

func (x *UnionGoto) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Goto != nil, x.Goto, false, nil, false, nil, false)
}

type UnionGuard struct {
	Double *float64
	Guard  *Guard
}

func (x *UnionGuard) UnmarshalJSON(data []byte) error {
	x.Guard = nil
	var c Guard
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Guard = &c
	}
	return nil
}

func (x *UnionGuard) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Guard != nil, x.Guard, false, nil, false, nil, false)
}

type UnionHasOwnProperty struct {
	Double         *float64
	HasOwnProperty *HasOwnProperty
}

func (x *UnionHasOwnProperty) UnmarshalJSON(data []byte) error {
	x.HasOwnProperty = nil
	var c HasOwnProperty
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.HasOwnProperty = &c
	}
	return nil
}

func (x *UnionHasOwnProperty) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.HasOwnProperty != nil, x.HasOwnProperty, false, nil, false, nil, false)
}

type UnionHashCode struct {
	Double   *float64
	HashCode *HashCode
}

func (x *UnionHashCode) UnmarshalJSON(data []byte) error {
	x.HashCode = nil
	var c HashCode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.HashCode = &c
	}
	return nil
}

func (x *UnionHashCode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.HashCode != nil, x.HashCode, false, nil, false, nil, false)
}

type UnionHashable struct {
	Double   *float64
	Hashable *Hashable
}

func (x *UnionHashable) UnmarshalJSON(data []byte) error {
	x.Hashable = nil
	var c Hashable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Hashable = &c
	}
	return nil
}

func (x *UnionHashable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Hashable != nil, x.Hashable, false, nil, false, nil, false)
}

type UnionHasher struct {
	Double *float64
	Hasher *Hasher
}

func (x *UnionHasher) UnmarshalJSON(data []byte) error {
	x.Hasher = nil
	var c Hasher
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Hasher = &c
	}
	return nil
}

func (x *UnionHasher) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Hasher != nil, x.Hasher, false, nil, false, nil, false)
}

type UnionID struct {
	Double *float64
	ID     *ID
}

func (x *UnionID) UnmarshalJSON(data []byte) error {
	x.ID = nil
	var c ID
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ID = &c
	}
	return nil
}

func (x *UnionID) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ID != nil, x.ID, false, nil, false, nil, false)
}

type UnionISODateTimeOffsetConverter struct {
	Double                     *float64
	ISODateTimeOffsetConverter *ISODateTimeOffsetConverter
}

func (x *UnionISODateTimeOffsetConverter) UnmarshalJSON(data []byte) error {
	x.ISODateTimeOffsetConverter = nil
	var c ISODateTimeOffsetConverter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ISODateTimeOffsetConverter = &c
	}
	return nil
}

func (x *UnionISODateTimeOffsetConverter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ISODateTimeOffsetConverter != nil, x.ISODateTimeOffsetConverter, false, nil, false, nil, false)
}

type UnionIf struct {
	Double *float64
	If     *If
}

func (x *UnionIf) UnmarshalJSON(data []byte) error {
	x.If = nil
	var c If
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.If = &c
	}
	return nil
}

func (x *UnionIf) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.If != nil, x.If, false, nil, false, nil, false)
}

type UnionImaginery struct {
	Double    *float64
	Imaginery *Imaginery
}

func (x *UnionImaginery) UnmarshalJSON(data []byte) error {
	x.Imaginery = nil
	var c Imaginery
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Imaginery = &c
	}
	return nil
}

func (x *UnionImaginery) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Imaginery != nil, x.Imaginery, false, nil, false, nil, false)
}

type UnionIMP struct {
	Double *float64
	Imp    *Imp
}

func (x *UnionIMP) UnmarshalJSON(data []byte) error {
	x.Imp = nil
	var c Imp
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Imp = &c
	}
	return nil
}

func (x *UnionIMP) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Imp != nil, x.Imp, false, nil, false, nil, false)
}

type UnionImplements struct {
	Double     *float64
	Implements *Implements
}

func (x *UnionImplements) UnmarshalJSON(data []byte) error {
	x.Implements = nil
	var c Implements
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Implements = &c
	}
	return nil
}

func (x *UnionImplements) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Implements != nil, x.Implements, false, nil, false, nil, false)
}

type UnionImplicit struct {
	Double   *float64
	Implicit *Implicit
}

func (x *UnionImplicit) UnmarshalJSON(data []byte) error {
	x.Implicit = nil
	var c Implicit
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Implicit = &c
	}
	return nil
}

func (x *UnionImplicit) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Implicit != nil, x.Implicit, false, nil, false, nil, false)
}

type UnionImport struct {
	Double *float64
	Import *Import
}

func (x *UnionImport) UnmarshalJSON(data []byte) error {
	x.Import = nil
	var c Import
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Import = &c
	}
	return nil
}

func (x *UnionImport) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Import != nil, x.Import, false, nil, false, nil, false)
}

type UnionIn struct {
	Double *float64
	In     *In
}

func (x *UnionIn) UnmarshalJSON(data []byte) error {
	x.In = nil
	var c In
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.In = &c
	}
	return nil
}

func (x *UnionIn) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.In != nil, x.In, false, nil, false, nil, false)
}

type UnionIndirect struct {
	Double   *float64
	Indirect *Indirect
}

func (x *UnionIndirect) UnmarshalJSON(data []byte) error {
	x.Indirect = nil
	var c Indirect
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Indirect = &c
	}
	return nil
}

func (x *UnionIndirect) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Indirect != nil, x.Indirect, false, nil, false, nil, false)
}

type UnionInfix struct {
	Double *float64
	Infix  *Infix
}

func (x *UnionInfix) UnmarshalJSON(data []byte) error {
	x.Infix = nil
	var c Infix
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Infix = &c
	}
	return nil
}

func (x *UnionInfix) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Infix != nil, x.Infix, false, nil, false, nil, false)
}

type UnionInit struct {
	Double *float64
	Init   *Init
}

func (x *UnionInit) UnmarshalJSON(data []byte) error {
	x.Init = nil
	var c Init
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Init = &c
	}
	return nil
}

func (x *UnionInit) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Init != nil, x.Init, false, nil, false, nil, false)
}

type UnionInline struct {
	Double *float64
	Inline *Inline
}

func (x *UnionInline) UnmarshalJSON(data []byte) error {
	x.Inline = nil
	var c Inline
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Inline = &c
	}
	return nil
}

func (x *UnionInline) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Inline != nil, x.Inline, false, nil, false, nil, false)
}

type UnionInout struct {
	Double *float64
	Inout  *Inout
}

func (x *UnionInout) UnmarshalJSON(data []byte) error {
	x.Inout = nil
	var c Inout
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Inout = &c
	}
	return nil
}

func (x *UnionInout) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Inout != nil, x.Inout, false, nil, false, nil, false)
}

type UnionInstanceof struct {
	Double     *float64
	Instanceof *Instanceof
}

func (x *UnionInstanceof) UnmarshalJSON(data []byte) error {
	x.Instanceof = nil
	var c Instanceof
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Instanceof = &c
	}
	return nil
}

func (x *UnionInstanceof) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Instanceof != nil, x.Instanceof, false, nil, false, nil, false)
}

type UnionInt struct {
	Double *float64
	Int    *Int
}

func (x *UnionInt) UnmarshalJSON(data []byte) error {
	x.Int = nil
	var c Int
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Int = &c
	}
	return nil
}

func (x *UnionInt) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Int != nil, x.Int, false, nil, false, nil, false)
}

type UnionIntNode struct {
	Double  *float64
	IntNode *IntNode
}

func (x *UnionIntNode) UnmarshalJSON(data []byte) error {
	x.IntNode = nil
	var c IntNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.IntNode = &c
	}
	return nil
}

func (x *UnionIntNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.IntNode != nil, x.IntNode, false, nil, false, nil, false)
}

type UnionInterface struct {
	Double    *float64
	Interface *Interface
}

func (x *UnionInterface) UnmarshalJSON(data []byte) error {
	x.Interface = nil
	var c Interface
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Interface = &c
	}
	return nil
}

func (x *UnionInterface) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Interface != nil, x.Interface, false, nil, false, nil, false)
}

type UnionInternal struct {
	Double   *float64
	Internal *Internal
}

func (x *UnionInternal) UnmarshalJSON(data []byte) error {
	x.Internal = nil
	var c Internal
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Internal = &c
	}
	return nil
}

func (x *UnionInternal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Internal != nil, x.Internal, false, nil, false, nil, false)
}

type UnionIs struct {
	Double *float64
	Is     *Is
}

func (x *UnionIs) UnmarshalJSON(data []byte) error {
	x.Is = nil
	var c Is
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Is = &c
	}
	return nil
}

func (x *UnionIs) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Is != nil, x.Is, false, nil, false, nil, false)
}

type UnionIterable struct {
	Double   *float64
	Iterable *Iterable
}

func (x *UnionIterable) UnmarshalJSON(data []byte) error {
	x.Iterable = nil
	var c Iterable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Iterable = &c
	}
	return nil
}

func (x *UnionIterable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Iterable != nil, x.Iterable, false, nil, false, nil, false)
}

type UnionJSON struct {
	Double *float64
	JSON   *JSON
}

func (x *UnionJSON) UnmarshalJSON(data []byte) error {
	x.JSON = nil
	var c JSON
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSON = &c
	}
	return nil
}

func (x *UnionJSON) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSON != nil, x.JSON, false, nil, false, nil, false)
}

type UnionJSONAny struct {
	Double  *float64
	JSONAny *JSONAny
}

func (x *UnionJSONAny) UnmarshalJSON(data []byte) error {
	x.JSONAny = nil
	var c JSONAny
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONAny = &c
	}
	return nil
}

func (x *UnionJSONAny) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONAny != nil, x.JSONAny, false, nil, false, nil, false)
}

type UnionJSONCodingKey struct {
	Double        *float64
	JSONCodingKey *JSONCodingKey
}

func (x *UnionJSONCodingKey) UnmarshalJSON(data []byte) error {
	x.JSONCodingKey = nil
	var c JSONCodingKey
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONCodingKey = &c
	}
	return nil
}

func (x *UnionJSONCodingKey) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONCodingKey != nil, x.JSONCodingKey, false, nil, false, nil, false)
}

type UnionJSONConverter struct {
	Double        *float64
	JSONConverter *JSONConverter
}

func (x *UnionJSONConverter) UnmarshalJSON(data []byte) error {
	x.JSONConverter = nil
	var c JSONConverter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONConverter = &c
	}
	return nil
}

func (x *UnionJSONConverter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONConverter != nil, x.JSONConverter, false, nil, false, nil, false)
}

type UnionJSONDecoder struct {
	Double      *float64
	JSONDecoder *JSONDecoder
}

func (x *UnionJSONDecoder) UnmarshalJSON(data []byte) error {
	x.JSONDecoder = nil
	var c JSONDecoder
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONDecoder = &c
	}
	return nil
}

func (x *UnionJSONDecoder) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONDecoder != nil, x.JSONDecoder, false, nil, false, nil, false)
}

type UnionJSONEncoder struct {
	Double      *float64
	JSONEncoder *JSONEncoder
}

func (x *UnionJSONEncoder) UnmarshalJSON(data []byte) error {
	x.JSONEncoder = nil
	var c JSONEncoder
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONEncoder = &c
	}
	return nil
}

func (x *UnionJSONEncoder) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONEncoder != nil, x.JSONEncoder, false, nil, false, nil, false)
}

type UnionJSONException struct {
	Double        *float64
	JSONException *JSONException
}

func (x *UnionJSONException) UnmarshalJSON(data []byte) error {
	x.JSONException = nil
	var c JSONException
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONException = &c
	}
	return nil
}

func (x *UnionJSONException) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONException != nil, x.JSONException, false, nil, false, nil, false)
}

type UnionJSONGenerator struct {
	Double        *float64
	JSONGenerator *JSONGenerator
}

func (x *UnionJSONGenerator) UnmarshalJSON(data []byte) error {
	x.JSONGenerator = nil
	var c JSONGenerator
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONGenerator = &c
	}
	return nil
}

func (x *UnionJSONGenerator) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONGenerator != nil, x.JSONGenerator, false, nil, false, nil, false)
}

type UnionJSONNode struct {
	Double   *float64
	JSONNode *JSONNode
}

func (x *UnionJSONNode) UnmarshalJSON(data []byte) error {
	x.JSONNode = nil
	var c JSONNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONNode = &c
	}
	return nil
}

func (x *UnionJSONNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONNode != nil, x.JSONNode, false, nil, false, nil, false)
}

type UnionJSONNull struct {
	Double   *float64
	JSONNull *JSONNull
}

func (x *UnionJSONNull) UnmarshalJSON(data []byte) error {
	x.JSONNull = nil
	var c JSONNull
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONNull = &c
	}
	return nil
}

func (x *UnionJSONNull) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONNull != nil, x.JSONNull, false, nil, false, nil, false)
}

type UnionJSONParser struct {
	Double     *float64
	JSONParser *JSONParser
}

func (x *UnionJSONParser) UnmarshalJSON(data []byte) error {
	x.JSONParser = nil
	var c JSONParser
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONParser = &c
	}
	return nil
}

func (x *UnionJSONParser) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONParser != nil, x.JSONParser, false, nil, false, nil, false)
}

type UnionJSONReader struct {
	Double     *float64
	JSONReader *JSONReader
}

func (x *UnionJSONReader) UnmarshalJSON(data []byte) error {
	x.JSONReader = nil
	var c JSONReader
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONReader = &c
	}
	return nil
}

func (x *UnionJSONReader) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONReader != nil, x.JSONReader, false, nil, false, nil, false)
}

type UnionJSONSerializer struct {
	Double         *float64
	JSONSerializer *JSONSerializer
}

func (x *UnionJSONSerializer) UnmarshalJSON(data []byte) error {
	x.JSONSerializer = nil
	var c JSONSerializer
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONSerializer = &c
	}
	return nil
}

func (x *UnionJSONSerializer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONSerializer != nil, x.JSONSerializer, false, nil, false, nil, false)
}

type UnionJSONToken struct {
	Double    *float64
	JSONToken *JSONToken
}

func (x *UnionJSONToken) UnmarshalJSON(data []byte) error {
	x.JSONToken = nil
	var c JSONToken
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONToken = &c
	}
	return nil
}

func (x *UnionJSONToken) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONToken != nil, x.JSONToken, false, nil, false, nil, false)
}

type UnionJSONTokenType struct {
	Double        *float64
	JSONTokenType *JSONTokenType
}

func (x *UnionJSONTokenType) UnmarshalJSON(data []byte) error {
	x.JSONTokenType = nil
	var c JSONTokenType
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONTokenType = &c
	}
	return nil
}

func (x *UnionJSONTokenType) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONTokenType != nil, x.JSONTokenType, false, nil, false, nil, false)
}

type UnionJSONWriter struct {
	Double     *float64
	JSONWriter *JSONWriter
}

func (x *UnionJSONWriter) UnmarshalJSON(data []byte) error {
	x.JSONWriter = nil
	var c JSONWriter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.JSONWriter = &c
	}
	return nil
}

func (x *UnionJSONWriter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.JSONWriter != nil, x.JSONWriter, false, nil, false, nil, false)
}

type UnionJdec struct {
	Double *float64
	Jdec   *Jdec
}

func (x *UnionJdec) UnmarshalJSON(data []byte) error {
	x.Jdec = nil
	var c Jdec
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Jdec = &c
	}
	return nil
}

func (x *UnionJdec) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Jdec != nil, x.Jdec, false, nil, false, nil, false)
}

type UnionJenc struct {
	Double *float64
	Jenc   *Jenc
}

func (x *UnionJenc) UnmarshalJSON(data []byte) error {
	x.Jenc = nil
	var c Jenc
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Jenc = &c
	}
	return nil
}

func (x *UnionJenc) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Jenc != nil, x.Jenc, false, nil, false, nil, false)
}

type UnionJpipe struct {
	Double *float64
	Jpipe  *Jpipe
}

func (x *UnionJpipe) UnmarshalJSON(data []byte) error {
	x.Jpipe = nil
	var c Jpipe
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Jpipe = &c
	}
	return nil
}

func (x *UnionJpipe) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Jpipe != nil, x.Jpipe, false, nil, false, nil, false)
}

type UnionKSerializer struct {
	Double      *float64
	KSerializer *KSerializer
}

func (x *UnionKSerializer) UnmarshalJSON(data []byte) error {
	x.KSerializer = nil
	var c KSerializer
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.KSerializer = &c
	}
	return nil
}

func (x *UnionKSerializer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.KSerializer != nil, x.KSerializer, false, nil, false, nil, false)
}

type UnionLambda struct {
	Double *float64
	Lambda *Lambda
}

func (x *UnionLambda) UnmarshalJSON(data []byte) error {
	x.Lambda = nil
	var c Lambda
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Lambda = &c
	}
	return nil
}

func (x *UnionLambda) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Lambda != nil, x.Lambda, false, nil, false, nil, false)
}

type UnionLazy struct {
	Double *float64
	Lazy   *Lazy
}

func (x *UnionLazy) UnmarshalJSON(data []byte) error {
	x.Lazy = nil
	var c Lazy
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Lazy = &c
	}
	return nil
}

func (x *UnionLazy) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Lazy != nil, x.Lazy, false, nil, false, nil, false)
}

type UnionLeft struct {
	Double *float64
	Left   *Left
}

func (x *UnionLeft) UnmarshalJSON(data []byte) error {
	x.Left = nil
	var c Left
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Left = &c
	}
	return nil
}

func (x *UnionLeft) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Left != nil, x.Left, false, nil, false, nil, false)
}

type UnionLet struct {
	Double *float64
	Let    *Let
}

func (x *UnionLet) UnmarshalJSON(data []byte) error {
	x.Let = nil
	var c Let
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Let = &c
	}
	return nil
}

func (x *UnionLet) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Let != nil, x.Let, false, nil, false, nil, false)
}

type UnionList struct {
	Double *float64
	List   *List
}

func (x *UnionList) UnmarshalJSON(data []byte) error {
	x.List = nil
	var c List
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.List = &c
	}
	return nil
}

func (x *UnionList) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.List != nil, x.List, false, nil, false, nil, false)
}

type UnionLocalDate struct {
	Double    *float64
	LocalDate *LocalDate
}

func (x *UnionLocalDate) UnmarshalJSON(data []byte) error {
	x.LocalDate = nil
	var c LocalDate
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LocalDate = &c
	}
	return nil
}

func (x *UnionLocalDate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.LocalDate != nil, x.LocalDate, false, nil, false, nil, false)
}

type UnionLocale struct {
	Double *float64
	Locale *Locale
}

func (x *UnionLocale) UnmarshalJSON(data []byte) error {
	x.Locale = nil
	var c Locale
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Locale = &c
	}
	return nil
}

func (x *UnionLocale) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Locale != nil, x.Locale, false, nil, false, nil, false)
}

type UnionLock struct {
	Double *float64
	Lock   *Lock
}

func (x *UnionLock) UnmarshalJSON(data []byte) error {
	x.Lock = nil
	var c Lock
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Lock = &c
	}
	return nil
}

func (x *UnionLock) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Lock != nil, x.Lock, false, nil, false, nil, false)
}

type UnionLong struct {
	Double *float64
	Long   *Long
}

func (x *UnionLong) UnmarshalJSON(data []byte) error {
	x.Long = nil
	var c Long
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Long = &c
	}
	return nil
}

func (x *UnionLong) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Long != nil, x.Long, false, nil, false, nil, false)
}

type UnionLongNode struct {
	Double   *float64
	LongNode *LongNode
}

func (x *UnionLongNode) UnmarshalJSON(data []byte) error {
	x.LongNode = nil
	var c LongNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.LongNode = &c
	}
	return nil
}

func (x *UnionLongNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.LongNode != nil, x.LongNode, false, nil, false, nil, false)
}

type UnionMap struct {
	Double *float64
	Map    *Map
}

func (x *UnionMap) UnmarshalJSON(data []byte) error {
	x.Map = nil
	var c Map
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Map = &c
	}
	return nil
}

func (x *UnionMap) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Map != nil, x.Map, false, nil, false, nil, false)
}

type UnionMapEntry struct {
	Double   *float64
	MapEntry *MapEntry
}

func (x *UnionMapEntry) UnmarshalJSON(data []byte) error {
	x.MapEntry = nil
	var c MapEntry
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MapEntry = &c
	}
	return nil
}

func (x *UnionMapEntry) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.MapEntry != nil, x.MapEntry, false, nil, false, nil, false)
}

type UnionMarshalJSON struct {
	Double            *float64
	PurpleMarshalJSON *MarshalJSON
}

func (x *UnionMarshalJSON) UnmarshalJSON(data []byte) error {
	x.PurpleMarshalJSON = nil
	var c MarshalJSON
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PurpleMarshalJSON = &c
	}
	return nil
}

func (x *UnionMarshalJSON) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PurpleMarshalJSON != nil, x.PurpleMarshalJSON, false, nil, false, nil, false)
}

type UnionMetadataPropertyHandling struct {
	Double                   *float64
	MetadataPropertyHandling *MetadataPropertyHandling
}

func (x *UnionMetadataPropertyHandling) UnmarshalJSON(data []byte) error {
	x.MetadataPropertyHandling = nil
	var c MetadataPropertyHandling
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.MetadataPropertyHandling = &c
	}
	return nil
}

func (x *UnionMetadataPropertyHandling) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.MetadataPropertyHandling != nil, x.MetadataPropertyHandling, false, nil, false, nil, false)
}

type UnionModule struct {
	Double *float64
	Module *Module
}

func (x *UnionModule) UnmarshalJSON(data []byte) error {
	x.Module = nil
	var c Module
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Module = &c
	}
	return nil
}

func (x *UnionModule) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Module != nil, x.Module, false, nil, false, nil, false)
}

type UnionMutable struct {
	Double  *float64
	Mutable *Mutable
}

func (x *UnionMutable) UnmarshalJSON(data []byte) error {
	x.Mutable = nil
	var c Mutable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Mutable = &c
	}
	return nil
}

func (x *UnionMutable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Mutable != nil, x.Mutable, false, nil, false, nil, false)
}

type UnionMutating struct {
	Double   *float64
	Mutating *Mutating
}

func (x *UnionMutating) UnmarshalJSON(data []byte) error {
	x.Mutating = nil
	var c Mutating
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Mutating = &c
	}
	return nil
}

func (x *UnionMutating) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Mutating != nil, x.Mutating, false, nil, false, nil, false)
}

type UnionNSError struct {
	Double  *float64
	NSError *NSError
}

func (x *UnionNSError) UnmarshalJSON(data []byte) error {
	x.NSError = nil
	var c NSError
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NSError = &c
	}
	return nil
}

func (x *UnionNSError) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NSError != nil, x.NSError, false, nil, false, nil, false)
}

type UnionNSObject struct {
	Double   *float64
	NSObject *NSObject
}

func (x *UnionNSObject) UnmarshalJSON(data []byte) error {
	x.NSObject = nil
	var c NSObject
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NSObject = &c
	}
	return nil
}

func (x *UnionNSObject) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NSObject != nil, x.NSObject, false, nil, false, nil, false)
}

type UnionNSString struct {
	Double   *float64
	NSString *NSString
}

func (x *UnionNSString) UnmarshalJSON(data []byte) error {
	x.NSString = nil
	var c NSString
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NSString = &c
	}
	return nil
}

func (x *UnionNSString) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NSString != nil, x.NSString, false, nil, false, nil, false)
}

type UnionNamespace struct {
	Double    *float64
	Namespace *Namespace
}

func (x *UnionNamespace) UnmarshalJSON(data []byte) error {
	x.Namespace = nil
	var c Namespace
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Namespace = &c
	}
	return nil
}

func (x *UnionNamespace) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Namespace != nil, x.Namespace, false, nil, false, nil, false)
}

type UnionNative struct {
	Double *float64
	Native *Native
}

func (x *UnionNative) UnmarshalJSON(data []byte) error {
	x.Native = nil
	var c Native
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Native = &c
	}
	return nil
}

func (x *UnionNative) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Native != nil, x.Native, false, nil, false, nil, false)
}

type UnionNew struct {
	Double *float64
	New    *New
}

func (x *UnionNew) UnmarshalJSON(data []byte) error {
	x.New = nil
	var c New
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.New = &c
	}
	return nil
}

func (x *UnionNew) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.New != nil, x.New, false, nil, false, nil, false)
}

type UnionNewtonsoft struct {
	Double     *float64
	Newtonsoft *Newtonsoft
}

func (x *UnionNewtonsoft) UnmarshalJSON(data []byte) error {
	x.Newtonsoft = nil
	var c Newtonsoft
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Newtonsoft = &c
	}
	return nil
}

func (x *UnionNewtonsoft) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Newtonsoft != nil, x.Newtonsoft, false, nil, false, nil, false)
}

type UnionNil struct {
	Double *float64
	Nil    *Nil
}

func (x *UnionNil) UnmarshalJSON(data []byte) error {
	x.Nil = nil
	var c Nil
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Nil = &c
	}
	return nil
}

func (x *UnionNil) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Nil != nil, x.Nil, false, nil, false, nil, false)
}

type UnionNO struct {
	Double *float64
	No     *No
}

func (x *UnionNO) UnmarshalJSON(data []byte) error {
	x.No = nil
	var c No
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.No = &c
	}
	return nil
}

func (x *UnionNO) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.No != nil, x.No, false, nil, false, nil, false)
}

type UnionNoSuchMethod struct {
	Double       *float64
	NoSuchMethod *NoSuchMethod
}

func (x *UnionNoSuchMethod) UnmarshalJSON(data []byte) error {
	x.NoSuchMethod = nil
	var c NoSuchMethod
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NoSuchMethod = &c
	}
	return nil
}

func (x *UnionNoSuchMethod) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NoSuchMethod != nil, x.NoSuchMethod, false, nil, false, nil, false)
}

type UnionNoexcept struct {
	Double   *float64
	Noexcept *Noexcept
}

func (x *UnionNoexcept) UnmarshalJSON(data []byte) error {
	x.Noexcept = nil
	var c Noexcept
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Noexcept = &c
	}
	return nil
}

func (x *UnionNoexcept) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Noexcept != nil, x.Noexcept, false, nil, false, nil, false)
}

type UnionNonatomic struct {
	Double    *float64
	Nonatomic *Nonatomic
}

func (x *UnionNonatomic) UnmarshalJSON(data []byte) error {
	x.Nonatomic = nil
	var c Nonatomic
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Nonatomic = &c
	}
	return nil
}

func (x *UnionNonatomic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Nonatomic != nil, x.Nonatomic, false, nil, false, nil, false)
}

type UnionNone struct {
	Double *float64
	None   *None
}

func (x *UnionNone) UnmarshalJSON(data []byte) error {
	x.None = nil
	var c None
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.None = &c
	}
	return nil
}

func (x *UnionNone) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.None != nil, x.None, false, nil, false, nil, false)
}

type UnionNonlocal struct {
	Double   *float64
	Nonlocal *Nonlocal
}

func (x *UnionNonlocal) UnmarshalJSON(data []byte) error {
	x.Nonlocal = nil
	var c Nonlocal
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Nonlocal = &c
	}
	return nil
}

func (x *UnionNonlocal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Nonlocal != nil, x.Nonlocal, false, nil, false, nil, false)
}

type UnionNonmutating struct {
	Double      *float64
	Nonmutating *Nonmutating
}

func (x *UnionNonmutating) UnmarshalJSON(data []byte) error {
	x.Nonmutating = nil
	var c Nonmutating
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Nonmutating = &c
	}
	return nil
}

func (x *UnionNonmutating) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Nonmutating != nil, x.Nonmutating, false, nil, false, nil, false)
}

type UnionNot struct {
	Double *float64
	Not    *Not
}

func (x *UnionNot) UnmarshalJSON(data []byte) error {
	x.Not = nil
	var c Not
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Not = &c
	}
	return nil
}

func (x *UnionNot) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Not != nil, x.Not, false, nil, false, nil, false)
}

type UnionNotEq struct {
	Double *float64
	NotEq  *NotEq
}

func (x *UnionNotEq) UnmarshalJSON(data []byte) error {
	x.NotEq = nil
	var c NotEq
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NotEq = &c
	}
	return nil
}

func (x *UnionNotEq) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NotEq != nil, x.NotEq, false, nil, false, nil, false)
}

type UnionNULL struct {
	Double *float64
	Null   *Null
}

func (x *UnionNULL) UnmarshalJSON(data []byte) error {
	x.Null = nil
	var c Null
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Null = &c
	}
	return nil
}

func (x *UnionNULL) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Null != nil, x.Null, false, nil, false, nil, false)
}

type UnionNullNode struct {
	Double   *float64
	NullNode *NullNode
}

func (x *UnionNullNode) UnmarshalJSON(data []byte) error {
	x.NullNode = nil
	var c NullNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NullNode = &c
	}
	return nil
}

func (x *UnionNullNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NullNode != nil, x.NullNode, false, nil, false, nil, false)
}

type UnionNullptr struct {
	Double  *float64
	Nullptr *Nullptr
}

func (x *UnionNullptr) UnmarshalJSON(data []byte) error {
	x.Nullptr = nil
	var c Nullptr
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Nullptr = &c
	}
	return nil
}

func (x *UnionNullptr) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Nullptr != nil, x.Nullptr, false, nil, false, nil, false)
}

type UnionNumber struct {
	Double *float64
	Number *Number
}

func (x *UnionNumber) UnmarshalJSON(data []byte) error {
	x.Number = nil
	var c Number
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Number = &c
	}
	return nil
}

func (x *UnionNumber) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Number != nil, x.Number, false, nil, false, nil, false)
}

type UnionObject struct {
	Double *float64
	Object *Object
}

func (x *UnionObject) UnmarshalJSON(data []byte) error {
	x.Object = nil
	var c Object
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Object = &c
	}
	return nil
}

func (x *UnionObject) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Object != nil, x.Object, false, nil, false, nil, false)
}

type UnionObjectMapper struct {
	Double       *float64
	ObjectMapper *ObjectMapper
}

func (x *UnionObjectMapper) UnmarshalJSON(data []byte) error {
	x.ObjectMapper = nil
	var c ObjectMapper
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ObjectMapper = &c
	}
	return nil
}

func (x *UnionObjectMapper) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ObjectMapper != nil, x.ObjectMapper, false, nil, false, nil, false)
}

type UnionObjectNode struct {
	Double     *float64
	ObjectNode *ObjectNode
}

func (x *UnionObjectNode) UnmarshalJSON(data []byte) error {
	x.ObjectNode = nil
	var c ObjectNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ObjectNode = &c
	}
	return nil
}

func (x *UnionObjectNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ObjectNode != nil, x.ObjectNode, false, nil, false, nil, false)
}

type UnionObjectReader struct {
	Double       *float64
	ObjectReader *ObjectReader
}

func (x *UnionObjectReader) UnmarshalJSON(data []byte) error {
	x.ObjectReader = nil
	var c ObjectReader
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ObjectReader = &c
	}
	return nil
}

func (x *UnionObjectReader) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ObjectReader != nil, x.ObjectReader, false, nil, false, nil, false)
}

type UnionObjectWriter struct {
	Double       *float64
	ObjectWriter *ObjectWriter
}

func (x *UnionObjectWriter) UnmarshalJSON(data []byte) error {
	x.ObjectWriter = nil
	var c ObjectWriter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ObjectWriter = &c
	}
	return nil
}

func (x *UnionObjectWriter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ObjectWriter != nil, x.ObjectWriter, false, nil, false, nil, false)
}

type UnionOf struct {
	Double *float64
	Of     *Of
}

func (x *UnionOf) UnmarshalJSON(data []byte) error {
	x.Of = nil
	var c Of
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Of = &c
	}
	return nil
}

func (x *UnionOf) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Of != nil, x.Of, false, nil, false, nil, false)
}

type UnionOffsetDateTime struct {
	Double         *float64
	OffsetDateTime *OffsetDateTime
}

func (x *UnionOffsetDateTime) UnmarshalJSON(data []byte) error {
	x.OffsetDateTime = nil
	var c OffsetDateTime
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.OffsetDateTime = &c
	}
	return nil
}

func (x *UnionOffsetDateTime) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.OffsetDateTime != nil, x.OffsetDateTime, false, nil, false, nil, false)
}

type UnionOffsetTime struct {
	Double     *float64
	OffsetTime *OffsetTime
}

func (x *UnionOffsetTime) UnmarshalJSON(data []byte) error {
	x.OffsetTime = nil
	var c OffsetTime
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.OffsetTime = &c
	}
	return nil
}

func (x *UnionOffsetTime) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.OffsetTime != nil, x.OffsetTime, false, nil, false, nil, false)
}

type UnionOneway struct {
	Double *float64
	Oneway *Oneway
}

func (x *UnionOneway) UnmarshalJSON(data []byte) error {
	x.Oneway = nil
	var c Oneway
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Oneway = &c
	}
	return nil
}

func (x *UnionOneway) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Oneway != nil, x.Oneway, false, nil, false, nil, false)
}

type UnionOpen struct {
	Double *float64
	Open   *Open
}

func (x *UnionOpen) UnmarshalJSON(data []byte) error {
	x.Open = nil
	var c Open
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Open = &c
	}
	return nil
}

func (x *UnionOpen) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Open != nil, x.Open, false, nil, false, nil, false)
}

type UnionOperator struct {
	Double   *float64
	Operator *Operator
}

func (x *UnionOperator) UnmarshalJSON(data []byte) error {
	x.Operator = nil
	var c Operator
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Operator = &c
	}
	return nil
}

func (x *UnionOperator) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Operator != nil, x.Operator, false, nil, false, nil, false)
}

type UnionOptional struct {
	Double   *float64
	Optional *Optional
}

func (x *UnionOptional) UnmarshalJSON(data []byte) error {
	x.Optional = nil
	var c Optional
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Optional = &c
	}
	return nil
}

func (x *UnionOptional) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Optional != nil, x.Optional, false, nil, false, nil, false)
}

type UnionOr struct {
	Double *float64
	Or     *Or
}

func (x *UnionOr) UnmarshalJSON(data []byte) error {
	x.Or = nil
	var c Or
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Or = &c
	}
	return nil
}

func (x *UnionOr) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Or != nil, x.Or, false, nil, false, nil, false)
}

type UnionOrEq struct {
	Double *float64
	OrEq   *OrEq
}

func (x *UnionOrEq) UnmarshalJSON(data []byte) error {
	x.OrEq = nil
	var c OrEq
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.OrEq = &c
	}
	return nil
}

func (x *UnionOrEq) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.OrEq != nil, x.OrEq, false, nil, false, nil, false)
}

type UnionOut struct {
	Double *float64
	Out    *Out
}

func (x *UnionOut) UnmarshalJSON(data []byte) error {
	x.Out = nil
	var c Out
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Out = &c
	}
	return nil
}

func (x *UnionOut) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Out != nil, x.Out, false, nil, false, nil, false)
}

type UnionOverride struct {
	Double   *float64
	Override *Override
}

func (x *UnionOverride) UnmarshalJSON(data []byte) error {
	x.Override = nil
	var c Override
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Override = &c
	}
	return nil
}

func (x *UnionOverride) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Override != nil, x.Override, false, nil, false, nil, false)
}

type UnionPackage struct {
	Double  *float64
	Package *Package
}

func (x *UnionPackage) UnmarshalJSON(data []byte) error {
	x.Package = nil
	var c Package
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Package = &c
	}
	return nil
}

func (x *UnionPackage) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Package != nil, x.Package, false, nil, false, nil, false)
}

type UnionParams struct {
	Double *float64
	Params *Params
}

func (x *UnionParams) UnmarshalJSON(data []byte) error {
	x.Params = nil
	var c Params
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Params = &c
	}
	return nil
}

func (x *UnionParams) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Params != nil, x.Params, false, nil, false, nil, false)
}

type UnionPass struct {
	Double *float64
	Pass   *Pass
}

func (x *UnionPass) UnmarshalJSON(data []byte) error {
	x.Pass = nil
	var c Pass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Pass = &c
	}
	return nil
}

func (x *UnionPass) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Pass != nil, x.Pass, false, nil, false, nil, false)
}

type UnionPort struct {
	Double *float64
	Port   *Port
}

func (x *UnionPort) UnmarshalJSON(data []byte) error {
	x.Port = nil
	var c Port
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Port = &c
	}
	return nil
}

func (x *UnionPort) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Port != nil, x.Port, false, nil, false, nil, false)
}

type UnionPostfix struct {
	Double  *float64
	Postfix *Postfix
}

func (x *UnionPostfix) UnmarshalJSON(data []byte) error {
	x.Postfix = nil
	var c Postfix
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Postfix = &c
	}
	return nil
}

func (x *UnionPostfix) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Postfix != nil, x.Postfix, false, nil, false, nil, false)
}

type UnionPrecedence struct {
	Double     *float64
	Precedence *Precedence
}

func (x *UnionPrecedence) UnmarshalJSON(data []byte) error {
	x.Precedence = nil
	var c Precedence
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Precedence = &c
	}
	return nil
}

func (x *UnionPrecedence) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Precedence != nil, x.Precedence, false, nil, false, nil, false)
}

type UnionPrefix struct {
	Double *float64
	Prefix *Prefix
}

func (x *UnionPrefix) UnmarshalJSON(data []byte) error {
	x.Prefix = nil
	var c Prefix
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Prefix = &c
	}
	return nil
}

func (x *UnionPrefix) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Prefix != nil, x.Prefix, false, nil, false, nil, false)
}

type UnionPrimitiveKind struct {
	Double        *float64
	PrimitiveKind *PrimitiveKind
}

func (x *UnionPrimitiveKind) UnmarshalJSON(data []byte) error {
	x.PrimitiveKind = nil
	var c PrimitiveKind
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PrimitiveKind = &c
	}
	return nil
}

func (x *UnionPrimitiveKind) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PrimitiveKind != nil, x.PrimitiveKind, false, nil, false, nil, false)
}

type UnionPrint struct {
	Double *float64
	Print  *Print
}

func (x *UnionPrint) UnmarshalJSON(data []byte) error {
	x.Print = nil
	var c Print
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Print = &c
	}
	return nil
}

func (x *UnionPrint) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Print != nil, x.Print, false, nil, false, nil, false)
}

type UnionPrintMembers struct {
	Double       *float64
	PrintMembers *PrintMembers
}

func (x *UnionPrintMembers) UnmarshalJSON(data []byte) error {
	x.PrintMembers = nil
	var c PrintMembers
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PrintMembers = &c
	}
	return nil
}

func (x *UnionPrintMembers) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PrintMembers != nil, x.PrintMembers, false, nil, false, nil, false)
}

type UnionPrintf struct {
	Double *float64
	Printf *Printf
}

func (x *UnionPrintf) UnmarshalJSON(data []byte) error {
	x.Printf = nil
	var c Printf
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Printf = &c
	}
	return nil
}

func (x *UnionPrintf) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Printf != nil, x.Printf, false, nil, false, nil, false)
}

type UnionPrivate struct {
	Double  *float64
	Private *Private
}

func (x *UnionPrivate) UnmarshalJSON(data []byte) error {
	x.Private = nil
	var c Private
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Private = &c
	}
	return nil
}

func (x *UnionPrivate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Private != nil, x.Private, false, nil, false, nil, false)
}

type UnionProtected struct {
	Double    *float64
	Protected *Protected
}

func (x *UnionProtected) UnmarshalJSON(data []byte) error {
	x.Protected = nil
	var c Protected
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Protected = &c
	}
	return nil
}

func (x *UnionProtected) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Protected != nil, x.Protected, false, nil, false, nil, false)
}

type UnionProtocol struct {
	Double   *float64
	Protocol *Protocol
}

func (x *UnionProtocol) UnmarshalJSON(data []byte) error {
	x.Protocol = nil
	var c Protocol
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Protocol = &c
	}
	return nil
}

func (x *UnionProtocol) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Protocol != nil, x.Protocol, false, nil, false, nil, false)
}

type UnionPublic struct {
	Double *float64
	Public *Public
}

func (x *UnionPublic) UnmarshalJSON(data []byte) error {
	x.Public = nil
	var c Public
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Public = &c
	}
	return nil
}

func (x *UnionPublic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Public != nil, x.Public, false, nil, false, nil, false)
}

type UnionBoolUnion struct {
	Double        *float64
	UnionBoolBool *UnionBoolBool
}

func (x *UnionBoolUnion) UnmarshalJSON(data []byte) error {
	x.UnionBoolBool = nil
	var c UnionBoolBool
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.UnionBoolBool = &c
	}
	return nil
}

func (x *UnionBoolUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.UnionBoolBool != nil, x.UnionBoolBool, false, nil, false, nil, false)
}

type UnionQuicktype struct {
	Double    *float64
	Quicktype *Quicktype
}

func (x *UnionQuicktype) UnmarshalJSON(data []byte) error {
	x.Quicktype = nil
	var c Quicktype
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Quicktype = &c
	}
	return nil
}

func (x *UnionQuicktype) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Quicktype != nil, x.Quicktype, false, nil, false, nil, false)
}

type UnionRaise struct {
	Double *float64
	Raise  *Raise
}

func (x *UnionRaise) UnmarshalJSON(data []byte) error {
	x.Raise = nil
	var c Raise
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Raise = &c
	}
	return nil
}

func (x *UnionRaise) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Raise != nil, x.Raise, false, nil, false, nil, false)
}

type UnionRange struct {
	Double *float64
	Range  *Range
}

func (x *UnionRange) UnmarshalJSON(data []byte) error {
	x.Range = nil
	var c Range
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Range = &c
	}
	return nil
}

func (x *UnionRange) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Range != nil, x.Range, false, nil, false, nil, false)
}

type UnionReadonly struct {
	Double   *float64
	Readonly *Readonly
}

func (x *UnionReadonly) UnmarshalJSON(data []byte) error {
	x.Readonly = nil
	var c Readonly
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Readonly = &c
	}
	return nil
}

func (x *UnionReadonly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Readonly != nil, x.Readonly, false, nil, false, nil, false)
}

type UnionRef struct {
	Double *float64
	Ref    *Ref
}

func (x *UnionRef) UnmarshalJSON(data []byte) error {
	x.Ref = nil
	var c Ref
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Ref = &c
	}
	return nil
}

func (x *UnionRef) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Ref != nil, x.Ref, false, nil, false, nil, false)
}

type UnionRegExp struct {
	Double *float64
	RegExp *RegExp
}

func (x *UnionRegExp) UnmarshalJSON(data []byte) error {
	x.RegExp = nil
	var c RegExp
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.RegExp = &c
	}
	return nil
}

func (x *UnionRegExp) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.RegExp != nil, x.RegExp, false, nil, false, nil, false)
}

type UnionRegister struct {
	Double   *float64
	Register *Register
}

func (x *UnionRegister) UnmarshalJSON(data []byte) error {
	x.Register = nil
	var c Register
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Register = &c
	}
	return nil
}

func (x *UnionRegister) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Register != nil, x.Register, false, nil, false, nil, false)
}

type UnionReinterpretCast struct {
	Double          *float64
	ReinterpretCast *ReinterpretCast
}

func (x *UnionReinterpretCast) UnmarshalJSON(data []byte) error {
	x.ReinterpretCast = nil
	var c ReinterpretCast
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ReinterpretCast = &c
	}
	return nil
}

func (x *UnionReinterpretCast) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ReinterpretCast != nil, x.ReinterpretCast, false, nil, false, nil, false)
}

type UnionRepeat struct {
	Double *float64
	Repeat *Repeat
}

func (x *UnionRepeat) UnmarshalJSON(data []byte) error {
	x.Repeat = nil
	var c Repeat
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Repeat = &c
	}
	return nil
}

func (x *UnionRepeat) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Repeat != nil, x.Repeat, false, nil, false, nil, false)
}

type UnionRequire struct {
	Double  *float64
	Require *Require
}

func (x *UnionRequire) UnmarshalJSON(data []byte) error {
	x.Require = nil
	var c Require
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Require = &c
	}
	return nil
}

func (x *UnionRequire) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Require != nil, x.Require, false, nil, false, nil, false)
}

type UnionRequired struct {
	Double   *float64
	Required *Required
}

func (x *UnionRequired) UnmarshalJSON(data []byte) error {
	x.Required = nil
	var c Required
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Required = &c
	}
	return nil
}

func (x *UnionRequired) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Required != nil, x.Required, false, nil, false, nil, false)
}

type UnionRequires struct {
	Double   *float64
	Requires *Requires
}

func (x *UnionRequires) UnmarshalJSON(data []byte) error {
	x.Requires = nil
	var c Requires
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Requires = &c
	}
	return nil
}

func (x *UnionRequires) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Requires != nil, x.Requires, false, nil, false, nil, false)
}

type UnionRestrict struct {
	Double   *float64
	Restrict *Restrict
}

func (x *UnionRestrict) UnmarshalJSON(data []byte) error {
	x.Restrict = nil
	var c Restrict
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Restrict = &c
	}
	return nil
}

func (x *UnionRestrict) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Restrict != nil, x.Restrict, false, nil, false, nil, false)
}

type UnionRetain struct {
	Double *float64
	Retain *Retain
}

func (x *UnionRetain) UnmarshalJSON(data []byte) error {
	x.Retain = nil
	var c Retain
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Retain = &c
	}
	return nil
}

func (x *UnionRetain) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Retain != nil, x.Retain, false, nil, false, nil, false)
}

type UnionRethrows struct {
	Double   *float64
	Rethrows *Rethrows
}

func (x *UnionRethrows) UnmarshalJSON(data []byte) error {
	x.Rethrows = nil
	var c Rethrows
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Rethrows = &c
	}
	return nil
}

func (x *UnionRethrows) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Rethrows != nil, x.Rethrows, false, nil, false, nil, false)
}

type UnionReturn struct {
	Double *float64
	Return *Return
}

func (x *UnionReturn) UnmarshalJSON(data []byte) error {
	x.Return = nil
	var c Return
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Return = &c
	}
	return nil
}

func (x *UnionReturn) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Return != nil, x.Return, false, nil, false, nil, false)
}

type UnionRight struct {
	Double *float64
	Right  *Right
}

func (x *UnionRight) UnmarshalJSON(data []byte) error {
	x.Right = nil
	var c Right
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Right = &c
	}
	return nil
}

func (x *UnionRight) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Right != nil, x.Right, false, nil, false, nil, false)
}

type UnionRuntimeType struct {
	Double      *float64
	RuntimeType *RuntimeType
}

func (x *UnionRuntimeType) UnmarshalJSON(data []byte) error {
	x.RuntimeType = nil
	var c RuntimeType
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.RuntimeType = &c
	}
	return nil
}

func (x *UnionRuntimeType) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.RuntimeType != nil, x.RuntimeType, false, nil, false, nil, false)
}

type UnionS struct {
	Double *float64
	S      *S
}

func (x *UnionS) UnmarshalJSON(data []byte) error {
	x.S = nil
	var c S
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.S = &c
	}
	return nil
}

func (x *UnionS) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.S != nil, x.S, false, nil, false, nil, false)
}

type UnionSbyte struct {
	Double *float64
	Sbyte  *Sbyte
}

func (x *UnionSbyte) UnmarshalJSON(data []byte) error {
	x.Sbyte = nil
	var c Sbyte
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Sbyte = &c
	}
	return nil
}

func (x *UnionSbyte) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Sbyte != nil, x.Sbyte, false, nil, false, nil, false)
}

type UnionSealed struct {
	Double *float64
	Sealed *Sealed
}

func (x *UnionSealed) UnmarshalJSON(data []byte) error {
	x.Sealed = nil
	var c Sealed
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Sealed = &c
	}
	return nil
}

func (x *UnionSealed) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Sealed != nil, x.Sealed, false, nil, false, nil, false)
}

type UnionSEL struct {
	Double *float64
	Sel    *Sel
}

func (x *UnionSEL) UnmarshalJSON(data []byte) error {
	x.Sel = nil
	var c Sel
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Sel = &c
	}
	return nil
}

func (x *UnionSEL) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Sel != nil, x.Sel, false, nil, false, nil, false)
}

type UnionSelect struct {
	Double *float64
	Select *Select
}

func (x *UnionSelect) UnmarshalJSON(data []byte) error {
	x.Select = nil
	var c Select
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Select = &c
	}
	return nil
}

func (x *UnionSelect) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Select != nil, x.Select, false, nil, false, nil, false)
}

type UnionSelf struct {
	Double *float64
	Self   *Self
}

func (x *UnionSelf) UnmarshalJSON(data []byte) error {
	x.Self = nil
	var c Self
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Self = &c
	}
	return nil
}

func (x *UnionSelf) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Self != nil, x.Self, false, nil, false, nil, false)
}

type UnionSendable struct {
	Double   *float64
	Sendable *Sendable
}

func (x *UnionSendable) UnmarshalJSON(data []byte) error {
	x.Sendable = nil
	var c Sendable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Sendable = &c
	}
	return nil
}

func (x *UnionSendable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Sendable != nil, x.Sendable, false, nil, false, nil, false)
}

type UnionSerialDescriptor struct {
	Double           *float64
	SerialDescriptor *SerialDescriptor
}

func (x *UnionSerialDescriptor) UnmarshalJSON(data []byte) error {
	x.SerialDescriptor = nil
	var c SerialDescriptor
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SerialDescriptor = &c
	}
	return nil
}

func (x *UnionSerialDescriptor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SerialDescriptor != nil, x.SerialDescriptor, false, nil, false, nil, false)
}

type UnionSerialName struct {
	Double     *float64
	SerialName *SerialName
}

func (x *UnionSerialName) UnmarshalJSON(data []byte) error {
	x.SerialName = nil
	var c SerialName
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SerialName = &c
	}
	return nil
}

func (x *UnionSerialName) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SerialName != nil, x.SerialName, false, nil, false, nil, false)
}

type UnionSerializable struct {
	Double       *float64
	Serializable *Serializable
}

func (x *UnionSerializable) UnmarshalJSON(data []byte) error {
	x.Serializable = nil
	var c Serializable
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Serializable = &c
	}
	return nil
}

func (x *UnionSerializable) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Serializable != nil, x.Serializable, false, nil, false, nil, false)
}

type UnionSerializationFeature struct {
	Double               *float64
	SerializationFeature *SerializationFeature
}

func (x *UnionSerializationFeature) UnmarshalJSON(data []byte) error {
	x.SerializationFeature = nil
	var c SerializationFeature
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SerializationFeature = &c
	}
	return nil
}

func (x *UnionSerializationFeature) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SerializationFeature != nil, x.SerializationFeature, false, nil, false, nil, false)
}

type UnionSerialize struct {
	Double    *float64
	Serialize *Serialize
}

func (x *UnionSerialize) UnmarshalJSON(data []byte) error {
	x.Serialize = nil
	var c Serialize
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Serialize = &c
	}
	return nil
}

func (x *UnionSerialize) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Serialize != nil, x.Serialize, false, nil, false, nil, false)
}

type UnionSerializerProvider struct {
	Double             *float64
	SerializerProvider *SerializerProvider
}

func (x *UnionSerializerProvider) UnmarshalJSON(data []byte) error {
	x.SerializerProvider = nil
	var c SerializerProvider
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SerializerProvider = &c
	}
	return nil
}

func (x *UnionSerializerProvider) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SerializerProvider != nil, x.SerializerProvider, false, nil, false, nil, false)
}

type UnionSet struct {
	Double *float64
	Set    *Set
}

func (x *UnionSet) UnmarshalJSON(data []byte) error {
	x.Set = nil
	var c Set
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Set = &c
	}
	return nil
}

func (x *UnionSet) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Set != nil, x.Set, false, nil, false, nil, false)
}

type UnionShort struct {
	Double *float64
	Short  *Short
}

func (x *UnionShort) UnmarshalJSON(data []byte) error {
	x.Short = nil
	var c Short
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Short = &c
	}
	return nil
}

func (x *UnionShort) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Short != nil, x.Short, false, nil, false, nil, false)
}

type UnionSigned struct {
	Double *float64
	Signed *Signed
}

func (x *UnionSigned) UnmarshalJSON(data []byte) error {
	x.Signed = nil
	var c Signed
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Signed = &c
	}
	return nil
}

func (x *UnionSigned) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Signed != nil, x.Signed, false, nil, false, nil, false)
}

type UnionSimpleModule struct {
	Double       *float64
	SimpleModule *SimpleModule
}

func (x *UnionSimpleModule) UnmarshalJSON(data []byte) error {
	x.SimpleModule = nil
	var c SimpleModule
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SimpleModule = &c
	}
	return nil
}

func (x *UnionSimpleModule) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SimpleModule != nil, x.SimpleModule, false, nil, false, nil, false)
}

type UnionSizeof struct {
	Double *float64
	Sizeof *Sizeof
}

func (x *UnionSizeof) UnmarshalJSON(data []byte) error {
	x.Sizeof = nil
	var c Sizeof
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Sizeof = &c
	}
	return nil
}

func (x *UnionSizeof) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Sizeof != nil, x.Sizeof, false, nil, false, nil, false)
}

type UnionStackalloc struct {
	Double     *float64
	Stackalloc *Stackalloc
}

func (x *UnionStackalloc) UnmarshalJSON(data []byte) error {
	x.Stackalloc = nil
	var c Stackalloc
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Stackalloc = &c
	}
	return nil
}

func (x *UnionStackalloc) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Stackalloc != nil, x.Stackalloc, false, nil, false, nil, false)
}

type UnionStandards struct {
	Double    *float64
	Standards *Standards
}

func (x *UnionStandards) UnmarshalJSON(data []byte) error {
	x.Standards = nil
	var c Standards
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Standards = &c
	}
	return nil
}

func (x *UnionStandards) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Standards != nil, x.Standards, false, nil, false, nil, false)
}

type UnionStatic struct {
	Double *float64
	Static *Static
}

func (x *UnionStatic) UnmarshalJSON(data []byte) error {
	x.Static = nil
	var c Static
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Static = &c
	}
	return nil
}

func (x *UnionStatic) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Static != nil, x.Static, false, nil, false, nil, false)
}

type UnionStaticAssert struct {
	Double       *float64
	StaticAssert *StaticAssert
}

func (x *UnionStaticAssert) UnmarshalJSON(data []byte) error {
	x.StaticAssert = nil
	var c StaticAssert
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.StaticAssert = &c
	}
	return nil
}

func (x *UnionStaticAssert) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.StaticAssert != nil, x.StaticAssert, false, nil, false, nil, false)
}

type UnionStaticCast struct {
	Double     *float64
	StaticCast *StaticCast
}

func (x *UnionStaticCast) UnmarshalJSON(data []byte) error {
	x.StaticCast = nil
	var c StaticCast
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.StaticCast = &c
	}
	return nil
}

func (x *UnionStaticCast) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.StaticCast != nil, x.StaticCast, false, nil, false, nil, false)
}

type UnionStdDeserializer struct {
	Double          *float64
	StdDeserializer *StdDeserializer
}

func (x *UnionStdDeserializer) UnmarshalJSON(data []byte) error {
	x.StdDeserializer = nil
	var c StdDeserializer
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.StdDeserializer = &c
	}
	return nil
}

func (x *UnionStdDeserializer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.StdDeserializer != nil, x.StdDeserializer, false, nil, false, nil, false)
}

type UnionStdSerializer struct {
	Double        *float64
	StdSerializer *StdSerializer
}

func (x *UnionStdSerializer) UnmarshalJSON(data []byte) error {
	x.StdSerializer = nil
	var c StdSerializer
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.StdSerializer = &c
	}
	return nil
}

func (x *UnionStdSerializer) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.StdSerializer != nil, x.StdSerializer, false, nil, false, nil, false)
}

type UnionStrictfp struct {
	Double   *float64
	Strictfp *Strictfp
}

func (x *UnionStrictfp) UnmarshalJSON(data []byte) error {
	x.Strictfp = nil
	var c Strictfp
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Strictfp = &c
	}
	return nil
}

func (x *UnionStrictfp) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Strictfp != nil, x.Strictfp, false, nil, false, nil, false)
}

type UnionString struct {
	Double *float64
	String *String
}

func (x *UnionString) UnmarshalJSON(data []byte) error {
	x.String = nil
	var c String
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.String = &c
	}
	return nil
}

func (x *UnionString) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.String != nil, x.String, false, nil, false, nil, false)
}

type UnionStruct struct {
	Double *float64
	Struct *Struct
}

func (x *UnionStruct) UnmarshalJSON(data []byte) error {
	x.Struct = nil
	var c Struct
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Struct = &c
	}
	return nil
}

func (x *UnionStruct) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Struct != nil, x.Struct, false, nil, false, nil, false)
}

type UnionSubscript struct {
	Double    *float64
	Subscript *Subscript
}

func (x *UnionSubscript) UnmarshalJSON(data []byte) error {
	x.Subscript = nil
	var c Subscript
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Subscript = &c
	}
	return nil
}

func (x *UnionSubscript) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Subscript != nil, x.Subscript, false, nil, false, nil, false)
}

type UnionSuper struct {
	Double *float64
	Super  *Super
}

func (x *UnionSuper) UnmarshalJSON(data []byte) error {
	x.Super = nil
	var c Super
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Super = &c
	}
	return nil
}

func (x *UnionSuper) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Super != nil, x.Super, false, nil, false, nil, false)
}

type UnionSwitch struct {
	Double *float64
	Switch *Switch
}

func (x *UnionSwitch) UnmarshalJSON(data []byte) error {
	x.Switch = nil
	var c Switch
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Switch = &c
	}
	return nil
}

func (x *UnionSwitch) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Switch != nil, x.Switch, false, nil, false, nil, false)
}

type UnionSymbol struct {
	Double *float64
	Symbol *Symbol
}

func (x *UnionSymbol) UnmarshalJSON(data []byte) error {
	x.Symbol = nil
	var c Symbol
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Symbol = &c
	}
	return nil
}

func (x *UnionSymbol) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Symbol != nil, x.Symbol, false, nil, false, nil, false)
}

type UnionSynchronized struct {
	Double       *float64
	Synchronized *Synchronized
}

func (x *UnionSynchronized) UnmarshalJSON(data []byte) error {
	x.Synchronized = nil
	var c Synchronized
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Synchronized = &c
	}
	return nil
}

func (x *UnionSynchronized) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Synchronized != nil, x.Synchronized, false, nil, false, nil, false)
}

type UnionSystem struct {
	Double *float64
	System *System
}

func (x *UnionSystem) UnmarshalJSON(data []byte) error {
	x.System = nil
	var c System
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.System = &c
	}
	return nil
}

func (x *UnionSystem) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.System != nil, x.System, false, nil, false, nil, false)
}

type UnionTemplate struct {
	Double   *float64
	Template *Template
}

func (x *UnionTemplate) UnmarshalJSON(data []byte) error {
	x.Template = nil
	var c Template
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Template = &c
	}
	return nil
}

func (x *UnionTemplate) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Template != nil, x.Template, false, nil, false, nil, false)
}

type UnionTextNode struct {
	Double   *float64
	TextNode *TextNode
}

func (x *UnionTextNode) UnmarshalJSON(data []byte) error {
	x.TextNode = nil
	var c TextNode
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TextNode = &c
	}
	return nil
}

func (x *UnionTextNode) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TextNode != nil, x.TextNode, false, nil, false, nil, false)
}

type UnionThen struct {
	Double *float64
	Then   *Then
}

func (x *UnionThen) UnmarshalJSON(data []byte) error {
	x.Then = nil
	var c Then
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Then = &c
	}
	return nil
}

func (x *UnionThen) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Then != nil, x.Then, false, nil, false, nil, false)
}

type UnionThis struct {
	Double *float64
	This   *This
}

func (x *UnionThis) UnmarshalJSON(data []byte) error {
	x.This = nil
	var c This
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.This = &c
	}
	return nil
}

func (x *UnionThis) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.This != nil, x.This, false, nil, false, nil, false)
}

type UnionThreadLocal struct {
	Double      *float64
	ThreadLocal *ThreadLocal
}

func (x *UnionThreadLocal) UnmarshalJSON(data []byte) error {
	x.ThreadLocal = nil
	var c ThreadLocal
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ThreadLocal = &c
	}
	return nil
}

func (x *UnionThreadLocal) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ThreadLocal != nil, x.ThreadLocal, false, nil, false, nil, false)
}

type UnionThrow struct {
	Double *float64
	Throw  *Throw
}

func (x *UnionThrow) UnmarshalJSON(data []byte) error {
	x.Throw = nil
	var c Throw
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Throw = &c
	}
	return nil
}

func (x *UnionThrow) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Throw != nil, x.Throw, false, nil, false, nil, false)
}

type UnionThrows struct {
	Double *float64
	Throws *Throws
}

func (x *UnionThrows) UnmarshalJSON(data []byte) error {
	x.Throws = nil
	var c Throws
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Throws = &c
	}
	return nil
}

func (x *UnionThrows) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Throws != nil, x.Throws, false, nil, false, nil, false)
}

type UnionTimeOnly struct {
	Double   *float64
	TimeOnly *TimeOnly
}

func (x *UnionTimeOnly) UnmarshalJSON(data []byte) error {
	x.TimeOnly = nil
	var c TimeOnly
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TimeOnly = &c
	}
	return nil
}

func (x *UnionTimeOnly) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TimeOnly != nil, x.TimeOnly, false, nil, false, nil, false)
}

type UnionTimeOnlyConverter struct {
	Double            *float64
	TimeOnlyConverter *TimeOnlyConverter
}

func (x *UnionTimeOnlyConverter) UnmarshalJSON(data []byte) error {
	x.TimeOnlyConverter = nil
	var c TimeOnlyConverter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TimeOnlyConverter = &c
	}
	return nil
}

func (x *UnionTimeOnlyConverter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TimeOnlyConverter != nil, x.TimeOnlyConverter, false, nil, false, nil, false)
}

type UnionTimeZone struct {
	Double   *float64
	TimeZone *TimeZone
}

func (x *UnionTimeZone) UnmarshalJSON(data []byte) error {
	x.TimeZone = nil
	var c TimeZone
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TimeZone = &c
	}
	return nil
}

func (x *UnionTimeZone) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TimeZone != nil, x.TimeZone, false, nil, false, nil, false)
}

type UnionToDict struct {
	Double *float64
	ToDict *ToDict
}

func (x *UnionToDict) UnmarshalJSON(data []byte) error {
	x.ToDict = nil
	var c ToDict
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ToDict = &c
	}
	return nil
}

func (x *UnionToDict) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ToDict != nil, x.ToDict, false, nil, false, nil, false)
}

type UnionToJSON struct {
	Double *float64
	ToJSON *ToJSON
}

func (x *UnionToJSON) UnmarshalJSON(data []byte) error {
	x.ToJSON = nil
	var c ToJSON
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ToJSON = &c
	}
	return nil
}

func (x *UnionToJSON) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ToJSON != nil, x.ToJSON, false, nil, false, nil, false)
}

type UnionToString struct {
	Double   *float64
	ToString *ToString
}

func (x *UnionToString) UnmarshalJSON(data []byte) error {
	x.ToString = nil
	var c ToString
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ToString = &c
	}
	return nil
}

func (x *UnionToString) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ToString != nil, x.ToString, false, nil, false, nil, false)
}

type UnionTopLevel struct {
	Double        *float64
	TopLevelClass *TopLevelClass
}

func (x *UnionTopLevel) UnmarshalJSON(data []byte) error {
	x.TopLevelClass = nil
	var c TopLevelClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TopLevelClass = &c
	}
	return nil
}

func (x *UnionTopLevel) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TopLevelClass != nil, x.TopLevelClass, false, nil, false, nil, false)
}

type UnionAnyUnion struct {
	AnyClass *AnyClass
	Double   *float64
}

func (x *UnionAnyUnion) UnmarshalJSON(data []byte) error {
	x.AnyClass = nil
	var c AnyClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.AnyClass = &c
	}
	return nil
}

func (x *UnionAnyUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.AnyClass != nil, x.AnyClass, false, nil, false, nil, false)
}

type UnionBool struct {
	BoolClass *BoolClass
	Double    *float64
}

func (x *UnionBool) UnmarshalJSON(data []byte) error {
	x.BoolClass = nil
	var c BoolClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.BoolClass = &c
	}
	return nil
}

func (x *UnionBool) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.BoolClass != nil, x.BoolClass, false, nil, false, nil, false)
}

type UnionClassUnion struct {
	ClassClass *ClassClass
	Double     *float64
}

func (x *UnionClassUnion) UnmarshalJSON(data []byte) error {
	x.ClassClass = nil
	var c ClassClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ClassClass = &c
	}
	return nil
}

func (x *UnionClassUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ClassClass != nil, x.ClassClass, false, nil, false, nil, false)
}

type UnionFalseUnion struct {
	Double     *float64
	FalseClass *FalseClass
}

func (x *UnionFalseUnion) UnmarshalJSON(data []byte) error {
	x.FalseClass = nil
	var c FalseClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.FalseClass = &c
	}
	return nil
}

func (x *UnionFalseUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.FalseClass != nil, x.FalseClass, false, nil, false, nil, false)
}

type UnionNoneUnion struct {
	Double    *float64
	NoneClass *NoneClass
}

func (x *UnionNoneUnion) UnmarshalJSON(data []byte) error {
	x.NoneClass = nil
	var c NoneClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NoneClass = &c
	}
	return nil
}

func (x *UnionNoneUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NoneClass != nil, x.NoneClass, false, nil, false, nil, false)
}

type UnionNull struct {
	Double    *float64
	NullClass *NullClass
}

func (x *UnionNull) UnmarshalJSON(data []byte) error {
	x.NullClass = nil
	var c NullClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.NullClass = &c
	}
	return nil
}

func (x *UnionNull) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.NullClass != nil, x.NullClass, false, nil, false, nil, false)
}

type UnionProtocolUnion struct {
	Double        *float64
	ProtocolClass *ProtocolClass
}

func (x *UnionProtocolUnion) UnmarshalJSON(data []byte) error {
	x.ProtocolClass = nil
	var c ProtocolClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.ProtocolClass = &c
	}
	return nil
}

func (x *UnionProtocolUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.ProtocolClass != nil, x.ProtocolClass, false, nil, false, nil, false)
}

type UnionSelfUnion struct {
	Double    *float64
	SelfClass *SelfClass
}

func (x *UnionSelfUnion) UnmarshalJSON(data []byte) error {
	x.SelfClass = nil
	var c SelfClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.SelfClass = &c
	}
	return nil
}

func (x *UnionSelfUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.SelfClass != nil, x.SelfClass, false, nil, false, nil, false)
}

type UnionTrueUnion struct {
	Double    *float64
	TrueClass *TrueClass
}

func (x *UnionTrueUnion) UnmarshalJSON(data []byte) error {
	x.TrueClass = nil
	var c TrueClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TrueClass = &c
	}
	return nil
}

func (x *UnionTrueUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TrueClass != nil, x.TrueClass, false, nil, false, nil, false)
}

type UnionTypeUnion struct {
	Double    *float64
	TypeClass *TypeClass
}

func (x *UnionTypeUnion) UnmarshalJSON(data []byte) error {
	x.TypeClass = nil
	var c TypeClass
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.TypeClass = &c
	}
	return nil
}

func (x *UnionTypeUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.TypeClass != nil, x.TypeClass, false, nil, false, nil, false)
}

type UnionTransient struct {
	Double    *float64
	Transient *Transient
}

func (x *UnionTransient) UnmarshalJSON(data []byte) error {
	x.Transient = nil
	var c Transient
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Transient = &c
	}
	return nil
}

func (x *UnionTransient) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Transient != nil, x.Transient, false, nil, false, nil, false)
}

type UnionTrue struct {
	Double *float64
	True   *True
}

func (x *UnionTrue) UnmarshalJSON(data []byte) error {
	x.True = nil
	var c True
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.True = &c
	}
	return nil
}

func (x *UnionTrue) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.True != nil, x.True, false, nil, false, nil, false)
}

type UnionTry struct {
	Double *float64
	Try    *Try
}

func (x *UnionTry) UnmarshalJSON(data []byte) error {
	x.Try = nil
	var c Try
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Try = &c
	}
	return nil
}

func (x *UnionTry) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Try != nil, x.Try, false, nil, false, nil, false)
}

type UnionType struct {
	Double *float64
	Type   *Type
}

func (x *UnionType) UnmarshalJSON(data []byte) error {
	x.Type = nil
	var c Type
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Type = &c
	}
	return nil
}

func (x *UnionType) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Type != nil, x.Type, false, nil, false, nil, false)
}

type UnionTypealias struct {
	Double    *float64
	Typealias *Typealias
}

func (x *UnionTypealias) UnmarshalJSON(data []byte) error {
	x.Typealias = nil
	var c Typealias
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Typealias = &c
	}
	return nil
}

func (x *UnionTypealias) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Typealias != nil, x.Typealias, false, nil, false, nil, false)
}

type UnionTypedef struct {
	Double  *float64
	Typedef *Typedef
}

func (x *UnionTypedef) UnmarshalJSON(data []byte) error {
	x.Typedef = nil
	var c Typedef
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Typedef = &c
	}
	return nil
}

func (x *UnionTypedef) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Typedef != nil, x.Typedef, false, nil, false, nil, false)
}

type UnionTypeid struct {
	Double *float64
	Typeid *Typeid
}

func (x *UnionTypeid) UnmarshalJSON(data []byte) error {
	x.Typeid = nil
	var c Typeid
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Typeid = &c
	}
	return nil
}

func (x *UnionTypeid) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Typeid != nil, x.Typeid, false, nil, false, nil, false)
}

type UnionTypename struct {
	Double   *float64
	Typename *Typename
}

func (x *UnionTypename) UnmarshalJSON(data []byte) error {
	x.Typename = nil
	var c Typename
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Typename = &c
	}
	return nil
}

func (x *UnionTypename) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Typename != nil, x.Typename, false, nil, false, nil, false)
}

type UnionTypeof struct {
	Double *float64
	Typeof *Typeof
}

func (x *UnionTypeof) UnmarshalJSON(data []byte) error {
	x.Typeof = nil
	var c Typeof
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Typeof = &c
	}
	return nil
}

func (x *UnionTypeof) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Typeof != nil, x.Typeof, false, nil, false, nil, false)
}

type UnionUUID struct {
	Double *float64
	UUID   *UUID
}

func (x *UnionUUID) UnmarshalJSON(data []byte) error {
	x.UUID = nil
	var c UUID
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.UUID = &c
	}
	return nil
}

func (x *UnionUUID) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.UUID != nil, x.UUID, false, nil, false, nil, false)
}

type UnionUint struct {
	Double *float64
	Uint   *Uint
}

func (x *UnionUint) UnmarshalJSON(data []byte) error {
	x.Uint = nil
	var c Uint
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Uint = &c
	}
	return nil
}

func (x *UnionUint) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Uint != nil, x.Uint, false, nil, false, nil, false)
}

type UnionUlong struct {
	Double *float64
	Ulong  *Ulong
}

func (x *UnionUlong) UnmarshalJSON(data []byte) error {
	x.Ulong = nil
	var c Ulong
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Ulong = &c
	}
	return nil
}

func (x *UnionUlong) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Ulong != nil, x.Ulong, false, nil, false, nil, false)
}

type UnionUnchecked struct {
	Double    *float64
	Unchecked *Unchecked
}

func (x *UnionUnchecked) UnmarshalJSON(data []byte) error {
	x.Unchecked = nil
	var c Unchecked
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Unchecked = &c
	}
	return nil
}

func (x *UnionUnchecked) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Unchecked != nil, x.Unchecked, false, nil, false, nil, false)
}

type UnionUndefined struct {
	Double    *float64
	Undefined *Undefined
}

func (x *UnionUndefined) UnmarshalJSON(data []byte) error {
	x.Undefined = nil
	var c Undefined
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Undefined = &c
	}
	return nil
}

func (x *UnionUndefined) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Undefined != nil, x.Undefined, false, nil, false, nil, false)
}

type UnionUnionUnion struct {
	Double *float64
	Union  *Union
}

func (x *UnionUnionUnion) UnmarshalJSON(data []byte) error {
	x.Union = nil
	var c Union
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Union = &c
	}
	return nil
}

func (x *UnionUnionUnion) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Union != nil, x.Union, false, nil, false, nil, false)
}

type UnionUnmarshalJSON struct {
	Double              *float64
	PurpleUnmarshalJSON *UnmarshalJSON
}

func (x *UnionUnmarshalJSON) UnmarshalJSON(data []byte) error {
	x.PurpleUnmarshalJSON = nil
	var c UnmarshalJSON
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.PurpleUnmarshalJSON = &c
	}
	return nil
}

func (x *UnionUnmarshalJSON) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.PurpleUnmarshalJSON != nil, x.PurpleUnmarshalJSON, false, nil, false, nil, false)
}

type UnionUnowned struct {
	Double  *float64
	Unowned *Unowned
}

func (x *UnionUnowned) UnmarshalJSON(data []byte) error {
	x.Unowned = nil
	var c Unowned
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Unowned = &c
	}
	return nil
}

func (x *UnionUnowned) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Unowned != nil, x.Unowned, false, nil, false, nil, false)
}

type UnionUnsafe struct {
	Double *float64
	Unsafe *Unsafe
}

func (x *UnionUnsafe) UnmarshalJSON(data []byte) error {
	x.Unsafe = nil
	var c Unsafe
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Unsafe = &c
	}
	return nil
}

func (x *UnionUnsafe) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Unsafe != nil, x.Unsafe, false, nil, false, nil, false)
}

type UnionUnsigned struct {
	Double   *float64
	Unsigned *Unsigned
}

func (x *UnionUnsigned) UnmarshalJSON(data []byte) error {
	x.Unsigned = nil
	var c Unsigned
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Unsigned = &c
	}
	return nil
}

func (x *UnionUnsigned) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Unsigned != nil, x.Unsigned, false, nil, false, nil, false)
}

type UnionUseSerializers struct {
	Double         *float64
	UseSerializers *UseSerializers
}

func (x *UnionUseSerializers) UnmarshalJSON(data []byte) error {
	x.UseSerializers = nil
	var c UseSerializers
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.UseSerializers = &c
	}
	return nil
}

func (x *UnionUseSerializers) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.UseSerializers != nil, x.UseSerializers, false, nil, false, nil, false)
}

type UnionUshort struct {
	Double *float64
	Ushort *Ushort
}

func (x *UnionUshort) UnmarshalJSON(data []byte) error {
	x.Ushort = nil
	var c Ushort
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Ushort = &c
	}
	return nil
}

func (x *UnionUshort) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Ushort != nil, x.Ushort, false, nil, false, nil, false)
}

type UnionUsing struct {
	Double *float64
	Using  *Using
}

func (x *UnionUsing) UnmarshalJSON(data []byte) error {
	x.Using = nil
	var c Using
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Using = &c
	}
	return nil
}

func (x *UnionUsing) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Using != nil, x.Using, false, nil, false, nil, false)
}

type UnionUtf8JSONReader struct {
	Double         *float64
	Utf8JSONReader *Utf8JSONReader
}

func (x *UnionUtf8JSONReader) UnmarshalJSON(data []byte) error {
	x.Utf8JSONReader = nil
	var c Utf8JSONReader
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Utf8JSONReader = &c
	}
	return nil
}

func (x *UnionUtf8JSONReader) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Utf8JSONReader != nil, x.Utf8JSONReader, false, nil, false, nil, false)
}

type UnionUtf8JSONWriter struct {
	Double         *float64
	Utf8JSONWriter *Utf8JSONWriter
}

func (x *UnionUtf8JSONWriter) UnmarshalJSON(data []byte) error {
	x.Utf8JSONWriter = nil
	var c Utf8JSONWriter
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Utf8JSONWriter = &c
	}
	return nil
}

func (x *UnionUtf8JSONWriter) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Utf8JSONWriter != nil, x.Utf8JSONWriter, false, nil, false, nil, false)
}

type UnionVar struct {
	Double *float64
	Var    *Var
}

func (x *UnionVar) UnmarshalJSON(data []byte) error {
	x.Var = nil
	var c Var
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Var = &c
	}
	return nil
}

func (x *UnionVar) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Var != nil, x.Var, false, nil, false, nil, false)
}

type UnionVirtual struct {
	Double  *float64
	Virtual *Virtual
}

func (x *UnionVirtual) UnmarshalJSON(data []byte) error {
	x.Virtual = nil
	var c Virtual
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Virtual = &c
	}
	return nil
}

func (x *UnionVirtual) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Virtual != nil, x.Virtual, false, nil, false, nil, false)
}

type UnionVoid struct {
	Double *float64
	Void   *Void
}

func (x *UnionVoid) UnmarshalJSON(data []byte) error {
	x.Void = nil
	var c Void
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Void = &c
	}
	return nil
}

func (x *UnionVoid) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Void != nil, x.Void, false, nil, false, nil, false)
}

type UnionVolatile struct {
	Double   *float64
	Volatile *Volatile
}

func (x *UnionVolatile) UnmarshalJSON(data []byte) error {
	x.Volatile = nil
	var c Volatile
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Volatile = &c
	}
	return nil
}

func (x *UnionVolatile) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Volatile != nil, x.Volatile, false, nil, false, nil, false)
}

type UnionWcharT struct {
	Double *float64
	WcharT *WcharT
}

func (x *UnionWcharT) UnmarshalJSON(data []byte) error {
	x.WcharT = nil
	var c WcharT
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.WcharT = &c
	}
	return nil
}

func (x *UnionWcharT) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.WcharT != nil, x.WcharT, false, nil, false, nil, false)
}

type UnionWeak struct {
	Double *float64
	Weak   *Weak
}

func (x *UnionWeak) UnmarshalJSON(data []byte) error {
	x.Weak = nil
	var c Weak
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Weak = &c
	}
	return nil
}

func (x *UnionWeak) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Weak != nil, x.Weak, false, nil, false, nil, false)
}

type UnionWhere struct {
	Double *float64
	Where  *Where
}

func (x *UnionWhere) UnmarshalJSON(data []byte) error {
	x.Where = nil
	var c Where
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Where = &c
	}
	return nil
}

func (x *UnionWhere) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Where != nil, x.Where, false, nil, false, nil, false)
}

type UnionWhile struct {
	Double *float64
	While  *While
}

func (x *UnionWhile) UnmarshalJSON(data []byte) error {
	x.While = nil
	var c While
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.While = &c
	}
	return nil
}

func (x *UnionWhile) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.While != nil, x.While, false, nil, false, nil, false)
}

type UnionWillSet struct {
	Double  *float64
	WillSet *WillSet
}

func (x *UnionWillSet) UnmarshalJSON(data []byte) error {
	x.WillSet = nil
	var c WillSet
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.WillSet = &c
	}
	return nil
}

func (x *UnionWillSet) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.WillSet != nil, x.WillSet, false, nil, false, nil, false)
}

type UnionWith struct {
	Double *float64
	With   *With
}

func (x *UnionWith) UnmarshalJSON(data []byte) error {
	x.With = nil
	var c With
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.With = &c
	}
	return nil
}

func (x *UnionWith) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.With != nil, x.With, false, nil, false, nil, false)
}

type UnionXor struct {
	Double *float64
	Xor    *Xor
}

func (x *UnionXor) UnmarshalJSON(data []byte) error {
	x.Xor = nil
	var c Xor
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Xor = &c
	}
	return nil
}

func (x *UnionXor) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Xor != nil, x.Xor, false, nil, false, nil, false)
}

type UnionXorEq struct {
	Double *float64
	XorEq  *XorEq
}

func (x *UnionXorEq) UnmarshalJSON(data []byte) error {
	x.XorEq = nil
	var c XorEq
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.XorEq = &c
	}
	return nil
}

func (x *UnionXorEq) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.XorEq != nil, x.XorEq, false, nil, false, nil, false)
}

type UnionYES struct {
	Double *float64
	Yes    *Yes
}

func (x *UnionYES) UnmarshalJSON(data []byte) error {
	x.Yes = nil
	var c Yes
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Yes = &c
	}
	return nil
}

func (x *UnionYES) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Yes != nil, x.Yes, false, nil, false, nil, false)
}

type UnionYield struct {
	Double *float64
	Yield  *Yield
}

func (x *UnionYield) UnmarshalJSON(data []byte) error {
	x.Yield = nil
	var c Yield
	object, err := unmarshalUnion(data, nil, &x.Double, nil, nil, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.Yield = &c
	}
	return nil
}

func (x *UnionYield) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, x.Double, nil, nil, false, nil, x.Yield != nil, x.Yield, false, nil, false, nil, false)
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
