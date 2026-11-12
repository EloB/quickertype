{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , BoolInUnion (..)
    , Union (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { boolInUnionQuickType :: BoolInUnion
    , unionQuickType :: [Union]
    } deriving (Show)

data BoolInUnion = BoolInUnion
    { aBoolInUnion :: Bool
    } deriving (Show)

data Union
    = IntegerInUnion Int
    | PurpleBoolInUnion Bool
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType boolInUnionQuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "BoolInUnion" .= boolInUnionQuickType
        , Just $ "union" .= unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "BoolInUnion"
        <*> v .: "union"

instance ToJSON BoolInUnion where
    toJSON (BoolInUnion aBoolInUnion) =
        object $ foldMap (maybe [] pure)
        [ Just $ "a" .= aBoolInUnion
        ]

instance FromJSON BoolInUnion where
    parseJSON (Object v) = BoolInUnion
        <$> v .: "a"

instance ToJSON Union where
    toJSON (IntegerInUnion x) = toJSON x
    toJSON (PurpleBoolInUnion x) = toJSON x

instance FromJSON Union where
    parseJSON xs@(Number _) = (fmap IntegerInUnion . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap PurpleBoolInUnion . parseJSON) xs
