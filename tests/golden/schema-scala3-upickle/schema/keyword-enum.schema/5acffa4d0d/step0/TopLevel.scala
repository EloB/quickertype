package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    val `enum` : Option[EnumEnum] = None
) derives OptionPickler.ReadWriter

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

given OptionPickler.ReadWriter[EnumEnum] = OptionPickler.readwriter[String].bimap[EnumEnum](
    {
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
    },
    {
        case "_" => EnumEnum.Empty
        case "_Bool" => EnumEnum.Bool
        case "_Complex" => EnumEnum.Complex
        case "_Imaginery" => EnumEnum.Imaginery
        case "abstract" => EnumEnum.Abstract
        case "alignas" => EnumEnum.Alignas
        case "alignof" => EnumEnum.Alignof
        case "and" => EnumEnum.And
        case "and_eq" => EnumEnum.AndEq
        case "any" => EnumEnum.EnumAny
        case "Any" => EnumEnum.PurpleAny
        case "ArrayNode" => EnumEnum.ArrayNode
        case "array" => EnumEnum.EnumArray
        case "as" => EnumEnum.As
        case "asm" => EnumEnum.ASM
        case "assert" => EnumEnum.Assert
        case "associatedtype" => EnumEnum.Associatedtype
        case "associativity" => EnumEnum.Associativity
        case "async" => EnumEnum.Async
        case "atomic" => EnumEnum.Atomic
        case "atomic_cancel" => EnumEnum.AtomicCancel
        case "atomic_commit" => EnumEnum.AtomicCommit
        case "atomic_noexcept" => EnumEnum.AtomicNoexcept
        case "auto" => EnumEnum.Auto
        case "await" => EnumEnum.Await
        case "base" => EnumEnum.Base
        case "bitand" => EnumEnum.Bitand
        case "bitor" => EnumEnum.Bitor
        case "BOOL" => EnumEnum.EnumBOOL
        case "bool" => EnumEnum.EnumBool
        case "boolean" => EnumEnum.EnumBoolean
        case "BooleanNode" => EnumEnum.BooleanNode
        case "break" => EnumEnum.Break
        case "bycopy" => EnumEnum.Bycopy
        case "byref" => EnumEnum.Byref
        case "byte" => EnumEnum.EnumByte
        case "Calendar" => EnumEnum.Calendar
        case "case" => EnumEnum.Case
        case "catch" => EnumEnum.Catch
        case "chan" => EnumEnum.Chan
        case "char" => EnumEnum.Char
        case "char16_t" => EnumEnum.Char16T
        case "char32_t" => EnumEnum.Char32T
        case "checked" => EnumEnum.Checked
        case "class" => EnumEnum.Class
        case "Class" => EnumEnum.EnumClass
        case "clone" => EnumEnum.Clone
        case "co_await" => EnumEnum.CoAwait
        case "co_return" => EnumEnum.CoReturn
        case "co_yield" => EnumEnum.CoYield
        case "Codable" => EnumEnum.Codable
        case "CodingKey" => EnumEnum.CodingKey
        case "CodingKeys" => EnumEnum.CodingKeys
        case "compl" => EnumEnum.Compl
        case "concept" => EnumEnum.Concept
        case "console" => EnumEnum.Console
        case "const" => EnumEnum.Const
        case "const_cast" => EnumEnum.ConstCast
        case "constexpr" => EnumEnum.Constexpr
        case "constructor" => EnumEnum.Constructor
        case "continue" => EnumEnum.Continue
        case "convenience" => EnumEnum.Convenience
        case "convert" => EnumEnum.Convert
        case "converter" => EnumEnum.Converter
        case "CultureInfo" => EnumEnum.CultureInfo
        case "date" => EnumEnum.Date
        case "date_parse_handling" => EnumEnum.DateParseHandling
        case "DateFormatter" => EnumEnum.DateFormatter
        case "DateOnly" => EnumEnum.DateOnly
        case "DateOnlyConverter" => EnumEnum.DateOnlyConverter
        case "DateTime" => EnumEnum.DateTime
        case "DateTimeStyles" => EnumEnum.DateTimeStyles
        case "debugger" => EnumEnum.Debugger
        case "decimal" => EnumEnum.Decimal
        case "declare" => EnumEnum.Declare
        case "DeserializationFeature" => EnumEnum.DeserializationFeature
        case "decltype" => EnumEnum.Decltype
        case "decode_string" => EnumEnum.DecodeString
        case "Decoder" => EnumEnum.Decoder
        case "DecodingError" => EnumEnum.DecodingError
        case "def" => EnumEnum.Def
        case "default" => EnumEnum.Default
        case "defer" => EnumEnum.Defer
        case "deinit" => EnumEnum.Deinit
        case "del" => EnumEnum.Del
        case "delegate" => EnumEnum.Delegate
        case "delete" => EnumEnum.Delete
        case "dict" => EnumEnum.Dict
        case "dictionary" => EnumEnum.Dictionary
        case "didSet" => EnumEnum.DidSet
        case "do" => EnumEnum.Do
        case "double" => EnumEnum.EnumDouble
        case "DoubleNode" => EnumEnum.DoubleNode
        case "dynamic" => EnumEnum.Dynamic
        case "dynamic_cast" => EnumEnum.DynamicCast
        case "elif" => EnumEnum.Elif
        case "else" => EnumEnum.Else
        case "encode_quick_type" => EnumEnum.EncodeQuickType
        case "Encoder" => EnumEnum.Encoder
        case "enum" => EnumEnum.EnumEnum
        case "EnumValues" => EnumEnum.EnumValues
        case "Equatable" => EnumEnum.Equatable
        case "equalityContract" => EnumEnum.EqualityContract
        case "event" => EnumEnum.Event
        case "except" => EnumEnum.Except
        case "exception" => EnumEnum.Exception
        case "explicit" => EnumEnum.Explicit
        case "export" => EnumEnum.Export
        case "exposing" => EnumEnum.Exposing
        case "extends" => EnumEnum.Extends
        case "extension" => EnumEnum.Extension
        case "extern" => EnumEnum.Extern
        case "fallthrough" => EnumEnum.Fallthrough
        case "false" => EnumEnum.False
        case "False" => EnumEnum.EnumFalse
        case "fileprivate" => EnumEnum.Fileprivate
        case "final" => EnumEnum.Final
        case "finally" => EnumEnum.Finally
        case "fixed" => EnumEnum.Fixed
        case "float" => EnumEnum.EnumFloat
        case "for" => EnumEnum.For
        case "foreach" => EnumEnum.Foreach
        case "FormatException" => EnumEnum.FormatException
        case "friend" => EnumEnum.Friend
        case "from" => EnumEnum.From
        case "from_dict" => EnumEnum.FromDict
        case "from_json" => EnumEnum.FromJSON
        case "func" => EnumEnum.Func
        case "function" => EnumEnum.Function
        case "get" => EnumEnum.Get
        case "global" => EnumEnum.Global
        case "go" => EnumEnum.Go
        case "goto" => EnumEnum.Goto
        case "guard" => EnumEnum.Guard
        case "Hashable" => EnumEnum.Hashable
        case "hashCode" => EnumEnum.HashCode
        case "Hasher" => EnumEnum.Hasher
        case "hasOwnProperty" => EnumEnum.HasOwnProperty
        case "id" => EnumEnum.ID
        case "if" => EnumEnum.If
        case "IMP" => EnumEnum.Imp
        case "implements" => EnumEnum.Implements
        case "implicit" => EnumEnum.Implicit
        case "import" => EnumEnum.Import
        case "in" => EnumEnum.In
        case "indirect" => EnumEnum.Indirect
        case "infix" => EnumEnum.Infix
        case "init" => EnumEnum.Init
        case "inline" => EnumEnum.Inline
        case "inout" => EnumEnum.Inout
        case "instanceof" => EnumEnum.Instanceof
        case "int" => EnumEnum.EnumInt
        case "IntNode" => EnumEnum.IntNode
        case "interface" => EnumEnum.Interface
        case "internal" => EnumEnum.Internal
        case "IsoDateTimeOffsetConverter" => EnumEnum.ISODateTimeOffsetConverter
        case "iterable" => EnumEnum.Iterable
        case "is" => EnumEnum.Is
        case "jdec" => EnumEnum.Jdec
        case "jenc" => EnumEnum.Jenc
        case "jpipe" => EnumEnum.Jpipe
        case "json" => EnumEnum.JSON
        case "json_converter" => EnumEnum.JSONConverter
        case "json_serializer" => EnumEnum.JSONSerializer
        case "json_token" => EnumEnum.JSONToken
        case "json_writer" => EnumEnum.JSONWriter
        case "JSONAny" => EnumEnum.JSONAny
        case "JSONCodingKey" => EnumEnum.JSONCodingKey
        case "JSONDecoder" => EnumEnum.JSONDecoder
        case "JSONEncoder" => EnumEnum.JSONEncoder
        case "JsonException" => EnumEnum.JSONException
        case "JsonGenerator" => EnumEnum.JSONGenerator
        case "JsonNode" => EnumEnum.JSONNode
        case "JSONNull" => EnumEnum.JSONNull
        case "JsonParser" => EnumEnum.JSONParser
        case "JsonReader" => EnumEnum.JSONReader
        case "JsonTokenType" => EnumEnum.JSONTokenType
        case "lambda" => EnumEnum.Lambda
        case "lazy" => EnumEnum.Lazy
        case "left" => EnumEnum.Left
        case "let" => EnumEnum.Let
        case "list" => EnumEnum.EnumList
        case "LocalDate" => EnumEnum.LocalDate
        case "LongNode" => EnumEnum.LongNode
        case "Locale" => EnumEnum.Locale
        case "lock" => EnumEnum.Lock
        case "long" => EnumEnum.EnumLong
        case "map" => EnumEnum.EnumMap
        case "MarshalJSON" => EnumEnum.MarshalJSON
        case "MapEntry" => EnumEnum.MapEntry
        case "metadata_property_handling" => EnumEnum.MetadataPropertyHandling
        case "module" => EnumEnum.Module
        case "mutable" => EnumEnum.Mutable
        case "mutating" => EnumEnum.Mutating
        case "namespace" => EnumEnum.Namespace
        case "native" => EnumEnum.Native
        case "new" => EnumEnum.New
        case "newtonsoft" => EnumEnum.Newtonsoft
        case "nil" => EnumEnum.Nil
        case "NullNode" => EnumEnum.NullNode
        case "NO" => EnumEnum.No
        case "noexcept" => EnumEnum.Noexcept
        case "nonatomic" => EnumEnum.Nonatomic
        case "none" => EnumEnum.None
        case "None" => EnumEnum.EnumNone
        case "nonlocal" => EnumEnum.Nonlocal
        case "nonmutating" => EnumEnum.Nonmutating
        case "NSObject" => EnumEnum.NSObject
        case "noSuchMethod" => EnumEnum.NoSuchMethod
        case "not" => EnumEnum.Not
        case "not_eq" => EnumEnum.NotEq
        case "NSError" => EnumEnum.NSError
        case "NSString" => EnumEnum.NSString
        case "NULL" => EnumEnum.Null
        case "null" => EnumEnum.EnumNull
        case "nullptr" => EnumEnum.Nullptr
        case "number" => EnumEnum.Number
        case "object" => EnumEnum.Object
        case "OffsetDateTime" => EnumEnum.OffsetDateTime
        case "OffsetTime" => EnumEnum.OffsetTime
        case "ObjectNode" => EnumEnum.ObjectNode
        case "ObjectMapper" => EnumEnum.ObjectMapper
        case "ObjectReader" => EnumEnum.ObjectReader
        case "ObjectWriter" => EnumEnum.ObjectWriter
        case "of" => EnumEnum.Of
        case "oneway" => EnumEnum.Oneway
        case "open" => EnumEnum.Open
        case "operator" => EnumEnum.Operator
        case "optional" => EnumEnum.Optional
        case "or" => EnumEnum.Or
        case "or_eq" => EnumEnum.OrEq
        case "out" => EnumEnum.Out
        case "override" => EnumEnum.Override
        case "package" => EnumEnum.Package
        case "params" => EnumEnum.Params
        case "pass" => EnumEnum.Pass
        case "port" => EnumEnum.Port
        case "postfix" => EnumEnum.Postfix
        case "precedence" => EnumEnum.Precedence
        case "prefix" => EnumEnum.Prefix
        case "print" => EnumEnum.Print
        case "printf" => EnumEnum.Printf
        case "printMembers" => EnumEnum.PrintMembers
        case "private" => EnumEnum.Private
        case "protected" => EnumEnum.Protected
        case "Protocol" => EnumEnum.Protocol
        case "protocol" => EnumEnum.EnumProtocol
        case "public" => EnumEnum.Public
        case "quicktype" => EnumEnum.Quicktype
        case "raise" => EnumEnum.Raise
        case "range" => EnumEnum.Range
        case "readonly" => EnumEnum.Readonly
        case "ref" => EnumEnum.Ref
        case "RegExp" => EnumEnum.RegExp
        case "register" => EnumEnum.Register
        case "reinterpret_cast" => EnumEnum.ReinterpretCast
        case "repeat" => EnumEnum.Repeat
        case "require" => EnumEnum.Require
        case "required" => EnumEnum.Required
        case "requires" => EnumEnum.Requires
        case "restrict" => EnumEnum.Restrict
        case "retain" => EnumEnum.Retain
        case "rethrows" => EnumEnum.Rethrows
        case "return" => EnumEnum.Return
        case "right" => EnumEnum.Right
        case "runtimeType" => EnumEnum.RuntimeType
        case "s" => EnumEnum.S
        case "sbyte" => EnumEnum.Sbyte
        case "sealed" => EnumEnum.Sealed
        case "SEL" => EnumEnum.Sel
        case "select" => EnumEnum.Select
        case "Self" => EnumEnum.Self
        case "Serializable" => EnumEnum.Serializable
        case "self" => EnumEnum.EnumSelf
        case "Sendable" => EnumEnum.Sendable
        case "serialize" => EnumEnum.Serialize
        case "SerialName" => EnumEnum.SerialName
        case "KSerializer" => EnumEnum.KSerializer
        case "PrimitiveKind" => EnumEnum.PrimitiveKind
        case "SerialDescriptor" => EnumEnum.SerialDescriptor
        case "SerializationFeature" => EnumEnum.SerializationFeature
        case "SerializerProvider" => EnumEnum.SerializerProvider
        case "set" => EnumEnum.Set
        case "short" => EnumEnum.EnumShort
        case "signed" => EnumEnum.Signed
        case "SimpleModule" => EnumEnum.SimpleModule
        case "sizeof" => EnumEnum.Sizeof
        case "stackalloc" => EnumEnum.Stackalloc
        case "Standards" => EnumEnum.Standards
        case "static" => EnumEnum.Static
        case "static_assert" => EnumEnum.StaticAssert
        case "static_cast" => EnumEnum.StaticCast
        case "StdDeserializer" => EnumEnum.StdDeserializer
        case "StdSerializer" => EnumEnum.StdSerializer
        case "strictfp" => EnumEnum.Strictfp
        case "string" => EnumEnum.EnumString
        case "struct" => EnumEnum.Struct
        case "subscript" => EnumEnum.Subscript
        case "super" => EnumEnum.Super
        case "switch" => EnumEnum.Switch
        case "symbol" => EnumEnum.Symbol
        case "synchronized" => EnumEnum.Synchronized
        case "system" => EnumEnum.EnumSystem
        case "template" => EnumEnum.Template
        case "then" => EnumEnum.Then
        case "this" => EnumEnum.This
        case "TextNode" => EnumEnum.TextNode
        case "thread_local" => EnumEnum.ThreadLocal
        case "throw" => EnumEnum.Throw
        case "throws" => EnumEnum.Throws
        case "TimeOnly" => EnumEnum.TimeOnly
        case "TimeOnlyConverter" => EnumEnum.TimeOnlyConverter
        case "TimeZone" => EnumEnum.TimeZone
        case "to_json" => EnumEnum.ToJSON
        case "top_level" => EnumEnum.TopLevel
        case "toString" => EnumEnum.ToString
        case "to_dict" => EnumEnum.ToDict
        case "transient" => EnumEnum.Transient
        case "True" => EnumEnum.True
        case "true" => EnumEnum.EnumTrue
        case "try" => EnumEnum.Try
        case "Type" => EnumEnum.Type
        case "type" => EnumEnum.EnumType
        case "typealias" => EnumEnum.Typealias
        case "typedef" => EnumEnum.Typedef
        case "typeid" => EnumEnum.Typeid
        case "typename" => EnumEnum.Typename
        case "typeof" => EnumEnum.Typeof
        case "uint" => EnumEnum.Uint
        case "ulong" => EnumEnum.Ulong
        case "unchecked" => EnumEnum.Unchecked
        case "undefined" => EnumEnum.Undefined
        case "union" => EnumEnum.Union
        case "UnmarshalJSON" => EnumEnum.UnmarshalJSON
        case "UseSerializers" => EnumEnum.UseSerializers
        case "unowned" => EnumEnum.Unowned
        case "unsafe" => EnumEnum.Unsafe
        case "unsigned" => EnumEnum.Unsigned
        case "ushort" => EnumEnum.Ushort
        case "using" => EnumEnum.Using
        case "Utf8JsonReader" => EnumEnum.Utf8JSONReader
        case "Utf8JsonWriter" => EnumEnum.Utf8JSONWriter
        case "UUID" => EnumEnum.UUID
        case "var" => EnumEnum.Var
        case "virtual" => EnumEnum.Virtual
        case "void" => EnumEnum.Void
        case "volatile" => EnumEnum.Volatile
        case "wchar_t" => EnumEnum.WcharT
        case "weak" => EnumEnum.Weak
        case "where" => EnumEnum.Where
        case "while" => EnumEnum.While
        case "willSet" => EnumEnum.WillSet
        case "with" => EnumEnum.With
        case "xor" => EnumEnum.Xor
        case "xor_eq" => EnumEnum.XorEq
        case "YES" => EnumEnum.Yes
        case "yield" => EnumEnum.Yield
        case "dummy" => EnumEnum.Dummy
        case other => throw new upickle.core.Abort("invalid EnumEnum: " + other)
    }
)
