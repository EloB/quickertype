{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { aboveI32MaxQuickType :: Int
    , belowI32MinQuickType :: Int
    , i32RangeQuickType :: Int
    , largeBoundsQuickType :: Int
    , onlyMaximumQuickType :: Int
    , onlyMinimumQuickType :: Int
    , smallNegativeQuickType :: Int
    , smallPositiveQuickType :: Int
    , unboundedQuickType :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType aboveI32MaxQuickType belowI32MinQuickType i32RangeQuickType largeBoundsQuickType onlyMaximumQuickType onlyMinimumQuickType smallNegativeQuickType smallPositiveQuickType unboundedQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "above_i32_max" .= aboveI32MaxQuickType
        , Just $ "below_i32_min" .= belowI32MinQuickType
        , Just $ "i32_range" .= i32RangeQuickType
        , Just $ "large_bounds" .= largeBoundsQuickType
        , Just $ "only_maximum" .= onlyMaximumQuickType
        , Just $ "only_minimum" .= onlyMinimumQuickType
        , Just $ "small_negative" .= smallNegativeQuickType
        , Just $ "small_positive" .= smallPositiveQuickType
        , Just $ "unbounded" .= unboundedQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "above_i32_max"
        <*> v .: "below_i32_min"
        <*> v .: "i32_range"
        <*> v .: "large_bounds"
        <*> v .: "only_maximum"
        <*> v .: "only_minimum"
        <*> v .: "small_negative"
        <*> v .: "small_positive"
        <*> v .: "unbounded"
