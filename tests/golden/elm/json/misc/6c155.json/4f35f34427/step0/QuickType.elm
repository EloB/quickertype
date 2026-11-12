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
    , Metadata
    , ResponseInfo
    , Resultset
    , Result
    , Component
    , Location
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { metadata : Metadata
    , results : List Result
    }

type alias Metadata =
    { executionTime : Float
    , responseInfo : ResponseInfo
    , resultset : Resultset
    }

type alias ResponseInfo =
    { developerMessage : String
    , status : Int
    }

type alias Resultset =
    { count : Int
    , page : Int
    , pagesize : Int
    }

type alias Result =
    { attachment : List Jdec.Value
    , body : String
    , changed : String
    , component : List Component
    , created : String
    , date : String
    , image : List Jdec.Value
    , location : Location
    , teaser : ()
    , title : String
    , topic : List Jdec.Value
    , url : String
    , uuid : String
    , vuuid : String
    }

type alias Component =
    { name : String
    , uuid : String
    }

type alias Location =
    { administrativeArea : String
    , country : String
    , faxNumber : String
    , locality : String
    , mobileNumber : String
    , phoneNumber : String
    , phoneNumberExtension : String
    , postalCode : String
    , subPremise : ()
    , thoroughfare : String
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
        |> Jpipe.required "metadata" metadata
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("metadata", encodeMetadata x.metadata)
        , ("results", Jenc.list encodeResult x.results)
        ]

metadata : Jdec.Decoder Metadata
metadata =
    Jdec.succeed Metadata
        |> Jpipe.required "executionTime" Jdec.float
        |> Jpipe.required "responseInfo" responseInfo
        |> Jpipe.required "resultset" resultset

encodeMetadata : Metadata -> Jenc.Value
encodeMetadata x =
    Jenc.object
        [ ("executionTime", Jenc.float x.executionTime)
        , ("responseInfo", encodeResponseInfo x.responseInfo)
        , ("resultset", encodeResultset x.resultset)
        ]

responseInfo : Jdec.Decoder ResponseInfo
responseInfo =
    Jdec.succeed ResponseInfo
        |> Jpipe.required "developerMessage" Jdec.string
        |> Jpipe.required "status" Jdec.int

encodeResponseInfo : ResponseInfo -> Jenc.Value
encodeResponseInfo x =
    Jenc.object
        [ ("developerMessage", Jenc.string x.developerMessage)
        , ("status", Jenc.int x.status)
        ]

resultset : Jdec.Decoder Resultset
resultset =
    Jdec.succeed Resultset
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "page" Jdec.int
        |> Jpipe.required "pagesize" Jdec.int

encodeResultset : Resultset -> Jenc.Value
encodeResultset x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("page", Jenc.int x.page)
        , ("pagesize", Jenc.int x.pagesize)
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "attachment" (Jdec.list Jdec.value )
        |> Jpipe.required "body" Jdec.string
        |> Jpipe.required "changed" Jdec.string
        |> Jpipe.required "component" (Jdec.list component )
        |> Jpipe.required "created" Jdec.string
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "image" (Jdec.list Jdec.value )
        |> Jpipe.required "location" location
        |> Jpipe.required "teaser" (Jdec.null ())
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "topic" (Jdec.list Jdec.value )
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "uuid" Jdec.string
        |> Jpipe.required "vuuid" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("attachment", Jenc.list identity x.attachment)
        , ("body", Jenc.string x.body)
        , ("changed", Jenc.string x.changed)
        , ("component", Jenc.list encodeComponent x.component)
        , ("created", Jenc.string x.created)
        , ("date", Jenc.string x.date)
        , ("image", Jenc.list identity x.image)
        , ("location", encodeLocation x.location)
        , ("teaser", always Jenc.null x.teaser)
        , ("title", Jenc.string x.title)
        , ("topic", Jenc.list identity x.topic)
        , ("url", Jenc.string x.url)
        , ("uuid", Jenc.string x.uuid)
        , ("vuuid", Jenc.string x.vuuid)
        ]

component : Jdec.Decoder Component
component =
    Jdec.succeed Component
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "uuid" Jdec.string

encodeComponent : Component -> Jenc.Value
encodeComponent x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        , ("uuid", Jenc.string x.uuid)
        ]

location : Jdec.Decoder Location
location =
    Jdec.succeed Location
        |> Jpipe.required "administrative_area" Jdec.string
        |> Jpipe.required "country" Jdec.string
        |> Jpipe.required "fax_number" Jdec.string
        |> Jpipe.required "locality" Jdec.string
        |> Jpipe.required "mobile_number" Jdec.string
        |> Jpipe.required "phone_number" Jdec.string
        |> Jpipe.required "phone_number_extension" Jdec.string
        |> Jpipe.required "postal_code" Jdec.string
        |> Jpipe.required "sub_premise" (Jdec.null ())
        |> Jpipe.required "thoroughfare" Jdec.string

encodeLocation : Location -> Jenc.Value
encodeLocation x =
    Jenc.object
        [ ("administrative_area", Jenc.string x.administrativeArea)
        , ("country", Jenc.string x.country)
        , ("fax_number", Jenc.string x.faxNumber)
        , ("locality", Jenc.string x.locality)
        , ("mobile_number", Jenc.string x.mobileNumber)
        , ("phone_number", Jenc.string x.phoneNumber)
        , ("phone_number_extension", Jenc.string x.phoneNumberExtension)
        , ("postal_code", Jenc.string x.postalCode)
        , ("sub_premise", always Jenc.null x.subPremise)
        , ("thoroughfare", Jenc.string x.thoroughfare)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
