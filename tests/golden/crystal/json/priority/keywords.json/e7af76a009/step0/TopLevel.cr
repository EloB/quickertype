require "json"

class TopLevel
  include JSON::Serializable

  property dummy : Int64

  property obj1 : Obj1

  property obj2 : Obj2

  property obj3 : Obj3

  property obj4 : Obj4

  property obj5 : Obj5

  property obj6 : Obj6
end

class Obj1
  include JSON::Serializable

  property alignas : Alignas

  property alignof : Alignof

  property and : And

  property and_eq : AndEq

  @[JSON::Field(key: "Any")]
  property any : AnyClass

  property array : ArrayClass

  @[JSON::Field(key: "ArrayNode")]
  property array_node : ArrayNode

  property assert : Assert

  property associatedtype : Associatedtype

  property associativity : Associativity

  property async : Async

  property atomic : AtomicClass

  property atomic_cancel : AtomicCancel

  property atomic_commit : AtomicCommit

  property atomic_noexcept : AtomicNoexcept

  property auto : Auto

  property await : Await

  property base : Base

  property bitand : Bitand

  property bitor : Bitor

  @[JSON::Field(key: "BOOL")]
  property bool : BoolClass

  property boolean : Boolean

  @[JSON::Field(key: "BooleanNode")]
  property boolean_node : BooleanNode

  property bycopy : Bycopy

  property byref : Byref

  property byte : Byte

  @[JSON::Field(key: "Calendar")]
  property calendar : Calendar

  property catch : Catch

  property chan : Chan

  property char : CharClass

  property char16_t : Char16T

  property char32_t : Char32T

  property checked : Checked

  property clone : Clone

  property co_await : CoAwait

  property co_return : CoReturn

  property co_yield : CoYield

  @[JSON::Field(key: "Codable")]
  property codable : Codable

  @[JSON::Field(key: "CodingKey")]
  property coding_key : CodingKey

  @[JSON::Field(key: "CodingKeys")]
  property coding_keys : CodingKeys

  property compl : Compl

  @[JSON::Field(key: "_Complex")]
  property complex : Complex

  property concept : Concept

  property console : Console

  property const : Const

  property const_cast : ConstCast

  property constexpr : Constexpr

  property constructor : Constructor

  property continue : Continue

  property convenience : Convenience

  property convert : Convert

  property converter : Converter

  property dummy : Int64

  @[JSON::Field(key: "_")]
  property empty : Empty

  @[JSON::Field(key: "_Imaginery")]
  property imaginery : Imaginery

  @[JSON::Field(key: "abstract")]
  property obj1_abstract : Abstract

  @[JSON::Field(key: "any")]
  property obj1_any : Obj1Any

  @[JSON::Field(key: "as")]
  property obj1_as : As

  @[JSON::Field(key: "asm")]
  property obj1_asm : Asm

  @[JSON::Field(key: "_Bool")]
  property obj1_bool : Obj1Bool

  @[JSON::Field(key: "break")]
  property obj1_break : Break

  @[JSON::Field(key: "case")]
  property obj1_case : Case

  @[JSON::Field(key: "Class")]
  property obj1_class : ClassClass

  @[JSON::Field(key: "bool")]
  property purple_bool : Obj1BoolClass

  @[JSON::Field(key: "class")]
  property purple_class : Obj1Class
end

class Alignas
  include JSON::Serializable

  property alignas : Int64
end

class Alignof
  include JSON::Serializable

  property alignof : Int64
end

class And
  include JSON::Serializable

  property and : Int64
end

class AndEq
  include JSON::Serializable

  property and_eq : Int64
end

class AnyClass
  include JSON::Serializable

  @[JSON::Field(key: "Any")]
  property any : Int64
end

class ArrayClass
  include JSON::Serializable

  property array : Int64
end

class ArrayNode
  include JSON::Serializable

  @[JSON::Field(key: "ArrayNode")]
  property array_node : Int64
end

class Assert
  include JSON::Serializable

  property assert : Int64
end

class Associatedtype
  include JSON::Serializable

  property associatedtype : Int64
end

class Associativity
  include JSON::Serializable

  property associativity : Int64
end

class Async
  include JSON::Serializable

  property async : Int64
end

class AtomicClass
  include JSON::Serializable

  property atomic : Int64
end

class AtomicCancel
  include JSON::Serializable

  property atomic_cancel : Int64
end

class AtomicCommit
  include JSON::Serializable

  property atomic_commit : Int64
end

class AtomicNoexcept
  include JSON::Serializable

  property atomic_noexcept : Int64
end

class Auto
  include JSON::Serializable

  property auto : Int64
end

class Await
  include JSON::Serializable

  property await : Int64
end

class Base
  include JSON::Serializable

  property base : Int64
end

class Bitand
  include JSON::Serializable

  property bitand : Int64
end

class Bitor
  include JSON::Serializable

  property bitor : Int64
end

class BoolClass
  include JSON::Serializable

  @[JSON::Field(key: "BOOL")]
  property bool : Int64
end

class Boolean
  include JSON::Serializable

  property boolean : Int64
end

class BooleanNode
  include JSON::Serializable

  @[JSON::Field(key: "BooleanNode")]
  property boolean_node : Int64
end

class Bycopy
  include JSON::Serializable

  property bycopy : Int64
end

class Byref
  include JSON::Serializable

  property byref : Int64
end

class Byte
  include JSON::Serializable

  property byte : Int64
end

class Calendar
  include JSON::Serializable

  @[JSON::Field(key: "Calendar")]
  property calendar : Int64
end

class Catch
  include JSON::Serializable

  property catch : Int64
end

class Chan
  include JSON::Serializable

  property chan : Int64
end

class CharClass
  include JSON::Serializable

  property char : Int64
end

class Char16T
  include JSON::Serializable

  property char16_t : Int64
end

class Char32T
  include JSON::Serializable

  property char32_t : Int64
end

class Checked
  include JSON::Serializable

  property checked : Int64
end

class Clone
  include JSON::Serializable

  property clone : Int64
end

class CoAwait
  include JSON::Serializable

  property co_await : Int64
end

class CoReturn
  include JSON::Serializable

  property co_return : Int64
end

class CoYield
  include JSON::Serializable

  property co_yield : Int64
end

class Codable
  include JSON::Serializable

  @[JSON::Field(key: "Codable")]
  property codable : Int64
