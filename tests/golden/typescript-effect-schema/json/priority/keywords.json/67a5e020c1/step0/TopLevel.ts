import * as S from "effect/Schema";


export const EnumValue = S.Literal(
    "ready",
    "done",
);
export type EnumValue = S.Schema.Type<typeof EnumValue>;

export class Yield extends S.Class<Yield>("Yield")({
    "yield": S.Int,
}) {}

export class Yes extends S.Class<Yes>("Yes")({
    "YES": S.Int,
}) {}

export class XorEq extends S.Class<XorEq>("XorEq")({
    "xor_eq": S.Int,
}) {}

export class Xor extends S.Class<Xor>("Xor")({
    "xor": S.Int,
}) {}

export class With extends S.Class<With>("With")({
    "with": S.Int,
}) {}

export class WillSet extends S.Class<WillSet>("WillSet")({
    "willSet": S.Int,
}) {}

export class While extends S.Class<While>("While")({
    "while": S.Int,
}) {}

export class Where extends S.Class<Where>("Where")({
    "where": S.Int,
}) {}

export class Weak extends S.Class<Weak>("Weak")({
    "weak": S.Int,
}) {}

export class WcharT extends S.Class<WcharT>("WcharT")({
    "wchar_t": S.Int,
}) {}

export class Volatile extends S.Class<Volatile>("Volatile")({
    "volatile": S.Int,
}) {}

export class Void extends S.Class<Void>("Void")({
    "void": S.Int,
}) {}

export class Virtual extends S.Class<Virtual>("Virtual")({
    "virtual": S.Int,
}) {}

export class Var extends S.Class<Var>("Var")({
    "var": S.Int,
}) {}

export class Uuid extends S.Class<Uuid>("Uuid")({
    "UUID": S.Int,
}) {}

export class Utf8JsonWriter extends S.Class<Utf8JsonWriter>("Utf8JsonWriter")({
    "Utf8JsonWriter": S.Int,
}) {}

export class Utf8JsonReader extends S.Class<Utf8JsonReader>("Utf8JsonReader")({
    "Utf8JsonReader": S.Int,
}) {}

export class Using extends S.Class<Using>("Using")({
    "using": S.Int,
}) {}

export class Ushort extends S.Class<Ushort>("Ushort")({
    "ushort": S.Int,
}) {}

export class UseSerializers extends S.Class<UseSerializers>("UseSerializers")({
    "UseSerializers": S.Int,
}) {}

export class Unsigned extends S.Class<Unsigned>("Unsigned")({
    "unsigned": S.Int,
}) {}

export class Unsafe extends S.Class<Unsafe>("Unsafe")({
    "unsafe": S.Int,
}) {}

export class Unowned extends S.Class<Unowned>("Unowned")({
    "unowned": S.Int,
}) {}

export class UnmarshalJson extends S.Class<UnmarshalJson>("UnmarshalJson")({
    "UnmarshalJSON": S.Int,
}) {}

export class Union extends S.Class<Union>("Union")({
    "union": S.Int,
}) {}

export class Undefined extends S.Class<Undefined>("Undefined")({
    "undefined": S.Int,
}) {}

export class Unchecked extends S.Class<Unchecked>("Unchecked")({
    "unchecked": S.Int,
}) {}

export class Ulong extends S.Class<Ulong>("Ulong")({
    "ulong": S.Int,
}) {}

export class Uint extends S.Class<Uint>("Uint")({
    "uint": S.Int,
}) {}

export class Typeof extends S.Class<Typeof>("Typeof")({
    "typeof": S.Int,
}) {}

export class Typename extends S.Class<Typename>("Typename")({
    "typename": S.Int,
}) {}

export class Typeid extends S.Class<Typeid>("Typeid")({
    "typeid": S.Int,
}) {}

export class Typedef extends S.Class<Typedef>("Typedef")({
    "typedef": S.Int,
}) {}

export class Typealias extends S.Class<Typealias>("Typealias")({
    "typealias": S.Int,
}) {}

export class Type extends S.Class<Type>("Type")({
    "Type": S.Int,
}) {}

export class Try extends S.Class<Try>("Try")({
    "try": S.Int,
}) {}

export class TypeClass extends S.Class<TypeClass>("TypeClass")({
    "type": S.Int,
}) {}

export class Obj6 extends S.Class<Obj6>("Obj6")({
    "dummy": S.Int,
    "type": TypeClass,
    "try": Try,
    "Type": Type,
    "typealias": Typealias,
    "typedef": Typedef,
    "typeid": Typeid,
    "typename": Typename,
    "typeof": Typeof,
    "uint": Uint,
    "ulong": Ulong,
    "unchecked": Unchecked,
    "undefined": Undefined,
    "union": Union,
    "UnmarshalJSON": UnmarshalJson,
    "unowned": Unowned,
    "unsafe": Unsafe,
    "unsigned": Unsigned,
    "UseSerializers": UseSerializers,
    "ushort": Ushort,
    "using": Using,
    "Utf8JsonReader": Utf8JsonReader,
    "Utf8JsonWriter": Utf8JsonWriter,
    "UUID": Uuid,
    "var": Var,
    "virtual": Virtual,
    "void": Void,
    "volatile": Volatile,
    "wchar_t": WcharT,
    "weak": Weak,
    "where": Where,
    "while": While,
    "willSet": WillSet,
    "with": With,
    "xor": Xor,
    "xor_eq": XorEq,
    "YES": Yes,
    "yield": Yield,
}) {}

export class True extends S.Class<True>("True")({
    "True": S.Int,
}) {}

export class Transient extends S.Class<Transient>("Transient")({
    "transient": S.Int,
}) {}

export class TopLevelClass extends S.Class<TopLevelClass>("TopLevelClass")({
    "top_level": S.Int,
}) {}

export class ToString extends S.Class<ToString>("ToString")({
    "toString": S.Int,
}) {}
Object.defineProperty(ToString.prototype, "toString", { writable: true });

export class ToJson extends S.Class<ToJson>("ToJson")({
    "to_json": S.Int,
}) {}

export class ToDict extends S.Class<ToDict>("ToDict")({
    "to_dict": S.Int,
}) {}

export class TimeZone extends S.Class<TimeZone>("TimeZone")({
    "TimeZone": S.Int,
}) {}

