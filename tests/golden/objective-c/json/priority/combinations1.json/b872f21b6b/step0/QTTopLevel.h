// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTCerographClass;
@class QTChemotherapeuticClass;
@class QTCimeliaClass;
@class QTCoadjustClass;
@class QTCredulityClass;
@class QTDeruralizeClass;
@class QTDiaereseClass;
@class QTEncrust;
@class QTFagginglyClass;
@class QTFenkClass;
@class QTFlagmakingClass;
@class QTHemocoeleClass;
@class QTInteracinar;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSString *centrodesmose;
@property (nonatomic, copy)   NSArray<id> *cerograph;
@property (nonatomic, copy)   NSArray<id> *chemotherapeutics;
@property (nonatomic, copy)   NSArray<id> *cimelia;
@property (nonatomic, assign) NSInteger citrated;
@property (nonatomic, copy)   NSArray<id> *clinodome;
@property (nonatomic, copy)   NSArray<id> *coadjust;
@property (nonatomic, copy)   NSArray<id> *consilience;
@property (nonatomic, copy)   NSArray<id> *constructor;
@property (nonatomic, copy)   NSArray<id> *continuative;
@property (nonatomic, copy)   NSArray<id> *credulity;
@property (nonatomic, copy)   NSArray<id> *creviced;
@property (nonatomic, copy)   NSArray<NSArray<NSNumber *> *> *cubiculum;
@property (nonatomic, copy)   NSArray<id> *deruralize;
@property (nonatomic, copy)   NSArray<id> *diaereses;
@property (nonatomic, copy)   NSArray<NSArray *> *dissolution;
@property (nonatomic, copy)   NSArray<id> *downstroke;
@property (nonatomic, copy)   NSArray<NSNumber *> *electrotautomerism;
@property (nonatomic, copy)   NSArray<id> *eleutheromania;
@property (nonatomic, strong) QTEncrust *encrust;
@property (nonatomic, copy)   NSArray<id> *entomoid;
@property (nonatomic, copy)   NSArray<id> *epipaleolithic;
@property (nonatomic, copy)   NSArray<id> *expropriable;
@property (nonatomic, copy)   NSArray<id> *faggingly;
@property (nonatomic, copy)   NSArray<id> *fenks;
@property (nonatomic, copy)   NSArray<id> *flagmaking;
@property (nonatomic, copy)   NSArray<id> *fluorometer;
@property (nonatomic, copy)   NSArray<NSNumber *> *fulsome;
@property (nonatomic, copy)   NSArray<id> *fuzzy;
@property (nonatomic, copy)   NSArray<id> *gardenwards;
@property (nonatomic, copy)   NSArray<id> *generalissimo;
@property (nonatomic, copy)   NSArray<NSDictionary<NSString *, NSNumber *> *> *habeas;
@property (nonatomic, copy)   NSArray<id> *hemicrystalline;
@property (nonatomic, copy)   NSArray<id> *hemocoele;
@property (nonatomic, copy)   NSArray<id> *hoister;
@property (nonatomic, copy)   NSArray<id> *hyperpiesis;
@property (nonatomic, copy)   NSArray<id> *hyppish;
@property (nonatomic, copy)   NSArray<id> *idealizer;
@property (nonatomic, copy)   NSArray<id> *incrustator;
@property (nonatomic, copy)   NSArray<id> *intentiveness;
@property (nonatomic, strong) QTInteracinar *interacinar;
@property (nonatomic, copy)   NSArray<NSArray<NSNumber *> *> *intercorrelation;
@property (nonatomic, copy)   NSArray<id> *jacutinga;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTCerographClass : NSObject
@property (nonatomic, nullable, copy) id apotropaion;
@property (nonatomic, nullable, copy) id casuary;
@property (nonatomic, nullable, copy) id creaker;
@property (nonatomic, nullable, copy) id disqualification;
@property (nonatomic, nullable, copy) id imperatorious;
@property (nonatomic, nullable, copy) id impermeabilize;
@property (nonatomic, nullable, copy) id metastoma;
@property (nonatomic, nullable, copy) id noctidiurnal;
@property (nonatomic, nullable, copy) id nonreserve;
@property (nonatomic, nullable, copy) id ophthalmotonometry;
@property (nonatomic, nullable, copy) id pailful;
@property (nonatomic, nullable, copy) id pigfish;
@property (nonatomic, nullable, copy) id pongee;
@property (nonatomic, nullable, copy) id prosodical;
@property (nonatomic, nullable, copy) id scrofuloderm;
@property (nonatomic, nullable, copy) id storekeeping;
@property (nonatomic, nullable, copy) id therologist;
@property (nonatomic, nullable, copy) id tolowa;
@property (nonatomic, nullable, copy) id tradeful;
@property (nonatomic, nullable, copy) id unriveting;
@end

