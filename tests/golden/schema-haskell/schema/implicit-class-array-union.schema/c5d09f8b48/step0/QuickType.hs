{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , FooClass (..)
    , FooUnion (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { fooQuickType :: FooUnion
    } deriving (Show)

data FooUnion
    = BoolInFooUnion Bool
    | DoubleInFooUnion Double
    | FooClassInFooUnion FooClass
    | IntegerArrayInFooUnion ([Int])
    | IntegerInFooUnion Int
    | NullInFooUnion
    | StringInFooUnion Text
    deriving (Show)

data FooClass = FooClass
    { barFooClass :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType fooQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foo" .= fooQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "foo"

instance ToJSON FooUnion where
    toJSON (BoolInFooUnion x) = toJSON x
    toJSON (DoubleInFooUnion x) = toJSON x
    toJSON (FooClassInFooUnion x) = toJSON x
    toJSON (IntegerArrayInFooUnion x) = toJSON x
    toJSON (IntegerInFooUnion x) = toJSON x
    toJSON NullInFooUnion = Null
    toJSON (StringInFooUnion x) = toJSON x

instance FromJSON FooUnion where
    parseJSON xs@(Bool _) = (fmap BoolInFooUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInFooUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FooClassInFooUnion . parseJSON) xs
    parseJSON xs@(Array _) = (fmap IntegerArrayInFooUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInFooUnion . parseJSON) xs
    parseJSON Null = return NullInFooUnion
    parseJSON xs@(String _) = (fmap StringInFooUnion . parseJSON) xs

instance ToJSON FooClass where
    toJSON (FooClass barFooClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bar" .= barFooClass
        ]

instance FromJSON FooClass where
    parseJSON (Object v) = FooClass
        <$> v .: "bar"
