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
    { fooQuickType :: Int
    , barQuickType :: Bool
    , quuxQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType fooQuickType barQuickType quuxQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foo" .= fooQuickType
        , Just $ "bar" .= barQuickType
        , Just $ "quux" .= quuxQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "foo"
        <*> v .: "bar"
        <*> v .: "quux"
