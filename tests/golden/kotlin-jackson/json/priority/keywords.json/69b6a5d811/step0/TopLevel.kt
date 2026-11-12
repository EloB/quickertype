// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(EnumValue::class,      { EnumValue.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj1: Obj1,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj2: Obj2,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj3: Obj3,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj4: Obj4,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj5: Obj5,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val obj6: Obj6
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Obj1 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val abstract: Abstract,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alignas: Alignas,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alignof: Alignof,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val and: And,

    @get:JsonProperty("and_eq", required=true)@field:JsonProperty("and_eq", required=true)
    val andEq: AndEq,

    @get:JsonProperty("Any", required=true)@field:JsonProperty("Any", required=true)
    val any: AnyClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val array: ArrayClass,

    @get:JsonProperty("ArrayNode", required=true)@field:JsonProperty("ArrayNode", required=true)
    val arrayNode: ArrayNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asm: ASM,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assert: Assert,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val associatedtype: Associatedtype,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val associativity: Associativity,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val async: Async,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val atomic: Atomic,

    @get:JsonProperty("atomic_cancel", required=true)@field:JsonProperty("atomic_cancel", required=true)
    val atomicCancel: AtomicCancel,

    @get:JsonProperty("atomic_commit", required=true)@field:JsonProperty("atomic_commit", required=true)
    val atomicCommit: AtomicCommit,

    @get:JsonProperty("atomic_noexcept", required=true)@field:JsonProperty("atomic_noexcept", required=true)
    val atomicNoexcept: AtomicNoexcept,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val auto: Auto,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val await: Await,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val base: Base,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bitand: Bitand,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bitor: Bitor,

    @get:JsonProperty("BOOL", required=true)@field:JsonProperty("BOOL", required=true)
    val bool: Bool,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val boolean: BooleanClass,

    @get:JsonProperty("BooleanNode", required=true)@field:JsonProperty("BooleanNode", required=true)
    val booleanNode: BooleanNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bycopy: Bycopy,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val byref: Byref,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val byte: ByteClass,

    @get:JsonProperty("Calendar", required=true)@field:JsonProperty("Calendar", required=true)
    val calendar: Calendar,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val case: Case,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val catch: Catch,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val chan: Chan,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val char: Char,

    @get:JsonProperty("char16_t", required=true)@field:JsonProperty("char16_t", required=true)
    val char16T: Char16T,

    @get:JsonProperty("char32_t", required=true)@field:JsonProperty("char32_t", required=true)
    val char32T: Char32T,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val checked: Checked,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clone: Clone,

    @get:JsonProperty("co_await", required=true)@field:JsonProperty("co_await", required=true)
    val coAwait: CoAwait,

    @get:JsonProperty("co_return", required=true)@field:JsonProperty("co_return", required=true)
    val coReturn: CoReturn,

    @get:JsonProperty("co_yield", required=true)@field:JsonProperty("co_yield", required=true)
    val coYield: CoYield,

    @get:JsonProperty("Codable", required=true)@field:JsonProperty("Codable", required=true)
    val codable: Codable,

    @get:JsonProperty("CodingKey", required=true)@field:JsonProperty("CodingKey", required=true)
    val codingKey: CodingKey,

    @get:JsonProperty("CodingKeys", required=true)@field:JsonProperty("CodingKeys", required=true)
    val codingKeys: CodingKeys,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val compl: Compl,

    @get:JsonProperty("_Complex", required=true)@field:JsonProperty("_Complex", required=true)
    val complex: Complex,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val concept: Concept,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val console: Console,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val const: Const,

    @get:JsonProperty("const_cast", required=true)@field:JsonProperty("const_cast", required=true)
    val constCast: ConstCast,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constexpr: Constexpr,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constructor: Constructor,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val convenience: Convenience,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val convert: Convert,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val converter: ConverterClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty("_", required=true)@field:JsonProperty("_", required=true)
    val empty: Empty,

    @get:JsonProperty("_Imaginery", required=true)@field:JsonProperty("_Imaginery", required=true)
    val imaginery: Imaginery,

    @get:JsonProperty("any", required=true)@field:JsonProperty("any", required=true)
    val obj1Any: Obj1Any,

    @get:JsonProperty("as", required=true)@field:JsonProperty("as", required=true)
    val obj1As: As,

    @get:JsonProperty("_Bool", required=true)@field:JsonProperty("_Bool", required=true)
    val obj1Bool: BoolClass,

    @get:JsonProperty("break", required=true)@field:JsonProperty("break", required=true)
    val obj1Break: Break,

    @get:JsonProperty("Class", required=true)@field:JsonProperty("Class", required=true)
    val obj1Class: ClassClass,

    @get:JsonProperty("continue", required=true)@field:JsonProperty("continue", required=true)
    val obj1Continue: Continue,

    @get:JsonProperty("bool", required=true)@field:JsonProperty("bool", required=true)
    val purpleBool: Obj1Bool,

    @get:JsonProperty("class", required=true)@field:JsonProperty("class", required=true)
    val purpleClass: Obj1Class
)

data class Abstract (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val abstract: Long
)

data class Alignas (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alignas: Long
)

data class Alignof (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alignof: Long
)

data class And (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val and: Long
)

data class AndEq (
    @get:JsonProperty("and_eq", required=true)@field:JsonProperty("and_eq", required=true)
    val andEq: Long
)

data class AnyClass (
    @get:JsonProperty("Any", required=true)@field:JsonProperty("Any", required=true)
    val any: Long
)

data class ArrayClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val array: Long
)

data class ArrayNodeClass (
    @get:JsonProperty("ArrayNode", required=true)@field:JsonProperty("ArrayNode", required=true)
    val arrayNode: Long
)

data class ASM (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asm: Long
)

data class Assert (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assert: Long
)

data class Associatedtype (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val associatedtype: Long
)

data class Associativity (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val associativity: Long
)

data class Async (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val async: Long
)

data class Atomic (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val atomic: Long
)

data class AtomicCancel (
    @get:JsonProperty("atomic_cancel", required=true)@field:JsonProperty("atomic_cancel", required=true)
    val atomicCancel: Long
)

data class AtomicCommit (
    @get:JsonProperty("atomic_commit", required=true)@field:JsonProperty("atomic_commit", required=true)
    val atomicCommit: Long
)

data class AtomicNoexcept (
    @get:JsonProperty("atomic_noexcept", required=true)@field:JsonProperty("atomic_noexcept", required=true)
    val atomicNoexcept: Long
)

data class Auto (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val auto: Long
)

data class Await (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val await: Long
)

data class Base (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val base: Long
)

data class Bitand (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bitand: Long
)

data class Bitor (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bitor: Long
)

data class Bool (
    @get:JsonProperty("BOOL", required=true)@field:JsonProperty("BOOL", required=true)
    val bool: Long
)

data class BooleanClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val boolean: Long
)

data class BooleanNodeClass (
    @get:JsonProperty("BooleanNode", required=true)@field:JsonProperty("BooleanNode", required=true)
    val booleanNode: Long
)

data class Bycopy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bycopy: Long
)

data class Byref (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val byref: Long
)

data class ByteClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val byte: Long
)

data class Calendar (
    @get:JsonProperty("Calendar", required=true)@field:JsonProperty("Calendar", required=true)
    val calendar: Long
)

