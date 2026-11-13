export interface TopLevel {
    attendance:           number;
    clock:                string;
    disableMatch:         number;
    inOT:                 number;
    leaddata:             Array<Array<LeaddatumEnum | number>>;
    officials_referee1:   string;
    officials_referee2:   string;
    officials_referee3:   string;
    othermatches:         Othermatch[];
    pbp:                  Pbp[];
    period:               number;
    periodLengthOVERTIME: number;
    periodLengthREGULAR:  number;
    periodType:           PerType;
    periodsMax:           number;
    scorers:              { [key: string]: Scorer[] };
    timeline:             unknown[];
    tm:                   { [key: string]: Tm };
    totalTimeAdded:       number;
    totallds:             Totallds;
}

export type LeaddatumEnum = "" | "P1" | "P2" | "P3" | "P4";

export interface Othermatch {
    clock:           string;
    competitionName: string;
    id:              string;
    period:          number;
    periodType:      PerType;
    team1:           Team;
    team1Name:       string;
    team1Score:      number;
    team2:           Team;
    team2Name:       string;
    team2Score:      number;
}

export type PerType = "REGULAR";

export interface Team {
    teamCode:              string;
    teamCodeInternational: string;
    teamName:              string;
    teamNameInternational: string;
}

export interface Pbp {
    actionType:                      ActionType;
    familyName?:                     string;
    familyNameInitial?:              FamilyNameInitial;
    firstName?:                      string;
    firstNameInitial?:               FirstNameInitial;
    gt:                              string;
    internationalFamilyName?:        string;
    internationalFamilyNameInitial?: FamilyNameInitial;
    internationalFirstName?:         string;
    internationalFirstNameInitial?:  FirstNameInitial;
    lead:                            number;
    period:                          number;
    periodType:                      PerType;
    player:                          string;
    pno:                             number;
    qualifier:                       string;
    s1:                              number;
    s2:                              number;
    scoreboardName?:                 ScoreboardName;
    scoring:                         number;
    shirtNumber:                     string;
    subType:                         string;
    success:                         number;
    tno:                             number;
}

export type ActionType = "game" | "period" | "3pt" | "2pt" | "rebound" | "timeout" | "foulon" | "foul" | "assist" | "substitution" | "freethrow" | "steal" | "turnover" | "block" | "jumpball";

export type FamilyNameInitial = "R" | "M" | "s" | "C" | "O" | "W" | "A" | "P" | "V" | "I" | "J" | "S" | "H" | "B";

export type FirstNameInitial = "D" | "J" | "T" | "C" | "O" | "H" | "L" | "A" | "K" | "R" | "B" | "N";

export type ScoreboardName = "" | "T. s" | "R. Ihata" | "D. Jones" | "B. Valentine";

export interface Scorer {
    familyName?:                     string;
    familyNameInitial?:              FamilyNameInitial;
    firstName?:                      string;
    firstNameInitial?:               FirstNameInitial;
    gt?:                             string;
    internationalFamilyName?:        string;
    internationalFamilyNameInitial?: FamilyNameInitial;
    internationalFirstName?:         string;
    internationalFirstNameInitial?:  FirstNameInitial;
    name?:                           string;
    per?:                            number;
    perType?:                        PerType;
    player?:                         string;
    pno:                             number;
    scoreboardName?:                 ScoreboardName;
    shirtNumber:                     string;
    summary?:                        string;
    times?:                          Time[];
    tno:                             number;
    tot?:                            number;
}

export interface Time {
    gt:      string;
    per:     number;
    perType: PerType;
}

