// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
final class TopLevel: Codable, Sendable {
    let abranchiata: [Abranchiata]
    let academe: [Academe]
    let acquirable: [Acquirable]
    let aerometry: [Aerometry]
    let alexin: [Alexin]
    let alleviate: [AlleviateElement]
    let amaas: [Amaa]
    let ambassage: [Ambassage]
    let amphithyron: [Amphithyron?]
    let andriana: [String?]
    let ankee: [AnkeeElement]
    let annihilator: [[String: Int?]?]
    let annulose: JSONNull?
    let ansarie: [AnsarieElement]
    let aphasia: [Aphasia]
    let asprawl: [Asprawl]
    let attractive: [Bool?]
    let barksome: [String: Int]
    let bedesman: [Bedesman]
    let belard: [Belard]
    let bocking: [Bocking]
    let brawlingly: [Brawlingly]
    let brookie: [Brookie]
    let bumboatman: [Bumboatman]
    let bystreet: [JSONNull?]
    let calaverite: [Calaverite]
    let catallactic: [Catallactic]
    let cemental: [Cemental]
    let chytridiaceae: [ChytridiaceaeElement]
    let discordia: [DiscordiaElement]
    let endomyces: [Endomyce]
    let epinephelidae: [Epinephelidae]
    let eupatorium: [Eupatorium]
    let gryphosaurus: [GryphosaurusElement]
    let koryak: [Koryak]
    let lavinia: [LaviniaElement]
    let oskar: [OskarElement]
    let rebecca: [RebeccaElement]
    let rhomboganoidei: [Rhomboganoidei]
    let rigsmal: Bool
    let ruellia: [Ruellia]
    let school: [School]
    let shakespearolater: [Shakespearolater]
    let svan: [Double]
    let wayao: [String: Double]

    enum CodingKeys: String, CodingKey {
        case abranchiata = "Abranchiata"
        case academe = "academe"
        case acquirable = "acquirable"
        case aerometry = "aerometry"
        case alexin = "alexin"
        case alleviate = "alleviate"
        case amaas = "amaas"
        case ambassage = "ambassage"
        case amphithyron = "amphithyron"
        case andriana = "Andriana"
        case ankee = "ankee"
        case annihilator = "annihilator"
        case annulose = "annulose"
        case ansarie = "Ansarie"
        case aphasia = "aphasia"
        case asprawl = "asprawl"
        case attractive = "attractive"
        case barksome = "barksome"
        case bedesman = "bedesman"
        case belard = "belard"
        case bocking = "bocking"
        case brawlingly = "brawlingly"
        case brookie = "brookie"
        case bumboatman = "bumboatman"
        case bystreet = "bystreet"
        case calaverite = "calaverite"
        case catallactic = "catallactic"
        case cemental = "cemental"
        case chytridiaceae = "Chytridiaceae"
        case discordia = "Discordia"
        case endomyces = "Endomyces"
        case epinephelidae = "Epinephelidae"
        case eupatorium = "Eupatorium"
        case gryphosaurus = "Gryphosaurus"
        case koryak = "Koryak"
        case lavinia = "Lavinia"
        case oskar = "Oskar"
        case rebecca = "Rebecca"
        case rhomboganoidei = "Rhomboganoidei"
        case rigsmal = "Rigsmal"
        case ruellia = "Ruellia"
        case school = "School"
        case shakespearolater = "Shakespearolater"
        case svan = "Svan"
        case wayao = "Wayao"
    }

