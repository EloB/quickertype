{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Empty (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { emptyQuickType :: Empty
    , fooQuickType :: Text
    , barQuickType :: Maybe Text
    } deriving (Show)

data Empty = Empty
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType emptyQuickType fooQuickType barQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "empty" .= emptyQuickType
        , Just $ "foo" .= fooQuickType
        , ("bar" .=) <$> barQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "empty"
        <*> v .: "foo"
        <*> v .:! "bar"

instance ToJSON Empty where
    toJSON = \_ -> emptyObject

instance FromJSON Empty where
    parseJSON (Object _) = return Empty
