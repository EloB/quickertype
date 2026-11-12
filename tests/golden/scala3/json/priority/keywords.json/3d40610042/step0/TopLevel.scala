package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val dummy : Long,
    val obj1 : Obj1,
    val obj2 : Obj2,
    val obj3 : Obj3,
    val obj4 : Obj4,
    val obj5 : Obj5,
    val obj6 : Obj6
) derives Encoder.AsObject, Decoder

case class Obj1 (
    val alignas : Alignas,
    val alignof : Alignof,
    val and : And,
    val and_eq : AndEq,
    val `Any` : AnyClass,
    val array : ArrayClass,
    val ArrayNode : ArrayNode,
    val as : As,
    val asm : ASM,
    val assert : Assert,
    val associatedtype : Associatedtype,
    val associativity : Associativity,
    val async : Async,
    val atomic : Atomic,
    val atomic_cancel : AtomicCancel,
    val atomic_commit : AtomicCommit,
    val atomic_noexcept : AtomicNoexcept,
    val auto : Auto,
    val await : Await,
    val base : Base,
    val bitand : Bitand,
    val bitor : Bitor,
    val BOOL : Bool,
    val boolean : BooleanClass,
    val BooleanNode : BooleanNode,
    val break : Break,
    val bycopy : Bycopy,
    val byref : Byref,
    val byte : ByteClass,
    val Calendar : Calendar,
    val chan : Chan,
    val char : Char,
    val char16_t : Char16T,
    val char32_t : Char32T,
    val checked : Checked,
    val cloneValue : Clone,
    val co_await : CoAwait,
    val co_return : CoReturn,
    val co_yield : CoYield,
    val Codable : Codable,
    val CodingKey : CodingKey,
    val CodingKeys : CodingKeys,
    val compl : Compl,
    val _Complex : Complex,
    val concept : Concept,
    val console : Console,
    val const : Const,
    val const_cast : ConstCast,
    val constexpr : Constexpr,
    val constructor : Constructor,
    val continue : Continue,
    val convenience : Convenience,
    val convert : Convert,
    val converter : Converter,
    val dummy : Long,
    val empty : Empty,
    val _Imaginery : Imaginery,
    val `abstract` : Abstract,
    val any : Obj1Any,
    val _Bool : BoolClass,
    val `case` : Case,
    val `catch` : Catch,
    val Class : Class,
    val bool : Obj1Bool,
    val `class` : ClassClass
)

object Obj1:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "cloneValue" -> "clone",
                "empty" -> "_"
            )
        )
    given io.circe.Codec.AsObject[Obj1] = io.circe.derivation.ConfiguredCodec.derived

case class Alignas (
    val alignas : Long
) derives Encoder.AsObject, Decoder

case class Alignof (
    val alignof : Long
) derives Encoder.AsObject, Decoder

case class And (
    val and : Long
) derives Encoder.AsObject, Decoder

case class AndEq (
    val and_eq : Long
) derives Encoder.AsObject, Decoder

case class AnyClass (
    val `Any` : Long
) derives Encoder.AsObject, Decoder

case class ArrayClass (
    val array : Long
) derives Encoder.AsObject, Decoder

case class ArrayNode (
    val ArrayNode : Long
) derives Encoder.AsObject, Decoder

case class As (
    val as : Long
) derives Encoder.AsObject, Decoder

case class ASM (
    val asm : Long
) derives Encoder.AsObject, Decoder

case class Assert (
    val assert : Long
) derives Encoder.AsObject, Decoder

case class Associatedtype (
    val associatedtype : Long
) derives Encoder.AsObject, Decoder

case class Associativity (
    val associativity : Long
) derives Encoder.AsObject, Decoder

case class Async (
    val async : Long
) derives Encoder.AsObject, Decoder

case class Atomic (
    val atomic : Long
) derives Encoder.AsObject, Decoder

case class AtomicCancel (
    val atomic_cancel : Long
) derives Encoder.AsObject, Decoder

case class AtomicCommit (
    val atomic_commit : Long
) derives Encoder.AsObject, Decoder

case class AtomicNoexcept (
    val atomic_noexcept : Long
) derives Encoder.AsObject, Decoder

case class Auto (
    val auto : Long
) derives Encoder.AsObject, Decoder

case class Await (
    val await : Long
) derives Encoder.AsObject, Decoder

case class Base (
    val base : Long
) derives Encoder.AsObject, Decoder

case class Bitand (
    val bitand : Long
) derives Encoder.AsObject, Decoder

case class Bitor (
    val bitor : Long
) derives Encoder.AsObject, Decoder

case class Bool (
    val BOOL : Long
) derives Encoder.AsObject, Decoder

case class BooleanClass (
    val boolean : Long
) derives Encoder.AsObject, Decoder

case class BooleanNode (
    val BooleanNode : Long
) derives Encoder.AsObject, Decoder

case class Break (
    val break : Long
) derives Encoder.AsObject, Decoder

case class Bycopy (
    val bycopy : Long
) derives Encoder.AsObject, Decoder

case class Byref (
    val byref : Long
) derives Encoder.AsObject, Decoder

case class ByteClass (
    val byte : Long
) derives Encoder.AsObject, Decoder

case class Calendar (
    val Calendar : Long
) derives Encoder.AsObject, Decoder

case class Chan (
    val chan : Long
) derives Encoder.AsObject, Decoder

case class Char (
    val char : Long
) derives Encoder.AsObject, Decoder

case class Char16T (
    val char16_t : Long
) derives Encoder.AsObject, Decoder

case class Char32T (
    val char32_t : Long
) derives Encoder.AsObject, Decoder

case class Checked (
    val checked : Long
) derives Encoder.AsObject, Decoder

