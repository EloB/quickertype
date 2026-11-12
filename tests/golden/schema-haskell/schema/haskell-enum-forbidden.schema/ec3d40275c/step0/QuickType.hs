{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Health (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { healthQuickType :: Health
    } deriving (Show)

data Health
    = OkHealth
    | ErrorHealth
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType healthQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "health" .= healthQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "health"

instance ToJSON Health where
    toJSON OkHealth = "ok"
    toJSON ErrorHealth = "error"

instance FromJSON Health where
    parseJSON = withText "Health" parseText
        where
            parseText "ok" = return OkHealth
            parseText "error" = return ErrorHealth
