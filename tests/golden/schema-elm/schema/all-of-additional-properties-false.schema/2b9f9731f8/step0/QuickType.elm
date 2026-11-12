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
    , Frequency(..)
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { amount : Float
    , frequency : Frequency
    , description : Maybe String
    , quickTypeType : Type
    }

type Frequency
    = Weekly
    | Monthly
    | Annually

type Type
    = GrossSalaryAmount
    | Overtime

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
        |> Jpipe.required "amount" Jdec.float
        |> Jpipe.required "frequency" frequency
        |> Jpipe.custom (optionalField "description" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "type" purpleType

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("amount", Jenc.float x.amount)
        , ("frequency", encodeFrequency x.frequency)
        , ("description", makeNullableEncoder Jenc.string x.description)
        , ("type", encodeType x.quickTypeType)
        ]

frequency : Jdec.Decoder Frequency
frequency =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Weekly" -> Jdec.succeed Weekly
                "Monthly" -> Jdec.succeed Monthly
                "Annually" -> Jdec.succeed Annually
                somethingElse -> Jdec.fail <| "Invalid Frequency: " ++ somethingElse
        )

encodeFrequency : Frequency -> Jenc.Value
encodeFrequency x = case x of
    Weekly -> Jenc.string "Weekly"
    Monthly -> Jenc.string "Monthly"
    Annually -> Jenc.string "Annually"

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "GrossSalaryAmount" -> Jdec.succeed GrossSalaryAmount
                "Overtime" -> Jdec.succeed Overtime
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    GrossSalaryAmount -> Jenc.string "GrossSalaryAmount"
    Overtime -> Jenc.string "Overtime"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