data class Case (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val case: Long
)

data class Catch (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val catch: Long
)

data class Chan (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val chan: Long
)

data class Char (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val char: Long
)

data class Char16T (
    @get:JsonProperty("char16_t", required=true)@field:JsonProperty("char16_t", required=true)
    val char16T: Long
)

data class Char32T (
    @get:JsonProperty("char32_t", required=true)@field:JsonProperty("char32_t", required=true)
    val char32T: Long
)

data class Checked (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val checked: Long
)

data class Clone (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clone: Long
)

data class CoAwait (
    @get:JsonProperty("co_await", required=true)@field:JsonProperty("co_await", required=true)
    val coAwait: Long
)

data class CoReturn (
    @get:JsonProperty("co_return", required=true)@field:JsonProperty("co_return", required=true)
    val coReturn: Long
)

data class CoYield (
    @get:JsonProperty("co_yield", required=true)@field:JsonProperty("co_yield", required=true)
    val coYield: Long
)

data class Codable (
    @get:JsonProperty("Codable", required=true)@field:JsonProperty("Codable", required=true)
    val codable: Long
)

data class CodingKey (
    @get:JsonProperty("CodingKey", required=true)@field:JsonProperty("CodingKey", required=true)
    val codingKey: Long
)

data class CodingKeys (
    @get:JsonProperty("CodingKeys", required=true)@field:JsonProperty("CodingKeys", required=true)
    val codingKeys: Long
)

data class Compl (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val compl: Long
)

data class Complex (
    @get:JsonProperty("_Complex", required=true)@field:JsonProperty("_Complex", required=true)
    val complex: Long
)

data class Concept (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val concept: Long
)

data class Console (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val console: Long
)

data class Const (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val const: Long
)

data class ConstCast (
    @get:JsonProperty("const_cast", required=true)@field:JsonProperty("const_cast", required=true)
    val constCast: Long
)

data class Constexpr (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constexpr: Long
)

data class Constructor (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constructor: Long
)

data class Convenience (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val convenience: Long
)

data class Convert (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val convert: Long
)

data class ConverterClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val converter: Long
)

data class Empty (
    @get:JsonProperty("_", required=true)@field:JsonProperty("_", required=true)
    val empty: Long
)

data class Imaginery (
    @get:JsonProperty("_Imaginery", required=true)@field:JsonProperty("_Imaginery", required=true)
    val imaginery: Long
)

data class Obj1Any (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val any: Long
)

data class As (
    @get:JsonProperty("as", required=true)@field:JsonProperty("as", required=true)
    val asAs: Long
)

data class BoolClass (
    @get:JsonProperty("_Bool", required=true)@field:JsonProperty("_Bool", required=true)
    val bool: Long
)

data class Break (
    @get:JsonProperty("break", required=true)@field:JsonProperty("break", required=true)
    val breakBreak: Long
)

data class ClassClass (
    @get:JsonProperty("Class", required=true)@field:JsonProperty("Class", required=true)
    val classClass: Long
)

data class Continue (
    @get:JsonProperty("continue", required=true)@field:JsonProperty("continue", required=true)
    val continueContinue: Long
)

data class Obj1Bool (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bool: Long
)

data class Obj1Class (
    @get:JsonProperty("class", required=true)@field:JsonProperty("class", required=true)
    val classClass: Long
)

data class Obj2 (
    @get:JsonProperty("CultureInfo", required=true)@field:JsonProperty("CultureInfo", required=true)
    val cultureInfo: CultureInfo,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: Date,

    @get:JsonProperty("DateFormatter", required=true)@field:JsonProperty("DateFormatter", required=true)
    val dateFormatter: DateFormatter,

    @get:JsonProperty("DateOnly", required=true)@field:JsonProperty("DateOnly", required=true)
    val dateOnly: DateOnly,

    @get:JsonProperty("DateOnlyConverter", required=true)@field:JsonProperty("DateOnlyConverter", required=true)
    val dateOnlyConverter: DateOnlyConverter,

    @get:JsonProperty("date_parse_handling", required=true)@field:JsonProperty("date_parse_handling", required=true)
    val dateParseHandling: DateParseHandling,

    @get:JsonProperty("DateTime", required=true)@field:JsonProperty("DateTime", required=true)
    val dateTime: DateTime,

    @get:JsonProperty("DateTimeStyles", required=true)@field:JsonProperty("DateTimeStyles", required=true)
    val dateTimeStyles: DateTimeStyles,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val debugger: Debugger,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decimal: Decimal,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val declare: Declare,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decltype: Decltype,

    @get:JsonProperty("decode_string", required=true)@field:JsonProperty("decode_string", required=true)
    val decodeString: DecodeString,

    @get:JsonProperty("Decoder", required=true)@field:JsonProperty("Decoder", required=true)
    val decoder: Decoder,

    @get:JsonProperty("DecodingError", required=true)@field:JsonProperty("DecodingError", required=true)
    val decodingError: DecodingError,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val def: Def,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val default: Default,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val defer: Defer,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val deinit: Deinit,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val del: Del,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val delegate: Delegate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val delete: Delete,

    @get:JsonProperty("DeserializationFeature", required=true)@field:JsonProperty("DeserializationFeature", required=true)
    val deserializationFeature: DeserializationFeatureClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dict: Dict,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dictionary: Dictionary,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val didSet: DidSet,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val double: DoubleClass,

    @get:JsonProperty("DoubleNode", required=true)@field:JsonProperty("DoubleNode", required=true)
    val doubleNode: DoubleNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dynamic: Dynamic,

    @get:JsonProperty("dynamic_cast", required=true)@field:JsonProperty("dynamic_cast", required=true)
    val dynamicCast: DynamicCast,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val elif: Elif,

    @get:JsonProperty("encode_quick_type", required=true)@field:JsonProperty("encode_quick_type", required=true)
    val encodeQuickType: EncodeQuickType,

    @get:JsonProperty("Encoder", required=true)@field:JsonProperty("Encoder", required=true)
    val encoder: Encoder,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enum: EnumClass,

    @get:JsonProperty("EnumValues", required=true)@field:JsonProperty("EnumValues", required=true)
    val enumValues: EnumValues,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val equalityContract: EqualityContract,

    @get:JsonProperty("Equatable", required=true)@field:JsonProperty("Equatable", required=true)
    val equatable: Equatable,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val event: Event,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val except: Except,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val exception: Exception,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val explicit: Explicit,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val export: Export,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val exposing: Exposing,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extends: Extends,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extension: Extension,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extern: Extern,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fallthrough: Fallthrough,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fileprivate: Fileprivate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val final: Final,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val finally: Finally,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fixed: Fixed,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val float: FloatClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foreach: Foreach,

    @get:JsonProperty("FormatException", required=true)@field:JsonProperty("FormatException", required=true)
    val formatException: FormatException,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val friend: Friend,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val from: From,

    @get:JsonProperty("from_dict", required=true)@field:JsonProperty("from_dict", required=true)
    val fromDict: FromDict,

    @get:JsonProperty("from_json", required=true)@field:JsonProperty("from_json", required=true)
    val fromJSON: FromJSON,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val func: Func,

    @get:JsonProperty("do", required=true)@field:JsonProperty("do", required=true)
    val obj2Do: Do,

    @get:JsonProperty("else", required=true)@field:JsonProperty("else", required=true)
    val obj2Else: Else,

    @get:JsonProperty("False", required=true)@field:JsonProperty("False", required=true)
    val obj2False: False,

    @get:JsonProperty("for", required=true)@field:JsonProperty("for", required=true)
    val obj2For: For,

    @get:JsonProperty("false", required=true)@field:JsonProperty("false", required=true)
    val purpleFalse: FalseClass
)

