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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { booleanValue : Bool
    , doubleValue : Float
    , intValue : Int
    , stringValue : String
    , uuidValue : String
    , uuidValues : List String
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
        |> Jpipe.required "booleanValue" Jdec.bool
        |> Jpipe.required "doubleValue" Jdec.float
        |> Jpipe.required "intValue" Jdec.int
        |> Jpipe.required "stringValue" Jdec.string
        |> Jpipe.required "uuidValue" Jdec.string
        |> Jpipe.required "uuidValues" (Jdec.list Jdec.string )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("booleanValue", Jenc.bool x.booleanValue)
        , ("doubleValue", Jenc.float x.doubleValue)
        , ("intValue", Jenc.int x.intValue)
        , ("stringValue", Jenc.string x.stringValue)
        , ("uuidValue", Jenc.string x.uuidValue)
        , ("uuidValues", Jenc.list Jenc.string x.uuidValues)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
