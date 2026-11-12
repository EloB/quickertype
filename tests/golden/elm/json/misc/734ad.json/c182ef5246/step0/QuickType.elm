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
    , Facets
    , Result
    , Status(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { count : Int
    , facets : Facets
    , limit : Int
    , next : String
    , offset : Int
    , previous : Bool
    , results : List Result
    }

type alias Facets =
    {
    }

type alias Result =
    { acronym : Maybe String
    , activityConsultCommittees : String
    , activityEuLegislative : String
    , activityExpertGroups : String
    , activityHighLevelGroups : String
    , activityIndustryForums : String
    , activityInterGroups : String
    , activityOther : Maybe String
    , activityRelevantComm : String
    , beOfficeCountry : Maybe String
    , beOfficeLat : Maybe Float
    , beOfficeLon : Maybe Float
    , beOfficePhone : Maybe String
    , beOfficePostCode : Maybe String
    , beOfficePostbox : Maybe String
    , beOfficeStreet : Maybe String
    , beOfficeTown : Maybe String
    , codeOfConduct : String
    , contactCountry : Int
    , createdAt : String
    , entity : String
    , goals : String
    , head : String
    , headOfficeCountry : String
    , headOfficeLat : Maybe Float
    , headOfficeLon : Maybe Float
    , headOfficePhone : String
    , headOfficePostCode : Maybe String
    , headOfficePostbox : Maybe String
    , headOfficeStreet : String
    , headOfficeTown : String
    , id : String
    , identificationCode : String
    , infoMembers : String
    , lastUpdateDate : String
    , legal : String
    , legalStatus : String
    , mainCategory : Int
    , mainCategoryTitle : String
    , members : Int
    , members100 : Maybe Int
    , members25 : Maybe Int
    , members50 : Maybe Int
    , members75 : Maybe Int
    , membersFte : Float
    , name : String
    , nativeName : ()
    , networking : Maybe String
    , numberOfNaturalPersons : Maybe Int
    , otherCodeOfConduct : Maybe String
    , registrationDate : String
    , status : Status
    , structureMembers : String
    , subCategory : Int
    , subCategoryTitle : String
    , updatedAt : String
    , uri : String
    , webSiteURL : Maybe String
    }

type Status
    = Active
    | Inactive

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
        |> Jpipe.required "facets" facets
        |> Jpipe.required "limit" Jdec.int
        |> Jpipe.required "next" Jdec.string
        |> Jpipe.required "offset" Jdec.int
        |> Jpipe.required "previous" Jdec.bool
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("facets", encodeFacets x.facets)
        , ("limit", Jenc.int x.limit)
        , ("next", Jenc.string x.next)
        , ("offset", Jenc.int x.offset)
        , ("previous", Jenc.bool x.previous)
        , ("results", Jenc.list encodeResult x.results)
        ]

facets : Jdec.Decoder Facets
facets =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Facets)

