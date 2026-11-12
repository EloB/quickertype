{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ArrayNode (..)
    , BooleanNode (..)
    , DoubleNode (..)
    , IntNode (..)
    , LongNode (..)
    , NullNode (..)
    , ObjectNode (..)
    , Thing (..)
    , TextNode (..)
    , Anything (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { arrayNodeQuickType :: Maybe ArrayNode
    , booleanNodeQuickType :: Maybe BooleanNode
    , doubleNodeQuickType :: Maybe DoubleNode
    , intNodeQuickType :: Maybe IntNode
    , longNodeQuickType :: Maybe LongNode
    , nullNodeQuickType :: Maybe NullNode
    , objectNodeQuickType :: Maybe ObjectNode
    , stuffQuickType :: HashMap Text Thing
    , textNodeQuickType :: Maybe TextNode
    } deriving (Show)

data ArrayNode = ArrayNode
    {
    } deriving (Show)

data BooleanNode = BooleanNode
    {
    } deriving (Show)

data DoubleNode = DoubleNode
    {
    } deriving (Show)

data IntNode = IntNode
    {
    } deriving (Show)

data LongNode = LongNode
    {
    } deriving (Show)

data NullNode = NullNode
    {
    } deriving (Show)

data ObjectNode = ObjectNode
    {
    } deriving (Show)

data Thing = Thing
    { optionalThing :: Maybe Anything
    , requiredThing :: Anything
    } deriving (Show)

data Anything
    = AnythingArrayInAnything ([Value])
    | AnythingMapInAnything (HashMap Text Value)
    | BoolInAnything Bool
    | DoubleInAnything Double
    | IntegerInAnything Int
    | NullInAnything
    | StringInAnything Text
    deriving (Show)

data TextNode = TextNode
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType arrayNodeQuickType booleanNodeQuickType doubleNodeQuickType intNodeQuickType longNodeQuickType nullNodeQuickType objectNodeQuickType stuffQuickType textNodeQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("arrayNode" .=) <$> arrayNodeQuickType
        , ("booleanNode" .=) <$> booleanNodeQuickType
        , ("doubleNode" .=) <$> doubleNodeQuickType
        , ("intNode" .=) <$> intNodeQuickType
        , ("longNode" .=) <$> longNodeQuickType
        , ("nullNode" .=) <$> nullNodeQuickType
        , ("objectNode" .=) <$> objectNodeQuickType
        , Just $ "stuff" .= stuffQuickType
        , ("textNode" .=) <$> textNodeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "arrayNode"
        <*> v .:! "booleanNode"
        <*> v .:! "doubleNode"
        <*> v .:! "intNode"
        <*> v .:! "longNode"
        <*> v .:! "nullNode"
        <*> v .:! "objectNode"
        <*> v .: "stuff"
        <*> v .:! "textNode"

instance ToJSON ArrayNode where
    toJSON = \_ -> emptyObject

instance FromJSON ArrayNode where
    parseJSON (Object _) = return ArrayNode

instance ToJSON BooleanNode where
    toJSON = \_ -> emptyObject

instance FromJSON BooleanNode where
    parseJSON (Object _) = return BooleanNode

instance ToJSON DoubleNode where
    toJSON = \_ -> emptyObject

instance FromJSON DoubleNode where
    parseJSON (Object _) = return DoubleNode

instance ToJSON IntNode where
    toJSON = \_ -> emptyObject

instance FromJSON IntNode where
    parseJSON (Object _) = return IntNode

instance ToJSON LongNode where
    toJSON = \_ -> emptyObject

instance FromJSON LongNode where
    parseJSON (Object _) = return LongNode

instance ToJSON NullNode where
    toJSON = \_ -> emptyObject

instance FromJSON NullNode where
    parseJSON (Object _) = return NullNode

instance ToJSON ObjectNode where
    toJSON = \_ -> emptyObject

instance FromJSON ObjectNode where
    parseJSON (Object _) = return ObjectNode

instance ToJSON Thing where
    toJSON (Thing optionalThing requiredThing) =
        object $ foldMap (maybe [] pure)
        [ ("optional" .=) <$> optionalThing
        , Just $ "required" .= requiredThing
        ]

instance FromJSON Thing where
    parseJSON (Object v) = Thing
        <$> v .:! "optional"
        <*> v .: "required"

instance ToJSON Anything where
    toJSON (AnythingArrayInAnything x) = toJSON x
    toJSON (AnythingMapInAnything x) = toJSON x
    toJSON (BoolInAnything x) = toJSON x
    toJSON (DoubleInAnything x) = toJSON x
    toJSON (IntegerInAnything x) = toJSON x
    toJSON NullInAnything = Null
    toJSON (StringInAnything x) = toJSON x

instance FromJSON Anything where
    parseJSON xs@(Array _) = (fmap AnythingArrayInAnything . parseJSON) xs
    parseJSON xs@(Object _) = (fmap AnythingMapInAnything . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInAnything . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInAnything . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInAnything . parseJSON) xs
    parseJSON Null = return NullInAnything
    parseJSON xs@(String _) = (fmap StringInAnything . parseJSON) xs

instance ToJSON TextNode where
    toJSON = \_ -> emptyObject

instance FromJSON TextNode where
    parseJSON (Object _) = return TextNode
