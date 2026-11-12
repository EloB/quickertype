{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Invoice (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { invoicesQuickType :: [Invoice]
    } deriving (Show)

data Invoice = Invoice
    { createdAtInvoice :: Maybe Text
    , dueDateInvoice :: Maybe Text
    , nameInvoice :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType invoicesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "invoices" .= invoicesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "invoices"

instance ToJSON Invoice where
    toJSON (Invoice createdAtInvoice dueDateInvoice nameInvoice) =
        object $ foldMap (maybe [] pure)
        [ Just $ "createdAt" .= createdAtInvoice
        , Just $ "dueDate" .= dueDateInvoice
        , Just $ "name" .= nameInvoice
        ]

instance FromJSON Invoice where
    parseJSON (Object v) = Invoice
        <$> v .: "createdAt"
        <*> v .: "dueDate"
        <*> v .: "name"
