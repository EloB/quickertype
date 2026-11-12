{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ResultElement (..)
    , Collection (..)
    , Detail (..)
    , FavMovie (..)
    , Image (..)
    , Video (..)
    , VoteScore (..)
    , DetailLanguage (..)
    , Type (..)
    , ResultLanguage (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { countQuickType :: Int
    , nextQuickType :: Text
    , previousQuickType :: Maybe Text
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data ResultElement = ResultElement
    { activeScreensResultElement :: Int
    , collectionsResultElement :: [Collection]
    , detailsResultElement :: [Detail]
    , durationResultElement :: Int
    , favMovieResultElement :: FavMovie
    , imagesResultElement :: [Image]
    , languageResultElement :: ResultLanguage
    , releaseDateResultElement :: Text
    , resultIDResultElement :: Int
    , starsResultElement :: Int
    , tagsResultElement :: Maybe ([Value])
    , titleResultElement :: Text
    , videosResultElement :: [Video]
    , voteScoreResultElement :: VoteScore
    , watchesResultElement :: Int
    } deriving (Show)

data Collection = Collection
    { collectionIDCollection :: Int
    , moviesCollection :: [Int]
    , nameCollection :: Text
    , slugCollection :: Text
    } deriving (Show)

data Detail = Detail
    { castDetail :: Text
    , detailIDDetail :: Int
    , directorDetail :: Text
    , languageDetail :: DetailLanguage
    , storylineDetail :: Text
    , taglineDetail :: Text
    , titleDetail :: Text
    } deriving (Show)

data DetailLanguage
    = EnDetailLanguage
    | ThDetailLanguage
    deriving (Show)

data FavMovie = FavMovie
    { followFavMovie :: Bool
    , starFavMovie :: Bool
    , watchedFavMovie :: Bool
    } deriving (Show)

data Image = Image
    { favsImage :: Int
    , imageIDImage :: Int
    , imageTypeImage :: Type
    , thumbnailImage :: Text
    , urlImage :: Text
    } deriving (Show)

data Type
    = PosterType
    | BackdropType
    deriving (Show)

data ResultLanguage
    = EnResultLanguage
    | PurpleResultLanguage
    deriving (Show)

data Video = Video
    { kindVideo :: Text
    , languageVideo :: ResultLanguage
    , sourceVideo :: Text
    , urlVideo :: Text
    } deriving (Show)

data VoteScore = VoteScore
    { avgVoteScore :: Int
    , scoreVoteScore :: Int
    , totalVoteScore :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType countQuickType nextQuickType previousQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countQuickType
        , Just $ "next" .= nextQuickType
        , Just $ "previous" .= previousQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "count"
        <*> v .: "next"
        <*> v .: "previous"
        <*> v .: "results"

instance ToJSON ResultElement where
    toJSON (ResultElement activeScreensResultElement collectionsResultElement detailsResultElement durationResultElement favMovieResultElement imagesResultElement languageResultElement releaseDateResultElement resultIDResultElement starsResultElement tagsResultElement titleResultElement videosResultElement voteScoreResultElement watchesResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "active_screens" .= activeScreensResultElement
        , Just $ "collections" .= collectionsResultElement
        , Just $ "details" .= detailsResultElement
        , Just $ "duration" .= durationResultElement
        , Just $ "fav_movie" .= favMovieResultElement
        , Just $ "images" .= imagesResultElement
        , Just $ "language" .= languageResultElement
        , Just $ "release_date" .= releaseDateResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "stars" .= starsResultElement
        , Just $ "tags" .= tagsResultElement
        , Just $ "title" .= titleResultElement
        , Just $ "videos" .= videosResultElement
        , Just $ "vote_score" .= voteScoreResultElement
        , Just $ "watches" .= watchesResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "active_screens"
        <*> v .: "collections"
        <*> v .: "details"
        <*> v .: "duration"
        <*> v .: "fav_movie"
        <*> v .: "images"
        <*> v .: "language"
        <*> v .: "release_date"
        <*> v .: "id"
        <*> v .: "stars"
        <*> v .: "tags"
        <*> v .: "title"
        <*> v .: "videos"
        <*> v .: "vote_score"
        <*> v .: "watches"

instance ToJSON Collection where
    toJSON (Collection collectionIDCollection moviesCollection nameCollection slugCollection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= collectionIDCollection
        , Just $ "movies" .= moviesCollection
        , Just $ "name" .= nameCollection
        , Just $ "slug" .= slugCollection
        ]

instance FromJSON Collection where
    parseJSON (Object v) = Collection
        <$> v .: "id"
        <*> v .: "movies"
        <*> v .: "name"
        <*> v .: "slug"

instance ToJSON Detail where
    toJSON (Detail castDetail detailIDDetail directorDetail languageDetail storylineDetail taglineDetail titleDetail) =
        object $ foldMap (maybe [] pure)
        [ Just $ "cast" .= castDetail
        , Just $ "id" .= detailIDDetail
        , Just $ "director" .= directorDetail
        , Just $ "language" .= languageDetail
        , Just $ "storyline" .= storylineDetail
        , Just $ "tagline" .= taglineDetail
        , Just $ "title" .= titleDetail
        ]

instance FromJSON Detail where
    parseJSON (Object v) = Detail
        <$> v .: "cast"
        <*> v .: "id"
        <*> v .: "director"
        <*> v .: "language"
        <*> v .: "storyline"
        <*> v .: "tagline"
        <*> v .: "title"

instance ToJSON DetailLanguage where
    toJSON EnDetailLanguage = "en"
    toJSON ThDetailLanguage = "th"

instance FromJSON DetailLanguage where
    parseJSON = withText "DetailLanguage" parseText
        where
            parseText "en" = return EnDetailLanguage
            parseText "th" = return ThDetailLanguage

instance ToJSON FavMovie where
    toJSON (FavMovie followFavMovie starFavMovie watchedFavMovie) =
        object $ foldMap (maybe [] pure)
        [ Just $ "follow" .= followFavMovie
        , Just $ "star" .= starFavMovie
        , Just $ "watched" .= watchedFavMovie
        ]

instance FromJSON FavMovie where
    parseJSON (Object v) = FavMovie
        <$> v .: "follow"
        <*> v .: "star"
        <*> v .: "watched"

instance ToJSON Image where
    toJSON (Image favsImage imageIDImage imageTypeImage thumbnailImage urlImage) =
        object $ foldMap (maybe [] pure)
        [ Just $ "favs" .= favsImage
        , Just $ "id" .= imageIDImage
        , Just $ "type" .= imageTypeImage
        , Just $ "thumbnail" .= thumbnailImage
        , Just $ "url" .= urlImage
        ]

instance FromJSON Image where
    parseJSON (Object v) = Image
        <$> v .: "favs"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "thumbnail"
        <*> v .: "url"

instance ToJSON Type where
    toJSON PosterType = "Poster"
    toJSON BackdropType = "Backdrop"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "Poster" = return PosterType
            parseText "Backdrop" = return BackdropType

instance ToJSON ResultLanguage where
    toJSON EnResultLanguage = "en"
    toJSON PurpleResultLanguage = "-"

instance FromJSON ResultLanguage where
    parseJSON = withText "ResultLanguage" parseText
        where
            parseText "en" = return EnResultLanguage
            parseText "-" = return PurpleResultLanguage

instance ToJSON Video where
    toJSON (Video kindVideo languageVideo sourceVideo urlVideo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "kind" .= kindVideo
        , Just $ "language" .= languageVideo
        , Just $ "source" .= sourceVideo
        , Just $ "url" .= urlVideo
        ]

instance FromJSON Video where
    parseJSON (Object v) = Video
        <$> v .: "kind"
        <*> v .: "language"
        <*> v .: "source"
        <*> v .: "url"

instance ToJSON VoteScore where
    toJSON (VoteScore avgVoteScore scoreVoteScore totalVoteScore) =
        object $ foldMap (maybe [] pure)
        [ Just $ "avg" .= avgVoteScore
        , Just $ "score" .= scoreVoteScore
        , Just $ "total" .= totalVoteScore
        ]

instance FromJSON VoteScore where
    parseJSON (Object v) = VoteScore
        <$> v .: "avg"
        <*> v .: "score"
        <*> v .: "total"
