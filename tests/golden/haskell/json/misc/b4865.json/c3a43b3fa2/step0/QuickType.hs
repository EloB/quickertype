{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Geolocation (..)
    , Fall (..)
    , Type (..)
    , Nametype (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { computedRegionCbhkFwbdQuickTypeElement :: Maybe Text
    , computedRegionNnqa25F4QuickTypeElement :: Maybe Text
    , fallQuickTypeElement :: Fall
    , geolocationQuickTypeElement :: Maybe Geolocation
    , massQuickTypeElement :: Maybe Text
    , nameQuickTypeElement :: Text
    , nametypeQuickTypeElement :: Nametype
    , quickTypeIDQuickTypeElement :: Text
    , recclassQuickTypeElement :: Text
    , reclatQuickTypeElement :: Maybe Text
    , reclongQuickTypeElement :: Maybe Text
    , yearQuickTypeElement :: Maybe Text
    } deriving (Show)

data Fall
    = FellFall
    | FoundFall
    deriving (Show)

data Geolocation = Geolocation
    { coordinatesGeolocation :: [Double]
    , geolocationTypeGeolocation :: Type
    } deriving (Show)

data Type
    = PointType
    deriving (Show)

data Nametype
    = ValidNametype
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement computedRegionCbhkFwbdQuickTypeElement computedRegionNnqa25F4QuickTypeElement fallQuickTypeElement geolocationQuickTypeElement massQuickTypeElement nameQuickTypeElement nametypeQuickTypeElement quickTypeIDQuickTypeElement recclassQuickTypeElement reclatQuickTypeElement reclongQuickTypeElement yearQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ (":@computed_region_cbhk_fwbd" .=) <$> computedRegionCbhkFwbdQuickTypeElement
        , (":@computed_region_nnqa_25f4" .=) <$> computedRegionNnqa25F4QuickTypeElement
        , Just $ "fall" .= fallQuickTypeElement
        , ("geolocation" .=) <$> geolocationQuickTypeElement
        , ("mass" .=) <$> massQuickTypeElement
        , Just $ "name" .= nameQuickTypeElement
        , Just $ "nametype" .= nametypeQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        , Just $ "recclass" .= recclassQuickTypeElement
        , ("reclat" .=) <$> reclatQuickTypeElement
        , ("reclong" .=) <$> reclongQuickTypeElement
        , ("year" .=) <$> yearQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .:! ":@computed_region_cbhk_fwbd"
        <*> v .:! ":@computed_region_nnqa_25f4"
        <*> v .: "fall"
        <*> v .:! "geolocation"
        <*> v .:! "mass"
        <*> v .: "name"
        <*> v .: "nametype"
        <*> v .: "id"
        <*> v .: "recclass"
        <*> v .:! "reclat"
        <*> v .:! "reclong"
        <*> v .:! "year"

instance ToJSON Fall where
    toJSON FellFall = "Fell"
    toJSON FoundFall = "Found"

instance FromJSON Fall where
    parseJSON = withText "Fall" parseText
        where
            parseText "Fell" = return FellFall
            parseText "Found" = return FoundFall

instance ToJSON Geolocation where
    toJSON (Geolocation coordinatesGeolocation geolocationTypeGeolocation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "coordinates" .= coordinatesGeolocation
        , Just $ "type" .= geolocationTypeGeolocation
        ]

instance FromJSON Geolocation where
    parseJSON (Object v) = Geolocation
        <$> v .: "coordinates"
        <*> v .: "type"

instance ToJSON Type where
    toJSON PointType = "Point"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "Point" = return PointType

instance ToJSON Nametype where
    toJSON ValidNametype = "Valid"

instance FromJSON Nametype where
    parseJSON = withText "Nametype" parseText
        where
            parseText "Valid" = return ValidNametype
