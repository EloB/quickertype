{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , TextClassificationOutputElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [TextClassificationOutputElement]

data TextClassificationOutputElement = TextClassificationOutputElement
    { labelTextClassificationOutputElement :: Text
    , scoreTextClassificationOutputElement :: Double
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON TextClassificationOutputElement where
    toJSON (TextClassificationOutputElement labelTextClassificationOutputElement scoreTextClassificationOutputElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "label" .= labelTextClassificationOutputElement
        , Just $ "score" .= scoreTextClassificationOutputElement
        ]

instance FromJSON TextClassificationOutputElement where
    parseJSON (Object v) = TextClassificationOutputElement
        <$> v .: "label"
        <*> v .: "score"
