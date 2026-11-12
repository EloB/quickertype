// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val dummy: Long,
    val obj1: Obj1,
    val obj2: Obj2,
    val obj3: Obj3,
    val obj4: Obj4,
    val obj5: Obj5,
    val obj6: Obj6
)

@Serializable
data class Obj1 (
    val abstract: Abstract,
    val alignas: Alignas,
    val alignof: Alignof,
    val and: And,

    @SerialName("and_eq")
    val andEq: AndEq,

    @SerialName("Any")
    val any: AnyClass,

    val array: ArrayClass,

    @SerialName("ArrayNode")
    val arrayNode: ArrayNode,

    val asm: ASM,
    val assert: Assert,
    val associatedtype: Associatedtype,
    val associativity: Associativity,
    val async: Async,
    val atomic: Atomic,

    @SerialName("atomic_cancel")
    val atomicCancel: AtomicCancel,

    @SerialName("atomic_commit")
    val atomicCommit: AtomicCommit,

    @SerialName("atomic_noexcept")
    val atomicNoexcept: AtomicNoexcept,

    val auto: Auto,
    val await: Await,
    val base: Base,
    val bitand: Bitand,
    val bitor: Bitor,

    @SerialName("BOOL")
    val bool: Bool,

    val boolean: BooleanClass,

    @SerialName("BooleanNode")
    val booleanNode: BooleanNode,

    val bycopy: Bycopy,
    val byref: Byref,
    val byte: ByteClass,

    @SerialName("Calendar")
    val calendar: Calendar,

    val case: Case,
    val catch: Catch,
    val chan: Chan,
    val char: Char,

    @SerialName("char16_t")
    val char16T: Char16T,

    @SerialName("char32_t")
    val char32T: Char32T,

    val checked: Checked,
    val clone: Clone,

    @SerialName("co_await")
    val coAwait: CoAwait,

    @SerialName("co_return")
    val coReturn: CoReturn,

    @SerialName("co_yield")
    val coYield: CoYield,

    @SerialName("Codable")
    val codable: Codable,

    @SerialName("CodingKey")
    val codingKey: CodingKey,

    @SerialName("CodingKeys")
    val codingKeys: CodingKeys,

    val compl: Compl,

    @SerialName("_Complex")
    val complex: Complex,

    val concept: Concept,
    val console: Console,
    val const: Const,

    @SerialName("const_cast")
    val constCast: ConstCast,

    val constexpr: Constexpr,
    val constructor: Constructor,
    val convenience: Convenience,
    val convert: Convert,
    val converter: ConverterClass,
    val dummy: Long,

    @SerialName("_")
    val empty: Empty,

    @SerialName("_Imaginery")
    val imaginery: Imaginery,

    @SerialName("any")
    val obj1Any: Obj1Any,

    @SerialName("as")
    val obj1As: As,

    @SerialName("_Bool")
    val obj1Bool: BoolClass,

    @SerialName("break")
    val obj1Break: Break,

    @SerialName("Class")
    val obj1Class: ClassClass,

    @SerialName("continue")
    val obj1Continue: Continue,

    @SerialName("bool")
    val purpleBool: Obj1Bool,

    @SerialName("class")
    val purpleClass: Obj1Class
)

@Serializable
data class Abstract (
    val abstract: Long
)

@Serializable
data class Alignas (
    val alignas: Long
)

@Serializable
data class Alignof (
    val alignof: Long
)

@Serializable
data class And (
    val and: Long
)

@Serializable
data class AndEq (
    @SerialName("and_eq")
    val andEq: Long
)

@Serializable
data class AnyClass (
    @SerialName("Any")
    val any: Long
)

@Serializable
data class ArrayClass (
    val array: Long
)

@Serializable
data class ArrayNode (
    @SerialName("ArrayNode")
    val arrayNode: Long
)

@Serializable
data class ASM (
    val asm: Long
)

@Serializable
data class Assert (
    val assert: Long
)

@Serializable
data class Associatedtype (
    val associatedtype: Long
)

@Serializable
data class Associativity (
    val associativity: Long
)

@Serializable
data class Async (
    val async: Long
)

@Serializable
data class Atomic (
    val atomic: Long
)

@Serializable
data class AtomicCancel (
    @SerialName("atomic_cancel")
    val atomicCancel: Long
)

@Serializable
data class AtomicCommit (
    @SerialName("atomic_commit")
    val atomicCommit: Long
)

@Serializable
data class AtomicNoexcept (
    @SerialName("atomic_noexcept")
    val atomicNoexcept: Long
)

@Serializable
data class Auto (
    val auto: Long
)

@Serializable
data class Await (
    val await: Long
)

@Serializable
data class Base (
    val base: Long
)

@Serializable
data class Bitand (
    val bitand: Long
)

@Serializable
data class Bitor (
    val bitor: Long
)

@Serializable
data class Bool (
    @SerialName("BOOL")
    val bool: Long
)

@Serializable
data class BooleanClass (
    val boolean: Long
)

@Serializable
data class BooleanNode (
    @SerialName("BooleanNode")
    val booleanNode: Long
)

@Serializable
data class Bycopy (
    val bycopy: Long
)

@Serializable
data class Byref (
    val byref: Long
)

@Serializable
data class ByteClass (
    val byte: Long
)

@Serializable
data class Calendar (
    @SerialName("Calendar")
    val calendar: Long
)

