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
    , Obj1
    , Abstract
    , Alignas
    , Alignof
    , And
    , AndEq
    , Any
    , ArrayClass
    , ArrayNode
    , ASM
    , Assert
    , Associatedtype
    , Associativity
    , Async
    , Atomic
    , AtomicCancel
    , AtomicCommit
    , AtomicNoexcept
    , Auto
    , Await
    , Base
    , Bitand
    , Bitor
    , Boolean
    , BooleanNode
    , Break
    , Bycopy
    , Byref
    , Byte
    , Calendar
    , Catch
    , Chan
    , Char
    , Char16T
    , Char32T
    , Checked
    , Class
    , Clone
    , CoAwait
    , CoReturn
    , CoYield
    , Codable
    , CodingKey
    , CodingKeys
    , Compl
    , Complex
    , Concept
    , Console
    , Const
    , ConstCast
    , Constexpr
    , Constructor
    , Continue
    , Convenience
    , Convert
    , Converter
    , Empty
    , Imaginery
    , AnyClass
    , As
    , Bool
    , BoolClass
    , Case
    , ClassClass
    , Obj1Bool
    , Obj2
    , CultureInfo
    , Date
    , DateFormatter
    , DateOnly
    , DateOnlyConverter
    , DateParseHandling
    , DateTime
    , DateTimeStyles
    , Debugger
    , Decimal
    , Declare
    , Decltype
    , DecodeString
    , DecodingError
    , Def
    , Default
    , Defer
    , Deinit
    , Del
    , Delegate
    , Delete
    , DeserializationFeature
    , DictClass
    , Dictionary
    , DidSet
    , Do
    , Double
    , DoubleNode
    , Dynamic
    , DynamicCast
    , Elif
    , EncodeQuickType
    , Encoder
    , Enum
    , EnumValues
    , EqualityContract
    , Equatable
    , Event
    , Except
    , Exception
    , Explicit
    , Export
    , Extends
    , Extension
    , Extern
    , Fallthrough
    , FalseClass
    , Fileprivate
    , Final
    , Finally
    , Fixed
    , For
    , Foreach
    , FormatException
    , Friend
    , From
    , FromDict
    , FromJSON
    , Func
    , Decoder
    , Else
    , Exposing
    , Obj2False
    , FloatClass
    , Obj3
    , Function
    , Get
    , Global
    , Go
    , Goto
    , Guard
    , HasOwnProperty
    , HashCode
    , Hashable
    , Hasher
    , ID
    , Imp
    , Implements
    , Implicit
    , Indirect
    , Init
    , Inline
    , Inout
    , Instanceof
    , IntNode
    , Interface
    , Internal
    , Is
    , ISODateTimeOffsetConverter
    , Iterable
    , JdecClass
    , JencClass
    , JpipeClass
    , JSON
    , JSONAny
    , JSONCodingKey
    , JSONConverter
    , JSONDecoder
    , JSONEncoder
    , JSONException
    , JSONGenerator
    , JSONNode
    , JSONNull
    , JSONParser
    , JSONReader
    , JSONSerializer
    , JSONToken
    , JSONTokenType
    , JSONWriter
    , Lambda
    , Lazy
    , Left
    , ListClass
    , LocalDate
    , Locale
    , Lock
    , Long
    , LongNode
    , Map
    , MapEntry
    , MarshalJSON
    , MetadataPropertyHandling
    , If
    , Import
    , In
    , Infix
    , IntClass
    , Let
    , Module
    , Obj4
    , Mutable
    , Mutating
    , Namespace
    , Native
    , New
    , Newtonsoft
    , Nil
    , No
    , NoSuchMethod
    , Noexcept
    , Nonatomic
    , None
    , Nonlocal
    , Nonmutating
    , Not
    , NotEq
    , NSError
    , NSObject
    , NSString
    , Null
    , NullNode
    , Nullptr
    , Number
    , NoneClass
    , NullClass
    , Of
    , Port
    , ProtocolClass
    , Object
    , ObjectMapper
    , ObjectNode
    , ObjectReader
    , ObjectWriter
    , OffsetDateTime
    , OffsetTime
    , Oneway
    , Open
    , Operator
    , Optional
    , Or
    , OrEq
    , Out
    , Override
    , Package
    , Params
    , Pass
    , Postfix
    , Precedence
    , Prefix
    , Print
    , PrintMembers
    , Printf
    , Private
    , Protected
    , Protocol
    , Public
    , Quicktype
    , Raise
    , Range
    , Readonly
    , Ref
    , RegExp
    , Register
    , ReinterpretCast
    , Obj5
    , KSerializer
    , SelfClass
    , StringClass
    , Then
    , Obj5True
    , PrimitiveKind
    , Repeat
    , Require
    , Required
    , Requires
    , Restrict
    , Retain
    , Rethrows
    , Return
    , Right
    , RuntimeType
    , S
    , Sbyte
    , Sealed
    , Sel
    , Select
    , Self
    , Sendable
    , SerialDescriptor
    , SerialName
    , Serializable
    , SerializationFeature
    , Serialize
    , SerializerProvider
    , Set
    , Short
    , Signed
    , SimpleModule
    , Sizeof
    , Stackalloc
    , Standards
    , Static
    , StaticAssert
    , StaticCast
    , StdDeserializer
    , StdSerializer
    , Strictfp
    , Struct
    , Subscript
    , Super
    , Switch
    , Symbol
    , Synchronized
    , System
    , Template
    , TextNode
    , This
    , ThreadLocal
    , Throw
    , Throws
    , TimeOnly
    , TimeOnlyConverter
    , TimeZone
    , ToDict
    , ToJSON
    , ToString
    , TopLevel
    , Transient
    , TrueClass
    , Obj6
    , Type
    , Where
    , TypeClass
    , Try
    , Typealias
    , Typedef
    , Typeid
    , Typename
    , Typeof
    , Uint
    , Ulong
    , Unchecked
    , Undefined
    , Union
    , UnmarshalJSON
    , Unowned
    , Unsafe
    , Unsigned
    , UseSerializers
    , Ushort
    , Using
    , Utf8JSONReader
    , Utf8JSONWriter
    , UUID
    , Var
    , Virtual
    , Void
    , Volatile
    , WcharT
    , Weak
    , While
    , WillSet
    , With
    , Xor
    , XorEq
    , Yes
    , Yield
    , EnumValue(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { dummy : Int
    , obj1 : Obj1
    , obj2 : Obj2
    , obj3 : Obj3
    , obj4 : Obj4
    , obj5 : Obj5
    , obj6 : Obj6
    }

type alias Obj1 =
    { abstract : Abstract
    , alignas : Alignas
    , alignof : Alignof
    , and : And
    , andEq : AndEq
    , any : Any
    , array : ArrayClass
    , arrayNode : ArrayNode
    , asm : ASM
    , assert : Assert
    , associatedtype : Associatedtype
    , associativity : Associativity
    , async : Async
    , atomic : Atomic
    , atomicCancel : AtomicCancel
    , atomicCommit : AtomicCommit
    , atomicNoexcept : AtomicNoexcept
    , auto : Auto
    , await : Await
    , base : Base
    , bitand : Bitand
    , bitor : Bitor
    , boolean : Boolean
    , booleanNode : BooleanNode
    , break : Break
    , bycopy : Bycopy
    , byref : Byref
    , byte : Byte
    , calendar : Calendar
    , catch : Catch
    , chan : Chan
    , char : Char
    , char16T : Char16T
    , char32T : Char32T
    , checked : Checked
    , class : Class
    , clone : Clone
    , coAwait : CoAwait
    , coReturn : CoReturn
    , coYield : CoYield
    , codable : Codable
    , codingKey : CodingKey
    , codingKeys : CodingKeys
    , compl : Compl
    , complex : Complex
    , concept : Concept
    , console : Console
    , const : Const
    , constCast : ConstCast
    , constexpr : Constexpr
    , constructor : Constructor
    , continue : Continue
    , convenience : Convenience
    , convert : Convert
    , converter : Converter
    , dummy : Int
    , empty : Empty
    , imaginery : Imaginery
    , obj1Any : AnyClass
    , obj1As : As
    , obj1BOOL : Bool
    , obj1Bool : BoolClass
    , obj1Case : Case
    , obj1Class : ClassClass
    , purpleBool : Obj1Bool
    }

type alias Abstract =
    { abstract : Int
    }

type alias Alignas =
    { alignas : Int
    }

type alias Alignof =
    { alignof : Int
    }

type alias And =
    { and : Int
    }

type alias AndEq =
    { andEq : Int
    }

type alias Any =
    { any : Int
    }

type alias ArrayClass =
    { array : Int
    }

type alias ArrayNode =
    { arrayNode : Int
    }

type alias ASM =
    { asm : Int
    }

type alias Assert =
    { assert : Int
    }

type alias Associatedtype =
    { associatedtype : Int
    }

type alias Associativity =
    { associativity : Int
    }

type alias Async =
    { async : Int
    }

type alias Atomic =
    { atomic : Int
    }

type alias AtomicCancel =
    { atomicCancel : Int
    }

type alias AtomicCommit =
    { atomicCommit : Int
    }

type alias AtomicNoexcept =
    { atomicNoexcept : Int
    }

type alias Auto =
    { auto : Int
    }

type alias Await =
    { await : Int
    }

type alias Base =
    { base : Int
    }

type alias Bitand =
    { bitand : Int
    }

type alias Bitor =
    { bitor : Int
    }

type alias Boolean =
    { boolean : Int
    }

type alias BooleanNode =
    { booleanNode : Int
    }

type alias Break =
    { break : Int
    }

type alias Bycopy =
    { bycopy : Int
    }

type alias Byref =
    { byref : Int
    }

type alias Byte =
    { byte : Int
    }

type alias Calendar =
    { calendar : Int
    }

type alias Catch =
    { catch : Int
    }

type alias Chan =
    { chan : Int
    }

type alias Char =
    { char : Int
    }

type alias Char16T =
    { char16T : Int
    }

type alias Char32T =
    { char32T : Int
    }

type alias Checked =
    { checked : Int
    }

type alias Class =
    { class : Int
    }

type alias Clone =
    { clone : Int
    }

type alias CoAwait =
    { coAwait : Int
    }

type alias CoReturn =
    { coReturn : Int
    }

type alias CoYield =
    { coYield : Int
    }

type alias Codable =
    { codable : Int
    }

type alias CodingKey =
    { codingKey : Int
    }

type alias CodingKeys =
    { codingKeys : Int
    }

type alias Compl =
    { compl : Int
    }

type alias Complex =
    { complex : Int
    }

type alias Concept =
    { concept : Int
    }

type alias Console =
    { console : Int
    }

type alias Const =
    { const : Int
    }

type alias ConstCast =
    { constCast : Int
    }

type alias Constexpr =
    { constexpr : Int
    }

type alias Constructor =
    { constructor : Int
    }

type alias Continue =
    { continue : Int
    }

type alias Convenience =
    { convenience : Int
    }

type alias Convert =
    { convert : Int
    }

type alias Converter =
    { converter : Int
    }

type alias Empty =
    { empty : Int
    }

type alias Imaginery =
    { imaginery : Int
    }

type alias AnyClass =
    { any : Int
    }

type alias As =
    { asAs : Int
    }

type alias Bool =
    { boolBool : Int
    }

type alias BoolClass =
    { boolBool : Int
    }

type alias Case =
    { caseCase : Int
    }

type alias ClassClass =
    { class : Int
    }

type alias Obj1Bool =
    { boolBool : Int
    }

type alias Obj2 =
    { cultureInfo : CultureInfo
    , date : Date
    , dateFormatter : DateFormatter
    , dateOnly : DateOnly
    , dateOnlyConverter : DateOnlyConverter
    , dateParseHandling : DateParseHandling
    , dateTime : DateTime
    , dateTimeStyles : DateTimeStyles
    , debugger : Debugger
    , decimal : Decimal
    , declare : Declare
    , decltype : Decltype
    , decodeString : DecodeString
    , decodingError : DecodingError
    , def : Def
    , default : Default
    , defer : Defer
    , deinit : Deinit
    , del : Del
    , delegate : Delegate
    , delete : Delete
    , deserializationFeature : DeserializationFeature
    , dict : DictClass
    , dictionary : Dictionary
    , didSet : DidSet
    , do : Do
    , double : Double
    , doubleNode : DoubleNode
    , dummy : Int
    , dynamic : Dynamic
    , dynamicCast : DynamicCast
    , elif : Elif
    , encodeQuickType : EncodeQuickType
    , encoder : Encoder
    , enum : Enum
    , enumValues : EnumValues
    , equalityContract : EqualityContract
    , equatable : Equatable
    , event : Event
    , except : Except
    , exception : Exception
    , explicit : Explicit
    , export : Export
    , extends : Extends
    , extension : Extension
    , extern : Extern
    , fallthrough : Fallthrough
    , false : FalseClass
    , fileprivate : Fileprivate
    , final : Final
    , finally : Finally
    , fixed : Fixed
    , for : For
    , foreach : Foreach
    , formatException : FormatException
    , friend : Friend
    , from : From
    , fromDict : FromDict
    , fromJSON : FromJSON
    , func : Func
    , obj2Decoder : Decoder
    , obj2Else : Else
    , obj2Exposing : Exposing
    , obj2False : Obj2False
    , obj2Float : FloatClass
    }

type alias CultureInfo =
    { cultureInfo : Int
    }

type alias Date =
    { date : Int
    }

type alias DateFormatter =
    { dateFormatter : Int
    }

type alias DateOnly =
    { dateOnly : Int
    }

type alias DateOnlyConverter =
    { dateOnlyConverter : Int
    }

type alias DateParseHandling =
    { dateParseHandling : Int
    }

type alias DateTime =
    { dateTime : String
    }

type alias DateTimeStyles =
    { dateTimeStyles : Int
    }

type alias Debugger =
    { debugger : Int
    }

type alias Decimal =
    { decimal : Int
    }

type alias Declare =
    { declare : Int
    }

type alias Decltype =
    { decltype : Int
    }

type alias DecodeString =
    { decodeString : Int
    }

type alias DecodingError =
    { decodingError : Int
    }

type alias Def =
    { def : Int
    }

type alias Default =
    { default : Int
    }

type alias Defer =
    { defer : Int
    }

type alias Deinit =
    { deinit : Int
    }

type alias Del =
    { del : Int
    }

type alias Delegate =
    { delegate : Int
    }

type alias Delete =
    { delete : Int
    }

type alias DeserializationFeature =
    { deserializationFeature : Int
    }

type alias DictClass =
    { dict : Int
    }

type alias Dictionary =
    { dictionary : Int
    }

type alias DidSet =
    { didSet : Int
    }

type alias Do =
    { do : Int
    }

type alias Double =
    { double : Int
    }

type alias DoubleNode =
    { doubleNode : Int
    }

type alias Dynamic =
    { dynamic : Int
    }

type alias DynamicCast =
    { dynamicCast : Int
    }

type alias Elif =
    { elif : Int
    }

type alias EncodeQuickType =
    { encodeQuickType : Int
    }

type alias Encoder =
    { encoder : Int
    }

type alias Enum =
    { enum : Int
    }

type alias EnumValues =
    { enumValues : List EnumValue
    }

type EnumValue
    = Ready
    | Done

type alias EqualityContract =
    { equalityContract : Int
    }

type alias Equatable =
    { equatable : Int
    }

type alias Event =
    { event : Int
    }

type alias Except =
    { except : Int
    }

type alias Exception =
    { exception : Int
    }

type alias Explicit =
    { explicit : Int
    }

type alias Export =
    { export : Int
    }

type alias Extends =
    { extends : Int
    }

type alias Extension =
    { extension : Int
    }

type alias Extern =
    { extern : Int
    }

type alias Fallthrough =
    { fallthrough : Int
    }

type alias FalseClass =
    { false : Int
    }

type alias Fileprivate =
    { fileprivate : Int
    }

type alias Final =
    { final : Int
    }

type alias Finally =
    { finally : Int
    }

type alias Fixed =
    { fixed : Int
    }

type alias For =
    { for : Int
    }

type alias Foreach =
    { foreach : Int
    }

type alias FormatException =
    { formatException : Int
    }

type alias Friend =
    { friend : Int
    }

type alias From =
    { from : Int
    }

type alias FromDict =
    { fromDict : Int
    }

type alias FromJSON =
    { fromJSON : Int
    }

type alias Func =
    { func : Int
    }

type alias Decoder =
    { decoderDecoder : Int
    }

type alias Else =
    { elseElse : Int
    }

type alias Exposing =
    { exposingExposing : Int
    }

type alias Obj2False =
    { false : Int
    }

type alias FloatClass =
    { floatFloat : Int
    }

type alias Obj3 =
    { dummy : Int
    , function : Function
    , get : Get
    , global : Global
    , go : Go
    , goto : Goto
    , guard : Guard
    , hasOwnProperty : HasOwnProperty
    , hashCode : HashCode
    , hashable : Hashable
    , hasher : Hasher
    , id : ID
    , imp : Imp
    , implements : Implements
    , implicit : Implicit
    , indirect : Indirect
    , init : Init
    , inline : Inline
    , inout : Inout
    , instanceof : Instanceof
    , intNode : IntNode
    , interface : Interface
    , internal : Internal
    , is : Is
    , isoDateTimeOffsetConverter : ISODateTimeOffsetConverter
    , iterable : Iterable
    , jdec : JdecClass
    , jenc : JencClass
    , jpipe : JpipeClass
    , json : JSON
    , jsonAny : JSONAny
    , jsonCodingKey : JSONCodingKey
    , jsonConverter : JSONConverter
    , jsonDecoder : JSONDecoder
    , jsonEncoder : JSONEncoder
    , jsonException : JSONException
    , jsonGenerator : JSONGenerator
    , jsonNode : JSONNode
    , jsonNull : JSONNull
    , jsonParser : JSONParser
    , jsonReader : JSONReader
    , jsonSerializer : JSONSerializer
    , jsonToken : JSONToken
    , jsonTokenType : JSONTokenType
    , jsonWriter : JSONWriter
    , lambda : Lambda
    , lazy : Lazy
    , left : Left
    , list : ListClass
    , localDate : LocalDate
    , locale : Locale
    , lock : Lock
    , long : Long
    , longNode : LongNode
    , map : Map
    , mapEntry : MapEntry
    , marshalJSON : MarshalJSON
    , metadataPropertyHandling : MetadataPropertyHandling
    , obj3If : If
    , obj3Import : Import
    , obj3In : In
    , obj3Infix : Infix
    , obj3Int : IntClass
    , obj3Let : Let
    , obj3Module : Module
    }

type alias Function =
    { function : Int
    }

type alias Get =
    { get : Int
    }

type alias Global =
    { global : Int
    }

type alias Go =
    { go : Int
    }

type alias Goto =
    { goto : Int
    }

type alias Guard =
    { guard : Int
    }

type alias HasOwnProperty =
    { hasOwnProperty : Int
    }

type alias HashCode =
    { hashCode : Int
    }

type alias Hashable =
    { hashable : Int
    }

type alias Hasher =
    { hasher : Int
    }

type alias ID =
    { id : Int
    }

type alias Imp =
    { imp : Int
    }

type alias Implements =
    { implements : Int
    }

type alias Implicit =
    { implicit : Int
    }

type alias Indirect =
    { indirect : Int
    }

type alias Init =
    { init : Int
    }

type alias Inline =
    { inline : Int
    }

type alias Inout =
    { inout : Int
    }

type alias Instanceof =
    { instanceof : Int
    }

type alias IntNode =
    { intNode : Int
    }

type alias Interface =
    { interface : Int
    }

type alias Internal =
    { internal : Int
    }

type alias Is =
    { is : Int
    }

type alias ISODateTimeOffsetConverter =
    { isoDateTimeOffsetConverter : Int
    }

type alias Iterable =
    { iterable : Int
    }

type alias JdecClass =
    { jdec : Int
    }

type alias JencClass =
    { jenc : Int
    }

type alias JpipeClass =
    { jpipe : Int
    }

type alias JSON =
    { json : Int
    }

type alias JSONAny =
    { jsonAny : ()
    }

type alias JSONCodingKey =
    { jsonCodingKey : Int
    }

type alias JSONConverter =
    { jsonConverter : Int
    }

type alias JSONDecoder =
    { jsonDecoder : Int
    }

type alias JSONEncoder =
    { jsonEncoder : Int
    }

type alias JSONException =
    { jsonException : Int
    }

type alias JSONGenerator =
    { jsonGenerator : Int
    }

type alias JSONNode =
    { jsonNode : Int
    }

type alias JSONNull =
    { jsonNull : Int
    }

type alias JSONParser =
    { jsonParser : Int
    }

type alias JSONReader =
    { jsonReader : Int
    }

type alias JSONSerializer =
    { jsonSerializer : Int
    }

type alias JSONToken =
    { jsonToken : Int
    }

type alias JSONTokenType =
    { jsonTokenType : Int
    }

type alias JSONWriter =
    { jsonWriter : Int
    }

type alias Lambda =
    { lambda : Int
    }

type alias Lazy =
    { lazy : Int
    }

type alias Left =
    { left : Int
    }

type alias ListClass =
    { list : Int
    }

type alias LocalDate =
    { localDate : Int
    }

type alias Locale =
    { locale : Int
    }

type alias Lock =
    { lock : Int
    }

type alias Long =
    { long : Int
    }

type alias LongNode =
    { longNode : Int
    }

type alias Map =
    { map : Int
    }

type alias MapEntry =
    { mapEntry : Int
    }

type alias MarshalJSON =
    { marshalJSON : Int
    }

type alias MetadataPropertyHandling =
    { metadataPropertyHandling : Int
    }

type alias If =
    { ifIf : Int
    }

type alias Import =
    { importImport : Int
    }

type alias In =
    { inIn : Int
    }

type alias Infix =
    { infixInfix : Int
    }

type alias IntClass =
    { intInt : Int
    }

type alias Let =
    { letLet : Int
    }

type alias Module =
    { moduleModule : Int
    }

type alias Obj4 =
    { dummy : Int
    , mutable : Mutable
    , mutating : Mutating
    , namespace : Namespace
    , native : Native
    , new : New
    , newtonsoft : Newtonsoft
    , nil : Nil
    , no : No
    , noSuchMethod : NoSuchMethod
    , noexcept : Noexcept
    , nonatomic : Nonatomic
    , none : None
    , nonlocal : Nonlocal
    , nonmutating : Nonmutating
    , not : Not
    , notEq : NotEq
    , nsError : NSError
    , nsObject : NSObject
    , nsString : NSString
    , null : Null
    , nullNode : NullNode
    , nullptr : Nullptr
    , number : Number
    , obj4None : NoneClass
    , obj4Null : NullClass
    , obj4Of : Of
    , obj4Port : Port
    , obj4Protocol : ProtocolClass
    , object : Object
    , objectMapper : ObjectMapper
    , objectNode : ObjectNode
    , objectReader : ObjectReader
    , objectWriter : ObjectWriter
    , offsetDateTime : OffsetDateTime
    , offsetTime : OffsetTime
    , oneway : Oneway
    , open : Open
    , operator : Operator
    , optional : Optional
    , or : Or
    , orEq : OrEq
    , out : Out
    , override : Override
    , package : Package
    , params : Params
    , pass : Pass
    , postfix : Postfix
    , precedence : Precedence
    , prefix : Prefix
    , print : Print
    , printMembers : PrintMembers
    , printf : Printf
    , private : Private
    , protected : Protected
    , protocol : Protocol
    , public : Public
    , quicktype : Quicktype
    , raise : Raise
    , range : Range
    , readonly : Readonly
    , ref : Ref
    , regExp : RegExp
    , register : Register
    , reinterpretCast : ReinterpretCast
    }

type alias Mutable =
    { mutable : Int
    }

type alias Mutating =
    { mutating : Int
    }

type alias Namespace =
    { namespace : Int
    }

type alias Native =
    { native : Int
    }

type alias New =
    { new : Int
    }

type alias Newtonsoft =
    { newtonsoft : Int
    }

type alias Nil =
    { nil : Int
    }

type alias No =
    { no : Int
    }

type alias NoSuchMethod =
    { noSuchMethod : Int
    }

type alias Noexcept =
    { noexcept : Int
    }

type alias Nonatomic =
    { nonatomic : Int
    }

type alias None =
    { none : Int
    }

type alias Nonlocal =
    { nonlocal : Int
    }

type alias Nonmutating =
    { nonmutating : Int
    }

type alias Not =
    { not : Int
    }

type alias NotEq =
    { notEq : Int
    }

type alias NSError =
    { nsError : Int
    }

type alias NSObject =
    { nsObject : Int
    }

type alias NSString =
    { nsString : Int
    }

type alias Null =
    { null : Int
    }

type alias NullNode =
    { nullNode : Int
    }

type alias Nullptr =
    { nullptr : Int
    }

type alias Number =
    { number : Int
    }

type alias NoneClass =
    { none : Int
    }

type alias NullClass =
    { null : Int
    }

type alias Of =
    { ofOf : Int
    }

type alias Port =
    { portPort : Int
    }

type alias ProtocolClass =
    { protocol : Int
    }

type alias Object =
    { object : Int
    }

type alias ObjectMapper =
    { objectMapper : Int
    }

type alias ObjectNode =
    { objectNode : Int
    }

type alias ObjectReader =
    { objectReader : Int
    }

type alias ObjectWriter =
    { objectWriter : Int
    }

type alias OffsetDateTime =
    { offsetDateTime : Int
    }

type alias OffsetTime =
    { offsetTime : Int
    }

type alias Oneway =
    { oneway : Int
    }

type alias Open =
    { open : Int
    }

type alias Operator =
    { operator : Int
    }

type alias Optional =
    { optional : Int
    }

type alias Or =
    { or : Int
    }

type alias OrEq =
    { orEq : Int
    }

type alias Out =
    { out : Int
    }

type alias Override =
    { override : Int
    }

type alias Package =
    { package : Int
    }

type alias Params =
    { params : Int
    }

type alias Pass =
    { pass : Int
    }

type alias Postfix =
    { postfix : Int
    }

type alias Precedence =
    { precedence : Int
    }

type alias Prefix =
    { prefix : Int
    }

type alias Print =
    { print : Int
    }

type alias PrintMembers =
    { printMembers : Int
    }

type alias Printf =
    { printf : Int
    }

type alias Private =
    { private : Int
    }

type alias Protected =
    { protected : Int
    }

type alias Protocol =
    { protocol : Int
    }

type alias Public =
    { public : Int
    }

type alias Quicktype =
    { quicktype : Int
    }

type alias Raise =
    { raise : Int
    }

type alias Range =
    { range : Int
    }

type alias Readonly =
    { readonly : Int
    }

type alias Ref =
    { ref : Int
    }

type alias RegExp =
    { regExp : String
    }

type alias Register =
    { register : Int
    }

type alias ReinterpretCast =
    { reinterpretCast : Int
    }

type alias Obj5 =
    { dummy : Int
    , kSerializer : KSerializer
    , obj5Self : SelfClass
    , obj5String : StringClass
    , obj5Then : Then
    , obj5True : Obj5True
    , primitiveKind : PrimitiveKind
    , repeat : Repeat
    , require : Require
    , required : Required
    , requires : Requires
    , restrict : Restrict
    , retain : Retain
    , rethrows : Rethrows
    , return : Return
    , right : Right
    , runtimeType : RuntimeType
    , s : S
    , sbyte : Sbyte
    , sealed : Sealed
    , sel : Sel
    , select : Select
    , self : Self
    , sendable : Sendable
    , serialDescriptor : SerialDescriptor
    , serialName : SerialName
    , serializable : Serializable
    , serializationFeature : SerializationFeature
    , serialize : Serialize
    , serializerProvider : SerializerProvider
    , set : Set
    , short : Short
    , signed : Signed
    , simpleModule : SimpleModule
    , sizeof : Sizeof
    , stackalloc : Stackalloc
    , standards : Standards
    , static : Static
    , staticAssert : StaticAssert
    , staticCast : StaticCast
    , stdDeserializer : StdDeserializer
    , stdSerializer : StdSerializer
    , strictfp : Strictfp
    , struct : Struct
    , subscript : Subscript
    , super : Super
    , switch : Switch
    , symbol : Symbol
    , synchronized : Synchronized
    , system : System
    , template : Template
    , textNode : TextNode
    , this : This
    , threadLocal : ThreadLocal
    , throw : Throw
    , throws : Throws
    , timeOnly : TimeOnly
    , timeOnlyConverter : TimeOnlyConverter
    , timeZone : TimeZone
    , toDict : ToDict
    , toJSON : ToJSON
    , toString : ToString
    , topLevel : TopLevel
    , transient : Transient
    , true : TrueClass
    }

type alias KSerializer =
    { kSerializer : Int
    }

type alias SelfClass =
    { self : Int
    }

type alias StringClass =
    { stringString : Int
    }

type alias Then =
    { thenThen : Int
    }

type alias Obj5True =
    { true : Int
    }

type alias PrimitiveKind =
    { primitiveKind : Int
    }

type alias Repeat =
    { repeat : Int
    }

type alias Require =
    { require : Int
    }

type alias Required =
    { required : Int
    }

type alias Requires =
    { requires : Int
    }

type alias Restrict =
    { restrict : Int
    }

type alias Retain =
    { retain : Int
    }

type alias Rethrows =
    { rethrows : Int
    }

type alias Return =
    { return : Int
    }

type alias Right =
    { right : Int
    }

type alias RuntimeType =
    { runtimeType : Int
    }

type alias S =
    { s : Int
    }

type alias Sbyte =
    { sbyte : Int
    }

type alias Sealed =
    { sealed : Int
    }

type alias Sel =
    { sel : Int
    }

type alias Select =
    { select : Int
    }

type alias Self =
    { self : Int
    }

type alias Sendable =
    { sendable : Int
    }

type alias SerialDescriptor =
    { serialDescriptor : Int
    }

type alias SerialName =
    { serialName : Int
    }

type alias Serializable =
    { serializable : Int
    }

type alias SerializationFeature =
    { serializationFeature : Int
    }

type alias Serialize =
    { serialize : Int
    }

type alias SerializerProvider =
    { serializerProvider : Int
    }

type alias Set =
    { set : Int
    }

type alias Short =
    { short : Int
    }

type alias Signed =
    { signed : Int
    }

type alias SimpleModule =
    { simpleModule : Int
    }

type alias Sizeof =
    { sizeof : Int
    }

type alias Stackalloc =
    { stackalloc : Int
    }

type alias Standards =
    { standards : Int
    }

type alias Static =
    { static : Int
    }

type alias StaticAssert =
    { staticAssert : Int
    }

type alias StaticCast =
    { staticCast : Int
    }

type alias StdDeserializer =
    { stdDeserializer : Int
    }

type alias StdSerializer =
    { stdSerializer : Int
    }

type alias Strictfp =
    { strictfp : Int
    }

type alias Struct =
    { struct : Int
    }

type alias Subscript =
    { subscript : Int
    }

type alias Super =
    { super : Int
    }

type alias Switch =
    { switch : Int
    }

type alias Symbol =
    { symbol : Int
    }

type alias Synchronized =
    { synchronized : Int
    }

type alias System =
    { system : Int
    }

type alias Template =
    { template : Int
    }

type alias TextNode =
    { textNode : Int
    }

type alias This =
    { this : Int
    }

type alias ThreadLocal =
    { threadLocal : Int
    }

type alias Throw =
    { throw : Int
    }

type alias Throws =
    { throws : Int
    }

type alias TimeOnly =
    { timeOnly : Int
    }

type alias TimeOnlyConverter =
    { timeOnlyConverter : Int
    }

type alias TimeZone =
    { timeZone : Int
    }

type alias ToDict =
    { toDict : Int
    }

type alias ToJSON =
    { toJSON : Int
    }

type alias ToString =
    { toString : Int
    }

type alias TopLevel =
    { topLevel : Int
    }

type alias Transient =
    { transient : Int
    }

type alias TrueClass =
    { true : Int
    }

type alias Obj6 =
    { dummy : Int
    , obj6Type : Type
    , obj6Where : Where
    , purpleType : TypeClass
    , try : Try
    , typealias : Typealias
    , typedef : Typedef
    , typeid : Typeid
    , typename : Typename
    , typeof : Typeof
    , uint : Uint
    , ulong : Ulong
    , unchecked : Unchecked
    , undefined : Undefined
    , union : Union
    , unmarshalJSON : UnmarshalJSON
    , unowned : Unowned
    , unsafe : Unsafe
    , unsigned : Unsigned
    , useSerializers : UseSerializers
    , ushort : Ushort
    , using : Using
    , utf8JSONReader : Utf8JSONReader
    , utf8JSONWriter : Utf8JSONWriter
    , uuid : UUID
    , var : Var
    , virtual : Virtual
    , void : Void
    , volatile : Volatile
    , wcharT : WcharT
    , weak : Weak
    , while : While
    , willSet : WillSet
    , with : With
    , xor : Xor
    , xorEq : XorEq
    , yes : Yes
    , yield : Yield
    }

type alias Type =
    { typeType : Int
    }

type alias Where =
    { whereWhere : Int
    }

type alias TypeClass =
    { typeType : Int
    }

type alias Try =
    { try : Int
    }

type alias Typealias =
    { typealias : Int
    }

type alias Typedef =
    { typedef : Int
    }

type alias Typeid =
    { typeid : Int
    }

type alias Typename =
    { typename : Int
    }

type alias Typeof =
    { typeof : Int
    }

type alias Uint =
    { uint : Int
    }

type alias Ulong =
    { ulong : Int
    }

type alias Unchecked =
    { unchecked : Int
    }

type alias Undefined =
    { undefined : Int
    }

type alias Union =
    { union : Int
    }

type alias UnmarshalJSON =
    { unmarshalJSON : Int
    }

type alias Unowned =
    { unowned : Int
    }

type alias Unsafe =
    { unsafe : Int
    }

type alias Unsigned =
    { unsigned : Int
    }

type alias UseSerializers =
    { useSerializers : Int
    }

type alias Ushort =
    { ushort : Int
    }

type alias Using =
    { using : Int
    }

type alias Utf8JSONReader =
    { utf8JSONReader : Int
    }

type alias Utf8JSONWriter =
    { utf8JSONWriter : Int
    }

type alias UUID =
    { uuid : Int
    }

type alias Var =
    { var : Int
    }

type alias Virtual =
    { virtual : Int
    }

type alias Void =
    { void : Int
    }

type alias Volatile =
    { volatile : Int
    }

type alias WcharT =
    { wcharT : Int
    }

type alias Weak =
    { weak : Int
    }

type alias While =
    { while : Int
    }

type alias WillSet =
    { willSet : Int
    }

type alias With =
    { with : Int
    }

type alias Xor =
    { xor : Int
    }

type alias XorEq =
    { xorEq : Int
    }

type alias Yes =
    { yes : Int
    }

type alias Yield =
    { yield : Int
    }

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
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "obj1" obj1
        |> Jpipe.required "obj2" obj2
        |> Jpipe.required "obj3" obj3
        |> Jpipe.required "obj4" obj4
        |> Jpipe.required "obj5" obj5
        |> Jpipe.required "obj6" obj6

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("dummy", Jenc.int x.dummy)
        , ("obj1", encodeObj1 x.obj1)
        , ("obj2", encodeObj2 x.obj2)
        , ("obj3", encodeObj3 x.obj3)
        , ("obj4", encodeObj4 x.obj4)
        , ("obj5", encodeObj5 x.obj5)
        , ("obj6", encodeObj6 x.obj6)
        ]

