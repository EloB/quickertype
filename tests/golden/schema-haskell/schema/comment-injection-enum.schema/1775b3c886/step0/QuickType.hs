{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Kind (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

{-| kind:
Comment delimiters:
*/
{ -
- }
"""
}
}
-}
data QuickType = QuickType
    { kindQuickType :: Kind
    } deriving (Show)

{-| Comment delimiters:
*/
{ -
- }
"""
}
}
-}
data Kind
    = OkKind
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType kindQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "kind" .= kindQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "kind"

instance ToJSON Kind where
    toJSON OkKind = "ok"

instance FromJSON Kind where
    parseJSON = withText "Kind" parseText
        where
            parseText "ok" = return OkKind
