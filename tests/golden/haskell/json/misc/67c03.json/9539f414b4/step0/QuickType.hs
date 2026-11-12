{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Person (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { messageQuickType :: Text
    , numberQuickType :: Int
    , peopleQuickType :: [Person]
    } deriving (Show)

data Person = Person
    { craftPerson :: Text
    , namePerson :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType messageQuickType numberQuickType peopleQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageQuickType
        , Just $ "number" .= numberQuickType
        , Just $ "people" .= peopleQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "message"
        <*> v .: "number"
        <*> v .: "people"

instance ToJSON Person where
    toJSON (Person craftPerson namePerson) =
        object $ foldMap (maybe [] pure)
        [ Just $ "craft" .= craftPerson
        , Just $ "name" .= namePerson
        ]

instance FromJSON Person where
    parseJSON (Object v) = Person
        <$> v .: "craft"
        <*> v .: "name"
