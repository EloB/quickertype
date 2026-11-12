// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTDefinitions;
@class QTArticle;
@class QTProperty;
@class QTFormatEnum;
@class QTDeMinimis;
@class QTDeMinimisProperties;
@class QTFAQ;
@class QTFAQProperties;
@class QTReport;
@class QTReportProperties;
@class QTTaxonomy;
@class QTTaxonomyProperties;
@class QTInfo;
@class QTPaths;
@class QTBusinessServiceProvidersSearchClass;
@class QTBusinessServiceProvidersSearchGet;
@class QTParameter;
@class QTIn;
@class QTPurpleResponses;
@class QTPurple200;
@class QTItemsClass;
@class QTConsolidatedScreeningListSearchClass;
@class QTConsolidatedScreeningListSearchGet;
@class QTFluffyResponses;
@class QTFluffy200;
@class QTPurpleSchema;
@class QTSchemaType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTFormatEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFormatEnum *)string;
@end

@interface QTIn : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTIn *)query;
@end

@interface QTSchemaType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSchemaType *)array;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSString *basePath;
@property (nonatomic, strong) QTDefinitions *definitions;
@property (nonatomic, copy)   NSString *host;
@property (nonatomic, strong) QTInfo *info;
@property (nonatomic, strong) QTPaths *paths;
@property (nonatomic, copy)   NSArray<NSString *> *produces;
@property (nonatomic, copy)   NSArray<NSString *> *schemes;
@property (nonatomic, copy)   NSString *swagger;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTDefinitions : NSObject
@property (nonatomic, strong) QTArticle *article;
@property (nonatomic, strong) QTArticle *center;
@property (nonatomic, strong) QTDeMinimis *deMinimis;
@property (nonatomic, strong) QTArticle *event;
@property (nonatomic, strong) QTFAQ *faq;
@property (nonatomic, strong) QTArticle *lead;
@property (nonatomic, strong) QTArticle *list;
@property (nonatomic, strong) QTArticle *marketIntelligence;
@property (nonatomic, strong) QTArticle *office;
@property (nonatomic, strong) QTArticle *provider;
@property (nonatomic, strong) QTArticle *rate;
@property (nonatomic, strong) QTReport *report;
@property (nonatomic, strong) QTTaxonomy *taxonomy;
@end

@interface QTArticle : NSObject
@property (nonatomic, copy) NSDictionary<NSString *, QTProperty *> *properties;
@end

@interface QTProperty : NSObject
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) QTFormatEnum *type;
@end

@interface QTDeMinimis : NSObject
@property (nonatomic, strong) QTDeMinimisProperties *properties;
@end

@interface QTDeMinimisProperties : NSObject
@property (nonatomic, strong) QTProperty *countries;
@property (nonatomic, strong) QTProperty *country;
@property (nonatomic, strong) QTProperty *deMinimisCurrency;
@property (nonatomic, strong) QTProperty *deMinimisValue;
@property (nonatomic, strong) QTProperty *notes;
@property (nonatomic, strong) QTProperty *vatAmount;
@property (nonatomic, strong) QTProperty *vatCurrency;
@end

@interface QTFAQ : NSObject
@property (nonatomic, strong) QTFAQProperties *properties;
@end

@interface QTFAQProperties : NSObject
@property (nonatomic, strong) QTProperty *answer;
@property (nonatomic, strong) QTProperty *countries;
@property (nonatomic, strong) QTProperty *firstPublishedDate;
@property (nonatomic, strong) QTProperty *identifier;
@property (nonatomic, strong) QTProperty *industries;
@property (nonatomic, strong) QTProperty *lastPublishedDate;
@property (nonatomic, strong) QTProperty *question;
@property (nonatomic, strong) QTProperty *topics;
@property (nonatomic, strong) QTProperty *tradeRegions;
@property (nonatomic, strong) QTProperty *url;
@property (nonatomic, strong) QTProperty *worldRegions;
@end

