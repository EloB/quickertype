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
    , Errors
    , Datum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { code : String
    , columnNames : List String
    , data : List (List Datum)
    , description : String
    , displayURL : String
    , errors : Errors
    , frequency : String
    , fromDate : String
    , id : Int
    , name : String
    , premium : Bool
    , quickTypeType : String
    , sourceCode : String
    , sourceName : String
    , toDate : String
    , updatedAt : String
    , urlizeName : String
    }

type Datum
    = DoubleInDatum Float
    | NullInDatum
    | StringInDatum String

type alias Errors =
    {
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
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "column_names" (Jdec.list Jdec.string )
        |> Jpipe.required "data" (Jdec.list (Jdec.list datum ) )
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "display_url" Jdec.string
        |> Jpipe.required "errors" errors
        |> Jpipe.required "frequency" Jdec.string
        |> Jpipe.required "from_date" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "premium" Jdec.bool
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "source_code" Jdec.string
        |> Jpipe.required "source_name" Jdec.string
        |> Jpipe.required "to_date" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "urlize_name" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("column_names", Jenc.list Jenc.string x.columnNames)
        , ("data", Jenc.list (Jenc.list encodeDatum) x.data)
        , ("description", Jenc.string x.description)
        , ("display_url", Jenc.string x.displayURL)
        , ("errors", encodeErrors x.errors)
        , ("frequency", Jenc.string x.frequency)
        , ("from_date", Jenc.string x.fromDate)
        , ("id", Jenc.int x.id)
        , ("name", Jenc.string x.name)
        , ("premium", Jenc.bool x.premium)
        , ("type", Jenc.string x.quickTypeType)
        , ("source_code", Jenc.string x.sourceCode)
        , ("source_name", Jenc.string x.sourceName)
        , ("to_date", Jenc.string x.toDate)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("urlize_name", Jenc.string x.urlizeName)
        ]

datum : Jdec.Decoder Datum
datum =
    Jdec.oneOf
        [ Jdec.null NullInDatum
        , Jdec.map StringInDatum Jdec.string
        , Jdec.map DoubleInDatum Jdec.float
        ]

encodeDatum : Datum -> Jenc.Value
encodeDatum x = case x of
    NullInDatum -> Jenc.null
    StringInDatum y -> Jenc.string y
    DoubleInDatum y -> Jenc.float y

errors : Jdec.Decoder Errors
errors =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Errors)

encodeErrors : Errors -> Jenc.Value
encodeErrors x =
    Jenc.object
        [
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
