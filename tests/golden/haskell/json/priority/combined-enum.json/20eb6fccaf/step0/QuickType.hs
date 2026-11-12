{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Bar (..)
    , X (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { barQuickType :: [Bar]
    , fooQuickType :: [Bar]
    } deriving (Show)

data Bar = Bar
    { xBar :: X
    } deriving (Show)

data X
    = ThreeX
    | OneX
    | TwoX
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType barQuickType fooQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bar" .= barQuickType
        , Just $ "foo" .= fooQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "bar"
        <*> v .: "foo"

instance ToJSON Bar where
    toJSON (Bar xBar) =
        object $ foldMap (maybe [] pure)
        [ Just $ "x" .= xBar
        ]

instance FromJSON Bar where
    parseJSON (Object v) = Bar
        <$> v .: "x"

instance ToJSON X where
    toJSON ThreeX = "three"
    toJSON OneX = "one"
    toJSON TwoX = "two"

instance FromJSON X where
    parseJSON = withText "X" parseText
        where
            parseText "three" = return ThreeX
            parseText "one" = return OneX
            parseText "two" = return TwoX
