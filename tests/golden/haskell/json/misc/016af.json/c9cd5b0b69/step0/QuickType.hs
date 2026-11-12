{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , TotalPopulation (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { totalPopulationQuickType :: [TotalPopulation]
    } deriving (Show)

data TotalPopulation = TotalPopulation
    { dateTotalPopulation :: Text
    , populationTotalPopulation :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType totalPopulationQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "total_population" .= totalPopulationQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "total_population"

instance ToJSON TotalPopulation where
    toJSON (TotalPopulation dateTotalPopulation populationTotalPopulation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date" .= dateTotalPopulation
        , Just $ "population" .= populationTotalPopulation
        ]

instance FromJSON TotalPopulation where
    parseJSON (Object v) = TotalPopulation
        <$> v .: "date"
        <*> v .: "population"
