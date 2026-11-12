-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , Pokemon
    , Evolution
    , Egg(..)
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { pokemon : List Pokemon
    }

type alias Pokemon =
    { avgSpawns : Float
    , candy : String
    , candyCount : Maybe Int
    , egg : Egg
    , height : String
    , id : Int
    , img : String
    , multipliers : Maybe (List Float)
    , name : String
    , nextEvolution : Maybe (List Evolution)
    , num : String
    , pokemonType : List Type
    , prevEvolution : Maybe (List Evolution)
    , spawnChance : Float
    , spawnTime : String
    , weaknesses : List Type
    , weight : String
    }

type Egg
    = The2KM
    | NotInEggs
    | The5KM
    | The10KM
    | OmanyteCandy

type alias Evolution =
    { name : String
    , num : String
    }

type Type
    = Fire
    | Ice
    | Flying
    | Psychic
    | Water
    | Ground
    | Rock
    | Electric
    | Grass
    | Fighting
    | Poison
    | Bug
    | Fairy
    | Ghost
    | Dark
    | Steel
    | Dragon
    | Normal

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "pokemon" (Jdec.list pokemon )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("pokemon", Jenc.list encodePokemon x.pokemon)
        ]

pokemon : Jdec.Decoder Pokemon
pokemon =
    Jdec.succeed Pokemon
        |> Jpipe.required "avg_spawns" Jdec.float
        |> Jpipe.required "candy" Jdec.string
        |> Jpipe.custom (optionalField "candy_count" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.required "egg" egg
        |> Jpipe.required "height" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "img" Jdec.string
        |> Jpipe.required "multipliers" (Jdec.nullable (Jdec.list Jdec.float ))
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.custom (optionalField "next_evolution" (Jdec.map Just (Jdec.list evolution )) Nothing)
        |> Jpipe.required "num" Jdec.string
        |> Jpipe.required "type" (Jdec.list purpleType )
        |> Jpipe.custom (optionalField "prev_evolution" (Jdec.map Just (Jdec.list evolution )) Nothing)
        |> Jpipe.required "spawn_chance" Jdec.float
        |> Jpipe.required "spawn_time" Jdec.string
        |> Jpipe.required "weaknesses" (Jdec.list purpleType )
        |> Jpipe.required "weight" Jdec.string

encodePokemon : Pokemon -> Jenc.Value
encodePokemon x =
    Jenc.object
        [ ("avg_spawns", Jenc.float x.avgSpawns)
        , ("candy", Jenc.string x.candy)
        , ("candy_count", makeNullableEncoder Jenc.int x.candyCount)
        , ("egg", encodeEgg x.egg)
        , ("height", Jenc.string x.height)
        , ("id", Jenc.int x.id)
        , ("img", Jenc.string x.img)
        , ("multipliers", makeNullableEncoder (Jenc.list Jenc.float) x.multipliers)
        , ("name", Jenc.string x.name)
        , ("next_evolution", makeNullableEncoder (Jenc.list encodeEvolution) x.nextEvolution)
        , ("num", Jenc.string x.num)
        , ("type", Jenc.list encodeType x.pokemonType)
        , ("prev_evolution", makeNullableEncoder (Jenc.list encodeEvolution) x.prevEvolution)
        , ("spawn_chance", Jenc.float x.spawnChance)
        , ("spawn_time", Jenc.string x.spawnTime)
        , ("weaknesses", Jenc.list encodeType x.weaknesses)
        , ("weight", Jenc.string x.weight)
        ]

egg : Jdec.Decoder Egg
egg =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "2 km" -> Jdec.succeed The2KM
                "Not in Eggs" -> Jdec.succeed NotInEggs
                "5 km" -> Jdec.succeed The5KM
                "10 km" -> Jdec.succeed The10KM
                "Omanyte Candy" -> Jdec.succeed OmanyteCandy
                somethingElse -> Jdec.fail <| "Invalid Egg: " ++ somethingElse
        )

encodeEgg : Egg -> Jenc.Value
encodeEgg x = case x of
    The2KM -> Jenc.string "2 km"
    NotInEggs -> Jenc.string "Not in Eggs"
    The5KM -> Jenc.string "5 km"
    The10KM -> Jenc.string "10 km"
    OmanyteCandy -> Jenc.string "Omanyte Candy"

evolution : Jdec.Decoder Evolution
evolution =
    Jdec.succeed Evolution
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "num" Jdec.string

encodeEvolution : Evolution -> Jenc.Value
encodeEvolution x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        , ("num", Jenc.string x.num)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Fire" -> Jdec.succeed Fire
                "Ice" -> Jdec.succeed Ice
                "Flying" -> Jdec.succeed Flying
                "Psychic" -> Jdec.succeed Psychic
                "Water" -> Jdec.succeed Water
                "Ground" -> Jdec.succeed Ground
                "Rock" -> Jdec.succeed Rock
                "Electric" -> Jdec.succeed Electric
                "Grass" -> Jdec.succeed Grass
                "Fighting" -> Jdec.succeed Fighting
                "Poison" -> Jdec.succeed Poison
                "Bug" -> Jdec.succeed Bug
                "Fairy" -> Jdec.succeed Fairy
                "Ghost" -> Jdec.succeed Ghost
                "Dark" -> Jdec.succeed Dark
                "Steel" -> Jdec.succeed Steel
                "Dragon" -> Jdec.succeed Dragon
                "Normal" -> Jdec.succeed Normal
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Fire -> Jenc.string "Fire"
    Ice -> Jenc.string "Ice"
    Flying -> Jenc.string "Flying"
    Psychic -> Jenc.string "Psychic"
    Water -> Jenc.string "Water"
    Ground -> Jenc.string "Ground"
    Rock -> Jenc.string "Rock"
    Electric -> Jenc.string "Electric"
    Grass -> Jenc.string "Grass"
    Fighting -> Jenc.string "Fighting"
    Poison -> Jenc.string "Poison"
    Bug -> Jenc.string "Bug"
    Fairy -> Jenc.string "Fairy"
    Ghost -> Jenc.string "Ghost"
    Dark -> Jenc.string "Dark"
    Steel -> Jenc.string "Steel"
    Dragon -> Jenc.string "Dragon"
    Normal -> Jenc.string "Normal"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