case class Clone (
    val cloneValue : Long
)

object Clone:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "cloneValue" -> "clone"
            )
        )
    given io.circe.Codec.AsObject[Clone] = io.circe.derivation.ConfiguredCodec.derived

case class CoAwait (
    val co_await : Long
) derives Encoder.AsObject, Decoder

case class CoReturn (
    val co_return : Long
) derives Encoder.AsObject, Decoder

case class CoYield (
    val co_yield : Long
) derives Encoder.AsObject, Decoder

case class Codable (
    val Codable : Long
) derives Encoder.AsObject, Decoder

case class CodingKey (
    val CodingKey : Long
) derives Encoder.AsObject, Decoder

case class CodingKeys (
    val CodingKeys : Long
) derives Encoder.AsObject, Decoder

case class Compl (
    val compl : Long
) derives Encoder.AsObject, Decoder

case class Complex (
    val _Complex : Long
) derives Encoder.AsObject, Decoder

case class Concept (
    val concept : Long
) derives Encoder.AsObject, Decoder

case class Console (
    val console : Long
) derives Encoder.AsObject, Decoder

case class Const (
    val const : Long
) derives Encoder.AsObject, Decoder

case class ConstCast (
    val const_cast : Long
) derives Encoder.AsObject, Decoder

case class Constexpr (
    val constexpr : Long
) derives Encoder.AsObject, Decoder

case class Constructor (
    val constructor : Long
) derives Encoder.AsObject, Decoder

case class Continue (
    val continue : Long
) derives Encoder.AsObject, Decoder

case class Convenience (
    val convenience : Long
) derives Encoder.AsObject, Decoder

case class Convert (
    val convert : Long
) derives Encoder.AsObject, Decoder

case class Converter (
    val converter : Long
) derives Encoder.AsObject, Decoder

case class Empty (
    val empty : Long
)

object Empty:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> "_"
            )
        )
    given io.circe.Codec.AsObject[Empty] = io.circe.derivation.ConfiguredCodec.derived

case class Imaginery (
    val _Imaginery : Long
) derives Encoder.AsObject, Decoder

case class Abstract (
    val `abstract` : Long
) derives Encoder.AsObject, Decoder

case class Obj1Any (
    val any : Long
) derives Encoder.AsObject, Decoder

case class BoolClass (
    val _Bool : Long
) derives Encoder.AsObject, Decoder

case class Case (
    val `case` : Long
) derives Encoder.AsObject, Decoder

case class Catch (
    val `catch` : Long
) derives Encoder.AsObject, Decoder

case class Class (
    val Class : Long
) derives Encoder.AsObject, Decoder

case class Obj1Bool (
    val bool : Long
) derives Encoder.AsObject, Decoder

case class ClassClass (
    val `class` : Long
) derives Encoder.AsObject, Decoder

case class Obj2 (
    val CultureInfo : CultureInfo,
    val date : Date,
    val DateFormatter : DateFormatter,
    val DateOnly : DateOnly,
    val DateOnlyConverter : DateOnlyConverter,
    val date_parse_handling : DateParseHandling,
    val DateTime : DateTime,
    val DateTimeStyles : DateTimeStyles,
    val debugger : Debugger,
    val decimal : Decimal,
    val declare : Declare,
    val decltype : Decltype,
    val decode_string : DecodeString,
    val Decoder : DecoderClass,
    val DecodingError : DecodingError,
    val default : Default,
    val defer : Defer,
    val deinit : Deinit,
    val del : Del,
    val delegate : Delegate,
    val delete : Delete,
    val DeserializationFeature : DeserializationFeature,
    val dict : Dict,
    val dictionary : Dictionary,
    val didSet : DidSet,
    val double : DoubleClass,
    val DoubleNode : DoubleNode,
    val dummy : Long,
    val dynamic : Dynamic,
    val dynamic_cast : DynamicCast,
    val elif : Elif,
    val encode_quick_type : EncodeQuickType,
    val Encoder : EncoderClass,
    val EnumValues : EnumValues,
    val equalityContract : EqualityContract,
    val Equatable : Equatable,
    val event : Event,
    val except : Except,
    val exception : ExceptionClass,
    val explicit : Explicit,
    val exposing : Exposing,
    val extension : Extension,
    val extern : Extern,
    val fallthrough : Fallthrough,
    val fileprivate : Fileprivate,
    val fixed : Fixed,
    val float : FloatClass,
    val foreach : Foreach,
    val FormatException : FormatException,
    val friend : Friend,
    val from : From,
    val from_dict : FromDict,
    val from_json : FromJSON,
    val func : Func,
    val `def` : Def,
    val `do` : Do,
    val `else` : Else,
    val `enum` : EnumClass,
    val `export` : Export,
    val `extends` : Extends,
    val False : False,
    val `final` : Final,
    val `finally` : Finally,
    val `for` : For,
    val `false` : FalseClass
) derives Encoder.AsObject, Decoder

case class CultureInfo (
    val CultureInfo : Long
) derives Encoder.AsObject, Decoder

case class Date (
    val date : Long
) derives Encoder.AsObject, Decoder

case class DateFormatter (
    val DateFormatter : Long
) derives Encoder.AsObject, Decoder

case class DateOnly (
    val DateOnly : Long
) derives Encoder.AsObject, Decoder

case class DateOnlyConverter (
    val DateOnlyConverter : Long
) derives Encoder.AsObject, Decoder

case class DateParseHandling (
    val date_parse_handling : Long
) derives Encoder.AsObject, Decoder

case class DateTime (
    val DateTime : java.time.Instant
) derives Encoder.AsObject, Decoder

case class DateTimeStyles (
    val DateTimeStyles : Long
) derives Encoder.AsObject, Decoder

