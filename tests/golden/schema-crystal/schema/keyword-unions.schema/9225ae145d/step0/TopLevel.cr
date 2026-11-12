require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "_")]
  property empty : UnionUnion?

  @[JSON::Field(key: "_Bool")]
  property top_level_bool : UnionBoolUnion?

  @[JSON::Field(key: "_Complex")]
  property complex : UnionComplex?

  @[JSON::Field(key: "_Imaginery")]
  property imaginery : UnionImaginery?

  @[JSON::Field(key: "abstract")]
  property top_level_abstract : UnionAbstract?

  property alignas : UnionAlignas?

  property alignof : UnionAlignof?

  property and : UnionAnd?

  property and_eq : UnionAndEq?

  @[JSON::Field(key: "any")]
  property top_level_any : UnionAnyUnion?

  @[JSON::Field(key: "Any")]
  property any : UnionAny?

  property array : UnionArray?

  @[JSON::Field(key: "ArrayNode")]
  property array_node : UnionArrayNode?

  @[JSON::Field(key: "as")]
  property top_level_as : UnionAs?

  @[JSON::Field(key: "asm")]
  property top_level_asm : UnionAsm?

  property assert : UnionAssert?

  property associatedtype : UnionAssociatedtype?

  property associativity : UnionAssociativity?

  property async : UnionAsync?

  property atomic : UnionAtomic?

  property atomic_cancel : UnionAtomicCancel?

  property atomic_commit : UnionAtomicCommit?

  property atomic_noexcept : UnionAtomicNoexcept?

  property auto : UnionAuto?

  property await : UnionAwait?

  property base : UnionBase?

  property bitand : UnionBitand?

  property bitor : UnionBitor?

  @[JSON::Field(key: "BOOL")]
  property bool : UnionBool?

  @[JSON::Field(key: "bool")]
  property purple_bool : TopLevelUnionBool?

  property boolean : UnionBoolean?

  @[JSON::Field(key: "BooleanNode")]
  property boolean_node : UnionBooleanNode?

  @[JSON::Field(key: "break")]
  property top_level_break : UnionBreak?

  property bycopy : UnionBycopy?

  property byref : UnionByref?

  property byte : UnionByte?

  @[JSON::Field(key: "Calendar")]
  property calendar : UnionCalendar?

  @[JSON::Field(key: "case")]
  property top_level_case : UnionCase?

  property catch : UnionCatch?

  property chan : UnionChan?

  property char : UnionChar?

  property char16_t : UnionChar16T?

  property char32_t : UnionChar32T?

  property checked : UnionChecked?

  @[JSON::Field(key: "class")]
  property purple_class : TopLevelUnionClass?

  @[JSON::Field(key: "Class")]
  property top_level_class : UnionClassUnion?

  property clone : UnionClone?

  property co_await : UnionCoAwait?

  property co_return : UnionCoReturn?

  property co_yield : UnionCoYield?

  @[JSON::Field(key: "Codable")]
  property codable : UnionCodable?

  @[JSON::Field(key: "CodingKey")]
  property coding_key : UnionCodingKey?

  @[JSON::Field(key: "CodingKeys")]
  property coding_keys : UnionCodingKeys?

  property compl : UnionCompl?

  property concept : UnionConcept?

  property console : UnionConsole?

  property const : UnionConst?

  property const_cast : UnionConstCast?

  property constexpr : UnionConstexpr?

  property constructor : UnionConstructor?

  property continue : UnionContinue?

  property convenience : UnionConvenience?

  property convert : UnionConvert?

  property converter : UnionConverter?

  @[JSON::Field(key: "CultureInfo")]
  property culture_info : UnionCultureInfo?

  property date : UnionDate?

  property date_parse_handling : UnionDateParseHandling?

  @[JSON::Field(key: "DateFormatter")]
  property date_formatter : UnionDateFormatter?

  @[JSON::Field(key: "DateOnly")]
  property date_only : UnionDateOnly?

  @[JSON::Field(key: "DateOnlyConverter")]
  property date_only_converter : UnionDateOnlyConverter?

  @[JSON::Field(key: "DateTime")]
  property date_time : UnionDateTime?

  @[JSON::Field(key: "DateTimeStyles")]
  property date_time_styles : UnionDateTimeStyles?

  property debugger : UnionDebugger?

  property decimal : UnionDecimal?

  property declare : UnionDeclare?

  property decltype : UnionDecltype?

  property decode_string : UnionDecodeString?

  @[JSON::Field(key: "Decoder")]
  property decoder : UnionDecoder?

  @[JSON::Field(key: "DecodingError")]
  property decoding_error : UnionDecodingError?

  @[JSON::Field(key: "def")]
  property top_level_def : UnionDef?

  property default : UnionDefault?

  property defer : UnionDefer?

  property deinit : UnionDeinit?

  property del : UnionDel?

  property delegate : UnionDelegate?

  property delete : UnionDelete?

  @[JSON::Field(key: "DeserializationFeature")]
  property deserialization_feature : UnionDeserializationFeature?

  property dict : UnionDict?

  property dictionary : UnionDictionary?

  @[JSON::Field(key: "didSet")]
  property did_set : UnionDidSet?

  @[JSON::Field(key: "do")]
  property top_level_do : UnionDo?

  property double : UnionDouble?

  @[JSON::Field(key: "DoubleNode")]
  property double_node : UnionDoubleNode?

  property dummy : Float64?

  property dynamic : UnionDynamic?

  property dynamic_cast : UnionDynamicCast?

  property elif : UnionElif?

  @[JSON::Field(key: "else")]
  property top_level_else : UnionElse?

  property encode_quick_type : UnionEncodeQuickType?

  @[JSON::Field(key: "Encoder")]
  property encoder : UnionEncoder?

  @[JSON::Field(key: "enum")]
  property top_level_enum : UnionEnum?

  @[JSON::Field(key: "EnumValues")]
  property enum_values : UnionEnumValues?

  @[JSON::Field(key: "equalityContract")]
  property equality_contract : UnionEqualityContract?

  @[JSON::Field(key: "Equatable")]
  property equatable : UnionEquatable?

  property event : UnionEvent?

  property except : UnionExcept?

  property exception : UnionException?

  property explicit : UnionExplicit?

  property export : UnionExport?

  property exposing : UnionExposing?

  property extends : UnionExtends?

  property extension : UnionExtension?

  property extern : UnionExtern?

  property fallthrough : UnionFallthrough?

  @[JSON::Field(key: "false")]
  property purple_false : UnionFalseUnion?

  @[JSON::Field(key: "False")]
  property top_level_false : UnionFalse?

  property fileprivate : UnionFileprivate?

  property final : UnionFinal?

  property finally : UnionFinally?

  property fixed : UnionFixed?

  property float : UnionFloat?

  @[JSON::Field(key: "for")]
  property top_level_for : UnionFor?

  property foreach : UnionForeach?

  @[JSON::Field(key: "FormatException")]
  property format_exception : UnionFormatException?

  property friend : UnionFriend?

  property from : UnionFrom?

  property from_dict : UnionFromDict?

  property from_json : UnionFromJson?

  property func : UnionFunc?

  property function : UnionFunction?

  property get : UnionGet?

  property global : UnionGlobal?

  property go : UnionGo?

  property goto : UnionGoto?

  property guard : UnionGuard?

  @[JSON::Field(key: "Hashable")]
  property hashable : UnionHashable?

  @[JSON::Field(key: "hashCode")]
  property hash_code : UnionHashCode?

  @[JSON::Field(key: "Hasher")]
  property hasher : UnionHasher?

  @[JSON::Field(key: "hasOwnProperty")]
  property has_own_property : UnionHasOwnProperty?

  property id : UnionId?

  @[JSON::Field(key: "if")]
  property top_level_if : UnionIf?

  @[JSON::Field(key: "IMP")]
  property imp : UnionImp?

  property implements : UnionImplements?

  property implicit : UnionImplicit?

  property import : UnionImport?

  @[JSON::Field(key: "in")]
  property top_level_in : UnionIn?

  property indirect : UnionIndirect?

  property infix : UnionInfix?

  property init : UnionInit?

  property inline : UnionInline?

  property inout : UnionInout?

  property instanceof : UnionInstanceof?

  property int : UnionInt?

  property interface : UnionInterface?

  property internal : UnionInternal?

  @[JSON::Field(key: "IntNode")]
  property int_node : UnionIntNode?

  property is : UnionIs?

  @[JSON::Field(key: "IsoDateTimeOffsetConverter")]
  property iso_date_time_offset_converter : UnionIsoDateTimeOffsetConverter?

  property iterable : UnionIterable?

  property jdec : UnionJdec?

  property jenc : UnionJenc?

  property jpipe : UnionJpipe?

  property json : UnionJson?

  property json_converter : UnionJsonConverter?

  property json_serializer : UnionJsonSerializer?

  property json_token : UnionJsonToken?

  property json_writer : UnionJsonWriter?

  @[JSON::Field(key: "JSONAny")]
  property json_any : UnionJsonAny?

  @[JSON::Field(key: "JSONCodingKey")]
  property json_coding_key : UnionJsonCodingKey?

  @[JSON::Field(key: "JSONDecoder")]
  property json_decoder : UnionJsonDecoder?

  @[JSON::Field(key: "JSONEncoder")]
  property json_encoder : UnionJsonEncoder?

  @[JSON::Field(key: "JsonException")]
  property json_exception : UnionJsonException?

  @[JSON::Field(key: "JsonGenerator")]
  property json_generator : UnionJsonGenerator?

  @[JSON::Field(key: "JsonNode")]
  property json_node : UnionJsonNode?

  @[JSON::Field(key: "JSONNull")]
  property json_null : UnionJsonNull?

  @[JSON::Field(key: "JsonParser")]
  property json_parser : UnionJsonParser?

  @[JSON::Field(key: "JsonReader")]
  property json_reader : UnionJsonReader?

  @[JSON::Field(key: "JsonTokenType")]
  property json_token_type : UnionJsonTokenType?

  @[JSON::Field(key: "KSerializer")]
  property k_serializer : UnionKSerializer?

  property lambda : UnionLambda?

  property lazy : UnionLazy?

  property left : UnionLeft?

  property let : UnionLet?

  property list : UnionList?

  @[JSON::Field(key: "LocalDate")]
  property local_date : UnionLocalDate?

  @[JSON::Field(key: "Locale")]
  property locale : UnionLocale?

  property lock : UnionLock?

  property long : UnionLong?

  @[JSON::Field(key: "LongNode")]
  property long_node : UnionLongNode?

  property map : UnionMap?

  @[JSON::Field(key: "MapEntry")]
  property map_entry : UnionMapEntry?

  @[JSON::Field(key: "MarshalJSON")]
  property marshal_json : UnionMarshalJson?

  property metadata_property_handling : UnionMetadataPropertyHandling?

  @[JSON::Field(key: "module")]
  property top_level_module : UnionModule?

  property mutable : UnionMutable?

  property mutating : UnionMutating?

  property namespace : UnionNamespace?

  property native : UnionNative?

  property new : UnionNew?

  property newtonsoft : UnionNewtonsoft?

  @[JSON::Field(key: "nil")]
  property top_level_nil : UnionNil?

  @[JSON::Field(key: "NO")]
  property no : UnionNo?

  property noexcept : UnionNoexcept?

  property nonatomic : UnionNonatomic?

  @[JSON::Field(key: "none")]
  property top_level_none : UnionNoneUnion?

  @[JSON::Field(key: "None")]
  property none : UnionNone?

  property nonlocal : UnionNonlocal?

  property nonmutating : UnionNonmutating?

  @[JSON::Field(key: "noSuchMethod")]
  property no_such_method : UnionNoSuchMethod?

  property not : UnionNot?

  property not_eq : UnionNotEq?

  @[JSON::Field(key: "NSError")]
  property ns_error : UnionNsError?

  @[JSON::Field(key: "NSObject")]
  property ns_object : UnionNsObject?

  @[JSON::Field(key: "NSString")]
  property ns_string : UnionNsString?

  @[JSON::Field(key: "NULL")]
  property null : UnionNull?

  @[JSON::Field(key: "null")]
  property top_level_null : UnionNullUnion?

  @[JSON::Field(key: "NullNode")]
  property null_node : UnionNullNode?

  property nullptr : UnionNullptr?

  property number : UnionNumber?

  property object : UnionObject?

  @[JSON::Field(key: "ObjectMapper")]
  property object_mapper : UnionObjectMapper?

  @[JSON::Field(key: "ObjectNode")]
  property object_node : UnionObjectNode?

  @[JSON::Field(key: "ObjectReader")]
  property object_reader : UnionObjectReader?

  @[JSON::Field(key: "ObjectWriter")]
  property object_writer : UnionObjectWriter?

  @[JSON::Field(key: "of")]
  property top_level_of : UnionOf?

  @[JSON::Field(key: "OffsetDateTime")]
  property offset_date_time : UnionOffsetDateTime?

  @[JSON::Field(key: "OffsetTime")]
  property offset_time : UnionOffsetTime?

  property oneway : UnionOneway?

  property open : UnionOpen?

  property operator : UnionOperator?

  property optional : UnionOptional?

  property or : UnionOr?

  property or_eq : UnionOrEq?

  @[JSON::Field(key: "out")]
  property top_level_out : UnionOut?

  property override : UnionOverride?

  property package : UnionPackage?

  property params : UnionParams?

  property pass : UnionPass?

  property port : UnionPort?

  property postfix : UnionPostfix?

  property precedence : UnionPrecedence?

  property prefix : UnionPrefix?

  @[JSON::Field(key: "PrimitiveKind")]
  property primitive_kind : UnionPrimitiveKind?

  property print : UnionPrint?

  property printf : UnionPrintf?

  @[JSON::Field(key: "printMembers")]
  property print_members : UnionPrintMembers?

  @[JSON::Field(key: "private")]
  property top_level_private : UnionPrivate?

  @[JSON::Field(key: "protected")]
  property top_level_protected : UnionProtected?

  @[JSON::Field(key: "Protocol")]
  property protocol : UnionProtocol?

  @[JSON::Field(key: "protocol")]
  property top_level_protocol : UnionProtocolUnion?

  property public : UnionPublic?

  property quicktype : UnionQuicktype?

  property raise : UnionRaise?

  property range : UnionRange?

  property readonly : UnionReadonly?

  property ref : UnionRef?

  @[JSON::Field(key: "RegExp")]
  property reg_exp : UnionRegExp?

  property register : UnionRegister?

  property reinterpret_cast : UnionReinterpretCast?

  property repeat : UnionRepeat?

  @[JSON::Field(key: "require")]
  property top_level_require : UnionRequire?

  property required : UnionRequired?

  property requires : UnionRequires?

  property restrict : UnionRestrict?

  property retain : UnionRetain?

  property rethrows : UnionRethrows?

  @[JSON::Field(key: "return")]
  property top_level_return : UnionReturn?

  property right : UnionRight?

  @[JSON::Field(key: "runtimeType")]
  property runtime_type : UnionRuntimeType?

  property s : UnionS?

  property sbyte : UnionSbyte?

  property sealed : UnionSealed?

  @[JSON::Field(key: "SEL")]
  property sel : UnionSel?

  @[JSON::Field(key: "select")]
  property top_level_select : UnionSelect?

  @[JSON::Field(key: "Self")]
  property top_level_self : UnionSelf?

  @[JSON::Field(key: "self")]
  property purple_self : UnionSelfUnion?

  @[JSON::Field(key: "Sendable")]
  property sendable : UnionSendable?

  @[JSON::Field(key: "SerialDescriptor")]
  property serial_descriptor : UnionSerialDescriptor?

  @[JSON::Field(key: "Serializable")]
  property serializable : UnionSerializable?

  @[JSON::Field(key: "SerializationFeature")]
  property serialization_feature : UnionSerializationFeature?

  property serialize : UnionSerialize?

  @[JSON::Field(key: "SerializerProvider")]
  property serializer_provider : UnionSerializerProvider?

  @[JSON::Field(key: "SerialName")]
  property serial_name : UnionSerialName?

  property set : UnionSet?

  property short : UnionShort?

  property signed : UnionSigned?

  @[JSON::Field(key: "SimpleModule")]
  property simple_module : UnionSimpleModule?

  @[JSON::Field(key: "sizeof")]
  property top_level_sizeof : UnionSizeof?

  property stackalloc : UnionStackalloc?

  @[JSON::Field(key: "Standards")]
  property standards : UnionStandards?

  property static : UnionStatic?

  property static_assert : UnionStaticAssert?

  property static_cast : UnionStaticCast?

  @[JSON::Field(key: "StdDeserializer")]
  property std_deserializer : UnionStdDeserializer?

  @[JSON::Field(key: "StdSerializer")]
  property std_serializer : UnionStdSerializer?

  property strictfp : UnionStrictfp?

  property string : UnionString?

  @[JSON::Field(key: "struct")]
  property top_level_struct : UnionStruct?

  property subscript : UnionSubscript?

  @[JSON::Field(key: "super")]
  property top_level_super : UnionSuper?

  property switch : UnionSwitch?

  property symbol : UnionSymbol?

  property synchronized : UnionSynchronized?

  property system : UnionSystem?

  property template : UnionTemplate?

  @[JSON::Field(key: "TextNode")]
  property text_node : UnionTextNode?

  @[JSON::Field(key: "then")]
  property top_level_then : UnionThen?

  property this : UnionThis?

  property thread_local : UnionThreadLocal?

  property throw : UnionThrow?

  property throws : UnionThrows?

  @[JSON::Field(key: "TimeOnly")]
  property time_only : UnionTimeOnly?

  @[JSON::Field(key: "TimeOnlyConverter")]
  property time_only_converter : UnionTimeOnlyConverter?

  @[JSON::Field(key: "TimeZone")]
  property time_zone : UnionTimeZone?

  property to_dict : UnionToDict?

  @[JSON::Field(key: "to_json")]
  property top_level_to_json : UnionToJson?

  property top_level : UnionTopLevel?

  @[JSON::Field(key: "toString")]
  property to_string : UnionToString?

  property transient : UnionTransient?

  @[JSON::Field(key: "True")]
  property top_level_true : UnionTrue?

  @[JSON::Field(key: "true")]
  property purple_true : UnionTrueUnion?

  property try : UnionTry?

  @[JSON::Field(key: "Type")]
  property top_level_type : UnionType?

  @[JSON::Field(key: "type")]
  property purple_type : UnionTypeUnion?

  property typealias : UnionTypealias?

  property typedef : UnionTypedef?

  property typeid : UnionTypeid?

  property typename : UnionTypename?

  @[JSON::Field(key: "typeof")]
  property top_level_typeof : UnionTypeof?

  property uint : UnionUint?

  property ulong : UnionUlong?

  property unchecked : UnionUnchecked?

  property undefined : UnionUndefined?

  @[JSON::Field(key: "union")]
  property top_level_union : UnionUnionUnion?

  @[JSON::Field(key: "UnmarshalJSON")]
  property unmarshal_json : UnionUnmarshalJson?

  property unowned : UnionUnowned?

  property unsafe : UnionUnsafe?

  property unsigned : UnionUnsigned?

  @[JSON::Field(key: "UseSerializers")]
  property use_serializers : UnionUseSerializers?

  property ushort : UnionUshort?

  property using : UnionUsing?

  @[JSON::Field(key: "Utf8JsonReader")]
  property utf8_json_reader : UnionUtf8JsonReader?

  @[JSON::Field(key: "Utf8JsonWriter")]
  property utf8_json_writer : UnionUtf8JsonWriter?

  @[JSON::Field(key: "UUID")]
  property uuid : UnionUuid?

  property var : UnionVar?

  property virtual : UnionVirtual?

  property void : UnionVoid?

  property volatile : UnionVolatile?

  property wchar_t : UnionWcharT?

  property weak : UnionWeak?

  property where : UnionWhere?

  @[JSON::Field(key: "while")]
  property top_level_while : UnionWhile?

  @[JSON::Field(key: "willSet")]
  property will_set : UnionWillSet?

  @[JSON::Field(key: "with")]
  property top_level_with : UnionWith?

  property xor : UnionXor?

  property xor_eq : UnionXorEq?

  @[JSON::Field(key: "YES")]
  property yes : UnionYes?

  @[JSON::Field(key: "yield")]
  property top_level_yield : UnionYield?
