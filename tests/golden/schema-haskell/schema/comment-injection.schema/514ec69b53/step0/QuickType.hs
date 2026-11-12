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

{-| Comment delimiters:
*/
/*
{ -
- }
"""
</summary> & <br>
}
}
}
}
}

trailingBackslash:
Ends with a backslash \

trailingQuote:
Ends with a quote "

trailingTripleQuote:
Ends with a triple quote """

value:
Property delimiters:
*/
/*
{ -
- }
"""
</summary> & <br>
}
}
}
}
}
-}
data QuickType = QuickType
    { trailingBackslashQuickType :: Maybe Text
    , trailingQuoteQuickType :: Maybe Text
    , trailingTripleQuoteQuickType :: Maybe Text
    , valueQuickType :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType trailingBackslashQuickType trailingQuoteQuickType trailingTripleQuoteQuickType valueQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("trailingBackslash" .=) <$> trailingBackslashQuickType
        , ("trailingQuote" .=) <$> trailingQuoteQuickType
        , ("trailingTripleQuote" .=) <$> trailingTripleQuoteQuickType
        , Just $ "value" .= valueQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "trailingBackslash"
        <*> v .:! "trailingQuote"
        <*> v .:! "trailingTripleQuote"
        <*> v .: "value"
