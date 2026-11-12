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
    , SenatorClass(..)
    , SenatorClassLabel(..)
    , SenatorRank(..)
    , SenatorRankLabel(..)
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
    { caucus : Maybe Party
    , congressNumbers : List Int
    , current : Bool
    , description : String
    , district : ()
    , enddate : String
    , extra : Extra
    , id : Int
    , leadershipTitle : Maybe String
    , party : Party
    , person : Person
    , phone : String
    , roleType : RoleType
    , roleTypeLabel : RoleTypeLabel
    , senatorClass : SenatorClass
    , senatorClassLabel : SenatorClassLabel
    , senatorRank : SenatorRank
    , senatorRankLabel : SenatorRankLabel
    , startdate : String
    , state : String
    , title : Title
    , titleLong : RoleTypeLabel
    , website : String
    }

type Party
    = Republican
    | Democrat
    | Independent

type alias Extra =
    { address : String
    , contactForm : String
    , fax : Maybe String
    , office : String
    , rssURL : Maybe String
    }

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
    , pvsid : String
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
    | Iii
    | Jr

type RoleType
    = Senator

type RoleTypeLabel
    = RoleTypeLabelSenator

type SenatorClass
    = Class2
    | Class1
    | Class3

type SenatorClassLabel
    = SenatorClassLabelClass2
    | SenatorClassLabelClass1
    | SenatorClassLabelClass3

type SenatorRank
    = Senior
    | Junior

type SenatorRankLabel
    = SenatorRankLabelSenior
    | SenatorRankLabelJunior

type Title
    = Sen

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
        |> Jpipe.required "caucus" (Jdec.nullable party)
        |> Jpipe.required "congress_numbers" (Jdec.list Jdec.int )
        |> Jpipe.required "current" Jdec.bool
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "district" (Jdec.null ())
        |> Jpipe.required "enddate" Jdec.string
        |> Jpipe.required "extra" extra
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "leadership_title" (Jdec.nullable Jdec.string)
        |> Jpipe.required "party" party
        |> Jpipe.required "person" person
        |> Jpipe.required "phone" Jdec.string
        |> Jpipe.required "role_type" roleType
        |> Jpipe.required "role_type_label" roleTypeLabel
        |> Jpipe.required "senator_class" senatorClass
        |> Jpipe.required "senator_class_label" senatorClassLabel
        |> Jpipe.required "senator_rank" senatorRank
        |> Jpipe.required "senator_rank_label" senatorRankLabel
        |> Jpipe.required "startdate" Jdec.string
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "title" title
        |> Jpipe.required "title_long" roleTypeLabel
        |> Jpipe.required "website" Jdec.string

encodeObject : Object -> Jenc.Value
encodeObject x =
    Jenc.object
        [ ("caucus", makeNullableEncoder encodeParty x.caucus)
        , ("congress_numbers", Jenc.list Jenc.int x.congressNumbers)
        , ("current", Jenc.bool x.current)
        , ("description", Jenc.string x.description)
        , ("district", always Jenc.null x.district)
        , ("enddate", Jenc.string x.enddate)
        , ("extra", encodeExtra x.extra)
        , ("id", Jenc.int x.id)
        , ("leadership_title", makeNullableEncoder Jenc.string x.leadershipTitle)
        , ("party", encodeParty x.party)
        , ("person", encodePerson x.person)
        , ("phone", Jenc.string x.phone)
        , ("role_type", encodeRoleType x.roleType)
        , ("role_type_label", encodeRoleTypeLabel x.roleTypeLabel)
        , ("senator_class", encodeSenatorClass x.senatorClass)
        , ("senator_class_label", encodeSenatorClassLabel x.senatorClassLabel)
        , ("senator_rank", encodeSenatorRank x.senatorRank)
        , ("senator_rank_label", encodeSenatorRankLabel x.senatorRankLabel)
        , ("startdate", Jenc.string x.startdate)
        , ("state", Jenc.string x.state)
        , ("title", encodeTitle x.title)
        , ("title_long", encodeRoleTypeLabel x.titleLong)
        , ("website", Jenc.string x.website)
        ]

party : Jdec.Decoder Party
party =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Republican" -> Jdec.succeed Republican
                "Democrat" -> Jdec.succeed Democrat
                "Independent" -> Jdec.succeed Independent
                somethingElse -> Jdec.fail <| "Invalid Party: " ++ somethingElse
        )

encodeParty : Party -> Jenc.Value
encodeParty x = case x of
    Republican -> Jenc.string "Republican"
    Democrat -> Jenc.string "Democrat"
    Independent -> Jenc.string "Independent"