end

class Alignas
  include JSON::Serializable

end

class Alignof
  include JSON::Serializable

end

class And
  include JSON::Serializable

end

class AndEq
  include JSON::Serializable

end

class AnyClass
  include JSON::Serializable

end

class ArrayClass
  include JSON::Serializable

end

class ArrayNode
  include JSON::Serializable

end

class Assert
  include JSON::Serializable

end

class Associatedtype
  include JSON::Serializable

end

class Associativity
  include JSON::Serializable

end

class Async
  include JSON::Serializable

end

class AtomicClass
  include JSON::Serializable

end

class AtomicCancel
  include JSON::Serializable

end

class AtomicCommit
  include JSON::Serializable

end

class AtomicNoexcept
  include JSON::Serializable

end

class Auto
  include JSON::Serializable

end

class Await
  include JSON::Serializable

end

class Base
  include JSON::Serializable

end

class Bitand
  include JSON::Serializable

end

class Bitor
  include JSON::Serializable

end

class BoolClass
  include JSON::Serializable

end

class Boolean
  include JSON::Serializable

end

class BooleanNode
  include JSON::Serializable

end

class Bycopy
  include JSON::Serializable

end

class Byref
  include JSON::Serializable

end

class Byte
  include JSON::Serializable

end

class Calendar
  include JSON::Serializable

