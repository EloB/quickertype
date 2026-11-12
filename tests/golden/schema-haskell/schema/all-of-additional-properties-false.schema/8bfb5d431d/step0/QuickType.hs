{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Frequency (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { amountQuickType :: Double
    , frequencyQuickType :: Frequency
    , descriptionQuickType :: Maybe Text
    , quickTypeTypeQuickType :: Type
    } deriving (Show)

data Frequency
    = WeeklyFrequency
    | MonthlyFrequency
    | AnnuallyFrequency
    deriving (Show)

data Type
    = GrossSalaryAmountType
    | OvertimeType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType amountQuickType frequencyQuickType descriptionQuickType quickTypeTypeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "amount" .= amountQuickType
        , Just $ "frequency" .= frequencyQuickType
        , ("description" .=) <$> descriptionQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "amount"
        <*> v .: "frequency"
        <*> v .:! "description"
        <*> v .: "type"

instance ToJSON Frequency where
    toJSON WeeklyFrequency = "Weekly"
    toJSON MonthlyFrequency = "Monthly"
    toJSON AnnuallyFrequency = "Annually"

instance FromJSON Frequency where
    parseJSON = withText "Frequency" parseText
        where
            parseText "Weekly" = return WeeklyFrequency
            parseText "Monthly" = return MonthlyFrequency
            parseText "Annually" = return AnnuallyFrequency

instance ToJSON Type where
    toJSON GrossSalaryAmountType = "GrossSalaryAmount"
    toJSON OvertimeType = "Overtime"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "GrossSalaryAmount" = return GrossSalaryAmountType
            parseText "Overtime" = return OvertimeType
