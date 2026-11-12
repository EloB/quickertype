// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(EnumValue::class,      { EnumValue.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val dummy: Long,
    val obj1: Obj1,
    val obj2: Obj2,
    val obj3: Obj3,
    val obj4: Obj4,
    val obj5: Obj5,
    val obj6: Obj6
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Obj1 (
    val abstract: Abstract,
    val alignas: Alignas,
    val alignof: Alignof,
    val and: And,

    @Json(name = "and_eq")
    val andEq: AndEq,

    @Json(name = "Any")
    val any: AnyClass,

    val array: ArrayClass,

    @Json(name = "ArrayNode")
    val arrayNode: ArrayNode,

    val asm: ASM,
    val assert: Assert,
    val associatedtype: Associatedtype,
    val associativity: Associativity,
    val async: Async,
    val atomic: Atomic,

    @Json(name = "atomic_cancel")
    val atomicCancel: AtomicCancel,

    @Json(name = "atomic_commit")
    val atomicCommit: AtomicCommit,

    @Json(name = "atomic_noexcept")
    val atomicNoexcept: AtomicNoexcept,

    val auto: Auto,
    val await: Await,
    val base: Base,
    val bitand: Bitand,
    val bitor: Bitor,

    @Json(name = "BOOL")
    val bool: Bool,

    val boolean: BooleanClass,

    @Json(name = "BooleanNode")
    val booleanNode: BooleanNode,

    val bycopy: Bycopy,
    val byref: Byref,
    val byte: ByteClass,

    @Json(name = "Calendar")
    val calendar: Calendar,

    val case: Case,
    val catch: Catch,
    val chan: Chan,
    val char: Char,

    @Json(name = "char16_t")
    val char16T: Char16T,

    @Json(name = "char32_t")
    val char32T: Char32T,

    val checked: Checked,
    val clone: Clone,

    @Json(name = "co_await")
    val coAwait: CoAwait,

    @Json(name = "co_return")
    val coReturn: CoReturn,

    @Json(name = "co_yield")
    val coYield: CoYield,

    @Json(name = "Codable")
    val codable: Codable,

    @Json(name = "CodingKey")
    val codingKey: CodingKey,

    @Json(name = "CodingKeys")
    val codingKeys: CodingKeys,

    val compl: Compl,

    @Json(name = "_Complex")
    val complex: Complex,

    val concept: Concept,
    val console: Console,
    val const: Const,

    @Json(name = "const_cast")
    val constCast: ConstCast,

    val constexpr: Constexpr,
    val constructor: Constructor,
    val convenience: Convenience,
    val convert: Convert,
    val converter: ConverterClass,
    val dummy: Long,

    @Json(name = "_")
    val empty: Empty,

    @Json(name = "_Imaginery")
    val imaginery: Imaginery,

    @Json(name = "any")
    val obj1Any: Obj1Any,

    @Json(name = "as")
    val obj1As: As,

    @Json(name = "_Bool")
    val obj1Bool: BoolClass,

    @Json(name = "break")
    val obj1Break: Break,

    @Json(name = "Class")
    val obj1Class: ClassClass,

    @Json(name = "continue")
    val obj1Continue: Continue,

    @Json(name = "bool")
    val purpleBool: Obj1Bool,

    @Json(name = "class")
    val purpleClass: Obj1Class
)

data class Abstract (
    val abstract: Long
)

data class Alignas (
    val alignas: Long
)

data class Alignof (
    val alignof: Long
)

data class And (
    val and: Long
)

data class AndEq (
    @Json(name = "and_eq")
    val andEq: Long
)

data class AnyClass (
    @Json(name = "Any")
    val any: Long
)

data class ArrayClass (
    val array: Long
)

data class ArrayNode (
    @Json(name = "ArrayNode")
    val arrayNode: Long
)

data class ASM (
    val asm: Long
)

data class Assert (
    val assert: Long
)

data class Associatedtype (
    val associatedtype: Long
)

data class Associativity (
    val associativity: Long
)

data class Async (
    val async: Long
)

data class Atomic (
    val atomic: Long
)

data class AtomicCancel (
    @Json(name = "atomic_cancel")
    val atomicCancel: Long
)

data class AtomicCommit (
    @Json(name = "atomic_commit")
    val atomicCommit: Long
)

data class AtomicNoexcept (
    @Json(name = "atomic_noexcept")
    val atomicNoexcept: Long
)

data class Auto (
    val auto: Long
)

data class Await (
    val await: Long
)

data class Base (
    val base: Long
)

data class Bitand (
    val bitand: Long
)

data class Bitor (
    val bitor: Long
)

data class Bool (
    @Json(name = "BOOL")
    val bool: Long
)

data class BooleanClass (
    val boolean: Long
)

data class BooleanNode (
    @Json(name = "BooleanNode")
    val booleanNode: Long
)

data class Bycopy (
    val bycopy: Long
)

data class Byref (
    val byref: Long
)

data class ByteClass (
    val byte: Long
)

