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
    { dateQuickTypeElement :: Text
    , stopAndSearchQuickTypeElement :: [Text]
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement dateQuickTypeElement stopAndSearchQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date" .= dateQuickTypeElement
        , Just $ "stop-and-search" .= stopAndSearchQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "date"
        <*> v .: "stop-and-search"
