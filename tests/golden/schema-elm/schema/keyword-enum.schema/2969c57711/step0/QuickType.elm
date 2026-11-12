-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , EnumEnum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { enum : Maybe EnumEnum
    }

type EnumEnum
    = Empty
    | Bool
    | Complex
    | Imaginery
    | Abstract
    | Alignas
    | Alignof
    | And
    | AndEq
    | Any
    | EnumAny
    | ArrayNode
    | EnumArray
    | As
    | ASM
    | Assert
    | Associatedtype
    | Associativity
    | Async
    | Atomic
    | AtomicCancel
    | AtomicCommit
    | AtomicNoexcept
    | Auto
    | Await
    | Base
    | Bitand
    | Bitor
    | EnumBOOL
    | EnumBool
    | Boolean
    | BooleanNode
    | Break
    | Bycopy
    | Byref
    | Byte
    | Calendar
    | Case
    | Catch
    | Chan
    | Char
    | Char16T
    | Char32T
    | Checked
    | Class
    | EnumClass
    | Clone
    | CoAwait
    | CoReturn
    | CoYield
    | Codable
    | CodingKey
    | CodingKeys
    | Compl
    | Concept
    | Console
    | Const
    | ConstCast
    | Constexpr
    | Constructor
    | Continue
    | Convenience
    | Convert
    | Converter
    | CultureInfo
    | Date
    | DateParseHandling
    | DateFormatter
    | DateOnly
    | DateOnlyConverter
    | DateTime
    | DateTimeStyles
    | Debugger
    | Decimal
    | Declare
    | DeserializationFeature
    | Decltype
    | DecodeString
    | Decoder
    | DecodingError
    | Def
    | Default
    | Defer
    | Deinit
    | Del
    | Delegate
    | Delete
    | EnumDict
    | Dictionary
    | DidSet
    | Do
    | Double
    | DoubleNode
    | Dynamic
    | DynamicCast
    | Elif
    | Else
    | EncodeQuickType
    | Encoder
    | Enum
    | EnumValues
    | Equatable
    | EqualityContract
    | Event
    | Except
    | Exception
    | Explicit
    | Export
    | Exposing
    | Extends
    | Extension
    | Extern
    | Fallthrough
    | EnumFalse
    | PurpleFalse
    | Fileprivate
    | Final
    | Finally
    | Fixed
    | EnumFloat
    | For
    | Foreach
    | FormatException
    | Friend
    | From
    | FromDict
    | FromJSON
    | Func
    | Function
    | Get
    | Global
    | Go
    | Goto
    | Guard
    | Hashable
    | HashCode
    | Hasher
    | HasOwnProperty
    | ID
    | If
    | Imp
    | Implements
    | Implicit
    | Import
    | In
    | Indirect
    | Infix
    | Init
    | Inline
    | Inout
    | Instanceof
    | EnumInt
    | IntNode
    | Interface
    | Internal
    | ISODateTimeOffsetConverter
    | Iterable
    | Is
    | EnumJdec
    | EnumJenc
    | EnumJpipe
    | JSON
    | JSONConverter
    | JSONSerializer
    | JSONToken
    | JSONWriter
    | JSONAny
    | JSONCodingKey
    | JSONDecoder
    | JSONEncoder
    | JSONException
    | JSONGenerator
    | JSONNode
    | JSONNull
    | JSONParser
    | JSONReader
    | JSONTokenType
    | Lambda
    | Lazy
    | Left
    | Let
    | EnumList
    | LocalDate
    | LongNode
    | Locale
    | Lock
    | Long
    | Map
    | MarshalJSON
    | MapEntry
    | MetadataPropertyHandling
    | Module
    | Mutable
    | Mutating
    | Namespace
    | Native
    | New
    | Newtonsoft
    | Nil
    | NullNode
    | No
    | Noexcept
    | Nonatomic
    | None
    | EnumNone
    | Nonlocal
    | Nonmutating
    | NSObject
    | NoSuchMethod
    | Not
    | NotEq
    | NSError
    | NSString
    | Null
    | EnumNull
    | Nullptr
    | Number
    | Object
    | OffsetDateTime
    | OffsetTime
    | ObjectNode
    | ObjectMapper
    | ObjectReader
    | ObjectWriter
    | Of
    | Oneway
    | Open
    | Operator
    | Optional
    | Or
    | OrEq
    | Out
    | Override
    | Package
    | Params
    | Pass
    | Port
    | Postfix
    | Precedence
    | Prefix
    | Print
    | Printf
    | PrintMembers
    | Private
    | Protected
    | Protocol
    | EnumProtocol
    | Public
    | Quicktype
    | Raise
    | Range
    | Readonly
    | Ref
    | RegExp
    | Register
    | ReinterpretCast
    | Repeat
    | Require
    | Required
    | Requires
    | Restrict
    | Retain
    | Rethrows
    | Return
    | Right
    | RuntimeType
    | S
    | Sbyte
    | Sealed
    | Sel
    | Select
    | Self
    | Serializable
    | EnumSelf
    | Sendable
    | Serialize
    | SerialName
    | KSerializer
    | PrimitiveKind
    | SerialDescriptor
    | SerializationFeature
    | SerializerProvider
    | Set
    | Short
    | Signed
    | SimpleModule
    | Sizeof
    | Stackalloc
    | Standards
    | Static
    | StaticAssert
    | StaticCast
    | StdDeserializer
    | StdSerializer
    | Strictfp
    | EnumString
    | Struct
    | Subscript
    | Super
    | Switch
    | Symbol
    | Synchronized
    | System
    | Template
    | Then
    | This
    | TextNode
    | ThreadLocal
    | Throw
    | Throws
    | TimeOnly
    | TimeOnlyConverter
    | TimeZone
    | ToJSON
    | TopLevel
    | ToString
    | ToDict
    | Transient
    | EnumTrue
    | PurpleTrue
    | Try
    | Type
    | EnumType
    | Typealias
    | Typedef
    | Typeid
    | Typename
    | Typeof
    | Uint
    | Ulong
    | Unchecked
    | Undefined
    | Union
    | UnmarshalJSON
    | UseSerializers
    | Unowned
    | Unsafe
    | Unsigned
    | Ushort
    | Using
    | Utf8JSONReader
    | Utf8JSONWriter
    | UUID
    | Var
    | Virtual
    | Void
    | Volatile
    | WcharT
    | Weak
    | Where
    | While
    | WillSet
    | With
    | Xor
    | XorEq
    | Yes
    | Yield
    | Dummy

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.custom (optionalField "enum" (Jdec.map Just enumEnum) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("enum", makeNullableEncoder encodeEnumEnum x.enum)
        ]

