{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Coordinate (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { coordinatesQuickType :: Maybe ([Coordinate])
    , countQuickType :: Maybe Int
    , labelQuickType :: Maybe Text
    , requiredCoordinatesQuickType :: [Coordinate]
    , requiredCountQuickType :: Int
    , requiredLabelQuickType :: Text
    , weightQuickType :: Maybe Double
    } deriving (Show)

data Coordinate = Coordinate
    { latitudeCoordinate :: Double
    , longitudeCoordinate :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType coordinatesQuickType countQuickType labelQuickType requiredCoordinatesQuickType requiredCountQuickType requiredLabelQuickType weightQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("coordinates" .=) <$> coordinatesQuickType
        , ("count" .=) <$> countQuickType
        , ("label" .=) <$> labelQuickType
        , Just $ "requiredCoordinates" .= requiredCoordinatesQuickType
        , Just $ "requiredCount" .= requiredCountQuickType
        , Just $ "requiredLabel" .= requiredLabelQuickType
        , ("weight" .=) <$> weightQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "coordinates"
        <*> v .:! "count"
        <*> v .:! "label"
        <*> v .: "requiredCoordinates"
        <*> v .: "requiredCount"
        <*> v .: "requiredLabel"
        <*> v .:! "weight"

instance ToJSON Coordinate where
    toJSON (Coordinate latitudeCoordinate longitudeCoordinate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "latitude" .= latitudeCoordinate
        , Just $ "longitude" .= longitudeCoordinate
        ]

instance FromJSON Coordinate where
    parseJSON (Object v) = Coordinate
        <$> v .: "latitude"
        <*> v .: "longitude"
