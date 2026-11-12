// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTAlleviateClass;
@class QTRebecca;
@class QTAmphithyron;
@class QTAnkeeClass;
@class QTAnsarieClass;
@class QTChytridiaceaeClass;
@class QTDiscordiaClass;
@class QTGryphosaurusClass;
@class QTLaviniaClass;
@class QTOskarClass;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)           NSArray<id> *abranchiata;
@property (nonatomic, copy)           NSArray<id> *academe;
@property (nonatomic, copy)           NSArray<id> *acquirable;
@property (nonatomic, copy)           NSArray<id> *aerometry;
@property (nonatomic, copy)           NSArray<id> *alexin;
@property (nonatomic, copy)           NSArray<id> *alleviate;
@property (nonatomic, copy)           NSArray<id> *amaas;
@property (nonatomic, copy)           NSArray<id> *ambassage;
@property (nonatomic, copy)           NSArray<QTAmphithyron *> *amphithyron;
@property (nonatomic, copy)           NSArray<NSString *> *andriana;
@property (nonatomic, copy)           NSArray<id> *ankee;
@property (nonatomic, copy)           NSArray<NSDictionary<NSString *, NSNumber *> *> *annihilator;
@property (nonatomic, nullable, copy) id annulose;
@property (nonatomic, copy)           NSArray<id> *ansarie;
@property (nonatomic, copy)           NSArray<id> *aphasia;
@property (nonatomic, copy)           NSArray<id> *asprawl;
@property (nonatomic, copy)           NSArray<NSNumber *> *attractive;
@property (nonatomic, copy)           NSDictionary<NSString *, NSNumber *> *barksome;
@property (nonatomic, copy)           NSArray<id> *bedesman;
@property (nonatomic, copy)           NSArray<id> *belard;
@property (nonatomic, copy)           NSArray<id> *bocking;
@property (nonatomic, copy)           NSArray<id> *brawlingly;
@property (nonatomic, copy)           NSArray<id> *brookie;
@property (nonatomic, copy)           NSArray<id> *bumboatman;
@property (nonatomic, copy)           NSArray *bystreet;
@property (nonatomic, copy)           NSArray<id> *calaverite;
@property (nonatomic, copy)           NSArray<id> *catallactic;
@property (nonatomic, copy)           NSArray<id> *cemental;
@property (nonatomic, copy)           NSArray<id> *chytridiaceae;
@property (nonatomic, copy)           NSArray<id> *discordia;
@property (nonatomic, copy)           NSArray<id> *endomyces;
@property (nonatomic, copy)           NSArray<id> *epinephelidae;
@property (nonatomic, copy)           NSArray<id> *eupatorium;
@property (nonatomic, copy)           NSArray<id> *gryphosaurus;
@property (nonatomic, assign)         BOOL isRigsmal;
@property (nonatomic, copy)           NSArray<id> *koryak;
@property (nonatomic, copy)           NSArray<id> *lavinia;
@property (nonatomic, copy)           NSArray<id> *oskar;
@property (nonatomic, copy)           NSArray<id> *rebecca;
@property (nonatomic, copy)           NSArray<id> *rhomboganoidei;
@property (nonatomic, copy)           NSArray<id> *ruellia;
@property (nonatomic, copy)           NSArray<id> *school;
@property (nonatomic, copy)           NSArray<id> *shakespearolater;
@property (nonatomic, copy)           NSArray<NSNumber *> *svan;
@property (nonatomic, copy)           NSDictionary<NSString *, NSNumber *> *wayao;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTAlleviateClass : NSObject
@property (nonatomic, nullable, copy) id apriori;
@property (nonatomic, nullable, copy) id beggarer;
@property (nonatomic, nullable, copy) id brokenheartedly;
@property (nonatomic, nullable, copy) id debilitation;
@property (nonatomic, nullable, copy) id frike;
@property (nonatomic, nullable, copy) id gastrolith;
@property (nonatomic, nullable, copy) id hulsean;
@property (nonatomic, nullable, copy) id orthocentric;
@property (nonatomic, nullable, copy) id petaly;
@property (nonatomic, nullable, copy) id probudgeting;
@property (nonatomic, nullable, copy) id reacquire;
@property (nonatomic, nullable, copy) id scow;
@property (nonatomic, nullable, copy) id shutoff;
@property (nonatomic, nullable, copy) id subcontiguous;
@property (nonatomic, nullable, copy) id suffumigate;
@property (nonatomic, nullable, copy) id transformable;
@property (nonatomic, nullable, copy) id uncoroneted;
@property (nonatomic, nullable, copy) id unparking;
@property (nonatomic, nullable, copy) id unvarnishedness;
@property (nonatomic, nullable, copy) id wherewithal;
@end

@interface QTRebecca : NSObject
@property (nonatomic, assign)         double catharticalness;
@property (nonatomic, assign)         NSInteger chirotherium;
@property (nonatomic, copy)           NSString *disdiapason;
@property (nonatomic, assign)         BOOL isHomocerc;
@property (nonatomic, nullable, copy) id nonbookish;
@end

