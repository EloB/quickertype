{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
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
    , unionWithEnumQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType arrNullableQuickType arrOneQuickType nullableQuickType oneQuickType optionalQuickType unionWithEnumQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("arrNullable" .=) <$> arrNullableQuickType
        , ("arrOne" .=) <$> arrOneQuickType
        , Just $ "nullable" .= nullableQuickType
        , Just $ "one" .= oneQuickType
        , ("optional" .=) <$> optionalQuickType
        , Just $ "unionWithEnum" .= unionWithEnumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "arrNullable"
        <*> v .:! "arrOne"
        <*> v .: "nullable"
        <*> v .: "one"
        <*> v .:! "optional"
        <*> v .: "unionWithEnum"