data class CultureInfo (
    @get:JsonProperty("CultureInfo", required=true)@field:JsonProperty("CultureInfo", required=true)
    val cultureInfo: Long
)

data class Date (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: Long
)

data class DateFormatter (
    @get:JsonProperty("DateFormatter", required=true)@field:JsonProperty("DateFormatter", required=true)
    val dateFormatter: Long
)

data class DateOnly (
    @get:JsonProperty("DateOnly", required=true)@field:JsonProperty("DateOnly", required=true)
    val dateOnly: Long
)

data class DateOnlyConverter (
    @get:JsonProperty("DateOnlyConverter", required=true)@field:JsonProperty("DateOnlyConverter", required=true)
    val dateOnlyConverter: Long
)

data class DateParseHandling (
    @get:JsonProperty("date_parse_handling", required=true)@field:JsonProperty("date_parse_handling", required=true)
    val dateParseHandling: Long
)

data class DateTime (
    @get:JsonProperty("DateTime", required=true)@field:JsonProperty("DateTime", required=true)
    val dateTime: OffsetDateTime
)

data class DateTimeStyles (
    @get:JsonProperty("DateTimeStyles", required=true)@field:JsonProperty("DateTimeStyles", required=true)
    val dateTimeStyles: Long
)

data class Debugger (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val debugger: Long
)

data class Decimal (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decimal: Long
)

data class Declare (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val declare: Long
)

data class Decltype (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decltype: Long
)

data class DecodeString (
    @get:JsonProperty("decode_string", required=true)@field:JsonProperty("decode_string", required=true)
    val decodeString: Long
)

data class Decoder (
    @get:JsonProperty("Decoder", required=true)@field:JsonProperty("Decoder", required=true)
    val decoder: Long
)

data class DecodingError (
    @get:JsonProperty("DecodingError", required=true)@field:JsonProperty("DecodingError", required=true)
    val decodingError: Long
)

data class Def (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val def: Long
)

data class Default (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val default: Long
)

data class Defer (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val defer: Long
)

data class Deinit (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val deinit: Long
)

data class Del (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val del: Long
)

data class Delegate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val delegate: Long
)

data class Delete (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val delete: Long
)

data class DeserializationFeatureClass (
    @get:JsonProperty("DeserializationFeature", required=true)@field:JsonProperty("DeserializationFeature", required=true)
    val deserializationFeature: Long
)

data class Dict (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dict: Long
)

data class Dictionary (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dictionary: Long
)

data class DidSet (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val didSet: Long
)

data class DoubleClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val double: Long
)

data class DoubleNodeClass (
    @get:JsonProperty("DoubleNode", required=true)@field:JsonProperty("DoubleNode", required=true)
    val doubleNode: Long
)

data class Dynamic (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dynamic: Long
)

data class DynamicCast (
    @get:JsonProperty("dynamic_cast", required=true)@field:JsonProperty("dynamic_cast", required=true)
    val dynamicCast: Long
)

data class Elif (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val elif: Long
)

data class EncodeQuickType (
    @get:JsonProperty("encode_quick_type", required=true)@field:JsonProperty("encode_quick_type", required=true)
    val encodeQuickType: Long
)

data class Encoder (
    @get:JsonProperty("Encoder", required=true)@field:JsonProperty("Encoder", required=true)
    val encoder: Long
)

data class EnumClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enum: Long
)

data class EnumValues (
    @get:JsonProperty("EnumValues", required=true)@field:JsonProperty("EnumValues", required=true)
    val enumValues: List<EnumValue>
)

enum class EnumValue(val value: String) {
    Ready("ready"),
    Done("done");

    companion object {
        fun fromValue(value: String): EnumValue = when (value) {
            "ready" -> Ready
            "done"  -> Done
            else    -> throw IllegalArgumentException()
        }
    }
}

data class EqualityContract (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val equalityContract: Long
)

data class Equatable (
    @get:JsonProperty("Equatable", required=true)@field:JsonProperty("Equatable", required=true)
    val equatable: Long
)

data class Event (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val event: Long
)

data class Except (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val except: Long
)

data class Exception (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val exception: Long
)

data class Explicit (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val explicit: Long
)

data class Export (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val export: Long
)

data class Exposing (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val exposing: Long
)

data class Extends (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extends: Long
)

data class Extension (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extension: Long
)

data class Extern (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extern: Long
)

data class Fallthrough (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fallthrough: Long
)

data class Fileprivate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fileprivate: Long
)

data class Final (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val final: Long
)

data class Finally (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val finally: Long
)

data class Fixed (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fixed: Long
)

data class FloatClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val float: Long
)

data class Foreach (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foreach: Long
)

data class FormatException (
    @get:JsonProperty("FormatException", required=true)@field:JsonProperty("FormatException", required=true)
    val formatException: Long
)

data class Friend (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val friend: Long
)

data class From (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val from: Long
)

data class FromDict (
    @get:JsonProperty("from_dict", required=true)@field:JsonProperty("from_dict", required=true)
    val fromDict: Long
)

data class FromJSON (
    @get:JsonProperty("from_json", required=true)@field:JsonProperty("from_json", required=true)
    val fromJSON: Long
)

data class Func (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val func: Long
)

data class Do (
    @get:JsonProperty("do", required=true)@field:JsonProperty("do", required=true)
    val doDo: Long
)

data class Else (
    @get:JsonProperty("else", required=true)@field:JsonProperty("else", required=true)
    val elseElse: Long
)

data class False (
    @get:JsonProperty("False", required=true)@field:JsonProperty("False", required=true)
    val falseFalse: Long
)

data class For (
    @get:JsonProperty("for", required=true)@field:JsonProperty("for", required=true)
    val forFor: Long
)

data class FalseClass (
    @get:JsonProperty("false", required=true)@field:JsonProperty("false", required=true)
    val falseFalse: Long
)