export class TimeOnlyConverter extends S.Class<TimeOnlyConverter>("TimeOnlyConverter")({
    "TimeOnlyConverter": S.Int,
}) {}

export class TimeOnly extends S.Class<TimeOnly>("TimeOnly")({
    "TimeOnly": S.Int,
}) {}

export class Throws extends S.Class<Throws>("Throws")({
    "throws": S.Int,
}) {}

export class Throw extends S.Class<Throw>("Throw")({
    "throw": S.Int,
}) {}

export class ThreadLocal extends S.Class<ThreadLocal>("ThreadLocal")({
    "thread_local": S.Int,
}) {}

export class This extends S.Class<This>("This")({
    "this": S.Int,
}) {}

export class Then extends S.Class<Then>("Then")({
    "then": S.Int,
}) {}

export class TextNode extends S.Class<TextNode>("TextNode")({
    "TextNode": S.Int,
}) {}

export class Template extends S.Class<Template>("Template")({
    "template": S.Int,
}) {}

export class System extends S.Class<System>("System")({
    "system": S.Int,
}) {}

export class Synchronized extends S.Class<Synchronized>("Synchronized")({
    "synchronized": S.Int,
}) {}

export class Symbol extends S.Class<Symbol>("Symbol")({
    "symbol": S.Int,
}) {}

export class Switch extends S.Class<Switch>("Switch")({
    "switch": S.Int,
}) {}

export class Super extends S.Class<Super>("Super")({
    "super": S.Int,
}) {}

export class Subscript extends S.Class<Subscript>("Subscript")({
    "subscript": S.Int,
}) {}

export class Struct extends S.Class<Struct>("Struct")({
    "struct": S.Int,
}) {}

export class StringClass extends S.Class<StringClass>("StringClass")({
    "string": S.Int,
}) {}

export class Strictfp extends S.Class<Strictfp>("Strictfp")({
    "strictfp": S.Int,
}) {}

export class StdSerializer extends S.Class<StdSerializer>("StdSerializer")({
    "StdSerializer": S.Int,
}) {}

export class StdDeserializer extends S.Class<StdDeserializer>("StdDeserializer")({
    "StdDeserializer": S.Int,
}) {}

export class StaticCast extends S.Class<StaticCast>("StaticCast")({
    "static_cast": S.Int,
}) {}

export class StaticAssert extends S.Class<StaticAssert>("StaticAssert")({
    "static_assert": S.Int,
}) {}

export class Static extends S.Class<Static>("Static")({
    "static": S.Int,
}) {}

export class Standards extends S.Class<Standards>("Standards")({
    "Standards": S.Int,
}) {}

export class Stackalloc extends S.Class<Stackalloc>("Stackalloc")({
    "stackalloc": S.Int,
}) {}

export class Sizeof extends S.Class<Sizeof>("Sizeof")({
    "sizeof": S.Int,
}) {}

export class SimpleModule extends S.Class<SimpleModule>("SimpleModule")({
    "SimpleModule": S.Int,
}) {}

export class Signed extends S.Class<Signed>("Signed")({
    "signed": S.Int,
}) {}

export class Short extends S.Class<Short>("Short")({
    "short": S.Int,
}) {}

export class Set extends S.Class<Set>("Set")({
    "set": S.Int,
}) {}

export class SerializerProvider extends S.Class<SerializerProvider>("SerializerProvider")({
    "SerializerProvider": S.Int,
}) {}

export class Serialize extends S.Class<Serialize>("Serialize")({
    "serialize": S.Int,
}) {}

export class SerializationFeature extends S.Class<SerializationFeature>("SerializationFeature")({
    "SerializationFeature": S.Int,
}) {}

export class Serializable extends S.Class<Serializable>("Serializable")({
    "Serializable": S.Int,
}) {}

export class SerialName extends S.Class<SerialName>("SerialName")({
    "SerialName": S.Int,
}) {}

export class SerialDescriptor extends S.Class<SerialDescriptor>("SerialDescriptor")({
    "SerialDescriptor": S.Int,
}) {}

export class Sendable extends S.Class<Sendable>("Sendable")({
    "Sendable": S.Int,
}) {}

export class Self extends S.Class<Self>("Self")({
    "Self": S.Int,
}) {}

export class Select extends S.Class<Select>("Select")({
    "select": S.Int,
}) {}

export class Sel extends S.Class<Sel>("Sel")({
    "SEL": S.Int,
}) {}

export class Sealed extends S.Class<Sealed>("Sealed")({
    "sealed": S.Int,
}) {}

export class Sbyte extends S.Class<Sbyte>("Sbyte")({
    "sbyte": S.Int,
}) {}

export class SClass extends S.Class<SClass>("SClass")({
    "s": S.Int,
}) {}

export class RuntimeType extends S.Class<RuntimeType>("RuntimeType")({
    "runtimeType": S.Int,
}) {}

export class Right extends S.Class<Right>("Right")({
    "right": S.Int,
}) {}

export class Return extends S.Class<Return>("Return")({
    "return": S.Int,
}) {}

export class Rethrows extends S.Class<Rethrows>("Rethrows")({
    "rethrows": S.Int,
}) {}

export class Retain extends S.Class<Retain>("Retain")({
    "retain": S.Int,
}) {}

export class Restrict extends S.Class<Restrict>("Restrict")({
    "restrict": S.Int,
}) {}

export class Requires extends S.Class<Requires>("Requires")({
    "requires": S.Int,
}) {}

export class Required extends S.Class<Required>("Required")({
    "required": S.Int,
}) {}

export class Require extends S.Class<Require>("Require")({
    "require": S.Int,
}) {}

export class Repeat extends S.Class<Repeat>("Repeat")({
    "repeat": S.Int,
}) {}

export class PrimitiveKind extends S.Class<PrimitiveKind>("PrimitiveKind")({
    "PrimitiveKind": S.Int,
}) {}

export class TrueClass extends S.Class<TrueClass>("TrueClass")({
    "true": S.Int,
}) {}

export class SelfClass extends S.Class<SelfClass>("SelfClass")({
    "self": S.Int,
}) {}

export class KSerializer extends S.Class<KSerializer>("KSerializer")({
    "KSerializer": S.Int,
}) {}

