{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Abstract (..)
    , Alignas (..)
    , Alignof (..)
    , And (..)
    , AndEq (..)
    , Any (..)
    , ArrayClass (..)
    , ArrayNode (..)
    , ASM (..)
    , Assert (..)
    , Associatedtype (..)
    , Associativity (..)
    , Async (..)
    , Atomic (..)
    , AtomicCancel (..)
    , AtomicCommit (..)
    , AtomicNoexcept (..)
    , Auto (..)
    , Await (..)
    , Base (..)
    , Bitand (..)
    , Bitor (..)
    , BOOLClass (..)
    , Boolean (..)
    , BooleanNode (..)
    , Break (..)
    , Bycopy (..)
    , Byref (..)
    , Byte (..)
    , Calendar (..)
    , Catch (..)
    , Chan (..)
    , CharClass (..)
    , Char16T (..)
    , Char32T (..)
    , Checked (..)
    , Clone (..)
    , CoAwait (..)
    , CoReturn (..)
    , CoYield (..)
    , Codable (..)
    , CodingKey (..)
    , CodingKeys (..)
    , Compl (..)
    , Complex (..)
    , Concept (..)
    , Console (..)
    , Const (..)
    , ConstCast (..)
    , Constexpr (..)
    , Constructor (..)
    , Continue (..)
    , Convenience (..)
    , Convert (..)
    , Converter (..)
    , CultureInfo (..)
    , Date (..)
    , DateFormatter (..)
    , DateOnly (..)
    , DateOnlyConverter (..)
    , DateParseHandling (..)
    , DateTime (..)
    , DateTimeStyles (..)
    , Debugger (..)
    , Decimal (..)
    , Declare (..)
    , Decltype (..)
    , DecodeString (..)
    , Decoder (..)
    , DecodingError (..)
    , Def (..)
    , Defer (..)
    , Deinit (..)
    , Del (..)
    , Delegate (..)
    , Delete (..)
    , DeserializationFeature (..)
    , Dict (..)
    , Dictionary (..)
    , DidSet (..)
    , DoubleClass (..)
    , DoubleNode (..)
    , Dynamic (..)
    , DynamicCast (..)
    , Elif (..)
    , Empty (..)
    , EncodeQuickType (..)
    , Encoder (..)
    , EnumClass (..)
    , EnumValues (..)
    , EqualityContract (..)
    , Equatable (..)
    , Event (..)
    , Except (..)
    , Exception (..)
    , Explicit (..)
    , Export (..)
    , Exposing (..)
    , Extends (..)
    , Extension (..)
    , Extern (..)
    , Fallthrough (..)
    , FalseClass (..)
    , Fileprivate (..)
    , Final (..)
    , Finally (..)
    , Fixed (..)
    , FloatClass (..)
    , For (..)
    , Foreach (..)
    , FormatException (..)
    , Friend (..)
    , From (..)
    , FromDict (..)
    , FromJSONClass (..)
    , Func (..)
    , Function (..)
    , Get (..)
    , Global (..)
    , Go (..)
    , Goto (..)
    , Guard (..)
    , HasOwnProperty (..)
    , HashCode (..)
    , Hashable (..)
    , Hasher (..)
    , Imaginery (..)
    , Imp (..)
    , Implements (..)
    , Implicit (..)
    , Indirect (..)
    , Init (..)
    , Inline (..)
    , Inout (..)
    , Instanceof (..)
    , IntClass (..)
    , IntNode (..)
    , Interface (..)
    , Internal (..)
    , Is (..)
    , ISODateTimeOffsetConverter (..)
    , Iterable (..)
    , Jdec (..)
    , Jenc (..)
    , Jpipe (..)
    , JSON (..)
    , JSONAny (..)
    , JSONCodingKey (..)
    , JSONConverter (..)
    , JSONDecoder (..)
    , JSONEncoder (..)
    , JSONException (..)
    , JSONGenerator (..)
    , JSONNode (..)
    , JSONNull (..)
    , JSONParser (..)
    , JSONReader (..)
    , JSONSerializer (..)
    , JSONToken (..)
    , JSONTokenType (..)
    , JSONWriter (..)
    , KSerializer (..)
    , Lambda (..)
    , Lazy (..)
    , LeftClass (..)
    , List (..)
    , LocalDate (..)
    , Locale (..)
    , Lock (..)
    , Long (..)
    , LongNode (..)
    , MapClass (..)
    , MapEntry (..)
    , MarshalJSON (..)
    , MetadataPropertyHandling (..)
    , Mutable (..)
    , Mutating (..)
    , Namespace (..)
    , Native (..)
    , New (..)
    , Newtonsoft (..)
    , Nil (..)
    , No (..)
    , NoSuchMethod (..)
    , Noexcept (..)
    , Nonatomic (..)
    , None (..)
    , Nonlocal (..)
    , Nonmutating (..)
    , Not (..)
    , NotEq (..)
    , NSError (..)
    , NSObject (..)
    , NSString (..)
    , NULLClass (..)
    , NullNode (..)
    , Nullptr (..)
    , NumberClass (..)
    , ObjectClass (..)
    , ObjectMapper (..)
    , ObjectNode (..)
    , ObjectReader (..)
    , ObjectWriter (..)
    , OffsetDateTime (..)
    , OffsetTime (..)
    , Oneway (..)
    , Open (..)
    , Operator (..)
    , Optional (..)
    , Or (..)
    , OrEq (..)
    , Out (..)
    , Override (..)
    , Package (..)
    , Params (..)
    , Pass (..)
    , Port (..)
    , Postfix (..)
    , Precedence (..)
    , Prefix (..)
    , PrimitiveKind (..)
    , Print (..)
    , PrintMembers (..)
    , Printf (..)
    , Private (..)
    , Protected (..)
    , Protocol (..)
    , Public (..)
    , UnionBoolBool (..)
    , ClassClass (..)
    , TypeClass (..)
    , AnyClass (..)
    , As (..)
    , BoolClass (..)
    , Case (..)
    , Class (..)
    , Default (..)
    , Do (..)
    , Else (..)
    , UnionFalseFalse (..)
    , ID (..)
    , If (..)
    , Import (..)
    , In (..)
    , Infix (..)
    , Let (..)
    , Module (..)
    , NoneClass (..)
    , NullClass (..)
    , Of (..)
    , ProtocolClass (..)
    , SelfClass (..)
    , Then (..)
    , UnionTrueTrue (..)
    , Type (..)
    , Where (..)
    , Quicktype (..)
    , Raise (..)
    , Range (..)
    , Readonly (..)
    , Ref (..)
    , RegExp (..)
    , Register (..)
    , ReinterpretCast (..)
    , Repeat (..)
    , Require (..)
    , Required (..)
    , Requires (..)
    , Restrict (..)
    , Retain (..)
    , Rethrows (..)
    , Return (..)
    , RightClass (..)
    , RuntimeType (..)
    , S (..)
    , Sbyte (..)
    , Sealed (..)
    , Sel (..)
    , Select (..)
    , Self (..)
    , Sendable (..)
    , SerialDescriptor (..)
    , SerialName (..)
    , Serializable (..)
    , SerializationFeature (..)
    , Serialize (..)
    , SerializerProvider (..)
    , Set (..)
    , Short (..)
    , Signed (..)
    , SimpleModule (..)
    , Sizeof (..)
    , Stackalloc (..)
    , Standards (..)
    , Static (..)
    , StaticAssert (..)
    , StaticCast (..)
    , StdDeserializer (..)
    , StdSerializer (..)
    , Strictfp (..)
    , StringClass (..)
    , Struct (..)
    , Subscript (..)
    , Super (..)
    , Switch (..)
    , Symbol (..)
    , Synchronized (..)
    , System (..)
    , Template (..)
    , TextNode (..)
    , This (..)
    , ThreadLocal (..)
    , Throw (..)
    , Throws (..)
    , TimeOnly (..)
    , TimeOnlyConverter (..)
    , TimeZone (..)
    , ToDict (..)
    , ToJSONClass (..)
    , ToString (..)
    , TopLevel (..)
    , Transient (..)
    , TrueClass (..)
    , Try (..)
    , Typealias (..)
    , Typedef (..)
    , Typeid (..)
    , Typename (..)
    , Typeof (..)
    , Uint (..)
    , Ulong (..)
    , Unchecked (..)
    , Undefined (..)
    , Union (..)
    , UnmarshalJSON (..)
    , Unowned (..)
    , Unsafe (..)
    , Unsigned (..)
    , UseSerializers (..)
    , Ushort (..)
    , Using (..)
    , Utf8JSONReader (..)
    , Utf8JSONWriter (..)
    , UUID (..)
    , Var (..)
    , Virtual (..)
    , Void (..)
    , Volatile (..)
    , WcharT (..)
    , Weak (..)
    , While (..)
    , WillSet (..)
    , With (..)
    , Xor (..)
    , XorEq (..)
    , Yes (..)
    , Yield (..)
    , UnionAbstract (..)
    , UnionAlignas (..)
    , UnionAlignof (..)
    , UnionAnd (..)
    , UnionAndEq (..)
    , UnionAny (..)
    , UnionArray (..)
    , UnionArrayNode (..)
    , UnionASM (..)
    , UnionAssert (..)
    , UnionAssociatedtype (..)
    , UnionAssociativity (..)
    , UnionAsync (..)
    , UnionAtomic (..)
    , UnionAtomicCancel (..)
    , UnionAtomicCommit (..)
    , UnionAtomicNoexcept (..)
    , UnionAuto (..)
    , UnionAwait (..)
    , UnionBase (..)
    , UnionBitand (..)
    , UnionBitor (..)
    , UnionBOOL (..)
    , UnionBoolean (..)
    , UnionBooleanNode (..)
    , UnionBreak (..)
    , UnionBycopy (..)
    , UnionByref (..)
    , UnionByte (..)
    , UnionCalendar (..)
    , UnionCatch (..)
    , UnionChan (..)
    , UnionChar (..)
    , UnionChar16T (..)
    , UnionChar32T (..)
    , UnionChecked (..)
    , UnionClone (..)
    , UnionCoAwait (..)
    , UnionCoReturn (..)
    , UnionCoYield (..)
    , UnionCodable (..)
    , UnionCodingKey (..)
    , UnionCodingKeys (..)
    , UnionCompl (..)
    , UnionComplex (..)
    , UnionConcept (..)
    , UnionConsole (..)
    , UnionConst (..)
    , UnionConstCast (..)
    , UnionConstexpr (..)
    , UnionConstructor (..)
    , UnionContinue (..)
    , UnionConvenience (..)
    , UnionConvert (..)
    , UnionConverter (..)
    , UnionCultureInfo (..)
    , UnionDate (..)
    , UnionDateFormatter (..)
    , UnionDateOnly (..)
    , UnionDateOnlyConverter (..)
    , UnionDateParseHandling (..)
    , UnionDateTime (..)
    , UnionDateTimeStyles (..)
    , UnionDebugger (..)
    , UnionDecimal (..)
    , UnionDeclare (..)
    , UnionDecltype (..)
    , UnionDecodeString (..)
    , UnionDecoder (..)
    , UnionDecodingError (..)
    , UnionDef (..)
    , UnionDefer (..)
    , UnionDeinit (..)
    , UnionDel (..)
    , UnionDelegate (..)
    , UnionDelete (..)
    , UnionDeserializationFeature (..)
    , UnionDict (..)
    , UnionDictionary (..)
    , UnionDidSet (..)
    , UnionDouble (..)
    , UnionDoubleNode (..)
    , UnionDynamic (..)
    , UnionDynamicCast (..)
    , UnionElif (..)
    , UnionUnion (..)
    , UnionEncodeQuickType (..)
    , UnionEncoder (..)
    , UnionEnum (..)
    , UnionEnumValues (..)
    , UnionEqualityContract (..)
    , UnionEquatable (..)
    , UnionEvent (..)
    , UnionExcept (..)
    , UnionException (..)
    , UnionExplicit (..)
    , UnionExport (..)
    , UnionExposing (..)
    , UnionExtends (..)
    , UnionExtension (..)
    , UnionExtern (..)
    , UnionFallthrough (..)
    , UnionFalse (..)
    , UnionFileprivate (..)
    , UnionFinal (..)
    , UnionFinally (..)
    , UnionFixed (..)
    , UnionFloat (..)
    , UnionFor (..)
    , UnionForeach (..)
    , UnionFormatException (..)
    , UnionFriend (..)
    , UnionFrom (..)
    , UnionFromDict (..)
    , UnionFromJSON (..)
    , UnionFunc (..)
    , UnionFunction (..)
    , UnionGet (..)
    , UnionGlobal (..)
    , UnionGo (..)
    , UnionGoto (..)
    , UnionGuard (..)
    , UnionHasOwnProperty (..)
    , UnionHashCode (..)
    , UnionHashable (..)
    , UnionHasher (..)
    , UnionImaginery (..)
    , UnionIMP (..)
    , UnionImplements (..)
    , UnionImplicit (..)
    , UnionIndirect (..)
    , UnionInit (..)
    , UnionInline (..)
    , UnionInout (..)
    , UnionInstanceof (..)
    , UnionInt (..)
    , UnionIntNode (..)
    , UnionInterface (..)
    , UnionInternal (..)
    , UnionIs (..)
    , UnionISODateTimeOffsetConverter (..)
    , UnionIterable (..)
    , UnionJdec (..)
    , UnionJenc (..)
    , UnionJpipe (..)
    , UnionJSON (..)
    , UnionJSONAny (..)
    , UnionJSONCodingKey (..)
    , UnionJSONConverter (..)
    , UnionJSONDecoder (..)
    , UnionJSONEncoder (..)
    , UnionJSONException (..)
    , UnionJSONGenerator (..)
    , UnionJSONNode (..)
    , UnionJSONNull (..)
    , UnionJSONParser (..)
    , UnionJSONReader (..)
    , UnionJSONSerializer (..)
    , UnionJSONToken (..)
    , UnionJSONTokenType (..)
    , UnionJSONWriter (..)
    , UnionKSerializer (..)
    , UnionLambda (..)
    , UnionLazy (..)
    , UnionLeft (..)
    , UnionList (..)
    , UnionLocalDate (..)
    , UnionLocale (..)
    , UnionLock (..)
    , UnionLong (..)
    , UnionLongNode (..)
    , UnionMap (..)
    , UnionMapEntry (..)
    , UnionMarshalJSON (..)
    , UnionMetadataPropertyHandling (..)
    , UnionMutable (..)
    , UnionMutating (..)
    , UnionNamespace (..)
    , UnionNative (..)
    , UnionNew (..)
    , UnionNewtonsoft (..)
    , UnionNil (..)
    , UnionNO (..)
    , UnionNoSuchMethod (..)
    , UnionNoexcept (..)
    , UnionNonatomic (..)
    , UnionNone (..)
    , UnionNonlocal (..)
    , UnionNonmutating (..)
    , UnionNot (..)
    , UnionNotEq (..)
    , UnionNSError (..)
    , UnionNSObject (..)
    , UnionNSString (..)
    , UnionNULL (..)
    , UnionNullNode (..)
    , UnionNullptr (..)
    , UnionNumber (..)
    , UnionObject (..)
    , UnionObjectMapper (..)
    , UnionObjectNode (..)
    , UnionObjectReader (..)
    , UnionObjectWriter (..)
    , UnionOffsetDateTime (..)
    , UnionOffsetTime (..)
    , UnionOneway (..)
    , UnionOpen (..)
    , UnionOperator (..)
    , UnionOptional (..)
    , UnionOr (..)
    , UnionOrEq (..)
    , UnionOut (..)
    , UnionOverride (..)
    , UnionPackage (..)
    , UnionParams (..)
    , UnionPass (..)
    , UnionPort (..)
    , UnionPostfix (..)
    , UnionPrecedence (..)
    , UnionPrefix (..)
    , UnionPrimitiveKind (..)
    , UnionPrint (..)
    , UnionPrintMembers (..)
    , UnionPrintf (..)
    , UnionPrivate (..)
    , UnionProtected (..)
    , UnionProtocol (..)
    , UnionPublic (..)
    , UnionBoolUnion (..)
    , UnionClassUnion (..)
    , UnionTypeUnion (..)
    , UnionAnyUnion (..)
    , UnionAs (..)
    , UnionBool (..)
    , UnionCase (..)
    , UnionClass (..)
    , UnionDefault (..)
    , UnionDo (..)
    , UnionElse (..)
    , UnionFalseUnion (..)
    , UnionID (..)
    , UnionIf (..)
    , UnionImport (..)
    , UnionIn (..)
    , UnionInfix (..)
    , UnionLet (..)
    , UnionModule (..)
    , UnionNoneUnion (..)
    , UnionNull (..)
    , UnionOf (..)
    , UnionProtocolUnion (..)
    , UnionSelfUnion (..)
    , UnionThen (..)
    , UnionTrueUnion (..)
    , UnionType (..)
    , UnionWhere (..)
    , UnionQuicktype (..)
    , UnionRaise (..)
    , UnionRange (..)
    , UnionReadonly (..)
    , UnionRef (..)
    , UnionRegExp (..)
    , UnionRegister (..)
    , UnionReinterpretCast (..)
    , UnionRepeat (..)
    , UnionRequire (..)
    , UnionRequired (..)
    , UnionRequires (..)
    , UnionRestrict (..)
    , UnionRetain (..)
    , UnionRethrows (..)
    , UnionReturn (..)
    , UnionRight (..)
    , UnionRuntimeType (..)
    , UnionS (..)
    , UnionSbyte (..)
    , UnionSealed (..)
    , UnionSEL (..)
    , UnionSelect (..)
    , UnionSelf (..)
    , UnionSendable (..)
    , UnionSerialDescriptor (..)
    , UnionSerialName (..)
    , UnionSerializable (..)
    , UnionSerializationFeature (..)
    , UnionSerialize (..)
    , UnionSerializerProvider (..)
    , UnionSet (..)
    , UnionShort (..)
    , UnionSigned (..)
    , UnionSimpleModule (..)
    , UnionSizeof (..)
    , UnionStackalloc (..)
    , UnionStandards (..)
    , UnionStatic (..)
    , UnionStaticAssert (..)
    , UnionStaticCast (..)
    , UnionStdDeserializer (..)
    , UnionStdSerializer (..)
    , UnionStrictfp (..)
    , UnionString (..)
    , UnionStruct (..)
    , UnionSubscript (..)
    , UnionSuper (..)
    , UnionSwitch (..)
    , UnionSymbol (..)
    , UnionSynchronized (..)
    , UnionSystem (..)
    , UnionTemplate (..)
    , UnionTextNode (..)
    , UnionThis (..)
    , UnionThreadLocal (..)
    , UnionThrow (..)
    , UnionThrows (..)
    , UnionTimeOnly (..)
    , UnionTimeOnlyConverter (..)
    , UnionTimeZone (..)
    , UnionToDict (..)
    , UnionToJSON (..)
    , UnionToString (..)
    , UnionTopLevel (..)
    , UnionTransient (..)
    , UnionTrue (..)
    , UnionTry (..)
    , UnionTypealias (..)
    , UnionTypedef (..)
    , UnionTypeid (..)
    , UnionTypename (..)
    , UnionTypeof (..)
    , UnionUint (..)
    , UnionUlong (..)
    , UnionUnchecked (..)
    , UnionUndefined (..)
    , UnionUnionUnion (..)
    , UnionUnmarshalJSON (..)
    , UnionUnowned (..)
    , UnionUnsafe (..)
    , UnionUnsigned (..)
    , UnionUseSerializers (..)
    , UnionUshort (..)
    , UnionUsing (..)
    , UnionUtf8JSONReader (..)
    , UnionUtf8JSONWriter (..)
    , UnionUUID (..)
    , UnionVar (..)
    , UnionVirtual (..)
    , UnionVoid (..)
    , UnionVolatile (..)
    , UnionWcharT (..)
    , UnionWeak (..)
    , UnionWhile (..)
    , UnionWillSet (..)
    , UnionWith (..)
    , UnionXor (..)
    , UnionXorEq (..)
    , UnionYES (..)
    , UnionYield (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { emptyQuickType :: Maybe UnionUnion
    , quickTypeBoolQuickType :: Maybe UnionBool
    , complexQuickType :: Maybe UnionComplex
    , imagineryQuickType :: Maybe UnionImaginery
    , abstractQuickType :: Maybe UnionAbstract
    , alignasQuickType :: Maybe UnionAlignas
    , alignofQuickType :: Maybe UnionAlignof
    , andQuickType :: Maybe UnionAnd
    , andEqQuickType :: Maybe UnionAndEq
    , quickTypeAnyQuickType :: Maybe UnionAnyUnion
    , anyQuickType :: Maybe UnionAny
    , arrayQuickType :: Maybe UnionArray
    , arrayNodeQuickType :: Maybe UnionArrayNode
    , quickTypeAsQuickType :: Maybe UnionAs
    , asmQuickType :: Maybe UnionASM
    , assertQuickType :: Maybe UnionAssert
    , associatedtypeQuickType :: Maybe UnionAssociatedtype
    , associativityQuickType :: Maybe UnionAssociativity
    , asyncQuickType :: Maybe UnionAsync
    , atomicQuickType :: Maybe UnionAtomic
    , atomicCancelQuickType :: Maybe UnionAtomicCancel
    , atomicCommitQuickType :: Maybe UnionAtomicCommit
    , atomicNoexceptQuickType :: Maybe UnionAtomicNoexcept
    , autoQuickType :: Maybe UnionAuto
    , awaitQuickType :: Maybe UnionAwait
    , baseQuickType :: Maybe UnionBase
    , bitandQuickType :: Maybe UnionBitand
    , bitorQuickType :: Maybe UnionBitor
    , boolQuickType :: Maybe UnionBOOL
    , purpleBoolQuickType :: Maybe UnionBoolUnion
    , booleanQuickType :: Maybe UnionBoolean
    , booleanNodeQuickType :: Maybe UnionBooleanNode
    , breakQuickType :: Maybe UnionBreak
    , bycopyQuickType :: Maybe UnionBycopy
    , byrefQuickType :: Maybe UnionByref
    , byteQuickType :: Maybe UnionByte
    , calendarQuickType :: Maybe UnionCalendar
    , quickTypeCaseQuickType :: Maybe UnionCase
    , catchQuickType :: Maybe UnionCatch
    , chanQuickType :: Maybe UnionChan
    , charQuickType :: Maybe UnionChar
    , char16TQuickType :: Maybe UnionChar16T
    , char32TQuickType :: Maybe UnionChar32T
    , checkedQuickType :: Maybe UnionChecked
    , purpleClassQuickType :: Maybe UnionClassUnion
    , quickTypeClassQuickType :: Maybe UnionClass
    , cloneQuickType :: Maybe UnionClone
    , coAwaitQuickType :: Maybe UnionCoAwait
    , coReturnQuickType :: Maybe UnionCoReturn
    , coYieldQuickType :: Maybe UnionCoYield
    , codableQuickType :: Maybe UnionCodable
    , codingKeyQuickType :: Maybe UnionCodingKey
    , codingKeysQuickType :: Maybe UnionCodingKeys
    , complQuickType :: Maybe UnionCompl
    , conceptQuickType :: Maybe UnionConcept
    , consoleQuickType :: Maybe UnionConsole
    , constQuickType :: Maybe UnionConst
    , constCastQuickType :: Maybe UnionConstCast
    , constexprQuickType :: Maybe UnionConstexpr
    , constructorQuickType :: Maybe UnionConstructor
    , continueQuickType :: Maybe UnionContinue
    , convenienceQuickType :: Maybe UnionConvenience
    , convertQuickType :: Maybe UnionConvert
    , converterQuickType :: Maybe UnionConverter
    , cultureInfoQuickType :: Maybe UnionCultureInfo
    , dateQuickType :: Maybe UnionDate
    , dateParseHandlingQuickType :: Maybe UnionDateParseHandling
    , dateFormatterQuickType :: Maybe UnionDateFormatter
    , dateOnlyQuickType :: Maybe UnionDateOnly
    , dateOnlyConverterQuickType :: Maybe UnionDateOnlyConverter
    , dateTimeQuickType :: Maybe UnionDateTime
    , dateTimeStylesQuickType :: Maybe UnionDateTimeStyles
    , debuggerQuickType :: Maybe UnionDebugger
    , decimalQuickType :: Maybe UnionDecimal
    , declareQuickType :: Maybe UnionDeclare
    , decltypeQuickType :: Maybe UnionDecltype
    , decodeStringQuickType :: Maybe UnionDecodeString
    , decoderQuickType :: Maybe UnionDecoder
    , decodingErrorQuickType :: Maybe UnionDecodingError
    , defQuickType :: Maybe UnionDef
    , quickTypeDefaultQuickType :: Maybe UnionDefault
    , deferQuickType :: Maybe UnionDefer
    , deinitQuickType :: Maybe UnionDeinit
    , delQuickType :: Maybe UnionDel
    , delegateQuickType :: Maybe UnionDelegate
    , deleteQuickType :: Maybe UnionDelete
    , deserializationFeatureQuickType :: Maybe UnionDeserializationFeature
    , dictQuickType :: Maybe UnionDict
    , dictionaryQuickType :: Maybe UnionDictionary
    , didSetQuickType :: Maybe UnionDidSet
    , quickTypeDoQuickType :: Maybe UnionDo
    , doubleQuickType :: Maybe UnionDouble
    , doubleNodeQuickType :: Maybe UnionDoubleNode
    , dummyQuickType :: Maybe Double
    , dynamicQuickType :: Maybe UnionDynamic
    , dynamicCastQuickType :: Maybe UnionDynamicCast
    , elifQuickType :: Maybe UnionElif
    , quickTypeElseQuickType :: Maybe UnionElse
    , encodeQuickTypeQuickType :: Maybe UnionEncodeQuickType
    , encoderQuickType :: Maybe UnionEncoder
    , enumQuickType :: Maybe UnionEnum
    , enumValuesQuickType :: Maybe UnionEnumValues
    , equalityContractQuickType :: Maybe UnionEqualityContract
    , equatableQuickType :: Maybe UnionEquatable
    , eventQuickType :: Maybe UnionEvent
    , exceptQuickType :: Maybe UnionExcept
    , exceptionQuickType :: Maybe UnionException
    , explicitQuickType :: Maybe UnionExplicit
    , exportQuickType :: Maybe UnionExport
    , exposingQuickType :: Maybe UnionExposing
    , extendsQuickType :: Maybe UnionExtends
    , extensionQuickType :: Maybe UnionExtension
    , externQuickType :: Maybe UnionExtern
    , fallthroughQuickType :: Maybe UnionFallthrough
    , quickTypeFalseQuickType :: Maybe UnionFalseUnion
    , falseQuickType :: Maybe UnionFalse
    , fileprivateQuickType :: Maybe UnionFileprivate
    , finalQuickType :: Maybe UnionFinal
    , finallyQuickType :: Maybe UnionFinally
    , fixedQuickType :: Maybe UnionFixed
    , floatQuickType :: Maybe UnionFloat
    , forQuickType :: Maybe UnionFor
    , foreachQuickType :: Maybe UnionForeach
    , formatExceptionQuickType :: Maybe UnionFormatException
    , friendQuickType :: Maybe UnionFriend
    , fromQuickType :: Maybe UnionFrom
    , fromDictQuickType :: Maybe UnionFromDict
    , fromJSONQuickType :: Maybe UnionFromJSON
    , funcQuickType :: Maybe UnionFunc
    , functionQuickType :: Maybe UnionFunction
    , getQuickType :: Maybe UnionGet
    , globalQuickType :: Maybe UnionGlobal
    , goQuickType :: Maybe UnionGo
    , gotoQuickType :: Maybe UnionGoto
    , guardQuickType :: Maybe UnionGuard
    , hashableQuickType :: Maybe UnionHashable
    , hashCodeQuickType :: Maybe UnionHashCode
    , hasherQuickType :: Maybe UnionHasher
    , hasOwnPropertyQuickType :: Maybe UnionHasOwnProperty
    , quickTypeIDQuickType :: Maybe UnionID
    , quickTypeIfQuickType :: Maybe UnionIf
    , impQuickType :: Maybe UnionIMP
    , implementsQuickType :: Maybe UnionImplements
    , implicitQuickType :: Maybe UnionImplicit
    , quickTypeImportQuickType :: Maybe UnionImport
    , quickTypeInQuickType :: Maybe UnionIn
    , indirectQuickType :: Maybe UnionIndirect
    , quickTypeInfixQuickType :: Maybe UnionInfix
    , initQuickType :: Maybe UnionInit
    , inlineQuickType :: Maybe UnionInline
    , inoutQuickType :: Maybe UnionInout
    , instanceofQuickType :: Maybe UnionInstanceof
    , intQuickType :: Maybe UnionInt
    , interfaceQuickType :: Maybe UnionInterface
    , internalQuickType :: Maybe UnionInternal
    , intNodeQuickType :: Maybe UnionIntNode
    , isQuickType :: Maybe UnionIs
    , isoDateTimeOffsetConverterQuickType :: Maybe UnionISODateTimeOffsetConverter
    , iterableQuickType :: Maybe UnionIterable
    , jdecQuickType :: Maybe UnionJdec
    , jencQuickType :: Maybe UnionJenc
    , jpipeQuickType :: Maybe UnionJpipe
    , jsonQuickType :: Maybe UnionJSON
    , jsonConverterQuickType :: Maybe UnionJSONConverter
    , jsonSerializerQuickType :: Maybe UnionJSONSerializer
    , jsonTokenQuickType :: Maybe UnionJSONToken
    , jsonWriterQuickType :: Maybe UnionJSONWriter
    , jsonAnyQuickType :: Maybe UnionJSONAny
    , jsonCodingKeyQuickType :: Maybe UnionJSONCodingKey
    , jsonDecoderQuickType :: Maybe UnionJSONDecoder
    , jsonEncoderQuickType :: Maybe UnionJSONEncoder
    , jsonExceptionQuickType :: Maybe UnionJSONException
    , jsonGeneratorQuickType :: Maybe UnionJSONGenerator
    , jsonNodeQuickType :: Maybe UnionJSONNode
    , jsonNullQuickType :: Maybe UnionJSONNull
    , jsonParserQuickType :: Maybe UnionJSONParser
    , jsonReaderQuickType :: Maybe UnionJSONReader
    , jsonTokenTypeQuickType :: Maybe UnionJSONTokenType
    , kSerializerQuickType :: Maybe UnionKSerializer
    , lambdaQuickType :: Maybe UnionLambda
    , lazyQuickType :: Maybe UnionLazy
    , leftQuickType :: Maybe UnionLeft
    , quickTypeLetQuickType :: Maybe UnionLet
    , listQuickType :: Maybe UnionList
    , localDateQuickType :: Maybe UnionLocalDate
    , localeQuickType :: Maybe UnionLocale
    , lockQuickType :: Maybe UnionLock
    , longQuickType :: Maybe UnionLong
    , longNodeQuickType :: Maybe UnionLongNode
    , mapQuickType :: Maybe UnionMap
    , mapEntryQuickType :: Maybe UnionMapEntry
    , marshalJSONQuickType :: Maybe UnionMarshalJSON
    , metadataPropertyHandlingQuickType :: Maybe UnionMetadataPropertyHandling
    , quickTypeModuleQuickType :: Maybe UnionModule
    , mutableQuickType :: Maybe UnionMutable
    , mutatingQuickType :: Maybe UnionMutating
    , namespaceQuickType :: Maybe UnionNamespace
    , nativeQuickType :: Maybe UnionNative
    , newQuickType :: Maybe UnionNew
    , newtonsoftQuickType :: Maybe UnionNewtonsoft
    , nilQuickType :: Maybe UnionNil
    , noQuickType :: Maybe UnionNO
    , noexceptQuickType :: Maybe UnionNoexcept
    , nonatomicQuickType :: Maybe UnionNonatomic
    , quickTypeNoneQuickType :: Maybe UnionNoneUnion
    , noneQuickType :: Maybe UnionNone
    , nonlocalQuickType :: Maybe UnionNonlocal
    , nonmutatingQuickType :: Maybe UnionNonmutating
    , noSuchMethodQuickType :: Maybe UnionNoSuchMethod
    , notQuickType :: Maybe UnionNot
    , notEqQuickType :: Maybe UnionNotEq
    , nsErrorQuickType :: Maybe UnionNSError
    , nsObjectQuickType :: Maybe UnionNSObject
    , nsStringQuickType :: Maybe UnionNSString
    , nullQuickType :: Maybe UnionNULL
    , quickTypeNullQuickType :: Maybe UnionNull
    , nullNodeQuickType :: Maybe UnionNullNode
    , nullptrQuickType :: Maybe UnionNullptr
    , numberQuickType :: Maybe UnionNumber
    , objectQuickType :: Maybe UnionObject
    , objectMapperQuickType :: Maybe UnionObjectMapper
    , objectNodeQuickType :: Maybe UnionObjectNode
    , objectReaderQuickType :: Maybe UnionObjectReader
    , objectWriterQuickType :: Maybe UnionObjectWriter
    , quickTypeOfQuickType :: Maybe UnionOf
    , offsetDateTimeQuickType :: Maybe UnionOffsetDateTime
    , offsetTimeQuickType :: Maybe UnionOffsetTime
    , onewayQuickType :: Maybe UnionOneway
    , openQuickType :: Maybe UnionOpen
    , operatorQuickType :: Maybe UnionOperator
    , optionalQuickType :: Maybe UnionOptional
    , orQuickType :: Maybe UnionOr
    , orEqQuickType :: Maybe UnionOrEq
    , outQuickType :: Maybe UnionOut
    , overrideQuickType :: Maybe UnionOverride
    , packageQuickType :: Maybe UnionPackage
    , paramsQuickType :: Maybe UnionParams
    , passQuickType :: Maybe UnionPass
    , portQuickType :: Maybe UnionPort
    , postfixQuickType :: Maybe UnionPostfix
    , precedenceQuickType :: Maybe UnionPrecedence
    , prefixQuickType :: Maybe UnionPrefix
    , primitiveKindQuickType :: Maybe UnionPrimitiveKind
    , printQuickType :: Maybe UnionPrint
    , printfQuickType :: Maybe UnionPrintf
    , printMembersQuickType :: Maybe UnionPrintMembers
    , privateQuickType :: Maybe UnionPrivate
    , protectedQuickType :: Maybe UnionProtected
    , protocolQuickType :: Maybe UnionProtocol
    , quickTypeProtocolQuickType :: Maybe UnionProtocolUnion
    , publicQuickType :: Maybe UnionPublic
    , quicktypeQuickType :: Maybe UnionQuicktype
    , raiseQuickType :: Maybe UnionRaise
    , rangeQuickType :: Maybe UnionRange
    , readonlyQuickType :: Maybe UnionReadonly
    , refQuickType :: Maybe UnionRef
    , regExpQuickType :: Maybe UnionRegExp
    , registerQuickType :: Maybe UnionRegister
    , reinterpretCastQuickType :: Maybe UnionReinterpretCast
    , repeatQuickType :: Maybe UnionRepeat
    , requireQuickType :: Maybe UnionRequire
    , requiredQuickType :: Maybe UnionRequired
    , requiresQuickType :: Maybe UnionRequires
    , restrictQuickType :: Maybe UnionRestrict
    , retainQuickType :: Maybe UnionRetain
    , rethrowsQuickType :: Maybe UnionRethrows
    , returnQuickType :: Maybe UnionReturn
    , rightQuickType :: Maybe UnionRight
    , runtimeTypeQuickType :: Maybe UnionRuntimeType
    , sQuickType :: Maybe UnionS
    , sbyteQuickType :: Maybe UnionSbyte
    , sealedQuickType :: Maybe UnionSealed
    , selQuickType :: Maybe UnionSEL
    , selectQuickType :: Maybe UnionSelect
    , selfQuickType :: Maybe UnionSelf
    , quickTypeSelfQuickType :: Maybe UnionSelfUnion
    , sendableQuickType :: Maybe UnionSendable
    , serialDescriptorQuickType :: Maybe UnionSerialDescriptor
    , serializableQuickType :: Maybe UnionSerializable
    , serializationFeatureQuickType :: Maybe UnionSerializationFeature
    , serializeQuickType :: Maybe UnionSerialize
    , serializerProviderQuickType :: Maybe UnionSerializerProvider
    , serialNameQuickType :: Maybe UnionSerialName
    , setQuickType :: Maybe UnionSet
    , shortQuickType :: Maybe UnionShort
    , signedQuickType :: Maybe UnionSigned
    , simpleModuleQuickType :: Maybe UnionSimpleModule
    , sizeofQuickType :: Maybe UnionSizeof
    , stackallocQuickType :: Maybe UnionStackalloc
    , standardsQuickType :: Maybe UnionStandards
    , staticQuickType :: Maybe UnionStatic
    , staticAssertQuickType :: Maybe UnionStaticAssert
    , staticCastQuickType :: Maybe UnionStaticCast
    , stdDeserializerQuickType :: Maybe UnionStdDeserializer
    , stdSerializerQuickType :: Maybe UnionStdSerializer
    , strictfpQuickType :: Maybe UnionStrictfp
    , stringQuickType :: Maybe UnionString
    , structQuickType :: Maybe UnionStruct
    , subscriptQuickType :: Maybe UnionSubscript
    , superQuickType :: Maybe UnionSuper
    , switchQuickType :: Maybe UnionSwitch
    , symbolQuickType :: Maybe UnionSymbol
    , synchronizedQuickType :: Maybe UnionSynchronized
    , systemQuickType :: Maybe UnionSystem
    , templateQuickType :: Maybe UnionTemplate
    , textNodeQuickType :: Maybe UnionTextNode
    , quickTypeThenQuickType :: Maybe UnionThen
    , thisQuickType :: Maybe UnionThis
    , threadLocalQuickType :: Maybe UnionThreadLocal
    , throwQuickType :: Maybe UnionThrow
    , throwsQuickType :: Maybe UnionThrows
    , timeOnlyQuickType :: Maybe UnionTimeOnly
    , timeOnlyConverterQuickType :: Maybe UnionTimeOnlyConverter
    , timeZoneQuickType :: Maybe UnionTimeZone
    , toDictQuickType :: Maybe UnionToDict
    , toJSONQuickType :: Maybe UnionToJSON
    , topLevelQuickType :: Maybe UnionTopLevel
    , toStringQuickType :: Maybe UnionToString
    , transientQuickType :: Maybe UnionTransient
    , trueQuickType :: Maybe UnionTrue
    , quickTypeTrueQuickType :: Maybe UnionTrueUnion
    , tryQuickType :: Maybe UnionTry
    , quickTypeTypeQuickType :: Maybe UnionType
    , purpleTypeQuickType :: Maybe UnionTypeUnion
    , typealiasQuickType :: Maybe UnionTypealias
    , typedefQuickType :: Maybe UnionTypedef
    , typeidQuickType :: Maybe UnionTypeid
    , typenameQuickType :: Maybe UnionTypename
    , typeofQuickType :: Maybe UnionTypeof
    , uintQuickType :: Maybe UnionUint
    , ulongQuickType :: Maybe UnionUlong
    , uncheckedQuickType :: Maybe UnionUnchecked
    , undefinedQuickType :: Maybe UnionUndefined
    , unionQuickType :: Maybe UnionUnionUnion
    , unmarshalJSONQuickType :: Maybe UnionUnmarshalJSON
    , unownedQuickType :: Maybe UnionUnowned
    , unsafeQuickType :: Maybe UnionUnsafe
    , unsignedQuickType :: Maybe UnionUnsigned
    , useSerializersQuickType :: Maybe UnionUseSerializers
    , ushortQuickType :: Maybe UnionUshort
    , usingQuickType :: Maybe UnionUsing
    , utf8JSONReaderQuickType :: Maybe UnionUtf8JSONReader
    , utf8JSONWriterQuickType :: Maybe UnionUtf8JSONWriter
    , uuidQuickType :: Maybe UnionUUID
    , varQuickType :: Maybe UnionVar
    , virtualQuickType :: Maybe UnionVirtual
    , voidQuickType :: Maybe UnionVoid
    , volatileQuickType :: Maybe UnionVolatile
    , wcharTQuickType :: Maybe UnionWcharT
    , weakQuickType :: Maybe UnionWeak
    , quickTypeWhereQuickType :: Maybe UnionWhere
    , whileQuickType :: Maybe UnionWhile
    , willSetQuickType :: Maybe UnionWillSet
    , withQuickType :: Maybe UnionWith
    , xorQuickType :: Maybe UnionXor
    , xorEqQuickType :: Maybe UnionXorEq
    , yesQuickType :: Maybe UnionYES
    , yieldQuickType :: Maybe UnionYield
    } deriving (Show)

data UnionAbstract
    = AbstractInUnionAbstract Abstract
    | DoubleInUnionAbstract Double
    deriving (Show)

data Abstract = Abstract
    {
    } deriving (Show)

data UnionAlignas
    = AlignasInUnionAlignas Alignas
    | DoubleInUnionAlignas Double
    deriving (Show)

data Alignas = Alignas
    {
    } deriving (Show)

data UnionAlignof
    = AlignofInUnionAlignof Alignof
    | DoubleInUnionAlignof Double
    deriving (Show)

data Alignof = Alignof
    {
    } deriving (Show)

data UnionAnd
    = AndInUnionAnd And
    | DoubleInUnionAnd Double
    deriving (Show)

data And = And
    {
    } deriving (Show)

data UnionAndEq
    = AndEqInUnionAndEq AndEq
    | DoubleInUnionAndEq Double
    deriving (Show)

data AndEq = AndEq
    {
    } deriving (Show)

data UnionAny
    = AnyInUnionAny Any
    | DoubleInUnionAny Double
    deriving (Show)

data Any = Any
    {
    } deriving (Show)

data UnionArray
    = ArrayClassInUnionArray ArrayClass
    | DoubleInUnionArray Double
    deriving (Show)

data ArrayClass = ArrayClass
    {
    } deriving (Show)

data UnionArrayNode
    = ArrayNodeInUnionArrayNode ArrayNode
    | DoubleInUnionArrayNode Double
    deriving (Show)

data ArrayNode = ArrayNode
    {
    } deriving (Show)

data UnionASM
    = ASMInUnionASM ASM
    | DoubleInUnionASM Double
    deriving (Show)

data ASM = ASM
    {
    } deriving (Show)

data UnionAssert
    = AssertInUnionAssert Assert
    | DoubleInUnionAssert Double
    deriving (Show)

data Assert = Assert
    {
    } deriving (Show)

data UnionAssociatedtype
    = AssociatedtypeInUnionAssociatedtype Associatedtype
    | DoubleInUnionAssociatedtype Double
    deriving (Show)

data Associatedtype = Associatedtype
    {
    } deriving (Show)

data UnionAssociativity
    = AssociativityInUnionAssociativity Associativity
    | DoubleInUnionAssociativity Double
    deriving (Show)

data Associativity = Associativity
    {
    } deriving (Show)

data UnionAsync
    = AsyncInUnionAsync Async
    | DoubleInUnionAsync Double
    deriving (Show)

data Async = Async
    {
    } deriving (Show)

data UnionAtomic
    = AtomicInUnionAtomic Atomic
    | DoubleInUnionAtomic Double
    deriving (Show)

data Atomic = Atomic
    {
    } deriving (Show)

data UnionAtomicCancel
    = AtomicCancelInUnionAtomicCancel AtomicCancel
    | DoubleInUnionAtomicCancel Double
    deriving (Show)

data AtomicCancel = AtomicCancel
    {
    } deriving (Show)

data UnionAtomicCommit
    = AtomicCommitInUnionAtomicCommit AtomicCommit
    | DoubleInUnionAtomicCommit Double
    deriving (Show)

data AtomicCommit = AtomicCommit
    {
    } deriving (Show)

data UnionAtomicNoexcept
    = AtomicNoexceptInUnionAtomicNoexcept AtomicNoexcept
    | DoubleInUnionAtomicNoexcept Double
    deriving (Show)

data AtomicNoexcept = AtomicNoexcept
    {
    } deriving (Show)

data UnionAuto
    = AutoInUnionAuto Auto
    | DoubleInUnionAuto Double
    deriving (Show)

data Auto = Auto
    {
    } deriving (Show)

data UnionAwait
    = AwaitInUnionAwait Await
    | DoubleInUnionAwait Double
    deriving (Show)

data Await = Await
    {
    } deriving (Show)

data UnionBase
    = BaseInUnionBase Base
    | DoubleInUnionBase Double
    deriving (Show)

data Base = Base
    {
    } deriving (Show)

data UnionBitand
    = BitandInUnionBitand Bitand
    | DoubleInUnionBitand Double
    deriving (Show)

data Bitand = Bitand
    {
    } deriving (Show)

data UnionBitor
    = BitorInUnionBitor Bitor
    | DoubleInUnionBitor Double
    deriving (Show)

data Bitor = Bitor
    {
    } deriving (Show)

data UnionBOOL
    = BOOLClassInUnionBOOL BOOLClass
    | DoubleInUnionBOOL Double
    deriving (Show)

data BOOLClass = BOOLClass
    {
    } deriving (Show)

data UnionBoolean
    = BooleanInUnionBoolean Boolean
    | DoubleInUnionBoolean Double
    deriving (Show)

data Boolean = Boolean
    {
    } deriving (Show)

data UnionBooleanNode
    = BooleanNodeInUnionBooleanNode BooleanNode
    | DoubleInUnionBooleanNode Double
    deriving (Show)

data BooleanNode = BooleanNode
    {
    } deriving (Show)

data UnionBreak
    = BreakInUnionBreak Break
    | DoubleInUnionBreak Double
    deriving (Show)

data Break = Break
    {
    } deriving (Show)

data UnionBycopy
    = BycopyInUnionBycopy Bycopy
    | DoubleInUnionBycopy Double
    deriving (Show)

data Bycopy = Bycopy
    {
    } deriving (Show)

data UnionByref
    = ByrefInUnionByref Byref
    | DoubleInUnionByref Double
    deriving (Show)

data Byref = Byref
    {
    } deriving (Show)

data UnionByte
    = ByteInUnionByte Byte
    | DoubleInUnionByte Double
    deriving (Show)

data Byte = Byte
    {
    } deriving (Show)

data UnionCalendar
    = CalendarInUnionCalendar Calendar
    | DoubleInUnionCalendar Double
    deriving (Show)

data Calendar = Calendar
    {
    } deriving (Show)

data UnionCatch
    = CatchInUnionCatch Catch
    | DoubleInUnionCatch Double
    deriving (Show)

data Catch = Catch
    {
    } deriving (Show)

data UnionChan
    = ChanInUnionChan Chan
    | DoubleInUnionChan Double
    deriving (Show)

data Chan = Chan
    {
    } deriving (Show)

data UnionChar
    = CharClassInUnionChar CharClass
    | DoubleInUnionChar Double
    deriving (Show)

data CharClass = CharClass
    {
    } deriving (Show)

data UnionChar16T
    = Char16TInUnionChar16T Char16T
    | DoubleInUnionChar16T Double
    deriving (Show)

data Char16T = Char16T
    {
    } deriving (Show)

data UnionChar32T
    = Char32TInUnionChar32T Char32T
    | DoubleInUnionChar32T Double
    deriving (Show)

data Char32T = Char32T
    {
    } deriving (Show)

data UnionChecked
    = CheckedInUnionChecked Checked
    | DoubleInUnionChecked Double
    deriving (Show)

data Checked = Checked
    {
    } deriving (Show)

data UnionClone
    = CloneInUnionClone Clone
    | DoubleInUnionClone Double
    deriving (Show)

data Clone = Clone
    {
    } deriving (Show)

data UnionCoAwait
    = CoAwaitInUnionCoAwait CoAwait
    | DoubleInUnionCoAwait Double
    deriving (Show)

data CoAwait = CoAwait
    {
    } deriving (Show)

data UnionCoReturn
    = CoReturnInUnionCoReturn CoReturn
    | DoubleInUnionCoReturn Double
    deriving (Show)

data CoReturn = CoReturn
    {
    } deriving (Show)

data UnionCoYield
    = CoYieldInUnionCoYield CoYield
    | DoubleInUnionCoYield Double
    deriving (Show)

data CoYield = CoYield
    {
    } deriving (Show)

data UnionCodable
    = CodableInUnionCodable Codable
    | DoubleInUnionCodable Double
    deriving (Show)

data Codable = Codable
    {
    } deriving (Show)

data UnionCodingKey
    = CodingKeyInUnionCodingKey CodingKey
    | DoubleInUnionCodingKey Double
    deriving (Show)

data CodingKey = CodingKey
    {
    } deriving (Show)

data UnionCodingKeys
    = CodingKeysInUnionCodingKeys CodingKeys
    | DoubleInUnionCodingKeys Double
    deriving (Show)

data CodingKeys = CodingKeys
    {
    } deriving (Show)

data UnionCompl
    = ComplInUnionCompl Compl
    | DoubleInUnionCompl Double
    deriving (Show)

data Compl = Compl
    {
    } deriving (Show)

data UnionComplex
    = ComplexInUnionComplex Complex
    | DoubleInUnionComplex Double
    deriving (Show)

data Complex = Complex
    {
    } deriving (Show)

data UnionConcept
    = ConceptInUnionConcept Concept
    | DoubleInUnionConcept Double
    deriving (Show)

data Concept = Concept
    {
    } deriving (Show)

data UnionConsole
    = ConsoleInUnionConsole Console
    | DoubleInUnionConsole Double
    deriving (Show)

data Console = Console
    {
    } deriving (Show)

data UnionConst
    = ConstInUnionConst Const
    | DoubleInUnionConst Double
    deriving (Show)

data Const = Const
    {
    } deriving (Show)

data UnionConstCast
    = ConstCastInUnionConstCast ConstCast
    | DoubleInUnionConstCast Double
    deriving (Show)

data ConstCast = ConstCast
    {
    } deriving (Show)

data UnionConstexpr
    = ConstexprInUnionConstexpr Constexpr
    | DoubleInUnionConstexpr Double
    deriving (Show)

data Constexpr = Constexpr
    {
    } deriving (Show)

data UnionConstructor
    = ConstructorInUnionConstructor Constructor
    | DoubleInUnionConstructor Double
    deriving (Show)

data Constructor = Constructor
    {
    } deriving (Show)

data UnionContinue
    = ContinueInUnionContinue Continue
    | DoubleInUnionContinue Double
    deriving (Show)

data Continue = Continue
    {
    } deriving (Show)

data UnionConvenience
    = ConvenienceInUnionConvenience Convenience
    | DoubleInUnionConvenience Double
    deriving (Show)

data Convenience = Convenience
    {
    } deriving (Show)

data UnionConvert
    = ConvertInUnionConvert Convert
    | DoubleInUnionConvert Double
    deriving (Show)

data Convert = Convert
    {
    } deriving (Show)

data UnionConverter
    = ConverterInUnionConverter Converter
    | DoubleInUnionConverter Double
    deriving (Show)

data Converter = Converter
    {
    } deriving (Show)

data UnionCultureInfo
    = CultureInfoInUnionCultureInfo CultureInfo
    | DoubleInUnionCultureInfo Double
    deriving (Show)

data CultureInfo = CultureInfo
    {
    } deriving (Show)

data UnionDate
    = DateInUnionDate Date
    | DoubleInUnionDate Double
    deriving (Show)

data Date = Date
    {
    } deriving (Show)

data UnionDateFormatter
    = DateFormatterInUnionDateFormatter DateFormatter
    | DoubleInUnionDateFormatter Double
    deriving (Show)

data DateFormatter = DateFormatter
    {
    } deriving (Show)

data UnionDateOnly
    = DateOnlyInUnionDateOnly DateOnly
    | DoubleInUnionDateOnly Double
    deriving (Show)

data DateOnly = DateOnly
    {
    } deriving (Show)

data UnionDateOnlyConverter
    = DateOnlyConverterInUnionDateOnlyConverter DateOnlyConverter
    | DoubleInUnionDateOnlyConverter Double
    deriving (Show)

data DateOnlyConverter = DateOnlyConverter
    {
    } deriving (Show)

data UnionDateParseHandling
    = DateParseHandlingInUnionDateParseHandling DateParseHandling
    | DoubleInUnionDateParseHandling Double
    deriving (Show)

data DateParseHandling = DateParseHandling
    {
    } deriving (Show)

data UnionDateTime
    = DateTimeInUnionDateTime DateTime
    | DoubleInUnionDateTime Double
    deriving (Show)

data DateTime = DateTime
    {
    } deriving (Show)

data UnionDateTimeStyles
    = DateTimeStylesInUnionDateTimeStyles DateTimeStyles
    | DoubleInUnionDateTimeStyles Double
    deriving (Show)

data DateTimeStyles = DateTimeStyles
    {
    } deriving (Show)

data UnionDebugger
    = DebuggerInUnionDebugger Debugger
    | DoubleInUnionDebugger Double
    deriving (Show)

data Debugger = Debugger
    {
    } deriving (Show)

data UnionDecimal
    = DecimalInUnionDecimal Decimal
    | DoubleInUnionDecimal Double
    deriving (Show)

data Decimal = Decimal
    {
    } deriving (Show)

data UnionDeclare
    = DeclareInUnionDeclare Declare
    | DoubleInUnionDeclare Double
    deriving (Show)

data Declare = Declare
    {
    } deriving (Show)

data UnionDecltype
    = DecltypeInUnionDecltype Decltype
    | DoubleInUnionDecltype Double
    deriving (Show)

data Decltype = Decltype
    {
    } deriving (Show)

data UnionDecodeString
    = DecodeStringInUnionDecodeString DecodeString
    | DoubleInUnionDecodeString Double
    deriving (Show)

data DecodeString = DecodeString
    {
    } deriving (Show)

data UnionDecoder
    = DecoderInUnionDecoder Decoder
    | DoubleInUnionDecoder Double
    deriving (Show)

data Decoder = Decoder
    {
    } deriving (Show)

data UnionDecodingError
    = DecodingErrorInUnionDecodingError DecodingError
    | DoubleInUnionDecodingError Double
    deriving (Show)

data DecodingError = DecodingError
    {
    } deriving (Show)

data UnionDef
    = DefInUnionDef Def
    | DoubleInUnionDef Double
    deriving (Show)

data Def = Def
    {
    } deriving (Show)

data UnionDefer
    = DeferInUnionDefer Defer
    | DoubleInUnionDefer Double
    deriving (Show)

data Defer = Defer
    {
    } deriving (Show)

data UnionDeinit
    = DeinitInUnionDeinit Deinit
    | DoubleInUnionDeinit Double
    deriving (Show)

data Deinit = Deinit
    {
    } deriving (Show)

data UnionDel
    = DelInUnionDel Del
    | DoubleInUnionDel Double
    deriving (Show)

data Del = Del
    {
    } deriving (Show)

data UnionDelegate
    = DelegateInUnionDelegate Delegate
    | DoubleInUnionDelegate Double
    deriving (Show)

data Delegate = Delegate
    {
    } deriving (Show)

data UnionDelete
    = DeleteInUnionDelete Delete
    | DoubleInUnionDelete Double
    deriving (Show)

data Delete = Delete
    {
    } deriving (Show)

data UnionDeserializationFeature
    = DeserializationFeatureInUnionDeserializationFeature DeserializationFeature
    | DoubleInUnionDeserializationFeature Double
    deriving (Show)

data DeserializationFeature = DeserializationFeature
    {
    } deriving (Show)

data UnionDict
    = DictInUnionDict Dict
    | DoubleInUnionDict Double
    deriving (Show)

data Dict = Dict
    {
    } deriving (Show)

data UnionDictionary
    = DictionaryInUnionDictionary Dictionary
    | DoubleInUnionDictionary Double
    deriving (Show)

data Dictionary = Dictionary
    {
    } deriving (Show)

data UnionDidSet
    = DidSetInUnionDidSet DidSet
    | DoubleInUnionDidSet Double
    deriving (Show)

data DidSet = DidSet
    {
    } deriving (Show)

data UnionDouble
    = DoubleClassInUnionDouble DoubleClass
    | DoubleInUnionDouble Double
    deriving (Show)

data DoubleClass = DoubleClass
    {
    } deriving (Show)

data UnionDoubleNode
    = DoubleInUnionDoubleNode Double
    | DoubleNodeInUnionDoubleNode DoubleNode
    deriving (Show)

data DoubleNode = DoubleNode
    {
    } deriving (Show)

data UnionDynamic
    = DoubleInUnionDynamic Double
    | DynamicInUnionDynamic Dynamic
    deriving (Show)

data Dynamic = Dynamic
    {
    } deriving (Show)

data UnionDynamicCast
    = DoubleInUnionDynamicCast Double
    | DynamicCastInUnionDynamicCast DynamicCast
    deriving (Show)

data DynamicCast = DynamicCast
    {
    } deriving (Show)

data UnionElif
    = DoubleInUnionElif Double
    | ElifInUnionElif Elif
    deriving (Show)

data Elif = Elif
    {
    } deriving (Show)

data UnionUnion
    = DoubleInUnionUnion Double
    | EmptyInUnionUnion Empty
    deriving (Show)

data Empty = Empty
    {
    } deriving (Show)

data UnionEncodeQuickType
    = DoubleInUnionEncodeQuickType Double
    | EncodeQuickTypeInUnionEncodeQuickType EncodeQuickType
    deriving (Show)

data EncodeQuickType = EncodeQuickType
    {
    } deriving (Show)

data UnionEncoder
    = DoubleInUnionEncoder Double
    | EncoderInUnionEncoder Encoder
    deriving (Show)

data Encoder = Encoder
    {
    } deriving (Show)

data UnionEnum
    = DoubleInUnionEnum Double
    | EnumClassInUnionEnum EnumClass
    deriving (Show)

data EnumClass = EnumClass
    {
    } deriving (Show)

data UnionEnumValues
    = DoubleInUnionEnumValues Double
    | EnumValuesInUnionEnumValues EnumValues
    deriving (Show)

data EnumValues = EnumValues
    {
    } deriving (Show)

data UnionEqualityContract
    = DoubleInUnionEqualityContract Double
    | EqualityContractInUnionEqualityContract EqualityContract
    deriving (Show)

data EqualityContract = EqualityContract
    {
    } deriving (Show)

data UnionEquatable
    = DoubleInUnionEquatable Double
    | EquatableInUnionEquatable Equatable
    deriving (Show)

data Equatable = Equatable
    {
    } deriving (Show)

data UnionEvent
    = DoubleInUnionEvent Double
    | EventInUnionEvent Event
    deriving (Show)

data Event = Event
    {
    } deriving (Show)

data UnionExcept
    = DoubleInUnionExcept Double
    | ExceptInUnionExcept Except
    deriving (Show)

data Except = Except
    {
    } deriving (Show)

data UnionException
    = DoubleInUnionException Double
    | ExceptionInUnionException Exception
    deriving (Show)

data Exception = Exception
    {
    } deriving (Show)

data UnionExplicit
    = DoubleInUnionExplicit Double
    | ExplicitInUnionExplicit Explicit
    deriving (Show)

data Explicit = Explicit
    {
    } deriving (Show)

data UnionExport
    = DoubleInUnionExport Double
    | ExportInUnionExport Export
    deriving (Show)

data Export = Export
    {
    } deriving (Show)

data UnionExposing
    = DoubleInUnionExposing Double
    | ExposingInUnionExposing Exposing
    deriving (Show)

data Exposing = Exposing
    {
    } deriving (Show)

data UnionExtends
    = DoubleInUnionExtends Double
    | ExtendsInUnionExtends Extends
    deriving (Show)

data Extends = Extends
    {
    } deriving (Show)

data UnionExtension
    = DoubleInUnionExtension Double
    | ExtensionInUnionExtension Extension
    deriving (Show)

data Extension = Extension
    {
    } deriving (Show)

data UnionExtern
    = DoubleInUnionExtern Double
    | ExternInUnionExtern Extern
    deriving (Show)

data Extern = Extern
    {
    } deriving (Show)

data UnionFallthrough
    = DoubleInUnionFallthrough Double
    | FallthroughInUnionFallthrough Fallthrough
    deriving (Show)

data Fallthrough = Fallthrough
    {
    } deriving (Show)

data UnionFalse
    = DoubleInUnionFalse Double
    | FalseClassInUnionFalse FalseClass
    deriving (Show)

data FalseClass = FalseClass
    {
    } deriving (Show)

data UnionFileprivate
    = DoubleInUnionFileprivate Double
    | FileprivateInUnionFileprivate Fileprivate
    deriving (Show)

data Fileprivate = Fileprivate
    {
    } deriving (Show)

data UnionFinal
    = DoubleInUnionFinal Double
    | FinalInUnionFinal Final
    deriving (Show)

data Final = Final
    {
    } deriving (Show)

data UnionFinally
    = DoubleInUnionFinally Double
    | FinallyInUnionFinally Finally
    deriving (Show)

data Finally = Finally
    {
    } deriving (Show)

data UnionFixed
    = DoubleInUnionFixed Double
    | FixedInUnionFixed Fixed
    deriving (Show)

data Fixed = Fixed
    {
    } deriving (Show)

data UnionFloat
    = DoubleInUnionFloat Double
    | FloatClassInUnionFloat FloatClass
    deriving (Show)

data FloatClass = FloatClass
    {
    } deriving (Show)

data UnionFor
    = DoubleInUnionFor Double
    | ForInUnionFor For
    deriving (Show)

data For = For
    {
    } deriving (Show)

data UnionForeach
    = DoubleInUnionForeach Double
    | ForeachInUnionForeach Foreach
    deriving (Show)

data Foreach = Foreach
    {
    } deriving (Show)

data UnionFormatException
    = DoubleInUnionFormatException Double
    | FormatExceptionInUnionFormatException FormatException
    deriving (Show)

data FormatException = FormatException
    {
    } deriving (Show)

data UnionFriend
    = DoubleInUnionFriend Double
    | FriendInUnionFriend Friend
    deriving (Show)

data Friend = Friend
    {
    } deriving (Show)

data UnionFrom
    = DoubleInUnionFrom Double
    | FromInUnionFrom From
    deriving (Show)

data From = From
    {
    } deriving (Show)

data UnionFromDict
    = DoubleInUnionFromDict Double
    | FromDictInUnionFromDict FromDict
    deriving (Show)

data FromDict = FromDict
    {
    } deriving (Show)

data UnionFromJSON
    = DoubleInUnionFromJSON Double
    | FromJSONClassInUnionFromJSON FromJSONClass
    deriving (Show)

data FromJSONClass = FromJSONClass
    {
    } deriving (Show)

data UnionFunc
    = DoubleInUnionFunc Double
    | FuncInUnionFunc Func
    deriving (Show)

data Func = Func
    {
    } deriving (Show)

data UnionFunction
    = DoubleInUnionFunction Double
    | FunctionInUnionFunction Function
    deriving (Show)

data Function = Function
    {
    } deriving (Show)

data UnionGet
    = DoubleInUnionGet Double
    | GetInUnionGet Get
    deriving (Show)

data Get = Get
    {
    } deriving (Show)

data UnionGlobal
    = DoubleInUnionGlobal Double
    | GlobalInUnionGlobal Global
    deriving (Show)

data Global = Global
    {
    } deriving (Show)

data UnionGo
    = DoubleInUnionGo Double
    | GoInUnionGo Go
    deriving (Show)

data Go = Go
    {
    } deriving (Show)

data UnionGoto
    = DoubleInUnionGoto Double
    | GotoInUnionGoto Goto
    deriving (Show)

data Goto = Goto
    {
    } deriving (Show)

data UnionGuard
    = DoubleInUnionGuard Double
    | GuardInUnionGuard Guard
    deriving (Show)

data Guard = Guard
    {
    } deriving (Show)

data UnionHasOwnProperty
    = DoubleInUnionHasOwnProperty Double
    | HasOwnPropertyInUnionHasOwnProperty HasOwnProperty
    deriving (Show)

data HasOwnProperty = HasOwnProperty
    {
    } deriving (Show)

data UnionHashCode
    = DoubleInUnionHashCode Double
    | HashCodeInUnionHashCode HashCode
    deriving (Show)

data HashCode = HashCode
    {
    } deriving (Show)

data UnionHashable
    = DoubleInUnionHashable Double
    | HashableInUnionHashable Hashable
    deriving (Show)

data Hashable = Hashable
    {
    } deriving (Show)

data UnionHasher
    = DoubleInUnionHasher Double
    | HasherInUnionHasher Hasher
    deriving (Show)

data Hasher = Hasher
    {
    } deriving (Show)

data UnionImaginery
    = DoubleInUnionImaginery Double
    | ImagineryInUnionImaginery Imaginery
    deriving (Show)

data Imaginery = Imaginery
    {
    } deriving (Show)

data UnionIMP
    = DoubleInUnionIMP Double
    | ImpInUnionIMP Imp
    deriving (Show)

data Imp = Imp
    {
    } deriving (Show)

data UnionImplements
    = DoubleInUnionImplements Double
    | ImplementsInUnionImplements Implements
    deriving (Show)

data Implements = Implements
    {
    } deriving (Show)

data UnionImplicit
    = DoubleInUnionImplicit Double
    | ImplicitInUnionImplicit Implicit
    deriving (Show)

data Implicit = Implicit
    {
    } deriving (Show)

data UnionIndirect
    = DoubleInUnionIndirect Double
    | IndirectInUnionIndirect Indirect
    deriving (Show)

data Indirect = Indirect
    {
    } deriving (Show)

data UnionInit
    = DoubleInUnionInit Double
    | InitInUnionInit Init
    deriving (Show)

data Init = Init
    {
    } deriving (Show)

data UnionInline
    = DoubleInUnionInline Double
    | InlineInUnionInline Inline
    deriving (Show)

data Inline = Inline
    {
    } deriving (Show)

data UnionInout
    = DoubleInUnionInout Double
    | InoutInUnionInout Inout
    deriving (Show)

data Inout = Inout
    {
    } deriving (Show)

data UnionInstanceof
    = DoubleInUnionInstanceof Double
    | InstanceofInUnionInstanceof Instanceof
    deriving (Show)

data Instanceof = Instanceof
    {
    } deriving (Show)

data UnionInt
    = DoubleInUnionInt Double
    | IntClassInUnionInt IntClass
    deriving (Show)

data IntClass = IntClass
    {
    } deriving (Show)

data UnionIntNode
    = DoubleInUnionIntNode Double
    | IntNodeInUnionIntNode IntNode
    deriving (Show)

data IntNode = IntNode
    {
    } deriving (Show)

data UnionInterface
    = DoubleInUnionInterface Double
    | InterfaceInUnionInterface Interface
    deriving (Show)

data Interface = Interface
    {
    } deriving (Show)

data UnionInternal
    = DoubleInUnionInternal Double
    | InternalInUnionInternal Internal
    deriving (Show)

data Internal = Internal
    {
    } deriving (Show)

data UnionIs
    = DoubleInUnionIs Double
    | IsInUnionIs Is
    deriving (Show)

data Is = Is
    {
    } deriving (Show)

data UnionISODateTimeOffsetConverter
    = DoubleInUnionISODateTimeOffsetConverter Double
    | ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter ISODateTimeOffsetConverter
    deriving (Show)

data ISODateTimeOffsetConverter = ISODateTimeOffsetConverter
    {
    } deriving (Show)

data UnionIterable
    = DoubleInUnionIterable Double
    | IterableInUnionIterable Iterable
    deriving (Show)

data Iterable = Iterable
    {
    } deriving (Show)

data UnionJdec
    = DoubleInUnionJdec Double
    | JdecInUnionJdec Jdec
    deriving (Show)

data Jdec = Jdec
    {
    } deriving (Show)

data UnionJenc
    = DoubleInUnionJenc Double
    | JencInUnionJenc Jenc
    deriving (Show)

data Jenc = Jenc
    {
    } deriving (Show)

data UnionJpipe
    = DoubleInUnionJpipe Double
    | JpipeInUnionJpipe Jpipe
    deriving (Show)

data Jpipe = Jpipe
    {
    } deriving (Show)

data UnionJSON
    = DoubleInUnionJSON Double
    | JSONInUnionJSON JSON
    deriving (Show)

data JSON = JSON
    {
    } deriving (Show)

data UnionJSONAny
    = DoubleInUnionJSONAny Double
    | JSONAnyInUnionJSONAny JSONAny
    deriving (Show)

data JSONAny = JSONAny
    {
    } deriving (Show)

data UnionJSONCodingKey
    = DoubleInUnionJSONCodingKey Double
    | JSONCodingKeyInUnionJSONCodingKey JSONCodingKey
    deriving (Show)

data JSONCodingKey = JSONCodingKey
    {
    } deriving (Show)

data UnionJSONConverter
    = DoubleInUnionJSONConverter Double
    | JSONConverterInUnionJSONConverter JSONConverter
    deriving (Show)

data JSONConverter = JSONConverter
    {
    } deriving (Show)

data UnionJSONDecoder
    = DoubleInUnionJSONDecoder Double
    | JSONDecoderInUnionJSONDecoder JSONDecoder
    deriving (Show)

data JSONDecoder = JSONDecoder
    {
    } deriving (Show)

data UnionJSONEncoder
    = DoubleInUnionJSONEncoder Double
    | JSONEncoderInUnionJSONEncoder JSONEncoder
    deriving (Show)

data JSONEncoder = JSONEncoder
    {
    } deriving (Show)

data UnionJSONException
    = DoubleInUnionJSONException Double
    | JSONExceptionInUnionJSONException JSONException
    deriving (Show)

data JSONException = JSONException
    {
    } deriving (Show)

data UnionJSONGenerator
    = DoubleInUnionJSONGenerator Double
    | JSONGeneratorInUnionJSONGenerator JSONGenerator
    deriving (Show)

data JSONGenerator = JSONGenerator
    {
    } deriving (Show)

data UnionJSONNode
    = DoubleInUnionJSONNode Double
    | JSONNodeInUnionJSONNode JSONNode
    deriving (Show)

data JSONNode = JSONNode
    {
    } deriving (Show)

data UnionJSONNull
    = DoubleInUnionJSONNull Double
    | JSONNullInUnionJSONNull JSONNull
    deriving (Show)

data JSONNull = JSONNull
    {
    } deriving (Show)

data UnionJSONParser
    = DoubleInUnionJSONParser Double
    | JSONParserInUnionJSONParser JSONParser
    deriving (Show)

data JSONParser = JSONParser
    {
    } deriving (Show)

data UnionJSONReader
    = DoubleInUnionJSONReader Double
    | JSONReaderInUnionJSONReader JSONReader
    deriving (Show)

data JSONReader = JSONReader
    {
    } deriving (Show)

data UnionJSONSerializer
    = DoubleInUnionJSONSerializer Double
    | JSONSerializerInUnionJSONSerializer JSONSerializer
    deriving (Show)

data JSONSerializer = JSONSerializer
    {
    } deriving (Show)

data UnionJSONToken
    = DoubleInUnionJSONToken Double
    | JSONTokenInUnionJSONToken JSONToken
    deriving (Show)

data JSONToken = JSONToken
    {
    } deriving (Show)

data UnionJSONTokenType
    = DoubleInUnionJSONTokenType Double
    | JSONTokenTypeInUnionJSONTokenType JSONTokenType
    deriving (Show)

data JSONTokenType = JSONTokenType
    {
    } deriving (Show)

data UnionJSONWriter
    = DoubleInUnionJSONWriter Double
    | JSONWriterInUnionJSONWriter JSONWriter
    deriving (Show)

data JSONWriter = JSONWriter
    {
    } deriving (Show)

data UnionKSerializer
    = DoubleInUnionKSerializer Double
    | KSerializerInUnionKSerializer KSerializer
    deriving (Show)

data KSerializer = KSerializer
    {
    } deriving (Show)

data UnionLambda
    = DoubleInUnionLambda Double
    | LambdaInUnionLambda Lambda
    deriving (Show)

data Lambda = Lambda
    {
    } deriving (Show)

data UnionLazy
    = DoubleInUnionLazy Double
    | LazyInUnionLazy Lazy
    deriving (Show)

data Lazy = Lazy
    {
    } deriving (Show)

data UnionLeft
    = DoubleInUnionLeft Double
    | LeftClassInUnionLeft LeftClass
    deriving (Show)

data LeftClass = LeftClass
    {
    } deriving (Show)

data UnionList
    = DoubleInUnionList Double
    | ListInUnionList List
    deriving (Show)

data List = List
    {
    } deriving (Show)

data UnionLocalDate
    = DoubleInUnionLocalDate Double
    | LocalDateInUnionLocalDate LocalDate
    deriving (Show)

data LocalDate = LocalDate
    {
    } deriving (Show)

data UnionLocale
    = DoubleInUnionLocale Double
    | LocaleInUnionLocale Locale
    deriving (Show)

data Locale = Locale
    {
    } deriving (Show)

data UnionLock
    = DoubleInUnionLock Double
    | LockInUnionLock Lock
    deriving (Show)

data Lock = Lock
    {
    } deriving (Show)

data UnionLong
    = DoubleInUnionLong Double
    | LongInUnionLong Long
    deriving (Show)

data Long = Long
    {
    } deriving (Show)

data UnionLongNode
    = DoubleInUnionLongNode Double
    | LongNodeInUnionLongNode LongNode
    deriving (Show)

data LongNode = LongNode
    {
    } deriving (Show)

data UnionMap
    = DoubleInUnionMap Double
    | MapClassInUnionMap MapClass
    deriving (Show)

data MapClass = MapClass
    {
    } deriving (Show)

data UnionMapEntry
    = DoubleInUnionMapEntry Double
    | MapEntryInUnionMapEntry MapEntry
    deriving (Show)

data MapEntry = MapEntry
    {
    } deriving (Show)

data UnionMarshalJSON
    = DoubleInUnionMarshalJSON Double
    | MarshalJSONInUnionMarshalJSON MarshalJSON
    deriving (Show)

data MarshalJSON = MarshalJSON
    {
    } deriving (Show)

data UnionMetadataPropertyHandling
    = DoubleInUnionMetadataPropertyHandling Double
    | MetadataPropertyHandlingInUnionMetadataPropertyHandling MetadataPropertyHandling
    deriving (Show)

data MetadataPropertyHandling = MetadataPropertyHandling
    {
    } deriving (Show)

data UnionMutable
    = DoubleInUnionMutable Double
    | MutableInUnionMutable Mutable
    deriving (Show)

data Mutable = Mutable
    {
    } deriving (Show)

data UnionMutating
    = DoubleInUnionMutating Double
    | MutatingInUnionMutating Mutating
    deriving (Show)

data Mutating = Mutating
    {
    } deriving (Show)

data UnionNamespace
    = DoubleInUnionNamespace Double
    | NamespaceInUnionNamespace Namespace
    deriving (Show)

data Namespace = Namespace
    {
    } deriving (Show)

data UnionNative
    = DoubleInUnionNative Double
    | NativeInUnionNative Native
    deriving (Show)

data Native = Native
    {
    } deriving (Show)

data UnionNew
    = DoubleInUnionNew Double
    | NewInUnionNew New
    deriving (Show)

data New = New
    {
    } deriving (Show)

data UnionNewtonsoft
    = DoubleInUnionNewtonsoft Double
    | NewtonsoftInUnionNewtonsoft Newtonsoft
    deriving (Show)

data Newtonsoft = Newtonsoft
    {
    } deriving (Show)

data UnionNil
    = DoubleInUnionNil Double
    | NilInUnionNil Nil
    deriving (Show)

data Nil = Nil
    {
    } deriving (Show)

data UnionNO
    = DoubleInUnionNO Double
    | NoInUnionNO No
    deriving (Show)

data No = No
    {
    } deriving (Show)

data UnionNoSuchMethod
    = DoubleInUnionNoSuchMethod Double
    | NoSuchMethodInUnionNoSuchMethod NoSuchMethod
    deriving (Show)

data NoSuchMethod = NoSuchMethod
    {
    } deriving (Show)

data UnionNoexcept
    = DoubleInUnionNoexcept Double
    | NoexceptInUnionNoexcept Noexcept
    deriving (Show)

data Noexcept = Noexcept
    {
    } deriving (Show)

data UnionNonatomic
    = DoubleInUnionNonatomic Double
    | NonatomicInUnionNonatomic Nonatomic
    deriving (Show)

data Nonatomic = Nonatomic
    {
    } deriving (Show)

data UnionNone
    = DoubleInUnionNone Double
    | NoneInUnionNone None
    deriving (Show)

data None = None
    {
    } deriving (Show)

data UnionNonlocal
    = DoubleInUnionNonlocal Double
    | NonlocalInUnionNonlocal Nonlocal
    deriving (Show)

data Nonlocal = Nonlocal
    {
    } deriving (Show)

data UnionNonmutating
    = DoubleInUnionNonmutating Double
    | NonmutatingInUnionNonmutating Nonmutating
    deriving (Show)

data Nonmutating = Nonmutating
    {
    } deriving (Show)

data UnionNot
    = DoubleInUnionNot Double
    | NotInUnionNot Not
    deriving (Show)

data Not = Not
    {
    } deriving (Show)

data UnionNotEq
    = DoubleInUnionNotEq Double
    | NotEqInUnionNotEq NotEq
    deriving (Show)

data NotEq = NotEq
    {
    } deriving (Show)

data UnionNSError
    = DoubleInUnionNSError Double
    | NSErrorInUnionNSError NSError
    deriving (Show)

data NSError = NSError
    {
    } deriving (Show)

data UnionNSObject
    = DoubleInUnionNSObject Double
    | NSObjectInUnionNSObject NSObject
    deriving (Show)

data NSObject = NSObject
    {
    } deriving (Show)

data UnionNSString
    = DoubleInUnionNSString Double
    | NSStringInUnionNSString NSString
    deriving (Show)

data NSString = NSString
    {
    } deriving (Show)

data UnionNULL
    = DoubleInUnionNULL Double
    | NULLClassInUnionNULL NULLClass
    deriving (Show)

data NULLClass = NULLClass
    {
    } deriving (Show)

data UnionNullNode
    = DoubleInUnionNullNode Double
    | NullNodeInUnionNullNode NullNode
    deriving (Show)

data NullNode = NullNode
    {
    } deriving (Show)

data UnionNullptr
    = DoubleInUnionNullptr Double
    | NullptrInUnionNullptr Nullptr
    deriving (Show)

data Nullptr = Nullptr
    {
    } deriving (Show)

data UnionNumber
    = DoubleInUnionNumber Double
    | NumberClassInUnionNumber NumberClass
    deriving (Show)

data NumberClass = NumberClass
    {
    } deriving (Show)

data UnionObject
    = DoubleInUnionObject Double
    | ObjectClassInUnionObject ObjectClass
    deriving (Show)

data ObjectClass = ObjectClass
    {
    } deriving (Show)

data UnionObjectMapper
    = DoubleInUnionObjectMapper Double
    | ObjectMapperInUnionObjectMapper ObjectMapper
    deriving (Show)

data ObjectMapper = ObjectMapper
    {
    } deriving (Show)

data UnionObjectNode
    = DoubleInUnionObjectNode Double
    | ObjectNodeInUnionObjectNode ObjectNode
    deriving (Show)

data ObjectNode = ObjectNode
    {
    } deriving (Show)

data UnionObjectReader
    = DoubleInUnionObjectReader Double
    | ObjectReaderInUnionObjectReader ObjectReader
    deriving (Show)

data ObjectReader = ObjectReader
    {
    } deriving (Show)

data UnionObjectWriter
    = DoubleInUnionObjectWriter Double
    | ObjectWriterInUnionObjectWriter ObjectWriter
    deriving (Show)

data ObjectWriter = ObjectWriter
    {
    } deriving (Show)

data UnionOffsetDateTime
    = DoubleInUnionOffsetDateTime Double
    | OffsetDateTimeInUnionOffsetDateTime OffsetDateTime
    deriving (Show)

data OffsetDateTime = OffsetDateTime
    {
    } deriving (Show)

data UnionOffsetTime
    = DoubleInUnionOffsetTime Double
    | OffsetTimeInUnionOffsetTime OffsetTime
    deriving (Show)

data OffsetTime = OffsetTime
    {
    } deriving (Show)

data UnionOneway
    = DoubleInUnionOneway Double
    | OnewayInUnionOneway Oneway
    deriving (Show)

data Oneway = Oneway
    {
    } deriving (Show)

data UnionOpen
    = DoubleInUnionOpen Double
    | OpenInUnionOpen Open
    deriving (Show)

data Open = Open
    {
    } deriving (Show)

data UnionOperator
    = DoubleInUnionOperator Double
    | OperatorInUnionOperator Operator
    deriving (Show)

data Operator = Operator
    {
    } deriving (Show)

data UnionOptional
    = DoubleInUnionOptional Double
    | OptionalInUnionOptional Optional
    deriving (Show)

data Optional = Optional
    {
    } deriving (Show)

data UnionOr
    = DoubleInUnionOr Double
    | OrInUnionOr Or
    deriving (Show)

data Or = Or
    {
    } deriving (Show)

data UnionOrEq
    = DoubleInUnionOrEq Double
    | OrEqInUnionOrEq OrEq
    deriving (Show)

data OrEq = OrEq
    {
    } deriving (Show)

data UnionOut
    = DoubleInUnionOut Double
    | OutInUnionOut Out
    deriving (Show)

data Out = Out
    {
    } deriving (Show)

data UnionOverride
    = DoubleInUnionOverride Double
    | OverrideInUnionOverride Override
    deriving (Show)

data Override = Override
    {
    } deriving (Show)

data UnionPackage
    = DoubleInUnionPackage Double
    | PackageInUnionPackage Package
    deriving (Show)

data Package = Package
    {
    } deriving (Show)

data UnionParams
    = DoubleInUnionParams Double
    | ParamsInUnionParams Params
    deriving (Show)

data Params = Params
    {
    } deriving (Show)

data UnionPass
    = DoubleInUnionPass Double
    | PassInUnionPass Pass
    deriving (Show)

data Pass = Pass
    {
    } deriving (Show)

data UnionPort
    = DoubleInUnionPort Double
    | PortInUnionPort Port
    deriving (Show)

data Port = Port
    {
    } deriving (Show)

data UnionPostfix
    = DoubleInUnionPostfix Double
    | PostfixInUnionPostfix Postfix
    deriving (Show)

data Postfix = Postfix
    {
    } deriving (Show)

data UnionPrecedence
    = DoubleInUnionPrecedence Double
    | PrecedenceInUnionPrecedence Precedence
    deriving (Show)

data Precedence = Precedence
    {
    } deriving (Show)

data UnionPrefix
    = DoubleInUnionPrefix Double
    | PrefixInUnionPrefix Prefix
    deriving (Show)

data Prefix = Prefix
    {
    } deriving (Show)

data UnionPrimitiveKind
    = DoubleInUnionPrimitiveKind Double
    | PrimitiveKindInUnionPrimitiveKind PrimitiveKind
    deriving (Show)

data PrimitiveKind = PrimitiveKind
    {
    } deriving (Show)

data UnionPrint
    = DoubleInUnionPrint Double
    | PrintInUnionPrint Print
    deriving (Show)

data Print = Print
    {
    } deriving (Show)

data UnionPrintMembers
    = DoubleInUnionPrintMembers Double
    | PrintMembersInUnionPrintMembers PrintMembers
    deriving (Show)

data PrintMembers = PrintMembers
    {
    } deriving (Show)

data UnionPrintf
    = DoubleInUnionPrintf Double
    | PrintfInUnionPrintf Printf
    deriving (Show)

data Printf = Printf
    {
    } deriving (Show)

data UnionPrivate
    = DoubleInUnionPrivate Double
    | PrivateInUnionPrivate Private
    deriving (Show)

data Private = Private
    {
    } deriving (Show)

data UnionProtected
    = DoubleInUnionProtected Double
    | ProtectedInUnionProtected Protected
    deriving (Show)

data Protected = Protected
    {
    } deriving (Show)

data UnionProtocol
    = DoubleInUnionProtocol Double
    | ProtocolInUnionProtocol Protocol
    deriving (Show)

data Protocol = Protocol
    {
    } deriving (Show)

data UnionPublic
    = DoubleInUnionPublic Double
    | PublicInUnionPublic Public
    deriving (Show)

data Public = Public
    {
    } deriving (Show)

data UnionBoolUnion
    = DoubleInUnionBoolUnion Double
    | UnionBoolBoolInUnionBoolUnion UnionBoolBool
    deriving (Show)

data UnionBoolBool = UnionBoolBool
    {
    } deriving (Show)

data UnionClassUnion
    = ClassClassInUnionClassUnion ClassClass
    | DoubleInUnionClassUnion Double
    deriving (Show)

data ClassClass = ClassClass
    {
    } deriving (Show)

data UnionTypeUnion
    = DoubleInUnionTypeUnion Double
    | TypeClassInUnionTypeUnion TypeClass
    deriving (Show)

data TypeClass = TypeClass
    {
    } deriving (Show)

data UnionAnyUnion
    = AnyClassInUnionAnyUnion AnyClass
    | DoubleInUnionAnyUnion Double
    deriving (Show)

data AnyClass = AnyClass
    {
    } deriving (Show)

data UnionAs
    = AsInUnionAs As
    | DoubleInUnionAs Double
    deriving (Show)

data As = As
    {
    } deriving (Show)

data UnionBool
    = BoolClassInUnionBool BoolClass
    | DoubleInUnionBool Double
    deriving (Show)

data BoolClass = BoolClass
    {
    } deriving (Show)

data UnionCase
    = CaseInUnionCase Case
    | DoubleInUnionCase Double
    deriving (Show)

data Case = Case
    {
    } deriving (Show)

data UnionClass
    = ClassInUnionClass Class
    | DoubleInUnionClass Double
    deriving (Show)

data Class = Class
    {
    } deriving (Show)

data UnionDefault
    = DefaultInUnionDefault Default
    | DoubleInUnionDefault Double
    deriving (Show)

data Default = Default
    {
    } deriving (Show)

data UnionDo
    = DoInUnionDo Do
    | DoubleInUnionDo Double
    deriving (Show)

data Do = Do
    {
    } deriving (Show)

data UnionElse
    = DoubleInUnionElse Double
    | ElseInUnionElse Else
    deriving (Show)

data Else = Else
    {
    } deriving (Show)

data UnionFalseUnion
    = DoubleInUnionFalseUnion Double
    | UnionFalseFalseInUnionFalseUnion UnionFalseFalse
    deriving (Show)

data UnionFalseFalse = UnionFalseFalse
    {
    } deriving (Show)

data UnionID
    = DoubleInUnionID Double
    | IDInUnionID ID
    deriving (Show)

data ID = ID
    {
    } deriving (Show)

data UnionIf
    = DoubleInUnionIf Double
    | IfInUnionIf If
    deriving (Show)

data If = If
    {
    } deriving (Show)

data UnionImport
    = DoubleInUnionImport Double
    | ImportInUnionImport Import
    deriving (Show)

data Import = Import
    {
    } deriving (Show)

data UnionIn
    = DoubleInUnionIn Double
    | InInUnionIn In
    deriving (Show)

data In = In
    {
    } deriving (Show)

data UnionInfix
    = DoubleInUnionInfix Double
    | InfixInUnionInfix Infix
    deriving (Show)

data Infix = Infix
    {
    } deriving (Show)

data UnionLet
    = DoubleInUnionLet Double
    | LetInUnionLet Let
    deriving (Show)

data Let = Let
    {
    } deriving (Show)

data UnionModule
    = DoubleInUnionModule Double
    | ModuleInUnionModule Module
    deriving (Show)

data Module = Module
    {
    } deriving (Show)

data UnionNoneUnion
    = DoubleInUnionNoneUnion Double
    | NoneClassInUnionNoneUnion NoneClass
    deriving (Show)

data NoneClass = NoneClass
    {
    } deriving (Show)

data UnionNull
    = DoubleInUnionNull Double
    | NullClassInUnionNull NullClass
    deriving (Show)

data NullClass = NullClass
    {
    } deriving (Show)

data UnionOf
    = DoubleInUnionOf Double
    | OfInUnionOf Of
    deriving (Show)

data Of = Of
    {
    } deriving (Show)

data UnionProtocolUnion
    = DoubleInUnionProtocolUnion Double
    | ProtocolClassInUnionProtocolUnion ProtocolClass
    deriving (Show)

data ProtocolClass = ProtocolClass
    {
    } deriving (Show)

data UnionSelfUnion
    = DoubleInUnionSelfUnion Double
    | SelfClassInUnionSelfUnion SelfClass
    deriving (Show)

data SelfClass = SelfClass
    {
    } deriving (Show)

data UnionThen
    = DoubleInUnionThen Double
    | ThenInUnionThen Then
    deriving (Show)

data Then = Then
    {
    } deriving (Show)

data UnionTrueUnion
    = DoubleInUnionTrueUnion Double
    | UnionTrueTrueInUnionTrueUnion UnionTrueTrue
    deriving (Show)

data UnionTrueTrue = UnionTrueTrue
    {
    } deriving (Show)

data UnionType
    = DoubleInUnionType Double
    | TypeInUnionType Type
    deriving (Show)

data Type = Type
    {
    } deriving (Show)

data UnionWhere
    = DoubleInUnionWhere Double
    | WhereInUnionWhere Where
    deriving (Show)

data Where = Where
    {
    } deriving (Show)

data UnionQuicktype
    = DoubleInUnionQuicktype Double
    | QuicktypeInUnionQuicktype Quicktype
    deriving (Show)

data Quicktype = Quicktype
    {
    } deriving (Show)

data UnionRaise
    = DoubleInUnionRaise Double
    | RaiseInUnionRaise Raise
    deriving (Show)

data Raise = Raise
    {
    } deriving (Show)

data UnionRange
    = DoubleInUnionRange Double
    | RangeInUnionRange Range
    deriving (Show)

data Range = Range
    {
    } deriving (Show)

data UnionReadonly
    = DoubleInUnionReadonly Double
    | ReadonlyInUnionReadonly Readonly
    deriving (Show)

data Readonly = Readonly
    {
    } deriving (Show)

data UnionRef
    = DoubleInUnionRef Double
    | RefInUnionRef Ref
    deriving (Show)

data Ref = Ref
    {
    } deriving (Show)

data UnionRegExp
    = DoubleInUnionRegExp Double
    | RegExpInUnionRegExp RegExp
    deriving (Show)

data RegExp = RegExp
    {
    } deriving (Show)

data UnionRegister
    = DoubleInUnionRegister Double
    | RegisterInUnionRegister Register
    deriving (Show)

data Register = Register
    {
    } deriving (Show)

data UnionReinterpretCast
    = DoubleInUnionReinterpretCast Double
    | ReinterpretCastInUnionReinterpretCast ReinterpretCast
    deriving (Show)

data ReinterpretCast = ReinterpretCast
    {
    } deriving (Show)

data UnionRepeat
    = DoubleInUnionRepeat Double
    | RepeatInUnionRepeat Repeat
    deriving (Show)

data Repeat = Repeat
    {
    } deriving (Show)

data UnionRequire
    = DoubleInUnionRequire Double
    | RequireInUnionRequire Require
    deriving (Show)

data Require = Require
    {
    } deriving (Show)

data UnionRequired
    = DoubleInUnionRequired Double
    | RequiredInUnionRequired Required
    deriving (Show)

data Required = Required
    {
    } deriving (Show)

data UnionRequires
    = DoubleInUnionRequires Double
    | RequiresInUnionRequires Requires
    deriving (Show)

data Requires = Requires
    {
    } deriving (Show)

data UnionRestrict
    = DoubleInUnionRestrict Double
    | RestrictInUnionRestrict Restrict
    deriving (Show)

data Restrict = Restrict
    {
    } deriving (Show)

data UnionRetain
    = DoubleInUnionRetain Double
    | RetainInUnionRetain Retain
    deriving (Show)

data Retain = Retain
    {
    } deriving (Show)

data UnionRethrows
    = DoubleInUnionRethrows Double
    | RethrowsInUnionRethrows Rethrows
    deriving (Show)

data Rethrows = Rethrows
    {
    } deriving (Show)

data UnionReturn
    = DoubleInUnionReturn Double
    | ReturnInUnionReturn Return
    deriving (Show)

data Return = Return
    {
    } deriving (Show)

data UnionRight
    = DoubleInUnionRight Double
    | RightClassInUnionRight RightClass
    deriving (Show)

data RightClass = RightClass
    {
    } deriving (Show)

data UnionRuntimeType
    = DoubleInUnionRuntimeType Double
    | RuntimeTypeInUnionRuntimeType RuntimeType
    deriving (Show)

data RuntimeType = RuntimeType
    {
    } deriving (Show)

data UnionS
    = DoubleInUnionS Double
    | SInUnionS S
    deriving (Show)

data S = S
    {
    } deriving (Show)

data UnionSbyte
    = DoubleInUnionSbyte Double
    | SbyteInUnionSbyte Sbyte
    deriving (Show)

data Sbyte = Sbyte
    {
    } deriving (Show)

data UnionSealed
    = DoubleInUnionSealed Double
    | SealedInUnionSealed Sealed
    deriving (Show)

data Sealed = Sealed
    {
    } deriving (Show)

data UnionSEL
    = DoubleInUnionSEL Double
    | SelInUnionSEL Sel
    deriving (Show)

data Sel = Sel
    {
    } deriving (Show)

data UnionSelect
    = DoubleInUnionSelect Double
    | SelectInUnionSelect Select
    deriving (Show)

data Select = Select
    {
    } deriving (Show)

data UnionSelf
    = DoubleInUnionSelf Double
    | SelfInUnionSelf Self
    deriving (Show)

data Self = Self
    {
    } deriving (Show)

data UnionSendable
    = DoubleInUnionSendable Double
    | SendableInUnionSendable Sendable
    deriving (Show)

data Sendable = Sendable
    {
    } deriving (Show)

data UnionSerialDescriptor
    = DoubleInUnionSerialDescriptor Double
    | SerialDescriptorInUnionSerialDescriptor SerialDescriptor
    deriving (Show)

data SerialDescriptor = SerialDescriptor
    {
    } deriving (Show)

data UnionSerialName
    = DoubleInUnionSerialName Double
    | SerialNameInUnionSerialName SerialName
    deriving (Show)

data SerialName = SerialName
    {
    } deriving (Show)

data UnionSerializable
    = DoubleInUnionSerializable Double
    | SerializableInUnionSerializable Serializable
    deriving (Show)

data Serializable = Serializable
    {
    } deriving (Show)

data UnionSerializationFeature
    = DoubleInUnionSerializationFeature Double
    | SerializationFeatureInUnionSerializationFeature SerializationFeature
    deriving (Show)

data SerializationFeature = SerializationFeature
    {
    } deriving (Show)

data UnionSerialize
    = DoubleInUnionSerialize Double
    | SerializeInUnionSerialize Serialize
    deriving (Show)

data Serialize = Serialize
    {
    } deriving (Show)

data UnionSerializerProvider
    = DoubleInUnionSerializerProvider Double
    | SerializerProviderInUnionSerializerProvider SerializerProvider
    deriving (Show)

data SerializerProvider = SerializerProvider
    {
    } deriving (Show)

data UnionSet
    = DoubleInUnionSet Double
    | SetInUnionSet Set
    deriving (Show)

data Set = Set
    {
    } deriving (Show)

data UnionShort
    = DoubleInUnionShort Double
    | ShortInUnionShort Short
    deriving (Show)

data Short = Short
    {
    } deriving (Show)

data UnionSigned
    = DoubleInUnionSigned Double
    | SignedInUnionSigned Signed
    deriving (Show)

data Signed = Signed
    {
    } deriving (Show)

data UnionSimpleModule
    = DoubleInUnionSimpleModule Double
    | SimpleModuleInUnionSimpleModule SimpleModule
    deriving (Show)

data SimpleModule = SimpleModule
    {
    } deriving (Show)

data UnionSizeof
    = DoubleInUnionSizeof Double
    | SizeofInUnionSizeof Sizeof
    deriving (Show)

data Sizeof = Sizeof
    {
    } deriving (Show)

data UnionStackalloc
    = DoubleInUnionStackalloc Double
    | StackallocInUnionStackalloc Stackalloc
    deriving (Show)

data Stackalloc = Stackalloc
    {
    } deriving (Show)

data UnionStandards
    = DoubleInUnionStandards Double
    | StandardsInUnionStandards Standards
    deriving (Show)

data Standards = Standards
    {
    } deriving (Show)

data UnionStatic
    = DoubleInUnionStatic Double
    | StaticInUnionStatic Static
    deriving (Show)

data Static = Static
    {
    } deriving (Show)

data UnionStaticAssert
    = DoubleInUnionStaticAssert Double
    | StaticAssertInUnionStaticAssert StaticAssert
    deriving (Show)

data StaticAssert = StaticAssert
    {
    } deriving (Show)

data UnionStaticCast
    = DoubleInUnionStaticCast Double
    | StaticCastInUnionStaticCast StaticCast
    deriving (Show)

data StaticCast = StaticCast
    {
    } deriving (Show)

data UnionStdDeserializer
    = DoubleInUnionStdDeserializer Double
    | StdDeserializerInUnionStdDeserializer StdDeserializer
    deriving (Show)

data StdDeserializer = StdDeserializer
    {
    } deriving (Show)

data UnionStdSerializer
    = DoubleInUnionStdSerializer Double
    | StdSerializerInUnionStdSerializer StdSerializer
    deriving (Show)

data StdSerializer = StdSerializer
    {
    } deriving (Show)

data UnionStrictfp
    = DoubleInUnionStrictfp Double
    | StrictfpInUnionStrictfp Strictfp
    deriving (Show)

data Strictfp = Strictfp
    {
    } deriving (Show)

data UnionString
    = DoubleInUnionString Double
    | StringClassInUnionString StringClass
    deriving (Show)

data StringClass = StringClass
    {
    } deriving (Show)

data UnionStruct
    = DoubleInUnionStruct Double
    | StructInUnionStruct Struct
    deriving (Show)

data Struct = Struct
    {
    } deriving (Show)

data UnionSubscript
    = DoubleInUnionSubscript Double
    | SubscriptInUnionSubscript Subscript
    deriving (Show)

data Subscript = Subscript
    {
    } deriving (Show)

data UnionSuper
    = DoubleInUnionSuper Double
    | SuperInUnionSuper Super
    deriving (Show)

data Super = Super
    {
    } deriving (Show)

data UnionSwitch
    = DoubleInUnionSwitch Double
    | SwitchInUnionSwitch Switch
    deriving (Show)

data Switch = Switch
    {
    } deriving (Show)

data UnionSymbol
    = DoubleInUnionSymbol Double
    | SymbolInUnionSymbol Symbol
    deriving (Show)

data Symbol = Symbol
    {
    } deriving (Show)

data UnionSynchronized
    = DoubleInUnionSynchronized Double
    | SynchronizedInUnionSynchronized Synchronized
    deriving (Show)

data Synchronized = Synchronized
    {
    } deriving (Show)

data UnionSystem
    = DoubleInUnionSystem Double
    | SystemInUnionSystem System
    deriving (Show)

data System = System
    {
    } deriving (Show)

data UnionTemplate
    = DoubleInUnionTemplate Double
    | TemplateInUnionTemplate Template
    deriving (Show)

data Template = Template
    {
    } deriving (Show)

data UnionTextNode
    = DoubleInUnionTextNode Double
    | TextNodeInUnionTextNode TextNode
    deriving (Show)

data TextNode = TextNode
    {
    } deriving (Show)

data UnionThis
    = DoubleInUnionThis Double
    | ThisInUnionThis This
    deriving (Show)

data This = This
    {
    } deriving (Show)

data UnionThreadLocal
    = DoubleInUnionThreadLocal Double
    | ThreadLocalInUnionThreadLocal ThreadLocal
    deriving (Show)

data ThreadLocal = ThreadLocal
    {
    } deriving (Show)

data UnionThrow
    = DoubleInUnionThrow Double
    | ThrowInUnionThrow Throw
    deriving (Show)

data Throw = Throw
    {
    } deriving (Show)

data UnionThrows
    = DoubleInUnionThrows Double
    | ThrowsInUnionThrows Throws
    deriving (Show)

data Throws = Throws
    {
    } deriving (Show)

data UnionTimeOnly
    = DoubleInUnionTimeOnly Double
    | TimeOnlyInUnionTimeOnly TimeOnly
    deriving (Show)

data TimeOnly = TimeOnly
    {
    } deriving (Show)

data UnionTimeOnlyConverter
    = DoubleInUnionTimeOnlyConverter Double
    | TimeOnlyConverterInUnionTimeOnlyConverter TimeOnlyConverter
    deriving (Show)

data TimeOnlyConverter = TimeOnlyConverter
    {
    } deriving (Show)

data UnionTimeZone
    = DoubleInUnionTimeZone Double
    | TimeZoneInUnionTimeZone TimeZone
    deriving (Show)

data TimeZone = TimeZone
    {
    } deriving (Show)

data UnionToDict
    = DoubleInUnionToDict Double
    | ToDictInUnionToDict ToDict
    deriving (Show)

data ToDict = ToDict
    {
    } deriving (Show)

data UnionToJSON
    = DoubleInUnionToJSON Double
    | ToJSONClassInUnionToJSON ToJSONClass
    deriving (Show)

data ToJSONClass = ToJSONClass
    {
    } deriving (Show)

data UnionToString
    = DoubleInUnionToString Double
    | ToStringInUnionToString ToString
    deriving (Show)

data ToString = ToString
    {
    } deriving (Show)

data UnionTopLevel
    = DoubleInUnionTopLevel Double
    | TopLevelInUnionTopLevel TopLevel
    deriving (Show)

data TopLevel = TopLevel
    {
    } deriving (Show)

data UnionTransient
    = DoubleInUnionTransient Double
    | TransientInUnionTransient Transient
    deriving (Show)

data Transient = Transient
    {
    } deriving (Show)

data UnionTrue
    = DoubleInUnionTrue Double
    | TrueClassInUnionTrue TrueClass
    deriving (Show)

data TrueClass = TrueClass
    {
    } deriving (Show)

data UnionTry
    = DoubleInUnionTry Double
    | TryInUnionTry Try
    deriving (Show)

data Try = Try
    {
    } deriving (Show)

data UnionTypealias
    = DoubleInUnionTypealias Double
    | TypealiasInUnionTypealias Typealias
    deriving (Show)

data Typealias = Typealias
    {
    } deriving (Show)

data UnionTypedef
    = DoubleInUnionTypedef Double
    | TypedefInUnionTypedef Typedef
    deriving (Show)

data Typedef = Typedef
    {
    } deriving (Show)

data UnionTypeid
    = DoubleInUnionTypeid Double
    | TypeidInUnionTypeid Typeid
    deriving (Show)

data Typeid = Typeid
    {
    } deriving (Show)

data UnionTypename
    = DoubleInUnionTypename Double
    | TypenameInUnionTypename Typename
    deriving (Show)

data Typename = Typename
    {
    } deriving (Show)

data UnionTypeof
    = DoubleInUnionTypeof Double
    | TypeofInUnionTypeof Typeof
    deriving (Show)

data Typeof = Typeof
    {
    } deriving (Show)

data UnionUint
    = DoubleInUnionUint Double
    | UintInUnionUint Uint
    deriving (Show)

data Uint = Uint
    {
    } deriving (Show)

data UnionUlong
    = DoubleInUnionUlong Double
    | UlongInUnionUlong Ulong
    deriving (Show)

data Ulong = Ulong
    {
    } deriving (Show)

data UnionUnchecked
    = DoubleInUnionUnchecked Double
    | UncheckedInUnionUnchecked Unchecked
    deriving (Show)

data Unchecked = Unchecked
    {
    } deriving (Show)

data UnionUndefined
    = DoubleInUnionUndefined Double
    | UndefinedInUnionUndefined Undefined
    deriving (Show)

data Undefined = Undefined
    {
    } deriving (Show)

data UnionUnionUnion
    = DoubleInUnionUnionUnion Double
    | UnionInUnionUnionUnion Union
    deriving (Show)

data Union = Union
    {
    } deriving (Show)

data UnionUnmarshalJSON
    = DoubleInUnionUnmarshalJSON Double
    | UnmarshalJSONInUnionUnmarshalJSON UnmarshalJSON
    deriving (Show)

data UnmarshalJSON = UnmarshalJSON
    {
    } deriving (Show)

data UnionUnowned
    = DoubleInUnionUnowned Double
    | UnownedInUnionUnowned Unowned
    deriving (Show)

data Unowned = Unowned
    {
    } deriving (Show)

data UnionUnsafe
    = DoubleInUnionUnsafe Double
    | UnsafeInUnionUnsafe Unsafe
    deriving (Show)

data Unsafe = Unsafe
    {
    } deriving (Show)

data UnionUnsigned
    = DoubleInUnionUnsigned Double
    | UnsignedInUnionUnsigned Unsigned
    deriving (Show)

data Unsigned = Unsigned
    {
    } deriving (Show)

data UnionUseSerializers
    = DoubleInUnionUseSerializers Double
    | UseSerializersInUnionUseSerializers UseSerializers
    deriving (Show)

data UseSerializers = UseSerializers
    {
    } deriving (Show)

data UnionUshort
    = DoubleInUnionUshort Double
    | UshortInUnionUshort Ushort
    deriving (Show)

data Ushort = Ushort
    {
    } deriving (Show)

data UnionUsing
    = DoubleInUnionUsing Double
    | UsingInUnionUsing Using
    deriving (Show)

data Using = Using
    {
    } deriving (Show)

data UnionUtf8JSONReader
    = DoubleInUnionUtf8JSONReader Double
    | Utf8JSONReaderInUnionUtf8JSONReader Utf8JSONReader
    deriving (Show)

data Utf8JSONReader = Utf8JSONReader
    {
    } deriving (Show)

data UnionUtf8JSONWriter
    = DoubleInUnionUtf8JSONWriter Double
    | Utf8JSONWriterInUnionUtf8JSONWriter Utf8JSONWriter
    deriving (Show)

data Utf8JSONWriter = Utf8JSONWriter
    {
    } deriving (Show)

data UnionUUID
    = DoubleInUnionUUID Double
    | UUIDInUnionUUID UUID
    deriving (Show)

data UUID = UUID
    {
    } deriving (Show)

data UnionVar
    = DoubleInUnionVar Double
    | VarInUnionVar Var
    deriving (Show)

data Var = Var
    {
    } deriving (Show)

data UnionVirtual
    = DoubleInUnionVirtual Double
    | VirtualInUnionVirtual Virtual
    deriving (Show)

data Virtual = Virtual
    {
    } deriving (Show)

data UnionVoid
    = DoubleInUnionVoid Double
    | VoidInUnionVoid Void
    deriving (Show)

data Void = Void
    {
    } deriving (Show)

data UnionVolatile
    = DoubleInUnionVolatile Double
    | VolatileInUnionVolatile Volatile
    deriving (Show)

data Volatile = Volatile
    {
    } deriving (Show)

data UnionWcharT
    = DoubleInUnionWcharT Double
    | WcharTInUnionWcharT WcharT
    deriving (Show)

data WcharT = WcharT
    {
    } deriving (Show)

data UnionWeak
    = DoubleInUnionWeak Double
    | WeakInUnionWeak Weak
    deriving (Show)

data Weak = Weak
    {
    } deriving (Show)

data UnionWhile
    = DoubleInUnionWhile Double
    | WhileInUnionWhile While
    deriving (Show)

data While = While
    {
    } deriving (Show)

data UnionWillSet
    = DoubleInUnionWillSet Double
    | WillSetInUnionWillSet WillSet
    deriving (Show)

data WillSet = WillSet
    {
    } deriving (Show)

data UnionWith
    = DoubleInUnionWith Double
    | WithInUnionWith With
    deriving (Show)

data With = With
    {
    } deriving (Show)

data UnionXor
    = DoubleInUnionXor Double
    | XorInUnionXor Xor
    deriving (Show)

data Xor = Xor
    {
    } deriving (Show)

data UnionXorEq
    = DoubleInUnionXorEq Double
    | XorEqInUnionXorEq XorEq
    deriving (Show)

data XorEq = XorEq
    {
    } deriving (Show)

data UnionYES
    = DoubleInUnionYES Double
    | YesInUnionYES Yes
    deriving (Show)

data Yes = Yes
    {
    } deriving (Show)

data UnionYield
    = DoubleInUnionYield Double
    | YieldInUnionYield Yield
    deriving (Show)

data Yield = Yield
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType emptyQuickType quickTypeBoolQuickType complexQuickType imagineryQuickType abstractQuickType alignasQuickType alignofQuickType andQuickType andEqQuickType quickTypeAnyQuickType anyQuickType arrayQuickType arrayNodeQuickType quickTypeAsQuickType asmQuickType assertQuickType associatedtypeQuickType associativityQuickType asyncQuickType atomicQuickType atomicCancelQuickType atomicCommitQuickType atomicNoexceptQuickType autoQuickType awaitQuickType baseQuickType bitandQuickType bitorQuickType boolQuickType purpleBoolQuickType booleanQuickType booleanNodeQuickType breakQuickType bycopyQuickType byrefQuickType byteQuickType calendarQuickType quickTypeCaseQuickType catchQuickType chanQuickType charQuickType char16TQuickType char32TQuickType checkedQuickType purpleClassQuickType quickTypeClassQuickType cloneQuickType coAwaitQuickType coReturnQuickType coYieldQuickType codableQuickType codingKeyQuickType codingKeysQuickType complQuickType conceptQuickType consoleQuickType constQuickType constCastQuickType constexprQuickType constructorQuickType continueQuickType convenienceQuickType convertQuickType converterQuickType cultureInfoQuickType dateQuickType dateParseHandlingQuickType dateFormatterQuickType dateOnlyQuickType dateOnlyConverterQuickType dateTimeQuickType dateTimeStylesQuickType debuggerQuickType decimalQuickType declareQuickType decltypeQuickType decodeStringQuickType decoderQuickType decodingErrorQuickType defQuickType quickTypeDefaultQuickType deferQuickType deinitQuickType delQuickType delegateQuickType deleteQuickType deserializationFeatureQuickType dictQuickType dictionaryQuickType didSetQuickType quickTypeDoQuickType doubleQuickType doubleNodeQuickType dummyQuickType dynamicQuickType dynamicCastQuickType elifQuickType quickTypeElseQuickType encodeQuickTypeQuickType encoderQuickType enumQuickType enumValuesQuickType equalityContractQuickType equatableQuickType eventQuickType exceptQuickType exceptionQuickType explicitQuickType exportQuickType exposingQuickType extendsQuickType extensionQuickType externQuickType fallthroughQuickType quickTypeFalseQuickType falseQuickType fileprivateQuickType finalQuickType finallyQuickType fixedQuickType floatQuickType forQuickType foreachQuickType formatExceptionQuickType friendQuickType fromQuickType fromDictQuickType fromJSONQuickType funcQuickType functionQuickType getQuickType globalQuickType goQuickType gotoQuickType guardQuickType hashableQuickType hashCodeQuickType hasherQuickType hasOwnPropertyQuickType quickTypeIDQuickType quickTypeIfQuickType impQuickType implementsQuickType implicitQuickType quickTypeImportQuickType quickTypeInQuickType indirectQuickType quickTypeInfixQuickType initQuickType inlineQuickType inoutQuickType instanceofQuickType intQuickType interfaceQuickType internalQuickType intNodeQuickType isQuickType isoDateTimeOffsetConverterQuickType iterableQuickType jdecQuickType jencQuickType jpipeQuickType jsonQuickType jsonConverterQuickType jsonSerializerQuickType jsonTokenQuickType jsonWriterQuickType jsonAnyQuickType jsonCodingKeyQuickType jsonDecoderQuickType jsonEncoderQuickType jsonExceptionQuickType jsonGeneratorQuickType jsonNodeQuickType jsonNullQuickType jsonParserQuickType jsonReaderQuickType jsonTokenTypeQuickType kSerializerQuickType lambdaQuickType lazyQuickType leftQuickType quickTypeLetQuickType listQuickType localDateQuickType localeQuickType lockQuickType longQuickType longNodeQuickType mapQuickType mapEntryQuickType marshalJSONQuickType metadataPropertyHandlingQuickType quickTypeModuleQuickType mutableQuickType mutatingQuickType namespaceQuickType nativeQuickType newQuickType newtonsoftQuickType nilQuickType noQuickType noexceptQuickType nonatomicQuickType quickTypeNoneQuickType noneQuickType nonlocalQuickType nonmutatingQuickType noSuchMethodQuickType notQuickType notEqQuickType nsErrorQuickType nsObjectQuickType nsStringQuickType nullQuickType quickTypeNullQuickType nullNodeQuickType nullptrQuickType numberQuickType objectQuickType objectMapperQuickType objectNodeQuickType objectReaderQuickType objectWriterQuickType quickTypeOfQuickType offsetDateTimeQuickType offsetTimeQuickType onewayQuickType openQuickType operatorQuickType optionalQuickType orQuickType orEqQuickType outQuickType overrideQuickType packageQuickType paramsQuickType passQuickType portQuickType postfixQuickType precedenceQuickType prefixQuickType primitiveKindQuickType printQuickType printfQuickType printMembersQuickType privateQuickType protectedQuickType protocolQuickType quickTypeProtocolQuickType publicQuickType quicktypeQuickType raiseQuickType rangeQuickType readonlyQuickType refQuickType regExpQuickType registerQuickType reinterpretCastQuickType repeatQuickType requireQuickType requiredQuickType requiresQuickType restrictQuickType retainQuickType rethrowsQuickType returnQuickType rightQuickType runtimeTypeQuickType sQuickType sbyteQuickType sealedQuickType selQuickType selectQuickType selfQuickType quickTypeSelfQuickType sendableQuickType serialDescriptorQuickType serializableQuickType serializationFeatureQuickType serializeQuickType serializerProviderQuickType serialNameQuickType setQuickType shortQuickType signedQuickType simpleModuleQuickType sizeofQuickType stackallocQuickType standardsQuickType staticQuickType staticAssertQuickType staticCastQuickType stdDeserializerQuickType stdSerializerQuickType strictfpQuickType stringQuickType structQuickType subscriptQuickType superQuickType switchQuickType symbolQuickType synchronizedQuickType systemQuickType templateQuickType textNodeQuickType quickTypeThenQuickType thisQuickType threadLocalQuickType throwQuickType throwsQuickType timeOnlyQuickType timeOnlyConverterQuickType timeZoneQuickType toDictQuickType toJSONQuickType topLevelQuickType toStringQuickType transientQuickType trueQuickType quickTypeTrueQuickType tryQuickType quickTypeTypeQuickType purpleTypeQuickType typealiasQuickType typedefQuickType typeidQuickType typenameQuickType typeofQuickType uintQuickType ulongQuickType uncheckedQuickType undefinedQuickType unionQuickType unmarshalJSONQuickType unownedQuickType unsafeQuickType unsignedQuickType useSerializersQuickType ushortQuickType usingQuickType utf8JSONReaderQuickType utf8JSONWriterQuickType uuidQuickType varQuickType virtualQuickType voidQuickType volatileQuickType wcharTQuickType weakQuickType quickTypeWhereQuickType whileQuickType willSetQuickType withQuickType xorQuickType xorEqQuickType yesQuickType yieldQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("_" .=) <$> emptyQuickType
        , ("_Bool" .=) <$> quickTypeBoolQuickType
        , ("_Complex" .=) <$> complexQuickType
        , ("_Imaginery" .=) <$> imagineryQuickType
        , ("abstract" .=) <$> abstractQuickType
        , ("alignas" .=) <$> alignasQuickType
        , ("alignof" .=) <$> alignofQuickType
        , ("and" .=) <$> andQuickType
        , ("and_eq" .=) <$> andEqQuickType
        , ("any" .=) <$> quickTypeAnyQuickType
        , ("Any" .=) <$> anyQuickType
        , ("array" .=) <$> arrayQuickType
        , ("ArrayNode" .=) <$> arrayNodeQuickType
        , ("as" .=) <$> quickTypeAsQuickType
        , ("asm" .=) <$> asmQuickType
        , ("assert" .=) <$> assertQuickType
        , ("associatedtype" .=) <$> associatedtypeQuickType
        , ("associativity" .=) <$> associativityQuickType
        , ("async" .=) <$> asyncQuickType
        , ("atomic" .=) <$> atomicQuickType
        , ("atomic_cancel" .=) <$> atomicCancelQuickType
        , ("atomic_commit" .=) <$> atomicCommitQuickType
        , ("atomic_noexcept" .=) <$> atomicNoexceptQuickType
        , ("auto" .=) <$> autoQuickType
        , ("await" .=) <$> awaitQuickType
        , ("base" .=) <$> baseQuickType
        , ("bitand" .=) <$> bitandQuickType
        , ("bitor" .=) <$> bitorQuickType
        , ("BOOL" .=) <$> boolQuickType
        , ("bool" .=) <$> purpleBoolQuickType
        , ("boolean" .=) <$> booleanQuickType
        , ("BooleanNode" .=) <$> booleanNodeQuickType
        , ("break" .=) <$> breakQuickType
        , ("bycopy" .=) <$> bycopyQuickType
        , ("byref" .=) <$> byrefQuickType
        , ("byte" .=) <$> byteQuickType
        , ("Calendar" .=) <$> calendarQuickType
        , ("case" .=) <$> quickTypeCaseQuickType
        , ("catch" .=) <$> catchQuickType
        , ("chan" .=) <$> chanQuickType
        , ("char" .=) <$> charQuickType
        , ("char16_t" .=) <$> char16TQuickType
        , ("char32_t" .=) <$> char32TQuickType
        , ("checked" .=) <$> checkedQuickType
        , ("class" .=) <$> purpleClassQuickType
        , ("Class" .=) <$> quickTypeClassQuickType
        , ("clone" .=) <$> cloneQuickType
        , ("co_await" .=) <$> coAwaitQuickType
        , ("co_return" .=) <$> coReturnQuickType
        , ("co_yield" .=) <$> coYieldQuickType
        , ("Codable" .=) <$> codableQuickType
        , ("CodingKey" .=) <$> codingKeyQuickType
        , ("CodingKeys" .=) <$> codingKeysQuickType
        , ("compl" .=) <$> complQuickType
        , ("concept" .=) <$> conceptQuickType
        , ("console" .=) <$> consoleQuickType
        , ("const" .=) <$> constQuickType
        , ("const_cast" .=) <$> constCastQuickType
        , ("constexpr" .=) <$> constexprQuickType
        , ("constructor" .=) <$> constructorQuickType
        , ("continue" .=) <$> continueQuickType
        , ("convenience" .=) <$> convenienceQuickType
        , ("convert" .=) <$> convertQuickType
        , ("converter" .=) <$> converterQuickType
        , ("CultureInfo" .=) <$> cultureInfoQuickType
        , ("date" .=) <$> dateQuickType
        , ("date_parse_handling" .=) <$> dateParseHandlingQuickType
        , ("DateFormatter" .=) <$> dateFormatterQuickType
        , ("DateOnly" .=) <$> dateOnlyQuickType
        , ("DateOnlyConverter" .=) <$> dateOnlyConverterQuickType
        , ("DateTime" .=) <$> dateTimeQuickType
        , ("DateTimeStyles" .=) <$> dateTimeStylesQuickType
        , ("debugger" .=) <$> debuggerQuickType
        , ("decimal" .=) <$> decimalQuickType
        , ("declare" .=) <$> declareQuickType
        , ("decltype" .=) <$> decltypeQuickType
        , ("decode_string" .=) <$> decodeStringQuickType
        , ("Decoder" .=) <$> decoderQuickType
        , ("DecodingError" .=) <$> decodingErrorQuickType
        , ("def" .=) <$> defQuickType
        , ("default" .=) <$> quickTypeDefaultQuickType
        , ("defer" .=) <$> deferQuickType
        , ("deinit" .=) <$> deinitQuickType
        , ("del" .=) <$> delQuickType
        , ("delegate" .=) <$> delegateQuickType
        , ("delete" .=) <$> deleteQuickType
        , ("DeserializationFeature" .=) <$> deserializationFeatureQuickType
        , ("dict" .=) <$> dictQuickType
        , ("dictionary" .=) <$> dictionaryQuickType
        , ("didSet" .=) <$> didSetQuickType
        , ("do" .=) <$> quickTypeDoQuickType
        , ("double" .=) <$> doubleQuickType
        , ("DoubleNode" .=) <$> doubleNodeQuickType
        , ("dummy" .=) <$> dummyQuickType
        , ("dynamic" .=) <$> dynamicQuickType
        , ("dynamic_cast" .=) <$> dynamicCastQuickType
        , ("elif" .=) <$> elifQuickType
        , ("else" .=) <$> quickTypeElseQuickType
        , ("encode_quick_type" .=) <$> encodeQuickTypeQuickType
        , ("Encoder" .=) <$> encoderQuickType
        , ("enum" .=) <$> enumQuickType
        , ("EnumValues" .=) <$> enumValuesQuickType
        , ("equalityContract" .=) <$> equalityContractQuickType
        , ("Equatable" .=) <$> equatableQuickType
        , ("event" .=) <$> eventQuickType
        , ("except" .=) <$> exceptQuickType
        , ("exception" .=) <$> exceptionQuickType
        , ("explicit" .=) <$> explicitQuickType
        , ("export" .=) <$> exportQuickType
        , ("exposing" .=) <$> exposingQuickType
        , ("extends" .=) <$> extendsQuickType
        , ("extension" .=) <$> extensionQuickType
        , ("extern" .=) <$> externQuickType
        , ("fallthrough" .=) <$> fallthroughQuickType
        , ("false" .=) <$> quickTypeFalseQuickType
        , ("False" .=) <$> falseQuickType
        , ("fileprivate" .=) <$> fileprivateQuickType
        , ("final" .=) <$> finalQuickType
        , ("finally" .=) <$> finallyQuickType
        , ("fixed" .=) <$> fixedQuickType
        , ("float" .=) <$> floatQuickType
        , ("for" .=) <$> forQuickType
        , ("foreach" .=) <$> foreachQuickType
        , ("FormatException" .=) <$> formatExceptionQuickType
        , ("friend" .=) <$> friendQuickType
        , ("from" .=) <$> fromQuickType
        , ("from_dict" .=) <$> fromDictQuickType
        , ("from_json" .=) <$> fromJSONQuickType
        , ("func" .=) <$> funcQuickType
        , ("function" .=) <$> functionQuickType
        , ("get" .=) <$> getQuickType
        , ("global" .=) <$> globalQuickType
        , ("go" .=) <$> goQuickType
        , ("goto" .=) <$> gotoQuickType
        , ("guard" .=) <$> guardQuickType
        , ("Hashable" .=) <$> hashableQuickType
        , ("hashCode" .=) <$> hashCodeQuickType
        , ("Hasher" .=) <$> hasherQuickType
        , ("hasOwnProperty" .=) <$> hasOwnPropertyQuickType
        , ("id" .=) <$> quickTypeIDQuickType
        , ("if" .=) <$> quickTypeIfQuickType
        , ("IMP" .=) <$> impQuickType
        , ("implements" .=) <$> implementsQuickType
        , ("implicit" .=) <$> implicitQuickType
        , ("import" .=) <$> quickTypeImportQuickType
        , ("in" .=) <$> quickTypeInQuickType
        , ("indirect" .=) <$> indirectQuickType
        , ("infix" .=) <$> quickTypeInfixQuickType
        , ("init" .=) <$> initQuickType
        , ("inline" .=) <$> inlineQuickType
        , ("inout" .=) <$> inoutQuickType
        , ("instanceof" .=) <$> instanceofQuickType
        , ("int" .=) <$> intQuickType
        , ("interface" .=) <$> interfaceQuickType
        , ("internal" .=) <$> internalQuickType
        , ("IntNode" .=) <$> intNodeQuickType
        , ("is" .=) <$> isQuickType
        , ("IsoDateTimeOffsetConverter" .=) <$> isoDateTimeOffsetConverterQuickType
        , ("iterable" .=) <$> iterableQuickType
        , ("jdec" .=) <$> jdecQuickType
        , ("jenc" .=) <$> jencQuickType
        , ("jpipe" .=) <$> jpipeQuickType
        , ("json" .=) <$> jsonQuickType
        , ("json_converter" .=) <$> jsonConverterQuickType
        , ("json_serializer" .=) <$> jsonSerializerQuickType
        , ("json_token" .=) <$> jsonTokenQuickType
        , ("json_writer" .=) <$> jsonWriterQuickType
        , ("JSONAny" .=) <$> jsonAnyQuickType
        , ("JSONCodingKey" .=) <$> jsonCodingKeyQuickType
        , ("JSONDecoder" .=) <$> jsonDecoderQuickType
        , ("JSONEncoder" .=) <$> jsonEncoderQuickType
        , ("JsonException" .=) <$> jsonExceptionQuickType
        , ("JsonGenerator" .=) <$> jsonGeneratorQuickType
        , ("JsonNode" .=) <$> jsonNodeQuickType
        , ("JSONNull" .=) <$> jsonNullQuickType
        , ("JsonParser" .=) <$> jsonParserQuickType
        , ("JsonReader" .=) <$> jsonReaderQuickType
        , ("JsonTokenType" .=) <$> jsonTokenTypeQuickType
        , ("KSerializer" .=) <$> kSerializerQuickType
        , ("lambda" .=) <$> lambdaQuickType
        , ("lazy" .=) <$> lazyQuickType
        , ("left" .=) <$> leftQuickType
        , ("let" .=) <$> quickTypeLetQuickType
        , ("list" .=) <$> listQuickType
        , ("LocalDate" .=) <$> localDateQuickType
        , ("Locale" .=) <$> localeQuickType
        , ("lock" .=) <$> lockQuickType
        , ("long" .=) <$> longQuickType
        , ("LongNode" .=) <$> longNodeQuickType
        , ("map" .=) <$> mapQuickType
        , ("MapEntry" .=) <$> mapEntryQuickType
        , ("MarshalJSON" .=) <$> marshalJSONQuickType
        , ("metadata_property_handling" .=) <$> metadataPropertyHandlingQuickType
        , ("module" .=) <$> quickTypeModuleQuickType
        , ("mutable" .=) <$> mutableQuickType
        , ("mutating" .=) <$> mutatingQuickType
        , ("namespace" .=) <$> namespaceQuickType
        , ("native" .=) <$> nativeQuickType
        , ("new" .=) <$> newQuickType
        , ("newtonsoft" .=) <$> newtonsoftQuickType
        , ("nil" .=) <$> nilQuickType
        , ("NO" .=) <$> noQuickType
        , ("noexcept" .=) <$> noexceptQuickType
        , ("nonatomic" .=) <$> nonatomicQuickType
        , ("none" .=) <$> quickTypeNoneQuickType
        , ("None" .=) <$> noneQuickType
        , ("nonlocal" .=) <$> nonlocalQuickType
        , ("nonmutating" .=) <$> nonmutatingQuickType
        , ("noSuchMethod" .=) <$> noSuchMethodQuickType
        , ("not" .=) <$> notQuickType
        , ("not_eq" .=) <$> notEqQuickType
        , ("NSError" .=) <$> nsErrorQuickType
        , ("NSObject" .=) <$> nsObjectQuickType
        , ("NSString" .=) <$> nsStringQuickType
        , ("NULL" .=) <$> nullQuickType
        , ("null" .=) <$> quickTypeNullQuickType
        , ("NullNode" .=) <$> nullNodeQuickType
        , ("nullptr" .=) <$> nullptrQuickType
        , ("number" .=) <$> numberQuickType
        , ("object" .=) <$> objectQuickType
        , ("ObjectMapper" .=) <$> objectMapperQuickType
        , ("ObjectNode" .=) <$> objectNodeQuickType
        , ("ObjectReader" .=) <$> objectReaderQuickType
        , ("ObjectWriter" .=) <$> objectWriterQuickType
        , ("of" .=) <$> quickTypeOfQuickType
        , ("OffsetDateTime" .=) <$> offsetDateTimeQuickType
        , ("OffsetTime" .=) <$> offsetTimeQuickType
        , ("oneway" .=) <$> onewayQuickType
        , ("open" .=) <$> openQuickType
        , ("operator" .=) <$> operatorQuickType
        , ("optional" .=) <$> optionalQuickType
        , ("or" .=) <$> orQuickType
        , ("or_eq" .=) <$> orEqQuickType
        , ("out" .=) <$> outQuickType
        , ("override" .=) <$> overrideQuickType
        , ("package" .=) <$> packageQuickType
        , ("params" .=) <$> paramsQuickType
        , ("pass" .=) <$> passQuickType
        , ("port" .=) <$> portQuickType
        , ("postfix" .=) <$> postfixQuickType
        , ("precedence" .=) <$> precedenceQuickType
        , ("prefix" .=) <$> prefixQuickType
        , ("PrimitiveKind" .=) <$> primitiveKindQuickType
        , ("print" .=) <$> printQuickType
        , ("printf" .=) <$> printfQuickType
        , ("printMembers" .=) <$> printMembersQuickType
        , ("private" .=) <$> privateQuickType
        , ("protected" .=) <$> protectedQuickType
        , ("Protocol" .=) <$> protocolQuickType
        , ("protocol" .=) <$> quickTypeProtocolQuickType
        , ("public" .=) <$> publicQuickType
        , ("quicktype" .=) <$> quicktypeQuickType
        , ("raise" .=) <$> raiseQuickType
        , ("range" .=) <$> rangeQuickType
        , ("readonly" .=) <$> readonlyQuickType
        , ("ref" .=) <$> refQuickType
        , ("RegExp" .=) <$> regExpQuickType
        , ("register" .=) <$> registerQuickType
        , ("reinterpret_cast" .=) <$> reinterpretCastQuickType
        , ("repeat" .=) <$> repeatQuickType
        , ("require" .=) <$> requireQuickType
        , ("required" .=) <$> requiredQuickType
        , ("requires" .=) <$> requiresQuickType
        , ("restrict" .=) <$> restrictQuickType
        , ("retain" .=) <$> retainQuickType
        , ("rethrows" .=) <$> rethrowsQuickType
        , ("return" .=) <$> returnQuickType
        , ("right" .=) <$> rightQuickType
        , ("runtimeType" .=) <$> runtimeTypeQuickType
        , ("s" .=) <$> sQuickType
        , ("sbyte" .=) <$> sbyteQuickType
        , ("sealed" .=) <$> sealedQuickType
        , ("SEL" .=) <$> selQuickType
        , ("select" .=) <$> selectQuickType
        , ("Self" .=) <$> selfQuickType
        , ("self" .=) <$> quickTypeSelfQuickType
        , ("Sendable" .=) <$> sendableQuickType
        , ("SerialDescriptor" .=) <$> serialDescriptorQuickType
        , ("Serializable" .=) <$> serializableQuickType
        , ("SerializationFeature" .=) <$> serializationFeatureQuickType
        , ("serialize" .=) <$> serializeQuickType
        , ("SerializerProvider" .=) <$> serializerProviderQuickType
        , ("SerialName" .=) <$> serialNameQuickType
        , ("set" .=) <$> setQuickType
        , ("short" .=) <$> shortQuickType
        , ("signed" .=) <$> signedQuickType
        , ("SimpleModule" .=) <$> simpleModuleQuickType
        , ("sizeof" .=) <$> sizeofQuickType
        , ("stackalloc" .=) <$> stackallocQuickType
        , ("Standards" .=) <$> standardsQuickType
        , ("static" .=) <$> staticQuickType
        , ("static_assert" .=) <$> staticAssertQuickType
        , ("static_cast" .=) <$> staticCastQuickType
        , ("StdDeserializer" .=) <$> stdDeserializerQuickType
        , ("StdSerializer" .=) <$> stdSerializerQuickType
        , ("strictfp" .=) <$> strictfpQuickType
        , ("string" .=) <$> stringQuickType
        , ("struct" .=) <$> structQuickType
        , ("subscript" .=) <$> subscriptQuickType
        , ("super" .=) <$> superQuickType
        , ("switch" .=) <$> switchQuickType
        , ("symbol" .=) <$> symbolQuickType
        , ("synchronized" .=) <$> synchronizedQuickType
        , ("system" .=) <$> systemQuickType
        , ("template" .=) <$> templateQuickType
        , ("TextNode" .=) <$> textNodeQuickType
        , ("then" .=) <$> quickTypeThenQuickType
        , ("this" .=) <$> thisQuickType
        , ("thread_local" .=) <$> threadLocalQuickType
        , ("throw" .=) <$> throwQuickType
        , ("throws" .=) <$> throwsQuickType
        , ("TimeOnly" .=) <$> timeOnlyQuickType
        , ("TimeOnlyConverter" .=) <$> timeOnlyConverterQuickType
        , ("TimeZone" .=) <$> timeZoneQuickType
        , ("to_dict" .=) <$> toDictQuickType
        , ("to_json" .=) <$> toJSONQuickType
        , ("top_level" .=) <$> topLevelQuickType
        , ("toString" .=) <$> toStringQuickType
        , ("transient" .=) <$> transientQuickType
        , ("True" .=) <$> trueQuickType
        , ("true" .=) <$> quickTypeTrueQuickType
        , ("try" .=) <$> tryQuickType
        , ("Type" .=) <$> quickTypeTypeQuickType
        , ("type" .=) <$> purpleTypeQuickType
        , ("typealias" .=) <$> typealiasQuickType
        , ("typedef" .=) <$> typedefQuickType
        , ("typeid" .=) <$> typeidQuickType
        , ("typename" .=) <$> typenameQuickType
        , ("typeof" .=) <$> typeofQuickType
        , ("uint" .=) <$> uintQuickType
        , ("ulong" .=) <$> ulongQuickType
        , ("unchecked" .=) <$> uncheckedQuickType
        , ("undefined" .=) <$> undefinedQuickType
        , ("union" .=) <$> unionQuickType
        , ("UnmarshalJSON" .=) <$> unmarshalJSONQuickType
        , ("unowned" .=) <$> unownedQuickType
        , ("unsafe" .=) <$> unsafeQuickType
        , ("unsigned" .=) <$> unsignedQuickType
        , ("UseSerializers" .=) <$> useSerializersQuickType
        , ("ushort" .=) <$> ushortQuickType
        , ("using" .=) <$> usingQuickType
        , ("Utf8JsonReader" .=) <$> utf8JSONReaderQuickType
        , ("Utf8JsonWriter" .=) <$> utf8JSONWriterQuickType
        , ("UUID" .=) <$> uuidQuickType
        , ("var" .=) <$> varQuickType
        , ("virtual" .=) <$> virtualQuickType
        , ("void" .=) <$> voidQuickType
        , ("volatile" .=) <$> volatileQuickType
        , ("wchar_t" .=) <$> wcharTQuickType
        , ("weak" .=) <$> weakQuickType
        , ("where" .=) <$> quickTypeWhereQuickType
        , ("while" .=) <$> whileQuickType
        , ("willSet" .=) <$> willSetQuickType
        , ("with" .=) <$> withQuickType
        , ("xor" .=) <$> xorQuickType
        , ("xor_eq" .=) <$> xorEqQuickType
        , ("YES" .=) <$> yesQuickType
        , ("yield" .=) <$> yieldQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "_"
        <*> v .:! "_Bool"
        <*> v .:! "_Complex"
        <*> v .:! "_Imaginery"
        <*> v .:! "abstract"
        <*> v .:! "alignas"
        <*> v .:! "alignof"
        <*> v .:! "and"
        <*> v .:! "and_eq"
        <*> v .:! "any"
        <*> v .:! "Any"
        <*> v .:! "array"
        <*> v .:! "ArrayNode"
        <*> v .:! "as"
        <*> v .:! "asm"
        <*> v .:! "assert"
        <*> v .:! "associatedtype"
        <*> v .:! "associativity"
        <*> v .:! "async"
        <*> v .:! "atomic"
        <*> v .:! "atomic_cancel"
        <*> v .:! "atomic_commit"
        <*> v .:! "atomic_noexcept"
        <*> v .:! "auto"
        <*> v .:! "await"
        <*> v .:! "base"
        <*> v .:! "bitand"
        <*> v .:! "bitor"
        <*> v .:! "BOOL"
        <*> v .:! "bool"
        <*> v .:! "boolean"
        <*> v .:! "BooleanNode"
        <*> v .:! "break"
        <*> v .:! "bycopy"
        <*> v .:! "byref"
        <*> v .:! "byte"
        <*> v .:! "Calendar"
        <*> v .:! "case"
        <*> v .:! "catch"
        <*> v .:! "chan"
        <*> v .:! "char"
        <*> v .:! "char16_t"
        <*> v .:! "char32_t"
        <*> v .:! "checked"
        <*> v .:! "class"
        <*> v .:! "Class"
        <*> v .:! "clone"
        <*> v .:! "co_await"
        <*> v .:! "co_return"
        <*> v .:! "co_yield"
        <*> v .:! "Codable"
        <*> v .:! "CodingKey"
        <*> v .:! "CodingKeys"
        <*> v .:! "compl"
        <*> v .:! "concept"
        <*> v .:! "console"
        <*> v .:! "const"
        <*> v .:! "const_cast"
        <*> v .:! "constexpr"
        <*> v .:! "constructor"
        <*> v .:! "continue"
        <*> v .:! "convenience"
        <*> v .:! "convert"
        <*> v .:! "converter"
        <*> v .:! "CultureInfo"
        <*> v .:! "date"
        <*> v .:! "date_parse_handling"
        <*> v .:! "DateFormatter"
        <*> v .:! "DateOnly"
        <*> v .:! "DateOnlyConverter"
        <*> v .:! "DateTime"
        <*> v .:! "DateTimeStyles"
        <*> v .:! "debugger"
        <*> v .:! "decimal"
        <*> v .:! "declare"
        <*> v .:! "decltype"
        <*> v .:! "decode_string"
        <*> v .:! "Decoder"
        <*> v .:! "DecodingError"
        <*> v .:! "def"
        <*> v .:! "default"
        <*> v .:! "defer"
        <*> v .:! "deinit"
        <*> v .:! "del"
        <*> v .:! "delegate"
        <*> v .:! "delete"
        <*> v .:! "DeserializationFeature"
        <*> v .:! "dict"
        <*> v .:! "dictionary"
        <*> v .:! "didSet"
        <*> v .:! "do"
        <*> v .:! "double"
        <*> v .:! "DoubleNode"
        <*> v .:! "dummy"
        <*> v .:! "dynamic"
        <*> v .:! "dynamic_cast"
        <*> v .:! "elif"
        <*> v .:! "else"
        <*> v .:! "encode_quick_type"
        <*> v .:! "Encoder"
        <*> v .:! "enum"
        <*> v .:! "EnumValues"
        <*> v .:! "equalityContract"
        <*> v .:! "Equatable"
        <*> v .:! "event"
        <*> v .:! "except"
        <*> v .:! "exception"
        <*> v .:! "explicit"
        <*> v .:! "export"
        <*> v .:! "exposing"
        <*> v .:! "extends"
        <*> v .:! "extension"
        <*> v .:! "extern"
        <*> v .:! "fallthrough"
        <*> v .:! "false"
        <*> v .:! "False"
        <*> v .:! "fileprivate"
        <*> v .:! "final"
        <*> v .:! "finally"
        <*> v .:! "fixed"
        <*> v .:! "float"
        <*> v .:! "for"
        <*> v .:! "foreach"
        <*> v .:! "FormatException"
        <*> v .:! "friend"
        <*> v .:! "from"
        <*> v .:! "from_dict"
        <*> v .:! "from_json"
        <*> v .:! "func"
        <*> v .:! "function"
        <*> v .:! "get"
        <*> v .:! "global"
        <*> v .:! "go"
        <*> v .:! "goto"
        <*> v .:! "guard"
        <*> v .:! "Hashable"
        <*> v .:! "hashCode"
        <*> v .:! "Hasher"
        <*> v .:! "hasOwnProperty"
        <*> v .:! "id"
        <*> v .:! "if"
        <*> v .:! "IMP"
        <*> v .:! "implements"
        <*> v .:! "implicit"
        <*> v .:! "import"
        <*> v .:! "in"
        <*> v .:! "indirect"
        <*> v .:! "infix"
        <*> v .:! "init"
        <*> v .:! "inline"
        <*> v .:! "inout"
        <*> v .:! "instanceof"
        <*> v .:! "int"
        <*> v .:! "interface"
        <*> v .:! "internal"
        <*> v .:! "IntNode"
        <*> v .:! "is"
        <*> v .:! "IsoDateTimeOffsetConverter"
        <*> v .:! "iterable"
        <*> v .:! "jdec"
        <*> v .:! "jenc"
        <*> v .:! "jpipe"
        <*> v .:! "json"
        <*> v .:! "json_converter"
        <*> v .:! "json_serializer"
        <*> v .:! "json_token"
        <*> v .:! "json_writer"
        <*> v .:! "JSONAny"
        <*> v .:! "JSONCodingKey"
        <*> v .:! "JSONDecoder"
        <*> v .:! "JSONEncoder"
        <*> v .:! "JsonException"
        <*> v .:! "JsonGenerator"
        <*> v .:! "JsonNode"
        <*> v .:! "JSONNull"
        <*> v .:! "JsonParser"
        <*> v .:! "JsonReader"
        <*> v .:! "JsonTokenType"
        <*> v .:! "KSerializer"
        <*> v .:! "lambda"
        <*> v .:! "lazy"
        <*> v .:! "left"
        <*> v .:! "let"
        <*> v .:! "list"
        <*> v .:! "LocalDate"
        <*> v .:! "Locale"
        <*> v .:! "lock"
        <*> v .:! "long"
        <*> v .:! "LongNode"
        <*> v .:! "map"
        <*> v .:! "MapEntry"
        <*> v .:! "MarshalJSON"
        <*> v .:! "metadata_property_handling"
        <*> v .:! "module"
        <*> v .:! "mutable"
        <*> v .:! "mutating"
        <*> v .:! "namespace"
        <*> v .:! "native"
        <*> v .:! "new"
        <*> v .:! "newtonsoft"
        <*> v .:! "nil"
        <*> v .:! "NO"
        <*> v .:! "noexcept"
        <*> v .:! "nonatomic"
        <*> v .:! "none"
        <*> v .:! "None"
        <*> v .:! "nonlocal"
        <*> v .:! "nonmutating"
        <*> v .:! "noSuchMethod"
        <*> v .:! "not"
        <*> v .:! "not_eq"
        <*> v .:! "NSError"
        <*> v .:! "NSObject"
        <*> v .:! "NSString"
        <*> v .:! "NULL"
        <*> v .:! "null"
        <*> v .:! "NullNode"
        <*> v .:! "nullptr"
        <*> v .:! "number"
        <*> v .:! "object"
        <*> v .:! "ObjectMapper"
        <*> v .:! "ObjectNode"
        <*> v .:! "ObjectReader"
        <*> v .:! "ObjectWriter"
        <*> v .:! "of"
        <*> v .:! "OffsetDateTime"
        <*> v .:! "OffsetTime"
        <*> v .:! "oneway"
        <*> v .:! "open"
        <*> v .:! "operator"
        <*> v .:! "optional"
        <*> v .:! "or"
        <*> v .:! "or_eq"
        <*> v .:! "out"
        <*> v .:! "override"
        <*> v .:! "package"
        <*> v .:! "params"
        <*> v .:! "pass"
        <*> v .:! "port"
        <*> v .:! "postfix"
        <*> v .:! "precedence"
        <*> v .:! "prefix"
        <*> v .:! "PrimitiveKind"
        <*> v .:! "print"
        <*> v .:! "printf"
        <*> v .:! "printMembers"
        <*> v .:! "private"
        <*> v .:! "protected"
        <*> v .:! "Protocol"
        <*> v .:! "protocol"
        <*> v .:! "public"
        <*> v .:! "quicktype"
        <*> v .:! "raise"
        <*> v .:! "range"
        <*> v .:! "readonly"
        <*> v .:! "ref"
        <*> v .:! "RegExp"
        <*> v .:! "register"
        <*> v .:! "reinterpret_cast"
        <*> v .:! "repeat"
        <*> v .:! "require"
        <*> v .:! "required"
        <*> v .:! "requires"
        <*> v .:! "restrict"
        <*> v .:! "retain"
        <*> v .:! "rethrows"
        <*> v .:! "return"
        <*> v .:! "right"
        <*> v .:! "runtimeType"
        <*> v .:! "s"
        <*> v .:! "sbyte"
        <*> v .:! "sealed"
        <*> v .:! "SEL"
        <*> v .:! "select"
        <*> v .:! "Self"
        <*> v .:! "self"
        <*> v .:! "Sendable"
        <*> v .:! "SerialDescriptor"
        <*> v .:! "Serializable"
        <*> v .:! "SerializationFeature"
        <*> v .:! "serialize"
        <*> v .:! "SerializerProvider"
        <*> v .:! "SerialName"
        <*> v .:! "set"
        <*> v .:! "short"
        <*> v .:! "signed"
        <*> v .:! "SimpleModule"
        <*> v .:! "sizeof"
        <*> v .:! "stackalloc"
        <*> v .:! "Standards"
        <*> v .:! "static"
        <*> v .:! "static_assert"
        <*> v .:! "static_cast"
        <*> v .:! "StdDeserializer"
        <*> v .:! "StdSerializer"
        <*> v .:! "strictfp"
        <*> v .:! "string"
        <*> v .:! "struct"
        <*> v .:! "subscript"
        <*> v .:! "super"
        <*> v .:! "switch"
        <*> v .:! "symbol"
        <*> v .:! "synchronized"
        <*> v .:! "system"
        <*> v .:! "template"
        <*> v .:! "TextNode"
        <*> v .:! "then"
        <*> v .:! "this"
        <*> v .:! "thread_local"
        <*> v .:! "throw"
        <*> v .:! "throws"
        <*> v .:! "TimeOnly"
        <*> v .:! "TimeOnlyConverter"
        <*> v .:! "TimeZone"
        <*> v .:! "to_dict"
        <*> v .:! "to_json"
        <*> v .:! "top_level"
        <*> v .:! "toString"
        <*> v .:! "transient"
        <*> v .:! "True"
        <*> v .:! "true"
        <*> v .:! "try"
        <*> v .:! "Type"
        <*> v .:! "type"
        <*> v .:! "typealias"
        <*> v .:! "typedef"
        <*> v .:! "typeid"
        <*> v .:! "typename"
        <*> v .:! "typeof"
        <*> v .:! "uint"
        <*> v .:! "ulong"
        <*> v .:! "unchecked"
        <*> v .:! "undefined"
        <*> v .:! "union"
        <*> v .:! "UnmarshalJSON"
        <*> v .:! "unowned"
        <*> v .:! "unsafe"
        <*> v .:! "unsigned"
        <*> v .:! "UseSerializers"
        <*> v .:! "ushort"
        <*> v .:! "using"
        <*> v .:! "Utf8JsonReader"
        <*> v .:! "Utf8JsonWriter"
        <*> v .:! "UUID"
        <*> v .:! "var"
        <*> v .:! "virtual"
        <*> v .:! "void"
        <*> v .:! "volatile"
        <*> v .:! "wchar_t"
        <*> v .:! "weak"
        <*> v .:! "where"
        <*> v .:! "while"
        <*> v .:! "willSet"
        <*> v .:! "with"
        <*> v .:! "xor"
        <*> v .:! "xor_eq"
        <*> v .:! "YES"
        <*> v .:! "yield"

instance ToJSON UnionAbstract where
    toJSON (AbstractInUnionAbstract x) = toJSON x
    toJSON (DoubleInUnionAbstract x) = toJSON x

instance FromJSON UnionAbstract where
    parseJSON xs@(Object _) = (fmap AbstractInUnionAbstract . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAbstract . parseJSON) xs

instance ToJSON Abstract where
    toJSON = \_ -> emptyObject

instance FromJSON Abstract where
    parseJSON (Object _) = return Abstract

instance ToJSON UnionAlignas where
    toJSON (AlignasInUnionAlignas x) = toJSON x
    toJSON (DoubleInUnionAlignas x) = toJSON x

instance FromJSON UnionAlignas where
    parseJSON xs@(Object _) = (fmap AlignasInUnionAlignas . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAlignas . parseJSON) xs

instance ToJSON Alignas where
    toJSON = \_ -> emptyObject

instance FromJSON Alignas where
    parseJSON (Object _) = return Alignas

instance ToJSON UnionAlignof where
    toJSON (AlignofInUnionAlignof x) = toJSON x
    toJSON (DoubleInUnionAlignof x) = toJSON x

instance FromJSON UnionAlignof where
    parseJSON xs@(Object _) = (fmap AlignofInUnionAlignof . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAlignof . parseJSON) xs

instance ToJSON Alignof where
    toJSON = \_ -> emptyObject

instance FromJSON Alignof where
    parseJSON (Object _) = return Alignof

instance ToJSON UnionAnd where
    toJSON (AndInUnionAnd x) = toJSON x
    toJSON (DoubleInUnionAnd x) = toJSON x

instance FromJSON UnionAnd where
    parseJSON xs@(Object _) = (fmap AndInUnionAnd . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAnd . parseJSON) xs

instance ToJSON And where
    toJSON = \_ -> emptyObject

instance FromJSON And where
    parseJSON (Object _) = return And

instance ToJSON UnionAndEq where
    toJSON (AndEqInUnionAndEq x) = toJSON x
    toJSON (DoubleInUnionAndEq x) = toJSON x

instance FromJSON UnionAndEq where
    parseJSON xs@(Object _) = (fmap AndEqInUnionAndEq . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAndEq . parseJSON) xs

instance ToJSON AndEq where
    toJSON = \_ -> emptyObject

instance FromJSON AndEq where
    parseJSON (Object _) = return AndEq

instance ToJSON UnionAny where
    toJSON (AnyInUnionAny x) = toJSON x
    toJSON (DoubleInUnionAny x) = toJSON x

instance FromJSON UnionAny where
    parseJSON xs@(Object _) = (fmap AnyInUnionAny . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAny . parseJSON) xs

instance ToJSON Any where
    toJSON = \_ -> emptyObject

instance FromJSON Any where
    parseJSON (Object _) = return Any

instance ToJSON UnionArray where
    toJSON (ArrayClassInUnionArray x) = toJSON x
    toJSON (DoubleInUnionArray x) = toJSON x

instance FromJSON UnionArray where
    parseJSON xs@(Object _) = (fmap ArrayClassInUnionArray . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionArray . parseJSON) xs

instance ToJSON ArrayClass where
    toJSON = \_ -> emptyObject

instance FromJSON ArrayClass where
    parseJSON (Object _) = return ArrayClass

instance ToJSON UnionArrayNode where
    toJSON (ArrayNodeInUnionArrayNode x) = toJSON x
    toJSON (DoubleInUnionArrayNode x) = toJSON x

instance FromJSON UnionArrayNode where
    parseJSON xs@(Object _) = (fmap ArrayNodeInUnionArrayNode . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionArrayNode . parseJSON) xs

instance ToJSON ArrayNode where
    toJSON = \_ -> emptyObject

instance FromJSON ArrayNode where
    parseJSON (Object _) = return ArrayNode

instance ToJSON UnionASM where
    toJSON (ASMInUnionASM x) = toJSON x
    toJSON (DoubleInUnionASM x) = toJSON x

instance FromJSON UnionASM where
    parseJSON xs@(Object _) = (fmap ASMInUnionASM . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionASM . parseJSON) xs

instance ToJSON ASM where
    toJSON = \_ -> emptyObject

instance FromJSON ASM where
    parseJSON (Object _) = return ASM

instance ToJSON UnionAssert where
    toJSON (AssertInUnionAssert x) = toJSON x
    toJSON (DoubleInUnionAssert x) = toJSON x

instance FromJSON UnionAssert where
    parseJSON xs@(Object _) = (fmap AssertInUnionAssert . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAssert . parseJSON) xs

instance ToJSON Assert where
    toJSON = \_ -> emptyObject

instance FromJSON Assert where
    parseJSON (Object _) = return Assert

instance ToJSON UnionAssociatedtype where
    toJSON (AssociatedtypeInUnionAssociatedtype x) = toJSON x
    toJSON (DoubleInUnionAssociatedtype x) = toJSON x

instance FromJSON UnionAssociatedtype where
    parseJSON xs@(Object _) = (fmap AssociatedtypeInUnionAssociatedtype . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAssociatedtype . parseJSON) xs

instance ToJSON Associatedtype where
    toJSON = \_ -> emptyObject

instance FromJSON Associatedtype where
    parseJSON (Object _) = return Associatedtype

instance ToJSON UnionAssociativity where
    toJSON (AssociativityInUnionAssociativity x) = toJSON x
    toJSON (DoubleInUnionAssociativity x) = toJSON x

instance FromJSON UnionAssociativity where
    parseJSON xs@(Object _) = (fmap AssociativityInUnionAssociativity . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAssociativity . parseJSON) xs

instance ToJSON Associativity where
    toJSON = \_ -> emptyObject

instance FromJSON Associativity where
    parseJSON (Object _) = return Associativity

instance ToJSON UnionAsync where
    toJSON (AsyncInUnionAsync x) = toJSON x
    toJSON (DoubleInUnionAsync x) = toJSON x

instance FromJSON UnionAsync where
    parseJSON xs@(Object _) = (fmap AsyncInUnionAsync . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAsync . parseJSON) xs

instance ToJSON Async where
    toJSON = \_ -> emptyObject

instance FromJSON Async where
    parseJSON (Object _) = return Async

instance ToJSON UnionAtomic where
    toJSON (AtomicInUnionAtomic x) = toJSON x
    toJSON (DoubleInUnionAtomic x) = toJSON x

instance FromJSON UnionAtomic where
    parseJSON xs@(Object _) = (fmap AtomicInUnionAtomic . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAtomic . parseJSON) xs

instance ToJSON Atomic where
    toJSON = \_ -> emptyObject

instance FromJSON Atomic where
    parseJSON (Object _) = return Atomic

instance ToJSON UnionAtomicCancel where
    toJSON (AtomicCancelInUnionAtomicCancel x) = toJSON x
    toJSON (DoubleInUnionAtomicCancel x) = toJSON x

instance FromJSON UnionAtomicCancel where
    parseJSON xs@(Object _) = (fmap AtomicCancelInUnionAtomicCancel . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAtomicCancel . parseJSON) xs

instance ToJSON AtomicCancel where
    toJSON = \_ -> emptyObject

instance FromJSON AtomicCancel where
    parseJSON (Object _) = return AtomicCancel

instance ToJSON UnionAtomicCommit where
    toJSON (AtomicCommitInUnionAtomicCommit x) = toJSON x
    toJSON (DoubleInUnionAtomicCommit x) = toJSON x

instance FromJSON UnionAtomicCommit where
    parseJSON xs@(Object _) = (fmap AtomicCommitInUnionAtomicCommit . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAtomicCommit . parseJSON) xs

instance ToJSON AtomicCommit where
    toJSON = \_ -> emptyObject

instance FromJSON AtomicCommit where
    parseJSON (Object _) = return AtomicCommit

instance ToJSON UnionAtomicNoexcept where
    toJSON (AtomicNoexceptInUnionAtomicNoexcept x) = toJSON x
    toJSON (DoubleInUnionAtomicNoexcept x) = toJSON x

instance FromJSON UnionAtomicNoexcept where
    parseJSON xs@(Object _) = (fmap AtomicNoexceptInUnionAtomicNoexcept . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAtomicNoexcept . parseJSON) xs

instance ToJSON AtomicNoexcept where
    toJSON = \_ -> emptyObject

instance FromJSON AtomicNoexcept where
    parseJSON (Object _) = return AtomicNoexcept

instance ToJSON UnionAuto where
    toJSON (AutoInUnionAuto x) = toJSON x
    toJSON (DoubleInUnionAuto x) = toJSON x

instance FromJSON UnionAuto where
    parseJSON xs@(Object _) = (fmap AutoInUnionAuto . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAuto . parseJSON) xs

instance ToJSON Auto where
    toJSON = \_ -> emptyObject

instance FromJSON Auto where
    parseJSON (Object _) = return Auto

instance ToJSON UnionAwait where
    toJSON (AwaitInUnionAwait x) = toJSON x
    toJSON (DoubleInUnionAwait x) = toJSON x

instance FromJSON UnionAwait where
    parseJSON xs@(Object _) = (fmap AwaitInUnionAwait . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAwait . parseJSON) xs

instance ToJSON Await where
    toJSON = \_ -> emptyObject

instance FromJSON Await where
    parseJSON (Object _) = return Await

instance ToJSON UnionBase where
    toJSON (BaseInUnionBase x) = toJSON x
    toJSON (DoubleInUnionBase x) = toJSON x

instance FromJSON UnionBase where
    parseJSON xs@(Object _) = (fmap BaseInUnionBase . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBase . parseJSON) xs

instance ToJSON Base where
    toJSON = \_ -> emptyObject

instance FromJSON Base where
    parseJSON (Object _) = return Base

instance ToJSON UnionBitand where
    toJSON (BitandInUnionBitand x) = toJSON x
    toJSON (DoubleInUnionBitand x) = toJSON x

instance FromJSON UnionBitand where
    parseJSON xs@(Object _) = (fmap BitandInUnionBitand . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBitand . parseJSON) xs

instance ToJSON Bitand where
    toJSON = \_ -> emptyObject

instance FromJSON Bitand where
    parseJSON (Object _) = return Bitand

instance ToJSON UnionBitor where
    toJSON (BitorInUnionBitor x) = toJSON x
    toJSON (DoubleInUnionBitor x) = toJSON x

instance FromJSON UnionBitor where
    parseJSON xs@(Object _) = (fmap BitorInUnionBitor . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBitor . parseJSON) xs

instance ToJSON Bitor where
    toJSON = \_ -> emptyObject

instance FromJSON Bitor where
    parseJSON (Object _) = return Bitor

instance ToJSON UnionBOOL where
    toJSON (BOOLClassInUnionBOOL x) = toJSON x
    toJSON (DoubleInUnionBOOL x) = toJSON x

instance FromJSON UnionBOOL where
    parseJSON xs@(Object _) = (fmap BOOLClassInUnionBOOL . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBOOL . parseJSON) xs

instance ToJSON BOOLClass where
    toJSON = \_ -> emptyObject

instance FromJSON BOOLClass where
    parseJSON (Object _) = return BOOLClass

instance ToJSON UnionBoolean where
    toJSON (BooleanInUnionBoolean x) = toJSON x
    toJSON (DoubleInUnionBoolean x) = toJSON x

instance FromJSON UnionBoolean where
    parseJSON xs@(Object _) = (fmap BooleanInUnionBoolean . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBoolean . parseJSON) xs

instance ToJSON Boolean where
    toJSON = \_ -> emptyObject

instance FromJSON Boolean where
    parseJSON (Object _) = return Boolean

instance ToJSON UnionBooleanNode where
    toJSON (BooleanNodeInUnionBooleanNode x) = toJSON x
    toJSON (DoubleInUnionBooleanNode x) = toJSON x

instance FromJSON UnionBooleanNode where
    parseJSON xs@(Object _) = (fmap BooleanNodeInUnionBooleanNode . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBooleanNode . parseJSON) xs

instance ToJSON BooleanNode where
    toJSON = \_ -> emptyObject

instance FromJSON BooleanNode where
    parseJSON (Object _) = return BooleanNode

instance ToJSON UnionBreak where
    toJSON (BreakInUnionBreak x) = toJSON x
    toJSON (DoubleInUnionBreak x) = toJSON x

instance FromJSON UnionBreak where
    parseJSON xs@(Object _) = (fmap BreakInUnionBreak . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBreak . parseJSON) xs

instance ToJSON Break where
    toJSON = \_ -> emptyObject

instance FromJSON Break where
    parseJSON (Object _) = return Break

instance ToJSON UnionBycopy where
    toJSON (BycopyInUnionBycopy x) = toJSON x
    toJSON (DoubleInUnionBycopy x) = toJSON x

instance FromJSON UnionBycopy where
    parseJSON xs@(Object _) = (fmap BycopyInUnionBycopy . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBycopy . parseJSON) xs

instance ToJSON Bycopy where
    toJSON = \_ -> emptyObject

instance FromJSON Bycopy where
    parseJSON (Object _) = return Bycopy

instance ToJSON UnionByref where
    toJSON (ByrefInUnionByref x) = toJSON x
    toJSON (DoubleInUnionByref x) = toJSON x

instance FromJSON UnionByref where
    parseJSON xs@(Object _) = (fmap ByrefInUnionByref . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionByref . parseJSON) xs

instance ToJSON Byref where
    toJSON = \_ -> emptyObject

instance FromJSON Byref where
    parseJSON (Object _) = return Byref

instance ToJSON UnionByte where
    toJSON (ByteInUnionByte x) = toJSON x
    toJSON (DoubleInUnionByte x) = toJSON x

instance FromJSON UnionByte where
    parseJSON xs@(Object _) = (fmap ByteInUnionByte . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionByte . parseJSON) xs

instance ToJSON Byte where
    toJSON = \_ -> emptyObject

instance FromJSON Byte where
    parseJSON (Object _) = return Byte

instance ToJSON UnionCalendar where
    toJSON (CalendarInUnionCalendar x) = toJSON x
    toJSON (DoubleInUnionCalendar x) = toJSON x

instance FromJSON UnionCalendar where
    parseJSON xs@(Object _) = (fmap CalendarInUnionCalendar . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCalendar . parseJSON) xs

instance ToJSON Calendar where
    toJSON = \_ -> emptyObject

instance FromJSON Calendar where
    parseJSON (Object _) = return Calendar

instance ToJSON UnionCatch where
    toJSON (CatchInUnionCatch x) = toJSON x
    toJSON (DoubleInUnionCatch x) = toJSON x

instance FromJSON UnionCatch where
    parseJSON xs@(Object _) = (fmap CatchInUnionCatch . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCatch . parseJSON) xs

instance ToJSON Catch where
    toJSON = \_ -> emptyObject

instance FromJSON Catch where
    parseJSON (Object _) = return Catch

instance ToJSON UnionChan where
    toJSON (ChanInUnionChan x) = toJSON x
    toJSON (DoubleInUnionChan x) = toJSON x

instance FromJSON UnionChan where
    parseJSON xs@(Object _) = (fmap ChanInUnionChan . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionChan . parseJSON) xs

instance ToJSON Chan where
    toJSON = \_ -> emptyObject

instance FromJSON Chan where
    parseJSON (Object _) = return Chan

instance ToJSON UnionChar where
    toJSON (CharClassInUnionChar x) = toJSON x
    toJSON (DoubleInUnionChar x) = toJSON x

instance FromJSON UnionChar where
    parseJSON xs@(Object _) = (fmap CharClassInUnionChar . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionChar . parseJSON) xs

instance ToJSON CharClass where
    toJSON = \_ -> emptyObject

instance FromJSON CharClass where
    parseJSON (Object _) = return CharClass

instance ToJSON UnionChar16T where
    toJSON (Char16TInUnionChar16T x) = toJSON x
    toJSON (DoubleInUnionChar16T x) = toJSON x

instance FromJSON UnionChar16T where
    parseJSON xs@(Object _) = (fmap Char16TInUnionChar16T . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionChar16T . parseJSON) xs

instance ToJSON Char16T where
    toJSON = \_ -> emptyObject

instance FromJSON Char16T where
    parseJSON (Object _) = return Char16T

instance ToJSON UnionChar32T where
    toJSON (Char32TInUnionChar32T x) = toJSON x
    toJSON (DoubleInUnionChar32T x) = toJSON x

instance FromJSON UnionChar32T where
    parseJSON xs@(Object _) = (fmap Char32TInUnionChar32T . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionChar32T . parseJSON) xs

instance ToJSON Char32T where
    toJSON = \_ -> emptyObject

instance FromJSON Char32T where
    parseJSON (Object _) = return Char32T

instance ToJSON UnionChecked where
    toJSON (CheckedInUnionChecked x) = toJSON x
    toJSON (DoubleInUnionChecked x) = toJSON x

instance FromJSON UnionChecked where
    parseJSON xs@(Object _) = (fmap CheckedInUnionChecked . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionChecked . parseJSON) xs

instance ToJSON Checked where
    toJSON = \_ -> emptyObject

instance FromJSON Checked where
    parseJSON (Object _) = return Checked

instance ToJSON UnionClone where
    toJSON (CloneInUnionClone x) = toJSON x
    toJSON (DoubleInUnionClone x) = toJSON x

instance FromJSON UnionClone where
    parseJSON xs@(Object _) = (fmap CloneInUnionClone . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionClone . parseJSON) xs

instance ToJSON Clone where
    toJSON = \_ -> emptyObject

instance FromJSON Clone where
    parseJSON (Object _) = return Clone

instance ToJSON UnionCoAwait where
    toJSON (CoAwaitInUnionCoAwait x) = toJSON x
    toJSON (DoubleInUnionCoAwait x) = toJSON x

instance FromJSON UnionCoAwait where
    parseJSON xs@(Object _) = (fmap CoAwaitInUnionCoAwait . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCoAwait . parseJSON) xs

instance ToJSON CoAwait where
    toJSON = \_ -> emptyObject

instance FromJSON CoAwait where
    parseJSON (Object _) = return CoAwait

instance ToJSON UnionCoReturn where
    toJSON (CoReturnInUnionCoReturn x) = toJSON x
    toJSON (DoubleInUnionCoReturn x) = toJSON x

instance FromJSON UnionCoReturn where
    parseJSON xs@(Object _) = (fmap CoReturnInUnionCoReturn . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCoReturn . parseJSON) xs

instance ToJSON CoReturn where
    toJSON = \_ -> emptyObject

instance FromJSON CoReturn where
    parseJSON (Object _) = return CoReturn

instance ToJSON UnionCoYield where
    toJSON (CoYieldInUnionCoYield x) = toJSON x
    toJSON (DoubleInUnionCoYield x) = toJSON x

instance FromJSON UnionCoYield where
    parseJSON xs@(Object _) = (fmap CoYieldInUnionCoYield . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCoYield . parseJSON) xs

instance ToJSON CoYield where
    toJSON = \_ -> emptyObject

instance FromJSON CoYield where
    parseJSON (Object _) = return CoYield

instance ToJSON UnionCodable where
    toJSON (CodableInUnionCodable x) = toJSON x
    toJSON (DoubleInUnionCodable x) = toJSON x

instance FromJSON UnionCodable where
    parseJSON xs@(Object _) = (fmap CodableInUnionCodable . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCodable . parseJSON) xs

instance ToJSON Codable where
    toJSON = \_ -> emptyObject

instance FromJSON Codable where
    parseJSON (Object _) = return Codable

instance ToJSON UnionCodingKey where
    toJSON (CodingKeyInUnionCodingKey x) = toJSON x
    toJSON (DoubleInUnionCodingKey x) = toJSON x

instance FromJSON UnionCodingKey where
    parseJSON xs@(Object _) = (fmap CodingKeyInUnionCodingKey . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCodingKey . parseJSON) xs

instance ToJSON CodingKey where
    toJSON = \_ -> emptyObject

instance FromJSON CodingKey where
    parseJSON (Object _) = return CodingKey

instance ToJSON UnionCodingKeys where
    toJSON (CodingKeysInUnionCodingKeys x) = toJSON x
    toJSON (DoubleInUnionCodingKeys x) = toJSON x

instance FromJSON UnionCodingKeys where
    parseJSON xs@(Object _) = (fmap CodingKeysInUnionCodingKeys . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCodingKeys . parseJSON) xs

instance ToJSON CodingKeys where
    toJSON = \_ -> emptyObject

instance FromJSON CodingKeys where
    parseJSON (Object _) = return CodingKeys

instance ToJSON UnionCompl where
    toJSON (ComplInUnionCompl x) = toJSON x
    toJSON (DoubleInUnionCompl x) = toJSON x

instance FromJSON UnionCompl where
    parseJSON xs@(Object _) = (fmap ComplInUnionCompl . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCompl . parseJSON) xs

instance ToJSON Compl where
    toJSON = \_ -> emptyObject

instance FromJSON Compl where
    parseJSON (Object _) = return Compl

instance ToJSON UnionComplex where
    toJSON (ComplexInUnionComplex x) = toJSON x
    toJSON (DoubleInUnionComplex x) = toJSON x

instance FromJSON UnionComplex where
    parseJSON xs@(Object _) = (fmap ComplexInUnionComplex . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionComplex . parseJSON) xs

instance ToJSON Complex where
    toJSON = \_ -> emptyObject

instance FromJSON Complex where
    parseJSON (Object _) = return Complex

instance ToJSON UnionConcept where
    toJSON (ConceptInUnionConcept x) = toJSON x
    toJSON (DoubleInUnionConcept x) = toJSON x

instance FromJSON UnionConcept where
    parseJSON xs@(Object _) = (fmap ConceptInUnionConcept . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConcept . parseJSON) xs

instance ToJSON Concept where
    toJSON = \_ -> emptyObject

instance FromJSON Concept where
    parseJSON (Object _) = return Concept

instance ToJSON UnionConsole where
    toJSON (ConsoleInUnionConsole x) = toJSON x
    toJSON (DoubleInUnionConsole x) = toJSON x

instance FromJSON UnionConsole where
    parseJSON xs@(Object _) = (fmap ConsoleInUnionConsole . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConsole . parseJSON) xs

instance ToJSON Console where
    toJSON = \_ -> emptyObject

instance FromJSON Console where
    parseJSON (Object _) = return Console

instance ToJSON UnionConst where
    toJSON (ConstInUnionConst x) = toJSON x
    toJSON (DoubleInUnionConst x) = toJSON x

instance FromJSON UnionConst where
    parseJSON xs@(Object _) = (fmap ConstInUnionConst . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConst . parseJSON) xs

instance ToJSON Const where
    toJSON = \_ -> emptyObject

instance FromJSON Const where
    parseJSON (Object _) = return Const

instance ToJSON UnionConstCast where
    toJSON (ConstCastInUnionConstCast x) = toJSON x
    toJSON (DoubleInUnionConstCast x) = toJSON x

instance FromJSON UnionConstCast where
    parseJSON xs@(Object _) = (fmap ConstCastInUnionConstCast . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConstCast . parseJSON) xs

instance ToJSON ConstCast where
    toJSON = \_ -> emptyObject

instance FromJSON ConstCast where
    parseJSON (Object _) = return ConstCast

instance ToJSON UnionConstexpr where
    toJSON (ConstexprInUnionConstexpr x) = toJSON x
    toJSON (DoubleInUnionConstexpr x) = toJSON x

instance FromJSON UnionConstexpr where
    parseJSON xs@(Object _) = (fmap ConstexprInUnionConstexpr . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConstexpr . parseJSON) xs

instance ToJSON Constexpr where
    toJSON = \_ -> emptyObject

instance FromJSON Constexpr where
    parseJSON (Object _) = return Constexpr

instance ToJSON UnionConstructor where
    toJSON (ConstructorInUnionConstructor x) = toJSON x
    toJSON (DoubleInUnionConstructor x) = toJSON x

instance FromJSON UnionConstructor where
    parseJSON xs@(Object _) = (fmap ConstructorInUnionConstructor . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConstructor . parseJSON) xs

instance ToJSON Constructor where
    toJSON = \_ -> emptyObject

instance FromJSON Constructor where
    parseJSON (Object _) = return Constructor

instance ToJSON UnionContinue where
    toJSON (ContinueInUnionContinue x) = toJSON x
    toJSON (DoubleInUnionContinue x) = toJSON x

instance FromJSON UnionContinue where
    parseJSON xs@(Object _) = (fmap ContinueInUnionContinue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionContinue . parseJSON) xs

instance ToJSON Continue where
    toJSON = \_ -> emptyObject

instance FromJSON Continue where
    parseJSON (Object _) = return Continue

instance ToJSON UnionConvenience where
    toJSON (ConvenienceInUnionConvenience x) = toJSON x
    toJSON (DoubleInUnionConvenience x) = toJSON x

instance FromJSON UnionConvenience where
    parseJSON xs@(Object _) = (fmap ConvenienceInUnionConvenience . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConvenience . parseJSON) xs

instance ToJSON Convenience where
    toJSON = \_ -> emptyObject

instance FromJSON Convenience where
    parseJSON (Object _) = return Convenience

instance ToJSON UnionConvert where
    toJSON (ConvertInUnionConvert x) = toJSON x
    toJSON (DoubleInUnionConvert x) = toJSON x

instance FromJSON UnionConvert where
    parseJSON xs@(Object _) = (fmap ConvertInUnionConvert . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConvert . parseJSON) xs

instance ToJSON Convert where
    toJSON = \_ -> emptyObject

instance FromJSON Convert where
    parseJSON (Object _) = return Convert

instance ToJSON UnionConverter where
    toJSON (ConverterInUnionConverter x) = toJSON x
    toJSON (DoubleInUnionConverter x) = toJSON x

instance FromJSON UnionConverter where
    parseJSON xs@(Object _) = (fmap ConverterInUnionConverter . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConverter . parseJSON) xs

instance ToJSON Converter where
    toJSON = \_ -> emptyObject

instance FromJSON Converter where
    parseJSON (Object _) = return Converter

instance ToJSON UnionCultureInfo where
    toJSON (CultureInfoInUnionCultureInfo x) = toJSON x
    toJSON (DoubleInUnionCultureInfo x) = toJSON x

instance FromJSON UnionCultureInfo where
    parseJSON xs@(Object _) = (fmap CultureInfoInUnionCultureInfo . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCultureInfo . parseJSON) xs

instance ToJSON CultureInfo where
    toJSON = \_ -> emptyObject

instance FromJSON CultureInfo where
    parseJSON (Object _) = return CultureInfo

instance ToJSON UnionDate where
    toJSON (DateInUnionDate x) = toJSON x
    toJSON (DoubleInUnionDate x) = toJSON x

instance FromJSON UnionDate where
    parseJSON xs@(Object _) = (fmap DateInUnionDate . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDate . parseJSON) xs

instance ToJSON Date where
    toJSON = \_ -> emptyObject

instance FromJSON Date where
    parseJSON (Object _) = return Date

instance ToJSON UnionDateFormatter where
    toJSON (DateFormatterInUnionDateFormatter x) = toJSON x
    toJSON (DoubleInUnionDateFormatter x) = toJSON x

instance FromJSON UnionDateFormatter where
    parseJSON xs@(Object _) = (fmap DateFormatterInUnionDateFormatter . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateFormatter . parseJSON) xs

instance ToJSON DateFormatter where
    toJSON = \_ -> emptyObject

instance FromJSON DateFormatter where
    parseJSON (Object _) = return DateFormatter

instance ToJSON UnionDateOnly where
    toJSON (DateOnlyInUnionDateOnly x) = toJSON x
    toJSON (DoubleInUnionDateOnly x) = toJSON x

instance FromJSON UnionDateOnly where
    parseJSON xs@(Object _) = (fmap DateOnlyInUnionDateOnly . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateOnly . parseJSON) xs

instance ToJSON DateOnly where
    toJSON = \_ -> emptyObject

instance FromJSON DateOnly where
    parseJSON (Object _) = return DateOnly

instance ToJSON UnionDateOnlyConverter where
    toJSON (DateOnlyConverterInUnionDateOnlyConverter x) = toJSON x
    toJSON (DoubleInUnionDateOnlyConverter x) = toJSON x

instance FromJSON UnionDateOnlyConverter where
    parseJSON xs@(Object _) = (fmap DateOnlyConverterInUnionDateOnlyConverter . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateOnlyConverter . parseJSON) xs

instance ToJSON DateOnlyConverter where
    toJSON = \_ -> emptyObject

instance FromJSON DateOnlyConverter where
    parseJSON (Object _) = return DateOnlyConverter

instance ToJSON UnionDateParseHandling where
    toJSON (DateParseHandlingInUnionDateParseHandling x) = toJSON x
    toJSON (DoubleInUnionDateParseHandling x) = toJSON x

instance FromJSON UnionDateParseHandling where
    parseJSON xs@(Object _) = (fmap DateParseHandlingInUnionDateParseHandling . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateParseHandling . parseJSON) xs

instance ToJSON DateParseHandling where
    toJSON = \_ -> emptyObject

instance FromJSON DateParseHandling where
    parseJSON (Object _) = return DateParseHandling

instance ToJSON UnionDateTime where
    toJSON (DateTimeInUnionDateTime x) = toJSON x
    toJSON (DoubleInUnionDateTime x) = toJSON x

instance FromJSON UnionDateTime where
    parseJSON xs@(Object _) = (fmap DateTimeInUnionDateTime . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateTime . parseJSON) xs

instance ToJSON DateTime where
    toJSON = \_ -> emptyObject

instance FromJSON DateTime where
    parseJSON (Object _) = return DateTime

instance ToJSON UnionDateTimeStyles where
    toJSON (DateTimeStylesInUnionDateTimeStyles x) = toJSON x
    toJSON (DoubleInUnionDateTimeStyles x) = toJSON x

instance FromJSON UnionDateTimeStyles where
    parseJSON xs@(Object _) = (fmap DateTimeStylesInUnionDateTimeStyles . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDateTimeStyles . parseJSON) xs

instance ToJSON DateTimeStyles where
    toJSON = \_ -> emptyObject

instance FromJSON DateTimeStyles where
    parseJSON (Object _) = return DateTimeStyles

instance ToJSON UnionDebugger where
    toJSON (DebuggerInUnionDebugger x) = toJSON x
    toJSON (DoubleInUnionDebugger x) = toJSON x

instance FromJSON UnionDebugger where
    parseJSON xs@(Object _) = (fmap DebuggerInUnionDebugger . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDebugger . parseJSON) xs

instance ToJSON Debugger where
    toJSON = \_ -> emptyObject

instance FromJSON Debugger where
    parseJSON (Object _) = return Debugger

instance ToJSON UnionDecimal where
    toJSON (DecimalInUnionDecimal x) = toJSON x
    toJSON (DoubleInUnionDecimal x) = toJSON x

instance FromJSON UnionDecimal where
    parseJSON xs@(Object _) = (fmap DecimalInUnionDecimal . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDecimal . parseJSON) xs

instance ToJSON Decimal where
    toJSON = \_ -> emptyObject

instance FromJSON Decimal where
    parseJSON (Object _) = return Decimal

instance ToJSON UnionDeclare where
    toJSON (DeclareInUnionDeclare x) = toJSON x
    toJSON (DoubleInUnionDeclare x) = toJSON x

instance FromJSON UnionDeclare where
    parseJSON xs@(Object _) = (fmap DeclareInUnionDeclare . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDeclare . parseJSON) xs

instance ToJSON Declare where
    toJSON = \_ -> emptyObject

instance FromJSON Declare where
    parseJSON (Object _) = return Declare

instance ToJSON UnionDecltype where
    toJSON (DecltypeInUnionDecltype x) = toJSON x
    toJSON (DoubleInUnionDecltype x) = toJSON x

instance FromJSON UnionDecltype where
    parseJSON xs@(Object _) = (fmap DecltypeInUnionDecltype . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDecltype . parseJSON) xs

instance ToJSON Decltype where
    toJSON = \_ -> emptyObject

instance FromJSON Decltype where
    parseJSON (Object _) = return Decltype

instance ToJSON UnionDecodeString where
    toJSON (DecodeStringInUnionDecodeString x) = toJSON x
    toJSON (DoubleInUnionDecodeString x) = toJSON x

instance FromJSON UnionDecodeString where
    parseJSON xs@(Object _) = (fmap DecodeStringInUnionDecodeString . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDecodeString . parseJSON) xs

instance ToJSON DecodeString where
    toJSON = \_ -> emptyObject

instance FromJSON DecodeString where
    parseJSON (Object _) = return DecodeString

instance ToJSON UnionDecoder where
    toJSON (DecoderInUnionDecoder x) = toJSON x
    toJSON (DoubleInUnionDecoder x) = toJSON x

instance FromJSON UnionDecoder where
    parseJSON xs@(Object _) = (fmap DecoderInUnionDecoder . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDecoder . parseJSON) xs

instance ToJSON Decoder where
    toJSON = \_ -> emptyObject

instance FromJSON Decoder where
    parseJSON (Object _) = return Decoder

instance ToJSON UnionDecodingError where
    toJSON (DecodingErrorInUnionDecodingError x) = toJSON x
    toJSON (DoubleInUnionDecodingError x) = toJSON x

instance FromJSON UnionDecodingError where
    parseJSON xs@(Object _) = (fmap DecodingErrorInUnionDecodingError . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDecodingError . parseJSON) xs

instance ToJSON DecodingError where
    toJSON = \_ -> emptyObject

instance FromJSON DecodingError where
    parseJSON (Object _) = return DecodingError

instance ToJSON UnionDef where
    toJSON (DefInUnionDef x) = toJSON x
    toJSON (DoubleInUnionDef x) = toJSON x

instance FromJSON UnionDef where
    parseJSON xs@(Object _) = (fmap DefInUnionDef . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDef . parseJSON) xs

instance ToJSON Def where
    toJSON = \_ -> emptyObject

instance FromJSON Def where
    parseJSON (Object _) = return Def

instance ToJSON UnionDefer where
    toJSON (DeferInUnionDefer x) = toJSON x
    toJSON (DoubleInUnionDefer x) = toJSON x

instance FromJSON UnionDefer where
    parseJSON xs@(Object _) = (fmap DeferInUnionDefer . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDefer . parseJSON) xs

instance ToJSON Defer where
    toJSON = \_ -> emptyObject

instance FromJSON Defer where
    parseJSON (Object _) = return Defer

instance ToJSON UnionDeinit where
    toJSON (DeinitInUnionDeinit x) = toJSON x
    toJSON (DoubleInUnionDeinit x) = toJSON x

instance FromJSON UnionDeinit where
    parseJSON xs@(Object _) = (fmap DeinitInUnionDeinit . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDeinit . parseJSON) xs

instance ToJSON Deinit where
    toJSON = \_ -> emptyObject

instance FromJSON Deinit where
    parseJSON (Object _) = return Deinit

instance ToJSON UnionDel where
    toJSON (DelInUnionDel x) = toJSON x
    toJSON (DoubleInUnionDel x) = toJSON x

instance FromJSON UnionDel where
    parseJSON xs@(Object _) = (fmap DelInUnionDel . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDel . parseJSON) xs

instance ToJSON Del where
    toJSON = \_ -> emptyObject

instance FromJSON Del where
    parseJSON (Object _) = return Del

instance ToJSON UnionDelegate where
    toJSON (DelegateInUnionDelegate x) = toJSON x
    toJSON (DoubleInUnionDelegate x) = toJSON x

instance FromJSON UnionDelegate where
    parseJSON xs@(Object _) = (fmap DelegateInUnionDelegate . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDelegate . parseJSON) xs

instance ToJSON Delegate where
    toJSON = \_ -> emptyObject

instance FromJSON Delegate where
    parseJSON (Object _) = return Delegate

instance ToJSON UnionDelete where
    toJSON (DeleteInUnionDelete x) = toJSON x
    toJSON (DoubleInUnionDelete x) = toJSON x

instance FromJSON UnionDelete where
    parseJSON xs@(Object _) = (fmap DeleteInUnionDelete . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDelete . parseJSON) xs

instance ToJSON Delete where
    toJSON = \_ -> emptyObject

instance FromJSON Delete where
    parseJSON (Object _) = return Delete

instance ToJSON UnionDeserializationFeature where
    toJSON (DeserializationFeatureInUnionDeserializationFeature x) = toJSON x
    toJSON (DoubleInUnionDeserializationFeature x) = toJSON x

instance FromJSON UnionDeserializationFeature where
    parseJSON xs@(Object _) = (fmap DeserializationFeatureInUnionDeserializationFeature . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDeserializationFeature . parseJSON) xs

instance ToJSON DeserializationFeature where
    toJSON = \_ -> emptyObject

instance FromJSON DeserializationFeature where
    parseJSON (Object _) = return DeserializationFeature

instance ToJSON UnionDict where
    toJSON (DictInUnionDict x) = toJSON x
    toJSON (DoubleInUnionDict x) = toJSON x

instance FromJSON UnionDict where
    parseJSON xs@(Object _) = (fmap DictInUnionDict . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDict . parseJSON) xs

instance ToJSON Dict where
    toJSON = \_ -> emptyObject

instance FromJSON Dict where
    parseJSON (Object _) = return Dict

instance ToJSON UnionDictionary where
    toJSON (DictionaryInUnionDictionary x) = toJSON x
    toJSON (DoubleInUnionDictionary x) = toJSON x

instance FromJSON UnionDictionary where
    parseJSON xs@(Object _) = (fmap DictionaryInUnionDictionary . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDictionary . parseJSON) xs

instance ToJSON Dictionary where
    toJSON = \_ -> emptyObject

instance FromJSON Dictionary where
    parseJSON (Object _) = return Dictionary

instance ToJSON UnionDidSet where
    toJSON (DidSetInUnionDidSet x) = toJSON x
    toJSON (DoubleInUnionDidSet x) = toJSON x

instance FromJSON UnionDidSet where
    parseJSON xs@(Object _) = (fmap DidSetInUnionDidSet . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDidSet . parseJSON) xs

instance ToJSON DidSet where
    toJSON = \_ -> emptyObject

instance FromJSON DidSet where
    parseJSON (Object _) = return DidSet

instance ToJSON UnionDouble where
    toJSON (DoubleClassInUnionDouble x) = toJSON x
    toJSON (DoubleInUnionDouble x) = toJSON x

instance FromJSON UnionDouble where
    parseJSON xs@(Object _) = (fmap DoubleClassInUnionDouble . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDouble . parseJSON) xs

instance ToJSON DoubleClass where
    toJSON = \_ -> emptyObject

instance FromJSON DoubleClass where
    parseJSON (Object _) = return DoubleClass

instance ToJSON UnionDoubleNode where
    toJSON (DoubleInUnionDoubleNode x) = toJSON x
    toJSON (DoubleNodeInUnionDoubleNode x) = toJSON x

instance FromJSON UnionDoubleNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionDoubleNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DoubleNodeInUnionDoubleNode . parseJSON) xs

instance ToJSON DoubleNode where
    toJSON = \_ -> emptyObject

instance FromJSON DoubleNode where
    parseJSON (Object _) = return DoubleNode

instance ToJSON UnionDynamic where
    toJSON (DoubleInUnionDynamic x) = toJSON x
    toJSON (DynamicInUnionDynamic x) = toJSON x

instance FromJSON UnionDynamic where
    parseJSON xs@(Number _) = (fmap DoubleInUnionDynamic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DynamicInUnionDynamic . parseJSON) xs

instance ToJSON Dynamic where
    toJSON = \_ -> emptyObject

instance FromJSON Dynamic where
    parseJSON (Object _) = return Dynamic

instance ToJSON UnionDynamicCast where
    toJSON (DoubleInUnionDynamicCast x) = toJSON x
    toJSON (DynamicCastInUnionDynamicCast x) = toJSON x

instance FromJSON UnionDynamicCast where
    parseJSON xs@(Number _) = (fmap DoubleInUnionDynamicCast . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DynamicCastInUnionDynamicCast . parseJSON) xs

instance ToJSON DynamicCast where
    toJSON = \_ -> emptyObject

instance FromJSON DynamicCast where
    parseJSON (Object _) = return DynamicCast

instance ToJSON UnionElif where
    toJSON (DoubleInUnionElif x) = toJSON x
    toJSON (ElifInUnionElif x) = toJSON x

instance FromJSON UnionElif where
    parseJSON xs@(Number _) = (fmap DoubleInUnionElif . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ElifInUnionElif . parseJSON) xs

instance ToJSON Elif where
    toJSON = \_ -> emptyObject

instance FromJSON Elif where
    parseJSON (Object _) = return Elif

instance ToJSON UnionUnion where
    toJSON (DoubleInUnionUnion x) = toJSON x
    toJSON (EmptyInUnionUnion x) = toJSON x

instance FromJSON UnionUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EmptyInUnionUnion . parseJSON) xs

