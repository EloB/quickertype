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
    , Definitions
    , Rate
    , Property
    , Info
    , Paths
    , TariffRatesSearch
    , Get
    , Parameter
    , Responses
    , The200
    , Schema
    , Items
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { basePath : String
    , definitions : Definitions
    , host : String
    , info : Info
    , paths : Paths
    , produces : List String
    , schemes : List String
    , swagger : String
    }

type alias Definitions =
    { rate : Rate
    }

type alias Rate =
    { properties : Dict String Property
    }

type alias Property =
    { description : String
    , propertyType : Type
    }

type Type
    = TypeString

type alias Info =
    { description : String
    , title : String
    , version : String
    }

type alias Paths =
    { tariffRatesSearch : TariffRatesSearch
    }

type alias TariffRatesSearch =
    { get : Get
    }

type alias Get =
    { description : String
    , parameters : List Parameter
    , responses : Responses
    , summary : String
    , tags : List String
    }

type alias Parameter =
    { description : String
    , format : Type
    , name : String
    , parameterIn : String
    , parameterType : Type
    , required : Bool
    }

type alias Responses =
    { the200 : The200
    }

type alias The200 =
    { description : String
    , schema : Schema
    }

type alias Schema =
    { items : Items
    , schemaType : String
    }

type alias Items =
    { ref : String
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
        |> Jpipe.required "basePath" Jdec.string
        |> Jpipe.required "definitions" definitions
        |> Jpipe.required "host" Jdec.string
        |> Jpipe.required "info" info
        |> Jpipe.required "paths" paths
        |> Jpipe.required "produces" (Jdec.list Jdec.string )
        |> Jpipe.required "schemes" (Jdec.list Jdec.string )
        |> Jpipe.required "swagger" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("basePath", Jenc.string x.basePath)
        , ("definitions", encodeDefinitions x.definitions)
        , ("host", Jenc.string x.host)
        , ("info", encodeInfo x.info)
        , ("paths", encodePaths x.paths)
        , ("produces", Jenc.list Jenc.string x.produces)
        , ("schemes", Jenc.list Jenc.string x.schemes)
        , ("swagger", Jenc.string x.swagger)
        ]

definitions : Jdec.Decoder Definitions
definitions =
    Jdec.succeed Definitions
        |> Jpipe.required "Rate" rate

encodeDefinitions : Definitions -> Jenc.Value
encodeDefinitions x =
    Jenc.object
        [ ("Rate", encodeRate x.rate)
        ]

rate : Jdec.Decoder Rate
rate =
    Jdec.succeed Rate
        |> Jpipe.required "properties" (Jdec.dict property)

encodeRate : Rate -> Jenc.Value
encodeRate x =
    Jenc.object
        [ ("properties", Jenc.dict identity encodeProperty x.properties)
        ]

property : Jdec.Decoder Property
property =
    Jdec.succeed Property
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "type" purpleType

encodeProperty : Property -> Jenc.Value
encodeProperty x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("type", encodeType x.propertyType)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "string" -> Jdec.succeed TypeString
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    TypeString -> Jenc.string "string"

info : Jdec.Decoder Info
info =
    Jdec.succeed Info
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "version" Jdec.string

encodeInfo : Info -> Jenc.Value
encodeInfo x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("title", Jenc.string x.title)
        , ("version", Jenc.string x.version)
        ]

paths : Jdec.Decoder Paths
paths =
    Jdec.succeed Paths
        |> Jpipe.required "/tariff_rates/search" tariffRatesSearch

encodePaths : Paths -> Jenc.Value
encodePaths x =
    Jenc.object
        [ ("/tariff_rates/search", encodeTariffRatesSearch x.tariffRatesSearch)
        ]

tariffRatesSearch : Jdec.Decoder TariffRatesSearch
tariffRatesSearch =
    Jdec.succeed TariffRatesSearch
        |> Jpipe.required "get" get

encodeTariffRatesSearch : TariffRatesSearch -> Jenc.Value
encodeTariffRatesSearch x =
    Jenc.object
        [ ("get", encodeGet x.get)
        ]

get : Jdec.Decoder Get
get =
    Jdec.succeed Get
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "parameters" (Jdec.list parameter )
        |> Jpipe.required "responses" responses
        |> Jpipe.required "summary" Jdec.string
        |> Jpipe.required "tags" (Jdec.list Jdec.string )

encodeGet : Get -> Jenc.Value
encodeGet x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("parameters", Jenc.list encodeParameter x.parameters)
        , ("responses", encodeResponses x.responses)
        , ("summary", Jenc.string x.summary)
        , ("tags", Jenc.list Jenc.string x.tags)
        ]

parameter : Jdec.Decoder Parameter
parameter =
    Jdec.succeed Parameter
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "format" purpleType
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "in" Jdec.string
        |> Jpipe.required "type" purpleType
        |> Jpipe.required "required" Jdec.bool

encodeParameter : Parameter -> Jenc.Value
encodeParameter x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("format", encodeType x.format)
        , ("name", Jenc.string x.name)
        , ("in", Jenc.string x.parameterIn)
        , ("type", encodeType x.parameterType)
        , ("required", Jenc.bool x.required)
        ]

responses : Jdec.Decoder Responses
responses =
    Jdec.succeed Responses
        |> Jpipe.required "200" the200

encodeResponses : Responses -> Jenc.Value
encodeResponses x =
    Jenc.object
        [ ("200", encodeThe200 x.the200)
        ]

the200 : Jdec.Decoder The200
the200 =
    Jdec.succeed The200
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "schema" schema

encodeThe200 : The200 -> Jenc.Value
encodeThe200 x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("schema", encodeSchema x.schema)
        ]

schema : Jdec.Decoder Schema
schema =
    Jdec.succeed Schema
        |> Jpipe.required "items" items
        |> Jpipe.required "type" Jdec.string

encodeSchema : Schema -> Jenc.Value
encodeSchema x =
    Jenc.object
        [ ("items", encodeItems x.items)
        , ("type", Jenc.string x.schemaType)
        ]

items : Jdec.Decoder Items
items =
    Jdec.succeed Items
        |> Jpipe.required "$ref" Jdec.string

encodeItems : Items -> Jenc.Value
encodeItems x =
    Jenc.object
        [ ("$ref", Jenc.string x.ref)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
