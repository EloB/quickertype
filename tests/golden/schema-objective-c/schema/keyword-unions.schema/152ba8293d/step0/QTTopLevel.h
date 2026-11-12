// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTAbstract;
@class QTAlignas;
@class QTAlignof;
@class QTAnd;
@class QTAndEq;
@class QTAny;
@class QTArray;
@class QTArrayNode;
@class QTAs;
@class QTAssert;
@class QTAssociatedtype;
@class QTAssociativity;
@class QTAsync;
@class QTAtomicCancel;
@class QTAtomicCommit;
@class QTAtomicNoexcept;
@class QTAwait;
@class QTBase;
@class QTBitand;
@class QTBitor;
@class QTBoolean;
@class QTBooleanNode;
@class QTBycopy;
@class QTByref;
@class QTByte;
@class QTCalendar;
@class QTCatch;
@class QTChan;
@class QTChar16T;
@class QTChar32T;
@class QTChecked;
@class QTClass;
@class QTClone;
@class QTCoAwait;
@class QTCoReturn;
@class QTCoYield;
@class QTCodable;
@class QTCodingKey;
@class QTCodingKeys;
@class QTCompl;
@class QTComplex;
@class QTConcept;
@class QTConsole;
@class QTConstCast;
@class QTConstexpr;
@class QTConstructor;
@class QTConvenience;
@class QTConvert;
@class QTConverter;
@class QTCultureInfo;
@class QTDate;
@class QTDateFormatter;
@class QTDateOnly;
@class QTDateOnlyConverter;
@class QTDateParseHandling;
@class QTDateTime;
@class QTDateTimeStyles;
@class QTDebugger;
@class QTDecimal;
@class QTDeclare;
@class QTDecltype;
@class QTDecodeString;
@class QTDecoder;
@class QTDecodingError;
@class QTDef;
@class QTDefer;
@class QTDeinit;
@class QTDel;
@class QTDelegate;
@class QTDelete;
@class QTDeserializationFeature;
@class QTDict;
@class QTDictionary;
@class QTDidSet;
@class QTDoubleNode;
@class QTDynamic;
@class QTDynamicCast;
@class QTElif;
@class QTEmpty;
@class QTEncodeQuickType;
@class QTEncoder;
@class QTEnumValues;
@class QTEqualityContract;
@class QTEquatable;
@class QTEvent;
@class QTExcept;
@class QTException;
@class QTExplicit;
@class QTExport;
@class QTExposing;
@class QTExtends;
@class QTExtension;
@class QTFallthrough;
@class QTFileprivate;
@class QTFinal;
@class QTFinally;
@class QTFixed;
@class QTForeach;
@class QTFormatException;
@class QTFriend;
@class QTFrom;
@class QTFromDict;
@class QTFromJSON;
@class QTFunc;
@class QTFunction;
@class QTGet;
@class QTGlobal;
@class QTGo;
@class QTGuard;
@class QTHasOwnProperty;
@class QTHashable;
@class QTHasher;
@class QTID;
@class QTImaginery;
@class QTImp;
@class QTImplements;
@class QTImplicit;
@class QTImport;
@class QTIn;
@class QTIndirect;
@class QTInfix;
@class QTInout;
@class QTInstanceof;
@class QTIntNode;
@class QTInterface;
@class QTInternal;
@class QTIs;
@class QTISODateTimeOffsetConverter;
@class QTIterable;
@class QTJdec;
@class QTJenc;
@class QTJpipe;
@class QTJSON;
@class QTJSONAny;
@class QTJSONCodingKey;
@class QTJSONConverter;
@class QTJSONDecoder;
@class QTJSONEncoder;
@class QTJSONException;
@class QTJSONGenerator;
@class QTJSONNode;
@class QTJSONNull;
@class QTJSONParser;
@class QTJSONReader;
@class QTJSONSerializer;
@class QTJSONToken;
@class QTJSONTokenType;
@class QTJSONWriter;
@class QTKSerializer;
@class QTLambda;
@class QTLazy;
@class QTLeft;
@class QTLet;
@class QTList;
@class QTLocalDate;
@class QTLocale;
@class QTLock;
@class QTLongNode;
@class QTMap;
@class QTMapEntry;
@class QTMarshalJSON;
@class QTMetadataPropertyHandling;
@class QTModule;
@class QTMutable;
@class QTMutating;
@class QTNamespace;
@class QTNative;
@class QTNewtonsoft;
@class QTNo;
@class QTNoSuchMethod;
@class QTNoexcept;
@class QTNone;
@class QTNonlocal;
@class QTNonmutating;
@class QTNot;
@class QTNotEq;
@class QTNSError;
@class QTNSObject;
@class QTNSString;
@class QTNull;
@class QTNullNode;
@class QTNullptr;
@class QTNumber;
@class QTObject;
@class QTObjectMapper;
@class QTObjectNode;
@class QTObjectReader;
@class QTObjectWriter;
@class QTOf;
@class QTOffsetDateTime;
@class QTOffsetTime;
@class QTOneway;
@class QTOpen;
@class QTOperator;
@class QTOptional;
@class QTOr;
@class QTOrEq;
@class QTOut;
@class QTOverride;
@class QTPackage;
@class QTParams;
@class QTPass;
@class QTPort;
@class QTPostfix;
@class QTPrecedence;
@class QTPrefix;
@class QTPrimitiveKind;
@class QTPrint;
@class QTPrintMembers;
@class QTPrintf;
@class QTPrivate;
@class QTProtected;
@class QTProtocol;
@class QTPublic;
@class QTASM;
@class QTAnyClass;
@class QTAtomic;
@class QTAuto;
@class QTBool;
@class QTBoolClass;
@class QTBreak;
@class QTCase;
@class QTChar;
@class QTClassClass;
@class QTConst;
@class QTContinue;
@class QTDefault;
@class QTDo;
@class QTDouble;
@class QTElse;
@class QTEnum;
@class QTExtern;
@class QTFalse;
@class QTFloat;
@class QTFor;
@class QTGoto;
@class QTIf;
@class QTInline;
@class QTInt;
@class QTLong;
@class QTNil;
@class QTNonatomic;
@class QTNoneClass;
@class QTNullClass;
@class QTProtocolClass;
@class QTRegister;
@class QTRestrict;
@class QTRetain;
@class QTReturn;
@class QTSelfClass;
@class QTShort;
@class QTSigned;
@class QTSizeof;
@class QTStatic;
@class QTStruct;
@class QTSwitch;
@class QTTrue;
@class QTTypeClass;
@class QTTypedef;
@class QTTypeof;
@class QTUnion;
@class QTUnsigned;
@class QTVoid;
@class QTVolatile;
@class QTWhile;
@class QTQuicktype;
@class QTRaise;
@class QTRange;
@class QTReadonly;
@class QTRef;
@class QTRegExp;
@class QTReinterpretCast;
@class QTRepeat;
@class QTRequire;
@class QTRequired;
@class QTRequires;
@class QTRethrows;
@class QTRight;
@class QTRuntimeType;
@class QTS;
@class QTSbyte;
@class QTSealed;
@class QTSel;
@class QTSelect;
@class QTSelf;
@class QTSendable;
@class QTSerialDescriptor;
@class QTSerialName;
@class QTSerializable;
@class QTSerializationFeature;
@class QTSerialize;
@class QTSerializerProvider;
@class QTSet;
@class QTSimpleModule;
@class QTStackalloc;
@class QTStandards;
@class QTStaticAssert;
@class QTStaticCast;
@class QTStdDeserializer;
@class QTStdSerializer;
@class QTStrictfp;
@class QTString;
@class QTSubscript;
@class QTSuper;
@class QTSymbol;
@class QTSynchronized;
@class QTSystem;
@class QTTemplate;
@class QTTextNode;
@class QTUnionBoolBool;
@class QTFalseClass;
@class QTHashCode;
@class QTInit;
@class QTNew;
@class QTTrueClass;
@class QTThen;
@class QTThis;
@class QTThreadLocal;
@class QTThrow;
@class QTThrows;
@class QTTimeOnly;
@class QTTimeOnlyConverter;
@class QTTimeZone;
@class QTToDict;
@class QTToJSON;
@class QTToString;
@class QTTopLevelClass;
@class QTTransient;
@class QTTry;
@class QTType;
@class QTTypealias;
@class QTTypeid;
@class QTTypename;
@class QTUint;
@class QTUlong;
@class QTUnchecked;
@class QTUndefined;
@class QTUnmarshalJSON;
@class QTUnowned;
@class QTUnsafe;
@class QTUseSerializers;
@class QTUshort;
@class QTUsing;
@class QTUtf8JSONReader;
@class QTUtf8JSONWriter;
@class QTUUID;
@class QTVar;
@class QTVirtual;
@class QTWcharT;
@class QTWeak;
@class QTWhere;
@class QTWillSet;
@class QTWith;
@class QTXor;
@class QTXorEq;
@class QTYes;
@class QTYield;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, copy)   id empty;
@property (nonatomic, nullable, copy)   id qtTopLevelBool;
@property (nonatomic, nullable, copy)   id complex;
@property (nonatomic, nullable, copy)   id imaginery;
@property (nonatomic, nullable, copy)   id abstract;
@property (nonatomic, nullable, copy)   id alignas;
@property (nonatomic, nullable, copy)   id alignof;
@property (nonatomic, nullable, copy)   id and;
@property (nonatomic, nullable, copy)   id andEq;
@property (nonatomic, nullable, copy)   id qtTopLevelAny;
@property (nonatomic, nullable, copy)   id any;
@property (nonatomic, nullable, copy)   id array;
@property (nonatomic, nullable, copy)   id arrayNode;
@property (nonatomic, nullable, copy)   id as;
@property (nonatomic, nullable, copy)   id qtTopLevelASM;
@property (nonatomic, nullable, copy)   id assert;
@property (nonatomic, nullable, copy)   id associatedtype;
@property (nonatomic, nullable, copy)   id associativity;
@property (nonatomic, nullable, copy)   id async;
@property (nonatomic, nullable, copy)   id qtTopLevelAtomic;
@property (nonatomic, nullable, copy)   id atomicCancel;
@property (nonatomic, nullable, copy)   id atomicCommit;
@property (nonatomic, nullable, copy)   id atomicNoexcept;
@property (nonatomic, nullable, copy)   id qtTopLevelAuto;
@property (nonatomic, nullable, copy)   id await;
@property (nonatomic, nullable, copy)   id base;
@property (nonatomic, nullable, copy)   id bitand;
@property (nonatomic, nullable, copy)   id bitor;
@property (nonatomic, nullable, copy)   id qtTopLevelBOOL;
@property (nonatomic, nullable, copy)   id theBool;
@property (nonatomic, nullable, copy)   id boolean;
@property (nonatomic, nullable, copy)   id booleanNode;
@property (nonatomic, nullable, copy)   id qtTopLevelBreak;
@property (nonatomic, nullable, copy)   id bycopy;
@property (nonatomic, nullable, copy)   id byref;
@property (nonatomic, nullable, copy)   id byte;
@property (nonatomic, nullable, copy)   id calendar;
@property (nonatomic, nullable, copy)   id qtTopLevelCase;
@property (nonatomic, nullable, copy)   id catch;
@property (nonatomic, nullable, copy)   id chan;
@property (nonatomic, nullable, copy)   id qtTopLevelChar;
@property (nonatomic, nullable, copy)   id char16T;
@property (nonatomic, nullable, copy)   id char32T;
@property (nonatomic, nullable, copy)   id checked;
@property (nonatomic, nullable, copy)   id qtTopLevelClass;
@property (nonatomic, nullable, copy)   id class;
@property (nonatomic, nullable, copy)   id clone;
@property (nonatomic, nullable, copy)   id coAwait;
@property (nonatomic, nullable, copy)   id coReturn;
@property (nonatomic, nullable, copy)   id coYield;
@property (nonatomic, nullable, copy)   id codable;
@property (nonatomic, nullable, copy)   id codingKey;
@property (nonatomic, nullable, copy)   id codingKeys;
@property (nonatomic, nullable, copy)   id compl;
@property (nonatomic, nullable, copy)   id concept;
@property (nonatomic, nullable, copy)   id console;
@property (nonatomic, nullable, copy)   id qtTopLevelConst;
@property (nonatomic, nullable, copy)   id constCast;
@property (nonatomic, nullable, copy)   id constexpr;
@property (nonatomic, nullable, copy)   id constructor;
@property (nonatomic, nullable, copy)   id qtTopLevelContinue;
@property (nonatomic, nullable, copy)   id convenience;
@property (nonatomic, nullable, copy)   id convert;
@property (nonatomic, nullable, copy)   id converter;
@property (nonatomic, nullable, copy)   id cultureInfo;
@property (nonatomic, nullable, copy)   id date;
@property (nonatomic, nullable, copy)   id dateParseHandling;
@property (nonatomic, nullable, copy)   id dateFormatter;
@property (nonatomic, nullable, copy)   id dateOnly;
@property (nonatomic, nullable, copy)   id dateOnlyConverter;
@property (nonatomic, nullable, copy)   id dateTime;
@property (nonatomic, nullable, copy)   id dateTimeStyles;
@property (nonatomic, nullable, copy)   id debugger;
@property (nonatomic, nullable, copy)   id decimal;
@property (nonatomic, nullable, copy)   id declare;
@property (nonatomic, nullable, copy)   id decltype;
@property (nonatomic, nullable, copy)   id decodeString;
@property (nonatomic, nullable, copy)   id decoder;
@property (nonatomic, nullable, copy)   id decodingError;
@property (nonatomic, nullable, copy)   id def;
@property (nonatomic, nullable, copy)   id qtTopLevelDefault;
@property (nonatomic, nullable, copy)   id defer;
@property (nonatomic, nullable, copy)   id deinit;
@property (nonatomic, nullable, copy)   id del;
@property (nonatomic, nullable, copy)   id delegate;
@property (nonatomic, nullable, copy)   id delete;
@property (nonatomic, nullable, copy)   id deserializationFeature;
@property (nonatomic, nullable, copy)   id dict;
@property (nonatomic, nullable, copy)   id dictionary;
@property (nonatomic, nullable, copy)   id didSet;
@property (nonatomic, nullable, copy)   id qtTopLevelDo;
@property (nonatomic, nullable, copy)   id qtTopLevelDouble;
@property (nonatomic, nullable, copy)   id doubleNode;
@property (nonatomic, nullable, strong) NSNumber *dummy;
@property (nonatomic, nullable, copy)   id dynamic;
@property (nonatomic, nullable, copy)   id dynamicCast;
@property (nonatomic, nullable, copy)   id elif;
@property (nonatomic, nullable, copy)   id qtTopLevelElse;
@property (nonatomic, nullable, copy)   id encodeQuickType;
@property (nonatomic, nullable, copy)   id encoder;
@property (nonatomic, nullable, copy)   id qtTopLevelEnum;
@property (nonatomic, nullable, copy)   id enumValues;
@property (nonatomic, nullable, copy)   id equalityContract;
@property (nonatomic, nullable, copy)   id equatable;
@property (nonatomic, nullable, copy)   id event;
@property (nonatomic, nullable, copy)   id except;
@property (nonatomic, nullable, copy)   id exception;
@property (nonatomic, nullable, copy)   id explicit;
@property (nonatomic, nullable, copy)   id export;
@property (nonatomic, nullable, copy)   id exposing;
@property (nonatomic, nullable, copy)   id extends;
@property (nonatomic, nullable, copy)   id extension;
@property (nonatomic, nullable, copy)   id qtTopLevelExtern;
@property (nonatomic, nullable, copy)   id fallthrough;
@property (nonatomic, nullable, copy)   id theFalse;
@property (nonatomic, nullable, copy)   id qtTopLevelFalse;
@property (nonatomic, nullable, copy)   id fileprivate;
@property (nonatomic, nullable, copy)   id final;
@property (nonatomic, nullable, copy)   id finally;
@property (nonatomic, nullable, copy)   id fixed;
@property (nonatomic, nullable, copy)   id qtTopLevelFloat;
@property (nonatomic, nullable, copy)   id qtTopLevelFor;
@property (nonatomic, nullable, copy)   id foreach;
@property (nonatomic, nullable, copy)   id formatException;
@property (nonatomic, nullable, copy)   id friend;
@property (nonatomic, nullable, copy)   id from;
@property (nonatomic, nullable, copy)   id fromDict;
@property (nonatomic, nullable, copy)   id fromJSON;
@property (nonatomic, nullable, copy)   id func;
@property (nonatomic, nullable, copy)   id function;
@property (nonatomic, nullable, copy)   id get;
@property (nonatomic, nullable, copy)   id global;
@property (nonatomic, nullable, copy)   id go;
@property (nonatomic, nullable, copy)   id qtTopLevelGoto;
@property (nonatomic, nullable, copy)   id guard;
@property (nonatomic, nullable, copy)   id hashable;
@property (nonatomic, nullable, copy)   id theHashCode;
@property (nonatomic, nullable, copy)   id hasher;
@property (nonatomic, nullable, copy)   id hasOwnProperty;
@property (nonatomic, nullable, copy)   id identifier;
@property (nonatomic, nullable, copy)   id qtTopLevelIf;
@property (nonatomic, nullable, copy)   id imp;
@property (nonatomic, nullable, copy)   id implements;
@property (nonatomic, nullable, copy)   id implicit;
@property (nonatomic, nullable, copy)   id import;
@property (nonatomic, nullable, copy)   id in;
@property (nonatomic, nullable, copy)   id indirect;
@property (nonatomic, nullable, copy)   id infix;
@property (nonatomic, nullable, copy)   id theInit;
@property (nonatomic, nullable, copy)   id qtTopLevelInline;
@property (nonatomic, nullable, copy)   id inout;
@property (nonatomic, nullable, copy)   id instanceof;
@property (nonatomic, nullable, copy)   id qtTopLevelInt;
@property (nonatomic, nullable, copy)   id interface;
@property (nonatomic, nullable, copy)   id internal;
@property (nonatomic, nullable, copy)   id intNode;
@property (nonatomic, nullable, copy)   id is;
@property (nonatomic, nullable, copy)   id isoDateTimeOffsetConverter;
@property (nonatomic, nullable, copy)   id iterable;
@property (nonatomic, nullable, copy)   id jdec;
@property (nonatomic, nullable, copy)   id jenc;
@property (nonatomic, nullable, copy)   id jpipe;
@property (nonatomic, nullable, copy)   id json;
@property (nonatomic, nullable, copy)   id jsonConverter;
@property (nonatomic, nullable, copy)   id jsonSerializer;
@property (nonatomic, nullable, copy)   id jsonToken;
@property (nonatomic, nullable, copy)   id jsonWriter;
@property (nonatomic, nullable, copy)   id jsonAny;
@property (nonatomic, nullable, copy)   id jsonCodingKey;
@property (nonatomic, nullable, copy)   id jsonDecoder;
@property (nonatomic, nullable, copy)   id jsonEncoder;
@property (nonatomic, nullable, copy)   id jsonException;
@property (nonatomic, nullable, copy)   id jsonGenerator;
@property (nonatomic, nullable, copy)   id jsonNode;
@property (nonatomic, nullable, copy)   id jsonNull;
@property (nonatomic, nullable, copy)   id jsonParser;
@property (nonatomic, nullable, copy)   id jsonReader;
@property (nonatomic, nullable, copy)   id jsonTokenType;
@property (nonatomic, nullable, copy)   id kSerializer;
@property (nonatomic, nullable, copy)   id lambda;
@property (nonatomic, nullable, copy)   id lazy;
@property (nonatomic, nullable, copy)   id left;
@property (nonatomic, nullable, copy)   id let;
@property (nonatomic, nullable, copy)   id list;
@property (nonatomic, nullable, copy)   id localDate;
@property (nonatomic, nullable, copy)   id locale;
@property (nonatomic, nullable, copy)   id lock;
@property (nonatomic, nullable, copy)   id qtTopLevelLong;
@property (nonatomic, nullable, copy)   id longNode;
@property (nonatomic, nullable, copy)   id map;
@property (nonatomic, nullable, copy)   id mapEntry;
@property (nonatomic, nullable, copy)   id marshalJSON;
@property (nonatomic, nullable, copy)   id metadataPropertyHandling;
@property (nonatomic, nullable, copy)   id module;
@property (nonatomic, nullable, copy)   id mutable;
@property (nonatomic, nullable, copy)   id mutating;
@property (nonatomic, nullable, copy)   id namespace;
@property (nonatomic, nullable, copy)   id native;
@property (nonatomic, nullable, copy)   id theNew;
@property (nonatomic, nullable, copy)   id newtonsoft;
@property (nonatomic, nullable, copy)   id qtTopLevelNil;
@property (nonatomic, nullable, copy)   id no;
@property (nonatomic, nullable, copy)   id noexcept;
@property (nonatomic, nullable, copy)   id qtTopLevelNonatomic;
@property (nonatomic, nullable, copy)   id qtTopLevelNone;
@property (nonatomic, nullable, copy)   id none;
@property (nonatomic, nullable, copy)   id nonlocal;
@property (nonatomic, nullable, copy)   id nonmutating;
@property (nonatomic, nullable, copy)   id noSuchMethod;
@property (nonatomic, nullable, copy)   id not;
@property (nonatomic, nullable, copy)   id notEq;
@property (nonatomic, nullable, copy)   id nsError;
@property (nonatomic, nullable, copy)   id nsObject;
@property (nonatomic, nullable, copy)   id nsString;
@property (nonatomic, nullable, copy)   id null;
@property (nonatomic, nullable, copy)   id qtTopLevelNull;
@property (nonatomic, nullable, copy)   id nullNode;
@property (nonatomic, nullable, copy)   id nullptr;
@property (nonatomic, nullable, copy)   id number;
@property (nonatomic, nullable, copy)   id object;
@property (nonatomic, nullable, copy)   id objectMapper;
@property (nonatomic, nullable, copy)   id objectNode;
@property (nonatomic, nullable, copy)   id objectReader;
@property (nonatomic, nullable, copy)   id objectWriter;
@property (nonatomic, nullable, copy)   id of;
@property (nonatomic, nullable, copy)   id offsetDateTime;
@property (nonatomic, nullable, copy)   id offsetTime;
@property (nonatomic, nullable, copy)   id oneway;
@property (nonatomic, nullable, copy)   id open;
@property (nonatomic, nullable, copy)   id operator;
@property (nonatomic, nullable, copy)   id optional;
@property (nonatomic, nullable, copy)   id or;
@property (nonatomic, nullable, copy)   id orEq;
@property (nonatomic, nullable, copy)   id out;
@property (nonatomic, nullable, copy)   id override;
@property (nonatomic, nullable, copy)   id package;
@property (nonatomic, nullable, copy)   id params;
@property (nonatomic, nullable, copy)   id pass;
@property (nonatomic, nullable, copy)   id port;
@property (nonatomic, nullable, copy)   id postfix;
@property (nonatomic, nullable, copy)   id precedence;
@property (nonatomic, nullable, copy)   id prefix;
@property (nonatomic, nullable, copy)   id primitiveKind;
@property (nonatomic, nullable, copy)   id print;
@property (nonatomic, nullable, copy)   id printf;
@property (nonatomic, nullable, copy)   id printMembers;
@property (nonatomic, nullable, copy)   id private;
@property (nonatomic, nullable, copy)   id protected;
@property (nonatomic, nullable, copy)   id protocol;
@property (nonatomic, nullable, copy)   id qtTopLevelProtocol;
@property (nonatomic, nullable, copy)   id public;
@property (nonatomic, nullable, copy)   id quicktype;
@property (nonatomic, nullable, copy)   id raise;
@property (nonatomic, nullable, copy)   id range;
@property (nonatomic, nullable, copy)   id readonly;
@property (nonatomic, nullable, copy)   id ref;
@property (nonatomic, nullable, copy)   id regExp;
@property (nonatomic, nullable, copy)   id qtTopLevelRegister;
@property (nonatomic, nullable, copy)   id reinterpretCast;
@property (nonatomic, nullable, copy)   id repeat;
@property (nonatomic, nullable, copy)   id require;
@property (nonatomic, nullable, copy)   id required;
@property (nonatomic, nullable, copy)   id requires;
@property (nonatomic, nullable, copy)   id qtTopLevelRestrict;
@property (nonatomic, nullable, copy)   id qtTopLevelRetain;
@property (nonatomic, nullable, copy)   id rethrows;
@property (nonatomic, nullable, copy)   id qtTopLevelReturn;
@property (nonatomic, nullable, copy)   id right;
@property (nonatomic, nullable, copy)   id runtimeType;
@property (nonatomic, nullable, copy)   id s;
@property (nonatomic, nullable, copy)   id sbyte;
@property (nonatomic, nullable, copy)   id sealed;
@property (nonatomic, nullable, copy)   id sel;
@property (nonatomic, nullable, copy)   id select;
@property (nonatomic, nullable, copy)   id self;
@property (nonatomic, nullable, copy)   id qtTopLevelSelf;
@property (nonatomic, nullable, copy)   id sendable;
@property (nonatomic, nullable, copy)   id serialDescriptor;
@property (nonatomic, nullable, copy)   id serializable;
@property (nonatomic, nullable, copy)   id serializationFeature;
@property (nonatomic, nullable, copy)   id serialize;
@property (nonatomic, nullable, copy)   id serializerProvider;
@property (nonatomic, nullable, copy)   id serialName;
@property (nonatomic, nullable, copy)   id set;
@property (nonatomic, nullable, copy)   id qtTopLevelShort;
@property (nonatomic, nullable, copy)   id qtTopLevelSigned;
@property (nonatomic, nullable, copy)   id simpleModule;
@property (nonatomic, nullable, copy)   id qtTopLevelSizeof;
@property (nonatomic, nullable, copy)   id stackalloc;
@property (nonatomic, nullable, copy)   id standards;
@property (nonatomic, nullable, copy)   id qtTopLevelStatic;
@property (nonatomic, nullable, copy)   id staticAssert;
@property (nonatomic, nullable, copy)   id staticCast;
@property (nonatomic, nullable, copy)   id stdDeserializer;
@property (nonatomic, nullable, copy)   id stdSerializer;
@property (nonatomic, nullable, copy)   id strictfp;
@property (nonatomic, nullable, copy)   id string;
@property (nonatomic, nullable, copy)   id qtTopLevelStruct;
@property (nonatomic, nullable, copy)   id subscript;
@property (nonatomic, nullable, copy)   id super;
@property (nonatomic, nullable, copy)   id qtTopLevelSwitch;
@property (nonatomic, nullable, copy)   id symbol;
@property (nonatomic, nullable, copy)   id synchronized;
@property (nonatomic, nullable, copy)   id system;
@property (nonatomic, nullable, copy)   id template;
@property (nonatomic, nullable, copy)   id textNode;
@property (nonatomic, nullable, copy)   id then;
@property (nonatomic, nullable, copy)   id this;
@property (nonatomic, nullable, copy)   id threadLocal;
@property (nonatomic, nullable, copy)   id throw;
@property (nonatomic, nullable, copy)   id throws;
@property (nonatomic, nullable, copy)   id timeOnly;
@property (nonatomic, nullable, copy)   id timeOnlyConverter;
@property (nonatomic, nullable, copy)   id timeZone;
@property (nonatomic, nullable, copy)   id toDict;
@property (nonatomic, nullable, copy)   id toJSON;
@property (nonatomic, nullable, copy)   id topLevel;
@property (nonatomic, nullable, copy)   id toString;
@property (nonatomic, nullable, copy)   id transient;
@property (nonatomic, nullable, copy)   id qtTopLevelTrue;
@property (nonatomic, nullable, copy)   id theTrue;
@property (nonatomic, nullable, copy)   id try;
@property (nonatomic, nullable, copy)   id type;
@property (nonatomic, nullable, copy)   id qtTopLevelType;
@property (nonatomic, nullable, copy)   id typealias;
@property (nonatomic, nullable, copy)   id qtTopLevelTypedef;
@property (nonatomic, nullable, copy)   id typeid;
@property (nonatomic, nullable, copy)   id typename;
@property (nonatomic, nullable, copy)   id qtTopLevelTypeof;
@property (nonatomic, nullable, copy)   id uint;
@property (nonatomic, nullable, copy)   id ulong;
@property (nonatomic, nullable, copy)   id unchecked;
@property (nonatomic, nullable, copy)   id undefined;
@property (nonatomic, nullable, copy)   id qtTopLevelUnion;
@property (nonatomic, nullable, copy)   id unmarshalJSON;
@property (nonatomic, nullable, copy)   id unowned;
@property (nonatomic, nullable, copy)   id unsafe;
@property (nonatomic, nullable, copy)   id qtTopLevelUnsigned;
@property (nonatomic, nullable, copy)   id useSerializers;
@property (nonatomic, nullable, copy)   id ushort;
@property (nonatomic, nullable, copy)   id using;
@property (nonatomic, nullable, copy)   id utf8JSONReader;
@property (nonatomic, nullable, copy)   id utf8JSONWriter;
@property (nonatomic, nullable, copy)   id uuid;
@property (nonatomic, nullable, copy)   id var;
@property (nonatomic, nullable, copy)   id virtual;
@property (nonatomic, nullable, copy)   id qtTopLevelVoid;
@property (nonatomic, nullable, copy)   id qtTopLevelVolatile;
@property (nonatomic, nullable, copy)   id wcharT;
@property (nonatomic, nullable, copy)   id weak;
@property (nonatomic, nullable, copy)   id where;
@property (nonatomic, nullable, copy)   id qtTopLevelWhile;
@property (nonatomic, nullable, copy)   id willSet;
@property (nonatomic, nullable, copy)   id with;
@property (nonatomic, nullable, copy)   id xor;
@property (nonatomic, nullable, copy)   id xorEq;
@property (nonatomic, nullable, copy)   id yes;
@property (nonatomic, nullable, copy)   id yield;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTAbstract : NSObject
@end

