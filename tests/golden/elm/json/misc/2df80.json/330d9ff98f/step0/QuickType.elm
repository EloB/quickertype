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
    , PurpleQuickType
    , Adminregion
    , FluffyQuickType
    , IDEnum(..)
    , ValueEnum(..)
    , QuickTypeUnion(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeUnion

type QuickTypeUnion
    = FluffyQuickTypeInQuickTypeUnion FluffyQuickType
    | PurpleQuickTypeArrayInQuickTypeUnion (List PurpleQuickType)

type alias PurpleQuickType =
    { adminregion : Adminregion
    , capitalCity : String
    , id : String
    , incomeLevel : Adminregion
    , iso2Code : String
    , latitude : String
    , lendingType : Adminregion
    , longitude : String
    , name : String
    , region : Adminregion
    }

type alias Adminregion =
    { id : IDEnum
    , value : ValueEnum
    }

type IDEnum
    = ID
    | SAS
    | SSA
    | Eca
    | Lac
    | EAP
    | Mna
    | Hic
    | Lic
    | Na
    | Lmc
    | Umc
    | Lnx
    | Idx
    | Ibd
    | Idb
    | Lcn
    | Ssf
    | Ecs
    | Mea
    | EAS
    | Nac

type ValueEnum
    = Value
    | SouthAsia
    | SubSaharanAfricaExcludingHighIncome
    | EuropeCentralAsiaExcludingHighIncome
    | LatinAmericaCaribbeanExcludingHighIncome
    | EastAsiaPacificExcludingHighIncome
    | MiddleEastNorthAfricaExcludingHighIncome
    | HighIncome
    | LowIncome
    | Aggregates
    | LowerMiddleIncome
    | UpperMiddleIncome
    | NotClassified
    | Ida
    | Ibrd
    | Blend
    | LatinAmericaCaribbean
    | SubSaharanAfrica
    | EuropeCentralAsia
    | MiddleEastNorthAfrica
    | EastAsiaPacific
    | NorthAmerica

type alias FluffyQuickType =
    { page : Int
    , pages : Int
    , perPage : String
    , total : Int
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeUnion 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeUnion r)

quickTypeUnion : Jdec.Decoder QuickTypeUnion
quickTypeUnion =
    Jdec.oneOf
        [ Jdec.map PurpleQuickTypeArrayInQuickTypeUnion (Jdec.list purpleQuickType )
        , Jdec.map FluffyQuickTypeInQuickTypeUnion fluffyQuickType
        ]

encodeQuickTypeUnion : QuickTypeUnion -> Jenc.Value
encodeQuickTypeUnion x = case x of
    PurpleQuickTypeArrayInQuickTypeUnion y -> Jenc.list encodePurpleQuickType y
    FluffyQuickTypeInQuickTypeUnion y -> encodeFluffyQuickType y

purpleQuickType : Jdec.Decoder PurpleQuickType
purpleQuickType =
    Jdec.succeed PurpleQuickType
        |> Jpipe.required "adminregion" adminregion
        |> Jpipe.required "capitalCity" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "incomeLevel" adminregion
        |> Jpipe.required "iso2Code" Jdec.string
        |> Jpipe.required "latitude" Jdec.string
        |> Jpipe.required "lendingType" adminregion
        |> Jpipe.required "longitude" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "region" adminregion

encodePurpleQuickType : PurpleQuickType -> Jenc.Value
encodePurpleQuickType x =
    Jenc.object
        [ ("adminregion", encodeAdminregion x.adminregion)
        , ("capitalCity", Jenc.string x.capitalCity)
        , ("id", Jenc.string x.id)
        , ("incomeLevel", encodeAdminregion x.incomeLevel)
        , ("iso2Code", Jenc.string x.iso2Code)
        , ("latitude", Jenc.string x.latitude)
        , ("lendingType", encodeAdminregion x.lendingType)
        , ("longitude", Jenc.string x.longitude)
        , ("name", Jenc.string x.name)
        , ("region", encodeAdminregion x.region)
        ]

adminregion : Jdec.Decoder Adminregion
adminregion =
    Jdec.succeed Adminregion
        |> Jpipe.required "id" idEnum
        |> Jpipe.required "value" valueEnum

encodeAdminregion : Adminregion -> Jenc.Value
encodeAdminregion x =
    Jenc.object
        [ ("id", encodeIDEnum x.id)
        , ("value", encodeValueEnum x.value)
        ]

idEnum : Jdec.Decoder IDEnum
idEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed ID
                "SAS" -> Jdec.succeed SAS
                "SSA" -> Jdec.succeed SSA
                "ECA" -> Jdec.succeed Eca
                "LAC" -> Jdec.succeed Lac
                "EAP" -> Jdec.succeed EAP
                "MNA" -> Jdec.succeed Mna
                "HIC" -> Jdec.succeed Hic
                "LIC" -> Jdec.succeed Lic
                "NA" -> Jdec.succeed Na
                "LMC" -> Jdec.succeed Lmc
                "UMC" -> Jdec.succeed Umc
                "LNX" -> Jdec.succeed Lnx
                "IDX" -> Jdec.succeed Idx
                "IBD" -> Jdec.succeed Ibd
                "IDB" -> Jdec.succeed Idb
                "LCN" -> Jdec.succeed Lcn
                "SSF" -> Jdec.succeed Ssf
                "ECS" -> Jdec.succeed Ecs
                "MEA" -> Jdec.succeed Mea
                "EAS" -> Jdec.succeed EAS
                "NAC" -> Jdec.succeed Nac
                somethingElse -> Jdec.fail <| "Invalid IDEnum: " ++ somethingElse
        )

