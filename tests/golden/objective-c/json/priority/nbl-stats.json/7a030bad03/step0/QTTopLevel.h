// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTLeaddatumEnum;
@class QTOthermatch;
@class QTPerType;
@class QTTeam;
@class QTPbp;
@class QTActionType;
@class QTFamilyNameInitial;
@class QTFirstNameInitial;
@class QTScoreboardName;
@class QTScorer;
@class QTTime;
@class QTTm;
@class QTLds;
@class QTSBlocks;
@class QTPl;
@class QTComp;
@class QTShot;
@class QTSubType;
@class QTTotallds;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTLeaddatumEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLeaddatumEnum *)empty;
+ (QTLeaddatumEnum *)p1;
+ (QTLeaddatumEnum *)p2;
+ (QTLeaddatumEnum *)p3;
+ (QTLeaddatumEnum *)p4;
@end

@interface QTPerType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPerType *)regular;
@end

@interface QTActionType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTActionType *)game;
+ (QTActionType *)period;
+ (QTActionType *)the3Pt;
+ (QTActionType *)the2Pt;
+ (QTActionType *)rebound;
+ (QTActionType *)timeout;
+ (QTActionType *)foulon;
+ (QTActionType *)foul;
+ (QTActionType *)assist;
+ (QTActionType *)substitution;
+ (QTActionType *)freethrow;
+ (QTActionType *)steal;
+ (QTActionType *)turnover;
+ (QTActionType *)block;
+ (QTActionType *)jumpball;
@end

@interface QTFamilyNameInitial : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFamilyNameInitial *)r;
+ (QTFamilyNameInitial *)m;
+ (QTFamilyNameInitial *)s;
+ (QTFamilyNameInitial *)c;
+ (QTFamilyNameInitial *)o;
+ (QTFamilyNameInitial *)w;
+ (QTFamilyNameInitial *)a;
+ (QTFamilyNameInitial *)p;
+ (QTFamilyNameInitial *)v;
+ (QTFamilyNameInitial *)i;
+ (QTFamilyNameInitial *)j;
+ (QTFamilyNameInitial *)familyNameInitialS;
+ (QTFamilyNameInitial *)h;
+ (QTFamilyNameInitial *)b;
@end

@interface QTFirstNameInitial : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFirstNameInitial *)d;
+ (QTFirstNameInitial *)j;
+ (QTFirstNameInitial *)t;
+ (QTFirstNameInitial *)c;
+ (QTFirstNameInitial *)o;
+ (QTFirstNameInitial *)h;
+ (QTFirstNameInitial *)l;
+ (QTFirstNameInitial *)a;
+ (QTFirstNameInitial *)k;
+ (QTFirstNameInitial *)r;
+ (QTFirstNameInitial *)b;
+ (QTFirstNameInitial *)n;
@end

@interface QTScoreboardName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTScoreboardName *)empty;
+ (QTScoreboardName *)tS;
+ (QTScoreboardName *)rIhata;
+ (QTScoreboardName *)dJones;
+ (QTScoreboardName *)bValentine;
@end

@interface QTSubType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSubType *)jumpshot;
+ (QTSubType *)layup;
+ (QTSubType *)dunk;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger attendance;
@property (nonatomic, copy)   NSString *clock;
@property (nonatomic, assign) NSInteger disableMatch;
@property (nonatomic, assign) NSInteger inOT;
@property (nonatomic, copy)   NSArray<NSArray<id> *> *leaddata;
@property (nonatomic, copy)   NSString *officialsReferee1;
@property (nonatomic, copy)   NSString *officialsReferee2;
@property (nonatomic, copy)   NSString *officialsReferee3;
@property (nonatomic, copy)   NSArray<QTOthermatch *> *othermatches;
@property (nonatomic, copy)   NSArray<QTPbp *> *pbp;
@property (nonatomic, assign) NSInteger period;
@property (nonatomic, assign) NSInteger periodLengthOVERTIME;
@property (nonatomic, assign) NSInteger periodLengthREGULAR;
@property (nonatomic, assign) QTPerType *periodType;
@property (nonatomic, assign) NSInteger periodsMax;
@property (nonatomic, copy)   NSDictionary<NSString *, NSArray<QTScorer *> *> *scorers;
@property (nonatomic, copy)   NSArray *timeline;
@property (nonatomic, copy)   NSDictionary<NSString *, QTTm *> *tm;
@property (nonatomic, assign) NSInteger totalTimeAdded;
@property (nonatomic, strong) QTTotallds *totallds;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTOthermatch : NSObject
@property (nonatomic, copy)   NSString *clock;
@property (nonatomic, copy)   NSString *competitionName;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, assign) NSInteger period;
@property (nonatomic, assign) QTPerType *periodType;
@property (nonatomic, strong) QTTeam *team1;
@property (nonatomic, copy)   NSString *team1Name;
@property (nonatomic, assign) NSInteger team1Score;
@property (nonatomic, strong) QTTeam *team2;
@property (nonatomic, copy)   NSString *team2Name;
@property (nonatomic, assign) NSInteger team2Score;
@end

