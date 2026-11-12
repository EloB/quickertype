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
    , SenatorClass (..)
    , SenatorClassLabel (..)
    , SenatorRank (..)
    , SenatorRankLabel (..)
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
    { caucusObjectElement :: Maybe Party
    , congressNumbersObjectElement :: [Int]
    , currentObjectElement :: Bool
    , descriptionObjectElement :: Text
    , districtObjectElement :: Maybe Text
    , enddateObjectElement :: Text
    , extraObjectElement :: Extra
    , leadershipTitleObjectElement :: Maybe Text
    , objectIDObjectElement :: Int
    , partyObjectElement :: Party
    , personObjectElement :: Person
    , phoneObjectElement :: Text
    , roleTypeObjectElement :: RoleType
    , roleTypeLabelObjectElement :: RoleTypeLabel
    , senatorClassObjectElement :: SenatorClass
    , senatorClassLabelObjectElement :: SenatorClassLabel
    , senatorRankObjectElement :: SenatorRank
    , senatorRankLabelObjectElement :: SenatorRankLabel
    , startdateObjectElement :: Text
    , stateObjectElement :: Text
    , titleObjectElement :: Title
    , titleLongObjectElement :: RoleTypeLabel
    , websiteObjectElement :: Text
    } deriving (Show)

data Party
    = RepublicanParty
    | DemocratParty
    | IndependentParty
    deriving (Show)

data Extra = Extra
    { addressExtra :: Text
    , contactFormExtra :: Text
    , faxExtra :: Maybe Text
    , officeExtra :: Text
    , rssURLExtra :: Maybe Text
    } deriving (Show)

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
    , pvsidPerson :: Text
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
    | IIINamemod
    | JrNamemod
    deriving (Show)

data RoleType
    = SenatorRoleType
    deriving (Show)

data RoleTypeLabel
    = SenatorRoleTypeLabel
    deriving (Show)

data SenatorClass
    = Class2SenatorClass
    | Class1SenatorClass
    | Class3SenatorClass
    deriving (Show)

data SenatorClassLabel
    = Class2_SenatorClassLabel
    | Class1_SenatorClassLabel
    | Class3_SenatorClassLabel
    deriving (Show)

data SenatorRank
    = SeniorSenatorRank
    | JuniorSenatorRank
    deriving (Show)

data SenatorRankLabel
    = SeniorSenatorRankLabel
    | JuniorSenatorRankLabel
    deriving (Show)

data Title
    = SenTitle
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
    toJSON (ObjectElement caucusObjectElement congressNumbersObjectElement currentObjectElement descriptionObjectElement districtObjectElement enddateObjectElement extraObjectElement leadershipTitleObjectElement objectIDObjectElement partyObjectElement personObjectElement phoneObjectElement roleTypeObjectElement roleTypeLabelObjectElement senatorClassObjectElement senatorClassLabelObjectElement senatorRankObjectElement senatorRankLabelObjectElement startdateObjectElement stateObjectElement titleObjectElement titleLongObjectElement websiteObjectElement) =
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
        , Just $ "senator_class_label" .= senatorClassLabelObjectElement
        , Just $ "senator_rank" .= senatorRankObjectElement
        , Just $ "senator_rank_label" .= senatorRankLabelObjectElement
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
        <*> v .: "senator_class_label"
        <*> v .: "senator_rank"
        <*> v .: "senator_rank_label"
        <*> v .: "startdate"
        <*> v .: "state"
        <*> v .: "title"
        <*> v .: "title_long"
        <*> v .: "website"

instance ToJSON Party where
    toJSON RepublicanParty = "Republican"
    toJSON DemocratParty = "Democrat"
    toJSON IndependentParty = "Independent"

instance FromJSON Party where
    parseJSON = withText "Party" parseText
        where
            parseText "Republican" = return RepublicanParty
            parseText "Democrat" = return DemocratParty
            parseText "Independent" = return IndependentParty

instance ToJSON Extra where
    toJSON (Extra addressExtra contactFormExtra faxExtra officeExtra rssURLExtra) =
        object $ foldMap (maybe [] pure)
        [ Just $ "address" .= addressExtra
        , Just $ "contact_form" .= contactFormExtra
        , ("fax" .=) <$> faxExtra
        , Just $ "office" .= officeExtra
        , ("rss_url" .=) <$> rssURLExtra
        ]

instance FromJSON Extra where
    parseJSON (Object v) = Extra
        <$> v .: "address"
        <*> v .: "contact_form"
        <*> v .:! "fax"
        <*> v .: "office"
        <*> v .:! "rss_url"

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
    toJSON IIINamemod = "III"
    toJSON JrNamemod = "Jr."

instance FromJSON Namemod where
    parseJSON = withText "Namemod" parseText
        where
            parseText "" = return PurpleNamemod
            parseText "III" = return IIINamemod
            parseText "Jr." = return JrNamemod

instance ToJSON RoleType where
    toJSON SenatorRoleType = "senator"

instance FromJSON RoleType where
    parseJSON = withText "RoleType" parseText
        where
            parseText "senator" = return SenatorRoleType

instance ToJSON RoleTypeLabel where
    toJSON SenatorRoleTypeLabel = "Senator"

instance FromJSON RoleTypeLabel where
    parseJSON = withText "RoleTypeLabel" parseText
        where
            parseText "Senator" = return SenatorRoleTypeLabel

instance ToJSON SenatorClass where
    toJSON Class2SenatorClass = "class2"
    toJSON Class1SenatorClass = "class1"
    toJSON Class3SenatorClass = "class3"

instance FromJSON SenatorClass where
    parseJSON = withText "SenatorClass" parseText
        where
            parseText "class2" = return Class2SenatorClass
            parseText "class1" = return Class1SenatorClass
            parseText "class3" = return Class3SenatorClass

instance ToJSON SenatorClassLabel where
    toJSON Class2_SenatorClassLabel = "Class 2"
    toJSON Class1_SenatorClassLabel = "Class 1"
    toJSON Class3_SenatorClassLabel = "Class 3"

instance FromJSON SenatorClassLabel where
    parseJSON = withText "SenatorClassLabel" parseText
        where
            parseText "Class 2" = return Class2_SenatorClassLabel
            parseText "Class 1" = return Class1_SenatorClassLabel
            parseText "Class 3" = return Class3_SenatorClassLabel

instance ToJSON SenatorRank where
    toJSON SeniorSenatorRank = "senior"
    toJSON JuniorSenatorRank = "junior"

instance FromJSON SenatorRank where
    parseJSON = withText "SenatorRank" parseText
        where
            parseText "senior" = return SeniorSenatorRank
            parseText "junior" = return JuniorSenatorRank

instance ToJSON SenatorRankLabel where
    toJSON SeniorSenatorRankLabel = "Senior"
    toJSON JuniorSenatorRankLabel = "Junior"

instance FromJSON SenatorRankLabel where
    parseJSON = withText "SenatorRankLabel" parseText
        where
            parseText "Senior" = return SeniorSenatorRankLabel
            parseText "Junior" = return JuniorSenatorRankLabel

instance ToJSON Title where
    toJSON SenTitle = "Sen."

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "Sen." = return SenTitle
