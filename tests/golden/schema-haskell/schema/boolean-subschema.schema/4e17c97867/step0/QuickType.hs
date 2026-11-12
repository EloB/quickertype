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
    { disallowedQuickType :: Maybe Value
    , emptyQuickType :: [Value]
    , fooQuickType :: Text
    , impossibleQuickType :: Maybe Value
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType disallowedQuickType emptyQuickType fooQuickType impossibleQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("disallowed" .=) <$> disallowedQuickType
        , Just $ "empty" .= emptyQuickType
        , Just $ "foo" .= fooQuickType
        , ("impossible" .=) <$> impossibleQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "disallowed"
        <*> v .: "empty"
        <*> v .: "foo"
        <*> v .:! "impossible"