end

class CodingKey
  include JSON::Serializable

  @[JSON::Field(key: "CodingKey")]
  property coding_key : Int64
end

class CodingKeys
  include JSON::Serializable

  @[JSON::Field(key: "CodingKeys")]
  property coding_keys : Int64
end

class Compl
  include JSON::Serializable

  property compl : Int64
end

class Complex
  include JSON::Serializable

  @[JSON::Field(key: "_Complex")]
  property complex : Int64
end

class Concept
  include JSON::Serializable

  property concept : Int64
end

class Console
  include JSON::Serializable

  property console : Int64
end

class Const
  include JSON::Serializable

  property const : Int64
end

class ConstCast
  include JSON::Serializable

  property const_cast : Int64
end

class Constexpr
  include JSON::Serializable

  property constexpr : Int64
end

class Constructor
  include JSON::Serializable

  property constructor : Int64
end

class Continue
  include JSON::Serializable

  property continue : Int64
end

class Convenience
  include JSON::Serializable

  property convenience : Int64
end

class Convert
  include JSON::Serializable

  property convert : Int64
end

class Converter
  include JSON::Serializable

  property converter : Int64
end

class Empty
  include JSON::Serializable

  @[JSON::Field(key: "_")]
  property empty : Int64
end

class Imaginery
  include JSON::Serializable

  @[JSON::Field(key: "_Imaginery")]
  property imaginery : Int64
end

class Abstract
  include JSON::Serializable

  @[JSON::Field(key: "abstract")]
  property abstract_abstract : Int64
end

class Obj1Any
  include JSON::Serializable

  property any : Int64
end

class As
  include JSON::Serializable

  @[JSON::Field(key: "as")]
  property as_as : Int64
end

class Asm
  include JSON::Serializable

  @[JSON::Field(key: "asm")]
  property asm_asm : Int64
end

class Obj1Bool
  include JSON::Serializable

  @[JSON::Field(key: "_Bool")]
  property bool : Int64
end

class Break
  include JSON::Serializable

  @[JSON::Field(key: "break")]
  property break_break : Int64
end

class Case
  include JSON::Serializable

  @[JSON::Field(key: "case")]
  property case_case : Int64
end

class ClassClass
  include JSON::Serializable

  @[JSON::Field(key: "Class")]
  property class_class : Int64
end

class Obj1BoolClass
  include JSON::Serializable

  property bool : Int64
end

class Obj1Class
  include JSON::Serializable

  @[JSON::Field(key: "class")]
  property class_class : Int64
end

class Obj2
  include JSON::Serializable

  @[JSON::Field(key: "CultureInfo")]
  property culture_info : CultureInfo

  property date : Date

  @[JSON::Field(key: "DateFormatter")]
  property date_formatter : DateFormatter

  @[JSON::Field(key: "DateOnly")]
  property date_only : DateOnly

  @[JSON::Field(key: "DateOnlyConverter")]
  property date_only_converter : DateOnlyConverter

  property date_parse_handling : DateParseHandling

  @[JSON::Field(key: "DateTime")]
  property date_time : DateTime

  @[JSON::Field(key: "DateTimeStyles")]
  property date_time_styles : DateTimeStyles

  property debugger : Debugger

  property decimal : Decimal

  property declare : Declare

  property decltype : Decltype

  property decode_string : DecodeString

  @[JSON::Field(key: "Decoder")]
  property decoder : Decoder

  @[JSON::Field(key: "DecodingError")]
  property decoding_error : DecodingError

  property default : Default

  property defer : Defer

  property deinit : Deinit

  property del : Del

  property delegate : Delegate

  property delete : Delete

  @[JSON::Field(key: "DeserializationFeature")]
  property deserialization_feature : DeserializationFeature

  property dict : Dict

  property dictionary : Dictionary

  @[JSON::Field(key: "didSet")]
  property did_set : DidSet

  property double : Double

  @[JSON::Field(key: "DoubleNode")]
  property double_node : DoubleNode

  property dummy : Int64

  property dynamic : Dynamic

  property dynamic_cast : DynamicCast

  property elif : Elif

  property encode_quick_type : EncodeQuickType

  @[JSON::Field(key: "Encoder")]
  property encoder : Encoder

  @[JSON::Field(key: "EnumValues")]
  property enum_values : EnumValues

  @[JSON::Field(key: "equalityContract")]
  property equality_contract : EqualityContract

  @[JSON::Field(key: "Equatable")]
  property equatable : Equatable

  property event : EventClass

  property except : Except

  property exception : ExceptionClass

  property explicit : Explicit

  property export : Export

  property exposing : Exposing

  property extends : Extends

  property extension : Extension

  property extern : ExternClass

  property fallthrough : Fallthrough

  property fileprivate : Fileprivate

  property final : Final

  property finally : Finally

  property fixed : Fixed

  property float : FloatClass

  property foreach : Foreach

  @[JSON::Field(key: "FormatException")]
  property format_exception : FormatException

  property friend : Friend

  property from : From

  property from_dict : FromDict

  property from_json : FromJson

  property func : Func

  @[JSON::Field(key: "def")]
  property obj2_def : Def

  @[JSON::Field(key: "do")]
  property obj2_do : Do

  @[JSON::Field(key: "else")]
  property obj2_else : Else

  @[JSON::Field(key: "enum")]
  property obj2_enum : EnumClass

  @[JSON::Field(key: "False")]
  property obj2_false : False

  @[JSON::Field(key: "for")]
  property obj2_for : For

  @[JSON::Field(key: "false")]
  property purple_false : FalseClass
end

class CultureInfo
  include JSON::Serializable

  @[JSON::Field(key: "CultureInfo")]
  property culture_info : Int64
end

class Date
  include JSON::Serializable

  property date : Int64
end

class DateFormatter
  include JSON::Serializable

  @[JSON::Field(key: "DateFormatter")]
  property date_formatter : Int64
end

class DateOnly
  include JSON::Serializable

  @[JSON::Field(key: "DateOnly")]
  property date_only : Int64
end

class DateOnlyConverter
  include JSON::Serializable

  @[JSON::Field(key: "DateOnlyConverter")]
  property date_only_converter : Int64
end

class DateParseHandling
  include JSON::Serializable

  property date_parse_handling : Int64
end

class DateTime
  include JSON::Serializable

  @[JSON::Field(key: "DateTime")]
  property date_time : String
