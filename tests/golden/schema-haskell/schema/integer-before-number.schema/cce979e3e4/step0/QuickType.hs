{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

{-| An integer or non-integer number -}

data QuickType
    = DoubleInQuickType Double
    | IntegerInQuickType Int
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (DoubleInQuickType x) = toJSON x
    toJSON (IntegerInQuickType x) = toJSON x

instance FromJSON QuickType where
    parseJSON xs@(Number _) = (fmap DoubleInQuickType . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInQuickType . parseJSON) xs
