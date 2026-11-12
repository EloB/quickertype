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
    { anEasyOneQuickType :: Int
    , isMNISTLetterQuickType :: Bool
    , jsonStringQuickType :: Text
    , prettyEasyTooQuickType :: Bool
    , shouldKnowThatIDIsAnInitialismQuickType :: Text
    , spacesAreSeparatorsTooQuickType :: Bool
    , zsrHhDemo3DelmatnrQuickType :: Bool
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType anEasyOneQuickType isMNISTLetterQuickType jsonStringQuickType prettyEasyTooQuickType shouldKnowThatIDIsAnInitialismQuickType spacesAreSeparatorsTooQuickType zsrHhDemo3DelmatnrQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "anEasyOne" .= anEasyOneQuickType
        , Just $ "isMNISTLetter" .= isMNISTLetterQuickType
        , Just $ "JSONString" .= jsonStringQuickType
        , Just $ "PrettyEasyToo" .= prettyEasyTooQuickType
        , Just $ "should_know_that_id_is_an_initialism" .= shouldKnowThatIDIsAnInitialismQuickType
        , Just $ "   spaces are separators  too  " .= spacesAreSeparatorsTooQuickType
        , Just $ "ZSR_HH_DEMO3_DELMATNR" .= zsrHhDemo3DelmatnrQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "anEasyOne"
        <*> v .: "isMNISTLetter"
        <*> v .: "JSONString"
        <*> v .: "PrettyEasyToo"
        <*> v .: "should_know_that_id_is_an_initialism"
        <*> v .: "   spaces are separators  too  "
        <*> v .: "ZSR_HH_DEMO3_DELMATNR"
