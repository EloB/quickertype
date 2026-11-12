{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Laureate (..)
    , Prize (..)
    , AffiliationClass (..)
    , Gender (..)
    , Category (..)
    , AffiliationElement (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { laureatesQuickType :: [Laureate]
    } deriving (Show)

data Laureate = Laureate
    { bornLaureate :: Text
    , bornCityLaureate :: Maybe Text
    , bornCountryLaureate :: Maybe Text
    , bornCountryCodeLaureate :: Maybe Text
    , diedLaureate :: Text
    , diedCityLaureate :: Maybe Text
    , diedCountryLaureate :: Maybe Text
    , diedCountryCodeLaureate :: Maybe Text
    , firstnameLaureate :: Maybe Text
    , genderLaureate :: Gender
    , laureateIDLaureate :: Text
    , prizesLaureate :: [Prize]
    , surnameLaureate :: Maybe Text
    } deriving (Show)

data Gender
    = MaleGender
    | FemaleGender
    | OrgGender
    deriving (Show)

data Prize = Prize
    { affiliationsPrize :: [AffiliationElement]
    , categoryPrize :: Maybe Category
    , motivationPrize :: Maybe Text
    , overallMotivationPrize :: Maybe Text
    , sharePrize :: Maybe Text
    , yearPrize :: Maybe Text
    } deriving (Show)

data AffiliationElement
    = AffiliationClassInAffiliationElement AffiliationClass
    | AnythingArrayInAffiliationElement ([Value])
    deriving (Show)

data AffiliationClass = AffiliationClass
    { cityAffiliationClass :: Maybe Text
    , countryAffiliationClass :: Maybe Text
    , nameAffiliationClass :: Maybe Text
    } deriving (Show)

data Category
    = PhysicsCategory
    | ChemistryCategory
    | PeaceCategory
    | MedicineCategory
    | LiteratureCategory
    | EconomicsCategory
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType laureatesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "laureates" .= laureatesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "laureates"

instance ToJSON Laureate where
    toJSON (Laureate bornLaureate bornCityLaureate bornCountryLaureate bornCountryCodeLaureate diedLaureate diedCityLaureate diedCountryLaureate diedCountryCodeLaureate firstnameLaureate genderLaureate laureateIDLaureate prizesLaureate surnameLaureate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "born" .= bornLaureate
        , ("bornCity" .=) <$> bornCityLaureate
        , ("bornCountry" .=) <$> bornCountryLaureate
        , ("bornCountryCode" .=) <$> bornCountryCodeLaureate
        , Just $ "died" .= diedLaureate
        , ("diedCity" .=) <$> diedCityLaureate
        , ("diedCountry" .=) <$> diedCountryLaureate
        , ("diedCountryCode" .=) <$> diedCountryCodeLaureate
        , ("firstname" .=) <$> firstnameLaureate
        , Just $ "gender" .= genderLaureate
        , Just $ "id" .= laureateIDLaureate
        , Just $ "prizes" .= prizesLaureate
        , ("surname" .=) <$> surnameLaureate
        ]

instance FromJSON Laureate where
    parseJSON (Object v) = Laureate
        <$> v .: "born"
        <*> v .:! "bornCity"
        <*> v .:! "bornCountry"
        <*> v .:! "bornCountryCode"
        <*> v .: "died"
        <*> v .:! "diedCity"
        <*> v .:! "diedCountry"
        <*> v .:! "diedCountryCode"
        <*> v .:! "firstname"
        <*> v .: "gender"
        <*> v .: "id"
        <*> v .: "prizes"
        <*> v .:! "surname"

instance ToJSON Gender where
    toJSON MaleGender = "male"
    toJSON FemaleGender = "female"
    toJSON OrgGender = "org"

instance FromJSON Gender where
    parseJSON = withText "Gender" parseText
        where
            parseText "male" = return MaleGender
            parseText "female" = return FemaleGender
            parseText "org" = return OrgGender

instance ToJSON Prize where
    toJSON (Prize affiliationsPrize categoryPrize motivationPrize overallMotivationPrize sharePrize yearPrize) =
        object $ foldMap (maybe [] pure)
        [ Just $ "affiliations" .= affiliationsPrize
        , ("category" .=) <$> categoryPrize
        , ("motivation" .=) <$> motivationPrize
        , ("overallMotivation" .=) <$> overallMotivationPrize
        , ("share" .=) <$> sharePrize
        , ("year" .=) <$> yearPrize
        ]

instance FromJSON Prize where
    parseJSON (Object v) = Prize
        <$> v .: "affiliations"
        <*> v .:! "category"
        <*> v .:! "motivation"
        <*> v .:! "overallMotivation"
        <*> v .:! "share"
        <*> v .:! "year"

instance ToJSON AffiliationElement where
    toJSON (AffiliationClassInAffiliationElement x) = toJSON x
    toJSON (AnythingArrayInAffiliationElement x) = toJSON x

instance FromJSON AffiliationElement where
    parseJSON xs@(Object _) = (fmap AffiliationClassInAffiliationElement . parseJSON) xs
    parseJSON xs@(Array _) = (fmap AnythingArrayInAffiliationElement . parseJSON) xs

instance ToJSON AffiliationClass where
    toJSON (AffiliationClass cityAffiliationClass countryAffiliationClass nameAffiliationClass) =
        object $ foldMap (maybe [] pure)
        [ ("city" .=) <$> cityAffiliationClass
        , ("country" .=) <$> countryAffiliationClass
        , ("name" .=) <$> nameAffiliationClass
        ]

instance FromJSON AffiliationClass where
    parseJSON (Object v) = AffiliationClass
        <$> v .:! "city"
        <*> v .:! "country"
        <*> v .:! "name"

instance ToJSON Category where
    toJSON PhysicsCategory = "physics"
    toJSON ChemistryCategory = "chemistry"
    toJSON PeaceCategory = "peace"
    toJSON MedicineCategory = "medicine"
    toJSON LiteratureCategory = "literature"
    toJSON EconomicsCategory = "economics"

instance FromJSON Category where
    parseJSON = withText "Category" parseText
        where
            parseText "physics" = return PhysicsCategory
            parseText "chemistry" = return ChemistryCategory
            parseText "peace" = return PeaceCategory
            parseText "medicine" = return MedicineCategory
            parseText "literature" = return LiteratureCategory
            parseText "economics" = return EconomicsCategory