end

class Catch
  include JSON::Serializable

end

class Chan
  include JSON::Serializable

end

class CharClass
  include JSON::Serializable

end

class Char16T
  include JSON::Serializable

end

class Char32T
  include JSON::Serializable

end

class Checked
  include JSON::Serializable

end

class Clone
  include JSON::Serializable

end

class CoAwait
  include JSON::Serializable

end

class CoReturn
  include JSON::Serializable

end

class CoYield
  include JSON::Serializable

end

class Codable
  include JSON::Serializable

end

class CodingKey
  include JSON::Serializable

end

class CodingKeys
  include JSON::Serializable

end

class Compl
  include JSON::Serializable

end

class Complex
  include JSON::Serializable

end

class Concept
  include JSON::Serializable

end

class Console
  include JSON::Serializable

end

class Const
  include JSON::Serializable

end

class ConstCast
  include JSON::Serializable

end

class Constexpr
  include JSON::Serializable

end

class Constructor
  include JSON::Serializable

end

class Continue
  include JSON::Serializable

end

class Convenience
  include JSON::Serializable

end

class Convert
  include JSON::Serializable

end

class Converter
  include JSON::Serializable

end

class CultureInfo
  include JSON::Serializable

end

class Date
  include JSON::Serializable

end

class DateFormatter
  include JSON::Serializable

