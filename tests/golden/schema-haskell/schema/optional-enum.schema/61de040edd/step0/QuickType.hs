{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Shortcut (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { nameQuickType :: Text
    , shortcutQuickType :: Maybe Shortcut
    } deriving (Show)

data Shortcut
    = HiddenShortcut
    | VisibleShortcut
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType nameQuickType shortcutQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameQuickType
        , ("shortcut" .=) <$> shortcutQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "name"
        <*> v .:! "shortcut"

instance ToJSON Shortcut where
    toJSON HiddenShortcut = "hidden"
    toJSON VisibleShortcut = "visible"

instance FromJSON Shortcut where
    parseJSON = withText "Shortcut" parseText
        where
            parseText "hidden" = return HiddenShortcut
            parseText "visible" = return VisibleShortcut
