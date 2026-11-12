// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTErrors;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSArray<NSString *> *columnNames;
@property (nonatomic, copy)   NSArray<NSArray<id> *> *data;
@property (nonatomic, copy)   NSString *displayURL;
@property (nonatomic, strong) QTErrors *errors;
@property (nonatomic, copy)   NSString *frequency;
@property (nonatomic, copy)   NSString *fromDate;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isPremium;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *sourceCode;
@property (nonatomic, copy)   NSString *sourceName;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *toDate;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *updatedAt;
@property (nonatomic, copy)   NSString *urlizeName;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTErrors : NSObject
@end

NS_ASSUME_NONNULL_END