@interface QTAmphithyron : NSObject
@property (nonatomic, nullable, strong) NSNumber *akroasis;
@property (nonatomic, nullable, strong) NSNumber *antiphonical;
@property (nonatomic, nullable, strong) NSNumber *basebred;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *conductometric;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *ensilation;
@property (nonatomic, nullable, strong) NSNumber *eyebolt;
@property (nonatomic, nullable, strong) NSNumber *fistulated;
@property (nonatomic, nullable, strong) NSNumber *heteropod;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *juniperus;
@property (nonatomic, nullable, strong) NSNumber *labyrinthically;
@property (nonatomic, nullable, strong) NSNumber *martyrization;
@property (nonatomic, nullable, strong) NSNumber *mispolicy;
@property (nonatomic, nullable, strong) NSNumber *multipara;
@property (nonatomic, nullable, strong) NSNumber *nazirite;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *possessorial;
@property (nonatomic, nullable, strong) NSNumber *shamed;
@property (nonatomic, nullable, strong) NSNumber *shelfworn;
@property (nonatomic, nullable, strong) NSNumber *stagnum;
@property (nonatomic, nullable, strong) NSNumber *those;
@property (nonatomic, nullable, strong) NSNumber *undecimal;
@end

@interface QTAnkeeClass : NSObject
@property (nonatomic, nullable, copy) id anomoean;
@property (nonatomic, nullable, copy) id barleyhood;
@property (nonatomic, nullable, copy) id befriender;
@property (nonatomic, nullable, copy) id brutishness;
@property (nonatomic, nullable, copy) id cephalalgy;
@property (nonatomic, nullable, copy) id cirurgian;
@property (nonatomic, nullable, copy) id conventionally;
@property (nonatomic, nullable, copy) id jackshay;
@property (nonatomic, nullable, copy) id milammeter;
@property (nonatomic, nullable, copy) id naja;
@property (nonatomic, nullable, copy) id ombrological;
@property (nonatomic, nullable, copy) id phonasthenia;
@property (nonatomic, nullable, copy) id retrievableness;
@property (nonatomic, nullable, copy) id snakily;
@property (nonatomic, nullable, copy) id swot;
@property (nonatomic, nullable, copy) id tartlet;
@property (nonatomic, nullable, copy) id thiofuran;
@property (nonatomic, nullable, copy) id tracheophone;
@property (nonatomic, nullable, copy) id tuglike;
@property (nonatomic, nullable, copy) id unscratchingly;
@end

@interface QTAnsarieClass : NSObject
@property (nonatomic, nullable, copy) id accension;
@property (nonatomic, nullable, copy) id alida;
@property (nonatomic, nullable, copy) id asteria;
@property (nonatomic, nullable, copy) id beriberic;
@property (nonatomic, nullable, copy) id edgebone;
@property (nonatomic, nullable, copy) id gastrodialysis;
@property (nonatomic, nullable, copy) id geographic;
@property (nonatomic, nullable, copy) id ictonyx;
@property (nonatomic, nullable, copy) id metrocele;
@property (nonatomic, nullable, copy) id misgraft;
@property (nonatomic, nullable, copy) id monteith;
@property (nonatomic, nullable, copy) id notcher;
@property (nonatomic, nullable, copy) id prorestriction;
@property (nonatomic, nullable, copy) id ramist;
@property (nonatomic, nullable, copy) id throatlet;
@property (nonatomic, nullable, copy) id unfair;
@property (nonatomic, nullable, copy) id unsynonymous;
@property (nonatomic, nullable, copy) id water;
@property (nonatomic, nullable, copy) id zestfully;
@property (nonatomic, nullable, copy) id zincic;
@end

@interface QTChytridiaceaeClass : NSObject
@property (nonatomic, nullable, copy) id batidaceae;
@property (nonatomic, nullable, copy) id brechites;
@property (nonatomic, nullable, copy) id codespairer;
@property (nonatomic, nullable, copy) id emery;
@property (nonatomic, nullable, copy) id enervative;
@property (nonatomic, nullable, copy) id excriminate;
@property (nonatomic, nullable, copy) id goshenite;
@property (nonatomic, nullable, copy) id grime;
@property (nonatomic, nullable, copy) id gritten;
@property (nonatomic, nullable, copy) id hectorly;
@property (nonatomic, nullable, copy) id intermediation;
@property (nonatomic, nullable, copy) id meeterly;
@property (nonatomic, nullable, copy) id narraganset;
@property (nonatomic, nullable, copy) id onymatic;
@property (nonatomic, nullable, copy) id paddlecock;
@property (nonatomic, nullable, copy) id thana;
@property (nonatomic, nullable, copy) id thornily;
@property (nonatomic, nullable, copy) id uckia;
@property (nonatomic, nullable, copy) id unmettle;
@property (nonatomic, nullable, copy) id vorticellid;
@end

