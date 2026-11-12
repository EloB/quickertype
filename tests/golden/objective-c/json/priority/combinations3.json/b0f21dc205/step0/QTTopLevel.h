// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTJurorClass;
@class QTLadronismClass;
@class QTLandlubberlyClass;
@class QTLupusClass;
@class QTMaslin;
@class QTMonaziteClass;
@class QTMonotheisticallyClass;
@class QTNoncontributing;
@class QTOccupationalistClass;
@class QTOutrivalClass;
@class QTPiaculumClass;
@class QTPneumocele;
@class QTPotwhiskyClass;
@class QTPrefreshmanClass;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy) NSArray<id> *juror;
@property (nonatomic, copy) NSArray<id> *kongoni;
@property (nonatomic, copy) NSArray<id> *ladronism;
@property (nonatomic, copy) NSArray<id> *landlubberly;
@property (nonatomic, copy) NSArray<id> *listener;
@property (nonatomic, copy) NSArray<id> *lupus;
@property (nonatomic, copy) NSArray<QTMaslin *> *maslin;
@property (nonatomic, copy) NSArray<id> *monazite;
@property (nonatomic, copy) NSArray<id> *monoliteral;
@property (nonatomic, copy) NSArray<id> *monotheistically;
@property (nonatomic, copy) NSArray<id> *montage;
@property (nonatomic, copy) NSArray<id> *moralness;
@property (nonatomic, copy) NSArray<QTMonaziteClass *> *mowra;
@property (nonatomic, copy) NSArray<id> *mulishly;
@property (nonatomic, copy) NSArray<id> *myoscope;
@property (nonatomic, copy) NSArray<NSArray<NSNumber *> *> *nach;
@property (nonatomic, copy) NSArray<id> *neuromastic;
@property (nonatomic, copy) NSArray<QTNoncontributing *> *noncontributing;
@property (nonatomic, copy) NSArray<id> *nonnervous;
@property (nonatomic, copy) NSArray<id> *nonvaluation;
@property (nonatomic, copy) NSArray<id> *occupationalist;
@property (nonatomic, copy) NSArray<id> *outrival;
@property (nonatomic, copy) NSArray<id> *paleographically;
@property (nonatomic, copy) NSArray<id> *pamphletwise;
@property (nonatomic, copy) NSArray<id> *pediatrics;
@property (nonatomic, copy) NSArray<NSNumber *> *perceptive;
@property (nonatomic, copy) NSArray<id> *piaculum;
@property (nonatomic, copy) NSArray<id> *piccadilly;
@property (nonatomic, copy) NSArray<id> *piffler;
@property (nonatomic, copy) NSArray<id> *pithful;
@property (nonatomic, copy) NSArray<id> *placuntitis;
@property (nonatomic, copy) NSArray<id> *plectopterous;
@property (nonatomic, copy) NSArray<QTPneumocele *> *pneumocele;
@property (nonatomic, copy) NSArray<id> *poliorcetic;
@property (nonatomic, copy) NSArray<id> *poormaster;
@property (nonatomic, copy) NSArray<id> *potwhisky;
@property (nonatomic, copy) NSArray<id> *practicalizer;
@property (nonatomic, copy) NSArray<id> *prefreshman;
@property (nonatomic, copy) NSArray<id> *prehensility;
@property (nonatomic, copy) NSArray<id> *prevoidance;
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, NSNumber *> *> *probant;
@property (nonatomic, copy) NSArray<id> *protext;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTJurorClass : NSObject
@property (nonatomic, nullable, copy) id adipsy;
@property (nonatomic, nullable, copy) id auxiliator;
@property (nonatomic, nullable, copy) id benda;
@property (nonatomic, nullable, copy) id benjamin;
@property (nonatomic, nullable, copy) id brandling;
@property (nonatomic, nullable, copy) id epicurishly;
@property (nonatomic, nullable, copy) id eremochaetous;
@property (nonatomic, nullable, copy) id marten;
@property (nonatomic, nullable, copy) id monocline;
@property (nonatomic, nullable, copy) id olea;
@property (nonatomic, nullable, copy) id palgat;
@property (nonatomic, nullable, copy) id pennyworth;
@property (nonatomic, nullable, copy) id pioury;
@property (nonatomic, nullable, copy) id pragmatistic;
@property (nonatomic, nullable, copy) id stylelessness;
@property (nonatomic, nullable, copy) id systematical;
@property (nonatomic, nullable, copy) id thready;
@property (nonatomic, nullable, copy) id uncontemporary;
@property (nonatomic, nullable, copy) id uncouched;
@property (nonatomic, nullable, copy) id uninhabitedness;
@end

