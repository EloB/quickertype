// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTTopLevelChild;
@class QTPurpleChild;
@class QTFluffyChild;
@class QTTentacledChild;
@class QTPurpleComment;
@class QTPurpleFlags;
@class QTPurpleKindString;
@class QTPurpleSignature;
@class QTGetSignatureFlags;
@class QTSignatureKindString;
@class QTGetSignatureType;
@class QTIndexSignatureElement;
@class QTPurpleType;
@class QTGetSignatureChild;
@class QTGetSignature;
@class QTElementType;
@class QTName;
@class QTTypeEnum;
@class QTFluffyComment;
@class QTFluffyFlags;
@class QTSource;
@class QTFileName;
@class QTGetSignatureComment;
@class QTGroup;
@class QTGetSignatureParameter;
@class QTTentacledComment;
@class QTTentacledFlags;
@class QTParameterKindString;
@class QTFluffyType;
@class QTTentacledType;
@class QTPurpleDeclaration;
@class QTTypeElement;
@class QTStickyComment;
@class QTTag;
@class QTStickyFlags;
@class QTExtendedBy;
@class QTFluffySignature;
@class QTIndigoFlags;
@class QTPurpleParameter;
@class QTStickyType;
@class QTIndigoType;
@class QTFluffyDeclaration;
@class QTStickyChild;
@class QTIndecentType;
@class QTIndexSignature;
@class QTHilariousType;
@class QTTentacledSignature;
@class QTIndigoComment;
@class QTFluffyParameter;
@class QTPurpleTypeArgument;
@class QTIndecentFlags;
@class QTFluffyKindString;
@class QTStickySignature;
@class QTTentacledParameter;
@class QTAmbitiousType;
@class QTTentacledDeclaration;
@class QTIndigoChild;
@class QTCunningType;
@class QTMagentaType;
@class QTStickyDeclaration;
@class QTIndecentChild;
@class QTFriskyType;
@class QTIndigoDeclaration;
@class QTFluffyTypeArgument;
@class QTTypeParameter;
@class QTMischievousType;
@class QTIndecentComment;
@class QTTentacledKindString;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTPurpleKindString : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPurpleKindString *)variable;
+ (QTPurpleKindString *)function;
+ (QTPurpleKindString *)property;
+ (QTPurpleKindString *)method;
+ (QTPurpleKindString *)constructor;
+ (QTPurpleKindString *)accessor;
+ (QTPurpleKindString *)enumerationMember;
+ (QTPurpleKindString *)module;
+ (QTPurpleKindString *)objectLiteral;
@end

@interface QTSignatureKindString : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSignatureKindString *)callSignature;
+ (QTSignatureKindString *)constructorSignature;
@end

@interface QTName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTName *)string;
+ (QTName *)number;
+ (QTName *)nameVoid;
+ (QTName *)t;
+ (QTName *)boolean;
+ (QTName *)baseClass;
+ (QTName *)any;
+ (QTName *)array;
+ (QTName *)myNumber;
@end

@interface QTTypeEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTypeEnum *)intrinsic;
+ (QTTypeEnum *)reflection;
+ (QTTypeEnum *)array;
+ (QTTypeEnum *)reference;
+ (QTTypeEnum *)typeParameter;
+ (QTTypeEnum *)tuple;
+ (QTTypeEnum *)typeUnion;
+ (QTTypeEnum *)stringLiteral;
@end

@interface QTFileName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFileName *)modulesTs;
+ (QTFileName *)classesTs;
+ (QTFileName *)flattenedTs;
+ (QTFileName *)accessTs;
+ (QTFileName *)defaultExportTs;
+ (QTFileName *)enumerationsTs;
+ (QTFileName *)functionsTs;
+ (QTFileName *)genericsTs;
+ (QTFileName *)singleExportTs;
+ (QTFileName *)typescript13Ts;
+ (QTFileName *)typescript14Ts;
+ (QTFileName *)typescript15Ts;
+ (QTFileName *)variablesTs;
@end

@interface QTParameterKindString : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTParameterKindString *)parameter;
@end