instance ToJSON Empty where
    toJSON = \_ -> emptyObject

instance FromJSON Empty where
    parseJSON (Object _) = return Empty

instance ToJSON UnionEncodeQuickType where
    toJSON (DoubleInUnionEncodeQuickType x) = toJSON x
    toJSON (EncodeQuickTypeInUnionEncodeQuickType x) = toJSON x

instance FromJSON UnionEncodeQuickType where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEncodeQuickType . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EncodeQuickTypeInUnionEncodeQuickType . parseJSON) xs

instance ToJSON EncodeQuickType where
    toJSON = \_ -> emptyObject

instance FromJSON EncodeQuickType where
    parseJSON (Object _) = return EncodeQuickType

instance ToJSON UnionEncoder where
    toJSON (DoubleInUnionEncoder x) = toJSON x
    toJSON (EncoderInUnionEncoder x) = toJSON x

instance FromJSON UnionEncoder where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEncoder . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EncoderInUnionEncoder . parseJSON) xs

instance ToJSON Encoder where
    toJSON = \_ -> emptyObject

instance FromJSON Encoder where
    parseJSON (Object _) = return Encoder

instance ToJSON UnionEnum where
    toJSON (DoubleInUnionEnum x) = toJSON x
    toJSON (EnumClassInUnionEnum x) = toJSON x

