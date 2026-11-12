{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Meta (..)
    , ObjectElement (..)
    , Extra (..)
    , Person (..)
    , Party (..)
    , Gender (..)
    , GenderLabel (..)
    , Namemod (..)
    , RoleType (..)
    , RoleTypeLabel (..)
    , Title (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { metaQuickType :: Meta
    , objectsQuickType :: [ObjectElement]
    } deriving (Show)

data Meta = Meta
    { limitMeta :: Int
    , offsetMeta :: Int
    , totalCountMeta :: Int
    } deriving (Show)

data ObjectElement = ObjectElement
    { caucusObjectElement :: Maybe Text
    , congressNumbersObjectElement :: [Int]
    , currentObjectElement :: Bool
    , descriptionObjectElement :: Text
    , districtObjectElement :: Int
    , enddateObjectElement :: Text
    , extraObjectElement :: Extra
    , leadershipTitleObjectElement :: Maybe Text
    , objectIDObjectElement :: Int
    , partyObjectElement :: Party
    , personObjectElement :: Person
    , phoneObjectElement :: Text
    , roleTypeObjectElement :: RoleType
    , roleTypeLabelObjectElement :: RoleTypeLabel
    , senatorClassObjectElement :: Maybe Text
    , senatorRankObjectElement :: Maybe Text
    , startdateObjectElement :: Text
    , stateObjectElement :: Text
    , titleObjectElement :: Title
    , titleLongObjectElement :: RoleTypeLabel
    , websiteObjectElement :: Text
    } deriving (Show)

data Extra = Extra
    { addressExtra :: Text
    , contactFormExtra :: Maybe Text
    , faxExtra :: Maybe (Maybe Text)
    , officeExtra :: Text
    , rssURLExtra :: Maybe Text
    } deriving (Show)

data Party
    = RepublicanParty
    | DemocratParty
    deriving (Show)

data Person = Person
    { bioguideidPerson :: Text
    , birthdayPerson :: Text
    , cspanidPerson :: Int
    , firstnamePerson :: Text
    , genderPerson :: Gender
    , genderLabelPerson :: GenderLabel
    , lastnamePerson :: Text
    , linkPerson :: Text
    , middlenamePerson :: Text
    , namePerson :: Text
    , namemodPerson :: Namemod
    , nicknamePerson :: Text
    , osidPerson :: Text
    , personIDPerson :: Int
    , pvsidPerson :: Maybe Text
    , sortnamePerson :: Text
    , twitteridPerson :: Maybe Text
    , youtubeidPerson :: Maybe Text
    } deriving (Show)

data Gender
    = MaleGender
    | FemaleGender
    deriving (Show)

data GenderLabel
    = MaleGenderLabel
    | FemaleGenderLabel
    deriving (Show)

data Namemod
    = PurpleNamemod
    | JrNamemod
    | IINamemod
    | IIINamemod
    | IVNamemod
    deriving (Show)

data RoleType
    = RepresentativeRoleType
    deriving (Show)

data RoleTypeLabel
    = RepresentativeRoleTypeLabel
    | DelegateRoleTypeLabel
    | ResidentCommissionerRoleTypeLabel
    deriving (Show)

data Title
    = RepTitle
    | CommishTitle
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType metaQuickType objectsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "meta" .= metaQuickType
        , Just $ "objects" .= objectsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "meta"
        <*> v .: "objects"

instance ToJSON Meta where
    toJSON (Meta limitMeta offsetMeta totalCountMeta) =
        object $ foldMap (maybe [] pure)
        [ Just $ "limit" .= limitMeta
        , Just $ "offset" .= offsetMeta
        , Just $ "total_count" .= totalCountMeta
        ]

instance FromJSON Meta where
    parseJSON (Object v) = Meta
        <$> v .: "limit"
        <*> v .: "offset"
        <*> v .: "total_count"

instance ToJSON ObjectElement where
    toJSON (ObjectElement caucusObjectElement congressNumbersObjectElement currentObjectElement descriptionObjectElement districtObjectElement enddateObjectElement extraObjectElement leadershipTitleObjectElement objectIDObjectElement partyObjectElement personObjectElement phoneObjectElement roleTypeObjectElement roleTypeLabelObjectElement senatorClassObjectElement senatorRankObjectElement startdateObjectElement stateObjectElement titleObjectElement titleLongObjectElement websiteObjectElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "caucus" .= caucusObjectElement
        , Just $ "congress_numbers" .= congressNumbersObjectElement
        , Just $ "current" .= currentObjectElement
        , Just $ "description" .= descriptionObjectElement
        , Just $ "district" .= districtObjectElement
        , Just $ "enddate" .= enddateObjectElement
        , Just $ "extra" .= extraObjectElement
        , Just $ "leadership_title" .= leadershipTitleObjectElement
        , Just $ "id" .= objectIDObjectElement
        , Just $ "party" .= partyObjectElement
        , Just $ "person" .= personObjectElement
        , Just $ "phone" .= phoneObjectElement
        , Just $ "role_type" .= roleTypeObjectElement
        , Just $ "role_type_label" .= roleTypeLabelObjectElement
        , Just $ "senator_class" .= senatorClassObjectElement
        , Just $ "senator_rank" .= senatorRankObjectElement
        , Just $ "startdate" .= startdateObjectElement
        , Just $ "state" .= stateObjectElement
        , Just $ "title" .= titleObjectElement
        , Just $ "title_long" .= titleLongObjectElement
        , Just $ "website" .= websiteObjectElement
        ]

instance FromJSON ObjectElement where
    parseJSON (Object v) = ObjectElement
        <$> v .: "caucus"
        <*> v .: "congress_numbers"
        <*> v .: "current"
        <*> v .: "description"
        <*> v .: "district"
        <*> v .: "enddate"
        <*> v .: "extra"
        <*> v .: "leadership_title"
        <*> v .: "id"
        <*> v .: "party"
        <*> v .: "person"
        <*> v .: "phone"
        <*> v .: "role_type"
        <*> v .: "role_type_label"
        <*> v .: "senator_class"
        <*> v .: "senator_rank"
        <*> v .: "startdate"
        <*> v .: "state"
        <*> v .: "title"
        <*> v .: "title_long"
        <*> v .: "website"

instance ToJSON Extra where
    toJSON (Extra addressExtra contactFormExtra faxExtra officeExtra rssURLExtra) =
        object $ foldMap (maybe [] pure)
        [ Just $ "address" .= addressExtra
        , ("contact_form" .=) <$> contactFormExtra
        , ("fax" .=) <$> faxExtra
        , Just $ "office" .= officeExtra
        , ("rss_url" .=) <$> rssURLExtra
        ]

instance FromJSON Extra where
    parseJSON (Object v) = Extra
        <$> v .: "address"
        <*> v .:! "contact_form"
        <*> v .:! "fax"
        <*> v .: "office"
        <*> v .:! "rss_url"

instance ToJSON Party where
    toJSON RepublicanParty = "Republican"
    toJSON DemocratParty = "Democrat"

instance FromJSON Party where
    parseJSON = withText "Party" parseText
        where
            parseText "Republican" = return RepublicanParty
            parseText "Democrat" = return DemocratParty

instance ToJSON Person where
    toJSON (Person bioguideidPerson birthdayPerson cspanidPerson firstnamePerson genderPerson genderLabelPerson lastnamePerson linkPerson middlenamePerson namePerson namemodPerson nicknamePerson osidPerson personIDPerson pvsidPerson sortnamePerson twitteridPerson youtubeidPerson) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bioguideid" .= bioguideidPerson
        , Just $ "birthday" .= birthdayPerson
        , Just $ "cspanid" .= cspanidPerson
        , Just $ "firstname" .= firstnamePerson
        , Just $ "gender" .= genderPerson
        , Just $ "gender_label" .= genderLabelPerson
        , Just $ "lastname" .= lastnamePerson
        , Just $ "link" .= linkPerson
        , Just $ "middlename" .= middlenamePerson
        , Just $ "name" .= namePerson
        , Just $ "namemod" .= namemodPerson
        , Just $ "nickname" .= nicknamePerson
        , Just $ "osid" .= osidPerson
        , Just $ "id" .= personIDPerson
        , Just $ "pvsid" .= pvsidPerson
        , Just $ "sortname" .= sortnamePerson
        , Just $ "twitterid" .= twitteridPerson
        , Just $ "youtubeid" .= youtubeidPerson
        ]

instance FromJSON Person where
    parseJSON (Object v) = Person
        <$> v .: "bioguideid"
        <*> v .: "birthday"
        <*> v .: "cspanid"
        <*> v .: "firstname"
        <*> v .: "gender"
        <*> v .: "gender_label"
        <*> v .: "lastname"
        <*> v .: "link"
        <*> v .: "middlename"
        <*> v .: "name"
        <*> v .: "namemod"
        <*> v .: "nickname"
        <*> v .: "osid"
        <*> v .: "id"
        <*> v .: "pvsid"
        <*> v .: "sortname"
        <*> v .: "twitterid"
        <*> v .: "youtubeid"

instance ToJSON Gender where
    toJSON MaleGender = "male"
    toJSON FemaleGender = "female"

instance FromJSON Gender where
    parseJSON = withText "Gender" parseText
        where
            parseText "male" = return MaleGender
            parseText "female" = return FemaleGender

instance ToJSON GenderLabel where
    toJSON MaleGenderLabel = "Male"
    toJSON FemaleGenderLabel = "Female"

instance FromJSON GenderLabel where
    parseJSON = withText "GenderLabel" parseText
        where
            parseText "Male" = return MaleGenderLabel
            parseText "Female" = return FemaleGenderLabel

instance ToJSON Namemod where
    toJSON PurpleNamemod = ""
    toJSON JrNamemod = "Jr."
    toJSON IINamemod = "II"
    toJSON IIINamemod = "III"
    toJSON IVNamemod = "IV"

instance FromJSON Namemod where
    parseJSON = withText "Namemod" parseText
        where
            parseText "" = return PurpleNamemod
            parseText "Jr." = return JrNamemod
            parseText "II" = return IINamemod
            parseText "III" = return IIINamemod
            parseText "IV" = return IVNamemod

instance ToJSON RoleType where
    toJSON RepresentativeRoleType = "representative"

instance FromJSON RoleType where
    parseJSON = withText "RoleType" parseText
        where
            parseText "representative" = return RepresentativeRoleType

instance ToJSON RoleTypeLabel where
    toJSON RepresentativeRoleTypeLabel = "Representative"
    toJSON DelegateRoleTypeLabel = "Delegate"
    toJSON ResidentCommissionerRoleTypeLabel = "Resident Commissioner"

instance FromJSON RoleTypeLabel where
    parseJSON = withText "RoleTypeLabel" parseText
        where
            parseText "Representative" = return RepresentativeRoleTypeLabel
            parseText "Delegate" = return DelegateRoleTypeLabel
            parseText "Resident Commissioner" = return ResidentCommissionerRoleTypeLabel

instance ToJSON Title where
    toJSON RepTitle = "Rep."
    toJSON CommishTitle = "Commish."

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "Rep." = return RepTitle
            parseText "Commish." = return CommishTitle
