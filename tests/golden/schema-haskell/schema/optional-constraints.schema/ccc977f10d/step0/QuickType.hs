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
    { optDoubleQuickType :: Maybe Double
    , optIntQuickType :: Maybe Int
    , optPatternQuickType :: Maybe Text
    , optStringQuickType :: Maybe Text
    , reqZeroMinQuickType :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType optDoubleQuickType optIntQuickType optPatternQuickType optStringQuickType reqZeroMinQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("optDouble" .=) <$> optDoubleQuickType
        , ("optInt" .=) <$> optIntQuickType
        , ("optPattern" .=) <$> optPatternQuickType
        , ("optString" .=) <$> optStringQuickType
        , Just $ "reqZeroMin" .= reqZeroMinQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "optDouble"
        <*> v .:! "optInt"
        <*> v .:! "optPattern"
        <*> v .:! "optString"
        <*> v .: "reqZeroMin"
