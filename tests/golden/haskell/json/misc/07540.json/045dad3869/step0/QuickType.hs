{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Cookies (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { cookiesQuickType :: Cookies
    } deriving (Show)

data Cookies = Cookies
    {
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

instance ToJSON Cookies where
    toJSON = \_ -> emptyObject

instance FromJSON Cookies where
    parseJSON (Object _) = return Cookies
