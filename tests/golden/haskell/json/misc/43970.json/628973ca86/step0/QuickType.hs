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
    { nameQuickTypeElement :: Text
    , notesQuickTypeElement :: Text
    , quickTypeIDQuickTypeElement :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement nameQuickTypeElement notesQuickTypeElement quickTypeIDQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Name" .= nameQuickTypeElement
        , Just $ "Notes" .= notesQuickTypeElement
        , Just $ "ID" .= quickTypeIDQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "Name"
        <*> v .: "Notes"
        <*> v .: "ID"
