// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTPurpleQTTopLevel;
@class QTBreed;
@class QTFirstname;
@class QTLastname;
@class QTPvptitle;
@class QTRankTitle;
@class QTSex;
@class QTFluffyQTTopLevel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTBreed : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTBreed *)atrox;
+ (QTBreed *)solitus;
+ (QTBreed *)opifex;
+ (QTBreed *)nano;
@end

@interface QTFirstname : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFirstname *)empty;
+ (QTFirstname *)chi;
@end

@interface QTLastname : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLastname *)empty;
+ (QTLastname *)washko;
@end

@interface QTPvptitle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPvptitle *)freshman;
@end

@interface QTRankTitle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRankTitle *)president;
+ (QTRankTitle *)advisor;
+ (QTRankTitle *)veteran;
+ (QTRankTitle *)applicant;
@end

@interface QTSex : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSex *)neuter;
+ (QTSex *)male;
+ (QTSex *)female;
@end

typedef NSArray<id> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTPurpleQTTopLevel : NSObject
@property (nonatomic, assign) NSInteger alienlevel;
@property (nonatomic, assign) QTBreed *breed;
@property (nonatomic, assign) NSInteger charDimension;
@property (nonatomic, assign) NSInteger charInstance;
@property (nonatomic, copy)   NSString *defenderRankTitle;
@property (nonatomic, assign) QTFirstname *firstname;
@property (nonatomic, assign) NSInteger headid;
@property (nonatomic, assign) QTLastname *lastname;
@property (nonatomic, assign) NSInteger levelx;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *prof;
@property (nonatomic, copy)   NSString *profTitle;
@property (nonatomic, assign) NSInteger pvprating;
@property (nonatomic, assign) QTPvptitle *pvptitle;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) QTRankTitle *rankTitle;
@property (nonatomic, assign) QTSex *sex;
@end

@interface QTFluffyQTTopLevel : NSObject
@property (nonatomic, assign) NSInteger adventurercount;
@property (nonatomic, assign) NSInteger agentcount;
@property (nonatomic, assign) NSInteger atroxcount;
@property (nonatomic, assign) double avglvl;
@property (nonatomic, assign) NSInteger btcount;
@property (nonatomic, assign) NSInteger doctorcount;
@property (nonatomic, assign) NSInteger enfcount;
@property (nonatomic, assign) NSInteger engineeercount;
@property (nonatomic, assign) NSInteger femalecount;
@property (nonatomic, assign) NSInteger fixercount;
@property (nonatomic, copy)   NSString *governingname;
@property (nonatomic, copy)   NSString *history;
@property (nonatomic, assign) NSInteger keepercount;
@property (nonatomic, assign) NSInteger macount;
@property (nonatomic, assign) NSInteger malecount;
@property (nonatomic, assign) NSInteger maxlvl;
@property (nonatomic, assign) NSInteger metacount;
@property (nonatomic, assign) NSInteger minlvl;
@property (nonatomic, assign) NSInteger monstercount;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger nanocount;
@property (nonatomic, assign) NSInteger nanoracecount;
@property (nonatomic, assign) NSInteger neutercount;
@property (nonatomic, assign) NSInteger nummembers;
@property (nonatomic, copy)   NSString *objective;
@property (nonatomic, assign) NSInteger opifexcount;
@property (nonatomic, assign) NSInteger orgDimension;
@property (nonatomic, assign) NSInteger orgInstance;
@property (nonatomic, copy)   NSString *qtTopLevelDESCRIPTION;
@property (nonatomic, assign) NSInteger shadecount;
@property (nonatomic, assign) NSInteger side;
@property (nonatomic, copy)   NSString *sideName;
@property (nonatomic, assign) NSInteger solidercount;
@property (nonatomic, assign) NSInteger solituscount;
@property (nonatomic, assign) NSInteger tradercount;
@end

NS_ASSUME_NONNULL_END
