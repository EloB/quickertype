{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Rate (..)
    , Period (..)
    , Rates (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { detailsQuickType :: Text
    , ratesQuickType :: [Rate]
    , versionQuickType :: Maybe Text
    } deriving (Show)

data Rate = Rate
    { codeRate :: Text
    , countryCodeRate :: Text
    , nameRate :: Text
    , periodsRate :: [Period]
    } deriving (Show)

data Period = Period
    { effectiveFromPeriod :: Text
    , ratesPeriod :: Rates
    } deriving (Show)

data Rates = Rates
    { parkingRates :: Maybe Double
    , reducedRates :: Maybe Double
    , reduced1Rates :: Maybe Double
    , reduced2Rates :: Maybe Double
    , standardRates :: Double
    , superReducedRates :: Maybe Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType detailsQuickType ratesQuickType versionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "details" .= detailsQuickType
        , Just $ "rates" .= ratesQuickType
        , Just $ "version" .= versionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "details"
        <*> v .: "rates"
        <*> v .: "version"

instance ToJSON Rate where
    toJSON (Rate codeRate countryCodeRate nameRate periodsRate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeRate
        , Just $ "country_code" .= countryCodeRate
        , Just $ "name" .= nameRate
        , Just $ "periods" .= periodsRate
        ]

instance FromJSON Rate where
    parseJSON (Object v) = Rate
        <$> v .: "code"
        <*> v .: "country_code"
        <*> v .: "name"
        <*> v .: "periods"

instance ToJSON Period where
    toJSON (Period effectiveFromPeriod ratesPeriod) =
        object $ foldMap (maybe [] pure)
        [ Just $ "effective_from" .= effectiveFromPeriod
        , Just $ "rates" .= ratesPeriod
        ]

instance FromJSON Period where
    parseJSON (Object v) = Period
        <$> v .: "effective_from"
        <*> v .: "rates"

instance ToJSON Rates where
    toJSON (Rates parkingRates reducedRates reduced1Rates reduced2Rates standardRates superReducedRates) =
        object $ foldMap (maybe [] pure)
        [ ("parking" .=) <$> parkingRates
        , ("reduced" .=) <$> reducedRates
        , ("reduced1" .=) <$> reduced1Rates
        , ("reduced2" .=) <$> reduced2Rates
        , Just $ "standard" .= standardRates
        , ("super_reduced" .=) <$> superReducedRates
        ]

instance FromJSON Rates where
    parseJSON (Object v) = Rates
        <$> v .:! "parking"
        <*> v .:! "reduced"
        <*> v .:! "reduced1"
        <*> v .:! "reduced2"
        <*> v .: "standard"
        <*> v .:! "super_reduced"
