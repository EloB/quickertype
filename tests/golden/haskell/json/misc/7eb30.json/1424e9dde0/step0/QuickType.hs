{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ResultElement (..)
    , Group (..)
    , Code (..)
    , English (..)
    , Thai (..)
    , Location (..)
    , Tel (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { countQuickType :: Int
    , nextQuickType :: Text
    , previousQuickType :: Maybe Text
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data ResultElement = ResultElement
    { codeResultElement :: Text
    , englishResultElement :: Text
    , favResultElement :: Bool
    , groupResultElement :: Group
    , locationResultElement :: Location
    , minScreensResultElement :: Int
    , numViewsResultElement :: Int
    , showtimesResultElement :: Text
    , starsResultElement :: Int
    , telResultElement :: Tel
    , thaiResultElement :: Text
    , todayScreensResultElement :: Int
    , urlResultElement :: Text
    , websiteResultElement :: Text
    } deriving (Show)

data Group = Group
    { codeGroup :: Code
    , englishGroup :: English
    , thaiGroup :: Thai
    , websiteGroup :: Text
    } deriving (Show)

data Code
    = SfCode
    deriving (Show)

data English
    = SFEnglish
    deriving (Show)

data Thai
    = _Thai
    deriving (Show)

data Location
    = PurpleLocation
    | The5ThFLEmporiumLocation
    deriving (Show)

data Tel
    = PurpleTel
    | The022688899_Tel
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType countQuickType nextQuickType previousQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countQuickType
        , Just $ "next" .= nextQuickType
        , Just $ "previous" .= previousQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "count"
        <*> v .: "next"
        <*> v .: "previous"
        <*> v .: "results"

instance ToJSON ResultElement where
    toJSON (ResultElement codeResultElement englishResultElement favResultElement groupResultElement locationResultElement minScreensResultElement numViewsResultElement showtimesResultElement starsResultElement telResultElement thaiResultElement todayScreensResultElement urlResultElement websiteResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeResultElement
        , Just $ "english" .= englishResultElement
        , Just $ "fav" .= favResultElement
        , Just $ "group" .= groupResultElement
        , Just $ "location" .= locationResultElement
        , Just $ "min_screens" .= minScreensResultElement
        , Just $ "num_views" .= numViewsResultElement
        , Just $ "showtimes" .= showtimesResultElement
        , Just $ "stars" .= starsResultElement
        , Just $ "tel" .= telResultElement
        , Just $ "thai" .= thaiResultElement
        , Just $ "today_screens" .= todayScreensResultElement
        , Just $ "url" .= urlResultElement
        , Just $ "website" .= websiteResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "code"
        <*> v .: "english"
        <*> v .: "fav"
        <*> v .: "group"
        <*> v .: "location"
        <*> v .: "min_screens"
        <*> v .: "num_views"
        <*> v .: "showtimes"
        <*> v .: "stars"
        <*> v .: "tel"
        <*> v .: "thai"
        <*> v .: "today_screens"
        <*> v .: "url"
        <*> v .: "website"

instance ToJSON Group where
    toJSON (Group codeGroup englishGroup thaiGroup websiteGroup) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeGroup
        , Just $ "english" .= englishGroup
        , Just $ "thai" .= thaiGroup
        , Just $ "website" .= websiteGroup
        ]

instance FromJSON Group where
    parseJSON (Object v) = Group
        <$> v .: "code"
        <*> v .: "english"
        <*> v .: "thai"
        <*> v .: "website"

instance ToJSON Code where
    toJSON SfCode = "sf"

instance FromJSON Code where
    parseJSON = withText "Code" parseText
        where
            parseText "sf" = return SfCode

instance ToJSON English where
    toJSON SFEnglish = "SF"

instance FromJSON English where
    parseJSON = withText "English" parseText
        where
            parseText "SF" = return SFEnglish

instance ToJSON Thai where
    toJSON _Thai = "เอสเอฟ"

instance FromJSON Thai where
    parseJSON = withText "Thai" parseText
        where
            parseText "เอสเอฟ" = return _Thai

instance ToJSON Location where
    toJSON PurpleLocation = ""
    toJSON The5ThFLEmporiumLocation = "5th Fl. Emporium"

instance FromJSON Location where
    parseJSON = withText "Location" parseText
        where
            parseText "" = return PurpleLocation
            parseText "5th Fl. Emporium" = return The5ThFLEmporiumLocation

instance ToJSON Tel where
    toJSON PurpleTel = ""
    toJSON The022688899_Tel = "02-268-8899"

instance FromJSON Tel where
    parseJSON = withText "Tel" parseText
        where
            parseText "" = return PurpleTel
            parseText "02-268-8899" = return The022688899_Tel
