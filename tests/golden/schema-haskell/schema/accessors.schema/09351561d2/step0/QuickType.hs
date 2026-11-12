{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , EnumEnum (..)
    , Union (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { barreQuickType :: Text
    , enumerificationQuickType :: EnumEnum
    , fooQuickType :: Text
    , unionizationQuickType :: Union
    } deriving (Show)

data EnumEnum
    = FireEnumEnum
    | GrassEnumEnum
    | BlueEnumEnum
    deriving (Show)

data Union
    = Amount Double
    | Presence Bool
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType barreQuickType enumerificationQuickType fooQuickType unionizationQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bar" .= barreQuickType
        , Just $ "enum" .= enumerificationQuickType
        , Just $ "foo" .= fooQuickType
        , Just $ "union" .= unionizationQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "bar"
        <*> v .: "enum"
        <*> v .: "foo"
        <*> v .: "union"

instance ToJSON EnumEnum where
    toJSON FireEnumEnum = "red"
    toJSON GrassEnumEnum = "green"
    toJSON BlueEnumEnum = "blue"

instance FromJSON EnumEnum where
    parseJSON = withText "EnumEnum" parseText
        where
            parseText "red" = return FireEnumEnum
            parseText "green" = return GrassEnumEnum
            parseText "blue" = return BlueEnumEnum

instance ToJSON Union where
    toJSON (Amount x) = toJSON x
    toJSON (Presence x) = toJSON x

instance FromJSON Union where
    parseJSON xs@(Number _) = (fmap Amount . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap Presence . parseJSON) xs
