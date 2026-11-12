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
    , StateElement
    , StateState
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { states : List StateElement
    }

type alias StateElement =
    { state : StateState
    }

type alias StateState =
    { stateID : String
    , stateName : String
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
        |> Jpipe.required "states" (Jdec.list stateElement )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("states", Jenc.list encodeStateElement x.states)
        ]

stateElement : Jdec.Decoder StateElement
stateElement =
    Jdec.succeed StateElement
        |> Jpipe.required "state" stateState

encodeStateElement : StateElement -> Jenc.Value
encodeStateElement x =
    Jenc.object
        [ ("state", encodeStateState x.state)
        ]

stateState : Jdec.Decoder StateState
stateState =
    Jdec.succeed StateState
        |> Jpipe.required "state_id" Jdec.string
        |> Jpipe.required "state_name" Jdec.string

encodeStateState : StateState -> Jenc.Value
encodeStateState x =
    Jenc.object
        [ ("state_id", Jenc.string x.stateID)
        , ("state_name", Jenc.string x.stateName)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
