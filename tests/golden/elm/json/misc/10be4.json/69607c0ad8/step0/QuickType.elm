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
    , OtherName
    , Text
    , Scheme(..)
    , Keyword(..)
    , Note(..)
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
    , otherNames : List OtherName
    , supersededBy : Maybe String
    , text : List Text
    }

type alias Identifier =
    { identifier : String
    , scheme : Scheme
    }

type Scheme
    = Spdx
    | Trove
    | Dep5

type Keyword
    = OSIApproved
    | Discouraged
    | Redundant
    | Miscellaneous
    | NonReusable
    | Obsolete
    | Popular
    | Permissive
    | Retired
    | SpecialPurpose
    | Copyleft
    | International

type alias Link =
    { note : Note
    , url : String
    }

type Note
    = OSIPage
    | TlDRLegal
    | WikipediaPage
    | NoteWikipediaPage
    | MozillaPage
    | OSETFoundationPage

type alias OtherName =
    { name : String
    , note : Maybe String
    }

type alias Text =
    { mediaType : MediaType
    , title : Title
    , url : String
    }

type MediaType
    = TextHTML
    | TextPlain
    | ApplicationPDF

type Title
    = HTML
    | PlainText
    | PDF

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
        |> Jpipe.required "other_names" (Jdec.list otherName )
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
        , ("other_names", Jenc.list encodeOtherName x.otherNames)
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
                "SPDX" -> Jdec.succeed Spdx
                "Trove" -> Jdec.succeed Trove
                "DEP5" -> Jdec.succeed Dep5
                somethingElse -> Jdec.fail <| "Invalid Scheme: " ++ somethingElse
        )

encodeScheme : Scheme -> Jenc.Value
encodeScheme x = case x of
    Spdx -> Jenc.string "SPDX"
    Trove -> Jenc.string "Trove"
    Dep5 -> Jenc.string "DEP5"

keyword : Jdec.Decoder Keyword
keyword =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "osi-approved" -> Jdec.succeed OSIApproved
                "discouraged" -> Jdec.succeed Discouraged
                "redundant" -> Jdec.succeed Redundant
                "miscellaneous" -> Jdec.succeed Miscellaneous
                "non-reusable" -> Jdec.succeed NonReusable
                "obsolete" -> Jdec.succeed Obsolete
                "popular" -> Jdec.succeed Popular
                "permissive" -> Jdec.succeed Permissive
                "retired" -> Jdec.succeed Retired
                "special-purpose" -> Jdec.succeed SpecialPurpose
                "copyleft" -> Jdec.succeed Copyleft
                "international" -> Jdec.succeed International
                somethingElse -> Jdec.fail <| "Invalid Keyword: " ++ somethingElse
        )

encodeKeyword : Keyword -> Jenc.Value
encodeKeyword x = case x of
    OSIApproved -> Jenc.string "osi-approved"
    Discouraged -> Jenc.string "discouraged"
    Redundant -> Jenc.string "redundant"
    Miscellaneous -> Jenc.string "miscellaneous"
    NonReusable -> Jenc.string "non-reusable"
    Obsolete -> Jenc.string "obsolete"
    Popular -> Jenc.string "popular"
    Permissive -> Jenc.string "permissive"
    Retired -> Jenc.string "retired"
    SpecialPurpose -> Jenc.string "special-purpose"
    Copyleft -> Jenc.string "copyleft"
    International -> Jenc.string "international"

link : Jdec.Decoder Link
link =
    Jdec.succeed Link
        |> Jpipe.required "note" note
        |> Jpipe.required "url" Jdec.string

encodeLink : Link -> Jenc.Value
encodeLink x =
    Jenc.object
        [ ("note", encodeNote x.note)
        , ("url", Jenc.string x.url)
        ]

note : Jdec.Decoder Note
note =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "OSI Page" -> Jdec.succeed OSIPage
                "tl;dr legal" -> Jdec.succeed TlDRLegal
                "Wikipedia page" -> Jdec.succeed WikipediaPage
                "Wikipedia Page" -> Jdec.succeed NoteWikipediaPage
                "Mozilla Page" -> Jdec.succeed MozillaPage
                "OSET Foundation Page" -> Jdec.succeed OSETFoundationPage
                somethingElse -> Jdec.fail <| "Invalid Note: " ++ somethingElse
        )

encodeNote : Note -> Jenc.Value
encodeNote x = case x of
    OSIPage -> Jenc.string "OSI Page"
    TlDRLegal -> Jenc.string "tl;dr legal"
    WikipediaPage -> Jenc.string "Wikipedia page"
    NoteWikipediaPage -> Jenc.string "Wikipedia Page"
    MozillaPage -> Jenc.string "Mozilla Page"
    OSETFoundationPage -> Jenc.string "OSET Foundation Page"

otherName : Jdec.Decoder OtherName
otherName =
    Jdec.succeed OtherName
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "note" (Jdec.nullable Jdec.string)

encodeOtherName : OtherName -> Jenc.Value
encodeOtherName x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        , ("note", makeNullableEncoder Jenc.string x.note)
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
                "text/html" -> Jdec.succeed TextHTML
                "text/plain" -> Jdec.succeed TextPlain
                "application/pdf" -> Jdec.succeed ApplicationPDF
                somethingElse -> Jdec.fail <| "Invalid MediaType: " ++ somethingElse
        )

encodeMediaType : MediaType -> Jenc.Value
encodeMediaType x = case x of
    TextHTML -> Jenc.string "text/html"
    TextPlain -> Jenc.string "text/plain"
    ApplicationPDF -> Jenc.string "application/pdf"

title : Jdec.Decoder Title
title =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "HTML" -> Jdec.succeed HTML
                "Plain Text" -> Jdec.succeed PlainText
                "PDF" -> Jdec.succeed PDF
                somethingElse -> Jdec.fail <| "Invalid Title: " ++ somethingElse
        )

encodeTitle : Title -> Jenc.Value
encodeTitle x = case x of
    HTML -> Jenc.string "HTML"
    PlainText -> Jenc.string "Plain Text"
    PDF -> Jenc.string "PDF"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
