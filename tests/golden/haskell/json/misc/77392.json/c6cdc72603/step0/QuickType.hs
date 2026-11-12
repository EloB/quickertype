{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , OrbitClass (..)
    , Pha (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { designationQuickTypeElement :: Text
    , discoveryDateQuickTypeElement :: Text
    , hMagQuickTypeElement :: Maybe Text
    , iDegQuickTypeElement :: Text
    , moidAuQuickTypeElement :: Text
    , orbitClassQuickTypeElement :: OrbitClass
    , periodYrQuickTypeElement :: Maybe Text
    , phaQuickTypeElement :: Pha
    , qAu1QuickTypeElement :: Text
    , qAu2QuickTypeElement :: Maybe Text
    } deriving (Show)

data OrbitClass
    = ApolloOrbitClass
    | AmorOrbitClass
    | AtenOrbitClass
    | CometOrbitClass
    | JupiterFamilyCometOrbitClass
    | HalleyTypeCometOrbitClass
    | ParabolicCometOrbitClass
    | PurpleJupiterFamilyCometOrbitClass
    | EnckeTypeCometOrbitClass
    deriving (Show)

data Pha
    = YPha
    | NPha
    | NAPha
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement designationQuickTypeElement discoveryDateQuickTypeElement hMagQuickTypeElement iDegQuickTypeElement moidAuQuickTypeElement orbitClassQuickTypeElement periodYrQuickTypeElement phaQuickTypeElement qAu1QuickTypeElement qAu2QuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "designation" .= designationQuickTypeElement
        , Just $ "discovery_date" .= discoveryDateQuickTypeElement
        , ("h_mag" .=) <$> hMagQuickTypeElement
        , Just $ "i_deg" .= iDegQuickTypeElement
        , Just $ "moid_au" .= moidAuQuickTypeElement
        , Just $ "orbit_class" .= orbitClassQuickTypeElement
        , ("period_yr" .=) <$> periodYrQuickTypeElement
        , Just $ "pha" .= phaQuickTypeElement
        , Just $ "q_au_1" .= qAu1QuickTypeElement
        , ("q_au_2" .=) <$> qAu2QuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "designation"
        <*> v .: "discovery_date"
        <*> v .:! "h_mag"
        <*> v .: "i_deg"
        <*> v .: "moid_au"
        <*> v .: "orbit_class"
        <*> v .:! "period_yr"
        <*> v .: "pha"
        <*> v .: "q_au_1"
        <*> v .:! "q_au_2"

instance ToJSON OrbitClass where
    toJSON ApolloOrbitClass = "Apollo"
    toJSON AmorOrbitClass = "Amor"
    toJSON AtenOrbitClass = "Aten"
    toJSON CometOrbitClass = "Comet"
    toJSON JupiterFamilyCometOrbitClass = "Jupiter-family Comet"
    toJSON HalleyTypeCometOrbitClass = "Halley-type Comet*"
    toJSON ParabolicCometOrbitClass = "Parabolic Comet"
    toJSON PurpleJupiterFamilyCometOrbitClass = "Jupiter-family Comet*"
    toJSON EnckeTypeCometOrbitClass = "Encke-type Comet"

instance FromJSON OrbitClass where
    parseJSON = withText "OrbitClass" parseText
        where
            parseText "Apollo" = return ApolloOrbitClass
            parseText "Amor" = return AmorOrbitClass
            parseText "Aten" = return AtenOrbitClass
            parseText "Comet" = return CometOrbitClass
            parseText "Jupiter-family Comet" = return JupiterFamilyCometOrbitClass
            parseText "Halley-type Comet*" = return HalleyTypeCometOrbitClass
            parseText "Parabolic Comet" = return ParabolicCometOrbitClass
            parseText "Jupiter-family Comet*" = return PurpleJupiterFamilyCometOrbitClass
            parseText "Encke-type Comet" = return EnckeTypeCometOrbitClass

instance ToJSON Pha where
    toJSON YPha = "Y"
    toJSON NPha = "N"
    toJSON NAPha = "n/a"

instance FromJSON Pha where
    parseJSON = withText "Pha" parseText
        where
            parseText "Y" = return YPha
            parseText "N" = return NPha
            parseText "n/a" = return NAPha
