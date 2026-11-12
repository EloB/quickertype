{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Status (..)
    , Weather (..)
    , Meta (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { cityQuickType :: Text
    , delayQuickType :: Text
    , iataQuickType :: Text
    , icaoQuickType :: Text
    , nameQuickType :: Text
    , stateQuickType :: Text
    , statusQuickType :: Status
    , weatherQuickType :: Weather
    } deriving (Show)

data Status = Status
    { avgDelayStatus :: Text
    , closureBeginStatus :: Text
    , closureEndStatus :: Text
    , endTimeStatus :: Text
    , maxDelayStatus :: Text
    , minDelayStatus :: Text
    , reasonStatus :: Text
    , statusTypeStatus :: Text
    , trendStatus :: Text
    } deriving (Show)

data Weather = Weather
    { metaWeather :: Meta
    , tempWeather :: Text
    , visibilityWeather :: Double
    , weatherWeather :: Text
    , windWeather :: Text
    } deriving (Show)

data Meta = Meta
    { creditMeta :: Text
    , updatedMeta :: Text
    , urlMeta :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType cityQuickType delayQuickType iataQuickType icaoQuickType nameQuickType stateQuickType statusQuickType weatherQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "city" .= cityQuickType
        , Just $ "delay" .= delayQuickType
        , Just $ "IATA" .= iataQuickType
        , Just $ "ICAO" .= icaoQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "state" .= stateQuickType
        , Just $ "status" .= statusQuickType
        , Just $ "weather" .= weatherQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "city"
        <*> v .: "delay"
        <*> v .: "IATA"
        <*> v .: "ICAO"
        <*> v .: "name"
        <*> v .: "state"
        <*> v .: "status"
        <*> v .: "weather"

instance ToJSON Status where
    toJSON (Status avgDelayStatus closureBeginStatus closureEndStatus endTimeStatus maxDelayStatus minDelayStatus reasonStatus statusTypeStatus trendStatus) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avgDelay" .= avgDelayStatus
        , Just $ "closureBegin" .= closureBeginStatus
        , Just $ "closureEnd" .= closureEndStatus
        , Just $ "endTime" .= endTimeStatus
        , Just $ "maxDelay" .= maxDelayStatus
        , Just $ "minDelay" .= minDelayStatus
        , Just $ "reason" .= reasonStatus
        , Just $ "type" .= statusTypeStatus
        , Just $ "trend" .= trendStatus
        ]

instance FromJSON Status where
    parseJSON (Object v) = Status
        <$> v .: "avgDelay"
        <*> v .: "closureBegin"
        <*> v .: "closureEnd"
        <*> v .: "endTime"
        <*> v .: "maxDelay"
        <*> v .: "minDelay"
        <*> v .: "reason"
        <*> v .: "type"
        <*> v .: "trend"

instance ToJSON Weather where
    toJSON (Weather metaWeather tempWeather visibilityWeather weatherWeather windWeather) =
        object $ foldMap (maybe [] pure)
        [ Just $ "meta" .= metaWeather
        , Just $ "temp" .= tempWeather
        , Just $ "visibility" .= visibilityWeather
        , Just $ "weather" .= weatherWeather
        , Just $ "wind" .= windWeather
        ]

instance FromJSON Weather where
    parseJSON (Object v) = Weather
        <$> v .: "meta"
        <*> v .: "temp"
        <*> v .: "visibility"
        <*> v .: "weather"
        <*> v .: "wind"

instance ToJSON Meta where
    toJSON (Meta creditMeta updatedMeta urlMeta) =
        object $ foldMap (maybe [] pure)
        [ Just $ "credit" .= creditMeta
        , Just $ "updated" .= updatedMeta
        , Just $ "url" .= urlMeta
        ]

instance FromJSON Meta where
    parseJSON (Object v) = Meta
        <$> v .: "credit"
        <*> v .: "updated"
        <*> v .: "url"
