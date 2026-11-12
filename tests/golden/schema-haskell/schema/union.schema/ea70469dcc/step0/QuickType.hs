{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { oneQuickTypeElement :: Maybe Int
    , twoQuickTypeElement :: Bool
    , threeQuickTypeElement :: Maybe Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement oneQuickTypeElement twoQuickTypeElement threeQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ ("one" .=) <$> oneQuickTypeElement
        , Just $ "two" .= twoQuickTypeElement
        , ("three" .=) <$> threeQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .:! "one"
        <*> v .: "two"
        <*> v .:! "three"
