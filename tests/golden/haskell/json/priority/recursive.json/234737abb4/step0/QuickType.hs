{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Category (..)
    , LinkElement (..)
    , LinkLink (..)
    , CategoryThumbnail (..)
    , Details (..)
    , Date (..)
    , Eonandyear (..)
    , Xmlschematype (..)
    , ProductElement (..)
    , ProductProduct (..)
    , Currency (..)
    , Rating (..)
    , Useraveragerating (..)
    , Specification (..)
    , Format (..)
    , FormatsClass (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { categoryQuickType :: Category
    , detailsQuickType :: Details
    , matchQuickType :: Text
    , pageQuickType :: Int
    , productQuickType :: [ProductElement]
    , schkQuickType :: Bool
    , totallooseoffersQuickType :: Int
    , totalpagesQuickType :: Int
    , totalresultsavailableQuickType :: Int
    , totalresultsreturnedQuickType :: Int
    } deriving (Show)

data Category = Category
    { categoryIDCategory :: Int
    , concatenatecategorynameCategory :: Bool
    , hasofferCategory :: Bool
    , isfinalCategory :: Bool
    , linksCategory :: [LinkElement]
    , nameCategory :: Text
    , parentcategoryidCategory :: Int
    , thumbnailCategory :: CategoryThumbnail
    } deriving (Show)

data LinkElement = LinkElement
    { linkLinkElement :: LinkLink
    } deriving (Show)

data LinkLink = LinkLink
    { linkTypeLinkLink :: Text
    , urlLinkLink :: Text
    } deriving (Show)

data CategoryThumbnail = CategoryThumbnail
    { urlCategoryThumbnail :: Text
    } deriving (Show)

data Details = Details
    { applicationidDetails :: Text
    , applicationversionDetails :: Text
    , codeDetails :: Int
    , dateDetails :: Date
    , elapsedtimeDetails :: Int
    , messageDetails :: Text
    , statusDetails :: Text
    } deriving (Show)

data Date = Date
    { dayDate :: Int
    , eonandyearDate :: Eonandyear
    , hourDate :: Int
    , millisecondDate :: Int
    , minuteDate :: Int
    , monthDate :: Int
    , secondDate :: Int
    , timezoneDate :: Int
    , validDate :: Bool
    , xmlschematypeDate :: Xmlschematype
    , yearDate :: Int
    } deriving (Show)

data Eonandyear = Eonandyear
    { lowestsetbitEonandyear :: Int
    } deriving (Show)

data Xmlschematype = Xmlschematype
    { localpartXmlschematype :: Text
    , namespaceuriXmlschematype :: Text
    , prefixXmlschematype :: Text
    } deriving (Show)

data ProductElement = ProductElement
    { productProductElement :: ProductProduct
    } deriving (Show)

data ProductProduct = ProductProduct
    { categoryidProductProduct :: Int
    , currencyProductProduct :: Currency
    , ecoProductProduct :: Bool
    , fulldescriptionProductProduct :: Bool
    , hasmetasearchProductProduct :: Bool
    , linksProductProduct :: [LinkElement]
    , numoffersProductProduct :: Int
    , pricemaxProductProduct :: Text
    , priceminProductProduct :: Text
    , productIDProductProduct :: Int
    , productnameProductProduct :: Text
    , quantityProductProduct :: Int
    , ratingProductProduct :: Rating
    , specificationProductProduct :: Specification
    , thumbnailProductProduct :: FormatsClass
    , totalsellersProductProduct :: Int
    } deriving (Show)

data Currency = Currency
    { abbreviationCurrency :: Text
    } deriving (Show)

data Rating = Rating
    { useraverageratingRating :: Useraveragerating
    } deriving (Show)

data Useraveragerating = Useraveragerating
    { linksUseraveragerating :: [LinkElement]
    , numcommentsUseraveragerating :: Int
    , ratingUseraveragerating :: Text
    } deriving (Show)

data Specification = Specification
    { linksSpecification :: [LinkElement]
    } deriving (Show)

data Format = Format
    { formatsFormat :: FormatsClass
    } deriving (Show)

data FormatsClass = FormatsClass
    { formatsFormatsClass :: Maybe ([Format])
    , heightFormatsClass :: Int
    , urlFormatsClass :: Text
    , widthFormatsClass :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType categoryQuickType detailsQuickType matchQuickType pageQuickType productQuickType schkQuickType totallooseoffersQuickType totalpagesQuickType totalresultsavailableQuickType totalresultsreturnedQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "category" .= categoryQuickType
        , Just $ "details" .= detailsQuickType
        , Just $ "match" .= matchQuickType
        , Just $ "page" .= pageQuickType
        , Just $ "product" .= productQuickType
        , Just $ "schk" .= schkQuickType
        , Just $ "totallooseoffers" .= totallooseoffersQuickType
        , Just $ "totalpages" .= totalpagesQuickType
        , Just $ "totalresultsavailable" .= totalresultsavailableQuickType
        , Just $ "totalresultsreturned" .= totalresultsreturnedQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "category"
        <*> v .: "details"
        <*> v .: "match"
        <*> v .: "page"
        <*> v .: "product"
        <*> v .: "schk"
        <*> v .: "totallooseoffers"
        <*> v .: "totalpages"
        <*> v .: "totalresultsavailable"
        <*> v .: "totalresultsreturned"

instance ToJSON Category where
    toJSON (Category categoryIDCategory concatenatecategorynameCategory hasofferCategory isfinalCategory linksCategory nameCategory parentcategoryidCategory thumbnailCategory) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= categoryIDCategory
        , Just $ "concatenatecategoryname" .= concatenatecategorynameCategory
        , Just $ "hasoffer" .= hasofferCategory
        , Just $ "isfinal" .= isfinalCategory
        , Just $ "links" .= linksCategory
        , Just $ "name" .= nameCategory
        , Just $ "parentcategoryid" .= parentcategoryidCategory
        , Just $ "thumbnail" .= thumbnailCategory
        ]

instance FromJSON Category where
    parseJSON (Object v) = Category
        <$> v .: "id"
        <*> v .: "concatenatecategoryname"
        <*> v .: "hasoffer"
        <*> v .: "isfinal"
        <*> v .: "links"
        <*> v .: "name"
        <*> v .: "parentcategoryid"
        <*> v .: "thumbnail"

instance ToJSON LinkElement where
    toJSON (LinkElement linkLinkElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "link" .= linkLinkElement
        ]

instance FromJSON LinkElement where
    parseJSON (Object v) = LinkElement
        <$> v .: "link"

instance ToJSON LinkLink where
    toJSON (LinkLink linkTypeLinkLink urlLinkLink) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= linkTypeLinkLink
        , Just $ "url" .= urlLinkLink
        ]

instance FromJSON LinkLink where
    parseJSON (Object v) = LinkLink
        <$> v .: "type"
        <*> v .: "url"

instance ToJSON CategoryThumbnail where
    toJSON (CategoryThumbnail urlCategoryThumbnail) =
        object $ foldMap (maybe [] pure)
        [ Just $ "url" .= urlCategoryThumbnail
        ]

instance FromJSON CategoryThumbnail where
    parseJSON (Object v) = CategoryThumbnail
        <$> v .: "url"

instance ToJSON Details where
    toJSON (Details applicationidDetails applicationversionDetails codeDetails dateDetails elapsedtimeDetails messageDetails statusDetails) =
        object $ foldMap (maybe [] pure)
        [ Just $ "applicationid" .= applicationidDetails
        , Just $ "applicationversion" .= applicationversionDetails
        , Just $ "code" .= codeDetails
        , Just $ "date" .= dateDetails
        , Just $ "elapsedtime" .= elapsedtimeDetails
        , Just $ "message" .= messageDetails
        , Just $ "status" .= statusDetails
        ]

instance FromJSON Details where
    parseJSON (Object v) = Details
        <$> v .: "applicationid"
        <*> v .: "applicationversion"
        <*> v .: "code"
        <*> v .: "date"
        <*> v .: "elapsedtime"
        <*> v .: "message"
        <*> v .: "status"

instance ToJSON Date where
    toJSON (Date dayDate eonandyearDate hourDate millisecondDate minuteDate monthDate secondDate timezoneDate validDate xmlschematypeDate yearDate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "day" .= dayDate
        , Just $ "eonandyear" .= eonandyearDate
        , Just $ "hour" .= hourDate
        , Just $ "millisecond" .= millisecondDate
        , Just $ "minute" .= minuteDate
        , Just $ "month" .= monthDate
        , Just $ "second" .= secondDate
        , Just $ "timezone" .= timezoneDate
        , Just $ "valid" .= validDate
        , Just $ "xmlschematype" .= xmlschematypeDate
        , Just $ "year" .= yearDate
        ]

instance FromJSON Date where
    parseJSON (Object v) = Date
        <$> v .: "day"
        <*> v .: "eonandyear"
        <*> v .: "hour"
        <*> v .: "millisecond"
        <*> v .: "minute"
        <*> v .: "month"
        <*> v .: "second"
        <*> v .: "timezone"
        <*> v .: "valid"
        <*> v .: "xmlschematype"
        <*> v .: "year"

instance ToJSON Eonandyear where
    toJSON (Eonandyear lowestsetbitEonandyear) =
        object $ foldMap (maybe [] pure)
        [ Just $ "lowestsetbit" .= lowestsetbitEonandyear
        ]

instance FromJSON Eonandyear where
    parseJSON (Object v) = Eonandyear
        <$> v .: "lowestsetbit"

instance ToJSON Xmlschematype where
    toJSON (Xmlschematype localpartXmlschematype namespaceuriXmlschematype prefixXmlschematype) =
        object $ foldMap (maybe [] pure)
        [ Just $ "localpart" .= localpartXmlschematype
        , Just $ "namespaceuri" .= namespaceuriXmlschematype
        , Just $ "prefix" .= prefixXmlschematype
        ]

instance FromJSON Xmlschematype where
    parseJSON (Object v) = Xmlschematype
        <$> v .: "localpart"
        <*> v .: "namespaceuri"
        <*> v .: "prefix"

instance ToJSON ProductElement where
    toJSON (ProductElement productProductElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "product" .= productProductElement
        ]

instance FromJSON ProductElement where
    parseJSON (Object v) = ProductElement
        <$> v .: "product"

instance ToJSON ProductProduct where
    toJSON (ProductProduct categoryidProductProduct currencyProductProduct ecoProductProduct fulldescriptionProductProduct hasmetasearchProductProduct linksProductProduct numoffersProductProduct pricemaxProductProduct priceminProductProduct productIDProductProduct productnameProductProduct quantityProductProduct ratingProductProduct specificationProductProduct thumbnailProductProduct totalsellersProductProduct) =
        object $ foldMap (maybe [] pure)
        [ Just $ "categoryid" .= categoryidProductProduct
        , Just $ "currency" .= currencyProductProduct
        , Just $ "eco" .= ecoProductProduct
        , Just $ "fulldescription" .= fulldescriptionProductProduct
        , Just $ "hasmetasearch" .= hasmetasearchProductProduct
        , Just $ "links" .= linksProductProduct
        , Just $ "numoffers" .= numoffersProductProduct
        , Just $ "pricemax" .= pricemaxProductProduct
        , Just $ "pricemin" .= priceminProductProduct
        , Just $ "id" .= productIDProductProduct
        , Just $ "productname" .= productnameProductProduct
        , Just $ "quantity" .= quantityProductProduct
        , Just $ "rating" .= ratingProductProduct
        , Just $ "specification" .= specificationProductProduct
        , Just $ "thumbnail" .= thumbnailProductProduct
        , Just $ "totalsellers" .= totalsellersProductProduct
        ]

instance FromJSON ProductProduct where
    parseJSON (Object v) = ProductProduct
        <$> v .: "categoryid"
        <*> v .: "currency"
        <*> v .: "eco"
        <*> v .: "fulldescription"
        <*> v .: "hasmetasearch"
        <*> v .: "links"
        <*> v .: "numoffers"
        <*> v .: "pricemax"
        <*> v .: "pricemin"
        <*> v .: "id"
        <*> v .: "productname"
        <*> v .: "quantity"
        <*> v .: "rating"
        <*> v .: "specification"
        <*> v .: "thumbnail"
        <*> v .: "totalsellers"

instance ToJSON Currency where
    toJSON (Currency abbreviationCurrency) =
        object $ foldMap (maybe [] pure)
        [ Just $ "abbreviation" .= abbreviationCurrency
        ]

instance FromJSON Currency where
    parseJSON (Object v) = Currency
        <$> v .: "abbreviation"

instance ToJSON Rating where
    toJSON (Rating useraverageratingRating) =
        object $ foldMap (maybe [] pure)
        [ Just $ "useraveragerating" .= useraverageratingRating
        ]

instance FromJSON Rating where
    parseJSON (Object v) = Rating
        <$> v .: "useraveragerating"

instance ToJSON Useraveragerating where
    toJSON (Useraveragerating linksUseraveragerating numcommentsUseraveragerating ratingUseraveragerating) =
        object $ foldMap (maybe [] pure)
        [ Just $ "links" .= linksUseraveragerating
        , Just $ "numcomments" .= numcommentsUseraveragerating
        , Just $ "rating" .= ratingUseraveragerating
        ]

instance FromJSON Useraveragerating where
    parseJSON (Object v) = Useraveragerating
        <$> v .: "links"
        <*> v .: "numcomments"
        <*> v .: "rating"

instance ToJSON Specification where
    toJSON (Specification linksSpecification) =
        object $ foldMap (maybe [] pure)
        [ Just $ "links" .= linksSpecification
        ]

instance FromJSON Specification where
    parseJSON (Object v) = Specification
        <$> v .: "links"

instance ToJSON Format where
    toJSON (Format formatsFormat) =
        object $ foldMap (maybe [] pure)
        [ Just $ "formats" .= formatsFormat
        ]

instance FromJSON Format where
    parseJSON (Object v) = Format
        <$> v .: "formats"

instance ToJSON FormatsClass where
    toJSON (FormatsClass formatsFormatsClass heightFormatsClass urlFormatsClass widthFormatsClass) =
        object $ foldMap (maybe [] pure)
        [ ("formats" .=) <$> formatsFormatsClass
        , Just $ "height" .= heightFormatsClass
        , Just $ "url" .= urlFormatsClass
        , Just $ "width" .= widthFormatsClass
        ]

instance FromJSON FormatsClass where
    parseJSON (Object v) = FormatsClass
        <$> v .:! "formats"
        <*> v .: "height"
        <*> v .: "url"
        <*> v .: "width"
