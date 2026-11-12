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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { birthDate : Maybe String
    , birthDateIsProtected : Bool
    , genderTypeID : Int
    , notes : String
    , parliamentaryName : String
    , personID : Int
    , photoURL : String
    , preferredName : String
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
        |> Jpipe.required "BirthDate" (Jdec.nullable Jdec.string)
        |> Jpipe.required "BirthDateIsProtected" Jdec.bool
        |> Jpipe.required "GenderTypeID" Jdec.int
        |> Jpipe.required "Notes" Jdec.string
        |> Jpipe.required "ParliamentaryName" Jdec.string
        |> Jpipe.required "PersonID" Jdec.int
        |> Jpipe.required "PhotoURL" Jdec.string
        |> Jpipe.required "PreferredName" Jdec.string

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("BirthDate", makeNullableEncoder Jenc.string x.birthDate)
        , ("BirthDateIsProtected", Jenc.bool x.birthDateIsProtected)
        , ("GenderTypeID", Jenc.int x.genderTypeID)
        , ("Notes", Jenc.string x.notes)
        , ("ParliamentaryName", Jenc.string x.parliamentaryName)
        , ("PersonID", Jenc.int x.personID)
        , ("PhotoURL", Jenc.string x.photoURL)
        , ("PreferredName", Jenc.string x.preferredName)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
