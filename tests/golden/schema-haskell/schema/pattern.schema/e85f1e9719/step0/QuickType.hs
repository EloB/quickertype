{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , RegExp (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { pattern1QuickType :: Text
    , pattern2QuickType :: Text
    , regExpQuickType :: Maybe RegExp
    , unionQuickType :: Text
    } deriving (Show)

data RegExp = RegExp
    { pattern3RegExp :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType pattern1QuickType pattern2QuickType regExpQuickType unionQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pattern1" .= pattern1QuickType
        , Just $ "pattern2" .= pattern2QuickType
        , ("RegExp" .=) <$> regExpQuickType
        , Just $ "union" .= unionQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "pattern1"
        <*> v .: "pattern2"
        <*> v .:! "RegExp"
        <*> v .: "union"

instance ToJSON RegExp where
    toJSON (RegExp pattern3RegExp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pattern3" .= pattern3RegExp
        ]

instance FromJSON RegExp where
    parseJSON (Object v) = RegExp
        <$> v .: "pattern3"