end

class DateTimeStyles
  include JSON::Serializable

  @[JSON::Field(key: "DateTimeStyles")]
  property date_time_styles : Int64
end

class Debugger
  include JSON::Serializable

  property debugger : Int64
end

class Decimal
  include JSON::Serializable

  property decimal : Int64
end

class Declare
  include JSON::Serializable

  property declare : Int64
end

class Decltype
  include JSON::Serializable

  property decltype : Int64
end

class DecodeString
  include JSON::Serializable

  property decode_string : Int64
end

class Decoder
  include JSON::Serializable

  @[JSON::Field(key: "Decoder")]
  property decoder : Int64
end

class DecodingError
  include JSON::Serializable

  @[JSON::Field(key: "DecodingError")]
  property decoding_error : Int64
end

class Default
  include JSON::Serializable

  property default : Int64
end

class Defer
  include JSON::Serializable

  property defer : Int64
end

class Deinit
  include JSON::Serializable

  property deinit : Int64
end

class Del
  include JSON::Serializable

  property del : Int64
end

class Delegate
  include JSON::Serializable

  property delegate : Int64
end

class Delete
  include JSON::Serializable

  property delete : Int64
end

class DeserializationFeature
  include JSON::Serializable

  @[JSON::Field(key: "DeserializationFeature")]
  property deserialization_feature : Int64
end

class Dict
  include JSON::Serializable

  property dict : Int64
end

class Dictionary
  include JSON::Serializable

  property dictionary : Int64
end

class DidSet
  include JSON::Serializable

  @[JSON::Field(key: "didSet")]
  property did_set : Int64
end

class Double
  include JSON::Serializable

  property double : Int64
end

class DoubleNode
  include JSON::Serializable

  @[JSON::Field(key: "DoubleNode")]
  property double_node : Int64
end

class Dynamic
  include JSON::Serializable

  property dynamic : Int64
end

class DynamicCast
  include JSON::Serializable

  property dynamic_cast : Int64
end

class Elif
  include JSON::Serializable

  property elif : Int64
end

class EncodeQuickType
  include JSON::Serializable

  property encode_quick_type : Int64
end

class Encoder
  include JSON::Serializable

  @[JSON::Field(key: "Encoder")]
  property encoder : Int64
end

class EnumValues
  include JSON::Serializable

  @[JSON::Field(key: "EnumValues")]
  property enum_values : Array(String)
end

class EqualityContract
  include JSON::Serializable

  @[JSON::Field(key: "equalityContract")]
  property equality_contract : Int64
end

class Equatable
  include JSON::Serializable

  @[JSON::Field(key: "Equatable")]
  property equatable : Int64
end

class EventClass
  include JSON::Serializable

  property event : Int64
end

class Except
  include JSON::Serializable

  property except : Int64
end

class ExceptionClass
  include JSON::Serializable

  property exception : Int64
end

class Explicit
  include JSON::Serializable

  property explicit : Int64
end

class Export
  include JSON::Serializable

  property export : Int64
end

class Exposing
  include JSON::Serializable

  property exposing : Int64
end

class Extends
  include JSON::Serializable

  property extends : Int64
end

class Extension
  include JSON::Serializable

  property extension : Int64
end

class ExternClass
  include JSON::Serializable

  property extern : Int64
end

class Fallthrough
  include JSON::Serializable

  property fallthrough : Int64
end

class Fileprivate
  include JSON::Serializable

  property fileprivate : Int64
end

class Final
  include JSON::Serializable

  property final : Int64
end

class Finally
  include JSON::Serializable

  property finally : Int64
end

class Fixed
  include JSON::Serializable

  property fixed : Int64
end

class FloatClass
  include JSON::Serializable

  property float : Int64
end

class Foreach
  include JSON::Serializable

  property foreach : Int64
end

class FormatException
  include JSON::Serializable

  @[JSON::Field(key: "FormatException")]
  property format_exception : Int64
end

class Friend
  include JSON::Serializable

  property friend : Int64
end

class From
  include JSON::Serializable

  property from : Int64
end

class FromDict
  include JSON::Serializable

  property from_dict : Int64
end

class FromJson
  include JSON::Serializable

  property from_json : Int64
end

class Func
  include JSON::Serializable

  property func : Int64
end

class Def
  include JSON::Serializable

  @[JSON::Field(key: "def")]
  property def_def : Int64
end

class Do
  include JSON::Serializable

  @[JSON::Field(key: "do")]
  property do_do : Int64
end

class Else
  include JSON::Serializable

  @[JSON::Field(key: "else")]
  property else_else : Int64
end

class EnumClass
  include JSON::Serializable

  @[JSON::Field(key: "enum")]
  property enum_enum : Int64
end

class False
  include JSON::Serializable

  @[JSON::Field(key: "False")]
  property false_false : Int64
end

class For
  include JSON::Serializable

  @[JSON::Field(key: "for")]
  property for_for : Int64
end

class FalseClass
  include JSON::Serializable

  @[JSON::Field(key: "false")]
  property false_false : Int64
end