enumEnum : Jdec.Decoder EnumEnum
enumEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "_" -> Jdec.succeed Empty
                "_Bool" -> Jdec.succeed Bool
                "_Complex" -> Jdec.succeed Complex
                "_Imaginery" -> Jdec.succeed Imaginery
                "abstract" -> Jdec.succeed Abstract
                "alignas" -> Jdec.succeed Alignas
                "alignof" -> Jdec.succeed Alignof
                "and" -> Jdec.succeed And
                "and_eq" -> Jdec.succeed AndEq
                "any" -> Jdec.succeed Any
                "Any" -> Jdec.succeed EnumAny
                "ArrayNode" -> Jdec.succeed ArrayNode
                "array" -> Jdec.succeed EnumArray
                "as" -> Jdec.succeed As
                "asm" -> Jdec.succeed ASM
                "assert" -> Jdec.succeed Assert
                "associatedtype" -> Jdec.succeed Associatedtype
                "associativity" -> Jdec.succeed Associativity
                "async" -> Jdec.succeed Async
                "atomic" -> Jdec.succeed Atomic
                "atomic_cancel" -> Jdec.succeed AtomicCancel
                "atomic_commit" -> Jdec.succeed AtomicCommit
                "atomic_noexcept" -> Jdec.succeed AtomicNoexcept
                "auto" -> Jdec.succeed Auto
                "await" -> Jdec.succeed Await
                "base" -> Jdec.succeed Base
                "bitand" -> Jdec.succeed Bitand
                "bitor" -> Jdec.succeed Bitor
                "BOOL" -> Jdec.succeed EnumBOOL
                "bool" -> Jdec.succeed EnumBool
                "boolean" -> Jdec.succeed Boolean
                "BooleanNode" -> Jdec.succeed BooleanNode
                "break" -> Jdec.succeed Break
                "bycopy" -> Jdec.succeed Bycopy
                "byref" -> Jdec.succeed Byref
                "byte" -> Jdec.succeed Byte
                "Calendar" -> Jdec.succeed Calendar
                "case" -> Jdec.succeed Case
                "catch" -> Jdec.succeed Catch
                "chan" -> Jdec.succeed Chan
                "char" -> Jdec.succeed Char
                "char16_t" -> Jdec.succeed Char16T
                "char32_t" -> Jdec.succeed Char32T
                "checked" -> Jdec.succeed Checked
                "class" -> Jdec.succeed Class
                "Class" -> Jdec.succeed EnumClass
                "clone" -> Jdec.succeed Clone
                "co_await" -> Jdec.succeed CoAwait
                "co_return" -> Jdec.succeed CoReturn
                "co_yield" -> Jdec.succeed CoYield
                "Codable" -> Jdec.succeed Codable
                "CodingKey" -> Jdec.succeed CodingKey
                "CodingKeys" -> Jdec.succeed CodingKeys
                "compl" -> Jdec.succeed Compl
                "concept" -> Jdec.succeed Concept
                "console" -> Jdec.succeed Console
                "const" -> Jdec.succeed Const
                "const_cast" -> Jdec.succeed ConstCast
                "constexpr" -> Jdec.succeed Constexpr
                "constructor" -> Jdec.succeed Constructor
                "continue" -> Jdec.succeed Continue
                "convenience" -> Jdec.succeed Convenience
                "convert" -> Jdec.succeed Convert
                "converter" -> Jdec.succeed Converter
                "CultureInfo" -> Jdec.succeed CultureInfo
                "date" -> Jdec.succeed Date
                "date_parse_handling" -> Jdec.succeed DateParseHandling
                "DateFormatter" -> Jdec.succeed DateFormatter
                "DateOnly" -> Jdec.succeed DateOnly
                "DateOnlyConverter" -> Jdec.succeed DateOnlyConverter
                "DateTime" -> Jdec.succeed DateTime
                "DateTimeStyles" -> Jdec.succeed DateTimeStyles
                "debugger" -> Jdec.succeed Debugger
                "decimal" -> Jdec.succeed Decimal
                "declare" -> Jdec.succeed Declare
                "DeserializationFeature" -> Jdec.succeed DeserializationFeature
                "decltype" -> Jdec.succeed Decltype
                "decode_string" -> Jdec.succeed DecodeString
                "Decoder" -> Jdec.succeed Decoder
                "DecodingError" -> Jdec.succeed DecodingError
                "def" -> Jdec.succeed Def
                "default" -> Jdec.succeed Default
                "defer" -> Jdec.succeed Defer
                "deinit" -> Jdec.succeed Deinit
                "del" -> Jdec.succeed Del
                "delegate" -> Jdec.succeed Delegate
                "delete" -> Jdec.succeed Delete
                "dict" -> Jdec.succeed EnumDict
                "dictionary" -> Jdec.succeed Dictionary
                "didSet" -> Jdec.succeed DidSet
                "do" -> Jdec.succeed Do
                "double" -> Jdec.succeed Double
                "DoubleNode" -> Jdec.succeed DoubleNode
                "dynamic" -> Jdec.succeed Dynamic
                "dynamic_cast" -> Jdec.succeed DynamicCast
                "elif" -> Jdec.succeed Elif
                "else" -> Jdec.succeed Else
                "encode_quick_type" -> Jdec.succeed EncodeQuickType
                "Encoder" -> Jdec.succeed Encoder
                "enum" -> Jdec.succeed Enum
                "EnumValues" -> Jdec.succeed EnumValues
                "Equatable" -> Jdec.succeed Equatable
                "equalityContract" -> Jdec.succeed EqualityContract
                "event" -> Jdec.succeed Event
                "except" -> Jdec.succeed Except
                "exception" -> Jdec.succeed Exception
                "explicit" -> Jdec.succeed Explicit
                "export" -> Jdec.succeed Export
                "exposing" -> Jdec.succeed Exposing
                "extends" -> Jdec.succeed Extends
                "extension" -> Jdec.succeed Extension
                "extern" -> Jdec.succeed Extern
                "fallthrough" -> Jdec.succeed Fallthrough
                "false" -> Jdec.succeed EnumFalse
                "False" -> Jdec.succeed PurpleFalse
                "fileprivate" -> Jdec.succeed Fileprivate
                "final" -> Jdec.succeed Final
                "finally" -> Jdec.succeed Finally
                "fixed" -> Jdec.succeed Fixed
                "float" -> Jdec.succeed EnumFloat
                "for" -> Jdec.succeed For
                "foreach" -> Jdec.succeed Foreach
                "FormatException" -> Jdec.succeed FormatException
                "friend" -> Jdec.succeed Friend
                "from" -> Jdec.succeed From
                "from_dict" -> Jdec.succeed FromDict
                "from_json" -> Jdec.succeed FromJSON
                "func" -> Jdec.succeed Func
                "function" -> Jdec.succeed Function
                "get" -> Jdec.succeed Get
                "global" -> Jdec.succeed Global
                "go" -> Jdec.succeed Go
                "goto" -> Jdec.succeed Goto
                "guard" -> Jdec.succeed Guard
                "Hashable" -> Jdec.succeed Hashable
                "hashCode" -> Jdec.succeed HashCode
                "Hasher" -> Jdec.succeed Hasher
                "hasOwnProperty" -> Jdec.succeed HasOwnProperty
                "id" -> Jdec.succeed ID
                "if" -> Jdec.succeed If
                "IMP" -> Jdec.succeed Imp
                "implements" -> Jdec.succeed Implements
                "implicit" -> Jdec.succeed Implicit
                "import" -> Jdec.succeed Import
                "in" -> Jdec.succeed In
                "indirect" -> Jdec.succeed Indirect
                "infix" -> Jdec.succeed Infix
                "init" -> Jdec.succeed Init
                "inline" -> Jdec.succeed Inline
                "inout" -> Jdec.succeed Inout
                "instanceof" -> Jdec.succeed Instanceof
                "int" -> Jdec.succeed EnumInt
                "IntNode" -> Jdec.succeed IntNode
                "interface" -> Jdec.succeed Interface
                "internal" -> Jdec.succeed Internal
                "IsoDateTimeOffsetConverter" -> Jdec.succeed ISODateTimeOffsetConverter
                "iterable" -> Jdec.succeed Iterable
                "is" -> Jdec.succeed Is
                "jdec" -> Jdec.succeed EnumJdec
                "jenc" -> Jdec.succeed EnumJenc
                "jpipe" -> Jdec.succeed EnumJpipe
                "json" -> Jdec.succeed JSON
                "json_converter" -> Jdec.succeed JSONConverter
                "json_serializer" -> Jdec.succeed JSONSerializer
                "json_token" -> Jdec.succeed JSONToken
                "json_writer" -> Jdec.succeed JSONWriter
                "JSONAny" -> Jdec.succeed JSONAny
                "JSONCodingKey" -> Jdec.succeed JSONCodingKey
                "JSONDecoder" -> Jdec.succeed JSONDecoder
                "JSONEncoder" -> Jdec.succeed JSONEncoder
                "JsonException" -> Jdec.succeed JSONException
                "JsonGenerator" -> Jdec.succeed JSONGenerator
                "JsonNode" -> Jdec.succeed JSONNode
                "JSONNull" -> Jdec.succeed JSONNull
                "JsonParser" -> Jdec.succeed JSONParser
                "JsonReader" -> Jdec.succeed JSONReader
                "JsonTokenType" -> Jdec.succeed JSONTokenType
                "lambda" -> Jdec.succeed Lambda
                "lazy" -> Jdec.succeed Lazy
                "left" -> Jdec.succeed Left
                "let" -> Jdec.succeed Let
                "list" -> Jdec.succeed EnumList
                "LocalDate" -> Jdec.succeed LocalDate
                "LongNode" -> Jdec.succeed LongNode
                "Locale" -> Jdec.succeed Locale
                "lock" -> Jdec.succeed Lock
                "long" -> Jdec.succeed Long
                "map" -> Jdec.succeed Map
                "MarshalJSON" -> Jdec.succeed MarshalJSON
                "MapEntry" -> Jdec.succeed MapEntry
                "metadata_property_handling" -> Jdec.succeed MetadataPropertyHandling
                "module" -> Jdec.succeed Module
                "mutable" -> Jdec.succeed Mutable
                "mutating" -> Jdec.succeed Mutating
                "namespace" -> Jdec.succeed Namespace
                "native" -> Jdec.succeed Native
                "new" -> Jdec.succeed New
                "newtonsoft" -> Jdec.succeed Newtonsoft
                "nil" -> Jdec.succeed Nil
                "NullNode" -> Jdec.succeed NullNode
                "NO" -> Jdec.succeed No
                "noexcept" -> Jdec.succeed Noexcept
                "nonatomic" -> Jdec.succeed Nonatomic
                "none" -> Jdec.succeed None
                "None" -> Jdec.succeed EnumNone
                "nonlocal" -> Jdec.succeed Nonlocal
                "nonmutating" -> Jdec.succeed Nonmutating
                "NSObject" -> Jdec.succeed NSObject
                "noSuchMethod" -> Jdec.succeed NoSuchMethod
                "not" -> Jdec.succeed Not
                "not_eq" -> Jdec.succeed NotEq
                "NSError" -> Jdec.succeed NSError
                "NSString" -> Jdec.succeed NSString
                "NULL" -> Jdec.succeed Null
                "null" -> Jdec.succeed EnumNull
                "nullptr" -> Jdec.succeed Nullptr
                "number" -> Jdec.succeed Number
                "object" -> Jdec.succeed Object
                "OffsetDateTime" -> Jdec.succeed OffsetDateTime
                "OffsetTime" -> Jdec.succeed OffsetTime
                "ObjectNode" -> Jdec.succeed ObjectNode
                "ObjectMapper" -> Jdec.succeed ObjectMapper
                "ObjectReader" -> Jdec.succeed ObjectReader
                "ObjectWriter" -> Jdec.succeed ObjectWriter
                "of" -> Jdec.succeed Of
                "oneway" -> Jdec.succeed Oneway
                "open" -> Jdec.succeed Open
                "operator" -> Jdec.succeed Operator
                "optional" -> Jdec.succeed Optional
                "or" -> Jdec.succeed Or
                "or_eq" -> Jdec.succeed OrEq
                "out" -> Jdec.succeed Out
                "override" -> Jdec.succeed Override
                "package" -> Jdec.succeed Package
                "params" -> Jdec.succeed Params
                "pass" -> Jdec.succeed Pass
                "port" -> Jdec.succeed Port
                "postfix" -> Jdec.succeed Postfix
                "precedence" -> Jdec.succeed Precedence
                "prefix" -> Jdec.succeed Prefix
                "print" -> Jdec.succeed Print
                "printf" -> Jdec.succeed Printf
                "printMembers" -> Jdec.succeed PrintMembers
                "private" -> Jdec.succeed Private
                "protected" -> Jdec.succeed Protected
                "Protocol" -> Jdec.succeed Protocol
                "protocol" -> Jdec.succeed EnumProtocol
                "public" -> Jdec.succeed Public
                "quicktype" -> Jdec.succeed Quicktype
                "raise" -> Jdec.succeed Raise
                "range" -> Jdec.succeed Range
                "readonly" -> Jdec.succeed Readonly
                "ref" -> Jdec.succeed Ref
                "RegExp" -> Jdec.succeed RegExp
                "register" -> Jdec.succeed Register
                "reinterpret_cast" -> Jdec.succeed ReinterpretCast
                "repeat" -> Jdec.succeed Repeat
                "require" -> Jdec.succeed Require
                "required" -> Jdec.succeed Required
                "requires" -> Jdec.succeed Requires
                "restrict" -> Jdec.succeed Restrict
                "retain" -> Jdec.succeed Retain
                "rethrows" -> Jdec.succeed Rethrows
                "return" -> Jdec.succeed Return
                "right" -> Jdec.succeed Right
                "runtimeType" -> Jdec.succeed RuntimeType
                "s" -> Jdec.succeed S
                "sbyte" -> Jdec.succeed Sbyte
                "sealed" -> Jdec.succeed Sealed
                "SEL" -> Jdec.succeed Sel
                "select" -> Jdec.succeed Select
                "Self" -> Jdec.succeed Self
                "Serializable" -> Jdec.succeed Serializable
                "self" -> Jdec.succeed EnumSelf
                "Sendable" -> Jdec.succeed Sendable
                "serialize" -> Jdec.succeed Serialize
                "SerialName" -> Jdec.succeed SerialName
                "KSerializer" -> Jdec.succeed KSerializer
                "PrimitiveKind" -> Jdec.succeed PrimitiveKind
                "SerialDescriptor" -> Jdec.succeed SerialDescriptor
                "SerializationFeature" -> Jdec.succeed SerializationFeature
                "SerializerProvider" -> Jdec.succeed SerializerProvider
                "set" -> Jdec.succeed Set
                "short" -> Jdec.succeed Short
                "signed" -> Jdec.succeed Signed
                "SimpleModule" -> Jdec.succeed SimpleModule
                "sizeof" -> Jdec.succeed Sizeof
                "stackalloc" -> Jdec.succeed Stackalloc
                "Standards" -> Jdec.succeed Standards
                "static" -> Jdec.succeed Static
                "static_assert" -> Jdec.succeed StaticAssert
                "static_cast" -> Jdec.succeed StaticCast
                "StdDeserializer" -> Jdec.succeed StdDeserializer
                "StdSerializer" -> Jdec.succeed StdSerializer
                "strictfp" -> Jdec.succeed Strictfp
                "string" -> Jdec.succeed EnumString
                "struct" -> Jdec.succeed Struct
                "subscript" -> Jdec.succeed Subscript
                "super" -> Jdec.succeed Super
                "switch" -> Jdec.succeed Switch
                "symbol" -> Jdec.succeed Symbol
                "synchronized" -> Jdec.succeed Synchronized
                "system" -> Jdec.succeed System
                "template" -> Jdec.succeed Template
                "then" -> Jdec.succeed Then
                "this" -> Jdec.succeed This
                "TextNode" -> Jdec.succeed TextNode
                "thread_local" -> Jdec.succeed ThreadLocal
                "throw" -> Jdec.succeed Throw
                "throws" -> Jdec.succeed Throws
                "TimeOnly" -> Jdec.succeed TimeOnly
                "TimeOnlyConverter" -> Jdec.succeed TimeOnlyConverter
                "TimeZone" -> Jdec.succeed TimeZone
                "to_json" -> Jdec.succeed ToJSON
                "top_level" -> Jdec.succeed TopLevel
                "toString" -> Jdec.succeed ToString
                "to_dict" -> Jdec.succeed ToDict
                "transient" -> Jdec.succeed Transient
                "True" -> Jdec.succeed EnumTrue
                "true" -> Jdec.succeed PurpleTrue
                "try" -> Jdec.succeed Try
                "Type" -> Jdec.succeed Type
                "type" -> Jdec.succeed EnumType
                "typealias" -> Jdec.succeed Typealias
                "typedef" -> Jdec.succeed Typedef
                "typeid" -> Jdec.succeed Typeid
                "typename" -> Jdec.succeed Typename
                "typeof" -> Jdec.succeed Typeof
                "uint" -> Jdec.succeed Uint
                "ulong" -> Jdec.succeed Ulong
                "unchecked" -> Jdec.succeed Unchecked
                "undefined" -> Jdec.succeed Undefined
                "union" -> Jdec.succeed Union
                "UnmarshalJSON" -> Jdec.succeed UnmarshalJSON
                "UseSerializers" -> Jdec.succeed UseSerializers
                "unowned" -> Jdec.succeed Unowned
                "unsafe" -> Jdec.succeed Unsafe
                "unsigned" -> Jdec.succeed Unsigned
                "ushort" -> Jdec.succeed Ushort
                "using" -> Jdec.succeed Using
                "Utf8JsonReader" -> Jdec.succeed Utf8JSONReader
                "Utf8JsonWriter" -> Jdec.succeed Utf8JSONWriter
                "UUID" -> Jdec.succeed UUID
                "var" -> Jdec.succeed Var
                "virtual" -> Jdec.succeed Virtual
                "void" -> Jdec.succeed Void
                "volatile" -> Jdec.succeed Volatile
                "wchar_t" -> Jdec.succeed WcharT
                "weak" -> Jdec.succeed Weak
                "where" -> Jdec.succeed Where
                "while" -> Jdec.succeed While
                "willSet" -> Jdec.succeed WillSet
                "with" -> Jdec.succeed With
                "xor" -> Jdec.succeed Xor
                "xor_eq" -> Jdec.succeed XorEq
                "YES" -> Jdec.succeed Yes
                "yield" -> Jdec.succeed Yield
                "dummy" -> Jdec.succeed Dummy
                somethingElse -> Jdec.fail <| "Invalid EnumEnum: " ++ somethingElse
        )

