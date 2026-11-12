{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , MapValue (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { mapQuickType :: Maybe (HashMap Text MapValue)
    } deriving (Show)

data MapValue
    = BoolInMapValue Bool
    | DoubleInMapValue Double
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType mapQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("map" .=) <$> mapQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "map"

instance ToJSON MapValue where
    toJSON (BoolInMapValue x) = toJSON x
    toJSON (DoubleInMapValue x) = toJSON x

instance FromJSON MapValue where
    parseJSON xs@(Bool _) = (fmap BoolInMapValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInMapValue . parseJSON) xs
