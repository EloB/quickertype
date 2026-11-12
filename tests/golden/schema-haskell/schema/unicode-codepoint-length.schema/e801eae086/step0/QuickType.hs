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
    { exactQuickType :: Text
    , maximumQuickType :: Text
    , minimumQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType exactQuickType maximumQuickType minimumQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "exact" .= exactQuickType
        , Just $ "maximum" .= maximumQuickType
        , Just $ "minimum" .= minimumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "exact"
        <*> v .: "maximum"
        <*> v .: "minimum"
