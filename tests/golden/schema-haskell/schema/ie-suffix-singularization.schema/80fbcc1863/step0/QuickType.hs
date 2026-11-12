{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Cookie (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { cookiesQuickType :: [Cookie]
    } deriving (Show)

data Cookie = Cookie
    { nameCookie :: Text
    , valueCookie :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType cookiesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "cookies" .= cookiesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "cookies"

instance ToJSON Cookie where
    toJSON (Cookie nameCookie valueCookie) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameCookie
        , Just $ "value" .= valueCookie
        ]

instance FromJSON Cookie where
    parseJSON (Object v) = Cookie
        <$> v .: "name"
        <*> v .: "value"
