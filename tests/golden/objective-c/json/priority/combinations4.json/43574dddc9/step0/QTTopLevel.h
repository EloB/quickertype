// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTPulpitismClass;
@class QTPyodermiaClass;
@class QTQuebrachineClass;
@class QTReimagine;
@class QTRessaut;
@class QTRewriteClass;
@class QTSantirClass;
@class QTSaxtenClass;
@class QTScatty;
@class QTSisteringClass;
@class QTStaghunting;
@class QTStrenuosityClass;
@class QTTruantcyClass;
@class QTUnimpeachablyClass;
@class QTUnstressedClass;
@class QTWrothyClass;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<id> *protrusive;
@property (nonatomic, copy)   NSArray<id> *pulpitism;
@property (nonatomic, copy)   NSArray<id> *pyodermia;
@property (nonatomic, copy)   NSArray<id> *quebrachine;
@property (nonatomic, copy)   NSArray<id> *querier;
@property (nonatomic, copy)   NSArray<id> *rebarbative;
@property (nonatomic, copy)   NSArray<QTReimagine *> *reimagine;
@property (nonatomic, strong) QTRessaut *ressaut;
@property (nonatomic, copy)   NSArray<id> *retrocervical;
@property (nonatomic, copy)   NSArray<id> *revert;
@property (nonatomic, copy)   NSArray<id> *rewrite;
@property (nonatomic, copy)   NSArray<id> *saccoderm;
@property (nonatomic, copy)   NSArray<id> *santir;
@property (nonatomic, copy)   NSArray<id> *saprophilous;
@property (nonatomic, copy)   NSArray<id> *saxten;
@property (nonatomic, copy)   NSArray<QTScatty *> *scatty;
@property (nonatomic, copy)   NSArray<id> *scoffer;
@property (nonatomic, copy)   NSArray<id> *scrampum;
@property (nonatomic, assign) double semantic;
@property (nonatomic, copy)   NSArray<id> *serpentinic;
@property (nonatomic, copy)   NSArray<id> *shadowable;
@property (nonatomic, copy)   NSArray<id> *sistering;
@property (nonatomic, copy)   NSArray<QTStaghunting *> *staghunting;
@property (nonatomic, copy)   NSArray<id> *stagmometer;
@property (nonatomic, copy)   NSArray<id> *stimulability;
@property (nonatomic, copy)   NSArray<id> *strangleable;
@property (nonatomic, copy)   NSArray<id> *strenuosity;
@property (nonatomic, copy)   NSArray<id> *tabaxir;
@property (nonatomic, copy)   NSArray<id> *talpiform;
@property (nonatomic, copy)   NSArray<id> *thwack;
@property (nonatomic, copy)   NSArray<NSNumber *> *to;
@property (nonatomic, copy)   NSArray<id> *tortricine;
@property (nonatomic, copy)   NSArray<id> *truantcy;
@property (nonatomic, copy)   NSArray<NSString *> *turgesce;
@property (nonatomic, copy)   NSArray<id> *unbeginning;
@property (nonatomic, copy)   NSArray<NSNumber *> *underdunged;
@property (nonatomic, copy)   NSArray<id> *undesirability;
@property (nonatomic, copy)   NSArray<id> *unerasing;
@property (nonatomic, copy)   NSArray<id> *unguentarium;
@property (nonatomic, copy)   NSArray<id> *unimpeachably;
@property (nonatomic, copy)   NSArray<id> *unmortgaged;
@property (nonatomic, copy)   NSArray<id> *unobstructed;
@property (nonatomic, copy)   NSArray<id> *unreceptivity;
@property (nonatomic, copy)   NSArray<id> *unsatisfactoriness;
@property (nonatomic, copy)   NSArray<NSNumber *> *unsecurity;
@property (nonatomic, copy)   NSArray<id> *unstressed;
@property (nonatomic, copy)   NSArray<id> *untasked;
@property (nonatomic, copy)   NSArray<id> *unvarying;
@property (nonatomic, copy)   NSArray<id> *vehemently;
@property (nonatomic, copy)   NSDictionary<NSString *, NSNumber *> *warriorship;
@property (nonatomic, copy)   NSArray<id> *whitepot;
@property (nonatomic, copy)   NSArray<id> *wrothy;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTPulpitismClass : NSObject
@property (nonatomic, nullable, copy) id abnet;
@property (nonatomic, nullable, copy) id buckhorn;
@property (nonatomic, nullable, copy) id calciform;
@property (nonatomic, nullable, copy) id chelophore;
@property (nonatomic, nullable, copy) id cogitation;
@property (nonatomic, nullable, copy) id decreeable;
@property (nonatomic, nullable, copy) id despicable;
@property (nonatomic, nullable, copy) id isodiazo;
@property (nonatomic, nullable, copy) id jadedly;
@property (nonatomic, nullable, copy) id leptochlorite;
@property (nonatomic, nullable, copy) id nursling;
@property (nonatomic, nullable, copy) id palamedean;
@property (nonatomic, nullable, copy) id photoheliograph;
@property (nonatomic, nullable, copy) id pipewood;
@property (nonatomic, nullable, copy) id roberd;
@property (nonatomic, nullable, copy) id statable;
@property (nonatomic, nullable, copy) id superassume;
@property (nonatomic, nullable, copy) id syllabe;
@property (nonatomic, nullable, copy) id toughhead;
@property (nonatomic, nullable, copy) id underburn;
@end

