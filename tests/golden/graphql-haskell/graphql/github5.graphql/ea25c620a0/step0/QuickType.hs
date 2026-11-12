{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , User (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { testDataQuickType :: Maybe Data
    , errorsQuickType :: Maybe ([ErrorElement])
    } deriving (Show)

data ErrorElement = ErrorElement
    { messageErrorElement :: Text
    } deriving (Show)

data Data = Data
    { viewerData :: User
    } deriving (Show)

data User = User
    { loginUser :: Text
    , nameUser :: Maybe (Maybe Text)
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType testDataQuickType errorsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= testDataQuickType
        , ("errors" .=) <$> errorsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "data"
        <*> v .:! "errors"

instance ToJSON ErrorElement where
    toJSON (ErrorElement messageErrorElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageErrorElement
        ]

instance FromJSON ErrorElement where
    parseJSON (Object v) = ErrorElement
        <$> v .: "message"

instance ToJSON Data where
    toJSON (Data viewerData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "viewer" .= viewerData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .: "viewer"

instance ToJSON User where
    toJSON (User loginUser nameUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "login" .= loginUser
        , ("name" .=) <$> nameUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "login"
        <*> v .:! "name"
