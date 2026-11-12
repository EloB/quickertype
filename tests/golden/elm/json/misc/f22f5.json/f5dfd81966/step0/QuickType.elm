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
    , Subreddit(..)
    , SubredditID(..)
    , SubredditNamePrefixed(..)
    , SubredditType(..)
    , Kind(..)
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
    , distinguished : ()
    , domain : String
    , downs : Int
    , edited : Bool
    , gilded : Int
    , hidden : Bool
    , hideScore : Bool
    , id : String
    , isSelf : Bool
    , isVideo : Bool
    , likes : ()
    , linkFlairCSSClass : Maybe String
    , linkFlairText : Maybe String
    , locked : Bool
    , media : ()
    , mediaEmbed : MediaEmbed
    , modReports : List Jdec.Value
    , name : String
    , numComments : Int
    , numReports : ()
    , over18 : Bool
    , permalink : String
    , quarantine : Bool
    , removalReason : ()
    , reportReasons : ()
    , saved : Bool
    , score : Int
    , secureMedia : ()
    , secureMediaEmbed : MediaEmbed
    , selftext : String
    , selftextHTML : ()
    , spoiler : Bool
    , stickied : Bool
    , subreddit : Subreddit
    , subredditID : SubredditID
    , subredditNamePrefixed : SubredditNamePrefixed
    , subredditType : SubredditType
    , suggestedSort : ()
    , thumbnail : String
    , title : String
    , ups : Int
    , url : String
    , userReports : List Jdec.Value
    , viewCount : ()
    , visited : Bool
    }

type alias MediaEmbed =
    {
    }

type Subreddit
    = Worldnews

type SubredditID
    = T52Qh13

type SubredditNamePrefixed
    = RWorldnews

type SubredditType
    = Public

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
        |> Jpipe.required "distinguished" (Jdec.null ())
        |> Jpipe.required "domain" Jdec.string
        |> Jpipe.required "downs" Jdec.int
        |> Jpipe.required "edited" Jdec.bool
        |> Jpipe.required "gilded" Jdec.int
        |> Jpipe.required "hidden" Jdec.bool
        |> Jpipe.required "hide_score" Jdec.bool
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "is_self" Jdec.bool
        |> Jpipe.required "is_video" Jdec.bool
        |> Jpipe.required "likes" (Jdec.null ())
        |> Jpipe.required "link_flair_css_class" (Jdec.nullable Jdec.string)
        |> Jpipe.required "link_flair_text" (Jdec.nullable Jdec.string)
        |> Jpipe.required "locked" Jdec.bool
        |> Jpipe.required "media" (Jdec.null ())
        |> Jpipe.required "media_embed" mediaEmbed
        |> Jpipe.required "mod_reports" (Jdec.list Jdec.value )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "num_comments" Jdec.int
        |> Jpipe.required "num_reports" (Jdec.null ())
        |> Jpipe.required "over_18" Jdec.bool
        |> Jpipe.required "permalink" Jdec.string
        |> Jpipe.required "quarantine" Jdec.bool
        |> Jpipe.required "removal_reason" (Jdec.null ())
        |> Jpipe.required "report_reasons" (Jdec.null ())
        |> Jpipe.required "saved" Jdec.bool
        |> Jpipe.required "score" Jdec.int
        |> Jpipe.required "secure_media" (Jdec.null ())
        |> Jpipe.required "secure_media_embed" mediaEmbed
        |> Jpipe.required "selftext" Jdec.string
        |> Jpipe.required "selftext_html" (Jdec.null ())
        |> Jpipe.required "spoiler" Jdec.bool
        |> Jpipe.required "stickied" Jdec.bool
        |> Jpipe.required "subreddit" subreddit
        |> Jpipe.required "subreddit_id" subredditID
        |> Jpipe.required "subreddit_name_prefixed" subredditNamePrefixed
        |> Jpipe.required "subreddit_type" subredditType
        |> Jpipe.required "suggested_sort" (Jdec.null ())
        |> Jpipe.required "thumbnail" Jdec.string
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
        , ("distinguished", always Jenc.null x.distinguished)
        , ("domain", Jenc.string x.domain)
        , ("downs", Jenc.int x.downs)
        , ("edited", Jenc.bool x.edited)
        , ("gilded", Jenc.int x.gilded)
        , ("hidden", Jenc.bool x.hidden)
        , ("hide_score", Jenc.bool x.hideScore)
        , ("id", Jenc.string x.id)
        , ("is_self", Jenc.bool x.isSelf)
        , ("is_video", Jenc.bool x.isVideo)
        , ("likes", always Jenc.null x.likes)
        , ("link_flair_css_class", makeNullableEncoder Jenc.string x.linkFlairCSSClass)
        , ("link_flair_text", makeNullableEncoder Jenc.string x.linkFlairText)
        , ("locked", Jenc.bool x.locked)
        , ("media", always Jenc.null x.media)
        , ("media_embed", encodeMediaEmbed x.mediaEmbed)
        , ("mod_reports", Jenc.list identity x.modReports)
        , ("name", Jenc.string x.name)
        , ("num_comments", Jenc.int x.numComments)
        , ("num_reports", always Jenc.null x.numReports)
        , ("over_18", Jenc.bool x.over18)
        , ("permalink", Jenc.string x.permalink)
        , ("quarantine", Jenc.bool x.quarantine)
        , ("removal_reason", always Jenc.null x.removalReason)
        , ("report_reasons", always Jenc.null x.reportReasons)
        , ("saved", Jenc.bool x.saved)
        , ("score", Jenc.int x.score)
        , ("secure_media", always Jenc.null x.secureMedia)
        , ("secure_media_embed", encodeMediaEmbed x.secureMediaEmbed)
        , ("selftext", Jenc.string x.selftext)
        , ("selftext_html", always Jenc.null x.selftextHTML)
        , ("spoiler", Jenc.bool x.spoiler)
        , ("stickied", Jenc.bool x.stickied)
        , ("subreddit", encodeSubreddit x.subreddit)
        , ("subreddit_id", encodeSubredditID x.subredditID)
        , ("subreddit_name_prefixed", encodeSubredditNamePrefixed x.subredditNamePrefixed)
        , ("subreddit_type", encodeSubredditType x.subredditType)
        , ("suggested_sort", always Jenc.null x.suggestedSort)
        , ("thumbnail", Jenc.string x.thumbnail)
        , ("title", Jenc.string x.title)
        , ("ups", Jenc.int x.ups)
        , ("url", Jenc.string x.url)
        , ("user_reports", Jenc.list identity x.userReports)
        , ("view_count", always Jenc.null x.viewCount)
        , ("visited", Jenc.bool x.visited)
        ]