@interface QTAlignas : NSObject
@end

@interface QTAlignof : NSObject
@end

@interface QTAnd : NSObject
@end

@interface QTAndEq : NSObject
@end

@interface QTAny : NSObject
@end

@interface QTArray : NSObject
@end

@interface QTArrayNode : NSObject
@end

@interface QTAs : NSObject
@end

@interface QTAssert : NSObject
@end

@interface QTAssociatedtype : NSObject
@end

@interface QTAssociativity : NSObject
@end

@interface QTAsync : NSObject
@end

@interface QTAtomicCancel : NSObject
@end

@interface QTAtomicCommit : NSObject
@end

@interface QTAtomicNoexcept : NSObject
@end

@interface QTAwait : NSObject
@end

@interface QTBase : NSObject
@end

@interface QTBitand : NSObject
@end

@interface QTBitor : NSObject
@end

@interface QTBoolean : NSObject
@end

@interface QTBooleanNode : NSObject
@end

@interface QTBycopy : NSObject
@end

@interface QTByref : NSObject
@end

@interface QTByte : NSObject
@end

@interface QTCalendar : NSObject
@end

@interface QTCatch : NSObject
@end

@interface QTChan : NSObject
@end

@interface QTChar16T : NSObject
@end

@interface QTChar32T : NSObject
@end

