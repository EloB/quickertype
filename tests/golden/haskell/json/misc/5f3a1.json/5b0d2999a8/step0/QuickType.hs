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
    { baseQuickType :: Text
    , dateQuickType :: Text
    , ratesQuickType :: HashMap Text Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType baseQuickType dateQuickType ratesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "base" .= baseQuickType
        , Just $ "date" .= dateQuickType
        , Just $ "rates" .= ratesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "base"
        <*> v .: "date"
        <*> v .: "rates"
