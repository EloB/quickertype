{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Pair (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { pairsQuickType :: HashMap Text Pair
    , serverTimeQuickType :: Int
    } deriving (Show)

data Pair = Pair
    { decimalPlacesPair :: Int
    , feePair :: Double
    , hiddenPair :: Int
    , maxAmountPair :: Int
    , maxPricePair :: Int
    , minAmountPair :: Double
    , minPricePair :: Double
    , minTotalPair :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType pairsQuickType serverTimeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pairs" .= pairsQuickType
        , Just $ "server_time" .= serverTimeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "pairs"
        <*> v .: "server_time"

instance ToJSON Pair where
    toJSON (Pair decimalPlacesPair feePair hiddenPair maxAmountPair maxPricePair minAmountPair minPricePair minTotalPair) =
        object $ foldMap (maybe [] pure)
        [ Just $ "decimal_places" .= decimalPlacesPair
        , Just $ "fee" .= feePair
        , Just $ "hidden" .= hiddenPair
        , Just $ "max_amount" .= maxAmountPair
        , Just $ "max_price" .= maxPricePair
        , Just $ "min_amount" .= minAmountPair
        , Just $ "min_price" .= minPricePair
        , Just $ "min_total" .= minTotalPair
        ]

instance FromJSON Pair where
    parseJSON (Object v) = Pair
        <$> v .: "decimal_places"
        <*> v .: "fee"
        <*> v .: "hidden"
        <*> v .: "max_amount"
        <*> v .: "max_price"
        <*> v .: "min_amount"
        <*> v .: "min_price"
        <*> v .: "min_total"