case class Debugger (
    val debugger : Long
) derives Encoder.AsObject, Decoder

case class Decimal (
    val decimal : Long
) derives Encoder.AsObject, Decoder

case class Declare (
    val declare : Long
) derives Encoder.AsObject, Decoder

case class Decltype (
    val decltype : Long
) derives Encoder.AsObject, Decoder

case class DecodeString (
    val decode_string : Long
) derives Encoder.AsObject, Decoder

case class DecoderClass (
    val Decoder : Long
) derives Encoder.AsObject, Decoder

case class DecodingError (
    val DecodingError : Long
) derives Encoder.AsObject, Decoder

case class Default (
    val default : Long
) derives Encoder.AsObject, Decoder

case class Defer (
    val defer : Long
) derives Encoder.AsObject, Decoder

case class Deinit (
    val deinit : Long
) derives Encoder.AsObject, Decoder

case class Del (
    val del : Long
) derives Encoder.AsObject, Decoder

case class Delegate (
    val delegate : Long
) derives Encoder.AsObject, Decoder

case class Delete (
    val delete : Long
) derives Encoder.AsObject, Decoder

case class DeserializationFeature (
    val DeserializationFeature : Long
) derives Encoder.AsObject, Decoder

case class Dict (
    val dict : Long
) derives Encoder.AsObject, Decoder

case class Dictionary (
    val dictionary : Long
) derives Encoder.AsObject, Decoder

case class DidSet (
    val didSet : Long
) derives Encoder.AsObject, Decoder

case class DoubleClass (
    val double : Long
) derives Encoder.AsObject, Decoder

case class DoubleNode (
    val DoubleNode : Long
) derives Encoder.AsObject, Decoder

case class Dynamic (
    val dynamic : Long
) derives Encoder.AsObject, Decoder

case class DynamicCast (
    val dynamic_cast : Long
) derives Encoder.AsObject, Decoder

case class Elif (
    val elif : Long
) derives Encoder.AsObject, Decoder

case class EncodeQuickType (
    val encode_quick_type : Long
) derives Encoder.AsObject, Decoder

case class EncoderClass (
    val Encoder : Long
) derives Encoder.AsObject, Decoder

case class EnumValues (
    val EnumValues : Seq[EnumValue]
) derives Encoder.AsObject, Decoder

enum EnumValue : 
    case Ready
    case Done

given Decoder[EnumValue] = Decoder.decodeString.emap {
    case "ready" => scala.Right(EnumValue.Ready)
    case "done" => scala.Right(EnumValue.Done)
    case other => scala.Left("invalid EnumValue: " + other)
}
given Encoder[EnumValue] = Encoder.encodeString.contramap {
    case EnumValue.Ready => "ready"
    case EnumValue.Done => "done"
}

case class EqualityContract (
    val equalityContract : Long
) derives Encoder.AsObject, Decoder

case class Equatable (
    val Equatable : Long
) derives Encoder.AsObject, Decoder

case class Event (
    val event : Long
) derives Encoder.AsObject, Decoder

case class Except (
    val except : Long
) derives Encoder.AsObject, Decoder

case class ExceptionClass (
    val exception : Long
) derives Encoder.AsObject, Decoder

case class Explicit (
    val explicit : Long
) derives Encoder.AsObject, Decoder

case class Exposing (
    val exposing : Long
) derives Encoder.AsObject, Decoder

case class Extension (
    val extension : Long
) derives Encoder.AsObject, Decoder

case class Extern (
    val extern : Long
) derives Encoder.AsObject, Decoder

case class Fallthrough (
    val fallthrough : Long
) derives Encoder.AsObject, Decoder

case class Fileprivate (
    val fileprivate : Long
) derives Encoder.AsObject, Decoder

case class Fixed (
    val fixed : Long
) derives Encoder.AsObject, Decoder

case class FloatClass (
    val float : Long
) derives Encoder.AsObject, Decoder

case class Foreach (
    val foreach : Long
) derives Encoder.AsObject, Decoder

case class FormatException (
    val FormatException : Long
) derives Encoder.AsObject, Decoder

case class Friend (
    val friend : Long
) derives Encoder.AsObject, Decoder

case class From (
    val from : Long
) derives Encoder.AsObject, Decoder

case class FromDict (
    val from_dict : Long
) derives Encoder.AsObject, Decoder

case class FromJSON (
    val from_json : Long
) derives Encoder.AsObject, Decoder

case class Func (
    val func : Long
) derives Encoder.AsObject, Decoder

case class Def (
    val `def` : Long
) derives Encoder.AsObject, Decoder

case class Do (
    val `do` : Long
) derives Encoder.AsObject, Decoder

case class Else (
    val `else` : Long
) derives Encoder.AsObject, Decoder

case class EnumClass (
    val `enum` : Long
) derives Encoder.AsObject, Decoder

case class Export (
    val `export` : Long
) derives Encoder.AsObject, Decoder

case class Extends (
    val `extends` : Long
) derives Encoder.AsObject, Decoder

case class False (
    val False : Long
) derives Encoder.AsObject, Decoder

case class Final (
    val `final` : Long
) derives Encoder.AsObject, Decoder

case class Finally (
    val `finally` : Long
) derives Encoder.AsObject, Decoder

case class For (
    val `for` : Long
) derives Encoder.AsObject, Decoder

case class FalseClass (
    val `false` : Long
) derives Encoder.AsObject, Decoder

