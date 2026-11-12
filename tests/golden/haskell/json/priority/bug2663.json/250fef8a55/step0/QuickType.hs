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
    { birthdayQuickType :: Text
    , lastSeenQuickType :: Text
    , nameQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType birthdayQuickType lastSeenQuickType nameQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "birthday" .= birthdayQuickType
        , Just $ "lastSeen" .= lastSeenQuickType
        , Just $ "name" .= nameQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "birthday"
        <*> v .: "lastSeen"
        <*> v .: "name"
