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
    , Empty
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
    , Imaginery
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
    , KSerializer
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
    , PrimitiveKind
    , Print
    , PrintMembers
    , Printf
    , Private
    , Protected
    , Protocol
    , Public
    , UnionBoolBool
    , TypeClass
    , AnyClass
    , As
    , Bool
    , BoolClass
    , Case
    , ClassClass
    , Decoder
    , Else
    , Exposing
    , UnionFalseFalse
    , FloatClass
    , If
    , Import
    , In
    , Infix
    , IntClass
    , Let
    , Module
    , NoneClass
    , NullClass
    , Of
    , Port
    , ProtocolClass
    , SelfClass
    , StringClass
    , Then
    , UnionTrueTrue
    , Type
    , Where
    , Quicktype
    , Raise
    , Range
    , Readonly
    , Ref
    , RegExp
    , Register
    , ReinterpretCast
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
    , UnionAbstract(..)
    , UnionAlignas(..)
    , UnionAlignof(..)
    , UnionAnd(..)
    , UnionAndEq(..)
    , UnionAny(..)
    , UnionArray(..)
    , UnionArrayNode(..)
    , UnionASM(..)
    , UnionAssert(..)
    , UnionAssociatedtype(..)
    , UnionAssociativity(..)
    , UnionAsync(..)
    , UnionAtomic(..)
    , UnionAtomicCancel(..)
    , UnionAtomicCommit(..)
    , UnionAtomicNoexcept(..)
    , UnionAuto(..)
    , UnionAwait(..)
    , UnionBase(..)
    , UnionBitand(..)
    , UnionBitor(..)
    , UnionBoolean(..)
    , UnionBooleanNode(..)
    , UnionBreak(..)
    , UnionBycopy(..)
    , UnionByref(..)
    , UnionByte(..)
    , UnionCalendar(..)
    , UnionCatch(..)
    , UnionChan(..)
    , UnionChar(..)
    , UnionChar16T(..)
    , UnionChar32T(..)
    , UnionChecked(..)
    , UnionClass(..)
    , UnionClone(..)
    , UnionCoAwait(..)
    , UnionCoReturn(..)
    , UnionCoYield(..)
    , UnionCodable(..)
    , UnionCodingKey(..)
    , UnionCodingKeys(..)
    , UnionCompl(..)
    , UnionComplex(..)
    , UnionConcept(..)
    , UnionConsole(..)
    , UnionConst(..)
    , UnionConstCast(..)
    , UnionConstexpr(..)
    , UnionConstructor(..)
    , UnionContinue(..)
    , UnionConvenience(..)
    , UnionConvert(..)
    , UnionConverter(..)
    , UnionCultureInfo(..)
    , UnionDate(..)
    , UnionDateFormatter(..)
    , UnionDateOnly(..)
    , UnionDateOnlyConverter(..)
    , UnionDateParseHandling(..)
    , UnionDateTime(..)
    , UnionDateTimeStyles(..)
    , UnionDebugger(..)
    , UnionDecimal(..)
    , UnionDeclare(..)
    , UnionDecltype(..)
    , UnionDecodeString(..)
    , UnionDecodingError(..)
    , UnionDef(..)
    , UnionDefault(..)
    , UnionDefer(..)
    , UnionDeinit(..)
    , UnionDel(..)
    , UnionDelegate(..)
    , UnionDelete(..)
    , UnionDeserializationFeature(..)
    , UnionDict(..)
    , UnionDictionary(..)
    , UnionDidSet(..)
    , UnionDo(..)
    , UnionDouble(..)
    , UnionDoubleNode(..)
    , UnionDynamic(..)
    , UnionDynamicCast(..)
    , UnionElif(..)
    , UnionUnion(..)
    , UnionEncodeQuickType(..)
    , UnionEncoder(..)
    , UnionEnum(..)
    , UnionEnumValues(..)
    , UnionEqualityContract(..)
    , UnionEquatable(..)
    , UnionEvent(..)
    , UnionExcept(..)
    , UnionException(..)
    , UnionExplicit(..)
    , UnionExport(..)
    , UnionExtends(..)
    , UnionExtension(..)
    , UnionExtern(..)
    , UnionFallthrough(..)
    , UnionFalse(..)
    , UnionFileprivate(..)
    , UnionFinal(..)
    , UnionFinally(..)
    , UnionFixed(..)
    , UnionFor(..)
    , UnionForeach(..)
    , UnionFormatException(..)
    , UnionFriend(..)
    , UnionFrom(..)
    , UnionFromDict(..)
    , UnionFromJSON(..)
    , UnionFunc(..)
    , UnionFunction(..)
    , UnionGet(..)
    , UnionGlobal(..)
    , UnionGo(..)
    , UnionGoto(..)
    , UnionGuard(..)
    , UnionHasOwnProperty(..)
    , UnionHashCode(..)
    , UnionHashable(..)
    , UnionHasher(..)
    , UnionID(..)
    , UnionImaginery(..)
    , UnionIMP(..)
    , UnionImplements(..)
    , UnionImplicit(..)
    , UnionIndirect(..)
    , UnionInit(..)
    , UnionInline(..)
    , UnionInout(..)
    , UnionInstanceof(..)
    , UnionIntNode(..)
    , UnionInterface(..)
    , UnionInternal(..)
    , UnionIs(..)
    , UnionISODateTimeOffsetConverter(..)
    , UnionIterable(..)
    , UnionJdec(..)
    , UnionJenc(..)
    , UnionJpipe(..)
    , UnionJSON(..)
    , UnionJSONAny(..)
    , UnionJSONCodingKey(..)
    , UnionJSONConverter(..)
    , UnionJSONDecoder(..)
    , UnionJSONEncoder(..)
    , UnionJSONException(..)
    , UnionJSONGenerator(..)
    , UnionJSONNode(..)
    , UnionJSONNull(..)
    , UnionJSONParser(..)
    , UnionJSONReader(..)
    , UnionJSONSerializer(..)
    , UnionJSONToken(..)
    , UnionJSONTokenType(..)
    , UnionJSONWriter(..)
    , UnionKSerializer(..)
    , UnionLambda(..)
    , UnionLazy(..)
    , UnionLeft(..)
    , UnionList(..)
    , UnionLocalDate(..)
    , UnionLocale(..)
    , UnionLock(..)
    , UnionLong(..)
    , UnionLongNode(..)
    , UnionMap(..)
    , UnionMapEntry(..)
    , UnionMarshalJSON(..)
    , UnionMetadataPropertyHandling(..)
    , UnionMutable(..)
    , UnionMutating(..)
    , UnionNamespace(..)
    , UnionNative(..)
    , UnionNew(..)
    , UnionNewtonsoft(..)
    , UnionNil(..)
    , UnionNO(..)
    , UnionNoSuchMethod(..)
    , UnionNoexcept(..)
    , UnionNonatomic(..)
    , UnionNone(..)
    , UnionNonlocal(..)
    , UnionNonmutating(..)
    , UnionNot(..)
    , UnionNotEq(..)
    , UnionNSError(..)
    , UnionNSObject(..)
    , UnionNSString(..)
    , UnionNULL(..)
    , UnionNullNode(..)
    , UnionNullptr(..)
    , UnionNumber(..)
    , UnionObject(..)
    , UnionObjectMapper(..)
    , UnionObjectNode(..)
    , UnionObjectReader(..)
    , UnionObjectWriter(..)
    , UnionOffsetDateTime(..)
    , UnionOffsetTime(..)
    , UnionOneway(..)
    , UnionOpen(..)
    , UnionOperator(..)
    , UnionOptional(..)
    , UnionOr(..)
    , UnionOrEq(..)
    , UnionOut(..)
    , UnionOverride(..)
    , UnionPackage(..)
    , UnionParams(..)
    , UnionPass(..)
    , UnionPostfix(..)
    , UnionPrecedence(..)
    , UnionPrefix(..)
    , UnionPrimitiveKind(..)
    , UnionPrint(..)
    , UnionPrintMembers(..)
    , UnionPrintf(..)
    , UnionPrivate(..)
    , UnionProtected(..)
    , UnionProtocol(..)
    , UnionPublic(..)
    , UnionBoolUnion(..)
    , UnionTypeUnion(..)
    , UnionAnyUnion(..)
    , UnionAs(..)
    , UnionBOOL(..)
    , UnionBool(..)
    , UnionCase(..)
    , UnionClassUnion(..)
    , UnionDecoder(..)
    , UnionElse(..)
    , UnionExposing(..)
    , UnionFalseUnion(..)
    , UnionFloat(..)
    , UnionIf(..)
    , UnionImport(..)
    , UnionIn(..)
    , UnionInfix(..)
    , UnionInt(..)
    , UnionLet(..)
    , UnionModule(..)
    , UnionNoneUnion(..)
    , UnionNull(..)
    , UnionOf(..)
    , UnionPort(..)
    , UnionProtocolUnion(..)
    , UnionSelfUnion(..)
    , UnionString(..)
    , UnionThen(..)
    , UnionTrueUnion(..)
    , UnionType(..)
    , UnionWhere(..)
    , UnionQuicktype(..)
    , UnionRaise(..)
    , UnionRange(..)
    , UnionReadonly(..)
    , UnionRef(..)
    , UnionRegExp(..)
    , UnionRegister(..)
    , UnionReinterpretCast(..)
    , UnionRepeat(..)
    , UnionRequire(..)
    , UnionRequired(..)
    , UnionRequires(..)
    , UnionRestrict(..)
    , UnionRetain(..)
    , UnionRethrows(..)
    , UnionReturn(..)
    , UnionRight(..)
    , UnionRuntimeType(..)
    , UnionS(..)
    , UnionSbyte(..)
    , UnionSealed(..)
    , UnionSEL(..)
    , UnionSelect(..)
    , UnionSelf(..)
    , UnionSendable(..)
    , UnionSerialDescriptor(..)
    , UnionSerialName(..)
    , UnionSerializable(..)
    , UnionSerializationFeature(..)
    , UnionSerialize(..)
    , UnionSerializerProvider(..)
    , UnionSet(..)
    , UnionShort(..)
    , UnionSigned(..)
    , UnionSimpleModule(..)
    , UnionSizeof(..)
    , UnionStackalloc(..)
    , UnionStandards(..)
    , UnionStatic(..)
    , UnionStaticAssert(..)
    , UnionStaticCast(..)
    , UnionStdDeserializer(..)
    , UnionStdSerializer(..)
    , UnionStrictfp(..)
    , UnionStruct(..)
    , UnionSubscript(..)
    , UnionSuper(..)
    , UnionSwitch(..)
    , UnionSymbol(..)
    , UnionSynchronized(..)
    , UnionSystem(..)
    , UnionTemplate(..)
    , UnionTextNode(..)
    , UnionThis(..)
    , UnionThreadLocal(..)
    , UnionThrow(..)
    , UnionThrows(..)
    , UnionTimeOnly(..)
    , UnionTimeOnlyConverter(..)
    , UnionTimeZone(..)
    , UnionToDict(..)
    , UnionToJSON(..)
    , UnionToString(..)
    , UnionTopLevel(..)
    , UnionTransient(..)
    , UnionTrue(..)
    , UnionTry(..)
    , UnionTypealias(..)
    , UnionTypedef(..)
    , UnionTypeid(..)
    , UnionTypename(..)
    , UnionTypeof(..)
    , UnionUint(..)
    , UnionUlong(..)
    , UnionUnchecked(..)
    , UnionUndefined(..)
    , UnionUnionUnion(..)
    , UnionUnmarshalJSON(..)
    , UnionUnowned(..)
    , UnionUnsafe(..)
    , UnionUnsigned(..)
    , UnionUseSerializers(..)
    , UnionUshort(..)
    , UnionUsing(..)
    , UnionUtf8JSONReader(..)
    , UnionUtf8JSONWriter(..)
    , UnionUUID(..)
    , UnionVar(..)
    , UnionVirtual(..)
    , UnionVoid(..)
    , UnionVolatile(..)
    , UnionWcharT(..)
    , UnionWeak(..)
    , UnionWhile(..)
    , UnionWillSet(..)
    , UnionWith(..)
    , UnionXor(..)
    , UnionXorEq(..)
    , UnionYES(..)
    , UnionYield(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { empty : Maybe UnionUnion
    , quickTypeBool : Maybe UnionBool
    , complex : Maybe UnionComplex
    , imaginery : Maybe UnionImaginery
    , abstract : Maybe UnionAbstract
    , alignas : Maybe UnionAlignas
    , alignof : Maybe UnionAlignof
    , and : Maybe UnionAnd
    , andEq : Maybe UnionAndEq
    , quickTypeAny : Maybe UnionAnyUnion
    , any : Maybe UnionAny
    , array : Maybe UnionArray
    , arrayNode : Maybe UnionArrayNode
    , quickTypeAs : Maybe UnionAs
    , asm : Maybe UnionASM
    , assert : Maybe UnionAssert
    , associatedtype : Maybe UnionAssociatedtype
    , associativity : Maybe UnionAssociativity
    , async : Maybe UnionAsync
    , atomic : Maybe UnionAtomic
    , atomicCancel : Maybe UnionAtomicCancel
    , atomicCommit : Maybe UnionAtomicCommit
    , atomicNoexcept : Maybe UnionAtomicNoexcept
    , auto : Maybe UnionAuto
    , await : Maybe UnionAwait
    , base : Maybe UnionBase
    , bitand : Maybe UnionBitand
    , bitor : Maybe UnionBitor
    , quickTypeBOOL : Maybe UnionBOOL
    , purpleBool : Maybe UnionBoolUnion
    , boolean : Maybe UnionBoolean
    , booleanNode : Maybe UnionBooleanNode
    , break : Maybe UnionBreak
    , bycopy : Maybe UnionBycopy
    , byref : Maybe UnionByref
    , byte : Maybe UnionByte
    , calendar : Maybe UnionCalendar
    , quickTypeCase : Maybe UnionCase
    , catch : Maybe UnionCatch
    , chan : Maybe UnionChan
    , char : Maybe UnionChar
    , char16T : Maybe UnionChar16T
    , char32T : Maybe UnionChar32T
    , checked : Maybe UnionChecked
    , quickTypeClass : Maybe UnionClassUnion
    , class : Maybe UnionClass
    , clone : Maybe UnionClone
    , coAwait : Maybe UnionCoAwait
    , coReturn : Maybe UnionCoReturn
    , coYield : Maybe UnionCoYield
    , codable : Maybe UnionCodable
    , codingKey : Maybe UnionCodingKey
    , codingKeys : Maybe UnionCodingKeys
    , compl : Maybe UnionCompl
    , concept : Maybe UnionConcept
    , console : Maybe UnionConsole
    , const : Maybe UnionConst
    , constCast : Maybe UnionConstCast
    , constexpr : Maybe UnionConstexpr
    , constructor : Maybe UnionConstructor
    , continue : Maybe UnionContinue
    , convenience : Maybe UnionConvenience
    , convert : Maybe UnionConvert
    , converter : Maybe UnionConverter
    , cultureInfo : Maybe UnionCultureInfo
    , date : Maybe UnionDate
    , dateParseHandling : Maybe UnionDateParseHandling
    , dateFormatter : Maybe UnionDateFormatter
    , dateOnly : Maybe UnionDateOnly
    , dateOnlyConverter : Maybe UnionDateOnlyConverter
    , dateTime : Maybe UnionDateTime
    , dateTimeStyles : Maybe UnionDateTimeStyles
    , debugger : Maybe UnionDebugger
    , decimal : Maybe UnionDecimal
    , declare : Maybe UnionDeclare
    , decltype : Maybe UnionDecltype
    , decodeString : Maybe UnionDecodeString
    , quickTypeDecoder : Maybe UnionDecoder
    , decodingError : Maybe UnionDecodingError
    , def : Maybe UnionDef
    , default : Maybe UnionDefault
    , defer : Maybe UnionDefer
    , deinit : Maybe UnionDeinit
    , del : Maybe UnionDel
    , delegate : Maybe UnionDelegate
    , delete : Maybe UnionDelete
    , deserializationFeature : Maybe UnionDeserializationFeature
    , dict : Maybe UnionDict
    , dictionary : Maybe UnionDictionary
    , didSet : Maybe UnionDidSet
    , do : Maybe UnionDo
    , double : Maybe UnionDouble
    , doubleNode : Maybe UnionDoubleNode
    , dummy : Maybe Float
    , dynamic : Maybe UnionDynamic
    , dynamicCast : Maybe UnionDynamicCast
    , elif : Maybe UnionElif
    , quickTypeElse : Maybe UnionElse
    , encodeQuickType : Maybe UnionEncodeQuickType
    , encoder : Maybe UnionEncoder
    , enum : Maybe UnionEnum
    , enumValues : Maybe UnionEnumValues
    , equalityContract : Maybe UnionEqualityContract
    , equatable : Maybe UnionEquatable
    , event : Maybe UnionEvent
    , except : Maybe UnionExcept
    , exception : Maybe UnionException
    , explicit : Maybe UnionExplicit
    , export : Maybe UnionExport
    , quickTypeExposing : Maybe UnionExposing
    , extends : Maybe UnionExtends
    , extension : Maybe UnionExtension
    , extern : Maybe UnionExtern
    , fallthrough : Maybe UnionFallthrough
    , quickTypeFalse : Maybe UnionFalseUnion
    , false : Maybe UnionFalse
    , fileprivate : Maybe UnionFileprivate
    , final : Maybe UnionFinal
    , finally : Maybe UnionFinally
    , fixed : Maybe UnionFixed
    , quickTypeFloat : Maybe UnionFloat
    , for : Maybe UnionFor
    , foreach : Maybe UnionForeach
    , formatException : Maybe UnionFormatException
    , friend : Maybe UnionFriend
    , from : Maybe UnionFrom
    , fromDict : Maybe UnionFromDict
    , fromJSON : Maybe UnionFromJSON
    , func : Maybe UnionFunc
    , function : Maybe UnionFunction
    , get : Maybe UnionGet
    , global : Maybe UnionGlobal
    , go : Maybe UnionGo
    , goto : Maybe UnionGoto
    , guard : Maybe UnionGuard
    , hashable : Maybe UnionHashable
    , hashCode : Maybe UnionHashCode
    , hasher : Maybe UnionHasher
    , hasOwnProperty : Maybe UnionHasOwnProperty
    , id : Maybe UnionID
    , quickTypeIf : Maybe UnionIf
    , imp : Maybe UnionIMP
    , implements : Maybe UnionImplements
    , implicit : Maybe UnionImplicit
    , quickTypeImport : Maybe UnionImport
    , quickTypeIn : Maybe UnionIn
    , indirect : Maybe UnionIndirect
    , quickTypeInfix : Maybe UnionInfix
    , init : Maybe UnionInit
    , inline : Maybe UnionInline
    , inout : Maybe UnionInout
    , instanceof : Maybe UnionInstanceof
    , quickTypeInt : Maybe UnionInt
    , interface : Maybe UnionInterface
    , internal : Maybe UnionInternal
    , intNode : Maybe UnionIntNode
    , is : Maybe UnionIs
    , isoDateTimeOffsetConverter : Maybe UnionISODateTimeOffsetConverter
    , iterable : Maybe UnionIterable
    , jdec : Maybe UnionJdec
    , jenc : Maybe UnionJenc
    , jpipe : Maybe UnionJpipe
    , json : Maybe UnionJSON
    , jsonConverter : Maybe UnionJSONConverter
    , jsonSerializer : Maybe UnionJSONSerializer
    , jsonToken : Maybe UnionJSONToken
    , jsonWriter : Maybe UnionJSONWriter
    , jsonAny : Maybe UnionJSONAny
    , jsonCodingKey : Maybe UnionJSONCodingKey
    , jsonDecoder : Maybe UnionJSONDecoder
    , jsonEncoder : Maybe UnionJSONEncoder
    , jsonException : Maybe UnionJSONException
    , jsonGenerator : Maybe UnionJSONGenerator
    , jsonNode : Maybe UnionJSONNode
    , jsonNull : Maybe UnionJSONNull
    , jsonParser : Maybe UnionJSONParser
    , jsonReader : Maybe UnionJSONReader
    , jsonTokenType : Maybe UnionJSONTokenType
    , kSerializer : Maybe UnionKSerializer
    , lambda : Maybe UnionLambda
    , lazy : Maybe UnionLazy
    , left : Maybe UnionLeft
    , quickTypeLet : Maybe UnionLet
    , list : Maybe UnionList
    , localDate : Maybe UnionLocalDate
    , locale : Maybe UnionLocale
    , lock : Maybe UnionLock
    , long : Maybe UnionLong
    , longNode : Maybe UnionLongNode
    , map : Maybe UnionMap
    , mapEntry : Maybe UnionMapEntry
    , marshalJSON : Maybe UnionMarshalJSON
    , metadataPropertyHandling : Maybe UnionMetadataPropertyHandling
    , quickTypeModule : Maybe UnionModule
    , mutable : Maybe UnionMutable
    , mutating : Maybe UnionMutating
    , namespace : Maybe UnionNamespace
    , native : Maybe UnionNative
    , new : Maybe UnionNew
    , newtonsoft : Maybe UnionNewtonsoft
    , nil : Maybe UnionNil
    , no : Maybe UnionNO
    , noexcept : Maybe UnionNoexcept
    , nonatomic : Maybe UnionNonatomic
    , quickTypeNone : Maybe UnionNoneUnion
    , none : Maybe UnionNone
    , nonlocal : Maybe UnionNonlocal
    , nonmutating : Maybe UnionNonmutating
    , noSuchMethod : Maybe UnionNoSuchMethod
    , not : Maybe UnionNot
    , notEq : Maybe UnionNotEq
    , nsError : Maybe UnionNSError
    , nsObject : Maybe UnionNSObject
    , nsString : Maybe UnionNSString
    , null : Maybe UnionNULL
    , quickTypeNull : Maybe UnionNull
    , nullNode : Maybe UnionNullNode
    , nullptr : Maybe UnionNullptr
    , number : Maybe UnionNumber
    , object : Maybe UnionObject
    , objectMapper : Maybe UnionObjectMapper
    , objectNode : Maybe UnionObjectNode
    , objectReader : Maybe UnionObjectReader
    , objectWriter : Maybe UnionObjectWriter
    , quickTypeOf : Maybe UnionOf
    , offsetDateTime : Maybe UnionOffsetDateTime
    , offsetTime : Maybe UnionOffsetTime
    , oneway : Maybe UnionOneway
    , open : Maybe UnionOpen
    , operator : Maybe UnionOperator
    , optional : Maybe UnionOptional
    , or : Maybe UnionOr
    , orEq : Maybe UnionOrEq
    , out : Maybe UnionOut
    , override : Maybe UnionOverride
    , package : Maybe UnionPackage
    , params : Maybe UnionParams
    , pass : Maybe UnionPass
    , quickTypePort : Maybe UnionPort
    , postfix : Maybe UnionPostfix
    , precedence : Maybe UnionPrecedence
    , prefix : Maybe UnionPrefix
    , primitiveKind : Maybe UnionPrimitiveKind
    , print : Maybe UnionPrint
    , printf : Maybe UnionPrintf
    , printMembers : Maybe UnionPrintMembers
    , private : Maybe UnionPrivate
    , protected : Maybe UnionProtected
    , protocol : Maybe UnionProtocol
    , quickTypeProtocol : Maybe UnionProtocolUnion
    , public : Maybe UnionPublic
    , quicktype : Maybe UnionQuicktype
    , raise : Maybe UnionRaise
    , range : Maybe UnionRange
    , readonly : Maybe UnionReadonly
    , ref : Maybe UnionRef
    , regExp : Maybe UnionRegExp
    , register : Maybe UnionRegister
    , reinterpretCast : Maybe UnionReinterpretCast
    , repeat : Maybe UnionRepeat
    , require : Maybe UnionRequire
    , required : Maybe UnionRequired
    , requires : Maybe UnionRequires
    , restrict : Maybe UnionRestrict
    , retain : Maybe UnionRetain
    , rethrows : Maybe UnionRethrows
    , return : Maybe UnionReturn
    , right : Maybe UnionRight
    , runtimeType : Maybe UnionRuntimeType
    , s : Maybe UnionS
    , sbyte : Maybe UnionSbyte
    , sealed : Maybe UnionSealed
    , sel : Maybe UnionSEL
    , select : Maybe UnionSelect
    , self : Maybe UnionSelf
    , quickTypeSelf : Maybe UnionSelfUnion
    , sendable : Maybe UnionSendable
    , serialDescriptor : Maybe UnionSerialDescriptor
    , serializable : Maybe UnionSerializable
    , serializationFeature : Maybe UnionSerializationFeature
    , serialize : Maybe UnionSerialize
    , serializerProvider : Maybe UnionSerializerProvider
    , serialName : Maybe UnionSerialName
    , set : Maybe UnionSet
    , short : Maybe UnionShort
    , signed : Maybe UnionSigned
    , simpleModule : Maybe UnionSimpleModule
    , sizeof : Maybe UnionSizeof
    , stackalloc : Maybe UnionStackalloc
    , standards : Maybe UnionStandards
    , static : Maybe UnionStatic
    , staticAssert : Maybe UnionStaticAssert
    , staticCast : Maybe UnionStaticCast
    , stdDeserializer : Maybe UnionStdDeserializer
    , stdSerializer : Maybe UnionStdSerializer
    , strictfp : Maybe UnionStrictfp
    , quickTypeString : Maybe UnionString
    , struct : Maybe UnionStruct
    , subscript : Maybe UnionSubscript
    , super : Maybe UnionSuper
    , switch : Maybe UnionSwitch
    , symbol : Maybe UnionSymbol
    , synchronized : Maybe UnionSynchronized
    , system : Maybe UnionSystem
    , template : Maybe UnionTemplate
    , textNode : Maybe UnionTextNode
    , quickTypeThen : Maybe UnionThen
    , this : Maybe UnionThis
    , threadLocal : Maybe UnionThreadLocal
    , throw : Maybe UnionThrow
    , throws : Maybe UnionThrows
    , timeOnly : Maybe UnionTimeOnly
    , timeOnlyConverter : Maybe UnionTimeOnlyConverter
    , timeZone : Maybe UnionTimeZone
    , toDict : Maybe UnionToDict
    , toJSON : Maybe UnionToJSON
    , topLevel : Maybe UnionTopLevel
    , toString : Maybe UnionToString
    , transient : Maybe UnionTransient
    , true : Maybe UnionTrue
    , quickTypeTrue : Maybe UnionTrueUnion
    , try : Maybe UnionTry
    , quickTypeType : Maybe UnionType
    , purpleType : Maybe UnionTypeUnion
    , typealias : Maybe UnionTypealias
    , typedef : Maybe UnionTypedef
    , typeid : Maybe UnionTypeid
    , typename : Maybe UnionTypename
    , typeof : Maybe UnionTypeof
    , uint : Maybe UnionUint
    , ulong : Maybe UnionUlong
    , unchecked : Maybe UnionUnchecked
    , undefined : Maybe UnionUndefined
    , union : Maybe UnionUnionUnion
    , unmarshalJSON : Maybe UnionUnmarshalJSON
    , unowned : Maybe UnionUnowned
    , unsafe : Maybe UnionUnsafe
    , unsigned : Maybe UnionUnsigned
    , useSerializers : Maybe UnionUseSerializers
    , ushort : Maybe UnionUshort
    , using : Maybe UnionUsing
    , utf8JSONReader : Maybe UnionUtf8JSONReader
    , utf8JSONWriter : Maybe UnionUtf8JSONWriter
    , uuid : Maybe UnionUUID
    , var : Maybe UnionVar
    , virtual : Maybe UnionVirtual
    , void : Maybe UnionVoid
    , volatile : Maybe UnionVolatile
    , wcharT : Maybe UnionWcharT
    , weak : Maybe UnionWeak
    , quickTypeWhere : Maybe UnionWhere
    , while : Maybe UnionWhile
    , willSet : Maybe UnionWillSet
    , with : Maybe UnionWith
    , xor : Maybe UnionXor
    , xorEq : Maybe UnionXorEq
    , yes : Maybe UnionYES
    , yield : Maybe UnionYield
    }

type UnionAbstract
    = AbstractInUnionAbstract Abstract
    | DoubleInUnionAbstract Float

type alias Abstract =
    {
    }

type UnionAlignas
    = AlignasInUnionAlignas Alignas
    | DoubleInUnionAlignas Float

type alias Alignas =
    {
    }

type UnionAlignof
    = AlignofInUnionAlignof Alignof
    | DoubleInUnionAlignof Float

type alias Alignof =
    {
    }

type UnionAnd
    = AndInUnionAnd And
    | DoubleInUnionAnd Float

type alias And =
    {
    }

type UnionAndEq
    = AndEqInUnionAndEq AndEq
    | DoubleInUnionAndEq Float

type alias AndEq =
    {
    }

type UnionAny
    = AnyInUnionAny Any
    | DoubleInUnionAny Float

type alias Any =
    {
    }

type UnionArray
    = ArrayClassInUnionArray ArrayClass
    | DoubleInUnionArray Float

type alias ArrayClass =
    {
    }

type UnionArrayNode
    = ArrayNodeInUnionArrayNode ArrayNode
    | DoubleInUnionArrayNode Float

type alias ArrayNode =
    {
    }

type UnionASM
    = ASMInUnionASM ASM
    | DoubleInUnionASM Float

type alias ASM =
    {
    }

type UnionAssert
    = AssertInUnionAssert Assert
    | DoubleInUnionAssert Float

type alias Assert =
    {
    }

type UnionAssociatedtype
    = AssociatedtypeInUnionAssociatedtype Associatedtype
    | DoubleInUnionAssociatedtype Float

type alias Associatedtype =
    {
    }

type UnionAssociativity
    = AssociativityInUnionAssociativity Associativity
    | DoubleInUnionAssociativity Float

type alias Associativity =
    {
    }

type UnionAsync
    = AsyncInUnionAsync Async
    | DoubleInUnionAsync Float

type alias Async =
    {
    }

type UnionAtomic
    = AtomicInUnionAtomic Atomic
    | DoubleInUnionAtomic Float

type alias Atomic =
    {
    }

type UnionAtomicCancel
    = AtomicCancelInUnionAtomicCancel AtomicCancel
    | DoubleInUnionAtomicCancel Float

type alias AtomicCancel =
    {
    }

type UnionAtomicCommit
    = AtomicCommitInUnionAtomicCommit AtomicCommit
    | DoubleInUnionAtomicCommit Float

type alias AtomicCommit =
    {
    }

type UnionAtomicNoexcept
    = AtomicNoexceptInUnionAtomicNoexcept AtomicNoexcept
    | DoubleInUnionAtomicNoexcept Float

type alias AtomicNoexcept =
    {
    }

type UnionAuto
    = AutoInUnionAuto Auto
    | DoubleInUnionAuto Float

type alias Auto =
    {
    }

type UnionAwait
    = AwaitInUnionAwait Await
    | DoubleInUnionAwait Float

type alias Await =
    {
    }

type UnionBase
    = BaseInUnionBase Base
    | DoubleInUnionBase Float

type alias Base =
    {
    }

type UnionBitand
    = BitandInUnionBitand Bitand
    | DoubleInUnionBitand Float

type alias Bitand =
    {
    }

type UnionBitor
    = BitorInUnionBitor Bitor
    | DoubleInUnionBitor Float

type alias Bitor =
    {
    }

type UnionBoolean
    = BooleanInUnionBoolean Boolean
    | DoubleInUnionBoolean Float

type alias Boolean =
    {
    }

type UnionBooleanNode
    = BooleanNodeInUnionBooleanNode BooleanNode
    | DoubleInUnionBooleanNode Float

type alias BooleanNode =
    {
    }

type UnionBreak
    = BreakInUnionBreak Break
    | DoubleInUnionBreak Float

type alias Break =
    {
    }

type UnionBycopy
    = BycopyInUnionBycopy Bycopy
    | DoubleInUnionBycopy Float

type alias Bycopy =
    {
    }

type UnionByref
    = ByrefInUnionByref Byref
    | DoubleInUnionByref Float

type alias Byref =
    {
    }

type UnionByte
    = ByteInUnionByte Byte
    | DoubleInUnionByte Float

type alias Byte =
    {
    }

type UnionCalendar
    = CalendarInUnionCalendar Calendar
    | DoubleInUnionCalendar Float

type alias Calendar =
    {
    }

type UnionCatch
    = CatchInUnionCatch Catch
    | DoubleInUnionCatch Float

type alias Catch =
    {
    }

type UnionChan
    = ChanInUnionChan Chan
    | DoubleInUnionChan Float

type alias Chan =
    {
    }

type UnionChar
    = CharInUnionChar Char
    | DoubleInUnionChar Float

type alias Char =
    {
    }

type UnionChar16T
    = Char16TInUnionChar16T Char16T
    | DoubleInUnionChar16T Float

type alias Char16T =
    {
    }

type UnionChar32T
    = Char32TInUnionChar32T Char32T
    | DoubleInUnionChar32T Float

type alias Char32T =
    {
    }

type UnionChecked
    = CheckedInUnionChecked Checked
    | DoubleInUnionChecked Float

type alias Checked =
    {
    }

type UnionClass
    = ClassInUnionClass Class
    | DoubleInUnionClass Float

type alias Class =
    {
    }

type UnionClone
    = CloneInUnionClone Clone
    | DoubleInUnionClone Float

type alias Clone =
    {
    }

type UnionCoAwait
    = CoAwaitInUnionCoAwait CoAwait
    | DoubleInUnionCoAwait Float

type alias CoAwait =
    {
    }

type UnionCoReturn
    = CoReturnInUnionCoReturn CoReturn
    | DoubleInUnionCoReturn Float

type alias CoReturn =
    {
    }

type UnionCoYield
    = CoYieldInUnionCoYield CoYield
    | DoubleInUnionCoYield Float

type alias CoYield =
    {
    }

type UnionCodable
    = CodableInUnionCodable Codable
    | DoubleInUnionCodable Float

type alias Codable =
    {
    }

type UnionCodingKey
    = CodingKeyInUnionCodingKey CodingKey
    | DoubleInUnionCodingKey Float

type alias CodingKey =
    {
    }

type UnionCodingKeys
    = CodingKeysInUnionCodingKeys CodingKeys
    | DoubleInUnionCodingKeys Float

type alias CodingKeys =
    {
    }

type UnionCompl
    = ComplInUnionCompl Compl
    | DoubleInUnionCompl Float

type alias Compl =
    {
    }

type UnionComplex
    = ComplexInUnionComplex Complex
    | DoubleInUnionComplex Float

type alias Complex =
    {
    }

type UnionConcept
    = ConceptInUnionConcept Concept
    | DoubleInUnionConcept Float

type alias Concept =
    {
    }

type UnionConsole
    = ConsoleInUnionConsole Console
    | DoubleInUnionConsole Float

type alias Console =
    {
    }

type UnionConst
    = ConstInUnionConst Const
    | DoubleInUnionConst Float

type alias Const =
    {
    }

type UnionConstCast
    = ConstCastInUnionConstCast ConstCast
    | DoubleInUnionConstCast Float

type alias ConstCast =
    {
    }

type UnionConstexpr
    = ConstexprInUnionConstexpr Constexpr
    | DoubleInUnionConstexpr Float

type alias Constexpr =
    {
    }

type UnionConstructor
    = ConstructorInUnionConstructor Constructor
    | DoubleInUnionConstructor Float

type alias Constructor =
    {
    }

type UnionContinue
    = ContinueInUnionContinue Continue
    | DoubleInUnionContinue Float

type alias Continue =
    {
    }

type UnionConvenience
    = ConvenienceInUnionConvenience Convenience
    | DoubleInUnionConvenience Float

type alias Convenience =
    {
    }

type UnionConvert
    = ConvertInUnionConvert Convert
    | DoubleInUnionConvert Float

type alias Convert =
    {
    }

type UnionConverter
    = ConverterInUnionConverter Converter
    | DoubleInUnionConverter Float

type alias Converter =
    {
    }

type UnionCultureInfo
    = CultureInfoInUnionCultureInfo CultureInfo
    | DoubleInUnionCultureInfo Float

type alias CultureInfo =
    {
    }

type UnionDate
    = DateInUnionDate Date
    | DoubleInUnionDate Float

type alias Date =
    {
    }

type UnionDateFormatter
    = DateFormatterInUnionDateFormatter DateFormatter
    | DoubleInUnionDateFormatter Float

type alias DateFormatter =
    {
    }

type UnionDateOnly
    = DateOnlyInUnionDateOnly DateOnly
    | DoubleInUnionDateOnly Float

type alias DateOnly =
    {
    }

type UnionDateOnlyConverter
    = DateOnlyConverterInUnionDateOnlyConverter DateOnlyConverter
    | DoubleInUnionDateOnlyConverter Float

type alias DateOnlyConverter =
    {
    }

type UnionDateParseHandling
    = DateParseHandlingInUnionDateParseHandling DateParseHandling
    | DoubleInUnionDateParseHandling Float

type alias DateParseHandling =
    {
    }

type UnionDateTime
    = DateTimeInUnionDateTime DateTime
    | DoubleInUnionDateTime Float

type alias DateTime =
    {
    }

type UnionDateTimeStyles
    = DateTimeStylesInUnionDateTimeStyles DateTimeStyles
    | DoubleInUnionDateTimeStyles Float

type alias DateTimeStyles =
    {
    }

type UnionDebugger
    = DebuggerInUnionDebugger Debugger
    | DoubleInUnionDebugger Float

type alias Debugger =
    {
    }

type UnionDecimal
    = DecimalInUnionDecimal Decimal
    | DoubleInUnionDecimal Float

type alias Decimal =
    {
    }

type UnionDeclare
    = DeclareInUnionDeclare Declare
    | DoubleInUnionDeclare Float

type alias Declare =
    {
    }

type UnionDecltype
    = DecltypeInUnionDecltype Decltype
    | DoubleInUnionDecltype Float

type alias Decltype =
    {
    }

type UnionDecodeString
    = DecodeStringInUnionDecodeString DecodeString
    | DoubleInUnionDecodeString Float

type alias DecodeString =
    {
    }

type UnionDecodingError
    = DecodingErrorInUnionDecodingError DecodingError
    | DoubleInUnionDecodingError Float

type alias DecodingError =
    {
    }

type UnionDef
    = DefInUnionDef Def
    | DoubleInUnionDef Float

type alias Def =
    {
    }

type UnionDefault
    = DefaultInUnionDefault Default
    | DoubleInUnionDefault Float

type alias Default =
    {
    }

type UnionDefer
    = DeferInUnionDefer Defer
    | DoubleInUnionDefer Float

type alias Defer =
    {
    }

type UnionDeinit
    = DeinitInUnionDeinit Deinit
    | DoubleInUnionDeinit Float

type alias Deinit =
    {
    }

type UnionDel
    = DelInUnionDel Del
    | DoubleInUnionDel Float

type alias Del =
    {
    }

type UnionDelegate
    = DelegateInUnionDelegate Delegate
    | DoubleInUnionDelegate Float

type alias Delegate =
    {
    }

type UnionDelete
    = DeleteInUnionDelete Delete
    | DoubleInUnionDelete Float

type alias Delete =
    {
    }

type UnionDeserializationFeature
    = DeserializationFeatureInUnionDeserializationFeature DeserializationFeature
    | DoubleInUnionDeserializationFeature Float

type alias DeserializationFeature =
    {
    }

type UnionDict
    = DictClassInUnionDict DictClass
    | DoubleInUnionDict Float

type alias DictClass =
    {
    }

type UnionDictionary
    = DictionaryInUnionDictionary Dictionary
    | DoubleInUnionDictionary Float

type alias Dictionary =
    {
    }

type UnionDidSet
    = DidSetInUnionDidSet DidSet
    | DoubleInUnionDidSet Float

type alias DidSet =
    {
    }

type UnionDo
    = DoInUnionDo Do
    | DoubleInUnionDo Float

type alias Do =
    {
    }

type UnionDouble
    = DoubleInUnionDouble Float
    | PurpleDoubleInUnionDouble Double

type alias Double =
    {
    }

type UnionDoubleNode
    = DoubleInUnionDoubleNode Float
    | DoubleNodeInUnionDoubleNode DoubleNode

type alias DoubleNode =
    {
    }

type UnionDynamic
    = DoubleInUnionDynamic Float
    | DynamicInUnionDynamic Dynamic

type alias Dynamic =
    {
    }

type UnionDynamicCast
    = DoubleInUnionDynamicCast Float
    | DynamicCastInUnionDynamicCast DynamicCast

type alias DynamicCast =
    {
    }

type UnionElif
    = DoubleInUnionElif Float
    | ElifInUnionElif Elif

type alias Elif =
    {
    }

type UnionUnion
    = DoubleInUnionUnion Float
    | EmptyInUnionUnion Empty

type alias Empty =
    {
    }

type UnionEncodeQuickType
    = DoubleInUnionEncodeQuickType Float
    | EncodeQuickTypeInUnionEncodeQuickType EncodeQuickType

type alias EncodeQuickType =
    {
    }

type UnionEncoder
    = DoubleInUnionEncoder Float
    | EncoderInUnionEncoder Encoder

type alias Encoder =
    {
    }

type UnionEnum
    = DoubleInUnionEnum Float
    | EnumInUnionEnum Enum

type alias Enum =
    {
    }

type UnionEnumValues
    = DoubleInUnionEnumValues Float
    | EnumValuesInUnionEnumValues EnumValues

type alias EnumValues =
    {
    }

type UnionEqualityContract
    = DoubleInUnionEqualityContract Float
    | EqualityContractInUnionEqualityContract EqualityContract

type alias EqualityContract =
    {
    }

type UnionEquatable
    = DoubleInUnionEquatable Float
    | EquatableInUnionEquatable Equatable

type alias Equatable =
    {
    }

type UnionEvent
    = DoubleInUnionEvent Float
    | EventInUnionEvent Event

type alias Event =
    {
    }

type UnionExcept
    = DoubleInUnionExcept Float
    | ExceptInUnionExcept Except

type alias Except =
    {
    }

type UnionException
    = DoubleInUnionException Float
    | ExceptionInUnionException Exception

type alias Exception =
    {
    }

type UnionExplicit
    = DoubleInUnionExplicit Float
    | ExplicitInUnionExplicit Explicit

type alias Explicit =
    {
    }

type UnionExport
    = DoubleInUnionExport Float
    | ExportInUnionExport Export

type alias Export =
    {
    }

type UnionExtends
    = DoubleInUnionExtends Float
    | ExtendsInUnionExtends Extends

type alias Extends =
    {
    }

type UnionExtension
    = DoubleInUnionExtension Float
    | ExtensionInUnionExtension Extension

type alias Extension =
    {
    }

type UnionExtern
    = DoubleInUnionExtern Float
    | ExternInUnionExtern Extern

type alias Extern =
    {
    }

type UnionFallthrough
    = DoubleInUnionFallthrough Float
    | FallthroughInUnionFallthrough Fallthrough

type alias Fallthrough =
    {
    }

type UnionFalse
    = DoubleInUnionFalse Float
    | FalseClassInUnionFalse FalseClass

type alias FalseClass =
    {
    }

type UnionFileprivate
    = DoubleInUnionFileprivate Float
    | FileprivateInUnionFileprivate Fileprivate

type alias Fileprivate =
    {
    }

type UnionFinal
    = DoubleInUnionFinal Float
    | FinalInUnionFinal Final

type alias Final =
    {
    }

type UnionFinally
    = DoubleInUnionFinally Float
    | FinallyInUnionFinally Finally

type alias Finally =
    {
    }

type UnionFixed
    = DoubleInUnionFixed Float
    | FixedInUnionFixed Fixed

type alias Fixed =
    {
    }

type UnionFor
    = DoubleInUnionFor Float
    | ForInUnionFor For

type alias For =
    {
    }

type UnionForeach
    = DoubleInUnionForeach Float
    | ForeachInUnionForeach Foreach

type alias Foreach =
    {
    }

type UnionFormatException
    = DoubleInUnionFormatException Float
    | FormatExceptionInUnionFormatException FormatException

type alias FormatException =
    {
    }

type UnionFriend
    = DoubleInUnionFriend Float
    | FriendInUnionFriend Friend

type alias Friend =
    {
    }

type UnionFrom
    = DoubleInUnionFrom Float
    | FromInUnionFrom From

type alias From =
    {
    }

type UnionFromDict
    = DoubleInUnionFromDict Float
    | FromDictInUnionFromDict FromDict

type alias FromDict =
    {
    }

type UnionFromJSON
    = DoubleInUnionFromJSON Float
    | FromJSONInUnionFromJSON FromJSON

type alias FromJSON =
    {
    }

type UnionFunc
    = DoubleInUnionFunc Float
    | FuncInUnionFunc Func

type alias Func =
    {
    }

type UnionFunction
    = DoubleInUnionFunction Float
    | FunctionInUnionFunction Function

type alias Function =
    {
    }

type UnionGet
    = DoubleInUnionGet Float
    | GetInUnionGet Get

type alias Get =
    {
    }

type UnionGlobal
    = DoubleInUnionGlobal Float
    | GlobalInUnionGlobal Global

type alias Global =
    {
    }

type UnionGo
    = DoubleInUnionGo Float
    | GoInUnionGo Go

type alias Go =
    {
    }

type UnionGoto
    = DoubleInUnionGoto Float
    | GotoInUnionGoto Goto

type alias Goto =
    {
    }

type UnionGuard
    = DoubleInUnionGuard Float
    | GuardInUnionGuard Guard

type alias Guard =
    {
    }

type UnionHasOwnProperty
    = DoubleInUnionHasOwnProperty Float
    | HasOwnPropertyInUnionHasOwnProperty HasOwnProperty

type alias HasOwnProperty =
    {
    }

type UnionHashCode
    = DoubleInUnionHashCode Float
    | HashCodeInUnionHashCode HashCode

type alias HashCode =
    {
    }

type UnionHashable
    = DoubleInUnionHashable Float
    | HashableInUnionHashable Hashable

type alias Hashable =
    {
    }

type UnionHasher
    = DoubleInUnionHasher Float
    | HasherInUnionHasher Hasher

type alias Hasher =
    {
    }

type UnionID
    = DoubleInUnionID Float
    | IDInUnionID ID

type alias ID =
    {
    }

type UnionImaginery
    = DoubleInUnionImaginery Float
    | ImagineryInUnionImaginery Imaginery

type alias Imaginery =
    {
    }

type UnionIMP
    = DoubleInUnionIMP Float
    | ImpInUnionIMP Imp

type alias Imp =
    {
    }

type UnionImplements
    = DoubleInUnionImplements Float
    | ImplementsInUnionImplements Implements

type alias Implements =
    {
    }

type UnionImplicit
    = DoubleInUnionImplicit Float
    | ImplicitInUnionImplicit Implicit

type alias Implicit =
    {
    }

type UnionIndirect
    = DoubleInUnionIndirect Float
    | IndirectInUnionIndirect Indirect

type alias Indirect =
    {
    }

type UnionInit
    = DoubleInUnionInit Float
    | InitInUnionInit Init

type alias Init =
    {
    }

type UnionInline
    = DoubleInUnionInline Float
    | InlineInUnionInline Inline

type alias Inline =
    {
    }

type UnionInout
    = DoubleInUnionInout Float
    | InoutInUnionInout Inout

type alias Inout =
    {
    }

type UnionInstanceof
    = DoubleInUnionInstanceof Float
    | InstanceofInUnionInstanceof Instanceof

type alias Instanceof =
    {
    }

type UnionIntNode
    = DoubleInUnionIntNode Float
    | IntNodeInUnionIntNode IntNode

type alias IntNode =
    {
    }

type UnionInterface
    = DoubleInUnionInterface Float
    | InterfaceInUnionInterface Interface

type alias Interface =
    {
    }

type UnionInternal
    = DoubleInUnionInternal Float
    | InternalInUnionInternal Internal

type alias Internal =
    {
    }

type UnionIs
    = DoubleInUnionIs Float
    | IsInUnionIs Is

type alias Is =
    {
    }

type UnionISODateTimeOffsetConverter
    = DoubleInUnionISODateTimeOffsetConverter Float
    | ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter ISODateTimeOffsetConverter

type alias ISODateTimeOffsetConverter =
    {
    }

type UnionIterable
    = DoubleInUnionIterable Float
    | IterableInUnionIterable Iterable

type alias Iterable =
    {
    }

type UnionJdec
    = DoubleInUnionJdec Float
    | JdecClassInUnionJdec JdecClass

type alias JdecClass =
    {
    }

type UnionJenc
    = DoubleInUnionJenc Float
    | JencClassInUnionJenc JencClass

type alias JencClass =
    {
    }

type UnionJpipe
    = DoubleInUnionJpipe Float
    | JpipeClassInUnionJpipe JpipeClass

type alias JpipeClass =
    {
    }

type UnionJSON
    = DoubleInUnionJSON Float
    | JSONInUnionJSON JSON

type alias JSON =
    {
    }

type UnionJSONAny
    = DoubleInUnionJSONAny Float
    | JSONAnyInUnionJSONAny JSONAny

type alias JSONAny =
    {
    }

type UnionJSONCodingKey
    = DoubleInUnionJSONCodingKey Float
    | JSONCodingKeyInUnionJSONCodingKey JSONCodingKey

type alias JSONCodingKey =
    {
    }

type UnionJSONConverter
    = DoubleInUnionJSONConverter Float
    | JSONConverterInUnionJSONConverter JSONConverter

type alias JSONConverter =
    {
    }

type UnionJSONDecoder
    = DoubleInUnionJSONDecoder Float
    | JSONDecoderInUnionJSONDecoder JSONDecoder

type alias JSONDecoder =
    {
    }

type UnionJSONEncoder
    = DoubleInUnionJSONEncoder Float
    | JSONEncoderInUnionJSONEncoder JSONEncoder

type alias JSONEncoder =
    {
    }

type UnionJSONException
    = DoubleInUnionJSONException Float
    | JSONExceptionInUnionJSONException JSONException

type alias JSONException =
    {
    }

type UnionJSONGenerator
    = DoubleInUnionJSONGenerator Float
    | JSONGeneratorInUnionJSONGenerator JSONGenerator

type alias JSONGenerator =
    {
    }

type UnionJSONNode
    = DoubleInUnionJSONNode Float
    | JSONNodeInUnionJSONNode JSONNode

type alias JSONNode =
    {
    }

type UnionJSONNull
    = DoubleInUnionJSONNull Float
    | JSONNullInUnionJSONNull JSONNull

type alias JSONNull =
    {
    }

type UnionJSONParser
    = DoubleInUnionJSONParser Float
    | JSONParserInUnionJSONParser JSONParser

type alias JSONParser =
    {
    }

type UnionJSONReader
    = DoubleInUnionJSONReader Float
    | JSONReaderInUnionJSONReader JSONReader

type alias JSONReader =
    {
    }

type UnionJSONSerializer
    = DoubleInUnionJSONSerializer Float
    | JSONSerializerInUnionJSONSerializer JSONSerializer

type alias JSONSerializer =
    {
    }

type UnionJSONToken
    = DoubleInUnionJSONToken Float
    | JSONTokenInUnionJSONToken JSONToken

type alias JSONToken =
    {
    }

type UnionJSONTokenType
    = DoubleInUnionJSONTokenType Float
    | JSONTokenTypeInUnionJSONTokenType JSONTokenType

type alias JSONTokenType =
    {
    }

type UnionJSONWriter
    = DoubleInUnionJSONWriter Float
    | JSONWriterInUnionJSONWriter JSONWriter

type alias JSONWriter =
    {
    }

type UnionKSerializer
    = DoubleInUnionKSerializer Float
    | KSerializerInUnionKSerializer KSerializer

type alias KSerializer =
    {
    }

type UnionLambda
    = DoubleInUnionLambda Float
    | LambdaInUnionLambda Lambda

type alias Lambda =
    {
    }

type UnionLazy
    = DoubleInUnionLazy Float
    | LazyInUnionLazy Lazy

type alias Lazy =
    {
    }

type UnionLeft
    = DoubleInUnionLeft Float
    | LeftInUnionLeft Left

type alias Left =
    {
    }

type UnionList
    = DoubleInUnionList Float
    | ListClassInUnionList ListClass

type alias ListClass =
    {
    }

type UnionLocalDate
    = DoubleInUnionLocalDate Float
    | LocalDateInUnionLocalDate LocalDate

type alias LocalDate =
    {
    }

type UnionLocale
    = DoubleInUnionLocale Float
    | LocaleInUnionLocale Locale

type alias Locale =
    {
    }

type UnionLock
    = DoubleInUnionLock Float
    | LockInUnionLock Lock

type alias Lock =
    {
    }

type UnionLong
    = DoubleInUnionLong Float
    | LongInUnionLong Long

type alias Long =
    {
    }

type UnionLongNode
    = DoubleInUnionLongNode Float
    | LongNodeInUnionLongNode LongNode

type alias LongNode =
    {
    }

type UnionMap
    = DoubleInUnionMap Float
    | MapInUnionMap Map

type alias Map =
    {
    }

type UnionMapEntry
    = DoubleInUnionMapEntry Float
    | MapEntryInUnionMapEntry MapEntry

type alias MapEntry =
    {
    }

type UnionMarshalJSON
    = DoubleInUnionMarshalJSON Float
    | MarshalJSONInUnionMarshalJSON MarshalJSON

type alias MarshalJSON =
    {
    }

type UnionMetadataPropertyHandling
    = DoubleInUnionMetadataPropertyHandling Float
    | MetadataPropertyHandlingInUnionMetadataPropertyHandling MetadataPropertyHandling

type alias MetadataPropertyHandling =
    {
    }

type UnionMutable
    = DoubleInUnionMutable Float
    | MutableInUnionMutable Mutable

type alias Mutable =
    {
    }

type UnionMutating
    = DoubleInUnionMutating Float
    | MutatingInUnionMutating Mutating

type alias Mutating =
    {
    }

type UnionNamespace
    = DoubleInUnionNamespace Float
    | NamespaceInUnionNamespace Namespace

type alias Namespace =
    {
    }

type UnionNative
    = DoubleInUnionNative Float
    | NativeInUnionNative Native

type alias Native =
    {
    }

type UnionNew
    = DoubleInUnionNew Float
    | NewInUnionNew New

type alias New =
    {
    }

type UnionNewtonsoft
    = DoubleInUnionNewtonsoft Float
    | NewtonsoftInUnionNewtonsoft Newtonsoft

type alias Newtonsoft =
    {
    }

type UnionNil
    = DoubleInUnionNil Float
    | NilInUnionNil Nil

type alias Nil =
    {
    }

type UnionNO
    = DoubleInUnionNO Float
    | NoInUnionNO No

type alias No =
    {
    }

type UnionNoSuchMethod
    = DoubleInUnionNoSuchMethod Float
    | NoSuchMethodInUnionNoSuchMethod NoSuchMethod

type alias NoSuchMethod =
    {
    }

type UnionNoexcept
    = DoubleInUnionNoexcept Float
    | NoexceptInUnionNoexcept Noexcept

type alias Noexcept =
    {
    }

type UnionNonatomic
    = DoubleInUnionNonatomic Float
    | NonatomicInUnionNonatomic Nonatomic

type alias Nonatomic =
    {
    }

type UnionNone
    = DoubleInUnionNone Float
    | NoneInUnionNone None

type alias None =
    {
    }

type UnionNonlocal
    = DoubleInUnionNonlocal Float
    | NonlocalInUnionNonlocal Nonlocal

type alias Nonlocal =
    {
    }

type UnionNonmutating
    = DoubleInUnionNonmutating Float
    | NonmutatingInUnionNonmutating Nonmutating

type alias Nonmutating =
    {
    }

type UnionNot
    = DoubleInUnionNot Float
    | NotInUnionNot Not

type alias Not =
    {
    }

type UnionNotEq
    = DoubleInUnionNotEq Float
    | NotEqInUnionNotEq NotEq

type alias NotEq =
    {
    }

type UnionNSError
    = DoubleInUnionNSError Float
    | NSErrorInUnionNSError NSError

type alias NSError =
    {
    }

type UnionNSObject
    = DoubleInUnionNSObject Float
    | NSObjectInUnionNSObject NSObject

type alias NSObject =
    {
    }

type UnionNSString
    = DoubleInUnionNSString Float
    | NSStringInUnionNSString NSString

type alias NSString =
    {
    }

type UnionNULL
    = DoubleInUnionNULL Float
    | NullInUnionNULL Null

type alias Null =
    {
    }

type UnionNullNode
    = DoubleInUnionNullNode Float
    | NullNodeInUnionNullNode NullNode

type alias NullNode =
    {
    }

type UnionNullptr
    = DoubleInUnionNullptr Float
    | NullptrInUnionNullptr Nullptr

type alias Nullptr =
    {
    }

type UnionNumber
    = DoubleInUnionNumber Float
    | NumberInUnionNumber Number

type alias Number =
    {
    }

type UnionObject
    = DoubleInUnionObject Float
    | ObjectInUnionObject Object

type alias Object =
    {
    }

type UnionObjectMapper
    = DoubleInUnionObjectMapper Float
    | ObjectMapperInUnionObjectMapper ObjectMapper

type alias ObjectMapper =
    {
    }

type UnionObjectNode
    = DoubleInUnionObjectNode Float
    | ObjectNodeInUnionObjectNode ObjectNode

type alias ObjectNode =
    {
    }

type UnionObjectReader
    = DoubleInUnionObjectReader Float
    | ObjectReaderInUnionObjectReader ObjectReader

type alias ObjectReader =
    {
    }

type UnionObjectWriter
    = DoubleInUnionObjectWriter Float
    | ObjectWriterInUnionObjectWriter ObjectWriter

type alias ObjectWriter =
    {
    }

type UnionOffsetDateTime
    = DoubleInUnionOffsetDateTime Float
    | OffsetDateTimeInUnionOffsetDateTime OffsetDateTime

type alias OffsetDateTime =
    {
    }

type UnionOffsetTime
    = DoubleInUnionOffsetTime Float
    | OffsetTimeInUnionOffsetTime OffsetTime

type alias OffsetTime =
    {
    }

type UnionOneway
    = DoubleInUnionOneway Float
    | OnewayInUnionOneway Oneway

type alias Oneway =
    {
    }

type UnionOpen
    = DoubleInUnionOpen Float
    | OpenInUnionOpen Open

type alias Open =
    {
    }

type UnionOperator
    = DoubleInUnionOperator Float
    | OperatorInUnionOperator Operator

type alias Operator =
    {
    }

type UnionOptional
    = DoubleInUnionOptional Float
    | OptionalInUnionOptional Optional

type alias Optional =
    {
    }

type UnionOr
    = DoubleInUnionOr Float
    | OrInUnionOr Or

type alias Or =
    {
    }

type UnionOrEq
    = DoubleInUnionOrEq Float
    | OrEqInUnionOrEq OrEq

type alias OrEq =
    {
    }

type UnionOut
    = DoubleInUnionOut Float
    | OutInUnionOut Out

type alias Out =
    {
    }

type UnionOverride
    = DoubleInUnionOverride Float
    | OverrideInUnionOverride Override

type alias Override =
    {
    }

type UnionPackage
    = DoubleInUnionPackage Float
    | PackageInUnionPackage Package

type alias Package =
    {
    }

type UnionParams
    = DoubleInUnionParams Float
    | ParamsInUnionParams Params

type alias Params =
    {
    }

type UnionPass
    = DoubleInUnionPass Float
    | PassInUnionPass Pass

type alias Pass =
    {
    }

type UnionPostfix
    = DoubleInUnionPostfix Float
    | PostfixInUnionPostfix Postfix

type alias Postfix =
    {
    }

type UnionPrecedence
    = DoubleInUnionPrecedence Float
    | PrecedenceInUnionPrecedence Precedence

type alias Precedence =
    {
    }

type UnionPrefix
    = DoubleInUnionPrefix Float
    | PrefixInUnionPrefix Prefix

type alias Prefix =
    {
    }

type UnionPrimitiveKind
    = DoubleInUnionPrimitiveKind Float
    | PrimitiveKindInUnionPrimitiveKind PrimitiveKind

type alias PrimitiveKind =
    {
    }

type UnionPrint
    = DoubleInUnionPrint Float
    | PrintInUnionPrint Print

type alias Print =
    {
    }

type UnionPrintMembers
    = DoubleInUnionPrintMembers Float
    | PrintMembersInUnionPrintMembers PrintMembers

type alias PrintMembers =
    {
    }

type UnionPrintf
    = DoubleInUnionPrintf Float
    | PrintfInUnionPrintf Printf

type alias Printf =
    {
    }

type UnionPrivate
    = DoubleInUnionPrivate Float
    | PrivateInUnionPrivate Private

type alias Private =
    {
    }

type UnionProtected
    = DoubleInUnionProtected Float
    | ProtectedInUnionProtected Protected

type alias Protected =
    {
    }

type UnionProtocol
    = DoubleInUnionProtocol Float
    | ProtocolInUnionProtocol Protocol

type alias Protocol =
    {
    }

type UnionPublic
    = DoubleInUnionPublic Float
    | PublicInUnionPublic Public

type alias Public =
    {
    }

type UnionBoolUnion
    = DoubleInUnionBoolUnion Float
    | UnionBoolBoolInUnionBoolUnion UnionBoolBool

type alias UnionBoolBool =
    {
    }

type UnionTypeUnion
    = DoubleInUnionTypeUnion Float
    | TypeClassInUnionTypeUnion TypeClass

type alias TypeClass =
    {
    }

type UnionAnyUnion
    = AnyClassInUnionAnyUnion AnyClass
    | DoubleInUnionAnyUnion Float

type alias AnyClass =
    {
    }

type UnionAs
    = AsInUnionAs As
    | DoubleInUnionAs Float

type alias As =
    {
    }

type UnionBOOL
    = BoolInUnionBOOL Bool
    | DoubleInUnionBOOL Float

type alias Bool =
    {
    }

type UnionBool
    = BoolClassInUnionBool BoolClass
    | DoubleInUnionBool Float

type alias BoolClass =
    {
    }

type UnionCase
    = CaseInUnionCase Case
    | DoubleInUnionCase Float

type alias Case =
    {
    }

type UnionClassUnion
    = ClassClassInUnionClassUnion ClassClass
    | DoubleInUnionClassUnion Float

type alias ClassClass =
    {
    }

type UnionDecoder
    = DecoderInUnionDecoder Decoder
    | DoubleInUnionDecoder Float

type alias Decoder =
    {
    }

type UnionElse
    = DoubleInUnionElse Float
    | ElseInUnionElse Else

type alias Else =
    {
    }

type UnionExposing
    = DoubleInUnionExposing Float
    | ExposingInUnionExposing Exposing

type alias Exposing =
    {
    }

type UnionFalseUnion
    = DoubleInUnionFalseUnion Float
    | UnionFalseFalseInUnionFalseUnion UnionFalseFalse

type alias UnionFalseFalse =
    {
    }

type UnionFloat
    = DoubleInUnionFloat Float
    | FloatClassInUnionFloat FloatClass

type alias FloatClass =
    {
    }

type UnionIf
    = DoubleInUnionIf Float
    | IfInUnionIf If

type alias If =
    {
    }

type UnionImport
    = DoubleInUnionImport Float
    | ImportInUnionImport Import

type alias Import =
    {
    }

type UnionIn
    = DoubleInUnionIn Float
    | InInUnionIn In

type alias In =
    {
    }

type UnionInfix
    = DoubleInUnionInfix Float
    | InfixInUnionInfix Infix

type alias Infix =
    {
    }

type UnionInt
    = DoubleInUnionInt Float
    | IntClassInUnionInt IntClass

type alias IntClass =
    {
    }

type UnionLet
    = DoubleInUnionLet Float
    | LetInUnionLet Let

type alias Let =
    {
    }

type UnionModule
    = DoubleInUnionModule Float
    | ModuleInUnionModule Module

type alias Module =
    {
    }

type UnionNoneUnion
    = DoubleInUnionNoneUnion Float
    | NoneClassInUnionNoneUnion NoneClass

type alias NoneClass =
    {
    }

type UnionNull
    = DoubleInUnionNull Float
    | NullClassInUnionNull NullClass

type alias NullClass =
    {
    }

type UnionOf
    = DoubleInUnionOf Float
    | OfInUnionOf Of

type alias Of =
    {
    }

type UnionPort
    = DoubleInUnionPort Float
    | PortInUnionPort Port

type alias Port =
    {
    }

type UnionProtocolUnion
    = DoubleInUnionProtocolUnion Float
    | ProtocolClassInUnionProtocolUnion ProtocolClass

type alias ProtocolClass =
    {
    }

type UnionSelfUnion
    = DoubleInUnionSelfUnion Float
    | SelfClassInUnionSelfUnion SelfClass

type alias SelfClass =
    {
    }

type UnionString
    = DoubleInUnionString Float
    | StringClassInUnionString StringClass

type alias StringClass =
    {
    }

type UnionThen
    = DoubleInUnionThen Float
    | ThenInUnionThen Then

type alias Then =
    {
    }

type UnionTrueUnion
    = DoubleInUnionTrueUnion Float
    | UnionTrueTrueInUnionTrueUnion UnionTrueTrue

type alias UnionTrueTrue =
    {
    }

type UnionType
    = DoubleInUnionType Float
    | TypeInUnionType Type

type alias Type =
    {
    }

type UnionWhere
    = DoubleInUnionWhere Float
    | WhereInUnionWhere Where

type alias Where =
    {
    }

type UnionQuicktype
    = DoubleInUnionQuicktype Float
    | QuicktypeInUnionQuicktype Quicktype

type alias Quicktype =
    {
    }

type UnionRaise
    = DoubleInUnionRaise Float
    | RaiseInUnionRaise Raise

type alias Raise =
    {
    }

type UnionRange
    = DoubleInUnionRange Float
    | RangeInUnionRange Range

type alias Range =
    {
    }

type UnionReadonly
    = DoubleInUnionReadonly Float
    | ReadonlyInUnionReadonly Readonly

type alias Readonly =
    {
    }

type UnionRef
    = DoubleInUnionRef Float
    | RefInUnionRef Ref

type alias Ref =
    {
    }

type UnionRegExp
    = DoubleInUnionRegExp Float
    | RegExpInUnionRegExp RegExp

type alias RegExp =
    {
    }

type UnionRegister
    = DoubleInUnionRegister Float
    | RegisterInUnionRegister Register

type alias Register =
    {
    }

type UnionReinterpretCast
    = DoubleInUnionReinterpretCast Float
    | ReinterpretCastInUnionReinterpretCast ReinterpretCast

type alias ReinterpretCast =
    {
    }

type UnionRepeat
    = DoubleInUnionRepeat Float
    | RepeatInUnionRepeat Repeat

type alias Repeat =
    {
    }

type UnionRequire
    = DoubleInUnionRequire Float
    | RequireInUnionRequire Require

type alias Require =
    {
    }

type UnionRequired
    = DoubleInUnionRequired Float
    | RequiredInUnionRequired Required

type alias Required =
    {
    }

type UnionRequires
    = DoubleInUnionRequires Float
    | RequiresInUnionRequires Requires

type alias Requires =
    {
    }

type UnionRestrict
    = DoubleInUnionRestrict Float
    | RestrictInUnionRestrict Restrict

type alias Restrict =
    {
    }

type UnionRetain
    = DoubleInUnionRetain Float
    | RetainInUnionRetain Retain

type alias Retain =
    {
    }

type UnionRethrows
    = DoubleInUnionRethrows Float
    | RethrowsInUnionRethrows Rethrows

type alias Rethrows =
    {
    }

type UnionReturn
    = DoubleInUnionReturn Float
    | ReturnInUnionReturn Return

type alias Return =
    {
    }

type UnionRight
    = DoubleInUnionRight Float
    | RightInUnionRight Right

type alias Right =
    {
    }

type UnionRuntimeType
    = DoubleInUnionRuntimeType Float
    | RuntimeTypeInUnionRuntimeType RuntimeType

type alias RuntimeType =
    {
    }

type UnionS
    = DoubleInUnionS Float
    | SInUnionS S

type alias S =
    {
    }

type UnionSbyte
    = DoubleInUnionSbyte Float
    | SbyteInUnionSbyte Sbyte

type alias Sbyte =
    {
    }

type UnionSealed
    = DoubleInUnionSealed Float
    | SealedInUnionSealed Sealed

type alias Sealed =
    {
    }

type UnionSEL
    = DoubleInUnionSEL Float
    | SelInUnionSEL Sel

type alias Sel =
    {
    }

type UnionSelect
    = DoubleInUnionSelect Float
    | SelectInUnionSelect Select

type alias Select =
    {
    }

type UnionSelf
    = DoubleInUnionSelf Float
    | SelfInUnionSelf Self

type alias Self =
    {
    }

type UnionSendable
    = DoubleInUnionSendable Float
    | SendableInUnionSendable Sendable

type alias Sendable =
    {
    }

type UnionSerialDescriptor
    = DoubleInUnionSerialDescriptor Float
    | SerialDescriptorInUnionSerialDescriptor SerialDescriptor

type alias SerialDescriptor =
    {
    }

type UnionSerialName
    = DoubleInUnionSerialName Float
    | SerialNameInUnionSerialName SerialName

type alias SerialName =
    {
    }

type UnionSerializable
    = DoubleInUnionSerializable Float
    | SerializableInUnionSerializable Serializable

type alias Serializable =
    {
    }

type UnionSerializationFeature
    = DoubleInUnionSerializationFeature Float
    | SerializationFeatureInUnionSerializationFeature SerializationFeature

type alias SerializationFeature =
    {
    }

type UnionSerialize
    = DoubleInUnionSerialize Float
    | SerializeInUnionSerialize Serialize

type alias Serialize =
    {
    }

type UnionSerializerProvider
    = DoubleInUnionSerializerProvider Float
    | SerializerProviderInUnionSerializerProvider SerializerProvider

type alias SerializerProvider =
    {
    }

type UnionSet
    = DoubleInUnionSet Float
    | SetInUnionSet Set

type alias Set =
    {
    }

type UnionShort
    = DoubleInUnionShort Float
    | ShortInUnionShort Short

type alias Short =
    {
    }

type UnionSigned
    = DoubleInUnionSigned Float
    | SignedInUnionSigned Signed

type alias Signed =
    {
    }

type UnionSimpleModule
    = DoubleInUnionSimpleModule Float
    | SimpleModuleInUnionSimpleModule SimpleModule

type alias SimpleModule =
    {
    }

type UnionSizeof
    = DoubleInUnionSizeof Float
    | SizeofInUnionSizeof Sizeof

type alias Sizeof =
    {
    }

type UnionStackalloc
    = DoubleInUnionStackalloc Float
    | StackallocInUnionStackalloc Stackalloc

type alias Stackalloc =
    {
    }

type UnionStandards
    = DoubleInUnionStandards Float
    | StandardsInUnionStandards Standards

type alias Standards =
    {
    }

type UnionStatic
    = DoubleInUnionStatic Float
    | StaticInUnionStatic Static

type alias Static =
    {
    }

type UnionStaticAssert
    = DoubleInUnionStaticAssert Float
    | StaticAssertInUnionStaticAssert StaticAssert

type alias StaticAssert =
    {
    }

type UnionStaticCast
    = DoubleInUnionStaticCast Float
    | StaticCastInUnionStaticCast StaticCast

type alias StaticCast =
    {
    }

type UnionStdDeserializer
    = DoubleInUnionStdDeserializer Float
    | StdDeserializerInUnionStdDeserializer StdDeserializer

type alias StdDeserializer =
    {
    }

type UnionStdSerializer
    = DoubleInUnionStdSerializer Float
    | StdSerializerInUnionStdSerializer StdSerializer

type alias StdSerializer =
    {
    }

type UnionStrictfp
    = DoubleInUnionStrictfp Float
    | StrictfpInUnionStrictfp Strictfp

type alias Strictfp =
    {
    }

type UnionStruct
    = DoubleInUnionStruct Float
    | StructInUnionStruct Struct

type alias Struct =
    {
    }

type UnionSubscript
    = DoubleInUnionSubscript Float
    | SubscriptInUnionSubscript Subscript

type alias Subscript =
    {
    }

type UnionSuper
    = DoubleInUnionSuper Float
    | SuperInUnionSuper Super

type alias Super =
    {
    }

type UnionSwitch
    = DoubleInUnionSwitch Float
    | SwitchInUnionSwitch Switch

type alias Switch =
    {
    }

type UnionSymbol
    = DoubleInUnionSymbol Float
    | SymbolInUnionSymbol Symbol

type alias Symbol =
    {
    }

type UnionSynchronized
    = DoubleInUnionSynchronized Float
    | SynchronizedInUnionSynchronized Synchronized

type alias Synchronized =
    {
    }

type UnionSystem
    = DoubleInUnionSystem Float
    | SystemInUnionSystem System

type alias System =
    {
    }

type UnionTemplate
    = DoubleInUnionTemplate Float
    | TemplateInUnionTemplate Template

type alias Template =
    {
    }

type UnionTextNode
    = DoubleInUnionTextNode Float
    | TextNodeInUnionTextNode TextNode

type alias TextNode =
    {
    }

type UnionThis
    = DoubleInUnionThis Float
    | ThisInUnionThis This

type alias This =
    {
    }

type UnionThreadLocal
    = DoubleInUnionThreadLocal Float
    | ThreadLocalInUnionThreadLocal ThreadLocal

type alias ThreadLocal =
    {
    }

type UnionThrow
    = DoubleInUnionThrow Float
    | ThrowInUnionThrow Throw

type alias Throw =
    {
    }

type UnionThrows
    = DoubleInUnionThrows Float
    | ThrowsInUnionThrows Throws

type alias Throws =
    {
    }

type UnionTimeOnly
    = DoubleInUnionTimeOnly Float
    | TimeOnlyInUnionTimeOnly TimeOnly

type alias TimeOnly =
    {
    }

type UnionTimeOnlyConverter
    = DoubleInUnionTimeOnlyConverter Float
    | TimeOnlyConverterInUnionTimeOnlyConverter TimeOnlyConverter

type alias TimeOnlyConverter =
    {
    }

type UnionTimeZone
    = DoubleInUnionTimeZone Float
    | TimeZoneInUnionTimeZone TimeZone

type alias TimeZone =
    {
    }

type UnionToDict
    = DoubleInUnionToDict Float
    | ToDictInUnionToDict ToDict

type alias ToDict =
    {
    }

type UnionToJSON
    = DoubleInUnionToJSON Float
    | ToJSONInUnionToJSON ToJSON

type alias ToJSON =
    {
    }

type UnionToString
    = DoubleInUnionToString Float
    | ToStringInUnionToString ToString

type alias ToString =
    {
    }

type UnionTopLevel
    = DoubleInUnionTopLevel Float
    | TopLevelInUnionTopLevel TopLevel

type alias TopLevel =
    {
    }

type UnionTransient
    = DoubleInUnionTransient Float
    | TransientInUnionTransient Transient

type alias Transient =
    {
    }

type UnionTrue
    = DoubleInUnionTrue Float
    | TrueClassInUnionTrue TrueClass

type alias TrueClass =
    {
    }

type UnionTry
    = DoubleInUnionTry Float
    | TryInUnionTry Try

type alias Try =
    {
    }

type UnionTypealias
    = DoubleInUnionTypealias Float
    | TypealiasInUnionTypealias Typealias

type alias Typealias =
    {
    }

type UnionTypedef
    = DoubleInUnionTypedef Float
    | TypedefInUnionTypedef Typedef

type alias Typedef =
    {
    }

type UnionTypeid
    = DoubleInUnionTypeid Float
    | TypeidInUnionTypeid Typeid

type alias Typeid =
    {
    }

type UnionTypename
    = DoubleInUnionTypename Float
    | TypenameInUnionTypename Typename

type alias Typename =
    {
    }

type UnionTypeof
    = DoubleInUnionTypeof Float
    | TypeofInUnionTypeof Typeof

type alias Typeof =
    {
    }

type UnionUint
    = DoubleInUnionUint Float
    | UintInUnionUint Uint

type alias Uint =
    {
    }

type UnionUlong
    = DoubleInUnionUlong Float
    | UlongInUnionUlong Ulong

type alias Ulong =
    {
    }

type UnionUnchecked
    = DoubleInUnionUnchecked Float
    | UncheckedInUnionUnchecked Unchecked

type alias Unchecked =
    {
    }

type UnionUndefined
    = DoubleInUnionUndefined Float
    | UndefinedInUnionUndefined Undefined

type alias Undefined =
    {
    }

type UnionUnionUnion
    = DoubleInUnionUnionUnion Float
    | UnionInUnionUnionUnion Union

type alias Union =
    {
    }

type UnionUnmarshalJSON
    = DoubleInUnionUnmarshalJSON Float
    | UnmarshalJSONInUnionUnmarshalJSON UnmarshalJSON

type alias UnmarshalJSON =
    {
    }

type UnionUnowned
    = DoubleInUnionUnowned Float
    | UnownedInUnionUnowned Unowned

type alias Unowned =
    {
    }

type UnionUnsafe
    = DoubleInUnionUnsafe Float
    | UnsafeInUnionUnsafe Unsafe

type alias Unsafe =
    {
    }

type UnionUnsigned
    = DoubleInUnionUnsigned Float
    | UnsignedInUnionUnsigned Unsigned

type alias Unsigned =
    {
    }

type UnionUseSerializers
    = DoubleInUnionUseSerializers Float
    | UseSerializersInUnionUseSerializers UseSerializers

type alias UseSerializers =
    {
    }

type UnionUshort
    = DoubleInUnionUshort Float
    | UshortInUnionUshort Ushort

type alias Ushort =
    {
    }

type UnionUsing
    = DoubleInUnionUsing Float
    | UsingInUnionUsing Using

type alias Using =
    {
    }

type UnionUtf8JSONReader
    = DoubleInUnionUtf8JSONReader Float
    | Utf8JSONReaderInUnionUtf8JSONReader Utf8JSONReader

type alias Utf8JSONReader =
    {
    }

type UnionUtf8JSONWriter
    = DoubleInUnionUtf8JSONWriter Float
    | Utf8JSONWriterInUnionUtf8JSONWriter Utf8JSONWriter

type alias Utf8JSONWriter =
    {
    }

type UnionUUID
    = DoubleInUnionUUID Float
    | UUIDInUnionUUID UUID

type alias UUID =
    {
    }

type UnionVar
    = DoubleInUnionVar Float
    | VarInUnionVar Var

type alias Var =
    {
    }

type UnionVirtual
    = DoubleInUnionVirtual Float
    | VirtualInUnionVirtual Virtual

type alias Virtual =
    {
    }

type UnionVoid
    = DoubleInUnionVoid Float
    | VoidInUnionVoid Void

type alias Void =
    {
    }

type UnionVolatile
    = DoubleInUnionVolatile Float
    | VolatileInUnionVolatile Volatile

type alias Volatile =
    {
    }

type UnionWcharT
    = DoubleInUnionWcharT Float
    | WcharTInUnionWcharT WcharT

type alias WcharT =
    {
    }

type UnionWeak
    = DoubleInUnionWeak Float
    | WeakInUnionWeak Weak

type alias Weak =
    {
    }

type UnionWhile
    = DoubleInUnionWhile Float
    | WhileInUnionWhile While

type alias While =
    {
    }

type UnionWillSet
    = DoubleInUnionWillSet Float
    | WillSetInUnionWillSet WillSet

type alias WillSet =
    {
    }

type UnionWith
    = DoubleInUnionWith Float
    | WithInUnionWith With

type alias With =
    {
    }

type UnionXor
    = DoubleInUnionXor Float
    | XorInUnionXor Xor

type alias Xor =
    {
    }

type UnionXorEq
    = DoubleInUnionXorEq Float
    | XorEqInUnionXorEq XorEq

type alias XorEq =
    {
    }

type UnionYES
    = DoubleInUnionYES Float
    | YesInUnionYES Yes

type alias Yes =
    {
    }

type UnionYield
    = DoubleInUnionYield Float
    | YieldInUnionYield Yield

type alias Yield =
    {
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
        |> Jpipe.custom (optionalField "_" (Jdec.map Just unionUnion) Nothing)
        |> Jpipe.custom (optionalField "_Bool" (Jdec.map Just unionBool) Nothing)
        |> Jpipe.custom (optionalField "_Complex" (Jdec.map Just unionComplex) Nothing)
        |> Jpipe.custom (optionalField "_Imaginery" (Jdec.map Just unionImaginery) Nothing)
        |> Jpipe.custom (optionalField "abstract" (Jdec.map Just unionAbstract) Nothing)
        |> Jpipe.custom (optionalField "alignas" (Jdec.map Just unionAlignas) Nothing)
        |> Jpipe.custom (optionalField "alignof" (Jdec.map Just unionAlignof) Nothing)
        |> Jpipe.custom (optionalField "and" (Jdec.map Just unionAnd) Nothing)
        |> Jpipe.custom (optionalField "and_eq" (Jdec.map Just unionAndEq) Nothing)
        |> Jpipe.custom (optionalField "any" (Jdec.map Just unionAnyUnion) Nothing)
        |> Jpipe.custom (optionalField "Any" (Jdec.map Just unionAny) Nothing)
        |> Jpipe.custom (optionalField "array" (Jdec.map Just unionArray) Nothing)
        |> Jpipe.custom (optionalField "ArrayNode" (Jdec.map Just unionArrayNode) Nothing)
        |> Jpipe.custom (optionalField "as" (Jdec.map Just unionAs) Nothing)
        |> Jpipe.custom (optionalField "asm" (Jdec.map Just unionASM) Nothing)
        |> Jpipe.custom (optionalField "assert" (Jdec.map Just unionAssert) Nothing)
        |> Jpipe.custom (optionalField "associatedtype" (Jdec.map Just unionAssociatedtype) Nothing)
        |> Jpipe.custom (optionalField "associativity" (Jdec.map Just unionAssociativity) Nothing)
        |> Jpipe.custom (optionalField "async" (Jdec.map Just unionAsync) Nothing)
        |> Jpipe.custom (optionalField "atomic" (Jdec.map Just unionAtomic) Nothing)
        |> Jpipe.custom (optionalField "atomic_cancel" (Jdec.map Just unionAtomicCancel) Nothing)
        |> Jpipe.custom (optionalField "atomic_commit" (Jdec.map Just unionAtomicCommit) Nothing)
        |> Jpipe.custom (optionalField "atomic_noexcept" (Jdec.map Just unionAtomicNoexcept) Nothing)
        |> Jpipe.custom (optionalField "auto" (Jdec.map Just unionAuto) Nothing)
        |> Jpipe.custom (optionalField "await" (Jdec.map Just unionAwait) Nothing)
        |> Jpipe.custom (optionalField "base" (Jdec.map Just unionBase) Nothing)
        |> Jpipe.custom (optionalField "bitand" (Jdec.map Just unionBitand) Nothing)
        |> Jpipe.custom (optionalField "bitor" (Jdec.map Just unionBitor) Nothing)
        |> Jpipe.custom (optionalField "BOOL" (Jdec.map Just unionBOOL) Nothing)
        |> Jpipe.custom (optionalField "bool" (Jdec.map Just unionBoolUnion) Nothing)
        |> Jpipe.custom (optionalField "boolean" (Jdec.map Just unionBoolean) Nothing)
        |> Jpipe.custom (optionalField "BooleanNode" (Jdec.map Just unionBooleanNode) Nothing)
        |> Jpipe.custom (optionalField "break" (Jdec.map Just unionBreak) Nothing)
        |> Jpipe.custom (optionalField "bycopy" (Jdec.map Just unionBycopy) Nothing)
        |> Jpipe.custom (optionalField "byref" (Jdec.map Just unionByref) Nothing)
        |> Jpipe.custom (optionalField "byte" (Jdec.map Just unionByte) Nothing)
        |> Jpipe.custom (optionalField "Calendar" (Jdec.map Just unionCalendar) Nothing)
        |> Jpipe.custom (optionalField "case" (Jdec.map Just unionCase) Nothing)
        |> Jpipe.custom (optionalField "catch" (Jdec.map Just unionCatch) Nothing)
        |> Jpipe.custom (optionalField "chan" (Jdec.map Just unionChan) Nothing)
        |> Jpipe.custom (optionalField "char" (Jdec.map Just unionChar) Nothing)
        |> Jpipe.custom (optionalField "char16_t" (Jdec.map Just unionChar16T) Nothing)
        |> Jpipe.custom (optionalField "char32_t" (Jdec.map Just unionChar32T) Nothing)
        |> Jpipe.custom (optionalField "checked" (Jdec.map Just unionChecked) Nothing)
        |> Jpipe.custom (optionalField "class" (Jdec.map Just unionClassUnion) Nothing)
        |> Jpipe.custom (optionalField "Class" (Jdec.map Just unionClass) Nothing)
        |> Jpipe.custom (optionalField "clone" (Jdec.map Just unionClone) Nothing)
        |> Jpipe.custom (optionalField "co_await" (Jdec.map Just unionCoAwait) Nothing)
        |> Jpipe.custom (optionalField "co_return" (Jdec.map Just unionCoReturn) Nothing)
        |> Jpipe.custom (optionalField "co_yield" (Jdec.map Just unionCoYield) Nothing)
        |> Jpipe.custom (optionalField "Codable" (Jdec.map Just unionCodable) Nothing)
        |> Jpipe.custom (optionalField "CodingKey" (Jdec.map Just unionCodingKey) Nothing)
        |> Jpipe.custom (optionalField "CodingKeys" (Jdec.map Just unionCodingKeys) Nothing)
        |> Jpipe.custom (optionalField "compl" (Jdec.map Just unionCompl) Nothing)
        |> Jpipe.custom (optionalField "concept" (Jdec.map Just unionConcept) Nothing)
        |> Jpipe.custom (optionalField "console" (Jdec.map Just unionConsole) Nothing)
        |> Jpipe.custom (optionalField "const" (Jdec.map Just unionConst) Nothing)
        |> Jpipe.custom (optionalField "const_cast" (Jdec.map Just unionConstCast) Nothing)
        |> Jpipe.custom (optionalField "constexpr" (Jdec.map Just unionConstexpr) Nothing)
        |> Jpipe.custom (optionalField "constructor" (Jdec.map Just unionConstructor) Nothing)
        |> Jpipe.custom (optionalField "continue" (Jdec.map Just unionContinue) Nothing)
        |> Jpipe.custom (optionalField "convenience" (Jdec.map Just unionConvenience) Nothing)
        |> Jpipe.custom (optionalField "convert" (Jdec.map Just unionConvert) Nothing)
        |> Jpipe.custom (optionalField "converter" (Jdec.map Just unionConverter) Nothing)
        |> Jpipe.custom (optionalField "CultureInfo" (Jdec.map Just unionCultureInfo) Nothing)
        |> Jpipe.custom (optionalField "date" (Jdec.map Just unionDate) Nothing)
        |> Jpipe.custom (optionalField "date_parse_handling" (Jdec.map Just unionDateParseHandling) Nothing)
        |> Jpipe.custom (optionalField "DateFormatter" (Jdec.map Just unionDateFormatter) Nothing)
        |> Jpipe.custom (optionalField "DateOnly" (Jdec.map Just unionDateOnly) Nothing)
        |> Jpipe.custom (optionalField "DateOnlyConverter" (Jdec.map Just unionDateOnlyConverter) Nothing)
        |> Jpipe.custom (optionalField "DateTime" (Jdec.map Just unionDateTime) Nothing)
        |> Jpipe.custom (optionalField "DateTimeStyles" (Jdec.map Just unionDateTimeStyles) Nothing)
        |> Jpipe.custom (optionalField "debugger" (Jdec.map Just unionDebugger) Nothing)
        |> Jpipe.custom (optionalField "decimal" (Jdec.map Just unionDecimal) Nothing)
        |> Jpipe.custom (optionalField "declare" (Jdec.map Just unionDeclare) Nothing)
        |> Jpipe.custom (optionalField "decltype" (Jdec.map Just unionDecltype) Nothing)
        |> Jpipe.custom (optionalField "decode_string" (Jdec.map Just unionDecodeString) Nothing)
        |> Jpipe.custom (optionalField "Decoder" (Jdec.map Just unionDecoder) Nothing)
        |> Jpipe.custom (optionalField "DecodingError" (Jdec.map Just unionDecodingError) Nothing)
        |> Jpipe.custom (optionalField "def" (Jdec.map Just unionDef) Nothing)
        |> Jpipe.custom (optionalField "default" (Jdec.map Just unionDefault) Nothing)
        |> Jpipe.custom (optionalField "defer" (Jdec.map Just unionDefer) Nothing)
        |> Jpipe.custom (optionalField "deinit" (Jdec.map Just unionDeinit) Nothing)
        |> Jpipe.custom (optionalField "del" (Jdec.map Just unionDel) Nothing)
        |> Jpipe.custom (optionalField "delegate" (Jdec.map Just unionDelegate) Nothing)
        |> Jpipe.custom (optionalField "delete" (Jdec.map Just unionDelete) Nothing)
        |> Jpipe.custom (optionalField "DeserializationFeature" (Jdec.map Just unionDeserializationFeature) Nothing)
        |> Jpipe.custom (optionalField "dict" (Jdec.map Just unionDict) Nothing)
        |> Jpipe.custom (optionalField "dictionary" (Jdec.map Just unionDictionary) Nothing)
        |> Jpipe.custom (optionalField "didSet" (Jdec.map Just unionDidSet) Nothing)
        |> Jpipe.custom (optionalField "do" (Jdec.map Just unionDo) Nothing)
        |> Jpipe.custom (optionalField "double" (Jdec.map Just unionDouble) Nothing)
        |> Jpipe.custom (optionalField "DoubleNode" (Jdec.map Just unionDoubleNode) Nothing)
        |> Jpipe.custom (optionalField "dummy" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "dynamic" (Jdec.map Just unionDynamic) Nothing)
        |> Jpipe.custom (optionalField "dynamic_cast" (Jdec.map Just unionDynamicCast) Nothing)
        |> Jpipe.custom (optionalField "elif" (Jdec.map Just unionElif) Nothing)
        |> Jpipe.custom (optionalField "else" (Jdec.map Just unionElse) Nothing)
        |> Jpipe.custom (optionalField "encode_quick_type" (Jdec.map Just unionEncodeQuickType) Nothing)
        |> Jpipe.custom (optionalField "Encoder" (Jdec.map Just unionEncoder) Nothing)
        |> Jpipe.custom (optionalField "enum" (Jdec.map Just unionEnum) Nothing)
        |> Jpipe.custom (optionalField "EnumValues" (Jdec.map Just unionEnumValues) Nothing)
        |> Jpipe.custom (optionalField "equalityContract" (Jdec.map Just unionEqualityContract) Nothing)
        |> Jpipe.custom (optionalField "Equatable" (Jdec.map Just unionEquatable) Nothing)
        |> Jpipe.custom (optionalField "event" (Jdec.map Just unionEvent) Nothing)
        |> Jpipe.custom (optionalField "except" (Jdec.map Just unionExcept) Nothing)
        |> Jpipe.custom (optionalField "exception" (Jdec.map Just unionException) Nothing)
        |> Jpipe.custom (optionalField "explicit" (Jdec.map Just unionExplicit) Nothing)
        |> Jpipe.custom (optionalField "export" (Jdec.map Just unionExport) Nothing)
        |> Jpipe.custom (optionalField "exposing" (Jdec.map Just unionExposing) Nothing)
        |> Jpipe.custom (optionalField "extends" (Jdec.map Just unionExtends) Nothing)
        |> Jpipe.custom (optionalField "extension" (Jdec.map Just unionExtension) Nothing)
        |> Jpipe.custom (optionalField "extern" (Jdec.map Just unionExtern) Nothing)
        |> Jpipe.custom (optionalField "fallthrough" (Jdec.map Just unionFallthrough) Nothing)
        |> Jpipe.custom (optionalField "false" (Jdec.map Just unionFalseUnion) Nothing)
        |> Jpipe.custom (optionalField "False" (Jdec.map Just unionFalse) Nothing)
        |> Jpipe.custom (optionalField "fileprivate" (Jdec.map Just unionFileprivate) Nothing)
        |> Jpipe.custom (optionalField "final" (Jdec.map Just unionFinal) Nothing)
        |> Jpipe.custom (optionalField "finally" (Jdec.map Just unionFinally) Nothing)
        |> Jpipe.custom (optionalField "fixed" (Jdec.map Just unionFixed) Nothing)
        |> Jpipe.custom (optionalField "float" (Jdec.map Just unionFloat) Nothing)
        |> Jpipe.custom (optionalField "for" (Jdec.map Just unionFor) Nothing)
        |> Jpipe.custom (optionalField "foreach" (Jdec.map Just unionForeach) Nothing)
        |> Jpipe.custom (optionalField "FormatException" (Jdec.map Just unionFormatException) Nothing)
        |> Jpipe.custom (optionalField "friend" (Jdec.map Just unionFriend) Nothing)
        |> Jpipe.custom (optionalField "from" (Jdec.map Just unionFrom) Nothing)
        |> Jpipe.custom (optionalField "from_dict" (Jdec.map Just unionFromDict) Nothing)
        |> Jpipe.custom (optionalField "from_json" (Jdec.map Just unionFromJSON) Nothing)
        |> Jpipe.custom (optionalField "func" (Jdec.map Just unionFunc) Nothing)
        |> Jpipe.custom (optionalField "function" (Jdec.map Just unionFunction) Nothing)
        |> Jpipe.custom (optionalField "get" (Jdec.map Just unionGet) Nothing)
        |> Jpipe.custom (optionalField "global" (Jdec.map Just unionGlobal) Nothing)
        |> Jpipe.custom (optionalField "go" (Jdec.map Just unionGo) Nothing)
        |> Jpipe.custom (optionalField "goto" (Jdec.map Just unionGoto) Nothing)
        |> Jpipe.custom (optionalField "guard" (Jdec.map Just unionGuard) Nothing)
        |> Jpipe.custom (optionalField "Hashable" (Jdec.map Just unionHashable) Nothing)
        |> Jpipe.custom (optionalField "hashCode" (Jdec.map Just unionHashCode) Nothing)
        |> Jpipe.custom (optionalField "Hasher" (Jdec.map Just unionHasher) Nothing)
        |> Jpipe.custom (optionalField "hasOwnProperty" (Jdec.map Just unionHasOwnProperty) Nothing)
        |> Jpipe.custom (optionalField "id" (Jdec.map Just unionID) Nothing)
        |> Jpipe.custom (optionalField "if" (Jdec.map Just unionIf) Nothing)
        |> Jpipe.custom (optionalField "IMP" (Jdec.map Just unionIMP) Nothing)
        |> Jpipe.custom (optionalField "implements" (Jdec.map Just unionImplements) Nothing)
        |> Jpipe.custom (optionalField "implicit" (Jdec.map Just unionImplicit) Nothing)
        |> Jpipe.custom (optionalField "import" (Jdec.map Just unionImport) Nothing)
        |> Jpipe.custom (optionalField "in" (Jdec.map Just unionIn) Nothing)
        |> Jpipe.custom (optionalField "indirect" (Jdec.map Just unionIndirect) Nothing)
        |> Jpipe.custom (optionalField "infix" (Jdec.map Just unionInfix) Nothing)
        |> Jpipe.custom (optionalField "init" (Jdec.map Just unionInit) Nothing)
        |> Jpipe.custom (optionalField "inline" (Jdec.map Just unionInline) Nothing)
        |> Jpipe.custom (optionalField "inout" (Jdec.map Just unionInout) Nothing)
        |> Jpipe.custom (optionalField "instanceof" (Jdec.map Just unionInstanceof) Nothing)
        |> Jpipe.custom (optionalField "int" (Jdec.map Just unionInt) Nothing)
        |> Jpipe.custom (optionalField "interface" (Jdec.map Just unionInterface) Nothing)
        |> Jpipe.custom (optionalField "internal" (Jdec.map Just unionInternal) Nothing)
        |> Jpipe.custom (optionalField "IntNode" (Jdec.map Just unionIntNode) Nothing)
        |> Jpipe.custom (optionalField "is" (Jdec.map Just unionIs) Nothing)
        |> Jpipe.custom (optionalField "IsoDateTimeOffsetConverter" (Jdec.map Just unionISODateTimeOffsetConverter) Nothing)
        |> Jpipe.custom (optionalField "iterable" (Jdec.map Just unionIterable) Nothing)
        |> Jpipe.custom (optionalField "jdec" (Jdec.map Just unionJdec) Nothing)
        |> Jpipe.custom (optionalField "jenc" (Jdec.map Just unionJenc) Nothing)
        |> Jpipe.custom (optionalField "jpipe" (Jdec.map Just unionJpipe) Nothing)
        |> Jpipe.custom (optionalField "json" (Jdec.map Just unionJSON) Nothing)
        |> Jpipe.custom (optionalField "json_converter" (Jdec.map Just unionJSONConverter) Nothing)
        |> Jpipe.custom (optionalField "json_serializer" (Jdec.map Just unionJSONSerializer) Nothing)
        |> Jpipe.custom (optionalField "json_token" (Jdec.map Just unionJSONToken) Nothing)
        |> Jpipe.custom (optionalField "json_writer" (Jdec.map Just unionJSONWriter) Nothing)
        |> Jpipe.custom (optionalField "JSONAny" (Jdec.map Just unionJSONAny) Nothing)
        |> Jpipe.custom (optionalField "JSONCodingKey" (Jdec.map Just unionJSONCodingKey) Nothing)
        |> Jpipe.custom (optionalField "JSONDecoder" (Jdec.map Just unionJSONDecoder) Nothing)
        |> Jpipe.custom (optionalField "JSONEncoder" (Jdec.map Just unionJSONEncoder) Nothing)
        |> Jpipe.custom (optionalField "JsonException" (Jdec.map Just unionJSONException) Nothing)
        |> Jpipe.custom (optionalField "JsonGenerator" (Jdec.map Just unionJSONGenerator) Nothing)
        |> Jpipe.custom (optionalField "JsonNode" (Jdec.map Just unionJSONNode) Nothing)
        |> Jpipe.custom (optionalField "JSONNull" (Jdec.map Just unionJSONNull) Nothing)
        |> Jpipe.custom (optionalField "JsonParser" (Jdec.map Just unionJSONParser) Nothing)
        |> Jpipe.custom (optionalField "JsonReader" (Jdec.map Just unionJSONReader) Nothing)
        |> Jpipe.custom (optionalField "JsonTokenType" (Jdec.map Just unionJSONTokenType) Nothing)
        |> Jpipe.custom (optionalField "KSerializer" (Jdec.map Just unionKSerializer) Nothing)
        |> Jpipe.custom (optionalField "lambda" (Jdec.map Just unionLambda) Nothing)
        |> Jpipe.custom (optionalField "lazy" (Jdec.map Just unionLazy) Nothing)
        |> Jpipe.custom (optionalField "left" (Jdec.map Just unionLeft) Nothing)
        |> Jpipe.custom (optionalField "let" (Jdec.map Just unionLet) Nothing)
        |> Jpipe.custom (optionalField "list" (Jdec.map Just unionList) Nothing)
        |> Jpipe.custom (optionalField "LocalDate" (Jdec.map Just unionLocalDate) Nothing)
        |> Jpipe.custom (optionalField "Locale" (Jdec.map Just unionLocale) Nothing)
        |> Jpipe.custom (optionalField "lock" (Jdec.map Just unionLock) Nothing)
        |> Jpipe.custom (optionalField "long" (Jdec.map Just unionLong) Nothing)
        |> Jpipe.custom (optionalField "LongNode" (Jdec.map Just unionLongNode) Nothing)
        |> Jpipe.custom (optionalField "map" (Jdec.map Just unionMap) Nothing)
        |> Jpipe.custom (optionalField "MapEntry" (Jdec.map Just unionMapEntry) Nothing)
        |> Jpipe.custom (optionalField "MarshalJSON" (Jdec.map Just unionMarshalJSON) Nothing)
        |> Jpipe.custom (optionalField "metadata_property_handling" (Jdec.map Just unionMetadataPropertyHandling) Nothing)
        |> Jpipe.custom (optionalField "module" (Jdec.map Just unionModule) Nothing)
        |> Jpipe.custom (optionalField "mutable" (Jdec.map Just unionMutable) Nothing)
        |> Jpipe.custom (optionalField "mutating" (Jdec.map Just unionMutating) Nothing)
        |> Jpipe.custom (optionalField "namespace" (Jdec.map Just unionNamespace) Nothing)
        |> Jpipe.custom (optionalField "native" (Jdec.map Just unionNative) Nothing)
        |> Jpipe.custom (optionalField "new" (Jdec.map Just unionNew) Nothing)
        |> Jpipe.custom (optionalField "newtonsoft" (Jdec.map Just unionNewtonsoft) Nothing)
        |> Jpipe.custom (optionalField "nil" (Jdec.map Just unionNil) Nothing)
        |> Jpipe.custom (optionalField "NO" (Jdec.map Just unionNO) Nothing)
        |> Jpipe.custom (optionalField "noexcept" (Jdec.map Just unionNoexcept) Nothing)
        |> Jpipe.custom (optionalField "nonatomic" (Jdec.map Just unionNonatomic) Nothing)
        |> Jpipe.custom (optionalField "none" (Jdec.map Just unionNoneUnion) Nothing)
        |> Jpipe.custom (optionalField "None" (Jdec.map Just unionNone) Nothing)
        |> Jpipe.custom (optionalField "nonlocal" (Jdec.map Just unionNonlocal) Nothing)
        |> Jpipe.custom (optionalField "nonmutating" (Jdec.map Just unionNonmutating) Nothing)
        |> Jpipe.custom (optionalField "noSuchMethod" (Jdec.map Just unionNoSuchMethod) Nothing)
        |> Jpipe.custom (optionalField "not" (Jdec.map Just unionNot) Nothing)
        |> Jpipe.custom (optionalField "not_eq" (Jdec.map Just unionNotEq) Nothing)
        |> Jpipe.custom (optionalField "NSError" (Jdec.map Just unionNSError) Nothing)
        |> Jpipe.custom (optionalField "NSObject" (Jdec.map Just unionNSObject) Nothing)
        |> Jpipe.custom (optionalField "NSString" (Jdec.map Just unionNSString) Nothing)
        |> Jpipe.custom (optionalField "NULL" (Jdec.map Just unionNULL) Nothing)
        |> Jpipe.custom (optionalField "null" (Jdec.map Just unionNull) Nothing)
        |> Jpipe.custom (optionalField "NullNode" (Jdec.map Just unionNullNode) Nothing)
        |> Jpipe.custom (optionalField "nullptr" (Jdec.map Just unionNullptr) Nothing)
        |> Jpipe.custom (optionalField "number" (Jdec.map Just unionNumber) Nothing)
        |> Jpipe.custom (optionalField "object" (Jdec.map Just unionObject) Nothing)
        |> Jpipe.custom (optionalField "ObjectMapper" (Jdec.map Just unionObjectMapper) Nothing)
        |> Jpipe.custom (optionalField "ObjectNode" (Jdec.map Just unionObjectNode) Nothing)
        |> Jpipe.custom (optionalField "ObjectReader" (Jdec.map Just unionObjectReader) Nothing)
        |> Jpipe.custom (optionalField "ObjectWriter" (Jdec.map Just unionObjectWriter) Nothing)
        |> Jpipe.custom (optionalField "of" (Jdec.map Just unionOf) Nothing)
        |> Jpipe.custom (optionalField "OffsetDateTime" (Jdec.map Just unionOffsetDateTime) Nothing)
        |> Jpipe.custom (optionalField "OffsetTime" (Jdec.map Just unionOffsetTime) Nothing)
        |> Jpipe.custom (optionalField "oneway" (Jdec.map Just unionOneway) Nothing)
        |> Jpipe.custom (optionalField "open" (Jdec.map Just unionOpen) Nothing)
        |> Jpipe.custom (optionalField "operator" (Jdec.map Just unionOperator) Nothing)
        |> Jpipe.custom (optionalField "optional" (Jdec.map Just unionOptional) Nothing)
        |> Jpipe.custom (optionalField "or" (Jdec.map Just unionOr) Nothing)
        |> Jpipe.custom (optionalField "or_eq" (Jdec.map Just unionOrEq) Nothing)
        |> Jpipe.custom (optionalField "out" (Jdec.map Just unionOut) Nothing)
        |> Jpipe.custom (optionalField "override" (Jdec.map Just unionOverride) Nothing)
        |> Jpipe.custom (optionalField "package" (Jdec.map Just unionPackage) Nothing)
        |> Jpipe.custom (optionalField "params" (Jdec.map Just unionParams) Nothing)
        |> Jpipe.custom (optionalField "pass" (Jdec.map Just unionPass) Nothing)
        |> Jpipe.custom (optionalField "port" (Jdec.map Just unionPort) Nothing)
        |> Jpipe.custom (optionalField "postfix" (Jdec.map Just unionPostfix) Nothing)
        |> Jpipe.custom (optionalField "precedence" (Jdec.map Just unionPrecedence) Nothing)
        |> Jpipe.custom (optionalField "prefix" (Jdec.map Just unionPrefix) Nothing)
        |> Jpipe.custom (optionalField "PrimitiveKind" (Jdec.map Just unionPrimitiveKind) Nothing)
        |> Jpipe.custom (optionalField "print" (Jdec.map Just unionPrint) Nothing)
        |> Jpipe.custom (optionalField "printf" (Jdec.map Just unionPrintf) Nothing)
        |> Jpipe.custom (optionalField "printMembers" (Jdec.map Just unionPrintMembers) Nothing)
        |> Jpipe.custom (optionalField "private" (Jdec.map Just unionPrivate) Nothing)
        |> Jpipe.custom (optionalField "protected" (Jdec.map Just unionProtected) Nothing)
        |> Jpipe.custom (optionalField "Protocol" (Jdec.map Just unionProtocol) Nothing)
        |> Jpipe.custom (optionalField "protocol" (Jdec.map Just unionProtocolUnion) Nothing)
        |> Jpipe.custom (optionalField "public" (Jdec.map Just unionPublic) Nothing)
        |> Jpipe.custom (optionalField "quicktype" (Jdec.map Just unionQuicktype) Nothing)
        |> Jpipe.custom (optionalField "raise" (Jdec.map Just unionRaise) Nothing)
        |> Jpipe.custom (optionalField "range" (Jdec.map Just unionRange) Nothing)
        |> Jpipe.custom (optionalField "readonly" (Jdec.map Just unionReadonly) Nothing)
        |> Jpipe.custom (optionalField "ref" (Jdec.map Just unionRef) Nothing)
        |> Jpipe.custom (optionalField "RegExp" (Jdec.map Just unionRegExp) Nothing)
        |> Jpipe.custom (optionalField "register" (Jdec.map Just unionRegister) Nothing)
        |> Jpipe.custom (optionalField "reinterpret_cast" (Jdec.map Just unionReinterpretCast) Nothing)
        |> Jpipe.custom (optionalField "repeat" (Jdec.map Just unionRepeat) Nothing)
        |> Jpipe.custom (optionalField "require" (Jdec.map Just unionRequire) Nothing)
        |> Jpipe.custom (optionalField "required" (Jdec.map Just unionRequired) Nothing)
        |> Jpipe.custom (optionalField "requires" (Jdec.map Just unionRequires) Nothing)
        |> Jpipe.custom (optionalField "restrict" (Jdec.map Just unionRestrict) Nothing)
        |> Jpipe.custom (optionalField "retain" (Jdec.map Just unionRetain) Nothing)
        |> Jpipe.custom (optionalField "rethrows" (Jdec.map Just unionRethrows) Nothing)
        |> Jpipe.custom (optionalField "return" (Jdec.map Just unionReturn) Nothing)
        |> Jpipe.custom (optionalField "right" (Jdec.map Just unionRight) Nothing)
        |> Jpipe.custom (optionalField "runtimeType" (Jdec.map Just unionRuntimeType) Nothing)
        |> Jpipe.custom (optionalField "s" (Jdec.map Just unionS) Nothing)
        |> Jpipe.custom (optionalField "sbyte" (Jdec.map Just unionSbyte) Nothing)
        |> Jpipe.custom (optionalField "sealed" (Jdec.map Just unionSealed) Nothing)
        |> Jpipe.custom (optionalField "SEL" (Jdec.map Just unionSEL) Nothing)
        |> Jpipe.custom (optionalField "select" (Jdec.map Just unionSelect) Nothing)
        |> Jpipe.custom (optionalField "Self" (Jdec.map Just unionSelf) Nothing)
        |> Jpipe.custom (optionalField "self" (Jdec.map Just unionSelfUnion) Nothing)
        |> Jpipe.custom (optionalField "Sendable" (Jdec.map Just unionSendable) Nothing)
        |> Jpipe.custom (optionalField "SerialDescriptor" (Jdec.map Just unionSerialDescriptor) Nothing)
        |> Jpipe.custom (optionalField "Serializable" (Jdec.map Just unionSerializable) Nothing)
        |> Jpipe.custom (optionalField "SerializationFeature" (Jdec.map Just unionSerializationFeature) Nothing)
        |> Jpipe.custom (optionalField "serialize" (Jdec.map Just unionSerialize) Nothing)
        |> Jpipe.custom (optionalField "SerializerProvider" (Jdec.map Just unionSerializerProvider) Nothing)
        |> Jpipe.custom (optionalField "SerialName" (Jdec.map Just unionSerialName) Nothing)
        |> Jpipe.custom (optionalField "set" (Jdec.map Just unionSet) Nothing)
        |> Jpipe.custom (optionalField "short" (Jdec.map Just unionShort) Nothing)
        |> Jpipe.custom (optionalField "signed" (Jdec.map Just unionSigned) Nothing)
        |> Jpipe.custom (optionalField "SimpleModule" (Jdec.map Just unionSimpleModule) Nothing)
        |> Jpipe.custom (optionalField "sizeof" (Jdec.map Just unionSizeof) Nothing)
        |> Jpipe.custom (optionalField "stackalloc" (Jdec.map Just unionStackalloc) Nothing)
        |> Jpipe.custom (optionalField "Standards" (Jdec.map Just unionStandards) Nothing)
        |> Jpipe.custom (optionalField "static" (Jdec.map Just unionStatic) Nothing)
        |> Jpipe.custom (optionalField "static_assert" (Jdec.map Just unionStaticAssert) Nothing)
        |> Jpipe.custom (optionalField "static_cast" (Jdec.map Just unionStaticCast) Nothing)
        |> Jpipe.custom (optionalField "StdDeserializer" (Jdec.map Just unionStdDeserializer) Nothing)
        |> Jpipe.custom (optionalField "StdSerializer" (Jdec.map Just unionStdSerializer) Nothing)
        |> Jpipe.custom (optionalField "strictfp" (Jdec.map Just unionStrictfp) Nothing)
        |> Jpipe.custom (optionalField "string" (Jdec.map Just unionString) Nothing)
        |> Jpipe.custom (optionalField "struct" (Jdec.map Just unionStruct) Nothing)
        |> Jpipe.custom (optionalField "subscript" (Jdec.map Just unionSubscript) Nothing)
        |> Jpipe.custom (optionalField "super" (Jdec.map Just unionSuper) Nothing)
        |> Jpipe.custom (optionalField "switch" (Jdec.map Just unionSwitch) Nothing)
        |> Jpipe.custom (optionalField "symbol" (Jdec.map Just unionSymbol) Nothing)
        |> Jpipe.custom (optionalField "synchronized" (Jdec.map Just unionSynchronized) Nothing)
        |> Jpipe.custom (optionalField "system" (Jdec.map Just unionSystem) Nothing)
        |> Jpipe.custom (optionalField "template" (Jdec.map Just unionTemplate) Nothing)
        |> Jpipe.custom (optionalField "TextNode" (Jdec.map Just unionTextNode) Nothing)
        |> Jpipe.custom (optionalField "then" (Jdec.map Just unionThen) Nothing)
        |> Jpipe.custom (optionalField "this" (Jdec.map Just unionThis) Nothing)
        |> Jpipe.custom (optionalField "thread_local" (Jdec.map Just unionThreadLocal) Nothing)
        |> Jpipe.custom (optionalField "throw" (Jdec.map Just unionThrow) Nothing)
        |> Jpipe.custom (optionalField "throws" (Jdec.map Just unionThrows) Nothing)
        |> Jpipe.custom (optionalField "TimeOnly" (Jdec.map Just unionTimeOnly) Nothing)
        |> Jpipe.custom (optionalField "TimeOnlyConverter" (Jdec.map Just unionTimeOnlyConverter) Nothing)
        |> Jpipe.custom (optionalField "TimeZone" (Jdec.map Just unionTimeZone) Nothing)
        |> Jpipe.custom (optionalField "to_dict" (Jdec.map Just unionToDict) Nothing)
        |> Jpipe.custom (optionalField "to_json" (Jdec.map Just unionToJSON) Nothing)
        |> Jpipe.custom (optionalField "top_level" (Jdec.map Just unionTopLevel) Nothing)
        |> Jpipe.custom (optionalField "toString" (Jdec.map Just unionToString) Nothing)
        |> Jpipe.custom (optionalField "transient" (Jdec.map Just unionTransient) Nothing)
        |> Jpipe.custom (optionalField "True" (Jdec.map Just unionTrue) Nothing)
        |> Jpipe.custom (optionalField "true" (Jdec.map Just unionTrueUnion) Nothing)
        |> Jpipe.custom (optionalField "try" (Jdec.map Just unionTry) Nothing)
        |> Jpipe.custom (optionalField "Type" (Jdec.map Just unionType) Nothing)
        |> Jpipe.custom (optionalField "type" (Jdec.map Just unionTypeUnion) Nothing)
        |> Jpipe.custom (optionalField "typealias" (Jdec.map Just unionTypealias) Nothing)
        |> Jpipe.custom (optionalField "typedef" (Jdec.map Just unionTypedef) Nothing)
        |> Jpipe.custom (optionalField "typeid" (Jdec.map Just unionTypeid) Nothing)
        |> Jpipe.custom (optionalField "typename" (Jdec.map Just unionTypename) Nothing)
        |> Jpipe.custom (optionalField "typeof" (Jdec.map Just unionTypeof) Nothing)
        |> Jpipe.custom (optionalField "uint" (Jdec.map Just unionUint) Nothing)
        |> Jpipe.custom (optionalField "ulong" (Jdec.map Just unionUlong) Nothing)
        |> Jpipe.custom (optionalField "unchecked" (Jdec.map Just unionUnchecked) Nothing)
        |> Jpipe.custom (optionalField "undefined" (Jdec.map Just unionUndefined) Nothing)
        |> Jpipe.custom (optionalField "union" (Jdec.map Just unionUnionUnion) Nothing)
        |> Jpipe.custom (optionalField "UnmarshalJSON" (Jdec.map Just unionUnmarshalJSON) Nothing)
        |> Jpipe.custom (optionalField "unowned" (Jdec.map Just unionUnowned) Nothing)
        |> Jpipe.custom (optionalField "unsafe" (Jdec.map Just unionUnsafe) Nothing)
        |> Jpipe.custom (optionalField "unsigned" (Jdec.map Just unionUnsigned) Nothing)
        |> Jpipe.custom (optionalField "UseSerializers" (Jdec.map Just unionUseSerializers) Nothing)
        |> Jpipe.custom (optionalField "ushort" (Jdec.map Just unionUshort) Nothing)
        |> Jpipe.custom (optionalField "using" (Jdec.map Just unionUsing) Nothing)
        |> Jpipe.custom (optionalField "Utf8JsonReader" (Jdec.map Just unionUtf8JSONReader) Nothing)
        |> Jpipe.custom (optionalField "Utf8JsonWriter" (Jdec.map Just unionUtf8JSONWriter) Nothing)
        |> Jpipe.custom (optionalField "UUID" (Jdec.map Just unionUUID) Nothing)
        |> Jpipe.custom (optionalField "var" (Jdec.map Just unionVar) Nothing)
        |> Jpipe.custom (optionalField "virtual" (Jdec.map Just unionVirtual) Nothing)
        |> Jpipe.custom (optionalField "void" (Jdec.map Just unionVoid) Nothing)
        |> Jpipe.custom (optionalField "volatile" (Jdec.map Just unionVolatile) Nothing)
        |> Jpipe.custom (optionalField "wchar_t" (Jdec.map Just unionWcharT) Nothing)
        |> Jpipe.custom (optionalField "weak" (Jdec.map Just unionWeak) Nothing)
        |> Jpipe.custom (optionalField "where" (Jdec.map Just unionWhere) Nothing)
        |> Jpipe.custom (optionalField "while" (Jdec.map Just unionWhile) Nothing)
        |> Jpipe.custom (optionalField "willSet" (Jdec.map Just unionWillSet) Nothing)
        |> Jpipe.custom (optionalField "with" (Jdec.map Just unionWith) Nothing)
        |> Jpipe.custom (optionalField "xor" (Jdec.map Just unionXor) Nothing)
        |> Jpipe.custom (optionalField "xor_eq" (Jdec.map Just unionXorEq) Nothing)
        |> Jpipe.custom (optionalField "YES" (Jdec.map Just unionYES) Nothing)
        |> Jpipe.custom (optionalField "yield" (Jdec.map Just unionYield) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("_", makeNullableEncoder encodeUnionUnion x.empty)
        , ("_Bool", makeNullableEncoder encodeUnionBool x.quickTypeBool)
        , ("_Complex", makeNullableEncoder encodeUnionComplex x.complex)
        , ("_Imaginery", makeNullableEncoder encodeUnionImaginery x.imaginery)
        , ("abstract", makeNullableEncoder encodeUnionAbstract x.abstract)
        , ("alignas", makeNullableEncoder encodeUnionAlignas x.alignas)
        , ("alignof", makeNullableEncoder encodeUnionAlignof x.alignof)
        , ("and", makeNullableEncoder encodeUnionAnd x.and)
        , ("and_eq", makeNullableEncoder encodeUnionAndEq x.andEq)
        , ("any", makeNullableEncoder encodeUnionAnyUnion x.quickTypeAny)
        , ("Any", makeNullableEncoder encodeUnionAny x.any)
        , ("array", makeNullableEncoder encodeUnionArray x.array)
        , ("ArrayNode", makeNullableEncoder encodeUnionArrayNode x.arrayNode)
        , ("as", makeNullableEncoder encodeUnionAs x.quickTypeAs)
        , ("asm", makeNullableEncoder encodeUnionASM x.asm)
        , ("assert", makeNullableEncoder encodeUnionAssert x.assert)
        , ("associatedtype", makeNullableEncoder encodeUnionAssociatedtype x.associatedtype)
        , ("associativity", makeNullableEncoder encodeUnionAssociativity x.associativity)
        , ("async", makeNullableEncoder encodeUnionAsync x.async)
        , ("atomic", makeNullableEncoder encodeUnionAtomic x.atomic)
        , ("atomic_cancel", makeNullableEncoder encodeUnionAtomicCancel x.atomicCancel)
        , ("atomic_commit", makeNullableEncoder encodeUnionAtomicCommit x.atomicCommit)
        , ("atomic_noexcept", makeNullableEncoder encodeUnionAtomicNoexcept x.atomicNoexcept)
        , ("auto", makeNullableEncoder encodeUnionAuto x.auto)
        , ("await", makeNullableEncoder encodeUnionAwait x.await)
        , ("base", makeNullableEncoder encodeUnionBase x.base)
        , ("bitand", makeNullableEncoder encodeUnionBitand x.bitand)
        , ("bitor", makeNullableEncoder encodeUnionBitor x.bitor)
        , ("BOOL", makeNullableEncoder encodeUnionBOOL x.quickTypeBOOL)
        , ("bool", makeNullableEncoder encodeUnionBoolUnion x.purpleBool)
        , ("boolean", makeNullableEncoder encodeUnionBoolean x.boolean)
        , ("BooleanNode", makeNullableEncoder encodeUnionBooleanNode x.booleanNode)
        , ("break", makeNullableEncoder encodeUnionBreak x.break)
        , ("bycopy", makeNullableEncoder encodeUnionBycopy x.bycopy)
        , ("byref", makeNullableEncoder encodeUnionByref x.byref)
        , ("byte", makeNullableEncoder encodeUnionByte x.byte)
        , ("Calendar", makeNullableEncoder encodeUnionCalendar x.calendar)
        , ("case", makeNullableEncoder encodeUnionCase x.quickTypeCase)
        , ("catch", makeNullableEncoder encodeUnionCatch x.catch)
        , ("chan", makeNullableEncoder encodeUnionChan x.chan)
        , ("char", makeNullableEncoder encodeUnionChar x.char)
        , ("char16_t", makeNullableEncoder encodeUnionChar16T x.char16T)
        , ("char32_t", makeNullableEncoder encodeUnionChar32T x.char32T)
        , ("checked", makeNullableEncoder encodeUnionChecked x.checked)
        , ("class", makeNullableEncoder encodeUnionClassUnion x.quickTypeClass)
        , ("Class", makeNullableEncoder encodeUnionClass x.class)
        , ("clone", makeNullableEncoder encodeUnionClone x.clone)
        , ("co_await", makeNullableEncoder encodeUnionCoAwait x.coAwait)
        , ("co_return", makeNullableEncoder encodeUnionCoReturn x.coReturn)
        , ("co_yield", makeNullableEncoder encodeUnionCoYield x.coYield)
        , ("Codable", makeNullableEncoder encodeUnionCodable x.codable)
        , ("CodingKey", makeNullableEncoder encodeUnionCodingKey x.codingKey)
        , ("CodingKeys", makeNullableEncoder encodeUnionCodingKeys x.codingKeys)
        , ("compl", makeNullableEncoder encodeUnionCompl x.compl)
        , ("concept", makeNullableEncoder encodeUnionConcept x.concept)
        , ("console", makeNullableEncoder encodeUnionConsole x.console)
        , ("const", makeNullableEncoder encodeUnionConst x.const)
        , ("const_cast", makeNullableEncoder encodeUnionConstCast x.constCast)
        , ("constexpr", makeNullableEncoder encodeUnionConstexpr x.constexpr)
        , ("constructor", makeNullableEncoder encodeUnionConstructor x.constructor)
        , ("continue", makeNullableEncoder encodeUnionContinue x.continue)
        , ("convenience", makeNullableEncoder encodeUnionConvenience x.convenience)
        , ("convert", makeNullableEncoder encodeUnionConvert x.convert)
        , ("converter", makeNullableEncoder encodeUnionConverter x.converter)
        , ("CultureInfo", makeNullableEncoder encodeUnionCultureInfo x.cultureInfo)
        , ("date", makeNullableEncoder encodeUnionDate x.date)
        , ("date_parse_handling", makeNullableEncoder encodeUnionDateParseHandling x.dateParseHandling)
        , ("DateFormatter", makeNullableEncoder encodeUnionDateFormatter x.dateFormatter)
        , ("DateOnly", makeNullableEncoder encodeUnionDateOnly x.dateOnly)
        , ("DateOnlyConverter", makeNullableEncoder encodeUnionDateOnlyConverter x.dateOnlyConverter)
        , ("DateTime", makeNullableEncoder encodeUnionDateTime x.dateTime)
        , ("DateTimeStyles", makeNullableEncoder encodeUnionDateTimeStyles x.dateTimeStyles)
        , ("debugger", makeNullableEncoder encodeUnionDebugger x.debugger)
        , ("decimal", makeNullableEncoder encodeUnionDecimal x.decimal)
        , ("declare", makeNullableEncoder encodeUnionDeclare x.declare)
        , ("decltype", makeNullableEncoder encodeUnionDecltype x.decltype)
        , ("decode_string", makeNullableEncoder encodeUnionDecodeString x.decodeString)
        , ("Decoder", makeNullableEncoder encodeUnionDecoder x.quickTypeDecoder)
        , ("DecodingError", makeNullableEncoder encodeUnionDecodingError x.decodingError)
        , ("def", makeNullableEncoder encodeUnionDef x.def)
        , ("default", makeNullableEncoder encodeUnionDefault x.default)
        , ("defer", makeNullableEncoder encodeUnionDefer x.defer)
        , ("deinit", makeNullableEncoder encodeUnionDeinit x.deinit)
        , ("del", makeNullableEncoder encodeUnionDel x.del)
        , ("delegate", makeNullableEncoder encodeUnionDelegate x.delegate)
        , ("delete", makeNullableEncoder encodeUnionDelete x.delete)
        , ("DeserializationFeature", makeNullableEncoder encodeUnionDeserializationFeature x.deserializationFeature)
        , ("dict", makeNullableEncoder encodeUnionDict x.dict)
        , ("dictionary", makeNullableEncoder encodeUnionDictionary x.dictionary)
        , ("didSet", makeNullableEncoder encodeUnionDidSet x.didSet)
        , ("do", makeNullableEncoder encodeUnionDo x.do)
        , ("double", makeNullableEncoder encodeUnionDouble x.double)
        , ("DoubleNode", makeNullableEncoder encodeUnionDoubleNode x.doubleNode)
        , ("dummy", makeNullableEncoder Jenc.float x.dummy)
        , ("dynamic", makeNullableEncoder encodeUnionDynamic x.dynamic)
        , ("dynamic_cast", makeNullableEncoder encodeUnionDynamicCast x.dynamicCast)
        , ("elif", makeNullableEncoder encodeUnionElif x.elif)
        , ("else", makeNullableEncoder encodeUnionElse x.quickTypeElse)
        , ("encode_quick_type", makeNullableEncoder encodeUnionEncodeQuickType x.encodeQuickType)
        , ("Encoder", makeNullableEncoder encodeUnionEncoder x.encoder)
        , ("enum", makeNullableEncoder encodeUnionEnum x.enum)
        , ("EnumValues", makeNullableEncoder encodeUnionEnumValues x.enumValues)
        , ("equalityContract", makeNullableEncoder encodeUnionEqualityContract x.equalityContract)
        , ("Equatable", makeNullableEncoder encodeUnionEquatable x.equatable)
        , ("event", makeNullableEncoder encodeUnionEvent x.event)
        , ("except", makeNullableEncoder encodeUnionExcept x.except)
        , ("exception", makeNullableEncoder encodeUnionException x.exception)
        , ("explicit", makeNullableEncoder encodeUnionExplicit x.explicit)
        , ("export", makeNullableEncoder encodeUnionExport x.export)
        , ("exposing", makeNullableEncoder encodeUnionExposing x.quickTypeExposing)
        , ("extends", makeNullableEncoder encodeUnionExtends x.extends)
        , ("extension", makeNullableEncoder encodeUnionExtension x.extension)
        , ("extern", makeNullableEncoder encodeUnionExtern x.extern)
        , ("fallthrough", makeNullableEncoder encodeUnionFallthrough x.fallthrough)
        , ("false", makeNullableEncoder encodeUnionFalseUnion x.quickTypeFalse)
        , ("False", makeNullableEncoder encodeUnionFalse x.false)
        , ("fileprivate", makeNullableEncoder encodeUnionFileprivate x.fileprivate)
        , ("final", makeNullableEncoder encodeUnionFinal x.final)
        , ("finally", makeNullableEncoder encodeUnionFinally x.finally)
        , ("fixed", makeNullableEncoder encodeUnionFixed x.fixed)
        , ("float", makeNullableEncoder encodeUnionFloat x.quickTypeFloat)
        , ("for", makeNullableEncoder encodeUnionFor x.for)
        , ("foreach", makeNullableEncoder encodeUnionForeach x.foreach)
        , ("FormatException", makeNullableEncoder encodeUnionFormatException x.formatException)
        , ("friend", makeNullableEncoder encodeUnionFriend x.friend)
        , ("from", makeNullableEncoder encodeUnionFrom x.from)
        , ("from_dict", makeNullableEncoder encodeUnionFromDict x.fromDict)
        , ("from_json", makeNullableEncoder encodeUnionFromJSON x.fromJSON)
        , ("func", makeNullableEncoder encodeUnionFunc x.func)
        , ("function", makeNullableEncoder encodeUnionFunction x.function)
        , ("get", makeNullableEncoder encodeUnionGet x.get)
        , ("global", makeNullableEncoder encodeUnionGlobal x.global)
        , ("go", makeNullableEncoder encodeUnionGo x.go)
        , ("goto", makeNullableEncoder encodeUnionGoto x.goto)
        , ("guard", makeNullableEncoder encodeUnionGuard x.guard)
        , ("Hashable", makeNullableEncoder encodeUnionHashable x.hashable)
        , ("hashCode", makeNullableEncoder encodeUnionHashCode x.hashCode)
        , ("Hasher", makeNullableEncoder encodeUnionHasher x.hasher)
        , ("hasOwnProperty", makeNullableEncoder encodeUnionHasOwnProperty x.hasOwnProperty)
        , ("id", makeNullableEncoder encodeUnionID x.id)
        , ("if", makeNullableEncoder encodeUnionIf x.quickTypeIf)
        , ("IMP", makeNullableEncoder encodeUnionIMP x.imp)
        , ("implements", makeNullableEncoder encodeUnionImplements x.implements)
        , ("implicit", makeNullableEncoder encodeUnionImplicit x.implicit)
        , ("import", makeNullableEncoder encodeUnionImport x.quickTypeImport)
        , ("in", makeNullableEncoder encodeUnionIn x.quickTypeIn)
        , ("indirect", makeNullableEncoder encodeUnionIndirect x.indirect)
        , ("infix", makeNullableEncoder encodeUnionInfix x.quickTypeInfix)
        , ("init", makeNullableEncoder encodeUnionInit x.init)
        , ("inline", makeNullableEncoder encodeUnionInline x.inline)
        , ("inout", makeNullableEncoder encodeUnionInout x.inout)
        , ("instanceof", makeNullableEncoder encodeUnionInstanceof x.instanceof)
        , ("int", makeNullableEncoder encodeUnionInt x.quickTypeInt)
        , ("interface", makeNullableEncoder encodeUnionInterface x.interface)
        , ("internal", makeNullableEncoder encodeUnionInternal x.internal)
        , ("IntNode", makeNullableEncoder encodeUnionIntNode x.intNode)
        , ("is", makeNullableEncoder encodeUnionIs x.is)
        , ("IsoDateTimeOffsetConverter", makeNullableEncoder encodeUnionISODateTimeOffsetConverter x.isoDateTimeOffsetConverter)
        , ("iterable", makeNullableEncoder encodeUnionIterable x.iterable)
        , ("jdec", makeNullableEncoder encodeUnionJdec x.jdec)
        , ("jenc", makeNullableEncoder encodeUnionJenc x.jenc)
        , ("jpipe", makeNullableEncoder encodeUnionJpipe x.jpipe)
        , ("json", makeNullableEncoder encodeUnionJSON x.json)
        , ("json_converter", makeNullableEncoder encodeUnionJSONConverter x.jsonConverter)
        , ("json_serializer", makeNullableEncoder encodeUnionJSONSerializer x.jsonSerializer)
        , ("json_token", makeNullableEncoder encodeUnionJSONToken x.jsonToken)
        , ("json_writer", makeNullableEncoder encodeUnionJSONWriter x.jsonWriter)
        , ("JSONAny", makeNullableEncoder encodeUnionJSONAny x.jsonAny)
        , ("JSONCodingKey", makeNullableEncoder encodeUnionJSONCodingKey x.jsonCodingKey)
        , ("JSONDecoder", makeNullableEncoder encodeUnionJSONDecoder x.jsonDecoder)
        , ("JSONEncoder", makeNullableEncoder encodeUnionJSONEncoder x.jsonEncoder)
        , ("JsonException", makeNullableEncoder encodeUnionJSONException x.jsonException)
        , ("JsonGenerator", makeNullableEncoder encodeUnionJSONGenerator x.jsonGenerator)
        , ("JsonNode", makeNullableEncoder encodeUnionJSONNode x.jsonNode)
        , ("JSONNull", makeNullableEncoder encodeUnionJSONNull x.jsonNull)
        , ("JsonParser", makeNullableEncoder encodeUnionJSONParser x.jsonParser)
        , ("JsonReader", makeNullableEncoder encodeUnionJSONReader x.jsonReader)
        , ("JsonTokenType", makeNullableEncoder encodeUnionJSONTokenType x.jsonTokenType)
        , ("KSerializer", makeNullableEncoder encodeUnionKSerializer x.kSerializer)
        , ("lambda", makeNullableEncoder encodeUnionLambda x.lambda)
        , ("lazy", makeNullableEncoder encodeUnionLazy x.lazy)
        , ("left", makeNullableEncoder encodeUnionLeft x.left)
        , ("let", makeNullableEncoder encodeUnionLet x.quickTypeLet)
        , ("list", makeNullableEncoder encodeUnionList x.list)
        , ("LocalDate", makeNullableEncoder encodeUnionLocalDate x.localDate)
        , ("Locale", makeNullableEncoder encodeUnionLocale x.locale)
        , ("lock", makeNullableEncoder encodeUnionLock x.lock)
        , ("long", makeNullableEncoder encodeUnionLong x.long)
        , ("LongNode", makeNullableEncoder encodeUnionLongNode x.longNode)
        , ("map", makeNullableEncoder encodeUnionMap x.map)
        , ("MapEntry", makeNullableEncoder encodeUnionMapEntry x.mapEntry)
        , ("MarshalJSON", makeNullableEncoder encodeUnionMarshalJSON x.marshalJSON)
        , ("metadata_property_handling", makeNullableEncoder encodeUnionMetadataPropertyHandling x.metadataPropertyHandling)
        , ("module", makeNullableEncoder encodeUnionModule x.quickTypeModule)
        , ("mutable", makeNullableEncoder encodeUnionMutable x.mutable)
        , ("mutating", makeNullableEncoder encodeUnionMutating x.mutating)
        , ("namespace", makeNullableEncoder encodeUnionNamespace x.namespace)
        , ("native", makeNullableEncoder encodeUnionNative x.native)
        , ("new", makeNullableEncoder encodeUnionNew x.new)
        , ("newtonsoft", makeNullableEncoder encodeUnionNewtonsoft x.newtonsoft)
        , ("nil", makeNullableEncoder encodeUnionNil x.nil)
        , ("NO", makeNullableEncoder encodeUnionNO x.no)
        , ("noexcept", makeNullableEncoder encodeUnionNoexcept x.noexcept)
        , ("nonatomic", makeNullableEncoder encodeUnionNonatomic x.nonatomic)
        , ("none", makeNullableEncoder encodeUnionNoneUnion x.quickTypeNone)
        , ("None", makeNullableEncoder encodeUnionNone x.none)
        , ("nonlocal", makeNullableEncoder encodeUnionNonlocal x.nonlocal)
        , ("nonmutating", makeNullableEncoder encodeUnionNonmutating x.nonmutating)
        , ("noSuchMethod", makeNullableEncoder encodeUnionNoSuchMethod x.noSuchMethod)
        , ("not", makeNullableEncoder encodeUnionNot x.not)
        , ("not_eq", makeNullableEncoder encodeUnionNotEq x.notEq)
        , ("NSError", makeNullableEncoder encodeUnionNSError x.nsError)
        , ("NSObject", makeNullableEncoder encodeUnionNSObject x.nsObject)
        , ("NSString", makeNullableEncoder encodeUnionNSString x.nsString)
        , ("NULL", makeNullableEncoder encodeUnionNULL x.null)
        , ("null", makeNullableEncoder encodeUnionNull x.quickTypeNull)
        , ("NullNode", makeNullableEncoder encodeUnionNullNode x.nullNode)
        , ("nullptr", makeNullableEncoder encodeUnionNullptr x.nullptr)
        , ("number", makeNullableEncoder encodeUnionNumber x.number)
        , ("object", makeNullableEncoder encodeUnionObject x.object)
        , ("ObjectMapper", makeNullableEncoder encodeUnionObjectMapper x.objectMapper)
        , ("ObjectNode", makeNullableEncoder encodeUnionObjectNode x.objectNode)
        , ("ObjectReader", makeNullableEncoder encodeUnionObjectReader x.objectReader)
        , ("ObjectWriter", makeNullableEncoder encodeUnionObjectWriter x.objectWriter)
        , ("of", makeNullableEncoder encodeUnionOf x.quickTypeOf)
        , ("OffsetDateTime", makeNullableEncoder encodeUnionOffsetDateTime x.offsetDateTime)
        , ("OffsetTime", makeNullableEncoder encodeUnionOffsetTime x.offsetTime)
        , ("oneway", makeNullableEncoder encodeUnionOneway x.oneway)
        , ("open", makeNullableEncoder encodeUnionOpen x.open)
        , ("operator", makeNullableEncoder encodeUnionOperator x.operator)
        , ("optional", makeNullableEncoder encodeUnionOptional x.optional)
        , ("or", makeNullableEncoder encodeUnionOr x.or)
        , ("or_eq", makeNullableEncoder encodeUnionOrEq x.orEq)
        , ("out", makeNullableEncoder encodeUnionOut x.out)
        , ("override", makeNullableEncoder encodeUnionOverride x.override)
        , ("package", makeNullableEncoder encodeUnionPackage x.package)
        , ("params", makeNullableEncoder encodeUnionParams x.params)
        , ("pass", makeNullableEncoder encodeUnionPass x.pass)
        , ("port", makeNullableEncoder encodeUnionPort x.quickTypePort)
        , ("postfix", makeNullableEncoder encodeUnionPostfix x.postfix)
        , ("precedence", makeNullableEncoder encodeUnionPrecedence x.precedence)
        , ("prefix", makeNullableEncoder encodeUnionPrefix x.prefix)
        , ("PrimitiveKind", makeNullableEncoder encodeUnionPrimitiveKind x.primitiveKind)
        , ("print", makeNullableEncoder encodeUnionPrint x.print)
        , ("printf", makeNullableEncoder encodeUnionPrintf x.printf)
        , ("printMembers", makeNullableEncoder encodeUnionPrintMembers x.printMembers)
        , ("private", makeNullableEncoder encodeUnionPrivate x.private)
        , ("protected", makeNullableEncoder encodeUnionProtected x.protected)
        , ("Protocol", makeNullableEncoder encodeUnionProtocol x.protocol)
        , ("protocol", makeNullableEncoder encodeUnionProtocolUnion x.quickTypeProtocol)
        , ("public", makeNullableEncoder encodeUnionPublic x.public)
        , ("quicktype", makeNullableEncoder encodeUnionQuicktype x.quicktype)
        , ("raise", makeNullableEncoder encodeUnionRaise x.raise)
        , ("range", makeNullableEncoder encodeUnionRange x.range)
        , ("readonly", makeNullableEncoder encodeUnionReadonly x.readonly)
        , ("ref", makeNullableEncoder encodeUnionRef x.ref)
        , ("RegExp", makeNullableEncoder encodeUnionRegExp x.regExp)
        , ("register", makeNullableEncoder encodeUnionRegister x.register)
        , ("reinterpret_cast", makeNullableEncoder encodeUnionReinterpretCast x.reinterpretCast)
        , ("repeat", makeNullableEncoder encodeUnionRepeat x.repeat)
        , ("require", makeNullableEncoder encodeUnionRequire x.require)
        , ("required", makeNullableEncoder encodeUnionRequired x.required)
        , ("requires", makeNullableEncoder encodeUnionRequires x.requires)
        , ("restrict", makeNullableEncoder encodeUnionRestrict x.restrict)
        , ("retain", makeNullableEncoder encodeUnionRetain x.retain)
        , ("rethrows", makeNullableEncoder encodeUnionRethrows x.rethrows)
        , ("return", makeNullableEncoder encodeUnionReturn x.return)
        , ("right", makeNullableEncoder encodeUnionRight x.right)
        , ("runtimeType", makeNullableEncoder encodeUnionRuntimeType x.runtimeType)
        , ("s", makeNullableEncoder encodeUnionS x.s)
        , ("sbyte", makeNullableEncoder encodeUnionSbyte x.sbyte)
        , ("sealed", makeNullableEncoder encodeUnionSealed x.sealed)
        , ("SEL", makeNullableEncoder encodeUnionSEL x.sel)
        , ("select", makeNullableEncoder encodeUnionSelect x.select)
        , ("Self", makeNullableEncoder encodeUnionSelf x.self)
        , ("self", makeNullableEncoder encodeUnionSelfUnion x.quickTypeSelf)
        , ("Sendable", makeNullableEncoder encodeUnionSendable x.sendable)
        , ("SerialDescriptor", makeNullableEncoder encodeUnionSerialDescriptor x.serialDescriptor)
        , ("Serializable", makeNullableEncoder encodeUnionSerializable x.serializable)
        , ("SerializationFeature", makeNullableEncoder encodeUnionSerializationFeature x.serializationFeature)
        , ("serialize", makeNullableEncoder encodeUnionSerialize x.serialize)
        , ("SerializerProvider", makeNullableEncoder encodeUnionSerializerProvider x.serializerProvider)
        , ("SerialName", makeNullableEncoder encodeUnionSerialName x.serialName)
        , ("set", makeNullableEncoder encodeUnionSet x.set)
        , ("short", makeNullableEncoder encodeUnionShort x.short)
        , ("signed", makeNullableEncoder encodeUnionSigned x.signed)
        , ("SimpleModule", makeNullableEncoder encodeUnionSimpleModule x.simpleModule)
        , ("sizeof", makeNullableEncoder encodeUnionSizeof x.sizeof)
        , ("stackalloc", makeNullableEncoder encodeUnionStackalloc x.stackalloc)
        , ("Standards", makeNullableEncoder encodeUnionStandards x.standards)
        , ("static", makeNullableEncoder encodeUnionStatic x.static)
        , ("static_assert", makeNullableEncoder encodeUnionStaticAssert x.staticAssert)
        , ("static_cast", makeNullableEncoder encodeUnionStaticCast x.staticCast)
        , ("StdDeserializer", makeNullableEncoder encodeUnionStdDeserializer x.stdDeserializer)
        , ("StdSerializer", makeNullableEncoder encodeUnionStdSerializer x.stdSerializer)
        , ("strictfp", makeNullableEncoder encodeUnionStrictfp x.strictfp)
        , ("string", makeNullableEncoder encodeUnionString x.quickTypeString)
        , ("struct", makeNullableEncoder encodeUnionStruct x.struct)
        , ("subscript", makeNullableEncoder encodeUnionSubscript x.subscript)
        , ("super", makeNullableEncoder encodeUnionSuper x.super)
        , ("switch", makeNullableEncoder encodeUnionSwitch x.switch)
        , ("symbol", makeNullableEncoder encodeUnionSymbol x.symbol)
        , ("synchronized", makeNullableEncoder encodeUnionSynchronized x.synchronized)
        , ("system", makeNullableEncoder encodeUnionSystem x.system)
        , ("template", makeNullableEncoder encodeUnionTemplate x.template)
        , ("TextNode", makeNullableEncoder encodeUnionTextNode x.textNode)
        , ("then", makeNullableEncoder encodeUnionThen x.quickTypeThen)
        , ("this", makeNullableEncoder encodeUnionThis x.this)
        , ("thread_local", makeNullableEncoder encodeUnionThreadLocal x.threadLocal)
        , ("throw", makeNullableEncoder encodeUnionThrow x.throw)
        , ("throws", makeNullableEncoder encodeUnionThrows x.throws)
        , ("TimeOnly", makeNullableEncoder encodeUnionTimeOnly x.timeOnly)
        , ("TimeOnlyConverter", makeNullableEncoder encodeUnionTimeOnlyConverter x.timeOnlyConverter)
        , ("TimeZone", makeNullableEncoder encodeUnionTimeZone x.timeZone)
        , ("to_dict", makeNullableEncoder encodeUnionToDict x.toDict)
        , ("to_json", makeNullableEncoder encodeUnionToJSON x.toJSON)
        , ("top_level", makeNullableEncoder encodeUnionTopLevel x.topLevel)
        , ("toString", makeNullableEncoder encodeUnionToString x.toString)
        , ("transient", makeNullableEncoder encodeUnionTransient x.transient)
        , ("True", makeNullableEncoder encodeUnionTrue x.true)
        , ("true", makeNullableEncoder encodeUnionTrueUnion x.quickTypeTrue)
        , ("try", makeNullableEncoder encodeUnionTry x.try)
        , ("Type", makeNullableEncoder encodeUnionType x.quickTypeType)
        , ("type", makeNullableEncoder encodeUnionTypeUnion x.purpleType)
        , ("typealias", makeNullableEncoder encodeUnionTypealias x.typealias)
        , ("typedef", makeNullableEncoder encodeUnionTypedef x.typedef)
        , ("typeid", makeNullableEncoder encodeUnionTypeid x.typeid)
        , ("typename", makeNullableEncoder encodeUnionTypename x.typename)
        , ("typeof", makeNullableEncoder encodeUnionTypeof x.typeof)
        , ("uint", makeNullableEncoder encodeUnionUint x.uint)
        , ("ulong", makeNullableEncoder encodeUnionUlong x.ulong)
        , ("unchecked", makeNullableEncoder encodeUnionUnchecked x.unchecked)
        , ("undefined", makeNullableEncoder encodeUnionUndefined x.undefined)
        , ("union", makeNullableEncoder encodeUnionUnionUnion x.union)
        , ("UnmarshalJSON", makeNullableEncoder encodeUnionUnmarshalJSON x.unmarshalJSON)
        , ("unowned", makeNullableEncoder encodeUnionUnowned x.unowned)
        , ("unsafe", makeNullableEncoder encodeUnionUnsafe x.unsafe)
        , ("unsigned", makeNullableEncoder encodeUnionUnsigned x.unsigned)
        , ("UseSerializers", makeNullableEncoder encodeUnionUseSerializers x.useSerializers)
        , ("ushort", makeNullableEncoder encodeUnionUshort x.ushort)
        , ("using", makeNullableEncoder encodeUnionUsing x.using)
        , ("Utf8JsonReader", makeNullableEncoder encodeUnionUtf8JSONReader x.utf8JSONReader)
        , ("Utf8JsonWriter", makeNullableEncoder encodeUnionUtf8JSONWriter x.utf8JSONWriter)
        , ("UUID", makeNullableEncoder encodeUnionUUID x.uuid)
        , ("var", makeNullableEncoder encodeUnionVar x.var)
        , ("virtual", makeNullableEncoder encodeUnionVirtual x.virtual)
        , ("void", makeNullableEncoder encodeUnionVoid x.void)
        , ("volatile", makeNullableEncoder encodeUnionVolatile x.volatile)
        , ("wchar_t", makeNullableEncoder encodeUnionWcharT x.wcharT)
        , ("weak", makeNullableEncoder encodeUnionWeak x.weak)
        , ("where", makeNullableEncoder encodeUnionWhere x.quickTypeWhere)
        , ("while", makeNullableEncoder encodeUnionWhile x.while)
        , ("willSet", makeNullableEncoder encodeUnionWillSet x.willSet)
        , ("with", makeNullableEncoder encodeUnionWith x.with)
        , ("xor", makeNullableEncoder encodeUnionXor x.xor)
        , ("xor_eq", makeNullableEncoder encodeUnionXorEq x.xorEq)
        , ("YES", makeNullableEncoder encodeUnionYES x.yes)
        , ("yield", makeNullableEncoder encodeUnionYield x.yield)
        ]

unionAbstract : Jdec.Decoder UnionAbstract
unionAbstract =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAbstract Jdec.float
        , Jdec.map AbstractInUnionAbstract abstract
        ]

encodeUnionAbstract : UnionAbstract -> Jenc.Value
encodeUnionAbstract x = case x of
    DoubleInUnionAbstract y -> Jenc.float y
    AbstractInUnionAbstract y -> encodeAbstract y

abstract : Jdec.Decoder Abstract
abstract =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Abstract)

encodeAbstract : Abstract -> Jenc.Value
encodeAbstract x =
    Jenc.object
        [
        ]

unionAlignas : Jdec.Decoder UnionAlignas
unionAlignas =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAlignas Jdec.float
        , Jdec.map AlignasInUnionAlignas alignas
        ]

encodeUnionAlignas : UnionAlignas -> Jenc.Value
encodeUnionAlignas x = case x of
    DoubleInUnionAlignas y -> Jenc.float y
    AlignasInUnionAlignas y -> encodeAlignas y

alignas : Jdec.Decoder Alignas
alignas =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Alignas)

encodeAlignas : Alignas -> Jenc.Value
encodeAlignas x =
    Jenc.object
        [
        ]

unionAlignof : Jdec.Decoder UnionAlignof
unionAlignof =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAlignof Jdec.float
        , Jdec.map AlignofInUnionAlignof alignof
        ]

encodeUnionAlignof : UnionAlignof -> Jenc.Value
encodeUnionAlignof x = case x of
    DoubleInUnionAlignof y -> Jenc.float y
    AlignofInUnionAlignof y -> encodeAlignof y

alignof : Jdec.Decoder Alignof
alignof =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Alignof)

encodeAlignof : Alignof -> Jenc.Value
encodeAlignof x =
    Jenc.object
        [
        ]

unionAnd : Jdec.Decoder UnionAnd
unionAnd =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAnd Jdec.float
        , Jdec.map AndInUnionAnd and
        ]

encodeUnionAnd : UnionAnd -> Jenc.Value
encodeUnionAnd x = case x of
    DoubleInUnionAnd y -> Jenc.float y
    AndInUnionAnd y -> encodeAnd y

and : Jdec.Decoder And
and =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> And)

encodeAnd : And -> Jenc.Value
encodeAnd x =
    Jenc.object
        [
        ]

unionAndEq : Jdec.Decoder UnionAndEq
unionAndEq =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAndEq Jdec.float
        , Jdec.map AndEqInUnionAndEq andEq
        ]

encodeUnionAndEq : UnionAndEq -> Jenc.Value
encodeUnionAndEq x = case x of
    DoubleInUnionAndEq y -> Jenc.float y
    AndEqInUnionAndEq y -> encodeAndEq y

andEq : Jdec.Decoder AndEq
andEq =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> AndEq)

encodeAndEq : AndEq -> Jenc.Value
encodeAndEq x =
    Jenc.object
        [
        ]

unionAny : Jdec.Decoder UnionAny
unionAny =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAny Jdec.float
        , Jdec.map AnyInUnionAny any
        ]

encodeUnionAny : UnionAny -> Jenc.Value
encodeUnionAny x = case x of
    DoubleInUnionAny y -> Jenc.float y
    AnyInUnionAny y -> encodeAny y

any : Jdec.Decoder Any
any =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Any)

encodeAny : Any -> Jenc.Value
encodeAny x =
    Jenc.object
        [
        ]

unionArray : Jdec.Decoder UnionArray
unionArray =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionArray Jdec.float
        , Jdec.map ArrayClassInUnionArray arrayClass
        ]

encodeUnionArray : UnionArray -> Jenc.Value
encodeUnionArray x = case x of
    DoubleInUnionArray y -> Jenc.float y
    ArrayClassInUnionArray y -> encodeArrayClass y

arrayClass : Jdec.Decoder ArrayClass
arrayClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ArrayClass)

encodeArrayClass : ArrayClass -> Jenc.Value
encodeArrayClass x =
    Jenc.object
        [
        ]

unionArrayNode : Jdec.Decoder UnionArrayNode
unionArrayNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionArrayNode Jdec.float
        , Jdec.map ArrayNodeInUnionArrayNode arrayNode
        ]

encodeUnionArrayNode : UnionArrayNode -> Jenc.Value
encodeUnionArrayNode x = case x of
    DoubleInUnionArrayNode y -> Jenc.float y
    ArrayNodeInUnionArrayNode y -> encodeArrayNode y

arrayNode : Jdec.Decoder ArrayNode
arrayNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ArrayNode)

encodeArrayNode : ArrayNode -> Jenc.Value
encodeArrayNode x =
    Jenc.object
        [
        ]

unionASM : Jdec.Decoder UnionASM
unionASM =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionASM Jdec.float
        , Jdec.map ASMInUnionASM asm
        ]

encodeUnionASM : UnionASM -> Jenc.Value
encodeUnionASM x = case x of
    DoubleInUnionASM y -> Jenc.float y
    ASMInUnionASM y -> encodeASM y

asm : Jdec.Decoder ASM
asm =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ASM)

encodeASM : ASM -> Jenc.Value
encodeASM x =
    Jenc.object
        [
        ]

unionAssert : Jdec.Decoder UnionAssert
unionAssert =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAssert Jdec.float
        , Jdec.map AssertInUnionAssert assert
        ]

encodeUnionAssert : UnionAssert -> Jenc.Value
encodeUnionAssert x = case x of
    DoubleInUnionAssert y -> Jenc.float y
    AssertInUnionAssert y -> encodeAssert y

assert : Jdec.Decoder Assert
assert =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Assert)

encodeAssert : Assert -> Jenc.Value
encodeAssert x =
    Jenc.object
        [
        ]

unionAssociatedtype : Jdec.Decoder UnionAssociatedtype
unionAssociatedtype =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAssociatedtype Jdec.float
        , Jdec.map AssociatedtypeInUnionAssociatedtype associatedtype
        ]

encodeUnionAssociatedtype : UnionAssociatedtype -> Jenc.Value
encodeUnionAssociatedtype x = case x of
    DoubleInUnionAssociatedtype y -> Jenc.float y
    AssociatedtypeInUnionAssociatedtype y -> encodeAssociatedtype y

associatedtype : Jdec.Decoder Associatedtype
associatedtype =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Associatedtype)

encodeAssociatedtype : Associatedtype -> Jenc.Value
encodeAssociatedtype x =
    Jenc.object
        [
        ]

unionAssociativity : Jdec.Decoder UnionAssociativity
unionAssociativity =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAssociativity Jdec.float
        , Jdec.map AssociativityInUnionAssociativity associativity
        ]

encodeUnionAssociativity : UnionAssociativity -> Jenc.Value
encodeUnionAssociativity x = case x of
    DoubleInUnionAssociativity y -> Jenc.float y
    AssociativityInUnionAssociativity y -> encodeAssociativity y

associativity : Jdec.Decoder Associativity
associativity =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Associativity)

encodeAssociativity : Associativity -> Jenc.Value
encodeAssociativity x =
    Jenc.object
        [
        ]

unionAsync : Jdec.Decoder UnionAsync
unionAsync =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAsync Jdec.float
        , Jdec.map AsyncInUnionAsync async
        ]

encodeUnionAsync : UnionAsync -> Jenc.Value
encodeUnionAsync x = case x of
    DoubleInUnionAsync y -> Jenc.float y
    AsyncInUnionAsync y -> encodeAsync y

async : Jdec.Decoder Async
async =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Async)

encodeAsync : Async -> Jenc.Value
encodeAsync x =
    Jenc.object
        [
        ]

unionAtomic : Jdec.Decoder UnionAtomic
unionAtomic =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAtomic Jdec.float
        , Jdec.map AtomicInUnionAtomic atomic
        ]

encodeUnionAtomic : UnionAtomic -> Jenc.Value
encodeUnionAtomic x = case x of
    DoubleInUnionAtomic y -> Jenc.float y
    AtomicInUnionAtomic y -> encodeAtomic y

atomic : Jdec.Decoder Atomic
atomic =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Atomic)

encodeAtomic : Atomic -> Jenc.Value
encodeAtomic x =
    Jenc.object
        [
        ]

unionAtomicCancel : Jdec.Decoder UnionAtomicCancel
unionAtomicCancel =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAtomicCancel Jdec.float
        , Jdec.map AtomicCancelInUnionAtomicCancel atomicCancel
        ]

encodeUnionAtomicCancel : UnionAtomicCancel -> Jenc.Value
encodeUnionAtomicCancel x = case x of
    DoubleInUnionAtomicCancel y -> Jenc.float y
    AtomicCancelInUnionAtomicCancel y -> encodeAtomicCancel y

atomicCancel : Jdec.Decoder AtomicCancel
atomicCancel =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> AtomicCancel)

encodeAtomicCancel : AtomicCancel -> Jenc.Value
encodeAtomicCancel x =
    Jenc.object
        [
        ]

unionAtomicCommit : Jdec.Decoder UnionAtomicCommit
unionAtomicCommit =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAtomicCommit Jdec.float
        , Jdec.map AtomicCommitInUnionAtomicCommit atomicCommit
        ]

encodeUnionAtomicCommit : UnionAtomicCommit -> Jenc.Value
encodeUnionAtomicCommit x = case x of
    DoubleInUnionAtomicCommit y -> Jenc.float y
    AtomicCommitInUnionAtomicCommit y -> encodeAtomicCommit y

atomicCommit : Jdec.Decoder AtomicCommit
atomicCommit =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> AtomicCommit)

encodeAtomicCommit : AtomicCommit -> Jenc.Value
encodeAtomicCommit x =
    Jenc.object
        [
        ]

unionAtomicNoexcept : Jdec.Decoder UnionAtomicNoexcept
unionAtomicNoexcept =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAtomicNoexcept Jdec.float
        , Jdec.map AtomicNoexceptInUnionAtomicNoexcept atomicNoexcept
        ]

encodeUnionAtomicNoexcept : UnionAtomicNoexcept -> Jenc.Value
encodeUnionAtomicNoexcept x = case x of
    DoubleInUnionAtomicNoexcept y -> Jenc.float y
    AtomicNoexceptInUnionAtomicNoexcept y -> encodeAtomicNoexcept y

atomicNoexcept : Jdec.Decoder AtomicNoexcept
atomicNoexcept =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> AtomicNoexcept)

encodeAtomicNoexcept : AtomicNoexcept -> Jenc.Value
encodeAtomicNoexcept x =
    Jenc.object
        [
        ]

unionAuto : Jdec.Decoder UnionAuto
unionAuto =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAuto Jdec.float
        , Jdec.map AutoInUnionAuto auto
        ]

encodeUnionAuto : UnionAuto -> Jenc.Value
encodeUnionAuto x = case x of
    DoubleInUnionAuto y -> Jenc.float y
    AutoInUnionAuto y -> encodeAuto y

auto : Jdec.Decoder Auto
auto =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Auto)

encodeAuto : Auto -> Jenc.Value
encodeAuto x =
    Jenc.object
        [
        ]

unionAwait : Jdec.Decoder UnionAwait
unionAwait =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAwait Jdec.float
        , Jdec.map AwaitInUnionAwait await
        ]

encodeUnionAwait : UnionAwait -> Jenc.Value
encodeUnionAwait x = case x of
    DoubleInUnionAwait y -> Jenc.float y
    AwaitInUnionAwait y -> encodeAwait y

await : Jdec.Decoder Await
await =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Await)

encodeAwait : Await -> Jenc.Value
encodeAwait x =
    Jenc.object
        [
        ]

unionBase : Jdec.Decoder UnionBase
unionBase =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBase Jdec.float
        , Jdec.map BaseInUnionBase base
        ]

encodeUnionBase : UnionBase -> Jenc.Value
encodeUnionBase x = case x of
    DoubleInUnionBase y -> Jenc.float y
    BaseInUnionBase y -> encodeBase y

base : Jdec.Decoder Base
base =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Base)

encodeBase : Base -> Jenc.Value
encodeBase x =
    Jenc.object
        [
        ]

unionBitand : Jdec.Decoder UnionBitand
unionBitand =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBitand Jdec.float
        , Jdec.map BitandInUnionBitand bitand
        ]

encodeUnionBitand : UnionBitand -> Jenc.Value
encodeUnionBitand x = case x of
    DoubleInUnionBitand y -> Jenc.float y
    BitandInUnionBitand y -> encodeBitand y

bitand : Jdec.Decoder Bitand
bitand =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Bitand)

encodeBitand : Bitand -> Jenc.Value
encodeBitand x =
    Jenc.object
        [
        ]

unionBitor : Jdec.Decoder UnionBitor
unionBitor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBitor Jdec.float
        , Jdec.map BitorInUnionBitor bitor
        ]

encodeUnionBitor : UnionBitor -> Jenc.Value
encodeUnionBitor x = case x of
    DoubleInUnionBitor y -> Jenc.float y
    BitorInUnionBitor y -> encodeBitor y

bitor : Jdec.Decoder Bitor
bitor =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Bitor)

encodeBitor : Bitor -> Jenc.Value
encodeBitor x =
    Jenc.object
        [
        ]

unionBoolean : Jdec.Decoder UnionBoolean
unionBoolean =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBoolean Jdec.float
        , Jdec.map BooleanInUnionBoolean boolean
        ]

encodeUnionBoolean : UnionBoolean -> Jenc.Value
encodeUnionBoolean x = case x of
    DoubleInUnionBoolean y -> Jenc.float y
    BooleanInUnionBoolean y -> encodeBoolean y

boolean : Jdec.Decoder Boolean
boolean =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Boolean)

encodeBoolean : Boolean -> Jenc.Value
encodeBoolean x =
    Jenc.object
        [
        ]

unionBooleanNode : Jdec.Decoder UnionBooleanNode
unionBooleanNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBooleanNode Jdec.float
        , Jdec.map BooleanNodeInUnionBooleanNode booleanNode
        ]

encodeUnionBooleanNode : UnionBooleanNode -> Jenc.Value
encodeUnionBooleanNode x = case x of
    DoubleInUnionBooleanNode y -> Jenc.float y
    BooleanNodeInUnionBooleanNode y -> encodeBooleanNode y

booleanNode : Jdec.Decoder BooleanNode
booleanNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> BooleanNode)

encodeBooleanNode : BooleanNode -> Jenc.Value
encodeBooleanNode x =
    Jenc.object
        [
        ]

unionBreak : Jdec.Decoder UnionBreak
unionBreak =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBreak Jdec.float
        , Jdec.map BreakInUnionBreak break
        ]

encodeUnionBreak : UnionBreak -> Jenc.Value
encodeUnionBreak x = case x of
    DoubleInUnionBreak y -> Jenc.float y
    BreakInUnionBreak y -> encodeBreak y

break : Jdec.Decoder Break
break =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Break)

encodeBreak : Break -> Jenc.Value
encodeBreak x =
    Jenc.object
        [
        ]

unionBycopy : Jdec.Decoder UnionBycopy
unionBycopy =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBycopy Jdec.float
        , Jdec.map BycopyInUnionBycopy bycopy
        ]

encodeUnionBycopy : UnionBycopy -> Jenc.Value
encodeUnionBycopy x = case x of
    DoubleInUnionBycopy y -> Jenc.float y
    BycopyInUnionBycopy y -> encodeBycopy y

bycopy : Jdec.Decoder Bycopy
bycopy =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Bycopy)

encodeBycopy : Bycopy -> Jenc.Value
encodeBycopy x =
    Jenc.object
        [
        ]

unionByref : Jdec.Decoder UnionByref
unionByref =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionByref Jdec.float
        , Jdec.map ByrefInUnionByref byref
        ]

encodeUnionByref : UnionByref -> Jenc.Value
encodeUnionByref x = case x of
    DoubleInUnionByref y -> Jenc.float y
    ByrefInUnionByref y -> encodeByref y

byref : Jdec.Decoder Byref
byref =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Byref)

encodeByref : Byref -> Jenc.Value
encodeByref x =
    Jenc.object
        [
        ]

unionByte : Jdec.Decoder UnionByte
unionByte =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionByte Jdec.float
        , Jdec.map ByteInUnionByte byte
        ]

encodeUnionByte : UnionByte -> Jenc.Value
encodeUnionByte x = case x of
    DoubleInUnionByte y -> Jenc.float y
    ByteInUnionByte y -> encodeByte y

byte : Jdec.Decoder Byte
byte =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Byte)

encodeByte : Byte -> Jenc.Value
encodeByte x =
    Jenc.object
        [
        ]

unionCalendar : Jdec.Decoder UnionCalendar
unionCalendar =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCalendar Jdec.float
        , Jdec.map CalendarInUnionCalendar calendar
        ]

encodeUnionCalendar : UnionCalendar -> Jenc.Value
encodeUnionCalendar x = case x of
    DoubleInUnionCalendar y -> Jenc.float y
    CalendarInUnionCalendar y -> encodeCalendar y

calendar : Jdec.Decoder Calendar
calendar =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Calendar)

encodeCalendar : Calendar -> Jenc.Value
encodeCalendar x =
    Jenc.object
        [
        ]

unionCatch : Jdec.Decoder UnionCatch
unionCatch =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCatch Jdec.float
        , Jdec.map CatchInUnionCatch catch
        ]

encodeUnionCatch : UnionCatch -> Jenc.Value
encodeUnionCatch x = case x of
    DoubleInUnionCatch y -> Jenc.float y
    CatchInUnionCatch y -> encodeCatch y

catch : Jdec.Decoder Catch
catch =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Catch)

encodeCatch : Catch -> Jenc.Value
encodeCatch x =
    Jenc.object
        [
        ]

unionChan : Jdec.Decoder UnionChan
unionChan =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionChan Jdec.float
        , Jdec.map ChanInUnionChan chan
        ]

encodeUnionChan : UnionChan -> Jenc.Value
encodeUnionChan x = case x of
    DoubleInUnionChan y -> Jenc.float y
    ChanInUnionChan y -> encodeChan y

chan : Jdec.Decoder Chan
chan =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Chan)

encodeChan : Chan -> Jenc.Value
encodeChan x =
    Jenc.object
        [
        ]

unionChar : Jdec.Decoder UnionChar
unionChar =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionChar Jdec.float
        , Jdec.map CharInUnionChar char
        ]

encodeUnionChar : UnionChar -> Jenc.Value
encodeUnionChar x = case x of
    DoubleInUnionChar y -> Jenc.float y
    CharInUnionChar y -> encodeChar y

char : Jdec.Decoder Char
char =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Char)

encodeChar : Char -> Jenc.Value
encodeChar x =
    Jenc.object
        [
        ]

unionChar16T : Jdec.Decoder UnionChar16T
unionChar16T =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionChar16T Jdec.float
        , Jdec.map Char16TInUnionChar16T char16T
        ]

encodeUnionChar16T : UnionChar16T -> Jenc.Value
encodeUnionChar16T x = case x of
    DoubleInUnionChar16T y -> Jenc.float y
    Char16TInUnionChar16T y -> encodeChar16T y

char16T : Jdec.Decoder Char16T
char16T =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Char16T)

encodeChar16T : Char16T -> Jenc.Value
encodeChar16T x =
    Jenc.object
        [
        ]

unionChar32T : Jdec.Decoder UnionChar32T
unionChar32T =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionChar32T Jdec.float
        , Jdec.map Char32TInUnionChar32T char32T
        ]

encodeUnionChar32T : UnionChar32T -> Jenc.Value
encodeUnionChar32T x = case x of
    DoubleInUnionChar32T y -> Jenc.float y
    Char32TInUnionChar32T y -> encodeChar32T y

char32T : Jdec.Decoder Char32T
char32T =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Char32T)

encodeChar32T : Char32T -> Jenc.Value
encodeChar32T x =
    Jenc.object
        [
        ]

unionChecked : Jdec.Decoder UnionChecked
unionChecked =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionChecked Jdec.float
        , Jdec.map CheckedInUnionChecked checked
        ]

encodeUnionChecked : UnionChecked -> Jenc.Value
encodeUnionChecked x = case x of
    DoubleInUnionChecked y -> Jenc.float y
    CheckedInUnionChecked y -> encodeChecked y

checked : Jdec.Decoder Checked
checked =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Checked)

encodeChecked : Checked -> Jenc.Value
encodeChecked x =
    Jenc.object
        [
        ]

unionClass : Jdec.Decoder UnionClass
unionClass =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionClass Jdec.float
        , Jdec.map ClassInUnionClass class
        ]

encodeUnionClass : UnionClass -> Jenc.Value
encodeUnionClass x = case x of
    DoubleInUnionClass y -> Jenc.float y
    ClassInUnionClass y -> encodeClass y

class : Jdec.Decoder Class
class =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Class)

encodeClass : Class -> Jenc.Value
encodeClass x =
    Jenc.object
        [
        ]

unionClone : Jdec.Decoder UnionClone
unionClone =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionClone Jdec.float
        , Jdec.map CloneInUnionClone clone
        ]

encodeUnionClone : UnionClone -> Jenc.Value
encodeUnionClone x = case x of
    DoubleInUnionClone y -> Jenc.float y
    CloneInUnionClone y -> encodeClone y

clone : Jdec.Decoder Clone
clone =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Clone)

encodeClone : Clone -> Jenc.Value
encodeClone x =
    Jenc.object
        [
        ]

unionCoAwait : Jdec.Decoder UnionCoAwait
unionCoAwait =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCoAwait Jdec.float
        , Jdec.map CoAwaitInUnionCoAwait coAwait
        ]

encodeUnionCoAwait : UnionCoAwait -> Jenc.Value
encodeUnionCoAwait x = case x of
    DoubleInUnionCoAwait y -> Jenc.float y
    CoAwaitInUnionCoAwait y -> encodeCoAwait y

coAwait : Jdec.Decoder CoAwait
coAwait =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CoAwait)

encodeCoAwait : CoAwait -> Jenc.Value
encodeCoAwait x =
    Jenc.object
        [
        ]

unionCoReturn : Jdec.Decoder UnionCoReturn
unionCoReturn =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCoReturn Jdec.float
        , Jdec.map CoReturnInUnionCoReturn coReturn
        ]

encodeUnionCoReturn : UnionCoReturn -> Jenc.Value
encodeUnionCoReturn x = case x of
    DoubleInUnionCoReturn y -> Jenc.float y
    CoReturnInUnionCoReturn y -> encodeCoReturn y

coReturn : Jdec.Decoder CoReturn
coReturn =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CoReturn)

encodeCoReturn : CoReturn -> Jenc.Value
encodeCoReturn x =
    Jenc.object
        [
        ]

unionCoYield : Jdec.Decoder UnionCoYield
unionCoYield =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCoYield Jdec.float
        , Jdec.map CoYieldInUnionCoYield coYield
        ]

encodeUnionCoYield : UnionCoYield -> Jenc.Value
encodeUnionCoYield x = case x of
    DoubleInUnionCoYield y -> Jenc.float y
    CoYieldInUnionCoYield y -> encodeCoYield y

coYield : Jdec.Decoder CoYield
coYield =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CoYield)

encodeCoYield : CoYield -> Jenc.Value
encodeCoYield x =
    Jenc.object
        [
        ]

unionCodable : Jdec.Decoder UnionCodable
unionCodable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCodable Jdec.float
        , Jdec.map CodableInUnionCodable codable
        ]

encodeUnionCodable : UnionCodable -> Jenc.Value
encodeUnionCodable x = case x of
    DoubleInUnionCodable y -> Jenc.float y
    CodableInUnionCodable y -> encodeCodable y

codable : Jdec.Decoder Codable
codable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Codable)

encodeCodable : Codable -> Jenc.Value
encodeCodable x =
    Jenc.object
        [
        ]

unionCodingKey : Jdec.Decoder UnionCodingKey
unionCodingKey =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCodingKey Jdec.float
        , Jdec.map CodingKeyInUnionCodingKey codingKey
        ]

encodeUnionCodingKey : UnionCodingKey -> Jenc.Value
encodeUnionCodingKey x = case x of
    DoubleInUnionCodingKey y -> Jenc.float y
    CodingKeyInUnionCodingKey y -> encodeCodingKey y

codingKey : Jdec.Decoder CodingKey
codingKey =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CodingKey)

encodeCodingKey : CodingKey -> Jenc.Value
encodeCodingKey x =
    Jenc.object
        [
        ]

unionCodingKeys : Jdec.Decoder UnionCodingKeys
unionCodingKeys =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCodingKeys Jdec.float
        , Jdec.map CodingKeysInUnionCodingKeys codingKeys
        ]

encodeUnionCodingKeys : UnionCodingKeys -> Jenc.Value
encodeUnionCodingKeys x = case x of
    DoubleInUnionCodingKeys y -> Jenc.float y
    CodingKeysInUnionCodingKeys y -> encodeCodingKeys y

codingKeys : Jdec.Decoder CodingKeys
codingKeys =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CodingKeys)

encodeCodingKeys : CodingKeys -> Jenc.Value
encodeCodingKeys x =
    Jenc.object
        [
        ]

unionCompl : Jdec.Decoder UnionCompl
unionCompl =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCompl Jdec.float
        , Jdec.map ComplInUnionCompl compl
        ]

encodeUnionCompl : UnionCompl -> Jenc.Value
encodeUnionCompl x = case x of
    DoubleInUnionCompl y -> Jenc.float y
    ComplInUnionCompl y -> encodeCompl y

compl : Jdec.Decoder Compl
compl =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Compl)

encodeCompl : Compl -> Jenc.Value
encodeCompl x =
    Jenc.object
        [
        ]

unionComplex : Jdec.Decoder UnionComplex
unionComplex =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionComplex Jdec.float
        , Jdec.map ComplexInUnionComplex complex
        ]

encodeUnionComplex : UnionComplex -> Jenc.Value
encodeUnionComplex x = case x of
    DoubleInUnionComplex y -> Jenc.float y
    ComplexInUnionComplex y -> encodeComplex y

complex : Jdec.Decoder Complex
complex =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Complex)

encodeComplex : Complex -> Jenc.Value
encodeComplex x =
    Jenc.object
        [
        ]

unionConcept : Jdec.Decoder UnionConcept
unionConcept =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConcept Jdec.float
        , Jdec.map ConceptInUnionConcept concept
        ]

encodeUnionConcept : UnionConcept -> Jenc.Value
encodeUnionConcept x = case x of
    DoubleInUnionConcept y -> Jenc.float y
    ConceptInUnionConcept y -> encodeConcept y

concept : Jdec.Decoder Concept
concept =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Concept)

encodeConcept : Concept -> Jenc.Value
encodeConcept x =
    Jenc.object
        [
        ]

unionConsole : Jdec.Decoder UnionConsole
unionConsole =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConsole Jdec.float
        , Jdec.map ConsoleInUnionConsole console
        ]

encodeUnionConsole : UnionConsole -> Jenc.Value
encodeUnionConsole x = case x of
    DoubleInUnionConsole y -> Jenc.float y
    ConsoleInUnionConsole y -> encodeConsole y

console : Jdec.Decoder Console
console =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Console)

encodeConsole : Console -> Jenc.Value
encodeConsole x =
    Jenc.object
        [
        ]

unionConst : Jdec.Decoder UnionConst
unionConst =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConst Jdec.float
        , Jdec.map ConstInUnionConst const
        ]

encodeUnionConst : UnionConst -> Jenc.Value
encodeUnionConst x = case x of
    DoubleInUnionConst y -> Jenc.float y
    ConstInUnionConst y -> encodeConst y

const : Jdec.Decoder Const
const =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Const)

encodeConst : Const -> Jenc.Value
encodeConst x =
    Jenc.object
        [
        ]

unionConstCast : Jdec.Decoder UnionConstCast
unionConstCast =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConstCast Jdec.float
        , Jdec.map ConstCastInUnionConstCast constCast
        ]

encodeUnionConstCast : UnionConstCast -> Jenc.Value
encodeUnionConstCast x = case x of
    DoubleInUnionConstCast y -> Jenc.float y
    ConstCastInUnionConstCast y -> encodeConstCast y

constCast : Jdec.Decoder ConstCast
constCast =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ConstCast)

encodeConstCast : ConstCast -> Jenc.Value
encodeConstCast x =
    Jenc.object
        [
        ]

unionConstexpr : Jdec.Decoder UnionConstexpr
unionConstexpr =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConstexpr Jdec.float
        , Jdec.map ConstexprInUnionConstexpr constexpr
        ]

encodeUnionConstexpr : UnionConstexpr -> Jenc.Value
encodeUnionConstexpr x = case x of
    DoubleInUnionConstexpr y -> Jenc.float y
    ConstexprInUnionConstexpr y -> encodeConstexpr y

constexpr : Jdec.Decoder Constexpr
constexpr =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Constexpr)

encodeConstexpr : Constexpr -> Jenc.Value
encodeConstexpr x =
    Jenc.object
        [
        ]

unionConstructor : Jdec.Decoder UnionConstructor
unionConstructor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConstructor Jdec.float
        , Jdec.map ConstructorInUnionConstructor constructor
        ]

encodeUnionConstructor : UnionConstructor -> Jenc.Value
encodeUnionConstructor x = case x of
    DoubleInUnionConstructor y -> Jenc.float y
    ConstructorInUnionConstructor y -> encodeConstructor y

constructor : Jdec.Decoder Constructor
constructor =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Constructor)

encodeConstructor : Constructor -> Jenc.Value
encodeConstructor x =
    Jenc.object
        [
        ]

unionContinue : Jdec.Decoder UnionContinue
unionContinue =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionContinue Jdec.float
        , Jdec.map ContinueInUnionContinue continue
        ]

encodeUnionContinue : UnionContinue -> Jenc.Value
encodeUnionContinue x = case x of
    DoubleInUnionContinue y -> Jenc.float y
    ContinueInUnionContinue y -> encodeContinue y

continue : Jdec.Decoder Continue
continue =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Continue)

encodeContinue : Continue -> Jenc.Value
encodeContinue x =
    Jenc.object
        [
        ]

unionConvenience : Jdec.Decoder UnionConvenience
unionConvenience =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConvenience Jdec.float
        , Jdec.map ConvenienceInUnionConvenience convenience
        ]

encodeUnionConvenience : UnionConvenience -> Jenc.Value
encodeUnionConvenience x = case x of
    DoubleInUnionConvenience y -> Jenc.float y
    ConvenienceInUnionConvenience y -> encodeConvenience y

convenience : Jdec.Decoder Convenience
convenience =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Convenience)

encodeConvenience : Convenience -> Jenc.Value
encodeConvenience x =
    Jenc.object
        [
        ]

unionConvert : Jdec.Decoder UnionConvert
unionConvert =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConvert Jdec.float
        , Jdec.map ConvertInUnionConvert convert
        ]

encodeUnionConvert : UnionConvert -> Jenc.Value
encodeUnionConvert x = case x of
    DoubleInUnionConvert y -> Jenc.float y
    ConvertInUnionConvert y -> encodeConvert y

convert : Jdec.Decoder Convert
convert =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Convert)

encodeConvert : Convert -> Jenc.Value
encodeConvert x =
    Jenc.object
        [
        ]

unionConverter : Jdec.Decoder UnionConverter
unionConverter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConverter Jdec.float
        , Jdec.map ConverterInUnionConverter converter
        ]

encodeUnionConverter : UnionConverter -> Jenc.Value
encodeUnionConverter x = case x of
    DoubleInUnionConverter y -> Jenc.float y
    ConverterInUnionConverter y -> encodeConverter y

converter : Jdec.Decoder Converter
converter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Converter)

encodeConverter : Converter -> Jenc.Value
encodeConverter x =
    Jenc.object
        [
        ]

unionCultureInfo : Jdec.Decoder UnionCultureInfo
unionCultureInfo =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCultureInfo Jdec.float
        , Jdec.map CultureInfoInUnionCultureInfo cultureInfo
        ]

encodeUnionCultureInfo : UnionCultureInfo -> Jenc.Value
encodeUnionCultureInfo x = case x of
    DoubleInUnionCultureInfo y -> Jenc.float y
    CultureInfoInUnionCultureInfo y -> encodeCultureInfo y

cultureInfo : Jdec.Decoder CultureInfo
cultureInfo =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> CultureInfo)

encodeCultureInfo : CultureInfo -> Jenc.Value
encodeCultureInfo x =
    Jenc.object
        [
        ]

unionDate : Jdec.Decoder UnionDate
unionDate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDate Jdec.float
        , Jdec.map DateInUnionDate date
        ]

encodeUnionDate : UnionDate -> Jenc.Value
encodeUnionDate x = case x of
    DoubleInUnionDate y -> Jenc.float y
    DateInUnionDate y -> encodeDate y

date : Jdec.Decoder Date
date =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Date)

encodeDate : Date -> Jenc.Value
encodeDate x =
    Jenc.object
        [
        ]

unionDateFormatter : Jdec.Decoder UnionDateFormatter
unionDateFormatter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateFormatter Jdec.float
        , Jdec.map DateFormatterInUnionDateFormatter dateFormatter
        ]

encodeUnionDateFormatter : UnionDateFormatter -> Jenc.Value
encodeUnionDateFormatter x = case x of
    DoubleInUnionDateFormatter y -> Jenc.float y
    DateFormatterInUnionDateFormatter y -> encodeDateFormatter y

dateFormatter : Jdec.Decoder DateFormatter
dateFormatter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateFormatter)

encodeDateFormatter : DateFormatter -> Jenc.Value
encodeDateFormatter x =
    Jenc.object
        [
        ]

unionDateOnly : Jdec.Decoder UnionDateOnly
unionDateOnly =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateOnly Jdec.float
        , Jdec.map DateOnlyInUnionDateOnly dateOnly
        ]

encodeUnionDateOnly : UnionDateOnly -> Jenc.Value
encodeUnionDateOnly x = case x of
    DoubleInUnionDateOnly y -> Jenc.float y
    DateOnlyInUnionDateOnly y -> encodeDateOnly y

dateOnly : Jdec.Decoder DateOnly
dateOnly =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateOnly)

encodeDateOnly : DateOnly -> Jenc.Value
encodeDateOnly x =
    Jenc.object
        [
        ]

unionDateOnlyConverter : Jdec.Decoder UnionDateOnlyConverter
unionDateOnlyConverter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateOnlyConverter Jdec.float
        , Jdec.map DateOnlyConverterInUnionDateOnlyConverter dateOnlyConverter
        ]

encodeUnionDateOnlyConverter : UnionDateOnlyConverter -> Jenc.Value
encodeUnionDateOnlyConverter x = case x of
    DoubleInUnionDateOnlyConverter y -> Jenc.float y
    DateOnlyConverterInUnionDateOnlyConverter y -> encodeDateOnlyConverter y

dateOnlyConverter : Jdec.Decoder DateOnlyConverter
dateOnlyConverter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateOnlyConverter)

encodeDateOnlyConverter : DateOnlyConverter -> Jenc.Value
encodeDateOnlyConverter x =
    Jenc.object
        [
        ]

unionDateParseHandling : Jdec.Decoder UnionDateParseHandling
unionDateParseHandling =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateParseHandling Jdec.float
        , Jdec.map DateParseHandlingInUnionDateParseHandling dateParseHandling
        ]

encodeUnionDateParseHandling : UnionDateParseHandling -> Jenc.Value
encodeUnionDateParseHandling x = case x of
    DoubleInUnionDateParseHandling y -> Jenc.float y
    DateParseHandlingInUnionDateParseHandling y -> encodeDateParseHandling y

dateParseHandling : Jdec.Decoder DateParseHandling
dateParseHandling =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateParseHandling)

encodeDateParseHandling : DateParseHandling -> Jenc.Value
encodeDateParseHandling x =
    Jenc.object
        [
        ]

unionDateTime : Jdec.Decoder UnionDateTime
unionDateTime =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateTime Jdec.float
        , Jdec.map DateTimeInUnionDateTime dateTime
        ]

encodeUnionDateTime : UnionDateTime -> Jenc.Value
encodeUnionDateTime x = case x of
    DoubleInUnionDateTime y -> Jenc.float y
    DateTimeInUnionDateTime y -> encodeDateTime y

dateTime : Jdec.Decoder DateTime
dateTime =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateTime)

encodeDateTime : DateTime -> Jenc.Value
encodeDateTime x =
    Jenc.object
        [
        ]

unionDateTimeStyles : Jdec.Decoder UnionDateTimeStyles
unionDateTimeStyles =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDateTimeStyles Jdec.float
        , Jdec.map DateTimeStylesInUnionDateTimeStyles dateTimeStyles
        ]

encodeUnionDateTimeStyles : UnionDateTimeStyles -> Jenc.Value
encodeUnionDateTimeStyles x = case x of
    DoubleInUnionDateTimeStyles y -> Jenc.float y
    DateTimeStylesInUnionDateTimeStyles y -> encodeDateTimeStyles y

dateTimeStyles : Jdec.Decoder DateTimeStyles
dateTimeStyles =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DateTimeStyles)

encodeDateTimeStyles : DateTimeStyles -> Jenc.Value
encodeDateTimeStyles x =
    Jenc.object
        [
        ]

unionDebugger : Jdec.Decoder UnionDebugger
unionDebugger =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDebugger Jdec.float
        , Jdec.map DebuggerInUnionDebugger debugger
        ]

encodeUnionDebugger : UnionDebugger -> Jenc.Value
encodeUnionDebugger x = case x of
    DoubleInUnionDebugger y -> Jenc.float y
    DebuggerInUnionDebugger y -> encodeDebugger y

debugger : Jdec.Decoder Debugger
debugger =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Debugger)

encodeDebugger : Debugger -> Jenc.Value
encodeDebugger x =
    Jenc.object
        [
        ]

unionDecimal : Jdec.Decoder UnionDecimal
unionDecimal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDecimal Jdec.float
        , Jdec.map DecimalInUnionDecimal decimal
        ]

encodeUnionDecimal : UnionDecimal -> Jenc.Value
encodeUnionDecimal x = case x of
    DoubleInUnionDecimal y -> Jenc.float y
    DecimalInUnionDecimal y -> encodeDecimal y

decimal : Jdec.Decoder Decimal
decimal =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Decimal)

encodeDecimal : Decimal -> Jenc.Value
encodeDecimal x =
    Jenc.object
        [
        ]

unionDeclare : Jdec.Decoder UnionDeclare
unionDeclare =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDeclare Jdec.float
        , Jdec.map DeclareInUnionDeclare declare
        ]

encodeUnionDeclare : UnionDeclare -> Jenc.Value
encodeUnionDeclare x = case x of
    DoubleInUnionDeclare y -> Jenc.float y
    DeclareInUnionDeclare y -> encodeDeclare y

declare : Jdec.Decoder Declare
declare =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Declare)

encodeDeclare : Declare -> Jenc.Value
encodeDeclare x =
    Jenc.object
        [
        ]

unionDecltype : Jdec.Decoder UnionDecltype
unionDecltype =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDecltype Jdec.float
        , Jdec.map DecltypeInUnionDecltype decltype
        ]

encodeUnionDecltype : UnionDecltype -> Jenc.Value
encodeUnionDecltype x = case x of
    DoubleInUnionDecltype y -> Jenc.float y
    DecltypeInUnionDecltype y -> encodeDecltype y

decltype : Jdec.Decoder Decltype
decltype =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Decltype)

encodeDecltype : Decltype -> Jenc.Value
encodeDecltype x =
    Jenc.object
        [
        ]

unionDecodeString : Jdec.Decoder UnionDecodeString
unionDecodeString =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDecodeString Jdec.float
        , Jdec.map DecodeStringInUnionDecodeString decodeString
        ]

encodeUnionDecodeString : UnionDecodeString -> Jenc.Value
encodeUnionDecodeString x = case x of
    DoubleInUnionDecodeString y -> Jenc.float y
    DecodeStringInUnionDecodeString y -> encodeDecodeString y

decodeString : Jdec.Decoder DecodeString
decodeString =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DecodeString)

encodeDecodeString : DecodeString -> Jenc.Value
encodeDecodeString x =
    Jenc.object
        [
        ]

unionDecodingError : Jdec.Decoder UnionDecodingError
unionDecodingError =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDecodingError Jdec.float
        , Jdec.map DecodingErrorInUnionDecodingError decodingError
        ]

encodeUnionDecodingError : UnionDecodingError -> Jenc.Value
encodeUnionDecodingError x = case x of
    DoubleInUnionDecodingError y -> Jenc.float y
    DecodingErrorInUnionDecodingError y -> encodeDecodingError y

decodingError : Jdec.Decoder DecodingError
decodingError =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DecodingError)

encodeDecodingError : DecodingError -> Jenc.Value
encodeDecodingError x =
    Jenc.object
        [
        ]

unionDef : Jdec.Decoder UnionDef
unionDef =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDef Jdec.float
        , Jdec.map DefInUnionDef def
        ]

encodeUnionDef : UnionDef -> Jenc.Value
encodeUnionDef x = case x of
    DoubleInUnionDef y -> Jenc.float y
    DefInUnionDef y -> encodeDef y

def : Jdec.Decoder Def
def =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Def)

encodeDef : Def -> Jenc.Value
encodeDef x =
    Jenc.object
        [
        ]

unionDefault : Jdec.Decoder UnionDefault
unionDefault =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDefault Jdec.float
        , Jdec.map DefaultInUnionDefault default
        ]

encodeUnionDefault : UnionDefault -> Jenc.Value
encodeUnionDefault x = case x of
    DoubleInUnionDefault y -> Jenc.float y
    DefaultInUnionDefault y -> encodeDefault y

default : Jdec.Decoder Default
default =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Default)

encodeDefault : Default -> Jenc.Value
encodeDefault x =
    Jenc.object
        [
        ]

unionDefer : Jdec.Decoder UnionDefer
unionDefer =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDefer Jdec.float
        , Jdec.map DeferInUnionDefer defer
        ]

encodeUnionDefer : UnionDefer -> Jenc.Value
encodeUnionDefer x = case x of
    DoubleInUnionDefer y -> Jenc.float y
    DeferInUnionDefer y -> encodeDefer y

defer : Jdec.Decoder Defer
defer =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Defer)

encodeDefer : Defer -> Jenc.Value
encodeDefer x =
    Jenc.object
        [
        ]

unionDeinit : Jdec.Decoder UnionDeinit
unionDeinit =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDeinit Jdec.float
        , Jdec.map DeinitInUnionDeinit deinit
        ]

encodeUnionDeinit : UnionDeinit -> Jenc.Value
encodeUnionDeinit x = case x of
    DoubleInUnionDeinit y -> Jenc.float y
    DeinitInUnionDeinit y -> encodeDeinit y

deinit : Jdec.Decoder Deinit
deinit =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Deinit)

encodeDeinit : Deinit -> Jenc.Value
encodeDeinit x =
    Jenc.object
        [
        ]

unionDel : Jdec.Decoder UnionDel
unionDel =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDel Jdec.float
        , Jdec.map DelInUnionDel del
        ]

encodeUnionDel : UnionDel -> Jenc.Value
encodeUnionDel x = case x of
    DoubleInUnionDel y -> Jenc.float y
    DelInUnionDel y -> encodeDel y

del : Jdec.Decoder Del
del =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Del)

encodeDel : Del -> Jenc.Value
encodeDel x =
    Jenc.object
        [
        ]

unionDelegate : Jdec.Decoder UnionDelegate
unionDelegate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDelegate Jdec.float
        , Jdec.map DelegateInUnionDelegate delegate
        ]

encodeUnionDelegate : UnionDelegate -> Jenc.Value
encodeUnionDelegate x = case x of
    DoubleInUnionDelegate y -> Jenc.float y
    DelegateInUnionDelegate y -> encodeDelegate y

delegate : Jdec.Decoder Delegate
delegate =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Delegate)

encodeDelegate : Delegate -> Jenc.Value
encodeDelegate x =
    Jenc.object
        [
        ]

unionDelete : Jdec.Decoder UnionDelete
unionDelete =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDelete Jdec.float
        , Jdec.map DeleteInUnionDelete delete
        ]

encodeUnionDelete : UnionDelete -> Jenc.Value
encodeUnionDelete x = case x of
    DoubleInUnionDelete y -> Jenc.float y
    DeleteInUnionDelete y -> encodeDelete y

delete : Jdec.Decoder Delete
delete =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Delete)

encodeDelete : Delete -> Jenc.Value
encodeDelete x =
    Jenc.object
        [
        ]

unionDeserializationFeature : Jdec.Decoder UnionDeserializationFeature
unionDeserializationFeature =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDeserializationFeature Jdec.float
        , Jdec.map DeserializationFeatureInUnionDeserializationFeature deserializationFeature
        ]

encodeUnionDeserializationFeature : UnionDeserializationFeature -> Jenc.Value
encodeUnionDeserializationFeature x = case x of
    DoubleInUnionDeserializationFeature y -> Jenc.float y
    DeserializationFeatureInUnionDeserializationFeature y -> encodeDeserializationFeature y

deserializationFeature : Jdec.Decoder DeserializationFeature
deserializationFeature =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DeserializationFeature)

encodeDeserializationFeature : DeserializationFeature -> Jenc.Value
encodeDeserializationFeature x =
    Jenc.object
        [
        ]

unionDict : Jdec.Decoder UnionDict
unionDict =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDict Jdec.float
        , Jdec.map DictClassInUnionDict dictClass
        ]

encodeUnionDict : UnionDict -> Jenc.Value
encodeUnionDict x = case x of
    DoubleInUnionDict y -> Jenc.float y
    DictClassInUnionDict y -> encodeDictClass y

dictClass : Jdec.Decoder DictClass
dictClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DictClass)

encodeDictClass : DictClass -> Jenc.Value
encodeDictClass x =
    Jenc.object
        [
        ]

unionDictionary : Jdec.Decoder UnionDictionary
unionDictionary =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDictionary Jdec.float
        , Jdec.map DictionaryInUnionDictionary dictionary
        ]

encodeUnionDictionary : UnionDictionary -> Jenc.Value
encodeUnionDictionary x = case x of
    DoubleInUnionDictionary y -> Jenc.float y
    DictionaryInUnionDictionary y -> encodeDictionary y

dictionary : Jdec.Decoder Dictionary
dictionary =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Dictionary)

encodeDictionary : Dictionary -> Jenc.Value
encodeDictionary x =
    Jenc.object
        [
        ]

unionDidSet : Jdec.Decoder UnionDidSet
unionDidSet =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDidSet Jdec.float
        , Jdec.map DidSetInUnionDidSet didSet
        ]

encodeUnionDidSet : UnionDidSet -> Jenc.Value
encodeUnionDidSet x = case x of
    DoubleInUnionDidSet y -> Jenc.float y
    DidSetInUnionDidSet y -> encodeDidSet y

didSet : Jdec.Decoder DidSet
didSet =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DidSet)

encodeDidSet : DidSet -> Jenc.Value
encodeDidSet x =
    Jenc.object
        [
        ]

unionDo : Jdec.Decoder UnionDo
unionDo =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDo Jdec.float
        , Jdec.map DoInUnionDo do
        ]

encodeUnionDo : UnionDo -> Jenc.Value
encodeUnionDo x = case x of
    DoubleInUnionDo y -> Jenc.float y
    DoInUnionDo y -> encodeDo y

do : Jdec.Decoder Do
do =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Do)

encodeDo : Do -> Jenc.Value
encodeDo x =
    Jenc.object
        [
        ]

unionDouble : Jdec.Decoder UnionDouble
unionDouble =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDouble Jdec.float
        , Jdec.map PurpleDoubleInUnionDouble double
        ]

encodeUnionDouble : UnionDouble -> Jenc.Value
encodeUnionDouble x = case x of
    DoubleInUnionDouble y -> Jenc.float y
    PurpleDoubleInUnionDouble y -> encodeDouble y

double : Jdec.Decoder Double
double =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Double)

encodeDouble : Double -> Jenc.Value
encodeDouble x =
    Jenc.object
        [
        ]

unionDoubleNode : Jdec.Decoder UnionDoubleNode
unionDoubleNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDoubleNode Jdec.float
        , Jdec.map DoubleNodeInUnionDoubleNode doubleNode
        ]

encodeUnionDoubleNode : UnionDoubleNode -> Jenc.Value
encodeUnionDoubleNode x = case x of
    DoubleInUnionDoubleNode y -> Jenc.float y
    DoubleNodeInUnionDoubleNode y -> encodeDoubleNode y

doubleNode : Jdec.Decoder DoubleNode
doubleNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DoubleNode)

encodeDoubleNode : DoubleNode -> Jenc.Value
encodeDoubleNode x =
    Jenc.object
        [
        ]

unionDynamic : Jdec.Decoder UnionDynamic
unionDynamic =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDynamic Jdec.float
        , Jdec.map DynamicInUnionDynamic dynamic
        ]

encodeUnionDynamic : UnionDynamic -> Jenc.Value
encodeUnionDynamic x = case x of
    DoubleInUnionDynamic y -> Jenc.float y
    DynamicInUnionDynamic y -> encodeDynamic y

dynamic : Jdec.Decoder Dynamic
dynamic =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Dynamic)

encodeDynamic : Dynamic -> Jenc.Value
encodeDynamic x =
    Jenc.object
        [
        ]

unionDynamicCast : Jdec.Decoder UnionDynamicCast
unionDynamicCast =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDynamicCast Jdec.float
        , Jdec.map DynamicCastInUnionDynamicCast dynamicCast
        ]

encodeUnionDynamicCast : UnionDynamicCast -> Jenc.Value
encodeUnionDynamicCast x = case x of
    DoubleInUnionDynamicCast y -> Jenc.float y
    DynamicCastInUnionDynamicCast y -> encodeDynamicCast y

dynamicCast : Jdec.Decoder DynamicCast
dynamicCast =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DynamicCast)

encodeDynamicCast : DynamicCast -> Jenc.Value
encodeDynamicCast x =
    Jenc.object
        [
        ]

unionElif : Jdec.Decoder UnionElif
unionElif =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionElif Jdec.float
        , Jdec.map ElifInUnionElif elif
        ]

encodeUnionElif : UnionElif -> Jenc.Value
encodeUnionElif x = case x of
    DoubleInUnionElif y -> Jenc.float y
    ElifInUnionElif y -> encodeElif y

elif : Jdec.Decoder Elif
elif =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Elif)

encodeElif : Elif -> Jenc.Value
encodeElif x =
    Jenc.object
        [
        ]

unionUnion : Jdec.Decoder UnionUnion
unionUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnion Jdec.float
        , Jdec.map EmptyInUnionUnion empty
        ]

encodeUnionUnion : UnionUnion -> Jenc.Value
encodeUnionUnion x = case x of
    DoubleInUnionUnion y -> Jenc.float y
    EmptyInUnionUnion y -> encodeEmpty y

empty : Jdec.Decoder Empty
empty =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Empty)

encodeEmpty : Empty -> Jenc.Value
encodeEmpty x =
    Jenc.object
        [
        ]

unionEncodeQuickType : Jdec.Decoder UnionEncodeQuickType
unionEncodeQuickType =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEncodeQuickType Jdec.float
        , Jdec.map EncodeQuickTypeInUnionEncodeQuickType purpleEncodeQuickType
        ]

encodeUnionEncodeQuickType : UnionEncodeQuickType -> Jenc.Value
encodeUnionEncodeQuickType x = case x of
    DoubleInUnionEncodeQuickType y -> Jenc.float y
    EncodeQuickTypeInUnionEncodeQuickType y -> encodeEncodeQuickType y

purpleEncodeQuickType : Jdec.Decoder EncodeQuickType
purpleEncodeQuickType =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> EncodeQuickType)

encodeEncodeQuickType : EncodeQuickType -> Jenc.Value
encodeEncodeQuickType x =
    Jenc.object
        [
        ]

unionEncoder : Jdec.Decoder UnionEncoder
unionEncoder =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEncoder Jdec.float
        , Jdec.map EncoderInUnionEncoder encoder
        ]

encodeUnionEncoder : UnionEncoder -> Jenc.Value
encodeUnionEncoder x = case x of
    DoubleInUnionEncoder y -> Jenc.float y
    EncoderInUnionEncoder y -> encodeEncoder y

encoder : Jdec.Decoder Encoder
encoder =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Encoder)

encodeEncoder : Encoder -> Jenc.Value
encodeEncoder x =
    Jenc.object
        [
        ]

unionEnum : Jdec.Decoder UnionEnum
unionEnum =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEnum Jdec.float
        , Jdec.map EnumInUnionEnum enum
        ]

encodeUnionEnum : UnionEnum -> Jenc.Value
encodeUnionEnum x = case x of
    DoubleInUnionEnum y -> Jenc.float y
    EnumInUnionEnum y -> encodeEnum y

enum : Jdec.Decoder Enum
enum =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Enum)

encodeEnum : Enum -> Jenc.Value
encodeEnum x =
    Jenc.object
        [
        ]

unionEnumValues : Jdec.Decoder UnionEnumValues
unionEnumValues =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEnumValues Jdec.float
        , Jdec.map EnumValuesInUnionEnumValues enumValues
        ]

encodeUnionEnumValues : UnionEnumValues -> Jenc.Value
encodeUnionEnumValues x = case x of
    DoubleInUnionEnumValues y -> Jenc.float y
    EnumValuesInUnionEnumValues y -> encodeEnumValues y

enumValues : Jdec.Decoder EnumValues
enumValues =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> EnumValues)

encodeEnumValues : EnumValues -> Jenc.Value
encodeEnumValues x =
    Jenc.object
        [
        ]

unionEqualityContract : Jdec.Decoder UnionEqualityContract
unionEqualityContract =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEqualityContract Jdec.float
        , Jdec.map EqualityContractInUnionEqualityContract equalityContract
        ]

encodeUnionEqualityContract : UnionEqualityContract -> Jenc.Value
encodeUnionEqualityContract x = case x of
    DoubleInUnionEqualityContract y -> Jenc.float y
    EqualityContractInUnionEqualityContract y -> encodeEqualityContract y

equalityContract : Jdec.Decoder EqualityContract
equalityContract =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> EqualityContract)

encodeEqualityContract : EqualityContract -> Jenc.Value
encodeEqualityContract x =
    Jenc.object
        [
        ]

unionEquatable : Jdec.Decoder UnionEquatable
unionEquatable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEquatable Jdec.float
        , Jdec.map EquatableInUnionEquatable equatable
        ]

encodeUnionEquatable : UnionEquatable -> Jenc.Value
encodeUnionEquatable x = case x of
    DoubleInUnionEquatable y -> Jenc.float y
    EquatableInUnionEquatable y -> encodeEquatable y

equatable : Jdec.Decoder Equatable
equatable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Equatable)

encodeEquatable : Equatable -> Jenc.Value
encodeEquatable x =
    Jenc.object
        [
        ]

unionEvent : Jdec.Decoder UnionEvent
unionEvent =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionEvent Jdec.float
        , Jdec.map EventInUnionEvent event
        ]

encodeUnionEvent : UnionEvent -> Jenc.Value
encodeUnionEvent x = case x of
    DoubleInUnionEvent y -> Jenc.float y
    EventInUnionEvent y -> encodeEvent y

event : Jdec.Decoder Event
event =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Event)

encodeEvent : Event -> Jenc.Value
encodeEvent x =
    Jenc.object
        [
        ]

unionExcept : Jdec.Decoder UnionExcept
unionExcept =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExcept Jdec.float
        , Jdec.map ExceptInUnionExcept except
        ]

encodeUnionExcept : UnionExcept -> Jenc.Value
encodeUnionExcept x = case x of
    DoubleInUnionExcept y -> Jenc.float y
    ExceptInUnionExcept y -> encodeExcept y

except : Jdec.Decoder Except
except =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Except)

encodeExcept : Except -> Jenc.Value
encodeExcept x =
    Jenc.object
        [
        ]

unionException : Jdec.Decoder UnionException
unionException =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionException Jdec.float
        , Jdec.map ExceptionInUnionException exception
        ]

encodeUnionException : UnionException -> Jenc.Value
encodeUnionException x = case x of
    DoubleInUnionException y -> Jenc.float y
    ExceptionInUnionException y -> encodeException y

exception : Jdec.Decoder Exception
exception =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Exception)

encodeException : Exception -> Jenc.Value
encodeException x =
    Jenc.object
        [
        ]

unionExplicit : Jdec.Decoder UnionExplicit
unionExplicit =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExplicit Jdec.float
        , Jdec.map ExplicitInUnionExplicit explicit
        ]

encodeUnionExplicit : UnionExplicit -> Jenc.Value
encodeUnionExplicit x = case x of
    DoubleInUnionExplicit y -> Jenc.float y
    ExplicitInUnionExplicit y -> encodeExplicit y

explicit : Jdec.Decoder Explicit
explicit =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Explicit)

encodeExplicit : Explicit -> Jenc.Value
encodeExplicit x =
    Jenc.object
        [
        ]

unionExport : Jdec.Decoder UnionExport
unionExport =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExport Jdec.float
        , Jdec.map ExportInUnionExport export
        ]

encodeUnionExport : UnionExport -> Jenc.Value
encodeUnionExport x = case x of
    DoubleInUnionExport y -> Jenc.float y
    ExportInUnionExport y -> encodeExport y

export : Jdec.Decoder Export
export =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Export)

encodeExport : Export -> Jenc.Value
encodeExport x =
    Jenc.object
        [
        ]

unionExtends : Jdec.Decoder UnionExtends
unionExtends =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExtends Jdec.float
        , Jdec.map ExtendsInUnionExtends extends
        ]

encodeUnionExtends : UnionExtends -> Jenc.Value
encodeUnionExtends x = case x of
    DoubleInUnionExtends y -> Jenc.float y
    ExtendsInUnionExtends y -> encodeExtends y

extends : Jdec.Decoder Extends
extends =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Extends)

encodeExtends : Extends -> Jenc.Value
encodeExtends x =
    Jenc.object
        [
        ]

unionExtension : Jdec.Decoder UnionExtension
unionExtension =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExtension Jdec.float
        , Jdec.map ExtensionInUnionExtension extension
        ]

encodeUnionExtension : UnionExtension -> Jenc.Value
encodeUnionExtension x = case x of
    DoubleInUnionExtension y -> Jenc.float y
    ExtensionInUnionExtension y -> encodeExtension y

extension : Jdec.Decoder Extension
extension =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Extension)

encodeExtension : Extension -> Jenc.Value
encodeExtension x =
    Jenc.object
        [
        ]

unionExtern : Jdec.Decoder UnionExtern
unionExtern =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExtern Jdec.float
        , Jdec.map ExternInUnionExtern extern
        ]

encodeUnionExtern : UnionExtern -> Jenc.Value
encodeUnionExtern x = case x of
    DoubleInUnionExtern y -> Jenc.float y
    ExternInUnionExtern y -> encodeExtern y

extern : Jdec.Decoder Extern
extern =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Extern)

encodeExtern : Extern -> Jenc.Value
encodeExtern x =
    Jenc.object
        [
        ]

unionFallthrough : Jdec.Decoder UnionFallthrough
unionFallthrough =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFallthrough Jdec.float
        , Jdec.map FallthroughInUnionFallthrough fallthrough
        ]

encodeUnionFallthrough : UnionFallthrough -> Jenc.Value
encodeUnionFallthrough x = case x of
    DoubleInUnionFallthrough y -> Jenc.float y
    FallthroughInUnionFallthrough y -> encodeFallthrough y

fallthrough : Jdec.Decoder Fallthrough
fallthrough =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Fallthrough)

encodeFallthrough : Fallthrough -> Jenc.Value
encodeFallthrough x =
    Jenc.object
        [
        ]

unionFalse : Jdec.Decoder UnionFalse
unionFalse =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFalse Jdec.float
        , Jdec.map FalseClassInUnionFalse falseClass
        ]

encodeUnionFalse : UnionFalse -> Jenc.Value
encodeUnionFalse x = case x of
    DoubleInUnionFalse y -> Jenc.float y
    FalseClassInUnionFalse y -> encodeFalseClass y

falseClass : Jdec.Decoder FalseClass
falseClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FalseClass)

encodeFalseClass : FalseClass -> Jenc.Value
encodeFalseClass x =
    Jenc.object
        [
        ]

unionFileprivate : Jdec.Decoder UnionFileprivate
unionFileprivate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFileprivate Jdec.float
        , Jdec.map FileprivateInUnionFileprivate fileprivate
        ]

encodeUnionFileprivate : UnionFileprivate -> Jenc.Value
encodeUnionFileprivate x = case x of
    DoubleInUnionFileprivate y -> Jenc.float y
    FileprivateInUnionFileprivate y -> encodeFileprivate y

fileprivate : Jdec.Decoder Fileprivate
fileprivate =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Fileprivate)

encodeFileprivate : Fileprivate -> Jenc.Value
encodeFileprivate x =
    Jenc.object
        [
        ]

unionFinal : Jdec.Decoder UnionFinal
unionFinal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFinal Jdec.float
        , Jdec.map FinalInUnionFinal final
        ]

encodeUnionFinal : UnionFinal -> Jenc.Value
encodeUnionFinal x = case x of
    DoubleInUnionFinal y -> Jenc.float y
    FinalInUnionFinal y -> encodeFinal y

final : Jdec.Decoder Final
final =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Final)

encodeFinal : Final -> Jenc.Value
encodeFinal x =
    Jenc.object
        [
        ]

unionFinally : Jdec.Decoder UnionFinally
unionFinally =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFinally Jdec.float
        , Jdec.map FinallyInUnionFinally finally
        ]

encodeUnionFinally : UnionFinally -> Jenc.Value
encodeUnionFinally x = case x of
    DoubleInUnionFinally y -> Jenc.float y
    FinallyInUnionFinally y -> encodeFinally y

finally : Jdec.Decoder Finally
finally =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Finally)

encodeFinally : Finally -> Jenc.Value
encodeFinally x =
    Jenc.object
        [
        ]

unionFixed : Jdec.Decoder UnionFixed
unionFixed =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFixed Jdec.float
        , Jdec.map FixedInUnionFixed fixed
        ]

encodeUnionFixed : UnionFixed -> Jenc.Value
encodeUnionFixed x = case x of
    DoubleInUnionFixed y -> Jenc.float y
    FixedInUnionFixed y -> encodeFixed y

fixed : Jdec.Decoder Fixed
fixed =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Fixed)

encodeFixed : Fixed -> Jenc.Value
encodeFixed x =
    Jenc.object
        [
        ]

unionFor : Jdec.Decoder UnionFor
unionFor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFor Jdec.float
        , Jdec.map ForInUnionFor for
        ]

encodeUnionFor : UnionFor -> Jenc.Value
encodeUnionFor x = case x of
    DoubleInUnionFor y -> Jenc.float y
    ForInUnionFor y -> encodeFor y

for : Jdec.Decoder For
for =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> For)

encodeFor : For -> Jenc.Value
encodeFor x =
    Jenc.object
        [
        ]

unionForeach : Jdec.Decoder UnionForeach
unionForeach =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionForeach Jdec.float
        , Jdec.map ForeachInUnionForeach foreach
        ]

encodeUnionForeach : UnionForeach -> Jenc.Value
encodeUnionForeach x = case x of
    DoubleInUnionForeach y -> Jenc.float y
    ForeachInUnionForeach y -> encodeForeach y

foreach : Jdec.Decoder Foreach
foreach =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Foreach)

encodeForeach : Foreach -> Jenc.Value
encodeForeach x =
    Jenc.object
        [
        ]

unionFormatException : Jdec.Decoder UnionFormatException
unionFormatException =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFormatException Jdec.float
        , Jdec.map FormatExceptionInUnionFormatException formatException
        ]

encodeUnionFormatException : UnionFormatException -> Jenc.Value
encodeUnionFormatException x = case x of
    DoubleInUnionFormatException y -> Jenc.float y
    FormatExceptionInUnionFormatException y -> encodeFormatException y

formatException : Jdec.Decoder FormatException
formatException =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FormatException)

encodeFormatException : FormatException -> Jenc.Value
encodeFormatException x =
    Jenc.object
        [
        ]

unionFriend : Jdec.Decoder UnionFriend
unionFriend =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFriend Jdec.float
        , Jdec.map FriendInUnionFriend friend
        ]

encodeUnionFriend : UnionFriend -> Jenc.Value
encodeUnionFriend x = case x of
    DoubleInUnionFriend y -> Jenc.float y
    FriendInUnionFriend y -> encodeFriend y

friend : Jdec.Decoder Friend
friend =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Friend)

encodeFriend : Friend -> Jenc.Value
encodeFriend x =
    Jenc.object
        [
        ]

unionFrom : Jdec.Decoder UnionFrom
unionFrom =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFrom Jdec.float
        , Jdec.map FromInUnionFrom from
        ]

encodeUnionFrom : UnionFrom -> Jenc.Value
encodeUnionFrom x = case x of
    DoubleInUnionFrom y -> Jenc.float y
    FromInUnionFrom y -> encodeFrom y

from : Jdec.Decoder From
from =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> From)

encodeFrom : From -> Jenc.Value
encodeFrom x =
    Jenc.object
        [
        ]

unionFromDict : Jdec.Decoder UnionFromDict
unionFromDict =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFromDict Jdec.float
        , Jdec.map FromDictInUnionFromDict fromDict
        ]

encodeUnionFromDict : UnionFromDict -> Jenc.Value
encodeUnionFromDict x = case x of
    DoubleInUnionFromDict y -> Jenc.float y
    FromDictInUnionFromDict y -> encodeFromDict y

fromDict : Jdec.Decoder FromDict
fromDict =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FromDict)

encodeFromDict : FromDict -> Jenc.Value
encodeFromDict x =
    Jenc.object
        [
        ]

unionFromJSON : Jdec.Decoder UnionFromJSON
unionFromJSON =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFromJSON Jdec.float
        , Jdec.map FromJSONInUnionFromJSON fromJSON
        ]

encodeUnionFromJSON : UnionFromJSON -> Jenc.Value
encodeUnionFromJSON x = case x of
    DoubleInUnionFromJSON y -> Jenc.float y
    FromJSONInUnionFromJSON y -> encodeFromJSON y

fromJSON : Jdec.Decoder FromJSON
fromJSON =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FromJSON)

encodeFromJSON : FromJSON -> Jenc.Value
encodeFromJSON x =
    Jenc.object
        [
        ]

unionFunc : Jdec.Decoder UnionFunc
unionFunc =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFunc Jdec.float
        , Jdec.map FuncInUnionFunc func
        ]

encodeUnionFunc : UnionFunc -> Jenc.Value
encodeUnionFunc x = case x of
    DoubleInUnionFunc y -> Jenc.float y
    FuncInUnionFunc y -> encodeFunc y

func : Jdec.Decoder Func
func =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Func)

encodeFunc : Func -> Jenc.Value
encodeFunc x =
    Jenc.object
        [
        ]

unionFunction : Jdec.Decoder UnionFunction
unionFunction =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFunction Jdec.float
        , Jdec.map FunctionInUnionFunction function
        ]

encodeUnionFunction : UnionFunction -> Jenc.Value
encodeUnionFunction x = case x of
    DoubleInUnionFunction y -> Jenc.float y
    FunctionInUnionFunction y -> encodeFunction y

function : Jdec.Decoder Function
function =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Function)

encodeFunction : Function -> Jenc.Value
encodeFunction x =
    Jenc.object
        [
        ]

unionGet : Jdec.Decoder UnionGet
unionGet =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionGet Jdec.float
        , Jdec.map GetInUnionGet get
        ]

encodeUnionGet : UnionGet -> Jenc.Value
encodeUnionGet x = case x of
    DoubleInUnionGet y -> Jenc.float y
    GetInUnionGet y -> encodeGet y

get : Jdec.Decoder Get
get =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Get)

encodeGet : Get -> Jenc.Value
encodeGet x =
    Jenc.object
        [
        ]

unionGlobal : Jdec.Decoder UnionGlobal
unionGlobal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionGlobal Jdec.float
        , Jdec.map GlobalInUnionGlobal global
        ]

encodeUnionGlobal : UnionGlobal -> Jenc.Value
encodeUnionGlobal x = case x of
    DoubleInUnionGlobal y -> Jenc.float y
    GlobalInUnionGlobal y -> encodeGlobal y

global : Jdec.Decoder Global
global =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Global)

encodeGlobal : Global -> Jenc.Value
encodeGlobal x =
    Jenc.object
        [
        ]

unionGo : Jdec.Decoder UnionGo
unionGo =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionGo Jdec.float
        , Jdec.map GoInUnionGo go
        ]

encodeUnionGo : UnionGo -> Jenc.Value
encodeUnionGo x = case x of
    DoubleInUnionGo y -> Jenc.float y
    GoInUnionGo y -> encodeGo y

go : Jdec.Decoder Go
go =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Go)

encodeGo : Go -> Jenc.Value
encodeGo x =
    Jenc.object
        [
        ]

unionGoto : Jdec.Decoder UnionGoto
unionGoto =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionGoto Jdec.float
        , Jdec.map GotoInUnionGoto goto
        ]

encodeUnionGoto : UnionGoto -> Jenc.Value
encodeUnionGoto x = case x of
    DoubleInUnionGoto y -> Jenc.float y
    GotoInUnionGoto y -> encodeGoto y

goto : Jdec.Decoder Goto
goto =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Goto)

encodeGoto : Goto -> Jenc.Value
encodeGoto x =
    Jenc.object
        [
        ]

unionGuard : Jdec.Decoder UnionGuard
unionGuard =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionGuard Jdec.float
        , Jdec.map GuardInUnionGuard guard
        ]

encodeUnionGuard : UnionGuard -> Jenc.Value
encodeUnionGuard x = case x of
    DoubleInUnionGuard y -> Jenc.float y
    GuardInUnionGuard y -> encodeGuard y

guard : Jdec.Decoder Guard
guard =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Guard)

encodeGuard : Guard -> Jenc.Value
encodeGuard x =
    Jenc.object
        [
        ]

unionHasOwnProperty : Jdec.Decoder UnionHasOwnProperty
unionHasOwnProperty =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionHasOwnProperty Jdec.float
        , Jdec.map HasOwnPropertyInUnionHasOwnProperty hasOwnProperty
        ]

encodeUnionHasOwnProperty : UnionHasOwnProperty -> Jenc.Value
encodeUnionHasOwnProperty x = case x of
    DoubleInUnionHasOwnProperty y -> Jenc.float y
    HasOwnPropertyInUnionHasOwnProperty y -> encodeHasOwnProperty y

hasOwnProperty : Jdec.Decoder HasOwnProperty
hasOwnProperty =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> HasOwnProperty)

encodeHasOwnProperty : HasOwnProperty -> Jenc.Value
encodeHasOwnProperty x =
    Jenc.object
        [
        ]

unionHashCode : Jdec.Decoder UnionHashCode
unionHashCode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionHashCode Jdec.float
        , Jdec.map HashCodeInUnionHashCode hashCode
        ]

encodeUnionHashCode : UnionHashCode -> Jenc.Value
encodeUnionHashCode x = case x of
    DoubleInUnionHashCode y -> Jenc.float y
    HashCodeInUnionHashCode y -> encodeHashCode y

hashCode : Jdec.Decoder HashCode
hashCode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> HashCode)

encodeHashCode : HashCode -> Jenc.Value
encodeHashCode x =
    Jenc.object
        [
        ]

unionHashable : Jdec.Decoder UnionHashable
unionHashable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionHashable Jdec.float
        , Jdec.map HashableInUnionHashable hashable
        ]

encodeUnionHashable : UnionHashable -> Jenc.Value
encodeUnionHashable x = case x of
    DoubleInUnionHashable y -> Jenc.float y
    HashableInUnionHashable y -> encodeHashable y

hashable : Jdec.Decoder Hashable
hashable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Hashable)

encodeHashable : Hashable -> Jenc.Value
encodeHashable x =
    Jenc.object
        [
        ]

unionHasher : Jdec.Decoder UnionHasher
unionHasher =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionHasher Jdec.float
        , Jdec.map HasherInUnionHasher hasher
        ]

encodeUnionHasher : UnionHasher -> Jenc.Value
encodeUnionHasher x = case x of
    DoubleInUnionHasher y -> Jenc.float y
    HasherInUnionHasher y -> encodeHasher y

hasher : Jdec.Decoder Hasher
hasher =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Hasher)

encodeHasher : Hasher -> Jenc.Value
encodeHasher x =
    Jenc.object
        [
        ]

unionID : Jdec.Decoder UnionID
unionID =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionID Jdec.float
        , Jdec.map IDInUnionID id
        ]

encodeUnionID : UnionID -> Jenc.Value
encodeUnionID x = case x of
    DoubleInUnionID y -> Jenc.float y
    IDInUnionID y -> encodeID y

id : Jdec.Decoder ID
id =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ID)

encodeID : ID -> Jenc.Value
encodeID x =
    Jenc.object
        [
        ]

unionImaginery : Jdec.Decoder UnionImaginery
unionImaginery =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionImaginery Jdec.float
        , Jdec.map ImagineryInUnionImaginery imaginery
        ]

encodeUnionImaginery : UnionImaginery -> Jenc.Value
encodeUnionImaginery x = case x of
    DoubleInUnionImaginery y -> Jenc.float y
    ImagineryInUnionImaginery y -> encodeImaginery y

imaginery : Jdec.Decoder Imaginery
imaginery =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Imaginery)

encodeImaginery : Imaginery -> Jenc.Value
encodeImaginery x =
    Jenc.object
        [
        ]

unionIMP : Jdec.Decoder UnionIMP
unionIMP =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIMP Jdec.float
        , Jdec.map ImpInUnionIMP imp
        ]

encodeUnionIMP : UnionIMP -> Jenc.Value
encodeUnionIMP x = case x of
    DoubleInUnionIMP y -> Jenc.float y
    ImpInUnionIMP y -> encodeImp y

imp : Jdec.Decoder Imp
imp =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Imp)

encodeImp : Imp -> Jenc.Value
encodeImp x =
    Jenc.object
        [
        ]

unionImplements : Jdec.Decoder UnionImplements
unionImplements =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionImplements Jdec.float
        , Jdec.map ImplementsInUnionImplements implements
        ]

encodeUnionImplements : UnionImplements -> Jenc.Value
encodeUnionImplements x = case x of
    DoubleInUnionImplements y -> Jenc.float y
    ImplementsInUnionImplements y -> encodeImplements y

implements : Jdec.Decoder Implements
implements =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Implements)

encodeImplements : Implements -> Jenc.Value
encodeImplements x =
    Jenc.object
        [
        ]

unionImplicit : Jdec.Decoder UnionImplicit
unionImplicit =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionImplicit Jdec.float
        , Jdec.map ImplicitInUnionImplicit implicit
        ]

encodeUnionImplicit : UnionImplicit -> Jenc.Value
encodeUnionImplicit x = case x of
    DoubleInUnionImplicit y -> Jenc.float y
    ImplicitInUnionImplicit y -> encodeImplicit y

implicit : Jdec.Decoder Implicit
implicit =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Implicit)

encodeImplicit : Implicit -> Jenc.Value
encodeImplicit x =
    Jenc.object
        [
        ]

unionIndirect : Jdec.Decoder UnionIndirect
unionIndirect =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIndirect Jdec.float
        , Jdec.map IndirectInUnionIndirect indirect
        ]

encodeUnionIndirect : UnionIndirect -> Jenc.Value
encodeUnionIndirect x = case x of
    DoubleInUnionIndirect y -> Jenc.float y
    IndirectInUnionIndirect y -> encodeIndirect y

indirect : Jdec.Decoder Indirect
indirect =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Indirect)

encodeIndirect : Indirect -> Jenc.Value
encodeIndirect x =
    Jenc.object
        [
        ]

unionInit : Jdec.Decoder UnionInit
unionInit =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInit Jdec.float
        , Jdec.map InitInUnionInit init
        ]

encodeUnionInit : UnionInit -> Jenc.Value
encodeUnionInit x = case x of
    DoubleInUnionInit y -> Jenc.float y
    InitInUnionInit y -> encodeInit y

init : Jdec.Decoder Init
init =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Init)

encodeInit : Init -> Jenc.Value
encodeInit x =
    Jenc.object
        [
        ]

unionInline : Jdec.Decoder UnionInline
unionInline =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInline Jdec.float
        , Jdec.map InlineInUnionInline inline
        ]

encodeUnionInline : UnionInline -> Jenc.Value
encodeUnionInline x = case x of
    DoubleInUnionInline y -> Jenc.float y
    InlineInUnionInline y -> encodeInline y

inline : Jdec.Decoder Inline
inline =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Inline)

encodeInline : Inline -> Jenc.Value
encodeInline x =
    Jenc.object
        [
        ]

unionInout : Jdec.Decoder UnionInout
unionInout =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInout Jdec.float
        , Jdec.map InoutInUnionInout inout
        ]

encodeUnionInout : UnionInout -> Jenc.Value
encodeUnionInout x = case x of
    DoubleInUnionInout y -> Jenc.float y
    InoutInUnionInout y -> encodeInout y

inout : Jdec.Decoder Inout
inout =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Inout)

encodeInout : Inout -> Jenc.Value
encodeInout x =
    Jenc.object
        [
        ]

unionInstanceof : Jdec.Decoder UnionInstanceof
unionInstanceof =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInstanceof Jdec.float
        , Jdec.map InstanceofInUnionInstanceof instanceof
        ]

encodeUnionInstanceof : UnionInstanceof -> Jenc.Value
encodeUnionInstanceof x = case x of
    DoubleInUnionInstanceof y -> Jenc.float y
    InstanceofInUnionInstanceof y -> encodeInstanceof y

instanceof : Jdec.Decoder Instanceof
instanceof =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Instanceof)

encodeInstanceof : Instanceof -> Jenc.Value
encodeInstanceof x =
    Jenc.object
        [
        ]

unionIntNode : Jdec.Decoder UnionIntNode
unionIntNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIntNode Jdec.float
        , Jdec.map IntNodeInUnionIntNode intNode
        ]

encodeUnionIntNode : UnionIntNode -> Jenc.Value
encodeUnionIntNode x = case x of
    DoubleInUnionIntNode y -> Jenc.float y
    IntNodeInUnionIntNode y -> encodeIntNode y

intNode : Jdec.Decoder IntNode
intNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> IntNode)

encodeIntNode : IntNode -> Jenc.Value
encodeIntNode x =
    Jenc.object
        [
        ]

unionInterface : Jdec.Decoder UnionInterface
unionInterface =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInterface Jdec.float
        , Jdec.map InterfaceInUnionInterface interface
        ]

encodeUnionInterface : UnionInterface -> Jenc.Value
encodeUnionInterface x = case x of
    DoubleInUnionInterface y -> Jenc.float y
    InterfaceInUnionInterface y -> encodeInterface y

interface : Jdec.Decoder Interface
interface =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Interface)

encodeInterface : Interface -> Jenc.Value
encodeInterface x =
    Jenc.object
        [
        ]

unionInternal : Jdec.Decoder UnionInternal
unionInternal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInternal Jdec.float
        , Jdec.map InternalInUnionInternal internal
        ]

encodeUnionInternal : UnionInternal -> Jenc.Value
encodeUnionInternal x = case x of
    DoubleInUnionInternal y -> Jenc.float y
    InternalInUnionInternal y -> encodeInternal y

internal : Jdec.Decoder Internal
internal =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Internal)

encodeInternal : Internal -> Jenc.Value
encodeInternal x =
    Jenc.object
        [
        ]

unionIs : Jdec.Decoder UnionIs
unionIs =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIs Jdec.float
        , Jdec.map IsInUnionIs is
        ]

encodeUnionIs : UnionIs -> Jenc.Value
encodeUnionIs x = case x of
    DoubleInUnionIs y -> Jenc.float y
    IsInUnionIs y -> encodeIs y

is : Jdec.Decoder Is
is =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Is)

encodeIs : Is -> Jenc.Value
encodeIs x =
    Jenc.object
        [
        ]

unionISODateTimeOffsetConverter : Jdec.Decoder UnionISODateTimeOffsetConverter
unionISODateTimeOffsetConverter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionISODateTimeOffsetConverter Jdec.float
        , Jdec.map ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter isoDateTimeOffsetConverter
        ]

encodeUnionISODateTimeOffsetConverter : UnionISODateTimeOffsetConverter -> Jenc.Value
encodeUnionISODateTimeOffsetConverter x = case x of
    DoubleInUnionISODateTimeOffsetConverter y -> Jenc.float y
    ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter y -> encodeISODateTimeOffsetConverter y

isoDateTimeOffsetConverter : Jdec.Decoder ISODateTimeOffsetConverter
isoDateTimeOffsetConverter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ISODateTimeOffsetConverter)

encodeISODateTimeOffsetConverter : ISODateTimeOffsetConverter -> Jenc.Value
encodeISODateTimeOffsetConverter x =
    Jenc.object
        [
        ]

unionIterable : Jdec.Decoder UnionIterable
unionIterable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIterable Jdec.float
        , Jdec.map IterableInUnionIterable iterable
        ]

encodeUnionIterable : UnionIterable -> Jenc.Value
encodeUnionIterable x = case x of
    DoubleInUnionIterable y -> Jenc.float y
    IterableInUnionIterable y -> encodeIterable y

iterable : Jdec.Decoder Iterable
iterable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Iterable)

encodeIterable : Iterable -> Jenc.Value
encodeIterable x =
    Jenc.object
        [
        ]

unionJdec : Jdec.Decoder UnionJdec
unionJdec =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJdec Jdec.float
        , Jdec.map JdecClassInUnionJdec jdecClass
        ]

encodeUnionJdec : UnionJdec -> Jenc.Value
encodeUnionJdec x = case x of
    DoubleInUnionJdec y -> Jenc.float y
    JdecClassInUnionJdec y -> encodeJdecClass y

jdecClass : Jdec.Decoder JdecClass
jdecClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JdecClass)

encodeJdecClass : JdecClass -> Jenc.Value
encodeJdecClass x =
    Jenc.object
        [
        ]

unionJenc : Jdec.Decoder UnionJenc
unionJenc =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJenc Jdec.float
        , Jdec.map JencClassInUnionJenc jencClass
        ]

encodeUnionJenc : UnionJenc -> Jenc.Value
encodeUnionJenc x = case x of
    DoubleInUnionJenc y -> Jenc.float y
    JencClassInUnionJenc y -> encodeJencClass y

jencClass : Jdec.Decoder JencClass
jencClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JencClass)

encodeJencClass : JencClass -> Jenc.Value
encodeJencClass x =
    Jenc.object
        [
        ]

unionJpipe : Jdec.Decoder UnionJpipe
unionJpipe =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJpipe Jdec.float
        , Jdec.map JpipeClassInUnionJpipe jpipeClass
        ]

encodeUnionJpipe : UnionJpipe -> Jenc.Value
encodeUnionJpipe x = case x of
    DoubleInUnionJpipe y -> Jenc.float y
    JpipeClassInUnionJpipe y -> encodeJpipeClass y

jpipeClass : Jdec.Decoder JpipeClass
jpipeClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JpipeClass)

encodeJpipeClass : JpipeClass -> Jenc.Value
encodeJpipeClass x =
    Jenc.object
        [
        ]

unionJSON : Jdec.Decoder UnionJSON
unionJSON =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSON Jdec.float
        , Jdec.map JSONInUnionJSON json
        ]

encodeUnionJSON : UnionJSON -> Jenc.Value
encodeUnionJSON x = case x of
    DoubleInUnionJSON y -> Jenc.float y
    JSONInUnionJSON y -> encodeJSON y

json : Jdec.Decoder JSON
json =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSON)

encodeJSON : JSON -> Jenc.Value
encodeJSON x =
    Jenc.object
        [
        ]

unionJSONAny : Jdec.Decoder UnionJSONAny
unionJSONAny =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONAny Jdec.float
        , Jdec.map JSONAnyInUnionJSONAny jsonAny
        ]

encodeUnionJSONAny : UnionJSONAny -> Jenc.Value
encodeUnionJSONAny x = case x of
    DoubleInUnionJSONAny y -> Jenc.float y
    JSONAnyInUnionJSONAny y -> encodeJSONAny y

jsonAny : Jdec.Decoder JSONAny
jsonAny =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONAny)

encodeJSONAny : JSONAny -> Jenc.Value
encodeJSONAny x =
    Jenc.object
        [
        ]

unionJSONCodingKey : Jdec.Decoder UnionJSONCodingKey
unionJSONCodingKey =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONCodingKey Jdec.float
        , Jdec.map JSONCodingKeyInUnionJSONCodingKey jsonCodingKey
        ]

encodeUnionJSONCodingKey : UnionJSONCodingKey -> Jenc.Value
encodeUnionJSONCodingKey x = case x of
    DoubleInUnionJSONCodingKey y -> Jenc.float y
    JSONCodingKeyInUnionJSONCodingKey y -> encodeJSONCodingKey y

jsonCodingKey : Jdec.Decoder JSONCodingKey
jsonCodingKey =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONCodingKey)

encodeJSONCodingKey : JSONCodingKey -> Jenc.Value
encodeJSONCodingKey x =
    Jenc.object
        [
        ]

unionJSONConverter : Jdec.Decoder UnionJSONConverter
unionJSONConverter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONConverter Jdec.float
        , Jdec.map JSONConverterInUnionJSONConverter jsonConverter
        ]

encodeUnionJSONConverter : UnionJSONConverter -> Jenc.Value
encodeUnionJSONConverter x = case x of
    DoubleInUnionJSONConverter y -> Jenc.float y
    JSONConverterInUnionJSONConverter y -> encodeJSONConverter y

jsonConverter : Jdec.Decoder JSONConverter
jsonConverter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONConverter)

encodeJSONConverter : JSONConverter -> Jenc.Value
encodeJSONConverter x =
    Jenc.object
        [
        ]

unionJSONDecoder : Jdec.Decoder UnionJSONDecoder
unionJSONDecoder =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONDecoder Jdec.float
        , Jdec.map JSONDecoderInUnionJSONDecoder jsonDecoder
        ]

encodeUnionJSONDecoder : UnionJSONDecoder -> Jenc.Value
encodeUnionJSONDecoder x = case x of
    DoubleInUnionJSONDecoder y -> Jenc.float y
    JSONDecoderInUnionJSONDecoder y -> encodeJSONDecoder y

jsonDecoder : Jdec.Decoder JSONDecoder
jsonDecoder =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONDecoder)

encodeJSONDecoder : JSONDecoder -> Jenc.Value
encodeJSONDecoder x =
    Jenc.object
        [
        ]

unionJSONEncoder : Jdec.Decoder UnionJSONEncoder
unionJSONEncoder =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONEncoder Jdec.float
        , Jdec.map JSONEncoderInUnionJSONEncoder jsonEncoder
        ]

encodeUnionJSONEncoder : UnionJSONEncoder -> Jenc.Value
encodeUnionJSONEncoder x = case x of
    DoubleInUnionJSONEncoder y -> Jenc.float y
    JSONEncoderInUnionJSONEncoder y -> encodeJSONEncoder y

jsonEncoder : Jdec.Decoder JSONEncoder
jsonEncoder =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONEncoder)

encodeJSONEncoder : JSONEncoder -> Jenc.Value
encodeJSONEncoder x =
    Jenc.object
        [
        ]

unionJSONException : Jdec.Decoder UnionJSONException
unionJSONException =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONException Jdec.float
        , Jdec.map JSONExceptionInUnionJSONException jsonException
        ]

encodeUnionJSONException : UnionJSONException -> Jenc.Value
encodeUnionJSONException x = case x of
    DoubleInUnionJSONException y -> Jenc.float y
    JSONExceptionInUnionJSONException y -> encodeJSONException y

jsonException : Jdec.Decoder JSONException
jsonException =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONException)

encodeJSONException : JSONException -> Jenc.Value
encodeJSONException x =
    Jenc.object
        [
        ]

unionJSONGenerator : Jdec.Decoder UnionJSONGenerator
unionJSONGenerator =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONGenerator Jdec.float
        , Jdec.map JSONGeneratorInUnionJSONGenerator jsonGenerator
        ]

encodeUnionJSONGenerator : UnionJSONGenerator -> Jenc.Value
encodeUnionJSONGenerator x = case x of
    DoubleInUnionJSONGenerator y -> Jenc.float y
    JSONGeneratorInUnionJSONGenerator y -> encodeJSONGenerator y

jsonGenerator : Jdec.Decoder JSONGenerator
jsonGenerator =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONGenerator)

encodeJSONGenerator : JSONGenerator -> Jenc.Value
encodeJSONGenerator x =
    Jenc.object
        [
        ]

unionJSONNode : Jdec.Decoder UnionJSONNode
unionJSONNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONNode Jdec.float
        , Jdec.map JSONNodeInUnionJSONNode jsonNode
        ]

encodeUnionJSONNode : UnionJSONNode -> Jenc.Value
encodeUnionJSONNode x = case x of
    DoubleInUnionJSONNode y -> Jenc.float y
    JSONNodeInUnionJSONNode y -> encodeJSONNode y

jsonNode : Jdec.Decoder JSONNode
jsonNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONNode)

encodeJSONNode : JSONNode -> Jenc.Value
encodeJSONNode x =
    Jenc.object
        [
        ]

unionJSONNull : Jdec.Decoder UnionJSONNull
unionJSONNull =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONNull Jdec.float
        , Jdec.map JSONNullInUnionJSONNull jsonNull
        ]

encodeUnionJSONNull : UnionJSONNull -> Jenc.Value
encodeUnionJSONNull x = case x of
    DoubleInUnionJSONNull y -> Jenc.float y
    JSONNullInUnionJSONNull y -> encodeJSONNull y

jsonNull : Jdec.Decoder JSONNull
jsonNull =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONNull)

encodeJSONNull : JSONNull -> Jenc.Value
encodeJSONNull x =
    Jenc.object
        [
        ]

unionJSONParser : Jdec.Decoder UnionJSONParser
unionJSONParser =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONParser Jdec.float
        , Jdec.map JSONParserInUnionJSONParser jsonParser
        ]

encodeUnionJSONParser : UnionJSONParser -> Jenc.Value
encodeUnionJSONParser x = case x of
    DoubleInUnionJSONParser y -> Jenc.float y
    JSONParserInUnionJSONParser y -> encodeJSONParser y

jsonParser : Jdec.Decoder JSONParser
jsonParser =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONParser)

encodeJSONParser : JSONParser -> Jenc.Value
encodeJSONParser x =
    Jenc.object
        [
        ]

unionJSONReader : Jdec.Decoder UnionJSONReader
unionJSONReader =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONReader Jdec.float
        , Jdec.map JSONReaderInUnionJSONReader jsonReader
        ]

encodeUnionJSONReader : UnionJSONReader -> Jenc.Value
encodeUnionJSONReader x = case x of
    DoubleInUnionJSONReader y -> Jenc.float y
    JSONReaderInUnionJSONReader y -> encodeJSONReader y

jsonReader : Jdec.Decoder JSONReader
jsonReader =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONReader)

encodeJSONReader : JSONReader -> Jenc.Value
encodeJSONReader x =
    Jenc.object
        [
        ]

unionJSONSerializer : Jdec.Decoder UnionJSONSerializer
unionJSONSerializer =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONSerializer Jdec.float
        , Jdec.map JSONSerializerInUnionJSONSerializer jsonSerializer
        ]

encodeUnionJSONSerializer : UnionJSONSerializer -> Jenc.Value
encodeUnionJSONSerializer x = case x of
    DoubleInUnionJSONSerializer y -> Jenc.float y
    JSONSerializerInUnionJSONSerializer y -> encodeJSONSerializer y

jsonSerializer : Jdec.Decoder JSONSerializer
jsonSerializer =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONSerializer)

encodeJSONSerializer : JSONSerializer -> Jenc.Value
encodeJSONSerializer x =
    Jenc.object
        [
        ]

unionJSONToken : Jdec.Decoder UnionJSONToken
unionJSONToken =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONToken Jdec.float
        , Jdec.map JSONTokenInUnionJSONToken jsonToken
        ]

encodeUnionJSONToken : UnionJSONToken -> Jenc.Value
encodeUnionJSONToken x = case x of
    DoubleInUnionJSONToken y -> Jenc.float y
    JSONTokenInUnionJSONToken y -> encodeJSONToken y

jsonToken : Jdec.Decoder JSONToken
jsonToken =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONToken)

encodeJSONToken : JSONToken -> Jenc.Value
encodeJSONToken x =
    Jenc.object
        [
        ]

unionJSONTokenType : Jdec.Decoder UnionJSONTokenType
unionJSONTokenType =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONTokenType Jdec.float
        , Jdec.map JSONTokenTypeInUnionJSONTokenType jsonTokenType
        ]

encodeUnionJSONTokenType : UnionJSONTokenType -> Jenc.Value
encodeUnionJSONTokenType x = case x of
    DoubleInUnionJSONTokenType y -> Jenc.float y
    JSONTokenTypeInUnionJSONTokenType y -> encodeJSONTokenType y

jsonTokenType : Jdec.Decoder JSONTokenType
jsonTokenType =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONTokenType)

encodeJSONTokenType : JSONTokenType -> Jenc.Value
encodeJSONTokenType x =
    Jenc.object
        [
        ]

unionJSONWriter : Jdec.Decoder UnionJSONWriter
unionJSONWriter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionJSONWriter Jdec.float
        , Jdec.map JSONWriterInUnionJSONWriter jsonWriter
        ]

encodeUnionJSONWriter : UnionJSONWriter -> Jenc.Value
encodeUnionJSONWriter x = case x of
    DoubleInUnionJSONWriter y -> Jenc.float y
    JSONWriterInUnionJSONWriter y -> encodeJSONWriter y

jsonWriter : Jdec.Decoder JSONWriter
jsonWriter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSONWriter)

encodeJSONWriter : JSONWriter -> Jenc.Value
encodeJSONWriter x =
    Jenc.object
        [
        ]

unionKSerializer : Jdec.Decoder UnionKSerializer
unionKSerializer =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionKSerializer Jdec.float
        , Jdec.map KSerializerInUnionKSerializer kSerializer
        ]

encodeUnionKSerializer : UnionKSerializer -> Jenc.Value
encodeUnionKSerializer x = case x of
    DoubleInUnionKSerializer y -> Jenc.float y
    KSerializerInUnionKSerializer y -> encodeKSerializer y

kSerializer : Jdec.Decoder KSerializer
kSerializer =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> KSerializer)

encodeKSerializer : KSerializer -> Jenc.Value
encodeKSerializer x =
    Jenc.object
        [
        ]

unionLambda : Jdec.Decoder UnionLambda
unionLambda =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLambda Jdec.float
        , Jdec.map LambdaInUnionLambda lambda
        ]

encodeUnionLambda : UnionLambda -> Jenc.Value
encodeUnionLambda x = case x of
    DoubleInUnionLambda y -> Jenc.float y
    LambdaInUnionLambda y -> encodeLambda y

lambda : Jdec.Decoder Lambda
lambda =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Lambda)

encodeLambda : Lambda -> Jenc.Value
encodeLambda x =
    Jenc.object
        [
        ]

unionLazy : Jdec.Decoder UnionLazy
unionLazy =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLazy Jdec.float
        , Jdec.map LazyInUnionLazy lazy
        ]

encodeUnionLazy : UnionLazy -> Jenc.Value
encodeUnionLazy x = case x of
    DoubleInUnionLazy y -> Jenc.float y
    LazyInUnionLazy y -> encodeLazy y

lazy : Jdec.Decoder Lazy
lazy =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Lazy)

encodeLazy : Lazy -> Jenc.Value
encodeLazy x =
    Jenc.object
        [
        ]

unionLeft : Jdec.Decoder UnionLeft
unionLeft =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLeft Jdec.float
        , Jdec.map LeftInUnionLeft left
        ]

encodeUnionLeft : UnionLeft -> Jenc.Value
encodeUnionLeft x = case x of
    DoubleInUnionLeft y -> Jenc.float y
    LeftInUnionLeft y -> encodeLeft y

left : Jdec.Decoder Left
left =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Left)

encodeLeft : Left -> Jenc.Value
encodeLeft x =
    Jenc.object
        [
        ]

unionList : Jdec.Decoder UnionList
unionList =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionList Jdec.float
        , Jdec.map ListClassInUnionList listClass
        ]

encodeUnionList : UnionList -> Jenc.Value
encodeUnionList x = case x of
    DoubleInUnionList y -> Jenc.float y
    ListClassInUnionList y -> encodeListClass y

listClass : Jdec.Decoder ListClass
listClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ListClass)

encodeListClass : ListClass -> Jenc.Value
encodeListClass x =
    Jenc.object
        [
        ]

unionLocalDate : Jdec.Decoder UnionLocalDate
unionLocalDate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLocalDate Jdec.float
        , Jdec.map LocalDateInUnionLocalDate localDate
        ]

encodeUnionLocalDate : UnionLocalDate -> Jenc.Value
encodeUnionLocalDate x = case x of
    DoubleInUnionLocalDate y -> Jenc.float y
    LocalDateInUnionLocalDate y -> encodeLocalDate y

localDate : Jdec.Decoder LocalDate
localDate =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> LocalDate)

encodeLocalDate : LocalDate -> Jenc.Value
encodeLocalDate x =
    Jenc.object
        [
        ]

unionLocale : Jdec.Decoder UnionLocale
unionLocale =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLocale Jdec.float
        , Jdec.map LocaleInUnionLocale locale
        ]

encodeUnionLocale : UnionLocale -> Jenc.Value
encodeUnionLocale x = case x of
    DoubleInUnionLocale y -> Jenc.float y
    LocaleInUnionLocale y -> encodeLocale y

locale : Jdec.Decoder Locale
locale =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Locale)

encodeLocale : Locale -> Jenc.Value
encodeLocale x =
    Jenc.object
        [
        ]

unionLock : Jdec.Decoder UnionLock
unionLock =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLock Jdec.float
        , Jdec.map LockInUnionLock lock
        ]

encodeUnionLock : UnionLock -> Jenc.Value
encodeUnionLock x = case x of
    DoubleInUnionLock y -> Jenc.float y
    LockInUnionLock y -> encodeLock y

lock : Jdec.Decoder Lock
lock =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Lock)

encodeLock : Lock -> Jenc.Value
encodeLock x =
    Jenc.object
        [
        ]

unionLong : Jdec.Decoder UnionLong
unionLong =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLong Jdec.float
        , Jdec.map LongInUnionLong long
        ]

encodeUnionLong : UnionLong -> Jenc.Value
encodeUnionLong x = case x of
    DoubleInUnionLong y -> Jenc.float y
    LongInUnionLong y -> encodeLong y

long : Jdec.Decoder Long
long =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Long)

encodeLong : Long -> Jenc.Value
encodeLong x =
    Jenc.object
        [
        ]

unionLongNode : Jdec.Decoder UnionLongNode
unionLongNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLongNode Jdec.float
        , Jdec.map LongNodeInUnionLongNode longNode
        ]

encodeUnionLongNode : UnionLongNode -> Jenc.Value
encodeUnionLongNode x = case x of
    DoubleInUnionLongNode y -> Jenc.float y
    LongNodeInUnionLongNode y -> encodeLongNode y

longNode : Jdec.Decoder LongNode
longNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> LongNode)

encodeLongNode : LongNode -> Jenc.Value
encodeLongNode x =
    Jenc.object
        [
        ]

unionMap : Jdec.Decoder UnionMap
unionMap =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMap Jdec.float
        , Jdec.map MapInUnionMap map
        ]

encodeUnionMap : UnionMap -> Jenc.Value
encodeUnionMap x = case x of
    DoubleInUnionMap y -> Jenc.float y
    MapInUnionMap y -> encodeMap y

map : Jdec.Decoder Map
map =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Map)

encodeMap : Map -> Jenc.Value
encodeMap x =
    Jenc.object
        [
        ]

unionMapEntry : Jdec.Decoder UnionMapEntry
unionMapEntry =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMapEntry Jdec.float
        , Jdec.map MapEntryInUnionMapEntry mapEntry
        ]

encodeUnionMapEntry : UnionMapEntry -> Jenc.Value
encodeUnionMapEntry x = case x of
    DoubleInUnionMapEntry y -> Jenc.float y
    MapEntryInUnionMapEntry y -> encodeMapEntry y

mapEntry : Jdec.Decoder MapEntry
mapEntry =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> MapEntry)

encodeMapEntry : MapEntry -> Jenc.Value
encodeMapEntry x =
    Jenc.object
        [
        ]

unionMarshalJSON : Jdec.Decoder UnionMarshalJSON
unionMarshalJSON =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMarshalJSON Jdec.float
        , Jdec.map MarshalJSONInUnionMarshalJSON marshalJSON
        ]

encodeUnionMarshalJSON : UnionMarshalJSON -> Jenc.Value
encodeUnionMarshalJSON x = case x of
    DoubleInUnionMarshalJSON y -> Jenc.float y
    MarshalJSONInUnionMarshalJSON y -> encodeMarshalJSON y

marshalJSON : Jdec.Decoder MarshalJSON
marshalJSON =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> MarshalJSON)

encodeMarshalJSON : MarshalJSON -> Jenc.Value
encodeMarshalJSON x =
    Jenc.object
        [
        ]

unionMetadataPropertyHandling : Jdec.Decoder UnionMetadataPropertyHandling
unionMetadataPropertyHandling =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMetadataPropertyHandling Jdec.float
        , Jdec.map MetadataPropertyHandlingInUnionMetadataPropertyHandling metadataPropertyHandling
        ]

encodeUnionMetadataPropertyHandling : UnionMetadataPropertyHandling -> Jenc.Value
encodeUnionMetadataPropertyHandling x = case x of
    DoubleInUnionMetadataPropertyHandling y -> Jenc.float y
    MetadataPropertyHandlingInUnionMetadataPropertyHandling y -> encodeMetadataPropertyHandling y

metadataPropertyHandling : Jdec.Decoder MetadataPropertyHandling
metadataPropertyHandling =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> MetadataPropertyHandling)

encodeMetadataPropertyHandling : MetadataPropertyHandling -> Jenc.Value
encodeMetadataPropertyHandling x =
    Jenc.object
        [
        ]

unionMutable : Jdec.Decoder UnionMutable
unionMutable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMutable Jdec.float
        , Jdec.map MutableInUnionMutable mutable
        ]

encodeUnionMutable : UnionMutable -> Jenc.Value
encodeUnionMutable x = case x of
    DoubleInUnionMutable y -> Jenc.float y
    MutableInUnionMutable y -> encodeMutable y

mutable : Jdec.Decoder Mutable
mutable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Mutable)

encodeMutable : Mutable -> Jenc.Value
encodeMutable x =
    Jenc.object
        [
        ]

unionMutating : Jdec.Decoder UnionMutating
unionMutating =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionMutating Jdec.float
        , Jdec.map MutatingInUnionMutating mutating
        ]

encodeUnionMutating : UnionMutating -> Jenc.Value
encodeUnionMutating x = case x of
    DoubleInUnionMutating y -> Jenc.float y
    MutatingInUnionMutating y -> encodeMutating y

mutating : Jdec.Decoder Mutating
mutating =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Mutating)

encodeMutating : Mutating -> Jenc.Value
encodeMutating x =
    Jenc.object
        [
        ]

unionNamespace : Jdec.Decoder UnionNamespace
unionNamespace =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNamespace Jdec.float
        , Jdec.map NamespaceInUnionNamespace namespace
        ]

encodeUnionNamespace : UnionNamespace -> Jenc.Value
encodeUnionNamespace x = case x of
    DoubleInUnionNamespace y -> Jenc.float y
    NamespaceInUnionNamespace y -> encodeNamespace y

namespace : Jdec.Decoder Namespace
namespace =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Namespace)

encodeNamespace : Namespace -> Jenc.Value
encodeNamespace x =
    Jenc.object
        [
        ]

unionNative : Jdec.Decoder UnionNative
unionNative =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNative Jdec.float
        , Jdec.map NativeInUnionNative native
        ]

encodeUnionNative : UnionNative -> Jenc.Value
encodeUnionNative x = case x of
    DoubleInUnionNative y -> Jenc.float y
    NativeInUnionNative y -> encodeNative y

native : Jdec.Decoder Native
native =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Native)

encodeNative : Native -> Jenc.Value
encodeNative x =
    Jenc.object
        [
        ]

unionNew : Jdec.Decoder UnionNew
unionNew =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNew Jdec.float
        , Jdec.map NewInUnionNew new
        ]

encodeUnionNew : UnionNew -> Jenc.Value
encodeUnionNew x = case x of
    DoubleInUnionNew y -> Jenc.float y
    NewInUnionNew y -> encodeNew y

new : Jdec.Decoder New
new =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> New)

encodeNew : New -> Jenc.Value
encodeNew x =
    Jenc.object
        [
        ]

unionNewtonsoft : Jdec.Decoder UnionNewtonsoft
unionNewtonsoft =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNewtonsoft Jdec.float
        , Jdec.map NewtonsoftInUnionNewtonsoft newtonsoft
        ]

encodeUnionNewtonsoft : UnionNewtonsoft -> Jenc.Value
encodeUnionNewtonsoft x = case x of
    DoubleInUnionNewtonsoft y -> Jenc.float y
    NewtonsoftInUnionNewtonsoft y -> encodeNewtonsoft y

newtonsoft : Jdec.Decoder Newtonsoft
newtonsoft =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Newtonsoft)

encodeNewtonsoft : Newtonsoft -> Jenc.Value
encodeNewtonsoft x =
    Jenc.object
        [
        ]

unionNil : Jdec.Decoder UnionNil
unionNil =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNil Jdec.float
        , Jdec.map NilInUnionNil nil
        ]

encodeUnionNil : UnionNil -> Jenc.Value
encodeUnionNil x = case x of
    DoubleInUnionNil y -> Jenc.float y
    NilInUnionNil y -> encodeNil y

nil : Jdec.Decoder Nil
nil =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Nil)

encodeNil : Nil -> Jenc.Value
encodeNil x =
    Jenc.object
        [
        ]

unionNO : Jdec.Decoder UnionNO
unionNO =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNO Jdec.float
        , Jdec.map NoInUnionNO no
        ]

encodeUnionNO : UnionNO -> Jenc.Value
encodeUnionNO x = case x of
    DoubleInUnionNO y -> Jenc.float y
    NoInUnionNO y -> encodeNo y

no : Jdec.Decoder No
no =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> No)

encodeNo : No -> Jenc.Value
encodeNo x =
    Jenc.object
        [
        ]

unionNoSuchMethod : Jdec.Decoder UnionNoSuchMethod
unionNoSuchMethod =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNoSuchMethod Jdec.float
        , Jdec.map NoSuchMethodInUnionNoSuchMethod noSuchMethod
        ]

encodeUnionNoSuchMethod : UnionNoSuchMethod -> Jenc.Value
encodeUnionNoSuchMethod x = case x of
    DoubleInUnionNoSuchMethod y -> Jenc.float y
    NoSuchMethodInUnionNoSuchMethod y -> encodeNoSuchMethod y

noSuchMethod : Jdec.Decoder NoSuchMethod
noSuchMethod =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NoSuchMethod)

encodeNoSuchMethod : NoSuchMethod -> Jenc.Value
encodeNoSuchMethod x =
    Jenc.object
        [
        ]

unionNoexcept : Jdec.Decoder UnionNoexcept
unionNoexcept =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNoexcept Jdec.float
        , Jdec.map NoexceptInUnionNoexcept noexcept
        ]

encodeUnionNoexcept : UnionNoexcept -> Jenc.Value
encodeUnionNoexcept x = case x of
    DoubleInUnionNoexcept y -> Jenc.float y
    NoexceptInUnionNoexcept y -> encodeNoexcept y

noexcept : Jdec.Decoder Noexcept
noexcept =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Noexcept)

encodeNoexcept : Noexcept -> Jenc.Value
encodeNoexcept x =
    Jenc.object
        [
        ]

unionNonatomic : Jdec.Decoder UnionNonatomic
unionNonatomic =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNonatomic Jdec.float
        , Jdec.map NonatomicInUnionNonatomic nonatomic
        ]

encodeUnionNonatomic : UnionNonatomic -> Jenc.Value
encodeUnionNonatomic x = case x of
    DoubleInUnionNonatomic y -> Jenc.float y
    NonatomicInUnionNonatomic y -> encodeNonatomic y

nonatomic : Jdec.Decoder Nonatomic
nonatomic =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Nonatomic)

encodeNonatomic : Nonatomic -> Jenc.Value
encodeNonatomic x =
    Jenc.object
        [
        ]

unionNone : Jdec.Decoder UnionNone
unionNone =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNone Jdec.float
        , Jdec.map NoneInUnionNone none
        ]

encodeUnionNone : UnionNone -> Jenc.Value
encodeUnionNone x = case x of
    DoubleInUnionNone y -> Jenc.float y
    NoneInUnionNone y -> encodeNone y

none : Jdec.Decoder None
none =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> None)

encodeNone : None -> Jenc.Value
encodeNone x =
    Jenc.object
        [
        ]

unionNonlocal : Jdec.Decoder UnionNonlocal
unionNonlocal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNonlocal Jdec.float
        , Jdec.map NonlocalInUnionNonlocal nonlocal
        ]

encodeUnionNonlocal : UnionNonlocal -> Jenc.Value
encodeUnionNonlocal x = case x of
    DoubleInUnionNonlocal y -> Jenc.float y
    NonlocalInUnionNonlocal y -> encodeNonlocal y

nonlocal : Jdec.Decoder Nonlocal
nonlocal =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Nonlocal)

encodeNonlocal : Nonlocal -> Jenc.Value
encodeNonlocal x =
    Jenc.object
        [
        ]

unionNonmutating : Jdec.Decoder UnionNonmutating
unionNonmutating =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNonmutating Jdec.float
        , Jdec.map NonmutatingInUnionNonmutating nonmutating
        ]

encodeUnionNonmutating : UnionNonmutating -> Jenc.Value
encodeUnionNonmutating x = case x of
    DoubleInUnionNonmutating y -> Jenc.float y
    NonmutatingInUnionNonmutating y -> encodeNonmutating y

nonmutating : Jdec.Decoder Nonmutating
nonmutating =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Nonmutating)

encodeNonmutating : Nonmutating -> Jenc.Value
encodeNonmutating x =
    Jenc.object
        [
        ]

unionNot : Jdec.Decoder UnionNot
unionNot =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNot Jdec.float
        , Jdec.map NotInUnionNot not
        ]

encodeUnionNot : UnionNot -> Jenc.Value
encodeUnionNot x = case x of
    DoubleInUnionNot y -> Jenc.float y
    NotInUnionNot y -> encodeNot y

not : Jdec.Decoder Not
not =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Not)

encodeNot : Not -> Jenc.Value
encodeNot x =
    Jenc.object
        [
        ]

unionNotEq : Jdec.Decoder UnionNotEq
unionNotEq =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNotEq Jdec.float
        , Jdec.map NotEqInUnionNotEq notEq
        ]

encodeUnionNotEq : UnionNotEq -> Jenc.Value
encodeUnionNotEq x = case x of
    DoubleInUnionNotEq y -> Jenc.float y
    NotEqInUnionNotEq y -> encodeNotEq y

notEq : Jdec.Decoder NotEq
notEq =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NotEq)

encodeNotEq : NotEq -> Jenc.Value
encodeNotEq x =
    Jenc.object
        [
        ]

unionNSError : Jdec.Decoder UnionNSError
unionNSError =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNSError Jdec.float
        , Jdec.map NSErrorInUnionNSError nsError
        ]

encodeUnionNSError : UnionNSError -> Jenc.Value
encodeUnionNSError x = case x of
    DoubleInUnionNSError y -> Jenc.float y
    NSErrorInUnionNSError y -> encodeNSError y

nsError : Jdec.Decoder NSError
nsError =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NSError)

encodeNSError : NSError -> Jenc.Value
encodeNSError x =
    Jenc.object
        [
        ]

unionNSObject : Jdec.Decoder UnionNSObject
unionNSObject =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNSObject Jdec.float
        , Jdec.map NSObjectInUnionNSObject nsObject
        ]

encodeUnionNSObject : UnionNSObject -> Jenc.Value
encodeUnionNSObject x = case x of
    DoubleInUnionNSObject y -> Jenc.float y
    NSObjectInUnionNSObject y -> encodeNSObject y

nsObject : Jdec.Decoder NSObject
nsObject =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NSObject)

encodeNSObject : NSObject -> Jenc.Value
encodeNSObject x =
    Jenc.object
        [
        ]

unionNSString : Jdec.Decoder UnionNSString
unionNSString =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNSString Jdec.float
        , Jdec.map NSStringInUnionNSString nsString
        ]

encodeUnionNSString : UnionNSString -> Jenc.Value
encodeUnionNSString x = case x of
    DoubleInUnionNSString y -> Jenc.float y
    NSStringInUnionNSString y -> encodeNSString y

nsString : Jdec.Decoder NSString
nsString =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NSString)

encodeNSString : NSString -> Jenc.Value
encodeNSString x =
    Jenc.object
        [
        ]

unionNULL : Jdec.Decoder UnionNULL
unionNULL =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNULL Jdec.float
        , Jdec.map NullInUnionNULL null
        ]

encodeUnionNULL : UnionNULL -> Jenc.Value
encodeUnionNULL x = case x of
    DoubleInUnionNULL y -> Jenc.float y
    NullInUnionNULL y -> encodeNull y

null : Jdec.Decoder Null
null =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Null)

encodeNull : Null -> Jenc.Value
encodeNull x =
    Jenc.object
        [
        ]

unionNullNode : Jdec.Decoder UnionNullNode
unionNullNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNullNode Jdec.float
        , Jdec.map NullNodeInUnionNullNode nullNode
        ]

encodeUnionNullNode : UnionNullNode -> Jenc.Value
encodeUnionNullNode x = case x of
    DoubleInUnionNullNode y -> Jenc.float y
    NullNodeInUnionNullNode y -> encodeNullNode y

nullNode : Jdec.Decoder NullNode
nullNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NullNode)

encodeNullNode : NullNode -> Jenc.Value
encodeNullNode x =
    Jenc.object
        [
        ]

unionNullptr : Jdec.Decoder UnionNullptr
unionNullptr =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNullptr Jdec.float
        , Jdec.map NullptrInUnionNullptr nullptr
        ]

encodeUnionNullptr : UnionNullptr -> Jenc.Value
encodeUnionNullptr x = case x of
    DoubleInUnionNullptr y -> Jenc.float y
    NullptrInUnionNullptr y -> encodeNullptr y

nullptr : Jdec.Decoder Nullptr
nullptr =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Nullptr)

encodeNullptr : Nullptr -> Jenc.Value
encodeNullptr x =
    Jenc.object
        [
        ]

unionNumber : Jdec.Decoder UnionNumber
unionNumber =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNumber Jdec.float
        , Jdec.map NumberInUnionNumber number
        ]

encodeUnionNumber : UnionNumber -> Jenc.Value
encodeUnionNumber x = case x of
    DoubleInUnionNumber y -> Jenc.float y
    NumberInUnionNumber y -> encodeNumber y

number : Jdec.Decoder Number
number =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Number)

encodeNumber : Number -> Jenc.Value
encodeNumber x =
    Jenc.object
        [
        ]

unionObject : Jdec.Decoder UnionObject
unionObject =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionObject Jdec.float
        , Jdec.map ObjectInUnionObject object
        ]

encodeUnionObject : UnionObject -> Jenc.Value
encodeUnionObject x = case x of
    DoubleInUnionObject y -> Jenc.float y
    ObjectInUnionObject y -> encodeObject y

object : Jdec.Decoder Object
object =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Object)

encodeObject : Object -> Jenc.Value
encodeObject x =
    Jenc.object
        [
        ]

unionObjectMapper : Jdec.Decoder UnionObjectMapper
unionObjectMapper =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionObjectMapper Jdec.float
        , Jdec.map ObjectMapperInUnionObjectMapper objectMapper
        ]

encodeUnionObjectMapper : UnionObjectMapper -> Jenc.Value
encodeUnionObjectMapper x = case x of
    DoubleInUnionObjectMapper y -> Jenc.float y
    ObjectMapperInUnionObjectMapper y -> encodeObjectMapper y

objectMapper : Jdec.Decoder ObjectMapper
objectMapper =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ObjectMapper)

encodeObjectMapper : ObjectMapper -> Jenc.Value
encodeObjectMapper x =
    Jenc.object
        [
        ]

unionObjectNode : Jdec.Decoder UnionObjectNode
unionObjectNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionObjectNode Jdec.float
        , Jdec.map ObjectNodeInUnionObjectNode objectNode
        ]

encodeUnionObjectNode : UnionObjectNode -> Jenc.Value
encodeUnionObjectNode x = case x of
    DoubleInUnionObjectNode y -> Jenc.float y
    ObjectNodeInUnionObjectNode y -> encodeObjectNode y

objectNode : Jdec.Decoder ObjectNode
objectNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ObjectNode)

encodeObjectNode : ObjectNode -> Jenc.Value
encodeObjectNode x =
    Jenc.object
        [
        ]

unionObjectReader : Jdec.Decoder UnionObjectReader
unionObjectReader =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionObjectReader Jdec.float
        , Jdec.map ObjectReaderInUnionObjectReader objectReader
        ]

encodeUnionObjectReader : UnionObjectReader -> Jenc.Value
encodeUnionObjectReader x = case x of
    DoubleInUnionObjectReader y -> Jenc.float y
    ObjectReaderInUnionObjectReader y -> encodeObjectReader y

objectReader : Jdec.Decoder ObjectReader
objectReader =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ObjectReader)

encodeObjectReader : ObjectReader -> Jenc.Value
encodeObjectReader x =
    Jenc.object
        [
        ]

unionObjectWriter : Jdec.Decoder UnionObjectWriter
unionObjectWriter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionObjectWriter Jdec.float
        , Jdec.map ObjectWriterInUnionObjectWriter objectWriter
        ]

encodeUnionObjectWriter : UnionObjectWriter -> Jenc.Value
encodeUnionObjectWriter x = case x of
    DoubleInUnionObjectWriter y -> Jenc.float y
    ObjectWriterInUnionObjectWriter y -> encodeObjectWriter y

objectWriter : Jdec.Decoder ObjectWriter
objectWriter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ObjectWriter)

encodeObjectWriter : ObjectWriter -> Jenc.Value
encodeObjectWriter x =
    Jenc.object
        [
        ]

unionOffsetDateTime : Jdec.Decoder UnionOffsetDateTime
unionOffsetDateTime =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOffsetDateTime Jdec.float
        , Jdec.map OffsetDateTimeInUnionOffsetDateTime offsetDateTime
        ]

encodeUnionOffsetDateTime : UnionOffsetDateTime -> Jenc.Value
encodeUnionOffsetDateTime x = case x of
    DoubleInUnionOffsetDateTime y -> Jenc.float y
    OffsetDateTimeInUnionOffsetDateTime y -> encodeOffsetDateTime y

offsetDateTime : Jdec.Decoder OffsetDateTime
offsetDateTime =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> OffsetDateTime)

encodeOffsetDateTime : OffsetDateTime -> Jenc.Value
encodeOffsetDateTime x =
    Jenc.object
        [
        ]

unionOffsetTime : Jdec.Decoder UnionOffsetTime
unionOffsetTime =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOffsetTime Jdec.float
        , Jdec.map OffsetTimeInUnionOffsetTime offsetTime
        ]

encodeUnionOffsetTime : UnionOffsetTime -> Jenc.Value
encodeUnionOffsetTime x = case x of
    DoubleInUnionOffsetTime y -> Jenc.float y
    OffsetTimeInUnionOffsetTime y -> encodeOffsetTime y

offsetTime : Jdec.Decoder OffsetTime
offsetTime =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> OffsetTime)

encodeOffsetTime : OffsetTime -> Jenc.Value
encodeOffsetTime x =
    Jenc.object
        [
        ]

unionOneway : Jdec.Decoder UnionOneway
unionOneway =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOneway Jdec.float
        , Jdec.map OnewayInUnionOneway oneway
        ]

encodeUnionOneway : UnionOneway -> Jenc.Value
encodeUnionOneway x = case x of
    DoubleInUnionOneway y -> Jenc.float y
    OnewayInUnionOneway y -> encodeOneway y

oneway : Jdec.Decoder Oneway
oneway =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Oneway)

encodeOneway : Oneway -> Jenc.Value
encodeOneway x =
    Jenc.object
        [
        ]

unionOpen : Jdec.Decoder UnionOpen
unionOpen =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOpen Jdec.float
        , Jdec.map OpenInUnionOpen open
        ]

encodeUnionOpen : UnionOpen -> Jenc.Value
encodeUnionOpen x = case x of
    DoubleInUnionOpen y -> Jenc.float y
    OpenInUnionOpen y -> encodeOpen y

open : Jdec.Decoder Open
open =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Open)

encodeOpen : Open -> Jenc.Value
encodeOpen x =
    Jenc.object
        [
        ]

unionOperator : Jdec.Decoder UnionOperator
unionOperator =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOperator Jdec.float
        , Jdec.map OperatorInUnionOperator operator
        ]

encodeUnionOperator : UnionOperator -> Jenc.Value
encodeUnionOperator x = case x of
    DoubleInUnionOperator y -> Jenc.float y
    OperatorInUnionOperator y -> encodeOperator y

operator : Jdec.Decoder Operator
operator =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Operator)

encodeOperator : Operator -> Jenc.Value
encodeOperator x =
    Jenc.object
        [
        ]

unionOptional : Jdec.Decoder UnionOptional
unionOptional =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOptional Jdec.float
        , Jdec.map OptionalInUnionOptional optional
        ]

encodeUnionOptional : UnionOptional -> Jenc.Value
encodeUnionOptional x = case x of
    DoubleInUnionOptional y -> Jenc.float y
    OptionalInUnionOptional y -> encodeOptional y

optional : Jdec.Decoder Optional
optional =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Optional)

encodeOptional : Optional -> Jenc.Value
encodeOptional x =
    Jenc.object
        [
        ]

unionOr : Jdec.Decoder UnionOr
unionOr =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOr Jdec.float
        , Jdec.map OrInUnionOr or
        ]

encodeUnionOr : UnionOr -> Jenc.Value
encodeUnionOr x = case x of
    DoubleInUnionOr y -> Jenc.float y
    OrInUnionOr y -> encodeOr y

or : Jdec.Decoder Or
or =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Or)

encodeOr : Or -> Jenc.Value
encodeOr x =
    Jenc.object
        [
        ]

unionOrEq : Jdec.Decoder UnionOrEq
unionOrEq =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOrEq Jdec.float
        , Jdec.map OrEqInUnionOrEq orEq
        ]

encodeUnionOrEq : UnionOrEq -> Jenc.Value
encodeUnionOrEq x = case x of
    DoubleInUnionOrEq y -> Jenc.float y
    OrEqInUnionOrEq y -> encodeOrEq y

orEq : Jdec.Decoder OrEq
orEq =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> OrEq)

encodeOrEq : OrEq -> Jenc.Value
encodeOrEq x =
    Jenc.object
        [
        ]

unionOut : Jdec.Decoder UnionOut
unionOut =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOut Jdec.float
        , Jdec.map OutInUnionOut out
        ]

encodeUnionOut : UnionOut -> Jenc.Value
encodeUnionOut x = case x of
    DoubleInUnionOut y -> Jenc.float y
    OutInUnionOut y -> encodeOut y

out : Jdec.Decoder Out
out =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Out)

encodeOut : Out -> Jenc.Value
encodeOut x =
    Jenc.object
        [
        ]

unionOverride : Jdec.Decoder UnionOverride
unionOverride =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOverride Jdec.float
        , Jdec.map OverrideInUnionOverride override
        ]

encodeUnionOverride : UnionOverride -> Jenc.Value
encodeUnionOverride x = case x of
    DoubleInUnionOverride y -> Jenc.float y
    OverrideInUnionOverride y -> encodeOverride y

override : Jdec.Decoder Override
override =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Override)

encodeOverride : Override -> Jenc.Value
encodeOverride x =
    Jenc.object
        [
        ]

unionPackage : Jdec.Decoder UnionPackage
unionPackage =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPackage Jdec.float
        , Jdec.map PackageInUnionPackage package
        ]

encodeUnionPackage : UnionPackage -> Jenc.Value
encodeUnionPackage x = case x of
    DoubleInUnionPackage y -> Jenc.float y
    PackageInUnionPackage y -> encodePackage y

package : Jdec.Decoder Package
package =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Package)

encodePackage : Package -> Jenc.Value
encodePackage x =
    Jenc.object
        [
        ]

unionParams : Jdec.Decoder UnionParams
unionParams =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionParams Jdec.float
        , Jdec.map ParamsInUnionParams params
        ]

encodeUnionParams : UnionParams -> Jenc.Value
encodeUnionParams x = case x of
    DoubleInUnionParams y -> Jenc.float y
    ParamsInUnionParams y -> encodeParams y

params : Jdec.Decoder Params
params =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Params)

encodeParams : Params -> Jenc.Value
encodeParams x =
    Jenc.object
        [
        ]

unionPass : Jdec.Decoder UnionPass
unionPass =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPass Jdec.float
        , Jdec.map PassInUnionPass pass
        ]

encodeUnionPass : UnionPass -> Jenc.Value
encodeUnionPass x = case x of
    DoubleInUnionPass y -> Jenc.float y
    PassInUnionPass y -> encodePass y

pass : Jdec.Decoder Pass
pass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Pass)

encodePass : Pass -> Jenc.Value
encodePass x =
    Jenc.object
        [
        ]

unionPostfix : Jdec.Decoder UnionPostfix
unionPostfix =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPostfix Jdec.float
        , Jdec.map PostfixInUnionPostfix postfix
        ]

encodeUnionPostfix : UnionPostfix -> Jenc.Value
encodeUnionPostfix x = case x of
    DoubleInUnionPostfix y -> Jenc.float y
    PostfixInUnionPostfix y -> encodePostfix y

postfix : Jdec.Decoder Postfix
postfix =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Postfix)

encodePostfix : Postfix -> Jenc.Value
encodePostfix x =
    Jenc.object
        [
        ]

unionPrecedence : Jdec.Decoder UnionPrecedence
unionPrecedence =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrecedence Jdec.float
        , Jdec.map PrecedenceInUnionPrecedence precedence
        ]

encodeUnionPrecedence : UnionPrecedence -> Jenc.Value
encodeUnionPrecedence x = case x of
    DoubleInUnionPrecedence y -> Jenc.float y
    PrecedenceInUnionPrecedence y -> encodePrecedence y

precedence : Jdec.Decoder Precedence
precedence =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Precedence)

encodePrecedence : Precedence -> Jenc.Value
encodePrecedence x =
    Jenc.object
        [
        ]

unionPrefix : Jdec.Decoder UnionPrefix
unionPrefix =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrefix Jdec.float
        , Jdec.map PrefixInUnionPrefix prefix
        ]

encodeUnionPrefix : UnionPrefix -> Jenc.Value
encodeUnionPrefix x = case x of
    DoubleInUnionPrefix y -> Jenc.float y
    PrefixInUnionPrefix y -> encodePrefix y

prefix : Jdec.Decoder Prefix
prefix =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Prefix)

encodePrefix : Prefix -> Jenc.Value
encodePrefix x =
    Jenc.object
        [
        ]

unionPrimitiveKind : Jdec.Decoder UnionPrimitiveKind
unionPrimitiveKind =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrimitiveKind Jdec.float
        , Jdec.map PrimitiveKindInUnionPrimitiveKind primitiveKind
        ]

encodeUnionPrimitiveKind : UnionPrimitiveKind -> Jenc.Value
encodeUnionPrimitiveKind x = case x of
    DoubleInUnionPrimitiveKind y -> Jenc.float y
    PrimitiveKindInUnionPrimitiveKind y -> encodePrimitiveKind y

primitiveKind : Jdec.Decoder PrimitiveKind
primitiveKind =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> PrimitiveKind)

encodePrimitiveKind : PrimitiveKind -> Jenc.Value
encodePrimitiveKind x =
    Jenc.object
        [
        ]

unionPrint : Jdec.Decoder UnionPrint
unionPrint =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrint Jdec.float
        , Jdec.map PrintInUnionPrint print
        ]

encodeUnionPrint : UnionPrint -> Jenc.Value
encodeUnionPrint x = case x of
    DoubleInUnionPrint y -> Jenc.float y
    PrintInUnionPrint y -> encodePrint y

print : Jdec.Decoder Print
print =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Print)

encodePrint : Print -> Jenc.Value
encodePrint x =
    Jenc.object
        [
        ]

unionPrintMembers : Jdec.Decoder UnionPrintMembers
unionPrintMembers =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrintMembers Jdec.float
        , Jdec.map PrintMembersInUnionPrintMembers printMembers
        ]

encodeUnionPrintMembers : UnionPrintMembers -> Jenc.Value
encodeUnionPrintMembers x = case x of
    DoubleInUnionPrintMembers y -> Jenc.float y
    PrintMembersInUnionPrintMembers y -> encodePrintMembers y

printMembers : Jdec.Decoder PrintMembers
printMembers =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> PrintMembers)

encodePrintMembers : PrintMembers -> Jenc.Value
encodePrintMembers x =
    Jenc.object
        [
        ]

unionPrintf : Jdec.Decoder UnionPrintf
unionPrintf =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrintf Jdec.float
        , Jdec.map PrintfInUnionPrintf printf
        ]

encodeUnionPrintf : UnionPrintf -> Jenc.Value
encodeUnionPrintf x = case x of
    DoubleInUnionPrintf y -> Jenc.float y
    PrintfInUnionPrintf y -> encodePrintf y

printf : Jdec.Decoder Printf
printf =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Printf)

encodePrintf : Printf -> Jenc.Value
encodePrintf x =
    Jenc.object
        [
        ]

unionPrivate : Jdec.Decoder UnionPrivate
unionPrivate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPrivate Jdec.float
        , Jdec.map PrivateInUnionPrivate private
        ]

encodeUnionPrivate : UnionPrivate -> Jenc.Value
encodeUnionPrivate x = case x of
    DoubleInUnionPrivate y -> Jenc.float y
    PrivateInUnionPrivate y -> encodePrivate y

private : Jdec.Decoder Private
private =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Private)

encodePrivate : Private -> Jenc.Value
encodePrivate x =
    Jenc.object
        [
        ]

unionProtected : Jdec.Decoder UnionProtected
unionProtected =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionProtected Jdec.float
        , Jdec.map ProtectedInUnionProtected protected
        ]

encodeUnionProtected : UnionProtected -> Jenc.Value
encodeUnionProtected x = case x of
    DoubleInUnionProtected y -> Jenc.float y
    ProtectedInUnionProtected y -> encodeProtected y

protected : Jdec.Decoder Protected
protected =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Protected)

encodeProtected : Protected -> Jenc.Value
encodeProtected x =
    Jenc.object
        [
        ]

unionProtocol : Jdec.Decoder UnionProtocol
unionProtocol =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionProtocol Jdec.float
        , Jdec.map ProtocolInUnionProtocol protocol
        ]

encodeUnionProtocol : UnionProtocol -> Jenc.Value
encodeUnionProtocol x = case x of
    DoubleInUnionProtocol y -> Jenc.float y
    ProtocolInUnionProtocol y -> encodeProtocol y

protocol : Jdec.Decoder Protocol
protocol =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Protocol)

encodeProtocol : Protocol -> Jenc.Value
encodeProtocol x =
    Jenc.object
        [
        ]

unionPublic : Jdec.Decoder UnionPublic
unionPublic =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPublic Jdec.float
        , Jdec.map PublicInUnionPublic public
        ]

encodeUnionPublic : UnionPublic -> Jenc.Value
encodeUnionPublic x = case x of
    DoubleInUnionPublic y -> Jenc.float y
    PublicInUnionPublic y -> encodePublic y

public : Jdec.Decoder Public
public =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Public)

encodePublic : Public -> Jenc.Value
encodePublic x =
    Jenc.object
        [
        ]

unionBoolUnion : Jdec.Decoder UnionBoolUnion
unionBoolUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBoolUnion Jdec.float
        , Jdec.map UnionBoolBoolInUnionBoolUnion unionBoolBool
        ]

encodeUnionBoolUnion : UnionBoolUnion -> Jenc.Value
encodeUnionBoolUnion x = case x of
    DoubleInUnionBoolUnion y -> Jenc.float y
    UnionBoolBoolInUnionBoolUnion y -> encodeUnionBoolBool y

unionBoolBool : Jdec.Decoder UnionBoolBool
unionBoolBool =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UnionBoolBool)

encodeUnionBoolBool : UnionBoolBool -> Jenc.Value
encodeUnionBoolBool x =
    Jenc.object
        [
        ]

unionTypeUnion : Jdec.Decoder UnionTypeUnion
unionTypeUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypeUnion Jdec.float
        , Jdec.map TypeClassInUnionTypeUnion typeClass
        ]

encodeUnionTypeUnion : UnionTypeUnion -> Jenc.Value
encodeUnionTypeUnion x = case x of
    DoubleInUnionTypeUnion y -> Jenc.float y
    TypeClassInUnionTypeUnion y -> encodeTypeClass y

typeClass : Jdec.Decoder TypeClass
typeClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TypeClass)

encodeTypeClass : TypeClass -> Jenc.Value
encodeTypeClass x =
    Jenc.object
        [
        ]

unionAnyUnion : Jdec.Decoder UnionAnyUnion
unionAnyUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAnyUnion Jdec.float
        , Jdec.map AnyClassInUnionAnyUnion anyClass
        ]

encodeUnionAnyUnion : UnionAnyUnion -> Jenc.Value
encodeUnionAnyUnion x = case x of
    DoubleInUnionAnyUnion y -> Jenc.float y
    AnyClassInUnionAnyUnion y -> encodeAnyClass y

anyClass : Jdec.Decoder AnyClass
anyClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> AnyClass)

encodeAnyClass : AnyClass -> Jenc.Value
encodeAnyClass x =
    Jenc.object
        [
        ]

unionAs : Jdec.Decoder UnionAs
unionAs =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionAs Jdec.float
        , Jdec.map AsInUnionAs purpleAs
        ]

encodeUnionAs : UnionAs -> Jenc.Value
encodeUnionAs x = case x of
    DoubleInUnionAs y -> Jenc.float y
    AsInUnionAs y -> encodeAs y

purpleAs : Jdec.Decoder As
purpleAs =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> As)

encodeAs : As -> Jenc.Value
encodeAs x =
    Jenc.object
        [
        ]

unionBOOL : Jdec.Decoder UnionBOOL
unionBOOL =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBOOL Jdec.float
        , Jdec.map BoolInUnionBOOL purpleBool
        ]

encodeUnionBOOL : UnionBOOL -> Jenc.Value
encodeUnionBOOL x = case x of
    DoubleInUnionBOOL y -> Jenc.float y
    BoolInUnionBOOL y -> encodeBool y

purpleBool : Jdec.Decoder Bool
purpleBool =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Bool)

encodeBool : Bool -> Jenc.Value
encodeBool x =
    Jenc.object
        [
        ]

unionBool : Jdec.Decoder UnionBool
unionBool =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionBool Jdec.float
        , Jdec.map BoolClassInUnionBool boolClass
        ]

encodeUnionBool : UnionBool -> Jenc.Value
encodeUnionBool x = case x of
    DoubleInUnionBool y -> Jenc.float y
    BoolClassInUnionBool y -> encodeBoolClass y

boolClass : Jdec.Decoder BoolClass
boolClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> BoolClass)

encodeBoolClass : BoolClass -> Jenc.Value
encodeBoolClass x =
    Jenc.object
        [
        ]

unionCase : Jdec.Decoder UnionCase
unionCase =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionCase Jdec.float
        , Jdec.map CaseInUnionCase purpleCase
        ]

encodeUnionCase : UnionCase -> Jenc.Value
encodeUnionCase x = case x of
    DoubleInUnionCase y -> Jenc.float y
    CaseInUnionCase y -> encodeCase y

purpleCase : Jdec.Decoder Case
purpleCase =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Case)

encodeCase : Case -> Jenc.Value
encodeCase x =
    Jenc.object
        [
        ]

unionClassUnion : Jdec.Decoder UnionClassUnion
unionClassUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionClassUnion Jdec.float
        , Jdec.map ClassClassInUnionClassUnion classClass
        ]

encodeUnionClassUnion : UnionClassUnion -> Jenc.Value
encodeUnionClassUnion x = case x of
    DoubleInUnionClassUnion y -> Jenc.float y
    ClassClassInUnionClassUnion y -> encodeClassClass y

classClass : Jdec.Decoder ClassClass
classClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ClassClass)

encodeClassClass : ClassClass -> Jenc.Value
encodeClassClass x =
    Jenc.object
        [
        ]

unionDecoder : Jdec.Decoder UnionDecoder
unionDecoder =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionDecoder Jdec.float
        , Jdec.map DecoderInUnionDecoder purpleDecoder
        ]

encodeUnionDecoder : UnionDecoder -> Jenc.Value
encodeUnionDecoder x = case x of
    DoubleInUnionDecoder y -> Jenc.float y
    DecoderInUnionDecoder y -> encodeDecoder y

purpleDecoder : Jdec.Decoder Decoder
purpleDecoder =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Decoder)

encodeDecoder : Decoder -> Jenc.Value
encodeDecoder x =
    Jenc.object
        [
        ]

unionElse : Jdec.Decoder UnionElse
unionElse =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionElse Jdec.float
        , Jdec.map ElseInUnionElse purpleElse
        ]

encodeUnionElse : UnionElse -> Jenc.Value
encodeUnionElse x = case x of
    DoubleInUnionElse y -> Jenc.float y
    ElseInUnionElse y -> encodeElse y

purpleElse : Jdec.Decoder Else
purpleElse =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Else)

encodeElse : Else -> Jenc.Value
encodeElse x =
    Jenc.object
        [
        ]

unionExposing : Jdec.Decoder UnionExposing
unionExposing =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionExposing Jdec.float
        , Jdec.map ExposingInUnionExposing purpleExposing
        ]

encodeUnionExposing : UnionExposing -> Jenc.Value
encodeUnionExposing x = case x of
    DoubleInUnionExposing y -> Jenc.float y
    ExposingInUnionExposing y -> encodeExposing y

purpleExposing : Jdec.Decoder Exposing
purpleExposing =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Exposing)

encodeExposing : Exposing -> Jenc.Value
encodeExposing x =
    Jenc.object
        [
        ]

unionFalseUnion : Jdec.Decoder UnionFalseUnion
unionFalseUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFalseUnion Jdec.float
        , Jdec.map UnionFalseFalseInUnionFalseUnion unionFalseFalse
        ]

encodeUnionFalseUnion : UnionFalseUnion -> Jenc.Value
encodeUnionFalseUnion x = case x of
    DoubleInUnionFalseUnion y -> Jenc.float y
    UnionFalseFalseInUnionFalseUnion y -> encodeUnionFalseFalse y

unionFalseFalse : Jdec.Decoder UnionFalseFalse
unionFalseFalse =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UnionFalseFalse)

encodeUnionFalseFalse : UnionFalseFalse -> Jenc.Value
encodeUnionFalseFalse x =
    Jenc.object
        [
        ]

unionFloat : Jdec.Decoder UnionFloat
unionFloat =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionFloat Jdec.float
        , Jdec.map FloatClassInUnionFloat floatClass
        ]

encodeUnionFloat : UnionFloat -> Jenc.Value
encodeUnionFloat x = case x of
    DoubleInUnionFloat y -> Jenc.float y
    FloatClassInUnionFloat y -> encodeFloatClass y

floatClass : Jdec.Decoder FloatClass
floatClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FloatClass)

encodeFloatClass : FloatClass -> Jenc.Value
encodeFloatClass x =
    Jenc.object
        [
        ]

unionIf : Jdec.Decoder UnionIf
unionIf =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIf Jdec.float
        , Jdec.map IfInUnionIf purpleIf
        ]

encodeUnionIf : UnionIf -> Jenc.Value
encodeUnionIf x = case x of
    DoubleInUnionIf y -> Jenc.float y
    IfInUnionIf y -> encodeIf y

purpleIf : Jdec.Decoder If
purpleIf =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> If)

encodeIf : If -> Jenc.Value
encodeIf x =
    Jenc.object
        [
        ]

unionImport : Jdec.Decoder UnionImport
unionImport =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionImport Jdec.float
        , Jdec.map ImportInUnionImport purpleImport
        ]

encodeUnionImport : UnionImport -> Jenc.Value
encodeUnionImport x = case x of
    DoubleInUnionImport y -> Jenc.float y
    ImportInUnionImport y -> encodeImport y

purpleImport : Jdec.Decoder Import
purpleImport =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Import)

encodeImport : Import -> Jenc.Value
encodeImport x =
    Jenc.object
        [
        ]

unionIn : Jdec.Decoder UnionIn
unionIn =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionIn Jdec.float
        , Jdec.map InInUnionIn purpleIn
        ]

encodeUnionIn : UnionIn -> Jenc.Value
encodeUnionIn x = case x of
    DoubleInUnionIn y -> Jenc.float y
    InInUnionIn y -> encodeIn y

purpleIn : Jdec.Decoder In
purpleIn =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> In)

encodeIn : In -> Jenc.Value
encodeIn x =
    Jenc.object
        [
        ]

unionInfix : Jdec.Decoder UnionInfix
unionInfix =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInfix Jdec.float
        , Jdec.map InfixInUnionInfix purpleInfix
        ]

encodeUnionInfix : UnionInfix -> Jenc.Value
encodeUnionInfix x = case x of
    DoubleInUnionInfix y -> Jenc.float y
    InfixInUnionInfix y -> encodeInfix y

purpleInfix : Jdec.Decoder Infix
purpleInfix =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Infix)

encodeInfix : Infix -> Jenc.Value
encodeInfix x =
    Jenc.object
        [
        ]

unionInt : Jdec.Decoder UnionInt
unionInt =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionInt Jdec.float
        , Jdec.map IntClassInUnionInt intClass
        ]

encodeUnionInt : UnionInt -> Jenc.Value
encodeUnionInt x = case x of
    DoubleInUnionInt y -> Jenc.float y
    IntClassInUnionInt y -> encodeIntClass y

intClass : Jdec.Decoder IntClass
intClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> IntClass)

encodeIntClass : IntClass -> Jenc.Value
encodeIntClass x =
    Jenc.object
        [
        ]

unionLet : Jdec.Decoder UnionLet
unionLet =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionLet Jdec.float
        , Jdec.map LetInUnionLet purpleLet
        ]

encodeUnionLet : UnionLet -> Jenc.Value
encodeUnionLet x = case x of
    DoubleInUnionLet y -> Jenc.float y
    LetInUnionLet y -> encodeLet y

purpleLet : Jdec.Decoder Let
purpleLet =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Let)

encodeLet : Let -> Jenc.Value
encodeLet x =
    Jenc.object
        [
        ]

unionModule : Jdec.Decoder UnionModule
unionModule =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionModule Jdec.float
        , Jdec.map ModuleInUnionModule purpleModule
        ]

encodeUnionModule : UnionModule -> Jenc.Value
encodeUnionModule x = case x of
    DoubleInUnionModule y -> Jenc.float y
    ModuleInUnionModule y -> encodeModule y

purpleModule : Jdec.Decoder Module
purpleModule =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Module)

encodeModule : Module -> Jenc.Value
encodeModule x =
    Jenc.object
        [
        ]

unionNoneUnion : Jdec.Decoder UnionNoneUnion
unionNoneUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNoneUnion Jdec.float
        , Jdec.map NoneClassInUnionNoneUnion noneClass
        ]

encodeUnionNoneUnion : UnionNoneUnion -> Jenc.Value
encodeUnionNoneUnion x = case x of
    DoubleInUnionNoneUnion y -> Jenc.float y
    NoneClassInUnionNoneUnion y -> encodeNoneClass y

noneClass : Jdec.Decoder NoneClass
noneClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NoneClass)

encodeNoneClass : NoneClass -> Jenc.Value
encodeNoneClass x =
    Jenc.object
        [
        ]

unionNull : Jdec.Decoder UnionNull
unionNull =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionNull Jdec.float
        , Jdec.map NullClassInUnionNull nullClass
        ]

encodeUnionNull : UnionNull -> Jenc.Value
encodeUnionNull x = case x of
    DoubleInUnionNull y -> Jenc.float y
    NullClassInUnionNull y -> encodeNullClass y

nullClass : Jdec.Decoder NullClass
nullClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NullClass)

encodeNullClass : NullClass -> Jenc.Value
encodeNullClass x =
    Jenc.object
        [
        ]

unionOf : Jdec.Decoder UnionOf
unionOf =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionOf Jdec.float
        , Jdec.map OfInUnionOf purpleOf
        ]

encodeUnionOf : UnionOf -> Jenc.Value
encodeUnionOf x = case x of
    DoubleInUnionOf y -> Jenc.float y
    OfInUnionOf y -> encodeOf y

purpleOf : Jdec.Decoder Of
purpleOf =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Of)

encodeOf : Of -> Jenc.Value
encodeOf x =
    Jenc.object
        [
        ]

unionPort : Jdec.Decoder UnionPort
unionPort =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionPort Jdec.float
        , Jdec.map PortInUnionPort purplePort
        ]

encodeUnionPort : UnionPort -> Jenc.Value
encodeUnionPort x = case x of
    DoubleInUnionPort y -> Jenc.float y
    PortInUnionPort y -> encodePort y

purplePort : Jdec.Decoder Port
purplePort =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Port)

encodePort : Port -> Jenc.Value
encodePort x =
    Jenc.object
        [
        ]

unionProtocolUnion : Jdec.Decoder UnionProtocolUnion
unionProtocolUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionProtocolUnion Jdec.float
        , Jdec.map ProtocolClassInUnionProtocolUnion protocolClass
        ]

encodeUnionProtocolUnion : UnionProtocolUnion -> Jenc.Value
encodeUnionProtocolUnion x = case x of
    DoubleInUnionProtocolUnion y -> Jenc.float y
    ProtocolClassInUnionProtocolUnion y -> encodeProtocolClass y

protocolClass : Jdec.Decoder ProtocolClass
protocolClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ProtocolClass)

encodeProtocolClass : ProtocolClass -> Jenc.Value
encodeProtocolClass x =
    Jenc.object
        [
        ]

unionSelfUnion : Jdec.Decoder UnionSelfUnion
unionSelfUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSelfUnion Jdec.float
        , Jdec.map SelfClassInUnionSelfUnion selfClass
        ]

encodeUnionSelfUnion : UnionSelfUnion -> Jenc.Value
encodeUnionSelfUnion x = case x of
    DoubleInUnionSelfUnion y -> Jenc.float y
    SelfClassInUnionSelfUnion y -> encodeSelfClass y

selfClass : Jdec.Decoder SelfClass
selfClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SelfClass)

encodeSelfClass : SelfClass -> Jenc.Value
encodeSelfClass x =
    Jenc.object
        [
        ]

unionString : Jdec.Decoder UnionString
unionString =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionString Jdec.float
        , Jdec.map StringClassInUnionString stringClass
        ]

encodeUnionString : UnionString -> Jenc.Value
encodeUnionString x = case x of
    DoubleInUnionString y -> Jenc.float y
    StringClassInUnionString y -> encodeStringClass y

stringClass : Jdec.Decoder StringClass
stringClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> StringClass)

encodeStringClass : StringClass -> Jenc.Value
encodeStringClass x =
    Jenc.object
        [
        ]

unionThen : Jdec.Decoder UnionThen
unionThen =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionThen Jdec.float
        , Jdec.map ThenInUnionThen purpleThen
        ]

encodeUnionThen : UnionThen -> Jenc.Value
encodeUnionThen x = case x of
    DoubleInUnionThen y -> Jenc.float y
    ThenInUnionThen y -> encodeThen y

purpleThen : Jdec.Decoder Then
purpleThen =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Then)

encodeThen : Then -> Jenc.Value
encodeThen x =
    Jenc.object
        [
        ]

unionTrueUnion : Jdec.Decoder UnionTrueUnion
unionTrueUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTrueUnion Jdec.float
        , Jdec.map UnionTrueTrueInUnionTrueUnion unionTrueTrue
        ]

encodeUnionTrueUnion : UnionTrueUnion -> Jenc.Value
encodeUnionTrueUnion x = case x of
    DoubleInUnionTrueUnion y -> Jenc.float y
    UnionTrueTrueInUnionTrueUnion y -> encodeUnionTrueTrue y

unionTrueTrue : Jdec.Decoder UnionTrueTrue
unionTrueTrue =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UnionTrueTrue)

encodeUnionTrueTrue : UnionTrueTrue -> Jenc.Value
encodeUnionTrueTrue x =
    Jenc.object
        [
        ]

unionType : Jdec.Decoder UnionType
unionType =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionType Jdec.float
        , Jdec.map TypeInUnionType purpleType
        ]

encodeUnionType : UnionType -> Jenc.Value
encodeUnionType x = case x of
    DoubleInUnionType y -> Jenc.float y
    TypeInUnionType y -> encodeType y

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Type)

encodeType : Type -> Jenc.Value
encodeType x =
    Jenc.object
        [
        ]

unionWhere : Jdec.Decoder UnionWhere
unionWhere =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWhere Jdec.float
        , Jdec.map WhereInUnionWhere purpleWhere
        ]

encodeUnionWhere : UnionWhere -> Jenc.Value
encodeUnionWhere x = case x of
    DoubleInUnionWhere y -> Jenc.float y
    WhereInUnionWhere y -> encodeWhere y

purpleWhere : Jdec.Decoder Where
purpleWhere =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Where)

encodeWhere : Where -> Jenc.Value
encodeWhere x =
    Jenc.object
        [
        ]

unionQuicktype : Jdec.Decoder UnionQuicktype
unionQuicktype =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionQuicktype Jdec.float
        , Jdec.map QuicktypeInUnionQuicktype quicktype
        ]

encodeUnionQuicktype : UnionQuicktype -> Jenc.Value
encodeUnionQuicktype x = case x of
    DoubleInUnionQuicktype y -> Jenc.float y
    QuicktypeInUnionQuicktype y -> encodeQuicktype y

quicktype : Jdec.Decoder Quicktype
quicktype =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Quicktype)

encodeQuicktype : Quicktype -> Jenc.Value
encodeQuicktype x =
    Jenc.object
        [
        ]

unionRaise : Jdec.Decoder UnionRaise
unionRaise =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRaise Jdec.float
        , Jdec.map RaiseInUnionRaise raise
        ]

encodeUnionRaise : UnionRaise -> Jenc.Value
encodeUnionRaise x = case x of
    DoubleInUnionRaise y -> Jenc.float y
    RaiseInUnionRaise y -> encodeRaise y

raise : Jdec.Decoder Raise
raise =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Raise)

encodeRaise : Raise -> Jenc.Value
encodeRaise x =
    Jenc.object
        [
        ]

unionRange : Jdec.Decoder UnionRange
unionRange =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRange Jdec.float
        , Jdec.map RangeInUnionRange range
        ]

encodeUnionRange : UnionRange -> Jenc.Value
encodeUnionRange x = case x of
    DoubleInUnionRange y -> Jenc.float y
    RangeInUnionRange y -> encodeRange y

range : Jdec.Decoder Range
range =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Range)

encodeRange : Range -> Jenc.Value
encodeRange x =
    Jenc.object
        [
        ]

unionReadonly : Jdec.Decoder UnionReadonly
unionReadonly =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionReadonly Jdec.float
        , Jdec.map ReadonlyInUnionReadonly readonly
        ]

encodeUnionReadonly : UnionReadonly -> Jenc.Value
encodeUnionReadonly x = case x of
    DoubleInUnionReadonly y -> Jenc.float y
    ReadonlyInUnionReadonly y -> encodeReadonly y

readonly : Jdec.Decoder Readonly
readonly =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Readonly)

encodeReadonly : Readonly -> Jenc.Value
encodeReadonly x =
    Jenc.object
        [
        ]

unionRef : Jdec.Decoder UnionRef
unionRef =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRef Jdec.float
        , Jdec.map RefInUnionRef ref
        ]

encodeUnionRef : UnionRef -> Jenc.Value
encodeUnionRef x = case x of
    DoubleInUnionRef y -> Jenc.float y
    RefInUnionRef y -> encodeRef y

ref : Jdec.Decoder Ref
ref =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Ref)

encodeRef : Ref -> Jenc.Value
encodeRef x =
    Jenc.object
        [
        ]

unionRegExp : Jdec.Decoder UnionRegExp
unionRegExp =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRegExp Jdec.float
        , Jdec.map RegExpInUnionRegExp regExp
        ]

encodeUnionRegExp : UnionRegExp -> Jenc.Value
encodeUnionRegExp x = case x of
    DoubleInUnionRegExp y -> Jenc.float y
    RegExpInUnionRegExp y -> encodeRegExp y

regExp : Jdec.Decoder RegExp
regExp =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> RegExp)

encodeRegExp : RegExp -> Jenc.Value
encodeRegExp x =
    Jenc.object
        [
        ]

unionRegister : Jdec.Decoder UnionRegister
unionRegister =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRegister Jdec.float
        , Jdec.map RegisterInUnionRegister register
        ]

encodeUnionRegister : UnionRegister -> Jenc.Value
encodeUnionRegister x = case x of
    DoubleInUnionRegister y -> Jenc.float y
    RegisterInUnionRegister y -> encodeRegister y

register : Jdec.Decoder Register
register =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Register)

encodeRegister : Register -> Jenc.Value
encodeRegister x =
    Jenc.object
        [
        ]

unionReinterpretCast : Jdec.Decoder UnionReinterpretCast
unionReinterpretCast =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionReinterpretCast Jdec.float
        , Jdec.map ReinterpretCastInUnionReinterpretCast reinterpretCast
        ]

encodeUnionReinterpretCast : UnionReinterpretCast -> Jenc.Value
encodeUnionReinterpretCast x = case x of
    DoubleInUnionReinterpretCast y -> Jenc.float y
    ReinterpretCastInUnionReinterpretCast y -> encodeReinterpretCast y

reinterpretCast : Jdec.Decoder ReinterpretCast
reinterpretCast =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ReinterpretCast)

encodeReinterpretCast : ReinterpretCast -> Jenc.Value
encodeReinterpretCast x =
    Jenc.object
        [
        ]

unionRepeat : Jdec.Decoder UnionRepeat
unionRepeat =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRepeat Jdec.float
        , Jdec.map RepeatInUnionRepeat repeat
        ]

encodeUnionRepeat : UnionRepeat -> Jenc.Value
encodeUnionRepeat x = case x of
    DoubleInUnionRepeat y -> Jenc.float y
    RepeatInUnionRepeat y -> encodeRepeat y

repeat : Jdec.Decoder Repeat
repeat =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Repeat)

encodeRepeat : Repeat -> Jenc.Value
encodeRepeat x =
    Jenc.object
        [
        ]

unionRequire : Jdec.Decoder UnionRequire
unionRequire =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRequire Jdec.float
        , Jdec.map RequireInUnionRequire require
        ]

encodeUnionRequire : UnionRequire -> Jenc.Value
encodeUnionRequire x = case x of
    DoubleInUnionRequire y -> Jenc.float y
    RequireInUnionRequire y -> encodeRequire y

require : Jdec.Decoder Require
require =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Require)

encodeRequire : Require -> Jenc.Value
encodeRequire x =
    Jenc.object
        [
        ]

unionRequired : Jdec.Decoder UnionRequired
unionRequired =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRequired Jdec.float
        , Jdec.map RequiredInUnionRequired required
        ]

encodeUnionRequired : UnionRequired -> Jenc.Value
encodeUnionRequired x = case x of
    DoubleInUnionRequired y -> Jenc.float y
    RequiredInUnionRequired y -> encodeRequired y

required : Jdec.Decoder Required
required =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Required)

encodeRequired : Required -> Jenc.Value
encodeRequired x =
    Jenc.object
        [
        ]

unionRequires : Jdec.Decoder UnionRequires
unionRequires =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRequires Jdec.float
        , Jdec.map RequiresInUnionRequires requires
        ]

encodeUnionRequires : UnionRequires -> Jenc.Value
encodeUnionRequires x = case x of
    DoubleInUnionRequires y -> Jenc.float y
    RequiresInUnionRequires y -> encodeRequires y

requires : Jdec.Decoder Requires
requires =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Requires)

encodeRequires : Requires -> Jenc.Value
encodeRequires x =
    Jenc.object
        [
        ]

unionRestrict : Jdec.Decoder UnionRestrict
unionRestrict =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRestrict Jdec.float
        , Jdec.map RestrictInUnionRestrict restrict
        ]

encodeUnionRestrict : UnionRestrict -> Jenc.Value
encodeUnionRestrict x = case x of
    DoubleInUnionRestrict y -> Jenc.float y
    RestrictInUnionRestrict y -> encodeRestrict y

restrict : Jdec.Decoder Restrict
restrict =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Restrict)

encodeRestrict : Restrict -> Jenc.Value
encodeRestrict x =
    Jenc.object
        [
        ]

unionRetain : Jdec.Decoder UnionRetain
unionRetain =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRetain Jdec.float
        , Jdec.map RetainInUnionRetain retain
        ]

encodeUnionRetain : UnionRetain -> Jenc.Value
encodeUnionRetain x = case x of
    DoubleInUnionRetain y -> Jenc.float y
    RetainInUnionRetain y -> encodeRetain y

retain : Jdec.Decoder Retain
retain =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Retain)

encodeRetain : Retain -> Jenc.Value
encodeRetain x =
    Jenc.object
        [
        ]

unionRethrows : Jdec.Decoder UnionRethrows
unionRethrows =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRethrows Jdec.float
        , Jdec.map RethrowsInUnionRethrows rethrows
        ]

encodeUnionRethrows : UnionRethrows -> Jenc.Value
encodeUnionRethrows x = case x of
    DoubleInUnionRethrows y -> Jenc.float y
    RethrowsInUnionRethrows y -> encodeRethrows y

rethrows : Jdec.Decoder Rethrows
rethrows =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Rethrows)

encodeRethrows : Rethrows -> Jenc.Value
encodeRethrows x =
    Jenc.object
        [
        ]

unionReturn : Jdec.Decoder UnionReturn
unionReturn =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionReturn Jdec.float
        , Jdec.map ReturnInUnionReturn return
        ]

encodeUnionReturn : UnionReturn -> Jenc.Value
encodeUnionReturn x = case x of
    DoubleInUnionReturn y -> Jenc.float y
    ReturnInUnionReturn y -> encodeReturn y

return : Jdec.Decoder Return
return =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Return)

encodeReturn : Return -> Jenc.Value
encodeReturn x =
    Jenc.object
        [
        ]

unionRight : Jdec.Decoder UnionRight
unionRight =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRight Jdec.float
        , Jdec.map RightInUnionRight right
        ]

encodeUnionRight : UnionRight -> Jenc.Value
encodeUnionRight x = case x of
    DoubleInUnionRight y -> Jenc.float y
    RightInUnionRight y -> encodeRight y

right : Jdec.Decoder Right
right =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Right)

encodeRight : Right -> Jenc.Value
encodeRight x =
    Jenc.object
        [
        ]

unionRuntimeType : Jdec.Decoder UnionRuntimeType
unionRuntimeType =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionRuntimeType Jdec.float
        , Jdec.map RuntimeTypeInUnionRuntimeType runtimeType
        ]

encodeUnionRuntimeType : UnionRuntimeType -> Jenc.Value
encodeUnionRuntimeType x = case x of
    DoubleInUnionRuntimeType y -> Jenc.float y
    RuntimeTypeInUnionRuntimeType y -> encodeRuntimeType y

runtimeType : Jdec.Decoder RuntimeType
runtimeType =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> RuntimeType)

encodeRuntimeType : RuntimeType -> Jenc.Value
encodeRuntimeType x =
    Jenc.object
        [
        ]

unionS : Jdec.Decoder UnionS
unionS =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionS Jdec.float
        , Jdec.map SInUnionS s
        ]

encodeUnionS : UnionS -> Jenc.Value
encodeUnionS x = case x of
    DoubleInUnionS y -> Jenc.float y
    SInUnionS y -> encodeS y

s : Jdec.Decoder S
s =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> S)

encodeS : S -> Jenc.Value
encodeS x =
    Jenc.object
        [
        ]

unionSbyte : Jdec.Decoder UnionSbyte
unionSbyte =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSbyte Jdec.float
        , Jdec.map SbyteInUnionSbyte sbyte
        ]

encodeUnionSbyte : UnionSbyte -> Jenc.Value
encodeUnionSbyte x = case x of
    DoubleInUnionSbyte y -> Jenc.float y
    SbyteInUnionSbyte y -> encodeSbyte y

sbyte : Jdec.Decoder Sbyte
sbyte =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Sbyte)

encodeSbyte : Sbyte -> Jenc.Value
encodeSbyte x =
    Jenc.object
        [
        ]

unionSealed : Jdec.Decoder UnionSealed
unionSealed =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSealed Jdec.float
        , Jdec.map SealedInUnionSealed sealed
        ]

encodeUnionSealed : UnionSealed -> Jenc.Value
encodeUnionSealed x = case x of
    DoubleInUnionSealed y -> Jenc.float y
    SealedInUnionSealed y -> encodeSealed y

sealed : Jdec.Decoder Sealed
sealed =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Sealed)

encodeSealed : Sealed -> Jenc.Value
encodeSealed x =
    Jenc.object
        [
        ]

unionSEL : Jdec.Decoder UnionSEL
unionSEL =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSEL Jdec.float
        , Jdec.map SelInUnionSEL sel
        ]

encodeUnionSEL : UnionSEL -> Jenc.Value
encodeUnionSEL x = case x of
    DoubleInUnionSEL y -> Jenc.float y
    SelInUnionSEL y -> encodeSel y

sel : Jdec.Decoder Sel
sel =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Sel)

encodeSel : Sel -> Jenc.Value
encodeSel x =
    Jenc.object
        [
        ]

unionSelect : Jdec.Decoder UnionSelect
unionSelect =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSelect Jdec.float
        , Jdec.map SelectInUnionSelect select
        ]

encodeUnionSelect : UnionSelect -> Jenc.Value
encodeUnionSelect x = case x of
    DoubleInUnionSelect y -> Jenc.float y
    SelectInUnionSelect y -> encodeSelect y

select : Jdec.Decoder Select
select =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Select)

encodeSelect : Select -> Jenc.Value
encodeSelect x =
    Jenc.object
        [
        ]

unionSelf : Jdec.Decoder UnionSelf
unionSelf =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSelf Jdec.float
        , Jdec.map SelfInUnionSelf self
        ]

encodeUnionSelf : UnionSelf -> Jenc.Value
encodeUnionSelf x = case x of
    DoubleInUnionSelf y -> Jenc.float y
    SelfInUnionSelf y -> encodeSelf y

self : Jdec.Decoder Self
self =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Self)

encodeSelf : Self -> Jenc.Value
encodeSelf x =
    Jenc.object
        [
        ]

unionSendable : Jdec.Decoder UnionSendable
unionSendable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSendable Jdec.float
        , Jdec.map SendableInUnionSendable sendable
        ]

encodeUnionSendable : UnionSendable -> Jenc.Value
encodeUnionSendable x = case x of
    DoubleInUnionSendable y -> Jenc.float y
    SendableInUnionSendable y -> encodeSendable y

sendable : Jdec.Decoder Sendable
sendable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Sendable)

encodeSendable : Sendable -> Jenc.Value
encodeSendable x =
    Jenc.object
        [
        ]

unionSerialDescriptor : Jdec.Decoder UnionSerialDescriptor
unionSerialDescriptor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerialDescriptor Jdec.float
        , Jdec.map SerialDescriptorInUnionSerialDescriptor serialDescriptor
        ]

encodeUnionSerialDescriptor : UnionSerialDescriptor -> Jenc.Value
encodeUnionSerialDescriptor x = case x of
    DoubleInUnionSerialDescriptor y -> Jenc.float y
    SerialDescriptorInUnionSerialDescriptor y -> encodeSerialDescriptor y

serialDescriptor : Jdec.Decoder SerialDescriptor
serialDescriptor =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SerialDescriptor)

encodeSerialDescriptor : SerialDescriptor -> Jenc.Value
encodeSerialDescriptor x =
    Jenc.object
        [
        ]

unionSerialName : Jdec.Decoder UnionSerialName
unionSerialName =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerialName Jdec.float
        , Jdec.map SerialNameInUnionSerialName serialName
        ]

encodeUnionSerialName : UnionSerialName -> Jenc.Value
encodeUnionSerialName x = case x of
    DoubleInUnionSerialName y -> Jenc.float y
    SerialNameInUnionSerialName y -> encodeSerialName y

serialName : Jdec.Decoder SerialName
serialName =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SerialName)

encodeSerialName : SerialName -> Jenc.Value
encodeSerialName x =
    Jenc.object
        [
        ]

unionSerializable : Jdec.Decoder UnionSerializable
unionSerializable =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerializable Jdec.float
        , Jdec.map SerializableInUnionSerializable serializable
        ]

encodeUnionSerializable : UnionSerializable -> Jenc.Value
encodeUnionSerializable x = case x of
    DoubleInUnionSerializable y -> Jenc.float y
    SerializableInUnionSerializable y -> encodeSerializable y

serializable : Jdec.Decoder Serializable
serializable =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Serializable)

encodeSerializable : Serializable -> Jenc.Value
encodeSerializable x =
    Jenc.object
        [
        ]

unionSerializationFeature : Jdec.Decoder UnionSerializationFeature
unionSerializationFeature =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerializationFeature Jdec.float
        , Jdec.map SerializationFeatureInUnionSerializationFeature serializationFeature
        ]

encodeUnionSerializationFeature : UnionSerializationFeature -> Jenc.Value
encodeUnionSerializationFeature x = case x of
    DoubleInUnionSerializationFeature y -> Jenc.float y
    SerializationFeatureInUnionSerializationFeature y -> encodeSerializationFeature y

serializationFeature : Jdec.Decoder SerializationFeature
serializationFeature =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SerializationFeature)

encodeSerializationFeature : SerializationFeature -> Jenc.Value
encodeSerializationFeature x =
    Jenc.object
        [
        ]

unionSerialize : Jdec.Decoder UnionSerialize
unionSerialize =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerialize Jdec.float
        , Jdec.map SerializeInUnionSerialize serialize
        ]

encodeUnionSerialize : UnionSerialize -> Jenc.Value
encodeUnionSerialize x = case x of
    DoubleInUnionSerialize y -> Jenc.float y
    SerializeInUnionSerialize y -> encodeSerialize y

serialize : Jdec.Decoder Serialize
serialize =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Serialize)

encodeSerialize : Serialize -> Jenc.Value
encodeSerialize x =
    Jenc.object
        [
        ]

unionSerializerProvider : Jdec.Decoder UnionSerializerProvider
unionSerializerProvider =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSerializerProvider Jdec.float
        , Jdec.map SerializerProviderInUnionSerializerProvider serializerProvider
        ]

encodeUnionSerializerProvider : UnionSerializerProvider -> Jenc.Value
encodeUnionSerializerProvider x = case x of
    DoubleInUnionSerializerProvider y -> Jenc.float y
    SerializerProviderInUnionSerializerProvider y -> encodeSerializerProvider y

serializerProvider : Jdec.Decoder SerializerProvider
serializerProvider =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SerializerProvider)

encodeSerializerProvider : SerializerProvider -> Jenc.Value
encodeSerializerProvider x =
    Jenc.object
        [
        ]

unionSet : Jdec.Decoder UnionSet
unionSet =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSet Jdec.float
        , Jdec.map SetInUnionSet set
        ]

encodeUnionSet : UnionSet -> Jenc.Value
encodeUnionSet x = case x of
    DoubleInUnionSet y -> Jenc.float y
    SetInUnionSet y -> encodeSet y

set : Jdec.Decoder Set
set =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Set)

encodeSet : Set -> Jenc.Value
encodeSet x =
    Jenc.object
        [
        ]

unionShort : Jdec.Decoder UnionShort
unionShort =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionShort Jdec.float
        , Jdec.map ShortInUnionShort short
        ]

encodeUnionShort : UnionShort -> Jenc.Value
encodeUnionShort x = case x of
    DoubleInUnionShort y -> Jenc.float y
    ShortInUnionShort y -> encodeShort y

short : Jdec.Decoder Short
short =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Short)

encodeShort : Short -> Jenc.Value
encodeShort x =
    Jenc.object
        [
        ]

unionSigned : Jdec.Decoder UnionSigned
unionSigned =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSigned Jdec.float
        , Jdec.map SignedInUnionSigned signed
        ]

encodeUnionSigned : UnionSigned -> Jenc.Value
encodeUnionSigned x = case x of
    DoubleInUnionSigned y -> Jenc.float y
    SignedInUnionSigned y -> encodeSigned y

signed : Jdec.Decoder Signed
signed =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Signed)

encodeSigned : Signed -> Jenc.Value
encodeSigned x =
    Jenc.object
        [
        ]

unionSimpleModule : Jdec.Decoder UnionSimpleModule
unionSimpleModule =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSimpleModule Jdec.float
        , Jdec.map SimpleModuleInUnionSimpleModule simpleModule
        ]

encodeUnionSimpleModule : UnionSimpleModule -> Jenc.Value
encodeUnionSimpleModule x = case x of
    DoubleInUnionSimpleModule y -> Jenc.float y
    SimpleModuleInUnionSimpleModule y -> encodeSimpleModule y

simpleModule : Jdec.Decoder SimpleModule
simpleModule =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> SimpleModule)

encodeSimpleModule : SimpleModule -> Jenc.Value
encodeSimpleModule x =
    Jenc.object
        [
        ]

unionSizeof : Jdec.Decoder UnionSizeof
unionSizeof =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSizeof Jdec.float
        , Jdec.map SizeofInUnionSizeof sizeof
        ]

encodeUnionSizeof : UnionSizeof -> Jenc.Value
encodeUnionSizeof x = case x of
    DoubleInUnionSizeof y -> Jenc.float y
    SizeofInUnionSizeof y -> encodeSizeof y

sizeof : Jdec.Decoder Sizeof
sizeof =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Sizeof)

encodeSizeof : Sizeof -> Jenc.Value
encodeSizeof x =
    Jenc.object
        [
        ]

unionStackalloc : Jdec.Decoder UnionStackalloc
unionStackalloc =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStackalloc Jdec.float
        , Jdec.map StackallocInUnionStackalloc stackalloc
        ]

encodeUnionStackalloc : UnionStackalloc -> Jenc.Value
encodeUnionStackalloc x = case x of
    DoubleInUnionStackalloc y -> Jenc.float y
    StackallocInUnionStackalloc y -> encodeStackalloc y

stackalloc : Jdec.Decoder Stackalloc
stackalloc =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Stackalloc)

encodeStackalloc : Stackalloc -> Jenc.Value
encodeStackalloc x =
    Jenc.object
        [
        ]

unionStandards : Jdec.Decoder UnionStandards
unionStandards =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStandards Jdec.float
        , Jdec.map StandardsInUnionStandards standards
        ]

encodeUnionStandards : UnionStandards -> Jenc.Value
encodeUnionStandards x = case x of
    DoubleInUnionStandards y -> Jenc.float y
    StandardsInUnionStandards y -> encodeStandards y

standards : Jdec.Decoder Standards
standards =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Standards)

encodeStandards : Standards -> Jenc.Value
encodeStandards x =
    Jenc.object
        [
        ]

unionStatic : Jdec.Decoder UnionStatic
unionStatic =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStatic Jdec.float
        , Jdec.map StaticInUnionStatic static
        ]

encodeUnionStatic : UnionStatic -> Jenc.Value
encodeUnionStatic x = case x of
    DoubleInUnionStatic y -> Jenc.float y
    StaticInUnionStatic y -> encodeStatic y

static : Jdec.Decoder Static
static =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Static)

encodeStatic : Static -> Jenc.Value
encodeStatic x =
    Jenc.object
        [
        ]

unionStaticAssert : Jdec.Decoder UnionStaticAssert
unionStaticAssert =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStaticAssert Jdec.float
        , Jdec.map StaticAssertInUnionStaticAssert staticAssert
        ]

encodeUnionStaticAssert : UnionStaticAssert -> Jenc.Value
encodeUnionStaticAssert x = case x of
    DoubleInUnionStaticAssert y -> Jenc.float y
    StaticAssertInUnionStaticAssert y -> encodeStaticAssert y

staticAssert : Jdec.Decoder StaticAssert
staticAssert =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> StaticAssert)

encodeStaticAssert : StaticAssert -> Jenc.Value
encodeStaticAssert x =
    Jenc.object
        [
        ]

unionStaticCast : Jdec.Decoder UnionStaticCast
unionStaticCast =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStaticCast Jdec.float
        , Jdec.map StaticCastInUnionStaticCast staticCast
        ]

encodeUnionStaticCast : UnionStaticCast -> Jenc.Value
encodeUnionStaticCast x = case x of
    DoubleInUnionStaticCast y -> Jenc.float y
    StaticCastInUnionStaticCast y -> encodeStaticCast y

staticCast : Jdec.Decoder StaticCast
staticCast =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> StaticCast)

encodeStaticCast : StaticCast -> Jenc.Value
encodeStaticCast x =
    Jenc.object
        [
        ]

unionStdDeserializer : Jdec.Decoder UnionStdDeserializer
unionStdDeserializer =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStdDeserializer Jdec.float
        , Jdec.map StdDeserializerInUnionStdDeserializer stdDeserializer
        ]

encodeUnionStdDeserializer : UnionStdDeserializer -> Jenc.Value
encodeUnionStdDeserializer x = case x of
    DoubleInUnionStdDeserializer y -> Jenc.float y
    StdDeserializerInUnionStdDeserializer y -> encodeStdDeserializer y

stdDeserializer : Jdec.Decoder StdDeserializer
stdDeserializer =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> StdDeserializer)

encodeStdDeserializer : StdDeserializer -> Jenc.Value
encodeStdDeserializer x =
    Jenc.object
        [
        ]

unionStdSerializer : Jdec.Decoder UnionStdSerializer
unionStdSerializer =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStdSerializer Jdec.float
        , Jdec.map StdSerializerInUnionStdSerializer stdSerializer
        ]

encodeUnionStdSerializer : UnionStdSerializer -> Jenc.Value
encodeUnionStdSerializer x = case x of
    DoubleInUnionStdSerializer y -> Jenc.float y
    StdSerializerInUnionStdSerializer y -> encodeStdSerializer y

stdSerializer : Jdec.Decoder StdSerializer
stdSerializer =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> StdSerializer)

encodeStdSerializer : StdSerializer -> Jenc.Value
encodeStdSerializer x =
    Jenc.object
        [
        ]

unionStrictfp : Jdec.Decoder UnionStrictfp
unionStrictfp =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStrictfp Jdec.float
        , Jdec.map StrictfpInUnionStrictfp strictfp
        ]

encodeUnionStrictfp : UnionStrictfp -> Jenc.Value
encodeUnionStrictfp x = case x of
    DoubleInUnionStrictfp y -> Jenc.float y
    StrictfpInUnionStrictfp y -> encodeStrictfp y

strictfp : Jdec.Decoder Strictfp
strictfp =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Strictfp)

encodeStrictfp : Strictfp -> Jenc.Value
encodeStrictfp x =
    Jenc.object
        [
        ]

unionStruct : Jdec.Decoder UnionStruct
unionStruct =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionStruct Jdec.float
        , Jdec.map StructInUnionStruct struct
        ]

encodeUnionStruct : UnionStruct -> Jenc.Value
encodeUnionStruct x = case x of
    DoubleInUnionStruct y -> Jenc.float y
    StructInUnionStruct y -> encodeStruct y

struct : Jdec.Decoder Struct
struct =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Struct)

encodeStruct : Struct -> Jenc.Value
encodeStruct x =
    Jenc.object
        [
        ]

unionSubscript : Jdec.Decoder UnionSubscript
unionSubscript =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSubscript Jdec.float
        , Jdec.map SubscriptInUnionSubscript subscript
        ]

encodeUnionSubscript : UnionSubscript -> Jenc.Value
encodeUnionSubscript x = case x of
    DoubleInUnionSubscript y -> Jenc.float y
    SubscriptInUnionSubscript y -> encodeSubscript y

subscript : Jdec.Decoder Subscript
subscript =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Subscript)

encodeSubscript : Subscript -> Jenc.Value
encodeSubscript x =
    Jenc.object
        [
        ]

unionSuper : Jdec.Decoder UnionSuper
unionSuper =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSuper Jdec.float
        , Jdec.map SuperInUnionSuper super
        ]

encodeUnionSuper : UnionSuper -> Jenc.Value
encodeUnionSuper x = case x of
    DoubleInUnionSuper y -> Jenc.float y
    SuperInUnionSuper y -> encodeSuper y

super : Jdec.Decoder Super
super =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Super)

encodeSuper : Super -> Jenc.Value
encodeSuper x =
    Jenc.object
        [
        ]

unionSwitch : Jdec.Decoder UnionSwitch
unionSwitch =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSwitch Jdec.float
        , Jdec.map SwitchInUnionSwitch switch
        ]

encodeUnionSwitch : UnionSwitch -> Jenc.Value
encodeUnionSwitch x = case x of
    DoubleInUnionSwitch y -> Jenc.float y
    SwitchInUnionSwitch y -> encodeSwitch y

switch : Jdec.Decoder Switch
switch =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Switch)

encodeSwitch : Switch -> Jenc.Value
encodeSwitch x =
    Jenc.object
        [
        ]

unionSymbol : Jdec.Decoder UnionSymbol
unionSymbol =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSymbol Jdec.float
        , Jdec.map SymbolInUnionSymbol symbol
        ]

encodeUnionSymbol : UnionSymbol -> Jenc.Value
encodeUnionSymbol x = case x of
    DoubleInUnionSymbol y -> Jenc.float y
    SymbolInUnionSymbol y -> encodeSymbol y

symbol : Jdec.Decoder Symbol
symbol =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Symbol)

encodeSymbol : Symbol -> Jenc.Value
encodeSymbol x =
    Jenc.object
        [
        ]

unionSynchronized : Jdec.Decoder UnionSynchronized
unionSynchronized =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSynchronized Jdec.float
        , Jdec.map SynchronizedInUnionSynchronized synchronized
        ]

encodeUnionSynchronized : UnionSynchronized -> Jenc.Value
encodeUnionSynchronized x = case x of
    DoubleInUnionSynchronized y -> Jenc.float y
    SynchronizedInUnionSynchronized y -> encodeSynchronized y

synchronized : Jdec.Decoder Synchronized
synchronized =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Synchronized)

encodeSynchronized : Synchronized -> Jenc.Value
encodeSynchronized x =
    Jenc.object
        [
        ]

unionSystem : Jdec.Decoder UnionSystem
unionSystem =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionSystem Jdec.float
        , Jdec.map SystemInUnionSystem system
        ]

encodeUnionSystem : UnionSystem -> Jenc.Value
encodeUnionSystem x = case x of
    DoubleInUnionSystem y -> Jenc.float y
    SystemInUnionSystem y -> encodeSystem y

system : Jdec.Decoder System
system =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> System)

encodeSystem : System -> Jenc.Value
encodeSystem x =
    Jenc.object
        [
        ]

unionTemplate : Jdec.Decoder UnionTemplate
unionTemplate =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTemplate Jdec.float
        , Jdec.map TemplateInUnionTemplate template
        ]

encodeUnionTemplate : UnionTemplate -> Jenc.Value
encodeUnionTemplate x = case x of
    DoubleInUnionTemplate y -> Jenc.float y
    TemplateInUnionTemplate y -> encodeTemplate y

template : Jdec.Decoder Template
template =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Template)

encodeTemplate : Template -> Jenc.Value
encodeTemplate x =
    Jenc.object
        [
        ]

unionTextNode : Jdec.Decoder UnionTextNode
unionTextNode =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTextNode Jdec.float
        , Jdec.map TextNodeInUnionTextNode textNode
        ]

encodeUnionTextNode : UnionTextNode -> Jenc.Value
encodeUnionTextNode x = case x of
    DoubleInUnionTextNode y -> Jenc.float y
    TextNodeInUnionTextNode y -> encodeTextNode y

textNode : Jdec.Decoder TextNode
textNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TextNode)

encodeTextNode : TextNode -> Jenc.Value
encodeTextNode x =
    Jenc.object
        [
        ]

unionThis : Jdec.Decoder UnionThis
unionThis =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionThis Jdec.float
        , Jdec.map ThisInUnionThis this
        ]

encodeUnionThis : UnionThis -> Jenc.Value
encodeUnionThis x = case x of
    DoubleInUnionThis y -> Jenc.float y
    ThisInUnionThis y -> encodeThis y

this : Jdec.Decoder This
this =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> This)

encodeThis : This -> Jenc.Value
encodeThis x =
    Jenc.object
        [
        ]

unionThreadLocal : Jdec.Decoder UnionThreadLocal
unionThreadLocal =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionThreadLocal Jdec.float
        , Jdec.map ThreadLocalInUnionThreadLocal threadLocal
        ]

encodeUnionThreadLocal : UnionThreadLocal -> Jenc.Value
encodeUnionThreadLocal x = case x of
    DoubleInUnionThreadLocal y -> Jenc.float y
    ThreadLocalInUnionThreadLocal y -> encodeThreadLocal y

threadLocal : Jdec.Decoder ThreadLocal
threadLocal =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ThreadLocal)

encodeThreadLocal : ThreadLocal -> Jenc.Value
encodeThreadLocal x =
    Jenc.object
        [
        ]

unionThrow : Jdec.Decoder UnionThrow
unionThrow =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionThrow Jdec.float
        , Jdec.map ThrowInUnionThrow throw
        ]

encodeUnionThrow : UnionThrow -> Jenc.Value
encodeUnionThrow x = case x of
    DoubleInUnionThrow y -> Jenc.float y
    ThrowInUnionThrow y -> encodeThrow y

throw : Jdec.Decoder Throw
throw =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Throw)

encodeThrow : Throw -> Jenc.Value
encodeThrow x =
    Jenc.object
        [
        ]

unionThrows : Jdec.Decoder UnionThrows
unionThrows =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionThrows Jdec.float
        , Jdec.map ThrowsInUnionThrows throws
        ]

encodeUnionThrows : UnionThrows -> Jenc.Value
encodeUnionThrows x = case x of
    DoubleInUnionThrows y -> Jenc.float y
    ThrowsInUnionThrows y -> encodeThrows y

throws : Jdec.Decoder Throws
throws =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Throws)

encodeThrows : Throws -> Jenc.Value
encodeThrows x =
    Jenc.object
        [
        ]

unionTimeOnly : Jdec.Decoder UnionTimeOnly
unionTimeOnly =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTimeOnly Jdec.float
        , Jdec.map TimeOnlyInUnionTimeOnly timeOnly
        ]

encodeUnionTimeOnly : UnionTimeOnly -> Jenc.Value
encodeUnionTimeOnly x = case x of
    DoubleInUnionTimeOnly y -> Jenc.float y
    TimeOnlyInUnionTimeOnly y -> encodeTimeOnly y

timeOnly : Jdec.Decoder TimeOnly
timeOnly =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TimeOnly)

encodeTimeOnly : TimeOnly -> Jenc.Value
encodeTimeOnly x =
    Jenc.object
        [
        ]

unionTimeOnlyConverter : Jdec.Decoder UnionTimeOnlyConverter
unionTimeOnlyConverter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTimeOnlyConverter Jdec.float
        , Jdec.map TimeOnlyConverterInUnionTimeOnlyConverter timeOnlyConverter
        ]

encodeUnionTimeOnlyConverter : UnionTimeOnlyConverter -> Jenc.Value
encodeUnionTimeOnlyConverter x = case x of
    DoubleInUnionTimeOnlyConverter y -> Jenc.float y
    TimeOnlyConverterInUnionTimeOnlyConverter y -> encodeTimeOnlyConverter y

timeOnlyConverter : Jdec.Decoder TimeOnlyConverter
timeOnlyConverter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TimeOnlyConverter)

encodeTimeOnlyConverter : TimeOnlyConverter -> Jenc.Value
encodeTimeOnlyConverter x =
    Jenc.object
        [
        ]

unionTimeZone : Jdec.Decoder UnionTimeZone
unionTimeZone =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTimeZone Jdec.float
        , Jdec.map TimeZoneInUnionTimeZone timeZone
        ]

encodeUnionTimeZone : UnionTimeZone -> Jenc.Value
encodeUnionTimeZone x = case x of
    DoubleInUnionTimeZone y -> Jenc.float y
    TimeZoneInUnionTimeZone y -> encodeTimeZone y

timeZone : Jdec.Decoder TimeZone
timeZone =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TimeZone)

encodeTimeZone : TimeZone -> Jenc.Value
encodeTimeZone x =
    Jenc.object
        [
        ]

unionToDict : Jdec.Decoder UnionToDict
unionToDict =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionToDict Jdec.float
        , Jdec.map ToDictInUnionToDict toDict
        ]

encodeUnionToDict : UnionToDict -> Jenc.Value
encodeUnionToDict x = case x of
    DoubleInUnionToDict y -> Jenc.float y
    ToDictInUnionToDict y -> encodeToDict y

toDict : Jdec.Decoder ToDict
toDict =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ToDict)

encodeToDict : ToDict -> Jenc.Value
encodeToDict x =
    Jenc.object
        [
        ]

unionToJSON : Jdec.Decoder UnionToJSON
unionToJSON =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionToJSON Jdec.float
        , Jdec.map ToJSONInUnionToJSON toJSON
        ]

encodeUnionToJSON : UnionToJSON -> Jenc.Value
encodeUnionToJSON x = case x of
    DoubleInUnionToJSON y -> Jenc.float y
    ToJSONInUnionToJSON y -> encodeToJSON y

toJSON : Jdec.Decoder ToJSON
toJSON =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ToJSON)

encodeToJSON : ToJSON -> Jenc.Value
encodeToJSON x =
    Jenc.object
        [
        ]

unionToString : Jdec.Decoder UnionToString
unionToString =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionToString Jdec.float
        , Jdec.map ToStringInUnionToString toString
        ]

encodeUnionToString : UnionToString -> Jenc.Value
encodeUnionToString x = case x of
    DoubleInUnionToString y -> Jenc.float y
    ToStringInUnionToString y -> encodeToString y

toString : Jdec.Decoder ToString
toString =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ToString)

encodeToString : ToString -> Jenc.Value
encodeToString x =
    Jenc.object
        [
        ]

unionTopLevel : Jdec.Decoder UnionTopLevel
unionTopLevel =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTopLevel Jdec.float
        , Jdec.map TopLevelInUnionTopLevel topLevel
        ]

encodeUnionTopLevel : UnionTopLevel -> Jenc.Value
encodeUnionTopLevel x = case x of
    DoubleInUnionTopLevel y -> Jenc.float y
    TopLevelInUnionTopLevel y -> encodeTopLevel y

topLevel : Jdec.Decoder TopLevel
topLevel =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TopLevel)

encodeTopLevel : TopLevel -> Jenc.Value
encodeTopLevel x =
    Jenc.object
        [
        ]

unionTransient : Jdec.Decoder UnionTransient
unionTransient =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTransient Jdec.float
        , Jdec.map TransientInUnionTransient transient
        ]

encodeUnionTransient : UnionTransient -> Jenc.Value
encodeUnionTransient x = case x of
    DoubleInUnionTransient y -> Jenc.float y
    TransientInUnionTransient y -> encodeTransient y

transient : Jdec.Decoder Transient
transient =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Transient)

encodeTransient : Transient -> Jenc.Value
encodeTransient x =
    Jenc.object
        [
        ]

unionTrue : Jdec.Decoder UnionTrue
unionTrue =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTrue Jdec.float
        , Jdec.map TrueClassInUnionTrue trueClass
        ]

encodeUnionTrue : UnionTrue -> Jenc.Value
encodeUnionTrue x = case x of
    DoubleInUnionTrue y -> Jenc.float y
    TrueClassInUnionTrue y -> encodeTrueClass y

trueClass : Jdec.Decoder TrueClass
trueClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TrueClass)

encodeTrueClass : TrueClass -> Jenc.Value
encodeTrueClass x =
    Jenc.object
        [
        ]

unionTry : Jdec.Decoder UnionTry
unionTry =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTry Jdec.float
        , Jdec.map TryInUnionTry try
        ]

encodeUnionTry : UnionTry -> Jenc.Value
encodeUnionTry x = case x of
    DoubleInUnionTry y -> Jenc.float y
    TryInUnionTry y -> encodeTry y

try : Jdec.Decoder Try
try =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Try)

encodeTry : Try -> Jenc.Value
encodeTry x =
    Jenc.object
        [
        ]

unionTypealias : Jdec.Decoder UnionTypealias
unionTypealias =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypealias Jdec.float
        , Jdec.map TypealiasInUnionTypealias typealias
        ]

encodeUnionTypealias : UnionTypealias -> Jenc.Value
encodeUnionTypealias x = case x of
    DoubleInUnionTypealias y -> Jenc.float y
    TypealiasInUnionTypealias y -> encodeTypealias y

typealias : Jdec.Decoder Typealias
typealias =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Typealias)

encodeTypealias : Typealias -> Jenc.Value
encodeTypealias x =
    Jenc.object
        [
        ]

unionTypedef : Jdec.Decoder UnionTypedef
unionTypedef =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypedef Jdec.float
        , Jdec.map TypedefInUnionTypedef typedef
        ]

encodeUnionTypedef : UnionTypedef -> Jenc.Value
encodeUnionTypedef x = case x of
    DoubleInUnionTypedef y -> Jenc.float y
    TypedefInUnionTypedef y -> encodeTypedef y

typedef : Jdec.Decoder Typedef
typedef =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Typedef)

encodeTypedef : Typedef -> Jenc.Value
encodeTypedef x =
    Jenc.object
        [
        ]

unionTypeid : Jdec.Decoder UnionTypeid
unionTypeid =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypeid Jdec.float
        , Jdec.map TypeidInUnionTypeid typeid
        ]

encodeUnionTypeid : UnionTypeid -> Jenc.Value
encodeUnionTypeid x = case x of
    DoubleInUnionTypeid y -> Jenc.float y
    TypeidInUnionTypeid y -> encodeTypeid y

typeid : Jdec.Decoder Typeid
typeid =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Typeid)

encodeTypeid : Typeid -> Jenc.Value
encodeTypeid x =
    Jenc.object
        [
        ]

unionTypename : Jdec.Decoder UnionTypename
unionTypename =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypename Jdec.float
        , Jdec.map TypenameInUnionTypename typename
        ]

encodeUnionTypename : UnionTypename -> Jenc.Value
encodeUnionTypename x = case x of
    DoubleInUnionTypename y -> Jenc.float y
    TypenameInUnionTypename y -> encodeTypename y

typename : Jdec.Decoder Typename
typename =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Typename)

encodeTypename : Typename -> Jenc.Value
encodeTypename x =
    Jenc.object
        [
        ]

unionTypeof : Jdec.Decoder UnionTypeof
unionTypeof =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionTypeof Jdec.float
        , Jdec.map TypeofInUnionTypeof typeof
        ]

encodeUnionTypeof : UnionTypeof -> Jenc.Value
encodeUnionTypeof x = case x of
    DoubleInUnionTypeof y -> Jenc.float y
    TypeofInUnionTypeof y -> encodeTypeof y

typeof : Jdec.Decoder Typeof
typeof =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Typeof)

encodeTypeof : Typeof -> Jenc.Value
encodeTypeof x =
    Jenc.object
        [
        ]

unionUint : Jdec.Decoder UnionUint
unionUint =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUint Jdec.float
        , Jdec.map UintInUnionUint uint
        ]

encodeUnionUint : UnionUint -> Jenc.Value
encodeUnionUint x = case x of
    DoubleInUnionUint y -> Jenc.float y
    UintInUnionUint y -> encodeUint y

uint : Jdec.Decoder Uint
uint =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Uint)

encodeUint : Uint -> Jenc.Value
encodeUint x =
    Jenc.object
        [
        ]

unionUlong : Jdec.Decoder UnionUlong
unionUlong =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUlong Jdec.float
        , Jdec.map UlongInUnionUlong ulong
        ]

encodeUnionUlong : UnionUlong -> Jenc.Value
encodeUnionUlong x = case x of
    DoubleInUnionUlong y -> Jenc.float y
    UlongInUnionUlong y -> encodeUlong y

ulong : Jdec.Decoder Ulong
ulong =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Ulong)

encodeUlong : Ulong -> Jenc.Value
encodeUlong x =
    Jenc.object
        [
        ]

unionUnchecked : Jdec.Decoder UnionUnchecked
unionUnchecked =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnchecked Jdec.float
        , Jdec.map UncheckedInUnionUnchecked unchecked
        ]

encodeUnionUnchecked : UnionUnchecked -> Jenc.Value
encodeUnionUnchecked x = case x of
    DoubleInUnionUnchecked y -> Jenc.float y
    UncheckedInUnionUnchecked y -> encodeUnchecked y

unchecked : Jdec.Decoder Unchecked
unchecked =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Unchecked)

encodeUnchecked : Unchecked -> Jenc.Value
encodeUnchecked x =
    Jenc.object
        [
        ]

unionUndefined : Jdec.Decoder UnionUndefined
unionUndefined =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUndefined Jdec.float
        , Jdec.map UndefinedInUnionUndefined undefined
        ]

encodeUnionUndefined : UnionUndefined -> Jenc.Value
encodeUnionUndefined x = case x of
    DoubleInUnionUndefined y -> Jenc.float y
    UndefinedInUnionUndefined y -> encodeUndefined y

undefined : Jdec.Decoder Undefined
undefined =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Undefined)

encodeUndefined : Undefined -> Jenc.Value
encodeUndefined x =
    Jenc.object
        [
        ]

unionUnionUnion : Jdec.Decoder UnionUnionUnion
unionUnionUnion =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnionUnion Jdec.float
        , Jdec.map UnionInUnionUnionUnion union
        ]

encodeUnionUnionUnion : UnionUnionUnion -> Jenc.Value
encodeUnionUnionUnion x = case x of
    DoubleInUnionUnionUnion y -> Jenc.float y
    UnionInUnionUnionUnion y -> encodeUnion y

union : Jdec.Decoder Union
union =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Union)

encodeUnion : Union -> Jenc.Value
encodeUnion x =
    Jenc.object
        [
        ]

unionUnmarshalJSON : Jdec.Decoder UnionUnmarshalJSON
unionUnmarshalJSON =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnmarshalJSON Jdec.float
        , Jdec.map UnmarshalJSONInUnionUnmarshalJSON unmarshalJSON
        ]

encodeUnionUnmarshalJSON : UnionUnmarshalJSON -> Jenc.Value
encodeUnionUnmarshalJSON x = case x of
    DoubleInUnionUnmarshalJSON y -> Jenc.float y
    UnmarshalJSONInUnionUnmarshalJSON y -> encodeUnmarshalJSON y

unmarshalJSON : Jdec.Decoder UnmarshalJSON
unmarshalJSON =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UnmarshalJSON)

encodeUnmarshalJSON : UnmarshalJSON -> Jenc.Value
encodeUnmarshalJSON x =
    Jenc.object
        [
        ]

unionUnowned : Jdec.Decoder UnionUnowned
unionUnowned =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnowned Jdec.float
        , Jdec.map UnownedInUnionUnowned unowned
        ]

encodeUnionUnowned : UnionUnowned -> Jenc.Value
encodeUnionUnowned x = case x of
    DoubleInUnionUnowned y -> Jenc.float y
    UnownedInUnionUnowned y -> encodeUnowned y

unowned : Jdec.Decoder Unowned
unowned =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Unowned)

encodeUnowned : Unowned -> Jenc.Value
encodeUnowned x =
    Jenc.object
        [
        ]

unionUnsafe : Jdec.Decoder UnionUnsafe
unionUnsafe =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnsafe Jdec.float
        , Jdec.map UnsafeInUnionUnsafe unsafe
        ]

encodeUnionUnsafe : UnionUnsafe -> Jenc.Value
encodeUnionUnsafe x = case x of
    DoubleInUnionUnsafe y -> Jenc.float y
    UnsafeInUnionUnsafe y -> encodeUnsafe y

unsafe : Jdec.Decoder Unsafe
unsafe =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Unsafe)

encodeUnsafe : Unsafe -> Jenc.Value
encodeUnsafe x =
    Jenc.object
        [
        ]

unionUnsigned : Jdec.Decoder UnionUnsigned
unionUnsigned =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUnsigned Jdec.float
        , Jdec.map UnsignedInUnionUnsigned unsigned
        ]

encodeUnionUnsigned : UnionUnsigned -> Jenc.Value
encodeUnionUnsigned x = case x of
    DoubleInUnionUnsigned y -> Jenc.float y
    UnsignedInUnionUnsigned y -> encodeUnsigned y

unsigned : Jdec.Decoder Unsigned
unsigned =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Unsigned)

encodeUnsigned : Unsigned -> Jenc.Value
encodeUnsigned x =
    Jenc.object
        [
        ]

unionUseSerializers : Jdec.Decoder UnionUseSerializers
unionUseSerializers =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUseSerializers Jdec.float
        , Jdec.map UseSerializersInUnionUseSerializers useSerializers
        ]

encodeUnionUseSerializers : UnionUseSerializers -> Jenc.Value
encodeUnionUseSerializers x = case x of
    DoubleInUnionUseSerializers y -> Jenc.float y
    UseSerializersInUnionUseSerializers y -> encodeUseSerializers y

useSerializers : Jdec.Decoder UseSerializers
useSerializers =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UseSerializers)

encodeUseSerializers : UseSerializers -> Jenc.Value
encodeUseSerializers x =
    Jenc.object
        [
        ]

unionUshort : Jdec.Decoder UnionUshort
unionUshort =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUshort Jdec.float
        , Jdec.map UshortInUnionUshort ushort
        ]

encodeUnionUshort : UnionUshort -> Jenc.Value
encodeUnionUshort x = case x of
    DoubleInUnionUshort y -> Jenc.float y
    UshortInUnionUshort y -> encodeUshort y

ushort : Jdec.Decoder Ushort
ushort =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Ushort)

encodeUshort : Ushort -> Jenc.Value
encodeUshort x =
    Jenc.object
        [
        ]

unionUsing : Jdec.Decoder UnionUsing
unionUsing =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUsing Jdec.float
        , Jdec.map UsingInUnionUsing using
        ]

encodeUnionUsing : UnionUsing -> Jenc.Value
encodeUnionUsing x = case x of
    DoubleInUnionUsing y -> Jenc.float y
    UsingInUnionUsing y -> encodeUsing y

using : Jdec.Decoder Using
using =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Using)

encodeUsing : Using -> Jenc.Value
encodeUsing x =
    Jenc.object
        [
        ]

unionUtf8JSONReader : Jdec.Decoder UnionUtf8JSONReader
unionUtf8JSONReader =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUtf8JSONReader Jdec.float
        , Jdec.map Utf8JSONReaderInUnionUtf8JSONReader utf8JSONReader
        ]

encodeUnionUtf8JSONReader : UnionUtf8JSONReader -> Jenc.Value
encodeUnionUtf8JSONReader x = case x of
    DoubleInUnionUtf8JSONReader y -> Jenc.float y
    Utf8JSONReaderInUnionUtf8JSONReader y -> encodeUtf8JSONReader y

utf8JSONReader : Jdec.Decoder Utf8JSONReader
utf8JSONReader =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Utf8JSONReader)

encodeUtf8JSONReader : Utf8JSONReader -> Jenc.Value
encodeUtf8JSONReader x =
    Jenc.object
        [
        ]

unionUtf8JSONWriter : Jdec.Decoder UnionUtf8JSONWriter
unionUtf8JSONWriter =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUtf8JSONWriter Jdec.float
        , Jdec.map Utf8JSONWriterInUnionUtf8JSONWriter utf8JSONWriter
        ]

encodeUnionUtf8JSONWriter : UnionUtf8JSONWriter -> Jenc.Value
encodeUnionUtf8JSONWriter x = case x of
    DoubleInUnionUtf8JSONWriter y -> Jenc.float y
    Utf8JSONWriterInUnionUtf8JSONWriter y -> encodeUtf8JSONWriter y

utf8JSONWriter : Jdec.Decoder Utf8JSONWriter
utf8JSONWriter =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Utf8JSONWriter)

encodeUtf8JSONWriter : Utf8JSONWriter -> Jenc.Value
encodeUtf8JSONWriter x =
    Jenc.object
        [
        ]

unionUUID : Jdec.Decoder UnionUUID
unionUUID =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionUUID Jdec.float
        , Jdec.map UUIDInUnionUUID uuid
        ]

encodeUnionUUID : UnionUUID -> Jenc.Value
encodeUnionUUID x = case x of
    DoubleInUnionUUID y -> Jenc.float y
    UUIDInUnionUUID y -> encodeUUID y

uuid : Jdec.Decoder UUID
uuid =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> UUID)

encodeUUID : UUID -> Jenc.Value
encodeUUID x =
    Jenc.object
        [
        ]

unionVar : Jdec.Decoder UnionVar
unionVar =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionVar Jdec.float
        , Jdec.map VarInUnionVar var
        ]

encodeUnionVar : UnionVar -> Jenc.Value
encodeUnionVar x = case x of
    DoubleInUnionVar y -> Jenc.float y
    VarInUnionVar y -> encodeVar y

var : Jdec.Decoder Var
var =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Var)

encodeVar : Var -> Jenc.Value
encodeVar x =
    Jenc.object
        [
        ]

unionVirtual : Jdec.Decoder UnionVirtual
unionVirtual =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionVirtual Jdec.float
        , Jdec.map VirtualInUnionVirtual virtual
        ]

encodeUnionVirtual : UnionVirtual -> Jenc.Value
encodeUnionVirtual x = case x of
    DoubleInUnionVirtual y -> Jenc.float y
    VirtualInUnionVirtual y -> encodeVirtual y

virtual : Jdec.Decoder Virtual
virtual =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Virtual)

encodeVirtual : Virtual -> Jenc.Value
encodeVirtual x =
    Jenc.object
        [
        ]

unionVoid : Jdec.Decoder UnionVoid
unionVoid =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionVoid Jdec.float
        , Jdec.map VoidInUnionVoid void
        ]

encodeUnionVoid : UnionVoid -> Jenc.Value
encodeUnionVoid x = case x of
    DoubleInUnionVoid y -> Jenc.float y
    VoidInUnionVoid y -> encodeVoid y

void : Jdec.Decoder Void
void =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Void)

encodeVoid : Void -> Jenc.Value
encodeVoid x =
    Jenc.object
        [
        ]

unionVolatile : Jdec.Decoder UnionVolatile
unionVolatile =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionVolatile Jdec.float
        , Jdec.map VolatileInUnionVolatile volatile
        ]

encodeUnionVolatile : UnionVolatile -> Jenc.Value
encodeUnionVolatile x = case x of
    DoubleInUnionVolatile y -> Jenc.float y
    VolatileInUnionVolatile y -> encodeVolatile y

volatile : Jdec.Decoder Volatile
volatile =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Volatile)

encodeVolatile : Volatile -> Jenc.Value
encodeVolatile x =
    Jenc.object
        [
        ]

unionWcharT : Jdec.Decoder UnionWcharT
unionWcharT =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWcharT Jdec.float
        , Jdec.map WcharTInUnionWcharT wcharT
        ]

encodeUnionWcharT : UnionWcharT -> Jenc.Value
encodeUnionWcharT x = case x of
    DoubleInUnionWcharT y -> Jenc.float y
    WcharTInUnionWcharT y -> encodeWcharT y

wcharT : Jdec.Decoder WcharT
wcharT =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> WcharT)

encodeWcharT : WcharT -> Jenc.Value
encodeWcharT x =
    Jenc.object
        [
        ]

unionWeak : Jdec.Decoder UnionWeak
unionWeak =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWeak Jdec.float
        , Jdec.map WeakInUnionWeak weak
        ]

encodeUnionWeak : UnionWeak -> Jenc.Value
encodeUnionWeak x = case x of
    DoubleInUnionWeak y -> Jenc.float y
    WeakInUnionWeak y -> encodeWeak y

weak : Jdec.Decoder Weak
weak =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Weak)

encodeWeak : Weak -> Jenc.Value
encodeWeak x =
    Jenc.object
        [
        ]

unionWhile : Jdec.Decoder UnionWhile
unionWhile =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWhile Jdec.float
        , Jdec.map WhileInUnionWhile while
        ]

encodeUnionWhile : UnionWhile -> Jenc.Value
encodeUnionWhile x = case x of
    DoubleInUnionWhile y -> Jenc.float y
    WhileInUnionWhile y -> encodeWhile y

while : Jdec.Decoder While
while =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> While)

encodeWhile : While -> Jenc.Value
encodeWhile x =
    Jenc.object
        [
        ]

unionWillSet : Jdec.Decoder UnionWillSet
unionWillSet =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWillSet Jdec.float
        , Jdec.map WillSetInUnionWillSet willSet
        ]

encodeUnionWillSet : UnionWillSet -> Jenc.Value
encodeUnionWillSet x = case x of
    DoubleInUnionWillSet y -> Jenc.float y
    WillSetInUnionWillSet y -> encodeWillSet y

willSet : Jdec.Decoder WillSet
willSet =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> WillSet)

encodeWillSet : WillSet -> Jenc.Value
encodeWillSet x =
    Jenc.object
        [
        ]

unionWith : Jdec.Decoder UnionWith
unionWith =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionWith Jdec.float
        , Jdec.map WithInUnionWith with
        ]

encodeUnionWith : UnionWith -> Jenc.Value
encodeUnionWith x = case x of
    DoubleInUnionWith y -> Jenc.float y
    WithInUnionWith y -> encodeWith y

with : Jdec.Decoder With
with =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> With)

encodeWith : With -> Jenc.Value
encodeWith x =
    Jenc.object
        [
        ]

unionXor : Jdec.Decoder UnionXor
unionXor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionXor Jdec.float
        , Jdec.map XorInUnionXor xor
        ]

encodeUnionXor : UnionXor -> Jenc.Value
encodeUnionXor x = case x of
    DoubleInUnionXor y -> Jenc.float y
    XorInUnionXor y -> encodeXor y

xor : Jdec.Decoder Xor
xor =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Xor)

encodeXor : Xor -> Jenc.Value
encodeXor x =
    Jenc.object
        [
        ]

unionXorEq : Jdec.Decoder UnionXorEq
unionXorEq =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionXorEq Jdec.float
        , Jdec.map XorEqInUnionXorEq xorEq
        ]

encodeUnionXorEq : UnionXorEq -> Jenc.Value
encodeUnionXorEq x = case x of
    DoubleInUnionXorEq y -> Jenc.float y
    XorEqInUnionXorEq y -> encodeXorEq y

xorEq : Jdec.Decoder XorEq
xorEq =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> XorEq)

encodeXorEq : XorEq -> Jenc.Value
encodeXorEq x =
    Jenc.object
        [
        ]

unionYES : Jdec.Decoder UnionYES
unionYES =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionYES Jdec.float
        , Jdec.map YesInUnionYES yes
        ]

encodeUnionYES : UnionYES -> Jenc.Value
encodeUnionYES x = case x of
    DoubleInUnionYES y -> Jenc.float y
    YesInUnionYES y -> encodeYes y

yes : Jdec.Decoder Yes
yes =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Yes)

encodeYes : Yes -> Jenc.Value
encodeYes x =
    Jenc.object
        [
        ]

unionYield : Jdec.Decoder UnionYield
unionYield =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionYield Jdec.float
        , Jdec.map YieldInUnionYield yield
        ]

encodeUnionYield : UnionYield -> Jenc.Value
encodeUnionYield x = case x of
    DoubleInUnionYield y -> Jenc.float y
    YieldInUnionYield y -> encodeYield y

yield : Jdec.Decoder Yield
yield =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Yield)

encodeYield : Yield -> Jenc.Value
encodeYield x =
    Jenc.object
        [
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
