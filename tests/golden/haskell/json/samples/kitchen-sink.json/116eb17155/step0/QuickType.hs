{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , DifferentThingClass (..)
    , PersonElement (..)
    , PurplePerson (..)
    , DifferentThingElement (..)
    , IntOrString (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { booleanValueQuickType :: Bool
    , dateValueQuickType :: Text
    , differentThingsQuickType :: [DifferentThingElement]
    , doubleValueQuickType :: Double
    , intValueQuickType :: Int
    , mapValueQuickType :: HashMap Text (Maybe Int)
    , nameWithSpacesQuickType :: Maybe Text
    , nullValueQuickType :: Maybe Text
    , nullableMapValueQuickType :: HashMap Text (Maybe Int)
    , peopleQuickType :: [PersonElement]
    , personQuickType :: PurplePerson
    , stringValueQuickType :: Text
    , tuplesQuickType :: [([IntOrString])]
    , uuidValueQuickType :: Text
    } deriving (Show)

data DifferentThingElement
    = DifferentThingClassInDifferentThingElement DifferentThingClass
    | IntegerInDifferentThingElement Int
    | StringInDifferentThingElement Text
    deriving (Show)

data DifferentThingClass = DifferentThingClass
    { nameDifferentThingClass :: Text
    } deriving (Show)

data PersonElement = PersonElement
    { intOrStringPersonElement :: IntOrString
    , namePersonElement :: Text
    , optionalValuePersonElement :: Maybe Bool
    } deriving (Show)

data IntOrString
    = IntegerInIntOrString Int
    | StringInIntOrString Text
    deriving (Show)

data PurplePerson = PurplePerson
    { intOrStringPurplePerson :: Int
    , namePurplePerson :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType booleanValueQuickType dateValueQuickType differentThingsQuickType doubleValueQuickType intValueQuickType mapValueQuickType nameWithSpacesQuickType nullValueQuickType nullableMapValueQuickType peopleQuickType personQuickType stringValueQuickType tuplesQuickType uuidValueQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "booleanValue" .= booleanValueQuickType
        , Just $ "dateValue" .= dateValueQuickType
        , Just $ "differentThings" .= differentThingsQuickType
        , Just $ "doubleValue" .= doubleValueQuickType
        , Just $ "intValue" .= intValueQuickType
        , Just $ "mapValue" .= mapValueQuickType
        , Just $ "name with spaces" .= nameWithSpacesQuickType
        , Just $ "nullValue" .= nullValueQuickType
        , Just $ "nullableMapValue" .= nullableMapValueQuickType
        , Just $ "people" .= peopleQuickType
        , Just $ "person" .= personQuickType
        , Just $ "stringValue" .= stringValueQuickType
        , Just $ "tuples" .= tuplesQuickType
        , Just $ "uuidValue" .= uuidValueQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "booleanValue"
        <*> v .: "dateValue"
        <*> v .: "differentThings"
        <*> v .: "doubleValue"
        <*> v .: "intValue"
        <*> v .: "mapValue"
        <*> v .: "name with spaces"
        <*> v .: "nullValue"
        <*> v .: "nullableMapValue"
        <*> v .: "people"
        <*> v .: "person"
        <*> v .: "stringValue"
        <*> v .: "tuples"
        <*> v .: "uuidValue"

instance ToJSON DifferentThingElement where
    toJSON (DifferentThingClassInDifferentThingElement x) = toJSON x
    toJSON (IntegerInDifferentThingElement x) = toJSON x
    toJSON (StringInDifferentThingElement x) = toJSON x

instance FromJSON DifferentThingElement where
    parseJSON xs@(Object _) = (fmap DifferentThingClassInDifferentThingElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInDifferentThingElement . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInDifferentThingElement . parseJSON) xs

instance ToJSON DifferentThingClass where
    toJSON (DifferentThingClass nameDifferentThingClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameDifferentThingClass
        ]

instance FromJSON DifferentThingClass where
    parseJSON (Object v) = DifferentThingClass
        <$> v .: "name"

instance ToJSON PersonElement where
    toJSON (PersonElement intOrStringPersonElement namePersonElement optionalValuePersonElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "intOrString" .= intOrStringPersonElement
        , Just $ "name" .= namePersonElement
        , ("optionalValue" .=) <$> optionalValuePersonElement
        ]

instance FromJSON PersonElement where
    parseJSON (Object v) = PersonElement
        <$> v .: "intOrString"
        <*> v .: "name"
        <*> v .:! "optionalValue"

instance ToJSON IntOrString where
    toJSON (IntegerInIntOrString x) = toJSON x
    toJSON (StringInIntOrString x) = toJSON x

instance FromJSON IntOrString where
    parseJSON xs@(Number _) = (fmap IntegerInIntOrString . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInIntOrString . parseJSON) xs

instance ToJSON PurplePerson where
    toJSON (PurplePerson intOrStringPurplePerson namePurplePerson) =
        object $ foldMap (maybe [] pure)
        [ Just $ "intOrString" .= intOrStringPurplePerson
        , Just $ "name" .= namePurplePerson
        ]

instance FromJSON PurplePerson where
    parseJSON (Object v) = PurplePerson
        <$> v .: "intOrString"
        <*> v .: "name"