@interface QTLadronismClass : NSObject
@property (nonatomic, nullable, copy) id acclaimer;
@property (nonatomic, nullable, copy) id achree;
@property (nonatomic, nullable, copy) id base;
@property (nonatomic, nullable, copy) id conundrumize;
@property (nonatomic, nullable, copy) id degerminator;
@property (nonatomic, nullable, copy) id describable;
@property (nonatomic, nullable, copy) id exasperatedly;
@property (nonatomic, nullable, copy) id heroine;
@property (nonatomic, nullable, copy) id indazin;
@property (nonatomic, nullable, copy) id luteous;
@property (nonatomic, nullable, copy) id papular;
@property (nonatomic, nullable, copy) id pritch;
@property (nonatomic, nullable, copy) id prodenia;
@property (nonatomic, nullable, copy) id seege;
@property (nonatomic, nullable, copy) id shopgirl;
@property (nonatomic, nullable, copy) id tragedietta;
@property (nonatomic, nullable, copy) id unsparse;
@property (nonatomic, nullable, copy) id uplook;
@property (nonatomic, nullable, copy) id vermiformis;
@property (nonatomic, nullable, copy) id whafabout;
@end

@interface QTLandlubberlyClass : NSObject
@property (nonatomic, nullable, copy) id acropoleis;
@property (nonatomic, nullable, copy) id aminate;
@property (nonatomic, nullable, copy) id amyraldism;
@property (nonatomic, nullable, copy) id bipenniform;
@property (nonatomic, nullable, copy) id bugre;
@property (nonatomic, nullable, copy) id calycule;
@property (nonatomic, nullable, copy) id caoutchouc;
@property (nonatomic, nullable, copy) id disprover;
@property (nonatomic, nullable, copy) id fitroot;
@property (nonatomic, nullable, copy) id fulgently;
@property (nonatomic, nullable, copy) id kickup;
@property (nonatomic, nullable, copy) id laevoversion;
@property (nonatomic, nullable, copy) id moter;
@property (nonatomic, nullable, copy) id objectivity;
@property (nonatomic, nullable, copy) id posterity;
@property (nonatomic, nullable, copy) id postnuptial;
@property (nonatomic, nullable, copy) id precedentary;
@property (nonatomic, nullable, copy) id saddling;
@property (nonatomic, nullable, copy) id subcurrent;
@property (nonatomic, nullable, copy) id unrecriminative;
@end

@interface QTLupusClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *chlorioninae;
@property (nonatomic, nullable, strong) NSNumber *corvinae;
@property (nonatomic, nullable, strong) NSNumber *crassina;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *exiguity;
@property (nonatomic, nullable, strong) NSNumber *farcist;
@property (nonatomic, nullable, strong) NSNumber *holographical;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *ichthyophagan;
@property (nonatomic, nullable, strong) NSNumber *implacable;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *outshiner;
@property (nonatomic, nullable, strong) NSNumber *overweather;
@property (nonatomic, nullable, strong) NSNumber *protonegroid;
@property (nonatomic, nullable, strong) NSNumber *shallowish;
@property (nonatomic, nullable, strong) NSNumber *snoke;
@property (nonatomic, nullable, strong) NSNumber *snout;
@property (nonatomic, nullable, strong) NSNumber *surveillance;
@property (nonatomic, nullable, strong) NSNumber *threshingtime;
@property (nonatomic, nullable, strong) NSNumber *thysanocarpus;
@property (nonatomic, nullable, strong) NSNumber *unsignificantly;
@property (nonatomic, nullable, strong) NSNumber *unsnap;
@property (nonatomic, nullable, strong) NSNumber *vendible;
@end

