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
    val dummy : Long,
    val obj1 : Obj1,
    val obj2 : Obj2,
    val obj3 : Obj3,
    val obj4 : Obj4,
    val obj5 : Obj5,
    val obj6 : Obj6
) derives OptionPickler.ReadWriter

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
    @upickle.implicits.key("clone")
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
    @upickle.implicits.key("_")
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
) derives OptionPickler.ReadWriter

case class Alignas (
    val alignas : Long
) derives OptionPickler.ReadWriter

case class Alignof (
    val alignof : Long
) derives OptionPickler.ReadWriter

case class And (
    val and : Long
) derives OptionPickler.ReadWriter

case class AndEq (
    val and_eq : Long
) derives OptionPickler.ReadWriter

case class AnyClass (
    val `Any` : Long
) derives OptionPickler.ReadWriter

case class ArrayClass (
    val array : Long
) derives OptionPickler.ReadWriter

case class ArrayNode (
    val ArrayNode : Long
) derives OptionPickler.ReadWriter

case class As (
    val as : Long
) derives OptionPickler.ReadWriter

case class ASM (
    val asm : Long
) derives OptionPickler.ReadWriter

case class Assert (
    val assert : Long
) derives OptionPickler.ReadWriter

case class Associatedtype (
    val associatedtype : Long
) derives OptionPickler.ReadWriter

case class Associativity (
    val associativity : Long
) derives OptionPickler.ReadWriter

case class Async (
    val async : Long
) derives OptionPickler.ReadWriter

case class Atomic (
    val atomic : Long
) derives OptionPickler.ReadWriter

case class AtomicCancel (
    val atomic_cancel : Long
) derives OptionPickler.ReadWriter

case class AtomicCommit (
    val atomic_commit : Long
) derives OptionPickler.ReadWriter

case class AtomicNoexcept (
    val atomic_noexcept : Long
) derives OptionPickler.ReadWriter

case class Auto (
    val auto : Long
) derives OptionPickler.ReadWriter

case class Await (
    val await : Long
) derives OptionPickler.ReadWriter

case class Base (
    val base : Long
) derives OptionPickler.ReadWriter

case class Bitand (
    val bitand : Long
) derives OptionPickler.ReadWriter

case class Bitor (
    val bitor : Long
) derives OptionPickler.ReadWriter

case class Bool (
    val BOOL : Long
) derives OptionPickler.ReadWriter

case class BooleanClass (
    val boolean : Long
) derives OptionPickler.ReadWriter

case class BooleanNode (
    val BooleanNode : Long
) derives OptionPickler.ReadWriter

case class Break (
    val break : Long
) derives OptionPickler.ReadWriter

case class Bycopy (
    val bycopy : Long
) derives OptionPickler.ReadWriter

case class Byref (
    val byref : Long
) derives OptionPickler.ReadWriter

case class ByteClass (
    val byte : Long
) derives OptionPickler.ReadWriter

case class Calendar (
    val Calendar : Long
) derives OptionPickler.ReadWriter

case class Chan (
    val chan : Long
) derives OptionPickler.ReadWriter

case class Char (
    val char : Long
) derives OptionPickler.ReadWriter

case class Char16T (
    val char16_t : Long
) derives OptionPickler.ReadWriter

case class Char32T (
    val char32_t : Long
) derives OptionPickler.ReadWriter

case class Checked (
    val checked : Long
) derives OptionPickler.ReadWriter

case class Clone (
    @upickle.implicits.key("clone")
    val cloneValue : Long
) derives OptionPickler.ReadWriter

case class CoAwait (
    val co_await : Long
) derives OptionPickler.ReadWriter

case class CoReturn (
    val co_return : Long
) derives OptionPickler.ReadWriter

case class CoYield (
    val co_yield : Long
) derives OptionPickler.ReadWriter

case class Codable (
    val Codable : Long
) derives OptionPickler.ReadWriter

case class CodingKey (
    val CodingKey : Long
) derives OptionPickler.ReadWriter

case class CodingKeys (
    val CodingKeys : Long
) derives OptionPickler.ReadWriter

