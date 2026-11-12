{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Option (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { optionsQuickType :: [Option]
    } deriving (Show)

data Option = Option
    { fooOption :: Maybe Text
    , nameOption :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType optionsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "options" .= optionsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "options"

instance ToJSON Option where
    toJSON (Option fooOption nameOption) =
        object $ foldMap (maybe [] pure)
        [ ("foo" .=) <$> fooOption
        , Just $ "name" .= nameOption
        ]

instance FromJSON Option where
    parseJSON (Object v) = Option
        <$> v .:! "foo"
        <*> v .: "name"