obj1 : Jdec.Decoder Obj1
obj1 =
    Jdec.succeed Obj1
        |> Jpipe.required "abstract" abstract
        |> Jpipe.required "alignas" alignas
        |> Jpipe.required "alignof" alignof
        |> Jpipe.required "and" and
        |> Jpipe.required "and_eq" andEq
        |> Jpipe.required "Any" any
        |> Jpipe.required "array" arrayClass
        |> Jpipe.required "ArrayNode" arrayNode
        |> Jpipe.required "asm" asm
        |> Jpipe.required "assert" assert
        |> Jpipe.required "associatedtype" associatedtype
        |> Jpipe.required "associativity" associativity
        |> Jpipe.required "async" async
        |> Jpipe.required "atomic" atomic
        |> Jpipe.required "atomic_cancel" atomicCancel
        |> Jpipe.required "atomic_commit" atomicCommit
        |> Jpipe.required "atomic_noexcept" atomicNoexcept
        |> Jpipe.required "auto" auto
        |> Jpipe.required "await" await
        |> Jpipe.required "base" base
        |> Jpipe.required "bitand" bitand
        |> Jpipe.required "bitor" bitor
        |> Jpipe.required "boolean" boolean
        |> Jpipe.required "BooleanNode" booleanNode
        |> Jpipe.required "break" break
        |> Jpipe.required "bycopy" bycopy
        |> Jpipe.required "byref" byref
        |> Jpipe.required "byte" byte
        |> Jpipe.required "Calendar" calendar
        |> Jpipe.required "catch" catch
        |> Jpipe.required "chan" chan
        |> Jpipe.required "char" char
        |> Jpipe.required "char16_t" char16T
        |> Jpipe.required "char32_t" char32T
        |> Jpipe.required "checked" checked
        |> Jpipe.required "Class" class
        |> Jpipe.required "clone" clone
        |> Jpipe.required "co_await" coAwait
        |> Jpipe.required "co_return" coReturn
        |> Jpipe.required "co_yield" coYield
        |> Jpipe.required "Codable" codable
        |> Jpipe.required "CodingKey" codingKey
        |> Jpipe.required "CodingKeys" codingKeys
        |> Jpipe.required "compl" compl
        |> Jpipe.required "_Complex" complex
        |> Jpipe.required "concept" concept
        |> Jpipe.required "console" console
        |> Jpipe.required "const" const
        |> Jpipe.required "const_cast" constCast
        |> Jpipe.required "constexpr" constexpr
        |> Jpipe.required "constructor" constructor
        |> Jpipe.required "continue" continue
        |> Jpipe.required "convenience" convenience
        |> Jpipe.required "convert" convert
        |> Jpipe.required "converter" converter
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "_" empty
        |> Jpipe.required "_Imaginery" imaginery
        |> Jpipe.required "any" anyClass
        |> Jpipe.required "as" purpleAs
        |> Jpipe.required "BOOL" purpleBool
        |> Jpipe.required "_Bool" boolClass
        |> Jpipe.required "case" purpleCase
        |> Jpipe.required "class" classClass
        |> Jpipe.required "bool" obj1Bool

encodeObj1 : Obj1 -> Jenc.Value
encodeObj1 x =
    Jenc.object
        [ ("abstract", encodeAbstract x.abstract)
        , ("alignas", encodeAlignas x.alignas)
        , ("alignof", encodeAlignof x.alignof)
        , ("and", encodeAnd x.and)
        , ("and_eq", encodeAndEq x.andEq)
        , ("Any", encodeAny x.any)
        , ("array", encodeArrayClass x.array)
        , ("ArrayNode", encodeArrayNode x.arrayNode)
        , ("asm", encodeASM x.asm)
        , ("assert", encodeAssert x.assert)
        , ("associatedtype", encodeAssociatedtype x.associatedtype)
        , ("associativity", encodeAssociativity x.associativity)
        , ("async", encodeAsync x.async)
        , ("atomic", encodeAtomic x.atomic)
        , ("atomic_cancel", encodeAtomicCancel x.atomicCancel)
        , ("atomic_commit", encodeAtomicCommit x.atomicCommit)
        , ("atomic_noexcept", encodeAtomicNoexcept x.atomicNoexcept)
        , ("auto", encodeAuto x.auto)
        , ("await", encodeAwait x.await)
        , ("base", encodeBase x.base)
        , ("bitand", encodeBitand x.bitand)
        , ("bitor", encodeBitor x.bitor)
        , ("boolean", encodeBoolean x.boolean)
        , ("BooleanNode", encodeBooleanNode x.booleanNode)
        , ("break", encodeBreak x.break)
        , ("bycopy", encodeBycopy x.bycopy)
        , ("byref", encodeByref x.byref)
        , ("byte", encodeByte x.byte)
        , ("Calendar", encodeCalendar x.calendar)
        , ("catch", encodeCatch x.catch)
        , ("chan", encodeChan x.chan)
        , ("char", encodeChar x.char)
        , ("char16_t", encodeChar16T x.char16T)
        , ("char32_t", encodeChar32T x.char32T)
        , ("checked", encodeChecked x.checked)
        , ("Class", encodeClass x.class)
        , ("clone", encodeClone x.clone)
        , ("co_await", encodeCoAwait x.coAwait)
        , ("co_return", encodeCoReturn x.coReturn)
        , ("co_yield", encodeCoYield x.coYield)
        , ("Codable", encodeCodable x.codable)
        , ("CodingKey", encodeCodingKey x.codingKey)
        , ("CodingKeys", encodeCodingKeys x.codingKeys)
        , ("compl", encodeCompl x.compl)
        , ("_Complex", encodeComplex x.complex)
        , ("concept", encodeConcept x.concept)
        , ("console", encodeConsole x.console)
        , ("const", encodeConst x.const)
        , ("const_cast", encodeConstCast x.constCast)
        , ("constexpr", encodeConstexpr x.constexpr)
        , ("constructor", encodeConstructor x.constructor)
        , ("continue", encodeContinue x.continue)
        , ("convenience", encodeConvenience x.convenience)
        , ("convert", encodeConvert x.convert)
        , ("converter", encodeConverter x.converter)
        , ("dummy", Jenc.int x.dummy)
        , ("_", encodeEmpty x.empty)
        , ("_Imaginery", encodeImaginery x.imaginery)
        , ("any", encodeAnyClass x.obj1Any)
        , ("as", encodeAs x.obj1As)
        , ("BOOL", encodeBool x.obj1BOOL)
        , ("_Bool", encodeBoolClass x.obj1Bool)
        , ("case", encodeCase x.obj1Case)
        , ("class", encodeClassClass x.obj1Class)
        , ("bool", encodeObj1Bool x.purpleBool)
        ]

abstract : Jdec.Decoder Abstract
abstract =
    Jdec.succeed Abstract
        |> Jpipe.required "abstract" Jdec.int

encodeAbstract : Abstract -> Jenc.Value
encodeAbstract x =
    Jenc.object
        [ ("abstract", Jenc.int x.abstract)
        ]

alignas : Jdec.Decoder Alignas
alignas =
    Jdec.succeed Alignas
        |> Jpipe.required "alignas" Jdec.int

encodeAlignas : Alignas -> Jenc.Value
encodeAlignas x =
    Jenc.object
        [ ("alignas", Jenc.int x.alignas)
        ]

alignof : Jdec.Decoder Alignof
alignof =
    Jdec.succeed Alignof
        |> Jpipe.required "alignof" Jdec.int

encodeAlignof : Alignof -> Jenc.Value
encodeAlignof x =
    Jenc.object
        [ ("alignof", Jenc.int x.alignof)
        ]

and : Jdec.Decoder And
and =
    Jdec.succeed And
        |> Jpipe.required "and" Jdec.int

encodeAnd : And -> Jenc.Value
encodeAnd x =
    Jenc.object
        [ ("and", Jenc.int x.and)
        ]

andEq : Jdec.Decoder AndEq
andEq =
    Jdec.succeed AndEq
        |> Jpipe.required "and_eq" Jdec.int

encodeAndEq : AndEq -> Jenc.Value
encodeAndEq x =
    Jenc.object
        [ ("and_eq", Jenc.int x.andEq)
        ]

any : Jdec.Decoder Any
any =
    Jdec.succeed Any
        |> Jpipe.required "Any" Jdec.int

encodeAny : Any -> Jenc.Value
encodeAny x =
    Jenc.object
        [ ("Any", Jenc.int x.any)
        ]

arrayClass : Jdec.Decoder ArrayClass
arrayClass =
    Jdec.succeed ArrayClass
        |> Jpipe.required "array" Jdec.int

encodeArrayClass : ArrayClass -> Jenc.Value
encodeArrayClass x =
    Jenc.object
        [ ("array", Jenc.int x.array)
        ]

arrayNode : Jdec.Decoder ArrayNode
arrayNode =
    Jdec.succeed ArrayNode
        |> Jpipe.required "ArrayNode" Jdec.int

encodeArrayNode : ArrayNode -> Jenc.Value
encodeArrayNode x =
    Jenc.object
        [ ("ArrayNode", Jenc.int x.arrayNode)
        ]

asm : Jdec.Decoder ASM
asm =
    Jdec.succeed ASM
        |> Jpipe.required "asm" Jdec.int

encodeASM : ASM -> Jenc.Value
encodeASM x =
    Jenc.object
        [ ("asm", Jenc.int x.asm)
        ]

assert : Jdec.Decoder Assert
assert =
    Jdec.succeed Assert
        |> Jpipe.required "assert" Jdec.int

encodeAssert : Assert -> Jenc.Value
encodeAssert x =
    Jenc.object
        [ ("assert", Jenc.int x.assert)
        ]

associatedtype : Jdec.Decoder Associatedtype
associatedtype =
    Jdec.succeed Associatedtype
        |> Jpipe.required "associatedtype" Jdec.int

encodeAssociatedtype : Associatedtype -> Jenc.Value
encodeAssociatedtype x =
    Jenc.object
        [ ("associatedtype", Jenc.int x.associatedtype)
        ]

associativity : Jdec.Decoder Associativity
associativity =
    Jdec.succeed Associativity
        |> Jpipe.required "associativity" Jdec.int

encodeAssociativity : Associativity -> Jenc.Value
encodeAssociativity x =
    Jenc.object
        [ ("associativity", Jenc.int x.associativity)
        ]

