{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Description (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { descriptionQuickType :: Description
    , quickTypeDataQuickType :: HashMap Text Text
    } deriving (Show)

data Description = Description
    { basePeriodDescription :: Text
    , missingDescription :: Text
    , titleDescription :: Text
    , unitsDescription :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType descriptionQuickType quickTypeDataQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionQuickType
        , Just $ "data" .= quickTypeDataQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "description"
        <*> v .: "data"

instance ToJSON Description where
    toJSON (Description basePeriodDescription missingDescription titleDescription unitsDescription) =
        object $ foldMap (maybe [] pure)
        [ Just $ "base_period" .= basePeriodDescription
        , Just $ "missing" .= missingDescription
        , Just $ "title" .= titleDescription
        , Just $ "units" .= unitsDescription
        ]

instance FromJSON Description where
    parseJSON (Object v) = Description
        <$> v .: "base_period"
        <*> v .: "missing"
        <*> v .: "title"
        <*> v .: "units"
