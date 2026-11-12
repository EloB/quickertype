{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , FooEnum (..)
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
    | EnumInFooUnion FooEnum
    | IntegerInFooUnion Int
    deriving (Show)

data FooEnum
    = AFooEnum
    | BFooEnum
    | CFooEnum
    deriving (Show)

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
    toJSON (EnumInFooUnion x) = toJSON x
    toJSON (IntegerInFooUnion x) = toJSON x

instance FromJSON FooUnion where
    parseJSON xs@(Bool _) = (fmap BoolInFooUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInFooUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInFooUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInFooUnion . parseJSON) xs

instance ToJSON FooEnum where
    toJSON AFooEnum = "a"
    toJSON BFooEnum = "b"
    toJSON CFooEnum = "c"

instance FromJSON FooEnum where
    parseJSON = withText "FooEnum" parseText
        where
            parseText "a" = return AFooEnum
            parseText "b" = return BFooEnum
            parseText "c" = return CFooEnum
