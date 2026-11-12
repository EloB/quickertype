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
    , Bar
    , X(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { bar : List Bar
    , foo : List Bar
    }

type alias Bar =
    { barX : X
    }

type X
    = Three
    | One
    | Two

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
        |> Jpipe.required "bar" (Jdec.list bar )
        |> Jpipe.required "foo" (Jdec.list bar )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("bar", Jenc.list encodeBar x.bar)
        , ("foo", Jenc.list encodeBar x.foo)
        ]

bar : Jdec.Decoder Bar
bar =
    Jdec.succeed Bar
        |> Jpipe.required "x" purpleX

encodeBar : Bar -> Jenc.Value
encodeBar x =
    Jenc.object
        [ ("x", encodeX x.barX)
        ]

purpleX : Jdec.Decoder X
purpleX =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "three" -> Jdec.succeed Three
                "one" -> Jdec.succeed One
                "two" -> Jdec.succeed Two
                somethingElse -> Jdec.fail <| "Invalid X: " ++ somethingElse
        )

encodeX : X -> Jenc.Value
encodeX x = case x of
    Three -> Jenc.string "three"
    One -> Jenc.string "one"
    Two -> Jenc.string "two"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
