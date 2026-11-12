{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Obj1 (..)
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
    , Empty (..)
    , Imaginery (..)
    , AnyClass (..)
    , As (..)
    , BoolClass (..)
    , Case (..)
    , Class (..)
    , Obj1Bool (..)
    , ClassClass (..)
    , Obj2 (..)
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
    , Default (..)
    , Do (..)
    , Else (..)
    , Obj2False (..)
    , Obj3 (..)
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
    , ID (..)
    , If (..)
    , Import (..)
    , In (..)
    , Infix (..)
    , Let (..)
    , Module (..)
    , Obj4 (..)
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
    , NoneClass (..)
    , NullClass (..)
    , Of (..)
    , ProtocolClass (..)
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
    , Print (..)
    , PrintMembers (..)
    , Printf (..)
    , Private (..)
    , Protected (..)
    , Protocol (..)
    , Public (..)
    , Quicktype (..)
    , Raise (..)
    , Range (..)
    , Readonly (..)
    , Ref (..)
    , RegExp (..)
    , Register (..)
    , ReinterpretCast (..)
    , Obj5 (..)
    , KSerializer (..)
    , SelfClass (..)
    , Then (..)
    , Obj5True (..)
    , PrimitiveKind (..)
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
    , Obj6 (..)
    , Type (..)
    , Where (..)
    , TypeClass (..)
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
    , EnumValue (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { dummyQuickType :: Int
    , obj1QuickType :: Obj1
    , obj2QuickType :: Obj2
    , obj3QuickType :: Obj3
    , obj4QuickType :: Obj4
    , obj5QuickType :: Obj5
    , obj6QuickType :: Obj6
    } deriving (Show)

data Obj1 = Obj1
    { abstractObj1 :: Abstract
    , alignasObj1 :: Alignas
    , alignofObj1 :: Alignof
    , andObj1 :: And
    , andEqObj1 :: AndEq
    , anyObj1 :: Any
    , arrayObj1 :: ArrayClass
    , arrayNodeObj1 :: ArrayNode
    , asmObj1 :: ASM
    , assertObj1 :: Assert
    , associatedtypeObj1 :: Associatedtype
    , associativityObj1 :: Associativity
    , asyncObj1 :: Async
    , atomicObj1 :: Atomic
    , atomicCancelObj1 :: AtomicCancel
    , atomicCommitObj1 :: AtomicCommit
    , atomicNoexceptObj1 :: AtomicNoexcept
    , autoObj1 :: Auto
    , awaitObj1 :: Await
    , baseObj1 :: Base
    , bitandObj1 :: Bitand
    , bitorObj1 :: Bitor
    , boolObj1 :: BOOLClass
    , booleanObj1 :: Boolean
    , booleanNodeObj1 :: BooleanNode
    , breakObj1 :: Break
    , bycopyObj1 :: Bycopy
    , byrefObj1 :: Byref
    , byteObj1 :: Byte
    , calendarObj1 :: Calendar
    , catchObj1 :: Catch
    , chanObj1 :: Chan
    , charObj1 :: CharClass
    , char16TObj1 :: Char16T
    , char32TObj1 :: Char32T
    , checkedObj1 :: Checked
    , cloneObj1 :: Clone
    , coAwaitObj1 :: CoAwait
    , coReturnObj1 :: CoReturn
    , coYieldObj1 :: CoYield
    , codableObj1 :: Codable
    , codingKeyObj1 :: CodingKey
    , codingKeysObj1 :: CodingKeys
    , complObj1 :: Compl
    , complexObj1 :: Complex
    , conceptObj1 :: Concept
    , consoleObj1 :: Console
    , constObj1 :: Const
    , constCastObj1 :: ConstCast
    , constexprObj1 :: Constexpr
    , constructorObj1 :: Constructor
    , continueObj1 :: Continue
    , convenienceObj1 :: Convenience
    , convertObj1 :: Convert
    , converterObj1 :: Converter
    , dummyObj1 :: Int
    , emptyObj1 :: Empty
    , imagineryObj1 :: Imaginery
    , obj1AnyObj1 :: AnyClass
    , obj1AsObj1 :: As
    , obj1BoolObj1 :: BoolClass
    , obj1CaseObj1 :: Case
    , obj1ClassObj1 :: Class
    , purpleBoolObj1 :: Obj1Bool
    , purpleClassObj1 :: ClassClass
    } deriving (Show)

data Abstract = Abstract
    { abstractAbstract :: Int
    } deriving (Show)

data Alignas = Alignas
    { alignasAlignas :: Int
    } deriving (Show)

data Alignof = Alignof
    { alignofAlignof :: Int
    } deriving (Show)

data And = And
    { andAnd :: Int
    } deriving (Show)

data AndEq = AndEq
    { andEqAndEq :: Int
    } deriving (Show)

data Any = Any
    { anyAny :: Int
    } deriving (Show)

data ArrayClass = ArrayClass
    { arrayArrayClass :: Int
    } deriving (Show)

data ArrayNode = ArrayNode
    { arrayNodeArrayNode :: Int
    } deriving (Show)

data ASM = ASM
    { asmASM :: Int
    } deriving (Show)

data Assert = Assert
    { assertAssert :: Int
    } deriving (Show)

data Associatedtype = Associatedtype
    { associatedtypeAssociatedtype :: Int
    } deriving (Show)

data Associativity = Associativity
    { associativityAssociativity :: Int
    } deriving (Show)

data Async = Async
    { asyncAsync :: Int
    } deriving (Show)

data Atomic = Atomic
    { atomicAtomic :: Int
    } deriving (Show)

data AtomicCancel = AtomicCancel
    { atomicCancelAtomicCancel :: Int
    } deriving (Show)

data AtomicCommit = AtomicCommit
    { atomicCommitAtomicCommit :: Int
    } deriving (Show)

data AtomicNoexcept = AtomicNoexcept
    { atomicNoexceptAtomicNoexcept :: Int
    } deriving (Show)

data Auto = Auto
    { autoAuto :: Int
    } deriving (Show)

data Await = Await
    { awaitAwait :: Int
    } deriving (Show)

data Base = Base
    { baseBase :: Int
    } deriving (Show)

data Bitand = Bitand
    { bitandBitand :: Int
    } deriving (Show)

data Bitor = Bitor
    { bitorBitor :: Int
    } deriving (Show)

data BOOLClass = BOOLClass
    { boolBOOLClass :: Int
    } deriving (Show)

data Boolean = Boolean
    { booleanBoolean :: Int
    } deriving (Show)

data BooleanNode = BooleanNode
    { booleanNodeBooleanNode :: Int
    } deriving (Show)

data Break = Break
    { breakBreak :: Int
    } deriving (Show)

data Bycopy = Bycopy
    { bycopyBycopy :: Int
    } deriving (Show)

data Byref = Byref
    { byrefByref :: Int
    } deriving (Show)

data Byte = Byte
    { byteByte :: Int
    } deriving (Show)

data Calendar = Calendar
    { calendarCalendar :: Int
    } deriving (Show)

data Catch = Catch
    { catchCatch :: Int
    } deriving (Show)

data Chan = Chan
    { chanChan :: Int
    } deriving (Show)

data CharClass = CharClass
    { charCharClass :: Int
    } deriving (Show)

data Char16T = Char16T
    { char16TChar16T :: Int
    } deriving (Show)

data Char32T = Char32T
    { char32TChar32T :: Int
    } deriving (Show)

data Checked = Checked
    { checkedChecked :: Int
    } deriving (Show)

data Clone = Clone
    { cloneClone :: Int
    } deriving (Show)

data CoAwait = CoAwait
    { coAwaitCoAwait :: Int
    } deriving (Show)

data CoReturn = CoReturn
    { coReturnCoReturn :: Int
    } deriving (Show)

data CoYield = CoYield
    { coYieldCoYield :: Int
    } deriving (Show)

data Codable = Codable
    { codableCodable :: Int
    } deriving (Show)

data CodingKey = CodingKey
    { codingKeyCodingKey :: Int
    } deriving (Show)

data CodingKeys = CodingKeys
    { codingKeysCodingKeys :: Int
    } deriving (Show)

data Compl = Compl
    { complCompl :: Int
    } deriving (Show)

data Complex = Complex
    { complexComplex :: Int
    } deriving (Show)

data Concept = Concept
    { conceptConcept :: Int
    } deriving (Show)

data Console = Console
    { consoleConsole :: Int
    } deriving (Show)

data Const = Const
    { constConst :: Int
    } deriving (Show)

data ConstCast = ConstCast
    { constCastConstCast :: Int
    } deriving (Show)

data Constexpr = Constexpr
    { constexprConstexpr :: Int
    } deriving (Show)

data Constructor = Constructor
    { constructorConstructor :: Int
    } deriving (Show)

data Continue = Continue
    { continueContinue :: Int
    } deriving (Show)

data Convenience = Convenience
    { convenienceConvenience :: Int
    } deriving (Show)

data Convert = Convert
    { convertConvert :: Int
    } deriving (Show)

data Converter = Converter
    { converterConverter :: Int
    } deriving (Show)

data Empty = Empty
    { emptyEmpty :: Int
    } deriving (Show)

data Imaginery = Imaginery
    { imagineryImaginery :: Int
    } deriving (Show)

data AnyClass = AnyClass
    { anyAnyClass :: Int
    } deriving (Show)

data As = As
    { asAsAs :: Int
    } deriving (Show)

data BoolClass = BoolClass
    { boolBoolClass :: Int
    } deriving (Show)

data Case = Case
    { caseCaseCase :: Int
    } deriving (Show)

data Class = Class
    { classClassClass :: Int
    } deriving (Show)

data Obj1Bool = Obj1Bool
    { boolObj1Bool :: Int
    } deriving (Show)

data ClassClass = ClassClass
    { classClassClassClass :: Int
    } deriving (Show)

data Obj2 = Obj2
    { cultureInfoObj2 :: CultureInfo
    , dateObj2 :: Date
    , dateFormatterObj2 :: DateFormatter
    , dateOnlyObj2 :: DateOnly
    , dateOnlyConverterObj2 :: DateOnlyConverter
    , dateParseHandlingObj2 :: DateParseHandling
    , dateTimeObj2 :: DateTime
    , dateTimeStylesObj2 :: DateTimeStyles
    , debuggerObj2 :: Debugger
    , decimalObj2 :: Decimal
    , declareObj2 :: Declare
    , decltypeObj2 :: Decltype
    , decodeStringObj2 :: DecodeString
    , decoderObj2 :: Decoder
    , decodingErrorObj2 :: DecodingError
    , defObj2 :: Def
    , deferObj2 :: Defer
    , deinitObj2 :: Deinit
    , delObj2 :: Del
    , delegateObj2 :: Delegate
    , deleteObj2 :: Delete
    , deserializationFeatureObj2 :: DeserializationFeature
    , dictObj2 :: Dict
    , dictionaryObj2 :: Dictionary
    , didSetObj2 :: DidSet
    , doubleObj2 :: DoubleClass
    , doubleNodeObj2 :: DoubleNode
    , dummyObj2 :: Int
    , dynamicObj2 :: Dynamic
    , dynamicCastObj2 :: DynamicCast
    , elifObj2 :: Elif
    , encodeQuickTypeObj2 :: EncodeQuickType
    , encoderObj2 :: Encoder
    , enumObj2 :: EnumClass
    , enumValuesObj2 :: EnumValues
    , equalityContractObj2 :: EqualityContract
    , equatableObj2 :: Equatable
    , eventObj2 :: Event
    , exceptObj2 :: Except
    , exceptionObj2 :: Exception
    , explicitObj2 :: Explicit
    , exportObj2 :: Export
    , exposingObj2 :: Exposing
    , extendsObj2 :: Extends
    , extensionObj2 :: Extension
    , externObj2 :: Extern
    , fallthroughObj2 :: Fallthrough
    , falseObj2 :: FalseClass
    , fileprivateObj2 :: Fileprivate
    , finalObj2 :: Final
    , finallyObj2 :: Finally
    , fixedObj2 :: Fixed
    , floatObj2 :: FloatClass
    , forObj2 :: For
    , foreachObj2 :: Foreach
    , formatExceptionObj2 :: FormatException
    , friendObj2 :: Friend
    , fromObj2 :: From
    , fromDictObj2 :: FromDict
    , fromJSONObj2 :: FromJSONClass
    , funcObj2 :: Func
    , obj2DefaultObj2 :: Default
    , obj2DoObj2 :: Do
    , obj2ElseObj2 :: Else
    , obj2FalseObj2 :: Obj2False
    } deriving (Show)

data CultureInfo = CultureInfo
    { cultureInfoCultureInfo :: Int
    } deriving (Show)

data Date = Date
    { dateDate :: Int
    } deriving (Show)

data DateFormatter = DateFormatter
    { dateFormatterDateFormatter :: Int
    } deriving (Show)

data DateOnly = DateOnly
    { dateOnlyDateOnly :: Int
    } deriving (Show)

data DateOnlyConverter = DateOnlyConverter
    { dateOnlyConverterDateOnlyConverter :: Int
    } deriving (Show)

data DateParseHandling = DateParseHandling
    { dateParseHandlingDateParseHandling :: Int
    } deriving (Show)

data DateTime = DateTime
    { dateTimeDateTime :: Text
    } deriving (Show)

data DateTimeStyles = DateTimeStyles
    { dateTimeStylesDateTimeStyles :: Int
    } deriving (Show)

data Debugger = Debugger
    { debuggerDebugger :: Int
    } deriving (Show)

data Decimal = Decimal
    { decimalDecimal :: Int
    } deriving (Show)

data Declare = Declare
    { declareDeclare :: Int
    } deriving (Show)

data Decltype = Decltype
    { decltypeDecltype :: Int
    } deriving (Show)

data DecodeString = DecodeString
    { decodeStringDecodeString :: Int
    } deriving (Show)

data Decoder = Decoder
    { decoderDecoder :: Int
    } deriving (Show)

data DecodingError = DecodingError
    { decodingErrorDecodingError :: Int
    } deriving (Show)

data Def = Def
    { defDef :: Int
    } deriving (Show)

data Defer = Defer
    { deferDefer :: Int
    } deriving (Show)

data Deinit = Deinit
    { deinitDeinit :: Int
    } deriving (Show)

data Del = Del
    { delDel :: Int
    } deriving (Show)

data Delegate = Delegate
    { delegateDelegate :: Int
    } deriving (Show)

data Delete = Delete
    { deleteDelete :: Int
    } deriving (Show)

data DeserializationFeature = DeserializationFeature
    { deserializationFeatureDeserializationFeature :: Int
    } deriving (Show)

data Dict = Dict
    { dictDict :: Int
    } deriving (Show)

data Dictionary = Dictionary
    { dictionaryDictionary :: Int
    } deriving (Show)

data DidSet = DidSet
    { didSetDidSet :: Int
    } deriving (Show)

data DoubleClass = DoubleClass
    { doubleDoubleClass :: Int
    } deriving (Show)

data DoubleNode = DoubleNode
    { doubleNodeDoubleNode :: Int
    } deriving (Show)

data Dynamic = Dynamic
    { dynamicDynamic :: Int
    } deriving (Show)

data DynamicCast = DynamicCast
    { dynamicCastDynamicCast :: Int
    } deriving (Show)

data Elif = Elif
    { elifElif :: Int
    } deriving (Show)

data EncodeQuickType = EncodeQuickType
    { encodeQuickTypeEncodeQuickType :: Int
    } deriving (Show)

data Encoder = Encoder
    { encoderEncoder :: Int
    } deriving (Show)

data EnumClass = EnumClass
    { enumEnumClass :: Int
    } deriving (Show)

data EnumValues = EnumValues
    { enumValuesEnumValues :: [EnumValue]
    } deriving (Show)

data EnumValue
    = ReadyEnumValue
    | DoneEnumValue
    deriving (Show)

data EqualityContract = EqualityContract
    { equalityContractEqualityContract :: Int
    } deriving (Show)

data Equatable = Equatable
    { equatableEquatable :: Int
    } deriving (Show)

data Event = Event
    { eventEvent :: Int
    } deriving (Show)

data Except = Except
    { exceptExcept :: Int
    } deriving (Show)

data Exception = Exception
    { exceptionException :: Int
    } deriving (Show)

data Explicit = Explicit
    { explicitExplicit :: Int
    } deriving (Show)

data Export = Export
    { exportExport :: Int
    } deriving (Show)

data Exposing = Exposing
    { exposingExposing :: Int
    } deriving (Show)

data Extends = Extends
    { extendsExtends :: Int
    } deriving (Show)

data Extension = Extension
    { extensionExtension :: Int
    } deriving (Show)

data Extern = Extern
    { externExtern :: Int
    } deriving (Show)

data Fallthrough = Fallthrough
    { fallthroughFallthrough :: Int
    } deriving (Show)

data FalseClass = FalseClass
    { falseFalseClass :: Int
    } deriving (Show)

data Fileprivate = Fileprivate
    { fileprivateFileprivate :: Int
    } deriving (Show)

data Final = Final
    { finalFinal :: Int
    } deriving (Show)

data Finally = Finally
    { finallyFinally :: Int
    } deriving (Show)

data Fixed = Fixed
    { fixedFixed :: Int
    } deriving (Show)

data FloatClass = FloatClass
    { floatFloatClass :: Int
    } deriving (Show)

data For = For
    { forFor :: Int
    } deriving (Show)

data Foreach = Foreach
    { foreachForeach :: Int
    } deriving (Show)

data FormatException = FormatException
    { formatExceptionFormatException :: Int
    } deriving (Show)

data Friend = Friend
    { friendFriend :: Int
    } deriving (Show)

data From = From
    { fromFrom :: Int
    } deriving (Show)

data FromDict = FromDict
    { fromDictFromDict :: Int
    } deriving (Show)

data FromJSONClass = FromJSONClass
    { fromJSONFromJSONClass :: Int
    } deriving (Show)

data Func = Func
    { funcFunc :: Int
    } deriving (Show)

data Default = Default
    { defaultDefaultDefault :: Int
    } deriving (Show)

data Do = Do
    { doDoDo :: Int
    } deriving (Show)

data Else = Else
    { elseElseElse :: Int
    } deriving (Show)

data Obj2False = Obj2False
    { falseObj2False :: Int
    } deriving (Show)

data Obj3 = Obj3
    { dummyObj3 :: Int
    , functionObj3 :: Function
    , getObj3 :: Get
    , globalObj3 :: Global
    , goObj3 :: Go
    , gotoObj3 :: Goto
    , guardObj3 :: Guard
    , hasOwnPropertyObj3 :: HasOwnProperty
    , hashCodeObj3 :: HashCode
    , hashableObj3 :: Hashable
    , hasherObj3 :: Hasher
    , impObj3 :: Imp
    , implementsObj3 :: Implements
    , implicitObj3 :: Implicit
    , indirectObj3 :: Indirect
    , initObj3 :: Init
    , inlineObj3 :: Inline
    , inoutObj3 :: Inout
    , instanceofObj3 :: Instanceof
    , intObj3 :: IntClass
    , intNodeObj3 :: IntNode
    , interfaceObj3 :: Interface
    , internalObj3 :: Internal
    , isObj3 :: Is
    , isoDateTimeOffsetConverterObj3 :: ISODateTimeOffsetConverter
    , iterableObj3 :: Iterable
    , jdecObj3 :: Jdec
    , jencObj3 :: Jenc
    , jpipeObj3 :: Jpipe
    , jsonObj3 :: JSON
    , jsonAnyObj3 :: JSONAny
    , jsonCodingKeyObj3 :: JSONCodingKey
    , jsonConverterObj3 :: JSONConverter
    , jsonDecoderObj3 :: JSONDecoder
    , jsonEncoderObj3 :: JSONEncoder
    , jsonExceptionObj3 :: JSONException
    , jsonGeneratorObj3 :: JSONGenerator
    , jsonNodeObj3 :: JSONNode
    , jsonNullObj3 :: JSONNull
    , jsonParserObj3 :: JSONParser
    , jsonReaderObj3 :: JSONReader
    , jsonSerializerObj3 :: JSONSerializer
    , jsonTokenObj3 :: JSONToken
    , jsonTokenTypeObj3 :: JSONTokenType
    , jsonWriterObj3 :: JSONWriter
    , lambdaObj3 :: Lambda
    , lazyObj3 :: Lazy
    , leftObj3 :: LeftClass
    , listObj3 :: List
    , localDateObj3 :: LocalDate
    , localeObj3 :: Locale
    , lockObj3 :: Lock
    , longObj3 :: Long
    , longNodeObj3 :: LongNode
    , mapObj3 :: MapClass
    , mapEntryObj3 :: MapEntry
    , marshalJSONObj3 :: MarshalJSON
    , metadataPropertyHandlingObj3 :: MetadataPropertyHandling
    , obj3IDObj3 :: ID
    , obj3IfObj3 :: If
    , obj3ImportObj3 :: Import
    , obj3InObj3 :: In
    , obj3InfixObj3 :: Infix
    , obj3LetObj3 :: Let
    , obj3ModuleObj3 :: Module
    } deriving (Show)

data Function = Function
    { functionFunction :: Int
    } deriving (Show)

data Get = Get
    { getGet :: Int
    } deriving (Show)

data Global = Global
    { globalGlobal :: Int
    } deriving (Show)

data Go = Go
    { goGo :: Int
    } deriving (Show)

data Goto = Goto
    { gotoGoto :: Int
    } deriving (Show)

data Guard = Guard
    { guardGuard :: Int
    } deriving (Show)

data HasOwnProperty = HasOwnProperty
    { hasOwnPropertyHasOwnProperty :: Int
    } deriving (Show)

data HashCode = HashCode
    { hashCodeHashCode :: Int
    } deriving (Show)

data Hashable = Hashable
    { hashableHashable :: Int
    } deriving (Show)

data Hasher = Hasher
    { hasherHasher :: Int
    } deriving (Show)

data Imp = Imp
    { impImp :: Int
    } deriving (Show)

data Implements = Implements
    { implementsImplements :: Int
    } deriving (Show)

data Implicit = Implicit
    { implicitImplicit :: Int
    } deriving (Show)

data Indirect = Indirect
    { indirectIndirect :: Int
    } deriving (Show)

data Init = Init
    { initInit :: Int
    } deriving (Show)

data Inline = Inline
    { inlineInline :: Int
    } deriving (Show)

data Inout = Inout
    { inoutInout :: Int
    } deriving (Show)

data Instanceof = Instanceof
    { instanceofInstanceof :: Int
    } deriving (Show)

data IntClass = IntClass
    { intIntClass :: Int
    } deriving (Show)

data IntNode = IntNode
    { intNodeIntNode :: Int
    } deriving (Show)

data Interface = Interface
    { interfaceInterface :: Int
    } deriving (Show)

data Internal = Internal
    { internalInternal :: Int
    } deriving (Show)

data Is = Is
    { isIs :: Int
    } deriving (Show)

data ISODateTimeOffsetConverter = ISODateTimeOffsetConverter
    { isoDateTimeOffsetConverterISODateTimeOffsetConverter :: Int
    } deriving (Show)

data Iterable = Iterable
    { iterableIterable :: Int
    } deriving (Show)

data Jdec = Jdec
    { jdecJdec :: Int
    } deriving (Show)

data Jenc = Jenc
    { jencJenc :: Int
    } deriving (Show)

data Jpipe = Jpipe
    { jpipeJpipe :: Int
    } deriving (Show)

data JSON = JSON
    { jsonJSON :: Int
    } deriving (Show)

data JSONAny = JSONAny
    { jsonAnyJSONAny :: Maybe Text
    } deriving (Show)

data JSONCodingKey = JSONCodingKey
    { jsonCodingKeyJSONCodingKey :: Int
    } deriving (Show)

data JSONConverter = JSONConverter
    { jsonConverterJSONConverter :: Int
    } deriving (Show)

data JSONDecoder = JSONDecoder
    { jsonDecoderJSONDecoder :: Int
    } deriving (Show)

data JSONEncoder = JSONEncoder
    { jsonEncoderJSONEncoder :: Int
    } deriving (Show)

data JSONException = JSONException
    { jsonExceptionJSONException :: Int
    } deriving (Show)

data JSONGenerator = JSONGenerator
    { jsonGeneratorJSONGenerator :: Int
    } deriving (Show)

data JSONNode = JSONNode
    { jsonNodeJSONNode :: Int
    } deriving (Show)

data JSONNull = JSONNull
    { jsonNullJSONNull :: Int
    } deriving (Show)

data JSONParser = JSONParser
    { jsonParserJSONParser :: Int
    } deriving (Show)

data JSONReader = JSONReader
    { jsonReaderJSONReader :: Int
    } deriving (Show)

data JSONSerializer = JSONSerializer
    { jsonSerializerJSONSerializer :: Int
    } deriving (Show)

data JSONToken = JSONToken
    { jsonTokenJSONToken :: Int
    } deriving (Show)

data JSONTokenType = JSONTokenType
    { jsonTokenTypeJSONTokenType :: Int
    } deriving (Show)

data JSONWriter = JSONWriter
    { jsonWriterJSONWriter :: Int
    } deriving (Show)

data Lambda = Lambda
    { lambdaLambda :: Int
    } deriving (Show)

data Lazy = Lazy
    { lazyLazy :: Int
    } deriving (Show)

data LeftClass = LeftClass
    { leftLeftClass :: Int
    } deriving (Show)

data List = List
    { listList :: Int
    } deriving (Show)

data LocalDate = LocalDate
    { localDateLocalDate :: Int
    } deriving (Show)

data Locale = Locale
    { localeLocale :: Int
    } deriving (Show)

data Lock = Lock
    { lockLock :: Int
    } deriving (Show)

data Long = Long
    { longLong :: Int
    } deriving (Show)

data LongNode = LongNode
    { longNodeLongNode :: Int
    } deriving (Show)

data MapClass = MapClass
    { mapMapClass :: Int
    } deriving (Show)

data MapEntry = MapEntry
    { mapEntryMapEntry :: Int
    } deriving (Show)

data MarshalJSON = MarshalJSON
    { marshalJSONMarshalJSON :: Int
    } deriving (Show)

data MetadataPropertyHandling = MetadataPropertyHandling
    { metadataPropertyHandlingMetadataPropertyHandling :: Int
    } deriving (Show)

data ID = ID
    { idIDID :: Int
    } deriving (Show)

data If = If
    { ifIfIf :: Int
    } deriving (Show)

data Import = Import
    { importImportImport :: Int
    } deriving (Show)

data In = In
    { inInIn :: Int
    } deriving (Show)

data Infix = Infix
    { infixInfixInfix :: Int
    } deriving (Show)

data Let = Let
    { letLetLet :: Int
    } deriving (Show)

data Module = Module
    { moduleModuleModule :: Int
    } deriving (Show)

data Obj4 = Obj4
    { dummyObj4 :: Int
    , mutableObj4 :: Mutable
    , mutatingObj4 :: Mutating
    , namespaceObj4 :: Namespace
    , nativeObj4 :: Native
    , newObj4 :: New
    , newtonsoftObj4 :: Newtonsoft
    , nilObj4 :: Nil
    , noObj4 :: No
    , noSuchMethodObj4 :: NoSuchMethod
    , noexceptObj4 :: Noexcept
    , nonatomicObj4 :: Nonatomic
    , noneObj4 :: None
    , nonlocalObj4 :: Nonlocal
    , nonmutatingObj4 :: Nonmutating
    , notObj4 :: Not
    , notEqObj4 :: NotEq
    , nsErrorObj4 :: NSError
    , nsObjectObj4 :: NSObject
    , nsStringObj4 :: NSString
    , nullObj4 :: NULLClass
    , nullNodeObj4 :: NullNode
    , nullptrObj4 :: Nullptr
    , numberObj4 :: NumberClass
    , obj4NoneObj4 :: NoneClass
    , obj4NullObj4 :: NullClass
    , obj4OfObj4 :: Of
    , obj4ProtocolObj4 :: ProtocolClass
    , objectObj4 :: ObjectClass
    , objectMapperObj4 :: ObjectMapper
    , objectNodeObj4 :: ObjectNode
    , objectReaderObj4 :: ObjectReader
    , objectWriterObj4 :: ObjectWriter
    , offsetDateTimeObj4 :: OffsetDateTime
    , offsetTimeObj4 :: OffsetTime
    , onewayObj4 :: Oneway
    , openObj4 :: Open
    , operatorObj4 :: Operator
    , optionalObj4 :: Optional
    , orObj4 :: Or
    , orEqObj4 :: OrEq
    , outObj4 :: Out
    , overrideObj4 :: Override
    , packageObj4 :: Package
    , paramsObj4 :: Params
    , passObj4 :: Pass
    , portObj4 :: Port
    , postfixObj4 :: Postfix
    , precedenceObj4 :: Precedence
    , prefixObj4 :: Prefix
    , printObj4 :: Print
    , printMembersObj4 :: PrintMembers
    , printfObj4 :: Printf
    , privateObj4 :: Private
    , protectedObj4 :: Protected
    , protocolObj4 :: Protocol
    , publicObj4 :: Public
    , quicktypeObj4 :: Quicktype
    , raiseObj4 :: Raise
    , rangeObj4 :: Range
    , readonlyObj4 :: Readonly
    , refObj4 :: Ref
    , regExpObj4 :: RegExp
    , registerObj4 :: Register
    , reinterpretCastObj4 :: ReinterpretCast
    } deriving (Show)

data Mutable = Mutable
    { mutableMutable :: Int
    } deriving (Show)

data Mutating = Mutating
    { mutatingMutating :: Int
    } deriving (Show)

data Namespace = Namespace
    { namespaceNamespace :: Int
    } deriving (Show)

data Native = Native
    { nativeNative :: Int
    } deriving (Show)

data New = New
    { newNew :: Int
    } deriving (Show)

data Newtonsoft = Newtonsoft
    { newtonsoftNewtonsoft :: Int
    } deriving (Show)

data Nil = Nil
    { nilNil :: Int
    } deriving (Show)

data No = No
    { noNo :: Int
    } deriving (Show)

data NoSuchMethod = NoSuchMethod
    { noSuchMethodNoSuchMethod :: Int
    } deriving (Show)

data Noexcept = Noexcept
    { noexceptNoexcept :: Int
    } deriving (Show)

data Nonatomic = Nonatomic
    { nonatomicNonatomic :: Int
    } deriving (Show)

data None = None
    { noneNone :: Int
    } deriving (Show)

data Nonlocal = Nonlocal
    { nonlocalNonlocal :: Int
    } deriving (Show)

data Nonmutating = Nonmutating
    { nonmutatingNonmutating :: Int
    } deriving (Show)

data Not = Not
    { notNot :: Int
    } deriving (Show)

data NotEq = NotEq
    { notEqNotEq :: Int
    } deriving (Show)

data NSError = NSError
    { nsErrorNSError :: Int
    } deriving (Show)

data NSObject = NSObject
    { nsObjectNSObject :: Int
    } deriving (Show)

data NSString = NSString
    { nsStringNSString :: Int
    } deriving (Show)

data NULLClass = NULLClass
    { nullNULLClass :: Int
    } deriving (Show)

data NullNode = NullNode
    { nullNodeNullNode :: Int
    } deriving (Show)

data Nullptr = Nullptr
    { nullptrNullptr :: Int
    } deriving (Show)

data NumberClass = NumberClass
    { numberNumberClass :: Int
    } deriving (Show)

data NoneClass = NoneClass
    { noneNoneClass :: Int
    } deriving (Show)

data NullClass = NullClass
    { nullNullClass :: Int
    } deriving (Show)

data Of = Of
    { ofOfOf :: Int
    } deriving (Show)

data ProtocolClass = ProtocolClass
    { protocolProtocolClass :: Int
    } deriving (Show)

data ObjectClass = ObjectClass
    { objectObjectClass :: Int
    } deriving (Show)

data ObjectMapper = ObjectMapper
    { objectMapperObjectMapper :: Int
    } deriving (Show)

data ObjectNode = ObjectNode
    { objectNodeObjectNode :: Int
    } deriving (Show)

data ObjectReader = ObjectReader
    { objectReaderObjectReader :: Int
    } deriving (Show)

data ObjectWriter = ObjectWriter
    { objectWriterObjectWriter :: Int
    } deriving (Show)

data OffsetDateTime = OffsetDateTime
    { offsetDateTimeOffsetDateTime :: Int
    } deriving (Show)

data OffsetTime = OffsetTime
    { offsetTimeOffsetTime :: Int
    } deriving (Show)

data Oneway = Oneway
    { onewayOneway :: Int
    } deriving (Show)

data Open = Open
    { openOpen :: Int
    } deriving (Show)

data Operator = Operator
    { operatorOperator :: Int
    } deriving (Show)

data Optional = Optional
    { optionalOptional :: Int
    } deriving (Show)

data Or = Or
    { orOr :: Int
    } deriving (Show)

data OrEq = OrEq
    { orEqOrEq :: Int
    } deriving (Show)

data Out = Out
    { outOut :: Int
    } deriving (Show)

data Override = Override
    { overrideOverride :: Int
    } deriving (Show)

data Package = Package
    { packagePackage :: Int
    } deriving (Show)

data Params = Params
    { paramsParams :: Int
    } deriving (Show)

data Pass = Pass
    { passPass :: Int
    } deriving (Show)

data Port = Port
    { portPort :: Int
    } deriving (Show)

data Postfix = Postfix
    { postfixPostfix :: Int
    } deriving (Show)

data Precedence = Precedence
    { precedencePrecedence :: Int
    } deriving (Show)

data Prefix = Prefix
    { prefixPrefix :: Int
    } deriving (Show)

data Print = Print
    { printPrint :: Int
    } deriving (Show)

data PrintMembers = PrintMembers
    { printMembersPrintMembers :: Int
    } deriving (Show)

data Printf = Printf
    { printfPrintf :: Int
    } deriving (Show)

data Private = Private
    { privatePrivate :: Int
    } deriving (Show)

data Protected = Protected
    { protectedProtected :: Int
    } deriving (Show)

data Protocol = Protocol
    { protocolProtocol :: Int
    } deriving (Show)

data Public = Public
    { publicPublic :: Int
    } deriving (Show)

data Quicktype = Quicktype
    { quicktypeQuicktype :: Int
    } deriving (Show)

data Raise = Raise
    { raiseRaise :: Int
    } deriving (Show)

data Range = Range
    { rangeRange :: Int
    } deriving (Show)

data Readonly = Readonly
    { readonlyReadonly :: Int
    } deriving (Show)

data Ref = Ref
    { refRef :: Int
    } deriving (Show)

data RegExp = RegExp
    { regExpRegExp :: Text
    } deriving (Show)

data Register = Register
    { registerRegister :: Int
    } deriving (Show)

data ReinterpretCast = ReinterpretCast
    { reinterpretCastReinterpretCast :: Int
    } deriving (Show)

data Obj5 = Obj5
    { dummyObj5 :: Int
    , kSerializerObj5 :: KSerializer
    , obj5SelfObj5 :: SelfClass
    , obj5ThenObj5 :: Then
    , obj5TrueObj5 :: Obj5True
    , primitiveKindObj5 :: PrimitiveKind
    , repeatObj5 :: Repeat
    , requireObj5 :: Require
    , requiredObj5 :: Required
    , requiresObj5 :: Requires
    , restrictObj5 :: Restrict
    , retainObj5 :: Retain
    , rethrowsObj5 :: Rethrows
    , returnObj5 :: Return
    , rightObj5 :: RightClass
    , runtimeTypeObj5 :: RuntimeType
    , sObj5 :: S
    , sbyteObj5 :: Sbyte
    , sealedObj5 :: Sealed
    , selObj5 :: Sel
    , selectObj5 :: Select
    , selfObj5 :: Self
    , sendableObj5 :: Sendable
    , serialDescriptorObj5 :: SerialDescriptor
    , serialNameObj5 :: SerialName
    , serializableObj5 :: Serializable
    , serializationFeatureObj5 :: SerializationFeature
    , serializeObj5 :: Serialize
    , serializerProviderObj5 :: SerializerProvider
    , setObj5 :: Set
    , shortObj5 :: Short
    , signedObj5 :: Signed
    , simpleModuleObj5 :: SimpleModule
    , sizeofObj5 :: Sizeof
    , stackallocObj5 :: Stackalloc
    , standardsObj5 :: Standards
    , staticObj5 :: Static
    , staticAssertObj5 :: StaticAssert
    , staticCastObj5 :: StaticCast
    , stdDeserializerObj5 :: StdDeserializer
    , stdSerializerObj5 :: StdSerializer
    , strictfpObj5 :: Strictfp
    , stringObj5 :: StringClass
    , structObj5 :: Struct
    , subscriptObj5 :: Subscript
    , superObj5 :: Super
    , switchObj5 :: Switch
    , symbolObj5 :: Symbol
    , synchronizedObj5 :: Synchronized
    , systemObj5 :: System
    , templateObj5 :: Template
    , textNodeObj5 :: TextNode
    , thisObj5 :: This
    , threadLocalObj5 :: ThreadLocal
    , throwObj5 :: Throw
    , throwsObj5 :: Throws
    , timeOnlyObj5 :: TimeOnly
    , timeOnlyConverterObj5 :: TimeOnlyConverter
    , timeZoneObj5 :: TimeZone
    , toDictObj5 :: ToDict
    , toJSONObj5 :: ToJSONClass
    , toStringObj5 :: ToString
    , topLevelObj5 :: TopLevel
    , transientObj5 :: Transient
    , trueObj5 :: TrueClass
    } deriving (Show)

data KSerializer = KSerializer
    { kSerializerKSerializer :: Int
    } deriving (Show)

data SelfClass = SelfClass
    { selfSelfClass :: Int
    } deriving (Show)

data Then = Then
    { thenThenThen :: Int
    } deriving (Show)

data Obj5True = Obj5True
    { trueObj5True :: Int
    } deriving (Show)

data PrimitiveKind = PrimitiveKind
    { primitiveKindPrimitiveKind :: Int
    } deriving (Show)

data Repeat = Repeat
    { repeatRepeat :: Int
    } deriving (Show)

data Require = Require
    { requireRequire :: Int
    } deriving (Show)

data Required = Required
    { requiredRequired :: Int
    } deriving (Show)

data Requires = Requires
    { requiresRequires :: Int
    } deriving (Show)

data Restrict = Restrict
    { restrictRestrict :: Int
    } deriving (Show)

data Retain = Retain
    { retainRetain :: Int
    } deriving (Show)

data Rethrows = Rethrows
    { rethrowsRethrows :: Int
    } deriving (Show)

data Return = Return
    { returnReturn :: Int
    } deriving (Show)

data RightClass = RightClass
    { rightRightClass :: Int
    } deriving (Show)

data RuntimeType = RuntimeType
    { runtimeTypeRuntimeType :: Int
    } deriving (Show)

data S = S
    { sS :: Int
    } deriving (Show)

data Sbyte = Sbyte
    { sbyteSbyte :: Int
    } deriving (Show)

data Sealed = Sealed
    { sealedSealed :: Int
    } deriving (Show)

data Sel = Sel
    { selSel :: Int
    } deriving (Show)

data Select = Select
    { selectSelect :: Int
    } deriving (Show)

data Self = Self
    { selfSelf :: Int
    } deriving (Show)

data Sendable = Sendable
    { sendableSendable :: Int
    } deriving (Show)

data SerialDescriptor = SerialDescriptor
    { serialDescriptorSerialDescriptor :: Int
    } deriving (Show)

data SerialName = SerialName
    { serialNameSerialName :: Int
    } deriving (Show)

data Serializable = Serializable
    { serializableSerializable :: Int
    } deriving (Show)

data SerializationFeature = SerializationFeature
    { serializationFeatureSerializationFeature :: Int
    } deriving (Show)

data Serialize = Serialize
    { serializeSerialize :: Int
    } deriving (Show)

data SerializerProvider = SerializerProvider
    { serializerProviderSerializerProvider :: Int
    } deriving (Show)

data Set = Set
    { setSet :: Int
    } deriving (Show)

data Short = Short
    { shortShort :: Int
    } deriving (Show)

data Signed = Signed
    { signedSigned :: Int
    } deriving (Show)

data SimpleModule = SimpleModule
    { simpleModuleSimpleModule :: Int
    } deriving (Show)

data Sizeof = Sizeof
    { sizeofSizeof :: Int
    } deriving (Show)

data Stackalloc = Stackalloc
    { stackallocStackalloc :: Int
    } deriving (Show)

data Standards = Standards
    { standardsStandards :: Int
    } deriving (Show)

data Static = Static
    { staticStatic :: Int
    } deriving (Show)

data StaticAssert = StaticAssert
    { staticAssertStaticAssert :: Int
    } deriving (Show)

data StaticCast = StaticCast
    { staticCastStaticCast :: Int
    } deriving (Show)

data StdDeserializer = StdDeserializer
    { stdDeserializerStdDeserializer :: Int
    } deriving (Show)

data StdSerializer = StdSerializer
    { stdSerializerStdSerializer :: Int
    } deriving (Show)

data Strictfp = Strictfp
    { strictfpStrictfp :: Int
    } deriving (Show)

data StringClass = StringClass
    { stringStringClass :: Int
    } deriving (Show)

data Struct = Struct
    { structStruct :: Int
    } deriving (Show)

data Subscript = Subscript
    { subscriptSubscript :: Int
    } deriving (Show)

data Super = Super
    { superSuper :: Int
    } deriving (Show)

data Switch = Switch
    { switchSwitch :: Int
    } deriving (Show)

data Symbol = Symbol
    { symbolSymbol :: Int
    } deriving (Show)

data Synchronized = Synchronized
    { synchronizedSynchronized :: Int
    } deriving (Show)

data System = System
    { systemSystem :: Int
    } deriving (Show)

data Template = Template
    { templateTemplate :: Int
    } deriving (Show)

data TextNode = TextNode
    { textNodeTextNode :: Int
    } deriving (Show)

data This = This
    { thisThis :: Int
    } deriving (Show)

data ThreadLocal = ThreadLocal
    { threadLocalThreadLocal :: Int
    } deriving (Show)

data Throw = Throw
    { throwThrow :: Int
    } deriving (Show)

data Throws = Throws
    { throwsThrows :: Int
    } deriving (Show)

data TimeOnly = TimeOnly
    { timeOnlyTimeOnly :: Int
    } deriving (Show)

data TimeOnlyConverter = TimeOnlyConverter
    { timeOnlyConverterTimeOnlyConverter :: Int
    } deriving (Show)

data TimeZone = TimeZone
    { timeZoneTimeZone :: Int
    } deriving (Show)

data ToDict = ToDict
    { toDictToDict :: Int
    } deriving (Show)

data ToJSONClass = ToJSONClass
    { toJSONToJSONClass :: Int
    } deriving (Show)

data ToString = ToString
    { toStringToString :: Int
    } deriving (Show)

data TopLevel = TopLevel
    { topLevelTopLevel :: Int
    } deriving (Show)

data Transient = Transient
    { transientTransient :: Int
    } deriving (Show)

data TrueClass = TrueClass
    { trueTrueClass :: Int
    } deriving (Show)

data Obj6 = Obj6
    { dummyObj6 :: Int
    , obj6TypeObj6 :: Type
    , obj6WhereObj6 :: Where
    , purpleTypeObj6 :: TypeClass
    , tryObj6 :: Try
    , typealiasObj6 :: Typealias
    , typedefObj6 :: Typedef
    , typeidObj6 :: Typeid
    , typenameObj6 :: Typename
    , typeofObj6 :: Typeof
    , uintObj6 :: Uint
    , ulongObj6 :: Ulong
    , uncheckedObj6 :: Unchecked
    , undefinedObj6 :: Undefined
    , unionObj6 :: Union
    , unmarshalJSONObj6 :: UnmarshalJSON
    , unownedObj6 :: Unowned
    , unsafeObj6 :: Unsafe
    , unsignedObj6 :: Unsigned
    , useSerializersObj6 :: UseSerializers
    , ushortObj6 :: Ushort
    , usingObj6 :: Using
    , utf8JSONReaderObj6 :: Utf8JSONReader
    , utf8JSONWriterObj6 :: Utf8JSONWriter
    , uuidObj6 :: UUID
    , varObj6 :: Var
    , virtualObj6 :: Virtual
    , voidObj6 :: Void
    , volatileObj6 :: Volatile
    , wcharTObj6 :: WcharT
    , weakObj6 :: Weak
    , whileObj6 :: While
    , willSetObj6 :: WillSet
    , withObj6 :: With
    , xorObj6 :: Xor
    , xorEqObj6 :: XorEq
    , yesObj6 :: Yes
    , yieldObj6 :: Yield
    } deriving (Show)

data Type = Type
    { typeTypeType :: Int
    } deriving (Show)

data Where = Where
    { whereWhereWhere :: Int
    } deriving (Show)

data TypeClass = TypeClass
    { typeTypeTypeClass :: Int
    } deriving (Show)

data Try = Try
    { tryTry :: Int
    } deriving (Show)

data Typealias = Typealias
    { typealiasTypealias :: Int
    } deriving (Show)

data Typedef = Typedef
    { typedefTypedef :: Int
    } deriving (Show)

data Typeid = Typeid
    { typeidTypeid :: Int
    } deriving (Show)

data Typename = Typename
    { typenameTypename :: Int
    } deriving (Show)

data Typeof = Typeof
    { typeofTypeof :: Int
    } deriving (Show)

data Uint = Uint
    { uintUint :: Int
    } deriving (Show)

data Ulong = Ulong
    { ulongUlong :: Int
    } deriving (Show)

data Unchecked = Unchecked
    { uncheckedUnchecked :: Int
    } deriving (Show)

data Undefined = Undefined
    { undefinedUndefined :: Int
    } deriving (Show)

data Union = Union
    { unionUnion :: Int
    } deriving (Show)

data UnmarshalJSON = UnmarshalJSON
    { unmarshalJSONUnmarshalJSON :: Int
    } deriving (Show)

data Unowned = Unowned
    { unownedUnowned :: Int
    } deriving (Show)

data Unsafe = Unsafe
    { unsafeUnsafe :: Int
    } deriving (Show)

data Unsigned = Unsigned
    { unsignedUnsigned :: Int
    } deriving (Show)

data UseSerializers = UseSerializers
    { useSerializersUseSerializers :: Int
    } deriving (Show)

data Ushort = Ushort
    { ushortUshort :: Int
    } deriving (Show)

data Using = Using
    { usingUsing :: Int
    } deriving (Show)

data Utf8JSONReader = Utf8JSONReader
    { utf8JSONReaderUtf8JSONReader :: Int
    } deriving (Show)

data Utf8JSONWriter = Utf8JSONWriter
    { utf8JSONWriterUtf8JSONWriter :: Int
    } deriving (Show)

data UUID = UUID
    { uuidUUID :: Int
    } deriving (Show)

data Var = Var
    { varVar :: Int
    } deriving (Show)

data Virtual = Virtual
    { virtualVirtual :: Int
    } deriving (Show)

data Void = Void
    { voidVoid :: Int
    } deriving (Show)

data Volatile = Volatile
    { volatileVolatile :: Int
    } deriving (Show)

data WcharT = WcharT
    { wcharTWcharT :: Int
    } deriving (Show)

data Weak = Weak
    { weakWeak :: Int
    } deriving (Show)

data While = While
    { whileWhile :: Int
    } deriving (Show)

data WillSet = WillSet
    { willSetWillSet :: Int
    } deriving (Show)

data With = With
    { withWith :: Int
    } deriving (Show)

data Xor = Xor
    { xorXor :: Int
    } deriving (Show)

data XorEq = XorEq
    { xorEqXorEq :: Int
    } deriving (Show)

data Yes = Yes
    { yesYes :: Int
    } deriving (Show)

data Yield = Yield
    { yieldYield :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType dummyQuickType obj1QuickType obj2QuickType obj3QuickType obj4QuickType obj5QuickType obj6QuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dummy" .= dummyQuickType
        , Just $ "obj1" .= obj1QuickType
        , Just $ "obj2" .= obj2QuickType
        , Just $ "obj3" .= obj3QuickType
        , Just $ "obj4" .= obj4QuickType
        , Just $ "obj5" .= obj5QuickType
        , Just $ "obj6" .= obj6QuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "dummy"
        <*> v .: "obj1"
        <*> v .: "obj2"
        <*> v .: "obj3"
        <*> v .: "obj4"
        <*> v .: "obj5"
        <*> v .: "obj6"

instance ToJSON Obj1 where
    toJSON (Obj1 abstractObj1 alignasObj1 alignofObj1 andObj1 andEqObj1 anyObj1 arrayObj1 arrayNodeObj1 asmObj1 assertObj1 associatedtypeObj1 associativityObj1 asyncObj1 atomicObj1 atomicCancelObj1 atomicCommitObj1 atomicNoexceptObj1 autoObj1 awaitObj1 baseObj1 bitandObj1 bitorObj1 boolObj1 booleanObj1 booleanNodeObj1 breakObj1 bycopyObj1 byrefObj1 byteObj1 calendarObj1 catchObj1 chanObj1 charObj1 char16TObj1 char32TObj1 checkedObj1 cloneObj1 coAwaitObj1 coReturnObj1 coYieldObj1 codableObj1 codingKeyObj1 codingKeysObj1 complObj1 complexObj1 conceptObj1 consoleObj1 constObj1 constCastObj1 constexprObj1 constructorObj1 continueObj1 convenienceObj1 convertObj1 converterObj1 dummyObj1 emptyObj1 imagineryObj1 obj1AnyObj1 obj1AsObj1 obj1BoolObj1 obj1CaseObj1 obj1ClassObj1 purpleBoolObj1 purpleClassObj1) =
        object $ foldMap (maybe [] pure)
        [ Just $ "abstract" .= abstractObj1
        , Just $ "alignas" .= alignasObj1
        , Just $ "alignof" .= alignofObj1
        , Just $ "and" .= andObj1
        , Just $ "and_eq" .= andEqObj1
        , Just $ "Any" .= anyObj1
        , Just $ "array" .= arrayObj1
        , Just $ "ArrayNode" .= arrayNodeObj1
        , Just $ "asm" .= asmObj1
        , Just $ "assert" .= assertObj1
        , Just $ "associatedtype" .= associatedtypeObj1
        , Just $ "associativity" .= associativityObj1
        , Just $ "async" .= asyncObj1
        , Just $ "atomic" .= atomicObj1
        , Just $ "atomic_cancel" .= atomicCancelObj1
        , Just $ "atomic_commit" .= atomicCommitObj1
        , Just $ "atomic_noexcept" .= atomicNoexceptObj1
        , Just $ "auto" .= autoObj1
        , Just $ "await" .= awaitObj1
        , Just $ "base" .= baseObj1
        , Just $ "bitand" .= bitandObj1
        , Just $ "bitor" .= bitorObj1
        , Just $ "BOOL" .= boolObj1
        , Just $ "boolean" .= booleanObj1
        , Just $ "BooleanNode" .= booleanNodeObj1
        , Just $ "break" .= breakObj1
        , Just $ "bycopy" .= bycopyObj1
        , Just $ "byref" .= byrefObj1
        , Just $ "byte" .= byteObj1
        , Just $ "Calendar" .= calendarObj1
        , Just $ "catch" .= catchObj1
        , Just $ "chan" .= chanObj1
        , Just $ "char" .= charObj1
        , Just $ "char16_t" .= char16TObj1
        , Just $ "char32_t" .= char32TObj1
        , Just $ "checked" .= checkedObj1
        , Just $ "clone" .= cloneObj1
        , Just $ "co_await" .= coAwaitObj1
        , Just $ "co_return" .= coReturnObj1
        , Just $ "co_yield" .= coYieldObj1
        , Just $ "Codable" .= codableObj1
        , Just $ "CodingKey" .= codingKeyObj1
        , Just $ "CodingKeys" .= codingKeysObj1
        , Just $ "compl" .= complObj1
        , Just $ "_Complex" .= complexObj1
        , Just $ "concept" .= conceptObj1
        , Just $ "console" .= consoleObj1
        , Just $ "const" .= constObj1
        , Just $ "const_cast" .= constCastObj1
        , Just $ "constexpr" .= constexprObj1
        , Just $ "constructor" .= constructorObj1
        , Just $ "continue" .= continueObj1
        , Just $ "convenience" .= convenienceObj1
        , Just $ "convert" .= convertObj1
        , Just $ "converter" .= converterObj1
        , Just $ "dummy" .= dummyObj1
        , Just $ "_" .= emptyObj1
        , Just $ "_Imaginery" .= imagineryObj1
        , Just $ "any" .= obj1AnyObj1
        , Just $ "as" .= obj1AsObj1
        , Just $ "_Bool" .= obj1BoolObj1
        , Just $ "case" .= obj1CaseObj1
        , Just $ "Class" .= obj1ClassObj1
        , Just $ "bool" .= purpleBoolObj1
        , Just $ "class" .= purpleClassObj1
        ]

instance FromJSON Obj1 where
    parseJSON (Object v) = Obj1
        <$> v .: "abstract"
        <*> v .: "alignas"
        <*> v .: "alignof"
        <*> v .: "and"
        <*> v .: "and_eq"
        <*> v .: "Any"
        <*> v .: "array"
        <*> v .: "ArrayNode"
        <*> v .: "asm"
        <*> v .: "assert"
        <*> v .: "associatedtype"
        <*> v .: "associativity"
        <*> v .: "async"
        <*> v .: "atomic"
        <*> v .: "atomic_cancel"
        <*> v .: "atomic_commit"
        <*> v .: "atomic_noexcept"
        <*> v .: "auto"
        <*> v .: "await"
        <*> v .: "base"
        <*> v .: "bitand"
        <*> v .: "bitor"
        <*> v .: "BOOL"
        <*> v .: "boolean"
        <*> v .: "BooleanNode"
        <*> v .: "break"
        <*> v .: "bycopy"
        <*> v .: "byref"
        <*> v .: "byte"
        <*> v .: "Calendar"
        <*> v .: "catch"
        <*> v .: "chan"
        <*> v .: "char"
        <*> v .: "char16_t"
        <*> v .: "char32_t"
        <*> v .: "checked"
        <*> v .: "clone"
        <*> v .: "co_await"
        <*> v .: "co_return"
        <*> v .: "co_yield"
        <*> v .: "Codable"
        <*> v .: "CodingKey"
        <*> v .: "CodingKeys"
        <*> v .: "compl"
        <*> v .: "_Complex"
        <*> v .: "concept"
        <*> v .: "console"
        <*> v .: "const"
        <*> v .: "const_cast"
        <*> v .: "constexpr"
        <*> v .: "constructor"
        <*> v .: "continue"
        <*> v .: "convenience"
        <*> v .: "convert"
        <*> v .: "converter"
        <*> v .: "dummy"
        <*> v .: "_"
        <*> v .: "_Imaginery"
        <*> v .: "any"
        <*> v .: "as"
        <*> v .: "_Bool"
        <*> v .: "case"
        <*> v .: "Class"
        <*> v .: "bool"
        <*> v .: "class"

instance ToJSON Abstract where
    toJSON (Abstract abstractAbstract) =
        object $ foldMap (maybe [] pure)
        [ Just $ "abstract" .= abstractAbstract
        ]

instance FromJSON Abstract where
    parseJSON (Object v) = Abstract
        <$> v .: "abstract"

instance ToJSON Alignas where
    toJSON (Alignas alignasAlignas) =
        object $ foldMap (maybe [] pure)
        [ Just $ "alignas" .= alignasAlignas
        ]

instance FromJSON Alignas where
    parseJSON (Object v) = Alignas
        <$> v .: "alignas"

instance ToJSON Alignof where
    toJSON (Alignof alignofAlignof) =
        object $ foldMap (maybe [] pure)
        [ Just $ "alignof" .= alignofAlignof
        ]

instance FromJSON Alignof where
    parseJSON (Object v) = Alignof
        <$> v .: "alignof"

instance ToJSON And where
    toJSON (And andAnd) =
        object $ foldMap (maybe [] pure)
        [ Just $ "and" .= andAnd
        ]

instance FromJSON And where
    parseJSON (Object v) = And
        <$> v .: "and"

instance ToJSON AndEq where
    toJSON (AndEq andEqAndEq) =
        object $ foldMap (maybe [] pure)
        [ Just $ "and_eq" .= andEqAndEq
        ]

instance FromJSON AndEq where
    parseJSON (Object v) = AndEq
        <$> v .: "and_eq"

instance ToJSON Any where
    toJSON (Any anyAny) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Any" .= anyAny
        ]

instance FromJSON Any where
    parseJSON (Object v) = Any
        <$> v .: "Any"

instance ToJSON ArrayClass where
    toJSON (ArrayClass arrayArrayClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "array" .= arrayArrayClass
        ]

instance FromJSON ArrayClass where
    parseJSON (Object v) = ArrayClass
        <$> v .: "array"

instance ToJSON ArrayNode where
    toJSON (ArrayNode arrayNodeArrayNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ArrayNode" .= arrayNodeArrayNode
        ]

instance FromJSON ArrayNode where
    parseJSON (Object v) = ArrayNode
        <$> v .: "ArrayNode"

instance ToJSON ASM where
    toJSON (ASM asmASM) =
        object $ foldMap (maybe [] pure)
        [ Just $ "asm" .= asmASM
        ]

instance FromJSON ASM where
    parseJSON (Object v) = ASM
        <$> v .: "asm"

instance ToJSON Assert where
    toJSON (Assert assertAssert) =
        object $ foldMap (maybe [] pure)
        [ Just $ "assert" .= assertAssert
        ]

instance FromJSON Assert where
    parseJSON (Object v) = Assert
        <$> v .: "assert"

instance ToJSON Associatedtype where
    toJSON (Associatedtype associatedtypeAssociatedtype) =
        object $ foldMap (maybe [] pure)
        [ Just $ "associatedtype" .= associatedtypeAssociatedtype
        ]

instance FromJSON Associatedtype where
    parseJSON (Object v) = Associatedtype
        <$> v .: "associatedtype"

instance ToJSON Associativity where
    toJSON (Associativity associativityAssociativity) =
        object $ foldMap (maybe [] pure)
        [ Just $ "associativity" .= associativityAssociativity
        ]

instance FromJSON Associativity where
    parseJSON (Object v) = Associativity
        <$> v .: "associativity"

instance ToJSON Async where
    toJSON (Async asyncAsync) =
        object $ foldMap (maybe [] pure)
        [ Just $ "async" .= asyncAsync
        ]

instance FromJSON Async where
    parseJSON (Object v) = Async
        <$> v .: "async"

instance ToJSON Atomic where
    toJSON (Atomic atomicAtomic) =
        object $ foldMap (maybe [] pure)
        [ Just $ "atomic" .= atomicAtomic
        ]

instance FromJSON Atomic where
    parseJSON (Object v) = Atomic
        <$> v .: "atomic"

instance ToJSON AtomicCancel where
    toJSON (AtomicCancel atomicCancelAtomicCancel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "atomic_cancel" .= atomicCancelAtomicCancel
        ]

instance FromJSON AtomicCancel where
    parseJSON (Object v) = AtomicCancel
        <$> v .: "atomic_cancel"

instance ToJSON AtomicCommit where
    toJSON (AtomicCommit atomicCommitAtomicCommit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "atomic_commit" .= atomicCommitAtomicCommit
        ]

instance FromJSON AtomicCommit where
    parseJSON (Object v) = AtomicCommit
        <$> v .: "atomic_commit"

instance ToJSON AtomicNoexcept where
    toJSON (AtomicNoexcept atomicNoexceptAtomicNoexcept) =
        object $ foldMap (maybe [] pure)
        [ Just $ "atomic_noexcept" .= atomicNoexceptAtomicNoexcept
        ]

instance FromJSON AtomicNoexcept where
    parseJSON (Object v) = AtomicNoexcept
        <$> v .: "atomic_noexcept"

instance ToJSON Auto where
    toJSON (Auto autoAuto) =
        object $ foldMap (maybe [] pure)
        [ Just $ "auto" .= autoAuto
        ]

instance FromJSON Auto where
    parseJSON (Object v) = Auto
        <$> v .: "auto"

instance ToJSON Await where
    toJSON (Await awaitAwait) =
        object $ foldMap (maybe [] pure)
        [ Just $ "await" .= awaitAwait
        ]

instance FromJSON Await where
    parseJSON (Object v) = Await
        <$> v .: "await"

instance ToJSON Base where
    toJSON (Base baseBase) =
        object $ foldMap (maybe [] pure)
        [ Just $ "base" .= baseBase
        ]

instance FromJSON Base where
    parseJSON (Object v) = Base
        <$> v .: "base"

instance ToJSON Bitand where
    toJSON (Bitand bitandBitand) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bitand" .= bitandBitand
        ]

instance FromJSON Bitand where
    parseJSON (Object v) = Bitand
        <$> v .: "bitand"

instance ToJSON Bitor where
    toJSON (Bitor bitorBitor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bitor" .= bitorBitor
        ]

instance FromJSON Bitor where
    parseJSON (Object v) = Bitor
        <$> v .: "bitor"

instance ToJSON BOOLClass where
    toJSON (BOOLClass boolBOOLClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "BOOL" .= boolBOOLClass
        ]

instance FromJSON BOOLClass where
    parseJSON (Object v) = BOOLClass
        <$> v .: "BOOL"

instance ToJSON Boolean where
    toJSON (Boolean booleanBoolean) =
        object $ foldMap (maybe [] pure)
        [ Just $ "boolean" .= booleanBoolean
        ]

instance FromJSON Boolean where
    parseJSON (Object v) = Boolean
        <$> v .: "boolean"

instance ToJSON BooleanNode where
    toJSON (BooleanNode booleanNodeBooleanNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "BooleanNode" .= booleanNodeBooleanNode
        ]

instance FromJSON BooleanNode where
    parseJSON (Object v) = BooleanNode
        <$> v .: "BooleanNode"

instance ToJSON Break where
    toJSON (Break breakBreak) =
        object $ foldMap (maybe [] pure)
        [ Just $ "break" .= breakBreak
        ]

instance FromJSON Break where
    parseJSON (Object v) = Break
        <$> v .: "break"

instance ToJSON Bycopy where
    toJSON (Bycopy bycopyBycopy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bycopy" .= bycopyBycopy
        ]

instance FromJSON Bycopy where
    parseJSON (Object v) = Bycopy
        <$> v .: "bycopy"

instance ToJSON Byref where
    toJSON (Byref byrefByref) =
        object $ foldMap (maybe [] pure)
        [ Just $ "byref" .= byrefByref
        ]

instance FromJSON Byref where
    parseJSON (Object v) = Byref
        <$> v .: "byref"

instance ToJSON Byte where
    toJSON (Byte byteByte) =
        object $ foldMap (maybe [] pure)
        [ Just $ "byte" .= byteByte
        ]

instance FromJSON Byte where
    parseJSON (Object v) = Byte
        <$> v .: "byte"

instance ToJSON Calendar where
    toJSON (Calendar calendarCalendar) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Calendar" .= calendarCalendar
        ]