end

class DateOnly
  include JSON::Serializable

end

class DateOnlyConverter
  include JSON::Serializable

end

class DateParseHandling
  include JSON::Serializable

end

class DateTime
  include JSON::Serializable

end

class DateTimeStyles
  include JSON::Serializable

end

class Debugger
  include JSON::Serializable

end

class Decimal
  include JSON::Serializable

end

class Declare
  include JSON::Serializable

end

class Decltype
  include JSON::Serializable

end

class DecodeString
  include JSON::Serializable

end

class Decoder
  include JSON::Serializable

end

class DecodingError
  include JSON::Serializable

end

class Default
  include JSON::Serializable

end

class Defer
  include JSON::Serializable

end

class Deinit
  include JSON::Serializable

end

class Del
  include JSON::Serializable

end

class Delegate
  include JSON::Serializable

end

class Delete
  include JSON::Serializable

end

class DeserializationFeature
  include JSON::Serializable

end

class Dict
  include JSON::Serializable

end

class Dictionary
  include JSON::Serializable

end

class DidSet
  include JSON::Serializable

end

class Double
  include JSON::Serializable

end

class DoubleNode
  include JSON::Serializable

end

class Dynamic
  include JSON::Serializable

end

class DynamicCast
  include JSON::Serializable

end

class Elif
  include JSON::Serializable

end

class Empty
  include JSON::Serializable

end

class EncodeQuickType
  include JSON::Serializable

end

class Encoder
  include JSON::Serializable

end

class EnumValues
  include JSON::Serializable

end

class EqualityContract
  include JSON::Serializable

end

class Equatable
  include JSON::Serializable

end

class EventClass
  include JSON::Serializable

end

class Except
  include JSON::Serializable

end

class ExceptionClass
  include JSON::Serializable

end

class Explicit
  include JSON::Serializable

end

class Export
  include JSON::Serializable

end

class Exposing
  include JSON::Serializable

end

class Extends
  include JSON::Serializable

end

class Extension
  include JSON::Serializable

end

class ExternClass
  include JSON::Serializable

end

class Fallthrough
  include JSON::Serializable

end

class Fileprivate
  include JSON::Serializable

end

class Final
  include JSON::Serializable

end

class Finally
  include JSON::Serializable

end

class Fixed
  include JSON::Serializable

end

class FloatClass
  include JSON::Serializable

end

class Foreach
  include JSON::Serializable

end

class FormatException
  include JSON::Serializable

end

class Friend
  include JSON::Serializable

end

class From
  include JSON::Serializable

end

class FromDict
  include JSON::Serializable

end

class FromJson
  include JSON::Serializable

end

class Func
  include JSON::Serializable

end

class Function
  include JSON::Serializable

end

class Get
  include JSON::Serializable

end

class Global
  include JSON::Serializable

end

class Go
  include JSON::Serializable

end

class Goto
  include JSON::Serializable

end

class Guard
  include JSON::Serializable

end

class HasOwnProperty
  include JSON::Serializable

end

class HashCode
  include JSON::Serializable

end

class Hashable
  include JSON::Serializable

end

class Hasher
  include JSON::Serializable

end

class Id
  include JSON::Serializable

end

class Imaginery
  include JSON::Serializable

end

class Imp
  include JSON::Serializable

end

class Implements
  include JSON::Serializable

end

class Implicit
  include JSON::Serializable

end

class Import
  include JSON::Serializable

end

class Indirect
  include JSON::Serializable

end

class Infix
  include JSON::Serializable

end

class Init
  include JSON::Serializable

end

class Inline
  include JSON::Serializable

end

class Inout
  include JSON::Serializable

end

class Instanceof
  include JSON::Serializable

end

class IntClass
  include JSON::Serializable

end

class IntNode
  include JSON::Serializable

end

class Interface
  include JSON::Serializable

end

class Internal
  include JSON::Serializable

end

class Is
  include JSON::Serializable

end

class IsoDateTimeOffsetConverter
  include JSON::Serializable

end

class IterableClass
  include JSON::Serializable

end

class Jdec
  include JSON::Serializable

end

class Jenc
  include JSON::Serializable

end

class Jpipe
  include JSON::Serializable

end

class Json
  include JSON::Serializable

end

class JsonAny
  include JSON::Serializable

end

class JsonCodingKey
  include JSON::Serializable

end

class JsonConverter
  include JSON::Serializable

end