case class Obj3 (
    val dummy : Long,
    val function : Function,
    val get : Get,
    val global : Global,
    val go : Go,
    val goto : Goto,
    val guard : Guard,
    val hasOwnProperty : HasOwnProperty,
    val hashCodeValue : HashCode,
    val Hashable : Hashable,
    val Hasher : Hasher,
    val id : ID,
    val IMP : Imp,
    val implements : Implements,
    val in : In,
    val indirect : Indirect,
    val infix : Infix,
    val init : Init,
    val inline : Inline,
    val inout : Inout,
    val instanceof : Instanceof,
    val int : IntClass,
    val IntNode : IntNode,
    val interface : Interface,
    val internal : Internal,
    val is : Is,
    val IsoDateTimeOffsetConverter : ISODateTimeOffsetConverter,
    val iterable : Iterable,
    val jdec : Jdec,
    val jenc : Jenc,
    val jpipe : Jpipe,
    val json : JSON,
    val JSONAny : JSONAny,
    val JSONCodingKey : JSONCodingKey,
    val json_converter : JSONConverter,
    val JSONDecoder : JSONDecoder,
    val JSONEncoder : JSONEncoder,
    val JsonException : JSONException,
    val JsonGenerator : JSONGenerator,
    val JsonNode : JSONNode,
    val JSONNull : JSONNull,
    val JsonParser : JSONParser,
    val JsonReader : JSONReader,
    val json_serializer : JSONSerializer,
    val json_token : JSONToken,
    val JsonTokenType : JSONTokenType,
    val json_writer : JSONWriter,
    val lambda : Lambda,
    val left : Left,
    val let : Let,
    val list : ListClass,
    val LocalDate : LocalDate,
    val Locale : Locale,
    val lock : Lock,
    val long : LongClass,
    val LongNode : LongNode,
    val map : MapClass,
    val MapEntry : MapEntry,
    val MarshalJSON : MarshalJSON,
    val metadata_property_handling : MetadataPropertyHandling,
    val module : Module,
    val `if` : If,
    val `implicit` : Implicit,
    val `import` : Import,
    val `lazy` : Lazy
)

object Obj3:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "hashCodeValue" -> "hashCode"
            )
        )
    given io.circe.Codec.AsObject[Obj3] = io.circe.derivation.ConfiguredCodec.derived

case class Function (
    val function : Long
) derives Encoder.AsObject, Decoder

case class Get (
    val get : Long
) derives Encoder.AsObject, Decoder

case class Global (
    val global : Long
) derives Encoder.AsObject, Decoder

case class Go (
    val go : Long
) derives Encoder.AsObject, Decoder

case class Goto (
    val goto : Long
) derives Encoder.AsObject, Decoder

case class Guard (
    val guard : Long
) derives Encoder.AsObject, Decoder

case class HasOwnProperty (
    val hasOwnProperty : Long
) derives Encoder.AsObject, Decoder

case class HashCode (
    val hashCodeValue : Long
)

object HashCode:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "hashCodeValue" -> "hashCode"
            )
        )
    given io.circe.Codec.AsObject[HashCode] = io.circe.derivation.ConfiguredCodec.derived

case class Hashable (
    val Hashable : Long
) derives Encoder.AsObject, Decoder

case class Hasher (
    val Hasher : Long
) derives Encoder.AsObject, Decoder

case class ID (
    val id : Long
) derives Encoder.AsObject, Decoder

case class Imp (
    val IMP : Long
) derives Encoder.AsObject, Decoder

case class Implements (
    val implements : Long
) derives Encoder.AsObject, Decoder

case class In (
    val in : Long
) derives Encoder.AsObject, Decoder

case class Indirect (
    val indirect : Long
) derives Encoder.AsObject, Decoder

case class Infix (
    val infix : Long
) derives Encoder.AsObject, Decoder

case class Init (
    val init : Long
) derives Encoder.AsObject, Decoder

case class Inline (
    val inline : Long
) derives Encoder.AsObject, Decoder

case class Inout (
    val inout : Long
) derives Encoder.AsObject, Decoder

case class Instanceof (
    val instanceof : Long
) derives Encoder.AsObject, Decoder

case class IntClass (
    val int : Long
) derives Encoder.AsObject, Decoder

case class IntNode (
    val IntNode : Long
) derives Encoder.AsObject, Decoder

case class Interface (
    val interface : Long
) derives Encoder.AsObject, Decoder

case class Internal (
    val internal : Long
) derives Encoder.AsObject, Decoder

case class Is (
    val is : Long
) derives Encoder.AsObject, Decoder

case class ISODateTimeOffsetConverter (
    val IsoDateTimeOffsetConverter : Long
) derives Encoder.AsObject, Decoder

case class Iterable (
    val iterable : Long
) derives Encoder.AsObject, Decoder

case class Jdec (
    val jdec : Long
) derives Encoder.AsObject, Decoder

case class Jenc (
    val jenc : Long
) derives Encoder.AsObject, Decoder

case class Jpipe (
    val jpipe : Long
) derives Encoder.AsObject, Decoder

case class JSON (
    val json : Long
) derives Encoder.AsObject, Decoder

