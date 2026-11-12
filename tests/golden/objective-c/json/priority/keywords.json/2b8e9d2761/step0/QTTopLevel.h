// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTObj1;
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
@class QTEmpty;
@class QTImaginery;
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
@class QTObj1Bool;
@class QTObj2;
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
@class QTEncodeQuickType;
@class QTEncoder;
@class QTEnumValues;
@class QTEnumValue;
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
@class QTDefault;
@class QTDo;
@class QTDouble;
@class QTElse;
@class QTEnum;
@class QTExtern;
@class QTFalse;
@class QTFloat;
@class QTFor;
@class QTFalseClass;
@class QTObj3;
@class QTFunction;
@class QTGet;
@class QTGlobal;
@class QTGo;
@class QTGuard;
@class QTHasOwnProperty;
@class QTHashable;
@class QTHasher;
@class QTID;
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
@class QTGoto;
@class QTIf;
@class QTInline;
@class QTInt;
@class QTLong;
@class QTHashCode;
@class QTInit;
@class QTObj4;
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
@class QTNil;
@class QTNonatomic;
@class QTNoneClass;
@class QTNullClass;
@class QTProtocolClass;
@class QTRegister;
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
@class QTPrint;
@class QTPrintMembers;
@class QTPrintf;
@class QTPrivate;
@class QTProtected;
@class QTProtocol;
@class QTPublic;
@class QTQuicktype;
@class QTRaise;
@class QTRange;
@class QTReadonly;
@class QTRef;
@class QTRegExp;
@class QTReinterpretCast;
@class QTNew;
@class QTObj5;
@class QTKSerializer;
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
@class QTPrimitiveKind;
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
@class QTObj6;
@class QTTypeClass;
@class QTTypedef;
@class QTTypeof;
@class QTUnion;
@class QTUnsigned;
@class QTVoid;
@class QTVolatile;
@class QTWhile;
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

#pragma mark - Boxed enums

@interface QTEnumValue : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTEnumValue *)ready;
+ (QTEnumValue *)done;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTObj1 *obj1;
@property (nonatomic, strong) QTObj2 *obj2;
@property (nonatomic, strong) QTObj3 *obj3;
@property (nonatomic, strong) QTObj4 *obj4;
@property (nonatomic, strong) QTObj5 *obj5;
@property (nonatomic, strong) QTObj6 *obj6;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTObj1 : NSObject
@property (nonatomic, strong) QTAbstract *abstract;
@property (nonatomic, strong) QTAlignas *alignas;
@property (nonatomic, strong) QTAlignof *alignof;
@property (nonatomic, strong) QTAnd *and;
@property (nonatomic, strong) QTAndEq *andEq;
@property (nonatomic, strong) QTAny *any;
@property (nonatomic, strong) QTArray *array;
@property (nonatomic, strong) QTArrayNode *arrayNode;
@property (nonatomic, strong) QTAs *as;
@property (nonatomic, strong) QTAssert *assert;
@property (nonatomic, strong) QTAssociatedtype *associatedtype;
@property (nonatomic, strong) QTAssociativity *associativity;
@property (nonatomic, strong) QTAsync *async;
@property (nonatomic, strong) QTAtomicCancel *atomicCancel;
@property (nonatomic, strong) QTAtomicCommit *atomicCommit;
@property (nonatomic, strong) QTAtomicNoexcept *atomicNoexcept;
@property (nonatomic, strong) QTAwait *await;
@property (nonatomic, strong) QTBase *base;
@property (nonatomic, strong) QTBitand *bitand;
@property (nonatomic, strong) QTBitor *bitor;
@property (nonatomic, strong) QTBoolean *boolean;
@property (nonatomic, strong) QTBooleanNode *booleanNode;
@property (nonatomic, strong) QTBycopy *bycopy;
@property (nonatomic, strong) QTByref *byref;
@property (nonatomic, strong) QTByte *byte;
@property (nonatomic, strong) QTCalendar *calendar;
@property (nonatomic, strong) QTCatch *catch;
@property (nonatomic, strong) QTChan *chan;
@property (nonatomic, strong) QTChar16T *char16T;
@property (nonatomic, strong) QTChar32T *char32T;
@property (nonatomic, strong) QTChecked *checked;
@property (nonatomic, strong) QTClass *class;
@property (nonatomic, strong) QTClone *clone;
@property (nonatomic, strong) QTCoAwait *coAwait;
@property (nonatomic, strong) QTCoReturn *coReturn;
@property (nonatomic, strong) QTCoYield *coYield;
@property (nonatomic, strong) QTCodable *codable;
@property (nonatomic, strong) QTCodingKey *codingKey;
@property (nonatomic, strong) QTCodingKeys *codingKeys;
@property (nonatomic, strong) QTCompl *compl;
@property (nonatomic, strong) QTComplex *complex;
@property (nonatomic, strong) QTConcept *concept;
@property (nonatomic, strong) QTConsole *console;
@property (nonatomic, strong) QTConstCast *constCast;
@property (nonatomic, strong) QTConstexpr *constexpr;
@property (nonatomic, strong) QTConstructor *constructor;
@property (nonatomic, strong) QTConvenience *convenience;
@property (nonatomic, strong) QTConvert *convert;
@property (nonatomic, strong) QTConverter *converter;
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTEmpty *empty;
@property (nonatomic, strong) QTImaginery *imaginery;
@property (nonatomic, strong) QTASM *obj1ASM;
@property (nonatomic, strong) QTAnyClass *obj1Any;
@property (nonatomic, strong) QTAtomic *obj1Atomic;
@property (nonatomic, strong) QTAuto *obj1Auto;
@property (nonatomic, strong) QTBool *obj1BOOL;
@property (nonatomic, strong) QTBoolClass *obj1Bool;
@property (nonatomic, strong) QTBreak *obj1Break;
@property (nonatomic, strong) QTCase *obj1Case;
@property (nonatomic, strong) QTChar *obj1Char;
@property (nonatomic, strong) QTClassClass *obj1Class;
@property (nonatomic, strong) QTConst *obj1Const;
@property (nonatomic, strong) QTContinue *obj1Continue;
@property (nonatomic, strong) QTObj1Bool *theBool;
@end

@interface QTAbstract : NSObject
@property (nonatomic, assign) NSInteger abstract;
@end

@interface QTAlignas : NSObject
@property (nonatomic, assign) NSInteger alignas;
@end

@interface QTAlignof : NSObject
@property (nonatomic, assign) NSInteger alignof;
@end

@interface QTAnd : NSObject
@property (nonatomic, assign) NSInteger and;
@end

@interface QTAndEq : NSObject
@property (nonatomic, assign) NSInteger andEq;
@end

@interface QTAny : NSObject
@property (nonatomic, assign) NSInteger any;
@end

@interface QTArray : NSObject
@property (nonatomic, assign) NSInteger array;
@end

@interface QTArrayNode : NSObject
@property (nonatomic, assign) NSInteger arrayNode;
@end

@interface QTAs : NSObject
@property (nonatomic, assign) NSInteger as;
@end

@interface QTAssert : NSObject
@property (nonatomic, assign) NSInteger assert;
@end

@interface QTAssociatedtype : NSObject
@property (nonatomic, assign) NSInteger associatedtype;
@end

@interface QTAssociativity : NSObject
@property (nonatomic, assign) NSInteger associativity;
@end

@interface QTAsync : NSObject
@property (nonatomic, assign) NSInteger async;
@end

@interface QTAtomicCancel : NSObject
@property (nonatomic, assign) NSInteger atomicCancel;
@end

