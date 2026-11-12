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
    { continueQuickType :: Text
    , emptyQuickType :: Text
    , nullQuickType :: Text
    , purpleXQuickType :: Text
    , quickTypeQuickType :: Text
    , quickTypeXQuickType :: Text
    , undefinedQuickType :: Text
    , xQuickType :: Text
    , xYQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType continueQuickType emptyQuickType nullQuickType purpleXQuickType quickTypeQuickType quickTypeXQuickType undefinedQuickType xQuickType xYQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "continue" .= continueQuickType
        , Just $ "" .= emptyQuickType
        , Just $ "null" .= nullQuickType
        , Just $ "x'" .= purpleXQuickType
        , Just $ "{}" .= quickTypeQuickType
        , Just $ "x\"" .= quickTypeXQuickType
        , Just $ "undefined" .= undefinedQuickType
        , Just $ "x" .= xQuickType
        , Just $ "x y" .= xYQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "continue"
        <*> v .: ""
        <*> v .: "null"
        <*> v .: "x'"
        <*> v .: "{}"
        <*> v .: "x\""
        <*> v .: "undefined"
        <*> v .: "x"
        <*> v .: "x y"
