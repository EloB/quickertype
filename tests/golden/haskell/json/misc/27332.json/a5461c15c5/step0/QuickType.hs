{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeData (..)
    , Child (..)
    , ChildData (..)
    , Media (..)
    , Oembed (..)
    , MediaEmbed (..)
    , Preview (..)
    , Image (..)
    , Source (..)
    , Variants (..)
    , Domain (..)
    , PostHint (..)
    , Subreddit (..)
    , SubredditID (..)
    , SubredditNamePrefixed (..)
    , SubredditType (..)
    , Kind (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { kindQuickType :: Text
    , quickTypeDataQuickType :: QuickTypeData
    } deriving (Show)

data QuickTypeData = QuickTypeData
    { afterQuickTypeData :: Text
    , beforeQuickTypeData :: Maybe Text
    , childrenQuickTypeData :: [Child]
    , modhashQuickTypeData :: Text
    } deriving (Show)

data Child = Child
    { childDataChild :: ChildData
    , kindChild :: Kind
    } deriving (Show)

data ChildData = ChildData
    { approvedAtUTCChildData :: Maybe Text
    , approvedByChildData :: Maybe Text
    , archivedChildData :: Bool
    , authorChildData :: Text
    , authorFlairCSSClassChildData :: Maybe Text
    , authorFlairTextChildData :: Maybe Text
    , bannedAtUTCChildData :: Maybe Text
    , bannedByChildData :: Maybe Text
    , brandSafeChildData :: Bool
    , canGildChildData :: Bool
    , canModPostChildData :: Bool
    , clickedChildData :: Bool
    , contestModeChildData :: Bool
    , createdChildData :: Double
    , createdUTCChildData :: Double
    , dataIDChildData :: Text
    , distinguishedChildData :: Maybe Text
    , domainChildData :: Domain
    , downsChildData :: Int
    , editedChildData :: Bool
    , gildedChildData :: Int
    , hiddenChildData :: Bool
    , hideScoreChildData :: Bool
    , isSelfChildData :: Bool
    , isVideoChildData :: Bool
    , likesChildData :: Maybe Text
    , linkFlairCSSClassChildData :: Maybe Text
    , linkFlairTextChildData :: Maybe Text
    , lockedChildData :: Bool
    , mediaChildData :: Maybe Media
    , mediaEmbedChildData :: MediaEmbed
    , modReportsChildData :: [Value]
    , nameChildData :: Text
    , numCommentsChildData :: Int
    , numReportsChildData :: Maybe Text
    , over18ChildData :: Bool
    , permalinkChildData :: Text
    , postHintChildData :: Maybe PostHint
    , previewChildData :: Maybe Preview
    , quarantineChildData :: Bool
    , removalReasonChildData :: Maybe Text
    , reportReasonsChildData :: Maybe Text
    , savedChildData :: Bool
    , scoreChildData :: Int
    , secureMediaChildData :: Maybe Media
    , secureMediaEmbedChildData :: MediaEmbed
    , selftextChildData :: Text
    , selftextHTMLChildData :: Maybe Text
    , spoilerChildData :: Bool
    , stickiedChildData :: Bool
    , subredditChildData :: Subreddit
    , subredditIDChildData :: SubredditID
    , subredditNamePrefixedChildData :: SubredditNamePrefixed
    , subredditTypeChildData :: SubredditType
    , suggestedSortChildData :: Maybe Text
    , thumbnailChildData :: Text
    , thumbnailHeightChildData :: Maybe Int
    , thumbnailWidthChildData :: Maybe Int
    , titleChildData :: Text
    , upsChildData :: Int
    , urlChildData :: Text
    , userReportsChildData :: [Value]
    , viewCountChildData :: Maybe Text
    , visitedChildData :: Bool
    } deriving (Show)

data Domain
    = SelfPicsDomain
    | ImgurCOMDomain
    | IImgurCOMDomain
    | IReddItDomain
    deriving (Show)

data Media = Media
    { mediaTypeMedia :: Domain
    , oembedMedia :: Oembed
    } deriving (Show)

data Oembed = Oembed
    { descriptionOembed :: Text
    , heightOembed :: Int
    , htmlOembed :: Text
    , oembedTypeOembed :: Text
    , providerNameOembed :: Text
    , providerURLOembed :: Text
    , thumbnailHeightOembed :: Int
    , thumbnailURLOembed :: Text
    , thumbnailWidthOembed :: Int
    , titleOembed :: Text
    , versionOembed :: Text
    , widthOembed :: Int
    } deriving (Show)

data MediaEmbed = MediaEmbed
    { contentMediaEmbed :: Maybe Text
    , heightMediaEmbed :: Maybe Int
    , scrollingMediaEmbed :: Maybe Bool
    , widthMediaEmbed :: Maybe Int
    } deriving (Show)

data PostHint
    = LinkPostHint
    | ImagePostHint
    deriving (Show)

data Preview = Preview
    { enabledPreview :: Bool
    , imagesPreview :: [Image]
    } deriving (Show)

data Image = Image
    { imageIDImage :: Text
    , resolutionsImage :: [Source]
    , sourceImage :: Source
    , variantsImage :: Variants
    } deriving (Show)

data Source = Source
    { heightSource :: Int
    , urlSource :: Text
    , widthSource :: Int
    } deriving (Show)

data Variants = Variants
    {
    } deriving (Show)

data Subreddit
    = PicsSubreddit
    deriving (Show)

data SubredditID
    = T52Qh0USubredditID
    deriving (Show)

data SubredditNamePrefixed
    = RPicsSubredditNamePrefixed
    deriving (Show)

data SubredditType
    = PublicSubredditType
    deriving (Show)

data Kind
    = T3Kind
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType kindQuickType quickTypeDataQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "kind" .= kindQuickType
        , Just $ "data" .= quickTypeDataQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "kind"
        <*> v .: "data"

instance ToJSON QuickTypeData where
    toJSON (QuickTypeData afterQuickTypeData beforeQuickTypeData childrenQuickTypeData modhashQuickTypeData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "after" .= afterQuickTypeData
        , Just $ "before" .= beforeQuickTypeData
        , Just $ "children" .= childrenQuickTypeData
        , Just $ "modhash" .= modhashQuickTypeData
        ]

instance FromJSON QuickTypeData where
    parseJSON (Object v) = QuickTypeData
        <$> v .: "after"
        <*> v .: "before"
        <*> v .: "children"
        <*> v .: "modhash"

instance ToJSON Child where
    toJSON (Child childDataChild kindChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= childDataChild
        , Just $ "kind" .= kindChild
        ]

instance FromJSON Child where
    parseJSON (Object v) = Child
        <$> v .: "data"
        <*> v .: "kind"

instance ToJSON ChildData where
    toJSON (ChildData approvedAtUTCChildData approvedByChildData archivedChildData authorChildData authorFlairCSSClassChildData authorFlairTextChildData bannedAtUTCChildData bannedByChildData brandSafeChildData canGildChildData canModPostChildData clickedChildData contestModeChildData createdChildData createdUTCChildData dataIDChildData distinguishedChildData domainChildData downsChildData editedChildData gildedChildData hiddenChildData hideScoreChildData isSelfChildData isVideoChildData likesChildData linkFlairCSSClassChildData linkFlairTextChildData lockedChildData mediaChildData mediaEmbedChildData modReportsChildData nameChildData numCommentsChildData numReportsChildData over18ChildData permalinkChildData postHintChildData previewChildData quarantineChildData removalReasonChildData reportReasonsChildData savedChildData scoreChildData secureMediaChildData secureMediaEmbedChildData selftextChildData selftextHTMLChildData spoilerChildData stickiedChildData subredditChildData subredditIDChildData subredditNamePrefixedChildData subredditTypeChildData suggestedSortChildData thumbnailChildData thumbnailHeightChildData thumbnailWidthChildData titleChildData upsChildData urlChildData userReportsChildData viewCountChildData visitedChildData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "approved_at_utc" .= approvedAtUTCChildData
        , Just $ "approved_by" .= approvedByChildData
        , Just $ "archived" .= archivedChildData
        , Just $ "author" .= authorChildData
        , Just $ "author_flair_css_class" .= authorFlairCSSClassChildData
        , Just $ "author_flair_text" .= authorFlairTextChildData
        , Just $ "banned_at_utc" .= bannedAtUTCChildData
        , Just $ "banned_by" .= bannedByChildData
        , Just $ "brand_safe" .= brandSafeChildData
        , Just $ "can_gild" .= canGildChildData
        , Just $ "can_mod_post" .= canModPostChildData
        , Just $ "clicked" .= clickedChildData
        , Just $ "contest_mode" .= contestModeChildData
        , Just $ "created" .= createdChildData
        , Just $ "created_utc" .= createdUTCChildData
        , Just $ "id" .= dataIDChildData
        , Just $ "distinguished" .= distinguishedChildData
        , Just $ "domain" .= domainChildData
        , Just $ "downs" .= downsChildData
        , Just $ "edited" .= editedChildData
        , Just $ "gilded" .= gildedChildData
        , Just $ "hidden" .= hiddenChildData
        , Just $ "hide_score" .= hideScoreChildData
        , Just $ "is_self" .= isSelfChildData
        , Just $ "is_video" .= isVideoChildData
        , Just $ "likes" .= likesChildData
        , Just $ "link_flair_css_class" .= linkFlairCSSClassChildData
        , Just $ "link_flair_text" .= linkFlairTextChildData
        , Just $ "locked" .= lockedChildData
        , Just $ "media" .= mediaChildData
        , Just $ "media_embed" .= mediaEmbedChildData
        , Just $ "mod_reports" .= modReportsChildData
        , Just $ "name" .= nameChildData
        , Just $ "num_comments" .= numCommentsChildData
        , Just $ "num_reports" .= numReportsChildData
        , Just $ "over_18" .= over18ChildData
        , Just $ "permalink" .= permalinkChildData
        , ("post_hint" .=) <$> postHintChildData
        , ("preview" .=) <$> previewChildData
        , Just $ "quarantine" .= quarantineChildData
        , Just $ "removal_reason" .= removalReasonChildData
        , Just $ "report_reasons" .= reportReasonsChildData
        , Just $ "saved" .= savedChildData
        , Just $ "score" .= scoreChildData
        , Just $ "secure_media" .= secureMediaChildData
        , Just $ "secure_media_embed" .= secureMediaEmbedChildData
        , Just $ "selftext" .= selftextChildData
        , Just $ "selftext_html" .= selftextHTMLChildData
        , Just $ "spoiler" .= spoilerChildData
        , Just $ "stickied" .= stickiedChildData
        , Just $ "subreddit" .= subredditChildData
        , Just $ "subreddit_id" .= subredditIDChildData
        , Just $ "subreddit_name_prefixed" .= subredditNamePrefixedChildData
        , Just $ "subreddit_type" .= subredditTypeChildData
        , Just $ "suggested_sort" .= suggestedSortChildData
        , Just $ "thumbnail" .= thumbnailChildData
        , Just $ "thumbnail_height" .= thumbnailHeightChildData
        , Just $ "thumbnail_width" .= thumbnailWidthChildData
        , Just $ "title" .= titleChildData
        , Just $ "ups" .= upsChildData
        , Just $ "url" .= urlChildData
        , Just $ "user_reports" .= userReportsChildData
        , Just $ "view_count" .= viewCountChildData
        , Just $ "visited" .= visitedChildData
        ]

instance FromJSON ChildData where
    parseJSON (Object v) = ChildData
        <$> v .: "approved_at_utc"
        <*> v .: "approved_by"
        <*> v .: "archived"
        <*> v .: "author"
        <*> v .: "author_flair_css_class"
        <*> v .: "author_flair_text"
        <*> v .: "banned_at_utc"
        <*> v .: "banned_by"
        <*> v .: "brand_safe"
        <*> v .: "can_gild"
        <*> v .: "can_mod_post"
        <*> v .: "clicked"
        <*> v .: "contest_mode"
        <*> v .: "created"
        <*> v .: "created_utc"
        <*> v .: "id"
        <*> v .: "distinguished"
        <*> v .: "domain"
        <*> v .: "downs"
        <*> v .: "edited"
        <*> v .: "gilded"
        <*> v .: "hidden"
        <*> v .: "hide_score"
        <*> v .: "is_self"
        <*> v .: "is_video"
        <*> v .: "likes"
        <*> v .: "link_flair_css_class"
        <*> v .: "link_flair_text"
        <*> v .: "locked"
        <*> v .: "media"
        <*> v .: "media_embed"
        <*> v .: "mod_reports"
        <*> v .: "name"
        <*> v .: "num_comments"
        <*> v .: "num_reports"
        <*> v .: "over_18"
        <*> v .: "permalink"
        <*> v .:! "post_hint"
        <*> v .:! "preview"
        <*> v .: "quarantine"
        <*> v .: "removal_reason"
        <*> v .: "report_reasons"
        <*> v .: "saved"
        <*> v .: "score"
        <*> v .: "secure_media"
        <*> v .: "secure_media_embed"
        <*> v .: "selftext"
        <*> v .: "selftext_html"
        <*> v .: "spoiler"
        <*> v .: "stickied"
        <*> v .: "subreddit"
        <*> v .: "subreddit_id"
        <*> v .: "subreddit_name_prefixed"
        <*> v .: "subreddit_type"
        <*> v .: "suggested_sort"
        <*> v .: "thumbnail"
        <*> v .: "thumbnail_height"
        <*> v .: "thumbnail_width"
        <*> v .: "title"
        <*> v .: "ups"
        <*> v .: "url"
        <*> v .: "user_reports"
        <*> v .: "view_count"
        <*> v .: "visited"

instance ToJSON Domain where
    toJSON SelfPicsDomain = "self.pics"
    toJSON ImgurCOMDomain = "imgur.com"
    toJSON IImgurCOMDomain = "i.imgur.com"
    toJSON IReddItDomain = "i.redd.it"

instance FromJSON Domain where
    parseJSON = withText "Domain" parseText
        where
            parseText "self.pics" = return SelfPicsDomain
            parseText "imgur.com" = return ImgurCOMDomain
            parseText "i.imgur.com" = return IImgurCOMDomain
            parseText "i.redd.it" = return IReddItDomain

instance ToJSON Media where
    toJSON (Media mediaTypeMedia oembedMedia) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= mediaTypeMedia
        , Just $ "oembed" .= oembedMedia
        ]

instance FromJSON Media where
    parseJSON (Object v) = Media
        <$> v .: "type"
        <*> v .: "oembed"

instance ToJSON Oembed where
    toJSON (Oembed descriptionOembed heightOembed htmlOembed oembedTypeOembed providerNameOembed providerURLOembed thumbnailHeightOembed thumbnailURLOembed thumbnailWidthOembed titleOembed versionOembed widthOembed) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionOembed
        , Just $ "height" .= heightOembed
        , Just $ "html" .= htmlOembed
        , Just $ "type" .= oembedTypeOembed
        , Just $ "provider_name" .= providerNameOembed
        , Just $ "provider_url" .= providerURLOembed
        , Just $ "thumbnail_height" .= thumbnailHeightOembed
        , Just $ "thumbnail_url" .= thumbnailURLOembed
        , Just $ "thumbnail_width" .= thumbnailWidthOembed
        , Just $ "title" .= titleOembed
        , Just $ "version" .= versionOembed
        , Just $ "width" .= widthOembed
        ]