@interface QTAtomicCommit : NSObject
@property (nonatomic, assign) NSInteger atomicCommit;
@end

@interface QTAtomicNoexcept : NSObject
@property (nonatomic, assign) NSInteger atomicNoexcept;
@end

@interface QTAwait : NSObject
@property (nonatomic, assign) NSInteger await;
@end

@interface QTBase : NSObject
@property (nonatomic, assign) NSInteger base;
@end

@interface QTBitand : NSObject
@property (nonatomic, assign) NSInteger bitand;
@end

@interface QTBitor : NSObject
@property (nonatomic, assign) NSInteger bitor;
@end

@interface QTBoolean : NSObject
@property (nonatomic, assign) NSInteger boolean;
@end

@interface QTBooleanNode : NSObject
@property (nonatomic, assign) NSInteger booleanNode;
@end

@interface QTBycopy : NSObject
@property (nonatomic, assign) NSInteger bycopy;
@end

@interface QTByref : NSObject
@property (nonatomic, assign) NSInteger byref;
@end

@interface QTByte : NSObject
@property (nonatomic, assign) NSInteger byte;
@end

@interface QTCalendar : NSObject
@property (nonatomic, assign) NSInteger calendar;
@end

@interface QTCatch : NSObject
@property (nonatomic, assign) NSInteger catch;
@end

@interface QTChan : NSObject
@property (nonatomic, assign) NSInteger chan;
@end

@interface QTChar16T : NSObject
@property (nonatomic, assign) NSInteger char16T;
@end

@interface QTChar32T : NSObject
@property (nonatomic, assign) NSInteger char32T;
@end

@interface QTChecked : NSObject
@property (nonatomic, assign) NSInteger checked;
@end

@interface QTClass : NSObject
@property (nonatomic, assign) NSInteger class;
@end

@interface QTClone : NSObject
@property (nonatomic, assign) NSInteger clone;
@end

@interface QTCoAwait : NSObject
@property (nonatomic, assign) NSInteger coAwait;
@end

@interface QTCoReturn : NSObject
@property (nonatomic, assign) NSInteger coReturn;
@end

@interface QTCoYield : NSObject
@property (nonatomic, assign) NSInteger coYield;
@end

@interface QTCodable : NSObject
@property (nonatomic, assign) NSInteger codable;
@end

@interface QTCodingKey : NSObject
@property (nonatomic, assign) NSInteger codingKey;
@end

@interface QTCodingKeys : NSObject
@property (nonatomic, assign) NSInteger codingKeys;
@end

@interface QTCompl : NSObject
@property (nonatomic, assign) NSInteger compl;
@end

@interface QTComplex : NSObject
@property (nonatomic, assign) NSInteger complex;
@end

@interface QTConcept : NSObject
@property (nonatomic, assign) NSInteger concept;
@end

@interface QTConsole : NSObject
@property (nonatomic, assign) NSInteger console;
@end

@interface QTConstCast : NSObject
@property (nonatomic, assign) NSInteger constCast;
@end

@interface QTConstexpr : NSObject
@property (nonatomic, assign) NSInteger constexpr;
@end

@interface QTConstructor : NSObject
@property (nonatomic, assign) NSInteger constructor;
@end

@interface QTConvenience : NSObject
@property (nonatomic, assign) NSInteger convenience;
@end

@interface QTConvert : NSObject
@property (nonatomic, assign) NSInteger convert;
@end

@interface QTConverter : NSObject
@property (nonatomic, assign) NSInteger converter;
@end

@interface QTEmpty : NSObject
@property (nonatomic, assign) NSInteger empty;
@end

@interface QTImaginery : NSObject
@property (nonatomic, assign) NSInteger imaginery;
@end

@interface QTASM : NSObject
@property (nonatomic, assign) NSInteger asmASM;
@end

@interface QTAnyClass : NSObject
@property (nonatomic, assign) NSInteger any;
@end

@interface QTAtomic : NSObject
@property (nonatomic, assign) NSInteger atomicAtomic;
@end

@interface QTAuto : NSObject
@property (nonatomic, assign) NSInteger autoAuto;
@end

@interface QTBool : NSObject
@property (nonatomic, assign) NSInteger boolBool;
@end

@interface QTBoolClass : NSObject
@property (nonatomic, assign) NSInteger boolBool;
@end

@interface QTBreak : NSObject
@property (nonatomic, assign) NSInteger breakBreak;
@end

@interface QTCase : NSObject
@property (nonatomic, assign) NSInteger caseCase;
@end

@interface QTChar : NSObject
@property (nonatomic, assign) NSInteger charChar;
@end

@interface QTClassClass : NSObject
@property (nonatomic, assign) NSInteger class;
@end

@interface QTConst : NSObject
@property (nonatomic, assign) NSInteger constConst;
@end

@interface QTContinue : NSObject
@property (nonatomic, assign) NSInteger continueContinue;
@end

@interface QTObj1Bool : NSObject
@property (nonatomic, assign) NSInteger boolBool;
@end

@interface QTObj2 : NSObject
@property (nonatomic, strong) QTCultureInfo *cultureInfo;
@property (nonatomic, strong) QTDate *date;
@property (nonatomic, strong) QTDateFormatter *dateFormatter;
@property (nonatomic, strong) QTDateOnly *dateOnly;
@property (nonatomic, strong) QTDateOnlyConverter *dateOnlyConverter;
@property (nonatomic, strong) QTDateParseHandling *dateParseHandling;
@property (nonatomic, strong) QTDateTime *dateTime;
@property (nonatomic, strong) QTDateTimeStyles *dateTimeStyles;
@property (nonatomic, strong) QTDebugger *debugger;
@property (nonatomic, strong) QTDecimal *decimal;
@property (nonatomic, strong) QTDeclare *declare;
@property (nonatomic, strong) QTDecltype *decltype;
@property (nonatomic, strong) QTDecodeString *decodeString;
@property (nonatomic, strong) QTDecoder *decoder;
@property (nonatomic, strong) QTDecodingError *decodingError;
@property (nonatomic, strong) QTDef *def;
@property (nonatomic, strong) QTDefer *defer;
@property (nonatomic, strong) QTDeinit *deinit;
@property (nonatomic, strong) QTDel *del;
@property (nonatomic, strong) QTDelegate *delegate;
@property (nonatomic, strong) QTDelete *delete;
@property (nonatomic, strong) QTDeserializationFeature *deserializationFeature;
@property (nonatomic, strong) QTDict *dict;
@property (nonatomic, strong) QTDictionary *dictionary;
@property (nonatomic, strong) QTDidSet *didSet;
@property (nonatomic, strong) QTDoubleNode *doubleNode;
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTDynamic *dynamic;
@property (nonatomic, strong) QTDynamicCast *dynamicCast;
@property (nonatomic, strong) QTElif *elif;
@property (nonatomic, strong) QTEncodeQuickType *encodeQuickType;
@property (nonatomic, strong) QTEncoder *encoder;
@property (nonatomic, strong) QTEnumValues *enumValues;
@property (nonatomic, strong) QTEqualityContract *equalityContract;
@property (nonatomic, strong) QTEquatable *equatable;
@property (nonatomic, strong) QTEvent *event;
@property (nonatomic, strong) QTExcept *except;
@property (nonatomic, strong) QTException *exception;
@property (nonatomic, strong) QTExplicit *explicit;
@property (nonatomic, strong) QTExport *export;
@property (nonatomic, strong) QTExposing *exposing;
@property (nonatomic, strong) QTExtends *extends;
@property (nonatomic, strong) QTExtension *extension;
@property (nonatomic, strong) QTFallthrough *fallthrough;
@property (nonatomic, strong) QTFileprivate *fileprivate;
@property (nonatomic, strong) QTFinal *final;
@property (nonatomic, strong) QTFinally *finally;
@property (nonatomic, strong) QTFixed *fixed;
@property (nonatomic, strong) QTForeach *foreach;
@property (nonatomic, strong) QTFormatException *formatException;
@property (nonatomic, strong) QTFriend *friend;
@property (nonatomic, strong) QTFrom *from;
@property (nonatomic, strong) QTFromDict *fromDict;
@property (nonatomic, strong) QTFromJSON *fromJSON;
@property (nonatomic, strong) QTFunc *func;
@property (nonatomic, strong) QTDefault *obj2Default;
@property (nonatomic, strong) QTDo *obj2Do;
@property (nonatomic, strong) QTDouble *obj2Double;
@property (nonatomic, strong) QTElse *obj2Else;
@property (nonatomic, strong) QTEnum *obj2Enum;
@property (nonatomic, strong) QTExtern *obj2Extern;
@property (nonatomic, strong) QTFalse *obj2False;
@property (nonatomic, strong) QTFloat *obj2Float;
@property (nonatomic, strong) QTFor *obj2For;
@property (nonatomic, strong) QTFalseClass *theFalse;
@end

