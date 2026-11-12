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
    , CategoryEnum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { category : CategoryEnum
    }

type CategoryEnum
    = Empty
    | Category

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
        |> Jpipe.required "category" categoryEnum

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("category", encodeCategoryEnum x.category)
        ]

categoryEnum : Jdec.Decoder CategoryEnum
categoryEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                " " -> Jdec.succeed Empty
                "" -> Jdec.succeed Category
                somethingElse -> Jdec.fail <| "Invalid CategoryEnum: " ++ somethingElse
        )

encodeCategoryEnum : CategoryEnum -> Jenc.Value
encodeCategoryEnum x = case x of
    Empty -> Jenc.string " "
    Category -> Jenc.string ""

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
