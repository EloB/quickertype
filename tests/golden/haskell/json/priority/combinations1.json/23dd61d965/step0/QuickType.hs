{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , CerographClass (..)
    , ChemotherapeuticClass (..)
    , CimeliaClass (..)
    , CoadjustClass (..)
    , CredulityClass (..)
    , DeruralizeClass (..)
    , DiaereseClass (..)
    , Encrust (..)
    , FagginglyClass (..)
    , FenkClass (..)
    , FlagmakingClass (..)
    , HemocoeleClass (..)
    , Interacinar (..)
    , CerographElement (..)
    , ChemotherapeuticElement (..)
    , CimeliaElement (..)
    , Clinodome (..)
    , CoadjustElement (..)
    , Consilience (..)
    , Constructor (..)
    , Continuative (..)
    , CredulityElement (..)
    , Creviced (..)
    , DeruralizeElement (..)
    , DiaereseElement (..)
    , Downstroke (..)
    , Eleutheromania (..)
    , Entomoid (..)
    , Epipaleolithic (..)
    , Expropriable (..)
    , FagginglyElement (..)
    , FenkElement (..)
    , FlagmakingElement (..)
    , Fluorometer (..)
    , Fuzzy (..)
    , Gardenward (..)
    , Generalissimo (..)
    , Hemicrystalline (..)
    , HemocoeleElement (..)
    , Hoister (..)
    , Hyperpiesi (..)
    , Hyppish (..)
    , Idealizer (..)
    , Incrustator (..)
    , Intentiveness (..)
    , Jacutinga (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { centrodesmoseQuickType :: Text
    , cerographQuickType :: [CerographElement]
    , chemotherapeuticsQuickType :: [ChemotherapeuticElement]
    , cimeliaQuickType :: [CimeliaElement]
    , citratedQuickType :: Int
    , clinodomeQuickType :: [Clinodome]
    , coadjustQuickType :: [CoadjustElement]
    , consilienceQuickType :: [Consilience]
    , constructorQuickType :: [Constructor]
    , continuativeQuickType :: [Continuative]
    , credulityQuickType :: [CredulityElement]
    , crevicedQuickType :: [Creviced]
    , cubiculumQuickType :: [([(Maybe Int)])]
    , deruralizeQuickType :: [DeruralizeElement]
    , diaeresesQuickType :: [DiaereseElement]
    , dissolutionQuickType :: [(Maybe ([(Maybe Text)]))]
    , downstrokeQuickType :: [Downstroke]
    , electrotautomerismQuickType :: [(Maybe Double)]
    , eleutheromaniaQuickType :: [Eleutheromania]
    , encrustQuickType :: Encrust
    , entomoidQuickType :: [Entomoid]
    , epipaleolithicQuickType :: [Epipaleolithic]
    , expropriableQuickType :: [Expropriable]
    , fagginglyQuickType :: [FagginglyElement]
    , fenksQuickType :: [FenkElement]
    , flagmakingQuickType :: [FlagmakingElement]
    , fluorometerQuickType :: [Fluorometer]
    , fulsomeQuickType :: [(Maybe Int)]
    , fuzzyQuickType :: [Fuzzy]
    , gardenwardsQuickType :: [Gardenward]
    , generalissimoQuickType :: [Generalissimo]
    , habeasQuickType :: [(Maybe (HashMap Text Int))]
    , hemicrystallineQuickType :: [Hemicrystalline]
    , hemocoeleQuickType :: [HemocoeleElement]
    , hoisterQuickType :: [Hoister]
    , hyperpiesisQuickType :: [Hyperpiesi]
    , hyppishQuickType :: [Hyppish]
    , idealizerQuickType :: [Idealizer]
    , incrustatorQuickType :: [Incrustator]
    , intentivenessQuickType :: [Intentiveness]
    , interacinarQuickType :: Interacinar
    , intercorrelationQuickType :: [(Maybe ([Int]))]
    , jacutingaQuickType :: [Jacutinga]
    } deriving (Show)

data CerographElement
    = CerographClassInCerographElement CerographClass
    | NullInCerographElement
    | StringInCerographElement Text
    deriving (Show)

data CerographClass = CerographClass
    { apotropaionCerographClass :: Maybe Text
    , casuaryCerographClass :: Maybe Text
    , creakerCerographClass :: Maybe Text
    , disqualificationCerographClass :: Maybe Text
    , imperatoriousCerographClass :: Maybe Text
    , impermeabilizeCerographClass :: Maybe Text
    , metastomaCerographClass :: Maybe Text
    , noctidiurnalCerographClass :: Maybe Text
    , nonreserveCerographClass :: Maybe Text
    , ophthalmotonometryCerographClass :: Maybe Text
    , pailfulCerographClass :: Maybe Text
    , pigfishCerographClass :: Maybe Text
    , pongeeCerographClass :: Maybe Text
    , prosodicalCerographClass :: Maybe Text
    , scrofulodermCerographClass :: Maybe Text
    , storekeepingCerographClass :: Maybe Text
    , therologistCerographClass :: Maybe Text
    , tolowaCerographClass :: Maybe Text
    , tradefulCerographClass :: Maybe Text
    , unrivetingCerographClass :: Maybe Text
    } deriving (Show)

data ChemotherapeuticElement
    = ChemotherapeuticClassInChemotherapeuticElement ChemotherapeuticClass
    | IntegerInChemotherapeuticElement Int
    deriving (Show)

data ChemotherapeuticClass = ChemotherapeuticClass
    { angioneuroticChemotherapeuticClass :: Maybe (Maybe Text)
    , availmentChemotherapeuticClass :: Maybe (Maybe Text)
    , bladeletChemotherapeuticClass :: Maybe (Maybe Text)
    , catharticalnessChemotherapeuticClass :: Maybe Double
    , caulisChemotherapeuticClass :: Maybe (Maybe Text)
    , chalcusChemotherapeuticClass :: Maybe (Maybe Text)
    , chirotheriumChemotherapeuticClass :: Maybe Int
    , disdiapasonChemotherapeuticClass :: Maybe Text
    , enteradenologicalChemotherapeuticClass :: Maybe (Maybe Text)
    , homocercChemotherapeuticClass :: Maybe Bool
    , imporosityChemotherapeuticClass :: Maybe (Maybe Text)
    , insistentlyChemotherapeuticClass :: Maybe (Maybe Text)
    , intraparietalChemotherapeuticClass :: Maybe (Maybe Text)
    , iviedChemotherapeuticClass :: Maybe (Maybe Text)
    , maureenChemotherapeuticClass :: Maybe (Maybe Text)
    , nonbookishChemotherapeuticClass :: Maybe (Maybe Text)
    , nostochineChemotherapeuticClass :: Maybe (Maybe Text)
    , nutcrackerChemotherapeuticClass :: Maybe (Maybe Text)
    , ofttimesChemotherapeuticClass :: Maybe (Maybe Text)
    , phenocrystChemotherapeuticClass :: Maybe (Maybe Text)
    , precoincidentChemotherapeuticClass :: Maybe (Maybe Text)
    , ramiferousChemotherapeuticClass :: Maybe (Maybe Text)
    , stagmometerChemotherapeuticClass :: Maybe (Maybe Text)
    , tetherballChemotherapeuticClass :: Maybe (Maybe Text)
    , unshyChemotherapeuticClass :: Maybe (Maybe Text)
    } deriving (Show)

data CimeliaElement
    = CimeliaClassInCimeliaElement CimeliaClass
    | IntegerArrayInCimeliaElement ([Int])
    | NullInCimeliaElement
    deriving (Show)

data CimeliaClass = CimeliaClass
    { catharticalnessCimeliaClass :: Double
    , chirotheriumCimeliaClass :: Int
    , disdiapasonCimeliaClass :: Text
    , homocercCimeliaClass :: Bool
    , nonbookishCimeliaClass :: Maybe Text
    } deriving (Show)

data Clinodome
    = DoubleInClinodome Double
    | StringInClinodome Text
    deriving (Show)

data CoadjustElement
    = CoadjustClassInCoadjustElement CoadjustClass
    | DoubleInCoadjustElement Double
    deriving (Show)

data CoadjustClass = CoadjustClass
    { amidosulphonalCoadjustClass :: Maybe (Maybe Text)
    , bennyCoadjustClass :: Maybe (Maybe Text)
    , catharticalnessCoadjustClass :: Maybe Double
    , chirotheriumCoadjustClass :: Maybe Int
    , disdiapasonCoadjustClass :: Maybe Text
    , ensnareCoadjustClass :: Maybe (Maybe Text)
    , homocercCoadjustClass :: Maybe Bool
    , hybridizerCoadjustClass :: Maybe (Maybe Text)
    , leastwiseCoadjustClass :: Maybe (Maybe Text)
    , lofCoadjustClass :: Maybe (Maybe Text)
    , monkhoodCoadjustClass :: Maybe (Maybe Text)
    , netherlandishCoadjustClass :: Maybe (Maybe Text)
    , nonbookishCoadjustClass :: Maybe (Maybe Text)
    , peonismCoadjustClass :: Maybe (Maybe Text)
    , phonelescopeCoadjustClass :: Maybe (Maybe Text)
    , porphyrogenitureCoadjustClass :: Maybe (Maybe Text)
    , preindemnifyCoadjustClass :: Maybe (Maybe Text)
    , rosalCoadjustClass :: Maybe (Maybe Text)
    , scalenousCoadjustClass :: Maybe (Maybe Text)
    , scopineCoadjustClass :: Maybe (Maybe Text)
    , sedaceaeCoadjustClass :: Maybe (Maybe Text)
    , suberinizeCoadjustClass :: Maybe (Maybe Text)
    , symbiotCoadjustClass :: Maybe (Maybe Text)
    , tablefellowCoadjustClass :: Maybe (Maybe Text)
    , unchargeableCoadjustClass :: Maybe (Maybe Text)
    } deriving (Show)

data Consilience
    = DoubleInConsilience Double
    | IntegerMapInConsilience (HashMap Text Int)
    deriving (Show)

data Constructor
    = BoolInConstructor Bool
    | UnionMapInConstructor (HashMap Text (Maybe Int))
    deriving (Show)

data Continuative
    = IntegerMapInContinuative (HashMap Text Int)
    | StringInContinuative Text
    deriving (Show)

data CredulityElement
    = CredulityClassInCredulityElement CredulityClass
    | IntegerInCredulityElement Int
    | StringInCredulityElement Text
    deriving (Show)

data CredulityClass = CredulityClass
    { ammonolyticCredulityClass :: Maybe Text
    , bushmasterCredulityClass :: Maybe Text
    , consideringCredulityClass :: Maybe Text
    , consuetudinaryCredulityClass :: Maybe Text
    , embarrasCredulityClass :: Maybe Text
    , finenessCredulityClass :: Maybe Text
    , flaithshipCredulityClass :: Maybe Text
    , flaviaCredulityClass :: Maybe Text
    , grufflyCredulityClass :: Maybe Text
    , hedychiumCredulityClass :: Maybe Text
    , leadwortCredulityClass :: Maybe Text
    , overseriouslyCredulityClass :: Maybe Text
    , parabolaCredulityClass :: Maybe Text
    , pectinatodenticulateCredulityClass :: Maybe Text
    , popeanCredulityClass :: Maybe Text
    , pornocratCredulityClass :: Maybe Text
    , quadrisectCredulityClass :: Maybe Text
    , serialityCredulityClass :: Maybe Text
    , vamphornCredulityClass :: Maybe Text
    , wharpCredulityClass :: Maybe Text
    } deriving (Show)

data Creviced
    = BoolInCreviced Bool
    | IntegerMapInCreviced (HashMap Text Int)
    | StringInCreviced Text
    deriving (Show)

data DeruralizeElement
    = BoolInDeruralizeElement Bool
    | DeruralizeClassInDeruralizeElement DeruralizeClass
    | NullArrayInDeruralizeElement ([(Maybe Text)])
    deriving (Show)

data DeruralizeClass = DeruralizeClass
    { bockerelDeruralizeClass :: Maybe Text
    , boulderDeruralizeClass :: Maybe Text
    , churrusDeruralizeClass :: Maybe Text
    , counterdiggedDeruralizeClass :: Maybe Text
    , dialogiteDeruralizeClass :: Maybe Text
    , digenicDeruralizeClass :: Maybe Text
    , dunbirdDeruralizeClass :: Maybe Text
    , ergatogyneDeruralizeClass :: Maybe Text
    , fiendfulDeruralizeClass :: Maybe Text
    , jackrodDeruralizeClass :: Maybe Text
    , jehovisticDeruralizeClass :: Maybe Text
    , panineanDeruralizeClass :: Maybe Text
    , pantherDeruralizeClass :: Maybe Text
    , placentigerousDeruralizeClass :: Maybe Text
    , romneyDeruralizeClass :: Maybe Text
    , sparmDeruralizeClass :: Maybe Text
    , tocsinDeruralizeClass :: Maybe Text
    , unnickedDeruralizeClass :: Maybe Text
    , unstavableDeruralizeClass :: Maybe Text
    , windfirmDeruralizeClass :: Maybe Text
    } deriving (Show)

data DiaereseElement
    = BoolInDiaereseElement Bool
    | DiaereseClassInDiaereseElement DiaereseClass
    | IntegerArrayInDiaereseElement ([Int])
    deriving (Show)

data DiaereseClass = DiaereseClass
    { amoreuxiaDiaereseClass :: Maybe Text
    , aniDiaereseClass :: Maybe Text
    , bernicleDiaereseClass :: Maybe Text
    , blackwasherDiaereseClass :: Maybe Text
    , blowhardDiaereseClass :: Maybe Text
    , bromaDiaereseClass :: Maybe Text
    , closecrossDiaereseClass :: Maybe Text
    , congregationalismDiaereseClass :: Maybe Text
    , graylyDiaereseClass :: Maybe Text
    , historicallyDiaereseClass :: Maybe Text
    , hoastDiaereseClass :: Maybe Text
    , irretentiveDiaereseClass :: Maybe Text
    , parcenerDiaereseClass :: Maybe Text
    , pedderDiaereseClass :: Maybe Text
    , pseudoanatomicDiaereseClass :: Maybe Text
    , rhizocarpianDiaereseClass :: Maybe Text
    , samelDiaereseClass :: Maybe Text
    , silkerDiaereseClass :: Maybe Text
    , subdentatedDiaereseClass :: Maybe Text
    , subobscureDiaereseClass :: Maybe Text
    } deriving (Show)

data Downstroke
    = BoolInDownstroke Bool
    | NullArrayInDownstroke ([(Maybe Text)])
    | StringInDownstroke Text
    deriving (Show)

data Eleutheromania
    = DoubleInEleutheromania Double
    | IntegerMapInEleutheromania (HashMap Text Int)
    | StringInEleutheromania Text
    deriving (Show)

data Encrust = Encrust
    { comradelyEncrust :: Maybe Text
    , diacanthousEncrust :: Maybe Text
    , femininenessEncrust :: Maybe Text
    , gossameredEncrust :: Maybe Text
    , hiberniaEncrust :: Maybe Text
    , hibiscusEncrust :: Maybe Text
    , lepidosauriaEncrust :: Maybe Text
    , lollinglyEncrust :: Maybe Text
    , managerEncrust :: Maybe Text
    , mechanicEncrust :: Maybe Text
    , overminutenessEncrust :: Maybe Text
    , papelonneEncrust :: Maybe Text
    , plebificationEncrust :: Maybe Text
    , pugmillerEncrust :: Maybe Text
    , recoverorEncrust :: Maybe Text
    , spermatoblasticEncrust :: Maybe Text
    , syllidaeEncrust :: Maybe Text
    , ungyvedEncrust :: Maybe Text
    , whirlaboutEncrust :: Maybe Text
    , woodenwareEncrust :: Maybe Text
    } deriving (Show)

data Entomoid
    = CimeliaClassInEntomoid CimeliaClass
    | IntegerInEntomoid Int
    deriving (Show)

data Epipaleolithic
    = DoubleInEpipaleolithic Double
    | IntegerArrayInEpipaleolithic ([Int])
    deriving (Show)

data Expropriable
    = CimeliaClassInExpropriable CimeliaClass
    | DoubleInExpropriable Double
    | NullArrayInExpropriable ([(Maybe Text)])
    deriving (Show)

data FagginglyElement
    = DoubleInFagginglyElement Double
    | FagginglyClassInFagginglyElement FagginglyClass
    deriving (Show)

data FagginglyClass = FagginglyClass
    { abranchianFagginglyClass :: Maybe Text
    , aculeiformFagginglyClass :: Maybe Text
    , adiaphoristicFagginglyClass :: Maybe Text
    , adoptionismFagginglyClass :: Maybe Text
    , anglicFagginglyClass :: Maybe Text
    , antrotomyFagginglyClass :: Maybe Text
    , coercivenessFagginglyClass :: Maybe Text
    , decoristFagginglyClass :: Maybe Text
    , duckhoodFagginglyClass :: Maybe Text
    , heteromeriFagginglyClass :: Maybe Text
    , hypochnoseFagginglyClass :: Maybe Text
    , lochageFagginglyClass :: Maybe Text
    , meleeFagginglyClass :: Maybe Text
    , nonconformitantFagginglyClass :: Maybe Text
    , poinsettiaFagginglyClass :: Maybe Text
    , putativelyFagginglyClass :: Maybe Text
    , semivolatileFagginglyClass :: Maybe Text
    , soleasFagginglyClass :: Maybe Text
    , unfastenableFagginglyClass :: Maybe Text
    , unmillineredFagginglyClass :: Maybe Text
    } deriving (Show)

data FenkElement
    = FenkClassInFenkElement FenkClass
    | StringInFenkElement Text
    deriving (Show)

data FenkClass = FenkClass
    { apoiseFenkClass :: Maybe Text
    , astronomizeFenkClass :: Maybe Text
    , cockhorseFenkClass :: Maybe Text
    , copularFenkClass :: Maybe Text
    , dagombaFenkClass :: Maybe Text
    , draffyFenkClass :: Maybe Text
    , foreignerFenkClass :: Maybe Text
    , guyandotFenkClass :: Maybe Text
    , neurogliosisFenkClass :: Maybe Text
    , osmiousFenkClass :: Maybe Text
    , palpitateFenkClass :: Maybe Text
    , rebukeableFenkClass :: Maybe Text
    , reinwardtiaFenkClass :: Maybe Text
    , reservatoryFenkClass :: Maybe Text
    , scaltFenkClass :: Maybe Text
    , scripturalizeFenkClass :: Maybe Text
    , tintometerFenkClass :: Maybe Text
    , tritonessFenkClass :: Maybe Text
    , undergradeFenkClass :: Maybe Text
    , undermountainFenkClass :: Maybe Text
    } deriving (Show)

data FlagmakingElement
    = BoolInFlagmakingElement Bool
    | DoubleInFlagmakingElement Double
    | FlagmakingClassInFlagmakingElement FlagmakingClass
    deriving (Show)

data FlagmakingClass = FlagmakingClass
    { albarcoFlagmakingClass :: Maybe Text
    , bunodontaFlagmakingClass :: Maybe Text
    , hornifyFlagmakingClass :: Maybe Text
    , hydrocorisaeFlagmakingClass :: Maybe Text
    , hypoglossusFlagmakingClass :: Maybe Text
    , inexpiablyFlagmakingClass :: Maybe Text
    , ingratitudeFlagmakingClass :: Maybe Text
    , ladyflyFlagmakingClass :: Maybe Text
    , medicamentFlagmakingClass :: Maybe Text
    , monogrammaticFlagmakingClass :: Maybe Text
    , nobbutFlagmakingClass :: Maybe Text
    , notacanthidaeFlagmakingClass :: Maybe Text
    , polyplacophoreFlagmakingClass :: Maybe Text
    , proexerciseFlagmakingClass :: Maybe Text
    , protoplastFlagmakingClass :: Maybe Text
    , puzzlingFlagmakingClass :: Maybe Text
    , splanchnoskeletonFlagmakingClass :: Maybe Text
    , unlovelinessFlagmakingClass :: Maybe Text
    , unquarantinedFlagmakingClass :: Maybe Text
    , unrenounceableFlagmakingClass :: Maybe Text
    } deriving (Show)

data Fluorometer
    = IntegerInFluorometer Int
    | NullInFluorometer
    | StringInFluorometer Text
    deriving (Show)

data Fuzzy
    = IntegerInFuzzy Int
    | UnionMapInFuzzy (HashMap Text (Maybe Int))
    deriving (Show)

data Gardenward
    = BoolInGardenward Bool
    | IntegerArrayInGardenward ([Int])
    | StringInGardenward Text
    deriving (Show)

data Generalissimo
    = BoolInGeneralissimo Bool
    | IntegerMapInGeneralissimo (HashMap Text Int)
    | NullInGeneralissimo
    deriving (Show)

data Hemicrystalline
    = CimeliaClassInHemicrystalline CimeliaClass
    | StringInHemicrystalline Text
    deriving (Show)

data HemocoeleElement
    = HemocoeleClassInHemocoeleElement HemocoeleClass
    | IntegerArrayInHemocoeleElement ([Int])
    deriving (Show)

data HemocoeleClass = HemocoeleClass
    { acrogamyHemocoeleClass :: Maybe (Maybe Text)
    , amelificationHemocoeleClass :: Maybe (Maybe Text)
    , autobiographicHemocoeleClass :: Maybe (Maybe Text)
    , beratHemocoeleClass :: Maybe (Maybe Text)
    , catharticalnessHemocoeleClass :: Maybe Double
    , chirotheriumHemocoeleClass :: Maybe Int
    , disdiapasonHemocoeleClass :: Maybe Text
    , disproportionablyHemocoeleClass :: Maybe (Maybe Text)
    , erythriteHemocoeleClass :: Maybe (Maybe Text)
    , graphicHemocoeleClass :: Maybe (Maybe Text)
    , hepatologicalHemocoeleClass :: Maybe (Maybe Text)
    , homocercHemocoeleClass :: Maybe Bool
    , incommensurablyHemocoeleClass :: Maybe (Maybe Text)
    , misaffirmHemocoeleClass :: Maybe (Maybe Text)
    , nonbookishHemocoeleClass :: Maybe (Maybe Text)
    , pocketbookHemocoeleClass :: Maybe (Maybe Text)
    , sclerometricHemocoeleClass :: Maybe (Maybe Text)
    , stamboulineHemocoeleClass :: Maybe (Maybe Text)
    , stickpinHemocoeleClass :: Maybe (Maybe Text)
    , tubulureHemocoeleClass :: Maybe (Maybe Text)
    , undelatedHemocoeleClass :: Maybe (Maybe Text)
    , unsaltHemocoeleClass :: Maybe (Maybe Text)
    , untutelarHemocoeleClass :: Maybe (Maybe Text)
    , vagrantHemocoeleClass :: Maybe (Maybe Text)
    , waltHemocoeleClass :: Maybe (Maybe Text)
    } deriving (Show)

data Hoister
    = CimeliaClassInHoister CimeliaClass
    | NullInHoister
    | StringInHoister Text
    deriving (Show)

data Hyperpiesi
    = CimeliaClassInHyperpiesi CimeliaClass
    | NullArrayInHyperpiesi ([(Maybe Text)])
    | NullInHyperpiesi
    deriving (Show)

data Hyppish
    = BoolInHyppish Bool
    | NullInHyppish
    | StringInHyppish Text
    deriving (Show)

data Idealizer
    = CimeliaClassInIdealizer CimeliaClass
    | IntegerInIdealizer Int
    | NullArrayInIdealizer ([(Maybe Text)])
    deriving (Show)

data Incrustator
    = IntegerArrayInIncrustator ([Int])
    | IntegerInIncrustator Int
    | StringInIncrustator Text
    deriving (Show)

data Intentiveness
    = CimeliaClassInIntentiveness CimeliaClass
    | DoubleInIntentiveness Double
    | StringInIntentiveness Text
    deriving (Show)

data Interacinar = Interacinar
    { assapanInteracinar :: Double
    , benefactorshipInteracinar :: Bool
    , triseriatimInteracinar :: Text
    , tubbingInteracinar :: Int
    , untrimmedInteracinar :: Maybe Text
    } deriving (Show)

data Jacutinga
    = IntegerArrayInJacutinga ([Int])
    | UnionMapInJacutinga (HashMap Text (Maybe Int))
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType centrodesmoseQuickType cerographQuickType chemotherapeuticsQuickType cimeliaQuickType citratedQuickType clinodomeQuickType coadjustQuickType consilienceQuickType constructorQuickType continuativeQuickType credulityQuickType crevicedQuickType cubiculumQuickType deruralizeQuickType diaeresesQuickType dissolutionQuickType downstrokeQuickType electrotautomerismQuickType eleutheromaniaQuickType encrustQuickType entomoidQuickType epipaleolithicQuickType expropriableQuickType fagginglyQuickType fenksQuickType flagmakingQuickType fluorometerQuickType fulsomeQuickType fuzzyQuickType gardenwardsQuickType generalissimoQuickType habeasQuickType hemicrystallineQuickType hemocoeleQuickType hoisterQuickType hyperpiesisQuickType hyppishQuickType idealizerQuickType incrustatorQuickType intentivenessQuickType interacinarQuickType intercorrelationQuickType jacutingaQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "centrodesmose" .= centrodesmoseQuickType
        , Just $ "cerograph" .= cerographQuickType
        , Just $ "chemotherapeutics" .= chemotherapeuticsQuickType
        , Just $ "cimelia" .= cimeliaQuickType
        , Just $ "citrated" .= citratedQuickType
        , Just $ "clinodome" .= clinodomeQuickType
        , Just $ "coadjust" .= coadjustQuickType
        , Just $ "consilience" .= consilienceQuickType
        , Just $ "constructor" .= constructorQuickType
        , Just $ "continuative" .= continuativeQuickType
        , Just $ "credulity" .= credulityQuickType
        , Just $ "creviced" .= crevicedQuickType
        , Just $ "cubiculum" .= cubiculumQuickType
        , Just $ "deruralize" .= deruralizeQuickType
        , Just $ "diaereses" .= diaeresesQuickType
        , Just $ "dissolution" .= dissolutionQuickType
        , Just $ "downstroke" .= downstrokeQuickType
        , Just $ "electrotautomerism" .= electrotautomerismQuickType
        , Just $ "eleutheromania" .= eleutheromaniaQuickType
        , Just $ "encrust" .= encrustQuickType
        , Just $ "entomoid" .= entomoidQuickType
        , Just $ "epipaleolithic" .= epipaleolithicQuickType
        , Just $ "expropriable" .= expropriableQuickType
        , Just $ "faggingly" .= fagginglyQuickType
        , Just $ "fenks" .= fenksQuickType
        , Just $ "flagmaking" .= flagmakingQuickType
        , Just $ "fluorometer" .= fluorometerQuickType
        , Just $ "fulsome" .= fulsomeQuickType
        , Just $ "fuzzy" .= fuzzyQuickType
        , Just $ "gardenwards" .= gardenwardsQuickType
        , Just $ "generalissimo" .= generalissimoQuickType
        , Just $ "habeas" .= habeasQuickType
        , Just $ "hemicrystalline" .= hemicrystallineQuickType
        , Just $ "hemocoele" .= hemocoeleQuickType
        , Just $ "hoister" .= hoisterQuickType
        , Just $ "hyperpiesis" .= hyperpiesisQuickType
        , Just $ "hyppish" .= hyppishQuickType
        , Just $ "idealizer" .= idealizerQuickType
        , Just $ "incrustator" .= incrustatorQuickType
        , Just $ "intentiveness" .= intentivenessQuickType
        , Just $ "interacinar" .= interacinarQuickType
        , Just $ "intercorrelation" .= intercorrelationQuickType
        , Just $ "jacutinga" .= jacutingaQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "centrodesmose"
        <*> v .: "cerograph"
        <*> v .: "chemotherapeutics"
        <*> v .: "cimelia"
        <*> v .: "citrated"
        <*> v .: "clinodome"
        <*> v .: "coadjust"
        <*> v .: "consilience"
        <*> v .: "constructor"
        <*> v .: "continuative"
        <*> v .: "credulity"
        <*> v .: "creviced"
        <*> v .: "cubiculum"
        <*> v .: "deruralize"
        <*> v .: "diaereses"
        <*> v .: "dissolution"
        <*> v .: "downstroke"
        <*> v .: "electrotautomerism"
        <*> v .: "eleutheromania"
        <*> v .: "encrust"
        <*> v .: "entomoid"
        <*> v .: "epipaleolithic"
        <*> v .: "expropriable"
        <*> v .: "faggingly"
        <*> v .: "fenks"
        <*> v .: "flagmaking"
        <*> v .: "fluorometer"
        <*> v .: "fulsome"
        <*> v .: "fuzzy"
        <*> v .: "gardenwards"
        <*> v .: "generalissimo"
        <*> v .: "habeas"
        <*> v .: "hemicrystalline"
        <*> v .: "hemocoele"
        <*> v .: "hoister"
        <*> v .: "hyperpiesis"
        <*> v .: "hyppish"
        <*> v .: "idealizer"
        <*> v .: "incrustator"
        <*> v .: "intentiveness"
        <*> v .: "interacinar"
        <*> v .: "intercorrelation"
        <*> v .: "jacutinga"

instance ToJSON CerographElement where
    toJSON (CerographClassInCerographElement x) = toJSON x
    toJSON NullInCerographElement = Null
    toJSON (StringInCerographElement x) = toJSON x

instance FromJSON CerographElement where
    parseJSON xs@(Object _) = (fmap CerographClassInCerographElement . parseJSON) xs
    parseJSON Null = return NullInCerographElement
    parseJSON xs@(String _) = (fmap StringInCerographElement . parseJSON) xs

instance ToJSON CerographClass where
    toJSON (CerographClass apotropaionCerographClass casuaryCerographClass creakerCerographClass disqualificationCerographClass imperatoriousCerographClass impermeabilizeCerographClass metastomaCerographClass noctidiurnalCerographClass nonreserveCerographClass ophthalmotonometryCerographClass pailfulCerographClass pigfishCerographClass pongeeCerographClass prosodicalCerographClass scrofulodermCerographClass storekeepingCerographClass therologistCerographClass tolowaCerographClass tradefulCerographClass unrivetingCerographClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "apotropaion" .= apotropaionCerographClass
        , Just $ "casuary" .= casuaryCerographClass
        , Just $ "creaker" .= creakerCerographClass
        , Just $ "disqualification" .= disqualificationCerographClass
        , Just $ "imperatorious" .= imperatoriousCerographClass
        , Just $ "impermeabilize" .= impermeabilizeCerographClass
        , Just $ "metastoma" .= metastomaCerographClass
        , Just $ "noctidiurnal" .= noctidiurnalCerographClass
        , Just $ "nonreserve" .= nonreserveCerographClass
        , Just $ "ophthalmotonometry" .= ophthalmotonometryCerographClass
        , Just $ "pailful" .= pailfulCerographClass
        , Just $ "pigfish" .= pigfishCerographClass
        , Just $ "pongee" .= pongeeCerographClass
        , Just $ "prosodical" .= prosodicalCerographClass
        , Just $ "scrofuloderm" .= scrofulodermCerographClass
        , Just $ "storekeeping" .= storekeepingCerographClass
        , Just $ "therologist" .= therologistCerographClass
        , Just $ "Tolowa" .= tolowaCerographClass
        , Just $ "tradeful" .= tradefulCerographClass
        , Just $ "unriveting" .= unrivetingCerographClass
        ]

instance FromJSON CerographClass where
    parseJSON (Object v) = CerographClass
        <$> v .: "apotropaion"
        <*> v .: "casuary"
        <*> v .: "creaker"
        <*> v .: "disqualification"
        <*> v .: "imperatorious"
        <*> v .: "impermeabilize"
        <*> v .: "metastoma"
        <*> v .: "noctidiurnal"
        <*> v .: "nonreserve"
        <*> v .: "ophthalmotonometry"
        <*> v .: "pailful"
        <*> v .: "pigfish"
        <*> v .: "pongee"
        <*> v .: "prosodical"
        <*> v .: "scrofuloderm"
        <*> v .: "storekeeping"
        <*> v .: "therologist"
        <*> v .: "Tolowa"
        <*> v .: "tradeful"
        <*> v .: "unriveting"

instance ToJSON ChemotherapeuticElement where
    toJSON (ChemotherapeuticClassInChemotherapeuticElement x) = toJSON x
    toJSON (IntegerInChemotherapeuticElement x) = toJSON x

instance FromJSON ChemotherapeuticElement where
    parseJSON xs@(Object _) = (fmap ChemotherapeuticClassInChemotherapeuticElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInChemotherapeuticElement . parseJSON) xs

instance ToJSON ChemotherapeuticClass where
    toJSON (ChemotherapeuticClass angioneuroticChemotherapeuticClass availmentChemotherapeuticClass bladeletChemotherapeuticClass catharticalnessChemotherapeuticClass caulisChemotherapeuticClass chalcusChemotherapeuticClass chirotheriumChemotherapeuticClass disdiapasonChemotherapeuticClass enteradenologicalChemotherapeuticClass homocercChemotherapeuticClass imporosityChemotherapeuticClass insistentlyChemotherapeuticClass intraparietalChemotherapeuticClass iviedChemotherapeuticClass maureenChemotherapeuticClass nonbookishChemotherapeuticClass nostochineChemotherapeuticClass nutcrackerChemotherapeuticClass ofttimesChemotherapeuticClass phenocrystChemotherapeuticClass precoincidentChemotherapeuticClass ramiferousChemotherapeuticClass stagmometerChemotherapeuticClass tetherballChemotherapeuticClass unshyChemotherapeuticClass) =
        object $ foldMap (maybe [] pure)
        [ ("angioneurotic" .=) <$> angioneuroticChemotherapeuticClass
        , ("availment" .=) <$> availmentChemotherapeuticClass
        , ("bladelet" .=) <$> bladeletChemotherapeuticClass
        , ("catharticalness" .=) <$> catharticalnessChemotherapeuticClass
        , ("caulis" .=) <$> caulisChemotherapeuticClass
        , ("chalcus" .=) <$> chalcusChemotherapeuticClass
        , ("Chirotherium" .=) <$> chirotheriumChemotherapeuticClass
        , ("disdiapason" .=) <$> disdiapasonChemotherapeuticClass
        , ("enteradenological" .=) <$> enteradenologicalChemotherapeuticClass
        , ("homocerc" .=) <$> homocercChemotherapeuticClass
        , ("imporosity" .=) <$> imporosityChemotherapeuticClass
        , ("insistently" .=) <$> insistentlyChemotherapeuticClass
        , ("intraparietal" .=) <$> intraparietalChemotherapeuticClass
        , ("ivied" .=) <$> iviedChemotherapeuticClass
        , ("Maureen" .=) <$> maureenChemotherapeuticClass
        , ("nonbookish" .=) <$> nonbookishChemotherapeuticClass
        , ("nostochine" .=) <$> nostochineChemotherapeuticClass
        , ("nutcracker" .=) <$> nutcrackerChemotherapeuticClass
        , ("ofttimes" .=) <$> ofttimesChemotherapeuticClass
        , ("phenocryst" .=) <$> phenocrystChemotherapeuticClass
        , ("precoincident" .=) <$> precoincidentChemotherapeuticClass
        , ("ramiferous" .=) <$> ramiferousChemotherapeuticClass
        , ("stagmometer" .=) <$> stagmometerChemotherapeuticClass
        , ("tetherball" .=) <$> tetherballChemotherapeuticClass
        , ("unshy" .=) <$> unshyChemotherapeuticClass
        ]

instance FromJSON ChemotherapeuticClass where
    parseJSON (Object v) = ChemotherapeuticClass
        <$> v .:! "angioneurotic"
        <*> v .:! "availment"
        <*> v .:! "bladelet"
        <*> v .:! "catharticalness"
        <*> v .:! "caulis"
        <*> v .:! "chalcus"
        <*> v .:! "Chirotherium"
        <*> v .:! "disdiapason"
        <*> v .:! "enteradenological"
        <*> v .:! "homocerc"
        <*> v .:! "imporosity"
        <*> v .:! "insistently"
        <*> v .:! "intraparietal"
        <*> v .:! "ivied"
        <*> v .:! "Maureen"
        <*> v .:! "nonbookish"
        <*> v .:! "nostochine"
        <*> v .:! "nutcracker"
        <*> v .:! "ofttimes"
        <*> v .:! "phenocryst"
        <*> v .:! "precoincident"
        <*> v .:! "ramiferous"
        <*> v .:! "stagmometer"
        <*> v .:! "tetherball"
        <*> v .:! "unshy"

instance ToJSON CimeliaElement where
    toJSON (CimeliaClassInCimeliaElement x) = toJSON x
    toJSON (IntegerArrayInCimeliaElement x) = toJSON x
    toJSON NullInCimeliaElement = Null

instance FromJSON CimeliaElement where
    parseJSON xs@(Object _) = (fmap CimeliaClassInCimeliaElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInCimeliaElement . parseJSON) xs
    parseJSON Null = return NullInCimeliaElement

instance ToJSON CimeliaClass where
    toJSON (CimeliaClass catharticalnessCimeliaClass chirotheriumCimeliaClass disdiapasonCimeliaClass homocercCimeliaClass nonbookishCimeliaClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "catharticalness" .= catharticalnessCimeliaClass
        , Just $ "Chirotherium" .= chirotheriumCimeliaClass
        , Just $ "disdiapason" .= disdiapasonCimeliaClass
        , Just $ "homocerc" .= homocercCimeliaClass
        , Just $ "nonbookish" .= nonbookishCimeliaClass
        ]

instance FromJSON CimeliaClass where
    parseJSON (Object v) = CimeliaClass
        <$> v .: "catharticalness"
        <*> v .: "Chirotherium"
        <*> v .: "disdiapason"
        <*> v .: "homocerc"
        <*> v .: "nonbookish"

instance ToJSON Clinodome where
    toJSON (DoubleInClinodome x) = toJSON x
    toJSON (StringInClinodome x) = toJSON x

instance FromJSON Clinodome where
    parseJSON xs@(Number _) = (fmap DoubleInClinodome . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInClinodome . parseJSON) xs

instance ToJSON CoadjustElement where
    toJSON (CoadjustClassInCoadjustElement x) = toJSON x
    toJSON (DoubleInCoadjustElement x) = toJSON x

instance FromJSON CoadjustElement where
    parseJSON xs@(Object _) = (fmap CoadjustClassInCoadjustElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInCoadjustElement . parseJSON) xs

instance ToJSON CoadjustClass where
    toJSON (CoadjustClass amidosulphonalCoadjustClass bennyCoadjustClass catharticalnessCoadjustClass chirotheriumCoadjustClass disdiapasonCoadjustClass ensnareCoadjustClass homocercCoadjustClass hybridizerCoadjustClass leastwiseCoadjustClass lofCoadjustClass monkhoodCoadjustClass netherlandishCoadjustClass nonbookishCoadjustClass peonismCoadjustClass phonelescopeCoadjustClass porphyrogenitureCoadjustClass preindemnifyCoadjustClass rosalCoadjustClass scalenousCoadjustClass scopineCoadjustClass sedaceaeCoadjustClass suberinizeCoadjustClass symbiotCoadjustClass tablefellowCoadjustClass unchargeableCoadjustClass) =
        object $ foldMap (maybe [] pure)
        [ ("amidosulphonal" .=) <$> amidosulphonalCoadjustClass
        , ("Benny" .=) <$> bennyCoadjustClass
        , ("catharticalness" .=) <$> catharticalnessCoadjustClass
        , ("Chirotherium" .=) <$> chirotheriumCoadjustClass
        , ("disdiapason" .=) <$> disdiapasonCoadjustClass
        , ("ensnare" .=) <$> ensnareCoadjustClass
        , ("homocerc" .=) <$> homocercCoadjustClass
        , ("hybridizer" .=) <$> hybridizerCoadjustClass
        , ("leastwise" .=) <$> leastwiseCoadjustClass
        , ("lof" .=) <$> lofCoadjustClass
        , ("monkhood" .=) <$> monkhoodCoadjustClass
        , ("Netherlandish" .=) <$> netherlandishCoadjustClass
        , ("nonbookish" .=) <$> nonbookishCoadjustClass
        , ("peonism" .=) <$> peonismCoadjustClass
        , ("Phonelescope" .=) <$> phonelescopeCoadjustClass
        , ("porphyrogeniture" .=) <$> porphyrogenitureCoadjustClass
        , ("preindemnify" .=) <$> preindemnifyCoadjustClass
        , ("rosal" .=) <$> rosalCoadjustClass
        , ("scalenous" .=) <$> scalenousCoadjustClass
        , ("scopine" .=) <$> scopineCoadjustClass
        , ("Sedaceae" .=) <$> sedaceaeCoadjustClass
        , ("suberinize" .=) <$> suberinizeCoadjustClass
        , ("symbiot" .=) <$> symbiotCoadjustClass
        , ("tablefellow" .=) <$> tablefellowCoadjustClass
        , ("unchargeable" .=) <$> unchargeableCoadjustClass
        ]

instance FromJSON CoadjustClass where
    parseJSON (Object v) = CoadjustClass
        <$> v .:! "amidosulphonal"
        <*> v .:! "Benny"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "disdiapason"
        <*> v .:! "ensnare"
        <*> v .:! "homocerc"
        <*> v .:! "hybridizer"
        <*> v .:! "leastwise"
        <*> v .:! "lof"
        <*> v .:! "monkhood"
        <*> v .:! "Netherlandish"
        <*> v .:! "nonbookish"
        <*> v .:! "peonism"
        <*> v .:! "Phonelescope"
        <*> v .:! "porphyrogeniture"
        <*> v .:! "preindemnify"
        <*> v .:! "rosal"
        <*> v .:! "scalenous"
        <*> v .:! "scopine"
        <*> v .:! "Sedaceae"
        <*> v .:! "suberinize"
        <*> v .:! "symbiot"
        <*> v .:! "tablefellow"
        <*> v .:! "unchargeable"

instance ToJSON Consilience where
    toJSON (DoubleInConsilience x) = toJSON x
    toJSON (IntegerMapInConsilience x) = toJSON x

instance FromJSON Consilience where
    parseJSON xs@(Number _) = (fmap DoubleInConsilience . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInConsilience . parseJSON) xs

instance ToJSON Constructor where
    toJSON (BoolInConstructor x) = toJSON x
    toJSON (UnionMapInConstructor x) = toJSON x

instance FromJSON Constructor where
    parseJSON xs@(Bool _) = (fmap BoolInConstructor . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInConstructor . parseJSON) xs

instance ToJSON Continuative where
    toJSON (IntegerMapInContinuative x) = toJSON x
    toJSON (StringInContinuative x) = toJSON x

instance FromJSON Continuative where
    parseJSON xs@(Object _) = (fmap IntegerMapInContinuative . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInContinuative . parseJSON) xs

instance ToJSON CredulityElement where
    toJSON (CredulityClassInCredulityElement x) = toJSON x
    toJSON (IntegerInCredulityElement x) = toJSON x
    toJSON (StringInCredulityElement x) = toJSON x

instance FromJSON CredulityElement where
    parseJSON xs@(Object _) = (fmap CredulityClassInCredulityElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInCredulityElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInCredulityElement . parseJSON) xs

instance ToJSON CredulityClass where
    toJSON (CredulityClass ammonolyticCredulityClass bushmasterCredulityClass consideringCredulityClass consuetudinaryCredulityClass embarrasCredulityClass finenessCredulityClass flaithshipCredulityClass flaviaCredulityClass grufflyCredulityClass hedychiumCredulityClass leadwortCredulityClass overseriouslyCredulityClass parabolaCredulityClass pectinatodenticulateCredulityClass popeanCredulityClass pornocratCredulityClass quadrisectCredulityClass serialityCredulityClass vamphornCredulityClass wharpCredulityClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ammonolytic" .= ammonolyticCredulityClass
        , Just $ "bushmaster" .= bushmasterCredulityClass
        , Just $ "considering" .= consideringCredulityClass
        , Just $ "consuetudinary" .= consuetudinaryCredulityClass
        , Just $ "embarras" .= embarrasCredulityClass
        , Just $ "fineness" .= finenessCredulityClass
        , Just $ "flaithship" .= flaithshipCredulityClass
        , Just $ "Flavia" .= flaviaCredulityClass
        , Just $ "gruffly" .= grufflyCredulityClass
        , Just $ "Hedychium" .= hedychiumCredulityClass
        , Just $ "leadwort" .= leadwortCredulityClass
        , Just $ "overseriously" .= overseriouslyCredulityClass
        , Just $ "parabola" .= parabolaCredulityClass
        , Just $ "pectinatodenticulate" .= pectinatodenticulateCredulityClass
        , Just $ "Popean" .= popeanCredulityClass
        , Just $ "pornocrat" .= pornocratCredulityClass
        , Just $ "quadrisect" .= quadrisectCredulityClass
        , Just $ "seriality" .= serialityCredulityClass
        , Just $ "vamphorn" .= vamphornCredulityClass
        , Just $ "wharp" .= wharpCredulityClass
        ]

instance FromJSON CredulityClass where
    parseJSON (Object v) = CredulityClass
        <$> v .: "ammonolytic"
        <*> v .: "bushmaster"
        <*> v .: "considering"
        <*> v .: "consuetudinary"
        <*> v .: "embarras"
        <*> v .: "fineness"
        <*> v .: "flaithship"
        <*> v .: "Flavia"
        <*> v .: "gruffly"
        <*> v .: "Hedychium"
        <*> v .: "leadwort"
        <*> v .: "overseriously"
        <*> v .: "parabola"
        <*> v .: "pectinatodenticulate"
        <*> v .: "Popean"
        <*> v .: "pornocrat"
        <*> v .: "quadrisect"
        <*> v .: "seriality"
        <*> v .: "vamphorn"
        <*> v .: "wharp"

instance ToJSON Creviced where
    toJSON (BoolInCreviced x) = toJSON x
    toJSON (IntegerMapInCreviced x) = toJSON x
    toJSON (StringInCreviced x) = toJSON x

instance FromJSON Creviced where
    parseJSON xs@(Bool _) = (fmap BoolInCreviced . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInCreviced . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInCreviced . parseJSON) xs

instance ToJSON DeruralizeElement where
    toJSON (BoolInDeruralizeElement x) = toJSON x
    toJSON (DeruralizeClassInDeruralizeElement x) = toJSON x
    toJSON (NullArrayInDeruralizeElement x) = toJSON x

instance FromJSON DeruralizeElement where
    parseJSON xs@(Bool _) = (fmap BoolInDeruralizeElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DeruralizeClassInDeruralizeElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInDeruralizeElement . parseJSON) xs

instance ToJSON DeruralizeClass where
    toJSON (DeruralizeClass bockerelDeruralizeClass boulderDeruralizeClass churrusDeruralizeClass counterdiggedDeruralizeClass dialogiteDeruralizeClass digenicDeruralizeClass dunbirdDeruralizeClass ergatogyneDeruralizeClass fiendfulDeruralizeClass jackrodDeruralizeClass jehovisticDeruralizeClass panineanDeruralizeClass pantherDeruralizeClass placentigerousDeruralizeClass romneyDeruralizeClass sparmDeruralizeClass tocsinDeruralizeClass unnickedDeruralizeClass unstavableDeruralizeClass windfirmDeruralizeClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bockerel" .= bockerelDeruralizeClass
        , Just $ "boulder" .= boulderDeruralizeClass
        , Just $ "churrus" .= churrusDeruralizeClass
        , Just $ "counterdigged" .= counterdiggedDeruralizeClass
        , Just $ "dialogite" .= dialogiteDeruralizeClass
        , Just $ "digenic" .= digenicDeruralizeClass
        , Just $ "dunbird" .= dunbirdDeruralizeClass
        , Just $ "ergatogyne" .= ergatogyneDeruralizeClass
        , Just $ "fiendful" .= fiendfulDeruralizeClass
        , Just $ "jackrod" .= jackrodDeruralizeClass
        , Just $ "Jehovistic" .= jehovisticDeruralizeClass
        , Just $ "Paninean" .= panineanDeruralizeClass
        , Just $ "panther" .= pantherDeruralizeClass
        , Just $ "placentigerous" .= placentigerousDeruralizeClass
        , Just $ "Romney" .= romneyDeruralizeClass
        , Just $ "sparm" .= sparmDeruralizeClass
        , Just $ "tocsin" .= tocsinDeruralizeClass
        , Just $ "unnicked" .= unnickedDeruralizeClass
        , Just $ "unstavable" .= unstavableDeruralizeClass
        , Just $ "windfirm" .= windfirmDeruralizeClass
        ]

instance FromJSON DeruralizeClass where
    parseJSON (Object v) = DeruralizeClass
        <$> v .: "bockerel"
        <*> v .: "boulder"
        <*> v .: "churrus"
        <*> v .: "counterdigged"
        <*> v .: "dialogite"
        <*> v .: "digenic"
        <*> v .: "dunbird"
        <*> v .: "ergatogyne"
        <*> v .: "fiendful"
        <*> v .: "jackrod"
        <*> v .: "Jehovistic"
        <*> v .: "Paninean"
        <*> v .: "panther"
        <*> v .: "placentigerous"
        <*> v .: "Romney"
        <*> v .: "sparm"
        <*> v .: "tocsin"
        <*> v .: "unnicked"
        <*> v .: "unstavable"
        <*> v .: "windfirm"

instance ToJSON DiaereseElement where
    toJSON (BoolInDiaereseElement x) = toJSON x
    toJSON (DiaereseClassInDiaereseElement x) = toJSON x
    toJSON (IntegerArrayInDiaereseElement x) = toJSON x

instance FromJSON DiaereseElement where
    parseJSON xs@(Bool _) = (fmap BoolInDiaereseElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DiaereseClassInDiaereseElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInDiaereseElement . parseJSON) xs

instance ToJSON DiaereseClass where
    toJSON (DiaereseClass amoreuxiaDiaereseClass aniDiaereseClass bernicleDiaereseClass blackwasherDiaereseClass blowhardDiaereseClass bromaDiaereseClass closecrossDiaereseClass congregationalismDiaereseClass graylyDiaereseClass historicallyDiaereseClass hoastDiaereseClass irretentiveDiaereseClass parcenerDiaereseClass pedderDiaereseClass pseudoanatomicDiaereseClass rhizocarpianDiaereseClass samelDiaereseClass silkerDiaereseClass subdentatedDiaereseClass subobscureDiaereseClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Amoreuxia" .= amoreuxiaDiaereseClass
        , Just $ "ani" .= aniDiaereseClass
        , Just $ "bernicle" .= bernicleDiaereseClass
        , Just $ "blackwasher" .= blackwasherDiaereseClass
        , Just $ "blowhard" .= blowhardDiaereseClass
        , Just $ "broma" .= bromaDiaereseClass
        , Just $ "closecross" .= closecrossDiaereseClass
        , Just $ "congregationalism" .= congregationalismDiaereseClass
        , Just $ "grayly" .= graylyDiaereseClass
        , Just $ "historically" .= historicallyDiaereseClass
        , Just $ "hoast" .= hoastDiaereseClass
        , Just $ "irretentive" .= irretentiveDiaereseClass
        , Just $ "parcener" .= parcenerDiaereseClass
        , Just $ "pedder" .= pedderDiaereseClass
        , Just $ "pseudoanatomic" .= pseudoanatomicDiaereseClass
        , Just $ "rhizocarpian" .= rhizocarpianDiaereseClass
        , Just $ "samel" .= samelDiaereseClass
        , Just $ "silker" .= silkerDiaereseClass
        , Just $ "subdentated" .= subdentatedDiaereseClass
        , Just $ "subobscure" .= subobscureDiaereseClass
        ]

instance FromJSON DiaereseClass where
    parseJSON (Object v) = DiaereseClass
        <$> v .: "Amoreuxia"
        <*> v .: "ani"
        <*> v .: "bernicle"
        <*> v .: "blackwasher"
        <*> v .: "blowhard"
        <*> v .: "broma"
        <*> v .: "closecross"
        <*> v .: "congregationalism"
        <*> v .: "grayly"
        <*> v .: "historically"
        <*> v .: "hoast"
        <*> v .: "irretentive"
        <*> v .: "parcener"
        <*> v .: "pedder"
        <*> v .: "pseudoanatomic"
        <*> v .: "rhizocarpian"
        <*> v .: "samel"
        <*> v .: "silker"
        <*> v .: "subdentated"
        <*> v .: "subobscure"

instance ToJSON Downstroke where
    toJSON (BoolInDownstroke x) = toJSON x
    toJSON (NullArrayInDownstroke x) = toJSON x
    toJSON (StringInDownstroke x) = toJSON x

instance FromJSON Downstroke where
    parseJSON xs@(Bool _) = (fmap BoolInDownstroke . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInDownstroke . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInDownstroke . parseJSON) xs

instance ToJSON Eleutheromania where
    toJSON (DoubleInEleutheromania x) = toJSON x
    toJSON (IntegerMapInEleutheromania x) = toJSON x
    toJSON (StringInEleutheromania x) = toJSON x

instance FromJSON Eleutheromania where
    parseJSON xs@(Number _) = (fmap DoubleInEleutheromania . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInEleutheromania . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInEleutheromania . parseJSON) xs

instance ToJSON Encrust where
    toJSON (Encrust comradelyEncrust diacanthousEncrust femininenessEncrust gossameredEncrust hiberniaEncrust hibiscusEncrust lepidosauriaEncrust lollinglyEncrust managerEncrust mechanicEncrust overminutenessEncrust papelonneEncrust plebificationEncrust pugmillerEncrust recoverorEncrust spermatoblasticEncrust syllidaeEncrust ungyvedEncrust whirlaboutEncrust woodenwareEncrust) =
        object $ foldMap (maybe [] pure)
        [ Just $ "comradely" .= comradelyEncrust
        , Just $ "diacanthous" .= diacanthousEncrust
        , Just $ "feminineness" .= femininenessEncrust
        , Just $ "gossamered" .= gossameredEncrust
        , Just $ "Hibernia" .= hiberniaEncrust
        , Just $ "Hibiscus" .= hibiscusEncrust
        , Just $ "Lepidosauria" .= lepidosauriaEncrust
        , Just $ "lollingly" .= lollinglyEncrust
        , Just $ "manager" .= managerEncrust
        , Just $ "mechanic" .= mechanicEncrust
        , Just $ "overminuteness" .= overminutenessEncrust
        , Just $ "papelonne" .= papelonneEncrust
        , Just $ "plebification" .= plebificationEncrust
        , Just $ "pugmiller" .= pugmillerEncrust
        , Just $ "recoveror" .= recoverorEncrust
        , Just $ "spermatoblastic" .= spermatoblasticEncrust
        , Just $ "Syllidae" .= syllidaeEncrust
        , Just $ "ungyved" .= ungyvedEncrust
        , Just $ "whirlabout" .= whirlaboutEncrust
        , Just $ "woodenware" .= woodenwareEncrust
        ]

instance FromJSON Encrust where
    parseJSON (Object v) = Encrust
        <$> v .: "comradely"
        <*> v .: "diacanthous"
        <*> v .: "feminineness"
        <*> v .: "gossamered"
        <*> v .: "Hibernia"
        <*> v .: "Hibiscus"
        <*> v .: "Lepidosauria"
        <*> v .: "lollingly"
        <*> v .: "manager"
        <*> v .: "mechanic"
        <*> v .: "overminuteness"
        <*> v .: "papelonne"
        <*> v .: "plebification"
        <*> v .: "pugmiller"
        <*> v .: "recoveror"
        <*> v .: "spermatoblastic"
        <*> v .: "Syllidae"
        <*> v .: "ungyved"
        <*> v .: "whirlabout"
        <*> v .: "woodenware"

instance ToJSON Entomoid where
    toJSON (CimeliaClassInEntomoid x) = toJSON x
    toJSON (IntegerInEntomoid x) = toJSON x

instance FromJSON Entomoid where
    parseJSON xs@(Object _) = (fmap CimeliaClassInEntomoid . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInEntomoid . parseJSON) xs

instance ToJSON Epipaleolithic where
    toJSON (DoubleInEpipaleolithic x) = toJSON x
    toJSON (IntegerArrayInEpipaleolithic x) = toJSON x

instance FromJSON Epipaleolithic where
    parseJSON xs@(Number _) = (fmap DoubleInEpipaleolithic . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInEpipaleolithic . parseJSON) xs

instance ToJSON Expropriable where
    toJSON (CimeliaClassInExpropriable x) = toJSON x
    toJSON (DoubleInExpropriable x) = toJSON x
    toJSON (NullArrayInExpropriable x) = toJSON x

instance FromJSON Expropriable where
    parseJSON xs@(Object _) = (fmap CimeliaClassInExpropriable . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInExpropriable . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInExpropriable . parseJSON) xs

instance ToJSON FagginglyElement where
    toJSON (DoubleInFagginglyElement x) = toJSON x
    toJSON (FagginglyClassInFagginglyElement x) = toJSON x

instance FromJSON FagginglyElement where
    parseJSON xs@(Number _) = (fmap DoubleInFagginglyElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FagginglyClassInFagginglyElement . parseJSON) xs

instance ToJSON FagginglyClass where
    toJSON (FagginglyClass abranchianFagginglyClass aculeiformFagginglyClass adiaphoristicFagginglyClass adoptionismFagginglyClass anglicFagginglyClass antrotomyFagginglyClass coercivenessFagginglyClass decoristFagginglyClass duckhoodFagginglyClass heteromeriFagginglyClass hypochnoseFagginglyClass lochageFagginglyClass meleeFagginglyClass nonconformitantFagginglyClass poinsettiaFagginglyClass putativelyFagginglyClass semivolatileFagginglyClass soleasFagginglyClass unfastenableFagginglyClass unmillineredFagginglyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "abranchian" .= abranchianFagginglyClass
        , Just $ "aculeiform" .= aculeiformFagginglyClass
        , Just $ "adiaphoristic" .= adiaphoristicFagginglyClass
        , Just $ "adoptionism" .= adoptionismFagginglyClass
        , Just $ "Anglic" .= anglicFagginglyClass
        , Just $ "antrotomy" .= antrotomyFagginglyClass
        , Just $ "coerciveness" .= coercivenessFagginglyClass
        , Just $ "decorist" .= decoristFagginglyClass
        , Just $ "duckhood" .= duckhoodFagginglyClass
        , Just $ "Heteromeri" .= heteromeriFagginglyClass
        , Just $ "hypochnose" .= hypochnoseFagginglyClass
        , Just $ "lochage" .= lochageFagginglyClass
        , Just $ "melee" .= meleeFagginglyClass
        , Just $ "nonconformitant" .= nonconformitantFagginglyClass
        , Just $ "Poinsettia" .= poinsettiaFagginglyClass
        , Just $ "putatively" .= putativelyFagginglyClass
        , Just $ "semivolatile" .= semivolatileFagginglyClass
        , Just $ "soleas" .= soleasFagginglyClass
        , Just $ "unfastenable" .= unfastenableFagginglyClass
        , Just $ "unmillinered" .= unmillineredFagginglyClass
        ]

instance FromJSON FagginglyClass where
    parseJSON (Object v) = FagginglyClass
        <$> v .: "abranchian"
        <*> v .: "aculeiform"
        <*> v .: "adiaphoristic"
        <*> v .: "adoptionism"
        <*> v .: "Anglic"
        <*> v .: "antrotomy"
        <*> v .: "coerciveness"
        <*> v .: "decorist"
        <*> v .: "duckhood"
        <*> v .: "Heteromeri"
        <*> v .: "hypochnose"
        <*> v .: "lochage"
        <*> v .: "melee"
        <*> v .: "nonconformitant"
        <*> v .: "Poinsettia"
        <*> v .: "putatively"
        <*> v .: "semivolatile"
        <*> v .: "soleas"
        <*> v .: "unfastenable"
        <*> v .: "unmillinered"

instance ToJSON FenkElement where
    toJSON (FenkClassInFenkElement x) = toJSON x
    toJSON (StringInFenkElement x) = toJSON x

instance FromJSON FenkElement where
    parseJSON xs@(Object _) = (fmap FenkClassInFenkElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInFenkElement . parseJSON) xs

instance ToJSON FenkClass where
    toJSON (FenkClass apoiseFenkClass astronomizeFenkClass cockhorseFenkClass copularFenkClass dagombaFenkClass draffyFenkClass foreignerFenkClass guyandotFenkClass neurogliosisFenkClass osmiousFenkClass palpitateFenkClass rebukeableFenkClass reinwardtiaFenkClass reservatoryFenkClass scaltFenkClass scripturalizeFenkClass tintometerFenkClass tritonessFenkClass undergradeFenkClass undermountainFenkClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "apoise" .= apoiseFenkClass
        , Just $ "astronomize" .= astronomizeFenkClass
        , Just $ "cockhorse" .= cockhorseFenkClass
        , Just $ "copular" .= copularFenkClass
        , Just $ "Dagomba" .= dagombaFenkClass
        , Just $ "draffy" .= draffyFenkClass
        , Just $ "foreigner" .= foreignerFenkClass
        , Just $ "Guyandot" .= guyandotFenkClass
        , Just $ "neurogliosis" .= neurogliosisFenkClass
        , Just $ "osmious" .= osmiousFenkClass
        , Just $ "palpitate" .= palpitateFenkClass
        , Just $ "rebukeable" .= rebukeableFenkClass
        , Just $ "Reinwardtia" .= reinwardtiaFenkClass
        , Just $ "reservatory" .= reservatoryFenkClass
        , Just $ "scalt" .= scaltFenkClass
        , Just $ "scripturalize" .= scripturalizeFenkClass
        , Just $ "tintometer" .= tintometerFenkClass
        , Just $ "Tritoness" .= tritonessFenkClass
        , Just $ "undergrade" .= undergradeFenkClass
        , Just $ "undermountain" .= undermountainFenkClass
        ]

instance FromJSON FenkClass where
    parseJSON (Object v) = FenkClass
        <$> v .: "apoise"
        <*> v .: "astronomize"
        <*> v .: "cockhorse"
        <*> v .: "copular"
        <*> v .: "Dagomba"
        <*> v .: "draffy"
        <*> v .: "foreigner"
        <*> v .: "Guyandot"
        <*> v .: "neurogliosis"
        <*> v .: "osmious"
        <*> v .: "palpitate"
        <*> v .: "rebukeable"
        <*> v .: "Reinwardtia"
        <*> v .: "reservatory"
        <*> v .: "scalt"
        <*> v .: "scripturalize"
        <*> v .: "tintometer"
        <*> v .: "Tritoness"
        <*> v .: "undergrade"
        <*> v .: "undermountain"

instance ToJSON FlagmakingElement where
    toJSON (BoolInFlagmakingElement x) = toJSON x
    toJSON (DoubleInFlagmakingElement x) = toJSON x
    toJSON (FlagmakingClassInFlagmakingElement x) = toJSON x

instance FromJSON FlagmakingElement where
    parseJSON xs@(Bool _) = (fmap BoolInFlagmakingElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInFlagmakingElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FlagmakingClassInFlagmakingElement . parseJSON) xs

instance ToJSON FlagmakingClass where
    toJSON (FlagmakingClass albarcoFlagmakingClass bunodontaFlagmakingClass hornifyFlagmakingClass hydrocorisaeFlagmakingClass hypoglossusFlagmakingClass inexpiablyFlagmakingClass ingratitudeFlagmakingClass ladyflyFlagmakingClass medicamentFlagmakingClass monogrammaticFlagmakingClass nobbutFlagmakingClass notacanthidaeFlagmakingClass polyplacophoreFlagmakingClass proexerciseFlagmakingClass protoplastFlagmakingClass puzzlingFlagmakingClass splanchnoskeletonFlagmakingClass unlovelinessFlagmakingClass unquarantinedFlagmakingClass unrenounceableFlagmakingClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "albarco" .= albarcoFlagmakingClass
        , Just $ "Bunodonta" .= bunodontaFlagmakingClass
        , Just $ "hornify" .= hornifyFlagmakingClass
        , Just $ "Hydrocorisae" .= hydrocorisaeFlagmakingClass
        , Just $ "hypoglossus" .= hypoglossusFlagmakingClass
        , Just $ "inexpiably" .= inexpiablyFlagmakingClass
        , Just $ "ingratitude" .= ingratitudeFlagmakingClass
        , Just $ "ladyfly" .= ladyflyFlagmakingClass
        , Just $ "medicament" .= medicamentFlagmakingClass
        , Just $ "monogrammatic" .= monogrammaticFlagmakingClass
        , Just $ "nobbut" .= nobbutFlagmakingClass
        , Just $ "Notacanthidae" .= notacanthidaeFlagmakingClass
        , Just $ "polyplacophore" .= polyplacophoreFlagmakingClass
        , Just $ "proexercise" .= proexerciseFlagmakingClass
        , Just $ "protoplast" .= protoplastFlagmakingClass
        , Just $ "puzzling" .= puzzlingFlagmakingClass
        , Just $ "splanchnoskeleton" .= splanchnoskeletonFlagmakingClass
        , Just $ "unloveliness" .= unlovelinessFlagmakingClass
        , Just $ "unquarantined" .= unquarantinedFlagmakingClass
        , Just $ "unrenounceable" .= unrenounceableFlagmakingClass
        ]

instance FromJSON FlagmakingClass where
    parseJSON (Object v) = FlagmakingClass
        <$> v .: "albarco"
        <*> v .: "Bunodonta"
        <*> v .: "hornify"
        <*> v .: "Hydrocorisae"
        <*> v .: "hypoglossus"
        <*> v .: "inexpiably"
        <*> v .: "ingratitude"
        <*> v .: "ladyfly"
        <*> v .: "medicament"
        <*> v .: "monogrammatic"
        <*> v .: "nobbut"
        <*> v .: "Notacanthidae"
        <*> v .: "polyplacophore"
        <*> v .: "proexercise"
        <*> v .: "protoplast"
        <*> v .: "puzzling"
        <*> v .: "splanchnoskeleton"
        <*> v .: "unloveliness"
        <*> v .: "unquarantined"
        <*> v .: "unrenounceable"

instance ToJSON Fluorometer where
    toJSON (IntegerInFluorometer x) = toJSON x
    toJSON NullInFluorometer = Null
    toJSON (StringInFluorometer x) = toJSON x

instance FromJSON Fluorometer where
    parseJSON xs@(Number _) = (fmap IntegerInFluorometer . parseJSON) xs
    parseJSON Null = return NullInFluorometer
    parseJSON xs@(String _) = (fmap StringInFluorometer . parseJSON) xs

instance ToJSON Fuzzy where
    toJSON (IntegerInFuzzy x) = toJSON x
    toJSON (UnionMapInFuzzy x) = toJSON x

instance FromJSON Fuzzy where
    parseJSON xs@(Number _) = (fmap IntegerInFuzzy . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInFuzzy . parseJSON) xs

instance ToJSON Gardenward where
    toJSON (BoolInGardenward x) = toJSON x
    toJSON (IntegerArrayInGardenward x) = toJSON x
    toJSON (StringInGardenward x) = toJSON x

instance FromJSON Gardenward where
    parseJSON xs@(Bool _) = (fmap BoolInGardenward . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInGardenward . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInGardenward . parseJSON) xs

instance ToJSON Generalissimo where
    toJSON (BoolInGeneralissimo x) = toJSON x
    toJSON (IntegerMapInGeneralissimo x) = toJSON x
    toJSON NullInGeneralissimo = Null

instance FromJSON Generalissimo where
    parseJSON xs@(Bool _) = (fmap BoolInGeneralissimo . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInGeneralissimo . parseJSON) xs
    parseJSON Null = return NullInGeneralissimo

instance ToJSON Hemicrystalline where
    toJSON (CimeliaClassInHemicrystalline x) = toJSON x
    toJSON (StringInHemicrystalline x) = toJSON x

instance FromJSON Hemicrystalline where
    parseJSON xs@(Object _) = (fmap CimeliaClassInHemicrystalline . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInHemicrystalline . parseJSON) xs

instance ToJSON HemocoeleElement where
    toJSON (HemocoeleClassInHemocoeleElement x) = toJSON x
    toJSON (IntegerArrayInHemocoeleElement x) = toJSON x

instance FromJSON HemocoeleElement where
    parseJSON xs@(Object _) = (fmap HemocoeleClassInHemocoeleElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInHemocoeleElement . parseJSON) xs

instance ToJSON HemocoeleClass where
    toJSON (HemocoeleClass acrogamyHemocoeleClass amelificationHemocoeleClass autobiographicHemocoeleClass beratHemocoeleClass catharticalnessHemocoeleClass chirotheriumHemocoeleClass disdiapasonHemocoeleClass disproportionablyHemocoeleClass erythriteHemocoeleClass graphicHemocoeleClass hepatologicalHemocoeleClass homocercHemocoeleClass incommensurablyHemocoeleClass misaffirmHemocoeleClass nonbookishHemocoeleClass pocketbookHemocoeleClass sclerometricHemocoeleClass stamboulineHemocoeleClass stickpinHemocoeleClass tubulureHemocoeleClass undelatedHemocoeleClass unsaltHemocoeleClass untutelarHemocoeleClass vagrantHemocoeleClass waltHemocoeleClass) =
        object $ foldMap (maybe [] pure)
        [ ("acrogamy" .=) <$> acrogamyHemocoeleClass
        , ("amelification" .=) <$> amelificationHemocoeleClass
        , ("autobiographic" .=) <$> autobiographicHemocoeleClass
        , ("berat" .=) <$> beratHemocoeleClass
        , ("catharticalness" .=) <$> catharticalnessHemocoeleClass
        , ("Chirotherium" .=) <$> chirotheriumHemocoeleClass
        , ("disdiapason" .=) <$> disdiapasonHemocoeleClass
        , ("disproportionably" .=) <$> disproportionablyHemocoeleClass
        , ("erythrite" .=) <$> erythriteHemocoeleClass
        , ("graphic" .=) <$> graphicHemocoeleClass
        , ("hepatological" .=) <$> hepatologicalHemocoeleClass
        , ("homocerc" .=) <$> homocercHemocoeleClass
        , ("incommensurably" .=) <$> incommensurablyHemocoeleClass
        , ("misaffirm" .=) <$> misaffirmHemocoeleClass
        , ("nonbookish" .=) <$> nonbookishHemocoeleClass
        , ("pocketbook" .=) <$> pocketbookHemocoeleClass
        , ("sclerometric" .=) <$> sclerometricHemocoeleClass
        , ("stambouline" .=) <$> stamboulineHemocoeleClass
        , ("stickpin" .=) <$> stickpinHemocoeleClass
        , ("tubulure" .=) <$> tubulureHemocoeleClass
        , ("undelated" .=) <$> undelatedHemocoeleClass
        , ("unsalt" .=) <$> unsaltHemocoeleClass
        , ("untutelar" .=) <$> untutelarHemocoeleClass
        , ("vagrant" .=) <$> vagrantHemocoeleClass
        , ("Walt" .=) <$> waltHemocoeleClass
        ]

instance FromJSON HemocoeleClass where
    parseJSON (Object v) = HemocoeleClass
        <$> v .:! "acrogamy"
        <*> v .:! "amelification"
        <*> v .:! "autobiographic"
        <*> v .:! "berat"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "disdiapason"
        <*> v .:! "disproportionably"
        <*> v .:! "erythrite"
        <*> v .:! "graphic"
        <*> v .:! "hepatological"
        <*> v .:! "homocerc"
        <*> v .:! "incommensurably"
        <*> v .:! "misaffirm"
        <*> v .:! "nonbookish"
        <*> v .:! "pocketbook"
        <*> v .:! "sclerometric"
        <*> v .:! "stambouline"
        <*> v .:! "stickpin"
        <*> v .:! "tubulure"
        <*> v .:! "undelated"
        <*> v .:! "unsalt"
        <*> v .:! "untutelar"
        <*> v .:! "vagrant"
        <*> v .:! "Walt"

instance ToJSON Hoister where
    toJSON (CimeliaClassInHoister x) = toJSON x
    toJSON NullInHoister = Null
    toJSON (StringInHoister x) = toJSON x

instance FromJSON Hoister where
    parseJSON xs@(Object _) = (fmap CimeliaClassInHoister . parseJSON) xs
    parseJSON Null = return NullInHoister
    parseJSON xs@(String _) = (fmap StringInHoister . parseJSON) xs

instance ToJSON Hyperpiesi where
    toJSON (CimeliaClassInHyperpiesi x) = toJSON x
    toJSON (NullArrayInHyperpiesi x) = toJSON x
    toJSON NullInHyperpiesi = Null

instance FromJSON Hyperpiesi where
    parseJSON xs@(Object _) = (fmap CimeliaClassInHyperpiesi . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInHyperpiesi . parseJSON) xs
    parseJSON Null = return NullInHyperpiesi

instance ToJSON Hyppish where
    toJSON (BoolInHyppish x) = toJSON x
    toJSON NullInHyppish = Null
    toJSON (StringInHyppish x) = toJSON x

instance FromJSON Hyppish where
    parseJSON xs@(Bool _) = (fmap BoolInHyppish . parseJSON) xs
    parseJSON Null = return NullInHyppish
    parseJSON xs@(String _) = (fmap StringInHyppish . parseJSON) xs

instance ToJSON Idealizer where
    toJSON (CimeliaClassInIdealizer x) = toJSON x
    toJSON (IntegerInIdealizer x) = toJSON x
    toJSON (NullArrayInIdealizer x) = toJSON x

instance FromJSON Idealizer where
    parseJSON xs@(Object _) = (fmap CimeliaClassInIdealizer . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInIdealizer . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInIdealizer . parseJSON) xs

instance ToJSON Incrustator where
    toJSON (IntegerArrayInIncrustator x) = toJSON x
    toJSON (IntegerInIncrustator x) = toJSON x
    toJSON (StringInIncrustator x) = toJSON x

instance FromJSON Incrustator where
    parseJSON xs@(Array _) = (fmap IntegerArrayInIncrustator . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInIncrustator . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInIncrustator . parseJSON) xs

instance ToJSON Intentiveness where
    toJSON (CimeliaClassInIntentiveness x) = toJSON x
    toJSON (DoubleInIntentiveness x) = toJSON x
    toJSON (StringInIntentiveness x) = toJSON x

instance FromJSON Intentiveness where
    parseJSON xs@(Object _) = (fmap CimeliaClassInIntentiveness . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInIntentiveness . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInIntentiveness . parseJSON) xs

instance ToJSON Interacinar where
    toJSON (Interacinar assapanInteracinar benefactorshipInteracinar triseriatimInteracinar tubbingInteracinar untrimmedInteracinar) =
        object $ foldMap (maybe [] pure)
        [ Just $ "assapan" .= assapanInteracinar
        , Just $ "benefactorship" .= benefactorshipInteracinar
        , Just $ "triseriatim" .= triseriatimInteracinar
        , Just $ "tubbing" .= tubbingInteracinar
        , Just $ "untrimmed" .= untrimmedInteracinar
        ]

instance FromJSON Interacinar where
    parseJSON (Object v) = Interacinar
        <$> v .: "assapan"
        <*> v .: "benefactorship"
        <*> v .: "triseriatim"
        <*> v .: "tubbing"
        <*> v .: "untrimmed"

instance ToJSON Jacutinga where
    toJSON (IntegerArrayInJacutinga x) = toJSON x
    toJSON (UnionMapInJacutinga x) = toJSON x

instance FromJSON Jacutinga where
    parseJSON xs@(Array _) = (fmap IntegerArrayInJacutinga . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInJacutinga . parseJSON) xs