instance FromJSON UnionEnum where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEnum . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EnumClassInUnionEnum . parseJSON) xs

instance ToJSON EnumClass where
    toJSON = \_ -> emptyObject

instance FromJSON EnumClass where
    parseJSON (Object _) = return EnumClass

instance ToJSON UnionEnumValues where
    toJSON (DoubleInUnionEnumValues x) = toJSON x
    toJSON (EnumValuesInUnionEnumValues x) = toJSON x

instance FromJSON UnionEnumValues where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEnumValues . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EnumValuesInUnionEnumValues . parseJSON) xs

instance ToJSON EnumValues where
    toJSON = \_ -> emptyObject

instance FromJSON EnumValues where
    parseJSON (Object _) = return EnumValues

instance ToJSON UnionEqualityContract where
    toJSON (DoubleInUnionEqualityContract x) = toJSON x
    toJSON (EqualityContractInUnionEqualityContract x) = toJSON x

instance FromJSON UnionEqualityContract where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEqualityContract . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EqualityContractInUnionEqualityContract . parseJSON) xs

instance ToJSON EqualityContract where
    toJSON = \_ -> emptyObject

instance FromJSON EqualityContract where
    parseJSON (Object _) = return EqualityContract

instance ToJSON UnionEquatable where
    toJSON (DoubleInUnionEquatable x) = toJSON x
    toJSON (EquatableInUnionEquatable x) = toJSON x

