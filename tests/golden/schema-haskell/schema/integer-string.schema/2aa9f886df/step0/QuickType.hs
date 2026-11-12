{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , UnionWithInt (..)
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
    , unionWithIntQuickType :: UnionWithInt
    , unionWithIntAndEnumQuickType :: UnionWithInt
    } deriving (Show)

data UnionWithInt
    = IntegerInUnionWithInt Int
    | StringInUnionWithInt Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType arrNullableQuickType arrOneQuickType nullableQuickType oneQuickType optionalQuickType unionWithIntQuickType unionWithIntAndEnumQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("arrNullable" .=) <$> arrNullableQuickType
        , ("arrOne" .=) <$> arrOneQuickType
        , Just $ "nullable" .= nullableQuickType
        , Just $ "one" .= oneQuickType
        , ("optional" .=) <$> optionalQuickType
        , Just $ "unionWithInt" .= unionWithIntQuickType
        , Just $ "unionWithIntAndEnum" .= unionWithIntAndEnumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "arrNullable"
        <*> v .:! "arrOne"
        <*> v .: "nullable"
        <*> v .: "one"
        <*> v .:! "optional"
        <*> v .: "unionWithInt"
        <*> v .: "unionWithIntAndEnum"

instance ToJSON UnionWithInt where
    toJSON (IntegerInUnionWithInt x) = toJSON x
    toJSON (StringInUnionWithInt x) = toJSON x

instance FromJSON UnionWithInt where
    parseJSON xs@(Number _) = (fmap IntegerInUnionWithInt . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnionWithInt . parseJSON) xs