class Obj3
  include JSON::Serializable

  property dummy : Int64

  property function : Function

  property get : Get

  property global : Global

  property go : Go

  property goto : Goto

  property guard : Guard

  @[JSON::Field(key: "hasOwnProperty")]
  property has_own_property : HasOwnProperty

  @[JSON::Field(key: "hashCode")]
  property hash_code : HashCode

  @[JSON::Field(key: "Hashable")]
  property hashable : Hashable

  @[JSON::Field(key: "Hasher")]
  property hasher : Hasher

  property id : Id

  @[JSON::Field(key: "IMP")]
  property imp : Imp

  property implements : Implements

  property implicit : Implicit

  property import : Import

  property indirect : Indirect

  property infix : Infix

  property init : Init

  property inline : Inline

  property inout : Inout

  property instanceof : Instanceof

  property int : IntClass

  @[JSON::Field(key: "IntNode")]
  property int_node : IntNode

  property interface : Interface

  property internal : Internal

  property is : Is

  @[JSON::Field(key: "IsoDateTimeOffsetConverter")]
  property iso_date_time_offset_converter : IsoDateTimeOffsetConverter

  property iterable : IterableClass

  property jdec : Jdec

  property jenc : Jenc

  property jpipe : Jpipe

  property json : Json

  @[JSON::Field(key: "JSONAny")]
  property json_any : JsonAny

  @[JSON::Field(key: "JSONCodingKey")]
  property json_coding_key : JsonCodingKey

  property json_converter : JsonConverter

  @[JSON::Field(key: "JSONDecoder")]
  property json_decoder : JsonDecoder

  @[JSON::Field(key: "JSONEncoder")]
  property json_encoder : JsonEncoder

  @[JSON::Field(key: "JsonException")]
  property json_exception : JsonException

  @[JSON::Field(key: "JsonGenerator")]
  property json_generator : JsonGenerator

  @[JSON::Field(key: "JsonNode")]
  property json_node : JsonNode

  @[JSON::Field(key: "JSONNull")]
  property json_null : JsonNull

  @[JSON::Field(key: "JsonParser")]
  property json_parser : JsonParser

  @[JSON::Field(key: "JsonReader")]
  property json_reader : JsonReader

  property json_serializer : JsonSerializer

  property json_token : JsonToken

  @[JSON::Field(key: "JsonTokenType")]
  property json_token_type : JsonTokenType

  property json_writer : JsonWriter

  property lambda : Lambda

  property lazy : Lazy

  property left : Left

  property let : Let

  property list : List

  @[JSON::Field(key: "LocalDate")]
  property local_date : LocalDate

  @[JSON::Field(key: "Locale")]
  property locale : Locale

  property lock : Lock

  property long : Long

  @[JSON::Field(key: "LongNode")]
  property long_node : LongNode

  property map : Map

  @[JSON::Field(key: "MapEntry")]
  property map_entry : MapEntry

  @[JSON::Field(key: "MarshalJSON")]
  property marshal_json : MarshalJson

  property metadata_property_handling : MetadataPropertyHandling

  @[JSON::Field(key: "if")]
  property obj3_if : If

  @[JSON::Field(key: "in")]
  property obj3_in : In

  @[JSON::Field(key: "module")]
  property obj3_module : Module
end

class Function
  include JSON::Serializable

  property function : Int64
end

class Get
  include JSON::Serializable

  property get : Int64
end

class Global
  include JSON::Serializable

  property global : Int64
end

class Go
  include JSON::Serializable

  property go : Int64
end

class Goto
  include JSON::Serializable

  property goto : Int64
end

class Guard
  include JSON::Serializable

  property guard : Int64
end

class HasOwnProperty
  include JSON::Serializable

  @[JSON::Field(key: "hasOwnProperty")]
  property has_own_property : Int64
end

class HashCode
  include JSON::Serializable

  @[JSON::Field(key: "hashCode")]
  property hash_code : Int64
end

class Hashable
  include JSON::Serializable

  @[JSON::Field(key: "Hashable")]
  property hashable : Int64
end

class Hasher
  include JSON::Serializable

  @[JSON::Field(key: "Hasher")]
  property hasher : Int64
end

class Id
  include JSON::Serializable

  property id : Int64
end

class Imp
  include JSON::Serializable

  @[JSON::Field(key: "IMP")]
  property imp : Int64
end

class Implements
  include JSON::Serializable

  property implements : Int64
end

class Implicit
  include JSON::Serializable

  property implicit : Int64
end

class Import
  include JSON::Serializable

  property import : Int64
end

class Indirect
  include JSON::Serializable

  property indirect : Int64
end

class Infix
  include JSON::Serializable

  property infix : Int64
end

class Init
  include JSON::Serializable

  property init : Int64
end

class Inline
  include JSON::Serializable

  property inline : Int64
end

class Inout
  include JSON::Serializable

  property inout : Int64
end

class Instanceof
  include JSON::Serializable

  property instanceof : Int64
end

class IntClass
  include JSON::Serializable

  property int : Int64
end

class IntNode
  include JSON::Serializable

  @[JSON::Field(key: "IntNode")]
  property int_node : Int64
end

class Interface
  include JSON::Serializable

  property interface : Int64
end

class Internal
  include JSON::Serializable

  property internal : Int64
end

class Is
  include JSON::Serializable

  property is : Int64
end

class IsoDateTimeOffsetConverter
  include JSON::Serializable

  @[JSON::Field(key: "IsoDateTimeOffsetConverter")]
  property iso_date_time_offset_converter : Int64
end

class IterableClass
  include JSON::Serializable

  property iterable : Int64
end

class Jdec
  include JSON::Serializable

  property jdec : Int64
end

class Jenc
  include JSON::Serializable

  property jenc : Int64
end

class Jpipe
  include JSON::Serializable

  property jpipe : Int64
end

class Json
  include JSON::Serializable

  property json : Int64
end

class JsonAny
  include JSON::Serializable

  @[JSON::Field(key: "JSONAny")]
  property json_any : Nil
end

class JsonCodingKey
  include JSON::Serializable

  @[JSON::Field(key: "JSONCodingKey")]
  property json_coding_key : Int64
end

class JsonConverter
  include JSON::Serializable

  property json_converter : Int64
end

class JsonDecoder
  include JSON::Serializable

  @[JSON::Field(key: "JSONDecoder")]
  property json_decoder : Int64
end

class JsonEncoder
  include JSON::Serializable

  @[JSON::Field(key: "JSONEncoder")]
  property json_encoder : Int64
end

class JsonException
  include JSON::Serializable

  @[JSON::Field(key: "JsonException")]
  property json_exception : Int64
end

class JsonGenerator
  include JSON::Serializable

  @[JSON::Field(key: "JsonGenerator")]
  property json_generator : Int64
end

class JsonNode
  include JSON::Serializable

  @[JSON::Field(key: "JsonNode")]
  property json_node : Int64
end

class JsonNull
  include JSON::Serializable

  @[JSON::Field(key: "JSONNull")]
  property json_null : Int64
end

class JsonParser
  include JSON::Serializable

  @[JSON::Field(key: "JsonParser")]
  property json_parser : Int64
end

class JsonReader
  include JSON::Serializable

  @[JSON::Field(key: "JsonReader")]
  property json_reader : Int64
end

class JsonSerializer
  include JSON::Serializable

  property json_serializer : Int64
end

class JsonToken
  include JSON::Serializable

  property json_token : Int64
end

class JsonTokenType
  include JSON::Serializable

  @[JSON::Field(key: "JsonTokenType")]
  property json_token_type : Int64
end

