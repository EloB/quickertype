{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Item (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { inputQuickType :: [Item]
    } deriving (Show)

data Item = Item
    { contentItem :: Maybe Text
    , itemIDItem :: Maybe Text
    , outputItem :: Maybe Text
    , summaryItem :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType inputQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "input" .= inputQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "input"

instance ToJSON Item where
    toJSON (Item contentItem itemIDItem outputItem summaryItem) =
        object $ foldMap (maybe [] pure)
        [ ("content" .=) <$> contentItem
        , ("id" .=) <$> itemIDItem
        , ("output" .=) <$> outputItem
        , ("summary" .=) <$> summaryItem
        ]

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .:! "content"
        <*> v .:! "id"
        <*> v .:! "output"
        <*> v .:! "summary"
