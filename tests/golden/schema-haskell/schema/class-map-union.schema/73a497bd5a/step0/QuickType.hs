{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , UnionClass (..)
    , UnionValue (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { unionQuickType :: Maybe (HashMap Text UnionValue)
    } deriving (Show)

data UnionValue
    = BoolInUnionValue Bool
    | DoubleInUnionValue Double
    | StringInUnionValue Text
    | UnionClassInUnionValue UnionClass
    deriving (Show)

data UnionClass = UnionClass
    { quuxUnionClass :: Maybe Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("union" .=) <$> unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "union"

instance ToJSON UnionValue where
    toJSON (BoolInUnionValue x) = toJSON x
    toJSON (DoubleInUnionValue x) = toJSON x
    toJSON (StringInUnionValue x) = toJSON x
    toJSON (UnionClassInUnionValue x) = toJSON x

instance FromJSON UnionValue where
    parseJSON xs@(Bool _) = (fmap BoolInUnionValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionValue . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInUnionValue . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionClassInUnionValue . parseJSON) xs

instance ToJSON UnionClass where
    toJSON (UnionClass quuxUnionClass) =
        object $ foldMap (maybe [] pure)
        [ ("quux" .=) <$> quuxUnionClass
        ]

instance FromJSON UnionClass where
    parseJSON (Object v) = UnionClass
        <$> v .:! "quux"