class JsonWriter
  include JSON::Serializable

  property json_writer : Int64
end

class Lambda
  include JSON::Serializable

  property lambda : Int64
end

class Lazy
  include JSON::Serializable

  property lazy : Int64
end

class Left
  include JSON::Serializable

  property left : Int64
end

class Let
  include JSON::Serializable

  property let : Int64
end

class List
  include JSON::Serializable

  property list : Int64
end

class LocalDate
  include JSON::Serializable

  @[JSON::Field(key: "LocalDate")]
  property local_date : Int64
end

class Locale
  include JSON::Serializable

  @[JSON::Field(key: "Locale")]
  property locale : Int64
end

class Lock
  include JSON::Serializable

  property lock : Int64
end

class Long
  include JSON::Serializable

  property long : Int64
end

class LongNode
  include JSON::Serializable

  @[JSON::Field(key: "LongNode")]
  property long_node : Int64
end

class Map
  include JSON::Serializable

  property map : Int64
end

class MapEntry
  include JSON::Serializable

  @[JSON::Field(key: "MapEntry")]
  property map_entry : Int64
end

class MarshalJson
  include JSON::Serializable

  @[JSON::Field(key: "MarshalJSON")]
  property marshal_json : Int64
end

class MetadataPropertyHandling
  include JSON::Serializable

  property metadata_property_handling : Int64
end

class If
  include JSON::Serializable

  @[JSON::Field(key: "if")]
  property if_if : Int64
end

class In
  include JSON::Serializable

  @[JSON::Field(key: "in")]
  property in_in : Int64
end

class Module
  include JSON::Serializable

  @[JSON::Field(key: "module")]
  property module_module : Int64
end

class Obj4
  include JSON::Serializable

  property dummy : Int64

  property mutable : Mutable

  property mutating : Mutating

  property namespace : Namespace

  property native : Native

  property new : New

  property newtonsoft : Newtonsoft

  @[JSON::Field(key: "NO")]
  property no : No

  @[JSON::Field(key: "noSuchMethod")]
  property no_such_method : NoSuchMethod

  property noexcept : Noexcept

  property nonatomic : Nonatomic

  @[JSON::Field(key: "None")]
  property none : None

  property nonlocal : Nonlocal

  property nonmutating : Nonmutating

  property not : Not

  property not_eq : NotEq

  @[JSON::Field(key: "NSError")]
  property ns_error : NsError

  @[JSON::Field(key: "NSObject")]
  property ns_object : NsObject

  @[JSON::Field(key: "NSString")]
  property ns_string : NsString

  @[JSON::Field(key: "NULL")]
  property null : Null

  @[JSON::Field(key: "NullNode")]
  property null_node : NullNode

  property nullptr : Nullptr

  property number : NumberClass

  @[JSON::Field(key: "nil")]
  property obj4_nil : NilClass

  @[JSON::Field(key: "none")]
  property obj4_none : NoneClass

  @[JSON::Field(key: "null")]
  property obj4_null : NullClass

  @[JSON::Field(key: "of")]
  property obj4_of : Of

  @[JSON::Field(key: "out")]
  property obj4_out : Out

  @[JSON::Field(key: "private")]
  property obj4_private : Private

  @[JSON::Field(key: "protected")]
  property obj4_protected : Protected

  @[JSON::Field(key: "protocol")]
  property obj4_protocol : ProtocolClass

  property object : ObjectClass

  @[JSON::Field(key: "ObjectMapper")]
  property object_mapper : ObjectMapper

  @[JSON::Field(key: "ObjectNode")]
  property object_node : ObjectNode

  @[JSON::Field(key: "ObjectReader")]
  property object_reader : ObjectReader

  @[JSON::Field(key: "ObjectWriter")]
  property object_writer : ObjectWriter

  @[JSON::Field(key: "OffsetDateTime")]
  property offset_date_time : OffsetDateTime

  @[JSON::Field(key: "OffsetTime")]
  property offset_time : OffsetTime

  property oneway : Oneway

  property open : Open

  property operator : Operator

  property optional : Optional

  property or : Or

  property or_eq : OrEq

  property override : Override

  property package : Package

  property params : Params

  property pass : Pass

  property port : Port

  property postfix : Postfix

  property precedence : Precedence

  property prefix : Prefix

  property print : Print

  @[JSON::Field(key: "printMembers")]
  property print_members : PrintMembers

  property printf : Printf

  @[JSON::Field(key: "Protocol")]
  property protocol : Protocol

  property public : Public

  property quicktype : Quicktype

  property raise : Raise

  property range : RangeClass

  property readonly : Readonly

  property ref : Ref

  @[JSON::Field(key: "RegExp")]
  property reg_exp : RegExp

  property register : Register

  property reinterpret_cast : ReinterpretCast
end

class Mutable
  include JSON::Serializable

  property mutable : Int64
end

class Mutating
  include JSON::Serializable

  property mutating : Int64
end

class Namespace
  include JSON::Serializable

  property namespace : Int64
end

class Native
  include JSON::Serializable

  property native : Int64
end

class New
  include JSON::Serializable

  property new : Int64
end

class Newtonsoft
  include JSON::Serializable

  property newtonsoft : Int64
end

class No
  include JSON::Serializable

  @[JSON::Field(key: "NO")]
  property no : Int64
end

class NoSuchMethod
  include JSON::Serializable

  @[JSON::Field(key: "noSuchMethod")]
  property no_such_method : Int64
end

class Noexcept
  include JSON::Serializable

  property noexcept : Int64
end

class Nonatomic
  include JSON::Serializable

  property nonatomic : Int64
end

class None
  include JSON::Serializable

  @[JSON::Field(key: "None")]
  property none : Int64
end

class Nonlocal
  include JSON::Serializable

  property nonlocal : Int64
end

class Nonmutating
  include JSON::Serializable

  property nonmutating : Int64
end

class Not
  include JSON::Serializable

  property not : Int64
end

class NotEq
  include JSON::Serializable

  property not_eq : Int64
end

class NsError
  include JSON::Serializable

  @[JSON::Field(key: "NSError")]
  property ns_error : Int64
end

class NsObject
  include JSON::Serializable

  @[JSON::Field(key: "NSObject")]
  property ns_object : Int64
end

class NsString
  include JSON::Serializable

  @[JSON::Field(key: "NSString")]
  property ns_string : Int64
end