data class Calendar (
    @Json(name = "Calendar")
    val calendar: Long
)

data class Case (
    val case: Long
)

data class Catch (
    val catch: Long
)

data class Chan (
    val chan: Long
)

data class Char (
    val char: Long
)

data class Char16T (
    @Json(name = "char16_t")
    val char16T: Long
)

data class Char32T (
    @Json(name = "char32_t")
    val char32T: Long
)

data class Checked (
    val checked: Long
)

data class Clone (
    val clone: Long
)

data class CoAwait (
    @Json(name = "co_await")
    val coAwait: Long
)

data class CoReturn (
    @Json(name = "co_return")
    val coReturn: Long
)

data class CoYield (
    @Json(name = "co_yield")
    val coYield: Long
)

data class Codable (
    @Json(name = "Codable")
    val codable: Long
)

data class CodingKey (
    @Json(name = "CodingKey")
    val codingKey: Long
)

data class CodingKeys (
    @Json(name = "CodingKeys")
    val codingKeys: Long
)

data class Compl (
    val compl: Long
)

data class Complex (
    @Json(name = "_Complex")
    val complex: Long
)

data class Concept (
    val concept: Long
)

data class Console (
    val console: Long
)

data class Const (
    val const: Long
)

data class ConstCast (
    @Json(name = "const_cast")
    val constCast: Long
)

data class Constexpr (
    val constexpr: Long
)

data class Constructor (
    val constructor: Long
)

data class Convenience (
    val convenience: Long
)

data class Convert (
    val convert: Long
)

data class ConverterClass (
    val converter: Long
)

data class Empty (
    @Json(name = "_")
    val empty: Long
)

data class Imaginery (
    @Json(name = "_Imaginery")
    val imaginery: Long
)

data class Obj1Any (
    val any: Long
)

data class As (
    @Json(name = "as")
    val asAs: Long
)

data class BoolClass (
    @Json(name = "_Bool")
    val bool: Long
)

data class Break (
    @Json(name = "break")
    val breakBreak: Long
)

data class ClassClass (
    @Json(name = "Class")
    val classClass: Long
)

data class Continue (
    @Json(name = "continue")
    val continueContinue: Long
)

data class Obj1Bool (
    val bool: Long
)

data class Obj1Class (
    @Json(name = "class")
    val classClass: Long
)

data class Obj2 (
    @Json(name = "CultureInfo")
    val cultureInfo: CultureInfo,

    val date: Date,

    @Json(name = "DateFormatter")
    val dateFormatter: DateFormatter,

    @Json(name = "DateOnly")
    val dateOnly: DateOnly,

    @Json(name = "DateOnlyConverter")
    val dateOnlyConverter: DateOnlyConverter,

    @Json(name = "date_parse_handling")
    val dateParseHandling: DateParseHandling,

    @Json(name = "DateTime")
    val dateTime: DateTime,

    @Json(name = "DateTimeStyles")
    val dateTimeStyles: DateTimeStyles,

    val debugger: Debugger,
    val decimal: Decimal,
    val declare: Declare,
    val decltype: Decltype,

    @Json(name = "decode_string")
    val decodeString: DecodeString,

    @Json(name = "Decoder")
    val decoder: Decoder,

    @Json(name = "DecodingError")
    val decodingError: DecodingError,

    val def: Def,
    val default: Default,
    val defer: Defer,
    val deinit: Deinit,
    val del: Del,
    val delegate: Delegate,
    val delete: Delete,

    @Json(name = "DeserializationFeature")
    val deserializationFeature: DeserializationFeature,

    val dict: Dict,
    val dictionary: Dictionary,
    val didSet: DidSet,
    val double: DoubleClass,

    @Json(name = "DoubleNode")
    val doubleNode: DoubleNode,

    val dummy: Long,
    val dynamic: Dynamic,

    @Json(name = "dynamic_cast")
    val dynamicCast: DynamicCast,

    val elif: Elif,

    @Json(name = "encode_quick_type")
    val encodeQuickType: EncodeQuickType,

    @Json(name = "Encoder")
    val encoder: Encoder,

    val enum: EnumClass,

    @Json(name = "EnumValues")
    val enumValues: EnumValues,

    val equalityContract: EqualityContract,

    @Json(name = "Equatable")
    val equatable: Equatable,

    val event: Event,
    val except: Except,
    val exception: Exception,
    val explicit: Explicit,
    val export: Export,
    val exposing: Exposing,
    val extends: Extends,
    val extension: Extension,
    val extern: Extern,
    val fallthrough: Fallthrough,
    val fileprivate: Fileprivate,
    val final: Final,
    val finally: Finally,
    val fixed: Fixed,
    val float: FloatClass,
    val foreach: Foreach,

    @Json(name = "FormatException")
    val formatException: FormatException,

    val friend: Friend,
    val from: From,

    @Json(name = "from_dict")
    val fromDict: FromDict,

    @Json(name = "from_json")
    val fromJSON: FromJSON,

    val func: Func,

    @Json(name = "do")
    val obj2Do: Do,

    @Json(name = "else")
    val obj2Else: Else,

    @Json(name = "False")
    val obj2False: False,

    @Json(name = "for")
    val obj2For: For,

    @Json(name = "false")
    val purpleFalse: FalseClass
)

