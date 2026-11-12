// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTCategory;
@class QTLinkElement;
@class QTLinkLink;
@class QTCategoryThumbnail;
@class QTDetails;
@class QTDate;
@class QTEonandyear;
@class QTXmlschematype;
@class QTProductElement;
@class QTProductProduct;
@class QTCurrency;
@class QTRating;
@class QTUseraveragerating;
@class QTSpecification;
@class QTFormat;
@class QTFormatsClass;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTCategory *category;
@property (nonatomic, strong) QTDetails *details;
@property (nonatomic, assign) BOOL isSchk;
@property (nonatomic, copy)   NSString *match;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy)   NSArray<QTProductElement *> *product;
@property (nonatomic, assign) NSInteger totallooseoffers;
@property (nonatomic, assign) NSInteger totalpages;
@property (nonatomic, assign) NSInteger totalresultsavailable;
@property (nonatomic, assign) NSInteger totalresultsreturned;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTCategory : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isConcatenatecategoryname;
@property (nonatomic, assign) BOOL isHasoffer;
@property (nonatomic, assign) BOOL isIsfinal;
@property (nonatomic, copy)   NSArray<QTLinkElement *> *links;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger parentcategoryid;
@property (nonatomic, strong) QTCategoryThumbnail *thumbnail;
@end

@interface QTLinkElement : NSObject
@property (nonatomic, strong) QTLinkLink *link;
@end

@interface QTLinkLink : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@end

@interface QTCategoryThumbnail : NSObject
@property (nonatomic, copy) NSString *url;
@end

@interface QTDetails : NSObject
@property (nonatomic, copy)   NSString *applicationid;
@property (nonatomic, copy)   NSString *applicationversion;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) QTDate *date;
@property (nonatomic, assign) NSInteger elapsedtime;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, copy)   NSString *status;
@end

@interface QTDate : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, strong) QTEonandyear *eonandyear;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) NSInteger millisecond;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, assign) NSInteger timezone;
@property (nonatomic, strong) QTXmlschematype *xmlschematype;
@property (nonatomic, assign) NSInteger year;
@end

@interface QTEonandyear : NSObject
@property (nonatomic, assign) NSInteger lowestsetbit;
@end

@interface QTXmlschematype : NSObject
@property (nonatomic, copy) NSString *localpart;
@property (nonatomic, copy) NSString *namespaceuri;
@property (nonatomic, copy) NSString *prefix;
@end

@interface QTProductElement : NSObject
@property (nonatomic, strong) QTProductProduct *product;
@end

@interface QTProductProduct : NSObject
@property (nonatomic, assign) NSInteger categoryid;
@property (nonatomic, strong) QTCurrency *currency;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isEco;
@property (nonatomic, assign) BOOL isFulldescription;
@property (nonatomic, assign) BOOL isHasmetasearch;
@property (nonatomic, copy)   NSArray<QTLinkElement *> *links;
@property (nonatomic, assign) NSInteger numoffers;
@property (nonatomic, copy)   NSString *pricemax;
@property (nonatomic, copy)   NSString *pricemin;
@property (nonatomic, copy)   NSString *productname;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong) QTRating *rating;
@property (nonatomic, strong) QTSpecification *specification;
@property (nonatomic, strong) QTFormatsClass *thumbnail;
@property (nonatomic, assign) NSInteger totalsellers;
@end

@interface QTCurrency : NSObject
@property (nonatomic, copy) NSString *abbreviation;
@end

@interface QTRating : NSObject
@property (nonatomic, strong) QTUseraveragerating *useraveragerating;
@end

@interface QTUseraveragerating : NSObject
@property (nonatomic, copy)   NSArray<QTLinkElement *> *links;
@property (nonatomic, assign) NSInteger numcomments;
@property (nonatomic, copy)   NSString *rating;
@end

@interface QTSpecification : NSObject
@property (nonatomic, copy) NSArray<QTLinkElement *> *links;
@end

@interface QTFormat : NSObject
@property (nonatomic, strong) QTFormatsClass *formats;
@end

@interface QTFormatsClass : NSObject
@property (nonatomic, nullable, copy) NSArray<QTFormat *> *formats;
@property (nonatomic, assign)         NSInteger height;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, assign)         NSInteger width;
@end

NS_ASSUME_NONNULL_END