@interface QTTeam : NSObject
@property (nonatomic, copy) NSString *teamCode;
@property (nonatomic, copy) NSString *teamCodeInternational;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *teamNameInternational;
@end

@interface QTPbp : NSObject
@property (nonatomic, assign)           QTActionType *actionType;
@property (nonatomic, nullable, copy)   NSString *familyName;
@property (nonatomic, nullable, assign) QTFamilyNameInitial *familyNameInitial;
@property (nonatomic, nullable, copy)   NSString *firstName;
@property (nonatomic, nullable, assign) QTFirstNameInitial *firstNameInitial;
@property (nonatomic, copy)             NSString *gt;
@property (nonatomic, nullable, copy)   NSString *internationalFamilyName;
@property (nonatomic, nullable, assign) QTFamilyNameInitial *internationalFamilyNameInitial;
@property (nonatomic, nullable, copy)   NSString *internationalFirstName;
@property (nonatomic, nullable, assign) QTFirstNameInitial *internationalFirstNameInitial;
@property (nonatomic, assign)           NSInteger lead;
@property (nonatomic, assign)           NSInteger period;
@property (nonatomic, assign)           QTPerType *periodType;
@property (nonatomic, copy)             NSString *player;
@property (nonatomic, assign)           NSInteger pno;
@property (nonatomic, copy)             NSString *qualifier;
@property (nonatomic, assign)           NSInteger s1;
@property (nonatomic, assign)           NSInteger s2;
@property (nonatomic, nullable, assign) QTScoreboardName *scoreboardName;
@property (nonatomic, assign)           NSInteger scoring;
@property (nonatomic, copy)             NSString *shirtNumber;
@property (nonatomic, copy)             NSString *subType;
@property (nonatomic, assign)           NSInteger success;
@property (nonatomic, assign)           NSInteger tno;
@end

@interface QTScorer : NSObject
@property (nonatomic, nullable, copy)   NSString *familyName;
@property (nonatomic, nullable, assign) QTFamilyNameInitial *familyNameInitial;
@property (nonatomic, nullable, copy)   NSString *firstName;
@property (nonatomic, nullable, assign) QTFirstNameInitial *firstNameInitial;
@property (nonatomic, nullable, copy)   NSString *gt;
@property (nonatomic, nullable, copy)   NSString *internationalFamilyName;
@property (nonatomic, nullable, assign) QTFamilyNameInitial *internationalFamilyNameInitial;
@property (nonatomic, nullable, copy)   NSString *internationalFirstName;
@property (nonatomic, nullable, assign) QTFirstNameInitial *internationalFirstNameInitial;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, strong) NSNumber *per;
@property (nonatomic, nullable, assign) QTPerType *perType;
@property (nonatomic, nullable, copy)   NSString *player;
@property (nonatomic, assign)           NSInteger pno;
@property (nonatomic, nullable, assign) QTScoreboardName *scoreboardName;
@property (nonatomic, copy)             NSString *shirtNumber;
@property (nonatomic, nullable, copy)   NSString *summary;
@property (nonatomic, nullable, copy)   NSArray<QTTime *> *times;
@property (nonatomic, assign)           NSInteger tno;
@property (nonatomic, nullable, strong) NSNumber *tot;
@end

@interface QTTime : NSObject
@property (nonatomic, copy)   NSString *gt;
@property (nonatomic, assign) NSInteger per;
@property (nonatomic, assign) QTPerType *perType;
@end