@interface QTPyodermiaClass : NSObject
@property (nonatomic, nullable, copy) id aphoristically;
@property (nonatomic, nullable, copy) id apophyllous;
@property (nonatomic, nullable, copy) id cognize;
@property (nonatomic, nullable, copy) id dermonosology;
@property (nonatomic, nullable, copy) id gyppo;
@property (nonatomic, nullable, copy) id ither;
@property (nonatomic, nullable, copy) id juglandaceous;
@property (nonatomic, nullable, copy) id litho;
@property (nonatomic, nullable, copy) id macropterous;
@property (nonatomic, nullable, copy) id photographer;
@property (nonatomic, nullable, copy) id romancing;
@property (nonatomic, nullable, copy) id rumness;
@property (nonatomic, nullable, copy) id somniloquist;
@property (nonatomic, nullable, copy) id stressfully;
@property (nonatomic, nullable, copy) id tactically;
@property (nonatomic, nullable, copy) id tracheophony;
@property (nonatomic, nullable, copy) id unappositely;
@property (nonatomic, nullable, copy) id unclothedly;
@property (nonatomic, nullable, copy) id unimplied;
@property (nonatomic, nullable, copy) id unsyncopated;
@end

@interface QTQuebrachineClass : NSObject
@property (nonatomic, assign)         double catharticalness;
@property (nonatomic, assign)         NSInteger chirotherium;
@property (nonatomic, copy)           NSString *disdiapason;
@property (nonatomic, assign)         BOOL isHomocerc;
@property (nonatomic, nullable, copy) id nonbookish;
@end

@interface QTReimagine : NSObject
@property (nonatomic, nullable, copy)   id adducible;
@property (nonatomic, nullable, copy)   id anabolin;
@property (nonatomic, nullable, copy)   id brainy;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   id chrysamine;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id fluxweed;
@property (nonatomic, nullable, copy)   id glaucine;
@property (nonatomic, nullable, copy)   id grobianism;
@property (nonatomic, nullable, copy)   id hermo;
@property (nonatomic, nullable, copy)   id hieroglyphist;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id icteroid;
@property (nonatomic, nullable, copy)   id immortal;
@property (nonatomic, nullable, copy)   id impetulant;
@property (nonatomic, nullable, copy)   id irrigate;
@property (nonatomic, nullable, copy)   id myxedema;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id onyx;
@property (nonatomic, nullable, copy)   id repasser;
@property (nonatomic, nullable, copy)   id septomarginal;
@property (nonatomic, nullable, copy)   id subdie;
@property (nonatomic, nullable, copy)   id tibiometatarsal;
@property (nonatomic, nullable, copy)   id waltzlike;
@end

@interface QTRessaut : NSObject
@property (nonatomic, copy) NSString *apperceptive;
@property (nonatomic, copy) NSString *cuttoo;
@property (nonatomic, copy) NSString *douser;
@property (nonatomic, copy) NSString *drinkproof;
@property (nonatomic, copy) NSString *forementioned;
@property (nonatomic, copy) NSString *freesia;
@property (nonatomic, copy) NSString *genevieve;
@property (nonatomic, copy) NSString *hyperdiabolical;
@property (nonatomic, copy) NSString *hypocone;
@property (nonatomic, copy) NSString *irreverentially;
@property (nonatomic, copy) NSString *jumart;
@property (nonatomic, copy) NSString *mimosaceae;
@property (nonatomic, copy) NSString *mollicrush;
@property (nonatomic, copy) NSString *nedder;
@property (nonatomic, copy) NSString *retinasphalt;
@property (nonatomic, copy) NSString *sough;
@property (nonatomic, copy) NSString *steading;
@property (nonatomic, copy) NSString *theopaschitism;
@property (nonatomic, copy) NSString *undurableness;
@property (nonatomic, copy) NSString *unmingleable;
@end

