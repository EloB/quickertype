{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , NumberUnion (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { numberQuickType :: NumberUnion
    } deriving (Show)

data NumberUnion
    = DoubleInNumberUnion Double
    | IntegerInNumberUnion Int
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType numberQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "number" .= numberQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "number"

instance ToJSON NumberUnion where
    toJSON (DoubleInNumberUnion x) = toJSON x
    toJSON (IntegerInNumberUnion x) = toJSON x

instance FromJSON NumberUnion where
    parseJSON xs@(Number _) = (fmap DoubleInNumberUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInNumberUnion . parseJSON) xs
