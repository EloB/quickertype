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
    { booleanQuickType :: Bool
    , integerQuickType :: Int
    , integersQuickType :: [Int]
    , numberQuickType :: Double
    , stringQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType booleanQuickType integerQuickType integersQuickType numberQuickType stringQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "boolean" .= booleanQuickType
        , Just $ "integer" .= integerQuickType
        , Just $ "integers" .= integersQuickType
        , Just $ "number" .= numberQuickType
        , Just $ "string" .= stringQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "boolean"
        <*> v .: "integer"
        <*> v .: "integers"
        <*> v .: "number"
        <*> v .: "string"
