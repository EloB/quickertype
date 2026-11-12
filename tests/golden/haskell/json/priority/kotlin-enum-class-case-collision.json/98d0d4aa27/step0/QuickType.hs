{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Category (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { categoryQuickTypeElement :: Category
    } deriving (Show)

data Category
    = PurpleCategory
    | FluffyCategory
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement categoryQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "category" .= categoryQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "category"

instance ToJSON Category where
    toJSON PurpleCategory = " "
    toJSON FluffyCategory = ""

instance FromJSON Category where
    parseJSON = withText "Category" parseText
        where
            parseText " " = return PurpleCategory
            parseText "" = return FluffyCategory