@interface QTChecked : NSObject
@end

@interface QTClass : NSObject
@end

@interface QTClone : NSObject
@end

@interface QTCoAwait : NSObject
@end

@interface QTCoReturn : NSObject
@end

@interface QTCoYield : NSObject
@end

@interface QTCodable : NSObject
@end

@interface QTCodingKey : NSObject
@end

@interface QTCodingKeys : NSObject
@end

@interface QTCompl : NSObject
@end

@interface QTComplex : NSObject
@end

@interface QTConcept : NSObject
@end

@interface QTConsole : NSObject
@end

@interface QTConstCast : NSObject
@end

@interface QTConstexpr : NSObject
@end

@interface QTConstructor : NSObject
@end

@interface QTConvenience : NSObject
@end

@interface QTConvert : NSObject
@end

@interface QTConverter : NSObject
@end

@interface QTCultureInfo : NSObject
@end

@interface QTDate : NSObject
@end

@interface QTDateFormatter : NSObject
@end

@interface QTDateOnly : NSObject
@end

@interface QTDateOnlyConverter : NSObject
@end

@interface QTDateParseHandling : NSObject
@end

@interface QTDateTime : NSObject
@end

@interface QTDateTimeStyles : NSObject
@end

@interface QTDebugger : NSObject
@end

