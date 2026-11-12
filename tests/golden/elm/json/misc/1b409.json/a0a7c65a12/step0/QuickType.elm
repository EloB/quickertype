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
    , Meta
    , Object
    , Extra
    , Person
    , Party(..)
    , Gender(..)
    , GenderLabel(..)
    , Namemod(..)
    , RoleType(..)
    , RoleTypeLabel(..)
    , Title(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { meta : Meta
    , objects : List Object
    }

type alias Meta =
    { limit : Int
    , offset : Int
    , totalCount : Int
    }

type alias Object =
    { caucus : ()
    , congressNumbers : List Int
    , current : Bool
    , description : String
    , district : Int
    , enddate : String
    , extra : Extra
    , id : Int
    , leadershipTitle : Maybe String
    , party : Party
    , person : Person
    , phone : String
    , roleType : RoleType
    , roleTypeLabel : RoleTypeLabel
    , senatorClass : ()
    , senatorRank : ()
    , startdate : String
    , state : String
    , title : Title
    , titleLong : RoleTypeLabel
    , website : String
    }

type alias Extra =
    { address : String
    , contactForm : Maybe String
    , fax : Maybe String
    , office : String
    , rssURL : Maybe String
    }

type Party
    = Republican
    | Democrat

type alias Person =
    { bioguideid : String
    , birthday : String
    , cspanid : Int
    , firstname : String
    , gender : Gender
    , genderLabel : GenderLabel
    , id : Int
    , lastname : String
    , link : String
    , middlename : String
    , name : String
    , namemod : Namemod
    , nickname : String
    , osid : String
    , pvsid : Maybe String
    , sortname : String
    , twitterid : Maybe String
    , youtubeid : Maybe String
    }

type Gender
    = Male
    | Female

type GenderLabel
    = GenderLabelMale
    | GenderLabelFemale

type Namemod
    = Empty
    | Jr
    | Ii
    | Iii
    | Iv

type RoleType
    = Representative

type RoleTypeLabel
    = RoleTypeLabelRepresentative
    | Delegate
    | ResidentCommissioner

type Title
    = Rep
    | Commish

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
        |> Jpipe.required "meta" meta
        |> Jpipe.required "objects" (Jdec.list object )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("meta", encodeMeta x.meta)
        , ("objects", Jenc.list encodeObject x.objects)
        ]

meta : Jdec.Decoder Meta
meta =
    Jdec.succeed Meta
        |> Jpipe.required "limit" Jdec.int
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "total_count" Jdec.int

encodeMeta : Meta -> Jenc.Value
encodeMeta x =
    Jenc.object
        [ ("limit", Jenc.int x.limit)
        , ("offset", Jenc.int x.offset)
        , ("total_count", Jenc.int x.totalCount)
        ]

object : Jdec.Decoder Object
object =
    Jdec.succeed Object
        |> Jpipe.required "caucus" (Jdec.null ())
        |> Jpipe.required "congress_numbers" (Jdec.list Jdec.int )
        |> Jpipe.required "current" Jdec.bool
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "district" Jdec.int
        |> Jpipe.required "enddate" Jdec.string
        |> Jpipe.required "extra" extra
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "leadership_title" (Jdec.nullable Jdec.string)
        |> Jpipe.required "party" party
        |> Jpipe.required "person" person
        |> Jpipe.required "phone" Jdec.string
        |> Jpipe.required "role_type" roleType
        |> Jpipe.required "role_type_label" roleTypeLabel
        |> Jpipe.required "senator_class" (Jdec.null ())
        |> Jpipe.required "senator_rank" (Jdec.null ())
        |> Jpipe.required "startdate" Jdec.string
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "title" title
        |> Jpipe.required "title_long" roleTypeLabel
        |> Jpipe.required "website" Jdec.string

encodeObject : Object -> Jenc.Value
encodeObject x =
    Jenc.object
        [ ("caucus", always Jenc.null x.caucus)
        , ("congress_numbers", Jenc.list Jenc.int x.congressNumbers)
        , ("current", Jenc.bool x.current)
        , ("description", Jenc.string x.description)
        , ("district", Jenc.int x.district)
        , ("enddate", Jenc.string x.enddate)
        , ("extra", encodeExtra x.extra)
        , ("id", Jenc.int x.id)
        , ("leadership_title", makeNullableEncoder Jenc.string x.leadershipTitle)
        , ("party", encodeParty x.party)
        , ("person", encodePerson x.person)
        , ("phone", Jenc.string x.phone)
        , ("role_type", encodeRoleType x.roleType)
        , ("role_type_label", encodeRoleTypeLabel x.roleTypeLabel)
        , ("senator_class", always Jenc.null x.senatorClass)
        , ("senator_rank", always Jenc.null x.senatorRank)
        , ("startdate", Jenc.string x.startdate)
        , ("state", Jenc.string x.state)
        , ("title", encodeTitle x.title)
        , ("title_long", encodeRoleTypeLabel x.titleLong)
        , ("website", Jenc.string x.website)
        ]

extra : Jdec.Decoder Extra
extra =
    Jdec.succeed Extra
        |> Jpipe.required "address" Jdec.string
        |> Jpipe.custom (optionalField "contact_form" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "fax" (Jdec.nullable Jdec.string) Nothing)
        |> Jpipe.required "office" Jdec.string
        |> Jpipe.custom (optionalField "rss_url" (Jdec.map Just Jdec.string) Nothing)

encodeExtra : Extra -> Jenc.Value
encodeExtra x =
    Jenc.object
        [ ("address", Jenc.string x.address)
        , ("contact_form", makeNullableEncoder Jenc.string x.contactForm)
        , ("fax", makeNullableEncoder Jenc.string x.fax)
        , ("office", Jenc.string x.office)
        , ("rss_url", makeNullableEncoder Jenc.string x.rssURL)
        ]

