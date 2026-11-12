// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    #[serde(rename = "enum")]
    pub top_level_enum: Option<Enum>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Enum {
    #[serde(rename = "_")]
    Empty,

    #[serde(rename = "_Bool")]
    Bool,

    #[serde(rename = "_Complex")]
    Complex,

    #[serde(rename = "_Imaginery")]
    Imaginery,

    Abstract,

    Alignas,

    Alignof,

    And,

    #[serde(rename = "and_eq")]
    AndEq,

    Any,

    #[serde(rename = "Any")]
    EnumAny,

    #[serde(rename = "ArrayNode")]
    ArrayNode,

    Array,

    As,

    Asm,

    Assert,

    Associatedtype,

    Associativity,

    Async,

    Atomic,

    #[serde(rename = "atomic_cancel")]
    AtomicCancel,

    #[serde(rename = "atomic_commit")]
    AtomicCommit,

    #[serde(rename = "atomic_noexcept")]
    AtomicNoexcept,

    Auto,

    Await,

    Base,

    Bitand,

    Bitor,

    #[serde(rename = "BOOL")]
    EnumBool,

    #[serde(rename = "bool")]
    PurpleBool,

    Boolean,

    #[serde(rename = "BooleanNode")]
    BooleanNode,

    Break,

    Bycopy,

    Byref,

    Byte,

    #[serde(rename = "Calendar")]
    Calendar,

    Case,

    Catch,

    Chan,

    Char,

    #[serde(rename = "char16_t")]
    Char16T,

    #[serde(rename = "char32_t")]
    Char32T,

    Checked,

    Class,

    #[serde(rename = "Class")]
    EnumClass,

    Clone,

    #[serde(rename = "co_await")]
    CoAwait,

    #[serde(rename = "co_return")]
    CoReturn,

    #[serde(rename = "co_yield")]
    CoYield,

    #[serde(rename = "Codable")]
    Codable,

    #[serde(rename = "CodingKey")]
    CodingKey,

    #[serde(rename = "CodingKeys")]
    CodingKeys,

    Compl,

    Concept,

    Console,

    Const,

    #[serde(rename = "const_cast")]
    ConstCast,

    Constexpr,

    Constructor,

    Continue,

    Convenience,

    Convert,

    Converter,

    #[serde(rename = "CultureInfo")]
    CultureInfo,

    Date,

    #[serde(rename = "date_parse_handling")]
    DateParseHandling,

    #[serde(rename = "DateFormatter")]
    DateFormatter,

    #[serde(rename = "DateOnly")]
    DateOnly,

    #[serde(rename = "DateOnlyConverter")]
    DateOnlyConverter,

    #[serde(rename = "DateTime")]
    DateTime,

    #[serde(rename = "DateTimeStyles")]
    DateTimeStyles,

    Debugger,

    Decimal,

    Declare,

    #[serde(rename = "DeserializationFeature")]
    DeserializationFeature,

    Decltype,

    #[serde(rename = "decode_string")]
    DecodeString,

    #[serde(rename = "Decoder")]
    Decoder,

    #[serde(rename = "DecodingError")]
    DecodingError,

    Def,

    Default,

    Defer,

    Deinit,

    Del,

    Delegate,

    Delete,

    Dict,

    Dictionary,

    #[serde(rename = "didSet")]
    DidSet,

    Do,

    Double,

    #[serde(rename = "DoubleNode")]
    DoubleNode,

    Dynamic,

    #[serde(rename = "dynamic_cast")]
    DynamicCast,

    Elif,

    Else,

    #[serde(rename = "encode_quick_type")]
    EncodeQuickType,

    #[serde(rename = "Encoder")]
    Encoder,

    Enum,

    #[serde(rename = "EnumValues")]
    EnumValues,

    #[serde(rename = "Equatable")]
    Equatable,

    #[serde(rename = "equalityContract")]
    EqualityContract,

    Event,

    Except,

    Exception,

    Explicit,

    Export,

    Exposing,

    Extends,

    Extension,

    Extern,

    Fallthrough,

    False,

    #[serde(rename = "False")]
    EnumFalse,

    Fileprivate,

    Final,

    Finally,

    Fixed,

    Float,

    For,

    Foreach,

    #[serde(rename = "FormatException")]
    FormatException,

    Friend,

    From,

    #[serde(rename = "from_dict")]
    FromDict,

    #[serde(rename = "from_json")]
    FromJson,

    Func,

    Function,

    Get,

    Global,

    Go,

    Goto,

    Guard,

    #[serde(rename = "Hashable")]
    Hashable,

    #[serde(rename = "hashCode")]
    HashCode,

    #[serde(rename = "Hasher")]
    Hasher,

    #[serde(rename = "hasOwnProperty")]
    HasOwnProperty,

    Id,

    If,

    #[serde(rename = "IMP")]
    Imp,

    Implements,

    Implicit,

    Import,

    In,

    Indirect,

    Infix,

    Init,

    Inline,

    Inout,

    Instanceof,

    Int,

    #[serde(rename = "IntNode")]
    IntNode,

    Interface,

    Internal,

    #[serde(rename = "IsoDateTimeOffsetConverter")]
    IsoDateTimeOffsetConverter,

    Iterable,

    Is,

    Jdec,

    Jenc,

    Jpipe,

    Json,

    #[serde(rename = "json_converter")]
    JsonConverter,

    #[serde(rename = "json_serializer")]
    JsonSerializer,

    #[serde(rename = "json_token")]
    JsonToken,

    #[serde(rename = "json_writer")]
    JsonWriter,

    #[serde(rename = "JSONAny")]
    JsonAny,

    #[serde(rename = "JSONCodingKey")]
    JsonCodingKey,

    #[serde(rename = "JSONDecoder")]
    JsonDecoder,

    #[serde(rename = "JSONEncoder")]
    JsonEncoder,

    #[serde(rename = "JsonException")]
    JsonException,

    #[serde(rename = "JsonGenerator")]
    JsonGenerator,

    #[serde(rename = "JsonNode")]
    JsonNode,

    #[serde(rename = "JSONNull")]
    JsonNull,

    #[serde(rename = "JsonParser")]
    JsonParser,

    #[serde(rename = "JsonReader")]
    JsonReader,

    #[serde(rename = "JsonTokenType")]
    JsonTokenType,

    Lambda,

    Lazy,

    Left,

    Let,

    List,

    #[serde(rename = "LocalDate")]
    LocalDate,

    #[serde(rename = "LongNode")]
    LongNode,

    #[serde(rename = "Locale")]
    Locale,

    Lock,

    Long,

    Map,

    #[serde(rename = "MarshalJSON")]
    MarshalJson,

    #[serde(rename = "MapEntry")]
    MapEntry,

    #[serde(rename = "metadata_property_handling")]
    MetadataPropertyHandling,

    Module,

    Mutable,

    Mutating,

    Namespace,

    Native,

    New,

    Newtonsoft,

    Nil,

    #[serde(rename = "NullNode")]
    NullNode,

    #[serde(rename = "NO")]
    No,

    Noexcept,

    Nonatomic,

    #[serde(rename = "none")]
    EnumNone,

    #[serde(rename = "None")]
    PurpleNone,

    Nonlocal,

    Nonmutating,

    #[serde(rename = "NSObject")]
    NsObject,

    #[serde(rename = "noSuchMethod")]
    NoSuchMethod,

    Not,

    #[serde(rename = "not_eq")]
    NotEq,

    #[serde(rename = "NSError")]
    NsError,

    #[serde(rename = "NSString")]
    NsString,

    #[serde(rename = "NULL")]
    Null,

    #[serde(rename = "null")]
    EnumNull,

    Nullptr,

    Number,

    Object,

    #[serde(rename = "OffsetDateTime")]
    OffsetDateTime,

    #[serde(rename = "OffsetTime")]
    OffsetTime,

    #[serde(rename = "ObjectNode")]
    ObjectNode,

    #[serde(rename = "ObjectMapper")]
    ObjectMapper,

    #[serde(rename = "ObjectReader")]
    ObjectReader,

    #[serde(rename = "ObjectWriter")]
    ObjectWriter,

    Of,

    Oneway,

    Open,

    Operator,

    Optional,

    Or,

    #[serde(rename = "or_eq")]
    OrEq,

    Out,

    Override,

    Package,

    Params,

    Pass,

    Port,

    Postfix,

    Precedence,

    Prefix,

    Print,

    Printf,

    #[serde(rename = "printMembers")]
    PrintMembers,

    Private,

    Protected,

    #[serde(rename = "Protocol")]
    Protocol,

    #[serde(rename = "protocol")]
    EnumProtocol,

    Public,

    Quicktype,

    Raise,

    Range,

    Readonly,

    Ref,

    #[serde(rename = "RegExp")]
    RegExp,

    Register,

    #[serde(rename = "reinterpret_cast")]
    ReinterpretCast,

    Repeat,

    Require,

    Required,

    Requires,

    Restrict,

    Retain,

    Rethrows,

    Return,

    Right,

    #[serde(rename = "runtimeType")]
    RuntimeType,

    S,

    Sbyte,

    Sealed,

    #[serde(rename = "SEL")]
    Sel,

    Select,

    #[serde(rename = "Self")]
    EnumSelf,

    #[serde(rename = "Serializable")]
    Serializable,

    #[serde(rename = "self")]
    PurpleSelf,

    #[serde(rename = "Sendable")]
    Sendable,

    #[serde(rename = "serialize")]
    EnumSerialize,

    #[serde(rename = "SerialName")]
    SerialName,

    #[serde(rename = "KSerializer")]
    KSerializer,

    #[serde(rename = "PrimitiveKind")]
    PrimitiveKind,

    #[serde(rename = "SerialDescriptor")]
    SerialDescriptor,

    #[serde(rename = "SerializationFeature")]
    SerializationFeature,

    #[serde(rename = "SerializerProvider")]
    SerializerProvider,

    Set,

    Short,

    Signed,

    #[serde(rename = "SimpleModule")]
    SimpleModule,

    Sizeof,

    Stackalloc,

    #[serde(rename = "Standards")]
    Standards,

    Static,

    #[serde(rename = "static_assert")]
    StaticAssert,

    #[serde(rename = "static_cast")]
    StaticCast,

    #[serde(rename = "StdDeserializer")]
    StdDeserializer,

    #[serde(rename = "StdSerializer")]
    StdSerializer,

    Strictfp,

    #[serde(rename = "string")]
    EnumString,

    Struct,

    Subscript,

    Super,

    Switch,

    Symbol,

    Synchronized,

    System,

    Template,

    Then,

    This,

    #[serde(rename = "TextNode")]
    TextNode,

    #[serde(rename = "thread_local")]
    ThreadLocal,

    Throw,

    Throws,

    #[serde(rename = "TimeOnly")]
    TimeOnly,

    #[serde(rename = "TimeOnlyConverter")]
    TimeOnlyConverter,

    #[serde(rename = "TimeZone")]
    TimeZone,

    #[serde(rename = "to_json")]
    ToJson,

    #[serde(rename = "top_level")]
    TopLevel,

    #[serde(rename = "toString")]
    ToString,

    #[serde(rename = "to_dict")]
    ToDict,

    Transient,

    #[serde(rename = "True")]
    True,

    #[serde(rename = "true")]
    EnumTrue,

    Try,

    #[serde(rename = "Type")]
    Type,

    #[serde(rename = "type")]
    EnumType,

    Typealias,

    Typedef,

    Typeid,

    Typename,

    Typeof,

    Uint,

    Ulong,

    Unchecked,

    Undefined,

    Union,

    #[serde(rename = "UnmarshalJSON")]
    UnmarshalJson,

    #[serde(rename = "UseSerializers")]
    UseSerializers,

    Unowned,

    Unsafe,

    Unsigned,

    Ushort,

    Using,

    #[serde(rename = "Utf8JsonReader")]
    Utf8JsonReader,

    #[serde(rename = "Utf8JsonWriter")]
    Utf8JsonWriter,

    #[serde(rename = "UUID")]
    Uuid,

    Var,

    Virtual,

    Void,

    Volatile,

    #[serde(rename = "wchar_t")]
    WcharT,

    Weak,

    Where,

    While,

    #[serde(rename = "willSet")]
    WillSet,

    With,

    Xor,

    #[serde(rename = "xor_eq")]
    XorEq,

    #[serde(rename = "YES")]
    Yes,

    Yield,

    Dummy,
}
