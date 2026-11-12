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
    , QuickTypeData
    , Child
    , ChildData
    , MediaEmbed
    , Preview
    , ImageElement
    , Source
    , Variants
    , GIF
    , Distinguished(..)
    , Domain(..)
    , PostHint(..)
    , Subreddit(..)
    , SubredditID(..)
    , SubredditNamePrefixed(..)
    , SubredditType(..)
    , Kind(..)
    , Edited(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { data : QuickTypeData
    , kind : String
    }

type alias QuickTypeData =
    { after : String
    , before : ()
    , children : List Child
    , modhash : String
    }

type alias Child =
    { data : ChildData
    , kind : Kind
    }

type alias ChildData =
    { approvedAtUTC : ()
    , approvedBy : ()
    , archived : Bool
    , author : String
    , authorFlairCSSClass : ()
    , authorFlairText : ()
    , bannedAtUTC : ()
    , bannedBy : ()
    , brandSafe : Bool
    , canGild : Bool
    , canModPost : Bool
    , clicked : Bool
    , contestMode : Bool
    , created : Float
    , createdUTC : Float
    , distinguished : Distinguished
    , domain : Domain
    , downs : Int
    , edited : Edited
    , gilded : Int
    , hidden : Bool
    , hideScore : Bool
    , id : String
    , isSelf : Bool
    , isVideo : Bool
    , likes : ()
    , linkFlairCSSClass : ()
    , linkFlairText : ()
    , locked : Bool
    , media : ()
    , mediaEmbed : MediaEmbed
    , modReports : List Jdec.Value
    , name : String
    , numComments : Int
    , numReports : ()
    , over18 : Bool
    , permalink : String
    , postHint : Maybe PostHint
    , preview : Maybe Preview
    , quarantine : Bool
    , removalReason : ()
    , reportReasons : ()
    , saved : Bool
    , score : Int
    , secureMedia : ()
    , secureMediaEmbed : MediaEmbed
    , selftext : String
    , selftextHTML : Maybe String
    , spoiler : Bool
    , stickied : Bool
    , subreddit : Subreddit
    , subredditID : SubredditID
    , subredditNamePrefixed : SubredditNamePrefixed
    , subredditType : SubredditType
    , suggestedSort : Maybe String
    , thumbnail : String
    , thumbnailHeight : Maybe Int
    , thumbnailWidth : Maybe Int
    , title : String
    , ups : Int
    , url : String
    , userReports : List Jdec.Value
    , viewCount : ()
    , visited : Bool
    }

type Distinguished
    = Admin

type Domain
    = SelfAnnouncements
    | IReddIt

type Edited
    = BoolInEdited Bool
    | DoubleInEdited Float

type alias MediaEmbed =
    {
    }

type PostHint
    = Self
    | Image

type alias Preview =
    { enabled : Bool
    , images : List ImageElement
    }

type alias ImageElement =
    { id : String
    , resolutions : List Source
    , source : Source
    , variants : Variants
    }

type alias Source =
    { height : Int
    , url : String
    , width : Int
    }

type alias Variants =
    { gif : Maybe GIF
    , mp4 : Maybe GIF
    }

type alias GIF =
    { resolutions : List Source
    , source : Source
    }

type Subreddit
    = Announcements

type SubredditID
    = T52R0Ij

type SubredditNamePrefixed
    = RAnnouncements

type SubredditType
    = Restricted

type Kind
    = T3

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
        |> Jpipe.required "data" quickTypeData
        |> Jpipe.required "kind" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("data", encodeQuickTypeData x.data)
        , ("kind", Jenc.string x.kind)
        ]

quickTypeData : Jdec.Decoder QuickTypeData
quickTypeData =
    Jdec.succeed QuickTypeData
        |> Jpipe.required "after" Jdec.string
        |> Jpipe.required "before" (Jdec.null ())
        |> Jpipe.required "children" (Jdec.list child )
        |> Jpipe.required "modhash" Jdec.string

encodeQuickTypeData : QuickTypeData -> Jenc.Value
encodeQuickTypeData x =
    Jenc.object
        [ ("after", Jenc.string x.after)
        , ("before", always Jenc.null x.before)
        , ("children", Jenc.list encodeChild x.children)
        , ("modhash", Jenc.string x.modhash)
        ]

child : Jdec.Decoder Child
child =
    Jdec.succeed Child
        |> Jpipe.required "data" childData
        |> Jpipe.required "kind" kind

encodeChild : Child -> Jenc.Value
encodeChild x =
    Jenc.object
        [ ("data", encodeChildData x.data)
        , ("kind", encodeKind x.kind)
        ]

