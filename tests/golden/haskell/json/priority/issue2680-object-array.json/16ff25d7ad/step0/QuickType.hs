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
    { keyQuickTypeElement :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement keyQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "key" .= keyQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "key"
