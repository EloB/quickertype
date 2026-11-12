{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Country (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { ageQuickTypeElement :: Int
    , countryQuickTypeElement :: Country
    , femalesQuickTypeElement :: Int
    , malesQuickTypeElement :: Int
    , totalQuickTypeElement :: Int
    , yearQuickTypeElement :: Int
    } deriving (Show)

data Country
    = UnitedStatesCountry
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement ageQuickTypeElement countryQuickTypeElement femalesQuickTypeElement malesQuickTypeElement totalQuickTypeElement yearQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "age" .= ageQuickTypeElement
        , Just $ "country" .= countryQuickTypeElement
        , Just $ "females" .= femalesQuickTypeElement
        , Just $ "males" .= malesQuickTypeElement
        , Just $ "total" .= totalQuickTypeElement
        , Just $ "year" .= yearQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "age"
        <*> v .: "country"
        <*> v .: "females"
        <*> v .: "males"
        <*> v .: "total"
        <*> v .: "year"

instance ToJSON Country where
    toJSON UnitedStatesCountry = "United States"

instance FromJSON Country where
    parseJSON = withText "Country" parseText
        where
            parseText "United States" = return UnitedStatesCountry
