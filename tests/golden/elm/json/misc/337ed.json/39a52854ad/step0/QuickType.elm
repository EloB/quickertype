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
    , Facets
    , Result
    , CustomIncome
    , CustomIncomeType(..)
    , Status(..)
    , ResultType(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { count : Int
    , facets : Facets
    , limit : Int
    , next : String
    , offset : Int
    , previous : Bool
    , results : List Result
    }

type alias Facets =
    {
    }

type alias Result =
    { costAbsolute : Maybe Int
    , costMax : Maybe Int
    , costMin : Maybe Int
    , createdAt : String
    , customIncomes : List CustomIncome
    , directRepCostsMax : ()
    , directRepCostsMin : ()
    , endDate : String
    , eurSourcesGrants : Int
    , eurSourcesGrantsSrc : Maybe String
    , eurSourcesProcurement : Int
    , eurSourcesProcurementSrc : Maybe String
    , id : String
    , newOrganisation : ()
    , noClients : Maybe String
    , otherFinancialInformation : Maybe String
    , otherSourcesContributions : Maybe Int
    , otherSourcesDonation : Maybe Int
    , otherSourcesTotal : Maybe Int
    , publicFinancingInfranational : Maybe Int
    , publicFinancingNational : Maybe Int
    , publicFinancingTotal : Maybe Int
    , representative : String
    , resultType : ResultType
    , startDate : String
    , status : Status
    , totalBudget : Maybe Int
    , turnoverAbsolute : Maybe Int
    , turnoverMax : Maybe Int
    , turnoverMin : Maybe Int
    , updatedAt : String
    , uri : String
    }

type alias CustomIncome =
    { amount : Int
    , createdAt : String
    , customIncomeType : CustomIncomeType
    , id : String
    , name : String
    , status : Status
    , updatedAt : String
    , uri : String
    }

type CustomIncomeType
    = Public
    | Other

type Status
    = Active
    | Inactive

type ResultType
    = FinancialDataNGO
    | FinancialDataLawyer
    | FinancialDataTradeAssociation

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
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "facets" facets
        |> Jpipe.required "limit" Jdec.int
        |> Jpipe.required "next" Jdec.string
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "previous" Jdec.bool
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("facets", encodeFacets x.facets)
        , ("limit", Jenc.int x.limit)
        , ("next", Jenc.string x.next)
        , ("offset", Jenc.int x.offset)
        , ("previous", Jenc.bool x.previous)
        , ("results", Jenc.list encodeResult x.results)
        ]

facets : Jdec.Decoder Facets
facets =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Facets)

