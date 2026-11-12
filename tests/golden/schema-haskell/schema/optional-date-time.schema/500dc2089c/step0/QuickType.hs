{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { optionalDateQuickType :: Maybe Text
    , optionalDateTimeQuickType :: Maybe Text
    , optionalTimeQuickType :: Maybe Text
    , requiredDateQuickType :: Text
    , requiredDateTimeQuickType :: Text
    , requiredTimeQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType optionalDateQuickType optionalDateTimeQuickType optionalTimeQuickType requiredDateQuickType requiredDateTimeQuickType requiredTimeQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("optional-date" .=) <$> optionalDateQuickType
        , ("optional-date-time" .=) <$> optionalDateTimeQuickType
        , ("optional-time" .=) <$> optionalTimeQuickType
        , Just $ "required-date" .= requiredDateQuickType
        , Just $ "required-date-time" .= requiredDateTimeQuickType
        , Just $ "required-time" .= requiredTimeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "optional-date"
        <*> v .:! "optional-date-time"
        <*> v .:! "optional-time"
        <*> v .: "required-date"
        <*> v .: "required-date-time"
        <*> v .: "required-time"