@interface QTChemotherapeuticClass : NSObject
@property (nonatomic, nullable, copy)   id angioneurotic;
@property (nonatomic, nullable, copy)   id availment;
@property (nonatomic, nullable, copy)   id bladelet;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, copy)   id caulis;
@property (nonatomic, nullable, copy)   id chalcus;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id enteradenological;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id imporosity;
@property (nonatomic, nullable, copy)   id insistently;
@property (nonatomic, nullable, copy)   id intraparietal;
@property (nonatomic, nullable, copy)   id ivied;
@property (nonatomic, nullable, copy)   id maureen;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id nostochine;
@property (nonatomic, nullable, copy)   id nutcracker;
@property (nonatomic, nullable, copy)   id ofttimes;
@property (nonatomic, nullable, copy)   id phenocryst;
@property (nonatomic, nullable, copy)   id precoincident;
@property (nonatomic, nullable, copy)   id ramiferous;
@property (nonatomic, nullable, copy)   id stagmometer;
@property (nonatomic, nullable, copy)   id tetherball;
@property (nonatomic, nullable, copy)   id unshy;
@end

@interface QTCimeliaClass : NSObject
@property (nonatomic, assign)         double catharticalness;
@property (nonatomic, assign)         NSInteger chirotherium;
@property (nonatomic, copy)           NSString *disdiapason;
@property (nonatomic, assign)         BOOL isHomocerc;
@property (nonatomic, nullable, copy) id nonbookish;
@end

@interface QTCoadjustClass : NSObject
@property (nonatomic, nullable, copy)   id amidosulphonal;
@property (nonatomic, nullable, copy)   id benny;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id ensnare;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id hybridizer;
@property (nonatomic, nullable, copy)   id leastwise;
@property (nonatomic, nullable, copy)   id lof;
@property (nonatomic, nullable, copy)   id monkhood;
@property (nonatomic, nullable, copy)   id netherlandish;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id peonism;
@property (nonatomic, nullable, copy)   id phonelescope;
@property (nonatomic, nullable, copy)   id porphyrogeniture;
@property (nonatomic, nullable, copy)   id preindemnify;
@property (nonatomic, nullable, copy)   id rosal;
@property (nonatomic, nullable, copy)   id scalenous;
@property (nonatomic, nullable, copy)   id scopine;
@property (nonatomic, nullable, copy)   id sedaceae;
@property (nonatomic, nullable, copy)   id suberinize;
@property (nonatomic, nullable, copy)   id symbiot;
@property (nonatomic, nullable, copy)   id tablefellow;
@property (nonatomic, nullable, copy)   id unchargeable;
@end

@interface QTCredulityClass : NSObject
@property (nonatomic, nullable, copy) id ammonolytic;
@property (nonatomic, nullable, copy) id bushmaster;
@property (nonatomic, nullable, copy) id considering;
@property (nonatomic, nullable, copy) id consuetudinary;
@property (nonatomic, nullable, copy) id embarras;
@property (nonatomic, nullable, copy) id fineness;
@property (nonatomic, nullable, copy) id flaithship;
@property (nonatomic, nullable, copy) id flavia;
@property (nonatomic, nullable, copy) id gruffly;
@property (nonatomic, nullable, copy) id hedychium;
@property (nonatomic, nullable, copy) id leadwort;
@property (nonatomic, nullable, copy) id overseriously;
@property (nonatomic, nullable, copy) id parabola;
@property (nonatomic, nullable, copy) id pectinatodenticulate;
@property (nonatomic, nullable, copy) id popean;
@property (nonatomic, nullable, copy) id pornocrat;
@property (nonatomic, nullable, copy) id quadrisect;
@property (nonatomic, nullable, copy) id seriality;
@property (nonatomic, nullable, copy) id vamphorn;
@property (nonatomic, nullable, copy) id wharp;
@end

