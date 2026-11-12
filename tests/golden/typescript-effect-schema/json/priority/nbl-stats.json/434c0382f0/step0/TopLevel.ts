import * as S from "effect/Schema";


export const LeaddatumEnum = S.Literal(
    "",
    "P1",
    "P2",
    "P3",
    "P4",
);
export type LeaddatumEnum = S.Schema.Type<typeof LeaddatumEnum>;


export const PerType = S.Literal(
    "REGULAR",
);
export type PerType = S.Schema.Type<typeof PerType>;


export const ActionType = S.Literal(
    "game",
    "period",
    "3pt",
    "2pt",
    "rebound",
    "timeout",
    "foulon",
    "foul",
    "assist",
    "substitution",
    "freethrow",
    "steal",
    "turnover",
    "block",
    "jumpball",
);
export type ActionType = S.Schema.Type<typeof ActionType>;


export const FamilyNameInitial = S.Literal(
    "R",
    "M",
    "s",
    "C",
    "O",
    "W",
    "A",
    "P",
    "V",
    "I",
    "J",
    "S",
    "H",
    "B",
);
export type FamilyNameInitial = S.Schema.Type<typeof FamilyNameInitial>;


export const FirstNameInitial = S.Literal(
    "D",
    "J",
    "T",
    "C",
    "O",
    "H",
    "L",
    "A",
    "K",
    "R",
    "B",
    "N",
);
export type FirstNameInitial = S.Schema.Type<typeof FirstNameInitial>;


export const ScoreboardName = S.Literal(
    "",
    "T. s",
    "R. Ihata",
    "D. Jones",
    "B. Valentine",
);
export type ScoreboardName = S.Schema.Type<typeof ScoreboardName>;


export const SubType = S.Literal(
    "jumpshot",
    "layup",
    "dunk",
);
export type SubType = S.Schema.Type<typeof SubType>;

export class Shot extends S.Class<Shot>("Shot")({
    "actionType": ActionType,
    "p": S.Int,
    "per": S.Int,
    "perType": PerType,
    "player": S.String,
    "pno": S.Int,
    "r": S.Int,
    "shirtNumber": S.String,
    "subType": SubType,
    "tno": S.Int,
    "x": S.Int,
    "y": S.Int,
}) {}

export class Comp extends S.Class<Comp>("Comp")({
    "sAssistsAverage": S.Number,
    "sMinutesAverage": S.String,
    "sPointsAverage": S.Number,
    "sReboundsTotalAverage": S.Number,
}) {}

export class Pl extends S.Class<Pl>("Pl")({
    "active": S.Int,
    "captain": S.optional(S.Int),
    "comp": S.optional(Comp),
    "eff_1": S.Int,
    "eff_2": S.Int,
    "eff_3": S.Number,
    "eff_4": S.Number,
    "eff_5": S.Int,
    "eff_6": S.Int,
    "eff_7": S.Int,
    "familyName": S.String,
    "familyNameInitial": FamilyNameInitial,
    "firstName": S.String,
    "firstNameInitial": FirstNameInitial,
    "internationalFamilyName": S.String,
    "internationalFamilyNameInitial": FamilyNameInitial,
    "internationalFirstName": S.String,
    "internationalFirstNameInitial": FirstNameInitial,
    "name": S.String,
    "playingPosition": S.String,
    "sAssists": S.Int,
    "sBlocks": S.Int,
    "sBlocksReceived": S.Int,
    "sFieldGoalsAttempted": S.Int,
    "sFieldGoalsMade": S.Int,
    "sFieldGoalsPercentage": S.Int,
    "sFoulsOn": S.Int,
    "sFoulsPersonal": S.Int,
    "sFreeThrowsAttempted": S.Int,
    "sFreeThrowsMade": S.Int,
    "sFreeThrowsPercentage": S.Int,
    "sMinutes": S.Union(S.Int, S.String),
    "sPlusMinusPoints": S.Int,
    "sPoints": S.Int,
    "sPointsFastBreak": S.Int,
    "sPointsInThePaint": S.Int,
    "sPointsSecondChance": S.Int,
    "sReboundsDefensive": S.Int,
    "sReboundsOffensive": S.Int,
    "sReboundsTotal": S.Int,
    "sSteals": S.Int,
    "sThreePointersAttempted": S.Int,
    "sThreePointersMade": S.Int,
    "sThreePointersPercentage": S.Int,
    "sTurnovers": S.Int,
    "sTwoPointersAttempted": S.Int,
    "sTwoPointersMade": S.Int,
    "sTwoPointersPercentage": S.Int,
    "shirtNumber": S.String.pipe(S.pattern(/^-?\d+$/)),
    "starter": S.Int,
}) {}

