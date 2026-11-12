{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Results (..)
    , SeriesElement (..)
    , Datum (..)
    , Footnote (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { messageQuickType :: [Value]
    , responseTimeQuickType :: Int
    , resultsQuickType :: Results
    , statusQuickType :: Text
    } deriving (Show)

data Results = Results
    { seriesResults :: [SeriesElement]
    } deriving (Show)

data SeriesElement = SeriesElement
    { seriesDataSeriesElement :: [Datum]
    , seriesIDSeriesElement :: Text
    } deriving (Show)

data Datum = Datum
    { footnotesDatum :: [Footnote]
    , periodDatum :: Text
    , periodNameDatum :: Text
    , valueDatum :: Text
    , yearDatum :: Text
    } deriving (Show)

data Footnote = Footnote
    { codeFootnote :: Maybe Text
    , footnoteTextFootnote :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType messageQuickType responseTimeQuickType resultsQuickType statusQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageQuickType
        , Just $ "responseTime" .= responseTimeQuickType
        , Just $ "Results" .= resultsQuickType
        , Just $ "status" .= statusQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "message"
        <*> v .: "responseTime"
        <*> v .: "Results"
        <*> v .: "status"

instance ToJSON Results where
    toJSON (Results seriesResults) =
        object $ foldMap (maybe [] pure)
        [ Just $ "series" .= seriesResults
        ]

instance FromJSON Results where
    parseJSON (Object v) = Results
        <$> v .: "series"

instance ToJSON SeriesElement where
    toJSON (SeriesElement seriesDataSeriesElement seriesIDSeriesElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= seriesDataSeriesElement
        , Just $ "seriesID" .= seriesIDSeriesElement
        ]

instance FromJSON SeriesElement where
    parseJSON (Object v) = SeriesElement
        <$> v .: "data"
        <*> v .: "seriesID"

instance ToJSON Datum where
    toJSON (Datum footnotesDatum periodDatum periodNameDatum valueDatum yearDatum) =
        object $ foldMap (maybe [] pure)
        [ Just $ "footnotes" .= footnotesDatum
        , Just $ "period" .= periodDatum
        , Just $ "periodName" .= periodNameDatum
        , Just $ "value" .= valueDatum
        , Just $ "year" .= yearDatum
        ]

instance FromJSON Datum where
    parseJSON (Object v) = Datum
        <$> v .: "footnotes"
        <*> v .: "period"
        <*> v .: "periodName"
        <*> v .: "value"
        <*> v .: "year"

instance ToJSON Footnote where
    toJSON (Footnote codeFootnote footnoteTextFootnote) =
        object $ foldMap (maybe [] pure)
        [ ("code" .=) <$> codeFootnote
        , ("text" .=) <$> footnoteTextFootnote
        ]

instance FromJSON Footnote where
    parseJSON (Object v) = Footnote
        <$> v .:! "code"
        <*> v .:! "text"
