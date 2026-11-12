{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Artist (..)
    , ExternalUrls (..)
    , Copyright (..)
    , ExternalIDS (..)
    , Image (..)
    , Tracks (..)
    , Item (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { albumTypeQuickType :: Text
    , artistsQuickType :: [Artist]
    , availableMarketsQuickType :: [Text]
    , copyrightsQuickType :: [Copyright]
    , externalIDSQuickType :: ExternalIDS
    , externalUrlsQuickType :: ExternalUrls
    , genresQuickType :: [Value]
    , hrefQuickType :: Text
    , imagesQuickType :: [Image]
    , nameQuickType :: Text
    , popularityQuickType :: Int
    , quickTypeIDQuickType :: Text
    , quickTypeTypeQuickType :: Text
    , releaseDateQuickType :: Text
    , releaseDatePrecisionQuickType :: Text
    , tracksQuickType :: Tracks
    , uriQuickType :: Text
    } deriving (Show)

data Artist = Artist
    { artistIDArtist :: Text
    , artistTypeArtist :: Text
    , externalUrlsArtist :: ExternalUrls
    , hrefArtist :: Text
    , nameArtist :: Text
    , uriArtist :: Text
    } deriving (Show)

data ExternalUrls = ExternalUrls
    { spotifyExternalUrls :: Text
    } deriving (Show)

data Copyright = Copyright
    { copyrightTextCopyright :: Text
    , copyrightTypeCopyright :: Text
    } deriving (Show)

data ExternalIDS = ExternalIDS
    { upcExternalIDS :: Text
    } deriving (Show)

data Image = Image
    { heightImage :: Int
    , urlImage :: Text
    , widthImage :: Int
    } deriving (Show)

data Tracks = Tracks
    { hrefTracks :: Text
    , itemsTracks :: [Item]
    , limitTracks :: Int
    , nextTracks :: Maybe Text
    , offsetTracks :: Int
    , previousTracks :: Maybe Text
    , totalTracks :: Int
    } deriving (Show)

data Item = Item
    { artistsItem :: [Artist]
    , availableMarketsItem :: [Text]
    , discNumberItem :: Int
    , durationMSItem :: Int
    , explicitItem :: Bool
    , externalUrlsItem :: ExternalUrls
    , hrefItem :: Text
    , itemIDItem :: Text
    , itemTypeItem :: Text
    , nameItem :: Text
    , previewURLItem :: Text
    , trackNumberItem :: Int
    , uriItem :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType albumTypeQuickType artistsQuickType availableMarketsQuickType copyrightsQuickType externalIDSQuickType externalUrlsQuickType genresQuickType hrefQuickType imagesQuickType nameQuickType popularityQuickType quickTypeIDQuickType quickTypeTypeQuickType releaseDateQuickType releaseDatePrecisionQuickType tracksQuickType uriQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "album_type" .= albumTypeQuickType
        , Just $ "artists" .= artistsQuickType
        , Just $ "available_markets" .= availableMarketsQuickType
        , Just $ "copyrights" .= copyrightsQuickType
        , Just $ "external_ids" .= externalIDSQuickType
        , Just $ "external_urls" .= externalUrlsQuickType
        , Just $ "genres" .= genresQuickType
        , Just $ "href" .= hrefQuickType
        , Just $ "images" .= imagesQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "popularity" .= popularityQuickType
        , Just $ "id" .= quickTypeIDQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        , Just $ "release_date" .= releaseDateQuickType
        , Just $ "release_date_precision" .= releaseDatePrecisionQuickType
        , Just $ "tracks" .= tracksQuickType
        , Just $ "uri" .= uriQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "album_type"
        <*> v .: "artists"
        <*> v .: "available_markets"
        <*> v .: "copyrights"
        <*> v .: "external_ids"
        <*> v .: "external_urls"
        <*> v .: "genres"
        <*> v .: "href"
        <*> v .: "images"
        <*> v .: "name"
        <*> v .: "popularity"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "release_date"
        <*> v .: "release_date_precision"
        <*> v .: "tracks"
        <*> v .: "uri"

instance ToJSON Artist where
    toJSON (Artist artistIDArtist artistTypeArtist externalUrlsArtist hrefArtist nameArtist uriArtist) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= artistIDArtist
        , Just $ "type" .= artistTypeArtist
        , Just $ "external_urls" .= externalUrlsArtist
        , Just $ "href" .= hrefArtist
        , Just $ "name" .= nameArtist
        , Just $ "uri" .= uriArtist
        ]

instance FromJSON Artist where
    parseJSON (Object v) = Artist
        <$> v .: "id"
        <*> v .: "type"
        <*> v .: "external_urls"
        <*> v .: "href"
        <*> v .: "name"
        <*> v .: "uri"

instance ToJSON ExternalUrls where
    toJSON (ExternalUrls spotifyExternalUrls) =
        object $ foldMap (maybe [] pure)
        [ Just $ "spotify" .= spotifyExternalUrls
        ]

instance FromJSON ExternalUrls where
    parseJSON (Object v) = ExternalUrls
        <$> v .: "spotify"

instance ToJSON Copyright where
    toJSON (Copyright copyrightTextCopyright copyrightTypeCopyright) =
        object $ foldMap (maybe [] pure)
        [ Just $ "text" .= copyrightTextCopyright
        , Just $ "type" .= copyrightTypeCopyright
        ]

instance FromJSON Copyright where
    parseJSON (Object v) = Copyright
        <$> v .: "text"
        <*> v .: "type"

instance ToJSON ExternalIDS where
    toJSON (ExternalIDS upcExternalIDS) =
        object $ foldMap (maybe [] pure)
        [ Just $ "upc" .= upcExternalIDS
        ]

instance FromJSON ExternalIDS where
    parseJSON (Object v) = ExternalIDS
        <$> v .: "upc"

instance ToJSON Image where
    toJSON (Image heightImage urlImage widthImage) =
        object $ foldMap (maybe [] pure)
        [ Just $ "height" .= heightImage
        , Just $ "url" .= urlImage
        , Just $ "width" .= widthImage
        ]

instance FromJSON Image where
    parseJSON (Object v) = Image
        <$> v .: "height"
        <*> v .: "url"
        <*> v .: "width"

instance ToJSON Tracks where
    toJSON (Tracks hrefTracks itemsTracks limitTracks nextTracks offsetTracks previousTracks totalTracks) =
        object $ foldMap (maybe [] pure)
        [ Just $ "href" .= hrefTracks
        , Just $ "items" .= itemsTracks
        , Just $ "limit" .= limitTracks
        , Just $ "next" .= nextTracks
        , Just $ "offset" .= offsetTracks
        , Just $ "previous" .= previousTracks
        , Just $ "total" .= totalTracks
        ]

instance FromJSON Tracks where
    parseJSON (Object v) = Tracks
        <$> v .: "href"
        <*> v .: "items"
        <*> v .: "limit"
        <*> v .: "next"
        <*> v .: "offset"
        <*> v .: "previous"
        <*> v .: "total"

instance ToJSON Item where
    toJSON (Item artistsItem availableMarketsItem discNumberItem durationMSItem explicitItem externalUrlsItem hrefItem itemIDItem itemTypeItem nameItem previewURLItem trackNumberItem uriItem) =
        object $ foldMap (maybe [] pure)
        [ Just $ "artists" .= artistsItem
        , Just $ "available_markets" .= availableMarketsItem
        , Just $ "disc_number" .= discNumberItem
        , Just $ "duration_ms" .= durationMSItem
        , Just $ "explicit" .= explicitItem
        , Just $ "external_urls" .= externalUrlsItem
        , Just $ "href" .= hrefItem
        , Just $ "id" .= itemIDItem
        , Just $ "type" .= itemTypeItem
        , Just $ "name" .= nameItem
        , Just $ "preview_url" .= previewURLItem
        , Just $ "track_number" .= trackNumberItem
        , Just $ "uri" .= uriItem
        ]

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .: "artists"
        <*> v .: "available_markets"
        <*> v .: "disc_number"
        <*> v .: "duration_ms"
        <*> v .: "explicit"
        <*> v .: "external_urls"
        <*> v .: "href"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "name"
        <*> v .: "preview_url"
        <*> v .: "track_number"
        <*> v .: "uri"
