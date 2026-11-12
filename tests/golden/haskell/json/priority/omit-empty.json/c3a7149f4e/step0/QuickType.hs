{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ResultElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { resultsQuickType :: [ResultElement]
    } deriving (Show)

data ResultElement = ResultElement
    { ageResultElement :: Int
    , nameResultElement :: Maybe (Maybe Text)
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "results"

instance ToJSON ResultElement where
    toJSON (ResultElement ageResultElement nameResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "age" .= ageResultElement
        , ("name" .=) <$> nameResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "age"
        <*> v .:! "name"
