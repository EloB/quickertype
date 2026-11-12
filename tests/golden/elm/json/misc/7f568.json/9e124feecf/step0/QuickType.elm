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
    , File
    , Type(..)
    , Language(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { comments : Int
    , commentsURL : String
    , commitsURL : String
    , createdAt : String
    , description : Maybe String
    , files : Dict String File
    , forksURL : String
    , gitPullURL : String
    , gitPushURL : String
    , htmlURL : String
    , id : String
    , public : Bool
    , truncated : Bool
    , updatedAt : String
    , url : String
    , user : ()
    }

type alias File =
    { fileType : Type
    , filename : String
    , language : Maybe Language
    , rawURL : String
    , size : Int
    }

type Type
    = TextPlain

type Language
    = Markdown

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
        |> Jpipe.required "comments" Jdec.int
        |> Jpipe.required "comments_url" Jdec.string
        |> Jpipe.required "commits_url" Jdec.string
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "description" (Jdec.nullable Jdec.string)
        |> Jpipe.required "files" (Jdec.dict file)
        |> Jpipe.required "forks_url" Jdec.string
        |> Jpipe.required "git_pull_url" Jdec.string
        |> Jpipe.required "git_push_url" Jdec.string
        |> Jpipe.required "html_url" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "public" Jdec.bool
        |> Jpipe.required "truncated" Jdec.bool
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "user" (Jdec.null ())

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("comments", Jenc.int x.comments)
        , ("comments_url", Jenc.string x.commentsURL)
        , ("commits_url", Jenc.string x.commitsURL)
        , ("created_at", Jenc.string x.createdAt)
        , ("description", makeNullableEncoder Jenc.string x.description)
        , ("files", Jenc.dict identity encodeFile x.files)
        , ("forks_url", Jenc.string x.forksURL)
        , ("git_pull_url", Jenc.string x.gitPullURL)
        , ("git_push_url", Jenc.string x.gitPushURL)
        , ("html_url", Jenc.string x.htmlURL)
        , ("id", Jenc.string x.id)
        , ("public", Jenc.bool x.public)
        , ("truncated", Jenc.bool x.truncated)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("url", Jenc.string x.url)
        , ("user", always Jenc.null x.user)
        ]

file : Jdec.Decoder File
file =
    Jdec.succeed File
        |> Jpipe.required "type" purpleType
        |> Jpipe.required "filename" Jdec.string
        |> Jpipe.required "language" (Jdec.nullable language)
        |> Jpipe.required "raw_url" Jdec.string
        |> Jpipe.required "size" Jdec.int

encodeFile : File -> Jenc.Value
encodeFile x =
    Jenc.object
        [ ("type", encodeType x.fileType)
        , ("filename", Jenc.string x.filename)
        , ("language", makeNullableEncoder encodeLanguage x.language)
        , ("raw_url", Jenc.string x.rawURL)
        , ("size", Jenc.int x.size)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "text/plain" -> Jdec.succeed TextPlain
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    TextPlain -> Jenc.string "text/plain"

language : Jdec.Decoder Language
language =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Markdown" -> Jdec.succeed Markdown
                somethingElse -> Jdec.fail <| "Invalid Language: " ++ somethingElse
        )

encodeLanguage : Language -> Jenc.Value
encodeLanguage x = case x of
    Markdown -> Jenc.string "Markdown"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