@interface QTMaslin : NSObject
@property (nonatomic, nullable, strong) NSNumber *alicant;
@property (nonatomic, nullable, copy)   id antiatonement;
@property (nonatomic, nullable, strong) NSNumber *anticorrosive;
@property (nonatomic, nullable, copy)   id aphidozer;
@property (nonatomic, nullable, copy)   id bakuninist;
@property (nonatomic, nullable, strong) NSNumber *be;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *chub;
@property (nonatomic, nullable, strong) NSNumber *cuprosilicon;
@property (nonatomic, nullable, strong) NSNumber *curtailedly;
@property (nonatomic, nullable, strong) NSNumber *dellenite;
@property (nonatomic, nullable, strong) NSNumber *dimitry;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id edifying;
@property (nonatomic, nullable, strong) NSNumber *ethmoiditis;
@property (nonatomic, nullable, copy)   id gastralgy;
@property (nonatomic, nullable, strong) NSNumber *goatherd;
@property (nonatomic, nullable, strong) NSNumber *hammerdress;
@property (nonatomic, nullable, copy)   id hangfire;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *lacunosity;
@property (nonatomic, nullable, copy)   id longiloquence;
@property (nonatomic, nullable, strong) NSNumber *mameliere;
@property (nonatomic, nullable, copy)   id motherless;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id noncorrodible;
@property (nonatomic, nullable, copy)   id nonsensicality;
@property (nonatomic, nullable, strong) NSNumber *oafishly;
@property (nonatomic, nullable, copy)   id pfund;
@property (nonatomic, nullable, copy)   id preadvisory;
@property (nonatomic, nullable, copy)   id retroflexed;
@property (nonatomic, nullable, strong) NSNumber *saccharulmic;
@property (nonatomic, nullable, strong) NSNumber *scowlful;
@property (nonatomic, nullable, copy)   id secluded;
@property (nonatomic, nullable, copy)   id slackage;
@property (nonatomic, nullable, strong) NSNumber *sphaeridial;
@property (nonatomic, nullable, copy)   id spondulics;
@property (nonatomic, nullable, strong) NSNumber *subsecive;
@property (nonatomic, nullable, copy)   id swellmobsman;
@property (nonatomic, nullable, strong) NSNumber *trachyglossate;
@property (nonatomic, nullable, copy)   id trialogue;
@property (nonatomic, nullable, strong) NSNumber *unassuaged;
@property (nonatomic, nullable, copy)   id ungross;
@property (nonatomic, nullable, copy)   id unjudiciously;
@end

@interface QTMonaziteClass : NSObject
@property (nonatomic, assign)         double catharticalness;
@property (nonatomic, assign)         NSInteger chirotherium;
@property (nonatomic, copy)           NSString *disdiapason;
@property (nonatomic, assign)         BOOL isHomocerc;
@property (nonatomic, nullable, copy) id nonbookish;
@end

@interface QTMonotheisticallyClass : NSObject
@property (nonatomic, nullable, copy)   id blaspheme;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, copy)   id celiosalpingectomy;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   id consummativeness;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id egestive;
@property (nonatomic, nullable, copy)   id enchylema;
@property (nonatomic, nullable, copy)   id gasconade;
@property (nonatomic, nullable, copy)   id holidayer;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id intuitionalism;
@property (nonatomic, nullable, copy)   id lophiostomate;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id nonvolition;
@property (nonatomic, nullable, copy)   id palatableness;
@property (nonatomic, nullable, copy)   id pimpery;
@property (nonatomic, nullable, copy)   id previolation;
@property (nonatomic, nullable, copy)   id reconveyance;
@property (nonatomic, nullable, copy)   id registership;
@property (nonatomic, nullable, copy)   id rhyacolite;
@property (nonatomic, nullable, copy)   id smithereens;
@property (nonatomic, nullable, copy)   id superedification;
@property (nonatomic, nullable, copy)   id trust;
@property (nonatomic, nullable, copy)   id whitestone;
@end