encodeFacets : Facets -> Jenc.Value
encodeFacets x =
    Jenc.object
        [
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "acronym" (Jdec.nullable Jdec.string)
        |> Jpipe.required "activity_consult_committees" Jdec.string
        |> Jpipe.required "activity_eu_legislative" Jdec.string
        |> Jpipe.required "activity_expert_groups" Jdec.string
        |> Jpipe.required "activity_high_level_groups" Jdec.string
        |> Jpipe.required "activity_industry_forums" Jdec.string
        |> Jpipe.required "activity_inter_groups" Jdec.string
        |> Jpipe.required "activity_other" (Jdec.nullable Jdec.string)
        |> Jpipe.required "activity_relevant_comm" Jdec.string
        |> Jpipe.custom (optionalField "be_office_country" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "be_office_lat" (Jdec.nullable Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "be_office_lon" (Jdec.nullable Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "be_office_phone" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "be_office_post_code" (Jdec.nullable Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "be_office_postbox" (Jdec.nullable Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "be_office_street" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "be_office_town" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "code_of_conduct" Jdec.string
        |> Jpipe.required "contact_country" Jdec.int
        |> Jpipe.required "created_at" Jdec.string
        |> Jpipe.required "entity" Jdec.string
        |> Jpipe.required "goals" Jdec.string
        |> Jpipe.required "head" Jdec.string
        |> Jpipe.required "head_office_country" Jdec.string
        |> Jpipe.required "head_office_lat" (Jdec.nullable Jdec.float)
        |> Jpipe.required "head_office_lon" (Jdec.nullable Jdec.float)
        |> Jpipe.required "head_office_phone" Jdec.string
        |> Jpipe.required "head_office_post_code" (Jdec.nullable Jdec.string)
        |> Jpipe.required "head_office_postbox" (Jdec.nullable Jdec.string)
        |> Jpipe.required "head_office_street" Jdec.string
        |> Jpipe.required "head_office_town" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "identification_code" Jdec.string
        |> Jpipe.required "info_members" Jdec.string
        |> Jpipe.required "last_update_date" Jdec.string
        |> Jpipe.required "legal" Jdec.string
        |> Jpipe.required "legal_status" Jdec.string
        |> Jpipe.required "main_category" Jdec.int
        |> Jpipe.required "main_category_title" Jdec.string
        |> Jpipe.required "members" Jdec.int
        |> Jpipe.required "members_100" (Jdec.nullable Jdec.int)
        |> Jpipe.required "members_25" (Jdec.nullable Jdec.int)
        |> Jpipe.required "members_50" (Jdec.nullable Jdec.int)
        |> Jpipe.required "members_75" (Jdec.nullable Jdec.int)
        |> Jpipe.required "members_fte" Jdec.float
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "native_name" (Jdec.null ())
        |> Jpipe.required "networking" (Jdec.nullable Jdec.string)
        |> Jpipe.required "number_of_natural_persons" (Jdec.nullable Jdec.int)
        |> Jpipe.required "other_code_of_conduct" (Jdec.nullable Jdec.string)
        |> Jpipe.required "registration_date" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "structure_members" Jdec.string
        |> Jpipe.required "sub_category" Jdec.int
        |> Jpipe.required "sub_category_title" Jdec.string
        |> Jpipe.required "updated_at" Jdec.string
        |> Jpipe.required "uri" Jdec.string
        |> Jpipe.required "web_site_url" (Jdec.nullable Jdec.string)

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("acronym", makeNullableEncoder Jenc.string x.acronym)
        , ("activity_consult_committees", Jenc.string x.activityConsultCommittees)
        , ("activity_eu_legislative", Jenc.string x.activityEuLegislative)
        , ("activity_expert_groups", Jenc.string x.activityExpertGroups)
        , ("activity_high_level_groups", Jenc.string x.activityHighLevelGroups)
        , ("activity_industry_forums", Jenc.string x.activityIndustryForums)
        , ("activity_inter_groups", Jenc.string x.activityInterGroups)
        , ("activity_other", makeNullableEncoder Jenc.string x.activityOther)
        , ("activity_relevant_comm", Jenc.string x.activityRelevantComm)
        , ("be_office_country", makeNullableEncoder Jenc.string x.beOfficeCountry)
        , ("be_office_lat", makeNullableEncoder Jenc.float x.beOfficeLat)
        , ("be_office_lon", makeNullableEncoder Jenc.float x.beOfficeLon)
        , ("be_office_phone", makeNullableEncoder Jenc.string x.beOfficePhone)
        , ("be_office_post_code", makeNullableEncoder Jenc.string x.beOfficePostCode)
        , ("be_office_postbox", makeNullableEncoder Jenc.string x.beOfficePostbox)
        , ("be_office_street", makeNullableEncoder Jenc.string x.beOfficeStreet)
        , ("be_office_town", makeNullableEncoder Jenc.string x.beOfficeTown)
        , ("code_of_conduct", Jenc.string x.codeOfConduct)
        , ("contact_country", Jenc.int x.contactCountry)
        , ("created_at", Jenc.string x.createdAt)
        , ("entity", Jenc.string x.entity)
        , ("goals", Jenc.string x.goals)
        , ("head", Jenc.string x.head)
        , ("head_office_country", Jenc.string x.headOfficeCountry)
        , ("head_office_lat", makeNullableEncoder Jenc.float x.headOfficeLat)
        , ("head_office_lon", makeNullableEncoder Jenc.float x.headOfficeLon)
        , ("head_office_phone", Jenc.string x.headOfficePhone)
        , ("head_office_post_code", makeNullableEncoder Jenc.string x.headOfficePostCode)
        , ("head_office_postbox", makeNullableEncoder Jenc.string x.headOfficePostbox)
        , ("head_office_street", Jenc.string x.headOfficeStreet)
        , ("head_office_town", Jenc.string x.headOfficeTown)
        , ("id", Jenc.string x.id)
        , ("identification_code", Jenc.string x.identificationCode)
        , ("info_members", Jenc.string x.infoMembers)
        , ("last_update_date", Jenc.string x.lastUpdateDate)
        , ("legal", Jenc.string x.legal)
        , ("legal_status", Jenc.string x.legalStatus)
        , ("main_category", Jenc.int x.mainCategory)
        , ("main_category_title", Jenc.string x.mainCategoryTitle)
        , ("members", Jenc.int x.members)
        , ("members_100", makeNullableEncoder Jenc.int x.members100)
        , ("members_25", makeNullableEncoder Jenc.int x.members25)
        , ("members_50", makeNullableEncoder Jenc.int x.members50)
        , ("members_75", makeNullableEncoder Jenc.int x.members75)
        , ("members_fte", Jenc.float x.membersFte)
        , ("name", Jenc.string x.name)
        , ("native_name", always Jenc.null x.nativeName)
        , ("networking", makeNullableEncoder Jenc.string x.networking)
        , ("number_of_natural_persons", makeNullableEncoder Jenc.int x.numberOfNaturalPersons)
        , ("other_code_of_conduct", makeNullableEncoder Jenc.string x.otherCodeOfConduct)
        , ("registration_date", Jenc.string x.registrationDate)
        , ("status", encodeStatus x.status)
        , ("structure_members", Jenc.string x.structureMembers)
        , ("sub_category", Jenc.int x.subCategory)
        , ("sub_category_title", Jenc.string x.subCategoryTitle)
        , ("updated_at", Jenc.string x.updatedAt)
        , ("uri", Jenc.string x.uri)
        , ("web_site_url", makeNullableEncoder Jenc.string x.webSiteURL)
        ]

status : Jdec.Decoder Status
status =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "active" -> Jdec.succeed Active
                "inactive" -> Jdec.succeed Inactive
                somethingElse -> Jdec.fail <| "Invalid Status: " ++ somethingElse
        )

encodeStatus : Status -> Jenc.Value
encodeStatus x = case x of
    Active -> Jenc.string "active"
    Inactive -> Jenc.string "inactive"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
