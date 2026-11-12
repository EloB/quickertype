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

{-| Nested block comment openers:
{ -
/*
This text must remain inside the generated documentation comment.

value:
Nested property block comment openers:
{ -
/*
This text must remain inside the generated property documentation comment.
-}
data QuickType = QuickType
    { valueQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType valueQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "value" .= valueQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "value"
