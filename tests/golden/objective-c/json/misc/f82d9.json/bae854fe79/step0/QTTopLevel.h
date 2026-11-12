// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTDefinitions;
@class QTReport;
@class QTProperties;
@class QTClickURL;
@class QTType;
@class QTInfo;
@class QTPaths;
@class QTMarketResearchLibrarySearch;
@class QTGet;
@class QTParameter;
@class QTResponses;
@class QTThe200;
@class QTSchema;
@class QTItems;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)string;
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
@property (nonatomic, strong) QTReport *report;
@end

@interface QTReport : NSObject
@property (nonatomic, strong) QTProperties *properties;
@end

@interface QTProperties : NSObject
@property (nonatomic, strong) QTClickURL *clickURL;
@property (nonatomic, strong) QTClickURL *country;
@property (nonatomic, strong) QTClickURL *expirationDate;
@property (nonatomic, strong) QTClickURL *identifier;
@property (nonatomic, strong) QTClickURL *industry;
@property (nonatomic, strong) QTClickURL *reportType;
@property (nonatomic, strong) QTClickURL *sourceIndustry;
@property (nonatomic, strong) QTClickURL *theDescription;
@property (nonatomic, strong) QTClickURL *title;
@property (nonatomic, strong) QTClickURL *url;
@end

@interface QTClickURL : NSObject
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) QTType *type;
@end

@interface QTInfo : NSObject
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *version;
@end

@interface QTPaths : NSObject
@property (nonatomic, strong) QTMarketResearchLibrarySearch *marketResearchLibrarySearch;
@end

@interface QTMarketResearchLibrarySearch : NSObject
@property (nonatomic, strong) QTGet *get;
@end

@interface QTGet : NSObject
@property (nonatomic, copy)   NSArray<QTParameter *> *parameters;
@property (nonatomic, strong) QTResponses *responses;
@property (nonatomic, copy)   NSString *summary;
@property (nonatomic, copy)   NSArray<NSString *> *tags;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTParameter : NSObject
@property (nonatomic, assign) QTType *format;
@property (nonatomic, copy)   NSString *in;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) QTType *type;
@end

@interface QTResponses : NSObject
@property (nonatomic, strong) QTThe200 *the200;
@end

@interface QTThe200 : NSObject
@property (nonatomic, strong) QTSchema *schema;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTSchema : NSObject
@property (nonatomic, strong) QTItems *items;
@property (nonatomic, copy)   NSString *type;
@end

@interface QTItems : NSObject
@property (nonatomic, copy) NSString *ref;
@end

NS_ASSUME_NONNULL_END