class JsonDecoder
  include JSON::Serializable

end

class JsonEncoder
  include JSON::Serializable

end

class JsonException
  include JSON::Serializable

end

class JsonGenerator
  include JSON::Serializable

end

class JsonNode
  include JSON::Serializable

end

class JsonNull
  include JSON::Serializable

end

class JsonParser
  include JSON::Serializable

end

class JsonReader
  include JSON::Serializable

end

class JsonSerializer
  include JSON::Serializable

end

class JsonToken
  include JSON::Serializable

end

class JsonTokenType
  include JSON::Serializable

end

class JsonWriter
  include JSON::Serializable

end

class KSerializer
  include JSON::Serializable

end

class Lambda
  include JSON::Serializable

end

class Lazy
  include JSON::Serializable

end

class Left
  include JSON::Serializable

end

class Let
  include JSON::Serializable

end

class List
  include JSON::Serializable

end

class LocalDate
  include JSON::Serializable

end

class Locale
  include JSON::Serializable

end

class Lock
  include JSON::Serializable

end

class Long
  include JSON::Serializable

end

class LongNode
  include JSON::Serializable

end

class Map
  include JSON::Serializable

end

class MapEntry
  include JSON::Serializable

end

class MarshalJson
  include JSON::Serializable

end

class MetadataPropertyHandling
  include JSON::Serializable

end

class Mutable
  include JSON::Serializable

end

class Mutating
  include JSON::Serializable

end

class Namespace
  include JSON::Serializable

end

class Native
  include JSON::Serializable

end

class New
  include JSON::Serializable

end

class Newtonsoft
  include JSON::Serializable

end

class No
  include JSON::Serializable

end

class NoSuchMethod
  include JSON::Serializable

end

class Noexcept
  include JSON::Serializable

end

class Nonatomic
  include JSON::Serializable

end

class None
  include JSON::Serializable

end

class Nonlocal
  include JSON::Serializable

end

class Nonmutating
  include JSON::Serializable

end

class Not
  include JSON::Serializable

end

class NotEq
  include JSON::Serializable

end

class NsError
  include JSON::Serializable

end

class NsObject
  include JSON::Serializable

end

class NsString
  include JSON::Serializable

end

class Null
  include JSON::Serializable

end

class NullNode
  include JSON::Serializable

end

class Nullptr
  include JSON::Serializable

end

class NumberClass
  include JSON::Serializable

end

class ObjectClass
  include JSON::Serializable

end

class ObjectMapper
  include JSON::Serializable

end

class ObjectNode
  include JSON::Serializable

end

class ObjectReader
  include JSON::Serializable

end

class ObjectWriter
  include JSON::Serializable

end

class OffsetDateTime
  include JSON::Serializable

end

class OffsetTime
  include JSON::Serializable

end

class Oneway
  include JSON::Serializable

end

class Open
  include JSON::Serializable

end

class Operator
  include JSON::Serializable

end

class Optional
  include JSON::Serializable

end

class Or
  include JSON::Serializable

end

class OrEq
  include JSON::Serializable

end

class Override
  include JSON::Serializable

end

class Package
  include JSON::Serializable

end

class Params
  include JSON::Serializable

end

class Pass
  include JSON::Serializable

end

class Port
  include JSON::Serializable

end

class Postfix
  include JSON::Serializable

end

class Precedence
  include JSON::Serializable

end

class Prefix
  include JSON::Serializable

end

class PrimitiveKind
  include JSON::Serializable

end

class Print
  include JSON::Serializable

end

class PrintMembers
  include JSON::Serializable

end

class Printf
  include JSON::Serializable

end

class Protocol
  include JSON::Serializable

end

class Public
  include JSON::Serializable

end

class UnionBoolBoolClass
  include JSON::Serializable

end

class UnionClassClass
  include JSON::Serializable

end

class FalseClass
  include JSON::Serializable

end

class SelfClass
  include JSON::Serializable

end

class TrueClass
  include JSON::Serializable

end

class TypeClass
  include JSON::Serializable

end

class Quicktype
  include JSON::Serializable

end

class Raise
  include JSON::Serializable

end

class RangeClass
  include JSON::Serializable

end

class Readonly
  include JSON::Serializable

end

class Ref
  include JSON::Serializable

end

class RegExp
  include JSON::Serializable

end

class Register
  include JSON::Serializable

end

class ReinterpretCast
  include JSON::Serializable

end

class Repeat
  include JSON::Serializable

end

class Required
  include JSON::Serializable

end

class Requires
  include JSON::Serializable

end

class Restrict
  include JSON::Serializable

end

class Retain
  include JSON::Serializable

end

class Rethrows
  include JSON::Serializable

end

class Right
  include JSON::Serializable

end

class RuntimeType
  include JSON::Serializable

end

class S
  include JSON::Serializable

end

class Sbyte
  include JSON::Serializable

end

class Sealed
  include JSON::Serializable

end

class Sel
  include JSON::Serializable

end

class Sendable
  include JSON::Serializable

end

class SerialDescriptor
  include JSON::Serializable

end

class SerialName
  include JSON::Serializable

end

class Serializable
  include JSON::Serializable

end

class SerializationFeature
  include JSON::Serializable

end

class Serialize
  include JSON::Serializable

end

class SerializerProvider
  include JSON::Serializable

end

class SetClass
  include JSON::Serializable

end

class Short
  include JSON::Serializable

end

class Signed
  include JSON::Serializable

end

class SimpleModule
  include JSON::Serializable

end

class Stackalloc
  include JSON::Serializable

end

class Standards
  include JSON::Serializable

end

class Static
  include JSON::Serializable

end

class StaticAssert
  include JSON::Serializable

end

class StaticCast
  include JSON::Serializable

end

class StdDeserializer
  include JSON::Serializable

end

class StdSerializer
  include JSON::Serializable

end

class Strictfp
  include JSON::Serializable

end

class StringClass
  include JSON::Serializable

end

class Subscript
  include JSON::Serializable

end

class Switch
  include JSON::Serializable

end

class SymbolClass
  include JSON::Serializable

end

class Synchronized
  include JSON::Serializable

end

class SystemClass
  include JSON::Serializable

end

class Template
  include JSON::Serializable

end

class TextNode
  include JSON::Serializable

end

class This
  include JSON::Serializable

end

class ThreadLocalClass
  include JSON::Serializable

end

class Throw
  include JSON::Serializable

end

class Throws
  include JSON::Serializable

end

class TimeOnly
  include JSON::Serializable

end

class TimeOnlyConverter
  include JSON::Serializable

end

class TimeZone
  include JSON::Serializable

end

class ToDict
  include JSON::Serializable

end

class ToString
  include JSON::Serializable

end

class TopLevelClass
  include JSON::Serializable

end

class Abstract
  include JSON::Serializable

end

class UnionAnyAny
  include JSON::Serializable

end

class As
  include JSON::Serializable

end

class Asm
  include JSON::Serializable

end