@interface QTNoncontributing : NSObject
@property (nonatomic, copy)           NSString *estevin;
@property (nonatomic, assign)         BOOL isSparsely;
@property (nonatomic, assign)         double jolterhead;
@property (nonatomic, assign)         NSInteger sauternes;
@property (nonatomic, nullable, copy) id unrequested;
@end

@interface QTOccupationalistClass : NSObject
@property (nonatomic, nullable, copy) id beholdable;
@property (nonatomic, nullable, copy) id brotuliform;
@property (nonatomic, nullable, copy) id chimakum;
@property (nonatomic, nullable, copy) id doodler;
@property (nonatomic, nullable, copy) id emulsin;
@property (nonatomic, nullable, copy) id fin;
@property (nonatomic, nullable, copy) id flourishing;
@property (nonatomic, nullable, copy) id flueless;
@property (nonatomic, nullable, copy) id furtively;
@property (nonatomic, nullable, copy) id gritter;
@property (nonatomic, nullable, copy) id interwish;
@property (nonatomic, nullable, copy) id monoxylic;
@property (nonatomic, nullable, copy) id myristic;
@property (nonatomic, nullable, copy) id nightwear;
@property (nonatomic, nullable, copy) id peruser;
@property (nonatomic, nullable, copy) id theoastrological;
@property (nonatomic, nullable, copy) id thumby;
@property (nonatomic, nullable, copy) id tingitid;
@property (nonatomic, nullable, copy) id trailless;
@property (nonatomic, nullable, copy) id unpocketed;
@end

@interface QTOutrivalClass : NSObject
@property (nonatomic, nullable, copy) id adroitly;
@property (nonatomic, nullable, copy) id bridehood;
@property (nonatomic, nullable, copy) id castoroides;
@property (nonatomic, nullable, copy) id czechoslovak;
@property (nonatomic, nullable, copy) id diagenesis;
@property (nonatomic, nullable, copy) id dihexahedron;
@property (nonatomic, nullable, copy) id dopester;
@property (nonatomic, nullable, copy) id eumerism;
@property (nonatomic, nullable, copy) id flyness;
@property (nonatomic, nullable, copy) id fouler;
@property (nonatomic, nullable, copy) id laudanosine;
@property (nonatomic, nullable, copy) id lingulidae;
@property (nonatomic, nullable, copy) id minutary;
@property (nonatomic, nullable, copy) id mitra;
@property (nonatomic, nullable, copy) id opisthorchiasis;
@property (nonatomic, nullable, copy) id pensively;
@property (nonatomic, nullable, copy) id pubigerous;
@property (nonatomic, nullable, copy) id rebellious;
@property (nonatomic, nullable, copy) id recodify;
@property (nonatomic, nullable, copy) id unpaced;
@end

@interface QTPiaculumClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *alada;
@property (nonatomic, nullable, strong) NSNumber *amphistomous;
@property (nonatomic, nullable, strong) NSNumber *boysenberry;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *decardinalize;
@property (nonatomic, nullable, strong) NSNumber *discouragement;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *doitrified;
@property (nonatomic, nullable, strong) NSNumber *hexaspermous;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *insinking;
@property (nonatomic, nullable, strong) NSNumber *loathfulness;
@property (nonatomic, nullable, strong) NSNumber *miasmatical;
@property (nonatomic, nullable, strong) NSNumber *neurofibril;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *phonendoscope;
@property (nonatomic, nullable, strong) NSNumber *pilferment;
@property (nonatomic, nullable, strong) NSNumber *predismissory;
@property (nonatomic, nullable, strong) NSNumber *preinscription;
@property (nonatomic, nullable, strong) NSNumber *quotative;
@property (nonatomic, nullable, strong) NSNumber *sienna;
@property (nonatomic, nullable, strong) NSNumber *thorax;
@property (nonatomic, nullable, strong) NSNumber *yachting;
@property (nonatomic, nullable, strong) NSNumber *zipper;
@end