data class Obj3 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val function: Function,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: Get,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val global: Global,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val go: Go,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val goto: Goto,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val guard: Guard,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hasOwnProperty: HasOwnProperty,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hashCode: HashCode,

    @get:JsonProperty("Hashable", required=true)@field:JsonProperty("Hashable", required=true)
    val hashable: Hashable,

    @get:JsonProperty("Hasher", required=true)@field:JsonProperty("Hasher", required=true)
    val hasher: Hasher,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: ID,

    @get:JsonProperty("IMP", required=true)@field:JsonProperty("IMP", required=true)
    val imp: Imp,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val implements: Implements,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val implicit: Implicit,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val import: Import,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indirect: Indirect,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val infix: Infix,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val init: Init,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inline: Inline,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inout: Inout,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val instanceof: Instanceof,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val int: IntClass,

    @get:JsonProperty("IntNode", required=true)@field:JsonProperty("IntNode", required=true)
    val intNode: IntNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internal: Internal,

    @get:JsonProperty("IsoDateTimeOffsetConverter", required=true)@field:JsonProperty("IsoDateTimeOffsetConverter", required=true)
    val isoDateTimeOffsetConverter: ISODateTimeOffsetConverter,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val iterable: Iterable,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jdec: Jdec,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jenc: Jenc,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jpipe: Jpipe,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val json: JSON,

    @get:JsonProperty("JSONAny", required=true)@field:JsonProperty("JSONAny", required=true)
    val jsonAny: JSONAny,

    @get:JsonProperty("JSONCodingKey", required=true)@field:JsonProperty("JSONCodingKey", required=true)
    val jsonCodingKey: JSONCodingKey,

    @get:JsonProperty("json_converter", required=true)@field:JsonProperty("json_converter", required=true)
    val jsonConverter: JSONConverter,

    @get:JsonProperty("JSONDecoder", required=true)@field:JsonProperty("JSONDecoder", required=true)
    val jsonDecoder: JSONDecoder,

    @get:JsonProperty("JSONEncoder", required=true)@field:JsonProperty("JSONEncoder", required=true)
    val jsonEncoder: JSONEncoder,

    @get:JsonProperty("JsonException", required=true)@field:JsonProperty("JsonException", required=true)
    val jsonException: JSONException,

    @get:JsonProperty("JsonGenerator", required=true)@field:JsonProperty("JsonGenerator", required=true)
    val jsonGenerator: JSONGenerator,

    @get:JsonProperty("JsonNode", required=true)@field:JsonProperty("JsonNode", required=true)
    val jsonNode: JSONNode,

    @get:JsonProperty("JSONNull", required=true)@field:JsonProperty("JSONNull", required=true)
    val jsonNull: JSONNull,

    @get:JsonProperty("JsonParser", required=true)@field:JsonProperty("JsonParser", required=true)
    val jsonParser: JSONParser,

    @get:JsonProperty("JsonReader", required=true)@field:JsonProperty("JsonReader", required=true)
    val jsonReader: JSONReader,

    @get:JsonProperty("json_serializer", required=true)@field:JsonProperty("json_serializer", required=true)
    val jsonSerializer: JSONSerializer,

    @get:JsonProperty("json_token", required=true)@field:JsonProperty("json_token", required=true)
    val jsonToken: JSONToken,

    @get:JsonProperty("JsonTokenType", required=true)@field:JsonProperty("JsonTokenType", required=true)
    val jsonTokenType: JSONTokenType,

    @get:JsonProperty("json_writer", required=true)@field:JsonProperty("json_writer", required=true)
    val jsonWriter: JSONWriter,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lambda: Lambda,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lazy: Lazy,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val left: Left,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val let: Let,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val list: ListClass,

    @get:JsonProperty("LocalDate", required=true)@field:JsonProperty("LocalDate", required=true)
    val localDate: LocalDate,

    @get:JsonProperty("Locale", required=true)@field:JsonProperty("Locale", required=true)
    val locale: Locale,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lock: Lock,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val long: LongClass,

    @get:JsonProperty("LongNode", required=true)@field:JsonProperty("LongNode", required=true)
    val longNode: LongNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val map: MapClass,

    @get:JsonProperty("MapEntry", required=true)@field:JsonProperty("MapEntry", required=true)
    val mapEntry: MapEntry,

    @get:JsonProperty("MarshalJSON", required=true)@field:JsonProperty("MarshalJSON", required=true)
    val marshalJSON: MarshalJSON,

    @get:JsonProperty("metadata_property_handling", required=true)@field:JsonProperty("metadata_property_handling", required=true)
    val metadataPropertyHandling: MetadataPropertyHandling,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val module: Module,

    @get:JsonProperty("if", required=true)@field:JsonProperty("if", required=true)
    val obj3If: If,

    @get:JsonProperty("in", required=true)@field:JsonProperty("in", required=true)
    val obj3In: In,

    @get:JsonProperty("interface", required=true)@field:JsonProperty("interface", required=true)
    val obj3Interface: Interface,

    @get:JsonProperty("is", required=true)@field:JsonProperty("is", required=true)
    val obj3Is: Is
)

data class Function (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val function: Long
)

data class Get (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: Long
)

data class Global (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val global: Long
)

data class Go (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val go: Long
)

data class Goto (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val goto: Long
)

data class Guard (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val guard: Long
)

data class HasOwnProperty (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hasOwnProperty: Long
)

data class HashCode (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hashCode: Long
)

data class Hashable (
    @get:JsonProperty("Hashable", required=true)@field:JsonProperty("Hashable", required=true)
    val hashable: Long
)

data class Hasher (
    @get:JsonProperty("Hasher", required=true)@field:JsonProperty("Hasher", required=true)
    val hasher: Long
)

data class ID (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long
)

data class Imp (
    @get:JsonProperty("IMP", required=true)@field:JsonProperty("IMP", required=true)
    val imp: Long
)

data class Implements (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val implements: Long
)

data class Implicit (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val implicit: Long
)

data class Import (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val import: Long
)

data class Indirect (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indirect: Long
)

data class Infix (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val infix: Long
)

data class Init (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val init: Long
)

data class Inline (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inline: Long
)

data class Inout (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inout: Long
)

data class Instanceof (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val instanceof: Long
)

data class IntClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val int: Long
)

data class IntNodeClass (
    @get:JsonProperty("IntNode", required=true)@field:JsonProperty("IntNode", required=true)
    val intNode: Long
)

data class Internal (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internal: Long
)

data class ISODateTimeOffsetConverter (
    @get:JsonProperty("IsoDateTimeOffsetConverter", required=true)@field:JsonProperty("IsoDateTimeOffsetConverter", required=true)
    val isoDateTimeOffsetConverter: Long
)

data class Iterable (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val iterable: Long
)

data class Jdec (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jdec: Long
)

data class Jenc (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jenc: Long
)

data class Jpipe (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jpipe: Long
)

data class JSON (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val json: Long
)

data class JSONAny (
    @get:JsonProperty("JSONAny", required=true)@field:JsonProperty("JSONAny", required=true)
    val jsonAny: Any? = null
)

data class JSONCodingKey (
    @get:JsonProperty("JSONCodingKey", required=true)@field:JsonProperty("JSONCodingKey", required=true)
    val jsonCodingKey: Long
)

data class JSONConverter (
    @get:JsonProperty("json_converter", required=true)@field:JsonProperty("json_converter", required=true)
    val jsonConverter: Long
)

data class JSONDecoder (
    @get:JsonProperty("JSONDecoder", required=true)@field:JsonProperty("JSONDecoder", required=true)
    val jsonDecoder: Long
)

data class JSONEncoder (
    @get:JsonProperty("JSONEncoder", required=true)@field:JsonProperty("JSONEncoder", required=true)
    val jsonEncoder: Long
)

data class JSONException (
    @get:JsonProperty("JsonException", required=true)@field:JsonProperty("JsonException", required=true)
    val jsonException: Long
)

data class JSONGenerator (
    @get:JsonProperty("JsonGenerator", required=true)@field:JsonProperty("JsonGenerator", required=true)
    val jsonGenerator: Long
)