@Serializable
data class Case (
    val case: Long
)

@Serializable
data class Catch (
    val catch: Long
)

@Serializable
data class Chan (
    val chan: Long
)

@Serializable
data class Char (
    val char: Long
)

@Serializable
data class Char16T (
    @SerialName("char16_t")
    val char16T: Long
)

@Serializable
data class Char32T (
    @SerialName("char32_t")
    val char32T: Long
)

@Serializable
data class Checked (
    val checked: Long
)

@Serializable
data class Clone (
    val clone: Long
)

@Serializable
data class CoAwait (
    @SerialName("co_await")
    val coAwait: Long
)

@Serializable
data class CoReturn (
    @SerialName("co_return")
    val coReturn: Long
)

@Serializable
data class CoYield (
    @SerialName("co_yield")
    val coYield: Long
)

@Serializable
data class Codable (
    @SerialName("Codable")
    val codable: Long
)

@Serializable
data class CodingKey (
    @SerialName("CodingKey")
    val codingKey: Long
)

@Serializable
data class CodingKeys (
    @SerialName("CodingKeys")
    val codingKeys: Long
)

@Serializable
data class Compl (
    val compl: Long
)

@Serializable
data class Complex (
    @SerialName("_Complex")
    val complex: Long
)

@Serializable
data class Concept (
    val concept: Long
)

@Serializable
data class Console (
    val console: Long
)

@Serializable
data class Const (
    val const: Long
)

@Serializable
data class ConstCast (
    @SerialName("const_cast")
    val constCast: Long
)

@Serializable
data class Constexpr (
    val constexpr: Long
)

@Serializable
data class Constructor (
    val constructor: Long
)

@Serializable
data class Convenience (
    val convenience: Long
)

@Serializable
data class Convert (
    val convert: Long
)

@Serializable
data class ConverterClass (
    val converter: Long
)

@Serializable
data class Empty (
    @SerialName("_")
    val empty: Long
)

@Serializable
data class Imaginery (
    @SerialName("_Imaginery")
    val imaginery: Long
)

@Serializable
data class Obj1Any (
    val any: Long
)

@Serializable
data class As (
    @SerialName("as")
    val asAs: Long
)

@Serializable
data class BoolClass (
    @SerialName("_Bool")
    val bool: Long
)

@Serializable
data class Break (
    @SerialName("break")
    val breakBreak: Long
)

@Serializable
data class ClassClass (
    @SerialName("Class")
    val classClass: Long
)

@Serializable
data class Continue (
    @SerialName("continue")
    val continueContinue: Long
)

@Serializable
data class Obj1Bool (
    val bool: Long
)

@Serializable
data class Obj1Class (
    @SerialName("class")
    val classClass: Long
)

@Serializable
data class Obj2 (
    @SerialName("CultureInfo")
    val cultureInfo: CultureInfo,

    val date: Date,

    @SerialName("DateFormatter")
    val dateFormatter: DateFormatter,

    @SerialName("DateOnly")
    val dateOnly: DateOnly,

    @SerialName("DateOnlyConverter")
    val dateOnlyConverter: DateOnlyConverter,

    @SerialName("date_parse_handling")
    val dateParseHandling: DateParseHandling,

    @SerialName("DateTime")
    val dateTime: DateTime,

    @SerialName("DateTimeStyles")
    val dateTimeStyles: DateTimeStyles,

    val debugger: Debugger,
    val decimal: Decimal,
    val declare: Declare,
    val decltype: Decltype,

    @SerialName("decode_string")
    val decodeString: DecodeString,

    @SerialName("Decoder")
    val decoder: DecoderClass,

    @SerialName("DecodingError")
    val decodingError: DecodingError,

    val def: Def,
    val default: Default,
    val defer: Defer,
    val deinit: Deinit,
    val del: Del,
    val delegate: Delegate,
    val delete: Delete,

    @SerialName("DeserializationFeature")
    val deserializationFeature: DeserializationFeature,

    val dict: Dict,
    val dictionary: Dictionary,
    val didSet: DidSet,
    val double: DoubleClass,

    @SerialName("DoubleNode")
    val doubleNode: DoubleNode,

    val dummy: Long,
    val dynamic: Dynamic,

    @SerialName("dynamic_cast")
    val dynamicCast: DynamicCast,

    val elif: Elif,

    @SerialName("encode_quick_type")
    val encodeQuickType: EncodeQuickType,

    @SerialName("Encoder")
    val encoder: EncoderClass,

    val enum: EnumClass,

    @SerialName("EnumValues")
    val enumValues: EnumValues,

    val equalityContract: EqualityContract,

    @SerialName("Equatable")
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

    @SerialName("FormatException")
    val formatException: FormatException,

    val friend: Friend,
    val from: From,

    @SerialName("from_dict")
    val fromDict: FromDict,

    @SerialName("from_json")
    val fromJSON: FromJSON,

    val func: Func,

    @SerialName("do")
    val obj2Do: Do,

    @SerialName("else")
    val obj2Else: Else,

    @SerialName("False")
    val obj2False: False,

    @SerialName("for")
    val obj2For: For,

    @SerialName("false")
    val purpleFalse: FalseClass
)

@Serializable
data class CultureInfo (
    @SerialName("CultureInfo")
    val cultureInfo: Long
)

