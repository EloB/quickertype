{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Pokemon (..)
    , Evolution (..)
    , Egg (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { pokemonQuickType :: [Pokemon]
    } deriving (Show)

data Pokemon = Pokemon
    { avgSpawnsPokemon :: Double
    , candyPokemon :: Text
    , candyCountPokemon :: Maybe Int
    , eggPokemon :: Egg
    , heightPokemon :: Text
    , imgPokemon :: Text
    , multipliersPokemon :: Maybe ([Double])
    , namePokemon :: Text
    , nextEvolutionPokemon :: Maybe ([Evolution])
    , numPokemon :: Text
    , pokemonIDPokemon :: Int
    , pokemonTypePokemon :: [Type]
    , prevEvolutionPokemon :: Maybe ([Evolution])
    , spawnChancePokemon :: Double
    , spawnTimePokemon :: Text
    , weaknessesPokemon :: [Type]
    , weightPokemon :: Text
    } deriving (Show)

data Egg
    = The2KMEgg
    | NotInEggsEgg
    | The5KMEgg
    | The10KMEgg
    | OmanyteCandyEgg
    deriving (Show)

data Evolution = Evolution
    { nameEvolution :: Text
    , numEvolution :: Text
    } deriving (Show)

data Type
    = FireType
    | IceType
    | FlyingType
    | PsychicType
    | WaterType
    | GroundType
    | RockType
    | ElectricType
    | GrassType
    | FightingType
    | PoisonType
    | BugType
    | FairyType
    | GhostType
    | DarkType
    | SteelType
    | DragonType
    | NormalType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType pokemonQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pokemon" .= pokemonQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "pokemon"

instance ToJSON Pokemon where
    toJSON (Pokemon avgSpawnsPokemon candyPokemon candyCountPokemon eggPokemon heightPokemon imgPokemon multipliersPokemon namePokemon nextEvolutionPokemon numPokemon pokemonIDPokemon pokemonTypePokemon prevEvolutionPokemon spawnChancePokemon spawnTimePokemon weaknessesPokemon weightPokemon) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avg_spawns" .= avgSpawnsPokemon
        , Just $ "candy" .= candyPokemon
        , ("candy_count" .=) <$> candyCountPokemon
        , Just $ "egg" .= eggPokemon
        , Just $ "height" .= heightPokemon
        , Just $ "img" .= imgPokemon
        , Just $ "multipliers" .= multipliersPokemon
        , Just $ "name" .= namePokemon
        , ("next_evolution" .=) <$> nextEvolutionPokemon
        , Just $ "num" .= numPokemon
        , Just $ "id" .= pokemonIDPokemon
        , Just $ "type" .= pokemonTypePokemon
        , ("prev_evolution" .=) <$> prevEvolutionPokemon
        , Just $ "spawn_chance" .= spawnChancePokemon
        , Just $ "spawn_time" .= spawnTimePokemon
        , Just $ "weaknesses" .= weaknessesPokemon
        , Just $ "weight" .= weightPokemon
        ]

instance FromJSON Pokemon where
    parseJSON (Object v) = Pokemon
        <$> v .: "avg_spawns"
        <*> v .: "candy"
        <*> v .:! "candy_count"
        <*> v .: "egg"
        <*> v .: "height"
        <*> v .: "img"
        <*> v .: "multipliers"
        <*> v .: "name"
        <*> v .:! "next_evolution"
        <*> v .: "num"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .:! "prev_evolution"
        <*> v .: "spawn_chance"
        <*> v .: "spawn_time"
        <*> v .: "weaknesses"
        <*> v .: "weight"

instance ToJSON Egg where
    toJSON The2KMEgg = "2 km"
    toJSON NotInEggsEgg = "Not in Eggs"
    toJSON The5KMEgg = "5 km"
    toJSON The10KMEgg = "10 km"
    toJSON OmanyteCandyEgg = "Omanyte Candy"

instance FromJSON Egg where
    parseJSON = withText "Egg" parseText
        where
            parseText "2 km" = return The2KMEgg
            parseText "Not in Eggs" = return NotInEggsEgg
            parseText "5 km" = return The5KMEgg
            parseText "10 km" = return The10KMEgg
            parseText "Omanyte Candy" = return OmanyteCandyEgg

instance ToJSON Evolution where
    toJSON (Evolution nameEvolution numEvolution) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameEvolution
        , Just $ "num" .= numEvolution
        ]

instance FromJSON Evolution where
    parseJSON (Object v) = Evolution
        <$> v .: "name"
        <*> v .: "num"

instance ToJSON Type where
    toJSON FireType = "Fire"
    toJSON IceType = "Ice"
    toJSON FlyingType = "Flying"
    toJSON PsychicType = "Psychic"
    toJSON WaterType = "Water"
    toJSON GroundType = "Ground"
    toJSON RockType = "Rock"
    toJSON ElectricType = "Electric"
    toJSON GrassType = "Grass"
    toJSON FightingType = "Fighting"
    toJSON PoisonType = "Poison"
    toJSON BugType = "Bug"
    toJSON FairyType = "Fairy"
    toJSON GhostType = "Ghost"
    toJSON DarkType = "Dark"
    toJSON SteelType = "Steel"
    toJSON DragonType = "Dragon"
    toJSON NormalType = "Normal"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "Fire" = return FireType
            parseText "Ice" = return IceType
            parseText "Flying" = return FlyingType
            parseText "Psychic" = return PsychicType
            parseText "Water" = return WaterType
            parseText "Ground" = return GroundType
            parseText "Rock" = return RockType
            parseText "Electric" = return ElectricType
            parseText "Grass" = return GrassType
            parseText "Fighting" = return FightingType
            parseText "Poison" = return PoisonType
            parseText "Bug" = return BugType
            parseText "Fairy" = return FairyType
            parseText "Ghost" = return GhostType
            parseText "Dark" = return DarkType
            parseText "Steel" = return SteelType
            parseText "Dragon" = return DragonType
            parseText "Normal" = return NormalType
