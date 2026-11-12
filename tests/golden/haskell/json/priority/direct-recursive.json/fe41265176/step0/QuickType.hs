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
    { alsoQuickType :: Maybe QuickType
    , barQuickType :: Bool
    , fooQuickType :: Int
    , mooQuickType :: Double
    , quuxQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType alsoQuickType barQuickType fooQuickType mooQuickType quuxQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("also" .=) <$> alsoQuickType
        , Just $ "bar" .= barQuickType
        , Just $ "foo" .= fooQuickType
        , Just $ "moo" .= mooQuickType
        , Just $ "quux" .= quuxQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "also"
        <*> v .: "bar"
        <*> v .: "foo"
        <*> v .: "moo"
        <*> v .: "quux"
