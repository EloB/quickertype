// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    #[serde(rename = "_")]
    pub empty: Option<UnionUnion>,

    #[serde(rename = "_Bool")]
    pub top_level_bool: Option<UnionBoolUnion>,

    #[serde(rename = "_Complex")]
    pub complex: Option<UnionComplex>,

    #[serde(rename = "_Imaginery")]
    pub imaginery: Option<UnionImaginery>,

    #[serde(rename = "abstract")]
    pub top_level_abstract: Option<UnionAbstract>,

    pub alignas: Option<UnionAlignas>,

    #[serde(rename = "alignof")]
    pub top_level_alignof: Option<UnionAlignof>,

    pub and: Option<UnionAnd>,

    pub and_eq: Option<UnionAndEq>,

    #[serde(rename = "any")]
    pub top_level_any: Option<UnionAnyUnion>,

    #[serde(rename = "Any")]
    pub any: Option<UnionAny>,

    pub array: Option<UnionArray>,

    #[serde(rename = "ArrayNode")]
    pub array_node: Option<UnionArrayNode>,

    #[serde(rename = "as")]
    pub top_level_as: Option<UnionAs>,

    pub asm: Option<UnionAsm>,

    pub assert: Option<UnionAssert>,

    pub associatedtype: Option<UnionAssociatedtype>,

    pub associativity: Option<UnionAssociativity>,

    #[serde(rename = "async")]
    pub top_level_async: Option<UnionAsync>,

    pub atomic: Option<UnionAtomic>,

    pub atomic_cancel: Option<UnionAtomicCancel>,

    pub atomic_commit: Option<UnionAtomicCommit>,

    pub atomic_noexcept: Option<UnionAtomicNoexcept>,

    pub auto: Option<UnionAuto>,

    pub await: Option<UnionAwait>,

    pub base: Option<UnionBase>,

    pub bitand: Option<UnionBitand>,

    pub bitor: Option<UnionBitor>,

    #[serde(rename = "BOOL")]
    pub bool: Option<UnionBool>,

    #[serde(rename = "bool")]
    pub purple_bool: Option<TopLevelUnionBool>,

    pub boolean: Option<UnionBoolean>,

    #[serde(rename = "BooleanNode")]
    pub boolean_node: Option<UnionBooleanNode>,

    #[serde(rename = "break")]
    pub top_level_break: Option<UnionBreak>,

    pub bycopy: Option<UnionBycopy>,

    pub byref: Option<UnionByref>,

    pub byte: Option<UnionByte>,

    #[serde(rename = "Calendar")]
    pub calendar: Option<UnionCalendar>,

    pub case: Option<UnionCase>,

    #[serde(rename = "catch")]
    pub top_level_catch: Option<UnionCatch>,

    pub chan: Option<UnionChan>,

    pub char: Option<UnionChar>,

    pub char16_t: Option<UnionChar16T>,

    pub char32_t: Option<UnionChar32T>,

    pub checked: Option<UnionChecked>,

    #[serde(rename = "class")]
    pub top_level_class: Option<UnionClassUnion>,

    #[serde(rename = "Class")]
    pub class: Option<UnionClass>,

    pub clone: Option<UnionClone>,

    pub co_await: Option<UnionCoAwait>,

    pub co_return: Option<UnionCoReturn>,

    pub co_yield: Option<UnionCoYield>,

    #[serde(rename = "Codable")]
    pub codable: Option<UnionCodable>,

    #[serde(rename = "CodingKey")]
    pub coding_key: Option<UnionCodingKey>,

    #[serde(rename = "CodingKeys")]
    pub coding_keys: Option<UnionCodingKeys>,

    pub compl: Option<UnionCompl>,

    pub concept: Option<UnionConcept>,

    pub console: Option<UnionConsole>,

    #[serde(rename = "const")]
    pub top_level_const: Option<UnionConst>,

    pub const_cast: Option<UnionConstCast>,

    pub constexpr: Option<UnionConstexpr>,

    pub constructor: Option<UnionConstructor>,

    #[serde(rename = "continue")]
    pub top_level_continue: Option<UnionContinue>,

    pub convenience: Option<UnionConvenience>,

    pub convert: Option<UnionConvert>,

    pub converter: Option<UnionConverter>,

    #[serde(rename = "CultureInfo")]
    pub culture_info: Option<UnionCultureInfo>,

    pub date: Option<UnionDate>,

    pub date_parse_handling: Option<UnionDateParseHandling>,

    #[serde(rename = "DateFormatter")]
    pub date_formatter: Option<UnionDateFormatter>,

    #[serde(rename = "DateOnly")]
    pub date_only: Option<UnionDateOnly>,

    #[serde(rename = "DateOnlyConverter")]
    pub date_only_converter: Option<UnionDateOnlyConverter>,

    #[serde(rename = "DateTime")]
    pub date_time: Option<UnionDateTime>,

    #[serde(rename = "DateTimeStyles")]
    pub date_time_styles: Option<UnionDateTimeStyles>,

    pub debugger: Option<UnionDebugger>,

    pub decimal: Option<UnionDecimal>,

    pub declare: Option<UnionDeclare>,

    pub decltype: Option<UnionDecltype>,

    pub decode_string: Option<UnionDecodeString>,

    #[serde(rename = "Decoder")]
    pub decoder: Option<UnionDecoder>,

    #[serde(rename = "DecodingError")]
    pub decoding_error: Option<UnionDecodingError>,

    pub def: Option<UnionDef>,

    #[serde(rename = "default")]
    pub top_level_default: Option<UnionDefault>,

    pub defer: Option<UnionDefer>,

    pub deinit: Option<UnionDeinit>,

    pub del: Option<UnionDel>,

    pub delegate: Option<UnionDelegate>,

    pub delete: Option<UnionDelete>,

    #[serde(rename = "DeserializationFeature")]
    pub deserialization_feature: Option<UnionDeserializationFeature>,

    pub dict: Option<UnionDict>,

    pub dictionary: Option<UnionDictionary>,

    #[serde(rename = "didSet")]
    pub did_set: Option<UnionDidSet>,

    #[serde(rename = "do")]
    pub top_level_do: Option<UnionDo>,

    pub double: Option<UnionDouble>,

    #[serde(rename = "DoubleNode")]
    pub double_node: Option<UnionDoubleNode>,

    pub dummy: Option<f64>,

    pub dynamic: Option<UnionDynamic>,

    pub dynamic_cast: Option<UnionDynamicCast>,

    pub elif: Option<UnionElif>,

    #[serde(rename = "else")]
    pub top_level_else: Option<UnionElse>,

    pub encode_quick_type: Option<UnionEncodeQuickType>,

    #[serde(rename = "Encoder")]
    pub encoder: Option<UnionEncoder>,

    #[serde(rename = "enum")]
    pub top_level_enum: Option<UnionEnum>,

    #[serde(rename = "EnumValues")]
    pub enum_values: Option<UnionEnumValues>,

    #[serde(rename = "equalityContract")]
    pub equality_contract: Option<UnionEqualityContract>,

    #[serde(rename = "Equatable")]
    pub equatable: Option<UnionEquatable>,

    pub event: Option<UnionEvent>,

    pub except: Option<UnionExcept>,

    pub exception: Option<UnionException>,

    pub explicit: Option<UnionExplicit>,

    pub export: Option<UnionExport>,

    pub exposing: Option<UnionExposing>,

    pub extends: Option<UnionExtends>,

    pub extension: Option<UnionExtension>,

    #[serde(rename = "extern")]
    pub top_level_extern: Option<UnionExtern>,

    pub fallthrough: Option<UnionFallthrough>,

    #[serde(rename = "false")]
    pub purple_false: Option<UnionFalseUnion>,

    #[serde(rename = "False")]
    pub top_level_false: Option<UnionFalse>,

    pub fileprivate: Option<UnionFileprivate>,

    #[serde(rename = "final")]
    pub top_level_final: Option<UnionFinal>,

    pub finally: Option<UnionFinally>,

    pub fixed: Option<UnionFixed>,

    pub float: Option<UnionFloat>,

    #[serde(rename = "for")]
    pub top_level_for: Option<UnionFor>,

    pub foreach: Option<UnionForeach>,

    #[serde(rename = "FormatException")]
    pub format_exception: Option<UnionFormatException>,

    pub friend: Option<UnionFriend>,

    pub from: Option<UnionFrom>,

    pub from_dict: Option<UnionFromDict>,

    pub from_json: Option<UnionFromJson>,

    pub func: Option<UnionFunc>,

    pub function: Option<UnionFunction>,

    pub get: Option<UnionGet>,

    pub global: Option<UnionGlobal>,

    pub go: Option<UnionGo>,

    pub goto: Option<UnionGoto>,

    pub guard: Option<UnionGuard>,

    #[serde(rename = "Hashable")]
    pub hashable: Option<UnionHashable>,

    #[serde(rename = "hashCode")]
    pub hash_code: Option<UnionHashCode>,

    #[serde(rename = "Hasher")]
    pub hasher: Option<UnionHasher>,

    #[serde(rename = "hasOwnProperty")]
    pub has_own_property: Option<UnionHasOwnProperty>,

    pub id: Option<UnionId>,

    #[serde(rename = "if")]
    pub top_level_if: Option<UnionIf>,

    #[serde(rename = "IMP")]
    pub imp: Option<UnionImp>,

    pub implements: Option<UnionImplements>,

    pub implicit: Option<UnionImplicit>,

    pub import: Option<UnionImport>,

    #[serde(rename = "in")]
    pub top_level_in: Option<UnionIn>,

    pub indirect: Option<UnionIndirect>,

    pub infix: Option<UnionInfix>,

    pub init: Option<UnionInit>,

    pub inline: Option<UnionInline>,

    pub inout: Option<UnionInout>,

    pub instanceof: Option<UnionInstanceof>,

    pub int: Option<UnionInt>,

    pub interface: Option<UnionInterface>,

    pub internal: Option<UnionInternal>,

    #[serde(rename = "IntNode")]
    pub int_node: Option<UnionIntNode>,

    pub is: Option<UnionIs>,

    #[serde(rename = "IsoDateTimeOffsetConverter")]
    pub iso_date_time_offset_converter: Option<UnionIsoDateTimeOffsetConverter>,

    pub iterable: Option<UnionIterable>,

    pub jdec: Option<UnionJdec>,

    pub jenc: Option<UnionJenc>,

    pub jpipe: Option<UnionJpipe>,

    pub json: Option<UnionJson>,

    pub json_converter: Option<UnionJsonConverter>,

    pub json_serializer: Option<UnionJsonSerializer>,

    pub json_token: Option<UnionJsonToken>,

    pub json_writer: Option<UnionJsonWriter>,

    #[serde(rename = "JSONAny")]
    pub json_any: Option<UnionJsonAny>,

    #[serde(rename = "JSONCodingKey")]
    pub json_coding_key: Option<UnionJsonCodingKey>,

    #[serde(rename = "JSONDecoder")]
    pub json_decoder: Option<UnionJsonDecoder>,

    #[serde(rename = "JSONEncoder")]
    pub json_encoder: Option<UnionJsonEncoder>,

    #[serde(rename = "JsonException")]
    pub json_exception: Option<UnionJsonException>,

    #[serde(rename = "JsonGenerator")]
    pub json_generator: Option<UnionJsonGenerator>,

    #[serde(rename = "JsonNode")]
    pub json_node: Option<UnionJsonNode>,

    #[serde(rename = "JSONNull")]
    pub json_null: Option<UnionJsonNull>,

    #[serde(rename = "JsonParser")]
    pub json_parser: Option<UnionJsonParser>,

    #[serde(rename = "JsonReader")]
    pub json_reader: Option<UnionJsonReader>,

    #[serde(rename = "JsonTokenType")]
    pub json_token_type: Option<UnionJsonTokenType>,

    #[serde(rename = "KSerializer")]
    pub k_serializer: Option<UnionKSerializer>,

    pub lambda: Option<UnionLambda>,

    pub lazy: Option<UnionLazy>,

    pub left: Option<UnionLeft>,

    #[serde(rename = "let")]
    pub top_level_let: Option<UnionLet>,

    pub list: Option<UnionList>,

    #[serde(rename = "LocalDate")]
    pub local_date: Option<UnionLocalDate>,

    #[serde(rename = "Locale")]
    pub locale: Option<UnionLocale>,

    pub lock: Option<UnionLock>,

    pub long: Option<UnionLong>,

    #[serde(rename = "LongNode")]
    pub long_node: Option<UnionLongNode>,

    pub map: Option<UnionMap>,

    #[serde(rename = "MapEntry")]
    pub map_entry: Option<UnionMapEntry>,

    #[serde(rename = "MarshalJSON")]
    pub marshal_json: Option<UnionMarshalJson>,

    pub metadata_property_handling: Option<UnionMetadataPropertyHandling>,

    pub module: Option<UnionModule>,

    pub mutable: Option<UnionMutable>,

    pub mutating: Option<UnionMutating>,

    pub namespace: Option<UnionNamespace>,

    pub native: Option<UnionNative>,

    pub new: Option<UnionNew>,

    pub newtonsoft: Option<UnionNewtonsoft>,

    pub nil: Option<UnionNil>,

    #[serde(rename = "NO")]
    pub no: Option<UnionNo>,

    pub noexcept: Option<UnionNoexcept>,

    pub nonatomic: Option<UnionNonatomic>,

    #[serde(rename = "none")]
    pub top_level_none: Option<UnionNoneUnion>,

    #[serde(rename = "None")]
    pub none: Option<UnionNone>,

    pub nonlocal: Option<UnionNonlocal>,

    pub nonmutating: Option<UnionNonmutating>,

    #[serde(rename = "noSuchMethod")]
    pub no_such_method: Option<UnionNoSuchMethod>,

    pub not: Option<UnionNot>,

    pub not_eq: Option<UnionNotEq>,

    #[serde(rename = "NSError")]
    pub ns_error: Option<UnionNsError>,

    #[serde(rename = "NSObject")]
    pub ns_object: Option<UnionNsObject>,

    #[serde(rename = "NSString")]
    pub ns_string: Option<UnionNsString>,

    #[serde(rename = "NULL")]
    pub null: Option<UnionNull>,

    #[serde(rename = "null")]
    pub top_level_null: Option<UnionNullUnion>,

    #[serde(rename = "NullNode")]
    pub null_node: Option<UnionNullNode>,

    pub nullptr: Option<UnionNullptr>,

    pub number: Option<UnionNumber>,

    pub object: Option<UnionObject>,

    #[serde(rename = "ObjectMapper")]
    pub object_mapper: Option<UnionObjectMapper>,

    #[serde(rename = "ObjectNode")]
    pub object_node: Option<UnionObjectNode>,

    #[serde(rename = "ObjectReader")]
    pub object_reader: Option<UnionObjectReader>,

    #[serde(rename = "ObjectWriter")]
    pub object_writer: Option<UnionObjectWriter>,

    pub of: Option<UnionOf>,

    #[serde(rename = "OffsetDateTime")]
    pub offset_date_time: Option<UnionOffsetDateTime>,

    #[serde(rename = "OffsetTime")]
    pub offset_time: Option<UnionOffsetTime>,

    pub oneway: Option<UnionOneway>,

    pub open: Option<UnionOpen>,

    pub operator: Option<UnionOperator>,

    pub optional: Option<UnionOptional>,

    pub or: Option<UnionOr>,

    pub or_eq: Option<UnionOrEq>,

    pub out: Option<UnionOut>,

    #[serde(rename = "override")]
    pub top_level_override: Option<UnionOverride>,

    pub package: Option<UnionPackage>,

    pub params: Option<UnionParams>,

    pub pass: Option<UnionPass>,

    pub port: Option<UnionPort>,

    pub postfix: Option<UnionPostfix>,

    pub precedence: Option<UnionPrecedence>,

    pub prefix: Option<UnionPrefix>,

    #[serde(rename = "PrimitiveKind")]
    pub primitive_kind: Option<UnionPrimitiveKind>,

    pub print: Option<UnionPrint>,

    pub printf: Option<UnionPrintf>,

    #[serde(rename = "printMembers")]
    pub print_members: Option<UnionPrintMembers>,

    pub private: Option<UnionPrivate>,

    pub protected: Option<UnionProtected>,

    #[serde(rename = "Protocol")]
    pub protocol: Option<UnionProtocol>,

    #[serde(rename = "protocol")]
    pub top_level_protocol: Option<UnionProtocolUnion>,

    pub public: Option<UnionPublic>,

    pub quicktype: Option<UnionQuicktype>,

    pub raise: Option<UnionRaise>,

    pub range: Option<UnionRange>,

    pub readonly: Option<UnionReadonly>,

    #[serde(rename = "ref")]
    pub top_level_ref: Option<UnionRef>,

    #[serde(rename = "RegExp")]
    pub reg_exp: Option<UnionRegExp>,

    pub register: Option<UnionRegister>,

    pub reinterpret_cast: Option<UnionReinterpretCast>,

    pub repeat: Option<UnionRepeat>,

    pub require: Option<UnionRequire>,

    pub required: Option<UnionRequired>,

    pub requires: Option<UnionRequires>,

    pub restrict: Option<UnionRestrict>,

    pub retain: Option<UnionRetain>,

    pub rethrows: Option<UnionRethrows>,

    #[serde(rename = "return")]
    pub top_level_return: Option<UnionReturn>,

    pub right: Option<UnionRight>,

    #[serde(rename = "runtimeType")]
    pub runtime_type: Option<UnionRuntimeType>,

    pub s: Option<UnionS>,

    pub sbyte: Option<UnionSbyte>,

    pub sealed: Option<UnionSealed>,

    #[serde(rename = "SEL")]
    pub sel: Option<UnionSel>,

    pub select: Option<UnionSelect>,

    #[serde(rename = "Self")]
    pub top_level_self: Option<UnionSelf>,

    #[serde(rename = "self")]
    pub purple_self: Option<UnionSelfUnion>,

    #[serde(rename = "Sendable")]
    pub sendable: Option<UnionSendable>,

    #[serde(rename = "SerialDescriptor")]
    pub serial_descriptor: Option<UnionSerialDescriptor>,

    #[serde(rename = "Serializable")]
    pub serializable: Option<UnionSerializable>,

    #[serde(rename = "SerializationFeature")]
    pub serialization_feature: Option<UnionSerializationFeature>,

    pub serialize: Option<UnionSerialize>,

    #[serde(rename = "SerializerProvider")]
    pub serializer_provider: Option<UnionSerializerProvider>,

    #[serde(rename = "SerialName")]
    pub serial_name: Option<UnionSerialName>,

    pub set: Option<UnionSet>,

    pub short: Option<UnionShort>,

    pub signed: Option<UnionSigned>,

    #[serde(rename = "SimpleModule")]
    pub simple_module: Option<UnionSimpleModule>,

    #[serde(rename = "sizeof")]
    pub top_level_sizeof: Option<UnionSizeof>,

    pub stackalloc: Option<UnionStackalloc>,

    #[serde(rename = "Standards")]
    pub standards: Option<UnionStandards>,

    #[serde(rename = "static")]
    pub top_level_static: Option<UnionStatic>,

    pub static_assert: Option<UnionStaticAssert>,

    pub static_cast: Option<UnionStaticCast>,

    #[serde(rename = "StdDeserializer")]
    pub std_deserializer: Option<UnionStdDeserializer>,

    #[serde(rename = "StdSerializer")]
    pub std_serializer: Option<UnionStdSerializer>,

    pub strictfp: Option<UnionStrictfp>,

    pub string: Option<UnionString>,

    #[serde(rename = "struct")]
    pub top_level_struct: Option<UnionStruct>,

    pub subscript: Option<UnionSubscript>,

    #[serde(rename = "super")]
    pub top_level_super: Option<UnionSuper>,

    pub switch: Option<UnionSwitch>,

    pub symbol: Option<UnionSymbol>,

    pub synchronized: Option<UnionSynchronized>,

    pub system: Option<UnionSystem>,

    pub template: Option<UnionTemplate>,

    #[serde(rename = "TextNode")]
    pub text_node: Option<UnionTextNode>,

    pub then: Option<UnionThen>,

    pub this: Option<UnionThis>,

    pub thread_local: Option<UnionThreadLocal>,

    pub throw: Option<UnionThrow>,

    pub throws: Option<UnionThrows>,

    #[serde(rename = "TimeOnly")]
    pub time_only: Option<UnionTimeOnly>,

    #[serde(rename = "TimeOnlyConverter")]
    pub time_only_converter: Option<UnionTimeOnlyConverter>,

    #[serde(rename = "TimeZone")]
    pub time_zone: Option<UnionTimeZone>,

    pub to_dict: Option<UnionToDict>,

    pub to_json: Option<UnionToJson>,

    pub top_level: Option<UnionTopLevel>,

    #[serde(rename = "toString")]
    pub to_string: Option<UnionToString>,

    pub transient: Option<UnionTransient>,

    #[serde(rename = "True")]
    pub top_level_true: Option<UnionTrue>,

    #[serde(rename = "true")]
    pub purple_true: Option<UnionTrueUnion>,

    pub try: Option<UnionTry>,

    #[serde(rename = "Type")]
    pub top_level_type: Option<UnionType>,

    #[serde(rename = "type")]
    pub purple_type: Option<UnionTypeUnion>,

    pub typealias: Option<UnionTypealias>,

    pub typedef: Option<UnionTypedef>,

    pub typeid: Option<UnionTypeid>,

    pub typename: Option<UnionTypename>,

    #[serde(rename = "typeof")]
    pub top_level_typeof: Option<UnionTypeof>,

    pub uint: Option<UnionUint>,

    pub ulong: Option<UnionUlong>,

    pub unchecked: Option<UnionUnchecked>,

    pub undefined: Option<UnionUndefined>,

    #[serde(rename = "union")]
    pub top_level_union: Option<UnionUnionUnion>,

    #[serde(rename = "UnmarshalJSON")]
    pub unmarshal_json: Option<UnionUnmarshalJson>,

    pub unowned: Option<UnionUnowned>,

    #[serde(rename = "unsafe")]
    pub top_level_unsafe: Option<UnionUnsafe>,

    pub unsigned: Option<UnionUnsigned>,

    #[serde(rename = "UseSerializers")]
    pub use_serializers: Option<UnionUseSerializers>,

    pub ushort: Option<UnionUshort>,

    pub using: Option<UnionUsing>,

    #[serde(rename = "Utf8JsonReader")]
    pub utf8_json_reader: Option<UnionUtf8JsonReader>,

    #[serde(rename = "Utf8JsonWriter")]
    pub utf8_json_writer: Option<UnionUtf8JsonWriter>,

    #[serde(rename = "UUID")]
    pub uuid: Option<UnionUuid>,

    pub var: Option<UnionVar>,

    #[serde(rename = "virtual")]
    pub top_level_virtual: Option<UnionVirtual>,

    pub void: Option<UnionVoid>,

    pub volatile: Option<UnionVolatile>,

    pub wchar_t: Option<UnionWcharT>,

    pub weak: Option<UnionWeak>,

    #[serde(rename = "where")]
    pub top_level_where: Option<UnionWhere>,

    #[serde(rename = "while")]
    pub top_level_while: Option<UnionWhile>,

    #[serde(rename = "willSet")]
    pub will_set: Option<UnionWillSet>,

    pub with: Option<UnionWith>,

    pub xor: Option<UnionXor>,

    pub xor_eq: Option<UnionXorEq>,

    #[serde(rename = "YES")]
    pub yes: Option<UnionYes>,

    #[serde(rename = "yield")]
    pub top_level_yield: Option<UnionYield>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAlignas {
    Alignas(Alignas),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alignas {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAnd {
    And(And),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct And {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAndEq {
    AndEq(AndEq),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AndEq {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAny {
    Any(Any),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Any {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionArray {
    Array(Array),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Array {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionArrayNode {
    ArrayNode(ArrayNode),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ArrayNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAsm {
    Asm(Asm),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Asm {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAssert {
    Assert(Assert),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Assert {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAssociatedtype {
    Associatedtype(Associatedtype),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Associatedtype {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAssociativity {
    Associativity(Associativity),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Associativity {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAtomic {
    Atomic(Atomic),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Atomic {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAtomicCancel {
    AtomicCancel(AtomicCancel),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicCancel {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAtomicCommit {
    AtomicCommit(AtomicCommit),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicCommit {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAtomicNoexcept {
    AtomicNoexcept(AtomicNoexcept),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicNoexcept {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAuto {
    Auto(Auto),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Auto {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAwait {
    Await(Await),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Await {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBase {
    Base(Base),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Base {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBitand {
    Bitand(Bitand),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bitand {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBitor {
    Bitor(Bitor),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bitor {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBool {
    Bool(Bool),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bool {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBoolean {
    Boolean(Boolean),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Boolean {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBooleanNode {
    BooleanNode(BooleanNode),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BooleanNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBycopy {
    Bycopy(Bycopy),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bycopy {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionByref {
    Byref(Byref),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Byref {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionByte {
    Byte(Byte),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Byte {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCalendar {
    Calendar(Calendar),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Calendar {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCase {
    Case(Case),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Case {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionChan {
    Chan(Chan),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Chan {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionChar {
    Char(Char),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionChar16T {
    Char16T(Char16T),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char16T {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionChar32T {
    Char32T(Char32T),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char32T {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionChecked {
    Checked(Checked),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Checked {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionClass {
    Class(Class),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Class {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionClone {
    Clone(Clone),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Clone {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCoAwait {
    CoAwait(CoAwait),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoAwait {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCoReturn {
    CoReturn(CoReturn),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoReturn {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCoYield {
    CoYield(CoYield),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoYield {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCodable {
    Codable(Codable),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Codable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCodingKey {
    CodingKey(CodingKey),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CodingKey {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCodingKeys {
    CodingKeys(CodingKeys),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CodingKeys {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCompl {
    Compl(Compl),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Compl {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionComplex {
    Complex(Complex),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Complex {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConcept {
    Concept(Concept),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Concept {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConsole {
    Console(Console),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Console {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConstCast {
    ConstCast(ConstCast),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConstCast {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConstexpr {
    Constexpr(Constexpr),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Constexpr {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConstructor {
    Constructor(Constructor),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Constructor {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConvenience {
    Convenience(Convenience),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Convenience {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConvert {
    Convert(Convert),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Convert {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConverter {
    Converter(Converter),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Converter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCultureInfo {
    CultureInfo(CultureInfo),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CultureInfo {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDate {
    Date(Date),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Date {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateFormatter {
    DateFormatter(DateFormatter),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateFormatter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateOnly {
    DateOnly(DateOnly),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateOnly {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateOnlyConverter {
    DateOnlyConverter(DateOnlyConverter),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateOnlyConverter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateParseHandling {
    DateParseHandling(DateParseHandling),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateParseHandling {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateTime {
    DateTime(DateTime),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateTime {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDateTimeStyles {
    DateTimeStyles(DateTimeStyles),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateTimeStyles {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDebugger {
    Debugger(Debugger),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Debugger {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDecimal {
    Decimal(Decimal),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Decimal {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDeclare {
    Declare(Declare),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Declare {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDecltype {
    Decltype(Decltype),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Decltype {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDecodeString {
    DecodeString(DecodeString),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DecodeString {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDecoder {
    Decoder(Decoder),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Decoder {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDecodingError {
    DecodingError(DecodingError),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DecodingError {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDef {
    Def(Def),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Def {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDefer {
    Defer(Defer),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Defer {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDeinit {
    Deinit(Deinit),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Deinit {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDel {
    Del(Del),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Del {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDelegate {
    Delegate(Delegate),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Delegate {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDelete {
    Delete(Delete),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Delete {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDeserializationFeature {
    DeserializationFeature(DeserializationFeature),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeserializationFeature {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDict {
    Dict(Dict),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dict {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDictionary {
    Dictionary(Dictionary),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dictionary {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDidSet {
    DidSet(DidSet),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DidSet {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDouble {
    Double(f64),

    PurpleDouble(Double),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Double {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDoubleNode {
    Double(f64),

    DoubleNode(DoubleNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DoubleNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDynamic {
    Double(f64),

    Dynamic(Dynamic),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dynamic {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDynamicCast {
    Double(f64),

    DynamicCast(DynamicCast),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DynamicCast {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionElif {
    Double(f64),

    Elif(Elif),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Elif {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnion {
    Double(f64),

    Empty(Empty),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Empty {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEncodeQuickType {
    Double(f64),

    EncodeQuickType(EncodeQuickType),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EncodeQuickType {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEncoder {
    Double(f64),

    Encoder(Encoder),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Encoder {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEnumValues {
    Double(f64),

    EnumValues(EnumValues),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EnumValues {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEqualityContract {
    Double(f64),

    EqualityContract(EqualityContract),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EqualityContract {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEquatable {
    Double(f64),

    Equatable(Equatable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Equatable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEvent {
    Double(f64),

    Event(Event),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Event {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExcept {
    Double(f64),

    Except(Except),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Except {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionException {
    Double(f64),

    Exception(Exception),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Exception {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExplicit {
    Double(f64),

    Explicit(Explicit),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Explicit {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExport {
    Double(f64),

    Export(Export),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Export {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExposing {
    Double(f64),

    Exposing(Exposing),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Exposing {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExtends {
    Double(f64),

    Extends(Extends),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extends {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExtension {
    Double(f64),

    Extension(Extension),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extension {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFallthrough {
    Double(f64),

    Fallthrough(Fallthrough),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fallthrough {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFileprivate {
    Double(f64),

    Fileprivate(Fileprivate),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fileprivate {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFinally {
    Double(f64),

    Finally(Finally),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Finally {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFixed {
    Double(f64),

    Fixed(Fixed),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fixed {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFloat {
    Double(f64),

    Float(Float),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Float {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionForeach {
    Double(f64),

    Foreach(Foreach),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Foreach {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFormatException {
    Double(f64),

    FormatException(FormatException),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FormatException {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFriend {
    Double(f64),

    Friend(Friend),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Friend {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFrom {
    Double(f64),

    From(From),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct From {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFromDict {
    Double(f64),

    FromDict(FromDict),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FromDict {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFromJson {
    Double(f64),

    FromJson(FromJson),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FromJson {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFunc {
    Double(f64),

    Func(Func),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Func {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFunction {
    Double(f64),

    Function(Function),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Function {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionGet {
    Double(f64),

    Get(Get),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Get {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionGlobal {
    Double(f64),

    Global(Global),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Global {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionGo {
    Double(f64),

    Go(Go),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Go {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionGoto {
    Double(f64),

    Goto(Goto),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Goto {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionGuard {
    Double(f64),

    Guard(Guard),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Guard {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionHasOwnProperty {
    Double(f64),

    HasOwnProperty(HasOwnProperty),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HasOwnProperty {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionHashCode {
    Double(f64),

    HashCode(HashCode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HashCode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionHashable {
    Double(f64),

    Hashable(Hashable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Hashable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionHasher {
    Double(f64),

    Hasher(Hasher),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Hasher {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionId {
    Double(f64),

    Id(Id),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Id {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionImaginery {
    Double(f64),

    Imaginery(Imaginery),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Imaginery {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionImp {
    Double(f64),

    Imp(Imp),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Imp {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionImplements {
    Double(f64),

    Implements(Implements),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Implements {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionImplicit {
    Double(f64),

    Implicit(Implicit),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Implicit {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionImport {
    Double(f64),

    Import(Import),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Import {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIndirect {
    Double(f64),

    Indirect(Indirect),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Indirect {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInfix {
    Double(f64),

    Infix(Infix),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Infix {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInit {
    Double(f64),

    Init(Init),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Init {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInline {
    Double(f64),

    Inline(Inline),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Inline {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInout {
    Double(f64),

    Inout(Inout),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Inout {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInstanceof {
    Double(f64),

    Instanceof(Instanceof),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Instanceof {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInt {
    Double(f64),

    Int(Int),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Int {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIntNode {
    Double(f64),

    IntNode(IntNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IntNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInterface {
    Double(f64),

    Interface(Interface),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Interface {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionInternal {
    Double(f64),

    Internal(Internal),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Internal {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIs {
    Double(f64),

    Is(Is),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Is {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIsoDateTimeOffsetConverter {
    Double(f64),

    IsoDateTimeOffsetConverter(IsoDateTimeOffsetConverter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IsoDateTimeOffsetConverter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIterable {
    Double(f64),

    Iterable(Iterable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Iterable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJdec {
    Double(f64),

    Jdec(Jdec),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jdec {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJenc {
    Double(f64),

    Jenc(Jenc),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jenc {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJpipe {
    Double(f64),

    Jpipe(Jpipe),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jpipe {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJson {
    Double(f64),

    Json(Json),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Json {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonAny {
    Double(f64),

    JsonAny(JsonAny),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonAny {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonCodingKey {
    Double(f64),

    JsonCodingKey(JsonCodingKey),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonCodingKey {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonConverter {
    Double(f64),

    JsonConverter(JsonConverter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonConverter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonDecoder {
    Double(f64),

    JsonDecoder(JsonDecoder),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonDecoder {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonEncoder {
    Double(f64),

    JsonEncoder(JsonEncoder),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonEncoder {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonException {
    Double(f64),

    JsonException(JsonException),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonException {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonGenerator {
    Double(f64),

    JsonGenerator(JsonGenerator),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonGenerator {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonNode {
    Double(f64),

    JsonNode(JsonNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonNull {
    Double(f64),

    JsonNull(JsonNull),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonNull {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonParser {
    Double(f64),

    JsonParser(JsonParser),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonParser {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonReader {
    Double(f64),

    JsonReader(JsonReader),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonReader {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonSerializer {
    Double(f64),

    JsonSerializer(JsonSerializer),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonSerializer {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonToken {
    Double(f64),

    JsonToken(JsonToken),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonToken {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonTokenType {
    Double(f64),

    JsonTokenType(JsonTokenType),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonTokenType {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionJsonWriter {
    Double(f64),

    JsonWriter(JsonWriter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonWriter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionKSerializer {
    Double(f64),

    KSerializer(KSerializer),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KSerializer {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLambda {
    Double(f64),

    Lambda(Lambda),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lambda {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLazy {
    Double(f64),

    Lazy(Lazy),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lazy {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLeft {
    Double(f64),

    Left(Left),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Left {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionList {
    Double(f64),

    List(List),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct List {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLocalDate {
    Double(f64),

    LocalDate(LocalDate),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LocalDate {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLocale {
    Double(f64),

    Locale(Locale),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Locale {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLock {
    Double(f64),

    Lock(Lock),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lock {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLong {
    Double(f64),

    Long(Long),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Long {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLongNode {
    Double(f64),

    LongNode(LongNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LongNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMap {
    Double(f64),

    Map(Map),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Map {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMapEntry {
    Double(f64),

    MapEntry(MapEntry),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MapEntry {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMarshalJson {
    Double(f64),

    MarshalJson(MarshalJson),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MarshalJson {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMetadataPropertyHandling {
    Double(f64),

    MetadataPropertyHandling(MetadataPropertyHandling),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MetadataPropertyHandling {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionModule {
    Double(f64),

    Module(Module),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Module {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMutable {
    Double(f64),

    Mutable(Mutable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Mutable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionMutating {
    Double(f64),

    Mutating(Mutating),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Mutating {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNamespace {
    Double(f64),

    Namespace(Namespace),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Namespace {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNative {
    Double(f64),

    Native(Native),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Native {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNew {
    Double(f64),

    New(New),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct New {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNewtonsoft {
    Double(f64),

    Newtonsoft(Newtonsoft),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Newtonsoft {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNil {
    Double(f64),

    Nil(Nil),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nil {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNo {
    Double(f64),

    No(No),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct No {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNoSuchMethod {
    Double(f64),

    NoSuchMethod(NoSuchMethod),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NoSuchMethod {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNoexcept {
    Double(f64),

    Noexcept(Noexcept),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Noexcept {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNonatomic {
    Double(f64),

    Nonatomic(Nonatomic),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonatomic {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNone {
    Double(f64),

    NoneClass(NoneClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NoneClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNonlocal {
    Double(f64),

    Nonlocal(Nonlocal),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonlocal {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNonmutating {
    Double(f64),

    Nonmutating(Nonmutating),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonmutating {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNot {
    Double(f64),

    Not(Not),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Not {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNotEq {
    Double(f64),

    NotEq(NotEq),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NotEq {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNsError {
    Double(f64),

    NsError(NsError),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NsError {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNsObject {
    Double(f64),

    NsObject(NsObject),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NsObject {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNsString {
    Double(f64),

    NsString(NsString),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NsString {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNull {
    Double(f64),

    Null(Null),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Null {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNullNode {
    Double(f64),

    NullNode(NullNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NullNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNullptr {
    Double(f64),

    Nullptr(Nullptr),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nullptr {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNumber {
    Double(f64),

    Number(Number),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Number {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionObject {
    Double(f64),

    Object(Object),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Object {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionObjectMapper {
    Double(f64),

    ObjectMapper(ObjectMapper),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectMapper {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionObjectNode {
    Double(f64),

    ObjectNode(ObjectNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionObjectReader {
    Double(f64),

    ObjectReader(ObjectReader),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectReader {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionObjectWriter {
    Double(f64),

    ObjectWriter(ObjectWriter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectWriter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOf {
    Double(f64),

    Of(Of),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Of {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOffsetDateTime {
    Double(f64),

    OffsetDateTime(OffsetDateTime),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OffsetDateTime {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOffsetTime {
    Double(f64),

    OffsetTime(OffsetTime),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OffsetTime {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOneway {
    Double(f64),

    Oneway(Oneway),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Oneway {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOpen {
    Double(f64),

    Open(Open),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Open {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOperator {
    Double(f64),

    Operator(Operator),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Operator {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOptional {
    Double(f64),

    Optional(Optional),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Optional {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOr {
    Double(f64),

    Or(Or),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Or {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOrEq {
    Double(f64),

    OrEq(OrEq),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OrEq {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOut {
    Double(f64),

    Out(Out),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Out {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPackage {
    Double(f64),

    Package(Package),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Package {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionParams {
    Double(f64),

    Params(Params),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Params {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPass {
    Double(f64),

    Pass(Pass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPort {
    Double(f64),

    Port(Port),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Port {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPostfix {
    Double(f64),

    Postfix(Postfix),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Postfix {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrecedence {
    Double(f64),

    Precedence(Precedence),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Precedence {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrefix {
    Double(f64),

    Prefix(Prefix),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Prefix {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrimitiveKind {
    Double(f64),

    PrimitiveKind(PrimitiveKind),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PrimitiveKind {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrint {
    Double(f64),

    Print(Print),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Print {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrintMembers {
    Double(f64),

    PrintMembers(PrintMembers),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PrintMembers {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrintf {
    Double(f64),

    Printf(Printf),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Printf {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPrivate {
    Double(f64),

    Private(Private),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Private {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionProtected {
    Double(f64),

    Protected(Protected),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Protected {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionProtocol {
    Double(f64),

    Protocol(Protocol),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Protocol {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionPublic {
    Double(f64),

    Public(Public),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Public {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TopLevelUnionBool {
    Double(f64),

    UnionBoolBool(UnionBoolBool),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnionBoolBool {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFalseUnion {
    Double(f64),

    FalseClass(FalseClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FalseClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSelfUnion {
    Double(f64),

    UnionSelfSelf(UnionSelfSelf),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnionSelfSelf {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTrueUnion {
    Double(f64),

    TrueClass(TrueClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TrueClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypeUnion {
    Double(f64),

    TypeClass(TypeClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TypeClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionQuicktype {
    Double(f64),

    Quicktype(Quicktype),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Quicktype {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRaise {
    Double(f64),

    Raise(Raise),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Raise {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRange {
    Double(f64),

    Range(Range),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Range {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionReadonly {
    Double(f64),

    Readonly(Readonly),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Readonly {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRegExp {
    Double(f64),

    RegExp(RegExp),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RegExp {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRegister {
    Double(f64),

    Register(Register),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Register {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionReinterpretCast {
    Double(f64),

    ReinterpretCast(ReinterpretCast),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReinterpretCast {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRepeat {
    Double(f64),

    Repeat(Repeat),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Repeat {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRequire {
    Double(f64),

    Require(Require),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Require {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRequired {
    Double(f64),

    Required(Required),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Required {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRequires {
    Double(f64),

    Requires(Requires),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Requires {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRestrict {
    Double(f64),

    Restrict(Restrict),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Restrict {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRetain {
    Double(f64),

    Retain(Retain),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Retain {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRethrows {
    Double(f64),

    Rethrows(Rethrows),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rethrows {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRight {
    Double(f64),

    Right(Right),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Right {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRuntimeType {
    Double(f64),

    RuntimeType(RuntimeType),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RuntimeType {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionS {
    Double(f64),

    S(S),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct S {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSbyte {
    Double(f64),

    Sbyte(Sbyte),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sbyte {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSealed {
    Double(f64),

    Sealed(Sealed),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sealed {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSel {
    Double(f64),

    Sel(Sel),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sel {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSelect {
    Double(f64),

    Select(Select),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Select {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSendable {
    Double(f64),

    Sendable(Sendable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sendable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerialDescriptor {
    Double(f64),

    SerialDescriptor(SerialDescriptor),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerialDescriptor {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerialName {
    Double(f64),

    SerialName(SerialName),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerialName {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerializable {
    Double(f64),

    Serializable(Serializable),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Serializable {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerializationFeature {
    Double(f64),

    SerializationFeature(SerializationFeature),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerializationFeature {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerialize {
    Double(f64),

    SerializeClass(SerializeClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerializeClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSerializerProvider {
    Double(f64),

    SerializerProvider(SerializerProvider),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerializerProvider {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSet {
    Double(f64),

    Set(Set),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Set {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionShort {
    Double(f64),

    Short(Short),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Short {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSigned {
    Double(f64),

    Signed(Signed),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Signed {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSimpleModule {
    Double(f64),

    SimpleModule(SimpleModule),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SimpleModule {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStackalloc {
    Double(f64),

    Stackalloc(Stackalloc),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Stackalloc {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStandards {
    Double(f64),

    Standards(Standards),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Standards {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStaticAssert {
    Double(f64),

    StaticAssert(StaticAssert),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StaticAssert {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStaticCast {
    Double(f64),

    StaticCast(StaticCast),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StaticCast {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStdDeserializer {
    Double(f64),

    StdDeserializer(StdDeserializer),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StdDeserializer {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStdSerializer {
    Double(f64),

    StdSerializer(StdSerializer),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StdSerializer {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStrictfp {
    Double(f64),

    Strictfp(Strictfp),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Strictfp {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionString {
    Double(f64),

    StringClass(StringClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StringClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSubscript {
    Double(f64),

    Subscript(Subscript),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Subscript {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSwitch {
    Double(f64),

    Switch(Switch),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Switch {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSymbol {
    Double(f64),

    Symbol(Symbol),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Symbol {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSynchronized {
    Double(f64),

    Synchronized(Synchronized),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Synchronized {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSystem {
    Double(f64),

    System(System),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct System {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTemplate {
    Double(f64),

    Template(Template),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Template {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTextNode {
    Double(f64),

    TextNode(TextNode),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TextNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionThen {
    Double(f64),

    Then(Then),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Then {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionThis {
    Double(f64),

    This(This),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct This {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionThreadLocal {
    Double(f64),

    ThreadLocal(ThreadLocal),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ThreadLocal {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionThrow {
    Double(f64),

    Throw(Throw),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Throw {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionThrows {
    Double(f64),

    Throws(Throws),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Throws {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTimeOnly {
    Double(f64),

    TimeOnly(TimeOnly),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TimeOnly {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTimeOnlyConverter {
    Double(f64),

    TimeOnlyConverter(TimeOnlyConverter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TimeOnlyConverter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTimeZone {
    Double(f64),

    TimeZone(TimeZone),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TimeZone {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionToDict {
    Double(f64),

    ToDict(ToDict),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToDict {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionToJson {
    Double(f64),

    ToJson(ToJson),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToJson {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionToString {
    Double(f64),

    ToString(ToString),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToString {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTopLevel {
    Double(f64),

    TopLevelClass(TopLevelClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAbstract {
    Abstract(Abstract),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Abstract {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAlignof {
    Alignof(Alignof),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alignof {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAnyUnion {
    AnyClass(AnyClass),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnyClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAs {
    As(As),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct As {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionAsync {
    Async(Async),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Async {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBoolUnion {
    BoolClass(BoolClass),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BoolClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionBreak {
    Break(Break),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Break {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionCatch {
    Catch(Catch),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Catch {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionClassUnion {
    ClassClass(ClassClass),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ClassClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionConst {
    Const(Const),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Const {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionContinue {
    Continue(Continue),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Continue {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDefault {
    Default(Default),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Default {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionDo {
    Do(Do),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Do {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionElse {
    Double(f64),

    Else(Else),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Else {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionEnum {
    Double(f64),

    Enum(Enum),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Enum {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionExtern {
    Double(f64),

    Extern(Extern),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extern {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFalse {
    Double(f64),

    False(False),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct False {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFinal {
    Double(f64),

    Final(Final),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Final {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionFor {
    Double(f64),

    For(For),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct For {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIf {
    Double(f64),

    If(If),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct If {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionIn {
    Double(f64),

    In(In),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct In {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionLet {
    Double(f64),

    Let(Let),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Let {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNoneUnion {
    Double(f64),

    UnionNoneNone(UnionNoneNone),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnionNoneNone {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionNullUnion {
    Double(f64),

    NullClass(NullClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NullClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionOverride {
    Double(f64),

    Override(Override),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Override {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionProtocolUnion {
    Double(f64),

    ProtocolClass(ProtocolClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProtocolClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionRef {
    Double(f64),

    Ref(Ref),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ref {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionReturn {
    Double(f64),

    Return(Return),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Return {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSelf {
    Double(f64),

    SelfClass(SelfClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SelfClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSizeof {
    Double(f64),

    Sizeof(Sizeof),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sizeof {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStatic {
    Double(f64),

    Static(Static),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Static {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionStruct {
    Double(f64),

    Struct(Struct),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Struct {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionSuper {
    Double(f64),

    Super(Super),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Super {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTrue {
    Double(f64),

    True(True),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct True {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionType {
    Double(f64),

    Type(Type),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Type {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypeof {
    Double(f64),

    Typeof(Typeof),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typeof {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnionUnion {
    Double(f64),

    Union(Union),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Union {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnsafe {
    Double(f64),

    Unsafe(Unsafe),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unsafe {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionVirtual {
    Double(f64),

    Virtual(Virtual),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Virtual {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWhere {
    Double(f64),

    Where(Where),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Where {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWhile {
    Double(f64),

    While(While),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct While {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionYield {
    Double(f64),

    Yield(Yield),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Yield {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTransient {
    Double(f64),

    Transient(Transient),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Transient {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTry {
    Double(f64),

    Try(Try),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Try {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypealias {
    Double(f64),

    Typealias(Typealias),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typealias {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypedef {
    Double(f64),

    Typedef(Typedef),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typedef {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypeid {
    Double(f64),

    Typeid(Typeid),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typeid {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionTypename {
    Double(f64),

    Typename(Typename),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typename {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUint {
    Double(f64),

    Uint(Uint),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Uint {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUlong {
    Double(f64),

    Ulong(Ulong),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ulong {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnchecked {
    Double(f64),

    Unchecked(Unchecked),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unchecked {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUndefined {
    Double(f64),

    Undefined(Undefined),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Undefined {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnmarshalJson {
    Double(f64),

    UnmarshalJson(UnmarshalJson),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnmarshalJson {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnowned {
    Double(f64),

    Unowned(Unowned),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unowned {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUnsigned {
    Double(f64),

    Unsigned(Unsigned),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unsigned {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUseSerializers {
    Double(f64),

    UseSerializers(UseSerializers),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UseSerializers {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUshort {
    Double(f64),

    Ushort(Ushort),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ushort {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUsing {
    Double(f64),

    Using(Using),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Using {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUtf8JsonReader {
    Double(f64),

    Utf8JsonReader(Utf8JsonReader),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Utf8JsonReader {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUtf8JsonWriter {
    Double(f64),

    Utf8JsonWriter(Utf8JsonWriter),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Utf8JsonWriter {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionUuid {
    Double(f64),

    Uuid(Uuid),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Uuid {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionVar {
    Double(f64),

    Var(Var),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Var {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionVoid {
    Double(f64),

    Void(Void),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Void {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionVolatile {
    Double(f64),

    Volatile(Volatile),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Volatile {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWcharT {
    Double(f64),

    WcharT(WcharT),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WcharT {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWeak {
    Double(f64),

    Weak(Weak),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Weak {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWillSet {
    Double(f64),

    WillSet(WillSet),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WillSet {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionWith {
    Double(f64),

    With(With),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct With {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionXor {
    Double(f64),

    Xor(Xor),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Xor {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionXorEq {
    Double(f64),

    XorEq(XorEq),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct XorEq {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionYes {
    Double(f64),

    Yes(Yes),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Yes {
}
