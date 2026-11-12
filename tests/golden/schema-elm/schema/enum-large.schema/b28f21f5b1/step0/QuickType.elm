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
    , Callsign(..)
    , Priority(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { callsign : Callsign
    , priority : Priority
    }

type Callsign
    = Alpha
    | Bravo
    | Charlie
    | Delta
    | Echo
    | Foxtrot
    | Golf
    | Hotel
    | India
    | Juliett
    | Kilo
    | Lima
    | Mike
    | November
    | Oscar
    | Papa
    | Quebec
    | Romeo
    | Sierra
    | Tango

type Priority
    = Low
    | Medium
    | High

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
        |> Jpipe.required "callsign" callsign
        |> Jpipe.required "priority" priority

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("callsign", encodeCallsign x.callsign)
        , ("priority", encodePriority x.priority)
        ]

callsign : Jdec.Decoder Callsign
callsign =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "alpha" -> Jdec.succeed Alpha
                "bravo" -> Jdec.succeed Bravo
                "charlie" -> Jdec.succeed Charlie
                "delta" -> Jdec.succeed Delta
                "echo" -> Jdec.succeed Echo
                "foxtrot" -> Jdec.succeed Foxtrot
                "golf" -> Jdec.succeed Golf
                "hotel" -> Jdec.succeed Hotel
                "india" -> Jdec.succeed India
                "juliett" -> Jdec.succeed Juliett
                "kilo" -> Jdec.succeed Kilo
                "lima" -> Jdec.succeed Lima
                "mike" -> Jdec.succeed Mike
                "november" -> Jdec.succeed November
                "oscar" -> Jdec.succeed Oscar
                "papa" -> Jdec.succeed Papa
                "quebec" -> Jdec.succeed Quebec
                "romeo" -> Jdec.succeed Romeo
                "sierra" -> Jdec.succeed Sierra
                "tango" -> Jdec.succeed Tango
                somethingElse -> Jdec.fail <| "Invalid Callsign: " ++ somethingElse
        )

encodeCallsign : Callsign -> Jenc.Value
encodeCallsign x = case x of
    Alpha -> Jenc.string "alpha"
    Bravo -> Jenc.string "bravo"
    Charlie -> Jenc.string "charlie"
    Delta -> Jenc.string "delta"
    Echo -> Jenc.string "echo"
    Foxtrot -> Jenc.string "foxtrot"
    Golf -> Jenc.string "golf"
    Hotel -> Jenc.string "hotel"
    India -> Jenc.string "india"
    Juliett -> Jenc.string "juliett"
    Kilo -> Jenc.string "kilo"
    Lima -> Jenc.string "lima"
    Mike -> Jenc.string "mike"
    November -> Jenc.string "november"
    Oscar -> Jenc.string "oscar"
    Papa -> Jenc.string "papa"
    Quebec -> Jenc.string "quebec"
    Romeo -> Jenc.string "romeo"
    Sierra -> Jenc.string "sierra"
    Tango -> Jenc.string "tango"

priority : Jdec.Decoder Priority
priority =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "low" -> Jdec.succeed Low
                "medium" -> Jdec.succeed Medium
                "high" -> Jdec.succeed High
                somethingElse -> Jdec.fail <| "Invalid Priority: " ++ somethingElse
        )

encodePriority : Priority -> Jenc.Value
encodePriority x = case x of
    Low -> Jenc.string "low"
    Medium -> Jenc.string "medium"
    High -> Jenc.string "high"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
