{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , IssPosition (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { issPositionQuickType :: IssPosition
    , messageQuickType :: Text
    , timestampQuickType :: Int
    } deriving (Show)

data IssPosition = IssPosition
    { latitudeIssPosition :: Text
    , longitudeIssPosition :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType issPositionQuickType messageQuickType timestampQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "iss_position" .= issPositionQuickType
        , Just $ "message" .= messageQuickType
        , Just $ "timestamp" .= timestampQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "iss_position"
        <*> v .: "message"
        <*> v .: "timestamp"

instance ToJSON IssPosition where
    toJSON (IssPosition latitudeIssPosition longitudeIssPosition) =
        object $ foldMap (maybe [] pure)
        [ Just $ "latitude" .= latitudeIssPosition
        , Just $ "longitude" .= longitudeIssPosition
        ]

instance FromJSON IssPosition where
    parseJSON (Object v) = IssPosition
        <$> v .: "latitude"
        <*> v .: "longitude"