@interface QTTm : NSObject
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *codeInternational;
@property (nonatomic, assign) NSInteger fouls;
@property (nonatomic, assign) NSInteger fullScore;
@property (nonatomic, strong) QTLds *lds;
@property (nonatomic, copy)   NSString *logo;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *nameInternational;
@property (nonatomic, assign) NSInteger p1Score;
@property (nonatomic, assign) NSInteger p2Score;
@property (nonatomic, assign) NSInteger p3Score;
@property (nonatomic, assign) NSInteger p4Score;
@property (nonatomic, copy)   NSDictionary<NSString *, QTPl *> *pl;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy)   NSArray<QTScorer *> *scoring;
@property (nonatomic, copy)   NSString *shortName;
@property (nonatomic, copy)   NSString *shortNameInternational;
@property (nonatomic, copy)   NSArray<QTShot *> *shot;
@property (nonatomic, assign) NSInteger timeouts;
@property (nonatomic, assign) NSInteger totEFF1;
@property (nonatomic, assign) NSInteger totEFF2;
@property (nonatomic, assign) double totEFF3;
@property (nonatomic, assign) NSInteger totEFF4;
@property (nonatomic, assign) NSInteger totEFF5;
@property (nonatomic, assign) NSInteger totEFF6;
@property (nonatomic, assign) NSInteger totEFF7;
@property (nonatomic, assign) NSInteger totSAssists;
@property (nonatomic, assign) NSInteger totSBenchPoints;
@property (nonatomic, assign) NSInteger totSBiggestLead;
@property (nonatomic, assign) NSInteger totSBiggestScoringRun;
@property (nonatomic, assign) NSInteger totSBlocks;
@property (nonatomic, assign) NSInteger totSBlocksReceived;
@property (nonatomic, assign) NSInteger totSFieldGoalsAttempted;
@property (nonatomic, assign) NSInteger totSFieldGoalsMade;
@property (nonatomic, assign) NSInteger totSFieldGoalsPercentage;
@property (nonatomic, assign) NSInteger totSFoulsOn;
@property (nonatomic, assign) NSInteger totSFoulsPersonal;
@property (nonatomic, assign) NSInteger totSFoulsTeam;
@property (nonatomic, assign) NSInteger totSFreeThrowsAttempted;
@property (nonatomic, assign) NSInteger totSFreeThrowsMade;
@property (nonatomic, assign) NSInteger totSFreeThrowsPercentage;
@property (nonatomic, assign) NSInteger totSLeadChanges;
@property (nonatomic, assign) NSInteger totSMinutes;
@property (nonatomic, assign) NSInteger totSPoints;
@property (nonatomic, assign) NSInteger totSPointsFastBreak;
@property (nonatomic, assign) NSInteger totSPointsFromTurnovers;
@property (nonatomic, assign) NSInteger totSPointsInThePaint;
@property (nonatomic, assign) NSInteger totSPointsSecondChance;
@property (nonatomic, assign) NSInteger totSReboundsDefensive;
@property (nonatomic, assign) NSInteger totSReboundsOffensive;
@property (nonatomic, assign) NSInteger totSReboundsTeam;
@property (nonatomic, assign) NSInteger totSReboundsTeamDefensive;
@property (nonatomic, assign) NSInteger totSReboundsTeamOffensive;
@property (nonatomic, assign) NSInteger totSReboundsTotal;
@property (nonatomic, assign) NSInteger totSSteals;
@property (nonatomic, assign) NSInteger totSThreePointersAttempted;
@property (nonatomic, assign) NSInteger totSThreePointersMade;
@property (nonatomic, assign) NSInteger totSThreePointersPercentage;
@property (nonatomic, assign) double totSTimeLeading;
@property (nonatomic, assign) NSInteger totSTimesScoresLevel;
@property (nonatomic, assign) NSInteger totSTurnovers;
@property (nonatomic, assign) NSInteger totSTurnoversTeam;
@property (nonatomic, assign) NSInteger totSTwoPointersAttempted;
@property (nonatomic, assign) NSInteger totSTwoPointersMade;
@property (nonatomic, assign) NSInteger totSTwoPointersPercentage;
@end

@interface QTLds : NSObject
@property (nonatomic, copy)   NSDictionary<NSString *, QTScorer *> *sAssists;
@property (nonatomic, strong) QTSBlocks *sBlocks;
@property (nonatomic, copy)   NSDictionary<NSString *, QTScorer *> *sPoints;
@property (nonatomic, copy)   NSDictionary<NSString *, QTScorer *> *sReboundsTotal;
@property (nonatomic, copy)   NSDictionary<NSString *, QTScorer *> *sSteals;
@end

@interface QTSBlocks : NSObject
@property (nonatomic, strong) QTScorer *the1;
@end

