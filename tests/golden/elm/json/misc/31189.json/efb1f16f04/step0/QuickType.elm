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
    , Rate
    , Period
    , Rates
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { details : String
    , rates : List Rate
    , version : ()
    }

type alias Rate =
    { code : String
    , countryCode : String
    , name : String
    , periods : List Period
    }

type alias Period =
    { effectiveFrom : String
    , rates : Rates
    }

type alias Rates =
    { parking : Maybe Float
    , reduced : Maybe Float
    , reduced1 : Maybe Float
    , reduced2 : Maybe Float
    , standard : Float
    , superReduced : Maybe Float
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
        |> Jpipe.required "details" Jdec.string
        |> Jpipe.required "rates" (Jdec.list rate )
        |> Jpipe.required "version" (Jdec.null ())

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("details", Jenc.string x.details)
        , ("rates", Jenc.list encodeRate x.rates)
        , ("version", always Jenc.null x.version)
        ]

rate : Jdec.Decoder Rate
rate =
    Jdec.succeed Rate
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "country_code" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "periods" (Jdec.list period )

encodeRate : Rate -> Jenc.Value
encodeRate x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("country_code", Jenc.string x.countryCode)
        , ("name", Jenc.string x.name)
        , ("periods", Jenc.list encodePeriod x.periods)
        ]

period : Jdec.Decoder Period
period =
    Jdec.succeed Period
        |> Jpipe.required "effective_from" Jdec.string
        |> Jpipe.required "rates" rates

encodePeriod : Period -> Jenc.Value
encodePeriod x =
    Jenc.object
        [ ("effective_from", Jenc.string x.effectiveFrom)
        , ("rates", encodeRates x.rates)
        ]

rates : Jdec.Decoder Rates
rates =
    Jdec.succeed Rates
        |> Jpipe.custom (optionalField "parking" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "reduced" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "reduced1" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "reduced2" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.required "standard" Jdec.float
        |> Jpipe.custom (optionalField "super_reduced" (Jdec.map Just Jdec.float) Nothing)

encodeRates : Rates -> Jenc.Value
encodeRates x =
    Jenc.object
        [ ("parking", makeNullableEncoder Jenc.float x.parking)
        , ("reduced", makeNullableEncoder Jenc.float x.reduced)
        , ("reduced1", makeNullableEncoder Jenc.float x.reduced1)
        , ("reduced2", makeNullableEncoder Jenc.float x.reduced2)
        , ("standard", Jenc.float x.standard)
        , ("super_reduced", makeNullableEncoder Jenc.float x.superReduced)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
