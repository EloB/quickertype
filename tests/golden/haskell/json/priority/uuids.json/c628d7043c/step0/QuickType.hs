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
    { booleanValueQuickType :: Bool
    , doubleValueQuickType :: Double
    , intValueQuickType :: Int
    , stringValueQuickType :: Text
    , uuidValueQuickType :: Text
    , uuidValuesQuickType :: [Text]
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType booleanValueQuickType doubleValueQuickType intValueQuickType stringValueQuickType uuidValueQuickType uuidValuesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "booleanValue" .= booleanValueQuickType
        , Just $ "doubleValue" .= doubleValueQuickType
        , Just $ "intValue" .= intValueQuickType
        , Just $ "stringValue" .= stringValueQuickType
        , Just $ "uuidValue" .= uuidValueQuickType
        , Just $ "uuidValues" .= uuidValuesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "booleanValue"
        <*> v .: "doubleValue"
        <*> v .: "intValue"
        <*> v .: "stringValue"
        <*> v .: "uuidValue"
        <*> v .: "uuidValues"
