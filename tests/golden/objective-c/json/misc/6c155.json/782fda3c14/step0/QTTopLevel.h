// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTMetadata;
@class QTResponseInfo;
@class QTResultset;
@class QTResult;
@class QTComponent;
@class QTLocation;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTMetadata *metadata;
@property (nonatomic, copy)   NSArray<QTResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTMetadata : NSObject
@property (nonatomic, assign) double executionTime;
@property (nonatomic, strong) QTResponseInfo *responseInfo;
@property (nonatomic, strong) QTResultset *resultset;
@end

@interface QTResponseInfo : NSObject
@property (nonatomic, copy)   NSString *developerMessage;
@property (nonatomic, assign) NSInteger status;
@end

@interface QTResultset : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pagesize;
@end

@interface QTResult : NSObject
@property (nonatomic, copy)           NSArray *attachment;
@property (nonatomic, copy)           NSString *body;
@property (nonatomic, copy)           NSString *changed;
@property (nonatomic, copy)           NSArray<QTComponent *> *component;
@property (nonatomic, copy)           NSString *created;
@property (nonatomic, copy)           NSString *date;
@property (nonatomic, copy)           NSArray *image;
@property (nonatomic, strong)         QTLocation *location;
@property (nonatomic, nullable, copy) id teaser;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, copy)           NSArray *topic;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, copy)           NSString *uuid;
@property (nonatomic, copy)           NSString *vuuid;
@end

@interface QTComponent : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uuid;
@end

@interface QTLocation : NSObject
@property (nonatomic, copy)           NSString *administrativeArea;
@property (nonatomic, copy)           NSString *country;
@property (nonatomic, copy)           NSString *faxNumber;
@property (nonatomic, copy)           NSString *locality;
@property (nonatomic, copy)           NSString *mobileNumber;
@property (nonatomic, copy)           NSString *phoneNumber;
@property (nonatomic, copy)           NSString *phoneNumberExtension;
@property (nonatomic, copy)           NSString *postalCode;
@property (nonatomic, nullable, copy) id subPremise;
@property (nonatomic, copy)           NSString *thoroughfare;
@end

NS_ASSUME_NONNULL_END
