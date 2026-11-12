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
    , Taxonomy
    , Properties
    , Annotations
    , Info
    , Paths
    , ItaTaxonomiesSearch
    , Get
    , Parameter
    , Responses
    , The200
    , Schema
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
    { taxonomy : Taxonomy
    }

type alias Taxonomy =
    { properties : Properties
    }

type alias Properties =
    { annotations : Annotations
    , datatypeProperties : Annotations
    , id : Annotations
    , label : Annotations
    , propertiesType : Annotations
    , subClassOf : Annotations
    }

type alias Annotations =
    { annotationsType : String
    , description : String
    }

type alias Info =
    { description : String
    , title : String
    , version : String
    }

type alias Paths =
    { itaTaxonomiesSearch : ItaTaxonomiesSearch
    }

type alias ItaTaxonomiesSearch =
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
    , format : String
    , name : String
    , parameterIn : String
    , parameterType : String
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
        |> Jpipe.required "Taxonomy" taxonomy

encodeDefinitions : Definitions -> Jenc.Value
encodeDefinitions x =
    Jenc.object
        [ ("Taxonomy", encodeTaxonomy x.taxonomy)
        ]

taxonomy : Jdec.Decoder Taxonomy
taxonomy =
    Jdec.succeed Taxonomy
        |> Jpipe.required "properties" properties

encodeTaxonomy : Taxonomy -> Jenc.Value
encodeTaxonomy x =
    Jenc.object
        [ ("properties", encodeProperties x.properties)
        ]

properties : Jdec.Decoder Properties
properties =
    Jdec.succeed Properties
        |> Jpipe.required "annotations" annotations
        |> Jpipe.required "datatype_properties" annotations
        |> Jpipe.required "id" annotations
        |> Jpipe.required "label" annotations
        |> Jpipe.required "type" annotations
        |> Jpipe.required "sub_class_of" annotations

encodeProperties : Properties -> Jenc.Value
encodeProperties x =
    Jenc.object
        [ ("annotations", encodeAnnotations x.annotations)
        , ("datatype_properties", encodeAnnotations x.datatypeProperties)
        , ("id", encodeAnnotations x.id)
        , ("label", encodeAnnotations x.label)
        , ("type", encodeAnnotations x.propertiesType)
        , ("sub_class_of", encodeAnnotations x.subClassOf)
        ]

annotations : Jdec.Decoder Annotations
annotations =
    Jdec.succeed Annotations
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "description" Jdec.string

encodeAnnotations : Annotations -> Jenc.Value
encodeAnnotations x =
    Jenc.object
        [ ("type", Jenc.string x.annotationsType)
        , ("description", Jenc.string x.description)
        ]

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
        |> Jpipe.required "/ita_taxonomies/search" itaTaxonomiesSearch

encodePaths : Paths -> Jenc.Value
encodePaths x =
    Jenc.object
        [ ("/ita_taxonomies/search", encodeItaTaxonomiesSearch x.itaTaxonomiesSearch)
        ]

itaTaxonomiesSearch : Jdec.Decoder ItaTaxonomiesSearch
itaTaxonomiesSearch =
    Jdec.succeed ItaTaxonomiesSearch
        |> Jpipe.required "get" get

encodeItaTaxonomiesSearch : ItaTaxonomiesSearch -> Jenc.Value
encodeItaTaxonomiesSearch x =
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
        |> Jpipe.required "format" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "in" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "required" Jdec.bool

encodeParameter : Parameter -> Jenc.Value
encodeParameter x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("format", Jenc.string x.format)
        , ("name", Jenc.string x.name)
        , ("in", Jenc.string x.parameterIn)
        , ("type", Jenc.string x.parameterType)
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
        |> Jpipe.required "$ref" Jdec.string

encodeSchema : Schema -> Jenc.Value
encodeSchema x =
    Jenc.object
        [ ("$ref", Jenc.string x.ref)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
