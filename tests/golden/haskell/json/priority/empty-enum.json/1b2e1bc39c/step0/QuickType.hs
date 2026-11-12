{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Foo (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { fooQuickType :: [Foo]
    } deriving (Show)

data Foo = Foo
    { barFoo :: Maybe Text
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

instance ToJSON Foo where
    toJSON (Foo barFoo) =
        object $ foldMap (maybe [] pure)
        [ ("bar" .=) <$> barFoo
        ]

instance FromJSON Foo where
    parseJSON (Object v) = Foo
        <$> v .:! "bar"
