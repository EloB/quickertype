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
    { myPropertyQuickType :: Maybe Text
    , secondPropertyQuickType :: Maybe Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType myPropertyQuickType secondPropertyQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("myProperty" .=) <$> myPropertyQuickType
        , ("secondProperty" .=) <$> secondPropertyQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "myProperty"
        <*> v .:! "secondProperty"