instance FromJSON Calendar where
    parseJSON (Object v) = Calendar
        <$> v .: "Calendar"

instance ToJSON Catch where
    toJSON (Catch catchCatch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "catch" .= catchCatch
        ]

instance FromJSON Catch where
    parseJSON (Object v) = Catch
        <$> v .: "catch"

instance ToJSON Chan where
    toJSON (Chan chanChan) =
        object $ foldMap (maybe [] pure)
        [ Just $ "chan" .= chanChan
        ]

instance FromJSON Chan where
    parseJSON (Object v) = Chan
        <$> v .: "chan"

instance ToJSON CharClass where
    toJSON (CharClass charCharClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "char" .= charCharClass
        ]

instance FromJSON CharClass where
    parseJSON (Object v) = CharClass
        <$> v .: "char"

instance ToJSON Char16T where
    toJSON (Char16T char16TChar16T) =
        object $ foldMap (maybe [] pure)
        [ Just $ "char16_t" .= char16TChar16T
        ]

instance FromJSON Char16T where
    parseJSON (Object v) = Char16T
        <$> v .: "char16_t"

instance ToJSON Char32T where
    toJSON (Char32T char32TChar32T) =
        object $ foldMap (maybe [] pure)
        [ Just $ "char32_t" .= char32TChar32T
        ]