@Serializable
data class Date (
    val date: Long
)

@Serializable
data class DateFormatter (
    @SerialName("DateFormatter")
    val dateFormatter: Long
)

@Serializable
data class DateOnly (
    @SerialName("DateOnly")
    val dateOnly: Long
)

@Serializable
data class DateOnlyConverter (
    @SerialName("DateOnlyConverter")
    val dateOnlyConverter: Long
)

@Serializable
data class DateParseHandling (
    @SerialName("date_parse_handling")
    val dateParseHandling: Long
)

@Serializable
data class DateTime (
    @SerialName("DateTime")
    val dateTime: OffsetDateTime
)

@Serializable
data class DateTimeStyles (
    @SerialName("DateTimeStyles")
    val dateTimeStyles: Long
)

@Serializable
data class Debugger (
    val debugger: Long
)

@Serializable
data class Decimal (
    val decimal: Long
)

@Serializable
data class Declare (
    val declare: Long
)

@Serializable
data class Decltype (
    val decltype: Long
)

@Serializable
data class DecodeString (
    @SerialName("decode_string")
    val decodeString: Long
)

@Serializable
data class DecoderClass (
    @SerialName("Decoder")
    val decoder: Long
)

@Serializable
data class DecodingError (
    @SerialName("DecodingError")
    val decodingError: Long
)

@Serializable
data class Def (
    val def: Long
)

@Serializable
data class Default (
    val default: Long
)

@Serializable
data class Defer (
    val defer: Long
)

@Serializable
data class Deinit (
    val deinit: Long
)

@Serializable
data class Del (
    val del: Long
)

@Serializable
data class Delegate (
    val delegate: Long
)

@Serializable
data class Delete (
    val delete: Long
)

@Serializable
data class DeserializationFeature (
    @SerialName("DeserializationFeature")
    val deserializationFeature: Long
)

@Serializable
data class Dict (
    val dict: Long
)

@Serializable
data class Dictionary (
    val dictionary: Long
)

@Serializable
data class DidSet (
    val didSet: Long
)

@Serializable
data class DoubleClass (
    val double: Long
)

@Serializable
data class DoubleNode (
    @SerialName("DoubleNode")
    val doubleNode: Long
)

@Serializable
data class Dynamic (
    val dynamic: Long
)

@Serializable
data class DynamicCast (
    @SerialName("dynamic_cast")
    val dynamicCast: Long
)

@Serializable
data class Elif (
    val elif: Long
)

@Serializable
data class EncodeQuickType (
    @SerialName("encode_quick_type")
    val encodeQuickType: Long
)

@Serializable
data class EncoderClass (
    @SerialName("Encoder")
    val encoder: Long
)

@Serializable
data class EnumClass (
    val enum: Long
)

@Serializable
data class EnumValues (
    @SerialName("EnumValues")
    val enumValues: List<EnumValue>
)

@Serializable
enum class EnumValue(val value: String) {
    @SerialName("ready") Ready("ready"),
    @SerialName("done") Done("done");
}

@Serializable
data class EqualityContract (
    val equalityContract: Long
)

@Serializable
data class Equatable (
    @SerialName("Equatable")
    val equatable: Long
)

@Serializable
data class Event (
    val event: Long
)

@Serializable
data class Except (
    val except: Long
)

@Serializable
data class Exception (
    val exception: Long
)

@Serializable
data class Explicit (
    val explicit: Long
)

@Serializable
data class Export (
    val export: Long
)

@Serializable
data class Exposing (
    val exposing: Long
)

@Serializable
data class Extends (
    val extends: Long
)

@Serializable
data class Extension (
    val extension: Long
)

@Serializable
data class Extern (
    val extern: Long
)

@Serializable
data class Fallthrough (
    val fallthrough: Long
)

@Serializable
data class Fileprivate (
    val fileprivate: Long
)

@Serializable
data class Final (
    val final: Long
)

@Serializable
data class Finally (
    val finally: Long
)

@Serializable
data class Fixed (
    val fixed: Long
)

@Serializable
data class FloatClass (
    val float: Long
)

@Serializable
data class Foreach (
    val foreach: Long
)

@Serializable
data class FormatException (
    @SerialName("FormatException")
    val formatException: Long
)

@Serializable
data class Friend (
    val friend: Long
)

@Serializable
data class From (
    val from: Long
)

@Serializable
data class FromDict (
    @SerialName("from_dict")
    val fromDict: Long
)

@Serializable
data class FromJSON (
    @SerialName("from_json")
    val fromJSON: Long
)

@Serializable
data class Func (
    val func: Long
)

@Serializable
data class Do (
    @SerialName("do")
    val doDo: Long
)

@Serializable
data class Else (
    @SerialName("else")
    val elseElse: Long
)

@Serializable
data class False (
    @SerialName("False")
    val falseFalse: Long
)

@Serializable
data class For (
    @SerialName("for")
    val forFor: Long
)

@Serializable
data class FalseClass (
    @SerialName("false")
    val falseFalse: Long
)

