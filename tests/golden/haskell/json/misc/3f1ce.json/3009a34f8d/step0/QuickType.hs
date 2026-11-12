{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Query (..)
    , Results (..)
    , Channel (..)
    , Astronomy (..)
    , Atmosphere (..)
    , Image (..)
    , Item (..)
    , Condition (..)
    , Forecast (..)
    , GUID (..)
    , Location (..)
    , Units (..)
    , Wind (..)
    , TextEnum (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { queryQuickType :: Query
    } deriving (Show)

data Query = Query
    { countQuery :: Int
    , createdQuery :: Text
    , langQuery :: Text
    , resultsQuery :: Results
    } deriving (Show)

data Results = Results
    { channelResults :: Channel
    } deriving (Show)

data Channel = Channel
    { astronomyChannel :: Astronomy
    , atmosphereChannel :: Atmosphere
    , descriptionChannel :: Text
    , imageChannel :: Image
    , itemChannel :: Item
    , languageChannel :: Text
    , lastBuildDateChannel :: Text
    , linkChannel :: Text
    , locationChannel :: Location
    , titleChannel :: Text
    , ttlChannel :: Text
    , unitsChannel :: Units
    , windChannel :: Wind
    } deriving (Show)

data Astronomy = Astronomy
    { sunriseAstronomy :: Text
    , sunsetAstronomy :: Text
    } deriving (Show)

data Atmosphere = Atmosphere
    { humidityAtmosphere :: Text
    , pressureAtmosphere :: Text
    , risingAtmosphere :: Text
    , visibilityAtmosphere :: Text
    } deriving (Show)

data Image = Image
    { heightImage :: Text
    , linkImage :: Text
    , titleImage :: Text
    , urlImage :: Text
    , widthImage :: Text
    } deriving (Show)

data Item = Item
    { conditionItem :: Condition
    , descriptionItem :: Text
    , forecastItem :: [Forecast]
    , guidItem :: GUID
    , latItem :: Text
    , linkItem :: Text
    , longItem :: Text
    , pubDateItem :: Text
    , titleItem :: Text
    } deriving (Show)

data Condition = Condition
    { codeCondition :: Text
    , conditionTextCondition :: Text
    , dateCondition :: Text
    , tempCondition :: Text
    } deriving (Show)

data Forecast = Forecast
    { codeForecast :: Text
    , dateForecast :: Text
    , dayForecast :: Text
    , forecastTextForecast :: TextEnum
    , highForecast :: Text
    , lowForecast :: Text
    } deriving (Show)

data TextEnum
    = ThunderstormsTextEnum
    deriving (Show)

data GUID = GUID
    { isPermaLinkGUID :: Text
    } deriving (Show)

data Location = Location
    { cityLocation :: Text
    , countryLocation :: Text
    , regionLocation :: Text
    } deriving (Show)

data Units = Units
    { distanceUnits :: Text
    , pressureUnits :: Text
    , speedUnits :: Text
    , temperatureUnits :: Text
    } deriving (Show)

data Wind = Wind
    { chillWind :: Text
    , directionWind :: Text
    , speedWind :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType queryQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "query" .= queryQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "query"

instance ToJSON Query where
    toJSON (Query countQuery createdQuery langQuery resultsQuery) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countQuery
        , Just $ "created" .= createdQuery
        , Just $ "lang" .= langQuery
        , Just $ "results" .= resultsQuery
        ]

instance FromJSON Query where
    parseJSON (Object v) = Query
        <$> v .: "count"
        <*> v .: "created"
        <*> v .: "lang"
        <*> v .: "results"

instance ToJSON Results where
    toJSON (Results channelResults) =
        object $ foldMap (maybe [] pure)
        [ Just $ "channel" .= channelResults
        ]

instance FromJSON Results where
    parseJSON (Object v) = Results
        <$> v .: "channel"

instance ToJSON Channel where
    toJSON (Channel astronomyChannel atmosphereChannel descriptionChannel imageChannel itemChannel languageChannel lastBuildDateChannel linkChannel locationChannel titleChannel ttlChannel unitsChannel windChannel) =
        object $ foldMap (maybe [] pure)
        [ Just $ "astronomy" .= astronomyChannel
        , Just $ "atmosphere" .= atmosphereChannel
        , Just $ "description" .= descriptionChannel
        , Just $ "image" .= imageChannel
        , Just $ "item" .= itemChannel
        , Just $ "language" .= languageChannel
        , Just $ "lastBuildDate" .= lastBuildDateChannel
        , Just $ "link" .= linkChannel
        , Just $ "location" .= locationChannel
        , Just $ "title" .= titleChannel
        , Just $ "ttl" .= ttlChannel
        , Just $ "units" .= unitsChannel
        , Just $ "wind" .= windChannel
        ]

instance FromJSON Channel where
    parseJSON (Object v) = Channel
        <$> v .: "astronomy"
        <*> v .: "atmosphere"
        <*> v .: "description"
        <*> v .: "image"
        <*> v .: "item"
        <*> v .: "language"
        <*> v .: "lastBuildDate"
        <*> v .: "link"
        <*> v .: "location"
        <*> v .: "title"
        <*> v .: "ttl"
        <*> v .: "units"
        <*> v .: "wind"

instance ToJSON Astronomy where
    toJSON (Astronomy sunriseAstronomy sunsetAstronomy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sunrise" .= sunriseAstronomy
        , Just $ "sunset" .= sunsetAstronomy
        ]

instance FromJSON Astronomy where
    parseJSON (Object v) = Astronomy
        <$> v .: "sunrise"
        <*> v .: "sunset"

instance ToJSON Atmosphere where
    toJSON (Atmosphere humidityAtmosphere pressureAtmosphere risingAtmosphere visibilityAtmosphere) =
        object $ foldMap (maybe [] pure)
        [ Just $ "humidity" .= humidityAtmosphere
        , Just $ "pressure" .= pressureAtmosphere
        , Just $ "rising" .= risingAtmosphere
        , Just $ "visibility" .= visibilityAtmosphere
        ]

instance FromJSON Atmosphere where
    parseJSON (Object v) = Atmosphere
        <$> v .: "humidity"
        <*> v .: "pressure"
        <*> v .: "rising"
        <*> v .: "visibility"

instance ToJSON Image where
    toJSON (Image heightImage linkImage titleImage urlImage widthImage) =
        object $ foldMap (maybe [] pure)
        [ Just $ "height" .= heightImage
        , Just $ "link" .= linkImage
        , Just $ "title" .= titleImage
        , Just $ "url" .= urlImage
        , Just $ "width" .= widthImage
        ]

instance FromJSON Image where
    parseJSON (Object v) = Image
        <$> v .: "height"
        <*> v .: "link"
        <*> v .: "title"
        <*> v .: "url"
        <*> v .: "width"

instance ToJSON Item where
    toJSON (Item conditionItem descriptionItem forecastItem guidItem latItem linkItem longItem pubDateItem titleItem) =
        object $ foldMap (maybe [] pure)
        [ Just $ "condition" .= conditionItem
        , Just $ "description" .= descriptionItem
        , Just $ "forecast" .= forecastItem
        , Just $ "guid" .= guidItem
        , Just $ "lat" .= latItem
        , Just $ "link" .= linkItem
        , Just $ "long" .= longItem
        , Just $ "pubDate" .= pubDateItem
        , Just $ "title" .= titleItem
        ]

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .: "condition"
        <*> v .: "description"
        <*> v .: "forecast"
        <*> v .: "guid"
        <*> v .: "lat"
        <*> v .: "link"
        <*> v .: "long"
        <*> v .: "pubDate"
        <*> v .: "title"

instance ToJSON Condition where
    toJSON (Condition codeCondition conditionTextCondition dateCondition tempCondition) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeCondition
        , Just $ "text" .= conditionTextCondition
        , Just $ "date" .= dateCondition
        , Just $ "temp" .= tempCondition
        ]

instance FromJSON Condition where
    parseJSON (Object v) = Condition
        <$> v .: "code"
        <*> v .: "text"
        <*> v .: "date"
        <*> v .: "temp"

instance ToJSON Forecast where
    toJSON (Forecast codeForecast dateForecast dayForecast forecastTextForecast highForecast lowForecast) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeForecast
        , Just $ "date" .= dateForecast
        , Just $ "day" .= dayForecast
        , Just $ "text" .= forecastTextForecast
        , Just $ "high" .= highForecast
        , Just $ "low" .= lowForecast
        ]

