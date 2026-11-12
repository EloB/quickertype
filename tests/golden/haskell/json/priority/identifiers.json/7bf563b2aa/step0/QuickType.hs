{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeBla (..)
    , Empty (..)
    , Foo (..)
    , FooBla (..)
    , EmptyClass (..)
    , ThisIsAToughOne (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { blaQuickType :: QuickTypeBla
    , emptyQuickType :: Empty
    , fooQuickType :: Foo
    , quickTypeQuickType :: Int
    , quickTypeEmptyQuickType :: EmptyClass
    , thisIsAToughOneQuickType :: ThisIsAToughOne
    } deriving (Show)

data QuickTypeBla = QuickTypeBla
    { barQuickTypeBla :: Int
    } deriving (Show)

data Empty = Empty
    { xEmpty :: Int
    } deriving (Show)

data Foo = Foo
    { blaFoo :: FooBla
    , emptyFoo :: Int
    , fooFoo :: Int
    } deriving (Show)

data FooBla = FooBla
    {
    } deriving (Show)

data EmptyClass = EmptyClass
    { yEmptyClass :: Int
    } deriving (Show)

data ThisIsAToughOne = ThisIsAToughOne
    { emptyThisIsAToughOne :: Int
    , thisIsAToughOneThisIsAToughOne :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType blaQuickType emptyQuickType fooQuickType quickTypeQuickType quickTypeEmptyQuickType thisIsAToughOneQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bla" .= blaQuickType
        , Just $ "" .= emptyQuickType
        , Just $ "foo" .= fooQuickType
        , Just $ "!" .= quickTypeQuickType
        , Just $ "Empty" .= quickTypeEmptyQuickType
        , Just $ "ThisIsA\x0001f61c\&Tough\"\n\nOne" .= thisIsAToughOneQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "bla"
        <*> v .: ""
        <*> v .: "foo"
        <*> v .: "!"
        <*> v .: "Empty"
        <*> v .: "ThisIsA\x0001f61c\&Tough\"\n\nOne"

instance ToJSON QuickTypeBla where
    toJSON (QuickTypeBla barQuickTypeBla) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bar" .= barQuickTypeBla
        ]

instance FromJSON QuickTypeBla where
    parseJSON (Object v) = QuickTypeBla
        <$> v .: "bar"

instance ToJSON Empty where
    toJSON (Empty xEmpty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "x" .= xEmpty
        ]

instance FromJSON Empty where
    parseJSON (Object v) = Empty
        <$> v .: "x"

instance ToJSON Foo where
    toJSON (Foo blaFoo emptyFoo fooFoo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bla" .= blaFoo
        , Just $ "_" .= emptyFoo
        , Just $ "__" .= fooFoo
        ]

instance FromJSON Foo where
    parseJSON (Object v) = Foo
        <$> v .: "bla"
        <*> v .: "_"
        <*> v .: "__"

instance ToJSON FooBla where
    toJSON = \_ -> emptyObject

instance FromJSON FooBla where
    parseJSON (Object _) = return FooBla

instance ToJSON EmptyClass where
    toJSON (EmptyClass yEmptyClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "y" .= yEmptyClass
        ]

instance FromJSON EmptyClass where
    parseJSON (Object v) = EmptyClass
        <$> v .: "y"

instance ToJSON ThisIsAToughOne where
    toJSON (ThisIsAToughOne emptyThisIsAToughOne thisIsAToughOneThisIsAToughOne) =
        object $ foldMap (maybe [] pure)
        [ Just $ "\n\n\n" .= emptyThisIsAToughOne
        , Just $ "\"" .= thisIsAToughOneThisIsAToughOne
        ]

instance FromJSON ThisIsAToughOne where
    parseJSON (Object v) = ThisIsAToughOne
        <$> v .: "\n\n\n"
        <*> v .: "\""
