{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , StateElement (..)
    , StateState (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { statesQuickType :: [StateElement]
    } deriving (Show)

data StateElement = StateElement
    { stateStateElement :: StateState
    } deriving (Show)

data StateState = StateState
    { stateIDStateState :: Text
    , stateNameStateState :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType statesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "states" .= statesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "states"

instance ToJSON StateElement where
    toJSON (StateElement stateStateElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "state" .= stateStateElement
        ]

instance FromJSON StateElement where
    parseJSON (Object v) = StateElement
        <$> v .: "state"

instance ToJSON StateState where
    toJSON (StateState stateIDStateState stateNameStateState) =
        object $ foldMap (maybe [] pure)
        [ Just $ "state_id" .= stateIDStateState
        , Just $ "state_name" .= stateNameStateState
        ]

instance FromJSON StateState where
    parseJSON (Object v) = StateState
        <$> v .: "state_id"
        <*> v .: "state_name"