@Serializable
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

    @SerialName("Hashable")
    val hashable: Hashable,

    @SerialName("Hasher")
    val hasher: Hasher,

    val id: ID,

    @SerialName("IMP")
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

    @SerialName("IntNode")
    val intNode: IntNode,

    val internal: Internal,

    @SerialName("IsoDateTimeOffsetConverter")
    val isoDateTimeOffsetConverter: ISODateTimeOffsetConverter,

    val iterable: Iterable,
    val jdec: Jdec,
    val jenc: Jenc,
    val jpipe: Jpipe,
    val json: JSON,

    @SerialName("JSONAny")
    val jsonAny: JSONAny,

    @SerialName("JSONCodingKey")
    val jsonCodingKey: JSONCodingKey,

    @SerialName("json_converter")
    val jsonConverter: JSONConverter,

    @SerialName("JSONDecoder")
    val jsonDecoder: JSONDecoder,

    @SerialName("JSONEncoder")
    val jsonEncoder: JSONEncoder,

    @SerialName("JsonException")
    val jsonException: JSONException,

    @SerialName("JsonGenerator")
    val jsonGenerator: JSONGenerator,

    @SerialName("JsonNode")
    val jsonNode: JSONNode,

    @SerialName("JSONNull")
    val jsonNull: JSONNull,

    @SerialName("JsonParser")
    val jsonParser: JSONParser,

    @SerialName("JsonReader")
    val jsonReader: JSONReader,

    @SerialName("json_serializer")
    val jsonSerializer: JSONSerializer,

    @SerialName("json_token")
    val jsonToken: JSONToken,

    @SerialName("JsonTokenType")
    val jsonTokenType: JSONTokenType,

    @SerialName("json_writer")
    val jsonWriter: JSONWriter,

    val lambda: Lambda,
    val lazy: Lazy,
    val left: Left,
    val let: Let,
    val list: ListClass,

    @SerialName("LocalDate")
    val localDate: LocalDate,

    @SerialName("Locale")
    val locale: Locale,

    val lock: Lock,
    val long: LongClass,

    @SerialName("LongNode")
    val longNode: LongNode,

    val map: MapClass,

    @SerialName("MapEntry")
    val mapEntry: MapEntry,

    @SerialName("MarshalJSON")
    val marshalJSON: MarshalJSON,

    @SerialName("metadata_property_handling")
    val metadataPropertyHandling: MetadataPropertyHandling,

    val module: Module,

    @SerialName("if")
    val obj3If: If,

    @SerialName("in")
    val obj3In: In,

    @SerialName("interface")
    val obj3Interface: Interface,

    @SerialName("is")
    val obj3Is: Is
)

@Serializable
data class Function (
    val function: Long
)

@Serializable
data class Get (
    val get: Long
)

@Serializable
data class Global (
    val global: Long
)

@Serializable
data class Go (
    val go: Long
)

@Serializable
data class Goto (
    val goto: Long
)

@Serializable
data class Guard (
    val guard: Long
)

@Serializable
data class HasOwnProperty (
    val hasOwnProperty: Long
)

@Serializable
data class HashCode (
    val hashCode: Long
)

@Serializable
data class Hashable (
    @SerialName("Hashable")
    val hashable: Long
)

@Serializable
data class Hasher (
    @SerialName("Hasher")
    val hasher: Long
)

@Serializable
data class ID (
    val id: Long
)

@Serializable
data class Imp (
    @SerialName("IMP")
    val imp: Long
)

@Serializable
data class Implements (
    val implements: Long
)

@Serializable
data class Implicit (
    val implicit: Long
)

@Serializable
data class Import (
    val import: Long
)

@Serializable
data class Indirect (
    val indirect: Long
)

@Serializable
data class Infix (
    val infix: Long
)

@Serializable
data class Init (
    val init: Long
)

@Serializable
data class Inline (
    val inline: Long
)

@Serializable
data class Inout (
    val inout: Long
)

@Serializable
data class Instanceof (
    val instanceof: Long
)

@Serializable
data class IntClass (
    val int: Long
)

@Serializable
data class IntNode (
    @SerialName("IntNode")
    val intNode: Long
)

@Serializable
data class Internal (
    val internal: Long
)

@Serializable
data class ISODateTimeOffsetConverter (
    @SerialName("IsoDateTimeOffsetConverter")
    val isoDateTimeOffsetConverter: Long
)

@Serializable
data class Iterable (
    val iterable: Long
)

@Serializable
data class Jdec (
    val jdec: Long
)

@Serializable
data class Jenc (
    val jenc: Long
)

@Serializable
data class Jpipe (
    val jpipe: Long
)

@Serializable
data class JSON (
    val json: Long
)

@Serializable
data class JSONAny (
    @SerialName("JSONAny")
    val jsonAny: JsonElement? = null
)

@Serializable
data class JSONCodingKey (
    @SerialName("JSONCodingKey")
    val jsonCodingKey: Long
)

@Serializable
data class JSONConverter (
    @SerialName("json_converter")
    val jsonConverter: Long
)

@Serializable
data class JSONDecoder (
    @SerialName("JSONDecoder")
    val jsonDecoder: Long
)

@Serializable
data class JSONEncoder (
    @SerialName("JSONEncoder")
    val jsonEncoder: Long
)

@Serializable
data class JSONException (
    @SerialName("JsonException")
    val jsonException: Long
)

@Serializable
data class JSONGenerator (
    @SerialName("JsonGenerator")
    val jsonGenerator: Long
)

@Serializable
data class JSONNode (
    @SerialName("JsonNode")
    val jsonNode: Long
)

@Serializable
data class JSONNull (
    @SerialName("JSONNull")
    val jsonNull: Long
)