extra : Jdec.Decoder Extra
extra =
    Jdec.succeed Extra
        |> Jpipe.required "address" Jdec.string
        |> Jpipe.required "contact_form" Jdec.string
        |> Jpipe.custom (optionalField "fax" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "office" Jdec.string
        |> Jpipe.custom (optionalField "rss_url" (Jdec.map Just Jdec.string) Nothing)

encodeExtra : Extra -> Jenc.Value
encodeExtra x =
    Jenc.object
        [ ("address", Jenc.string x.address)
        , ("contact_form", Jenc.string x.contactForm)
        , ("fax", makeNullableEncoder Jenc.string x.fax)
        , ("office", Jenc.string x.office)
        , ("rss_url", makeNullableEncoder Jenc.string x.rssURL)
        ]

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
        |> Jpipe.required "pvsid" Jdec.string
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
        , ("pvsid", Jenc.string x.pvsid)
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
                "III" -> Jdec.succeed Iii
                "Jr." -> Jdec.succeed Jr
                somethingElse -> Jdec.fail <| "Invalid Namemod: " ++ somethingElse
        )

encodeNamemod : Namemod -> Jenc.Value
encodeNamemod x = case x of
    Empty -> Jenc.string ""
    Iii -> Jenc.string "III"
    Jr -> Jenc.string "Jr."

roleType : Jdec.Decoder RoleType
roleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "senator" -> Jdec.succeed Senator
                somethingElse -> Jdec.fail <| "Invalid RoleType: " ++ somethingElse
        )

encodeRoleType : RoleType -> Jenc.Value
encodeRoleType x = case x of
    Senator -> Jenc.string "senator"

roleTypeLabel : Jdec.Decoder RoleTypeLabel
roleTypeLabel =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Senator" -> Jdec.succeed RoleTypeLabelSenator
                somethingElse -> Jdec.fail <| "Invalid RoleTypeLabel: " ++ somethingElse
        )

encodeRoleTypeLabel : RoleTypeLabel -> Jenc.Value
encodeRoleTypeLabel x = case x of
    RoleTypeLabelSenator -> Jenc.string "Senator"

senatorClass : Jdec.Decoder SenatorClass
senatorClass =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "class2" -> Jdec.succeed Class2
                "class1" -> Jdec.succeed Class1
                "class3" -> Jdec.succeed Class3
                somethingElse -> Jdec.fail <| "Invalid SenatorClass: " ++ somethingElse
        )

encodeSenatorClass : SenatorClass -> Jenc.Value
encodeSenatorClass x = case x of
    Class2 -> Jenc.string "class2"
    Class1 -> Jenc.string "class1"
    Class3 -> Jenc.string "class3"

senatorClassLabel : Jdec.Decoder SenatorClassLabel
senatorClassLabel =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Class 2" -> Jdec.succeed SenatorClassLabelClass2
                "Class 1" -> Jdec.succeed SenatorClassLabelClass1
                "Class 3" -> Jdec.succeed SenatorClassLabelClass3
                somethingElse -> Jdec.fail <| "Invalid SenatorClassLabel: " ++ somethingElse
        )

encodeSenatorClassLabel : SenatorClassLabel -> Jenc.Value
encodeSenatorClassLabel x = case x of
    SenatorClassLabelClass2 -> Jenc.string "Class 2"
    SenatorClassLabelClass1 -> Jenc.string "Class 1"
    SenatorClassLabelClass3 -> Jenc.string "Class 3"

senatorRank : Jdec.Decoder SenatorRank
senatorRank =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "senior" -> Jdec.succeed Senior
                "junior" -> Jdec.succeed Junior
                somethingElse -> Jdec.fail <| "Invalid SenatorRank: " ++ somethingElse
        )

encodeSenatorRank : SenatorRank -> Jenc.Value
encodeSenatorRank x = case x of
    Senior -> Jenc.string "senior"
    Junior -> Jenc.string "junior"

senatorRankLabel : Jdec.Decoder SenatorRankLabel
senatorRankLabel =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Senior" -> Jdec.succeed SenatorRankLabelSenior
                "Junior" -> Jdec.succeed SenatorRankLabelJunior
                somethingElse -> Jdec.fail <| "Invalid SenatorRankLabel: " ++ somethingElse
        )

encodeSenatorRankLabel : SenatorRankLabel -> Jenc.Value
encodeSenatorRankLabel x = case x of
    SenatorRankLabelSenior -> Jenc.string "Senior"
    SenatorRankLabelJunior -> Jenc.string "Junior"

title : Jdec.Decoder Title
title =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Sen." -> Jdec.succeed Sen
                somethingElse -> Jdec.fail <| "Invalid Title: " ++ somethingElse
        )

encodeTitle : Title -> Jenc.Value
encodeTitle x = case x of
    Sen -> Jenc.string "Sen."

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
