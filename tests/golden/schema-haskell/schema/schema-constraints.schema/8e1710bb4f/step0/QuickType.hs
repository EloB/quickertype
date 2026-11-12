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

data QuickType = QuickType
    { minMaxLengthQuickType :: Text
    , percentQuickType :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType minMaxLengthQuickType percentQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "minMaxLength" .= minMaxLengthQuickType
        , Just $ "percent" .= percentQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "minMaxLength"
        <*> v .: "percent"
