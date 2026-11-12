// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTData;
@class QTUser;
@class QTRepositoryConnection;
@class QTRepository;
@class QTError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, strong) QTData *data;
@property (nonatomic, nullable, copy)   NSArray<QTError *> *errors;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTData : NSObject
@property (nonatomic, strong) QTUser *viewer;
@end

@interface QTUser : NSObject
@property (nonatomic, copy)   NSString *login;
@property (nonatomic, strong) QTRepositoryConnection *repositories;
@end

@interface QTRepositoryConnection : NSObject
@property (nonatomic, assign)         NSInteger totalCount;
@property (nonatomic, nullable, copy) NSArray<QTRepository *> *nodes;
@end

@interface QTRepository : NSObject
@property (nonatomic, copy) NSString *name;
@end

@interface QTError : NSObject
@property (nonatomic, copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
