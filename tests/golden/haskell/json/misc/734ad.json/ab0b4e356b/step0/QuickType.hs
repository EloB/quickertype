{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Facets (..)
    , ResultElement (..)
    , Status (..)
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
    { acronymResultElement :: Maybe Text
    , activityConsultCommitteesResultElement :: Text
    , activityEuLegislativeResultElement :: Text
    , activityExpertGroupsResultElement :: Text
    , activityHighLevelGroupsResultElement :: Text
    , activityIndustryForumsResultElement :: Text
    , activityInterGroupsResultElement :: Text
    , activityOtherResultElement :: Maybe Text
    , activityRelevantCommResultElement :: Text
    , beOfficeCountryResultElement :: Maybe Text
    , beOfficeLatResultElement :: Maybe (Maybe Double)
    , beOfficeLonResultElement :: Maybe (Maybe Double)
    , beOfficePhoneResultElement :: Maybe Text
    , beOfficePostCodeResultElement :: Maybe (Maybe Text)
    , beOfficePostboxResultElement :: Maybe (Maybe Text)
    , beOfficeStreetResultElement :: Maybe Text
    , beOfficeTownResultElement :: Maybe Text
    , codeOfConductResultElement :: Text
    , contactCountryResultElement :: Int
    , createdAtResultElement :: Text
    , entityResultElement :: Text
    , goalsResultElement :: Text
    , headResultElement :: Text
    , headOfficeCountryResultElement :: Text
    , headOfficeLatResultElement :: Maybe Double
    , headOfficeLonResultElement :: Maybe Double
    , headOfficePhoneResultElement :: Text
    , headOfficePostCodeResultElement :: Maybe Text
    , headOfficePostboxResultElement :: Maybe Text
    , headOfficeStreetResultElement :: Text
    , headOfficeTownResultElement :: Text
    , identificationCodeResultElement :: Text
    , infoMembersResultElement :: Text
    , lastUpdateDateResultElement :: Text
    , legalResultElement :: Text
    , legalStatusResultElement :: Text
    , mainCategoryResultElement :: Int
    , mainCategoryTitleResultElement :: Text
    , membersResultElement :: Int
    , members100ResultElement :: Maybe Int
    , members25ResultElement :: Maybe Int
    , members50ResultElement :: Maybe Int
    , members75ResultElement :: Maybe Int
    , membersFteResultElement :: Double
    , nameResultElement :: Text
    , nativeNameResultElement :: Maybe Text
    , networkingResultElement :: Maybe Text
    , numberOfNaturalPersonsResultElement :: Maybe Int
    , otherCodeOfConductResultElement :: Maybe Text
    , registrationDateResultElement :: Text
    , resultIDResultElement :: Text
    , statusResultElement :: Status
    , structureMembersResultElement :: Text
    , subCategoryResultElement :: Int
    , subCategoryTitleResultElement :: Text
    , updatedAtResultElement :: Text
    , uriResultElement :: Text
    , webSiteURLResultElement :: Maybe Text
    } deriving (Show)

data Status
    = ActiveStatus
    | InactiveStatus
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
    toJSON (ResultElement acronymResultElement activityConsultCommitteesResultElement activityEuLegislativeResultElement activityExpertGroupsResultElement activityHighLevelGroupsResultElement activityIndustryForumsResultElement activityInterGroupsResultElement activityOtherResultElement activityRelevantCommResultElement beOfficeCountryResultElement beOfficeLatResultElement beOfficeLonResultElement beOfficePhoneResultElement beOfficePostCodeResultElement beOfficePostboxResultElement beOfficeStreetResultElement beOfficeTownResultElement codeOfConductResultElement contactCountryResultElement createdAtResultElement entityResultElement goalsResultElement headResultElement headOfficeCountryResultElement headOfficeLatResultElement headOfficeLonResultElement headOfficePhoneResultElement headOfficePostCodeResultElement headOfficePostboxResultElement headOfficeStreetResultElement headOfficeTownResultElement identificationCodeResultElement infoMembersResultElement lastUpdateDateResultElement legalResultElement legalStatusResultElement mainCategoryResultElement mainCategoryTitleResultElement membersResultElement members100ResultElement members25ResultElement members50ResultElement members75ResultElement membersFteResultElement nameResultElement nativeNameResultElement networkingResultElement numberOfNaturalPersonsResultElement otherCodeOfConductResultElement registrationDateResultElement resultIDResultElement statusResultElement structureMembersResultElement subCategoryResultElement subCategoryTitleResultElement updatedAtResultElement uriResultElement webSiteURLResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "acronym" .= acronymResultElement
        , Just $ "activity_consult_committees" .= activityConsultCommitteesResultElement
        , Just $ "activity_eu_legislative" .= activityEuLegislativeResultElement
        , Just $ "activity_expert_groups" .= activityExpertGroupsResultElement
        , Just $ "activity_high_level_groups" .= activityHighLevelGroupsResultElement
        , Just $ "activity_industry_forums" .= activityIndustryForumsResultElement
        , Just $ "activity_inter_groups" .= activityInterGroupsResultElement
        , Just $ "activity_other" .= activityOtherResultElement
        , Just $ "activity_relevant_comm" .= activityRelevantCommResultElement
        , ("be_office_country" .=) <$> beOfficeCountryResultElement
        , ("be_office_lat" .=) <$> beOfficeLatResultElement
        , ("be_office_lon" .=) <$> beOfficeLonResultElement
        , ("be_office_phone" .=) <$> beOfficePhoneResultElement
        , ("be_office_post_code" .=) <$> beOfficePostCodeResultElement
        , ("be_office_postbox" .=) <$> beOfficePostboxResultElement
        , ("be_office_street" .=) <$> beOfficeStreetResultElement
        , ("be_office_town" .=) <$> beOfficeTownResultElement
        , Just $ "code_of_conduct" .= codeOfConductResultElement
        , Just $ "contact_country" .= contactCountryResultElement
        , Just $ "created_at" .= createdAtResultElement
        , Just $ "entity" .= entityResultElement
        , Just $ "goals" .= goalsResultElement
        , Just $ "head" .= headResultElement
        , Just $ "head_office_country" .= headOfficeCountryResultElement
        , Just $ "head_office_lat" .= headOfficeLatResultElement
        , Just $ "head_office_lon" .= headOfficeLonResultElement
        , Just $ "head_office_phone" .= headOfficePhoneResultElement
        , Just $ "head_office_post_code" .= headOfficePostCodeResultElement
        , Just $ "head_office_postbox" .= headOfficePostboxResultElement
        , Just $ "head_office_street" .= headOfficeStreetResultElement
        , Just $ "head_office_town" .= headOfficeTownResultElement
        , Just $ "identification_code" .= identificationCodeResultElement
        , Just $ "info_members" .= infoMembersResultElement
        , Just $ "last_update_date" .= lastUpdateDateResultElement
        , Just $ "legal" .= legalResultElement
        , Just $ "legal_status" .= legalStatusResultElement
        , Just $ "main_category" .= mainCategoryResultElement
        , Just $ "main_category_title" .= mainCategoryTitleResultElement
        , Just $ "members" .= membersResultElement
        , Just $ "members_100" .= members100ResultElement
        , Just $ "members_25" .= members25ResultElement
        , Just $ "members_50" .= members50ResultElement
        , Just $ "members_75" .= members75ResultElement
        , Just $ "members_fte" .= membersFteResultElement
        , Just $ "name" .= nameResultElement
        , Just $ "native_name" .= nativeNameResultElement
        , Just $ "networking" .= networkingResultElement
        , Just $ "number_of_natural_persons" .= numberOfNaturalPersonsResultElement
        , Just $ "other_code_of_conduct" .= otherCodeOfConductResultElement
        , Just $ "registration_date" .= registrationDateResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "status" .= statusResultElement
        , Just $ "structure_members" .= structureMembersResultElement
        , Just $ "sub_category" .= subCategoryResultElement
        , Just $ "sub_category_title" .= subCategoryTitleResultElement
        , Just $ "updated_at" .= updatedAtResultElement
        , Just $ "uri" .= uriResultElement
        , Just $ "web_site_url" .= webSiteURLResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "acronym"
        <*> v .: "activity_consult_committees"
        <*> v .: "activity_eu_legislative"
        <*> v .: "activity_expert_groups"
        <*> v .: "activity_high_level_groups"
        <*> v .: "activity_industry_forums"
        <*> v .: "activity_inter_groups"
        <*> v .: "activity_other"
        <*> v .: "activity_relevant_comm"
        <*> v .:! "be_office_country"
        <*> v .:! "be_office_lat"
        <*> v .:! "be_office_lon"
        <*> v .:! "be_office_phone"
        <*> v .:! "be_office_post_code"
        <*> v .:! "be_office_postbox"
        <*> v .:! "be_office_street"
        <*> v .:! "be_office_town"
        <*> v .: "code_of_conduct"
        <*> v .: "contact_country"
        <*> v .: "created_at"
        <*> v .: "entity"
        <*> v .: "goals"
        <*> v .: "head"
        <*> v .: "head_office_country"
        <*> v .: "head_office_lat"
        <*> v .: "head_office_lon"
        <*> v .: "head_office_phone"
        <*> v .: "head_office_post_code"
        <*> v .: "head_office_postbox"
        <*> v .: "head_office_street"
        <*> v .: "head_office_town"
        <*> v .: "identification_code"
        <*> v .: "info_members"
        <*> v .: "last_update_date"
        <*> v .: "legal"
        <*> v .: "legal_status"
        <*> v .: "main_category"
        <*> v .: "main_category_title"
        <*> v .: "members"
        <*> v .: "members_100"
        <*> v .: "members_25"
        <*> v .: "members_50"
        <*> v .: "members_75"
        <*> v .: "members_fte"
        <*> v .: "name"
        <*> v .: "native_name"
        <*> v .: "networking"
        <*> v .: "number_of_natural_persons"
        <*> v .: "other_code_of_conduct"
        <*> v .: "registration_date"
        <*> v .: "id"
        <*> v .: "status"
        <*> v .: "structure_members"
        <*> v .: "sub_category"
        <*> v .: "sub_category_title"
        <*> v .: "updated_at"
        <*> v .: "uri"
        <*> v .: "web_site_url"

instance ToJSON Status where
    toJSON ActiveStatus = "active"
    toJSON InactiveStatus = "inactive"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "active" = return ActiveStatus
            parseText "inactive" = return InactiveStatus