instance FromJSON UnionEquatable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEquatable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EquatableInUnionEquatable . parseJSON) xs

instance ToJSON Equatable where
    toJSON = \_ -> emptyObject

instance FromJSON Equatable where
    parseJSON (Object _) = return Equatable

instance ToJSON UnionEvent where
    toJSON (DoubleInUnionEvent x) = toJSON x
    toJSON (EventInUnionEvent x) = toJSON x

instance FromJSON UnionEvent where
    parseJSON xs@(Number _) = (fmap DoubleInUnionEvent . parseJSON) xs
    parseJSON xs@(Object _) = (fmap EventInUnionEvent . parseJSON) xs

instance ToJSON Event where
    toJSON = \_ -> emptyObject

instance FromJSON Event where
    parseJSON (Object _) = return Event

instance ToJSON UnionExcept where
    toJSON (DoubleInUnionExcept x) = toJSON x
    toJSON (ExceptInUnionExcept x) = toJSON x

instance FromJSON UnionExcept where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExcept . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExceptInUnionExcept . parseJSON) xs

instance ToJSON Except where
    toJSON = \_ -> emptyObject

instance FromJSON Except where
    parseJSON (Object _) = return Except

instance ToJSON UnionException where
    toJSON (DoubleInUnionException x) = toJSON x
    toJSON (ExceptionInUnionException x) = toJSON x

