// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int attendance;
    final String clock;
    final int disableMatch;
    final int inOt;
    final List<List<dynamic>> leaddata;
    final String officialsReferee1;
    final String officialsReferee2;
    final String officialsReferee3;
    final List<Othermatch> othermatches;
    final List<Pbp> pbp;
    final int period;
    final int periodLengthOvertime;
    final int periodLengthRegular;
    final PerType periodType;
    final int periodsMax;
    final Map<String, List<Scorer>> scorers;
    final List<dynamic> timeline;
    final Map<String, Tm> tm;
    final int totalTimeAdded;
    final Totallds totallds;

    TopLevel({
        required this.attendance,
        required this.clock,
        required this.disableMatch,
        required this.inOt,
        required this.leaddata,
        required this.officialsReferee1,
        required this.officialsReferee2,
        required this.officialsReferee3,
        required this.othermatches,
        required this.pbp,
        required this.period,
        required this.periodLengthOvertime,
        required this.periodLengthRegular,
        required this.periodType,
        required this.periodsMax,
        required this.scorers,
        required this.timeline,
        required this.tm,
        required this.totalTimeAdded,
        required this.totallds,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        attendance: json["attendance"],
        clock: json["clock"],
        disableMatch: json["disableMatch"],
        inOt: json["inOT"],
        leaddata: List<List<dynamic>>.from(json["leaddata"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        officialsReferee1: json["officials_referee1"],
        officialsReferee2: json["officials_referee2"],
        officialsReferee3: json["officials_referee3"],
        othermatches: List<Othermatch>.from(json["othermatches"].map((x) => Othermatch.fromJson(x))),
        pbp: List<Pbp>.from(json["pbp"].map((x) => Pbp.fromJson(x))),
        period: json["period"],
        periodLengthOvertime: json["periodLengthOVERTIME"],
        periodLengthRegular: json["periodLengthREGULAR"],
        periodType: perTypeValues.map[json["periodType"]]!,
        periodsMax: json["periodsMax"],
        scorers: Map.from(json["scorers"]).map((k, v) => MapEntry<String, List<Scorer>>(k, List<Scorer>.from(v.map((x) => Scorer.fromJson(x))))),
        timeline: List<dynamic>.from(json["timeline"].map((x) => x)),
        tm: Map.from(json["tm"]).map((k, v) => MapEntry<String, Tm>(k, Tm.fromJson(v))),
        totalTimeAdded: json["totalTimeAdded"],
        totallds: Totallds.fromJson(json["totallds"]),
    );

    Map<String, dynamic> toJson() => {
        "attendance": attendance,
        "clock": clock,
        "disableMatch": disableMatch,
        "inOT": inOt,
        "leaddata": List<dynamic>.from(leaddata.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "officials_referee1": officialsReferee1,
        "officials_referee2": officialsReferee2,
        "officials_referee3": officialsReferee3,
        "othermatches": List<dynamic>.from(othermatches.map((x) => x.toJson())),
        "pbp": List<dynamic>.from(pbp.map((x) => x.toJson())),
        "period": period,
        "periodLengthOVERTIME": periodLengthOvertime,
        "periodLengthREGULAR": periodLengthRegular,
        "periodType": perTypeValues.reverse[periodType],
        "periodsMax": periodsMax,
        "scorers": Map.from(scorers).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "timeline": List<dynamic>.from(timeline.map((x) => x)),
        "tm": Map.from(tm).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "totalTimeAdded": totalTimeAdded,
        "totallds": totallds.toJson(),
    };
}

enum LeaddatumEnum {
    EMPTY,
    P1,
    P2,
    P3,
    P4
}

final leaddatumEnumValues = EnumValues({
    "": LeaddatumEnum.EMPTY,
    "P1": LeaddatumEnum.P1,
    "P2": LeaddatumEnum.P2,
    "P3": LeaddatumEnum.P3,
    "P4": LeaddatumEnum.P4
});

class Othermatch {
    final String clock;
    final String competitionName;
    final String id;
    final int period;
    final PerType periodType;
    final Team team1;
    final String team1Name;
    final int team1Score;
    final Team team2;
    final String team2Name;
    final int team2Score;

    Othermatch({
        required this.clock,
        required this.competitionName,
        required this.id,
        required this.period,
        required this.periodType,
        required this.team1,
        required this.team1Name,
        required this.team1Score,
        required this.team2,
        required this.team2Name,
        required this.team2Score,
    });

    factory Othermatch.fromJson(Map<String, dynamic> json) => Othermatch(
        clock: json["clock"],
        competitionName: json["competitionName"],
        id: json["id"],
        period: json["period"],
        periodType: perTypeValues.map[json["periodType"]]!,
        team1: Team.fromJson(json["team1"]),
        team1Name: json["team1Name"],
        team1Score: json["team1Score"],
        team2: Team.fromJson(json["team2"]),
        team2Name: json["team2Name"],
        team2Score: json["team2Score"],
    );

    Map<String, dynamic> toJson() => {
        "clock": clock,
        "competitionName": competitionName,
        "id": id,
        "period": period,
        "periodType": perTypeValues.reverse[periodType],
        "team1": team1.toJson(),
        "team1Name": team1Name,
        "team1Score": team1Score,
        "team2": team2.toJson(),
        "team2Name": team2Name,
        "team2Score": team2Score,
    };
}

enum PerType {
    REGULAR
}

final perTypeValues = EnumValues({
    "REGULAR": PerType.REGULAR
});

class Team {
    final String teamCode;
    final String teamCodeInternational;
    final String teamName;
    final String teamNameInternational;

    Team({
        required this.teamCode,
        required this.teamCodeInternational,
        required this.teamName,
        required this.teamNameInternational,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamCode: json["teamCode"],
        teamCodeInternational: json["teamCodeInternational"],
        teamName: json["teamName"],
        teamNameInternational: json["teamNameInternational"],
    );

    Map<String, dynamic> toJson() => {
        "teamCode": teamCode,
        "teamCodeInternational": teamCodeInternational,
        "teamName": teamName,
        "teamNameInternational": teamNameInternational,
    };
}

class Pbp {
    final ActionType actionType;
    final String? familyName;
    final FamilyNameInitial? familyNameInitial;
    final String? firstName;
    final FirstNameInitial? firstNameInitial;
    final String gt;
    final String? internationalFamilyName;
    final FamilyNameInitial? internationalFamilyNameInitial;
    final String? internationalFirstName;
    final FirstNameInitial? internationalFirstNameInitial;
    final int lead;
    final int period;
    final PerType periodType;
    final String player;
    final int pno;
    final String qualifier;
    final int s1;
    final int s2;
    final ScoreboardName? scoreboardName;
    final int scoring;
    final String shirtNumber;
    final String subType;
    final int success;
    final int tno;

    Pbp({
        required this.actionType,
        this.familyName,
        this.familyNameInitial,
        this.firstName,
        this.firstNameInitial,
        required this.gt,
        this.internationalFamilyName,
        this.internationalFamilyNameInitial,
        this.internationalFirstName,
        this.internationalFirstNameInitial,
        required this.lead,
        required this.period,
        required this.periodType,
        required this.player,
        required this.pno,
        required this.qualifier,
        required this.s1,
        required this.s2,
        this.scoreboardName,
        required this.scoring,
        required this.shirtNumber,
        required this.subType,
        required this.success,
        required this.tno,
    });

    factory Pbp.fromJson(Map<String, dynamic> json) => Pbp(
        actionType: actionTypeValues.map[json["actionType"]]!,
        familyName: json["familyName"],
        familyNameInitial: json["familyNameInitial"] == null ? null : familyNameInitialValues.map[json["familyNameInitial"]]!,
        firstName: json["firstName"],
        firstNameInitial: json["firstNameInitial"] == null ? null : firstNameInitialValues.map[json["firstNameInitial"]]!,
        gt: json["gt"],
        internationalFamilyName: json["internationalFamilyName"],
        internationalFamilyNameInitial: json["internationalFamilyNameInitial"] == null ? null : familyNameInitialValues.map[json["internationalFamilyNameInitial"]]!,
        internationalFirstName: json["internationalFirstName"],
        internationalFirstNameInitial: json["internationalFirstNameInitial"] == null ? null : firstNameInitialValues.map[json["internationalFirstNameInitial"]]!,
        lead: json["lead"],
        period: json["period"],
        periodType: perTypeValues.map[json["periodType"]]!,
        player: json["player"],
        pno: json["pno"],
        qualifier: json["qualifier"],
        s1: json["s1"],
        s2: json["s2"],
        scoreboardName: json["scoreboardName"] == null ? null : scoreboardNameValues.map[json["scoreboardName"]]!,
        scoring: json["scoring"],
        shirtNumber: json["shirtNumber"],
        subType: json["subType"],
        success: json["success"],
        tno: json["tno"],
    );

    Map<String, dynamic> toJson() => {
        "actionType": actionTypeValues.reverse[actionType],
        "familyName": familyName,
        "familyNameInitial": familyNameInitialValues.reverse[familyNameInitial],
        "firstName": firstName,
        "firstNameInitial": firstNameInitialValues.reverse[firstNameInitial],
        "gt": gt,
        "internationalFamilyName": internationalFamilyName,
        "internationalFamilyNameInitial": familyNameInitialValues.reverse[internationalFamilyNameInitial],
        "internationalFirstName": internationalFirstName,
        "internationalFirstNameInitial": firstNameInitialValues.reverse[internationalFirstNameInitial],
        "lead": lead,
        "period": period,
        "periodType": perTypeValues.reverse[periodType],
        "player": player,
        "pno": pno,
        "qualifier": qualifier,
        "s1": s1,
        "s2": s2,
        "scoreboardName": scoreboardNameValues.reverse[scoreboardName],
        "scoring": scoring,
        "shirtNumber": shirtNumber,
        "subType": subType,
        "success": success,
        "tno": tno,
    };
}

enum ActionType {
    GAME,
    PERIOD,
    THE_3_PT,
    THE_2_PT,
    REBOUND,
    TIMEOUT,
    FOULON,
    FOUL,
    ASSIST,
    SUBSTITUTION,
    FREETHROW,
    STEAL,
    TURNOVER,
    BLOCK,
    JUMPBALL
}

final actionTypeValues = EnumValues({
    "game": ActionType.GAME,
    "period": ActionType.PERIOD,
    "3pt": ActionType.THE_3_PT,
    "2pt": ActionType.THE_2_PT,
    "rebound": ActionType.REBOUND,
    "timeout": ActionType.TIMEOUT,
    "foulon": ActionType.FOULON,
    "foul": ActionType.FOUL,
    "assist": ActionType.ASSIST,
    "substitution": ActionType.SUBSTITUTION,
    "freethrow": ActionType.FREETHROW,
    "steal": ActionType.STEAL,
    "turnover": ActionType.TURNOVER,
    "block": ActionType.BLOCK,
    "jumpball": ActionType.JUMPBALL
});

enum FamilyNameInitial {
    R,
    M,
    S,
    C,
    O,
    W,
    A,
    P,
    V,
    I,
    J,
    FAMILY_NAME_INITIAL_S,
    H,
    B
}

final familyNameInitialValues = EnumValues({
    "R": FamilyNameInitial.R,
    "M": FamilyNameInitial.M,
    "s": FamilyNameInitial.S,
    "C": FamilyNameInitial.C,
    "O": FamilyNameInitial.O,
    "W": FamilyNameInitial.W,
    "A": FamilyNameInitial.A,
    "P": FamilyNameInitial.P,
    "V": FamilyNameInitial.V,
    "I": FamilyNameInitial.I,
    "J": FamilyNameInitial.J,
    "S": FamilyNameInitial.FAMILY_NAME_INITIAL_S,
    "H": FamilyNameInitial.H,
    "B": FamilyNameInitial.B
});

enum FirstNameInitial {
    D,
    J,
    T,
    C,
    O,
    H,
    L,
    A,
    K,
    R,
    B,
    N
}

final firstNameInitialValues = EnumValues({
    "D": FirstNameInitial.D,
    "J": FirstNameInitial.J,
    "T": FirstNameInitial.T,
    "C": FirstNameInitial.C,
    "O": FirstNameInitial.O,
    "H": FirstNameInitial.H,
    "L": FirstNameInitial.L,
    "A": FirstNameInitial.A,
    "K": FirstNameInitial.K,
    "R": FirstNameInitial.R,
    "B": FirstNameInitial.B,
    "N": FirstNameInitial.N
});

enum ScoreboardName {
    EMPTY,
    T_S,
    R_IHATA,
    D_JONES,
    B_VALENTINE
}

final scoreboardNameValues = EnumValues({
    "": ScoreboardName.EMPTY,
    "T. s": ScoreboardName.T_S,
    "R. Ihata": ScoreboardName.R_IHATA,
    "D. Jones": ScoreboardName.D_JONES,
    "B. Valentine": ScoreboardName.B_VALENTINE
});

class Scorer {
    final String? familyName;
    final FamilyNameInitial? familyNameInitial;
    final String? firstName;
    final FirstNameInitial? firstNameInitial;
    final String? gt;
    final String? internationalFamilyName;
    final FamilyNameInitial? internationalFamilyNameInitial;
    final String? internationalFirstName;
    final FirstNameInitial? internationalFirstNameInitial;
    final String? name;
    final int? per;
    final PerType? perType;
    final String? player;
    final int pno;
    final ScoreboardName? scoreboardName;
    final String shirtNumber;
    final String? summary;
    final List<Time>? times;
    final int tno;
    final int? tot;

    Scorer({
        this.familyName,
        this.familyNameInitial,
        this.firstName,
        this.firstNameInitial,
        this.gt,
        this.internationalFamilyName,
        this.internationalFamilyNameInitial,
        this.internationalFirstName,
        this.internationalFirstNameInitial,
        this.name,
        this.per,
        this.perType,
        this.player,
        required this.pno,
        this.scoreboardName,
        required this.shirtNumber,
        this.summary,
        this.times,
        required this.tno,
        this.tot,
    });

    factory Scorer.fromJson(Map<String, dynamic> json) => Scorer(
        familyName: json["familyName"],
        familyNameInitial: json["familyNameInitial"] == null ? null : familyNameInitialValues.map[json["familyNameInitial"]]!,
        firstName: json["firstName"],
        firstNameInitial: json["firstNameInitial"] == null ? null : firstNameInitialValues.map[json["firstNameInitial"]]!,
        gt: json["gt"],
        internationalFamilyName: json["internationalFamilyName"],
        internationalFamilyNameInitial: json["internationalFamilyNameInitial"] == null ? null : familyNameInitialValues.map[json["internationalFamilyNameInitial"]]!,
        internationalFirstName: json["internationalFirstName"],
        internationalFirstNameInitial: json["internationalFirstNameInitial"] == null ? null : firstNameInitialValues.map[json["internationalFirstNameInitial"]]!,
        name: json["name"],
        per: json["per"],
        perType: json["perType"] == null ? null : perTypeValues.map[json["perType"]]!,
        player: json["player"],
        pno: json["pno"],
        scoreboardName: json["scoreboardName"] == null ? null : scoreboardNameValues.map[json["scoreboardName"]]!,
        shirtNumber: json["shirtNumber"],
        summary: json["summary"],
        times: json["times"] == null ? null : List<Time>.from(json["times"]!.map((x) => Time.fromJson(x))),
        tno: json["tno"],
        tot: json["tot"],
    );

    Map<String, dynamic> toJson() => {
        "familyName": familyName,
        "familyNameInitial": familyNameInitialValues.reverse[familyNameInitial],
        "firstName": firstName,
        "firstNameInitial": firstNameInitialValues.reverse[firstNameInitial],
        "gt": gt,
        "internationalFamilyName": internationalFamilyName,
        "internationalFamilyNameInitial": familyNameInitialValues.reverse[internationalFamilyNameInitial],
        "internationalFirstName": internationalFirstName,
        "internationalFirstNameInitial": firstNameInitialValues.reverse[internationalFirstNameInitial],
        "name": name,
        "per": per,
        "perType": perTypeValues.reverse[perType],
        "player": player,
        "pno": pno,
        "scoreboardName": scoreboardNameValues.reverse[scoreboardName],
        "shirtNumber": shirtNumber,
        "summary": summary,
        "times": times == null ? null : List<dynamic>.from(times!.map((x) => x.toJson())),
        "tno": tno,
        "tot": tot,
    };
}

class Time {
    final String gt;
    final int per;
    final PerType perType;

    Time({
        required this.gt,
        required this.per,
        required this.perType,
    });

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        gt: json["gt"],
        per: json["per"],
        perType: perTypeValues.map[json["perType"]]!,
    );

    Map<String, dynamic> toJson() => {
        "gt": gt,
        "per": per,
        "perType": perTypeValues.reverse[perType],
    };
}

class Tm {
    final String code;
    final String codeInternational;
    final int fouls;
    final int fullScore;
    final Lds lds;
    final String logo;
    final String name;
    final String nameInternational;
    final int p1Score;
    final int p2Score;
    final int p3Score;
    final int p4Score;
    final Map<String, Pl> pl;
    final int score;
    final List<Scorer> scoring;
    final String shortName;
    final String shortNameInternational;
    final List<Shot> shot;
    final int timeouts;
    final int totEff1;
    final int totEff2;
    final double totEff3;
    final int totEff4;
    final int totEff5;
    final int totEff6;
    final int totEff7;
    final int totSAssists;
    final int totSBenchPoints;
    final int totSBiggestLead;
    final int totSBiggestScoringRun;
    final int totSBlocks;
    final int totSBlocksReceived;
    final int totSFieldGoalsAttempted;
    final int totSFieldGoalsMade;
    final int totSFieldGoalsPercentage;
    final int totSFoulsOn;
    final int totSFoulsPersonal;
    final int totSFoulsTeam;
    final int totSFreeThrowsAttempted;
    final int totSFreeThrowsMade;
    final int totSFreeThrowsPercentage;
    final int totSLeadChanges;
    final int totSMinutes;
    final int totSPoints;
    final int totSPointsFastBreak;
    final int totSPointsFromTurnovers;
    final int totSPointsInThePaint;
    final int totSPointsSecondChance;
    final int totSReboundsDefensive;
    final int totSReboundsOffensive;
    final int totSReboundsTeam;
    final int totSReboundsTeamDefensive;
    final int totSReboundsTeamOffensive;
    final int totSReboundsTotal;
    final int totSSteals;
    final int totSThreePointersAttempted;
    final int totSThreePointersMade;
    final int totSThreePointersPercentage;
    final double totSTimeLeading;
    final int totSTimesScoresLevel;
    final int totSTurnovers;
    final int totSTurnoversTeam;
    final int totSTwoPointersAttempted;
    final int totSTwoPointersMade;
    final int totSTwoPointersPercentage;

    Tm({
        required this.code,
        required this.codeInternational,
        required this.fouls,
        required this.fullScore,
        required this.lds,
        required this.logo,
        required this.name,
        required this.nameInternational,
        required this.p1Score,
        required this.p2Score,
        required this.p3Score,
        required this.p4Score,
        required this.pl,
        required this.score,
        required this.scoring,
        required this.shortName,
        required this.shortNameInternational,
        required this.shot,
        required this.timeouts,
        required this.totEff1,
        required this.totEff2,
        required this.totEff3,
        required this.totEff4,
        required this.totEff5,
        required this.totEff6,
        required this.totEff7,
        required this.totSAssists,
        required this.totSBenchPoints,
        required this.totSBiggestLead,
        required this.totSBiggestScoringRun,
        required this.totSBlocks,
        required this.totSBlocksReceived,
        required this.totSFieldGoalsAttempted,
        required this.totSFieldGoalsMade,
        required this.totSFieldGoalsPercentage,
        required this.totSFoulsOn,
        required this.totSFoulsPersonal,
        required this.totSFoulsTeam,
        required this.totSFreeThrowsAttempted,
        required this.totSFreeThrowsMade,
        required this.totSFreeThrowsPercentage,
        required this.totSLeadChanges,
        required this.totSMinutes,
        required this.totSPoints,
        required this.totSPointsFastBreak,
        required this.totSPointsFromTurnovers,
        required this.totSPointsInThePaint,
        required this.totSPointsSecondChance,
        required this.totSReboundsDefensive,
        required this.totSReboundsOffensive,
        required this.totSReboundsTeam,
        required this.totSReboundsTeamDefensive,
        required this.totSReboundsTeamOffensive,
        required this.totSReboundsTotal,
        required this.totSSteals,
        required this.totSThreePointersAttempted,
        required this.totSThreePointersMade,
        required this.totSThreePointersPercentage,
        required this.totSTimeLeading,
        required this.totSTimesScoresLevel,
        required this.totSTurnovers,
        required this.totSTurnoversTeam,
        required this.totSTwoPointersAttempted,
        required this.totSTwoPointersMade,
        required this.totSTwoPointersPercentage,
    });

    factory Tm.fromJson(Map<String, dynamic> json) => Tm(
        code: json["code"],
        codeInternational: json["codeInternational"],
        fouls: json["fouls"],
        fullScore: json["full_score"],
        lds: Lds.fromJson(json["lds"]),
        logo: json["logo"],
        name: json["name"],
        nameInternational: json["nameInternational"],
        p1Score: json["p1_score"],
        p2Score: json["p2_score"],
        p3Score: json["p3_score"],
        p4Score: json["p4_score"],
        pl: Map.from(json["pl"]).map((k, v) => MapEntry<String, Pl>(k, Pl.fromJson(v))),
        score: json["score"],
        scoring: List<Scorer>.from(json["scoring"].map((x) => Scorer.fromJson(x))),
        shortName: json["shortName"],
        shortNameInternational: json["shortNameInternational"],
        shot: List<Shot>.from(json["shot"].map((x) => Shot.fromJson(x))),
        timeouts: json["timeouts"],
        totEff1: json["tot_eff_1"],
        totEff2: json["tot_eff_2"],
        totEff3: json["tot_eff_3"]?.toDouble(),
        totEff4: json["tot_eff_4"],
        totEff5: json["tot_eff_5"],
        totEff6: json["tot_eff_6"],
        totEff7: json["tot_eff_7"],
        totSAssists: json["tot_sAssists"],
        totSBenchPoints: json["tot_sBenchPoints"],
        totSBiggestLead: json["tot_sBiggestLead"],
        totSBiggestScoringRun: json["tot_sBiggestScoringRun"],
        totSBlocks: json["tot_sBlocks"],
        totSBlocksReceived: json["tot_sBlocksReceived"],
        totSFieldGoalsAttempted: json["tot_sFieldGoalsAttempted"],
        totSFieldGoalsMade: json["tot_sFieldGoalsMade"],
        totSFieldGoalsPercentage: json["tot_sFieldGoalsPercentage"],
        totSFoulsOn: json["tot_sFoulsOn"],
        totSFoulsPersonal: json["tot_sFoulsPersonal"],
        totSFoulsTeam: json["tot_sFoulsTeam"],
        totSFreeThrowsAttempted: json["tot_sFreeThrowsAttempted"],
        totSFreeThrowsMade: json["tot_sFreeThrowsMade"],
        totSFreeThrowsPercentage: json["tot_sFreeThrowsPercentage"],
        totSLeadChanges: json["tot_sLeadChanges"],
        totSMinutes: json["tot_sMinutes"],
        totSPoints: json["tot_sPoints"],
        totSPointsFastBreak: json["tot_sPointsFastBreak"],
        totSPointsFromTurnovers: json["tot_sPointsFromTurnovers"],
        totSPointsInThePaint: json["tot_sPointsInThePaint"],
        totSPointsSecondChance: json["tot_sPointsSecondChance"],
        totSReboundsDefensive: json["tot_sReboundsDefensive"],
        totSReboundsOffensive: json["tot_sReboundsOffensive"],
        totSReboundsTeam: json["tot_sReboundsTeam"],
        totSReboundsTeamDefensive: json["tot_sReboundsTeamDefensive"],
        totSReboundsTeamOffensive: json["tot_sReboundsTeamOffensive"],
        totSReboundsTotal: json["tot_sReboundsTotal"],
        totSSteals: json["tot_sSteals"],
        totSThreePointersAttempted: json["tot_sThreePointersAttempted"],
        totSThreePointersMade: json["tot_sThreePointersMade"],
        totSThreePointersPercentage: json["tot_sThreePointersPercentage"],
        totSTimeLeading: json["tot_sTimeLeading"]?.toDouble(),
        totSTimesScoresLevel: json["tot_sTimesScoresLevel"],
        totSTurnovers: json["tot_sTurnovers"],
        totSTurnoversTeam: json["tot_sTurnoversTeam"],
        totSTwoPointersAttempted: json["tot_sTwoPointersAttempted"],
        totSTwoPointersMade: json["tot_sTwoPointersMade"],
        totSTwoPointersPercentage: json["tot_sTwoPointersPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "codeInternational": codeInternational,
        "fouls": fouls,
        "full_score": fullScore,
        "lds": lds.toJson(),
        "logo": logo,
        "name": name,
        "nameInternational": nameInternational,
        "p1_score": p1Score,
        "p2_score": p2Score,
        "p3_score": p3Score,
        "p4_score": p4Score,
        "pl": Map.from(pl).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "score": score,
        "scoring": List<dynamic>.from(scoring.map((x) => x.toJson())),
        "shortName": shortName,
        "shortNameInternational": shortNameInternational,
        "shot": List<dynamic>.from(shot.map((x) => x.toJson())),
        "timeouts": timeouts,
        "tot_eff_1": totEff1,
        "tot_eff_2": totEff2,
        "tot_eff_3": totEff3,
        "tot_eff_4": totEff4,
        "tot_eff_5": totEff5,
        "tot_eff_6": totEff6,
        "tot_eff_7": totEff7,
        "tot_sAssists": totSAssists,
        "tot_sBenchPoints": totSBenchPoints,
        "tot_sBiggestLead": totSBiggestLead,
        "tot_sBiggestScoringRun": totSBiggestScoringRun,
        "tot_sBlocks": totSBlocks,
        "tot_sBlocksReceived": totSBlocksReceived,
        "tot_sFieldGoalsAttempted": totSFieldGoalsAttempted,
        "tot_sFieldGoalsMade": totSFieldGoalsMade,
        "tot_sFieldGoalsPercentage": totSFieldGoalsPercentage,
        "tot_sFoulsOn": totSFoulsOn,
        "tot_sFoulsPersonal": totSFoulsPersonal,
        "tot_sFoulsTeam": totSFoulsTeam,
        "tot_sFreeThrowsAttempted": totSFreeThrowsAttempted,
        "tot_sFreeThrowsMade": totSFreeThrowsMade,
        "tot_sFreeThrowsPercentage": totSFreeThrowsPercentage,
        "tot_sLeadChanges": totSLeadChanges,
        "tot_sMinutes": totSMinutes,
        "tot_sPoints": totSPoints,
        "tot_sPointsFastBreak": totSPointsFastBreak,
        "tot_sPointsFromTurnovers": totSPointsFromTurnovers,
        "tot_sPointsInThePaint": totSPointsInThePaint,
        "tot_sPointsSecondChance": totSPointsSecondChance,
        "tot_sReboundsDefensive": totSReboundsDefensive,
        "tot_sReboundsOffensive": totSReboundsOffensive,
        "tot_sReboundsTeam": totSReboundsTeam,
        "tot_sReboundsTeamDefensive": totSReboundsTeamDefensive,
        "tot_sReboundsTeamOffensive": totSReboundsTeamOffensive,
        "tot_sReboundsTotal": totSReboundsTotal,
        "tot_sSteals": totSSteals,
        "tot_sThreePointersAttempted": totSThreePointersAttempted,
        "tot_sThreePointersMade": totSThreePointersMade,
        "tot_sThreePointersPercentage": totSThreePointersPercentage,
        "tot_sTimeLeading": totSTimeLeading,
        "tot_sTimesScoresLevel": totSTimesScoresLevel,
        "tot_sTurnovers": totSTurnovers,
        "tot_sTurnoversTeam": totSTurnoversTeam,
        "tot_sTwoPointersAttempted": totSTwoPointersAttempted,
        "tot_sTwoPointersMade": totSTwoPointersMade,
        "tot_sTwoPointersPercentage": totSTwoPointersPercentage,
    };
}

class Lds {
    final Map<String, Scorer> sAssists;
    final SBlocks sBlocks;
    final Map<String, Scorer> sPoints;
    final Map<String, Scorer> sReboundsTotal;
    final Map<String, Scorer> sSteals;

    Lds({
        required this.sAssists,
        required this.sBlocks,
        required this.sPoints,
        required this.sReboundsTotal,
        required this.sSteals,
    });

    factory Lds.fromJson(Map<String, dynamic> json) => Lds(
        sAssists: Map.from(json["sAssists"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sBlocks: SBlocks.fromJson(json["sBlocks"]),
        sPoints: Map.from(json["sPoints"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sReboundsTotal: Map.from(json["sReboundsTotal"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sSteals: Map.from(json["sSteals"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "sAssists": Map.from(sAssists).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sBlocks": sBlocks.toJson(),
        "sPoints": Map.from(sPoints).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sReboundsTotal": Map.from(sReboundsTotal).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sSteals": Map.from(sSteals).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class SBlocks {
    final Scorer the1;

    SBlocks({
        required this.the1,
    });

    factory SBlocks.fromJson(Map<String, dynamic> json) => SBlocks(
        the1: Scorer.fromJson(json["1"]),
    );

    Map<String, dynamic> toJson() => {
        "1": the1.toJson(),
    };
}

class Pl {
    final int active;
    final int? captain;
    final Comp? comp;
    final int eff1;
    final int eff2;
    final double eff3;
    final double eff4;
    final int eff5;
    final int eff6;
    final int eff7;
    final String familyName;
    final FamilyNameInitial familyNameInitial;
    final String firstName;
    final FirstNameInitial firstNameInitial;
    final String internationalFamilyName;
    final FamilyNameInitial internationalFamilyNameInitial;
    final String internationalFirstName;
    final FirstNameInitial internationalFirstNameInitial;
    final String name;
    final String playingPosition;
    final int sAssists;
    final int sBlocks;
    final int sBlocksReceived;
    final int sFieldGoalsAttempted;
    final int sFieldGoalsMade;
    final int sFieldGoalsPercentage;
    final int sFoulsOn;
    final int sFoulsPersonal;
    final int sFreeThrowsAttempted;
    final int sFreeThrowsMade;
    final int sFreeThrowsPercentage;
    final dynamic sMinutes;
    final int sPlusMinusPoints;
    final int sPoints;
    final int sPointsFastBreak;
    final int sPointsInThePaint;
    final int sPointsSecondChance;
    final int sReboundsDefensive;
    final int sReboundsOffensive;
    final int sReboundsTotal;
    final int sSteals;
    final int sThreePointersAttempted;
    final int sThreePointersMade;
    final int sThreePointersPercentage;
    final int sTurnovers;
    final int sTwoPointersAttempted;
    final int sTwoPointersMade;
    final int sTwoPointersPercentage;
    final String shirtNumber;
    final int starter;

    Pl({
        required this.active,
        this.captain,
        this.comp,
        required this.eff1,
        required this.eff2,
        required this.eff3,
        required this.eff4,
        required this.eff5,
        required this.eff6,
        required this.eff7,
        required this.familyName,
        required this.familyNameInitial,
        required this.firstName,
        required this.firstNameInitial,
        required this.internationalFamilyName,
        required this.internationalFamilyNameInitial,
        required this.internationalFirstName,
        required this.internationalFirstNameInitial,
        required this.name,
        required this.playingPosition,
        required this.sAssists,
        required this.sBlocks,
        required this.sBlocksReceived,
        required this.sFieldGoalsAttempted,
        required this.sFieldGoalsMade,
        required this.sFieldGoalsPercentage,
        required this.sFoulsOn,
        required this.sFoulsPersonal,
        required this.sFreeThrowsAttempted,
        required this.sFreeThrowsMade,
        required this.sFreeThrowsPercentage,
        required this.sMinutes,
        required this.sPlusMinusPoints,
        required this.sPoints,
        required this.sPointsFastBreak,
        required this.sPointsInThePaint,
        required this.sPointsSecondChance,
        required this.sReboundsDefensive,
        required this.sReboundsOffensive,
        required this.sReboundsTotal,
        required this.sSteals,
        required this.sThreePointersAttempted,
        required this.sThreePointersMade,
        required this.sThreePointersPercentage,
        required this.sTurnovers,
        required this.sTwoPointersAttempted,
        required this.sTwoPointersMade,
        required this.sTwoPointersPercentage,
        required this.shirtNumber,
        required this.starter,
    });

    factory Pl.fromJson(Map<String, dynamic> json) => Pl(
        active: json["active"],
        captain: json["captain"],
        comp: json["comp"] == null ? null : Comp.fromJson(json["comp"]),
        eff1: json["eff_1"],
        eff2: json["eff_2"],
        eff3: json["eff_3"]?.toDouble(),
        eff4: json["eff_4"]?.toDouble(),
        eff5: json["eff_5"],
        eff6: json["eff_6"],
        eff7: json["eff_7"],
        familyName: json["familyName"],
        familyNameInitial: familyNameInitialValues.map[json["familyNameInitial"]]!,
        firstName: json["firstName"],
        firstNameInitial: firstNameInitialValues.map[json["firstNameInitial"]]!,
        internationalFamilyName: json["internationalFamilyName"],
        internationalFamilyNameInitial: familyNameInitialValues.map[json["internationalFamilyNameInitial"]]!,
        internationalFirstName: json["internationalFirstName"],
        internationalFirstNameInitial: firstNameInitialValues.map[json["internationalFirstNameInitial"]]!,
        name: json["name"],
        playingPosition: json["playingPosition"],
        sAssists: json["sAssists"],
        sBlocks: json["sBlocks"],
        sBlocksReceived: json["sBlocksReceived"],
        sFieldGoalsAttempted: json["sFieldGoalsAttempted"],
        sFieldGoalsMade: json["sFieldGoalsMade"],
        sFieldGoalsPercentage: json["sFieldGoalsPercentage"],
        sFoulsOn: json["sFoulsOn"],
        sFoulsPersonal: json["sFoulsPersonal"],
        sFreeThrowsAttempted: json["sFreeThrowsAttempted"],
        sFreeThrowsMade: json["sFreeThrowsMade"],
        sFreeThrowsPercentage: json["sFreeThrowsPercentage"],
        sMinutes: json["sMinutes"],
        sPlusMinusPoints: json["sPlusMinusPoints"],
        sPoints: json["sPoints"],
        sPointsFastBreak: json["sPointsFastBreak"],
        sPointsInThePaint: json["sPointsInThePaint"],
        sPointsSecondChance: json["sPointsSecondChance"],
        sReboundsDefensive: json["sReboundsDefensive"],
        sReboundsOffensive: json["sReboundsOffensive"],
        sReboundsTotal: json["sReboundsTotal"],
        sSteals: json["sSteals"],
        sThreePointersAttempted: json["sThreePointersAttempted"],
        sThreePointersMade: json["sThreePointersMade"],
        sThreePointersPercentage: json["sThreePointersPercentage"],
        sTurnovers: json["sTurnovers"],
        sTwoPointersAttempted: json["sTwoPointersAttempted"],
        sTwoPointersMade: json["sTwoPointersMade"],
        sTwoPointersPercentage: json["sTwoPointersPercentage"],
        shirtNumber: json["shirtNumber"],
        starter: json["starter"],
    );

    Map<String, dynamic> toJson() => {
        "active": active,
        "captain": captain,
        "comp": comp?.toJson(),
        "eff_1": eff1,
        "eff_2": eff2,
        "eff_3": eff3,
        "eff_4": eff4,
        "eff_5": eff5,
        "eff_6": eff6,
        "eff_7": eff7,
        "familyName": familyName,
        "familyNameInitial": familyNameInitialValues.reverse[familyNameInitial],
        "firstName": firstName,
        "firstNameInitial": firstNameInitialValues.reverse[firstNameInitial],
        "internationalFamilyName": internationalFamilyName,
        "internationalFamilyNameInitial": familyNameInitialValues.reverse[internationalFamilyNameInitial],
        "internationalFirstName": internationalFirstName,
        "internationalFirstNameInitial": firstNameInitialValues.reverse[internationalFirstNameInitial],
        "name": name,
        "playingPosition": playingPosition,
        "sAssists": sAssists,
        "sBlocks": sBlocks,
        "sBlocksReceived": sBlocksReceived,
        "sFieldGoalsAttempted": sFieldGoalsAttempted,
        "sFieldGoalsMade": sFieldGoalsMade,
        "sFieldGoalsPercentage": sFieldGoalsPercentage,
        "sFoulsOn": sFoulsOn,
        "sFoulsPersonal": sFoulsPersonal,
        "sFreeThrowsAttempted": sFreeThrowsAttempted,
        "sFreeThrowsMade": sFreeThrowsMade,
        "sFreeThrowsPercentage": sFreeThrowsPercentage,
        "sMinutes": sMinutes,
        "sPlusMinusPoints": sPlusMinusPoints,
        "sPoints": sPoints,
        "sPointsFastBreak": sPointsFastBreak,
        "sPointsInThePaint": sPointsInThePaint,
        "sPointsSecondChance": sPointsSecondChance,
        "sReboundsDefensive": sReboundsDefensive,
        "sReboundsOffensive": sReboundsOffensive,
        "sReboundsTotal": sReboundsTotal,
        "sSteals": sSteals,
        "sThreePointersAttempted": sThreePointersAttempted,
        "sThreePointersMade": sThreePointersMade,
        "sThreePointersPercentage": sThreePointersPercentage,
        "sTurnovers": sTurnovers,
        "sTwoPointersAttempted": sTwoPointersAttempted,
        "sTwoPointersMade": sTwoPointersMade,
        "sTwoPointersPercentage": sTwoPointersPercentage,
        "shirtNumber": shirtNumber,
        "starter": starter,
    };
}

class Comp {
    final double sAssistsAverage;
    final String sMinutesAverage;
    final double sPointsAverage;
    final double sReboundsTotalAverage;

    Comp({
        required this.sAssistsAverage,
        required this.sMinutesAverage,
        required this.sPointsAverage,
        required this.sReboundsTotalAverage,
    });

    factory Comp.fromJson(Map<String, dynamic> json) => Comp(
        sAssistsAverage: json["sAssistsAverage"]?.toDouble(),
        sMinutesAverage: json["sMinutesAverage"],
        sPointsAverage: json["sPointsAverage"]?.toDouble(),
        sReboundsTotalAverage: json["sReboundsTotalAverage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sAssistsAverage": sAssistsAverage,
        "sMinutesAverage": sMinutesAverage,
        "sPointsAverage": sPointsAverage,
        "sReboundsTotalAverage": sReboundsTotalAverage,
    };
}

class Shot {
    final ActionType actionType;
    final int p;
    final int per;
    final PerType perType;
    final String player;
    final int pno;
    final int r;
    final String shirtNumber;
    final SubType subType;
    final int tno;
    final int x;
    final int y;

    Shot({
        required this.actionType,
        required this.p,
        required this.per,
        required this.perType,
        required this.player,
        required this.pno,
        required this.r,
        required this.shirtNumber,
        required this.subType,
        required this.tno,
        required this.x,
        required this.y,
    });

    factory Shot.fromJson(Map<String, dynamic> json) => Shot(
        actionType: actionTypeValues.map[json["actionType"]]!,
        p: json["p"],
        per: json["per"],
        perType: perTypeValues.map[json["perType"]]!,
        player: json["player"],
        pno: json["pno"],
        r: json["r"],
        shirtNumber: json["shirtNumber"],
        subType: subTypeValues.map[json["subType"]]!,
        tno: json["tno"],
        x: json["x"],
        y: json["y"],
    );

    Map<String, dynamic> toJson() => {
        "actionType": actionTypeValues.reverse[actionType],
        "p": p,
        "per": per,
        "perType": perTypeValues.reverse[perType],
        "player": player,
        "pno": pno,
        "r": r,
        "shirtNumber": shirtNumber,
        "subType": subTypeValues.reverse[subType],
        "tno": tno,
        "x": x,
        "y": y,
    };
}

enum SubType {
    JUMPSHOT,
    LAYUP,
    DUNK
}

final subTypeValues = EnumValues({
    "jumpshot": SubType.JUMPSHOT,
    "layup": SubType.LAYUP,
    "dunk": SubType.DUNK
});

class Totallds {
    final Map<String, Scorer> sAssists;
    final Map<String, Scorer> sBlocks;
    final Map<String, Scorer> sPoints;
    final Map<String, Scorer> sReboundsTotal;
    final Map<String, Scorer> sSteals;

    Totallds({
        required this.sAssists,
        required this.sBlocks,
        required this.sPoints,
        required this.sReboundsTotal,
        required this.sSteals,
    });

    factory Totallds.fromJson(Map<String, dynamic> json) => Totallds(
        sAssists: Map.from(json["sAssists"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sBlocks: Map.from(json["sBlocks"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sPoints: Map.from(json["sPoints"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sReboundsTotal: Map.from(json["sReboundsTotal"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
        sSteals: Map.from(json["sSteals"]).map((k, v) => MapEntry<String, Scorer>(k, Scorer.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "sAssists": Map.from(sAssists).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sBlocks": Map.from(sBlocks).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sPoints": Map.from(sPoints).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sReboundsTotal": Map.from(sReboundsTotal).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "sSteals": Map.from(sSteals).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
