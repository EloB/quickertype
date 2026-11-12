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
    { longitudeQuickType :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType longitudeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "longitude" .= longitudeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "longitude"