instance FromJSON Char32T where
    parseJSON (Object v) = Char32T
        <$> v .: "char32_t"

instance ToJSON Checked where
    toJSON (Checked checkedChecked) =
        object $ foldMap (maybe [] pure)
        [ Just $ "checked" .= checkedChecked
        ]

instance FromJSON Checked where
    parseJSON (Object v) = Checked
        <$> v .: "checked"

instance ToJSON Clone where
    toJSON (Clone cloneClone) =
        object $ foldMap (maybe [] pure)
        [ Just $ "clone" .= cloneClone
        ]

instance FromJSON Clone where
    parseJSON (Object v) = Clone
        <$> v .: "clone"

instance ToJSON CoAwait where
    toJSON (CoAwait coAwaitCoAwait) =
        object $ foldMap (maybe [] pure)
        [ Just $ "co_await" .= coAwaitCoAwait
        ]

instance FromJSON CoAwait where
    parseJSON (Object v) = CoAwait
        <$> v .: "co_await"

instance ToJSON CoReturn where
    toJSON (CoReturn coReturnCoReturn) =
        object $ foldMap (maybe [] pure)
        [ Just $ "co_return" .= coReturnCoReturn
        ]

instance FromJSON CoReturn where
    parseJSON (Object v) = CoReturn
        <$> v .: "co_return"

instance ToJSON CoYield where
    toJSON (CoYield coYieldCoYield) =
        object $ foldMap (maybe [] pure)
        [ Just $ "co_yield" .= coYieldCoYield
        ]

instance FromJSON CoYield where
    parseJSON (Object v) = CoYield
        <$> v .: "co_yield"

instance ToJSON Codable where
    toJSON (Codable codableCodable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Codable" .= codableCodable
        ]

instance FromJSON Codable where
    parseJSON (Object v) = Codable
        <$> v .: "Codable"

instance ToJSON CodingKey where
    toJSON (CodingKey codingKeyCodingKey) =
        object $ foldMap (maybe [] pure)
        [ Just $ "CodingKey" .= codingKeyCodingKey
        ]

instance FromJSON CodingKey where
    parseJSON (Object v) = CodingKey
        <$> v .: "CodingKey"

instance ToJSON CodingKeys where
    toJSON (CodingKeys codingKeysCodingKeys) =
        object $ foldMap (maybe [] pure)
        [ Just $ "CodingKeys" .= codingKeysCodingKeys
        ]

instance FromJSON CodingKeys where
    parseJSON (Object v) = CodingKeys
        <$> v .: "CodingKeys"

instance ToJSON Compl where
    toJSON (Compl complCompl) =
        object $ foldMap (maybe [] pure)
        [ Just $ "compl" .= complCompl
        ]

instance FromJSON Compl where
    parseJSON (Object v) = Compl
        <$> v .: "compl"

instance ToJSON Complex where
    toJSON (Complex complexComplex) =
        object $ foldMap (maybe [] pure)
        [ Just $ "_Complex" .= complexComplex
        ]

instance FromJSON Complex where
    parseJSON (Object v) = Complex
        <$> v .: "_Complex"

instance ToJSON Concept where
    toJSON (Concept conceptConcept) =
        object $ foldMap (maybe [] pure)
        [ Just $ "concept" .= conceptConcept
        ]

instance FromJSON Concept where
    parseJSON (Object v) = Concept
        <$> v .: "concept"

instance ToJSON Console where
    toJSON (Console consoleConsole) =
        object $ foldMap (maybe [] pure)
        [ Just $ "console" .= consoleConsole
        ]

instance FromJSON Console where
    parseJSON (Object v) = Console
        <$> v .: "console"

instance ToJSON Const where
    toJSON (Const constConst) =
        object $ foldMap (maybe [] pure)
        [ Just $ "const" .= constConst
        ]

instance FromJSON Const where
    parseJSON (Object v) = Const
        <$> v .: "const"

