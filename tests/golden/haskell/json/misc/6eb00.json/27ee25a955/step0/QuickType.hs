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
    { directorateIDQuickTypeElement :: Int
    , nameQuickTypeElement :: Text
    , quickTypeIDQuickTypeElement :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement directorateIDQuickTypeElement nameQuickTypeElement quickTypeIDQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "DirectorateID" .= directorateIDQuickTypeElement
        , Just $ "Name" .= nameQuickTypeElement
        , Just $ "Id" .= quickTypeIDQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "DirectorateID"
        <*> v .: "Name"
        <*> v .: "Id"