@interface QTFluffyKindString : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFluffyKindString *)module;
+ (QTFluffyKindString *)class;
+ (QTFluffyKindString *)variable;
+ (QTFluffyKindString *)function;
+ (QTFluffyKindString *)interface;
+ (QTFluffyKindString *)enumeration;
+ (QTFluffyKindString *)objectLiteral;
+ (QTFluffyKindString *)typeAlias;
@end

@interface QTTentacledKindString : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTentacledKindString *)externalModule;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<QTTopLevelChild *> *children;
@property (nonatomic, strong) QTGetSignatureFlags *flags;
@property (nonatomic, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, copy)   NSString *name;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTTopLevelChild : NSObject
@property (nonatomic, copy)             NSArray<QTPurpleChild *> *children;
@property (nonatomic, nullable, strong) QTIndecentComment *comment;
@property (nonatomic, strong)           QTPurpleFlags *flags;
@property (nonatomic, copy)             NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTTentacledKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, copy)             NSString *originalName;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@end

@interface QTPurpleChild : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTFluffyChild *> *children;
@property (nonatomic, nullable, strong) QTStickyComment *comment;
@property (nonatomic, nullable, copy)   NSString *defaultValue;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *extendedBy;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *extendedTypes;
@property (nonatomic, strong)           QTIndecentFlags *flags;
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *implementedBy;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *implementedTypes;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTFluffyKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTStickySignature *> *signatures;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@property (nonatomic, nullable, strong) QTMagentaType *type;
@property (nonatomic, nullable, copy)   NSArray<QTTypeParameter *> *typeParameter;
@end

@interface QTFluffyChild : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTTentacledChild *> *children;
@property (nonatomic, nullable, strong) QTStickyComment *comment;
@property (nonatomic, nullable, copy)   NSString *defaultValue;
@property (nonatomic, strong)           QTStickyFlags *flags;
@property (nonatomic, nullable, strong) QTGetSignature *getSignature;
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, nullable, strong) QTExtendedBy *implementationOf;
@property (nonatomic, nullable, strong) QTExtendedBy *inheritedFrom;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTPurpleKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, strong) QTExtendedBy *overwrites;
@property (nonatomic, nullable, strong) QTGetSignature *setSignature;
@property (nonatomic, nullable, copy)   NSArray<QTFluffySignature *> *signatures;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@property (nonatomic, nullable, strong) QTIndigoType *type;
@end

@interface QTTentacledChild : NSObject
@property (nonatomic, nullable, strong) QTPurpleComment *comment;
@property (nonatomic, nullable, copy)   NSString *defaultValue;
@property (nonatomic, strong)           QTPurpleFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTPurpleKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTPurpleSignature *> *signatures;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@property (nonatomic, nullable, strong) QTTypeElement *type;
@end

@interface QTPurpleComment : NSObject
@property (nonatomic, copy) NSString *shortText;
@end

@interface QTPurpleFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *isExported;
@end

@interface QTPurpleSignature : NSObject
@property (nonatomic, nullable, strong) QTPurpleComment *comment;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTSignatureKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, copy)             NSArray<QTGetSignature *> *parameters;
@property (nonatomic, strong)           QTTentacledType *type;
@end

@interface QTGetSignatureFlags : NSObject
@end

@interface QTGetSignatureType : NSObject
@property (nonatomic, nullable, strong) QTGetSignature *declaration;
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@end

@interface QTIndexSignatureElement : NSObject
@property (nonatomic, strong)         QTGetSignatureFlags *flags;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger kind;
@property (nonatomic, copy)           NSString *kindString;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, nullable, copy) NSArray<QTGetSignature *> *parameters;
@property (nonatomic, strong)         QTPurpleType *type;
@end

@interface QTPurpleType : NSObject
@property (nonatomic, nullable, strong) QTGetSignature *declaration;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@end

@interface QTGetSignatureChild : NSObject
@property (nonatomic, nullable, strong) QTFluffyComment *comment;
@property (nonatomic, strong)           QTFluffyFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTPurpleKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@property (nonatomic, strong)           QTPurpleType *type;
@end

