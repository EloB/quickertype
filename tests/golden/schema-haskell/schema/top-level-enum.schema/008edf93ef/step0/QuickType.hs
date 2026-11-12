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

data QuickType
    = OneQuickType
    | ThreeQuickType
    | TwoQuickType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON OneQuickType = "one"
    toJSON ThreeQuickType = "three"
    toJSON TwoQuickType = "two"

instance FromJSON QuickType where
    parseJSON = withText "QuickType" parseText
        where
            parseText "one" = return OneQuickType
            parseText "three" = return ThreeQuickType
            parseText "two" = return TwoQuickType