case class JSONAny (
    val JSONAny : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class JSONCodingKey (
    val JSONCodingKey : Long
) derives Encoder.AsObject, Decoder

case class JSONConverter (
    val json_converter : Long
) derives Encoder.AsObject, Decoder

case class JSONDecoder (
    val JSONDecoder : Long
) derives Encoder.AsObject, Decoder

case class JSONEncoder (
    val JSONEncoder : Long
) derives Encoder.AsObject, Decoder

case class JSONException (
    val JsonException : Long
) derives Encoder.AsObject, Decoder

case class JSONGenerator (
    val JsonGenerator : Long
) derives Encoder.AsObject, Decoder

case class JSONNode (
    val JsonNode : Long
) derives Encoder.AsObject, Decoder

case class JSONNull (
    val JSONNull : Long
) derives Encoder.AsObject, Decoder

case class JSONParser (
    val JsonParser : Long
) derives Encoder.AsObject, Decoder

case class JSONReader (
    val JsonReader : Long
) derives Encoder.AsObject, Decoder

case class JSONSerializer (
    val json_serializer : Long
) derives Encoder.AsObject, Decoder

case class JSONToken (
    val json_token : Long
) derives Encoder.AsObject, Decoder

case class JSONTokenType (
    val JsonTokenType : Long
) derives Encoder.AsObject, Decoder

case class JSONWriter (
    val json_writer : Long
) derives Encoder.AsObject, Decoder

case class Lambda (
    val lambda : Long
) derives Encoder.AsObject, Decoder

case class Left (
    val left : Long
) derives Encoder.AsObject, Decoder

case class Let (
    val let : Long
) derives Encoder.AsObject, Decoder

case class ListClass (
    val list : Long
) derives Encoder.AsObject, Decoder

case class LocalDate (
    val LocalDate : Long
) derives Encoder.AsObject, Decoder

case class Locale (
    val Locale : Long
) derives Encoder.AsObject, Decoder

case class Lock (
    val lock : Long
) derives Encoder.AsObject, Decoder

case class LongClass (
    val long : Long
) derives Encoder.AsObject, Decoder

case class LongNode (
    val LongNode : Long
) derives Encoder.AsObject, Decoder

case class MapClass (
    val map : Long
) derives Encoder.AsObject, Decoder

case class MapEntry (
    val MapEntry : Long
) derives Encoder.AsObject, Decoder

case class MarshalJSON (
    val MarshalJSON : Long
) derives Encoder.AsObject, Decoder

case class MetadataPropertyHandling (
    val metadata_property_handling : Long
) derives Encoder.AsObject, Decoder

case class Module (
    val module : Long
) derives Encoder.AsObject, Decoder

case class If (
    val `if` : Long
) derives Encoder.AsObject, Decoder

case class Implicit (
    val `implicit` : Long
) derives Encoder.AsObject, Decoder

case class Import (
    val `import` : Long
) derives Encoder.AsObject, Decoder

case class Lazy (
    val `lazy` : Long
) derives Encoder.AsObject, Decoder

case class Obj4 (
    val dummy : Long,
    val mutable : Mutable,
    val mutating : Mutating,
    val namespace : Namespace,
    val native : Native,
    val newtonsoft : Newtonsoft,
    val nil : Nil,
    val NO : No,
    val noSuchMethod : NoSuchMethod,
    val noexcept : Noexcept,
    val nonatomic : Nonatomic,
    val None : NoneClass,
    val nonlocal : Nonlocal,
    val nonmutating : Nonmutating,
    val not : Not,
    val not_eq : NotEq,
    val NSError : NSError,
    val NSObject : NSObject,
    val NSString : NSString,
    val NullNode : NullNode,
    val nullptr : Nullptr,
    val number : Number,
    val NULL : NULLClass,
    val `new` : New,
    val none : Obj4None,
    val `null` : NullClass,
    val `object` : Object,
    val `override` : Override,
    val `package` : Package,
    val `private` : Private,
    val `protected` : Protected,
    val protocol : ProtocolClass,
    val ObjectMapper : ObjectMapper,
    val ObjectNode : ObjectNode,
    val ObjectReader : ObjectReader,
    val ObjectWriter : ObjectWriter,
    val of : Of,
    val OffsetDateTime : OffsetDateTime,
    val OffsetTime : OffsetTime,
    val oneway : Oneway,
    val open : Open,
    val operator : Operator,
    val optional : Optional,
    val or : Or,
    val or_eq : OrEq,
    val out : Out,
    val params : Params,
    val pass : Pass,
    val port : Port,
    val postfix : Postfix,
    val precedence : Precedence,
    val prefix : Prefix,
    val print : Print,
    val printMembers : PrintMembers,
    val printf : Printf,
    val Protocol : Protocol,
    val public : Public,
    val quicktype : Quicktype,
    val raise : Raise,
    val range : Range,
    val readonly : Readonly,
    val ref : Ref,
    val RegExp : RegExp,
    val register : Register,
    val reinterpret_cast : ReinterpretCast
) derives Encoder.AsObject, Decoder

case class Mutable (
    val mutable : Long
) derives Encoder.AsObject, Decoder

case class Mutating (
    val mutating : Long
) derives Encoder.AsObject, Decoder

case class Namespace (
    val namespace : Long
) derives Encoder.AsObject, Decoder

case class Native (
    val native : Long
) derives Encoder.AsObject, Decoder

case class Newtonsoft (
    val newtonsoft : Long
) derives Encoder.AsObject, Decoder

case class Nil (
    val nil : Long
) derives Encoder.AsObject, Decoder

case class No (
    val NO : Long
) derives Encoder.AsObject, Decoder

case class NoSuchMethod (
    val noSuchMethod : Long
) derives Encoder.AsObject, Decoder

case class Noexcept (
    val noexcept : Long
) derives Encoder.AsObject, Decoder

case class Nonatomic (
    val nonatomic : Long
) derives Encoder.AsObject, Decoder

case class NoneClass (
    val None : Long
) derives Encoder.AsObject, Decoder

case class Nonlocal (
    val nonlocal : Long
) derives Encoder.AsObject, Decoder

case class Nonmutating (
    val nonmutating : Long
) derives Encoder.AsObject, Decoder

case class Not (
    val not : Long
) derives Encoder.AsObject, Decoder

case class NotEq (
    val not_eq : Long
) derives Encoder.AsObject, Decoder

case class NSError (
    val NSError : Long
) derives Encoder.AsObject, Decoder

case class NSObject (
    val NSObject : Long
) derives Encoder.AsObject, Decoder

case class NSString (
    val NSString : Long
) derives Encoder.AsObject, Decoder

case class NullNode (
    val NullNode : Long
) derives Encoder.AsObject, Decoder

case class Nullptr (
    val nullptr : Long
) derives Encoder.AsObject, Decoder

case class Number (
    val number : Long
) derives Encoder.AsObject, Decoder

case class NULLClass (
    val NULL : Long
) derives Encoder.AsObject, Decoder

case class New (
    val `new` : Long
) derives Encoder.AsObject, Decoder

case class Obj4None (
    val none : Long
) derives Encoder.AsObject, Decoder

case class NullClass (
    val `null` : Long
) derives Encoder.AsObject, Decoder

case class Object (
    val `object` : Long
) derives Encoder.AsObject, Decoder

case class Override (
    val `override` : Long
) derives Encoder.AsObject, Decoder

case class Package (
    val `package` : Long
) derives Encoder.AsObject, Decoder

case class Private (
    val `private` : Long
) derives Encoder.AsObject, Decoder

case class Protected (
    val `protected` : Long
) derives Encoder.AsObject, Decoder

case class ProtocolClass (
    val protocol : Long
) derives Encoder.AsObject, Decoder

case class ObjectMapper (
    val ObjectMapper : Long
) derives Encoder.AsObject, Decoder

case class ObjectNode (
    val ObjectNode : Long
) derives Encoder.AsObject, Decoder

case class ObjectReader (
    val ObjectReader : Long
) derives Encoder.AsObject, Decoder

case class ObjectWriter (
    val ObjectWriter : Long
) derives Encoder.AsObject, Decoder

case class Of (
    val of : Long
) derives Encoder.AsObject, Decoder

case class OffsetDateTime (
    val OffsetDateTime : Long
) derives Encoder.AsObject, Decoder

case class OffsetTime (
    val OffsetTime : Long
) derives Encoder.AsObject, Decoder

case class Oneway (
    val oneway : Long
) derives Encoder.AsObject, Decoder

case class Open (
    val open : Long
) derives Encoder.AsObject, Decoder

case class Operator (
    val operator : Long
) derives Encoder.AsObject, Decoder

case class Optional (
    val optional : Long
) derives Encoder.AsObject, Decoder

case class Or (
    val or : Long
) derives Encoder.AsObject, Decoder

case class OrEq (
    val or_eq : Long
) derives Encoder.AsObject, Decoder

case class Out (
    val out : Long
) derives Encoder.AsObject, Decoder

case class Params (
    val params : Long
) derives Encoder.AsObject, Decoder

case class Pass (
    val pass : Long
) derives Encoder.AsObject, Decoder

case class Port (
    val port : Long
) derives Encoder.AsObject, Decoder

case class Postfix (
    val postfix : Long
) derives Encoder.AsObject, Decoder

case class Precedence (
    val precedence : Long
) derives Encoder.AsObject, Decoder

case class Prefix (
    val prefix : Long
) derives Encoder.AsObject, Decoder

case class Print (
    val print : Long
) derives Encoder.AsObject, Decoder

case class PrintMembers (
    val printMembers : Long
) derives Encoder.AsObject, Decoder

case class Printf (
    val printf : Long
) derives Encoder.AsObject, Decoder

case class Protocol (
    val Protocol : Long
) derives Encoder.AsObject, Decoder

case class Public (
    val public : Long
) derives Encoder.AsObject, Decoder

case class Quicktype (
    val quicktype : Long
) derives Encoder.AsObject, Decoder

case class Raise (
    val raise : Long
) derives Encoder.AsObject, Decoder

case class Range (
    val range : Long
) derives Encoder.AsObject, Decoder

case class Readonly (
    val readonly : Long
) derives Encoder.AsObject, Decoder

case class Ref (
    val ref : Long
) derives Encoder.AsObject, Decoder

case class RegExp (
    val RegExp : java.util.UUID
) derives Encoder.AsObject, Decoder

case class Register (
    val register : Long
) derives Encoder.AsObject, Decoder

case class ReinterpretCast (
    val reinterpret_cast : Long
) derives Encoder.AsObject, Decoder

case class Obj5 (
    val dummy : Long,
    val KSerializer : KSerializer,
    val `return` : Return,
    val `sealed` : Sealed,
    val self : SelfClass,
    val `super` : Super,
    val `then` : Then,
    val `this` : This,
    val `throw` : Throw,
    val True : True,
    val PrimitiveKind : PrimitiveKind,
    val `true` : TrueClass,
    val repeat : Repeat,
    val require : Require,
    val required : Required,
    val requires : Requires,
    val restrict : Restrict,
    val retain : Retain,
    val rethrows : Rethrows,
    val right : Right,
    val runtimeType : RuntimeType,
    val s : S,
    val sbyte : Sbyte,
    val SEL : Sel,
    val select : Select,
    val Self : Self,
    val Sendable : Sendable,
    val SerialDescriptor : SerialDescriptor,
    val SerialName : SerialName,
    val Serializable : Serializable,
    val SerializationFeature : SerializationFeature,
    val serialize : Serialize,
    val SerializerProvider : SerializerProvider,
    val set : Set,
    val short : ShortClass,
    val signed : Signed,
    val SimpleModule : SimpleModule,
    val sizeof : Sizeof,
    val stackalloc : Stackalloc,
    val Standards : Standards,
    val static : Static,
    val static_assert : StaticAssert,
    val static_cast : StaticCast,
    val StdDeserializer : StdDeserializer,
    val StdSerializer : StdSerializer,
    val strictfp : Strictfp,
    val string : StringClass,
    val struct : Struct,
    val subscript : Subscript,
    val switch : Switch,
    val symbol : Symbol,
    val synchronizedValue : Synchronized,
    val system : SystemClass,
    val template : Template,
    val TextNode : TextNode,
    val thread_local : ThreadLocal,
    val throws : Throws,
    val TimeOnly : TimeOnly,
    val TimeOnlyConverter : TimeOnlyConverter,
    val TimeZone : TimeZone,
    val to_dict : ToDict,
    val to_json : ToJSON,
    val toStringValue : ToString,
    val top_level : TopLevelClass,
    val transient : Transient
)

object Obj5:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "synchronizedValue" -> "synchronized",
                "toStringValue" -> "toString"
            )
        )
    given io.circe.Codec.AsObject[Obj5] = io.circe.derivation.ConfiguredCodec.derived