export class Time extends S.Class<Time>("Time")({
    "gt": S.String,
    "per": S.Int,
    "perType": PerType,
}) {}

export class Scorer extends S.Class<Scorer>("Scorer")({
    "familyName": S.optional(S.String),
    "familyNameInitial": S.optional(FamilyNameInitial),
    "firstName": S.optional(S.String),
    "firstNameInitial": S.optional(FirstNameInitial),
    "gt": S.optional(S.String),
    "internationalFamilyName": S.optional(S.String),
    "internationalFamilyNameInitial": S.optional(FamilyNameInitial),
    "internationalFirstName": S.optional(S.String),
    "internationalFirstNameInitial": S.optional(FirstNameInitial),
    "name": S.optional(S.String),
    "per": S.optional(S.Int),
    "perType": S.optional(PerType),
    "player": S.optional(S.String),
    "pno": S.Int,
    "scoreboardName": S.optional(ScoreboardName),
    "shirtNumber": S.String,
    "summary": S.optional(S.String),
    "times": S.optional(S.Array(Time)),
    "tno": S.Int,
    "tot": S.optional(S.Int),
}) {}

export class Pbp extends S.Class<Pbp>("Pbp")({
    "actionType": ActionType,
    "familyName": S.optional(S.String),
    "familyNameInitial": S.optional(FamilyNameInitial),
    "firstName": S.optional(S.String),
    "firstNameInitial": S.optional(FirstNameInitial),
    "gt": S.String,
    "internationalFamilyName": S.optional(S.String),
    "internationalFamilyNameInitial": S.optional(FamilyNameInitial),
    "internationalFirstName": S.optional(S.String),
    "internationalFirstNameInitial": S.optional(FirstNameInitial),
    "lead": S.Int,
    "period": S.Int,
    "periodType": PerType,
    "player": S.String,
    "pno": S.Int,
    "qualifier": S.String,
    "s1": S.Int,
    "s2": S.Int,
    "scoreboardName": S.optional(ScoreboardName),
    "scoring": S.Int,
    "shirtNumber": S.String,
    "subType": S.String,
    "success": S.Int,
    "tno": S.Int,
}) {}

export class Totallds extends S.Class<Totallds>("Totallds")({
    "sAssists": S.Record({ key: S.String, value: Scorer}),
    "sBlocks": S.Record({ key: S.String, value: Scorer}),
    "sPoints": S.Record({ key: S.String, value: Scorer}),
    "sReboundsTotal": S.Record({ key: S.String, value: Scorer}),
    "sSteals": S.Record({ key: S.String, value: Scorer}),
}) {}

export class Team extends S.Class<Team>("Team")({
    "teamCode": S.String,
    "teamCodeInternational": S.String,
    "teamName": S.String,
    "teamNameInternational": S.String,
}) {}

export class Othermatch extends S.Class<Othermatch>("Othermatch")({
    "clock": S.String,
    "competitionName": S.String,
    "id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "period": S.Int,
    "periodType": PerType,
    "team1": Team,
    "team1Name": S.String,
    "team1Score": S.Int,
    "team2": Team,
    "team2Name": S.String,
    "team2Score": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "attendance": S.Int,
    "clock": S.String,
    "disableMatch": S.Int,
    "inOT": S.Int,
    "leaddata": S.Array(S.Array(S.Union(LeaddatumEnum, S.Int))),
    "officials_referee1": S.String,
    "officials_referee2": S.String,
    "officials_referee3": S.String,
    "othermatches": S.Array(Othermatch),
    "pbp": S.Array(Pbp),
    "period": S.Int,
    "periodLengthOVERTIME": S.Int,
    "periodLengthREGULAR": S.Int,
    "periodType": PerType,
    "periodsMax": S.Int,
    "scorers": S.Record({ key: S.String, value: S.Array(Scorer)}),
    "timeline": S.Array(S.Any),
    "tm": S.Record({ key: S.String, value: S.suspend(() => Tm)}),
    "totalTimeAdded": S.Int,
    "totallds": Totallds,
}) {}

