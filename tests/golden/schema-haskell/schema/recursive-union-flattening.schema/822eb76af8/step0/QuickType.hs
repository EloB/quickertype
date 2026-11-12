{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeClass (..)
    , XClass (..)
    , QuickTypeElement (..)
    , XElement (..)
    , X (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType
    = AnythingMapInQuickType (HashMap Text Value)
    | BoolInQuickType Bool
    | DoubleInQuickType Double
    | IntegerInQuickType Int
    | NullInQuickType
    | StringInQuickType Text
    | UnionArrayInQuickType ([QuickTypeElement])
    deriving (Show)

data QuickTypeElement
    = AnythingArrayInQuickTypeElement ([Value])
    | BoolInQuickTypeElement Bool
    | DoubleInQuickTypeElement Double
    | IntegerInQuickTypeElement Int
    | NullInQuickTypeElement
    | QuickTypeClassInQuickTypeElement QuickTypeClass
    | StringInQuickTypeElement Text
    deriving (Show)

data QuickTypeClass = QuickTypeClass
    { xQuickTypeClass :: Maybe X
    } deriving (Show)

data XClass = XClass
    { xXClass :: Maybe X
    } deriving (Show)

data XElement
    = AnythingArrayInXElement ([Value])
    | BoolInXElement Bool
    | DoubleInXElement Double
    | IntegerInXElement Int
    | NullInXElement
    | StringInXElement Text
    | XClassInXElement XClass
    deriving (Show)

data X
    = AnythingMapInX (HashMap Text Value)
    | BoolInX Bool
    | DoubleInX Double
    | IntegerInX Int
    | NullInX
    | StringInX Text
    | UnionArrayInX ([XElement])
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (AnythingMapInQuickType x) = toJSON x
    toJSON (BoolInQuickType x) = toJSON x
    toJSON (DoubleInQuickType x) = toJSON x
    toJSON (IntegerInQuickType x) = toJSON x
    toJSON NullInQuickType = Null
    toJSON (StringInQuickType x) = toJSON x
    toJSON (UnionArrayInQuickType x) = toJSON x

instance FromJSON QuickType where
    parseJSON xs@(Object _) = (fmap AnythingMapInQuickType . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInQuickType . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInQuickType . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInQuickType . parseJSON) xs
    parseJSON Null = return NullInQuickType
    parseJSON xs@(String _) = (fmap StringInQuickType . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInQuickType . parseJSON) xs

instance ToJSON QuickTypeElement where
    toJSON (AnythingArrayInQuickTypeElement x) = toJSON x
    toJSON (BoolInQuickTypeElement x) = toJSON x
    toJSON (DoubleInQuickTypeElement x) = toJSON x
    toJSON (IntegerInQuickTypeElement x) = toJSON x
    toJSON NullInQuickTypeElement = Null
    toJSON (QuickTypeClassInQuickTypeElement x) = toJSON x
    toJSON (StringInQuickTypeElement x) = toJSON x

instance FromJSON QuickTypeElement where
    parseJSON xs@(Array _) = (fmap AnythingArrayInQuickTypeElement . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInQuickTypeElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInQuickTypeElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInQuickTypeElement . parseJSON) xs
    parseJSON Null = return NullInQuickTypeElement
    parseJSON xs@(Object _) = (fmap QuickTypeClassInQuickTypeElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInQuickTypeElement . parseJSON) xs

instance ToJSON QuickTypeClass where
    toJSON (QuickTypeClass xQuickTypeClass) =
        object $ foldMap (maybe [] pure)
        [ ("x" .=) <$> xQuickTypeClass
        ]

instance FromJSON QuickTypeClass where
    parseJSON (Object v) = QuickTypeClass
        <$> v .:! "x"

instance ToJSON XClass where
    toJSON (XClass xXClass) =
        object $ foldMap (maybe [] pure)
        [ ("x" .=) <$> xXClass
        ]

instance FromJSON XClass where
    parseJSON (Object v) = XClass
        <$> v .:! "x"

instance ToJSON XElement where
    toJSON (AnythingArrayInXElement x) = toJSON x
    toJSON (BoolInXElement x) = toJSON x
    toJSON (DoubleInXElement x) = toJSON x
    toJSON (IntegerInXElement x) = toJSON x
    toJSON NullInXElement = Null
    toJSON (StringInXElement x) = toJSON x
    toJSON (XClassInXElement x) = toJSON x

instance FromJSON XElement where
    parseJSON xs@(Array _) = (fmap AnythingArrayInXElement . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInXElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInXElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInXElement . parseJSON) xs
    parseJSON Null = return NullInXElement
    parseJSON xs@(String _) = (fmap StringInXElement . parseJSON) xs
    parseJSON xs@(Object _) = (fmap XClassInXElement . parseJSON) xs

instance ToJSON X where
    toJSON (AnythingMapInX x) = toJSON x
    toJSON (BoolInX x) = toJSON x
    toJSON (DoubleInX x) = toJSON x
    toJSON (IntegerInX x) = toJSON x
    toJSON NullInX = Null
    toJSON (StringInX x) = toJSON x
    toJSON (UnionArrayInX x) = toJSON x

instance FromJSON X where
    parseJSON xs@(Object _) = (fmap AnythingMapInX . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInX . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInX . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInX . parseJSON) xs
    parseJSON Null = return NullInX
    parseJSON xs@(String _) = (fmap StringInX . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInX . parseJSON) xs