@interface QTRewriteClass : NSObject
@property (nonatomic, nullable, copy) id accountancy;
@property (nonatomic, nullable, copy) id cacotrophic;
@property (nonatomic, nullable, copy) id contest;
@property (nonatomic, nullable, copy) id couthily;
@property (nonatomic, nullable, copy) id falculate;
@property (nonatomic, nullable, copy) id foreseize;
@property (nonatomic, nullable, copy) id hyades;
@property (nonatomic, nullable, copy) id lemnad;
@property (nonatomic, nullable, copy) id monotheistically;
@property (nonatomic, nullable, copy) id nonflying;
@property (nonatomic, nullable, copy) id ptenoglossa;
@property (nonatomic, nullable, copy) id repatch;
@property (nonatomic, nullable, copy) id rodman;
@property (nonatomic, nullable, copy) id strung;
@property (nonatomic, nullable, copy) id titmal;
@property (nonatomic, nullable, copy) id twalpennyworth;
@property (nonatomic, nullable, copy) id unblamable;
@property (nonatomic, nullable, copy) id vertical;
@property (nonatomic, nullable, copy) id whiggification;
@property (nonatomic, nullable, copy) id yardman;
@end

@interface QTSantirClass : NSObject
@property (nonatomic, nullable, copy) id admiredly;
@property (nonatomic, nullable, copy) id demicaponier;
@property (nonatomic, nullable, copy) id epitympanic;
@property (nonatomic, nullable, copy) id investitor;
@property (nonatomic, nullable, copy) id lupiform;
@property (nonatomic, nullable, copy) id monoflagellate;
@property (nonatomic, nullable, copy) id paleoethnic;
@property (nonatomic, nullable, copy) id prediscountable;
@property (nonatomic, nullable, copy) id rhetoricals;
@property (nonatomic, nullable, copy) id roomth;
@property (nonatomic, nullable, copy) id saccharose;
@property (nonatomic, nullable, copy) id septonasal;
@property (nonatomic, nullable, copy) id serpenticide;
@property (nonatomic, nullable, copy) id setarious;
@property (nonatomic, nullable, copy) id spaework;
@property (nonatomic, nullable, copy) id stylite;
@property (nonatomic, nullable, copy) id suessiones;
@property (nonatomic, nullable, copy) id timelily;
@property (nonatomic, nullable, copy) id unprofaned;
@property (nonatomic, nullable, copy) id vorticular;
@end

@interface QTSaxtenClass : NSObject
@property (nonatomic, nullable, copy)   id algarrobilla;
@property (nonatomic, nullable, copy)   id bowgrace;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, copy)   id centaurid;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id flix;
@property (nonatomic, nullable, copy)   id germanely;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id inhume;
@property (nonatomic, nullable, copy)   id lepidote;
@property (nonatomic, nullable, copy)   id megalochirous;
@property (nonatomic, nullable, copy)   id ninepenny;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id nondeist;
@property (nonatomic, nullable, copy)   id nymphaeaceous;
@property (nonatomic, nullable, copy)   id parietofrontal;
@property (nonatomic, nullable, copy)   id sancyite;
@property (nonatomic, nullable, copy)   id subjectivist;
@property (nonatomic, nullable, copy)   id tibiad;
@property (nonatomic, nullable, copy)   id transonic;
@property (nonatomic, nullable, copy)   id tripetalous;
@property (nonatomic, nullable, copy)   id trunchman;
@property (nonatomic, nullable, copy)   id urger;
@property (nonatomic, nullable, copy)   id withdrawnness;
@end

@interface QTScatty : NSObject
@property (nonatomic, nullable, copy) id aeriferous;
@property (nonatomic, nullable, copy) id antical;
@property (nonatomic, nullable, copy) id antighostism;
@property (nonatomic, nullable, copy) id arcanum;
@property (nonatomic, nullable, copy) id autotrophy;
@property (nonatomic, nullable, copy) id baronial;
@property (nonatomic, nullable, copy) id caffeine;
@property (nonatomic, nullable, copy) id gorgoniacean;
@property (nonatomic, nullable, copy) id heroical;
@property (nonatomic, nullable, copy) id hydropical;
@property (nonatomic, nullable, copy) id mechanology;
@property (nonatomic, nullable, copy) id musicopoetic;
@property (nonatomic, nullable, copy) id officiality;
@property (nonatomic, nullable, copy) id oftentimes;
@property (nonatomic, nullable, copy) id ophthalmotonometer;
@property (nonatomic, nullable, copy) id reflectively;
@property (nonatomic, nullable, copy) id springer;
@property (nonatomic, nullable, copy) id tabasco;
@property (nonatomic, nullable, copy) id teleianthous;
@property (nonatomic, nullable, copy) id uncombated;
@end