instance ToJSON ConstCast where
    toJSON (ConstCast constCastConstCast) =
        object $ foldMap (maybe [] pure)
        [ Just $ "const_cast" .= constCastConstCast
        ]

instance FromJSON ConstCast where
    parseJSON (Object v) = ConstCast
        <$> v .: "const_cast"

instance ToJSON Constexpr where
    toJSON (Constexpr constexprConstexpr) =
        object $ foldMap (maybe [] pure)
        [ Just $ "constexpr" .= constexprConstexpr
        ]

instance FromJSON Constexpr where
    parseJSON (Object v) = Constexpr
        <$> v .: "constexpr"

instance ToJSON Constructor where
    toJSON (Constructor constructorConstructor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "constructor" .= constructorConstructor
        ]

instance FromJSON Constructor where
    parseJSON (Object v) = Constructor
        <$> v .: "constructor"

instance ToJSON Continue where
    toJSON (Continue continueContinue) =
        object $ foldMap (maybe [] pure)
        [ Just $ "continue" .= continueContinue
        ]

instance FromJSON Continue where
    parseJSON (Object v) = Continue
        <$> v .: "continue"

instance ToJSON Convenience where
    toJSON (Convenience convenienceConvenience) =
        object $ foldMap (maybe [] pure)
        [ Just $ "convenience" .= convenienceConvenience
        ]

instance FromJSON Convenience where
    parseJSON (Object v) = Convenience
        <$> v .: "convenience"

instance ToJSON Convert where
    toJSON (Convert convertConvert) =
        object $ foldMap (maybe [] pure)
        [ Just $ "convert" .= convertConvert
        ]

instance FromJSON Convert where
    parseJSON (Object v) = Convert
        <$> v .: "convert"

instance ToJSON Converter where
    toJSON (Converter converterConverter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "converter" .= converterConverter
        ]

instance FromJSON Converter where
    parseJSON (Object v) = Converter
        <$> v .: "converter"

instance ToJSON Empty where
    toJSON (Empty emptyEmpty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "_" .= emptyEmpty
        ]

instance FromJSON Empty where
    parseJSON (Object v) = Empty
        <$> v .: "_"

instance ToJSON Imaginery where
    toJSON (Imaginery imagineryImaginery) =
        object $ foldMap (maybe [] pure)
        [ Just $ "_Imaginery" .= imagineryImaginery
        ]

instance FromJSON Imaginery where
    parseJSON (Object v) = Imaginery
        <$> v .: "_Imaginery"

instance ToJSON AnyClass where
    toJSON (AnyClass anyAnyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "any" .= anyAnyClass
        ]

instance FromJSON AnyClass where
    parseJSON (Object v) = AnyClass
        <$> v .: "any"

instance ToJSON As where
    toJSON (As asAsAs) =
        object $ foldMap (maybe [] pure)
        [ Just $ "as" .= asAsAs
        ]

instance FromJSON As where
    parseJSON (Object v) = As
        <$> v .: "as"

instance ToJSON BoolClass where
    toJSON (BoolClass boolBoolClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "_Bool" .= boolBoolClass
        ]

instance FromJSON BoolClass where
    parseJSON (Object v) = BoolClass
        <$> v .: "_Bool"

instance ToJSON Case where
    toJSON (Case caseCaseCase) =
        object $ foldMap (maybe [] pure)
        [ Just $ "case" .= caseCaseCase
        ]

instance FromJSON Case where
    parseJSON (Object v) = Case
        <$> v .: "case"

instance ToJSON Class where
    toJSON (Class classClassClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Class" .= classClassClass
        ]

instance FromJSON Class where
    parseJSON (Object v) = Class
        <$> v .: "Class"

instance ToJSON Obj1Bool where
    toJSON (Obj1Bool boolObj1Bool) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bool" .= boolObj1Bool
        ]

instance FromJSON Obj1Bool where
    parseJSON (Object v) = Obj1Bool
        <$> v .: "bool"

instance ToJSON ClassClass where
    toJSON (ClassClass classClassClassClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "class" .= classClassClassClass
        ]

instance FromJSON ClassClass where
    parseJSON (Object v) = ClassClass
        <$> v .: "class"

instance ToJSON Obj2 where
    toJSON (Obj2 cultureInfoObj2 dateObj2 dateFormatterObj2 dateOnlyObj2 dateOnlyConverterObj2 dateParseHandlingObj2 dateTimeObj2 dateTimeStylesObj2 debuggerObj2 decimalObj2 declareObj2 decltypeObj2 decodeStringObj2 decoderObj2 decodingErrorObj2 defObj2 deferObj2 deinitObj2 delObj2 delegateObj2 deleteObj2 deserializationFeatureObj2 dictObj2 dictionaryObj2 didSetObj2 doubleObj2 doubleNodeObj2 dummyObj2 dynamicObj2 dynamicCastObj2 elifObj2 encodeQuickTypeObj2 encoderObj2 enumObj2 enumValuesObj2 equalityContractObj2 equatableObj2 eventObj2 exceptObj2 exceptionObj2 explicitObj2 exportObj2 exposingObj2 extendsObj2 extensionObj2 externObj2 fallthroughObj2 falseObj2 fileprivateObj2 finalObj2 finallyObj2 fixedObj2 floatObj2 forObj2 foreachObj2 formatExceptionObj2 friendObj2 fromObj2 fromDictObj2 fromJSONObj2 funcObj2 obj2DefaultObj2 obj2DoObj2 obj2ElseObj2 obj2FalseObj2) =
        object $ foldMap (maybe [] pure)
        [ Just $ "CultureInfo" .= cultureInfoObj2
        , Just $ "date" .= dateObj2
        , Just $ "DateFormatter" .= dateFormatterObj2
        , Just $ "DateOnly" .= dateOnlyObj2
        , Just $ "DateOnlyConverter" .= dateOnlyConverterObj2
        , Just $ "date_parse_handling" .= dateParseHandlingObj2
        , Just $ "DateTime" .= dateTimeObj2
        , Just $ "DateTimeStyles" .= dateTimeStylesObj2
        , Just $ "debugger" .= debuggerObj2
        , Just $ "decimal" .= decimalObj2
        , Just $ "declare" .= declareObj2
        , Just $ "decltype" .= decltypeObj2
        , Just $ "decode_string" .= decodeStringObj2
        , Just $ "Decoder" .= decoderObj2
        , Just $ "DecodingError" .= decodingErrorObj2
        , Just $ "def" .= defObj2
        , Just $ "defer" .= deferObj2
        , Just $ "deinit" .= deinitObj2
        , Just $ "del" .= delObj2
        , Just $ "delegate" .= delegateObj2
        , Just $ "delete" .= deleteObj2
        , Just $ "DeserializationFeature" .= deserializationFeatureObj2
        , Just $ "dict" .= dictObj2
        , Just $ "dictionary" .= dictionaryObj2
        , Just $ "didSet" .= didSetObj2
        , Just $ "double" .= doubleObj2
        , Just $ "DoubleNode" .= doubleNodeObj2
        , Just $ "dummy" .= dummyObj2
        , Just $ "dynamic" .= dynamicObj2
        , Just $ "dynamic_cast" .= dynamicCastObj2
        , Just $ "elif" .= elifObj2
        , Just $ "encode_quick_type" .= encodeQuickTypeObj2
        , Just $ "Encoder" .= encoderObj2
        , Just $ "enum" .= enumObj2
        , Just $ "EnumValues" .= enumValuesObj2
        , Just $ "equalityContract" .= equalityContractObj2
        , Just $ "Equatable" .= equatableObj2
        , Just $ "event" .= eventObj2
        , Just $ "except" .= exceptObj2
        , Just $ "exception" .= exceptionObj2
        , Just $ "explicit" .= explicitObj2
        , Just $ "export" .= exportObj2
        , Just $ "exposing" .= exposingObj2
        , Just $ "extends" .= extendsObj2
        , Just $ "extension" .= extensionObj2
        , Just $ "extern" .= externObj2
        , Just $ "fallthrough" .= fallthroughObj2
        , Just $ "False" .= falseObj2
        , Just $ "fileprivate" .= fileprivateObj2
        , Just $ "final" .= finalObj2
        , Just $ "finally" .= finallyObj2
        , Just $ "fixed" .= fixedObj2
        , Just $ "float" .= floatObj2
        , Just $ "for" .= forObj2
        , Just $ "foreach" .= foreachObj2
        , Just $ "FormatException" .= formatExceptionObj2
        , Just $ "friend" .= friendObj2
        , Just $ "from" .= fromObj2
        , Just $ "from_dict" .= fromDictObj2
        , Just $ "from_json" .= fromJSONObj2
        , Just $ "func" .= funcObj2
        , Just $ "default" .= obj2DefaultObj2
        , Just $ "do" .= obj2DoObj2
        , Just $ "else" .= obj2ElseObj2
        , Just $ "false" .= obj2FalseObj2
        ]

instance FromJSON Obj2 where
    parseJSON (Object v) = Obj2
        <$> v .: "CultureInfo"
        <*> v .: "date"
        <*> v .: "DateFormatter"
        <*> v .: "DateOnly"
        <*> v .: "DateOnlyConverter"
        <*> v .: "date_parse_handling"
        <*> v .: "DateTime"
        <*> v .: "DateTimeStyles"
        <*> v .: "debugger"
        <*> v .: "decimal"
        <*> v .: "declare"
        <*> v .: "decltype"
        <*> v .: "decode_string"
        <*> v .: "Decoder"
        <*> v .: "DecodingError"
        <*> v .: "def"
        <*> v .: "defer"
        <*> v .: "deinit"
        <*> v .: "del"
        <*> v .: "delegate"
        <*> v .: "delete"
        <*> v .: "DeserializationFeature"
        <*> v .: "dict"
        <*> v .: "dictionary"
        <*> v .: "didSet"
        <*> v .: "double"
        <*> v .: "DoubleNode"
        <*> v .: "dummy"
        <*> v .: "dynamic"
        <*> v .: "dynamic_cast"
        <*> v .: "elif"
        <*> v .: "encode_quick_type"
        <*> v .: "Encoder"
        <*> v .: "enum"
        <*> v .: "EnumValues"
        <*> v .: "equalityContract"
        <*> v .: "Equatable"
        <*> v .: "event"
        <*> v .: "except"
        <*> v .: "exception"
        <*> v .: "explicit"
        <*> v .: "export"
        <*> v .: "exposing"
        <*> v .: "extends"
        <*> v .: "extension"
        <*> v .: "extern"
        <*> v .: "fallthrough"
        <*> v .: "False"
        <*> v .: "fileprivate"
        <*> v .: "final"
        <*> v .: "finally"
        <*> v .: "fixed"
        <*> v .: "float"
        <*> v .: "for"
        <*> v .: "foreach"
        <*> v .: "FormatException"
        <*> v .: "friend"
        <*> v .: "from"
        <*> v .: "from_dict"
        <*> v .: "from_json"
        <*> v .: "func"
        <*> v .: "default"
        <*> v .: "do"
        <*> v .: "else"
        <*> v .: "false"

instance ToJSON CultureInfo where
    toJSON (CultureInfo cultureInfoCultureInfo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "CultureInfo" .= cultureInfoCultureInfo
        ]

instance FromJSON CultureInfo where
    parseJSON (Object v) = CultureInfo
        <$> v .: "CultureInfo"

instance ToJSON Date where
    toJSON (Date dateDate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date" .= dateDate
        ]

instance FromJSON Date where
    parseJSON (Object v) = Date
        <$> v .: "date"

instance ToJSON DateFormatter where
    toJSON (DateFormatter dateFormatterDateFormatter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DateFormatter" .= dateFormatterDateFormatter
        ]

instance FromJSON DateFormatter where
    parseJSON (Object v) = DateFormatter
        <$> v .: "DateFormatter"

instance ToJSON DateOnly where
    toJSON (DateOnly dateOnlyDateOnly) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DateOnly" .= dateOnlyDateOnly
        ]

instance FromJSON DateOnly where
    parseJSON (Object v) = DateOnly
        <$> v .: "DateOnly"

instance ToJSON DateOnlyConverter where
    toJSON (DateOnlyConverter dateOnlyConverterDateOnlyConverter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DateOnlyConverter" .= dateOnlyConverterDateOnlyConverter
        ]

instance FromJSON DateOnlyConverter where
    parseJSON (Object v) = DateOnlyConverter
        <$> v .: "DateOnlyConverter"

instance ToJSON DateParseHandling where
    toJSON (DateParseHandling dateParseHandlingDateParseHandling) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date_parse_handling" .= dateParseHandlingDateParseHandling
        ]

instance FromJSON DateParseHandling where
    parseJSON (Object v) = DateParseHandling
        <$> v .: "date_parse_handling"

instance ToJSON DateTime where
    toJSON (DateTime dateTimeDateTime) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DateTime" .= dateTimeDateTime
        ]

instance FromJSON DateTime where
    parseJSON (Object v) = DateTime
        <$> v .: "DateTime"

instance ToJSON DateTimeStyles where
    toJSON (DateTimeStyles dateTimeStylesDateTimeStyles) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DateTimeStyles" .= dateTimeStylesDateTimeStyles
        ]

instance FromJSON DateTimeStyles where
    parseJSON (Object v) = DateTimeStyles
        <$> v .: "DateTimeStyles"

instance ToJSON Debugger where
    toJSON (Debugger debuggerDebugger) =
        object $ foldMap (maybe [] pure)
        [ Just $ "debugger" .= debuggerDebugger
        ]

instance FromJSON Debugger where
    parseJSON (Object v) = Debugger
        <$> v .: "debugger"

instance ToJSON Decimal where
    toJSON (Decimal decimalDecimal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "decimal" .= decimalDecimal
        ]

instance FromJSON Decimal where
    parseJSON (Object v) = Decimal
        <$> v .: "decimal"

instance ToJSON Declare where
    toJSON (Declare declareDeclare) =
        object $ foldMap (maybe [] pure)
        [ Just $ "declare" .= declareDeclare
        ]

instance FromJSON Declare where
    parseJSON (Object v) = Declare
        <$> v .: "declare"

instance ToJSON Decltype where
    toJSON (Decltype decltypeDecltype) =
        object $ foldMap (maybe [] pure)
        [ Just $ "decltype" .= decltypeDecltype
        ]

instance FromJSON Decltype where
    parseJSON (Object v) = Decltype
        <$> v .: "decltype"

instance ToJSON DecodeString where
    toJSON (DecodeString decodeStringDecodeString) =
        object $ foldMap (maybe [] pure)
        [ Just $ "decode_string" .= decodeStringDecodeString
        ]

instance FromJSON DecodeString where
    parseJSON (Object v) = DecodeString
        <$> v .: "decode_string"

instance ToJSON Decoder where
    toJSON (Decoder decoderDecoder) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Decoder" .= decoderDecoder
        ]

instance FromJSON Decoder where
    parseJSON (Object v) = Decoder
        <$> v .: "Decoder"

instance ToJSON DecodingError where
    toJSON (DecodingError decodingErrorDecodingError) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DecodingError" .= decodingErrorDecodingError
        ]

instance FromJSON DecodingError where
    parseJSON (Object v) = DecodingError
        <$> v .: "DecodingError"

instance ToJSON Def where
    toJSON (Def defDef) =
        object $ foldMap (maybe [] pure)
        [ Just $ "def" .= defDef
        ]

instance FromJSON Def where
    parseJSON (Object v) = Def
        <$> v .: "def"

instance ToJSON Defer where
    toJSON (Defer deferDefer) =
        object $ foldMap (maybe [] pure)
        [ Just $ "defer" .= deferDefer
        ]

instance FromJSON Defer where
    parseJSON (Object v) = Defer
        <$> v .: "defer"

instance ToJSON Deinit where
    toJSON (Deinit deinitDeinit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "deinit" .= deinitDeinit
        ]

instance FromJSON Deinit where
    parseJSON (Object v) = Deinit
        <$> v .: "deinit"

instance ToJSON Del where
    toJSON (Del delDel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "del" .= delDel
        ]

instance FromJSON Del where
    parseJSON (Object v) = Del
        <$> v .: "del"

instance ToJSON Delegate where
    toJSON (Delegate delegateDelegate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "delegate" .= delegateDelegate
        ]

instance FromJSON Delegate where
    parseJSON (Object v) = Delegate
        <$> v .: "delegate"

instance ToJSON Delete where
    toJSON (Delete deleteDelete) =
        object $ foldMap (maybe [] pure)
        [ Just $ "delete" .= deleteDelete
        ]

instance FromJSON Delete where
    parseJSON (Object v) = Delete
        <$> v .: "delete"

instance ToJSON DeserializationFeature where
    toJSON (DeserializationFeature deserializationFeatureDeserializationFeature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DeserializationFeature" .= deserializationFeatureDeserializationFeature
        ]

instance FromJSON DeserializationFeature where
    parseJSON (Object v) = DeserializationFeature
        <$> v .: "DeserializationFeature"

instance ToJSON Dict where
    toJSON (Dict dictDict) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dict" .= dictDict
        ]

instance FromJSON Dict where
    parseJSON (Object v) = Dict
        <$> v .: "dict"

instance ToJSON Dictionary where
    toJSON (Dictionary dictionaryDictionary) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dictionary" .= dictionaryDictionary
        ]

instance FromJSON Dictionary where
    parseJSON (Object v) = Dictionary
        <$> v .: "dictionary"

instance ToJSON DidSet where
    toJSON (DidSet didSetDidSet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "didSet" .= didSetDidSet
        ]

instance FromJSON DidSet where
    parseJSON (Object v) = DidSet
        <$> v .: "didSet"

instance ToJSON DoubleClass where
    toJSON (DoubleClass doubleDoubleClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "double" .= doubleDoubleClass
        ]

instance FromJSON DoubleClass where
    parseJSON (Object v) = DoubleClass
        <$> v .: "double"

instance ToJSON DoubleNode where
    toJSON (DoubleNode doubleNodeDoubleNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DoubleNode" .= doubleNodeDoubleNode
        ]

instance FromJSON DoubleNode where
    parseJSON (Object v) = DoubleNode
        <$> v .: "DoubleNode"

instance ToJSON Dynamic where
    toJSON (Dynamic dynamicDynamic) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dynamic" .= dynamicDynamic
        ]

instance FromJSON Dynamic where
    parseJSON (Object v) = Dynamic
        <$> v .: "dynamic"

instance ToJSON DynamicCast where
    toJSON (DynamicCast dynamicCastDynamicCast) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dynamic_cast" .= dynamicCastDynamicCast
        ]

instance FromJSON DynamicCast where
    parseJSON (Object v) = DynamicCast
        <$> v .: "dynamic_cast"

instance ToJSON Elif where
    toJSON (Elif elifElif) =
        object $ foldMap (maybe [] pure)
        [ Just $ "elif" .= elifElif
        ]

instance FromJSON Elif where
    parseJSON (Object v) = Elif
        <$> v .: "elif"

instance ToJSON EncodeQuickType where
    toJSON (EncodeQuickType encodeQuickTypeEncodeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "encode_quick_type" .= encodeQuickTypeEncodeQuickType
        ]

instance FromJSON EncodeQuickType where
    parseJSON (Object v) = EncodeQuickType
        <$> v .: "encode_quick_type"

instance ToJSON Encoder where
    toJSON (Encoder encoderEncoder) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Encoder" .= encoderEncoder
        ]

instance FromJSON Encoder where
    parseJSON (Object v) = Encoder
        <$> v .: "Encoder"

instance ToJSON EnumClass where
    toJSON (EnumClass enumEnumClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "enum" .= enumEnumClass
        ]

instance FromJSON EnumClass where
    parseJSON (Object v) = EnumClass
        <$> v .: "enum"

instance ToJSON EnumValues where
    toJSON (EnumValues enumValuesEnumValues) =
        object $ foldMap (maybe [] pure)
        [ Just $ "EnumValues" .= enumValuesEnumValues
        ]

instance FromJSON EnumValues where
    parseJSON (Object v) = EnumValues
        <$> v .: "EnumValues"

instance ToJSON EnumValue where
    toJSON ReadyEnumValue = "ready"
    toJSON DoneEnumValue = "done"

instance FromJSON EnumValue where
    parseJSON = withText "EnumValue" parseText
        where
            parseText "ready" = return ReadyEnumValue
            parseText "done" = return DoneEnumValue

instance ToJSON EqualityContract where
    toJSON (EqualityContract equalityContractEqualityContract) =
        object $ foldMap (maybe [] pure)
        [ Just $ "equalityContract" .= equalityContractEqualityContract
        ]

instance FromJSON EqualityContract where
    parseJSON (Object v) = EqualityContract
        <$> v .: "equalityContract"

instance ToJSON Equatable where
    toJSON (Equatable equatableEquatable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Equatable" .= equatableEquatable
        ]

instance FromJSON Equatable where
    parseJSON (Object v) = Equatable
        <$> v .: "Equatable"

instance ToJSON Event where
    toJSON (Event eventEvent) =
        object $ foldMap (maybe [] pure)
        [ Just $ "event" .= eventEvent
        ]

instance FromJSON Event where
    parseJSON (Object v) = Event
        <$> v .: "event"

instance ToJSON Except where
    toJSON (Except exceptExcept) =
        object $ foldMap (maybe [] pure)
        [ Just $ "except" .= exceptExcept
        ]

instance FromJSON Except where
    parseJSON (Object v) = Except
        <$> v .: "except"

instance ToJSON Exception where
    toJSON (Exception exceptionException) =
        object $ foldMap (maybe [] pure)
        [ Just $ "exception" .= exceptionException
        ]

instance FromJSON Exception where
    parseJSON (Object v) = Exception
        <$> v .: "exception"

instance ToJSON Explicit where
    toJSON (Explicit explicitExplicit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "explicit" .= explicitExplicit
        ]

instance FromJSON Explicit where
    parseJSON (Object v) = Explicit
        <$> v .: "explicit"

instance ToJSON Export where
    toJSON (Export exportExport) =
        object $ foldMap (maybe [] pure)
        [ Just $ "export" .= exportExport
        ]

instance FromJSON Export where
    parseJSON (Object v) = Export
        <$> v .: "export"

instance ToJSON Exposing where
    toJSON (Exposing exposingExposing) =
        object $ foldMap (maybe [] pure)
        [ Just $ "exposing" .= exposingExposing
        ]

instance FromJSON Exposing where
    parseJSON (Object v) = Exposing
        <$> v .: "exposing"

instance ToJSON Extends where
    toJSON (Extends extendsExtends) =
        object $ foldMap (maybe [] pure)
        [ Just $ "extends" .= extendsExtends
        ]

instance FromJSON Extends where
    parseJSON (Object v) = Extends
        <$> v .: "extends"

instance ToJSON Extension where
    toJSON (Extension extensionExtension) =
        object $ foldMap (maybe [] pure)
        [ Just $ "extension" .= extensionExtension
        ]

instance FromJSON Extension where
    parseJSON (Object v) = Extension
        <$> v .: "extension"