@Serializable
data class JSONParser (
    @SerialName("JsonParser")
    val jsonParser: Long
)

@Serializable
data class JSONReader (
    @SerialName("JsonReader")
    val jsonReader: Long
)

@Serializable
data class JSONSerializer (
    @SerialName("json_serializer")
    val jsonSerializer: Long
)

@Serializable
data class JSONToken (
    @SerialName("json_token")
    val jsonToken: Long
)

@Serializable
data class JSONTokenType (
    @SerialName("JsonTokenType")
    val jsonTokenType: Long
)

@Serializable
data class JSONWriter (
    @SerialName("json_writer")
    val jsonWriter: Long
)

@Serializable
data class Lambda (
    val lambda: Long
)

@Serializable
data class Lazy (
    val lazy: Long
)

@Serializable
data class Left (
    val left: Long
)

@Serializable
data class Let (
    val let: Long
)

@Serializable
data class ListClass (
    val list: Long
)

@Serializable
data class LocalDate (
    @SerialName("LocalDate")
    val localDate: Long
)

@Serializable
data class Locale (
    @SerialName("Locale")
    val locale: Long
)

@Serializable
data class Lock (
    val lock: Long
)

@Serializable
data class LongClass (
    val long: Long
)

@Serializable
data class LongNode (
    @SerialName("LongNode")
    val longNode: Long
)

@Serializable
data class MapClass (
    val map: Long
)

@Serializable
data class MapEntry (
    @SerialName("MapEntry")
    val mapEntry: Long
)

@Serializable
data class MarshalJSON (
    @SerialName("MarshalJSON")
    val marshalJSON: Long
)

@Serializable
data class MetadataPropertyHandling (
    @SerialName("metadata_property_handling")
    val metadataPropertyHandling: Long
)

@Serializable
data class Module (
    val module: Long
)

@Serializable
data class If (
    @SerialName("if")
    val ifIf: Long
)

@Serializable
data class In (
    @SerialName("in")
    val inIn: Long
)

@Serializable
data class Interface (
    @SerialName("interface")
    val interfaceInterface: Long
)

@Serializable
data class Is (
    @SerialName("is")
    val isIs: Long
)

@Serializable
data class Obj4 (
    val dummy: Long,
    val mutable: Mutable,
    val mutating: Mutating,
    val namespace: Namespace,
    val native: Native,
    val new: New,
    val newtonsoft: Newtonsoft,
    val nil: Nil,

    @SerialName("NO")
    val no: No,

    val noSuchMethod: NoSuchMethod,
    val noexcept: Noexcept,
    val nonatomic: Nonatomic,

    @SerialName("None")
    val none: None,

    val nonlocal: Nonlocal,
    val nonmutating: Nonmutating,
    val not: Not,

    @SerialName("not_eq")
    val notEq: NotEq,

    @SerialName("NSError")
    val nsError: NSError,

    @SerialName("NSObject")
    val nsObject: NSObject,

    @SerialName("NSString")
    val nsString: NSString,

    @SerialName("NullNode")
    val nullNode: NullNode,

    val nullptr: Nullptr,
    val number: Number,

    @SerialName("NULL")
    val obj4NULL: Null,

    @SerialName("none")
    val obj4None: NoneClass,

    @SerialName("null")
    val obj4Null: NullClass,

    @SerialName("object")
    val obj4Object: Object,

    @SerialName("package")
    val obj4Package: Package,

    @SerialName("protocol")
    val obj4Protocol: ProtocolClass,

    @SerialName("ObjectMapper")
    val objectMapper: ObjectMapper,

    @SerialName("ObjectNode")
    val objectNode: ObjectNode,

    @SerialName("ObjectReader")
    val objectReader: ObjectReader,

    @SerialName("ObjectWriter")
    val objectWriter: ObjectWriter,

    val of: Of,

    @SerialName("OffsetDateTime")
    val offsetDateTime: OffsetDateTimeClass,

    @SerialName("OffsetTime")
    val offsetTime: OffsetTime,

    val oneway: Oneway,
    val open: Open,
    val operator: Operator,
    val optional: Optional,
    val or: Or,

    @SerialName("or_eq")
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

    @SerialName("Protocol")
    val protocol: Protocol,

    val public: Public,
    val quicktype: Quicktype,
    val raise: Raise,
    val range: Range,
    val readonly: Readonly,
    val ref: Ref,

    @SerialName("RegExp")
    val regExp: RegExp,

    val register: Register,

    @SerialName("reinterpret_cast")
    val reinterpretCast: ReinterpretCast
)

@Serializable
data class Mutable (
    val mutable: Long
)

@Serializable
data class Mutating (
    val mutating: Long
)

@Serializable
data class Namespace (
    val namespace: Long
)

@Serializable
data class Native (
    val native: Long
)

@Serializable
data class New (
    val new: Long
)

@Serializable
data class Newtonsoft (
    val newtonsoft: Long
)

@Serializable
data class Nil (
    val nil: Long
)

@Serializable
data class No (
    @SerialName("NO")
    val no: Long
)

@Serializable
data class NoSuchMethod (
    val noSuchMethod: Long
)

@Serializable
data class Noexcept (
    val noexcept: Long
)

@Serializable
data class Nonatomic (
    val nonatomic: Long
)

@Serializable
data class None (
    @SerialName("None")
    val none: Long
)

