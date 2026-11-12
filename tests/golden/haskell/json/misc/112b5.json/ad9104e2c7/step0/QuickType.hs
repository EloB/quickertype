{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Args (..)
    , Headers (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { argsQuickType :: Args
    , headersQuickType :: Headers
    , originQuickType :: Text
    , urlQuickType :: Text
    } deriving (Show)

data Args = Args
    {
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
    toJSON (QuickType argsQuickType headersQuickType originQuickType urlQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "args" .= argsQuickType
        , Just $ "headers" .= headersQuickType
        , Just $ "origin" .= originQuickType
        , Just $ "url" .= urlQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "args"
        <*> v .: "headers"
        <*> v .: "origin"
        <*> v .: "url"

instance ToJSON Args where
    toJSON = \_ -> emptyObject

instance FromJSON Args where
    parseJSON (Object _) = return Args

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
