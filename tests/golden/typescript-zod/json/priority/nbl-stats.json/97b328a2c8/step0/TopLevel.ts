import * as z from "zod";


export const LeaddatumEnumSchema = z.enum([
    "",
    "P1",
    "P2",
    "P3",
    "P4",
]);
export type LeaddatumEnum = z.infer<typeof LeaddatumEnumSchema>;


export const PerTypeSchema = z.enum([
    "REGULAR",
]);
export type PerType = z.infer<typeof PerTypeSchema>;


export const ActionTypeSchema = z.enum([
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
]);
export type ActionType = z.infer<typeof ActionTypeSchema>;


export const FamilyNameInitialSchema = z.enum([
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
]);
export type FamilyNameInitial = z.infer<typeof FamilyNameInitialSchema>;


export const FirstNameInitialSchema = z.enum([
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
]);
export type FirstNameInitial = z.infer<typeof FirstNameInitialSchema>;


export const ScoreboardNameSchema = z.enum([
    "",
    "T. s",
    "R. Ihata",
    "D. Jones",
    "B. Valentine",
]);
export type ScoreboardName = z.infer<typeof ScoreboardNameSchema>;


export const SubTypeSchema = z.enum([
    "jumpshot",
    "layup",
    "dunk",
]);
export type SubType = z.infer<typeof SubTypeSchema>;

export const TeamSchema = z.object({
    "teamCode": z.string(),
    "teamCodeInternational": z.string(),
    "teamName": z.string(),
    "teamNameInternational": z.string(),
});
export type Team = z.infer<typeof TeamSchema>;

export const PbpSchema = z.object({
    "actionType": ActionTypeSchema,
    "familyName": z.string().optional(),
    "familyNameInitial": FamilyNameInitialSchema.optional(),
    "firstName": z.string().optional(),
    "firstNameInitial": FirstNameInitialSchema.optional(),
    "gt": z.string(),
    "internationalFamilyName": z.string().optional(),
    "internationalFamilyNameInitial": FamilyNameInitialSchema.optional(),
    "internationalFirstName": z.string().optional(),
    "internationalFirstNameInitial": FirstNameInitialSchema.optional(),
    "lead": z.number().int(),
    "period": z.number().int(),
    "periodType": PerTypeSchema,
    "player": z.string(),
    "pno": z.number().int(),
    "qualifier": z.string(),
    "s1": z.number().int(),
    "s2": z.number().int(),
    "scoreboardName": ScoreboardNameSchema.optional(),
    "scoring": z.number().int(),
    "shirtNumber": z.string(),
    "subType": z.string(),
    "success": z.number().int(),
    "tno": z.number().int(),
});
export type Pbp = z.infer<typeof PbpSchema>;

export const TimeSchema = z.object({
    "gt": z.string(),
    "per": z.number().int(),
    "perType": PerTypeSchema,
});
export type Time = z.infer<typeof TimeSchema>;

export const CompSchema = z.object({
    "sAssistsAverage": z.number(),
    "sMinutesAverage": z.string(),
    "sPointsAverage": z.number(),
    "sReboundsTotalAverage": z.number(),
});
export type Comp = z.infer<typeof CompSchema>;

export const ShotSchema = z.object({
    "actionType": ActionTypeSchema,
    "p": z.number().int(),
    "per": z.number().int(),
    "perType": PerTypeSchema,
    "player": z.string(),
    "pno": z.number().int(),
    "r": z.number().int(),
    "shirtNumber": z.string(),
    "subType": SubTypeSchema,
    "tno": z.number().int(),
    "x": z.number().int(),
    "y": z.number().int(),
});
export type Shot = z.infer<typeof ShotSchema>;

export const OthermatchSchema = z.object({
    "clock": z.string(),
    "competitionName": z.string(),
    "id": z.string().regex(/^-?\d+$/),
    "period": z.number().int(),
    "periodType": PerTypeSchema,
    "team1": TeamSchema,
    "team1Name": z.string(),
    "team1Score": z.number().int(),
    "team2": TeamSchema,
    "team2Name": z.string(),
    "team2Score": z.number().int(),
});
export type Othermatch = z.infer<typeof OthermatchSchema>;