class Null
  include JSON::Serializable

  @[JSON::Field(key: "NULL")]
  property null : Int64
end

class NullNode
  include JSON::Serializable

  @[JSON::Field(key: "NullNode")]
  property null_node : Int64
end

class Nullptr
  include JSON::Serializable

  property nullptr : Int64
end

class NumberClass
  include JSON::Serializable

  property number : Int64
end

class NilClass
  include JSON::Serializable

  @[JSON::Field(key: "nil")]
  property nil_nil : Int64
end

class NoneClass
  include JSON::Serializable

  property none : Int64
end

class NullClass
  include JSON::Serializable

  property null : Int64
end

class Of
  include JSON::Serializable

  @[JSON::Field(key: "of")]
  property of_of : Int64
end

class Out
  include JSON::Serializable

  @[JSON::Field(key: "out")]
  property out_out : Int64
end

class Private
  include JSON::Serializable

  @[JSON::Field(key: "private")]
  property private_private : Int64
end

class Protected
  include JSON::Serializable

  @[JSON::Field(key: "protected")]
  property protected_protected : Int64
end

class ProtocolClass
  include JSON::Serializable

  property protocol : Int64
end

class ObjectClass
  include JSON::Serializable

  property object : Int64
end

class ObjectMapper
  include JSON::Serializable

  @[JSON::Field(key: "ObjectMapper")]
  property object_mapper : Int64
end

class ObjectNode
  include JSON::Serializable

  @[JSON::Field(key: "ObjectNode")]
  property object_node : Int64
end

class ObjectReader
  include JSON::Serializable

  @[JSON::Field(key: "ObjectReader")]
  property object_reader : Int64
end

class ObjectWriter
  include JSON::Serializable

  @[JSON::Field(key: "ObjectWriter")]
  property object_writer : Int64
end

class OffsetDateTime
  include JSON::Serializable

  @[JSON::Field(key: "OffsetDateTime")]
  property offset_date_time : Int64
end

class OffsetTime
  include JSON::Serializable

  @[JSON::Field(key: "OffsetTime")]
  property offset_time : Int64
end

class Oneway
  include JSON::Serializable

  property oneway : Int64
end

class Open
  include JSON::Serializable

  property open : Int64
end

class Operator
  include JSON::Serializable

  property operator : Int64
end

class Optional
  include JSON::Serializable

  property optional : Int64
end

class Or
  include JSON::Serializable

  property or : Int64
end

class OrEq
  include JSON::Serializable

  property or_eq : Int64
end

class Override
  include JSON::Serializable

  property override : Int64
end

class Package
  include JSON::Serializable

  property package : Int64
end

class Params
  include JSON::Serializable

  property params : Int64
end

class Pass
  include JSON::Serializable

  property pass : Int64
end

class Port
  include JSON::Serializable

  property port : Int64
end

class Postfix
  include JSON::Serializable

  property postfix : Int64
end

class Precedence
  include JSON::Serializable

  property precedence : Int64
end

class Prefix
  include JSON::Serializable

  property prefix : Int64
end

class Print
  include JSON::Serializable

  property print : Int64
end

class PrintMembers
  include JSON::Serializable

  @[JSON::Field(key: "printMembers")]
  property print_members : Int64
end

class Printf
  include JSON::Serializable

  property printf : Int64
end

class Protocol
  include JSON::Serializable

  @[JSON::Field(key: "Protocol")]
  property protocol : Int64
end

class Public
  include JSON::Serializable

  property public : Int64
end

class Quicktype
  include JSON::Serializable

  property quicktype : Int64
end

class Raise
  include JSON::Serializable

  property raise : Int64
end

class RangeClass
  include JSON::Serializable

  property range : Int64
end

class Readonly
  include JSON::Serializable

  property readonly : Int64
end

class Ref
  include JSON::Serializable

  property ref : Int64
end

class RegExp
  include JSON::Serializable

  @[JSON::Field(key: "RegExp")]
  property reg_exp : String
end

class Register
  include JSON::Serializable

  property register : Int64
end

class ReinterpretCast
  include JSON::Serializable

  property reinterpret_cast : Int64
end

class Obj5
  include JSON::Serializable

  property dummy : Int64

  @[JSON::Field(key: "KSerializer")]
  property k_serializer : KSerializer

  @[JSON::Field(key: "require")]
  property obj5_require : Require

  @[JSON::Field(key: "return")]
  property obj5_return : Return

  @[JSON::Field(key: "select")]
  property obj5_select : Select

  @[JSON::Field(key: "Self")]
  property obj5_self : Self

  @[JSON::Field(key: "sizeof")]
  property obj5_sizeof : Sizeof

  @[JSON::Field(key: "struct")]
  property obj5_struct : StructClass

  @[JSON::Field(key: "super")]
  property obj5_super : Super

  @[JSON::Field(key: "then")]
  property obj5_then : Then

  @[JSON::Field(key: "to_json")]
  property obj5_to_json : ToJson

  @[JSON::Field(key: "True")]
  property obj5_true : True

  @[JSON::Field(key: "PrimitiveKind")]
  property primitive_kind : PrimitiveKind

  @[JSON::Field(key: "self")]
  property purple_self : SelfClass

  @[JSON::Field(key: "true")]
  property purple_true : TrueClass

  property repeat : Repeat

  property required : Required

  property requires : Requires

  property restrict : Restrict

  property retain : Retain

  property rethrows : Rethrows

  property right : Right

  @[JSON::Field(key: "runtimeType")]
  property runtime_type : RuntimeType

  property s : S

  property sbyte : Sbyte

  property sealed : Sealed

  @[JSON::Field(key: "SEL")]
  property sel : Sel

  @[JSON::Field(key: "Sendable")]
  property sendable : Sendable

  @[JSON::Field(key: "SerialDescriptor")]
  property serial_descriptor : SerialDescriptor

  @[JSON::Field(key: "SerialName")]
  property serial_name : SerialName

  @[JSON::Field(key: "Serializable")]
  property serializable : Serializable

  @[JSON::Field(key: "SerializationFeature")]
  property serialization_feature : SerializationFeature

  property serialize : Serialize

  @[JSON::Field(key: "SerializerProvider")]
  property serializer_provider : SerializerProvider

  property set : SetClass

  property short : Short

  property signed : Signed

  @[JSON::Field(key: "SimpleModule")]
  property simple_module : SimpleModule

  property stackalloc : Stackalloc

  @[JSON::Field(key: "Standards")]
  property standards : Standards

  property static : Static

  property static_assert : StaticAssert

  property static_cast : StaticCast

  @[JSON::Field(key: "StdDeserializer")]
  property std_deserializer : StdDeserializer

  @[JSON::Field(key: "StdSerializer")]
  property std_serializer : StdSerializer

  property strictfp : Strictfp

  property string : StringClass

  property subscript : Subscript

  property switch : Switch

  property symbol : SymbolClass

  property synchronized : Synchronized

  property system : SystemClass

  property template : Template

  @[JSON::Field(key: "TextNode")]
  property text_node : TextNode

  property this : This

  property thread_local : ThreadLocalClass

  property throw : Throw

  property throws : Throws

  @[JSON::Field(key: "TimeOnly")]
  property time_only : TimeOnly

  @[JSON::Field(key: "TimeOnlyConverter")]
  property time_only_converter : TimeOnlyConverter

  @[JSON::Field(key: "TimeZone")]
  property time_zone : TimeZone

  property to_dict : ToDict

  @[JSON::Field(key: "toString")]
  property to_string : ToString

  property top_level : TopLevelClass

  property transient : Transient
