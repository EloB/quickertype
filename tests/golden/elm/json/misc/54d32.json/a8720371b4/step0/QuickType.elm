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
    , Facets
    , Result
    , Status(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { count : Int
    , facets : Facets
    , limit : Int
    , next : String
    , offset : Int
    , previous : Bool
    , results : List Result
    }

type alias Facets =
    {
    }

type alias Result =
    { createdAt : String
    , id : String
    , personID : String
    , representativeID : String
    , status : Status
    , updatedAt : String
    }

type Status
    = Inactive
    | Active

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
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "facets" facets
        |> Jpipe.required "limit" Jdec.int
        |> Jpipe.required "next" Jdec.string
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "previous" Jdec.bool
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("facets", encodeFacets x.facets)
        , ("limit", Jenc.int x.limit)
        , ("next", Jenc.string x.next)
        , ("offset", Jenc.int x.offset)
        , ("previous", Jenc.bool x.previous)
        , ("results", Jenc.list encodeResult x.results)
        ]

facets : Jdec.Decoder Facets
facets =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Facets)

encodeFacets : Facets -> Jenc.Value
encodeFacets x =
    Jenc.object
        [
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "person_id" Jdec.string
        |> Jpipe.required "representative_id" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "updated_at" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("created_at", Jenc.string x.createdAt)
        , ("id", Jenc.string x.id)
        , ("person_id", Jenc.string x.personID)
        , ("representative_id", Jenc.string x.representativeID)
        , ("status", encodeStatus x.status)
        , ("updated_at", Jenc.string x.updatedAt)
        ]

status : Jdec.Decoder Status
status =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "inactive" -> Jdec.succeed Inactive
                "active" -> Jdec.succeed Active
                somethingElse -> Jdec.fail <| "Invalid Status: " ++ somethingElse
        )

encodeStatus : Status -> Jenc.Value
encodeStatus x = case x of
    Inactive -> Jenc.string "inactive"
    Active -> Jenc.string "active"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
