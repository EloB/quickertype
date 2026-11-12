{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Response (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { responseQuickType :: Response
    } deriving (Show)

data Response = Response
    { playerCountResponse :: Int
    , resultResponse :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType responseQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "response" .= responseQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "response"

instance ToJSON Response where
    toJSON (Response playerCountResponse resultResponse) =
        object $ foldMap (maybe [] pure)
        [ Just $ "player_count" .= playerCountResponse
        , Just $ "result" .= resultResponse
        ]

instance FromJSON Response where
    parseJSON (Object v) = Response
        <$> v .: "player_count"
        <*> v .: "result"
