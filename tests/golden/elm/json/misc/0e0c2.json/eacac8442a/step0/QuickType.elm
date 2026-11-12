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
    , Result
    , Collection
    , Detail
    , FavMovie
    , Image
    , Video
    , VoteScore
    , DetailLanguage(..)
    , Type(..)
    , ResultLanguage(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { count : Int
    , next : String
    , previous : ()
    , results : List Result
    }

type alias Result =
    { activeScreens : Int
    , collections : List Collection
    , details : List Detail
    , duration : Int
    , favMovie : FavMovie
    , id : Int
    , images : List Image
    , language : ResultLanguage
    , releaseDate : String
    , stars : Int
    , tags : Maybe (List Jdec.Value)
    , title : String
    , videos : List Video
    , voteScore : VoteScore
    , watches : Int
    }

type alias Collection =
    { id : Int
    , movies : List Int
    , name : String
    , slug : String
    }

type alias Detail =
    { cast : String
    , director : String
    , id : Int
    , language : DetailLanguage
    , storyline : String
    , tagline : String
    , title : String
    }

type DetailLanguage
    = PurpleEn
    | Th

type alias FavMovie =
    { follow : Bool
    , star : Bool
    , watched : Bool
    }

type alias Image =
    { favs : Int
    , id : Int
    , imageType : Type
    , thumbnail : String
    , url : String
    }

type Type
    = Poster
    | Backdrop

type ResultLanguage
    = FluffyEn
    | Empty

type alias Video =
    { kind : String
    , language : ResultLanguage
    , source : String
    , url : String
    }

type alias VoteScore =
    { avg : Int
    , score : Int
    , total : Int
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
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "next" Jdec.string
        |> Jpipe.required "previous" (Jdec.null ())
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("next", Jenc.string x.next)
        , ("previous", always Jenc.null x.previous)
        , ("results", Jenc.list encodeResult x.results)
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "active_screens" Jdec.int
        |> Jpipe.required "collections" (Jdec.list collection )
        |> Jpipe.required "details" (Jdec.list detail )
        |> Jpipe.required "duration" Jdec.int
        |> Jpipe.required "fav_movie" favMovie
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "images" (Jdec.list image )
        |> Jpipe.required "language" resultLanguage
        |> Jpipe.required "release_date" Jdec.string
        |> Jpipe.required "stars" Jdec.int
        |> Jpipe.required "tags" (Jdec.nullable (Jdec.list Jdec.value ))
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "videos" (Jdec.list video )
        |> Jpipe.required "vote_score" voteScore
        |> Jpipe.required "watches" Jdec.int

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("active_screens", Jenc.int x.activeScreens)
        , ("collections", Jenc.list encodeCollection x.collections)
        , ("details", Jenc.list encodeDetail x.details)
        , ("duration", Jenc.int x.duration)
        , ("fav_movie", encodeFavMovie x.favMovie)
        , ("id", Jenc.int x.id)
        , ("images", Jenc.list encodeImage x.images)
        , ("language", encodeResultLanguage x.language)
        , ("release_date", Jenc.string x.releaseDate)
        , ("stars", Jenc.int x.stars)
        , ("tags", makeNullableEncoder (Jenc.list identity) x.tags)
        , ("title", Jenc.string x.title)
        , ("videos", Jenc.list encodeVideo x.videos)
        , ("vote_score", encodeVoteScore x.voteScore)
        , ("watches", Jenc.int x.watches)
        ]

collection : Jdec.Decoder Collection
collection =
    Jdec.succeed Collection
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "movies" (Jdec.list Jdec.int )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "slug" Jdec.string

encodeCollection : Collection -> Jenc.Value
encodeCollection x =
    Jenc.object
        [ ("id", Jenc.int x.id)
        , ("movies", Jenc.list Jenc.int x.movies)
        , ("name", Jenc.string x.name)
        , ("slug", Jenc.string x.slug)
        ]

detail : Jdec.Decoder Detail
detail =
    Jdec.succeed Detail
        |> Jpipe.required "cast" Jdec.string
        |> Jpipe.required "director" Jdec.string
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "language" detailLanguage
        |> Jpipe.required "storyline" Jdec.string
        |> Jpipe.required "tagline" Jdec.string
        |> Jpipe.required "title" Jdec.string

encodeDetail : Detail -> Jenc.Value
encodeDetail x =
    Jenc.object
        [ ("cast", Jenc.string x.cast)
        , ("director", Jenc.string x.director)
        , ("id", Jenc.int x.id)
        , ("language", encodeDetailLanguage x.language)
        , ("storyline", Jenc.string x.storyline)
        , ("tagline", Jenc.string x.tagline)
        , ("title", Jenc.string x.title)
        ]

detailLanguage : Jdec.Decoder DetailLanguage
detailLanguage =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "en" -> Jdec.succeed PurpleEn
                "th" -> Jdec.succeed Th
                somethingElse -> Jdec.fail <| "Invalid DetailLanguage: " ++ somethingElse
        )