instance FromJSON UnionException where
    parseJSON xs@(Number _) = (fmap DoubleInUnionException . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExceptionInUnionException . parseJSON) xs

instance ToJSON Exception where
    toJSON = \_ -> emptyObject

instance FromJSON Exception where
    parseJSON (Object _) = return Exception

instance ToJSON UnionExplicit where
    toJSON (DoubleInUnionExplicit x) = toJSON x
    toJSON (ExplicitInUnionExplicit x) = toJSON x

instance FromJSON UnionExplicit where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExplicit . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExplicitInUnionExplicit . parseJSON) xs

instance ToJSON Explicit where
    toJSON = \_ -> emptyObject

instance FromJSON Explicit where
    parseJSON (Object _) = return Explicit

instance ToJSON UnionExport where
    toJSON (DoubleInUnionExport x) = toJSON x
    toJSON (ExportInUnionExport x) = toJSON x

instance FromJSON UnionExport where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExport . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExportInUnionExport . parseJSON) xs

instance ToJSON Export where
    toJSON = \_ -> emptyObject

instance FromJSON Export where
    parseJSON (Object _) = return Export

instance ToJSON UnionExposing where
    toJSON (DoubleInUnionExposing x) = toJSON x
    toJSON (ExposingInUnionExposing x) = toJSON x