data class JSONNode (
    @get:JsonProperty("JsonNode", required=true)@field:JsonProperty("JsonNode", required=true)
    val jsonNode: Long
)

data class JSONNull (
    @get:JsonProperty("JSONNull", required=true)@field:JsonProperty("JSONNull", required=true)
    val jsonNull: Long
)

data class JSONParser (
    @get:JsonProperty("JsonParser", required=true)@field:JsonProperty("JsonParser", required=true)
    val jsonParser: Long
)

data class JSONReader (
    @get:JsonProperty("JsonReader", required=true)@field:JsonProperty("JsonReader", required=true)
    val jsonReader: Long
)

data class JSONSerializer (
    @get:JsonProperty("json_serializer", required=true)@field:JsonProperty("json_serializer", required=true)
    val jsonSerializer: Long
)

data class JSONToken (
    @get:JsonProperty("json_token", required=true)@field:JsonProperty("json_token", required=true)
    val jsonToken: Long
)

data class JSONTokenType (
    @get:JsonProperty("JsonTokenType", required=true)@field:JsonProperty("JsonTokenType", required=true)
    val jsonTokenType: Long
)

data class JSONWriter (
    @get:JsonProperty("json_writer", required=true)@field:JsonProperty("json_writer", required=true)
    val jsonWriter: Long
)

data class Lambda (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lambda: Long
)

data class Lazy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lazy: Long
)

data class Left (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val left: Long
)

data class Let (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val let: Long
)

data class ListClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val list: Long
)

data class LocalDate (
    @get:JsonProperty("LocalDate", required=true)@field:JsonProperty("LocalDate", required=true)
    val localDate: Long
)

data class Locale (
    @get:JsonProperty("Locale", required=true)@field:JsonProperty("Locale", required=true)
    val locale: Long
)

data class Lock (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lock: Long
)

data class LongClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val long: Long
)

data class LongNodeClass (
    @get:JsonProperty("LongNode", required=true)@field:JsonProperty("LongNode", required=true)
    val longNode: Long
)

data class MapClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val map: Long
)

data class MapEntry (
    @get:JsonProperty("MapEntry", required=true)@field:JsonProperty("MapEntry", required=true)
    val mapEntry: Long
)

data class MarshalJSON (
    @get:JsonProperty("MarshalJSON", required=true)@field:JsonProperty("MarshalJSON", required=true)
    val marshalJSON: Long
)

data class MetadataPropertyHandling (
    @get:JsonProperty("metadata_property_handling", required=true)@field:JsonProperty("metadata_property_handling", required=true)
    val metadataPropertyHandling: Long
)

data class Module (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val module: Long
)

data class If (
    @get:JsonProperty("if", required=true)@field:JsonProperty("if", required=true)
    val ifIf: Long
)

data class In (
    @get:JsonProperty("in", required=true)@field:JsonProperty("in", required=true)
    val inIn: Long
)

data class Interface (
    @get:JsonProperty("interface", required=true)@field:JsonProperty("interface", required=true)
    val interfaceInterface: Long
)

data class Is (
    @get:JsonProperty("is", required=true)@field:JsonProperty("is", required=true)
    val isIs: Long
)

data class Obj4 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mutable: Mutable,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mutating: Mutating,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val namespace: Namespace,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val native: Native,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val new: New,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val newtonsoft: Newtonsoft,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nil: Nil,

    @get:JsonProperty("NO", required=true)@field:JsonProperty("NO", required=true)
    val no: No,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noSuchMethod: NoSuchMethod,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noexcept: Noexcept,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonatomic: Nonatomic,

    @get:JsonProperty("None", required=true)@field:JsonProperty("None", required=true)
    val none: None,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonlocal: Nonlocal,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonmutating: Nonmutating,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val not: Not,

    @get:JsonProperty("not_eq", required=true)@field:JsonProperty("not_eq", required=true)
    val notEq: NotEq,

    @get:JsonProperty("NSError", required=true)@field:JsonProperty("NSError", required=true)
    val nsError: NSError,

    @get:JsonProperty("NSObject", required=true)@field:JsonProperty("NSObject", required=true)
    val nsObject: NSObject,

    @get:JsonProperty("NSString", required=true)@field:JsonProperty("NSString", required=true)
    val nsString: NSString,

    @get:JsonProperty("NullNode", required=true)@field:JsonProperty("NullNode", required=true)
    val nullNode: NullNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nullptr: Nullptr,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val number: Number,

    @get:JsonProperty("NULL", required=true)@field:JsonProperty("NULL", required=true)
    val obj4NULL: Null,

    @get:JsonProperty("none", required=true)@field:JsonProperty("none", required=true)
    val obj4None: NoneClass,

    @get:JsonProperty("null", required=true)@field:JsonProperty("null", required=true)
    val obj4Null: NullClass,

    @get:JsonProperty("object", required=true)@field:JsonProperty("object", required=true)
    val obj4Object: Object,

    @get:JsonProperty("package", required=true)@field:JsonProperty("package", required=true)
    val obj4Package: Package,

    @get:JsonProperty("protocol", required=true)@field:JsonProperty("protocol", required=true)
    val obj4Protocol: ProtocolClass,

    @get:JsonProperty("ObjectMapper", required=true)@field:JsonProperty("ObjectMapper", required=true)
    val objectMapper: ObjectMapperClass,

    @get:JsonProperty("ObjectNode", required=true)@field:JsonProperty("ObjectNode", required=true)
    val objectNode: ObjectNodeClass,

    @get:JsonProperty("ObjectReader", required=true)@field:JsonProperty("ObjectReader", required=true)
    val objectReader: ObjectReader,

    @get:JsonProperty("ObjectWriter", required=true)@field:JsonProperty("ObjectWriter", required=true)
    val objectWriter: ObjectWriter,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val of: Of,

    @get:JsonProperty("OffsetDateTime", required=true)@field:JsonProperty("OffsetDateTime", required=true)
    val offsetDateTime: OffsetDateTimeClass,

    @get:JsonProperty("OffsetTime", required=true)@field:JsonProperty("OffsetTime", required=true)
    val offsetTime: OffsetTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val oneway: Oneway,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val open: Open,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val operator: Operator,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val optional: Optional,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val or: Or,

    @get:JsonProperty("or_eq", required=true)@field:JsonProperty("or_eq", required=true)
    val orEq: OrEq,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val out: Out,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val override: Override,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val params: Params,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pass: Pass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val port: Port,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val postfix: Postfix,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val precedence: Precedence,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prefix: Prefix,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val print: Print,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val printMembers: PrintMembers,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val printf: Printf,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val private: Private,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protected: Protected,

    @get:JsonProperty("Protocol", required=true)@field:JsonProperty("Protocol", required=true)
    val protocol: Protocol,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val public: Public,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quicktype: Quicktype,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val raise: Raise,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val range: Range,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val readonly: Readonly,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ref: Ref,

    @get:JsonProperty("RegExp", required=true)@field:JsonProperty("RegExp", required=true)
    val regExp: RegExp,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val register: Register,

    @get:JsonProperty("reinterpret_cast", required=true)@field:JsonProperty("reinterpret_cast", required=true)
    val reinterpretCast: ReinterpretCast
)