encodeDetailLanguage : DetailLanguage -> Jenc.Value
encodeDetailLanguage x = case x of
    PurpleEn -> Jenc.string "en"
    Th -> Jenc.string "th"

favMovie : Jdec.Decoder FavMovie
favMovie =
    Jdec.succeed FavMovie
        |> Jpipe.required "follow" Jdec.bool
        |> Jpipe.required "star" Jdec.bool
        |> Jpipe.required "watched" Jdec.bool

encodeFavMovie : FavMovie -> Jenc.Value
encodeFavMovie x =
    Jenc.object
        [ ("follow", Jenc.bool x.follow)
        , ("star", Jenc.bool x.star)
        , ("watched", Jenc.bool x.watched)
        ]

image : Jdec.Decoder Image
image =
    Jdec.succeed Image
        |> Jpipe.required "favs" Jdec.int
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "type" purpleType
        |> Jpipe.required "thumbnail" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeImage : Image -> Jenc.Value
encodeImage x =
    Jenc.object
        [ ("favs", Jenc.int x.favs)
        , ("id", Jenc.int x.id)
        , ("type", encodeType x.imageType)
        , ("thumbnail", Jenc.string x.thumbnail)
        , ("url", Jenc.string x.url)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Poster" -> Jdec.succeed Poster
                "Backdrop" -> Jdec.succeed Backdrop
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Poster -> Jenc.string "Poster"
    Backdrop -> Jenc.string "Backdrop"

resultLanguage : Jdec.Decoder ResultLanguage
resultLanguage =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "en" -> Jdec.succeed FluffyEn
                "-" -> Jdec.succeed Empty
                somethingElse -> Jdec.fail <| "Invalid ResultLanguage: " ++ somethingElse
        )

encodeResultLanguage : ResultLanguage -> Jenc.Value
encodeResultLanguage x = case x of
    FluffyEn -> Jenc.string "en"
    Empty -> Jenc.string "-"

video : Jdec.Decoder Video
video =
    Jdec.succeed Video
        |> Jpipe.required "kind" Jdec.string
        |> Jpipe.required "language" resultLanguage
        |> Jpipe.required "source" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeVideo : Video -> Jenc.Value
encodeVideo x =
    Jenc.object
        [ ("kind", Jenc.string x.kind)
        , ("language", encodeResultLanguage x.language)
        , ("source", Jenc.string x.source)
        , ("url", Jenc.string x.url)
        ]

voteScore : Jdec.Decoder VoteScore
voteScore =
    Jdec.succeed VoteScore
        |> Jpipe.required "avg" Jdec.int
        |> Jpipe.required "score" Jdec.int
        |> Jpipe.required "total" Jdec.int

encodeVoteScore : VoteScore -> Jenc.Value
encodeVoteScore x =
    Jenc.object
        [ ("avg", Jenc.int x.avg)
        , ("score", Jenc.int x.score)
        , ("total", Jenc.int x.total)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
