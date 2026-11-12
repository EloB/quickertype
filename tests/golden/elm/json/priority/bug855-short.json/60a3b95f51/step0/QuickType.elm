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
    , QuickTypeValue
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = Dict String QuickTypeValue

type alias QuickTypeValue =
    { channelID : String
    , channelName : String
    , code : String
    , emoticonSet : Int
    , id : Int
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.dict quickTypeValue

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.dict identity encodeQuickTypeValue r)

quickTypeValue : Jdec.Decoder QuickTypeValue
quickTypeValue =
    Jdec.succeed QuickTypeValue
        |> Jpipe.required "channel_id" Jdec.string
        |> Jpipe.required "channel_name" Jdec.string
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "emoticon_set" Jdec.int
        |> Jpipe.required "id" Jdec.int

encodeQuickTypeValue : QuickTypeValue -> Jenc.Value
encodeQuickTypeValue x =
    Jenc.object
        [ ("channel_id", Jenc.string x.channelID)
        , ("channel_name", Jenc.string x.channelName)
        , ("code", Jenc.string x.code)
        , ("emoticon_set", Jenc.int x.emoticonSet)
        , ("id", Jenc.int x.id)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