@interface QTDecimal : NSObject
@end

@interface QTDeclare : NSObject
@end

@interface QTDecltype : NSObject
@end

@interface QTDecodeString : NSObject
@end

@interface QTDecoder : NSObject
@end

@interface QTDecodingError : NSObject
@end

@interface QTDef : NSObject
@end

@interface QTDefer : NSObject
@end

@interface QTDeinit : NSObject
@end

@interface QTDel : NSObject
@end

@interface QTDelegate : NSObject
@end

@interface QTDelete : NSObject
@end

@interface QTDeserializationFeature : NSObject
@end

@interface QTDict : NSObject
@end

@interface QTDictionary : NSObject
@end

@interface QTDidSet : NSObject
@end

@interface QTDoubleNode : NSObject
@end

@interface QTDynamic : NSObject
@end

@interface QTDynamicCast : NSObject
@end

@interface QTElif : NSObject
@end

@interface QTEmpty : NSObject
@end

@interface QTEncodeQuickType : NSObject
@end

@interface QTEncoder : NSObject
@end

@interface QTEnumValues : NSObject
@end

@interface QTEqualityContract : NSObject
@end

@interface QTEquatable : NSObject
@end

@interface QTEvent : NSObject
@end

@interface QTExcept : NSObject
@end

@interface QTException : NSObject
@end