instance FromJSON UnionExposing where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExposing . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExposingInUnionExposing . parseJSON) xs

instance ToJSON Exposing where
    toJSON = \_ -> emptyObject

instance FromJSON Exposing where
    parseJSON (Object _) = return Exposing

instance ToJSON UnionExtends where
    toJSON (DoubleInUnionExtends x) = toJSON x
    toJSON (ExtendsInUnionExtends x) = toJSON x

instance FromJSON UnionExtends where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExtends . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExtendsInUnionExtends . parseJSON) xs

instance ToJSON Extends where
    toJSON = \_ -> emptyObject

instance FromJSON Extends where
    parseJSON (Object _) = return Extends

instance ToJSON UnionExtension where
    toJSON (DoubleInUnionExtension x) = toJSON x
    toJSON (ExtensionInUnionExtension x) = toJSON x

instance FromJSON UnionExtension where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExtension . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExtensionInUnionExtension . parseJSON) xs

instance ToJSON Extension where
    toJSON = \_ -> emptyObject

instance FromJSON Extension where
    parseJSON (Object _) = return Extension

instance ToJSON UnionExtern where
    toJSON (DoubleInUnionExtern x) = toJSON x
    toJSON (ExternInUnionExtern x) = toJSON x

instance FromJSON UnionExtern where
    parseJSON xs@(Number _) = (fmap DoubleInUnionExtern . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ExternInUnionExtern . parseJSON) xs

instance ToJSON Extern where
    toJSON = \_ -> emptyObject

instance FromJSON Extern where
    parseJSON (Object _) = return Extern

instance ToJSON UnionFallthrough where
    toJSON (DoubleInUnionFallthrough x) = toJSON x
    toJSON (FallthroughInUnionFallthrough x) = toJSON x

instance FromJSON UnionFallthrough where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFallthrough . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FallthroughInUnionFallthrough . parseJSON) xs

instance ToJSON Fallthrough where
    toJSON = \_ -> emptyObject

instance FromJSON Fallthrough where
    parseJSON (Object _) = return Fallthrough

instance ToJSON UnionFalse where
    toJSON (DoubleInUnionFalse x) = toJSON x
    toJSON (FalseClassInUnionFalse x) = toJSON x

instance FromJSON UnionFalse where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFalse . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FalseClassInUnionFalse . parseJSON) xs

instance ToJSON FalseClass where
    toJSON = \_ -> emptyObject

instance FromJSON FalseClass where
    parseJSON (Object _) = return FalseClass

instance ToJSON UnionFileprivate where
    toJSON (DoubleInUnionFileprivate x) = toJSON x
    toJSON (FileprivateInUnionFileprivate x) = toJSON x

instance FromJSON UnionFileprivate where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFileprivate . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FileprivateInUnionFileprivate . parseJSON) xs

instance ToJSON Fileprivate where
    toJSON = \_ -> emptyObject

instance FromJSON Fileprivate where
    parseJSON (Object _) = return Fileprivate

instance ToJSON UnionFinal where
    toJSON (DoubleInUnionFinal x) = toJSON x
    toJSON (FinalInUnionFinal x) = toJSON x

instance FromJSON UnionFinal where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFinal . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FinalInUnionFinal . parseJSON) xs

instance ToJSON Final where
    toJSON = \_ -> emptyObject

instance FromJSON Final where
    parseJSON (Object _) = return Final

instance ToJSON UnionFinally where
    toJSON (DoubleInUnionFinally x) = toJSON x
    toJSON (FinallyInUnionFinally x) = toJSON x

instance FromJSON UnionFinally where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFinally . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FinallyInUnionFinally . parseJSON) xs

instance ToJSON Finally where
    toJSON = \_ -> emptyObject

instance FromJSON Finally where
    parseJSON (Object _) = return Finally

instance ToJSON UnionFixed where
    toJSON (DoubleInUnionFixed x) = toJSON x
    toJSON (FixedInUnionFixed x) = toJSON x

instance FromJSON UnionFixed where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFixed . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FixedInUnionFixed . parseJSON) xs

instance ToJSON Fixed where
    toJSON = \_ -> emptyObject

instance FromJSON Fixed where
    parseJSON (Object _) = return Fixed

instance ToJSON UnionFloat where
    toJSON (DoubleInUnionFloat x) = toJSON x
    toJSON (FloatClassInUnionFloat x) = toJSON x

instance FromJSON UnionFloat where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFloat . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FloatClassInUnionFloat . parseJSON) xs

instance ToJSON FloatClass where
    toJSON = \_ -> emptyObject

instance FromJSON FloatClass where
    parseJSON (Object _) = return FloatClass

instance ToJSON UnionFor where
    toJSON (DoubleInUnionFor x) = toJSON x
    toJSON (ForInUnionFor x) = toJSON x

instance FromJSON UnionFor where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFor . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ForInUnionFor . parseJSON) xs

instance ToJSON For where
    toJSON = \_ -> emptyObject

instance FromJSON For where
    parseJSON (Object _) = return For

instance ToJSON UnionForeach where
    toJSON (DoubleInUnionForeach x) = toJSON x
    toJSON (ForeachInUnionForeach x) = toJSON x

instance FromJSON UnionForeach where
    parseJSON xs@(Number _) = (fmap DoubleInUnionForeach . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ForeachInUnionForeach . parseJSON) xs

instance ToJSON Foreach where
    toJSON = \_ -> emptyObject

instance FromJSON Foreach where
    parseJSON (Object _) = return Foreach

instance ToJSON UnionFormatException where
    toJSON (DoubleInUnionFormatException x) = toJSON x
    toJSON (FormatExceptionInUnionFormatException x) = toJSON x

instance FromJSON UnionFormatException where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFormatException . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FormatExceptionInUnionFormatException . parseJSON) xs

instance ToJSON FormatException where
    toJSON = \_ -> emptyObject

instance FromJSON FormatException where
    parseJSON (Object _) = return FormatException

instance ToJSON UnionFriend where
    toJSON (DoubleInUnionFriend x) = toJSON x
    toJSON (FriendInUnionFriend x) = toJSON x

instance FromJSON UnionFriend where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFriend . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FriendInUnionFriend . parseJSON) xs

instance ToJSON Friend where
    toJSON = \_ -> emptyObject

instance FromJSON Friend where
    parseJSON (Object _) = return Friend

instance ToJSON UnionFrom where
    toJSON (DoubleInUnionFrom x) = toJSON x
    toJSON (FromInUnionFrom x) = toJSON x

instance FromJSON UnionFrom where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFrom . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FromInUnionFrom . parseJSON) xs

instance ToJSON From where
    toJSON = \_ -> emptyObject

instance FromJSON From where
    parseJSON (Object _) = return From

instance ToJSON UnionFromDict where
    toJSON (DoubleInUnionFromDict x) = toJSON x
    toJSON (FromDictInUnionFromDict x) = toJSON x

instance FromJSON UnionFromDict where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFromDict . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FromDictInUnionFromDict . parseJSON) xs

instance ToJSON FromDict where
    toJSON = \_ -> emptyObject

instance FromJSON FromDict where
    parseJSON (Object _) = return FromDict

instance ToJSON UnionFromJSON where
    toJSON (DoubleInUnionFromJSON x) = toJSON x
    toJSON (FromJSONClassInUnionFromJSON x) = toJSON x

instance FromJSON UnionFromJSON where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFromJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FromJSONClassInUnionFromJSON . parseJSON) xs

instance ToJSON FromJSONClass where
    toJSON = \_ -> emptyObject

instance FromJSON FromJSONClass where
    parseJSON (Object _) = return FromJSONClass

instance ToJSON UnionFunc where
    toJSON (DoubleInUnionFunc x) = toJSON x
    toJSON (FuncInUnionFunc x) = toJSON x

instance FromJSON UnionFunc where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFunc . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FuncInUnionFunc . parseJSON) xs

instance ToJSON Func where
    toJSON = \_ -> emptyObject

instance FromJSON Func where
    parseJSON (Object _) = return Func

instance ToJSON UnionFunction where
    toJSON (DoubleInUnionFunction x) = toJSON x
    toJSON (FunctionInUnionFunction x) = toJSON x

instance FromJSON UnionFunction where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFunction . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FunctionInUnionFunction . parseJSON) xs

instance ToJSON Function where
    toJSON = \_ -> emptyObject

instance FromJSON Function where
    parseJSON (Object _) = return Function

instance ToJSON UnionGet where
    toJSON (DoubleInUnionGet x) = toJSON x
    toJSON (GetInUnionGet x) = toJSON x

instance FromJSON UnionGet where
    parseJSON xs@(Number _) = (fmap DoubleInUnionGet . parseJSON) xs
    parseJSON xs@(Object _) = (fmap GetInUnionGet . parseJSON) xs

instance ToJSON Get where
    toJSON = \_ -> emptyObject

instance FromJSON Get where
    parseJSON (Object _) = return Get

instance ToJSON UnionGlobal where
    toJSON (DoubleInUnionGlobal x) = toJSON x
    toJSON (GlobalInUnionGlobal x) = toJSON x

instance FromJSON UnionGlobal where
    parseJSON xs@(Number _) = (fmap DoubleInUnionGlobal . parseJSON) xs
    parseJSON xs@(Object _) = (fmap GlobalInUnionGlobal . parseJSON) xs

instance ToJSON Global where
    toJSON = \_ -> emptyObject

instance FromJSON Global where
    parseJSON (Object _) = return Global

instance ToJSON UnionGo where
    toJSON (DoubleInUnionGo x) = toJSON x
    toJSON (GoInUnionGo x) = toJSON x

instance FromJSON UnionGo where
    parseJSON xs@(Number _) = (fmap DoubleInUnionGo . parseJSON) xs
    parseJSON xs@(Object _) = (fmap GoInUnionGo . parseJSON) xs

instance ToJSON Go where
    toJSON = \_ -> emptyObject

instance FromJSON Go where
    parseJSON (Object _) = return Go

instance ToJSON UnionGoto where
    toJSON (DoubleInUnionGoto x) = toJSON x
    toJSON (GotoInUnionGoto x) = toJSON x

instance FromJSON UnionGoto where
    parseJSON xs@(Number _) = (fmap DoubleInUnionGoto . parseJSON) xs
    parseJSON xs@(Object _) = (fmap GotoInUnionGoto . parseJSON) xs

instance ToJSON Goto where
    toJSON = \_ -> emptyObject

instance FromJSON Goto where
    parseJSON (Object _) = return Goto

instance ToJSON UnionGuard where
    toJSON (DoubleInUnionGuard x) = toJSON x
    toJSON (GuardInUnionGuard x) = toJSON x

instance FromJSON UnionGuard where
    parseJSON xs@(Number _) = (fmap DoubleInUnionGuard . parseJSON) xs
    parseJSON xs@(Object _) = (fmap GuardInUnionGuard . parseJSON) xs

instance ToJSON Guard where
    toJSON = \_ -> emptyObject

instance FromJSON Guard where
    parseJSON (Object _) = return Guard

instance ToJSON UnionHasOwnProperty where
    toJSON (DoubleInUnionHasOwnProperty x) = toJSON x
    toJSON (HasOwnPropertyInUnionHasOwnProperty x) = toJSON x

instance FromJSON UnionHasOwnProperty where
    parseJSON xs@(Number _) = (fmap DoubleInUnionHasOwnProperty . parseJSON) xs
    parseJSON xs@(Object _) = (fmap HasOwnPropertyInUnionHasOwnProperty . parseJSON) xs

instance ToJSON HasOwnProperty where
    toJSON = \_ -> emptyObject

instance FromJSON HasOwnProperty where
    parseJSON (Object _) = return HasOwnProperty

instance ToJSON UnionHashCode where
    toJSON (DoubleInUnionHashCode x) = toJSON x
    toJSON (HashCodeInUnionHashCode x) = toJSON x

instance FromJSON UnionHashCode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionHashCode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap HashCodeInUnionHashCode . parseJSON) xs

instance ToJSON HashCode where
    toJSON = \_ -> emptyObject

instance FromJSON HashCode where
    parseJSON (Object _) = return HashCode

instance ToJSON UnionHashable where
    toJSON (DoubleInUnionHashable x) = toJSON x
    toJSON (HashableInUnionHashable x) = toJSON x

instance FromJSON UnionHashable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionHashable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap HashableInUnionHashable . parseJSON) xs

instance ToJSON Hashable where
    toJSON = \_ -> emptyObject

instance FromJSON Hashable where
    parseJSON (Object _) = return Hashable

instance ToJSON UnionHasher where
    toJSON (DoubleInUnionHasher x) = toJSON x
    toJSON (HasherInUnionHasher x) = toJSON x

instance FromJSON UnionHasher where
    parseJSON xs@(Number _) = (fmap DoubleInUnionHasher . parseJSON) xs
    parseJSON xs@(Object _) = (fmap HasherInUnionHasher . parseJSON) xs

instance ToJSON Hasher where
    toJSON = \_ -> emptyObject

instance FromJSON Hasher where
    parseJSON (Object _) = return Hasher

instance ToJSON UnionImaginery where
    toJSON (DoubleInUnionImaginery x) = toJSON x
    toJSON (ImagineryInUnionImaginery x) = toJSON x

instance FromJSON UnionImaginery where
    parseJSON xs@(Number _) = (fmap DoubleInUnionImaginery . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ImagineryInUnionImaginery . parseJSON) xs

instance ToJSON Imaginery where
    toJSON = \_ -> emptyObject

instance FromJSON Imaginery where
    parseJSON (Object _) = return Imaginery

instance ToJSON UnionIMP where
    toJSON (DoubleInUnionIMP x) = toJSON x
    toJSON (ImpInUnionIMP x) = toJSON x

instance FromJSON UnionIMP where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIMP . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ImpInUnionIMP . parseJSON) xs

instance ToJSON Imp where
    toJSON = \_ -> emptyObject

instance FromJSON Imp where
    parseJSON (Object _) = return Imp

instance ToJSON UnionImplements where
    toJSON (DoubleInUnionImplements x) = toJSON x
    toJSON (ImplementsInUnionImplements x) = toJSON x

instance FromJSON UnionImplements where
    parseJSON xs@(Number _) = (fmap DoubleInUnionImplements . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ImplementsInUnionImplements . parseJSON) xs

instance ToJSON Implements where
    toJSON = \_ -> emptyObject

instance FromJSON Implements where
    parseJSON (Object _) = return Implements

instance ToJSON UnionImplicit where
    toJSON (DoubleInUnionImplicit x) = toJSON x
    toJSON (ImplicitInUnionImplicit x) = toJSON x

instance FromJSON UnionImplicit where
    parseJSON xs@(Number _) = (fmap DoubleInUnionImplicit . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ImplicitInUnionImplicit . parseJSON) xs

instance ToJSON Implicit where
    toJSON = \_ -> emptyObject

instance FromJSON Implicit where
    parseJSON (Object _) = return Implicit

instance ToJSON UnionIndirect where
    toJSON (DoubleInUnionIndirect x) = toJSON x
    toJSON (IndirectInUnionIndirect x) = toJSON x

instance FromJSON UnionIndirect where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIndirect . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IndirectInUnionIndirect . parseJSON) xs

instance ToJSON Indirect where
    toJSON = \_ -> emptyObject

instance FromJSON Indirect where
    parseJSON (Object _) = return Indirect

instance ToJSON UnionInit where
    toJSON (DoubleInUnionInit x) = toJSON x
    toJSON (InitInUnionInit x) = toJSON x

instance FromJSON UnionInit where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInit . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InitInUnionInit . parseJSON) xs

instance ToJSON Init where
    toJSON = \_ -> emptyObject

instance FromJSON Init where
    parseJSON (Object _) = return Init

instance ToJSON UnionInline where
    toJSON (DoubleInUnionInline x) = toJSON x
    toJSON (InlineInUnionInline x) = toJSON x

instance FromJSON UnionInline where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInline . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InlineInUnionInline . parseJSON) xs

instance ToJSON Inline where
    toJSON = \_ -> emptyObject

instance FromJSON Inline where
    parseJSON (Object _) = return Inline

instance ToJSON UnionInout where
    toJSON (DoubleInUnionInout x) = toJSON x
    toJSON (InoutInUnionInout x) = toJSON x

instance FromJSON UnionInout where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInout . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InoutInUnionInout . parseJSON) xs

instance ToJSON Inout where
    toJSON = \_ -> emptyObject

instance FromJSON Inout where
    parseJSON (Object _) = return Inout

instance ToJSON UnionInstanceof where
    toJSON (DoubleInUnionInstanceof x) = toJSON x
    toJSON (InstanceofInUnionInstanceof x) = toJSON x

instance FromJSON UnionInstanceof where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInstanceof . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InstanceofInUnionInstanceof . parseJSON) xs

instance ToJSON Instanceof where
    toJSON = \_ -> emptyObject

instance FromJSON Instanceof where
    parseJSON (Object _) = return Instanceof

instance ToJSON UnionInt where
    toJSON (DoubleInUnionInt x) = toJSON x
    toJSON (IntClassInUnionInt x) = toJSON x

instance FromJSON UnionInt where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInt . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntClassInUnionInt . parseJSON) xs

instance ToJSON IntClass where
    toJSON = \_ -> emptyObject

instance FromJSON IntClass where
    parseJSON (Object _) = return IntClass

instance ToJSON UnionIntNode where
    toJSON (DoubleInUnionIntNode x) = toJSON x
    toJSON (IntNodeInUnionIntNode x) = toJSON x

instance FromJSON UnionIntNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIntNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntNodeInUnionIntNode . parseJSON) xs

instance ToJSON IntNode where
    toJSON = \_ -> emptyObject

instance FromJSON IntNode where
    parseJSON (Object _) = return IntNode

instance ToJSON UnionInterface where
    toJSON (DoubleInUnionInterface x) = toJSON x
    toJSON (InterfaceInUnionInterface x) = toJSON x

instance FromJSON UnionInterface where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInterface . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InterfaceInUnionInterface . parseJSON) xs

instance ToJSON Interface where
    toJSON = \_ -> emptyObject

instance FromJSON Interface where
    parseJSON (Object _) = return Interface

instance ToJSON UnionInternal where
    toJSON (DoubleInUnionInternal x) = toJSON x
    toJSON (InternalInUnionInternal x) = toJSON x

instance FromJSON UnionInternal where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInternal . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InternalInUnionInternal . parseJSON) xs

instance ToJSON Internal where
    toJSON = \_ -> emptyObject

instance FromJSON Internal where
    parseJSON (Object _) = return Internal

instance ToJSON UnionIs where
    toJSON (DoubleInUnionIs x) = toJSON x
    toJSON (IsInUnionIs x) = toJSON x

instance FromJSON UnionIs where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIs . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IsInUnionIs . parseJSON) xs

instance ToJSON Is where
    toJSON = \_ -> emptyObject

instance FromJSON Is where
    parseJSON (Object _) = return Is

instance ToJSON UnionISODateTimeOffsetConverter where
    toJSON (DoubleInUnionISODateTimeOffsetConverter x) = toJSON x
    toJSON (ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter x) = toJSON x

instance FromJSON UnionISODateTimeOffsetConverter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionISODateTimeOffsetConverter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ISODateTimeOffsetConverterInUnionISODateTimeOffsetConverter . parseJSON) xs

instance ToJSON ISODateTimeOffsetConverter where
    toJSON = \_ -> emptyObject

instance FromJSON ISODateTimeOffsetConverter where
    parseJSON (Object _) = return ISODateTimeOffsetConverter

instance ToJSON UnionIterable where
    toJSON (DoubleInUnionIterable x) = toJSON x
    toJSON (IterableInUnionIterable x) = toJSON x

instance FromJSON UnionIterable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIterable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IterableInUnionIterable . parseJSON) xs

instance ToJSON Iterable where
    toJSON = \_ -> emptyObject

instance FromJSON Iterable where
    parseJSON (Object _) = return Iterable

instance ToJSON UnionJdec where
    toJSON (DoubleInUnionJdec x) = toJSON x
    toJSON (JdecInUnionJdec x) = toJSON x

instance FromJSON UnionJdec where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJdec . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JdecInUnionJdec . parseJSON) xs

instance ToJSON Jdec where
    toJSON = \_ -> emptyObject

instance FromJSON Jdec where
    parseJSON (Object _) = return Jdec

instance ToJSON UnionJenc where
    toJSON (DoubleInUnionJenc x) = toJSON x
    toJSON (JencInUnionJenc x) = toJSON x

instance FromJSON UnionJenc where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJenc . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JencInUnionJenc . parseJSON) xs

instance ToJSON Jenc where
    toJSON = \_ -> emptyObject

instance FromJSON Jenc where
    parseJSON (Object _) = return Jenc

instance ToJSON UnionJpipe where
    toJSON (DoubleInUnionJpipe x) = toJSON x
    toJSON (JpipeInUnionJpipe x) = toJSON x

instance FromJSON UnionJpipe where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJpipe . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JpipeInUnionJpipe . parseJSON) xs

instance ToJSON Jpipe where
    toJSON = \_ -> emptyObject

instance FromJSON Jpipe where
    parseJSON (Object _) = return Jpipe

instance ToJSON UnionJSON where
    toJSON (DoubleInUnionJSON x) = toJSON x
    toJSON (JSONInUnionJSON x) = toJSON x

instance FromJSON UnionJSON where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONInUnionJSON . parseJSON) xs

instance ToJSON JSON where
    toJSON = \_ -> emptyObject

instance FromJSON JSON where
    parseJSON (Object _) = return JSON

instance ToJSON UnionJSONAny where
    toJSON (DoubleInUnionJSONAny x) = toJSON x
    toJSON (JSONAnyInUnionJSONAny x) = toJSON x

instance FromJSON UnionJSONAny where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONAny . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONAnyInUnionJSONAny . parseJSON) xs

instance ToJSON JSONAny where
    toJSON = \_ -> emptyObject

instance FromJSON JSONAny where
    parseJSON (Object _) = return JSONAny

instance ToJSON UnionJSONCodingKey where
    toJSON (DoubleInUnionJSONCodingKey x) = toJSON x
    toJSON (JSONCodingKeyInUnionJSONCodingKey x) = toJSON x

instance FromJSON UnionJSONCodingKey where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONCodingKey . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONCodingKeyInUnionJSONCodingKey . parseJSON) xs

instance ToJSON JSONCodingKey where
    toJSON = \_ -> emptyObject

instance FromJSON JSONCodingKey where
    parseJSON (Object _) = return JSONCodingKey

instance ToJSON UnionJSONConverter where
    toJSON (DoubleInUnionJSONConverter x) = toJSON x
    toJSON (JSONConverterInUnionJSONConverter x) = toJSON x

instance FromJSON UnionJSONConverter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONConverter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONConverterInUnionJSONConverter . parseJSON) xs

instance ToJSON JSONConverter where
    toJSON = \_ -> emptyObject

instance FromJSON JSONConverter where
    parseJSON (Object _) = return JSONConverter

instance ToJSON UnionJSONDecoder where
    toJSON (DoubleInUnionJSONDecoder x) = toJSON x
    toJSON (JSONDecoderInUnionJSONDecoder x) = toJSON x

instance FromJSON UnionJSONDecoder where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONDecoder . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONDecoderInUnionJSONDecoder . parseJSON) xs

instance ToJSON JSONDecoder where
    toJSON = \_ -> emptyObject

instance FromJSON JSONDecoder where
    parseJSON (Object _) = return JSONDecoder

instance ToJSON UnionJSONEncoder where
    toJSON (DoubleInUnionJSONEncoder x) = toJSON x
    toJSON (JSONEncoderInUnionJSONEncoder x) = toJSON x

instance FromJSON UnionJSONEncoder where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONEncoder . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONEncoderInUnionJSONEncoder . parseJSON) xs

instance ToJSON JSONEncoder where
    toJSON = \_ -> emptyObject

instance FromJSON JSONEncoder where
    parseJSON (Object _) = return JSONEncoder

instance ToJSON UnionJSONException where
    toJSON (DoubleInUnionJSONException x) = toJSON x
    toJSON (JSONExceptionInUnionJSONException x) = toJSON x

instance FromJSON UnionJSONException where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONException . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONExceptionInUnionJSONException . parseJSON) xs

instance ToJSON JSONException where
    toJSON = \_ -> emptyObject

instance FromJSON JSONException where
    parseJSON (Object _) = return JSONException

instance ToJSON UnionJSONGenerator where
    toJSON (DoubleInUnionJSONGenerator x) = toJSON x
    toJSON (JSONGeneratorInUnionJSONGenerator x) = toJSON x

instance FromJSON UnionJSONGenerator where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONGenerator . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONGeneratorInUnionJSONGenerator . parseJSON) xs

instance ToJSON JSONGenerator where
    toJSON = \_ -> emptyObject

instance FromJSON JSONGenerator where
    parseJSON (Object _) = return JSONGenerator

instance ToJSON UnionJSONNode where
    toJSON (DoubleInUnionJSONNode x) = toJSON x
    toJSON (JSONNodeInUnionJSONNode x) = toJSON x

instance FromJSON UnionJSONNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONNodeInUnionJSONNode . parseJSON) xs

instance ToJSON JSONNode where
    toJSON = \_ -> emptyObject

instance FromJSON JSONNode where
    parseJSON (Object _) = return JSONNode

instance ToJSON UnionJSONNull where
    toJSON (DoubleInUnionJSONNull x) = toJSON x
    toJSON (JSONNullInUnionJSONNull x) = toJSON x

instance FromJSON UnionJSONNull where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONNull . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONNullInUnionJSONNull . parseJSON) xs

instance ToJSON JSONNull where
    toJSON = \_ -> emptyObject

instance FromJSON JSONNull where
    parseJSON (Object _) = return JSONNull

instance ToJSON UnionJSONParser where
    toJSON (DoubleInUnionJSONParser x) = toJSON x
    toJSON (JSONParserInUnionJSONParser x) = toJSON x

instance FromJSON UnionJSONParser where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONParser . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONParserInUnionJSONParser . parseJSON) xs

instance ToJSON JSONParser where
    toJSON = \_ -> emptyObject

instance FromJSON JSONParser where
    parseJSON (Object _) = return JSONParser

instance ToJSON UnionJSONReader where
    toJSON (DoubleInUnionJSONReader x) = toJSON x
    toJSON (JSONReaderInUnionJSONReader x) = toJSON x

instance FromJSON UnionJSONReader where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONReader . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONReaderInUnionJSONReader . parseJSON) xs

instance ToJSON JSONReader where
    toJSON = \_ -> emptyObject

instance FromJSON JSONReader where
    parseJSON (Object _) = return JSONReader

instance ToJSON UnionJSONSerializer where
    toJSON (DoubleInUnionJSONSerializer x) = toJSON x
    toJSON (JSONSerializerInUnionJSONSerializer x) = toJSON x

instance FromJSON UnionJSONSerializer where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONSerializer . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONSerializerInUnionJSONSerializer . parseJSON) xs

instance ToJSON JSONSerializer where
    toJSON = \_ -> emptyObject

instance FromJSON JSONSerializer where
    parseJSON (Object _) = return JSONSerializer

instance ToJSON UnionJSONToken where
    toJSON (DoubleInUnionJSONToken x) = toJSON x
    toJSON (JSONTokenInUnionJSONToken x) = toJSON x

instance FromJSON UnionJSONToken where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONToken . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONTokenInUnionJSONToken . parseJSON) xs

instance ToJSON JSONToken where
    toJSON = \_ -> emptyObject

instance FromJSON JSONToken where
    parseJSON (Object _) = return JSONToken

instance ToJSON UnionJSONTokenType where
    toJSON (DoubleInUnionJSONTokenType x) = toJSON x
    toJSON (JSONTokenTypeInUnionJSONTokenType x) = toJSON x

instance FromJSON UnionJSONTokenType where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONTokenType . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONTokenTypeInUnionJSONTokenType . parseJSON) xs

instance ToJSON JSONTokenType where
    toJSON = \_ -> emptyObject

instance FromJSON JSONTokenType where
    parseJSON (Object _) = return JSONTokenType

instance ToJSON UnionJSONWriter where
    toJSON (DoubleInUnionJSONWriter x) = toJSON x
    toJSON (JSONWriterInUnionJSONWriter x) = toJSON x

instance FromJSON UnionJSONWriter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionJSONWriter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONWriterInUnionJSONWriter . parseJSON) xs

instance ToJSON JSONWriter where
    toJSON = \_ -> emptyObject

instance FromJSON JSONWriter where
    parseJSON (Object _) = return JSONWriter

instance ToJSON UnionKSerializer where
    toJSON (DoubleInUnionKSerializer x) = toJSON x
    toJSON (KSerializerInUnionKSerializer x) = toJSON x

instance FromJSON UnionKSerializer where
    parseJSON xs@(Number _) = (fmap DoubleInUnionKSerializer . parseJSON) xs
    parseJSON xs@(Object _) = (fmap KSerializerInUnionKSerializer . parseJSON) xs

instance ToJSON KSerializer where
    toJSON = \_ -> emptyObject

instance FromJSON KSerializer where
    parseJSON (Object _) = return KSerializer

instance ToJSON UnionLambda where
    toJSON (DoubleInUnionLambda x) = toJSON x
    toJSON (LambdaInUnionLambda x) = toJSON x

instance FromJSON UnionLambda where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLambda . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LambdaInUnionLambda . parseJSON) xs

instance ToJSON Lambda where
    toJSON = \_ -> emptyObject

instance FromJSON Lambda where
    parseJSON (Object _) = return Lambda

instance ToJSON UnionLazy where
    toJSON (DoubleInUnionLazy x) = toJSON x
    toJSON (LazyInUnionLazy x) = toJSON x

instance FromJSON UnionLazy where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLazy . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LazyInUnionLazy . parseJSON) xs

instance ToJSON Lazy where
    toJSON = \_ -> emptyObject

instance FromJSON Lazy where
    parseJSON (Object _) = return Lazy

instance ToJSON UnionLeft where
    toJSON (DoubleInUnionLeft x) = toJSON x
    toJSON (LeftClassInUnionLeft x) = toJSON x

instance FromJSON UnionLeft where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLeft . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LeftClassInUnionLeft . parseJSON) xs

instance ToJSON LeftClass where
    toJSON = \_ -> emptyObject

instance FromJSON LeftClass where
    parseJSON (Object _) = return LeftClass

instance ToJSON UnionList where
    toJSON (DoubleInUnionList x) = toJSON x
    toJSON (ListInUnionList x) = toJSON x

instance FromJSON UnionList where
    parseJSON xs@(Number _) = (fmap DoubleInUnionList . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ListInUnionList . parseJSON) xs

instance ToJSON List where
    toJSON = \_ -> emptyObject

instance FromJSON List where
    parseJSON (Object _) = return List

instance ToJSON UnionLocalDate where
    toJSON (DoubleInUnionLocalDate x) = toJSON x
    toJSON (LocalDateInUnionLocalDate x) = toJSON x

instance FromJSON UnionLocalDate where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLocalDate . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LocalDateInUnionLocalDate . parseJSON) xs

instance ToJSON LocalDate where
    toJSON = \_ -> emptyObject

instance FromJSON LocalDate where
    parseJSON (Object _) = return LocalDate

instance ToJSON UnionLocale where
    toJSON (DoubleInUnionLocale x) = toJSON x
    toJSON (LocaleInUnionLocale x) = toJSON x

instance FromJSON UnionLocale where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLocale . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LocaleInUnionLocale . parseJSON) xs

instance ToJSON Locale where
    toJSON = \_ -> emptyObject

instance FromJSON Locale where
    parseJSON (Object _) = return Locale

instance ToJSON UnionLock where
    toJSON (DoubleInUnionLock x) = toJSON x
    toJSON (LockInUnionLock x) = toJSON x

instance FromJSON UnionLock where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLock . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LockInUnionLock . parseJSON) xs

instance ToJSON Lock where
    toJSON = \_ -> emptyObject

instance FromJSON Lock where
    parseJSON (Object _) = return Lock

instance ToJSON UnionLong where
    toJSON (DoubleInUnionLong x) = toJSON x
    toJSON (LongInUnionLong x) = toJSON x

instance FromJSON UnionLong where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLong . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LongInUnionLong . parseJSON) xs

instance ToJSON Long where
    toJSON = \_ -> emptyObject

instance FromJSON Long where
    parseJSON (Object _) = return Long

instance ToJSON UnionLongNode where
    toJSON (DoubleInUnionLongNode x) = toJSON x
    toJSON (LongNodeInUnionLongNode x) = toJSON x

instance FromJSON UnionLongNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLongNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LongNodeInUnionLongNode . parseJSON) xs

instance ToJSON LongNode where
    toJSON = \_ -> emptyObject

instance FromJSON LongNode where
    parseJSON (Object _) = return LongNode

instance ToJSON UnionMap where
    toJSON (DoubleInUnionMap x) = toJSON x
    toJSON (MapClassInUnionMap x) = toJSON x

instance FromJSON UnionMap where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMap . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MapClassInUnionMap . parseJSON) xs

instance ToJSON MapClass where
    toJSON = \_ -> emptyObject

instance FromJSON MapClass where
    parseJSON (Object _) = return MapClass

instance ToJSON UnionMapEntry where
    toJSON (DoubleInUnionMapEntry x) = toJSON x
    toJSON (MapEntryInUnionMapEntry x) = toJSON x

instance FromJSON UnionMapEntry where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMapEntry . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MapEntryInUnionMapEntry . parseJSON) xs

instance ToJSON MapEntry where
    toJSON = \_ -> emptyObject

instance FromJSON MapEntry where
    parseJSON (Object _) = return MapEntry

instance ToJSON UnionMarshalJSON where
    toJSON (DoubleInUnionMarshalJSON x) = toJSON x
    toJSON (MarshalJSONInUnionMarshalJSON x) = toJSON x

instance FromJSON UnionMarshalJSON where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMarshalJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MarshalJSONInUnionMarshalJSON . parseJSON) xs

instance ToJSON MarshalJSON where
    toJSON = \_ -> emptyObject

instance FromJSON MarshalJSON where
    parseJSON (Object _) = return MarshalJSON

instance ToJSON UnionMetadataPropertyHandling where
    toJSON (DoubleInUnionMetadataPropertyHandling x) = toJSON x
    toJSON (MetadataPropertyHandlingInUnionMetadataPropertyHandling x) = toJSON x

instance FromJSON UnionMetadataPropertyHandling where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMetadataPropertyHandling . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MetadataPropertyHandlingInUnionMetadataPropertyHandling . parseJSON) xs

instance ToJSON MetadataPropertyHandling where
    toJSON = \_ -> emptyObject

instance FromJSON MetadataPropertyHandling where
    parseJSON (Object _) = return MetadataPropertyHandling

instance ToJSON UnionMutable where
    toJSON (DoubleInUnionMutable x) = toJSON x
    toJSON (MutableInUnionMutable x) = toJSON x

instance FromJSON UnionMutable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMutable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MutableInUnionMutable . parseJSON) xs

instance ToJSON Mutable where
    toJSON = \_ -> emptyObject

instance FromJSON Mutable where
    parseJSON (Object _) = return Mutable

instance ToJSON UnionMutating where
    toJSON (DoubleInUnionMutating x) = toJSON x
    toJSON (MutatingInUnionMutating x) = toJSON x

instance FromJSON UnionMutating where
    parseJSON xs@(Number _) = (fmap DoubleInUnionMutating . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MutatingInUnionMutating . parseJSON) xs

instance ToJSON Mutating where
    toJSON = \_ -> emptyObject

instance FromJSON Mutating where
    parseJSON (Object _) = return Mutating

instance ToJSON UnionNamespace where
    toJSON (DoubleInUnionNamespace x) = toJSON x
    toJSON (NamespaceInUnionNamespace x) = toJSON x

instance FromJSON UnionNamespace where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNamespace . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NamespaceInUnionNamespace . parseJSON) xs

instance ToJSON Namespace where
    toJSON = \_ -> emptyObject

instance FromJSON Namespace where
    parseJSON (Object _) = return Namespace

instance ToJSON UnionNative where
    toJSON (DoubleInUnionNative x) = toJSON x
    toJSON (NativeInUnionNative x) = toJSON x

instance FromJSON UnionNative where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNative . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NativeInUnionNative . parseJSON) xs

instance ToJSON Native where
    toJSON = \_ -> emptyObject

instance FromJSON Native where
    parseJSON (Object _) = return Native

instance ToJSON UnionNew where
    toJSON (DoubleInUnionNew x) = toJSON x
    toJSON (NewInUnionNew x) = toJSON x

instance FromJSON UnionNew where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNew . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NewInUnionNew . parseJSON) xs

instance ToJSON New where
    toJSON = \_ -> emptyObject

instance FromJSON New where
    parseJSON (Object _) = return New

instance ToJSON UnionNewtonsoft where
    toJSON (DoubleInUnionNewtonsoft x) = toJSON x
    toJSON (NewtonsoftInUnionNewtonsoft x) = toJSON x

instance FromJSON UnionNewtonsoft where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNewtonsoft . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NewtonsoftInUnionNewtonsoft . parseJSON) xs

instance ToJSON Newtonsoft where
    toJSON = \_ -> emptyObject

instance FromJSON Newtonsoft where
    parseJSON (Object _) = return Newtonsoft

instance ToJSON UnionNil where
    toJSON (DoubleInUnionNil x) = toJSON x
    toJSON (NilInUnionNil x) = toJSON x

instance FromJSON UnionNil where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNil . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NilInUnionNil . parseJSON) xs

instance ToJSON Nil where
    toJSON = \_ -> emptyObject

instance FromJSON Nil where
    parseJSON (Object _) = return Nil

instance ToJSON UnionNO where
    toJSON (DoubleInUnionNO x) = toJSON x
    toJSON (NoInUnionNO x) = toJSON x

instance FromJSON UnionNO where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNO . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NoInUnionNO . parseJSON) xs

instance ToJSON No where
    toJSON = \_ -> emptyObject

instance FromJSON No where
    parseJSON (Object _) = return No

