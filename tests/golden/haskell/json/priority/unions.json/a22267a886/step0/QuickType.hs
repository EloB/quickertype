{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ZClass (..)
    , X (..)
    , ZElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { xQuickType :: [X]
    , yQuickType :: [(Maybe Int)]
    , zQuickType :: [ZElement]
    } deriving (Show)

data X
    = IntegerInX Int
    | NullInX
    | StringInX Text
    deriving (Show)

data ZElement
    = IntegerArrayInZElement ([Int])
    | IntegerInZElement Int
    | ZClassInZElement ZClass
    deriving (Show)

data ZClass = ZClass
    { aZClass :: Bool
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType xQuickType yQuickType zQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "x" .= xQuickType
        , Just $ "y" .= yQuickType
        , Just $ "z" .= zQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "x"
        <*> v .: "y"
        <*> v .: "z"

instance ToJSON X where
    toJSON (IntegerInX x) = toJSON x
    toJSON NullInX = Null
    toJSON (StringInX x) = toJSON x

instance FromJSON X where
    parseJSON xs@(Number _) = (fmap IntegerInX . parseJSON) xs
    parseJSON Null = return NullInX
    parseJSON xs@(String _) = (fmap StringInX . parseJSON) xs

instance ToJSON ZElement where
    toJSON (IntegerArrayInZElement x) = toJSON x
    toJSON (IntegerInZElement x) = toJSON x
    toJSON (ZClassInZElement x) = toJSON x

instance FromJSON ZElement where
    parseJSON xs@(Array _) = (fmap IntegerArrayInZElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInZElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap ZClassInZElement . parseJSON) xs

instance ToJSON ZClass where
    toJSON (ZClass aZClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "a" .= aZClass
        ]

instance FromJSON ZClass where
    parseJSON (Object v) = ZClass
        <$> v .: "a"
