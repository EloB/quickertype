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
    , Othermatch
    , Team
    , Pbp
    , Scorer
    , Time
    , Tm
    , Lds
    , SBlocks
    , Pl
    , Comp
    , Shot
    , Totallds
    , LeaddatumEnum(..)
    , PerType(..)
    , ActionType(..)
    , FamilyNameInitial(..)
    , FirstNameInitial(..)
    , ScoreboardNameEnum(..)
    , SubType(..)
    , LeaddatumElement(..)
    , SMinutes(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { attendance : Int
    , clock : String
    , disableMatch : Int
    , inOT : Int
    , leaddata : List (List LeaddatumElement)
    , officialsReferee1 : String
    , officialsReferee2 : String
    , officialsReferee3 : String
    , othermatches : List Othermatch
    , pbp : List Pbp
    , period : Int
    , periodLengthOVERTIME : Int
    , periodLengthREGULAR : Int
    , periodType : PerType
    , periodsMax : Int
    , scorers : Dict String (List Scorer)
    , timeline : List Jdec.Value
    , tm : Dict String Tm
    , totalTimeAdded : Int
    , totallds : Totallds
    }

type LeaddatumElement
    = EnumInLeaddatumElement LeaddatumEnum
    | IntegerInLeaddatumElement Int

type LeaddatumEnum
    = Leaddatum
    | P1
    | P2
    | P3
    | P4

type alias Othermatch =
    { clock : String
    , competitionName : String
    , id : String
    , period : Int
    , periodType : PerType
    , team1 : Team
    , team1Name : String
    , team1Score : Int
    , team2 : Team
    , team2Name : String
    , team2Score : Int
    }

type PerType
    = Regular

type alias Team =
    { teamCode : String
    , teamCodeInternational : String
    , teamName : String
    , teamNameInternational : String
    }

type alias Pbp =
    { actionType : ActionType
    , familyName : Maybe String
    , familyNameInitial : Maybe FamilyNameInitial
    , firstName : Maybe String
    , firstNameInitial : Maybe FirstNameInitial
    , gt : String
    , internationalFamilyName : Maybe String
    , internationalFamilyNameInitial : Maybe FamilyNameInitial
    , internationalFirstName : Maybe String
    , internationalFirstNameInitial : Maybe FirstNameInitial
    , lead : Int
    , period : Int
    , periodType : PerType
    , player : String
    , pno : Int
    , qualifier : String
    , s1 : Int
    , s2 : Int
    , scoreboardName : Maybe ScoreboardNameEnum
    , scoring : Int
    , shirtNumber : String
    , subType : String
    , success : Int
    , tno : Int
    }

type ActionType
    = Game
    | Period
    | The3Pt
    | The2Pt
    | Rebound
    | Timeout
    | Foulon
    | Foul
    | Assist
    | Substitution
    | Freethrow
    | Steal
    | Turnover
    | Block
    | Jumpball

type FamilyNameInitial
    = FamilyNameInitialR
    | M
    | S
    | FamilyNameInitialC
    | FamilyNameInitialO
    | W
    | FamilyNameInitialA
    | P
    | V
    | I
    | FamilyNameInitialJ
    | FamilyNameInitialS
    | FamilyNameInitialH
    | FamilyNameInitialB

type FirstNameInitial
    = D
    | FirstNameInitialJ
    | T
    | FirstNameInitialC
    | FirstNameInitialO
    | FirstNameInitialH
    | L
    | FirstNameInitialA
    | K
    | FirstNameInitialR
    | FirstNameInitialB
    | N

type ScoreboardNameEnum
    = ScoreboardName
    | TS
    | RIhata
    | DJones
    | BValentine

type alias Scorer =
    { familyName : Maybe String
    , familyNameInitial : Maybe FamilyNameInitial
    , firstName : Maybe String
    , firstNameInitial : Maybe FirstNameInitial
    , gt : Maybe String
    , internationalFamilyName : Maybe String
    , internationalFamilyNameInitial : Maybe FamilyNameInitial
    , internationalFirstName : Maybe String
    , internationalFirstNameInitial : Maybe FirstNameInitial
    , name : Maybe String
    , per : Maybe Int
    , perType : Maybe PerType
    , player : Maybe String
    , pno : Int
    , scoreboardName : Maybe ScoreboardNameEnum
    , shirtNumber : String
    , summary : Maybe String
    , times : Maybe (List Time)
    , tno : Int
    , tot : Maybe Int
    }

type alias Time =
    { gt : String
    , per : Int
    , perType : PerType
    }

type alias Tm =
    { code : String
    , codeInternational : String
    , fouls : Int
    , fullScore : Int
    , lds : Lds
    , logo : String
    , name : String
    , nameInternational : String
    , p1Score : Int
    , p2Score : Int
    , p3Score : Int
    , p4Score : Int
    , pl : Dict String Pl
    , score : Int
    , scoring : List Scorer
    , shortName : String
    , shortNameInternational : String
    , shot : List Shot
    , timeouts : Int
    , totEFF1 : Int
    , totEFF2 : Int
    , totEFF3 : Float
    , totEFF4 : Int
    , totEFF5 : Int
    , totEFF6 : Int
    , totEFF7 : Int
    , totSAssists : Int
    , totSBenchPoints : Int
    , totSBiggestLead : Int
    , totSBiggestScoringRun : Int
    , totSBlocks : Int
    , totSBlocksReceived : Int
    , totSFieldGoalsAttempted : Int
    , totSFieldGoalsMade : Int
    , totSFieldGoalsPercentage : Int
    , totSFoulsOn : Int
    , totSFoulsPersonal : Int
    , totSFoulsTeam : Int
    , totSFreeThrowsAttempted : Int
    , totSFreeThrowsMade : Int
    , totSFreeThrowsPercentage : Int
    , totSLeadChanges : Int
    , totSMinutes : Int
    , totSPoints : Int
    , totSPointsFastBreak : Int
    , totSPointsFromTurnovers : Int
    , totSPointsInThePaint : Int
    , totSPointsSecondChance : Int
    , totSReboundsDefensive : Int
    , totSReboundsOffensive : Int
    , totSReboundsTeam : Int
    , totSReboundsTeamDefensive : Int
    , totSReboundsTeamOffensive : Int
    , totSReboundsTotal : Int
    , totSSteals : Int
    , totSThreePointersAttempted : Int
    , totSThreePointersMade : Int
    , totSThreePointersPercentage : Int
    , totSTimeLeading : Float
    , totSTimesScoresLevel : Int
    , totSTurnovers : Int
    , totSTurnoversTeam : Int
    , totSTwoPointersAttempted : Int
    , totSTwoPointersMade : Int
    , totSTwoPointersPercentage : Int
    }

type alias Lds =
    { sAssists : Dict String Scorer
    , sBlocks : SBlocks
    , sPoints : Dict String Scorer
    , sReboundsTotal : Dict String Scorer
    , sSteals : Dict String Scorer
    }

type alias SBlocks =
    { the1 : Scorer
    }

type alias Pl =
    { active : Int
    , captain : Maybe Int
    , comp : Maybe Comp
    , eff1 : Int
    , eff2 : Int
    , eff3 : Float
    , eff4 : Float
    , eff5 : Int
    , eff6 : Int
    , eff7 : Int
    , familyName : String
    , familyNameInitial : FamilyNameInitial
    , firstName : String
    , firstNameInitial : FirstNameInitial
    , internationalFamilyName : String
    , internationalFamilyNameInitial : FamilyNameInitial
    , internationalFirstName : String
    , internationalFirstNameInitial : FirstNameInitial
    , name : String
    , playingPosition : String
    , sAssists : Int
    , sBlocks : Int
    , sBlocksReceived : Int
    , sFieldGoalsAttempted : Int
    , sFieldGoalsMade : Int
    , sFieldGoalsPercentage : Int
    , sFoulsOn : Int
    , sFoulsPersonal : Int
    , sFreeThrowsAttempted : Int
    , sFreeThrowsMade : Int
    , sFreeThrowsPercentage : Int
    , sMinutes : SMinutes
    , sPlusMinusPoints : Int
    , sPoints : Int
    , sPointsFastBreak : Int
    , sPointsInThePaint : Int
    , sPointsSecondChance : Int
    , sReboundsDefensive : Int
    , sReboundsOffensive : Int
    , sReboundsTotal : Int
    , sSteals : Int
    , sThreePointersAttempted : Int
    , sThreePointersMade : Int
    , sThreePointersPercentage : Int
    , sTurnovers : Int
    , sTwoPointersAttempted : Int
    , sTwoPointersMade : Int
    , sTwoPointersPercentage : Int
    , shirtNumber : String
    , starter : Int
    }

type alias Comp =
    { sAssistsAverage : Float
    , sMinutesAverage : String
    , sPointsAverage : Float
    , sReboundsTotalAverage : Float
    }

type SMinutes
    = IntegerInSMinutes Int
    | StringInSMinutes String

type alias Shot =
    { actionType : ActionType
    , p : Int
    , per : Int
    , perType : PerType
    , player : String
    , pno : Int
    , shirtNumber : String
    , shotR : Int
    , shotX : Int
    , shotY : Int
    , subType : SubType
    , tno : Int
    }

type SubType
    = Jumpshot
    | Layup
    | Dunk

type alias Totallds =
    { sAssists : Dict String Scorer
    , sBlocks : Dict String Scorer
    , sPoints : Dict String Scorer
    , sReboundsTotal : Dict String Scorer
    , sSteals : Dict String Scorer
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
        |> Jpipe.required "attendance" Jdec.int
        |> Jpipe.required "clock" Jdec.string
        |> Jpipe.required "disableMatch" Jdec.int
        |> Jpipe.required "inOT" Jdec.int
        |> Jpipe.required "leaddata" (Jdec.list (Jdec.list leaddatumElement ) )
        |> Jpipe.required "officials_referee1" Jdec.string
        |> Jpipe.required "officials_referee2" Jdec.string
        |> Jpipe.required "officials_referee3" Jdec.string
        |> Jpipe.required "othermatches" (Jdec.list othermatch )
        |> Jpipe.required "pbp" (Jdec.list pbp )
        |> Jpipe.required "period" Jdec.int
        |> Jpipe.required "periodLengthOVERTIME" Jdec.int
        |> Jpipe.required "periodLengthREGULAR" Jdec.int
        |> Jpipe.required "periodType" perType
        |> Jpipe.required "periodsMax" Jdec.int
        |> Jpipe.required "scorers" (Jdec.dict (Jdec.list scorer ))
        |> Jpipe.required "timeline" (Jdec.list Jdec.value )
        |> Jpipe.required "tm" (Jdec.dict tm)
        |> Jpipe.required "totalTimeAdded" Jdec.int
        |> Jpipe.required "totallds" totallds

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("attendance", Jenc.int x.attendance)
        , ("clock", Jenc.string x.clock)
        , ("disableMatch", Jenc.int x.disableMatch)
        , ("inOT", Jenc.int x.inOT)
        , ("leaddata", Jenc.list (Jenc.list encodeLeaddatumElement) x.leaddata)
        , ("officials_referee1", Jenc.string x.officialsReferee1)
        , ("officials_referee2", Jenc.string x.officialsReferee2)
        , ("officials_referee3", Jenc.string x.officialsReferee3)
        , ("othermatches", Jenc.list encodeOthermatch x.othermatches)
        , ("pbp", Jenc.list encodePbp x.pbp)
        , ("period", Jenc.int x.period)
        , ("periodLengthOVERTIME", Jenc.int x.periodLengthOVERTIME)
        , ("periodLengthREGULAR", Jenc.int x.periodLengthREGULAR)
        , ("periodType", encodePerType x.periodType)
        , ("periodsMax", Jenc.int x.periodsMax)
        , ("scorers", Jenc.dict identity (Jenc.list encodeScorer) x.scorers)
        , ("timeline", Jenc.list identity x.timeline)
        , ("tm", Jenc.dict identity encodeTm x.tm)
        , ("totalTimeAdded", Jenc.int x.totalTimeAdded)
        , ("totallds", encodeTotallds x.totallds)
        ]

leaddatumElement : Jdec.Decoder LeaddatumElement
leaddatumElement =
    Jdec.oneOf
        [ Jdec.map IntegerInLeaddatumElement Jdec.int
        , Jdec.map EnumInLeaddatumElement leaddatumEnum
        ]

encodeLeaddatumElement : LeaddatumElement -> Jenc.Value
encodeLeaddatumElement x = case x of
    IntegerInLeaddatumElement y -> Jenc.int y
    EnumInLeaddatumElement y -> encodeLeaddatumEnum y

leaddatumEnum : Jdec.Decoder LeaddatumEnum
leaddatumEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Leaddatum
                "P1" -> Jdec.succeed P1
                "P2" -> Jdec.succeed P2
                "P3" -> Jdec.succeed P3
                "P4" -> Jdec.succeed P4
                somethingElse -> Jdec.fail <| "Invalid LeaddatumEnum: " ++ somethingElse
        )

