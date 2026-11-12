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
    , Scheme(..)
    , Keyword(..)
    , MediaType(..)
    , Title(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { id : String
    , identifiers : List Identifier
    , keywords : List Keyword
    , links : List Link
    , name : String
    , otherNames : List Jdec.Value
    , supersededBy : Maybe String
    , text : List Text
    }

type alias Identifier =
    { identifier : String
    , scheme : Scheme
    }

type Scheme
    = Dep5
    | Spdx
    | Trove

type Keyword
    = OSIApproved
    | Popular
    | Copyleft
    | International

type alias Link =
    { note : String
    , url : String
    }

type alias Text =
    { mediaType : MediaType
    , title : Title
    , url : String
    }

type MediaType
    = TextPlain
    | TextHTML

type Title
    = PlainText
    | HTML

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
        |> Jpipe.required "keywords" (Jdec.list keyword )
        |> Jpipe.required "links" (Jdec.list link )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "other_names" (Jdec.list Jdec.value )
        |> Jpipe.required "superseded_by" (Jdec.nullable Jdec.string)
        |> Jpipe.required "text" (Jdec.list text )

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("id", Jenc.string x.id)
        , ("identifiers", Jenc.list encodeIdentifier x.identifiers)
        , ("keywords", Jenc.list encodeKeyword x.keywords)
        , ("links", Jenc.list encodeLink x.links)
        , ("name", Jenc.string x.name)
        , ("other_names", Jenc.list identity x.otherNames)
        , ("superseded_by", makeNullableEncoder Jenc.string x.supersededBy)
        , ("text", Jenc.list encodeText x.text)
        ]

identifier : Jdec.Decoder Identifier
identifier =
    Jdec.succeed Identifier
        |> Jpipe.required "identifier" Jdec.string
        |> Jpipe.required "scheme" scheme

encodeIdentifier : Identifier -> Jenc.Value
encodeIdentifier x =
    Jenc.object
        [ ("identifier", Jenc.string x.identifier)
        , ("scheme", encodeScheme x.scheme)
        ]

scheme : Jdec.Decoder Scheme
scheme =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "DEP5" -> Jdec.succeed Dep5
                "SPDX" -> Jdec.succeed Spdx
                "Trove" -> Jdec.succeed Trove
                somethingElse -> Jdec.fail <| "Invalid Scheme: " ++ somethingElse
        )

encodeScheme : Scheme -> Jenc.Value
encodeScheme x = case x of
    Dep5 -> Jenc.string "DEP5"
    Spdx -> Jenc.string "SPDX"
    Trove -> Jenc.string "Trove"

keyword : Jdec.Decoder Keyword
keyword =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "osi-approved" -> Jdec.succeed OSIApproved
                "popular" -> Jdec.succeed Popular
                "copyleft" -> Jdec.succeed Copyleft
                "international" -> Jdec.succeed International
                somethingElse -> Jdec.fail <| "Invalid Keyword: " ++ somethingElse
        )

encodeKeyword : Keyword -> Jenc.Value
encodeKeyword x = case x of
    OSIApproved -> Jenc.string "osi-approved"
    Popular -> Jenc.string "popular"
    Copyleft -> Jenc.string "copyleft"
    International -> Jenc.string "international"

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
        |> Jpipe.required "media_type" mediaType
        |> Jpipe.required "title" title
        |> Jpipe.required "url" Jdec.string

encodeText : Text -> Jenc.Value
encodeText x =
    Jenc.object
        [ ("media_type", encodeMediaType x.mediaType)
        , ("title", encodeTitle x.title)
        , ("url", Jenc.string x.url)
        ]

mediaType : Jdec.Decoder MediaType
mediaType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "text/plain" -> Jdec.succeed TextPlain
                "text/html" -> Jdec.succeed TextHTML
                somethingElse -> Jdec.fail <| "Invalid MediaType: " ++ somethingElse
        )

encodeMediaType : MediaType -> Jenc.Value
encodeMediaType x = case x of
    TextPlain -> Jenc.string "text/plain"
    TextHTML -> Jenc.string "text/html"

title : Jdec.Decoder Title
title =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Plain Text" -> Jdec.succeed PlainText
                "HTML" -> Jdec.succeed HTML
                somethingElse -> Jdec.fail <| "Invalid Title: " ++ somethingElse
        )

encodeTitle : Title -> Jenc.Value
encodeTitle x = case x of
    PlainText -> Jenc.string "Plain Text"
    HTML -> Jenc.string "HTML"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