data class Mutable (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mutable: Long
)

data class Mutating (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mutating: Long
)

data class Namespace (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val namespace: Long
)

data class Native (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val native: Long
)

data class New (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val new: Long
)

data class Newtonsoft (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val newtonsoft: Long
)

data class Nil (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nil: Long
)

data class No (
    @get:JsonProperty("NO", required=true)@field:JsonProperty("NO", required=true)
    val no: Long
)

data class NoSuchMethod (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noSuchMethod: Long
)

data class Noexcept (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noexcept: Long
)

data class Nonatomic (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonatomic: Long
)

data class None (
    @get:JsonProperty("None", required=true)@field:JsonProperty("None", required=true)
    val none: Long
)

data class Nonlocal (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonlocal: Long
)

data class Nonmutating (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonmutating: Long
)

data class Not (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val not: Long
)

data class NotEq (
    @get:JsonProperty("not_eq", required=true)@field:JsonProperty("not_eq", required=true)
    val notEq: Long
)

data class NSError (
    @get:JsonProperty("NSError", required=true)@field:JsonProperty("NSError", required=true)
    val nsError: Long
)

data class NSObject (
    @get:JsonProperty("NSObject", required=true)@field:JsonProperty("NSObject", required=true)
    val nsObject: Long
)

data class NSString (
    @get:JsonProperty("NSString", required=true)@field:JsonProperty("NSString", required=true)
    val nsString: Long
)

data class NullNodeClass (
    @get:JsonProperty("NullNode", required=true)@field:JsonProperty("NullNode", required=true)
    val nullNode: Long
)

data class Nullptr (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nullptr: Long
)

data class Number (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val number: Long
)

data class Null (
    @get:JsonProperty("NULL", required=true)@field:JsonProperty("NULL", required=true)
    val nullNull: Long
)

data class NoneClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val none: Long
)

data class NullClass (
    @get:JsonProperty("null", required=true)@field:JsonProperty("null", required=true)
    val nullNull: Long
)

data class Object (
    @get:JsonProperty("object", required=true)@field:JsonProperty("object", required=true)
    val objectObject: Long
)

data class Package (
    @get:JsonProperty("package", required=true)@field:JsonProperty("package", required=true)
    val packagePackage: Long
)

data class ProtocolClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protocol: Long
)

data class ObjectMapperClass (
    @get:JsonProperty("ObjectMapper", required=true)@field:JsonProperty("ObjectMapper", required=true)
    val objectMapper: Long
)

data class ObjectNodeClass (
    @get:JsonProperty("ObjectNode", required=true)@field:JsonProperty("ObjectNode", required=true)
    val objectNode: Long
)

data class ObjectReader (
    @get:JsonProperty("ObjectReader", required=true)@field:JsonProperty("ObjectReader", required=true)
    val objectReader: Long
)

data class ObjectWriter (
    @get:JsonProperty("ObjectWriter", required=true)@field:JsonProperty("ObjectWriter", required=true)
    val objectWriter: Long
)

data class Of (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val of: Long
)

data class OffsetDateTimeClass (
    @get:JsonProperty("OffsetDateTime", required=true)@field:JsonProperty("OffsetDateTime", required=true)
    val offsetDateTime: Long
)

data class OffsetTime (
    @get:JsonProperty("OffsetTime", required=true)@field:JsonProperty("OffsetTime", required=true)
    val offsetTime: Long
)

data class Oneway (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val oneway: Long
)

data class Open (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val open: Long
)

data class Operator (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val operator: Long
)

data class Optional (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val optional: Long
)

data class Or (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val or: Long
)

data class OrEq (
    @get:JsonProperty("or_eq", required=true)@field:JsonProperty("or_eq", required=true)
    val orEq: Long
)

data class Out (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val out: Long
)

data class Override (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val override: Long
)

data class Params (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val params: Long
)

data class Pass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pass: Long
)

data class Port (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val port: Long
)

data class Postfix (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val postfix: Long
)

data class Precedence (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val precedence: Long
)

data class Prefix (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prefix: Long
)

data class Print (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val print: Long
)

data class PrintMembers (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val printMembers: Long
)

data class Printf (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val printf: Long
)

data class Private (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val private: Long
)

data class Protected (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protected: Long
)

data class Protocol (
    @get:JsonProperty("Protocol", required=true)@field:JsonProperty("Protocol", required=true)
    val protocol: Long
)

data class Public (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val public: Long
)

data class Quicktype (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quicktype: Long
)

data class Raise (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val raise: Long
)

data class Range (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val range: Long
)

data class Readonly (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val readonly: Long
)

data class Ref (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ref: Long
)

data class RegExp (
    @get:JsonProperty("RegExp", required=true)@field:JsonProperty("RegExp", required=true)
    val regExp: String
)

data class Register (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val register: Long
)

data class ReinterpretCast (
    @get:JsonProperty("reinterpret_cast", required=true)@field:JsonProperty("reinterpret_cast", required=true)
    val reinterpretCast: Long
)

