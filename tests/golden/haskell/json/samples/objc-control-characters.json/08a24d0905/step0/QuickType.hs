{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ValueElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { literalQuickType :: Text
    , the11QuickType :: Int
    , valuesQuickType :: [ValueElement]
    } deriving (Show)

data ValueElement
    = C0ValueElement
    | C1ValueElement
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType literalQuickType the11QuickType valuesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "literal" .= literalQuickType
        , Just $ "#{1+1}" .= the11QuickType
        , Just $ "values" .= valuesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "literal"
        <*> v .: "#{1+1}"
        <*> v .: "values"

instance ToJSON ValueElement where
    toJSON C0ValueElement = "c0\x0001\&\x001b\&\x001f\&"
    toJSON C1ValueElement = "c1\x007f\&\x0080\&\x0085\&\x009f\&"

instance FromJSON ValueElement where
    parseJSON = withText "ValueElement" parseText
        where
            parseText "c0\x0001\&\x001b\&\x001f\&" = return C0ValueElement
            parseText "c1\x007f\&\x0080\&\x0085\&\x009f\&" = return C1ValueElement
