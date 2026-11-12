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
    { blockIndexQuickType :: Int
    , hashQuickType :: Text
    , heightQuickType :: Int
    , timeQuickType :: Int
    , txIndexesQuickType :: [Int]
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType blockIndexQuickType hashQuickType heightQuickType timeQuickType txIndexesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "block_index" .= blockIndexQuickType
        , Just $ "hash" .= hashQuickType
        , Just $ "height" .= heightQuickType
        , Just $ "time" .= timeQuickType
        , Just $ "txIndexes" .= txIndexesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "block_index"
        <*> v .: "hash"
        <*> v .: "height"
        <*> v .: "time"
        <*> v .: "txIndexes"