childData : Jdec.Decoder ChildData
childData =
    Jdec.succeed ChildData
        |> Jpipe.required "approved_at_utc" (Jdec.null ())
        |> Jpipe.required "approved_by" (Jdec.null ())
        |> Jpipe.required "archived" Jdec.bool
        |> Jpipe.required "author" Jdec.string
        |> Jpipe.required "author_flair_css_class" (Jdec.null ())
        |> Jpipe.required "author_flair_text" (Jdec.null ())
        |> Jpipe.required "banned_at_utc" (Jdec.null ())
        |> Jpipe.required "banned_by" (Jdec.null ())
        |> Jpipe.required "brand_safe" Jdec.bool
        |> Jpipe.required "can_gild" Jdec.bool
        |> Jpipe.required "can_mod_post" Jdec.bool
        |> Jpipe.required "clicked" Jdec.bool
        |> Jpipe.required "contest_mode" Jdec.bool
        |> Jpipe.required "created" Jdec.float
        |> Jpipe.required "created_utc" Jdec.float
        |> Jpipe.required "distinguished" distinguished
        |> Jpipe.required "domain" domain
        |> Jpipe.required "downs" Jdec.int
        |> Jpipe.required "edited" edited
        |> Jpipe.required "gilded" Jdec.int
        |> Jpipe.required "hidden" Jdec.bool
        |> Jpipe.required "hide_score" Jdec.bool
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "is_self" Jdec.bool
        |> Jpipe.required "is_video" Jdec.bool
        |> Jpipe.required "likes" (Jdec.null ())
        |> Jpipe.required "link_flair_css_class" (Jdec.null ())
        |> Jpipe.required "link_flair_text" (Jdec.null ())
        |> Jpipe.required "locked" Jdec.bool
        |> Jpipe.required "media" (Jdec.null ())
        |> Jpipe.required "media_embed" mediaEmbed
        |> Jpipe.required "mod_reports" (Jdec.list Jdec.value )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "num_comments" Jdec.int
        |> Jpipe.required "num_reports" (Jdec.null ())
        |> Jpipe.required "over_18" Jdec.bool
        |> Jpipe.required "permalink" Jdec.string
        |> Jpipe.custom (optionalField "post_hint" (Jdec.map Just postHint) Nothing)
        |> Jpipe.custom (optionalField "preview" (Jdec.map Just preview) Nothing)
        |> Jpipe.required "quarantine" Jdec.bool
        |> Jpipe.required "removal_reason" (Jdec.null ())
        |> Jpipe.required "report_reasons" (Jdec.null ())
        |> Jpipe.required "saved" Jdec.bool
        |> Jpipe.required "score" Jdec.int
        |> Jpipe.required "secure_media" (Jdec.null ())
        |> Jpipe.required "secure_media_embed" mediaEmbed
        |> Jpipe.required "selftext" Jdec.string
        |> Jpipe.required "selftext_html" (Jdec.nullable Jdec.string)
        |> Jpipe.required "spoiler" Jdec.bool
        |> Jpipe.required "stickied" Jdec.bool
        |> Jpipe.required "subreddit" subreddit
        |> Jpipe.required "subreddit_id" subredditID
        |> Jpipe.required "subreddit_name_prefixed" subredditNamePrefixed
        |> Jpipe.required "subreddit_type" subredditType
        |> Jpipe.required "suggested_sort" (Jdec.nullable Jdec.string)
        |> Jpipe.required "thumbnail" Jdec.string
        |> Jpipe.required "thumbnail_height" (Jdec.nullable Jdec.int)
        |> Jpipe.required "thumbnail_width" (Jdec.nullable Jdec.int)
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "ups" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "user_reports" (Jdec.list Jdec.value )
        |> Jpipe.required "view_count" (Jdec.null ())
        |> Jpipe.required "visited" Jdec.bool