export class Obj5 extends S.Class<Obj5>("Obj5")({
    "dummy": S.Int,
    "KSerializer": KSerializer,
    "self": SelfClass,
    "true": TrueClass,
    "PrimitiveKind": PrimitiveKind,
    "repeat": Repeat,
    "require": Require,
    "required": Required,
    "requires": Requires,
    "restrict": Restrict,
    "retain": Retain,
    "rethrows": Rethrows,
    "return": Return,
    "right": Right,
    "runtimeType": RuntimeType,
    "s": SClass,
    "sbyte": Sbyte,
    "sealed": Sealed,
    "SEL": Sel,
    "select": Select,
    "Self": Self,
    "Sendable": Sendable,
    "SerialDescriptor": SerialDescriptor,
    "SerialName": SerialName,
    "Serializable": Serializable,
    "SerializationFeature": SerializationFeature,
    "serialize": Serialize,
    "SerializerProvider": SerializerProvider,
    "set": Set,
    "short": Short,
    "signed": Signed,
    "SimpleModule": SimpleModule,
    "sizeof": Sizeof,
    "stackalloc": Stackalloc,
    "Standards": Standards,
    "static": Static,
    "static_assert": StaticAssert,
    "static_cast": StaticCast,
    "StdDeserializer": StdDeserializer,
    "StdSerializer": StdSerializer,
    "strictfp": Strictfp,
    "string": StringClass,
    "struct": Struct,
    "subscript": Subscript,
    "super": Super,
    "switch": Switch,
    "symbol": Symbol,
    "synchronized": Synchronized,
    "system": System,
    "template": Template,
    "TextNode": TextNode,
    "then": Then,
    "this": This,
    "thread_local": ThreadLocal,
    "throw": Throw,
    "throws": Throws,
    "TimeOnly": TimeOnly,
    "TimeOnlyConverter": TimeOnlyConverter,
    "TimeZone": TimeZone,
    "to_dict": ToDict,
    "to_json": ToJson,
    "toString": ToString,
    "top_level": TopLevelClass,
    "transient": Transient,
    "True": True,
}) {}
Object.defineProperty(Obj5.prototype, "toString", { writable: true });

export class ReinterpretCast extends S.Class<ReinterpretCast>("ReinterpretCast")({
    "reinterpret_cast": S.Int,
}) {}

export class Register extends S.Class<Register>("Register")({
    "register": S.Int,
}) {}

export class RegExpClass extends S.Class<RegExpClass>("RegExpClass")({
    "RegExp": S.UUID,
}) {}

export class Ref extends S.Class<Ref>("Ref")({
    "ref": S.Int,
}) {}

export class Readonly extends S.Class<Readonly>("Readonly")({
    "readonly": S.Int,
}) {}

export class Range extends S.Class<Range>("Range")({
    "range": S.Int,
}) {}

export class Raise extends S.Class<Raise>("Raise")({
    "raise": S.Int,
}) {}

export class Quicktype extends S.Class<Quicktype>("Quicktype")({
    "quicktype": S.Int,
}) {}

export class Public extends S.Class<Public>("Public")({
    "public": S.Int,
}) {}

export class Protocol extends S.Class<Protocol>("Protocol")({
    "Protocol": S.Int,
}) {}

export class Protected extends S.Class<Protected>("Protected")({
    "protected": S.Int,
}) {}

export class Private extends S.Class<Private>("Private")({
    "private": S.Int,
}) {}

export class Printf extends S.Class<Printf>("Printf")({
    "printf": S.Int,
}) {}

export class PrintMembers extends S.Class<PrintMembers>("PrintMembers")({
    "printMembers": S.Int,
}) {}

export class Print extends S.Class<Print>("Print")({
    "print": S.Int,
}) {}

export class Prefix extends S.Class<Prefix>("Prefix")({
    "prefix": S.Int,
}) {}

export class Precedence extends S.Class<Precedence>("Precedence")({
    "precedence": S.Int,
}) {}

export class Postfix extends S.Class<Postfix>("Postfix")({
    "postfix": S.Int,
}) {}

export class Port extends S.Class<Port>("Port")({
    "port": S.Int,
}) {}

export class Pass extends S.Class<Pass>("Pass")({
    "pass": S.Int,
}) {}

export class Params extends S.Class<Params>("Params")({
    "params": S.Int,
}) {}

export class Package extends S.Class<Package>("Package")({
    "package": S.Int,
}) {}

export class Override extends S.Class<Override>("Override")({
    "override": S.Int,
}) {}

export class Out extends S.Class<Out>("Out")({
    "out": S.Int,
}) {}

export class OrEq extends S.Class<OrEq>("OrEq")({
    "or_eq": S.Int,
}) {}

export class Or extends S.Class<Or>("Or")({
    "or": S.Int,
}) {}

export class Optional extends S.Class<Optional>("Optional")({
    "optional": S.Int,
}) {}

export class Operator extends S.Class<Operator>("Operator")({
    "operator": S.Int,
}) {}

export class Open extends S.Class<Open>("Open")({
    "open": S.Int,
}) {}

export class Oneway extends S.Class<Oneway>("Oneway")({
    "oneway": S.Int,
}) {}

export class OffsetTime extends S.Class<OffsetTime>("OffsetTime")({
    "OffsetTime": S.Int,
}) {}

export class OffsetDateTime extends S.Class<OffsetDateTime>("OffsetDateTime")({
    "OffsetDateTime": S.Int,
}) {}

export class Of extends S.Class<Of>("Of")({
    "of": S.Int,
}) {}

export class ObjectWriter extends S.Class<ObjectWriter>("ObjectWriter")({
    "ObjectWriter": S.Int,
}) {}

export class ObjectReader extends S.Class<ObjectReader>("ObjectReader")({
    "ObjectReader": S.Int,
}) {}

export class ObjectNode extends S.Class<ObjectNode>("ObjectNode")({
    "ObjectNode": S.Int,
}) {}

export class ObjectMapper extends S.Class<ObjectMapper>("ObjectMapper")({
    "ObjectMapper": S.Int,
}) {}

export class ObjectClass extends S.Class<ObjectClass>("ObjectClass")({
    "object": S.Int,
}) {}

export class ProtocolClass extends S.Class<ProtocolClass>("ProtocolClass")({
    "protocol": S.Int,
}) {}

export class NullClass extends S.Class<NullClass>("NullClass")({
    "null": S.Int,
}) {}

