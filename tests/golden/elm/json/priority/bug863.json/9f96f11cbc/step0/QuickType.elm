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
    , PurpleQuickType
    , FluffyQuickType
    , Breed(..)
    , FIRSTNAMEEnum(..)
    , LASTNAMEEnum(..)
    , Pvptitle(..)
    , RankTitle(..)
    , Sex(..)
    , QuickTypeUnion(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeUnion

type QuickTypeUnion
    = FluffyQuickTypeInQuickTypeUnion FluffyQuickType
    | PurpleQuickTypeArrayInQuickTypeUnion (List PurpleQuickType)
    | StringInQuickTypeUnion String

type alias PurpleQuickType =
    { alienlevel : Int
    , breed : Breed
    , charDimension : Int
    , charInstance : Int
    , defenderRankTitle : String
    , firstname : FIRSTNAMEEnum
    , headid : Int
    , lastname : LASTNAMEEnum
    , levelx : Int
    , name : String
    , prof : String
    , profTitle : String
    , pvprating : Int
    , pvptitle : Pvptitle
    , rank : Int
    , rankTitle : RankTitle
    , sex : Sex
    }

type Breed
    = Atrox
    | Solitus
    | Opifex
    | Nano

type FIRSTNAMEEnum
    = Firstname
    | Chi

type LASTNAMEEnum
    = Lastname
    | Washko

type Pvptitle
    = Freshman

type RankTitle
    = President
    | Advisor
    | Veteran
    | Applicant

type Sex
    = Neuter
    | Male
    | Female

type alias FluffyQuickType =
    { adventurercount : Int
    , agentcount : Int
    , atroxcount : Int
    , avglvl : Float
    , btcount : Int
    , description : String
    , doctorcount : Int
    , enfcount : Int
    , engineeercount : Int
    , femalecount : Int
    , fixercount : Int
    , governingname : String
    , history : String
    , keepercount : Int
    , macount : Int
    , malecount : Int
    , maxlvl : Int
    , metacount : Int
    , minlvl : Int
    , monstercount : Int
    , name : String
    , nanocount : Int
    , nanoracecount : Int
    , neutercount : Int
    , nummembers : Int
    , objective : String
    , opifexcount : Int
    , orgDimension : Int
    , orgInstance : Int
    , shadecount : Int
    , side : Int
    , sideName : String
    , solidercount : Int
    , solituscount : Int
    , tradercount : Int
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeUnion 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeUnion r)

quickTypeUnion : Jdec.Decoder QuickTypeUnion
quickTypeUnion =
    Jdec.oneOf
        [ Jdec.map PurpleQuickTypeArrayInQuickTypeUnion (Jdec.list purpleQuickType )
        , Jdec.map StringInQuickTypeUnion Jdec.string
        , Jdec.map FluffyQuickTypeInQuickTypeUnion fluffyQuickType
        ]

encodeQuickTypeUnion : QuickTypeUnion -> Jenc.Value
encodeQuickTypeUnion x = case x of
    PurpleQuickTypeArrayInQuickTypeUnion y -> Jenc.list encodePurpleQuickType y
    StringInQuickTypeUnion y -> Jenc.string y
    FluffyQuickTypeInQuickTypeUnion y -> encodeFluffyQuickType y

purpleQuickType : Jdec.Decoder PurpleQuickType
purpleQuickType =
    Jdec.succeed PurpleQuickType
        |> Jpipe.required "ALIENLEVEL" Jdec.int
        |> Jpipe.required "BREED" breed
        |> Jpipe.required "CHAR_DIMENSION" Jdec.int
        |> Jpipe.required "CHAR_INSTANCE" Jdec.int
        |> Jpipe.required "DEFENDER_RANK_TITLE" Jdec.string
        |> Jpipe.required "FIRSTNAME" firstnameEnum
        |> Jpipe.required "HEADID" Jdec.int
        |> Jpipe.required "LASTNAME" lastnameEnum
        |> Jpipe.required "LEVELX" Jdec.int
        |> Jpipe.required "NAME" Jdec.string
        |> Jpipe.required "PROF" Jdec.string
        |> Jpipe.required "PROF_TITLE" Jdec.string
        |> Jpipe.required "PVPRATING" Jdec.int
        |> Jpipe.required "PVPTITLE" pvptitle
        |> Jpipe.required "RANK" Jdec.int
        |> Jpipe.required "RANK_TITLE" rankTitle
        |> Jpipe.required "SEX" sex

encodePurpleQuickType : PurpleQuickType -> Jenc.Value
encodePurpleQuickType x =
    Jenc.object
        [ ("ALIENLEVEL", Jenc.int x.alienlevel)
        , ("BREED", encodeBreed x.breed)
        , ("CHAR_DIMENSION", Jenc.int x.charDimension)
        , ("CHAR_INSTANCE", Jenc.int x.charInstance)
        , ("DEFENDER_RANK_TITLE", Jenc.string x.defenderRankTitle)
        , ("FIRSTNAME", encodeFIRSTNAMEEnum x.firstname)
        , ("HEADID", Jenc.int x.headid)
        , ("LASTNAME", encodeLASTNAMEEnum x.lastname)
        , ("LEVELX", Jenc.int x.levelx)
        , ("NAME", Jenc.string x.name)
        , ("PROF", Jenc.string x.prof)
        , ("PROF_TITLE", Jenc.string x.profTitle)
        , ("PVPRATING", Jenc.int x.pvprating)
        , ("PVPTITLE", encodePvptitle x.pvptitle)
        , ("RANK", Jenc.int x.rank)
        , ("RANK_TITLE", encodeRankTitle x.rankTitle)
        , ("SEX", encodeSex x.sex)
        ]

breed : Jdec.Decoder Breed
breed =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Atrox" -> Jdec.succeed Atrox
                "Solitus" -> Jdec.succeed Solitus
                "Opifex" -> Jdec.succeed Opifex
                "Nano" -> Jdec.succeed Nano
                somethingElse -> Jdec.fail <| "Invalid Breed: " ++ somethingElse
        )

