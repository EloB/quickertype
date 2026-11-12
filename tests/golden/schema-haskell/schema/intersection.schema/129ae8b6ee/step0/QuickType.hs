{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Intersection (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { intersectionQuickType :: Maybe Intersection
    } deriving (Show)

data Intersection = Intersection
    { fooIntersection :: Double
    , barIntersection :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType intersectionQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("intersection" .=) <$> intersectionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "intersection"

instance ToJSON Intersection where
    toJSON (Intersection fooIntersection barIntersection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foo" .= fooIntersection
        , ("bar" .=) <$> barIntersection
        ]

instance FromJSON Intersection where
    parseJSON (Object v) = Intersection
        <$> v .: "foo"
        <*> v .:! "bar"