@interface QTExplicit : NSObject
@end

@interface QTExport : NSObject
@end

@interface QTExposing : NSObject
@end

@interface QTExtends : NSObject
@end

@interface QTExtension : NSObject
@end

@interface QTFallthrough : NSObject
@end

@interface QTFileprivate : NSObject
@end

@interface QTFinal : NSObject
@end

@interface QTFinally : NSObject
@end

@interface QTFixed : NSObject
@end

@interface QTForeach : NSObject
@end

@interface QTFormatException : NSObject
@end

@interface QTFriend : NSObject
@end

@interface QTFrom : NSObject
@end

@interface QTFromDict : NSObject
@end

@interface QTFromJSON : NSObject
@end

@interface QTFunc : NSObject
@end

@interface QTFunction : NSObject
@end

@interface QTGet : NSObject
@end

@interface QTGlobal : NSObject
@end

@interface QTGo : NSObject
@end

@interface QTGuard : NSObject
@end

@interface QTHasOwnProperty : NSObject
@end

@interface QTHashable : NSObject
@end

@interface QTHasher : NSObject
@end

@interface QTID : NSObject
@end

@interface QTImaginery : NSObject
@end

@interface QTImp : NSObject
@end

@interface QTImplements : NSObject
@end

@interface QTImplicit : NSObject
@end