@interface QTCultureInfo : NSObject
@property (nonatomic, assign) NSInteger cultureInfo;
@end

@interface QTDate : NSObject
@property (nonatomic, assign) NSInteger date;
@end

@interface QTDateFormatter : NSObject
@property (nonatomic, assign) NSInteger dateFormatter;
@end

@interface QTDateOnly : NSObject
@property (nonatomic, assign) NSInteger dateOnly;
@end

@interface QTDateOnlyConverter : NSObject
@property (nonatomic, assign) NSInteger dateOnlyConverter;
@end

@interface QTDateParseHandling : NSObject
@property (nonatomic, assign) NSInteger dateParseHandling;
@end

@interface QTDateTime : NSObject
@property (nonatomic, copy) NSString *dateTime;
@end

@interface QTDateTimeStyles : NSObject
@property (nonatomic, assign) NSInteger dateTimeStyles;
@end

@interface QTDebugger : NSObject
@property (nonatomic, assign) NSInteger debugger;
@end

@interface QTDecimal : NSObject
@property (nonatomic, assign) NSInteger decimal;
@end

@interface QTDeclare : NSObject
@property (nonatomic, assign) NSInteger declare;
@end

@interface QTDecltype : NSObject
@property (nonatomic, assign) NSInteger decltype;
@end

@interface QTDecodeString : NSObject
@property (nonatomic, assign) NSInteger decodeString;
@end

@interface QTDecoder : NSObject
@property (nonatomic, assign) NSInteger decoder;
@end

@interface QTDecodingError : NSObject
@property (nonatomic, assign) NSInteger decodingError;
@end

@interface QTDef : NSObject
@property (nonatomic, assign) NSInteger def;
@end

@interface QTDefer : NSObject
@property (nonatomic, assign) NSInteger defer;
@end

@interface QTDeinit : NSObject
@property (nonatomic, assign) NSInteger deinit;
@end

@interface QTDel : NSObject
@property (nonatomic, assign) NSInteger del;
@end

@interface QTDelegate : NSObject
@property (nonatomic, assign) NSInteger delegate;
@end

@interface QTDelete : NSObject
@property (nonatomic, assign) NSInteger delete;
@end

@interface QTDeserializationFeature : NSObject
@property (nonatomic, assign) NSInteger deserializationFeature;
@end

@interface QTDict : NSObject
@property (nonatomic, assign) NSInteger dict;
@end

@interface QTDictionary : NSObject
@property (nonatomic, assign) NSInteger dictionary;
@end

@interface QTDidSet : NSObject
@property (nonatomic, assign) NSInteger didSet;
@end

@interface QTDoubleNode : NSObject
@property (nonatomic, assign) NSInteger doubleNode;
@end

@interface QTDynamic : NSObject
@property (nonatomic, assign) NSInteger dynamic;
@end

@interface QTDynamicCast : NSObject
@property (nonatomic, assign) NSInteger dynamicCast;
@end

@interface QTElif : NSObject
@property (nonatomic, assign) NSInteger elif;
@end

@interface QTEncodeQuickType : NSObject
@property (nonatomic, assign) NSInteger encodeQuickType;
@end

@interface QTEncoder : NSObject
@property (nonatomic, assign) NSInteger encoder;
@end

@interface QTEnumValues : NSObject
@property (nonatomic, copy) NSArray<QTEnumValue *> *enumValues;
@end

@interface QTEqualityContract : NSObject
@property (nonatomic, assign) NSInteger equalityContract;
@end

@interface QTEquatable : NSObject
@property (nonatomic, assign) NSInteger equatable;
@end

@interface QTEvent : NSObject
@property (nonatomic, assign) NSInteger event;
@end

@interface QTExcept : NSObject
@property (nonatomic, assign) NSInteger except;
@end

@interface QTException : NSObject
@property (nonatomic, assign) NSInteger exception;
@end

@interface QTExplicit : NSObject
@property (nonatomic, assign) NSInteger explicit;
@end

@interface QTExport : NSObject
@property (nonatomic, assign) NSInteger export;
@end

@interface QTExposing : NSObject
@property (nonatomic, assign) NSInteger exposing;
@end

@interface QTExtends : NSObject
@property (nonatomic, assign) NSInteger extends;
@end

@interface QTExtension : NSObject
@property (nonatomic, assign) NSInteger extension;
@end

@interface QTFallthrough : NSObject
@property (nonatomic, assign) NSInteger fallthrough;
@end

@interface QTFileprivate : NSObject
@property (nonatomic, assign) NSInteger fileprivate;
@end

@interface QTFinal : NSObject
@property (nonatomic, assign) NSInteger final;
@end

@interface QTFinally : NSObject
@property (nonatomic, assign) NSInteger finally;
@end

@interface QTFixed : NSObject
@property (nonatomic, assign) NSInteger fixed;
@end

@interface QTForeach : NSObject
@property (nonatomic, assign) NSInteger foreach;
@end

@interface QTFormatException : NSObject
@property (nonatomic, assign) NSInteger formatException;
@end

@interface QTFriend : NSObject
@property (nonatomic, assign) NSInteger friend;
@end

@interface QTFrom : NSObject
@property (nonatomic, assign) NSInteger from;
@end

@interface QTFromDict : NSObject
@property (nonatomic, assign) NSInteger fromDict;
@end

@interface QTFromJSON : NSObject
@property (nonatomic, assign) NSInteger fromJSON;
@end

@interface QTFunc : NSObject
@property (nonatomic, assign) NSInteger func;
@end

@interface QTDefault : NSObject
@property (nonatomic, assign) NSInteger defaultDefault;
@end

@interface QTDo : NSObject
@property (nonatomic, assign) NSInteger doDo;
@end

@interface QTDouble : NSObject
@property (nonatomic, assign) NSInteger doubleDouble;
@end

@interface QTElse : NSObject
@property (nonatomic, assign) NSInteger elseElse;
@end

@interface QTEnum : NSObject
@property (nonatomic, assign) NSInteger enumEnum;
@end

@interface QTExtern : NSObject
@property (nonatomic, assign) NSInteger externExtern;
@end

