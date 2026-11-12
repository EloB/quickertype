// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTMeta;
@class QTObject;
@class QTParty;
@class QTExtra;
@class QTPerson;
@class QTGender;
@class QTGenderLabel;
@class QTNamemod;
@class QTRoleType;
@class QTRoleTypeLabel;
@class QTSenatorClass;
@class QTSenatorClassLabel;
@class QTSenatorRank;
@class QTSenatorRankLabel;
@class QTTitle;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTParty : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTParty *)democrat;
+ (QTParty *)republican;
+ (QTParty *)independent;
@end

@interface QTGender : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGender *)female;
+ (QTGender *)male;
@end

@interface QTGenderLabel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGenderLabel *)female;
+ (QTGenderLabel *)male;
@end

@interface QTNamemod : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTNamemod *)empty;
+ (QTNamemod *)jr;
+ (QTNamemod *)iii;
@end

@interface QTRoleType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRoleType *)senator;
@end

@interface QTRoleTypeLabel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRoleTypeLabel *)senator;
@end

@interface QTSenatorClass : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSenatorClass *)class1;
+ (QTSenatorClass *)class2;
+ (QTSenatorClass *)class3;
@end

@interface QTSenatorClassLabel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSenatorClassLabel *)class1;
+ (QTSenatorClassLabel *)class2;
+ (QTSenatorClassLabel *)class3;
@end

@interface QTSenatorRank : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSenatorRank *)junior;
+ (QTSenatorRank *)senior;
@end

@interface QTSenatorRankLabel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSenatorRankLabel *)junior;
+ (QTSenatorRankLabel *)senior;
@end

@interface QTTitle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTitle *)sen;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTMeta *meta;
@property (nonatomic, copy)   NSArray<QTObject *> *objects;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTMeta : NSObject
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger totalCount;
@end

@interface QTObject : NSObject
@property (nonatomic, nullable, assign) QTParty *caucus;
@property (nonatomic, copy)             NSArray<NSNumber *> *congressNumbers;
@property (nonatomic, nullable, copy)   id district;
@property (nonatomic, copy)             NSString *enddate;
@property (nonatomic, strong)           QTExtra *extra;
@property (nonatomic, assign)           BOOL isCurrent;
@property (nonatomic, nullable, copy)   NSString *leadershipTitle;
@property (nonatomic, assign)           QTParty *party;
@property (nonatomic, strong)           QTPerson *person;
@property (nonatomic, copy)             NSString *phone;
@property (nonatomic, assign)           QTRoleType *roleType;
@property (nonatomic, assign)           QTRoleTypeLabel *roleTypeLabel;
@property (nonatomic, assign)           QTSenatorClass *senatorClass;
@property (nonatomic, assign)           QTSenatorClassLabel *senatorClassLabel;
@property (nonatomic, assign)           QTSenatorRank *senatorRank;
@property (nonatomic, assign)           QTSenatorRankLabel *senatorRankLabel;
@property (nonatomic, copy)             NSString *startdate;
@property (nonatomic, copy)             NSString *state;
@property (nonatomic, copy)             NSString *theDescription;
@property (nonatomic, assign)           QTTitle *title;
@property (nonatomic, assign)           QTRoleTypeLabel *titleLong;
@property (nonatomic, copy)             NSString *website;
@end

@interface QTExtra : NSObject
@property (nonatomic, copy)           NSString *address;
@property (nonatomic, copy)           NSString *contactForm;
@property (nonatomic, nullable, copy) NSString *fax;
@property (nonatomic, copy)           NSString *office;
@property (nonatomic, nullable, copy) NSString *rssURL;
@end

@interface QTPerson : NSObject
@property (nonatomic, copy)           NSString *bioguideid;
@property (nonatomic, copy)           NSString *birthday;
@property (nonatomic, assign)         NSInteger cspanid;
@property (nonatomic, copy)           NSString *firstname;
@property (nonatomic, assign)         QTGender *gender;
@property (nonatomic, assign)         QTGenderLabel *genderLabel;
@property (nonatomic, copy)           NSString *lastname;
@property (nonatomic, copy)           NSString *link;
@property (nonatomic, copy)           NSString *middlename;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, assign)         QTNamemod *namemod;
@property (nonatomic, copy)           NSString *nickname;
@property (nonatomic, copy)           NSString *osid;
@property (nonatomic, copy)           NSString *pvsid;
@property (nonatomic, copy)           NSString *sortname;
@property (nonatomic, nullable, copy) NSString *twitterid;
@property (nonatomic, nullable, copy) NSString *youtubeid;
@end

NS_ASSUME_NONNULL_END