encodeFacets : Facets -> Jenc.Value
encodeFacets x =
    Jenc.object
        [
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "cost_absolute" (Jdec.nullable Jdec.int)
        |> Jpipe.required "cost_max" (Jdec.nullable Jdec.int)
        |> Jpipe.required "cost_min" (Jdec.nullable Jdec.int)
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "customIncomes" (Jdec.list customIncome )
        |> Jpipe.required "direct_rep_costs_max" (Jdec.null ())
        |> Jpipe.required "direct_rep_costs_min" (Jdec.null ())
        |> Jpipe.required "end_date" Jdec.string
        |> Jpipe.required "eur_sources_grants" Jdec.int
        |> Jpipe.required "eur_sources_grants_src" (Jdec.nullable Jdec.string)
        |> Jpipe.required "eur_sources_procurement" Jdec.int
        |> Jpipe.required "eur_sources_procurement_src" (Jdec.nullable Jdec.string)
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "new_organisation" (Jdec.null ())
        |> Jpipe.required "no_clients" (Jdec.nullable Jdec.string)
        |> Jpipe.required "other_financial_information" (Jdec.nullable Jdec.string)
        |> Jpipe.required "other_sources_contributions" (Jdec.nullable Jdec.int)
        |> Jpipe.required "other_sources_donation" (Jdec.nullable Jdec.int)
        |> Jpipe.required "other_sources_total" (Jdec.nullable Jdec.int)
        |> Jpipe.required "public_financing_infranational" (Jdec.nullable Jdec.int)
        |> Jpipe.required "public_financing_national" (Jdec.nullable Jdec.int)
        |> Jpipe.required "public_financing_total" (Jdec.nullable Jdec.int)
        |> Jpipe.required "representative" Jdec.string
        |> Jpipe.required "type" resultType
        |> Jpipe.required "start_date" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "total_budget" (Jdec.nullable Jdec.int)
        |> Jpipe.required "turnover_absolute" (Jdec.nullable Jdec.int)
        |> Jpipe.required "turnover_max" (Jdec.nullable Jdec.int)
        |> Jpipe.required "turnover_min" (Jdec.nullable Jdec.int)
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "uri" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("cost_absolute", makeNullableEncoder Jenc.int x.costAbsolute)
        , ("cost_max", makeNullableEncoder Jenc.int x.costMax)
        , ("cost_min", makeNullableEncoder Jenc.int x.costMin)
        , ("created_at", Jenc.string x.createdAt)
        , ("customIncomes", Jenc.list encodeCustomIncome x.customIncomes)
        , ("direct_rep_costs_max", always Jenc.null x.directRepCostsMax)
        , ("direct_rep_costs_min", always Jenc.null x.directRepCostsMin)
        , ("end_date", Jenc.string x.endDate)
        , ("eur_sources_grants", Jenc.int x.eurSourcesGrants)
        , ("eur_sources_grants_src", makeNullableEncoder Jenc.string x.eurSourcesGrantsSrc)
        , ("eur_sources_procurement", Jenc.int x.eurSourcesProcurement)
        , ("eur_sources_procurement_src", makeNullableEncoder Jenc.string x.eurSourcesProcurementSrc)
        , ("id", Jenc.string x.id)
        , ("new_organisation", always Jenc.null x.newOrganisation)
        , ("no_clients", makeNullableEncoder Jenc.string x.noClients)
        , ("other_financial_information", makeNullableEncoder Jenc.string x.otherFinancialInformation)
        , ("other_sources_contributions", makeNullableEncoder Jenc.int x.otherSourcesContributions)
        , ("other_sources_donation", makeNullableEncoder Jenc.int x.otherSourcesDonation)
        , ("other_sources_total", makeNullableEncoder Jenc.int x.otherSourcesTotal)
        , ("public_financing_infranational", makeNullableEncoder Jenc.int x.publicFinancingInfranational)
        , ("public_financing_national", makeNullableEncoder Jenc.int x.publicFinancingNational)
        , ("public_financing_total", makeNullableEncoder Jenc.int x.publicFinancingTotal)
        , ("representative", Jenc.string x.representative)
        , ("type", encodeResultType x.resultType)
        , ("start_date", Jenc.string x.startDate)
        , ("status", encodeStatus x.status)
        , ("total_budget", makeNullableEncoder Jenc.int x.totalBudget)
        , ("turnover_absolute", makeNullableEncoder Jenc.int x.turnoverAbsolute)
        , ("turnover_max", makeNullableEncoder Jenc.int x.turnoverMax)
        , ("turnover_min", makeNullableEncoder Jenc.int x.turnoverMin)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("uri", Jenc.string x.uri)
        ]

customIncome : Jdec.Decoder CustomIncome
customIncome =
    Jdec.succeed CustomIncome
        |> Jpipe.required "amount" Jdec.int
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "type" customIncomeType
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "uri" Jdec.string

encodeCustomIncome : CustomIncome -> Jenc.Value
encodeCustomIncome x =
    Jenc.object
        [ ("amount", Jenc.int x.amount)
        , ("created_at", Jenc.string x.createdAt)
        , ("type", encodeCustomIncomeType x.customIncomeType)
        , ("id", Jenc.string x.id)
        , ("name", Jenc.string x.name)
        , ("status", encodeStatus x.status)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("uri", Jenc.string x.uri)
        ]

customIncomeType : Jdec.Decoder CustomIncomeType
customIncomeType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "public" -> Jdec.succeed Public
                "other" -> Jdec.succeed Other
                somethingElse -> Jdec.fail <| "Invalid CustomIncomeType: " ++ somethingElse
        )

encodeCustomIncomeType : CustomIncomeType -> Jenc.Value
encodeCustomIncomeType x = case x of
    Public -> Jenc.string "public"
    Other -> Jenc.string "other"

status : Jdec.Decoder Status
status =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "active" -> Jdec.succeed Active
                "inactive" -> Jdec.succeed Inactive
                somethingElse -> Jdec.fail <| "Invalid Status: " ++ somethingElse
        )

encodeStatus : Status -> Jenc.Value
encodeStatus x = case x of
    Active -> Jenc.string "active"
    Inactive -> Jenc.string "inactive"

resultType : Jdec.Decoder ResultType
resultType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "FinancialDataNGO" -> Jdec.succeed FinancialDataNGO
                "FinancialDataLawyer" -> Jdec.succeed FinancialDataLawyer
                "FinancialDataTradeAssociation" -> Jdec.succeed FinancialDataTradeAssociation
                somethingElse -> Jdec.fail <| "Invalid ResultType: " ++ somethingElse
        )

encodeResultType : ResultType -> Jenc.Value
encodeResultType x = case x of
    FinancialDataNGO -> Jenc.string "FinancialDataNGO"
    FinancialDataLawyer -> Jenc.string "FinancialDataLawyer"
    FinancialDataTradeAssociation -> Jenc.string "FinancialDataTradeAssociation"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
