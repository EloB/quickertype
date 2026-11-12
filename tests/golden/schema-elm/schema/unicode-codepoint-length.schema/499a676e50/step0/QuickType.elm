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
    { exact : String
    , maximum : String
    , minimum : String
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
        |> Jpipe.required "exact" (Jdec.andThen (\x -> if List.length (String.toList x) >= 2 && List.length (String.toList x) <= 2 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "maximum" (Jdec.andThen (\x -> if True && List.length (String.toList x) <= 1 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "minimum" (Jdec.andThen (\x -> if List.length (String.toList x) >= 2 && True then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("exact", Jenc.string x.exact)
        , ("maximum", Jenc.string x.maximum)
        , ("minimum", Jenc.string x.minimum)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