@interface QTSisteringClass : NSObject
@property (nonatomic, nullable, copy) id amphicarpic;
@property (nonatomic, nullable, copy) id chianti;
@property (nonatomic, nullable, copy) id frigorific;
@property (nonatomic, nullable, copy) id haplomi;
@property (nonatomic, nullable, copy) id hyperkinesis;
@property (nonatomic, nullable, copy) id laudable;
@property (nonatomic, nullable, copy) id madwoman;
@property (nonatomic, nullable, copy) id maimedly;
@property (nonatomic, nullable, copy) id micropterygidae;
@property (nonatomic, nullable, copy) id microrhabdus;
@property (nonatomic, nullable, copy) id nondense;
@property (nonatomic, nullable, copy) id phlebemphraxis;
@property (nonatomic, nullable, copy) id redsear;
@property (nonatomic, nullable, copy) id schismatical;
@property (nonatomic, nullable, copy) id tartryl;
@property (nonatomic, nullable, copy) id unabhorred;
@property (nonatomic, nullable, copy) id undeliberateness;
@property (nonatomic, nullable, copy) id unmixable;
@property (nonatomic, nullable, copy) id untruckling;
@property (nonatomic, nullable, copy) id vineal;
@end

@interface QTStaghunting : NSObject
@property (nonatomic, nullable, strong) NSNumber *calorimetric;
@property (nonatomic, nullable, strong) NSNumber *canid;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *ditriglyphic;
@property (nonatomic, nullable, strong) NSNumber *floriferousness;
@property (nonatomic, nullable, strong) NSNumber *gamelike;
@property (nonatomic, nullable, strong) NSNumber *grig;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *interloan;
@property (nonatomic, nullable, strong) NSNumber *lithotomy;
@property (nonatomic, nullable, strong) NSNumber *loric;
@property (nonatomic, nullable, strong) NSNumber *membranocoriaceous;
@property (nonatomic, nullable, strong) NSNumber *membranogenic;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *overtrump;
@property (nonatomic, nullable, strong) NSNumber *scotino;
@property (nonatomic, nullable, strong) NSNumber *seasonable;
@property (nonatomic, nullable, strong) NSNumber *sephen;
@property (nonatomic, nullable, strong) NSNumber *stigmarioid;
@property (nonatomic, nullable, strong) NSNumber *tired;
@property (nonatomic, nullable, strong) NSNumber *trifid;
@property (nonatomic, nullable, strong) NSNumber *undefeatedly;
@property (nonatomic, nullable, strong) NSNumber *ungirlish;
@end

@interface QTStrenuosityClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *bliss;
@property (nonatomic, nullable, strong) NSNumber *buccate;
@property (nonatomic, nullable, strong) NSNumber *bulletproof;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *crumblingness;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *engagedly;
@property (nonatomic, nullable, strong) NSNumber *fightable;
@property (nonatomic, nullable, strong) NSNumber *hoariness;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *hypopodium;
@property (nonatomic, nullable, strong) NSNumber *luxurist;
@property (nonatomic, nullable, strong) NSNumber *mechanician;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *onopordon;
@property (nonatomic, nullable, strong) NSNumber *podgily;
@property (nonatomic, nullable, strong) NSNumber *reformableness;
@property (nonatomic, nullable, strong) NSNumber *scatterbrains;
@property (nonatomic, nullable, strong) NSNumber *seminuria;
@property (nonatomic, nullable, strong) NSNumber *sodomite;
@property (nonatomic, nullable, strong) NSNumber *tramp;
@property (nonatomic, nullable, strong) NSNumber *undueness;
@property (nonatomic, nullable, strong) NSNumber *worthily;
@property (nonatomic, nullable, strong) NSNumber *yankeeist;
@end

