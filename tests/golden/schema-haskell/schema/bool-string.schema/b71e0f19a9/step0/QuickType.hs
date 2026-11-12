{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , UnionWithBool (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { arrNullableQuickType :: Maybe ([(Maybe Text)])
    , arrOneQuickType :: Maybe ([Text])
    , nullableQuickType :: Maybe Text
    , oneQuickType :: Text
    , optionalQuickType :: Maybe Text
    , unionWithBoolQuickType :: UnionWithBool
    , unionWithBoolAndEnumQuickType :: UnionWithBool
    } deriving (Show)

data UnionWithBool
    = BoolInUnionWithBool Bool
    | StringInUnionWithBool Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType arrNullableQuickType arrOneQuickType nullableQuickType oneQuickType optionalQuickType unionWithBoolQuickType unionWithBoolAndEnumQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("arrNullable" .=) <$> arrNullableQuickType
        , ("arrOne" .=) <$> arrOneQuickType
        , Just $ "nullable" .= nullableQuickType
        , Just $ "one" .= oneQuickType
        , ("optional" .=) <$> optionalQuickType
        , Just $ "unionWithBool" .= unionWithBoolQuickType
        , Just $ "unionWithBoolAndEnum" .= unionWithBoolAndEnumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "arrNullable"
        <*> v .:! "arrOne"
        <*> v .: "nullable"
        <*> v .: "one"
        <*> v .:! "optional"
        <*> v .: "unionWithBool"
        <*> v .: "unionWithBoolAndEnum"

instance ToJSON UnionWithBool where
    toJSON (BoolInUnionWithBool x) = toJSON x
    toJSON (StringInUnionWithBool x) = toJSON x

instance FromJSON UnionWithBool where
    parseJSON xs@(Bool _) = (fmap BoolInUnionWithBool . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnionWithBool . parseJSON) xs