@interface QTPl : NSObject
@property (nonatomic, assign)           NSInteger active;
@property (nonatomic, nullable, strong) NSNumber *captain;
@property (nonatomic, nullable, strong) QTComp *comp;
@property (nonatomic, assign)           NSInteger eff1;
@property (nonatomic, assign)           NSInteger eff2;
@property (nonatomic, assign)           double eff3;
@property (nonatomic, assign)           double eff4;
@property (nonatomic, assign)           NSInteger eff5;
@property (nonatomic, assign)           NSInteger eff6;
@property (nonatomic, assign)           NSInteger eff7;
@property (nonatomic, copy)             NSString *familyName;
@property (nonatomic, assign)           QTFamilyNameInitial *familyNameInitial;
@property (nonatomic, copy)             NSString *firstName;
@property (nonatomic, assign)           QTFirstNameInitial *firstNameInitial;
@property (nonatomic, copy)             NSString *internationalFamilyName;
@property (nonatomic, assign)           QTFamilyNameInitial *internationalFamilyNameInitial;
@property (nonatomic, copy)             NSString *internationalFirstName;
@property (nonatomic, assign)           QTFirstNameInitial *internationalFirstNameInitial;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, copy)             NSString *playingPosition;
@property (nonatomic, assign)           NSInteger sAssists;
@property (nonatomic, assign)           NSInteger sBlocks;
@property (nonatomic, assign)           NSInteger sBlocksReceived;
@property (nonatomic, assign)           NSInteger sFieldGoalsAttempted;
@property (nonatomic, assign)           NSInteger sFieldGoalsMade;
@property (nonatomic, assign)           NSInteger sFieldGoalsPercentage;
@property (nonatomic, assign)           NSInteger sFoulsOn;
@property (nonatomic, assign)           NSInteger sFoulsPersonal;
@property (nonatomic, assign)           NSInteger sFreeThrowsAttempted;
@property (nonatomic, assign)           NSInteger sFreeThrowsMade;
@property (nonatomic, assign)           NSInteger sFreeThrowsPercentage;
@property (nonatomic, copy)             id sMinutes;
@property (nonatomic, assign)           NSInteger sPlusMinusPoints;
@property (nonatomic, assign)           NSInteger sPoints;
@property (nonatomic, assign)           NSInteger sPointsFastBreak;
@property (nonatomic, assign)           NSInteger sPointsInThePaint;
@property (nonatomic, assign)           NSInteger sPointsSecondChance;
@property (nonatomic, assign)           NSInteger sReboundsDefensive;
@property (nonatomic, assign)           NSInteger sReboundsOffensive;
@property (nonatomic, assign)           NSInteger sReboundsTotal;
@property (nonatomic, assign)           NSInteger sSteals;
@property (nonatomic, assign)           NSInteger sThreePointersAttempted;
@property (nonatomic, assign)           NSInteger sThreePointersMade;
@property (nonatomic, assign)           NSInteger sThreePointersPercentage;
@property (nonatomic, assign)           NSInteger sTurnovers;
@property (nonatomic, assign)           NSInteger sTwoPointersAttempted;
@property (nonatomic, assign)           NSInteger sTwoPointersMade;
@property (nonatomic, assign)           NSInteger sTwoPointersPercentage;
@property (nonatomic, copy)             NSString *shirtNumber;
@property (nonatomic, assign)           NSInteger starter;
@end

@interface QTComp : NSObject
@property (nonatomic, assign) double sAssistsAverage;
@property (nonatomic, copy)   NSString *sMinutesAverage;
@property (nonatomic, assign) double sPointsAverage;
@property (nonatomic, assign) double sReboundsTotalAverage;
@end

@interface QTShot : NSObject
@property (nonatomic, assign) QTActionType *actionType;
@property (nonatomic, assign) NSInteger p;
@property (nonatomic, assign) NSInteger per;
@property (nonatomic, assign) QTPerType *perType;
@property (nonatomic, copy)   NSString *player;
@property (nonatomic, assign) NSInteger pno;
@property (nonatomic, assign) NSInteger r;
@property (nonatomic, copy)   NSString *shirtNumber;
@property (nonatomic, assign) QTSubType *subType;
@property (nonatomic, assign) NSInteger tno;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@end

@interface QTTotallds : NSObject
@property (nonatomic, copy) NSDictionary<NSString *, QTScorer *> *sAssists;
@property (nonatomic, copy) NSDictionary<NSString *, QTScorer *> *sBlocks;
@property (nonatomic, copy) NSDictionary<NSString *, QTScorer *> *sPoints;
@property (nonatomic, copy) NSDictionary<NSString *, QTScorer *> *sReboundsTotal;
@property (nonatomic, copy) NSDictionary<NSString *, QTScorer *> *sSteals;
@end

NS_ASSUME_NONNULL_END
