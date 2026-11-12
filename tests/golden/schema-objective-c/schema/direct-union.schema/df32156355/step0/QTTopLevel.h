// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTArrayNode;
@class QTBooleanNode;
@class QTDoubleNode;
@class QTIntNode;
@class QTLongNode;
@class QTNullNode;
@class QTObjectNode;
@class QTThing;
@class QTTextNode;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, strong) QTArrayNode *arrayNode;
@property (nonatomic, nullable, strong) QTBooleanNode *booleanNode;
@property (nonatomic, nullable, strong) QTDoubleNode *doubleNode;
@property (nonatomic, nullable, strong) QTIntNode *intNode;
@property (nonatomic, nullable, strong) QTLongNode *longNode;
@property (nonatomic, nullable, strong) QTNullNode *nullNode;
@property (nonatomic, nullable, strong) QTObjectNode *objectNode;
@property (nonatomic, copy)             NSDictionary<NSString *, QTThing *> *stuff;
@property (nonatomic, nullable, strong) QTTextNode *textNode;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTArrayNode : NSObject
@end

@interface QTBooleanNode : NSObject
@end

@interface QTDoubleNode : NSObject
@end

@interface QTIntNode : NSObject
@end

@interface QTLongNode : NSObject
@end

@interface QTNullNode : NSObject
@end

@interface QTObjectNode : NSObject
@end

@interface QTThing : NSObject
@property (nonatomic, nullable, copy) id optional;
@property (nonatomic, nullable, copy) id required;
@end

@interface QTTextNode : NSObject
@end

NS_ASSUME_NONNULL_END
