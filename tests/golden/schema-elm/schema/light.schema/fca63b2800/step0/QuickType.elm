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
    , LightParams
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { lightParams : LightParams
    }

type alias LightParams =
    { appID : String
    , outletID : String
    , rgba : String
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
        |> Jpipe.required "LightParams" lightParams

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("LightParams", encodeLightParams x.lightParams)
        ]

lightParams : Jdec.Decoder LightParams
lightParams =
    Jdec.succeed LightParams
        |> Jpipe.required "app_id" Jdec.string
        |> Jpipe.required "outlet_id" Jdec.string
        |> Jpipe.required "rgba" Jdec.string

encodeLightParams : LightParams -> Jenc.Value
encodeLightParams x =
    Jenc.object
        [ ("app_id", Jenc.string x.appID)
        , ("outlet_id", Jenc.string x.outletID)
        , ("rgba", Jenc.string x.rgba)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