@interface QTGetSignature : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTGetSignatureChild *> *children;
@property (nonatomic, nullable, strong) QTGetSignatureComment *comment;
@property (nonatomic, nullable, copy)   NSString *defaultValue;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, copy)             NSString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTGetSignatureParameter *> *parameters;
@property (nonatomic, nullable, copy)   NSArray<QTIndexSignatureElement *> *signatures;
@property (nonatomic, nullable, copy)   NSArray<QTSource *> *sources;
@property (nonatomic, nullable, strong) QTGetSignatureType *type;
@property (nonatomic, nullable, copy)   NSArray<QTGetSignature *> *typeParameter;
@end

@interface QTElementType : NSObject
@property (nonatomic, assign) QTName *name;
@property (nonatomic, assign) QTTypeEnum *type;
@end

@interface QTFluffyComment : NSObject
@property (nonatomic, copy) NSString *text;
@end

@interface QTFluffyFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *isOptional;
@end

@interface QTSource : NSObject
@property (nonatomic, assign) NSInteger character;
@property (nonatomic, assign) QTFileName *fileName;
@property (nonatomic, assign) NSInteger line;
@end

@interface QTGetSignatureComment : NSObject
@property (nonatomic, nullable, copy) NSString *returns;
@property (nonatomic, nullable, copy) NSString *shortText;
@property (nonatomic, nullable, copy) NSString *text;
@end

@interface QTGroup : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *children;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, copy)   NSString *title;
@end

@interface QTGetSignatureParameter : NSObject
@property (nonatomic, nullable, strong) QTTentacledComment *comment;
@property (nonatomic, strong)           QTTentacledFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTParameterKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, strong)           QTFluffyType *type;
@end

@interface QTTentacledComment : NSObject
@property (nonatomic, nullable, copy) NSString *shortText;
@property (nonatomic, nullable, copy) NSString *text;
@end

@interface QTTentacledFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *isOptional;
@property (nonatomic, nullable, strong) NSNumber *isREST;
@end

@interface QTFluffyType : NSObject
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *typeArguments;
@end

@interface QTTentacledType : NSObject
@property (nonatomic, nullable, strong) QTPurpleDeclaration *declaration;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@end

@interface QTPurpleDeclaration : NSObject
@property (nonatomic, copy)   NSArray<QTGetSignature *> *children;
@property (nonatomic, strong) QTGetSignatureFlags *flags;
@property (nonatomic, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, copy)   NSString *kindString;
@property (nonatomic, copy)   NSString *name;
@end

@interface QTTypeElement : NSObject
@property (nonatomic, nullable, strong) QTGetSignature *declaration;
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *typeArguments;
@end

@interface QTStickyComment : NSObject
@property (nonatomic, nullable, copy) NSString *returns;
@property (nonatomic, nullable, copy) NSString *shortText;
@property (nonatomic, nullable, copy) NSArray<QTTag *> *tags;
@property (nonatomic, nullable, copy) NSString *text;
@end

@interface QTTag : NSObject
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *text;
@end

@interface QTStickyFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *isAbstract;
@property (nonatomic, nullable, strong) NSNumber *isConstructorProperty;
@property (nonatomic, nullable, strong) NSNumber *isExported;
@property (nonatomic, nullable, strong) NSNumber *isPrivate;
@property (nonatomic, nullable, strong) NSNumber *isProtected;
@property (nonatomic, nullable, strong) NSNumber *isPublic;
@property (nonatomic, nullable, strong) NSNumber *isStatic;
@end

@interface QTExtendedBy : NSObject
@property (nonatomic, nullable, strong) QTExtendedBy *constraint;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *typeArguments;
@end

@interface QTFluffySignature : NSObject
@property (nonatomic, nullable, strong) QTStickyComment *comment;
@property (nonatomic, strong)           QTIndigoFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, nullable, strong) QTExtendedBy *implementationOf;
@property (nonatomic, nullable, strong) QTExtendedBy *inheritedFrom;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTSignatureKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, strong) QTExtendedBy *overwrites;
@property (nonatomic, nullable, copy)   NSArray<QTPurpleParameter *> *parameters;
@property (nonatomic, strong)           QTExtendedBy *type;
@property (nonatomic, nullable, copy)   NSArray<QTGetSignature *> *typeParameter;
@end