instance ToJSON Extern where
    toJSON (Extern externExtern) =
        object $ foldMap (maybe [] pure)
        [ Just $ "extern" .= externExtern
        ]

instance FromJSON Extern where
    parseJSON (Object v) = Extern
        <$> v .: "extern"

instance ToJSON Fallthrough where
    toJSON (Fallthrough fallthroughFallthrough) =
        object $ foldMap (maybe [] pure)
        [ Just $ "fallthrough" .= fallthroughFallthrough
        ]

instance FromJSON Fallthrough where
    parseJSON (Object v) = Fallthrough
        <$> v .: "fallthrough"

instance ToJSON FalseClass where
    toJSON (FalseClass falseFalseClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "False" .= falseFalseClass
        ]

instance FromJSON FalseClass where
    parseJSON (Object v) = FalseClass
        <$> v .: "False"

instance ToJSON Fileprivate where
    toJSON (Fileprivate fileprivateFileprivate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "fileprivate" .= fileprivateFileprivate
        ]

instance FromJSON Fileprivate where
    parseJSON (Object v) = Fileprivate
        <$> v .: "fileprivate"

instance ToJSON Final where
    toJSON (Final finalFinal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "final" .= finalFinal
        ]

instance FromJSON Final where
    parseJSON (Object v) = Final
        <$> v .: "final"

instance ToJSON Finally where
    toJSON (Finally finallyFinally) =
        object $ foldMap (maybe [] pure)
        [ Just $ "finally" .= finallyFinally
        ]

instance FromJSON Finally where
    parseJSON (Object v) = Finally
        <$> v .: "finally"

instance ToJSON Fixed where
    toJSON (Fixed fixedFixed) =
        object $ foldMap (maybe [] pure)
        [ Just $ "fixed" .= fixedFixed
        ]

instance FromJSON Fixed where
    parseJSON (Object v) = Fixed
        <$> v .: "fixed"

instance ToJSON FloatClass where
    toJSON (FloatClass floatFloatClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "float" .= floatFloatClass
        ]

instance FromJSON FloatClass where
    parseJSON (Object v) = FloatClass
        <$> v .: "float"

instance ToJSON For where
    toJSON (For forFor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "for" .= forFor
        ]

instance FromJSON For where
    parseJSON (Object v) = For
        <$> v .: "for"

instance ToJSON Foreach where
    toJSON (Foreach foreachForeach) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foreach" .= foreachForeach
        ]

instance FromJSON Foreach where
    parseJSON (Object v) = Foreach
        <$> v .: "foreach"

instance ToJSON FormatException where
    toJSON (FormatException formatExceptionFormatException) =
        object $ foldMap (maybe [] pure)
        [ Just $ "FormatException" .= formatExceptionFormatException
        ]

instance FromJSON FormatException where
    parseJSON (Object v) = FormatException
        <$> v .: "FormatException"

instance ToJSON Friend where
    toJSON (Friend friendFriend) =
        object $ foldMap (maybe [] pure)
        [ Just $ "friend" .= friendFriend
        ]

instance FromJSON Friend where
    parseJSON (Object v) = Friend
        <$> v .: "friend"

instance ToJSON From where
    toJSON (From fromFrom) =
        object $ foldMap (maybe [] pure)
        [ Just $ "from" .= fromFrom
        ]

instance FromJSON From where
    parseJSON (Object v) = From
        <$> v .: "from"

instance ToJSON FromDict where
    toJSON (FromDict fromDictFromDict) =
        object $ foldMap (maybe [] pure)
        [ Just $ "from_dict" .= fromDictFromDict
        ]

instance FromJSON FromDict where
    parseJSON (Object v) = FromDict
        <$> v .: "from_dict"

instance ToJSON FromJSONClass where
    toJSON (FromJSONClass fromJSONFromJSONClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "from_json" .= fromJSONFromJSONClass
        ]

instance FromJSON FromJSONClass where
    parseJSON (Object v) = FromJSONClass
        <$> v .: "from_json"

instance ToJSON Func where
    toJSON (Func funcFunc) =
        object $ foldMap (maybe [] pure)
        [ Just $ "func" .= funcFunc
        ]

instance FromJSON Func where
    parseJSON (Object v) = Func
        <$> v .: "func"

instance ToJSON Default where
    toJSON (Default defaultDefaultDefault) =
        object $ foldMap (maybe [] pure)
        [ Just $ "default" .= defaultDefaultDefault
        ]

instance FromJSON Default where
    parseJSON (Object v) = Default
        <$> v .: "default"

instance ToJSON Do where
    toJSON (Do doDoDo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "do" .= doDoDo
        ]

instance FromJSON Do where
    parseJSON (Object v) = Do
        <$> v .: "do"

instance ToJSON Else where
    toJSON (Else elseElseElse) =
        object $ foldMap (maybe [] pure)
        [ Just $ "else" .= elseElseElse
        ]

instance FromJSON Else where
    parseJSON (Object v) = Else
        <$> v .: "else"

instance ToJSON Obj2False where
    toJSON (Obj2False falseObj2False) =
        object $ foldMap (maybe [] pure)
        [ Just $ "false" .= falseObj2False
        ]

instance FromJSON Obj2False where
    parseJSON (Object v) = Obj2False
        <$> v .: "false"

instance ToJSON Obj3 where
    toJSON (Obj3 dummyObj3 functionObj3 getObj3 globalObj3 goObj3 gotoObj3 guardObj3 hasOwnPropertyObj3 hashCodeObj3 hashableObj3 hasherObj3 impObj3 implementsObj3 implicitObj3 indirectObj3 initObj3 inlineObj3 inoutObj3 instanceofObj3 intObj3 intNodeObj3 interfaceObj3 internalObj3 isObj3 isoDateTimeOffsetConverterObj3 iterableObj3 jdecObj3 jencObj3 jpipeObj3 jsonObj3 jsonAnyObj3 jsonCodingKeyObj3 jsonConverterObj3 jsonDecoderObj3 jsonEncoderObj3 jsonExceptionObj3 jsonGeneratorObj3 jsonNodeObj3 jsonNullObj3 jsonParserObj3 jsonReaderObj3 jsonSerializerObj3 jsonTokenObj3 jsonTokenTypeObj3 jsonWriterObj3 lambdaObj3 lazyObj3 leftObj3 listObj3 localDateObj3 localeObj3 lockObj3 longObj3 longNodeObj3 mapObj3 mapEntryObj3 marshalJSONObj3 metadataPropertyHandlingObj3 obj3IDObj3 obj3IfObj3 obj3ImportObj3 obj3InObj3 obj3InfixObj3 obj3LetObj3 obj3ModuleObj3) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dummy" .= dummyObj3
        , Just $ "function" .= functionObj3
        , Just $ "get" .= getObj3
        , Just $ "global" .= globalObj3
        , Just $ "go" .= goObj3
        , Just $ "goto" .= gotoObj3
        , Just $ "guard" .= guardObj3
        , Just $ "hasOwnProperty" .= hasOwnPropertyObj3
        , Just $ "hashCode" .= hashCodeObj3
        , Just $ "Hashable" .= hashableObj3
        , Just $ "Hasher" .= hasherObj3
        , Just $ "IMP" .= impObj3
        , Just $ "implements" .= implementsObj3
        , Just $ "implicit" .= implicitObj3
        , Just $ "indirect" .= indirectObj3
        , Just $ "init" .= initObj3
        , Just $ "inline" .= inlineObj3
        , Just $ "inout" .= inoutObj3
        , Just $ "instanceof" .= instanceofObj3
        , Just $ "int" .= intObj3
        , Just $ "IntNode" .= intNodeObj3
        , Just $ "interface" .= interfaceObj3
        , Just $ "internal" .= internalObj3
        , Just $ "is" .= isObj3
        , Just $ "IsoDateTimeOffsetConverter" .= isoDateTimeOffsetConverterObj3
        , Just $ "iterable" .= iterableObj3
        , Just $ "jdec" .= jdecObj3
        , Just $ "jenc" .= jencObj3
        , Just $ "jpipe" .= jpipeObj3
        , Just $ "json" .= jsonObj3
        , Just $ "JSONAny" .= jsonAnyObj3
        , Just $ "JSONCodingKey" .= jsonCodingKeyObj3
        , Just $ "json_converter" .= jsonConverterObj3
        , Just $ "JSONDecoder" .= jsonDecoderObj3
        , Just $ "JSONEncoder" .= jsonEncoderObj3
        , Just $ "JsonException" .= jsonExceptionObj3
        , Just $ "JsonGenerator" .= jsonGeneratorObj3
        , Just $ "JsonNode" .= jsonNodeObj3
        , Just $ "JSONNull" .= jsonNullObj3
        , Just $ "JsonParser" .= jsonParserObj3
        , Just $ "JsonReader" .= jsonReaderObj3
        , Just $ "json_serializer" .= jsonSerializerObj3
        , Just $ "json_token" .= jsonTokenObj3
        , Just $ "JsonTokenType" .= jsonTokenTypeObj3
        , Just $ "json_writer" .= jsonWriterObj3
        , Just $ "lambda" .= lambdaObj3
        , Just $ "lazy" .= lazyObj3
        , Just $ "left" .= leftObj3
        , Just $ "list" .= listObj3
        , Just $ "LocalDate" .= localDateObj3
        , Just $ "Locale" .= localeObj3
        , Just $ "lock" .= lockObj3
        , Just $ "long" .= longObj3
        , Just $ "LongNode" .= longNodeObj3
        , Just $ "map" .= mapObj3
        , Just $ "MapEntry" .= mapEntryObj3
        , Just $ "MarshalJSON" .= marshalJSONObj3
        , Just $ "metadata_property_handling" .= metadataPropertyHandlingObj3
        , Just $ "id" .= obj3IDObj3
        , Just $ "if" .= obj3IfObj3
        , Just $ "import" .= obj3ImportObj3
        , Just $ "in" .= obj3InObj3
        , Just $ "infix" .= obj3InfixObj3
        , Just $ "let" .= obj3LetObj3
        , Just $ "module" .= obj3ModuleObj3
        ]

instance FromJSON Obj3 where
    parseJSON (Object v) = Obj3
        <$> v .: "dummy"
        <*> v .: "function"
        <*> v .: "get"
        <*> v .: "global"
        <*> v .: "go"
        <*> v .: "goto"
        <*> v .: "guard"
        <*> v .: "hasOwnProperty"
        <*> v .: "hashCode"
        <*> v .: "Hashable"
        <*> v .: "Hasher"
        <*> v .: "IMP"
        <*> v .: "implements"
        <*> v .: "implicit"
        <*> v .: "indirect"
        <*> v .: "init"
        <*> v .: "inline"
        <*> v .: "inout"
        <*> v .: "instanceof"
        <*> v .: "int"
        <*> v .: "IntNode"
        <*> v .: "interface"
        <*> v .: "internal"
        <*> v .: "is"
        <*> v .: "IsoDateTimeOffsetConverter"
        <*> v .: "iterable"
        <*> v .: "jdec"
        <*> v .: "jenc"
        <*> v .: "jpipe"
        <*> v .: "json"
        <*> v .: "JSONAny"
        <*> v .: "JSONCodingKey"
        <*> v .: "json_converter"
        <*> v .: "JSONDecoder"
        <*> v .: "JSONEncoder"
        <*> v .: "JsonException"
        <*> v .: "JsonGenerator"
        <*> v .: "JsonNode"
        <*> v .: "JSONNull"
        <*> v .: "JsonParser"
        <*> v .: "JsonReader"
        <*> v .: "json_serializer"
        <*> v .: "json_token"
        <*> v .: "JsonTokenType"
        <*> v .: "json_writer"
        <*> v .: "lambda"
        <*> v .: "lazy"
        <*> v .: "left"
        <*> v .: "list"
        <*> v .: "LocalDate"
        <*> v .: "Locale"
        <*> v .: "lock"
        <*> v .: "long"
        <*> v .: "LongNode"
        <*> v .: "map"
        <*> v .: "MapEntry"
        <*> v .: "MarshalJSON"
        <*> v .: "metadata_property_handling"
        <*> v .: "id"
        <*> v .: "if"
        <*> v .: "import"
        <*> v .: "in"
        <*> v .: "infix"
        <*> v .: "let"
        <*> v .: "module"

instance ToJSON Function where
    toJSON (Function functionFunction) =
        object $ foldMap (maybe [] pure)
        [ Just $ "function" .= functionFunction
        ]

instance FromJSON Function where
    parseJSON (Object v) = Function
        <$> v .: "function"

instance ToJSON Get where
    toJSON (Get getGet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getGet
        ]

instance FromJSON Get where
    parseJSON (Object v) = Get
        <$> v .: "get"

instance ToJSON Global where
    toJSON (Global globalGlobal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "global" .= globalGlobal
        ]

instance FromJSON Global where
    parseJSON (Object v) = Global
        <$> v .: "global"

instance ToJSON Go where
    toJSON (Go goGo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "go" .= goGo
        ]

instance FromJSON Go where
    parseJSON (Object v) = Go
        <$> v .: "go"

instance ToJSON Goto where
    toJSON (Goto gotoGoto) =
        object $ foldMap (maybe [] pure)
        [ Just $ "goto" .= gotoGoto
        ]

instance FromJSON Goto where
    parseJSON (Object v) = Goto
        <$> v .: "goto"

instance ToJSON Guard where
    toJSON (Guard guardGuard) =
        object $ foldMap (maybe [] pure)
        [ Just $ "guard" .= guardGuard
        ]

instance FromJSON Guard where
    parseJSON (Object v) = Guard
        <$> v .: "guard"

instance ToJSON HasOwnProperty where
    toJSON (HasOwnProperty hasOwnPropertyHasOwnProperty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "hasOwnProperty" .= hasOwnPropertyHasOwnProperty
        ]

instance FromJSON HasOwnProperty where
    parseJSON (Object v) = HasOwnProperty
        <$> v .: "hasOwnProperty"

instance ToJSON HashCode where
    toJSON (HashCode hashCodeHashCode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "hashCode" .= hashCodeHashCode
        ]

instance FromJSON HashCode where
    parseJSON (Object v) = HashCode
        <$> v .: "hashCode"

instance ToJSON Hashable where
    toJSON (Hashable hashableHashable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Hashable" .= hashableHashable
        ]

instance FromJSON Hashable where
    parseJSON (Object v) = Hashable
        <$> v .: "Hashable"

instance ToJSON Hasher where
    toJSON (Hasher hasherHasher) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Hasher" .= hasherHasher
        ]

instance FromJSON Hasher where
    parseJSON (Object v) = Hasher
        <$> v .: "Hasher"

instance ToJSON Imp where
    toJSON (Imp impImp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "IMP" .= impImp
        ]

instance FromJSON Imp where
    parseJSON (Object v) = Imp
        <$> v .: "IMP"

instance ToJSON Implements where
    toJSON (Implements implementsImplements) =
        object $ foldMap (maybe [] pure)
        [ Just $ "implements" .= implementsImplements
        ]

instance FromJSON Implements where
    parseJSON (Object v) = Implements
        <$> v .: "implements"

instance ToJSON Implicit where
    toJSON (Implicit implicitImplicit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "implicit" .= implicitImplicit
        ]

instance FromJSON Implicit where
    parseJSON (Object v) = Implicit
        <$> v .: "implicit"

instance ToJSON Indirect where
    toJSON (Indirect indirectIndirect) =
        object $ foldMap (maybe [] pure)
        [ Just $ "indirect" .= indirectIndirect
        ]

instance FromJSON Indirect where
    parseJSON (Object v) = Indirect
        <$> v .: "indirect"

instance ToJSON Init where
    toJSON (Init initInit) =
        object $ foldMap (maybe [] pure)
        [ Just $ "init" .= initInit
        ]

instance FromJSON Init where
    parseJSON (Object v) = Init
        <$> v .: "init"

instance ToJSON Inline where
    toJSON (Inline inlineInline) =
        object $ foldMap (maybe [] pure)
        [ Just $ "inline" .= inlineInline
        ]

instance FromJSON Inline where
    parseJSON (Object v) = Inline
        <$> v .: "inline"

instance ToJSON Inout where
    toJSON (Inout inoutInout) =
        object $ foldMap (maybe [] pure)
        [ Just $ "inout" .= inoutInout
        ]

instance FromJSON Inout where
    parseJSON (Object v) = Inout
        <$> v .: "inout"

instance ToJSON Instanceof where
    toJSON (Instanceof instanceofInstanceof) =
        object $ foldMap (maybe [] pure)
        [ Just $ "instanceof" .= instanceofInstanceof
        ]

instance FromJSON Instanceof where
    parseJSON (Object v) = Instanceof
        <$> v .: "instanceof"

instance ToJSON IntClass where
    toJSON (IntClass intIntClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "int" .= intIntClass
        ]

instance FromJSON IntClass where
    parseJSON (Object v) = IntClass
        <$> v .: "int"

instance ToJSON IntNode where
    toJSON (IntNode intNodeIntNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "IntNode" .= intNodeIntNode
        ]

instance FromJSON IntNode where
    parseJSON (Object v) = IntNode
        <$> v .: "IntNode"

instance ToJSON Interface where
    toJSON (Interface interfaceInterface) =
        object $ foldMap (maybe [] pure)
        [ Just $ "interface" .= interfaceInterface
        ]

instance FromJSON Interface where
    parseJSON (Object v) = Interface
        <$> v .: "interface"

instance ToJSON Internal where
    toJSON (Internal internalInternal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "internal" .= internalInternal
        ]

instance FromJSON Internal where
    parseJSON (Object v) = Internal
        <$> v .: "internal"

instance ToJSON Is where
    toJSON (Is isIs) =
        object $ foldMap (maybe [] pure)
        [ Just $ "is" .= isIs
        ]

instance FromJSON Is where
    parseJSON (Object v) = Is
        <$> v .: "is"

instance ToJSON ISODateTimeOffsetConverter where
    toJSON (ISODateTimeOffsetConverter isoDateTimeOffsetConverterISODateTimeOffsetConverter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "IsoDateTimeOffsetConverter" .= isoDateTimeOffsetConverterISODateTimeOffsetConverter
        ]

instance FromJSON ISODateTimeOffsetConverter where
    parseJSON (Object v) = ISODateTimeOffsetConverter
        <$> v .: "IsoDateTimeOffsetConverter"

instance ToJSON Iterable where
    toJSON (Iterable iterableIterable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "iterable" .= iterableIterable
        ]

instance FromJSON Iterable where
    parseJSON (Object v) = Iterable
        <$> v .: "iterable"

instance ToJSON Jdec where
    toJSON (Jdec jdecJdec) =
        object $ foldMap (maybe [] pure)
        [ Just $ "jdec" .= jdecJdec
        ]

instance FromJSON Jdec where
    parseJSON (Object v) = Jdec
        <$> v .: "jdec"

instance ToJSON Jenc where
    toJSON (Jenc jencJenc) =
        object $ foldMap (maybe [] pure)
        [ Just $ "jenc" .= jencJenc
        ]

instance FromJSON Jenc where
    parseJSON (Object v) = Jenc
        <$> v .: "jenc"

instance ToJSON Jpipe where
    toJSON (Jpipe jpipeJpipe) =
        object $ foldMap (maybe [] pure)
        [ Just $ "jpipe" .= jpipeJpipe
        ]

instance FromJSON Jpipe where
    parseJSON (Object v) = Jpipe
        <$> v .: "jpipe"

instance ToJSON JSON where
    toJSON (JSON jsonJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "json" .= jsonJSON
        ]

instance FromJSON JSON where
    parseJSON (Object v) = JSON
        <$> v .: "json"

instance ToJSON JSONAny where
    toJSON (JSONAny jsonAnyJSONAny) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JSONAny" .= jsonAnyJSONAny
        ]

instance FromJSON JSONAny where
    parseJSON (Object v) = JSONAny
        <$> v .: "JSONAny"

instance ToJSON JSONCodingKey where
    toJSON (JSONCodingKey jsonCodingKeyJSONCodingKey) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JSONCodingKey" .= jsonCodingKeyJSONCodingKey
        ]

instance FromJSON JSONCodingKey where
    parseJSON (Object v) = JSONCodingKey
        <$> v .: "JSONCodingKey"

instance ToJSON JSONConverter where
    toJSON (JSONConverter jsonConverterJSONConverter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "json_converter" .= jsonConverterJSONConverter
        ]

instance FromJSON JSONConverter where
    parseJSON (Object v) = JSONConverter
        <$> v .: "json_converter"

instance ToJSON JSONDecoder where
    toJSON (JSONDecoder jsonDecoderJSONDecoder) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JSONDecoder" .= jsonDecoderJSONDecoder
        ]

instance FromJSON JSONDecoder where
    parseJSON (Object v) = JSONDecoder
        <$> v .: "JSONDecoder"

instance ToJSON JSONEncoder where
    toJSON (JSONEncoder jsonEncoderJSONEncoder) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JSONEncoder" .= jsonEncoderJSONEncoder
        ]

instance FromJSON JSONEncoder where
    parseJSON (Object v) = JSONEncoder
        <$> v .: "JSONEncoder"

instance ToJSON JSONException where
    toJSON (JSONException jsonExceptionJSONException) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonException" .= jsonExceptionJSONException
        ]

instance FromJSON JSONException where
    parseJSON (Object v) = JSONException
        <$> v .: "JsonException"

instance ToJSON JSONGenerator where
    toJSON (JSONGenerator jsonGeneratorJSONGenerator) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonGenerator" .= jsonGeneratorJSONGenerator
        ]

instance FromJSON JSONGenerator where
    parseJSON (Object v) = JSONGenerator
        <$> v .: "JsonGenerator"

instance ToJSON JSONNode where
    toJSON (JSONNode jsonNodeJSONNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonNode" .= jsonNodeJSONNode
        ]

instance FromJSON JSONNode where
    parseJSON (Object v) = JSONNode
        <$> v .: "JsonNode"

instance ToJSON JSONNull where
    toJSON (JSONNull jsonNullJSONNull) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JSONNull" .= jsonNullJSONNull
        ]

instance FromJSON JSONNull where
    parseJSON (Object v) = JSONNull
        <$> v .: "JSONNull"

instance ToJSON JSONParser where
    toJSON (JSONParser jsonParserJSONParser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonParser" .= jsonParserJSONParser
        ]

instance FromJSON JSONParser where
    parseJSON (Object v) = JSONParser
        <$> v .: "JsonParser"

instance ToJSON JSONReader where
    toJSON (JSONReader jsonReaderJSONReader) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonReader" .= jsonReaderJSONReader
        ]

instance FromJSON JSONReader where
    parseJSON (Object v) = JSONReader
        <$> v .: "JsonReader"

instance ToJSON JSONSerializer where
    toJSON (JSONSerializer jsonSerializerJSONSerializer) =
        object $ foldMap (maybe [] pure)
        [ Just $ "json_serializer" .= jsonSerializerJSONSerializer
        ]