case class Compl (
    val compl : Long
) derives OptionPickler.ReadWriter

case class Complex (
    val _Complex : Long
) derives OptionPickler.ReadWriter

case class Concept (
    val concept : Long
) derives OptionPickler.ReadWriter

case class Console (
    val console : Long
) derives OptionPickler.ReadWriter

case class Const (
    val const : Long
) derives OptionPickler.ReadWriter

case class ConstCast (
    val const_cast : Long
) derives OptionPickler.ReadWriter

case class Constexpr (
    val constexpr : Long
) derives OptionPickler.ReadWriter

case class Constructor (
    val constructor : Long
) derives OptionPickler.ReadWriter

case class Continue (
    val continue : Long
) derives OptionPickler.ReadWriter

case class Convenience (
    val convenience : Long
) derives OptionPickler.ReadWriter

case class Convert (
    val convert : Long
) derives OptionPickler.ReadWriter

case class Converter (
    val converter : Long
) derives OptionPickler.ReadWriter

case class Empty (
    @upickle.implicits.key("_")
    val empty : Long
) derives OptionPickler.ReadWriter

case class Imaginery (
    val _Imaginery : Long
) derives OptionPickler.ReadWriter

case class Abstract (
    val `abstract` : Long
) derives OptionPickler.ReadWriter

case class Obj1Any (
    val any : Long
) derives OptionPickler.ReadWriter

case class BoolClass (
    val _Bool : Long
) derives OptionPickler.ReadWriter

case class Case (
    val `case` : Long
) derives OptionPickler.ReadWriter

case class Catch (
    val `catch` : Long
) derives OptionPickler.ReadWriter

case class Class (
    val Class : Long
) derives OptionPickler.ReadWriter

case class Obj1Bool (
    val bool : Long
) derives OptionPickler.ReadWriter

