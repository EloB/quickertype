// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTPokemon;
@class QTEgg;
@class QTEvolution;
@class QTType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTEgg : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTEgg *)the2KM;
+ (QTEgg *)notInEggs;
+ (QTEgg *)the5KM;
+ (QTEgg *)the10KM;
+ (QTEgg *)omanyteCandy;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)fire;
+ (QTType *)ice;
+ (QTType *)flying;
+ (QTType *)psychic;
+ (QTType *)water;
+ (QTType *)ground;
+ (QTType *)rock;
+ (QTType *)electric;
+ (QTType *)grass;
+ (QTType *)fighting;
+ (QTType *)poison;
+ (QTType *)bug;
+ (QTType *)fairy;
+ (QTType *)ghost;
+ (QTType *)dark;
+ (QTType *)steel;
+ (QTType *)dragon;
+ (QTType *)normal;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy) NSArray<QTPokemon *> *pokemon;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTPokemon : NSObject
@property (nonatomic, assign)           double avgSpawns;
@property (nonatomic, copy)             NSString *candy;
@property (nonatomic, nullable, strong) NSNumber *candyCount;
@property (nonatomic, assign)           QTEgg *egg;
@property (nonatomic, copy)             NSString *height;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, copy)             NSString *img;
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *multipliers;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTEvolution *> *nextEvolution;
@property (nonatomic, copy)             NSString *num;
@property (nonatomic, nullable, copy)   NSArray<QTEvolution *> *prevEvolution;
@property (nonatomic, assign)           double spawnChance;
@property (nonatomic, copy)             NSString *spawnTime;
@property (nonatomic, copy)             NSArray<QTType *> *type;
@property (nonatomic, copy)             NSArray<QTType *> *weaknesses;
@property (nonatomic, copy)             NSString *weight;
@end

@interface QTEvolution : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *num;
@end

NS_ASSUME_NONNULL_END