@interface QTDiscordiaClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *altaic;
@property (nonatomic, nullable, strong) NSNumber *amoristic;
@property (nonatomic, nullable, strong) NSNumber *blennophthalmia;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *disciplinability;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *goofer;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *laryngograph;
@property (nonatomic, nullable, strong) NSNumber *leucitis;
@property (nonatomic, nullable, strong) NSNumber *lymphocyst;
@property (nonatomic, nullable, strong) NSNumber *microcosmology;
@property (nonatomic, nullable, strong) NSNumber *nauseation;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *patarin;
@property (nonatomic, nullable, strong) NSNumber *preliberal;
@property (nonatomic, nullable, strong) NSNumber *prettifier;
@property (nonatomic, nullable, strong) NSNumber *rangework;
@property (nonatomic, nullable, strong) NSNumber *redient;
@property (nonatomic, nullable, strong) NSNumber *subfusiform;
@property (nonatomic, nullable, strong) NSNumber *suicidical;
@property (nonatomic, nullable, strong) NSNumber *swow;
@property (nonatomic, nullable, strong) NSNumber *wastrel;
@property (nonatomic, nullable, strong) NSNumber *wingle;
@end

@interface QTGryphosaurusClass : NSObject
@property (nonatomic, nullable, copy) id amissibility;
@property (nonatomic, nullable, copy) id burushaski;
@property (nonatomic, nullable, copy) id citronin;
@property (nonatomic, nullable, copy) id coplaintiff;
@property (nonatomic, nullable, copy) id disquisitionary;
@property (nonatomic, nullable, copy) id enoplan;
@property (nonatomic, nullable, copy) id faintness;
@property (nonatomic, nullable, copy) id hebetomy;
@property (nonatomic, nullable, copy) id islandry;
@property (nonatomic, nullable, copy) id lameduck;
@property (nonatomic, nullable, copy) id overbattle;
@property (nonatomic, nullable, copy) id overinterested;
@property (nonatomic, nullable, copy) id phrenologic;
@property (nonatomic, nullable, copy) id rainband;
@property (nonatomic, nullable, copy) id shiningly;
@property (nonatomic, nullable, copy) id stamineous;
@property (nonatomic, nullable, copy) id subscapularis;
@property (nonatomic, nullable, copy) id tahami;
@property (nonatomic, nullable, copy) id undaubed;
@property (nonatomic, nullable, copy) id underntime;
@end

@interface QTLaviniaClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *agitable;
@property (nonatomic, nullable, strong) NSNumber *asininity;
@property (nonatomic, nullable, strong) NSNumber *benefiter;
@property (nonatomic, nullable, strong) NSNumber *bronzelike;
@property (nonatomic, nullable, strong) NSNumber *catharticalness;
@property (nonatomic, nullable, strong) NSNumber *chirotherium;
@property (nonatomic, nullable, strong) NSNumber *cholesteatomatous;
@property (nonatomic, nullable, strong) NSNumber *deprivement;
@property (nonatomic, nullable, copy)   NSString *disdiapason;
@property (nonatomic, nullable, strong) NSNumber *flippantness;
@property (nonatomic, nullable, strong) NSNumber *fogproof;
@property (nonatomic, nullable, strong) NSNumber *homocerc;
@property (nonatomic, nullable, strong) NSNumber *merrymeeting;
@property (nonatomic, nullable, copy)   id nonbookish;
@property (nonatomic, nullable, strong) NSNumber *overcareful;
@property (nonatomic, nullable, strong) NSNumber *panaris;
@property (nonatomic, nullable, strong) NSNumber *preacceptance;
@property (nonatomic, nullable, strong) NSNumber *quinoxaline;
@property (nonatomic, nullable, strong) NSNumber *sig;
@property (nonatomic, nullable, strong) NSNumber *superconfusion;
@property (nonatomic, nullable, strong) NSNumber *tacana;
@property (nonatomic, nullable, strong) NSNumber *tillotter;
@property (nonatomic, nullable, strong) NSNumber *tranquillize;
@property (nonatomic, nullable, strong) NSNumber *unquestionable;
@property (nonatomic, nullable, strong) NSNumber *uproute;
@end

@interface QTOskarClass : NSObject
@property (nonatomic, nullable, copy) id acrobates;
@property (nonatomic, nullable, copy) id beanshooter;
@property (nonatomic, nullable, copy) id bearhound;
@property (nonatomic, nullable, copy) id cayuga;
@property (nonatomic, nullable, copy) id guarneri;
@property (nonatomic, nullable, copy) id hypochondriacism;
@property (nonatomic, nullable, copy) id indication;
@property (nonatomic, nullable, copy) id jaculative;
@property (nonatomic, nullable, copy) id nagana;
@property (nonatomic, nullable, copy) id netherlandish;
@property (nonatomic, nullable, copy) id noctivagous;
@property (nonatomic, nullable, copy) id nonphysiological;
@property (nonatomic, nullable, copy) id praxis;
@property (nonatomic, nullable, copy) id provision;
@property (nonatomic, nullable, copy) id subterhuman;
@property (nonatomic, nullable, copy) id sunlit;
@property (nonatomic, nullable, copy) id syncraniate;
@property (nonatomic, nullable, copy) id teachment;
@property (nonatomic, nullable, copy) id unmutinous;
@property (nonatomic, nullable, copy) id unstoppable;
@end

NS_ASSUME_NONNULL_END
