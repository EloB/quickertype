{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Item (..)
    , Address (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { itemQuickType :: [Item]
    } deriving (Show)

data Item = Item
    { addressItem :: Maybe Address
    , createdAtItem :: Maybe Text
    , nameItem :: Text
    , sexItem :: Maybe Int
    } deriving (Show)

data Address = Address
    { cityAddress :: Text
    , countryAddress :: Text
    , streetAddress :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType itemQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "item" .= itemQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "item"

instance ToJSON Item where
    toJSON (Item addressItem createdAtItem nameItem sexItem) =
        object $ foldMap (maybe [] pure)
        [ ("address" .=) <$> addressItem
        , ("created_at" .=) <$> createdAtItem
        , Just $ "name" .= nameItem
        , Just $ "sex" .= sexItem
        ]

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .:! "address"
        <*> v .:! "created_at"
        <*> v .: "name"
        <*> v .: "sex"

instance ToJSON Address where
    toJSON (Address cityAddress countryAddress streetAddress) =
        object $ foldMap (maybe [] pure)
        [ Just $ "city" .= cityAddress
        , Just $ "country" .= countryAddress
        , Just $ "street" .= streetAddress
        ]

instance FromJSON Address where
    parseJSON (Object v) = Address
        <$> v .: "city"
        <*> v .: "country"
        <*> v .: "street"
