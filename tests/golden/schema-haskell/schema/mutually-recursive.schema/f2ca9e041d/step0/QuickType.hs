{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Bar (..)
    , Foo (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data Foo
    = QuickTypeArrayInFoo ([QuickType])
    | QuickTypeInFoo QuickType
    deriving (Show)

data Bar = Bar
    { fooBar :: Foo
    } deriving (Show)

data QuickType = QuickType
    { barQuickType :: Maybe Bar
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON Foo where
    toJSON (QuickTypeArrayInFoo x) = toJSON x
    toJSON (QuickTypeInFoo x) = toJSON x

instance FromJSON Foo where
    parseJSON xs@(Array _) = (fmap QuickTypeArrayInFoo . parseJSON) xs
    parseJSON xs@(Object _) = (fmap QuickTypeInFoo . parseJSON) xs

instance ToJSON Bar where
    toJSON (Bar fooBar) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foo" .= fooBar
        ]

instance FromJSON Bar where
    parseJSON (Object v) = Bar
        <$> v .: "foo"

instance ToJSON QuickType where
    toJSON (QuickType barQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("bar" .=) <$> barQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "bar"
