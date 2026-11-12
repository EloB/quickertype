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
    { dateQuickType :: Int
    , titleQuickType :: Text
    , validityQuickType :: Bool
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType dateQuickType titleQuickType validityQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date" .= dateQuickType
        , Just $ "title" .= titleQuickType
        , Just $ "validity" .= validityQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "date"
        <*> v .: "title"
        <*> v .: "validity"