data class CultureInfo (
    @Json(name = "CultureInfo")
    val cultureInfo: Long
)

data class Date (
    val date: Long
)

data class DateFormatter (
    @Json(name = "DateFormatter")
    val dateFormatter: Long
)

data class DateOnly (
    @Json(name = "DateOnly")
    val dateOnly: Long
)

data class DateOnlyConverter (
    @Json(name = "DateOnlyConverter")
    val dateOnlyConverter: Long
)

data class DateParseHandling (
    @Json(name = "date_parse_handling")
    val dateParseHandling: Long
)

data class DateTime (
    @Json(name = "DateTime")
    val dateTime: OffsetDateTime
)

data class DateTimeStyles (
    @Json(name = "DateTimeStyles")
    val dateTimeStyles: Long
)

data class Debugger (
    val debugger: Long
)

data class Decimal (
    val decimal: Long
)

data class Declare (
    val declare: Long
)

data class Decltype (
    val decltype: Long
)

data class DecodeString (
    @Json(name = "decode_string")
    val decodeString: Long
)

data class Decoder (
    @Json(name = "Decoder")
    val decoder: Long
)

data class DecodingError (
    @Json(name = "DecodingError")
    val decodingError: Long
)

data class Def (
    val def: Long
)

data class Default (
    val default: Long
)

data class Defer (
    val defer: Long
)

data class Deinit (
    val deinit: Long
)

data class Del (
    val del: Long
)

data class Delegate (
    val delegate: Long
)

data class Delete (
    val delete: Long
)

data class DeserializationFeature (
    @Json(name = "DeserializationFeature")
    val deserializationFeature: Long
)

data class Dict (
    val dict: Long
)

data class Dictionary (
    val dictionary: Long
)

data class DidSet (
    val didSet: Long
)

data class DoubleClass (
    val double: Long
)

data class DoubleNode (
    @Json(name = "DoubleNode")
    val doubleNode: Long
)

data class Dynamic (
    val dynamic: Long
)

data class DynamicCast (
    @Json(name = "dynamic_cast")
    val dynamicCast: Long
)

data class Elif (
    val elif: Long
)

data class EncodeQuickType (
    @Json(name = "encode_quick_type")
    val encodeQuickType: Long
)

data class Encoder (
    @Json(name = "Encoder")
    val encoder: Long
)

data class EnumClass (
    val enum: Long
)

data class EnumValues (
    @Json(name = "EnumValues")
    val enumValues: List<EnumValue>
)

enum class EnumValue(val value: String) {
    Ready("ready"),
    Done("done");

    companion object {
        public fun fromValue(value: String): EnumValue = when (value) {
            "ready" -> Ready
            "done"  -> Done
            else    -> throw IllegalArgumentException()
        }
    }
}

data class EqualityContract (
    val equalityContract: Long
)

data class Equatable (
    @Json(name = "Equatable")
    val equatable: Long
)

data class Event (
    val event: Long
)

data class Except (
    val except: Long
)

data class Exception (
    val exception: Long
)

data class Explicit (
    val explicit: Long
)

data class Export (
    val export: Long
)

data class Exposing (
    val exposing: Long
)

data class Extends (
    val extends: Long
)

data class Extension (
    val extension: Long
)

data class Extern (
    val extern: Long
)

data class Fallthrough (
    val fallthrough: Long
)

data class Fileprivate (
    val fileprivate: Long
)

data class Final (
    val final: Long
)

data class Finally (
    val finally: Long
)

data class Fixed (
    val fixed: Long
)

data class FloatClass (
    val float: Long
)

data class Foreach (
    val foreach: Long
)

data class FormatException (
    @Json(name = "FormatException")
    val formatException: Long
)

data class Friend (
    val friend: Long
)

data class From (
    val from: Long
)

data class FromDict (
    @Json(name = "from_dict")
    val fromDict: Long
)

data class FromJSON (
    @Json(name = "from_json")
    val fromJSON: Long
)

data class Func (
    val func: Long
)

data class Do (
    @Json(name = "do")
    val doDo: Long
)

data class Else (
    @Json(name = "else")
    val elseElse: Long
)

data class False (
    @Json(name = "False")
    val falseFalse: Long
)

data class For (
    @Json(name = "for")
    val forFor: Long
)

data class FalseClass (
    @Json(name = "false")
    val falseFalse: Long
)

