// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTArgs;
@class QTHeaders;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTArgs *args;
@property (nonatomic, copy)   NSString *data;
@property (nonatomic, strong) QTArgs *files;
@property (nonatomic, strong) QTArgs *form;
@property (nonatomic, strong) QTHeaders *headers;
@property (nonatomic, copy)   NSString *origin;
@property (nonatomic, copy)   NSString *url;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTArgs : NSObject
@end

@interface QTHeaders : NSObject
@property (nonatomic, copy) NSString *acceptEncoding;
@property (nonatomic, copy) NSString *connection;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *userAgent;
@end

NS_ASSUME_NONNULL_END