export interface Tm {
    code:                         string;
    codeInternational:            string;
    fouls:                        number;
    full_score:                   number;
    lds:                          Lds;
    logo:                         string;
    name:                         string;
    nameInternational:            string;
    p1_score:                     number;
    p2_score:                     number;
    p3_score:                     number;
    p4_score:                     number;
    pl:                           { [key: string]: Pl };
    score:                        number;
    scoring:                      Scorer[];
    shortName:                    string;
    shortNameInternational:       string;
    shot:                         Shot[];
    timeouts:                     number;
    tot_eff_1:                    number;
    tot_eff_2:                    number;
    tot_eff_3:                    number;
    tot_eff_4:                    number;
    tot_eff_5:                    number;
    tot_eff_6:                    number;
    tot_eff_7:                    number;
    tot_sAssists:                 number;
    tot_sBenchPoints:             number;
    tot_sBiggestLead:             number;
    tot_sBiggestScoringRun:       number;
    tot_sBlocks:                  number;
    tot_sBlocksReceived:          number;
    tot_sFieldGoalsAttempted:     number;
    tot_sFieldGoalsMade:          number;
    tot_sFieldGoalsPercentage:    number;
    tot_sFoulsOn:                 number;
    tot_sFoulsPersonal:           number;
    tot_sFoulsTeam:               number;
    tot_sFreeThrowsAttempted:     number;
    tot_sFreeThrowsMade:          number;
    tot_sFreeThrowsPercentage:    number;
    tot_sLeadChanges:             number;
    tot_sMinutes:                 number;
    tot_sPoints:                  number;
    tot_sPointsFastBreak:         number;
    tot_sPointsFromTurnovers:     number;
    tot_sPointsInThePaint:        number;
    tot_sPointsSecondChance:      number;
    tot_sReboundsDefensive:       number;
    tot_sReboundsOffensive:       number;
    tot_sReboundsTeam:            number;
    tot_sReboundsTeamDefensive:   number;
    tot_sReboundsTeamOffensive:   number;
    tot_sReboundsTotal:           number;
    tot_sSteals:                  number;
    tot_sThreePointersAttempted:  number;
    tot_sThreePointersMade:       number;
    tot_sThreePointersPercentage: number;
    tot_sTimeLeading:             number;
    tot_sTimesScoresLevel:        number;
    tot_sTurnovers:               number;
    tot_sTurnoversTeam:           number;
    tot_sTwoPointersAttempted:    number;
    tot_sTwoPointersMade:         number;
    tot_sTwoPointersPercentage:   number;
}

export interface Lds {
    sAssists:       { [key: string]: Scorer };
    sBlocks:        SBlocks;
    sPoints:        { [key: string]: Scorer };
    sReboundsTotal: { [key: string]: Scorer };
    sSteals:        { [key: string]: Scorer };
}

export interface SBlocks {
    "1": Scorer;
}

export interface Pl {
    active:                         number;
    captain?:                       number;
    comp?:                          Comp;
    eff_1:                          number;
    eff_2:                          number;
    eff_3:                          number;
    eff_4:                          number;
    eff_5:                          number;
    eff_6:                          number;
    eff_7:                          number;
    familyName:                     string;
    familyNameInitial:              FamilyNameInitial;
    firstName:                      string;
    firstNameInitial:               FirstNameInitial;
    internationalFamilyName:        string;
    internationalFamilyNameInitial: FamilyNameInitial;
    internationalFirstName:         string;
    internationalFirstNameInitial:  FirstNameInitial;
    name:                           string;
    playingPosition:                string;
    sAssists:                       number;
    sBlocks:                        number;
    sBlocksReceived:                number;
    sFieldGoalsAttempted:           number;
    sFieldGoalsMade:                number;
    sFieldGoalsPercentage:          number;
    sFoulsOn:                       number;
    sFoulsPersonal:                 number;
    sFreeThrowsAttempted:           number;
    sFreeThrowsMade:                number;
    sFreeThrowsPercentage:          number;
    sMinutes:                       number | string;
    sPlusMinusPoints:               number;
    sPoints:                        number;
    sPointsFastBreak:               number;
    sPointsInThePaint:              number;
    sPointsSecondChance:            number;
    sReboundsDefensive:             number;
    sReboundsOffensive:             number;
    sReboundsTotal:                 number;
    sSteals:                        number;
    sThreePointersAttempted:        number;
    sThreePointersMade:             number;
    sThreePointersPercentage:       number;
    sTurnovers:                     number;
    sTwoPointersAttempted:          number;
    sTwoPointersMade:               number;
    sTwoPointersPercentage:         number;
    shirtNumber:                    string;
    starter:                        number;
}

export interface Comp {
    sAssistsAverage:       number;
    sMinutesAverage:       string;
    sPointsAverage:        number;
    sReboundsTotalAverage: number;
}

export interface Shot {
    actionType:  ActionType;
    p:           number;
    per:         number;
    perType:     PerType;
    player:      string;
    pno:         number;
    r:           number;
    shirtNumber: string;
    subType:     SubType;
    tno:         number;
    x:           number;
    y:           number;
}

export type SubType = "jumpshot" | "layup" | "dunk";

export interface Totallds {
    sAssists:       { [key: string]: Scorer };
    sBlocks:        { [key: string]: Scorer };
    sPoints:        { [key: string]: Scorer };
    sReboundsTotal: { [key: string]: Scorer };
    sSteals:        { [key: string]: Scorer };
}