export const ScorerSchema = z.object({
    "familyName": z.string().optional(),
    "familyNameInitial": FamilyNameInitialSchema.optional(),
    "firstName": z.string().optional(),
    "firstNameInitial": FirstNameInitialSchema.optional(),
    "gt": z.string().optional(),
    "internationalFamilyName": z.string().optional(),
    "internationalFamilyNameInitial": FamilyNameInitialSchema.optional(),
    "internationalFirstName": z.string().optional(),
    "internationalFirstNameInitial": FirstNameInitialSchema.optional(),
    "name": z.string().optional(),
    "per": z.number().int().optional(),
    "perType": PerTypeSchema.optional(),
    "player": z.string().optional(),
    "pno": z.number().int(),
    "scoreboardName": ScoreboardNameSchema.optional(),
    "shirtNumber": z.string(),
    "summary": z.string().optional(),
    "times": z.array(TimeSchema).optional(),
    "tno": z.number().int(),
    "tot": z.number().int().optional(),
});
export type Scorer = z.infer<typeof ScorerSchema>;

export const SBlocksSchema = z.object({
    "1": ScorerSchema,
});
export type SBlocks = z.infer<typeof SBlocksSchema>;

export const PlSchema = z.object({
    "active": z.number().int(),
    "captain": z.number().int().optional(),
    "comp": CompSchema.optional(),
    "eff_1": z.number().int(),
    "eff_2": z.number().int(),
    "eff_3": z.number(),
    "eff_4": z.number(),
    "eff_5": z.number().int(),
    "eff_6": z.number().int(),
    "eff_7": z.number().int(),
    "familyName": z.string(),
    "familyNameInitial": FamilyNameInitialSchema,
    "firstName": z.string(),
    "firstNameInitial": FirstNameInitialSchema,
    "internationalFamilyName": z.string(),
    "internationalFamilyNameInitial": FamilyNameInitialSchema,
    "internationalFirstName": z.string(),
    "internationalFirstNameInitial": FirstNameInitialSchema,
    "name": z.string(),
    "playingPosition": z.string(),
    "sAssists": z.number().int(),
    "sBlocks": z.number().int(),
    "sBlocksReceived": z.number().int(),
    "sFieldGoalsAttempted": z.number().int(),
    "sFieldGoalsMade": z.number().int(),
    "sFieldGoalsPercentage": z.number().int(),
    "sFoulsOn": z.number().int(),
    "sFoulsPersonal": z.number().int(),
    "sFreeThrowsAttempted": z.number().int(),
    "sFreeThrowsMade": z.number().int(),
    "sFreeThrowsPercentage": z.number().int(),
    "sMinutes": z.union([z.number().int(), z.string()]),
    "sPlusMinusPoints": z.number().int(),
    "sPoints": z.number().int(),
    "sPointsFastBreak": z.number().int(),
    "sPointsInThePaint": z.number().int(),
    "sPointsSecondChance": z.number().int(),
    "sReboundsDefensive": z.number().int(),
    "sReboundsOffensive": z.number().int(),
    "sReboundsTotal": z.number().int(),
    "sSteals": z.number().int(),
    "sThreePointersAttempted": z.number().int(),
    "sThreePointersMade": z.number().int(),
    "sThreePointersPercentage": z.number().int(),
    "sTurnovers": z.number().int(),
    "sTwoPointersAttempted": z.number().int(),
    "sTwoPointersMade": z.number().int(),
    "sTwoPointersPercentage": z.number().int(),
    "shirtNumber": z.string().regex(/^-?\d+$/),
    "starter": z.number().int(),
});
export type Pl = z.infer<typeof PlSchema>;

export const TotalldsSchema = z.object({
    "sAssists": z.record(z.string(), ScorerSchema),
    "sBlocks": z.record(z.string(), ScorerSchema),
    "sPoints": z.record(z.string(), ScorerSchema),
    "sReboundsTotal": z.record(z.string(), ScorerSchema),
    "sSteals": z.record(z.string(), ScorerSchema),
});
export type Totallds = z.infer<typeof TotalldsSchema>;

export const LdsSchema = z.object({
    "sAssists": z.record(z.string(), ScorerSchema),
    "sBlocks": SBlocksSchema,
    "sPoints": z.record(z.string(), ScorerSchema),
    "sReboundsTotal": z.record(z.string(), ScorerSchema),
    "sSteals": z.record(z.string(), ScorerSchema),
});
export type Lds = z.infer<typeof LdsSchema>;