instance FromJSON JSONSerializer where
    parseJSON (Object v) = JSONSerializer
        <$> v .: "json_serializer"

instance ToJSON JSONToken where
    toJSON (JSONToken jsonTokenJSONToken) =
        object $ foldMap (maybe [] pure)
        [ Just $ "json_token" .= jsonTokenJSONToken
        ]

instance FromJSON JSONToken where
    parseJSON (Object v) = JSONToken
        <$> v .: "json_token"

instance ToJSON JSONTokenType where
    toJSON (JSONTokenType jsonTokenTypeJSONTokenType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "JsonTokenType" .= jsonTokenTypeJSONTokenType
        ]

instance FromJSON JSONTokenType where
    parseJSON (Object v) = JSONTokenType
        <$> v .: "JsonTokenType"

instance ToJSON JSONWriter where
    toJSON (JSONWriter jsonWriterJSONWriter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "json_writer" .= jsonWriterJSONWriter
        ]

instance FromJSON JSONWriter where
    parseJSON (Object v) = JSONWriter
        <$> v .: "json_writer"

instance ToJSON Lambda where
    toJSON (Lambda lambdaLambda) =
        object $ foldMap (maybe [] pure)
        [ Just $ "lambda" .= lambdaLambda
        ]

instance FromJSON Lambda where
    parseJSON (Object v) = Lambda
        <$> v .: "lambda"

instance ToJSON Lazy where
    toJSON (Lazy lazyLazy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "lazy" .= lazyLazy
        ]

instance FromJSON Lazy where
    parseJSON (Object v) = Lazy
        <$> v .: "lazy"

instance ToJSON LeftClass where
    toJSON (LeftClass leftLeftClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "left" .= leftLeftClass
        ]

instance FromJSON LeftClass where
    parseJSON (Object v) = LeftClass
        <$> v .: "left"

instance ToJSON List where
    toJSON (List listList) =
        object $ foldMap (maybe [] pure)
        [ Just $ "list" .= listList
        ]

instance FromJSON List where
    parseJSON (Object v) = List
        <$> v .: "list"

instance ToJSON LocalDate where
    toJSON (LocalDate localDateLocalDate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "LocalDate" .= localDateLocalDate
        ]

instance FromJSON LocalDate where
    parseJSON (Object v) = LocalDate
        <$> v .: "LocalDate"

instance ToJSON Locale where
    toJSON (Locale localeLocale) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Locale" .= localeLocale
        ]

instance FromJSON Locale where
    parseJSON (Object v) = Locale
        <$> v .: "Locale"

instance ToJSON Lock where
    toJSON (Lock lockLock) =
        object $ foldMap (maybe [] pure)
        [ Just $ "lock" .= lockLock
        ]

instance FromJSON Lock where
    parseJSON (Object v) = Lock
        <$> v .: "lock"

instance ToJSON Long where
    toJSON (Long longLong) =
        object $ foldMap (maybe [] pure)
        [ Just $ "long" .= longLong
        ]

instance FromJSON Long where
    parseJSON (Object v) = Long
        <$> v .: "long"

instance ToJSON LongNode where
    toJSON (LongNode longNodeLongNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "LongNode" .= longNodeLongNode
        ]

instance FromJSON LongNode where
    parseJSON (Object v) = LongNode
        <$> v .: "LongNode"

instance ToJSON MapClass where
    toJSON (MapClass mapMapClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "map" .= mapMapClass
        ]

instance FromJSON MapClass where
    parseJSON (Object v) = MapClass
        <$> v .: "map"

instance ToJSON MapEntry where
    toJSON (MapEntry mapEntryMapEntry) =
        object $ foldMap (maybe [] pure)
        [ Just $ "MapEntry" .= mapEntryMapEntry
        ]

instance FromJSON MapEntry where
    parseJSON (Object v) = MapEntry
        <$> v .: "MapEntry"

instance ToJSON MarshalJSON where
    toJSON (MarshalJSON marshalJSONMarshalJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "MarshalJSON" .= marshalJSONMarshalJSON
        ]

instance FromJSON MarshalJSON where
    parseJSON (Object v) = MarshalJSON
        <$> v .: "MarshalJSON"

instance ToJSON MetadataPropertyHandling where
    toJSON (MetadataPropertyHandling metadataPropertyHandlingMetadataPropertyHandling) =
        object $ foldMap (maybe [] pure)
        [ Just $ "metadata_property_handling" .= metadataPropertyHandlingMetadataPropertyHandling
        ]

instance FromJSON MetadataPropertyHandling where
    parseJSON (Object v) = MetadataPropertyHandling
        <$> v .: "metadata_property_handling"

instance ToJSON ID where
    toJSON (ID idIDID) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= idIDID
        ]

instance FromJSON ID where
    parseJSON (Object v) = ID
        <$> v .: "id"

instance ToJSON If where
    toJSON (If ifIfIf) =
        object $ foldMap (maybe [] pure)
        [ Just $ "if" .= ifIfIf
        ]

instance FromJSON If where
    parseJSON (Object v) = If
        <$> v .: "if"

instance ToJSON Import where
    toJSON (Import importImportImport) =
        object $ foldMap (maybe [] pure)
        [ Just $ "import" .= importImportImport
        ]

instance FromJSON Import where
    parseJSON (Object v) = Import
        <$> v .: "import"

instance ToJSON In where
    toJSON (In inInIn) =
        object $ foldMap (maybe [] pure)
        [ Just $ "in" .= inInIn
        ]

instance FromJSON In where
    parseJSON (Object v) = In
        <$> v .: "in"

instance ToJSON Infix where
    toJSON (Infix infixInfixInfix) =
        object $ foldMap (maybe [] pure)
        [ Just $ "infix" .= infixInfixInfix
        ]

instance FromJSON Infix where
    parseJSON (Object v) = Infix
        <$> v .: "infix"

instance ToJSON Let where
    toJSON (Let letLetLet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "let" .= letLetLet
        ]

instance FromJSON Let where
    parseJSON (Object v) = Let
        <$> v .: "let"

instance ToJSON Module where
    toJSON (Module moduleModuleModule) =
        object $ foldMap (maybe [] pure)
        [ Just $ "module" .= moduleModuleModule
        ]

instance FromJSON Module where
    parseJSON (Object v) = Module
        <$> v .: "module"

instance ToJSON Obj4 where
    toJSON (Obj4 dummyObj4 mutableObj4 mutatingObj4 namespaceObj4 nativeObj4 newObj4 newtonsoftObj4 nilObj4 noObj4 noSuchMethodObj4 noexceptObj4 nonatomicObj4 noneObj4 nonlocalObj4 nonmutatingObj4 notObj4 notEqObj4 nsErrorObj4 nsObjectObj4 nsStringObj4 nullObj4 nullNodeObj4 nullptrObj4 numberObj4 obj4NoneObj4 obj4NullObj4 obj4OfObj4 obj4ProtocolObj4 objectObj4 objectMapperObj4 objectNodeObj4 objectReaderObj4 objectWriterObj4 offsetDateTimeObj4 offsetTimeObj4 onewayObj4 openObj4 operatorObj4 optionalObj4 orObj4 orEqObj4 outObj4 overrideObj4 packageObj4 paramsObj4 passObj4 portObj4 postfixObj4 precedenceObj4 prefixObj4 printObj4 printMembersObj4 printfObj4 privateObj4 protectedObj4 protocolObj4 publicObj4 quicktypeObj4 raiseObj4 rangeObj4 readonlyObj4 refObj4 regExpObj4 registerObj4 reinterpretCastObj4) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dummy" .= dummyObj4
        , Just $ "mutable" .= mutableObj4
        , Just $ "mutating" .= mutatingObj4
        , Just $ "namespace" .= namespaceObj4
        , Just $ "native" .= nativeObj4
        , Just $ "new" .= newObj4
        , Just $ "newtonsoft" .= newtonsoftObj4
        , Just $ "nil" .= nilObj4
        , Just $ "NO" .= noObj4
        , Just $ "noSuchMethod" .= noSuchMethodObj4
        , Just $ "noexcept" .= noexceptObj4
        , Just $ "nonatomic" .= nonatomicObj4
        , Just $ "None" .= noneObj4
        , Just $ "nonlocal" .= nonlocalObj4
        , Just $ "nonmutating" .= nonmutatingObj4
        , Just $ "not" .= notObj4
        , Just $ "not_eq" .= notEqObj4
        , Just $ "NSError" .= nsErrorObj4
        , Just $ "NSObject" .= nsObjectObj4
        , Just $ "NSString" .= nsStringObj4
        , Just $ "NULL" .= nullObj4
        , Just $ "NullNode" .= nullNodeObj4
        , Just $ "nullptr" .= nullptrObj4
        , Just $ "number" .= numberObj4
        , Just $ "none" .= obj4NoneObj4
        , Just $ "null" .= obj4NullObj4
        , Just $ "of" .= obj4OfObj4
        , Just $ "protocol" .= obj4ProtocolObj4
        , Just $ "object" .= objectObj4
        , Just $ "ObjectMapper" .= objectMapperObj4
        , Just $ "ObjectNode" .= objectNodeObj4
        , Just $ "ObjectReader" .= objectReaderObj4
        , Just $ "ObjectWriter" .= objectWriterObj4
        , Just $ "OffsetDateTime" .= offsetDateTimeObj4
        , Just $ "OffsetTime" .= offsetTimeObj4
        , Just $ "oneway" .= onewayObj4
        , Just $ "open" .= openObj4
        , Just $ "operator" .= operatorObj4
        , Just $ "optional" .= optionalObj4
        , Just $ "or" .= orObj4
        , Just $ "or_eq" .= orEqObj4
        , Just $ "out" .= outObj4
        , Just $ "override" .= overrideObj4
        , Just $ "package" .= packageObj4
        , Just $ "params" .= paramsObj4
        , Just $ "pass" .= passObj4
        , Just $ "port" .= portObj4
        , Just $ "postfix" .= postfixObj4
        , Just $ "precedence" .= precedenceObj4
        , Just $ "prefix" .= prefixObj4
        , Just $ "print" .= printObj4
        , Just $ "printMembers" .= printMembersObj4
        , Just $ "printf" .= printfObj4
        , Just $ "private" .= privateObj4
        , Just $ "protected" .= protectedObj4
        , Just $ "Protocol" .= protocolObj4
        , Just $ "public" .= publicObj4
        , Just $ "quicktype" .= quicktypeObj4
        , Just $ "raise" .= raiseObj4
        , Just $ "range" .= rangeObj4
        , Just $ "readonly" .= readonlyObj4
        , Just $ "ref" .= refObj4
        , Just $ "RegExp" .= regExpObj4
        , Just $ "register" .= registerObj4
        , Just $ "reinterpret_cast" .= reinterpretCastObj4
        ]

instance FromJSON Obj4 where
    parseJSON (Object v) = Obj4
        <$> v .: "dummy"
        <*> v .: "mutable"
        <*> v .: "mutating"
        <*> v .: "namespace"
        <*> v .: "native"
        <*> v .: "new"
        <*> v .: "newtonsoft"
        <*> v .: "nil"
        <*> v .: "NO"
        <*> v .: "noSuchMethod"
        <*> v .: "noexcept"
        <*> v .: "nonatomic"
        <*> v .: "None"
        <*> v .: "nonlocal"
        <*> v .: "nonmutating"
        <*> v .: "not"
        <*> v .: "not_eq"
        <*> v .: "NSError"
        <*> v .: "NSObject"
        <*> v .: "NSString"
        <*> v .: "NULL"
        <*> v .: "NullNode"
        <*> v .: "nullptr"
        <*> v .: "number"
        <*> v .: "none"
        <*> v .: "null"
        <*> v .: "of"
        <*> v .: "protocol"
        <*> v .: "object"
        <*> v .: "ObjectMapper"
        <*> v .: "ObjectNode"
        <*> v .: "ObjectReader"
        <*> v .: "ObjectWriter"
        <*> v .: "OffsetDateTime"
        <*> v .: "OffsetTime"
        <*> v .: "oneway"
        <*> v .: "open"
        <*> v .: "operator"
        <*> v .: "optional"
        <*> v .: "or"
        <*> v .: "or_eq"
        <*> v .: "out"
        <*> v .: "override"
        <*> v .: "package"
        <*> v .: "params"
        <*> v .: "pass"
        <*> v .: "port"
        <*> v .: "postfix"
        <*> v .: "precedence"
        <*> v .: "prefix"
        <*> v .: "print"
        <*> v .: "printMembers"
        <*> v .: "printf"
        <*> v .: "private"
        <*> v .: "protected"
        <*> v .: "Protocol"
        <*> v .: "public"
        <*> v .: "quicktype"
        <*> v .: "raise"
        <*> v .: "range"
        <*> v .: "readonly"
        <*> v .: "ref"
        <*> v .: "RegExp"
        <*> v .: "register"
        <*> v .: "reinterpret_cast"

instance ToJSON Mutable where
    toJSON (Mutable mutableMutable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "mutable" .= mutableMutable
        ]

instance FromJSON Mutable where
    parseJSON (Object v) = Mutable
        <$> v .: "mutable"

instance ToJSON Mutating where
    toJSON (Mutating mutatingMutating) =
        object $ foldMap (maybe [] pure)
        [ Just $ "mutating" .= mutatingMutating
        ]

instance FromJSON Mutating where
    parseJSON (Object v) = Mutating
        <$> v .: "mutating"

instance ToJSON Namespace where
    toJSON (Namespace namespaceNamespace) =
        object $ foldMap (maybe [] pure)
        [ Just $ "namespace" .= namespaceNamespace
        ]

instance FromJSON Namespace where
    parseJSON (Object v) = Namespace
        <$> v .: "namespace"

instance ToJSON Native where
    toJSON (Native nativeNative) =
        object $ foldMap (maybe [] pure)
        [ Just $ "native" .= nativeNative
        ]

instance FromJSON Native where
    parseJSON (Object v) = Native
        <$> v .: "native"

instance ToJSON New where
    toJSON (New newNew) =
        object $ foldMap (maybe [] pure)
        [ Just $ "new" .= newNew
        ]

instance FromJSON New where
    parseJSON (Object v) = New
        <$> v .: "new"

instance ToJSON Newtonsoft where
    toJSON (Newtonsoft newtonsoftNewtonsoft) =
        object $ foldMap (maybe [] pure)
        [ Just $ "newtonsoft" .= newtonsoftNewtonsoft
        ]

instance FromJSON Newtonsoft where
    parseJSON (Object v) = Newtonsoft
        <$> v .: "newtonsoft"

instance ToJSON Nil where
    toJSON (Nil nilNil) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nil" .= nilNil
        ]

instance FromJSON Nil where
    parseJSON (Object v) = Nil
        <$> v .: "nil"

instance ToJSON No where
    toJSON (No noNo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NO" .= noNo
        ]

instance FromJSON No where
    parseJSON (Object v) = No
        <$> v .: "NO"

instance ToJSON NoSuchMethod where
    toJSON (NoSuchMethod noSuchMethodNoSuchMethod) =
        object $ foldMap (maybe [] pure)
        [ Just $ "noSuchMethod" .= noSuchMethodNoSuchMethod
        ]

instance FromJSON NoSuchMethod where
    parseJSON (Object v) = NoSuchMethod
        <$> v .: "noSuchMethod"

instance ToJSON Noexcept where
    toJSON (Noexcept noexceptNoexcept) =
        object $ foldMap (maybe [] pure)
        [ Just $ "noexcept" .= noexceptNoexcept
        ]

instance FromJSON Noexcept where
    parseJSON (Object v) = Noexcept
        <$> v .: "noexcept"

instance ToJSON Nonatomic where
    toJSON (Nonatomic nonatomicNonatomic) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nonatomic" .= nonatomicNonatomic
        ]

instance FromJSON Nonatomic where
    parseJSON (Object v) = Nonatomic
        <$> v .: "nonatomic"

instance ToJSON None where
    toJSON (None noneNone) =
        object $ foldMap (maybe [] pure)
        [ Just $ "None" .= noneNone
        ]

instance FromJSON None where
    parseJSON (Object v) = None
        <$> v .: "None"

instance ToJSON Nonlocal where
    toJSON (Nonlocal nonlocalNonlocal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nonlocal" .= nonlocalNonlocal
        ]

instance FromJSON Nonlocal where
    parseJSON (Object v) = Nonlocal
        <$> v .: "nonlocal"

instance ToJSON Nonmutating where
    toJSON (Nonmutating nonmutatingNonmutating) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nonmutating" .= nonmutatingNonmutating
        ]

instance FromJSON Nonmutating where
    parseJSON (Object v) = Nonmutating
        <$> v .: "nonmutating"

instance ToJSON Not where
    toJSON (Not notNot) =
        object $ foldMap (maybe [] pure)
        [ Just $ "not" .= notNot
        ]

instance FromJSON Not where
    parseJSON (Object v) = Not
        <$> v .: "not"

instance ToJSON NotEq where
    toJSON (NotEq notEqNotEq) =
        object $ foldMap (maybe [] pure)
        [ Just $ "not_eq" .= notEqNotEq
        ]

instance FromJSON NotEq where
    parseJSON (Object v) = NotEq
        <$> v .: "not_eq"

instance ToJSON NSError where
    toJSON (NSError nsErrorNSError) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NSError" .= nsErrorNSError
        ]

instance FromJSON NSError where
    parseJSON (Object v) = NSError
        <$> v .: "NSError"

instance ToJSON NSObject where
    toJSON (NSObject nsObjectNSObject) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NSObject" .= nsObjectNSObject
        ]

instance FromJSON NSObject where
    parseJSON (Object v) = NSObject
        <$> v .: "NSObject"

instance ToJSON NSString where
    toJSON (NSString nsStringNSString) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NSString" .= nsStringNSString
        ]

instance FromJSON NSString where
    parseJSON (Object v) = NSString
        <$> v .: "NSString"

instance ToJSON NULLClass where
    toJSON (NULLClass nullNULLClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NULL" .= nullNULLClass
        ]

instance FromJSON NULLClass where
    parseJSON (Object v) = NULLClass
        <$> v .: "NULL"

instance ToJSON NullNode where
    toJSON (NullNode nullNodeNullNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "NullNode" .= nullNodeNullNode
        ]

instance FromJSON NullNode where
    parseJSON (Object v) = NullNode
        <$> v .: "NullNode"

instance ToJSON Nullptr where
    toJSON (Nullptr nullptrNullptr) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nullptr" .= nullptrNullptr
        ]

instance FromJSON Nullptr where
    parseJSON (Object v) = Nullptr
        <$> v .: "nullptr"

instance ToJSON NumberClass where
    toJSON (NumberClass numberNumberClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "number" .= numberNumberClass
        ]

instance FromJSON NumberClass where
    parseJSON (Object v) = NumberClass
        <$> v .: "number"

instance ToJSON NoneClass where
    toJSON (NoneClass noneNoneClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "none" .= noneNoneClass
        ]

instance FromJSON NoneClass where
    parseJSON (Object v) = NoneClass
        <$> v .: "none"

instance ToJSON NullClass where
    toJSON (NullClass nullNullClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "null" .= nullNullClass
        ]

instance FromJSON NullClass where
    parseJSON (Object v) = NullClass
        <$> v .: "null"

instance ToJSON Of where
    toJSON (Of ofOfOf) =
        object $ foldMap (maybe [] pure)
        [ Just $ "of" .= ofOfOf
        ]

instance FromJSON Of where
    parseJSON (Object v) = Of
        <$> v .: "of"

instance ToJSON ProtocolClass where
    toJSON (ProtocolClass protocolProtocolClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "protocol" .= protocolProtocolClass
        ]

instance FromJSON ProtocolClass where
    parseJSON (Object v) = ProtocolClass
        <$> v .: "protocol"

instance ToJSON ObjectClass where
    toJSON (ObjectClass objectObjectClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "object" .= objectObjectClass
        ]

instance FromJSON ObjectClass where
    parseJSON (Object v) = ObjectClass
        <$> v .: "object"

instance ToJSON ObjectMapper where
    toJSON (ObjectMapper objectMapperObjectMapper) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ObjectMapper" .= objectMapperObjectMapper
        ]

instance FromJSON ObjectMapper where
    parseJSON (Object v) = ObjectMapper
        <$> v .: "ObjectMapper"

instance ToJSON ObjectNode where
    toJSON (ObjectNode objectNodeObjectNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ObjectNode" .= objectNodeObjectNode
        ]

instance FromJSON ObjectNode where
    parseJSON (Object v) = ObjectNode
        <$> v .: "ObjectNode"

instance ToJSON ObjectReader where
    toJSON (ObjectReader objectReaderObjectReader) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ObjectReader" .= objectReaderObjectReader
        ]

instance FromJSON ObjectReader where
    parseJSON (Object v) = ObjectReader
        <$> v .: "ObjectReader"

instance ToJSON ObjectWriter where
    toJSON (ObjectWriter objectWriterObjectWriter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ObjectWriter" .= objectWriterObjectWriter
        ]

instance FromJSON ObjectWriter where
    parseJSON (Object v) = ObjectWriter
        <$> v .: "ObjectWriter"

instance ToJSON OffsetDateTime where
    toJSON (OffsetDateTime offsetDateTimeOffsetDateTime) =
        object $ foldMap (maybe [] pure)
        [ Just $ "OffsetDateTime" .= offsetDateTimeOffsetDateTime
        ]

instance FromJSON OffsetDateTime where
    parseJSON (Object v) = OffsetDateTime
        <$> v .: "OffsetDateTime"

instance ToJSON OffsetTime where
    toJSON (OffsetTime offsetTimeOffsetTime) =
        object $ foldMap (maybe [] pure)
        [ Just $ "OffsetTime" .= offsetTimeOffsetTime
        ]

instance FromJSON OffsetTime where
    parseJSON (Object v) = OffsetTime
        <$> v .: "OffsetTime"

instance ToJSON Oneway where
    toJSON (Oneway onewayOneway) =
        object $ foldMap (maybe [] pure)
        [ Just $ "oneway" .= onewayOneway
        ]

instance FromJSON Oneway where
    parseJSON (Object v) = Oneway
        <$> v .: "oneway"

instance ToJSON Open where
    toJSON (Open openOpen) =
        object $ foldMap (maybe [] pure)
        [ Just $ "open" .= openOpen
        ]

instance FromJSON Open where
    parseJSON (Object v) = Open
        <$> v .: "open"

instance ToJSON Operator where
    toJSON (Operator operatorOperator) =
        object $ foldMap (maybe [] pure)
        [ Just $ "operator" .= operatorOperator
        ]

instance FromJSON Operator where
    parseJSON (Object v) = Operator
        <$> v .: "operator"

