{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , UnionListClass (..)
    , UnionList (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { listQuickType :: UnionList
    } deriving (Show)

data UnionListClass = UnionListClass
    { nextUnionListClass :: UnionList
    } deriving (Show)

data UnionList
    = DoubleInUnionList Double
    | UnionListClassInUnionList UnionListClass
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType listQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "list" .= listQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "list"

instance ToJSON UnionListClass where
    toJSON (UnionListClass nextUnionListClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "next" .= nextUnionListClass
        ]

instance FromJSON UnionListClass where
    parseJSON (Object v) = UnionListClass
        <$> v .: "next"

instance ToJSON UnionList where
    toJSON (DoubleInUnionList x) = toJSON x
    toJSON (UnionListClassInUnionList x) = toJSON x

instance FromJSON UnionList where
    parseJSON xs@(Number _) = (fmap DoubleInUnionList . parseJSON) xs
    parseJSON xs@(Object _) = (fmap UnionListClassInUnionList . parseJSON) xs
