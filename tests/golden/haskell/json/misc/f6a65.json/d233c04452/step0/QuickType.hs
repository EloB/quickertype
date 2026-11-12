{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Meta (..)
    , Pagination (..)
    , Datum (..)
    , Images (..)
    , The480_WStill (..)
    , DownsizedSmall (..)
    , FixedHeight (..)
    , Looping (..)
    , User (..)
    , Type (..)
    , Rating (..)
    , Username (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { metaQuickType :: Meta
    , paginationQuickType :: Pagination
    , quickTypeDataQuickType :: [Datum]
    } deriving (Show)

data Meta = Meta
    { msgMeta :: Text
    , responseIDMeta :: Text
    , statusMeta :: Int
    } deriving (Show)

data Pagination = Pagination
    { countPagination :: Int
    , offsetPagination :: Int
    , totalCountPagination :: Int
    } deriving (Show)

data Datum = Datum
    { bitlyGIFURLDatum :: Text
    , bitlyURLDatum :: Text
    , contentURLDatum :: Text
    , datumIDDatum :: Text
    , datumTypeDatum :: Type
    , embedURLDatum :: Text
    , imagesDatum :: Images
    , importDatetimeDatum :: Text
    , isIndexableDatum :: Int
    , ratingDatum :: Rating
    , slugDatum :: Text
    , sourceDatum :: Text
    , sourcePostURLDatum :: Text
    , sourceTLDDatum :: Text
    , trendingDatetimeDatum :: Text
    , urlDatum :: Text
    , userDatum :: Maybe User
    , usernameDatum :: Username
    } deriving (Show)

data Type
    = GIFType
    deriving (Show)

data Images = Images
    { downsizedImages :: The480_WStill
    , downsizedLargeImages :: The480_WStill
    , downsizedMediumImages :: The480_WStill
    , downsizedSmallImages :: DownsizedSmall
    , downsizedStillImages :: The480_WStill
    , fixedHeightImages :: FixedHeight
    , fixedHeightDownsampledImages :: FixedHeight
    , fixedHeightSmallImages :: FixedHeight
    , fixedHeightSmallStillImages :: The480_WStill
    , fixedHeightStillImages :: The480_WStill
    , fixedWidthImages :: FixedHeight
    , fixedWidthDownsampledImages :: FixedHeight
    , fixedWidthSmallImages :: FixedHeight
    , fixedWidthSmallStillImages :: The480_WStill
    , fixedWidthStillImages :: The480_WStill
    , loopingImages :: Looping
    , originalImages :: FixedHeight
    , originalMp4Images :: DownsizedSmall
    , originalStillImages :: The480_WStill
    , previewImages :: DownsizedSmall
    , previewGIFImages :: The480_WStill
    , previewWebpImages :: The480_WStill
    , the480WStillImages :: Maybe The480_WStill
    } deriving (Show)

data The480_WStill = The480_WStill
    { heightThe480_WStill :: Text
    , sizeThe480_WStill :: Maybe Text
    , urlThe480_WStill :: Text
    , widthThe480_WStill :: Text
    } deriving (Show)

data DownsizedSmall = DownsizedSmall
    { heightDownsizedSmall :: Text
    , mp4DownsizedSmall :: Text
    , mp4SizeDownsizedSmall :: Text
    , widthDownsizedSmall :: Text
    } deriving (Show)

data FixedHeight = FixedHeight
    { framesFixedHeight :: Maybe Text
    , hashFixedHeight :: Maybe Text
    , heightFixedHeight :: Text
    , mp4FixedHeight :: Maybe Text
    , mp4SizeFixedHeight :: Maybe Text
    , sizeFixedHeight :: Text
    , urlFixedHeight :: Text
    , webpFixedHeight :: Text
    , webpSizeFixedHeight :: Text
    , widthFixedHeight :: Text
    } deriving (Show)

data Looping = Looping
    { mp4Looping :: Text
    , mp4SizeLooping :: Text
    } deriving (Show)

data Rating
    = GRating
    | YRating
    | PGRating
    | PG13_Rating
    deriving (Show)

data User = User
    { avatarURLUser :: Text
    , bannerURLUser :: Text
    , displayNameUser :: Text
    , profileURLUser :: Text
    , twitterUser :: Text
    , usernameUser :: Username
    } deriving (Show)

data Username
    = PurpleUsername
    | ProducthuntUsername
    | MeetaikoUsername
    | CheezburgerUsername
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType metaQuickType paginationQuickType quickTypeDataQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "meta" .= metaQuickType
        , Just $ "pagination" .= paginationQuickType
        , Just $ "data" .= quickTypeDataQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "meta"
        <*> v .: "pagination"
        <*> v .: "data"

instance ToJSON Meta where
    toJSON (Meta msgMeta responseIDMeta statusMeta) =
        object $ foldMap (maybe [] pure)
        [ Just $ "msg" .= msgMeta
        , Just $ "response_id" .= responseIDMeta
        , Just $ "status" .= statusMeta
        ]

instance FromJSON Meta where
    parseJSON (Object v) = Meta
        <$> v .: "msg"
        <*> v .: "response_id"
        <*> v .: "status"

instance ToJSON Pagination where
    toJSON (Pagination countPagination offsetPagination totalCountPagination) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countPagination
        , Just $ "offset" .= offsetPagination
        , Just $ "total_count" .= totalCountPagination
        ]

instance FromJSON Pagination where
    parseJSON (Object v) = Pagination
        <$> v .: "count"
        <*> v .: "offset"
        <*> v .: "total_count"

instance ToJSON Datum where
    toJSON (Datum bitlyGIFURLDatum bitlyURLDatum contentURLDatum datumIDDatum datumTypeDatum embedURLDatum imagesDatum importDatetimeDatum isIndexableDatum ratingDatum slugDatum sourceDatum sourcePostURLDatum sourceTLDDatum trendingDatetimeDatum urlDatum userDatum usernameDatum) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bitly_gif_url" .= bitlyGIFURLDatum
        , Just $ "bitly_url" .= bitlyURLDatum
        , Just $ "content_url" .= contentURLDatum
        , Just $ "id" .= datumIDDatum
        , Just $ "type" .= datumTypeDatum
        , Just $ "embed_url" .= embedURLDatum
        , Just $ "images" .= imagesDatum
        , Just $ "import_datetime" .= importDatetimeDatum
        , Just $ "is_indexable" .= isIndexableDatum
        , Just $ "rating" .= ratingDatum
        , Just $ "slug" .= slugDatum
        , Just $ "source" .= sourceDatum
        , Just $ "source_post_url" .= sourcePostURLDatum
        , Just $ "source_tld" .= sourceTLDDatum
        , Just $ "trending_datetime" .= trendingDatetimeDatum
        , Just $ "url" .= urlDatum
        , ("user" .=) <$> userDatum
        , Just $ "username" .= usernameDatum
        ]

