// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Obj1;
let _Any;
let _ArrayNode;
let _Bool;
let _BooleanNode;
let _Calendar;
let _Class;
let _Codable;
let _CodingKey;
let _CodingKeys;
let _Empty;
let _BoolClass;
let _Complex;
let _Imaginery;
let _Abstract;
let _Alignas;
let _Alignof;
let _And;
let _AndEq;
let _AnyClass;
let _Array;
let _As;
let _ASM;
let _Assert;
let _Associatedtype;
let _Associativity;
let _Async;
let _Atomic;
let _AtomicCancel;
let _AtomicCommit;
let _AtomicNoexcept;
let _Auto;
let _Await;
let _Base;
let _Bitand;
let _Bitor;
let _Obj1Bool;
let _Boolean;
let _Break;
let _Bycopy;
let _Byref;
let _Byte;
let _Case;
let _Catch;
let _Chan;
let _Char;
let _Char16T;
let _Char32T;
let _Checked;
let _ClassClass;
let _Clone;
let _CoAwait;
let _CoReturn;
let _CoYield;
let _Compl;
let _Concept;
let _Console;
let _Const;
let _ConstCast;
let _Constexpr;
let _Constructor;
let _Continue;
let _Convenience;
let _Convert;
let _Converter;
let _Obj2;
let _CultureInfo;
let _DateFormatter;
let _DateOnly;
let _DateOnlyConverter;
let _DateTime;
let _DateTimeStyles;
let _Decoder;
let _DecodingError;
let _DeserializationFeature;
let _DoubleNode;
let _Encoder;
let _EnumValues;
let _Equatable;
let _False;
let _FormatException;
let _Date;
let _DateParseHandling;
let _Debugger;
let _Decimal;
let _Declare;
let _Decltype;
let _DecodeString;
let _Def;
let _Default;
let _Defer;
let _Deinit;
let _Del;
let _Delegate;
let _Delete;
let _Dict;
let _Dictionary;
let _DidSet;
let _Do;
let _Double;
let _Dynamic;
let _DynamicCast;
let _Elif;
let _Else;
let _EncodeQuickType;
let _Enum;
let _EqualityContract;
let _Event;
let _Except;
let _Exception;
let _Explicit;
let _Export;
let _Exposing;
let _Extends;
let _Extension;
let _Extern;
let _Fallthrough;
let _FalseClass;
let _Fileprivate;
let _Final;
let _Finally;
let _Fixed;
let _Float;
let _For;
let _Foreach;
let _Friend;
let _From;
let _FromDict;
let _FromJSON;
let _Func;
let _Obj3;
let _Hashable;
let _Hasher;
let _Imp;
let _IntNode;
let _ISODateTimeOffsetConverter;
let _JSONAny;
let _JSONCodingKey;
let _JSONDecoder;
let _JSONEncoder;
let _JSONNull;
let _JSONException;
let _JSONGenerator;
let _JSONNode;
let _JSONParser;
let _JSONReader;
let _JSONTokenType;
let _LocalDate;
let _Locale;
let _LongNode;
let _MapEntry;
let _MarshalJSON;
let _Function;
let _Get;
let _Global;
let _Go;
let _Goto;
let _Guard;
let _HasOwnProperty;
let _HashCode;
let _ID;
let _If;
let _Implements;
let _Implicit;
let _Import;
let _In;
let _Indirect;
let _Infix;
let _Init;
let _Inline;
let _Inout;
let _Instanceof;
let _Int;
let _Interface;
let _Internal;
let _Is;
let _Iterable;
let _Jdec;
let _Jenc;
let _Jpipe;
let _JSON;
let _JSONConverter;
let _JSONSerializer;
let _JSONToken;
let _JSONWriter;
let _Lambda;
let _Lazy;
let _Left;
let _Let;
let _List;
let _Lock;
let _Long;
let _Map;
let _MetadataPropertyHandling;
let _Module;
let _Obj4;
let _No;
let _NSError;
let _NSObject;
let _NSString;
let _Null;
let _None;
let _NullNode;
let _ObjectMapper;
let _ObjectNode;
let _ObjectReader;
let _ObjectWriter;
let _OffsetDateTime;
let _OffsetTime;
let _Protocol;
let _RegExp;
let _Mutable;
let _Mutating;
let _Namespace;
let _Native;
let _New;
let _Newtonsoft;
let _Nil;
let _NoSuchMethod;
let _Noexcept;
let _Nonatomic;
let _NoneClass;
let _Nonlocal;
let _Nonmutating;
let _Not;
let _NotEq;
let _NullClass;
let _Nullptr;
let _Number;
let _Object;
let _Of;
let _Oneway;
let _Open;
let _Operator;
let _Optional;
let _Or;
let _OrEq;
let _Out;
let _Override;
let _Package;
let _Params;
let _Pass;
let _Port;
let _Postfix;
let _Precedence;
let _Prefix;
let _Print;
let _PrintMembers;
let _Printf;
let _Private;
let _Protected;
let _ProtocolClass;
let _Public;
let _Quicktype;
let _Raise;
let _Range;
let _Readonly;
let _Ref;
let _Register;
let _ReinterpretCast;
let _Obj5;
let _KSerializer;
let _PrimitiveKind;
let _Sel;
let _Self;
let _Sendable;
let _SerialDescriptor;
let _SerialName;
let _Serializable;
let _SerializationFeature;
let _SerializerProvider;
let _SimpleModule;
let _Standards;
let _StdDeserializer;
let _StdSerializer;
let _TextNode;
let _TimeOnly;
let _TimeOnlyConverter;
let _TimeZone;
let _True;
let _Repeat;
let _Require;
let _Required;
let _Requires;
let _Restrict;
let _Retain;
let _Rethrows;
let _Return;
let _Right;
let _RuntimeType;
let _S;
let _Sbyte;
let _Sealed;
let _Select;
let _SelfClass;
let _Serialize;
let _Set;
let _Short;
let _Signed;
let _Sizeof;
let _Stackalloc;
let _Static;
let _StaticAssert;
let _StaticCast;
let _Strictfp;
let _String;
let _Struct;
let _Subscript;
let _Super;
let _Switch;
let _Symbol;
let _Synchronized;
let _System;
let _Template;
let _Then;
let _This;
let _ThreadLocal;
let _Throw;
let _Throws;
let _ToString;
let _ToDict;
let _ToJSON;
let _TopLevelClass;
let _Transient;
let _TrueClass;
let _Obj6;
let _Type;
let _UUID;
let _UnmarshalJSON;
let _UseSerializers;
let _Utf8JSONReader;
let _Utf8JSONWriter;
let _Yes;
let _Try;
let _TypeClass;
let _Typealias;
let _Typedef;
let _Typeid;
let _Typename;
let _Typeof;
let _Uint;
let _Ulong;
let _Unchecked;
let _Undefined;
let _Union;
let _Unowned;
let _Unsafe;
let _Unsigned;
let _Ushort;
let _Using;
let _Var;
let _Virtual;
let _Void;
let _Volatile;
let _WcharT;
let _Weak;
let _Where;
let _While;
let _WillSet;
let _With;
let _Xor;
let _XorEq;
let _Yield;
const _EnumValue = PropTypes.oneOf(['ready', 'done']);
_Any = PropTypes.shape({
    "Any": PropTypes.oneOfType([Integer]).isRequired,
});
_ArrayNode = PropTypes.shape({
    "ArrayNode": PropTypes.oneOfType([Integer]).isRequired,
});
_Bool = PropTypes.shape({
    "BOOL": PropTypes.oneOfType([Integer]).isRequired,
});
_BooleanNode = PropTypes.shape({
    "BooleanNode": PropTypes.oneOfType([Integer]).isRequired,
});
_Calendar = PropTypes.shape({
    "Calendar": PropTypes.oneOfType([Integer]).isRequired,
});
_Class = PropTypes.shape({
    "Class": PropTypes.oneOfType([Integer]).isRequired,
});
_Codable = PropTypes.shape({
    "Codable": PropTypes.oneOfType([Integer]).isRequired,
});
_CodingKey = PropTypes.shape({
    "CodingKey": PropTypes.oneOfType([Integer]).isRequired,
});
_CodingKeys = PropTypes.shape({
    "CodingKeys": PropTypes.oneOfType([Integer]).isRequired,
});
_Empty = PropTypes.shape({
    "_": PropTypes.oneOfType([Integer]).isRequired,
});
_BoolClass = PropTypes.shape({
    "_Bool": PropTypes.oneOfType([Integer]).isRequired,
});
_Complex = PropTypes.shape({
    "_Complex": PropTypes.oneOfType([Integer]).isRequired,
});
_Imaginery = PropTypes.shape({
    "_Imaginery": PropTypes.oneOfType([Integer]).isRequired,
});
_Abstract = PropTypes.shape({
    "abstract": PropTypes.oneOfType([Integer]).isRequired,
});
_Alignas = PropTypes.shape({
    "alignas": PropTypes.oneOfType([Integer]).isRequired,
});
_Alignof = PropTypes.shape({
    "alignof": PropTypes.oneOfType([Integer]).isRequired,
});
_And = PropTypes.shape({
    "and": PropTypes.oneOfType([Integer]).isRequired,
});
_AndEq = PropTypes.shape({
    "and_eq": PropTypes.oneOfType([Integer]).isRequired,
});
_AnyClass = PropTypes.shape({
    "any": PropTypes.oneOfType([Integer]).isRequired,
});
_Array = PropTypes.shape({
    "array": PropTypes.oneOfType([Integer]).isRequired,
});
_As = PropTypes.shape({
    "as": PropTypes.oneOfType([Integer]).isRequired,
});
_ASM = PropTypes.shape({
    "asm": PropTypes.oneOfType([Integer]).isRequired,
});
_Assert = PropTypes.shape({
    "assert": PropTypes.oneOfType([Integer]).isRequired,
});
_Associatedtype = PropTypes.shape({
    "associatedtype": PropTypes.oneOfType([Integer]).isRequired,
});
_Associativity = PropTypes.shape({
    "associativity": PropTypes.oneOfType([Integer]).isRequired,
});
_Async = PropTypes.shape({
    "async": PropTypes.oneOfType([Integer]).isRequired,
});
_Atomic = PropTypes.shape({
    "atomic": PropTypes.oneOfType([Integer]).isRequired,
});
_AtomicCancel = PropTypes.shape({
    "atomic_cancel": PropTypes.oneOfType([Integer]).isRequired,
});
_AtomicCommit = PropTypes.shape({
    "atomic_commit": PropTypes.oneOfType([Integer]).isRequired,
});
_AtomicNoexcept = PropTypes.shape({
    "atomic_noexcept": PropTypes.oneOfType([Integer]).isRequired,
});
_Auto = PropTypes.shape({
    "auto": PropTypes.oneOfType([Integer]).isRequired,
});
_Await = PropTypes.shape({
    "await": PropTypes.oneOfType([Integer]).isRequired,
});
_Base = PropTypes.shape({
    "base": PropTypes.oneOfType([Integer]).isRequired,
});
_Bitand = PropTypes.shape({
    "bitand": PropTypes.oneOfType([Integer]).isRequired,
});
_Bitor = PropTypes.shape({
    "bitor": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj1Bool = PropTypes.shape({
    "bool": PropTypes.oneOfType([Integer]).isRequired,
});
_Boolean = PropTypes.shape({
    "boolean": PropTypes.oneOfType([Integer]).isRequired,
});
_Break = PropTypes.shape({
    "break": PropTypes.oneOfType([Integer]).isRequired,
});
_Bycopy = PropTypes.shape({
    "bycopy": PropTypes.oneOfType([Integer]).isRequired,
});
_Byref = PropTypes.shape({
    "byref": PropTypes.oneOfType([Integer]).isRequired,
});
_Byte = PropTypes.shape({
    "byte": PropTypes.oneOfType([Integer]).isRequired,
});
_Case = PropTypes.shape({
    "case": PropTypes.oneOfType([Integer]).isRequired,
});
_Catch = PropTypes.shape({
    "catch": PropTypes.oneOfType([Integer]).isRequired,
});
_Chan = PropTypes.shape({
    "chan": PropTypes.oneOfType([Integer]).isRequired,
});
_Char = PropTypes.shape({
    "char": PropTypes.oneOfType([Integer]).isRequired,
});
_Char16T = PropTypes.shape({
    "char16_t": PropTypes.oneOfType([Integer]).isRequired,
});
_Char32T = PropTypes.shape({
    "char32_t": PropTypes.oneOfType([Integer]).isRequired,
});
_Checked = PropTypes.shape({
    "checked": PropTypes.oneOfType([Integer]).isRequired,
});
_ClassClass = PropTypes.shape({
    "class": PropTypes.oneOfType([Integer]).isRequired,
});
_Clone = PropTypes.shape({
    "clone": PropTypes.oneOfType([Integer]).isRequired,
});
_CoAwait = PropTypes.shape({
    "co_await": PropTypes.oneOfType([Integer]).isRequired,
});
_CoReturn = PropTypes.shape({
    "co_return": PropTypes.oneOfType([Integer]).isRequired,
});
_CoYield = PropTypes.shape({
    "co_yield": PropTypes.oneOfType([Integer]).isRequired,
});
_Compl = PropTypes.shape({
    "compl": PropTypes.oneOfType([Integer]).isRequired,
});
_Concept = PropTypes.shape({
    "concept": PropTypes.oneOfType([Integer]).isRequired,
});
_Console = PropTypes.shape({
    "console": PropTypes.oneOfType([Integer]).isRequired,
});
_Const = PropTypes.shape({
    "const": PropTypes.oneOfType([Integer]).isRequired,
});
_ConstCast = PropTypes.shape({
    "const_cast": PropTypes.oneOfType([Integer]).isRequired,
});
_Constexpr = PropTypes.shape({
    "constexpr": PropTypes.oneOfType([Integer]).isRequired,
});
_Constructor = PropTypes.shape({
    "constructor": PropTypes.oneOfType([Integer]).isRequired,
});
_Continue = PropTypes.shape({
    "continue": PropTypes.oneOfType([Integer]).isRequired,
});
_Convenience = PropTypes.shape({
    "convenience": PropTypes.oneOfType([Integer]).isRequired,
});
_Convert = PropTypes.shape({
    "convert": PropTypes.oneOfType([Integer]).isRequired,
});
_Converter = PropTypes.shape({
    "converter": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj1 = PropTypes.shape({
    "Any": _Any,
    "ArrayNode": _ArrayNode,
    "BOOL": _Bool,
    "BooleanNode": _BooleanNode,
    "Calendar": _Calendar,
    "Class": _Class,
    "Codable": _Codable,
    "CodingKey": _CodingKey,
    "CodingKeys": _CodingKeys,
    "_": _Empty,
    "_Bool": _BoolClass,
    "_Complex": _Complex,
    "_Imaginery": _Imaginery,
    "abstract": _Abstract,
    "alignas": _Alignas,
    "alignof": _Alignof,
    "and": _And,
    "and_eq": _AndEq,
    "any": _AnyClass,
    "array": _Array,
    "as": _As,
    "asm": _ASM,
    "assert": _Assert,
    "associatedtype": _Associatedtype,
    "associativity": _Associativity,
    "async": _Async,
    "atomic": _Atomic,
    "atomic_cancel": _AtomicCancel,
    "atomic_commit": _AtomicCommit,
    "atomic_noexcept": _AtomicNoexcept,
    "auto": _Auto,
    "await": _Await,
    "base": _Base,
    "bitand": _Bitand,
    "bitor": _Bitor,
    "bool": _Obj1Bool,
    "boolean": _Boolean,
    "break": _Break,
    "bycopy": _Bycopy,
    "byref": _Byref,
    "byte": _Byte,
    "case": _Case,
    "catch": _Catch,
    "chan": _Chan,
    "char": _Char,
    "char16_t": _Char16T,
    "char32_t": _Char32T,
    "checked": _Checked,
    "class": _ClassClass,
    "clone": _Clone,
    "co_await": _CoAwait,
    "co_return": _CoReturn,
    "co_yield": _CoYield,
    "compl": _Compl,
    "concept": _Concept,
    "console": _Console,
    "const": _Const,
    "const_cast": _ConstCast,
    "constexpr": _Constexpr,
    "constructor": _Constructor,
    "continue": _Continue,
    "convenience": _Convenience,
    "convert": _Convert,
    "converter": _Converter,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
});
_CultureInfo = PropTypes.shape({
    "CultureInfo": PropTypes.oneOfType([Integer]).isRequired,
});
_DateFormatter = PropTypes.shape({
    "DateFormatter": PropTypes.oneOfType([Integer]).isRequired,
});
_DateOnly = PropTypes.shape({
    "DateOnly": PropTypes.oneOfType([Integer]).isRequired,
});
_DateOnlyConverter = PropTypes.shape({
    "DateOnlyConverter": PropTypes.oneOfType([Integer]).isRequired,
});
_DateTime = PropTypes.shape({
    "DateTime": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
});
_DateTimeStyles = PropTypes.shape({
    "DateTimeStyles": PropTypes.oneOfType([Integer]).isRequired,
});
_Decoder = PropTypes.shape({
    "Decoder": PropTypes.oneOfType([Integer]).isRequired,
});
_DecodingError = PropTypes.shape({
    "DecodingError": PropTypes.oneOfType([Integer]).isRequired,
});
_DeserializationFeature = PropTypes.shape({
    "DeserializationFeature": PropTypes.oneOfType([Integer]).isRequired,
});
_DoubleNode = PropTypes.shape({
    "DoubleNode": PropTypes.oneOfType([Integer]).isRequired,
});
_Encoder = PropTypes.shape({
    "Encoder": PropTypes.oneOfType([Integer]).isRequired,
});
_EnumValues = PropTypes.shape({
    "EnumValues": PropTypes.oneOfType([PropTypes.arrayOf(_EnumValue)]).isRequired,
});
_Equatable = PropTypes.shape({
    "Equatable": PropTypes.oneOfType([Integer]).isRequired,
});
_False = PropTypes.shape({
    "False": PropTypes.oneOfType([Integer]).isRequired,
});
_FormatException = PropTypes.shape({
    "FormatException": PropTypes.oneOfType([Integer]).isRequired,
});
_Date = PropTypes.shape({
    "date": PropTypes.oneOfType([Integer]).isRequired,
});
_DateParseHandling = PropTypes.shape({
    "date_parse_handling": PropTypes.oneOfType([Integer]).isRequired,
});
_Debugger = PropTypes.shape({
    "debugger": PropTypes.oneOfType([Integer]).isRequired,
});
_Decimal = PropTypes.shape({
    "decimal": PropTypes.oneOfType([Integer]).isRequired,
});
_Declare = PropTypes.shape({
    "declare": PropTypes.oneOfType([Integer]).isRequired,
});
_Decltype = PropTypes.shape({
    "decltype": PropTypes.oneOfType([Integer]).isRequired,
});
_DecodeString = PropTypes.shape({
    "decode_string": PropTypes.oneOfType([Integer]).isRequired,
});
_Def = PropTypes.shape({
    "def": PropTypes.oneOfType([Integer]).isRequired,
});
_Default = PropTypes.shape({
    "default": PropTypes.oneOfType([Integer]).isRequired,
});
_Defer = PropTypes.shape({
    "defer": PropTypes.oneOfType([Integer]).isRequired,
});
_Deinit = PropTypes.shape({
    "deinit": PropTypes.oneOfType([Integer]).isRequired,
});
_Del = PropTypes.shape({
    "del": PropTypes.oneOfType([Integer]).isRequired,
});
_Delegate = PropTypes.shape({
    "delegate": PropTypes.oneOfType([Integer]).isRequired,
});
_Delete = PropTypes.shape({
    "delete": PropTypes.oneOfType([Integer]).isRequired,
});
_Dict = PropTypes.shape({
    "dict": PropTypes.oneOfType([Integer]).isRequired,
});
_Dictionary = PropTypes.shape({
    "dictionary": PropTypes.oneOfType([Integer]).isRequired,
});
_DidSet = PropTypes.shape({
    "didSet": PropTypes.oneOfType([Integer]).isRequired,
});
_Do = PropTypes.shape({
    "do": PropTypes.oneOfType([Integer]).isRequired,
});
_Double = PropTypes.shape({
    "double": PropTypes.oneOfType([Integer]).isRequired,
});
_Dynamic = PropTypes.shape({
    "dynamic": PropTypes.oneOfType([Integer]).isRequired,
});
_DynamicCast = PropTypes.shape({
    "dynamic_cast": PropTypes.oneOfType([Integer]).isRequired,
});
_Elif = PropTypes.shape({
    "elif": PropTypes.oneOfType([Integer]).isRequired,
});
_Else = PropTypes.shape({
    "else": PropTypes.oneOfType([Integer]).isRequired,
});
_EncodeQuickType = PropTypes.shape({
    "encode_quick_type": PropTypes.oneOfType([Integer]).isRequired,
});
_Enum = PropTypes.shape({
    "enum": PropTypes.oneOfType([Integer]).isRequired,
});
_EqualityContract = PropTypes.shape({
    "equalityContract": PropTypes.oneOfType([Integer]).isRequired,
});
_Event = PropTypes.shape({
    "event": PropTypes.oneOfType([Integer]).isRequired,
});
_Except = PropTypes.shape({
    "except": PropTypes.oneOfType([Integer]).isRequired,
});
_Exception = PropTypes.shape({
    "exception": PropTypes.oneOfType([Integer]).isRequired,
});
_Explicit = PropTypes.shape({
    "explicit": PropTypes.oneOfType([Integer]).isRequired,
});
_Export = PropTypes.shape({
    "export": PropTypes.oneOfType([Integer]).isRequired,
});
_Exposing = PropTypes.shape({
    "exposing": PropTypes.oneOfType([Integer]).isRequired,
});
_Extends = PropTypes.shape({
    "extends": PropTypes.oneOfType([Integer]).isRequired,
});
_Extension = PropTypes.shape({
    "extension": PropTypes.oneOfType([Integer]).isRequired,
});
_Extern = PropTypes.shape({
    "extern": PropTypes.oneOfType([Integer]).isRequired,
});
_Fallthrough = PropTypes.shape({
    "fallthrough": PropTypes.oneOfType([Integer]).isRequired,
});
_FalseClass = PropTypes.shape({
    "false": PropTypes.oneOfType([Integer]).isRequired,
});
_Fileprivate = PropTypes.shape({
    "fileprivate": PropTypes.oneOfType([Integer]).isRequired,
});
_Final = PropTypes.shape({
    "final": PropTypes.oneOfType([Integer]).isRequired,
});
_Finally = PropTypes.shape({
    "finally": PropTypes.oneOfType([Integer]).isRequired,
});
_Fixed = PropTypes.shape({
    "fixed": PropTypes.oneOfType([Integer]).isRequired,
});
_Float = PropTypes.shape({
    "float": PropTypes.oneOfType([Integer]).isRequired,
});
_For = PropTypes.shape({
    "for": PropTypes.oneOfType([Integer]).isRequired,
});
_Foreach = PropTypes.shape({
    "foreach": PropTypes.oneOfType([Integer]).isRequired,
});
_Friend = PropTypes.shape({
    "friend": PropTypes.oneOfType([Integer]).isRequired,
});
_From = PropTypes.shape({
    "from": PropTypes.oneOfType([Integer]).isRequired,
});
_FromDict = PropTypes.shape({
    "from_dict": PropTypes.oneOfType([Integer]).isRequired,
});
_FromJSON = PropTypes.shape({
    "from_json": PropTypes.oneOfType([Integer]).isRequired,
});
_Func = PropTypes.shape({
    "func": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj2 = PropTypes.shape({
    "CultureInfo": _CultureInfo,
    "DateFormatter": _DateFormatter,
    "DateOnly": _DateOnly,
    "DateOnlyConverter": _DateOnlyConverter,
    "DateTime": _DateTime,
    "DateTimeStyles": _DateTimeStyles,
    "Decoder": _Decoder,
    "DecodingError": _DecodingError,
    "DeserializationFeature": _DeserializationFeature,
    "DoubleNode": _DoubleNode,
    "Encoder": _Encoder,
    "EnumValues": _EnumValues,
    "Equatable": _Equatable,
    "False": _False,
    "FormatException": _FormatException,
    "date": _Date,
    "date_parse_handling": _DateParseHandling,
    "debugger": _Debugger,
    "decimal": _Decimal,
    "declare": _Declare,
    "decltype": _Decltype,
    "decode_string": _DecodeString,
    "def": _Def,
    "default": _Default,
    "defer": _Defer,
    "deinit": _Deinit,
    "del": _Del,
    "delegate": _Delegate,
    "delete": _Delete,
    "dict": _Dict,
    "dictionary": _Dictionary,
    "didSet": _DidSet,
    "do": _Do,
    "double": _Double,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "dynamic": _Dynamic,
    "dynamic_cast": _DynamicCast,
    "elif": _Elif,
    "else": _Else,
    "encode_quick_type": _EncodeQuickType,
    "enum": _Enum,
    "equalityContract": _EqualityContract,
    "event": _Event,
    "except": _Except,
    "exception": _Exception,
    "explicit": _Explicit,
    "export": _Export,
    "exposing": _Exposing,
    "extends": _Extends,
    "extension": _Extension,
    "extern": _Extern,
    "fallthrough": _Fallthrough,
    "false": _FalseClass,
    "fileprivate": _Fileprivate,
    "final": _Final,
    "finally": _Finally,
    "fixed": _Fixed,
    "float": _Float,
    "for": _For,
    "foreach": _Foreach,
    "friend": _Friend,
    "from": _From,
    "from_dict": _FromDict,
    "from_json": _FromJSON,
    "func": _Func,
});
_Hashable = PropTypes.shape({
    "Hashable": PropTypes.oneOfType([Integer]).isRequired,
});
_Hasher = PropTypes.shape({
    "Hasher": PropTypes.oneOfType([Integer]).isRequired,
});
_Imp = PropTypes.shape({
    "IMP": PropTypes.oneOfType([Integer]).isRequired,
});
_IntNode = PropTypes.shape({
    "IntNode": PropTypes.oneOfType([Integer]).isRequired,
});
_ISODateTimeOffsetConverter = PropTypes.shape({
    "IsoDateTimeOffsetConverter": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONAny = PropTypes.shape({
    "JSONAny": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
});
_JSONCodingKey = PropTypes.shape({
    "JSONCodingKey": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONDecoder = PropTypes.shape({
    "JSONDecoder": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONEncoder = PropTypes.shape({
    "JSONEncoder": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONNull = PropTypes.shape({
    "JSONNull": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONException = PropTypes.shape({
    "JsonException": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONGenerator = PropTypes.shape({
    "JsonGenerator": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONNode = PropTypes.shape({
    "JsonNode": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONParser = PropTypes.shape({
    "JsonParser": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONReader = PropTypes.shape({
    "JsonReader": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONTokenType = PropTypes.shape({
    "JsonTokenType": PropTypes.oneOfType([Integer]).isRequired,
});
_LocalDate = PropTypes.shape({
    "LocalDate": PropTypes.oneOfType([Integer]).isRequired,
});
_Locale = PropTypes.shape({
    "Locale": PropTypes.oneOfType([Integer]).isRequired,
});
_LongNode = PropTypes.shape({
    "LongNode": PropTypes.oneOfType([Integer]).isRequired,
});
_MapEntry = PropTypes.shape({
    "MapEntry": PropTypes.oneOfType([Integer]).isRequired,
});
_MarshalJSON = PropTypes.shape({
    "MarshalJSON": PropTypes.oneOfType([Integer]).isRequired,
});
_Function = PropTypes.shape({
    "function": PropTypes.oneOfType([Integer]).isRequired,
});
_Get = PropTypes.shape({
    "get": PropTypes.oneOfType([Integer]).isRequired,
});
_Global = PropTypes.shape({
    "global": PropTypes.oneOfType([Integer]).isRequired,
});
_Go = PropTypes.shape({
    "go": PropTypes.oneOfType([Integer]).isRequired,
});
_Goto = PropTypes.shape({
    "goto": PropTypes.oneOfType([Integer]).isRequired,
});
_Guard = PropTypes.shape({
    "guard": PropTypes.oneOfType([Integer]).isRequired,
});
_HasOwnProperty = PropTypes.shape({
    "hasOwnProperty": PropTypes.oneOfType([Integer]).isRequired,
});
_HashCode = PropTypes.shape({
    "hashCode": PropTypes.oneOfType([Integer]).isRequired,
});
_ID = PropTypes.shape({
    "id": PropTypes.oneOfType([Integer]).isRequired,
});
_If = PropTypes.shape({
    "if": PropTypes.oneOfType([Integer]).isRequired,
});
_Implements = PropTypes.shape({
    "implements": PropTypes.oneOfType([Integer]).isRequired,
});
_Implicit = PropTypes.shape({
    "implicit": PropTypes.oneOfType([Integer]).isRequired,
});
_Import = PropTypes.shape({
    "import": PropTypes.oneOfType([Integer]).isRequired,
});
_In = PropTypes.shape({
    "in": PropTypes.oneOfType([Integer]).isRequired,
});
_Indirect = PropTypes.shape({
    "indirect": PropTypes.oneOfType([Integer]).isRequired,
});
_Infix = PropTypes.shape({
    "infix": PropTypes.oneOfType([Integer]).isRequired,
});
_Init = PropTypes.shape({
    "init": PropTypes.oneOfType([Integer]).isRequired,
});
_Inline = PropTypes.shape({
    "inline": PropTypes.oneOfType([Integer]).isRequired,
});
_Inout = PropTypes.shape({
    "inout": PropTypes.oneOfType([Integer]).isRequired,
});
_Instanceof = PropTypes.shape({
    "instanceof": PropTypes.oneOfType([Integer]).isRequired,
});
_Int = PropTypes.shape({
    "int": PropTypes.oneOfType([Integer]).isRequired,
});
_Interface = PropTypes.shape({
    "interface": PropTypes.oneOfType([Integer]).isRequired,
});
_Internal = PropTypes.shape({
    "internal": PropTypes.oneOfType([Integer]).isRequired,
});
_Is = PropTypes.shape({
    "is": PropTypes.oneOfType([Integer]).isRequired,
});
_Iterable = PropTypes.shape({
    "iterable": PropTypes.oneOfType([Integer]).isRequired,
});
_Jdec = PropTypes.shape({
    "jdec": PropTypes.oneOfType([Integer]).isRequired,
});
_Jenc = PropTypes.shape({
    "jenc": PropTypes.oneOfType([Integer]).isRequired,
});
_Jpipe = PropTypes.shape({
    "jpipe": PropTypes.oneOfType([Integer]).isRequired,
});
_JSON = PropTypes.shape({
    "json": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONConverter = PropTypes.shape({
    "json_converter": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONSerializer = PropTypes.shape({
    "json_serializer": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONToken = PropTypes.shape({
    "json_token": PropTypes.oneOfType([Integer]).isRequired,
});
_JSONWriter = PropTypes.shape({
    "json_writer": PropTypes.oneOfType([Integer]).isRequired,
});
_Lambda = PropTypes.shape({
    "lambda": PropTypes.oneOfType([Integer]).isRequired,
});
_Lazy = PropTypes.shape({
    "lazy": PropTypes.oneOfType([Integer]).isRequired,
});
_Left = PropTypes.shape({
    "left": PropTypes.oneOfType([Integer]).isRequired,
});
_Let = PropTypes.shape({
    "let": PropTypes.oneOfType([Integer]).isRequired,
});
_List = PropTypes.shape({
    "list": PropTypes.oneOfType([Integer]).isRequired,
});
_Lock = PropTypes.shape({
    "lock": PropTypes.oneOfType([Integer]).isRequired,
});
_Long = PropTypes.shape({
    "long": PropTypes.oneOfType([Integer]).isRequired,
});
_Map = PropTypes.shape({
    "map": PropTypes.oneOfType([Integer]).isRequired,
});
_MetadataPropertyHandling = PropTypes.shape({
    "metadata_property_handling": PropTypes.oneOfType([Integer]).isRequired,
});
_Module = PropTypes.shape({
    "module": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj3 = PropTypes.shape({
    "Hashable": _Hashable,
    "Hasher": _Hasher,
    "IMP": _Imp,
    "IntNode": _IntNode,
    "IsoDateTimeOffsetConverter": _ISODateTimeOffsetConverter,
    "JSONAny": _JSONAny,
    "JSONCodingKey": _JSONCodingKey,
    "JSONDecoder": _JSONDecoder,
    "JSONEncoder": _JSONEncoder,
    "JSONNull": _JSONNull,
    "JsonException": _JSONException,
    "JsonGenerator": _JSONGenerator,
    "JsonNode": _JSONNode,
    "JsonParser": _JSONParser,
    "JsonReader": _JSONReader,
    "JsonTokenType": _JSONTokenType,
    "LocalDate": _LocalDate,
    "Locale": _Locale,
    "LongNode": _LongNode,
    "MapEntry": _MapEntry,
    "MarshalJSON": _MarshalJSON,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "function": _Function,
    "get": _Get,
    "global": _Global,
    "go": _Go,
    "goto": _Goto,
    "guard": _Guard,
    "hasOwnProperty": _HasOwnProperty,
    "hashCode": _HashCode,
    "id": _ID,
    "if": _If,
    "implements": _Implements,
    "implicit": _Implicit,
    "import": _Import,
    "in": _In,
    "indirect": _Indirect,
    "infix": _Infix,
    "init": _Init,
    "inline": _Inline,
    "inout": _Inout,
    "instanceof": _Instanceof,
    "int": _Int,
    "interface": _Interface,
    "internal": _Internal,
    "is": _Is,
    "iterable": _Iterable,
    "jdec": _Jdec,
    "jenc": _Jenc,
    "jpipe": _Jpipe,
    "json": _JSON,
    "json_converter": _JSONConverter,
    "json_serializer": _JSONSerializer,
    "json_token": _JSONToken,
    "json_writer": _JSONWriter,
    "lambda": _Lambda,
    "lazy": _Lazy,
    "left": _Left,
    "let": _Let,
    "list": _List,
    "lock": _Lock,
    "long": _Long,
    "map": _Map,
    "metadata_property_handling": _MetadataPropertyHandling,
    "module": _Module,
});
_No = PropTypes.shape({
    "NO": PropTypes.oneOfType([Integer]).isRequired,
});
_NSError = PropTypes.shape({
    "NSError": PropTypes.oneOfType([Integer]).isRequired,
});
_NSObject = PropTypes.shape({
    "NSObject": PropTypes.oneOfType([Integer]).isRequired,
});
_NSString = PropTypes.shape({
    "NSString": PropTypes.oneOfType([Integer]).isRequired,
});
_Null = PropTypes.shape({
    "NULL": PropTypes.oneOfType([Integer]).isRequired,
});
_None = PropTypes.shape({
    "None": PropTypes.oneOfType([Integer]).isRequired,
});
_NullNode = PropTypes.shape({
    "NullNode": PropTypes.oneOfType([Integer]).isRequired,
});
_ObjectMapper = PropTypes.shape({
    "ObjectMapper": PropTypes.oneOfType([Integer]).isRequired,
});
_ObjectNode = PropTypes.shape({
    "ObjectNode": PropTypes.oneOfType([Integer]).isRequired,
});
_ObjectReader = PropTypes.shape({
    "ObjectReader": PropTypes.oneOfType([Integer]).isRequired,
});
_ObjectWriter = PropTypes.shape({
    "ObjectWriter": PropTypes.oneOfType([Integer]).isRequired,
});
_OffsetDateTime = PropTypes.shape({
    "OffsetDateTime": PropTypes.oneOfType([Integer]).isRequired,
});
_OffsetTime = PropTypes.shape({
    "OffsetTime": PropTypes.oneOfType([Integer]).isRequired,
});
_Protocol = PropTypes.shape({
    "Protocol": PropTypes.oneOfType([Integer]).isRequired,
});
_RegExp = PropTypes.shape({
    "RegExp": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
});
_Mutable = PropTypes.shape({
    "mutable": PropTypes.oneOfType([Integer]).isRequired,
});
_Mutating = PropTypes.shape({
    "mutating": PropTypes.oneOfType([Integer]).isRequired,
});
_Namespace = PropTypes.shape({
    "namespace": PropTypes.oneOfType([Integer]).isRequired,
});
_Native = PropTypes.shape({
    "native": PropTypes.oneOfType([Integer]).isRequired,
});
_New = PropTypes.shape({
    "new": PropTypes.oneOfType([Integer]).isRequired,
});
_Newtonsoft = PropTypes.shape({
    "newtonsoft": PropTypes.oneOfType([Integer]).isRequired,
});
_Nil = PropTypes.shape({
    "nil": PropTypes.oneOfType([Integer]).isRequired,
});
_NoSuchMethod = PropTypes.shape({
    "noSuchMethod": PropTypes.oneOfType([Integer]).isRequired,
});
_Noexcept = PropTypes.shape({
    "noexcept": PropTypes.oneOfType([Integer]).isRequired,
});
_Nonatomic = PropTypes.shape({
    "nonatomic": PropTypes.oneOfType([Integer]).isRequired,
});
_NoneClass = PropTypes.shape({
    "none": PropTypes.oneOfType([Integer]).isRequired,
});
_Nonlocal = PropTypes.shape({
    "nonlocal": PropTypes.oneOfType([Integer]).isRequired,
});
_Nonmutating = PropTypes.shape({
    "nonmutating": PropTypes.oneOfType([Integer]).isRequired,
});
_Not = PropTypes.shape({
    "not": PropTypes.oneOfType([Integer]).isRequired,
});
_NotEq = PropTypes.shape({
    "not_eq": PropTypes.oneOfType([Integer]).isRequired,
});
_NullClass = PropTypes.shape({
    "null": PropTypes.oneOfType([Integer]).isRequired,
});
_Nullptr = PropTypes.shape({
    "nullptr": PropTypes.oneOfType([Integer]).isRequired,
});
_Number = PropTypes.shape({
    "number": PropTypes.oneOfType([Integer]).isRequired,
});
_Object = PropTypes.shape({
    "object": PropTypes.oneOfType([Integer]).isRequired,
});
_Of = PropTypes.shape({
    "of": PropTypes.oneOfType([Integer]).isRequired,
});
_Oneway = PropTypes.shape({
    "oneway": PropTypes.oneOfType([Integer]).isRequired,
});
_Open = PropTypes.shape({
    "open": PropTypes.oneOfType([Integer]).isRequired,
});
_Operator = PropTypes.shape({
    "operator": PropTypes.oneOfType([Integer]).isRequired,
});
_Optional = PropTypes.shape({
    "optional": PropTypes.oneOfType([Integer]).isRequired,
});
_Or = PropTypes.shape({
    "or": PropTypes.oneOfType([Integer]).isRequired,
});
_OrEq = PropTypes.shape({
    "or_eq": PropTypes.oneOfType([Integer]).isRequired,
});
_Out = PropTypes.shape({
    "out": PropTypes.oneOfType([Integer]).isRequired,
});
_Override = PropTypes.shape({
    "override": PropTypes.oneOfType([Integer]).isRequired,
});
_Package = PropTypes.shape({
    "package": PropTypes.oneOfType([Integer]).isRequired,
});
_Params = PropTypes.shape({
    "params": PropTypes.oneOfType([Integer]).isRequired,
});
_Pass = PropTypes.shape({
    "pass": PropTypes.oneOfType([Integer]).isRequired,
});
_Port = PropTypes.shape({
    "port": PropTypes.oneOfType([Integer]).isRequired,
});
_Postfix = PropTypes.shape({
    "postfix": PropTypes.oneOfType([Integer]).isRequired,
});
_Precedence = PropTypes.shape({
    "precedence": PropTypes.oneOfType([Integer]).isRequired,
});
_Prefix = PropTypes.shape({
    "prefix": PropTypes.oneOfType([Integer]).isRequired,
});
_Print = PropTypes.shape({
    "print": PropTypes.oneOfType([Integer]).isRequired,
});
_PrintMembers = PropTypes.shape({
    "printMembers": PropTypes.oneOfType([Integer]).isRequired,
});
_Printf = PropTypes.shape({
    "printf": PropTypes.oneOfType([Integer]).isRequired,
});
_Private = PropTypes.shape({
    "private": PropTypes.oneOfType([Integer]).isRequired,
});
_Protected = PropTypes.shape({
    "protected": PropTypes.oneOfType([Integer]).isRequired,
});
_ProtocolClass = PropTypes.shape({
    "protocol": PropTypes.oneOfType([Integer]).isRequired,
});
_Public = PropTypes.shape({
    "public": PropTypes.oneOfType([Integer]).isRequired,
});
_Quicktype = PropTypes.shape({
    "quicktype": PropTypes.oneOfType([Integer]).isRequired,
});
_Raise = PropTypes.shape({
    "raise": PropTypes.oneOfType([Integer]).isRequired,
});
_Range = PropTypes.shape({
    "range": PropTypes.oneOfType([Integer]).isRequired,
});
_Readonly = PropTypes.shape({
    "readonly": PropTypes.oneOfType([Integer]).isRequired,
});
_Ref = PropTypes.shape({
    "ref": PropTypes.oneOfType([Integer]).isRequired,
});
_Register = PropTypes.shape({
    "register": PropTypes.oneOfType([Integer]).isRequired,
});
_ReinterpretCast = PropTypes.shape({
    "reinterpret_cast": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj4 = PropTypes.shape({
    "NO": _No,
    "NSError": _NSError,
    "NSObject": _NSObject,
    "NSString": _NSString,
    "NULL": _Null,
    "None": _None,
    "NullNode": _NullNode,
    "ObjectMapper": _ObjectMapper,
    "ObjectNode": _ObjectNode,
    "ObjectReader": _ObjectReader,
    "ObjectWriter": _ObjectWriter,
    "OffsetDateTime": _OffsetDateTime,
    "OffsetTime": _OffsetTime,
    "Protocol": _Protocol,
    "RegExp": _RegExp,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "mutable": _Mutable,
    "mutating": _Mutating,
    "namespace": _Namespace,
    "native": _Native,
    "new": _New,
    "newtonsoft": _Newtonsoft,
    "nil": _Nil,
    "noSuchMethod": _NoSuchMethod,
    "noexcept": _Noexcept,
    "nonatomic": _Nonatomic,
    "none": _NoneClass,
    "nonlocal": _Nonlocal,
    "nonmutating": _Nonmutating,
    "not": _Not,
    "not_eq": _NotEq,
    "null": _NullClass,
    "nullptr": _Nullptr,
    "number": _Number,
    "object": _Object,
    "of": _Of,
    "oneway": _Oneway,
    "open": _Open,
    "operator": _Operator,
    "optional": _Optional,
    "or": _Or,
    "or_eq": _OrEq,
    "out": _Out,
    "override": _Override,
    "package": _Package,
    "params": _Params,
    "pass": _Pass,
    "port": _Port,
    "postfix": _Postfix,
    "precedence": _Precedence,
    "prefix": _Prefix,
    "print": _Print,
    "printMembers": _PrintMembers,
    "printf": _Printf,
    "private": _Private,
    "protected": _Protected,
    "protocol": _ProtocolClass,
    "public": _Public,
    "quicktype": _Quicktype,
    "raise": _Raise,
    "range": _Range,
    "readonly": _Readonly,
    "ref": _Ref,
    "register": _Register,
    "reinterpret_cast": _ReinterpretCast,
});
_KSerializer = PropTypes.shape({
    "KSerializer": PropTypes.oneOfType([Integer]).isRequired,
});
_PrimitiveKind = PropTypes.shape({
    "PrimitiveKind": PropTypes.oneOfType([Integer]).isRequired,
});
_Sel = PropTypes.shape({
    "SEL": PropTypes.oneOfType([Integer]).isRequired,
});
_Self = PropTypes.shape({
    "Self": PropTypes.oneOfType([Integer]).isRequired,
});
_Sendable = PropTypes.shape({
    "Sendable": PropTypes.oneOfType([Integer]).isRequired,
});
_SerialDescriptor = PropTypes.shape({
    "SerialDescriptor": PropTypes.oneOfType([Integer]).isRequired,
});
_SerialName = PropTypes.shape({
    "SerialName": PropTypes.oneOfType([Integer]).isRequired,
});
_Serializable = PropTypes.shape({
    "Serializable": PropTypes.oneOfType([Integer]).isRequired,
});
_SerializationFeature = PropTypes.shape({
    "SerializationFeature": PropTypes.oneOfType([Integer]).isRequired,
});
_SerializerProvider = PropTypes.shape({
    "SerializerProvider": PropTypes.oneOfType([Integer]).isRequired,
});
_SimpleModule = PropTypes.shape({
    "SimpleModule": PropTypes.oneOfType([Integer]).isRequired,
});
_Standards = PropTypes.shape({
    "Standards": PropTypes.oneOfType([Integer]).isRequired,
});
_StdDeserializer = PropTypes.shape({
    "StdDeserializer": PropTypes.oneOfType([Integer]).isRequired,
});
_StdSerializer = PropTypes.shape({
    "StdSerializer": PropTypes.oneOfType([Integer]).isRequired,
});
_TextNode = PropTypes.shape({
    "TextNode": PropTypes.oneOfType([Integer]).isRequired,
});
_TimeOnly = PropTypes.shape({
    "TimeOnly": PropTypes.oneOfType([Integer]).isRequired,
});
_TimeOnlyConverter = PropTypes.shape({
    "TimeOnlyConverter": PropTypes.oneOfType([Integer]).isRequired,
});
_TimeZone = PropTypes.shape({
    "TimeZone": PropTypes.oneOfType([Integer]).isRequired,
});
_True = PropTypes.shape({
    "True": PropTypes.oneOfType([Integer]).isRequired,
});
_Repeat = PropTypes.shape({
    "repeat": PropTypes.oneOfType([Integer]).isRequired,
});
_Require = PropTypes.shape({
    "require": PropTypes.oneOfType([Integer]).isRequired,
});
_Required = PropTypes.shape({
    "required": PropTypes.oneOfType([Integer]).isRequired,
});
_Requires = PropTypes.shape({
    "requires": PropTypes.oneOfType([Integer]).isRequired,
});
_Restrict = PropTypes.shape({
    "restrict": PropTypes.oneOfType([Integer]).isRequired,
});
_Retain = PropTypes.shape({
    "retain": PropTypes.oneOfType([Integer]).isRequired,
});
_Rethrows = PropTypes.shape({
    "rethrows": PropTypes.oneOfType([Integer]).isRequired,
});
_Return = PropTypes.shape({
    "return": PropTypes.oneOfType([Integer]).isRequired,
});
_Right = PropTypes.shape({
    "right": PropTypes.oneOfType([Integer]).isRequired,
});
_RuntimeType = PropTypes.shape({
    "runtimeType": PropTypes.oneOfType([Integer]).isRequired,
});
_S = PropTypes.shape({
    "s": PropTypes.oneOfType([Integer]).isRequired,
});
_Sbyte = PropTypes.shape({
    "sbyte": PropTypes.oneOfType([Integer]).isRequired,
});
_Sealed = PropTypes.shape({
    "sealed": PropTypes.oneOfType([Integer]).isRequired,
});
_Select = PropTypes.shape({
    "select": PropTypes.oneOfType([Integer]).isRequired,
});
_SelfClass = PropTypes.shape({
    "self": PropTypes.oneOfType([Integer]).isRequired,
});
_Serialize = PropTypes.shape({
    "serialize": PropTypes.oneOfType([Integer]).isRequired,
});
_Set = PropTypes.shape({
    "set": PropTypes.oneOfType([Integer]).isRequired,
});
_Short = PropTypes.shape({
    "short": PropTypes.oneOfType([Integer]).isRequired,
});
_Signed = PropTypes.shape({
    "signed": PropTypes.oneOfType([Integer]).isRequired,
});
_Sizeof = PropTypes.shape({
    "sizeof": PropTypes.oneOfType([Integer]).isRequired,
});
_Stackalloc = PropTypes.shape({
    "stackalloc": PropTypes.oneOfType([Integer]).isRequired,
});
_Static = PropTypes.shape({
    "static": PropTypes.oneOfType([Integer]).isRequired,
});
_StaticAssert = PropTypes.shape({
    "static_assert": PropTypes.oneOfType([Integer]).isRequired,
});
_StaticCast = PropTypes.shape({
    "static_cast": PropTypes.oneOfType([Integer]).isRequired,
});
_Strictfp = PropTypes.shape({
    "strictfp": PropTypes.oneOfType([Integer]).isRequired,
});
_String = PropTypes.shape({
    "string": PropTypes.oneOfType([Integer]).isRequired,
});
_Struct = PropTypes.shape({
    "struct": PropTypes.oneOfType([Integer]).isRequired,
});
_Subscript = PropTypes.shape({
    "subscript": PropTypes.oneOfType([Integer]).isRequired,
});
_Super = PropTypes.shape({
    "super": PropTypes.oneOfType([Integer]).isRequired,
});
_Switch = PropTypes.shape({
    "switch": PropTypes.oneOfType([Integer]).isRequired,
});
_Symbol = PropTypes.shape({
    "symbol": PropTypes.oneOfType([Integer]).isRequired,
});
_Synchronized = PropTypes.shape({
    "synchronized": PropTypes.oneOfType([Integer]).isRequired,
});
_System = PropTypes.shape({
    "system": PropTypes.oneOfType([Integer]).isRequired,
});
_Template = PropTypes.shape({
    "template": PropTypes.oneOfType([Integer]).isRequired,
});
_Then = PropTypes.shape({
    "then": PropTypes.oneOfType([Integer]).isRequired,
});
_This = PropTypes.shape({
    "this": PropTypes.oneOfType([Integer]).isRequired,
});
_ThreadLocal = PropTypes.shape({
    "thread_local": PropTypes.oneOfType([Integer]).isRequired,
});
_Throw = PropTypes.shape({
    "throw": PropTypes.oneOfType([Integer]).isRequired,
});
_Throws = PropTypes.shape({
    "throws": PropTypes.oneOfType([Integer]).isRequired,
});
_ToString = PropTypes.shape({
    "toString": PropTypes.oneOfType([Integer]).isRequired,
});
_ToDict = PropTypes.shape({
    "to_dict": PropTypes.oneOfType([Integer]).isRequired,
});
_ToJSON = PropTypes.shape({
    "to_json": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevelClass = PropTypes.shape({
    "top_level": PropTypes.oneOfType([Integer]).isRequired,
});
_Transient = PropTypes.shape({
    "transient": PropTypes.oneOfType([Integer]).isRequired,
});
_TrueClass = PropTypes.shape({
    "true": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj5 = PropTypes.shape({
    "KSerializer": _KSerializer,
    "PrimitiveKind": _PrimitiveKind,
    "SEL": _Sel,
    "Self": _Self,
    "Sendable": _Sendable,
    "SerialDescriptor": _SerialDescriptor,
    "SerialName": _SerialName,
    "Serializable": _Serializable,
    "SerializationFeature": _SerializationFeature,
    "SerializerProvider": _SerializerProvider,
    "SimpleModule": _SimpleModule,
    "Standards": _Standards,
    "StdDeserializer": _StdDeserializer,
    "StdSerializer": _StdSerializer,
    "TextNode": _TextNode,
    "TimeOnly": _TimeOnly,
    "TimeOnlyConverter": _TimeOnlyConverter,
    "TimeZone": _TimeZone,
    "True": _True,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "repeat": _Repeat,
    "require": _Require,
    "required": _Required,
    "requires": _Requires,
    "restrict": _Restrict,
    "retain": _Retain,
    "rethrows": _Rethrows,
    "return": _Return,
    "right": _Right,
    "runtimeType": _RuntimeType,
    "s": _S,
    "sbyte": _Sbyte,
    "sealed": _Sealed,
    "select": _Select,
    "self": _SelfClass,
    "serialize": _Serialize,
    "set": _Set,
    "short": _Short,
    "signed": _Signed,
    "sizeof": _Sizeof,
    "stackalloc": _Stackalloc,
    "static": _Static,
    "static_assert": _StaticAssert,
    "static_cast": _StaticCast,
    "strictfp": _Strictfp,
    "string": _String,
    "struct": _Struct,
    "subscript": _Subscript,
    "super": _Super,
    "switch": _Switch,
    "symbol": _Symbol,
    "synchronized": _Synchronized,
    "system": _System,
    "template": _Template,
    "then": _Then,
    "this": _This,
    "thread_local": _ThreadLocal,
    "throw": _Throw,
    "throws": _Throws,
    "toString": _ToString,
    "to_dict": _ToDict,
    "to_json": _ToJSON,
    "top_level": _TopLevelClass,
    "transient": _Transient,
    "true": _TrueClass,
});
_Type = PropTypes.shape({
    "Type": PropTypes.oneOfType([Integer]).isRequired,
});
_UUID = PropTypes.shape({
    "UUID": PropTypes.oneOfType([Integer]).isRequired,
});
_UnmarshalJSON = PropTypes.shape({
    "UnmarshalJSON": PropTypes.oneOfType([Integer]).isRequired,
});
_UseSerializers = PropTypes.shape({
    "UseSerializers": PropTypes.oneOfType([Integer]).isRequired,
});
_Utf8JSONReader = PropTypes.shape({
    "Utf8JsonReader": PropTypes.oneOfType([Integer]).isRequired,
});
_Utf8JSONWriter = PropTypes.shape({
    "Utf8JsonWriter": PropTypes.oneOfType([Integer]).isRequired,
});
_Yes = PropTypes.shape({
    "YES": PropTypes.oneOfType([Integer]).isRequired,
});
_Try = PropTypes.shape({
    "try": PropTypes.oneOfType([Integer]).isRequired,
});
_TypeClass = PropTypes.shape({
    "type": PropTypes.oneOfType([Integer]).isRequired,
});
_Typealias = PropTypes.shape({
    "typealias": PropTypes.oneOfType([Integer]).isRequired,
});
_Typedef = PropTypes.shape({
    "typedef": PropTypes.oneOfType([Integer]).isRequired,
});
_Typeid = PropTypes.shape({
    "typeid": PropTypes.oneOfType([Integer]).isRequired,
});
_Typename = PropTypes.shape({
    "typename": PropTypes.oneOfType([Integer]).isRequired,
});
_Typeof = PropTypes.shape({
    "typeof": PropTypes.oneOfType([Integer]).isRequired,
});
_Uint = PropTypes.shape({
    "uint": PropTypes.oneOfType([Integer]).isRequired,
});
_Ulong = PropTypes.shape({
    "ulong": PropTypes.oneOfType([Integer]).isRequired,
});
_Unchecked = PropTypes.shape({
    "unchecked": PropTypes.oneOfType([Integer]).isRequired,
});
_Undefined = PropTypes.shape({
    "undefined": PropTypes.oneOfType([Integer]).isRequired,
});
_Union = PropTypes.shape({
    "union": PropTypes.oneOfType([Integer]).isRequired,
});
_Unowned = PropTypes.shape({
    "unowned": PropTypes.oneOfType([Integer]).isRequired,
});
_Unsafe = PropTypes.shape({
    "unsafe": PropTypes.oneOfType([Integer]).isRequired,
});
_Unsigned = PropTypes.shape({
    "unsigned": PropTypes.oneOfType([Integer]).isRequired,
});
_Ushort = PropTypes.shape({
    "ushort": PropTypes.oneOfType([Integer]).isRequired,
});
_Using = PropTypes.shape({
    "using": PropTypes.oneOfType([Integer]).isRequired,
});
_Var = PropTypes.shape({
    "var": PropTypes.oneOfType([Integer]).isRequired,
});
_Virtual = PropTypes.shape({
    "virtual": PropTypes.oneOfType([Integer]).isRequired,
});
_Void = PropTypes.shape({
    "void": PropTypes.oneOfType([Integer]).isRequired,
});
_Volatile = PropTypes.shape({
    "volatile": PropTypes.oneOfType([Integer]).isRequired,
});
_WcharT = PropTypes.shape({
    "wchar_t": PropTypes.oneOfType([Integer]).isRequired,
});
_Weak = PropTypes.shape({
    "weak": PropTypes.oneOfType([Integer]).isRequired,
});
_Where = PropTypes.shape({
    "where": PropTypes.oneOfType([Integer]).isRequired,
});
_While = PropTypes.shape({
    "while": PropTypes.oneOfType([Integer]).isRequired,
});
_WillSet = PropTypes.shape({
    "willSet": PropTypes.oneOfType([Integer]).isRequired,
});
_With = PropTypes.shape({
    "with": PropTypes.oneOfType([Integer]).isRequired,
});
_Xor = PropTypes.shape({
    "xor": PropTypes.oneOfType([Integer]).isRequired,
});
_XorEq = PropTypes.shape({
    "xor_eq": PropTypes.oneOfType([Integer]).isRequired,
});
_Yield = PropTypes.shape({
    "yield": PropTypes.oneOfType([Integer]).isRequired,
});
_Obj6 = PropTypes.shape({
    "Type": _Type,
    "UUID": _UUID,
    "UnmarshalJSON": _UnmarshalJSON,
    "UseSerializers": _UseSerializers,
    "Utf8JsonReader": _Utf8JSONReader,
    "Utf8JsonWriter": _Utf8JSONWriter,
    "YES": _Yes,
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "try": _Try,
    "type": _TypeClass,
    "typealias": _Typealias,
    "typedef": _Typedef,
    "typeid": _Typeid,
    "typename": _Typename,
    "typeof": _Typeof,
    "uint": _Uint,
    "ulong": _Ulong,
    "unchecked": _Unchecked,
    "undefined": _Undefined,
    "union": _Union,
    "unowned": _Unowned,
    "unsafe": _Unsafe,
    "unsigned": _Unsigned,
    "ushort": _Ushort,
    "using": _Using,
    "var": _Var,
    "virtual": _Virtual,
    "void": _Void,
    "volatile": _Volatile,
    "wchar_t": _WcharT,
    "weak": _Weak,
    "where": _Where,
    "while": _While,
    "willSet": _WillSet,
    "with": _With,
    "xor": _Xor,
    "xor_eq": _XorEq,
    "yield": _Yield,
});
_TopLevel = PropTypes.shape({
    "dummy": PropTypes.oneOfType([Integer]).isRequired,
    "obj1": _Obj1,
    "obj2": _Obj2,
    "obj3": _Obj3,
    "obj4": _Obj4,
    "obj5": _Obj5,
    "obj6": _Obj6,
});

export const TopLevel = _TopLevel;
