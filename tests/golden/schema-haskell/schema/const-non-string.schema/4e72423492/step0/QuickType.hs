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
    { amountQuickType :: Int
    , enabledQuickType :: Bool
    , kindQuickType :: Kind
    , ratioQuickType :: Double
    , versionQuickType :: Double
    } deriving (Show)

data Kind
    = WidgetKind
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType amountQuickType enabledQuickType kindQuickType ratioQuickType versionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "amount" .= amountQuickType
        , Just $ "enabled" .= enabledQuickType
        , Just $ "kind" .= kindQuickType
        , Just $ "ratio" .= ratioQuickType
        , Just $ "version" .= versionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "amount"
        <*> v .: "enabled"
        <*> v .: "kind"
        <*> v .: "ratio"
        <*> v .: "version"

instance ToJSON Kind where
    toJSON WidgetKind = "widget"

instance FromJSON Kind where
    parseJSON = withText "Kind" parseText
        where
            parseText "widget" = return WidgetKind