encodeLeaddatumEnum : LeaddatumEnum -> Jenc.Value
encodeLeaddatumEnum x = case x of
    Leaddatum -> Jenc.string ""
    P1 -> Jenc.string "P1"
    P2 -> Jenc.string "P2"
    P3 -> Jenc.string "P3"
    P4 -> Jenc.string "P4"

othermatch : Jdec.Decoder Othermatch
othermatch =
    Jdec.succeed Othermatch
        |> Jpipe.required "clock" Jdec.string
        |> Jpipe.required "competitionName" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "period" Jdec.int
        |> Jpipe.required "periodType" perType
        |> Jpipe.required "team1" team
        |> Jpipe.required "team1Name" Jdec.string
        |> Jpipe.required "team1Score" Jdec.int
        |> Jpipe.required "team2" team
        |> Jpipe.required "team2Name" Jdec.string
        |> Jpipe.required "team2Score" Jdec.int

encodeOthermatch : Othermatch -> Jenc.Value
encodeOthermatch x =
    Jenc.object
        [ ("clock", Jenc.string x.clock)
        , ("competitionName", Jenc.string x.competitionName)
        , ("id", Jenc.string x.id)
        , ("period", Jenc.int x.period)
        , ("periodType", encodePerType x.periodType)
        , ("team1", encodeTeam x.team1)
        , ("team1Name", Jenc.string x.team1Name)
        , ("team1Score", Jenc.int x.team1Score)
        , ("team2", encodeTeam x.team2)
        , ("team2Name", Jenc.string x.team2Name)
        , ("team2Score", Jenc.int x.team2Score)
        ]

