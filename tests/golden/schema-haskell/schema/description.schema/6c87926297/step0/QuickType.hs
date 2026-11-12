{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ObjectOrStringClass (..)
    , EnumEnum (..)
    , ObjectOrStringUnion (..)
    , Union (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

{-| The top-level class.
Its description has two lines.

bar:
A pretty boolean

enum:
An enumeration

union:
Either a number or a string
-}
data QuickType = QuickType
    { barQuickType :: Maybe Bool
    , enumQuickType :: EnumEnum
    , fooQuickType :: Maybe Double
    , objectOrStringQuickType :: ObjectOrStringUnion
    , unionQuickType :: Union
    } deriving (Show)

{-| An enumeration -}

data EnumEnum
    = FooEnumEnum
    | BarEnumEnum
    deriving (Show)

data ObjectOrStringUnion
    = ObjectOrStringClassInObjectOrStringUnion ObjectOrStringClass
    | StringInObjectOrStringUnion Text
    deriving (Show)

{-| prop:
This must not get lost
-}
data ObjectOrStringClass = ObjectOrStringClass
    { propObjectOrStringClass :: Double
    } deriving (Show)

{-| Either a number or a string -}

data Union
    = DoubleInUnion Double
    | StringInUnion Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType barQuickType enumQuickType fooQuickType objectOrStringQuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("bar" .=) <$> barQuickType
        , Just $ "enum" .= enumQuickType
        , ("foo" .=) <$> fooQuickType
        , Just $ "object-or-string" .= objectOrStringQuickType
        , Just $ "union" .= unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "bar"
        <*> v .: "enum"
        <*> v .:! "foo"
        <*> v .: "object-or-string"
        <*> v .: "union"

instance ToJSON EnumEnum where
    toJSON FooEnumEnum = "foo"
    toJSON BarEnumEnum = "bar"

instance FromJSON EnumEnum where
    parseJSON = withText "EnumEnum" parseText
        where
            parseText "foo" = return FooEnumEnum
            parseText "bar" = return BarEnumEnum

instance ToJSON ObjectOrStringUnion where
    toJSON (ObjectOrStringClassInObjectOrStringUnion x) = toJSON x
    toJSON (StringInObjectOrStringUnion x) = toJSON x

instance FromJSON ObjectOrStringUnion where
    parseJSON xs@(Object _) = (fmap ObjectOrStringClassInObjectOrStringUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInObjectOrStringUnion . parseJSON) xs

instance ToJSON ObjectOrStringClass where
    toJSON (ObjectOrStringClass propObjectOrStringClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "prop" .= propObjectOrStringClass
        ]

instance FromJSON ObjectOrStringClass where
    parseJSON (Object v) = ObjectOrStringClass
        <$> v .: "prop"

instance ToJSON Union where
    toJSON (DoubleInUnion x) = toJSON x
    toJSON (StringInUnion x) = toJSON x

instance FromJSON Union where
    parseJSON xs@(Number _) = (fmap DoubleInUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnion . parseJSON) xs
