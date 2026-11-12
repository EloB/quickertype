-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , Artist
    , ExternalUrls
    , Copyright
    , ExternalIDS
    , Image
    , Tracks
    , Item
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { albumType : String
    , artists : List Artist
    , availableMarkets : List String
    , copyrights : List Copyright
    , externalIDS : ExternalIDS
    , externalUrls : ExternalUrls
    , genres : List Jdec.Value
    , href : String
    , id : String
    , images : List Image
    , name : String
    , popularity : Int
    , quickTypeType : String
    , releaseDate : String
    , releaseDatePrecision : String
    , tracks : Tracks
    , uri : String
    }

type alias Artist =
    { artistType : String
    , externalUrls : ExternalUrls
    , href : String
    , id : String
    , name : String
    , uri : String
    }

type alias ExternalUrls =
    { spotify : String
    }

type alias Copyright =
    { copyrightType : String
    , text : String
    }

type alias ExternalIDS =
    { upc : String
    }

type alias Image =
    { height : Int
    , url : String
    , width : Int
    }

type alias Tracks =
    { href : String
    , items : List Item
    , limit : Int
    , next : ()
    , offset : Int
    , previous : ()
    , total : Int
    }

type alias Item =
    { artists : List Artist
    , availableMarkets : List String
    , discNumber : Int
    , durationMS : Int
    , explicit : Bool
    , externalUrls : ExternalUrls
    , href : String
    , id : String
    , itemType : String
    , name : String
    , previewURL : String
    , trackNumber : Int
    , uri : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "album_type" Jdec.string
        |> Jpipe.required "artists" (Jdec.list artist )
        |> Jpipe.required "available_markets" (Jdec.list Jdec.string )
        |> Jpipe.required "copyrights" (Jdec.list copyright )
        |> Jpipe.required "external_ids" externalIDS
        |> Jpipe.required "external_urls" externalUrls
        |> Jpipe.required "genres" (Jdec.list Jdec.value )
        |> Jpipe.required "href" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "images" (Jdec.list image )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "popularity" Jdec.int
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "release_date" Jdec.string
        |> Jpipe.required "release_date_precision" Jdec.string
        |> Jpipe.required "tracks" tracks
        |> Jpipe.required "uri" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("album_type", Jenc.string x.albumType)
        , ("artists", Jenc.list encodeArtist x.artists)
        , ("available_markets", Jenc.list Jenc.string x.availableMarkets)
        , ("copyrights", Jenc.list encodeCopyright x.copyrights)
        , ("external_ids", encodeExternalIDS x.externalIDS)
        , ("external_urls", encodeExternalUrls x.externalUrls)
        , ("genres", Jenc.list identity x.genres)
        , ("href", Jenc.string x.href)
        , ("id", Jenc.string x.id)
        , ("images", Jenc.list encodeImage x.images)
        , ("name", Jenc.string x.name)
        , ("popularity", Jenc.int x.popularity)
        , ("type", Jenc.string x.quickTypeType)
        , ("release_date", Jenc.string x.releaseDate)
        , ("release_date_precision", Jenc.string x.releaseDatePrecision)
        , ("tracks", encodeTracks x.tracks)
        , ("uri", Jenc.string x.uri)
        ]

artist : Jdec.Decoder Artist
artist =
    Jdec.succeed Artist
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "external_urls" externalUrls
        |> Jpipe.required "href" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "uri" Jdec.string

encodeArtist : Artist -> Jenc.Value
encodeArtist x =
    Jenc.object
        [ ("type", Jenc.string x.artistType)
        , ("external_urls", encodeExternalUrls x.externalUrls)
        , ("href", Jenc.string x.href)
        , ("id", Jenc.string x.id)
        , ("name", Jenc.string x.name)
        , ("uri", Jenc.string x.uri)
        ]

externalUrls : Jdec.Decoder ExternalUrls
externalUrls =
    Jdec.succeed ExternalUrls
        |> Jpipe.required "spotify" Jdec.string

encodeExternalUrls : ExternalUrls -> Jenc.Value
encodeExternalUrls x =
    Jenc.object
        [ ("spotify", Jenc.string x.spotify)
        ]

copyright : Jdec.Decoder Copyright
copyright =
    Jdec.succeed Copyright
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "text" Jdec.string

encodeCopyright : Copyright -> Jenc.Value
encodeCopyright x =
    Jenc.object
        [ ("type", Jenc.string x.copyrightType)
        , ("text", Jenc.string x.text)
        ]

externalIDS : Jdec.Decoder ExternalIDS
externalIDS =
    Jdec.succeed ExternalIDS
        |> Jpipe.required "upc" Jdec.string

encodeExternalIDS : ExternalIDS -> Jenc.Value
encodeExternalIDS x =
    Jenc.object
        [ ("upc", Jenc.string x.upc)
        ]

image : Jdec.Decoder Image
image =
    Jdec.succeed Image
        |> Jpipe.required "height" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "width" Jdec.int

encodeImage : Image -> Jenc.Value
encodeImage x =
    Jenc.object
        [ ("height", Jenc.int x.height)
        , ("url", Jenc.string x.url)
        , ("width", Jenc.int x.width)
        ]

tracks : Jdec.Decoder Tracks
tracks =
    Jdec.succeed Tracks
        |> Jpipe.required "href" Jdec.string
        |> Jpipe.required "items" (Jdec.list item )
        |> Jpipe.required "limit" Jdec.int
        |> Jpipe.required "next" (Jdec.null ())
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "previous" (Jdec.null ())
        |> Jpipe.required "total" Jdec.int

encodeTracks : Tracks -> Jenc.Value
encodeTracks x =
    Jenc.object
        [ ("href", Jenc.string x.href)
        , ("items", Jenc.list encodeItem x.items)
        , ("limit", Jenc.int x.limit)
        , ("next", always Jenc.null x.next)
        , ("offset", Jenc.int x.offset)
        , ("previous", always Jenc.null x.previous)
        , ("total", Jenc.int x.total)
        ]

item : Jdec.Decoder Item
item =
    Jdec.succeed Item
        |> Jpipe.required "artists" (Jdec.list artist )
        |> Jpipe.required "available_markets" (Jdec.list Jdec.string )
        |> Jpipe.required "disc_number" Jdec.int
        |> Jpipe.required "duration_ms" Jdec.int
        |> Jpipe.required "explicit" Jdec.bool
        |> Jpipe.required "external_urls" externalUrls
        |> Jpipe.required "href" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "preview_url" Jdec.string
        |> Jpipe.required "track_number" Jdec.int
        |> Jpipe.required "uri" Jdec.string

encodeItem : Item -> Jenc.Value
encodeItem x =
    Jenc.object
        [ ("artists", Jenc.list encodeArtist x.artists)
        , ("available_markets", Jenc.list Jenc.string x.availableMarkets)
        , ("disc_number", Jenc.int x.discNumber)
        , ("duration_ms", Jenc.int x.durationMS)
        , ("explicit", Jenc.bool x.explicit)
        , ("external_urls", encodeExternalUrls x.externalUrls)
        , ("href", Jenc.string x.href)
        , ("id", Jenc.string x.id)
        , ("type", Jenc.string x.itemType)
        , ("name", Jenc.string x.name)
        , ("preview_url", Jenc.string x.previewURL)
        , ("track_number", Jenc.int x.trackNumber)
        , ("uri", Jenc.string x.uri)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