instance FromJSON Oembed where
    parseJSON (Object v) = Oembed
        <$> v .: "description"
        <*> v .: "height"
        <*> v .: "html"
        <*> v .: "type"
        <*> v .: "provider_name"
        <*> v .: "provider_url"
        <*> v .: "thumbnail_height"
        <*> v .: "thumbnail_url"
        <*> v .: "thumbnail_width"
        <*> v .: "title"
        <*> v .: "version"
        <*> v .: "width"

instance ToJSON MediaEmbed where
    toJSON (MediaEmbed contentMediaEmbed heightMediaEmbed scrollingMediaEmbed widthMediaEmbed) =
        object $ foldMap (maybe [] pure)
        [ ("content" .=) <$> contentMediaEmbed
        , ("height" .=) <$> heightMediaEmbed
        , ("scrolling" .=) <$> scrollingMediaEmbed
        , ("width" .=) <$> widthMediaEmbed
        ]

instance FromJSON MediaEmbed where
    parseJSON (Object v) = MediaEmbed
        <$> v .:! "content"
        <*> v .:! "height"
        <*> v .:! "scrolling"
        <*> v .:! "width"

instance ToJSON PostHint where
    toJSON LinkPostHint = "link"
    toJSON ImagePostHint = "image"

instance FromJSON PostHint where
    parseJSON = withText "PostHint" parseText
        where
            parseText "link" = return LinkPostHint
            parseText "image" = return ImagePostHint