@interface QTFalse : NSObject
@property (nonatomic, assign) NSInteger falseFalse;
@end

@interface QTFloat : NSObject
@property (nonatomic, assign) NSInteger floatFloat;
@end

@interface QTFor : NSObject
@property (nonatomic, assign) NSInteger forFor;
@end

@interface QTFalseClass : NSObject
@property (nonatomic, assign) NSInteger falseFalse;
@end

@interface QTObj3 : NSObject
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTFunction *function;
@property (nonatomic, strong) QTGet *get;
@property (nonatomic, strong) QTGlobal *global;
@property (nonatomic, strong) QTGo *go;
@property (nonatomic, strong) QTGuard *guard;
@property (nonatomic, strong) QTHasOwnProperty *hasOwnProperty;
@property (nonatomic, strong) QTHashable *hashable;
@property (nonatomic, strong) QTHasher *hasher;
@property (nonatomic, strong) QTID *identifier;
@property (nonatomic, strong) QTImp *imp;
@property (nonatomic, strong) QTImplements *implements;
@property (nonatomic, strong) QTImplicit *implicit;
@property (nonatomic, strong) QTImport *import;
@property (nonatomic, strong) QTIn *in;
@property (nonatomic, strong) QTIndirect *indirect;
@property (nonatomic, strong) QTInfix *infix;
@property (nonatomic, strong) QTInout *inout;
@property (nonatomic, strong) QTInstanceof *instanceof;
@property (nonatomic, strong) QTIntNode *intNode;
@property (nonatomic, strong) QTInterface *interface;
@property (nonatomic, strong) QTInternal *internal;
@property (nonatomic, strong) QTIs *is;
@property (nonatomic, strong) QTISODateTimeOffsetConverter *isoDateTimeOffsetConverter;
@property (nonatomic, strong) QTIterable *iterable;
@property (nonatomic, strong) QTJdec *jdec;
@property (nonatomic, strong) QTJenc *jenc;
@property (nonatomic, strong) QTJpipe *jpipe;
@property (nonatomic, strong) QTJSON *json;
@property (nonatomic, strong) QTJSONAny *jsonAny;
@property (nonatomic, strong) QTJSONCodingKey *jsonCodingKey;
@property (nonatomic, strong) QTJSONConverter *jsonConverter;
@property (nonatomic, strong) QTJSONDecoder *jsonDecoder;
@property (nonatomic, strong) QTJSONEncoder *jsonEncoder;
@property (nonatomic, strong) QTJSONException *jsonException;
@property (nonatomic, strong) QTJSONGenerator *jsonGenerator;
@property (nonatomic, strong) QTJSONNode *jsonNode;
@property (nonatomic, strong) QTJSONNull *jsonNull;
@property (nonatomic, strong) QTJSONParser *jsonParser;
@property (nonatomic, strong) QTJSONReader *jsonReader;
@property (nonatomic, strong) QTJSONSerializer *jsonSerializer;
@property (nonatomic, strong) QTJSONToken *jsonToken;
@property (nonatomic, strong) QTJSONTokenType *jsonTokenType;
@property (nonatomic, strong) QTJSONWriter *jsonWriter;
@property (nonatomic, strong) QTLambda *lambda;
@property (nonatomic, strong) QTLazy *lazy;
@property (nonatomic, strong) QTLeft *left;
@property (nonatomic, strong) QTLet *let;
@property (nonatomic, strong) QTList *list;
@property (nonatomic, strong) QTLocalDate *localDate;
@property (nonatomic, strong) QTLocale *locale;
@property (nonatomic, strong) QTLock *lock;
@property (nonatomic, strong) QTLongNode *longNode;
@property (nonatomic, strong) QTMap *map;
@property (nonatomic, strong) QTMapEntry *mapEntry;
@property (nonatomic, strong) QTMarshalJSON *marshalJSON;
@property (nonatomic, strong) QTMetadataPropertyHandling *metadataPropertyHandling;
@property (nonatomic, strong) QTModule *module;
@property (nonatomic, strong) QTGoto *obj3Goto;
@property (nonatomic, strong) QTIf *obj3If;
@property (nonatomic, strong) QTInline *obj3Inline;
@property (nonatomic, strong) QTInt *obj3Int;
@property (nonatomic, strong) QTLong *obj3Long;
@property (nonatomic, strong) QTHashCode *theHashCode;
@property (nonatomic, strong) QTInit *theInit;
@end

@interface QTFunction : NSObject
@property (nonatomic, assign) NSInteger function;
@end

@interface QTGet : NSObject
@property (nonatomic, assign) NSInteger get;
@end

@interface QTGlobal : NSObject
@property (nonatomic, assign) NSInteger global;
@end

@interface QTGo : NSObject
@property (nonatomic, assign) NSInteger go;
@end

@interface QTGuard : NSObject
@property (nonatomic, assign) NSInteger guard;
@end

@interface QTHasOwnProperty : NSObject
@property (nonatomic, assign) NSInteger hasOwnProperty;
@end

@interface QTHashable : NSObject
@property (nonatomic, assign) NSInteger hashable;
@end

@interface QTHasher : NSObject
@property (nonatomic, assign) NSInteger hasher;
@end

@interface QTID : NSObject
@property (nonatomic, assign) NSInteger identifier;
@end

@interface QTImp : NSObject
@property (nonatomic, assign) NSInteger imp;
@end

@interface QTImplements : NSObject
@property (nonatomic, assign) NSInteger implements;
@end

@interface QTImplicit : NSObject
@property (nonatomic, assign) NSInteger implicit;
@end

@interface QTImport : NSObject
@property (nonatomic, assign) NSInteger import;
@end

@interface QTIn : NSObject
@property (nonatomic, assign) NSInteger in;
@end

@interface QTIndirect : NSObject
@property (nonatomic, assign) NSInteger indirect;
@end

@interface QTInfix : NSObject
@property (nonatomic, assign) NSInteger infix;
@end

@interface QTInout : NSObject
@property (nonatomic, assign) NSInteger inout;
@end

@interface QTInstanceof : NSObject
@property (nonatomic, assign) NSInteger instanceof;
@end

@interface QTIntNode : NSObject
@property (nonatomic, assign) NSInteger intNode;
@end

@interface QTInterface : NSObject
@property (nonatomic, assign) NSInteger interface;
@end

@interface QTInternal : NSObject
@property (nonatomic, assign) NSInteger internal;
@end

@interface QTIs : NSObject
@property (nonatomic, assign) NSInteger is;
@end

@interface QTISODateTimeOffsetConverter : NSObject
@property (nonatomic, assign) NSInteger isoDateTimeOffsetConverter;
@end

@interface QTIterable : NSObject
@property (nonatomic, assign) NSInteger iterable;
@end

@interface QTJdec : NSObject
@property (nonatomic, assign) NSInteger jdec;
@end

@interface QTJenc : NSObject
@property (nonatomic, assign) NSInteger jenc;
@end

@interface QTJpipe : NSObject
@property (nonatomic, assign) NSInteger jpipe;
@end

@interface QTJSON : NSObject
@property (nonatomic, assign) NSInteger json;
@end

@interface QTJSONAny : NSObject
@property (nonatomic, nullable, copy) id jsonAny;
@end

@interface QTJSONCodingKey : NSObject
@property (nonatomic, assign) NSInteger jsonCodingKey;
@end

@interface QTJSONConverter : NSObject
@property (nonatomic, assign) NSInteger jsonConverter;
@end

@interface QTJSONDecoder : NSObject
@property (nonatomic, assign) NSInteger jsonDecoder;
@end

