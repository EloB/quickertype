// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTDisplayType;
@class QTTopLevelFlag;
@class QTGrant;
@class QTGrantFlag;
@class QTGrantType;
@class QTTopLevelMetadata;
@class QTCustomFields;
@class QTTest;
@class QTJSONQuery;
@class QTGroup;
@class QTOrder;
@class QTOrderColumnFieldName;
@class QTSelect;
@class QTWhere;
@class QTChild;
@class QTChildColumnFieldName;
@class QTChildMetadata;
@class QTMetadataOperator;
@class QTTableColumnID;
@class QTChildOperator;
@class QTWhereOperator;
@class QTMetadataRenderTypeConfig;
@class QTPurpleVisible;
@class QTRichRendererConfigs;
@class QTFatRow;
@class QTColumn;
@class QTRow;
@class QTField;
@class QTFieldType;
@class QTStyles;
@class QTWidth;
@class QTV1ArchivedProperties;
@class QTAccessPoints;
@class QTV1ArchivedPropertiesRenderTypeConfig;
@class QTFluffyVisible;
@class QTModifyingViewUid;
@class QTOwner;
@class QTRoleName;
@class QTProvenance;
@class QTPublicationStage;
@class QTRatings;
@class QTRight;
@class QTRowsUpdatedBy;
@class QTTableAuthor;
@class QTViewType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTDisplayType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDisplayType *)table;
+ (QTDisplayType *)dataLens;
+ (QTDisplayType *)fatrow;
+ (QTDisplayType *)page;
@end

@interface QTTopLevelFlag : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTopLevelFlag *)flagDefault;
+ (QTTopLevelFlag *)restorable;
+ (QTTopLevelFlag *)restorePossibleForType;
@end

@interface QTGrantFlag : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGrantFlag *)public;
@end

@interface QTGrantType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGrantType *)viewer;
@end

@interface QTOrderColumnFieldName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTOrderColumnFieldName *)dateReceived;
+ (QTOrderColumnFieldName *)agreementDate;
+ (QTOrderColumnFieldName *)inEffectAsOf1_1_2012;
@end

@interface QTChildColumnFieldName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTChildColumnFieldName *)product;
+ (QTChildColumnFieldName *)complaintWhatHappened;
+ (QTChildColumnFieldName *)subProduct;
+ (QTChildColumnFieldName *)issue;
@end

@interface QTMetadataOperator : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMetadataOperator *)equals;
+ (QTMetadataOperator *)blank;
@end

@interface QTChildOperator : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTChildOperator *)equals;
+ (QTChildOperator *)isNotBlank;
@end

@interface QTWhereOperator : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTWhereOperator *)equals;
+ (QTWhereOperator *)and;
@end

@interface QTFieldType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFieldType *)columnLabel;
+ (QTFieldType *)columnData;
@end

@interface QTWidth : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTWidth *)the27;
+ (QTWidth *)the40;
+ (QTWidth *)the30;
+ (QTWidth *)the33;
@end

@interface QTModifyingViewUid : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTModifyingViewUid *)s6EwH6Mp;
@end

@interface QTRoleName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRoleName *)administrator;
+ (QTRoleName *)publisher;
@end

@interface QTProvenance : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTProvenance *)official;
@end

@interface QTPublicationStage : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPublicationStage *)published;
@end

@interface QTRight : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRight *)read;
@end

@interface QTRowsUpdatedBy : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRowsUpdatedBy *)pjxgVe4M;
+ (QTRowsUpdatedBy *)the54A3Qyun;
+ (QTRowsUpdatedBy *)the9E3M2843;
+ (QTRowsUpdatedBy *)vvcaFr6G;
@end

