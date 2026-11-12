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
    , RegExp
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { pattern1 : String
    , pattern2 : String
    , regExp : Maybe RegExp
    , union : String
    }

type alias RegExp =
    { pattern3 : String
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
        |> Jpipe.required "pattern1" Jdec.string
        |> Jpipe.required "pattern2" Jdec.string
        |> Jpipe.custom (optionalField "RegExp" (Jdec.map Just regExp) Nothing)
        |> Jpipe.required "union" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("pattern1", Jenc.string x.pattern1)
        , ("pattern2", Jenc.string x.pattern2)
        , ("RegExp", makeNullableEncoder encodeRegExp x.regExp)
        , ("union", Jenc.string x.union)
        ]

regExp : Jdec.Decoder RegExp
regExp =
    Jdec.succeed RegExp
        |> Jpipe.required "pattern3" Jdec.string

encodeRegExp : RegExp -> Jenc.Value
encodeRegExp x =
    Jenc.object
        [ ("pattern3", Jenc.string x.pattern3)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
