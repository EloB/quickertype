{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Response (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

{-| Postman collection -}

data QuickType = QuickType
    { itemQuickType :: Maybe ([QuickType])
    , nameQuickType :: Maybe Text
    , responseQuickType :: Maybe ([Response])
    } deriving (Show)

data Response = Response
    { bodyResponse :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType itemQuickType nameQuickType responseQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("item" .=) <$> itemQuickType
        , ("name" .=) <$> nameQuickType
        , ("response" .=) <$> responseQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "item"
        <*> v .:! "name"
        <*> v .:! "response"

instance ToJSON Response where
    toJSON (Response bodyResponse) =
        object $ foldMap (maybe [] pure)
        [ ("body" .=) <$> bodyResponse
        ]

instance FromJSON Response where
    parseJSON (Object v) = Response
        <$> v .:! "body"