end

class KSerializer
  include JSON::Serializable

  @[JSON::Field(key: "KSerializer")]
  property k_serializer : Int64
end

class Require
  include JSON::Serializable

  @[JSON::Field(key: "require")]
  property require_require : Int64
end

class Return
  include JSON::Serializable

  @[JSON::Field(key: "return")]
  property return_return : Int64
end

class Select
  include JSON::Serializable

  @[JSON::Field(key: "select")]
  property select_select : Int64
end

class Self
  include JSON::Serializable

  @[JSON::Field(key: "Self")]
  property self_self : Int64
end

class Sizeof
  include JSON::Serializable

  @[JSON::Field(key: "sizeof")]
  property sizeof_sizeof : Int64
end

class StructClass
  include JSON::Serializable

  @[JSON::Field(key: "struct")]
  property struct_struct : Int64
end

class Super
  include JSON::Serializable

  @[JSON::Field(key: "super")]
  property super_super : Int64
end

class Then
  include JSON::Serializable

  @[JSON::Field(key: "then")]
  property then_then : Int64
end

class ToJson
  include JSON::Serializable

  @[JSON::Field(key: "to_json")]
  property to_json_to_json : Int64
end

class True
  include JSON::Serializable

  @[JSON::Field(key: "True")]
  property true_true : Int64
end

class PrimitiveKind
  include JSON::Serializable

  @[JSON::Field(key: "PrimitiveKind")]
  property primitive_kind : Int64
end

class SelfClass
  include JSON::Serializable

  @[JSON::Field(key: "self")]
  property self_self : Int64
end

class TrueClass
  include JSON::Serializable

  @[JSON::Field(key: "true")]
  property true_true : Int64
end

class Repeat
  include JSON::Serializable

  property repeat : Int64
end

class Required
  include JSON::Serializable

  property required : Int64
end

class Requires
  include JSON::Serializable

  property requires : Int64
end

class Restrict
  include JSON::Serializable

  property restrict : Int64
end

class Retain
  include JSON::Serializable

  property retain : Int64
end

class Rethrows
  include JSON::Serializable

  property rethrows : Int64
end

class Right
  include JSON::Serializable

  property right : Int64
end

class RuntimeType
  include JSON::Serializable

  @[JSON::Field(key: "runtimeType")]
  property runtime_type : Int64
end

class S
  include JSON::Serializable

  property s : Int64
end

class Sbyte
  include JSON::Serializable

  property sbyte : Int64
end

class Sealed
  include JSON::Serializable

  property sealed : Int64
end

class Sel
  include JSON::Serializable

  @[JSON::Field(key: "SEL")]
  property sel : Int64
end

class Sendable
  include JSON::Serializable

  @[JSON::Field(key: "Sendable")]
  property sendable : Int64
end

class SerialDescriptor
  include JSON::Serializable

  @[JSON::Field(key: "SerialDescriptor")]
  property serial_descriptor : Int64
end

class SerialName
  include JSON::Serializable

  @[JSON::Field(key: "SerialName")]
  property serial_name : Int64
end

class Serializable
  include JSON::Serializable

  @[JSON::Field(key: "Serializable")]
  property serializable : Int64
end

class SerializationFeature
  include JSON::Serializable

  @[JSON::Field(key: "SerializationFeature")]
  property serialization_feature : Int64
end

class Serialize
  include JSON::Serializable

  property serialize : Int64
end

class SerializerProvider
  include JSON::Serializable

  @[JSON::Field(key: "SerializerProvider")]
  property serializer_provider : Int64
end

class SetClass
  include JSON::Serializable

  property set : Int64
end

class Short
  include JSON::Serializable

  property short : Int64
end

class Signed
  include JSON::Serializable

  property signed : Int64
end

class SimpleModule
  include JSON::Serializable

  @[JSON::Field(key: "SimpleModule")]
  property simple_module : Int64
end

class Stackalloc
  include JSON::Serializable

  property stackalloc : Int64
end

class Standards
  include JSON::Serializable

  @[JSON::Field(key: "Standards")]
  property standards : Int64
end

class Static
  include JSON::Serializable

  property static : Int64
end

class StaticAssert
  include JSON::Serializable

  property static_assert : Int64
end

class StaticCast
  include JSON::Serializable

  property static_cast : Int64
end

class StdDeserializer
  include JSON::Serializable

  @[JSON::Field(key: "StdDeserializer")]
  property std_deserializer : Int64
end

class StdSerializer
  include JSON::Serializable

  @[JSON::Field(key: "StdSerializer")]
  property std_serializer : Int64
end

class Strictfp
  include JSON::Serializable

  property strictfp : Int64
end

class StringClass
  include JSON::Serializable

  property string : Int64
end

class Subscript
  include JSON::Serializable

  property subscript : Int64
end

class Switch
  include JSON::Serializable

  property switch : Int64
end

class SymbolClass
  include JSON::Serializable

  property symbol : Int64
end

class Synchronized
  include JSON::Serializable

  property synchronized : Int64
end

class SystemClass
  include JSON::Serializable

  property system : Int64
end

class Template
  include JSON::Serializable

  property template : Int64
end

