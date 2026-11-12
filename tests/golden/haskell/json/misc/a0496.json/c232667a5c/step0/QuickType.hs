{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Errors (..)
    , Datum (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { codeQuickType :: Text
    , columnNamesQuickType :: [Text]
    , descriptionQuickType :: Text
    , displayURLQuickType :: Text
    , errorsQuickType :: Errors
    , frequencyQuickType :: Text
    , fromDateQuickType :: Text
    , nameQuickType :: Text
    , premiumQuickType :: Bool
    , quickTypeDataQuickType :: [([Datum])]
    , quickTypeIDQuickType :: Int
    , quickTypeTypeQuickType :: Text
    , sourceCodeQuickType :: Text
    , sourceNameQuickType :: Text
    , toDateQuickType :: Text
    , updatedAtQuickType :: Text
    , urlizeNameQuickType :: Text
    } deriving (Show)

data Errors = Errors
    {
    } deriving (Show)

data Datum
    = DoubleInDatum Double
    | NullInDatum
    | StringInDatum Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType codeQuickType columnNamesQuickType descriptionQuickType displayURLQuickType errorsQuickType frequencyQuickType fromDateQuickType nameQuickType premiumQuickType quickTypeDataQuickType quickTypeIDQuickType quickTypeTypeQuickType sourceCodeQuickType sourceNameQuickType toDateQuickType updatedAtQuickType urlizeNameQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeQuickType
        , Just $ "column_names" .= columnNamesQuickType
        , Just $ "description" .= descriptionQuickType
        , Just $ "display_url" .= displayURLQuickType
        , Just $ "errors" .= errorsQuickType
        , Just $ "frequency" .= frequencyQuickType
        , Just $ "from_date" .= fromDateQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "premium" .= premiumQuickType
        , Just $ "data" .= quickTypeDataQuickType
        , Just $ "id" .= quickTypeIDQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        , Just $ "source_code" .= sourceCodeQuickType
        , Just $ "source_name" .= sourceNameQuickType
        , Just $ "to_date" .= toDateQuickType
        , Just $ "updated_at" .= updatedAtQuickType
        , Just $ "urlize_name" .= urlizeNameQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "code"
        <*> v .: "column_names"
        <*> v .: "description"
        <*> v .: "display_url"
        <*> v .: "errors"
        <*> v .: "frequency"
        <*> v .: "from_date"
        <*> v .: "name"
        <*> v .: "premium"
        <*> v .: "data"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "source_code"
        <*> v .: "source_name"
        <*> v .: "to_date"
        <*> v .: "updated_at"
        <*> v .: "urlize_name"

instance ToJSON Errors where
    toJSON = \_ -> emptyObject

instance FromJSON Errors where
    parseJSON (Object _) = return Errors

instance ToJSON Datum where
    toJSON (DoubleInDatum x) = toJSON x
    toJSON NullInDatum = Null
    toJSON (StringInDatum x) = toJSON x

instance FromJSON Datum where
    parseJSON xs@(Number _) = (fmap DoubleInDatum . parseJSON) xs
    parseJSON Null = return NullInDatum
    parseJSON xs@(String _) = (fmap StringInDatum . parseJSON) xs
