package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val `enum` : Option[EnumEnum] = None
) derives Encoder.AsObject, Decoder

enum EnumEnum : 
    case Empty
    case Bool
    case Complex
    case Imaginery
    case Abstract
    case Alignas
    case Alignof
    case And
    case AndEq
    case EnumAny
    case PurpleAny
    case ArrayNode
    case EnumArray
    case As
    case ASM
    case Assert
    case Associatedtype
    case Associativity
    case Async
    case Atomic
    case AtomicCancel
    case AtomicCommit
    case AtomicNoexcept
    case Auto
    case Await
    case Base
    case Bitand
    case Bitor
    case EnumBOOL
    case EnumBool
    case EnumBoolean
    case BooleanNode
    case Break
    case Bycopy
    case Byref
    case EnumByte
    case Calendar
    case Case
    case Catch
    case Chan
    case Char
    case Char16T
    case Char32T
    case Checked
    case Class
    case EnumClass
    case Clone
    case CoAwait
    case CoReturn
    case CoYield
    case Codable
    case CodingKey
    case CodingKeys
    case Compl
    case Concept
    case Console
    case Const
    case ConstCast
    case Constexpr
    case Constructor
    case Continue
    case Convenience
    case Convert
    case Converter
    case CultureInfo
    case Date
    case DateParseHandling
    case DateFormatter
    case DateOnly
    case DateOnlyConverter
    case DateTime
    case DateTimeStyles
    case Debugger
    case Decimal
    case Declare
    case DeserializationFeature
    case Decltype
    case DecodeString
    case Decoder
    case DecodingError
    case Def
    case Default
    case Defer
    case Deinit
    case Del
    case Delegate
    case Delete
    case Dict
    case Dictionary
    case DidSet
    case Do
    case EnumDouble
    case DoubleNode
    case Dynamic
    case DynamicCast
    case Elif
    case Else
    case EncodeQuickType
    case Encoder
    case EnumEnum
    case EnumValues
    case Equatable
    case EqualityContract
    case Event
    case Except
    case Exception
    case Explicit
    case Export
    case Exposing
    case Extends
    case Extension
    case Extern
    case Fallthrough
    case False
    case EnumFalse
    case Fileprivate
    case Final
    case Finally
    case Fixed
    case EnumFloat
    case For
    case Foreach
    case FormatException
    case Friend
    case From
    case FromDict
    case FromJSON
    case Func
    case Function
    case Get
    case Global
    case Go
    case Goto
    case Guard
    case Hashable
    case HashCode
    case Hasher
    case HasOwnProperty
    case ID
    case If
    case Imp
    case Implements
    case Implicit
    case Import
    case In
    case Indirect
    case Infix
    case Init
    case Inline
    case Inout
    case Instanceof
    case EnumInt
    case IntNode
    case Interface
    case Internal
    case ISODateTimeOffsetConverter
    case Iterable
    case Is
    case Jdec
    case Jenc
    case Jpipe
    case JSON
    case JSONConverter
    case JSONSerializer
    case JSONToken
    case JSONWriter
    case JSONAny
    case JSONCodingKey
    case JSONDecoder
    case JSONEncoder
    case JSONException
    case JSONGenerator
    case JSONNode
    case JSONNull
    case JSONParser
    case JSONReader
    case JSONTokenType
    case Lambda
    case Lazy
    case Left
    case Let
    case EnumList
    case LocalDate
    case LongNode
    case Locale
    case Lock
    case EnumLong
    case EnumMap
    case MarshalJSON
    case MapEntry
    case MetadataPropertyHandling
    case Module
    case Mutable
    case Mutating
    case Namespace
    case Native
    case New
    case Newtonsoft
    case Nil
    case NullNode
    case No
    case Noexcept
    case Nonatomic
    case None
    case EnumNone
    case Nonlocal
    case Nonmutating
    case NSObject
    case NoSuchMethod
    case Not
    case NotEq
    case NSError
    case NSString
    case Null
    case EnumNull
    case Nullptr
    case Number
    case Object
    case OffsetDateTime
    case OffsetTime
    case ObjectNode
    case ObjectMapper
    case ObjectReader
    case ObjectWriter
    case Of
    case Oneway
    case Open
    case Operator
    case Optional
    case Or
    case OrEq
    case Out
    case Override
    case Package
    case Params
    case Pass
    case Port
    case Postfix
    case Precedence
    case Prefix
    case Print
    case Printf
    case PrintMembers
    case Private
    case Protected
    case Protocol
    case EnumProtocol
    case Public
    case Quicktype
    case Raise
    case Range
    case Readonly
    case Ref
    case RegExp
    case Register
    case ReinterpretCast
    case Repeat
    case Require
    case Required
    case Requires
    case Restrict
    case Retain
    case Rethrows
    case Return
    case Right
    case RuntimeType
    case S
    case Sbyte
    case Sealed
    case Sel
    case Select
    case Self
    case Serializable
    case EnumSelf
    case Sendable
    case Serialize
    case SerialName
    case KSerializer
    case PrimitiveKind
    case SerialDescriptor
    case SerializationFeature
    case SerializerProvider
    case Set
    case EnumShort
    case Signed
    case SimpleModule
    case Sizeof
    case Stackalloc
    case Standards
    case Static
    case StaticAssert
    case StaticCast
    case StdDeserializer
    case StdSerializer
    case Strictfp
    case EnumString
    case Struct
    case Subscript
    case Super
    case Switch
    case Symbol
    case Synchronized
    case EnumSystem
    case Template
    case Then
    case This
    case TextNode
    case ThreadLocal
    case Throw
    case Throws
    case TimeOnly
    case TimeOnlyConverter
    case TimeZone
    case ToJSON
    case TopLevel
    case ToString
    case ToDict
    case Transient
    case True
    case EnumTrue
    case Try
    case Type
    case EnumType
    case Typealias
    case Typedef
    case Typeid
    case Typename
    case Typeof
    case Uint
    case Ulong
    case Unchecked
    case Undefined
    case Union
    case UnmarshalJSON
    case UseSerializers
    case Unowned
    case Unsafe
    case Unsigned
    case Ushort
    case Using
    case Utf8JSONReader
    case Utf8JSONWriter
    case UUID
    case Var
    case Virtual
    case Void
    case Volatile
    case WcharT
    case Weak
    case Where
    case While
    case WillSet
    case With
    case Xor
    case XorEq
    case Yes
    case Yield
    case Dummy