data class Obj3 (
    val dummy: Long,
    val function: Function,
    val get: Get,
    val global: Global,
    val go: Go,
    val goto: Goto,
    val guard: Guard,
    val hasOwnProperty: HasOwnProperty,
    val hashCode: HashCode,

    @Json(name = "Hashable")
    val hashable: Hashable,

    @Json(name = "Hasher")
    val hasher: Hasher,

    val id: ID,

    @Json(name = "IMP")
    val imp: Imp,

    val implements: Implements,
    val implicit: Implicit,
    val import: Import,
    val indirect: Indirect,
    val infix: Infix,
    val init: Init,
    val inline: Inline,
    val inout: Inout,
    val instanceof: Instanceof,
    val int: IntClass,

    @Json(name = "IntNode")
    val intNode: IntNode,

    val internal: Internal,

    @Json(name = "IsoDateTimeOffsetConverter")
    val isoDateTimeOffsetConverter: ISODateTimeOffsetConverter,

    val iterable: Iterable,
    val jdec: Jdec,
    val jenc: Jenc,
    val jpipe: Jpipe,
    val json: JSON,

    @Json(name = "JSONAny")
    val jsonAny: JSONAny,

    @Json(name = "JSONCodingKey")
    val jsonCodingKey: JSONCodingKey,

    @Json(name = "json_converter")
    val jsonConverter: JSONConverter,

    @Json(name = "JSONDecoder")
    val jsonDecoder: JSONDecoder,

    @Json(name = "JSONEncoder")
    val jsonEncoder: JSONEncoder,

    @Json(name = "JsonException")
    val jsonException: JSONException,

    @Json(name = "JsonGenerator")
    val jsonGenerator: JSONGenerator,

    @Json(name = "JsonNode")
    val jsonNode: JSONNode,

    @Json(name = "JSONNull")
    val jsonNull: JSONNull,

    @Json(name = "JsonParser")
    val jsonParser: JSONParser,

    @Json(name = "JsonReader")
    val jsonReader: JSONReader,

    @Json(name = "json_serializer")
    val jsonSerializer: JSONSerializer,

    @Json(name = "json_token")
    val jsonToken: JSONToken,

    @Json(name = "JsonTokenType")
    val jsonTokenType: JSONTokenType,

    @Json(name = "json_writer")
    val jsonWriter: JSONWriter,

    val lambda: Lambda,
    val lazy: Lazy,
    val left: Left,
    val let: Let,
    val list: ListClass,

    @Json(name = "LocalDate")
    val localDate: LocalDate,

    @Json(name = "Locale")
    val locale: Locale,

    val lock: Lock,
    val long: LongClass,

    @Json(name = "LongNode")
    val longNode: LongNode,

    val map: MapClass,

    @Json(name = "MapEntry")
    val mapEntry: MapEntry,

    @Json(name = "MarshalJSON")
    val marshalJSON: MarshalJSON,

    @Json(name = "metadata_property_handling")
    val metadataPropertyHandling: MetadataPropertyHandling,

    val module: Module,

    @Json(name = "if")
    val obj3If: If,

    @Json(name = "in")
    val obj3In: In,

    @Json(name = "interface")
    val obj3Interface: Interface,

    @Json(name = "is")
    val obj3Is: Is
)

data class Function (
    val function: Long
)

data class Get (
    val get: Long
)

data class Global (
    val global: Long
)

data class Go (
    val go: Long
)

data class Goto (
    val goto: Long
)

data class Guard (
    val guard: Long
)

data class HasOwnProperty (
    val hasOwnProperty: Long
)

data class HashCode (
    val hashCode: Long
)

data class Hashable (
    @Json(name = "Hashable")
    val hashable: Long
)

data class Hasher (
    @Json(name = "Hasher")
    val hasher: Long
)

data class ID (
    val id: Long
)

data class Imp (
    @Json(name = "IMP")
    val imp: Long
)

data class Implements (
    val implements: Long
)

data class Implicit (
    val implicit: Long
)

data class Import (
    val import: Long
)

data class Indirect (
    val indirect: Long
)

data class Infix (
    val infix: Long
)

data class Init (
    val init: Long
)

data class Inline (
    val inline: Long
)

data class Inout (
    val inout: Long
)

data class Instanceof (
    val instanceof: Long
)

data class IntClass (
    val int: Long
)

data class IntNode (
    @Json(name = "IntNode")
    val intNode: Long
)

data class Internal (
    val internal: Long
)

data class ISODateTimeOffsetConverter (
    @Json(name = "IsoDateTimeOffsetConverter")
    val isoDateTimeOffsetConverter: Long
)

data class Iterable (
    val iterable: Long
)

data class Jdec (
    val jdec: Long
)

data class Jenc (
    val jenc: Long
)

data class Jpipe (
    val jpipe: Long
)

data class JSON (
    val json: Long
)

data class JSONAny (
    @Json(name = "JSONAny")
    val jsonAny: Any? = null
)

data class JSONCodingKey (
    @Json(name = "JSONCodingKey")
    val jsonCodingKey: Long
)

data class JSONConverter (
    @Json(name = "json_converter")
    val jsonConverter: Long
)

data class JSONDecoder (
    @Json(name = "JSONDecoder")
    val jsonDecoder: Long
)

data class JSONEncoder (
    @Json(name = "JSONEncoder")
    val jsonEncoder: Long
)

data class JSONException (
    @Json(name = "JsonException")
    val jsonException: Long
)

