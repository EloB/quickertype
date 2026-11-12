// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTMeta;
@class QTView;
@class QTColumn;
@class QTCachedContents;
@class QTTop;
@class QTTypeName;
@class QTFormat;
@class QTGrant;
@class QTViewMetadata;
@class QTAttachment;
@class QTCustomFields;
@class QTCommonCore;
@class QTDatasetInformation;
@class QTDatasetSummary;
@class QTDisclaimers;
@class QTFilterCondition;
@class QTChild;
@class QTChildMetadata;
@class QTTableColumnID;
@class QTFilterConditionMetadata;
@class QTJSONQuery;
@class QTOrder;
@class QTRenderTypeConfig;
@class QTVisible;
@class QTOwner;
@class QTQuery;
@class QTOrderBy;
@class QTExpression;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTTypeName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTypeName *)metaData;
+ (QTTypeName *)number;
+ (QTTypeName *)text;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<NSArray<id> *> *data;
@property (nonatomic, strong) QTMeta *meta;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTMeta : NSObject
@property (nonatomic, strong) QTView *view;
@end

@interface QTView : NSObject
@property (nonatomic, copy)   NSString *attribution;
@property (nonatomic, assign) NSInteger averageRating;
@property (nonatomic, copy)   NSString *category;
@property (nonatomic, copy)   NSArray<QTColumn *> *columns;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, copy)   NSString *displayType;
@property (nonatomic, assign) NSInteger downloadCount;
@property (nonatomic, copy)   NSArray<NSString *> *flags;
@property (nonatomic, copy)   NSArray<QTGrant *> *grants;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, assign) NSInteger indexUpdatedAt;
@property (nonatomic, assign) BOOL isHideFromCatalog;
@property (nonatomic, assign) BOOL isHideFromDataJSON;
@property (nonatomic, assign) BOOL isNewBackend;
@property (nonatomic, assign) BOOL isPublicationAppendEnabled;
@property (nonatomic, copy)   NSString *locale;
@property (nonatomic, strong) QTViewMetadata *metadata;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger numberOfComments;
@property (nonatomic, assign) NSInteger oid;
@property (nonatomic, strong) QTOwner *owner;
@property (nonatomic, copy)   NSString *provenance;
@property (nonatomic, assign) NSInteger publicationDate;
@property (nonatomic, assign) NSInteger publicationGroup;
@property (nonatomic, copy)   NSString *publicationStage;
@property (nonatomic, strong) QTQuery *query;
@property (nonatomic, copy)   NSArray<NSString *> *rights;
@property (nonatomic, assign) NSInteger rowsUpdatedAt;
@property (nonatomic, copy)   NSString *rowsUpdatedBy;
@property (nonatomic, strong) QTOwner *tableAuthor;
@property (nonatomic, assign) NSInteger tableID;
@property (nonatomic, copy)   NSArray<NSString *> *tags;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) NSInteger totalTimesRated;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, assign) NSInteger viewLastModified;
@property (nonatomic, copy)   NSString *viewType;
@end

@interface QTColumn : NSObject
@property (nonatomic, nullable, strong) QTCachedContents *cachedContents;
@property (nonatomic, assign)           QTTypeName *dataTypeName;
@property (nonatomic, copy)             NSString *fieldName;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *flags;
@property (nonatomic, strong)           QTFormat *format;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, assign)           NSInteger position;
@property (nonatomic, assign)           QTTypeName *renderTypeName;
@property (nonatomic, nullable, strong) NSNumber *tableColumnID;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@property (nonatomic, nullable, strong) NSNumber *width;
@end

@interface QTCachedContents : NSObject
@property (nonatomic, nullable, copy) NSString *average;
@property (nonatomic, copy)           NSString *largest;
@property (nonatomic, assign)         NSInteger nonNull;
@property (nonatomic, assign)         NSInteger null;
@property (nonatomic, copy)           NSString *smallest;
@property (nonatomic, nullable, copy) NSString *sum;
@property (nonatomic, copy)           NSArray<QTTop *> *top;
@end

@interface QTTop : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)   NSString *item;
@end

@interface QTFormat : NSObject
@property (nonatomic, nullable, copy) NSString *align;
@property (nonatomic, nullable, copy) NSString *noCommas;
@property (nonatomic, nullable, copy) NSString *precisionStyle;
@end

