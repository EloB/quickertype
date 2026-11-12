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
    , Prize
    , Laureate
    , Category(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { prizes : List Prize
    }

type alias Prize =
    { category : Category
    , laureates : List Laureate
    , overallMotivation : Maybe String
    , year : String
    }

type Category
    = Physics
    | Chemistry
    | Medicine
    | Literature
    | Peace
    | Economics

type alias Laureate =
    { firstname : String
    , id : String
    , motivation : Maybe String
    , share : String
    , surname : String
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
        |> Jpipe.required "prizes" (Jdec.list prize )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("prizes", Jenc.list encodePrize x.prizes)
        ]

prize : Jdec.Decoder Prize
prize =
    Jdec.succeed Prize
        |> Jpipe.required "category" category
        |> Jpipe.required "laureates" (Jdec.list laureate )
        |> Jpipe.custom (optionalField "overallMotivation" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "year" Jdec.string

encodePrize : Prize -> Jenc.Value
encodePrize x =
    Jenc.object
        [ ("category", encodeCategory x.category)
        , ("laureates", Jenc.list encodeLaureate x.laureates)
        , ("overallMotivation", makeNullableEncoder Jenc.string x.overallMotivation)
        , ("year", Jenc.string x.year)
        ]

category : Jdec.Decoder Category
category =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "physics" -> Jdec.succeed Physics
                "chemistry" -> Jdec.succeed Chemistry
                "medicine" -> Jdec.succeed Medicine
                "literature" -> Jdec.succeed Literature
                "peace" -> Jdec.succeed Peace
                "economics" -> Jdec.succeed Economics
                somethingElse -> Jdec.fail <| "Invalid Category: " ++ somethingElse
        )

encodeCategory : Category -> Jenc.Value
encodeCategory x = case x of
    Physics -> Jenc.string "physics"
    Chemistry -> Jenc.string "chemistry"
    Medicine -> Jenc.string "medicine"
    Literature -> Jenc.string "literature"
    Peace -> Jenc.string "peace"
    Economics -> Jenc.string "economics"

laureate : Jdec.Decoder Laureate
laureate =
    Jdec.succeed Laureate
        |> Jpipe.required "firstname" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "motivation" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "share" Jdec.string
        |> Jpipe.required "surname" Jdec.string

encodeLaureate : Laureate -> Jenc.Value
encodeLaureate x =
    Jenc.object
        [ ("firstname", Jenc.string x.firstname)
        , ("id", Jenc.string x.id)
        , ("motivation", makeNullableEncoder Jenc.string x.motivation)
        , ("share", Jenc.string x.share)
        , ("surname", Jenc.string x.surname)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
