{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Country (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { countriesQuickType :: [Country]
    } deriving (Show)

data Country = Country
    { codeCountry :: Text
    , nameCountry :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType countriesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "countries" .= countriesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "countries"

instance ToJSON Country where
    toJSON (Country codeCountry nameCountry) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeCountry
        , Just $ "name" .= nameCountry
        ]

instance FromJSON Country where
    parseJSON (Object v) = Country
        <$> v .: "code"
        <*> v .: "name"
