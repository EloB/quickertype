{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Constructor (..)
    , UnionConstructor (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { constructorQuickType :: Maybe UnionConstructor
    } deriving (Show)

data UnionConstructor
    = ConstructorInUnionConstructor Constructor
    | DoubleInUnionConstructor Double
    deriving (Show)

data Constructor = Constructor
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType constructorQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("constructor" .=) <$> constructorQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "constructor"

instance ToJSON UnionConstructor where
    toJSON (ConstructorInUnionConstructor x) = toJSON x
    toJSON (DoubleInUnionConstructor x) = toJSON x

instance FromJSON UnionConstructor where
    parseJSON xs@(Object _) = (fmap ConstructorInUnionConstructor . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInUnionConstructor . parseJSON) xs

instance ToJSON Constructor where
    toJSON = \_ -> emptyObject

instance FromJSON Constructor where
    parseJSON (Object _) = return Constructor
