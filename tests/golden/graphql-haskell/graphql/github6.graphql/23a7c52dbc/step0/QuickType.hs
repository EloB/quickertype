{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , UniformResourceLocatable (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { quickTypeDataQuickType :: Maybe Data
    , errorsQuickType :: Maybe ([ErrorElement])
    } deriving (Show)

data ErrorElement = ErrorElement
    { messageErrorElement :: Text
    } deriving (Show)

data Data = Data
    { resourceData :: Maybe UniformResourceLocatable
    } deriving (Show)

data UniformResourceLocatable = UniformResourceLocatable
    { urlUniformResourceLocatable :: Text
    , loginUniformResourceLocatable :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType quickTypeDataQuickType errorsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= quickTypeDataQuickType
        , ("errors" .=) <$> errorsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "data"
        <*> v .:! "errors"

instance ToJSON ErrorElement where
    toJSON (ErrorElement messageErrorElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageErrorElement
        ]

instance FromJSON ErrorElement where
    parseJSON (Object v) = ErrorElement
        <$> v .: "message"

instance ToJSON Data where
    toJSON (Data resourceData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "resource" .= resourceData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .: "resource"

instance ToJSON UniformResourceLocatable where
    toJSON (UniformResourceLocatable urlUniformResourceLocatable loginUniformResourceLocatable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "url" .= urlUniformResourceLocatable
        , ("login" .=) <$> loginUniformResourceLocatable
        ]

instance FromJSON UniformResourceLocatable where
    parseJSON (Object v) = UniformResourceLocatable
        <$> v .: "url"
        <*> v .:! "login"
