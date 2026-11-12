{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , MixedClass (..)
    , MixedElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { mixedQuickType :: [MixedElement]
    } deriving (Show)

data MixedElement
    = BoolInMixedElement Bool
    | IntegerInMixedElement Int
    | MixedClassInMixedElement MixedClass
    | NullInMixedElement
    | StringInMixedElement Text
    deriving (Show)

data MixedClass = MixedClass
    { nestedMixedClass :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType mixedQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "mixed" .= mixedQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "mixed"

instance ToJSON MixedElement where
    toJSON (BoolInMixedElement x) = toJSON x
    toJSON (IntegerInMixedElement x) = toJSON x
    toJSON (MixedClassInMixedElement x) = toJSON x
    toJSON NullInMixedElement = Null
    toJSON (StringInMixedElement x) = toJSON x

instance FromJSON MixedElement where
    parseJSON xs@(Bool _) = (fmap BoolInMixedElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInMixedElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MixedClassInMixedElement . parseJSON) xs
    parseJSON Null = return NullInMixedElement
    parseJSON xs@(String _) = (fmap StringInMixedElement . parseJSON) xs

instance ToJSON MixedClass where
    toJSON (MixedClass nestedMixedClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nested" .= nestedMixedClass
        ]

instance FromJSON MixedClass where
    parseJSON (Object v) = MixedClass
        <$> v .: "nested"
