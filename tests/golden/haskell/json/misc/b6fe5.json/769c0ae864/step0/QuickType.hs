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
    { groupQuickType :: Text
    , movieQuickType :: Text
    , movieImageQuickType :: Text
    , theaterQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType groupQuickType movieQuickType movieImageQuickType theaterQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "group" .= groupQuickType
        , Just $ "movie" .= movieQuickType
        , Just $ "movie-image" .= movieImageQuickType
        , Just $ "theater" .= theaterQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "group"
        <*> v .: "movie"
        <*> v .: "movie-image"
        <*> v .: "theater"