encodeBreed : Breed -> Jenc.Value
encodeBreed x = case x of
    Atrox -> Jenc.string "Atrox"
    Solitus -> Jenc.string "Solitus"
    Opifex -> Jenc.string "Opifex"
    Nano -> Jenc.string "Nano"

firstnameEnum : Jdec.Decoder FIRSTNAMEEnum
firstnameEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Firstname
                "Chi" -> Jdec.succeed Chi
                somethingElse -> Jdec.fail <| "Invalid FIRSTNAMEEnum: " ++ somethingElse
        )

encodeFIRSTNAMEEnum : FIRSTNAMEEnum -> Jenc.Value
encodeFIRSTNAMEEnum x = case x of
    Firstname -> Jenc.string ""
    Chi -> Jenc.string "Chi"

lastnameEnum : Jdec.Decoder LASTNAMEEnum
lastnameEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Lastname
                "Washko" -> Jdec.succeed Washko
                somethingElse -> Jdec.fail <| "Invalid LASTNAMEEnum: " ++ somethingElse
        )

encodeLASTNAMEEnum : LASTNAMEEnum -> Jenc.Value
encodeLASTNAMEEnum x = case x of
    Lastname -> Jenc.string ""
    Washko -> Jenc.string "Washko"

pvptitle : Jdec.Decoder Pvptitle
pvptitle =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Freshman" -> Jdec.succeed Freshman
                somethingElse -> Jdec.fail <| "Invalid Pvptitle: " ++ somethingElse
        )

encodePvptitle : Pvptitle -> Jenc.Value
encodePvptitle x = case x of
    Freshman -> Jenc.string "Freshman"

rankTitle : Jdec.Decoder RankTitle
rankTitle =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "President" -> Jdec.succeed President
                "Advisor" -> Jdec.succeed Advisor
                "Veteran" -> Jdec.succeed Veteran
                "Applicant" -> Jdec.succeed Applicant
                somethingElse -> Jdec.fail <| "Invalid RankTitle: " ++ somethingElse
        )

encodeRankTitle : RankTitle -> Jenc.Value
encodeRankTitle x = case x of
    President -> Jenc.string "President"
    Advisor -> Jenc.string "Advisor"
    Veteran -> Jenc.string "Veteran"
    Applicant -> Jenc.string "Applicant"

sex : Jdec.Decoder Sex
sex =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Neuter" -> Jdec.succeed Neuter
                "Male" -> Jdec.succeed Male
                "Female" -> Jdec.succeed Female
                somethingElse -> Jdec.fail <| "Invalid Sex: " ++ somethingElse
        )

encodeSex : Sex -> Jenc.Value
encodeSex x = case x of
    Neuter -> Jenc.string "Neuter"
    Male -> Jenc.string "Male"
    Female -> Jenc.string "Female"

