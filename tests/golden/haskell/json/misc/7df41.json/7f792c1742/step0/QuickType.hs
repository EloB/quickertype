{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , PC (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { pcQuickType :: PC
    , ps3QuickType :: PC
    , ps4QuickType :: PC
    , xboxQuickType :: PC
    , xoneQuickType :: PC
    } deriving (Show)

data PC = PC
    { countPC :: Int
    , labelPC :: Text
    , peak24PC :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType pcQuickType ps3QuickType ps4QuickType xboxQuickType xoneQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pc" .= pcQuickType
        , Just $ "ps3" .= ps3QuickType
        , Just $ "ps4" .= ps4QuickType
        , Just $ "xbox" .= xboxQuickType
        , Just $ "xone" .= xoneQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "pc"
        <*> v .: "ps3"
        <*> v .: "ps4"
        <*> v .: "xbox"
        <*> v .: "xone"

instance ToJSON PC where
    toJSON (PC countPC labelPC peak24PC) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countPC
        , Just $ "label" .= labelPC
        , Just $ "peak24" .= peak24PC
        ]

instance FromJSON PC where
    parseJSON (Object v) = PC
        <$> v .: "count"
        <*> v .: "label"
        <*> v .: "peak24"
