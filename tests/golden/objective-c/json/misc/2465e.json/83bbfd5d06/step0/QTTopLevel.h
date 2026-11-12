// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTDefinitions;
@class QTTaxonomy;
@class QTProperties;
@class QTAnnotations;
@class QTInfo;
@class QTPaths;
@class QTItaTaxonomiesSearch;
@class QTGet;
@class QTParameter;
@class QTResponses;
@class QTThe200;
@class QTSchema;

NS_ASSUME_NONNULL_BEGIN

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
@property (nonatomic, strong) QTTaxonomy *taxonomy;
@end

@interface QTTaxonomy : NSObject
@property (nonatomic, strong) QTProperties *properties;
@end

@interface QTProperties : NSObject
@property (nonatomic, strong) QTAnnotations *annotations;
@property (nonatomic, strong) QTAnnotations *datatypeProperties;
@property (nonatomic, strong) QTAnnotations *identifier;
@property (nonatomic, strong) QTAnnotations *label;
@property (nonatomic, strong) QTAnnotations *subClassOf;
@property (nonatomic, strong) QTAnnotations *type;
@end

@interface QTAnnotations : NSObject
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *type;
@end

@interface QTInfo : NSObject
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *version;
@end

@interface QTPaths : NSObject
@property (nonatomic, strong) QTItaTaxonomiesSearch *itaTaxonomiesSearch;
@end

@interface QTItaTaxonomiesSearch : NSObject
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
@property (nonatomic, copy)   NSString *format;
@property (nonatomic, copy)   NSString *in;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *type;
@end

@interface QTResponses : NSObject
@property (nonatomic, strong) QTThe200 *the200;
@end

@interface QTThe200 : NSObject
@property (nonatomic, strong) QTSchema *schema;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTSchema : NSObject
@property (nonatomic, copy) NSString *ref;
@end

NS_ASSUME_NONNULL_END
