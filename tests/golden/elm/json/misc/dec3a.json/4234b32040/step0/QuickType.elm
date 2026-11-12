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
    , HiringOrg
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
    { aboutOffice : String
    , applicationProcess : String
    , body : String
    , changed : String
    , created : String
    , deadline : ()
    , hiringOffice : ()
    , hiringOrg : HiringOrg
    , jobID : ()
    , language : String
    , location : Location
    , numPositions : String
    , position : String
    , practiceArea : String
    , qualifications : String
    , relocationExpenses : ()
    , salary : String
    , title : String
    , travel : String
    , url : String
    , uuid : String
    , vuuid : String
    }

type alias HiringOrg =
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
        |> Jpipe.required "about_office" Jdec.string
        |> Jpipe.required "application_process" Jdec.string
        |> Jpipe.required "body" Jdec.string
        |> Jpipe.required "changed" Jdec.string
        |> Jpipe.required "created" Jdec.string
        |> Jpipe.required "deadline" (Jdec.null ())
        |> Jpipe.required "hiring_office" (Jdec.null ())
        |> Jpipe.required "hiring_org" hiringOrg
        |> Jpipe.required "job_id" (Jdec.null ())
        |> Jpipe.required "language" Jdec.string
        |> Jpipe.required "location" location
        |> Jpipe.required "num_positions" Jdec.string
        |> Jpipe.required "position" Jdec.string
        |> Jpipe.required "practice_area" Jdec.string
        |> Jpipe.required "qualifications" Jdec.string
        |> Jpipe.required "relocation_expenses" (Jdec.null ())
        |> Jpipe.required "salary" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "travel" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "uuid" Jdec.string
        |> Jpipe.required "vuuid" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("about_office", Jenc.string x.aboutOffice)
        , ("application_process", Jenc.string x.applicationProcess)
        , ("body", Jenc.string x.body)
        , ("changed", Jenc.string x.changed)
        , ("created", Jenc.string x.created)
        , ("deadline", always Jenc.null x.deadline)
        , ("hiring_office", always Jenc.null x.hiringOffice)
        , ("hiring_org", encodeHiringOrg x.hiringOrg)
        , ("job_id", always Jenc.null x.jobID)
        , ("language", Jenc.string x.language)
        , ("location", encodeLocation x.location)
        , ("num_positions", Jenc.string x.numPositions)
        , ("position", Jenc.string x.position)
        , ("practice_area", Jenc.string x.practiceArea)
        , ("qualifications", Jenc.string x.qualifications)
        , ("relocation_expenses", always Jenc.null x.relocationExpenses)
        , ("salary", Jenc.string x.salary)
        , ("title", Jenc.string x.title)
        , ("travel", Jenc.string x.travel)
        , ("url", Jenc.string x.url)
        , ("uuid", Jenc.string x.uuid)
        , ("vuuid", Jenc.string x.vuuid)
        ]

hiringOrg : Jdec.Decoder HiringOrg
hiringOrg =
    Jdec.succeed HiringOrg
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "uuid" Jdec.string

encodeHiringOrg : HiringOrg -> Jenc.Value
encodeHiringOrg x =
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
