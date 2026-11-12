{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Config (..)
    , ClosedClass (..)
    , Item (..)
    , Closed (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { configQuickType :: Maybe Config
    } deriving (Show)

data Config = Config
    { closedConfig :: Maybe Closed
    , nameConfig :: Maybe Text
    , settingsConfig :: Maybe (HashMap Text ([Item]))
    } deriving (Show)

data Closed
    = AnythingArrayInClosed ([Value])
    | BoolInClosed Bool
    | ClosedClassInClosed ClosedClass
    | DoubleInClosed Double
    | IntegerInClosed Int
    | NullInClosed
    | StringInClosed Text
    deriving (Show)

data ClosedClass = ClosedClass
    {
    } deriving (Show)

data Item = Item
    { keyItem :: Text
    , valueItem :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType configQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("config" .=) <$> configQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "config"

instance ToJSON Config where
    toJSON (Config closedConfig nameConfig settingsConfig) =
        object $ foldMap (maybe [] pure)
        [ ("closed" .=) <$> closedConfig
        , ("name" .=) <$> nameConfig
        , ("settings" .=) <$> settingsConfig
        ]

instance FromJSON Config where
    parseJSON (Object v) = Config
        <$> v .:! "closed"
        <*> v .:! "name"
        <*> v .:! "settings"

instance ToJSON Closed where
    toJSON (AnythingArrayInClosed x) = toJSON x
    toJSON (BoolInClosed x) = toJSON x
    toJSON (ClosedClassInClosed x) = toJSON x
    toJSON (DoubleInClosed x) = toJSON x
    toJSON (IntegerInClosed x) = toJSON x
    toJSON NullInClosed = Null
    toJSON (StringInClosed x) = toJSON x

instance FromJSON Closed where
    parseJSON xs@(Array _) = (fmap AnythingArrayInClosed . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInClosed . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ClosedClassInClosed . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInClosed . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInClosed . parseJSON) xs
    parseJSON Null = return NullInClosed
    parseJSON xs@(String _) = (fmap StringInClosed . parseJSON) xs

instance ToJSON ClosedClass where
    toJSON = \_ -> emptyObject

instance FromJSON ClosedClass where
    parseJSON (Object _) = return ClosedClass

instance ToJSON Item where
    toJSON (Item keyItem valueItem) =
        object $ foldMap (maybe [] pure)
        [ Just $ "key" .= keyItem
        , Just $ "value" .= valueItem
        ]

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .: "key"
        <*> v .: "value"