@interface QTJSONEncoder : NSObject
@property (nonatomic, assign) NSInteger jsonEncoder;
@end

@interface QTJSONException : NSObject
@property (nonatomic, assign) NSInteger jsonException;
@end

@interface QTJSONGenerator : NSObject
@property (nonatomic, assign) NSInteger jsonGenerator;
@end

@interface QTJSONNode : NSObject
@property (nonatomic, assign) NSInteger jsonNode;
@end

@interface QTJSONNull : NSObject
@property (nonatomic, assign) NSInteger jsonNull;
@end

@interface QTJSONParser : NSObject
@property (nonatomic, assign) NSInteger jsonParser;
@end

@interface QTJSONReader : NSObject
@property (nonatomic, assign) NSInteger jsonReader;
@end

@interface QTJSONSerializer : NSObject
@property (nonatomic, assign) NSInteger jsonSerializer;
@end

@interface QTJSONToken : NSObject
@property (nonatomic, assign) NSInteger jsonToken;
@end

@interface QTJSONTokenType : NSObject
@property (nonatomic, assign) NSInteger jsonTokenType;
@end

@interface QTJSONWriter : NSObject
@property (nonatomic, assign) NSInteger jsonWriter;
@end

@interface QTLambda : NSObject
@property (nonatomic, assign) NSInteger lambda;
@end

@interface QTLazy : NSObject
@property (nonatomic, assign) NSInteger lazy;
@end

@interface QTLeft : NSObject
@property (nonatomic, assign) NSInteger left;
@end

@interface QTLet : NSObject
@property (nonatomic, assign) NSInteger let;
@end

@interface QTList : NSObject
@property (nonatomic, assign) NSInteger list;
@end

@interface QTLocalDate : NSObject
@property (nonatomic, assign) NSInteger localDate;
@end

@interface QTLocale : NSObject
@property (nonatomic, assign) NSInteger locale;
@end

@interface QTLock : NSObject
@property (nonatomic, assign) NSInteger lock;
@end

@interface QTLongNode : NSObject
@property (nonatomic, assign) NSInteger longNode;
@end

@interface QTMap : NSObject
@property (nonatomic, assign) NSInteger map;
@end

@interface QTMapEntry : NSObject
@property (nonatomic, assign) NSInteger mapEntry;
@end

@interface QTMarshalJSON : NSObject
@property (nonatomic, assign) NSInteger marshalJSON;
@end

@interface QTMetadataPropertyHandling : NSObject
@property (nonatomic, assign) NSInteger metadataPropertyHandling;
@end

@interface QTModule : NSObject
@property (nonatomic, assign) NSInteger module;
@end

@interface QTGoto : NSObject
@property (nonatomic, assign) NSInteger gotoGoto;
@end

@interface QTIf : NSObject
@property (nonatomic, assign) NSInteger ifIf;
@end

@interface QTInline : NSObject
@property (nonatomic, assign) NSInteger inlineInline;
@end

@interface QTInt : NSObject
@property (nonatomic, assign) NSInteger intInt;
@end

@interface QTLong : NSObject
@property (nonatomic, assign) NSInteger longLong;
@end

@interface QTHashCode : NSObject
@property (nonatomic, assign) NSInteger theHashCode;
@end

@interface QTInit : NSObject
@property (nonatomic, assign) NSInteger theInit;
@end

@interface QTObj4 : NSObject
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTMutable *mutable;
@property (nonatomic, strong) QTMutating *mutating;
@property (nonatomic, strong) QTNamespace *namespace;
@property (nonatomic, strong) QTNative *native;
@property (nonatomic, strong) QTNewtonsoft *newtonsoft;
@property (nonatomic, strong) QTNo *no;
@property (nonatomic, strong) QTNoSuchMethod *noSuchMethod;
@property (nonatomic, strong) QTNoexcept *noexcept;
@property (nonatomic, strong) QTNone *none;
@property (nonatomic, strong) QTNonlocal *nonlocal;
@property (nonatomic, strong) QTNonmutating *nonmutating;
@property (nonatomic, strong) QTNot *not;
@property (nonatomic, strong) QTNotEq *notEq;
@property (nonatomic, strong) QTNSError *nsError;
@property (nonatomic, strong) QTNSObject *nsObject;
@property (nonatomic, strong) QTNSString *nsString;
@property (nonatomic, strong) QTNull *null;
@property (nonatomic, strong) QTNullNode *nullNode;
@property (nonatomic, strong) QTNullptr *nullptr;
@property (nonatomic, strong) QTNumber *number;
@property (nonatomic, strong) QTNil *obj4Nil;
@property (nonatomic, strong) QTNonatomic *obj4Nonatomic;
@property (nonatomic, strong) QTNoneClass *obj4None;
@property (nonatomic, strong) QTNullClass *obj4Null;
@property (nonatomic, strong) QTProtocolClass *obj4Protocol;
@property (nonatomic, strong) QTRegister *obj4Register;
@property (nonatomic, strong) QTObject *object;
@property (nonatomic, strong) QTObjectMapper *objectMapper;
@property (nonatomic, strong) QTObjectNode *objectNode;
@property (nonatomic, strong) QTObjectReader *objectReader;
@property (nonatomic, strong) QTObjectWriter *objectWriter;
@property (nonatomic, strong) QTOf *of;
@property (nonatomic, strong) QTOffsetDateTime *offsetDateTime;
@property (nonatomic, strong) QTOffsetTime *offsetTime;
@property (nonatomic, strong) QTOneway *oneway;
@property (nonatomic, strong) QTOpen *open;
@property (nonatomic, strong) QTOperator *operator;
@property (nonatomic, strong) QTOptional *optional;
@property (nonatomic, strong) QTOr *or;
@property (nonatomic, strong) QTOrEq *orEq;
@property (nonatomic, strong) QTOut *out;
@property (nonatomic, strong) QTOverride *override;
@property (nonatomic, strong) QTPackage *package;
@property (nonatomic, strong) QTParams *params;
@property (nonatomic, strong) QTPass *pass;
@property (nonatomic, strong) QTPort *port;
@property (nonatomic, strong) QTPostfix *postfix;
@property (nonatomic, strong) QTPrecedence *precedence;
@property (nonatomic, strong) QTPrefix *prefix;
@property (nonatomic, strong) QTPrint *print;
@property (nonatomic, strong) QTPrintMembers *printMembers;
@property (nonatomic, strong) QTPrintf *printf;
@property (nonatomic, strong) QTPrivate *private;
@property (nonatomic, strong) QTProtected *protected;
@property (nonatomic, strong) QTProtocol *protocol;
@property (nonatomic, strong) QTPublic *public;
@property (nonatomic, strong) QTQuicktype *quicktype;
@property (nonatomic, strong) QTRaise *raise;
@property (nonatomic, strong) QTRange *range;
@property (nonatomic, strong) QTReadonly *readonly;
@property (nonatomic, strong) QTRef *ref;
@property (nonatomic, strong) QTRegExp *regExp;
@property (nonatomic, strong) QTReinterpretCast *reinterpretCast;
@property (nonatomic, strong) QTNew *theNew;
@end

@interface QTMutable : NSObject
@property (nonatomic, assign) NSInteger mutable;
@end

@interface QTMutating : NSObject
@property (nonatomic, assign) NSInteger mutating;
@end

@interface QTNamespace : NSObject
@property (nonatomic, assign) NSInteger namespace;
@end

@interface QTNative : NSObject
@property (nonatomic, assign) NSInteger native;
@end

