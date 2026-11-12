{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , AlleviateClass (..)
    , Rebecca (..)
    , Amphithyron (..)
    , AnkeeClass (..)
    , AnsarieClass (..)
    , ChytridiaceaeClass (..)
    , DiscordiaClass (..)
    , GryphosaurusClass (..)
    , LaviniaClass (..)
    , OskarClass (..)
    , Abranchiata (..)
    , Academe (..)
    , Acquirable (..)
    , Aerometry (..)
    , Alexin (..)
    , AlleviateElement (..)
    , Amaa (..)
    , Ambassage (..)
    , AnkeeElement (..)
    , AnsarieElement (..)
    , Aphasia (..)
    , Asprawl (..)
    , Bedesman (..)
    , Belard (..)
    , Bocking (..)
    , Brawlingly (..)
    , Brookie (..)
    , Bumboatman (..)
    , Calaverite (..)
    , Catallactic (..)
    , Cemental (..)
    , ChytridiaceaeElement (..)
    , DiscordiaElement (..)
    , Endomyce (..)
    , Epinephelidae (..)
    , Eupatorium (..)
    , GryphosaurusElement (..)
    , Koryak (..)
    , LaviniaElement (..)
    , OskarElement (..)
    , RebeccaElement (..)
    , Rhomboganoidei (..)
    , Ruellia (..)
    , School (..)
    , Shakespearolater (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)
import Data.Vector (Vector)

data QuickType = QuickType
    { abranchiataQuickType :: Vector Abranchiata
    , academeQuickType :: Vector Academe
    , acquirableQuickType :: Vector Acquirable
    , aerometryQuickType :: Vector Aerometry
    , alexinQuickType :: Vector Alexin
    , alleviateQuickType :: Vector AlleviateElement
    , amaasQuickType :: Vector Amaa
    , ambassageQuickType :: Vector Ambassage
    , amphithyronQuickType :: Vector (Maybe Amphithyron)
    , andrianaQuickType :: Vector (Maybe Text)
    , ankeeQuickType :: Vector AnkeeElement
    , annihilatorQuickType :: Vector (Maybe (HashMap Text (Maybe Int)))
    , annuloseQuickType :: Maybe Text
    , ansarieQuickType :: Vector AnsarieElement
    , aphasiaQuickType :: Vector Aphasia
    , asprawlQuickType :: Vector Asprawl
    , attractiveQuickType :: Vector (Maybe Bool)
    , barksomeQuickType :: HashMap Text Int
    , bedesmanQuickType :: Vector Bedesman
    , belardQuickType :: Vector Belard
    , bockingQuickType :: Vector Bocking
    , brawlinglyQuickType :: Vector Brawlingly
    , brookieQuickType :: Vector Brookie
    , bumboatmanQuickType :: Vector Bumboatman
    , bystreetQuickType :: Vector (Maybe Text)
    , calaveriteQuickType :: Vector Calaverite
    , catallacticQuickType :: Vector Catallactic
    , cementalQuickType :: Vector Cemental
    , chytridiaceaeQuickType :: Vector ChytridiaceaeElement
    , discordiaQuickType :: Vector DiscordiaElement
    , endomycesQuickType :: Vector Endomyce
    , epinephelidaeQuickType :: Vector Epinephelidae
    , eupatoriumQuickType :: Vector Eupatorium
    , gryphosaurusQuickType :: Vector GryphosaurusElement
    , koryakQuickType :: Vector Koryak
    , laviniaQuickType :: Vector LaviniaElement
    , oskarQuickType :: Vector OskarElement
    , rebeccaQuickType :: Vector RebeccaElement
    , rhomboganoideiQuickType :: Vector Rhomboganoidei
    , rigsmalQuickType :: Bool
    , ruelliaQuickType :: Vector Ruellia
    , schoolQuickType :: Vector School
    , shakespearolaterQuickType :: Vector Shakespearolater
    , svanQuickType :: Vector Double
    , wayaoQuickType :: HashMap Text Double
    } deriving (Show)

data Abranchiata
    = IntegerArrayInAbranchiata (Vector Int)
    | IntegerInAbranchiata Int
    | NullInAbranchiata
    deriving (Show)

data Academe
    = IntegerArrayInAcademe (Vector Int)
    | IntegerInAcademe Int
    | IntegerMapInAcademe (HashMap Text Int)
    deriving (Show)

data Acquirable
    = IntegerMapInAcquirable (HashMap Text Int)
    | UnionArrayInAcquirable (Vector (Maybe Int))
    deriving (Show)

data Aerometry
    = BoolInAerometry Bool
    | DoubleInAerometry Double
    deriving (Show)

data Alexin
    = BoolInAlexin Bool
    | IntegerArrayInAlexin (Vector Int)
    deriving (Show)

data AlleviateElement
    = AlleviateClassInAlleviateElement AlleviateClass
    | UnionArrayInAlleviateElement (Vector (Maybe Int))
    deriving (Show)

data AlleviateClass = AlleviateClass
    { aprioriAlleviateClass :: Maybe Text
    , beggarerAlleviateClass :: Maybe Text
    , brokenheartedlyAlleviateClass :: Maybe Text
    , debilitationAlleviateClass :: Maybe Text
    , frikeAlleviateClass :: Maybe Text
    , gastrolithAlleviateClass :: Maybe Text
    , hulseanAlleviateClass :: Maybe Text
    , orthocentricAlleviateClass :: Maybe Text
    , petalyAlleviateClass :: Maybe Text
    , probudgetingAlleviateClass :: Maybe Text
    , reacquireAlleviateClass :: Maybe Text
    , scowAlleviateClass :: Maybe Text
    , shutoffAlleviateClass :: Maybe Text
    , subcontiguousAlleviateClass :: Maybe Text
    , suffumigateAlleviateClass :: Maybe Text
    , transformableAlleviateClass :: Maybe Text
    , uncoronetedAlleviateClass :: Maybe Text
    , unparkingAlleviateClass :: Maybe Text
    , unvarnishednessAlleviateClass :: Maybe Text
    , wherewithalAlleviateClass :: Maybe Text
    } deriving (Show)

data Amaa
    = BoolInAmaa Bool
    | IntegerInAmaa Int
    | RebeccaInAmaa Rebecca
    deriving (Show)

data Rebecca = Rebecca
    { catharticalnessRebecca :: Double
    , chirotheriumRebecca :: Int
    , disdiapasonRebecca :: Text
    , homocercRebecca :: Bool
    , nonbookishRebecca :: Maybe Text
    } deriving (Show)

data Ambassage
    = NullArrayInAmbassage (Vector (Maybe Text))
    | StringInAmbassage Text
    deriving (Show)

data Amphithyron = Amphithyron
    { akroasisAmphithyron :: Maybe Int
    , antiphonicalAmphithyron :: Maybe Int
    , basebredAmphithyron :: Maybe Int
    , catharticalnessAmphithyron :: Maybe Double
    , chirotheriumAmphithyron :: Maybe Int
    , conductometricAmphithyron :: Maybe Int
    , disdiapasonAmphithyron :: Maybe Text
    , ensilationAmphithyron :: Maybe Int
    , eyeboltAmphithyron :: Maybe Int
    , fistulatedAmphithyron :: Maybe Int
    , heteropodAmphithyron :: Maybe Int
    , homocercAmphithyron :: Maybe Bool
    , juniperusAmphithyron :: Maybe Int
    , labyrinthicallyAmphithyron :: Maybe Int
    , martyrizationAmphithyron :: Maybe Int
    , mispolicyAmphithyron :: Maybe Int
    , multiparaAmphithyron :: Maybe Int
    , naziriteAmphithyron :: Maybe Int
    , nonbookishAmphithyron :: Maybe (Maybe Text)
    , possessorialAmphithyron :: Maybe Int
    , shamedAmphithyron :: Maybe Int
    , shelfwornAmphithyron :: Maybe Int
    , stagnumAmphithyron :: Maybe Int
    , thoseAmphithyron :: Maybe Int
    , undecimalAmphithyron :: Maybe Int
    } deriving (Show)

data AnkeeElement
    = AnkeeClassInAnkeeElement AnkeeClass
    | IntegerArrayInAnkeeElement (Vector Int)
    | IntegerInAnkeeElement Int
    deriving (Show)

data AnkeeClass = AnkeeClass
    { anomoeanAnkeeClass :: Maybe Text
    , barleyhoodAnkeeClass :: Maybe Text
    , befrienderAnkeeClass :: Maybe Text
    , brutishnessAnkeeClass :: Maybe Text
    , cephalalgyAnkeeClass :: Maybe Text
    , cirurgianAnkeeClass :: Maybe Text
    , conventionallyAnkeeClass :: Maybe Text
    , jackshayAnkeeClass :: Maybe Text
    , milammeterAnkeeClass :: Maybe Text
    , najaAnkeeClass :: Maybe Text
    , ombrologicalAnkeeClass :: Maybe Text
    , phonastheniaAnkeeClass :: Maybe Text
    , retrievablenessAnkeeClass :: Maybe Text
    , snakilyAnkeeClass :: Maybe Text
    , swotAnkeeClass :: Maybe Text
    , tartletAnkeeClass :: Maybe Text
    , thiofuranAnkeeClass :: Maybe Text
    , tracheophoneAnkeeClass :: Maybe Text
    , tuglikeAnkeeClass :: Maybe Text
    , unscratchinglyAnkeeClass :: Maybe Text
    } deriving (Show)

data AnsarieElement
    = AnsarieClassInAnsarieElement AnsarieClass
    | IntegerArrayInAnsarieElement (Vector Int)
    | NullInAnsarieElement
    deriving (Show)

data AnsarieClass = AnsarieClass
    { accensionAnsarieClass :: Maybe Text
    , alidaAnsarieClass :: Maybe Text
    , asteriaAnsarieClass :: Maybe Text
    , beribericAnsarieClass :: Maybe Text
    , edgeboneAnsarieClass :: Maybe Text
    , gastrodialysisAnsarieClass :: Maybe Text
    , geographicAnsarieClass :: Maybe Text
    , ictonyxAnsarieClass :: Maybe Text
    , metroceleAnsarieClass :: Maybe Text
    , misgraftAnsarieClass :: Maybe Text
    , monteithAnsarieClass :: Maybe Text
    , notcherAnsarieClass :: Maybe Text
    , prorestrictionAnsarieClass :: Maybe Text
    , ramistAnsarieClass :: Maybe Text
    , throatletAnsarieClass :: Maybe Text
    , unfairAnsarieClass :: Maybe Text
    , unsynonymousAnsarieClass :: Maybe Text
    , waterAnsarieClass :: Maybe Text
    , zestfullyAnsarieClass :: Maybe Text
    , zincicAnsarieClass :: Maybe Text
    } deriving (Show)

data Aphasia
    = IntegerArrayInAphasia (Vector Int)
    | IntegerInAphasia Int
    deriving (Show)

data Asprawl
    = DoubleInAsprawl Double
    | StringInAsprawl Text
    deriving (Show)

data Bedesman
    = BoolInBedesman Bool
    | DoubleInBedesman Double
    | StringInBedesman Text
    deriving (Show)

data Belard
    = DoubleInBelard Double
    | IntegerArrayInBelard (Vector Int)
    | RebeccaInBelard Rebecca
    deriving (Show)

data Bocking
    = BoolInBocking Bool
    | IntegerArrayInBocking (Vector Int)
    | IntegerMapInBocking (HashMap Text Int)
    deriving (Show)

data Brawlingly
    = NullArrayInBrawlingly (Vector (Maybe Text))
    | UnionMapInBrawlingly (HashMap Text (Maybe Int))
    deriving (Show)

data Brookie
    = IntegerArrayInBrookie (Vector Int)
    | RebeccaInBrookie Rebecca
    deriving (Show)

data Bumboatman
    = NullArrayInBumboatman (Vector (Maybe Text))
    | NullInBumboatman
    | StringInBumboatman Text
    deriving (Show)

data Calaverite
    = IntegerArrayInCalaverite (Vector Int)
    | StringInCalaverite Text
    deriving (Show)

data Catallactic
    = BoolInCatallactic Bool
    | IntegerMapInCatallactic (HashMap Text Int)
    | NullArrayInCatallactic (Vector (Maybe Text))
    deriving (Show)

data Cemental
    = DoubleInCemental Double
    | IntegerArrayInCemental (Vector Int)
    | IntegerMapInCemental (HashMap Text Int)
    deriving (Show)

data ChytridiaceaeElement
    = BoolInChytridiaceaeElement Bool
    | ChytridiaceaeClassInChytridiaceaeElement ChytridiaceaeClass
    | NullInChytridiaceaeElement
    deriving (Show)

data ChytridiaceaeClass = ChytridiaceaeClass
    { batidaceaeChytridiaceaeClass :: Maybe Text
    , brechitesChytridiaceaeClass :: Maybe Text
    , codespairerChytridiaceaeClass :: Maybe Text
    , emeryChytridiaceaeClass :: Maybe Text
    , enervativeChytridiaceaeClass :: Maybe Text
    , excriminateChytridiaceaeClass :: Maybe Text
    , gosheniteChytridiaceaeClass :: Maybe Text
    , grimeChytridiaceaeClass :: Maybe Text
    , grittenChytridiaceaeClass :: Maybe Text
    , hectorlyChytridiaceaeClass :: Maybe Text
    , intermediationChytridiaceaeClass :: Maybe Text
    , meeterlyChytridiaceaeClass :: Maybe Text
    , narragansetChytridiaceaeClass :: Maybe Text
    , onymaticChytridiaceaeClass :: Maybe Text
    , paddlecockChytridiaceaeClass :: Maybe Text
    , thanaChytridiaceaeClass :: Maybe Text
    , thornilyChytridiaceaeClass :: Maybe Text
    , uckiaChytridiaceaeClass :: Maybe Text
    , unmettleChytridiaceaeClass :: Maybe Text
    , vorticellidChytridiaceaeClass :: Maybe Text
    } deriving (Show)

data DiscordiaElement
    = DiscordiaClassInDiscordiaElement DiscordiaClass
    | IntegerArrayInDiscordiaElement (Vector Int)
    deriving (Show)

data DiscordiaClass = DiscordiaClass
    { altaicDiscordiaClass :: Maybe Int
    , amoristicDiscordiaClass :: Maybe Int
    , blennophthalmiaDiscordiaClass :: Maybe Int
    , catharticalnessDiscordiaClass :: Maybe Double
    , chirotheriumDiscordiaClass :: Maybe Int
    , disciplinabilityDiscordiaClass :: Maybe Int
    , disdiapasonDiscordiaClass :: Maybe Text
    , gooferDiscordiaClass :: Maybe Int
    , homocercDiscordiaClass :: Maybe Bool
    , laryngographDiscordiaClass :: Maybe Int
    , leucitisDiscordiaClass :: Maybe Int
    , lymphocystDiscordiaClass :: Maybe Int
    , microcosmologyDiscordiaClass :: Maybe Int
    , nauseationDiscordiaClass :: Maybe Int
    , nonbookishDiscordiaClass :: Maybe (Maybe Text)
    , patarinDiscordiaClass :: Maybe Int
    , preliberalDiscordiaClass :: Maybe Int
    , prettifierDiscordiaClass :: Maybe Int
    , rangeworkDiscordiaClass :: Maybe Int
    , redientDiscordiaClass :: Maybe Int
    , subfusiformDiscordiaClass :: Maybe Int
    , suicidicalDiscordiaClass :: Maybe Int
    , swowDiscordiaClass :: Maybe Int
    , wastrelDiscordiaClass :: Maybe Int
    , wingleDiscordiaClass :: Maybe Int
    } deriving (Show)

data Endomyce
    = IntegerInEndomyce Int
    | StringInEndomyce Text
    deriving (Show)

data Epinephelidae
    = BoolInEpinephelidae Bool
    | IntegerInEpinephelidae Int
    | StringInEpinephelidae Text
    deriving (Show)

data Eupatorium
    = IntegerMapInEupatorium (HashMap Text Int)
    | NullArrayInEupatorium (Vector (Maybe Text))
    deriving (Show)

data GryphosaurusElement
    = GryphosaurusClassInGryphosaurusElement GryphosaurusClass
    | IntegerArrayInGryphosaurusElement (Vector Int)
    | StringInGryphosaurusElement Text
    deriving (Show)

data GryphosaurusClass = GryphosaurusClass
    { amissibilityGryphosaurusClass :: Maybe Text
    , burushaskiGryphosaurusClass :: Maybe Text
    , citroninGryphosaurusClass :: Maybe Text
    , coplaintiffGryphosaurusClass :: Maybe Text
    , disquisitionaryGryphosaurusClass :: Maybe Text
    , enoplanGryphosaurusClass :: Maybe Text
    , faintnessGryphosaurusClass :: Maybe Text
    , hebetomyGryphosaurusClass :: Maybe Text
    , islandryGryphosaurusClass :: Maybe Text
    , lameduckGryphosaurusClass :: Maybe Text
    , overbattleGryphosaurusClass :: Maybe Text
    , overinterestedGryphosaurusClass :: Maybe Text
    , phrenologicGryphosaurusClass :: Maybe Text
    , rainbandGryphosaurusClass :: Maybe Text
    , shininglyGryphosaurusClass :: Maybe Text
    , stamineousGryphosaurusClass :: Maybe Text
    , subscapularisGryphosaurusClass :: Maybe Text
    , tahamiGryphosaurusClass :: Maybe Text
    , undaubedGryphosaurusClass :: Maybe Text
    , underntimeGryphosaurusClass :: Maybe Text
    } deriving (Show)

data Koryak
    = StringInKoryak Text
    | UnionMapInKoryak (HashMap Text (Maybe Int))
    deriving (Show)

data LaviniaElement
    = LaviniaClassInLaviniaElement LaviniaClass
    | StringInLaviniaElement Text
    deriving (Show)

data LaviniaClass = LaviniaClass
    { agitableLaviniaClass :: Maybe Int
    , asininityLaviniaClass :: Maybe Int
    , benefiterLaviniaClass :: Maybe Int
    , bronzelikeLaviniaClass :: Maybe Int
    , catharticalnessLaviniaClass :: Maybe Double
    , chirotheriumLaviniaClass :: Maybe Int
    , cholesteatomatousLaviniaClass :: Maybe Int
    , deprivementLaviniaClass :: Maybe Int
    , disdiapasonLaviniaClass :: Maybe Text
    , flippantnessLaviniaClass :: Maybe Int
    , fogproofLaviniaClass :: Maybe Int
    , homocercLaviniaClass :: Maybe Bool
    , merrymeetingLaviniaClass :: Maybe Int
    , nonbookishLaviniaClass :: Maybe (Maybe Text)
    , overcarefulLaviniaClass :: Maybe Int
    , panarisLaviniaClass :: Maybe Int
    , preacceptanceLaviniaClass :: Maybe Int
    , quinoxalineLaviniaClass :: Maybe Int
    , sigLaviniaClass :: Maybe Int
    , superconfusionLaviniaClass :: Maybe Int
    , tacanaLaviniaClass :: Maybe Int
    , tillotterLaviniaClass :: Maybe Int
    , tranquillizeLaviniaClass :: Maybe Int
    , unquestionableLaviniaClass :: Maybe Int
    , uprouteLaviniaClass :: Maybe Int
    } deriving (Show)

data OskarElement
    = IntegerArrayInOskarElement (Vector Int)
    | OskarClassInOskarElement OskarClass
    deriving (Show)

data OskarClass = OskarClass
    { acrobatesOskarClass :: Maybe Text
    , beanshooterOskarClass :: Maybe Text
    , bearhoundOskarClass :: Maybe Text
    , cayugaOskarClass :: Maybe Text
    , guarneriOskarClass :: Maybe Text
    , hypochondriacismOskarClass :: Maybe Text
    , indicationOskarClass :: Maybe Text
    , jaculativeOskarClass :: Maybe Text
    , naganaOskarClass :: Maybe Text
    , netherlandishOskarClass :: Maybe Text
    , noctivagousOskarClass :: Maybe Text
    , nonphysiologicalOskarClass :: Maybe Text
    , praxisOskarClass :: Maybe Text
    , provisionOskarClass :: Maybe Text
    , subterhumanOskarClass :: Maybe Text
    , sunlitOskarClass :: Maybe Text
    , syncraniateOskarClass :: Maybe Text
    , teachmentOskarClass :: Maybe Text
    , unmutinousOskarClass :: Maybe Text
    , unstoppableOskarClass :: Maybe Text
    } deriving (Show)

data RebeccaElement
    = IntegerInRebeccaElement Int
    | RebeccaInRebeccaElement Rebecca
    | StringInRebeccaElement Text
    deriving (Show)

data Rhomboganoidei
    = IntegerArrayInRhomboganoidei (Vector Int)
    | RebeccaInRhomboganoidei Rebecca
    | StringInRhomboganoidei Text
    deriving (Show)

data Ruellia
    = BoolInRuellia Bool
    | RebeccaInRuellia Rebecca
    | StringInRuellia Text
    deriving (Show)

data School
    = IntegerInSchool Int
    | IntegerMapInSchool (HashMap Text Int)
    | NullInSchool
    deriving (Show)

data Shakespearolater
    = DoubleInShakespearolater Double
    | IntegerArrayInShakespearolater (Vector Int)
    | StringInShakespearolater Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType abranchiataQuickType academeQuickType acquirableQuickType aerometryQuickType alexinQuickType alleviateQuickType amaasQuickType ambassageQuickType amphithyronQuickType andrianaQuickType ankeeQuickType annihilatorQuickType annuloseQuickType ansarieQuickType aphasiaQuickType asprawlQuickType attractiveQuickType barksomeQuickType bedesmanQuickType belardQuickType bockingQuickType brawlinglyQuickType brookieQuickType bumboatmanQuickType bystreetQuickType calaveriteQuickType catallacticQuickType cementalQuickType chytridiaceaeQuickType discordiaQuickType endomycesQuickType epinephelidaeQuickType eupatoriumQuickType gryphosaurusQuickType koryakQuickType laviniaQuickType oskarQuickType rebeccaQuickType rhomboganoideiQuickType rigsmalQuickType ruelliaQuickType schoolQuickType shakespearolaterQuickType svanQuickType wayaoQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Abranchiata" .= abranchiataQuickType
        , Just $ "academe" .= academeQuickType
        , Just $ "acquirable" .= acquirableQuickType
        , Just $ "aerometry" .= aerometryQuickType
        , Just $ "alexin" .= alexinQuickType
        , Just $ "alleviate" .= alleviateQuickType
        , Just $ "amaas" .= amaasQuickType
        , Just $ "ambassage" .= ambassageQuickType
        , Just $ "amphithyron" .= amphithyronQuickType
        , Just $ "Andriana" .= andrianaQuickType
        , Just $ "ankee" .= ankeeQuickType
        , Just $ "annihilator" .= annihilatorQuickType
        , Just $ "annulose" .= annuloseQuickType
        , Just $ "Ansarie" .= ansarieQuickType
        , Just $ "aphasia" .= aphasiaQuickType
        , Just $ "asprawl" .= asprawlQuickType
        , Just $ "attractive" .= attractiveQuickType
        , Just $ "barksome" .= barksomeQuickType
        , Just $ "bedesman" .= bedesmanQuickType
        , Just $ "belard" .= belardQuickType
        , Just $ "bocking" .= bockingQuickType
        , Just $ "brawlingly" .= brawlinglyQuickType
        , Just $ "brookie" .= brookieQuickType
        , Just $ "bumboatman" .= bumboatmanQuickType
        , Just $ "bystreet" .= bystreetQuickType
        , Just $ "calaverite" .= calaveriteQuickType
        , Just $ "catallactic" .= catallacticQuickType
        , Just $ "cemental" .= cementalQuickType
        , Just $ "Chytridiaceae" .= chytridiaceaeQuickType
        , Just $ "Discordia" .= discordiaQuickType
        , Just $ "Endomyces" .= endomycesQuickType
        , Just $ "Epinephelidae" .= epinephelidaeQuickType
        , Just $ "Eupatorium" .= eupatoriumQuickType
        , Just $ "Gryphosaurus" .= gryphosaurusQuickType
        , Just $ "Koryak" .= koryakQuickType
        , Just $ "Lavinia" .= laviniaQuickType
        , Just $ "Oskar" .= oskarQuickType
        , Just $ "Rebecca" .= rebeccaQuickType
        , Just $ "Rhomboganoidei" .= rhomboganoideiQuickType
        , Just $ "Rigsmal" .= rigsmalQuickType
        , Just $ "Ruellia" .= ruelliaQuickType
        , Just $ "School" .= schoolQuickType
        , Just $ "Shakespearolater" .= shakespearolaterQuickType
        , Just $ "Svan" .= svanQuickType
        , Just $ "Wayao" .= wayaoQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "Abranchiata"
        <*> v .: "academe"
        <*> v .: "acquirable"
        <*> v .: "aerometry"
        <*> v .: "alexin"
        <*> v .: "alleviate"
        <*> v .: "amaas"
        <*> v .: "ambassage"
        <*> v .: "amphithyron"
        <*> v .: "Andriana"
        <*> v .: "ankee"
        <*> v .: "annihilator"
        <*> v .: "annulose"
        <*> v .: "Ansarie"
        <*> v .: "aphasia"
        <*> v .: "asprawl"
        <*> v .: "attractive"
        <*> v .: "barksome"
        <*> v .: "bedesman"
        <*> v .: "belard"
        <*> v .: "bocking"
        <*> v .: "brawlingly"
        <*> v .: "brookie"
        <*> v .: "bumboatman"
        <*> v .: "bystreet"
        <*> v .: "calaverite"
        <*> v .: "catallactic"
        <*> v .: "cemental"
        <*> v .: "Chytridiaceae"
        <*> v .: "Discordia"
        <*> v .: "Endomyces"
        <*> v .: "Epinephelidae"
        <*> v .: "Eupatorium"
        <*> v .: "Gryphosaurus"
        <*> v .: "Koryak"
        <*> v .: "Lavinia"
        <*> v .: "Oskar"
        <*> v .: "Rebecca"
        <*> v .: "Rhomboganoidei"
        <*> v .: "Rigsmal"
        <*> v .: "Ruellia"
        <*> v .: "School"
        <*> v .: "Shakespearolater"
        <*> v .: "Svan"
        <*> v .: "Wayao"

instance ToJSON Abranchiata where
    toJSON (IntegerArrayInAbranchiata x) = toJSON x
    toJSON (IntegerInAbranchiata x) = toJSON x
    toJSON NullInAbranchiata = Null

instance FromJSON Abranchiata where
    parseJSON xs@(Array _) = (fmap IntegerArrayInAbranchiata . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAbranchiata . parseJSON) xs
    parseJSON Null = return NullInAbranchiata

instance ToJSON Academe where
    toJSON (IntegerArrayInAcademe x) = toJSON x
    toJSON (IntegerInAcademe x) = toJSON x
    toJSON (IntegerMapInAcademe x) = toJSON x

instance FromJSON Academe where
    parseJSON xs@(Array _) = (fmap IntegerArrayInAcademe . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAcademe . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInAcademe . parseJSON) xs

instance ToJSON Acquirable where
    toJSON (IntegerMapInAcquirable x) = toJSON x
    toJSON (UnionArrayInAcquirable x) = toJSON x

instance FromJSON Acquirable where
    parseJSON xs@(Object _) = (fmap IntegerMapInAcquirable . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInAcquirable . parseJSON) xs

instance ToJSON Aerometry where
    toJSON (BoolInAerometry x) = toJSON x
    toJSON (DoubleInAerometry x) = toJSON x

instance FromJSON Aerometry where
    parseJSON xs@(Bool _) = (fmap BoolInAerometry . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInAerometry . parseJSON) xs

instance ToJSON Alexin where
    toJSON (BoolInAlexin x) = toJSON x
    toJSON (IntegerArrayInAlexin x) = toJSON x

instance FromJSON Alexin where
    parseJSON xs@(Bool _) = (fmap BoolInAlexin . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInAlexin . parseJSON) xs

instance ToJSON AlleviateElement where
    toJSON (AlleviateClassInAlleviateElement x) = toJSON x
    toJSON (UnionArrayInAlleviateElement x) = toJSON x

instance FromJSON AlleviateElement where
    parseJSON xs@(Object _) = (fmap AlleviateClassInAlleviateElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInAlleviateElement . parseJSON) xs

instance ToJSON AlleviateClass where
    toJSON (AlleviateClass aprioriAlleviateClass beggarerAlleviateClass brokenheartedlyAlleviateClass debilitationAlleviateClass frikeAlleviateClass gastrolithAlleviateClass hulseanAlleviateClass orthocentricAlleviateClass petalyAlleviateClass probudgetingAlleviateClass reacquireAlleviateClass scowAlleviateClass shutoffAlleviateClass subcontiguousAlleviateClass suffumigateAlleviateClass transformableAlleviateClass uncoronetedAlleviateClass unparkingAlleviateClass unvarnishednessAlleviateClass wherewithalAlleviateClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "apriori" .= aprioriAlleviateClass
        , Just $ "beggarer" .= beggarerAlleviateClass
        , Just $ "brokenheartedly" .= brokenheartedlyAlleviateClass
        , Just $ "debilitation" .= debilitationAlleviateClass
        , Just $ "frike" .= frikeAlleviateClass
        , Just $ "gastrolith" .= gastrolithAlleviateClass
        , Just $ "Hulsean" .= hulseanAlleviateClass
        , Just $ "orthocentric" .= orthocentricAlleviateClass
        , Just $ "petaly" .= petalyAlleviateClass
        , Just $ "probudgeting" .= probudgetingAlleviateClass
        , Just $ "reacquire" .= reacquireAlleviateClass
        , Just $ "scow" .= scowAlleviateClass
        , Just $ "shutoff" .= shutoffAlleviateClass
        , Just $ "subcontiguous" .= subcontiguousAlleviateClass
        , Just $ "suffumigate" .= suffumigateAlleviateClass
        , Just $ "transformable" .= transformableAlleviateClass
        , Just $ "uncoroneted" .= uncoronetedAlleviateClass
        , Just $ "unparking" .= unparkingAlleviateClass
        , Just $ "unvarnishedness" .= unvarnishednessAlleviateClass
        , Just $ "wherewithal" .= wherewithalAlleviateClass
        ]

instance FromJSON AlleviateClass where
    parseJSON (Object v) = AlleviateClass
        <$> v .: "apriori"
        <*> v .: "beggarer"
        <*> v .: "brokenheartedly"
        <*> v .: "debilitation"
        <*> v .: "frike"
        <*> v .: "gastrolith"
        <*> v .: "Hulsean"
        <*> v .: "orthocentric"
        <*> v .: "petaly"
        <*> v .: "probudgeting"
        <*> v .: "reacquire"
        <*> v .: "scow"
        <*> v .: "shutoff"
        <*> v .: "subcontiguous"
        <*> v .: "suffumigate"
        <*> v .: "transformable"
        <*> v .: "uncoroneted"
        <*> v .: "unparking"
        <*> v .: "unvarnishedness"
        <*> v .: "wherewithal"

instance ToJSON Amaa where
    toJSON (BoolInAmaa x) = toJSON x
    toJSON (IntegerInAmaa x) = toJSON x
    toJSON (RebeccaInAmaa x) = toJSON x

instance FromJSON Amaa where
    parseJSON xs@(Bool _) = (fmap BoolInAmaa . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAmaa . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInAmaa . parseJSON) xs

instance ToJSON Rebecca where
    toJSON (Rebecca catharticalnessRebecca chirotheriumRebecca disdiapasonRebecca homocercRebecca nonbookishRebecca) =
        object $ foldMap (maybe [] pure)
        [ Just $ "catharticalness" .= catharticalnessRebecca
        , Just $ "Chirotherium" .= chirotheriumRebecca
        , Just $ "disdiapason" .= disdiapasonRebecca
        , Just $ "homocerc" .= homocercRebecca
        , Just $ "nonbookish" .= nonbookishRebecca
        ]

instance FromJSON Rebecca where
    parseJSON (Object v) = Rebecca
        <$> v .: "catharticalness"
        <*> v .: "Chirotherium"
        <*> v .: "disdiapason"
        <*> v .: "homocerc"
        <*> v .: "nonbookish"

instance ToJSON Ambassage where
    toJSON (NullArrayInAmbassage x) = toJSON x
    toJSON (StringInAmbassage x) = toJSON x

instance FromJSON Ambassage where
    parseJSON xs@(Array _) = (fmap NullArrayInAmbassage . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInAmbassage . parseJSON) xs

instance ToJSON Amphithyron where
    toJSON (Amphithyron akroasisAmphithyron antiphonicalAmphithyron basebredAmphithyron catharticalnessAmphithyron chirotheriumAmphithyron conductometricAmphithyron disdiapasonAmphithyron ensilationAmphithyron eyeboltAmphithyron fistulatedAmphithyron heteropodAmphithyron homocercAmphithyron juniperusAmphithyron labyrinthicallyAmphithyron martyrizationAmphithyron mispolicyAmphithyron multiparaAmphithyron naziriteAmphithyron nonbookishAmphithyron possessorialAmphithyron shamedAmphithyron shelfwornAmphithyron stagnumAmphithyron thoseAmphithyron undecimalAmphithyron) =
        object $ foldMap (maybe [] pure)
        [ ("akroasis" .=) <$> akroasisAmphithyron
        , ("antiphonical" .=) <$> antiphonicalAmphithyron
        , ("basebred" .=) <$> basebredAmphithyron
        , ("catharticalness" .=) <$> catharticalnessAmphithyron
        , ("Chirotherium" .=) <$> chirotheriumAmphithyron
        , ("conductometric" .=) <$> conductometricAmphithyron
        , ("disdiapason" .=) <$> disdiapasonAmphithyron
        , ("ensilation" .=) <$> ensilationAmphithyron
        , ("eyebolt" .=) <$> eyeboltAmphithyron
        , ("fistulated" .=) <$> fistulatedAmphithyron
        , ("heteropod" .=) <$> heteropodAmphithyron
        , ("homocerc" .=) <$> homocercAmphithyron
        , ("Juniperus" .=) <$> juniperusAmphithyron
        , ("labyrinthically" .=) <$> labyrinthicallyAmphithyron
        , ("martyrization" .=) <$> martyrizationAmphithyron
        , ("mispolicy" .=) <$> mispolicyAmphithyron
        , ("multipara" .=) <$> multiparaAmphithyron
        , ("Nazirite" .=) <$> naziriteAmphithyron
        , ("nonbookish" .=) <$> nonbookishAmphithyron
        , ("possessorial" .=) <$> possessorialAmphithyron
        , ("shamed" .=) <$> shamedAmphithyron
        , ("shelfworn" .=) <$> shelfwornAmphithyron
        , ("stagnum" .=) <$> stagnumAmphithyron
        , ("Those" .=) <$> thoseAmphithyron
        , ("undecimal" .=) <$> undecimalAmphithyron
        ]

instance FromJSON Amphithyron where
    parseJSON (Object v) = Amphithyron
        <$> v .:! "akroasis"
        <*> v .:! "antiphonical"
        <*> v .:! "basebred"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "conductometric"
        <*> v .:! "disdiapason"
        <*> v .:! "ensilation"
        <*> v .:! "eyebolt"
        <*> v .:! "fistulated"
        <*> v .:! "heteropod"
        <*> v .:! "homocerc"
        <*> v .:! "Juniperus"
        <*> v .:! "labyrinthically"
        <*> v .:! "martyrization"
        <*> v .:! "mispolicy"
        <*> v .:! "multipara"
        <*> v .:! "Nazirite"
        <*> v .:! "nonbookish"
        <*> v .:! "possessorial"
        <*> v .:! "shamed"
        <*> v .:! "shelfworn"
        <*> v .:! "stagnum"
        <*> v .:! "Those"
        <*> v .:! "undecimal"

instance ToJSON AnkeeElement where
    toJSON (AnkeeClassInAnkeeElement x) = toJSON x
    toJSON (IntegerArrayInAnkeeElement x) = toJSON x
    toJSON (IntegerInAnkeeElement x) = toJSON x

instance FromJSON AnkeeElement where
    parseJSON xs@(Object _) = (fmap AnkeeClassInAnkeeElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInAnkeeElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAnkeeElement . parseJSON) xs

instance ToJSON AnkeeClass where
    toJSON (AnkeeClass anomoeanAnkeeClass barleyhoodAnkeeClass befrienderAnkeeClass brutishnessAnkeeClass cephalalgyAnkeeClass cirurgianAnkeeClass conventionallyAnkeeClass jackshayAnkeeClass milammeterAnkeeClass najaAnkeeClass ombrologicalAnkeeClass phonastheniaAnkeeClass retrievablenessAnkeeClass snakilyAnkeeClass swotAnkeeClass tartletAnkeeClass thiofuranAnkeeClass tracheophoneAnkeeClass tuglikeAnkeeClass unscratchinglyAnkeeClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Anomoean" .= anomoeanAnkeeClass
        , Just $ "barleyhood" .= barleyhoodAnkeeClass
        , Just $ "befriender" .= befrienderAnkeeClass
        , Just $ "brutishness" .= brutishnessAnkeeClass
        , Just $ "cephalalgy" .= cephalalgyAnkeeClass
        , Just $ "cirurgian" .= cirurgianAnkeeClass
        , Just $ "conventionally" .= conventionallyAnkeeClass
        , Just $ "jackshay" .= jackshayAnkeeClass
        , Just $ "milammeter" .= milammeterAnkeeClass
        , Just $ "Naja" .= najaAnkeeClass
        , Just $ "ombrological" .= ombrologicalAnkeeClass
        , Just $ "phonasthenia" .= phonastheniaAnkeeClass
        , Just $ "retrievableness" .= retrievablenessAnkeeClass
        , Just $ "snakily" .= snakilyAnkeeClass
        , Just $ "swot" .= swotAnkeeClass
        , Just $ "tartlet" .= tartletAnkeeClass
        , Just $ "thiofuran" .= thiofuranAnkeeClass
        , Just $ "tracheophone" .= tracheophoneAnkeeClass
        , Just $ "tuglike" .= tuglikeAnkeeClass
        , Just $ "unscratchingly" .= unscratchinglyAnkeeClass
        ]

instance FromJSON AnkeeClass where
    parseJSON (Object v) = AnkeeClass
        <$> v .: "Anomoean"
        <*> v .: "barleyhood"
        <*> v .: "befriender"
        <*> v .: "brutishness"
        <*> v .: "cephalalgy"
        <*> v .: "cirurgian"
        <*> v .: "conventionally"
        <*> v .: "jackshay"
        <*> v .: "milammeter"
        <*> v .: "Naja"
        <*> v .: "ombrological"
        <*> v .: "phonasthenia"
        <*> v .: "retrievableness"
        <*> v .: "snakily"
        <*> v .: "swot"
        <*> v .: "tartlet"
        <*> v .: "thiofuran"
        <*> v .: "tracheophone"
        <*> v .: "tuglike"
        <*> v .: "unscratchingly"

instance ToJSON AnsarieElement where
    toJSON (AnsarieClassInAnsarieElement x) = toJSON x
    toJSON (IntegerArrayInAnsarieElement x) = toJSON x
    toJSON NullInAnsarieElement = Null

instance FromJSON AnsarieElement where
    parseJSON xs@(Object _) = (fmap AnsarieClassInAnsarieElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInAnsarieElement . parseJSON) xs
    parseJSON Null = return NullInAnsarieElement

instance ToJSON AnsarieClass where
    toJSON (AnsarieClass accensionAnsarieClass alidaAnsarieClass asteriaAnsarieClass beribericAnsarieClass edgeboneAnsarieClass gastrodialysisAnsarieClass geographicAnsarieClass ictonyxAnsarieClass metroceleAnsarieClass misgraftAnsarieClass monteithAnsarieClass notcherAnsarieClass prorestrictionAnsarieClass ramistAnsarieClass throatletAnsarieClass unfairAnsarieClass unsynonymousAnsarieClass waterAnsarieClass zestfullyAnsarieClass zincicAnsarieClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "accension" .= accensionAnsarieClass
        , Just $ "Alida" .= alidaAnsarieClass
        , Just $ "asteria" .= asteriaAnsarieClass
        , Just $ "beriberic" .= beribericAnsarieClass
        , Just $ "edgebone" .= edgeboneAnsarieClass
        , Just $ "gastrodialysis" .= gastrodialysisAnsarieClass
        , Just $ "geographic" .= geographicAnsarieClass
        , Just $ "Ictonyx" .= ictonyxAnsarieClass
        , Just $ "metrocele" .= metroceleAnsarieClass
        , Just $ "misgraft" .= misgraftAnsarieClass
        , Just $ "monteith" .= monteithAnsarieClass
        , Just $ "notcher" .= notcherAnsarieClass
        , Just $ "prorestriction" .= prorestrictionAnsarieClass
        , Just $ "Ramist" .= ramistAnsarieClass
        , Just $ "throatlet" .= throatletAnsarieClass
        , Just $ "unfair" .= unfairAnsarieClass
        , Just $ "unsynonymous" .= unsynonymousAnsarieClass
        , Just $ "water" .= waterAnsarieClass
        , Just $ "zestfully" .= zestfullyAnsarieClass
        , Just $ "zincic" .= zincicAnsarieClass
        ]

instance FromJSON AnsarieClass where
    parseJSON (Object v) = AnsarieClass
        <$> v .: "accension"
        <*> v .: "Alida"
        <*> v .: "asteria"
        <*> v .: "beriberic"
        <*> v .: "edgebone"
        <*> v .: "gastrodialysis"
        <*> v .: "geographic"
        <*> v .: "Ictonyx"
        <*> v .: "metrocele"
        <*> v .: "misgraft"
        <*> v .: "monteith"
        <*> v .: "notcher"
        <*> v .: "prorestriction"
        <*> v .: "Ramist"
        <*> v .: "throatlet"
        <*> v .: "unfair"
        <*> v .: "unsynonymous"
        <*> v .: "water"
        <*> v .: "zestfully"
        <*> v .: "zincic"

instance ToJSON Aphasia where
    toJSON (IntegerArrayInAphasia x) = toJSON x
    toJSON (IntegerInAphasia x) = toJSON x

instance FromJSON Aphasia where
    parseJSON xs@(Array _) = (fmap IntegerArrayInAphasia . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAphasia . parseJSON) xs

instance ToJSON Asprawl where
    toJSON (DoubleInAsprawl x) = toJSON x
    toJSON (StringInAsprawl x) = toJSON x

instance FromJSON Asprawl where
    parseJSON xs@(Number _) = (fmap DoubleInAsprawl . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInAsprawl . parseJSON) xs

instance ToJSON Bedesman where
    toJSON (BoolInBedesman x) = toJSON x
    toJSON (DoubleInBedesman x) = toJSON x
    toJSON (StringInBedesman x) = toJSON x

instance FromJSON Bedesman where
    parseJSON xs@(Bool _) = (fmap BoolInBedesman . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInBedesman . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInBedesman . parseJSON) xs

instance ToJSON Belard where
    toJSON (DoubleInBelard x) = toJSON x
    toJSON (IntegerArrayInBelard x) = toJSON x
    toJSON (RebeccaInBelard x) = toJSON x

instance FromJSON Belard where
    parseJSON xs@(Number _) = (fmap DoubleInBelard . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInBelard . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInBelard . parseJSON) xs

instance ToJSON Bocking where
    toJSON (BoolInBocking x) = toJSON x
    toJSON (IntegerArrayInBocking x) = toJSON x
    toJSON (IntegerMapInBocking x) = toJSON x

instance FromJSON Bocking where
    parseJSON xs@(Bool _) = (fmap BoolInBocking . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInBocking . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInBocking . parseJSON) xs

instance ToJSON Brawlingly where
    toJSON (NullArrayInBrawlingly x) = toJSON x
    toJSON (UnionMapInBrawlingly x) = toJSON x

instance FromJSON Brawlingly where
    parseJSON xs@(Array _) = (fmap NullArrayInBrawlingly . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInBrawlingly . parseJSON) xs

instance ToJSON Brookie where
    toJSON (IntegerArrayInBrookie x) = toJSON x
    toJSON (RebeccaInBrookie x) = toJSON x

instance FromJSON Brookie where
    parseJSON xs@(Array _) = (fmap IntegerArrayInBrookie . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInBrookie . parseJSON) xs

instance ToJSON Bumboatman where
    toJSON (NullArrayInBumboatman x) = toJSON x
    toJSON NullInBumboatman = Null
    toJSON (StringInBumboatman x) = toJSON x

instance FromJSON Bumboatman where
    parseJSON xs@(Array _) = (fmap NullArrayInBumboatman . parseJSON) xs
    parseJSON Null = return NullInBumboatman
    parseJSON xs@(String _) = (fmap StringInBumboatman . parseJSON) xs

instance ToJSON Calaverite where
    toJSON (IntegerArrayInCalaverite x) = toJSON x
    toJSON (StringInCalaverite x) = toJSON x

instance FromJSON Calaverite where
    parseJSON xs@(Array _) = (fmap IntegerArrayInCalaverite . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInCalaverite . parseJSON) xs

instance ToJSON Catallactic where
    toJSON (BoolInCatallactic x) = toJSON x
    toJSON (IntegerMapInCatallactic x) = toJSON x
    toJSON (NullArrayInCatallactic x) = toJSON x

instance FromJSON Catallactic where
    parseJSON xs@(Bool _) = (fmap BoolInCatallactic . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInCatallactic . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInCatallactic . parseJSON) xs

instance ToJSON Cemental where
    toJSON (DoubleInCemental x) = toJSON x
    toJSON (IntegerArrayInCemental x) = toJSON x
    toJSON (IntegerMapInCemental x) = toJSON x

instance FromJSON Cemental where
    parseJSON xs@(Number _) = (fmap DoubleInCemental . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInCemental . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInCemental . parseJSON) xs

instance ToJSON ChytridiaceaeElement where
    toJSON (BoolInChytridiaceaeElement x) = toJSON x
    toJSON (ChytridiaceaeClassInChytridiaceaeElement x) = toJSON x
    toJSON NullInChytridiaceaeElement = Null

instance FromJSON ChytridiaceaeElement where
    parseJSON xs@(Bool _) = (fmap BoolInChytridiaceaeElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ChytridiaceaeClassInChytridiaceaeElement . parseJSON) xs
    parseJSON Null = return NullInChytridiaceaeElement

instance ToJSON ChytridiaceaeClass where
    toJSON (ChytridiaceaeClass batidaceaeChytridiaceaeClass brechitesChytridiaceaeClass codespairerChytridiaceaeClass emeryChytridiaceaeClass enervativeChytridiaceaeClass excriminateChytridiaceaeClass gosheniteChytridiaceaeClass grimeChytridiaceaeClass grittenChytridiaceaeClass hectorlyChytridiaceaeClass intermediationChytridiaceaeClass meeterlyChytridiaceaeClass narragansetChytridiaceaeClass onymaticChytridiaceaeClass paddlecockChytridiaceaeClass thanaChytridiaceaeClass thornilyChytridiaceaeClass uckiaChytridiaceaeClass unmettleChytridiaceaeClass vorticellidChytridiaceaeClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Batidaceae" .= batidaceaeChytridiaceaeClass
        , Just $ "Brechites" .= brechitesChytridiaceaeClass
        , Just $ "codespairer" .= codespairerChytridiaceaeClass
        , Just $ "Emery" .= emeryChytridiaceaeClass
        , Just $ "enervative" .= enervativeChytridiaceaeClass
        , Just $ "excriminate" .= excriminateChytridiaceaeClass
        , Just $ "goshenite" .= gosheniteChytridiaceaeClass
        , Just $ "grime" .= grimeChytridiaceaeClass
        , Just $ "gritten" .= grittenChytridiaceaeClass
        , Just $ "hectorly" .= hectorlyChytridiaceaeClass
        , Just $ "intermediation" .= intermediationChytridiaceaeClass
        , Just $ "meeterly" .= meeterlyChytridiaceaeClass
        , Just $ "Narraganset" .= narragansetChytridiaceaeClass
        , Just $ "onymatic" .= onymaticChytridiaceaeClass
        , Just $ "paddlecock" .= paddlecockChytridiaceaeClass
        , Just $ "thana" .= thanaChytridiaceaeClass
        , Just $ "thornily" .= thornilyChytridiaceaeClass
        , Just $ "uckia" .= uckiaChytridiaceaeClass
        , Just $ "unmettle" .= unmettleChytridiaceaeClass
        , Just $ "vorticellid" .= vorticellidChytridiaceaeClass
        ]

instance FromJSON ChytridiaceaeClass where
    parseJSON (Object v) = ChytridiaceaeClass
        <$> v .: "Batidaceae"
        <*> v .: "Brechites"
        <*> v .: "codespairer"
        <*> v .: "Emery"
        <*> v .: "enervative"
        <*> v .: "excriminate"
        <*> v .: "goshenite"
        <*> v .: "grime"
        <*> v .: "gritten"
        <*> v .: "hectorly"
        <*> v .: "intermediation"
        <*> v .: "meeterly"
        <*> v .: "Narraganset"
        <*> v .: "onymatic"
        <*> v .: "paddlecock"
        <*> v .: "thana"
        <*> v .: "thornily"
        <*> v .: "uckia"
        <*> v .: "unmettle"
        <*> v .: "vorticellid"

instance ToJSON DiscordiaElement where
    toJSON (DiscordiaClassInDiscordiaElement x) = toJSON x
    toJSON (IntegerArrayInDiscordiaElement x) = toJSON x

instance FromJSON DiscordiaElement where
    parseJSON xs@(Object _) = (fmap DiscordiaClassInDiscordiaElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInDiscordiaElement . parseJSON) xs

instance ToJSON DiscordiaClass where
    toJSON (DiscordiaClass altaicDiscordiaClass amoristicDiscordiaClass blennophthalmiaDiscordiaClass catharticalnessDiscordiaClass chirotheriumDiscordiaClass disciplinabilityDiscordiaClass disdiapasonDiscordiaClass gooferDiscordiaClass homocercDiscordiaClass laryngographDiscordiaClass leucitisDiscordiaClass lymphocystDiscordiaClass microcosmologyDiscordiaClass nauseationDiscordiaClass nonbookishDiscordiaClass patarinDiscordiaClass preliberalDiscordiaClass prettifierDiscordiaClass rangeworkDiscordiaClass redientDiscordiaClass subfusiformDiscordiaClass suicidicalDiscordiaClass swowDiscordiaClass wastrelDiscordiaClass wingleDiscordiaClass) =
        object $ foldMap (maybe [] pure)
        [ ("Altaic" .=) <$> altaicDiscordiaClass
        , ("amoristic" .=) <$> amoristicDiscordiaClass
        , ("blennophthalmia" .=) <$> blennophthalmiaDiscordiaClass
        , ("catharticalness" .=) <$> catharticalnessDiscordiaClass
        , ("Chirotherium" .=) <$> chirotheriumDiscordiaClass
        , ("disciplinability" .=) <$> disciplinabilityDiscordiaClass
        , ("disdiapason" .=) <$> disdiapasonDiscordiaClass
        , ("goofer" .=) <$> gooferDiscordiaClass
        , ("homocerc" .=) <$> homocercDiscordiaClass
        , ("laryngograph" .=) <$> laryngographDiscordiaClass
        , ("leucitis" .=) <$> leucitisDiscordiaClass
        , ("lymphocyst" .=) <$> lymphocystDiscordiaClass
        , ("microcosmology" .=) <$> microcosmologyDiscordiaClass
        , ("nauseation" .=) <$> nauseationDiscordiaClass
        , ("nonbookish" .=) <$> nonbookishDiscordiaClass
        , ("Patarin" .=) <$> patarinDiscordiaClass
        , ("preliberal" .=) <$> preliberalDiscordiaClass
        , ("prettifier" .=) <$> prettifierDiscordiaClass
        , ("rangework" .=) <$> rangeworkDiscordiaClass
        , ("redient" .=) <$> redientDiscordiaClass
        , ("subfusiform" .=) <$> subfusiformDiscordiaClass
        , ("suicidical" .=) <$> suicidicalDiscordiaClass
        , ("swow" .=) <$> swowDiscordiaClass
        , ("wastrel" .=) <$> wastrelDiscordiaClass
        , ("wingle" .=) <$> wingleDiscordiaClass
        ]

instance FromJSON DiscordiaClass where
    parseJSON (Object v) = DiscordiaClass
        <$> v .:! "Altaic"
        <*> v .:! "amoristic"
        <*> v .:! "blennophthalmia"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "disciplinability"
        <*> v .:! "disdiapason"
        <*> v .:! "goofer"
        <*> v .:! "homocerc"
        <*> v .:! "laryngograph"
        <*> v .:! "leucitis"
        <*> v .:! "lymphocyst"
        <*> v .:! "microcosmology"
        <*> v .:! "nauseation"
        <*> v .:! "nonbookish"
        <*> v .:! "Patarin"
        <*> v .:! "preliberal"
        <*> v .:! "prettifier"
        <*> v .:! "rangework"
        <*> v .:! "redient"
        <*> v .:! "subfusiform"
        <*> v .:! "suicidical"
        <*> v .:! "swow"
        <*> v .:! "wastrel"
        <*> v .:! "wingle"

instance ToJSON Endomyce where
    toJSON (IntegerInEndomyce x) = toJSON x
    toJSON (StringInEndomyce x) = toJSON x

instance FromJSON Endomyce where
    parseJSON xs@(Number _) = (fmap IntegerInEndomyce . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInEndomyce . parseJSON) xs

instance ToJSON Epinephelidae where
    toJSON (BoolInEpinephelidae x) = toJSON x
    toJSON (IntegerInEpinephelidae x) = toJSON x
    toJSON (StringInEpinephelidae x) = toJSON x

instance FromJSON Epinephelidae where
    parseJSON xs@(Bool _) = (fmap BoolInEpinephelidae . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInEpinephelidae . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInEpinephelidae . parseJSON) xs

instance ToJSON Eupatorium where
    toJSON (IntegerMapInEupatorium x) = toJSON x
    toJSON (NullArrayInEupatorium x) = toJSON x

instance FromJSON Eupatorium where
    parseJSON xs@(Object _) = (fmap IntegerMapInEupatorium . parseJSON) xs
    parseJSON xs@(Array _) = (fmap NullArrayInEupatorium . parseJSON) xs

instance ToJSON GryphosaurusElement where
    toJSON (GryphosaurusClassInGryphosaurusElement x) = toJSON x
    toJSON (IntegerArrayInGryphosaurusElement x) = toJSON x
    toJSON (StringInGryphosaurusElement x) = toJSON x

instance FromJSON GryphosaurusElement where
    parseJSON xs@(Object _) = (fmap GryphosaurusClassInGryphosaurusElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInGryphosaurusElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInGryphosaurusElement . parseJSON) xs

instance ToJSON GryphosaurusClass where
    toJSON (GryphosaurusClass amissibilityGryphosaurusClass burushaskiGryphosaurusClass citroninGryphosaurusClass coplaintiffGryphosaurusClass disquisitionaryGryphosaurusClass enoplanGryphosaurusClass faintnessGryphosaurusClass hebetomyGryphosaurusClass islandryGryphosaurusClass lameduckGryphosaurusClass overbattleGryphosaurusClass overinterestedGryphosaurusClass phrenologicGryphosaurusClass rainbandGryphosaurusClass shininglyGryphosaurusClass stamineousGryphosaurusClass subscapularisGryphosaurusClass tahamiGryphosaurusClass undaubedGryphosaurusClass underntimeGryphosaurusClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "amissibility" .= amissibilityGryphosaurusClass
        , Just $ "Burushaski" .= burushaskiGryphosaurusClass
        , Just $ "citronin" .= citroninGryphosaurusClass
        , Just $ "coplaintiff" .= coplaintiffGryphosaurusClass
        , Just $ "disquisitionary" .= disquisitionaryGryphosaurusClass
        , Just $ "enoplan" .= enoplanGryphosaurusClass
        , Just $ "faintness" .= faintnessGryphosaurusClass
        , Just $ "hebetomy" .= hebetomyGryphosaurusClass
        , Just $ "islandry" .= islandryGryphosaurusClass
        , Just $ "lameduck" .= lameduckGryphosaurusClass
        , Just $ "overbattle" .= overbattleGryphosaurusClass
        , Just $ "overinterested" .= overinterestedGryphosaurusClass
        , Just $ "phrenologic" .= phrenologicGryphosaurusClass
        , Just $ "rainband" .= rainbandGryphosaurusClass
        , Just $ "shiningly" .= shininglyGryphosaurusClass
        , Just $ "stamineous" .= stamineousGryphosaurusClass
        , Just $ "subscapularis" .= subscapularisGryphosaurusClass
        , Just $ "Tahami" .= tahamiGryphosaurusClass
        , Just $ "undaubed" .= undaubedGryphosaurusClass
        , Just $ "underntime" .= underntimeGryphosaurusClass
        ]

instance FromJSON GryphosaurusClass where
    parseJSON (Object v) = GryphosaurusClass
        <$> v .: "amissibility"
        <*> v .: "Burushaski"
        <*> v .: "citronin"
        <*> v .: "coplaintiff"
        <*> v .: "disquisitionary"
        <*> v .: "enoplan"
        <*> v .: "faintness"
        <*> v .: "hebetomy"
        <*> v .: "islandry"
        <*> v .: "lameduck"
        <*> v .: "overbattle"
        <*> v .: "overinterested"
        <*> v .: "phrenologic"
        <*> v .: "rainband"
        <*> v .: "shiningly"
        <*> v .: "stamineous"
        <*> v .: "subscapularis"
        <*> v .: "Tahami"
        <*> v .: "undaubed"
        <*> v .: "underntime"

instance ToJSON Koryak where
    toJSON (StringInKoryak x) = toJSON x
    toJSON (UnionMapInKoryak x) = toJSON x

instance FromJSON Koryak where
    parseJSON xs@(String _) = (fmap StringInKoryak . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionMapInKoryak . parseJSON) xs

instance ToJSON LaviniaElement where
    toJSON (LaviniaClassInLaviniaElement x) = toJSON x
    toJSON (StringInLaviniaElement x) = toJSON x

instance FromJSON LaviniaElement where
    parseJSON xs@(Object _) = (fmap LaviniaClassInLaviniaElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInLaviniaElement . parseJSON) xs

instance ToJSON LaviniaClass where
    toJSON (LaviniaClass agitableLaviniaClass asininityLaviniaClass benefiterLaviniaClass bronzelikeLaviniaClass catharticalnessLaviniaClass chirotheriumLaviniaClass cholesteatomatousLaviniaClass deprivementLaviniaClass disdiapasonLaviniaClass flippantnessLaviniaClass fogproofLaviniaClass homocercLaviniaClass merrymeetingLaviniaClass nonbookishLaviniaClass overcarefulLaviniaClass panarisLaviniaClass preacceptanceLaviniaClass quinoxalineLaviniaClass sigLaviniaClass superconfusionLaviniaClass tacanaLaviniaClass tillotterLaviniaClass tranquillizeLaviniaClass unquestionableLaviniaClass uprouteLaviniaClass) =
        object $ foldMap (maybe [] pure)
        [ ("agitable" .=) <$> agitableLaviniaClass
        , ("asininity" .=) <$> asininityLaviniaClass
        , ("benefiter" .=) <$> benefiterLaviniaClass
        , ("bronzelike" .=) <$> bronzelikeLaviniaClass
        , ("catharticalness" .=) <$> catharticalnessLaviniaClass
        , ("Chirotherium" .=) <$> chirotheriumLaviniaClass
        , ("cholesteatomatous" .=) <$> cholesteatomatousLaviniaClass
        , ("deprivement" .=) <$> deprivementLaviniaClass
        , ("disdiapason" .=) <$> disdiapasonLaviniaClass
        , ("flippantness" .=) <$> flippantnessLaviniaClass
        , ("fogproof" .=) <$> fogproofLaviniaClass
        , ("homocerc" .=) <$> homocercLaviniaClass
        , ("merrymeeting" .=) <$> merrymeetingLaviniaClass
        , ("nonbookish" .=) <$> nonbookishLaviniaClass
        , ("overcareful" .=) <$> overcarefulLaviniaClass
        , ("panaris" .=) <$> panarisLaviniaClass
        , ("preacceptance" .=) <$> preacceptanceLaviniaClass
        , ("quinoxaline" .=) <$> quinoxalineLaviniaClass
        , ("sig" .=) <$> sigLaviniaClass
        , ("superconfusion" .=) <$> superconfusionLaviniaClass
        , ("Tacana" .=) <$> tacanaLaviniaClass
        , ("tillotter" .=) <$> tillotterLaviniaClass
        , ("tranquillize" .=) <$> tranquillizeLaviniaClass
        , ("unquestionable" .=) <$> unquestionableLaviniaClass
        , ("uproute" .=) <$> uprouteLaviniaClass
        ]

instance FromJSON LaviniaClass where
    parseJSON (Object v) = LaviniaClass
        <$> v .:! "agitable"
        <*> v .:! "asininity"
        <*> v .:! "benefiter"
        <*> v .:! "bronzelike"
        <*> v .:! "catharticalness"
        <*> v .:! "Chirotherium"
        <*> v .:! "cholesteatomatous"
        <*> v .:! "deprivement"
        <*> v .:! "disdiapason"
        <*> v .:! "flippantness"
        <*> v .:! "fogproof"
        <*> v .:! "homocerc"
        <*> v .:! "merrymeeting"
        <*> v .:! "nonbookish"
        <*> v .:! "overcareful"
        <*> v .:! "panaris"
        <*> v .:! "preacceptance"
        <*> v .:! "quinoxaline"
        <*> v .:! "sig"
        <*> v .:! "superconfusion"
        <*> v .:! "Tacana"
        <*> v .:! "tillotter"
        <*> v .:! "tranquillize"
        <*> v .:! "unquestionable"
        <*> v .:! "uproute"

instance ToJSON OskarElement where
    toJSON (IntegerArrayInOskarElement x) = toJSON x
    toJSON (OskarClassInOskarElement x) = toJSON x

instance FromJSON OskarElement where
    parseJSON xs@(Array _) = (fmap IntegerArrayInOskarElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OskarClassInOskarElement . parseJSON) xs

instance ToJSON OskarClass where
    toJSON (OskarClass acrobatesOskarClass beanshooterOskarClass bearhoundOskarClass cayugaOskarClass guarneriOskarClass hypochondriacismOskarClass indicationOskarClass jaculativeOskarClass naganaOskarClass netherlandishOskarClass noctivagousOskarClass nonphysiologicalOskarClass praxisOskarClass provisionOskarClass subterhumanOskarClass sunlitOskarClass syncraniateOskarClass teachmentOskarClass unmutinousOskarClass unstoppableOskarClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Acrobates" .= acrobatesOskarClass
        , Just $ "beanshooter" .= beanshooterOskarClass
        , Just $ "bearhound" .= bearhoundOskarClass
        , Just $ "Cayuga" .= cayugaOskarClass
        , Just $ "guarneri" .= guarneriOskarClass
        , Just $ "hypochondriacism" .= hypochondriacismOskarClass
        , Just $ "indication" .= indicationOskarClass
        , Just $ "jaculative" .= jaculativeOskarClass
        , Just $ "nagana" .= naganaOskarClass
        , Just $ "Netherlandish" .= netherlandishOskarClass
        , Just $ "noctivagous" .= noctivagousOskarClass
        , Just $ "nonphysiological" .= nonphysiologicalOskarClass
        , Just $ "praxis" .= praxisOskarClass
        , Just $ "provision" .= provisionOskarClass
        , Just $ "subterhuman" .= subterhumanOskarClass
        , Just $ "sunlit" .= sunlitOskarClass
        , Just $ "syncraniate" .= syncraniateOskarClass
        , Just $ "teachment" .= teachmentOskarClass
        , Just $ "unmutinous" .= unmutinousOskarClass
        , Just $ "unstoppable" .= unstoppableOskarClass
        ]

instance FromJSON OskarClass where
    parseJSON (Object v) = OskarClass
        <$> v .: "Acrobates"
        <*> v .: "beanshooter"
        <*> v .: "bearhound"
        <*> v .: "Cayuga"
        <*> v .: "guarneri"
        <*> v .: "hypochondriacism"
        <*> v .: "indication"
        <*> v .: "jaculative"
        <*> v .: "nagana"
        <*> v .: "Netherlandish"
        <*> v .: "noctivagous"
        <*> v .: "nonphysiological"
        <*> v .: "praxis"
        <*> v .: "provision"
        <*> v .: "subterhuman"
        <*> v .: "sunlit"
        <*> v .: "syncraniate"
        <*> v .: "teachment"
        <*> v .: "unmutinous"
        <*> v .: "unstoppable"

instance ToJSON RebeccaElement where
    toJSON (IntegerInRebeccaElement x) = toJSON x
    toJSON (RebeccaInRebeccaElement x) = toJSON x
    toJSON (StringInRebeccaElement x) = toJSON x

instance FromJSON RebeccaElement where
    parseJSON xs@(Number _) = (fmap IntegerInRebeccaElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInRebeccaElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInRebeccaElement . parseJSON) xs

instance ToJSON Rhomboganoidei where
    toJSON (IntegerArrayInRhomboganoidei x) = toJSON x
    toJSON (RebeccaInRhomboganoidei x) = toJSON x
    toJSON (StringInRhomboganoidei x) = toJSON x

instance FromJSON Rhomboganoidei where
    parseJSON xs@(Array _) = (fmap IntegerArrayInRhomboganoidei . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInRhomboganoidei . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInRhomboganoidei . parseJSON) xs

instance ToJSON Ruellia where
    toJSON (BoolInRuellia x) = toJSON x
    toJSON (RebeccaInRuellia x) = toJSON x
    toJSON (StringInRuellia x) = toJSON x

instance FromJSON Ruellia where
    parseJSON xs@(Bool _) = (fmap BoolInRuellia . parseJSON) xs
    parseJSON xs@(Object _) = (fmap RebeccaInRuellia . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInRuellia . parseJSON) xs

instance ToJSON School where
    toJSON (IntegerInSchool x) = toJSON x
    toJSON (IntegerMapInSchool x) = toJSON x
    toJSON NullInSchool = Null

instance FromJSON School where
    parseJSON xs@(Number _) = (fmap IntegerInSchool . parseJSON) xs
    parseJSON xs@(Object _) = (fmap IntegerMapInSchool . parseJSON) xs
    parseJSON Null = return NullInSchool

instance ToJSON Shakespearolater where
    toJSON (DoubleInShakespearolater x) = toJSON x
    toJSON (IntegerArrayInShakespearolater x) = toJSON x
    toJSON (StringInShakespearolater x) = toJSON x

instance FromJSON Shakespearolater where
    parseJSON xs@(Number _) = (fmap DoubleInShakespearolater . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInShakespearolater . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInShakespearolater . parseJSON) xs