@interface QTGrant : NSObject
@property (nonatomic, copy)   NSArray<NSString *> *flags;
@property (nonatomic, assign) BOOL isInherited;
@property (nonatomic, copy)   NSString *type;
@end

@interface QTViewMetadata : NSObject
@property (nonatomic, copy)   NSArray<QTAttachment *> *attachments;
@property (nonatomic, copy)   NSArray<NSString *> *availableDisplayTypes;
@property (nonatomic, strong) QTCustomFields *customFields;
@property (nonatomic, strong) QTFilterCondition *filterCondition;
@property (nonatomic, strong) QTJSONQuery *jsonQuery;
@property (nonatomic, copy)   NSString *rdfSubject;
@property (nonatomic, strong) QTRenderTypeConfig *renderTypeConfig;
@property (nonatomic, copy)   NSString *rowLabel;
@end

@interface QTAttachment : NSObject
@property (nonatomic, copy) NSString *assetID;
@property (nonatomic, copy) NSString *blobID;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *name;
@end

@interface QTCustomFields : NSObject
@property (nonatomic, strong) QTCommonCore *commonCore;
@property (nonatomic, strong) QTDatasetInformation *datasetInformation;
@property (nonatomic, strong) QTDatasetSummary *datasetSummary;
@property (nonatomic, strong) QTDisclaimers *disclaimers;
@end

@interface QTCommonCore : NSObject
@property (nonatomic, copy) NSString *contactEmail;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *publisher;
@end

@interface QTDatasetInformation : NSObject
@property (nonatomic, copy) NSString *agency;
@end

@interface QTDatasetSummary : NSObject
@property (nonatomic, copy) NSString *contactInformation;
@property (nonatomic, copy) NSString *coverage;
@property (nonatomic, copy) NSString *granularity;
@property (nonatomic, copy) NSString *organization;
@property (nonatomic, copy) NSString *postingFrequency;
@property (nonatomic, copy) NSString *timePeriod;
@end

@interface QTDisclaimers : NSObject
@property (nonatomic, copy) NSString *disclaimer;
@property (nonatomic, copy) NSString *limitations;
@end

@interface QTFilterCondition : NSObject
@property (nonatomic, copy)   NSArray<QTChild *> *children;
@property (nonatomic, strong) QTFilterConditionMetadata *metadata;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *value;
@end

@interface QTChild : NSObject
@property (nonatomic, strong) QTChildMetadata *metadata;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *value;
@end

@interface QTChildMetadata : NSObject
@property (nonatomic, copy)   NSArray<NSArray<NSString *> *> *customValues;
@property (nonatomic, copy)   NSString *operator;
@property (nonatomic, strong) QTTableColumnID *tableColumnID;
@end

@interface QTTableColumnID : NSObject
@property (nonatomic, assign) NSInteger the703610;
@end

@interface QTFilterConditionMetadata : NSObject
@property (nonatomic, assign) BOOL isAdvanced;
@property (nonatomic, assign) NSInteger unifiedVersion;
@end

@interface QTJSONQuery : NSObject
@property (nonatomic, copy) NSArray<QTOrder *> *order;
@end

@interface QTOrder : NSObject
@property (nonatomic, copy)   NSString *columnFieldName;
@property (nonatomic, assign) BOOL isAscending;
@end

@interface QTRenderTypeConfig : NSObject
@property (nonatomic, strong) QTVisible *visible;
@end

@interface QTVisible : NSObject
@property (nonatomic, assign) BOOL isTable;
@end

@interface QTOwner : NSObject
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *profileImageURLLarge;
@property (nonatomic, copy) NSString *profileImageURLMedium;
@property (nonatomic, copy) NSString *profileImageURLSmall;
@property (nonatomic, copy) NSArray<NSString *> *rights;
@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *screenName;
@end

@interface QTQuery : NSObject
@property (nonatomic, copy) NSArray<QTOrderBy *> *orderBys;
@end

@interface QTOrderBy : NSObject
@property (nonatomic, strong) QTExpression *expression;
@property (nonatomic, assign) BOOL isAscending;
@end

@interface QTExpression : NSObject
@property (nonatomic, assign) NSInteger columnID;
@property (nonatomic, copy)   NSString *type;
@end

NS_ASSUME_NONNULL_END
