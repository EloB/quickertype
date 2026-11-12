// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let attendance: Int
    let clock: String
    let disableMatch: Int
    let inOT: Int
    let leaddata: [[LeaddatumElement]]
    let officialsReferee1: String
    let officialsReferee2: String
    let officialsReferee3: String
    let othermatches: [Othermatch]
    let pbp: [Pbp]
    let period: Int
    let periodLengthOVERTIME: Int
    let periodLengthREGULAR: Int
    let periodType: PerType
    let periodsMax: Int
    let scorers: [String: [Scorer]]
    let timeline: [JSONAny]
    let tm: [String: Tm]
    let totalTimeAdded: Int
    let totallds: Totallds

    enum CodingKeys: String, CodingKey {
        case attendance = "attendance"
        case clock = "clock"
        case disableMatch = "disableMatch"
        case inOT = "inOT"
        case leaddata = "leaddata"
        case officialsReferee1 = "officials_referee1"
        case officialsReferee2 = "officials_referee2"
        case officialsReferee3 = "officials_referee3"
        case othermatches = "othermatches"
        case pbp = "pbp"
        case period = "period"
        case periodLengthOVERTIME = "periodLengthOVERTIME"
        case periodLengthREGULAR = "periodLengthREGULAR"
        case periodType = "periodType"
        case periodsMax = "periodsMax"
        case scorers = "scorers"
        case timeline = "timeline"
        case tm = "tm"
        case totalTimeAdded = "totalTimeAdded"
        case totallds = "totallds"
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        attendance: Int? = nil,
        clock: String? = nil,
        disableMatch: Int? = nil,
        inOT: Int? = nil,
        leaddata: [[LeaddatumElement]]? = nil,
        officialsReferee1: String? = nil,
        officialsReferee2: String? = nil,
        officialsReferee3: String? = nil,
        othermatches: [Othermatch]? = nil,
        pbp: [Pbp]? = nil,
        period: Int? = nil,
        periodLengthOVERTIME: Int? = nil,
        periodLengthREGULAR: Int? = nil,
        periodType: PerType? = nil,
        periodsMax: Int? = nil,
        scorers: [String: [Scorer]]? = nil,
        timeline: [JSONAny]? = nil,
        tm: [String: Tm]? = nil,
        totalTimeAdded: Int? = nil,
        totallds: Totallds? = nil
    ) -> TopLevel {
        return TopLevel(
            attendance: attendance ?? self.attendance,
            clock: clock ?? self.clock,
            disableMatch: disableMatch ?? self.disableMatch,
            inOT: inOT ?? self.inOT,
            leaddata: leaddata ?? self.leaddata,
            officialsReferee1: officialsReferee1 ?? self.officialsReferee1,
            officialsReferee2: officialsReferee2 ?? self.officialsReferee2,
            officialsReferee3: officialsReferee3 ?? self.officialsReferee3,
            othermatches: othermatches ?? self.othermatches,
            pbp: pbp ?? self.pbp,
            period: period ?? self.period,
            periodLengthOVERTIME: periodLengthOVERTIME ?? self.periodLengthOVERTIME,
            periodLengthREGULAR: periodLengthREGULAR ?? self.periodLengthREGULAR,
            periodType: periodType ?? self.periodType,
            periodsMax: periodsMax ?? self.periodsMax,
            scorers: scorers ?? self.scorers,
            timeline: timeline ?? self.timeline,
            tm: tm ?? self.tm,
            totalTimeAdded: totalTimeAdded ?? self.totalTimeAdded,
            totallds: totallds ?? self.totallds
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum LeaddatumElement: Codable {
    case enumeration(LeaddatumEnum)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(LeaddatumEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(LeaddatumElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LeaddatumElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum LeaddatumEnum: String, Codable {
    case empty = ""
    case p1 = "P1"
    case p2 = "P2"
    case p3 = "P3"
    case p4 = "P4"
}

// MARK: - Othermatch
struct Othermatch: Codable {
    let clock: String
    let competitionName: String
    let id: String
    let period: Int
    let periodType: PerType
    let team1: Team
    let team1Name: String
    let team1Score: Int
    let team2: Team
    let team2Name: String
    let team2Score: Int

    enum CodingKeys: String, CodingKey {
        case clock = "clock"
        case competitionName = "competitionName"
        case id = "id"
        case period = "period"
        case periodType = "periodType"
        case team1 = "team1"
        case team1Name = "team1Name"
        case team1Score = "team1Score"
        case team2 = "team2"
        case team2Name = "team2Name"
        case team2Score = "team2Score"
    }
}

// MARK: Othermatch convenience initializers and mutators

extension Othermatch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Othermatch.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        clock: String? = nil,
        competitionName: String? = nil,
        id: String? = nil,
        period: Int? = nil,
        periodType: PerType? = nil,
        team1: Team? = nil,
        team1Name: String? = nil,
        team1Score: Int? = nil,
        team2: Team? = nil,
        team2Name: String? = nil,
        team2Score: Int? = nil
    ) -> Othermatch {
        return Othermatch(
            clock: clock ?? self.clock,
            competitionName: competitionName ?? self.competitionName,
            id: id ?? self.id,
            period: period ?? self.period,
            periodType: periodType ?? self.periodType,
            team1: team1 ?? self.team1,
            team1Name: team1Name ?? self.team1Name,
            team1Score: team1Score ?? self.team1Score,
            team2: team2 ?? self.team2,
            team2Name: team2Name ?? self.team2Name,
            team2Score: team2Score ?? self.team2Score
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum PerType: String, Codable {
    case regular = "REGULAR"
}

// MARK: - Team
struct Team: Codable {
    let teamCode: String
    let teamCodeInternational: String
    let teamName: String
    let teamNameInternational: String

    enum CodingKeys: String, CodingKey {
        case teamCode = "teamCode"
        case teamCodeInternational = "teamCodeInternational"
        case teamName = "teamName"
        case teamNameInternational = "teamNameInternational"
    }
}

// MARK: Team convenience initializers and mutators

extension Team {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Team.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        teamCode: String? = nil,
        teamCodeInternational: String? = nil,
        teamName: String? = nil,
        teamNameInternational: String? = nil
    ) -> Team {
        return Team(
            teamCode: teamCode ?? self.teamCode,
            teamCodeInternational: teamCodeInternational ?? self.teamCodeInternational,
            teamName: teamName ?? self.teamName,
            teamNameInternational: teamNameInternational ?? self.teamNameInternational
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pbp
struct Pbp: Codable {
    let actionType: ActionType
    let familyName: String?
    let familyNameInitial: FamilyNameInitial?
    let firstName: String?
    let firstNameInitial: FirstNameInitial?
    let gt: String
    let internationalFamilyName: String?
    let internationalFamilyNameInitial: FamilyNameInitial?
    let internationalFirstName: String?
    let internationalFirstNameInitial: FirstNameInitial?
    let lead: Int
    let period: Int
    let periodType: PerType
    let player: String
    let pno: Int
    let qualifier: String
    let s1: Int
    let s2: Int
    let scoreboardName: ScoreboardName?
    let scoring: Int
    let shirtNumber: String
    let subType: String
    let success: Int
    let tno: Int

    enum CodingKeys: String, CodingKey {
        case actionType = "actionType"
        case familyName = "familyName"
        case familyNameInitial = "familyNameInitial"
        case firstName = "firstName"
        case firstNameInitial = "firstNameInitial"
        case gt = "gt"
        case internationalFamilyName = "internationalFamilyName"
        case internationalFamilyNameInitial = "internationalFamilyNameInitial"
        case internationalFirstName = "internationalFirstName"
        case internationalFirstNameInitial = "internationalFirstNameInitial"
        case lead = "lead"
        case period = "period"
        case periodType = "periodType"
        case player = "player"
        case pno = "pno"
        case qualifier = "qualifier"
        case s1 = "s1"
        case s2 = "s2"
        case scoreboardName = "scoreboardName"
        case scoring = "scoring"
        case shirtNumber = "shirtNumber"
        case subType = "subType"
        case success = "success"
        case tno = "tno"
    }
}

// MARK: Pbp convenience initializers and mutators

extension Pbp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pbp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        actionType: ActionType? = nil,
        familyName: String?? = nil,
        familyNameInitial: FamilyNameInitial?? = nil,
        firstName: String?? = nil,
        firstNameInitial: FirstNameInitial?? = nil,
        gt: String? = nil,
        internationalFamilyName: String?? = nil,
        internationalFamilyNameInitial: FamilyNameInitial?? = nil,
        internationalFirstName: String?? = nil,
        internationalFirstNameInitial: FirstNameInitial?? = nil,
        lead: Int? = nil,
        period: Int? = nil,
        periodType: PerType? = nil,
        player: String? = nil,
        pno: Int? = nil,
        qualifier: String? = nil,
        s1: Int? = nil,
        s2: Int? = nil,
        scoreboardName: ScoreboardName?? = nil,
        scoring: Int? = nil,
        shirtNumber: String? = nil,
        subType: String? = nil,
        success: Int? = nil,
        tno: Int? = nil
    ) -> Pbp {
        return Pbp(
            actionType: actionType ?? self.actionType,
            familyName: familyName ?? self.familyName,
            familyNameInitial: familyNameInitial ?? self.familyNameInitial,
            firstName: firstName ?? self.firstName,
            firstNameInitial: firstNameInitial ?? self.firstNameInitial,
            gt: gt ?? self.gt,
            internationalFamilyName: internationalFamilyName ?? self.internationalFamilyName,
            internationalFamilyNameInitial: internationalFamilyNameInitial ?? self.internationalFamilyNameInitial,
            internationalFirstName: internationalFirstName ?? self.internationalFirstName,
            internationalFirstNameInitial: internationalFirstNameInitial ?? self.internationalFirstNameInitial,
            lead: lead ?? self.lead,
            period: period ?? self.period,
            periodType: periodType ?? self.periodType,
            player: player ?? self.player,
            pno: pno ?? self.pno,
            qualifier: qualifier ?? self.qualifier,
            s1: s1 ?? self.s1,
            s2: s2 ?? self.s2,
            scoreboardName: scoreboardName ?? self.scoreboardName,
            scoring: scoring ?? self.scoring,
            shirtNumber: shirtNumber ?? self.shirtNumber,
            subType: subType ?? self.subType,
            success: success ?? self.success,
            tno: tno ?? self.tno
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ActionType: String, Codable {
    case game = "game"
    case period = "period"
    case the3Pt = "3pt"
    case the2Pt = "2pt"
    case rebound = "rebound"
    case timeout = "timeout"
    case foulon = "foulon"
    case foul = "foul"
    case assist = "assist"
    case substitution = "substitution"
    case freethrow = "freethrow"
    case steal = "steal"
    case turnover = "turnover"
    case block = "block"
    case jumpball = "jumpball"
}

enum FamilyNameInitial: String, Codable {
    case r = "R"
    case m = "M"
    case s = "s"
    case c = "C"
    case o = "O"
    case w = "W"
    case a = "A"
    case p = "P"
    case v = "V"
    case i = "I"
    case j = "J"
    case familyNameInitialS = "S"
    case h = "H"
    case b = "B"
}

enum FirstNameInitial: String, Codable {
    case d = "D"
    case j = "J"
    case t = "T"
    case c = "C"
    case o = "O"
    case h = "H"
    case l = "L"
    case a = "A"
    case k = "K"
    case r = "R"
    case b = "B"
    case n = "N"
}

enum ScoreboardName: String, Codable {
    case empty = ""
    case tS = "T. s"
    case rIhata = "R. Ihata"
    case dJones = "D. Jones"
    case bValentine = "B. Valentine"
}

// MARK: - Scorer
struct Scorer: Codable {
    let familyName: String?
    let familyNameInitial: FamilyNameInitial?
    let firstName: String?
    let firstNameInitial: FirstNameInitial?
    let gt: String?
    let internationalFamilyName: String?
    let internationalFamilyNameInitial: FamilyNameInitial?
    let internationalFirstName: String?
    let internationalFirstNameInitial: FirstNameInitial?
    let name: String?
    let per: Int?
    let perType: PerType?
    let player: String?
    let pno: Int
    let scoreboardName: ScoreboardName?
    let shirtNumber: String
    let summary: String?
    let times: [Time]?
    let tno: Int
    let tot: Int?

    enum CodingKeys: String, CodingKey {
        case familyName = "familyName"
        case familyNameInitial = "familyNameInitial"
        case firstName = "firstName"
        case firstNameInitial = "firstNameInitial"
        case gt = "gt"
        case internationalFamilyName = "internationalFamilyName"
        case internationalFamilyNameInitial = "internationalFamilyNameInitial"
        case internationalFirstName = "internationalFirstName"
        case internationalFirstNameInitial = "internationalFirstNameInitial"
        case name = "name"
        case per = "per"
        case perType = "perType"
        case player = "player"
        case pno = "pno"
        case scoreboardName = "scoreboardName"
        case shirtNumber = "shirtNumber"
        case summary = "summary"
        case times = "times"
        case tno = "tno"
        case tot = "tot"
    }
}

// MARK: Scorer convenience initializers and mutators

extension Scorer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Scorer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        familyName: String?? = nil,
        familyNameInitial: FamilyNameInitial?? = nil,
        firstName: String?? = nil,
        firstNameInitial: FirstNameInitial?? = nil,
        gt: String?? = nil,
        internationalFamilyName: String?? = nil,
        internationalFamilyNameInitial: FamilyNameInitial?? = nil,
        internationalFirstName: String?? = nil,
        internationalFirstNameInitial: FirstNameInitial?? = nil,
        name: String?? = nil,
        per: Int?? = nil,
        perType: PerType?? = nil,
        player: String?? = nil,
        pno: Int? = nil,
        scoreboardName: ScoreboardName?? = nil,
        shirtNumber: String? = nil,
        summary: String?? = nil,
        times: [Time]?? = nil,
        tno: Int? = nil,
        tot: Int?? = nil
    ) -> Scorer {
        return Scorer(
            familyName: familyName ?? self.familyName,
            familyNameInitial: familyNameInitial ?? self.familyNameInitial,
            firstName: firstName ?? self.firstName,
            firstNameInitial: firstNameInitial ?? self.firstNameInitial,
            gt: gt ?? self.gt,
            internationalFamilyName: internationalFamilyName ?? self.internationalFamilyName,
            internationalFamilyNameInitial: internationalFamilyNameInitial ?? self.internationalFamilyNameInitial,
            internationalFirstName: internationalFirstName ?? self.internationalFirstName,
            internationalFirstNameInitial: internationalFirstNameInitial ?? self.internationalFirstNameInitial,
            name: name ?? self.name,
            per: per ?? self.per,
            perType: perType ?? self.perType,
            player: player ?? self.player,
            pno: pno ?? self.pno,
            scoreboardName: scoreboardName ?? self.scoreboardName,
            shirtNumber: shirtNumber ?? self.shirtNumber,
            summary: summary ?? self.summary,
            times: times ?? self.times,
            tno: tno ?? self.tno,
            tot: tot ?? self.tot
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Time
struct Time: Codable {
    let gt: String
    let per: Int
    let perType: PerType

    enum CodingKeys: String, CodingKey {
        case gt = "gt"
        case per = "per"
        case perType = "perType"
    }
}

// MARK: Time convenience initializers and mutators

extension Time {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Time.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        gt: String? = nil,
        per: Int? = nil,
        perType: PerType? = nil
    ) -> Time {
        return Time(
            gt: gt ?? self.gt,
            per: per ?? self.per,
            perType: perType ?? self.perType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Tm
struct Tm: Codable {
    let code: String
    let codeInternational: String
    let fouls: Int
    let fullScore: Int
    let lds: Lds
    let logo: String
    let name: String
    let nameInternational: String
    let p1Score: Int
    let p2Score: Int
    let p3Score: Int
    let p4Score: Int
    let pl: [String: Pl]
    let score: Int
    let scoring: [Scorer]
    let shortName: String
    let shortNameInternational: String
    let shot: [Shot]
    let timeouts: Int
    let totEFF1: Int
    let totEFF2: Int
    let totEFF3: Double
    let totEFF4: Int
    let totEFF5: Int
    let totEFF6: Int
    let totEFF7: Int
    let totSAssists: Int
    let totSBenchPoints: Int
    let totSBiggestLead: Int
    let totSBiggestScoringRun: Int
    let totSBlocks: Int
    let totSBlocksReceived: Int
    let totSFieldGoalsAttempted: Int
    let totSFieldGoalsMade: Int
    let totSFieldGoalsPercentage: Int
    let totSFoulsOn: Int
    let totSFoulsPersonal: Int
    let totSFoulsTeam: Int
    let totSFreeThrowsAttempted: Int
    let totSFreeThrowsMade: Int
    let totSFreeThrowsPercentage: Int
    let totSLeadChanges: Int
    let totSMinutes: Int
    let totSPoints: Int
    let totSPointsFastBreak: Int
    let totSPointsFromTurnovers: Int
    let totSPointsInThePaint: Int
    let totSPointsSecondChance: Int
    let totSReboundsDefensive: Int
    let totSReboundsOffensive: Int
    let totSReboundsTeam: Int
    let totSReboundsTeamDefensive: Int
    let totSReboundsTeamOffensive: Int
    let totSReboundsTotal: Int
    let totSSteals: Int
    let totSThreePointersAttempted: Int
    let totSThreePointersMade: Int
    let totSThreePointersPercentage: Int
    let totSTimeLeading: Double
    let totSTimesScoresLevel: Int
    let totSTurnovers: Int
    let totSTurnoversTeam: Int
    let totSTwoPointersAttempted: Int
    let totSTwoPointersMade: Int
    let totSTwoPointersPercentage: Int

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case codeInternational = "codeInternational"
        case fouls = "fouls"
        case fullScore = "full_score"
        case lds = "lds"
        case logo = "logo"
        case name = "name"
        case nameInternational = "nameInternational"
        case p1Score = "p1_score"
        case p2Score = "p2_score"
        case p3Score = "p3_score"
        case p4Score = "p4_score"
        case pl = "pl"
        case score = "score"
        case scoring = "scoring"
        case shortName = "shortName"
        case shortNameInternational = "shortNameInternational"
        case shot = "shot"
        case timeouts = "timeouts"
        case totEFF1 = "tot_eff_1"
        case totEFF2 = "tot_eff_2"
        case totEFF3 = "tot_eff_3"
        case totEFF4 = "tot_eff_4"
        case totEFF5 = "tot_eff_5"
        case totEFF6 = "tot_eff_6"
        case totEFF7 = "tot_eff_7"
        case totSAssists = "tot_sAssists"
        case totSBenchPoints = "tot_sBenchPoints"
        case totSBiggestLead = "tot_sBiggestLead"
        case totSBiggestScoringRun = "tot_sBiggestScoringRun"
        case totSBlocks = "tot_sBlocks"
        case totSBlocksReceived = "tot_sBlocksReceived"
        case totSFieldGoalsAttempted = "tot_sFieldGoalsAttempted"
        case totSFieldGoalsMade = "tot_sFieldGoalsMade"
        case totSFieldGoalsPercentage = "tot_sFieldGoalsPercentage"
        case totSFoulsOn = "tot_sFoulsOn"
        case totSFoulsPersonal = "tot_sFoulsPersonal"
        case totSFoulsTeam = "tot_sFoulsTeam"
        case totSFreeThrowsAttempted = "tot_sFreeThrowsAttempted"
        case totSFreeThrowsMade = "tot_sFreeThrowsMade"
        case totSFreeThrowsPercentage = "tot_sFreeThrowsPercentage"
        case totSLeadChanges = "tot_sLeadChanges"
        case totSMinutes = "tot_sMinutes"
        case totSPoints = "tot_sPoints"
        case totSPointsFastBreak = "tot_sPointsFastBreak"
        case totSPointsFromTurnovers = "tot_sPointsFromTurnovers"
        case totSPointsInThePaint = "tot_sPointsInThePaint"
        case totSPointsSecondChance = "tot_sPointsSecondChance"
        case totSReboundsDefensive = "tot_sReboundsDefensive"
        case totSReboundsOffensive = "tot_sReboundsOffensive"
        case totSReboundsTeam = "tot_sReboundsTeam"
        case totSReboundsTeamDefensive = "tot_sReboundsTeamDefensive"
        case totSReboundsTeamOffensive = "tot_sReboundsTeamOffensive"
        case totSReboundsTotal = "tot_sReboundsTotal"
        case totSSteals = "tot_sSteals"
        case totSThreePointersAttempted = "tot_sThreePointersAttempted"
        case totSThreePointersMade = "tot_sThreePointersMade"
        case totSThreePointersPercentage = "tot_sThreePointersPercentage"
        case totSTimeLeading = "tot_sTimeLeading"
        case totSTimesScoresLevel = "tot_sTimesScoresLevel"
        case totSTurnovers = "tot_sTurnovers"
        case totSTurnoversTeam = "tot_sTurnoversTeam"
        case totSTwoPointersAttempted = "tot_sTwoPointersAttempted"
        case totSTwoPointersMade = "tot_sTwoPointersMade"
        case totSTwoPointersPercentage = "tot_sTwoPointersPercentage"
    }
}

// MARK: Tm convenience initializers and mutators

extension Tm {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Tm.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        code: String? = nil,
        codeInternational: String? = nil,
        fouls: Int? = nil,
        fullScore: Int? = nil,
        lds: Lds? = nil,
        logo: String? = nil,
        name: String? = nil,
        nameInternational: String? = nil,
        p1Score: Int? = nil,
        p2Score: Int? = nil,
        p3Score: Int? = nil,
        p4Score: Int? = nil,
        pl: [String: Pl]? = nil,
        score: Int? = nil,
        scoring: [Scorer]? = nil,
        shortName: String? = nil,
        shortNameInternational: String? = nil,
        shot: [Shot]? = nil,
        timeouts: Int? = nil,
        totEFF1: Int? = nil,
        totEFF2: Int? = nil,
        totEFF3: Double? = nil,
        totEFF4: Int? = nil,
        totEFF5: Int? = nil,
        totEFF6: Int? = nil,
        totEFF7: Int? = nil,
        totSAssists: Int? = nil,
        totSBenchPoints: Int? = nil,
        totSBiggestLead: Int? = nil,
        totSBiggestScoringRun: Int? = nil,
        totSBlocks: Int? = nil,
        totSBlocksReceived: Int? = nil,
        totSFieldGoalsAttempted: Int? = nil,
        totSFieldGoalsMade: Int? = nil,
        totSFieldGoalsPercentage: Int? = nil,
        totSFoulsOn: Int? = nil,
        totSFoulsPersonal: Int? = nil,
        totSFoulsTeam: Int? = nil,
        totSFreeThrowsAttempted: Int? = nil,
        totSFreeThrowsMade: Int? = nil,
        totSFreeThrowsPercentage: Int? = nil,
        totSLeadChanges: Int? = nil,
        totSMinutes: Int? = nil,
        totSPoints: Int? = nil,
        totSPointsFastBreak: Int? = nil,
        totSPointsFromTurnovers: Int? = nil,
        totSPointsInThePaint: Int? = nil,
        totSPointsSecondChance: Int? = nil,
        totSReboundsDefensive: Int? = nil,
        totSReboundsOffensive: Int? = nil,
        totSReboundsTeam: Int? = nil,
        totSReboundsTeamDefensive: Int? = nil,
        totSReboundsTeamOffensive: Int? = nil,
        totSReboundsTotal: Int? = nil,
        totSSteals: Int? = nil,
        totSThreePointersAttempted: Int? = nil,
        totSThreePointersMade: Int? = nil,
        totSThreePointersPercentage: Int? = nil,
        totSTimeLeading: Double? = nil,
        totSTimesScoresLevel: Int? = nil,
        totSTurnovers: Int? = nil,
        totSTurnoversTeam: Int? = nil,
        totSTwoPointersAttempted: Int? = nil,
        totSTwoPointersMade: Int? = nil,
        totSTwoPointersPercentage: Int? = nil
    ) -> Tm {
        return Tm(
            code: code ?? self.code,
            codeInternational: codeInternational ?? self.codeInternational,
            fouls: fouls ?? self.fouls,
            fullScore: fullScore ?? self.fullScore,
            lds: lds ?? self.lds,
            logo: logo ?? self.logo,
            name: name ?? self.name,
            nameInternational: nameInternational ?? self.nameInternational,
            p1Score: p1Score ?? self.p1Score,
            p2Score: p2Score ?? self.p2Score,
            p3Score: p3Score ?? self.p3Score,
            p4Score: p4Score ?? self.p4Score,
            pl: pl ?? self.pl,
            score: score ?? self.score,
            scoring: scoring ?? self.scoring,
            shortName: shortName ?? self.shortName,
            shortNameInternational: shortNameInternational ?? self.shortNameInternational,
            shot: shot ?? self.shot,
            timeouts: timeouts ?? self.timeouts,
            totEFF1: totEFF1 ?? self.totEFF1,
            totEFF2: totEFF2 ?? self.totEFF2,
            totEFF3: totEFF3 ?? self.totEFF3,
            totEFF4: totEFF4 ?? self.totEFF4,
            totEFF5: totEFF5 ?? self.totEFF5,
            totEFF6: totEFF6 ?? self.totEFF6,
            totEFF7: totEFF7 ?? self.totEFF7,
            totSAssists: totSAssists ?? self.totSAssists,
            totSBenchPoints: totSBenchPoints ?? self.totSBenchPoints,
            totSBiggestLead: totSBiggestLead ?? self.totSBiggestLead,
            totSBiggestScoringRun: totSBiggestScoringRun ?? self.totSBiggestScoringRun,
            totSBlocks: totSBlocks ?? self.totSBlocks,
            totSBlocksReceived: totSBlocksReceived ?? self.totSBlocksReceived,
            totSFieldGoalsAttempted: totSFieldGoalsAttempted ?? self.totSFieldGoalsAttempted,
            totSFieldGoalsMade: totSFieldGoalsMade ?? self.totSFieldGoalsMade,
            totSFieldGoalsPercentage: totSFieldGoalsPercentage ?? self.totSFieldGoalsPercentage,
            totSFoulsOn: totSFoulsOn ?? self.totSFoulsOn,
            totSFoulsPersonal: totSFoulsPersonal ?? self.totSFoulsPersonal,
            totSFoulsTeam: totSFoulsTeam ?? self.totSFoulsTeam,
            totSFreeThrowsAttempted: totSFreeThrowsAttempted ?? self.totSFreeThrowsAttempted,
            totSFreeThrowsMade: totSFreeThrowsMade ?? self.totSFreeThrowsMade,
            totSFreeThrowsPercentage: totSFreeThrowsPercentage ?? self.totSFreeThrowsPercentage,
            totSLeadChanges: totSLeadChanges ?? self.totSLeadChanges,
            totSMinutes: totSMinutes ?? self.totSMinutes,
            totSPoints: totSPoints ?? self.totSPoints,
            totSPointsFastBreak: totSPointsFastBreak ?? self.totSPointsFastBreak,
            totSPointsFromTurnovers: totSPointsFromTurnovers ?? self.totSPointsFromTurnovers,
            totSPointsInThePaint: totSPointsInThePaint ?? self.totSPointsInThePaint,
            totSPointsSecondChance: totSPointsSecondChance ?? self.totSPointsSecondChance,
            totSReboundsDefensive: totSReboundsDefensive ?? self.totSReboundsDefensive,
            totSReboundsOffensive: totSReboundsOffensive ?? self.totSReboundsOffensive,
            totSReboundsTeam: totSReboundsTeam ?? self.totSReboundsTeam,
            totSReboundsTeamDefensive: totSReboundsTeamDefensive ?? self.totSReboundsTeamDefensive,
            totSReboundsTeamOffensive: totSReboundsTeamOffensive ?? self.totSReboundsTeamOffensive,
            totSReboundsTotal: totSReboundsTotal ?? self.totSReboundsTotal,
            totSSteals: totSSteals ?? self.totSSteals,
            totSThreePointersAttempted: totSThreePointersAttempted ?? self.totSThreePointersAttempted,
            totSThreePointersMade: totSThreePointersMade ?? self.totSThreePointersMade,
            totSThreePointersPercentage: totSThreePointersPercentage ?? self.totSThreePointersPercentage,
            totSTimeLeading: totSTimeLeading ?? self.totSTimeLeading,
            totSTimesScoresLevel: totSTimesScoresLevel ?? self.totSTimesScoresLevel,
            totSTurnovers: totSTurnovers ?? self.totSTurnovers,
            totSTurnoversTeam: totSTurnoversTeam ?? self.totSTurnoversTeam,
            totSTwoPointersAttempted: totSTwoPointersAttempted ?? self.totSTwoPointersAttempted,
            totSTwoPointersMade: totSTwoPointersMade ?? self.totSTwoPointersMade,
            totSTwoPointersPercentage: totSTwoPointersPercentage ?? self.totSTwoPointersPercentage
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Lds
struct Lds: Codable {
    let sAssists: [String: Scorer]
    let sBlocks: SBlocks
    let sPoints: [String: Scorer]
    let sReboundsTotal: [String: Scorer]
    let sSteals: [String: Scorer]

    enum CodingKeys: String, CodingKey {
        case sAssists = "sAssists"
        case sBlocks = "sBlocks"
        case sPoints = "sPoints"
        case sReboundsTotal = "sReboundsTotal"
        case sSteals = "sSteals"
    }
}

// MARK: Lds convenience initializers and mutators

extension Lds {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lds.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sAssists: [String: Scorer]? = nil,
        sBlocks: SBlocks? = nil,
        sPoints: [String: Scorer]? = nil,
        sReboundsTotal: [String: Scorer]? = nil,
        sSteals: [String: Scorer]? = nil
    ) -> Lds {
        return Lds(
            sAssists: sAssists ?? self.sAssists,
            sBlocks: sBlocks ?? self.sBlocks,
            sPoints: sPoints ?? self.sPoints,
            sReboundsTotal: sReboundsTotal ?? self.sReboundsTotal,
            sSteals: sSteals ?? self.sSteals
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SBlocks
struct SBlocks: Codable {
    let the1: Scorer

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

// MARK: SBlocks convenience initializers and mutators

extension SBlocks {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SBlocks.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        the1: Scorer? = nil
    ) -> SBlocks {
        return SBlocks(
            the1: the1 ?? self.the1
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pl
struct Pl: Codable {
    let active: Int
    let captain: Int?
    let comp: Comp?
    let eff1: Int
    let eff2: Int
    let eff3: Double
    let eff4: Double
    let eff5: Int
    let eff6: Int
    let eff7: Int
    let familyName: String
    let familyNameInitial: FamilyNameInitial
    let firstName: String
    let firstNameInitial: FirstNameInitial
    let internationalFamilyName: String
    let internationalFamilyNameInitial: FamilyNameInitial
    let internationalFirstName: String
    let internationalFirstNameInitial: FirstNameInitial
    let name: String
    let playingPosition: String
    let sAssists: Int
    let sBlocks: Int
    let sBlocksReceived: Int
    let sFieldGoalsAttempted: Int
    let sFieldGoalsMade: Int
    let sFieldGoalsPercentage: Int
    let sFoulsOn: Int
    let sFoulsPersonal: Int
    let sFreeThrowsAttempted: Int
    let sFreeThrowsMade: Int
    let sFreeThrowsPercentage: Int
    let sMinutes: SMinutes
    let sPlusMinusPoints: Int
    let sPoints: Int
    let sPointsFastBreak: Int
    let sPointsInThePaint: Int
    let sPointsSecondChance: Int
    let sReboundsDefensive: Int
    let sReboundsOffensive: Int
    let sReboundsTotal: Int
    let sSteals: Int
    let sThreePointersAttempted: Int
    let sThreePointersMade: Int
    let sThreePointersPercentage: Int
    let sTurnovers: Int
    let sTwoPointersAttempted: Int
    let sTwoPointersMade: Int
    let sTwoPointersPercentage: Int
    let shirtNumber: String
    let starter: Int

    enum CodingKeys: String, CodingKey {
        case active = "active"
        case captain = "captain"
        case comp = "comp"
        case eff1 = "eff_1"
        case eff2 = "eff_2"
        case eff3 = "eff_3"
        case eff4 = "eff_4"
        case eff5 = "eff_5"
        case eff6 = "eff_6"
        case eff7 = "eff_7"
        case familyName = "familyName"
        case familyNameInitial = "familyNameInitial"
        case firstName = "firstName"
        case firstNameInitial = "firstNameInitial"
        case internationalFamilyName = "internationalFamilyName"
        case internationalFamilyNameInitial = "internationalFamilyNameInitial"
        case internationalFirstName = "internationalFirstName"
        case internationalFirstNameInitial = "internationalFirstNameInitial"
        case name = "name"
        case playingPosition = "playingPosition"
        case sAssists = "sAssists"
        case sBlocks = "sBlocks"
        case sBlocksReceived = "sBlocksReceived"
        case sFieldGoalsAttempted = "sFieldGoalsAttempted"
        case sFieldGoalsMade = "sFieldGoalsMade"
        case sFieldGoalsPercentage = "sFieldGoalsPercentage"
        case sFoulsOn = "sFoulsOn"
        case sFoulsPersonal = "sFoulsPersonal"
        case sFreeThrowsAttempted = "sFreeThrowsAttempted"
        case sFreeThrowsMade = "sFreeThrowsMade"
        case sFreeThrowsPercentage = "sFreeThrowsPercentage"
        case sMinutes = "sMinutes"
        case sPlusMinusPoints = "sPlusMinusPoints"
        case sPoints = "sPoints"
        case sPointsFastBreak = "sPointsFastBreak"
        case sPointsInThePaint = "sPointsInThePaint"
        case sPointsSecondChance = "sPointsSecondChance"
        case sReboundsDefensive = "sReboundsDefensive"
        case sReboundsOffensive = "sReboundsOffensive"
        case sReboundsTotal = "sReboundsTotal"
        case sSteals = "sSteals"
        case sThreePointersAttempted = "sThreePointersAttempted"
        case sThreePointersMade = "sThreePointersMade"
        case sThreePointersPercentage = "sThreePointersPercentage"
        case sTurnovers = "sTurnovers"
        case sTwoPointersAttempted = "sTwoPointersAttempted"
        case sTwoPointersMade = "sTwoPointersMade"
        case sTwoPointersPercentage = "sTwoPointersPercentage"
        case shirtNumber = "shirtNumber"
        case starter = "starter"
    }
}

// MARK: Pl convenience initializers and mutators

extension Pl {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pl.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        active: Int? = nil,
        captain: Int?? = nil,
        comp: Comp?? = nil,
        eff1: Int? = nil,
        eff2: Int? = nil,
        eff3: Double? = nil,
        eff4: Double? = nil,
        eff5: Int? = nil,
        eff6: Int? = nil,
        eff7: Int? = nil,
        familyName: String? = nil,
        familyNameInitial: FamilyNameInitial? = nil,
        firstName: String? = nil,
        firstNameInitial: FirstNameInitial? = nil,
        internationalFamilyName: String? = nil,
        internationalFamilyNameInitial: FamilyNameInitial? = nil,
        internationalFirstName: String? = nil,
        internationalFirstNameInitial: FirstNameInitial? = nil,
        name: String? = nil,
        playingPosition: String? = nil,
        sAssists: Int? = nil,
        sBlocks: Int? = nil,
        sBlocksReceived: Int? = nil,
        sFieldGoalsAttempted: Int? = nil,
        sFieldGoalsMade: Int? = nil,
        sFieldGoalsPercentage: Int? = nil,
        sFoulsOn: Int? = nil,
        sFoulsPersonal: Int? = nil,
        sFreeThrowsAttempted: Int? = nil,
        sFreeThrowsMade: Int? = nil,
        sFreeThrowsPercentage: Int? = nil,
        sMinutes: SMinutes? = nil,
        sPlusMinusPoints: Int? = nil,
        sPoints: Int? = nil,
        sPointsFastBreak: Int? = nil,
        sPointsInThePaint: Int? = nil,
        sPointsSecondChance: Int? = nil,
        sReboundsDefensive: Int? = nil,
        sReboundsOffensive: Int? = nil,
        sReboundsTotal: Int? = nil,
        sSteals: Int? = nil,
        sThreePointersAttempted: Int? = nil,
        sThreePointersMade: Int? = nil,
        sThreePointersPercentage: Int? = nil,
        sTurnovers: Int? = nil,
        sTwoPointersAttempted: Int? = nil,
        sTwoPointersMade: Int? = nil,
        sTwoPointersPercentage: Int? = nil,
        shirtNumber: String? = nil,
        starter: Int? = nil
    ) -> Pl {
        return Pl(
            active: active ?? self.active,
            captain: captain ?? self.captain,
            comp: comp ?? self.comp,
            eff1: eff1 ?? self.eff1,
            eff2: eff2 ?? self.eff2,
            eff3: eff3 ?? self.eff3,
            eff4: eff4 ?? self.eff4,
            eff5: eff5 ?? self.eff5,
            eff6: eff6 ?? self.eff6,
            eff7: eff7 ?? self.eff7,
            familyName: familyName ?? self.familyName,
            familyNameInitial: familyNameInitial ?? self.familyNameInitial,
            firstName: firstName ?? self.firstName,
            firstNameInitial: firstNameInitial ?? self.firstNameInitial,
            internationalFamilyName: internationalFamilyName ?? self.internationalFamilyName,
            internationalFamilyNameInitial: internationalFamilyNameInitial ?? self.internationalFamilyNameInitial,
            internationalFirstName: internationalFirstName ?? self.internationalFirstName,
            internationalFirstNameInitial: internationalFirstNameInitial ?? self.internationalFirstNameInitial,
            name: name ?? self.name,
            playingPosition: playingPosition ?? self.playingPosition,
            sAssists: sAssists ?? self.sAssists,
            sBlocks: sBlocks ?? self.sBlocks,
            sBlocksReceived: sBlocksReceived ?? self.sBlocksReceived,
            sFieldGoalsAttempted: sFieldGoalsAttempted ?? self.sFieldGoalsAttempted,
            sFieldGoalsMade: sFieldGoalsMade ?? self.sFieldGoalsMade,
            sFieldGoalsPercentage: sFieldGoalsPercentage ?? self.sFieldGoalsPercentage,
            sFoulsOn: sFoulsOn ?? self.sFoulsOn,
            sFoulsPersonal: sFoulsPersonal ?? self.sFoulsPersonal,
            sFreeThrowsAttempted: sFreeThrowsAttempted ?? self.sFreeThrowsAttempted,
            sFreeThrowsMade: sFreeThrowsMade ?? self.sFreeThrowsMade,
            sFreeThrowsPercentage: sFreeThrowsPercentage ?? self.sFreeThrowsPercentage,
            sMinutes: sMinutes ?? self.sMinutes,
            sPlusMinusPoints: sPlusMinusPoints ?? self.sPlusMinusPoints,
            sPoints: sPoints ?? self.sPoints,
            sPointsFastBreak: sPointsFastBreak ?? self.sPointsFastBreak,
            sPointsInThePaint: sPointsInThePaint ?? self.sPointsInThePaint,
            sPointsSecondChance: sPointsSecondChance ?? self.sPointsSecondChance,
            sReboundsDefensive: sReboundsDefensive ?? self.sReboundsDefensive,
            sReboundsOffensive: sReboundsOffensive ?? self.sReboundsOffensive,
            sReboundsTotal: sReboundsTotal ?? self.sReboundsTotal,
            sSteals: sSteals ?? self.sSteals,
            sThreePointersAttempted: sThreePointersAttempted ?? self.sThreePointersAttempted,
            sThreePointersMade: sThreePointersMade ?? self.sThreePointersMade,
            sThreePointersPercentage: sThreePointersPercentage ?? self.sThreePointersPercentage,
            sTurnovers: sTurnovers ?? self.sTurnovers,
            sTwoPointersAttempted: sTwoPointersAttempted ?? self.sTwoPointersAttempted,
            sTwoPointersMade: sTwoPointersMade ?? self.sTwoPointersMade,
            sTwoPointersPercentage: sTwoPointersPercentage ?? self.sTwoPointersPercentage,
            shirtNumber: shirtNumber ?? self.shirtNumber,
            starter: starter ?? self.starter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Comp
struct Comp: Codable {
    let sAssistsAverage: Double
    let sMinutesAverage: String
    let sPointsAverage: Double
    let sReboundsTotalAverage: Double

    enum CodingKeys: String, CodingKey {
        case sAssistsAverage = "sAssistsAverage"
        case sMinutesAverage = "sMinutesAverage"
        case sPointsAverage = "sPointsAverage"
        case sReboundsTotalAverage = "sReboundsTotalAverage"
    }
}

// MARK: Comp convenience initializers and mutators

extension Comp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sAssistsAverage: Double? = nil,
        sMinutesAverage: String? = nil,
        sPointsAverage: Double? = nil,
        sReboundsTotalAverage: Double? = nil
    ) -> Comp {
        return Comp(
            sAssistsAverage: sAssistsAverage ?? self.sAssistsAverage,
            sMinutesAverage: sMinutesAverage ?? self.sMinutesAverage,
            sPointsAverage: sPointsAverage ?? self.sPointsAverage,
            sReboundsTotalAverage: sReboundsTotalAverage ?? self.sReboundsTotalAverage
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum SMinutes: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(SMinutes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SMinutes"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Shot
struct Shot: Codable {
    let actionType: ActionType
    let p: Int
    let per: Int
    let perType: PerType
    let player: String
    let pno: Int
    let r: Int
    let shirtNumber: String
    let subType: SubType
    let tno: Int
    let x: Int
    let y: Int

    enum CodingKeys: String, CodingKey {
        case actionType = "actionType"
        case p = "p"
        case per = "per"
        case perType = "perType"
        case player = "player"
        case pno = "pno"
        case r = "r"
        case shirtNumber = "shirtNumber"
        case subType = "subType"
        case tno = "tno"
        case x = "x"
        case y = "y"
    }
}

// MARK: Shot convenience initializers and mutators

extension Shot {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Shot.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        actionType: ActionType? = nil,
        p: Int? = nil,
        per: Int? = nil,
        perType: PerType? = nil,
        player: String? = nil,
        pno: Int? = nil,
        r: Int? = nil,
        shirtNumber: String? = nil,
        subType: SubType? = nil,
        tno: Int? = nil,
        x: Int? = nil,
        y: Int? = nil
    ) -> Shot {
        return Shot(
            actionType: actionType ?? self.actionType,
            p: p ?? self.p,
            per: per ?? self.per,
            perType: perType ?? self.perType,
            player: player ?? self.player,
            pno: pno ?? self.pno,
            r: r ?? self.r,
            shirtNumber: shirtNumber ?? self.shirtNumber,
            subType: subType ?? self.subType,
            tno: tno ?? self.tno,
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum SubType: String, Codable {
    case jumpshot = "jumpshot"
    case layup = "layup"
    case dunk = "dunk"
}

// MARK: - Totallds
struct Totallds: Codable {
    let sAssists: [String: Scorer]
    let sBlocks: [String: Scorer]
    let sPoints: [String: Scorer]
    let sReboundsTotal: [String: Scorer]
    let sSteals: [String: Scorer]

    enum CodingKeys: String, CodingKey {
        case sAssists = "sAssists"
        case sBlocks = "sBlocks"
        case sPoints = "sPoints"
        case sReboundsTotal = "sReboundsTotal"
        case sSteals = "sSteals"
    }
}

// MARK: Totallds convenience initializers and mutators

extension Totallds {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Totallds.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sAssists: [String: Scorer]? = nil,
        sBlocks: [String: Scorer]? = nil,
        sPoints: [String: Scorer]? = nil,
        sReboundsTotal: [String: Scorer]? = nil,
        sSteals: [String: Scorer]? = nil
    ) -> Totallds {
        return Totallds(
            sAssists: sAssists ?? self.sAssists,
            sBlocks: sBlocks ?? self.sBlocks,
            sPoints: sPoints ?? self.sPoints,
            sReboundsTotal: sReboundsTotal ?? self.sReboundsTotal,
            sSteals: sSteals ?? self.sSteals
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
    })
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    encoder.dateEncodingStrategy = .formatted(formatter)
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
