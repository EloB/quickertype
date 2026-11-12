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
    , QuickTypeElement
    , Location
    , Street
    , OutcomeStatus
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { category : String
    , context : String
    , id : Int
    , location : Location
    , locationSubtype : String
    , locationType : String
    , month : String
    , outcomeStatus : OutcomeStatus
    , persistentID : String
    }

type alias Location =
    { latitude : String
    , longitude : String
    , street : Street
    }

type alias Street =
    { id : Int
    , name : String
    }

type alias OutcomeStatus =
    { category : String
    , date : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeElement r)

quickTypeElement : Jdec.Decoder QuickTypeElement
quickTypeElement =
    Jdec.succeed QuickTypeElement
        |> Jpipe.required "category" Jdec.string
        |> Jpipe.required "context" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "location" location
        |> Jpipe.required "location_subtype" Jdec.string
        |> Jpipe.required "location_type" Jdec.string
        |> Jpipe.required "month" Jdec.string
        |> Jpipe.required "outcome_status" outcomeStatus
        |> Jpipe.required "persistent_id" Jdec.string

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("category", Jenc.string x.category)
        , ("context", Jenc.string x.context)
        , ("id", Jenc.int x.id)
        , ("location", encodeLocation x.location)
        , ("location_subtype", Jenc.string x.locationSubtype)
        , ("location_type", Jenc.string x.locationType)
        , ("month", Jenc.string x.month)
        , ("outcome_status", encodeOutcomeStatus x.outcomeStatus)
        , ("persistent_id", Jenc.string x.persistentID)
        ]

location : Jdec.Decoder Location
location =
    Jdec.succeed Location
        |> Jpipe.required "latitude" Jdec.string
        |> Jpipe.required "longitude" Jdec.string
        |> Jpipe.required "street" street

encodeLocation : Location -> Jenc.Value
encodeLocation x =
    Jenc.object
        [ ("latitude", Jenc.string x.latitude)
        , ("longitude", Jenc.string x.longitude)
        , ("street", encodeStreet x.street)
        ]

street : Jdec.Decoder Street
street =
    Jdec.succeed Street
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "name" Jdec.string

encodeStreet : Street -> Jenc.Value
encodeStreet x =
    Jenc.object
        [ ("id", Jenc.int x.id)
        , ("name", Jenc.string x.name)
        ]

outcomeStatus : Jdec.Decoder OutcomeStatus
outcomeStatus =
    Jdec.succeed OutcomeStatus
        |> Jpipe.required "category" Jdec.string
        |> Jpipe.required "date" Jdec.string

encodeOutcomeStatus : OutcomeStatus -> Jenc.Value
encodeOutcomeStatus x =
    Jenc.object
        [ ("category", Jenc.string x.category)
        , ("date", Jenc.string x.date)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