@interface QTViewType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTViewType *)tabular;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, assign)           NSInteger averageRating;
@property (nonatomic, nullable, copy)   NSString *category;
@property (nonatomic, assign)           NSInteger createdAt;
@property (nonatomic, nullable, assign) QTDisplayType *displayType;
@property (nonatomic, assign)           NSInteger downloadCount;
@property (nonatomic, nullable, copy)   NSArray<QTTopLevelFlag *> *flags;
@property (nonatomic, copy)             NSArray<QTGrant *> *grants;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, nullable, strong) NSNumber *indexUpdatedAt;
@property (nonatomic, assign)           BOOL isHideFromCatalog;
@property (nonatomic, assign)           BOOL isHideFromDataJSON;
@property (nonatomic, assign)           BOOL isNewBackend;
@property (nonatomic, assign)           BOOL isPublicationAppendEnabled;
@property (nonatomic, copy)             NSString *locale;
@property (nonatomic, strong)           QTTopLevelMetadata *metadata;
@property (nonatomic, nullable, strong) NSNumber *moderationStatus;
@property (nonatomic, nullable, assign) QTModifyingViewUid *modifyingViewUid;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, assign)           NSInteger numberOfComments;
@property (nonatomic, assign)           NSInteger oid;
@property (nonatomic, strong)           QTOwner *owner;
@property (nonatomic, assign)           QTProvenance *provenance;
@property (nonatomic, nullable, strong) NSNumber *publicationDate;
@property (nonatomic, assign)           NSInteger publicationGroup;
@property (nonatomic, assign)           QTPublicationStage *publicationStage;
@property (nonatomic, nullable, strong) QTRatings *ratings;
@property (nonatomic, nullable, copy)   NSString *resourceName;
@property (nonatomic, copy)             NSArray<QTRight *> *rights;
@property (nonatomic, nullable, copy)   NSString *rowClass;
@property (nonatomic, nullable, strong) NSNumber *rowIdentifierColumnID;
@property (nonatomic, nullable, strong) NSNumber *rowsUpdatedAt;
@property (nonatomic, nullable, assign) QTRowsUpdatedBy *rowsUpdatedBy;
@property (nonatomic, strong)           QTTableAuthor *tableAuthor;
@property (nonatomic, assign)           NSInteger tableID;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *tags;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@property (nonatomic, assign)           NSInteger totalTimesRated;
@property (nonatomic, assign)           NSInteger viewCount;
@property (nonatomic, assign)           NSInteger viewLastModified;
@property (nonatomic, assign)           QTViewType *viewType;
@end

@interface QTGrant : NSObject
@property (nonatomic, copy)   NSArray<QTGrantFlag *> *flags;
@property (nonatomic, assign) BOOL isInherited;
@property (nonatomic, assign) QTGrantType *type;
@end

@interface QTTopLevelMetadata : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTDisplayType *> *availableDisplayTypes;
@property (nonatomic, nullable, strong) QTCustomFields *customFields;
@property (nonatomic, nullable, strong) QTJSONQuery *jsonQuery;
@property (nonatomic, nullable, copy)   NSString *rdfClass;
@property (nonatomic, nullable, copy)   NSString *rdfSubject;
@property (nonatomic, nullable, strong) QTMetadataRenderTypeConfig *renderTypeConfig;
@property (nonatomic, nullable, strong) QTRichRendererConfigs *richRendererConfigs;
@property (nonatomic, nullable, copy)   NSString *rowIdentifier;
@property (nonatomic, nullable, copy)   NSString *rowLabel;
@property (nonatomic, nullable, strong) QTV1ArchivedProperties *v1ArchivedProperties;
@end

@interface QTCustomFields : NSObject
@property (nonatomic, strong) QTTest *test;
@end

@interface QTTest : NSObject
@property (nonatomic, copy) NSString *cfpb1;
@end

@interface QTJSONQuery : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTGroup *> *group;
@property (nonatomic, nullable, copy)   NSArray<QTOrder *> *order;
@property (nonatomic, nullable, copy)   NSArray<QTSelect *> *select;
@property (nonatomic, nullable, strong) QTWhere *where;
@end

@interface QTGroup : NSObject
@property (nonatomic, copy) NSString *columnFieldName;
@end

@interface QTOrder : NSObject
@property (nonatomic, assign) QTOrderColumnFieldName *columnFieldName;
@property (nonatomic, assign) BOOL isAscending;
@end

@interface QTSelect : NSObject
@property (nonatomic, nullable, copy) NSString *aggregate;
@property (nonatomic, copy)           NSString *columnFieldName;
@end