case class KSerializer (
    val KSerializer : Long
) derives Encoder.AsObject, Decoder

case class Return (
    val `return` : Long
) derives Encoder.AsObject, Decoder

case class Sealed (
    val `sealed` : Long
) derives Encoder.AsObject, Decoder

case class SelfClass (
    val self : Long
) derives Encoder.AsObject, Decoder

case class Super (
    val `super` : Long
) derives Encoder.AsObject, Decoder

case class Then (
    val `then` : Long
) derives Encoder.AsObject, Decoder

case class This (
    val `this` : Long
) derives Encoder.AsObject, Decoder

case class Throw (
    val `throw` : Long
) derives Encoder.AsObject, Decoder

case class True (
    val True : Long
) derives Encoder.AsObject, Decoder

case class PrimitiveKind (
    val PrimitiveKind : Long
) derives Encoder.AsObject, Decoder

case class TrueClass (
    val `true` : Long
) derives Encoder.AsObject, Decoder

case class Repeat (
    val repeat : Long
) derives Encoder.AsObject, Decoder

case class Require (
    val require : Long
) derives Encoder.AsObject, Decoder

case class Required (
    val required : Long
) derives Encoder.AsObject, Decoder

case class Requires (
    val requires : Long
) derives Encoder.AsObject, Decoder