export class NoneClass extends S.Class<NoneClass>("NoneClass")({
    "none": S.Int,
}) {}

export class Number extends S.Class<Number>("Number")({
    "number": S.Int,
}) {}

export class Nullptr extends S.Class<Nullptr>("Nullptr")({
    "nullptr": S.Int,
}) {}

export class NullNode extends S.Class<NullNode>("NullNode")({
    "NullNode": S.Int,
}) {}

export class Null extends S.Class<Null>("Null")({
    "NULL": S.Int,
}) {}

export class NsString extends S.Class<NsString>("NsString")({
    "NSString": S.Int,
}) {}

export class NsObject extends S.Class<NsObject>("NsObject")({
    "NSObject": S.Int,
}) {}

export class NsError extends S.Class<NsError>("NsError")({
    "NSError": S.Int,
}) {}

export class NotEq extends S.Class<NotEq>("NotEq")({
    "not_eq": S.Int,
}) {}

export class Not extends S.Class<Not>("Not")({
    "not": S.Int,
}) {}

export class Nonmutating extends S.Class<Nonmutating>("Nonmutating")({
    "nonmutating": S.Int,
}) {}

export class Nonlocal extends S.Class<Nonlocal>("Nonlocal")({
    "nonlocal": S.Int,
}) {}

export class None extends S.Class<None>("None")({
    "None": S.Int,
}) {}

export class Nonatomic extends S.Class<Nonatomic>("Nonatomic")({
    "nonatomic": S.Int,
}) {}

export class Noexcept extends S.Class<Noexcept>("Noexcept")({
    "noexcept": S.Int,
}) {}

export class NoSuchMethod extends S.Class<NoSuchMethod>("NoSuchMethod")({
    "noSuchMethod": S.Int,
}) {}

export class No extends S.Class<No>("No")({
    "NO": S.Int,
}) {}

export class Nil extends S.Class<Nil>("Nil")({
    "nil": S.Int,
}) {}

export class Newtonsoft extends S.Class<Newtonsoft>("Newtonsoft")({
    "newtonsoft": S.Int,
}) {}

export class New extends S.Class<New>("New")({
    "new": S.Int,
}) {}

export class Native extends S.Class<Native>("Native")({
    "native": S.Int,
}) {}

export class Namespace extends S.Class<Namespace>("Namespace")({
    "namespace": S.Int,
}) {}

export class Mutating extends S.Class<Mutating>("Mutating")({
    "mutating": S.Int,
}) {}

export class Mutable extends S.Class<Mutable>("Mutable")({
    "mutable": S.Int,
}) {}

export class Obj4 extends S.Class<Obj4>("Obj4")({
    "dummy": S.Int,
    "mutable": Mutable,
    "mutating": Mutating,
    "namespace": Namespace,
    "native": Native,
    "new": New,
    "newtonsoft": Newtonsoft,
    "nil": Nil,
    "NO": No,
    "noSuchMethod": NoSuchMethod,
    "noexcept": Noexcept,
    "nonatomic": Nonatomic,
    "None": None,
    "nonlocal": Nonlocal,
    "nonmutating": Nonmutating,
    "not": Not,
    "not_eq": NotEq,
    "NSError": NsError,
    "NSObject": NsObject,
    "NSString": NsString,
    "NULL": Null,
    "NullNode": NullNode,
    "nullptr": Nullptr,
    "number": Number,
    "none": NoneClass,
    "null": NullClass,
    "protocol": ProtocolClass,
    "object": ObjectClass,
    "ObjectMapper": ObjectMapper,
    "ObjectNode": ObjectNode,
    "ObjectReader": ObjectReader,
    "ObjectWriter": ObjectWriter,
    "of": Of,
    "OffsetDateTime": OffsetDateTime,
    "OffsetTime": OffsetTime,
    "oneway": Oneway,
    "open": Open,
    "operator": Operator,
    "optional": Optional,
    "or": Or,
    "or_eq": OrEq,
    "out": Out,
    "override": Override,
    "package": Package,
    "params": Params,
    "pass": Pass,
    "port": Port,
    "postfix": Postfix,
    "precedence": Precedence,
    "prefix": Prefix,
    "print": Print,
    "printMembers": PrintMembers,
    "printf": Printf,
    "private": Private,
    "protected": Protected,
    "Protocol": Protocol,
    "public": Public,
    "quicktype": Quicktype,
    "raise": Raise,
    "range": Range,
    "readonly": Readonly,
    "ref": Ref,
    "RegExp": RegExpClass,
    "register": Register,
    "reinterpret_cast": ReinterpretCast,
}) {}

export class Module extends S.Class<Module>("Module")({
    "module": S.Int,
}) {}

export class MetadataPropertyHandling extends S.Class<MetadataPropertyHandling>("MetadataPropertyHandling")({
    "metadata_property_handling": S.Int,
}) {}

export class MarshalJson extends S.Class<MarshalJson>("MarshalJson")({
    "MarshalJSON": S.Int,
}) {}

export class MapEntry extends S.Class<MapEntry>("MapEntry")({
    "MapEntry": S.Int,
}) {}

export class Map extends S.Class<Map>("Map")({
    "map": S.Int,
}) {}

export class LongNode extends S.Class<LongNode>("LongNode")({
    "LongNode": S.Int,
}) {}

export class Long extends S.Class<Long>("Long")({
    "long": S.Int,
}) {}

export class Lock extends S.Class<Lock>("Lock")({
    "lock": S.Int,
}) {}

export class Locale extends S.Class<Locale>("Locale")({
    "Locale": S.Int,
}) {}

export class LocalDate extends S.Class<LocalDate>("LocalDate")({
    "LocalDate": S.Int,
}) {}

export class List extends S.Class<List>("List")({
    "list": S.Int,
}) {}

export class Let extends S.Class<Let>("Let")({
    "let": S.Int,
}) {}

export class Left extends S.Class<Left>("Left")({
    "left": S.Int,
}) {}

export class Lazy extends S.Class<Lazy>("Lazy")({
    "lazy": S.Int,
}) {}

export class Lambda extends S.Class<Lambda>("Lambda")({
    "lambda": S.Int,
}) {}

export class JsonWriter extends S.Class<JsonWriter>("JsonWriter")({
    "json_writer": S.Int,
}) {}

export class JsonTokenType extends S.Class<JsonTokenType>("JsonTokenType")({
    "JsonTokenType": S.Int,
}) {}

