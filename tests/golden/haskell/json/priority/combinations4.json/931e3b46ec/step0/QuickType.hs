{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , PulpitismClass (..)
    , PyodermiaClass (..)
    , QuebrachineClass (..)
    , Reimagine (..)
    , Ressaut (..)
    , RewriteClass (..)
    , SantirClass (..)
    , SaxtenClass (..)
    , Scatty (..)
    , SisteringClass (..)
    , Staghunting (..)
    , StrenuosityClass (..)
    , TruantcyClass (..)
    , UnimpeachablyClass (..)
    , UnstressedClass (..)
    , WrothyClass (..)
    , Protrusive (..)
    , PulpitismElement (..)
    , PyodermiaElement (..)
    , QuebrachineElement (..)
    , Querier (..)
    , Rebarbative (..)
    , Retrocervical (..)
    , Revert (..)
    , RewriteElement (..)
    , Saccoderm (..)
    , SantirElement (..)
    , Saprophilous (..)
    , SaxtenElement (..)
    , Scoffer (..)
    , Scrampum (..)
    , Serpentinic (..)
    , Shadowable (..)
    , SisteringElement (..)
    , Stagmometer (..)
    , Stimulability (..)
    , Strangleable (..)
    , StrenuosityElement (..)
    , Tabaxir (..)
    , Talpiform (..)
    , Thwack (..)
    , Tortricine (..)
    , TruantcyElement (..)
    , Unbeginning (..)
    , Undesirability (..)
    , Unerasing (..)
    , Unguentarium (..)
    , UnimpeachablyElement (..)
    , Unmortgaged (..)
    , Unobstructed (..)
    , Unreceptivity (..)
    , Unsatisfactoriness (..)
    , UnstressedElement (..)
    , Untasked (..)
    , Unvarying (..)
    , Vehemently (..)
    , Whitepot (..)
    , WrothyElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { protrusiveQuickType :: [Protrusive]
    , pulpitismQuickType :: [PulpitismElement]
    , pyodermiaQuickType :: [PyodermiaElement]
    , quebrachineQuickType :: [QuebrachineElement]
    , querierQuickType :: [Querier]
    , rebarbativeQuickType :: [Rebarbative]
    , reimagineQuickType :: [Reimagine]
    , ressautQuickType :: Ressaut
    , retrocervicalQuickType :: [Retrocervical]
    , revertQuickType :: [Revert]
    , rewriteQuickType :: [RewriteElement]
    , saccodermQuickType :: [Saccoderm]
    , santirQuickType :: [SantirElement]
    , saprophilousQuickType :: [Saprophilous]
    , saxtenQuickType :: [SaxtenElement]
    , scattyQuickType :: [(Maybe Scatty)]
    , scofferQuickType :: [Scoffer]
    , scrampumQuickType :: [Scrampum]
    , semanticQuickType :: Double
    , serpentinicQuickType :: [Serpentinic]
    , shadowableQuickType :: [Shadowable]
    , sisteringQuickType :: [SisteringElement]
    , staghuntingQuickType :: [Staghunting]
    , stagmometerQuickType :: [Stagmometer]
    , stimulabilityQuickType :: [Stimulability]
    , strangleableQuickType :: [Strangleable]
    , strenuosityQuickType :: [StrenuosityElement]
    , tabaxirQuickType :: [Tabaxir]
    , talpiformQuickType :: [Talpiform]
    , thwackQuickType :: [Thwack]
    , toQuickType :: [(Maybe Double)]
    , tortricineQuickType :: [Tortricine]
    , truantcyQuickType :: [TruantcyElement]
    , turgesceQuickType :: [Text]
    , unbeginningQuickType :: [Unbeginning]
    , underdungedQuickType :: [Double]
    , undesirabilityQuickType :: [Undesirability]
    , unerasingQuickType :: [Unerasing]
    , unguentariumQuickType :: [Unguentarium]
    , unimpeachablyQuickType :: [UnimpeachablyElement]
    , unmortgagedQuickType :: [Unmortgaged]
    , unobstructedQuickType :: [Unobstructed]
    , unreceptivityQuickType :: [Unreceptivity]
    , unsatisfactorinessQuickType :: [Unsatisfactoriness]
    , unsecurityQuickType :: [Int]
    , unstressedQuickType :: [UnstressedElement]
    , untaskedQuickType :: [Untasked]
    , unvaryingQuickType :: [Unvarying]
    , vehementlyQuickType :: [Vehemently]
    , warriorshipQuickType :: HashMap Text Bool
    , whitepotQuickType :: [Whitepot]
    , wrothyQuickType :: [WrothyElement]
    } deriving (Show)

data Protrusive
    = DoubleInProtrusive Double
    | UnionArrayInProtrusive ([(Maybe Int)])
    deriving (Show)

data PulpitismElement
    = DoubleInPulpitismElement Double
    | IntegerArrayInPulpitismElement ([Int])
    | PulpitismClassInPulpitismElement PulpitismClass
    deriving (Show)

data PulpitismClass = PulpitismClass
    { abnetPulpitismClass :: Maybe Text
    , buckhornPulpitismClass :: Maybe Text
    , calciformPulpitismClass :: Maybe Text
    , chelophorePulpitismClass :: Maybe Text
    , cogitationPulpitismClass :: Maybe Text
    , decreeablePulpitismClass :: Maybe Text
    , despicablePulpitismClass :: Maybe Text
    , isodiazoPulpitismClass :: Maybe Text
    , jadedlyPulpitismClass :: Maybe Text
    , leptochloritePulpitismClass :: Maybe Text
    , nurslingPulpitismClass :: Maybe Text
    , palamedeanPulpitismClass :: Maybe Text
    , photoheliographPulpitismClass :: Maybe Text
    , pipewoodPulpitismClass :: Maybe Text
    , roberdPulpitismClass :: Maybe Text
    , statablePulpitismClass :: Maybe Text
    , superassumePulpitismClass :: Maybe Text
    , syllabePulpitismClass :: Maybe Text
    , toughheadPulpitismClass :: Maybe Text
    , underburnPulpitismClass :: Maybe Text
    } deriving (Show)

data PyodermiaElement
    = IntegerInPyodermiaElement Int
    | PyodermiaClassInPyodermiaElement PyodermiaClass
    deriving (Show)

data PyodermiaClass = PyodermiaClass
    { aphoristicallyPyodermiaClass :: Maybe Text
    , apophyllousPyodermiaClass :: Maybe Text
    , cognizePyodermiaClass :: Maybe Text
    , dermonosologyPyodermiaClass :: Maybe Text
    , gyppoPyodermiaClass :: Maybe Text
    , itherPyodermiaClass :: Maybe Text
    , juglandaceousPyodermiaClass :: Maybe Text
    , lithoPyodermiaClass :: Maybe Text
    , macropterousPyodermiaClass :: Maybe Text
    , photographerPyodermiaClass :: Maybe Text
    , romancingPyodermiaClass :: Maybe Text
    , rumnessPyodermiaClass :: Maybe Text
    , somniloquistPyodermiaClass :: Maybe Text
    , stressfullyPyodermiaClass :: Maybe Text
    , tacticallyPyodermiaClass :: Maybe Text
    , tracheophonyPyodermiaClass :: Maybe Text
    , unappositelyPyodermiaClass :: Maybe Text
    , unclothedlyPyodermiaClass :: Maybe Text
    , unimpliedPyodermiaClass :: Maybe Text
    , unsyncopatedPyodermiaClass :: Maybe Text
    } deriving (Show)

data QuebrachineElement
    = BoolInQuebrachineElement Bool
    | NullInQuebrachineElement
    | QuebrachineClassInQuebrachineElement QuebrachineClass
    deriving (Show)

data QuebrachineClass = QuebrachineClass
    { catharticalnessQuebrachineClass :: Double
    , chirotheriumQuebrachineClass :: Int
    , disdiapasonQuebrachineClass :: Text
    , homocercQuebrachineClass :: Bool
    , nonbookishQuebrachineClass :: Maybe Text
    } deriving (Show)

data Querier
    = BoolInQuerier Bool
    | IntegerMapInQuerier (HashMap Text Int)
    deriving (Show)

data Rebarbative
    = BoolInRebarbative Bool
    | DoubleInRebarbative Double
    | IntegerArrayInRebarbative ([Int])
    deriving (Show)

data Reimagine = Reimagine
    { adducibleReimagine :: Maybe (Maybe Text)
    , anabolinReimagine :: Maybe (Maybe Text)
    , brainyReimagine :: Maybe (Maybe Text)
    , catharticalnessReimagine :: Maybe Double
    , chirotheriumReimagine :: Maybe Int
    , chrysamineReimagine :: Maybe (Maybe Text)
    , disdiapasonReimagine :: Maybe Text
    , fluxweedReimagine :: Maybe (Maybe Text)
    , glaucineReimagine :: Maybe (Maybe Text)
    , grobianismReimagine :: Maybe (Maybe Text)
    , hermoReimagine :: Maybe (Maybe Text)
    , hieroglyphistReimagine :: Maybe (Maybe Text)
    , homocercReimagine :: Maybe Bool
    , icteroidReimagine :: Maybe (Maybe Text)
    , immortalReimagine :: Maybe (Maybe Text)
    , impetulantReimagine :: Maybe (Maybe Text)
    , irrigateReimagine :: Maybe (Maybe Text)
    , myxedemaReimagine :: Maybe (Maybe Text)
    , nonbookishReimagine :: Maybe (Maybe Text)
    , onyxReimagine :: Maybe (Maybe Text)
    , repasserReimagine :: Maybe (Maybe Text)
    , septomarginalReimagine :: Maybe (Maybe Text)
    , subdieReimagine :: Maybe (Maybe Text)
    , tibiometatarsalReimagine :: Maybe (Maybe Text)
    , waltzlikeReimagine :: Maybe (Maybe Text)
    } deriving (Show)

data Ressaut = Ressaut
    { apperceptiveRessaut :: Text
    , cuttooRessaut :: Text
    , douserRessaut :: Text
    , drinkproofRessaut :: Text
    , forementionedRessaut :: Text
    , freesiaRessaut :: Text
    , genevieveRessaut :: Text
    , hyperdiabolicalRessaut :: Text
    , hypoconeRessaut :: Text
    , irreverentiallyRessaut :: Text
    , jumartRessaut :: Text
    , mimosaceaeRessaut :: Text
    , mollicrushRessaut :: Text
    , nedderRessaut :: Text
    , retinasphaltRessaut :: Text
    , soughRessaut :: Text
    , steadingRessaut :: Text
    , theopaschitismRessaut :: Text
    , undurablenessRessaut :: Text
    , unmingleableRessaut :: Text
    } deriving (Show)

data Retrocervical
    = IntegerInRetrocervical Int
    | UnionArrayInRetrocervical ([(Maybe Int)])
    deriving (Show)

data Revert
    = BoolInRevert Bool
    | StringInRevert Text
    deriving (Show)

data RewriteElement
    = DoubleInRewriteElement Double
    | NullArrayInRewriteElement ([(Maybe Text)])
    | RewriteClassInRewriteElement RewriteClass
    deriving (Show)

data RewriteClass = RewriteClass
    { accountancyRewriteClass :: Maybe Text
    , cacotrophicRewriteClass :: Maybe Text
    , contestRewriteClass :: Maybe Text
    , couthilyRewriteClass :: Maybe Text
    , falculateRewriteClass :: Maybe Text
    , foreseizeRewriteClass :: Maybe Text
    , hyadesRewriteClass :: Maybe Text
    , lemnadRewriteClass :: Maybe Text
    , monotheisticallyRewriteClass :: Maybe Text
    , nonflyingRewriteClass :: Maybe Text
    , ptenoglossaRewriteClass :: Maybe Text
    , repatchRewriteClass :: Maybe Text
    , rodmanRewriteClass :: Maybe Text
    , strungRewriteClass :: Maybe Text
    , titmalRewriteClass :: Maybe Text
    , twalpennyworthRewriteClass :: Maybe Text
    , unblamableRewriteClass :: Maybe Text
    , verticalRewriteClass :: Maybe Text
    , whiggificationRewriteClass :: Maybe Text
    , yardmanRewriteClass :: Maybe Text
    } deriving (Show)

data Saccoderm
    = IntegerArrayInSaccoderm ([Int])
    | NullInSaccoderm
    | StringInSaccoderm Text
    deriving (Show)

data SantirElement
    = DoubleInSantirElement Double
    | SantirClassInSantirElement SantirClass
    deriving (Show)

data SantirClass = SantirClass
    { admiredlySantirClass :: Maybe Text
    , demicaponierSantirClass :: Maybe Text
    , epitympanicSantirClass :: Maybe Text
    , investitorSantirClass :: Maybe Text
    , lupiformSantirClass :: Maybe Text
    , monoflagellateSantirClass :: Maybe Text
    , paleoethnicSantirClass :: Maybe Text
    , prediscountableSantirClass :: Maybe Text
    , rhetoricalsSantirClass :: Maybe Text
    , roomthSantirClass :: Maybe Text
    , saccharoseSantirClass :: Maybe Text
    , septonasalSantirClass :: Maybe Text
    , serpenticideSantirClass :: Maybe Text
    , setariousSantirClass :: Maybe Text
    , spaeworkSantirClass :: Maybe Text
    , styliteSantirClass :: Maybe Text
    , suessionesSantirClass :: Maybe Text
    , timelilySantirClass :: Maybe Text
    , unprofanedSantirClass :: Maybe Text
    , vorticularSantirClass :: Maybe Text
    } deriving (Show)

data Saprophilous
    = IntegerMapInSaprophilous (HashMap Text Int)
    | NullInSaprophilous
    | StringInSaprophilous Text
    deriving (Show)

data SaxtenElement
    = SaxtenClassInSaxtenElement SaxtenClass
    | StringInSaxtenElement Text
    deriving (Show)

data SaxtenClass = SaxtenClass
    { algarrobillaSaxtenClass :: Maybe (Maybe Text)
    , bowgraceSaxtenClass :: Maybe (Maybe Text)
    , catharticalnessSaxtenClass :: Maybe Double
    , centauridSaxtenClass :: Maybe (Maybe Text)
    , chirotheriumSaxtenClass :: Maybe Int
    , disdiapasonSaxtenClass :: Maybe Text
    , flixSaxtenClass :: Maybe (Maybe Text)
    , germanelySaxtenClass :: Maybe (Maybe Text)
    , homocercSaxtenClass :: Maybe Bool
    , inhumeSaxtenClass :: Maybe (Maybe Text)
    , lepidoteSaxtenClass :: Maybe (Maybe Text)
    , megalochirousSaxtenClass :: Maybe (Maybe Text)
    , ninepennySaxtenClass :: Maybe (Maybe Text)
    , nonbookishSaxtenClass :: Maybe (Maybe Text)
    , nondeistSaxtenClass :: Maybe (Maybe Text)
    , nymphaeaceousSaxtenClass :: Maybe (Maybe Text)
    , parietofrontalSaxtenClass :: Maybe (Maybe Text)
    , sancyiteSaxtenClass :: Maybe (Maybe Text)
    , subjectivistSaxtenClass :: Maybe (Maybe Text)
    , tibiadSaxtenClass :: Maybe (Maybe Text)
    , transonicSaxtenClass :: Maybe (Maybe Text)
    , tripetalousSaxtenClass :: Maybe (Maybe Text)
    , trunchmanSaxtenClass :: Maybe (Maybe Text)
    , urgerSaxtenClass :: Maybe (Maybe Text)
    , withdrawnnessSaxtenClass :: Maybe (Maybe Text)
    } deriving (Show)

data Scatty = Scatty
    { aeriferousScatty :: Maybe Text
    , anticalScatty :: Maybe Text
    , antighostismScatty :: Maybe Text
    , arcanumScatty :: Maybe Text
    , autotrophyScatty :: Maybe Text
    , baronialScatty :: Maybe Text
    , caffeineScatty :: Maybe Text
    , gorgoniaceanScatty :: Maybe Text
    , heroicalScatty :: Maybe Text
    , hydropicalScatty :: Maybe Text
    , mechanologyScatty :: Maybe Text
    , musicopoeticScatty :: Maybe Text
    , officialityScatty :: Maybe Text
    , oftentimesScatty :: Maybe Text
    , ophthalmotonometerScatty :: Maybe Text
    , reflectivelyScatty :: Maybe Text
    , springerScatty :: Maybe Text
    , tabascoScatty :: Maybe Text
    , teleianthousScatty :: Maybe Text
    , uncombatedScatty :: Maybe Text
    } deriving (Show)

data Scoffer
    = IntegerMapInScoffer (HashMap Text Int)
    | NullArrayInScoffer ([(Maybe Text)])
    | NullInScoffer
    deriving (Show)

data Scrampum
    = BoolInScrampum Bool
    | IntegerArrayInScrampum ([Int])
    | NullInScrampum
    deriving (Show)

data Serpentinic
    = DoubleInSerpentinic Double
    | IntegerArrayInSerpentinic ([Int])
    deriving (Show)

data Shadowable
    = BoolInShadowable Bool
    | UnionArrayInShadowable ([(Maybe Int)])
    deriving (Show)

data SisteringElement
    = IntegerInSisteringElement Int
    | NullArrayInSisteringElement ([(Maybe Text)])
    | SisteringClassInSisteringElement SisteringClass
    deriving (Show)

data SisteringClass = SisteringClass
    { amphicarpicSisteringClass :: Maybe Text
    , chiantiSisteringClass :: Maybe Text
    , frigorificSisteringClass :: Maybe Text
    , haplomiSisteringClass :: Maybe Text
    , hyperkinesisSisteringClass :: Maybe Text
    , laudableSisteringClass :: Maybe Text
    , madwomanSisteringClass :: Maybe Text
    , maimedlySisteringClass :: Maybe Text
    , micropterygidaeSisteringClass :: Maybe Text
    , microrhabdusSisteringClass :: Maybe Text
    , nondenseSisteringClass :: Maybe Text
    , phlebemphraxisSisteringClass :: Maybe Text
    , redsearSisteringClass :: Maybe Text
    , schismaticalSisteringClass :: Maybe Text
    , tartrylSisteringClass :: Maybe Text
    , unabhorredSisteringClass :: Maybe Text
    , undeliberatenessSisteringClass :: Maybe Text
    , unmixableSisteringClass :: Maybe Text
    , untrucklingSisteringClass :: Maybe Text
    , vinealSisteringClass :: Maybe Text
    } deriving (Show)

data Staghunting = Staghunting
    { calorimetricStaghunting :: Maybe Int
    , canidStaghunting :: Maybe Int
    , catharticalnessStaghunting :: Maybe Double
    , chirotheriumStaghunting :: Maybe Int
    , disdiapasonStaghunting :: Maybe Text
    , ditriglyphicStaghunting :: Maybe Int
    , floriferousnessStaghunting :: Maybe Int
    , gamelikeStaghunting :: Maybe Int
    , grigStaghunting :: Maybe Int
    , homocercStaghunting :: Maybe Bool
    , interloanStaghunting :: Maybe Int
    , lithotomyStaghunting :: Maybe Int
    , loricStaghunting :: Maybe Int
    , membranocoriaceousStaghunting :: Maybe Int
    , membranogenicStaghunting :: Maybe Int
    , nonbookishStaghunting :: Maybe (Maybe Text)
    , overtrumpStaghunting :: Maybe Int
    , scotinoStaghunting :: Maybe Int
    , seasonableStaghunting :: Maybe Int
    , sephenStaghunting :: Maybe Int
    , stigmarioidStaghunting :: Maybe Int
    , tiredStaghunting :: Maybe Int
    , trifidStaghunting :: Maybe Int
    , undefeatedlyStaghunting :: Maybe Int
    , ungirlishStaghunting :: Maybe Int
    } deriving (Show)

data Stagmometer
    = StringInStagmometer Text
    | UnionArrayInStagmometer ([(Maybe Int)])
    deriving (Show)

data Stimulability
    = BoolInStimulability Bool
    | IntegerInStimulability Int
    | IntegerMapInStimulability (HashMap Text Int)
    deriving (Show)

data Strangleable
    = DoubleInStrangleable Double
    | NullArrayInStrangleable ([(Maybe Text)])
    deriving (Show)

data StrenuosityElement
    = NullArrayInStrenuosityElement ([(Maybe Text)])
    | StrenuosityClassInStrenuosityElement StrenuosityClass
    deriving (Show)

data StrenuosityClass = StrenuosityClass
    { blissStrenuosityClass :: Maybe Int
    , buccateStrenuosityClass :: Maybe Int
    , bulletproofStrenuosityClass :: Maybe Int
    , catharticalnessStrenuosityClass :: Maybe Double
    , chirotheriumStrenuosityClass :: Maybe Int
    , crumblingnessStrenuosityClass :: Maybe Int
    , disdiapasonStrenuosityClass :: Maybe Text
    , engagedlyStrenuosityClass :: Maybe Int
    , fightableStrenuosityClass :: Maybe Int
    , hoarinessStrenuosityClass :: Maybe Int
    , homocercStrenuosityClass :: Maybe Bool
    , hypopodiumStrenuosityClass :: Maybe Int
    , luxuristStrenuosityClass :: Maybe Int
    , mechanicianStrenuosityClass :: Maybe Int
    , nonbookishStrenuosityClass :: Maybe (Maybe Text)
    , onopordonStrenuosityClass :: Maybe Int
    , podgilyStrenuosityClass :: Maybe Int
    , reformablenessStrenuosityClass :: Maybe Int
    , scatterbrainsStrenuosityClass :: Maybe Int
    , seminuriaStrenuosityClass :: Maybe Int
    , sodomiteStrenuosityClass :: Maybe Int
    , trampStrenuosityClass :: Maybe Int
    , unduenessStrenuosityClass :: Maybe Int
    , worthilyStrenuosityClass :: Maybe Int
    , yankeeistStrenuosityClass :: Maybe Int
    } deriving (Show)

data Tabaxir
    = BoolInTabaxir Bool
    | DoubleInTabaxir Double
    deriving (Show)

data Talpiform
    = DoubleInTalpiform Double
    | NullInTalpiform
    | QuebrachineClassInTalpiform QuebrachineClass
    deriving (Show)

data Thwack
    = BoolInThwack Bool
    | DoubleInThwack Double
    | QuebrachineClassInThwack QuebrachineClass
    deriving (Show)

data Tortricine
    = QuebrachineClassInTortricine QuebrachineClass
    | UnionArrayInTortricine ([(Maybe Int)])
    deriving (Show)

data TruantcyElement
    = BoolInTruantcyElement Bool
    | TruantcyClassInTruantcyElement TruantcyClass
    deriving (Show)

data TruantcyClass = TruantcyClass
    { alfionaTruantcyClass :: Maybe (Maybe Text)
    , ascaridiasisTruantcyClass :: Maybe (Maybe Text)
    , bungeyTruantcyClass :: Maybe (Maybe Text)
    , catharticalnessTruantcyClass :: Maybe Double
    , ceroxyleTruantcyClass :: Maybe (Maybe Text)
    , chirotheriumTruantcyClass :: Maybe Int
    , chorologyTruantcyClass :: Maybe (Maybe Text)
    , disdiapasonTruantcyClass :: Maybe Text
    , enmarbleTruantcyClass :: Maybe (Maybe Text)
    , epeiraTruantcyClass :: Maybe (Maybe Text)
    , eurylaimiTruantcyClass :: Maybe (Maybe Text)
    , germinationTruantcyClass :: Maybe (Maybe Text)
    , hallelujahTruantcyClass :: Maybe (Maybe Text)
    , homocercTruantcyClass :: Maybe Bool
    , levTruantcyClass :: Maybe (Maybe Text)
    , mouthingTruantcyClass :: Maybe (Maybe Text)
    , nonbookishTruantcyClass :: Maybe (Maybe Text)
    , phillilooTruantcyClass :: Maybe (Maybe Text)
    , planetalTruantcyClass :: Maybe (Maybe Text)
    , poneyTruantcyClass :: Maybe (Maybe Text)
    , punctualistTruantcyClass :: Maybe (Maybe Text)
    , returnlesslyTruantcyClass :: Maybe (Maybe Text)
    , skelderTruantcyClass :: Maybe (Maybe Text)
    , windwaywardlyTruantcyClass :: Maybe (Maybe Text)
    , yumanTruantcyClass :: Maybe (Maybe Text)
    } deriving (Show)

data Unbeginning
    = IntegerMapInUnbeginning (HashMap Text Int)
    | NullArrayInUnbeginning ([(Maybe Text)])
    | StringInUnbeginning Text
    deriving (Show)

data Undesirability
    = IntegerArrayInUndesirability ([Int])
    | IntegerMapInUndesirability (HashMap Text Int)
    | StringInUndesirability Text
    deriving (Show)

data Unerasing
    = IntegerInUnerasing Int
    | IntegerMapInUnerasing (HashMap Text Int)
    | NullArrayInUnerasing ([(Maybe Text)])
    deriving (Show)

data Unguentarium
    = IntegerInUnguentarium Int
    | NullArrayInUnguentarium ([(Maybe Text)])
    | NullInUnguentarium
    deriving (Show)

data UnimpeachablyElement
    = BoolInUnimpeachablyElement Bool
    | UnimpeachablyClassInUnimpeachablyElement UnimpeachablyClass
    deriving (Show)

data UnimpeachablyClass = UnimpeachablyClass
    { acerinUnimpeachablyClass :: Maybe Int
    , bobadilUnimpeachablyClass :: Maybe Int
    , catharticalnessUnimpeachablyClass :: Maybe Double
    , chirotheriumUnimpeachablyClass :: Maybe Int
    , chlorophylligenousUnimpeachablyClass :: Maybe Int
    , conversationalUnimpeachablyClass :: Maybe Int
    , demiowlUnimpeachablyClass :: Maybe Int
    , disdiapasonUnimpeachablyClass :: Maybe Text
    , ectorhinalUnimpeachablyClass :: Maybe Int
    , gamblesomenessUnimpeachablyClass :: Maybe Int
    , homocercUnimpeachablyClass :: Maybe Bool
    , irrorateUnimpeachablyClass :: Maybe Int
    , kindergarteningUnimpeachablyClass :: Maybe Int
    , lateriticUnimpeachablyClass :: Maybe Int
    , mespilUnimpeachablyClass :: Maybe Int
    , misconfigurationUnimpeachablyClass :: Maybe Int
    , nonbookishUnimpeachablyClass :: Maybe (Maybe Text)
    , planometryUnimpeachablyClass :: Maybe Int
    , quiinaUnimpeachablyClass :: Maybe Int
    , robertUnimpeachablyClass :: Maybe Int
    , rotUnimpeachablyClass :: Maybe Int
    , subcinctoriumUnimpeachablyClass :: Maybe Int
    , tussockerUnimpeachablyClass :: Maybe Int
    , ultraproudUnimpeachablyClass :: Maybe Int
    , unsuggestednessUnimpeachablyClass :: Maybe Int
    } deriving (Show)

data Unmortgaged
    = DoubleInUnmortgaged Double
    | IntegerMapInUnmortgaged (HashMap Text Int)
    | NullInUnmortgaged
    deriving (Show)

data Unobstructed
    = IntegerInUnobstructed Int
    | NullInUnobstructed
    | QuebrachineClassInUnobstructed QuebrachineClass
    deriving (Show)

data Unreceptivity
    = IntegerInUnreceptivity Int
    | NullArrayInUnreceptivity ([(Maybe Text)])
    | StringInUnreceptivity Text
    deriving (Show)

data Unsatisfactoriness
    = BoolInUnsatisfactoriness Bool
    | IntegerArrayInUnsatisfactoriness ([Int])
    | IntegerInUnsatisfactoriness Int
    deriving (Show)

data UnstressedElement
    = BoolInUnstressedElement Bool
    | StringInUnstressedElement Text
    | UnstressedClassInUnstressedElement UnstressedClass
    deriving (Show)

data UnstressedClass = UnstressedClass
    { alainUnstressedClass :: Maybe Text
    , amphirhinaUnstressedClass :: Maybe Text
    , antimachineryUnstressedClass :: Maybe Text
    , coldishUnstressedClass :: Maybe Text
    , crantaraUnstressedClass :: Maybe Text
    , distinguishingUnstressedClass :: Maybe Text
    , elytroposisUnstressedClass :: Maybe Text
    , gentianwortUnstressedClass :: Maybe Text
    , heliosisUnstressedClass :: Maybe Text
    , instrumentalUnstressedClass :: Maybe Text
    , introinflectionUnstressedClass :: Maybe Text
    , kalaUnstressedClass :: Maybe Text
    , lincolnianUnstressedClass :: Maybe Text
    , metadUnstressedClass :: Maybe Text
    , sarcophilusUnstressedClass :: Maybe Text
    , swinginglyUnstressedClass :: Maybe Text
    , unconformityUnstressedClass :: Maybe Text
    , undecreedUnstressedClass :: Maybe Text
    , venerableUnstressedClass :: Maybe Text
    , vowellessnessUnstressedClass :: Maybe Text
    } deriving (Show)

data Untasked
    = DoubleInUntasked Double
    | IntegerMapInUntasked (HashMap Text Int)
    | NullArrayInUntasked ([(Maybe Text)])
    deriving (Show)

data Unvarying
    = BoolInUnvarying Bool
    | DoubleInUnvarying Double
    | IntegerMapInUnvarying (HashMap Text Int)
    deriving (Show)

data Vehemently
    = BoolInVehemently Bool
    | NullArrayInVehemently ([(Maybe Text)])
    | NullInVehemently
    deriving (Show)

data Whitepot
    = DoubleInWhitepot Double
    | QuebrachineClassInWhitepot QuebrachineClass
    deriving (Show)

data WrothyElement
    = NullArrayInWrothyElement ([(Maybe Text)])
    | WrothyClassInWrothyElement WrothyClass
    deriving (Show)

data WrothyClass = WrothyClass
    { aeschynanthusWrothyClass :: Maybe Text
    , aquiferousWrothyClass :: Maybe Text
    , cheapenerWrothyClass :: Maybe Text
    , enumerationWrothyClass :: Maybe Text
    , ephesineWrothyClass :: Maybe Text
    , escadrilleWrothyClass :: Maybe Text
    , estrousWrothyClass :: Maybe Text
    , interestedlyWrothyClass :: Maybe Text
    , katakinetomerWrothyClass :: Maybe Text
    , mortificationWrothyClass :: Maybe Text
    , morulaWrothyClass :: Maybe Text
    , orthosymmetricalWrothyClass :: Maybe Text
    , overbarkWrothyClass :: Maybe Text
    , politistWrothyClass :: Maybe Text
    , sphenomalarWrothyClass :: Maybe Text
    , throatfulWrothyClass :: Maybe Text
    , transhumanceWrothyClass :: Maybe Text
    , triandrianWrothyClass :: Maybe Text
    , unbookedWrothyClass :: Maybe Text
    , wrothyQualifiedWrothyClass :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType protrusiveQuickType pulpitismQuickType pyodermiaQuickType quebrachineQuickType querierQuickType rebarbativeQuickType reimagineQuickType ressautQuickType retrocervicalQuickType revertQuickType rewriteQuickType saccodermQuickType santirQuickType saprophilousQuickType saxtenQuickType scattyQuickType scofferQuickType scrampumQuickType semanticQuickType serpentinicQuickType shadowableQuickType sisteringQuickType staghuntingQuickType stagmometerQuickType stimulabilityQuickType strangleableQuickType strenuosityQuickType tabaxirQuickType talpiformQuickType thwackQuickType toQuickType tortricineQuickType truantcyQuickType turgesceQuickType unbeginningQuickType underdungedQuickType undesirabilityQuickType unerasingQuickType unguentariumQuickType unimpeachablyQuickType unmortgagedQuickType unobstructedQuickType unreceptivityQuickType unsatisfactorinessQuickType unsecurityQuickType unstressedQuickType untaskedQuickType unvaryingQuickType vehementlyQuickType warriorshipQuickType whitepotQuickType wrothyQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "protrusive" .= protrusiveQuickType
        , Just $ "pulpitism" .= pulpitismQuickType
        , Just $ "pyodermia" .= pyodermiaQuickType
        , Just $ "quebrachine" .= quebrachineQuickType
        , Just $ "querier" .= querierQuickType
        , Just $ "rebarbative" .= rebarbativeQuickType
        , Just $ "reimagine" .= reimagineQuickType
        , Just $ "ressaut" .= ressautQuickType
        , Just $ "retrocervical" .= retrocervicalQuickType
        , Just $ "revert" .= revertQuickType
        , Just $ "rewrite" .= rewriteQuickType
        , Just $ "saccoderm" .= saccodermQuickType
        , Just $ "santir" .= santirQuickType
        , Just $ "saprophilous" .= saprophilousQuickType
        , Just $ "saxten" .= saxtenQuickType
        , Just $ "scatty" .= scattyQuickType
        , Just $ "scoffer" .= scofferQuickType
        , Just $ "scrampum" .= scrampumQuickType
        , Just $ "semantic" .= semanticQuickType
        , Just $ "serpentinic" .= serpentinicQuickType
        , Just $ "shadowable" .= shadowableQuickType
        , Just $ "sistering" .= sisteringQuickType
        , Just $ "staghunting" .= staghuntingQuickType
        , Just $ "stagmometer" .= stagmometerQuickType
        , Just $ "stimulability" .= stimulabilityQuickType
        , Just $ "strangleable" .= strangleableQuickType
        , Just $ "strenuosity" .= strenuosityQuickType
        , Just $ "tabaxir" .= tabaxirQuickType
        , Just $ "talpiform" .= talpiformQuickType
        , Just $ "thwack" .= thwackQuickType
        , Just $ "to" .= toQuickType
        , Just $ "tortricine" .= tortricineQuickType
        , Just $ "truantcy" .= truantcyQuickType
        , Just $ "turgesce" .= turgesceQuickType
        , Just $ "unbeginning" .= unbeginningQuickType
        , Just $ "underdunged" .= underdungedQuickType
        , Just $ "undesirability" .= undesirabilityQuickType
        , Just $ "unerasing" .= unerasingQuickType
        , Just $ "unguentarium" .= unguentariumQuickType
        , Just $ "unimpeachably" .= unimpeachablyQuickType
        , Just $ "unmortgaged" .= unmortgagedQuickType
        , Just $ "unobstructed" .= unobstructedQuickType
        , Just $ "unreceptivity" .= unreceptivityQuickType
        , Just $ "unsatisfactoriness" .= unsatisfactorinessQuickType
        , Just $ "unsecurity" .= unsecurityQuickType
        , Just $ "unstressed" .= unstressedQuickType
        , Just $ "untasked" .= untaskedQuickType
        , Just $ "unvarying" .= unvaryingQuickType
        , Just $ "vehemently" .= vehementlyQuickType
        , Just $ "warriorship" .= warriorshipQuickType
        , Just $ "whitepot" .= whitepotQuickType
        , Just $ "wrothy" .= wrothyQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "protrusive"
        <*> v .: "pulpitism"
        <*> v .: "pyodermia"
        <*> v .: "quebrachine"
        <*> v .: "querier"
        <*> v .: "rebarbative"
        <*> v .: "reimagine"
        <*> v .: "ressaut"
        <*> v .: "retrocervical"
        <*> v .: "revert"
        <*> v .: "rewrite"
        <*> v .: "saccoderm"
        <*> v .: "santir"
        <*> v .: "saprophilous"
        <*> v .: "saxten"
        <*> v .: "scatty"
        <*> v .: "scoffer"
        <*> v .: "scrampum"
        <*> v .: "semantic"
        <*> v .: "serpentinic"
        <*> v .: "shadowable"
        <*> v .: "sistering"
        <*> v .: "staghunting"
        <*> v .: "stagmometer"
        <*> v .: "stimulability"
        <*> v .: "strangleable"
        <*> v .: "strenuosity"
        <*> v .: "tabaxir"
        <*> v .: "talpiform"
        <*> v .: "thwack"
        <*> v .: "to"
        <*> v .: "tortricine"
        <*> v .: "truantcy"
        <*> v .: "turgesce"
        <*> v .: "unbeginning"
        <*> v .: "underdunged"
        <*> v .: "undesirability"
        <*> v .: "unerasing"
        <*> v .: "unguentarium"
        <*> v .: "unimpeachably"
        <*> v .: "unmortgaged"
        <*> v .: "unobstructed"
        <*> v .: "unreceptivity"
        <*> v .: "unsatisfactoriness"
        <*> v .: "unsecurity"
        <*> v .: "unstressed"
        <*> v .: "untasked"
        <*> v .: "unvarying"
        <*> v .: "vehemently"
        <*> v .: "warriorship"
        <*> v .: "whitepot"
        <*> v .: "wrothy"

instance ToJSON Protrusive where
    toJSON (DoubleInProtrusive x) = toJSON x
    toJSON (UnionArrayInProtrusive x) = toJSON x

instance FromJSON Protrusive where
    parseJSON xs@(Number _) = (fmap DoubleInProtrusive . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInProtrusive . parseJSON) xs

instance ToJSON PulpitismElement where
    toJSON (DoubleInPulpitismElement x) = toJSON x
    toJSON (IntegerArrayInPulpitismElement x) = toJSON x
    toJSON (PulpitismClassInPulpitismElement x) = toJSON x

instance FromJSON PulpitismElement where
    parseJSON xs@(Number _) = (fmap DoubleInPulpitismElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInPulpitismElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PulpitismClassInPulpitismElement . parseJSON) xs

instance ToJSON PulpitismClass where
    toJSON (PulpitismClass abnetPulpitismClass buckhornPulpitismClass calciformPulpitismClass chelophorePulpitismClass cogitationPulpitismClass decreeablePulpitismClass despicablePulpitismClass isodiazoPulpitismClass jadedlyPulpitismClass leptochloritePulpitismClass nurslingPulpitismClass palamedeanPulpitismClass photoheliographPulpitismClass pipewoodPulpitismClass roberdPulpitismClass statablePulpitismClass superassumePulpitismClass syllabePulpitismClass toughheadPulpitismClass underburnPulpitismClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "abnet" .= abnetPulpitismClass
        , Just $ "buckhorn" .= buckhornPulpitismClass
        , Just $ "calciform" .= calciformPulpitismClass
        , Just $ "chelophore" .= chelophorePulpitismClass
        , Just $ "cogitation" .= cogitationPulpitismClass
        , Just $ "decreeable" .= decreeablePulpitismClass
        , Just $ "despicable" .= despicablePulpitismClass
        , Just $ "isodiazo" .= isodiazoPulpitismClass
        , Just $ "jadedly" .= jadedlyPulpitismClass
        , Just $ "leptochlorite" .= leptochloritePulpitismClass
        , Just $ "nursling" .= nurslingPulpitismClass
        , Just $ "palamedean" .= palamedeanPulpitismClass
        , Just $ "photoheliograph" .= photoheliographPulpitismClass
        , Just $ "pipewood" .= pipewoodPulpitismClass
        , Just $ "roberd" .= roberdPulpitismClass
        , Just $ "statable" .= statablePulpitismClass
        , Just $ "superassume" .= superassumePulpitismClass
        , Just $ "syllabe" .= syllabePulpitismClass
        , Just $ "toughhead" .= toughheadPulpitismClass
        , Just $ "underburn" .= underburnPulpitismClass
        ]

instance FromJSON PulpitismClass where
    parseJSON (Object v) = PulpitismClass
        <$> v .: "abnet"
        <*> v .: "buckhorn"
        <*> v .: "calciform"
        <*> v .: "chelophore"
        <*> v .: "cogitation"
        <*> v .: "decreeable"
        <*> v .: "despicable"
        <*> v .: "isodiazo"
        <*> v .: "jadedly"
        <*> v .: "leptochlorite"
        <*> v .: "nursling"
        <*> v .: "palamedean"
        <*> v .: "photoheliograph"
        <*> v .: "pipewood"
        <*> v .: "roberd"
        <*> v .: "statable"
        <*> v .: "superassume"
        <*> v .: "syllabe"
        <*> v .: "toughhead"
        <*> v .: "underburn"

instance ToJSON PyodermiaElement where
    toJSON (IntegerInPyodermiaElement x) = toJSON x
    toJSON (PyodermiaClassInPyodermiaElement x) = toJSON x

instance FromJSON PyodermiaElement where
    parseJSON xs@(Number _) = (fmap IntegerInPyodermiaElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PyodermiaClassInPyodermiaElement . parseJSON) xs

instance ToJSON PyodermiaClass where
    toJSON (PyodermiaClass aphoristicallyPyodermiaClass apophyllousPyodermiaClass cognizePyodermiaClass dermonosologyPyodermiaClass gyppoPyodermiaClass itherPyodermiaClass juglandaceousPyodermiaClass lithoPyodermiaClass macropterousPyodermiaClass photographerPyodermiaClass romancingPyodermiaClass rumnessPyodermiaClass somniloquistPyodermiaClass stressfullyPyodermiaClass tacticallyPyodermiaClass tracheophonyPyodermiaClass unappositelyPyodermiaClass unclothedlyPyodermiaClass unimpliedPyodermiaClass unsyncopatedPyodermiaClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "aphoristically" .= aphoristicallyPyodermiaClass
        , Just $ "apophyllous" .= apophyllousPyodermiaClass
        , Just $ "cognize" .= cognizePyodermiaClass
        , Just $ "dermonosology" .= dermonosologyPyodermiaClass
        , Just $ "Gyppo" .= gyppoPyodermiaClass
        , Just $ "ither" .= itherPyodermiaClass
        , Just $ "juglandaceous" .= juglandaceousPyodermiaClass
        , Just $ "litho" .= lithoPyodermiaClass
        , Just $ "macropterous" .= macropterousPyodermiaClass
        , Just $ "photographer" .= photographerPyodermiaClass
        , Just $ "romancing" .= romancingPyodermiaClass
        , Just $ "rumness" .= rumnessPyodermiaClass
        , Just $ "somniloquist" .= somniloquistPyodermiaClass
        , Just $ "stressfully" .= stressfullyPyodermiaClass
        , Just $ "tactically" .= tacticallyPyodermiaClass
        , Just $ "tracheophony" .= tracheophonyPyodermiaClass
        , Just $ "unappositely" .= unappositelyPyodermiaClass
        , Just $ "unclothedly" .= unclothedlyPyodermiaClass
        , Just $ "unimplied" .= unimpliedPyodermiaClass
        , Just $ "unsyncopated" .= unsyncopatedPyodermiaClass
        ]

instance FromJSON PyodermiaClass where
    parseJSON (Object v) = PyodermiaClass
        <$> v .: "aphoristically"
        <*> v .: "apophyllous"
        <*> v .: "cognize"
        <*> v .: "dermonosology"
        <*> v .: "Gyppo"
        <*> v .: "ither"
        <*> v .: "juglandaceous"
        <*> v .: "litho"
        <*> v .: "macropterous"
        <*> v .: "photographer"
        <*> v .: "romancing"
        <*> v .: "rumness"
        <*> v .: "somniloquist"
        <*> v .: "stressfully"
        <*> v .: "tactically"
        <*> v .: "tracheophony"
        <*> v .: "unappositely"
        <*> v .: "unclothedly"
        <*> v .: "unimplied"
        <*> v .: "unsyncopated"

instance ToJSON QuebrachineElement where
    toJSON (BoolInQuebrachineElement x) = toJSON x
    toJSON NullInQuebrachineElement = Null
    toJSON (QuebrachineClassInQuebrachineElement x) = toJSON x

instance FromJSON QuebrachineElement where
    parseJSON xs@(Bool _) = (fmap BoolInQuebrachineElement . parseJSON) xs
    parseJSON Null = return NullInQuebrachineElement
    parseJSON xs@(Object _) = (fmap QuebrachineClassInQuebrachineElement . parseJSON) xs

instance ToJSON QuebrachineClass where
    toJSON (QuebrachineClass catharticalnessQuebrachineClass chirotheriumQuebrachineClass disdiapasonQuebrachineClass homocercQuebrachineClass nonbookishQuebrachineClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "catharticalness" .= catharticalnessQuebrachineClass
        , Just $ "Chirotherium" .= chirotheriumQuebrachineClass
        , Just $ "disdiapason" .= disdiapasonQuebrachineClass
        , Just $ "homocerc" .= homocercQuebrachineClass
        , Just $ "nonbookish" .= nonbookishQuebrachineClass
        ]

instance FromJSON QuebrachineClass where
    parseJSON (Object v) = QuebrachineClass
        <$> v .: "catharticalness"
        <*> v .: "Chirotherium"
        <*> v .: "disdiapason"
        <*> v .: "homocerc"
        <*> v .: "nonbookish"

instance ToJSON Querier where
    toJSON (BoolInQuerier x) = toJSON x
    toJSON (IntegerMapInQuerier x) = toJSON x

instance FromJSON Querier where
    parseJSON xs@(Bool _) = (fmap BoolInQuerier . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInQuerier . parseJSON) xs

instance ToJSON Rebarbative where
    toJSON (BoolInRebarbative x) = toJSON x
    toJSON (DoubleInRebarbative x) = toJSON x
    toJSON (IntegerArrayInRebarbative x) = toJSON x

instance FromJSON Rebarbative where
    parseJSON xs@(Bool _) = (fmap BoolInRebarbative . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInRebarbative . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInRebarbative . parseJSON) xs

instance ToJSON Reimagine where
    toJSON (Reimagine adducibleReimagine anabolinReimagine brainyReimagine catharticalnessReimagine chirotheriumReimagine chrysamineReimagine disdiapasonReimagine fluxweedReimagine glaucineReimagine grobianismReimagine hermoReimagine hieroglyphistReimagine homocercReimagine icteroidReimagine immortalReimagine impetulantReimagine irrigateReimagine myxedemaReimagine nonbookishReimagine onyxReimagine repasserReimagine septomarginalReimagine subdieReimagine tibiometatarsalReimagine waltzlikeReimagine) =
        object $ foldMap (maybe [] pure)
        [ ("adducible" .=) <$> adducibleReimagine
        , ("anabolin" .=) <$> anabolinReimagine
        , ("brainy" .=) <$> brainyReimagine
        , ("catharticalness" .=) <$> catharticalnessReimagine
        , ("Chirotherium" .=) <$> chirotheriumReimagine
        , ("chrysamine" .=) <$> chrysamineReimagine
        , ("disdiapason" .=) <$> disdiapasonReimagine
        , ("fluxweed" .=) <$> fluxweedReimagine
        , ("glaucine" .=) <$> glaucineReimagine
        , ("grobianism" .=) <$> grobianismReimagine
        , ("Hermo" .=) <$> hermoReimagine
        , ("hieroglyphist" .=) <$> hieroglyphistReimagine
        , ("homocerc" .=) <$> homocercReimagine
        , ("icteroid" .=) <$> icteroidReimagine
        , ("immortal" .=) <$> immortalReimagine
        , ("impetulant" .=) <$> impetulantReimagine
        , ("irrigate" .=) <$> irrigateReimagine
        , ("myxedema" .=) <$> myxedemaReimagine
        , ("nonbookish" .=) <$> nonbookishReimagine
        , ("onyx" .=) <$> onyxReimagine
        , ("repasser" .=) <$> repasserReimagine
        , ("septomarginal" .=) <$> septomarginalReimagine
        , ("subdie" .=) <$> subdieReimagine
        , ("tibiometatarsal" .=) <$> tibiometatarsalReimagine
        , ("waltzlike" .=) <$> waltzlikeReimagine
        ]

instance FromJSON Reimagine where
    parseJSON (Object v) = Reimagine
        <$> v .:! "adducible"
        <*> v .:! "anabolin"
        <*> v .:! "brainy"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "chrysamine"
        <*> v .:! "disdiapason"
        <*> v .:! "fluxweed"
        <*> v .:! "glaucine"
        <*> v .:! "grobianism"
        <*> v .:! "Hermo"
        <*> v .:! "hieroglyphist"
        <*> v .:! "homocerc"
        <*> v .:! "icteroid"
        <*> v .:! "immortal"
        <*> v .:! "impetulant"
        <*> v .:! "irrigate"
        <*> v .:! "myxedema"
        <*> v .:! "nonbookish"
        <*> v .:! "onyx"
        <*> v .:! "repasser"
        <*> v .:! "septomarginal"
        <*> v .:! "subdie"
        <*> v .:! "tibiometatarsal"
        <*> v .:! "waltzlike"

instance ToJSON Ressaut where
    toJSON (Ressaut apperceptiveRessaut cuttooRessaut douserRessaut drinkproofRessaut forementionedRessaut freesiaRessaut genevieveRessaut hyperdiabolicalRessaut hypoconeRessaut irreverentiallyRessaut jumartRessaut mimosaceaeRessaut mollicrushRessaut nedderRessaut retinasphaltRessaut soughRessaut steadingRessaut theopaschitismRessaut undurablenessRessaut unmingleableRessaut) =
        object $ foldMap (maybe [] pure)
        [ Just $ "apperceptive" .= apperceptiveRessaut
        , Just $ "cuttoo" .= cuttooRessaut
        , Just $ "douser" .= douserRessaut
        , Just $ "drinkproof" .= drinkproofRessaut
        , Just $ "forementioned" .= forementionedRessaut
        , Just $ "Freesia" .= freesiaRessaut
        , Just $ "Genevieve" .= genevieveRessaut
        , Just $ "hyperdiabolical" .= hyperdiabolicalRessaut
        , Just $ "hypocone" .= hypoconeRessaut
        , Just $ "irreverentially" .= irreverentiallyRessaut
        , Just $ "jumart" .= jumartRessaut
        , Just $ "Mimosaceae" .= mimosaceaeRessaut
        , Just $ "mollicrush" .= mollicrushRessaut
        , Just $ "nedder" .= nedderRessaut
        , Just $ "retinasphalt" .= retinasphaltRessaut
        , Just $ "sough" .= soughRessaut
        , Just $ "steading" .= steadingRessaut
        , Just $ "Theopaschitism" .= theopaschitismRessaut
        , Just $ "undurableness" .= undurablenessRessaut
        , Just $ "unmingleable" .= unmingleableRessaut
        ]

instance FromJSON Ressaut where
    parseJSON (Object v) = Ressaut
        <$> v .: "apperceptive"
        <*> v .: "cuttoo"
        <*> v .: "douser"
        <*> v .: "drinkproof"
        <*> v .: "forementioned"
        <*> v .: "Freesia"
        <*> v .: "Genevieve"
        <*> v .: "hyperdiabolical"
        <*> v .: "hypocone"
        <*> v .: "irreverentially"
        <*> v .: "jumart"
        <*> v .: "Mimosaceae"
        <*> v .: "mollicrush"
        <*> v .: "nedder"
        <*> v .: "retinasphalt"
        <*> v .: "sough"
        <*> v .: "steading"
        <*> v .: "Theopaschitism"
        <*> v .: "undurableness"
        <*> v .: "unmingleable"

instance ToJSON Retrocervical where
    toJSON (IntegerInRetrocervical x) = toJSON x
    toJSON (UnionArrayInRetrocervical x) = toJSON x

instance FromJSON Retrocervical where
    parseJSON xs@(Number _) = (fmap IntegerInRetrocervical . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInRetrocervical . parseJSON) xs

instance ToJSON Revert where
    toJSON (BoolInRevert x) = toJSON x
    toJSON (StringInRevert x) = toJSON x

instance FromJSON Revert where
    parseJSON xs@(Bool _) = (fmap BoolInRevert . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInRevert . parseJSON) xs

instance ToJSON RewriteElement where
    toJSON (DoubleInRewriteElement x) = toJSON x
    toJSON (NullArrayInRewriteElement x) = toJSON x
    toJSON (RewriteClassInRewriteElement x) = toJSON x

instance FromJSON RewriteElement where
    parseJSON xs@(Number _) = (fmap DoubleInRewriteElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInRewriteElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RewriteClassInRewriteElement . parseJSON) xs

instance ToJSON RewriteClass where
    toJSON (RewriteClass accountancyRewriteClass cacotrophicRewriteClass contestRewriteClass couthilyRewriteClass falculateRewriteClass foreseizeRewriteClass hyadesRewriteClass lemnadRewriteClass monotheisticallyRewriteClass nonflyingRewriteClass ptenoglossaRewriteClass repatchRewriteClass rodmanRewriteClass strungRewriteClass titmalRewriteClass twalpennyworthRewriteClass unblamableRewriteClass verticalRewriteClass whiggificationRewriteClass yardmanRewriteClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "accountancy" .= accountancyRewriteClass
        , Just $ "cacotrophic" .= cacotrophicRewriteClass
        , Just $ "contest" .= contestRewriteClass
        , Just $ "couthily" .= couthilyRewriteClass
        , Just $ "falculate" .= falculateRewriteClass
        , Just $ "foreseize" .= foreseizeRewriteClass
        , Just $ "Hyades" .= hyadesRewriteClass
        , Just $ "lemnad" .= lemnadRewriteClass
        , Just $ "monotheistically" .= monotheisticallyRewriteClass
        , Just $ "nonflying" .= nonflyingRewriteClass
        , Just $ "Ptenoglossa" .= ptenoglossaRewriteClass
        , Just $ "repatch" .= repatchRewriteClass
        , Just $ "rodman" .= rodmanRewriteClass
        , Just $ "strung" .= strungRewriteClass
        , Just $ "titmal" .= titmalRewriteClass
        , Just $ "twalpennyworth" .= twalpennyworthRewriteClass
        , Just $ "unblamable" .= unblamableRewriteClass
        , Just $ "vertical" .= verticalRewriteClass
        , Just $ "Whiggification" .= whiggificationRewriteClass
        , Just $ "yardman" .= yardmanRewriteClass
        ]

instance FromJSON RewriteClass where
    parseJSON (Object v) = RewriteClass
        <$> v .: "accountancy"
        <*> v .: "cacotrophic"
        <*> v .: "contest"
        <*> v .: "couthily"
        <*> v .: "falculate"
        <*> v .: "foreseize"
        <*> v .: "Hyades"
        <*> v .: "lemnad"
        <*> v .: "monotheistically"
        <*> v .: "nonflying"
        <*> v .: "Ptenoglossa"
        <*> v .: "repatch"
        <*> v .: "rodman"
        <*> v .: "strung"
        <*> v .: "titmal"
        <*> v .: "twalpennyworth"
        <*> v .: "unblamable"
        <*> v .: "vertical"
        <*> v .: "Whiggification"
        <*> v .: "yardman"

instance ToJSON Saccoderm where
    toJSON (IntegerArrayInSaccoderm x) = toJSON x
    toJSON NullInSaccoderm = Null
    toJSON (StringInSaccoderm x) = toJSON x

instance FromJSON Saccoderm where
    parseJSON xs@(Array _) = (fmap IntegerArrayInSaccoderm . parseJSON) xs
    parseJSON Null = return NullInSaccoderm
    parseJSON xs@(String _) = (fmap StringInSaccoderm . parseJSON) xs

instance ToJSON SantirElement where
    toJSON (DoubleInSantirElement x) = toJSON x
    toJSON (SantirClassInSantirElement x) = toJSON x

instance FromJSON SantirElement where
    parseJSON xs@(Number _) = (fmap DoubleInSantirElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SantirClassInSantirElement . parseJSON) xs

instance ToJSON SantirClass where
    toJSON (SantirClass admiredlySantirClass demicaponierSantirClass epitympanicSantirClass investitorSantirClass lupiformSantirClass monoflagellateSantirClass paleoethnicSantirClass prediscountableSantirClass rhetoricalsSantirClass roomthSantirClass saccharoseSantirClass septonasalSantirClass serpenticideSantirClass setariousSantirClass spaeworkSantirClass styliteSantirClass suessionesSantirClass timelilySantirClass unprofanedSantirClass vorticularSantirClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "admiredly" .= admiredlySantirClass
        , Just $ "demicaponier" .= demicaponierSantirClass
        , Just $ "epitympanic" .= epitympanicSantirClass
        , Just $ "investitor" .= investitorSantirClass
        , Just $ "lupiform" .= lupiformSantirClass
        , Just $ "monoflagellate" .= monoflagellateSantirClass
        , Just $ "paleoethnic" .= paleoethnicSantirClass
        , Just $ "prediscountable" .= prediscountableSantirClass
        , Just $ "rhetoricals" .= rhetoricalsSantirClass
        , Just $ "roomth" .= roomthSantirClass
        , Just $ "saccharose" .= saccharoseSantirClass
        , Just $ "septonasal" .= septonasalSantirClass
        , Just $ "serpenticide" .= serpenticideSantirClass
        , Just $ "setarious" .= setariousSantirClass
        , Just $ "spaework" .= spaeworkSantirClass
        , Just $ "stylite" .= styliteSantirClass
        , Just $ "Suessiones" .= suessionesSantirClass
        , Just $ "timelily" .= timelilySantirClass
        , Just $ "unprofaned" .= unprofanedSantirClass
        , Just $ "vorticular" .= vorticularSantirClass
        ]

instance FromJSON SantirClass where
    parseJSON (Object v) = SantirClass
        <$> v .: "admiredly"
        <*> v .: "demicaponier"
        <*> v .: "epitympanic"
        <*> v .: "investitor"
        <*> v .: "lupiform"
        <*> v .: "monoflagellate"
        <*> v .: "paleoethnic"
        <*> v .: "prediscountable"
        <*> v .: "rhetoricals"
        <*> v .: "roomth"
        <*> v .: "saccharose"
        <*> v .: "septonasal"
        <*> v .: "serpenticide"
        <*> v .: "setarious"
        <*> v .: "spaework"
        <*> v .: "stylite"
        <*> v .: "Suessiones"
        <*> v .: "timelily"
        <*> v .: "unprofaned"
        <*> v .: "vorticular"

instance ToJSON Saprophilous where
    toJSON (IntegerMapInSaprophilous x) = toJSON x
    toJSON NullInSaprophilous = Null
    toJSON (StringInSaprophilous x) = toJSON x

instance FromJSON Saprophilous where
    parseJSON xs@(Object _) = (fmap IntegerMapInSaprophilous . parseJSON) xs
    parseJSON Null = return NullInSaprophilous
    parseJSON xs@(String _) = (fmap StringInSaprophilous . parseJSON) xs

instance ToJSON SaxtenElement where
    toJSON (SaxtenClassInSaxtenElement x) = toJSON x
    toJSON (StringInSaxtenElement x) = toJSON x

instance FromJSON SaxtenElement where
    parseJSON xs@(Object _) = (fmap SaxtenClassInSaxtenElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInSaxtenElement . parseJSON) xs

instance ToJSON SaxtenClass where
    toJSON (SaxtenClass algarrobillaSaxtenClass bowgraceSaxtenClass catharticalnessSaxtenClass centauridSaxtenClass chirotheriumSaxtenClass disdiapasonSaxtenClass flixSaxtenClass germanelySaxtenClass homocercSaxtenClass inhumeSaxtenClass lepidoteSaxtenClass megalochirousSaxtenClass ninepennySaxtenClass nonbookishSaxtenClass nondeistSaxtenClass nymphaeaceousSaxtenClass parietofrontalSaxtenClass sancyiteSaxtenClass subjectivistSaxtenClass tibiadSaxtenClass transonicSaxtenClass tripetalousSaxtenClass trunchmanSaxtenClass urgerSaxtenClass withdrawnnessSaxtenClass) =
        object $ foldMap (maybe [] pure)
        [ ("algarrobilla" .=) <$> algarrobillaSaxtenClass
        , ("bowgrace" .=) <$> bowgraceSaxtenClass
        , ("catharticalness" .=) <$> catharticalnessSaxtenClass
        , ("Centaurid" .=) <$> centauridSaxtenClass
        , ("Chirotherium" .=) <$> chirotheriumSaxtenClass
        , ("disdiapason" .=) <$> disdiapasonSaxtenClass
        , ("flix" .=) <$> flixSaxtenClass
        , ("germanely" .=) <$> germanelySaxtenClass
        , ("homocerc" .=) <$> homocercSaxtenClass
        , ("inhume" .=) <$> inhumeSaxtenClass
        , ("lepidote" .=) <$> lepidoteSaxtenClass
        , ("megalochirous" .=) <$> megalochirousSaxtenClass
        , ("ninepenny" .=) <$> ninepennySaxtenClass
        , ("nonbookish" .=) <$> nonbookishSaxtenClass
        , ("nondeist" .=) <$> nondeistSaxtenClass
        , ("nymphaeaceous" .=) <$> nymphaeaceousSaxtenClass
        , ("parietofrontal" .=) <$> parietofrontalSaxtenClass
        , ("sancyite" .=) <$> sancyiteSaxtenClass
        , ("subjectivist" .=) <$> subjectivistSaxtenClass
        , ("tibiad" .=) <$> tibiadSaxtenClass
        , ("transonic" .=) <$> transonicSaxtenClass
        , ("tripetalous" .=) <$> tripetalousSaxtenClass
        , ("trunchman" .=) <$> trunchmanSaxtenClass
        , ("urger" .=) <$> urgerSaxtenClass
        , ("withdrawnness" .=) <$> withdrawnnessSaxtenClass
        ]

instance FromJSON SaxtenClass where
    parseJSON (Object v) = SaxtenClass
        <$> v .:! "algarrobilla"
        <*> v .:! "bowgrace"
        <*> v .:! "catharticalness"
        <*> v .:! "Centaurid"
        <*> v .:! "Chirotherium"
        <*> v .:! "disdiapason"
        <*> v .:! "flix"
        <*> v .:! "germanely"
        <*> v .:! "homocerc"
        <*> v .:! "inhume"
        <*> v .:! "lepidote"
        <*> v .:! "megalochirous"
        <*> v .:! "ninepenny"
        <*> v .:! "nonbookish"
        <*> v .:! "nondeist"
        <*> v .:! "nymphaeaceous"
        <*> v .:! "parietofrontal"
        <*> v .:! "sancyite"
        <*> v .:! "subjectivist"
        <*> v .:! "tibiad"
        <*> v .:! "transonic"
        <*> v .:! "tripetalous"
        <*> v .:! "trunchman"
        <*> v .:! "urger"
        <*> v .:! "withdrawnness"

instance ToJSON Scatty where
    toJSON (Scatty aeriferousScatty anticalScatty antighostismScatty arcanumScatty autotrophyScatty baronialScatty caffeineScatty gorgoniaceanScatty heroicalScatty hydropicalScatty mechanologyScatty musicopoeticScatty officialityScatty oftentimesScatty ophthalmotonometerScatty reflectivelyScatty springerScatty tabascoScatty teleianthousScatty uncombatedScatty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "aeriferous" .= aeriferousScatty
        , Just $ "antical" .= anticalScatty
        , Just $ "antighostism" .= antighostismScatty
        , Just $ "arcanum" .= arcanumScatty
        , Just $ "autotrophy" .= autotrophyScatty
        , Just $ "baronial" .= baronialScatty
        , Just $ "caffeine" .= caffeineScatty
        , Just $ "gorgoniacean" .= gorgoniaceanScatty
        , Just $ "heroical" .= heroicalScatty
        , Just $ "hydropical" .= hydropicalScatty
        , Just $ "mechanology" .= mechanologyScatty
        , Just $ "musicopoetic" .= musicopoeticScatty
        , Just $ "officiality" .= officialityScatty
        , Just $ "oftentimes" .= oftentimesScatty
        , Just $ "ophthalmotonometer" .= ophthalmotonometerScatty
        , Just $ "reflectively" .= reflectivelyScatty
        , Just $ "springer" .= springerScatty
        , Just $ "Tabasco" .= tabascoScatty
        , Just $ "teleianthous" .= teleianthousScatty
        , Just $ "uncombated" .= uncombatedScatty
        ]

instance FromJSON Scatty where
    parseJSON (Object v) = Scatty
        <$> v .: "aeriferous"
        <*> v .: "antical"
        <*> v .: "antighostism"
        <*> v .: "arcanum"
        <*> v .: "autotrophy"
        <*> v .: "baronial"
        <*> v .: "caffeine"
        <*> v .: "gorgoniacean"
        <*> v .: "heroical"
        <*> v .: "hydropical"
        <*> v .: "mechanology"
        <*> v .: "musicopoetic"
        <*> v .: "officiality"
        <*> v .: "oftentimes"
        <*> v .: "ophthalmotonometer"
        <*> v .: "reflectively"
        <*> v .: "springer"
        <*> v .: "Tabasco"
        <*> v .: "teleianthous"
        <*> v .: "uncombated"

instance ToJSON Scoffer where
    toJSON (IntegerMapInScoffer x) = toJSON x
    toJSON (NullArrayInScoffer x) = toJSON x
    toJSON NullInScoffer = Null

instance FromJSON Scoffer where
    parseJSON xs@(Object _) = (fmap IntegerMapInScoffer . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInScoffer . parseJSON) xs
    parseJSON Null = return NullInScoffer

instance ToJSON Scrampum where
    toJSON (BoolInScrampum x) = toJSON x
    toJSON (IntegerArrayInScrampum x) = toJSON x
    toJSON NullInScrampum = Null

instance FromJSON Scrampum where
    parseJSON xs@(Bool _) = (fmap BoolInScrampum . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInScrampum . parseJSON) xs
    parseJSON Null = return NullInScrampum

instance ToJSON Serpentinic where
    toJSON (DoubleInSerpentinic x) = toJSON x
    toJSON (IntegerArrayInSerpentinic x) = toJSON x

instance FromJSON Serpentinic where
    parseJSON xs@(Number _) = (fmap DoubleInSerpentinic . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInSerpentinic . parseJSON) xs

instance ToJSON Shadowable where
    toJSON (BoolInShadowable x) = toJSON x
    toJSON (UnionArrayInShadowable x) = toJSON x

instance FromJSON Shadowable where
    parseJSON xs@(Bool _) = (fmap BoolInShadowable . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInShadowable . parseJSON) xs

instance ToJSON SisteringElement where
    toJSON (IntegerInSisteringElement x) = toJSON x
    toJSON (NullArrayInSisteringElement x) = toJSON x
    toJSON (SisteringClassInSisteringElement x) = toJSON x

instance FromJSON SisteringElement where
    parseJSON xs@(Number _) = (fmap IntegerInSisteringElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInSisteringElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap SisteringClassInSisteringElement . parseJSON) xs

instance ToJSON SisteringClass where
    toJSON (SisteringClass amphicarpicSisteringClass chiantiSisteringClass frigorificSisteringClass haplomiSisteringClass hyperkinesisSisteringClass laudableSisteringClass madwomanSisteringClass maimedlySisteringClass micropterygidaeSisteringClass microrhabdusSisteringClass nondenseSisteringClass phlebemphraxisSisteringClass redsearSisteringClass schismaticalSisteringClass tartrylSisteringClass unabhorredSisteringClass undeliberatenessSisteringClass unmixableSisteringClass untrucklingSisteringClass vinealSisteringClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "amphicarpic" .= amphicarpicSisteringClass
        , Just $ "Chianti" .= chiantiSisteringClass
        , Just $ "frigorific" .= frigorificSisteringClass
        , Just $ "Haplomi" .= haplomiSisteringClass
        , Just $ "hyperkinesis" .= hyperkinesisSisteringClass
        , Just $ "laudable" .= laudableSisteringClass
        , Just $ "madwoman" .= madwomanSisteringClass
        , Just $ "maimedly" .= maimedlySisteringClass
        , Just $ "Micropterygidae" .= micropterygidaeSisteringClass
        , Just $ "microrhabdus" .= microrhabdusSisteringClass
        , Just $ "nondense" .= nondenseSisteringClass
        , Just $ "phlebemphraxis" .= phlebemphraxisSisteringClass
        , Just $ "redsear" .= redsearSisteringClass
        , Just $ "schismatical" .= schismaticalSisteringClass
        , Just $ "tartryl" .= tartrylSisteringClass
        , Just $ "unabhorred" .= unabhorredSisteringClass
        , Just $ "undeliberateness" .= undeliberatenessSisteringClass
        , Just $ "unmixable" .= unmixableSisteringClass
        , Just $ "untruckling" .= untrucklingSisteringClass
        , Just $ "vineal" .= vinealSisteringClass
        ]

instance FromJSON SisteringClass where
    parseJSON (Object v) = SisteringClass
        <$> v .: "amphicarpic"
        <*> v .: "Chianti"
        <*> v .: "frigorific"
        <*> v .: "Haplomi"
        <*> v .: "hyperkinesis"
        <*> v .: "laudable"
        <*> v .: "madwoman"
        <*> v .: "maimedly"
        <*> v .: "Micropterygidae"
        <*> v .: "microrhabdus"
        <*> v .: "nondense"
        <*> v .: "phlebemphraxis"
        <*> v .: "redsear"
        <*> v .: "schismatical"
        <*> v .: "tartryl"
        <*> v .: "unabhorred"
        <*> v .: "undeliberateness"
        <*> v .: "unmixable"
        <*> v .: "untruckling"
        <*> v .: "vineal"

instance ToJSON Staghunting where
    toJSON (Staghunting calorimetricStaghunting canidStaghunting catharticalnessStaghunting chirotheriumStaghunting disdiapasonStaghunting ditriglyphicStaghunting floriferousnessStaghunting gamelikeStaghunting grigStaghunting homocercStaghunting interloanStaghunting lithotomyStaghunting loricStaghunting membranocoriaceousStaghunting membranogenicStaghunting nonbookishStaghunting overtrumpStaghunting scotinoStaghunting seasonableStaghunting sephenStaghunting stigmarioidStaghunting tiredStaghunting trifidStaghunting undefeatedlyStaghunting ungirlishStaghunting) =
        object $ foldMap (maybe [] pure)
        [ ("calorimetric" .=) <$> calorimetricStaghunting
        , ("canid" .=) <$> canidStaghunting
        , ("catharticalness" .=) <$> catharticalnessStaghunting
        , ("Chirotherium" .=) <$> chirotheriumStaghunting
        , ("disdiapason" .=) <$> disdiapasonStaghunting
        , ("ditriglyphic" .=) <$> ditriglyphicStaghunting
        , ("floriferousness" .=) <$> floriferousnessStaghunting
        , ("gamelike" .=) <$> gamelikeStaghunting
        , ("grig" .=) <$> grigStaghunting
        , ("homocerc" .=) <$> homocercStaghunting
        , ("interloan" .=) <$> interloanStaghunting
        , ("lithotomy" .=) <$> lithotomyStaghunting
        , ("loric" .=) <$> loricStaghunting
        , ("membranocoriaceous" .=) <$> membranocoriaceousStaghunting
        , ("membranogenic" .=) <$> membranogenicStaghunting
        , ("nonbookish" .=) <$> nonbookishStaghunting
        , ("overtrump" .=) <$> overtrumpStaghunting
        , ("scotino" .=) <$> scotinoStaghunting
        , ("seasonable" .=) <$> seasonableStaghunting
        , ("sephen" .=) <$> sephenStaghunting
        , ("stigmarioid" .=) <$> stigmarioidStaghunting
        , ("tired" .=) <$> tiredStaghunting
        , ("trifid" .=) <$> trifidStaghunting
        , ("undefeatedly" .=) <$> undefeatedlyStaghunting
        , ("ungirlish" .=) <$> ungirlishStaghunting
        ]

instance FromJSON Staghunting where
    parseJSON (Object v) = Staghunting
        <$> v .:! "calorimetric"
        <*> v .:! "canid"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "disdiapason"
        <*> v .:! "ditriglyphic"
        <*> v .:! "floriferousness"
        <*> v .:! "gamelike"
        <*> v .:! "grig"
        <*> v .:! "homocerc"
        <*> v .:! "interloan"
        <*> v .:! "lithotomy"
        <*> v .:! "loric"
        <*> v .:! "membranocoriaceous"
        <*> v .:! "membranogenic"
        <*> v .:! "nonbookish"
        <*> v .:! "overtrump"
        <*> v .:! "scotino"
        <*> v .:! "seasonable"
        <*> v .:! "sephen"
        <*> v .:! "stigmarioid"
        <*> v .:! "tired"
        <*> v .:! "trifid"
        <*> v .:! "undefeatedly"
        <*> v .:! "ungirlish"

instance ToJSON Stagmometer where
    toJSON (StringInStagmometer x) = toJSON x
    toJSON (UnionArrayInStagmometer x) = toJSON x

instance FromJSON Stagmometer where
    parseJSON xs@(String _) = (fmap StringInStagmometer . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInStagmometer . parseJSON) xs

instance ToJSON Stimulability where
    toJSON (BoolInStimulability x) = toJSON x
    toJSON (IntegerInStimulability x) = toJSON x
    toJSON (IntegerMapInStimulability x) = toJSON x

instance FromJSON Stimulability where
    parseJSON xs@(Bool _) = (fmap BoolInStimulability . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInStimulability . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInStimulability . parseJSON) xs

instance ToJSON Strangleable where
    toJSON (DoubleInStrangleable x) = toJSON x
    toJSON (NullArrayInStrangleable x) = toJSON x

instance FromJSON Strangleable where
    parseJSON xs@(Number _) = (fmap DoubleInStrangleable . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInStrangleable . parseJSON) xs

instance ToJSON StrenuosityElement where
    toJSON (NullArrayInStrenuosityElement x) = toJSON x
    toJSON (StrenuosityClassInStrenuosityElement x) = toJSON x

instance FromJSON StrenuosityElement where
    parseJSON xs@(Array _) = (fmap NullArrayInStrenuosityElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap StrenuosityClassInStrenuosityElement . parseJSON) xs

instance ToJSON StrenuosityClass where
    toJSON (StrenuosityClass blissStrenuosityClass buccateStrenuosityClass bulletproofStrenuosityClass catharticalnessStrenuosityClass chirotheriumStrenuosityClass crumblingnessStrenuosityClass disdiapasonStrenuosityClass engagedlyStrenuosityClass fightableStrenuosityClass hoarinessStrenuosityClass homocercStrenuosityClass hypopodiumStrenuosityClass luxuristStrenuosityClass mechanicianStrenuosityClass nonbookishStrenuosityClass onopordonStrenuosityClass podgilyStrenuosityClass reformablenessStrenuosityClass scatterbrainsStrenuosityClass seminuriaStrenuosityClass sodomiteStrenuosityClass trampStrenuosityClass unduenessStrenuosityClass worthilyStrenuosityClass yankeeistStrenuosityClass) =
        object $ foldMap (maybe [] pure)
        [ ("bliss" .=) <$> blissStrenuosityClass
        , ("buccate" .=) <$> buccateStrenuosityClass
        , ("bulletproof" .=) <$> bulletproofStrenuosityClass
        , ("catharticalness" .=) <$> catharticalnessStrenuosityClass
        , ("Chirotherium" .=) <$> chirotheriumStrenuosityClass
        , ("crumblingness" .=) <$> crumblingnessStrenuosityClass
        , ("disdiapason" .=) <$> disdiapasonStrenuosityClass
        , ("engagedly" .=) <$> engagedlyStrenuosityClass
        , ("fightable" .=) <$> fightableStrenuosityClass
        , ("hoariness" .=) <$> hoarinessStrenuosityClass
        , ("homocerc" .=) <$> homocercStrenuosityClass
        , ("hypopodium" .=) <$> hypopodiumStrenuosityClass
        , ("luxurist" .=) <$> luxuristStrenuosityClass
        , ("mechanician" .=) <$> mechanicianStrenuosityClass
        , ("nonbookish" .=) <$> nonbookishStrenuosityClass
        , ("Onopordon" .=) <$> onopordonStrenuosityClass
        , ("podgily" .=) <$> podgilyStrenuosityClass
        , ("reformableness" .=) <$> reformablenessStrenuosityClass
        , ("scatterbrains" .=) <$> scatterbrainsStrenuosityClass
        , ("seminuria" .=) <$> seminuriaStrenuosityClass
        , ("Sodomite" .=) <$> sodomiteStrenuosityClass
        , ("tramp" .=) <$> trampStrenuosityClass
        , ("undueness" .=) <$> unduenessStrenuosityClass
        , ("worthily" .=) <$> worthilyStrenuosityClass
        , ("Yankeeist" .=) <$> yankeeistStrenuosityClass
        ]

instance FromJSON StrenuosityClass where
    parseJSON (Object v) = StrenuosityClass
        <$> v .:! "bliss"
        <*> v .:! "buccate"
        <*> v .:! "bulletproof"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "crumblingness"
        <*> v .:! "disdiapason"
        <*> v .:! "engagedly"
        <*> v .:! "fightable"
        <*> v .:! "hoariness"
        <*> v .:! "homocerc"
        <*> v .:! "hypopodium"
        <*> v .:! "luxurist"
        <*> v .:! "mechanician"
        <*> v .:! "nonbookish"
        <*> v .:! "Onopordon"
        <*> v .:! "podgily"
        <*> v .:! "reformableness"
        <*> v .:! "scatterbrains"
        <*> v .:! "seminuria"
        <*> v .:! "Sodomite"
        <*> v .:! "tramp"
        <*> v .:! "undueness"
        <*> v .:! "worthily"
        <*> v .:! "Yankeeist"

instance ToJSON Tabaxir where
    toJSON (BoolInTabaxir x) = toJSON x
    toJSON (DoubleInTabaxir x) = toJSON x

instance FromJSON Tabaxir where
    parseJSON xs@(Bool _) = (fmap BoolInTabaxir . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInTabaxir . parseJSON) xs

instance ToJSON Talpiform where
    toJSON (DoubleInTalpiform x) = toJSON x
    toJSON NullInTalpiform = Null
    toJSON (QuebrachineClassInTalpiform x) = toJSON x

instance FromJSON Talpiform where
    parseJSON xs@(Number _) = (fmap DoubleInTalpiform . parseJSON) xs
    parseJSON Null = return NullInTalpiform
    parseJSON xs@(Object _) = (fmap QuebrachineClassInTalpiform . parseJSON) xs

instance ToJSON Thwack where
    toJSON (BoolInThwack x) = toJSON x
    toJSON (DoubleInThwack x) = toJSON x
    toJSON (QuebrachineClassInThwack x) = toJSON x

instance FromJSON Thwack where
    parseJSON xs@(Bool _) = (fmap BoolInThwack . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInThwack . parseJSON) xs
    parseJSON xs@(Object _) = (fmap QuebrachineClassInThwack . parseJSON) xs

instance ToJSON Tortricine where
    toJSON (QuebrachineClassInTortricine x) = toJSON x
    toJSON (UnionArrayInTortricine x) = toJSON x

instance FromJSON Tortricine where
    parseJSON xs@(Object _) = (fmap QuebrachineClassInTortricine . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInTortricine . parseJSON) xs

instance ToJSON TruantcyElement where
    toJSON (BoolInTruantcyElement x) = toJSON x
    toJSON (TruantcyClassInTruantcyElement x) = toJSON x

instance FromJSON TruantcyElement where
    parseJSON xs@(Bool _) = (fmap BoolInTruantcyElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TruantcyClassInTruantcyElement . parseJSON) xs

instance ToJSON TruantcyClass where
    toJSON (TruantcyClass alfionaTruantcyClass ascaridiasisTruantcyClass bungeyTruantcyClass catharticalnessTruantcyClass ceroxyleTruantcyClass chirotheriumTruantcyClass chorologyTruantcyClass disdiapasonTruantcyClass enmarbleTruantcyClass epeiraTruantcyClass eurylaimiTruantcyClass germinationTruantcyClass hallelujahTruantcyClass homocercTruantcyClass levTruantcyClass mouthingTruantcyClass nonbookishTruantcyClass phillilooTruantcyClass planetalTruantcyClass poneyTruantcyClass punctualistTruantcyClass returnlesslyTruantcyClass skelderTruantcyClass windwaywardlyTruantcyClass yumanTruantcyClass) =
        object $ foldMap (maybe [] pure)
        [ ("alfiona" .=) <$> alfionaTruantcyClass
        , ("ascaridiasis" .=) <$> ascaridiasisTruantcyClass
        , ("bungey" .=) <$> bungeyTruantcyClass
        , ("catharticalness" .=) <$> catharticalnessTruantcyClass
        , ("ceroxyle" .=) <$> ceroxyleTruantcyClass
        , ("Chirotherium" .=) <$> chirotheriumTruantcyClass
        , ("chorology" .=) <$> chorologyTruantcyClass
        , ("disdiapason" .=) <$> disdiapasonTruantcyClass
        , ("enmarble" .=) <$> enmarbleTruantcyClass
        , ("Epeira" .=) <$> epeiraTruantcyClass
        , ("Eurylaimi" .=) <$> eurylaimiTruantcyClass
        , ("germination" .=) <$> germinationTruantcyClass
        , ("hallelujah" .=) <$> hallelujahTruantcyClass
        , ("homocerc" .=) <$> homocercTruantcyClass
        , ("lev" .=) <$> levTruantcyClass
        , ("mouthing" .=) <$> mouthingTruantcyClass
        , ("nonbookish" .=) <$> nonbookishTruantcyClass
        , ("philliloo" .=) <$> phillilooTruantcyClass
        , ("planetal" .=) <$> planetalTruantcyClass
        , ("poney" .=) <$> poneyTruantcyClass
        , ("punctualist" .=) <$> punctualistTruantcyClass
        , ("returnlessly" .=) <$> returnlesslyTruantcyClass
        , ("skelder" .=) <$> skelderTruantcyClass
        , ("windwaywardly" .=) <$> windwaywardlyTruantcyClass
        , ("Yuman" .=) <$> yumanTruantcyClass
        ]

instance FromJSON TruantcyClass where
    parseJSON (Object v) = TruantcyClass
        <$> v .:! "alfiona"
        <*> v .:! "ascaridiasis"
        <*> v .:! "bungey"
        <*> v .:! "catharticalness"
        <*> v .:! "ceroxyle"
        <*> v .:! "Chirotherium"
        <*> v .:! "chorology"
        <*> v .:! "disdiapason"
        <*> v .:! "enmarble"
        <*> v .:! "Epeira"
        <*> v .:! "Eurylaimi"
        <*> v .:! "germination"
        <*> v .:! "hallelujah"
        <*> v .:! "homocerc"
        <*> v .:! "lev"
        <*> v .:! "mouthing"
        <*> v .:! "nonbookish"
        <*> v .:! "philliloo"
        <*> v .:! "planetal"
        <*> v .:! "poney"
        <*> v .:! "punctualist"
        <*> v .:! "returnlessly"
        <*> v .:! "skelder"
        <*> v .:! "windwaywardly"
        <*> v .:! "Yuman"

instance ToJSON Unbeginning where
    toJSON (IntegerMapInUnbeginning x) = toJSON x
    toJSON (NullArrayInUnbeginning x) = toJSON x
    toJSON (StringInUnbeginning x) = toJSON x

instance FromJSON Unbeginning where
    parseJSON xs@(Object _) = (fmap IntegerMapInUnbeginning . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInUnbeginning . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnbeginning . parseJSON) xs

instance ToJSON Undesirability where
    toJSON (IntegerArrayInUndesirability x) = toJSON x
    toJSON (IntegerMapInUndesirability x) = toJSON x
    toJSON (StringInUndesirability x) = toJSON x

instance FromJSON Undesirability where
    parseJSON xs@(Array _) = (fmap IntegerArrayInUndesirability . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInUndesirability . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUndesirability . parseJSON) xs

instance ToJSON Unerasing where
    toJSON (IntegerInUnerasing x) = toJSON x
    toJSON (IntegerMapInUnerasing x) = toJSON x
    toJSON (NullArrayInUnerasing x) = toJSON x

instance FromJSON Unerasing where
    parseJSON xs@(Number _) = (fmap IntegerInUnerasing . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInUnerasing . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInUnerasing . parseJSON) xs

instance ToJSON Unguentarium where
    toJSON (IntegerInUnguentarium x) = toJSON x
    toJSON (NullArrayInUnguentarium x) = toJSON x
    toJSON NullInUnguentarium = Null

instance FromJSON Unguentarium where
    parseJSON xs@(Number _) = (fmap IntegerInUnguentarium . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInUnguentarium . parseJSON) xs
    parseJSON Null = return NullInUnguentarium

instance ToJSON UnimpeachablyElement where
    toJSON (BoolInUnimpeachablyElement x) = toJSON x
    toJSON (UnimpeachablyClassInUnimpeachablyElement x) = toJSON x

instance FromJSON UnimpeachablyElement where
    parseJSON xs@(Bool _) = (fmap BoolInUnimpeachablyElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnimpeachablyClassInUnimpeachablyElement . parseJSON) xs

instance ToJSON UnimpeachablyClass where
    toJSON (UnimpeachablyClass acerinUnimpeachablyClass bobadilUnimpeachablyClass catharticalnessUnimpeachablyClass chirotheriumUnimpeachablyClass chlorophylligenousUnimpeachablyClass conversationalUnimpeachablyClass demiowlUnimpeachablyClass disdiapasonUnimpeachablyClass ectorhinalUnimpeachablyClass gamblesomenessUnimpeachablyClass homocercUnimpeachablyClass irrorateUnimpeachablyClass kindergarteningUnimpeachablyClass lateriticUnimpeachablyClass mespilUnimpeachablyClass misconfigurationUnimpeachablyClass nonbookishUnimpeachablyClass planometryUnimpeachablyClass quiinaUnimpeachablyClass robertUnimpeachablyClass rotUnimpeachablyClass subcinctoriumUnimpeachablyClass tussockerUnimpeachablyClass ultraproudUnimpeachablyClass unsuggestednessUnimpeachablyClass) =
        object $ foldMap (maybe [] pure)
        [ ("acerin" .=) <$> acerinUnimpeachablyClass
        , ("Bobadil" .=) <$> bobadilUnimpeachablyClass
        , ("catharticalness" .=) <$> catharticalnessUnimpeachablyClass
        , ("Chirotherium" .=) <$> chirotheriumUnimpeachablyClass
        , ("chlorophylligenous" .=) <$> chlorophylligenousUnimpeachablyClass
        , ("conversational" .=) <$> conversationalUnimpeachablyClass
        , ("demiowl" .=) <$> demiowlUnimpeachablyClass
        , ("disdiapason" .=) <$> disdiapasonUnimpeachablyClass
        , ("ectorhinal" .=) <$> ectorhinalUnimpeachablyClass
        , ("gamblesomeness" .=) <$> gamblesomenessUnimpeachablyClass
        , ("homocerc" .=) <$> homocercUnimpeachablyClass
        , ("irrorate" .=) <$> irrorateUnimpeachablyClass
        , ("kindergartening" .=) <$> kindergarteningUnimpeachablyClass
        , ("lateritic" .=) <$> lateriticUnimpeachablyClass
        , ("mespil" .=) <$> mespilUnimpeachablyClass
        , ("misconfiguration" .=) <$> misconfigurationUnimpeachablyClass
        , ("nonbookish" .=) <$> nonbookishUnimpeachablyClass
        , ("planometry" .=) <$> planometryUnimpeachablyClass
        , ("Quiina" .=) <$> quiinaUnimpeachablyClass
        , ("Robert" .=) <$> robertUnimpeachablyClass
        , ("rot" .=) <$> rotUnimpeachablyClass
        , ("subcinctorium" .=) <$> subcinctoriumUnimpeachablyClass
        , ("tussocker" .=) <$> tussockerUnimpeachablyClass
        , ("ultraproud" .=) <$> ultraproudUnimpeachablyClass
        , ("unsuggestedness" .=) <$> unsuggestednessUnimpeachablyClass
        ]

instance FromJSON UnimpeachablyClass where
    parseJSON (Object v) = UnimpeachablyClass
        <$> v .:! "acerin"
        <*> v .:! "Bobadil"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "chlorophylligenous"
        <*> v .:! "conversational"
        <*> v .:! "demiowl"
        <*> v .:! "disdiapason"
        <*> v .:! "ectorhinal"
        <*> v .:! "gamblesomeness"
        <*> v .:! "homocerc"
        <*> v .:! "irrorate"
        <*> v .:! "kindergartening"
        <*> v .:! "lateritic"
        <*> v .:! "mespil"
        <*> v .:! "misconfiguration"
        <*> v .:! "nonbookish"
        <*> v .:! "planometry"
        <*> v .:! "Quiina"
        <*> v .:! "Robert"
        <*> v .:! "rot"
        <*> v .:! "subcinctorium"
        <*> v .:! "tussocker"
        <*> v .:! "ultraproud"
        <*> v .:! "unsuggestedness"

instance ToJSON Unmortgaged where
    toJSON (DoubleInUnmortgaged x) = toJSON x
    toJSON (IntegerMapInUnmortgaged x) = toJSON x
    toJSON NullInUnmortgaged = Null

instance FromJSON Unmortgaged where
    parseJSON xs@(Number _) = (fmap DoubleInUnmortgaged . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInUnmortgaged . parseJSON) xs
    parseJSON Null = return NullInUnmortgaged

instance ToJSON Unobstructed where
    toJSON (IntegerInUnobstructed x) = toJSON x
    toJSON NullInUnobstructed = Null
    toJSON (QuebrachineClassInUnobstructed x) = toJSON x

instance FromJSON Unobstructed where
    parseJSON xs@(Number _) = (fmap IntegerInUnobstructed . parseJSON) xs
    parseJSON Null = return NullInUnobstructed
    parseJSON xs@(Object _) = (fmap QuebrachineClassInUnobstructed . parseJSON) xs

instance ToJSON Unreceptivity where
    toJSON (IntegerInUnreceptivity x) = toJSON x
    toJSON (NullArrayInUnreceptivity x) = toJSON x
    toJSON (StringInUnreceptivity x) = toJSON x

instance FromJSON Unreceptivity where
    parseJSON xs@(Number _) = (fmap IntegerInUnreceptivity . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInUnreceptivity . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnreceptivity . parseJSON) xs

instance ToJSON Unsatisfactoriness where
    toJSON (BoolInUnsatisfactoriness x) = toJSON x
    toJSON (IntegerArrayInUnsatisfactoriness x) = toJSON x
    toJSON (IntegerInUnsatisfactoriness x) = toJSON x

instance FromJSON Unsatisfactoriness where
    parseJSON xs@(Bool _) = (fmap BoolInUnsatisfactoriness . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInUnsatisfactoriness . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInUnsatisfactoriness . parseJSON) xs

instance ToJSON UnstressedElement where
    toJSON (BoolInUnstressedElement x) = toJSON x
    toJSON (StringInUnstressedElement x) = toJSON x
    toJSON (UnstressedClassInUnstressedElement x) = toJSON x

instance FromJSON UnstressedElement where
    parseJSON xs@(Bool _) = (fmap BoolInUnstressedElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnstressedElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnstressedClassInUnstressedElement . parseJSON) xs

instance ToJSON UnstressedClass where
    toJSON (UnstressedClass alainUnstressedClass amphirhinaUnstressedClass antimachineryUnstressedClass coldishUnstressedClass crantaraUnstressedClass distinguishingUnstressedClass elytroposisUnstressedClass gentianwortUnstressedClass heliosisUnstressedClass instrumentalUnstressedClass introinflectionUnstressedClass kalaUnstressedClass lincolnianUnstressedClass metadUnstressedClass sarcophilusUnstressedClass swinginglyUnstressedClass unconformityUnstressedClass undecreedUnstressedClass venerableUnstressedClass vowellessnessUnstressedClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Alain" .= alainUnstressedClass
        , Just $ "Amphirhina" .= amphirhinaUnstressedClass
        , Just $ "antimachinery" .= antimachineryUnstressedClass
        , Just $ "coldish" .= coldishUnstressedClass
        , Just $ "crantara" .= crantaraUnstressedClass
        , Just $ "distinguishing" .= distinguishingUnstressedClass
        , Just $ "elytroposis" .= elytroposisUnstressedClass
        , Just $ "gentianwort" .= gentianwortUnstressedClass
        , Just $ "heliosis" .= heliosisUnstressedClass
        , Just $ "instrumental" .= instrumentalUnstressedClass
        , Just $ "introinflection" .= introinflectionUnstressedClass
        , Just $ "kala" .= kalaUnstressedClass
        , Just $ "Lincolnian" .= lincolnianUnstressedClass
        , Just $ "metad" .= metadUnstressedClass
        , Just $ "Sarcophilus" .= sarcophilusUnstressedClass
        , Just $ "swingingly" .= swinginglyUnstressedClass
        , Just $ "unconformity" .= unconformityUnstressedClass
        , Just $ "undecreed" .= undecreedUnstressedClass
        , Just $ "venerable" .= venerableUnstressedClass
        , Just $ "vowellessness" .= vowellessnessUnstressedClass
        ]

instance FromJSON UnstressedClass where
    parseJSON (Object v) = UnstressedClass
        <$> v .: "Alain"
        <*> v .: "Amphirhina"
        <*> v .: "antimachinery"
        <*> v .: "coldish"
        <*> v .: "crantara"
        <*> v .: "distinguishing"
        <*> v .: "elytroposis"
        <*> v .: "gentianwort"
        <*> v .: "heliosis"
        <*> v .: "instrumental"
        <*> v .: "introinflection"
        <*> v .: "kala"
        <*> v .: "Lincolnian"
        <*> v .: "metad"
        <*> v .: "Sarcophilus"
        <*> v .: "swingingly"
        <*> v .: "unconformity"
        <*> v .: "undecreed"
        <*> v .: "venerable"
        <*> v .: "vowellessness"

instance ToJSON Untasked where
    toJSON (DoubleInUntasked x) = toJSON x
    toJSON (IntegerMapInUntasked x) = toJSON x
    toJSON (NullArrayInUntasked x) = toJSON x

instance FromJSON Untasked where
    parseJSON xs@(Number _) = (fmap DoubleInUntasked . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInUntasked . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInUntasked . parseJSON) xs

instance ToJSON Unvarying where
    toJSON (BoolInUnvarying x) = toJSON x
    toJSON (DoubleInUnvarying x) = toJSON x
    toJSON (IntegerMapInUnvarying x) = toJSON x

instance FromJSON Unvarying where
    parseJSON xs@(Bool _) = (fmap BoolInUnvarying . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnvarying . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInUnvarying . parseJSON) xs

instance ToJSON Vehemently where
    toJSON (BoolInVehemently x) = toJSON x
    toJSON (NullArrayInVehemently x) = toJSON x
    toJSON NullInVehemently = Null

instance FromJSON Vehemently where
    parseJSON xs@(Bool _) = (fmap BoolInVehemently . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInVehemently . parseJSON) xs
    parseJSON Null = return NullInVehemently

instance ToJSON Whitepot where
    toJSON (DoubleInWhitepot x) = toJSON x
    toJSON (QuebrachineClassInWhitepot x) = toJSON x

instance FromJSON Whitepot where
    parseJSON xs@(Number _) = (fmap DoubleInWhitepot . parseJSON) xs
    parseJSON xs@(Object _) = (fmap QuebrachineClassInWhitepot . parseJSON) xs

instance ToJSON WrothyElement where
    toJSON (NullArrayInWrothyElement x) = toJSON x
    toJSON (WrothyClassInWrothyElement x) = toJSON x

instance FromJSON WrothyElement where
    parseJSON xs@(Array _) = (fmap NullArrayInWrothyElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap WrothyClassInWrothyElement . parseJSON) xs

instance ToJSON WrothyClass where
    toJSON (WrothyClass aeschynanthusWrothyClass aquiferousWrothyClass cheapenerWrothyClass enumerationWrothyClass ephesineWrothyClass escadrilleWrothyClass estrousWrothyClass interestedlyWrothyClass katakinetomerWrothyClass mortificationWrothyClass morulaWrothyClass orthosymmetricalWrothyClass overbarkWrothyClass politistWrothyClass sphenomalarWrothyClass throatfulWrothyClass transhumanceWrothyClass triandrianWrothyClass unbookedWrothyClass wrothyQualifiedWrothyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Aeschynanthus" .= aeschynanthusWrothyClass
        , Just $ "aquiferous" .= aquiferousWrothyClass
        , Just $ "cheapener" .= cheapenerWrothyClass
        , Just $ "enumeration" .= enumerationWrothyClass
        , Just $ "Ephesine" .= ephesineWrothyClass
        , Just $ "escadrille" .= escadrilleWrothyClass
        , Just $ "estrous" .= estrousWrothyClass
        , Just $ "interestedly" .= interestedlyWrothyClass
        , Just $ "katakinetomer" .= katakinetomerWrothyClass
        , Just $ "mortification" .= mortificationWrothyClass
        , Just $ "morula" .= morulaWrothyClass
        , Just $ "orthosymmetrical" .= orthosymmetricalWrothyClass
        , Just $ "overbark" .= overbarkWrothyClass
        , Just $ "politist" .= politistWrothyClass
        , Just $ "sphenomalar" .= sphenomalarWrothyClass
        , Just $ "throatful" .= throatfulWrothyClass
        , Just $ "transhumance" .= transhumanceWrothyClass
        , Just $ "triandrian" .= triandrianWrothyClass
        , Just $ "unbooked" .= unbookedWrothyClass
        , Just $ "qualified" .= wrothyQualifiedWrothyClass
        ]

instance FromJSON WrothyClass where
    parseJSON (Object v) = WrothyClass
        <$> v .: "Aeschynanthus"
        <*> v .: "aquiferous"
        <*> v .: "cheapener"
        <*> v .: "enumeration"
        <*> v .: "Ephesine"
        <*> v .: "escadrille"
        <*> v .: "estrous"
        <*> v .: "interestedly"
        <*> v .: "katakinetomer"
        <*> v .: "mortification"
        <*> v .: "morula"
        <*> v .: "orthosymmetrical"
        <*> v .: "overbark"
        <*> v .: "politist"
        <*> v .: "sphenomalar"
        <*> v .: "throatful"
        <*> v .: "transhumance"
        <*> v .: "triandrian"
        <*> v .: "unbooked"
        <*> v .: "qualified"
