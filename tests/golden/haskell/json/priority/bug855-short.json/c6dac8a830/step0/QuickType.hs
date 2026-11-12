{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeValue (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = HashMap Text QuickTypeValue

data QuickTypeValue = QuickTypeValue
    { channelIDQuickTypeValue :: Text
    , channelNameQuickTypeValue :: Text
    , codeQuickTypeValue :: Text
    , emoticonSetQuickTypeValue :: Int
    , quickTypeIDQuickTypeValue :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeValue where
    toJSON (QuickTypeValue channelIDQuickTypeValue channelNameQuickTypeValue codeQuickTypeValue emoticonSetQuickTypeValue quickTypeIDQuickTypeValue) =
        object $ foldMap (maybe [] pure)
        [ Just $ "channel_id" .= channelIDQuickTypeValue
        , Just $ "channel_name" .= channelNameQuickTypeValue
        , Just $ "code" .= codeQuickTypeValue
        , Just $ "emoticon_set" .= emoticonSetQuickTypeValue
        , Just $ "id" .= quickTypeIDQuickTypeValue
        ]

instance FromJSON QuickTypeValue where
    parseJSON (Object v) = QuickTypeValue
        <$> v .: "channel_id"
        <*> v .: "channel_name"
        <*> v .: "code"
        <*> v .: "emoticon_set"
        <*> v .: "id"