case class Restrict (
    val restrict : Long
) derives Encoder.AsObject, Decoder

case class Retain (
    val retain : Long
) derives Encoder.AsObject, Decoder

case class Rethrows (
    val rethrows : Long
) derives Encoder.AsObject, Decoder

case class Right (
    val right : Long
) derives Encoder.AsObject, Decoder

case class RuntimeType (
    val runtimeType : Long
) derives Encoder.AsObject, Decoder

case class S (
    val s : Long
) derives Encoder.AsObject, Decoder

case class Sbyte (
    val sbyte : Long
) derives Encoder.AsObject, Decoder

case class Sel (
    val SEL : Long
) derives Encoder.AsObject, Decoder

case class Select (
    val select : Long
) derives Encoder.AsObject, Decoder

case class Self (
    val Self : Long
) derives Encoder.AsObject, Decoder

case class Sendable (
    val Sendable : Long
) derives Encoder.AsObject, Decoder

case class SerialDescriptor (
    val SerialDescriptor : Long
) derives Encoder.AsObject, Decoder

case class SerialName (
    val SerialName : Long
) derives Encoder.AsObject, Decoder

case class Serializable (
    val Serializable : Long
) derives Encoder.AsObject, Decoder

case class SerializationFeature (
    val SerializationFeature : Long
) derives Encoder.AsObject, Decoder

case class Serialize (
    val serialize : Long
) derives Encoder.AsObject, Decoder

case class SerializerProvider (
    val SerializerProvider : Long
) derives Encoder.AsObject, Decoder

case class Set (
    val set : Long
) derives Encoder.AsObject, Decoder

case class ShortClass (
    val short : Long
) derives Encoder.AsObject, Decoder

case class Signed (
    val signed : Long
) derives Encoder.AsObject, Decoder

case class SimpleModule (
    val SimpleModule : Long
) derives Encoder.AsObject, Decoder

case class Sizeof (
    val sizeof : Long
) derives Encoder.AsObject, Decoder

case class Stackalloc (
    val stackalloc : Long
) derives Encoder.AsObject, Decoder

case class Standards (
    val Standards : Long
) derives Encoder.AsObject, Decoder

case class Static (
    val static : Long
) derives Encoder.AsObject, Decoder

case class StaticAssert (
    val static_assert : Long
) derives Encoder.AsObject, Decoder

case class StaticCast (
    val static_cast : Long
) derives Encoder.AsObject, Decoder

case class StdDeserializer (
    val StdDeserializer : Long
) derives Encoder.AsObject, Decoder

case class StdSerializer (
    val StdSerializer : Long
) derives Encoder.AsObject, Decoder

case class Strictfp (
    val strictfp : Long
) derives Encoder.AsObject, Decoder

case class StringClass (
    val string : Long
) derives Encoder.AsObject, Decoder

case class Struct (
    val struct : Long
) derives Encoder.AsObject, Decoder

case class Subscript (
    val subscript : Long
) derives Encoder.AsObject, Decoder

case class Switch (
    val switch : Long
) derives Encoder.AsObject, Decoder

case class Symbol (
    val symbol : Long
) derives Encoder.AsObject, Decoder

case class Synchronized (
    val synchronizedValue : Long
)

object Synchronized:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "synchronizedValue" -> "synchronized"
            )
        )
    given io.circe.Codec.AsObject[Synchronized] = io.circe.derivation.ConfiguredCodec.derived

case class SystemClass (
    val system : Long
) derives Encoder.AsObject, Decoder

case class Template (
    val template : Long
) derives Encoder.AsObject, Decoder

