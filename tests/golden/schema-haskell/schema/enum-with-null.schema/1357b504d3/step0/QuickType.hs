{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , EnumEnum (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { enumQuickType :: Maybe EnumEnum
    } deriving (Show)

data EnumEnum
    = FooEnumEnum
    | BarEnumEnum
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType enumQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "enum" .= enumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "enum"

instance ToJSON EnumEnum where
    toJSON FooEnumEnum = "foo"
    toJSON BarEnumEnum = "bar"

instance FromJSON EnumEnum where
    parseJSON = withText "EnumEnum" parseText
        where
            parseText "foo" = return FooEnumEnum
            parseText "bar" = return BarEnumEnum