@Serializable
data class Nonlocal (
    val nonlocal: Long
)

@Serializable
data class Nonmutating (
    val nonmutating: Long
)

@Serializable
data class Not (
    val not: Long
)

@Serializable
data class NotEq (
    @SerialName("not_eq")
    val notEq: Long
)

@Serializable
data class NSError (
    @SerialName("NSError")
    val nsError: Long
)

@Serializable
data class NSObject (
    @SerialName("NSObject")
    val nsObject: Long
)

@Serializable
data class NSString (
    @SerialName("NSString")
    val nsString: Long
)

@Serializable
data class NullNode (
    @SerialName("NullNode")
    val nullNode: Long
)

@Serializable
data class Nullptr (
    val nullptr: Long
)

@Serializable
data class Number (
    val number: Long
)

@Serializable
data class Null (
    @SerialName("NULL")
    val nullNull: Long
)

@Serializable
data class NoneClass (
    val none: Long
)

@Serializable
data class NullClass (
    @SerialName("null")
    val nullNull: Long
)

@Serializable
data class Object (
    @SerialName("object")
    val objectObject: Long
)

@Serializable
data class Package (
    @SerialName("package")
    val packagePackage: Long
)

@Serializable
data class ProtocolClass (
    val protocol: Long
)

@Serializable
data class ObjectMapper (
    @SerialName("ObjectMapper")
    val objectMapper: Long
)

@Serializable
data class ObjectNode (
    @SerialName("ObjectNode")
    val objectNode: Long
)

@Serializable
data class ObjectReader (
    @SerialName("ObjectReader")
    val objectReader: Long
)

@Serializable
data class ObjectWriter (
    @SerialName("ObjectWriter")
    val objectWriter: Long
)

@Serializable
data class Of (
    val of: Long
)

@Serializable
data class OffsetDateTimeClass (
    @SerialName("OffsetDateTime")
    val offsetDateTime: Long
)

@Serializable
data class OffsetTime (
    @SerialName("OffsetTime")
    val offsetTime: Long
)

@Serializable
data class Oneway (
    val oneway: Long
)

@Serializable
data class Open (
    val open: Long
)

@Serializable
data class Operator (
    val operator: Long
)

@Serializable
data class Optional (
    val optional: Long
)

@Serializable
data class Or (
    val or: Long
)

@Serializable
data class OrEq (
    @SerialName("or_eq")
    val orEq: Long
)

@Serializable
data class Out (
    val out: Long
)

@Serializable
data class Override (
    val override: Long
)

@Serializable
data class Params (
    val params: Long
)

@Serializable
data class Pass (
    val pass: Long
)

@Serializable
data class Port (
    val port: Long
)

@Serializable
data class Postfix (
    val postfix: Long
)

@Serializable
data class Precedence (
    val precedence: Long
)

@Serializable
data class Prefix (
    val prefix: Long
)

@Serializable
data class Print (
    val print: Long
)

@Serializable
data class PrintMembers (
    val printMembers: Long
)

@Serializable
data class Printf (
    val printf: Long
)

@Serializable
data class Private (
    val private: Long
)

@Serializable
data class Protected (
    val protected: Long
)

@Serializable
data class Protocol (
    @SerialName("Protocol")
    val protocol: Long
)

@Serializable
data class Public (
    val public: Long
)

@Serializable
data class Quicktype (
    val quicktype: Long
)

@Serializable
data class Raise (
    val raise: Long
)

@Serializable
data class Range (
    val range: Long
)

@Serializable
data class Readonly (
    val readonly: Long
)

@Serializable
data class Ref (
    val ref: Long
)

@Serializable
data class RegExp (
    @SerialName("RegExp")
    val regExp: String
)

@Serializable
data class Register (
    val register: Long
)

@Serializable
data class ReinterpretCast (
    @SerialName("reinterpret_cast")
    val reinterpretCast: Long
)

@Serializable
data class Obj5 (
    val dummy: Long,

    @SerialName("KSerializer")
    val kSerializer: KSerializerClass,

    @SerialName("return")
    val obj5Return: Return,

    @SerialName("self")
    val obj5Self: SelfClass,

    @SerialName("super")
    val obj5Super: Super,

    @SerialName("this")
    val obj5This: This,

    @SerialName("throw")
    val obj5Throw: Throw,

    @SerialName("True")
    val obj5True: True,

    @SerialName("PrimitiveKind")
    val primitiveKind: PrimitiveKindClass,

    @SerialName("true")
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

    @SerialName("SEL")
    val sel: Sel,

    val select: Select,

    @SerialName("Self")
    val self: Self,

    @SerialName("Sendable")
    val sendable: Sendable,

    @SerialName("SerialDescriptor")
    val serialDescriptor: SerialDescriptorClass,

    @SerialName("SerialName")
    val serialName: SerialNameClass,

    @SerialName("Serializable")
    val serializable: SerializableClass,

    @SerialName("SerializationFeature")
    val serializationFeature: SerializationFeature,

    val serialize: Serialize,

    @SerialName("SerializerProvider")
    val serializerProvider: SerializerProvider,

    val set: Set,
    val short: ShortClass,
    val signed: Signed,

    @SerialName("SimpleModule")
    val simpleModule: SimpleModule,

    val sizeof: Sizeof,
    val stackalloc: Stackalloc,

    @SerialName("Standards")
    val standards: Standards,

    val static: Static,

    @SerialName("static_assert")
    val staticAssert: StaticAssert,

    @SerialName("static_cast")
    val staticCast: StaticCast,

    @SerialName("StdDeserializer")
    val stdDeserializer: StdDeserializer,

    @SerialName("StdSerializer")
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

    @SerialName("TextNode")
    val textNode: TextNode,

    val then: Then,

    @SerialName("thread_local")
    val threadLocal: ThreadLocal,

    val throws: Throws,

    @SerialName("TimeOnly")
    val timeOnly: TimeOnly,

    @SerialName("TimeOnlyConverter")
    val timeOnlyConverter: TimeOnlyConverter,

    @SerialName("TimeZone")
    val timeZone: TimeZone,

    @SerialName("to_dict")
    val toDict: ToDict,

    @SerialName("to_json")
    val toJSON: ToJSON,

    val toString: ToString,

    @SerialName("top_level")
    val topLevel: TopLevelClass,

    val transient: Transient
)

