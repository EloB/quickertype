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
    pub dummy: i64,

    pub obj1: Obj1,

    pub obj2: Obj2,

    pub obj3: Obj3,

    pub obj4: Obj4,

    pub obj5: Obj5,

    pub obj6: Obj6,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj1 {
    pub alignas: Alignas,

    pub and: And,

    pub and_eq: AndEq,

    #[serde(rename = "Any")]
    pub any: Any,

    pub array: Array,

    #[serde(rename = "ArrayNode")]
    pub array_node: ArrayNode,

    pub asm: Asm,

    pub assert: Assert,

    pub associatedtype: Associatedtype,

    pub associativity: Associativity,

    pub atomic: Atomic,

    pub atomic_cancel: AtomicCancel,

    pub atomic_commit: AtomicCommit,

    pub atomic_noexcept: AtomicNoexcept,

    pub auto: Auto,

    pub await: Await,

    pub base: Base,

    pub bitand: Bitand,

    pub bitor: Bitor,

    #[serde(rename = "BOOL")]
    pub bool: Bool,

    pub boolean: Boolean,

    #[serde(rename = "BooleanNode")]
    pub boolean_node: BooleanNode,

    pub bycopy: Bycopy,

    pub byref: Byref,

    pub byte: Byte,

    #[serde(rename = "Calendar")]
    pub calendar: Calendar,

    pub case: Case,

    pub chan: Chan,

    pub char: Char,

    pub char16_t: Char16T,

    pub char32_t: Char32T,

    pub checked: Checked,

    #[serde(rename = "Class")]
    pub class: Class,

    pub clone: Clone,

    pub co_await: CoAwait,

    pub co_return: CoReturn,

    pub co_yield: CoYield,

    #[serde(rename = "Codable")]
    pub codable: Codable,

    #[serde(rename = "CodingKey")]
    pub coding_key: CodingKey,

    #[serde(rename = "CodingKeys")]
    pub coding_keys: CodingKeys,

    pub compl: Compl,

    #[serde(rename = "_Complex")]
    pub complex: Complex,

    pub concept: Concept,

    pub console: Console,

    pub const_cast: ConstCast,

    pub constexpr: Constexpr,

    pub constructor: Constructor,

    pub convenience: Convenience,

    pub convert: Convert,

    pub converter: Converter,

    pub dummy: i64,

    #[serde(rename = "_")]
    pub empty: Empty,

    #[serde(rename = "_Imaginery")]
    pub imaginery: Imaginery,

    #[serde(rename = "abstract")]
    pub obj1_abstract: Abstract,

    #[serde(rename = "alignof")]
    pub obj1_alignof: Alignof,

    #[serde(rename = "any")]
    pub obj1_any: AnyClass,

    #[serde(rename = "as")]
    pub obj1_as: As,

    #[serde(rename = "async")]
    pub obj1_async: Async,

    #[serde(rename = "_Bool")]
    pub obj1_bool: BoolClass,

    #[serde(rename = "break")]
    pub obj1_break: Break,

    #[serde(rename = "catch")]
    pub obj1_catch: Catch,

    #[serde(rename = "class")]
    pub obj1_class: ClassClass,

    #[serde(rename = "const")]
    pub obj1_const: Const,

    #[serde(rename = "continue")]
    pub obj1_continue: Continue,

    #[serde(rename = "bool")]
    pub purple_bool: Obj1Bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alignas {
    pub alignas: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct And {
    pub and: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AndEq {
    pub and_eq: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Any {
    pub any: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Array {
    pub array: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ArrayNode {
    pub array_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Asm {
    pub asm: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Assert {
    pub assert: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Associatedtype {
    pub associatedtype: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Associativity {
    pub associativity: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Atomic {
    pub atomic: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicCancel {
    pub atomic_cancel: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicCommit {
    pub atomic_commit: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AtomicNoexcept {
    pub atomic_noexcept: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Auto {
    pub auto: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Await {
    pub await: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Base {
    pub base: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bitand {
    pub bitand: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bitor {
    pub bitor: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Bool {
    pub bool: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Boolean {
    pub boolean: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct BooleanNode {
    pub boolean_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Bycopy {
    pub bycopy: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Byref {
    pub byref: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Byte {
    pub byte: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Calendar {
    pub calendar: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Case {
    pub case: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Chan {
    pub chan: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char {
    pub char: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char16T {
    pub char16_t: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Char32T {
    pub char32_t: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Checked {
    pub checked: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Class {
    pub class: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Clone {
    pub clone: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoAwait {
    pub co_await: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoReturn {
    pub co_return: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoYield {
    pub co_yield: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Codable {
    pub codable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct CodingKey {
    pub coding_key: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct CodingKeys {
    pub coding_keys: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Compl {
    pub compl: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Complex {
    #[serde(rename = "_Complex")]
    pub complex: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Concept {
    pub concept: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Console {
    pub console: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConstCast {
    pub const_cast: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Constexpr {
    pub constexpr: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Constructor {
    pub constructor: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Convenience {
    pub convenience: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Convert {
    pub convert: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Converter {
    pub converter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Empty {
    #[serde(rename = "_")]
    pub empty: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Imaginery {
    #[serde(rename = "_Imaginery")]
    pub imaginery: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Abstract {
    #[serde(rename = "abstract")]
    pub abstract_abstract: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alignof {
    #[serde(rename = "alignof")]
    pub alignof_alignof: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnyClass {
    pub any: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct As {
    #[serde(rename = "as")]
    pub as_as: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Async {
    #[serde(rename = "async")]
    pub async_async: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BoolClass {
    #[serde(rename = "_Bool")]
    pub bool: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Break {
    #[serde(rename = "break")]
    pub break_break: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Catch {
    #[serde(rename = "catch")]
    pub catch_catch: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ClassClass {
    pub class: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Const {
    #[serde(rename = "const")]
    pub const_const: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Continue {
    #[serde(rename = "continue")]
    pub continue_continue: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj1Bool {
    pub bool: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj2 {
    #[serde(rename = "CultureInfo")]
    pub culture_info: CultureInfo,

    pub date: Date,

    #[serde(rename = "DateFormatter")]
    pub date_formatter: DateFormatter,

    #[serde(rename = "DateOnly")]
    pub date_only: DateOnly,

    #[serde(rename = "DateOnlyConverter")]
    pub date_only_converter: DateOnlyConverter,

    pub date_parse_handling: DateParseHandling,

    #[serde(rename = "DateTime")]
    pub date_time: DateTime,

    #[serde(rename = "DateTimeStyles")]
    pub date_time_styles: DateTimeStyles,

    pub debugger: Debugger,

    pub decimal: Decimal,

    pub declare: Declare,

    pub decltype: Decltype,

    pub decode_string: DecodeString,

    #[serde(rename = "Decoder")]
    pub decoder: Decoder,

    #[serde(rename = "DecodingError")]
    pub decoding_error: DecodingError,

    pub def: Def,

    pub defer: Defer,

    pub deinit: Deinit,

    pub del: Del,

    pub delegate: Delegate,

    pub delete: Delete,

    #[serde(rename = "DeserializationFeature")]
    pub deserialization_feature: DeserializationFeature,

    pub dict: Dict,

    pub dictionary: Dictionary,

    #[serde(rename = "didSet")]
    pub did_set: DidSet,

    pub double: Double,

    #[serde(rename = "DoubleNode")]
    pub double_node: DoubleNode,

    pub dummy: i64,

    pub dynamic: Dynamic,

    pub dynamic_cast: DynamicCast,

    pub elif: Elif,

    pub encode_quick_type: EncodeQuickType,

    #[serde(rename = "Encoder")]
    pub encoder: Encoder,

    #[serde(rename = "EnumValues")]
    pub enum_values: EnumValues,

    #[serde(rename = "equalityContract")]
    pub equality_contract: EqualityContract,

    #[serde(rename = "Equatable")]
    pub equatable: Equatable,

    pub event: Event,

    pub except: Except,

    pub exception: Exception,

    pub explicit: Explicit,

    pub export: Export,

    pub exposing: Exposing,

    pub extends: Extends,

    pub extension: Extension,

    pub fallthrough: Fallthrough,

    pub fileprivate: Fileprivate,

    pub finally: Finally,

    pub fixed: Fixed,

    pub float: Float,

    pub foreach: Foreach,

    #[serde(rename = "FormatException")]
    pub format_exception: FormatException,

    pub friend: Friend,

    pub from: From,

    pub from_dict: FromDict,

    pub from_json: FromJson,

    pub func: Func,

    #[serde(rename = "default")]
    pub obj2_default: Default,

    #[serde(rename = "do")]
    pub obj2_do: Do,

    #[serde(rename = "else")]
    pub obj2_else: Else,

    #[serde(rename = "enum")]
    pub obj2_enum: Enum,

    #[serde(rename = "extern")]
    pub obj2_extern: Extern,

    #[serde(rename = "False")]
    pub obj2_false: False,

    #[serde(rename = "final")]
    pub obj2_final: Final,

    #[serde(rename = "for")]
    pub obj2_for: For,

    #[serde(rename = "false")]
    pub purple_false: FalseClass,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct CultureInfo {
    pub culture_info: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Date {
    pub date: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DateFormatter {
    pub date_formatter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DateOnly {
    pub date_only: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DateOnlyConverter {
    pub date_only_converter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateParseHandling {
    pub date_parse_handling: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DateTime {
    pub date_time: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DateTimeStyles {
    pub date_time_styles: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Debugger {
    pub debugger: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Decimal {
    pub decimal: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Declare {
    pub declare: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Decltype {
    pub decltype: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DecodeString {
    pub decode_string: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Decoder {
    pub decoder: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DecodingError {
    pub decoding_error: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Def {
    pub def: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Defer {
    pub defer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Deinit {
    pub deinit: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Del {
    pub del: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Delegate {
    pub delegate: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Delete {
    pub delete: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DeserializationFeature {
    pub deserialization_feature: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dict {
    pub dict: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dictionary {
    pub dictionary: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct DidSet {
    pub did_set: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Double {
    pub double: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DoubleNode {
    pub double_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Dynamic {
    pub dynamic: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DynamicCast {
    pub dynamic_cast: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Elif {
    pub elif: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EncodeQuickType {
    pub encode_quick_type: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Encoder {
    pub encoder: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct EnumValues {
    pub enum_values: Vec<EnumValue>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum EnumValue {
    Ready,

    Done,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct EqualityContract {
    pub equality_contract: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Equatable {
    pub equatable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Event {
    pub event: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Except {
    pub except: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Exception {
    pub exception: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Explicit {
    pub explicit: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Export {
    pub export: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Exposing {
    pub exposing: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extends {
    pub extends: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extension {
    pub extension: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fallthrough {
    pub fallthrough: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fileprivate {
    pub fileprivate: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Finally {
    pub finally: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fixed {
    pub fixed: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Float {
    pub float: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Foreach {
    pub foreach: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct FormatException {
    pub format_exception: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Friend {
    pub friend: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct From {
    pub from: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FromDict {
    pub from_dict: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FromJson {
    pub from_json: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Func {
    pub func: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Default {
    #[serde(rename = "default")]
    pub default_default: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Do {
    #[serde(rename = "do")]
    pub do_do: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Else {
    #[serde(rename = "else")]
    pub else_else: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Enum {
    #[serde(rename = "enum")]
    pub enum_enum: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extern {
    #[serde(rename = "extern")]
    pub extern_extern: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct False {
    #[serde(rename = "False")]
    pub false_false: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Final {
    #[serde(rename = "final")]
    pub final_final: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct For {
    #[serde(rename = "for")]
    pub for_for: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FalseClass {
    #[serde(rename = "false")]
    pub false_false: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj3 {
    pub dummy: i64,

    pub function: Function,

    pub get: Get,

    pub global: Global,

    pub go: Go,

    pub goto: Goto,

    pub guard: Guard,

    #[serde(rename = "hasOwnProperty")]
    pub has_own_property: HasOwnProperty,

    #[serde(rename = "hashCode")]
    pub hash_code: HashCode,

    #[serde(rename = "Hashable")]
    pub hashable: Hashable,

    #[serde(rename = "Hasher")]
    pub hasher: Hasher,

    pub id: Id,

    #[serde(rename = "IMP")]
    pub imp: Imp,

    pub implements: Implements,

    pub implicit: Implicit,

    pub import: Import,

    pub indirect: Indirect,

    pub infix: Infix,

    pub init: Init,

    pub inline: Inline,

    pub inout: Inout,

    pub instanceof: Instanceof,

    pub int: Int,

    #[serde(rename = "IntNode")]
    pub int_node: IntNode,

    pub interface: Interface,

    pub internal: Internal,

    pub is: Is,

    #[serde(rename = "IsoDateTimeOffsetConverter")]
    pub iso_date_time_offset_converter: IsoDateTimeOffsetConverter,

    pub iterable: Iterable,

    pub jdec: Jdec,

    pub jenc: Jenc,

    pub jpipe: Jpipe,

    pub json: Json,

    #[serde(rename = "JSONAny")]
    pub json_any: JsonAny,

    #[serde(rename = "JSONCodingKey")]
    pub json_coding_key: JsonCodingKey,

    pub json_converter: JsonConverter,

    #[serde(rename = "JSONDecoder")]
    pub json_decoder: JsonDecoder,

    #[serde(rename = "JSONEncoder")]
    pub json_encoder: JsonEncoder,

    #[serde(rename = "JsonException")]
    pub json_exception: JsonException,

    #[serde(rename = "JsonGenerator")]
    pub json_generator: JsonGenerator,

    #[serde(rename = "JsonNode")]
    pub json_node: JsonNode,

    #[serde(rename = "JSONNull")]
    pub json_null: JsonNull,

    #[serde(rename = "JsonParser")]
    pub json_parser: JsonParser,

    #[serde(rename = "JsonReader")]
    pub json_reader: JsonReader,

    pub json_serializer: JsonSerializer,

    pub json_token: JsonToken,

    #[serde(rename = "JsonTokenType")]
    pub json_token_type: JsonTokenType,

    pub json_writer: JsonWriter,

    pub lambda: Lambda,

    pub lazy: Lazy,

    pub left: Left,

    pub list: List,

    #[serde(rename = "LocalDate")]
    pub local_date: LocalDate,

    #[serde(rename = "Locale")]
    pub locale: Locale,

    pub lock: Lock,

    pub long: Long,

    #[serde(rename = "LongNode")]
    pub long_node: LongNode,

    pub map: Map,

    #[serde(rename = "MapEntry")]
    pub map_entry: MapEntry,

    #[serde(rename = "MarshalJSON")]
    pub marshal_json: MarshalJson,

    pub metadata_property_handling: MetadataPropertyHandling,

    pub module: Module,

    #[serde(rename = "if")]
    pub obj3_if: If,

    #[serde(rename = "in")]
    pub obj3_in: In,

    #[serde(rename = "let")]
    pub obj3_let: Let,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Function {
    pub function: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Get {
    pub get: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Global {
    pub global: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Go {
    pub go: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Goto {
    pub goto: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Guard {
    pub guard: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct HasOwnProperty {
    pub has_own_property: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct HashCode {
    pub hash_code: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Hashable {
    pub hashable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Hasher {
    pub hasher: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Id {
    pub id: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Imp {
    pub imp: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Implements {
    pub implements: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Implicit {
    pub implicit: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Import {
    pub import: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Indirect {
    pub indirect: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Infix {
    pub infix: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Init {
    pub init: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Inline {
    pub inline: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Inout {
    pub inout: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Instanceof {
    pub instanceof: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Int {
    pub int: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct IntNode {
    pub int_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Interface {
    pub interface: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Internal {
    pub internal: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Is {
    pub is: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct IsoDateTimeOffsetConverter {
    pub iso_date_time_offset_converter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Iterable {
    pub iterable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jdec {
    pub jdec: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jenc {
    pub jenc: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Jpipe {
    pub jpipe: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Json {
    pub json: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonAny {
    #[serde(rename = "JSONAny")]
    pub json_any: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonCodingKey {
    #[serde(rename = "JSONCodingKey")]
    pub json_coding_key: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonConverter {
    pub json_converter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonDecoder {
    #[serde(rename = "JSONDecoder")]
    pub json_decoder: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonEncoder {
    #[serde(rename = "JSONEncoder")]
    pub json_encoder: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonException {
    pub json_exception: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonGenerator {
    pub json_generator: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonNode {
    pub json_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonNull {
    #[serde(rename = "JSONNull")]
    pub json_null: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonParser {
    pub json_parser: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonReader {
    pub json_reader: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonSerializer {
    pub json_serializer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonToken {
    pub json_token: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct JsonTokenType {
    pub json_token_type: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonWriter {
    pub json_writer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lambda {
    pub lambda: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lazy {
    pub lazy: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Left {
    pub left: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct List {
    pub list: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct LocalDate {
    pub local_date: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Locale {
    pub locale: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Lock {
    pub lock: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Long {
    pub long: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct LongNode {
    pub long_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Map {
    pub map: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct MapEntry {
    pub map_entry: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct MarshalJson {
    #[serde(rename = "MarshalJSON")]
    pub marshal_json: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MetadataPropertyHandling {
    pub metadata_property_handling: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Module {
    pub module: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct If {
    #[serde(rename = "if")]
    pub if_if: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct In {
    #[serde(rename = "in")]
    pub in_in: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Let {
    #[serde(rename = "let")]
    pub let_let: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj4 {
    pub dummy: i64,

    pub mutable: Mutable,

    pub mutating: Mutating,

    pub namespace: Namespace,

    pub native: Native,

    pub new: New,

    pub newtonsoft: Newtonsoft,

    pub nil: Nil,

    #[serde(rename = "NO")]
    pub no: No,

    #[serde(rename = "noSuchMethod")]
    pub no_such_method: NoSuchMethod,

    pub noexcept: Noexcept,

    pub nonatomic: Nonatomic,

    #[serde(rename = "None")]
    pub none: NoneClass,

    pub nonlocal: Nonlocal,

    pub nonmutating: Nonmutating,

    pub not: Not,

    pub not_eq: NotEq,

    #[serde(rename = "NSError")]
    pub ns_error: NsError,

    #[serde(rename = "NSObject")]
    pub ns_object: NsObject,

    #[serde(rename = "NSString")]
    pub ns_string: NsString,

    #[serde(rename = "NULL")]
    pub null: Null,

    #[serde(rename = "NullNode")]
    pub null_node: NullNode,

    pub nullptr: Nullptr,

    pub number: Number,

    #[serde(rename = "none")]
    pub obj4_none: Obj4None,

    #[serde(rename = "null")]
    pub obj4_null: NullClass,

    #[serde(rename = "override")]
    pub obj4_override: Override,

    #[serde(rename = "protocol")]
    pub obj4_protocol: ProtocolClass,

    #[serde(rename = "ref")]
    pub obj4_ref: Ref,

    pub object: Object,

    #[serde(rename = "ObjectMapper")]
    pub object_mapper: ObjectMapper,

    #[serde(rename = "ObjectNode")]
    pub object_node: ObjectNode,

    #[serde(rename = "ObjectReader")]
    pub object_reader: ObjectReader,

    #[serde(rename = "ObjectWriter")]
    pub object_writer: ObjectWriter,

    pub of: Of,

    #[serde(rename = "OffsetDateTime")]
    pub offset_date_time: OffsetDateTime,

    #[serde(rename = "OffsetTime")]
    pub offset_time: OffsetTime,

    pub oneway: Oneway,

    pub open: Open,

    pub operator: Operator,

    pub optional: Optional,

    pub or: Or,

    pub or_eq: OrEq,

    pub out: Out,

    pub package: Package,

    pub params: Params,

    pub pass: Pass,

    pub port: Port,

    pub postfix: Postfix,

    pub precedence: Precedence,

    pub prefix: Prefix,

    pub print: Print,

    #[serde(rename = "printMembers")]
    pub print_members: PrintMembers,

    pub printf: Printf,

    pub private: Private,

    pub protected: Protected,

    #[serde(rename = "Protocol")]
    pub protocol: Protocol,

    pub public: Public,

    pub quicktype: Quicktype,

    pub raise: Raise,

    pub range: Range,

    pub readonly: Readonly,

    #[serde(rename = "RegExp")]
    pub reg_exp: RegExp,

    pub register: Register,

    pub reinterpret_cast: ReinterpretCast,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Mutable {
    pub mutable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Mutating {
    pub mutating: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Namespace {
    pub namespace: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Native {
    pub native: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct New {
    pub new: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Newtonsoft {
    pub newtonsoft: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nil {
    pub nil: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct No {
    pub no: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct NoSuchMethod {
    pub no_such_method: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Noexcept {
    pub noexcept: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonatomic {
    pub nonatomic: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct NoneClass {
    pub none: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonlocal {
    pub nonlocal: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nonmutating {
    pub nonmutating: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Not {
    pub not: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NotEq {
    pub not_eq: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct NsError {
    #[serde(rename = "NSError")]
    pub ns_error: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct NsObject {
    #[serde(rename = "NSObject")]
    pub ns_object: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct NsString {
    #[serde(rename = "NSString")]
    pub ns_string: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Null {
    pub null: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct NullNode {
    pub null_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Nullptr {
    pub nullptr: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Number {
    pub number: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj4None {
    pub none: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NullClass {
    pub null: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Override {
    #[serde(rename = "override")]
    pub override_override: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProtocolClass {
    pub protocol: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ref {
    #[serde(rename = "ref")]
    pub ref_ref: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Object {
    pub object: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ObjectMapper {
    pub object_mapper: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ObjectNode {
    pub object_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ObjectReader {
    pub object_reader: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ObjectWriter {
    pub object_writer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Of {
    pub of: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct OffsetDateTime {
    pub offset_date_time: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct OffsetTime {
    pub offset_time: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Oneway {
    pub oneway: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Open {
    pub open: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Operator {
    pub operator: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Optional {
    pub optional: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Or {
    pub or: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OrEq {
    pub or_eq: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Out {
    pub out: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Package {
    pub package: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Params {
    pub params: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pass {
    pub pass: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Port {
    pub port: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Postfix {
    pub postfix: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Precedence {
    pub precedence: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Prefix {
    pub prefix: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Print {
    pub print: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PrintMembers {
    pub print_members: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Printf {
    pub printf: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Private {
    pub private: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Protected {
    pub protected: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Protocol {
    pub protocol: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Public {
    pub public: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Quicktype {
    pub quicktype: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Raise {
    pub raise: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Range {
    pub range: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Readonly {
    pub readonly: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct RegExp {
    pub reg_exp: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Register {
    pub register: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReinterpretCast {
    pub reinterpret_cast: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj5 {
    pub dummy: i64,

    #[serde(rename = "KSerializer")]
    pub k_serializer: KSerializer,

    #[serde(rename = "return")]
    pub obj5_return: Return,

    #[serde(rename = "Self")]
    pub obj5_self: SelfClass,

    #[serde(rename = "sizeof")]
    pub obj5_sizeof: Sizeof,

    #[serde(rename = "static")]
    pub obj5_static: Static,

    #[serde(rename = "struct")]
    pub obj5_struct: Struct,

    #[serde(rename = "super")]
    pub obj5_super: Super,

    #[serde(rename = "True")]
    pub obj5_true: True,

    #[serde(rename = "PrimitiveKind")]
    pub primitive_kind: PrimitiveKind,

    #[serde(rename = "self")]
    pub purple_self: Obj5Self,

    #[serde(rename = "true")]
    pub purple_true: TrueClass,

    pub repeat: Repeat,

    pub require: Require,

    pub required: Required,

    pub requires: Requires,

    pub restrict: Restrict,

    pub retain: Retain,

    pub rethrows: Rethrows,

    pub right: Right,

    #[serde(rename = "runtimeType")]
    pub runtime_type: RuntimeType,

    pub s: S,

    pub sbyte: Sbyte,

    pub sealed: Sealed,

    #[serde(rename = "SEL")]
    pub sel: Sel,

    pub select: Select,

    #[serde(rename = "Sendable")]
    pub sendable: Sendable,

    #[serde(rename = "SerialDescriptor")]
    pub serial_descriptor: SerialDescriptor,

    #[serde(rename = "SerialName")]
    pub serial_name: SerialName,

    #[serde(rename = "Serializable")]
    pub serializable: Serializable,

    #[serde(rename = "SerializationFeature")]
    pub serialization_feature: SerializationFeature,

    pub serialize: SerializeClass,

    #[serde(rename = "SerializerProvider")]
    pub serializer_provider: SerializerProvider,

    pub set: Set,

    pub short: Short,

    pub signed: Signed,

    #[serde(rename = "SimpleModule")]
    pub simple_module: SimpleModule,

    pub stackalloc: Stackalloc,

    #[serde(rename = "Standards")]
    pub standards: Standards,

    pub static_assert: StaticAssert,

    pub static_cast: StaticCast,

    #[serde(rename = "StdDeserializer")]
    pub std_deserializer: StdDeserializer,

    #[serde(rename = "StdSerializer")]
    pub std_serializer: StdSerializer,

    pub strictfp: Strictfp,

    pub string: StringClass,

    pub subscript: Subscript,

    pub switch: Switch,

    pub symbol: Symbol,

    pub synchronized: Synchronized,

    pub system: System,

    pub template: Template,

    #[serde(rename = "TextNode")]
    pub text_node: TextNode,

    pub then: Then,

    pub this: This,

    pub thread_local: ThreadLocal,

    pub throw: Throw,

    pub throws: Throws,

    #[serde(rename = "TimeOnly")]
    pub time_only: TimeOnly,

    #[serde(rename = "TimeOnlyConverter")]
    pub time_only_converter: TimeOnlyConverter,

    #[serde(rename = "TimeZone")]
    pub time_zone: TimeZone,

    pub to_dict: ToDict,

    pub to_json: ToJson,

    #[serde(rename = "toString")]
    pub to_string: ToString,

    pub top_level: TopLevelClass,

    pub transient: Transient,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct KSerializer {
    pub k_serializer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Return {
    #[serde(rename = "return")]
    pub return_return: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SelfClass {
    #[serde(rename = "Self")]
    pub self_self: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sizeof {
    #[serde(rename = "sizeof")]
    pub sizeof_sizeof: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Static {
    #[serde(rename = "static")]
    pub static_static: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Struct {
    #[serde(rename = "struct")]
    pub struct_struct: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Super {
    #[serde(rename = "super")]
    pub super_super: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct True {
    #[serde(rename = "True")]
    pub true_true: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct PrimitiveKind {
    pub primitive_kind: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj5Self {
    #[serde(rename = "self")]
    pub self_self: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TrueClass {
    #[serde(rename = "true")]
    pub true_true: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Repeat {
    pub repeat: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Require {
    pub require: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Required {
    pub required: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Requires {
    pub requires: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Restrict {
    pub restrict: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Retain {
    pub retain: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rethrows {
    pub rethrows: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Right {
    pub right: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuntimeType {
    pub runtime_type: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct S {
    pub s: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sbyte {
    pub sbyte: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Sealed {
    pub sealed: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Sel {
    pub sel: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Select {
    pub select: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Sendable {
    pub sendable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SerialDescriptor {
    pub serial_descriptor: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SerialName {
    pub serial_name: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Serializable {
    pub serializable: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SerializationFeature {
    pub serialization_feature: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SerializeClass {
    pub serialize: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SerializerProvider {
    pub serializer_provider: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Set {
    pub set: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Short {
    pub short: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Signed {
    pub signed: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct SimpleModule {
    pub simple_module: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Stackalloc {
    pub stackalloc: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Standards {
    pub standards: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StaticAssert {
    pub static_assert: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StaticCast {
    pub static_cast: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct StdDeserializer {
    pub std_deserializer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct StdSerializer {
    pub std_serializer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Strictfp {
    pub strictfp: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StringClass {
    pub string: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Subscript {
    pub subscript: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Switch {
    pub switch: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Symbol {
    pub symbol: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Synchronized {
    pub synchronized: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct System {
    pub system: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Template {
    pub template: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct TextNode {
    pub text_node: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Then {
    pub then: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct This {
    pub this: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ThreadLocal {
    pub thread_local: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Throw {
    pub throw: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Throws {
    pub throws: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct TimeOnly {
    pub time_only: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct TimeOnlyConverter {
    pub time_only_converter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct TimeZone {
    pub time_zone: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToDict {
    pub to_dict: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToJson {
    pub to_json: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ToString {
    pub to_string: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelClass {
    pub top_level: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Transient {
    pub transient: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Obj6 {
    pub dummy: i64,

    #[serde(rename = "Type")]
    pub obj6_type: Type,

    #[serde(rename = "typeof")]
    pub obj6_typeof: Typeof,

    #[serde(rename = "union")]
    pub obj6_union: Union,

    #[serde(rename = "unsafe")]
    pub obj6_unsafe: Unsafe,

    #[serde(rename = "virtual")]
    pub obj6_virtual: Virtual,

    #[serde(rename = "where")]
    pub obj6_where: Where,

    #[serde(rename = "while")]
    pub obj6_while: While,

    #[serde(rename = "yield")]
    pub obj6_yield: Yield,

    #[serde(rename = "type")]
    pub purple_type: TypeClass,

    pub try: Try,

    pub typealias: Typealias,

    pub typedef: Typedef,

    pub typeid: Typeid,

    pub typename: Typename,

    pub uint: Uint,

    pub ulong: Ulong,

    pub unchecked: Unchecked,

    pub undefined: Undefined,

    #[serde(rename = "UnmarshalJSON")]
    pub unmarshal_json: UnmarshalJson,

    pub unowned: Unowned,

    pub unsigned: Unsigned,

    #[serde(rename = "UseSerializers")]
    pub use_serializers: UseSerializers,

    pub ushort: Ushort,

    pub using: Using,

    #[serde(rename = "Utf8JsonReader")]
    pub utf8_json_reader: Utf8JsonReader,

    #[serde(rename = "Utf8JsonWriter")]
    pub utf8_json_writer: Utf8JsonWriter,

    #[serde(rename = "UUID")]
    pub uuid: Uuid,

    pub var: Var,

    pub void: Void,

    pub volatile: Volatile,

    pub wchar_t: WcharT,

    pub weak: Weak,

    #[serde(rename = "willSet")]
    pub will_set: WillSet,

    pub with: With,

    pub xor: Xor,

    pub xor_eq: XorEq,

    #[serde(rename = "YES")]
    pub yes: Yes,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Type {
    #[serde(rename = "Type")]
    pub type_type: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typeof {
    #[serde(rename = "typeof")]
    pub typeof_typeof: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Union {
    #[serde(rename = "union")]
    pub union_union: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unsafe {
    #[serde(rename = "unsafe")]
    pub unsafe_unsafe: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Virtual {
    #[serde(rename = "virtual")]
    pub virtual_virtual: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Where {
    #[serde(rename = "where")]
    pub where_where: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct While {
    #[serde(rename = "while")]
    pub while_while: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Yield {
    #[serde(rename = "yield")]
    pub yield_yield: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TypeClass {
    #[serde(rename = "type")]
    pub type_type: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Try {
    pub try: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typealias {
    pub typealias: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typedef {
    pub typedef: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typeid {
    pub typeid: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Typename {
    pub typename: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Uint {
    pub uint: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ulong {
    pub ulong: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unchecked {
    pub unchecked: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Undefined {
    pub undefined: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct UnmarshalJson {
    #[serde(rename = "UnmarshalJSON")]
    pub unmarshal_json: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unowned {
    pub unowned: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unsigned {
    pub unsigned: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct UseSerializers {
    pub use_serializers: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ushort {
    pub ushort: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Using {
    pub using: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Utf8JsonReader {
    pub utf8_json_reader: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Utf8JsonWriter {
    pub utf8_json_writer: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Uuid {
    pub uuid: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Var {
    pub var: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Void {
    pub void: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Volatile {
    pub volatile: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WcharT {
    pub wchar_t: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Weak {
    pub weak: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct WillSet {
    pub will_set: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct With {
    pub with: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Xor {
    pub xor: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct XorEq {
    pub xor_eq: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Yes {
    pub yes: i64,
}
