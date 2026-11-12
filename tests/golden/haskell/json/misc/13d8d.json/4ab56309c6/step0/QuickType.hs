{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Location (..)
    , Street (..)
    , OutcomeStatus (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { categoryQuickTypeElement :: Text
    , contextQuickTypeElement :: Text
    , locationQuickTypeElement :: Location
    , locationSubtypeQuickTypeElement :: Text
    , locationTypeQuickTypeElement :: Text
    , monthQuickTypeElement :: Text
    , outcomeStatusQuickTypeElement :: OutcomeStatus
    , persistentIDQuickTypeElement :: Text
    , quickTypeIDQuickTypeElement :: Int
    } deriving (Show)

data Location = Location
    { latitudeLocation :: Text
    , longitudeLocation :: Text
    , streetLocation :: Street
    } deriving (Show)

data Street = Street
    { nameStreet :: Text
    , streetIDStreet :: Int
    } deriving (Show)

data OutcomeStatus = OutcomeStatus
    { categoryOutcomeStatus :: Text
    , dateOutcomeStatus :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement categoryQuickTypeElement contextQuickTypeElement locationQuickTypeElement locationSubtypeQuickTypeElement locationTypeQuickTypeElement monthQuickTypeElement outcomeStatusQuickTypeElement persistentIDQuickTypeElement quickTypeIDQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "category" .= categoryQuickTypeElement
        , Just $ "context" .= contextQuickTypeElement
        , Just $ "location" .= locationQuickTypeElement
        , Just $ "location_subtype" .= locationSubtypeQuickTypeElement
        , Just $ "location_type" .= locationTypeQuickTypeElement
        , Just $ "month" .= monthQuickTypeElement
        , Just $ "outcome_status" .= outcomeStatusQuickTypeElement
        , Just $ "persistent_id" .= persistentIDQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "category"
        <*> v .: "context"
        <*> v .: "location"
        <*> v .: "location_subtype"
        <*> v .: "location_type"
        <*> v .: "month"
        <*> v .: "outcome_status"
        <*> v .: "persistent_id"
        <*> v .: "id"

instance ToJSON Location where
    toJSON (Location latitudeLocation longitudeLocation streetLocation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "latitude" .= latitudeLocation
        , Just $ "longitude" .= longitudeLocation
        , Just $ "street" .= streetLocation
        ]

instance FromJSON Location where
    parseJSON (Object v) = Location
        <$> v .: "latitude"
        <*> v .: "longitude"
        <*> v .: "street"

instance ToJSON Street where
    toJSON (Street nameStreet streetIDStreet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameStreet
        , Just $ "id" .= streetIDStreet
        ]

instance FromJSON Street where
    parseJSON (Object v) = Street
        <$> v .: "name"
        <*> v .: "id"

instance ToJSON OutcomeStatus where
    toJSON (OutcomeStatus categoryOutcomeStatus dateOutcomeStatus) =
        object $ foldMap (maybe [] pure)
        [ Just $ "category" .= categoryOutcomeStatus
        , Just $ "date" .= dateOutcomeStatus
        ]

instance FromJSON OutcomeStatus where
    parseJSON (Object v) = OutcomeStatus
        <$> v .: "category"
        <*> v .: "date"