data class Obj5 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty("KSerializer", required=true)@field:JsonProperty("KSerializer", required=true)
    val kSerializer: KSerializer,

    @get:JsonProperty("return", required=true)@field:JsonProperty("return", required=true)
    val obj5Return: Return,

    @get:JsonProperty("self", required=true)@field:JsonProperty("self", required=true)
    val obj5Self: SelfClass,

    @get:JsonProperty("super", required=true)@field:JsonProperty("super", required=true)
    val obj5Super: Super,

    @get:JsonProperty("this", required=true)@field:JsonProperty("this", required=true)
    val obj5This: This,

    @get:JsonProperty("throw", required=true)@field:JsonProperty("throw", required=true)
    val obj5Throw: Throw,

    @get:JsonProperty("True", required=true)@field:JsonProperty("True", required=true)
    val obj5True: True,

    @get:JsonProperty("PrimitiveKind", required=true)@field:JsonProperty("PrimitiveKind", required=true)
    val primitiveKind: PrimitiveKind,

    @get:JsonProperty("true", required=true)@field:JsonProperty("true", required=true)
    val purpleTrue: TrueClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val repeat: Repeat,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val require: Require,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val required: Required,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val requires: Requires,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val restrict: Restrict,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val retain: Retain,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rethrows: Rethrows,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val right: Right,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val runtimeType: RuntimeType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val s: S,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sbyte: Sbyte,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sealed: Sealed,

    @get:JsonProperty("SEL", required=true)@field:JsonProperty("SEL", required=true)
    val sel: Sel,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val select: Select,

    @get:JsonProperty("Self", required=true)@field:JsonProperty("Self", required=true)
    val self: Self,

    @get:JsonProperty("Sendable", required=true)@field:JsonProperty("Sendable", required=true)
    val sendable: Sendable,

    @get:JsonProperty("SerialDescriptor", required=true)@field:JsonProperty("SerialDescriptor", required=true)
    val serialDescriptor: SerialDescriptor,

    @get:JsonProperty("SerialName", required=true)@field:JsonProperty("SerialName", required=true)
    val serialName: SerialName,

    @get:JsonProperty("Serializable", required=true)@field:JsonProperty("Serializable", required=true)
    val serializable: Serializable,

    @get:JsonProperty("SerializationFeature", required=true)@field:JsonProperty("SerializationFeature", required=true)
    val serializationFeature: SerializationFeatureClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val serialize: Serialize,

    @get:JsonProperty("SerializerProvider", required=true)@field:JsonProperty("SerializerProvider", required=true)
    val serializerProvider: SerializerProviderClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val set: Set,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val short: ShortClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val signed: Signed,

    @get:JsonProperty("SimpleModule", required=true)@field:JsonProperty("SimpleModule", required=true)
    val simpleModule: SimpleModuleClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sizeof: Sizeof,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stackalloc: Stackalloc,

    @get:JsonProperty("Standards", required=true)@field:JsonProperty("Standards", required=true)
    val standards: Standards,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val static: Static,

    @get:JsonProperty("static_assert", required=true)@field:JsonProperty("static_assert", required=true)
    val staticAssert: StaticAssert,

    @get:JsonProperty("static_cast", required=true)@field:JsonProperty("static_cast", required=true)
    val staticCast: StaticCast,

    @get:JsonProperty("StdDeserializer", required=true)@field:JsonProperty("StdDeserializer", required=true)
    val stdDeserializer: StdDeserializerClass,

    @get:JsonProperty("StdSerializer", required=true)@field:JsonProperty("StdSerializer", required=true)
    val stdSerializer: StdSerializerClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val strictfp: Strictfp,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val string: StringClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val struct: Struct,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subscript: Subscript,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val switch: Switch,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val symbol: Symbol,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val synchronized: Synchronized,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val system: SystemClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val template: Template,

    @get:JsonProperty("TextNode", required=true)@field:JsonProperty("TextNode", required=true)
    val textNode: TextNodeClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val then: Then,

    @get:JsonProperty("thread_local", required=true)@field:JsonProperty("thread_local", required=true)
    val threadLocal: ThreadLocal,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val throws: Throws,

    @get:JsonProperty("TimeOnly", required=true)@field:JsonProperty("TimeOnly", required=true)
    val timeOnly: TimeOnly,

    @get:JsonProperty("TimeOnlyConverter", required=true)@field:JsonProperty("TimeOnlyConverter", required=true)
    val timeOnlyConverter: TimeOnlyConverter,

    @get:JsonProperty("TimeZone", required=true)@field:JsonProperty("TimeZone", required=true)
    val timeZone: TimeZone,

    @get:JsonProperty("to_dict", required=true)@field:JsonProperty("to_dict", required=true)
    val toDict: ToDict,

    @get:JsonProperty("to_json", required=true)@field:JsonProperty("to_json", required=true)
    val toJSON: ToJSON,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val toString: ToString,

    @get:JsonProperty("top_level", required=true)@field:JsonProperty("top_level", required=true)
    val topLevel: TopLevelClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val transient: Transient
)

data class KSerializer (
    @get:JsonProperty("KSerializer", required=true)@field:JsonProperty("KSerializer", required=true)
    val kSerializer: Long
)

data class Return (
    @get:JsonProperty("return", required=true)@field:JsonProperty("return", required=true)
    val returnReturn: Long
)

data class SelfClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val self: Long
)

data class Super (
    @get:JsonProperty("super", required=true)@field:JsonProperty("super", required=true)
    val superSuper: Long
)

data class This (
    @get:JsonProperty("this", required=true)@field:JsonProperty("this", required=true)
    val thisThis: Long
)

data class Throw (
    @get:JsonProperty("throw", required=true)@field:JsonProperty("throw", required=true)
    val throwThrow: Long
)

data class True (
    @get:JsonProperty("True", required=true)@field:JsonProperty("True", required=true)
    val trueTrue: Long
)

data class PrimitiveKind (
    @get:JsonProperty("PrimitiveKind", required=true)@field:JsonProperty("PrimitiveKind", required=true)
    val primitiveKind: Long
)

data class TrueClass (
    @get:JsonProperty("true", required=true)@field:JsonProperty("true", required=true)
    val trueTrue: Long
)

data class Repeat (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val repeat: Long
)

data class Require (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val require: Long
)

data class Required (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val required: Long
)

data class Requires (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val requires: Long
)

data class Restrict (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val restrict: Long
)

data class Retain (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val retain: Long
)

data class Rethrows (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rethrows: Long
)

data class Right (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val right: Long
)

data class RuntimeType (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val runtimeType: Long
)

data class S (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val s: Long
)

data class Sbyte (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sbyte: Long
)

data class Sealed (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sealed: Long
)

data class Sel (
    @get:JsonProperty("SEL", required=true)@field:JsonProperty("SEL", required=true)
    val sel: Long
)

data class Select (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val select: Long
)

data class Self (
    @get:JsonProperty("Self", required=true)@field:JsonProperty("Self", required=true)
    val self: Long
)

data class Sendable (
    @get:JsonProperty("Sendable", required=true)@field:JsonProperty("Sendable", required=true)
    val sendable: Long
)

data class SerialDescriptor (
    @get:JsonProperty("SerialDescriptor", required=true)@field:JsonProperty("SerialDescriptor", required=true)
    val serialDescriptor: Long
)

data class SerialName (
    @get:JsonProperty("SerialName", required=true)@field:JsonProperty("SerialName", required=true)
    val serialName: Long
)

data class Serializable (
    @get:JsonProperty("Serializable", required=true)@field:JsonProperty("Serializable", required=true)
    val serializable: Long
)

data class SerializationFeatureClass (
    @get:JsonProperty("SerializationFeature", required=true)@field:JsonProperty("SerializationFeature", required=true)
    val serializationFeature: Long
)

data class Serialize (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val serialize: Long
)

data class SerializerProviderClass (
    @get:JsonProperty("SerializerProvider", required=true)@field:JsonProperty("SerializerProvider", required=true)
    val serializerProvider: Long
)

data class Set (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val set: Long
)

data class ShortClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val short: Long
)

data class Signed (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val signed: Long
)

data class SimpleModuleClass (
    @get:JsonProperty("SimpleModule", required=true)@field:JsonProperty("SimpleModule", required=true)
    val simpleModule: Long
)

data class Sizeof (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sizeof: Long
)

data class Stackalloc (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stackalloc: Long
)

data class Standards (
    @get:JsonProperty("Standards", required=true)@field:JsonProperty("Standards", required=true)
    val standards: Long
)

data class Static (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val static: Long
)

data class StaticAssert (
    @get:JsonProperty("static_assert", required=true)@field:JsonProperty("static_assert", required=true)
    val staticAssert: Long
)

data class StaticCast (
    @get:JsonProperty("static_cast", required=true)@field:JsonProperty("static_cast", required=true)
    val staticCast: Long
)

data class StdDeserializerClass (
    @get:JsonProperty("StdDeserializer", required=true)@field:JsonProperty("StdDeserializer", required=true)
    val stdDeserializer: Long
)

data class StdSerializerClass (
    @get:JsonProperty("StdSerializer", required=true)@field:JsonProperty("StdSerializer", required=true)
    val stdSerializer: Long
)

data class Strictfp (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val strictfp: Long
)

data class StringClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val string: Long
)

data class Struct (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val struct: Long
)

data class Subscript (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subscript: Long
)

data class Switch (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val switch: Long
)

data class Symbol (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val symbol: Long
)