export const TmSchema = z.object({
    "code": z.string(),
    "codeInternational": z.string(),
    "fouls": z.number().int(),
    "full_score": z.number().int(),
    "lds": LdsSchema,
    "logo": z.string(),
    "name": z.string(),
    "nameInternational": z.string(),
    "p1_score": z.number().int(),
    "p2_score": z.number().int(),
    "p3_score": z.number().int(),
    "p4_score": z.number().int(),
    "pl": z.record(z.string(), PlSchema),
    "score": z.number().int(),
    "scoring": z.array(ScorerSchema),
    "shortName": z.string(),
    "shortNameInternational": z.string(),
    "shot": z.array(ShotSchema),
    "timeouts": z.number().int(),
    "tot_eff_1": z.number().int(),
    "tot_eff_2": z.number().int(),
    "tot_eff_3": z.number(),
    "tot_eff_4": z.number().int(),
    "tot_eff_5": z.number().int(),
    "tot_eff_6": z.number().int(),
    "tot_eff_7": z.number().int(),
    "tot_sAssists": z.number().int(),
    "tot_sBenchPoints": z.number().int(),
    "tot_sBiggestLead": z.number().int(),
    "tot_sBiggestScoringRun": z.number().int(),
    "tot_sBlocks": z.number().int(),
    "tot_sBlocksReceived": z.number().int(),
    "tot_sFieldGoalsAttempted": z.number().int(),
    "tot_sFieldGoalsMade": z.number().int(),
    "tot_sFieldGoalsPercentage": z.number().int(),
    "tot_sFoulsOn": z.number().int(),
    "tot_sFoulsPersonal": z.number().int(),
    "tot_sFoulsTeam": z.number().int(),
    "tot_sFreeThrowsAttempted": z.number().int(),
    "tot_sFreeThrowsMade": z.number().int(),
    "tot_sFreeThrowsPercentage": z.number().int(),
    "tot_sLeadChanges": z.number().int(),
    "tot_sMinutes": z.number().int(),
    "tot_sPoints": z.number().int(),
    "tot_sPointsFastBreak": z.number().int(),
    "tot_sPointsFromTurnovers": z.number().int(),
    "tot_sPointsInThePaint": z.number().int(),
    "tot_sPointsSecondChance": z.number().int(),
    "tot_sReboundsDefensive": z.number().int(),
    "tot_sReboundsOffensive": z.number().int(),
    "tot_sReboundsTeam": z.number().int(),
    "tot_sReboundsTeamDefensive": z.number().int(),
    "tot_sReboundsTeamOffensive": z.number().int(),
    "tot_sReboundsTotal": z.number().int(),
    "tot_sSteals": z.number().int(),
    "tot_sThreePointersAttempted": z.number().int(),
    "tot_sThreePointersMade": z.number().int(),
    "tot_sThreePointersPercentage": z.number().int(),
    "tot_sTimeLeading": z.number(),
    "tot_sTimesScoresLevel": z.number().int(),
    "tot_sTurnovers": z.number().int(),
    "tot_sTurnoversTeam": z.number().int(),
    "tot_sTwoPointersAttempted": z.number().int(),
    "tot_sTwoPointersMade": z.number().int(),
    "tot_sTwoPointersPercentage": z.number().int(),
});
export type Tm = z.infer<typeof TmSchema>;

export const TopLevelSchema = z.object({
    "attendance": z.number().int(),
    "clock": z.string(),
    "disableMatch": z.number().int(),
    "inOT": z.number().int(),
    "leaddata": z.array(z.array(z.union([LeaddatumEnumSchema, z.number().int()]))),
    "officials_referee1": z.string(),
    "officials_referee2": z.string(),
    "officials_referee3": z.string(),
    "othermatches": z.array(OthermatchSchema),
    "pbp": z.array(PbpSchema),
    "period": z.number().int(),
    "periodLengthOVERTIME": z.number().int(),
    "periodLengthREGULAR": z.number().int(),
    "periodType": PerTypeSchema,
    "periodsMax": z.number().int(),
    "scorers": z.record(z.string(), z.array(ScorerSchema)),
    "timeline": z.array(z.any()),
    "tm": z.record(z.string(), TmSchema),
    "totalTimeAdded": z.number().int(),
    "totallds": TotalldsSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