encodeChildData : ChildData -> Jenc.Value
encodeChildData x =
    Jenc.object
        [ ("approved_at_utc", always Jenc.null x.approvedAtUTC)
        , ("approved_by", always Jenc.null x.approvedBy)
        , ("archived", Jenc.bool x.archived)
        , ("author", Jenc.string x.author)
        , ("author_flair_css_class", always Jenc.null x.authorFlairCSSClass)
        , ("author_flair_text", always Jenc.null x.authorFlairText)
        , ("banned_at_utc", always Jenc.null x.bannedAtUTC)
        , ("banned_by", always Jenc.null x.bannedBy)
        , ("brand_safe", Jenc.bool x.brandSafe)
        , ("can_gild", Jenc.bool x.canGild)
        , ("can_mod_post", Jenc.bool x.canModPost)
        , ("clicked", Jenc.bool x.clicked)
        , ("contest_mode", Jenc.bool x.contestMode)
        , ("created", Jenc.float x.created)
        , ("created_utc", Jenc.float x.createdUTC)
        , ("distinguished", encodeDistinguished x.distinguished)
        , ("domain", encodeDomain x.domain)
        , ("downs", Jenc.int x.downs)
        , ("edited", encodeEdited x.edited)
        , ("gilded", Jenc.int x.gilded)
        , ("hidden", Jenc.bool x.hidden)
        , ("hide_score", Jenc.bool x.hideScore)
        , ("id", Jenc.string x.id)
        , ("is_self", Jenc.bool x.isSelf)
        , ("is_video", Jenc.bool x.isVideo)
        , ("likes", always Jenc.null x.likes)
        , ("link_flair_css_class", always Jenc.null x.linkFlairCSSClass)
        , ("link_flair_text", always Jenc.null x.linkFlairText)
        , ("locked", Jenc.bool x.locked)
        , ("media", always Jenc.null x.media)
        , ("media_embed", encodeMediaEmbed x.mediaEmbed)
        , ("mod_reports", Jenc.list identity x.modReports)
        , ("name", Jenc.string x.name)
        , ("num_comments", Jenc.int x.numComments)
        , ("num_reports", always Jenc.null x.numReports)
        , ("over_18", Jenc.bool x.over18)
        , ("permalink", Jenc.string x.permalink)
        , ("post_hint", makeNullableEncoder encodePostHint x.postHint)
        , ("preview", makeNullableEncoder encodePreview x.preview)
        , ("quarantine", Jenc.bool x.quarantine)
        , ("removal_reason", always Jenc.null x.removalReason)
        , ("report_reasons", always Jenc.null x.reportReasons)
        , ("saved", Jenc.bool x.saved)
        , ("score", Jenc.int x.score)
        , ("secure_media", always Jenc.null x.secureMedia)
        , ("secure_media_embed", encodeMediaEmbed x.secureMediaEmbed)
        , ("selftext", Jenc.string x.selftext)
        , ("selftext_html", makeNullableEncoder Jenc.string x.selftextHTML)
        , ("spoiler", Jenc.bool x.spoiler)
        , ("stickied", Jenc.bool x.stickied)
        , ("subreddit", encodeSubreddit x.subreddit)
        , ("subreddit_id", encodeSubredditID x.subredditID)
        , ("subreddit_name_prefixed", encodeSubredditNamePrefixed x.subredditNamePrefixed)
        , ("subreddit_type", encodeSubredditType x.subredditType)
        , ("suggested_sort", makeNullableEncoder Jenc.string x.suggestedSort)
        , ("thumbnail", Jenc.string x.thumbnail)
        , ("thumbnail_height", makeNullableEncoder Jenc.int x.thumbnailHeight)
        , ("thumbnail_width", makeNullableEncoder Jenc.int x.thumbnailWidth)
        , ("title", Jenc.string x.title)
        , ("ups", Jenc.int x.ups)
        , ("url", Jenc.string x.url)
        , ("user_reports", Jenc.list identity x.userReports)
        , ("view_count", always Jenc.null x.viewCount)
        , ("visited", Jenc.bool x.visited)
        ]

distinguished : Jdec.Decoder Distinguished
distinguished =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "admin" -> Jdec.succeed Admin
                somethingElse -> Jdec.fail <| "Invalid Distinguished: " ++ somethingElse
        )

encodeDistinguished : Distinguished -> Jenc.Value
encodeDistinguished x = case x of
    Admin -> Jenc.string "admin"

domain : Jdec.Decoder Domain
domain =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "self.announcements" -> Jdec.succeed SelfAnnouncements
                "i.redd.it" -> Jdec.succeed IReddIt
                somethingElse -> Jdec.fail <| "Invalid Domain: " ++ somethingElse
        )

encodeDomain : Domain -> Jenc.Value
encodeDomain x = case x of
    SelfAnnouncements -> Jenc.string "self.announcements"
    IReddIt -> Jenc.string "i.redd.it"

edited : Jdec.Decoder Edited
edited =
    Jdec.oneOf
        [ Jdec.map BoolInEdited Jdec.bool
        , Jdec.map DoubleInEdited Jdec.float
        ]

encodeEdited : Edited -> Jenc.Value
encodeEdited x = case x of
    BoolInEdited y -> Jenc.bool y
    DoubleInEdited y -> Jenc.float y

mediaEmbed : Jdec.Decoder MediaEmbed
mediaEmbed =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> MediaEmbed)

encodeMediaEmbed : MediaEmbed -> Jenc.Value
encodeMediaEmbed x =
    Jenc.object
        [
        ]

