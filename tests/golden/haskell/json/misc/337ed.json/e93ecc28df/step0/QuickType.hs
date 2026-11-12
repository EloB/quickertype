{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Facets (..)
    , ResultElement (..)
    , CustomIncome (..)
    , CustomIncomeType (..)
    , Status (..)
    , ResultType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { countQuickType :: Int
    , facetsQuickType :: Facets
    , limitQuickType :: Int
    , nextQuickType :: Text
    , offsetQuickType :: Int
    , previousQuickType :: Bool
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data Facets = Facets
    {
    } deriving (Show)

data ResultElement = ResultElement
    { costAbsoluteResultElement :: Maybe Int
    , costMaxResultElement :: Maybe Int
    , costMinResultElement :: Maybe Int
    , createdAtResultElement :: Text
    , customIncomesResultElement :: [CustomIncome]
    , directRepCostsMaxResultElement :: Maybe Text
    , directRepCostsMinResultElement :: Maybe Text
    , endDateResultElement :: Text
    , eurSourcesGrantsResultElement :: Int
    , eurSourcesGrantsSrcResultElement :: Maybe Text
    , eurSourcesProcurementResultElement :: Int
    , eurSourcesProcurementSrcResultElement :: Maybe Text
    , newOrganisationResultElement :: Maybe Text
    , noClientsResultElement :: Maybe Text
    , otherFinancialInformationResultElement :: Maybe Text
    , otherSourcesContributionsResultElement :: Maybe Int
    , otherSourcesDonationResultElement :: Maybe Int
    , otherSourcesTotalResultElement :: Maybe Int
    , publicFinancingInfranationalResultElement :: Maybe Int
    , publicFinancingNationalResultElement :: Maybe Int
    , publicFinancingTotalResultElement :: Maybe Int
    , representativeResultElement :: Text
    , resultIDResultElement :: Text
    , resultTypeResultElement :: ResultType
    , startDateResultElement :: Text
    , statusResultElement :: Status
    , totalBudgetResultElement :: Maybe Int
    , turnoverAbsoluteResultElement :: Maybe Int
    , turnoverMaxResultElement :: Maybe Int
    , turnoverMinResultElement :: Maybe Int
    , updatedAtResultElement :: Text
    , uriResultElement :: Text
    } deriving (Show)

data CustomIncome = CustomIncome
    { amountCustomIncome :: Int
    , createdAtCustomIncome :: Text
    , customIncomeIDCustomIncome :: Text
    , customIncomeTypeCustomIncome :: CustomIncomeType
    , nameCustomIncome :: Text
    , statusCustomIncome :: Status
    , updatedAtCustomIncome :: Text
    , uriCustomIncome :: Text
    } deriving (Show)

data CustomIncomeType
    = PublicCustomIncomeType
    | OtherCustomIncomeType
    deriving (Show)

data Status
    = ActiveStatus
    | InactiveStatus
    deriving (Show)

data ResultType
    = FinancialDataNGOResultType
    | FinancialDataLawyerResultType
    | FinancialDataTradeAssociationResultType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType countQuickType facetsQuickType limitQuickType nextQuickType offsetQuickType previousQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countQuickType
        , Just $ "facets" .= facetsQuickType
        , Just $ "limit" .= limitQuickType
        , Just $ "next" .= nextQuickType
        , Just $ "offset" .= offsetQuickType
        , Just $ "previous" .= previousQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "count"
        <*> v .: "facets"
        <*> v .: "limit"
        <*> v .: "next"
        <*> v .: "offset"
        <*> v .: "previous"
        <*> v .: "results"

instance ToJSON Facets where
    toJSON = \_ -> emptyObject

instance FromJSON Facets where
    parseJSON (Object _) = return Facets

instance ToJSON ResultElement where
    toJSON (ResultElement costAbsoluteResultElement costMaxResultElement costMinResultElement createdAtResultElement customIncomesResultElement directRepCostsMaxResultElement directRepCostsMinResultElement endDateResultElement eurSourcesGrantsResultElement eurSourcesGrantsSrcResultElement eurSourcesProcurementResultElement eurSourcesProcurementSrcResultElement newOrganisationResultElement noClientsResultElement otherFinancialInformationResultElement otherSourcesContributionsResultElement otherSourcesDonationResultElement otherSourcesTotalResultElement publicFinancingInfranationalResultElement publicFinancingNationalResultElement publicFinancingTotalResultElement representativeResultElement resultIDResultElement resultTypeResultElement startDateResultElement statusResultElement totalBudgetResultElement turnoverAbsoluteResultElement turnoverMaxResultElement turnoverMinResultElement updatedAtResultElement uriResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "cost_absolute" .= costAbsoluteResultElement
        , Just $ "cost_max" .= costMaxResultElement
        , Just $ "cost_min" .= costMinResultElement
        , Just $ "created_at" .= createdAtResultElement
        , Just $ "customIncomes" .= customIncomesResultElement
        , Just $ "direct_rep_costs_max" .= directRepCostsMaxResultElement
        , Just $ "direct_rep_costs_min" .= directRepCostsMinResultElement
        , Just $ "end_date" .= endDateResultElement
        , Just $ "eur_sources_grants" .= eurSourcesGrantsResultElement
        , Just $ "eur_sources_grants_src" .= eurSourcesGrantsSrcResultElement
        , Just $ "eur_sources_procurement" .= eurSourcesProcurementResultElement
        , Just $ "eur_sources_procurement_src" .= eurSourcesProcurementSrcResultElement
        , Just $ "new_organisation" .= newOrganisationResultElement
        , Just $ "no_clients" .= noClientsResultElement
        , Just $ "other_financial_information" .= otherFinancialInformationResultElement
        , Just $ "other_sources_contributions" .= otherSourcesContributionsResultElement
        , Just $ "other_sources_donation" .= otherSourcesDonationResultElement
        , Just $ "other_sources_total" .= otherSourcesTotalResultElement
        , Just $ "public_financing_infranational" .= publicFinancingInfranationalResultElement
        , Just $ "public_financing_national" .= publicFinancingNationalResultElement
        , Just $ "public_financing_total" .= publicFinancingTotalResultElement
        , Just $ "representative" .= representativeResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "type" .= resultTypeResultElement
        , Just $ "start_date" .= startDateResultElement
        , Just $ "status" .= statusResultElement
        , Just $ "total_budget" .= totalBudgetResultElement
        , Just $ "turnover_absolute" .= turnoverAbsoluteResultElement
        , Just $ "turnover_max" .= turnoverMaxResultElement
        , Just $ "turnover_min" .= turnoverMinResultElement
        , Just $ "updated_at" .= updatedAtResultElement
        , Just $ "uri" .= uriResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "cost_absolute"
        <*> v .: "cost_max"
        <*> v .: "cost_min"
        <*> v .: "created_at"
        <*> v .: "customIncomes"
        <*> v .: "direct_rep_costs_max"
        <*> v .: "direct_rep_costs_min"
        <*> v .: "end_date"
        <*> v .: "eur_sources_grants"
        <*> v .: "eur_sources_grants_src"
        <*> v .: "eur_sources_procurement"
        <*> v .: "eur_sources_procurement_src"
        <*> v .: "new_organisation"
        <*> v .: "no_clients"
        <*> v .: "other_financial_information"
        <*> v .: "other_sources_contributions"
        <*> v .: "other_sources_donation"
        <*> v .: "other_sources_total"
        <*> v .: "public_financing_infranational"
        <*> v .: "public_financing_national"
        <*> v .: "public_financing_total"
        <*> v .: "representative"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "start_date"
        <*> v .: "status"
        <*> v .: "total_budget"
        <*> v .: "turnover_absolute"
        <*> v .: "turnover_max"
        <*> v .: "turnover_min"
        <*> v .: "updated_at"
        <*> v .: "uri"

instance ToJSON CustomIncome where
    toJSON (CustomIncome amountCustomIncome createdAtCustomIncome customIncomeIDCustomIncome customIncomeTypeCustomIncome nameCustomIncome statusCustomIncome updatedAtCustomIncome uriCustomIncome) =
        object $ foldMap (maybe [] pure)
        [ Just $ "amount" .= amountCustomIncome
        , Just $ "created_at" .= createdAtCustomIncome
        , Just $ "id" .= customIncomeIDCustomIncome
        , Just $ "type" .= customIncomeTypeCustomIncome
        , Just $ "name" .= nameCustomIncome
        , Just $ "status" .= statusCustomIncome
        , Just $ "updated_at" .= updatedAtCustomIncome
        , Just $ "uri" .= uriCustomIncome
        ]

instance FromJSON CustomIncome where
    parseJSON (Object v) = CustomIncome
        <$> v .: "amount"
        <*> v .: "created_at"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "name"
        <*> v .: "status"
        <*> v .: "updated_at"
        <*> v .: "uri"

instance ToJSON CustomIncomeType where
    toJSON PublicCustomIncomeType = "public"
    toJSON OtherCustomIncomeType = "other"

instance FromJSON CustomIncomeType where
    parseJSON = withText "CustomIncomeType" parseText
        where
            parseText "public" = return PublicCustomIncomeType
            parseText "other" = return OtherCustomIncomeType

instance ToJSON Status where
    toJSON ActiveStatus = "active"
    toJSON InactiveStatus = "inactive"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "active" = return ActiveStatus
            parseText "inactive" = return InactiveStatus

instance ToJSON ResultType where
    toJSON FinancialDataNGOResultType = "FinancialDataNGO"
    toJSON FinancialDataLawyerResultType = "FinancialDataLawyer"
    toJSON FinancialDataTradeAssociationResultType = "FinancialDataTradeAssociation"

instance FromJSON ResultType where
    parseJSON = withText "ResultType" parseText
        where
            parseText "FinancialDataNGO" = return FinancialDataNGOResultType
            parseText "FinancialDataLawyer" = return FinancialDataLawyerResultType
            parseText "FinancialDataTradeAssociation" = return FinancialDataTradeAssociationResultType
