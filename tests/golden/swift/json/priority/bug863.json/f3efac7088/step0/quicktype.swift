// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

enum TopLevelUnion: Codable {
    case fluffyTopLevel(FluffyTopLevel)
    case purpleTopLevelArray([PurpleTopLevel])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([PurpleTopLevel].self) {
            self = .purpleTopLevelArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(FluffyTopLevel.self) {
            self = .fluffyTopLevel(x)
            return
        }
        throw DecodingError.typeMismatch(TopLevelUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TopLevelUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffyTopLevel(let x):
            try container.encode(x)
        case .purpleTopLevelArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PurpleTopLevel
struct PurpleTopLevel: Codable {
    let alienlevel: Int
    let breed: Breed
    let charDimension: Int
    let charInstance: Int
    let defenderRankTitle: String
    let firstname: Firstname
    let headid: Int
    let lastname: Lastname
    let levelx: Int
    let name: String
    let prof: String
    let profTitle: String
    let pvprating: Int
    let pvptitle: Pvptitle
    let rank: Int
    let rankTitle: RankTitle
    let sex: Sex

    enum CodingKeys: String, CodingKey {
        case alienlevel = "ALIENLEVEL"
        case breed = "BREED"
        case charDimension = "CHAR_DIMENSION"
        case charInstance = "CHAR_INSTANCE"
        case defenderRankTitle = "DEFENDER_RANK_TITLE"
        case firstname = "FIRSTNAME"
        case headid = "HEADID"
        case lastname = "LASTNAME"
        case levelx = "LEVELX"
        case name = "NAME"
        case prof = "PROF"
        case profTitle = "PROF_TITLE"
        case pvprating = "PVPRATING"
        case pvptitle = "PVPTITLE"
        case rank = "RANK"
        case rankTitle = "RANK_TITLE"
        case sex = "SEX"
    }
}

// MARK: PurpleTopLevel convenience initializers and mutators

extension PurpleTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleTopLevel.self, from: data)
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
        alienlevel: Int? = nil,
        breed: Breed? = nil,
        charDimension: Int? = nil,
        charInstance: Int? = nil,
        defenderRankTitle: String? = nil,
        firstname: Firstname? = nil,
        headid: Int? = nil,
        lastname: Lastname? = nil,
        levelx: Int? = nil,
        name: String? = nil,
        prof: String? = nil,
        profTitle: String? = nil,
        pvprating: Int? = nil,
        pvptitle: Pvptitle? = nil,
        rank: Int? = nil,
        rankTitle: RankTitle? = nil,
        sex: Sex? = nil
    ) -> PurpleTopLevel {
        return PurpleTopLevel(
            alienlevel: alienlevel ?? self.alienlevel,
            breed: breed ?? self.breed,
            charDimension: charDimension ?? self.charDimension,
            charInstance: charInstance ?? self.charInstance,
            defenderRankTitle: defenderRankTitle ?? self.defenderRankTitle,
            firstname: firstname ?? self.firstname,
            headid: headid ?? self.headid,
            lastname: lastname ?? self.lastname,
            levelx: levelx ?? self.levelx,
            name: name ?? self.name,
            prof: prof ?? self.prof,
            profTitle: profTitle ?? self.profTitle,
            pvprating: pvprating ?? self.pvprating,
            pvptitle: pvptitle ?? self.pvptitle,
            rank: rank ?? self.rank,
            rankTitle: rankTitle ?? self.rankTitle,
            sex: sex ?? self.sex
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Breed: String, Codable {
    case atrox = "Atrox"
    case solitus = "Solitus"
    case opifex = "Opifex"
    case nano = "Nano"
}

enum Firstname: String, Codable {
    case empty = ""
    case chi = "Chi"
}

enum Lastname: String, Codable {
    case empty = ""
    case washko = "Washko"
}

enum Pvptitle: String, Codable {
    case freshman = "Freshman"
}

enum RankTitle: String, Codable {
    case president = "President"
    case advisor = "Advisor"
    case veteran = "Veteran"
    case applicant = "Applicant"
}

enum Sex: String, Codable {
    case neuter = "Neuter"
    case male = "Male"
    case female = "Female"
}

// MARK: - FluffyTopLevel
struct FluffyTopLevel: Codable {
    let adventurercount: Int
    let agentcount: Int
    let atroxcount: Int
    let avglvl: Double
    let btcount: Int
    let description: String
    let doctorcount: Int
    let enfcount: Int
    let engineeercount: Int
    let femalecount: Int
    let fixercount: Int
    let governingname: String
    let history: String
    let keepercount: Int
    let macount: Int
    let malecount: Int
    let maxlvl: Int
    let metacount: Int
    let minlvl: Int
    let monstercount: Int
    let name: String
    let nanocount: Int
    let nanoracecount: Int
    let neutercount: Int
    let nummembers: Int
    let objective: String
    let opifexcount: Int
    let orgDimension: Int
    let orgInstance: Int
    let shadecount: Int
    let side: Int
    let sideName: String
    let solidercount: Int
    let solituscount: Int
    let tradercount: Int

    enum CodingKeys: String, CodingKey {
        case adventurercount = "ADVENTURERCOUNT"
        case agentcount = "AGENTCOUNT"
        case atroxcount = "ATROXCOUNT"
        case avglvl = "AVGLVL"
        case btcount = "BTCOUNT"
        case description = "DESCRIPTION"
        case doctorcount = "DOCTORCOUNT"
        case enfcount = "ENFCOUNT"
        case engineeercount = "ENGINEEERCOUNT"
        case femalecount = "FEMALECOUNT"
        case fixercount = "FIXERCOUNT"
        case governingname = "GOVERNINGNAME"
        case history = "HISTORY"
        case keepercount = "KEEPERCOUNT"
        case macount = "MACOUNT"
        case malecount = "MALECOUNT"
        case maxlvl = "MAXLVL"
        case metacount = "METACOUNT"
        case minlvl = "MINLVL"
        case monstercount = "MONSTERCOUNT"
        case name = "NAME"
        case nanocount = "NANOCOUNT"
        case nanoracecount = "NANORACECOUNT"
        case neutercount = "NEUTERCOUNT"
        case nummembers = "NUMMEMBERS"
        case objective = "OBJECTIVE"
        case opifexcount = "OPIFEXCOUNT"
        case orgDimension = "ORG_DIMENSION"
        case orgInstance = "ORG_INSTANCE"
        case shadecount = "SHADECOUNT"
        case side = "SIDE"
        case sideName = "SIDE_NAME"
        case solidercount = "SOLIDERCOUNT"
        case solituscount = "SOLITUSCOUNT"
        case tradercount = "TRADERCOUNT"
    }
}

// MARK: FluffyTopLevel convenience initializers and mutators

extension FluffyTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyTopLevel.self, from: data)
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
        adventurercount: Int? = nil,
        agentcount: Int? = nil,
        atroxcount: Int? = nil,
        avglvl: Double? = nil,
        btcount: Int? = nil,
        description: String? = nil,
        doctorcount: Int? = nil,
        enfcount: Int? = nil,
        engineeercount: Int? = nil,
        femalecount: Int? = nil,
        fixercount: Int? = nil,
        governingname: String? = nil,
        history: String? = nil,
        keepercount: Int? = nil,
        macount: Int? = nil,
        malecount: Int? = nil,
        maxlvl: Int? = nil,
        metacount: Int? = nil,
        minlvl: Int? = nil,
        monstercount: Int? = nil,
        name: String? = nil,
        nanocount: Int? = nil,
        nanoracecount: Int? = nil,
        neutercount: Int? = nil,
        nummembers: Int? = nil,
        objective: String? = nil,
        opifexcount: Int? = nil,
        orgDimension: Int? = nil,
        orgInstance: Int? = nil,
        shadecount: Int? = nil,
        side: Int? = nil,
        sideName: String? = nil,
        solidercount: Int? = nil,
        solituscount: Int? = nil,
        tradercount: Int? = nil
    ) -> FluffyTopLevel {
        return FluffyTopLevel(
            adventurercount: adventurercount ?? self.adventurercount,
            agentcount: agentcount ?? self.agentcount,
            atroxcount: atroxcount ?? self.atroxcount,
            avglvl: avglvl ?? self.avglvl,
            btcount: btcount ?? self.btcount,
            description: description ?? self.description,
            doctorcount: doctorcount ?? self.doctorcount,
            enfcount: enfcount ?? self.enfcount,
            engineeercount: engineeercount ?? self.engineeercount,
            femalecount: femalecount ?? self.femalecount,
            fixercount: fixercount ?? self.fixercount,
            governingname: governingname ?? self.governingname,
            history: history ?? self.history,
            keepercount: keepercount ?? self.keepercount,
            macount: macount ?? self.macount,
            malecount: malecount ?? self.malecount,
            maxlvl: maxlvl ?? self.maxlvl,
            metacount: metacount ?? self.metacount,
            minlvl: minlvl ?? self.minlvl,
            monstercount: monstercount ?? self.monstercount,
            name: name ?? self.name,
            nanocount: nanocount ?? self.nanocount,
            nanoracecount: nanoracecount ?? self.nanoracecount,
            neutercount: neutercount ?? self.neutercount,
            nummembers: nummembers ?? self.nummembers,
            objective: objective ?? self.objective,
            opifexcount: opifexcount ?? self.opifexcount,
            orgDimension: orgDimension ?? self.orgDimension,
            orgInstance: orgInstance ?? self.orgInstance,
            shadecount: shadecount ?? self.shadecount,
            side: side ?? self.side,
            sideName: sideName ?? self.sideName,
            solidercount: solidercount ?? self.solidercount,
            solituscount: solituscount ?? self.solituscount,
            tradercount: tradercount ?? self.tradercount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias TopLevel = [TopLevelUnion]

extension Array where Element == TopLevel.Element {
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
