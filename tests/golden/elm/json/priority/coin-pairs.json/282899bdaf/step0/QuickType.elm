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
    , Pair
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { pairs : Dict String Pair
    , serverTime : Int
    }

type alias Pair =
    { decimalPlaces : Int
    , fee : Float
    , hidden : Int
    , maxAmount : Int
    , maxPrice : Int
    , minAmount : Float
    , minPrice : Float
    , minTotal : Float
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
        |> Jpipe.required "pairs" (Jdec.dict pair)
        |> Jpipe.required "server_time" Jdec.int

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("pairs", Jenc.dict identity encodePair x.pairs)
        , ("server_time", Jenc.int x.serverTime)
        ]

pair : Jdec.Decoder Pair
pair =
    Jdec.succeed Pair
        |> Jpipe.required "decimal_places" Jdec.int
        |> Jpipe.required "fee" Jdec.float
        |> Jpipe.required "hidden" Jdec.int
        |> Jpipe.required "max_amount" Jdec.int
        |> Jpipe.required "max_price" Jdec.int
        |> Jpipe.required "min_amount" Jdec.float
        |> Jpipe.required "min_price" Jdec.float
        |> Jpipe.required "min_total" Jdec.float

encodePair : Pair -> Jenc.Value
encodePair x =
    Jenc.object
        [ ("decimal_places", Jenc.int x.decimalPlaces)
        , ("fee", Jenc.float x.fee)
        , ("hidden", Jenc.int x.hidden)
        , ("max_amount", Jenc.int x.maxAmount)
        , ("max_price", Jenc.int x.maxPrice)
        , ("min_amount", Jenc.float x.minAmount)
        , ("min_price", Jenc.float x.minPrice)
        , ("min_total", Jenc.float x.minTotal)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