@interface QTImport : NSObject
@end

@interface QTIn : NSObject
@end

@interface QTIndirect : NSObject
@end

@interface QTInfix : NSObject
@end

@interface QTInout : NSObject
@end

@interface QTInstanceof : NSObject
@end

@interface QTIntNode : NSObject
@end

@interface QTInterface : NSObject
@end

@interface QTInternal : NSObject
@end

@interface QTIs : NSObject
@end

@interface QTISODateTimeOffsetConverter : NSObject
@end

@interface QTIterable : NSObject
@end

@interface QTJdec : NSObject
@end

@interface QTJenc : NSObject
@end

@interface QTJpipe : NSObject
@end

@interface QTJSON : NSObject
@end

@interface QTJSONAny : NSObject
@end

@interface QTJSONCodingKey : NSObject
@end

@interface QTJSONConverter : NSObject
@end

@interface QTJSONDecoder : NSObject
@end

@interface QTJSONEncoder : NSObject
@end

@interface QTJSONException : NSObject
@end

@interface QTJSONGenerator : NSObject
@end

@interface QTJSONNode : NSObject
@end

@interface QTJSONNull : NSObject
@end

@interface QTJSONParser : NSObject
@end

@interface QTJSONReader : NSObject
@end

@interface QTJSONSerializer : NSObject
@end