@interface QTDeruralizeClass : NSObject
@property (nonatomic, nullable, copy) id bockerel;
@property (nonatomic, nullable, copy) id boulder;
@property (nonatomic, nullable, copy) id churrus;
@property (nonatomic, nullable, copy) id counterdigged;
@property (nonatomic, nullable, copy) id dialogite;
@property (nonatomic, nullable, copy) id digenic;
@property (nonatomic, nullable, copy) id dunbird;
@property (nonatomic, nullable, copy) id ergatogyne;
@property (nonatomic, nullable, copy) id fiendful;
@property (nonatomic, nullable, copy) id jackrod;
@property (nonatomic, nullable, copy) id jehovistic;
@property (nonatomic, nullable, copy) id paninean;
@property (nonatomic, nullable, copy) id panther;
@property (nonatomic, nullable, copy) id placentigerous;
@property (nonatomic, nullable, copy) id romney;
@property (nonatomic, nullable, copy) id sparm;
@property (nonatomic, nullable, copy) id tocsin;
@property (nonatomic, nullable, copy) id unnicked;
@property (nonatomic, nullable, copy) id unstavable;
@property (nonatomic, nullable, copy) id windfirm;
@end

@interface QTDiaereseClass : NSObject
@property (nonatomic, nullable, copy) id amoreuxia;
@property (nonatomic, nullable, copy) id ani;
@property (nonatomic, nullable, copy) id bernicle;
@property (nonatomic, nullable, copy) id blackwasher;
@property (nonatomic, nullable, copy) id blowhard;
@property (nonatomic, nullable, copy) id broma;
@property (nonatomic, nullable, copy) id closecross;
@property (nonatomic, nullable, copy) id congregationalism;
@property (nonatomic, nullable, copy) id grayly;
@property (nonatomic, nullable, copy) id historically;
@property (nonatomic, nullable, copy) id hoast;
@property (nonatomic, nullable, copy) id irretentive;
@property (nonatomic, nullable, copy) id parcener;
@property (nonatomic, nullable, copy) id pedder;
@property (nonatomic, nullable, copy) id pseudoanatomic;
@property (nonatomic, nullable, copy) id rhizocarpian;
@property (nonatomic, nullable, copy) id samel;
@property (nonatomic, nullable, copy) id silker;
@property (nonatomic, nullable, copy) id subdentated;
@property (nonatomic, nullable, copy) id subobscure;
@end

@interface QTEncrust : NSObject
@property (nonatomic, nullable, copy) id comradely;
@property (nonatomic, nullable, copy) id diacanthous;
@property (nonatomic, nullable, copy) id feminineness;
@property (nonatomic, nullable, copy) id gossamered;
@property (nonatomic, nullable, copy) id hibernia;
@property (nonatomic, nullable, copy) id hibiscus;
@property (nonatomic, nullable, copy) id lepidosauria;
@property (nonatomic, nullable, copy) id lollingly;
@property (nonatomic, nullable, copy) id manager;
@property (nonatomic, nullable, copy) id mechanic;
@property (nonatomic, nullable, copy) id overminuteness;
@property (nonatomic, nullable, copy) id papelonne;
@property (nonatomic, nullable, copy) id plebification;
@property (nonatomic, nullable, copy) id pugmiller;
@property (nonatomic, nullable, copy) id recoveror;
@property (nonatomic, nullable, copy) id spermatoblastic;
@property (nonatomic, nullable, copy) id syllidae;
@property (nonatomic, nullable, copy) id ungyved;
@property (nonatomic, nullable, copy) id whirlabout;
@property (nonatomic, nullable, copy) id woodenware;
@end

@interface QTFagginglyClass : NSObject
@property (nonatomic, nullable, copy) id abranchian;
@property (nonatomic, nullable, copy) id aculeiform;
@property (nonatomic, nullable, copy) id adiaphoristic;
@property (nonatomic, nullable, copy) id adoptionism;
@property (nonatomic, nullable, copy) id anglic;
@property (nonatomic, nullable, copy) id antrotomy;
@property (nonatomic, nullable, copy) id coerciveness;
@property (nonatomic, nullable, copy) id decorist;
@property (nonatomic, nullable, copy) id duckhood;
@property (nonatomic, nullable, copy) id heteromeri;
@property (nonatomic, nullable, copy) id hypochnose;
@property (nonatomic, nullable, copy) id lochage;
@property (nonatomic, nullable, copy) id melee;
@property (nonatomic, nullable, copy) id nonconformitant;
@property (nonatomic, nullable, copy) id poinsettia;
@property (nonatomic, nullable, copy) id putatively;
@property (nonatomic, nullable, copy) id semivolatile;
@property (nonatomic, nullable, copy) id soleas;
@property (nonatomic, nullable, copy) id unfastenable;
@property (nonatomic, nullable, copy) id unmillinered;
@end