encodeIDEnum : IDEnum -> Jenc.Value
encodeIDEnum x = case x of
    ID -> Jenc.string ""
    SAS -> Jenc.string "SAS"
    SSA -> Jenc.string "SSA"
    Eca -> Jenc.string "ECA"
    Lac -> Jenc.string "LAC"
    EAP -> Jenc.string "EAP"
    Mna -> Jenc.string "MNA"
    Hic -> Jenc.string "HIC"
    Lic -> Jenc.string "LIC"
    Na -> Jenc.string "NA"
    Lmc -> Jenc.string "LMC"
    Umc -> Jenc.string "UMC"
    Lnx -> Jenc.string "LNX"
    Idx -> Jenc.string "IDX"
    Ibd -> Jenc.string "IBD"
    Idb -> Jenc.string "IDB"
    Lcn -> Jenc.string "LCN"
    Ssf -> Jenc.string "SSF"
    Ecs -> Jenc.string "ECS"
    Mea -> Jenc.string "MEA"
    EAS -> Jenc.string "EAS"
    Nac -> Jenc.string "NAC"

valueEnum : Jdec.Decoder ValueEnum
valueEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Value
                "South Asia" -> Jdec.succeed SouthAsia
                "Sub-Saharan Africa (excluding high income)" -> Jdec.succeed SubSaharanAfricaExcludingHighIncome
                "Europe & Central Asia (excluding high income)" -> Jdec.succeed EuropeCentralAsiaExcludingHighIncome
                "Latin America & Caribbean (excluding high income)" -> Jdec.succeed LatinAmericaCaribbeanExcludingHighIncome
                "East Asia & Pacific (excluding high income)" -> Jdec.succeed EastAsiaPacificExcludingHighIncome
                "Middle East & North Africa (excluding high income)" -> Jdec.succeed MiddleEastNorthAfricaExcludingHighIncome
                "High income" -> Jdec.succeed HighIncome
                "Low income" -> Jdec.succeed LowIncome
                "Aggregates" -> Jdec.succeed Aggregates
                "Lower middle income" -> Jdec.succeed LowerMiddleIncome
                "Upper middle income" -> Jdec.succeed UpperMiddleIncome
                "Not classified" -> Jdec.succeed NotClassified
                "IDA" -> Jdec.succeed Ida
                "IBRD" -> Jdec.succeed Ibrd
                "Blend" -> Jdec.succeed Blend
                "Latin America & Caribbean " -> Jdec.succeed LatinAmericaCaribbean
                "Sub-Saharan Africa " -> Jdec.succeed SubSaharanAfrica
                "Europe & Central Asia" -> Jdec.succeed EuropeCentralAsia
                "Middle East & North Africa" -> Jdec.succeed MiddleEastNorthAfrica
                "East Asia & Pacific" -> Jdec.succeed EastAsiaPacific
                "North America" -> Jdec.succeed NorthAmerica
                somethingElse -> Jdec.fail <| "Invalid ValueEnum: " ++ somethingElse
        )

encodeValueEnum : ValueEnum -> Jenc.Value
encodeValueEnum x = case x of
    Value -> Jenc.string ""
    SouthAsia -> Jenc.string "South Asia"
    SubSaharanAfricaExcludingHighIncome -> Jenc.string "Sub-Saharan Africa (excluding high income)"
    EuropeCentralAsiaExcludingHighIncome -> Jenc.string "Europe & Central Asia (excluding high income)"
    LatinAmericaCaribbeanExcludingHighIncome -> Jenc.string "Latin America & Caribbean (excluding high income)"
    EastAsiaPacificExcludingHighIncome -> Jenc.string "East Asia & Pacific (excluding high income)"
    MiddleEastNorthAfricaExcludingHighIncome -> Jenc.string "Middle East & North Africa (excluding high income)"
    HighIncome -> Jenc.string "High income"
    LowIncome -> Jenc.string "Low income"
    Aggregates -> Jenc.string "Aggregates"
    LowerMiddleIncome -> Jenc.string "Lower middle income"
    UpperMiddleIncome -> Jenc.string "Upper middle income"
    NotClassified -> Jenc.string "Not classified"
    Ida -> Jenc.string "IDA"
    Ibrd -> Jenc.string "IBRD"
    Blend -> Jenc.string "Blend"
    LatinAmericaCaribbean -> Jenc.string "Latin America & Caribbean "
    SubSaharanAfrica -> Jenc.string "Sub-Saharan Africa "
    EuropeCentralAsia -> Jenc.string "Europe & Central Asia"
    MiddleEastNorthAfrica -> Jenc.string "Middle East & North Africa"
    EastAsiaPacific -> Jenc.string "East Asia & Pacific"
    NorthAmerica -> Jenc.string "North America"

fluffyQuickType : Jdec.Decoder FluffyQuickType
fluffyQuickType =
    Jdec.succeed FluffyQuickType
        |> Jpipe.required "page" Jdec.int
        |> Jpipe.required "pages" Jdec.int
        |> Jpipe.required "per_page" Jdec.string
        |> Jpipe.required "total" Jdec.int

encodeFluffyQuickType : FluffyQuickType -> Jenc.Value
encodeFluffyQuickType x =
    Jenc.object
        [ ("page", Jenc.int x.page)
        , ("pages", Jenc.int x.pages)
        , ("per_page", Jenc.string x.perPage)
        , ("total", Jenc.int x.total)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