async : Jdec.Decoder Async
async =
    Jdec.succeed Async
        |> Jpipe.required "async" Jdec.int

encodeAsync : Async -> Jenc.Value
encodeAsync x =
    Jenc.object
        [ ("async", Jenc.int x.async)
        ]

atomic : Jdec.Decoder Atomic
atomic =
    Jdec.succeed Atomic
        |> Jpipe.required "atomic" Jdec.int

encodeAtomic : Atomic -> Jenc.Value
encodeAtomic x =
    Jenc.object
        [ ("atomic", Jenc.int x.atomic)
        ]

atomicCancel : Jdec.Decoder AtomicCancel
atomicCancel =
    Jdec.succeed AtomicCancel
        |> Jpipe.required "atomic_cancel" Jdec.int

encodeAtomicCancel : AtomicCancel -> Jenc.Value
encodeAtomicCancel x =
    Jenc.object
        [ ("atomic_cancel", Jenc.int x.atomicCancel)
        ]

atomicCommit : Jdec.Decoder AtomicCommit
atomicCommit =
    Jdec.succeed AtomicCommit
        |> Jpipe.required "atomic_commit" Jdec.int

encodeAtomicCommit : AtomicCommit -> Jenc.Value
encodeAtomicCommit x =
    Jenc.object
        [ ("atomic_commit", Jenc.int x.atomicCommit)
        ]

atomicNoexcept : Jdec.Decoder AtomicNoexcept
atomicNoexcept =
    Jdec.succeed AtomicNoexcept
        |> Jpipe.required "atomic_noexcept" Jdec.int

encodeAtomicNoexcept : AtomicNoexcept -> Jenc.Value
encodeAtomicNoexcept x =
    Jenc.object
        [ ("atomic_noexcept", Jenc.int x.atomicNoexcept)
        ]

auto : Jdec.Decoder Auto
auto =
    Jdec.succeed Auto
        |> Jpipe.required "auto" Jdec.int

encodeAuto : Auto -> Jenc.Value
encodeAuto x =
    Jenc.object
        [ ("auto", Jenc.int x.auto)
        ]

await : Jdec.Decoder Await
await =
    Jdec.succeed Await
        |> Jpipe.required "await" Jdec.int

encodeAwait : Await -> Jenc.Value
encodeAwait x =
    Jenc.object
        [ ("await", Jenc.int x.await)
        ]

base : Jdec.Decoder Base
base =
    Jdec.succeed Base
        |> Jpipe.required "base" Jdec.int

encodeBase : Base -> Jenc.Value
encodeBase x =
    Jenc.object
        [ ("base", Jenc.int x.base)
        ]

bitand : Jdec.Decoder Bitand
bitand =
    Jdec.succeed Bitand
        |> Jpipe.required "bitand" Jdec.int

encodeBitand : Bitand -> Jenc.Value
encodeBitand x =
    Jenc.object
        [ ("bitand", Jenc.int x.bitand)
        ]

bitor : Jdec.Decoder Bitor
bitor =
    Jdec.succeed Bitor
        |> Jpipe.required "bitor" Jdec.int

encodeBitor : Bitor -> Jenc.Value
encodeBitor x =
    Jenc.object
        [ ("bitor", Jenc.int x.bitor)
        ]

boolean : Jdec.Decoder Boolean
boolean =
    Jdec.succeed Boolean
        |> Jpipe.required "boolean" Jdec.int

encodeBoolean : Boolean -> Jenc.Value
encodeBoolean x =
    Jenc.object
        [ ("boolean", Jenc.int x.boolean)
        ]

booleanNode : Jdec.Decoder BooleanNode
booleanNode =
    Jdec.succeed BooleanNode
        |> Jpipe.required "BooleanNode" Jdec.int

encodeBooleanNode : BooleanNode -> Jenc.Value
encodeBooleanNode x =
    Jenc.object
        [ ("BooleanNode", Jenc.int x.booleanNode)
        ]

break : Jdec.Decoder Break
break =
    Jdec.succeed Break
        |> Jpipe.required "break" Jdec.int

encodeBreak : Break -> Jenc.Value
encodeBreak x =
    Jenc.object
        [ ("break", Jenc.int x.break)
        ]

bycopy : Jdec.Decoder Bycopy
bycopy =
    Jdec.succeed Bycopy
        |> Jpipe.required "bycopy" Jdec.int

encodeBycopy : Bycopy -> Jenc.Value
encodeBycopy x =
    Jenc.object
        [ ("bycopy", Jenc.int x.bycopy)
        ]

byref : Jdec.Decoder Byref
byref =
    Jdec.succeed Byref
        |> Jpipe.required "byref" Jdec.int

encodeByref : Byref -> Jenc.Value
encodeByref x =
    Jenc.object
        [ ("byref", Jenc.int x.byref)
        ]

byte : Jdec.Decoder Byte
byte =
    Jdec.succeed Byte
        |> Jpipe.required "byte" Jdec.int

encodeByte : Byte -> Jenc.Value
encodeByte x =
    Jenc.object
        [ ("byte", Jenc.int x.byte)
        ]

calendar : Jdec.Decoder Calendar
calendar =
    Jdec.succeed Calendar
        |> Jpipe.required "Calendar" Jdec.int

encodeCalendar : Calendar -> Jenc.Value
encodeCalendar x =
    Jenc.object
        [ ("Calendar", Jenc.int x.calendar)
        ]

catch : Jdec.Decoder Catch
catch =
    Jdec.succeed Catch
        |> Jpipe.required "catch" Jdec.int

encodeCatch : Catch -> Jenc.Value
encodeCatch x =
    Jenc.object
        [ ("catch", Jenc.int x.catch)
        ]

chan : Jdec.Decoder Chan
chan =
    Jdec.succeed Chan
        |> Jpipe.required "chan" Jdec.int

encodeChan : Chan -> Jenc.Value
encodeChan x =
    Jenc.object
        [ ("chan", Jenc.int x.chan)
        ]

char : Jdec.Decoder Char
char =
    Jdec.succeed Char
        |> Jpipe.required "char" Jdec.int

encodeChar : Char -> Jenc.Value
encodeChar x =
    Jenc.object
        [ ("char", Jenc.int x.char)
        ]

char16T : Jdec.Decoder Char16T
char16T =
    Jdec.succeed Char16T
        |> Jpipe.required "char16_t" Jdec.int

encodeChar16T : Char16T -> Jenc.Value
encodeChar16T x =
    Jenc.object
        [ ("char16_t", Jenc.int x.char16T)
        ]

char32T : Jdec.Decoder Char32T
char32T =
    Jdec.succeed Char32T
        |> Jpipe.required "char32_t" Jdec.int

encodeChar32T : Char32T -> Jenc.Value
encodeChar32T x =
    Jenc.object
        [ ("char32_t", Jenc.int x.char32T)
        ]

checked : Jdec.Decoder Checked
checked =
    Jdec.succeed Checked
        |> Jpipe.required "checked" Jdec.int

encodeChecked : Checked -> Jenc.Value
encodeChecked x =
    Jenc.object
        [ ("checked", Jenc.int x.checked)
        ]

class : Jdec.Decoder Class
class =
    Jdec.succeed Class
        |> Jpipe.required "Class" Jdec.int

encodeClass : Class -> Jenc.Value
encodeClass x =
    Jenc.object
        [ ("Class", Jenc.int x.class)
        ]

clone : Jdec.Decoder Clone
clone =
    Jdec.succeed Clone
        |> Jpipe.required "clone" Jdec.int

encodeClone : Clone -> Jenc.Value
encodeClone x =
    Jenc.object
        [ ("clone", Jenc.int x.clone)
        ]

coAwait : Jdec.Decoder CoAwait
coAwait =
    Jdec.succeed CoAwait
        |> Jpipe.required "co_await" Jdec.int

encodeCoAwait : CoAwait -> Jenc.Value
encodeCoAwait x =
    Jenc.object
        [ ("co_await", Jenc.int x.coAwait)
        ]

coReturn : Jdec.Decoder CoReturn
coReturn =
    Jdec.succeed CoReturn
        |> Jpipe.required "co_return" Jdec.int

encodeCoReturn : CoReturn -> Jenc.Value
encodeCoReturn x =
    Jenc.object
        [ ("co_return", Jenc.int x.coReturn)
        ]

coYield : Jdec.Decoder CoYield
coYield =
    Jdec.succeed CoYield
        |> Jpipe.required "co_yield" Jdec.int

encodeCoYield : CoYield -> Jenc.Value
encodeCoYield x =
    Jenc.object
        [ ("co_yield", Jenc.int x.coYield)
        ]

codable : Jdec.Decoder Codable
codable =
    Jdec.succeed Codable
        |> Jpipe.required "Codable" Jdec.int

encodeCodable : Codable -> Jenc.Value
encodeCodable x =
    Jenc.object
        [ ("Codable", Jenc.int x.codable)
        ]

codingKey : Jdec.Decoder CodingKey
codingKey =
    Jdec.succeed CodingKey
        |> Jpipe.required "CodingKey" Jdec.int

encodeCodingKey : CodingKey -> Jenc.Value
encodeCodingKey x =
    Jenc.object
        [ ("CodingKey", Jenc.int x.codingKey)
        ]

codingKeys : Jdec.Decoder CodingKeys
codingKeys =
    Jdec.succeed CodingKeys
        |> Jpipe.required "CodingKeys" Jdec.int

encodeCodingKeys : CodingKeys -> Jenc.Value
encodeCodingKeys x =
    Jenc.object
        [ ("CodingKeys", Jenc.int x.codingKeys)
        ]

compl : Jdec.Decoder Compl
compl =
    Jdec.succeed Compl
        |> Jpipe.required "compl" Jdec.int

encodeCompl : Compl -> Jenc.Value
encodeCompl x =
    Jenc.object
        [ ("compl", Jenc.int x.compl)
        ]

complex : Jdec.Decoder Complex
complex =
    Jdec.succeed Complex
        |> Jpipe.required "_Complex" Jdec.int

encodeComplex : Complex -> Jenc.Value
encodeComplex x =
    Jenc.object
        [ ("_Complex", Jenc.int x.complex)
        ]

concept : Jdec.Decoder Concept
concept =
    Jdec.succeed Concept
        |> Jpipe.required "concept" Jdec.int

encodeConcept : Concept -> Jenc.Value
encodeConcept x =
    Jenc.object
        [ ("concept", Jenc.int x.concept)
        ]

console : Jdec.Decoder Console
console =
    Jdec.succeed Console
        |> Jpipe.required "console" Jdec.int

encodeConsole : Console -> Jenc.Value
encodeConsole x =
    Jenc.object
        [ ("console", Jenc.int x.console)
        ]

const : Jdec.Decoder Const
const =
    Jdec.succeed Const
        |> Jpipe.required "const" Jdec.int

encodeConst : Const -> Jenc.Value
encodeConst x =
    Jenc.object
        [ ("const", Jenc.int x.const)
        ]

constCast : Jdec.Decoder ConstCast
constCast =
    Jdec.succeed ConstCast
        |> Jpipe.required "const_cast" Jdec.int

encodeConstCast : ConstCast -> Jenc.Value
encodeConstCast x =
    Jenc.object
        [ ("const_cast", Jenc.int x.constCast)
        ]

constexpr : Jdec.Decoder Constexpr
constexpr =
    Jdec.succeed Constexpr
        |> Jpipe.required "constexpr" Jdec.int

encodeConstexpr : Constexpr -> Jenc.Value
encodeConstexpr x =
    Jenc.object
        [ ("constexpr", Jenc.int x.constexpr)
        ]

constructor : Jdec.Decoder Constructor
constructor =
    Jdec.succeed Constructor
        |> Jpipe.required "constructor" Jdec.int

encodeConstructor : Constructor -> Jenc.Value
encodeConstructor x =
    Jenc.object
        [ ("constructor", Jenc.int x.constructor)
        ]

continue : Jdec.Decoder Continue
continue =
    Jdec.succeed Continue
        |> Jpipe.required "continue" Jdec.int

encodeContinue : Continue -> Jenc.Value
encodeContinue x =
    Jenc.object
        [ ("continue", Jenc.int x.continue)
        ]

convenience : Jdec.Decoder Convenience
convenience =
    Jdec.succeed Convenience
        |> Jpipe.required "convenience" Jdec.int

encodeConvenience : Convenience -> Jenc.Value
encodeConvenience x =
    Jenc.object
        [ ("convenience", Jenc.int x.convenience)
        ]

convert : Jdec.Decoder Convert
convert =
    Jdec.succeed Convert
        |> Jpipe.required "convert" Jdec.int

encodeConvert : Convert -> Jenc.Value
encodeConvert x =
    Jenc.object
        [ ("convert", Jenc.int x.convert)
        ]

converter : Jdec.Decoder Converter
converter =
    Jdec.succeed Converter
        |> Jpipe.required "converter" Jdec.int

encodeConverter : Converter -> Jenc.Value
encodeConverter x =
    Jenc.object
        [ ("converter", Jenc.int x.converter)
        ]

empty : Jdec.Decoder Empty
empty =
    Jdec.succeed Empty
        |> Jpipe.required "_" Jdec.int

encodeEmpty : Empty -> Jenc.Value
encodeEmpty x =
    Jenc.object
        [ ("_", Jenc.int x.empty)
        ]

imaginery : Jdec.Decoder Imaginery
imaginery =
    Jdec.succeed Imaginery
        |> Jpipe.required "_Imaginery" Jdec.int

encodeImaginery : Imaginery -> Jenc.Value
encodeImaginery x =
    Jenc.object
        [ ("_Imaginery", Jenc.int x.imaginery)
        ]

anyClass : Jdec.Decoder AnyClass
anyClass =
    Jdec.succeed AnyClass
        |> Jpipe.required "any" Jdec.int

encodeAnyClass : AnyClass -> Jenc.Value
encodeAnyClass x =
    Jenc.object
        [ ("any", Jenc.int x.any)
        ]

purpleAs : Jdec.Decoder As
purpleAs =
    Jdec.succeed As
        |> Jpipe.required "as" Jdec.int

encodeAs : As -> Jenc.Value
encodeAs x =
    Jenc.object
        [ ("as", Jenc.int x.asAs)
        ]

purpleBool : Jdec.Decoder Bool
purpleBool =
    Jdec.succeed Bool
        |> Jpipe.required "BOOL" Jdec.int

encodeBool : Bool -> Jenc.Value
encodeBool x =
    Jenc.object
        [ ("BOOL", Jenc.int x.boolBool)
        ]

boolClass : Jdec.Decoder BoolClass
boolClass =
    Jdec.succeed BoolClass
        |> Jpipe.required "_Bool" Jdec.int

encodeBoolClass : BoolClass -> Jenc.Value
encodeBoolClass x =
    Jenc.object
        [ ("_Bool", Jenc.int x.boolBool)
        ]

purpleCase : Jdec.Decoder Case
purpleCase =
    Jdec.succeed Case
        |> Jpipe.required "case" Jdec.int

encodeCase : Case -> Jenc.Value
encodeCase x =
    Jenc.object
        [ ("case", Jenc.int x.caseCase)
        ]

classClass : Jdec.Decoder ClassClass
classClass =
    Jdec.succeed ClassClass
        |> Jpipe.required "class" Jdec.int

encodeClassClass : ClassClass -> Jenc.Value
encodeClassClass x =
    Jenc.object
        [ ("class", Jenc.int x.class)
        ]

obj1Bool : Jdec.Decoder Obj1Bool
obj1Bool =
    Jdec.succeed Obj1Bool
        |> Jpipe.required "bool" Jdec.int

encodeObj1Bool : Obj1Bool -> Jenc.Value
encodeObj1Bool x =
    Jenc.object
        [ ("bool", Jenc.int x.boolBool)
        ]

obj2 : Jdec.Decoder Obj2
obj2 =
    Jdec.succeed Obj2
        |> Jpipe.required "CultureInfo" cultureInfo
        |> Jpipe.required "date" date
        |> Jpipe.required "DateFormatter" dateFormatter
        |> Jpipe.required "DateOnly" dateOnly
        |> Jpipe.required "DateOnlyConverter" dateOnlyConverter
        |> Jpipe.required "date_parse_handling" dateParseHandling
        |> Jpipe.required "DateTime" dateTime
        |> Jpipe.required "DateTimeStyles" dateTimeStyles
        |> Jpipe.required "debugger" debugger
        |> Jpipe.required "decimal" decimal
        |> Jpipe.required "declare" declare
        |> Jpipe.required "decltype" decltype
        |> Jpipe.required "decode_string" decodeString
        |> Jpipe.required "DecodingError" decodingError
        |> Jpipe.required "def" def
        |> Jpipe.required "default" default
        |> Jpipe.required "defer" defer
        |> Jpipe.required "deinit" deinit
        |> Jpipe.required "del" del
        |> Jpipe.required "delegate" delegate
        |> Jpipe.required "delete" delete
        |> Jpipe.required "DeserializationFeature" deserializationFeature
        |> Jpipe.required "dict" dictClass
        |> Jpipe.required "dictionary" dictionary
        |> Jpipe.required "didSet" didSet
        |> Jpipe.required "do" do
        |> Jpipe.required "double" double
        |> Jpipe.required "DoubleNode" doubleNode
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "dynamic" dynamic
        |> Jpipe.required "dynamic_cast" dynamicCast
        |> Jpipe.required "elif" elif
        |> Jpipe.required "encode_quick_type" purpleEncodeQuickType
        |> Jpipe.required "Encoder" encoder
        |> Jpipe.required "enum" enum
        |> Jpipe.required "EnumValues" enumValues
        |> Jpipe.required "equalityContract" equalityContract
        |> Jpipe.required "Equatable" equatable
        |> Jpipe.required "event" event
        |> Jpipe.required "except" except
        |> Jpipe.required "exception" exception
        |> Jpipe.required "explicit" explicit
        |> Jpipe.required "export" export
        |> Jpipe.required "extends" extends
        |> Jpipe.required "extension" extension
        |> Jpipe.required "extern" extern
        |> Jpipe.required "fallthrough" fallthrough
        |> Jpipe.required "False" falseClass
        |> Jpipe.required "fileprivate" fileprivate
        |> Jpipe.required "final" final
        |> Jpipe.required "finally" finally
        |> Jpipe.required "fixed" fixed
        |> Jpipe.required "for" for
        |> Jpipe.required "foreach" foreach
        |> Jpipe.required "FormatException" formatException
        |> Jpipe.required "friend" friend
        |> Jpipe.required "from" from
        |> Jpipe.required "from_dict" fromDict
        |> Jpipe.required "from_json" fromJSON
        |> Jpipe.required "func" func
        |> Jpipe.required "Decoder" purpleDecoder
        |> Jpipe.required "else" purpleElse
        |> Jpipe.required "exposing" purpleExposing
        |> Jpipe.required "false" obj2False
        |> Jpipe.required "float" floatClass

encodeObj2 : Obj2 -> Jenc.Value
encodeObj2 x =
    Jenc.object
        [ ("CultureInfo", encodeCultureInfo x.cultureInfo)
        , ("date", encodeDate x.date)
        , ("DateFormatter", encodeDateFormatter x.dateFormatter)
        , ("DateOnly", encodeDateOnly x.dateOnly)
        , ("DateOnlyConverter", encodeDateOnlyConverter x.dateOnlyConverter)
        , ("date_parse_handling", encodeDateParseHandling x.dateParseHandling)
        , ("DateTime", encodeDateTime x.dateTime)
        , ("DateTimeStyles", encodeDateTimeStyles x.dateTimeStyles)
        , ("debugger", encodeDebugger x.debugger)
        , ("decimal", encodeDecimal x.decimal)
        , ("declare", encodeDeclare x.declare)
        , ("decltype", encodeDecltype x.decltype)
        , ("decode_string", encodeDecodeString x.decodeString)
        , ("DecodingError", encodeDecodingError x.decodingError)
        , ("def", encodeDef x.def)
        , ("default", encodeDefault x.default)
        , ("defer", encodeDefer x.defer)
        , ("deinit", encodeDeinit x.deinit)
        , ("del", encodeDel x.del)
        , ("delegate", encodeDelegate x.delegate)
        , ("delete", encodeDelete x.delete)
        , ("DeserializationFeature", encodeDeserializationFeature x.deserializationFeature)
        , ("dict", encodeDictClass x.dict)
        , ("dictionary", encodeDictionary x.dictionary)
        , ("didSet", encodeDidSet x.didSet)
        , ("do", encodeDo x.do)
        , ("double", encodeDouble x.double)
        , ("DoubleNode", encodeDoubleNode x.doubleNode)
        , ("dummy", Jenc.int x.dummy)
        , ("dynamic", encodeDynamic x.dynamic)
        , ("dynamic_cast", encodeDynamicCast x.dynamicCast)
        , ("elif", encodeElif x.elif)
        , ("encode_quick_type", encodeEncodeQuickType x.encodeQuickType)
        , ("Encoder", encodeEncoder x.encoder)
        , ("enum", encodeEnum x.enum)
        , ("EnumValues", encodeEnumValues x.enumValues)
        , ("equalityContract", encodeEqualityContract x.equalityContract)
        , ("Equatable", encodeEquatable x.equatable)
        , ("event", encodeEvent x.event)
        , ("except", encodeExcept x.except)
        , ("exception", encodeException x.exception)
        , ("explicit", encodeExplicit x.explicit)
        , ("export", encodeExport x.export)
        , ("extends", encodeExtends x.extends)
        , ("extension", encodeExtension x.extension)
        , ("extern", encodeExtern x.extern)
        , ("fallthrough", encodeFallthrough x.fallthrough)
        , ("False", encodeFalseClass x.false)
        , ("fileprivate", encodeFileprivate x.fileprivate)
        , ("final", encodeFinal x.final)
        , ("finally", encodeFinally x.finally)
        , ("fixed", encodeFixed x.fixed)
        , ("for", encodeFor x.for)
        , ("foreach", encodeForeach x.foreach)
        , ("FormatException", encodeFormatException x.formatException)
        , ("friend", encodeFriend x.friend)
        , ("from", encodeFrom x.from)
        , ("from_dict", encodeFromDict x.fromDict)
        , ("from_json", encodeFromJSON x.fromJSON)
        , ("func", encodeFunc x.func)
        , ("Decoder", encodeDecoder x.obj2Decoder)
        , ("else", encodeElse x.obj2Else)
        , ("exposing", encodeExposing x.obj2Exposing)
        , ("false", encodeObj2False x.obj2False)
        , ("float", encodeFloatClass x.obj2Float)
        ]

cultureInfo : Jdec.Decoder CultureInfo
cultureInfo =
    Jdec.succeed CultureInfo
        |> Jpipe.required "CultureInfo" Jdec.int

encodeCultureInfo : CultureInfo -> Jenc.Value
encodeCultureInfo x =
    Jenc.object
        [ ("CultureInfo", Jenc.int x.cultureInfo)
        ]

date : Jdec.Decoder Date
date =
    Jdec.succeed Date
        |> Jpipe.required "date" Jdec.int