case class TextNode (
    val TextNode : Long
) derives Encoder.AsObject, Decoder

case class ThreadLocal (
    val thread_local : Long
) derives Encoder.AsObject, Decoder

case class Throws (
    val throws : Long
) derives Encoder.AsObject, Decoder

case class TimeOnly (
    val TimeOnly : Long
) derives Encoder.AsObject, Decoder

case class TimeOnlyConverter (
    val TimeOnlyConverter : Long
) derives Encoder.AsObject, Decoder

case class TimeZone (
    val TimeZone : Long
) derives Encoder.AsObject, Decoder

case class ToDict (
    val to_dict : Long
) derives Encoder.AsObject, Decoder

case class ToJSON (
    val to_json : Long
) derives Encoder.AsObject, Decoder

case class ToString (
    val toStringValue : Long
)

object ToString:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "toStringValue" -> "toString"
            )
        )
    given io.circe.Codec.AsObject[ToString] = io.circe.derivation.ConfiguredCodec.derived

case class TopLevelClass (
    val top_level : Long
) derives Encoder.AsObject, Decoder

case class Transient (
    val transient : Long
) derives Encoder.AsObject, Decoder

case class Obj6 (
    val dummy : Long,
    val `try` : Try,
    val Type : Type,
    val `var` : Var,
    val `while` : While,
    val `with` : With,
    val `yield` : Yield,
    val `type` : TypeClass,
    val typealias : Typealias,
    val typedef : Typedef,
    val typeid : Typeid,
    val typename : Typename,
    val typeof : Typeof,
    val uint : Uint,
    val ulong : Ulong,
    val unchecked : Unchecked,
    val undefined : Undefined,
    val union : Union,
    val UnmarshalJSON : UnmarshalJSON,
    val unowned : Unowned,
    val unsafe : Unsafe,
    val unsigned : Unsigned,
    val UseSerializers : UseSerializers,
    val ushort : Ushort,
    val using : Using,
    val Utf8JsonReader : Utf8JSONReader,
    val Utf8JsonWriter : Utf8JSONWriter,
    val UUID : UUID,
    val virtual : Virtual,
    val void : Void,
    val volatile : Volatile,
    val wchar_t : WcharT,
    val weak : Weak,
    val where : Where,
    val willSet : WillSet,
    val xor : Xor,
    val xor_eq : XorEq,
    val YES : Yes
) derives Encoder.AsObject, Decoder

case class Try (
    val `try` : Long
) derives Encoder.AsObject, Decoder

case class Type (
    val Type : Long
) derives Encoder.AsObject, Decoder

case class Var (
    val `var` : Long
) derives Encoder.AsObject, Decoder

case class While (
    val `while` : Long
) derives Encoder.AsObject, Decoder

case class With (
    val `with` : Long
) derives Encoder.AsObject, Decoder

case class Yield (
    val `yield` : Long
) derives Encoder.AsObject, Decoder

case class TypeClass (
    val `type` : Long
) derives Encoder.AsObject, Decoder

case class Typealias (
    val typealias : Long
) derives Encoder.AsObject, Decoder

case class Typedef (
    val typedef : Long
) derives Encoder.AsObject, Decoder

case class Typeid (
    val typeid : Long
) derives Encoder.AsObject, Decoder

case class Typename (
    val typename : Long
) derives Encoder.AsObject, Decoder

case class Typeof (
    val typeof : Long
) derives Encoder.AsObject, Decoder

case class Uint (
    val uint : Long
) derives Encoder.AsObject, Decoder

case class Ulong (
    val ulong : Long
) derives Encoder.AsObject, Decoder

case class Unchecked (
    val unchecked : Long
) derives Encoder.AsObject, Decoder

case class Undefined (
    val undefined : Long
) derives Encoder.AsObject, Decoder

case class Union (
    val union : Long
) derives Encoder.AsObject, Decoder

case class UnmarshalJSON (
    val UnmarshalJSON : Long
) derives Encoder.AsObject, Decoder

case class Unowned (
    val unowned : Long
) derives Encoder.AsObject, Decoder

case class Unsafe (
    val unsafe : Long
) derives Encoder.AsObject, Decoder

case class Unsigned (
    val unsigned : Long
) derives Encoder.AsObject, Decoder

case class UseSerializers (
    val UseSerializers : Long
) derives Encoder.AsObject, Decoder

case class Ushort (
    val ushort : Long
) derives Encoder.AsObject, Decoder

case class Using (
    val using : Long
) derives Encoder.AsObject, Decoder

case class Utf8JSONReader (
    val Utf8JsonReader : Long
) derives Encoder.AsObject, Decoder

case class Utf8JSONWriter (
    val Utf8JsonWriter : Long
) derives Encoder.AsObject, Decoder

case class UUID (
    val UUID : Long
) derives Encoder.AsObject, Decoder

case class Virtual (
    val virtual : Long
) derives Encoder.AsObject, Decoder

case class Void (
    val void : Long
) derives Encoder.AsObject, Decoder

case class Volatile (
    val volatile : Long
) derives Encoder.AsObject, Decoder

case class WcharT (
    val wchar_t : Long
) derives Encoder.AsObject, Decoder

case class Weak (
    val weak : Long
) derives Encoder.AsObject, Decoder

case class Where (
    val where : Long
) derives Encoder.AsObject, Decoder

case class WillSet (
    val willSet : Long
) derives Encoder.AsObject, Decoder

case class Xor (
    val xor : Long
) derives Encoder.AsObject, Decoder

case class XorEq (
    val xor_eq : Long
) derives Encoder.AsObject, Decoder

case class Yes (
    val YES : Long
) derives Encoder.AsObject, Decoder
