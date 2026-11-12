{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , LightParams (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { lightParamsQuickType :: LightParams
    } deriving (Show)

data LightParams = LightParams
    { appIDLightParams :: Text
    , outletIDLightParams :: Text
    , rgbaLightParams :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType lightParamsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "LightParams" .= lightParamsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "LightParams"

instance ToJSON LightParams where
    toJSON (LightParams appIDLightParams outletIDLightParams rgbaLightParams) =
        object $ foldMap (maybe [] pure)
        [ Just $ "app_id" .= appIDLightParams
        , Just $ "outlet_id" .= outletIDLightParams
        , Just $ "rgba" .= rgbaLightParams
        ]

instance FromJSON LightParams where
    parseJSON (Object v) = LightParams
        <$> v .: "app_id"
        <*> v .: "outlet_id"
        <*> v .: "rgba"