export class JsonToken extends S.Class<JsonToken>("JsonToken")({
    "json_token": S.Int,
}) {}

export class JsonSerializer extends S.Class<JsonSerializer>("JsonSerializer")({
    "json_serializer": S.Int,
}) {}

export class JsonReader extends S.Class<JsonReader>("JsonReader")({
    "JsonReader": S.Int,
}) {}

export class JsonParser extends S.Class<JsonParser>("JsonParser")({
    "JsonParser": S.Int,
}) {}

export class JsonNull extends S.Class<JsonNull>("JsonNull")({
    "JSONNull": S.Int,
}) {}

export class JsonNode extends S.Class<JsonNode>("JsonNode")({
    "JsonNode": S.Int,
}) {}

export class JsonGenerator extends S.Class<JsonGenerator>("JsonGenerator")({
    "JsonGenerator": S.Int,
}) {}

export class JsonException extends S.Class<JsonException>("JsonException")({
    "JsonException": S.Int,
}) {}

export class JsonEncoder extends S.Class<JsonEncoder>("JsonEncoder")({
    "JSONEncoder": S.Int,
}) {}

export class JsonDecoder extends S.Class<JsonDecoder>("JsonDecoder")({
    "JSONDecoder": S.Int,
}) {}

export class JsonConverter extends S.Class<JsonConverter>("JsonConverter")({
    "json_converter": S.Int,
}) {}

export class JsonCodingKey extends S.Class<JsonCodingKey>("JsonCodingKey")({
    "JSONCodingKey": S.Int,
}) {}

export class JsonAny extends S.Class<JsonAny>("JsonAny")({
    "JSONAny": S.Null,
}) {}

export class Json extends S.Class<Json>("Json")({
    "json": S.Int,
}) {}

export class Jpipe extends S.Class<Jpipe>("Jpipe")({
    "jpipe": S.Int,
}) {}

export class Jenc extends S.Class<Jenc>("Jenc")({
    "jenc": S.Int,
}) {}

export class Jdec extends S.Class<Jdec>("Jdec")({
    "jdec": S.Int,
}) {}

export class Iterable extends S.Class<Iterable>("Iterable")({
    "iterable": S.Int,
}) {}

export class IsoDateTimeOffsetConverter extends S.Class<IsoDateTimeOffsetConverter>("IsoDateTimeOffsetConverter")({
    "IsoDateTimeOffsetConverter": S.Int,
}) {}

export class Is extends S.Class<Is>("Is")({
    "is": S.Int,
}) {}

export class Internal extends S.Class<Internal>("Internal")({
    "internal": S.Int,
}) {}

export class Interface extends S.Class<Interface>("Interface")({
    "interface": S.Int,
}) {}

export class IntNode extends S.Class<IntNode>("IntNode")({
    "IntNode": S.Int,
}) {}

export class Int extends S.Class<Int>("Int")({
    "int": S.Int,
}) {}

export class Instanceof extends S.Class<Instanceof>("Instanceof")({
    "instanceof": S.Int,
}) {}

export class Inout extends S.Class<Inout>("Inout")({
    "inout": S.Int,
}) {}

export class Inline extends S.Class<Inline>("Inline")({
    "inline": S.Int,
}) {}

export class Init extends S.Class<Init>("Init")({
    "init": S.Int,
}) {}

export class Infix extends S.Class<Infix>("Infix")({
    "infix": S.Int,
}) {}

export class Indirect extends S.Class<Indirect>("Indirect")({
    "indirect": S.Int,
}) {}

export class In extends S.Class<In>("In")({
    "in": S.Int,
}) {}

export class Import extends S.Class<Import>("Import")({
    "import": S.Int,
}) {}

export class Implicit extends S.Class<Implicit>("Implicit")({
    "implicit": S.Int,
}) {}

export class Implements extends S.Class<Implements>("Implements")({
    "implements": S.Int,
}) {}

export class Imp extends S.Class<Imp>("Imp")({
    "IMP": S.Int,
}) {}

export class If extends S.Class<If>("If")({
    "if": S.Int,
}) {}

export class Id extends S.Class<Id>("Id")({
    "id": S.Int,
}) {}

export class Hasher extends S.Class<Hasher>("Hasher")({
    "Hasher": S.Int,
}) {}

export class Hashable extends S.Class<Hashable>("Hashable")({
    "Hashable": S.Int,
}) {}

export class HashCode extends S.Class<HashCode>("HashCode")({
    "hashCode": S.Int,
}) {}

export class HasOwnProperty extends S.Class<HasOwnProperty>("HasOwnProperty")({
    "hasOwnProperty": S.Int,
}) {}

export class Guard extends S.Class<Guard>("Guard")({
    "guard": S.Int,
}) {}

export class Goto extends S.Class<Goto>("Goto")({
    "goto": S.Int,
}) {}

export class Go extends S.Class<Go>("Go")({
    "go": S.Int,
}) {}

export class Global extends S.Class<Global>("Global")({
    "global": S.Int,
}) {}

export class Get extends S.Class<Get>("Get")({
    "get": S.Int,
}) {}

export class Function extends S.Class<Function>("Function")({
    "function": S.Int,
}) {}

export class Obj3 extends S.Class<Obj3>("Obj3")({
    "dummy": S.Int,
    "function": Function,
    "get": Get,
    "global": Global,
    "go": Go,
    "goto": Goto,
    "guard": Guard,
    "hasOwnProperty": HasOwnProperty,
    "hashCode": HashCode,
    "Hashable": Hashable,
    "Hasher": Hasher,
    "id": Id,
    "if": If,
    "IMP": Imp,
    "implements": Implements,
    "implicit": Implicit,
    "import": Import,
    "in": In,
    "indirect": Indirect,
    "infix": Infix,
    "init": Init,
    "inline": Inline,
    "inout": Inout,
    "instanceof": Instanceof,
    "int": Int,
    "IntNode": IntNode,
    "interface": Interface,
    "internal": Internal,
    "is": Is,
    "IsoDateTimeOffsetConverter": IsoDateTimeOffsetConverter,
    "iterable": Iterable,
    "jdec": Jdec,
    "jenc": Jenc,
    "jpipe": Jpipe,
    "json": Json,
    "JSONAny": JsonAny,
    "JSONCodingKey": JsonCodingKey,
    "json_converter": JsonConverter,
    "JSONDecoder": JsonDecoder,
    "JSONEncoder": JsonEncoder,
    "JsonException": JsonException,
    "JsonGenerator": JsonGenerator,
    "JsonNode": JsonNode,
    "JSONNull": JsonNull,
    "JsonParser": JsonParser,
    "JsonReader": JsonReader,
    "json_serializer": JsonSerializer,
    "json_token": JsonToken,
    "JsonTokenType": JsonTokenType,
    "json_writer": JsonWriter,
    "lambda": Lambda,
    "lazy": Lazy,
    "left": Left,
    "let": Let,
    "list": List,
    "LocalDate": LocalDate,
    "Locale": Locale,
    "lock": Lock,
    "long": Long,
    "LongNode": LongNode,
    "map": Map,
    "MapEntry": MapEntry,
    "MarshalJSON": MarshalJson,
    "metadata_property_handling": MetadataPropertyHandling,
    "module": Module,
}) {}

