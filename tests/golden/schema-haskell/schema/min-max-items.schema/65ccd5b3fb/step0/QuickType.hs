{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , UnionItem (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { maxOnlyQuickType :: [Int]
    , minAndMaxQuickType :: [Double]
    , minOnlyQuickType :: [Text]
    , plainQuickType :: [Text]
    , unionItemsQuickType :: [UnionItem]
    } deriving (Show)

data UnionItem
    = IntegerInUnionItem Int
    | StringInUnionItem Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType maxOnlyQuickType minAndMaxQuickType minOnlyQuickType plainQuickType unionItemsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "maxOnly" .= maxOnlyQuickType
        , Just $ "minAndMax" .= minAndMaxQuickType
        , Just $ "minOnly" .= minOnlyQuickType
        , Just $ "plain" .= plainQuickType
        , Just $ "unionItems" .= unionItemsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "maxOnly"
        <*> v .: "minAndMax"
        <*> v .: "minOnly"
        <*> v .: "plain"
        <*> v .: "unionItems"

instance ToJSON UnionItem where
    toJSON (IntegerInUnionItem x) = toJSON x
    toJSON (StringInUnionItem x) = toJSON x

instance FromJSON UnionItem where
    parseJSON xs@(Number _) = (fmap IntegerInUnionItem . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnionItem . parseJSON) xs
