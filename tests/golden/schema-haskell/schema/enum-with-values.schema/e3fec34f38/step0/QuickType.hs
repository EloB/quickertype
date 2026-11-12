{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Weekdays (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { weekdaysQuickType :: Weekdays
    } deriving (Show)

data Weekdays
    = MondayWeekdays
    | TuesdayWeekdays
    | WednesdayWeekdays
    | ThursdayWeekdays
    | FridayWeekdays
    | SaturdayWeekdays
    | SundayWeekdays
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType weekdaysQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "weekdays" .= weekdaysQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "weekdays"

instance ToJSON Weekdays where
    toJSON MondayWeekdays = "Monday"
    toJSON TuesdayWeekdays = "Tuesday"
    toJSON WednesdayWeekdays = "Wednesday"
    toJSON ThursdayWeekdays = "Thursday"
    toJSON FridayWeekdays = "Friday"
    toJSON SaturdayWeekdays = "Saturday"
    toJSON SundayWeekdays = "Sunday"

instance FromJSON Weekdays where
    parseJSON = withText "Weekdays" parseText
        where
            parseText "Monday" = return MondayWeekdays
            parseText "Tuesday" = return TuesdayWeekdays
            parseText "Wednesday" = return WednesdayWeekdays
            parseText "Thursday" = return ThursdayWeekdays
            parseText "Friday" = return FridayWeekdays
            parseText "Saturday" = return SaturdayWeekdays
            parseText "Sunday" = return SundayWeekdays