@interface QTIndigoFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *isPrivate;
@property (nonatomic, nullable, strong) NSNumber *isProtected;
@end

@interface QTPurpleParameter : NSObject
@property (nonatomic, nullable, strong) QTTentacledComment *comment;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTParameterKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, strong)           QTStickyType *type;
@end

@interface QTStickyType : NSObject
@property (nonatomic, nullable, strong) QTExtendedBy *constraint;
@property (nonatomic, nullable, strong) QTGetSignature *declaration;
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *elements;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *typeArguments;
@end

@interface QTIndigoType : NSObject
@property (nonatomic, nullable, strong) QTExtendedBy *constraint;
@property (nonatomic, nullable, strong) QTFluffyDeclaration *declaration;
@property (nonatomic, nullable, strong) QTExtendedBy *elementType;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *elements;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTPurpleTypeArgument *> *typeArguments;
@property (nonatomic, nullable, copy)   NSArray<QTTypeElement *> *types;
@end

@interface QTFluffyDeclaration : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTStickyChild *> *children;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, nullable, strong) QTIndexSignature *indexSignature;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, copy)             NSString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTTentacledSignature *> *signatures;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@end

@interface QTStickyChild : NSObject
@property (nonatomic, nullable, strong) QTFluffyComment *comment;
@property (nonatomic, strong)           QTFluffyFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTPurpleKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@property (nonatomic, strong)           QTIndecentType *type;
@end

@interface QTIndecentType : NSObject
@property (nonatomic, nullable, strong) QTGetSignature *declaration;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *elements;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@end

@interface QTIndexSignature : NSObject
@property (nonatomic, strong) QTGetSignatureFlags *flags;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, copy)   NSString *kindString;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSArray<QTGetSignature *> *parameters;
@property (nonatomic, strong) QTHilariousType *type;
@end

@interface QTHilariousType : NSObject
@property (nonatomic, strong) QTGetSignature *declaration;
@property (nonatomic, assign) QTTypeEnum *type;
@end

@interface QTTentacledSignature : NSObject
@property (nonatomic, nullable, strong) QTIndigoComment *comment;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTSignatureKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTFluffyParameter *> *parameters;
@property (nonatomic, strong)           QTExtendedBy *type;
@end

@interface QTIndigoComment : NSObject
@property (nonatomic, copy) NSString *returns;
@property (nonatomic, copy) NSString *shortText;
@end

@interface QTFluffyParameter : NSObject
@property (nonatomic, nullable, strong) QTFluffyComment *comment;
@property (nonatomic, strong)           QTFluffyFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, copy)             NSString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTSource *> *sources;
@property (nonatomic, strong)           QTElementType *type;
@end

@interface QTPurpleTypeArgument : NSObject
@property (nonatomic, copy)   NSString *operator;
@property (nonatomic, strong) QTElementType *target;
@property (nonatomic, copy)   NSString *type;
@end

@interface QTIndecentFlags : NSObject
@property (nonatomic, nullable, strong) NSNumber *hasExportAssignment;
@property (nonatomic, nullable, strong) NSNumber *isAbstract;
@property (nonatomic, nullable, strong) NSNumber *isConst;
@property (nonatomic, nullable, strong) NSNumber *isExported;
@property (nonatomic, nullable, strong) NSNumber *isLet;
@property (nonatomic, nullable, strong) NSNumber *isPrivate;
@property (nonatomic, nullable, strong) NSNumber *isProtected;
@end

@interface QTStickySignature : NSObject
@property (nonatomic, strong)         QTStickyComment *comment;
@property (nonatomic, strong)         QTIndigoFlags *flags;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger kind;
@property (nonatomic, assign)         QTSignatureKindString *kindString;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, nullable, copy) NSArray<QTTentacledParameter *> *parameters;
@property (nonatomic, strong)         QTCunningType *type;
@property (nonatomic, nullable, copy) NSArray<QTGetSignature *> *typeParameter;
@end