@interface QTTruantcyClass : NSObject
@property (nonatomic, nullable, copy)   id alfiona;
@property (nonatomic, nullable, copy)   id ascaridiasis;
@property (nonatomic, nullable, copy)   id bungey;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, copy)   id ceroxyle;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   id chorology;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id enmarble;
@property (nonatomic, nullable, copy)   id epeira;
@property (nonatomic, nullable, copy)   id eurylaimi;
@property (nonatomic, nullable, copy)   id germination;
@property (nonatomic, nullable, copy)   id hallelujah;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id lev;
@property (nonatomic, nullable, copy)   id mouthing;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id philliloo;
@property (nonatomic, nullable, copy)   id planetal;
@property (nonatomic, nullable, copy)   id poney;
@property (nonatomic, nullable, copy)   id punctualist;
@property (nonatomic, nullable, copy)   id returnlessly;
@property (nonatomic, nullable, copy)   id skelder;
@property (nonatomic, nullable, copy)   id windwaywardly;
@property (nonatomic, nullable, copy)   id yuman;
@end

@interface QTUnimpeachablyClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *acerin;
@property (nonatomic, nullable, strong) NSNumber *bobadil;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *chlorophylligenous;
@property (nonatomic, nullable, strong) NSNumber *conversational;
@property (nonatomic, nullable, strong) NSNumber *demiowl;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *ectorhinal;
@property (nonatomic, nullable, strong) NSNumber *gamblesomeness;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *irrorate;
@property (nonatomic, nullable, strong) NSNumber *kindergartening;
@property (nonatomic, nullable, strong) NSNumber *lateritic;
@property (nonatomic, nullable, strong) NSNumber *mespil;
@property (nonatomic, nullable, strong) NSNumber *misconfiguration;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *planometry;
@property (nonatomic, nullable, strong) NSNumber *quiina;
@property (nonatomic, nullable, strong) NSNumber *robert;
@property (nonatomic, nullable, strong) NSNumber *rot;
@property (nonatomic, nullable, strong) NSNumber *subcinctorium;
@property (nonatomic, nullable, strong) NSNumber *tussocker;
@property (nonatomic, nullable, strong) NSNumber *ultraproud;
@property (nonatomic, nullable, strong) NSNumber *unsuggestedness;
@end

@interface QTUnstressedClass : NSObject
@property (nonatomic, nullable, copy) id alain;
@property (nonatomic, nullable, copy) id amphirhina;
@property (nonatomic, nullable, copy) id antimachinery;
@property (nonatomic, nullable, copy) id coldish;
@property (nonatomic, nullable, copy) id crantara;
@property (nonatomic, nullable, copy) id distinguishing;
@property (nonatomic, nullable, copy) id elytroposis;
@property (nonatomic, nullable, copy) id gentianwort;
@property (nonatomic, nullable, copy) id heliosis;
@property (nonatomic, nullable, copy) id instrumental;
@property (nonatomic, nullable, copy) id introinflection;
@property (nonatomic, nullable, copy) id kala;
@property (nonatomic, nullable, copy) id lincolnian;
@property (nonatomic, nullable, copy) id metad;
@property (nonatomic, nullable, copy) id sarcophilus;
@property (nonatomic, nullable, copy) id swingingly;
@property (nonatomic, nullable, copy) id unconformity;
@property (nonatomic, nullable, copy) id undecreed;
@property (nonatomic, nullable, copy) id venerable;
@property (nonatomic, nullable, copy) id vowellessness;
@end

@interface QTWrothyClass : NSObject
@property (nonatomic, nullable, copy) id aeschynanthus;
@property (nonatomic, nullable, copy) id aquiferous;
@property (nonatomic, nullable, copy) id cheapener;
@property (nonatomic, nullable, copy) id enumeration;
@property (nonatomic, nullable, copy) id ephesine;
@property (nonatomic, nullable, copy) id escadrille;
@property (nonatomic, nullable, copy) id estrous;
@property (nonatomic, nullable, copy) id interestedly;
@property (nonatomic, nullable, copy) id katakinetomer;
@property (nonatomic, nullable, copy) id mortification;
@property (nonatomic, nullable, copy) id morula;
@property (nonatomic, nullable, copy) id orthosymmetrical;
@property (nonatomic, nullable, copy) id overbark;
@property (nonatomic, nullable, copy) id politist;
@property (nonatomic, nullable, copy) id qualified;
@property (nonatomic, nullable, copy) id sphenomalar;
@property (nonatomic, nullable, copy) id throatful;
@property (nonatomic, nullable, copy) id transhumance;
@property (nonatomic, nullable, copy) id triandrian;
@property (nonatomic, nullable, copy) id unbooked;
@end

NS_ASSUME_NONNULL_END