data class JSONGenerator (
    @Json(name = "JsonGenerator")
    val jsonGenerator: Long
)

data class JSONNode (
    @Json(name = "JsonNode")
    val jsonNode: Long
)

data class JSONNull (
    @Json(name = "JSONNull")
    val jsonNull: Long
)

data class JSONParser (
    @Json(name = "JsonParser")
    val jsonParser: Long
)

data class JSONReader (
    @Json(name = "JsonReader")
    val jsonReader: Long
)

data class JSONSerializer (
    @Json(name = "json_serializer")
    val jsonSerializer: Long
)

data class JSONToken (
    @Json(name = "json_token")
    val jsonToken: Long
)

data class JSONTokenType (
    @Json(name = "JsonTokenType")
    val jsonTokenType: Long
)

data class JSONWriter (
    @Json(name = "json_writer")
    val jsonWriter: Long
)

data class Lambda (
    val lambda: Long
)

data class Lazy (
    val lazy: Long
)

data class Left (
    val left: Long
)

data class Let (
    val let: Long
)

data class ListClass (
    val list: Long
)

data class LocalDate (
    @Json(name = "LocalDate")
    val localDate: Long
)

data class Locale (
    @Json(name = "Locale")
    val locale: Long
)

data class Lock (
    val lock: Long
)

data class LongClass (
    val long: Long
)

data class LongNode (
    @Json(name = "LongNode")
    val longNode: Long
)

data class MapClass (
    val map: Long
)

data class MapEntry (
    @Json(name = "MapEntry")
    val mapEntry: Long
)

data class MarshalJSON (
    @Json(name = "MarshalJSON")
    val marshalJSON: Long
)

data class MetadataPropertyHandling (
    @Json(name = "metadata_property_handling")
    val metadataPropertyHandling: Long
)

data class Module (
    val module: Long
)

data class If (
    @Json(name = "if")
    val ifIf: Long
)

data class In (
    @Json(name = "in")
    val inIn: Long
)

data class Interface (
    @Json(name = "interface")
    val interfaceInterface: Long
)

data class Is (
    @Json(name = "is")
    val isIs: Long
)

data class Obj4 (
    val dummy: Long,
    val mutable: Mutable,
    val mutating: Mutating,
    val namespace: Namespace,
    val native: Native,
    val new: New,
    val newtonsoft: Newtonsoft,
    val nil: Nil,

    @Json(name = "NO")
    val no: No,

    val noSuchMethod: NoSuchMethod,
    val noexcept: Noexcept,
    val nonatomic: Nonatomic,

    @Json(name = "None")
    val none: None,

    val nonlocal: Nonlocal,
    val nonmutating: Nonmutating,
    val not: Not,

    @Json(name = "not_eq")
    val notEq: NotEq,

    @Json(name = "NSError")
    val nsError: NSError,

    @Json(name = "NSObject")
    val nsObject: NSObject,

    @Json(name = "NSString")
    val nsString: NSString,

    @Json(name = "NullNode")
    val nullNode: NullNode,

    val nullptr: Nullptr,
    val number: Number,

    @Json(name = "NULL")
    val obj4NULL: Null,

    @Json(name = "none")
    val obj4None: NoneClass,

    @Json(name = "null")
    val obj4Null: NullClass,

    @Json(name = "object")
    val obj4Object: Object,

    @Json(name = "package")
    val obj4Package: Package,

    @Json(name = "protocol")
    val obj4Protocol: ProtocolClass,

    @Json(name = "ObjectMapper")
    val objectMapper: ObjectMapper,

    @Json(name = "ObjectNode")
    val objectNode: ObjectNode,

    @Json(name = "ObjectReader")
    val objectReader: ObjectReader,

    @Json(name = "ObjectWriter")
    val objectWriter: ObjectWriter,

    val of: Of,

    @Json(name = "OffsetDateTime")
    val offsetDateTime: OffsetDateTimeClass,

    @Json(name = "OffsetTime")
    val offsetTime: OffsetTime,

    val oneway: Oneway,
    val open: Open,
    val operator: Operator,
    val optional: Optional,
    val or: Or,

    @Json(name = "or_eq")
    val orEq: OrEq,

    val out: Out,
    val override: Override,
    val params: Params,
    val pass: Pass,
    val port: Port,
    val postfix: Postfix,
    val precedence: Precedence,
    val prefix: Prefix,
    val print: Print,
    val printMembers: PrintMembers,
    val printf: Printf,
    val private: Private,
    val protected: Protected,

    @Json(name = "Protocol")
    val protocol: Protocol,

    val public: Public,
    val quicktype: Quicktype,
    val raise: Raise,
    val range: Range,
    val readonly: Readonly,
    val ref: Ref,

    @Json(name = "RegExp")
    val regExp: RegExp,

    val register: Register,

    @Json(name = "reinterpret_cast")
    val reinterpretCast: ReinterpretCast
)

data class Mutable (
    val mutable: Long
)

data class Mutating (
    val mutating: Long
)

data class Namespace (
    val namespace: Long
)

