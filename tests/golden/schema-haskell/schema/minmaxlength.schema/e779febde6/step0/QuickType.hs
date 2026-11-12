{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , InUnion (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { intersectionQuickType :: Text
    , inUnionQuickType :: InUnion
    , maxlengthQuickType :: Text
    , minlengthQuickType :: Text
    , minMaxIntersectionQuickType :: Text
    , minmaxlengthQuickType :: Text
    , minMaxUnionQuickType :: Text
    , unionQuickType :: Text
    } deriving (Show)

data InUnion
    = DoubleInInUnion Double
    | StringInInUnion Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType intersectionQuickType inUnionQuickType maxlengthQuickType minlengthQuickType minMaxIntersectionQuickType minmaxlengthQuickType minMaxUnionQuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "intersection" .= intersectionQuickType
        , Just $ "inUnion" .= inUnionQuickType
        , Just $ "maxlength" .= maxlengthQuickType
        , Just $ "minlength" .= minlengthQuickType
        , Just $ "minMaxIntersection" .= minMaxIntersectionQuickType
        , Just $ "minmaxlength" .= minmaxlengthQuickType
        , Just $ "minMaxUnion" .= minMaxUnionQuickType
        , Just $ "union" .= unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "intersection"
        <*> v .: "inUnion"
        <*> v .: "maxlength"
        <*> v .: "minlength"
        <*> v .: "minMaxIntersection"
        <*> v .: "minmaxlength"
        <*> v .: "minMaxUnion"
        <*> v .: "union"

instance ToJSON InUnion where
    toJSON (DoubleInInUnion x) = toJSON x
    toJSON (StringInInUnion x) = toJSON x

instance FromJSON InUnion where
    parseJSON xs@(Number _) = (fmap DoubleInInUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInInUnion . parseJSON) xs