instance FromJSON Forecast where
    parseJSON (Object v) = Forecast
        <$> v .: "code"
        <*> v .: "date"
        <*> v .: "day"
        <*> v .: "text"
        <*> v .: "high"
        <*> v .: "low"

instance ToJSON TextEnum where
    toJSON ThunderstormsTextEnum = "Thunderstorms"

instance FromJSON TextEnum where
    parseJSON = withText "TextEnum" parseText
        where
            parseText "Thunderstorms" = return ThunderstormsTextEnum

instance ToJSON GUID where
    toJSON (GUID isPermaLinkGUID) =
        object $ foldMap (maybe [] pure)
        [ Just $ "isPermaLink" .= isPermaLinkGUID
        ]

instance FromJSON GUID where
    parseJSON (Object v) = GUID
        <$> v .: "isPermaLink"

instance ToJSON Location where
    toJSON (Location cityLocation countryLocation regionLocation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "city" .= cityLocation
        , Just $ "country" .= countryLocation
        , Just $ "region" .= regionLocation
        ]

instance FromJSON Location where
    parseJSON (Object v) = Location
        <$> v .: "city"
        <*> v .: "country"
        <*> v .: "region"

instance ToJSON Units where
    toJSON (Units distanceUnits pressureUnits speedUnits temperatureUnits) =
        object $ foldMap (maybe [] pure)
        [ Just $ "distance" .= distanceUnits
        , Just $ "pressure" .= pressureUnits
        , Just $ "speed" .= speedUnits
        , Just $ "temperature" .= temperatureUnits
        ]

instance FromJSON Units where
    parseJSON (Object v) = Units
        <$> v .: "distance"
        <*> v .: "pressure"
        <*> v .: "speed"
        <*> v .: "temperature"

instance ToJSON Wind where
    toJSON (Wind chillWind directionWind speedWind) =
        object $ foldMap (maybe [] pure)
        [ Just $ "chill" .= chillWind
        , Just $ "direction" .= directionWind
        , Just $ "speed" .= speedWind
        ]

instance FromJSON Wind where
    parseJSON (Object v) = Wind
        <$> v .: "chill"
        <*> v .: "direction"
        <*> v .: "speed"
