{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , JurorClass (..)
    , LadronismClass (..)
    , LandlubberlyClass (..)
    , LupusClass (..)
    , Maslin (..)
    , MonaziteClass (..)
    , MonotheisticallyClass (..)
    , Noncontributing (..)
    , OccupationalistClass (..)
    , OutrivalClass (..)
    , PiaculumClass (..)
    , Pneumocele (..)
    , PotwhiskyClass (..)
    , PrefreshmanClass (..)
    , JurorElement (..)
    , Kongoni (..)
    , LadronismElement (..)
    , LandlubberlyElement (..)
    , Listener (..)
    , LupusElement (..)
    , MonaziteElement (..)
    , Monoliteral (..)
    , MonotheisticallyElement (..)
    , Montage (..)
    , Moralness (..)
    , Mulishly (..)
    , Myoscope (..)
    , Neuromastic (..)
    , Nonnervous (..)
    , Nonvaluation (..)
    , OccupationalistElement (..)
    , OutrivalElement (..)
    , Paleographically (..)
    , Pamphletwise (..)
    , Pediatric (..)
    , PiaculumElement (..)
    , Piccadilly (..)
    , Piffler (..)
    , Pithful (..)
    , Placuntiti (..)
    , Plectopterous (..)
    , Poliorcetic (..)
    , Poormaster (..)
    , PotwhiskyElement (..)
    , Practicalizer (..)
    , PrefreshmanElement (..)
    , Prehensility (..)
    , Prevoidance (..)
    , Protext (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)
import Data.Vector (Vector)

data QuickType = QuickType
    { jurorQuickType :: Vector JurorElement
    , kongoniQuickType :: Vector Kongoni
    , ladronismQuickType :: Vector LadronismElement
    , landlubberlyQuickType :: Vector LandlubberlyElement
    , listenerQuickType :: Vector Listener
    , lupusQuickType :: Vector LupusElement
    , maslinQuickType :: Vector Maslin
    , monaziteQuickType :: Vector MonaziteElement
    , monoliteralQuickType :: Vector Monoliteral
    , monotheisticallyQuickType :: Vector MonotheisticallyElement
    , montageQuickType :: Vector Montage
    , moralnessQuickType :: Vector Moralness
    , mowraQuickType :: Vector (Maybe MonaziteClass)
    , mulishlyQuickType :: Vector Mulishly
    , myoscopeQuickType :: Vector Myoscope
    , nachQuickType :: Vector (Maybe (Vector (Maybe Int)))
    , neuromasticQuickType :: Vector Neuromastic
    , noncontributingQuickType :: Vector Noncontributing
    , nonnervousQuickType :: Vector Nonnervous
    , nonvaluationQuickType :: Vector Nonvaluation
    , occupationalistQuickType :: Vector OccupationalistElement
    , outrivalQuickType :: Vector OutrivalElement
    , paleographicallyQuickType :: Vector Paleographically
    , pamphletwiseQuickType :: Vector Pamphletwise
    , pediatricsQuickType :: Vector Pediatric
    , perceptiveQuickType :: Vector Bool
    , piaculumQuickType :: Vector PiaculumElement
    , piccadillyQuickType :: Vector Piccadilly
    , pifflerQuickType :: Vector Piffler
    , pithfulQuickType :: Vector Pithful
    , placuntitisQuickType :: Vector Placuntiti
    , plectopterousQuickType :: Vector Plectopterous
    , pneumoceleQuickType :: Vector (Maybe Pneumocele)
    , poliorceticQuickType :: Vector Poliorcetic
    , poormasterQuickType :: Vector Poormaster
    , potwhiskyQuickType :: Vector PotwhiskyElement
    , practicalizerQuickType :: Vector Practicalizer
    , prefreshmanQuickType :: Vector PrefreshmanElement
    , prehensilityQuickType :: Vector Prehensility
    , prevoidanceQuickType :: Vector Prevoidance
    , probantQuickType :: Vector (HashMap Text (Maybe Int))
    , protextQuickType :: Vector Protext
    } deriving (Show)

data JurorElement
    = BoolInJurorElement Bool
    | JurorClassInJurorElement JurorClass
    deriving (Show)

data JurorClass = JurorClass
    { adipsyJurorClass :: Maybe Text
    , auxiliatorJurorClass :: Maybe Text
    , bendaJurorClass :: Maybe Text
    , benjaminJurorClass :: Maybe Text
    , brandlingJurorClass :: Maybe Text
    , epicurishlyJurorClass :: Maybe Text
    , eremochaetousJurorClass :: Maybe Text
    , martenJurorClass :: Maybe Text
    , monoclineJurorClass :: Maybe Text
    , oleaJurorClass :: Maybe Text
    , palgatJurorClass :: Maybe Text
    , pennyworthJurorClass :: Maybe Text
    , piouryJurorClass :: Maybe Text
    , pragmatisticJurorClass :: Maybe Text
    , stylelessnessJurorClass :: Maybe Text
    , systematicalJurorClass :: Maybe Text
    , threadyJurorClass :: Maybe Text
    , uncontemporaryJurorClass :: Maybe Text
    , uncouchedJurorClass :: Maybe Text
    , uninhabitednessJurorClass :: Maybe Text
    } deriving (Show)

data Kongoni
    = IntegerArrayInKongoni (Vector Int)
    | IntegerMapInKongoni (HashMap Text Int)
    deriving (Show)

data LadronismElement
    = DoubleInLadronismElement Double
    | LadronismClassInLadronismElement LadronismClass
    | StringInLadronismElement Text
    deriving (Show)

data LadronismClass = LadronismClass
    { acclaimerLadronismClass :: Maybe Text
    , achreeLadronismClass :: Maybe Text
    , baseLadronismClass :: Maybe Text
    , conundrumizeLadronismClass :: Maybe Text
    , degerminatorLadronismClass :: Maybe Text
    , describableLadronismClass :: Maybe Text
    , exasperatedlyLadronismClass :: Maybe Text
    , heroineLadronismClass :: Maybe Text
    , indazinLadronismClass :: Maybe Text
    , luteousLadronismClass :: Maybe Text
    , papularLadronismClass :: Maybe Text
    , pritchLadronismClass :: Maybe Text
    , prodeniaLadronismClass :: Maybe Text
    , seegeLadronismClass :: Maybe Text
    , shopgirlLadronismClass :: Maybe Text
    , tragediettaLadronismClass :: Maybe Text
    , unsparseLadronismClass :: Maybe Text
    , uplookLadronismClass :: Maybe Text
    , vermiformisLadronismClass :: Maybe Text
    , whafaboutLadronismClass :: Maybe Text
    } deriving (Show)

data LandlubberlyElement
    = BoolInLandlubberlyElement Bool
    | IntegerInLandlubberlyElement Int
    | LandlubberlyClassInLandlubberlyElement LandlubberlyClass
    deriving (Show)

data LandlubberlyClass = LandlubberlyClass
    { acropoleisLandlubberlyClass :: Maybe Text
    , aminateLandlubberlyClass :: Maybe Text
    , amyraldismLandlubberlyClass :: Maybe Text
    , bipenniformLandlubberlyClass :: Maybe Text
    , bugreLandlubberlyClass :: Maybe Text
    , calyculeLandlubberlyClass :: Maybe Text
    , caoutchoucLandlubberlyClass :: Maybe Text
    , disproverLandlubberlyClass :: Maybe Text
    , fitrootLandlubberlyClass :: Maybe Text
    , fulgentlyLandlubberlyClass :: Maybe Text
    , kickupLandlubberlyClass :: Maybe Text
    , laevoversionLandlubberlyClass :: Maybe Text
    , moterLandlubberlyClass :: Maybe Text
    , objectivityLandlubberlyClass :: Maybe Text
    , posterityLandlubberlyClass :: Maybe Text
    , postnuptialLandlubberlyClass :: Maybe Text
    , precedentaryLandlubberlyClass :: Maybe Text
    , saddlingLandlubberlyClass :: Maybe Text
    , subcurrentLandlubberlyClass :: Maybe Text
    , unrecriminativeLandlubberlyClass :: Maybe Text
    } deriving (Show)

data Listener
    = IntegerInListener Int
    | NullArrayInListener (Vector (Maybe Text))
    deriving (Show)

data LupusElement
    = IntegerInLupusElement Int
    | LupusClassInLupusElement LupusClass
    deriving (Show)

data LupusClass = LupusClass
    { catharticalnessLupusClass :: Maybe Double
    , chirotheriumLupusClass :: Maybe Int
    , chlorioninaeLupusClass :: Maybe Int
    , corvinaeLupusClass :: Maybe Int
    , crassinaLupusClass :: Maybe Int
    , disdiapasonLupusClass :: Maybe Text
    , exiguityLupusClass :: Maybe Int
    , farcistLupusClass :: Maybe Int
    , holographicalLupusClass :: Maybe Int
    , homocercLupusClass :: Maybe Bool
    , ichthyophaganLupusClass :: Maybe Int
    , implacableLupusClass :: Maybe Int
    , nonbookishLupusClass :: Maybe (Maybe Text)
    , outshinerLupusClass :: Maybe Int
    , overweatherLupusClass :: Maybe Int
    , protonegroidLupusClass :: Maybe Int
    , shallowishLupusClass :: Maybe Int
    , snokeLupusClass :: Maybe Int
    , snoutLupusClass :: Maybe Int
    , surveillanceLupusClass :: Maybe Int
    , threshingtimeLupusClass :: Maybe Int
    , thysanocarpusLupusClass :: Maybe Int
    , unsignificantlyLupusClass :: Maybe Int
    , unsnapLupusClass :: Maybe Int
    , vendibleLupusClass :: Maybe Int
    } deriving (Show)

data Maslin = Maslin
    { alicantMaslin :: Maybe Int
    , antiatonementMaslin :: Maybe (Maybe Text)
    , anticorrosiveMaslin :: Maybe Int
    , aphidozerMaslin :: Maybe (Maybe Text)
    , bakuninistMaslin :: Maybe (Maybe Text)
    , beMaslin :: Maybe Int
    , catharticalnessMaslin :: Maybe Double
    , chirotheriumMaslin :: Maybe Int
    , chubMaslin :: Maybe Int
    , cuprosiliconMaslin :: Maybe Int
    , curtailedlyMaslin :: Maybe Int
    , delleniteMaslin :: Maybe Int
    , dimitryMaslin :: Maybe Int
    , disdiapasonMaslin :: Maybe Text
    , edifyingMaslin :: Maybe (Maybe Text)
    , ethmoiditisMaslin :: Maybe Int
    , gastralgyMaslin :: Maybe (Maybe Text)
    , goatherdMaslin :: Maybe Int
    , hammerdressMaslin :: Maybe Int
    , hangfireMaslin :: Maybe (Maybe Text)
    , homocercMaslin :: Maybe Bool
    , lacunosityMaslin :: Maybe Int
    , longiloquenceMaslin :: Maybe (Maybe Text)
    , mameliereMaslin :: Maybe Int
    , motherlessMaslin :: Maybe (Maybe Text)
    , nonbookishMaslin :: Maybe (Maybe Text)
    , noncorrodibleMaslin :: Maybe (Maybe Text)
    , nonsensicalityMaslin :: Maybe (Maybe Text)
    , oafishlyMaslin :: Maybe Int
    , pfundMaslin :: Maybe (Maybe Text)
    , preadvisoryMaslin :: Maybe (Maybe Text)
    , retroflexedMaslin :: Maybe (Maybe Text)
    , saccharulmicMaslin :: Maybe Int
    , scowlfulMaslin :: Maybe Int
    , secludedMaslin :: Maybe (Maybe Text)
    , slackageMaslin :: Maybe (Maybe Text)
    , sphaeridialMaslin :: Maybe Int
    , spondulicsMaslin :: Maybe (Maybe Text)
    , subseciveMaslin :: Maybe Int
    , swellmobsmanMaslin :: Maybe (Maybe Text)
    , trachyglossateMaslin :: Maybe Int
    , trialogueMaslin :: Maybe (Maybe Text)
    , unassuagedMaslin :: Maybe Int
    , ungrossMaslin :: Maybe (Maybe Text)
    , unjudiciouslyMaslin :: Maybe (Maybe Text)
    } deriving (Show)

data MonaziteElement
    = DoubleInMonaziteElement Double
    | MonaziteClassInMonaziteElement MonaziteClass
    deriving (Show)

data MonaziteClass = MonaziteClass
    { catharticalnessMonaziteClass :: Double
    , chirotheriumMonaziteClass :: Int
    , disdiapasonMonaziteClass :: Text
    , homocercMonaziteClass :: Bool
    , nonbookishMonaziteClass :: Maybe Text
    } deriving (Show)

data Monoliteral
    = BoolInMonoliteral Bool
    | NullArrayInMonoliteral (Vector (Maybe Text))
    deriving (Show)

data MonotheisticallyElement
    = MonotheisticallyClassInMonotheisticallyElement MonotheisticallyClass
    | NullArrayInMonotheisticallyElement (Vector (Maybe Text))
    deriving (Show)

data MonotheisticallyClass = MonotheisticallyClass
    { blasphemeMonotheisticallyClass :: Maybe (Maybe Text)
    , catharticalnessMonotheisticallyClass :: Maybe Double
    , celiosalpingectomyMonotheisticallyClass :: Maybe (Maybe Text)
    , chirotheriumMonotheisticallyClass :: Maybe Int
    , consummativenessMonotheisticallyClass :: Maybe (Maybe Text)
    , disdiapasonMonotheisticallyClass :: Maybe Text
    , egestiveMonotheisticallyClass :: Maybe (Maybe Text)
    , enchylemaMonotheisticallyClass :: Maybe (Maybe Text)
    , gasconadeMonotheisticallyClass :: Maybe (Maybe Text)
    , holidayerMonotheisticallyClass :: Maybe (Maybe Text)
    , homocercMonotheisticallyClass :: Maybe Bool
    , intuitionalismMonotheisticallyClass :: Maybe (Maybe Text)
    , lophiostomateMonotheisticallyClass :: Maybe (Maybe Text)
    , nonbookishMonotheisticallyClass :: Maybe (Maybe Text)
    , nonvolitionMonotheisticallyClass :: Maybe (Maybe Text)
    , palatablenessMonotheisticallyClass :: Maybe (Maybe Text)
    , pimperyMonotheisticallyClass :: Maybe (Maybe Text)
    , previolationMonotheisticallyClass :: Maybe (Maybe Text)
    , reconveyanceMonotheisticallyClass :: Maybe (Maybe Text)
    , registershipMonotheisticallyClass :: Maybe (Maybe Text)
    , rhyacoliteMonotheisticallyClass :: Maybe (Maybe Text)
    , smithereensMonotheisticallyClass :: Maybe (Maybe Text)
    , superedificationMonotheisticallyClass :: Maybe (Maybe Text)
    , trustMonotheisticallyClass :: Maybe (Maybe Text)
    , whitestoneMonotheisticallyClass :: Maybe (Maybe Text)
    } deriving (Show)

data Montage
    = DoubleInMontage Double
    | NullArrayInMontage (Vector (Maybe Text))
    | StringInMontage Text
    deriving (Show)

data Moralness
    = DoubleInMoralness Double
    | NullArrayInMoralness (Vector (Maybe Text))
    | NullInMoralness
    deriving (Show)

data Mulishly
    = DoubleInMulishly Double
    | IntegerArrayInMulishly (Vector Int)
    | NullInMulishly
    deriving (Show)

data Myoscope
    = BoolInMyoscope Bool
    | IntegerInMyoscope Int
    | NullArrayInMyoscope (Vector (Maybe Text))
    deriving (Show)

data Neuromastic
    = DoubleInNeuromastic Double
    | NullArrayInNeuromastic (Vector (Maybe Text))
    deriving (Show)

data Noncontributing = Noncontributing
    { estevinNoncontributing :: Text
    , jolterheadNoncontributing :: Double
    , sauternesNoncontributing :: Int
    , sparselyNoncontributing :: Bool
    , unrequestedNoncontributing :: Maybe Text
    } deriving (Show)

data Nonnervous
    = BoolInNonnervous Bool
    | IntegerInNonnervous Int
    deriving (Show)

data Nonvaluation
    = BoolInNonvaluation Bool
    | DoubleInNonvaluation Double
    | NullArrayInNonvaluation (Vector (Maybe Text))
    deriving (Show)

data OccupationalistElement
    = NullArrayInOccupationalistElement (Vector (Maybe Text))
    | NullInOccupationalistElement
    | OccupationalistClassInOccupationalistElement OccupationalistClass
    deriving (Show)

data OccupationalistClass = OccupationalistClass
    { beholdableOccupationalistClass :: Maybe Text
    , brotuliformOccupationalistClass :: Maybe Text
    , chimakumOccupationalistClass :: Maybe Text
    , doodlerOccupationalistClass :: Maybe Text
    , emulsinOccupationalistClass :: Maybe Text
    , finOccupationalistClass :: Maybe Text
    , flourishingOccupationalistClass :: Maybe Text
    , fluelessOccupationalistClass :: Maybe Text
    , furtivelyOccupationalistClass :: Maybe Text
    , gritterOccupationalistClass :: Maybe Text
    , interwishOccupationalistClass :: Maybe Text
    , monoxylicOccupationalistClass :: Maybe Text
    , myristicOccupationalistClass :: Maybe Text
    , nightwearOccupationalistClass :: Maybe Text
    , peruserOccupationalistClass :: Maybe Text
    , theoastrologicalOccupationalistClass :: Maybe Text
    , thumbyOccupationalistClass :: Maybe Text
    , tingitidOccupationalistClass :: Maybe Text
    , traillessOccupationalistClass :: Maybe Text
    , unpocketedOccupationalistClass :: Maybe Text
    } deriving (Show)

data OutrivalElement
    = DoubleInOutrivalElement Double
    | NullInOutrivalElement
    | OutrivalClassInOutrivalElement OutrivalClass
    deriving (Show)

data OutrivalClass = OutrivalClass
    { adroitlyOutrivalClass :: Maybe Text
    , bridehoodOutrivalClass :: Maybe Text
    , castoroidesOutrivalClass :: Maybe Text
    , czechoslovakOutrivalClass :: Maybe Text
    , diagenesisOutrivalClass :: Maybe Text
    , dihexahedronOutrivalClass :: Maybe Text
    , dopesterOutrivalClass :: Maybe Text
    , eumerismOutrivalClass :: Maybe Text
    , flynessOutrivalClass :: Maybe Text
    , foulerOutrivalClass :: Maybe Text
    , laudanosineOutrivalClass :: Maybe Text
    , lingulidaeOutrivalClass :: Maybe Text
    , minutaryOutrivalClass :: Maybe Text
    , mitraOutrivalClass :: Maybe Text
    , opisthorchiasisOutrivalClass :: Maybe Text
    , pensivelyOutrivalClass :: Maybe Text
    , pubigerousOutrivalClass :: Maybe Text
    , rebelliousOutrivalClass :: Maybe Text
    , recodifyOutrivalClass :: Maybe Text
    , unpacedOutrivalClass :: Maybe Text
    } deriving (Show)

data Paleographically
    = DoubleInPaleographically Double
    | UnionMapInPaleographically (HashMap Text (Maybe Int))
    deriving (Show)

data Pamphletwise
    = IntegerInPamphletwise Int
    | IntegerMapInPamphletwise (HashMap Text Int)
    | StringInPamphletwise Text
    deriving (Show)

data Pediatric
    = BoolInPediatric Bool
    | DoubleInPediatric Double
    | NullInPediatric
    deriving (Show)

data PiaculumElement
    = DoubleInPiaculumElement Double
    | PiaculumClassInPiaculumElement PiaculumClass
    deriving (Show)

data PiaculumClass = PiaculumClass
    { aladaPiaculumClass :: Maybe Int
    , amphistomousPiaculumClass :: Maybe Int
    , boysenberryPiaculumClass :: Maybe Int
    , catharticalnessPiaculumClass :: Maybe Double
    , chirotheriumPiaculumClass :: Maybe Int
    , decardinalizePiaculumClass :: Maybe Int
    , discouragementPiaculumClass :: Maybe Int
    , disdiapasonPiaculumClass :: Maybe Text
    , doitrifiedPiaculumClass :: Maybe Int
    , hexaspermousPiaculumClass :: Maybe Int
    , homocercPiaculumClass :: Maybe Bool
    , insinkingPiaculumClass :: Maybe Int
    , loathfulnessPiaculumClass :: Maybe Int
    , miasmaticalPiaculumClass :: Maybe Int
    , neurofibrilPiaculumClass :: Maybe Int
    , nonbookishPiaculumClass :: Maybe (Maybe Text)
    , phonendoscopePiaculumClass :: Maybe Int
    , pilfermentPiaculumClass :: Maybe Int
    , predismissoryPiaculumClass :: Maybe Int
    , preinscriptionPiaculumClass :: Maybe Int
    , quotativePiaculumClass :: Maybe Int
    , siennaPiaculumClass :: Maybe Int
    , thoraxPiaculumClass :: Maybe Int
    , yachtingPiaculumClass :: Maybe Int
    , zipperPiaculumClass :: Maybe Int
    } deriving (Show)

data Piccadilly
    = DoubleInPiccadilly Double
    | NullInPiccadilly
    | StringInPiccadilly Text
    deriving (Show)

data Piffler
    = MonaziteClassInPiffler MonaziteClass
    | NullArrayInPiffler (Vector (Maybe Text))
    deriving (Show)

data Pithful
    = BoolInPithful Bool
    | IntegerInPithful Int
    | NullInPithful
    deriving (Show)

data Placuntiti
    = IntegerInPlacuntiti Int
    | IntegerMapInPlacuntiti (HashMap Text Int)
    deriving (Show)

data Plectopterous
    = DoubleInPlectopterous Double
    | IntegerMapInPlectopterous (HashMap Text Int)
    deriving (Show)

data Pneumocele = Pneumocele
    { carbonarismPneumocele :: Maybe (Maybe Text)
    , catharticalnessPneumocele :: Maybe Double
    , chirotheriumPneumocele :: Maybe Int
    , cineolicPneumocele :: Maybe (Maybe Text)
    , cobblyPneumocele :: Maybe (Maybe Text)
    , conchyliferousPneumocele :: Maybe (Maybe Text)
    , congregationPneumocele :: Maybe (Maybe Text)
    , disdiapasonPneumocele :: Maybe Text
    , enterotomyPneumocele :: Maybe (Maybe Text)
    , entophytalPneumocele :: Maybe (Maybe Text)
    , fewtrilsPneumocele :: Maybe (Maybe Text)
    , heremPneumocele :: Maybe (Maybe Text)
    , homocercPneumocele :: Maybe Bool
    , konigaPneumocele :: Maybe (Maybe Text)
    , meticulosityPneumocele :: Maybe (Maybe Text)
    , mickyPneumocele :: Maybe (Maybe Text)
    , mismarriagePneumocele :: Maybe (Maybe Text)
    , neurotrophicPneumocele :: Maybe (Maybe Text)
    , nonbookishPneumocele :: Maybe (Maybe Text)
    , persuasivelyPneumocele :: Maybe (Maybe Text)
    , replaceablePneumocele :: Maybe (Maybe Text)
    , silexPneumocele :: Maybe (Maybe Text)
    , taillightPneumocele :: Maybe (Maybe Text)
    , unjealousPneumocele :: Maybe (Maybe Text)
    , visitorialPneumocele :: Maybe (Maybe Text)
    } deriving (Show)

data Poliorcetic
    = BoolInPoliorcetic Bool
    | MonaziteClassInPoliorcetic MonaziteClass
    deriving (Show)

data Poormaster
    = IntegerArrayInPoormaster (Vector Int)
    | IntegerMapInPoormaster (HashMap Text Int)
    | NullInPoormaster
    deriving (Show)

data PotwhiskyElement
    = IntegerInPotwhiskyElement Int
    | NullInPotwhiskyElement
    | PotwhiskyClassInPotwhiskyElement PotwhiskyClass
    deriving (Show)

data PotwhiskyClass = PotwhiskyClass
    { arciformPotwhiskyClass :: Maybe Text
    , cresolinPotwhiskyClass :: Maybe Text
    , disheartenerPotwhiskyClass :: Maybe Text
    , disproportionablePotwhiskyClass :: Maybe Text
    , euchordaPotwhiskyClass :: Maybe Text
    , ferrywayPotwhiskyClass :: Maybe Text
    , filamentiferousPotwhiskyClass :: Maybe Text
    , flemishPotwhiskyClass :: Maybe Text
    , forgainstPotwhiskyClass :: Maybe Text
    , graineringPotwhiskyClass :: Maybe Text
    , irrevolublePotwhiskyClass :: Maybe Text
    , kindredshipPotwhiskyClass :: Maybe Text
    , pinguitudinousPotwhiskyClass :: Maybe Text
    , simpletonicPotwhiskyClass :: Maybe Text
    , singsongPotwhiskyClass :: Maybe Text
    , submergementPotwhiskyClass :: Maybe Text
    , supraoesophagalPotwhiskyClass :: Maybe Text
    , thrashelPotwhiskyClass :: Maybe Text
    , tyremesisPotwhiskyClass :: Maybe Text
    , yorubaPotwhiskyClass :: Maybe Text
    } deriving (Show)

data Practicalizer
    = MonaziteClassInPracticalizer MonaziteClass
    | NullArrayInPracticalizer (Vector (Maybe Text))
    | StringInPracticalizer Text
    deriving (Show)

data PrefreshmanElement
    = NullArrayInPrefreshmanElement (Vector (Maybe Text))
    | PrefreshmanClassInPrefreshmanElement PrefreshmanClass
    | StringInPrefreshmanElement Text
    deriving (Show)

data PrefreshmanClass = PrefreshmanClass
    { azorubinePrefreshmanClass :: Maybe Text
    , choroiditisPrefreshmanClass :: Maybe Text
    , coagulatoryPrefreshmanClass :: Maybe Text
    , cycloramaPrefreshmanClass :: Maybe Text
    , dolphusPrefreshmanClass :: Maybe Text
    , duckheartedPrefreshmanClass :: Maybe Text
    , ficusPrefreshmanClass :: Maybe Text
    , gemaricPrefreshmanClass :: Maybe Text
    , jugationPrefreshmanClass :: Maybe Text
    , myoliposisPrefreshmanClass :: Maybe Text
    , nonnominationPrefreshmanClass :: Maybe Text
    , palayPrefreshmanClass :: Maybe Text
    , pentactinalPrefreshmanClass :: Maybe Text
    , phaetPrefreshmanClass :: Maybe Text
    , piquantPrefreshmanClass :: Maybe Text
    , registrationPrefreshmanClass :: Maybe Text
    , remancipationPrefreshmanClass :: Maybe Text
    , scutatiformPrefreshmanClass :: Maybe Text
    , theodolitePrefreshmanClass :: Maybe Text
    , underwardPrefreshmanClass :: Maybe Text
    } deriving (Show)

data Prehensility
    = BoolInPrehensility Bool
    | MonaziteClassInPrehensility MonaziteClass
    | NullArrayInPrehensility (Vector (Maybe Text))
    deriving (Show)

data Prevoidance
    = IntegerArrayInPrevoidance (Vector Int)
    | IntegerInPrevoidance Int
    | MonaziteClassInPrevoidance MonaziteClass
    deriving (Show)

data Protext
    = BoolInProtext Bool
    | IntegerArrayInProtext (Vector Int)
    | MonaziteClassInProtext MonaziteClass
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType jurorQuickType kongoniQuickType ladronismQuickType landlubberlyQuickType listenerQuickType lupusQuickType maslinQuickType monaziteQuickType monoliteralQuickType monotheisticallyQuickType montageQuickType moralnessQuickType mowraQuickType mulishlyQuickType myoscopeQuickType nachQuickType neuromasticQuickType noncontributingQuickType nonnervousQuickType nonvaluationQuickType occupationalistQuickType outrivalQuickType paleographicallyQuickType pamphletwiseQuickType pediatricsQuickType perceptiveQuickType piaculumQuickType piccadillyQuickType pifflerQuickType pithfulQuickType placuntitisQuickType plectopterousQuickType pneumoceleQuickType poliorceticQuickType poormasterQuickType potwhiskyQuickType practicalizerQuickType prefreshmanQuickType prehensilityQuickType prevoidanceQuickType probantQuickType protextQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "juror" .= jurorQuickType
        , Just $ "kongoni" .= kongoniQuickType
        , Just $ "ladronism" .= ladronismQuickType
        , Just $ "landlubberly" .= landlubberlyQuickType
        , Just $ "listener" .= listenerQuickType
        , Just $ "lupus" .= lupusQuickType
        , Just $ "maslin" .= maslinQuickType
        , Just $ "monazite" .= monaziteQuickType
        , Just $ "monoliteral" .= monoliteralQuickType
        , Just $ "monotheistically" .= monotheisticallyQuickType
        , Just $ "montage" .= montageQuickType
        , Just $ "moralness" .= moralnessQuickType
        , Just $ "mowra" .= mowraQuickType
        , Just $ "mulishly" .= mulishlyQuickType
        , Just $ "myoscope" .= myoscopeQuickType
        , Just $ "nach" .= nachQuickType
        , Just $ "neuromastic" .= neuromasticQuickType
        , Just $ "noncontributing" .= noncontributingQuickType
        , Just $ "nonnervous" .= nonnervousQuickType
        , Just $ "nonvaluation" .= nonvaluationQuickType
        , Just $ "occupationalist" .= occupationalistQuickType
        , Just $ "outrival" .= outrivalQuickType
        , Just $ "paleographically" .= paleographicallyQuickType
        , Just $ "pamphletwise" .= pamphletwiseQuickType
        , Just $ "pediatrics" .= pediatricsQuickType
        , Just $ "perceptive" .= perceptiveQuickType
        , Just $ "piaculum" .= piaculumQuickType
        , Just $ "piccadilly" .= piccadillyQuickType
        , Just $ "piffler" .= pifflerQuickType
        , Just $ "pithful" .= pithfulQuickType
        , Just $ "placuntitis" .= placuntitisQuickType
        , Just $ "plectopterous" .= plectopterousQuickType
        , Just $ "pneumocele" .= pneumoceleQuickType
        , Just $ "poliorcetic" .= poliorceticQuickType
        , Just $ "poormaster" .= poormasterQuickType
        , Just $ "potwhisky" .= potwhiskyQuickType
        , Just $ "practicalizer" .= practicalizerQuickType
        , Just $ "prefreshman" .= prefreshmanQuickType
        , Just $ "prehensility" .= prehensilityQuickType
        , Just $ "prevoidance" .= prevoidanceQuickType
        , Just $ "probant" .= probantQuickType
        , Just $ "protext" .= protextQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "juror"
        <*> v .: "kongoni"
        <*> v .: "ladronism"
        <*> v .: "landlubberly"
        <*> v .: "listener"
        <*> v .: "lupus"
        <*> v .: "maslin"
        <*> v .: "monazite"
        <*> v .: "monoliteral"
        <*> v .: "monotheistically"
        <*> v .: "montage"
        <*> v .: "moralness"
        <*> v .: "mowra"
        <*> v .: "mulishly"
        <*> v .: "myoscope"
        <*> v .: "nach"
        <*> v .: "neuromastic"
        <*> v .: "noncontributing"
        <*> v .: "nonnervous"
        <*> v .: "nonvaluation"
        <*> v .: "occupationalist"
        <*> v .: "outrival"
        <*> v .: "paleographically"
        <*> v .: "pamphletwise"
        <*> v .: "pediatrics"
        <*> v .: "perceptive"
        <*> v .: "piaculum"
        <*> v .: "piccadilly"
        <*> v .: "piffler"
        <*> v .: "pithful"
        <*> v .: "placuntitis"
        <*> v .: "plectopterous"
        <*> v .: "pneumocele"
        <*> v .: "poliorcetic"
        <*> v .: "poormaster"
        <*> v .: "potwhisky"
        <*> v .: "practicalizer"
        <*> v .: "prefreshman"
        <*> v .: "prehensility"
        <*> v .: "prevoidance"
        <*> v .: "probant"
        <*> v .: "protext"

instance ToJSON JurorElement where
    toJSON (BoolInJurorElement x) = toJSON x
    toJSON (JurorClassInJurorElement x) = toJSON x

instance FromJSON JurorElement where
    parseJSON xs@(Bool _) = (fmap BoolInJurorElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JurorClassInJurorElement . parseJSON) xs

instance ToJSON JurorClass where
    toJSON (JurorClass adipsyJurorClass auxiliatorJurorClass bendaJurorClass benjaminJurorClass brandlingJurorClass epicurishlyJurorClass eremochaetousJurorClass martenJurorClass monoclineJurorClass oleaJurorClass palgatJurorClass pennyworthJurorClass piouryJurorClass pragmatisticJurorClass stylelessnessJurorClass systematicalJurorClass threadyJurorClass uncontemporaryJurorClass uncouchedJurorClass uninhabitednessJurorClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "adipsy" .= adipsyJurorClass
        , Just $ "auxiliator" .= auxiliatorJurorClass
        , Just $ "benda" .= bendaJurorClass
        , Just $ "benjamin" .= benjaminJurorClass
        , Just $ "brandling" .= brandlingJurorClass
        , Just $ "epicurishly" .= epicurishlyJurorClass
        , Just $ "eremochaetous" .= eremochaetousJurorClass
        , Just $ "marten" .= martenJurorClass
        , Just $ "monocline" .= monoclineJurorClass
        , Just $ "Olea" .= oleaJurorClass
        , Just $ "palgat" .= palgatJurorClass
        , Just $ "pennyworth" .= pennyworthJurorClass
        , Just $ "pioury" .= piouryJurorClass
        , Just $ "pragmatistic" .= pragmatisticJurorClass
        , Just $ "stylelessness" .= stylelessnessJurorClass
        , Just $ "systematical" .= systematicalJurorClass
        , Just $ "thready" .= threadyJurorClass
        , Just $ "uncontemporary" .= uncontemporaryJurorClass
        , Just $ "uncouched" .= uncouchedJurorClass
        , Just $ "uninhabitedness" .= uninhabitednessJurorClass
        ]

instance FromJSON JurorClass where
    parseJSON (Object v) = JurorClass
        <$> v .: "adipsy"
        <*> v .: "auxiliator"
        <*> v .: "benda"
        <*> v .: "benjamin"
        <*> v .: "brandling"
        <*> v .: "epicurishly"
        <*> v .: "eremochaetous"
        <*> v .: "marten"
        <*> v .: "monocline"
        <*> v .: "Olea"
        <*> v .: "palgat"
        <*> v .: "pennyworth"
        <*> v .: "pioury"
        <*> v .: "pragmatistic"
        <*> v .: "stylelessness"
        <*> v .: "systematical"
        <*> v .: "thready"
        <*> v .: "uncontemporary"
        <*> v .: "uncouched"
        <*> v .: "uninhabitedness"

instance ToJSON Kongoni where
    toJSON (IntegerArrayInKongoni x) = toJSON x
    toJSON (IntegerMapInKongoni x) = toJSON x

instance FromJSON Kongoni where
    parseJSON xs@(Array _) = (fmap IntegerArrayInKongoni . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInKongoni . parseJSON) xs

instance ToJSON LadronismElement where
    toJSON (DoubleInLadronismElement x) = toJSON x
    toJSON (LadronismClassInLadronismElement x) = toJSON x
    toJSON (StringInLadronismElement x) = toJSON x

instance FromJSON LadronismElement where
    parseJSON xs@(Number _) = (fmap DoubleInLadronismElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LadronismClassInLadronismElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInLadronismElement . parseJSON) xs

instance ToJSON LadronismClass where
    toJSON (LadronismClass acclaimerLadronismClass achreeLadronismClass baseLadronismClass conundrumizeLadronismClass degerminatorLadronismClass describableLadronismClass exasperatedlyLadronismClass heroineLadronismClass indazinLadronismClass luteousLadronismClass papularLadronismClass pritchLadronismClass prodeniaLadronismClass seegeLadronismClass shopgirlLadronismClass tragediettaLadronismClass unsparseLadronismClass uplookLadronismClass vermiformisLadronismClass whafaboutLadronismClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "acclaimer" .= acclaimerLadronismClass
        , Just $ "achree" .= achreeLadronismClass
        , Just $ "base" .= baseLadronismClass
        , Just $ "conundrumize" .= conundrumizeLadronismClass
        , Just $ "degerminator" .= degerminatorLadronismClass
        , Just $ "describable" .= describableLadronismClass
        , Just $ "exasperatedly" .= exasperatedlyLadronismClass
        , Just $ "heroine" .= heroineLadronismClass
        , Just $ "indazin" .= indazinLadronismClass
        , Just $ "luteous" .= luteousLadronismClass
        , Just $ "papular" .= papularLadronismClass
        , Just $ "pritch" .= pritchLadronismClass
        , Just $ "Prodenia" .= prodeniaLadronismClass
        , Just $ "seege" .= seegeLadronismClass
        , Just $ "shopgirl" .= shopgirlLadronismClass
        , Just $ "tragedietta" .= tragediettaLadronismClass
        , Just $ "unsparse" .= unsparseLadronismClass
        , Just $ "uplook" .= uplookLadronismClass
        , Just $ "vermiformis" .= vermiformisLadronismClass
        , Just $ "whafabout" .= whafaboutLadronismClass
        ]

instance FromJSON LadronismClass where
    parseJSON (Object v) = LadronismClass
        <$> v .: "acclaimer"
        <*> v .: "achree"
        <*> v .: "base"
        <*> v .: "conundrumize"
        <*> v .: "degerminator"
        <*> v .: "describable"
        <*> v .: "exasperatedly"
        <*> v .: "heroine"
        <*> v .: "indazin"
        <*> v .: "luteous"
        <*> v .: "papular"
        <*> v .: "pritch"
        <*> v .: "Prodenia"
        <*> v .: "seege"
        <*> v .: "shopgirl"
        <*> v .: "tragedietta"
        <*> v .: "unsparse"
        <*> v .: "uplook"
        <*> v .: "vermiformis"
        <*> v .: "whafabout"

instance ToJSON LandlubberlyElement where
    toJSON (BoolInLandlubberlyElement x) = toJSON x
    toJSON (IntegerInLandlubberlyElement x) = toJSON x
    toJSON (LandlubberlyClassInLandlubberlyElement x) = toJSON x

instance FromJSON LandlubberlyElement where
    parseJSON xs@(Bool _) = (fmap BoolInLandlubberlyElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInLandlubberlyElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LandlubberlyClassInLandlubberlyElement . parseJSON) xs

instance ToJSON LandlubberlyClass where
    toJSON (LandlubberlyClass acropoleisLandlubberlyClass aminateLandlubberlyClass amyraldismLandlubberlyClass bipenniformLandlubberlyClass bugreLandlubberlyClass calyculeLandlubberlyClass caoutchoucLandlubberlyClass disproverLandlubberlyClass fitrootLandlubberlyClass fulgentlyLandlubberlyClass kickupLandlubberlyClass laevoversionLandlubberlyClass moterLandlubberlyClass objectivityLandlubberlyClass posterityLandlubberlyClass postnuptialLandlubberlyClass precedentaryLandlubberlyClass saddlingLandlubberlyClass subcurrentLandlubberlyClass unrecriminativeLandlubberlyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "acropoleis" .= acropoleisLandlubberlyClass
        , Just $ "aminate" .= aminateLandlubberlyClass
        , Just $ "Amyraldism" .= amyraldismLandlubberlyClass
        , Just $ "bipenniform" .= bipenniformLandlubberlyClass
        , Just $ "bugre" .= bugreLandlubberlyClass
        , Just $ "calycule" .= calyculeLandlubberlyClass
        , Just $ "caoutchouc" .= caoutchoucLandlubberlyClass
        , Just $ "disprover" .= disproverLandlubberlyClass
        , Just $ "fitroot" .= fitrootLandlubberlyClass
        , Just $ "fulgently" .= fulgentlyLandlubberlyClass
        , Just $ "kickup" .= kickupLandlubberlyClass
        , Just $ "laevoversion" .= laevoversionLandlubberlyClass
        , Just $ "moter" .= moterLandlubberlyClass
        , Just $ "objectivity" .= objectivityLandlubberlyClass
        , Just $ "posterity" .= posterityLandlubberlyClass
        , Just $ "postnuptial" .= postnuptialLandlubberlyClass
        , Just $ "precedentary" .= precedentaryLandlubberlyClass
        , Just $ "saddling" .= saddlingLandlubberlyClass
        , Just $ "subcurrent" .= subcurrentLandlubberlyClass
        , Just $ "unrecriminative" .= unrecriminativeLandlubberlyClass
        ]

instance FromJSON LandlubberlyClass where
    parseJSON (Object v) = LandlubberlyClass
        <$> v .: "acropoleis"
        <*> v .: "aminate"
        <*> v .: "Amyraldism"
        <*> v .: "bipenniform"
        <*> v .: "bugre"
        <*> v .: "calycule"
        <*> v .: "caoutchouc"
        <*> v .: "disprover"
        <*> v .: "fitroot"
        <*> v .: "fulgently"
        <*> v .: "kickup"
        <*> v .: "laevoversion"
        <*> v .: "moter"
        <*> v .: "objectivity"
        <*> v .: "posterity"
        <*> v .: "postnuptial"
        <*> v .: "precedentary"
        <*> v .: "saddling"
        <*> v .: "subcurrent"
        <*> v .: "unrecriminative"

instance ToJSON Listener where
    toJSON (IntegerInListener x) = toJSON x
    toJSON (NullArrayInListener x) = toJSON x

instance FromJSON Listener where
    parseJSON xs@(Number _) = (fmap IntegerInListener . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInListener . parseJSON) xs

instance ToJSON LupusElement where
    toJSON (IntegerInLupusElement x) = toJSON x
    toJSON (LupusClassInLupusElement x) = toJSON x

instance FromJSON LupusElement where
    parseJSON xs@(Number _) = (fmap IntegerInLupusElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap LupusClassInLupusElement . parseJSON) xs

instance ToJSON LupusClass where
    toJSON (LupusClass catharticalnessLupusClass chirotheriumLupusClass chlorioninaeLupusClass corvinaeLupusClass crassinaLupusClass disdiapasonLupusClass exiguityLupusClass farcistLupusClass holographicalLupusClass homocercLupusClass ichthyophaganLupusClass implacableLupusClass nonbookishLupusClass outshinerLupusClass overweatherLupusClass protonegroidLupusClass shallowishLupusClass snokeLupusClass snoutLupusClass surveillanceLupusClass threshingtimeLupusClass thysanocarpusLupusClass unsignificantlyLupusClass unsnapLupusClass vendibleLupusClass) =
        object $ foldMap (maybe [] pure)
        [ ("catharticalness" .=) <$> catharticalnessLupusClass
        , ("Chirotherium" .=) <$> chirotheriumLupusClass
        , ("Chlorioninae" .=) <$> chlorioninaeLupusClass
        , ("Corvinae" .=) <$> corvinaeLupusClass
        , ("Crassina" .=) <$> crassinaLupusClass
        , ("disdiapason" .=) <$> disdiapasonLupusClass
        , ("exiguity" .=) <$> exiguityLupusClass
        , ("farcist" .=) <$> farcistLupusClass
        , ("holographical" .=) <$> holographicalLupusClass
        , ("homocerc" .=) <$> homocercLupusClass
        , ("ichthyophagan" .=) <$> ichthyophaganLupusClass
        , ("implacable" .=) <$> implacableLupusClass
        , ("nonbookish" .=) <$> nonbookishLupusClass
        , ("outshiner" .=) <$> outshinerLupusClass
        , ("overweather" .=) <$> overweatherLupusClass
        , ("protonegroid" .=) <$> protonegroidLupusClass
        , ("shallowish" .=) <$> shallowishLupusClass
        , ("snoke" .=) <$> snokeLupusClass
        , ("snout" .=) <$> snoutLupusClass
        , ("surveillance" .=) <$> surveillanceLupusClass
        , ("threshingtime" .=) <$> threshingtimeLupusClass
        , ("Thysanocarpus" .=) <$> thysanocarpusLupusClass
        , ("unsignificantly" .=) <$> unsignificantlyLupusClass
        , ("unsnap" .=) <$> unsnapLupusClass
        , ("vendible" .=) <$> vendibleLupusClass
        ]

instance FromJSON LupusClass where
    parseJSON (Object v) = LupusClass
        <$> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "Chlorioninae"
        <*> v .:! "Corvinae"
        <*> v .:! "Crassina"
        <*> v .:! "disdiapason"
        <*> v .:! "exiguity"
        <*> v .:! "farcist"
        <*> v .:! "holographical"
        <*> v .:! "homocerc"
        <*> v .:! "ichthyophagan"
        <*> v .:! "implacable"
        <*> v .:! "nonbookish"
        <*> v .:! "outshiner"
        <*> v .:! "overweather"
        <*> v .:! "protonegroid"
        <*> v .:! "shallowish"
        <*> v .:! "snoke"
        <*> v .:! "snout"
        <*> v .:! "surveillance"
        <*> v .:! "threshingtime"
        <*> v .:! "Thysanocarpus"
        <*> v .:! "unsignificantly"
        <*> v .:! "unsnap"
        <*> v .:! "vendible"

instance ToJSON Maslin where
    toJSON (Maslin alicantMaslin antiatonementMaslin anticorrosiveMaslin aphidozerMaslin bakuninistMaslin beMaslin catharticalnessMaslin chirotheriumMaslin chubMaslin cuprosiliconMaslin curtailedlyMaslin delleniteMaslin dimitryMaslin disdiapasonMaslin edifyingMaslin ethmoiditisMaslin gastralgyMaslin goatherdMaslin hammerdressMaslin hangfireMaslin homocercMaslin lacunosityMaslin longiloquenceMaslin mameliereMaslin motherlessMaslin nonbookishMaslin noncorrodibleMaslin nonsensicalityMaslin oafishlyMaslin pfundMaslin preadvisoryMaslin retroflexedMaslin saccharulmicMaslin scowlfulMaslin secludedMaslin slackageMaslin sphaeridialMaslin spondulicsMaslin subseciveMaslin swellmobsmanMaslin trachyglossateMaslin trialogueMaslin unassuagedMaslin ungrossMaslin unjudiciouslyMaslin) =
        object $ foldMap (maybe [] pure)
        [ ("Alicant" .=) <$> alicantMaslin
        , ("antiatonement" .=) <$> antiatonementMaslin
        , ("anticorrosive" .=) <$> anticorrosiveMaslin
        , ("aphidozer" .=) <$> aphidozerMaslin
        , ("Bakuninist" .=) <$> bakuninistMaslin
        , ("be" .=) <$> beMaslin
        , ("catharticalness" .=) <$> catharticalnessMaslin
        , ("Chirotherium" .=) <$> chirotheriumMaslin
        , ("chub" .=) <$> chubMaslin
        , ("cuprosilicon" .=) <$> cuprosiliconMaslin
        , ("curtailedly" .=) <$> curtailedlyMaslin
        , ("dellenite" .=) <$> delleniteMaslin
        , ("Dimitry" .=) <$> dimitryMaslin
        , ("disdiapason" .=) <$> disdiapasonMaslin
        , ("edifying" .=) <$> edifyingMaslin
        , ("ethmoiditis" .=) <$> ethmoiditisMaslin
        , ("gastralgy" .=) <$> gastralgyMaslin
        , ("goatherd" .=) <$> goatherdMaslin
        , ("hammerdress" .=) <$> hammerdressMaslin
        , ("hangfire" .=) <$> hangfireMaslin
        , ("homocerc" .=) <$> homocercMaslin
        , ("lacunosity" .=) <$> lacunosityMaslin
        , ("longiloquence" .=) <$> longiloquenceMaslin
        , ("mameliere" .=) <$> mameliereMaslin
        , ("motherless" .=) <$> motherlessMaslin
        , ("nonbookish" .=) <$> nonbookishMaslin
        , ("noncorrodible" .=) <$> noncorrodibleMaslin
        , ("nonsensicality" .=) <$> nonsensicalityMaslin
        , ("oafishly" .=) <$> oafishlyMaslin
        , ("pfund" .=) <$> pfundMaslin
        , ("preadvisory" .=) <$> preadvisoryMaslin
        , ("retroflexed" .=) <$> retroflexedMaslin
        , ("saccharulmic" .=) <$> saccharulmicMaslin
        , ("scowlful" .=) <$> scowlfulMaslin
        , ("secluded" .=) <$> secludedMaslin
        , ("slackage" .=) <$> slackageMaslin
        , ("sphaeridial" .=) <$> sphaeridialMaslin
        , ("spondulics" .=) <$> spondulicsMaslin
        , ("subsecive" .=) <$> subseciveMaslin
        , ("swellmobsman" .=) <$> swellmobsmanMaslin
        , ("trachyglossate" .=) <$> trachyglossateMaslin
        , ("trialogue" .=) <$> trialogueMaslin
        , ("unassuaged" .=) <$> unassuagedMaslin
        , ("ungross" .=) <$> ungrossMaslin
        , ("unjudiciously" .=) <$> unjudiciouslyMaslin
        ]

instance FromJSON Maslin where
    parseJSON (Object v) = Maslin
        <$> v .:! "Alicant"
        <*> v .:! "antiatonement"
        <*> v .:! "anticorrosive"
        <*> v .:! "aphidozer"
        <*> v .:! "Bakuninist"
        <*> v .:! "be"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "chub"
        <*> v .:! "cuprosilicon"
        <*> v .:! "curtailedly"
        <*> v .:! "dellenite"
        <*> v .:! "Dimitry"
        <*> v .:! "disdiapason"
        <*> v .:! "edifying"
        <*> v .:! "ethmoiditis"
        <*> v .:! "gastralgy"
        <*> v .:! "goatherd"
        <*> v .:! "hammerdress"
        <*> v .:! "hangfire"
        <*> v .:! "homocerc"
        <*> v .:! "lacunosity"
        <*> v .:! "longiloquence"
        <*> v .:! "mameliere"
        <*> v .:! "motherless"
        <*> v .:! "nonbookish"
        <*> v .:! "noncorrodible"
        <*> v .:! "nonsensicality"
        <*> v .:! "oafishly"
        <*> v .:! "pfund"
        <*> v .:! "preadvisory"
        <*> v .:! "retroflexed"
        <*> v .:! "saccharulmic"
        <*> v .:! "scowlful"
        <*> v .:! "secluded"
        <*> v .:! "slackage"
        <*> v .:! "sphaeridial"
        <*> v .:! "spondulics"
        <*> v .:! "subsecive"
        <*> v .:! "swellmobsman"
        <*> v .:! "trachyglossate"
        <*> v .:! "trialogue"
        <*> v .:! "unassuaged"
        <*> v .:! "ungross"
        <*> v .:! "unjudiciously"

instance ToJSON MonaziteElement where
    toJSON (DoubleInMonaziteElement x) = toJSON x
    toJSON (MonaziteClassInMonaziteElement x) = toJSON x

instance FromJSON MonaziteElement where
    parseJSON xs@(Number _) = (fmap DoubleInMonaziteElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MonaziteClassInMonaziteElement . parseJSON) xs

instance ToJSON MonaziteClass where
    toJSON (MonaziteClass catharticalnessMonaziteClass chirotheriumMonaziteClass disdiapasonMonaziteClass homocercMonaziteClass nonbookishMonaziteClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "catharticalness" .= catharticalnessMonaziteClass
        , Just $ "Chirotherium" .= chirotheriumMonaziteClass
        , Just $ "disdiapason" .= disdiapasonMonaziteClass
        , Just $ "homocerc" .= homocercMonaziteClass
        , Just $ "nonbookish" .= nonbookishMonaziteClass
        ]

instance FromJSON MonaziteClass where
    parseJSON (Object v) = MonaziteClass
        <$> v .: "catharticalness"
        <*> v .: "Chirotherium"
        <*> v .: "disdiapason"
        <*> v .: "homocerc"
        <*> v .: "nonbookish"

instance ToJSON Monoliteral where
    toJSON (BoolInMonoliteral x) = toJSON x
    toJSON (NullArrayInMonoliteral x) = toJSON x

instance FromJSON Monoliteral where
    parseJSON xs@(Bool _) = (fmap BoolInMonoliteral . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInMonoliteral . parseJSON) xs

instance ToJSON MonotheisticallyElement where
    toJSON (MonotheisticallyClassInMonotheisticallyElement x) = toJSON x
    toJSON (NullArrayInMonotheisticallyElement x) = toJSON x

instance FromJSON MonotheisticallyElement where
    parseJSON xs@(Object _) = (fmap MonotheisticallyClassInMonotheisticallyElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInMonotheisticallyElement . parseJSON) xs

instance ToJSON MonotheisticallyClass where
    toJSON (MonotheisticallyClass blasphemeMonotheisticallyClass catharticalnessMonotheisticallyClass celiosalpingectomyMonotheisticallyClass chirotheriumMonotheisticallyClass consummativenessMonotheisticallyClass disdiapasonMonotheisticallyClass egestiveMonotheisticallyClass enchylemaMonotheisticallyClass gasconadeMonotheisticallyClass holidayerMonotheisticallyClass homocercMonotheisticallyClass intuitionalismMonotheisticallyClass lophiostomateMonotheisticallyClass nonbookishMonotheisticallyClass nonvolitionMonotheisticallyClass palatablenessMonotheisticallyClass pimperyMonotheisticallyClass previolationMonotheisticallyClass reconveyanceMonotheisticallyClass registershipMonotheisticallyClass rhyacoliteMonotheisticallyClass smithereensMonotheisticallyClass superedificationMonotheisticallyClass trustMonotheisticallyClass whitestoneMonotheisticallyClass) =
        object $ foldMap (maybe [] pure)
        [ ("blaspheme" .=) <$> blasphemeMonotheisticallyClass
        , ("catharticalness" .=) <$> catharticalnessMonotheisticallyClass
        , ("celiosalpingectomy" .=) <$> celiosalpingectomyMonotheisticallyClass
        , ("Chirotherium" .=) <$> chirotheriumMonotheisticallyClass
        , ("consummativeness" .=) <$> consummativenessMonotheisticallyClass
        , ("disdiapason" .=) <$> disdiapasonMonotheisticallyClass
        , ("egestive" .=) <$> egestiveMonotheisticallyClass
        , ("enchylema" .=) <$> enchylemaMonotheisticallyClass
        , ("gasconade" .=) <$> gasconadeMonotheisticallyClass
        , ("holidayer" .=) <$> holidayerMonotheisticallyClass
        , ("homocerc" .=) <$> homocercMonotheisticallyClass
        , ("intuitionalism" .=) <$> intuitionalismMonotheisticallyClass
        , ("lophiostomate" .=) <$> lophiostomateMonotheisticallyClass
        , ("nonbookish" .=) <$> nonbookishMonotheisticallyClass
        , ("nonvolition" .=) <$> nonvolitionMonotheisticallyClass
        , ("palatableness" .=) <$> palatablenessMonotheisticallyClass
        , ("pimpery" .=) <$> pimperyMonotheisticallyClass
        , ("previolation" .=) <$> previolationMonotheisticallyClass
        , ("reconveyance" .=) <$> reconveyanceMonotheisticallyClass
        , ("registership" .=) <$> registershipMonotheisticallyClass
        , ("rhyacolite" .=) <$> rhyacoliteMonotheisticallyClass
        , ("smithereens" .=) <$> smithereensMonotheisticallyClass
        , ("superedification" .=) <$> superedificationMonotheisticallyClass
        , ("trust" .=) <$> trustMonotheisticallyClass
        , ("whitestone" .=) <$> whitestoneMonotheisticallyClass
        ]

instance FromJSON MonotheisticallyClass where
    parseJSON (Object v) = MonotheisticallyClass
        <$> v .:! "blaspheme"
        <*> v .:! "catharticalness"
        <*> v .:! "celiosalpingectomy"
        <*> v .:! "Chirotherium"
        <*> v .:! "consummativeness"
        <*> v .:! "disdiapason"
        <*> v .:! "egestive"
        <*> v .:! "enchylema"
        <*> v .:! "gasconade"
        <*> v .:! "holidayer"
        <*> v .:! "homocerc"
        <*> v .:! "intuitionalism"
        <*> v .:! "lophiostomate"
        <*> v .:! "nonbookish"
        <*> v .:! "nonvolition"
        <*> v .:! "palatableness"
        <*> v .:! "pimpery"
        <*> v .:! "previolation"
        <*> v .:! "reconveyance"
        <*> v .:! "registership"
        <*> v .:! "rhyacolite"
        <*> v .:! "smithereens"
        <*> v .:! "superedification"
        <*> v .:! "trust"
        <*> v .:! "whitestone"

instance ToJSON Montage where
    toJSON (DoubleInMontage x) = toJSON x
    toJSON (NullArrayInMontage x) = toJSON x
    toJSON (StringInMontage x) = toJSON x

instance FromJSON Montage where
    parseJSON xs@(Number _) = (fmap DoubleInMontage . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInMontage . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInMontage . parseJSON) xs

instance ToJSON Moralness where
    toJSON (DoubleInMoralness x) = toJSON x
    toJSON (NullArrayInMoralness x) = toJSON x
    toJSON NullInMoralness = Null

instance FromJSON Moralness where
    parseJSON xs@(Number _) = (fmap DoubleInMoralness . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInMoralness . parseJSON) xs
    parseJSON Null = return NullInMoralness

instance ToJSON Mulishly where
    toJSON (DoubleInMulishly x) = toJSON x
    toJSON (IntegerArrayInMulishly x) = toJSON x
    toJSON NullInMulishly = Null

instance FromJSON Mulishly where
    parseJSON xs@(Number _) = (fmap DoubleInMulishly . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInMulishly . parseJSON) xs
    parseJSON Null = return NullInMulishly

instance ToJSON Myoscope where
    toJSON (BoolInMyoscope x) = toJSON x
    toJSON (IntegerInMyoscope x) = toJSON x
    toJSON (NullArrayInMyoscope x) = toJSON x

instance FromJSON Myoscope where
    parseJSON xs@(Bool _) = (fmap BoolInMyoscope . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInMyoscope . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInMyoscope . parseJSON) xs

instance ToJSON Neuromastic where
    toJSON (DoubleInNeuromastic x) = toJSON x
    toJSON (NullArrayInNeuromastic x) = toJSON x

instance FromJSON Neuromastic where
    parseJSON xs@(Number _) = (fmap DoubleInNeuromastic . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInNeuromastic . parseJSON) xs

instance ToJSON Noncontributing where
    toJSON (Noncontributing estevinNoncontributing jolterheadNoncontributing sauternesNoncontributing sparselyNoncontributing unrequestedNoncontributing) =
        object $ foldMap (maybe [] pure)
        [ Just $ "estevin" .= estevinNoncontributing
        , Just $ "jolterhead" .= jolterheadNoncontributing
        , Just $ "sauternes" .= sauternesNoncontributing
        , Just $ "sparsely" .= sparselyNoncontributing
        , Just $ "unrequested" .= unrequestedNoncontributing
        ]

instance FromJSON Noncontributing where
    parseJSON (Object v) = Noncontributing
        <$> v .: "estevin"
        <*> v .: "jolterhead"
        <*> v .: "sauternes"
        <*> v .: "sparsely"
        <*> v .: "unrequested"

instance ToJSON Nonnervous where
    toJSON (BoolInNonnervous x) = toJSON x
    toJSON (IntegerInNonnervous x) = toJSON x

instance FromJSON Nonnervous where
    parseJSON xs@(Bool _) = (fmap BoolInNonnervous . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInNonnervous . parseJSON) xs

instance ToJSON Nonvaluation where
    toJSON (BoolInNonvaluation x) = toJSON x
    toJSON (DoubleInNonvaluation x) = toJSON x
    toJSON (NullArrayInNonvaluation x) = toJSON x

instance FromJSON Nonvaluation where
    parseJSON xs@(Bool _) = (fmap BoolInNonvaluation . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInNonvaluation . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInNonvaluation . parseJSON) xs

instance ToJSON OccupationalistElement where
    toJSON (NullArrayInOccupationalistElement x) = toJSON x
    toJSON NullInOccupationalistElement = Null
    toJSON (OccupationalistClassInOccupationalistElement x) = toJSON x

instance FromJSON OccupationalistElement where
    parseJSON xs@(Array _) = (fmap NullArrayInOccupationalistElement . parseJSON) xs
    parseJSON Null = return NullInOccupationalistElement
    parseJSON xs@(Object _) = (fmap OccupationalistClassInOccupationalistElement . parseJSON) xs

instance ToJSON OccupationalistClass where
    toJSON (OccupationalistClass beholdableOccupationalistClass brotuliformOccupationalistClass chimakumOccupationalistClass doodlerOccupationalistClass emulsinOccupationalistClass finOccupationalistClass flourishingOccupationalistClass fluelessOccupationalistClass furtivelyOccupationalistClass gritterOccupationalistClass interwishOccupationalistClass monoxylicOccupationalistClass myristicOccupationalistClass nightwearOccupationalistClass peruserOccupationalistClass theoastrologicalOccupationalistClass thumbyOccupationalistClass tingitidOccupationalistClass traillessOccupationalistClass unpocketedOccupationalistClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "beholdable" .= beholdableOccupationalistClass
        , Just $ "brotuliform" .= brotuliformOccupationalistClass
        , Just $ "Chimakum" .= chimakumOccupationalistClass
        , Just $ "doodler" .= doodlerOccupationalistClass
        , Just $ "emulsin" .= emulsinOccupationalistClass
        , Just $ "Fin" .= finOccupationalistClass
        , Just $ "flourishing" .= flourishingOccupationalistClass
        , Just $ "flueless" .= fluelessOccupationalistClass
        , Just $ "furtively" .= furtivelyOccupationalistClass
        , Just $ "gritter" .= gritterOccupationalistClass
        , Just $ "interwish" .= interwishOccupationalistClass
        , Just $ "monoxylic" .= monoxylicOccupationalistClass
        , Just $ "myristic" .= myristicOccupationalistClass
        , Just $ "nightwear" .= nightwearOccupationalistClass
        , Just $ "peruser" .= peruserOccupationalistClass
        , Just $ "theoastrological" .= theoastrologicalOccupationalistClass
        , Just $ "thumby" .= thumbyOccupationalistClass
        , Just $ "tingitid" .= tingitidOccupationalistClass
        , Just $ "trailless" .= traillessOccupationalistClass
        , Just $ "unpocketed" .= unpocketedOccupationalistClass
        ]

instance FromJSON OccupationalistClass where
    parseJSON (Object v) = OccupationalistClass
        <$> v .: "beholdable"
        <*> v .: "brotuliform"
        <*> v .: "Chimakum"
        <*> v .: "doodler"
        <*> v .: "emulsin"
        <*> v .: "Fin"
        <*> v .: "flourishing"
        <*> v .: "flueless"
        <*> v .: "furtively"
        <*> v .: "gritter"
        <*> v .: "interwish"
        <*> v .: "monoxylic"
        <*> v .: "myristic"
        <*> v .: "nightwear"
        <*> v .: "peruser"
        <*> v .: "theoastrological"
        <*> v .: "thumby"
        <*> v .: "tingitid"
        <*> v .: "trailless"
        <*> v .: "unpocketed"

instance ToJSON OutrivalElement where
    toJSON (DoubleInOutrivalElement x) = toJSON x
    toJSON NullInOutrivalElement = Null
    toJSON (OutrivalClassInOutrivalElement x) = toJSON x

instance FromJSON OutrivalElement where
    parseJSON xs@(Number _) = (fmap DoubleInOutrivalElement . parseJSON) xs
    parseJSON Null = return NullInOutrivalElement
    parseJSON xs@(Object _) = (fmap OutrivalClassInOutrivalElement . parseJSON) xs

instance ToJSON OutrivalClass where
    toJSON (OutrivalClass adroitlyOutrivalClass bridehoodOutrivalClass castoroidesOutrivalClass czechoslovakOutrivalClass diagenesisOutrivalClass dihexahedronOutrivalClass dopesterOutrivalClass eumerismOutrivalClass flynessOutrivalClass foulerOutrivalClass laudanosineOutrivalClass lingulidaeOutrivalClass minutaryOutrivalClass mitraOutrivalClass opisthorchiasisOutrivalClass pensivelyOutrivalClass pubigerousOutrivalClass rebelliousOutrivalClass recodifyOutrivalClass unpacedOutrivalClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "adroitly" .= adroitlyOutrivalClass
        , Just $ "bridehood" .= bridehoodOutrivalClass
        , Just $ "Castoroides" .= castoroidesOutrivalClass
        , Just $ "Czechoslovak" .= czechoslovakOutrivalClass
        , Just $ "diagenesis" .= diagenesisOutrivalClass
        , Just $ "dihexahedron" .= dihexahedronOutrivalClass
        , Just $ "dopester" .= dopesterOutrivalClass
        , Just $ "eumerism" .= eumerismOutrivalClass
        , Just $ "flyness" .= flynessOutrivalClass
        , Just $ "fouler" .= foulerOutrivalClass
        , Just $ "laudanosine" .= laudanosineOutrivalClass
        , Just $ "Lingulidae" .= lingulidaeOutrivalClass
        , Just $ "minutary" .= minutaryOutrivalClass
        , Just $ "mitra" .= mitraOutrivalClass
        , Just $ "opisthorchiasis" .= opisthorchiasisOutrivalClass
        , Just $ "pensively" .= pensivelyOutrivalClass
        , Just $ "pubigerous" .= pubigerousOutrivalClass
        , Just $ "rebellious" .= rebelliousOutrivalClass
        , Just $ "recodify" .= recodifyOutrivalClass
        , Just $ "unpaced" .= unpacedOutrivalClass
        ]

instance FromJSON OutrivalClass where
    parseJSON (Object v) = OutrivalClass
        <$> v .: "adroitly"
        <*> v .: "bridehood"
        <*> v .: "Castoroides"
        <*> v .: "Czechoslovak"
        <*> v .: "diagenesis"
        <*> v .: "dihexahedron"
        <*> v .: "dopester"
        <*> v .: "eumerism"
        <*> v .: "flyness"
        <*> v .: "fouler"
        <*> v .: "laudanosine"
        <*> v .: "Lingulidae"
        <*> v .: "minutary"
        <*> v .: "mitra"
        <*> v .: "opisthorchiasis"
        <*> v .: "pensively"
        <*> v .: "pubigerous"
        <*> v .: "rebellious"
        <*> v .: "recodify"
        <*> v .: "unpaced"

instance ToJSON Paleographically where
    toJSON (DoubleInPaleographically x) = toJSON x
    toJSON (UnionMapInPaleographically x) = toJSON x

instance FromJSON Paleographically where
    parseJSON xs@(Number _) = (fmap DoubleInPaleographically . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInPaleographically . parseJSON) xs

instance ToJSON Pamphletwise where
    toJSON (IntegerInPamphletwise x) = toJSON x
    toJSON (IntegerMapInPamphletwise x) = toJSON x
    toJSON (StringInPamphletwise x) = toJSON x

instance FromJSON Pamphletwise where
    parseJSON xs@(Number _) = (fmap IntegerInPamphletwise . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInPamphletwise . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInPamphletwise . parseJSON) xs

instance ToJSON Pediatric where
    toJSON (BoolInPediatric x) = toJSON x
    toJSON (DoubleInPediatric x) = toJSON x
    toJSON NullInPediatric = Null

instance FromJSON Pediatric where
    parseJSON xs@(Bool _) = (fmap BoolInPediatric . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInPediatric . parseJSON) xs
    parseJSON Null = return NullInPediatric

instance ToJSON PiaculumElement where
    toJSON (DoubleInPiaculumElement x) = toJSON x
    toJSON (PiaculumClassInPiaculumElement x) = toJSON x

instance FromJSON PiaculumElement where
    parseJSON xs@(Number _) = (fmap DoubleInPiaculumElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PiaculumClassInPiaculumElement . parseJSON) xs

instance ToJSON PiaculumClass where
    toJSON (PiaculumClass aladaPiaculumClass amphistomousPiaculumClass boysenberryPiaculumClass catharticalnessPiaculumClass chirotheriumPiaculumClass decardinalizePiaculumClass discouragementPiaculumClass disdiapasonPiaculumClass doitrifiedPiaculumClass hexaspermousPiaculumClass homocercPiaculumClass insinkingPiaculumClass loathfulnessPiaculumClass miasmaticalPiaculumClass neurofibrilPiaculumClass nonbookishPiaculumClass phonendoscopePiaculumClass pilfermentPiaculumClass predismissoryPiaculumClass preinscriptionPiaculumClass quotativePiaculumClass siennaPiaculumClass thoraxPiaculumClass yachtingPiaculumClass zipperPiaculumClass) =
        object $ foldMap (maybe [] pure)
        [ ("alada" .=) <$> aladaPiaculumClass
        , ("amphistomous" .=) <$> amphistomousPiaculumClass
        , ("boysenberry" .=) <$> boysenberryPiaculumClass
        , ("catharticalness" .=) <$> catharticalnessPiaculumClass
        , ("Chirotherium" .=) <$> chirotheriumPiaculumClass
        , ("decardinalize" .=) <$> decardinalizePiaculumClass
        , ("discouragement" .=) <$> discouragementPiaculumClass
        , ("disdiapason" .=) <$> disdiapasonPiaculumClass
        , ("doitrified" .=) <$> doitrifiedPiaculumClass
        , ("hexaspermous" .=) <$> hexaspermousPiaculumClass
        , ("homocerc" .=) <$> homocercPiaculumClass
        , ("insinking" .=) <$> insinkingPiaculumClass
        , ("loathfulness" .=) <$> loathfulnessPiaculumClass
        , ("miasmatical" .=) <$> miasmaticalPiaculumClass
        , ("neurofibril" .=) <$> neurofibrilPiaculumClass
        , ("nonbookish" .=) <$> nonbookishPiaculumClass
        , ("phonendoscope" .=) <$> phonendoscopePiaculumClass
        , ("pilferment" .=) <$> pilfermentPiaculumClass
        , ("predismissory" .=) <$> predismissoryPiaculumClass
        , ("preinscription" .=) <$> preinscriptionPiaculumClass
        , ("quotative" .=) <$> quotativePiaculumClass
        , ("sienna" .=) <$> siennaPiaculumClass
        , ("thorax" .=) <$> thoraxPiaculumClass
        , ("yachting" .=) <$> yachtingPiaculumClass
        , ("Zipper" .=) <$> zipperPiaculumClass
        ]

instance FromJSON PiaculumClass where
    parseJSON (Object v) = PiaculumClass
        <$> v .:! "alada"
        <*> v .:! "amphistomous"
        <*> v .:! "boysenberry"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "decardinalize"
        <*> v .:! "discouragement"
        <*> v .:! "disdiapason"
        <*> v .:! "doitrified"
        <*> v .:! "hexaspermous"
        <*> v .:! "homocerc"
        <*> v .:! "insinking"
        <*> v .:! "loathfulness"
        <*> v .:! "miasmatical"
        <*> v .:! "neurofibril"
        <*> v .:! "nonbookish"
        <*> v .:! "phonendoscope"
        <*> v .:! "pilferment"
        <*> v .:! "predismissory"
        <*> v .:! "preinscription"
        <*> v .:! "quotative"
        <*> v .:! "sienna"
        <*> v .:! "thorax"
        <*> v .:! "yachting"
        <*> v .:! "Zipper"

instance ToJSON Piccadilly where
    toJSON (DoubleInPiccadilly x) = toJSON x
    toJSON NullInPiccadilly = Null
    toJSON (StringInPiccadilly x) = toJSON x

instance FromJSON Piccadilly where
    parseJSON xs@(Number _) = (fmap DoubleInPiccadilly . parseJSON) xs
    parseJSON Null = return NullInPiccadilly
    parseJSON xs@(String _) = (fmap StringInPiccadilly . parseJSON) xs

instance ToJSON Piffler where
    toJSON (MonaziteClassInPiffler x) = toJSON x
    toJSON (NullArrayInPiffler x) = toJSON x

instance FromJSON Piffler where
    parseJSON xs@(Object _) = (fmap MonaziteClassInPiffler . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInPiffler . parseJSON) xs

instance ToJSON Pithful where
    toJSON (BoolInPithful x) = toJSON x
    toJSON (IntegerInPithful x) = toJSON x
    toJSON NullInPithful = Null

instance FromJSON Pithful where
    parseJSON xs@(Bool _) = (fmap BoolInPithful . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInPithful . parseJSON) xs
    parseJSON Null = return NullInPithful

instance ToJSON Placuntiti where
    toJSON (IntegerInPlacuntiti x) = toJSON x
    toJSON (IntegerMapInPlacuntiti x) = toJSON x

instance FromJSON Placuntiti where
    parseJSON xs@(Number _) = (fmap IntegerInPlacuntiti . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInPlacuntiti . parseJSON) xs

instance ToJSON Plectopterous where
    toJSON (DoubleInPlectopterous x) = toJSON x
    toJSON (IntegerMapInPlectopterous x) = toJSON x

instance FromJSON Plectopterous where
    parseJSON xs@(Number _) = (fmap DoubleInPlectopterous . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInPlectopterous . parseJSON) xs

instance ToJSON Pneumocele where
    toJSON (Pneumocele carbonarismPneumocele catharticalnessPneumocele chirotheriumPneumocele cineolicPneumocele cobblyPneumocele conchyliferousPneumocele congregationPneumocele disdiapasonPneumocele enterotomyPneumocele entophytalPneumocele fewtrilsPneumocele heremPneumocele homocercPneumocele konigaPneumocele meticulosityPneumocele mickyPneumocele mismarriagePneumocele neurotrophicPneumocele nonbookishPneumocele persuasivelyPneumocele replaceablePneumocele silexPneumocele taillightPneumocele unjealousPneumocele visitorialPneumocele) =
        object $ foldMap (maybe [] pure)
        [ ("Carbonarism" .=) <$> carbonarismPneumocele
        , ("catharticalness" .=) <$> catharticalnessPneumocele
        , ("Chirotherium" .=) <$> chirotheriumPneumocele
        , ("cineolic" .=) <$> cineolicPneumocele
        , ("cobbly" .=) <$> cobblyPneumocele
        , ("conchyliferous" .=) <$> conchyliferousPneumocele
        , ("congregation" .=) <$> congregationPneumocele
        , ("disdiapason" .=) <$> disdiapasonPneumocele
        , ("enterotomy" .=) <$> enterotomyPneumocele
        , ("entophytal" .=) <$> entophytalPneumocele
        , ("fewtrils" .=) <$> fewtrilsPneumocele
        , ("herem" .=) <$> heremPneumocele
        , ("homocerc" .=) <$> homocercPneumocele
        , ("Koniga" .=) <$> konigaPneumocele
        , ("meticulosity" .=) <$> meticulosityPneumocele
        , ("Micky" .=) <$> mickyPneumocele
        , ("mismarriage" .=) <$> mismarriagePneumocele
        , ("neurotrophic" .=) <$> neurotrophicPneumocele
        , ("nonbookish" .=) <$> nonbookishPneumocele
        , ("persuasively" .=) <$> persuasivelyPneumocele
        , ("replaceable" .=) <$> replaceablePneumocele
        , ("silex" .=) <$> silexPneumocele
        , ("taillight" .=) <$> taillightPneumocele
        , ("unjealous" .=) <$> unjealousPneumocele
        , ("visitorial" .=) <$> visitorialPneumocele
        ]

instance FromJSON Pneumocele where
    parseJSON (Object v) = Pneumocele
        <$> v .:! "Carbonarism"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "cineolic"
        <*> v .:! "cobbly"
        <*> v .:! "conchyliferous"
        <*> v .:! "congregation"
        <*> v .:! "disdiapason"
        <*> v .:! "enterotomy"
        <*> v .:! "entophytal"
        <*> v .:! "fewtrils"
        <*> v .:! "herem"
        <*> v .:! "homocerc"
        <*> v .:! "Koniga"
        <*> v .:! "meticulosity"
        <*> v .:! "Micky"
        <*> v .:! "mismarriage"
        <*> v .:! "neurotrophic"
        <*> v .:! "nonbookish"
        <*> v .:! "persuasively"
        <*> v .:! "replaceable"
        <*> v .:! "silex"
        <*> v .:! "taillight"
        <*> v .:! "unjealous"
        <*> v .:! "visitorial"

instance ToJSON Poliorcetic where
    toJSON (BoolInPoliorcetic x) = toJSON x
    toJSON (MonaziteClassInPoliorcetic x) = toJSON x

instance FromJSON Poliorcetic where
    parseJSON xs@(Bool _) = (fmap BoolInPoliorcetic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MonaziteClassInPoliorcetic . parseJSON) xs

instance ToJSON Poormaster where
    toJSON (IntegerArrayInPoormaster x) = toJSON x
    toJSON (IntegerMapInPoormaster x) = toJSON x
    toJSON NullInPoormaster = Null

instance FromJSON Poormaster where
    parseJSON xs@(Array _) = (fmap IntegerArrayInPoormaster . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInPoormaster . parseJSON) xs
    parseJSON Null = return NullInPoormaster

instance ToJSON PotwhiskyElement where
    toJSON (IntegerInPotwhiskyElement x) = toJSON x
    toJSON NullInPotwhiskyElement = Null
    toJSON (PotwhiskyClassInPotwhiskyElement x) = toJSON x

instance FromJSON PotwhiskyElement where
    parseJSON xs@(Number _) = (fmap IntegerInPotwhiskyElement . parseJSON) xs
    parseJSON Null = return NullInPotwhiskyElement
    parseJSON xs@(Object _) = (fmap PotwhiskyClassInPotwhiskyElement . parseJSON) xs

instance ToJSON PotwhiskyClass where
    toJSON (PotwhiskyClass arciformPotwhiskyClass cresolinPotwhiskyClass disheartenerPotwhiskyClass disproportionablePotwhiskyClass euchordaPotwhiskyClass ferrywayPotwhiskyClass filamentiferousPotwhiskyClass flemishPotwhiskyClass forgainstPotwhiskyClass graineringPotwhiskyClass irrevolublePotwhiskyClass kindredshipPotwhiskyClass pinguitudinousPotwhiskyClass simpletonicPotwhiskyClass singsongPotwhiskyClass submergementPotwhiskyClass supraoesophagalPotwhiskyClass thrashelPotwhiskyClass tyremesisPotwhiskyClass yorubaPotwhiskyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "arciform" .= arciformPotwhiskyClass
        , Just $ "cresolin" .= cresolinPotwhiskyClass
        , Just $ "disheartener" .= disheartenerPotwhiskyClass
        , Just $ "disproportionable" .= disproportionablePotwhiskyClass
        , Just $ "Euchorda" .= euchordaPotwhiskyClass
        , Just $ "ferryway" .= ferrywayPotwhiskyClass
        , Just $ "filamentiferous" .= filamentiferousPotwhiskyClass
        , Just $ "flemish" .= flemishPotwhiskyClass
        , Just $ "forgainst" .= forgainstPotwhiskyClass
        , Just $ "grainering" .= graineringPotwhiskyClass
        , Just $ "irrevoluble" .= irrevolublePotwhiskyClass
        , Just $ "kindredship" .= kindredshipPotwhiskyClass
        , Just $ "pinguitudinous" .= pinguitudinousPotwhiskyClass
        , Just $ "simpletonic" .= simpletonicPotwhiskyClass
        , Just $ "singsong" .= singsongPotwhiskyClass
        , Just $ "submergement" .= submergementPotwhiskyClass
        , Just $ "supraoesophagal" .= supraoesophagalPotwhiskyClass
        , Just $ "thrashel" .= thrashelPotwhiskyClass
        , Just $ "tyremesis" .= tyremesisPotwhiskyClass
        , Just $ "Yoruba" .= yorubaPotwhiskyClass
        ]

instance FromJSON PotwhiskyClass where
    parseJSON (Object v) = PotwhiskyClass
        <$> v .: "arciform"
        <*> v .: "cresolin"
        <*> v .: "disheartener"
        <*> v .: "disproportionable"
        <*> v .: "Euchorda"
        <*> v .: "ferryway"
        <*> v .: "filamentiferous"
        <*> v .: "flemish"
        <*> v .: "forgainst"
        <*> v .: "grainering"
        <*> v .: "irrevoluble"
        <*> v .: "kindredship"
        <*> v .: "pinguitudinous"
        <*> v .: "simpletonic"
        <*> v .: "singsong"
        <*> v .: "submergement"
        <*> v .: "supraoesophagal"
        <*> v .: "thrashel"
        <*> v .: "tyremesis"
        <*> v .: "Yoruba"

instance ToJSON Practicalizer where
    toJSON (MonaziteClassInPracticalizer x) = toJSON x
    toJSON (NullArrayInPracticalizer x) = toJSON x
    toJSON (StringInPracticalizer x) = toJSON x

instance FromJSON Practicalizer where
    parseJSON xs@(Object _) = (fmap MonaziteClassInPracticalizer . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInPracticalizer . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInPracticalizer . parseJSON) xs

instance ToJSON PrefreshmanElement where
    toJSON (NullArrayInPrefreshmanElement x) = toJSON x
    toJSON (PrefreshmanClassInPrefreshmanElement x) = toJSON x
    toJSON (StringInPrefreshmanElement x) = toJSON x

instance FromJSON PrefreshmanElement where
    parseJSON xs@(Array _) = (fmap NullArrayInPrefreshmanElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PrefreshmanClassInPrefreshmanElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInPrefreshmanElement . parseJSON) xs

instance ToJSON PrefreshmanClass where
    toJSON (PrefreshmanClass azorubinePrefreshmanClass choroiditisPrefreshmanClass coagulatoryPrefreshmanClass cycloramaPrefreshmanClass dolphusPrefreshmanClass duckheartedPrefreshmanClass ficusPrefreshmanClass gemaricPrefreshmanClass jugationPrefreshmanClass myoliposisPrefreshmanClass nonnominationPrefreshmanClass palayPrefreshmanClass pentactinalPrefreshmanClass phaetPrefreshmanClass piquantPrefreshmanClass registrationPrefreshmanClass remancipationPrefreshmanClass scutatiformPrefreshmanClass theodolitePrefreshmanClass underwardPrefreshmanClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "azorubine" .= azorubinePrefreshmanClass
        , Just $ "choroiditis" .= choroiditisPrefreshmanClass
        , Just $ "coagulatory" .= coagulatoryPrefreshmanClass
        , Just $ "cyclorama" .= cycloramaPrefreshmanClass
        , Just $ "Dolphus" .= dolphusPrefreshmanClass
        , Just $ "duckhearted" .= duckheartedPrefreshmanClass
        , Just $ "Ficus" .= ficusPrefreshmanClass
        , Just $ "Gemaric" .= gemaricPrefreshmanClass
        , Just $ "jugation" .= jugationPrefreshmanClass
        , Just $ "myoliposis" .= myoliposisPrefreshmanClass
        , Just $ "nonnomination" .= nonnominationPrefreshmanClass
        , Just $ "palay" .= palayPrefreshmanClass
        , Just $ "pentactinal" .= pentactinalPrefreshmanClass
        , Just $ "Phaet" .= phaetPrefreshmanClass
        , Just $ "piquant" .= piquantPrefreshmanClass
        , Just $ "registration" .= registrationPrefreshmanClass
        , Just $ "remancipation" .= remancipationPrefreshmanClass
        , Just $ "scutatiform" .= scutatiformPrefreshmanClass
        , Just $ "theodolite" .= theodolitePrefreshmanClass
        , Just $ "underward" .= underwardPrefreshmanClass
        ]

instance FromJSON PrefreshmanClass where
    parseJSON (Object v) = PrefreshmanClass
        <$> v .: "azorubine"
        <*> v .: "choroiditis"
        <*> v .: "coagulatory"
        <*> v .: "cyclorama"
        <*> v .: "Dolphus"
        <*> v .: "duckhearted"
        <*> v .: "Ficus"
        <*> v .: "Gemaric"
        <*> v .: "jugation"
        <*> v .: "myoliposis"
        <*> v .: "nonnomination"
        <*> v .: "palay"
        <*> v .: "pentactinal"
        <*> v .: "Phaet"
        <*> v .: "piquant"
        <*> v .: "registration"
        <*> v .: "remancipation"
        <*> v .: "scutatiform"
        <*> v .: "theodolite"
        <*> v .: "underward"

instance ToJSON Prehensility where
    toJSON (BoolInPrehensility x) = toJSON x
    toJSON (MonaziteClassInPrehensility x) = toJSON x
    toJSON (NullArrayInPrehensility x) = toJSON x

instance FromJSON Prehensility where
    parseJSON xs@(Bool _) = (fmap BoolInPrehensility . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MonaziteClassInPrehensility . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInPrehensility . parseJSON) xs

instance ToJSON Prevoidance where
    toJSON (IntegerArrayInPrevoidance x) = toJSON x
    toJSON (IntegerInPrevoidance x) = toJSON x
    toJSON (MonaziteClassInPrevoidance x) = toJSON x

instance FromJSON Prevoidance where
    parseJSON xs@(Array _) = (fmap IntegerArrayInPrevoidance . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInPrevoidance . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MonaziteClassInPrevoidance . parseJSON) xs

instance ToJSON Protext where
    toJSON (BoolInProtext x) = toJSON x
    toJSON (IntegerArrayInProtext x) = toJSON x
    toJSON (MonaziteClassInProtext x) = toJSON x

instance FromJSON Protext where
    parseJSON xs@(Bool _) = (fmap BoolInProtext . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInProtext . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MonaziteClassInProtext . parseJSON) xs
