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
    , MissionSpec
    , Objective
    , Reward
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { missionSpecs : Dict String MissionSpec
    }

type alias MissionSpec =
    { objectives : Dict String Objective
    }

type alias Objective =
    { rewards : Dict String Reward
    }

type alias Reward =
    {
    }

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
        |> Jpipe.required "mission_specs" (Jdec.dict missionSpec)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("mission_specs", Jenc.dict identity encodeMissionSpec x.missionSpecs)
        ]

missionSpec : Jdec.Decoder MissionSpec
missionSpec =
    Jdec.succeed MissionSpec
        |> Jpipe.required "objectives" (Jdec.dict objective)

encodeMissionSpec : MissionSpec -> Jenc.Value
encodeMissionSpec x =
    Jenc.object
        [ ("objectives", Jenc.dict identity encodeObjective x.objectives)
        ]

objective : Jdec.Decoder Objective
objective =
    Jdec.succeed Objective
        |> Jpipe.required "rewards" (Jdec.dict reward)

encodeObjective : Objective -> Jenc.Value
encodeObjective x =
    Jenc.object
        [ ("rewards", Jenc.dict identity encodeReward x.rewards)
        ]

reward : Jdec.Decoder Reward
reward =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Reward)

encodeReward : Reward -> Jenc.Value
encodeReward x =
    Jenc.object
        [
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
