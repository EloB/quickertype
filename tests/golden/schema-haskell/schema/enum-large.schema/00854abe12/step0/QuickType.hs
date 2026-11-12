{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Callsign (..)
    , Priority (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { callsignQuickType :: Callsign
    , priorityQuickType :: Priority
    } deriving (Show)

data Callsign
    = AlphaCallsign
    | BravoCallsign
    | CharlieCallsign
    | DeltaCallsign
    | EchoCallsign
    | FoxtrotCallsign
    | GolfCallsign
    | HotelCallsign
    | IndiaCallsign
    | JuliettCallsign
    | KiloCallsign
    | LimaCallsign
    | MikeCallsign
    | NovemberCallsign
    | OscarCallsign
    | PapaCallsign
    | QuebecCallsign
    | RomeoCallsign
    | SierraCallsign
    | TangoCallsign
    deriving (Show)

data Priority
    = LowPriority
    | MediumPriority
    | HighPriority
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType callsignQuickType priorityQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "callsign" .= callsignQuickType
        , Just $ "priority" .= priorityQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "callsign"
        <*> v .: "priority"

instance ToJSON Callsign where
    toJSON AlphaCallsign = "alpha"
    toJSON BravoCallsign = "bravo"
    toJSON CharlieCallsign = "charlie"
    toJSON DeltaCallsign = "delta"
    toJSON EchoCallsign = "echo"
    toJSON FoxtrotCallsign = "foxtrot"
    toJSON GolfCallsign = "golf"
    toJSON HotelCallsign = "hotel"
    toJSON IndiaCallsign = "india"
    toJSON JuliettCallsign = "juliett"
    toJSON KiloCallsign = "kilo"
    toJSON LimaCallsign = "lima"
    toJSON MikeCallsign = "mike"
    toJSON NovemberCallsign = "november"
    toJSON OscarCallsign = "oscar"
    toJSON PapaCallsign = "papa"
    toJSON QuebecCallsign = "quebec"
    toJSON RomeoCallsign = "romeo"
    toJSON SierraCallsign = "sierra"
    toJSON TangoCallsign = "tango"

instance FromJSON Callsign where
    parseJSON = withText "Callsign" parseText
        where
            parseText "alpha" = return AlphaCallsign
            parseText "bravo" = return BravoCallsign
            parseText "charlie" = return CharlieCallsign
            parseText "delta" = return DeltaCallsign
            parseText "echo" = return EchoCallsign
            parseText "foxtrot" = return FoxtrotCallsign
            parseText "golf" = return GolfCallsign
            parseText "hotel" = return HotelCallsign
            parseText "india" = return IndiaCallsign
            parseText "juliett" = return JuliettCallsign
            parseText "kilo" = return KiloCallsign
            parseText "lima" = return LimaCallsign
            parseText "mike" = return MikeCallsign
            parseText "november" = return NovemberCallsign
            parseText "oscar" = return OscarCallsign
            parseText "papa" = return PapaCallsign
            parseText "quebec" = return QuebecCallsign
            parseText "romeo" = return RomeoCallsign
            parseText "sierra" = return SierraCallsign
            parseText "tango" = return TangoCallsign

instance ToJSON Priority where
    toJSON LowPriority = "low"
    toJSON MediumPriority = "medium"
    toJSON HighPriority = "high"

instance FromJSON Priority where
    parseJSON = withText "Priority" parseText
        where
            parseText "low" = return LowPriority
            parseText "medium" = return MediumPriority
            parseText "high" = return HighPriority