@interface QTWhere : NSObject
@property (nonatomic, nullable, copy)   NSArray<QTChild *> *children;
@property (nonatomic, nullable, assign) QTChildColumnFieldName *columnFieldName;
@property (nonatomic, nullable, strong) QTChildMetadata *metadata;
@property (nonatomic, assign)           QTWhereOperator *operator;
@property (nonatomic, nullable, copy)   NSString *value;
@end

@interface QTChild : NSObject
@property (nonatomic, assign)           QTChildColumnFieldName *columnFieldName;
@property (nonatomic, nullable, strong) QTChildMetadata *metadata;
@property (nonatomic, assign)           QTChildOperator *operator;
@property (nonatomic, nullable, copy)   NSString *value;
@end

@interface QTChildMetadata : NSObject
@property (nonatomic, nullable, copy)   NSArray<NSString *> *customValues;
@property (nonatomic, nullable, strong) NSNumber *freeform;
@property (nonatomic, nullable, strong) NSNumber *includeAuto;
@property (nonatomic, nullable, assign) QTMetadataOperator *operator;
@property (nonatomic, nullable, strong) QTTableColumnID *tableColumnID;
@property (nonatomic, nullable, strong) NSNumber *unifiedVersion;
@end

@interface QTTableColumnID : NSObject
@property (nonatomic, assign) NSInteger the2819740;
@end

@interface QTMetadataRenderTypeConfig : NSObject
@property (nonatomic, strong) QTPurpleVisible *visible;
@end

@interface QTPurpleVisible : NSObject
@property (nonatomic, nullable, strong) NSNumber *fatrow;
@property (nonatomic, nullable, strong) NSNumber *table;
@end

@interface QTRichRendererConfigs : NSObject
@property (nonatomic, strong) QTFatRow *fatRow;
@end

@interface QTFatRow : NSObject
@property (nonatomic, copy) NSArray<QTColumn *> *columns;
@end

@interface QTColumn : NSObject
@property (nonatomic, copy)   NSArray<QTRow *> *rows;
@property (nonatomic, strong) QTStyles *styles;
@end

@interface QTRow : NSObject
@property (nonatomic, copy) NSArray<QTField *> *fields;
@end

@interface QTField : NSObject
@property (nonatomic, assign) NSInteger tableColumnID;
@property (nonatomic, assign) QTFieldType *type;
@end

@interface QTStyles : NSObject
@property (nonatomic, assign) QTWidth *width;
@end

@interface QTV1ArchivedProperties : NSObject
@property (nonatomic, strong) QTAccessPoints *accessPoints;
@property (nonatomic, copy)   NSString *blistID;
@property (nonatomic, strong) QTV1ArchivedPropertiesRenderTypeConfig *renderTypeConfig;
@end

@interface QTAccessPoints : NSObject
@property (nonatomic, copy) NSString *theNewView;
@end

@interface QTV1ArchivedPropertiesRenderTypeConfig : NSObject
@property (nonatomic, strong) QTFluffyVisible *visible;
@end

@interface QTFluffyVisible : NSObject
@property (nonatomic, assign) BOOL isHref;
@end

@interface QTOwner : NSObject
@property (nonatomic, copy)             NSString *displayName;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *flags;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, nullable, strong) NSNumber *lastNotificationSeenAt;
@property (nonatomic, nullable, copy)   NSString *profileImageURLLarge;
@property (nonatomic, nullable, copy)   NSString *profileImageURLMedium;
@property (nonatomic, nullable, copy)   NSString *profileImageURLSmall;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *rights;
@property (nonatomic, nullable, assign) QTRoleName *roleName;
@property (nonatomic, copy)             NSString *screenName;
@end

@interface QTRatings : NSObject
@property (nonatomic, assign) NSInteger rating;
@end

@interface QTTableAuthor : NSObject
@property (nonatomic, copy)             NSString *displayName;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *rights;
@property (nonatomic, nullable, assign) QTRoleName *roleName;
@property (nonatomic, copy)             NSString *screenName;
@end

NS_ASSUME_NONNULL_END
