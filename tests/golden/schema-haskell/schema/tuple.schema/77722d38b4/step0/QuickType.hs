{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Tuple (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { tupleQuickType :: [Tuple]
    } deriving (Show)

data Tuple
    = BoolInTuple Bool
    | IntegerInTuple Int
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType tupleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "tuple" .= tupleQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "tuple"

instance ToJSON Tuple where
    toJSON (BoolInTuple x) = toJSON x
    toJSON (IntegerInTuple x) = toJSON x

instance FromJSON Tuple where
    parseJSON xs@(Bool _) = (fmap BoolInTuple . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInTuple . parseJSON) xs