class TextNode
  include JSON::Serializable

  @[JSON::Field(key: "TextNode")]
  property text_node : Int64
end

class This
  include JSON::Serializable

  property this : Int64
end

class ThreadLocalClass
  include JSON::Serializable

  property thread_local : Int64
end

class Throw
  include JSON::Serializable

  property throw : Int64
end

class Throws
  include JSON::Serializable

  property throws : Int64
end

class TimeOnly
  include JSON::Serializable

  @[JSON::Field(key: "TimeOnly")]
  property time_only : Int64
end

class TimeOnlyConverter
  include JSON::Serializable

  @[JSON::Field(key: "TimeOnlyConverter")]
  property time_only_converter : Int64
end

class TimeZone
  include JSON::Serializable

  @[JSON::Field(key: "TimeZone")]
  property time_zone : Int64
end

class ToDict
  include JSON::Serializable

  property to_dict : Int64
end

class ToString
  include JSON::Serializable

  @[JSON::Field(key: "toString")]
  property to_string : Int64
end

class TopLevelClass
  include JSON::Serializable

  property top_level : Int64
end

class Transient
  include JSON::Serializable

  property transient : Int64
end

class Obj6
  include JSON::Serializable

  property dummy : Int64

  @[JSON::Field(key: "Type")]
  property obj6_type : Type

  @[JSON::Field(key: "typeof")]
  property obj6_typeof : Typeof

  @[JSON::Field(key: "union")]
  property obj6_union : UnionClass

  @[JSON::Field(key: "while")]
  property obj6_while : While

  @[JSON::Field(key: "with")]
  property obj6_with : With

  @[JSON::Field(key: "yield")]
  property obj6_yield : Yield

  @[JSON::Field(key: "type")]
  property purple_type : TypeClass

  property try : Try

  property typealias : Typealias

  property typedef : Typedef

  property typeid : Typeid

  property typename : Typename

  property uint : Uint

  property ulong : Ulong

  property unchecked : Unchecked

  property undefined : Undefined

  @[JSON::Field(key: "UnmarshalJSON")]
  property unmarshal_json : UnmarshalJson

  property unowned : Unowned

  property unsafe : Unsafe

  property unsigned : Unsigned

  @[JSON::Field(key: "UseSerializers")]
  property use_serializers : UseSerializers

  property ushort : Ushort

  property using : Using

  @[JSON::Field(key: "Utf8JsonReader")]
  property utf8_json_reader : Utf8JsonReader

  @[JSON::Field(key: "Utf8JsonWriter")]
  property utf8_json_writer : Utf8JsonWriter

  @[JSON::Field(key: "UUID")]
  property uuid : Uuid

  property var : Var

  property virtual : Virtual

  property void : VoidClass

  property volatile : Volatile

  property wchar_t : WcharT

  property weak : Weak

  property where : Where

  @[JSON::Field(key: "willSet")]
  property will_set : WillSet

  property xor : Xor

  property xor_eq : XorEq

  @[JSON::Field(key: "YES")]
  property yes : Yes
end

class Type
  include JSON::Serializable

  @[JSON::Field(key: "Type")]
  property type_type : Int64
end

class Typeof
  include JSON::Serializable

  @[JSON::Field(key: "typeof")]
  property typeof_typeof : Int64
end

class UnionClass
  include JSON::Serializable

  @[JSON::Field(key: "union")]
  property union_union : Int64
end

class While
  include JSON::Serializable

  @[JSON::Field(key: "while")]
  property while_while : Int64
end

class With
  include JSON::Serializable

  @[JSON::Field(key: "with")]
  property with_with : Int64
end

class Yield
  include JSON::Serializable

  @[JSON::Field(key: "yield")]
  property yield_yield : Int64
end

class TypeClass
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property type_type : Int64
end

class Try
  include JSON::Serializable

  property try : Int64
end

class Typealias
  include JSON::Serializable

  property typealias : Int64
end

class Typedef
  include JSON::Serializable

  property typedef : Int64
end

class Typeid
  include JSON::Serializable

  property typeid : Int64
end

class Typename
  include JSON::Serializable

  property typename : Int64
end

class Uint
  include JSON::Serializable

  property uint : Int64
end

class Ulong
  include JSON::Serializable

  property ulong : Int64
end

class Unchecked
  include JSON::Serializable

  property unchecked : Int64
end

class Undefined
  include JSON::Serializable

  property undefined : Int64
end

class UnmarshalJson
  include JSON::Serializable

  @[JSON::Field(key: "UnmarshalJSON")]
  property unmarshal_json : Int64
end

class Unowned
  include JSON::Serializable

  property unowned : Int64
end

class Unsafe
  include JSON::Serializable

  property unsafe : Int64
end

class Unsigned
  include JSON::Serializable

  property unsigned : Int64
end

class UseSerializers
  include JSON::Serializable

  @[JSON::Field(key: "UseSerializers")]
  property use_serializers : Int64
end

class Ushort
  include JSON::Serializable

  property ushort : Int64
end

class Using
  include JSON::Serializable

  property using : Int64
end

class Utf8JsonReader
  include JSON::Serializable

  @[JSON::Field(key: "Utf8JsonReader")]
  property utf8_json_reader : Int64
end

class Utf8JsonWriter
  include JSON::Serializable

  @[JSON::Field(key: "Utf8JsonWriter")]
  property utf8_json_writer : Int64
end

class Uuid
  include JSON::Serializable

  @[JSON::Field(key: "UUID")]
  property uuid : Int64
end

class Var
  include JSON::Serializable

  property var : Int64
end

class Virtual
  include JSON::Serializable

  property virtual : Int64
end

class VoidClass
  include JSON::Serializable

  property void : Int64
end

class Volatile
  include JSON::Serializable

  property volatile : Int64
end

class WcharT
  include JSON::Serializable

  property wchar_t : Int64
end

class Weak
  include JSON::Serializable

  property weak : Int64
end

class Where
  include JSON::Serializable

  property where : Int64
end

class WillSet
  include JSON::Serializable

  @[JSON::Field(key: "willSet")]
  property will_set : Int64
end

class Xor
  include JSON::Serializable

  property xor : Int64
end

class XorEq
  include JSON::Serializable

  property xor_eq : Int64
end

class Yes
  include JSON::Serializable

  @[JSON::Field(key: "YES")]
  property yes : Int64
end
