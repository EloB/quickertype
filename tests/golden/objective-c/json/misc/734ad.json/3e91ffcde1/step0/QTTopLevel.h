// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFacets;
@class QTResult;
@class QTStatus;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTStatus : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStatus *)active;
+ (QTStatus *)inactive;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) QTFacets *facets;
@property (nonatomic, assign) BOOL isPrevious;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, copy)   NSString *next;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, copy)   NSArray<QTResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFacets : NSObject
@end

@interface QTResult : NSObject
@property (nonatomic, nullable, copy)   NSString *acronym;
@property (nonatomic, copy)             NSString *activityConsultCommittees;
@property (nonatomic, copy)             NSString *activityEuLegislative;
@property (nonatomic, copy)             NSString *activityExpertGroups;
@property (nonatomic, copy)             NSString *activityHighLevelGroups;
@property (nonatomic, copy)             NSString *activityIndustryForums;
@property (nonatomic, copy)             NSString *activityInterGroups;
@property (nonatomic, nullable, copy)   NSString *activityOther;
@property (nonatomic, copy)             NSString *activityRelevantComm;
@property (nonatomic, nullable, copy)   NSString *beOfficeCountry;
@property (nonatomic, nullable, strong) NSNumber *beOfficeLat;
@property (nonatomic, nullable, strong) NSNumber *beOfficeLon;
@property (nonatomic, nullable, copy)   NSString *beOfficePhone;
@property (nonatomic, nullable, copy)   NSString *beOfficePostCode;
@property (nonatomic, nullable, copy)   NSString *beOfficePostbox;
@property (nonatomic, nullable, copy)   NSString *beOfficeStreet;
@property (nonatomic, nullable, copy)   NSString *beOfficeTown;
@property (nonatomic, copy)             NSString *codeOfConduct;
@property (nonatomic, assign)           NSInteger contactCountry;
@property (nonatomic, copy)             NSString *createdAt;
@property (nonatomic, copy)             NSString *entity;
@property (nonatomic, copy)             NSString *goals;
@property (nonatomic, copy)             NSString *head;
@property (nonatomic, copy)             NSString *headOfficeCountry;
@property (nonatomic, nullable, strong) NSNumber *headOfficeLat;
@property (nonatomic, nullable, strong) NSNumber *headOfficeLon;
@property (nonatomic, copy)             NSString *headOfficePhone;
@property (nonatomic, nullable, copy)   NSString *headOfficePostCode;
@property (nonatomic, nullable, copy)   NSString *headOfficePostbox;
@property (nonatomic, copy)             NSString *headOfficeStreet;
@property (nonatomic, copy)             NSString *headOfficeTown;
@property (nonatomic, copy)             NSString *identificationCode;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, copy)             NSString *infoMembers;
@property (nonatomic, copy)             NSString *lastUpdateDate;
@property (nonatomic, copy)             NSString *legal;
@property (nonatomic, copy)             NSString *legalStatus;
@property (nonatomic, assign)           NSInteger mainCategory;
@property (nonatomic, copy)             NSString *mainCategoryTitle;
@property (nonatomic, assign)           NSInteger members;
@property (nonatomic, nullable, strong) NSNumber *members100;
@property (nonatomic, nullable, strong) NSNumber *members25;
@property (nonatomic, nullable, strong) NSNumber *members50;
@property (nonatomic, nullable, strong) NSNumber *members75;
@property (nonatomic, assign)           double membersFte;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   id nativeName;
@property (nonatomic, nullable, copy)   NSString *networking;
@property (nonatomic, nullable, strong) NSNumber *numberOfNaturalPersons;
@property (nonatomic, nullable, copy)   NSString *otherCodeOfConduct;
@property (nonatomic, copy)             NSString *registrationDate;
@property (nonatomic, assign)           QTStatus *status;
@property (nonatomic, copy)             NSString *structureMembers;
@property (nonatomic, assign)           NSInteger subCategory;
@property (nonatomic, copy)             NSString *subCategoryTitle;
@property (nonatomic, copy)             NSString *updatedAt;
@property (nonatomic, copy)             NSString *uri;
@property (nonatomic, nullable, copy)   NSString *webSiteURL;
@end

NS_ASSUME_NONNULL_END