encodeEnumEnum : EnumEnum -> Jenc.Value
encodeEnumEnum x = case x of
    Empty -> Jenc.string "_"
    Bool -> Jenc.string "_Bool"
    Complex -> Jenc.string "_Complex"
    Imaginery -> Jenc.string "_Imaginery"
    Abstract -> Jenc.string "abstract"
    Alignas -> Jenc.string "alignas"
    Alignof -> Jenc.string "alignof"
    And -> Jenc.string "and"
    AndEq -> Jenc.string "and_eq"
    Any -> Jenc.string "any"
    EnumAny -> Jenc.string "Any"
    ArrayNode -> Jenc.string "ArrayNode"
    EnumArray -> Jenc.string "array"
    As -> Jenc.string "as"
    ASM -> Jenc.string "asm"
    Assert -> Jenc.string "assert"
    Associatedtype -> Jenc.string "associatedtype"
    Associativity -> Jenc.string "associativity"
    Async -> Jenc.string "async"
    Atomic -> Jenc.string "atomic"
    AtomicCancel -> Jenc.string "atomic_cancel"
    AtomicCommit -> Jenc.string "atomic_commit"
    AtomicNoexcept -> Jenc.string "atomic_noexcept"
    Auto -> Jenc.string "auto"
    Await -> Jenc.string "await"
    Base -> Jenc.string "base"
    Bitand -> Jenc.string "bitand"
    Bitor -> Jenc.string "bitor"
    EnumBOOL -> Jenc.string "BOOL"
    EnumBool -> Jenc.string "bool"
    Boolean -> Jenc.string "boolean"
    BooleanNode -> Jenc.string "BooleanNode"
    Break -> Jenc.string "break"
    Bycopy -> Jenc.string "bycopy"
    Byref -> Jenc.string "byref"
    Byte -> Jenc.string "byte"
    Calendar -> Jenc.string "Calendar"
    Case -> Jenc.string "case"
    Catch -> Jenc.string "catch"
    Chan -> Jenc.string "chan"
    Char -> Jenc.string "char"
    Char16T -> Jenc.string "char16_t"
    Char32T -> Jenc.string "char32_t"
    Checked -> Jenc.string "checked"
    Class -> Jenc.string "class"
    EnumClass -> Jenc.string "Class"
    Clone -> Jenc.string "clone"
    CoAwait -> Jenc.string "co_await"
    CoReturn -> Jenc.string "co_return"
    CoYield -> Jenc.string "co_yield"
    Codable -> Jenc.string "Codable"
    CodingKey -> Jenc.string "CodingKey"
    CodingKeys -> Jenc.string "CodingKeys"
    Compl -> Jenc.string "compl"
    Concept -> Jenc.string "concept"
    Console -> Jenc.string "console"
    Const -> Jenc.string "const"
    ConstCast -> Jenc.string "const_cast"
    Constexpr -> Jenc.string "constexpr"
    Constructor -> Jenc.string "constructor"
    Continue -> Jenc.string "continue"
    Convenience -> Jenc.string "convenience"
    Convert -> Jenc.string "convert"
    Converter -> Jenc.string "converter"
    CultureInfo -> Jenc.string "CultureInfo"
    Date -> Jenc.string "date"
    DateParseHandling -> Jenc.string "date_parse_handling"
    DateFormatter -> Jenc.string "DateFormatter"
    DateOnly -> Jenc.string "DateOnly"
    DateOnlyConverter -> Jenc.string "DateOnlyConverter"
    DateTime -> Jenc.string "DateTime"
    DateTimeStyles -> Jenc.string "DateTimeStyles"
    Debugger -> Jenc.string "debugger"
    Decimal -> Jenc.string "decimal"
    Declare -> Jenc.string "declare"
    DeserializationFeature -> Jenc.string "DeserializationFeature"
    Decltype -> Jenc.string "decltype"
    DecodeString -> Jenc.string "decode_string"
    Decoder -> Jenc.string "Decoder"
    DecodingError -> Jenc.string "DecodingError"
    Def -> Jenc.string "def"
    Default -> Jenc.string "default"
    Defer -> Jenc.string "defer"
    Deinit -> Jenc.string "deinit"
    Del -> Jenc.string "del"
    Delegate -> Jenc.string "delegate"
    Delete -> Jenc.string "delete"
    EnumDict -> Jenc.string "dict"
    Dictionary -> Jenc.string "dictionary"
    DidSet -> Jenc.string "didSet"
    Do -> Jenc.string "do"
    Double -> Jenc.string "double"
    DoubleNode -> Jenc.string "DoubleNode"
    Dynamic -> Jenc.string "dynamic"
    DynamicCast -> Jenc.string "dynamic_cast"
    Elif -> Jenc.string "elif"
    Else -> Jenc.string "else"
    EncodeQuickType -> Jenc.string "encode_quick_type"
    Encoder -> Jenc.string "Encoder"
    Enum -> Jenc.string "enum"
    EnumValues -> Jenc.string "EnumValues"
    Equatable -> Jenc.string "Equatable"
    EqualityContract -> Jenc.string "equalityContract"
    Event -> Jenc.string "event"
    Except -> Jenc.string "except"
    Exception -> Jenc.string "exception"
    Explicit -> Jenc.string "explicit"
    Export -> Jenc.string "export"
    Exposing -> Jenc.string "exposing"
    Extends -> Jenc.string "extends"
    Extension -> Jenc.string "extension"
    Extern -> Jenc.string "extern"
    Fallthrough -> Jenc.string "fallthrough"
    EnumFalse -> Jenc.string "false"
    PurpleFalse -> Jenc.string "False"
    Fileprivate -> Jenc.string "fileprivate"
    Final -> Jenc.string "final"
    Finally -> Jenc.string "finally"
    Fixed -> Jenc.string "fixed"
    EnumFloat -> Jenc.string "float"
    For -> Jenc.string "for"
    Foreach -> Jenc.string "foreach"
    FormatException -> Jenc.string "FormatException"
    Friend -> Jenc.string "friend"
    From -> Jenc.string "from"
    FromDict -> Jenc.string "from_dict"
    FromJSON -> Jenc.string "from_json"
    Func -> Jenc.string "func"
    Function -> Jenc.string "function"
    Get -> Jenc.string "get"
    Global -> Jenc.string "global"
    Go -> Jenc.string "go"
    Goto -> Jenc.string "goto"
    Guard -> Jenc.string "guard"
    Hashable -> Jenc.string "Hashable"
    HashCode -> Jenc.string "hashCode"
    Hasher -> Jenc.string "Hasher"
    HasOwnProperty -> Jenc.string "hasOwnProperty"
    ID -> Jenc.string "id"
    If -> Jenc.string "if"
    Imp -> Jenc.string "IMP"
    Implements -> Jenc.string "implements"
    Implicit -> Jenc.string "implicit"
    Import -> Jenc.string "import"
    In -> Jenc.string "in"
    Indirect -> Jenc.string "indirect"
    Infix -> Jenc.string "infix"
    Init -> Jenc.string "init"
    Inline -> Jenc.string "inline"
    Inout -> Jenc.string "inout"
    Instanceof -> Jenc.string "instanceof"
    EnumInt -> Jenc.string "int"
    IntNode -> Jenc.string "IntNode"
    Interface -> Jenc.string "interface"
    Internal -> Jenc.string "internal"
    ISODateTimeOffsetConverter -> Jenc.string "IsoDateTimeOffsetConverter"
    Iterable -> Jenc.string "iterable"
    Is -> Jenc.string "is"
    EnumJdec -> Jenc.string "jdec"
    EnumJenc -> Jenc.string "jenc"
    EnumJpipe -> Jenc.string "jpipe"
    JSON -> Jenc.string "json"
    JSONConverter -> Jenc.string "json_converter"
    JSONSerializer -> Jenc.string "json_serializer"
    JSONToken -> Jenc.string "json_token"
    JSONWriter -> Jenc.string "json_writer"
    JSONAny -> Jenc.string "JSONAny"
    JSONCodingKey -> Jenc.string "JSONCodingKey"
    JSONDecoder -> Jenc.string "JSONDecoder"
    JSONEncoder -> Jenc.string "JSONEncoder"
    JSONException -> Jenc.string "JsonException"
    JSONGenerator -> Jenc.string "JsonGenerator"
    JSONNode -> Jenc.string "JsonNode"
    JSONNull -> Jenc.string "JSONNull"
    JSONParser -> Jenc.string "JsonParser"
    JSONReader -> Jenc.string "JsonReader"
    JSONTokenType -> Jenc.string "JsonTokenType"
    Lambda -> Jenc.string "lambda"
    Lazy -> Jenc.string "lazy"
    Left -> Jenc.string "left"
    Let -> Jenc.string "let"
    EnumList -> Jenc.string "list"
    LocalDate -> Jenc.string "LocalDate"
    LongNode -> Jenc.string "LongNode"
    Locale -> Jenc.string "Locale"
    Lock -> Jenc.string "lock"
    Long -> Jenc.string "long"
    Map -> Jenc.string "map"
    MarshalJSON -> Jenc.string "MarshalJSON"
    MapEntry -> Jenc.string "MapEntry"
    MetadataPropertyHandling -> Jenc.string "metadata_property_handling"
    Module -> Jenc.string "module"
    Mutable -> Jenc.string "mutable"
    Mutating -> Jenc.string "mutating"
    Namespace -> Jenc.string "namespace"
    Native -> Jenc.string "native"
    New -> Jenc.string "new"
    Newtonsoft -> Jenc.string "newtonsoft"
    Nil -> Jenc.string "nil"
    NullNode -> Jenc.string "NullNode"
    No -> Jenc.string "NO"
    Noexcept -> Jenc.string "noexcept"
    Nonatomic -> Jenc.string "nonatomic"
    None -> Jenc.string "none"
    EnumNone -> Jenc.string "None"
    Nonlocal -> Jenc.string "nonlocal"
    Nonmutating -> Jenc.string "nonmutating"
    NSObject -> Jenc.string "NSObject"
    NoSuchMethod -> Jenc.string "noSuchMethod"
    Not -> Jenc.string "not"
    NotEq -> Jenc.string "not_eq"
    NSError -> Jenc.string "NSError"
    NSString -> Jenc.string "NSString"
    Null -> Jenc.string "NULL"
    EnumNull -> Jenc.string "null"
    Nullptr -> Jenc.string "nullptr"
    Number -> Jenc.string "number"
    Object -> Jenc.string "object"
    OffsetDateTime -> Jenc.string "OffsetDateTime"
    OffsetTime -> Jenc.string "OffsetTime"
    ObjectNode -> Jenc.string "ObjectNode"
    ObjectMapper -> Jenc.string "ObjectMapper"
    ObjectReader -> Jenc.string "ObjectReader"
    ObjectWriter -> Jenc.string "ObjectWriter"
    Of -> Jenc.string "of"
    Oneway -> Jenc.string "oneway"
    Open -> Jenc.string "open"
    Operator -> Jenc.string "operator"
    Optional -> Jenc.string "optional"
    Or -> Jenc.string "or"
    OrEq -> Jenc.string "or_eq"
    Out -> Jenc.string "out"
    Override -> Jenc.string "override"
    Package -> Jenc.string "package"
    Params -> Jenc.string "params"
    Pass -> Jenc.string "pass"
    Port -> Jenc.string "port"
    Postfix -> Jenc.string "postfix"
    Precedence -> Jenc.string "precedence"
    Prefix -> Jenc.string "prefix"
    Print -> Jenc.string "print"
    Printf -> Jenc.string "printf"
    PrintMembers -> Jenc.string "printMembers"
    Private -> Jenc.string "private"
    Protected -> Jenc.string "protected"
    Protocol -> Jenc.string "Protocol"
    EnumProtocol -> Jenc.string "protocol"
    Public -> Jenc.string "public"
    Quicktype -> Jenc.string "quicktype"
    Raise -> Jenc.string "raise"
    Range -> Jenc.string "range"
    Readonly -> Jenc.string "readonly"
    Ref -> Jenc.string "ref"
    RegExp -> Jenc.string "RegExp"
    Register -> Jenc.string "register"
    ReinterpretCast -> Jenc.string "reinterpret_cast"
    Repeat -> Jenc.string "repeat"
    Require -> Jenc.string "require"
    Required -> Jenc.string "required"
    Requires -> Jenc.string "requires"
    Restrict -> Jenc.string "restrict"
    Retain -> Jenc.string "retain"
    Rethrows -> Jenc.string "rethrows"
    Return -> Jenc.string "return"
    Right -> Jenc.string "right"
    RuntimeType -> Jenc.string "runtimeType"
    S -> Jenc.string "s"
    Sbyte -> Jenc.string "sbyte"
    Sealed -> Jenc.string "sealed"
    Sel -> Jenc.string "SEL"
    Select -> Jenc.string "select"
    Self -> Jenc.string "Self"
    Serializable -> Jenc.string "Serializable"
    EnumSelf -> Jenc.string "self"
    Sendable -> Jenc.string "Sendable"
    Serialize -> Jenc.string "serialize"
    SerialName -> Jenc.string "SerialName"
    KSerializer -> Jenc.string "KSerializer"
    PrimitiveKind -> Jenc.string "PrimitiveKind"
    SerialDescriptor -> Jenc.string "SerialDescriptor"
    SerializationFeature -> Jenc.string "SerializationFeature"
    SerializerProvider -> Jenc.string "SerializerProvider"
    Set -> Jenc.string "set"
    Short -> Jenc.string "short"
    Signed -> Jenc.string "signed"
    SimpleModule -> Jenc.string "SimpleModule"
    Sizeof -> Jenc.string "sizeof"
    Stackalloc -> Jenc.string "stackalloc"
    Standards -> Jenc.string "Standards"
    Static -> Jenc.string "static"
    StaticAssert -> Jenc.string "static_assert"
    StaticCast -> Jenc.string "static_cast"
    StdDeserializer -> Jenc.string "StdDeserializer"
    StdSerializer -> Jenc.string "StdSerializer"
    Strictfp -> Jenc.string "strictfp"
    EnumString -> Jenc.string "string"
    Struct -> Jenc.string "struct"
    Subscript -> Jenc.string "subscript"
    Super -> Jenc.string "super"
    Switch -> Jenc.string "switch"
    Symbol -> Jenc.string "symbol"
    Synchronized -> Jenc.string "synchronized"
    System -> Jenc.string "system"
    Template -> Jenc.string "template"
    Then -> Jenc.string "then"
    This -> Jenc.string "this"
    TextNode -> Jenc.string "TextNode"
    ThreadLocal -> Jenc.string "thread_local"
    Throw -> Jenc.string "throw"
    Throws -> Jenc.string "throws"
    TimeOnly -> Jenc.string "TimeOnly"
    TimeOnlyConverter -> Jenc.string "TimeOnlyConverter"
    TimeZone -> Jenc.string "TimeZone"
    ToJSON -> Jenc.string "to_json"
    TopLevel -> Jenc.string "top_level"
    ToString -> Jenc.string "toString"
    ToDict -> Jenc.string "to_dict"
    Transient -> Jenc.string "transient"
    EnumTrue -> Jenc.string "True"
    PurpleTrue -> Jenc.string "true"
    Try -> Jenc.string "try"
    Type -> Jenc.string "Type"
    EnumType -> Jenc.string "type"
    Typealias -> Jenc.string "typealias"
    Typedef -> Jenc.string "typedef"
    Typeid -> Jenc.string "typeid"
    Typename -> Jenc.string "typename"
    Typeof -> Jenc.string "typeof"
    Uint -> Jenc.string "uint"
    Ulong -> Jenc.string "ulong"
    Unchecked -> Jenc.string "unchecked"
    Undefined -> Jenc.string "undefined"
    Union -> Jenc.string "union"
    UnmarshalJSON -> Jenc.string "UnmarshalJSON"
    UseSerializers -> Jenc.string "UseSerializers"
    Unowned -> Jenc.string "unowned"
    Unsafe -> Jenc.string "unsafe"
    Unsigned -> Jenc.string "unsigned"
    Ushort -> Jenc.string "ushort"
    Using -> Jenc.string "using"
    Utf8JSONReader -> Jenc.string "Utf8JsonReader"
    Utf8JSONWriter -> Jenc.string "Utf8JsonWriter"
    UUID -> Jenc.string "UUID"
    Var -> Jenc.string "var"
    Virtual -> Jenc.string "virtual"
    Void -> Jenc.string "void"
    Volatile -> Jenc.string "volatile"
    WcharT -> Jenc.string "wchar_t"
    Weak -> Jenc.string "weak"
    Where -> Jenc.string "where"
    While -> Jenc.string "while"
    WillSet -> Jenc.string "willSet"
    With -> Jenc.string "with"
    Xor -> Jenc.string "xor"
    XorEq -> Jenc.string "xor_eq"
    Yes -> Jenc.string "YES"
    Yield -> Jenc.string "yield"
    Dummy -> Jenc.string "dummy"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