data class Native (
    val native: Long
)

data class New (
    val new: Long
)

data class Newtonsoft (
    val newtonsoft: Long
)

data class Nil (
    val nil: Long
)

data class No (
    @Json(name = "NO")
    val no: Long
)

data class NoSuchMethod (
    val noSuchMethod: Long
)

data class Noexcept (
    val noexcept: Long
)

data class Nonatomic (
    val nonatomic: Long
)

data class None (
    @Json(name = "None")
    val none: Long
)

data class Nonlocal (
    val nonlocal: Long
)

data class Nonmutating (
    val nonmutating: Long
)

data class Not (
    val not: Long
)

data class NotEq (
    @Json(name = "not_eq")
    val notEq: Long
)

data class NSError (
    @Json(name = "NSError")
    val nsError: Long
)

data class NSObject (
    @Json(name = "NSObject")
    val nsObject: Long
)

data class NSString (
    @Json(name = "NSString")
    val nsString: Long
)

data class NullNode (
    @Json(name = "NullNode")
    val nullNode: Long
)

data class Nullptr (
    val nullptr: Long
)

data class Number (
    val number: Long
)

data class Null (
    @Json(name = "NULL")
    val nullNull: Long
)

data class NoneClass (
    val none: Long
)

data class NullClass (
    @Json(name = "null")
    val nullNull: Long
)

data class Object (
    @Json(name = "object")
    val objectObject: Long
)

data class Package (
    @Json(name = "package")
    val packagePackage: Long
)

data class ProtocolClass (
    val protocol: Long
)

data class ObjectMapper (
    @Json(name = "ObjectMapper")
    val objectMapper: Long
)

data class ObjectNode (
    @Json(name = "ObjectNode")
    val objectNode: Long
)

data class ObjectReader (
    @Json(name = "ObjectReader")
    val objectReader: Long
)

data class ObjectWriter (
    @Json(name = "ObjectWriter")
    val objectWriter: Long
)

data class Of (
    val of: Long
)

data class OffsetDateTimeClass (
    @Json(name = "OffsetDateTime")
    val offsetDateTime: Long
)

data class OffsetTime (
    @Json(name = "OffsetTime")
    val offsetTime: Long
)

data class Oneway (
    val oneway: Long
)

data class Open (
    val open: Long
)

data class Operator (
    val operator: Long
)

data class Optional (
    val optional: Long
)

data class Or (
    val or: Long
)

data class OrEq (
    @Json(name = "or_eq")
    val orEq: Long
)

data class Out (
    val out: Long
)

data class Override (
    val override: Long
)

data class Params (
    val params: Long
)

data class Pass (
    val pass: Long
)

data class Port (
    val port: Long
)

data class Postfix (
    val postfix: Long
)

data class Precedence (
    val precedence: Long
)

data class Prefix (
    val prefix: Long
)

data class Print (
    val print: Long
)

data class PrintMembers (
    val printMembers: Long
)

data class Printf (
    val printf: Long
)

data class Private (
    val private: Long
)

data class Protected (
    val protected: Long
)

data class Protocol (
    @Json(name = "Protocol")
    val protocol: Long
)

data class Public (
    val public: Long
)

data class Quicktype (
    val quicktype: Long
)

data class Raise (
    val raise: Long
)

data class Range (
    val range: Long
)

data class Readonly (
    val readonly: Long
)

data class Ref (
    val ref: Long
)

data class RegExp (
    @Json(name = "RegExp")
    val regExp: String
)

data class Register (
    val register: Long
)

data class ReinterpretCast (
    @Json(name = "reinterpret_cast")
    val reinterpretCast: Long
)

