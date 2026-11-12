{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , A (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { aQuickTypeElement :: Maybe A
    } deriving (Show)

data A
    = IntegerInA Int
    | StringInA Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement aQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ ("a" .=) <$> aQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .:! "a"

instance ToJSON A where
    toJSON (IntegerInA x) = toJSON x
    toJSON (StringInA x) = toJSON x

instance FromJSON A where
    parseJSON xs@(Number _) = (fmap IntegerInA . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInA . parseJSON) xs