class UnionBoolBool
  include JSON::Serializable

end

class Break
  include JSON::Serializable

end

class Case
  include JSON::Serializable

end

class ClassClass
  include JSON::Serializable

end

class Def
  include JSON::Serializable

end

class Do
  include JSON::Serializable

end

class Else
  include JSON::Serializable

end

class EnumClass
  include JSON::Serializable

end

class False
  include JSON::Serializable

end

class For
  include JSON::Serializable

end

class If
  include JSON::Serializable

end

class In
  include JSON::Serializable

end

class Module
  include JSON::Serializable

end

class NilClass
  include JSON::Serializable

end

class NoneClass
  include JSON::Serializable

end

class NullClass
  include JSON::Serializable

end

class Of
  include JSON::Serializable

end

class Out
  include JSON::Serializable

end

class Private
  include JSON::Serializable

end

class Protected
  include JSON::Serializable

end

class ProtocolClass
  include JSON::Serializable

end

class Require
  include JSON::Serializable

end

class Return
  include JSON::Serializable

end

class Select
  include JSON::Serializable

end

class Self
  include JSON::Serializable

end

class Sizeof
  include JSON::Serializable

end

class StructClass
  include JSON::Serializable

end

class Super
  include JSON::Serializable

end

class Then
  include JSON::Serializable

end

class ToJson
  include JSON::Serializable

end

class True
  include JSON::Serializable

end

class Type
  include JSON::Serializable

end

class Typeof
  include JSON::Serializable

end

class UnionClass
  include JSON::Serializable

end

class While
  include JSON::Serializable

end

class With
  include JSON::Serializable

end

class Yield
  include JSON::Serializable

end

class Transient
  include JSON::Serializable

end

class Try
  include JSON::Serializable

end

class Typealias
  include JSON::Serializable

end

class Typedef
  include JSON::Serializable

end

class Typeid
  include JSON::Serializable

end

class Typename
  include JSON::Serializable

end

class Uint
  include JSON::Serializable

end

class Ulong
  include JSON::Serializable

end

class Unchecked
  include JSON::Serializable

end

class Undefined
  include JSON::Serializable

end

class UnmarshalJson
  include JSON::Serializable

end

class Unowned
  include JSON::Serializable

end

class Unsafe
  include JSON::Serializable

end

class Unsigned
  include JSON::Serializable

end

class UseSerializers
  include JSON::Serializable

end

class Ushort
  include JSON::Serializable

end

class Using
  include JSON::Serializable

end

class Utf8JsonReader
  include JSON::Serializable

end

class Utf8JsonWriter
  include JSON::Serializable

end

class Uuid
  include JSON::Serializable

end

class Var
  include JSON::Serializable

end

class Virtual
  include JSON::Serializable

end

class VoidClass
  include JSON::Serializable

end

class Volatile
  include JSON::Serializable

end

class WcharT
  include JSON::Serializable

end

class Weak
  include JSON::Serializable

end

class Where
  include JSON::Serializable

end

class WillSet
  include JSON::Serializable

end

class Xor
  include JSON::Serializable

end

class XorEq
  include JSON::Serializable

end

class Yes
  include JSON::Serializable

end

alias UnionAlignas = Alignas | Float64

alias UnionAlignof = Alignof | Float64

alias UnionAnd = And | Float64

alias UnionAndEq = AndEq | Float64

alias UnionAny = AnyClass | Float64

alias UnionArray = ArrayClass | Float64

alias UnionArrayNode = ArrayNode | Float64

alias UnionAssert = Assert | Float64

alias UnionAssociatedtype = Associatedtype | Float64

alias UnionAssociativity = Associativity | Float64

alias UnionAsync = Async | Float64

alias UnionAtomic = AtomicClass | Float64

alias UnionAtomicCancel = AtomicCancel | Float64

alias UnionAtomicCommit = AtomicCommit | Float64

alias UnionAtomicNoexcept = AtomicNoexcept | Float64

alias UnionAuto = Auto | Float64

alias UnionAwait = Await | Float64

alias UnionBase = Base | Float64

alias UnionBitand = Bitand | Float64

alias UnionBitor = Bitor | Float64

alias UnionBool = BoolClass | Float64

alias UnionBoolean = Boolean | Float64

alias UnionBooleanNode = BooleanNode | Float64

alias UnionBycopy = Bycopy | Float64

alias UnionByref = Byref | Float64

alias UnionByte = Byte | Float64

alias UnionCalendar = Calendar | Float64

alias UnionCatch = Catch | Float64

alias UnionChan = Chan | Float64

alias UnionChar = CharClass | Float64

alias UnionChar16T = Char16T | Float64

alias UnionChar32T = Char32T | Float64

alias UnionChecked = Checked | Float64

alias UnionClone = Clone | Float64

alias UnionCoAwait = CoAwait | Float64

alias UnionCoReturn = CoReturn | Float64

alias UnionCoYield = CoYield | Float64

alias UnionCodable = Codable | Float64

alias UnionCodingKey = CodingKey | Float64

alias UnionCodingKeys = CodingKeys | Float64

alias UnionCompl = Compl | Float64

alias UnionComplex = Complex | Float64

alias UnionConcept = Concept | Float64

alias UnionConsole = Console | Float64

alias UnionConst = Const | Float64

alias UnionConstCast = ConstCast | Float64

alias UnionConstexpr = Constexpr | Float64

alias UnionConstructor = Constructor | Float64

alias UnionContinue = Continue | Float64

alias UnionConvenience = Convenience | Float64

alias UnionConvert = Convert | Float64

alias UnionConverter = Converter | Float64

alias UnionCultureInfo = CultureInfo | Float64

alias UnionDate = Date | Float64

alias UnionDateFormatter = DateFormatter | Float64

alias UnionDateOnly = DateOnly | Float64

alias UnionDateOnlyConverter = DateOnlyConverter | Float64

alias UnionDateParseHandling = DateParseHandling | Float64

alias UnionDateTime = DateTime | Float64

alias UnionDateTimeStyles = DateTimeStyles | Float64

alias UnionDebugger = Debugger | Float64

alias UnionDecimal = Decimal | Float64

alias UnionDeclare = Declare | Float64

alias UnionDecltype = Decltype | Float64

alias UnionDecodeString = DecodeString | Float64

alias UnionDecoder = Decoder | Float64

alias UnionDecodingError = DecodingError | Float64

alias UnionDefault = Default | Float64

alias UnionDefer = Defer | Float64

alias UnionDeinit = Deinit | Float64

alias UnionDel = Del | Float64

alias UnionDelegate = Delegate | Float64

alias UnionDelete = Delete | Float64

alias UnionDeserializationFeature = DeserializationFeature | Float64

alias UnionDict = Dict | Float64

alias UnionDictionary = Dictionary | Float64

alias UnionDidSet = DidSet | Float64

alias UnionDouble = Float64 | Double

alias UnionDoubleNode = Float64 | DoubleNode