encodeDate : Date -> Jenc.Value
encodeDate x =
    Jenc.object
        [ ("date", Jenc.int x.date)
        ]

dateFormatter : Jdec.Decoder DateFormatter
dateFormatter =
    Jdec.succeed DateFormatter
        |> Jpipe.required "DateFormatter" Jdec.int

encodeDateFormatter : DateFormatter -> Jenc.Value
encodeDateFormatter x =
    Jenc.object
        [ ("DateFormatter", Jenc.int x.dateFormatter)
        ]

dateOnly : Jdec.Decoder DateOnly
dateOnly =
    Jdec.succeed DateOnly
        |> Jpipe.required "DateOnly" Jdec.int

encodeDateOnly : DateOnly -> Jenc.Value
encodeDateOnly x =
    Jenc.object
        [ ("DateOnly", Jenc.int x.dateOnly)
        ]

dateOnlyConverter : Jdec.Decoder DateOnlyConverter
dateOnlyConverter =
    Jdec.succeed DateOnlyConverter
        |> Jpipe.required "DateOnlyConverter" Jdec.int

encodeDateOnlyConverter : DateOnlyConverter -> Jenc.Value
encodeDateOnlyConverter x =
    Jenc.object
        [ ("DateOnlyConverter", Jenc.int x.dateOnlyConverter)
        ]

dateParseHandling : Jdec.Decoder DateParseHandling
dateParseHandling =
    Jdec.succeed DateParseHandling
        |> Jpipe.required "date_parse_handling" Jdec.int

encodeDateParseHandling : DateParseHandling -> Jenc.Value
encodeDateParseHandling x =
    Jenc.object
        [ ("date_parse_handling", Jenc.int x.dateParseHandling)
        ]

dateTime : Jdec.Decoder DateTime
dateTime =
    Jdec.succeed DateTime
        |> Jpipe.required "DateTime" Jdec.string

encodeDateTime : DateTime -> Jenc.Value
encodeDateTime x =
    Jenc.object
        [ ("DateTime", Jenc.string x.dateTime)
        ]

dateTimeStyles : Jdec.Decoder DateTimeStyles
dateTimeStyles =
    Jdec.succeed DateTimeStyles
        |> Jpipe.required "DateTimeStyles" Jdec.int

encodeDateTimeStyles : DateTimeStyles -> Jenc.Value
encodeDateTimeStyles x =
    Jenc.object
        [ ("DateTimeStyles", Jenc.int x.dateTimeStyles)
        ]

debugger : Jdec.Decoder Debugger
debugger =
    Jdec.succeed Debugger
        |> Jpipe.required "debugger" Jdec.int

encodeDebugger : Debugger -> Jenc.Value
encodeDebugger x =
    Jenc.object
        [ ("debugger", Jenc.int x.debugger)
        ]

decimal : Jdec.Decoder Decimal
decimal =
    Jdec.succeed Decimal
        |> Jpipe.required "decimal" Jdec.int

encodeDecimal : Decimal -> Jenc.Value
encodeDecimal x =
    Jenc.object
        [ ("decimal", Jenc.int x.decimal)
        ]

declare : Jdec.Decoder Declare
declare =
    Jdec.succeed Declare
        |> Jpipe.required "declare" Jdec.int

encodeDeclare : Declare -> Jenc.Value
encodeDeclare x =
    Jenc.object
        [ ("declare", Jenc.int x.declare)
        ]

decltype : Jdec.Decoder Decltype
decltype =
    Jdec.succeed Decltype
        |> Jpipe.required "decltype" Jdec.int

encodeDecltype : Decltype -> Jenc.Value
encodeDecltype x =
    Jenc.object
        [ ("decltype", Jenc.int x.decltype)
        ]

decodeString : Jdec.Decoder DecodeString
decodeString =
    Jdec.succeed DecodeString
        |> Jpipe.required "decode_string" Jdec.int

encodeDecodeString : DecodeString -> Jenc.Value
encodeDecodeString x =
    Jenc.object
        [ ("decode_string", Jenc.int x.decodeString)
        ]

decodingError : Jdec.Decoder DecodingError
decodingError =
    Jdec.succeed DecodingError
        |> Jpipe.required "DecodingError" Jdec.int

encodeDecodingError : DecodingError -> Jenc.Value
encodeDecodingError x =
    Jenc.object
        [ ("DecodingError", Jenc.int x.decodingError)
        ]

def : Jdec.Decoder Def
def =
    Jdec.succeed Def
        |> Jpipe.required "def" Jdec.int

encodeDef : Def -> Jenc.Value
encodeDef x =
    Jenc.object
        [ ("def", Jenc.int x.def)
        ]

default : Jdec.Decoder Default
default =
    Jdec.succeed Default
        |> Jpipe.required "default" Jdec.int

encodeDefault : Default -> Jenc.Value
encodeDefault x =
    Jenc.object
        [ ("default", Jenc.int x.default)
        ]

defer : Jdec.Decoder Defer
defer =
    Jdec.succeed Defer
        |> Jpipe.required "defer" Jdec.int

encodeDefer : Defer -> Jenc.Value
encodeDefer x =
    Jenc.object
        [ ("defer", Jenc.int x.defer)
        ]

deinit : Jdec.Decoder Deinit
deinit =
    Jdec.succeed Deinit
        |> Jpipe.required "deinit" Jdec.int

encodeDeinit : Deinit -> Jenc.Value
encodeDeinit x =
    Jenc.object
        [ ("deinit", Jenc.int x.deinit)
        ]

del : Jdec.Decoder Del
del =
    Jdec.succeed Del
        |> Jpipe.required "del" Jdec.int

encodeDel : Del -> Jenc.Value
encodeDel x =
    Jenc.object
        [ ("del", Jenc.int x.del)
        ]

delegate : Jdec.Decoder Delegate
delegate =
    Jdec.succeed Delegate
        |> Jpipe.required "delegate" Jdec.int

encodeDelegate : Delegate -> Jenc.Value
encodeDelegate x =
    Jenc.object
        [ ("delegate", Jenc.int x.delegate)
        ]

delete : Jdec.Decoder Delete
delete =
    Jdec.succeed Delete
        |> Jpipe.required "delete" Jdec.int

encodeDelete : Delete -> Jenc.Value
encodeDelete x =
    Jenc.object
        [ ("delete", Jenc.int x.delete)
        ]

deserializationFeature : Jdec.Decoder DeserializationFeature
deserializationFeature =
    Jdec.succeed DeserializationFeature
        |> Jpipe.required "DeserializationFeature" Jdec.int

encodeDeserializationFeature : DeserializationFeature -> Jenc.Value
encodeDeserializationFeature x =
    Jenc.object
        [ ("DeserializationFeature", Jenc.int x.deserializationFeature)
        ]

dictClass : Jdec.Decoder DictClass
dictClass =
    Jdec.succeed DictClass
        |> Jpipe.required "dict" Jdec.int

encodeDictClass : DictClass -> Jenc.Value
encodeDictClass x =
    Jenc.object
        [ ("dict", Jenc.int x.dict)
        ]

dictionary : Jdec.Decoder Dictionary
dictionary =
    Jdec.succeed Dictionary
        |> Jpipe.required "dictionary" Jdec.int

encodeDictionary : Dictionary -> Jenc.Value
encodeDictionary x =
    Jenc.object
        [ ("dictionary", Jenc.int x.dictionary)
        ]

didSet : Jdec.Decoder DidSet
didSet =
    Jdec.succeed DidSet
        |> Jpipe.required "didSet" Jdec.int

encodeDidSet : DidSet -> Jenc.Value
encodeDidSet x =
    Jenc.object
        [ ("didSet", Jenc.int x.didSet)
        ]

do : Jdec.Decoder Do
do =
    Jdec.succeed Do
        |> Jpipe.required "do" Jdec.int

encodeDo : Do -> Jenc.Value
encodeDo x =
    Jenc.object
        [ ("do", Jenc.int x.do)
        ]

double : Jdec.Decoder Double
double =
    Jdec.succeed Double
        |> Jpipe.required "double" Jdec.int

encodeDouble : Double -> Jenc.Value
encodeDouble x =
    Jenc.object
        [ ("double", Jenc.int x.double)
        ]

doubleNode : Jdec.Decoder DoubleNode
doubleNode =
    Jdec.succeed DoubleNode
        |> Jpipe.required "DoubleNode" Jdec.int

encodeDoubleNode : DoubleNode -> Jenc.Value
encodeDoubleNode x =
    Jenc.object
        [ ("DoubleNode", Jenc.int x.doubleNode)
        ]

dynamic : Jdec.Decoder Dynamic
dynamic =
    Jdec.succeed Dynamic
        |> Jpipe.required "dynamic" Jdec.int

encodeDynamic : Dynamic -> Jenc.Value
encodeDynamic x =
    Jenc.object
        [ ("dynamic", Jenc.int x.dynamic)
        ]

dynamicCast : Jdec.Decoder DynamicCast
dynamicCast =
    Jdec.succeed DynamicCast
        |> Jpipe.required "dynamic_cast" Jdec.int

encodeDynamicCast : DynamicCast -> Jenc.Value
encodeDynamicCast x =
    Jenc.object
        [ ("dynamic_cast", Jenc.int x.dynamicCast)
        ]

elif : Jdec.Decoder Elif
elif =
    Jdec.succeed Elif
        |> Jpipe.required "elif" Jdec.int

encodeElif : Elif -> Jenc.Value
encodeElif x =
    Jenc.object
        [ ("elif", Jenc.int x.elif)
        ]

purpleEncodeQuickType : Jdec.Decoder EncodeQuickType
purpleEncodeQuickType =
    Jdec.succeed EncodeQuickType
        |> Jpipe.required "encode_quick_type" Jdec.int

encodeEncodeQuickType : EncodeQuickType -> Jenc.Value
encodeEncodeQuickType x =
    Jenc.object
        [ ("encode_quick_type", Jenc.int x.encodeQuickType)
        ]

encoder : Jdec.Decoder Encoder
encoder =
    Jdec.succeed Encoder
        |> Jpipe.required "Encoder" Jdec.int

encodeEncoder : Encoder -> Jenc.Value
encodeEncoder x =
    Jenc.object
        [ ("Encoder", Jenc.int x.encoder)
        ]

enum : Jdec.Decoder Enum
enum =
    Jdec.succeed Enum
        |> Jpipe.required "enum" Jdec.int

encodeEnum : Enum -> Jenc.Value
encodeEnum x =
    Jenc.object
        [ ("enum", Jenc.int x.enum)
        ]

enumValues : Jdec.Decoder EnumValues
enumValues =
    Jdec.succeed EnumValues
        |> Jpipe.required "EnumValues" (Jdec.list enumValue )

encodeEnumValues : EnumValues -> Jenc.Value
encodeEnumValues x =
    Jenc.object
        [ ("EnumValues", Jenc.list encodeEnumValue x.enumValues)
        ]

enumValue : Jdec.Decoder EnumValue
enumValue =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "ready" -> Jdec.succeed Ready
                "done" -> Jdec.succeed Done
                somethingElse -> Jdec.fail <| "Invalid EnumValue: " ++ somethingElse
        )

encodeEnumValue : EnumValue -> Jenc.Value
encodeEnumValue x = case x of
    Ready -> Jenc.string "ready"
    Done -> Jenc.string "done"

equalityContract : Jdec.Decoder EqualityContract
equalityContract =
    Jdec.succeed EqualityContract
        |> Jpipe.required "equalityContract" Jdec.int

encodeEqualityContract : EqualityContract -> Jenc.Value
encodeEqualityContract x =
    Jenc.object
        [ ("equalityContract", Jenc.int x.equalityContract)
        ]

equatable : Jdec.Decoder Equatable
equatable =
    Jdec.succeed Equatable
        |> Jpipe.required "Equatable" Jdec.int

encodeEquatable : Equatable -> Jenc.Value
encodeEquatable x =
    Jenc.object
        [ ("Equatable", Jenc.int x.equatable)
        ]

event : Jdec.Decoder Event
event =
    Jdec.succeed Event
        |> Jpipe.required "event" Jdec.int

encodeEvent : Event -> Jenc.Value
encodeEvent x =
    Jenc.object
        [ ("event", Jenc.int x.event)
        ]

except : Jdec.Decoder Except
except =
    Jdec.succeed Except
        |> Jpipe.required "except" Jdec.int

encodeExcept : Except -> Jenc.Value
encodeExcept x =
    Jenc.object
        [ ("except", Jenc.int x.except)
        ]

exception : Jdec.Decoder Exception
exception =
    Jdec.succeed Exception
        |> Jpipe.required "exception" Jdec.int

encodeException : Exception -> Jenc.Value
encodeException x =
    Jenc.object
        [ ("exception", Jenc.int x.exception)
        ]

explicit : Jdec.Decoder Explicit
explicit =
    Jdec.succeed Explicit
        |> Jpipe.required "explicit" Jdec.int

encodeExplicit : Explicit -> Jenc.Value
encodeExplicit x =
    Jenc.object
        [ ("explicit", Jenc.int x.explicit)
        ]

export : Jdec.Decoder Export
export =
    Jdec.succeed Export
        |> Jpipe.required "export" Jdec.int

encodeExport : Export -> Jenc.Value
encodeExport x =
    Jenc.object
        [ ("export", Jenc.int x.export)
        ]

extends : Jdec.Decoder Extends
extends =
    Jdec.succeed Extends
        |> Jpipe.required "extends" Jdec.int

encodeExtends : Extends -> Jenc.Value
encodeExtends x =
    Jenc.object
        [ ("extends", Jenc.int x.extends)
        ]

extension : Jdec.Decoder Extension
extension =
    Jdec.succeed Extension
        |> Jpipe.required "extension" Jdec.int

encodeExtension : Extension -> Jenc.Value
encodeExtension x =
    Jenc.object
        [ ("extension", Jenc.int x.extension)
        ]

extern : Jdec.Decoder Extern
extern =
    Jdec.succeed Extern
        |> Jpipe.required "extern" Jdec.int

encodeExtern : Extern -> Jenc.Value
encodeExtern x =
    Jenc.object
        [ ("extern", Jenc.int x.extern)
        ]

fallthrough : Jdec.Decoder Fallthrough
fallthrough =
    Jdec.succeed Fallthrough
        |> Jpipe.required "fallthrough" Jdec.int

encodeFallthrough : Fallthrough -> Jenc.Value
encodeFallthrough x =
    Jenc.object
        [ ("fallthrough", Jenc.int x.fallthrough)
        ]

falseClass : Jdec.Decoder FalseClass
falseClass =
    Jdec.succeed FalseClass
        |> Jpipe.required "False" Jdec.int

encodeFalseClass : FalseClass -> Jenc.Value
encodeFalseClass x =
    Jenc.object
        [ ("False", Jenc.int x.false)
        ]

fileprivate : Jdec.Decoder Fileprivate
fileprivate =
    Jdec.succeed Fileprivate
        |> Jpipe.required "fileprivate" Jdec.int

encodeFileprivate : Fileprivate -> Jenc.Value
encodeFileprivate x =
    Jenc.object
        [ ("fileprivate", Jenc.int x.fileprivate)
        ]

final : Jdec.Decoder Final
final =
    Jdec.succeed Final
        |> Jpipe.required "final" Jdec.int

encodeFinal : Final -> Jenc.Value
encodeFinal x =
    Jenc.object
        [ ("final", Jenc.int x.final)
        ]

finally : Jdec.Decoder Finally
finally =
    Jdec.succeed Finally
        |> Jpipe.required "finally" Jdec.int

encodeFinally : Finally -> Jenc.Value
encodeFinally x =
    Jenc.object
        [ ("finally", Jenc.int x.finally)
        ]

fixed : Jdec.Decoder Fixed
fixed =
    Jdec.succeed Fixed
        |> Jpipe.required "fixed" Jdec.int

encodeFixed : Fixed -> Jenc.Value
encodeFixed x =
    Jenc.object
        [ ("fixed", Jenc.int x.fixed)
        ]

for : Jdec.Decoder For
for =
    Jdec.succeed For
        |> Jpipe.required "for" Jdec.int

encodeFor : For -> Jenc.Value
encodeFor x =
    Jenc.object
        [ ("for", Jenc.int x.for)
        ]

foreach : Jdec.Decoder Foreach
foreach =
    Jdec.succeed Foreach
        |> Jpipe.required "foreach" Jdec.int

encodeForeach : Foreach -> Jenc.Value
encodeForeach x =
    Jenc.object
        [ ("foreach", Jenc.int x.foreach)
        ]

formatException : Jdec.Decoder FormatException
formatException =
    Jdec.succeed FormatException
        |> Jpipe.required "FormatException" Jdec.int

encodeFormatException : FormatException -> Jenc.Value
encodeFormatException x =
    Jenc.object
        [ ("FormatException", Jenc.int x.formatException)
        ]

friend : Jdec.Decoder Friend
friend =
    Jdec.succeed Friend
        |> Jpipe.required "friend" Jdec.int

encodeFriend : Friend -> Jenc.Value
encodeFriend x =
    Jenc.object
        [ ("friend", Jenc.int x.friend)
        ]

from : Jdec.Decoder From
from =
    Jdec.succeed From
        |> Jpipe.required "from" Jdec.int

encodeFrom : From -> Jenc.Value
encodeFrom x =
    Jenc.object
        [ ("from", Jenc.int x.from)
        ]

fromDict : Jdec.Decoder FromDict
fromDict =
    Jdec.succeed FromDict
        |> Jpipe.required "from_dict" Jdec.int

encodeFromDict : FromDict -> Jenc.Value
encodeFromDict x =
    Jenc.object
        [ ("from_dict", Jenc.int x.fromDict)
        ]

fromJSON : Jdec.Decoder FromJSON
fromJSON =
    Jdec.succeed FromJSON
        |> Jpipe.required "from_json" Jdec.int

encodeFromJSON : FromJSON -> Jenc.Value
encodeFromJSON x =
    Jenc.object
        [ ("from_json", Jenc.int x.fromJSON)
        ]

func : Jdec.Decoder Func
func =
    Jdec.succeed Func
        |> Jpipe.required "func" Jdec.int

encodeFunc : Func -> Jenc.Value
encodeFunc x =
    Jenc.object
        [ ("func", Jenc.int x.func)
        ]

purpleDecoder : Jdec.Decoder Decoder
purpleDecoder =
    Jdec.succeed Decoder
        |> Jpipe.required "Decoder" Jdec.int

encodeDecoder : Decoder -> Jenc.Value
encodeDecoder x =
    Jenc.object
        [ ("Decoder", Jenc.int x.decoderDecoder)
        ]

purpleElse : Jdec.Decoder Else
purpleElse =
    Jdec.succeed Else
        |> Jpipe.required "else" Jdec.int

encodeElse : Else -> Jenc.Value
encodeElse x =
    Jenc.object
        [ ("else", Jenc.int x.elseElse)
        ]

purpleExposing : Jdec.Decoder Exposing
purpleExposing =
    Jdec.succeed Exposing
        |> Jpipe.required "exposing" Jdec.int

encodeExposing : Exposing -> Jenc.Value
encodeExposing x =
    Jenc.object
        [ ("exposing", Jenc.int x.exposingExposing)
        ]

obj2False : Jdec.Decoder Obj2False
obj2False =
    Jdec.succeed Obj2False
        |> Jpipe.required "false" Jdec.int

encodeObj2False : Obj2False -> Jenc.Value
encodeObj2False x =
    Jenc.object
        [ ("false", Jenc.int x.false)
        ]

floatClass : Jdec.Decoder FloatClass
floatClass =
    Jdec.succeed FloatClass
        |> Jpipe.required "float" Jdec.int

encodeFloatClass : FloatClass -> Jenc.Value
encodeFloatClass x =
    Jenc.object
        [ ("float", Jenc.int x.floatFloat)
        ]

obj3 : Jdec.Decoder Obj3
obj3 =
    Jdec.succeed Obj3
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "function" function
        |> Jpipe.required "get" get
        |> Jpipe.required "global" global
        |> Jpipe.required "go" go
        |> Jpipe.required "goto" goto
        |> Jpipe.required "guard" guard
        |> Jpipe.required "hasOwnProperty" hasOwnProperty
        |> Jpipe.required "hashCode" hashCode
        |> Jpipe.required "Hashable" hashable
        |> Jpipe.required "Hasher" hasher
        |> Jpipe.required "id" id
        |> Jpipe.required "IMP" imp
        |> Jpipe.required "implements" implements
        |> Jpipe.required "implicit" implicit
        |> Jpipe.required "indirect" indirect
        |> Jpipe.required "init" init
        |> Jpipe.required "inline" inline
        |> Jpipe.required "inout" inout
        |> Jpipe.required "instanceof" instanceof
        |> Jpipe.required "IntNode" intNode
        |> Jpipe.required "interface" interface
        |> Jpipe.required "internal" internal
        |> Jpipe.required "is" is
        |> Jpipe.required "IsoDateTimeOffsetConverter" isoDateTimeOffsetConverter
        |> Jpipe.required "iterable" iterable
        |> Jpipe.required "jdec" jdecClass
        |> Jpipe.required "jenc" jencClass
        |> Jpipe.required "jpipe" jpipeClass
        |> Jpipe.required "json" json
        |> Jpipe.required "JSONAny" jsonAny
        |> Jpipe.required "JSONCodingKey" jsonCodingKey
        |> Jpipe.required "json_converter" jsonConverter
        |> Jpipe.required "JSONDecoder" jsonDecoder
        |> Jpipe.required "JSONEncoder" jsonEncoder
        |> Jpipe.required "JsonException" jsonException
        |> Jpipe.required "JsonGenerator" jsonGenerator
        |> Jpipe.required "JsonNode" jsonNode
        |> Jpipe.required "JSONNull" jsonNull
        |> Jpipe.required "JsonParser" jsonParser
        |> Jpipe.required "JsonReader" jsonReader
        |> Jpipe.required "json_serializer" jsonSerializer
        |> Jpipe.required "json_token" jsonToken
        |> Jpipe.required "JsonTokenType" jsonTokenType
        |> Jpipe.required "json_writer" jsonWriter
        |> Jpipe.required "lambda" lambda
        |> Jpipe.required "lazy" lazy
        |> Jpipe.required "left" left
        |> Jpipe.required "list" listClass
        |> Jpipe.required "LocalDate" localDate
        |> Jpipe.required "Locale" locale
        |> Jpipe.required "lock" lock
        |> Jpipe.required "long" long
        |> Jpipe.required "LongNode" longNode
        |> Jpipe.required "map" map
        |> Jpipe.required "MapEntry" mapEntry
        |> Jpipe.required "MarshalJSON" marshalJSON
        |> Jpipe.required "metadata_property_handling" metadataPropertyHandling
        |> Jpipe.required "if" purpleIf
        |> Jpipe.required "import" purpleImport
        |> Jpipe.required "in" purpleIn
        |> Jpipe.required "infix" purpleInfix
        |> Jpipe.required "int" intClass
        |> Jpipe.required "let" purpleLet
        |> Jpipe.required "module" purpleModule