export class FalseClass extends S.Class<FalseClass>("FalseClass")({
    "false": S.Int,
}) {}

export class Func extends S.Class<Func>("Func")({
    "func": S.Int,
}) {}

export class FromJson extends S.Class<FromJson>("FromJson")({
    "from_json": S.Int,
}) {}

export class FromDict extends S.Class<FromDict>("FromDict")({
    "from_dict": S.Int,
}) {}

export class From extends S.Class<From>("From")({
    "from": S.Int,
}) {}

export class Friend extends S.Class<Friend>("Friend")({
    "friend": S.Int,
}) {}

export class FormatException extends S.Class<FormatException>("FormatException")({
    "FormatException": S.Int,
}) {}

export class Foreach extends S.Class<Foreach>("Foreach")({
    "foreach": S.Int,
}) {}

export class For extends S.Class<For>("For")({
    "for": S.Int,
}) {}

export class Float extends S.Class<Float>("Float")({
    "float": S.Int,
}) {}

export class Fixed extends S.Class<Fixed>("Fixed")({
    "fixed": S.Int,
}) {}

export class Finally extends S.Class<Finally>("Finally")({
    "finally": S.Int,
}) {}

export class Final extends S.Class<Final>("Final")({
    "final": S.Int,
}) {}

export class Fileprivate extends S.Class<Fileprivate>("Fileprivate")({
    "fileprivate": S.Int,
}) {}

export class False extends S.Class<False>("False")({
    "False": S.Int,
}) {}

export class Fallthrough extends S.Class<Fallthrough>("Fallthrough")({
    "fallthrough": S.Int,
}) {}

export class Extern extends S.Class<Extern>("Extern")({
    "extern": S.Int,
}) {}

export class Extension extends S.Class<Extension>("Extension")({
    "extension": S.Int,
}) {}

export class Extends extends S.Class<Extends>("Extends")({
    "extends": S.Int,
}) {}

export class Exposing extends S.Class<Exposing>("Exposing")({
    "exposing": S.Int,
}) {}

export class Export extends S.Class<Export>("Export")({
    "export": S.Int,
}) {}

export class Explicit extends S.Class<Explicit>("Explicit")({
    "explicit": S.Int,
}) {}

export class Exception extends S.Class<Exception>("Exception")({
    "exception": S.Int,
}) {}

export class Except extends S.Class<Except>("Except")({
    "except": S.Int,
}) {}

export class Event extends S.Class<Event>("Event")({
    "event": S.Int,
}) {}

export class Equatable extends S.Class<Equatable>("Equatable")({
    "Equatable": S.Int,
}) {}

export class EqualityContract extends S.Class<EqualityContract>("EqualityContract")({
    "equalityContract": S.Int,
}) {}

export class EnumValues extends S.Class<EnumValues>("EnumValues")({
    "EnumValues": S.Array(EnumValue),
}) {}

export class Enum extends S.Class<Enum>("Enum")({
    "enum": S.Int,
}) {}

export class Encoder extends S.Class<Encoder>("Encoder")({
    "Encoder": S.Int,
}) {}

export class EncodeQuickType extends S.Class<EncodeQuickType>("EncodeQuickType")({
    "encode_quick_type": S.Int,
}) {}

export class Else extends S.Class<Else>("Else")({
    "else": S.Int,
}) {}

export class Elif extends S.Class<Elif>("Elif")({
    "elif": S.Int,
}) {}

export class DynamicCast extends S.Class<DynamicCast>("DynamicCast")({
    "dynamic_cast": S.Int,
}) {}

export class Dynamic extends S.Class<Dynamic>("Dynamic")({
    "dynamic": S.Int,
}) {}

export class DoubleNode extends S.Class<DoubleNode>("DoubleNode")({
    "DoubleNode": S.Int,
}) {}

export class Double extends S.Class<Double>("Double")({
    "double": S.Int,
}) {}

export class Do extends S.Class<Do>("Do")({
    "do": S.Int,
}) {}

export class DidSet extends S.Class<DidSet>("DidSet")({
    "didSet": S.Int,
}) {}

export class Dictionary extends S.Class<Dictionary>("Dictionary")({
    "dictionary": S.Int,
}) {}

export class Dict extends S.Class<Dict>("Dict")({
    "dict": S.Int,
}) {}

export class DeserializationFeature extends S.Class<DeserializationFeature>("DeserializationFeature")({
    "DeserializationFeature": S.Int,
}) {}

export class Delete extends S.Class<Delete>("Delete")({
    "delete": S.Int,
}) {}

export class Delegate extends S.Class<Delegate>("Delegate")({
    "delegate": S.Int,
}) {}

export class Del extends S.Class<Del>("Del")({
    "del": S.Int,
}) {}

export class Deinit extends S.Class<Deinit>("Deinit")({
    "deinit": S.Int,
}) {}

export class Defer extends S.Class<Defer>("Defer")({
    "defer": S.Int,
}) {}

export class Default extends S.Class<Default>("Default")({
    "default": S.Int,
}) {}

export class Def extends S.Class<Def>("Def")({
    "def": S.Int,
}) {}

export class DecodingError extends S.Class<DecodingError>("DecodingError")({
    "DecodingError": S.Int,
}) {}

export class Decoder extends S.Class<Decoder>("Decoder")({
    "Decoder": S.Int,
}) {}