instance FromJSON Datum where
    parseJSON (Object v) = Datum
        <$> v .: "bitly_gif_url"
        <*> v .: "bitly_url"
        <*> v .: "content_url"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "embed_url"
        <*> v .: "images"
        <*> v .: "import_datetime"
        <*> v .: "is_indexable"
        <*> v .: "rating"
        <*> v .: "slug"
        <*> v .: "source"
        <*> v .: "source_post_url"
        <*> v .: "source_tld"
        <*> v .: "trending_datetime"
        <*> v .: "url"
        <*> v .:! "user"
        <*> v .: "username"

instance ToJSON Type where
    toJSON GIFType = "gif"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "gif" = return GIFType

instance ToJSON Images where
    toJSON (Images downsizedImages downsizedLargeImages downsizedMediumImages downsizedSmallImages downsizedStillImages fixedHeightImages fixedHeightDownsampledImages fixedHeightSmallImages fixedHeightSmallStillImages fixedHeightStillImages fixedWidthImages fixedWidthDownsampledImages fixedWidthSmallImages fixedWidthSmallStillImages fixedWidthStillImages loopingImages originalImages originalMp4Images originalStillImages previewImages previewGIFImages previewWebpImages the480WStillImages) =
        object $ foldMap (maybe [] pure)
        [ Just $ "downsized" .= downsizedImages
        , Just $ "downsized_large" .= downsizedLargeImages
        , Just $ "downsized_medium" .= downsizedMediumImages
        , Just $ "downsized_small" .= downsizedSmallImages
        , Just $ "downsized_still" .= downsizedStillImages
        , Just $ "fixed_height" .= fixedHeightImages
        , Just $ "fixed_height_downsampled" .= fixedHeightDownsampledImages
        , Just $ "fixed_height_small" .= fixedHeightSmallImages
        , Just $ "fixed_height_small_still" .= fixedHeightSmallStillImages
        , Just $ "fixed_height_still" .= fixedHeightStillImages
        , Just $ "fixed_width" .= fixedWidthImages
        , Just $ "fixed_width_downsampled" .= fixedWidthDownsampledImages
        , Just $ "fixed_width_small" .= fixedWidthSmallImages
        , Just $ "fixed_width_small_still" .= fixedWidthSmallStillImages
        , Just $ "fixed_width_still" .= fixedWidthStillImages
        , Just $ "looping" .= loopingImages
        , Just $ "original" .= originalImages
        , Just $ "original_mp4" .= originalMp4Images
        , Just $ "original_still" .= originalStillImages
        , Just $ "preview" .= previewImages
        , Just $ "preview_gif" .= previewGIFImages
        , Just $ "preview_webp" .= previewWebpImages
        , ("480w_still" .=) <$> the480WStillImages
        ]

instance FromJSON Images where
    parseJSON (Object v) = Images
        <$> v .: "downsized"
        <*> v .: "downsized_large"
        <*> v .: "downsized_medium"
        <*> v .: "downsized_small"
        <*> v .: "downsized_still"
        <*> v .: "fixed_height"
        <*> v .: "fixed_height_downsampled"
        <*> v .: "fixed_height_small"
        <*> v .: "fixed_height_small_still"
        <*> v .: "fixed_height_still"
        <*> v .: "fixed_width"
        <*> v .: "fixed_width_downsampled"
        <*> v .: "fixed_width_small"
        <*> v .: "fixed_width_small_still"
        <*> v .: "fixed_width_still"
        <*> v .: "looping"
        <*> v .: "original"
        <*> v .: "original_mp4"
        <*> v .: "original_still"
        <*> v .: "preview"
        <*> v .: "preview_gif"
        <*> v .: "preview_webp"
        <*> v .:! "480w_still"