encodeObj3 : Obj3 -> Jenc.Value
encodeObj3 x =
    Jenc.object
        [ ("dummy", Jenc.int x.dummy)
        , ("function", encodeFunction x.function)
        , ("get", encodeGet x.get)
        , ("global", encodeGlobal x.global)
        , ("go", encodeGo x.go)
        , ("goto", encodeGoto x.goto)
        , ("guard", encodeGuard x.guard)
        , ("hasOwnProperty", encodeHasOwnProperty x.hasOwnProperty)
        , ("hashCode", encodeHashCode x.hashCode)
        , ("Hashable", encodeHashable x.hashable)
        , ("Hasher", encodeHasher x.hasher)
        , ("id", encodeID x.id)
        , ("IMP", encodeImp x.imp)
        , ("implements", encodeImplements x.implements)
        , ("implicit", encodeImplicit x.implicit)
        , ("indirect", encodeIndirect x.indirect)
        , ("init", encodeInit x.init)
        , ("inline", encodeInline x.inline)
        , ("inout", encodeInout x.inout)
        , ("instanceof", encodeInstanceof x.instanceof)
        , ("IntNode", encodeIntNode x.intNode)
        , ("interface", encodeInterface x.interface)
        , ("internal", encodeInternal x.internal)
        , ("is", encodeIs x.is)
        , ("IsoDateTimeOffsetConverter", encodeISODateTimeOffsetConverter x.isoDateTimeOffsetConverter)
        , ("iterable", encodeIterable x.iterable)
        , ("jdec", encodeJdecClass x.jdec)
        , ("jenc", encodeJencClass x.jenc)
        , ("jpipe", encodeJpipeClass x.jpipe)
        , ("json", encodeJSON x.json)
        , ("JSONAny", encodeJSONAny x.jsonAny)
        , ("JSONCodingKey", encodeJSONCodingKey x.jsonCodingKey)
        , ("json_converter", encodeJSONConverter x.jsonConverter)
        , ("JSONDecoder", encodeJSONDecoder x.jsonDecoder)
        , ("JSONEncoder", encodeJSONEncoder x.jsonEncoder)
        , ("JsonException", encodeJSONException x.jsonException)
        , ("JsonGenerator", encodeJSONGenerator x.jsonGenerator)
        , ("JsonNode", encodeJSONNode x.jsonNode)
        , ("JSONNull", encodeJSONNull x.jsonNull)
        , ("JsonParser", encodeJSONParser x.jsonParser)
        , ("JsonReader", encodeJSONReader x.jsonReader)
        , ("json_serializer", encodeJSONSerializer x.jsonSerializer)
        , ("json_token", encodeJSONToken x.jsonToken)
        , ("JsonTokenType", encodeJSONTokenType x.jsonTokenType)
        , ("json_writer", encodeJSONWriter x.jsonWriter)
        , ("lambda", encodeLambda x.lambda)
        , ("lazy", encodeLazy x.lazy)
        , ("left", encodeLeft x.left)
        , ("list", encodeListClass x.list)
        , ("LocalDate", encodeLocalDate x.localDate)
        , ("Locale", encodeLocale x.locale)
        , ("lock", encodeLock x.lock)
        , ("long", encodeLong x.long)
        , ("LongNode", encodeLongNode x.longNode)
        , ("map", encodeMap x.map)
        , ("MapEntry", encodeMapEntry x.mapEntry)
        , ("MarshalJSON", encodeMarshalJSON x.marshalJSON)
        , ("metadata_property_handling", encodeMetadataPropertyHandling x.metadataPropertyHandling)
        , ("if", encodeIf x.obj3If)
        , ("import", encodeImport x.obj3Import)
        , ("in", encodeIn x.obj3In)
        , ("infix", encodeInfix x.obj3Infix)
        , ("int", encodeIntClass x.obj3Int)
        , ("let", encodeLet x.obj3Let)
        , ("module", encodeModule x.obj3Module)
        ]

function : Jdec.Decoder Function
function =
    Jdec.succeed Function
        |> Jpipe.required "function" Jdec.int

encodeFunction : Function -> Jenc.Value
encodeFunction x =
    Jenc.object
        [ ("function", Jenc.int x.function)
        ]

get : Jdec.Decoder Get
get =
    Jdec.succeed Get
        |> Jpipe.required "get" Jdec.int

encodeGet : Get -> Jenc.Value
encodeGet x =
    Jenc.object
        [ ("get", Jenc.int x.get)
        ]

global : Jdec.Decoder Global
global =
    Jdec.succeed Global
        |> Jpipe.required "global" Jdec.int

encodeGlobal : Global -> Jenc.Value
encodeGlobal x =
    Jenc.object
        [ ("global", Jenc.int x.global)
        ]

go : Jdec.Decoder Go
go =
    Jdec.succeed Go
        |> Jpipe.required "go" Jdec.int

encodeGo : Go -> Jenc.Value
encodeGo x =
    Jenc.object
        [ ("go", Jenc.int x.go)
        ]

goto : Jdec.Decoder Goto
goto =
    Jdec.succeed Goto
        |> Jpipe.required "goto" Jdec.int

encodeGoto : Goto -> Jenc.Value
encodeGoto x =
    Jenc.object
        [ ("goto", Jenc.int x.goto)
        ]

guard : Jdec.Decoder Guard
guard =
    Jdec.succeed Guard
        |> Jpipe.required "guard" Jdec.int

encodeGuard : Guard -> Jenc.Value
encodeGuard x =
    Jenc.object
        [ ("guard", Jenc.int x.guard)
        ]

hasOwnProperty : Jdec.Decoder HasOwnProperty
hasOwnProperty =
    Jdec.succeed HasOwnProperty
        |> Jpipe.required "hasOwnProperty" Jdec.int

encodeHasOwnProperty : HasOwnProperty -> Jenc.Value
encodeHasOwnProperty x =
    Jenc.object
        [ ("hasOwnProperty", Jenc.int x.hasOwnProperty)
        ]

hashCode : Jdec.Decoder HashCode
hashCode =
    Jdec.succeed HashCode
        |> Jpipe.required "hashCode" Jdec.int

encodeHashCode : HashCode -> Jenc.Value
encodeHashCode x =
    Jenc.object
        [ ("hashCode", Jenc.int x.hashCode)
        ]

hashable : Jdec.Decoder Hashable
hashable =
    Jdec.succeed Hashable
        |> Jpipe.required "Hashable" Jdec.int

encodeHashable : Hashable -> Jenc.Value
encodeHashable x =
    Jenc.object
        [ ("Hashable", Jenc.int x.hashable)
        ]

hasher : Jdec.Decoder Hasher
hasher =
    Jdec.succeed Hasher
        |> Jpipe.required "Hasher" Jdec.int

encodeHasher : Hasher -> Jenc.Value
encodeHasher x =
    Jenc.object
        [ ("Hasher", Jenc.int x.hasher)
        ]

id : Jdec.Decoder ID
id =
    Jdec.succeed ID
        |> Jpipe.required "id" Jdec.int

encodeID : ID -> Jenc.Value
encodeID x =
    Jenc.object
        [ ("id", Jenc.int x.id)
        ]

imp : Jdec.Decoder Imp
imp =
    Jdec.succeed Imp
        |> Jpipe.required "IMP" Jdec.int

encodeImp : Imp -> Jenc.Value
encodeImp x =
    Jenc.object
        [ ("IMP", Jenc.int x.imp)
        ]

implements : Jdec.Decoder Implements
implements =
    Jdec.succeed Implements
        |> Jpipe.required "implements" Jdec.int

encodeImplements : Implements -> Jenc.Value
encodeImplements x =
    Jenc.object
        [ ("implements", Jenc.int x.implements)
        ]

implicit : Jdec.Decoder Implicit
implicit =
    Jdec.succeed Implicit
        |> Jpipe.required "implicit" Jdec.int

encodeImplicit : Implicit -> Jenc.Value
encodeImplicit x =
    Jenc.object
        [ ("implicit", Jenc.int x.implicit)
        ]

indirect : Jdec.Decoder Indirect
indirect =
    Jdec.succeed Indirect
        |> Jpipe.required "indirect" Jdec.int

encodeIndirect : Indirect -> Jenc.Value
encodeIndirect x =
    Jenc.object
        [ ("indirect", Jenc.int x.indirect)
        ]

init : Jdec.Decoder Init
init =
    Jdec.succeed Init
        |> Jpipe.required "init" Jdec.int

encodeInit : Init -> Jenc.Value
encodeInit x =
    Jenc.object
        [ ("init", Jenc.int x.init)
        ]

inline : Jdec.Decoder Inline
inline =
    Jdec.succeed Inline
        |> Jpipe.required "inline" Jdec.int

encodeInline : Inline -> Jenc.Value
encodeInline x =
    Jenc.object
        [ ("inline", Jenc.int x.inline)
        ]

inout : Jdec.Decoder Inout
inout =
    Jdec.succeed Inout
        |> Jpipe.required "inout" Jdec.int

encodeInout : Inout -> Jenc.Value
encodeInout x =
    Jenc.object
        [ ("inout", Jenc.int x.inout)
        ]

instanceof : Jdec.Decoder Instanceof
instanceof =
    Jdec.succeed Instanceof
        |> Jpipe.required "instanceof" Jdec.int

encodeInstanceof : Instanceof -> Jenc.Value
encodeInstanceof x =
    Jenc.object
        [ ("instanceof", Jenc.int x.instanceof)
        ]

intNode : Jdec.Decoder IntNode
intNode =
    Jdec.succeed IntNode
        |> Jpipe.required "IntNode" Jdec.int

encodeIntNode : IntNode -> Jenc.Value
encodeIntNode x =
    Jenc.object
        [ ("IntNode", Jenc.int x.intNode)
        ]

interface : Jdec.Decoder Interface
interface =
    Jdec.succeed Interface
        |> Jpipe.required "interface" Jdec.int

encodeInterface : Interface -> Jenc.Value
encodeInterface x =
    Jenc.object
        [ ("interface", Jenc.int x.interface)
        ]

internal : Jdec.Decoder Internal
internal =
    Jdec.succeed Internal
        |> Jpipe.required "internal" Jdec.int

encodeInternal : Internal -> Jenc.Value
encodeInternal x =
    Jenc.object
        [ ("internal", Jenc.int x.internal)
        ]

is : Jdec.Decoder Is
is =
    Jdec.succeed Is
        |> Jpipe.required "is" Jdec.int

encodeIs : Is -> Jenc.Value
encodeIs x =
    Jenc.object
        [ ("is", Jenc.int x.is)
        ]

isoDateTimeOffsetConverter : Jdec.Decoder ISODateTimeOffsetConverter
isoDateTimeOffsetConverter =
    Jdec.succeed ISODateTimeOffsetConverter
        |> Jpipe.required "IsoDateTimeOffsetConverter" Jdec.int

encodeISODateTimeOffsetConverter : ISODateTimeOffsetConverter -> Jenc.Value
encodeISODateTimeOffsetConverter x =
    Jenc.object
        [ ("IsoDateTimeOffsetConverter", Jenc.int x.isoDateTimeOffsetConverter)
        ]

iterable : Jdec.Decoder Iterable
iterable =
    Jdec.succeed Iterable
        |> Jpipe.required "iterable" Jdec.int

encodeIterable : Iterable -> Jenc.Value
encodeIterable x =
    Jenc.object
        [ ("iterable", Jenc.int x.iterable)
        ]

jdecClass : Jdec.Decoder JdecClass
jdecClass =
    Jdec.succeed JdecClass
        |> Jpipe.required "jdec" Jdec.int

encodeJdecClass : JdecClass -> Jenc.Value
encodeJdecClass x =
    Jenc.object
        [ ("jdec", Jenc.int x.jdec)
        ]

jencClass : Jdec.Decoder JencClass
jencClass =
    Jdec.succeed JencClass
        |> Jpipe.required "jenc" Jdec.int

encodeJencClass : JencClass -> Jenc.Value
encodeJencClass x =
    Jenc.object
        [ ("jenc", Jenc.int x.jenc)
        ]

jpipeClass : Jdec.Decoder JpipeClass
jpipeClass =
    Jdec.succeed JpipeClass
        |> Jpipe.required "jpipe" Jdec.int

encodeJpipeClass : JpipeClass -> Jenc.Value
encodeJpipeClass x =
    Jenc.object
        [ ("jpipe", Jenc.int x.jpipe)
        ]

json : Jdec.Decoder JSON
json =
    Jdec.succeed JSON
        |> Jpipe.required "json" Jdec.int

encodeJSON : JSON -> Jenc.Value
encodeJSON x =
    Jenc.object
        [ ("json", Jenc.int x.json)
        ]

jsonAny : Jdec.Decoder JSONAny
jsonAny =
    Jdec.succeed JSONAny
        |> Jpipe.required "JSONAny" (Jdec.null ())

encodeJSONAny : JSONAny -> Jenc.Value
encodeJSONAny x =
    Jenc.object
        [ ("JSONAny", always Jenc.null x.jsonAny)
        ]

jsonCodingKey : Jdec.Decoder JSONCodingKey
jsonCodingKey =
    Jdec.succeed JSONCodingKey
        |> Jpipe.required "JSONCodingKey" Jdec.int

encodeJSONCodingKey : JSONCodingKey -> Jenc.Value
encodeJSONCodingKey x =
    Jenc.object
        [ ("JSONCodingKey", Jenc.int x.jsonCodingKey)
        ]

jsonConverter : Jdec.Decoder JSONConverter
jsonConverter =
    Jdec.succeed JSONConverter
        |> Jpipe.required "json_converter" Jdec.int

encodeJSONConverter : JSONConverter -> Jenc.Value
encodeJSONConverter x =
    Jenc.object
        [ ("json_converter", Jenc.int x.jsonConverter)
        ]

jsonDecoder : Jdec.Decoder JSONDecoder
jsonDecoder =
    Jdec.succeed JSONDecoder
        |> Jpipe.required "JSONDecoder" Jdec.int

encodeJSONDecoder : JSONDecoder -> Jenc.Value
encodeJSONDecoder x =
    Jenc.object
        [ ("JSONDecoder", Jenc.int x.jsonDecoder)
        ]

jsonEncoder : Jdec.Decoder JSONEncoder
jsonEncoder =
    Jdec.succeed JSONEncoder
        |> Jpipe.required "JSONEncoder" Jdec.int

encodeJSONEncoder : JSONEncoder -> Jenc.Value
encodeJSONEncoder x =
    Jenc.object
        [ ("JSONEncoder", Jenc.int x.jsonEncoder)
        ]

jsonException : Jdec.Decoder JSONException
jsonException =
    Jdec.succeed JSONException
        |> Jpipe.required "JsonException" Jdec.int

encodeJSONException : JSONException -> Jenc.Value
encodeJSONException x =
    Jenc.object
        [ ("JsonException", Jenc.int x.jsonException)
        ]

jsonGenerator : Jdec.Decoder JSONGenerator
jsonGenerator =
    Jdec.succeed JSONGenerator
        |> Jpipe.required "JsonGenerator" Jdec.int

encodeJSONGenerator : JSONGenerator -> Jenc.Value
encodeJSONGenerator x =
    Jenc.object
        [ ("JsonGenerator", Jenc.int x.jsonGenerator)
        ]

jsonNode : Jdec.Decoder JSONNode
jsonNode =
    Jdec.succeed JSONNode
        |> Jpipe.required "JsonNode" Jdec.int

encodeJSONNode : JSONNode -> Jenc.Value
encodeJSONNode x =
    Jenc.object
        [ ("JsonNode", Jenc.int x.jsonNode)
        ]

jsonNull : Jdec.Decoder JSONNull
jsonNull =
    Jdec.succeed JSONNull
        |> Jpipe.required "JSONNull" Jdec.int

encodeJSONNull : JSONNull -> Jenc.Value
encodeJSONNull x =
    Jenc.object
        [ ("JSONNull", Jenc.int x.jsonNull)
        ]

jsonParser : Jdec.Decoder JSONParser
jsonParser =
    Jdec.succeed JSONParser
        |> Jpipe.required "JsonParser" Jdec.int

encodeJSONParser : JSONParser -> Jenc.Value
encodeJSONParser x =
    Jenc.object
        [ ("JsonParser", Jenc.int x.jsonParser)
        ]

jsonReader : Jdec.Decoder JSONReader
jsonReader =
    Jdec.succeed JSONReader
        |> Jpipe.required "JsonReader" Jdec.int

encodeJSONReader : JSONReader -> Jenc.Value
encodeJSONReader x =
    Jenc.object
        [ ("JsonReader", Jenc.int x.jsonReader)
        ]

jsonSerializer : Jdec.Decoder JSONSerializer
jsonSerializer =
    Jdec.succeed JSONSerializer
        |> Jpipe.required "json_serializer" Jdec.int

encodeJSONSerializer : JSONSerializer -> Jenc.Value
encodeJSONSerializer x =
    Jenc.object
        [ ("json_serializer", Jenc.int x.jsonSerializer)
        ]

jsonToken : Jdec.Decoder JSONToken
jsonToken =
    Jdec.succeed JSONToken
        |> Jpipe.required "json_token" Jdec.int

encodeJSONToken : JSONToken -> Jenc.Value
encodeJSONToken x =
    Jenc.object
        [ ("json_token", Jenc.int x.jsonToken)
        ]

jsonTokenType : Jdec.Decoder JSONTokenType
jsonTokenType =
    Jdec.succeed JSONTokenType
        |> Jpipe.required "JsonTokenType" Jdec.int

encodeJSONTokenType : JSONTokenType -> Jenc.Value
encodeJSONTokenType x =
    Jenc.object
        [ ("JsonTokenType", Jenc.int x.jsonTokenType)
        ]

jsonWriter : Jdec.Decoder JSONWriter
jsonWriter =
    Jdec.succeed JSONWriter
        |> Jpipe.required "json_writer" Jdec.int

encodeJSONWriter : JSONWriter -> Jenc.Value
encodeJSONWriter x =
    Jenc.object
        [ ("json_writer", Jenc.int x.jsonWriter)
        ]

lambda : Jdec.Decoder Lambda
lambda =
    Jdec.succeed Lambda
        |> Jpipe.required "lambda" Jdec.int

encodeLambda : Lambda -> Jenc.Value
encodeLambda x =
    Jenc.object
        [ ("lambda", Jenc.int x.lambda)
        ]

lazy : Jdec.Decoder Lazy
lazy =
    Jdec.succeed Lazy
        |> Jpipe.required "lazy" Jdec.int

encodeLazy : Lazy -> Jenc.Value
encodeLazy x =
    Jenc.object
        [ ("lazy", Jenc.int x.lazy)
        ]

left : Jdec.Decoder Left
left =
    Jdec.succeed Left
        |> Jpipe.required "left" Jdec.int

encodeLeft : Left -> Jenc.Value
encodeLeft x =
    Jenc.object
        [ ("left", Jenc.int x.left)
        ]

listClass : Jdec.Decoder ListClass
listClass =
    Jdec.succeed ListClass
        |> Jpipe.required "list" Jdec.int

encodeListClass : ListClass -> Jenc.Value
encodeListClass x =
    Jenc.object
        [ ("list", Jenc.int x.list)
        ]

localDate : Jdec.Decoder LocalDate
localDate =
    Jdec.succeed LocalDate
        |> Jpipe.required "LocalDate" Jdec.int

encodeLocalDate : LocalDate -> Jenc.Value
encodeLocalDate x =
    Jenc.object
        [ ("LocalDate", Jenc.int x.localDate)
        ]

locale : Jdec.Decoder Locale
locale =
    Jdec.succeed Locale
        |> Jpipe.required "Locale" Jdec.int

encodeLocale : Locale -> Jenc.Value
encodeLocale x =
    Jenc.object
        [ ("Locale", Jenc.int x.locale)
        ]

lock : Jdec.Decoder Lock
lock =
    Jdec.succeed Lock
        |> Jpipe.required "lock" Jdec.int

encodeLock : Lock -> Jenc.Value
encodeLock x =
    Jenc.object
        [ ("lock", Jenc.int x.lock)
        ]

long : Jdec.Decoder Long
long =
    Jdec.succeed Long
        |> Jpipe.required "long" Jdec.int

encodeLong : Long -> Jenc.Value
encodeLong x =
    Jenc.object
        [ ("long", Jenc.int x.long)
        ]

longNode : Jdec.Decoder LongNode
longNode =
    Jdec.succeed LongNode
        |> Jpipe.required "LongNode" Jdec.int

encodeLongNode : LongNode -> Jenc.Value
encodeLongNode x =
    Jenc.object
        [ ("LongNode", Jenc.int x.longNode)
        ]

map : Jdec.Decoder Map
map =
    Jdec.succeed Map
        |> Jpipe.required "map" Jdec.int

encodeMap : Map -> Jenc.Value
encodeMap x =
    Jenc.object
        [ ("map", Jenc.int x.map)
        ]

mapEntry : Jdec.Decoder MapEntry
mapEntry =
    Jdec.succeed MapEntry
        |> Jpipe.required "MapEntry" Jdec.int

encodeMapEntry : MapEntry -> Jenc.Value
encodeMapEntry x =
    Jenc.object
        [ ("MapEntry", Jenc.int x.mapEntry)
        ]

marshalJSON : Jdec.Decoder MarshalJSON
marshalJSON =
    Jdec.succeed MarshalJSON
        |> Jpipe.required "MarshalJSON" Jdec.int

encodeMarshalJSON : MarshalJSON -> Jenc.Value
encodeMarshalJSON x =
    Jenc.object
        [ ("MarshalJSON", Jenc.int x.marshalJSON)
        ]

metadataPropertyHandling : Jdec.Decoder MetadataPropertyHandling
metadataPropertyHandling =
    Jdec.succeed MetadataPropertyHandling
        |> Jpipe.required "metadata_property_handling" Jdec.int

encodeMetadataPropertyHandling : MetadataPropertyHandling -> Jenc.Value
encodeMetadataPropertyHandling x =
    Jenc.object
        [ ("metadata_property_handling", Jenc.int x.metadataPropertyHandling)
        ]

purpleIf : Jdec.Decoder If
purpleIf =
    Jdec.succeed If
        |> Jpipe.required "if" Jdec.int

encodeIf : If -> Jenc.Value
encodeIf x =
    Jenc.object
        [ ("if", Jenc.int x.ifIf)
        ]

purpleImport : Jdec.Decoder Import
purpleImport =
    Jdec.succeed Import
        |> Jpipe.required "import" Jdec.int

encodeImport : Import -> Jenc.Value
encodeImport x =
    Jenc.object
        [ ("import", Jenc.int x.importImport)
        ]

purpleIn : Jdec.Decoder In
purpleIn =
    Jdec.succeed In
        |> Jpipe.required "in" Jdec.int

encodeIn : In -> Jenc.Value
encodeIn x =
    Jenc.object
        [ ("in", Jenc.int x.inIn)
        ]

