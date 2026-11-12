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
    { barQuickType :: Int
    , fooQuickType :: Int
    , quuxQuickType :: Bool
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType barQuickType fooQuickType quuxQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bar" .= barQuickType
        , Just $ "foo" .= fooQuickType
        , Just $ "quux" .= quuxQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "bar"
        <*> v .: "foo"
        <*> v .: "quux"
