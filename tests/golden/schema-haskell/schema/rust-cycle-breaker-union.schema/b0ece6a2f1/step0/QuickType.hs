{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Node (..)
    , Next (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { nextQuickType :: Maybe Next
    , valueQuickType :: Text
    } deriving (Show)

data Node = Node
    { nextNode :: Maybe Next
    , valueNode :: Text
    } deriving (Show)

data Next
    = NodeInNext Node
    | NullInNext
    | StringInNext Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType nextQuickType valueQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("next" .=) <$> nextQuickType
        , Just $ "value" .= valueQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "next"
        <*> v .: "value"

instance ToJSON Node where
    toJSON (Node nextNode valueNode) =
        object $ foldMap (maybe [] pure)
        [ ("next" .=) <$> nextNode
        , Just $ "value" .= valueNode
        ]

instance FromJSON Node where
    parseJSON (Object v) = Node
        <$> v .:! "next"
        <*> v .: "value"

instance ToJSON Next where
    toJSON (NodeInNext x) = toJSON x
    toJSON NullInNext = Null
    toJSON (StringInNext x) = toJSON x

instance FromJSON Next where
    parseJSON xs@(Object _) = (fmap NodeInNext . parseJSON) xs
    parseJSON Null = return NullInNext
    parseJSON xs@(String _) = (fmap StringInNext . parseJSON) xs