@Serializable
data class KSerializerClass (
    @SerialName("KSerializer")
    val kSerializer: Long
)

@Serializable
data class Return (
    @SerialName("return")
    val returnReturn: Long
)

@Serializable
data class SelfClass (
    val self: Long
)

@Serializable
data class Super (
    @SerialName("super")
    val superSuper: Long
)

@Serializable
data class This (
    @SerialName("this")
    val thisThis: Long
)

@Serializable
data class Throw (
    @SerialName("throw")
    val throwThrow: Long
)

@Serializable
data class True (
    @SerialName("True")
    val trueTrue: Long
)

@Serializable
data class PrimitiveKindClass (
    @SerialName("PrimitiveKind")
    val primitiveKind: Long
)

@Serializable
data class TrueClass (
    @SerialName("true")
    val trueTrue: Long
)

@Serializable
data class Repeat (
    val repeat: Long
)

@Serializable
data class Require (
    val require: Long
)

@Serializable
data class Required (
    val required: Long
)

@Serializable
data class Requires (
    val requires: Long
)

@Serializable
data class Restrict (
    val restrict: Long
)

@Serializable
data class Retain (
    val retain: Long
)

@Serializable
data class Rethrows (
    val rethrows: Long
)

@Serializable
data class Right (
    val right: Long
)

@Serializable
data class RuntimeType (
    val runtimeType: Long
)

@Serializable
data class S (
    val s: Long
)

@Serializable
data class Sbyte (
    val sbyte: Long
)

@Serializable
data class Sealed (
    val sealed: Long
)

@Serializable
data class Sel (
    @SerialName("SEL")
    val sel: Long
)

@Serializable
data class Select (
    val select: Long
)

@Serializable
data class Self (
    @SerialName("Self")
    val self: Long
)

@Serializable
data class Sendable (
    @SerialName("Sendable")
    val sendable: Long
)

@Serializable
data class SerialDescriptorClass (
    @SerialName("SerialDescriptor")
    val serialDescriptor: Long
)

@Serializable
data class SerialNameClass (
    @SerialName("SerialName")
    val serialName: Long
)

@Serializable
data class SerializableClass (
    @SerialName("Serializable")
    val serializable: Long
)

@Serializable
data class SerializationFeature (
    @SerialName("SerializationFeature")
    val serializationFeature: Long
)

@Serializable
data class Serialize (
    val serialize: Long
)

@Serializable
data class SerializerProvider (
    @SerialName("SerializerProvider")
    val serializerProvider: Long
)

@Serializable
data class Set (
    val set: Long
)

@Serializable
data class ShortClass (
    val short: Long
)

@Serializable
data class Signed (
    val signed: Long
)

@Serializable
data class SimpleModule (
    @SerialName("SimpleModule")
    val simpleModule: Long
)

@Serializable
data class Sizeof (
    val sizeof: Long
)

@Serializable
data class Stackalloc (
    val stackalloc: Long
)

@Serializable
data class Standards (
    @SerialName("Standards")
    val standards: Long
)

@Serializable
data class Static (
    val static: Long
)

@Serializable
data class StaticAssert (
    @SerialName("static_assert")
    val staticAssert: Long
)

@Serializable
data class StaticCast (
    @SerialName("static_cast")
    val staticCast: Long
)

@Serializable
data class StdDeserializer (
    @SerialName("StdDeserializer")
    val stdDeserializer: Long
)

@Serializable
data class StdSerializer (
    @SerialName("StdSerializer")
    val stdSerializer: Long
)

@Serializable
data class Strictfp (
    val strictfp: Long
)

@Serializable
data class StringClass (
    val string: Long
)

@Serializable
data class Struct (
    val struct: Long
)

@Serializable
data class Subscript (
    val subscript: Long
)

@Serializable
data class Switch (
    val switch: Long
)

@Serializable
data class Symbol (
    val symbol: Long
)

@Serializable
data class Synchronized (
    val synchronized: Long
)

@Serializable
data class SystemClass (
    val system: Long
)

@Serializable
data class Template (
    val template: Long
)

@Serializable
data class TextNode (
    @SerialName("TextNode")
    val textNode: Long
)

@Serializable
data class Then (
    val then: Long
)

@Serializable
data class ThreadLocal (
    @SerialName("thread_local")
    val threadLocal: Long
)