postHint : Jdec.Decoder PostHint
postHint =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "self" -> Jdec.succeed Self
                "image" -> Jdec.succeed Image
                somethingElse -> Jdec.fail <| "Invalid PostHint: " ++ somethingElse
        )

encodePostHint : PostHint -> Jenc.Value
encodePostHint x = case x of
    Self -> Jenc.string "self"
    Image -> Jenc.string "image"

preview : Jdec.Decoder Preview
preview =
    Jdec.succeed Preview
        |> Jpipe.required "enabled" Jdec.bool
        |> Jpipe.required "images" (Jdec.list imageElement )

encodePreview : Preview -> Jenc.Value
encodePreview x =
    Jenc.object
        [ ("enabled", Jenc.bool x.enabled)
        , ("images", Jenc.list encodeImageElement x.images)
        ]

imageElement : Jdec.Decoder ImageElement
imageElement =
    Jdec.succeed ImageElement
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "resolutions" (Jdec.list source )
        |> Jpipe.required "source" source
        |> Jpipe.required "variants" variants

encodeImageElement : ImageElement -> Jenc.Value
encodeImageElement x =
    Jenc.object
        [ ("id", Jenc.string x.id)
        , ("resolutions", Jenc.list encodeSource x.resolutions)
        , ("source", encodeSource x.source)
        , ("variants", encodeVariants x.variants)
        ]

source : Jdec.Decoder Source
source =
    Jdec.succeed Source
        |> Jpipe.required "height" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "width" Jdec.int

encodeSource : Source -> Jenc.Value
encodeSource x =
    Jenc.object
        [ ("height", Jenc.int x.height)
        , ("url", Jenc.string x.url)
        , ("width", Jenc.int x.width)
        ]

variants : Jdec.Decoder Variants
variants =
    Jdec.succeed Variants
        |> Jpipe.custom (optionalField "gif" (Jdec.map Just gif) Nothing)
        |> Jpipe.custom (optionalField "mp4" (Jdec.map Just gif) Nothing)

encodeVariants : Variants -> Jenc.Value
encodeVariants x =
    Jenc.object
        [ ("gif", makeNullableEncoder encodeGIF x.gif)
        , ("mp4", makeNullableEncoder encodeGIF x.mp4)
        ]

gif : Jdec.Decoder GIF
gif =
    Jdec.succeed GIF
        |> Jpipe.required "resolutions" (Jdec.list source )
        |> Jpipe.required "source" source

encodeGIF : GIF -> Jenc.Value
encodeGIF x =
    Jenc.object
        [ ("resolutions", Jenc.list encodeSource x.resolutions)
        , ("source", encodeSource x.source)
        ]

subreddit : Jdec.Decoder Subreddit
subreddit =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "announcements" -> Jdec.succeed Announcements
                somethingElse -> Jdec.fail <| "Invalid Subreddit: " ++ somethingElse
        )

encodeSubreddit : Subreddit -> Jenc.Value
encodeSubreddit x = case x of
    Announcements -> Jenc.string "announcements"

subredditID : Jdec.Decoder SubredditID
subredditID =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "t5_2r0ij" -> Jdec.succeed T52R0Ij
                somethingElse -> Jdec.fail <| "Invalid SubredditID: " ++ somethingElse
        )

encodeSubredditID : SubredditID -> Jenc.Value
encodeSubredditID x = case x of
    T52R0Ij -> Jenc.string "t5_2r0ij"

subredditNamePrefixed : Jdec.Decoder SubredditNamePrefixed
subredditNamePrefixed =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "r/announcements" -> Jdec.succeed RAnnouncements
                somethingElse -> Jdec.fail <| "Invalid SubredditNamePrefixed: " ++ somethingElse
        )

encodeSubredditNamePrefixed : SubredditNamePrefixed -> Jenc.Value
encodeSubredditNamePrefixed x = case x of
    RAnnouncements -> Jenc.string "r/announcements"

subredditType : Jdec.Decoder SubredditType
subredditType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "restricted" -> Jdec.succeed Restricted
                somethingElse -> Jdec.fail <| "Invalid SubredditType: " ++ somethingElse
        )

encodeSubredditType : SubredditType -> Jenc.Value
encodeSubredditType x = case x of
    Restricted -> Jenc.string "restricted"

kind : Jdec.Decoder Kind
kind =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "t3" -> Jdec.succeed T3
                somethingElse -> Jdec.fail <| "Invalid Kind: " ++ somethingElse
        )

encodeKind : Kind -> Jenc.Value
encodeKind x = case x of
    T3 -> Jenc.string "t3"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
