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
    , Datum
    , Images
    , Downsized
    , DownsizedSmall
    , FixedHeight
    , Looping
    , User
    , Meta
    , Pagination
    , Type(..)
    , Rating(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { data : List Datum
    , meta : Meta
    , pagination : Pagination
    }

type alias Datum =
    { bitlyGIFURL : String
    , bitlyURL : String
    , contentURL : String
    , datumType : Type
    , embedURL : String
    , id : String
    , images : Images
    , importDatetime : String
    , isIndexable : Int
    , rating : Rating
    , slug : String
    , source : String
    , sourcePostURL : String
    , sourceTLD : String
    , trendingDatetime : String
    , url : String
    , user : Maybe User
    , username : String
    }

type Type
    = GIF

type alias Images =
    { downsized : Downsized
    , downsizedLarge : Downsized
    , downsizedMedium : Downsized
    , downsizedSmall : DownsizedSmall
    , downsizedStill : Downsized
    , fixedHeight : FixedHeight
    , fixedHeightDownsampled : FixedHeight
    , fixedHeightSmall : FixedHeight
    , fixedHeightSmallStill : Downsized
    , fixedHeightStill : Downsized
    , fixedWidth : FixedHeight
    , fixedWidthDownsampled : FixedHeight
    , fixedWidthSmall : FixedHeight
    , fixedWidthSmallStill : Downsized
    , fixedWidthStill : Downsized
    , looping : Looping
    , original : FixedHeight
    , originalMp4 : DownsizedSmall
    , originalStill : Downsized
    , preview : DownsizedSmall
    , previewGIF : Downsized
    , previewWebp : Downsized
    }

type alias Downsized =
    { height : String
    , size : Maybe String
    , url : String
    , width : String
    }

type alias DownsizedSmall =
    { height : String
    , mp4 : String
    , mp4Size : String
    , width : String
    }

type alias FixedHeight =
    { frames : Maybe String
    , height : String
    , mp4 : Maybe String
    , mp4Size : Maybe String
    , size : String
    , url : String
    , webp : String
    , webpSize : String
    , width : String
    }

type alias Looping =
    { mp4 : String
    , mp4Size : String
    }

type Rating
    = G
    | PG
    | Y
    | PG13

type alias User =
    { avatarURL : String
    , bannerURL : String
    , displayName : String
    , profileURL : String
    , twitter : String
    , username : String
    }

type alias Meta =
    { msg : String
    , responseID : String
    , status : Int
    }

type alias Pagination =
    { count : Int
    , offset : Int
    , totalCount : Int
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
        |> Jpipe.required "data" (Jdec.list datum )
        |> Jpipe.required "meta" meta
        |> Jpipe.required "pagination" pagination

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("data", Jenc.list encodeDatum x.data)
        , ("meta", encodeMeta x.meta)
        , ("pagination", encodePagination x.pagination)
        ]

datum : Jdec.Decoder Datum
datum =
    Jdec.succeed Datum
        |> Jpipe.required "bitly_gif_url" Jdec.string
        |> Jpipe.required "bitly_url" Jdec.string
        |> Jpipe.required "content_url" Jdec.string
        |> Jpipe.required "type" purpleType
        |> Jpipe.required "embed_url" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "images" images
        |> Jpipe.required "import_datetime" Jdec.string
        |> Jpipe.required "is_indexable" Jdec.int
        |> Jpipe.required "rating" rating
        |> Jpipe.required "slug" Jdec.string
        |> Jpipe.required "source" Jdec.string
        |> Jpipe.required "source_post_url" Jdec.string
        |> Jpipe.required "source_tld" Jdec.string
        |> Jpipe.required "trending_datetime" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.custom (optionalField "user" (Jdec.map Just user) Nothing)
        |> Jpipe.required "username" Jdec.string

encodeDatum : Datum -> Jenc.Value
encodeDatum x =
    Jenc.object
        [ ("bitly_gif_url", Jenc.string x.bitlyGIFURL)
        , ("bitly_url", Jenc.string x.bitlyURL)
        , ("content_url", Jenc.string x.contentURL)
        , ("type", encodeType x.datumType)
        , ("embed_url", Jenc.string x.embedURL)
        , ("id", Jenc.string x.id)
        , ("images", encodeImages x.images)
        , ("import_datetime", Jenc.string x.importDatetime)
        , ("is_indexable", Jenc.int x.isIndexable)
        , ("rating", encodeRating x.rating)
        , ("slug", Jenc.string x.slug)
        , ("source", Jenc.string x.source)
        , ("source_post_url", Jenc.string x.sourcePostURL)
        , ("source_tld", Jenc.string x.sourceTLD)
        , ("trending_datetime", Jenc.string x.trendingDatetime)
        , ("url", Jenc.string x.url)
        , ("user", makeNullableEncoder encodeUser x.user)
        , ("username", Jenc.string x.username)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "gif" -> Jdec.succeed GIF
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    GIF -> Jenc.string "gif"

images : Jdec.Decoder Images
images =
    Jdec.succeed Images
        |> Jpipe.required "downsized" downsized
        |> Jpipe.required "downsized_large" downsized
        |> Jpipe.required "downsized_medium" downsized
        |> Jpipe.required "downsized_small" downsizedSmall
        |> Jpipe.required "downsized_still" downsized
        |> Jpipe.required "fixed_height" fixedHeight
        |> Jpipe.required "fixed_height_downsampled" fixedHeight
        |> Jpipe.required "fixed_height_small" fixedHeight
        |> Jpipe.required "fixed_height_small_still" downsized
        |> Jpipe.required "fixed_height_still" downsized
        |> Jpipe.required "fixed_width" fixedHeight
        |> Jpipe.required "fixed_width_downsampled" fixedHeight
        |> Jpipe.required "fixed_width_small" fixedHeight
        |> Jpipe.required "fixed_width_small_still" downsized
        |> Jpipe.required "fixed_width_still" downsized
        |> Jpipe.required "looping" looping
        |> Jpipe.required "original" fixedHeight
        |> Jpipe.required "original_mp4" downsizedSmall
        |> Jpipe.required "original_still" downsized
        |> Jpipe.required "preview" downsizedSmall
        |> Jpipe.required "preview_gif" downsized
        |> Jpipe.required "preview_webp" downsized

encodeImages : Images -> Jenc.Value
encodeImages x =
    Jenc.object
        [ ("downsized", encodeDownsized x.downsized)
        , ("downsized_large", encodeDownsized x.downsizedLarge)
        , ("downsized_medium", encodeDownsized x.downsizedMedium)
        , ("downsized_small", encodeDownsizedSmall x.downsizedSmall)
        , ("downsized_still", encodeDownsized x.downsizedStill)
        , ("fixed_height", encodeFixedHeight x.fixedHeight)
        , ("fixed_height_downsampled", encodeFixedHeight x.fixedHeightDownsampled)
        , ("fixed_height_small", encodeFixedHeight x.fixedHeightSmall)
        , ("fixed_height_small_still", encodeDownsized x.fixedHeightSmallStill)
        , ("fixed_height_still", encodeDownsized x.fixedHeightStill)
        , ("fixed_width", encodeFixedHeight x.fixedWidth)
        , ("fixed_width_downsampled", encodeFixedHeight x.fixedWidthDownsampled)
        , ("fixed_width_small", encodeFixedHeight x.fixedWidthSmall)
        , ("fixed_width_small_still", encodeDownsized x.fixedWidthSmallStill)
        , ("fixed_width_still", encodeDownsized x.fixedWidthStill)
        , ("looping", encodeLooping x.looping)
        , ("original", encodeFixedHeight x.original)
        , ("original_mp4", encodeDownsizedSmall x.originalMp4)
        , ("original_still", encodeDownsized x.originalStill)
        , ("preview", encodeDownsizedSmall x.preview)
        , ("preview_gif", encodeDownsized x.previewGIF)
        , ("preview_webp", encodeDownsized x.previewWebp)
        ]

downsized : Jdec.Decoder Downsized
downsized =
    Jdec.succeed Downsized
        |> Jpipe.required "height" Jdec.string
        |> Jpipe.custom (optionalField "size" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "width" Jdec.string

encodeDownsized : Downsized -> Jenc.Value
encodeDownsized x =
    Jenc.object
        [ ("height", Jenc.string x.height)
        , ("size", makeNullableEncoder Jenc.string x.size)
        , ("url", Jenc.string x.url)
        , ("width", Jenc.string x.width)
        ]

downsizedSmall : Jdec.Decoder DownsizedSmall
downsizedSmall =
    Jdec.succeed DownsizedSmall
        |> Jpipe.required "height" Jdec.string
        |> Jpipe.required "mp4" Jdec.string
        |> Jpipe.required "mp4_size" Jdec.string
        |> Jpipe.required "width" Jdec.string

encodeDownsizedSmall : DownsizedSmall -> Jenc.Value
encodeDownsizedSmall x =
    Jenc.object
        [ ("height", Jenc.string x.height)
        , ("mp4", Jenc.string x.mp4)
        , ("mp4_size", Jenc.string x.mp4Size)
        , ("width", Jenc.string x.width)
        ]

fixedHeight : Jdec.Decoder FixedHeight
fixedHeight =
    Jdec.succeed FixedHeight
        |> Jpipe.custom (optionalField "frames" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "height" Jdec.string
        |> Jpipe.custom (optionalField "mp4" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "mp4_size" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "size" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "webp" Jdec.string
        |> Jpipe.required "webp_size" Jdec.string
        |> Jpipe.required "width" Jdec.string

encodeFixedHeight : FixedHeight -> Jenc.Value
encodeFixedHeight x =
    Jenc.object
        [ ("frames", makeNullableEncoder Jenc.string x.frames)
        , ("height", Jenc.string x.height)
        , ("mp4", makeNullableEncoder Jenc.string x.mp4)
        , ("mp4_size", makeNullableEncoder Jenc.string x.mp4Size)
        , ("size", Jenc.string x.size)
        , ("url", Jenc.string x.url)
        , ("webp", Jenc.string x.webp)
        , ("webp_size", Jenc.string x.webpSize)
        , ("width", Jenc.string x.width)
        ]

looping : Jdec.Decoder Looping
looping =
    Jdec.succeed Looping
        |> Jpipe.required "mp4" Jdec.string
        |> Jpipe.required "mp4_size" Jdec.string

encodeLooping : Looping -> Jenc.Value
encodeLooping x =
    Jenc.object
        [ ("mp4", Jenc.string x.mp4)
        , ("mp4_size", Jenc.string x.mp4Size)
        ]

rating : Jdec.Decoder Rating
rating =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "g" -> Jdec.succeed G
                "pg" -> Jdec.succeed PG
                "y" -> Jdec.succeed Y
                "pg-13" -> Jdec.succeed PG13
                somethingElse -> Jdec.fail <| "Invalid Rating: " ++ somethingElse
        )

encodeRating : Rating -> Jenc.Value
encodeRating x = case x of
    G -> Jenc.string "g"
    PG -> Jenc.string "pg"
    Y -> Jenc.string "y"
    PG13 -> Jenc.string "pg-13"

user : Jdec.Decoder User
user =
    Jdec.succeed User
        |> Jpipe.required "avatar_url" Jdec.string
        |> Jpipe.required "banner_url" Jdec.string
        |> Jpipe.required "display_name" Jdec.string
        |> Jpipe.required "profile_url" Jdec.string
        |> Jpipe.required "twitter" Jdec.string
        |> Jpipe.required "username" Jdec.string

encodeUser : User -> Jenc.Value
encodeUser x =
    Jenc.object
        [ ("avatar_url", Jenc.string x.avatarURL)
        , ("banner_url", Jenc.string x.bannerURL)
        , ("display_name", Jenc.string x.displayName)
        , ("profile_url", Jenc.string x.profileURL)
        , ("twitter", Jenc.string x.twitter)
        , ("username", Jenc.string x.username)
        ]

meta : Jdec.Decoder Meta
meta =
    Jdec.succeed Meta
        |> Jpipe.required "msg" Jdec.string
        |> Jpipe.required "response_id" Jdec.string
        |> Jpipe.required "status" Jdec.int

encodeMeta : Meta -> Jenc.Value
encodeMeta x =
    Jenc.object
        [ ("msg", Jenc.string x.msg)
        , ("response_id", Jenc.string x.responseID)
        , ("status", Jenc.int x.status)
        ]

pagination : Jdec.Decoder Pagination
pagination =
    Jdec.succeed Pagination
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "total_count" Jdec.int

encodePagination : Pagination -> Jenc.Value
encodePagination x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("offset", Jenc.int x.offset)
        , ("total_count", Jenc.int x.totalCount)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