instance ToJSON Preview where
    toJSON (Preview enabledPreview imagesPreview) =
        object $ foldMap (maybe [] pure)
        [ Just $ "enabled" .= enabledPreview
        , Just $ "images" .= imagesPreview
        ]

instance FromJSON Preview where
    parseJSON (Object v) = Preview
        <$> v .: "enabled"
        <*> v .: "images"

instance ToJSON Image where
    toJSON (Image imageIDImage resolutionsImage sourceImage variantsImage) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= imageIDImage
        , Just $ "resolutions" .= resolutionsImage
        , Just $ "source" .= sourceImage
        , Just $ "variants" .= variantsImage
        ]

instance FromJSON Image where
    parseJSON (Object v) = Image
        <$> v .: "id"
        <*> v .: "resolutions"
        <*> v .: "source"
        <*> v .: "variants"

instance ToJSON Source where
    toJSON (Source heightSource urlSource widthSource) =
        object $ foldMap (maybe [] pure)
        [ Just $ "height" .= heightSource
        , Just $ "url" .= urlSource
        , Just $ "width" .= widthSource
        ]

instance FromJSON Source where
    parseJSON (Object v) = Source
        <$> v .: "height"
        <*> v .: "url"
        <*> v .: "width"

instance ToJSON Variants where
    toJSON = \_ -> emptyObject