@interface QTFenkClass : NSObject
@property (nonatomic, nullable, copy) id apoise;
@property (nonatomic, nullable, copy) id astronomize;
@property (nonatomic, nullable, copy) id cockhorse;
@property (nonatomic, nullable, copy) id copular;
@property (nonatomic, nullable, copy) id dagomba;
@property (nonatomic, nullable, copy) id draffy;
@property (nonatomic, nullable, copy) id foreigner;
@property (nonatomic, nullable, copy) id guyandot;
@property (nonatomic, nullable, copy) id neurogliosis;
@property (nonatomic, nullable, copy) id osmious;
@property (nonatomic, nullable, copy) id palpitate;
@property (nonatomic, nullable, copy) id rebukeable;
@property (nonatomic, nullable, copy) id reinwardtia;
@property (nonatomic, nullable, copy) id reservatory;
@property (nonatomic, nullable, copy) id scalt;
@property (nonatomic, nullable, copy) id scripturalize;
@property (nonatomic, nullable, copy) id tintometer;
@property (nonatomic, nullable, copy) id tritoness;
@property (nonatomic, nullable, copy) id undergrade;
@property (nonatomic, nullable, copy) id undermountain;
@end

@interface QTFlagmakingClass : NSObject
@property (nonatomic, nullable, copy) id albarco;
@property (nonatomic, nullable, copy) id bunodonta;
@property (nonatomic, nullable, copy) id hornify;
@property (nonatomic, nullable, copy) id hydrocorisae;
@property (nonatomic, nullable, copy) id hypoglossus;
@property (nonatomic, nullable, copy) id inexpiably;
@property (nonatomic, nullable, copy) id ingratitude;
@property (nonatomic, nullable, copy) id ladyfly;
@property (nonatomic, nullable, copy) id medicament;
@property (nonatomic, nullable, copy) id monogrammatic;
@property (nonatomic, nullable, copy) id nobbut;
@property (nonatomic, nullable, copy) id notacanthidae;
@property (nonatomic, nullable, copy) id polyplacophore;
@property (nonatomic, nullable, copy) id proexercise;
@property (nonatomic, nullable, copy) id protoplast;
@property (nonatomic, nullable, copy) id puzzling;
@property (nonatomic, nullable, copy) id splanchnoskeleton;
@property (nonatomic, nullable, copy) id unloveliness;
@property (nonatomic, nullable, copy) id unquarantined;
@property (nonatomic, nullable, copy) id unrenounceable;
@end

@interface QTHemocoeleClass : NSObject
@property (nonatomic, nullable, copy)   id acrogamy;
@property (nonatomic, nullable, copy)   id amelification;
@property (nonatomic, nullable, copy)   id autobiographic;
@property (nonatomic, nullable, copy)   id berat;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id disproportionably;
@property (nonatomic, nullable, copy)   id erythrite;
@property (nonatomic, nullable, copy)   id graphic;
@property (nonatomic, nullable, copy)   id hepatological;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id incommensurably;
@property (nonatomic, nullable, copy)   id misaffirm;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id pocketbook;
@property (nonatomic, nullable, copy)   id sclerometric;
@property (nonatomic, nullable, copy)   id stambouline;
@property (nonatomic, nullable, copy)   id stickpin;
@property (nonatomic, nullable, copy)   id tubulure;
@property (nonatomic, nullable, copy)   id undelated;
@property (nonatomic, nullable, copy)   id unsalt;
@property (nonatomic, nullable, copy)   id untutelar;
@property (nonatomic, nullable, copy)   id vagrant;
@property (nonatomic, nullable, copy)   id walt;
@end

@interface QTInteracinar : NSObject
@property (nonatomic, assign)         double assapan;
@property (nonatomic, assign)         BOOL isBenefactorship;
@property (nonatomic, copy)           NSString *triseriatim;
@property (nonatomic, assign)         NSInteger tubbing;
@property (nonatomic, nullable, copy) id untrimmed;
@end

NS_ASSUME_NONNULL_END