export class DecodeString extends S.Class<DecodeString>("DecodeString")({
    "decode_string": S.Int,
}) {}

export class Decltype extends S.Class<Decltype>("Decltype")({
    "decltype": S.Int,
}) {}

export class Declare extends S.Class<Declare>("Declare")({
    "declare": S.Int,
}) {}

export class Decimal extends S.Class<Decimal>("Decimal")({
    "decimal": S.Int,
}) {}

export class Debugger extends S.Class<Debugger>("Debugger")({
    "debugger": S.Int,
}) {}

export class DateTimeStyles extends S.Class<DateTimeStyles>("DateTimeStyles")({
    "DateTimeStyles": S.Int,
}) {}

export class DateTime extends S.Class<DateTime>("DateTime")({
    "DateTime": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
}) {}

export class DateParseHandling extends S.Class<DateParseHandling>("DateParseHandling")({
    "date_parse_handling": S.Int,
}) {}

export class DateOnlyConverter extends S.Class<DateOnlyConverter>("DateOnlyConverter")({
    "DateOnlyConverter": S.Int,
}) {}

export class DateOnly extends S.Class<DateOnly>("DateOnly")({
    "DateOnly": S.Int,
}) {}

export class DateFormatter extends S.Class<DateFormatter>("DateFormatter")({
    "DateFormatter": S.Int,
}) {}

export class DateClass extends S.Class<DateClass>("DateClass")({
    "date": S.Int,
}) {}

export class CultureInfo extends S.Class<CultureInfo>("CultureInfo")({
    "CultureInfo": S.Int,
}) {}

export class Obj2 extends S.Class<Obj2>("Obj2")({
    "CultureInfo": CultureInfo,
    "date": DateClass,
    "DateFormatter": DateFormatter,
    "DateOnly": DateOnly,
    "DateOnlyConverter": DateOnlyConverter,
    "date_parse_handling": DateParseHandling,
    "DateTime": DateTime,
    "DateTimeStyles": DateTimeStyles,
    "debugger": Debugger,
    "decimal": Decimal,
    "declare": Declare,
    "decltype": Decltype,
    "decode_string": DecodeString,
    "Decoder": Decoder,
    "DecodingError": DecodingError,
    "def": Def,
    "default": Default,
    "defer": Defer,
    "deinit": Deinit,
    "del": Del,
    "delegate": Delegate,
    "delete": Delete,
    "DeserializationFeature": DeserializationFeature,
    "dict": Dict,
    "dictionary": Dictionary,
    "didSet": DidSet,
    "do": Do,
    "double": Double,
    "DoubleNode": DoubleNode,
    "dummy": S.Int,
    "dynamic": Dynamic,
    "dynamic_cast": DynamicCast,
    "elif": Elif,
    "else": Else,
    "encode_quick_type": EncodeQuickType,
    "Encoder": Encoder,
    "enum": Enum,
    "EnumValues": EnumValues,
    "equalityContract": EqualityContract,
    "Equatable": Equatable,
    "event": Event,
    "except": Except,
    "exception": Exception,
    "explicit": Explicit,
    "export": Export,
    "exposing": Exposing,
    "extends": Extends,
    "extension": Extension,
    "extern": Extern,
    "fallthrough": Fallthrough,
    "False": False,
    "fileprivate": Fileprivate,
    "final": Final,
    "finally": Finally,
    "fixed": Fixed,
    "float": Float,
    "for": For,
    "foreach": Foreach,
    "FormatException": FormatException,
    "friend": Friend,
    "from": From,
    "from_dict": FromDict,
    "from_json": FromJson,
    "func": Func,
    "false": FalseClass,
}) {}

export class Obj1Bool extends S.Class<Obj1Bool>("Obj1Bool")({
    "bool": S.Int,
}) {}

export class Obj1Class extends S.Class<Obj1Class>("Obj1Class")({
    "class": S.Int,
}) {}

export class BoolClass extends S.Class<BoolClass>("BoolClass")({
    "_Bool": S.Int,
}) {}

export class AnyClass extends S.Class<AnyClass>("AnyClass")({
    "any": S.Int,
}) {}

export class Imaginery extends S.Class<Imaginery>("Imaginery")({
    "_Imaginery": S.Int,
}) {}

export class Empty extends S.Class<Empty>("Empty")({
    "_": S.Int,
}) {}

export class Converter extends S.Class<Converter>("Converter")({
    "converter": S.Int,
}) {}

export class Convert extends S.Class<Convert>("Convert")({
    "convert": S.Int,
}) {}

export class Convenience extends S.Class<Convenience>("Convenience")({
    "convenience": S.Int,
}) {}

export class Continue extends S.Class<Continue>("Continue")({
    "continue": S.Int,
}) {}

export class Constructor extends S.Class<Constructor>("Constructor")({
    "constructor": S.Int,
}) {}

export class Constexpr extends S.Class<Constexpr>("Constexpr")({
    "constexpr": S.Int,
}) {}

export class ConstCast extends S.Class<ConstCast>("ConstCast")({
    "const_cast": S.Int,
}) {}

export class Const extends S.Class<Const>("Const")({
    "const": S.Int,
}) {}

export class Console extends S.Class<Console>("Console")({
    "console": S.Int,
}) {}

export class Concept extends S.Class<Concept>("Concept")({
    "concept": S.Int,
}) {}

export class Complex extends S.Class<Complex>("Complex")({
    "_Complex": S.Int,
}) {}

export class Compl extends S.Class<Compl>("Compl")({
    "compl": S.Int,
}) {}

export class CodingKeys extends S.Class<CodingKeys>("CodingKeys")({
    "CodingKeys": S.Int,
}) {}

export class CodingKey extends S.Class<CodingKey>("CodingKey")({
    "CodingKey": S.Int,
}) {}

export class Codable extends S.Class<Codable>("Codable")({
    "Codable": S.Int,
}) {}

export class CoYield extends S.Class<CoYield>("CoYield")({
    "co_yield": S.Int,
}) {}

export class CoReturn extends S.Class<CoReturn>("CoReturn")({
    "co_return": S.Int,
}) {}

export class CoAwait extends S.Class<CoAwait>("CoAwait")({
    "co_await": S.Int,
}) {}

export class Clone extends S.Class<Clone>("Clone")({
    "clone": S.Int,
}) {}