alias UnionDynamic = Float64 | Dynamic

alias UnionDynamicCast = Float64 | DynamicCast

alias UnionElif = Float64 | Elif

alias UnionUnion = Float64 | Empty

alias UnionEncodeQuickType = Float64 | EncodeQuickType

alias UnionEncoder = Float64 | Encoder

alias UnionEnumValues = Float64 | EnumValues

alias UnionEqualityContract = Float64 | EqualityContract

alias UnionEquatable = Float64 | Equatable

alias UnionEvent = Float64 | EventClass

alias UnionExcept = Float64 | Except

alias UnionException = Float64 | ExceptionClass

alias UnionExplicit = Float64 | Explicit

alias UnionExport = Float64 | Export

alias UnionExposing = Float64 | Exposing

alias UnionExtends = Float64 | Extends

alias UnionExtension = Float64 | Extension

alias UnionExtern = Float64 | ExternClass

alias UnionFallthrough = Float64 | Fallthrough

alias UnionFileprivate = Float64 | Fileprivate

alias UnionFinal = Float64 | Final

alias UnionFinally = Float64 | Finally

alias UnionFixed = Float64 | Fixed

alias UnionFloat = Float64 | FloatClass

alias UnionForeach = Float64 | Foreach

alias UnionFormatException = Float64 | FormatException

alias UnionFriend = Float64 | Friend

alias UnionFrom = Float64 | From

alias UnionFromDict = Float64 | FromDict

alias UnionFromJson = Float64 | FromJson

alias UnionFunc = Float64 | Func

alias UnionFunction = Float64 | Function

alias UnionGet = Float64 | Get

alias UnionGlobal = Float64 | Global

alias UnionGo = Float64 | Go

alias UnionGoto = Float64 | Goto

alias UnionGuard = Float64 | Guard

alias UnionHasOwnProperty = Float64 | HasOwnProperty

alias UnionHashCode = Float64 | HashCode

alias UnionHashable = Float64 | Hashable

alias UnionHasher = Float64 | Hasher

alias UnionId = Float64 | Id

alias UnionImaginery = Float64 | Imaginery

alias UnionImp = Float64 | Imp

alias UnionImplements = Float64 | Implements

alias UnionImplicit = Float64 | Implicit

alias UnionImport = Float64 | Import

alias UnionIndirect = Float64 | Indirect

alias UnionInfix = Float64 | Infix

alias UnionInit = Float64 | Init

alias UnionInline = Float64 | Inline

alias UnionInout = Float64 | Inout

alias UnionInstanceof = Float64 | Instanceof

alias UnionInt = Float64 | IntClass

alias UnionIntNode = Float64 | IntNode

alias UnionInterface = Float64 | Interface

alias UnionInternal = Float64 | Internal

alias UnionIs = Float64 | Is

alias UnionIsoDateTimeOffsetConverter = Float64 | IsoDateTimeOffsetConverter

alias UnionIterable = Float64 | IterableClass

alias UnionJdec = Float64 | Jdec

alias UnionJenc = Float64 | Jenc

alias UnionJpipe = Float64 | Jpipe

alias UnionJson = Float64 | Json

alias UnionJsonAny = Float64 | JsonAny

alias UnionJsonCodingKey = Float64 | JsonCodingKey

alias UnionJsonConverter = Float64 | JsonConverter

alias UnionJsonDecoder = Float64 | JsonDecoder

alias UnionJsonEncoder = Float64 | JsonEncoder

alias UnionJsonException = Float64 | JsonException

alias UnionJsonGenerator = Float64 | JsonGenerator

alias UnionJsonNode = Float64 | JsonNode

alias UnionJsonNull = Float64 | JsonNull

alias UnionJsonParser = Float64 | JsonParser

alias UnionJsonReader = Float64 | JsonReader

alias UnionJsonSerializer = Float64 | JsonSerializer

alias UnionJsonToken = Float64 | JsonToken

alias UnionJsonTokenType = Float64 | JsonTokenType

alias UnionJsonWriter = Float64 | JsonWriter

alias UnionKSerializer = Float64 | KSerializer

alias UnionLambda = Float64 | Lambda

alias UnionLazy = Float64 | Lazy

alias UnionLeft = Float64 | Left

alias UnionLet = Float64 | Let

alias UnionList = Float64 | List

alias UnionLocalDate = Float64 | LocalDate

alias UnionLocale = Float64 | Locale

alias UnionLock = Float64 | Lock

alias UnionLong = Float64 | Long

alias UnionLongNode = Float64 | LongNode

alias UnionMap = Float64 | Map

alias UnionMapEntry = Float64 | MapEntry

alias UnionMarshalJson = Float64 | MarshalJson

alias UnionMetadataPropertyHandling = Float64 | MetadataPropertyHandling

alias UnionMutable = Float64 | Mutable

alias UnionMutating = Float64 | Mutating

alias UnionNamespace = Float64 | Namespace

alias UnionNative = Float64 | Native

alias UnionNew = Float64 | New

alias UnionNewtonsoft = Float64 | Newtonsoft

alias UnionNo = Float64 | No

alias UnionNoSuchMethod = Float64 | NoSuchMethod

alias UnionNoexcept = Float64 | Noexcept

alias UnionNonatomic = Float64 | Nonatomic

alias UnionNone = Float64 | None

alias UnionNonlocal = Float64 | Nonlocal

alias UnionNonmutating = Float64 | Nonmutating

alias UnionNot = Float64 | Not

alias UnionNotEq = Float64 | NotEq

alias UnionNsError = Float64 | NsError

alias UnionNsObject = Float64 | NsObject

alias UnionNsString = Float64 | NsString

alias UnionNull = Float64 | Null

alias UnionNullNode = Float64 | NullNode

alias UnionNullptr = Float64 | Nullptr

alias UnionNumber = Float64 | NumberClass

alias UnionObject = Float64 | ObjectClass

alias UnionObjectMapper = Float64 | ObjectMapper

alias UnionObjectNode = Float64 | ObjectNode

alias UnionObjectReader = Float64 | ObjectReader

alias UnionObjectWriter = Float64 | ObjectWriter

alias UnionOffsetDateTime = Float64 | OffsetDateTime

alias UnionOffsetTime = Float64 | OffsetTime

alias UnionOneway = Float64 | Oneway

alias UnionOpen = Float64 | Open

alias UnionOperator = Float64 | Operator

alias UnionOptional = Float64 | Optional

alias UnionOr = Float64 | Or

alias UnionOrEq = Float64 | OrEq

alias UnionOverride = Float64 | Override

alias UnionPackage = Float64 | Package

alias UnionParams = Float64 | Params

alias UnionPass = Float64 | Pass

alias UnionPort = Float64 | Port

alias UnionPostfix = Float64 | Postfix

alias UnionPrecedence = Float64 | Precedence

alias UnionPrefix = Float64 | Prefix

alias UnionPrimitiveKind = Float64 | PrimitiveKind