@interface QTJSONToken : NSObject
@end

@interface QTJSONTokenType : NSObject
@end

@interface QTJSONWriter : NSObject
@end

@interface QTKSerializer : NSObject
@end

@interface QTLambda : NSObject
@end

@interface QTLazy : NSObject
@end

@interface QTLeft : NSObject
@end

@interface QTLet : NSObject
@end

@interface QTList : NSObject
@end

@interface QTLocalDate : NSObject
@end

@interface QTLocale : NSObject
@end

@interface QTLock : NSObject
@end

@interface QTLongNode : NSObject
@end

@interface QTMap : NSObject
@end

@interface QTMapEntry : NSObject
@end

@interface QTMarshalJSON : NSObject
@end

@interface QTMetadataPropertyHandling : NSObject
@end

@interface QTModule : NSObject
@end

@interface QTMutable : NSObject
@end

@interface QTMutating : NSObject
@end

@interface QTNamespace : NSObject
@end

@interface QTNative : NSObject
@end

@interface QTNewtonsoft : NSObject
@end

@interface QTNo : NSObject
@end

@interface QTNoSuchMethod : NSObject
@end

@interface QTNoexcept : NSObject
@end

@interface QTNone : NSObject
@end

@interface QTNonlocal : NSObject
@end

@interface QTNonmutating : NSObject
@end

@interface QTNot : NSObject
@end

@interface QTNotEq : NSObject
@end

@interface QTNSError : NSObject
@end

@interface QTNSObject : NSObject
@end

@interface QTNSString : NSObject
@end

@interface QTNull : NSObject
@end

@interface QTNullNode : NSObject
@end

@interface QTNullptr : NSObject
@end

@interface QTNumber : NSObject
@end

@interface QTObject : NSObject
@end

@interface QTObjectMapper : NSObject
@end

@interface QTObjectNode : NSObject
@end

@interface QTObjectReader : NSObject
@end

@interface QTObjectWriter : NSObject
@end

@interface QTOf : NSObject
@end

@interface QTOffsetDateTime : NSObject
@end

@interface QTOffsetTime : NSObject
@end

@interface QTOneway : NSObject
@end

@interface QTOpen : NSObject
@end

@interface QTOperator : NSObject
@end

@interface QTOptional : NSObject
@end

@interface QTOr : NSObject
@end

@interface QTOrEq : NSObject
@end

@interface QTOut : NSObject
@end

@interface QTOverride : NSObject
@end

@interface QTPackage : NSObject
@end

@interface QTParams : NSObject
@end

@interface QTPass : NSObject
@end

@interface QTPort : NSObject
@end

@interface QTPostfix : NSObject
@end

@interface QTPrecedence : NSObject
@end

@interface QTPrefix : NSObject
@end

@interface QTPrimitiveKind : NSObject
@end

@interface QTPrint : NSObject
@end

@interface QTPrintMembers : NSObject
@end

@interface QTPrintf : NSObject
@end

@interface QTPrivate : NSObject
@end

@interface QTProtected : NSObject
@end

@interface QTProtocol : NSObject
@end

@interface QTPublic : NSObject
@end

@interface QTASM : NSObject
@end

@interface QTAnyClass : NSObject
@end

@interface QTAtomic : NSObject
@end

@interface QTAuto : NSObject
@end

@interface QTBool : NSObject
@end

@interface QTBoolClass : NSObject
@end

@interface QTBreak : NSObject
@end

@interface QTCase : NSObject
@end

@interface QTChar : NSObject
@end

@interface QTClassClass : NSObject
@end

@interface QTConst : NSObject
@end

@interface QTContinue : NSObject
@end

@interface QTDefault : NSObject
@end

