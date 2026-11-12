{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , PurpleQuickType (..)
    , FluffyQuickType (..)
    , Breed (..)
    , Firstname (..)
    , Lastname (..)
    , Pvptitle (..)
    , RankTitle (..)
    , Sex (..)
    , QuickTypeUnion (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeUnion]

data QuickTypeUnion
    = FluffyQuickTypeInQuickTypeUnion FluffyQuickType
    | PurpleQuickTypeArrayInQuickTypeUnion ([PurpleQuickType])
    | StringInQuickTypeUnion Text
    deriving (Show)

data PurpleQuickType = PurpleQuickType
    { alienlevelPurpleQuickType :: Int
    , breedPurpleQuickType :: Breed
    , charDimensionPurpleQuickType :: Int
    , charInstancePurpleQuickType :: Int
    , defenderRankTitlePurpleQuickType :: Text
    , firstnamePurpleQuickType :: Firstname
    , headidPurpleQuickType :: Int
    , lastnamePurpleQuickType :: Lastname
    , levelxPurpleQuickType :: Int
    , namePurpleQuickType :: Text
    , profPurpleQuickType :: Text
    , profTitlePurpleQuickType :: Text
    , pvpratingPurpleQuickType :: Int
    , pvptitlePurpleQuickType :: Pvptitle
    , rankPurpleQuickType :: Int
    , rankTitlePurpleQuickType :: RankTitle
    , sexPurpleQuickType :: Sex
    } deriving (Show)

data Breed
    = AtroxBreed
    | SolitusBreed
    | OpifexBreed
    | NanoBreed
    deriving (Show)

data Firstname
    = PurpleFirstname
    | ChiFirstname
    deriving (Show)

data Lastname
    = PurpleLastname
    | WashkoLastname
    deriving (Show)

data Pvptitle
    = FreshmanPvptitle
    deriving (Show)

data RankTitle
    = PresidentRankTitle
    | AdvisorRankTitle
    | VeteranRankTitle
    | ApplicantRankTitle
    deriving (Show)

data Sex
    = NeuterSex
    | MaleSex
    | FemaleSex
    deriving (Show)

data FluffyQuickType = FluffyQuickType
    { adventurercountFluffyQuickType :: Int
    , agentcountFluffyQuickType :: Int
    , atroxcountFluffyQuickType :: Int
    , avglvlFluffyQuickType :: Double
    , btcountFluffyQuickType :: Int
    , descriptionFluffyQuickType :: Text
    , doctorcountFluffyQuickType :: Int
    , enfcountFluffyQuickType :: Int
    , engineeercountFluffyQuickType :: Int
    , femalecountFluffyQuickType :: Int
    , fixercountFluffyQuickType :: Int
    , governingnameFluffyQuickType :: Text
    , historyFluffyQuickType :: Text
    , keepercountFluffyQuickType :: Int
    , macountFluffyQuickType :: Int
    , malecountFluffyQuickType :: Int
    , maxlvlFluffyQuickType :: Int
    , metacountFluffyQuickType :: Int
    , minlvlFluffyQuickType :: Int
    , monstercountFluffyQuickType :: Int
    , nameFluffyQuickType :: Text
    , nanocountFluffyQuickType :: Int
    , nanoracecountFluffyQuickType :: Int
    , neutercountFluffyQuickType :: Int
    , nummembersFluffyQuickType :: Int
    , objectiveFluffyQuickType :: Text
    , opifexcountFluffyQuickType :: Int
    , orgDimensionFluffyQuickType :: Int
    , orgInstanceFluffyQuickType :: Int
    , shadecountFluffyQuickType :: Int
    , sideFluffyQuickType :: Int
    , sideNameFluffyQuickType :: Text
    , solidercountFluffyQuickType :: Int
    , solituscountFluffyQuickType :: Int
    , tradercountFluffyQuickType :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeUnion where
    toJSON (FluffyQuickTypeInQuickTypeUnion x) = toJSON x
    toJSON (PurpleQuickTypeArrayInQuickTypeUnion x) = toJSON x
    toJSON (StringInQuickTypeUnion x) = toJSON x

instance FromJSON QuickTypeUnion where
    parseJSON xs@(Object _) = (fmap FluffyQuickTypeInQuickTypeUnion . parseJSON) xs
    parseJSON xs@(Array _) = (fmap PurpleQuickTypeArrayInQuickTypeUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInQuickTypeUnion . parseJSON) xs

instance ToJSON PurpleQuickType where
    toJSON (PurpleQuickType alienlevelPurpleQuickType breedPurpleQuickType charDimensionPurpleQuickType charInstancePurpleQuickType defenderRankTitlePurpleQuickType firstnamePurpleQuickType headidPurpleQuickType lastnamePurpleQuickType levelxPurpleQuickType namePurpleQuickType profPurpleQuickType profTitlePurpleQuickType pvpratingPurpleQuickType pvptitlePurpleQuickType rankPurpleQuickType rankTitlePurpleQuickType sexPurpleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ALIENLEVEL" .= alienlevelPurpleQuickType
        , Just $ "BREED" .= breedPurpleQuickType
        , Just $ "CHAR_DIMENSION" .= charDimensionPurpleQuickType
        , Just $ "CHAR_INSTANCE" .= charInstancePurpleQuickType
        , Just $ "DEFENDER_RANK_TITLE" .= defenderRankTitlePurpleQuickType
        , Just $ "FIRSTNAME" .= firstnamePurpleQuickType
        , Just $ "HEADID" .= headidPurpleQuickType
        , Just $ "LASTNAME" .= lastnamePurpleQuickType
        , Just $ "LEVELX" .= levelxPurpleQuickType
        , Just $ "NAME" .= namePurpleQuickType
        , Just $ "PROF" .= profPurpleQuickType
        , Just $ "PROF_TITLE" .= profTitlePurpleQuickType
        , Just $ "PVPRATING" .= pvpratingPurpleQuickType
        , Just $ "PVPTITLE" .= pvptitlePurpleQuickType
        , Just $ "RANK" .= rankPurpleQuickType
        , Just $ "RANK_TITLE" .= rankTitlePurpleQuickType
        , Just $ "SEX" .= sexPurpleQuickType
        ]

instance FromJSON PurpleQuickType where
    parseJSON (Object v) = PurpleQuickType
        <$> v .: "ALIENLEVEL"
        <*> v .: "BREED"
        <*> v .: "CHAR_DIMENSION"
        <*> v .: "CHAR_INSTANCE"
        <*> v .: "DEFENDER_RANK_TITLE"
        <*> v .: "FIRSTNAME"
        <*> v .: "HEADID"
        <*> v .: "LASTNAME"
        <*> v .: "LEVELX"
        <*> v .: "NAME"
        <*> v .: "PROF"
        <*> v .: "PROF_TITLE"
        <*> v .: "PVPRATING"
        <*> v .: "PVPTITLE"
        <*> v .: "RANK"
        <*> v .: "RANK_TITLE"
        <*> v .: "SEX"

instance ToJSON Breed where
    toJSON AtroxBreed = "Atrox"
    toJSON SolitusBreed = "Solitus"
    toJSON OpifexBreed = "Opifex"
    toJSON NanoBreed = "Nano"

instance FromJSON Breed where
    parseJSON = withText "Breed" parseText
        where
            parseText "Atrox" = return AtroxBreed
            parseText "Solitus" = return SolitusBreed
            parseText "Opifex" = return OpifexBreed
            parseText "Nano" = return NanoBreed

instance ToJSON Firstname where
    toJSON PurpleFirstname = ""
    toJSON ChiFirstname = "Chi"

instance FromJSON Firstname where
    parseJSON = withText "Firstname" parseText
        where
            parseText "" = return PurpleFirstname
            parseText "Chi" = return ChiFirstname

instance ToJSON Lastname where
    toJSON PurpleLastname = ""
    toJSON WashkoLastname = "Washko"

instance FromJSON Lastname where
    parseJSON = withText "Lastname" parseText
        where
            parseText "" = return PurpleLastname
            parseText "Washko" = return WashkoLastname

instance ToJSON Pvptitle where
    toJSON FreshmanPvptitle = "Freshman"

instance FromJSON Pvptitle where
    parseJSON = withText "Pvptitle" parseText
        where
            parseText "Freshman" = return FreshmanPvptitle

instance ToJSON RankTitle where
    toJSON PresidentRankTitle = "President"
    toJSON AdvisorRankTitle = "Advisor"
    toJSON VeteranRankTitle = "Veteran"
    toJSON ApplicantRankTitle = "Applicant"

instance FromJSON RankTitle where
    parseJSON = withText "RankTitle" parseText
        where
            parseText "President" = return PresidentRankTitle
            parseText "Advisor" = return AdvisorRankTitle
            parseText "Veteran" = return VeteranRankTitle
            parseText "Applicant" = return ApplicantRankTitle

instance ToJSON Sex where
    toJSON NeuterSex = "Neuter"
    toJSON MaleSex = "Male"
    toJSON FemaleSex = "Female"

instance FromJSON Sex where
    parseJSON = withText "Sex" parseText
        where
            parseText "Neuter" = return NeuterSex
            parseText "Male" = return MaleSex
            parseText "Female" = return FemaleSex

instance ToJSON FluffyQuickType where
    toJSON (FluffyQuickType adventurercountFluffyQuickType agentcountFluffyQuickType atroxcountFluffyQuickType avglvlFluffyQuickType btcountFluffyQuickType descriptionFluffyQuickType doctorcountFluffyQuickType enfcountFluffyQuickType engineeercountFluffyQuickType femalecountFluffyQuickType fixercountFluffyQuickType governingnameFluffyQuickType historyFluffyQuickType keepercountFluffyQuickType macountFluffyQuickType malecountFluffyQuickType maxlvlFluffyQuickType metacountFluffyQuickType minlvlFluffyQuickType monstercountFluffyQuickType nameFluffyQuickType nanocountFluffyQuickType nanoracecountFluffyQuickType neutercountFluffyQuickType nummembersFluffyQuickType objectiveFluffyQuickType opifexcountFluffyQuickType orgDimensionFluffyQuickType orgInstanceFluffyQuickType shadecountFluffyQuickType sideFluffyQuickType sideNameFluffyQuickType solidercountFluffyQuickType solituscountFluffyQuickType tradercountFluffyQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ADVENTURERCOUNT" .= adventurercountFluffyQuickType
        , Just $ "AGENTCOUNT" .= agentcountFluffyQuickType
        , Just $ "ATROXCOUNT" .= atroxcountFluffyQuickType
        , Just $ "AVGLVL" .= avglvlFluffyQuickType
        , Just $ "BTCOUNT" .= btcountFluffyQuickType
        , Just $ "DESCRIPTION" .= descriptionFluffyQuickType
        , Just $ "DOCTORCOUNT" .= doctorcountFluffyQuickType
        , Just $ "ENFCOUNT" .= enfcountFluffyQuickType
        , Just $ "ENGINEEERCOUNT" .= engineeercountFluffyQuickType
        , Just $ "FEMALECOUNT" .= femalecountFluffyQuickType
        , Just $ "FIXERCOUNT" .= fixercountFluffyQuickType
        , Just $ "GOVERNINGNAME" .= governingnameFluffyQuickType
        , Just $ "HISTORY" .= historyFluffyQuickType
        , Just $ "KEEPERCOUNT" .= keepercountFluffyQuickType
        , Just $ "MACOUNT" .= macountFluffyQuickType
        , Just $ "MALECOUNT" .= malecountFluffyQuickType
        , Just $ "MAXLVL" .= maxlvlFluffyQuickType
        , Just $ "METACOUNT" .= metacountFluffyQuickType
        , Just $ "MINLVL" .= minlvlFluffyQuickType
        , Just $ "MONSTERCOUNT" .= monstercountFluffyQuickType
        , Just $ "NAME" .= nameFluffyQuickType
        , Just $ "NANOCOUNT" .= nanocountFluffyQuickType
        , Just $ "NANORACECOUNT" .= nanoracecountFluffyQuickType
        , Just $ "NEUTERCOUNT" .= neutercountFluffyQuickType
        , Just $ "NUMMEMBERS" .= nummembersFluffyQuickType
        , Just $ "OBJECTIVE" .= objectiveFluffyQuickType
        , Just $ "OPIFEXCOUNT" .= opifexcountFluffyQuickType
        , Just $ "ORG_DIMENSION" .= orgDimensionFluffyQuickType
        , Just $ "ORG_INSTANCE" .= orgInstanceFluffyQuickType
        , Just $ "SHADECOUNT" .= shadecountFluffyQuickType
        , Just $ "SIDE" .= sideFluffyQuickType
        , Just $ "SIDE_NAME" .= sideNameFluffyQuickType
        , Just $ "SOLIDERCOUNT" .= solidercountFluffyQuickType
        , Just $ "SOLITUSCOUNT" .= solituscountFluffyQuickType
        , Just $ "TRADERCOUNT" .= tradercountFluffyQuickType
        ]

instance FromJSON FluffyQuickType where
    parseJSON (Object v) = FluffyQuickType
        <$> v .: "ADVENTURERCOUNT"
        <*> v .: "AGENTCOUNT"
        <*> v .: "ATROXCOUNT"
        <*> v .: "AVGLVL"
        <*> v .: "BTCOUNT"
        <*> v .: "DESCRIPTION"
        <*> v .: "DOCTORCOUNT"
        <*> v .: "ENFCOUNT"
        <*> v .: "ENGINEEERCOUNT"
        <*> v .: "FEMALECOUNT"
        <*> v .: "FIXERCOUNT"
        <*> v .: "GOVERNINGNAME"
        <*> v .: "HISTORY"
        <*> v .: "KEEPERCOUNT"
        <*> v .: "MACOUNT"
        <*> v .: "MALECOUNT"
        <*> v .: "MAXLVL"
        <*> v .: "METACOUNT"
        <*> v .: "MINLVL"
        <*> v .: "MONSTERCOUNT"
        <*> v .: "NAME"
        <*> v .: "NANOCOUNT"
        <*> v .: "NANORACECOUNT"
        <*> v .: "NEUTERCOUNT"
        <*> v .: "NUMMEMBERS"
        <*> v .: "OBJECTIVE"
        <*> v .: "OPIFEXCOUNT"
        <*> v .: "ORG_DIMENSION"
        <*> v .: "ORG_INSTANCE"
        <*> v .: "SHADECOUNT"
        <*> v .: "SIDE"
        <*> v .: "SIDE_NAME"
        <*> v .: "SOLIDERCOUNT"
        <*> v .: "SOLITUSCOUNT"
        <*> v .: "TRADERCOUNT"
