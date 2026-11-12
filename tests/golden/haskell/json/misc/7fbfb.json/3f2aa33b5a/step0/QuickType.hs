{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , PurpleQuickType (..)
    , Country (..)
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
    { countryPurpleQuickType :: Country
    , datePurpleQuickType :: Text
    , decimalPurpleQuickType :: Text
    , indicatorPurpleQuickType :: Country
    , valuePurpleQuickType :: Text
    } deriving (Show)

data Country = Country
    { countryIDCountry :: ID
    , valueCountry :: ValueEnum
    } deriving (Show)

data ID
    = CNID
    | NyGdpMktpCDID
    deriving (Show)

data ValueEnum
    = ChinaValueEnum
    | GDPCurrentUSValueEnum
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
    toJSON (PurpleQuickType countryPurpleQuickType datePurpleQuickType decimalPurpleQuickType indicatorPurpleQuickType valuePurpleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "country" .= countryPurpleQuickType
        , Just $ "date" .= datePurpleQuickType
        , Just $ "decimal" .= decimalPurpleQuickType
        , Just $ "indicator" .= indicatorPurpleQuickType
        , Just $ "value" .= valuePurpleQuickType
        ]

instance FromJSON PurpleQuickType where
    parseJSON (Object v) = PurpleQuickType
        <$> v .: "country"
        <*> v .: "date"
        <*> v .: "decimal"
        <*> v .: "indicator"
        <*> v .: "value"

instance ToJSON Country where
    toJSON (Country countryIDCountry valueCountry) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= countryIDCountry
        , Just $ "value" .= valueCountry
        ]

instance FromJSON Country where
    parseJSON (Object v) = Country
        <$> v .: "id"
        <*> v .: "value"

instance ToJSON ID where
    toJSON CNID = "CN"
    toJSON NyGdpMktpCDID = "NY.GDP.MKTP.CD"

instance FromJSON ID where
    parseJSON = withText "ID" parseText
        where
            parseText "CN" = return CNID
            parseText "NY.GDP.MKTP.CD" = return NyGdpMktpCDID

instance ToJSON ValueEnum where
    toJSON ChinaValueEnum = "China"
    toJSON GDPCurrentUSValueEnum = "GDP (current US$)"

instance FromJSON ValueEnum where
    parseJSON = withText "ValueEnum" parseText
        where
            parseText "China" = return ChinaValueEnum
            parseText "GDP (current US$)" = return GDPCurrentUSValueEnum

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