instance ToJSON The480_WStill where
    toJSON (The480_WStill heightThe480_WStill sizeThe480_WStill urlThe480_WStill widthThe480_WStill) =
        object $ foldMap (maybe [] pure)
        [ Just $ "height" .= heightThe480_WStill
        , ("size" .=) <$> sizeThe480_WStill
        , Just $ "url" .= urlThe480_WStill
        , Just $ "width" .= widthThe480_WStill
        ]

instance FromJSON The480_WStill where
    parseJSON (Object v) = The480_WStill
        <$> v .: "height"
        <*> v .:! "size"
        <*> v .: "url"
        <*> v .: "width"

instance ToJSON DownsizedSmall where
    toJSON (DownsizedSmall heightDownsizedSmall mp4DownsizedSmall mp4SizeDownsizedSmall widthDownsizedSmall) =
        object $ foldMap (maybe [] pure)
        [ Just $ "height" .= heightDownsizedSmall
        , Just $ "mp4" .= mp4DownsizedSmall
        , Just $ "mp4_size" .= mp4SizeDownsizedSmall
        , Just $ "width" .= widthDownsizedSmall
        ]

instance FromJSON DownsizedSmall where
    parseJSON (Object v) = DownsizedSmall
        <$> v .: "height"
        <*> v .: "mp4"
        <*> v .: "mp4_size"
        <*> v .: "width"

instance ToJSON FixedHeight where
    toJSON (FixedHeight framesFixedHeight hashFixedHeight heightFixedHeight mp4FixedHeight mp4SizeFixedHeight sizeFixedHeight urlFixedHeight webpFixedHeight webpSizeFixedHeight widthFixedHeight) =
        object $ foldMap (maybe [] pure)
        [ ("frames" .=) <$> framesFixedHeight
        , ("hash" .=) <$> hashFixedHeight
        , Just $ "height" .= heightFixedHeight
        , ("mp4" .=) <$> mp4FixedHeight
        , ("mp4_size" .=) <$> mp4SizeFixedHeight
        , Just $ "size" .= sizeFixedHeight
        , Just $ "url" .= urlFixedHeight
        , Just $ "webp" .= webpFixedHeight
        , Just $ "webp_size" .= webpSizeFixedHeight
        , Just $ "width" .= widthFixedHeight
        ]

instance FromJSON FixedHeight where
    parseJSON (Object v) = FixedHeight
        <$> v .:! "frames"
        <*> v .:! "hash"
        <*> v .: "height"
        <*> v .:! "mp4"
        <*> v .:! "mp4_size"
        <*> v .: "size"
        <*> v .: "url"
        <*> v .: "webp"
        <*> v .: "webp_size"
        <*> v .: "width"

instance ToJSON Looping where
    toJSON (Looping mp4Looping mp4SizeLooping) =
        object $ foldMap (maybe [] pure)
        [ Just $ "mp4" .= mp4Looping
        , Just $ "mp4_size" .= mp4SizeLooping
        ]

instance FromJSON Looping where
    parseJSON (Object v) = Looping
        <$> v .: "mp4"
        <*> v .: "mp4_size"

instance ToJSON Rating where
    toJSON GRating = "g"
    toJSON YRating = "y"
    toJSON PGRating = "pg"
    toJSON PG13_Rating = "pg-13"

instance FromJSON Rating where
    parseJSON = withText "Rating" parseText
        where
            parseText "g" = return GRating
            parseText "y" = return YRating
            parseText "pg" = return PGRating
            parseText "pg-13" = return PG13_Rating

instance ToJSON User where
    toJSON (User avatarURLUser bannerURLUser displayNameUser profileURLUser twitterUser usernameUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avatar_url" .= avatarURLUser
        , Just $ "banner_url" .= bannerURLUser
        , Just $ "display_name" .= displayNameUser
        , Just $ "profile_url" .= profileURLUser
        , Just $ "twitter" .= twitterUser
        , Just $ "username" .= usernameUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "avatar_url"
        <*> v .: "banner_url"
        <*> v .: "display_name"
        <*> v .: "profile_url"
        <*> v .: "twitter"
        <*> v .: "username"

instance ToJSON Username where
    toJSON PurpleUsername = ""
    toJSON ProducthuntUsername = "producthunt"
    toJSON MeetaikoUsername = "meetaiko"
    toJSON CheezburgerUsername = "cheezburger"

instance FromJSON Username where
    parseJSON = withText "Username" parseText
        where
            parseText "" = return PurpleUsername
            parseText "producthunt" = return ProducthuntUsername
            parseText "meetaiko" = return MeetaikoUsername
            parseText "cheezburger" = return CheezburgerUsername
