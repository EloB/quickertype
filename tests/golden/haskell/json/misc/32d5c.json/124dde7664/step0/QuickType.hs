{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { birthDateQuickTypeElement :: Maybe Text
    , birthDateIsProtectedQuickTypeElement :: Bool
    , genderTypeIDQuickTypeElement :: Int
    , notesQuickTypeElement :: Text
    , parliamentaryNameQuickTypeElement :: Text
    , personIDQuickTypeElement :: Int
    , photoURLQuickTypeElement :: Text
    , preferredNameQuickTypeElement :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement birthDateQuickTypeElement birthDateIsProtectedQuickTypeElement genderTypeIDQuickTypeElement notesQuickTypeElement parliamentaryNameQuickTypeElement personIDQuickTypeElement photoURLQuickTypeElement preferredNameQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "BirthDate" .= birthDateQuickTypeElement
        , Just $ "BirthDateIsProtected" .= birthDateIsProtectedQuickTypeElement
        , Just $ "GenderTypeID" .= genderTypeIDQuickTypeElement
        , Just $ "Notes" .= notesQuickTypeElement
        , Just $ "ParliamentaryName" .= parliamentaryNameQuickTypeElement
        , Just $ "PersonID" .= personIDQuickTypeElement
        , Just $ "PhotoURL" .= photoURLQuickTypeElement
        , Just $ "PreferredName" .= preferredNameQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "BirthDate"
        <*> v .: "BirthDateIsProtected"
        <*> v .: "GenderTypeID"
        <*> v .: "Notes"
        <*> v .: "ParliamentaryName"
        <*> v .: "PersonID"
        <*> v .: "PhotoURL"
        <*> v .: "PreferredName"