@interface QTPneumocele : NSObject
@property (nonatomic, nullable, copy)   id carbonarism;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, copy)   id cineolic;
@property (nonatomic, nullable, copy)   id cobbly;
@property (nonatomic, nullable, copy)   id conchyliferous;
@property (nonatomic, nullable, copy)   id congregation;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, copy)   id enterotomy;
@property (nonatomic, nullable, copy)   id entophytal;
@property (nonatomic, nullable, copy)   id fewtrils;
@property (nonatomic, nullable, copy)   id herem;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, copy)   id koniga;
@property (nonatomic, nullable, copy)   id meticulosity;
@property (nonatomic, nullable, copy)   id micky;
@property (nonatomic, nullable, copy)   id mismarriage;
@property (nonatomic, nullable, copy)   id neurotrophic;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, copy)   id persuasively;
@property (nonatomic, nullable, copy)   id replaceable;
@property (nonatomic, nullable, copy)   id silex;
@property (nonatomic, nullable, copy)   id taillight;
@property (nonatomic, nullable, copy)   id unjealous;
@property (nonatomic, nullable, copy)   id visitorial;
@end

@interface QTPotwhiskyClass : NSObject
@property (nonatomic, nullable, copy) id arciform;
@property (nonatomic, nullable, copy) id cresolin;
@property (nonatomic, nullable, copy) id disheartener;
@property (nonatomic, nullable, copy) id disproportionable;
@property (nonatomic, nullable, copy) id euchorda;
@property (nonatomic, nullable, copy) id ferryway;
@property (nonatomic, nullable, copy) id filamentiferous;
@property (nonatomic, nullable, copy) id flemish;
@property (nonatomic, nullable, copy) id forgainst;
@property (nonatomic, nullable, copy) id grainering;
@property (nonatomic, nullable, copy) id irrevoluble;
@property (nonatomic, nullable, copy) id kindredship;
@property (nonatomic, nullable, copy) id pinguitudinous;
@property (nonatomic, nullable, copy) id simpletonic;
@property (nonatomic, nullable, copy) id singsong;
@property (nonatomic, nullable, copy) id submergement;
@property (nonatomic, nullable, copy) id supraoesophagal;
@property (nonatomic, nullable, copy) id thrashel;
@property (nonatomic, nullable, copy) id tyremesis;
@property (nonatomic, nullable, copy) id yoruba;
@end

@interface QTPrefreshmanClass : NSObject
@property (nonatomic, nullable, copy) id azorubine;
@property (nonatomic, nullable, copy) id choroiditis;
@property (nonatomic, nullable, copy) id coagulatory;
@property (nonatomic, nullable, copy) id cyclorama;
@property (nonatomic, nullable, copy) id dolphus;
@property (nonatomic, nullable, copy) id duckhearted;
@property (nonatomic, nullable, copy) id ficus;
@property (nonatomic, nullable, copy) id gemaric;
@property (nonatomic, nullable, copy) id jugation;
@property (nonatomic, nullable, copy) id myoliposis;
@property (nonatomic, nullable, copy) id nonnomination;
@property (nonatomic, nullable, copy) id palay;
@property (nonatomic, nullable, copy) id pentactinal;
@property (nonatomic, nullable, copy) id phaet;
@property (nonatomic, nullable, copy) id piquant;
@property (nonatomic, nullable, copy) id registration;
@property (nonatomic, nullable, copy) id remancipation;
@property (nonatomic, nullable, copy) id scutatiform;
@property (nonatomic, nullable, copy) id theodolite;
@property (nonatomic, nullable, copy) id underward;
@end

NS_ASSUME_NONNULL_END
