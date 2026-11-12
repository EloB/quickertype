{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Othermatch (..)
    , Team (..)
    , Pbp (..)
    , Scorer (..)
    , Time (..)
    , Tm (..)
    , Lds (..)
    , SBlocks (..)
    , Pl (..)
    , Comp (..)
    , Shot (..)
    , Totallds (..)
    , LeaddatumEnum (..)
    , PerType (..)
    , ActionType (..)
    , FamilyNameInitial (..)
    , FirstNameInitial (..)
    , ScoreboardName (..)
    , SubType (..)
    , LeaddatumElement (..)
    , SMinutes (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { attendanceQuickType :: Int
    , clockQuickType :: Text
    , disableMatchQuickType :: Int
    , inOTQuickType :: Int
    , leaddataQuickType :: [([LeaddatumElement])]
    , officialsReferee1QuickType :: Text
    , officialsReferee2QuickType :: Text
    , officialsReferee3QuickType :: Text
    , othermatchesQuickType :: [Othermatch]
    , pbpQuickType :: [Pbp]
    , periodQuickType :: Int
    , periodLengthOVERTIMEQuickType :: Int
    , periodLengthREGULARQuickType :: Int
    , periodTypeQuickType :: PerType
    , periodsMaxQuickType :: Int
    , scorersQuickType :: HashMap Text ([Scorer])
    , timelineQuickType :: [Value]
    , tmQuickType :: HashMap Text Tm
    , totalTimeAddedQuickType :: Int
    , totalldsQuickType :: Totallds
    } deriving (Show)

data LeaddatumElement
    = EnumInLeaddatumElement LeaddatumEnum
    | IntegerInLeaddatumElement Int
    deriving (Show)

data LeaddatumEnum
    = PurpleLeaddatumEnum
    | P1LeaddatumEnum
    | P2LeaddatumEnum
    | P3LeaddatumEnum
    | P4LeaddatumEnum
    deriving (Show)

data Othermatch = Othermatch
    { clockOthermatch :: Text
    , competitionNameOthermatch :: Text
    , othermatchIDOthermatch :: Text
    , periodOthermatch :: Int
    , periodTypeOthermatch :: PerType
    , team1Othermatch :: Team
    , team1NameOthermatch :: Text
    , team1ScoreOthermatch :: Int
    , team2Othermatch :: Team
    , team2NameOthermatch :: Text
    , team2ScoreOthermatch :: Int
    } deriving (Show)

data PerType
    = REGULARPerType
    deriving (Show)

data Team = Team
    { teamCodeTeam :: Text
    , teamCodeInternationalTeam :: Text
    , teamNameTeam :: Text
    , teamNameInternationalTeam :: Text
    } deriving (Show)

data Pbp = Pbp
    { actionTypePbp :: ActionType
    , familyNamePbp :: Maybe Text
    , familyNameInitialPbp :: Maybe FamilyNameInitial
    , firstNamePbp :: Maybe Text
    , firstNameInitialPbp :: Maybe FirstNameInitial
    , gtPbp :: Text
    , internationalFamilyNamePbp :: Maybe Text
    , internationalFamilyNameInitialPbp :: Maybe FamilyNameInitial
    , internationalFirstNamePbp :: Maybe Text
    , internationalFirstNameInitialPbp :: Maybe FirstNameInitial
    , leadPbp :: Int
    , periodPbp :: Int
    , periodTypePbp :: PerType
    , playerPbp :: Text
    , pnoPbp :: Int
    , qualifierPbp :: Text
    , s1Pbp :: Int
    , s2Pbp :: Int
    , scoreboardNamePbp :: Maybe ScoreboardName
    , scoringPbp :: Int
    , shirtNumberPbp :: Text
    , subTypePbp :: Text
    , successPbp :: Int
    , tnoPbp :: Int
    } deriving (Show)

data ActionType
    = GameActionType
    | PeriodActionType
    | The3PtActionType
    | The2PtActionType
    | ReboundActionType
    | TimeoutActionType
    | FoulonActionType
    | FoulActionType
    | AssistActionType
    | SubstitutionActionType
    | FreethrowActionType
    | StealActionType
    | TurnoverActionType
    | BlockActionType
    | JumpballActionType
    deriving (Show)

data FamilyNameInitial
    = RFamilyNameInitial
    | MFamilyNameInitial
    | SFamilyNameInitial
    | CFamilyNameInitial
    | OFamilyNameInitial
    | WFamilyNameInitial
    | AFamilyNameInitial
    | PFamilyNameInitial
    | VFamilyNameInitial
    | IFamilyNameInitial
    | JFamilyNameInitial
    | PurpleSFamilyNameInitial
    | HFamilyNameInitial
    | BFamilyNameInitial
    deriving (Show)

data FirstNameInitial
    = DFirstNameInitial
    | JFirstNameInitial
    | TFirstNameInitial
    | CFirstNameInitial
    | OFirstNameInitial
    | HFirstNameInitial
    | LFirstNameInitial
    | AFirstNameInitial
    | KFirstNameInitial
    | RFirstNameInitial
    | BFirstNameInitial
    | NFirstNameInitial
    deriving (Show)

data ScoreboardName
    = PurpleScoreboardName
    | TSScoreboardName
    | RIhataScoreboardName
    | DJonesScoreboardName
    | BValentineScoreboardName
    deriving (Show)

data Scorer = Scorer
    { familyNameScorer :: Maybe Text
    , familyNameInitialScorer :: Maybe FamilyNameInitial
    , firstNameScorer :: Maybe Text
    , firstNameInitialScorer :: Maybe FirstNameInitial
    , gtScorer :: Maybe Text
    , internationalFamilyNameScorer :: Maybe Text
    , internationalFamilyNameInitialScorer :: Maybe FamilyNameInitial
    , internationalFirstNameScorer :: Maybe Text
    , internationalFirstNameInitialScorer :: Maybe FirstNameInitial
    , nameScorer :: Maybe Text
    , perScorer :: Maybe Int
    , perTypeScorer :: Maybe PerType
    , playerScorer :: Maybe Text
    , pnoScorer :: Int
    , scoreboardNameScorer :: Maybe ScoreboardName
    , shirtNumberScorer :: Text
    , summaryScorer :: Maybe Text
    , timesScorer :: Maybe ([Time])
    , tnoScorer :: Int
    , totScorer :: Maybe Int
    } deriving (Show)

data Time = Time
    { gtTime :: Text
    , perTime :: Int
    , perTypeTime :: PerType
    } deriving (Show)

data Tm = Tm
    { codeTm :: Text
    , codeInternationalTm :: Text
    , foulsTm :: Int
    , fullScoreTm :: Int
    , ldsTm :: Lds
    , logoTm :: Text
    , nameTm :: Text
    , nameInternationalTm :: Text
    , p1ScoreTm :: Int
    , p2ScoreTm :: Int
    , p3ScoreTm :: Int
    , p4ScoreTm :: Int
    , plTm :: HashMap Text Pl
    , scoreTm :: Int
    , scoringTm :: [Scorer]
    , shortNameTm :: Text
    , shortNameInternationalTm :: Text
    , shotTm :: [Shot]
    , timeoutsTm :: Int
    , totEFF1Tm :: Int
    , totEFF2Tm :: Int
    , totEFF3Tm :: Double
    , totEFF4Tm :: Int
    , totEFF5Tm :: Int
    , totEFF6Tm :: Int
    , totEFF7Tm :: Int
    , totSAssistsTm :: Int
    , totSBenchPointsTm :: Int
    , totSBiggestLeadTm :: Int
    , totSBiggestScoringRunTm :: Int
    , totSBlocksTm :: Int
    , totSBlocksReceivedTm :: Int
    , totSFieldGoalsAttemptedTm :: Int
    , totSFieldGoalsMadeTm :: Int
    , totSFieldGoalsPercentageTm :: Int
    , totSFoulsOnTm :: Int
    , totSFoulsPersonalTm :: Int
    , totSFoulsTeamTm :: Int
    , totSFreeThrowsAttemptedTm :: Int
    , totSFreeThrowsMadeTm :: Int
    , totSFreeThrowsPercentageTm :: Int
    , totSLeadChangesTm :: Int
    , totSMinutesTm :: Int
    , totSPointsTm :: Int
    , totSPointsFastBreakTm :: Int
    , totSPointsFromTurnoversTm :: Int
    , totSPointsInThePaintTm :: Int
    , totSPointsSecondChanceTm :: Int
    , totSReboundsDefensiveTm :: Int
    , totSReboundsOffensiveTm :: Int
    , totSReboundsTeamTm :: Int
    , totSReboundsTeamDefensiveTm :: Int
    , totSReboundsTeamOffensiveTm :: Int
    , totSReboundsTotalTm :: Int
    , totSStealsTm :: Int
    , totSThreePointersAttemptedTm :: Int
    , totSThreePointersMadeTm :: Int
    , totSThreePointersPercentageTm :: Int
    , totSTimeLeadingTm :: Double
    , totSTimesScoresLevelTm :: Int
    , totSTurnoversTm :: Int
    , totSTurnoversTeamTm :: Int
    , totSTwoPointersAttemptedTm :: Int
    , totSTwoPointersMadeTm :: Int
    , totSTwoPointersPercentageTm :: Int
    } deriving (Show)

data Lds = Lds
    { sAssistsLds :: HashMap Text Scorer
    , sBlocksLds :: SBlocks
    , sPointsLds :: HashMap Text Scorer
    , sReboundsTotalLds :: HashMap Text Scorer
    , sStealsLds :: HashMap Text Scorer
    } deriving (Show)

data SBlocks = SBlocks
    { the1SBlocks :: Scorer
    } deriving (Show)

data Pl = Pl
    { activePl :: Int
    , captainPl :: Maybe Int
    , compPl :: Maybe Comp
    , eff1Pl :: Int
    , eff2Pl :: Int
    , eff3Pl :: Double
    , eff4Pl :: Double
    , eff5Pl :: Int
    , eff6Pl :: Int
    , eff7Pl :: Int
    , familyNamePl :: Text
    , familyNameInitialPl :: FamilyNameInitial
    , firstNamePl :: Text
    , firstNameInitialPl :: FirstNameInitial
    , internationalFamilyNamePl :: Text
    , internationalFamilyNameInitialPl :: FamilyNameInitial
    , internationalFirstNamePl :: Text
    , internationalFirstNameInitialPl :: FirstNameInitial
    , namePl :: Text
    , playingPositionPl :: Text
    , sAssistsPl :: Int
    , sBlocksPl :: Int
    , sBlocksReceivedPl :: Int
    , sFieldGoalsAttemptedPl :: Int
    , sFieldGoalsMadePl :: Int
    , sFieldGoalsPercentagePl :: Int
    , sFoulsOnPl :: Int
    , sFoulsPersonalPl :: Int
    , sFreeThrowsAttemptedPl :: Int
    , sFreeThrowsMadePl :: Int
    , sFreeThrowsPercentagePl :: Int
    , sMinutesPl :: SMinutes
    , sPlusMinusPointsPl :: Int
    , sPointsPl :: Int
    , sPointsFastBreakPl :: Int
    , sPointsInThePaintPl :: Int
    , sPointsSecondChancePl :: Int
    , sReboundsDefensivePl :: Int
    , sReboundsOffensivePl :: Int
    , sReboundsTotalPl :: Int
    , sStealsPl :: Int
    , sThreePointersAttemptedPl :: Int
    , sThreePointersMadePl :: Int
    , sThreePointersPercentagePl :: Int
    , sTurnoversPl :: Int
    , sTwoPointersAttemptedPl :: Int
    , sTwoPointersMadePl :: Int
    , sTwoPointersPercentagePl :: Int
    , shirtNumberPl :: Text
    , starterPl :: Int
    } deriving (Show)

data Comp = Comp
    { sAssistsAverageComp :: Double
    , sMinutesAverageComp :: Text
    , sPointsAverageComp :: Double
    , sReboundsTotalAverageComp :: Double
    } deriving (Show)

data SMinutes
    = IntegerInSMinutes Int
    | StringInSMinutes Text
    deriving (Show)

data Shot = Shot
    { actionTypeShot :: ActionType
    , pShot :: Int
    , perShot :: Int
    , perTypeShot :: PerType
    , playerShot :: Text
    , pnoShot :: Int
    , rShot :: Int
    , shirtNumberShot :: Text
    , subTypeShot :: SubType
    , tnoShot :: Int
    , xShot :: Int
    , yShot :: Int
    } deriving (Show)

data SubType
    = JumpshotSubType
    | LayupSubType
    | DunkSubType
    deriving (Show)

data Totallds = Totallds
    { sAssistsTotallds :: HashMap Text Scorer
    , sBlocksTotallds :: HashMap Text Scorer
    , sPointsTotallds :: HashMap Text Scorer
    , sReboundsTotalTotallds :: HashMap Text Scorer
    , sStealsTotallds :: HashMap Text Scorer
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType attendanceQuickType clockQuickType disableMatchQuickType inOTQuickType leaddataQuickType officialsReferee1QuickType officialsReferee2QuickType officialsReferee3QuickType othermatchesQuickType pbpQuickType periodQuickType periodLengthOVERTIMEQuickType periodLengthREGULARQuickType periodTypeQuickType periodsMaxQuickType scorersQuickType timelineQuickType tmQuickType totalTimeAddedQuickType totalldsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "attendance" .= attendanceQuickType
        , Just $ "clock" .= clockQuickType
        , Just $ "disableMatch" .= disableMatchQuickType
        , Just $ "inOT" .= inOTQuickType
        , Just $ "leaddata" .= leaddataQuickType
        , Just $ "officials_referee1" .= officialsReferee1QuickType
        , Just $ "officials_referee2" .= officialsReferee2QuickType
        , Just $ "officials_referee3" .= officialsReferee3QuickType
        , Just $ "othermatches" .= othermatchesQuickType
        , Just $ "pbp" .= pbpQuickType
        , Just $ "period" .= periodQuickType
        , Just $ "periodLengthOVERTIME" .= periodLengthOVERTIMEQuickType
        , Just $ "periodLengthREGULAR" .= periodLengthREGULARQuickType
        , Just $ "periodType" .= periodTypeQuickType
        , Just $ "periodsMax" .= periodsMaxQuickType
        , Just $ "scorers" .= scorersQuickType
        , Just $ "timeline" .= timelineQuickType
        , Just $ "tm" .= tmQuickType
        , Just $ "totalTimeAdded" .= totalTimeAddedQuickType
        , Just $ "totallds" .= totalldsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "attendance"
        <*> v .: "clock"
        <*> v .: "disableMatch"
        <*> v .: "inOT"
        <*> v .: "leaddata"
        <*> v .: "officials_referee1"
        <*> v .: "officials_referee2"
        <*> v .: "officials_referee3"
        <*> v .: "othermatches"
        <*> v .: "pbp"
        <*> v .: "period"
        <*> v .: "periodLengthOVERTIME"
        <*> v .: "periodLengthREGULAR"
        <*> v .: "periodType"
        <*> v .: "periodsMax"
        <*> v .: "scorers"
        <*> v .: "timeline"
        <*> v .: "tm"
        <*> v .: "totalTimeAdded"
        <*> v .: "totallds"

instance ToJSON LeaddatumElement where
    toJSON (EnumInLeaddatumElement x) = toJSON x
    toJSON (IntegerInLeaddatumElement x) = toJSON x

instance FromJSON LeaddatumElement where
    parseJSON xs@(String _) = (fmap EnumInLeaddatumElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap IntegerInLeaddatumElement . parseJSON) xs

instance ToJSON LeaddatumEnum where
    toJSON PurpleLeaddatumEnum = ""
    toJSON P1LeaddatumEnum = "P1"
    toJSON P2LeaddatumEnum = "P2"
    toJSON P3LeaddatumEnum = "P3"
    toJSON P4LeaddatumEnum = "P4"

instance FromJSON LeaddatumEnum where
    parseJSON = withText "LeaddatumEnum" parseText
        where
            parseText "" = return PurpleLeaddatumEnum
            parseText "P1" = return P1LeaddatumEnum
            parseText "P2" = return P2LeaddatumEnum
            parseText "P3" = return P3LeaddatumEnum
            parseText "P4" = return P4LeaddatumEnum

instance ToJSON Othermatch where
    toJSON (Othermatch clockOthermatch competitionNameOthermatch othermatchIDOthermatch periodOthermatch periodTypeOthermatch team1Othermatch team1NameOthermatch team1ScoreOthermatch team2Othermatch team2NameOthermatch team2ScoreOthermatch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "clock" .= clockOthermatch
        , Just $ "competitionName" .= competitionNameOthermatch
        , Just $ "id" .= othermatchIDOthermatch
        , Just $ "period" .= periodOthermatch
        , Just $ "periodType" .= periodTypeOthermatch
        , Just $ "team1" .= team1Othermatch
        , Just $ "team1Name" .= team1NameOthermatch
        , Just $ "team1Score" .= team1ScoreOthermatch
        , Just $ "team2" .= team2Othermatch
        , Just $ "team2Name" .= team2NameOthermatch
        , Just $ "team2Score" .= team2ScoreOthermatch
        ]

instance FromJSON Othermatch where
    parseJSON (Object v) = Othermatch
        <$> v .: "clock"
        <*> v .: "competitionName"
        <*> v .: "id"
        <*> v .: "period"
        <*> v .: "periodType"
        <*> v .: "team1"
        <*> v .: "team1Name"
        <*> v .: "team1Score"
        <*> v .: "team2"
        <*> v .: "team2Name"
        <*> v .: "team2Score"

instance ToJSON PerType where
    toJSON REGULARPerType = "REGULAR"

instance FromJSON PerType where
    parseJSON = withText "PerType" parseText
        where
            parseText "REGULAR" = return REGULARPerType

instance ToJSON Team where
    toJSON (Team teamCodeTeam teamCodeInternationalTeam teamNameTeam teamNameInternationalTeam) =
        object $ foldMap (maybe [] pure)
        [ Just $ "teamCode" .= teamCodeTeam
        , Just $ "teamCodeInternational" .= teamCodeInternationalTeam
        , Just $ "teamName" .= teamNameTeam
        , Just $ "teamNameInternational" .= teamNameInternationalTeam
        ]

instance FromJSON Team where
    parseJSON (Object v) = Team
        <$> v .: "teamCode"
        <*> v .: "teamCodeInternational"
        <*> v .: "teamName"
        <*> v .: "teamNameInternational"

instance ToJSON Pbp where
    toJSON (Pbp actionTypePbp familyNamePbp familyNameInitialPbp firstNamePbp firstNameInitialPbp gtPbp internationalFamilyNamePbp internationalFamilyNameInitialPbp internationalFirstNamePbp internationalFirstNameInitialPbp leadPbp periodPbp periodTypePbp playerPbp pnoPbp qualifierPbp s1Pbp s2Pbp scoreboardNamePbp scoringPbp shirtNumberPbp subTypePbp successPbp tnoPbp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "actionType" .= actionTypePbp
        , ("familyName" .=) <$> familyNamePbp
        , ("familyNameInitial" .=) <$> familyNameInitialPbp
        , ("firstName" .=) <$> firstNamePbp
        , ("firstNameInitial" .=) <$> firstNameInitialPbp
        , Just $ "gt" .= gtPbp
        , ("internationalFamilyName" .=) <$> internationalFamilyNamePbp
        , ("internationalFamilyNameInitial" .=) <$> internationalFamilyNameInitialPbp
        , ("internationalFirstName" .=) <$> internationalFirstNamePbp
        , ("internationalFirstNameInitial" .=) <$> internationalFirstNameInitialPbp
        , Just $ "lead" .= leadPbp
        , Just $ "period" .= periodPbp
        , Just $ "periodType" .= periodTypePbp
        , Just $ "player" .= playerPbp
        , Just $ "pno" .= pnoPbp
        , Just $ "qualifier" .= qualifierPbp
        , Just $ "s1" .= s1Pbp
        , Just $ "s2" .= s2Pbp
        , ("scoreboardName" .=) <$> scoreboardNamePbp
        , Just $ "scoring" .= scoringPbp
        , Just $ "shirtNumber" .= shirtNumberPbp
        , Just $ "subType" .= subTypePbp
        , Just $ "success" .= successPbp
        , Just $ "tno" .= tnoPbp
        ]

instance FromJSON Pbp where
    parseJSON (Object v) = Pbp
        <$> v .: "actionType"
        <*> v .:! "familyName"
        <*> v .:! "familyNameInitial"
        <*> v .:! "firstName"
        <*> v .:! "firstNameInitial"
        <*> v .: "gt"
        <*> v .:! "internationalFamilyName"
        <*> v .:! "internationalFamilyNameInitial"
        <*> v .:! "internationalFirstName"
        <*> v .:! "internationalFirstNameInitial"
        <*> v .: "lead"
        <*> v .: "period"
        <*> v .: "periodType"
        <*> v .: "player"
        <*> v .: "pno"
        <*> v .: "qualifier"
        <*> v .: "s1"
        <*> v .: "s2"
        <*> v .:! "scoreboardName"
        <*> v .: "scoring"
        <*> v .: "shirtNumber"
        <*> v .: "subType"
        <*> v .: "success"
        <*> v .: "tno"

instance ToJSON ActionType where
    toJSON GameActionType = "game"
    toJSON PeriodActionType = "period"
    toJSON The3PtActionType = "3pt"
    toJSON The2PtActionType = "2pt"
    toJSON ReboundActionType = "rebound"
    toJSON TimeoutActionType = "timeout"
    toJSON FoulonActionType = "foulon"
    toJSON FoulActionType = "foul"
    toJSON AssistActionType = "assist"
    toJSON SubstitutionActionType = "substitution"
    toJSON FreethrowActionType = "freethrow"
    toJSON StealActionType = "steal"
    toJSON TurnoverActionType = "turnover"
    toJSON BlockActionType = "block"
    toJSON JumpballActionType = "jumpball"

instance FromJSON ActionType where
    parseJSON = withText "ActionType" parseText
        where
            parseText "game" = return GameActionType
            parseText "period" = return PeriodActionType
            parseText "3pt" = return The3PtActionType
            parseText "2pt" = return The2PtActionType
            parseText "rebound" = return ReboundActionType
            parseText "timeout" = return TimeoutActionType
            parseText "foulon" = return FoulonActionType
            parseText "foul" = return FoulActionType
            parseText "assist" = return AssistActionType
            parseText "substitution" = return SubstitutionActionType
            parseText "freethrow" = return FreethrowActionType
            parseText "steal" = return StealActionType
            parseText "turnover" = return TurnoverActionType
            parseText "block" = return BlockActionType
            parseText "jumpball" = return JumpballActionType

instance ToJSON FamilyNameInitial where
    toJSON RFamilyNameInitial = "R"
    toJSON MFamilyNameInitial = "M"
    toJSON SFamilyNameInitial = "s"
    toJSON CFamilyNameInitial = "C"
    toJSON OFamilyNameInitial = "O"
    toJSON WFamilyNameInitial = "W"
    toJSON AFamilyNameInitial = "A"
    toJSON PFamilyNameInitial = "P"
    toJSON VFamilyNameInitial = "V"
    toJSON IFamilyNameInitial = "I"
    toJSON JFamilyNameInitial = "J"
    toJSON PurpleSFamilyNameInitial = "S"
    toJSON HFamilyNameInitial = "H"
    toJSON BFamilyNameInitial = "B"

instance FromJSON FamilyNameInitial where
    parseJSON = withText "FamilyNameInitial" parseText
        where
            parseText "R" = return RFamilyNameInitial
            parseText "M" = return MFamilyNameInitial
            parseText "s" = return SFamilyNameInitial
            parseText "C" = return CFamilyNameInitial
            parseText "O" = return OFamilyNameInitial
            parseText "W" = return WFamilyNameInitial
            parseText "A" = return AFamilyNameInitial
            parseText "P" = return PFamilyNameInitial
            parseText "V" = return VFamilyNameInitial
            parseText "I" = return IFamilyNameInitial
            parseText "J" = return JFamilyNameInitial
            parseText "S" = return PurpleSFamilyNameInitial
            parseText "H" = return HFamilyNameInitial
            parseText "B" = return BFamilyNameInitial

instance ToJSON FirstNameInitial where
    toJSON DFirstNameInitial = "D"
    toJSON JFirstNameInitial = "J"
    toJSON TFirstNameInitial = "T"
    toJSON CFirstNameInitial = "C"
    toJSON OFirstNameInitial = "O"
    toJSON HFirstNameInitial = "H"
    toJSON LFirstNameInitial = "L"
    toJSON AFirstNameInitial = "A"
    toJSON KFirstNameInitial = "K"
    toJSON RFirstNameInitial = "R"
    toJSON BFirstNameInitial = "B"
    toJSON NFirstNameInitial = "N"

instance FromJSON FirstNameInitial where
    parseJSON = withText "FirstNameInitial" parseText
        where
            parseText "D" = return DFirstNameInitial
            parseText "J" = return JFirstNameInitial
            parseText "T" = return TFirstNameInitial
            parseText "C" = return CFirstNameInitial
            parseText "O" = return OFirstNameInitial
            parseText "H" = return HFirstNameInitial
            parseText "L" = return LFirstNameInitial
            parseText "A" = return AFirstNameInitial
            parseText "K" = return KFirstNameInitial
            parseText "R" = return RFirstNameInitial
            parseText "B" = return BFirstNameInitial
            parseText "N" = return NFirstNameInitial

instance ToJSON ScoreboardName where
    toJSON PurpleScoreboardName = ""
    toJSON TSScoreboardName = "T. s"
    toJSON RIhataScoreboardName = "R. Ihata"
    toJSON DJonesScoreboardName = "D. Jones"
    toJSON BValentineScoreboardName = "B. Valentine"

instance FromJSON ScoreboardName where
    parseJSON = withText "ScoreboardName" parseText
        where
            parseText "" = return PurpleScoreboardName
            parseText "T. s" = return TSScoreboardName
            parseText "R. Ihata" = return RIhataScoreboardName
            parseText "D. Jones" = return DJonesScoreboardName
            parseText "B. Valentine" = return BValentineScoreboardName

instance ToJSON Scorer where
    toJSON (Scorer familyNameScorer familyNameInitialScorer firstNameScorer firstNameInitialScorer gtScorer internationalFamilyNameScorer internationalFamilyNameInitialScorer internationalFirstNameScorer internationalFirstNameInitialScorer nameScorer perScorer perTypeScorer playerScorer pnoScorer scoreboardNameScorer shirtNumberScorer summaryScorer timesScorer tnoScorer totScorer) =
        object $ foldMap (maybe [] pure)
        [ ("familyName" .=) <$> familyNameScorer
        , ("familyNameInitial" .=) <$> familyNameInitialScorer
        , ("firstName" .=) <$> firstNameScorer
        , ("firstNameInitial" .=) <$> firstNameInitialScorer
        , ("gt" .=) <$> gtScorer
        , ("internationalFamilyName" .=) <$> internationalFamilyNameScorer
        , ("internationalFamilyNameInitial" .=) <$> internationalFamilyNameInitialScorer
        , ("internationalFirstName" .=) <$> internationalFirstNameScorer
        , ("internationalFirstNameInitial" .=) <$> internationalFirstNameInitialScorer
        , ("name" .=) <$> nameScorer
        , ("per" .=) <$> perScorer
        , ("perType" .=) <$> perTypeScorer
        , ("player" .=) <$> playerScorer
        , Just $ "pno" .= pnoScorer
        , ("scoreboardName" .=) <$> scoreboardNameScorer
        , Just $ "shirtNumber" .= shirtNumberScorer
        , ("summary" .=) <$> summaryScorer
        , ("times" .=) <$> timesScorer
        , Just $ "tno" .= tnoScorer
        , ("tot" .=) <$> totScorer
        ]

instance FromJSON Scorer where
    parseJSON (Object v) = Scorer
        <$> v .:! "familyName"
        <*> v .:! "familyNameInitial"
        <*> v .:! "firstName"
        <*> v .:! "firstNameInitial"
        <*> v .:! "gt"
        <*> v .:! "internationalFamilyName"
        <*> v .:! "internationalFamilyNameInitial"
        <*> v .:! "internationalFirstName"
        <*> v .:! "internationalFirstNameInitial"
        <*> v .:! "name"
        <*> v .:! "per"
        <*> v .:! "perType"
        <*> v .:! "player"
        <*> v .: "pno"
        <*> v .:! "scoreboardName"
        <*> v .: "shirtNumber"
        <*> v .:! "summary"
        <*> v .:! "times"
        <*> v .: "tno"
        <*> v .:! "tot"

instance ToJSON Time where
    toJSON (Time gtTime perTime perTypeTime) =
        object $ foldMap (maybe [] pure)
        [ Just $ "gt" .= gtTime
        , Just $ "per" .= perTime
        , Just $ "perType" .= perTypeTime
        ]

instance FromJSON Time where
    parseJSON (Object v) = Time
        <$> v .: "gt"
        <*> v .: "per"
        <*> v .: "perType"

instance ToJSON Tm where
    toJSON (Tm codeTm codeInternationalTm foulsTm fullScoreTm ldsTm logoTm nameTm nameInternationalTm p1ScoreTm p2ScoreTm p3ScoreTm p4ScoreTm plTm scoreTm scoringTm shortNameTm shortNameInternationalTm shotTm timeoutsTm totEFF1Tm totEFF2Tm totEFF3Tm totEFF4Tm totEFF5Tm totEFF6Tm totEFF7Tm totSAssistsTm totSBenchPointsTm totSBiggestLeadTm totSBiggestScoringRunTm totSBlocksTm totSBlocksReceivedTm totSFieldGoalsAttemptedTm totSFieldGoalsMadeTm totSFieldGoalsPercentageTm totSFoulsOnTm totSFoulsPersonalTm totSFoulsTeamTm totSFreeThrowsAttemptedTm totSFreeThrowsMadeTm totSFreeThrowsPercentageTm totSLeadChangesTm totSMinutesTm totSPointsTm totSPointsFastBreakTm totSPointsFromTurnoversTm totSPointsInThePaintTm totSPointsSecondChanceTm totSReboundsDefensiveTm totSReboundsOffensiveTm totSReboundsTeamTm totSReboundsTeamDefensiveTm totSReboundsTeamOffensiveTm totSReboundsTotalTm totSStealsTm totSThreePointersAttemptedTm totSThreePointersMadeTm totSThreePointersPercentageTm totSTimeLeadingTm totSTimesScoresLevelTm totSTurnoversTm totSTurnoversTeamTm totSTwoPointersAttemptedTm totSTwoPointersMadeTm totSTwoPointersPercentageTm) =
        object $ foldMap (maybe [] pure)
        [ Just $ "code" .= codeTm
        , Just $ "codeInternational" .= codeInternationalTm
        , Just $ "fouls" .= foulsTm
        , Just $ "full_score" .= fullScoreTm
        , Just $ "lds" .= ldsTm
        , Just $ "logo" .= logoTm
        , Just $ "name" .= nameTm
        , Just $ "nameInternational" .= nameInternationalTm
        , Just $ "p1_score" .= p1ScoreTm
        , Just $ "p2_score" .= p2ScoreTm
        , Just $ "p3_score" .= p3ScoreTm
        , Just $ "p4_score" .= p4ScoreTm
        , Just $ "pl" .= plTm
        , Just $ "score" .= scoreTm
        , Just $ "scoring" .= scoringTm
        , Just $ "shortName" .= shortNameTm
        , Just $ "shortNameInternational" .= shortNameInternationalTm
        , Just $ "shot" .= shotTm
        , Just $ "timeouts" .= timeoutsTm
        , Just $ "tot_eff_1" .= totEFF1Tm
        , Just $ "tot_eff_2" .= totEFF2Tm
        , Just $ "tot_eff_3" .= totEFF3Tm
        , Just $ "tot_eff_4" .= totEFF4Tm
        , Just $ "tot_eff_5" .= totEFF5Tm
        , Just $ "tot_eff_6" .= totEFF6Tm
        , Just $ "tot_eff_7" .= totEFF7Tm
        , Just $ "tot_sAssists" .= totSAssistsTm
        , Just $ "tot_sBenchPoints" .= totSBenchPointsTm
        , Just $ "tot_sBiggestLead" .= totSBiggestLeadTm
        , Just $ "tot_sBiggestScoringRun" .= totSBiggestScoringRunTm
        , Just $ "tot_sBlocks" .= totSBlocksTm
        , Just $ "tot_sBlocksReceived" .= totSBlocksReceivedTm
        , Just $ "tot_sFieldGoalsAttempted" .= totSFieldGoalsAttemptedTm
        , Just $ "tot_sFieldGoalsMade" .= totSFieldGoalsMadeTm
        , Just $ "tot_sFieldGoalsPercentage" .= totSFieldGoalsPercentageTm
        , Just $ "tot_sFoulsOn" .= totSFoulsOnTm
        , Just $ "tot_sFoulsPersonal" .= totSFoulsPersonalTm
        , Just $ "tot_sFoulsTeam" .= totSFoulsTeamTm
        , Just $ "tot_sFreeThrowsAttempted" .= totSFreeThrowsAttemptedTm
        , Just $ "tot_sFreeThrowsMade" .= totSFreeThrowsMadeTm
        , Just $ "tot_sFreeThrowsPercentage" .= totSFreeThrowsPercentageTm
        , Just $ "tot_sLeadChanges" .= totSLeadChangesTm
        , Just $ "tot_sMinutes" .= totSMinutesTm
        , Just $ "tot_sPoints" .= totSPointsTm
        , Just $ "tot_sPointsFastBreak" .= totSPointsFastBreakTm
        , Just $ "tot_sPointsFromTurnovers" .= totSPointsFromTurnoversTm
        , Just $ "tot_sPointsInThePaint" .= totSPointsInThePaintTm
        , Just $ "tot_sPointsSecondChance" .= totSPointsSecondChanceTm
        , Just $ "tot_sReboundsDefensive" .= totSReboundsDefensiveTm
        , Just $ "tot_sReboundsOffensive" .= totSReboundsOffensiveTm
        , Just $ "tot_sReboundsTeam" .= totSReboundsTeamTm
        , Just $ "tot_sReboundsTeamDefensive" .= totSReboundsTeamDefensiveTm
        , Just $ "tot_sReboundsTeamOffensive" .= totSReboundsTeamOffensiveTm
        , Just $ "tot_sReboundsTotal" .= totSReboundsTotalTm
        , Just $ "tot_sSteals" .= totSStealsTm
        , Just $ "tot_sThreePointersAttempted" .= totSThreePointersAttemptedTm
        , Just $ "tot_sThreePointersMade" .= totSThreePointersMadeTm
        , Just $ "tot_sThreePointersPercentage" .= totSThreePointersPercentageTm
        , Just $ "tot_sTimeLeading" .= totSTimeLeadingTm
        , Just $ "tot_sTimesScoresLevel" .= totSTimesScoresLevelTm
        , Just $ "tot_sTurnovers" .= totSTurnoversTm
        , Just $ "tot_sTurnoversTeam" .= totSTurnoversTeamTm
        , Just $ "tot_sTwoPointersAttempted" .= totSTwoPointersAttemptedTm
        , Just $ "tot_sTwoPointersMade" .= totSTwoPointersMadeTm
        , Just $ "tot_sTwoPointersPercentage" .= totSTwoPointersPercentageTm
        ]

instance FromJSON Tm where
    parseJSON (Object v) = Tm
        <$> v .: "code"
        <*> v .: "codeInternational"
        <*> v .: "fouls"
        <*> v .: "full_score"
        <*> v .: "lds"
        <*> v .: "logo"
        <*> v .: "name"
        <*> v .: "nameInternational"
        <*> v .: "p1_score"
        <*> v .: "p2_score"
        <*> v .: "p3_score"
        <*> v .: "p4_score"
        <*> v .: "pl"
        <*> v .: "score"
        <*> v .: "scoring"
        <*> v .: "shortName"
        <*> v .: "shortNameInternational"
        <*> v .: "shot"
        <*> v .: "timeouts"
        <*> v .: "tot_eff_1"
        <*> v .: "tot_eff_2"
        <*> v .: "tot_eff_3"
        <*> v .: "tot_eff_4"
        <*> v .: "tot_eff_5"
        <*> v .: "tot_eff_6"
        <*> v .: "tot_eff_7"
        <*> v .: "tot_sAssists"
        <*> v .: "tot_sBenchPoints"
        <*> v .: "tot_sBiggestLead"
        <*> v .: "tot_sBiggestScoringRun"
        <*> v .: "tot_sBlocks"
        <*> v .: "tot_sBlocksReceived"
        <*> v .: "tot_sFieldGoalsAttempted"
        <*> v .: "tot_sFieldGoalsMade"
        <*> v .: "tot_sFieldGoalsPercentage"
        <*> v .: "tot_sFoulsOn"
        <*> v .: "tot_sFoulsPersonal"
        <*> v .: "tot_sFoulsTeam"
        <*> v .: "tot_sFreeThrowsAttempted"
        <*> v .: "tot_sFreeThrowsMade"
        <*> v .: "tot_sFreeThrowsPercentage"
        <*> v .: "tot_sLeadChanges"
        <*> v .: "tot_sMinutes"
        <*> v .: "tot_sPoints"
        <*> v .: "tot_sPointsFastBreak"
        <*> v .: "tot_sPointsFromTurnovers"
        <*> v .: "tot_sPointsInThePaint"
        <*> v .: "tot_sPointsSecondChance"
        <*> v .: "tot_sReboundsDefensive"
        <*> v .: "tot_sReboundsOffensive"
        <*> v .: "tot_sReboundsTeam"
        <*> v .: "tot_sReboundsTeamDefensive"
        <*> v .: "tot_sReboundsTeamOffensive"
        <*> v .: "tot_sReboundsTotal"
        <*> v .: "tot_sSteals"
        <*> v .: "tot_sThreePointersAttempted"
        <*> v .: "tot_sThreePointersMade"
        <*> v .: "tot_sThreePointersPercentage"
        <*> v .: "tot_sTimeLeading"
        <*> v .: "tot_sTimesScoresLevel"
        <*> v .: "tot_sTurnovers"
        <*> v .: "tot_sTurnoversTeam"
        <*> v .: "tot_sTwoPointersAttempted"
        <*> v .: "tot_sTwoPointersMade"
        <*> v .: "tot_sTwoPointersPercentage"

instance ToJSON Lds where
    toJSON (Lds sAssistsLds sBlocksLds sPointsLds sReboundsTotalLds sStealsLds) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sAssists" .= sAssistsLds
        , Just $ "sBlocks" .= sBlocksLds
        , Just $ "sPoints" .= sPointsLds
        , Just $ "sReboundsTotal" .= sReboundsTotalLds
        , Just $ "sSteals" .= sStealsLds
        ]

instance FromJSON Lds where
    parseJSON (Object v) = Lds
        <$> v .: "sAssists"
        <*> v .: "sBlocks"
        <*> v .: "sPoints"
        <*> v .: "sReboundsTotal"
        <*> v .: "sSteals"

instance ToJSON SBlocks where
    toJSON (SBlocks the1SBlocks) =
        object $ foldMap (maybe [] pure)
        [ Just $ "1" .= the1SBlocks
        ]

instance FromJSON SBlocks where
    parseJSON (Object v) = SBlocks
        <$> v .: "1"

instance ToJSON Pl where
    toJSON (Pl activePl captainPl compPl eff1Pl eff2Pl eff3Pl eff4Pl eff5Pl eff6Pl eff7Pl familyNamePl familyNameInitialPl firstNamePl firstNameInitialPl internationalFamilyNamePl internationalFamilyNameInitialPl internationalFirstNamePl internationalFirstNameInitialPl namePl playingPositionPl sAssistsPl sBlocksPl sBlocksReceivedPl sFieldGoalsAttemptedPl sFieldGoalsMadePl sFieldGoalsPercentagePl sFoulsOnPl sFoulsPersonalPl sFreeThrowsAttemptedPl sFreeThrowsMadePl sFreeThrowsPercentagePl sMinutesPl sPlusMinusPointsPl sPointsPl sPointsFastBreakPl sPointsInThePaintPl sPointsSecondChancePl sReboundsDefensivePl sReboundsOffensivePl sReboundsTotalPl sStealsPl sThreePointersAttemptedPl sThreePointersMadePl sThreePointersPercentagePl sTurnoversPl sTwoPointersAttemptedPl sTwoPointersMadePl sTwoPointersPercentagePl shirtNumberPl starterPl) =
        object $ foldMap (maybe [] pure)
        [ Just $ "active" .= activePl
        , ("captain" .=) <$> captainPl
        , ("comp" .=) <$> compPl
        , Just $ "eff_1" .= eff1Pl
        , Just $ "eff_2" .= eff2Pl
        , Just $ "eff_3" .= eff3Pl
        , Just $ "eff_4" .= eff4Pl
        , Just $ "eff_5" .= eff5Pl
        , Just $ "eff_6" .= eff6Pl
        , Just $ "eff_7" .= eff7Pl
        , Just $ "familyName" .= familyNamePl
        , Just $ "familyNameInitial" .= familyNameInitialPl
        , Just $ "firstName" .= firstNamePl
        , Just $ "firstNameInitial" .= firstNameInitialPl
        , Just $ "internationalFamilyName" .= internationalFamilyNamePl
        , Just $ "internationalFamilyNameInitial" .= internationalFamilyNameInitialPl
        , Just $ "internationalFirstName" .= internationalFirstNamePl
        , Just $ "internationalFirstNameInitial" .= internationalFirstNameInitialPl
        , Just $ "name" .= namePl
        , Just $ "playingPosition" .= playingPositionPl
        , Just $ "sAssists" .= sAssistsPl
        , Just $ "sBlocks" .= sBlocksPl
        , Just $ "sBlocksReceived" .= sBlocksReceivedPl
        , Just $ "sFieldGoalsAttempted" .= sFieldGoalsAttemptedPl
        , Just $ "sFieldGoalsMade" .= sFieldGoalsMadePl
        , Just $ "sFieldGoalsPercentage" .= sFieldGoalsPercentagePl
        , Just $ "sFoulsOn" .= sFoulsOnPl
        , Just $ "sFoulsPersonal" .= sFoulsPersonalPl
        , Just $ "sFreeThrowsAttempted" .= sFreeThrowsAttemptedPl
        , Just $ "sFreeThrowsMade" .= sFreeThrowsMadePl
        , Just $ "sFreeThrowsPercentage" .= sFreeThrowsPercentagePl
        , Just $ "sMinutes" .= sMinutesPl
        , Just $ "sPlusMinusPoints" .= sPlusMinusPointsPl
        , Just $ "sPoints" .= sPointsPl
        , Just $ "sPointsFastBreak" .= sPointsFastBreakPl
        , Just $ "sPointsInThePaint" .= sPointsInThePaintPl
        , Just $ "sPointsSecondChance" .= sPointsSecondChancePl
        , Just $ "sReboundsDefensive" .= sReboundsDefensivePl
        , Just $ "sReboundsOffensive" .= sReboundsOffensivePl
        , Just $ "sReboundsTotal" .= sReboundsTotalPl
        , Just $ "sSteals" .= sStealsPl
        , Just $ "sThreePointersAttempted" .= sThreePointersAttemptedPl
        , Just $ "sThreePointersMade" .= sThreePointersMadePl
        , Just $ "sThreePointersPercentage" .= sThreePointersPercentagePl
        , Just $ "sTurnovers" .= sTurnoversPl
        , Just $ "sTwoPointersAttempted" .= sTwoPointersAttemptedPl
        , Just $ "sTwoPointersMade" .= sTwoPointersMadePl
        , Just $ "sTwoPointersPercentage" .= sTwoPointersPercentagePl
        , Just $ "shirtNumber" .= shirtNumberPl
        , Just $ "starter" .= starterPl
        ]

instance FromJSON Pl where
    parseJSON (Object v) = Pl
        <$> v .: "active"
        <*> v .:! "captain"
        <*> v .:! "comp"
        <*> v .: "eff_1"
        <*> v .: "eff_2"
        <*> v .: "eff_3"
        <*> v .: "eff_4"
        <*> v .: "eff_5"
        <*> v .: "eff_6"
        <*> v .: "eff_7"
        <*> v .: "familyName"
        <*> v .: "familyNameInitial"
        <*> v .: "firstName"
        <*> v .: "firstNameInitial"
        <*> v .: "internationalFamilyName"
        <*> v .: "internationalFamilyNameInitial"
        <*> v .: "internationalFirstName"
        <*> v .: "internationalFirstNameInitial"
        <*> v .: "name"
        <*> v .: "playingPosition"
        <*> v .: "sAssists"
        <*> v .: "sBlocks"
        <*> v .: "sBlocksReceived"
        <*> v .: "sFieldGoalsAttempted"
        <*> v .: "sFieldGoalsMade"
        <*> v .: "sFieldGoalsPercentage"
        <*> v .: "sFoulsOn"
        <*> v .: "sFoulsPersonal"
        <*> v .: "sFreeThrowsAttempted"
        <*> v .: "sFreeThrowsMade"
        <*> v .: "sFreeThrowsPercentage"
        <*> v .: "sMinutes"
        <*> v .: "sPlusMinusPoints"
        <*> v .: "sPoints"
        <*> v .: "sPointsFastBreak"
        <*> v .: "sPointsInThePaint"
        <*> v .: "sPointsSecondChance"
        <*> v .: "sReboundsDefensive"
        <*> v .: "sReboundsOffensive"
        <*> v .: "sReboundsTotal"
        <*> v .: "sSteals"
        <*> v .: "sThreePointersAttempted"
        <*> v .: "sThreePointersMade"
        <*> v .: "sThreePointersPercentage"
        <*> v .: "sTurnovers"
        <*> v .: "sTwoPointersAttempted"
        <*> v .: "sTwoPointersMade"
        <*> v .: "sTwoPointersPercentage"
        <*> v .: "shirtNumber"
        <*> v .: "starter"

instance ToJSON Comp where
    toJSON (Comp sAssistsAverageComp sMinutesAverageComp sPointsAverageComp sReboundsTotalAverageComp) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sAssistsAverage" .= sAssistsAverageComp
        , Just $ "sMinutesAverage" .= sMinutesAverageComp
        , Just $ "sPointsAverage" .= sPointsAverageComp
        , Just $ "sReboundsTotalAverage" .= sReboundsTotalAverageComp
        ]

instance FromJSON Comp where
    parseJSON (Object v) = Comp
        <$> v .: "sAssistsAverage"
        <*> v .: "sMinutesAverage"
        <*> v .: "sPointsAverage"
        <*> v .: "sReboundsTotalAverage"

instance ToJSON SMinutes where
    toJSON (IntegerInSMinutes x) = toJSON x
    toJSON (StringInSMinutes x) = toJSON x

instance FromJSON SMinutes where
    parseJSON xs@(Number _) = (fmap IntegerInSMinutes . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInSMinutes . parseJSON) xs

instance ToJSON Shot where
    toJSON (Shot actionTypeShot pShot perShot perTypeShot playerShot pnoShot rShot shirtNumberShot subTypeShot tnoShot xShot yShot) =
        object $ foldMap (maybe [] pure)
        [ Just $ "actionType" .= actionTypeShot
        , Just $ "p" .= pShot
        , Just $ "per" .= perShot
        , Just $ "perType" .= perTypeShot
        , Just $ "player" .= playerShot
        , Just $ "pno" .= pnoShot
        , Just $ "r" .= rShot
        , Just $ "shirtNumber" .= shirtNumberShot
        , Just $ "subType" .= subTypeShot
        , Just $ "tno" .= tnoShot
        , Just $ "x" .= xShot
        , Just $ "y" .= yShot
        ]

instance FromJSON Shot where
    parseJSON (Object v) = Shot
        <$> v .: "actionType"
        <*> v .: "p"
        <*> v .: "per"
        <*> v .: "perType"
        <*> v .: "player"
        <*> v .: "pno"
        <*> v .: "r"
        <*> v .: "shirtNumber"
        <*> v .: "subType"
        <*> v .: "tno"
        <*> v .: "x"
        <*> v .: "y"

instance ToJSON SubType where
    toJSON JumpshotSubType = "jumpshot"
    toJSON LayupSubType = "layup"
    toJSON DunkSubType = "dunk"

instance FromJSON SubType where
    parseJSON = withText "SubType" parseText
        where
            parseText "jumpshot" = return JumpshotSubType
            parseText "layup" = return LayupSubType
            parseText "dunk" = return DunkSubType

instance ToJSON Totallds where
    toJSON (Totallds sAssistsTotallds sBlocksTotallds sPointsTotallds sReboundsTotalTotallds sStealsTotallds) =
        object $ foldMap (maybe [] pure)
        [ Just $ "sAssists" .= sAssistsTotallds
        , Just $ "sBlocks" .= sBlocksTotallds
        , Just $ "sPoints" .= sPointsTotallds
        , Just $ "sReboundsTotal" .= sReboundsTotalTotallds
        , Just $ "sSteals" .= sStealsTotallds
        ]

instance FromJSON Totallds where
    parseJSON (Object v) = Totallds
        <$> v .: "sAssists"
        <*> v .: "sBlocks"
        <*> v .: "sPoints"
        <*> v .: "sReboundsTotal"
        <*> v .: "sSteals"