data class Obj5 (
    val dummy: Long,

    @Json(name = "KSerializer")
    val kSerializer: KSerializer,

    @Json(name = "return")
    val obj5Return: Return,

    @Json(name = "self")
    val obj5Self: SelfClass,

    @Json(name = "super")
    val obj5Super: Super,

    @Json(name = "this")
    val obj5This: This,

    @Json(name = "throw")
    val obj5Throw: Throw,

    @Json(name = "True")
    val obj5True: True,

    @Json(name = "PrimitiveKind")
    val primitiveKind: PrimitiveKind,

    @Json(name = "true")
    val purpleTrue: TrueClass,

    val repeat: Repeat,
    val require: Require,
    val required: Required,
    val requires: Requires,
    val restrict: Restrict,
    val retain: Retain,
    val rethrows: Rethrows,
    val right: Right,
    val runtimeType: RuntimeType,
    val s: S,
    val sbyte: Sbyte,
    val sealed: Sealed,

    @Json(name = "SEL")
    val sel: Sel,

    val select: Select,

    @Json(name = "Self")
    val self: Self,

    @Json(name = "Sendable")
    val sendable: Sendable,

    @Json(name = "SerialDescriptor")
    val serialDescriptor: SerialDescriptor,

    @Json(name = "SerialName")
    val serialName: SerialName,

    @Json(name = "Serializable")
    val serializable: Serializable,

    @Json(name = "SerializationFeature")
    val serializationFeature: SerializationFeature,

    val serialize: Serialize,

    @Json(name = "SerializerProvider")
    val serializerProvider: SerializerProvider,

    val set: Set,
    val short: ShortClass,
    val signed: Signed,

    @Json(name = "SimpleModule")
    val simpleModule: SimpleModule,

    val sizeof: Sizeof,
    val stackalloc: Stackalloc,

    @Json(name = "Standards")
    val standards: Standards,

    val static: Static,

    @Json(name = "static_assert")
    val staticAssert: StaticAssert,

    @Json(name = "static_cast")
    val staticCast: StaticCast,

    @Json(name = "StdDeserializer")
    val stdDeserializer: StdDeserializer,

    @Json(name = "StdSerializer")
    val stdSerializer: StdSerializer,

    val strictfp: Strictfp,
    val string: StringClass,
    val struct: Struct,
    val subscript: Subscript,
    val switch: Switch,
    val symbol: Symbol,
    val synchronized: Synchronized,
    val system: SystemClass,
    val template: Template,

    @Json(name = "TextNode")
    val textNode: TextNode,

    val then: Then,

    @Json(name = "thread_local")
    val threadLocal: ThreadLocal,

    val throws: Throws,

    @Json(name = "TimeOnly")
    val timeOnly: TimeOnly,

    @Json(name = "TimeOnlyConverter")
    val timeOnlyConverter: TimeOnlyConverter,

    @Json(name = "TimeZone")
    val timeZone: TimeZone,

    @Json(name = "to_dict")
    val toDict: ToDict,

    @Json(name = "to_json")
    val toJSON: ToJSON,

    val toString: ToString,

    @Json(name = "top_level")
    val topLevel: TopLevelClass,

    val transient: Transient
)

data class KSerializer (
    @Json(name = "KSerializer")
    val kSerializer: Long
)

data class Return (
    @Json(name = "return")
    val returnReturn: Long
)

data class SelfClass (
    val self: Long
)

data class Super (
    @Json(name = "super")
    val superSuper: Long
)

data class This (
    @Json(name = "this")
    val thisThis: Long
)

data class Throw (
    @Json(name = "throw")
    val throwThrow: Long
)

data class True (
    @Json(name = "True")
    val trueTrue: Long
)

data class PrimitiveKind (
    @Json(name = "PrimitiveKind")
    val primitiveKind: Long
)

data class TrueClass (
    @Json(name = "true")
    val trueTrue: Long
)

data class Repeat (
    val repeat: Long
)

data class Require (
    val require: Long
)

data class Required (
    val required: Long
)

data class Requires (
    val requires: Long
)

data class Restrict (
    val restrict: Long
)

data class Retain (
    val retain: Long
)

data class Rethrows (
    val rethrows: Long
)

data class Right (
    val right: Long
)

data class RuntimeType (
    val runtimeType: Long
)

data class S (
    val s: Long
)

data class Sbyte (
    val sbyte: Long
)

data class Sealed (
    val sealed: Long
)

data class Sel (
    @Json(name = "SEL")
    val sel: Long
)

data class Select (
    val select: Long
)

data class Self (
    @Json(name = "Self")
    val self: Long
)

data class Sendable (
    @Json(name = "Sendable")
    val sendable: Long
)

data class SerialDescriptor (
    @Json(name = "SerialDescriptor")
    val serialDescriptor: Long
)

data class SerialName (
    @Json(name = "SerialName")
    val serialName: Long
)

data class Serializable (
    @Json(name = "Serializable")
    val serializable: Long
)

data class SerializationFeature (
    @Json(name = "SerializationFeature")
    val serializationFeature: Long
)

data class Serialize (
    val serialize: Long
)

data class SerializerProvider (
    @Json(name = "SerializerProvider")
    val serializerProvider: Long
)

data class Set (
    val set: Long
)

data class ShortClass (
    val short: Long
)

data class Signed (
    val signed: Long
)

data class SimpleModule (
    @Json(name = "SimpleModule")
    val simpleModule: Long
)

data class Sizeof (
    val sizeof: Long
)

data class Stackalloc (
    val stackalloc: Long
)

data class Standards (
    @Json(name = "Standards")
    val standards: Long
)

data class Static (
    val static: Long
)

data class StaticAssert (
    @Json(name = "static_assert")
    val staticAssert: Long
)

data class StaticCast (
    @Json(name = "static_cast")
    val staticCast: Long
)

data class StdDeserializer (
    @Json(name = "StdDeserializer")
    val stdDeserializer: Long
)

data class StdSerializer (
    @Json(name = "StdSerializer")
    val stdSerializer: Long
)

data class Strictfp (
    val strictfp: Long
)

data class StringClass (
    val string: Long
)

data class Struct (
    val struct: Long
)

data class Subscript (
    val subscript: Long
)

data class Switch (
    val switch: Long
)

data class Symbol (
    val symbol: Long
)

data class Synchronized (
    val synchronized: Long
)