fluffyQuickType : Jdec.Decoder FluffyQuickType
fluffyQuickType =
    Jdec.succeed FluffyQuickType
        |> Jpipe.required "ADVENTURERCOUNT" Jdec.int
        |> Jpipe.required "AGENTCOUNT" Jdec.int
        |> Jpipe.required "ATROXCOUNT" Jdec.int
        |> Jpipe.required "AVGLVL" Jdec.float
        |> Jpipe.required "BTCOUNT" Jdec.int
        |> Jpipe.required "DESCRIPTION" Jdec.string
        |> Jpipe.required "DOCTORCOUNT" Jdec.int
        |> Jpipe.required "ENFCOUNT" Jdec.int
        |> Jpipe.required "ENGINEEERCOUNT" Jdec.int
        |> Jpipe.required "FEMALECOUNT" Jdec.int
        |> Jpipe.required "FIXERCOUNT" Jdec.int
        |> Jpipe.required "GOVERNINGNAME" Jdec.string
        |> Jpipe.required "HISTORY" Jdec.string
        |> Jpipe.required "KEEPERCOUNT" Jdec.int
        |> Jpipe.required "MACOUNT" Jdec.int
        |> Jpipe.required "MALECOUNT" Jdec.int
        |> Jpipe.required "MAXLVL" Jdec.int
        |> Jpipe.required "METACOUNT" Jdec.int
        |> Jpipe.required "MINLVL" Jdec.int
        |> Jpipe.required "MONSTERCOUNT" Jdec.int
        |> Jpipe.required "NAME" Jdec.string
        |> Jpipe.required "NANOCOUNT" Jdec.int
        |> Jpipe.required "NANORACECOUNT" Jdec.int
        |> Jpipe.required "NEUTERCOUNT" Jdec.int
        |> Jpipe.required "NUMMEMBERS" Jdec.int
        |> Jpipe.required "OBJECTIVE" Jdec.string
        |> Jpipe.required "OPIFEXCOUNT" Jdec.int
        |> Jpipe.required "ORG_DIMENSION" Jdec.int
        |> Jpipe.required "ORG_INSTANCE" Jdec.int
        |> Jpipe.required "SHADECOUNT" Jdec.int
        |> Jpipe.required "SIDE" Jdec.int
        |> Jpipe.required "SIDE_NAME" Jdec.string
        |> Jpipe.required "SOLIDERCOUNT" Jdec.int
        |> Jpipe.required "SOLITUSCOUNT" Jdec.int
        |> Jpipe.required "TRADERCOUNT" Jdec.int

encodeFluffyQuickType : FluffyQuickType -> Jenc.Value
encodeFluffyQuickType x =
    Jenc.object
        [ ("ADVENTURERCOUNT", Jenc.int x.adventurercount)
        , ("AGENTCOUNT", Jenc.int x.agentcount)
        , ("ATROXCOUNT", Jenc.int x.atroxcount)
        , ("AVGLVL", Jenc.float x.avglvl)
        , ("BTCOUNT", Jenc.int x.btcount)
        , ("DESCRIPTION", Jenc.string x.description)
        , ("DOCTORCOUNT", Jenc.int x.doctorcount)
        , ("ENFCOUNT", Jenc.int x.enfcount)
        , ("ENGINEEERCOUNT", Jenc.int x.engineeercount)
        , ("FEMALECOUNT", Jenc.int x.femalecount)
        , ("FIXERCOUNT", Jenc.int x.fixercount)
        , ("GOVERNINGNAME", Jenc.string x.governingname)
        , ("HISTORY", Jenc.string x.history)
        , ("KEEPERCOUNT", Jenc.int x.keepercount)
        , ("MACOUNT", Jenc.int x.macount)
        , ("MALECOUNT", Jenc.int x.malecount)
        , ("MAXLVL", Jenc.int x.maxlvl)
        , ("METACOUNT", Jenc.int x.metacount)
        , ("MINLVL", Jenc.int x.minlvl)
        , ("MONSTERCOUNT", Jenc.int x.monstercount)
        , ("NAME", Jenc.string x.name)
        , ("NANOCOUNT", Jenc.int x.nanocount)
        , ("NANORACECOUNT", Jenc.int x.nanoracecount)
        , ("NEUTERCOUNT", Jenc.int x.neutercount)
        , ("NUMMEMBERS", Jenc.int x.nummembers)
        , ("OBJECTIVE", Jenc.string x.objective)
        , ("OPIFEXCOUNT", Jenc.int x.opifexcount)
        , ("ORG_DIMENSION", Jenc.int x.orgDimension)
        , ("ORG_INSTANCE", Jenc.int x.orgInstance)
        , ("SHADECOUNT", Jenc.int x.shadecount)
        , ("SIDE", Jenc.int x.side)
        , ("SIDE_NAME", Jenc.string x.sideName)
        , ("SOLIDERCOUNT", Jenc.int x.solidercount)
        , ("SOLITUSCOUNT", Jenc.int x.solituscount)
        , ("TRADERCOUNT", Jenc.int x.tradercount)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
