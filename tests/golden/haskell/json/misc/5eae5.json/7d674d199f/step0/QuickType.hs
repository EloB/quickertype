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
    , quickTypeIDQuickTypeElement :: Int
    , sponsorQuickTypeElement :: Text
    , titleQuickTypeElement :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement dateQuickTypeElement quickTypeIDQuickTypeElement sponsorQuickTypeElement titleQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Date" .= dateQuickTypeElement
        , Just $ "ID" .= quickTypeIDQuickTypeElement
        , Just $ "Sponsor" .= sponsorQuickTypeElement
        , Just $ "Title" .= titleQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "Date"
        <*> v .: "ID"
        <*> v .: "Sponsor"
        <*> v .: "Title"