data class SystemClass (
    val system: Long
)

data class Template (
    val template: Long
)

data class TextNode (
    @Json(name = "TextNode")
    val textNode: Long
)

data class Then (
    val then: Long
)

data class ThreadLocal (
    @Json(name = "thread_local")
    val threadLocal: Long
)

data class Throws (
    val throws: Long
)

data class TimeOnly (
    @Json(name = "TimeOnly")
    val timeOnly: Long
)

data class TimeOnlyConverter (
    @Json(name = "TimeOnlyConverter")
    val timeOnlyConverter: Long
)

data class TimeZone (
    @Json(name = "TimeZone")
    val timeZone: Long
)

data class ToDict (
    @Json(name = "to_dict")
    val toDict: Long
)

data class ToJSON (
    @Json(name = "to_json")
    val toJSON: Long
)

data class ToString (
    val toString: Long
)

data class TopLevelClass (
    @Json(name = "top_level")
    val topLevel: Long
)

data class Transient (
    val transient: Long
)

data class Obj6 (
    val dummy: Long,

    @Json(name = "try")
    val obj6Try: Try,

    @Json(name = "type")
    val obj6Type: TypeClass,

    @Json(name = "typealias")
    val obj6Typealias: Typealias,

    @Json(name = "typeof")
    val obj6Typeof: Typeof,

    @Json(name = "var")
    val obj6Var: Var,

    @Json(name = "while")
    val obj6While: While,

    @Json(name = "Type")
    val type: Type,

    val typedef: Typedef,
    val typeid: Typeid,
    val typename: Typename,
    val uint: Uint,
    val ulong: Ulong,
    val unchecked: Unchecked,
    val undefined: Undefined,
    val union: Union,

    @Json(name = "UnmarshalJSON")
    val unmarshalJSON: UnmarshalJSON,

    val unowned: Unowned,
    val unsafe: Unsafe,
    val unsigned: Unsigned,

    @Json(name = "UseSerializers")
    val useSerializers: UseSerializers,

    val ushort: Ushort,
    val using: Using,

    @Json(name = "Utf8JsonReader")
    val utf8JSONReader: Utf8JSONReader,

    @Json(name = "Utf8JsonWriter")
    val utf8JSONWriter: Utf8JSONWriter,

    @Json(name = "UUID")
    val uuid: UUID,

    val virtual: Virtual,
    val void: Void,
    val volatile: Volatile,

    @Json(name = "wchar_t")
    val wcharT: WcharT,

    val weak: Weak,
    val where: Where,
    val willSet: WillSet,
    val with: With,
    val xor: Xor,

    @Json(name = "xor_eq")
    val xorEq: XorEq,

    @Json(name = "YES")
    val yes: Yes,

    val yield: Yield
)

data class Try (
    @Json(name = "try")
    val tryTry: Long
)

data class TypeClass (
    val type: Long
)

data class Typealias (
    @Json(name = "typealias")
    val typealiasTypealias: Long
)

data class Typeof (
    @Json(name = "typeof")
    val typeofTypeof: Long
)

data class Var (
    @Json(name = "var")
    val varVar: Long
)

data class While (
    @Json(name = "while")
    val whileWhile: Long
)

data class Type (
    @Json(name = "Type")
    val type: Long
)

data class Typedef (
    val typedef: Long
)

data class Typeid (
    val typeid: Long
)

data class Typename (
    val typename: Long
)

data class Uint (
    val uint: Long
)

data class Ulong (
    val ulong: Long
)

data class Unchecked (
    val unchecked: Long
)

data class Undefined (
    val undefined: Long
)

data class Union (
    val union: Long
)

data class UnmarshalJSON (
    @Json(name = "UnmarshalJSON")
    val unmarshalJSON: Long
)

data class Unowned (
    val unowned: Long
)

data class Unsafe (
    val unsafe: Long
)

data class Unsigned (
    val unsigned: Long
)

data class UseSerializers (
    @Json(name = "UseSerializers")
    val useSerializers: Long
)

data class Ushort (
    val ushort: Long
)

data class Using (
    val using: Long
)

data class Utf8JSONReader (
    @Json(name = "Utf8JsonReader")
    val utf8JSONReader: Long
)

data class Utf8JSONWriter (
    @Json(name = "Utf8JsonWriter")
    val utf8JSONWriter: Long
)

data class UUID (
    @Json(name = "UUID")
    val uuid: Long
)

data class Virtual (
    val virtual: Long
)

data class Void (
    val void: Long
)

data class Volatile (
    val volatile: Long
)

data class WcharT (
    @Json(name = "wchar_t")
    val wcharT: Long
)

data class Weak (
    val weak: Long
)

data class Where (
    val where: Long
)

data class WillSet (
    val willSet: Long
)

data class With (
    val with: Long
)

data class Xor (
    val xor: Long
)

data class XorEq (
    @Json(name = "xor_eq")
    val xorEq: Long
)

data class Yes (
    @Json(name = "YES")
    val yes: Long
)

data class Yield (
    val yield: Long
)
