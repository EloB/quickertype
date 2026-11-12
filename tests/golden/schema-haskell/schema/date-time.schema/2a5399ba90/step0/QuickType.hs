{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , LocalDate (..)
    , OffsetDateTime (..)
    , OffsetTime (..)
    , ComplexUnionArray (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { complexUnionArrayQuickType :: [ComplexUnionArray]
    , dateQuickType :: Text
    , dateTimeQuickType :: Text
    , localDateClassQuickType :: Maybe LocalDate
    , offsetDateTimeClassQuickType :: Maybe OffsetDateTime
    , offsetTimeClassQuickType :: Maybe OffsetTime
    , timeQuickType :: Text
    , unionArrayQuickType :: [Text]
    } deriving (Show)

data ComplexUnionArray
    = IntegerInComplexUnionArray Int
    | StringInComplexUnionArray Text
    deriving (Show)

data LocalDate = LocalDate
    {
    } deriving (Show)

data OffsetDateTime = OffsetDateTime
    {
    } deriving (Show)

data OffsetTime = OffsetTime
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType complexUnionArrayQuickType dateQuickType dateTimeQuickType localDateClassQuickType offsetDateTimeClassQuickType offsetTimeClassQuickType timeQuickType unionArrayQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "complex-union-array" .= complexUnionArrayQuickType
        , Just $ "date" .= dateQuickType
        , Just $ "date-time" .= dateTimeQuickType
        , ("local-date-class" .=) <$> localDateClassQuickType
        , ("offset-date-time-class" .=) <$> offsetDateTimeClassQuickType
        , ("offset-time-class" .=) <$> offsetTimeClassQuickType
        , Just $ "time" .= timeQuickType
        , Just $ "union-array" .= unionArrayQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "complex-union-array"
        <*> v .: "date"
        <*> v .: "date-time"
        <*> v .:! "local-date-class"
        <*> v .:! "offset-date-time-class"
        <*> v .:! "offset-time-class"
        <*> v .: "time"
        <*> v .: "union-array"

instance ToJSON ComplexUnionArray where
    toJSON (IntegerInComplexUnionArray x) = toJSON x
    toJSON (StringInComplexUnionArray x) = toJSON x

instance FromJSON ComplexUnionArray where
    parseJSON xs@(Number _) = (fmap IntegerInComplexUnionArray . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInComplexUnionArray . parseJSON) xs

instance ToJSON LocalDate where
    toJSON = \_ -> emptyObject

instance FromJSON LocalDate where
    parseJSON (Object _) = return LocalDate

instance ToJSON OffsetDateTime where
    toJSON = \_ -> emptyObject

instance FromJSON OffsetDateTime where
    parseJSON (Object _) = return OffsetDateTime

instance ToJSON OffsetTime where
    toJSON = \_ -> emptyObject

instance FromJSON OffsetTime where
    parseJSON (Object _) = return OffsetTime
