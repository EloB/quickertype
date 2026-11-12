// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
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
        case academe, acquirable, aerometry, alexin, alleviate, amaas, ambassage, amphithyron
        case andriana = "Andriana"
        case ankee, annihilator, annulose
        case ansarie = "Ansarie"
        case aphasia, asprawl, attractive, barksome, bedesman, belard, bocking, brawlingly, brookie, bumboatman, bystreet, calaverite, catallactic, cemental
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

enum Abranchiata: Codable {
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

enum Academe: Codable {
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

enum Acquirable: Codable {
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

enum Aerometry: Codable {
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

enum Alexin: Codable {
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

enum AlleviateElement: Codable {
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
struct AlleviateClass: Codable {
    let apriori, beggarer, brokenheartedly, debilitation: JSONNull?
    let frike, gastrolith, hulsean, orthocentric: JSONNull?
    let petaly, probudgeting, reacquire, scow: JSONNull?
    let shutoff, subcontiguous, suffumigate, transformable: JSONNull?
    let uncoroneted, unparking, unvarnishedness, wherewithal: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apriori, beggarer, brokenheartedly, debilitation, frike, gastrolith
        case hulsean = "Hulsean"
        case orthocentric, petaly, probudgeting, reacquire, scow, shutoff, subcontiguous, suffumigate, transformable, uncoroneted, unparking, unvarnishedness, wherewithal
    }
}

// MARK: AlleviateClass convenience initializers and mutators

extension AlleviateClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AlleviateClass.self, from: data)
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

enum Amaa: Codable {
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
struct Rebecca: Codable {
    let catharticalness: Double
    let chirotherium: Int
    let disdiapason: String
    let homocerc: Bool
    let nonbookish: JSONNull?

    enum CodingKeys: String, CodingKey {
        case catharticalness
        case chirotherium = "Chirotherium"
        case disdiapason, homocerc, nonbookish
    }
}

// MARK: Rebecca convenience initializers and mutators

extension Rebecca {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rebecca.self, from: data)
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

enum Ambassage: Codable {
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
struct Amphithyron: Codable {
    let akroasis, antiphonical, basebred: Int?
    let catharticalness: Double?
    let chirotherium, conductometric: Int?
    let disdiapason: String?
    let ensilation, eyebolt, fistulated, heteropod: Int?
    let homocerc: Bool?
    let juniperus, labyrinthically, martyrization, mispolicy: Int?
    let multipara, nazirite: Int?
    let nonbookish: JSONNull?
    let possessorial, shamed, shelfworn, stagnum: Int?
    let those, undecimal: Int?

    enum CodingKeys: String, CodingKey {
        case akroasis, antiphonical, basebred, catharticalness
        case chirotherium = "Chirotherium"
        case conductometric, disdiapason, ensilation, eyebolt, fistulated, heteropod, homocerc
        case juniperus = "Juniperus"
        case labyrinthically, martyrization, mispolicy, multipara
        case nazirite = "Nazirite"
        case nonbookish, possessorial, shamed, shelfworn, stagnum
        case those = "Those"
        case undecimal
    }
}

// MARK: Amphithyron convenience initializers and mutators

extension Amphithyron {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Amphithyron.self, from: data)
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

enum AnkeeElement: Codable {
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
struct AnkeeClass: Codable {
    let anomoean, barleyhood, befriender, brutishness: JSONNull?
    let cephalalgy, cirurgian, conventionally, jackshay: JSONNull?
    let milammeter, naja, ombrological, phonasthenia: JSONNull?
    let retrievableness, snakily, swot, tartlet: JSONNull?
    let thiofuran, tracheophone, tuglike, unscratchingly: JSONNull?

    enum CodingKeys: String, CodingKey {
        case anomoean = "Anomoean"
        case barleyhood, befriender, brutishness, cephalalgy, cirurgian, conventionally, jackshay, milammeter
        case naja = "Naja"
        case ombrological, phonasthenia, retrievableness, snakily, swot, tartlet, thiofuran, tracheophone, tuglike, unscratchingly
    }
}

// MARK: AnkeeClass convenience initializers and mutators

extension AnkeeClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AnkeeClass.self, from: data)
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

enum AnsarieElement: Codable {
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
struct AnsarieClass: Codable {
    let accension, alida, asteria, beriberic: JSONNull?
    let edgebone, gastrodialysis, geographic, ictonyx: JSONNull?
    let metrocele, misgraft, monteith, notcher: JSONNull?
    let prorestriction, ramist, throatlet, unfair: JSONNull?
    let unsynonymous, water, zestfully, zincic: JSONNull?

    enum CodingKeys: String, CodingKey {
        case accension
        case alida = "Alida"
        case asteria, beriberic, edgebone, gastrodialysis, geographic
        case ictonyx = "Ictonyx"
        case metrocele, misgraft, monteith, notcher, prorestriction
        case ramist = "Ramist"
        case throatlet, unfair, unsynonymous, water, zestfully, zincic
    }
}

// MARK: AnsarieClass convenience initializers and mutators

extension AnsarieClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AnsarieClass.self, from: data)
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

enum Aphasia: Codable {
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

enum Asprawl: Codable {
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

enum Bedesman: Codable {
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

enum Belard: Codable {
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

enum Bocking: Codable {
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

enum Brawlingly: Codable {
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

enum Brookie: Codable {
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

enum Bumboatman: Codable {
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

enum Calaverite: Codable {
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

enum Catallactic: Codable {
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

enum Cemental: Codable {
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

enum ChytridiaceaeElement: Codable {
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
struct ChytridiaceaeClass: Codable {
    let batidaceae, brechites, codespairer, emery: JSONNull?
    let enervative, excriminate, goshenite, grime: JSONNull?
    let gritten, hectorly, intermediation, meeterly: JSONNull?
    let narraganset, onymatic, paddlecock, thana: JSONNull?
    let thornily, uckia, unmettle, vorticellid: JSONNull?