    init(abranchiata: [Abranchiata], academe: [Academe], acquirable: [Acquirable], aerometry: [Aerometry], alexin: [Alexin], alleviate: [AlleviateElement], amaas: [Amaa], ambassage: [Ambassage], amphithyron: [Amphithyron?], andriana: [String?], ankee: [AnkeeElement], annihilator: [[String: Int?]?], annulose: JSONNull?, ansarie: [AnsarieElement], aphasia: [Aphasia], asprawl: [Asprawl], attractive: [Bool?], barksome: [String: Int], bedesman: [Bedesman], belard: [Belard], bocking: [Bocking], brawlingly: [Brawlingly], brookie: [Brookie], bumboatman: [Bumboatman], bystreet: [JSONNull?], calaverite: [Calaverite], catallactic: [Catallactic], cemental: [Cemental], chytridiaceae: [ChytridiaceaeElement], discordia: [DiscordiaElement], endomyces: [Endomyce], epinephelidae: [Epinephelidae], eupatorium: [Eupatorium], gryphosaurus: [GryphosaurusElement], koryak: [Koryak], lavinia: [LaviniaElement], oskar: [OskarElement], rebecca: [RebeccaElement], rhomboganoidei: [Rhomboganoidei], rigsmal: Bool, ruellia: [Ruellia], school: [School], shakespearolater: [Shakespearolater], svan: [Double], wayao: [String: Double]) {
        self.abranchiata = abranchiata
        self.academe = academe
        self.acquirable = acquirable
        self.aerometry = aerometry
        self.alexin = alexin
        self.alleviate = alleviate
        self.amaas = amaas
        self.ambassage = ambassage
        self.amphithyron = amphithyron
        self.andriana = andriana
        self.ankee = ankee
        self.annihilator = annihilator
        self.annulose = annulose
        self.ansarie = ansarie
        self.aphasia = aphasia
        self.asprawl = asprawl
        self.attractive = attractive
        self.barksome = barksome
        self.bedesman = bedesman
        self.belard = belard
        self.bocking = bocking
        self.brawlingly = brawlingly
        self.brookie = brookie
        self.bumboatman = bumboatman
        self.bystreet = bystreet
        self.calaverite = calaverite
        self.catallactic = catallactic
        self.cemental = cemental
        self.chytridiaceae = chytridiaceae
        self.discordia = discordia
        self.endomyces = endomyces
        self.epinephelidae = epinephelidae
        self.eupatorium = eupatorium
        self.gryphosaurus = gryphosaurus
        self.koryak = koryak
        self.lavinia = lavinia
        self.oskar = oskar
        self.rebecca = rebecca
        self.rhomboganoidei = rhomboganoidei
        self.rigsmal = rigsmal
        self.ruellia = ruellia
        self.school = school
        self.shakespearolater = shakespearolater
        self.svan = svan
        self.wayao = wayao
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TopLevel.self, from: data)
        self.init(abranchiata: me.abranchiata, academe: me.academe, acquirable: me.acquirable, aerometry: me.aerometry, alexin: me.alexin, alleviate: me.alleviate, amaas: me.amaas, ambassage: me.ambassage, amphithyron: me.amphithyron, andriana: me.andriana, ankee: me.ankee, annihilator: me.annihilator, annulose: me.annulose, ansarie: me.ansarie, aphasia: me.aphasia, asprawl: me.asprawl, attractive: me.attractive, barksome: me.barksome, bedesman: me.bedesman, belard: me.belard, bocking: me.bocking, brawlingly: me.brawlingly, brookie: me.brookie, bumboatman: me.bumboatman, bystreet: me.bystreet, calaverite: me.calaverite, catallactic: me.catallactic, cemental: me.cemental, chytridiaceae: me.chytridiaceae, discordia: me.discordia, endomyces: me.endomyces, epinephelidae: me.epinephelidae, eupatorium: me.eupatorium, gryphosaurus: me.gryphosaurus, koryak: me.koryak, lavinia: me.lavinia, oskar: me.oskar, rebecca: me.rebecca, rhomboganoidei: me.rhomboganoidei, rigsmal: me.rigsmal, ruellia: me.ruellia, school: me.school, shakespearolater: me.shakespearolater, svan: me.svan, wayao: me.wayao)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        abranchiata: [Abranchiata]? = nil,
        academe: [Academe]? = nil,
        acquirable: [Acquirable]? = nil,
        aerometry: [Aerometry]? = nil,
        alexin: [Alexin]? = nil,
        alleviate: [AlleviateElement]? = nil,
        amaas: [Amaa]? = nil,
        ambassage: [Ambassage]? = nil,
        amphithyron: [Amphithyron?]? = nil,
        andriana: [String?]? = nil,
        ankee: [AnkeeElement]? = nil,
        annihilator: [[String: Int?]?]? = nil,
        annulose: JSONNull?? = nil,
        ansarie: [AnsarieElement]? = nil,
        aphasia: [Aphasia]? = nil,
        asprawl: [Asprawl]? = nil,
        attractive: [Bool?]? = nil,
        barksome: [String: Int]? = nil,
        bedesman: [Bedesman]? = nil,
        belard: [Belard]? = nil,
        bocking: [Bocking]? = nil,
        brawlingly: [Brawlingly]? = nil,
        brookie: [Brookie]? = nil,
        bumboatman: [Bumboatman]? = nil,
        bystreet: [JSONNull?]? = nil,
        calaverite: [Calaverite]? = nil,
        catallactic: [Catallactic]? = nil,
        cemental: [Cemental]? = nil,
        chytridiaceae: [ChytridiaceaeElement]? = nil,
        discordia: [DiscordiaElement]? = nil,
        endomyces: [Endomyce]? = nil,
        epinephelidae: [Epinephelidae]? = nil,
        eupatorium: [Eupatorium]? = nil,
        gryphosaurus: [GryphosaurusElement]? = nil,
        koryak: [Koryak]? = nil,
        lavinia: [LaviniaElement]? = nil,
        oskar: [OskarElement]? = nil,
        rebecca: [RebeccaElement]? = nil,
        rhomboganoidei: [Rhomboganoidei]? = nil,
        rigsmal: Bool? = nil,
        ruellia: [Ruellia]? = nil,
        school: [School]? = nil,
        shakespearolater: [Shakespearolater]? = nil,
        svan: [Double]? = nil,
        wayao: [String: Double]? = nil
    ) -> TopLevel {
        return TopLevel(
            abranchiata: abranchiata ?? self.abranchiata,
            academe: academe ?? self.academe,
            acquirable: acquirable ?? self.acquirable,
            aerometry: aerometry ?? self.aerometry,
            alexin: alexin ?? self.alexin,
            alleviate: alleviate ?? self.alleviate,
            amaas: amaas ?? self.amaas,
            ambassage: ambassage ?? self.ambassage,
            amphithyron: amphithyron ?? self.amphithyron,
            andriana: andriana ?? self.andriana,
            ankee: ankee ?? self.ankee,
            annihilator: annihilator ?? self.annihilator,
            annulose: annulose ?? self.annulose,
            ansarie: ansarie ?? self.ansarie,
            aphasia: aphasia ?? self.aphasia,
            asprawl: asprawl ?? self.asprawl,
            attractive: attractive ?? self.attractive,
            barksome: barksome ?? self.barksome,
            bedesman: bedesman ?? self.bedesman,
            belard: belard ?? self.belard,
            bocking: bocking ?? self.bocking,
            brawlingly: brawlingly ?? self.brawlingly,
            brookie: brookie ?? self.brookie,
            bumboatman: bumboatman ?? self.bumboatman,
            bystreet: bystreet ?? self.bystreet,
            calaverite: calaverite ?? self.calaverite,
            catallactic: catallactic ?? self.catallactic,
            cemental: cemental ?? self.cemental,
            chytridiaceae: chytridiaceae ?? self.chytridiaceae,
            discordia: discordia ?? self.discordia,
            endomyces: endomyces ?? self.endomyces,
            epinephelidae: epinephelidae ?? self.epinephelidae,
            eupatorium: eupatorium ?? self.eupatorium,
            gryphosaurus: gryphosaurus ?? self.gryphosaurus,
            koryak: koryak ?? self.koryak,
            lavinia: lavinia ?? self.lavinia,
            oskar: oskar ?? self.oskar,
            rebecca: rebecca ?? self.rebecca,
            rhomboganoidei: rhomboganoidei ?? self.rhomboganoidei,
            rigsmal: rigsmal ?? self.rigsmal,
            ruellia: ruellia ?? self.ruellia,
            school: school ?? self.school,
            shakespearolater: shakespearolater ?? self.shakespearolater,
            svan: svan ?? self.svan,
            wayao: wayao ?? self.wayao
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Abranchiata: Codable, Sendable {
    case integer(Int)
    case integerArray([Int])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Abranchiata.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Abranchiata"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Academe: Codable, Sendable {
    case integer(Int)
    case integerArray([Int])
    case integerMap([String: Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Academe.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Academe"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Acquirable: Codable, Sendable {
    case integerMap([String: Int])
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Acquirable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Acquirable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum Aerometry: Codable, Sendable {
    case bool(Bool)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Aerometry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Aerometry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

enum Alexin: Codable, Sendable {
    case bool(Bool)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        throw DecodingError.typeMismatch(Alexin.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Alexin"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

enum AlleviateElement: Codable, Sendable {
    case alleviateClass(AlleviateClass)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(AlleviateClass.self) {
            self = .alleviateClass(x)
            return
        }
        throw DecodingError.typeMismatch(AlleviateElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AlleviateElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .alleviateClass(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AlleviateClass
final class AlleviateClass: Codable, Sendable {
    let apriori: JSONNull?
    let beggarer: JSONNull?
    let brokenheartedly: JSONNull?
    let debilitation: JSONNull?
    let frike: JSONNull?
    let gastrolith: JSONNull?
    let hulsean: JSONNull?
    let orthocentric: JSONNull?
    let petaly: JSONNull?
    let probudgeting: JSONNull?
    let reacquire: JSONNull?
    let scow: JSONNull?
    let shutoff: JSONNull?
    let subcontiguous: JSONNull?
    let suffumigate: JSONNull?
    let transformable: JSONNull?
    let uncoroneted: JSONNull?
    let unparking: JSONNull?
    let unvarnishedness: JSONNull?
    let wherewithal: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apriori = "apriori"
        case beggarer = "beggarer"
        case brokenheartedly = "brokenheartedly"
        case debilitation = "debilitation"
        case frike = "frike"
        case gastrolith = "gastrolith"
        case hulsean = "Hulsean"
        case orthocentric = "orthocentric"
        case petaly = "petaly"
        case probudgeting = "probudgeting"
        case reacquire = "reacquire"
        case scow = "scow"
        case shutoff = "shutoff"
        case subcontiguous = "subcontiguous"
        case suffumigate = "suffumigate"
        case transformable = "transformable"
        case uncoroneted = "uncoroneted"
        case unparking = "unparking"
        case unvarnishedness = "unvarnishedness"
        case wherewithal = "wherewithal"
    }

    init(apriori: JSONNull?, beggarer: JSONNull?, brokenheartedly: JSONNull?, debilitation: JSONNull?, frike: JSONNull?, gastrolith: JSONNull?, hulsean: JSONNull?, orthocentric: JSONNull?, petaly: JSONNull?, probudgeting: JSONNull?, reacquire: JSONNull?, scow: JSONNull?, shutoff: JSONNull?, subcontiguous: JSONNull?, suffumigate: JSONNull?, transformable: JSONNull?, uncoroneted: JSONNull?, unparking: JSONNull?, unvarnishedness: JSONNull?, wherewithal: JSONNull?) {
        self.apriori = apriori
        self.beggarer = beggarer
        self.brokenheartedly = brokenheartedly
        self.debilitation = debilitation
        self.frike = frike
        self.gastrolith = gastrolith
        self.hulsean = hulsean
        self.orthocentric = orthocentric
        self.petaly = petaly
        self.probudgeting = probudgeting
        self.reacquire = reacquire
        self.scow = scow
        self.shutoff = shutoff
        self.subcontiguous = subcontiguous
        self.suffumigate = suffumigate
        self.transformable = transformable
        self.uncoroneted = uncoroneted
        self.unparking = unparking
        self.unvarnishedness = unvarnishedness
        self.wherewithal = wherewithal
    }
}

// MARK: AlleviateClass convenience initializers and mutators

extension AlleviateClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AlleviateClass.self, from: data)
        self.init(apriori: me.apriori, beggarer: me.beggarer, brokenheartedly: me.brokenheartedly, debilitation: me.debilitation, frike: me.frike, gastrolith: me.gastrolith, hulsean: me.hulsean, orthocentric: me.orthocentric, petaly: me.petaly, probudgeting: me.probudgeting, reacquire: me.reacquire, scow: me.scow, shutoff: me.shutoff, subcontiguous: me.subcontiguous, suffumigate: me.suffumigate, transformable: me.transformable, uncoroneted: me.uncoroneted, unparking: me.unparking, unvarnishedness: me.unvarnishedness, wherewithal: me.wherewithal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        apriori: JSONNull?? = nil,
        beggarer: JSONNull?? = nil,
        brokenheartedly: JSONNull?? = nil,
        debilitation: JSONNull?? = nil,
        frike: JSONNull?? = nil,
        gastrolith: JSONNull?? = nil,
        hulsean: JSONNull?? = nil,
        orthocentric: JSONNull?? = nil,
        petaly: JSONNull?? = nil,
        probudgeting: JSONNull?? = nil,
        reacquire: JSONNull?? = nil,
        scow: JSONNull?? = nil,
        shutoff: JSONNull?? = nil,
        subcontiguous: JSONNull?? = nil,
        suffumigate: JSONNull?? = nil,
        transformable: JSONNull?? = nil,
        uncoroneted: JSONNull?? = nil,
        unparking: JSONNull?? = nil,
        unvarnishedness: JSONNull?? = nil,
        wherewithal: JSONNull?? = nil
    ) -> AlleviateClass {
        return AlleviateClass(
            apriori: apriori ?? self.apriori,
            beggarer: beggarer ?? self.beggarer,
            brokenheartedly: brokenheartedly ?? self.brokenheartedly,
            debilitation: debilitation ?? self.debilitation,
            frike: frike ?? self.frike,
            gastrolith: gastrolith ?? self.gastrolith,
            hulsean: hulsean ?? self.hulsean,
            orthocentric: orthocentric ?? self.orthocentric,
            petaly: petaly ?? self.petaly,
            probudgeting: probudgeting ?? self.probudgeting,
            reacquire: reacquire ?? self.reacquire,
            scow: scow ?? self.scow,
            shutoff: shutoff ?? self.shutoff,
            subcontiguous: subcontiguous ?? self.subcontiguous,
            suffumigate: suffumigate ?? self.suffumigate,
            transformable: transformable ?? self.transformable,
            uncoroneted: uncoroneted ?? self.uncoroneted,
            unparking: unparking ?? self.unparking,
            unvarnishedness: unvarnishedness ?? self.unvarnishedness,
            wherewithal: wherewithal ?? self.wherewithal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Amaa: Codable, Sendable {
    case bool(Bool)
    case integer(Int)
    case rebecca(Rebecca)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(Amaa.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Amaa"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Rebecca
final class Rebecca: Codable, Sendable {
    let catharticalness: Double
    let chirotherium: Int
    let disdiapason: String
    let homocerc: Bool
    let nonbookish: JSONNull?

    enum CodingKeys: String, CodingKey {
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case homocerc = "homocerc"
        case nonbookish = "nonbookish"
    }

    init(catharticalness: Double, chirotherium: Int, disdiapason: String, homocerc: Bool, nonbookish: JSONNull?) {
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.homocerc = homocerc
        self.nonbookish = nonbookish
    }
}

// MARK: Rebecca convenience initializers and mutators

extension Rebecca {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Rebecca.self, from: data)
        self.init(catharticalness: me.catharticalness, chirotherium: me.chirotherium, disdiapason: me.disdiapason, homocerc: me.homocerc, nonbookish: me.nonbookish)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        catharticalness: Double? = nil,
        chirotherium: Int? = nil,
        disdiapason: String? = nil,
        homocerc: Bool? = nil,
        nonbookish: JSONNull?? = nil
    ) -> Rebecca {
        return Rebecca(
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            homocerc: homocerc ?? self.homocerc,
            nonbookish: nonbookish ?? self.nonbookish
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Ambassage: Codable, Sendable {
    case nullArray([JSONNull?])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Ambassage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ambassage"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Amphithyron
final class Amphithyron: Codable, Sendable {
    let akroasis: Int?
    let antiphonical: Int?
    let basebred: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let conductometric: Int?
    let disdiapason: String?
    let ensilation: Int?
    let eyebolt: Int?
    let fistulated: Int?
    let heteropod: Int?
    let homocerc: Bool?
    let juniperus: Int?
    let labyrinthically: Int?
    let martyrization: Int?
    let mispolicy: Int?
    let multipara: Int?
    let nazirite: Int?
    let nonbookish: JSONNull?
    let possessorial: Int?
    let shamed: Int?
    let shelfworn: Int?
    let stagnum: Int?
    let those: Int?
    let undecimal: Int?

    enum CodingKeys: String, CodingKey {
        case akroasis = "akroasis"
        case antiphonical = "antiphonical"
        case basebred = "basebred"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case conductometric = "conductometric"
        case disdiapason = "disdiapason"
        case ensilation = "ensilation"
        case eyebolt = "eyebolt"
        case fistulated = "fistulated"
        case heteropod = "heteropod"
        case homocerc = "homocerc"
        case juniperus = "Juniperus"
        case labyrinthically = "labyrinthically"
        case martyrization = "martyrization"
        case mispolicy = "mispolicy"
        case multipara = "multipara"
        case nazirite = "Nazirite"
        case nonbookish = "nonbookish"
        case possessorial = "possessorial"
        case shamed = "shamed"
        case shelfworn = "shelfworn"
        case stagnum = "stagnum"
        case those = "Those"
        case undecimal = "undecimal"
    }

    init(akroasis: Int?, antiphonical: Int?, basebred: Int?, catharticalness: Double?, chirotherium: Int?, conductometric: Int?, disdiapason: String?, ensilation: Int?, eyebolt: Int?, fistulated: Int?, heteropod: Int?, homocerc: Bool?, juniperus: Int?, labyrinthically: Int?, martyrization: Int?, mispolicy: Int?, multipara: Int?, nazirite: Int?, nonbookish: JSONNull?, possessorial: Int?, shamed: Int?, shelfworn: Int?, stagnum: Int?, those: Int?, undecimal: Int?) {
        self.akroasis = akroasis
        self.antiphonical = antiphonical
        self.basebred = basebred
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.conductometric = conductometric
        self.disdiapason = disdiapason
        self.ensilation = ensilation
        self.eyebolt = eyebolt
        self.fistulated = fistulated
        self.heteropod = heteropod
        self.homocerc = homocerc
        self.juniperus = juniperus
        self.labyrinthically = labyrinthically
        self.martyrization = martyrization
        self.mispolicy = mispolicy
        self.multipara = multipara
        self.nazirite = nazirite
        self.nonbookish = nonbookish
        self.possessorial = possessorial
        self.shamed = shamed
        self.shelfworn = shelfworn
        self.stagnum = stagnum
        self.those = those
        self.undecimal = undecimal
    }
}

// MARK: Amphithyron convenience initializers and mutators

extension Amphithyron {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Amphithyron.self, from: data)
        self.init(akroasis: me.akroasis, antiphonical: me.antiphonical, basebred: me.basebred, catharticalness: me.catharticalness, chirotherium: me.chirotherium, conductometric: me.conductometric, disdiapason: me.disdiapason, ensilation: me.ensilation, eyebolt: me.eyebolt, fistulated: me.fistulated, heteropod: me.heteropod, homocerc: me.homocerc, juniperus: me.juniperus, labyrinthically: me.labyrinthically, martyrization: me.martyrization, mispolicy: me.mispolicy, multipara: me.multipara, nazirite: me.nazirite, nonbookish: me.nonbookish, possessorial: me.possessorial, shamed: me.shamed, shelfworn: me.shelfworn, stagnum: me.stagnum, those: me.those, undecimal: me.undecimal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        akroasis: Int?? = nil,
        antiphonical: Int?? = nil,
        basebred: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        conductometric: Int?? = nil,
        disdiapason: String?? = nil,
        ensilation: Int?? = nil,
        eyebolt: Int?? = nil,
        fistulated: Int?? = nil,
        heteropod: Int?? = nil,
        homocerc: Bool?? = nil,
        juniperus: Int?? = nil,
        labyrinthically: Int?? = nil,
        martyrization: Int?? = nil,
        mispolicy: Int?? = nil,
        multipara: Int?? = nil,
        nazirite: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        possessorial: Int?? = nil,
        shamed: Int?? = nil,
        shelfworn: Int?? = nil,
        stagnum: Int?? = nil,
        those: Int?? = nil,
        undecimal: Int?? = nil
    ) -> Amphithyron {
        return Amphithyron(
            akroasis: akroasis ?? self.akroasis,
            antiphonical: antiphonical ?? self.antiphonical,
            basebred: basebred ?? self.basebred,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            conductometric: conductometric ?? self.conductometric,
            disdiapason: disdiapason ?? self.disdiapason,
            ensilation: ensilation ?? self.ensilation,
            eyebolt: eyebolt ?? self.eyebolt,
            fistulated: fistulated ?? self.fistulated,
            heteropod: heteropod ?? self.heteropod,
            homocerc: homocerc ?? self.homocerc,
            juniperus: juniperus ?? self.juniperus,
            labyrinthically: labyrinthically ?? self.labyrinthically,
            martyrization: martyrization ?? self.martyrization,
            mispolicy: mispolicy ?? self.mispolicy,
            multipara: multipara ?? self.multipara,
            nazirite: nazirite ?? self.nazirite,
            nonbookish: nonbookish ?? self.nonbookish,
            possessorial: possessorial ?? self.possessorial,
            shamed: shamed ?? self.shamed,
            shelfworn: shelfworn ?? self.shelfworn,
            stagnum: stagnum ?? self.stagnum,
            those: those ?? self.those,
            undecimal: undecimal ?? self.undecimal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum AnkeeElement: Codable, Sendable {
    case ankeeClass(AnkeeClass)
    case integer(Int)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(AnkeeClass.self) {
            self = .ankeeClass(x)
            return
        }
        throw DecodingError.typeMismatch(AnkeeElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnkeeElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .ankeeClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AnkeeClass
final class AnkeeClass: Codable, Sendable {
    let anomoean: JSONNull?
    let barleyhood: JSONNull?
    let befriender: JSONNull?
    let brutishness: JSONNull?
    let cephalalgy: JSONNull?
    let cirurgian: JSONNull?
    let conventionally: JSONNull?
    let jackshay: JSONNull?
    let milammeter: JSONNull?
    let naja: JSONNull?
    let ombrological: JSONNull?
    let phonasthenia: JSONNull?
    let retrievableness: JSONNull?
    let snakily: JSONNull?
    let swot: JSONNull?
    let tartlet: JSONNull?
    let thiofuran: JSONNull?
    let tracheophone: JSONNull?
    let tuglike: JSONNull?
    let unscratchingly: JSONNull?

    enum CodingKeys: String, CodingKey {
        case anomoean = "Anomoean"
        case barleyhood = "barleyhood"
        case befriender = "befriender"
        case brutishness = "brutishness"
        case cephalalgy = "cephalalgy"
        case cirurgian = "cirurgian"
        case conventionally = "conventionally"
        case jackshay = "jackshay"
        case milammeter = "milammeter"
        case naja = "Naja"
        case ombrological = "ombrological"
        case phonasthenia = "phonasthenia"
        case retrievableness = "retrievableness"
        case snakily = "snakily"
        case swot = "swot"
        case tartlet = "tartlet"
        case thiofuran = "thiofuran"
        case tracheophone = "tracheophone"
        case tuglike = "tuglike"
        case unscratchingly = "unscratchingly"
    }

    init(anomoean: JSONNull?, barleyhood: JSONNull?, befriender: JSONNull?, brutishness: JSONNull?, cephalalgy: JSONNull?, cirurgian: JSONNull?, conventionally: JSONNull?, jackshay: JSONNull?, milammeter: JSONNull?, naja: JSONNull?, ombrological: JSONNull?, phonasthenia: JSONNull?, retrievableness: JSONNull?, snakily: JSONNull?, swot: JSONNull?, tartlet: JSONNull?, thiofuran: JSONNull?, tracheophone: JSONNull?, tuglike: JSONNull?, unscratchingly: JSONNull?) {
        self.anomoean = anomoean
        self.barleyhood = barleyhood
        self.befriender = befriender
        self.brutishness = brutishness
        self.cephalalgy = cephalalgy
        self.cirurgian = cirurgian
        self.conventionally = conventionally
        self.jackshay = jackshay
        self.milammeter = milammeter
        self.naja = naja
        self.ombrological = ombrological
        self.phonasthenia = phonasthenia
        self.retrievableness = retrievableness
        self.snakily = snakily
        self.swot = swot
        self.tartlet = tartlet
        self.thiofuran = thiofuran
        self.tracheophone = tracheophone
        self.tuglike = tuglike
        self.unscratchingly = unscratchingly
    }
}

// MARK: AnkeeClass convenience initializers and mutators

extension AnkeeClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AnkeeClass.self, from: data)
        self.init(anomoean: me.anomoean, barleyhood: me.barleyhood, befriender: me.befriender, brutishness: me.brutishness, cephalalgy: me.cephalalgy, cirurgian: me.cirurgian, conventionally: me.conventionally, jackshay: me.jackshay, milammeter: me.milammeter, naja: me.naja, ombrological: me.ombrological, phonasthenia: me.phonasthenia, retrievableness: me.retrievableness, snakily: me.snakily, swot: me.swot, tartlet: me.tartlet, thiofuran: me.thiofuran, tracheophone: me.tracheophone, tuglike: me.tuglike, unscratchingly: me.unscratchingly)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        anomoean: JSONNull?? = nil,
        barleyhood: JSONNull?? = nil,
        befriender: JSONNull?? = nil,
        brutishness: JSONNull?? = nil,
        cephalalgy: JSONNull?? = nil,
        cirurgian: JSONNull?? = nil,
        conventionally: JSONNull?? = nil,
        jackshay: JSONNull?? = nil,
        milammeter: JSONNull?? = nil,
        naja: JSONNull?? = nil,
        ombrological: JSONNull?? = nil,
        phonasthenia: JSONNull?? = nil,
        retrievableness: JSONNull?? = nil,
        snakily: JSONNull?? = nil,
        swot: JSONNull?? = nil,
        tartlet: JSONNull?? = nil,
        thiofuran: JSONNull?? = nil,
        tracheophone: JSONNull?? = nil,
        tuglike: JSONNull?? = nil,
        unscratchingly: JSONNull?? = nil
    ) -> AnkeeClass {
        return AnkeeClass(
            anomoean: anomoean ?? self.anomoean,
            barleyhood: barleyhood ?? self.barleyhood,
            befriender: befriender ?? self.befriender,
            brutishness: brutishness ?? self.brutishness,
            cephalalgy: cephalalgy ?? self.cephalalgy,
            cirurgian: cirurgian ?? self.cirurgian,
            conventionally: conventionally ?? self.conventionally,
            jackshay: jackshay ?? self.jackshay,
            milammeter: milammeter ?? self.milammeter,
            naja: naja ?? self.naja,
            ombrological: ombrological ?? self.ombrological,
            phonasthenia: phonasthenia ?? self.phonasthenia,
            retrievableness: retrievableness ?? self.retrievableness,
            snakily: snakily ?? self.snakily,
            swot: swot ?? self.swot,
            tartlet: tartlet ?? self.tartlet,
            thiofuran: thiofuran ?? self.thiofuran,
            tracheophone: tracheophone ?? self.tracheophone,
            tuglike: tuglike ?? self.tuglike,
            unscratchingly: unscratchingly ?? self.unscratchingly
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum AnsarieElement: Codable, Sendable {
    case ansarieClass(AnsarieClass)
    case integerArray([Int])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(AnsarieClass.self) {
            self = .ansarieClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(AnsarieElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnsarieElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .ansarieClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - AnsarieClass
final class AnsarieClass: Codable, Sendable {
    let accension: JSONNull?
    let alida: JSONNull?
    let asteria: JSONNull?
    let beriberic: JSONNull?
    let edgebone: JSONNull?
    let gastrodialysis: JSONNull?
    let geographic: JSONNull?
    let ictonyx: JSONNull?
    let metrocele: JSONNull?
    let misgraft: JSONNull?
    let monteith: JSONNull?
    let notcher: JSONNull?
    let prorestriction: JSONNull?
    let ramist: JSONNull?
    let throatlet: JSONNull?
    let unfair: JSONNull?
    let unsynonymous: JSONNull?
    let water: JSONNull?
    let zestfully: JSONNull?
    let zincic: JSONNull?

    enum CodingKeys: String, CodingKey {
        case accension = "accension"
        case alida = "Alida"
        case asteria = "asteria"
        case beriberic = "beriberic"
        case edgebone = "edgebone"
        case gastrodialysis = "gastrodialysis"
        case geographic = "geographic"
        case ictonyx = "Ictonyx"
        case metrocele = "metrocele"
        case misgraft = "misgraft"
        case monteith = "monteith"
        case notcher = "notcher"
        case prorestriction = "prorestriction"
        case ramist = "Ramist"
        case throatlet = "throatlet"
        case unfair = "unfair"
        case unsynonymous = "unsynonymous"
        case water = "water"
        case zestfully = "zestfully"
        case zincic = "zincic"
    }

    init(accension: JSONNull?, alida: JSONNull?, asteria: JSONNull?, beriberic: JSONNull?, edgebone: JSONNull?, gastrodialysis: JSONNull?, geographic: JSONNull?, ictonyx: JSONNull?, metrocele: JSONNull?, misgraft: JSONNull?, monteith: JSONNull?, notcher: JSONNull?, prorestriction: JSONNull?, ramist: JSONNull?, throatlet: JSONNull?, unfair: JSONNull?, unsynonymous: JSONNull?, water: JSONNull?, zestfully: JSONNull?, zincic: JSONNull?) {
        self.accension = accension
        self.alida = alida
        self.asteria = asteria
        self.beriberic = beriberic
        self.edgebone = edgebone
        self.gastrodialysis = gastrodialysis
        self.geographic = geographic
        self.ictonyx = ictonyx
        self.metrocele = metrocele
        self.misgraft = misgraft
        self.monteith = monteith
        self.notcher = notcher
        self.prorestriction = prorestriction
        self.ramist = ramist
        self.throatlet = throatlet
        self.unfair = unfair
        self.unsynonymous = unsynonymous
        self.water = water
        self.zestfully = zestfully
        self.zincic = zincic
    }
}

// MARK: AnsarieClass convenience initializers and mutators

extension AnsarieClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AnsarieClass.self, from: data)
        self.init(accension: me.accension, alida: me.alida, asteria: me.asteria, beriberic: me.beriberic, edgebone: me.edgebone, gastrodialysis: me.gastrodialysis, geographic: me.geographic, ictonyx: me.ictonyx, metrocele: me.metrocele, misgraft: me.misgraft, monteith: me.monteith, notcher: me.notcher, prorestriction: me.prorestriction, ramist: me.ramist, throatlet: me.throatlet, unfair: me.unfair, unsynonymous: me.unsynonymous, water: me.water, zestfully: me.zestfully, zincic: me.zincic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        accension: JSONNull?? = nil,
        alida: JSONNull?? = nil,
        asteria: JSONNull?? = nil,
        beriberic: JSONNull?? = nil,
        edgebone: JSONNull?? = nil,
        gastrodialysis: JSONNull?? = nil,
        geographic: JSONNull?? = nil,
        ictonyx: JSONNull?? = nil,
        metrocele: JSONNull?? = nil,
        misgraft: JSONNull?? = nil,
        monteith: JSONNull?? = nil,
        notcher: JSONNull?? = nil,
        prorestriction: JSONNull?? = nil,
        ramist: JSONNull?? = nil,
        throatlet: JSONNull?? = nil,
        unfair: JSONNull?? = nil,
        unsynonymous: JSONNull?? = nil,
        water: JSONNull?? = nil,
        zestfully: JSONNull?? = nil,
        zincic: JSONNull?? = nil
    ) -> AnsarieClass {
        return AnsarieClass(
            accension: accension ?? self.accension,
            alida: alida ?? self.alida,
            asteria: asteria ?? self.asteria,
            beriberic: beriberic ?? self.beriberic,
            edgebone: edgebone ?? self.edgebone,
            gastrodialysis: gastrodialysis ?? self.gastrodialysis,
            geographic: geographic ?? self.geographic,
            ictonyx: ictonyx ?? self.ictonyx,
            metrocele: metrocele ?? self.metrocele,
            misgraft: misgraft ?? self.misgraft,
            monteith: monteith ?? self.monteith,
            notcher: notcher ?? self.notcher,
            prorestriction: prorestriction ?? self.prorestriction,
            ramist: ramist ?? self.ramist,
            throatlet: throatlet ?? self.throatlet,
            unfair: unfair ?? self.unfair,
            unsynonymous: unsynonymous ?? self.unsynonymous,
            water: water ?? self.water,
            zestfully: zestfully ?? self.zestfully,
            zincic: zincic ?? self.zincic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Aphasia: Codable, Sendable {
    case integer(Int)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        throw DecodingError.typeMismatch(Aphasia.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Aphasia"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

enum Asprawl: Codable, Sendable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Asprawl.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Asprawl"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Bedesman: Codable, Sendable {
    case bool(Bool)
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Bedesman.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Bedesman"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Belard: Codable, Sendable {
    case double(Double)
    case integerArray([Int])
    case rebecca(Rebecca)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(Belard.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Belard"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        }
    }
}

enum Bocking: Codable, Sendable {
    case bool(Bool)
    case integerArray([Int])
    case integerMap([String: Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Bocking.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Bocking"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Brawlingly: Codable, Sendable {
    case nullArray([JSONNull?])
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        throw DecodingError.typeMismatch(Brawlingly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Brawlingly"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

enum Brookie: Codable, Sendable {
    case integerArray([Int])
    case rebecca(Rebecca)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(Brookie.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Brookie"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        }
    }
}

enum Bumboatman: Codable, Sendable {
    case nullArray([JSONNull?])
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Bumboatman.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Bumboatman"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Calaverite: Codable, Sendable {
    case integerArray([Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Calaverite.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Calaverite"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Catallactic: Codable, Sendable {
    case bool(Bool)
    case integerMap([String: Int])
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Catallactic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Catallactic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum Cemental: Codable, Sendable {
    case double(Double)
    case integerArray([Int])
    case integerMap([String: Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Cemental.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Cemental"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum ChytridiaceaeElement: Codable, Sendable {
    case bool(Bool)
    case chytridiaceaeClass(ChytridiaceaeClass)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(ChytridiaceaeClass.self) {
            self = .chytridiaceaeClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(ChytridiaceaeElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ChytridiaceaeElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .chytridiaceaeClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - ChytridiaceaeClass
final class ChytridiaceaeClass: Codable, Sendable {
    let batidaceae: JSONNull?
    let brechites: JSONNull?
    let codespairer: JSONNull?
    let emery: JSONNull?
    let enervative: JSONNull?
    let excriminate: JSONNull?
    let goshenite: JSONNull?
    let grime: JSONNull?
    let gritten: JSONNull?
    let hectorly: JSONNull?
    let intermediation: JSONNull?
    let meeterly: JSONNull?
    let narraganset: JSONNull?
    let onymatic: JSONNull?
    let paddlecock: JSONNull?
    let thana: JSONNull?
    let thornily: JSONNull?
    let uckia: JSONNull?
    let unmettle: JSONNull?
    let vorticellid: JSONNull?

    enum CodingKeys: String, CodingKey {
        case batidaceae = "Batidaceae"
        case brechites = "Brechites"
        case codespairer = "codespairer"
        case emery = "Emery"
        case enervative = "enervative"
        case excriminate = "excriminate"
        case goshenite = "goshenite"
        case grime = "grime"
        case gritten = "gritten"
        case hectorly = "hectorly"
        case intermediation = "intermediation"
        case meeterly = "meeterly"
        case narraganset = "Narraganset"
        case onymatic = "onymatic"
        case paddlecock = "paddlecock"
        case thana = "thana"
        case thornily = "thornily"
        case uckia = "uckia"
        case unmettle = "unmettle"
        case vorticellid = "vorticellid"
    }

    init(batidaceae: JSONNull?, brechites: JSONNull?, codespairer: JSONNull?, emery: JSONNull?, enervative: JSONNull?, excriminate: JSONNull?, goshenite: JSONNull?, grime: JSONNull?, gritten: JSONNull?, hectorly: JSONNull?, intermediation: JSONNull?, meeterly: JSONNull?, narraganset: JSONNull?, onymatic: JSONNull?, paddlecock: JSONNull?, thana: JSONNull?, thornily: JSONNull?, uckia: JSONNull?, unmettle: JSONNull?, vorticellid: JSONNull?) {
        self.batidaceae = batidaceae
        self.brechites = brechites
        self.codespairer = codespairer
        self.emery = emery
        self.enervative = enervative
        self.excriminate = excriminate
        self.goshenite = goshenite
        self.grime = grime
        self.gritten = gritten
        self.hectorly = hectorly
        self.intermediation = intermediation
        self.meeterly = meeterly
        self.narraganset = narraganset
        self.onymatic = onymatic
        self.paddlecock = paddlecock
        self.thana = thana
        self.thornily = thornily
        self.uckia = uckia
        self.unmettle = unmettle
        self.vorticellid = vorticellid
    }
}

// MARK: ChytridiaceaeClass convenience initializers and mutators

extension ChytridiaceaeClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChytridiaceaeClass.self, from: data)
        self.init(batidaceae: me.batidaceae, brechites: me.brechites, codespairer: me.codespairer, emery: me.emery, enervative: me.enervative, excriminate: me.excriminate, goshenite: me.goshenite, grime: me.grime, gritten: me.gritten, hectorly: me.hectorly, intermediation: me.intermediation, meeterly: me.meeterly, narraganset: me.narraganset, onymatic: me.onymatic, paddlecock: me.paddlecock, thana: me.thana, thornily: me.thornily, uckia: me.uckia, unmettle: me.unmettle, vorticellid: me.vorticellid)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        batidaceae: JSONNull?? = nil,
        brechites: JSONNull?? = nil,
        codespairer: JSONNull?? = nil,
        emery: JSONNull?? = nil,
        enervative: JSONNull?? = nil,
        excriminate: JSONNull?? = nil,
        goshenite: JSONNull?? = nil,
        grime: JSONNull?? = nil,
        gritten: JSONNull?? = nil,
        hectorly: JSONNull?? = nil,
        intermediation: JSONNull?? = nil,
        meeterly: JSONNull?? = nil,
        narraganset: JSONNull?? = nil,
        onymatic: JSONNull?? = nil,
        paddlecock: JSONNull?? = nil,
        thana: JSONNull?? = nil,
        thornily: JSONNull?? = nil,
        uckia: JSONNull?? = nil,
        unmettle: JSONNull?? = nil,
        vorticellid: JSONNull?? = nil
    ) -> ChytridiaceaeClass {
        return ChytridiaceaeClass(
            batidaceae: batidaceae ?? self.batidaceae,
            brechites: brechites ?? self.brechites,
            codespairer: codespairer ?? self.codespairer,
            emery: emery ?? self.emery,
            enervative: enervative ?? self.enervative,
            excriminate: excriminate ?? self.excriminate,
            goshenite: goshenite ?? self.goshenite,
            grime: grime ?? self.grime,
            gritten: gritten ?? self.gritten,
            hectorly: hectorly ?? self.hectorly,
            intermediation: intermediation ?? self.intermediation,
            meeterly: meeterly ?? self.meeterly,
            narraganset: narraganset ?? self.narraganset,
            onymatic: onymatic ?? self.onymatic,
            paddlecock: paddlecock ?? self.paddlecock,
            thana: thana ?? self.thana,
            thornily: thornily ?? self.thornily,
            uckia: uckia ?? self.uckia,
            unmettle: unmettle ?? self.unmettle,
            vorticellid: vorticellid ?? self.vorticellid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum DiscordiaElement: Codable, Sendable {
    case discordiaClass(DiscordiaClass)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(DiscordiaClass.self) {
            self = .discordiaClass(x)
            return
        }
        throw DecodingError.typeMismatch(DiscordiaElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DiscordiaElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .discordiaClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DiscordiaClass
final class DiscordiaClass: Codable, Sendable {
    let altaic: Int?
    let amoristic: Int?
    let blennophthalmia: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let disciplinability: Int?
    let disdiapason: String?
    let goofer: Int?
    let homocerc: Bool?
    let laryngograph: Int?
    let leucitis: Int?
    let lymphocyst: Int?
    let microcosmology: Int?
    let nauseation: Int?
    let nonbookish: JSONNull?
    let patarin: Int?
    let preliberal: Int?
    let prettifier: Int?
    let rangework: Int?
    let redient: Int?
    let subfusiform: Int?
    let suicidical: Int?
    let swow: Int?
    let wastrel: Int?
    let wingle: Int?

    enum CodingKeys: String, CodingKey {
        case altaic = "Altaic"
        case amoristic = "amoristic"
        case blennophthalmia = "blennophthalmia"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disciplinability = "disciplinability"
        case disdiapason = "disdiapason"
        case goofer = "goofer"
        case homocerc = "homocerc"
        case laryngograph = "laryngograph"
        case leucitis = "leucitis"
        case lymphocyst = "lymphocyst"
        case microcosmology = "microcosmology"
        case nauseation = "nauseation"
        case nonbookish = "nonbookish"
        case patarin = "Patarin"
        case preliberal = "preliberal"
        case prettifier = "prettifier"
        case rangework = "rangework"
        case redient = "redient"
        case subfusiform = "subfusiform"
        case suicidical = "suicidical"
        case swow = "swow"
        case wastrel = "wastrel"
        case wingle = "wingle"
    }

    init(altaic: Int?, amoristic: Int?, blennophthalmia: Int?, catharticalness: Double?, chirotherium: Int?, disciplinability: Int?, disdiapason: String?, goofer: Int?, homocerc: Bool?, laryngograph: Int?, leucitis: Int?, lymphocyst: Int?, microcosmology: Int?, nauseation: Int?, nonbookish: JSONNull?, patarin: Int?, preliberal: Int?, prettifier: Int?, rangework: Int?, redient: Int?, subfusiform: Int?, suicidical: Int?, swow: Int?, wastrel: Int?, wingle: Int?) {
        self.altaic = altaic
        self.amoristic = amoristic
        self.blennophthalmia = blennophthalmia
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disciplinability = disciplinability
        self.disdiapason = disdiapason
        self.goofer = goofer
        self.homocerc = homocerc
        self.laryngograph = laryngograph
        self.leucitis = leucitis
        self.lymphocyst = lymphocyst
        self.microcosmology = microcosmology
        self.nauseation = nauseation
        self.nonbookish = nonbookish
        self.patarin = patarin
        self.preliberal = preliberal
        self.prettifier = prettifier
        self.rangework = rangework
        self.redient = redient
        self.subfusiform = subfusiform
        self.suicidical = suicidical
        self.swow = swow
        self.wastrel = wastrel
        self.wingle = wingle
    }
}

// MARK: DiscordiaClass convenience initializers and mutators

extension DiscordiaClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DiscordiaClass.self, from: data)
        self.init(altaic: me.altaic, amoristic: me.amoristic, blennophthalmia: me.blennophthalmia, catharticalness: me.catharticalness, chirotherium: me.chirotherium, disciplinability: me.disciplinability, disdiapason: me.disdiapason, goofer: me.goofer, homocerc: me.homocerc, laryngograph: me.laryngograph, leucitis: me.leucitis, lymphocyst: me.lymphocyst, microcosmology: me.microcosmology, nauseation: me.nauseation, nonbookish: me.nonbookish, patarin: me.patarin, preliberal: me.preliberal, prettifier: me.prettifier, rangework: me.rangework, redient: me.redient, subfusiform: me.subfusiform, suicidical: me.suicidical, swow: me.swow, wastrel: me.wastrel, wingle: me.wingle)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        altaic: Int?? = nil,
        amoristic: Int?? = nil,
        blennophthalmia: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        disciplinability: Int?? = nil,
        disdiapason: String?? = nil,
        goofer: Int?? = nil,
        homocerc: Bool?? = nil,
        laryngograph: Int?? = nil,
        leucitis: Int?? = nil,
        lymphocyst: Int?? = nil,
        microcosmology: Int?? = nil,
        nauseation: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        patarin: Int?? = nil,
        preliberal: Int?? = nil,
        prettifier: Int?? = nil,
        rangework: Int?? = nil,
        redient: Int?? = nil,
        subfusiform: Int?? = nil,
        suicidical: Int?? = nil,
        swow: Int?? = nil,
        wastrel: Int?? = nil,
        wingle: Int?? = nil
    ) -> DiscordiaClass {
        return DiscordiaClass(
            altaic: altaic ?? self.altaic,
            amoristic: amoristic ?? self.amoristic,
            blennophthalmia: blennophthalmia ?? self.blennophthalmia,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            disciplinability: disciplinability ?? self.disciplinability,
            disdiapason: disdiapason ?? self.disdiapason,
            goofer: goofer ?? self.goofer,
            homocerc: homocerc ?? self.homocerc,
            laryngograph: laryngograph ?? self.laryngograph,
            leucitis: leucitis ?? self.leucitis,
            lymphocyst: lymphocyst ?? self.lymphocyst,
            microcosmology: microcosmology ?? self.microcosmology,
            nauseation: nauseation ?? self.nauseation,
            nonbookish: nonbookish ?? self.nonbookish,
            patarin: patarin ?? self.patarin,
            preliberal: preliberal ?? self.preliberal,
            prettifier: prettifier ?? self.prettifier,
            rangework: rangework ?? self.rangework,
            redient: redient ?? self.redient,
            subfusiform: subfusiform ?? self.subfusiform,
            suicidical: suicidical ?? self.suicidical,
            swow: swow ?? self.swow,
            wastrel: wastrel ?? self.wastrel,
            wingle: wingle ?? self.wingle
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Endomyce: Codable, Sendable {
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
        throw DecodingError.typeMismatch(Endomyce.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Endomyce"))
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

enum Epinephelidae: Codable, Sendable {
    case bool(Bool)
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Epinephelidae.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Epinephelidae"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Eupatorium: Codable, Sendable {
    case integerMap([String: Int])
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Eupatorium.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Eupatorium"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum GryphosaurusElement: Codable, Sendable {
    case gryphosaurusClass(GryphosaurusClass)
    case integerArray([Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(GryphosaurusClass.self) {
            self = .gryphosaurusClass(x)
            return
        }
        throw DecodingError.typeMismatch(GryphosaurusElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GryphosaurusElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .gryphosaurusClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GryphosaurusClass
final class GryphosaurusClass: Codable, Sendable {
    let amissibility: JSONNull?
    let burushaski: JSONNull?
    let citronin: JSONNull?
    let coplaintiff: JSONNull?
    let disquisitionary: JSONNull?
    let enoplan: JSONNull?
    let faintness: JSONNull?
    let hebetomy: JSONNull?
    let islandry: JSONNull?
    let lameduck: JSONNull?
    let overbattle: JSONNull?
    let overinterested: JSONNull?
    let phrenologic: JSONNull?
    let rainband: JSONNull?
    let shiningly: JSONNull?
    let stamineous: JSONNull?
    let subscapularis: JSONNull?
    let tahami: JSONNull?
    let undaubed: JSONNull?
    let underntime: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amissibility = "amissibility"
        case burushaski = "Burushaski"
        case citronin = "citronin"
        case coplaintiff = "coplaintiff"
        case disquisitionary = "disquisitionary"
        case enoplan = "enoplan"
        case faintness = "faintness"
        case hebetomy = "hebetomy"
        case islandry = "islandry"
        case lameduck = "lameduck"
        case overbattle = "overbattle"
        case overinterested = "overinterested"
        case phrenologic = "phrenologic"
        case rainband = "rainband"
        case shiningly = "shiningly"
        case stamineous = "stamineous"
        case subscapularis = "subscapularis"
        case tahami = "Tahami"
        case undaubed = "undaubed"
        case underntime = "underntime"
    }

    init(amissibility: JSONNull?, burushaski: JSONNull?, citronin: JSONNull?, coplaintiff: JSONNull?, disquisitionary: JSONNull?, enoplan: JSONNull?, faintness: JSONNull?, hebetomy: JSONNull?, islandry: JSONNull?, lameduck: JSONNull?, overbattle: JSONNull?, overinterested: JSONNull?, phrenologic: JSONNull?, rainband: JSONNull?, shiningly: JSONNull?, stamineous: JSONNull?, subscapularis: JSONNull?, tahami: JSONNull?, undaubed: JSONNull?, underntime: JSONNull?) {
        self.amissibility = amissibility
        self.burushaski = burushaski
        self.citronin = citronin
        self.coplaintiff = coplaintiff
        self.disquisitionary = disquisitionary
        self.enoplan = enoplan
        self.faintness = faintness
        self.hebetomy = hebetomy
        self.islandry = islandry
        self.lameduck = lameduck
        self.overbattle = overbattle
        self.overinterested = overinterested
        self.phrenologic = phrenologic
        self.rainband = rainband
        self.shiningly = shiningly
        self.stamineous = stamineous
        self.subscapularis = subscapularis
        self.tahami = tahami
        self.undaubed = undaubed
        self.underntime = underntime
    }
}

// MARK: GryphosaurusClass convenience initializers and mutators

extension GryphosaurusClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(GryphosaurusClass.self, from: data)
        self.init(amissibility: me.amissibility, burushaski: me.burushaski, citronin: me.citronin, coplaintiff: me.coplaintiff, disquisitionary: me.disquisitionary, enoplan: me.enoplan, faintness: me.faintness, hebetomy: me.hebetomy, islandry: me.islandry, lameduck: me.lameduck, overbattle: me.overbattle, overinterested: me.overinterested, phrenologic: me.phrenologic, rainband: me.rainband, shiningly: me.shiningly, stamineous: me.stamineous, subscapularis: me.subscapularis, tahami: me.tahami, undaubed: me.undaubed, underntime: me.underntime)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        amissibility: JSONNull?? = nil,
        burushaski: JSONNull?? = nil,
        citronin: JSONNull?? = nil,
        coplaintiff: JSONNull?? = nil,
        disquisitionary: JSONNull?? = nil,
        enoplan: JSONNull?? = nil,
        faintness: JSONNull?? = nil,
        hebetomy: JSONNull?? = nil,
        islandry: JSONNull?? = nil,
        lameduck: JSONNull?? = nil,
        overbattle: JSONNull?? = nil,
        overinterested: JSONNull?? = nil,
        phrenologic: JSONNull?? = nil,
        rainband: JSONNull?? = nil,
        shiningly: JSONNull?? = nil,
        stamineous: JSONNull?? = nil,
        subscapularis: JSONNull?? = nil,
        tahami: JSONNull?? = nil,
        undaubed: JSONNull?? = nil,
        underntime: JSONNull?? = nil
    ) -> GryphosaurusClass {
        return GryphosaurusClass(
            amissibility: amissibility ?? self.amissibility,
            burushaski: burushaski ?? self.burushaski,
            citronin: citronin ?? self.citronin,
            coplaintiff: coplaintiff ?? self.coplaintiff,
            disquisitionary: disquisitionary ?? self.disquisitionary,
            enoplan: enoplan ?? self.enoplan,
            faintness: faintness ?? self.faintness,
            hebetomy: hebetomy ?? self.hebetomy,
            islandry: islandry ?? self.islandry,
            lameduck: lameduck ?? self.lameduck,
            overbattle: overbattle ?? self.overbattle,
            overinterested: overinterested ?? self.overinterested,
            phrenologic: phrenologic ?? self.phrenologic,
            rainband: rainband ?? self.rainband,
            shiningly: shiningly ?? self.shiningly,
            stamineous: stamineous ?? self.stamineous,
            subscapularis: subscapularis ?? self.subscapularis,
            tahami: tahami ?? self.tahami,
            undaubed: undaubed ?? self.undaubed,
            underntime: underntime ?? self.underntime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Koryak: Codable, Sendable {
    case string(String)
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Koryak.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Koryak"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

enum LaviniaElement: Codable, Sendable {
    case laviniaClass(LaviniaClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(LaviniaClass.self) {
            self = .laviniaClass(x)
            return
        }
        throw DecodingError.typeMismatch(LaviniaElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LaviniaElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .laviniaClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LaviniaClass
final class LaviniaClass: Codable, Sendable {
    let agitable: Int?
    let asininity: Int?
    let benefiter: Int?
    let bronzelike: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let cholesteatomatous: Int?
    let deprivement: Int?
    let disdiapason: String?
    let flippantness: Int?
    let fogproof: Int?
    let homocerc: Bool?
    let merrymeeting: Int?
    let nonbookish: JSONNull?
    let overcareful: Int?
    let panaris: Int?
    let preacceptance: Int?
    let quinoxaline: Int?
    let sig: Int?
    let superconfusion: Int?
    let tacana: Int?
    let tillotter: Int?
    let tranquillize: Int?
    let unquestionable: Int?
    let uproute: Int?

    enum CodingKeys: String, CodingKey {
        case agitable = "agitable"
        case asininity = "asininity"
        case benefiter = "benefiter"
        case bronzelike = "bronzelike"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case cholesteatomatous = "cholesteatomatous"
        case deprivement = "deprivement"
        case disdiapason = "disdiapason"
        case flippantness = "flippantness"
        case fogproof = "fogproof"
        case homocerc = "homocerc"
        case merrymeeting = "merrymeeting"
        case nonbookish = "nonbookish"
        case overcareful = "overcareful"
        case panaris = "panaris"
        case preacceptance = "preacceptance"
        case quinoxaline = "quinoxaline"
        case sig = "sig"
        case superconfusion = "superconfusion"
        case tacana = "Tacana"
        case tillotter = "tillotter"
        case tranquillize = "tranquillize"
        case unquestionable = "unquestionable"
        case uproute = "uproute"
    }

    init(agitable: Int?, asininity: Int?, benefiter: Int?, bronzelike: Int?, catharticalness: Double?, chirotherium: Int?, cholesteatomatous: Int?, deprivement: Int?, disdiapason: String?, flippantness: Int?, fogproof: Int?, homocerc: Bool?, merrymeeting: Int?, nonbookish: JSONNull?, overcareful: Int?, panaris: Int?, preacceptance: Int?, quinoxaline: Int?, sig: Int?, superconfusion: Int?, tacana: Int?, tillotter: Int?, tranquillize: Int?, unquestionable: Int?, uproute: Int?) {
        self.agitable = agitable
        self.asininity = asininity
        self.benefiter = benefiter
        self.bronzelike = bronzelike
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.cholesteatomatous = cholesteatomatous
        self.deprivement = deprivement
        self.disdiapason = disdiapason
        self.flippantness = flippantness
        self.fogproof = fogproof
        self.homocerc = homocerc
        self.merrymeeting = merrymeeting
        self.nonbookish = nonbookish
        self.overcareful = overcareful
        self.panaris = panaris
        self.preacceptance = preacceptance
        self.quinoxaline = quinoxaline
        self.sig = sig
        self.superconfusion = superconfusion
        self.tacana = tacana
        self.tillotter = tillotter
        self.tranquillize = tranquillize
        self.unquestionable = unquestionable
        self.uproute = uproute
    }
}

// MARK: LaviniaClass convenience initializers and mutators

extension LaviniaClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(LaviniaClass.self, from: data)
        self.init(agitable: me.agitable, asininity: me.asininity, benefiter: me.benefiter, bronzelike: me.bronzelike, catharticalness: me.catharticalness, chirotherium: me.chirotherium, cholesteatomatous: me.cholesteatomatous, deprivement: me.deprivement, disdiapason: me.disdiapason, flippantness: me.flippantness, fogproof: me.fogproof, homocerc: me.homocerc, merrymeeting: me.merrymeeting, nonbookish: me.nonbookish, overcareful: me.overcareful, panaris: me.panaris, preacceptance: me.preacceptance, quinoxaline: me.quinoxaline, sig: me.sig, superconfusion: me.superconfusion, tacana: me.tacana, tillotter: me.tillotter, tranquillize: me.tranquillize, unquestionable: me.unquestionable, uproute: me.uproute)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        agitable: Int?? = nil,
        asininity: Int?? = nil,
        benefiter: Int?? = nil,
        bronzelike: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        cholesteatomatous: Int?? = nil,
        deprivement: Int?? = nil,
        disdiapason: String?? = nil,
        flippantness: Int?? = nil,
        fogproof: Int?? = nil,
        homocerc: Bool?? = nil,
        merrymeeting: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        overcareful: Int?? = nil,
        panaris: Int?? = nil,
        preacceptance: Int?? = nil,
        quinoxaline: Int?? = nil,
        sig: Int?? = nil,
        superconfusion: Int?? = nil,
        tacana: Int?? = nil,
        tillotter: Int?? = nil,
        tranquillize: Int?? = nil,
        unquestionable: Int?? = nil,
        uproute: Int?? = nil
    ) -> LaviniaClass {
        return LaviniaClass(
            agitable: agitable ?? self.agitable,
            asininity: asininity ?? self.asininity,
            benefiter: benefiter ?? self.benefiter,
            bronzelike: bronzelike ?? self.bronzelike,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            cholesteatomatous: cholesteatomatous ?? self.cholesteatomatous,
            deprivement: deprivement ?? self.deprivement,
            disdiapason: disdiapason ?? self.disdiapason,
            flippantness: flippantness ?? self.flippantness,
            fogproof: fogproof ?? self.fogproof,
            homocerc: homocerc ?? self.homocerc,
            merrymeeting: merrymeeting ?? self.merrymeeting,
            nonbookish: nonbookish ?? self.nonbookish,
            overcareful: overcareful ?? self.overcareful,
            panaris: panaris ?? self.panaris,
            preacceptance: preacceptance ?? self.preacceptance,
            quinoxaline: quinoxaline ?? self.quinoxaline,
            sig: sig ?? self.sig,
            superconfusion: superconfusion ?? self.superconfusion,
            tacana: tacana ?? self.tacana,
            tillotter: tillotter ?? self.tillotter,
            tranquillize: tranquillize ?? self.tranquillize,
            unquestionable: unquestionable ?? self.unquestionable,
            uproute: uproute ?? self.uproute
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum OskarElement: Codable, Sendable {
    case integerArray([Int])
    case oskarClass(OskarClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(OskarClass.self) {
            self = .oskarClass(x)
            return
        }
        throw DecodingError.typeMismatch(OskarElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OskarElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .oskarClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - OskarClass
final class OskarClass: Codable, Sendable {
    let acrobates: JSONNull?
    let beanshooter: JSONNull?
    let bearhound: JSONNull?
    let cayuga: JSONNull?
    let guarneri: JSONNull?
    let hypochondriacism: JSONNull?
    let indication: JSONNull?
    let jaculative: JSONNull?
    let nagana: JSONNull?
    let netherlandish: JSONNull?
    let noctivagous: JSONNull?
    let nonphysiological: JSONNull?
    let praxis: JSONNull?
    let provision: JSONNull?
    let subterhuman: JSONNull?
    let sunlit: JSONNull?
    let syncraniate: JSONNull?
    let teachment: JSONNull?
    let unmutinous: JSONNull?
    let unstoppable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acrobates = "Acrobates"
        case beanshooter = "beanshooter"
        case bearhound = "bearhound"
        case cayuga = "Cayuga"
        case guarneri = "guarneri"
        case hypochondriacism = "hypochondriacism"
        case indication = "indication"
        case jaculative = "jaculative"
        case nagana = "nagana"
        case netherlandish = "Netherlandish"
        case noctivagous = "noctivagous"
        case nonphysiological = "nonphysiological"
        case praxis = "praxis"
        case provision = "provision"
        case subterhuman = "subterhuman"
        case sunlit = "sunlit"
        case syncraniate = "syncraniate"
        case teachment = "teachment"
        case unmutinous = "unmutinous"
        case unstoppable = "unstoppable"
    }

    init(acrobates: JSONNull?, beanshooter: JSONNull?, bearhound: JSONNull?, cayuga: JSONNull?, guarneri: JSONNull?, hypochondriacism: JSONNull?, indication: JSONNull?, jaculative: JSONNull?, nagana: JSONNull?, netherlandish: JSONNull?, noctivagous: JSONNull?, nonphysiological: JSONNull?, praxis: JSONNull?, provision: JSONNull?, subterhuman: JSONNull?, sunlit: JSONNull?, syncraniate: JSONNull?, teachment: JSONNull?, unmutinous: JSONNull?, unstoppable: JSONNull?) {
        self.acrobates = acrobates
        self.beanshooter = beanshooter
        self.bearhound = bearhound
        self.cayuga = cayuga
        self.guarneri = guarneri
        self.hypochondriacism = hypochondriacism
        self.indication = indication
        self.jaculative = jaculative
        self.nagana = nagana
        self.netherlandish = netherlandish
        self.noctivagous = noctivagous
        self.nonphysiological = nonphysiological
        self.praxis = praxis
        self.provision = provision
        self.subterhuman = subterhuman
        self.sunlit = sunlit
        self.syncraniate = syncraniate
        self.teachment = teachment
        self.unmutinous = unmutinous
        self.unstoppable = unstoppable
    }
}

// MARK: OskarClass convenience initializers and mutators

extension OskarClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OskarClass.self, from: data)
        self.init(acrobates: me.acrobates, beanshooter: me.beanshooter, bearhound: me.bearhound, cayuga: me.cayuga, guarneri: me.guarneri, hypochondriacism: me.hypochondriacism, indication: me.indication, jaculative: me.jaculative, nagana: me.nagana, netherlandish: me.netherlandish, noctivagous: me.noctivagous, nonphysiological: me.nonphysiological, praxis: me.praxis, provision: me.provision, subterhuman: me.subterhuman, sunlit: me.sunlit, syncraniate: me.syncraniate, teachment: me.teachment, unmutinous: me.unmutinous, unstoppable: me.unstoppable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        acrobates: JSONNull?? = nil,
        beanshooter: JSONNull?? = nil,
        bearhound: JSONNull?? = nil,
        cayuga: JSONNull?? = nil,
        guarneri: JSONNull?? = nil,
        hypochondriacism: JSONNull?? = nil,
        indication: JSONNull?? = nil,
        jaculative: JSONNull?? = nil,
        nagana: JSONNull?? = nil,
        netherlandish: JSONNull?? = nil,
        noctivagous: JSONNull?? = nil,
        nonphysiological: JSONNull?? = nil,
        praxis: JSONNull?? = nil,
        provision: JSONNull?? = nil,
        subterhuman: JSONNull?? = nil,
        sunlit: JSONNull?? = nil,
        syncraniate: JSONNull?? = nil,
        teachment: JSONNull?? = nil,
        unmutinous: JSONNull?? = nil,
        unstoppable: JSONNull?? = nil
    ) -> OskarClass {
        return OskarClass(
            acrobates: acrobates ?? self.acrobates,
            beanshooter: beanshooter ?? self.beanshooter,
            bearhound: bearhound ?? self.bearhound,
            cayuga: cayuga ?? self.cayuga,
            guarneri: guarneri ?? self.guarneri,
            hypochondriacism: hypochondriacism ?? self.hypochondriacism,
            indication: indication ?? self.indication,
            jaculative: jaculative ?? self.jaculative,
            nagana: nagana ?? self.nagana,
            netherlandish: netherlandish ?? self.netherlandish,
            noctivagous: noctivagous ?? self.noctivagous,
            nonphysiological: nonphysiological ?? self.nonphysiological,
            praxis: praxis ?? self.praxis,
            provision: provision ?? self.provision,
            subterhuman: subterhuman ?? self.subterhuman,
            sunlit: sunlit ?? self.sunlit,
            syncraniate: syncraniate ?? self.syncraniate,
            teachment: teachment ?? self.teachment,
            unmutinous: unmutinous ?? self.unmutinous,
            unstoppable: unstoppable ?? self.unstoppable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum RebeccaElement: Codable, Sendable {
    case integer(Int)
    case rebecca(Rebecca)
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
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(RebeccaElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RebeccaElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Rhomboganoidei: Codable, Sendable {
    case integerArray([Int])
    case rebecca(Rebecca)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(Rhomboganoidei.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Rhomboganoidei"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Ruellia: Codable, Sendable {
    case bool(Bool)
    case rebecca(Rebecca)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Rebecca.self) {
            self = .rebecca(x)
            return
        }
        throw DecodingError.typeMismatch(Ruellia.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ruellia"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .rebecca(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum School: Codable, Sendable {
    case integer(Int)
    case integerMap([String: Int])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(School.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for School"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Shakespearolater: Codable, Sendable {
    case double(Double)
    case integerArray([Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Shakespearolater.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Shakespearolater"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
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

final class JSONNull: Codable, Hashable, Sendable {

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
