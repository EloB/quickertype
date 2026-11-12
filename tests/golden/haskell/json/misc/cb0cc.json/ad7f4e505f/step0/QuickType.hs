{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Prize (..)
    , Laureate (..)
    , Category (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { prizesQuickType :: [Prize]
    } deriving (Show)

data Prize = Prize
    { categoryPrize :: Category
    , laureatesPrize :: [Laureate]
    , overallMotivationPrize :: Maybe Text
    , yearPrize :: Text
    } deriving (Show)

data Category
    = PhysicsCategory
    | ChemistryCategory
    | MedicineCategory
    | LiteratureCategory
    | PeaceCategory
    | EconomicsCategory
    deriving (Show)

data Laureate = Laureate
    { firstnameLaureate :: Text
    , laureateIDLaureate :: Text
    , motivationLaureate :: Maybe Text
    , shareLaureate :: Text
    , surnameLaureate :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType prizesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "prizes" .= prizesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "prizes"

instance ToJSON Prize where
    toJSON (Prize categoryPrize laureatesPrize overallMotivationPrize yearPrize) =
        object $ foldMap (maybe [] pure)
        [ Just $ "category" .= categoryPrize
        , Just $ "laureates" .= laureatesPrize
        , ("overallMotivation" .=) <$> overallMotivationPrize
        , Just $ "year" .= yearPrize
        ]

instance FromJSON Prize where
    parseJSON (Object v) = Prize
        <$> v .: "category"
        <*> v .: "laureates"
        <*> v .:! "overallMotivation"
        <*> v .: "year"

instance ToJSON Category where
    toJSON PhysicsCategory = "physics"
    toJSON ChemistryCategory = "chemistry"
    toJSON MedicineCategory = "medicine"
    toJSON LiteratureCategory = "literature"
    toJSON PeaceCategory = "peace"
    toJSON EconomicsCategory = "economics"

instance FromJSON Category where
    parseJSON = withText "Category" parseText
        where
            parseText "physics" = return PhysicsCategory
            parseText "chemistry" = return ChemistryCategory
            parseText "medicine" = return MedicineCategory
            parseText "literature" = return LiteratureCategory
            parseText "peace" = return PeaceCategory
            parseText "economics" = return EconomicsCategory

instance ToJSON Laureate where
    toJSON (Laureate firstnameLaureate laureateIDLaureate motivationLaureate shareLaureate surnameLaureate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "firstname" .= firstnameLaureate
        , Just $ "id" .= laureateIDLaureate
        , ("motivation" .=) <$> motivationLaureate
        , Just $ "share" .= shareLaureate
        , Just $ "surname" .= surnameLaureate
        ]

instance FromJSON Laureate where
    parseJSON (Object v) = Laureate
        <$> v .: "firstname"
        <*> v .: "id"
        <*> v .:! "motivation"
        <*> v .: "share"
        <*> v .: "surname"