@interface QTNewtonsoft : NSObject
@property (nonatomic, assign) NSInteger newtonsoft;
@end

@interface QTNo : NSObject
@property (nonatomic, assign) NSInteger no;
@end

@interface QTNoSuchMethod : NSObject
@property (nonatomic, assign) NSInteger noSuchMethod;
@end

@interface QTNoexcept : NSObject
@property (nonatomic, assign) NSInteger noexcept;
@end

@interface QTNone : NSObject
@property (nonatomic, assign) NSInteger none;
@end

@interface QTNonlocal : NSObject
@property (nonatomic, assign) NSInteger nonlocal;
@end

@interface QTNonmutating : NSObject
@property (nonatomic, assign) NSInteger nonmutating;
@end

@interface QTNot : NSObject
@property (nonatomic, assign) NSInteger not;
@end

@interface QTNotEq : NSObject
@property (nonatomic, assign) NSInteger notEq;
@end

@interface QTNSError : NSObject
@property (nonatomic, assign) NSInteger nsError;
@end

@interface QTNSObject : NSObject
@property (nonatomic, assign) NSInteger nsObject;
@end

@interface QTNSString : NSObject
@property (nonatomic, assign) NSInteger nsString;
@end

@interface QTNull : NSObject
@property (nonatomic, assign) NSInteger null;
@end

@interface QTNullNode : NSObject
@property (nonatomic, assign) NSInteger nullNode;
@end

@interface QTNullptr : NSObject
@property (nonatomic, assign) NSInteger nullptr;
@end

@interface QTNumber : NSObject
@property (nonatomic, assign) NSInteger number;
@end

@interface QTNil : NSObject
@property (nonatomic, assign) NSInteger nilNil;
@end

@interface QTNonatomic : NSObject
@property (nonatomic, assign) NSInteger nonatomicNonatomic;
@end

@interface QTNoneClass : NSObject
@property (nonatomic, assign) NSInteger none;
@end

@interface QTNullClass : NSObject
@property (nonatomic, assign) NSInteger null;
@end

@interface QTProtocolClass : NSObject
@property (nonatomic, assign) NSInteger protocol;
@end

@interface QTRegister : NSObject
@property (nonatomic, assign) NSInteger registerRegister;
@end

@interface QTObject : NSObject
@property (nonatomic, assign) NSInteger object;
@end

@interface QTObjectMapper : NSObject
@property (nonatomic, assign) NSInteger objectMapper;
@end

@interface QTObjectNode : NSObject
@property (nonatomic, assign) NSInteger objectNode;
@end

@interface QTObjectReader : NSObject
@property (nonatomic, assign) NSInteger objectReader;
@end

@interface QTObjectWriter : NSObject
@property (nonatomic, assign) NSInteger objectWriter;
@end

@interface QTOf : NSObject
@property (nonatomic, assign) NSInteger of;
@end

@interface QTOffsetDateTime : NSObject
@property (nonatomic, assign) NSInteger offsetDateTime;
@end

@interface QTOffsetTime : NSObject
@property (nonatomic, assign) NSInteger offsetTime;
@end

@interface QTOneway : NSObject
@property (nonatomic, assign) NSInteger oneway;
@end

@interface QTOpen : NSObject
@property (nonatomic, assign) NSInteger open;
@end

@interface QTOperator : NSObject
@property (nonatomic, assign) NSInteger operator;
@end

@interface QTOptional : NSObject
@property (nonatomic, assign) NSInteger optional;
@end

@interface QTOr : NSObject
@property (nonatomic, assign) NSInteger or;
@end

@interface QTOrEq : NSObject
@property (nonatomic, assign) NSInteger orEq;
@end

@interface QTOut : NSObject
@property (nonatomic, assign) NSInteger out;
@end

@interface QTOverride : NSObject
@property (nonatomic, assign) NSInteger override;
@end

@interface QTPackage : NSObject
@property (nonatomic, assign) NSInteger package;
@end

@interface QTParams : NSObject
@property (nonatomic, assign) NSInteger params;
@end

@interface QTPass : NSObject
@property (nonatomic, assign) NSInteger pass;
@end

@interface QTPort : NSObject
@property (nonatomic, assign) NSInteger port;
@end

@interface QTPostfix : NSObject
@property (nonatomic, assign) NSInteger postfix;
@end

@interface QTPrecedence : NSObject
@property (nonatomic, assign) NSInteger precedence;
@end

@interface QTPrefix : NSObject
@property (nonatomic, assign) NSInteger prefix;
@end

@interface QTPrint : NSObject
@property (nonatomic, assign) NSInteger print;
@end

@interface QTPrintMembers : NSObject
@property (nonatomic, assign) NSInteger printMembers;
@end

@interface QTPrintf : NSObject
@property (nonatomic, assign) NSInteger printf;
@end

@interface QTPrivate : NSObject
@property (nonatomic, assign) NSInteger private;
@end

@interface QTProtected : NSObject
@property (nonatomic, assign) NSInteger protected;
@end

@interface QTProtocol : NSObject
@property (nonatomic, assign) NSInteger protocol;
@end

@interface QTPublic : NSObject
@property (nonatomic, assign) NSInteger public;
@end

@interface QTQuicktype : NSObject
@property (nonatomic, assign) NSInteger quicktype;
@end

@interface QTRaise : NSObject
@property (nonatomic, assign) NSInteger raise;
@end

@interface QTRange : NSObject
@property (nonatomic, assign) NSInteger range;
@end

@interface QTReadonly : NSObject
@property (nonatomic, assign) NSInteger readonly;
@end

@interface QTRef : NSObject
@property (nonatomic, assign) NSInteger ref;
@end

@interface QTRegExp : NSObject
@property (nonatomic, copy) NSString *regExp;
@end

@interface QTReinterpretCast : NSObject
@property (nonatomic, assign) NSInteger reinterpretCast;
@end

@interface QTNew : NSObject
@property (nonatomic, assign) NSInteger theNew;
@end

