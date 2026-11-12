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
    , Identifier
    , Link
    , Text
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { id : String
    , identifiers : List Identifier
    , keywords : List String
    , links : List Link
    , name : String
    , otherNames : List Jdec.Value
    , supersededBy : ()
    , text : List Text
    }

type alias Identifier =
    { identifier : String
    , scheme : String
    }

type alias Link =
    { note : String
    , url : String
    }

type alias Text =
    { mediaType : String
    , title : String
    , url : String
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
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "identifiers" (Jdec.list identifier )
        |> Jpipe.required "keywords" (Jdec.list Jdec.string )
        |> Jpipe.required "links" (Jdec.list link )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "other_names" (Jdec.list Jdec.value )
        |> Jpipe.required "superseded_by" (Jdec.null ())
        |> Jpipe.required "text" (Jdec.list text )

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("id", Jenc.string x.id)
        , ("identifiers", Jenc.list encodeIdentifier x.identifiers)
        , ("keywords", Jenc.list Jenc.string x.keywords)
        , ("links", Jenc.list encodeLink x.links)
        , ("name", Jenc.string x.name)
        , ("other_names", Jenc.list identity x.otherNames)
        , ("superseded_by", always Jenc.null x.supersededBy)
        , ("text", Jenc.list encodeText x.text)
        ]

identifier : Jdec.Decoder Identifier
identifier =
    Jdec.succeed Identifier
        |> Jpipe.required "identifier" Jdec.string
        |> Jpipe.required "scheme" Jdec.string

encodeIdentifier : Identifier -> Jenc.Value
encodeIdentifier x =
    Jenc.object
        [ ("identifier", Jenc.string x.identifier)
        , ("scheme", Jenc.string x.scheme)
        ]

link : Jdec.Decoder Link
link =
    Jdec.succeed Link
        |> Jpipe.required "note" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeLink : Link -> Jenc.Value
encodeLink x =
    Jenc.object
        [ ("note", Jenc.string x.note)
        , ("url", Jenc.string x.url)
        ]

text : Jdec.Decoder Text
text =
    Jdec.succeed Text
        |> Jpipe.required "media_type" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeText : Text -> Jenc.Value
encodeText x =
    Jenc.object
        [ ("media_type", Jenc.string x.mediaType)
        , ("title", Jenc.string x.title)
        , ("url", Jenc.string x.url)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
