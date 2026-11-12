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
    , Title(..)
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
    , entity : String
    , firstName : String
    , id : String
    , lastName : String
    , name : String
    , position : Maybe String
    , status : Status
    , title : Maybe Title
    , updatedAt : String
    , uri : String
    }

type Status
    = Inactive
    | Active

type Title
    = Mr
    | MS

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
        |> Jpipe.required "entity" Jdec.string
        |> Jpipe.required "first_name" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "last_name" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "position" (Jdec.nullable Jdec.string)
        |> Jpipe.required "status" status
        |> Jpipe.required "title" (Jdec.nullable title)
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "uri" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("created_at", Jenc.string x.createdAt)
        , ("entity", Jenc.string x.entity)
        , ("first_name", Jenc.string x.firstName)
        , ("id", Jenc.string x.id)
        , ("last_name", Jenc.string x.lastName)
        , ("name", Jenc.string x.name)
        , ("position", makeNullableEncoder Jenc.string x.position)
        , ("status", encodeStatus x.status)
        , ("title", makeNullableEncoder encodeTitle x.title)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("uri", Jenc.string x.uri)
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

title : Jdec.Decoder Title
title =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Mr" -> Jdec.succeed Mr
                "Ms" -> Jdec.succeed MS
                somethingElse -> Jdec.fail <| "Invalid Title: " ++ somethingElse
        )

encodeTitle : Title -> Jenc.Value
encodeTitle x = case x of
    Mr -> Jenc.string "Mr"
    MS -> Jenc.string "Ms"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