instance ToJSON UnionNoSuchMethod where
    toJSON (DoubleInUnionNoSuchMethod x) = toJSON x
    toJSON (NoSuchMethodInUnionNoSuchMethod x) = toJSON x

instance FromJSON UnionNoSuchMethod where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNoSuchMethod . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NoSuchMethodInUnionNoSuchMethod . parseJSON) xs

instance ToJSON NoSuchMethod where
    toJSON = \_ -> emptyObject

instance FromJSON NoSuchMethod where
    parseJSON (Object _) = return NoSuchMethod

instance ToJSON UnionNoexcept where
    toJSON (DoubleInUnionNoexcept x) = toJSON x
    toJSON (NoexceptInUnionNoexcept x) = toJSON x

instance FromJSON UnionNoexcept where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNoexcept . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NoexceptInUnionNoexcept . parseJSON) xs

instance ToJSON Noexcept where
    toJSON = \_ -> emptyObject

instance FromJSON Noexcept where
    parseJSON (Object _) = return Noexcept

instance ToJSON UnionNonatomic where
    toJSON (DoubleInUnionNonatomic x) = toJSON x
    toJSON (NonatomicInUnionNonatomic x) = toJSON x

instance FromJSON UnionNonatomic where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNonatomic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NonatomicInUnionNonatomic . parseJSON) xs

instance ToJSON Nonatomic where
    toJSON = \_ -> emptyObject

instance FromJSON Nonatomic where
    parseJSON (Object _) = return Nonatomic

instance ToJSON UnionNone where
    toJSON (DoubleInUnionNone x) = toJSON x
    toJSON (NoneInUnionNone x) = toJSON x

instance FromJSON UnionNone where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNone . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NoneInUnionNone . parseJSON) xs

instance ToJSON None where
    toJSON = \_ -> emptyObject

instance FromJSON None where
    parseJSON (Object _) = return None

instance ToJSON UnionNonlocal where
    toJSON (DoubleInUnionNonlocal x) = toJSON x
    toJSON (NonlocalInUnionNonlocal x) = toJSON x

instance FromJSON UnionNonlocal where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNonlocal . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NonlocalInUnionNonlocal . parseJSON) xs

instance ToJSON Nonlocal where
    toJSON = \_ -> emptyObject

instance FromJSON Nonlocal where
    parseJSON (Object _) = return Nonlocal

instance ToJSON UnionNonmutating where
    toJSON (DoubleInUnionNonmutating x) = toJSON x
    toJSON (NonmutatingInUnionNonmutating x) = toJSON x

instance FromJSON UnionNonmutating where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNonmutating . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NonmutatingInUnionNonmutating . parseJSON) xs

instance ToJSON Nonmutating where
    toJSON = \_ -> emptyObject

instance FromJSON Nonmutating where
    parseJSON (Object _) = return Nonmutating

instance ToJSON UnionNot where
    toJSON (DoubleInUnionNot x) = toJSON x
    toJSON (NotInUnionNot x) = toJSON x

instance FromJSON UnionNot where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNot . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NotInUnionNot . parseJSON) xs

instance ToJSON Not where
    toJSON = \_ -> emptyObject

instance FromJSON Not where
    parseJSON (Object _) = return Not

instance ToJSON UnionNotEq where
    toJSON (DoubleInUnionNotEq x) = toJSON x
    toJSON (NotEqInUnionNotEq x) = toJSON x

instance FromJSON UnionNotEq where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNotEq . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NotEqInUnionNotEq . parseJSON) xs

instance ToJSON NotEq where
    toJSON = \_ -> emptyObject

instance FromJSON NotEq where
    parseJSON (Object _) = return NotEq

instance ToJSON UnionNSError where
    toJSON (DoubleInUnionNSError x) = toJSON x
    toJSON (NSErrorInUnionNSError x) = toJSON x

instance FromJSON UnionNSError where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNSError . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NSErrorInUnionNSError . parseJSON) xs

instance ToJSON NSError where
    toJSON = \_ -> emptyObject

instance FromJSON NSError where
    parseJSON (Object _) = return NSError

instance ToJSON UnionNSObject where
    toJSON (DoubleInUnionNSObject x) = toJSON x
    toJSON (NSObjectInUnionNSObject x) = toJSON x

instance FromJSON UnionNSObject where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNSObject . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NSObjectInUnionNSObject . parseJSON) xs

instance ToJSON NSObject where
    toJSON = \_ -> emptyObject

instance FromJSON NSObject where
    parseJSON (Object _) = return NSObject

instance ToJSON UnionNSString where
    toJSON (DoubleInUnionNSString x) = toJSON x
    toJSON (NSStringInUnionNSString x) = toJSON x

instance FromJSON UnionNSString where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNSString . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NSStringInUnionNSString . parseJSON) xs

instance ToJSON NSString where
    toJSON = \_ -> emptyObject

instance FromJSON NSString where
    parseJSON (Object _) = return NSString

instance ToJSON UnionNULL where
    toJSON (DoubleInUnionNULL x) = toJSON x
    toJSON (NULLClassInUnionNULL x) = toJSON x

instance FromJSON UnionNULL where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNULL . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NULLClassInUnionNULL . parseJSON) xs

instance ToJSON NULLClass where
    toJSON = \_ -> emptyObject

instance FromJSON NULLClass where
    parseJSON (Object _) = return NULLClass

instance ToJSON UnionNullNode where
    toJSON (DoubleInUnionNullNode x) = toJSON x
    toJSON (NullNodeInUnionNullNode x) = toJSON x

instance FromJSON UnionNullNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNullNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NullNodeInUnionNullNode . parseJSON) xs

instance ToJSON NullNode where
    toJSON = \_ -> emptyObject

instance FromJSON NullNode where
    parseJSON (Object _) = return NullNode

instance ToJSON UnionNullptr where
    toJSON (DoubleInUnionNullptr x) = toJSON x
    toJSON (NullptrInUnionNullptr x) = toJSON x

instance FromJSON UnionNullptr where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNullptr . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NullptrInUnionNullptr . parseJSON) xs

instance ToJSON Nullptr where
    toJSON = \_ -> emptyObject

instance FromJSON Nullptr where
    parseJSON (Object _) = return Nullptr

instance ToJSON UnionNumber where
    toJSON (DoubleInUnionNumber x) = toJSON x
    toJSON (NumberClassInUnionNumber x) = toJSON x

instance FromJSON UnionNumber where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNumber . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NumberClassInUnionNumber . parseJSON) xs

instance ToJSON NumberClass where
    toJSON = \_ -> emptyObject

instance FromJSON NumberClass where
    parseJSON (Object _) = return NumberClass

instance ToJSON UnionObject where
    toJSON (DoubleInUnionObject x) = toJSON x
    toJSON (ObjectClassInUnionObject x) = toJSON x

instance FromJSON UnionObject where
    parseJSON xs@(Number _) = (fmap DoubleInUnionObject . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ObjectClassInUnionObject . parseJSON) xs

instance ToJSON ObjectClass where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectClass where
    parseJSON (Object _) = return ObjectClass

instance ToJSON UnionObjectMapper where
    toJSON (DoubleInUnionObjectMapper x) = toJSON x
    toJSON (ObjectMapperInUnionObjectMapper x) = toJSON x

instance FromJSON UnionObjectMapper where
    parseJSON xs@(Number _) = (fmap DoubleInUnionObjectMapper . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ObjectMapperInUnionObjectMapper . parseJSON) xs

instance ToJSON ObjectMapper where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectMapper where
    parseJSON (Object _) = return ObjectMapper

instance ToJSON UnionObjectNode where
    toJSON (DoubleInUnionObjectNode x) = toJSON x
    toJSON (ObjectNodeInUnionObjectNode x) = toJSON x

instance FromJSON UnionObjectNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionObjectNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ObjectNodeInUnionObjectNode . parseJSON) xs

instance ToJSON ObjectNode where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectNode where
    parseJSON (Object _) = return ObjectNode

instance ToJSON UnionObjectReader where
    toJSON (DoubleInUnionObjectReader x) = toJSON x
    toJSON (ObjectReaderInUnionObjectReader x) = toJSON x

instance FromJSON UnionObjectReader where
    parseJSON xs@(Number _) = (fmap DoubleInUnionObjectReader . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ObjectReaderInUnionObjectReader . parseJSON) xs

instance ToJSON ObjectReader where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectReader where
    parseJSON (Object _) = return ObjectReader

instance ToJSON UnionObjectWriter where
    toJSON (DoubleInUnionObjectWriter x) = toJSON x
    toJSON (ObjectWriterInUnionObjectWriter x) = toJSON x

instance FromJSON UnionObjectWriter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionObjectWriter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ObjectWriterInUnionObjectWriter . parseJSON) xs

instance ToJSON ObjectWriter where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectWriter where
    parseJSON (Object _) = return ObjectWriter

instance ToJSON UnionOffsetDateTime where
    toJSON (DoubleInUnionOffsetDateTime x) = toJSON x
    toJSON (OffsetDateTimeInUnionOffsetDateTime x) = toJSON x

instance FromJSON UnionOffsetDateTime where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOffsetDateTime . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OffsetDateTimeInUnionOffsetDateTime . parseJSON) xs

instance ToJSON OffsetDateTime where
    toJSON = \_ -> emptyObject

instance FromJSON OffsetDateTime where
    parseJSON (Object _) = return OffsetDateTime

instance ToJSON UnionOffsetTime where
    toJSON (DoubleInUnionOffsetTime x) = toJSON x
    toJSON (OffsetTimeInUnionOffsetTime x) = toJSON x

instance FromJSON UnionOffsetTime where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOffsetTime . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OffsetTimeInUnionOffsetTime . parseJSON) xs

instance ToJSON OffsetTime where
    toJSON = \_ -> emptyObject

instance FromJSON OffsetTime where
    parseJSON (Object _) = return OffsetTime

instance ToJSON UnionOneway where
    toJSON (DoubleInUnionOneway x) = toJSON x
    toJSON (OnewayInUnionOneway x) = toJSON x

instance FromJSON UnionOneway where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOneway . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OnewayInUnionOneway . parseJSON) xs

instance ToJSON Oneway where
    toJSON = \_ -> emptyObject

instance FromJSON Oneway where
    parseJSON (Object _) = return Oneway

instance ToJSON UnionOpen where
    toJSON (DoubleInUnionOpen x) = toJSON x
    toJSON (OpenInUnionOpen x) = toJSON x

instance FromJSON UnionOpen where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOpen . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OpenInUnionOpen . parseJSON) xs

instance ToJSON Open where
    toJSON = \_ -> emptyObject

instance FromJSON Open where
    parseJSON (Object _) = return Open

instance ToJSON UnionOperator where
    toJSON (DoubleInUnionOperator x) = toJSON x
    toJSON (OperatorInUnionOperator x) = toJSON x

instance FromJSON UnionOperator where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOperator . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OperatorInUnionOperator . parseJSON) xs

instance ToJSON Operator where
    toJSON = \_ -> emptyObject

instance FromJSON Operator where
    parseJSON (Object _) = return Operator

instance ToJSON UnionOptional where
    toJSON (DoubleInUnionOptional x) = toJSON x
    toJSON (OptionalInUnionOptional x) = toJSON x

instance FromJSON UnionOptional where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOptional . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OptionalInUnionOptional . parseJSON) xs

instance ToJSON Optional where
    toJSON = \_ -> emptyObject

instance FromJSON Optional where
    parseJSON (Object _) = return Optional

instance ToJSON UnionOr where
    toJSON (DoubleInUnionOr x) = toJSON x
    toJSON (OrInUnionOr x) = toJSON x

instance FromJSON UnionOr where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOr . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OrInUnionOr . parseJSON) xs

instance ToJSON Or where
    toJSON = \_ -> emptyObject

instance FromJSON Or where
    parseJSON (Object _) = return Or

instance ToJSON UnionOrEq where
    toJSON (DoubleInUnionOrEq x) = toJSON x
    toJSON (OrEqInUnionOrEq x) = toJSON x

instance FromJSON UnionOrEq where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOrEq . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OrEqInUnionOrEq . parseJSON) xs

instance ToJSON OrEq where
    toJSON = \_ -> emptyObject

instance FromJSON OrEq where
    parseJSON (Object _) = return OrEq

instance ToJSON UnionOut where
    toJSON (DoubleInUnionOut x) = toJSON x
    toJSON (OutInUnionOut x) = toJSON x

instance FromJSON UnionOut where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOut . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OutInUnionOut . parseJSON) xs

instance ToJSON Out where
    toJSON = \_ -> emptyObject

instance FromJSON Out where
    parseJSON (Object _) = return Out

instance ToJSON UnionOverride where
    toJSON (DoubleInUnionOverride x) = toJSON x
    toJSON (OverrideInUnionOverride x) = toJSON x

instance FromJSON UnionOverride where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOverride . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OverrideInUnionOverride . parseJSON) xs

instance ToJSON Override where
    toJSON = \_ -> emptyObject

instance FromJSON Override where
    parseJSON (Object _) = return Override

instance ToJSON UnionPackage where
    toJSON (DoubleInUnionPackage x) = toJSON x
    toJSON (PackageInUnionPackage x) = toJSON x

instance FromJSON UnionPackage where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPackage . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PackageInUnionPackage . parseJSON) xs

instance ToJSON Package where
    toJSON = \_ -> emptyObject

instance FromJSON Package where
    parseJSON (Object _) = return Package

instance ToJSON UnionParams where
    toJSON (DoubleInUnionParams x) = toJSON x
    toJSON (ParamsInUnionParams x) = toJSON x

instance FromJSON UnionParams where
    parseJSON xs@(Number _) = (fmap DoubleInUnionParams . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ParamsInUnionParams . parseJSON) xs

instance ToJSON Params where
    toJSON = \_ -> emptyObject

instance FromJSON Params where
    parseJSON (Object _) = return Params

instance ToJSON UnionPass where
    toJSON (DoubleInUnionPass x) = toJSON x
    toJSON (PassInUnionPass x) = toJSON x

instance FromJSON UnionPass where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPass . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PassInUnionPass . parseJSON) xs

instance ToJSON Pass where
    toJSON = \_ -> emptyObject

instance FromJSON Pass where
    parseJSON (Object _) = return Pass

instance ToJSON UnionPort where
    toJSON (DoubleInUnionPort x) = toJSON x
    toJSON (PortInUnionPort x) = toJSON x

instance FromJSON UnionPort where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPort . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PortInUnionPort . parseJSON) xs

instance ToJSON Port where
    toJSON = \_ -> emptyObject

instance FromJSON Port where
    parseJSON (Object _) = return Port

instance ToJSON UnionPostfix where
    toJSON (DoubleInUnionPostfix x) = toJSON x
    toJSON (PostfixInUnionPostfix x) = toJSON x

instance FromJSON UnionPostfix where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPostfix . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PostfixInUnionPostfix . parseJSON) xs

instance ToJSON Postfix where
    toJSON = \_ -> emptyObject

instance FromJSON Postfix where
    parseJSON (Object _) = return Postfix

instance ToJSON UnionPrecedence where
    toJSON (DoubleInUnionPrecedence x) = toJSON x
    toJSON (PrecedenceInUnionPrecedence x) = toJSON x

instance FromJSON UnionPrecedence where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrecedence . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrecedenceInUnionPrecedence . parseJSON) xs

instance ToJSON Precedence where
    toJSON = \_ -> emptyObject

instance FromJSON Precedence where
    parseJSON (Object _) = return Precedence

instance ToJSON UnionPrefix where
    toJSON (DoubleInUnionPrefix x) = toJSON x
    toJSON (PrefixInUnionPrefix x) = toJSON x

instance FromJSON UnionPrefix where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrefix . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrefixInUnionPrefix . parseJSON) xs

instance ToJSON Prefix where
    toJSON = \_ -> emptyObject

instance FromJSON Prefix where
    parseJSON (Object _) = return Prefix

instance ToJSON UnionPrimitiveKind where
    toJSON (DoubleInUnionPrimitiveKind x) = toJSON x
    toJSON (PrimitiveKindInUnionPrimitiveKind x) = toJSON x

instance FromJSON UnionPrimitiveKind where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrimitiveKind . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrimitiveKindInUnionPrimitiveKind . parseJSON) xs

instance ToJSON PrimitiveKind where
    toJSON = \_ -> emptyObject

instance FromJSON PrimitiveKind where
    parseJSON (Object _) = return PrimitiveKind

instance ToJSON UnionPrint where
    toJSON (DoubleInUnionPrint x) = toJSON x
    toJSON (PrintInUnionPrint x) = toJSON x

instance FromJSON UnionPrint where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrint . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrintInUnionPrint . parseJSON) xs

instance ToJSON Print where
    toJSON = \_ -> emptyObject

instance FromJSON Print where
    parseJSON (Object _) = return Print

instance ToJSON UnionPrintMembers where
    toJSON (DoubleInUnionPrintMembers x) = toJSON x
    toJSON (PrintMembersInUnionPrintMembers x) = toJSON x

instance FromJSON UnionPrintMembers where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrintMembers . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrintMembersInUnionPrintMembers . parseJSON) xs

instance ToJSON PrintMembers where
    toJSON = \_ -> emptyObject

instance FromJSON PrintMembers where
    parseJSON (Object _) = return PrintMembers

instance ToJSON UnionPrintf where
    toJSON (DoubleInUnionPrintf x) = toJSON x
    toJSON (PrintfInUnionPrintf x) = toJSON x

instance FromJSON UnionPrintf where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrintf . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrintfInUnionPrintf . parseJSON) xs

instance ToJSON Printf where
    toJSON = \_ -> emptyObject

instance FromJSON Printf where
    parseJSON (Object _) = return Printf

instance ToJSON UnionPrivate where
    toJSON (DoubleInUnionPrivate x) = toJSON x
    toJSON (PrivateInUnionPrivate x) = toJSON x

instance FromJSON UnionPrivate where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPrivate . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrivateInUnionPrivate . parseJSON) xs

instance ToJSON Private where
    toJSON = \_ -> emptyObject

instance FromJSON Private where
    parseJSON (Object _) = return Private

instance ToJSON UnionProtected where
    toJSON (DoubleInUnionProtected x) = toJSON x
    toJSON (ProtectedInUnionProtected x) = toJSON x

instance FromJSON UnionProtected where
    parseJSON xs@(Number _) = (fmap DoubleInUnionProtected . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ProtectedInUnionProtected . parseJSON) xs

instance ToJSON Protected where
    toJSON = \_ -> emptyObject

instance FromJSON Protected where
    parseJSON (Object _) = return Protected

instance ToJSON UnionProtocol where
    toJSON (DoubleInUnionProtocol x) = toJSON x
    toJSON (ProtocolInUnionProtocol x) = toJSON x

instance FromJSON UnionProtocol where
    parseJSON xs@(Number _) = (fmap DoubleInUnionProtocol . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ProtocolInUnionProtocol . parseJSON) xs

instance ToJSON Protocol where
    toJSON = \_ -> emptyObject

instance FromJSON Protocol where
    parseJSON (Object _) = return Protocol

instance ToJSON UnionPublic where
    toJSON (DoubleInUnionPublic x) = toJSON x
    toJSON (PublicInUnionPublic x) = toJSON x

instance FromJSON UnionPublic where
    parseJSON xs@(Number _) = (fmap DoubleInUnionPublic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PublicInUnionPublic . parseJSON) xs

instance ToJSON Public where
    toJSON = \_ -> emptyObject

instance FromJSON Public where
    parseJSON (Object _) = return Public

instance ToJSON UnionBoolUnion where
    toJSON (DoubleInUnionBoolUnion x) = toJSON x
    toJSON (UnionBoolBoolInUnionBoolUnion x) = toJSON x

instance FromJSON UnionBoolUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionBoolUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionBoolBoolInUnionBoolUnion . parseJSON) xs

instance ToJSON UnionBoolBool where
    toJSON = \_ -> emptyObject

instance FromJSON UnionBoolBool where
    parseJSON (Object _) = return UnionBoolBool

instance ToJSON UnionClassUnion where
    toJSON (ClassClassInUnionClassUnion x) = toJSON x
    toJSON (DoubleInUnionClassUnion x) = toJSON x

instance FromJSON UnionClassUnion where
    parseJSON xs@(Object _) = (fmap ClassClassInUnionClassUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionClassUnion . parseJSON) xs

instance ToJSON ClassClass where
    toJSON = \_ -> emptyObject

instance FromJSON ClassClass where
    parseJSON (Object _) = return ClassClass

instance ToJSON UnionTypeUnion where
    toJSON (DoubleInUnionTypeUnion x) = toJSON x
    toJSON (TypeClassInUnionTypeUnion x) = toJSON x

instance FromJSON UnionTypeUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypeUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypeClassInUnionTypeUnion . parseJSON) xs

instance ToJSON TypeClass where
    toJSON = \_ -> emptyObject

instance FromJSON TypeClass where
    parseJSON (Object _) = return TypeClass

instance ToJSON UnionAnyUnion where
    toJSON (AnyClassInUnionAnyUnion x) = toJSON x
    toJSON (DoubleInUnionAnyUnion x) = toJSON x

instance FromJSON UnionAnyUnion where
    parseJSON xs@(Object _) = (fmap AnyClassInUnionAnyUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAnyUnion . parseJSON) xs

instance ToJSON AnyClass where
    toJSON = \_ -> emptyObject

instance FromJSON AnyClass where
    parseJSON (Object _) = return AnyClass

instance ToJSON UnionAs where
    toJSON (AsInUnionAs x) = toJSON x
    toJSON (DoubleInUnionAs x) = toJSON x

instance FromJSON UnionAs where
    parseJSON xs@(Object _) = (fmap AsInUnionAs . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionAs . parseJSON) xs

instance ToJSON As where
    toJSON = \_ -> emptyObject

instance FromJSON As where
    parseJSON (Object _) = return As

instance ToJSON UnionBool where
    toJSON (BoolClassInUnionBool x) = toJSON x
    toJSON (DoubleInUnionBool x) = toJSON x

instance FromJSON UnionBool where
    parseJSON xs@(Object _) = (fmap BoolClassInUnionBool . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionBool . parseJSON) xs

instance ToJSON BoolClass where
    toJSON = \_ -> emptyObject

instance FromJSON BoolClass where
    parseJSON (Object _) = return BoolClass

instance ToJSON UnionCase where
    toJSON (CaseInUnionCase x) = toJSON x
    toJSON (DoubleInUnionCase x) = toJSON x

instance FromJSON UnionCase where
    parseJSON xs@(Object _) = (fmap CaseInUnionCase . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionCase . parseJSON) xs

instance ToJSON Case where
    toJSON = \_ -> emptyObject

instance FromJSON Case where
    parseJSON (Object _) = return Case

instance ToJSON UnionClass where
    toJSON (ClassInUnionClass x) = toJSON x
    toJSON (DoubleInUnionClass x) = toJSON x

instance FromJSON UnionClass where
    parseJSON xs@(Object _) = (fmap ClassInUnionClass . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionClass . parseJSON) xs

instance ToJSON Class where
    toJSON = \_ -> emptyObject

instance FromJSON Class where
    parseJSON (Object _) = return Class

instance ToJSON UnionDefault where
    toJSON (DefaultInUnionDefault x) = toJSON x
    toJSON (DoubleInUnionDefault x) = toJSON x

instance FromJSON UnionDefault where
    parseJSON xs@(Object _) = (fmap DefaultInUnionDefault . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDefault . parseJSON) xs

instance ToJSON Default where
    toJSON = \_ -> emptyObject

instance FromJSON Default where
    parseJSON (Object _) = return Default

instance ToJSON UnionDo where
    toJSON (DoInUnionDo x) = toJSON x
    toJSON (DoubleInUnionDo x) = toJSON x

instance FromJSON UnionDo where
    parseJSON xs@(Object _) = (fmap DoInUnionDo . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionDo . parseJSON) xs

instance ToJSON Do where
    toJSON = \_ -> emptyObject

instance FromJSON Do where
    parseJSON (Object _) = return Do

instance ToJSON UnionElse where
    toJSON (DoubleInUnionElse x) = toJSON x
    toJSON (ElseInUnionElse x) = toJSON x

instance FromJSON UnionElse where
    parseJSON xs@(Number _) = (fmap DoubleInUnionElse . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ElseInUnionElse . parseJSON) xs

instance ToJSON Else where
    toJSON = \_ -> emptyObject

instance FromJSON Else where
    parseJSON (Object _) = return Else

instance ToJSON UnionFalseUnion where
    toJSON (DoubleInUnionFalseUnion x) = toJSON x
    toJSON (UnionFalseFalseInUnionFalseUnion x) = toJSON x

instance FromJSON UnionFalseUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionFalseUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionFalseFalseInUnionFalseUnion . parseJSON) xs

instance ToJSON UnionFalseFalse where
    toJSON = \_ -> emptyObject

instance FromJSON UnionFalseFalse where
    parseJSON (Object _) = return UnionFalseFalse

instance ToJSON UnionID where
    toJSON (DoubleInUnionID x) = toJSON x
    toJSON (IDInUnionID x) = toJSON x

instance FromJSON UnionID where
    parseJSON xs@(Number _) = (fmap DoubleInUnionID . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IDInUnionID . parseJSON) xs

instance ToJSON ID where
    toJSON = \_ -> emptyObject

instance FromJSON ID where
    parseJSON (Object _) = return ID

instance ToJSON UnionIf where
    toJSON (DoubleInUnionIf x) = toJSON x
    toJSON (IfInUnionIf x) = toJSON x

instance FromJSON UnionIf where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIf . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IfInUnionIf . parseJSON) xs

instance ToJSON If where
    toJSON = \_ -> emptyObject

instance FromJSON If where
    parseJSON (Object _) = return If

instance ToJSON UnionImport where
    toJSON (DoubleInUnionImport x) = toJSON x
    toJSON (ImportInUnionImport x) = toJSON x

instance FromJSON UnionImport where
    parseJSON xs@(Number _) = (fmap DoubleInUnionImport . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ImportInUnionImport . parseJSON) xs

instance ToJSON Import where
    toJSON = \_ -> emptyObject

instance FromJSON Import where
    parseJSON (Object _) = return Import

instance ToJSON UnionIn where
    toJSON (DoubleInUnionIn x) = toJSON x
    toJSON (InInUnionIn x) = toJSON x

instance FromJSON UnionIn where
    parseJSON xs@(Number _) = (fmap DoubleInUnionIn . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InInUnionIn . parseJSON) xs

instance ToJSON In where
    toJSON = \_ -> emptyObject

instance FromJSON In where
    parseJSON (Object _) = return In

instance ToJSON UnionInfix where
    toJSON (DoubleInUnionInfix x) = toJSON x
    toJSON (InfixInUnionInfix x) = toJSON x

instance FromJSON UnionInfix where
    parseJSON xs@(Number _) = (fmap DoubleInUnionInfix . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InfixInUnionInfix . parseJSON) xs

instance ToJSON Infix where
    toJSON = \_ -> emptyObject

instance FromJSON Infix where
    parseJSON (Object _) = return Infix

instance ToJSON UnionLet where
    toJSON (DoubleInUnionLet x) = toJSON x
    toJSON (LetInUnionLet x) = toJSON x

instance FromJSON UnionLet where
    parseJSON xs@(Number _) = (fmap DoubleInUnionLet . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LetInUnionLet . parseJSON) xs

instance ToJSON Let where
    toJSON = \_ -> emptyObject

instance FromJSON Let where
    parseJSON (Object _) = return Let

instance ToJSON UnionModule where
    toJSON (DoubleInUnionModule x) = toJSON x
    toJSON (ModuleInUnionModule x) = toJSON x

instance FromJSON UnionModule where
    parseJSON xs@(Number _) = (fmap DoubleInUnionModule . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ModuleInUnionModule . parseJSON) xs

instance ToJSON Module where
    toJSON = \_ -> emptyObject

instance FromJSON Module where
    parseJSON (Object _) = return Module

instance ToJSON UnionNoneUnion where
    toJSON (DoubleInUnionNoneUnion x) = toJSON x
    toJSON (NoneClassInUnionNoneUnion x) = toJSON x

instance FromJSON UnionNoneUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNoneUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NoneClassInUnionNoneUnion . parseJSON) xs

instance ToJSON NoneClass where
    toJSON = \_ -> emptyObject

instance FromJSON NoneClass where
    parseJSON (Object _) = return NoneClass

instance ToJSON UnionNull where
    toJSON (DoubleInUnionNull x) = toJSON x
    toJSON (NullClassInUnionNull x) = toJSON x

instance FromJSON UnionNull where
    parseJSON xs@(Number _) = (fmap DoubleInUnionNull . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NullClassInUnionNull . parseJSON) xs

instance ToJSON NullClass where
    toJSON = \_ -> emptyObject

instance FromJSON NullClass where
    parseJSON (Object _) = return NullClass

instance ToJSON UnionOf where
    toJSON (DoubleInUnionOf x) = toJSON x
    toJSON (OfInUnionOf x) = toJSON x

instance FromJSON UnionOf where
    parseJSON xs@(Number _) = (fmap DoubleInUnionOf . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OfInUnionOf . parseJSON) xs

instance ToJSON Of where
    toJSON = \_ -> emptyObject

instance FromJSON Of where
    parseJSON (Object _) = return Of

instance ToJSON UnionProtocolUnion where
    toJSON (DoubleInUnionProtocolUnion x) = toJSON x
    toJSON (ProtocolClassInUnionProtocolUnion x) = toJSON x

instance FromJSON UnionProtocolUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionProtocolUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ProtocolClassInUnionProtocolUnion . parseJSON) xs

instance ToJSON ProtocolClass where
    toJSON = \_ -> emptyObject

instance FromJSON ProtocolClass where
    parseJSON (Object _) = return ProtocolClass

instance ToJSON UnionSelfUnion where
    toJSON (DoubleInUnionSelfUnion x) = toJSON x
    toJSON (SelfClassInUnionSelfUnion x) = toJSON x

instance FromJSON UnionSelfUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSelfUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SelfClassInUnionSelfUnion . parseJSON) xs

instance ToJSON SelfClass where
    toJSON = \_ -> emptyObject

instance FromJSON SelfClass where
    parseJSON (Object _) = return SelfClass

instance ToJSON UnionThen where
    toJSON (DoubleInUnionThen x) = toJSON x
    toJSON (ThenInUnionThen x) = toJSON x

instance FromJSON UnionThen where
    parseJSON xs@(Number _) = (fmap DoubleInUnionThen . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ThenInUnionThen . parseJSON) xs

instance ToJSON Then where
    toJSON = \_ -> emptyObject

instance FromJSON Then where
    parseJSON (Object _) = return Then

instance ToJSON UnionTrueUnion where
    toJSON (DoubleInUnionTrueUnion x) = toJSON x
    toJSON (UnionTrueTrueInUnionTrueUnion x) = toJSON x

instance FromJSON UnionTrueUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTrueUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionTrueTrueInUnionTrueUnion . parseJSON) xs

instance ToJSON UnionTrueTrue where
    toJSON = \_ -> emptyObject

instance FromJSON UnionTrueTrue where
    parseJSON (Object _) = return UnionTrueTrue

instance ToJSON UnionType where
    toJSON (DoubleInUnionType x) = toJSON x
    toJSON (TypeInUnionType x) = toJSON x

instance FromJSON UnionType where
    parseJSON xs@(Number _) = (fmap DoubleInUnionType . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypeInUnionType . parseJSON) xs

instance ToJSON Type where
    toJSON = \_ -> emptyObject

instance FromJSON Type where
    parseJSON (Object _) = return Type

instance ToJSON UnionWhere where
    toJSON (DoubleInUnionWhere x) = toJSON x
    toJSON (WhereInUnionWhere x) = toJSON x

instance FromJSON UnionWhere where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWhere . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WhereInUnionWhere . parseJSON) xs

instance ToJSON Where where
    toJSON = \_ -> emptyObject

instance FromJSON Where where
    parseJSON (Object _) = return Where

instance ToJSON UnionQuicktype where
    toJSON (DoubleInUnionQuicktype x) = toJSON x
    toJSON (QuicktypeInUnionQuicktype x) = toJSON x

instance FromJSON UnionQuicktype where
    parseJSON xs@(Number _) = (fmap DoubleInUnionQuicktype . parseJSON) xs
    parseJSON xs@(Object _) = (fmap QuicktypeInUnionQuicktype . parseJSON) xs

instance ToJSON Quicktype where
    toJSON = \_ -> emptyObject

instance FromJSON Quicktype where
    parseJSON (Object _) = return Quicktype

instance ToJSON UnionRaise where
    toJSON (DoubleInUnionRaise x) = toJSON x
    toJSON (RaiseInUnionRaise x) = toJSON x

instance FromJSON UnionRaise where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRaise . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RaiseInUnionRaise . parseJSON) xs

instance ToJSON Raise where
    toJSON = \_ -> emptyObject

instance FromJSON Raise where
    parseJSON (Object _) = return Raise

instance ToJSON UnionRange where
    toJSON (DoubleInUnionRange x) = toJSON x
    toJSON (RangeInUnionRange x) = toJSON x

instance FromJSON UnionRange where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRange . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RangeInUnionRange . parseJSON) xs

instance ToJSON Range where
    toJSON = \_ -> emptyObject

instance FromJSON Range where
    parseJSON (Object _) = return Range

instance ToJSON UnionReadonly where
    toJSON (DoubleInUnionReadonly x) = toJSON x
    toJSON (ReadonlyInUnionReadonly x) = toJSON x

instance FromJSON UnionReadonly where
    parseJSON xs@(Number _) = (fmap DoubleInUnionReadonly . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ReadonlyInUnionReadonly . parseJSON) xs

instance ToJSON Readonly where
    toJSON = \_ -> emptyObject

instance FromJSON Readonly where
    parseJSON (Object _) = return Readonly

instance ToJSON UnionRef where
    toJSON (DoubleInUnionRef x) = toJSON x
    toJSON (RefInUnionRef x) = toJSON x

instance FromJSON UnionRef where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRef . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RefInUnionRef . parseJSON) xs

instance ToJSON Ref where
    toJSON = \_ -> emptyObject

instance FromJSON Ref where
    parseJSON (Object _) = return Ref

instance ToJSON UnionRegExp where
    toJSON (DoubleInUnionRegExp x) = toJSON x
    toJSON (RegExpInUnionRegExp x) = toJSON x

instance FromJSON UnionRegExp where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRegExp . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RegExpInUnionRegExp . parseJSON) xs

instance ToJSON RegExp where
    toJSON = \_ -> emptyObject

instance FromJSON RegExp where
    parseJSON (Object _) = return RegExp

instance ToJSON UnionRegister where
    toJSON (DoubleInUnionRegister x) = toJSON x
    toJSON (RegisterInUnionRegister x) = toJSON x

instance FromJSON UnionRegister where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRegister . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RegisterInUnionRegister . parseJSON) xs

instance ToJSON Register where
    toJSON = \_ -> emptyObject

instance FromJSON Register where
    parseJSON (Object _) = return Register

instance ToJSON UnionReinterpretCast where
    toJSON (DoubleInUnionReinterpretCast x) = toJSON x
    toJSON (ReinterpretCastInUnionReinterpretCast x) = toJSON x

instance FromJSON UnionReinterpretCast where
    parseJSON xs@(Number _) = (fmap DoubleInUnionReinterpretCast . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ReinterpretCastInUnionReinterpretCast . parseJSON) xs

instance ToJSON ReinterpretCast where
    toJSON = \_ -> emptyObject

instance FromJSON ReinterpretCast where
    parseJSON (Object _) = return ReinterpretCast

instance ToJSON UnionRepeat where
    toJSON (DoubleInUnionRepeat x) = toJSON x
    toJSON (RepeatInUnionRepeat x) = toJSON x

instance FromJSON UnionRepeat where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRepeat . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RepeatInUnionRepeat . parseJSON) xs

instance ToJSON Repeat where
    toJSON = \_ -> emptyObject

instance FromJSON Repeat where
    parseJSON (Object _) = return Repeat

instance ToJSON UnionRequire where
    toJSON (DoubleInUnionRequire x) = toJSON x
    toJSON (RequireInUnionRequire x) = toJSON x

instance FromJSON UnionRequire where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRequire . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RequireInUnionRequire . parseJSON) xs

instance ToJSON Require where
    toJSON = \_ -> emptyObject

instance FromJSON Require where
    parseJSON (Object _) = return Require

instance ToJSON UnionRequired where
    toJSON (DoubleInUnionRequired x) = toJSON x
    toJSON (RequiredInUnionRequired x) = toJSON x

instance FromJSON UnionRequired where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRequired . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RequiredInUnionRequired . parseJSON) xs

instance ToJSON Required where
    toJSON = \_ -> emptyObject

instance FromJSON Required where
    parseJSON (Object _) = return Required

instance ToJSON UnionRequires where
    toJSON (DoubleInUnionRequires x) = toJSON x
    toJSON (RequiresInUnionRequires x) = toJSON x

instance FromJSON UnionRequires where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRequires . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RequiresInUnionRequires . parseJSON) xs

instance ToJSON Requires where
    toJSON = \_ -> emptyObject

instance FromJSON Requires where
    parseJSON (Object _) = return Requires

instance ToJSON UnionRestrict where
    toJSON (DoubleInUnionRestrict x) = toJSON x
    toJSON (RestrictInUnionRestrict x) = toJSON x

instance FromJSON UnionRestrict where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRestrict . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RestrictInUnionRestrict . parseJSON) xs

instance ToJSON Restrict where
    toJSON = \_ -> emptyObject

instance FromJSON Restrict where
    parseJSON (Object _) = return Restrict

instance ToJSON UnionRetain where
    toJSON (DoubleInUnionRetain x) = toJSON x
    toJSON (RetainInUnionRetain x) = toJSON x

instance FromJSON UnionRetain where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRetain . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RetainInUnionRetain . parseJSON) xs

instance ToJSON Retain where
    toJSON = \_ -> emptyObject

instance FromJSON Retain where
    parseJSON (Object _) = return Retain

instance ToJSON UnionRethrows where
    toJSON (DoubleInUnionRethrows x) = toJSON x
    toJSON (RethrowsInUnionRethrows x) = toJSON x

instance FromJSON UnionRethrows where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRethrows . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RethrowsInUnionRethrows . parseJSON) xs

instance ToJSON Rethrows where
    toJSON = \_ -> emptyObject

instance FromJSON Rethrows where
    parseJSON (Object _) = return Rethrows

instance ToJSON UnionReturn where
    toJSON (DoubleInUnionReturn x) = toJSON x
    toJSON (ReturnInUnionReturn x) = toJSON x

