{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Metadata (..)
    , ResponseInfo (..)
    , Resultset (..)
    , ResultElement (..)
    , HiringOrg (..)
    , Location (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { metadataQuickType :: Metadata
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data Metadata = Metadata
    { executionTimeMetadata :: Double
    , responseInfoMetadata :: ResponseInfo
    , resultsetMetadata :: Resultset
    } deriving (Show)

data ResponseInfo = ResponseInfo
    { developerMessageResponseInfo :: Text
    , statusResponseInfo :: Int
    } deriving (Show)

data Resultset = Resultset
    { countResultset :: Int
    , pageResultset :: Int
    , pagesizeResultset :: Int
    } deriving (Show)

data ResultElement = ResultElement
    { aboutOfficeResultElement :: Text
    , applicationProcessResultElement :: Text
    , bodyResultElement :: Text
    , changedResultElement :: Text
    , createdResultElement :: Text
    , deadlineResultElement :: Maybe Text
    , hiringOfficeResultElement :: Maybe Text
    , hiringOrgResultElement :: HiringOrg
    , jobIDResultElement :: Maybe Text
    , languageResultElement :: Text
    , locationResultElement :: Location
    , numPositionsResultElement :: Text
    , positionResultElement :: Text
    , practiceAreaResultElement :: Text
    , qualificationsResultElement :: Text
    , relocationExpensesResultElement :: Maybe Text
    , salaryResultElement :: Text
    , titleResultElement :: Text
    , travelResultElement :: Text
    , urlResultElement :: Text
    , uuidResultElement :: Text
    , vuuidResultElement :: Text
    } deriving (Show)

data HiringOrg = HiringOrg
    { nameHiringOrg :: Text
    , uuidHiringOrg :: Text
    } deriving (Show)

data Location = Location
    { administrativeAreaLocation :: Text
    , countryLocation :: Text
    , faxNumberLocation :: Text
    , localityLocation :: Text
    , mobileNumberLocation :: Text
    , phoneNumberLocation :: Text
    , phoneNumberExtensionLocation :: Text
    , postalCodeLocation :: Text
    , subPremiseLocation :: Maybe Text
    , thoroughfareLocation :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType metadataQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "metadata" .= metadataQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "metadata"
        <*> v .: "results"

instance ToJSON Metadata where
    toJSON (Metadata executionTimeMetadata responseInfoMetadata resultsetMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "executionTime" .= executionTimeMetadata
        , Just $ "responseInfo" .= responseInfoMetadata
        , Just $ "resultset" .= resultsetMetadata
        ]

instance FromJSON Metadata where
    parseJSON (Object v) = Metadata
        <$> v .: "executionTime"
        <*> v .: "responseInfo"
        <*> v .: "resultset"

instance ToJSON ResponseInfo where
    toJSON (ResponseInfo developerMessageResponseInfo statusResponseInfo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "developerMessage" .= developerMessageResponseInfo
        , Just $ "status" .= statusResponseInfo
        ]

instance FromJSON ResponseInfo where
    parseJSON (Object v) = ResponseInfo
        <$> v .: "developerMessage"
        <*> v .: "status"

instance ToJSON Resultset where
    toJSON (Resultset countResultset pageResultset pagesizeResultset) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countResultset
        , Just $ "page" .= pageResultset
        , Just $ "pagesize" .= pagesizeResultset
        ]

instance FromJSON Resultset where
    parseJSON (Object v) = Resultset
        <$> v .: "count"
        <*> v .: "page"
        <*> v .: "pagesize"

instance ToJSON ResultElement where
    toJSON (ResultElement aboutOfficeResultElement applicationProcessResultElement bodyResultElement changedResultElement createdResultElement deadlineResultElement hiringOfficeResultElement hiringOrgResultElement jobIDResultElement languageResultElement locationResultElement numPositionsResultElement positionResultElement practiceAreaResultElement qualificationsResultElement relocationExpensesResultElement salaryResultElement titleResultElement travelResultElement urlResultElement uuidResultElement vuuidResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "about_office" .= aboutOfficeResultElement
        , Just $ "application_process" .= applicationProcessResultElement
        , Just $ "body" .= bodyResultElement
        , Just $ "changed" .= changedResultElement
        , Just $ "created" .= createdResultElement
        , Just $ "deadline" .= deadlineResultElement
        , Just $ "hiring_office" .= hiringOfficeResultElement
        , Just $ "hiring_org" .= hiringOrgResultElement
        , Just $ "job_id" .= jobIDResultElement
        , Just $ "language" .= languageResultElement
        , Just $ "location" .= locationResultElement
        , Just $ "num_positions" .= numPositionsResultElement
        , Just $ "position" .= positionResultElement
        , Just $ "practice_area" .= practiceAreaResultElement
        , Just $ "qualifications" .= qualificationsResultElement
        , Just $ "relocation_expenses" .= relocationExpensesResultElement
        , Just $ "salary" .= salaryResultElement
        , Just $ "title" .= titleResultElement
        , Just $ "travel" .= travelResultElement
        , Just $ "url" .= urlResultElement
        , Just $ "uuid" .= uuidResultElement
        , Just $ "vuuid" .= vuuidResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "about_office"
        <*> v .: "application_process"
        <*> v .: "body"
        <*> v .: "changed"
        <*> v .: "created"
        <*> v .: "deadline"
        <*> v .: "hiring_office"
        <*> v .: "hiring_org"
        <*> v .: "job_id"
        <*> v .: "language"
        <*> v .: "location"
        <*> v .: "num_positions"
        <*> v .: "position"
        <*> v .: "practice_area"
        <*> v .: "qualifications"
        <*> v .: "relocation_expenses"
        <*> v .: "salary"
        <*> v .: "title"
        <*> v .: "travel"
        <*> v .: "url"
        <*> v .: "uuid"
        <*> v .: "vuuid"

instance ToJSON HiringOrg where
    toJSON (HiringOrg nameHiringOrg uuidHiringOrg) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameHiringOrg
        , Just $ "uuid" .= uuidHiringOrg
        ]

instance FromJSON HiringOrg where
    parseJSON (Object v) = HiringOrg
        <$> v .: "name"
        <*> v .: "uuid"

instance ToJSON Location where
    toJSON (Location administrativeAreaLocation countryLocation faxNumberLocation localityLocation mobileNumberLocation phoneNumberLocation phoneNumberExtensionLocation postalCodeLocation subPremiseLocation thoroughfareLocation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "administrative_area" .= administrativeAreaLocation
        , Just $ "country" .= countryLocation
        , Just $ "fax_number" .= faxNumberLocation
        , Just $ "locality" .= localityLocation
        , Just $ "mobile_number" .= mobileNumberLocation
        , Just $ "phone_number" .= phoneNumberLocation
        , Just $ "phone_number_extension" .= phoneNumberExtensionLocation
        , Just $ "postal_code" .= postalCodeLocation
        , Just $ "sub_premise" .= subPremiseLocation
        , Just $ "thoroughfare" .= thoroughfareLocation
        ]

instance FromJSON Location where
    parseJSON (Object v) = Location
        <$> v .: "administrative_area"
        <*> v .: "country"
        <*> v .: "fax_number"
        <*> v .: "locality"
        <*> v .: "mobile_number"
        <*> v .: "phone_number"
        <*> v .: "phone_number_extension"
        <*> v .: "postal_code"
        <*> v .: "sub_premise"
        <*> v .: "thoroughfare"