export class ClassClass extends S.Class<ClassClass>("ClassClass")({
    "Class": S.Int,
}) {}

export class Checked extends S.Class<Checked>("Checked")({
    "checked": S.Int,
}) {}

export class Char32T extends S.Class<Char32T>("Char32T")({
    "char32_t": S.Int,
}) {}

export class Char16T extends S.Class<Char16T>("Char16T")({
    "char16_t": S.Int,
}) {}

export class Char extends S.Class<Char>("Char")({
    "char": S.Int,
}) {}

export class Chan extends S.Class<Chan>("Chan")({
    "chan": S.Int,
}) {}

export class Catch extends S.Class<Catch>("Catch")({
    "catch": S.Int,
}) {}

export class Case extends S.Class<Case>("Case")({
    "case": S.Int,
}) {}

export class Calendar extends S.Class<Calendar>("Calendar")({
    "Calendar": S.Int,
}) {}

export class Byte extends S.Class<Byte>("Byte")({
    "byte": S.Int,
}) {}

export class Byref extends S.Class<Byref>("Byref")({
    "byref": S.Int,
}) {}

export class Bycopy extends S.Class<Bycopy>("Bycopy")({
    "bycopy": S.Int,
}) {}

export class Break extends S.Class<Break>("Break")({
    "break": S.Int,
}) {}

export class BooleanNode extends S.Class<BooleanNode>("BooleanNode")({
    "BooleanNode": S.Int,
}) {}

export class Boolean extends S.Class<Boolean>("Boolean")({
    "boolean": S.Int,
}) {}

export class Bool extends S.Class<Bool>("Bool")({
    "BOOL": S.Int,
}) {}

export class Bitor extends S.Class<Bitor>("Bitor")({
    "bitor": S.Int,
}) {}

export class Bitand extends S.Class<Bitand>("Bitand")({
    "bitand": S.Int,
}) {}

export class Base extends S.Class<Base>("Base")({
    "base": S.Int,
}) {}

export class Await extends S.Class<Await>("Await")({
    "await": S.Int,
}) {}

export class Auto extends S.Class<Auto>("Auto")({
    "auto": S.Int,
}) {}

export class AtomicNoexcept extends S.Class<AtomicNoexcept>("AtomicNoexcept")({
    "atomic_noexcept": S.Int,
}) {}

export class AtomicCommit extends S.Class<AtomicCommit>("AtomicCommit")({
    "atomic_commit": S.Int,
}) {}

export class AtomicCancel extends S.Class<AtomicCancel>("AtomicCancel")({
    "atomic_cancel": S.Int,
}) {}

export class Atomic extends S.Class<Atomic>("Atomic")({
    "atomic": S.Int,
}) {}

export class Async extends S.Class<Async>("Async")({
    "async": S.Int,
}) {}

export class Associativity extends S.Class<Associativity>("Associativity")({
    "associativity": S.Int,
}) {}

export class Associatedtype extends S.Class<Associatedtype>("Associatedtype")({
    "associatedtype": S.Int,
}) {}

export class Assert extends S.Class<Assert>("Assert")({
    "assert": S.Int,
}) {}

export class Asm extends S.Class<Asm>("Asm")({
    "asm": S.Int,
}) {}

export class As extends S.Class<As>("As")({
    "as": S.Int,
}) {}

export class ArrayNode extends S.Class<ArrayNode>("ArrayNode")({
    "ArrayNode": S.Int,
}) {}

export class ArrayClass extends S.Class<ArrayClass>("ArrayClass")({
    "array": S.Int,
}) {}

export class Any extends S.Class<Any>("Any")({
    "Any": S.Int,
}) {}

export class AndEq extends S.Class<AndEq>("AndEq")({
    "and_eq": S.Int,
}) {}

export class And extends S.Class<And>("And")({
    "and": S.Int,
}) {}

export class Alignof extends S.Class<Alignof>("Alignof")({
    "alignof": S.Int,
}) {}

export class Alignas extends S.Class<Alignas>("Alignas")({
    "alignas": S.Int,
}) {}

export class Abstract extends S.Class<Abstract>("Abstract")({
    "abstract": S.Int,
}) {}

export class Obj1 extends S.Class<Obj1>("Obj1")({
    "abstract": Abstract,
    "alignas": Alignas,
    "alignof": Alignof,
    "and": And,
    "and_eq": AndEq,
    "Any": Any,
    "array": ArrayClass,
    "ArrayNode": ArrayNode,
    "as": As,
    "asm": Asm,
    "assert": Assert,
    "associatedtype": Associatedtype,
    "associativity": Associativity,
    "async": Async,
    "atomic": Atomic,
    "atomic_cancel": AtomicCancel,
    "atomic_commit": AtomicCommit,
    "atomic_noexcept": AtomicNoexcept,
    "auto": Auto,
    "await": Await,
    "base": Base,
    "bitand": Bitand,
    "bitor": Bitor,
    "BOOL": Bool,
    "boolean": Boolean,
    "BooleanNode": BooleanNode,
    "break": Break,
    "bycopy": Bycopy,
    "byref": Byref,
    "byte": Byte,
    "Calendar": Calendar,
    "case": Case,
    "catch": Catch,
    "chan": Chan,
    "char": Char,
    "char16_t": Char16T,
    "char32_t": Char32T,
    "checked": Checked,
    "Class": ClassClass,
    "clone": Clone,
    "co_await": CoAwait,
    "co_return": CoReturn,
    "co_yield": CoYield,
    "Codable": Codable,
    "CodingKey": CodingKey,
    "CodingKeys": CodingKeys,
    "compl": Compl,
    "_Complex": Complex,
    "concept": Concept,
    "console": Console,
    "const": Const,
    "const_cast": ConstCast,
    "constexpr": Constexpr,
    "constructor": Constructor,
    "continue": Continue,
    "convenience": Convenience,
    "convert": Convert,
    "converter": Converter,
    "dummy": S.Int,
    "_": Empty,
    "_Imaginery": Imaginery,
    "any": AnyClass,
    "_Bool": BoolClass,
    "class": Obj1Class,
    "bool": Obj1Bool,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "dummy": S.Int,
    "obj1": Obj1,
    "obj2": Obj2,
    "obj3": Obj3,
    "obj4": Obj4,
    "obj5": Obj5,
    "obj6": Obj6,
}) {}