perType : Jdec.Decoder PerType
perType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "REGULAR" -> Jdec.succeed Regular
                somethingElse -> Jdec.fail <| "Invalid PerType: " ++ somethingElse
        )

encodePerType : PerType -> Jenc.Value
encodePerType x = case x of
    Regular -> Jenc.string "REGULAR"

team : Jdec.Decoder Team
team =
    Jdec.succeed Team
        |> Jpipe.required "teamCode" Jdec.string
        |> Jpipe.required "teamCodeInternational" Jdec.string
        |> Jpipe.required "teamName" Jdec.string
        |> Jpipe.required "teamNameInternational" Jdec.string

encodeTeam : Team -> Jenc.Value
encodeTeam x =
    Jenc.object
        [ ("teamCode", Jenc.string x.teamCode)
        , ("teamCodeInternational", Jenc.string x.teamCodeInternational)
        , ("teamName", Jenc.string x.teamName)
        , ("teamNameInternational", Jenc.string x.teamNameInternational)
        ]

pbp : Jdec.Decoder Pbp
pbp =
    Jdec.succeed Pbp
        |> Jpipe.required "actionType" actionType
        |> Jpipe.custom (optionalField "familyName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "familyNameInitial" (Jdec.map Just familyNameInitial) Nothing)
        |> Jpipe.custom (optionalField "firstName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "firstNameInitial" (Jdec.map Just firstNameInitial) Nothing)
        |> Jpipe.required "gt" Jdec.string
        |> Jpipe.custom (optionalField "internationalFamilyName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "internationalFamilyNameInitial" (Jdec.map Just familyNameInitial) Nothing)
        |> Jpipe.custom (optionalField "internationalFirstName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "internationalFirstNameInitial" (Jdec.map Just firstNameInitial) Nothing)
        |> Jpipe.required "lead" Jdec.int
        |> Jpipe.required "period" Jdec.int
        |> Jpipe.required "periodType" perType
        |> Jpipe.required "player" Jdec.string
        |> Jpipe.required "pno" Jdec.int
        |> Jpipe.required "qualifier" Jdec.string
        |> Jpipe.required "s1" Jdec.int
        |> Jpipe.required "s2" Jdec.int
        |> Jpipe.custom (optionalField "scoreboardName" (Jdec.map Just scoreboardNameEnum) Nothing)
        |> Jpipe.required "scoring" Jdec.int
        |> Jpipe.required "shirtNumber" Jdec.string
        |> Jpipe.required "subType" Jdec.string
        |> Jpipe.required "success" Jdec.int
        |> Jpipe.required "tno" Jdec.int

encodePbp : Pbp -> Jenc.Value
encodePbp x =
    Jenc.object
        [ ("actionType", encodeActionType x.actionType)
        , ("familyName", makeNullableEncoder Jenc.string x.familyName)
        , ("familyNameInitial", makeNullableEncoder encodeFamilyNameInitial x.familyNameInitial)
        , ("firstName", makeNullableEncoder Jenc.string x.firstName)
        , ("firstNameInitial", makeNullableEncoder encodeFirstNameInitial x.firstNameInitial)
        , ("gt", Jenc.string x.gt)
        , ("internationalFamilyName", makeNullableEncoder Jenc.string x.internationalFamilyName)
        , ("internationalFamilyNameInitial", makeNullableEncoder encodeFamilyNameInitial x.internationalFamilyNameInitial)
        , ("internationalFirstName", makeNullableEncoder Jenc.string x.internationalFirstName)
        , ("internationalFirstNameInitial", makeNullableEncoder encodeFirstNameInitial x.internationalFirstNameInitial)
        , ("lead", Jenc.int x.lead)
        , ("period", Jenc.int x.period)
        , ("periodType", encodePerType x.periodType)
        , ("player", Jenc.string x.player)
        , ("pno", Jenc.int x.pno)
        , ("qualifier", Jenc.string x.qualifier)
        , ("s1", Jenc.int x.s1)
        , ("s2", Jenc.int x.s2)
        , ("scoreboardName", makeNullableEncoder encodeScoreboardNameEnum x.scoreboardName)
        , ("scoring", Jenc.int x.scoring)
        , ("shirtNumber", Jenc.string x.shirtNumber)
        , ("subType", Jenc.string x.subType)
        , ("success", Jenc.int x.success)
        , ("tno", Jenc.int x.tno)
        ]

actionType : Jdec.Decoder ActionType
actionType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "game" -> Jdec.succeed Game
                "period" -> Jdec.succeed Period
                "3pt" -> Jdec.succeed The3Pt
                "2pt" -> Jdec.succeed The2Pt
                "rebound" -> Jdec.succeed Rebound
                "timeout" -> Jdec.succeed Timeout
                "foulon" -> Jdec.succeed Foulon
                "foul" -> Jdec.succeed Foul
                "assist" -> Jdec.succeed Assist
                "substitution" -> Jdec.succeed Substitution
                "freethrow" -> Jdec.succeed Freethrow
                "steal" -> Jdec.succeed Steal
                "turnover" -> Jdec.succeed Turnover
                "block" -> Jdec.succeed Block
                "jumpball" -> Jdec.succeed Jumpball
                somethingElse -> Jdec.fail <| "Invalid ActionType: " ++ somethingElse
        )

encodeActionType : ActionType -> Jenc.Value
encodeActionType x = case x of
    Game -> Jenc.string "game"
    Period -> Jenc.string "period"
    The3Pt -> Jenc.string "3pt"
    The2Pt -> Jenc.string "2pt"
    Rebound -> Jenc.string "rebound"
    Timeout -> Jenc.string "timeout"
    Foulon -> Jenc.string "foulon"
    Foul -> Jenc.string "foul"
    Assist -> Jenc.string "assist"
    Substitution -> Jenc.string "substitution"
    Freethrow -> Jenc.string "freethrow"
    Steal -> Jenc.string "steal"
    Turnover -> Jenc.string "turnover"
    Block -> Jenc.string "block"
    Jumpball -> Jenc.string "jumpball"

familyNameInitial : Jdec.Decoder FamilyNameInitial
familyNameInitial =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "R" -> Jdec.succeed FamilyNameInitialR
                "M" -> Jdec.succeed M
                "s" -> Jdec.succeed S
                "C" -> Jdec.succeed FamilyNameInitialC
                "O" -> Jdec.succeed FamilyNameInitialO
                "W" -> Jdec.succeed W
                "A" -> Jdec.succeed FamilyNameInitialA
                "P" -> Jdec.succeed P
                "V" -> Jdec.succeed V
                "I" -> Jdec.succeed I
                "J" -> Jdec.succeed FamilyNameInitialJ
                "S" -> Jdec.succeed FamilyNameInitialS
                "H" -> Jdec.succeed FamilyNameInitialH
                "B" -> Jdec.succeed FamilyNameInitialB
                somethingElse -> Jdec.fail <| "Invalid FamilyNameInitial: " ++ somethingElse
        )

encodeFamilyNameInitial : FamilyNameInitial -> Jenc.Value
encodeFamilyNameInitial x = case x of
    FamilyNameInitialR -> Jenc.string "R"
    M -> Jenc.string "M"
    S -> Jenc.string "s"
    FamilyNameInitialC -> Jenc.string "C"
    FamilyNameInitialO -> Jenc.string "O"
    W -> Jenc.string "W"
    FamilyNameInitialA -> Jenc.string "A"
    P -> Jenc.string "P"
    V -> Jenc.string "V"
    I -> Jenc.string "I"
    FamilyNameInitialJ -> Jenc.string "J"
    FamilyNameInitialS -> Jenc.string "S"
    FamilyNameInitialH -> Jenc.string "H"
    FamilyNameInitialB -> Jenc.string "B"

firstNameInitial : Jdec.Decoder FirstNameInitial
firstNameInitial =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "D" -> Jdec.succeed D
                "J" -> Jdec.succeed FirstNameInitialJ
                "T" -> Jdec.succeed T
                "C" -> Jdec.succeed FirstNameInitialC
                "O" -> Jdec.succeed FirstNameInitialO
                "H" -> Jdec.succeed FirstNameInitialH
                "L" -> Jdec.succeed L
                "A" -> Jdec.succeed FirstNameInitialA
                "K" -> Jdec.succeed K
                "R" -> Jdec.succeed FirstNameInitialR
                "B" -> Jdec.succeed FirstNameInitialB
                "N" -> Jdec.succeed N
                somethingElse -> Jdec.fail <| "Invalid FirstNameInitial: " ++ somethingElse
        )

encodeFirstNameInitial : FirstNameInitial -> Jenc.Value
encodeFirstNameInitial x = case x of
    D -> Jenc.string "D"
    FirstNameInitialJ -> Jenc.string "J"
    T -> Jenc.string "T"
    FirstNameInitialC -> Jenc.string "C"
    FirstNameInitialO -> Jenc.string "O"
    FirstNameInitialH -> Jenc.string "H"
    L -> Jenc.string "L"
    FirstNameInitialA -> Jenc.string "A"
    K -> Jenc.string "K"
    FirstNameInitialR -> Jenc.string "R"
    FirstNameInitialB -> Jenc.string "B"
    N -> Jenc.string "N"

scoreboardNameEnum : Jdec.Decoder ScoreboardNameEnum
scoreboardNameEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed ScoreboardName
                "T. s" -> Jdec.succeed TS
                "R. Ihata" -> Jdec.succeed RIhata
                "D. Jones" -> Jdec.succeed DJones
                "B. Valentine" -> Jdec.succeed BValentine
                somethingElse -> Jdec.fail <| "Invalid ScoreboardNameEnum: " ++ somethingElse
        )

