{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Hints (..)
    , Labels (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { hintsQuickType :: Hints
    , labelsQuickType :: Labels
    } deriving (Show)

data Hints = Hints
    {
    } deriving (Show)

data Labels = Labels
    { accountNumberLabels :: Text
    , titleLabels :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType hintsQuickType labelsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Hints" .= hintsQuickType
        , Just $ "Labels" .= labelsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "Hints"
        <*> v .: "Labels"

instance ToJSON Hints where
    toJSON = \_ -> emptyObject

instance FromJSON Hints where
    parseJSON (Object _) = return Hints

instance ToJSON Labels where
    toJSON (Labels accountNumberLabels titleLabels) =
        object $ foldMap (maybe [] pure)
        [ Just $ "AccountNumber" .= accountNumberLabels
        , Just $ "Title" .= titleLabels
        ]

instance FromJSON Labels where
    parseJSON (Object v) = Labels
        <$> v .: "AccountNumber"
        <*> v .: "Title"
