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
    { freeQuickType :: Double
    , intersectionQuickType :: Double
    , maxQuickType :: Double
    , minQuickType :: Double
    , minmaxQuickType :: Double
    , minMaxIntersectionQuickType :: Double
    , minMaxUnionQuickType :: Double
    , unionQuickType :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType freeQuickType intersectionQuickType maxQuickType minQuickType minmaxQuickType minMaxIntersectionQuickType minMaxUnionQuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "free" .= freeQuickType
        , Just $ "intersection" .= intersectionQuickType
        , Just $ "max" .= maxQuickType
        , Just $ "min" .= minQuickType
        , Just $ "minmax" .= minmaxQuickType
        , Just $ "minMaxIntersection" .= minMaxIntersectionQuickType
        , Just $ "minMaxUnion" .= minMaxUnionQuickType
        , Just $ "union" .= unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "free"
        <*> v .: "intersection"
        <*> v .: "max"
        <*> v .: "min"
        <*> v .: "minmax"
        <*> v .: "minMaxIntersection"
        <*> v .: "minMaxUnion"
        <*> v .: "union"
