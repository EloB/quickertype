{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , PurpleQuickType (..)
    , Adminregion (..)
    , FluffyQuickType (..)
    , ID (..)
    , ValueEnum (..)
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
    deriving (Show)

data PurpleQuickType = PurpleQuickType
    { adminregionPurpleQuickType :: Adminregion
    , capitalCityPurpleQuickType :: Text
    , incomeLevelPurpleQuickType :: Adminregion
    , iso2CodePurpleQuickType :: Text
    , latitudePurpleQuickType :: Text
    , lendingTypePurpleQuickType :: Adminregion
    , longitudePurpleQuickType :: Text
    , namePurpleQuickType :: Text
    , quickTypeIDPurpleQuickType :: Text
    , regionPurpleQuickType :: Adminregion
    } deriving (Show)

data Adminregion = Adminregion
    { adminregionIDAdminregion :: ID
    , valueAdminregion :: ValueEnum
    } deriving (Show)

data ID
    = PurpleID
    | SASID
    | SSAID
    | EcaID
    | LacID
    | EAPID
    | MnaID
    | HicID
    | LicID
    | NaID
    | LmcID
    | UmcID
    | LnxID
    | IdxID
    | IbdID
    | IdbID
    | LcnID
    | SsfID
    | EcsID
    | MeaID
    | EASID
    | NacID
    deriving (Show)

data ValueEnum
    = PurpleValueEnum
    | SouthAsiaValueEnum
    | SubSaharanAfricaExcludingHighIncomeValueEnum
    | EuropeCentralAsiaExcludingHighIncomeValueEnum
    | LatinAmericaCaribbeanExcludingHighIncomeValueEnum
    | EastAsiaPacificExcludingHighIncomeValueEnum
    | MiddleEastNorthAfricaExcludingHighIncomeValueEnum
    | HighIncomeValueEnum
    | LowIncomeValueEnum
    | AggregatesValueEnum
    | LowerMiddleIncomeValueEnum
    | UpperMiddleIncomeValueEnum
    | NotClassifiedValueEnum
    | IDAValueEnum
    | IBRDValueEnum
    | BlendValueEnum
    | LatinAmericaCaribbeanValueEnum
    | SubSaharanAfricaValueEnum
    | EuropeCentralAsiaValueEnum
    | MiddleEastNorthAfricaValueEnum
    | EastAsiaPacificValueEnum
    | NorthAmericaValueEnum
    deriving (Show)

data FluffyQuickType = FluffyQuickType
    { pageFluffyQuickType :: Int
    , pagesFluffyQuickType :: Int
    , perPageFluffyQuickType :: Text
    , totalFluffyQuickType :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeUnion where
    toJSON (FluffyQuickTypeInQuickTypeUnion x) = toJSON x
    toJSON (PurpleQuickTypeArrayInQuickTypeUnion x) = toJSON x

instance FromJSON QuickTypeUnion where
    parseJSON xs@(Object _) = (fmap FluffyQuickTypeInQuickTypeUnion . parseJSON) xs
    parseJSON xs@(Array _) = (fmap PurpleQuickTypeArrayInQuickTypeUnion . parseJSON) xs

instance ToJSON PurpleQuickType where
    toJSON (PurpleQuickType adminregionPurpleQuickType capitalCityPurpleQuickType incomeLevelPurpleQuickType iso2CodePurpleQuickType latitudePurpleQuickType lendingTypePurpleQuickType longitudePurpleQuickType namePurpleQuickType quickTypeIDPurpleQuickType regionPurpleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "adminregion" .= adminregionPurpleQuickType
        , Just $ "capitalCity" .= capitalCityPurpleQuickType
        , Just $ "incomeLevel" .= incomeLevelPurpleQuickType
        , Just $ "iso2Code" .= iso2CodePurpleQuickType
        , Just $ "latitude" .= latitudePurpleQuickType
        , Just $ "lendingType" .= lendingTypePurpleQuickType
        , Just $ "longitude" .= longitudePurpleQuickType
        , Just $ "name" .= namePurpleQuickType
        , Just $ "id" .= quickTypeIDPurpleQuickType
        , Just $ "region" .= regionPurpleQuickType
        ]

instance FromJSON PurpleQuickType where
    parseJSON (Object v) = PurpleQuickType
        <$> v .: "adminregion"
        <*> v .: "capitalCity"
        <*> v .: "incomeLevel"
        <*> v .: "iso2Code"
        <*> v .: "latitude"
        <*> v .: "lendingType"
        <*> v .: "longitude"
        <*> v .: "name"
        <*> v .: "id"
        <*> v .: "region"

instance ToJSON Adminregion where
    toJSON (Adminregion adminregionIDAdminregion valueAdminregion) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= adminregionIDAdminregion
        , Just $ "value" .= valueAdminregion
        ]

instance FromJSON Adminregion where
    parseJSON (Object v) = Adminregion
        <$> v .: "id"
        <*> v .: "value"

instance ToJSON ID where
    toJSON PurpleID = ""
    toJSON SASID = "SAS"
    toJSON SSAID = "SSA"
    toJSON EcaID = "ECA"
    toJSON LacID = "LAC"
    toJSON EAPID = "EAP"
    toJSON MnaID = "MNA"
    toJSON HicID = "HIC"
    toJSON LicID = "LIC"
    toJSON NaID = "NA"
    toJSON LmcID = "LMC"
    toJSON UmcID = "UMC"
    toJSON LnxID = "LNX"
    toJSON IdxID = "IDX"
    toJSON IbdID = "IBD"
    toJSON IdbID = "IDB"
    toJSON LcnID = "LCN"
    toJSON SsfID = "SSF"
    toJSON EcsID = "ECS"
    toJSON MeaID = "MEA"
    toJSON EASID = "EAS"
    toJSON NacID = "NAC"

instance FromJSON ID where
    parseJSON = withText "ID" parseText
        where
            parseText "" = return PurpleID
            parseText "SAS" = return SASID
            parseText "SSA" = return SSAID
            parseText "ECA" = return EcaID
            parseText "LAC" = return LacID
            parseText "EAP" = return EAPID
            parseText "MNA" = return MnaID
            parseText "HIC" = return HicID
            parseText "LIC" = return LicID
            parseText "NA" = return NaID
            parseText "LMC" = return LmcID
            parseText "UMC" = return UmcID
            parseText "LNX" = return LnxID
            parseText "IDX" = return IdxID
            parseText "IBD" = return IbdID
            parseText "IDB" = return IdbID
            parseText "LCN" = return LcnID
            parseText "SSF" = return SsfID
            parseText "ECS" = return EcsID
            parseText "MEA" = return MeaID
            parseText "EAS" = return EASID
            parseText "NAC" = return NacID

instance ToJSON ValueEnum where
    toJSON PurpleValueEnum = ""
    toJSON SouthAsiaValueEnum = "South Asia"
    toJSON SubSaharanAfricaExcludingHighIncomeValueEnum = "Sub-Saharan Africa (excluding high income)"
    toJSON EuropeCentralAsiaExcludingHighIncomeValueEnum = "Europe & Central Asia (excluding high income)"
    toJSON LatinAmericaCaribbeanExcludingHighIncomeValueEnum = "Latin America & Caribbean (excluding high income)"
    toJSON EastAsiaPacificExcludingHighIncomeValueEnum = "East Asia & Pacific (excluding high income)"
    toJSON MiddleEastNorthAfricaExcludingHighIncomeValueEnum = "Middle East & North Africa (excluding high income)"
    toJSON HighIncomeValueEnum = "High income"
    toJSON LowIncomeValueEnum = "Low income"
    toJSON AggregatesValueEnum = "Aggregates"
    toJSON LowerMiddleIncomeValueEnum = "Lower middle income"
    toJSON UpperMiddleIncomeValueEnum = "Upper middle income"
    toJSON NotClassifiedValueEnum = "Not classified"
    toJSON IDAValueEnum = "IDA"
    toJSON IBRDValueEnum = "IBRD"
    toJSON BlendValueEnum = "Blend"
    toJSON LatinAmericaCaribbeanValueEnum = "Latin America & Caribbean "
    toJSON SubSaharanAfricaValueEnum = "Sub-Saharan Africa "
    toJSON EuropeCentralAsiaValueEnum = "Europe & Central Asia"
    toJSON MiddleEastNorthAfricaValueEnum = "Middle East & North Africa"
    toJSON EastAsiaPacificValueEnum = "East Asia & Pacific"
    toJSON NorthAmericaValueEnum = "North America"

instance FromJSON ValueEnum where
    parseJSON = withText "ValueEnum" parseText
        where
            parseText "" = return PurpleValueEnum
            parseText "South Asia" = return SouthAsiaValueEnum
            parseText "Sub-Saharan Africa (excluding high income)" = return SubSaharanAfricaExcludingHighIncomeValueEnum
            parseText "Europe & Central Asia (excluding high income)" = return EuropeCentralAsiaExcludingHighIncomeValueEnum
            parseText "Latin America & Caribbean (excluding high income)" = return LatinAmericaCaribbeanExcludingHighIncomeValueEnum
            parseText "East Asia & Pacific (excluding high income)" = return EastAsiaPacificExcludingHighIncomeValueEnum
            parseText "Middle East & North Africa (excluding high income)" = return MiddleEastNorthAfricaExcludingHighIncomeValueEnum
            parseText "High income" = return HighIncomeValueEnum
            parseText "Low income" = return LowIncomeValueEnum
            parseText "Aggregates" = return AggregatesValueEnum
            parseText "Lower middle income" = return LowerMiddleIncomeValueEnum
            parseText "Upper middle income" = return UpperMiddleIncomeValueEnum
            parseText "Not classified" = return NotClassifiedValueEnum
            parseText "IDA" = return IDAValueEnum
            parseText "IBRD" = return IBRDValueEnum
            parseText "Blend" = return BlendValueEnum
            parseText "Latin America & Caribbean " = return LatinAmericaCaribbeanValueEnum
            parseText "Sub-Saharan Africa " = return SubSaharanAfricaValueEnum
            parseText "Europe & Central Asia" = return EuropeCentralAsiaValueEnum
            parseText "Middle East & North Africa" = return MiddleEastNorthAfricaValueEnum
            parseText "East Asia & Pacific" = return EastAsiaPacificValueEnum
            parseText "North America" = return NorthAmericaValueEnum

instance ToJSON FluffyQuickType where
    toJSON (FluffyQuickType pageFluffyQuickType pagesFluffyQuickType perPageFluffyQuickType totalFluffyQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "page" .= pageFluffyQuickType
        , Just $ "pages" .= pagesFluffyQuickType
        , Just $ "per_page" .= perPageFluffyQuickType
        , Just $ "total" .= totalFluffyQuickType
        ]

instance FromJSON FluffyQuickType where
    parseJSON (Object v) = FluffyQuickType
        <$> v .: "page"
        <*> v .: "pages"
        <*> v .: "per_page"
        <*> v .: "total"