instance FromJSON UnionReturn where
    parseJSON xs@(Number _) = (fmap DoubleInUnionReturn . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ReturnInUnionReturn . parseJSON) xs

instance ToJSON Return where
    toJSON = \_ -> emptyObject

instance FromJSON Return where
    parseJSON (Object _) = return Return

instance ToJSON UnionRight where
    toJSON (DoubleInUnionRight x) = toJSON x
    toJSON (RightClassInUnionRight x) = toJSON x

instance FromJSON UnionRight where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRight . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RightClassInUnionRight . parseJSON) xs

instance ToJSON RightClass where
    toJSON = \_ -> emptyObject

instance FromJSON RightClass where
    parseJSON (Object _) = return RightClass

instance ToJSON UnionRuntimeType where
    toJSON (DoubleInUnionRuntimeType x) = toJSON x
    toJSON (RuntimeTypeInUnionRuntimeType x) = toJSON x

instance FromJSON UnionRuntimeType where
    parseJSON xs@(Number _) = (fmap DoubleInUnionRuntimeType . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RuntimeTypeInUnionRuntimeType . parseJSON) xs

instance ToJSON RuntimeType where
    toJSON = \_ -> emptyObject

instance FromJSON RuntimeType where
    parseJSON (Object _) = return RuntimeType

instance ToJSON UnionS where
    toJSON (DoubleInUnionS x) = toJSON x
    toJSON (SInUnionS x) = toJSON x

instance FromJSON UnionS where
    parseJSON xs@(Number _) = (fmap DoubleInUnionS . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SInUnionS . parseJSON) xs

instance ToJSON S where
    toJSON = \_ -> emptyObject

instance FromJSON S where
    parseJSON (Object _) = return S

instance ToJSON UnionSbyte where
    toJSON (DoubleInUnionSbyte x) = toJSON x
    toJSON (SbyteInUnionSbyte x) = toJSON x

instance FromJSON UnionSbyte where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSbyte . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SbyteInUnionSbyte . parseJSON) xs

instance ToJSON Sbyte where
    toJSON = \_ -> emptyObject

instance FromJSON Sbyte where
    parseJSON (Object _) = return Sbyte

instance ToJSON UnionSealed where
    toJSON (DoubleInUnionSealed x) = toJSON x
    toJSON (SealedInUnionSealed x) = toJSON x

instance FromJSON UnionSealed where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSealed . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SealedInUnionSealed . parseJSON) xs

instance ToJSON Sealed where
    toJSON = \_ -> emptyObject

instance FromJSON Sealed where
    parseJSON (Object _) = return Sealed

instance ToJSON UnionSEL where
    toJSON (DoubleInUnionSEL x) = toJSON x
    toJSON (SelInUnionSEL x) = toJSON x

instance FromJSON UnionSEL where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSEL . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SelInUnionSEL . parseJSON) xs

instance ToJSON Sel where
    toJSON = \_ -> emptyObject

instance FromJSON Sel where
    parseJSON (Object _) = return Sel

instance ToJSON UnionSelect where
    toJSON (DoubleInUnionSelect x) = toJSON x
    toJSON (SelectInUnionSelect x) = toJSON x

instance FromJSON UnionSelect where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSelect . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SelectInUnionSelect . parseJSON) xs

instance ToJSON Select where
    toJSON = \_ -> emptyObject

instance FromJSON Select where
    parseJSON (Object _) = return Select

instance ToJSON UnionSelf where
    toJSON (DoubleInUnionSelf x) = toJSON x
    toJSON (SelfInUnionSelf x) = toJSON x

instance FromJSON UnionSelf where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSelf . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SelfInUnionSelf . parseJSON) xs

instance ToJSON Self where
    toJSON = \_ -> emptyObject

instance FromJSON Self where
    parseJSON (Object _) = return Self

instance ToJSON UnionSendable where
    toJSON (DoubleInUnionSendable x) = toJSON x
    toJSON (SendableInUnionSendable x) = toJSON x

instance FromJSON UnionSendable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSendable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SendableInUnionSendable . parseJSON) xs

instance ToJSON Sendable where
    toJSON = \_ -> emptyObject

instance FromJSON Sendable where
    parseJSON (Object _) = return Sendable

instance ToJSON UnionSerialDescriptor where
    toJSON (DoubleInUnionSerialDescriptor x) = toJSON x
    toJSON (SerialDescriptorInUnionSerialDescriptor x) = toJSON x

instance FromJSON UnionSerialDescriptor where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerialDescriptor . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerialDescriptorInUnionSerialDescriptor . parseJSON) xs

instance ToJSON SerialDescriptor where
    toJSON = \_ -> emptyObject

instance FromJSON SerialDescriptor where
    parseJSON (Object _) = return SerialDescriptor

instance ToJSON UnionSerialName where
    toJSON (DoubleInUnionSerialName x) = toJSON x
    toJSON (SerialNameInUnionSerialName x) = toJSON x

instance FromJSON UnionSerialName where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerialName . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerialNameInUnionSerialName . parseJSON) xs

instance ToJSON SerialName where
    toJSON = \_ -> emptyObject

instance FromJSON SerialName where
    parseJSON (Object _) = return SerialName

instance ToJSON UnionSerializable where
    toJSON (DoubleInUnionSerializable x) = toJSON x
    toJSON (SerializableInUnionSerializable x) = toJSON x

instance FromJSON UnionSerializable where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerializable . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerializableInUnionSerializable . parseJSON) xs

instance ToJSON Serializable where
    toJSON = \_ -> emptyObject

instance FromJSON Serializable where
    parseJSON (Object _) = return Serializable

instance ToJSON UnionSerializationFeature where
    toJSON (DoubleInUnionSerializationFeature x) = toJSON x
    toJSON (SerializationFeatureInUnionSerializationFeature x) = toJSON x

instance FromJSON UnionSerializationFeature where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerializationFeature . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerializationFeatureInUnionSerializationFeature . parseJSON) xs

instance ToJSON SerializationFeature where
    toJSON = \_ -> emptyObject

instance FromJSON SerializationFeature where
    parseJSON (Object _) = return SerializationFeature

instance ToJSON UnionSerialize where
    toJSON (DoubleInUnionSerialize x) = toJSON x
    toJSON (SerializeInUnionSerialize x) = toJSON x

instance FromJSON UnionSerialize where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerialize . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerializeInUnionSerialize . parseJSON) xs

instance ToJSON Serialize where
    toJSON = \_ -> emptyObject

instance FromJSON Serialize where
    parseJSON (Object _) = return Serialize

instance ToJSON UnionSerializerProvider where
    toJSON (DoubleInUnionSerializerProvider x) = toJSON x
    toJSON (SerializerProviderInUnionSerializerProvider x) = toJSON x

instance FromJSON UnionSerializerProvider where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSerializerProvider . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SerializerProviderInUnionSerializerProvider . parseJSON) xs

instance ToJSON SerializerProvider where
    toJSON = \_ -> emptyObject

instance FromJSON SerializerProvider where
    parseJSON (Object _) = return SerializerProvider

instance ToJSON UnionSet where
    toJSON (DoubleInUnionSet x) = toJSON x
    toJSON (SetInUnionSet x) = toJSON x

instance FromJSON UnionSet where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSet . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SetInUnionSet . parseJSON) xs

instance ToJSON Set where
    toJSON = \_ -> emptyObject

instance FromJSON Set where
    parseJSON (Object _) = return Set

instance ToJSON UnionShort where
    toJSON (DoubleInUnionShort x) = toJSON x
    toJSON (ShortInUnionShort x) = toJSON x

instance FromJSON UnionShort where
    parseJSON xs@(Number _) = (fmap DoubleInUnionShort . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ShortInUnionShort . parseJSON) xs

instance ToJSON Short where
    toJSON = \_ -> emptyObject

instance FromJSON Short where
    parseJSON (Object _) = return Short

instance ToJSON UnionSigned where
    toJSON (DoubleInUnionSigned x) = toJSON x
    toJSON (SignedInUnionSigned x) = toJSON x

instance FromJSON UnionSigned where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSigned . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SignedInUnionSigned . parseJSON) xs

instance ToJSON Signed where
    toJSON = \_ -> emptyObject

instance FromJSON Signed where
    parseJSON (Object _) = return Signed

instance ToJSON UnionSimpleModule where
    toJSON (DoubleInUnionSimpleModule x) = toJSON x
    toJSON (SimpleModuleInUnionSimpleModule x) = toJSON x

instance FromJSON UnionSimpleModule where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSimpleModule . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SimpleModuleInUnionSimpleModule . parseJSON) xs

instance ToJSON SimpleModule where
    toJSON = \_ -> emptyObject

instance FromJSON SimpleModule where
    parseJSON (Object _) = return SimpleModule

instance ToJSON UnionSizeof where
    toJSON (DoubleInUnionSizeof x) = toJSON x
    toJSON (SizeofInUnionSizeof x) = toJSON x

instance FromJSON UnionSizeof where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSizeof . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SizeofInUnionSizeof . parseJSON) xs

instance ToJSON Sizeof where
    toJSON = \_ -> emptyObject

instance FromJSON Sizeof where
    parseJSON (Object _) = return Sizeof

instance ToJSON UnionStackalloc where
    toJSON (DoubleInUnionStackalloc x) = toJSON x
    toJSON (StackallocInUnionStackalloc x) = toJSON x

instance FromJSON UnionStackalloc where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStackalloc . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StackallocInUnionStackalloc . parseJSON) xs

instance ToJSON Stackalloc where
    toJSON = \_ -> emptyObject

instance FromJSON Stackalloc where
    parseJSON (Object _) = return Stackalloc

instance ToJSON UnionStandards where
    toJSON (DoubleInUnionStandards x) = toJSON x
    toJSON (StandardsInUnionStandards x) = toJSON x

instance FromJSON UnionStandards where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStandards . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StandardsInUnionStandards . parseJSON) xs

instance ToJSON Standards where
    toJSON = \_ -> emptyObject

instance FromJSON Standards where
    parseJSON (Object _) = return Standards

instance ToJSON UnionStatic where
    toJSON (DoubleInUnionStatic x) = toJSON x
    toJSON (StaticInUnionStatic x) = toJSON x

instance FromJSON UnionStatic where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStatic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StaticInUnionStatic . parseJSON) xs

instance ToJSON Static where
    toJSON = \_ -> emptyObject

instance FromJSON Static where
    parseJSON (Object _) = return Static

instance ToJSON UnionStaticAssert where
    toJSON (DoubleInUnionStaticAssert x) = toJSON x
    toJSON (StaticAssertInUnionStaticAssert x) = toJSON x

instance FromJSON UnionStaticAssert where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStaticAssert . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StaticAssertInUnionStaticAssert . parseJSON) xs

instance ToJSON StaticAssert where
    toJSON = \_ -> emptyObject

instance FromJSON StaticAssert where
    parseJSON (Object _) = return StaticAssert

instance ToJSON UnionStaticCast where
    toJSON (DoubleInUnionStaticCast x) = toJSON x
    toJSON (StaticCastInUnionStaticCast x) = toJSON x

instance FromJSON UnionStaticCast where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStaticCast . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StaticCastInUnionStaticCast . parseJSON) xs

instance ToJSON StaticCast where
    toJSON = \_ -> emptyObject

instance FromJSON StaticCast where
    parseJSON (Object _) = return StaticCast

instance ToJSON UnionStdDeserializer where
    toJSON (DoubleInUnionStdDeserializer x) = toJSON x
    toJSON (StdDeserializerInUnionStdDeserializer x) = toJSON x

instance FromJSON UnionStdDeserializer where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStdDeserializer . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StdDeserializerInUnionStdDeserializer . parseJSON) xs

instance ToJSON StdDeserializer where
    toJSON = \_ -> emptyObject

instance FromJSON StdDeserializer where
    parseJSON (Object _) = return StdDeserializer

instance ToJSON UnionStdSerializer where
    toJSON (DoubleInUnionStdSerializer x) = toJSON x
    toJSON (StdSerializerInUnionStdSerializer x) = toJSON x

instance FromJSON UnionStdSerializer where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStdSerializer . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StdSerializerInUnionStdSerializer . parseJSON) xs

instance ToJSON StdSerializer where
    toJSON = \_ -> emptyObject

instance FromJSON StdSerializer where
    parseJSON (Object _) = return StdSerializer

instance ToJSON UnionStrictfp where
    toJSON (DoubleInUnionStrictfp x) = toJSON x
    toJSON (StrictfpInUnionStrictfp x) = toJSON x

instance FromJSON UnionStrictfp where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStrictfp . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StrictfpInUnionStrictfp . parseJSON) xs

instance ToJSON Strictfp where
    toJSON = \_ -> emptyObject

instance FromJSON Strictfp where
    parseJSON (Object _) = return Strictfp

instance ToJSON UnionString where
    toJSON (DoubleInUnionString x) = toJSON x
    toJSON (StringClassInUnionString x) = toJSON x

instance FromJSON UnionString where
    parseJSON xs@(Number _) = (fmap DoubleInUnionString . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StringClassInUnionString . parseJSON) xs

instance ToJSON StringClass where
    toJSON = \_ -> emptyObject

instance FromJSON StringClass where
    parseJSON (Object _) = return StringClass

instance ToJSON UnionStruct where
    toJSON (DoubleInUnionStruct x) = toJSON x
    toJSON (StructInUnionStruct x) = toJSON x

instance FromJSON UnionStruct where
    parseJSON xs@(Number _) = (fmap DoubleInUnionStruct . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StructInUnionStruct . parseJSON) xs

instance ToJSON Struct where
    toJSON = \_ -> emptyObject

instance FromJSON Struct where
    parseJSON (Object _) = return Struct

instance ToJSON UnionSubscript where
    toJSON (DoubleInUnionSubscript x) = toJSON x
    toJSON (SubscriptInUnionSubscript x) = toJSON x

instance FromJSON UnionSubscript where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSubscript . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SubscriptInUnionSubscript . parseJSON) xs

instance ToJSON Subscript where
    toJSON = \_ -> emptyObject

instance FromJSON Subscript where
    parseJSON (Object _) = return Subscript

instance ToJSON UnionSuper where
    toJSON (DoubleInUnionSuper x) = toJSON x
    toJSON (SuperInUnionSuper x) = toJSON x

instance FromJSON UnionSuper where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSuper . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SuperInUnionSuper . parseJSON) xs

instance ToJSON Super where
    toJSON = \_ -> emptyObject

instance FromJSON Super where
    parseJSON (Object _) = return Super

instance ToJSON UnionSwitch where
    toJSON (DoubleInUnionSwitch x) = toJSON x
    toJSON (SwitchInUnionSwitch x) = toJSON x

instance FromJSON UnionSwitch where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSwitch . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SwitchInUnionSwitch . parseJSON) xs

instance ToJSON Switch where
    toJSON = \_ -> emptyObject

instance FromJSON Switch where
    parseJSON (Object _) = return Switch

instance ToJSON UnionSymbol where
    toJSON (DoubleInUnionSymbol x) = toJSON x
    toJSON (SymbolInUnionSymbol x) = toJSON x

instance FromJSON UnionSymbol where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSymbol . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SymbolInUnionSymbol . parseJSON) xs

instance ToJSON Symbol where
    toJSON = \_ -> emptyObject

instance FromJSON Symbol where
    parseJSON (Object _) = return Symbol

instance ToJSON UnionSynchronized where
    toJSON (DoubleInUnionSynchronized x) = toJSON x
    toJSON (SynchronizedInUnionSynchronized x) = toJSON x

instance FromJSON UnionSynchronized where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSynchronized . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SynchronizedInUnionSynchronized . parseJSON) xs

instance ToJSON Synchronized where
    toJSON = \_ -> emptyObject

instance FromJSON Synchronized where
    parseJSON (Object _) = return Synchronized

instance ToJSON UnionSystem where
    toJSON (DoubleInUnionSystem x) = toJSON x
    toJSON (SystemInUnionSystem x) = toJSON x

instance FromJSON UnionSystem where
    parseJSON xs@(Number _) = (fmap DoubleInUnionSystem . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SystemInUnionSystem . parseJSON) xs

instance ToJSON System where
    toJSON = \_ -> emptyObject

instance FromJSON System where
    parseJSON (Object _) = return System

instance ToJSON UnionTemplate where
    toJSON (DoubleInUnionTemplate x) = toJSON x
    toJSON (TemplateInUnionTemplate x) = toJSON x

instance FromJSON UnionTemplate where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTemplate . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TemplateInUnionTemplate . parseJSON) xs

instance ToJSON Template where
    toJSON = \_ -> emptyObject

instance FromJSON Template where
    parseJSON (Object _) = return Template

instance ToJSON UnionTextNode where
    toJSON (DoubleInUnionTextNode x) = toJSON x
    toJSON (TextNodeInUnionTextNode x) = toJSON x

instance FromJSON UnionTextNode where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTextNode . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TextNodeInUnionTextNode . parseJSON) xs

instance ToJSON TextNode where
    toJSON = \_ -> emptyObject

instance FromJSON TextNode where
    parseJSON (Object _) = return TextNode

instance ToJSON UnionThis where
    toJSON (DoubleInUnionThis x) = toJSON x
    toJSON (ThisInUnionThis x) = toJSON x

instance FromJSON UnionThis where
    parseJSON xs@(Number _) = (fmap DoubleInUnionThis . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ThisInUnionThis . parseJSON) xs

instance ToJSON This where
    toJSON = \_ -> emptyObject

instance FromJSON This where
    parseJSON (Object _) = return This

instance ToJSON UnionThreadLocal where
    toJSON (DoubleInUnionThreadLocal x) = toJSON x
    toJSON (ThreadLocalInUnionThreadLocal x) = toJSON x

instance FromJSON UnionThreadLocal where
    parseJSON xs@(Number _) = (fmap DoubleInUnionThreadLocal . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ThreadLocalInUnionThreadLocal . parseJSON) xs

instance ToJSON ThreadLocal where
    toJSON = \_ -> emptyObject

instance FromJSON ThreadLocal where
    parseJSON (Object _) = return ThreadLocal

instance ToJSON UnionThrow where
    toJSON (DoubleInUnionThrow x) = toJSON x
    toJSON (ThrowInUnionThrow x) = toJSON x

instance FromJSON UnionThrow where
    parseJSON xs@(Number _) = (fmap DoubleInUnionThrow . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ThrowInUnionThrow . parseJSON) xs

instance ToJSON Throw where
    toJSON = \_ -> emptyObject

instance FromJSON Throw where
    parseJSON (Object _) = return Throw

instance ToJSON UnionThrows where
    toJSON (DoubleInUnionThrows x) = toJSON x
    toJSON (ThrowsInUnionThrows x) = toJSON x

instance FromJSON UnionThrows where
    parseJSON xs@(Number _) = (fmap DoubleInUnionThrows . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ThrowsInUnionThrows . parseJSON) xs

instance ToJSON Throws where
    toJSON = \_ -> emptyObject

instance FromJSON Throws where
    parseJSON (Object _) = return Throws

instance ToJSON UnionTimeOnly where
    toJSON (DoubleInUnionTimeOnly x) = toJSON x
    toJSON (TimeOnlyInUnionTimeOnly x) = toJSON x

instance FromJSON UnionTimeOnly where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTimeOnly . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TimeOnlyInUnionTimeOnly . parseJSON) xs

instance ToJSON TimeOnly where
    toJSON = \_ -> emptyObject

instance FromJSON TimeOnly where
    parseJSON (Object _) = return TimeOnly

instance ToJSON UnionTimeOnlyConverter where
    toJSON (DoubleInUnionTimeOnlyConverter x) = toJSON x
    toJSON (TimeOnlyConverterInUnionTimeOnlyConverter x) = toJSON x

instance FromJSON UnionTimeOnlyConverter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTimeOnlyConverter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TimeOnlyConverterInUnionTimeOnlyConverter . parseJSON) xs

instance ToJSON TimeOnlyConverter where
    toJSON = \_ -> emptyObject

instance FromJSON TimeOnlyConverter where
    parseJSON (Object _) = return TimeOnlyConverter

instance ToJSON UnionTimeZone where
    toJSON (DoubleInUnionTimeZone x) = toJSON x
    toJSON (TimeZoneInUnionTimeZone x) = toJSON x

instance FromJSON UnionTimeZone where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTimeZone . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TimeZoneInUnionTimeZone . parseJSON) xs

instance ToJSON TimeZone where
    toJSON = \_ -> emptyObject

instance FromJSON TimeZone where
    parseJSON (Object _) = return TimeZone

instance ToJSON UnionToDict where
    toJSON (DoubleInUnionToDict x) = toJSON x
    toJSON (ToDictInUnionToDict x) = toJSON x

instance FromJSON UnionToDict where
    parseJSON xs@(Number _) = (fmap DoubleInUnionToDict . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ToDictInUnionToDict . parseJSON) xs

instance ToJSON ToDict where
    toJSON = \_ -> emptyObject

instance FromJSON ToDict where
    parseJSON (Object _) = return ToDict

instance ToJSON UnionToJSON where
    toJSON (DoubleInUnionToJSON x) = toJSON x
    toJSON (ToJSONClassInUnionToJSON x) = toJSON x

instance FromJSON UnionToJSON where
    parseJSON xs@(Number _) = (fmap DoubleInUnionToJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ToJSONClassInUnionToJSON . parseJSON) xs

instance ToJSON ToJSONClass where
    toJSON = \_ -> emptyObject

instance FromJSON ToJSONClass where
    parseJSON (Object _) = return ToJSONClass

instance ToJSON UnionToString where
    toJSON (DoubleInUnionToString x) = toJSON x
    toJSON (ToStringInUnionToString x) = toJSON x

instance FromJSON UnionToString where
    parseJSON xs@(Number _) = (fmap DoubleInUnionToString . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ToStringInUnionToString . parseJSON) xs

instance ToJSON ToString where
    toJSON = \_ -> emptyObject

instance FromJSON ToString where
    parseJSON (Object _) = return ToString

instance ToJSON UnionTopLevel where
    toJSON (DoubleInUnionTopLevel x) = toJSON x
    toJSON (TopLevelInUnionTopLevel x) = toJSON x

instance FromJSON UnionTopLevel where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTopLevel . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TopLevelInUnionTopLevel . parseJSON) xs

instance ToJSON TopLevel where
    toJSON = \_ -> emptyObject

instance FromJSON TopLevel where
    parseJSON (Object _) = return TopLevel

instance ToJSON UnionTransient where
    toJSON (DoubleInUnionTransient x) = toJSON x
    toJSON (TransientInUnionTransient x) = toJSON x

instance FromJSON UnionTransient where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTransient . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TransientInUnionTransient . parseJSON) xs

instance ToJSON Transient where
    toJSON = \_ -> emptyObject

instance FromJSON Transient where
    parseJSON (Object _) = return Transient

instance ToJSON UnionTrue where
    toJSON (DoubleInUnionTrue x) = toJSON x
    toJSON (TrueClassInUnionTrue x) = toJSON x

instance FromJSON UnionTrue where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTrue . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TrueClassInUnionTrue . parseJSON) xs

instance ToJSON TrueClass where
    toJSON = \_ -> emptyObject

instance FromJSON TrueClass where
    parseJSON (Object _) = return TrueClass

instance ToJSON UnionTry where
    toJSON (DoubleInUnionTry x) = toJSON x
    toJSON (TryInUnionTry x) = toJSON x

instance FromJSON UnionTry where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTry . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TryInUnionTry . parseJSON) xs

instance ToJSON Try where
    toJSON = \_ -> emptyObject

instance FromJSON Try where
    parseJSON (Object _) = return Try

instance ToJSON UnionTypealias where
    toJSON (DoubleInUnionTypealias x) = toJSON x
    toJSON (TypealiasInUnionTypealias x) = toJSON x

instance FromJSON UnionTypealias where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypealias . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypealiasInUnionTypealias . parseJSON) xs

instance ToJSON Typealias where
    toJSON = \_ -> emptyObject

instance FromJSON Typealias where
    parseJSON (Object _) = return Typealias

instance ToJSON UnionTypedef where
    toJSON (DoubleInUnionTypedef x) = toJSON x
    toJSON (TypedefInUnionTypedef x) = toJSON x

instance FromJSON UnionTypedef where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypedef . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypedefInUnionTypedef . parseJSON) xs

instance ToJSON Typedef where
    toJSON = \_ -> emptyObject

instance FromJSON Typedef where
    parseJSON (Object _) = return Typedef

instance ToJSON UnionTypeid where
    toJSON (DoubleInUnionTypeid x) = toJSON x
    toJSON (TypeidInUnionTypeid x) = toJSON x

instance FromJSON UnionTypeid where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypeid . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypeidInUnionTypeid . parseJSON) xs

instance ToJSON Typeid where
    toJSON = \_ -> emptyObject

instance FromJSON Typeid where
    parseJSON (Object _) = return Typeid

instance ToJSON UnionTypename where
    toJSON (DoubleInUnionTypename x) = toJSON x
    toJSON (TypenameInUnionTypename x) = toJSON x

instance FromJSON UnionTypename where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypename . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypenameInUnionTypename . parseJSON) xs

instance ToJSON Typename where
    toJSON = \_ -> emptyObject

instance FromJSON Typename where
    parseJSON (Object _) = return Typename

instance ToJSON UnionTypeof where
    toJSON (DoubleInUnionTypeof x) = toJSON x
    toJSON (TypeofInUnionTypeof x) = toJSON x

instance FromJSON UnionTypeof where
    parseJSON xs@(Number _) = (fmap DoubleInUnionTypeof . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TypeofInUnionTypeof . parseJSON) xs

instance ToJSON Typeof where
    toJSON = \_ -> emptyObject

instance FromJSON Typeof where
    parseJSON (Object _) = return Typeof

instance ToJSON UnionUint where
    toJSON (DoubleInUnionUint x) = toJSON x
    toJSON (UintInUnionUint x) = toJSON x

instance FromJSON UnionUint where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUint . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UintInUnionUint . parseJSON) xs

instance ToJSON Uint where
    toJSON = \_ -> emptyObject

instance FromJSON Uint where
    parseJSON (Object _) = return Uint

instance ToJSON UnionUlong where
    toJSON (DoubleInUnionUlong x) = toJSON x
    toJSON (UlongInUnionUlong x) = toJSON x

instance FromJSON UnionUlong where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUlong . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UlongInUnionUlong . parseJSON) xs

instance ToJSON Ulong where
    toJSON = \_ -> emptyObject

instance FromJSON Ulong where
    parseJSON (Object _) = return Ulong

instance ToJSON UnionUnchecked where
    toJSON (DoubleInUnionUnchecked x) = toJSON x
    toJSON (UncheckedInUnionUnchecked x) = toJSON x

instance FromJSON UnionUnchecked where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnchecked . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UncheckedInUnionUnchecked . parseJSON) xs

instance ToJSON Unchecked where
    toJSON = \_ -> emptyObject

instance FromJSON Unchecked where
    parseJSON (Object _) = return Unchecked

instance ToJSON UnionUndefined where
    toJSON (DoubleInUnionUndefined x) = toJSON x
    toJSON (UndefinedInUnionUndefined x) = toJSON x

instance FromJSON UnionUndefined where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUndefined . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UndefinedInUnionUndefined . parseJSON) xs

instance ToJSON Undefined where
    toJSON = \_ -> emptyObject

instance FromJSON Undefined where
    parseJSON (Object _) = return Undefined

instance ToJSON UnionUnionUnion where
    toJSON (DoubleInUnionUnionUnion x) = toJSON x
    toJSON (UnionInUnionUnionUnion x) = toJSON x

instance FromJSON UnionUnionUnion where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnionUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionInUnionUnionUnion . parseJSON) xs

instance ToJSON Union where
    toJSON = \_ -> emptyObject

instance FromJSON Union where
    parseJSON (Object _) = return Union

instance ToJSON UnionUnmarshalJSON where
    toJSON (DoubleInUnionUnmarshalJSON x) = toJSON x
    toJSON (UnmarshalJSONInUnionUnmarshalJSON x) = toJSON x

instance FromJSON UnionUnmarshalJSON where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnmarshalJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnmarshalJSONInUnionUnmarshalJSON . parseJSON) xs

instance ToJSON UnmarshalJSON where
    toJSON = \_ -> emptyObject

instance FromJSON UnmarshalJSON where
    parseJSON (Object _) = return UnmarshalJSON

instance ToJSON UnionUnowned where
    toJSON (DoubleInUnionUnowned x) = toJSON x
    toJSON (UnownedInUnionUnowned x) = toJSON x

instance FromJSON UnionUnowned where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnowned . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnownedInUnionUnowned . parseJSON) xs

instance ToJSON Unowned where
    toJSON = \_ -> emptyObject

instance FromJSON Unowned where
    parseJSON (Object _) = return Unowned

instance ToJSON UnionUnsafe where
    toJSON (DoubleInUnionUnsafe x) = toJSON x
    toJSON (UnsafeInUnionUnsafe x) = toJSON x

instance FromJSON UnionUnsafe where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnsafe . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnsafeInUnionUnsafe . parseJSON) xs

instance ToJSON Unsafe where
    toJSON = \_ -> emptyObject

instance FromJSON Unsafe where
    parseJSON (Object _) = return Unsafe

instance ToJSON UnionUnsigned where
    toJSON (DoubleInUnionUnsigned x) = toJSON x
    toJSON (UnsignedInUnionUnsigned x) = toJSON x

instance FromJSON UnionUnsigned where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUnsigned . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnsignedInUnionUnsigned . parseJSON) xs

instance ToJSON Unsigned where
    toJSON = \_ -> emptyObject

instance FromJSON Unsigned where
    parseJSON (Object _) = return Unsigned

instance ToJSON UnionUseSerializers where
    toJSON (DoubleInUnionUseSerializers x) = toJSON x
    toJSON (UseSerializersInUnionUseSerializers x) = toJSON x

instance FromJSON UnionUseSerializers where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUseSerializers . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UseSerializersInUnionUseSerializers . parseJSON) xs

instance ToJSON UseSerializers where
    toJSON = \_ -> emptyObject

instance FromJSON UseSerializers where
    parseJSON (Object _) = return UseSerializers

instance ToJSON UnionUshort where
    toJSON (DoubleInUnionUshort x) = toJSON x
    toJSON (UshortInUnionUshort x) = toJSON x

instance FromJSON UnionUshort where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUshort . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UshortInUnionUshort . parseJSON) xs

instance ToJSON Ushort where
    toJSON = \_ -> emptyObject

instance FromJSON Ushort where
    parseJSON (Object _) = return Ushort

instance ToJSON UnionUsing where
    toJSON (DoubleInUnionUsing x) = toJSON x
    toJSON (UsingInUnionUsing x) = toJSON x

instance FromJSON UnionUsing where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUsing . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UsingInUnionUsing . parseJSON) xs

instance ToJSON Using where
    toJSON = \_ -> emptyObject

instance FromJSON Using where
    parseJSON (Object _) = return Using

instance ToJSON UnionUtf8JSONReader where
    toJSON (DoubleInUnionUtf8JSONReader x) = toJSON x
    toJSON (Utf8JSONReaderInUnionUtf8JSONReader x) = toJSON x

instance FromJSON UnionUtf8JSONReader where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUtf8JSONReader . parseJSON) xs
    parseJSON xs@(Object _) = (fmap Utf8JSONReaderInUnionUtf8JSONReader . parseJSON) xs

instance ToJSON Utf8JSONReader where
    toJSON = \_ -> emptyObject

instance FromJSON Utf8JSONReader where
    parseJSON (Object _) = return Utf8JSONReader

instance ToJSON UnionUtf8JSONWriter where
    toJSON (DoubleInUnionUtf8JSONWriter x) = toJSON x
    toJSON (Utf8JSONWriterInUnionUtf8JSONWriter x) = toJSON x

instance FromJSON UnionUtf8JSONWriter where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUtf8JSONWriter . parseJSON) xs
    parseJSON xs@(Object _) = (fmap Utf8JSONWriterInUnionUtf8JSONWriter . parseJSON) xs

instance ToJSON Utf8JSONWriter where
    toJSON = \_ -> emptyObject

instance FromJSON Utf8JSONWriter where
    parseJSON (Object _) = return Utf8JSONWriter

instance ToJSON UnionUUID where
    toJSON (DoubleInUnionUUID x) = toJSON x
    toJSON (UUIDInUnionUUID x) = toJSON x

instance FromJSON UnionUUID where
    parseJSON xs@(Number _) = (fmap DoubleInUnionUUID . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UUIDInUnionUUID . parseJSON) xs

instance ToJSON UUID where
    toJSON = \_ -> emptyObject

instance FromJSON UUID where
    parseJSON (Object _) = return UUID

instance ToJSON UnionVar where
    toJSON (DoubleInUnionVar x) = toJSON x
    toJSON (VarInUnionVar x) = toJSON x

instance FromJSON UnionVar where
    parseJSON xs@(Number _) = (fmap DoubleInUnionVar . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VarInUnionVar . parseJSON) xs

instance ToJSON Var where
    toJSON = \_ -> emptyObject

instance FromJSON Var where
    parseJSON (Object _) = return Var

instance ToJSON UnionVirtual where
    toJSON (DoubleInUnionVirtual x) = toJSON x
    toJSON (VirtualInUnionVirtual x) = toJSON x

instance FromJSON UnionVirtual where
    parseJSON xs@(Number _) = (fmap DoubleInUnionVirtual . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VirtualInUnionVirtual . parseJSON) xs

instance ToJSON Virtual where
    toJSON = \_ -> emptyObject

instance FromJSON Virtual where
    parseJSON (Object _) = return Virtual

instance ToJSON UnionVoid where
    toJSON (DoubleInUnionVoid x) = toJSON x
    toJSON (VoidInUnionVoid x) = toJSON x

instance FromJSON UnionVoid where
    parseJSON xs@(Number _) = (fmap DoubleInUnionVoid . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VoidInUnionVoid . parseJSON) xs

instance ToJSON Void where
    toJSON = \_ -> emptyObject

instance FromJSON Void where
    parseJSON (Object _) = return Void

instance ToJSON UnionVolatile where
    toJSON (DoubleInUnionVolatile x) = toJSON x
    toJSON (VolatileInUnionVolatile x) = toJSON x

instance FromJSON UnionVolatile where
    parseJSON xs@(Number _) = (fmap DoubleInUnionVolatile . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VolatileInUnionVolatile . parseJSON) xs

instance ToJSON Volatile where
    toJSON = \_ -> emptyObject

instance FromJSON Volatile where
    parseJSON (Object _) = return Volatile

instance ToJSON UnionWcharT where
    toJSON (DoubleInUnionWcharT x) = toJSON x
    toJSON (WcharTInUnionWcharT x) = toJSON x

instance FromJSON UnionWcharT where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWcharT . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WcharTInUnionWcharT . parseJSON) xs

instance ToJSON WcharT where
    toJSON = \_ -> emptyObject

instance FromJSON WcharT where
    parseJSON (Object _) = return WcharT

instance ToJSON UnionWeak where
    toJSON (DoubleInUnionWeak x) = toJSON x
    toJSON (WeakInUnionWeak x) = toJSON x

instance FromJSON UnionWeak where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWeak . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WeakInUnionWeak . parseJSON) xs

instance ToJSON Weak where
    toJSON = \_ -> emptyObject

instance FromJSON Weak where
    parseJSON (Object _) = return Weak

instance ToJSON UnionWhile where
    toJSON (DoubleInUnionWhile x) = toJSON x
    toJSON (WhileInUnionWhile x) = toJSON x

instance FromJSON UnionWhile where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWhile . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WhileInUnionWhile . parseJSON) xs

instance ToJSON While where
    toJSON = \_ -> emptyObject

instance FromJSON While where
    parseJSON (Object _) = return While

instance ToJSON UnionWillSet where
    toJSON (DoubleInUnionWillSet x) = toJSON x
    toJSON (WillSetInUnionWillSet x) = toJSON x

instance FromJSON UnionWillSet where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWillSet . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WillSetInUnionWillSet . parseJSON) xs

instance ToJSON WillSet where
    toJSON = \_ -> emptyObject

instance FromJSON WillSet where
    parseJSON (Object _) = return WillSet

instance ToJSON UnionWith where
    toJSON (DoubleInUnionWith x) = toJSON x
    toJSON (WithInUnionWith x) = toJSON x

instance FromJSON UnionWith where
    parseJSON xs@(Number _) = (fmap DoubleInUnionWith . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WithInUnionWith . parseJSON) xs

instance ToJSON With where
    toJSON = \_ -> emptyObject

instance FromJSON With where
    parseJSON (Object _) = return With

instance ToJSON UnionXor where
    toJSON (DoubleInUnionXor x) = toJSON x
    toJSON (XorInUnionXor x) = toJSON x

instance FromJSON UnionXor where
    parseJSON xs@(Number _) = (fmap DoubleInUnionXor . parseJSON) xs
    parseJSON xs@(Object _) = (fmap XorInUnionXor . parseJSON) xs

instance ToJSON Xor where
    toJSON = \_ -> emptyObject

instance FromJSON Xor where
    parseJSON (Object _) = return Xor

instance ToJSON UnionXorEq where
    toJSON (DoubleInUnionXorEq x) = toJSON x
    toJSON (XorEqInUnionXorEq x) = toJSON x

instance FromJSON UnionXorEq where
    parseJSON xs@(Number _) = (fmap DoubleInUnionXorEq . parseJSON) xs
    parseJSON xs@(Object _) = (fmap XorEqInUnionXorEq . parseJSON) xs

instance ToJSON XorEq where
    toJSON = \_ -> emptyObject

instance FromJSON XorEq where
    parseJSON (Object _) = return XorEq

instance ToJSON UnionYES where
    toJSON (DoubleInUnionYES x) = toJSON x
    toJSON (YesInUnionYES x) = toJSON x

instance FromJSON UnionYES where
    parseJSON xs@(Number _) = (fmap DoubleInUnionYES . parseJSON) xs
    parseJSON xs@(Object _) = (fmap YesInUnionYES . parseJSON) xs

instance ToJSON Yes where
    toJSON = \_ -> emptyObject

instance FromJSON Yes where
    parseJSON (Object _) = return Yes

instance ToJSON UnionYield where
    toJSON (DoubleInUnionYield x) = toJSON x
    toJSON (YieldInUnionYield x) = toJSON x

instance FromJSON UnionYield where
    parseJSON xs@(Number _) = (fmap DoubleInUnionYield . parseJSON) xs
    parseJSON xs@(Object _) = (fmap YieldInUnionYield . parseJSON) xs

instance ToJSON Yield where
    toJSON = \_ -> emptyObject

instance FromJSON Yield where
    parseJSON (Object _) = return Yield
