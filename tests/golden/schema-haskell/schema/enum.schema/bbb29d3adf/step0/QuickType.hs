{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , OtherArr (..)
    , Gve (..)
    , Lvc (..)
    , Arr (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { arrQuickType :: Maybe ([Arr])
    , forQuickType :: Maybe Text
    , gveQuickType :: Gve
    , lvcQuickType :: Maybe Lvc
    , otherArrQuickType :: Maybe ([OtherArr])
    } deriving (Show)

data Arr
    = EnumInArr OtherArr
    | IntegerInArr Int
    deriving (Show)

data OtherArr
    = FooOtherArr
    | BarOtherArr
    | IfOtherArr
    deriving (Show)

data Gve
    = GoodGve
    | NeutralGve
    | EvilGve
    deriving (Show)

data Lvc
    = LawfulLvc
    | NeutralLvc
    | ChaoticLvc
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType arrQuickType forQuickType gveQuickType lvcQuickType otherArrQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("arr" .=) <$> arrQuickType
        , ("for" .=) <$> forQuickType
        , Just $ "gve" .= gveQuickType
        , ("lvc" .=) <$> lvcQuickType
        , ("otherArr" .=) <$> otherArrQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "arr"
        <*> v .:! "for"
        <*> v .: "gve"
        <*> v .:! "lvc"
        <*> v .:! "otherArr"

instance ToJSON Arr where
    toJSON (EnumInArr x) = toJSON x
    toJSON (IntegerInArr x) = toJSON x

instance FromJSON Arr where
    parseJSON xs@(String _) = (fmap EnumInArr . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInArr . parseJSON) xs

instance ToJSON OtherArr where
    toJSON FooOtherArr = "foo"
    toJSON BarOtherArr = "bar"
    toJSON IfOtherArr = "if"

instance FromJSON OtherArr where
    parseJSON = withText "OtherArr" parseText
        where
            parseText "foo" = return FooOtherArr
            parseText "bar" = return BarOtherArr
            parseText "if" = return IfOtherArr

instance ToJSON Gve where
    toJSON GoodGve = "good"
    toJSON NeutralGve = "neutral"
    toJSON EvilGve = "evil"

instance FromJSON Gve where
    parseJSON = withText "Gve" parseText
        where
            parseText "good" = return GoodGve
            parseText "neutral" = return NeutralGve
            parseText "evil" = return EvilGve

instance ToJSON Lvc where
    toJSON LawfulLvc = "lawful"
    toJSON NeutralLvc = "neutral"
    toJSON ChaoticLvc = "chaotic"

instance FromJSON Lvc where
    parseJSON = withText "Lvc" parseText
        where
            parseText "lawful" = return LawfulLvc
            parseText "neutral" = return NeutralLvc
            parseText "chaotic" = return ChaoticLvc