data class Synchronized (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val synchronized: Long
)

data class SystemClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val system: Long
)

data class Template (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val template: Long
)

data class TextNodeClass (
    @get:JsonProperty("TextNode", required=true)@field:JsonProperty("TextNode", required=true)
    val textNode: Long
)

data class Then (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val then: Long
)

data class ThreadLocal (
    @get:JsonProperty("thread_local", required=true)@field:JsonProperty("thread_local", required=true)
    val threadLocal: Long
)

data class Throws (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val throws: Long
)

data class TimeOnly (
    @get:JsonProperty("TimeOnly", required=true)@field:JsonProperty("TimeOnly", required=true)
    val timeOnly: Long
)

data class TimeOnlyConverter (
    @get:JsonProperty("TimeOnlyConverter", required=true)@field:JsonProperty("TimeOnlyConverter", required=true)
    val timeOnlyConverter: Long
)

data class TimeZone (
    @get:JsonProperty("TimeZone", required=true)@field:JsonProperty("TimeZone", required=true)
    val timeZone: Long
)

data class ToDict (
    @get:JsonProperty("to_dict", required=true)@field:JsonProperty("to_dict", required=true)
    val toDict: Long
)

data class ToJSON (
    @get:JsonProperty("to_json", required=true)@field:JsonProperty("to_json", required=true)
    val toJSON: Long
)

data class ToString (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val toString: Long
)

data class TopLevelClass (
    @get:JsonProperty("top_level", required=true)@field:JsonProperty("top_level", required=true)
    val topLevel: Long
)

data class Transient (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val transient: Long
)

data class Obj6 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dummy: Long,

    @get:JsonProperty("try", required=true)@field:JsonProperty("try", required=true)
    val obj6Try: Try,

    @get:JsonProperty("type", required=true)@field:JsonProperty("type", required=true)
    val obj6Type: TypeClass,

    @get:JsonProperty("typealias", required=true)@field:JsonProperty("typealias", required=true)
    val obj6Typealias: Typealias,

    @get:JsonProperty("typeof", required=true)@field:JsonProperty("typeof", required=true)
    val obj6Typeof: Typeof,

    @get:JsonProperty("var", required=true)@field:JsonProperty("var", required=true)
    val obj6Var: Var,

    @get:JsonProperty("while", required=true)@field:JsonProperty("while", required=true)
    val obj6While: While,

    @get:JsonProperty("Type", required=true)@field:JsonProperty("Type", required=true)
    val type: Type,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typedef: Typedef,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typeid: Typeid,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typename: Typename,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uint: Uint,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ulong: Ulong,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unchecked: Unchecked,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undefined: Undefined,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: Union,

    @get:JsonProperty("UnmarshalJSON", required=true)@field:JsonProperty("UnmarshalJSON", required=true)
    val unmarshalJSON: UnmarshalJSON,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unowned: Unowned,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsafe: Unsafe,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsigned: Unsigned,

    @get:JsonProperty("UseSerializers", required=true)@field:JsonProperty("UseSerializers", required=true)
    val useSerializers: UseSerializers,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ushort: Ushort,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val using: Using,

    @get:JsonProperty("Utf8JsonReader", required=true)@field:JsonProperty("Utf8JsonReader", required=true)
    val utf8JSONReader: Utf8JSONReader,

    @get:JsonProperty("Utf8JsonWriter", required=true)@field:JsonProperty("Utf8JsonWriter", required=true)
    val utf8JSONWriter: Utf8JSONWriter,

    @get:JsonProperty("UUID", required=true)@field:JsonProperty("UUID", required=true)
    val uuid: UUID,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val virtual: Virtual,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val void: Void,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val volatile: Volatile,

    @get:JsonProperty("wchar_t", required=true)@field:JsonProperty("wchar_t", required=true)
    val wcharT: WcharT,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weak: Weak,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val where: Where,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val willSet: WillSet,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val with: With,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val xor: Xor,

    @get:JsonProperty("xor_eq", required=true)@field:JsonProperty("xor_eq", required=true)
    val xorEq: XorEq,

    @get:JsonProperty("YES", required=true)@field:JsonProperty("YES", required=true)
    val yes: Yes,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val yield: Yield
)

data class Try (
    @get:JsonProperty("try", required=true)@field:JsonProperty("try", required=true)
    val tryTry: Long
)

data class TypeClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Long
)

data class Typealias (
    @get:JsonProperty("typealias", required=true)@field:JsonProperty("typealias", required=true)
    val typealiasTypealias: Long
)

data class Typeof (
    @get:JsonProperty("typeof", required=true)@field:JsonProperty("typeof", required=true)
    val typeofTypeof: Long
)

data class Var (
    @get:JsonProperty("var", required=true)@field:JsonProperty("var", required=true)
    val varVar: Long
)

data class While (
    @get:JsonProperty("while", required=true)@field:JsonProperty("while", required=true)
    val whileWhile: Long
)

data class Type (
    @get:JsonProperty("Type", required=true)@field:JsonProperty("Type", required=true)
    val type: Long
)

data class Typedef (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typedef: Long
)

data class Typeid (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typeid: Long
)

data class Typename (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val typename: Long
)

data class Uint (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uint: Long
)

data class Ulong (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ulong: Long
)

data class Unchecked (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unchecked: Long
)

data class Undefined (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undefined: Long
)

data class Union (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: Long
)

data class UnmarshalJSON (
    @get:JsonProperty("UnmarshalJSON", required=true)@field:JsonProperty("UnmarshalJSON", required=true)
    val unmarshalJSON: Long
)

data class Unowned (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unowned: Long
)

data class Unsafe (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsafe: Long
)

data class Unsigned (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsigned: Long
)

data class UseSerializers (
    @get:JsonProperty("UseSerializers", required=true)@field:JsonProperty("UseSerializers", required=true)
    val useSerializers: Long
)

data class Ushort (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ushort: Long
)

data class Using (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val using: Long
)

data class Utf8JSONReader (
    @get:JsonProperty("Utf8JsonReader", required=true)@field:JsonProperty("Utf8JsonReader", required=true)
    val utf8JSONReader: Long
)

data class Utf8JSONWriter (
    @get:JsonProperty("Utf8JsonWriter", required=true)@field:JsonProperty("Utf8JsonWriter", required=true)
    val utf8JSONWriter: Long
)

data class UUID (
    @get:JsonProperty("UUID", required=true)@field:JsonProperty("UUID", required=true)
    val uuid: Long
)

data class Virtual (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val virtual: Long
)

data class Void (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val void: Long
)

data class Volatile (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val volatile: Long
)

data class WcharT (
    @get:JsonProperty("wchar_t", required=true)@field:JsonProperty("wchar_t", required=true)
    val wcharT: Long
)

data class Weak (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weak: Long
)

data class Where (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val where: Long
)

data class WillSet (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val willSet: Long
)

data class With (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val with: Long
)

data class Xor (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val xor: Long
)

data class XorEq (
    @get:JsonProperty("xor_eq", required=true)@field:JsonProperty("xor_eq", required=true)
    val xorEq: Long
)

data class Yes (
    @get:JsonProperty("YES", required=true)@field:JsonProperty("YES", required=true)
    val yes: Long
)

data class Yield (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val yield: Long
)