mediaEmbed : Jdec.Decoder MediaEmbed
mediaEmbed =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> MediaEmbed)

encodeMediaEmbed : MediaEmbed -> Jenc.Value
encodeMediaEmbed x =
    Jenc.object
        [
        ]

subreddit : Jdec.Decoder Subreddit
subreddit =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "worldnews" -> Jdec.succeed Worldnews
                somethingElse -> Jdec.fail <| "Invalid Subreddit: " ++ somethingElse
        )

encodeSubreddit : Subreddit -> Jenc.Value
encodeSubreddit x = case x of
    Worldnews -> Jenc.string "worldnews"

subredditID : Jdec.Decoder SubredditID
subredditID =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "t5_2qh13" -> Jdec.succeed T52Qh13
                somethingElse -> Jdec.fail <| "Invalid SubredditID: " ++ somethingElse
        )

encodeSubredditID : SubredditID -> Jenc.Value
encodeSubredditID x = case x of
    T52Qh13 -> Jenc.string "t5_2qh13"

subredditNamePrefixed : Jdec.Decoder SubredditNamePrefixed
subredditNamePrefixed =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "r/worldnews" -> Jdec.succeed RWorldnews
                somethingElse -> Jdec.fail <| "Invalid SubredditNamePrefixed: " ++ somethingElse
        )

encodeSubredditNamePrefixed : SubredditNamePrefixed -> Jenc.Value
encodeSubredditNamePrefixed x = case x of
    RWorldnews -> Jenc.string "r/worldnews"

subredditType : Jdec.Decoder SubredditType
subredditType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "public" -> Jdec.succeed Public
                somethingElse -> Jdec.fail <| "Invalid SubredditType: " ++ somethingElse
        )

encodeSubredditType : SubredditType -> Jenc.Value
encodeSubredditType x = case x of
    Public -> Jenc.string "public"

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
