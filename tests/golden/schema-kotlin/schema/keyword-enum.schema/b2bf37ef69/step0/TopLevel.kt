// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(EnumEnum::class, { EnumEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val enum: EnumEnum? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class EnumEnum(val value: String) {
    Empty("_"),
    Bool("_Bool"),
    Complex("_Complex"),
    Imaginery("_Imaginery"),
    Abstract("abstract"),
    Alignas("alignas"),
    Alignof("alignof"),
    And("and"),
    AndEq("and_eq"),
    EnumAny("any"),
    PurpleAny("Any"),
    ArrayNode("ArrayNode"),
    EnumArray("array"),
    As("as"),
    ASM("asm"),
    Assert("assert"),
    Associatedtype("associatedtype"),
    Associativity("associativity"),
    Async("async"),
    Atomic("atomic"),
    AtomicCancel("atomic_cancel"),
    AtomicCommit("atomic_commit"),
    AtomicNoexcept("atomic_noexcept"),
    Auto("auto"),
    Await("await"),
    Base("base"),
    Bitand("bitand"),
    Bitor("bitor"),
    EnumBOOL("BOOL"),
    EnumBool("bool"),
    EnumBoolean("boolean"),
    BooleanNode("BooleanNode"),
    Break("break"),
    Bycopy("bycopy"),
    Byref("byref"),
    EnumByte("byte"),
    Calendar("Calendar"),
    Case("case"),
    Catch("catch"),
    Chan("chan"),
    Char("char"),
    Char16T("char16_t"),
    Char32T("char32_t"),
    Checked("checked"),
    EnumClass("class"),
    PurpleClass("Class"),
    Clone("clone"),
    CoAwait("co_await"),
    CoReturn("co_return"),
    CoYield("co_yield"),
    Codable("Codable"),
    CodingKey("CodingKey"),
    CodingKeys("CodingKeys"),
    Compl("compl"),
    Concept("concept"),
    Console("console"),
    Const("const"),
    ConstCast("const_cast"),
    Constexpr("constexpr"),
    Constructor("constructor"),
    Continue("continue"),
    Convenience("convenience"),
    Convert("convert"),
    EnumConverter("converter"),
    CultureInfo("CultureInfo"),
    Date("date"),
    DateParseHandling("date_parse_handling"),
    DateFormatter("DateFormatter"),
    DateOnly("DateOnly"),
    DateOnlyConverter("DateOnlyConverter"),
    DateTime("DateTime"),
    DateTimeStyles("DateTimeStyles"),
    Debugger("debugger"),
    Decimal("decimal"),
    Declare("declare"),
    DeserializationFeature("DeserializationFeature"),
    Decltype("decltype"),
    DecodeString("decode_string"),
    Decoder("Decoder"),
    DecodingError("DecodingError"),
    Def("def"),
    Default("default"),
    Defer("defer"),
    Deinit("deinit"),
    Del("del"),
    Delegate("delegate"),
    Delete("delete"),
    Dict("dict"),
    Dictionary("dictionary"),
    DidSet("didSet"),
    Do("do"),
    EnumDouble("double"),
    DoubleNode("DoubleNode"),
    Dynamic("dynamic"),
    DynamicCast("dynamic_cast"),
    Elif("elif"),
    Else("else"),
    EncodeQuickType("encode_quick_type"),
    Encoder("Encoder"),
    PurpleEnum("enum"),
    EnumValues("EnumValues"),
    Equatable("Equatable"),
    EqualityContract("equalityContract"),
    Event("event"),
    Except("except"),
    Exception("exception"),
    Explicit("explicit"),
    Export("export"),
    Exposing("exposing"),
    Extends("extends"),
    Extension("extension"),
    Extern("extern"),
    Fallthrough("fallthrough"),
    False("false"),
    EnumFalse("False"),
    Fileprivate("fileprivate"),
    Final("final"),
    Finally("finally"),
    Fixed("fixed"),
    EnumFloat("float"),
    For("for"),
    Foreach("foreach"),
    FormatException("FormatException"),
    Friend("friend"),
    From("from"),
    FromDict("from_dict"),
    FromJSON("from_json"),
    Func("func"),
    Function("function"),
    Get("get"),
    Global("global"),
    Go("go"),
    Goto("goto"),
    Guard("guard"),
    Hashable("Hashable"),
    HashCode("hashCode"),
    Hasher("Hasher"),
    HasOwnProperty("hasOwnProperty"),
    ID("id"),
    If("if"),
    Imp("IMP"),
    Implements("implements"),
    Implicit("implicit"),
    Import("import"),
    In("in"),
    Indirect("indirect"),
    Infix("infix"),
    Init("init"),
    Inline("inline"),
    Inout("inout"),
    Instanceof("instanceof"),
    EnumInt("int"),
    IntNode("IntNode"),
    Interface("interface"),
    Internal("internal"),
    ISODateTimeOffsetConverter("IsoDateTimeOffsetConverter"),
    Iterable("iterable"),
    Is("is"),
    Jdec("jdec"),
    Jenc("jenc"),
    Jpipe("jpipe"),
    JSON("json"),
    JSONConverter("json_converter"),
    JSONSerializer("json_serializer"),
    JSONToken("json_token"),
    JSONWriter("json_writer"),
    JSONAny("JSONAny"),
    JSONCodingKey("JSONCodingKey"),
    JSONDecoder("JSONDecoder"),
    JSONEncoder("JSONEncoder"),
    JSONException("JsonException"),
    JSONGenerator("JsonGenerator"),
    JSONNode("JsonNode"),
    JSONNull("JSONNull"),
    JSONParser("JsonParser"),
    JSONReader("JsonReader"),
    JSONTokenType("JsonTokenType"),
    Lambda("lambda"),
    Lazy("lazy"),
    Left("left"),
    Let("let"),
    EnumList("list"),
    LocalDate("LocalDate"),
    LongNode("LongNode"),
    Locale("Locale"),
    Lock("lock"),
    EnumLong("long"),
    EnumMap("map"),
    MarshalJSON("MarshalJSON"),
    MapEntry("MapEntry"),
    MetadataPropertyHandling("metadata_property_handling"),
    Module("module"),
    Mutable("mutable"),
    Mutating("mutating"),
    Namespace("namespace"),
    Native("native"),
    New("new"),
    Newtonsoft("newtonsoft"),
    Nil("nil"),
    NullNode("NullNode"),
    No("NO"),
    Noexcept("noexcept"),
    Nonatomic("nonatomic"),
    None("none"),
    EnumNone("None"),
    Nonlocal("nonlocal"),
    Nonmutating("nonmutating"),
    NSObject("NSObject"),
    NoSuchMethod("noSuchMethod"),
    Not("not"),
    NotEq("not_eq"),
    NSError("NSError"),
    NSString("NSString"),
    Null("NULL"),
    EnumNull("null"),
    Nullptr("nullptr"),
    Number("number"),
    Object("object"),
    OffsetDateTime("OffsetDateTime"),
    OffsetTime("OffsetTime"),
    ObjectNode("ObjectNode"),
    ObjectMapper("ObjectMapper"),
    ObjectReader("ObjectReader"),
    ObjectWriter("ObjectWriter"),
    Of("of"),
    Oneway("oneway"),
    Open("open"),
    Operator("operator"),
    Optional("optional"),
    Or("or"),
    OrEq("or_eq"),
    Out("out"),
    Override("override"),
    Package("package"),
    Params("params"),
    Pass("pass"),
    Port("port"),
    Postfix("postfix"),
    Precedence("precedence"),
    Prefix("prefix"),
    Print("print"),
    Printf("printf"),
    PrintMembers("printMembers"),
    Private("private"),
    Protected("protected"),
    Protocol("Protocol"),
    EnumProtocol("protocol"),
    Public("public"),
    Quicktype("quicktype"),
    Raise("raise"),
    Range("range"),
    Readonly("readonly"),
    Ref("ref"),
    RegExp("RegExp"),
    Register("register"),
    ReinterpretCast("reinterpret_cast"),
    Repeat("repeat"),
    Require("require"),
    Required("required"),
    Requires("requires"),
    Restrict("restrict"),
    Retain("retain"),
    Rethrows("rethrows"),
    Return("return"),
    Right("right"),
    RuntimeType("runtimeType"),
    S("s"),
    Sbyte("sbyte"),
    Sealed("sealed"),
    Sel("SEL"),
    Select("select"),
    Self("Self"),
    Serializable("Serializable"),
    EnumSelf("self"),
    Sendable("Sendable"),
    Serialize("serialize"),
    SerialName("SerialName"),
    KSerializer("KSerializer"),
    PrimitiveKind("PrimitiveKind"),
    SerialDescriptor("SerialDescriptor"),
    SerializationFeature("SerializationFeature"),
    SerializerProvider("SerializerProvider"),
    Set("set"),
    EnumShort("short"),
    Signed("signed"),
    SimpleModule("SimpleModule"),
    Sizeof("sizeof"),
    Stackalloc("stackalloc"),
    Standards("Standards"),
    Static("static"),
    StaticAssert("static_assert"),
    StaticCast("static_cast"),
    StdDeserializer("StdDeserializer"),
    StdSerializer("StdSerializer"),
    Strictfp("strictfp"),
    EnumString("string"),
    Struct("struct"),
    Subscript("subscript"),
    Super("super"),
    Switch("switch"),
    Symbol("symbol"),
    Synchronized("synchronized"),
    EnumSystem("system"),
    Template("template"),
    Then("then"),
    This("this"),
    TextNode("TextNode"),
    ThreadLocal("thread_local"),
    Throw("throw"),
    Throws("throws"),
    TimeOnly("TimeOnly"),
    TimeOnlyConverter("TimeOnlyConverter"),
    TimeZone("TimeZone"),
    ToJSON("to_json"),
    TopLevel("top_level"),
    ToString("toString"),
    ToDict("to_dict"),
    Transient("transient"),
    True("True"),
    EnumTrue("true"),
    Try("try"),
    Type("Type"),
    EnumType("type"),
    Typealias("typealias"),
    Typedef("typedef"),
    Typeid("typeid"),
    Typename("typename"),
    Typeof("typeof"),
    Uint("uint"),
    Ulong("ulong"),
    Unchecked("unchecked"),
    Undefined("undefined"),
    Union("union"),
    UnmarshalJSON("UnmarshalJSON"),
    UseSerializers("UseSerializers"),
    Unowned("unowned"),
    Unsafe("unsafe"),
    Unsigned("unsigned"),
    Ushort("ushort"),
    Using("using"),
    Utf8JSONReader("Utf8JsonReader"),
    Utf8JSONWriter("Utf8JsonWriter"),
    UUID("UUID"),
    Var("var"),
    Virtual("virtual"),
    Void("void"),
    Volatile("volatile"),
    WcharT("wchar_t"),
    Weak("weak"),
    Where("where"),
    While("while"),
    WillSet("willSet"),
    With("with"),
    Xor("xor"),
    XorEq("xor_eq"),
    Yes("YES"),
    Yield("yield"),
    Dummy("dummy");

    companion object {
        public fun fromValue(value: String): EnumEnum = when (value) {
            "_"                          -> Empty
            "_Bool"                      -> Bool
            "_Complex"                   -> Complex
            "_Imaginery"                 -> Imaginery
            "abstract"                   -> Abstract
            "alignas"                    -> Alignas
            "alignof"                    -> Alignof
            "and"                        -> And
            "and_eq"                     -> AndEq
            "any"                        -> EnumAny
            "Any"                        -> PurpleAny
            "ArrayNode"                  -> ArrayNode
            "array"                      -> EnumArray
            "as"                         -> As
            "asm"                        -> ASM
            "assert"                     -> Assert
            "associatedtype"             -> Associatedtype
            "associativity"              -> Associativity
            "async"                      -> Async
            "atomic"                     -> Atomic
            "atomic_cancel"              -> AtomicCancel
            "atomic_commit"              -> AtomicCommit
            "atomic_noexcept"            -> AtomicNoexcept
            "auto"                       -> Auto
            "await"                      -> Await
            "base"                       -> Base
            "bitand"                     -> Bitand
            "bitor"                      -> Bitor
            "BOOL"                       -> EnumBOOL
            "bool"                       -> EnumBool
            "boolean"                    -> EnumBoolean
            "BooleanNode"                -> BooleanNode
            "break"                      -> Break
            "bycopy"                     -> Bycopy
            "byref"                      -> Byref
            "byte"                       -> EnumByte
            "Calendar"                   -> Calendar
            "case"                       -> Case
            "catch"                      -> Catch
            "chan"                       -> Chan
            "char"                       -> Char
            "char16_t"                   -> Char16T
            "char32_t"                   -> Char32T
            "checked"                    -> Checked
            "class"                      -> EnumClass
            "Class"                      -> PurpleClass
            "clone"                      -> Clone
            "co_await"                   -> CoAwait
            "co_return"                  -> CoReturn
            "co_yield"                   -> CoYield
            "Codable"                    -> Codable
            "CodingKey"                  -> CodingKey
            "CodingKeys"                 -> CodingKeys
            "compl"                      -> Compl
            "concept"                    -> Concept
            "console"                    -> Console
            "const"                      -> Const
            "const_cast"                 -> ConstCast
            "constexpr"                  -> Constexpr
            "constructor"                -> Constructor
            "continue"                   -> Continue
            "convenience"                -> Convenience
            "convert"                    -> Convert
            "converter"                  -> EnumConverter
            "CultureInfo"                -> CultureInfo
            "date"                       -> Date
            "date_parse_handling"        -> DateParseHandling
            "DateFormatter"              -> DateFormatter
            "DateOnly"                   -> DateOnly
            "DateOnlyConverter"          -> DateOnlyConverter
            "DateTime"                   -> DateTime
            "DateTimeStyles"             -> DateTimeStyles
            "debugger"                   -> Debugger
            "decimal"                    -> Decimal
            "declare"                    -> Declare
            "DeserializationFeature"     -> DeserializationFeature
            "decltype"                   -> Decltype
            "decode_string"              -> DecodeString
            "Decoder"                    -> Decoder
            "DecodingError"              -> DecodingError
            "def"                        -> Def
            "default"                    -> Default
            "defer"                      -> Defer
            "deinit"                     -> Deinit
            "del"                        -> Del
            "delegate"                   -> Delegate
            "delete"                     -> Delete
            "dict"                       -> Dict
            "dictionary"                 -> Dictionary
            "didSet"                     -> DidSet
            "do"                         -> Do
            "double"                     -> EnumDouble
            "DoubleNode"                 -> DoubleNode
            "dynamic"                    -> Dynamic
            "dynamic_cast"               -> DynamicCast
            "elif"                       -> Elif
            "else"                       -> Else
            "encode_quick_type"          -> EncodeQuickType
            "Encoder"                    -> Encoder
            "enum"                       -> PurpleEnum
            "EnumValues"                 -> EnumValues
            "Equatable"                  -> Equatable
            "equalityContract"           -> EqualityContract
            "event"                      -> Event
            "except"                     -> Except
            "exception"                  -> Exception
            "explicit"                   -> Explicit
            "export"                     -> Export
            "exposing"                   -> Exposing
            "extends"                    -> Extends
            "extension"                  -> Extension
            "extern"                     -> Extern
            "fallthrough"                -> Fallthrough
            "false"                      -> False
            "False"                      -> EnumFalse
            "fileprivate"                -> Fileprivate
            "final"                      -> Final
            "finally"                    -> Finally
            "fixed"                      -> Fixed
            "float"                      -> EnumFloat
            "for"                        -> For
            "foreach"                    -> Foreach
            "FormatException"            -> FormatException
            "friend"                     -> Friend
            "from"                       -> From
            "from_dict"                  -> FromDict
            "from_json"                  -> FromJSON
            "func"                       -> Func
            "function"                   -> Function
            "get"                        -> Get
            "global"                     -> Global
            "go"                         -> Go
            "goto"                       -> Goto
            "guard"                      -> Guard
            "Hashable"                   -> Hashable
            "hashCode"                   -> HashCode
            "Hasher"                     -> Hasher
            "hasOwnProperty"             -> HasOwnProperty
            "id"                         -> ID
            "if"                         -> If
            "IMP"                        -> Imp
            "implements"                 -> Implements
            "implicit"                   -> Implicit
            "import"                     -> Import
            "in"                         -> In
            "indirect"                   -> Indirect
            "infix"                      -> Infix
            "init"                       -> Init
            "inline"                     -> Inline
            "inout"                      -> Inout
            "instanceof"                 -> Instanceof
            "int"                        -> EnumInt
            "IntNode"                    -> IntNode
            "interface"                  -> Interface
            "internal"                   -> Internal
            "IsoDateTimeOffsetConverter" -> ISODateTimeOffsetConverter
            "iterable"                   -> Iterable
            "is"                         -> Is
            "jdec"                       -> Jdec
            "jenc"                       -> Jenc
            "jpipe"                      -> Jpipe
            "json"                       -> JSON
            "json_converter"             -> JSONConverter
            "json_serializer"            -> JSONSerializer
            "json_token"                 -> JSONToken
            "json_writer"                -> JSONWriter
            "JSONAny"                    -> JSONAny
            "JSONCodingKey"              -> JSONCodingKey
            "JSONDecoder"                -> JSONDecoder
            "JSONEncoder"                -> JSONEncoder
            "JsonException"              -> JSONException
            "JsonGenerator"              -> JSONGenerator
            "JsonNode"                   -> JSONNode
            "JSONNull"                   -> JSONNull
            "JsonParser"                 -> JSONParser
            "JsonReader"                 -> JSONReader
            "JsonTokenType"              -> JSONTokenType
            "lambda"                     -> Lambda
            "lazy"                       -> Lazy
            "left"                       -> Left
            "let"                        -> Let
            "list"                       -> EnumList
            "LocalDate"                  -> LocalDate
            "LongNode"                   -> LongNode
            "Locale"                     -> Locale
            "lock"                       -> Lock
            "long"                       -> EnumLong
            "map"                        -> EnumMap
            "MarshalJSON"                -> MarshalJSON
            "MapEntry"                   -> MapEntry
            "metadata_property_handling" -> MetadataPropertyHandling
            "module"                     -> Module
            "mutable"                    -> Mutable
            "mutating"                   -> Mutating
            "namespace"                  -> Namespace
            "native"                     -> Native
            "new"                        -> New
            "newtonsoft"                 -> Newtonsoft
            "nil"                        -> Nil
            "NullNode"                   -> NullNode
            "NO"                         -> No
            "noexcept"                   -> Noexcept
            "nonatomic"                  -> Nonatomic
            "none"                       -> None
            "None"                       -> EnumNone
            "nonlocal"                   -> Nonlocal
            "nonmutating"                -> Nonmutating
            "NSObject"                   -> NSObject
            "noSuchMethod"               -> NoSuchMethod
            "not"                        -> Not
            "not_eq"                     -> NotEq
            "NSError"                    -> NSError
            "NSString"                   -> NSString
            "NULL"                       -> Null
            "null"                       -> EnumNull
            "nullptr"                    -> Nullptr
            "number"                     -> Number
            "object"                     -> Object
            "OffsetDateTime"             -> OffsetDateTime
            "OffsetTime"                 -> OffsetTime
            "ObjectNode"                 -> ObjectNode
            "ObjectMapper"               -> ObjectMapper
            "ObjectReader"               -> ObjectReader
            "ObjectWriter"               -> ObjectWriter
            "of"                         -> Of
            "oneway"                     -> Oneway
            "open"                       -> Open
            "operator"                   -> Operator
            "optional"                   -> Optional
            "or"                         -> Or
            "or_eq"                      -> OrEq
            "out"                        -> Out
            "override"                   -> Override
            "package"                    -> Package
            "params"                     -> Params
            "pass"                       -> Pass
            "port"                       -> Port
            "postfix"                    -> Postfix
            "precedence"                 -> Precedence
            "prefix"                     -> Prefix
            "print"                      -> Print
            "printf"                     -> Printf
            "printMembers"               -> PrintMembers
            "private"                    -> Private
            "protected"                  -> Protected
            "Protocol"                   -> Protocol
            "protocol"                   -> EnumProtocol
            "public"                     -> Public
            "quicktype"                  -> Quicktype
            "raise"                      -> Raise
            "range"                      -> Range
            "readonly"                   -> Readonly
            "ref"                        -> Ref
            "RegExp"                     -> RegExp
            "register"                   -> Register
            "reinterpret_cast"           -> ReinterpretCast
            "repeat"                     -> Repeat
            "require"                    -> Require
            "required"                   -> Required
            "requires"                   -> Requires
            "restrict"                   -> Restrict
            "retain"                     -> Retain
            "rethrows"                   -> Rethrows
            "return"                     -> Return
            "right"                      -> Right
            "runtimeType"                -> RuntimeType
            "s"                          -> S
            "sbyte"                      -> Sbyte
            "sealed"                     -> Sealed
            "SEL"                        -> Sel
            "select"                     -> Select
            "Self"                       -> Self
            "Serializable"               -> Serializable
            "self"                       -> EnumSelf
            "Sendable"                   -> Sendable
            "serialize"                  -> Serialize
            "SerialName"                 -> SerialName
            "KSerializer"                -> KSerializer
            "PrimitiveKind"              -> PrimitiveKind
            "SerialDescriptor"           -> SerialDescriptor
            "SerializationFeature"       -> SerializationFeature
            "SerializerProvider"         -> SerializerProvider
            "set"                        -> Set
            "short"                      -> EnumShort
            "signed"                     -> Signed
            "SimpleModule"               -> SimpleModule
            "sizeof"                     -> Sizeof
            "stackalloc"                 -> Stackalloc
            "Standards"                  -> Standards
            "static"                     -> Static
            "static_assert"              -> StaticAssert
            "static_cast"                -> StaticCast
            "StdDeserializer"            -> StdDeserializer
            "StdSerializer"              -> StdSerializer
            "strictfp"                   -> Strictfp
            "string"                     -> EnumString
            "struct"                     -> Struct
            "subscript"                  -> Subscript
            "super"                      -> Super
            "switch"                     -> Switch
            "symbol"                     -> Symbol
            "synchronized"               -> Synchronized
            "system"                     -> EnumSystem
            "template"                   -> Template
            "then"                       -> Then
            "this"                       -> This
            "TextNode"                   -> TextNode
            "thread_local"               -> ThreadLocal
            "throw"                      -> Throw
            "throws"                     -> Throws
            "TimeOnly"                   -> TimeOnly
            "TimeOnlyConverter"          -> TimeOnlyConverter
            "TimeZone"                   -> TimeZone
            "to_json"                    -> ToJSON
            "top_level"                  -> TopLevel
            "toString"                   -> ToString
            "to_dict"                    -> ToDict
            "transient"                  -> Transient
            "True"                       -> True
            "true"                       -> EnumTrue
            "try"                        -> Try
            "Type"                       -> Type
            "type"                       -> EnumType
            "typealias"                  -> Typealias
            "typedef"                    -> Typedef
            "typeid"                     -> Typeid
            "typename"                   -> Typename
            "typeof"                     -> Typeof
            "uint"                       -> Uint
            "ulong"                      -> Ulong
            "unchecked"                  -> Unchecked
            "undefined"                  -> Undefined
            "union"                      -> Union
            "UnmarshalJSON"              -> UnmarshalJSON
            "UseSerializers"             -> UseSerializers
            "unowned"                    -> Unowned
            "unsafe"                     -> Unsafe
            "unsigned"                   -> Unsigned
            "ushort"                     -> Ushort
            "using"                      -> Using
            "Utf8JsonReader"             -> Utf8JSONReader
            "Utf8JsonWriter"             -> Utf8JSONWriter
            "UUID"                       -> UUID
            "var"                        -> Var
            "virtual"                    -> Virtual
            "void"                       -> Void
            "volatile"                   -> Volatile
            "wchar_t"                    -> WcharT
            "weak"                       -> Weak
            "where"                      -> Where
            "while"                      -> While
            "willSet"                    -> WillSet
            "with"                       -> With
            "xor"                        -> Xor
            "xor_eq"                     -> XorEq
            "YES"                        -> Yes
            "yield"                      -> Yield
            "dummy"                      -> Dummy
            else                         -> throw IllegalArgumentException()
        }
    }
}