@interface QTTentacledParameter : NSObject
@property (nonatomic, nullable, strong) QTTentacledComment *comment;
@property (nonatomic, nullable, copy)   NSString *defaultValue;
@property (nonatomic, strong)           QTTentacledFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, assign)           QTParameterKindString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSString *originalName;
@property (nonatomic, strong)           QTAmbitiousType *type;
@end

@interface QTAmbitiousType : NSObject
@property (nonatomic, nullable, strong) QTTentacledDeclaration *declaration;
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *typeArguments;
@end

@interface QTTentacledDeclaration : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTIndigoChild *> *children;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *groups;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, nullable, strong) QTIndexSignatureElement *indexSignature;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, copy)             NSString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTGetSignature *> *signatures;
@property (nonatomic, copy)             NSArray<QTSource *> *sources;
@end

@interface QTIndigoChild : NSObject
@property (nonatomic, strong)         QTFluffyComment *comment;
@property (nonatomic, nullable, copy) NSString *defaultValue;
@property (nonatomic, strong)         QTFluffyFlags *flags;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger kind;
@property (nonatomic, assign)         QTPurpleKindString *kindString;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSArray<QTSource *> *sources;
@property (nonatomic, strong)         QTIndecentType *type;
@end

@interface QTCunningType : NSObject
@property (nonatomic, nullable, strong) QTPurpleDeclaration *declaration;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTElementType *> *typeArguments;
@end

@interface QTMagentaType : NSObject
@property (nonatomic, nullable, strong) QTStickyDeclaration *declaration;
@property (nonatomic, nullable, strong) QTElementType *elementType;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *elements;
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@property (nonatomic, nullable, copy)   NSArray<QTFluffyTypeArgument *> *typeArguments;
@property (nonatomic, nullable, copy)   NSArray<QTExtendedBy *> *types;
@property (nonatomic, nullable, copy)   NSString *value;
@end

@interface QTStickyDeclaration : NSObject
@property (nonatomic, nullable, copy) NSArray<QTIndecentChild *> *children;
@property (nonatomic, strong)         QTGetSignatureFlags *flags;
@property (nonatomic, nullable, copy) NSArray<QTGroup *> *groups;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger kind;
@property (nonatomic, copy)           NSString *kindString;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSArray<QTGetSignature *> *signatures;
@property (nonatomic, copy)           NSArray<QTSource *> *sources;
@end

@interface QTIndecentChild : NSObject
@property (nonatomic, strong) QTFluffyFlags *flags;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) QTPurpleKindString *kindString;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSArray<QTSource *> *sources;
@property (nonatomic, strong) QTFriskyType *type;
@end

@interface QTFriskyType : NSObject
@property (nonatomic, nullable, strong) QTIndigoDeclaration *declaration;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, assign)           QTTypeEnum *type;
@end

@interface QTIndigoDeclaration : NSObject
@property (nonatomic, nullable, copy) NSArray<QTGetSignature *> *children;
@property (nonatomic, strong)         QTGetSignatureFlags *flags;
@property (nonatomic, nullable, copy) NSArray<QTGroup *> *groups;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger kind;
@property (nonatomic, copy)           NSString *kindString;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, nullable, copy) NSArray<QTGetSignature *> *signatures;
@property (nonatomic, copy)           NSArray<QTSource *> *sources;
@end

@interface QTFluffyTypeArgument : NSObject
@property (nonatomic, assign) QTTypeEnum *type;
@property (nonatomic, copy)   NSArray<QTElementType *> *types;
@end

@interface QTTypeParameter : NSObject
@property (nonatomic, nullable, strong) QTPurpleComment *comment;
@property (nonatomic, strong)           QTGetSignatureFlags *flags;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger kind;
@property (nonatomic, copy)             NSString *kindString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, strong) QTMischievousType *type;
@end

@interface QTMischievousType : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, nullable, copy)   NSString *operator;
@property (nonatomic, nullable, strong) QTElementType *target;
@property (nonatomic, copy)             NSString *type;
@end

@interface QTIndecentComment : NSObject
@property (nonatomic, copy)           NSString *shortText;
@property (nonatomic, nullable, copy) NSArray<QTTag *> *tags;
@end

NS_ASSUME_NONNULL_END
