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
    , Invoice
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { invoices : List Invoice
    }

type alias Invoice =
    { createdAt : Maybe String
    , dueDate : Maybe String
    , name : String
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
        |> Jpipe.required "invoices" (Jdec.list invoice )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("invoices", Jenc.list encodeInvoice x.invoices)
        ]

invoice : Jdec.Decoder Invoice
invoice =
    Jdec.succeed Invoice
        |> Jpipe.required "createdAt" (Jdec.nullable Jdec.string)
        |> Jpipe.required "dueDate" (Jdec.nullable Jdec.string)
        |> Jpipe.required "name" Jdec.string

encodeInvoice : Invoice -> Jenc.Value
encodeInvoice x =
    Jenc.object
        [ ("createdAt", makeNullableEncoder Jenc.string x.createdAt)
        , ("dueDate", makeNullableEncoder Jenc.string x.dueDate)
        , ("name", Jenc.string x.name)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
