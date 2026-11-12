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
    , Item
    , Address
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { item : List Item
    }

type alias Item =
    { address : Maybe Address
    , createdAt : Maybe String
    , name : String
    , sex : Maybe Int
    }

type alias Address =
    { city : String
    , country : String
    , street : String
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
        |> Jpipe.required "item" (Jdec.list item )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("item", Jenc.list encodeItem x.item)
        ]

item : Jdec.Decoder Item
item =
    Jdec.succeed Item
        |> Jpipe.custom (optionalField "address" (Jdec.map Just address) Nothing)
        |> Jpipe.custom (optionalField "created_at" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "sex" (Jdec.nullable Jdec.int)

encodeItem : Item -> Jenc.Value
encodeItem x =
    Jenc.object
        [ ("address", makeNullableEncoder encodeAddress x.address)
        , ("created_at", makeNullableEncoder Jenc.string x.createdAt)
        , ("name", Jenc.string x.name)
        , ("sex", makeNullableEncoder Jenc.int x.sex)
        ]

address : Jdec.Decoder Address
address =
    Jdec.succeed Address
        |> Jpipe.required "city" Jdec.string
        |> Jpipe.required "country" Jdec.string
        |> Jpipe.required "street" Jdec.string

encodeAddress : Address -> Jenc.Value
encodeAddress x =
    Jenc.object
        [ ("city", Jenc.string x.city)
        , ("country", Jenc.string x.country)
        , ("street", Jenc.string x.street)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