purpleInfix : Jdec.Decoder Infix
purpleInfix =
    Jdec.succeed Infix
        |> Jpipe.required "infix" Jdec.int

encodeInfix : Infix -> Jenc.Value
encodeInfix x =
    Jenc.object
        [ ("infix", Jenc.int x.infixInfix)
        ]

intClass : Jdec.Decoder IntClass
intClass =
    Jdec.succeed IntClass
        |> Jpipe.required "int" Jdec.int

encodeIntClass : IntClass -> Jenc.Value
encodeIntClass x =
    Jenc.object
        [ ("int", Jenc.int x.intInt)
        ]

purpleLet : Jdec.Decoder Let
purpleLet =
    Jdec.succeed Let
        |> Jpipe.required "let" Jdec.int

encodeLet : Let -> Jenc.Value
encodeLet x =
    Jenc.object
        [ ("let", Jenc.int x.letLet)
        ]

purpleModule : Jdec.Decoder Module
purpleModule =
    Jdec.succeed Module
        |> Jpipe.required "module" Jdec.int

encodeModule : Module -> Jenc.Value
encodeModule x =
    Jenc.object
        [ ("module", Jenc.int x.moduleModule)
        ]

obj4 : Jdec.Decoder Obj4
obj4 =
    Jdec.succeed Obj4
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "mutable" mutable
        |> Jpipe.required "mutating" mutating
        |> Jpipe.required "namespace" namespace
        |> Jpipe.required "native" native
        |> Jpipe.required "new" new
        |> Jpipe.required "newtonsoft" newtonsoft
        |> Jpipe.required "nil" nil
        |> Jpipe.required "NO" no
        |> Jpipe.required "noSuchMethod" noSuchMethod
        |> Jpipe.required "noexcept" noexcept
        |> Jpipe.required "nonatomic" nonatomic
        |> Jpipe.required "None" none
        |> Jpipe.required "nonlocal" nonlocal
        |> Jpipe.required "nonmutating" nonmutating
        |> Jpipe.required "not" not
        |> Jpipe.required "not_eq" notEq
        |> Jpipe.required "NSError" nsError
        |> Jpipe.required "NSObject" nsObject
        |> Jpipe.required "NSString" nsString
        |> Jpipe.required "NULL" null
        |> Jpipe.required "NullNode" nullNode
        |> Jpipe.required "nullptr" nullptr
        |> Jpipe.required "number" number
        |> Jpipe.required "none" noneClass
        |> Jpipe.required "null" nullClass
        |> Jpipe.required "of" purpleOf
        |> Jpipe.required "port" purplePort
        |> Jpipe.required "protocol" protocolClass
        |> Jpipe.required "object" object
        |> Jpipe.required "ObjectMapper" objectMapper
        |> Jpipe.required "ObjectNode" objectNode
        |> Jpipe.required "ObjectReader" objectReader
        |> Jpipe.required "ObjectWriter" objectWriter
        |> Jpipe.required "OffsetDateTime" offsetDateTime
        |> Jpipe.required "OffsetTime" offsetTime
        |> Jpipe.required "oneway" oneway
        |> Jpipe.required "open" open
        |> Jpipe.required "operator" operator
        |> Jpipe.required "optional" optional
        |> Jpipe.required "or" or
        |> Jpipe.required "or_eq" orEq
        |> Jpipe.required "out" out
        |> Jpipe.required "override" override
        |> Jpipe.required "package" package
        |> Jpipe.required "params" params
        |> Jpipe.required "pass" pass
        |> Jpipe.required "postfix" postfix
        |> Jpipe.required "precedence" precedence
        |> Jpipe.required "prefix" prefix
        |> Jpipe.required "print" print
        |> Jpipe.required "printMembers" printMembers
        |> Jpipe.required "printf" printf
        |> Jpipe.required "private" private
        |> Jpipe.required "protected" protected
        |> Jpipe.required "Protocol" protocol
        |> Jpipe.required "public" public
        |> Jpipe.required "quicktype" quicktype
        |> Jpipe.required "raise" raise
        |> Jpipe.required "range" range
        |> Jpipe.required "readonly" readonly
        |> Jpipe.required "ref" ref
        |> Jpipe.required "RegExp" regExp
        |> Jpipe.required "register" register
        |> Jpipe.required "reinterpret_cast" reinterpretCast

encodeObj4 : Obj4 -> Jenc.Value
encodeObj4 x =
    Jenc.object
        [ ("dummy", Jenc.int x.dummy)
        , ("mutable", encodeMutable x.mutable)
        , ("mutating", encodeMutating x.mutating)
        , ("namespace", encodeNamespace x.namespace)
        , ("native", encodeNative x.native)
        , ("new", encodeNew x.new)
        , ("newtonsoft", encodeNewtonsoft x.newtonsoft)
        , ("nil", encodeNil x.nil)
        , ("NO", encodeNo x.no)
        , ("noSuchMethod", encodeNoSuchMethod x.noSuchMethod)
        , ("noexcept", encodeNoexcept x.noexcept)
        , ("nonatomic", encodeNonatomic x.nonatomic)
        , ("None", encodeNone x.none)
        , ("nonlocal", encodeNonlocal x.nonlocal)
        , ("nonmutating", encodeNonmutating x.nonmutating)
        , ("not", encodeNot x.not)
        , ("not_eq", encodeNotEq x.notEq)
        , ("NSError", encodeNSError x.nsError)
        , ("NSObject", encodeNSObject x.nsObject)
        , ("NSString", encodeNSString x.nsString)
        , ("NULL", encodeNull x.null)
        , ("NullNode", encodeNullNode x.nullNode)
        , ("nullptr", encodeNullptr x.nullptr)
        , ("number", encodeNumber x.number)
        , ("none", encodeNoneClass x.obj4None)
        , ("null", encodeNullClass x.obj4Null)
        , ("of", encodeOf x.obj4Of)
        , ("port", encodePort x.obj4Port)
        , ("protocol", encodeProtocolClass x.obj4Protocol)
        , ("object", encodeObject x.object)
        , ("ObjectMapper", encodeObjectMapper x.objectMapper)
        , ("ObjectNode", encodeObjectNode x.objectNode)
        , ("ObjectReader", encodeObjectReader x.objectReader)
        , ("ObjectWriter", encodeObjectWriter x.objectWriter)
        , ("OffsetDateTime", encodeOffsetDateTime x.offsetDateTime)
        , ("OffsetTime", encodeOffsetTime x.offsetTime)
        , ("oneway", encodeOneway x.oneway)
        , ("open", encodeOpen x.open)
        , ("operator", encodeOperator x.operator)
        , ("optional", encodeOptional x.optional)
        , ("or", encodeOr x.or)
        , ("or_eq", encodeOrEq x.orEq)
        , ("out", encodeOut x.out)
        , ("override", encodeOverride x.override)
        , ("package", encodePackage x.package)
        , ("params", encodeParams x.params)
        , ("pass", encodePass x.pass)
        , ("postfix", encodePostfix x.postfix)
        , ("precedence", encodePrecedence x.precedence)
        , ("prefix", encodePrefix x.prefix)
        , ("print", encodePrint x.print)
        , ("printMembers", encodePrintMembers x.printMembers)
        , ("printf", encodePrintf x.printf)
        , ("private", encodePrivate x.private)
        , ("protected", encodeProtected x.protected)
        , ("Protocol", encodeProtocol x.protocol)
        , ("public", encodePublic x.public)
        , ("quicktype", encodeQuicktype x.quicktype)
        , ("raise", encodeRaise x.raise)
        , ("range", encodeRange x.range)
        , ("readonly", encodeReadonly x.readonly)
        , ("ref", encodeRef x.ref)
        , ("RegExp", encodeRegExp x.regExp)
        , ("register", encodeRegister x.register)
        , ("reinterpret_cast", encodeReinterpretCast x.reinterpretCast)
        ]

mutable : Jdec.Decoder Mutable
mutable =
    Jdec.succeed Mutable
        |> Jpipe.required "mutable" Jdec.int

encodeMutable : Mutable -> Jenc.Value
encodeMutable x =
    Jenc.object
        [ ("mutable", Jenc.int x.mutable)
        ]

mutating : Jdec.Decoder Mutating
mutating =
    Jdec.succeed Mutating
        |> Jpipe.required "mutating" Jdec.int

encodeMutating : Mutating -> Jenc.Value
encodeMutating x =
    Jenc.object
        [ ("mutating", Jenc.int x.mutating)
        ]

namespace : Jdec.Decoder Namespace
namespace =
    Jdec.succeed Namespace
        |> Jpipe.required "namespace" Jdec.int

encodeNamespace : Namespace -> Jenc.Value
encodeNamespace x =
    Jenc.object
        [ ("namespace", Jenc.int x.namespace)
        ]

native : Jdec.Decoder Native
native =
    Jdec.succeed Native
        |> Jpipe.required "native" Jdec.int

encodeNative : Native -> Jenc.Value
encodeNative x =
    Jenc.object
        [ ("native", Jenc.int x.native)
        ]

new : Jdec.Decoder New
new =
    Jdec.succeed New
        |> Jpipe.required "new" Jdec.int

encodeNew : New -> Jenc.Value
encodeNew x =
    Jenc.object
        [ ("new", Jenc.int x.new)
        ]

newtonsoft : Jdec.Decoder Newtonsoft
newtonsoft =
    Jdec.succeed Newtonsoft
        |> Jpipe.required "newtonsoft" Jdec.int

encodeNewtonsoft : Newtonsoft -> Jenc.Value
encodeNewtonsoft x =
    Jenc.object
        [ ("newtonsoft", Jenc.int x.newtonsoft)
        ]

nil : Jdec.Decoder Nil
nil =
    Jdec.succeed Nil
        |> Jpipe.required "nil" Jdec.int

encodeNil : Nil -> Jenc.Value
encodeNil x =
    Jenc.object
        [ ("nil", Jenc.int x.nil)
        ]

no : Jdec.Decoder No
no =
    Jdec.succeed No
        |> Jpipe.required "NO" Jdec.int

encodeNo : No -> Jenc.Value
encodeNo x =
    Jenc.object
        [ ("NO", Jenc.int x.no)
        ]

noSuchMethod : Jdec.Decoder NoSuchMethod
noSuchMethod =
    Jdec.succeed NoSuchMethod
        |> Jpipe.required "noSuchMethod" Jdec.int

encodeNoSuchMethod : NoSuchMethod -> Jenc.Value
encodeNoSuchMethod x =
    Jenc.object
        [ ("noSuchMethod", Jenc.int x.noSuchMethod)
        ]

noexcept : Jdec.Decoder Noexcept
noexcept =
    Jdec.succeed Noexcept
        |> Jpipe.required "noexcept" Jdec.int

encodeNoexcept : Noexcept -> Jenc.Value
encodeNoexcept x =
    Jenc.object
        [ ("noexcept", Jenc.int x.noexcept)
        ]

nonatomic : Jdec.Decoder Nonatomic
nonatomic =
    Jdec.succeed Nonatomic
        |> Jpipe.required "nonatomic" Jdec.int

encodeNonatomic : Nonatomic -> Jenc.Value
encodeNonatomic x =
    Jenc.object
        [ ("nonatomic", Jenc.int x.nonatomic)
        ]

none : Jdec.Decoder None
none =
    Jdec.succeed None
        |> Jpipe.required "None" Jdec.int

encodeNone : None -> Jenc.Value
encodeNone x =
    Jenc.object
        [ ("None", Jenc.int x.none)
        ]

nonlocal : Jdec.Decoder Nonlocal
nonlocal =
    Jdec.succeed Nonlocal
        |> Jpipe.required "nonlocal" Jdec.int

encodeNonlocal : Nonlocal -> Jenc.Value
encodeNonlocal x =
    Jenc.object
        [ ("nonlocal", Jenc.int x.nonlocal)
        ]

nonmutating : Jdec.Decoder Nonmutating
nonmutating =
    Jdec.succeed Nonmutating
        |> Jpipe.required "nonmutating" Jdec.int

encodeNonmutating : Nonmutating -> Jenc.Value
encodeNonmutating x =
    Jenc.object
        [ ("nonmutating", Jenc.int x.nonmutating)
        ]

not : Jdec.Decoder Not
not =
    Jdec.succeed Not
        |> Jpipe.required "not" Jdec.int

encodeNot : Not -> Jenc.Value
encodeNot x =
    Jenc.object
        [ ("not", Jenc.int x.not)
        ]

notEq : Jdec.Decoder NotEq
notEq =
    Jdec.succeed NotEq
        |> Jpipe.required "not_eq" Jdec.int

encodeNotEq : NotEq -> Jenc.Value
encodeNotEq x =
    Jenc.object
        [ ("not_eq", Jenc.int x.notEq)
        ]

nsError : Jdec.Decoder NSError
nsError =
    Jdec.succeed NSError
        |> Jpipe.required "NSError" Jdec.int

encodeNSError : NSError -> Jenc.Value
encodeNSError x =
    Jenc.object
        [ ("NSError", Jenc.int x.nsError)
        ]

nsObject : Jdec.Decoder NSObject
nsObject =
    Jdec.succeed NSObject
        |> Jpipe.required "NSObject" Jdec.int

encodeNSObject : NSObject -> Jenc.Value
encodeNSObject x =
    Jenc.object
        [ ("NSObject", Jenc.int x.nsObject)
        ]

nsString : Jdec.Decoder NSString
nsString =
    Jdec.succeed NSString
        |> Jpipe.required "NSString" Jdec.int

encodeNSString : NSString -> Jenc.Value
encodeNSString x =
    Jenc.object
        [ ("NSString", Jenc.int x.nsString)
        ]

null : Jdec.Decoder Null
null =
    Jdec.succeed Null
        |> Jpipe.required "NULL" Jdec.int

encodeNull : Null -> Jenc.Value
encodeNull x =
    Jenc.object
        [ ("NULL", Jenc.int x.null)
        ]

nullNode : Jdec.Decoder NullNode
nullNode =
    Jdec.succeed NullNode
        |> Jpipe.required "NullNode" Jdec.int

encodeNullNode : NullNode -> Jenc.Value
encodeNullNode x =
    Jenc.object
        [ ("NullNode", Jenc.int x.nullNode)
        ]

nullptr : Jdec.Decoder Nullptr
nullptr =
    Jdec.succeed Nullptr
        |> Jpipe.required "nullptr" Jdec.int

encodeNullptr : Nullptr -> Jenc.Value
encodeNullptr x =
    Jenc.object
        [ ("nullptr", Jenc.int x.nullptr)
        ]

number : Jdec.Decoder Number
number =
    Jdec.succeed Number
        |> Jpipe.required "number" Jdec.int

encodeNumber : Number -> Jenc.Value
encodeNumber x =
    Jenc.object
        [ ("number", Jenc.int x.number)
        ]

noneClass : Jdec.Decoder NoneClass
noneClass =
    Jdec.succeed NoneClass
        |> Jpipe.required "none" Jdec.int

encodeNoneClass : NoneClass -> Jenc.Value
encodeNoneClass x =
    Jenc.object
        [ ("none", Jenc.int x.none)
        ]

nullClass : Jdec.Decoder NullClass
nullClass =
    Jdec.succeed NullClass
        |> Jpipe.required "null" Jdec.int

encodeNullClass : NullClass -> Jenc.Value
encodeNullClass x =
    Jenc.object
        [ ("null", Jenc.int x.null)
        ]

purpleOf : Jdec.Decoder Of
purpleOf =
    Jdec.succeed Of
        |> Jpipe.required "of" Jdec.int

encodeOf : Of -> Jenc.Value
encodeOf x =
    Jenc.object
        [ ("of", Jenc.int x.ofOf)
        ]

purplePort : Jdec.Decoder Port
purplePort =
    Jdec.succeed Port
        |> Jpipe.required "port" Jdec.int

encodePort : Port -> Jenc.Value
encodePort x =
    Jenc.object
        [ ("port", Jenc.int x.portPort)
        ]

protocolClass : Jdec.Decoder ProtocolClass
protocolClass =
    Jdec.succeed ProtocolClass
        |> Jpipe.required "protocol" Jdec.int

encodeProtocolClass : ProtocolClass -> Jenc.Value
encodeProtocolClass x =
    Jenc.object
        [ ("protocol", Jenc.int x.protocol)
        ]

object : Jdec.Decoder Object
object =
    Jdec.succeed Object
        |> Jpipe.required "object" Jdec.int

encodeObject : Object -> Jenc.Value
encodeObject x =
    Jenc.object
        [ ("object", Jenc.int x.object)
        ]

objectMapper : Jdec.Decoder ObjectMapper
objectMapper =
    Jdec.succeed ObjectMapper
        |> Jpipe.required "ObjectMapper" Jdec.int

encodeObjectMapper : ObjectMapper -> Jenc.Value
encodeObjectMapper x =
    Jenc.object
        [ ("ObjectMapper", Jenc.int x.objectMapper)
        ]

objectNode : Jdec.Decoder ObjectNode
objectNode =
    Jdec.succeed ObjectNode
        |> Jpipe.required "ObjectNode" Jdec.int

encodeObjectNode : ObjectNode -> Jenc.Value
encodeObjectNode x =
    Jenc.object
        [ ("ObjectNode", Jenc.int x.objectNode)
        ]

objectReader : Jdec.Decoder ObjectReader
objectReader =
    Jdec.succeed ObjectReader
        |> Jpipe.required "ObjectReader" Jdec.int

encodeObjectReader : ObjectReader -> Jenc.Value
encodeObjectReader x =
    Jenc.object
        [ ("ObjectReader", Jenc.int x.objectReader)
        ]

objectWriter : Jdec.Decoder ObjectWriter
objectWriter =
    Jdec.succeed ObjectWriter
        |> Jpipe.required "ObjectWriter" Jdec.int

encodeObjectWriter : ObjectWriter -> Jenc.Value
encodeObjectWriter x =
    Jenc.object
        [ ("ObjectWriter", Jenc.int x.objectWriter)
        ]

offsetDateTime : Jdec.Decoder OffsetDateTime
offsetDateTime =
    Jdec.succeed OffsetDateTime
        |> Jpipe.required "OffsetDateTime" Jdec.int

encodeOffsetDateTime : OffsetDateTime -> Jenc.Value
encodeOffsetDateTime x =
    Jenc.object
        [ ("OffsetDateTime", Jenc.int x.offsetDateTime)
        ]

offsetTime : Jdec.Decoder OffsetTime
offsetTime =
    Jdec.succeed OffsetTime
        |> Jpipe.required "OffsetTime" Jdec.int

encodeOffsetTime : OffsetTime -> Jenc.Value
encodeOffsetTime x =
    Jenc.object
        [ ("OffsetTime", Jenc.int x.offsetTime)
        ]

oneway : Jdec.Decoder Oneway
oneway =
    Jdec.succeed Oneway
        |> Jpipe.required "oneway" Jdec.int

encodeOneway : Oneway -> Jenc.Value
encodeOneway x =
    Jenc.object
        [ ("oneway", Jenc.int x.oneway)
        ]

open : Jdec.Decoder Open
open =
    Jdec.succeed Open
        |> Jpipe.required "open" Jdec.int

encodeOpen : Open -> Jenc.Value
encodeOpen x =
    Jenc.object
        [ ("open", Jenc.int x.open)
        ]

operator : Jdec.Decoder Operator
operator =
    Jdec.succeed Operator
        |> Jpipe.required "operator" Jdec.int

encodeOperator : Operator -> Jenc.Value
encodeOperator x =
    Jenc.object
        [ ("operator", Jenc.int x.operator)
        ]

optional : Jdec.Decoder Optional
optional =
    Jdec.succeed Optional
        |> Jpipe.required "optional" Jdec.int

encodeOptional : Optional -> Jenc.Value
encodeOptional x =
    Jenc.object
        [ ("optional", Jenc.int x.optional)
        ]

or : Jdec.Decoder Or
or =
    Jdec.succeed Or
        |> Jpipe.required "or" Jdec.int

encodeOr : Or -> Jenc.Value
encodeOr x =
    Jenc.object
        [ ("or", Jenc.int x.or)
        ]

orEq : Jdec.Decoder OrEq
orEq =
    Jdec.succeed OrEq
        |> Jpipe.required "or_eq" Jdec.int

encodeOrEq : OrEq -> Jenc.Value
encodeOrEq x =
    Jenc.object
        [ ("or_eq", Jenc.int x.orEq)
        ]

out : Jdec.Decoder Out
out =
    Jdec.succeed Out
        |> Jpipe.required "out" Jdec.int

encodeOut : Out -> Jenc.Value
encodeOut x =
    Jenc.object
        [ ("out", Jenc.int x.out)
        ]

override : Jdec.Decoder Override
override =
    Jdec.succeed Override
        |> Jpipe.required "override" Jdec.int

encodeOverride : Override -> Jenc.Value
encodeOverride x =
    Jenc.object
        [ ("override", Jenc.int x.override)
        ]

package : Jdec.Decoder Package
package =
    Jdec.succeed Package
        |> Jpipe.required "package" Jdec.int

encodePackage : Package -> Jenc.Value
encodePackage x =
    Jenc.object
        [ ("package", Jenc.int x.package)
        ]

params : Jdec.Decoder Params
params =
    Jdec.succeed Params
        |> Jpipe.required "params" Jdec.int

encodeParams : Params -> Jenc.Value
encodeParams x =
    Jenc.object
        [ ("params", Jenc.int x.params)
        ]

pass : Jdec.Decoder Pass
pass =
    Jdec.succeed Pass
        |> Jpipe.required "pass" Jdec.int

encodePass : Pass -> Jenc.Value
encodePass x =
    Jenc.object
        [ ("pass", Jenc.int x.pass)
        ]

postfix : Jdec.Decoder Postfix
postfix =
    Jdec.succeed Postfix
        |> Jpipe.required "postfix" Jdec.int

encodePostfix : Postfix -> Jenc.Value
encodePostfix x =
    Jenc.object
        [ ("postfix", Jenc.int x.postfix)
        ]

precedence : Jdec.Decoder Precedence
precedence =
    Jdec.succeed Precedence
        |> Jpipe.required "precedence" Jdec.int

encodePrecedence : Precedence -> Jenc.Value
encodePrecedence x =
    Jenc.object
        [ ("precedence", Jenc.int x.precedence)
        ]

prefix : Jdec.Decoder Prefix
prefix =
    Jdec.succeed Prefix
        |> Jpipe.required "prefix" Jdec.int

encodePrefix : Prefix -> Jenc.Value
encodePrefix x =
    Jenc.object
        [ ("prefix", Jenc.int x.prefix)
        ]

print : Jdec.Decoder Print
print =
    Jdec.succeed Print
        |> Jpipe.required "print" Jdec.int

encodePrint : Print -> Jenc.Value
encodePrint x =
    Jenc.object
        [ ("print", Jenc.int x.print)
        ]

