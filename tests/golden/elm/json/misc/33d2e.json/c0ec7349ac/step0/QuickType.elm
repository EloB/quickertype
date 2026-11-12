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
    , Laureate
    , Prize
    , AffiliationClass
    , Gender(..)
    , Category(..)
    , AffiliationElement(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { laureates : List Laureate
    }

type alias Laureate =
    { born : String
    , bornCity : Maybe String
    , bornCountry : Maybe String
    , bornCountryCode : Maybe String
    , died : String
    , diedCity : Maybe String
    , diedCountry : Maybe String
    , diedCountryCode : Maybe String
    , firstname : Maybe String
    , gender : Gender
    , id : String
    , prizes : List Prize
    , surname : Maybe String
    }

type Gender
    = Male
    | Female
    | Org

type alias Prize =
    { affiliations : List AffiliationElement
    , category : Maybe Category
    , motivation : Maybe String
    , overallMotivation : Maybe String
    , share : Maybe String
    , year : Maybe String
    }

type AffiliationElement
    = AffiliationClassInAffiliationElement AffiliationClass
    | AnythingArrayInAffiliationElement (List Jdec.Value)

type alias AffiliationClass =
    { city : Maybe String
    , country : Maybe String
    , name : Maybe String
    }

type Category
    = Physics
    | Chemistry
    | Peace
    | Medicine
    | Literature
    | Economics

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
        |> Jpipe.required "laureates" (Jdec.list laureate )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("laureates", Jenc.list encodeLaureate x.laureates)
        ]

laureate : Jdec.Decoder Laureate
laureate =
    Jdec.succeed Laureate
        |> Jpipe.required "born" Jdec.string
        |> Jpipe.custom (optionalField "bornCity" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "bornCountry" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "bornCountryCode" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "died" Jdec.string
        |> Jpipe.custom (optionalField "diedCity" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "diedCountry" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "diedCountryCode" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "firstname" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "gender" gender
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "prizes" (Jdec.list prize )
        |> Jpipe.custom (optionalField "surname" (Jdec.map Just Jdec.string) Nothing)

encodeLaureate : Laureate -> Jenc.Value
encodeLaureate x =
    Jenc.object
        [ ("born", Jenc.string x.born)
        , ("bornCity", makeNullableEncoder Jenc.string x.bornCity)
        , ("bornCountry", makeNullableEncoder Jenc.string x.bornCountry)
        , ("bornCountryCode", makeNullableEncoder Jenc.string x.bornCountryCode)
        , ("died", Jenc.string x.died)
        , ("diedCity", makeNullableEncoder Jenc.string x.diedCity)
        , ("diedCountry", makeNullableEncoder Jenc.string x.diedCountry)
        , ("diedCountryCode", makeNullableEncoder Jenc.string x.diedCountryCode)
        , ("firstname", makeNullableEncoder Jenc.string x.firstname)
        , ("gender", encodeGender x.gender)
        , ("id", Jenc.string x.id)
        , ("prizes", Jenc.list encodePrize x.prizes)
        , ("surname", makeNullableEncoder Jenc.string x.surname)
        ]

gender : Jdec.Decoder Gender
gender =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "male" -> Jdec.succeed Male
                "female" -> Jdec.succeed Female
                "org" -> Jdec.succeed Org
                somethingElse -> Jdec.fail <| "Invalid Gender: " ++ somethingElse
        )

encodeGender : Gender -> Jenc.Value
encodeGender x = case x of
    Male -> Jenc.string "male"
    Female -> Jenc.string "female"
    Org -> Jenc.string "org"

prize : Jdec.Decoder Prize
prize =
    Jdec.succeed Prize
        |> Jpipe.required "affiliations" (Jdec.list affiliationElement )
        |> Jpipe.custom (optionalField "category" (Jdec.map Just category) Nothing)
        |> Jpipe.custom (optionalField "motivation" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "overallMotivation" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "share" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "year" (Jdec.map Just Jdec.string) Nothing)

encodePrize : Prize -> Jenc.Value
encodePrize x =
    Jenc.object
        [ ("affiliations", Jenc.list encodeAffiliationElement x.affiliations)
        , ("category", makeNullableEncoder encodeCategory x.category)
        , ("motivation", makeNullableEncoder Jenc.string x.motivation)
        , ("overallMotivation", makeNullableEncoder Jenc.string x.overallMotivation)
        , ("share", makeNullableEncoder Jenc.string x.share)
        , ("year", makeNullableEncoder Jenc.string x.year)
        ]

affiliationElement : Jdec.Decoder AffiliationElement
affiliationElement =
    Jdec.oneOf
        [ Jdec.map AnythingArrayInAffiliationElement (Jdec.list Jdec.value )
        , Jdec.map AffiliationClassInAffiliationElement affiliationClass
        ]

encodeAffiliationElement : AffiliationElement -> Jenc.Value
encodeAffiliationElement x = case x of
    AnythingArrayInAffiliationElement y -> Jenc.list identity y
    AffiliationClassInAffiliationElement y -> encodeAffiliationClass y

affiliationClass : Jdec.Decoder AffiliationClass
affiliationClass =
    Jdec.succeed AffiliationClass
        |> Jpipe.custom (optionalField "city" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "country" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "name" (Jdec.map Just Jdec.string) Nothing)

encodeAffiliationClass : AffiliationClass -> Jenc.Value
encodeAffiliationClass x =
    Jenc.object
        [ ("city", makeNullableEncoder Jenc.string x.city)
        , ("country", makeNullableEncoder Jenc.string x.country)
        , ("name", makeNullableEncoder Jenc.string x.name)
        ]

category : Jdec.Decoder Category
category =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "physics" -> Jdec.succeed Physics
                "chemistry" -> Jdec.succeed Chemistry
                "peace" -> Jdec.succeed Peace
                "medicine" -> Jdec.succeed Medicine
                "literature" -> Jdec.succeed Literature
                "economics" -> Jdec.succeed Economics
                somethingElse -> Jdec.fail <| "Invalid Category: " ++ somethingElse
        )

encodeCategory : Category -> Jenc.Value
encodeCategory x = case x of
    Physics -> Jenc.string "physics"
    Chemistry -> Jenc.string "chemistry"
    Peace -> Jenc.string "peace"
    Medicine -> Jenc.string "medicine"
    Literature -> Jenc.string "literature"
    Economics -> Jenc.string "economics"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