party : Jdec.Decoder Party
party =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Republican" -> Jdec.succeed Republican
                "Democrat" -> Jdec.succeed Democrat
                somethingElse -> Jdec.fail <| "Invalid Party: " ++ somethingElse
        )

encodeParty : Party -> Jenc.Value
encodeParty x = case x of
    Republican -> Jenc.string "Republican"
    Democrat -> Jenc.string "Democrat"

person : Jdec.Decoder Person
person =
    Jdec.succeed Person
        |> Jpipe.required "bioguideid" Jdec.string
        |> Jpipe.required "birthday" Jdec.string
        |> Jpipe.required "cspanid" Jdec.int
        |> Jpipe.required "firstname" Jdec.string
        |> Jpipe.required "gender" gender
        |> Jpipe.required "gender_label" genderLabel
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "lastname" Jdec.string
        |> Jpipe.required "link" Jdec.string
        |> Jpipe.required "middlename" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "namemod" namemod
        |> Jpipe.required "nickname" Jdec.string
        |> Jpipe.required "osid" Jdec.string
        |> Jpipe.required "pvsid" (Jdec.nullable Jdec.string)
        |> Jpipe.required "sortname" Jdec.string
        |> Jpipe.required "twitterid" (Jdec.nullable Jdec.string)
        |> Jpipe.required "youtubeid" (Jdec.nullable Jdec.string)

encodePerson : Person -> Jenc.Value
encodePerson x =
    Jenc.object
        [ ("bioguideid", Jenc.string x.bioguideid)
        , ("birthday", Jenc.string x.birthday)
        , ("cspanid", Jenc.int x.cspanid)
        , ("firstname", Jenc.string x.firstname)
        , ("gender", encodeGender x.gender)
        , ("gender_label", encodeGenderLabel x.genderLabel)
        , ("id", Jenc.int x.id)
        , ("lastname", Jenc.string x.lastname)
        , ("link", Jenc.string x.link)
        , ("middlename", Jenc.string x.middlename)
        , ("name", Jenc.string x.name)
        , ("namemod", encodeNamemod x.namemod)
        , ("nickname", Jenc.string x.nickname)
        , ("osid", Jenc.string x.osid)
        , ("pvsid", makeNullableEncoder Jenc.string x.pvsid)
        , ("sortname", Jenc.string x.sortname)
        , ("twitterid", makeNullableEncoder Jenc.string x.twitterid)
        , ("youtubeid", makeNullableEncoder Jenc.string x.youtubeid)
        ]

gender : Jdec.Decoder Gender
gender =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "male" -> Jdec.succeed Male
                "female" -> Jdec.succeed Female
                somethingElse -> Jdec.fail <| "Invalid Gender: " ++ somethingElse
        )

encodeGender : Gender -> Jenc.Value
encodeGender x = case x of
    Male -> Jenc.string "male"
    Female -> Jenc.string "female"

genderLabel : Jdec.Decoder GenderLabel
genderLabel =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Male" -> Jdec.succeed GenderLabelMale
                "Female" -> Jdec.succeed GenderLabelFemale
                somethingElse -> Jdec.fail <| "Invalid GenderLabel: " ++ somethingElse
        )

encodeGenderLabel : GenderLabel -> Jenc.Value
encodeGenderLabel x = case x of
    GenderLabelMale -> Jenc.string "Male"
    GenderLabelFemale -> Jenc.string "Female"

namemod : Jdec.Decoder Namemod
namemod =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Empty
                "Jr." -> Jdec.succeed Jr
                "II" -> Jdec.succeed Ii
                "III" -> Jdec.succeed Iii
                "IV" -> Jdec.succeed Iv
                somethingElse -> Jdec.fail <| "Invalid Namemod: " ++ somethingElse
        )

encodeNamemod : Namemod -> Jenc.Value
encodeNamemod x = case x of
    Empty -> Jenc.string ""
    Jr -> Jenc.string "Jr."
    Ii -> Jenc.string "II"
    Iii -> Jenc.string "III"
    Iv -> Jenc.string "IV"

roleType : Jdec.Decoder RoleType
roleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "representative" -> Jdec.succeed Representative
                somethingElse -> Jdec.fail <| "Invalid RoleType: " ++ somethingElse
        )

encodeRoleType : RoleType -> Jenc.Value
encodeRoleType x = case x of
    Representative -> Jenc.string "representative"

roleTypeLabel : Jdec.Decoder RoleTypeLabel
roleTypeLabel =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Representative" -> Jdec.succeed RoleTypeLabelRepresentative
                "Delegate" -> Jdec.succeed Delegate
                "Resident Commissioner" -> Jdec.succeed ResidentCommissioner
                somethingElse -> Jdec.fail <| "Invalid RoleTypeLabel: " ++ somethingElse
        )

encodeRoleTypeLabel : RoleTypeLabel -> Jenc.Value
encodeRoleTypeLabel x = case x of
    RoleTypeLabelRepresentative -> Jenc.string "Representative"
    Delegate -> Jenc.string "Delegate"
    ResidentCommissioner -> Jenc.string "Resident Commissioner"

title : Jdec.Decoder Title
title =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Rep." -> Jdec.succeed Rep
                "Commish." -> Jdec.succeed Commish
                somethingElse -> Jdec.fail <| "Invalid Title: " ++ somethingElse
        )

encodeTitle : Title -> Jenc.Value
encodeTitle x = case x of
    Rep -> Jenc.string "Rep."
    Commish -> Jenc.string "Commish."

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