@Serializable
data class Throws (
    val throws: Long
)

@Serializable
data class TimeOnly (
    @SerialName("TimeOnly")
    val timeOnly: Long
)

@Serializable
data class TimeOnlyConverter (
    @SerialName("TimeOnlyConverter")
    val timeOnlyConverter: Long
)

@Serializable
data class TimeZone (
    @SerialName("TimeZone")
    val timeZone: Long
)

@Serializable
data class ToDict (
    @SerialName("to_dict")
    val toDict: Long
)

@Serializable
data class ToJSON (
    @SerialName("to_json")
    val toJSON: Long
)

@Serializable
data class ToString (
    val toString: Long
)

@Serializable
data class TopLevelClass (
    @SerialName("top_level")
    val topLevel: Long
)

@Serializable
data class Transient (
    val transient: Long
)

@Serializable
data class Obj6 (
    val dummy: Long,

    @SerialName("try")
    val obj6Try: Try,

    @SerialName("type")
    val obj6Type: TypeClass,

    @SerialName("typealias")
    val obj6Typealias: Typealias,

    @SerialName("typeof")
    val obj6Typeof: Typeof,

    @SerialName("var")
    val obj6Var: Var,

    @SerialName("while")
    val obj6While: While,

    @SerialName("Type")
    val type: Type,

    val typedef: Typedef,
    val typeid: Typeid,
    val typename: Typename,
    val uint: Uint,
    val ulong: Ulong,
    val unchecked: Unchecked,
    val undefined: Undefined,
    val union: Union,

    @SerialName("UnmarshalJSON")
    val unmarshalJSON: UnmarshalJSON,

    val unowned: Unowned,
    val unsafe: Unsafe,
    val unsigned: Unsigned,

    @SerialName("UseSerializers")
    val useSerializers: UseSerializersClass,

    val ushort: Ushort,
    val using: Using,

    @SerialName("Utf8JsonReader")
    val utf8JSONReader: Utf8JSONReader,

    @SerialName("Utf8JsonWriter")
    val utf8JSONWriter: Utf8JSONWriter,

    @SerialName("UUID")
    val uuid: UUID,

    val virtual: Virtual,
    val void: Void,
    val volatile: Volatile,

    @SerialName("wchar_t")
    val wcharT: WcharT,

    val weak: Weak,
    val where: Where,
    val willSet: WillSet,
    val with: With,
    val xor: Xor,

    @SerialName("xor_eq")
    val xorEq: XorEq,

    @SerialName("YES")
    val yes: Yes,

    val yield: Yield
)

@Serializable
data class Try (
    @SerialName("try")
    val tryTry: Long
)

@Serializable
data class TypeClass (
    val type: Long
)

@Serializable
data class Typealias (
    @SerialName("typealias")
    val typealiasTypealias: Long
)

@Serializable
data class Typeof (
    @SerialName("typeof")
    val typeofTypeof: Long
)

@Serializable
data class Var (
    @SerialName("var")
    val varVar: Long
)

@Serializable
data class While (
    @SerialName("while")
    val whileWhile: Long
)

@Serializable
data class Type (
    @SerialName("Type")
    val type: Long
)

@Serializable
data class Typedef (
    val typedef: Long
)

@Serializable
data class Typeid (
    val typeid: Long
)

@Serializable
data class Typename (
    val typename: Long
)

@Serializable
data class Uint (
    val uint: Long
)

@Serializable
data class Ulong (
    val ulong: Long
)

@Serializable
data class Unchecked (
    val unchecked: Long
)

@Serializable
data class Undefined (
    val undefined: Long
)

@Serializable
data class Union (
    val union: Long
)

@Serializable
data class UnmarshalJSON (
    @SerialName("UnmarshalJSON")
    val unmarshalJSON: Long
)

@Serializable
data class Unowned (
    val unowned: Long
)

@Serializable
data class Unsafe (
    val unsafe: Long
)

@Serializable
data class Unsigned (
    val unsigned: Long
)

@Serializable
data class UseSerializersClass (
    @SerialName("UseSerializers")
    val useSerializers: Long
)

@Serializable
data class Ushort (
    val ushort: Long
)

@Serializable
data class Using (
    val using: Long
)

@Serializable
data class Utf8JSONReader (
    @SerialName("Utf8JsonReader")
    val utf8JSONReader: Long
)

@Serializable
data class Utf8JSONWriter (
    @SerialName("Utf8JsonWriter")
    val utf8JSONWriter: Long
)

@Serializable
data class UUID (
    @SerialName("UUID")
    val uuid: Long
)

@Serializable
data class Virtual (
    val virtual: Long
)

@Serializable
data class Void (
    val void: Long
)

@Serializable
data class Volatile (
    val volatile: Long
)

@Serializable
data class WcharT (
    @SerialName("wchar_t")
    val wcharT: Long
)

@Serializable
data class Weak (
    val weak: Long
)

@Serializable
data class Where (
    val where: Long
)

@Serializable
data class WillSet (
    val willSet: Long
)

@Serializable
data class With (
    val with: Long
)

@Serializable
data class Xor (
    val xor: Long
)

@Serializable
data class XorEq (
    @SerialName("xor_eq")
    val xorEq: Long
)

@Serializable
data class Yes (
    @SerialName("YES")
    val yes: Long
)

@Serializable
data class Yield (
    val yield: Long
)

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