alias UnionPrint = Float64 | Print

alias UnionPrintMembers = Float64 | PrintMembers

alias UnionPrintf = Float64 | Printf

alias UnionProtocol = Float64 | Protocol

alias UnionPublic = Float64 | Public

alias TopLevelUnionBool = Float64 | UnionBoolBoolClass

alias TopLevelUnionClass = Float64 | UnionClassClass

alias UnionFalseUnion = Float64 | FalseClass

alias UnionSelfUnion = Float64 | SelfClass

alias UnionTrueUnion = Float64 | TrueClass

alias UnionTypeUnion = Float64 | TypeClass

alias UnionQuicktype = Float64 | Quicktype

alias UnionRaise = Float64 | Raise

alias UnionRange = Float64 | RangeClass

alias UnionReadonly = Float64 | Readonly

alias UnionRef = Float64 | Ref

alias UnionRegExp = Float64 | RegExp

alias UnionRegister = Float64 | Register

alias UnionReinterpretCast = Float64 | ReinterpretCast

alias UnionRepeat = Float64 | Repeat

alias UnionRequired = Float64 | Required

alias UnionRequires = Float64 | Requires

alias UnionRestrict = Float64 | Restrict

alias UnionRetain = Float64 | Retain

alias UnionRethrows = Float64 | Rethrows

alias UnionRight = Float64 | Right

alias UnionRuntimeType = Float64 | RuntimeType

alias UnionS = Float64 | S

alias UnionSbyte = Float64 | Sbyte

alias UnionSealed = Float64 | Sealed

alias UnionSel = Float64 | Sel

alias UnionSendable = Float64 | Sendable

alias UnionSerialDescriptor = Float64 | SerialDescriptor

alias UnionSerialName = Float64 | SerialName

alias UnionSerializable = Float64 | Serializable

alias UnionSerializationFeature = Float64 | SerializationFeature

alias UnionSerialize = Float64 | Serialize

alias UnionSerializerProvider = Float64 | SerializerProvider

alias UnionSet = Float64 | SetClass

alias UnionShort = Float64 | Short

alias UnionSigned = Float64 | Signed

alias UnionSimpleModule = Float64 | SimpleModule

alias UnionStackalloc = Float64 | Stackalloc

alias UnionStandards = Float64 | Standards

alias UnionStatic = Float64 | Static

alias UnionStaticAssert = Float64 | StaticAssert

alias UnionStaticCast = Float64 | StaticCast

alias UnionStdDeserializer = Float64 | StdDeserializer

alias UnionStdSerializer = Float64 | StdSerializer

alias UnionStrictfp = Float64 | Strictfp

alias UnionString = Float64 | StringClass

alias UnionSubscript = Float64 | Subscript

alias UnionSwitch = Float64 | Switch

alias UnionSymbol = Float64 | SymbolClass

alias UnionSynchronized = Float64 | Synchronized

alias UnionSystem = Float64 | SystemClass

alias UnionTemplate = Float64 | Template

alias UnionTextNode = Float64 | TextNode

alias UnionThis = Float64 | This

alias UnionThreadLocal = Float64 | ThreadLocalClass

alias UnionThrow = Float64 | Throw

alias UnionThrows = Float64 | Throws

alias UnionTimeOnly = Float64 | TimeOnly

alias UnionTimeOnlyConverter = Float64 | TimeOnlyConverter

alias UnionTimeZone = Float64 | TimeZone

alias UnionToDict = Float64 | ToDict

alias UnionToString = Float64 | ToString

alias UnionTopLevel = Float64 | TopLevelClass

alias UnionAbstract = Abstract | Float64

alias UnionAnyUnion = Float64 | UnionAnyAny

alias UnionAs = As | Float64

alias UnionAsm = Asm | Float64

alias UnionBoolUnion = Float64 | UnionBoolBool

alias UnionBreak = Break | Float64

alias UnionCase = Case | Float64

alias UnionClassUnion = ClassClass | Float64

alias UnionDef = Def | Float64

alias UnionDo = Do | Float64

alias UnionElse = Float64 | Else

alias UnionEnum = Float64 | EnumClass

alias UnionFalse = Float64 | False

alias UnionFor = Float64 | For

alias UnionIf = Float64 | If

alias UnionIn = Float64 | In

alias UnionModule = Float64 | Module

alias UnionNil = Float64 | NilClass

alias UnionNoneUnion = Float64 | NoneClass

alias UnionNullUnion = Float64 | NullClass

alias UnionOf = Float64 | Of

alias UnionOut = Float64 | Out

alias UnionPrivate = Float64 | Private

alias UnionProtected = Float64 | Protected

alias UnionProtocolUnion = Float64 | ProtocolClass

alias UnionRequire = Float64 | Require

alias UnionReturn = Float64 | Return

alias UnionSelect = Float64 | Select

alias UnionSelf = Float64 | Self

alias UnionSizeof = Float64 | Sizeof

alias UnionStruct = Float64 | StructClass

alias UnionSuper = Float64 | Super

alias UnionThen = Float64 | Then

alias UnionToJson = Float64 | ToJson

alias UnionTrue = Float64 | True

alias UnionType = Float64 | Type

alias UnionTypeof = Float64 | Typeof

alias UnionUnionUnion = Float64 | UnionClass

alias UnionWhile = Float64 | While

alias UnionWith = Float64 | With

alias UnionYield = Float64 | Yield

alias UnionTransient = Float64 | Transient

alias UnionTry = Float64 | Try

alias UnionTypealias = Float64 | Typealias

alias UnionTypedef = Float64 | Typedef

alias UnionTypeid = Float64 | Typeid

alias UnionTypename = Float64 | Typename

alias UnionUint = Float64 | Uint

alias UnionUlong = Float64 | Ulong

alias UnionUnchecked = Float64 | Unchecked

alias UnionUndefined = Float64 | Undefined

alias UnionUnmarshalJson = Float64 | UnmarshalJson

alias UnionUnowned = Float64 | Unowned

alias UnionUnsafe = Float64 | Unsafe

alias UnionUnsigned = Float64 | Unsigned

alias UnionUseSerializers = Float64 | UseSerializers

alias UnionUshort = Float64 | Ushort

alias UnionUsing = Float64 | Using

alias UnionUtf8JsonReader = Float64 | Utf8JsonReader

alias UnionUtf8JsonWriter = Float64 | Utf8JsonWriter

alias UnionUuid = Float64 | Uuid

alias UnionVar = Float64 | Var

alias UnionVirtual = Float64 | Virtual

alias UnionVoid = Float64 | VoidClass

alias UnionVolatile = Float64 | Volatile

alias UnionWcharT = Float64 | WcharT

alias UnionWeak = Float64 | Weak

alias UnionWhere = Float64 | Where

alias UnionWillSet = Float64 | WillSet

alias UnionXor = Float64 | Xor

alias UnionXorEq = Float64 | XorEq

alias UnionYes = Float64 | Yes