case class ClassClass (
    val `class` : Long
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class CultureInfo (
    val CultureInfo : Long
) derives OptionPickler.ReadWriter

case class Date (
    val date : Long
) derives OptionPickler.ReadWriter

case class DateFormatter (
    val DateFormatter : Long
) derives OptionPickler.ReadWriter

case class DateOnly (
    val DateOnly : Long
) derives OptionPickler.ReadWriter

case class DateOnlyConverter (
    val DateOnlyConverter : Long
) derives OptionPickler.ReadWriter

case class DateParseHandling (
    val date_parse_handling : Long
) derives OptionPickler.ReadWriter

case class DateTime (
    val DateTime : java.time.Instant
) derives OptionPickler.ReadWriter

case class DateTimeStyles (
    val DateTimeStyles : Long
) derives OptionPickler.ReadWriter

case class Debugger (
    val debugger : Long
) derives OptionPickler.ReadWriter

case class Decimal (
    val decimal : Long
) derives OptionPickler.ReadWriter

case class Declare (
    val declare : Long
) derives OptionPickler.ReadWriter

case class Decltype (
    val decltype : Long
) derives OptionPickler.ReadWriter

case class DecodeString (
    val decode_string : Long
) derives OptionPickler.ReadWriter

case class DecoderClass (
    val Decoder : Long
) derives OptionPickler.ReadWriter

case class DecodingError (
    val DecodingError : Long
) derives OptionPickler.ReadWriter

case class Default (
    val default : Long
) derives OptionPickler.ReadWriter

case class Defer (
    val defer : Long
) derives OptionPickler.ReadWriter

case class Deinit (
    val deinit : Long
) derives OptionPickler.ReadWriter

case class Del (
    val del : Long
) derives OptionPickler.ReadWriter

case class Delegate (
    val delegate : Long
) derives OptionPickler.ReadWriter

case class Delete (
    val delete : Long
) derives OptionPickler.ReadWriter

case class DeserializationFeature (
    val DeserializationFeature : Long
) derives OptionPickler.ReadWriter

case class Dict (
    val dict : Long
) derives OptionPickler.ReadWriter

case class Dictionary (
    val dictionary : Long
) derives OptionPickler.ReadWriter

case class DidSet (
    val didSet : Long
) derives OptionPickler.ReadWriter

case class DoubleClass (
    val double : Long
) derives OptionPickler.ReadWriter

case class DoubleNode (
    val DoubleNode : Long
) derives OptionPickler.ReadWriter

case class Dynamic (
    val dynamic : Long
) derives OptionPickler.ReadWriter

case class DynamicCast (
    val dynamic_cast : Long
) derives OptionPickler.ReadWriter

case class Elif (
    val elif : Long
) derives OptionPickler.ReadWriter

case class EncodeQuickType (
    val encode_quick_type : Long
) derives OptionPickler.ReadWriter

case class EncoderClass (
    val Encoder : Long
) derives OptionPickler.ReadWriter

case class EnumValues (
    val EnumValues : Seq[EnumValue]
) derives OptionPickler.ReadWriter

enum EnumValue : 
    case Ready
    case Done

given OptionPickler.ReadWriter[EnumValue] = OptionPickler.readwriter[String].bimap[EnumValue](
    {
        case EnumValue.Ready => "ready"
        case EnumValue.Done => "done"
    },
    {
        case "ready" => EnumValue.Ready
        case "done" => EnumValue.Done
        case other => throw new upickle.core.Abort("invalid EnumValue: " + other)
    }
)

case class EqualityContract (
    val equalityContract : Long
) derives OptionPickler.ReadWriter

case class Equatable (
    val Equatable : Long
) derives OptionPickler.ReadWriter

case class Event (
    val event : Long
) derives OptionPickler.ReadWriter

case class Except (
    val except : Long
) derives OptionPickler.ReadWriter

case class ExceptionClass (
    val exception : Long
) derives OptionPickler.ReadWriter

case class Explicit (
    val explicit : Long
) derives OptionPickler.ReadWriter

case class Exposing (
    val exposing : Long
) derives OptionPickler.ReadWriter

case class Extension (
    val extension : Long
) derives OptionPickler.ReadWriter

case class Extern (
    val extern : Long
) derives OptionPickler.ReadWriter

case class Fallthrough (
    val fallthrough : Long
) derives OptionPickler.ReadWriter

case class Fileprivate (
    val fileprivate : Long
) derives OptionPickler.ReadWriter

case class Fixed (
    val fixed : Long
) derives OptionPickler.ReadWriter

case class FloatClass (
    val float : Long
) derives OptionPickler.ReadWriter

case class Foreach (
    val foreach : Long
) derives OptionPickler.ReadWriter

case class FormatException (
    val FormatException : Long
) derives OptionPickler.ReadWriter

case class Friend (
    val friend : Long
) derives OptionPickler.ReadWriter

case class From (
    val from : Long
) derives OptionPickler.ReadWriter

case class FromDict (
    val from_dict : Long
) derives OptionPickler.ReadWriter

case class FromJSON (
    val from_json : Long
) derives OptionPickler.ReadWriter

case class Func (
    val func : Long
) derives OptionPickler.ReadWriter

case class Def (
    val `def` : Long
) derives OptionPickler.ReadWriter

case class Do (
    val `do` : Long
) derives OptionPickler.ReadWriter

case class Else (
    val `else` : Long
) derives OptionPickler.ReadWriter

case class EnumClass (
    val `enum` : Long
) derives OptionPickler.ReadWriter

case class Export (
    val `export` : Long
) derives OptionPickler.ReadWriter

case class Extends (
    val `extends` : Long
) derives OptionPickler.ReadWriter

case class False (
    val False : Long
) derives OptionPickler.ReadWriter

case class Final (
    val `final` : Long
) derives OptionPickler.ReadWriter

case class Finally (
    val `finally` : Long
) derives OptionPickler.ReadWriter

case class For (
    val `for` : Long
) derives OptionPickler.ReadWriter

case class FalseClass (
    val `false` : Long
) derives OptionPickler.ReadWriter

case class Obj3 (
    val dummy : Long,
    val function : Function,
    val get : Get,
    val global : Global,
    val go : Go,
    val goto : Goto,
    val guard : Guard,
    val hasOwnProperty : HasOwnProperty,
    @upickle.implicits.key("hashCode")
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
) derives OptionPickler.ReadWriter

case class Function (
    val function : Long
) derives OptionPickler.ReadWriter

case class Get (
    val get : Long
) derives OptionPickler.ReadWriter

case class Global (
    val global : Long
) derives OptionPickler.ReadWriter

case class Go (
    val go : Long
) derives OptionPickler.ReadWriter

case class Goto (
    val goto : Long
) derives OptionPickler.ReadWriter

case class Guard (
    val guard : Long
) derives OptionPickler.ReadWriter

case class HasOwnProperty (
    val hasOwnProperty : Long
) derives OptionPickler.ReadWriter

case class HashCode (
    @upickle.implicits.key("hashCode")
    val hashCodeValue : Long
) derives OptionPickler.ReadWriter

case class Hashable (
    val Hashable : Long
) derives OptionPickler.ReadWriter

case class Hasher (
    val Hasher : Long
) derives OptionPickler.ReadWriter

case class ID (
    val id : Long
) derives OptionPickler.ReadWriter

case class Imp (
    val IMP : Long
) derives OptionPickler.ReadWriter

case class Implements (
    val implements : Long
) derives OptionPickler.ReadWriter

case class In (
    val in : Long
) derives OptionPickler.ReadWriter

case class Indirect (
    val indirect : Long
) derives OptionPickler.ReadWriter

case class Infix (
    val infix : Long
) derives OptionPickler.ReadWriter

case class Init (
    val init : Long
) derives OptionPickler.ReadWriter

case class Inline (
    val inline : Long
) derives OptionPickler.ReadWriter

case class Inout (
    val inout : Long
) derives OptionPickler.ReadWriter

case class Instanceof (
    val instanceof : Long
) derives OptionPickler.ReadWriter

case class IntClass (
    val int : Long
) derives OptionPickler.ReadWriter

case class IntNode (
    val IntNode : Long
) derives OptionPickler.ReadWriter

case class Interface (
    val interface : Long
) derives OptionPickler.ReadWriter

case class Internal (
    val internal : Long
) derives OptionPickler.ReadWriter

case class Is (
    val is : Long
) derives OptionPickler.ReadWriter

case class ISODateTimeOffsetConverter (
    val IsoDateTimeOffsetConverter : Long
) derives OptionPickler.ReadWriter

case class Iterable (
    val iterable : Long
) derives OptionPickler.ReadWriter

case class Jdec (
    val jdec : Long
) derives OptionPickler.ReadWriter

case class Jenc (
    val jenc : Long
) derives OptionPickler.ReadWriter

case class Jpipe (
    val jpipe : Long
) derives OptionPickler.ReadWriter

case class JSON (
    val json : Long
) derives OptionPickler.ReadWriter

case class JSONAny (
    val JSONAny : Option[ujson.Value]
) derives OptionPickler.ReadWriter

case class JSONCodingKey (
    val JSONCodingKey : Long
) derives OptionPickler.ReadWriter

case class JSONConverter (
    val json_converter : Long
) derives OptionPickler.ReadWriter

case class JSONDecoder (
    val JSONDecoder : Long
) derives OptionPickler.ReadWriter

case class JSONEncoder (
    val JSONEncoder : Long
) derives OptionPickler.ReadWriter

case class JSONException (
    val JsonException : Long
) derives OptionPickler.ReadWriter

case class JSONGenerator (
    val JsonGenerator : Long
) derives OptionPickler.ReadWriter

case class JSONNode (
    val JsonNode : Long
) derives OptionPickler.ReadWriter

case class JSONNull (
    val JSONNull : Long
) derives OptionPickler.ReadWriter

case class JSONParser (
    val JsonParser : Long
) derives OptionPickler.ReadWriter

case class JSONReader (
    val JsonReader : Long
) derives OptionPickler.ReadWriter

case class JSONSerializer (
    val json_serializer : Long
) derives OptionPickler.ReadWriter

case class JSONToken (
    val json_token : Long
) derives OptionPickler.ReadWriter

case class JSONTokenType (
    val JsonTokenType : Long
) derives OptionPickler.ReadWriter

case class JSONWriter (
    val json_writer : Long
) derives OptionPickler.ReadWriter

case class Lambda (
    val lambda : Long
) derives OptionPickler.ReadWriter

case class Left (
    val left : Long
) derives OptionPickler.ReadWriter

case class Let (
    val let : Long
) derives OptionPickler.ReadWriter

case class ListClass (
    val list : Long
) derives OptionPickler.ReadWriter

case class LocalDate (
    val LocalDate : Long
) derives OptionPickler.ReadWriter

case class Locale (
    val Locale : Long
) derives OptionPickler.ReadWriter

case class Lock (
    val lock : Long
) derives OptionPickler.ReadWriter

case class LongClass (
    val long : Long
) derives OptionPickler.ReadWriter

case class LongNode (
    val LongNode : Long
) derives OptionPickler.ReadWriter

case class MapClass (
    val map : Long
) derives OptionPickler.ReadWriter

case class MapEntry (
    val MapEntry : Long
) derives OptionPickler.ReadWriter

case class MarshalJSON (
    val MarshalJSON : Long
) derives OptionPickler.ReadWriter

case class MetadataPropertyHandling (
    val metadata_property_handling : Long
) derives OptionPickler.ReadWriter

case class Module (
    val module : Long
) derives OptionPickler.ReadWriter

case class If (
    val `if` : Long
) derives OptionPickler.ReadWriter

case class Implicit (
    val `implicit` : Long
) derives OptionPickler.ReadWriter

case class Import (
    val `import` : Long
) derives OptionPickler.ReadWriter

case class Lazy (
    val `lazy` : Long
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class Mutable (
    val mutable : Long
) derives OptionPickler.ReadWriter

case class Mutating (
    val mutating : Long
) derives OptionPickler.ReadWriter

case class Namespace (
    val namespace : Long
) derives OptionPickler.ReadWriter

case class Native (
    val native : Long
) derives OptionPickler.ReadWriter

case class Newtonsoft (
    val newtonsoft : Long
) derives OptionPickler.ReadWriter

case class Nil (
    val nil : Long
) derives OptionPickler.ReadWriter

case class No (
    val NO : Long
) derives OptionPickler.ReadWriter

case class NoSuchMethod (
    val noSuchMethod : Long
) derives OptionPickler.ReadWriter

case class Noexcept (
    val noexcept : Long
) derives OptionPickler.ReadWriter

case class Nonatomic (
    val nonatomic : Long
) derives OptionPickler.ReadWriter

case class NoneClass (
    val None : Long
) derives OptionPickler.ReadWriter

case class Nonlocal (
    val nonlocal : Long
) derives OptionPickler.ReadWriter

case class Nonmutating (
    val nonmutating : Long
) derives OptionPickler.ReadWriter

case class Not (
    val not : Long
) derives OptionPickler.ReadWriter

case class NotEq (
    val not_eq : Long
) derives OptionPickler.ReadWriter

case class NSError (
    val NSError : Long
) derives OptionPickler.ReadWriter

case class NSObject (
    val NSObject : Long
) derives OptionPickler.ReadWriter

case class NSString (
    val NSString : Long
) derives OptionPickler.ReadWriter

case class NullNode (
    val NullNode : Long
) derives OptionPickler.ReadWriter

case class Nullptr (
    val nullptr : Long
) derives OptionPickler.ReadWriter

case class Number (
    val number : Long
) derives OptionPickler.ReadWriter

case class NULLClass (
    val NULL : Long
) derives OptionPickler.ReadWriter

case class New (
    val `new` : Long
) derives OptionPickler.ReadWriter

case class Obj4None (
    val none : Long
) derives OptionPickler.ReadWriter

case class NullClass (
    val `null` : Long
) derives OptionPickler.ReadWriter

case class Object (
    val `object` : Long
) derives OptionPickler.ReadWriter

case class Override (
    val `override` : Long
) derives OptionPickler.ReadWriter

case class Package (
    val `package` : Long
) derives OptionPickler.ReadWriter

case class Private (
    val `private` : Long
) derives OptionPickler.ReadWriter

case class Protected (
    val `protected` : Long
) derives OptionPickler.ReadWriter

case class ProtocolClass (
    val protocol : Long
) derives OptionPickler.ReadWriter

case class ObjectMapper (
    val ObjectMapper : Long
) derives OptionPickler.ReadWriter

case class ObjectNode (
    val ObjectNode : Long
) derives OptionPickler.ReadWriter

case class ObjectReader (
    val ObjectReader : Long
) derives OptionPickler.ReadWriter

case class ObjectWriter (
    val ObjectWriter : Long
) derives OptionPickler.ReadWriter

case class Of (
    val of : Long
) derives OptionPickler.ReadWriter

case class OffsetDateTime (
    val OffsetDateTime : Long
) derives OptionPickler.ReadWriter

case class OffsetTime (
    val OffsetTime : Long
) derives OptionPickler.ReadWriter

case class Oneway (
    val oneway : Long
) derives OptionPickler.ReadWriter

case class Open (
    val open : Long
) derives OptionPickler.ReadWriter

case class Operator (
    val operator : Long
) derives OptionPickler.ReadWriter

case class Optional (
    val optional : Long
) derives OptionPickler.ReadWriter

case class Or (
    val or : Long
) derives OptionPickler.ReadWriter

case class OrEq (
    val or_eq : Long
) derives OptionPickler.ReadWriter

case class Out (
    val out : Long
) derives OptionPickler.ReadWriter

case class Params (
    val params : Long
) derives OptionPickler.ReadWriter

case class Pass (
    val pass : Long
) derives OptionPickler.ReadWriter

case class Port (
    val port : Long
) derives OptionPickler.ReadWriter

case class Postfix (
    val postfix : Long
) derives OptionPickler.ReadWriter

case class Precedence (
    val precedence : Long
) derives OptionPickler.ReadWriter

case class Prefix (
    val prefix : Long
) derives OptionPickler.ReadWriter

case class Print (
    val print : Long
) derives OptionPickler.ReadWriter

case class PrintMembers (
    val printMembers : Long
) derives OptionPickler.ReadWriter

case class Printf (
    val printf : Long
) derives OptionPickler.ReadWriter

case class Protocol (
    val Protocol : Long
) derives OptionPickler.ReadWriter

case class Public (
    val public : Long
) derives OptionPickler.ReadWriter

case class Quicktype (
    val quicktype : Long
) derives OptionPickler.ReadWriter

case class Raise (
    val raise : Long
) derives OptionPickler.ReadWriter

case class Range (
    val range : Long
) derives OptionPickler.ReadWriter

case class Readonly (
    val readonly : Long
) derives OptionPickler.ReadWriter

case class Ref (
    val ref : Long
) derives OptionPickler.ReadWriter

case class RegExp (
    val RegExp : java.util.UUID
) derives OptionPickler.ReadWriter

case class Register (
    val register : Long
) derives OptionPickler.ReadWriter

case class ReinterpretCast (
    val reinterpret_cast : Long
) derives OptionPickler.ReadWriter

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
    @upickle.implicits.key("synchronized")
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
    @upickle.implicits.key("toString")
    val toStringValue : ToString,
    val top_level : TopLevelClass,
    val transient : Transient
) derives OptionPickler.ReadWriter

case class KSerializer (
    val KSerializer : Long
) derives OptionPickler.ReadWriter

case class Return (
    val `return` : Long
) derives OptionPickler.ReadWriter

case class Sealed (
    val `sealed` : Long
) derives OptionPickler.ReadWriter

case class SelfClass (
    val self : Long
) derives OptionPickler.ReadWriter

case class Super (
    val `super` : Long
) derives OptionPickler.ReadWriter

case class Then (
    val `then` : Long
) derives OptionPickler.ReadWriter

case class This (
    val `this` : Long
) derives OptionPickler.ReadWriter

case class Throw (
    val `throw` : Long
) derives OptionPickler.ReadWriter

case class True (
    val True : Long
) derives OptionPickler.ReadWriter

case class PrimitiveKind (
    val PrimitiveKind : Long
) derives OptionPickler.ReadWriter

case class TrueClass (
    val `true` : Long
) derives OptionPickler.ReadWriter

case class Repeat (
    val repeat : Long
) derives OptionPickler.ReadWriter

case class Require (
    val require : Long
) derives OptionPickler.ReadWriter

case class Required (
    val required : Long
) derives OptionPickler.ReadWriter

case class Requires (
    val requires : Long
) derives OptionPickler.ReadWriter

case class Restrict (
    val restrict : Long
) derives OptionPickler.ReadWriter

case class Retain (
    val retain : Long
) derives OptionPickler.ReadWriter

case class Rethrows (
    val rethrows : Long
) derives OptionPickler.ReadWriter

case class Right (
    val right : Long
) derives OptionPickler.ReadWriter

case class RuntimeType (
    val runtimeType : Long
) derives OptionPickler.ReadWriter

case class S (
    val s : Long
) derives OptionPickler.ReadWriter

case class Sbyte (
    val sbyte : Long
) derives OptionPickler.ReadWriter

case class Sel (
    val SEL : Long
) derives OptionPickler.ReadWriter

case class Select (
    val select : Long
) derives OptionPickler.ReadWriter

case class Self (
    val Self : Long
) derives OptionPickler.ReadWriter

case class Sendable (
    val Sendable : Long
) derives OptionPickler.ReadWriter

case class SerialDescriptor (
    val SerialDescriptor : Long
) derives OptionPickler.ReadWriter

case class SerialName (
    val SerialName : Long
) derives OptionPickler.ReadWriter

case class Serializable (
    val Serializable : Long
) derives OptionPickler.ReadWriter

case class SerializationFeature (
    val SerializationFeature : Long
) derives OptionPickler.ReadWriter

case class Serialize (
    val serialize : Long
) derives OptionPickler.ReadWriter

case class SerializerProvider (
    val SerializerProvider : Long
) derives OptionPickler.ReadWriter

case class Set (
    val set : Long
) derives OptionPickler.ReadWriter

case class ShortClass (
    val short : Long
) derives OptionPickler.ReadWriter

case class Signed (
    val signed : Long
) derives OptionPickler.ReadWriter

case class SimpleModule (
    val SimpleModule : Long
) derives OptionPickler.ReadWriter

case class Sizeof (
    val sizeof : Long
) derives OptionPickler.ReadWriter

case class Stackalloc (
    val stackalloc : Long
) derives OptionPickler.ReadWriter

case class Standards (
    val Standards : Long
) derives OptionPickler.ReadWriter

case class Static (
    val static : Long
) derives OptionPickler.ReadWriter

case class StaticAssert (
    val static_assert : Long
) derives OptionPickler.ReadWriter

case class StaticCast (
    val static_cast : Long
) derives OptionPickler.ReadWriter

case class StdDeserializer (
    val StdDeserializer : Long
) derives OptionPickler.ReadWriter

case class StdSerializer (
    val StdSerializer : Long
) derives OptionPickler.ReadWriter

case class Strictfp (
    val strictfp : Long
) derives OptionPickler.ReadWriter

case class StringClass (
    val string : Long
) derives OptionPickler.ReadWriter

case class Struct (
    val struct : Long
) derives OptionPickler.ReadWriter

case class Subscript (
    val subscript : Long
) derives OptionPickler.ReadWriter

case class Switch (
    val switch : Long
) derives OptionPickler.ReadWriter

case class Symbol (
    val symbol : Long
) derives OptionPickler.ReadWriter

case class Synchronized (
    @upickle.implicits.key("synchronized")
    val synchronizedValue : Long
) derives OptionPickler.ReadWriter

case class SystemClass (
    val system : Long
) derives OptionPickler.ReadWriter

case class Template (
    val template : Long
) derives OptionPickler.ReadWriter

case class TextNode (
    val TextNode : Long
) derives OptionPickler.ReadWriter

case class ThreadLocal (
    val thread_local : Long
) derives OptionPickler.ReadWriter

case class Throws (
    val throws : Long
) derives OptionPickler.ReadWriter

case class TimeOnly (
    val TimeOnly : Long
) derives OptionPickler.ReadWriter

case class TimeOnlyConverter (
    val TimeOnlyConverter : Long
) derives OptionPickler.ReadWriter

case class TimeZone (
    val TimeZone : Long
) derives OptionPickler.ReadWriter

case class ToDict (
    val to_dict : Long
) derives OptionPickler.ReadWriter

case class ToJSON (
    val to_json : Long
) derives OptionPickler.ReadWriter

case class ToString (
    @upickle.implicits.key("toString")
    val toStringValue : Long
) derives OptionPickler.ReadWriter

case class TopLevelClass (
    val top_level : Long
) derives OptionPickler.ReadWriter

case class Transient (
    val transient : Long
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class Try (
    val `try` : Long
) derives OptionPickler.ReadWriter

case class Type (
    val Type : Long
) derives OptionPickler.ReadWriter

case class Var (
    val `var` : Long
) derives OptionPickler.ReadWriter

case class While (
    val `while` : Long
) derives OptionPickler.ReadWriter

case class With (
    val `with` : Long
) derives OptionPickler.ReadWriter

case class Yield (
    val `yield` : Long
) derives OptionPickler.ReadWriter

case class TypeClass (
    val `type` : Long
) derives OptionPickler.ReadWriter

case class Typealias (
    val typealias : Long
) derives OptionPickler.ReadWriter

case class Typedef (
    val typedef : Long
) derives OptionPickler.ReadWriter

case class Typeid (
    val typeid : Long
) derives OptionPickler.ReadWriter

case class Typename (
    val typename : Long
) derives OptionPickler.ReadWriter

case class Typeof (
    val typeof : Long
) derives OptionPickler.ReadWriter

case class Uint (
    val uint : Long
) derives OptionPickler.ReadWriter

case class Ulong (
    val ulong : Long
) derives OptionPickler.ReadWriter

case class Unchecked (
    val unchecked : Long
) derives OptionPickler.ReadWriter

case class Undefined (
    val undefined : Long
) derives OptionPickler.ReadWriter

case class Union (
    val union : Long
) derives OptionPickler.ReadWriter

case class UnmarshalJSON (
    val UnmarshalJSON : Long
) derives OptionPickler.ReadWriter

case class Unowned (
    val unowned : Long
) derives OptionPickler.ReadWriter

case class Unsafe (
    val unsafe : Long
) derives OptionPickler.ReadWriter

case class Unsigned (
    val unsigned : Long
) derives OptionPickler.ReadWriter

case class UseSerializers (
    val UseSerializers : Long
) derives OptionPickler.ReadWriter

case class Ushort (
    val ushort : Long
) derives OptionPickler.ReadWriter

case class Using (
    val using : Long
) derives OptionPickler.ReadWriter

case class Utf8JSONReader (
    val Utf8JsonReader : Long
) derives OptionPickler.ReadWriter

case class Utf8JSONWriter (
    val Utf8JsonWriter : Long
) derives OptionPickler.ReadWriter

case class UUID (
    val UUID : Long
) derives OptionPickler.ReadWriter

case class Virtual (
    val virtual : Long
) derives OptionPickler.ReadWriter

case class Void (
    val void : Long
) derives OptionPickler.ReadWriter

case class Volatile (
    val volatile : Long
) derives OptionPickler.ReadWriter

case class WcharT (
    val wchar_t : Long
) derives OptionPickler.ReadWriter

case class Weak (
    val weak : Long
) derives OptionPickler.ReadWriter

case class Where (
    val where : Long
) derives OptionPickler.ReadWriter

case class WillSet (
    val willSet : Long
) derives OptionPickler.ReadWriter

case class Xor (
    val xor : Long
) derives OptionPickler.ReadWriter

case class XorEq (
    val xor_eq : Long
) derives OptionPickler.ReadWriter

case class Yes (
    val YES : Long
) derives OptionPickler.ReadWriter