export class SBlocks extends S.Class<SBlocks>("SBlocks")({
    "1": Scorer,
}) {}

export class Lds extends S.Class<Lds>("Lds")({
    "sAssists": S.Record({ key: S.String, value: Scorer}),
    "sBlocks": SBlocks,
    "sPoints": S.Record({ key: S.String, value: Scorer}),
    "sReboundsTotal": S.Record({ key: S.String, value: Scorer}),
    "sSteals": S.Record({ key: S.String, value: Scorer}),
}) {}

export class Tm extends S.Class<Tm>("Tm")({
    "code": S.String,
    "codeInternational": S.String,
    "fouls": S.Int,
    "full_score": S.Int,
    "lds": Lds,
    "logo": S.String,
    "name": S.String,
    "nameInternational": S.String,
    "p1_score": S.Int,
    "p2_score": S.Int,
    "p3_score": S.Int,
    "p4_score": S.Int,
    "pl": S.Record({ key: S.String, value: Pl}),
    "score": S.Int,
    "scoring": S.Array(Scorer),
    "shortName": S.String,
    "shortNameInternational": S.String,
    "shot": S.Array(Shot),
    "timeouts": S.Int,
    "tot_eff_1": S.Int,
    "tot_eff_2": S.Int,
    "tot_eff_3": S.Number,
    "tot_eff_4": S.Int,
    "tot_eff_5": S.Int,
    "tot_eff_6": S.Int,
    "tot_eff_7": S.Int,
    "tot_sAssists": S.Int,
    "tot_sBenchPoints": S.Int,
    "tot_sBiggestLead": S.Int,
    "tot_sBiggestScoringRun": S.Int,
    "tot_sBlocks": S.Int,
    "tot_sBlocksReceived": S.Int,
    "tot_sFieldGoalsAttempted": S.Int,
    "tot_sFieldGoalsMade": S.Int,
    "tot_sFieldGoalsPercentage": S.Int,
    "tot_sFoulsOn": S.Int,
    "tot_sFoulsPersonal": S.Int,
    "tot_sFoulsTeam": S.Int,
    "tot_sFreeThrowsAttempted": S.Int,
    "tot_sFreeThrowsMade": S.Int,
    "tot_sFreeThrowsPercentage": S.Int,
    "tot_sLeadChanges": S.Int,
    "tot_sMinutes": S.Int,
    "tot_sPoints": S.Int,
    "tot_sPointsFastBreak": S.Int,
    "tot_sPointsFromTurnovers": S.Int,
    "tot_sPointsInThePaint": S.Int,
    "tot_sPointsSecondChance": S.Int,
    "tot_sReboundsDefensive": S.Int,
    "tot_sReboundsOffensive": S.Int,
    "tot_sReboundsTeam": S.Int,
    "tot_sReboundsTeamDefensive": S.Int,
    "tot_sReboundsTeamOffensive": S.Int,
    "tot_sReboundsTotal": S.Int,
    "tot_sSteals": S.Int,
    "tot_sThreePointersAttempted": S.Int,
    "tot_sThreePointersMade": S.Int,
    "tot_sThreePointersPercentage": S.Int,
    "tot_sTimeLeading": S.Number,
    "tot_sTimesScoresLevel": S.Int,
    "tot_sTurnovers": S.Int,
    "tot_sTurnoversTeam": S.Int,
    "tot_sTwoPointersAttempted": S.Int,
    "tot_sTwoPointersMade": S.Int,
    "tot_sTwoPointersPercentage": S.Int,
}) {}