@interface QTReport : NSObject
@property (nonatomic, strong) QTReportProperties *properties;
@end

@interface QTReportProperties : NSObject
@property (nonatomic, strong) QTProperty *countries;
@property (nonatomic, strong) QTProperty *expirationDate;
@property (nonatomic, strong) QTProperty *identifier;
@property (nonatomic, strong) QTProperty *industries;
@property (nonatomic, strong) QTProperty *itaIndustries;
@property (nonatomic, strong) QTProperty *reportType;
@property (nonatomic, strong) QTProperty *theDescription;
@property (nonatomic, strong) QTProperty *title;
@property (nonatomic, strong) QTProperty *url;
@end

@interface QTTaxonomy : NSObject
@property (nonatomic, strong) QTTaxonomyProperties *properties;
@end

@interface QTTaxonomyProperties : NSObject
@property (nonatomic, strong) QTProperty *annotations;
@property (nonatomic, strong) QTProperty *datatypeProperties;
@property (nonatomic, strong) QTProperty *identifier;
@property (nonatomic, strong) QTProperty *label;
@property (nonatomic, strong) QTProperty *subClassOf;
@property (nonatomic, strong) QTProperty *type;
@end

@interface QTInfo : NSObject
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *version;
@end

@interface QTPaths : NSObject
@property (nonatomic, strong) QTBusinessServiceProvidersSearchClass *businessServiceProvidersSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *consolidatedScreeningListSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *deMinimisSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *itaFaqsSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *itaOfficeLocationsSearch;
@property (nonatomic, strong) QTBusinessServiceProvidersSearchClass *itaTaxonomiesSearch;
@property (nonatomic, strong) QTBusinessServiceProvidersSearchClass *itaZipcodeToPostSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *marketIntelligenceSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *marketResearchLibrarySearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *tariffRatesSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *tradeArticlesSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *tradeEventsSearch;
@property (nonatomic, strong) QTConsolidatedScreeningListSearchClass *tradeLeadsSearch;
@end

@interface QTBusinessServiceProvidersSearchClass : NSObject
@property (nonatomic, strong) QTBusinessServiceProvidersSearchGet *get;
@end

@interface QTBusinessServiceProvidersSearchGet : NSObject
@property (nonatomic, copy)   NSArray<QTParameter *> *parameters;
@property (nonatomic, strong) QTPurpleResponses *responses;
@property (nonatomic, copy)   NSString *summary;
@property (nonatomic, copy)   NSArray<NSString *> *tags;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTParameter : NSObject
@property (nonatomic, assign) QTFormatEnum *format;
@property (nonatomic, assign) QTIn *in;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) QTFormatEnum *type;
@end

@interface QTPurpleResponses : NSObject
@property (nonatomic, strong) QTPurple200 *the200;
@end

@interface QTPurple200 : NSObject
@property (nonatomic, strong) QTItemsClass *schema;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTItemsClass : NSObject
@property (nonatomic, copy) NSString *ref;
@end

@interface QTConsolidatedScreeningListSearchClass : NSObject
@property (nonatomic, strong) QTConsolidatedScreeningListSearchGet *get;
@end

@interface QTConsolidatedScreeningListSearchGet : NSObject
@property (nonatomic, copy)   NSArray<QTParameter *> *parameters;
@property (nonatomic, strong) QTFluffyResponses *responses;
@property (nonatomic, copy)   NSString *summary;
@property (nonatomic, copy)   NSArray<NSString *> *tags;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTFluffyResponses : NSObject
@property (nonatomic, strong) QTFluffy200 *the200;
@end

@interface QTFluffy200 : NSObject
@property (nonatomic, strong) QTPurpleSchema *schema;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTPurpleSchema : NSObject
@property (nonatomic, strong) QTItemsClass *items;
@property (nonatomic, assign) QTSchemaType *type;
@end

NS_ASSUME_NONNULL_END