given Decoder[EnumEnum] = Decoder.decodeString.emap {
    case "_" => scala.Right(EnumEnum.Empty)
    case "_Bool" => scala.Right(EnumEnum.Bool)
    case "_Complex" => scala.Right(EnumEnum.Complex)
    case "_Imaginery" => scala.Right(EnumEnum.Imaginery)
    case "abstract" => scala.Right(EnumEnum.Abstract)
    case "alignas" => scala.Right(EnumEnum.Alignas)
    case "alignof" => scala.Right(EnumEnum.Alignof)
    case "and" => scala.Right(EnumEnum.And)
    case "and_eq" => scala.Right(EnumEnum.AndEq)
    case "any" => scala.Right(EnumEnum.EnumAny)
    case "Any" => scala.Right(EnumEnum.PurpleAny)
    case "ArrayNode" => scala.Right(EnumEnum.ArrayNode)
    case "array" => scala.Right(EnumEnum.EnumArray)
    case "as" => scala.Right(EnumEnum.As)
    case "asm" => scala.Right(EnumEnum.ASM)
    case "assert" => scala.Right(EnumEnum.Assert)
    case "associatedtype" => scala.Right(EnumEnum.Associatedtype)
    case "associativity" => scala.Right(EnumEnum.Associativity)
    case "async" => scala.Right(EnumEnum.Async)
    case "atomic" => scala.Right(EnumEnum.Atomic)
    case "atomic_cancel" => scala.Right(EnumEnum.AtomicCancel)
    case "atomic_commit" => scala.Right(EnumEnum.AtomicCommit)
    case "atomic_noexcept" => scala.Right(EnumEnum.AtomicNoexcept)
    case "auto" => scala.Right(EnumEnum.Auto)
    case "await" => scala.Right(EnumEnum.Await)
    case "base" => scala.Right(EnumEnum.Base)
    case "bitand" => scala.Right(EnumEnum.Bitand)
    case "bitor" => scala.Right(EnumEnum.Bitor)
    case "BOOL" => scala.Right(EnumEnum.EnumBOOL)
    case "bool" => scala.Right(EnumEnum.EnumBool)
    case "boolean" => scala.Right(EnumEnum.EnumBoolean)
    case "BooleanNode" => scala.Right(EnumEnum.BooleanNode)
    case "break" => scala.Right(EnumEnum.Break)
    case "bycopy" => scala.Right(EnumEnum.Bycopy)
    case "byref" => scala.Right(EnumEnum.Byref)
    case "byte" => scala.Right(EnumEnum.EnumByte)
    case "Calendar" => scala.Right(EnumEnum.Calendar)
    case "case" => scala.Right(EnumEnum.Case)
    case "catch" => scala.Right(EnumEnum.Catch)
    case "chan" => scala.Right(EnumEnum.Chan)
    case "char" => scala.Right(EnumEnum.Char)
    case "char16_t" => scala.Right(EnumEnum.Char16T)
    case "char32_t" => scala.Right(EnumEnum.Char32T)
    case "checked" => scala.Right(EnumEnum.Checked)
    case "class" => scala.Right(EnumEnum.Class)
    case "Class" => scala.Right(EnumEnum.EnumClass)
    case "clone" => scala.Right(EnumEnum.Clone)
    case "co_await" => scala.Right(EnumEnum.CoAwait)
    case "co_return" => scala.Right(EnumEnum.CoReturn)
    case "co_yield" => scala.Right(EnumEnum.CoYield)
    case "Codable" => scala.Right(EnumEnum.Codable)
    case "CodingKey" => scala.Right(EnumEnum.CodingKey)
    case "CodingKeys" => scala.Right(EnumEnum.CodingKeys)
    case "compl" => scala.Right(EnumEnum.Compl)
    case "concept" => scala.Right(EnumEnum.Concept)
    case "console" => scala.Right(EnumEnum.Console)
    case "const" => scala.Right(EnumEnum.Const)
    case "const_cast" => scala.Right(EnumEnum.ConstCast)
    case "constexpr" => scala.Right(EnumEnum.Constexpr)
    case "constructor" => scala.Right(EnumEnum.Constructor)
    case "continue" => scala.Right(EnumEnum.Continue)
    case "convenience" => scala.Right(EnumEnum.Convenience)
    case "convert" => scala.Right(EnumEnum.Convert)
    case "converter" => scala.Right(EnumEnum.Converter)
    case "CultureInfo" => scala.Right(EnumEnum.CultureInfo)
    case "date" => scala.Right(EnumEnum.Date)
    case "date_parse_handling" => scala.Right(EnumEnum.DateParseHandling)
    case "DateFormatter" => scala.Right(EnumEnum.DateFormatter)
    case "DateOnly" => scala.Right(EnumEnum.DateOnly)
    case "DateOnlyConverter" => scala.Right(EnumEnum.DateOnlyConverter)
    case "DateTime" => scala.Right(EnumEnum.DateTime)
    case "DateTimeStyles" => scala.Right(EnumEnum.DateTimeStyles)
    case "debugger" => scala.Right(EnumEnum.Debugger)
    case "decimal" => scala.Right(EnumEnum.Decimal)
    case "declare" => scala.Right(EnumEnum.Declare)
    case "DeserializationFeature" => scala.Right(EnumEnum.DeserializationFeature)
    case "decltype" => scala.Right(EnumEnum.Decltype)
    case "decode_string" => scala.Right(EnumEnum.DecodeString)
    case "Decoder" => scala.Right(EnumEnum.Decoder)
    case "DecodingError" => scala.Right(EnumEnum.DecodingError)
    case "def" => scala.Right(EnumEnum.Def)
    case "default" => scala.Right(EnumEnum.Default)
    case "defer" => scala.Right(EnumEnum.Defer)
    case "deinit" => scala.Right(EnumEnum.Deinit)
    case "del" => scala.Right(EnumEnum.Del)
    case "delegate" => scala.Right(EnumEnum.Delegate)
    case "delete" => scala.Right(EnumEnum.Delete)
    case "dict" => scala.Right(EnumEnum.Dict)
    case "dictionary" => scala.Right(EnumEnum.Dictionary)
    case "didSet" => scala.Right(EnumEnum.DidSet)
    case "do" => scala.Right(EnumEnum.Do)
    case "double" => scala.Right(EnumEnum.EnumDouble)
    case "DoubleNode" => scala.Right(EnumEnum.DoubleNode)
    case "dynamic" => scala.Right(EnumEnum.Dynamic)
    case "dynamic_cast" => scala.Right(EnumEnum.DynamicCast)
    case "elif" => scala.Right(EnumEnum.Elif)
    case "else" => scala.Right(EnumEnum.Else)
    case "encode_quick_type" => scala.Right(EnumEnum.EncodeQuickType)
    case "Encoder" => scala.Right(EnumEnum.Encoder)
    case "enum" => scala.Right(EnumEnum.EnumEnum)
    case "EnumValues" => scala.Right(EnumEnum.EnumValues)
    case "Equatable" => scala.Right(EnumEnum.Equatable)
    case "equalityContract" => scala.Right(EnumEnum.EqualityContract)
    case "event" => scala.Right(EnumEnum.Event)
    case "except" => scala.Right(EnumEnum.Except)
    case "exception" => scala.Right(EnumEnum.Exception)
    case "explicit" => scala.Right(EnumEnum.Explicit)
    case "export" => scala.Right(EnumEnum.Export)
    case "exposing" => scala.Right(EnumEnum.Exposing)
    case "extends" => scala.Right(EnumEnum.Extends)
    case "extension" => scala.Right(EnumEnum.Extension)
    case "extern" => scala.Right(EnumEnum.Extern)
    case "fallthrough" => scala.Right(EnumEnum.Fallthrough)
    case "false" => scala.Right(EnumEnum.False)
    case "False" => scala.Right(EnumEnum.EnumFalse)
    case "fileprivate" => scala.Right(EnumEnum.Fileprivate)
    case "final" => scala.Right(EnumEnum.Final)
    case "finally" => scala.Right(EnumEnum.Finally)
    case "fixed" => scala.Right(EnumEnum.Fixed)
    case "float" => scala.Right(EnumEnum.EnumFloat)
    case "for" => scala.Right(EnumEnum.For)
    case "foreach" => scala.Right(EnumEnum.Foreach)
    case "FormatException" => scala.Right(EnumEnum.FormatException)
    case "friend" => scala.Right(EnumEnum.Friend)
    case "from" => scala.Right(EnumEnum.From)
    case "from_dict" => scala.Right(EnumEnum.FromDict)
    case "from_json" => scala.Right(EnumEnum.FromJSON)
    case "func" => scala.Right(EnumEnum.Func)
    case "function" => scala.Right(EnumEnum.Function)
    case "get" => scala.Right(EnumEnum.Get)
    case "global" => scala.Right(EnumEnum.Global)
    case "go" => scala.Right(EnumEnum.Go)
    case "goto" => scala.Right(EnumEnum.Goto)
    case "guard" => scala.Right(EnumEnum.Guard)
    case "Hashable" => scala.Right(EnumEnum.Hashable)
    case "hashCode" => scala.Right(EnumEnum.HashCode)
    case "Hasher" => scala.Right(EnumEnum.Hasher)
    case "hasOwnProperty" => scala.Right(EnumEnum.HasOwnProperty)
    case "id" => scala.Right(EnumEnum.ID)
    case "if" => scala.Right(EnumEnum.If)
    case "IMP" => scala.Right(EnumEnum.Imp)
    case "implements" => scala.Right(EnumEnum.Implements)
    case "implicit" => scala.Right(EnumEnum.Implicit)
    case "import" => scala.Right(EnumEnum.Import)
    case "in" => scala.Right(EnumEnum.In)
    case "indirect" => scala.Right(EnumEnum.Indirect)
    case "infix" => scala.Right(EnumEnum.Infix)
    case "init" => scala.Right(EnumEnum.Init)
    case "inline" => scala.Right(EnumEnum.Inline)
    case "inout" => scala.Right(EnumEnum.Inout)
    case "instanceof" => scala.Right(EnumEnum.Instanceof)
    case "int" => scala.Right(EnumEnum.EnumInt)
    case "IntNode" => scala.Right(EnumEnum.IntNode)
    case "interface" => scala.Right(EnumEnum.Interface)
    case "internal" => scala.Right(EnumEnum.Internal)
    case "IsoDateTimeOffsetConverter" => scala.Right(EnumEnum.ISODateTimeOffsetConverter)
    case "iterable" => scala.Right(EnumEnum.Iterable)
    case "is" => scala.Right(EnumEnum.Is)
    case "jdec" => scala.Right(EnumEnum.Jdec)
    case "jenc" => scala.Right(EnumEnum.Jenc)
    case "jpipe" => scala.Right(EnumEnum.Jpipe)
    case "json" => scala.Right(EnumEnum.JSON)
    case "json_converter" => scala.Right(EnumEnum.JSONConverter)
    case "json_serializer" => scala.Right(EnumEnum.JSONSerializer)
    case "json_token" => scala.Right(EnumEnum.JSONToken)
    case "json_writer" => scala.Right(EnumEnum.JSONWriter)
    case "JSONAny" => scala.Right(EnumEnum.JSONAny)
    case "JSONCodingKey" => scala.Right(EnumEnum.JSONCodingKey)
    case "JSONDecoder" => scala.Right(EnumEnum.JSONDecoder)
    case "JSONEncoder" => scala.Right(EnumEnum.JSONEncoder)
    case "JsonException" => scala.Right(EnumEnum.JSONException)
    case "JsonGenerator" => scala.Right(EnumEnum.JSONGenerator)
    case "JsonNode" => scala.Right(EnumEnum.JSONNode)
    case "JSONNull" => scala.Right(EnumEnum.JSONNull)
    case "JsonParser" => scala.Right(EnumEnum.JSONParser)
    case "JsonReader" => scala.Right(EnumEnum.JSONReader)
    case "JsonTokenType" => scala.Right(EnumEnum.JSONTokenType)
    case "lambda" => scala.Right(EnumEnum.Lambda)
    case "lazy" => scala.Right(EnumEnum.Lazy)
    case "left" => scala.Right(EnumEnum.Left)
    case "let" => scala.Right(EnumEnum.Let)
    case "list" => scala.Right(EnumEnum.EnumList)
    case "LocalDate" => scala.Right(EnumEnum.LocalDate)
    case "LongNode" => scala.Right(EnumEnum.LongNode)
    case "Locale" => scala.Right(EnumEnum.Locale)
    case "lock" => scala.Right(EnumEnum.Lock)
    case "long" => scala.Right(EnumEnum.EnumLong)
    case "map" => scala.Right(EnumEnum.EnumMap)
    case "MarshalJSON" => scala.Right(EnumEnum.MarshalJSON)
    case "MapEntry" => scala.Right(EnumEnum.MapEntry)
    case "metadata_property_handling" => scala.Right(EnumEnum.MetadataPropertyHandling)
    case "module" => scala.Right(EnumEnum.Module)
    case "mutable" => scala.Right(EnumEnum.Mutable)
    case "mutating" => scala.Right(EnumEnum.Mutating)
    case "namespace" => scala.Right(EnumEnum.Namespace)
    case "native" => scala.Right(EnumEnum.Native)
    case "new" => scala.Right(EnumEnum.New)
    case "newtonsoft" => scala.Right(EnumEnum.Newtonsoft)
    case "nil" => scala.Right(EnumEnum.Nil)
    case "NullNode" => scala.Right(EnumEnum.NullNode)
    case "NO" => scala.Right(EnumEnum.No)
    case "noexcept" => scala.Right(EnumEnum.Noexcept)
    case "nonatomic" => scala.Right(EnumEnum.Nonatomic)
    case "none" => scala.Right(EnumEnum.None)
    case "None" => scala.Right(EnumEnum.EnumNone)
    case "nonlocal" => scala.Right(EnumEnum.Nonlocal)
    case "nonmutating" => scala.Right(EnumEnum.Nonmutating)
    case "NSObject" => scala.Right(EnumEnum.NSObject)
    case "noSuchMethod" => scala.Right(EnumEnum.NoSuchMethod)
    case "not" => scala.Right(EnumEnum.Not)
    case "not_eq" => scala.Right(EnumEnum.NotEq)
    case "NSError" => scala.Right(EnumEnum.NSError)
    case "NSString" => scala.Right(EnumEnum.NSString)
    case "NULL" => scala.Right(EnumEnum.Null)
    case "null" => scala.Right(EnumEnum.EnumNull)
    case "nullptr" => scala.Right(EnumEnum.Nullptr)
    case "number" => scala.Right(EnumEnum.Number)
    case "object" => scala.Right(EnumEnum.Object)
    case "OffsetDateTime" => scala.Right(EnumEnum.OffsetDateTime)
    case "OffsetTime" => scala.Right(EnumEnum.OffsetTime)
    case "ObjectNode" => scala.Right(EnumEnum.ObjectNode)
    case "ObjectMapper" => scala.Right(EnumEnum.ObjectMapper)
    case "ObjectReader" => scala.Right(EnumEnum.ObjectReader)
    case "ObjectWriter" => scala.Right(EnumEnum.ObjectWriter)
    case "of" => scala.Right(EnumEnum.Of)
    case "oneway" => scala.Right(EnumEnum.Oneway)
    case "open" => scala.Right(EnumEnum.Open)
    case "operator" => scala.Right(EnumEnum.Operator)
    case "optional" => scala.Right(EnumEnum.Optional)
    case "or" => scala.Right(EnumEnum.Or)
    case "or_eq" => scala.Right(EnumEnum.OrEq)
    case "out" => scala.Right(EnumEnum.Out)
    case "override" => scala.Right(EnumEnum.Override)
    case "package" => scala.Right(EnumEnum.Package)
    case "params" => scala.Right(EnumEnum.Params)
    case "pass" => scala.Right(EnumEnum.Pass)
    case "port" => scala.Right(EnumEnum.Port)
    case "postfix" => scala.Right(EnumEnum.Postfix)
    case "precedence" => scala.Right(EnumEnum.Precedence)
    case "prefix" => scala.Right(EnumEnum.Prefix)
    case "print" => scala.Right(EnumEnum.Print)
    case "printf" => scala.Right(EnumEnum.Printf)
    case "printMembers" => scala.Right(EnumEnum.PrintMembers)
    case "private" => scala.Right(EnumEnum.Private)
    case "protected" => scala.Right(EnumEnum.Protected)
    case "Protocol" => scala.Right(EnumEnum.Protocol)
    case "protocol" => scala.Right(EnumEnum.EnumProtocol)
    case "public" => scala.Right(EnumEnum.Public)
    case "quicktype" => scala.Right(EnumEnum.Quicktype)
    case "raise" => scala.Right(EnumEnum.Raise)
    case "range" => scala.Right(EnumEnum.Range)
    case "readonly" => scala.Right(EnumEnum.Readonly)
    case "ref" => scala.Right(EnumEnum.Ref)
    case "RegExp" => scala.Right(EnumEnum.RegExp)
    case "register" => scala.Right(EnumEnum.Register)
    case "reinterpret_cast" => scala.Right(EnumEnum.ReinterpretCast)
    case "repeat" => scala.Right(EnumEnum.Repeat)
    case "require" => scala.Right(EnumEnum.Require)
    case "required" => scala.Right(EnumEnum.Required)
    case "requires" => scala.Right(EnumEnum.Requires)
    case "restrict" => scala.Right(EnumEnum.Restrict)
    case "retain" => scala.Right(EnumEnum.Retain)
    case "rethrows" => scala.Right(EnumEnum.Rethrows)
    case "return" => scala.Right(EnumEnum.Return)
    case "right" => scala.Right(EnumEnum.Right)
    case "runtimeType" => scala.Right(EnumEnum.RuntimeType)
    case "s" => scala.Right(EnumEnum.S)
    case "sbyte" => scala.Right(EnumEnum.Sbyte)
    case "sealed" => scala.Right(EnumEnum.Sealed)
    case "SEL" => scala.Right(EnumEnum.Sel)
    case "select" => scala.Right(EnumEnum.Select)
    case "Self" => scala.Right(EnumEnum.Self)
    case "Serializable" => scala.Right(EnumEnum.Serializable)
    case "self" => scala.Right(EnumEnum.EnumSelf)
    case "Sendable" => scala.Right(EnumEnum.Sendable)
    case "serialize" => scala.Right(EnumEnum.Serialize)
    case "SerialName" => scala.Right(EnumEnum.SerialName)
    case "KSerializer" => scala.Right(EnumEnum.KSerializer)
    case "PrimitiveKind" => scala.Right(EnumEnum.PrimitiveKind)
    case "SerialDescriptor" => scala.Right(EnumEnum.SerialDescriptor)
    case "SerializationFeature" => scala.Right(EnumEnum.SerializationFeature)
    case "SerializerProvider" => scala.Right(EnumEnum.SerializerProvider)
    case "set" => scala.Right(EnumEnum.Set)
    case "short" => scala.Right(EnumEnum.EnumShort)
    case "signed" => scala.Right(EnumEnum.Signed)
    case "SimpleModule" => scala.Right(EnumEnum.SimpleModule)
    case "sizeof" => scala.Right(EnumEnum.Sizeof)
    case "stackalloc" => scala.Right(EnumEnum.Stackalloc)
    case "Standards" => scala.Right(EnumEnum.Standards)
    case "static" => scala.Right(EnumEnum.Static)
    case "static_assert" => scala.Right(EnumEnum.StaticAssert)
    case "static_cast" => scala.Right(EnumEnum.StaticCast)
    case "StdDeserializer" => scala.Right(EnumEnum.StdDeserializer)
    case "StdSerializer" => scala.Right(EnumEnum.StdSerializer)
    case "strictfp" => scala.Right(EnumEnum.Strictfp)
    case "string" => scala.Right(EnumEnum.EnumString)
    case "struct" => scala.Right(EnumEnum.Struct)
    case "subscript" => scala.Right(EnumEnum.Subscript)
    case "super" => scala.Right(EnumEnum.Super)
    case "switch" => scala.Right(EnumEnum.Switch)
    case "symbol" => scala.Right(EnumEnum.Symbol)
    case "synchronized" => scala.Right(EnumEnum.Synchronized)
    case "system" => scala.Right(EnumEnum.EnumSystem)
    case "template" => scala.Right(EnumEnum.Template)
    case "then" => scala.Right(EnumEnum.Then)
    case "this" => scala.Right(EnumEnum.This)
    case "TextNode" => scala.Right(EnumEnum.TextNode)
    case "thread_local" => scala.Right(EnumEnum.ThreadLocal)
    case "throw" => scala.Right(EnumEnum.Throw)
    case "throws" => scala.Right(EnumEnum.Throws)
    case "TimeOnly" => scala.Right(EnumEnum.TimeOnly)
    case "TimeOnlyConverter" => scala.Right(EnumEnum.TimeOnlyConverter)
    case "TimeZone" => scala.Right(EnumEnum.TimeZone)
    case "to_json" => scala.Right(EnumEnum.ToJSON)
    case "top_level" => scala.Right(EnumEnum.TopLevel)
    case "toString" => scala.Right(EnumEnum.ToString)
    case "to_dict" => scala.Right(EnumEnum.ToDict)
    case "transient" => scala.Right(EnumEnum.Transient)
    case "True" => scala.Right(EnumEnum.True)
    case "true" => scala.Right(EnumEnum.EnumTrue)
    case "try" => scala.Right(EnumEnum.Try)
    case "Type" => scala.Right(EnumEnum.Type)
    case "type" => scala.Right(EnumEnum.EnumType)
    case "typealias" => scala.Right(EnumEnum.Typealias)
    case "typedef" => scala.Right(EnumEnum.Typedef)
    case "typeid" => scala.Right(EnumEnum.Typeid)
    case "typename" => scala.Right(EnumEnum.Typename)
    case "typeof" => scala.Right(EnumEnum.Typeof)
    case "uint" => scala.Right(EnumEnum.Uint)
    case "ulong" => scala.Right(EnumEnum.Ulong)
    case "unchecked" => scala.Right(EnumEnum.Unchecked)
    case "undefined" => scala.Right(EnumEnum.Undefined)
    case "union" => scala.Right(EnumEnum.Union)
    case "UnmarshalJSON" => scala.Right(EnumEnum.UnmarshalJSON)
    case "UseSerializers" => scala.Right(EnumEnum.UseSerializers)
    case "unowned" => scala.Right(EnumEnum.Unowned)
    case "unsafe" => scala.Right(EnumEnum.Unsafe)
    case "unsigned" => scala.Right(EnumEnum.Unsigned)
    case "ushort" => scala.Right(EnumEnum.Ushort)
    case "using" => scala.Right(EnumEnum.Using)
    case "Utf8JsonReader" => scala.Right(EnumEnum.Utf8JSONReader)
    case "Utf8JsonWriter" => scala.Right(EnumEnum.Utf8JSONWriter)
    case "UUID" => scala.Right(EnumEnum.UUID)
    case "var" => scala.Right(EnumEnum.Var)
    case "virtual" => scala.Right(EnumEnum.Virtual)
    case "void" => scala.Right(EnumEnum.Void)
    case "volatile" => scala.Right(EnumEnum.Volatile)
    case "wchar_t" => scala.Right(EnumEnum.WcharT)
    case "weak" => scala.Right(EnumEnum.Weak)
    case "where" => scala.Right(EnumEnum.Where)
    case "while" => scala.Right(EnumEnum.While)
    case "willSet" => scala.Right(EnumEnum.WillSet)
    case "with" => scala.Right(EnumEnum.With)
    case "xor" => scala.Right(EnumEnum.Xor)
    case "xor_eq" => scala.Right(EnumEnum.XorEq)
    case "YES" => scala.Right(EnumEnum.Yes)
    case "yield" => scala.Right(EnumEnum.Yield)
    case "dummy" => scala.Right(EnumEnum.Dummy)
    case other => scala.Left("invalid EnumEnum: " + other)
}
given Encoder[EnumEnum] = Encoder.encodeString.contramap {
    case EnumEnum.Empty => "_"
    case EnumEnum.Bool => "_Bool"
    case EnumEnum.Complex => "_Complex"
    case EnumEnum.Imaginery => "_Imaginery"
    case EnumEnum.Abstract => "abstract"
    case EnumEnum.Alignas => "alignas"
    case EnumEnum.Alignof => "alignof"
    case EnumEnum.And => "and"
    case EnumEnum.AndEq => "and_eq"
    case EnumEnum.EnumAny => "any"
    case EnumEnum.PurpleAny => "Any"
    case EnumEnum.ArrayNode => "ArrayNode"
    case EnumEnum.EnumArray => "array"
    case EnumEnum.As => "as"
    case EnumEnum.ASM => "asm"
    case EnumEnum.Assert => "assert"
    case EnumEnum.Associatedtype => "associatedtype"
    case EnumEnum.Associativity => "associativity"
    case EnumEnum.Async => "async"
    case EnumEnum.Atomic => "atomic"
    case EnumEnum.AtomicCancel => "atomic_cancel"
    case EnumEnum.AtomicCommit => "atomic_commit"
    case EnumEnum.AtomicNoexcept => "atomic_noexcept"
    case EnumEnum.Auto => "auto"
    case EnumEnum.Await => "await"
    case EnumEnum.Base => "base"
    case EnumEnum.Bitand => "bitand"
    case EnumEnum.Bitor => "bitor"
    case EnumEnum.EnumBOOL => "BOOL"
    case EnumEnum.EnumBool => "bool"
    case EnumEnum.EnumBoolean => "boolean"
    case EnumEnum.BooleanNode => "BooleanNode"
    case EnumEnum.Break => "break"
    case EnumEnum.Bycopy => "bycopy"
    case EnumEnum.Byref => "byref"
    case EnumEnum.EnumByte => "byte"
    case EnumEnum.Calendar => "Calendar"
    case EnumEnum.Case => "case"
    case EnumEnum.Catch => "catch"
    case EnumEnum.Chan => "chan"
    case EnumEnum.Char => "char"
    case EnumEnum.Char16T => "char16_t"
    case EnumEnum.Char32T => "char32_t"
    case EnumEnum.Checked => "checked"
    case EnumEnum.Class => "class"
    case EnumEnum.EnumClass => "Class"
    case EnumEnum.Clone => "clone"
    case EnumEnum.CoAwait => "co_await"
    case EnumEnum.CoReturn => "co_return"
    case EnumEnum.CoYield => "co_yield"
    case EnumEnum.Codable => "Codable"
    case EnumEnum.CodingKey => "CodingKey"
    case EnumEnum.CodingKeys => "CodingKeys"
    case EnumEnum.Compl => "compl"
    case EnumEnum.Concept => "concept"
    case EnumEnum.Console => "console"
    case EnumEnum.Const => "const"
    case EnumEnum.ConstCast => "const_cast"
    case EnumEnum.Constexpr => "constexpr"
    case EnumEnum.Constructor => "constructor"
    case EnumEnum.Continue => "continue"
    case EnumEnum.Convenience => "convenience"
    case EnumEnum.Convert => "convert"
    case EnumEnum.Converter => "converter"
    case EnumEnum.CultureInfo => "CultureInfo"
    case EnumEnum.Date => "date"
    case EnumEnum.DateParseHandling => "date_parse_handling"
    case EnumEnum.DateFormatter => "DateFormatter"
    case EnumEnum.DateOnly => "DateOnly"
    case EnumEnum.DateOnlyConverter => "DateOnlyConverter"
    case EnumEnum.DateTime => "DateTime"
    case EnumEnum.DateTimeStyles => "DateTimeStyles"
    case EnumEnum.Debugger => "debugger"
    case EnumEnum.Decimal => "decimal"
    case EnumEnum.Declare => "declare"
    case EnumEnum.DeserializationFeature => "DeserializationFeature"
    case EnumEnum.Decltype => "decltype"
    case EnumEnum.DecodeString => "decode_string"
    case EnumEnum.Decoder => "Decoder"
    case EnumEnum.DecodingError => "DecodingError"
    case EnumEnum.Def => "def"
    case EnumEnum.Default => "default"
    case EnumEnum.Defer => "defer"
    case EnumEnum.Deinit => "deinit"
    case EnumEnum.Del => "del"
    case EnumEnum.Delegate => "delegate"
    case EnumEnum.Delete => "delete"
    case EnumEnum.Dict => "dict"
    case EnumEnum.Dictionary => "dictionary"
    case EnumEnum.DidSet => "didSet"
    case EnumEnum.Do => "do"
    case EnumEnum.EnumDouble => "double"
    case EnumEnum.DoubleNode => "DoubleNode"
    case EnumEnum.Dynamic => "dynamic"
    case EnumEnum.DynamicCast => "dynamic_cast"
    case EnumEnum.Elif => "elif"
    case EnumEnum.Else => "else"
    case EnumEnum.EncodeQuickType => "encode_quick_type"
    case EnumEnum.Encoder => "Encoder"
    case EnumEnum.EnumEnum => "enum"
    case EnumEnum.EnumValues => "EnumValues"
    case EnumEnum.Equatable => "Equatable"
    case EnumEnum.EqualityContract => "equalityContract"
    case EnumEnum.Event => "event"
    case EnumEnum.Except => "except"
    case EnumEnum.Exception => "exception"
    case EnumEnum.Explicit => "explicit"
    case EnumEnum.Export => "export"
    case EnumEnum.Exposing => "exposing"
    case EnumEnum.Extends => "extends"
    case EnumEnum.Extension => "extension"
    case EnumEnum.Extern => "extern"
    case EnumEnum.Fallthrough => "fallthrough"
    case EnumEnum.False => "false"
    case EnumEnum.EnumFalse => "False"
    case EnumEnum.Fileprivate => "fileprivate"
    case EnumEnum.Final => "final"
    case EnumEnum.Finally => "finally"
    case EnumEnum.Fixed => "fixed"
    case EnumEnum.EnumFloat => "float"
    case EnumEnum.For => "for"
    case EnumEnum.Foreach => "foreach"
    case EnumEnum.FormatException => "FormatException"
    case EnumEnum.Friend => "friend"
    case EnumEnum.From => "from"
    case EnumEnum.FromDict => "from_dict"
    case EnumEnum.FromJSON => "from_json"
    case EnumEnum.Func => "func"
    case EnumEnum.Function => "function"
    case EnumEnum.Get => "get"
    case EnumEnum.Global => "global"
    case EnumEnum.Go => "go"
    case EnumEnum.Goto => "goto"
    case EnumEnum.Guard => "guard"
    case EnumEnum.Hashable => "Hashable"
    case EnumEnum.HashCode => "hashCode"
    case EnumEnum.Hasher => "Hasher"
    case EnumEnum.HasOwnProperty => "hasOwnProperty"
    case EnumEnum.ID => "id"
    case EnumEnum.If => "if"
    case EnumEnum.Imp => "IMP"
    case EnumEnum.Implements => "implements"
    case EnumEnum.Implicit => "implicit"
    case EnumEnum.Import => "import"
    case EnumEnum.In => "in"
    case EnumEnum.Indirect => "indirect"
    case EnumEnum.Infix => "infix"
    case EnumEnum.Init => "init"
    case EnumEnum.Inline => "inline"
    case EnumEnum.Inout => "inout"
    case EnumEnum.Instanceof => "instanceof"
    case EnumEnum.EnumInt => "int"
    case EnumEnum.IntNode => "IntNode"
    case EnumEnum.Interface => "interface"
    case EnumEnum.Internal => "internal"
    case EnumEnum.ISODateTimeOffsetConverter => "IsoDateTimeOffsetConverter"
    case EnumEnum.Iterable => "iterable"
    case EnumEnum.Is => "is"
    case EnumEnum.Jdec => "jdec"
    case EnumEnum.Jenc => "jenc"
    case EnumEnum.Jpipe => "jpipe"
    case EnumEnum.JSON => "json"
    case EnumEnum.JSONConverter => "json_converter"
    case EnumEnum.JSONSerializer => "json_serializer"
    case EnumEnum.JSONToken => "json_token"
    case EnumEnum.JSONWriter => "json_writer"
    case EnumEnum.JSONAny => "JSONAny"
    case EnumEnum.JSONCodingKey => "JSONCodingKey"
    case EnumEnum.JSONDecoder => "JSONDecoder"
    case EnumEnum.JSONEncoder => "JSONEncoder"
    case EnumEnum.JSONException => "JsonException"
    case EnumEnum.JSONGenerator => "JsonGenerator"
    case EnumEnum.JSONNode => "JsonNode"
    case EnumEnum.JSONNull => "JSONNull"
    case EnumEnum.JSONParser => "JsonParser"
    case EnumEnum.JSONReader => "JsonReader"
    case EnumEnum.JSONTokenType => "JsonTokenType"
    case EnumEnum.Lambda => "lambda"
    case EnumEnum.Lazy => "lazy"
    case EnumEnum.Left => "left"
    case EnumEnum.Let => "let"
    case EnumEnum.EnumList => "list"
    case EnumEnum.LocalDate => "LocalDate"
    case EnumEnum.LongNode => "LongNode"
    case EnumEnum.Locale => "Locale"
    case EnumEnum.Lock => "lock"
    case EnumEnum.EnumLong => "long"
    case EnumEnum.EnumMap => "map"
    case EnumEnum.MarshalJSON => "MarshalJSON"
    case EnumEnum.MapEntry => "MapEntry"
    case EnumEnum.MetadataPropertyHandling => "metadata_property_handling"
    case EnumEnum.Module => "module"
    case EnumEnum.Mutable => "mutable"
    case EnumEnum.Mutating => "mutating"
    case EnumEnum.Namespace => "namespace"
    case EnumEnum.Native => "native"
    case EnumEnum.New => "new"
    case EnumEnum.Newtonsoft => "newtonsoft"
    case EnumEnum.Nil => "nil"
    case EnumEnum.NullNode => "NullNode"
    case EnumEnum.No => "NO"
    case EnumEnum.Noexcept => "noexcept"
    case EnumEnum.Nonatomic => "nonatomic"
    case EnumEnum.None => "none"
    case EnumEnum.EnumNone => "None"
    case EnumEnum.Nonlocal => "nonlocal"
    case EnumEnum.Nonmutating => "nonmutating"
    case EnumEnum.NSObject => "NSObject"
    case EnumEnum.NoSuchMethod => "noSuchMethod"
    case EnumEnum.Not => "not"
    case EnumEnum.NotEq => "not_eq"
    case EnumEnum.NSError => "NSError"
    case EnumEnum.NSString => "NSString"
    case EnumEnum.Null => "NULL"
    case EnumEnum.EnumNull => "null"
    case EnumEnum.Nullptr => "nullptr"
    case EnumEnum.Number => "number"
    case EnumEnum.Object => "object"
    case EnumEnum.OffsetDateTime => "OffsetDateTime"
    case EnumEnum.OffsetTime => "OffsetTime"
    case EnumEnum.ObjectNode => "ObjectNode"
    case EnumEnum.ObjectMapper => "ObjectMapper"
    case EnumEnum.ObjectReader => "ObjectReader"
    case EnumEnum.ObjectWriter => "ObjectWriter"
    case EnumEnum.Of => "of"
    case EnumEnum.Oneway => "oneway"
    case EnumEnum.Open => "open"
    case EnumEnum.Operator => "operator"
    case EnumEnum.Optional => "optional"
    case EnumEnum.Or => "or"
    case EnumEnum.OrEq => "or_eq"
    case EnumEnum.Out => "out"
    case EnumEnum.Override => "override"
    case EnumEnum.Package => "package"
    case EnumEnum.Params => "params"
    case EnumEnum.Pass => "pass"
    case EnumEnum.Port => "port"
    case EnumEnum.Postfix => "postfix"
    case EnumEnum.Precedence => "precedence"
    case EnumEnum.Prefix => "prefix"
    case EnumEnum.Print => "print"
    case EnumEnum.Printf => "printf"
    case EnumEnum.PrintMembers => "printMembers"
    case EnumEnum.Private => "private"
    case EnumEnum.Protected => "protected"
    case EnumEnum.Protocol => "Protocol"
    case EnumEnum.EnumProtocol => "protocol"
    case EnumEnum.Public => "public"
    case EnumEnum.Quicktype => "quicktype"
    case EnumEnum.Raise => "raise"
    case EnumEnum.Range => "range"
    case EnumEnum.Readonly => "readonly"
    case EnumEnum.Ref => "ref"
    case EnumEnum.RegExp => "RegExp"
    case EnumEnum.Register => "register"
    case EnumEnum.ReinterpretCast => "reinterpret_cast"
    case EnumEnum.Repeat => "repeat"
    case EnumEnum.Require => "require"
    case EnumEnum.Required => "required"
    case EnumEnum.Requires => "requires"
    case EnumEnum.Restrict => "restrict"
    case EnumEnum.Retain => "retain"
    case EnumEnum.Rethrows => "rethrows"
    case EnumEnum.Return => "return"
    case EnumEnum.Right => "right"
    case EnumEnum.RuntimeType => "runtimeType"
    case EnumEnum.S => "s"
    case EnumEnum.Sbyte => "sbyte"
    case EnumEnum.Sealed => "sealed"
    case EnumEnum.Sel => "SEL"
    case EnumEnum.Select => "select"
    case EnumEnum.Self => "Self"
    case EnumEnum.Serializable => "Serializable"
    case EnumEnum.EnumSelf => "self"
    case EnumEnum.Sendable => "Sendable"
    case EnumEnum.Serialize => "serialize"
    case EnumEnum.SerialName => "SerialName"
    case EnumEnum.KSerializer => "KSerializer"
    case EnumEnum.PrimitiveKind => "PrimitiveKind"
    case EnumEnum.SerialDescriptor => "SerialDescriptor"
    case EnumEnum.SerializationFeature => "SerializationFeature"
    case EnumEnum.SerializerProvider => "SerializerProvider"
    case EnumEnum.Set => "set"
    case EnumEnum.EnumShort => "short"
    case EnumEnum.Signed => "signed"
    case EnumEnum.SimpleModule => "SimpleModule"
    case EnumEnum.Sizeof => "sizeof"
    case EnumEnum.Stackalloc => "stackalloc"
    case EnumEnum.Standards => "Standards"
    case EnumEnum.Static => "static"
    case EnumEnum.StaticAssert => "static_assert"
    case EnumEnum.StaticCast => "static_cast"
    case EnumEnum.StdDeserializer => "StdDeserializer"
    case EnumEnum.StdSerializer => "StdSerializer"
    case EnumEnum.Strictfp => "strictfp"
    case EnumEnum.EnumString => "string"
    case EnumEnum.Struct => "struct"
    case EnumEnum.Subscript => "subscript"
    case EnumEnum.Super => "super"
    case EnumEnum.Switch => "switch"
    case EnumEnum.Symbol => "symbol"
    case EnumEnum.Synchronized => "synchronized"
    case EnumEnum.EnumSystem => "system"
    case EnumEnum.Template => "template"
    case EnumEnum.Then => "then"
    case EnumEnum.This => "this"
    case EnumEnum.TextNode => "TextNode"
    case EnumEnum.ThreadLocal => "thread_local"
    case EnumEnum.Throw => "throw"
    case EnumEnum.Throws => "throws"
    case EnumEnum.TimeOnly => "TimeOnly"
    case EnumEnum.TimeOnlyConverter => "TimeOnlyConverter"
    case EnumEnum.TimeZone => "TimeZone"
    case EnumEnum.ToJSON => "to_json"
    case EnumEnum.TopLevel => "top_level"
    case EnumEnum.ToString => "toString"
    case EnumEnum.ToDict => "to_dict"
    case EnumEnum.Transient => "transient"
    case EnumEnum.True => "True"
    case EnumEnum.EnumTrue => "true"
    case EnumEnum.Try => "try"
    case EnumEnum.Type => "Type"
    case EnumEnum.EnumType => "type"
    case EnumEnum.Typealias => "typealias"
    case EnumEnum.Typedef => "typedef"
    case EnumEnum.Typeid => "typeid"
    case EnumEnum.Typename => "typename"
    case EnumEnum.Typeof => "typeof"
    case EnumEnum.Uint => "uint"
    case EnumEnum.Ulong => "ulong"
    case EnumEnum.Unchecked => "unchecked"
    case EnumEnum.Undefined => "undefined"
    case EnumEnum.Union => "union"
    case EnumEnum.UnmarshalJSON => "UnmarshalJSON"
    case EnumEnum.UseSerializers => "UseSerializers"
    case EnumEnum.Unowned => "unowned"
    case EnumEnum.Unsafe => "unsafe"
    case EnumEnum.Unsigned => "unsigned"
    case EnumEnum.Ushort => "ushort"
    case EnumEnum.Using => "using"
    case EnumEnum.Utf8JSONReader => "Utf8JsonReader"
    case EnumEnum.Utf8JSONWriter => "Utf8JsonWriter"
    case EnumEnum.UUID => "UUID"
    case EnumEnum.Var => "var"
    case EnumEnum.Virtual => "virtual"
    case EnumEnum.Void => "void"
    case EnumEnum.Volatile => "volatile"
    case EnumEnum.WcharT => "wchar_t"
    case EnumEnum.Weak => "weak"
    case EnumEnum.Where => "where"
    case EnumEnum.While => "while"
    case EnumEnum.WillSet => "willSet"
    case EnumEnum.With => "with"
    case EnumEnum.Xor => "xor"
    case EnumEnum.XorEq => "xor_eq"
    case EnumEnum.Yes => "YES"
    case EnumEnum.Yield => "yield"
    case EnumEnum.Dummy => "dummy"
}
