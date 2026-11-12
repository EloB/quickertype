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
    { childrenDataQuickType :: [QuickType]
    , isActiveQuickType :: Bool
    , levelQuickType :: Int
    , nameQuickType :: Text
    , parentIDQuickType :: Int
    , positionQuickType :: Int
    , productCountQuickType :: Int
    , quickTypeIDQuickType :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType childrenDataQuickType isActiveQuickType levelQuickType nameQuickType parentIDQuickType positionQuickType productCountQuickType quickTypeIDQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "children_data" .= childrenDataQuickType
        , Just $ "is_active" .= isActiveQuickType
        , Just $ "level" .= levelQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "parent_id" .= parentIDQuickType
        , Just $ "position" .= positionQuickType
        , Just $ "product_count" .= productCountQuickType
        , Just $ "id" .= quickTypeIDQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "children_data"
        <*> v .: "is_active"
        <*> v .: "level"
        <*> v .: "name"
        <*> v .: "parent_id"
        <*> v .: "position"
        <*> v .: "product_count"
        <*> v .: "id"
