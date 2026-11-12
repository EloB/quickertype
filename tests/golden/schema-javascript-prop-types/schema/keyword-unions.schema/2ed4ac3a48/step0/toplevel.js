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

let _TopLevel;
let _Any;
let _ArrayNode;
let _Bool;
let _BooleanNode;
let _Calendar;
let _Class;
let _Codable;
let _CodingKey;
let _CodingKeys;
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
let _KSerializer;
let _LocalDate;
let _Locale;
let _LongNode;
let _MapEntry;
let _MarshalJSON;
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
let _PrimitiveKind;
let _Protocol;
let _RegExp;
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
let _Type;
let _UUID;
let _UnmarshalJSON;
let _UseSerializers;
let _Utf8JSONReader;
let _Utf8JSONWriter;
let _Yes;
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
let _UnionBoolBool;
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
_Any = PropTypes.shape({
});
_ArrayNode = PropTypes.shape({
});
_Bool = PropTypes.shape({
});
_BooleanNode = PropTypes.shape({
});
_Calendar = PropTypes.shape({
});
_Class = PropTypes.shape({
});
_Codable = PropTypes.shape({
});
_CodingKey = PropTypes.shape({
});
_CodingKeys = PropTypes.shape({
});
_CultureInfo = PropTypes.shape({
});
_DateFormatter = PropTypes.shape({
});
_DateOnly = PropTypes.shape({
});
_DateOnlyConverter = PropTypes.shape({
});
_DateTime = PropTypes.shape({
});
_DateTimeStyles = PropTypes.shape({
});
_Decoder = PropTypes.shape({
});
_DecodingError = PropTypes.shape({
});
_DeserializationFeature = PropTypes.shape({
});
_DoubleNode = PropTypes.shape({
});
_Encoder = PropTypes.shape({
});
_EnumValues = PropTypes.shape({
});
_Equatable = PropTypes.shape({
});
_False = PropTypes.shape({
});
_FormatException = PropTypes.shape({
});
_Hashable = PropTypes.shape({
});
_Hasher = PropTypes.shape({
});
_Imp = PropTypes.shape({
});
_IntNode = PropTypes.shape({
});
_ISODateTimeOffsetConverter = PropTypes.shape({
});
_JSONAny = PropTypes.shape({
});
_JSONCodingKey = PropTypes.shape({
});
_JSONDecoder = PropTypes.shape({
});
_JSONEncoder = PropTypes.shape({
});
_JSONNull = PropTypes.shape({
});
_JSONException = PropTypes.shape({
});
_JSONGenerator = PropTypes.shape({
});
_JSONNode = PropTypes.shape({
});
_JSONParser = PropTypes.shape({
});
_JSONReader = PropTypes.shape({
});
_JSONTokenType = PropTypes.shape({
});
_KSerializer = PropTypes.shape({
});
_LocalDate = PropTypes.shape({
});
_Locale = PropTypes.shape({
});
_LongNode = PropTypes.shape({
});
_MapEntry = PropTypes.shape({
});
_MarshalJSON = PropTypes.shape({
});
_No = PropTypes.shape({
});
_NSError = PropTypes.shape({
});
_NSObject = PropTypes.shape({
});
_NSString = PropTypes.shape({
});
_Null = PropTypes.shape({
});
_None = PropTypes.shape({
});
_NullNode = PropTypes.shape({
});
_ObjectMapper = PropTypes.shape({
});
_ObjectNode = PropTypes.shape({
});
_ObjectReader = PropTypes.shape({
});
_ObjectWriter = PropTypes.shape({
});
_OffsetDateTime = PropTypes.shape({
});
_OffsetTime = PropTypes.shape({
});
_PrimitiveKind = PropTypes.shape({
});
_Protocol = PropTypes.shape({
});
_RegExp = PropTypes.shape({
});
_Sel = PropTypes.shape({
});
_Self = PropTypes.shape({
});
_Sendable = PropTypes.shape({
});
_SerialDescriptor = PropTypes.shape({
});
_SerialName = PropTypes.shape({
});
_Serializable = PropTypes.shape({
});
_SerializationFeature = PropTypes.shape({
});
_SerializerProvider = PropTypes.shape({
});
_SimpleModule = PropTypes.shape({
});
_Standards = PropTypes.shape({
});
_StdDeserializer = PropTypes.shape({
});
_StdSerializer = PropTypes.shape({
});
_TextNode = PropTypes.shape({
});
_TimeOnly = PropTypes.shape({
});
_TimeOnlyConverter = PropTypes.shape({
});
_TimeZone = PropTypes.shape({
});
_True = PropTypes.shape({
});
_Type = PropTypes.shape({
});
_UUID = PropTypes.shape({
});
_UnmarshalJSON = PropTypes.shape({
});
_UseSerializers = PropTypes.shape({
});
_Utf8JSONReader = PropTypes.shape({
});
_Utf8JSONWriter = PropTypes.shape({
});
_Yes = PropTypes.shape({
});
_Empty = PropTypes.shape({
});
_BoolClass = PropTypes.shape({
});
_Complex = PropTypes.shape({
});
_Imaginery = PropTypes.shape({
});
_Abstract = PropTypes.shape({
});
_Alignas = PropTypes.shape({
});
_Alignof = PropTypes.shape({
});
_And = PropTypes.shape({
});
_AndEq = PropTypes.shape({
});
_AnyClass = PropTypes.shape({
});
_Array = PropTypes.shape({
});
_As = PropTypes.shape({
});
_ASM = PropTypes.shape({
});
_Assert = PropTypes.shape({
});
_Associatedtype = PropTypes.shape({
});
_Associativity = PropTypes.shape({
});
_Async = PropTypes.shape({
});
_Atomic = PropTypes.shape({
});
_AtomicCancel = PropTypes.shape({
});
_AtomicCommit = PropTypes.shape({
});
_AtomicNoexcept = PropTypes.shape({
});
_Auto = PropTypes.shape({
});
_Await = PropTypes.shape({
});
_Base = PropTypes.shape({
});
_Bitand = PropTypes.shape({
});
_Bitor = PropTypes.shape({
});
_UnionBoolBool = PropTypes.shape({
});
_Boolean = PropTypes.shape({
});
_Break = PropTypes.shape({
});
_Bycopy = PropTypes.shape({
});
_Byref = PropTypes.shape({
});
_Byte = PropTypes.shape({
});
_Case = PropTypes.shape({
});
_Catch = PropTypes.shape({
});
_Chan = PropTypes.shape({
});
_Char = PropTypes.shape({
});
_Char16T = PropTypes.shape({
});
_Char32T = PropTypes.shape({
});
_Checked = PropTypes.shape({
});
_ClassClass = PropTypes.shape({
});
_Clone = PropTypes.shape({
});
_CoAwait = PropTypes.shape({
});
_CoReturn = PropTypes.shape({
});
_CoYield = PropTypes.shape({
});
_Compl = PropTypes.shape({
});
_Concept = PropTypes.shape({
});
_Console = PropTypes.shape({
});
_Const = PropTypes.shape({
});
_ConstCast = PropTypes.shape({
});
_Constexpr = PropTypes.shape({
});
_Constructor = PropTypes.shape({
});
_Continue = PropTypes.shape({
});
_Convenience = PropTypes.shape({
});
_Convert = PropTypes.shape({
});
_Converter = PropTypes.shape({
});
_Date = PropTypes.shape({
});
_DateParseHandling = PropTypes.shape({
});
_Debugger = PropTypes.shape({
});
_Decimal = PropTypes.shape({
});
_Declare = PropTypes.shape({
});
_Decltype = PropTypes.shape({
});
_DecodeString = PropTypes.shape({
});
_Def = PropTypes.shape({
});
_Default = PropTypes.shape({
});
_Defer = PropTypes.shape({
});
_Deinit = PropTypes.shape({
});
_Del = PropTypes.shape({
});
_Delegate = PropTypes.shape({
});
_Delete = PropTypes.shape({
});
_Dict = PropTypes.shape({
});
_Dictionary = PropTypes.shape({
});
_DidSet = PropTypes.shape({
});
_Do = PropTypes.shape({
});
_Double = PropTypes.shape({
});
_Dynamic = PropTypes.shape({
});
_DynamicCast = PropTypes.shape({
});
_Elif = PropTypes.shape({
});
_Else = PropTypes.shape({
});
_EncodeQuickType = PropTypes.shape({
});
_Enum = PropTypes.shape({
});
_EqualityContract = PropTypes.shape({
});
_Event = PropTypes.shape({
});
_Except = PropTypes.shape({
});
_Exception = PropTypes.shape({
});
_Explicit = PropTypes.shape({
});
_Export = PropTypes.shape({
});
_Exposing = PropTypes.shape({
});
_Extends = PropTypes.shape({
});
_Extension = PropTypes.shape({
});
_Extern = PropTypes.shape({
});
_Fallthrough = PropTypes.shape({
});
_FalseClass = PropTypes.shape({
});
_Fileprivate = PropTypes.shape({
});
_Final = PropTypes.shape({
});
_Finally = PropTypes.shape({
});
_Fixed = PropTypes.shape({
});
_Float = PropTypes.shape({
});
_For = PropTypes.shape({
});
_Foreach = PropTypes.shape({
});
_Friend = PropTypes.shape({
});
_From = PropTypes.shape({
});
_FromDict = PropTypes.shape({
});
_FromJSON = PropTypes.shape({
});
_Func = PropTypes.shape({
});
_Function = PropTypes.shape({
});
_Get = PropTypes.shape({
});
_Global = PropTypes.shape({
});
_Go = PropTypes.shape({
});
_Goto = PropTypes.shape({
});
_Guard = PropTypes.shape({
});
_HasOwnProperty = PropTypes.shape({
});
_HashCode = PropTypes.shape({
});
_ID = PropTypes.shape({
});
_If = PropTypes.shape({
});
_Implements = PropTypes.shape({
});
_Implicit = PropTypes.shape({
});
_Import = PropTypes.shape({
});
_In = PropTypes.shape({
});
_Indirect = PropTypes.shape({
});
_Infix = PropTypes.shape({
});
_Init = PropTypes.shape({
});
_Inline = PropTypes.shape({
});
_Inout = PropTypes.shape({
});
_Instanceof = PropTypes.shape({
});
_Int = PropTypes.shape({
});
_Interface = PropTypes.shape({
});
_Internal = PropTypes.shape({
});
_Is = PropTypes.shape({
});
_Iterable = PropTypes.shape({
});
_Jdec = PropTypes.shape({
});
_Jenc = PropTypes.shape({
});
_Jpipe = PropTypes.shape({
});
_JSON = PropTypes.shape({
});
_JSONConverter = PropTypes.shape({
});
_JSONSerializer = PropTypes.shape({
});
_JSONToken = PropTypes.shape({
});
_JSONWriter = PropTypes.shape({
});
_Lambda = PropTypes.shape({
});
_Lazy = PropTypes.shape({
});
_Left = PropTypes.shape({
});
_Let = PropTypes.shape({
});
_List = PropTypes.shape({
});
_Lock = PropTypes.shape({
});
_Long = PropTypes.shape({
});
_Map = PropTypes.shape({
});
_MetadataPropertyHandling = PropTypes.shape({
});
_Module = PropTypes.shape({
});
_Mutable = PropTypes.shape({
});
_Mutating = PropTypes.shape({
});
_Namespace = PropTypes.shape({
});
_Native = PropTypes.shape({
});
_New = PropTypes.shape({
});
_Newtonsoft = PropTypes.shape({
});
_Nil = PropTypes.shape({
});
_NoSuchMethod = PropTypes.shape({
});
_Noexcept = PropTypes.shape({
});
_Nonatomic = PropTypes.shape({
});
_NoneClass = PropTypes.shape({
});
_Nonlocal = PropTypes.shape({
});
_Nonmutating = PropTypes.shape({
});
_Not = PropTypes.shape({
});
_NotEq = PropTypes.shape({
});
_NullClass = PropTypes.shape({
});
_Nullptr = PropTypes.shape({
});
_Number = PropTypes.shape({
});
_Object = PropTypes.shape({
});
_Of = PropTypes.shape({
});
_Oneway = PropTypes.shape({
});
_Open = PropTypes.shape({
});
_Operator = PropTypes.shape({
});
_Optional = PropTypes.shape({
});
_Or = PropTypes.shape({
});
_OrEq = PropTypes.shape({
});
_Out = PropTypes.shape({
});
_Override = PropTypes.shape({
});
_Package = PropTypes.shape({
});
_Params = PropTypes.shape({
});
_Pass = PropTypes.shape({
});
_Port = PropTypes.shape({
});
_Postfix = PropTypes.shape({
});
_Precedence = PropTypes.shape({
});
_Prefix = PropTypes.shape({
});
_Print = PropTypes.shape({
});
_PrintMembers = PropTypes.shape({
});
_Printf = PropTypes.shape({
});
_Private = PropTypes.shape({
});
_Protected = PropTypes.shape({
});
_ProtocolClass = PropTypes.shape({
});
_Public = PropTypes.shape({
});
_Quicktype = PropTypes.shape({
});
_Raise = PropTypes.shape({
});
_Range = PropTypes.shape({
});
_Readonly = PropTypes.shape({
});
_Ref = PropTypes.shape({
});
_Register = PropTypes.shape({
});
_ReinterpretCast = PropTypes.shape({
});
_Repeat = PropTypes.shape({
});
_Require = PropTypes.shape({
});
_Required = PropTypes.shape({
});
_Requires = PropTypes.shape({
});
_Restrict = PropTypes.shape({
});
_Retain = PropTypes.shape({
});
_Rethrows = PropTypes.shape({
});
_Return = PropTypes.shape({
});
_Right = PropTypes.shape({
});
_RuntimeType = PropTypes.shape({
});
_S = PropTypes.shape({
});
_Sbyte = PropTypes.shape({
});
_Sealed = PropTypes.shape({
});
_Select = PropTypes.shape({
});
_SelfClass = PropTypes.shape({
});
_Serialize = PropTypes.shape({
});
_Set = PropTypes.shape({
});
_Short = PropTypes.shape({
});
_Signed = PropTypes.shape({
});
_Sizeof = PropTypes.shape({
});
_Stackalloc = PropTypes.shape({
});
_Static = PropTypes.shape({
});
_StaticAssert = PropTypes.shape({
});
_StaticCast = PropTypes.shape({
});
_Strictfp = PropTypes.shape({
});
_String = PropTypes.shape({
});
_Struct = PropTypes.shape({
});
_Subscript = PropTypes.shape({
});
_Super = PropTypes.shape({
});
_Switch = PropTypes.shape({
});
_Symbol = PropTypes.shape({
});
_Synchronized = PropTypes.shape({
});
_System = PropTypes.shape({
});
_Template = PropTypes.shape({
});
_Then = PropTypes.shape({
});
_This = PropTypes.shape({
});
_ThreadLocal = PropTypes.shape({
});
_Throw = PropTypes.shape({
});
_Throws = PropTypes.shape({
});
_ToString = PropTypes.shape({
});
_ToDict = PropTypes.shape({
});
_ToJSON = PropTypes.shape({
});
_TopLevelClass = PropTypes.shape({
});
_Transient = PropTypes.shape({
});
_TrueClass = PropTypes.shape({
});
_Try = PropTypes.shape({
});
_TypeClass = PropTypes.shape({
});
_Typealias = PropTypes.shape({
});
_Typedef = PropTypes.shape({
});
_Typeid = PropTypes.shape({
});
_Typename = PropTypes.shape({
});
_Typeof = PropTypes.shape({
});
_Uint = PropTypes.shape({
});
_Ulong = PropTypes.shape({
});
_Unchecked = PropTypes.shape({
});
_Undefined = PropTypes.shape({
});
_Union = PropTypes.shape({
});
_Unowned = PropTypes.shape({
});
_Unsafe = PropTypes.shape({
});
_Unsigned = PropTypes.shape({
});
_Ushort = PropTypes.shape({
});
_Using = PropTypes.shape({
});
_Var = PropTypes.shape({
});
_Virtual = PropTypes.shape({
});
_Void = PropTypes.shape({
});
_Volatile = PropTypes.shape({
});
_WcharT = PropTypes.shape({
});
_Weak = PropTypes.shape({
});
_Where = PropTypes.shape({
});
_While = PropTypes.shape({
});
_WillSet = PropTypes.shape({
});
_With = PropTypes.shape({
});
_Xor = PropTypes.shape({
});
_XorEq = PropTypes.shape({
});
_Yield = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "_": PropTypes.oneOfType([_Empty, PropTypes.number, PropTypes.oneOf([null])]),
    "_Bool": PropTypes.oneOfType([_BoolClass, PropTypes.number, PropTypes.oneOf([null])]),
    "_Complex": PropTypes.oneOfType([_Complex, PropTypes.number, PropTypes.oneOf([null])]),
    "_Imaginery": PropTypes.oneOfType([_Imaginery, PropTypes.number, PropTypes.oneOf([null])]),
    "abstract": PropTypes.oneOfType([_Abstract, PropTypes.number, PropTypes.oneOf([null])]),
    "alignas": PropTypes.oneOfType([_Alignas, PropTypes.number, PropTypes.oneOf([null])]),
    "alignof": PropTypes.oneOfType([_Alignof, PropTypes.number, PropTypes.oneOf([null])]),
    "and": PropTypes.oneOfType([_And, PropTypes.number, PropTypes.oneOf([null])]),
    "and_eq": PropTypes.oneOfType([_AndEq, PropTypes.number, PropTypes.oneOf([null])]),
    "any": PropTypes.oneOfType([_AnyClass, PropTypes.number, PropTypes.oneOf([null])]),
    "Any": PropTypes.oneOfType([_Any, PropTypes.number, PropTypes.oneOf([null])]),
    "array": PropTypes.oneOfType([_Array, PropTypes.number, PropTypes.oneOf([null])]),
    "ArrayNode": PropTypes.oneOfType([_ArrayNode, PropTypes.number, PropTypes.oneOf([null])]),
    "as": PropTypes.oneOfType([_As, PropTypes.number, PropTypes.oneOf([null])]),
    "asm": PropTypes.oneOfType([_ASM, PropTypes.number, PropTypes.oneOf([null])]),
    "assert": PropTypes.oneOfType([_Assert, PropTypes.number, PropTypes.oneOf([null])]),
    "associatedtype": PropTypes.oneOfType([_Associatedtype, PropTypes.number, PropTypes.oneOf([null])]),
    "associativity": PropTypes.oneOfType([_Associativity, PropTypes.number, PropTypes.oneOf([null])]),
    "async": PropTypes.oneOfType([_Async, PropTypes.number, PropTypes.oneOf([null])]),
    "atomic": PropTypes.oneOfType([_Atomic, PropTypes.number, PropTypes.oneOf([null])]),
    "atomic_cancel": PropTypes.oneOfType([_AtomicCancel, PropTypes.number, PropTypes.oneOf([null])]),
    "atomic_commit": PropTypes.oneOfType([_AtomicCommit, PropTypes.number, PropTypes.oneOf([null])]),
    "atomic_noexcept": PropTypes.oneOfType([_AtomicNoexcept, PropTypes.number, PropTypes.oneOf([null])]),
    "auto": PropTypes.oneOfType([_Auto, PropTypes.number, PropTypes.oneOf([null])]),
    "await": PropTypes.oneOfType([_Await, PropTypes.number, PropTypes.oneOf([null])]),
    "base": PropTypes.oneOfType([_Base, PropTypes.number, PropTypes.oneOf([null])]),
    "bitand": PropTypes.oneOfType([_Bitand, PropTypes.number, PropTypes.oneOf([null])]),
    "bitor": PropTypes.oneOfType([_Bitor, PropTypes.number, PropTypes.oneOf([null])]),
    "BOOL": PropTypes.oneOfType([_Bool, PropTypes.number, PropTypes.oneOf([null])]),
    "bool": PropTypes.oneOfType([_UnionBoolBool, PropTypes.number, PropTypes.oneOf([null])]),
    "boolean": PropTypes.oneOfType([_Boolean, PropTypes.number, PropTypes.oneOf([null])]),
    "BooleanNode": PropTypes.oneOfType([_BooleanNode, PropTypes.number, PropTypes.oneOf([null])]),
    "break": PropTypes.oneOfType([_Break, PropTypes.number, PropTypes.oneOf([null])]),
    "bycopy": PropTypes.oneOfType([_Bycopy, PropTypes.number, PropTypes.oneOf([null])]),
    "byref": PropTypes.oneOfType([_Byref, PropTypes.number, PropTypes.oneOf([null])]),
    "byte": PropTypes.oneOfType([_Byte, PropTypes.number, PropTypes.oneOf([null])]),
    "Calendar": PropTypes.oneOfType([_Calendar, PropTypes.number, PropTypes.oneOf([null])]),
    "case": PropTypes.oneOfType([_Case, PropTypes.number, PropTypes.oneOf([null])]),
    "catch": PropTypes.oneOfType([_Catch, PropTypes.number, PropTypes.oneOf([null])]),
    "chan": PropTypes.oneOfType([_Chan, PropTypes.number, PropTypes.oneOf([null])]),
    "char": PropTypes.oneOfType([_Char, PropTypes.number, PropTypes.oneOf([null])]),
    "char16_t": PropTypes.oneOfType([_Char16T, PropTypes.number, PropTypes.oneOf([null])]),
    "char32_t": PropTypes.oneOfType([_Char32T, PropTypes.number, PropTypes.oneOf([null])]),
    "checked": PropTypes.oneOfType([_Checked, PropTypes.number, PropTypes.oneOf([null])]),
    "class": PropTypes.oneOfType([_ClassClass, PropTypes.number, PropTypes.oneOf([null])]),
    "Class": PropTypes.oneOfType([_Class, PropTypes.number, PropTypes.oneOf([null])]),
    "clone": PropTypes.oneOfType([_Clone, PropTypes.number, PropTypes.oneOf([null])]),
    "co_await": PropTypes.oneOfType([_CoAwait, PropTypes.number, PropTypes.oneOf([null])]),
    "co_return": PropTypes.oneOfType([_CoReturn, PropTypes.number, PropTypes.oneOf([null])]),
    "co_yield": PropTypes.oneOfType([_CoYield, PropTypes.number, PropTypes.oneOf([null])]),
    "Codable": PropTypes.oneOfType([_Codable, PropTypes.number, PropTypes.oneOf([null])]),
    "CodingKey": PropTypes.oneOfType([_CodingKey, PropTypes.number, PropTypes.oneOf([null])]),
    "CodingKeys": PropTypes.oneOfType([_CodingKeys, PropTypes.number, PropTypes.oneOf([null])]),
    "compl": PropTypes.oneOfType([_Compl, PropTypes.number, PropTypes.oneOf([null])]),
    "concept": PropTypes.oneOfType([_Concept, PropTypes.number, PropTypes.oneOf([null])]),
    "console": PropTypes.oneOfType([_Console, PropTypes.number, PropTypes.oneOf([null])]),
    "const": PropTypes.oneOfType([_Const, PropTypes.number, PropTypes.oneOf([null])]),
    "const_cast": PropTypes.oneOfType([_ConstCast, PropTypes.number, PropTypes.oneOf([null])]),
    "constexpr": PropTypes.oneOfType([_Constexpr, PropTypes.number, PropTypes.oneOf([null])]),
    "constructor": (props, name, ...args) => Object.prototype.hasOwnProperty.call(props, name) ? PropTypes.oneOfType([_Constructor, PropTypes.number, PropTypes.oneOf([null])])(props, name, ...args) : null,
    "continue": PropTypes.oneOfType([_Continue, PropTypes.number, PropTypes.oneOf([null])]),
    "convenience": PropTypes.oneOfType([_Convenience, PropTypes.number, PropTypes.oneOf([null])]),
    "convert": PropTypes.oneOfType([_Convert, PropTypes.number, PropTypes.oneOf([null])]),
    "converter": PropTypes.oneOfType([_Converter, PropTypes.number, PropTypes.oneOf([null])]),
    "CultureInfo": PropTypes.oneOfType([_CultureInfo, PropTypes.number, PropTypes.oneOf([null])]),
    "date": PropTypes.oneOfType([_Date, PropTypes.number, PropTypes.oneOf([null])]),
    "date_parse_handling": PropTypes.oneOfType([_DateParseHandling, PropTypes.number, PropTypes.oneOf([null])]),
    "DateFormatter": PropTypes.oneOfType([_DateFormatter, PropTypes.number, PropTypes.oneOf([null])]),
    "DateOnly": PropTypes.oneOfType([_DateOnly, PropTypes.number, PropTypes.oneOf([null])]),
    "DateOnlyConverter": PropTypes.oneOfType([_DateOnlyConverter, PropTypes.number, PropTypes.oneOf([null])]),
    "DateTime": PropTypes.oneOfType([_DateTime, PropTypes.number, PropTypes.oneOf([null])]),
    "DateTimeStyles": PropTypes.oneOfType([_DateTimeStyles, PropTypes.number, PropTypes.oneOf([null])]),
    "debugger": PropTypes.oneOfType([_Debugger, PropTypes.number, PropTypes.oneOf([null])]),
    "decimal": PropTypes.oneOfType([_Decimal, PropTypes.number, PropTypes.oneOf([null])]),
    "declare": PropTypes.oneOfType([_Declare, PropTypes.number, PropTypes.oneOf([null])]),
    "decltype": PropTypes.oneOfType([_Decltype, PropTypes.number, PropTypes.oneOf([null])]),
    "decode_string": PropTypes.oneOfType([_DecodeString, PropTypes.number, PropTypes.oneOf([null])]),
    "Decoder": PropTypes.oneOfType([_Decoder, PropTypes.number, PropTypes.oneOf([null])]),
    "DecodingError": PropTypes.oneOfType([_DecodingError, PropTypes.number, PropTypes.oneOf([null])]),
    "def": PropTypes.oneOfType([_Def, PropTypes.number, PropTypes.oneOf([null])]),
    "default": PropTypes.oneOfType([_Default, PropTypes.number, PropTypes.oneOf([null])]),
    "defer": PropTypes.oneOfType([_Defer, PropTypes.number, PropTypes.oneOf([null])]),
    "deinit": PropTypes.oneOfType([_Deinit, PropTypes.number, PropTypes.oneOf([null])]),
    "del": PropTypes.oneOfType([_Del, PropTypes.number, PropTypes.oneOf([null])]),
    "delegate": PropTypes.oneOfType([_Delegate, PropTypes.number, PropTypes.oneOf([null])]),
    "delete": PropTypes.oneOfType([_Delete, PropTypes.number, PropTypes.oneOf([null])]),
    "DeserializationFeature": PropTypes.oneOfType([_DeserializationFeature, PropTypes.number, PropTypes.oneOf([null])]),
    "dict": PropTypes.oneOfType([_Dict, PropTypes.number, PropTypes.oneOf([null])]),
    "dictionary": PropTypes.oneOfType([_Dictionary, PropTypes.number, PropTypes.oneOf([null])]),
    "didSet": PropTypes.oneOfType([_DidSet, PropTypes.number, PropTypes.oneOf([null])]),
    "do": PropTypes.oneOfType([_Do, PropTypes.number, PropTypes.oneOf([null])]),
    "double": PropTypes.oneOfType([_Double, PropTypes.number, PropTypes.oneOf([null])]),
    "DoubleNode": PropTypes.oneOfType([_DoubleNode, PropTypes.number, PropTypes.oneOf([null])]),
    "dummy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dynamic": PropTypes.oneOfType([_Dynamic, PropTypes.number, PropTypes.oneOf([null])]),
    "dynamic_cast": PropTypes.oneOfType([_DynamicCast, PropTypes.number, PropTypes.oneOf([null])]),
    "elif": PropTypes.oneOfType([_Elif, PropTypes.number, PropTypes.oneOf([null])]),
    "else": PropTypes.oneOfType([_Else, PropTypes.number, PropTypes.oneOf([null])]),
    "encode_quick_type": PropTypes.oneOfType([_EncodeQuickType, PropTypes.number, PropTypes.oneOf([null])]),
    "Encoder": PropTypes.oneOfType([_Encoder, PropTypes.number, PropTypes.oneOf([null])]),
    "enum": PropTypes.oneOfType([_Enum, PropTypes.number, PropTypes.oneOf([null])]),
    "EnumValues": PropTypes.oneOfType([_EnumValues, PropTypes.number, PropTypes.oneOf([null])]),
    "equalityContract": PropTypes.oneOfType([_EqualityContract, PropTypes.number, PropTypes.oneOf([null])]),
    "Equatable": PropTypes.oneOfType([_Equatable, PropTypes.number, PropTypes.oneOf([null])]),
    "event": PropTypes.oneOfType([_Event, PropTypes.number, PropTypes.oneOf([null])]),
    "except": PropTypes.oneOfType([_Except, PropTypes.number, PropTypes.oneOf([null])]),
    "exception": PropTypes.oneOfType([_Exception, PropTypes.number, PropTypes.oneOf([null])]),
    "explicit": PropTypes.oneOfType([_Explicit, PropTypes.number, PropTypes.oneOf([null])]),
    "export": PropTypes.oneOfType([_Export, PropTypes.number, PropTypes.oneOf([null])]),
    "exposing": PropTypes.oneOfType([_Exposing, PropTypes.number, PropTypes.oneOf([null])]),
    "extends": PropTypes.oneOfType([_Extends, PropTypes.number, PropTypes.oneOf([null])]),
    "extension": PropTypes.oneOfType([_Extension, PropTypes.number, PropTypes.oneOf([null])]),
    "extern": PropTypes.oneOfType([_Extern, PropTypes.number, PropTypes.oneOf([null])]),
    "fallthrough": PropTypes.oneOfType([_Fallthrough, PropTypes.number, PropTypes.oneOf([null])]),
    "false": PropTypes.oneOfType([_FalseClass, PropTypes.number, PropTypes.oneOf([null])]),
    "False": PropTypes.oneOfType([_False, PropTypes.number, PropTypes.oneOf([null])]),
    "fileprivate": PropTypes.oneOfType([_Fileprivate, PropTypes.number, PropTypes.oneOf([null])]),
    "final": PropTypes.oneOfType([_Final, PropTypes.number, PropTypes.oneOf([null])]),
    "finally": PropTypes.oneOfType([_Finally, PropTypes.number, PropTypes.oneOf([null])]),
    "fixed": PropTypes.oneOfType([_Fixed, PropTypes.number, PropTypes.oneOf([null])]),
    "float": PropTypes.oneOfType([_Float, PropTypes.number, PropTypes.oneOf([null])]),
    "for": PropTypes.oneOfType([_For, PropTypes.number, PropTypes.oneOf([null])]),
    "foreach": PropTypes.oneOfType([_Foreach, PropTypes.number, PropTypes.oneOf([null])]),
    "FormatException": PropTypes.oneOfType([_FormatException, PropTypes.number, PropTypes.oneOf([null])]),
    "friend": PropTypes.oneOfType([_Friend, PropTypes.number, PropTypes.oneOf([null])]),
    "from": PropTypes.oneOfType([_From, PropTypes.number, PropTypes.oneOf([null])]),
    "from_dict": PropTypes.oneOfType([_FromDict, PropTypes.number, PropTypes.oneOf([null])]),
    "from_json": PropTypes.oneOfType([_FromJSON, PropTypes.number, PropTypes.oneOf([null])]),
    "func": PropTypes.oneOfType([_Func, PropTypes.number, PropTypes.oneOf([null])]),
    "function": PropTypes.oneOfType([_Function, PropTypes.number, PropTypes.oneOf([null])]),
    "get": PropTypes.oneOfType([_Get, PropTypes.number, PropTypes.oneOf([null])]),
    "global": PropTypes.oneOfType([_Global, PropTypes.number, PropTypes.oneOf([null])]),
    "go": PropTypes.oneOfType([_Go, PropTypes.number, PropTypes.oneOf([null])]),
    "goto": PropTypes.oneOfType([_Goto, PropTypes.number, PropTypes.oneOf([null])]),
    "guard": PropTypes.oneOfType([_Guard, PropTypes.number, PropTypes.oneOf([null])]),
    "Hashable": PropTypes.oneOfType([_Hashable, PropTypes.number, PropTypes.oneOf([null])]),
    "hashCode": PropTypes.oneOfType([_HashCode, PropTypes.number, PropTypes.oneOf([null])]),
    "Hasher": PropTypes.oneOfType([_Hasher, PropTypes.number, PropTypes.oneOf([null])]),
    "hasOwnProperty": (props, name, ...args) => Object.prototype.hasOwnProperty.call(props, name) ? PropTypes.oneOfType([_HasOwnProperty, PropTypes.number, PropTypes.oneOf([null])])(props, name, ...args) : null,
    "id": PropTypes.oneOfType([_ID, PropTypes.number, PropTypes.oneOf([null])]),
    "if": PropTypes.oneOfType([_If, PropTypes.number, PropTypes.oneOf([null])]),
    "IMP": PropTypes.oneOfType([_Imp, PropTypes.number, PropTypes.oneOf([null])]),
    "implements": PropTypes.oneOfType([_Implements, PropTypes.number, PropTypes.oneOf([null])]),
    "implicit": PropTypes.oneOfType([_Implicit, PropTypes.number, PropTypes.oneOf([null])]),
    "import": PropTypes.oneOfType([_Import, PropTypes.number, PropTypes.oneOf([null])]),
    "in": PropTypes.oneOfType([_In, PropTypes.number, PropTypes.oneOf([null])]),
    "indirect": PropTypes.oneOfType([_Indirect, PropTypes.number, PropTypes.oneOf([null])]),
    "infix": PropTypes.oneOfType([_Infix, PropTypes.number, PropTypes.oneOf([null])]),
    "init": PropTypes.oneOfType([_Init, PropTypes.number, PropTypes.oneOf([null])]),
    "inline": PropTypes.oneOfType([_Inline, PropTypes.number, PropTypes.oneOf([null])]),
    "inout": PropTypes.oneOfType([_Inout, PropTypes.number, PropTypes.oneOf([null])]),
    "instanceof": PropTypes.oneOfType([_Instanceof, PropTypes.number, PropTypes.oneOf([null])]),
    "int": PropTypes.oneOfType([_Int, PropTypes.number, PropTypes.oneOf([null])]),
    "interface": PropTypes.oneOfType([_Interface, PropTypes.number, PropTypes.oneOf([null])]),
    "internal": PropTypes.oneOfType([_Internal, PropTypes.number, PropTypes.oneOf([null])]),
    "IntNode": PropTypes.oneOfType([_IntNode, PropTypes.number, PropTypes.oneOf([null])]),
    "is": PropTypes.oneOfType([_Is, PropTypes.number, PropTypes.oneOf([null])]),
    "IsoDateTimeOffsetConverter": PropTypes.oneOfType([_ISODateTimeOffsetConverter, PropTypes.number, PropTypes.oneOf([null])]),
    "iterable": PropTypes.oneOfType([_Iterable, PropTypes.number, PropTypes.oneOf([null])]),
    "jdec": PropTypes.oneOfType([_Jdec, PropTypes.number, PropTypes.oneOf([null])]),
    "jenc": PropTypes.oneOfType([_Jenc, PropTypes.number, PropTypes.oneOf([null])]),
    "jpipe": PropTypes.oneOfType([_Jpipe, PropTypes.number, PropTypes.oneOf([null])]),
    "json": PropTypes.oneOfType([_JSON, PropTypes.number, PropTypes.oneOf([null])]),
    "json_converter": PropTypes.oneOfType([_JSONConverter, PropTypes.number, PropTypes.oneOf([null])]),
    "json_serializer": PropTypes.oneOfType([_JSONSerializer, PropTypes.number, PropTypes.oneOf([null])]),
    "json_token": PropTypes.oneOfType([_JSONToken, PropTypes.number, PropTypes.oneOf([null])]),
    "json_writer": PropTypes.oneOfType([_JSONWriter, PropTypes.number, PropTypes.oneOf([null])]),
    "JSONAny": PropTypes.oneOfType([_JSONAny, PropTypes.number, PropTypes.oneOf([null])]),
    "JSONCodingKey": PropTypes.oneOfType([_JSONCodingKey, PropTypes.number, PropTypes.oneOf([null])]),
    "JSONDecoder": PropTypes.oneOfType([_JSONDecoder, PropTypes.number, PropTypes.oneOf([null])]),
    "JSONEncoder": PropTypes.oneOfType([_JSONEncoder, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonException": PropTypes.oneOfType([_JSONException, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonGenerator": PropTypes.oneOfType([_JSONGenerator, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonNode": PropTypes.oneOfType([_JSONNode, PropTypes.number, PropTypes.oneOf([null])]),
    "JSONNull": PropTypes.oneOfType([_JSONNull, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonParser": PropTypes.oneOfType([_JSONParser, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonReader": PropTypes.oneOfType([_JSONReader, PropTypes.number, PropTypes.oneOf([null])]),
    "JsonTokenType": PropTypes.oneOfType([_JSONTokenType, PropTypes.number, PropTypes.oneOf([null])]),
    "KSerializer": PropTypes.oneOfType([_KSerializer, PropTypes.number, PropTypes.oneOf([null])]),
    "lambda": PropTypes.oneOfType([_Lambda, PropTypes.number, PropTypes.oneOf([null])]),
    "lazy": PropTypes.oneOfType([_Lazy, PropTypes.number, PropTypes.oneOf([null])]),
    "left": PropTypes.oneOfType([_Left, PropTypes.number, PropTypes.oneOf([null])]),
    "let": PropTypes.oneOfType([_Let, PropTypes.number, PropTypes.oneOf([null])]),
    "list": PropTypes.oneOfType([_List, PropTypes.number, PropTypes.oneOf([null])]),
    "LocalDate": PropTypes.oneOfType([_LocalDate, PropTypes.number, PropTypes.oneOf([null])]),
    "Locale": PropTypes.oneOfType([_Locale, PropTypes.number, PropTypes.oneOf([null])]),
    "lock": PropTypes.oneOfType([_Lock, PropTypes.number, PropTypes.oneOf([null])]),
    "long": PropTypes.oneOfType([_Long, PropTypes.number, PropTypes.oneOf([null])]),
    "LongNode": PropTypes.oneOfType([_LongNode, PropTypes.number, PropTypes.oneOf([null])]),
    "map": PropTypes.oneOfType([_Map, PropTypes.number, PropTypes.oneOf([null])]),
    "MapEntry": PropTypes.oneOfType([_MapEntry, PropTypes.number, PropTypes.oneOf([null])]),
    "MarshalJSON": PropTypes.oneOfType([_MarshalJSON, PropTypes.number, PropTypes.oneOf([null])]),
    "metadata_property_handling": PropTypes.oneOfType([_MetadataPropertyHandling, PropTypes.number, PropTypes.oneOf([null])]),
    "module": PropTypes.oneOfType([_Module, PropTypes.number, PropTypes.oneOf([null])]),
    "mutable": PropTypes.oneOfType([_Mutable, PropTypes.number, PropTypes.oneOf([null])]),
    "mutating": PropTypes.oneOfType([_Mutating, PropTypes.number, PropTypes.oneOf([null])]),
    "namespace": PropTypes.oneOfType([_Namespace, PropTypes.number, PropTypes.oneOf([null])]),
    "native": PropTypes.oneOfType([_Native, PropTypes.number, PropTypes.oneOf([null])]),
    "new": PropTypes.oneOfType([_New, PropTypes.number, PropTypes.oneOf([null])]),
    "newtonsoft": PropTypes.oneOfType([_Newtonsoft, PropTypes.number, PropTypes.oneOf([null])]),
    "nil": PropTypes.oneOfType([_Nil, PropTypes.number, PropTypes.oneOf([null])]),
    "NO": PropTypes.oneOfType([_No, PropTypes.number, PropTypes.oneOf([null])]),
    "noexcept": PropTypes.oneOfType([_Noexcept, PropTypes.number, PropTypes.oneOf([null])]),
    "nonatomic": PropTypes.oneOfType([_Nonatomic, PropTypes.number, PropTypes.oneOf([null])]),
    "none": PropTypes.oneOfType([_NoneClass, PropTypes.number, PropTypes.oneOf([null])]),
    "None": PropTypes.oneOfType([_None, PropTypes.number, PropTypes.oneOf([null])]),
    "nonlocal": PropTypes.oneOfType([_Nonlocal, PropTypes.number, PropTypes.oneOf([null])]),
    "nonmutating": PropTypes.oneOfType([_Nonmutating, PropTypes.number, PropTypes.oneOf([null])]),
    "noSuchMethod": PropTypes.oneOfType([_NoSuchMethod, PropTypes.number, PropTypes.oneOf([null])]),
    "not": PropTypes.oneOfType([_Not, PropTypes.number, PropTypes.oneOf([null])]),
    "not_eq": PropTypes.oneOfType([_NotEq, PropTypes.number, PropTypes.oneOf([null])]),
    "NSError": PropTypes.oneOfType([_NSError, PropTypes.number, PropTypes.oneOf([null])]),
    "NSObject": PropTypes.oneOfType([_NSObject, PropTypes.number, PropTypes.oneOf([null])]),
    "NSString": PropTypes.oneOfType([_NSString, PropTypes.number, PropTypes.oneOf([null])]),
    "NULL": PropTypes.oneOfType([_Null, PropTypes.number, PropTypes.oneOf([null])]),
    "null": PropTypes.oneOfType([_NullClass, PropTypes.number, PropTypes.oneOf([null])]),
    "NullNode": PropTypes.oneOfType([_NullNode, PropTypes.number, PropTypes.oneOf([null])]),
    "nullptr": PropTypes.oneOfType([_Nullptr, PropTypes.number, PropTypes.oneOf([null])]),
    "number": PropTypes.oneOfType([_Number, PropTypes.number, PropTypes.oneOf([null])]),
    "object": PropTypes.oneOfType([_Object, PropTypes.number, PropTypes.oneOf([null])]),
    "ObjectMapper": PropTypes.oneOfType([_ObjectMapper, PropTypes.number, PropTypes.oneOf([null])]),
    "ObjectNode": PropTypes.oneOfType([_ObjectNode, PropTypes.number, PropTypes.oneOf([null])]),
    "ObjectReader": PropTypes.oneOfType([_ObjectReader, PropTypes.number, PropTypes.oneOf([null])]),
    "ObjectWriter": PropTypes.oneOfType([_ObjectWriter, PropTypes.number, PropTypes.oneOf([null])]),
    "of": PropTypes.oneOfType([_Of, PropTypes.number, PropTypes.oneOf([null])]),
    "OffsetDateTime": PropTypes.oneOfType([_OffsetDateTime, PropTypes.number, PropTypes.oneOf([null])]),
    "OffsetTime": PropTypes.oneOfType([_OffsetTime, PropTypes.number, PropTypes.oneOf([null])]),
    "oneway": PropTypes.oneOfType([_Oneway, PropTypes.number, PropTypes.oneOf([null])]),
    "open": PropTypes.oneOfType([_Open, PropTypes.number, PropTypes.oneOf([null])]),
    "operator": PropTypes.oneOfType([_Operator, PropTypes.number, PropTypes.oneOf([null])]),
    "optional": PropTypes.oneOfType([_Optional, PropTypes.number, PropTypes.oneOf([null])]),
    "or": PropTypes.oneOfType([_Or, PropTypes.number, PropTypes.oneOf([null])]),
    "or_eq": PropTypes.oneOfType([_OrEq, PropTypes.number, PropTypes.oneOf([null])]),
    "out": PropTypes.oneOfType([_Out, PropTypes.number, PropTypes.oneOf([null])]),
    "override": PropTypes.oneOfType([_Override, PropTypes.number, PropTypes.oneOf([null])]),
    "package": PropTypes.oneOfType([_Package, PropTypes.number, PropTypes.oneOf([null])]),
    "params": PropTypes.oneOfType([_Params, PropTypes.number, PropTypes.oneOf([null])]),
    "pass": PropTypes.oneOfType([_Pass, PropTypes.number, PropTypes.oneOf([null])]),
    "port": PropTypes.oneOfType([_Port, PropTypes.number, PropTypes.oneOf([null])]),
    "postfix": PropTypes.oneOfType([_Postfix, PropTypes.number, PropTypes.oneOf([null])]),
    "precedence": PropTypes.oneOfType([_Precedence, PropTypes.number, PropTypes.oneOf([null])]),
    "prefix": PropTypes.oneOfType([_Prefix, PropTypes.number, PropTypes.oneOf([null])]),
    "PrimitiveKind": PropTypes.oneOfType([_PrimitiveKind, PropTypes.number, PropTypes.oneOf([null])]),
    "print": PropTypes.oneOfType([_Print, PropTypes.number, PropTypes.oneOf([null])]),
    "printf": PropTypes.oneOfType([_Printf, PropTypes.number, PropTypes.oneOf([null])]),
    "printMembers": PropTypes.oneOfType([_PrintMembers, PropTypes.number, PropTypes.oneOf([null])]),
    "private": PropTypes.oneOfType([_Private, PropTypes.number, PropTypes.oneOf([null])]),
    "protected": PropTypes.oneOfType([_Protected, PropTypes.number, PropTypes.oneOf([null])]),
    "Protocol": PropTypes.oneOfType([_Protocol, PropTypes.number, PropTypes.oneOf([null])]),
    "protocol": PropTypes.oneOfType([_ProtocolClass, PropTypes.number, PropTypes.oneOf([null])]),
    "public": PropTypes.oneOfType([_Public, PropTypes.number, PropTypes.oneOf([null])]),
    "quicktype": PropTypes.oneOfType([_Quicktype, PropTypes.number, PropTypes.oneOf([null])]),
    "raise": PropTypes.oneOfType([_Raise, PropTypes.number, PropTypes.oneOf([null])]),
    "range": PropTypes.oneOfType([_Range, PropTypes.number, PropTypes.oneOf([null])]),
    "readonly": PropTypes.oneOfType([_Readonly, PropTypes.number, PropTypes.oneOf([null])]),
    "ref": PropTypes.oneOfType([_Ref, PropTypes.number, PropTypes.oneOf([null])]),
    "RegExp": PropTypes.oneOfType([_RegExp, PropTypes.number, PropTypes.oneOf([null])]),
    "register": PropTypes.oneOfType([_Register, PropTypes.number, PropTypes.oneOf([null])]),
    "reinterpret_cast": PropTypes.oneOfType([_ReinterpretCast, PropTypes.number, PropTypes.oneOf([null])]),
    "repeat": PropTypes.oneOfType([_Repeat, PropTypes.number, PropTypes.oneOf([null])]),
    "require": PropTypes.oneOfType([_Require, PropTypes.number, PropTypes.oneOf([null])]),
    "required": PropTypes.oneOfType([_Required, PropTypes.number, PropTypes.oneOf([null])]),
    "requires": PropTypes.oneOfType([_Requires, PropTypes.number, PropTypes.oneOf([null])]),
    "restrict": PropTypes.oneOfType([_Restrict, PropTypes.number, PropTypes.oneOf([null])]),
    "retain": PropTypes.oneOfType([_Retain, PropTypes.number, PropTypes.oneOf([null])]),
    "rethrows": PropTypes.oneOfType([_Rethrows, PropTypes.number, PropTypes.oneOf([null])]),
    "return": PropTypes.oneOfType([_Return, PropTypes.number, PropTypes.oneOf([null])]),
    "right": PropTypes.oneOfType([_Right, PropTypes.number, PropTypes.oneOf([null])]),
    "runtimeType": PropTypes.oneOfType([_RuntimeType, PropTypes.number, PropTypes.oneOf([null])]),
    "s": PropTypes.oneOfType([_S, PropTypes.number, PropTypes.oneOf([null])]),
    "sbyte": PropTypes.oneOfType([_Sbyte, PropTypes.number, PropTypes.oneOf([null])]),
    "sealed": PropTypes.oneOfType([_Sealed, PropTypes.number, PropTypes.oneOf([null])]),
    "SEL": PropTypes.oneOfType([_Sel, PropTypes.number, PropTypes.oneOf([null])]),
    "select": PropTypes.oneOfType([_Select, PropTypes.number, PropTypes.oneOf([null])]),
    "Self": PropTypes.oneOfType([_Self, PropTypes.number, PropTypes.oneOf([null])]),
    "self": PropTypes.oneOfType([_SelfClass, PropTypes.number, PropTypes.oneOf([null])]),
    "Sendable": PropTypes.oneOfType([_Sendable, PropTypes.number, PropTypes.oneOf([null])]),
    "SerialDescriptor": PropTypes.oneOfType([_SerialDescriptor, PropTypes.number, PropTypes.oneOf([null])]),
    "Serializable": PropTypes.oneOfType([_Serializable, PropTypes.number, PropTypes.oneOf([null])]),
    "SerializationFeature": PropTypes.oneOfType([_SerializationFeature, PropTypes.number, PropTypes.oneOf([null])]),
    "serialize": PropTypes.oneOfType([_Serialize, PropTypes.number, PropTypes.oneOf([null])]),
    "SerializerProvider": PropTypes.oneOfType([_SerializerProvider, PropTypes.number, PropTypes.oneOf([null])]),
    "SerialName": PropTypes.oneOfType([_SerialName, PropTypes.number, PropTypes.oneOf([null])]),
    "set": PropTypes.oneOfType([_Set, PropTypes.number, PropTypes.oneOf([null])]),
    "short": PropTypes.oneOfType([_Short, PropTypes.number, PropTypes.oneOf([null])]),
    "signed": PropTypes.oneOfType([_Signed, PropTypes.number, PropTypes.oneOf([null])]),
    "SimpleModule": PropTypes.oneOfType([_SimpleModule, PropTypes.number, PropTypes.oneOf([null])]),
    "sizeof": PropTypes.oneOfType([_Sizeof, PropTypes.number, PropTypes.oneOf([null])]),
    "stackalloc": PropTypes.oneOfType([_Stackalloc, PropTypes.number, PropTypes.oneOf([null])]),
    "Standards": PropTypes.oneOfType([_Standards, PropTypes.number, PropTypes.oneOf([null])]),
    "static": PropTypes.oneOfType([_Static, PropTypes.number, PropTypes.oneOf([null])]),
    "static_assert": PropTypes.oneOfType([_StaticAssert, PropTypes.number, PropTypes.oneOf([null])]),
    "static_cast": PropTypes.oneOfType([_StaticCast, PropTypes.number, PropTypes.oneOf([null])]),
    "StdDeserializer": PropTypes.oneOfType([_StdDeserializer, PropTypes.number, PropTypes.oneOf([null])]),
    "StdSerializer": PropTypes.oneOfType([_StdSerializer, PropTypes.number, PropTypes.oneOf([null])]),
    "strictfp": PropTypes.oneOfType([_Strictfp, PropTypes.number, PropTypes.oneOf([null])]),
    "string": PropTypes.oneOfType([_String, PropTypes.number, PropTypes.oneOf([null])]),
    "struct": PropTypes.oneOfType([_Struct, PropTypes.number, PropTypes.oneOf([null])]),
    "subscript": PropTypes.oneOfType([_Subscript, PropTypes.number, PropTypes.oneOf([null])]),
    "super": PropTypes.oneOfType([_Super, PropTypes.number, PropTypes.oneOf([null])]),
    "switch": PropTypes.oneOfType([_Switch, PropTypes.number, PropTypes.oneOf([null])]),
    "symbol": PropTypes.oneOfType([_Symbol, PropTypes.number, PropTypes.oneOf([null])]),
    "synchronized": PropTypes.oneOfType([_Synchronized, PropTypes.number, PropTypes.oneOf([null])]),
    "system": PropTypes.oneOfType([_System, PropTypes.number, PropTypes.oneOf([null])]),
    "template": PropTypes.oneOfType([_Template, PropTypes.number, PropTypes.oneOf([null])]),
    "TextNode": PropTypes.oneOfType([_TextNode, PropTypes.number, PropTypes.oneOf([null])]),
    "then": PropTypes.oneOfType([_Then, PropTypes.number, PropTypes.oneOf([null])]),
    "this": PropTypes.oneOfType([_This, PropTypes.number, PropTypes.oneOf([null])]),
    "thread_local": PropTypes.oneOfType([_ThreadLocal, PropTypes.number, PropTypes.oneOf([null])]),
    "throw": PropTypes.oneOfType([_Throw, PropTypes.number, PropTypes.oneOf([null])]),
    "throws": PropTypes.oneOfType([_Throws, PropTypes.number, PropTypes.oneOf([null])]),
    "TimeOnly": PropTypes.oneOfType([_TimeOnly, PropTypes.number, PropTypes.oneOf([null])]),
    "TimeOnlyConverter": PropTypes.oneOfType([_TimeOnlyConverter, PropTypes.number, PropTypes.oneOf([null])]),
    "TimeZone": PropTypes.oneOfType([_TimeZone, PropTypes.number, PropTypes.oneOf([null])]),
    "to_dict": PropTypes.oneOfType([_ToDict, PropTypes.number, PropTypes.oneOf([null])]),
    "to_json": PropTypes.oneOfType([_ToJSON, PropTypes.number, PropTypes.oneOf([null])]),
    "top_level": PropTypes.oneOfType([_TopLevelClass, PropTypes.number, PropTypes.oneOf([null])]),
    "toString": (props, name, ...args) => Object.prototype.hasOwnProperty.call(props, name) ? PropTypes.oneOfType([_ToString, PropTypes.number, PropTypes.oneOf([null])])(props, name, ...args) : null,
    "transient": PropTypes.oneOfType([_Transient, PropTypes.number, PropTypes.oneOf([null])]),
    "True": PropTypes.oneOfType([_True, PropTypes.number, PropTypes.oneOf([null])]),
    "true": PropTypes.oneOfType([_TrueClass, PropTypes.number, PropTypes.oneOf([null])]),
    "try": PropTypes.oneOfType([_Try, PropTypes.number, PropTypes.oneOf([null])]),
    "Type": PropTypes.oneOfType([_Type, PropTypes.number, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_TypeClass, PropTypes.number, PropTypes.oneOf([null])]),
    "typealias": PropTypes.oneOfType([_Typealias, PropTypes.number, PropTypes.oneOf([null])]),
    "typedef": PropTypes.oneOfType([_Typedef, PropTypes.number, PropTypes.oneOf([null])]),
    "typeid": PropTypes.oneOfType([_Typeid, PropTypes.number, PropTypes.oneOf([null])]),
    "typename": PropTypes.oneOfType([_Typename, PropTypes.number, PropTypes.oneOf([null])]),
    "typeof": PropTypes.oneOfType([_Typeof, PropTypes.number, PropTypes.oneOf([null])]),
    "uint": PropTypes.oneOfType([_Uint, PropTypes.number, PropTypes.oneOf([null])]),
    "ulong": PropTypes.oneOfType([_Ulong, PropTypes.number, PropTypes.oneOf([null])]),
    "unchecked": PropTypes.oneOfType([_Unchecked, PropTypes.number, PropTypes.oneOf([null])]),
    "undefined": PropTypes.oneOfType([_Undefined, PropTypes.number, PropTypes.oneOf([null])]),
    "union": PropTypes.oneOfType([_Union, PropTypes.number, PropTypes.oneOf([null])]),
    "UnmarshalJSON": PropTypes.oneOfType([_UnmarshalJSON, PropTypes.number, PropTypes.oneOf([null])]),
    "unowned": PropTypes.oneOfType([_Unowned, PropTypes.number, PropTypes.oneOf([null])]),
    "unsafe": PropTypes.oneOfType([_Unsafe, PropTypes.number, PropTypes.oneOf([null])]),
    "unsigned": PropTypes.oneOfType([_Unsigned, PropTypes.number, PropTypes.oneOf([null])]),
    "UseSerializers": PropTypes.oneOfType([_UseSerializers, PropTypes.number, PropTypes.oneOf([null])]),
    "ushort": PropTypes.oneOfType([_Ushort, PropTypes.number, PropTypes.oneOf([null])]),
    "using": PropTypes.oneOfType([_Using, PropTypes.number, PropTypes.oneOf([null])]),
    "Utf8JsonReader": PropTypes.oneOfType([_Utf8JSONReader, PropTypes.number, PropTypes.oneOf([null])]),
    "Utf8JsonWriter": PropTypes.oneOfType([_Utf8JSONWriter, PropTypes.number, PropTypes.oneOf([null])]),
    "UUID": PropTypes.oneOfType([_UUID, PropTypes.number, PropTypes.oneOf([null])]),
    "var": PropTypes.oneOfType([_Var, PropTypes.number, PropTypes.oneOf([null])]),
    "virtual": PropTypes.oneOfType([_Virtual, PropTypes.number, PropTypes.oneOf([null])]),
    "void": PropTypes.oneOfType([_Void, PropTypes.number, PropTypes.oneOf([null])]),
    "volatile": PropTypes.oneOfType([_Volatile, PropTypes.number, PropTypes.oneOf([null])]),
    "wchar_t": PropTypes.oneOfType([_WcharT, PropTypes.number, PropTypes.oneOf([null])]),
    "weak": PropTypes.oneOfType([_Weak, PropTypes.number, PropTypes.oneOf([null])]),
    "where": PropTypes.oneOfType([_Where, PropTypes.number, PropTypes.oneOf([null])]),
    "while": PropTypes.oneOfType([_While, PropTypes.number, PropTypes.oneOf([null])]),
    "willSet": PropTypes.oneOfType([_WillSet, PropTypes.number, PropTypes.oneOf([null])]),
    "with": PropTypes.oneOfType([_With, PropTypes.number, PropTypes.oneOf([null])]),
    "xor": PropTypes.oneOfType([_Xor, PropTypes.number, PropTypes.oneOf([null])]),
    "xor_eq": PropTypes.oneOfType([_XorEq, PropTypes.number, PropTypes.oneOf([null])]),
    "YES": PropTypes.oneOfType([_Yes, PropTypes.number, PropTypes.oneOf([null])]),
    "yield": PropTypes.oneOfType([_Yield, PropTypes.number, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
