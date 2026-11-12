{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Kind (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { bQuickType :: Maybe (Maybe Text)
    , kindQuickType :: Kind
    } deriving (Show)

data Kind
    = OneKind
    | TwoKind
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType bQuickType kindQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("b" .=) <$> bQuickType
        , Just $ "kind" .= kindQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "b"
        <*> v .: "kind"

instance ToJSON Kind where
    toJSON OneKind = "one"
    toJSON TwoKind = "two"

instance FromJSON Kind where
    parseJSON = withText "Kind" parseText
        where
            parseText "one" = return OneKind
            parseText "two" = return TwoKind