printMembers : Jdec.Decoder PrintMembers
printMembers =
    Jdec.succeed PrintMembers
        |> Jpipe.required "printMembers" Jdec.int

encodePrintMembers : PrintMembers -> Jenc.Value
encodePrintMembers x =
    Jenc.object
        [ ("printMembers", Jenc.int x.printMembers)
        ]

printf : Jdec.Decoder Printf
printf =
    Jdec.succeed Printf
        |> Jpipe.required "printf" Jdec.int

encodePrintf : Printf -> Jenc.Value
encodePrintf x =
    Jenc.object
        [ ("printf", Jenc.int x.printf)
        ]

private : Jdec.Decoder Private
private =
    Jdec.succeed Private
        |> Jpipe.required "private" Jdec.int

encodePrivate : Private -> Jenc.Value
encodePrivate x =
    Jenc.object
        [ ("private", Jenc.int x.private)
        ]

protected : Jdec.Decoder Protected
protected =
    Jdec.succeed Protected
        |> Jpipe.required "protected" Jdec.int

encodeProtected : Protected -> Jenc.Value
encodeProtected x =
    Jenc.object
        [ ("protected", Jenc.int x.protected)
        ]

protocol : Jdec.Decoder Protocol
protocol =
    Jdec.succeed Protocol
        |> Jpipe.required "Protocol" Jdec.int

encodeProtocol : Protocol -> Jenc.Value
encodeProtocol x =
    Jenc.object
        [ ("Protocol", Jenc.int x.protocol)
        ]

public : Jdec.Decoder Public
public =
    Jdec.succeed Public
        |> Jpipe.required "public" Jdec.int

encodePublic : Public -> Jenc.Value
encodePublic x =
    Jenc.object
        [ ("public", Jenc.int x.public)
        ]

quicktype : Jdec.Decoder Quicktype
quicktype =
    Jdec.succeed Quicktype
        |> Jpipe.required "quicktype" Jdec.int

encodeQuicktype : Quicktype -> Jenc.Value
encodeQuicktype x =
    Jenc.object
        [ ("quicktype", Jenc.int x.quicktype)
        ]

raise : Jdec.Decoder Raise
raise =
    Jdec.succeed Raise
        |> Jpipe.required "raise" Jdec.int

encodeRaise : Raise -> Jenc.Value
encodeRaise x =
    Jenc.object
        [ ("raise", Jenc.int x.raise)
        ]

range : Jdec.Decoder Range
range =
    Jdec.succeed Range
        |> Jpipe.required "range" Jdec.int

encodeRange : Range -> Jenc.Value
encodeRange x =
    Jenc.object
        [ ("range", Jenc.int x.range)
        ]

readonly : Jdec.Decoder Readonly
readonly =
    Jdec.succeed Readonly
        |> Jpipe.required "readonly" Jdec.int

encodeReadonly : Readonly -> Jenc.Value
encodeReadonly x =
    Jenc.object
        [ ("readonly", Jenc.int x.readonly)
        ]

ref : Jdec.Decoder Ref
ref =
    Jdec.succeed Ref
        |> Jpipe.required "ref" Jdec.int

encodeRef : Ref -> Jenc.Value
encodeRef x =
    Jenc.object
        [ ("ref", Jenc.int x.ref)
        ]

regExp : Jdec.Decoder RegExp
regExp =
    Jdec.succeed RegExp
        |> Jpipe.required "RegExp" Jdec.string

encodeRegExp : RegExp -> Jenc.Value
encodeRegExp x =
    Jenc.object
        [ ("RegExp", Jenc.string x.regExp)
        ]

register : Jdec.Decoder Register
register =
    Jdec.succeed Register
        |> Jpipe.required "register" Jdec.int

encodeRegister : Register -> Jenc.Value
encodeRegister x =
    Jenc.object
        [ ("register", Jenc.int x.register)
        ]

reinterpretCast : Jdec.Decoder ReinterpretCast
reinterpretCast =
    Jdec.succeed ReinterpretCast
        |> Jpipe.required "reinterpret_cast" Jdec.int

encodeReinterpretCast : ReinterpretCast -> Jenc.Value
encodeReinterpretCast x =
    Jenc.object
        [ ("reinterpret_cast", Jenc.int x.reinterpretCast)
        ]

obj5 : Jdec.Decoder Obj5
obj5 =
    Jdec.succeed Obj5
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "KSerializer" kSerializer
        |> Jpipe.required "self" selfClass
        |> Jpipe.required "string" stringClass
        |> Jpipe.required "then" purpleThen
        |> Jpipe.required "true" obj5True
        |> Jpipe.required "PrimitiveKind" primitiveKind
        |> Jpipe.required "repeat" repeat
        |> Jpipe.required "require" require
        |> Jpipe.required "required" required
        |> Jpipe.required "requires" requires
        |> Jpipe.required "restrict" restrict
        |> Jpipe.required "retain" retain
        |> Jpipe.required "rethrows" rethrows
        |> Jpipe.required "return" return
        |> Jpipe.required "right" right
        |> Jpipe.required "runtimeType" runtimeType
        |> Jpipe.required "s" s
        |> Jpipe.required "sbyte" sbyte
        |> Jpipe.required "sealed" sealed
        |> Jpipe.required "SEL" sel
        |> Jpipe.required "select" select
        |> Jpipe.required "Self" self
        |> Jpipe.required "Sendable" sendable
        |> Jpipe.required "SerialDescriptor" serialDescriptor
        |> Jpipe.required "SerialName" serialName
        |> Jpipe.required "Serializable" serializable
        |> Jpipe.required "SerializationFeature" serializationFeature
        |> Jpipe.required "serialize" serialize
        |> Jpipe.required "SerializerProvider" serializerProvider
        |> Jpipe.required "set" set
        |> Jpipe.required "short" short
        |> Jpipe.required "signed" signed
        |> Jpipe.required "SimpleModule" simpleModule
        |> Jpipe.required "sizeof" sizeof
        |> Jpipe.required "stackalloc" stackalloc
        |> Jpipe.required "Standards" standards
        |> Jpipe.required "static" static
        |> Jpipe.required "static_assert" staticAssert
        |> Jpipe.required "static_cast" staticCast
        |> Jpipe.required "StdDeserializer" stdDeserializer
        |> Jpipe.required "StdSerializer" stdSerializer
        |> Jpipe.required "strictfp" strictfp
        |> Jpipe.required "struct" struct
        |> Jpipe.required "subscript" subscript
        |> Jpipe.required "super" super
        |> Jpipe.required "switch" switch
        |> Jpipe.required "symbol" symbol
        |> Jpipe.required "synchronized" synchronized
        |> Jpipe.required "system" system
        |> Jpipe.required "template" template
        |> Jpipe.required "TextNode" textNode
        |> Jpipe.required "this" this
        |> Jpipe.required "thread_local" threadLocal
        |> Jpipe.required "throw" throw
        |> Jpipe.required "throws" throws
        |> Jpipe.required "TimeOnly" timeOnly
        |> Jpipe.required "TimeOnlyConverter" timeOnlyConverter
        |> Jpipe.required "TimeZone" timeZone
        |> Jpipe.required "to_dict" toDict
        |> Jpipe.required "to_json" toJSON
        |> Jpipe.required "toString" toString
        |> Jpipe.required "top_level" topLevel
        |> Jpipe.required "transient" transient
        |> Jpipe.required "True" trueClass

encodeObj5 : Obj5 -> Jenc.Value
encodeObj5 x =
    Jenc.object
        [ ("dummy", Jenc.int x.dummy)
        , ("KSerializer", encodeKSerializer x.kSerializer)
        , ("self", encodeSelfClass x.obj5Self)
        , ("string", encodeStringClass x.obj5String)
        , ("then", encodeThen x.obj5Then)
        , ("true", encodeObj5True x.obj5True)
        , ("PrimitiveKind", encodePrimitiveKind x.primitiveKind)
        , ("repeat", encodeRepeat x.repeat)
        , ("require", encodeRequire x.require)
        , ("required", encodeRequired x.required)
        , ("requires", encodeRequires x.requires)
        , ("restrict", encodeRestrict x.restrict)
        , ("retain", encodeRetain x.retain)
        , ("rethrows", encodeRethrows x.rethrows)
        , ("return", encodeReturn x.return)
        , ("right", encodeRight x.right)
        , ("runtimeType", encodeRuntimeType x.runtimeType)
        , ("s", encodeS x.s)
        , ("sbyte", encodeSbyte x.sbyte)
        , ("sealed", encodeSealed x.sealed)
        , ("SEL", encodeSel x.sel)
        , ("select", encodeSelect x.select)
        , ("Self", encodeSelf x.self)
        , ("Sendable", encodeSendable x.sendable)
        , ("SerialDescriptor", encodeSerialDescriptor x.serialDescriptor)
        , ("SerialName", encodeSerialName x.serialName)
        , ("Serializable", encodeSerializable x.serializable)
        , ("SerializationFeature", encodeSerializationFeature x.serializationFeature)
        , ("serialize", encodeSerialize x.serialize)
        , ("SerializerProvider", encodeSerializerProvider x.serializerProvider)
        , ("set", encodeSet x.set)
        , ("short", encodeShort x.short)
        , ("signed", encodeSigned x.signed)
        , ("SimpleModule", encodeSimpleModule x.simpleModule)
        , ("sizeof", encodeSizeof x.sizeof)
        , ("stackalloc", encodeStackalloc x.stackalloc)
        , ("Standards", encodeStandards x.standards)
        , ("static", encodeStatic x.static)
        , ("static_assert", encodeStaticAssert x.staticAssert)
        , ("static_cast", encodeStaticCast x.staticCast)
        , ("StdDeserializer", encodeStdDeserializer x.stdDeserializer)
        , ("StdSerializer", encodeStdSerializer x.stdSerializer)
        , ("strictfp", encodeStrictfp x.strictfp)
        , ("struct", encodeStruct x.struct)
        , ("subscript", encodeSubscript x.subscript)
        , ("super", encodeSuper x.super)
        , ("switch", encodeSwitch x.switch)
        , ("symbol", encodeSymbol x.symbol)
        , ("synchronized", encodeSynchronized x.synchronized)
        , ("system", encodeSystem x.system)
        , ("template", encodeTemplate x.template)
        , ("TextNode", encodeTextNode x.textNode)
        , ("this", encodeThis x.this)
        , ("thread_local", encodeThreadLocal x.threadLocal)
        , ("throw", encodeThrow x.throw)
        , ("throws", encodeThrows x.throws)
        , ("TimeOnly", encodeTimeOnly x.timeOnly)
        , ("TimeOnlyConverter", encodeTimeOnlyConverter x.timeOnlyConverter)
        , ("TimeZone", encodeTimeZone x.timeZone)
        , ("to_dict", encodeToDict x.toDict)
        , ("to_json", encodeToJSON x.toJSON)
        , ("toString", encodeToString x.toString)
        , ("top_level", encodeTopLevel x.topLevel)
        , ("transient", encodeTransient x.transient)
        , ("True", encodeTrueClass x.true)
        ]

kSerializer : Jdec.Decoder KSerializer
kSerializer =
    Jdec.succeed KSerializer
        |> Jpipe.required "KSerializer" Jdec.int

encodeKSerializer : KSerializer -> Jenc.Value
encodeKSerializer x =
    Jenc.object
        [ ("KSerializer", Jenc.int x.kSerializer)
        ]

selfClass : Jdec.Decoder SelfClass
selfClass =
    Jdec.succeed SelfClass
        |> Jpipe.required "self" Jdec.int

encodeSelfClass : SelfClass -> Jenc.Value
encodeSelfClass x =
    Jenc.object
        [ ("self", Jenc.int x.self)
        ]

stringClass : Jdec.Decoder StringClass
stringClass =
    Jdec.succeed StringClass
        |> Jpipe.required "string" Jdec.int

encodeStringClass : StringClass -> Jenc.Value
encodeStringClass x =
    Jenc.object
        [ ("string", Jenc.int x.stringString)
        ]

purpleThen : Jdec.Decoder Then
purpleThen =
    Jdec.succeed Then
        |> Jpipe.required "then" Jdec.int

encodeThen : Then -> Jenc.Value
encodeThen x =
    Jenc.object
        [ ("then", Jenc.int x.thenThen)
        ]

obj5True : Jdec.Decoder Obj5True
obj5True =
    Jdec.succeed Obj5True
        |> Jpipe.required "true" Jdec.int

encodeObj5True : Obj5True -> Jenc.Value
encodeObj5True x =
    Jenc.object
        [ ("true", Jenc.int x.true)
        ]

primitiveKind : Jdec.Decoder PrimitiveKind
primitiveKind =
    Jdec.succeed PrimitiveKind
        |> Jpipe.required "PrimitiveKind" Jdec.int

encodePrimitiveKind : PrimitiveKind -> Jenc.Value
encodePrimitiveKind x =
    Jenc.object
        [ ("PrimitiveKind", Jenc.int x.primitiveKind)
        ]

repeat : Jdec.Decoder Repeat
repeat =
    Jdec.succeed Repeat
        |> Jpipe.required "repeat" Jdec.int

encodeRepeat : Repeat -> Jenc.Value
encodeRepeat x =
    Jenc.object
        [ ("repeat", Jenc.int x.repeat)
        ]

require : Jdec.Decoder Require
require =
    Jdec.succeed Require
        |> Jpipe.required "require" Jdec.int

encodeRequire : Require -> Jenc.Value
encodeRequire x =
    Jenc.object
        [ ("require", Jenc.int x.require)
        ]

required : Jdec.Decoder Required
required =
    Jdec.succeed Required
        |> Jpipe.required "required" Jdec.int

encodeRequired : Required -> Jenc.Value
encodeRequired x =
    Jenc.object
        [ ("required", Jenc.int x.required)
        ]

requires : Jdec.Decoder Requires
requires =
    Jdec.succeed Requires
        |> Jpipe.required "requires" Jdec.int

encodeRequires : Requires -> Jenc.Value
encodeRequires x =
    Jenc.object
        [ ("requires", Jenc.int x.requires)
        ]

restrict : Jdec.Decoder Restrict
restrict =
    Jdec.succeed Restrict
        |> Jpipe.required "restrict" Jdec.int

encodeRestrict : Restrict -> Jenc.Value
encodeRestrict x =
    Jenc.object
        [ ("restrict", Jenc.int x.restrict)
        ]

retain : Jdec.Decoder Retain
retain =
    Jdec.succeed Retain
        |> Jpipe.required "retain" Jdec.int

encodeRetain : Retain -> Jenc.Value
encodeRetain x =
    Jenc.object
        [ ("retain", Jenc.int x.retain)
        ]

rethrows : Jdec.Decoder Rethrows
rethrows =
    Jdec.succeed Rethrows
        |> Jpipe.required "rethrows" Jdec.int

encodeRethrows : Rethrows -> Jenc.Value
encodeRethrows x =
    Jenc.object
        [ ("rethrows", Jenc.int x.rethrows)
        ]

return : Jdec.Decoder Return
return =
    Jdec.succeed Return
        |> Jpipe.required "return" Jdec.int

encodeReturn : Return -> Jenc.Value
encodeReturn x =
    Jenc.object
        [ ("return", Jenc.int x.return)
        ]

right : Jdec.Decoder Right
right =
    Jdec.succeed Right
        |> Jpipe.required "right" Jdec.int

encodeRight : Right -> Jenc.Value
encodeRight x =
    Jenc.object
        [ ("right", Jenc.int x.right)
        ]

runtimeType : Jdec.Decoder RuntimeType
runtimeType =
    Jdec.succeed RuntimeType
        |> Jpipe.required "runtimeType" Jdec.int

encodeRuntimeType : RuntimeType -> Jenc.Value
encodeRuntimeType x =
    Jenc.object
        [ ("runtimeType", Jenc.int x.runtimeType)
        ]

s : Jdec.Decoder S
s =
    Jdec.succeed S
        |> Jpipe.required "s" Jdec.int

encodeS : S -> Jenc.Value
encodeS x =
    Jenc.object
        [ ("s", Jenc.int x.s)
        ]

sbyte : Jdec.Decoder Sbyte
sbyte =
    Jdec.succeed Sbyte
        |> Jpipe.required "sbyte" Jdec.int

encodeSbyte : Sbyte -> Jenc.Value
encodeSbyte x =
    Jenc.object
        [ ("sbyte", Jenc.int x.sbyte)
        ]

sealed : Jdec.Decoder Sealed
sealed =
    Jdec.succeed Sealed
        |> Jpipe.required "sealed" Jdec.int

encodeSealed : Sealed -> Jenc.Value
encodeSealed x =
    Jenc.object
        [ ("sealed", Jenc.int x.sealed)
        ]

sel : Jdec.Decoder Sel
sel =
    Jdec.succeed Sel
        |> Jpipe.required "SEL" Jdec.int

encodeSel : Sel -> Jenc.Value
encodeSel x =
    Jenc.object
        [ ("SEL", Jenc.int x.sel)
        ]

select : Jdec.Decoder Select
select =
    Jdec.succeed Select
        |> Jpipe.required "select" Jdec.int

encodeSelect : Select -> Jenc.Value
encodeSelect x =
    Jenc.object
        [ ("select", Jenc.int x.select)
        ]

self : Jdec.Decoder Self
self =
    Jdec.succeed Self
        |> Jpipe.required "Self" Jdec.int

encodeSelf : Self -> Jenc.Value
encodeSelf x =
    Jenc.object
        [ ("Self", Jenc.int x.self)
        ]

sendable : Jdec.Decoder Sendable
sendable =
    Jdec.succeed Sendable
        |> Jpipe.required "Sendable" Jdec.int

encodeSendable : Sendable -> Jenc.Value
encodeSendable x =
    Jenc.object
        [ ("Sendable", Jenc.int x.sendable)
        ]

serialDescriptor : Jdec.Decoder SerialDescriptor
serialDescriptor =
    Jdec.succeed SerialDescriptor
        |> Jpipe.required "SerialDescriptor" Jdec.int

encodeSerialDescriptor : SerialDescriptor -> Jenc.Value
encodeSerialDescriptor x =
    Jenc.object
        [ ("SerialDescriptor", Jenc.int x.serialDescriptor)
        ]

serialName : Jdec.Decoder SerialName
serialName =
    Jdec.succeed SerialName
        |> Jpipe.required "SerialName" Jdec.int

encodeSerialName : SerialName -> Jenc.Value
encodeSerialName x =
    Jenc.object
        [ ("SerialName", Jenc.int x.serialName)
        ]

serializable : Jdec.Decoder Serializable
serializable =
    Jdec.succeed Serializable
        |> Jpipe.required "Serializable" Jdec.int

encodeSerializable : Serializable -> Jenc.Value
encodeSerializable x =
    Jenc.object
        [ ("Serializable", Jenc.int x.serializable)
        ]

serializationFeature : Jdec.Decoder SerializationFeature
serializationFeature =
    Jdec.succeed SerializationFeature
        |> Jpipe.required "SerializationFeature" Jdec.int

encodeSerializationFeature : SerializationFeature -> Jenc.Value
encodeSerializationFeature x =
    Jenc.object
        [ ("SerializationFeature", Jenc.int x.serializationFeature)
        ]

serialize : Jdec.Decoder Serialize
serialize =
    Jdec.succeed Serialize
        |> Jpipe.required "serialize" Jdec.int

encodeSerialize : Serialize -> Jenc.Value
encodeSerialize x =
    Jenc.object
        [ ("serialize", Jenc.int x.serialize)
        ]

serializerProvider : Jdec.Decoder SerializerProvider
serializerProvider =
    Jdec.succeed SerializerProvider
        |> Jpipe.required "SerializerProvider" Jdec.int

encodeSerializerProvider : SerializerProvider -> Jenc.Value
encodeSerializerProvider x =
    Jenc.object
        [ ("SerializerProvider", Jenc.int x.serializerProvider)
        ]

set : Jdec.Decoder Set
set =
    Jdec.succeed Set
        |> Jpipe.required "set" Jdec.int

encodeSet : Set -> Jenc.Value
encodeSet x =
    Jenc.object
        [ ("set", Jenc.int x.set)
        ]

short : Jdec.Decoder Short
short =
    Jdec.succeed Short
        |> Jpipe.required "short" Jdec.int

encodeShort : Short -> Jenc.Value
encodeShort x =
    Jenc.object
        [ ("short", Jenc.int x.short)
        ]

signed : Jdec.Decoder Signed
signed =
    Jdec.succeed Signed
        |> Jpipe.required "signed" Jdec.int

encodeSigned : Signed -> Jenc.Value
encodeSigned x =
    Jenc.object
        [ ("signed", Jenc.int x.signed)
        ]

simpleModule : Jdec.Decoder SimpleModule
simpleModule =
    Jdec.succeed SimpleModule
        |> Jpipe.required "SimpleModule" Jdec.int

encodeSimpleModule : SimpleModule -> Jenc.Value
encodeSimpleModule x =
    Jenc.object
        [ ("SimpleModule", Jenc.int x.simpleModule)
        ]

sizeof : Jdec.Decoder Sizeof
sizeof =
    Jdec.succeed Sizeof
        |> Jpipe.required "sizeof" Jdec.int

encodeSizeof : Sizeof -> Jenc.Value
encodeSizeof x =
    Jenc.object
        [ ("sizeof", Jenc.int x.sizeof)
        ]

stackalloc : Jdec.Decoder Stackalloc
stackalloc =
    Jdec.succeed Stackalloc
        |> Jpipe.required "stackalloc" Jdec.int

encodeStackalloc : Stackalloc -> Jenc.Value
encodeStackalloc x =
    Jenc.object
        [ ("stackalloc", Jenc.int x.stackalloc)
        ]

standards : Jdec.Decoder Standards
standards =
    Jdec.succeed Standards
        |> Jpipe.required "Standards" Jdec.int

encodeStandards : Standards -> Jenc.Value
encodeStandards x =
    Jenc.object
        [ ("Standards", Jenc.int x.standards)
        ]

static : Jdec.Decoder Static
static =
    Jdec.succeed Static
        |> Jpipe.required "static" Jdec.int

encodeStatic : Static -> Jenc.Value
encodeStatic x =
    Jenc.object
        [ ("static", Jenc.int x.static)
        ]

staticAssert : Jdec.Decoder StaticAssert
staticAssert =
    Jdec.succeed StaticAssert
        |> Jpipe.required "static_assert" Jdec.int

encodeStaticAssert : StaticAssert -> Jenc.Value
encodeStaticAssert x =
    Jenc.object
        [ ("static_assert", Jenc.int x.staticAssert)
        ]

staticCast : Jdec.Decoder StaticCast
staticCast =
    Jdec.succeed StaticCast
        |> Jpipe.required "static_cast" Jdec.int

encodeStaticCast : StaticCast -> Jenc.Value
encodeStaticCast x =
    Jenc.object
        [ ("static_cast", Jenc.int x.staticCast)
        ]

stdDeserializer : Jdec.Decoder StdDeserializer
stdDeserializer =
    Jdec.succeed StdDeserializer
        |> Jpipe.required "StdDeserializer" Jdec.int