@interface QTObj5 : NSObject
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTKSerializer *kSerializer;
@property (nonatomic, strong) QTRestrict *obj5Restrict;
@property (nonatomic, strong) QTRetain *obj5Retain;
@property (nonatomic, strong) QTReturn *obj5Return;
@property (nonatomic, strong) QTSelfClass *obj5Self;
@property (nonatomic, strong) QTShort *obj5Short;
@property (nonatomic, strong) QTSigned *obj5Signed;
@property (nonatomic, strong) QTSizeof *obj5Sizeof;
@property (nonatomic, strong) QTStatic *obj5Static;
@property (nonatomic, strong) QTStruct *obj5Struct;
@property (nonatomic, strong) QTSwitch *obj5Switch;
@property (nonatomic, strong) QTTrue *obj5True;
@property (nonatomic, strong) QTPrimitiveKind *primitiveKind;
@property (nonatomic, strong) QTRepeat *repeat;
@property (nonatomic, strong) QTRequire *require;
@property (nonatomic, strong) QTRequired *required;
@property (nonatomic, strong) QTRequires *requires;
@property (nonatomic, strong) QTRethrows *rethrows;
@property (nonatomic, strong) QTRight *right;
@property (nonatomic, strong) QTRuntimeType *runtimeType;
@property (nonatomic, strong) QTS *s;
@property (nonatomic, strong) QTSbyte *sbyte;
@property (nonatomic, strong) QTSealed *sealed;
@property (nonatomic, strong) QTSel *sel;
@property (nonatomic, strong) QTSelect *select;
@property (nonatomic, strong) QTSelf *self;
@property (nonatomic, strong) QTSendable *sendable;
@property (nonatomic, strong) QTSerialDescriptor *serialDescriptor;
@property (nonatomic, strong) QTSerialName *serialName;
@property (nonatomic, strong) QTSerializable *serializable;
@property (nonatomic, strong) QTSerializationFeature *serializationFeature;
@property (nonatomic, strong) QTSerialize *serialize;
@property (nonatomic, strong) QTSerializerProvider *serializerProvider;
@property (nonatomic, strong) QTSet *set;
@property (nonatomic, strong) QTSimpleModule *simpleModule;
@property (nonatomic, strong) QTStackalloc *stackalloc;
@property (nonatomic, strong) QTStandards *standards;
@property (nonatomic, strong) QTStaticAssert *staticAssert;
@property (nonatomic, strong) QTStaticCast *staticCast;
@property (nonatomic, strong) QTStdDeserializer *stdDeserializer;
@property (nonatomic, strong) QTStdSerializer *stdSerializer;
@property (nonatomic, strong) QTStrictfp *strictfp;
@property (nonatomic, strong) QTString *string;
@property (nonatomic, strong) QTSubscript *subscript;
@property (nonatomic, strong) QTSuper *super;
@property (nonatomic, strong) QTSymbol *symbol;
@property (nonatomic, strong) QTSynchronized *synchronized;
@property (nonatomic, strong) QTSystem *system;
@property (nonatomic, strong) QTTemplate *template;
@property (nonatomic, strong) QTTextNode *textNode;
@property (nonatomic, strong) QTTrueClass *theTrue;
@property (nonatomic, strong) QTThen *then;
@property (nonatomic, strong) QTThis *this;
@property (nonatomic, strong) QTThreadLocal *threadLocal;
@property (nonatomic, strong) QTThrow *throw;
@property (nonatomic, strong) QTThrows *throws;
@property (nonatomic, strong) QTTimeOnly *timeOnly;
@property (nonatomic, strong) QTTimeOnlyConverter *timeOnlyConverter;
@property (nonatomic, strong) QTTimeZone *timeZone;
@property (nonatomic, strong) QTToDict *toDict;
@property (nonatomic, strong) QTToJSON *toJSON;
@property (nonatomic, strong) QTToString *toString;
@property (nonatomic, strong) QTTopLevelClass *topLevel;
@property (nonatomic, strong) QTTransient *transient;
@end

@interface QTKSerializer : NSObject
@property (nonatomic, assign) NSInteger kSerializer;
@end

@interface QTRestrict : NSObject
@property (nonatomic, assign) NSInteger restrictRestrict;
@end

@interface QTRetain : NSObject
@property (nonatomic, assign) NSInteger retainRetain;
@end

@interface QTReturn : NSObject
@property (nonatomic, assign) NSInteger returnReturn;
@end

@interface QTSelfClass : NSObject
@property (nonatomic, assign) NSInteger self;
@end

@interface QTShort : NSObject
@property (nonatomic, assign) NSInteger shortShort;
@end

@interface QTSigned : NSObject
@property (nonatomic, assign) NSInteger signedSigned;
@end

@interface QTSizeof : NSObject
@property (nonatomic, assign) NSInteger sizeofSizeof;
@end

@interface QTStatic : NSObject
@property (nonatomic, assign) NSInteger staticStatic;
@end

@interface QTStruct : NSObject
@property (nonatomic, assign) NSInteger structStruct;
@end

@interface QTSwitch : NSObject
@property (nonatomic, assign) NSInteger switchSwitch;
@end

@interface QTTrue : NSObject
@property (nonatomic, assign) NSInteger trueTrue;
@end

@interface QTPrimitiveKind : NSObject
@property (nonatomic, assign) NSInteger primitiveKind;
@end

@interface QTRepeat : NSObject
@property (nonatomic, assign) NSInteger repeat;
@end

@interface QTRequire : NSObject
@property (nonatomic, assign) NSInteger require;
@end

@interface QTRequired : NSObject
@property (nonatomic, assign) NSInteger required;
@end

@interface QTRequires : NSObject
@property (nonatomic, assign) NSInteger requires;
@end

@interface QTRethrows : NSObject
@property (nonatomic, assign) NSInteger rethrows;
@end

@interface QTRight : NSObject
@property (nonatomic, assign) NSInteger right;
@end

@interface QTRuntimeType : NSObject
@property (nonatomic, assign) NSInteger runtimeType;
@end

@interface QTS : NSObject
@property (nonatomic, assign) NSInteger s;
@end

@interface QTSbyte : NSObject
@property (nonatomic, assign) NSInteger sbyte;
@end

@interface QTSealed : NSObject
@property (nonatomic, assign) NSInteger sealed;
@end

@interface QTSel : NSObject
@property (nonatomic, assign) NSInteger sel;
@end

@interface QTSelect : NSObject
@property (nonatomic, assign) NSInteger select;
@end

@interface QTSelf : NSObject
@property (nonatomic, assign) NSInteger self;
@end

@interface QTSendable : NSObject
@property (nonatomic, assign) NSInteger sendable;
@end

@interface QTSerialDescriptor : NSObject
@property (nonatomic, assign) NSInteger serialDescriptor;
@end

@interface QTSerialName : NSObject
@property (nonatomic, assign) NSInteger serialName;
@end

@interface QTSerializable : NSObject
@property (nonatomic, assign) NSInteger serializable;
@end

@interface QTSerializationFeature : NSObject
@property (nonatomic, assign) NSInteger serializationFeature;
@end

@interface QTSerialize : NSObject
@property (nonatomic, assign) NSInteger serialize;
@end

@interface QTSerializerProvider : NSObject
@property (nonatomic, assign) NSInteger serializerProvider;
@end

@interface QTSet : NSObject
@property (nonatomic, assign) NSInteger set;
@end

@interface QTSimpleModule : NSObject
@property (nonatomic, assign) NSInteger simpleModule;
@end

@interface QTStackalloc : NSObject
@property (nonatomic, assign) NSInteger stackalloc;
@end

@interface QTStandards : NSObject
@property (nonatomic, assign) NSInteger standards;
@end

@interface QTStaticAssert : NSObject
@property (nonatomic, assign) NSInteger staticAssert;
@end

@interface QTStaticCast : NSObject
@property (nonatomic, assign) NSInteger staticCast;
@end

@interface QTStdDeserializer : NSObject
@property (nonatomic, assign) NSInteger stdDeserializer;
@end

@interface QTStdSerializer : NSObject
@property (nonatomic, assign) NSInteger stdSerializer;
@end

@interface QTStrictfp : NSObject
@property (nonatomic, assign) NSInteger strictfp;
@end

@interface QTString : NSObject
@property (nonatomic, assign) NSInteger string;
@end

@interface QTSubscript : NSObject
@property (nonatomic, assign) NSInteger subscript;
@end

@interface QTSuper : NSObject
@property (nonatomic, assign) NSInteger super;
@end

@interface QTSymbol : NSObject
@property (nonatomic, assign) NSInteger symbol;
@end

@interface QTSynchronized : NSObject
@property (nonatomic, assign) NSInteger synchronized;
@end

@interface QTSystem : NSObject
@property (nonatomic, assign) NSInteger system;
@end

@interface QTTemplate : NSObject
@property (nonatomic, assign) NSInteger template;
@end

@interface QTTextNode : NSObject
@property (nonatomic, assign) NSInteger textNode;
@end

@interface QTTrueClass : NSObject
@property (nonatomic, assign) NSInteger trueTrue;
@end

