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
    , Weekdays(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { weekdays : Weekdays
    }

type Weekdays
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday

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
        |> Jpipe.required "weekdays" weekdays

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("weekdays", encodeWeekdays x.weekdays)
        ]

weekdays : Jdec.Decoder Weekdays
weekdays =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Monday" -> Jdec.succeed Monday
                "Tuesday" -> Jdec.succeed Tuesday
                "Wednesday" -> Jdec.succeed Wednesday
                "Thursday" -> Jdec.succeed Thursday
                "Friday" -> Jdec.succeed Friday
                "Saturday" -> Jdec.succeed Saturday
                "Sunday" -> Jdec.succeed Sunday
                somethingElse -> Jdec.fail <| "Invalid Weekdays: " ++ somethingElse
        )

encodeWeekdays : Weekdays -> Jenc.Value
encodeWeekdays x = case x of
    Monday -> Jenc.string "Monday"
    Tuesday -> Jenc.string "Tuesday"
    Wednesday -> Jenc.string "Wednesday"
    Thursday -> Jenc.string "Thursday"
    Friday -> Jenc.string "Friday"
    Saturday -> Jenc.string "Saturday"
    Sunday -> Jenc.string "Sunday"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
