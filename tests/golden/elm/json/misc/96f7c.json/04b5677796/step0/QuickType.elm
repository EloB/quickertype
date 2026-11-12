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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { git : List String
    , githubServicesSHA : String
    , hooks : List String
    , importer : List String
    , pages : List String
    , verifiablePasswordAuthentication : Bool
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
        |> Jpipe.required "git" (Jdec.list Jdec.string )
        |> Jpipe.required "github_services_sha" Jdec.string
        |> Jpipe.required "hooks" (Jdec.list Jdec.string )
        |> Jpipe.required "importer" (Jdec.list Jdec.string )
        |> Jpipe.required "pages" (Jdec.list Jdec.string )
        |> Jpipe.required "verifiable_password_authentication" Jdec.bool

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("git", Jenc.list Jenc.string x.git)
        , ("github_services_sha", Jenc.string x.githubServicesSHA)
        , ("hooks", Jenc.list Jenc.string x.hooks)
        , ("importer", Jenc.list Jenc.string x.importer)
        , ("pages", Jenc.list Jenc.string x.pages)
        , ("verifiable_password_authentication", Jenc.bool x.verifiablePasswordAuthentication)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