instance FromJSON Variants where
    parseJSON (Object _) = return Variants

instance ToJSON Subreddit where
    toJSON PicsSubreddit = "pics"

instance FromJSON Subreddit where
    parseJSON = withText "Subreddit" parseText
        where
            parseText "pics" = return PicsSubreddit

instance ToJSON SubredditID where
    toJSON T52Qh0USubredditID = "t5_2qh0u"

instance FromJSON SubredditID where
    parseJSON = withText "SubredditID" parseText
        where
            parseText "t5_2qh0u" = return T52Qh0USubredditID

instance ToJSON SubredditNamePrefixed where
    toJSON RPicsSubredditNamePrefixed = "r/pics"

instance FromJSON SubredditNamePrefixed where
    parseJSON = withText "SubredditNamePrefixed" parseText
        where
            parseText "r/pics" = return RPicsSubredditNamePrefixed

instance ToJSON SubredditType where
    toJSON PublicSubredditType = "public"

instance FromJSON SubredditType where
    parseJSON = withText "SubredditType" parseText
        where
            parseText "public" = return PublicSubredditType

instance ToJSON Kind where
    toJSON T3Kind = "t3"

instance FromJSON Kind where
    parseJSON = withText "Kind" parseText
        where
            parseText "t3" = return T3Kind