encodeStdDeserializer : StdDeserializer -> Jenc.Value
encodeStdDeserializer x =
    Jenc.object
        [ ("StdDeserializer", Jenc.int x.stdDeserializer)
        ]

stdSerializer : Jdec.Decoder StdSerializer
stdSerializer =
    Jdec.succeed StdSerializer
        |> Jpipe.required "StdSerializer" Jdec.int

encodeStdSerializer : StdSerializer -> Jenc.Value
encodeStdSerializer x =
    Jenc.object
        [ ("StdSerializer", Jenc.int x.stdSerializer)
        ]

strictfp : Jdec.Decoder Strictfp
strictfp =
    Jdec.succeed Strictfp
        |> Jpipe.required "strictfp" Jdec.int

encodeStrictfp : Strictfp -> Jenc.Value
encodeStrictfp x =
    Jenc.object
        [ ("strictfp", Jenc.int x.strictfp)
        ]

struct : Jdec.Decoder Struct
struct =
    Jdec.succeed Struct
        |> Jpipe.required "struct" Jdec.int

encodeStruct : Struct -> Jenc.Value
encodeStruct x =
    Jenc.object
        [ ("struct", Jenc.int x.struct)
        ]

subscript : Jdec.Decoder Subscript
subscript =
    Jdec.succeed Subscript
        |> Jpipe.required "subscript" Jdec.int

encodeSubscript : Subscript -> Jenc.Value
encodeSubscript x =
    Jenc.object
        [ ("subscript", Jenc.int x.subscript)
        ]

super : Jdec.Decoder Super
super =
    Jdec.succeed Super
        |> Jpipe.required "super" Jdec.int

encodeSuper : Super -> Jenc.Value
encodeSuper x =
    Jenc.object
        [ ("super", Jenc.int x.super)
        ]

switch : Jdec.Decoder Switch
switch =
    Jdec.succeed Switch
        |> Jpipe.required "switch" Jdec.int

encodeSwitch : Switch -> Jenc.Value
encodeSwitch x =
    Jenc.object
        [ ("switch", Jenc.int x.switch)
        ]

symbol : Jdec.Decoder Symbol
symbol =
    Jdec.succeed Symbol
        |> Jpipe.required "symbol" Jdec.int

encodeSymbol : Symbol -> Jenc.Value
encodeSymbol x =
    Jenc.object
        [ ("symbol", Jenc.int x.symbol)
        ]

synchronized : Jdec.Decoder Synchronized
synchronized =
    Jdec.succeed Synchronized
        |> Jpipe.required "synchronized" Jdec.int

encodeSynchronized : Synchronized -> Jenc.Value
encodeSynchronized x =
    Jenc.object
        [ ("synchronized", Jenc.int x.synchronized)
        ]

system : Jdec.Decoder System
system =
    Jdec.succeed System
        |> Jpipe.required "system" Jdec.int

encodeSystem : System -> Jenc.Value
encodeSystem x =
    Jenc.object
        [ ("system", Jenc.int x.system)
        ]

template : Jdec.Decoder Template
template =
    Jdec.succeed Template
        |> Jpipe.required "template" Jdec.int

encodeTemplate : Template -> Jenc.Value
encodeTemplate x =
    Jenc.object
        [ ("template", Jenc.int x.template)
        ]

textNode : Jdec.Decoder TextNode
textNode =
    Jdec.succeed TextNode
        |> Jpipe.required "TextNode" Jdec.int

encodeTextNode : TextNode -> Jenc.Value
encodeTextNode x =
    Jenc.object
        [ ("TextNode", Jenc.int x.textNode)
        ]

this : Jdec.Decoder This
this =
    Jdec.succeed This
        |> Jpipe.required "this" Jdec.int

encodeThis : This -> Jenc.Value
encodeThis x =
    Jenc.object
        [ ("this", Jenc.int x.this)
        ]

threadLocal : Jdec.Decoder ThreadLocal
threadLocal =
    Jdec.succeed ThreadLocal
        |> Jpipe.required "thread_local" Jdec.int

encodeThreadLocal : ThreadLocal -> Jenc.Value
encodeThreadLocal x =
    Jenc.object
        [ ("thread_local", Jenc.int x.threadLocal)
        ]

throw : Jdec.Decoder Throw
throw =
    Jdec.succeed Throw
        |> Jpipe.required "throw" Jdec.int

encodeThrow : Throw -> Jenc.Value
encodeThrow x =
    Jenc.object
        [ ("throw", Jenc.int x.throw)
        ]

throws : Jdec.Decoder Throws
throws =
    Jdec.succeed Throws
        |> Jpipe.required "throws" Jdec.int

encodeThrows : Throws -> Jenc.Value
encodeThrows x =
    Jenc.object
        [ ("throws", Jenc.int x.throws)
        ]

timeOnly : Jdec.Decoder TimeOnly
timeOnly =
    Jdec.succeed TimeOnly
        |> Jpipe.required "TimeOnly" Jdec.int

encodeTimeOnly : TimeOnly -> Jenc.Value
encodeTimeOnly x =
    Jenc.object
        [ ("TimeOnly", Jenc.int x.timeOnly)
        ]

timeOnlyConverter : Jdec.Decoder TimeOnlyConverter
timeOnlyConverter =
    Jdec.succeed TimeOnlyConverter
        |> Jpipe.required "TimeOnlyConverter" Jdec.int

encodeTimeOnlyConverter : TimeOnlyConverter -> Jenc.Value
encodeTimeOnlyConverter x =
    Jenc.object
        [ ("TimeOnlyConverter", Jenc.int x.timeOnlyConverter)
        ]

timeZone : Jdec.Decoder TimeZone
timeZone =
    Jdec.succeed TimeZone
        |> Jpipe.required "TimeZone" Jdec.int

encodeTimeZone : TimeZone -> Jenc.Value
encodeTimeZone x =
    Jenc.object
        [ ("TimeZone", Jenc.int x.timeZone)
        ]

toDict : Jdec.Decoder ToDict
toDict =
    Jdec.succeed ToDict
        |> Jpipe.required "to_dict" Jdec.int

encodeToDict : ToDict -> Jenc.Value
encodeToDict x =
    Jenc.object
        [ ("to_dict", Jenc.int x.toDict)
        ]

toJSON : Jdec.Decoder ToJSON
toJSON =
    Jdec.succeed ToJSON
        |> Jpipe.required "to_json" Jdec.int

encodeToJSON : ToJSON -> Jenc.Value
encodeToJSON x =
    Jenc.object
        [ ("to_json", Jenc.int x.toJSON)
        ]

toString : Jdec.Decoder ToString
toString =
    Jdec.succeed ToString
        |> Jpipe.required "toString" Jdec.int

encodeToString : ToString -> Jenc.Value
encodeToString x =
    Jenc.object
        [ ("toString", Jenc.int x.toString)
        ]

topLevel : Jdec.Decoder TopLevel
topLevel =
    Jdec.succeed TopLevel
        |> Jpipe.required "top_level" Jdec.int

encodeTopLevel : TopLevel -> Jenc.Value
encodeTopLevel x =
    Jenc.object
        [ ("top_level", Jenc.int x.topLevel)
        ]

transient : Jdec.Decoder Transient
transient =
    Jdec.succeed Transient
        |> Jpipe.required "transient" Jdec.int

encodeTransient : Transient -> Jenc.Value
encodeTransient x =
    Jenc.object
        [ ("transient", Jenc.int x.transient)
        ]

trueClass : Jdec.Decoder TrueClass
trueClass =
    Jdec.succeed TrueClass
        |> Jpipe.required "True" Jdec.int

encodeTrueClass : TrueClass -> Jenc.Value
encodeTrueClass x =
    Jenc.object
        [ ("True", Jenc.int x.true)
        ]

obj6 : Jdec.Decoder Obj6
obj6 =
    Jdec.succeed Obj6
        |> Jpipe.required "dummy" Jdec.int
        |> Jpipe.required "Type" purpleType
        |> Jpipe.required "where" purpleWhere
        |> Jpipe.required "type" typeClass
        |> Jpipe.required "try" try
        |> Jpipe.required "typealias" typealias
        |> Jpipe.required "typedef" typedef
        |> Jpipe.required "typeid" typeid
        |> Jpipe.required "typename" typename
        |> Jpipe.required "typeof" typeof
        |> Jpipe.required "uint" uint
        |> Jpipe.required "ulong" ulong
        |> Jpipe.required "unchecked" unchecked
        |> Jpipe.required "undefined" undefined
        |> Jpipe.required "union" union
        |> Jpipe.required "UnmarshalJSON" unmarshalJSON
        |> Jpipe.required "unowned" unowned
        |> Jpipe.required "unsafe" unsafe
        |> Jpipe.required "unsigned" unsigned
        |> Jpipe.required "UseSerializers" useSerializers
        |> Jpipe.required "ushort" ushort
        |> Jpipe.required "using" using
        |> Jpipe.required "Utf8JsonReader" utf8JSONReader
        |> Jpipe.required "Utf8JsonWriter" utf8JSONWriter
        |> Jpipe.required "UUID" uuid
        |> Jpipe.required "var" var
        |> Jpipe.required "virtual" virtual
        |> Jpipe.required "void" void
        |> Jpipe.required "volatile" volatile
        |> Jpipe.required "wchar_t" wcharT
        |> Jpipe.required "weak" weak
        |> Jpipe.required "while" while
        |> Jpipe.required "willSet" willSet
        |> Jpipe.required "with" with
        |> Jpipe.required "xor" xor
        |> Jpipe.required "xor_eq" xorEq
        |> Jpipe.required "YES" yes
        |> Jpipe.required "yield" yield

encodeObj6 : Obj6 -> Jenc.Value
encodeObj6 x =
    Jenc.object
        [ ("dummy", Jenc.int x.dummy)
        , ("Type", encodeType x.obj6Type)
        , ("where", encodeWhere x.obj6Where)
        , ("type", encodeTypeClass x.purpleType)
        , ("try", encodeTry x.try)
        , ("typealias", encodeTypealias x.typealias)
        , ("typedef", encodeTypedef x.typedef)
        , ("typeid", encodeTypeid x.typeid)
        , ("typename", encodeTypename x.typename)
        , ("typeof", encodeTypeof x.typeof)
        , ("uint", encodeUint x.uint)
        , ("ulong", encodeUlong x.ulong)
        , ("unchecked", encodeUnchecked x.unchecked)
        , ("undefined", encodeUndefined x.undefined)
        , ("union", encodeUnion x.union)
        , ("UnmarshalJSON", encodeUnmarshalJSON x.unmarshalJSON)
        , ("unowned", encodeUnowned x.unowned)
        , ("unsafe", encodeUnsafe x.unsafe)
        , ("unsigned", encodeUnsigned x.unsigned)
        , ("UseSerializers", encodeUseSerializers x.useSerializers)
        , ("ushort", encodeUshort x.ushort)
        , ("using", encodeUsing x.using)
        , ("Utf8JsonReader", encodeUtf8JSONReader x.utf8JSONReader)
        , ("Utf8JsonWriter", encodeUtf8JSONWriter x.utf8JSONWriter)
        , ("UUID", encodeUUID x.uuid)
        , ("var", encodeVar x.var)
        , ("virtual", encodeVirtual x.virtual)
        , ("void", encodeVoid x.void)
        , ("volatile", encodeVolatile x.volatile)
        , ("wchar_t", encodeWcharT x.wcharT)
        , ("weak", encodeWeak x.weak)
        , ("while", encodeWhile x.while)
        , ("willSet", encodeWillSet x.willSet)
        , ("with", encodeWith x.with)
        , ("xor", encodeXor x.xor)
        , ("xor_eq", encodeXorEq x.xorEq)
        , ("YES", encodeYes x.yes)
        , ("yield", encodeYield x.yield)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.succeed Type
        |> Jpipe.required "Type" Jdec.int

encodeType : Type -> Jenc.Value
encodeType x =
    Jenc.object
        [ ("Type", Jenc.int x.typeType)
        ]

purpleWhere : Jdec.Decoder Where
purpleWhere =
    Jdec.succeed Where
        |> Jpipe.required "where" Jdec.int

encodeWhere : Where -> Jenc.Value
encodeWhere x =
    Jenc.object
        [ ("where", Jenc.int x.whereWhere)
        ]

typeClass : Jdec.Decoder TypeClass
typeClass =
    Jdec.succeed TypeClass
        |> Jpipe.required "type" Jdec.int

encodeTypeClass : TypeClass -> Jenc.Value
encodeTypeClass x =
    Jenc.object
        [ ("type", Jenc.int x.typeType)
        ]

try : Jdec.Decoder Try
try =
    Jdec.succeed Try
        |> Jpipe.required "try" Jdec.int

encodeTry : Try -> Jenc.Value
encodeTry x =
    Jenc.object
        [ ("try", Jenc.int x.try)
        ]

typealias : Jdec.Decoder Typealias
typealias =
    Jdec.succeed Typealias
        |> Jpipe.required "typealias" Jdec.int

encodeTypealias : Typealias -> Jenc.Value
encodeTypealias x =
    Jenc.object
        [ ("typealias", Jenc.int x.typealias)
        ]

typedef : Jdec.Decoder Typedef
typedef =
    Jdec.succeed Typedef
        |> Jpipe.required "typedef" Jdec.int

encodeTypedef : Typedef -> Jenc.Value
encodeTypedef x =
    Jenc.object
        [ ("typedef", Jenc.int x.typedef)
        ]

typeid : Jdec.Decoder Typeid
typeid =
    Jdec.succeed Typeid
        |> Jpipe.required "typeid" Jdec.int

encodeTypeid : Typeid -> Jenc.Value
encodeTypeid x =
    Jenc.object
        [ ("typeid", Jenc.int x.typeid)
        ]

typename : Jdec.Decoder Typename
typename =
    Jdec.succeed Typename
        |> Jpipe.required "typename" Jdec.int

encodeTypename : Typename -> Jenc.Value
encodeTypename x =
    Jenc.object
        [ ("typename", Jenc.int x.typename)
        ]

typeof : Jdec.Decoder Typeof
typeof =
    Jdec.succeed Typeof
        |> Jpipe.required "typeof" Jdec.int

encodeTypeof : Typeof -> Jenc.Value
encodeTypeof x =
    Jenc.object
        [ ("typeof", Jenc.int x.typeof)
        ]

uint : Jdec.Decoder Uint
uint =
    Jdec.succeed Uint
        |> Jpipe.required "uint" Jdec.int

encodeUint : Uint -> Jenc.Value
encodeUint x =
    Jenc.object
        [ ("uint", Jenc.int x.uint)
        ]

ulong : Jdec.Decoder Ulong
ulong =
    Jdec.succeed Ulong
        |> Jpipe.required "ulong" Jdec.int

encodeUlong : Ulong -> Jenc.Value
encodeUlong x =
    Jenc.object
        [ ("ulong", Jenc.int x.ulong)
        ]

unchecked : Jdec.Decoder Unchecked
unchecked =
    Jdec.succeed Unchecked
        |> Jpipe.required "unchecked" Jdec.int

encodeUnchecked : Unchecked -> Jenc.Value
encodeUnchecked x =
    Jenc.object
        [ ("unchecked", Jenc.int x.unchecked)
        ]

undefined : Jdec.Decoder Undefined
undefined =
    Jdec.succeed Undefined
        |> Jpipe.required "undefined" Jdec.int

encodeUndefined : Undefined -> Jenc.Value
encodeUndefined x =
    Jenc.object
        [ ("undefined", Jenc.int x.undefined)
        ]

union : Jdec.Decoder Union
union =
    Jdec.succeed Union
        |> Jpipe.required "union" Jdec.int

encodeUnion : Union -> Jenc.Value
encodeUnion x =
    Jenc.object
        [ ("union", Jenc.int x.union)
        ]

unmarshalJSON : Jdec.Decoder UnmarshalJSON
unmarshalJSON =
    Jdec.succeed UnmarshalJSON
        |> Jpipe.required "UnmarshalJSON" Jdec.int

encodeUnmarshalJSON : UnmarshalJSON -> Jenc.Value
encodeUnmarshalJSON x =
    Jenc.object
        [ ("UnmarshalJSON", Jenc.int x.unmarshalJSON)
        ]

unowned : Jdec.Decoder Unowned
unowned =
    Jdec.succeed Unowned
        |> Jpipe.required "unowned" Jdec.int

encodeUnowned : Unowned -> Jenc.Value
encodeUnowned x =
    Jenc.object
        [ ("unowned", Jenc.int x.unowned)
        ]

unsafe : Jdec.Decoder Unsafe
unsafe =
    Jdec.succeed Unsafe
        |> Jpipe.required "unsafe" Jdec.int

encodeUnsafe : Unsafe -> Jenc.Value
encodeUnsafe x =
    Jenc.object
        [ ("unsafe", Jenc.int x.unsafe)
        ]

unsigned : Jdec.Decoder Unsigned
unsigned =
    Jdec.succeed Unsigned
        |> Jpipe.required "unsigned" Jdec.int

encodeUnsigned : Unsigned -> Jenc.Value
encodeUnsigned x =
    Jenc.object
        [ ("unsigned", Jenc.int x.unsigned)
        ]

useSerializers : Jdec.Decoder UseSerializers
useSerializers =
    Jdec.succeed UseSerializers
        |> Jpipe.required "UseSerializers" Jdec.int

encodeUseSerializers : UseSerializers -> Jenc.Value
encodeUseSerializers x =
    Jenc.object
        [ ("UseSerializers", Jenc.int x.useSerializers)
        ]

ushort : Jdec.Decoder Ushort
ushort =
    Jdec.succeed Ushort
        |> Jpipe.required "ushort" Jdec.int

encodeUshort : Ushort -> Jenc.Value
encodeUshort x =
    Jenc.object
        [ ("ushort", Jenc.int x.ushort)
        ]

using : Jdec.Decoder Using
using =
    Jdec.succeed Using
        |> Jpipe.required "using" Jdec.int

encodeUsing : Using -> Jenc.Value
encodeUsing x =
    Jenc.object
        [ ("using", Jenc.int x.using)
        ]

utf8JSONReader : Jdec.Decoder Utf8JSONReader
utf8JSONReader =
    Jdec.succeed Utf8JSONReader
        |> Jpipe.required "Utf8JsonReader" Jdec.int

encodeUtf8JSONReader : Utf8JSONReader -> Jenc.Value
encodeUtf8JSONReader x =
    Jenc.object
        [ ("Utf8JsonReader", Jenc.int x.utf8JSONReader)
        ]

utf8JSONWriter : Jdec.Decoder Utf8JSONWriter
utf8JSONWriter =
    Jdec.succeed Utf8JSONWriter
        |> Jpipe.required "Utf8JsonWriter" Jdec.int

encodeUtf8JSONWriter : Utf8JSONWriter -> Jenc.Value
encodeUtf8JSONWriter x =
    Jenc.object
        [ ("Utf8JsonWriter", Jenc.int x.utf8JSONWriter)
        ]

uuid : Jdec.Decoder UUID
uuid =
    Jdec.succeed UUID
        |> Jpipe.required "UUID" Jdec.int

encodeUUID : UUID -> Jenc.Value
encodeUUID x =
    Jenc.object
        [ ("UUID", Jenc.int x.uuid)
        ]

var : Jdec.Decoder Var
var =
    Jdec.succeed Var
        |> Jpipe.required "var" Jdec.int

encodeVar : Var -> Jenc.Value
encodeVar x =
    Jenc.object
        [ ("var", Jenc.int x.var)
        ]

virtual : Jdec.Decoder Virtual
virtual =
    Jdec.succeed Virtual
        |> Jpipe.required "virtual" Jdec.int

encodeVirtual : Virtual -> Jenc.Value
encodeVirtual x =
    Jenc.object
        [ ("virtual", Jenc.int x.virtual)
        ]

void : Jdec.Decoder Void
void =
    Jdec.succeed Void
        |> Jpipe.required "void" Jdec.int

encodeVoid : Void -> Jenc.Value
encodeVoid x =
    Jenc.object
        [ ("void", Jenc.int x.void)
        ]

volatile : Jdec.Decoder Volatile
volatile =
    Jdec.succeed Volatile
        |> Jpipe.required "volatile" Jdec.int

encodeVolatile : Volatile -> Jenc.Value
encodeVolatile x =
    Jenc.object
        [ ("volatile", Jenc.int x.volatile)
        ]

wcharT : Jdec.Decoder WcharT
wcharT =
    Jdec.succeed WcharT
        |> Jpipe.required "wchar_t" Jdec.int

encodeWcharT : WcharT -> Jenc.Value
encodeWcharT x =
    Jenc.object
        [ ("wchar_t", Jenc.int x.wcharT)
        ]

weak : Jdec.Decoder Weak
weak =
    Jdec.succeed Weak
        |> Jpipe.required "weak" Jdec.int

encodeWeak : Weak -> Jenc.Value
encodeWeak x =
    Jenc.object
        [ ("weak", Jenc.int x.weak)
        ]

while : Jdec.Decoder While
while =
    Jdec.succeed While
        |> Jpipe.required "while" Jdec.int

encodeWhile : While -> Jenc.Value
encodeWhile x =
    Jenc.object
        [ ("while", Jenc.int x.while)
        ]

willSet : Jdec.Decoder WillSet
willSet =
    Jdec.succeed WillSet
        |> Jpipe.required "willSet" Jdec.int

encodeWillSet : WillSet -> Jenc.Value
encodeWillSet x =
    Jenc.object
        [ ("willSet", Jenc.int x.willSet)
        ]

with : Jdec.Decoder With
with =
    Jdec.succeed With
        |> Jpipe.required "with" Jdec.int

encodeWith : With -> Jenc.Value
encodeWith x =
    Jenc.object
        [ ("with", Jenc.int x.with)
        ]

xor : Jdec.Decoder Xor
xor =
    Jdec.succeed Xor
        |> Jpipe.required "xor" Jdec.int

encodeXor : Xor -> Jenc.Value
encodeXor x =
    Jenc.object
        [ ("xor", Jenc.int x.xor)
        ]

xorEq : Jdec.Decoder XorEq
xorEq =
    Jdec.succeed XorEq
        |> Jpipe.required "xor_eq" Jdec.int

encodeXorEq : XorEq -> Jenc.Value
encodeXorEq x =
    Jenc.object
        [ ("xor_eq", Jenc.int x.xorEq)
        ]

yes : Jdec.Decoder Yes
yes =
    Jdec.succeed Yes
        |> Jpipe.required "YES" Jdec.int

encodeYes : Yes -> Jenc.Value
encodeYes x =
    Jenc.object
        [ ("YES", Jenc.int x.yes)
        ]

yield : Jdec.Decoder Yield
yield =
    Jdec.succeed Yield
        |> Jpipe.required "yield" Jdec.int

encodeYield : Yield -> Jenc.Value
encodeYield x =
    Jenc.object
        [ ("yield", Jenc.int x.yield)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
