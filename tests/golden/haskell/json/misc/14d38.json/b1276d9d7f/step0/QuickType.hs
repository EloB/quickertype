{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Headers (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { headersQuickType :: Headers
    } deriving (Show)

data Headers = Headers
    { acceptEncodingHeaders :: Text
    , connectionHeaders :: Text
    , hostHeaders :: Text
    , userAgentHeaders :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType headersQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "headers" .= headersQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "headers"

instance ToJSON Headers where
    toJSON (Headers acceptEncodingHeaders connectionHeaders hostHeaders userAgentHeaders) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Accept-Encoding" .= acceptEncodingHeaders
        , Just $ "Connection" .= connectionHeaders
        , Just $ "Host" .= hostHeaders
        , Just $ "User-Agent" .= userAgentHeaders
        ]

instance FromJSON Headers where
    parseJSON (Object v) = Headers
        <$> v .: "Accept-Encoding"
        <*> v .: "Connection"
        <*> v .: "Host"
        <*> v .: "User-Agent"