encodeScoreboardNameEnum : ScoreboardNameEnum -> Jenc.Value
encodeScoreboardNameEnum x = case x of
    ScoreboardName -> Jenc.string ""
    TS -> Jenc.string "T. s"
    RIhata -> Jenc.string "R. Ihata"
    DJones -> Jenc.string "D. Jones"
    BValentine -> Jenc.string "B. Valentine"

scorer : Jdec.Decoder Scorer
scorer =
    Jdec.succeed Scorer
        |> Jpipe.custom (optionalField "familyName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "familyNameInitial" (Jdec.map Just familyNameInitial) Nothing)
        |> Jpipe.custom (optionalField "firstName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "firstNameInitial" (Jdec.map Just firstNameInitial) Nothing)
        |> Jpipe.custom (optionalField "gt" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "internationalFamilyName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "internationalFamilyNameInitial" (Jdec.map Just familyNameInitial) Nothing)
        |> Jpipe.custom (optionalField "internationalFirstName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "internationalFirstNameInitial" (Jdec.map Just firstNameInitial) Nothing)
        |> Jpipe.custom (optionalField "name" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "per" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "perType" (Jdec.map Just perType) Nothing)
        |> Jpipe.custom (optionalField "player" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "pno" Jdec.int
        |> Jpipe.custom (optionalField "scoreboardName" (Jdec.map Just scoreboardNameEnum) Nothing)
        |> Jpipe.required "shirtNumber" Jdec.string
        |> Jpipe.custom (optionalField "summary" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "times" (Jdec.map Just (Jdec.list time )) Nothing)
        |> Jpipe.required "tno" Jdec.int
        |> Jpipe.custom (optionalField "tot" (Jdec.map Just Jdec.int) Nothing)

encodeScorer : Scorer -> Jenc.Value
encodeScorer x =
    Jenc.object
        [ ("familyName", makeNullableEncoder Jenc.string x.familyName)
        , ("familyNameInitial", makeNullableEncoder encodeFamilyNameInitial x.familyNameInitial)
        , ("firstName", makeNullableEncoder Jenc.string x.firstName)
        , ("firstNameInitial", makeNullableEncoder encodeFirstNameInitial x.firstNameInitial)
        , ("gt", makeNullableEncoder Jenc.string x.gt)
        , ("internationalFamilyName", makeNullableEncoder Jenc.string x.internationalFamilyName)
        , ("internationalFamilyNameInitial", makeNullableEncoder encodeFamilyNameInitial x.internationalFamilyNameInitial)
        , ("internationalFirstName", makeNullableEncoder Jenc.string x.internationalFirstName)
        , ("internationalFirstNameInitial", makeNullableEncoder encodeFirstNameInitial x.internationalFirstNameInitial)
        , ("name", makeNullableEncoder Jenc.string x.name)
        , ("per", makeNullableEncoder Jenc.int x.per)
        , ("perType", makeNullableEncoder encodePerType x.perType)
        , ("player", makeNullableEncoder Jenc.string x.player)
        , ("pno", Jenc.int x.pno)
        , ("scoreboardName", makeNullableEncoder encodeScoreboardNameEnum x.scoreboardName)
        , ("shirtNumber", Jenc.string x.shirtNumber)
        , ("summary", makeNullableEncoder Jenc.string x.summary)
        , ("times", makeNullableEncoder (Jenc.list encodeTime) x.times)
        , ("tno", Jenc.int x.tno)
        , ("tot", makeNullableEncoder Jenc.int x.tot)
        ]

time : Jdec.Decoder Time
time =
    Jdec.succeed Time
        |> Jpipe.required "gt" Jdec.string
        |> Jpipe.required "per" Jdec.int
        |> Jpipe.required "perType" perType

encodeTime : Time -> Jenc.Value
encodeTime x =
    Jenc.object
        [ ("gt", Jenc.string x.gt)
        , ("per", Jenc.int x.per)
        , ("perType", encodePerType x.perType)
        ]

tm : Jdec.Decoder Tm
tm =
    Jdec.succeed Tm
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "codeInternational" Jdec.string
        |> Jpipe.required "fouls" Jdec.int
        |> Jpipe.required "full_score" Jdec.int
        |> Jpipe.required "lds" lds
        |> Jpipe.required "logo" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "nameInternational" Jdec.string
        |> Jpipe.required "p1_score" Jdec.int
        |> Jpipe.required "p2_score" Jdec.int
        |> Jpipe.required "p3_score" Jdec.int
        |> Jpipe.required "p4_score" Jdec.int
        |> Jpipe.required "pl" (Jdec.dict pl)
        |> Jpipe.required "score" Jdec.int
        |> Jpipe.required "scoring" (Jdec.list scorer )
        |> Jpipe.required "shortName" Jdec.string
        |> Jpipe.required "shortNameInternational" Jdec.string
        |> Jpipe.required "shot" (Jdec.list shot )
        |> Jpipe.required "timeouts" Jdec.int
        |> Jpipe.required "tot_eff_1" Jdec.int
        |> Jpipe.required "tot_eff_2" Jdec.int
        |> Jpipe.required "tot_eff_3" Jdec.float
        |> Jpipe.required "tot_eff_4" Jdec.int
        |> Jpipe.required "tot_eff_5" Jdec.int
        |> Jpipe.required "tot_eff_6" Jdec.int
        |> Jpipe.required "tot_eff_7" Jdec.int
        |> Jpipe.required "tot_sAssists" Jdec.int
        |> Jpipe.required "tot_sBenchPoints" Jdec.int
        |> Jpipe.required "tot_sBiggestLead" Jdec.int
        |> Jpipe.required "tot_sBiggestScoringRun" Jdec.int
        |> Jpipe.required "tot_sBlocks" Jdec.int
        |> Jpipe.required "tot_sBlocksReceived" Jdec.int
        |> Jpipe.required "tot_sFieldGoalsAttempted" Jdec.int
        |> Jpipe.required "tot_sFieldGoalsMade" Jdec.int
        |> Jpipe.required "tot_sFieldGoalsPercentage" Jdec.int
        |> Jpipe.required "tot_sFoulsOn" Jdec.int
        |> Jpipe.required "tot_sFoulsPersonal" Jdec.int
        |> Jpipe.required "tot_sFoulsTeam" Jdec.int
        |> Jpipe.required "tot_sFreeThrowsAttempted" Jdec.int
        |> Jpipe.required "tot_sFreeThrowsMade" Jdec.int
        |> Jpipe.required "tot_sFreeThrowsPercentage" Jdec.int
        |> Jpipe.required "tot_sLeadChanges" Jdec.int
        |> Jpipe.required "tot_sMinutes" Jdec.int
        |> Jpipe.required "tot_sPoints" Jdec.int
        |> Jpipe.required "tot_sPointsFastBreak" Jdec.int
        |> Jpipe.required "tot_sPointsFromTurnovers" Jdec.int
        |> Jpipe.required "tot_sPointsInThePaint" Jdec.int
        |> Jpipe.required "tot_sPointsSecondChance" Jdec.int
        |> Jpipe.required "tot_sReboundsDefensive" Jdec.int
        |> Jpipe.required "tot_sReboundsOffensive" Jdec.int
        |> Jpipe.required "tot_sReboundsTeam" Jdec.int
        |> Jpipe.required "tot_sReboundsTeamDefensive" Jdec.int
        |> Jpipe.required "tot_sReboundsTeamOffensive" Jdec.int
        |> Jpipe.required "tot_sReboundsTotal" Jdec.int
        |> Jpipe.required "tot_sSteals" Jdec.int
        |> Jpipe.required "tot_sThreePointersAttempted" Jdec.int
        |> Jpipe.required "tot_sThreePointersMade" Jdec.int
        |> Jpipe.required "tot_sThreePointersPercentage" Jdec.int
        |> Jpipe.required "tot_sTimeLeading" Jdec.float
        |> Jpipe.required "tot_sTimesScoresLevel" Jdec.int
        |> Jpipe.required "tot_sTurnovers" Jdec.int
        |> Jpipe.required "tot_sTurnoversTeam" Jdec.int
        |> Jpipe.required "tot_sTwoPointersAttempted" Jdec.int
        |> Jpipe.required "tot_sTwoPointersMade" Jdec.int
        |> Jpipe.required "tot_sTwoPointersPercentage" Jdec.int

encodeTm : Tm -> Jenc.Value
encodeTm x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("codeInternational", Jenc.string x.codeInternational)
        , ("fouls", Jenc.int x.fouls)
        , ("full_score", Jenc.int x.fullScore)
        , ("lds", encodeLds x.lds)
        , ("logo", Jenc.string x.logo)
        , ("name", Jenc.string x.name)
        , ("nameInternational", Jenc.string x.nameInternational)
        , ("p1_score", Jenc.int x.p1Score)
        , ("p2_score", Jenc.int x.p2Score)
        , ("p3_score", Jenc.int x.p3Score)
        , ("p4_score", Jenc.int x.p4Score)
        , ("pl", Jenc.dict identity encodePl x.pl)
        , ("score", Jenc.int x.score)
        , ("scoring", Jenc.list encodeScorer x.scoring)
        , ("shortName", Jenc.string x.shortName)
        , ("shortNameInternational", Jenc.string x.shortNameInternational)
        , ("shot", Jenc.list encodeShot x.shot)
        , ("timeouts", Jenc.int x.timeouts)
        , ("tot_eff_1", Jenc.int x.totEFF1)
        , ("tot_eff_2", Jenc.int x.totEFF2)
        , ("tot_eff_3", Jenc.float x.totEFF3)
        , ("tot_eff_4", Jenc.int x.totEFF4)
        , ("tot_eff_5", Jenc.int x.totEFF5)
        , ("tot_eff_6", Jenc.int x.totEFF6)
        , ("tot_eff_7", Jenc.int x.totEFF7)
        , ("tot_sAssists", Jenc.int x.totSAssists)
        , ("tot_sBenchPoints", Jenc.int x.totSBenchPoints)
        , ("tot_sBiggestLead", Jenc.int x.totSBiggestLead)
        , ("tot_sBiggestScoringRun", Jenc.int x.totSBiggestScoringRun)
        , ("tot_sBlocks", Jenc.int x.totSBlocks)
        , ("tot_sBlocksReceived", Jenc.int x.totSBlocksReceived)
        , ("tot_sFieldGoalsAttempted", Jenc.int x.totSFieldGoalsAttempted)
        , ("tot_sFieldGoalsMade", Jenc.int x.totSFieldGoalsMade)
        , ("tot_sFieldGoalsPercentage", Jenc.int x.totSFieldGoalsPercentage)
        , ("tot_sFoulsOn", Jenc.int x.totSFoulsOn)
        , ("tot_sFoulsPersonal", Jenc.int x.totSFoulsPersonal)
        , ("tot_sFoulsTeam", Jenc.int x.totSFoulsTeam)
        , ("tot_sFreeThrowsAttempted", Jenc.int x.totSFreeThrowsAttempted)
        , ("tot_sFreeThrowsMade", Jenc.int x.totSFreeThrowsMade)
        , ("tot_sFreeThrowsPercentage", Jenc.int x.totSFreeThrowsPercentage)
        , ("tot_sLeadChanges", Jenc.int x.totSLeadChanges)
        , ("tot_sMinutes", Jenc.int x.totSMinutes)
        , ("tot_sPoints", Jenc.int x.totSPoints)
        , ("tot_sPointsFastBreak", Jenc.int x.totSPointsFastBreak)
        , ("tot_sPointsFromTurnovers", Jenc.int x.totSPointsFromTurnovers)
        , ("tot_sPointsInThePaint", Jenc.int x.totSPointsInThePaint)
        , ("tot_sPointsSecondChance", Jenc.int x.totSPointsSecondChance)
        , ("tot_sReboundsDefensive", Jenc.int x.totSReboundsDefensive)
        , ("tot_sReboundsOffensive", Jenc.int x.totSReboundsOffensive)
        , ("tot_sReboundsTeam", Jenc.int x.totSReboundsTeam)
        , ("tot_sReboundsTeamDefensive", Jenc.int x.totSReboundsTeamDefensive)
        , ("tot_sReboundsTeamOffensive", Jenc.int x.totSReboundsTeamOffensive)
        , ("tot_sReboundsTotal", Jenc.int x.totSReboundsTotal)
        , ("tot_sSteals", Jenc.int x.totSSteals)
        , ("tot_sThreePointersAttempted", Jenc.int x.totSThreePointersAttempted)
        , ("tot_sThreePointersMade", Jenc.int x.totSThreePointersMade)
        , ("tot_sThreePointersPercentage", Jenc.int x.totSThreePointersPercentage)
        , ("tot_sTimeLeading", Jenc.float x.totSTimeLeading)
        , ("tot_sTimesScoresLevel", Jenc.int x.totSTimesScoresLevel)
        , ("tot_sTurnovers", Jenc.int x.totSTurnovers)
        , ("tot_sTurnoversTeam", Jenc.int x.totSTurnoversTeam)
        , ("tot_sTwoPointersAttempted", Jenc.int x.totSTwoPointersAttempted)
        , ("tot_sTwoPointersMade", Jenc.int x.totSTwoPointersMade)
        , ("tot_sTwoPointersPercentage", Jenc.int x.totSTwoPointersPercentage)
        ]

lds : Jdec.Decoder Lds
lds =
    Jdec.succeed Lds
        |> Jpipe.required "sAssists" (Jdec.dict scorer)
        |> Jpipe.required "sBlocks" sBlocks
        |> Jpipe.required "sPoints" (Jdec.dict scorer)
        |> Jpipe.required "sReboundsTotal" (Jdec.dict scorer)
        |> Jpipe.required "sSteals" (Jdec.dict scorer)

encodeLds : Lds -> Jenc.Value
encodeLds x =
    Jenc.object
        [ ("sAssists", Jenc.dict identity encodeScorer x.sAssists)
        , ("sBlocks", encodeSBlocks x.sBlocks)
        , ("sPoints", Jenc.dict identity encodeScorer x.sPoints)
        , ("sReboundsTotal", Jenc.dict identity encodeScorer x.sReboundsTotal)
        , ("sSteals", Jenc.dict identity encodeScorer x.sSteals)
        ]

sBlocks : Jdec.Decoder SBlocks
sBlocks =
    Jdec.succeed SBlocks
        |> Jpipe.required "1" scorer

encodeSBlocks : SBlocks -> Jenc.Value
encodeSBlocks x =
    Jenc.object
        [ ("1", encodeScorer x.the1)
        ]

pl : Jdec.Decoder Pl
pl =
    Jdec.succeed Pl
        |> Jpipe.required "active" Jdec.int
        |> Jpipe.custom (optionalField "captain" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "comp" (Jdec.map Just comp) Nothing)
        |> Jpipe.required "eff_1" Jdec.int
        |> Jpipe.required "eff_2" Jdec.int
        |> Jpipe.required "eff_3" Jdec.float
        |> Jpipe.required "eff_4" Jdec.float
        |> Jpipe.required "eff_5" Jdec.int
        |> Jpipe.required "eff_6" Jdec.int
        |> Jpipe.required "eff_7" Jdec.int
        |> Jpipe.required "familyName" Jdec.string
        |> Jpipe.required "familyNameInitial" familyNameInitial
        |> Jpipe.required "firstName" Jdec.string
        |> Jpipe.required "firstNameInitial" firstNameInitial
        |> Jpipe.required "internationalFamilyName" Jdec.string
        |> Jpipe.required "internationalFamilyNameInitial" familyNameInitial
        |> Jpipe.required "internationalFirstName" Jdec.string
        |> Jpipe.required "internationalFirstNameInitial" firstNameInitial
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "playingPosition" Jdec.string
        |> Jpipe.required "sAssists" Jdec.int
        |> Jpipe.required "sBlocks" Jdec.int
        |> Jpipe.required "sBlocksReceived" Jdec.int
        |> Jpipe.required "sFieldGoalsAttempted" Jdec.int
        |> Jpipe.required "sFieldGoalsMade" Jdec.int
        |> Jpipe.required "sFieldGoalsPercentage" Jdec.int
        |> Jpipe.required "sFoulsOn" Jdec.int
        |> Jpipe.required "sFoulsPersonal" Jdec.int
        |> Jpipe.required "sFreeThrowsAttempted" Jdec.int
        |> Jpipe.required "sFreeThrowsMade" Jdec.int
        |> Jpipe.required "sFreeThrowsPercentage" Jdec.int
        |> Jpipe.required "sMinutes" sMinutes
        |> Jpipe.required "sPlusMinusPoints" Jdec.int
        |> Jpipe.required "sPoints" Jdec.int
        |> Jpipe.required "sPointsFastBreak" Jdec.int
        |> Jpipe.required "sPointsInThePaint" Jdec.int
        |> Jpipe.required "sPointsSecondChance" Jdec.int
        |> Jpipe.required "sReboundsDefensive" Jdec.int
        |> Jpipe.required "sReboundsOffensive" Jdec.int
        |> Jpipe.required "sReboundsTotal" Jdec.int
        |> Jpipe.required "sSteals" Jdec.int
        |> Jpipe.required "sThreePointersAttempted" Jdec.int
        |> Jpipe.required "sThreePointersMade" Jdec.int
        |> Jpipe.required "sThreePointersPercentage" Jdec.int
        |> Jpipe.required "sTurnovers" Jdec.int
        |> Jpipe.required "sTwoPointersAttempted" Jdec.int
        |> Jpipe.required "sTwoPointersMade" Jdec.int
        |> Jpipe.required "sTwoPointersPercentage" Jdec.int
        |> Jpipe.required "shirtNumber" Jdec.string
        |> Jpipe.required "starter" Jdec.int

encodePl : Pl -> Jenc.Value
encodePl x =
    Jenc.object
        [ ("active", Jenc.int x.active)
        , ("captain", makeNullableEncoder Jenc.int x.captain)
        , ("comp", makeNullableEncoder encodeComp x.comp)
        , ("eff_1", Jenc.int x.eff1)
        , ("eff_2", Jenc.int x.eff2)
        , ("eff_3", Jenc.float x.eff3)
        , ("eff_4", Jenc.float x.eff4)
        , ("eff_5", Jenc.int x.eff5)
        , ("eff_6", Jenc.int x.eff6)
        , ("eff_7", Jenc.int x.eff7)
        , ("familyName", Jenc.string x.familyName)
        , ("familyNameInitial", encodeFamilyNameInitial x.familyNameInitial)
        , ("firstName", Jenc.string x.firstName)
        , ("firstNameInitial", encodeFirstNameInitial x.firstNameInitial)
        , ("internationalFamilyName", Jenc.string x.internationalFamilyName)
        , ("internationalFamilyNameInitial", encodeFamilyNameInitial x.internationalFamilyNameInitial)
        , ("internationalFirstName", Jenc.string x.internationalFirstName)
        , ("internationalFirstNameInitial", encodeFirstNameInitial x.internationalFirstNameInitial)
        , ("name", Jenc.string x.name)
        , ("playingPosition", Jenc.string x.playingPosition)
        , ("sAssists", Jenc.int x.sAssists)
        , ("sBlocks", Jenc.int x.sBlocks)
        , ("sBlocksReceived", Jenc.int x.sBlocksReceived)
        , ("sFieldGoalsAttempted", Jenc.int x.sFieldGoalsAttempted)
        , ("sFieldGoalsMade", Jenc.int x.sFieldGoalsMade)
        , ("sFieldGoalsPercentage", Jenc.int x.sFieldGoalsPercentage)
        , ("sFoulsOn", Jenc.int x.sFoulsOn)
        , ("sFoulsPersonal", Jenc.int x.sFoulsPersonal)
        , ("sFreeThrowsAttempted", Jenc.int x.sFreeThrowsAttempted)
        , ("sFreeThrowsMade", Jenc.int x.sFreeThrowsMade)
        , ("sFreeThrowsPercentage", Jenc.int x.sFreeThrowsPercentage)
        , ("sMinutes", encodeSMinutes x.sMinutes)
        , ("sPlusMinusPoints", Jenc.int x.sPlusMinusPoints)
        , ("sPoints", Jenc.int x.sPoints)
        , ("sPointsFastBreak", Jenc.int x.sPointsFastBreak)
        , ("sPointsInThePaint", Jenc.int x.sPointsInThePaint)
        , ("sPointsSecondChance", Jenc.int x.sPointsSecondChance)
        , ("sReboundsDefensive", Jenc.int x.sReboundsDefensive)
        , ("sReboundsOffensive", Jenc.int x.sReboundsOffensive)
        , ("sReboundsTotal", Jenc.int x.sReboundsTotal)
        , ("sSteals", Jenc.int x.sSteals)
        , ("sThreePointersAttempted", Jenc.int x.sThreePointersAttempted)
        , ("sThreePointersMade", Jenc.int x.sThreePointersMade)
        , ("sThreePointersPercentage", Jenc.int x.sThreePointersPercentage)
        , ("sTurnovers", Jenc.int x.sTurnovers)
        , ("sTwoPointersAttempted", Jenc.int x.sTwoPointersAttempted)
        , ("sTwoPointersMade", Jenc.int x.sTwoPointersMade)
        , ("sTwoPointersPercentage", Jenc.int x.sTwoPointersPercentage)
        , ("shirtNumber", Jenc.string x.shirtNumber)
        , ("starter", Jenc.int x.starter)
        ]

comp : Jdec.Decoder Comp
comp =
    Jdec.succeed Comp
        |> Jpipe.required "sAssistsAverage" Jdec.float
        |> Jpipe.required "sMinutesAverage" Jdec.string
        |> Jpipe.required "sPointsAverage" Jdec.float
        |> Jpipe.required "sReboundsTotalAverage" Jdec.float

encodeComp : Comp -> Jenc.Value
encodeComp x =
    Jenc.object
        [ ("sAssistsAverage", Jenc.float x.sAssistsAverage)
        , ("sMinutesAverage", Jenc.string x.sMinutesAverage)
        , ("sPointsAverage", Jenc.float x.sPointsAverage)
        , ("sReboundsTotalAverage", Jenc.float x.sReboundsTotalAverage)
        ]

sMinutes : Jdec.Decoder SMinutes
sMinutes =
    Jdec.oneOf
        [ Jdec.map IntegerInSMinutes Jdec.int
        , Jdec.map StringInSMinutes Jdec.string
        ]

encodeSMinutes : SMinutes -> Jenc.Value
encodeSMinutes x = case x of
    IntegerInSMinutes y -> Jenc.int y
    StringInSMinutes y -> Jenc.string y

shot : Jdec.Decoder Shot
shot =
    Jdec.succeed Shot
        |> Jpipe.required "actionType" actionType
        |> Jpipe.required "p" Jdec.int
        |> Jpipe.required "per" Jdec.int
        |> Jpipe.required "perType" perType
        |> Jpipe.required "player" Jdec.string
        |> Jpipe.required "pno" Jdec.int
        |> Jpipe.required "shirtNumber" Jdec.string
        |> Jpipe.required "r" Jdec.int
        |> Jpipe.required "x" Jdec.int
        |> Jpipe.required "y" Jdec.int
        |> Jpipe.required "subType" subType
        |> Jpipe.required "tno" Jdec.int

encodeShot : Shot -> Jenc.Value
encodeShot x =
    Jenc.object
        [ ("actionType", encodeActionType x.actionType)
        , ("p", Jenc.int x.p)
        , ("per", Jenc.int x.per)
        , ("perType", encodePerType x.perType)
        , ("player", Jenc.string x.player)
        , ("pno", Jenc.int x.pno)
        , ("shirtNumber", Jenc.string x.shirtNumber)
        , ("r", Jenc.int x.shotR)
        , ("x", Jenc.int x.shotX)
        , ("y", Jenc.int x.shotY)
        , ("subType", encodeSubType x.subType)
        , ("tno", Jenc.int x.tno)
        ]

subType : Jdec.Decoder SubType
subType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "jumpshot" -> Jdec.succeed Jumpshot
                "layup" -> Jdec.succeed Layup
                "dunk" -> Jdec.succeed Dunk
                somethingElse -> Jdec.fail <| "Invalid SubType: " ++ somethingElse
        )

encodeSubType : SubType -> Jenc.Value
encodeSubType x = case x of
    Jumpshot -> Jenc.string "jumpshot"
    Layup -> Jenc.string "layup"
    Dunk -> Jenc.string "dunk"

totallds : Jdec.Decoder Totallds
totallds =
    Jdec.succeed Totallds
        |> Jpipe.required "sAssists" (Jdec.dict scorer)
        |> Jpipe.required "sBlocks" (Jdec.dict scorer)
        |> Jpipe.required "sPoints" (Jdec.dict scorer)
        |> Jpipe.required "sReboundsTotal" (Jdec.dict scorer)
        |> Jpipe.required "sSteals" (Jdec.dict scorer)

encodeTotallds : Totallds -> Jenc.Value
encodeTotallds x =
    Jenc.object
        [ ("sAssists", Jenc.dict identity encodeScorer x.sAssists)
        , ("sBlocks", Jenc.dict identity encodeScorer x.sBlocks)
        , ("sPoints", Jenc.dict identity encodeScorer x.sPoints)
        , ("sReboundsTotal", Jenc.dict identity encodeScorer x.sReboundsTotal)
        , ("sSteals", Jenc.dict identity encodeScorer x.sSteals)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