@interface QTThen : NSObject
@property (nonatomic, assign) NSInteger then;
@end

@interface QTThis : NSObject
@property (nonatomic, assign) NSInteger this;
@end

@interface QTThreadLocal : NSObject
@property (nonatomic, assign) NSInteger threadLocal;
@end

@interface QTThrow : NSObject
@property (nonatomic, assign) NSInteger throw;
@end

@interface QTThrows : NSObject
@property (nonatomic, assign) NSInteger throws;
@end

@interface QTTimeOnly : NSObject
@property (nonatomic, assign) NSInteger timeOnly;
@end

@interface QTTimeOnlyConverter : NSObject
@property (nonatomic, assign) NSInteger timeOnlyConverter;
@end

@interface QTTimeZone : NSObject
@property (nonatomic, assign) NSInteger timeZone;
@end

@interface QTToDict : NSObject
@property (nonatomic, assign) NSInteger toDict;
@end

@interface QTToJSON : NSObject
@property (nonatomic, assign) NSInteger toJSON;
@end

@interface QTToString : NSObject
@property (nonatomic, assign) NSInteger toString;
@end

@interface QTTopLevelClass : NSObject
@property (nonatomic, assign) NSInteger topLevel;
@end

@interface QTTransient : NSObject
@property (nonatomic, assign) NSInteger transient;
@end

@interface QTObj6 : NSObject
@property (nonatomic, assign) NSInteger dummy;
@property (nonatomic, strong) QTTypeClass *obj6Type;
@property (nonatomic, strong) QTTypedef *obj6Typedef;
@property (nonatomic, strong) QTTypeof *obj6Typeof;
@property (nonatomic, strong) QTUnion *obj6Union;
@property (nonatomic, strong) QTUnsigned *obj6Unsigned;
@property (nonatomic, strong) QTVoid *obj6Void;
@property (nonatomic, strong) QTVolatile *obj6Volatile;
@property (nonatomic, strong) QTWhile *obj6While;
@property (nonatomic, strong) QTTry *try;
@property (nonatomic, strong) QTType *type;
@property (nonatomic, strong) QTTypealias *typealias;
@property (nonatomic, strong) QTTypeid *typeid;
@property (nonatomic, strong) QTTypename *typename;
@property (nonatomic, strong) QTUint *uint;
@property (nonatomic, strong) QTUlong *ulong;
@property (nonatomic, strong) QTUnchecked *unchecked;
@property (nonatomic, strong) QTUndefined *undefined;
@property (nonatomic, strong) QTUnmarshalJSON *unmarshalJSON;
@property (nonatomic, strong) QTUnowned *unowned;
@property (nonatomic, strong) QTUnsafe *unsafe;
@property (nonatomic, strong) QTUseSerializers *useSerializers;
@property (nonatomic, strong) QTUshort *ushort;
@property (nonatomic, strong) QTUsing *using;
@property (nonatomic, strong) QTUtf8JSONReader *utf8JSONReader;
@property (nonatomic, strong) QTUtf8JSONWriter *utf8JSONWriter;
@property (nonatomic, strong) QTUUID *uuid;
@property (nonatomic, strong) QTVar *var;
@property (nonatomic, strong) QTVirtual *virtual;
@property (nonatomic, strong) QTWcharT *wcharT;
@property (nonatomic, strong) QTWeak *weak;
@property (nonatomic, strong) QTWhere *where;
@property (nonatomic, strong) QTWillSet *willSet;
@property (nonatomic, strong) QTWith *with;
@property (nonatomic, strong) QTXor *xor;
@property (nonatomic, strong) QTXorEq *xorEq;
@property (nonatomic, strong) QTYes *yes;
@property (nonatomic, strong) QTYield *yield;
@end

@interface QTTypeClass : NSObject
@property (nonatomic, assign) NSInteger type;
@end

@interface QTTypedef : NSObject
@property (nonatomic, assign) NSInteger typedefTypedef;
@end

@interface QTTypeof : NSObject
@property (nonatomic, assign) NSInteger typeofTypeof;
@end

@interface QTUnion : NSObject
@property (nonatomic, assign) NSInteger unionUnion;
@end

@interface QTUnsigned : NSObject
@property (nonatomic, assign) NSInteger unsignedUnsigned;
@end

@interface QTVoid : NSObject
@property (nonatomic, assign) NSInteger voidVoid;
@end

@interface QTVolatile : NSObject
@property (nonatomic, assign) NSInteger volatileVolatile;
@end

@interface QTWhile : NSObject
@property (nonatomic, assign) NSInteger whileWhile;
@end

@interface QTTry : NSObject
@property (nonatomic, assign) NSInteger try;
@end

@interface QTType : NSObject
@property (nonatomic, assign) NSInteger type;
@end

@interface QTTypealias : NSObject
@property (nonatomic, assign) NSInteger typealias;
@end

@interface QTTypeid : NSObject
@property (nonatomic, assign) NSInteger typeid;
@end

@interface QTTypename : NSObject
@property (nonatomic, assign) NSInteger typename;
@end

@interface QTUint : NSObject
@property (nonatomic, assign) NSInteger uint;
@end

@interface QTUlong : NSObject
@property (nonatomic, assign) NSInteger ulong;
@end

@interface QTUnchecked : NSObject
@property (nonatomic, assign) NSInteger unchecked;
@end

@interface QTUndefined : NSObject
@property (nonatomic, assign) NSInteger undefined;
@end

@interface QTUnmarshalJSON : NSObject
@property (nonatomic, assign) NSInteger unmarshalJSON;
@end

@interface QTUnowned : NSObject
@property (nonatomic, assign) NSInteger unowned;
@end

@interface QTUnsafe : NSObject
@property (nonatomic, assign) NSInteger unsafe;
@end

@interface QTUseSerializers : NSObject
@property (nonatomic, assign) NSInteger useSerializers;
@end

@interface QTUshort : NSObject
@property (nonatomic, assign) NSInteger ushort;
@end

@interface QTUsing : NSObject
@property (nonatomic, assign) NSInteger using;
@end

@interface QTUtf8JSONReader : NSObject
@property (nonatomic, assign) NSInteger utf8JSONReader;
@end

@interface QTUtf8JSONWriter : NSObject
@property (nonatomic, assign) NSInteger utf8JSONWriter;
@end

@interface QTUUID : NSObject
@property (nonatomic, assign) NSInteger uuid;
@end

@interface QTVar : NSObject
@property (nonatomic, assign) NSInteger var;
@end

@interface QTVirtual : NSObject
@property (nonatomic, assign) NSInteger virtual;
@end

@interface QTWcharT : NSObject
@property (nonatomic, assign) NSInteger wcharT;
@end

@interface QTWeak : NSObject
@property (nonatomic, assign) NSInteger weak;
@end

@interface QTWhere : NSObject
@property (nonatomic, assign) NSInteger where;
@end

@interface QTWillSet : NSObject
@property (nonatomic, assign) NSInteger willSet;
@end

@interface QTWith : NSObject
@property (nonatomic, assign) NSInteger with;
@end

@interface QTXor : NSObject
@property (nonatomic, assign) NSInteger xor;
@end

@interface QTXorEq : NSObject
@property (nonatomic, assign) NSInteger xorEq;
@end

@interface QTYes : NSObject
@property (nonatomic, assign) NSInteger yes;
@end

@interface QTYield : NSObject
@property (nonatomic, assign) NSInteger yield;
@end

NS_ASSUME_NONNULL_END