instance ToJSON Optional where
    toJSON (Optional optionalOptional) =
        object $ foldMap (maybe [] pure)
        [ Just $ "optional" .= optionalOptional
        ]

instance FromJSON Optional where
    parseJSON (Object v) = Optional
        <$> v .: "optional"

instance ToJSON Or where
    toJSON (Or orOr) =
        object $ foldMap (maybe [] pure)
        [ Just $ "or" .= orOr
        ]

instance FromJSON Or where
    parseJSON (Object v) = Or
        <$> v .: "or"

instance ToJSON OrEq where
    toJSON (OrEq orEqOrEq) =
        object $ foldMap (maybe [] pure)
        [ Just $ "or_eq" .= orEqOrEq
        ]

instance FromJSON OrEq where
    parseJSON (Object v) = OrEq
        <$> v .: "or_eq"

instance ToJSON Out where
    toJSON (Out outOut) =
        object $ foldMap (maybe [] pure)
        [ Just $ "out" .= outOut
        ]

instance FromJSON Out where
    parseJSON (Object v) = Out
        <$> v .: "out"

instance ToJSON Override where
    toJSON (Override overrideOverride) =
        object $ foldMap (maybe [] pure)
        [ Just $ "override" .= overrideOverride
        ]

instance FromJSON Override where
    parseJSON (Object v) = Override
        <$> v .: "override"

instance ToJSON Package where
    toJSON (Package packagePackage) =
        object $ foldMap (maybe [] pure)
        [ Just $ "package" .= packagePackage
        ]

instance FromJSON Package where
    parseJSON (Object v) = Package
        <$> v .: "package"

instance ToJSON Params where
    toJSON (Params paramsParams) =
        object $ foldMap (maybe [] pure)
        [ Just $ "params" .= paramsParams
        ]

instance FromJSON Params where
    parseJSON (Object v) = Params
        <$> v .: "params"

instance ToJSON Pass where
    toJSON (Pass passPass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pass" .= passPass
        ]

instance FromJSON Pass where
    parseJSON (Object v) = Pass
        <$> v .: "pass"

instance ToJSON Port where
    toJSON (Port portPort) =
        object $ foldMap (maybe [] pure)
        [ Just $ "port" .= portPort
        ]

instance FromJSON Port where
    parseJSON (Object v) = Port
        <$> v .: "port"

instance ToJSON Postfix where
    toJSON (Postfix postfixPostfix) =
        object $ foldMap (maybe [] pure)
        [ Just $ "postfix" .= postfixPostfix
        ]

instance FromJSON Postfix where
    parseJSON (Object v) = Postfix
        <$> v .: "postfix"

instance ToJSON Precedence where
    toJSON (Precedence precedencePrecedence) =
        object $ foldMap (maybe [] pure)
        [ Just $ "precedence" .= precedencePrecedence
        ]

instance FromJSON Precedence where
    parseJSON (Object v) = Precedence
        <$> v .: "precedence"

instance ToJSON Prefix where
    toJSON (Prefix prefixPrefix) =
        object $ foldMap (maybe [] pure)
        [ Just $ "prefix" .= prefixPrefix
        ]

instance FromJSON Prefix where
    parseJSON (Object v) = Prefix
        <$> v .: "prefix"

instance ToJSON Print where
    toJSON (Print printPrint) =
        object $ foldMap (maybe [] pure)
        [ Just $ "print" .= printPrint
        ]

instance FromJSON Print where
    parseJSON (Object v) = Print
        <$> v .: "print"

instance ToJSON PrintMembers where
    toJSON (PrintMembers printMembersPrintMembers) =
        object $ foldMap (maybe [] pure)
        [ Just $ "printMembers" .= printMembersPrintMembers
        ]

instance FromJSON PrintMembers where
    parseJSON (Object v) = PrintMembers
        <$> v .: "printMembers"

instance ToJSON Printf where
    toJSON (Printf printfPrintf) =
        object $ foldMap (maybe [] pure)
        [ Just $ "printf" .= printfPrintf
        ]

instance FromJSON Printf where
    parseJSON (Object v) = Printf
        <$> v .: "printf"

instance ToJSON Private where
    toJSON (Private privatePrivate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "private" .= privatePrivate
        ]

instance FromJSON Private where
    parseJSON (Object v) = Private
        <$> v .: "private"

instance ToJSON Protected where
    toJSON (Protected protectedProtected) =
        object $ foldMap (maybe [] pure)
        [ Just $ "protected" .= protectedProtected
        ]

instance FromJSON Protected where
    parseJSON (Object v) = Protected
        <$> v .: "protected"

instance ToJSON Protocol where
    toJSON (Protocol protocolProtocol) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Protocol" .= protocolProtocol
        ]

instance FromJSON Protocol where
    parseJSON (Object v) = Protocol
        <$> v .: "Protocol"

instance ToJSON Public where
    toJSON (Public publicPublic) =
        object $ foldMap (maybe [] pure)
        [ Just $ "public" .= publicPublic
        ]

instance FromJSON Public where
    parseJSON (Object v) = Public
        <$> v .: "public"

instance ToJSON Quicktype where
    toJSON (Quicktype quicktypeQuicktype) =
        object $ foldMap (maybe [] pure)
        [ Just $ "quicktype" .= quicktypeQuicktype
        ]

instance FromJSON Quicktype where
    parseJSON (Object v) = Quicktype
        <$> v .: "quicktype"

instance ToJSON Raise where
    toJSON (Raise raiseRaise) =
        object $ foldMap (maybe [] pure)
        [ Just $ "raise" .= raiseRaise
        ]

instance FromJSON Raise where
    parseJSON (Object v) = Raise
        <$> v .: "raise"

instance ToJSON Range where
    toJSON (Range rangeRange) =
        object $ foldMap (maybe [] pure)
        [ Just $ "range" .= rangeRange
        ]

instance FromJSON Range where
    parseJSON (Object v) = Range
        <$> v .: "range"

instance ToJSON Readonly where
    toJSON (Readonly readonlyReadonly) =
        object $ foldMap (maybe [] pure)
        [ Just $ "readonly" .= readonlyReadonly
        ]

instance FromJSON Readonly where
    parseJSON (Object v) = Readonly
        <$> v .: "readonly"

instance ToJSON Ref where
    toJSON (Ref refRef) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ref" .= refRef
        ]

instance FromJSON Ref where
    parseJSON (Object v) = Ref
        <$> v .: "ref"

instance ToJSON RegExp where
    toJSON (RegExp regExpRegExp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "RegExp" .= regExpRegExp
        ]

instance FromJSON RegExp where
    parseJSON (Object v) = RegExp
        <$> v .: "RegExp"

instance ToJSON Register where
    toJSON (Register registerRegister) =
        object $ foldMap (maybe [] pure)
        [ Just $ "register" .= registerRegister
        ]

instance FromJSON Register where
    parseJSON (Object v) = Register
        <$> v .: "register"

instance ToJSON ReinterpretCast where
    toJSON (ReinterpretCast reinterpretCastReinterpretCast) =
        object $ foldMap (maybe [] pure)
        [ Just $ "reinterpret_cast" .= reinterpretCastReinterpretCast
        ]

instance FromJSON ReinterpretCast where
    parseJSON (Object v) = ReinterpretCast
        <$> v .: "reinterpret_cast"

instance ToJSON Obj5 where
    toJSON (Obj5 dummyObj5 kSerializerObj5 obj5SelfObj5 obj5ThenObj5 obj5TrueObj5 primitiveKindObj5 repeatObj5 requireObj5 requiredObj5 requiresObj5 restrictObj5 retainObj5 rethrowsObj5 returnObj5 rightObj5 runtimeTypeObj5 sObj5 sbyteObj5 sealedObj5 selObj5 selectObj5 selfObj5 sendableObj5 serialDescriptorObj5 serialNameObj5 serializableObj5 serializationFeatureObj5 serializeObj5 serializerProviderObj5 setObj5 shortObj5 signedObj5 simpleModuleObj5 sizeofObj5 stackallocObj5 standardsObj5 staticObj5 staticAssertObj5 staticCastObj5 stdDeserializerObj5 stdSerializerObj5 strictfpObj5 stringObj5 structObj5 subscriptObj5 superObj5 switchObj5 symbolObj5 synchronizedObj5 systemObj5 templateObj5 textNodeObj5 thisObj5 threadLocalObj5 throwObj5 throwsObj5 timeOnlyObj5 timeOnlyConverterObj5 timeZoneObj5 toDictObj5 toJSONObj5 toStringObj5 topLevelObj5 transientObj5 trueObj5) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dummy" .= dummyObj5
        , Just $ "KSerializer" .= kSerializerObj5
        , Just $ "self" .= obj5SelfObj5
        , Just $ "then" .= obj5ThenObj5
        , Just $ "true" .= obj5TrueObj5
        , Just $ "PrimitiveKind" .= primitiveKindObj5
        , Just $ "repeat" .= repeatObj5
        , Just $ "require" .= requireObj5
        , Just $ "required" .= requiredObj5
        , Just $ "requires" .= requiresObj5
        , Just $ "restrict" .= restrictObj5
        , Just $ "retain" .= retainObj5
        , Just $ "rethrows" .= rethrowsObj5
        , Just $ "return" .= returnObj5
        , Just $ "right" .= rightObj5
        , Just $ "runtimeType" .= runtimeTypeObj5
        , Just $ "s" .= sObj5
        , Just $ "sbyte" .= sbyteObj5
        , Just $ "sealed" .= sealedObj5
        , Just $ "SEL" .= selObj5
        , Just $ "select" .= selectObj5
        , Just $ "Self" .= selfObj5
        , Just $ "Sendable" .= sendableObj5
        , Just $ "SerialDescriptor" .= serialDescriptorObj5
        , Just $ "SerialName" .= serialNameObj5
        , Just $ "Serializable" .= serializableObj5
        , Just $ "SerializationFeature" .= serializationFeatureObj5
        , Just $ "serialize" .= serializeObj5
        , Just $ "SerializerProvider" .= serializerProviderObj5
        , Just $ "set" .= setObj5
        , Just $ "short" .= shortObj5
        , Just $ "signed" .= signedObj5
        , Just $ "SimpleModule" .= simpleModuleObj5
        , Just $ "sizeof" .= sizeofObj5
        , Just $ "stackalloc" .= stackallocObj5
        , Just $ "Standards" .= standardsObj5
        , Just $ "static" .= staticObj5
        , Just $ "static_assert" .= staticAssertObj5
        , Just $ "static_cast" .= staticCastObj5
        , Just $ "StdDeserializer" .= stdDeserializerObj5
        , Just $ "StdSerializer" .= stdSerializerObj5
        , Just $ "strictfp" .= strictfpObj5
        , Just $ "string" .= stringObj5
        , Just $ "struct" .= structObj5
        , Just $ "subscript" .= subscriptObj5
        , Just $ "super" .= superObj5
        , Just $ "switch" .= switchObj5
        , Just $ "symbol" .= symbolObj5
        , Just $ "synchronized" .= synchronizedObj5
        , Just $ "system" .= systemObj5
        , Just $ "template" .= templateObj5
        , Just $ "TextNode" .= textNodeObj5
        , Just $ "this" .= thisObj5
        , Just $ "thread_local" .= threadLocalObj5
        , Just $ "throw" .= throwObj5
        , Just $ "throws" .= throwsObj5
        , Just $ "TimeOnly" .= timeOnlyObj5
        , Just $ "TimeOnlyConverter" .= timeOnlyConverterObj5
        , Just $ "TimeZone" .= timeZoneObj5
        , Just $ "to_dict" .= toDictObj5
        , Just $ "to_json" .= toJSONObj5
        , Just $ "toString" .= toStringObj5
        , Just $ "top_level" .= topLevelObj5
        , Just $ "transient" .= transientObj5
        , Just $ "True" .= trueObj5
        ]

instance FromJSON Obj5 where
    parseJSON (Object v) = Obj5
        <$> v .: "dummy"
        <*> v .: "KSerializer"
        <*> v .: "self"
        <*> v .: "then"
        <*> v .: "true"
        <*> v .: "PrimitiveKind"
        <*> v .: "repeat"
        <*> v .: "require"
        <*> v .: "required"
        <*> v .: "requires"
        <*> v .: "restrict"
        <*> v .: "retain"
        <*> v .: "rethrows"
        <*> v .: "return"
        <*> v .: "right"
        <*> v .: "runtimeType"
        <*> v .: "s"
        <*> v .: "sbyte"
        <*> v .: "sealed"
        <*> v .: "SEL"
        <*> v .: "select"
        <*> v .: "Self"
        <*> v .: "Sendable"
        <*> v .: "SerialDescriptor"
        <*> v .: "SerialName"
        <*> v .: "Serializable"
        <*> v .: "SerializationFeature"
        <*> v .: "serialize"
        <*> v .: "SerializerProvider"
        <*> v .: "set"
        <*> v .: "short"
        <*> v .: "signed"
        <*> v .: "SimpleModule"
        <*> v .: "sizeof"
        <*> v .: "stackalloc"
        <*> v .: "Standards"
        <*> v .: "static"
        <*> v .: "static_assert"
        <*> v .: "static_cast"
        <*> v .: "StdDeserializer"
        <*> v .: "StdSerializer"
        <*> v .: "strictfp"
        <*> v .: "string"
        <*> v .: "struct"
        <*> v .: "subscript"
        <*> v .: "super"
        <*> v .: "switch"
        <*> v .: "symbol"
        <*> v .: "synchronized"
        <*> v .: "system"
        <*> v .: "template"
        <*> v .: "TextNode"
        <*> v .: "this"
        <*> v .: "thread_local"
        <*> v .: "throw"
        <*> v .: "throws"
        <*> v .: "TimeOnly"
        <*> v .: "TimeOnlyConverter"
        <*> v .: "TimeZone"
        <*> v .: "to_dict"
        <*> v .: "to_json"
        <*> v .: "toString"
        <*> v .: "top_level"
        <*> v .: "transient"
        <*> v .: "True"

instance ToJSON KSerializer where
    toJSON (KSerializer kSerializerKSerializer) =
        object $ foldMap (maybe [] pure)
        [ Just $ "KSerializer" .= kSerializerKSerializer
        ]

instance FromJSON KSerializer where
    parseJSON (Object v) = KSerializer
        <$> v .: "KSerializer"

instance ToJSON SelfClass where
    toJSON (SelfClass selfSelfClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "self" .= selfSelfClass
        ]

instance FromJSON SelfClass where
    parseJSON (Object v) = SelfClass
        <$> v .: "self"

instance ToJSON Then where
    toJSON (Then thenThenThen) =
        object $ foldMap (maybe [] pure)
        [ Just $ "then" .= thenThenThen
        ]

instance FromJSON Then where
    parseJSON (Object v) = Then
        <$> v .: "then"

instance ToJSON Obj5True where
    toJSON (Obj5True trueObj5True) =
        object $ foldMap (maybe [] pure)
        [ Just $ "true" .= trueObj5True
        ]

instance FromJSON Obj5True where
    parseJSON (Object v) = Obj5True
        <$> v .: "true"

instance ToJSON PrimitiveKind where
    toJSON (PrimitiveKind primitiveKindPrimitiveKind) =
        object $ foldMap (maybe [] pure)
        [ Just $ "PrimitiveKind" .= primitiveKindPrimitiveKind
        ]

instance FromJSON PrimitiveKind where
    parseJSON (Object v) = PrimitiveKind
        <$> v .: "PrimitiveKind"

instance ToJSON Repeat where
    toJSON (Repeat repeatRepeat) =
        object $ foldMap (maybe [] pure)
        [ Just $ "repeat" .= repeatRepeat
        ]

instance FromJSON Repeat where
    parseJSON (Object v) = Repeat
        <$> v .: "repeat"

instance ToJSON Require where
    toJSON (Require requireRequire) =
        object $ foldMap (maybe [] pure)
        [ Just $ "require" .= requireRequire
        ]

instance FromJSON Require where
    parseJSON (Object v) = Require
        <$> v .: "require"

instance ToJSON Required where
    toJSON (Required requiredRequired) =
        object $ foldMap (maybe [] pure)
        [ Just $ "required" .= requiredRequired
        ]

instance FromJSON Required where
    parseJSON (Object v) = Required
        <$> v .: "required"

instance ToJSON Requires where
    toJSON (Requires requiresRequires) =
        object $ foldMap (maybe [] pure)
        [ Just $ "requires" .= requiresRequires
        ]

instance FromJSON Requires where
    parseJSON (Object v) = Requires
        <$> v .: "requires"

instance ToJSON Restrict where
    toJSON (Restrict restrictRestrict) =
        object $ foldMap (maybe [] pure)
        [ Just $ "restrict" .= restrictRestrict
        ]

instance FromJSON Restrict where
    parseJSON (Object v) = Restrict
        <$> v .: "restrict"

instance ToJSON Retain where
    toJSON (Retain retainRetain) =
        object $ foldMap (maybe [] pure)
        [ Just $ "retain" .= retainRetain
        ]

instance FromJSON Retain where
    parseJSON (Object v) = Retain
        <$> v .: "retain"

instance ToJSON Rethrows where
    toJSON (Rethrows rethrowsRethrows) =
        object $ foldMap (maybe [] pure)
        [ Just $ "rethrows" .= rethrowsRethrows
        ]

instance FromJSON Rethrows where
    parseJSON (Object v) = Rethrows
        <$> v .: "rethrows"

instance ToJSON Return where
    toJSON (Return returnReturn) =
        object $ foldMap (maybe [] pure)
        [ Just $ "return" .= returnReturn
        ]

instance FromJSON Return where
    parseJSON (Object v) = Return
        <$> v .: "return"

instance ToJSON RightClass where
    toJSON (RightClass rightRightClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "right" .= rightRightClass
        ]

instance FromJSON RightClass where
    parseJSON (Object v) = RightClass
        <$> v .: "right"

instance ToJSON RuntimeType where
    toJSON (RuntimeType runtimeTypeRuntimeType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "runtimeType" .= runtimeTypeRuntimeType
        ]

instance FromJSON RuntimeType where
    parseJSON (Object v) = RuntimeType
        <$> v .: "runtimeType"

instance ToJSON S where
    toJSON (S sS) =
        object $ foldMap (maybe [] pure)
        [ Just $ "s" .= sS
        ]

instance FromJSON S where
    parseJSON (Object v) = S
        <$> v .: "s"

instance ToJSON Sbyte where
    toJSON (Sbyte sbyteSbyte) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sbyte" .= sbyteSbyte
        ]

instance FromJSON Sbyte where
    parseJSON (Object v) = Sbyte
        <$> v .: "sbyte"

instance ToJSON Sealed where
    toJSON (Sealed sealedSealed) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sealed" .= sealedSealed
        ]

instance FromJSON Sealed where
    parseJSON (Object v) = Sealed
        <$> v .: "sealed"

instance ToJSON Sel where
    toJSON (Sel selSel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SEL" .= selSel
        ]

instance FromJSON Sel where
    parseJSON (Object v) = Sel
        <$> v .: "SEL"

instance ToJSON Select where
    toJSON (Select selectSelect) =
        object $ foldMap (maybe [] pure)
        [ Just $ "select" .= selectSelect
        ]

instance FromJSON Select where
    parseJSON (Object v) = Select
        <$> v .: "select"

instance ToJSON Self where
    toJSON (Self selfSelf) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Self" .= selfSelf
        ]

instance FromJSON Self where
    parseJSON (Object v) = Self
        <$> v .: "Self"

instance ToJSON Sendable where
    toJSON (Sendable sendableSendable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Sendable" .= sendableSendable
        ]

instance FromJSON Sendable where
    parseJSON (Object v) = Sendable
        <$> v .: "Sendable"

instance ToJSON SerialDescriptor where
    toJSON (SerialDescriptor serialDescriptorSerialDescriptor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SerialDescriptor" .= serialDescriptorSerialDescriptor
        ]

instance FromJSON SerialDescriptor where
    parseJSON (Object v) = SerialDescriptor
        <$> v .: "SerialDescriptor"

instance ToJSON SerialName where
    toJSON (SerialName serialNameSerialName) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SerialName" .= serialNameSerialName
        ]

instance FromJSON SerialName where
    parseJSON (Object v) = SerialName
        <$> v .: "SerialName"

instance ToJSON Serializable where
    toJSON (Serializable serializableSerializable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Serializable" .= serializableSerializable
        ]

instance FromJSON Serializable where
    parseJSON (Object v) = Serializable
        <$> v .: "Serializable"

instance ToJSON SerializationFeature where
    toJSON (SerializationFeature serializationFeatureSerializationFeature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SerializationFeature" .= serializationFeatureSerializationFeature
        ]

instance FromJSON SerializationFeature where
    parseJSON (Object v) = SerializationFeature
        <$> v .: "SerializationFeature"

instance ToJSON Serialize where
    toJSON (Serialize serializeSerialize) =
        object $ foldMap (maybe [] pure)
        [ Just $ "serialize" .= serializeSerialize
        ]

instance FromJSON Serialize where
    parseJSON (Object v) = Serialize
        <$> v .: "serialize"

instance ToJSON SerializerProvider where
    toJSON (SerializerProvider serializerProviderSerializerProvider) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SerializerProvider" .= serializerProviderSerializerProvider
        ]

instance FromJSON SerializerProvider where
    parseJSON (Object v) = SerializerProvider
        <$> v .: "SerializerProvider"

instance ToJSON Set where
    toJSON (Set setSet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "set" .= setSet
        ]

instance FromJSON Set where
    parseJSON (Object v) = Set
        <$> v .: "set"

instance ToJSON Short where
    toJSON (Short shortShort) =
        object $ foldMap (maybe [] pure)
        [ Just $ "short" .= shortShort
        ]

instance FromJSON Short where
    parseJSON (Object v) = Short
        <$> v .: "short"

instance ToJSON Signed where
    toJSON (Signed signedSigned) =
        object $ foldMap (maybe [] pure)
        [ Just $ "signed" .= signedSigned
        ]

instance FromJSON Signed where
    parseJSON (Object v) = Signed
        <$> v .: "signed"

instance ToJSON SimpleModule where
    toJSON (SimpleModule simpleModuleSimpleModule) =
        object $ foldMap (maybe [] pure)
        [ Just $ "SimpleModule" .= simpleModuleSimpleModule
        ]

instance FromJSON SimpleModule where
    parseJSON (Object v) = SimpleModule
        <$> v .: "SimpleModule"

instance ToJSON Sizeof where
    toJSON (Sizeof sizeofSizeof) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sizeof" .= sizeofSizeof
        ]

instance FromJSON Sizeof where
    parseJSON (Object v) = Sizeof
        <$> v .: "sizeof"

instance ToJSON Stackalloc where
    toJSON (Stackalloc stackallocStackalloc) =
        object $ foldMap (maybe [] pure)
        [ Just $ "stackalloc" .= stackallocStackalloc
        ]

