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
    , Open(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { open : List Open
    , tuple : List Open
    }

type Open
    = BoolInOpen Bool
    | IntegerInOpen Int

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
        |> Jpipe.required "open" (Jdec.list open )
        |> Jpipe.required "tuple" (Jdec.list open )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("open", Jenc.list encodeOpen x.open)
        , ("tuple", Jenc.list encodeOpen x.tuple)
        ]

open : Jdec.Decoder Open
open =
    Jdec.oneOf
        [ Jdec.map BoolInOpen Jdec.bool
        , Jdec.map IntegerInOpen Jdec.int
        ]

encodeOpen : Open -> Jenc.Value
encodeOpen x = case x of
    BoolInOpen y -> Jenc.bool y
    IntegerInOpen y -> Jenc.int y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
