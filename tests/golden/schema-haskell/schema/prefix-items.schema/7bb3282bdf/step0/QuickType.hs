{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Open (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { openQuickType :: [Open]
    , tupleQuickType :: [Open]
    } deriving (Show)

data Open
    = BoolInOpen Bool
    | IntegerInOpen Int
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType openQuickType tupleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "open" .= openQuickType
        , Just $ "tuple" .= tupleQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "open"
        <*> v .: "tuple"

instance ToJSON Open where
    toJSON (BoolInOpen x) = toJSON x
    toJSON (IntegerInOpen x) = toJSON x

instance FromJSON Open where
    parseJSON xs@(Bool _) = (fmap BoolInOpen . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInOpen . parseJSON) xs
