{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ValueUnion (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { valueQuickType :: ValueUnion
    } deriving (Show)

data ValueUnion
    = DoubleInValueUnion Double
    | IntegerInValueUnion Int
    | StringInValueUnion Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType valueQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "value" .= valueQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "value"

instance ToJSON ValueUnion where
    toJSON (DoubleInValueUnion x) = toJSON x
    toJSON (IntegerInValueUnion x) = toJSON x
    toJSON (StringInValueUnion x) = toJSON x

instance FromJSON ValueUnion where
    parseJSON xs@(Number _) = (fmap DoubleInValueUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInValueUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInValueUnion . parseJSON) xs