@interface QTDo : NSObject
@end

@interface QTDouble : NSObject
@end

@interface QTElse : NSObject
@end

@interface QTEnum : NSObject
@end

@interface QTExtern : NSObject
@end

@interface QTFalse : NSObject
@end

@interface QTFloat : NSObject
@end

@interface QTFor : NSObject
@end

@interface QTGoto : NSObject
@end

@interface QTIf : NSObject
@end

@interface QTInline : NSObject
@end

@interface QTInt : NSObject
@end

@interface QTLong : NSObject
@end

@interface QTNil : NSObject
@end

@interface QTNonatomic : NSObject
@end

@interface QTNoneClass : NSObject
@end

@interface QTNullClass : NSObject
@end

@interface QTProtocolClass : NSObject
@end

@interface QTRegister : NSObject
@end

@interface QTRestrict : NSObject
@end

@interface QTRetain : NSObject
@end

@interface QTReturn : NSObject
@end

@interface QTSelfClass : NSObject
@end

@interface QTShort : NSObject
@end

@interface QTSigned : NSObject
@end

@interface QTSizeof : NSObject
@end

@interface QTStatic : NSObject
@end

@interface QTStruct : NSObject
@end

@interface QTSwitch : NSObject
@end

@interface QTTrue : NSObject
@end

@interface QTTypeClass : NSObject
@end

@interface QTTypedef : NSObject
@end

@interface QTTypeof : NSObject
@end

@interface QTUnion : NSObject
@end

@interface QTUnsigned : NSObject
@end

@interface QTVoid : NSObject
@end

@interface QTVolatile : NSObject
@end

@interface QTWhile : NSObject
@end

@interface QTQuicktype : NSObject
@end

@interface QTRaise : NSObject
@end

@interface QTRange : NSObject
@end

@interface QTReadonly : NSObject
@end

@interface QTRef : NSObject
@end

@interface QTRegExp : NSObject
@end

@interface QTReinterpretCast : NSObject
@end

@interface QTRepeat : NSObject
@end

@interface QTRequire : NSObject
@end

@interface QTRequired : NSObject
@end

@interface QTRequires : NSObject
@end

@interface QTRethrows : NSObject
@end

@interface QTRight : NSObject
@end

@interface QTRuntimeType : NSObject
@end

@interface QTS : NSObject
@end

@interface QTSbyte : NSObject
@end

@interface QTSealed : NSObject
@end

@interface QTSel : NSObject
@end

@interface QTSelect : NSObject
@end

@interface QTSelf : NSObject
@end

@interface QTSendable : NSObject
@end

@interface QTSerialDescriptor : NSObject
@end

@interface QTSerialName : NSObject
@end

@interface QTSerializable : NSObject
@end

@interface QTSerializationFeature : NSObject
@end

@interface QTSerialize : NSObject
@end

@interface QTSerializerProvider : NSObject
@end

@interface QTSet : NSObject
@end

@interface QTSimpleModule : NSObject
@end

@interface QTStackalloc : NSObject
@end

@interface QTStandards : NSObject
@end

@interface QTStaticAssert : NSObject
@end

@interface QTStaticCast : NSObject
@end

@interface QTStdDeserializer : NSObject
@end

@interface QTStdSerializer : NSObject
@end

@interface QTStrictfp : NSObject
@end

@interface QTString : NSObject
@end

@interface QTSubscript : NSObject
@end

@interface QTSuper : NSObject
@end

@interface QTSymbol : NSObject
@end

@interface QTSynchronized : NSObject
@end

@interface QTSystem : NSObject
@end

@interface QTTemplate : NSObject
@end

@interface QTTextNode : NSObject
@end

@interface QTUnionBoolBool : NSObject
@end

@interface QTFalseClass : NSObject
@end

@interface QTHashCode : NSObject
@end

@interface QTInit : NSObject
@end

@interface QTNew : NSObject
@end

@interface QTTrueClass : NSObject
@end

@interface QTThen : NSObject
@end

@interface QTThis : NSObject
@end

@interface QTThreadLocal : NSObject
@end

@interface QTThrow : NSObject
@end

@interface QTThrows : NSObject
@end

@interface QTTimeOnly : NSObject
@end

@interface QTTimeOnlyConverter : NSObject
@end

@interface QTTimeZone : NSObject
@end

@interface QTToDict : NSObject
@end

@interface QTToJSON : NSObject
@end

@interface QTToString : NSObject
@end

@interface QTTopLevelClass : NSObject
@end

@interface QTTransient : NSObject
@end

@interface QTTry : NSObject
@end

@interface QTType : NSObject
@end

@interface QTTypealias : NSObject
@end

@interface QTTypeid : NSObject
@end

@interface QTTypename : NSObject
@end

@interface QTUint : NSObject
@end

@interface QTUlong : NSObject
@end

@interface QTUnchecked : NSObject
@end

@interface QTUndefined : NSObject
@end

@interface QTUnmarshalJSON : NSObject
@end

@interface QTUnowned : NSObject
@end

@interface QTUnsafe : NSObject
@end

@interface QTUseSerializers : NSObject
@end

@interface QTUshort : NSObject
@end

@interface QTUsing : NSObject
@end

@interface QTUtf8JSONReader : NSObject
@end

@interface QTUtf8JSONWriter : NSObject
@end

@interface QTUUID : NSObject
@end

@interface QTVar : NSObject
@end

@interface QTVirtual : NSObject
@end

@interface QTWcharT : NSObject
@end

@interface QTWeak : NSObject
@end

@interface QTWhere : NSObject
@end

@interface QTWillSet : NSObject
@end

@interface QTWith : NSObject
@end

@interface QTXor : NSObject
@end

@interface QTXorEq : NSObject
@end

@interface QTYes : NSObject
@end

@interface QTYield : NSObject
@end

NS_ASSUME_NONNULL_END