    enum CodingKeys: String, CodingKey {
        case batidaceae = "Batidaceae"
        case brechites = "Brechites"
        case codespairer
        case emery = "Emery"
        case enervative, excriminate, goshenite, grime, gritten, hectorly, intermediation, meeterly
        case narraganset = "Narraganset"
        case onymatic, paddlecock, thana, thornily, uckia, unmettle, vorticellid
    }
}

// MARK: ChytridiaceaeClass convenience initializers and mutators

extension ChytridiaceaeClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChytridiaceaeClass.self, from: data)
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

enum DiscordiaElement: Codable {
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
struct DiscordiaClass: Codable {
    let altaic, amoristic, blennophthalmia: Int?
    let catharticalness: Double?
    let chirotherium, disciplinability: Int?
    let disdiapason: String?
    let goofer: Int?
    let homocerc: Bool?
    let laryngograph, leucitis, lymphocyst, microcosmology: Int?
    let nauseation: Int?
    let nonbookish: JSONNull?
    let patarin, preliberal, prettifier, rangework: Int?
    let redient, subfusiform, suicidical, swow: Int?
    let wastrel, wingle: Int?

    enum CodingKeys: String, CodingKey {
        case altaic = "Altaic"
        case amoristic, blennophthalmia, catharticalness
        case chirotherium = "Chirotherium"
        case disciplinability, disdiapason, goofer, homocerc, laryngograph, leucitis, lymphocyst, microcosmology, nauseation, nonbookish
        case patarin = "Patarin"
        case preliberal, prettifier, rangework, redient, subfusiform, suicidical, swow, wastrel, wingle
    }
}

// MARK: DiscordiaClass convenience initializers and mutators

extension DiscordiaClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DiscordiaClass.self, from: data)
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

enum Endomyce: Codable {
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

enum Epinephelidae: Codable {
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

enum Eupatorium: Codable {
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

enum GryphosaurusElement: Codable {
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
struct GryphosaurusClass: Codable {
    let amissibility, burushaski, citronin, coplaintiff: JSONNull?
    let disquisitionary, enoplan, faintness, hebetomy: JSONNull?
    let islandry, lameduck, overbattle, overinterested: JSONNull?
    let phrenologic, rainband, shiningly, stamineous: JSONNull?
    let subscapularis, tahami, undaubed, underntime: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amissibility
        case burushaski = "Burushaski"
        case citronin, coplaintiff, disquisitionary, enoplan, faintness, hebetomy, islandry, lameduck, overbattle, overinterested, phrenologic, rainband, shiningly, stamineous, subscapularis
        case tahami = "Tahami"
        case undaubed, underntime
    }
}

// MARK: GryphosaurusClass convenience initializers and mutators

extension GryphosaurusClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GryphosaurusClass.self, from: data)
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

enum Koryak: Codable {
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

enum LaviniaElement: Codable {
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
struct LaviniaClass: Codable {
    let agitable, asininity, benefiter, bronzelike: Int?
    let catharticalness: Double?
    let chirotherium, cholesteatomatous, deprivement: Int?
    let disdiapason: String?
    let flippantness, fogproof: Int?
    let homocerc: Bool?
    let merrymeeting: Int?
    let nonbookish: JSONNull?
    let overcareful, panaris, preacceptance, quinoxaline: Int?
    let sig, superconfusion, tacana, tillotter: Int?
    let tranquillize, unquestionable, uproute: Int?

    enum CodingKeys: String, CodingKey {
        case agitable, asininity, benefiter, bronzelike, catharticalness
        case chirotherium = "Chirotherium"
        case cholesteatomatous, deprivement, disdiapason, flippantness, fogproof, homocerc, merrymeeting, nonbookish, overcareful, panaris, preacceptance, quinoxaline, sig, superconfusion
        case tacana = "Tacana"
        case tillotter, tranquillize, unquestionable, uproute
    }
}

// MARK: LaviniaClass convenience initializers and mutators

extension LaviniaClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LaviniaClass.self, from: data)
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

enum OskarElement: Codable {
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
struct OskarClass: Codable {
    let acrobates, beanshooter, bearhound, cayuga: JSONNull?
    let guarneri, hypochondriacism, indication, jaculative: JSONNull?
    let nagana, netherlandish, noctivagous, nonphysiological: JSONNull?
    let praxis, provision, subterhuman, sunlit: JSONNull?
    let syncraniate, teachment, unmutinous, unstoppable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acrobates = "Acrobates"
        case beanshooter, bearhound
        case cayuga = "Cayuga"
        case guarneri, hypochondriacism, indication, jaculative, nagana
        case netherlandish = "Netherlandish"
        case noctivagous, nonphysiological, praxis, provision, subterhuman, sunlit, syncraniate, teachment, unmutinous, unstoppable
    }
}

// MARK: OskarClass convenience initializers and mutators

extension OskarClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OskarClass.self, from: data)
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

enum RebeccaElement: Codable {
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

enum Rhomboganoidei: Codable {
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

enum Ruellia: Codable {
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

enum School: Codable {
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

enum Shakespearolater: Codable {
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