instance FromJSON Stackalloc where
    parseJSON (Object v) = Stackalloc
        <$> v .: "stackalloc"

instance ToJSON Standards where
    toJSON (Standards standardsStandards) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Standards" .= standardsStandards
        ]

instance FromJSON Standards where
    parseJSON (Object v) = Standards
        <$> v .: "Standards"

instance ToJSON Static where
    toJSON (Static staticStatic) =
        object $ foldMap (maybe [] pure)
        [ Just $ "static" .= staticStatic
        ]

instance FromJSON Static where
    parseJSON (Object v) = Static
        <$> v .: "static"

instance ToJSON StaticAssert where
    toJSON (StaticAssert staticAssertStaticAssert) =
        object $ foldMap (maybe [] pure)
        [ Just $ "static_assert" .= staticAssertStaticAssert
        ]

instance FromJSON StaticAssert where
    parseJSON (Object v) = StaticAssert
        <$> v .: "static_assert"

instance ToJSON StaticCast where
    toJSON (StaticCast staticCastStaticCast) =
        object $ foldMap (maybe [] pure)
        [ Just $ "static_cast" .= staticCastStaticCast
        ]

instance FromJSON StaticCast where
    parseJSON (Object v) = StaticCast
        <$> v .: "static_cast"

instance ToJSON StdDeserializer where
    toJSON (StdDeserializer stdDeserializerStdDeserializer) =
        object $ foldMap (maybe [] pure)
        [ Just $ "StdDeserializer" .= stdDeserializerStdDeserializer
        ]

instance FromJSON StdDeserializer where
    parseJSON (Object v) = StdDeserializer
        <$> v .: "StdDeserializer"

instance ToJSON StdSerializer where
    toJSON (StdSerializer stdSerializerStdSerializer) =
        object $ foldMap (maybe [] pure)
        [ Just $ "StdSerializer" .= stdSerializerStdSerializer
        ]

instance FromJSON StdSerializer where
    parseJSON (Object v) = StdSerializer
        <$> v .: "StdSerializer"

instance ToJSON Strictfp where
    toJSON (Strictfp strictfpStrictfp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "strictfp" .= strictfpStrictfp
        ]

instance FromJSON Strictfp where
    parseJSON (Object v) = Strictfp
        <$> v .: "strictfp"

instance ToJSON StringClass where
    toJSON (StringClass stringStringClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "string" .= stringStringClass
        ]

instance FromJSON StringClass where
    parseJSON (Object v) = StringClass
        <$> v .: "string"

instance ToJSON Struct where
    toJSON (Struct structStruct) =
        object $ foldMap (maybe [] pure)
        [ Just $ "struct" .= structStruct
        ]

instance FromJSON Struct where
    parseJSON (Object v) = Struct
        <$> v .: "struct"

instance ToJSON Subscript where
    toJSON (Subscript subscriptSubscript) =
        object $ foldMap (maybe [] pure)
        [ Just $ "subscript" .= subscriptSubscript
        ]

instance FromJSON Subscript where
    parseJSON (Object v) = Subscript
        <$> v .: "subscript"

instance ToJSON Super where
    toJSON (Super superSuper) =
        object $ foldMap (maybe [] pure)
        [ Just $ "super" .= superSuper
        ]

instance FromJSON Super where
    parseJSON (Object v) = Super
        <$> v .: "super"

instance ToJSON Switch where
    toJSON (Switch switchSwitch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "switch" .= switchSwitch
        ]

instance FromJSON Switch where
    parseJSON (Object v) = Switch
        <$> v .: "switch"

instance ToJSON Symbol where
    toJSON (Symbol symbolSymbol) =
        object $ foldMap (maybe [] pure)
        [ Just $ "symbol" .= symbolSymbol
        ]

instance FromJSON Symbol where
    parseJSON (Object v) = Symbol
        <$> v .: "symbol"

instance ToJSON Synchronized where
    toJSON (Synchronized synchronizedSynchronized) =
        object $ foldMap (maybe [] pure)
        [ Just $ "synchronized" .= synchronizedSynchronized
        ]

instance FromJSON Synchronized where
    parseJSON (Object v) = Synchronized
        <$> v .: "synchronized"

instance ToJSON System where
    toJSON (System systemSystem) =
        object $ foldMap (maybe [] pure)
        [ Just $ "system" .= systemSystem
        ]

instance FromJSON System where
    parseJSON (Object v) = System
        <$> v .: "system"

instance ToJSON Template where
    toJSON (Template templateTemplate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "template" .= templateTemplate
        ]

instance FromJSON Template where
    parseJSON (Object v) = Template
        <$> v .: "template"

instance ToJSON TextNode where
    toJSON (TextNode textNodeTextNode) =
        object $ foldMap (maybe [] pure)
        [ Just $ "TextNode" .= textNodeTextNode
        ]

instance FromJSON TextNode where
    parseJSON (Object v) = TextNode
        <$> v .: "TextNode"

instance ToJSON This where
    toJSON (This thisThis) =
        object $ foldMap (maybe [] pure)
        [ Just $ "this" .= thisThis
        ]

instance FromJSON This where
    parseJSON (Object v) = This
        <$> v .: "this"

instance ToJSON ThreadLocal where
    toJSON (ThreadLocal threadLocalThreadLocal) =
        object $ foldMap (maybe [] pure)
        [ Just $ "thread_local" .= threadLocalThreadLocal
        ]

instance FromJSON ThreadLocal where
    parseJSON (Object v) = ThreadLocal
        <$> v .: "thread_local"

instance ToJSON Throw where
    toJSON (Throw throwThrow) =
        object $ foldMap (maybe [] pure)
        [ Just $ "throw" .= throwThrow
        ]

instance FromJSON Throw where
    parseJSON (Object v) = Throw
        <$> v .: "throw"

instance ToJSON Throws where
    toJSON (Throws throwsThrows) =
        object $ foldMap (maybe [] pure)
        [ Just $ "throws" .= throwsThrows
        ]

instance FromJSON Throws where
    parseJSON (Object v) = Throws
        <$> v .: "throws"

instance ToJSON TimeOnly where
    toJSON (TimeOnly timeOnlyTimeOnly) =
        object $ foldMap (maybe [] pure)
        [ Just $ "TimeOnly" .= timeOnlyTimeOnly
        ]

instance FromJSON TimeOnly where
    parseJSON (Object v) = TimeOnly
        <$> v .: "TimeOnly"

instance ToJSON TimeOnlyConverter where
    toJSON (TimeOnlyConverter timeOnlyConverterTimeOnlyConverter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "TimeOnlyConverter" .= timeOnlyConverterTimeOnlyConverter
        ]

instance FromJSON TimeOnlyConverter where
    parseJSON (Object v) = TimeOnlyConverter
        <$> v .: "TimeOnlyConverter"

instance ToJSON TimeZone where
    toJSON (TimeZone timeZoneTimeZone) =
        object $ foldMap (maybe [] pure)
        [ Just $ "TimeZone" .= timeZoneTimeZone
        ]

instance FromJSON TimeZone where
    parseJSON (Object v) = TimeZone
        <$> v .: "TimeZone"

instance ToJSON ToDict where
    toJSON (ToDict toDictToDict) =
        object $ foldMap (maybe [] pure)
        [ Just $ "to_dict" .= toDictToDict
        ]

instance FromJSON ToDict where
    parseJSON (Object v) = ToDict
        <$> v .: "to_dict"

instance ToJSON ToJSONClass where
    toJSON (ToJSONClass toJSONToJSONClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "to_json" .= toJSONToJSONClass
        ]

instance FromJSON ToJSONClass where
    parseJSON (Object v) = ToJSONClass
        <$> v .: "to_json"

instance ToJSON ToString where
    toJSON (ToString toStringToString) =
        object $ foldMap (maybe [] pure)
        [ Just $ "toString" .= toStringToString
        ]

instance FromJSON ToString where
    parseJSON (Object v) = ToString
        <$> v .: "toString"

instance ToJSON TopLevel where
    toJSON (TopLevel topLevelTopLevel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "top_level" .= topLevelTopLevel
        ]

instance FromJSON TopLevel where
    parseJSON (Object v) = TopLevel
        <$> v .: "top_level"

instance ToJSON Transient where
    toJSON (Transient transientTransient) =
        object $ foldMap (maybe [] pure)
        [ Just $ "transient" .= transientTransient
        ]

instance FromJSON Transient where
    parseJSON (Object v) = Transient
        <$> v .: "transient"

instance ToJSON TrueClass where
    toJSON (TrueClass trueTrueClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "True" .= trueTrueClass
        ]

instance FromJSON TrueClass where
    parseJSON (Object v) = TrueClass
        <$> v .: "True"

instance ToJSON Obj6 where
    toJSON (Obj6 dummyObj6 obj6TypeObj6 obj6WhereObj6 purpleTypeObj6 tryObj6 typealiasObj6 typedefObj6 typeidObj6 typenameObj6 typeofObj6 uintObj6 ulongObj6 uncheckedObj6 undefinedObj6 unionObj6 unmarshalJSONObj6 unownedObj6 unsafeObj6 unsignedObj6 useSerializersObj6 ushortObj6 usingObj6 utf8JSONReaderObj6 utf8JSONWriterObj6 uuidObj6 varObj6 virtualObj6 voidObj6 volatileObj6 wcharTObj6 weakObj6 whileObj6 willSetObj6 withObj6 xorObj6 xorEqObj6 yesObj6 yieldObj6) =
        object $ foldMap (maybe [] pure)
        [ Just $ "dummy" .= dummyObj6
        , Just $ "Type" .= obj6TypeObj6
        , Just $ "where" .= obj6WhereObj6
        , Just $ "type" .= purpleTypeObj6
        , Just $ "try" .= tryObj6
        , Just $ "typealias" .= typealiasObj6
        , Just $ "typedef" .= typedefObj6
        , Just $ "typeid" .= typeidObj6
        , Just $ "typename" .= typenameObj6
        , Just $ "typeof" .= typeofObj6
        , Just $ "uint" .= uintObj6
        , Just $ "ulong" .= ulongObj6
        , Just $ "unchecked" .= uncheckedObj6
        , Just $ "undefined" .= undefinedObj6
        , Just $ "union" .= unionObj6
        , Just $ "UnmarshalJSON" .= unmarshalJSONObj6
        , Just $ "unowned" .= unownedObj6
        , Just $ "unsafe" .= unsafeObj6
        , Just $ "unsigned" .= unsignedObj6
        , Just $ "UseSerializers" .= useSerializersObj6
        , Just $ "ushort" .= ushortObj6
        , Just $ "using" .= usingObj6
        , Just $ "Utf8JsonReader" .= utf8JSONReaderObj6
        , Just $ "Utf8JsonWriter" .= utf8JSONWriterObj6
        , Just $ "UUID" .= uuidObj6
        , Just $ "var" .= varObj6
        , Just $ "virtual" .= virtualObj6
        , Just $ "void" .= voidObj6
        , Just $ "volatile" .= volatileObj6
        , Just $ "wchar_t" .= wcharTObj6
        , Just $ "weak" .= weakObj6
        , Just $ "while" .= whileObj6
        , Just $ "willSet" .= willSetObj6
        , Just $ "with" .= withObj6
        , Just $ "xor" .= xorObj6
        , Just $ "xor_eq" .= xorEqObj6
        , Just $ "YES" .= yesObj6
        , Just $ "yield" .= yieldObj6
        ]

instance FromJSON Obj6 where
    parseJSON (Object v) = Obj6
        <$> v .: "dummy"
        <*> v .: "Type"
        <*> v .: "where"
        <*> v .: "type"
        <*> v .: "try"
        <*> v .: "typealias"
        <*> v .: "typedef"
        <*> v .: "typeid"
        <*> v .: "typename"
        <*> v .: "typeof"
        <*> v .: "uint"
        <*> v .: "ulong"
        <*> v .: "unchecked"
        <*> v .: "undefined"
        <*> v .: "union"
        <*> v .: "UnmarshalJSON"
        <*> v .: "unowned"
        <*> v .: "unsafe"
        <*> v .: "unsigned"
        <*> v .: "UseSerializers"
        <*> v .: "ushort"
        <*> v .: "using"
        <*> v .: "Utf8JsonReader"
        <*> v .: "Utf8JsonWriter"
        <*> v .: "UUID"
        <*> v .: "var"
        <*> v .: "virtual"
        <*> v .: "void"
        <*> v .: "volatile"
        <*> v .: "wchar_t"
        <*> v .: "weak"
        <*> v .: "while"
        <*> v .: "willSet"
        <*> v .: "with"
        <*> v .: "xor"
        <*> v .: "xor_eq"
        <*> v .: "YES"
        <*> v .: "yield"

instance ToJSON Type where
    toJSON (Type typeTypeType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Type" .= typeTypeType
        ]

instance FromJSON Type where
    parseJSON (Object v) = Type
        <$> v .: "Type"

instance ToJSON Where where
    toJSON (Where whereWhereWhere) =
        object $ foldMap (maybe [] pure)
        [ Just $ "where" .= whereWhereWhere
        ]

instance FromJSON Where where
    parseJSON (Object v) = Where
        <$> v .: "where"

instance ToJSON TypeClass where
    toJSON (TypeClass typeTypeTypeClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= typeTypeTypeClass
        ]

instance FromJSON TypeClass where
    parseJSON (Object v) = TypeClass
        <$> v .: "type"

instance ToJSON Try where
    toJSON (Try tryTry) =
        object $ foldMap (maybe [] pure)
        [ Just $ "try" .= tryTry
        ]

instance FromJSON Try where
    parseJSON (Object v) = Try
        <$> v .: "try"

instance ToJSON Typealias where
    toJSON (Typealias typealiasTypealias) =
        object $ foldMap (maybe [] pure)
        [ Just $ "typealias" .= typealiasTypealias
        ]

instance FromJSON Typealias where
    parseJSON (Object v) = Typealias
        <$> v .: "typealias"

instance ToJSON Typedef where
    toJSON (Typedef typedefTypedef) =
        object $ foldMap (maybe [] pure)
        [ Just $ "typedef" .= typedefTypedef
        ]

instance FromJSON Typedef where
    parseJSON (Object v) = Typedef
        <$> v .: "typedef"

instance ToJSON Typeid where
    toJSON (Typeid typeidTypeid) =
        object $ foldMap (maybe [] pure)
        [ Just $ "typeid" .= typeidTypeid
        ]

instance FromJSON Typeid where
    parseJSON (Object v) = Typeid
        <$> v .: "typeid"

instance ToJSON Typename where
    toJSON (Typename typenameTypename) =
        object $ foldMap (maybe [] pure)
        [ Just $ "typename" .= typenameTypename
        ]

instance FromJSON Typename where
    parseJSON (Object v) = Typename
        <$> v .: "typename"

instance ToJSON Typeof where
    toJSON (Typeof typeofTypeof) =
        object $ foldMap (maybe [] pure)
        [ Just $ "typeof" .= typeofTypeof
        ]

instance FromJSON Typeof where
    parseJSON (Object v) = Typeof
        <$> v .: "typeof"

instance ToJSON Uint where
    toJSON (Uint uintUint) =
        object $ foldMap (maybe [] pure)
        [ Just $ "uint" .= uintUint
        ]

instance FromJSON Uint where
    parseJSON (Object v) = Uint
        <$> v .: "uint"

instance ToJSON Ulong where
    toJSON (Ulong ulongUlong) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ulong" .= ulongUlong
        ]

instance FromJSON Ulong where
    parseJSON (Object v) = Ulong
        <$> v .: "ulong"

instance ToJSON Unchecked where
    toJSON (Unchecked uncheckedUnchecked) =
        object $ foldMap (maybe [] pure)
        [ Just $ "unchecked" .= uncheckedUnchecked
        ]

instance FromJSON Unchecked where
    parseJSON (Object v) = Unchecked
        <$> v .: "unchecked"

instance ToJSON Undefined where
    toJSON (Undefined undefinedUndefined) =
        object $ foldMap (maybe [] pure)
        [ Just $ "undefined" .= undefinedUndefined
        ]

instance FromJSON Undefined where
    parseJSON (Object v) = Undefined
        <$> v .: "undefined"

instance ToJSON Union where
    toJSON (Union unionUnion) =
        object $ foldMap (maybe [] pure)
        [ Just $ "union" .= unionUnion
        ]

instance FromJSON Union where
    parseJSON (Object v) = Union
        <$> v .: "union"

instance ToJSON UnmarshalJSON where
    toJSON (UnmarshalJSON unmarshalJSONUnmarshalJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "UnmarshalJSON" .= unmarshalJSONUnmarshalJSON
        ]

instance FromJSON UnmarshalJSON where
    parseJSON (Object v) = UnmarshalJSON
        <$> v .: "UnmarshalJSON"

instance ToJSON Unowned where
    toJSON (Unowned unownedUnowned) =
        object $ foldMap (maybe [] pure)
        [ Just $ "unowned" .= unownedUnowned
        ]

instance FromJSON Unowned where
    parseJSON (Object v) = Unowned
        <$> v .: "unowned"

instance ToJSON Unsafe where
    toJSON (Unsafe unsafeUnsafe) =
        object $ foldMap (maybe [] pure)
        [ Just $ "unsafe" .= unsafeUnsafe
        ]

instance FromJSON Unsafe where
    parseJSON (Object v) = Unsafe
        <$> v .: "unsafe"

instance ToJSON Unsigned where
    toJSON (Unsigned unsignedUnsigned) =
        object $ foldMap (maybe [] pure)
        [ Just $ "unsigned" .= unsignedUnsigned
        ]

instance FromJSON Unsigned where
    parseJSON (Object v) = Unsigned
        <$> v .: "unsigned"

instance ToJSON UseSerializers where
    toJSON (UseSerializers useSerializersUseSerializers) =
        object $ foldMap (maybe [] pure)
        [ Just $ "UseSerializers" .= useSerializersUseSerializers
        ]

instance FromJSON UseSerializers where
    parseJSON (Object v) = UseSerializers
        <$> v .: "UseSerializers"

instance ToJSON Ushort where
    toJSON (Ushort ushortUshort) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ushort" .= ushortUshort
        ]

instance FromJSON Ushort where
    parseJSON (Object v) = Ushort
        <$> v .: "ushort"

instance ToJSON Using where
    toJSON (Using usingUsing) =
        object $ foldMap (maybe [] pure)
        [ Just $ "using" .= usingUsing
        ]

instance FromJSON Using where
    parseJSON (Object v) = Using
        <$> v .: "using"

instance ToJSON Utf8JSONReader where
    toJSON (Utf8JSONReader utf8JSONReaderUtf8JSONReader) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Utf8JsonReader" .= utf8JSONReaderUtf8JSONReader
        ]

instance FromJSON Utf8JSONReader where
    parseJSON (Object v) = Utf8JSONReader
        <$> v .: "Utf8JsonReader"

instance ToJSON Utf8JSONWriter where
    toJSON (Utf8JSONWriter utf8JSONWriterUtf8JSONWriter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Utf8JsonWriter" .= utf8JSONWriterUtf8JSONWriter
        ]

instance FromJSON Utf8JSONWriter where
    parseJSON (Object v) = Utf8JSONWriter
        <$> v .: "Utf8JsonWriter"

instance ToJSON UUID where
    toJSON (UUID uuidUUID) =
        object $ foldMap (maybe [] pure)
        [ Just $ "UUID" .= uuidUUID
        ]

instance FromJSON UUID where
    parseJSON (Object v) = UUID
        <$> v .: "UUID"

instance ToJSON Var where
    toJSON (Var varVar) =
        object $ foldMap (maybe [] pure)
        [ Just $ "var" .= varVar
        ]

instance FromJSON Var where
    parseJSON (Object v) = Var
        <$> v .: "var"

instance ToJSON Virtual where
    toJSON (Virtual virtualVirtual) =
        object $ foldMap (maybe [] pure)
        [ Just $ "virtual" .= virtualVirtual
        ]

instance FromJSON Virtual where
    parseJSON (Object v) = Virtual
        <$> v .: "virtual"

instance ToJSON Void where
    toJSON (Void voidVoid) =
        object $ foldMap (maybe [] pure)
        [ Just $ "void" .= voidVoid
        ]

instance FromJSON Void where
    parseJSON (Object v) = Void
        <$> v .: "void"

instance ToJSON Volatile where
    toJSON (Volatile volatileVolatile) =
        object $ foldMap (maybe [] pure)
        [ Just $ "volatile" .= volatileVolatile
        ]

instance FromJSON Volatile where
    parseJSON (Object v) = Volatile
        <$> v .: "volatile"

instance ToJSON WcharT where
    toJSON (WcharT wcharTWcharT) =
        object $ foldMap (maybe [] pure)
        [ Just $ "wchar_t" .= wcharTWcharT
        ]

instance FromJSON WcharT where
    parseJSON (Object v) = WcharT
        <$> v .: "wchar_t"

instance ToJSON Weak where
    toJSON (Weak weakWeak) =
        object $ foldMap (maybe [] pure)
        [ Just $ "weak" .= weakWeak
        ]

instance FromJSON Weak where
    parseJSON (Object v) = Weak
        <$> v .: "weak"

instance ToJSON While where
    toJSON (While whileWhile) =
        object $ foldMap (maybe [] pure)
        [ Just $ "while" .= whileWhile
        ]

instance FromJSON While where
    parseJSON (Object v) = While
        <$> v .: "while"

instance ToJSON WillSet where
    toJSON (WillSet willSetWillSet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "willSet" .= willSetWillSet
        ]

instance FromJSON WillSet where
    parseJSON (Object v) = WillSet
        <$> v .: "willSet"

instance ToJSON With where
    toJSON (With withWith) =
        object $ foldMap (maybe [] pure)
        [ Just $ "with" .= withWith
        ]

instance FromJSON With where
    parseJSON (Object v) = With
        <$> v .: "with"

instance ToJSON Xor where
    toJSON (Xor xorXor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "xor" .= xorXor
        ]

instance FromJSON Xor where
    parseJSON (Object v) = Xor
        <$> v .: "xor"

instance ToJSON XorEq where
    toJSON (XorEq xorEqXorEq) =
        object $ foldMap (maybe [] pure)
        [ Just $ "xor_eq" .= xorEqXorEq
        ]

instance FromJSON XorEq where
    parseJSON (Object v) = XorEq
        <$> v .: "xor_eq"

instance ToJSON Yes where
    toJSON (Yes yesYes) =
        object $ foldMap (maybe [] pure)
        [ Just $ "YES" .= yesYes
        ]

instance FromJSON Yes where
    parseJSON (Object v) = Yes
        <$> v .: "YES"

instance ToJSON Yield where
    toJSON (Yield yieldYield) =
        object $ foldMap (maybe [] pure)
        [ Just $ "yield" .= yieldYield
        ]

instance FromJSON Yield where
    parseJSON (Object v) = Yield
        <$> v .: "yield"
