// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    var centrodesmose: String
    var cerograph: [CerographElement]
    var chemotherapeutics: [ChemotherapeuticElement]
    var cimelia: [CimeliaElement]
    var citrated: Int
    var clinodome: [Clinodome]
    var coadjust: [CoadjustElement]
    var consilience: [Consilience]
    var constructor: [Constructor]
    var continuative: [Continuative]
    var credulity: [CredulityElement]
    var creviced: [Creviced]
    var cubiculum: [[Int?]]
    var deruralize: [DeruralizeElement]
    var diaereses: [DiaereseElement]
    var dissolution: [[JSONNull?]?]
    var downstroke: [Downstroke]
    var electrotautomerism: [Double?]
    var eleutheromania: [Eleutheromania]
    var encrust: Encrust
    var entomoid: [Entomoid]
    var epipaleolithic: [Epipaleolithic]
    var expropriable: [Expropriable]
    var faggingly: [FagginglyElement]
    var fenks: [FenkElement]
    var flagmaking: [FlagmakingElement]
    var fluorometer: [Fluorometer]
    var fulsome: [Int?]
    var fuzzy: [Fuzzy]
    var gardenwards: [Gardenward]
    var generalissimo: [Generalissimo]
    var habeas: [[String: Int]?]
    var hemicrystalline: [Hemicrystalline]
    var hemocoele: [HemocoeleElement]
    var hoister: [Hoister]
    var hyperpiesis: [Hyperpiesi]
    var hyppish: [Hyppish]
    var idealizer: [Idealizer]
    var incrustator: [Incrustator]
    var intentiveness: [Intentiveness]
    var interacinar: Interacinar
    var intercorrelation: [[Int]?]
    var jacutinga: [Jacutinga]

    enum CodingKeys: String, CodingKey {
        case centrodesmose = "centrodesmose"
        case cerograph = "cerograph"
        case chemotherapeutics = "chemotherapeutics"
        case cimelia = "cimelia"
        case citrated = "citrated"
        case clinodome = "clinodome"
        case coadjust = "coadjust"
        case consilience = "consilience"
        case constructor = "constructor"
        case continuative = "continuative"
        case credulity = "credulity"
        case creviced = "creviced"
        case cubiculum = "cubiculum"
        case deruralize = "deruralize"
        case diaereses = "diaereses"
        case dissolution = "dissolution"
        case downstroke = "downstroke"
        case electrotautomerism = "electrotautomerism"
        case eleutheromania = "eleutheromania"
        case encrust = "encrust"
        case entomoid = "entomoid"
        case epipaleolithic = "epipaleolithic"
        case expropriable = "expropriable"
        case faggingly = "faggingly"
        case fenks = "fenks"
        case flagmaking = "flagmaking"
        case fluorometer = "fluorometer"
        case fulsome = "fulsome"
        case fuzzy = "fuzzy"
        case gardenwards = "gardenwards"
        case generalissimo = "generalissimo"
        case habeas = "habeas"
        case hemicrystalline = "hemicrystalline"
        case hemocoele = "hemocoele"
        case hoister = "hoister"
        case hyperpiesis = "hyperpiesis"
        case hyppish = "hyppish"
        case idealizer = "idealizer"
        case incrustator = "incrustator"
        case intentiveness = "intentiveness"
        case interacinar = "interacinar"
        case intercorrelation = "intercorrelation"
        case jacutinga = "jacutinga"
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
        centrodesmose: String? = nil,
        cerograph: [CerographElement]? = nil,
        chemotherapeutics: [ChemotherapeuticElement]? = nil,
        cimelia: [CimeliaElement]? = nil,
        citrated: Int? = nil,
        clinodome: [Clinodome]? = nil,
        coadjust: [CoadjustElement]? = nil,
        consilience: [Consilience]? = nil,
        constructor: [Constructor]? = nil,
        continuative: [Continuative]? = nil,
        credulity: [CredulityElement]? = nil,
        creviced: [Creviced]? = nil,
        cubiculum: [[Int?]]? = nil,
        deruralize: [DeruralizeElement]? = nil,
        diaereses: [DiaereseElement]? = nil,
        dissolution: [[JSONNull?]?]? = nil,
        downstroke: [Downstroke]? = nil,
        electrotautomerism: [Double?]? = nil,
        eleutheromania: [Eleutheromania]? = nil,
        encrust: Encrust? = nil,
        entomoid: [Entomoid]? = nil,
        epipaleolithic: [Epipaleolithic]? = nil,
        expropriable: [Expropriable]? = nil,
        faggingly: [FagginglyElement]? = nil,
        fenks: [FenkElement]? = nil,
        flagmaking: [FlagmakingElement]? = nil,
        fluorometer: [Fluorometer]? = nil,
        fulsome: [Int?]? = nil,
        fuzzy: [Fuzzy]? = nil,
        gardenwards: [Gardenward]? = nil,
        generalissimo: [Generalissimo]? = nil,
        habeas: [[String: Int]?]? = nil,
        hemicrystalline: [Hemicrystalline]? = nil,
        hemocoele: [HemocoeleElement]? = nil,
        hoister: [Hoister]? = nil,
        hyperpiesis: [Hyperpiesi]? = nil,
        hyppish: [Hyppish]? = nil,
        idealizer: [Idealizer]? = nil,
        incrustator: [Incrustator]? = nil,
        intentiveness: [Intentiveness]? = nil,
        interacinar: Interacinar? = nil,
        intercorrelation: [[Int]?]? = nil,
        jacutinga: [Jacutinga]? = nil
    ) -> TopLevel {
        return TopLevel(
            centrodesmose: centrodesmose ?? self.centrodesmose,
            cerograph: cerograph ?? self.cerograph,
            chemotherapeutics: chemotherapeutics ?? self.chemotherapeutics,
            cimelia: cimelia ?? self.cimelia,
            citrated: citrated ?? self.citrated,
            clinodome: clinodome ?? self.clinodome,
            coadjust: coadjust ?? self.coadjust,
            consilience: consilience ?? self.consilience,
            constructor: constructor ?? self.constructor,
            continuative: continuative ?? self.continuative,
            credulity: credulity ?? self.credulity,
            creviced: creviced ?? self.creviced,
            cubiculum: cubiculum ?? self.cubiculum,
            deruralize: deruralize ?? self.deruralize,
            diaereses: diaereses ?? self.diaereses,
            dissolution: dissolution ?? self.dissolution,
            downstroke: downstroke ?? self.downstroke,
            electrotautomerism: electrotautomerism ?? self.electrotautomerism,
            eleutheromania: eleutheromania ?? self.eleutheromania,
            encrust: encrust ?? self.encrust,
            entomoid: entomoid ?? self.entomoid,
            epipaleolithic: epipaleolithic ?? self.epipaleolithic,
            expropriable: expropriable ?? self.expropriable,
            faggingly: faggingly ?? self.faggingly,
            fenks: fenks ?? self.fenks,
            flagmaking: flagmaking ?? self.flagmaking,
            fluorometer: fluorometer ?? self.fluorometer,
            fulsome: fulsome ?? self.fulsome,
            fuzzy: fuzzy ?? self.fuzzy,
            gardenwards: gardenwards ?? self.gardenwards,
            generalissimo: generalissimo ?? self.generalissimo,
            habeas: habeas ?? self.habeas,
            hemicrystalline: hemicrystalline ?? self.hemicrystalline,
            hemocoele: hemocoele ?? self.hemocoele,
            hoister: hoister ?? self.hoister,
            hyperpiesis: hyperpiesis ?? self.hyperpiesis,
            hyppish: hyppish ?? self.hyppish,
            idealizer: idealizer ?? self.idealizer,
            incrustator: incrustator ?? self.incrustator,
            intentiveness: intentiveness ?? self.intentiveness,
            interacinar: interacinar ?? self.interacinar,
            intercorrelation: intercorrelation ?? self.intercorrelation,
            jacutinga: jacutinga ?? self.jacutinga
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum CerographElement: Codable {
    case cerographClass(CerographClass)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(CerographClass.self) {
            self = .cerographClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(CerographElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CerographElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cerographClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - CerographClass
struct CerographClass: Codable {
    var apotropaion: JSONNull?
    var casuary: JSONNull?
    var creaker: JSONNull?
    var disqualification: JSONNull?
    var imperatorious: JSONNull?
    var impermeabilize: JSONNull?
    var metastoma: JSONNull?
    var noctidiurnal: JSONNull?
    var nonreserve: JSONNull?
    var ophthalmotonometry: JSONNull?
    var pailful: JSONNull?
    var pigfish: JSONNull?
    var pongee: JSONNull?
    var prosodical: JSONNull?
    var scrofuloderm: JSONNull?
    var storekeeping: JSONNull?
    var therologist: JSONNull?
    var tolowa: JSONNull?
    var tradeful: JSONNull?
    var unriveting: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apotropaion = "apotropaion"
        case casuary = "casuary"
        case creaker = "creaker"
        case disqualification = "disqualification"
        case imperatorious = "imperatorious"
        case impermeabilize = "impermeabilize"
        case metastoma = "metastoma"
        case noctidiurnal = "noctidiurnal"
        case nonreserve = "nonreserve"
        case ophthalmotonometry = "ophthalmotonometry"
        case pailful = "pailful"
        case pigfish = "pigfish"
        case pongee = "pongee"
        case prosodical = "prosodical"
        case scrofuloderm = "scrofuloderm"
        case storekeeping = "storekeeping"
        case therologist = "therologist"
        case tolowa = "Tolowa"
        case tradeful = "tradeful"
        case unriveting = "unriveting"
    }
}

// MARK: CerographClass convenience initializers and mutators

extension CerographClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CerographClass.self, from: data)
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
        apotropaion: JSONNull?? = nil,
        casuary: JSONNull?? = nil,
        creaker: JSONNull?? = nil,
        disqualification: JSONNull?? = nil,
        imperatorious: JSONNull?? = nil,
        impermeabilize: JSONNull?? = nil,
        metastoma: JSONNull?? = nil,
        noctidiurnal: JSONNull?? = nil,
        nonreserve: JSONNull?? = nil,
        ophthalmotonometry: JSONNull?? = nil,
        pailful: JSONNull?? = nil,
        pigfish: JSONNull?? = nil,
        pongee: JSONNull?? = nil,
        prosodical: JSONNull?? = nil,
        scrofuloderm: JSONNull?? = nil,
        storekeeping: JSONNull?? = nil,
        therologist: JSONNull?? = nil,
        tolowa: JSONNull?? = nil,
        tradeful: JSONNull?? = nil,
        unriveting: JSONNull?? = nil
    ) -> CerographClass {
        return CerographClass(
            apotropaion: apotropaion ?? self.apotropaion,
            casuary: casuary ?? self.casuary,
            creaker: creaker ?? self.creaker,
            disqualification: disqualification ?? self.disqualification,
            imperatorious: imperatorious ?? self.imperatorious,
            impermeabilize: impermeabilize ?? self.impermeabilize,
            metastoma: metastoma ?? self.metastoma,
            noctidiurnal: noctidiurnal ?? self.noctidiurnal,
            nonreserve: nonreserve ?? self.nonreserve,
            ophthalmotonometry: ophthalmotonometry ?? self.ophthalmotonometry,
            pailful: pailful ?? self.pailful,
            pigfish: pigfish ?? self.pigfish,
            pongee: pongee ?? self.pongee,
            prosodical: prosodical ?? self.prosodical,
            scrofuloderm: scrofuloderm ?? self.scrofuloderm,
            storekeeping: storekeeping ?? self.storekeeping,
            therologist: therologist ?? self.therologist,
            tolowa: tolowa ?? self.tolowa,
            tradeful: tradeful ?? self.tradeful,
            unriveting: unriveting ?? self.unriveting
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ChemotherapeuticElement: Codable {
    case chemotherapeuticClass(ChemotherapeuticClass)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(ChemotherapeuticClass.self) {
            self = .chemotherapeuticClass(x)
            return
        }
        throw DecodingError.typeMismatch(ChemotherapeuticElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ChemotherapeuticElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .chemotherapeuticClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ChemotherapeuticClass
struct ChemotherapeuticClass: Codable {
    var angioneurotic: JSONNull?
    var availment: JSONNull?
    var bladelet: JSONNull?
    var catharticalness: Double?
    var caulis: JSONNull?
    var chalcus: JSONNull?
    var chirotherium: Int?
    var disdiapason: String?
    var enteradenological: JSONNull?
    var homocerc: Bool?
    var imporosity: JSONNull?
    var insistently: JSONNull?
    var intraparietal: JSONNull?
    var ivied: JSONNull?
    var maureen: JSONNull?
    var nonbookish: JSONNull?
    var nostochine: JSONNull?
    var nutcracker: JSONNull?
    var ofttimes: JSONNull?
    var phenocryst: JSONNull?
    var precoincident: JSONNull?
    var ramiferous: JSONNull?
    var stagmometer: JSONNull?
    var tetherball: JSONNull?
    var unshy: JSONNull?

    enum CodingKeys: String, CodingKey {
        case angioneurotic = "angioneurotic"
        case availment = "availment"
        case bladelet = "bladelet"
        case catharticalness = "catharticalness"
        case caulis = "caulis"
        case chalcus = "chalcus"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case enteradenological = "enteradenological"
        case homocerc = "homocerc"
        case imporosity = "imporosity"
        case insistently = "insistently"
        case intraparietal = "intraparietal"
        case ivied = "ivied"
        case maureen = "Maureen"
        case nonbookish = "nonbookish"
        case nostochine = "nostochine"
        case nutcracker = "nutcracker"
        case ofttimes = "ofttimes"
        case phenocryst = "phenocryst"
        case precoincident = "precoincident"
        case ramiferous = "ramiferous"
        case stagmometer = "stagmometer"
        case tetherball = "tetherball"
        case unshy = "unshy"
    }
}

// MARK: ChemotherapeuticClass convenience initializers and mutators

extension ChemotherapeuticClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChemotherapeuticClass.self, from: data)
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
        angioneurotic: JSONNull?? = nil,
        availment: JSONNull?? = nil,
        bladelet: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        caulis: JSONNull?? = nil,
        chalcus: JSONNull?? = nil,
        chirotherium: Int?? = nil,
        disdiapason: String?? = nil,
        enteradenological: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        imporosity: JSONNull?? = nil,
        insistently: JSONNull?? = nil,
        intraparietal: JSONNull?? = nil,
        ivied: JSONNull?? = nil,
        maureen: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        nostochine: JSONNull?? = nil,
        nutcracker: JSONNull?? = nil,
        ofttimes: JSONNull?? = nil,
        phenocryst: JSONNull?? = nil,
        precoincident: JSONNull?? = nil,
        ramiferous: JSONNull?? = nil,
        stagmometer: JSONNull?? = nil,
        tetherball: JSONNull?? = nil,
        unshy: JSONNull?? = nil
    ) -> ChemotherapeuticClass {
        return ChemotherapeuticClass(
            angioneurotic: angioneurotic ?? self.angioneurotic,
            availment: availment ?? self.availment,
            bladelet: bladelet ?? self.bladelet,
            catharticalness: catharticalness ?? self.catharticalness,
            caulis: caulis ?? self.caulis,
            chalcus: chalcus ?? self.chalcus,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            enteradenological: enteradenological ?? self.enteradenological,
            homocerc: homocerc ?? self.homocerc,
            imporosity: imporosity ?? self.imporosity,
            insistently: insistently ?? self.insistently,
            intraparietal: intraparietal ?? self.intraparietal,
            ivied: ivied ?? self.ivied,
            maureen: maureen ?? self.maureen,
            nonbookish: nonbookish ?? self.nonbookish,
            nostochine: nostochine ?? self.nostochine,
            nutcracker: nutcracker ?? self.nutcracker,
            ofttimes: ofttimes ?? self.ofttimes,
            phenocryst: phenocryst ?? self.phenocryst,
            precoincident: precoincident ?? self.precoincident,
            ramiferous: ramiferous ?? self.ramiferous,
            stagmometer: stagmometer ?? self.stagmometer,
            tetherball: tetherball ?? self.tetherball,
            unshy: unshy ?? self.unshy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum CimeliaElement: Codable {
    case cimeliaClass(CimeliaClass)
    case integerArray([Int])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(CimeliaElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CimeliaElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - CimeliaClass
struct CimeliaClass: Codable {
    var catharticalness: Double
    var chirotherium: Int
    var disdiapason: String
    var homocerc: Bool
    var nonbookish: JSONNull?

    enum CodingKeys: String, CodingKey {
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case homocerc = "homocerc"
        case nonbookish = "nonbookish"
    }
}

// MARK: CimeliaClass convenience initializers and mutators

extension CimeliaClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CimeliaClass.self, from: data)
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
    ) -> CimeliaClass {
        return CimeliaClass(
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

enum Clinodome: Codable {
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
        throw DecodingError.typeMismatch(Clinodome.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Clinodome"))
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

enum CoadjustElement: Codable {
    case coadjustClass(CoadjustClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CoadjustClass.self) {
            self = .coadjustClass(x)
            return
        }
        throw DecodingError.typeMismatch(CoadjustElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CoadjustElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .coadjustClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CoadjustClass
struct CoadjustClass: Codable {
    var amidosulphonal: JSONNull?
    var benny: JSONNull?
    var catharticalness: Double?
    var chirotherium: Int?
    var disdiapason: String?
    var ensnare: JSONNull?
    var homocerc: Bool?
    var hybridizer: JSONNull?
    var leastwise: JSONNull?
    var lof: JSONNull?
    var monkhood: JSONNull?
    var netherlandish: JSONNull?
    var nonbookish: JSONNull?
    var peonism: JSONNull?
    var phonelescope: JSONNull?
    var porphyrogeniture: JSONNull?
    var preindemnify: JSONNull?
    var rosal: JSONNull?
    var scalenous: JSONNull?
    var scopine: JSONNull?
    var sedaceae: JSONNull?
    var suberinize: JSONNull?
    var symbiot: JSONNull?
    var tablefellow: JSONNull?
    var unchargeable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amidosulphonal = "amidosulphonal"
        case benny = "Benny"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case ensnare = "ensnare"
        case homocerc = "homocerc"
        case hybridizer = "hybridizer"
        case leastwise = "leastwise"
        case lof = "lof"
        case monkhood = "monkhood"
        case netherlandish = "Netherlandish"
        case nonbookish = "nonbookish"
        case peonism = "peonism"
        case phonelescope = "Phonelescope"
        case porphyrogeniture = "porphyrogeniture"
        case preindemnify = "preindemnify"
        case rosal = "rosal"
        case scalenous = "scalenous"
        case scopine = "scopine"
        case sedaceae = "Sedaceae"
        case suberinize = "suberinize"
        case symbiot = "symbiot"
        case tablefellow = "tablefellow"
        case unchargeable = "unchargeable"
    }
}

// MARK: CoadjustClass convenience initializers and mutators

extension CoadjustClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoadjustClass.self, from: data)
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
        amidosulphonal: JSONNull?? = nil,
        benny: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        disdiapason: String?? = nil,
        ensnare: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        hybridizer: JSONNull?? = nil,
        leastwise: JSONNull?? = nil,
        lof: JSONNull?? = nil,
        monkhood: JSONNull?? = nil,
        netherlandish: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        peonism: JSONNull?? = nil,
        phonelescope: JSONNull?? = nil,
        porphyrogeniture: JSONNull?? = nil,
        preindemnify: JSONNull?? = nil,
        rosal: JSONNull?? = nil,
        scalenous: JSONNull?? = nil,
        scopine: JSONNull?? = nil,
        sedaceae: JSONNull?? = nil,
        suberinize: JSONNull?? = nil,
        symbiot: JSONNull?? = nil,
        tablefellow: JSONNull?? = nil,
        unchargeable: JSONNull?? = nil
    ) -> CoadjustClass {
        return CoadjustClass(
            amidosulphonal: amidosulphonal ?? self.amidosulphonal,
            benny: benny ?? self.benny,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            ensnare: ensnare ?? self.ensnare,
            homocerc: homocerc ?? self.homocerc,
            hybridizer: hybridizer ?? self.hybridizer,
            leastwise: leastwise ?? self.leastwise,
            lof: lof ?? self.lof,
            monkhood: monkhood ?? self.monkhood,
            netherlandish: netherlandish ?? self.netherlandish,
            nonbookish: nonbookish ?? self.nonbookish,
            peonism: peonism ?? self.peonism,
            phonelescope: phonelescope ?? self.phonelescope,
            porphyrogeniture: porphyrogeniture ?? self.porphyrogeniture,
            preindemnify: preindemnify ?? self.preindemnify,
            rosal: rosal ?? self.rosal,
            scalenous: scalenous ?? self.scalenous,
            scopine: scopine ?? self.scopine,
            sedaceae: sedaceae ?? self.sedaceae,
            suberinize: suberinize ?? self.suberinize,
            symbiot: symbiot ?? self.symbiot,
            tablefellow: tablefellow ?? self.tablefellow,
            unchargeable: unchargeable ?? self.unchargeable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Consilience: Codable {
    case double(Double)
    case integerMap([String: Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Consilience.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Consilience"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Constructor: Codable {
    case bool(Bool)
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        throw DecodingError.typeMismatch(Constructor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Constructor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

enum Continuative: Codable {
    case integerMap([String: Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Continuative.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Continuative"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum CredulityElement: Codable {
    case credulityClass(CredulityClass)
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
        if let x = try? container.decode(CredulityClass.self) {
            self = .credulityClass(x)
            return
        }
        throw DecodingError.typeMismatch(CredulityElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CredulityElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .credulityClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CredulityClass
struct CredulityClass: Codable {
    var ammonolytic: JSONNull?
    var bushmaster: JSONNull?
    var considering: JSONNull?
    var consuetudinary: JSONNull?
    var embarras: JSONNull?
    var fineness: JSONNull?
    var flaithship: JSONNull?
    var flavia: JSONNull?
    var gruffly: JSONNull?
    var hedychium: JSONNull?
    var leadwort: JSONNull?
    var overseriously: JSONNull?
    var parabola: JSONNull?
    var pectinatodenticulate: JSONNull?
    var popean: JSONNull?
    var pornocrat: JSONNull?
    var quadrisect: JSONNull?
    var seriality: JSONNull?
    var vamphorn: JSONNull?
    var wharp: JSONNull?

    enum CodingKeys: String, CodingKey {
        case ammonolytic = "ammonolytic"
        case bushmaster = "bushmaster"
        case considering = "considering"
        case consuetudinary = "consuetudinary"
        case embarras = "embarras"
        case fineness = "fineness"
        case flaithship = "flaithship"
        case flavia = "Flavia"
        case gruffly = "gruffly"
        case hedychium = "Hedychium"
        case leadwort = "leadwort"
        case overseriously = "overseriously"
        case parabola = "parabola"
        case pectinatodenticulate = "pectinatodenticulate"
        case popean = "Popean"
        case pornocrat = "pornocrat"
        case quadrisect = "quadrisect"
        case seriality = "seriality"
        case vamphorn = "vamphorn"
        case wharp = "wharp"
    }
}

// MARK: CredulityClass convenience initializers and mutators

extension CredulityClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CredulityClass.self, from: data)
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
        ammonolytic: JSONNull?? = nil,
        bushmaster: JSONNull?? = nil,
        considering: JSONNull?? = nil,
        consuetudinary: JSONNull?? = nil,
        embarras: JSONNull?? = nil,
        fineness: JSONNull?? = nil,
        flaithship: JSONNull?? = nil,
        flavia: JSONNull?? = nil,
        gruffly: JSONNull?? = nil,
        hedychium: JSONNull?? = nil,
        leadwort: JSONNull?? = nil,
        overseriously: JSONNull?? = nil,
        parabola: JSONNull?? = nil,
        pectinatodenticulate: JSONNull?? = nil,
        popean: JSONNull?? = nil,
        pornocrat: JSONNull?? = nil,
        quadrisect: JSONNull?? = nil,
        seriality: JSONNull?? = nil,
        vamphorn: JSONNull?? = nil,
        wharp: JSONNull?? = nil
    ) -> CredulityClass {
        return CredulityClass(
            ammonolytic: ammonolytic ?? self.ammonolytic,
            bushmaster: bushmaster ?? self.bushmaster,
            considering: considering ?? self.considering,
            consuetudinary: consuetudinary ?? self.consuetudinary,
            embarras: embarras ?? self.embarras,
            fineness: fineness ?? self.fineness,
            flaithship: flaithship ?? self.flaithship,
            flavia: flavia ?? self.flavia,
            gruffly: gruffly ?? self.gruffly,
            hedychium: hedychium ?? self.hedychium,
            leadwort: leadwort ?? self.leadwort,
            overseriously: overseriously ?? self.overseriously,
            parabola: parabola ?? self.parabola,
            pectinatodenticulate: pectinatodenticulate ?? self.pectinatodenticulate,
            popean: popean ?? self.popean,
            pornocrat: pornocrat ?? self.pornocrat,
            quadrisect: quadrisect ?? self.quadrisect,
            seriality: seriality ?? self.seriality,
            vamphorn: vamphorn ?? self.vamphorn,
            wharp: wharp ?? self.wharp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Creviced: Codable {
    case bool(Bool)
    case integerMap([String: Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Creviced.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Creviced"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum DeruralizeElement: Codable {
    case bool(Bool)
    case deruralizeClass(DeruralizeClass)
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
        if let x = try? container.decode(DeruralizeClass.self) {
            self = .deruralizeClass(x)
            return
        }
        throw DecodingError.typeMismatch(DeruralizeElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DeruralizeElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .deruralizeClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DeruralizeClass
struct DeruralizeClass: Codable {
    var bockerel: JSONNull?
    var boulder: JSONNull?
    var churrus: JSONNull?
    var counterdigged: JSONNull?
    var dialogite: JSONNull?
    var digenic: JSONNull?
    var dunbird: JSONNull?
    var ergatogyne: JSONNull?
    var fiendful: JSONNull?
    var jackrod: JSONNull?
    var jehovistic: JSONNull?
    var paninean: JSONNull?
    var panther: JSONNull?
    var placentigerous: JSONNull?
    var romney: JSONNull?
    var sparm: JSONNull?
    var tocsin: JSONNull?
    var unnicked: JSONNull?
    var unstavable: JSONNull?
    var windfirm: JSONNull?

    enum CodingKeys: String, CodingKey {
        case bockerel = "bockerel"
        case boulder = "boulder"
        case churrus = "churrus"
        case counterdigged = "counterdigged"
        case dialogite = "dialogite"
        case digenic = "digenic"
        case dunbird = "dunbird"
        case ergatogyne = "ergatogyne"
        case fiendful = "fiendful"
        case jackrod = "jackrod"
        case jehovistic = "Jehovistic"
        case paninean = "Paninean"
        case panther = "panther"
        case placentigerous = "placentigerous"
        case romney = "Romney"
        case sparm = "sparm"
        case tocsin = "tocsin"
        case unnicked = "unnicked"
        case unstavable = "unstavable"
        case windfirm = "windfirm"
    }
}

// MARK: DeruralizeClass convenience initializers and mutators

extension DeruralizeClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeruralizeClass.self, from: data)
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
        bockerel: JSONNull?? = nil,
        boulder: JSONNull?? = nil,
        churrus: JSONNull?? = nil,
        counterdigged: JSONNull?? = nil,
        dialogite: JSONNull?? = nil,
        digenic: JSONNull?? = nil,
        dunbird: JSONNull?? = nil,
        ergatogyne: JSONNull?? = nil,
        fiendful: JSONNull?? = nil,
        jackrod: JSONNull?? = nil,
        jehovistic: JSONNull?? = nil,
        paninean: JSONNull?? = nil,
        panther: JSONNull?? = nil,
        placentigerous: JSONNull?? = nil,
        romney: JSONNull?? = nil,
        sparm: JSONNull?? = nil,
        tocsin: JSONNull?? = nil,
        unnicked: JSONNull?? = nil,
        unstavable: JSONNull?? = nil,
        windfirm: JSONNull?? = nil
    ) -> DeruralizeClass {
        return DeruralizeClass(
            bockerel: bockerel ?? self.bockerel,
            boulder: boulder ?? self.boulder,
            churrus: churrus ?? self.churrus,
            counterdigged: counterdigged ?? self.counterdigged,
            dialogite: dialogite ?? self.dialogite,
            digenic: digenic ?? self.digenic,
            dunbird: dunbird ?? self.dunbird,
            ergatogyne: ergatogyne ?? self.ergatogyne,
            fiendful: fiendful ?? self.fiendful,
            jackrod: jackrod ?? self.jackrod,
            jehovistic: jehovistic ?? self.jehovistic,
            paninean: paninean ?? self.paninean,
            panther: panther ?? self.panther,
            placentigerous: placentigerous ?? self.placentigerous,
            romney: romney ?? self.romney,
            sparm: sparm ?? self.sparm,
            tocsin: tocsin ?? self.tocsin,
            unnicked: unnicked ?? self.unnicked,
            unstavable: unstavable ?? self.unstavable,
            windfirm: windfirm ?? self.windfirm
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum DiaereseElement: Codable {
    case bool(Bool)
    case diaereseClass(DiaereseClass)
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
        if let x = try? container.decode(DiaereseClass.self) {
            self = .diaereseClass(x)
            return
        }
        throw DecodingError.typeMismatch(DiaereseElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DiaereseElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .diaereseClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DiaereseClass
struct DiaereseClass: Codable {
    var amoreuxia: JSONNull?
    var ani: JSONNull?
    var bernicle: JSONNull?
    var blackwasher: JSONNull?
    var blowhard: JSONNull?
    var broma: JSONNull?
    var closecross: JSONNull?
    var congregationalism: JSONNull?
    var grayly: JSONNull?
    var historically: JSONNull?
    var hoast: JSONNull?
    var irretentive: JSONNull?
    var parcener: JSONNull?
    var pedder: JSONNull?
    var pseudoanatomic: JSONNull?
    var rhizocarpian: JSONNull?
    var samel: JSONNull?
    var silker: JSONNull?
    var subdentated: JSONNull?
    var subobscure: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amoreuxia = "Amoreuxia"
        case ani = "ani"
        case bernicle = "bernicle"
        case blackwasher = "blackwasher"
        case blowhard = "blowhard"
        case broma = "broma"
        case closecross = "closecross"
        case congregationalism = "congregationalism"
        case grayly = "grayly"
        case historically = "historically"
        case hoast = "hoast"
        case irretentive = "irretentive"
        case parcener = "parcener"
        case pedder = "pedder"
        case pseudoanatomic = "pseudoanatomic"
        case rhizocarpian = "rhizocarpian"
        case samel = "samel"
        case silker = "silker"
        case subdentated = "subdentated"
        case subobscure = "subobscure"
    }
}

// MARK: DiaereseClass convenience initializers and mutators

extension DiaereseClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DiaereseClass.self, from: data)
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
        amoreuxia: JSONNull?? = nil,
        ani: JSONNull?? = nil,
        bernicle: JSONNull?? = nil,
        blackwasher: JSONNull?? = nil,
        blowhard: JSONNull?? = nil,
        broma: JSONNull?? = nil,
        closecross: JSONNull?? = nil,
        congregationalism: JSONNull?? = nil,
        grayly: JSONNull?? = nil,
        historically: JSONNull?? = nil,
        hoast: JSONNull?? = nil,
        irretentive: JSONNull?? = nil,
        parcener: JSONNull?? = nil,
        pedder: JSONNull?? = nil,
        pseudoanatomic: JSONNull?? = nil,
        rhizocarpian: JSONNull?? = nil,
        samel: JSONNull?? = nil,
        silker: JSONNull?? = nil,
        subdentated: JSONNull?? = nil,
        subobscure: JSONNull?? = nil
    ) -> DiaereseClass {
        return DiaereseClass(
            amoreuxia: amoreuxia ?? self.amoreuxia,
            ani: ani ?? self.ani,
            bernicle: bernicle ?? self.bernicle,
            blackwasher: blackwasher ?? self.blackwasher,
            blowhard: blowhard ?? self.blowhard,
            broma: broma ?? self.broma,
            closecross: closecross ?? self.closecross,
            congregationalism: congregationalism ?? self.congregationalism,
            grayly: grayly ?? self.grayly,
            historically: historically ?? self.historically,
            hoast: hoast ?? self.hoast,
            irretentive: irretentive ?? self.irretentive,
            parcener: parcener ?? self.parcener,
            pedder: pedder ?? self.pedder,
            pseudoanatomic: pseudoanatomic ?? self.pseudoanatomic,
            rhizocarpian: rhizocarpian ?? self.rhizocarpian,
            samel: samel ?? self.samel,
            silker: silker ?? self.silker,
            subdentated: subdentated ?? self.subdentated,
            subobscure: subobscure ?? self.subobscure
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Downstroke: Codable {
    case bool(Bool)
    case nullArray([JSONNull?])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Downstroke.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Downstroke"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Eleutheromania: Codable {
    case double(Double)
    case integerMap([String: Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Eleutheromania.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Eleutheromania"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Encrust
struct Encrust: Codable {
    var comradely: JSONNull?
    var diacanthous: JSONNull?
    var feminineness: JSONNull?
    var gossamered: JSONNull?
    var hibernia: JSONNull?
    var hibiscus: JSONNull?
    var lepidosauria: JSONNull?
    var lollingly: JSONNull?
    var manager: JSONNull?
    var mechanic: JSONNull?
    var overminuteness: JSONNull?
    var papelonne: JSONNull?
    var plebification: JSONNull?
    var pugmiller: JSONNull?
    var recoveror: JSONNull?
    var spermatoblastic: JSONNull?
    var syllidae: JSONNull?
    var ungyved: JSONNull?
    var whirlabout: JSONNull?
    var woodenware: JSONNull?

    enum CodingKeys: String, CodingKey {
        case comradely = "comradely"
        case diacanthous = "diacanthous"
        case feminineness = "feminineness"
        case gossamered = "gossamered"
        case hibernia = "Hibernia"
        case hibiscus = "Hibiscus"
        case lepidosauria = "Lepidosauria"
        case lollingly = "lollingly"
        case manager = "manager"
        case mechanic = "mechanic"
        case overminuteness = "overminuteness"
        case papelonne = "papelonne"
        case plebification = "plebification"
        case pugmiller = "pugmiller"
        case recoveror = "recoveror"
        case spermatoblastic = "spermatoblastic"
        case syllidae = "Syllidae"
        case ungyved = "ungyved"
        case whirlabout = "whirlabout"
        case woodenware = "woodenware"
    }
}

// MARK: Encrust convenience initializers and mutators

extension Encrust {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Encrust.self, from: data)
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
        comradely: JSONNull?? = nil,
        diacanthous: JSONNull?? = nil,
        feminineness: JSONNull?? = nil,
        gossamered: JSONNull?? = nil,
        hibernia: JSONNull?? = nil,
        hibiscus: JSONNull?? = nil,
        lepidosauria: JSONNull?? = nil,
        lollingly: JSONNull?? = nil,
        manager: JSONNull?? = nil,
        mechanic: JSONNull?? = nil,
        overminuteness: JSONNull?? = nil,
        papelonne: JSONNull?? = nil,
        plebification: JSONNull?? = nil,
        pugmiller: JSONNull?? = nil,
        recoveror: JSONNull?? = nil,
        spermatoblastic: JSONNull?? = nil,
        syllidae: JSONNull?? = nil,
        ungyved: JSONNull?? = nil,
        whirlabout: JSONNull?? = nil,
        woodenware: JSONNull?? = nil
    ) -> Encrust {
        return Encrust(
            comradely: comradely ?? self.comradely,
            diacanthous: diacanthous ?? self.diacanthous,
            feminineness: feminineness ?? self.feminineness,
            gossamered: gossamered ?? self.gossamered,
            hibernia: hibernia ?? self.hibernia,
            hibiscus: hibiscus ?? self.hibiscus,
            lepidosauria: lepidosauria ?? self.lepidosauria,
            lollingly: lollingly ?? self.lollingly,
            manager: manager ?? self.manager,
            mechanic: mechanic ?? self.mechanic,
            overminuteness: overminuteness ?? self.overminuteness,
            papelonne: papelonne ?? self.papelonne,
            plebification: plebification ?? self.plebification,
            pugmiller: pugmiller ?? self.pugmiller,
            recoveror: recoveror ?? self.recoveror,
            spermatoblastic: spermatoblastic ?? self.spermatoblastic,
            syllidae: syllidae ?? self.syllidae,
            ungyved: ungyved ?? self.ungyved,
            whirlabout: whirlabout ?? self.whirlabout,
            woodenware: woodenware ?? self.woodenware
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Entomoid: Codable {
    case cimeliaClass(CimeliaClass)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        throw DecodingError.typeMismatch(Entomoid.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Entomoid"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum Epipaleolithic: Codable {
    case double(Double)
    case integerArray([Int])

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
        throw DecodingError.typeMismatch(Epipaleolithic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Epipaleolithic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

enum Expropriable: Codable {
    case cimeliaClass(CimeliaClass)
    case double(Double)
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        throw DecodingError.typeMismatch(Expropriable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Expropriable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum FagginglyElement: Codable {
    case double(Double)
    case fagginglyClass(FagginglyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FagginglyClass.self) {
            self = .fagginglyClass(x)
            return
        }
        throw DecodingError.typeMismatch(FagginglyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FagginglyElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .fagginglyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FagginglyClass
struct FagginglyClass: Codable {
    var abranchian: JSONNull?
    var aculeiform: JSONNull?
    var adiaphoristic: JSONNull?
    var adoptionism: JSONNull?
    var anglic: JSONNull?
    var antrotomy: JSONNull?
    var coerciveness: JSONNull?
    var decorist: JSONNull?
    var duckhood: JSONNull?
    var heteromeri: JSONNull?
    var hypochnose: JSONNull?
    var lochage: JSONNull?
    var melee: JSONNull?
    var nonconformitant: JSONNull?
    var poinsettia: JSONNull?
    var putatively: JSONNull?
    var semivolatile: JSONNull?
    var soleas: JSONNull?
    var unfastenable: JSONNull?
    var unmillinered: JSONNull?

    enum CodingKeys: String, CodingKey {
        case abranchian = "abranchian"
        case aculeiform = "aculeiform"
        case adiaphoristic = "adiaphoristic"
        case adoptionism = "adoptionism"
        case anglic = "Anglic"
        case antrotomy = "antrotomy"
        case coerciveness = "coerciveness"
        case decorist = "decorist"
        case duckhood = "duckhood"
        case heteromeri = "Heteromeri"
        case hypochnose = "hypochnose"
        case lochage = "lochage"
        case melee = "melee"
        case nonconformitant = "nonconformitant"
        case poinsettia = "Poinsettia"
        case putatively = "putatively"
        case semivolatile = "semivolatile"
        case soleas = "soleas"
        case unfastenable = "unfastenable"
        case unmillinered = "unmillinered"
    }
}

// MARK: FagginglyClass convenience initializers and mutators

extension FagginglyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FagginglyClass.self, from: data)
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
        abranchian: JSONNull?? = nil,
        aculeiform: JSONNull?? = nil,
        adiaphoristic: JSONNull?? = nil,
        adoptionism: JSONNull?? = nil,
        anglic: JSONNull?? = nil,
        antrotomy: JSONNull?? = nil,
        coerciveness: JSONNull?? = nil,
        decorist: JSONNull?? = nil,
        duckhood: JSONNull?? = nil,
        heteromeri: JSONNull?? = nil,
        hypochnose: JSONNull?? = nil,
        lochage: JSONNull?? = nil,
        melee: JSONNull?? = nil,
        nonconformitant: JSONNull?? = nil,
        poinsettia: JSONNull?? = nil,
        putatively: JSONNull?? = nil,
        semivolatile: JSONNull?? = nil,
        soleas: JSONNull?? = nil,
        unfastenable: JSONNull?? = nil,
        unmillinered: JSONNull?? = nil
    ) -> FagginglyClass {
        return FagginglyClass(
            abranchian: abranchian ?? self.abranchian,
            aculeiform: aculeiform ?? self.aculeiform,
            adiaphoristic: adiaphoristic ?? self.adiaphoristic,
            adoptionism: adoptionism ?? self.adoptionism,
            anglic: anglic ?? self.anglic,
            antrotomy: antrotomy ?? self.antrotomy,
            coerciveness: coerciveness ?? self.coerciveness,
            decorist: decorist ?? self.decorist,
            duckhood: duckhood ?? self.duckhood,
            heteromeri: heteromeri ?? self.heteromeri,
            hypochnose: hypochnose ?? self.hypochnose,
            lochage: lochage ?? self.lochage,
            melee: melee ?? self.melee,
            nonconformitant: nonconformitant ?? self.nonconformitant,
            poinsettia: poinsettia ?? self.poinsettia,
            putatively: putatively ?? self.putatively,
            semivolatile: semivolatile ?? self.semivolatile,
            soleas: soleas ?? self.soleas,
            unfastenable: unfastenable ?? self.unfastenable,
            unmillinered: unmillinered ?? self.unmillinered
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FenkElement: Codable {
    case fenkClass(FenkClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(FenkClass.self) {
            self = .fenkClass(x)
            return
        }
        throw DecodingError.typeMismatch(FenkElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FenkElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fenkClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FenkClass
struct FenkClass: Codable {
    var apoise: JSONNull?
    var astronomize: JSONNull?
    var cockhorse: JSONNull?
    var copular: JSONNull?
    var dagomba: JSONNull?
    var draffy: JSONNull?
    var foreigner: JSONNull?
    var guyandot: JSONNull?
    var neurogliosis: JSONNull?
    var osmious: JSONNull?
    var palpitate: JSONNull?
    var rebukeable: JSONNull?
    var reinwardtia: JSONNull?
    var reservatory: JSONNull?
    var scalt: JSONNull?
    var scripturalize: JSONNull?
    var tintometer: JSONNull?
    var tritoness: JSONNull?
    var undergrade: JSONNull?
    var undermountain: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apoise = "apoise"
        case astronomize = "astronomize"
        case cockhorse = "cockhorse"
        case copular = "copular"
        case dagomba = "Dagomba"
        case draffy = "draffy"
        case foreigner = "foreigner"
        case guyandot = "Guyandot"
        case neurogliosis = "neurogliosis"
        case osmious = "osmious"
        case palpitate = "palpitate"
        case rebukeable = "rebukeable"
        case reinwardtia = "Reinwardtia"
        case reservatory = "reservatory"
        case scalt = "scalt"
        case scripturalize = "scripturalize"
        case tintometer = "tintometer"
        case tritoness = "Tritoness"
        case undergrade = "undergrade"
        case undermountain = "undermountain"
    }
}

// MARK: FenkClass convenience initializers and mutators

extension FenkClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FenkClass.self, from: data)
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
        apoise: JSONNull?? = nil,
        astronomize: JSONNull?? = nil,
        cockhorse: JSONNull?? = nil,
        copular: JSONNull?? = nil,
        dagomba: JSONNull?? = nil,
        draffy: JSONNull?? = nil,
        foreigner: JSONNull?? = nil,
        guyandot: JSONNull?? = nil,
        neurogliosis: JSONNull?? = nil,
        osmious: JSONNull?? = nil,
        palpitate: JSONNull?? = nil,
        rebukeable: JSONNull?? = nil,
        reinwardtia: JSONNull?? = nil,
        reservatory: JSONNull?? = nil,
        scalt: JSONNull?? = nil,
        scripturalize: JSONNull?? = nil,
        tintometer: JSONNull?? = nil,
        tritoness: JSONNull?? = nil,
        undergrade: JSONNull?? = nil,
        undermountain: JSONNull?? = nil
    ) -> FenkClass {
        return FenkClass(
            apoise: apoise ?? self.apoise,
            astronomize: astronomize ?? self.astronomize,
            cockhorse: cockhorse ?? self.cockhorse,
            copular: copular ?? self.copular,
            dagomba: dagomba ?? self.dagomba,
            draffy: draffy ?? self.draffy,
            foreigner: foreigner ?? self.foreigner,
            guyandot: guyandot ?? self.guyandot,
            neurogliosis: neurogliosis ?? self.neurogliosis,
            osmious: osmious ?? self.osmious,
            palpitate: palpitate ?? self.palpitate,
            rebukeable: rebukeable ?? self.rebukeable,
            reinwardtia: reinwardtia ?? self.reinwardtia,
            reservatory: reservatory ?? self.reservatory,
            scalt: scalt ?? self.scalt,
            scripturalize: scripturalize ?? self.scripturalize,
            tintometer: tintometer ?? self.tintometer,
            tritoness: tritoness ?? self.tritoness,
            undergrade: undergrade ?? self.undergrade,
            undermountain: undermountain ?? self.undermountain
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FlagmakingElement: Codable {
    case bool(Bool)
    case double(Double)
    case flagmakingClass(FlagmakingClass)

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
        if let x = try? container.decode(FlagmakingClass.self) {
            self = .flagmakingClass(x)
            return
        }
        throw DecodingError.typeMismatch(FlagmakingElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FlagmakingElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .flagmakingClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FlagmakingClass
struct FlagmakingClass: Codable {
    var albarco: JSONNull?
    var bunodonta: JSONNull?
    var hornify: JSONNull?
    var hydrocorisae: JSONNull?
    var hypoglossus: JSONNull?
    var inexpiably: JSONNull?
    var ingratitude: JSONNull?
    var ladyfly: JSONNull?
    var medicament: JSONNull?
    var monogrammatic: JSONNull?
    var nobbut: JSONNull?
    var notacanthidae: JSONNull?
    var polyplacophore: JSONNull?
    var proexercise: JSONNull?
    var protoplast: JSONNull?
    var puzzling: JSONNull?
    var splanchnoskeleton: JSONNull?
    var unloveliness: JSONNull?
    var unquarantined: JSONNull?
    var unrenounceable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case albarco = "albarco"
        case bunodonta = "Bunodonta"
        case hornify = "hornify"
        case hydrocorisae = "Hydrocorisae"
        case hypoglossus = "hypoglossus"
        case inexpiably = "inexpiably"
        case ingratitude = "ingratitude"
        case ladyfly = "ladyfly"
        case medicament = "medicament"
        case monogrammatic = "monogrammatic"
        case nobbut = "nobbut"
        case notacanthidae = "Notacanthidae"
        case polyplacophore = "polyplacophore"
        case proexercise = "proexercise"
        case protoplast = "protoplast"
        case puzzling = "puzzling"
        case splanchnoskeleton = "splanchnoskeleton"
        case unloveliness = "unloveliness"
        case unquarantined = "unquarantined"
        case unrenounceable = "unrenounceable"
    }
}

// MARK: FlagmakingClass convenience initializers and mutators

extension FlagmakingClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FlagmakingClass.self, from: data)
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
        albarco: JSONNull?? = nil,
        bunodonta: JSONNull?? = nil,
        hornify: JSONNull?? = nil,
        hydrocorisae: JSONNull?? = nil,
        hypoglossus: JSONNull?? = nil,
        inexpiably: JSONNull?? = nil,
        ingratitude: JSONNull?? = nil,
        ladyfly: JSONNull?? = nil,
        medicament: JSONNull?? = nil,
        monogrammatic: JSONNull?? = nil,
        nobbut: JSONNull?? = nil,
        notacanthidae: JSONNull?? = nil,
        polyplacophore: JSONNull?? = nil,
        proexercise: JSONNull?? = nil,
        protoplast: JSONNull?? = nil,
        puzzling: JSONNull?? = nil,
        splanchnoskeleton: JSONNull?? = nil,
        unloveliness: JSONNull?? = nil,
        unquarantined: JSONNull?? = nil,
        unrenounceable: JSONNull?? = nil
    ) -> FlagmakingClass {
        return FlagmakingClass(
            albarco: albarco ?? self.albarco,
            bunodonta: bunodonta ?? self.bunodonta,
            hornify: hornify ?? self.hornify,
            hydrocorisae: hydrocorisae ?? self.hydrocorisae,
            hypoglossus: hypoglossus ?? self.hypoglossus,
            inexpiably: inexpiably ?? self.inexpiably,
            ingratitude: ingratitude ?? self.ingratitude,
            ladyfly: ladyfly ?? self.ladyfly,
            medicament: medicament ?? self.medicament,
            monogrammatic: monogrammatic ?? self.monogrammatic,
            nobbut: nobbut ?? self.nobbut,
            notacanthidae: notacanthidae ?? self.notacanthidae,
            polyplacophore: polyplacophore ?? self.polyplacophore,
            proexercise: proexercise ?? self.proexercise,
            protoplast: protoplast ?? self.protoplast,
            puzzling: puzzling ?? self.puzzling,
            splanchnoskeleton: splanchnoskeleton ?? self.splanchnoskeleton,
            unloveliness: unloveliness ?? self.unloveliness,
            unquarantined: unquarantined ?? self.unquarantined,
            unrenounceable: unrenounceable ?? self.unrenounceable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Fluorometer: Codable {
    case integer(Int)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Fluorometer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Fluorometer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Fuzzy: Codable {
    case integer(Int)
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        throw DecodingError.typeMismatch(Fuzzy.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Fuzzy"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

enum Gardenward: Codable {
    case bool(Bool)
    case integerArray([Int])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Gardenward.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Gardenward"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Generalissimo: Codable {
    case bool(Bool)
    case integerMap([String: Int])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
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
        throw DecodingError.typeMismatch(Generalissimo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Generalissimo"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Hemicrystalline: Codable {
    case cimeliaClass(CimeliaClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        throw DecodingError.typeMismatch(Hemicrystalline.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Hemicrystalline"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum HemocoeleElement: Codable {
    case hemocoeleClass(HemocoeleClass)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(HemocoeleClass.self) {
            self = .hemocoeleClass(x)
            return
        }
        throw DecodingError.typeMismatch(HemocoeleElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HemocoeleElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .hemocoeleClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HemocoeleClass
struct HemocoeleClass: Codable {
    var acrogamy: JSONNull?
    var amelification: JSONNull?
    var autobiographic: JSONNull?
    var berat: JSONNull?
    var catharticalness: Double?
    var chirotherium: Int?
    var disdiapason: String?
    var disproportionably: JSONNull?
    var erythrite: JSONNull?
    var graphic: JSONNull?
    var hepatological: JSONNull?
    var homocerc: Bool?
    var incommensurably: JSONNull?
    var misaffirm: JSONNull?
    var nonbookish: JSONNull?
    var pocketbook: JSONNull?
    var sclerometric: JSONNull?
    var stambouline: JSONNull?
    var stickpin: JSONNull?
    var tubulure: JSONNull?
    var undelated: JSONNull?
    var unsalt: JSONNull?
    var untutelar: JSONNull?
    var vagrant: JSONNull?
    var walt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acrogamy = "acrogamy"
        case amelification = "amelification"
        case autobiographic = "autobiographic"
        case berat = "berat"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case disproportionably = "disproportionably"
        case erythrite = "erythrite"
        case graphic = "graphic"
        case hepatological = "hepatological"
        case homocerc = "homocerc"
        case incommensurably = "incommensurably"
        case misaffirm = "misaffirm"
        case nonbookish = "nonbookish"
        case pocketbook = "pocketbook"
        case sclerometric = "sclerometric"
        case stambouline = "stambouline"
        case stickpin = "stickpin"
        case tubulure = "tubulure"
        case undelated = "undelated"
        case unsalt = "unsalt"
        case untutelar = "untutelar"
        case vagrant = "vagrant"
        case walt = "Walt"
    }
}

// MARK: HemocoeleClass convenience initializers and mutators

extension HemocoeleClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HemocoeleClass.self, from: data)
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
        acrogamy: JSONNull?? = nil,
        amelification: JSONNull?? = nil,
        autobiographic: JSONNull?? = nil,
        berat: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        disdiapason: String?? = nil,
        disproportionably: JSONNull?? = nil,
        erythrite: JSONNull?? = nil,
        graphic: JSONNull?? = nil,
        hepatological: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        incommensurably: JSONNull?? = nil,
        misaffirm: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        pocketbook: JSONNull?? = nil,
        sclerometric: JSONNull?? = nil,
        stambouline: JSONNull?? = nil,
        stickpin: JSONNull?? = nil,
        tubulure: JSONNull?? = nil,
        undelated: JSONNull?? = nil,
        unsalt: JSONNull?? = nil,
        untutelar: JSONNull?? = nil,
        vagrant: JSONNull?? = nil,
        walt: JSONNull?? = nil
    ) -> HemocoeleClass {
        return HemocoeleClass(
            acrogamy: acrogamy ?? self.acrogamy,
            amelification: amelification ?? self.amelification,
            autobiographic: autobiographic ?? self.autobiographic,
            berat: berat ?? self.berat,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            disproportionably: disproportionably ?? self.disproportionably,
            erythrite: erythrite ?? self.erythrite,
            graphic: graphic ?? self.graphic,
            hepatological: hepatological ?? self.hepatological,
            homocerc: homocerc ?? self.homocerc,
            incommensurably: incommensurably ?? self.incommensurably,
            misaffirm: misaffirm ?? self.misaffirm,
            nonbookish: nonbookish ?? self.nonbookish,
            pocketbook: pocketbook ?? self.pocketbook,
            sclerometric: sclerometric ?? self.sclerometric,
            stambouline: stambouline ?? self.stambouline,
            stickpin: stickpin ?? self.stickpin,
            tubulure: tubulure ?? self.tubulure,
            undelated: undelated ?? self.undelated,
            unsalt: unsalt ?? self.unsalt,
            untutelar: untutelar ?? self.untutelar,
            vagrant: vagrant ?? self.vagrant,
            walt: walt ?? self.walt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Hoister: Codable {
    case cimeliaClass(CimeliaClass)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Hoister.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Hoister"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Hyperpiesi: Codable {
    case cimeliaClass(CimeliaClass)
    case nullArray([JSONNull?])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Hyperpiesi.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Hyperpiesi"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Hyppish: Codable {
    case bool(Bool)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Hyppish.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Hyppish"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Idealizer: Codable {
    case cimeliaClass(CimeliaClass)
    case integer(Int)
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        throw DecodingError.typeMismatch(Idealizer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Idealizer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum Incrustator: Codable {
    case integer(Int)
    case integerArray([Int])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Incrustator.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Incrustator"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Intentiveness: Codable {
    case cimeliaClass(CimeliaClass)
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
        if let x = try? container.decode(CimeliaClass.self) {
            self = .cimeliaClass(x)
            return
        }
        throw DecodingError.typeMismatch(Intentiveness.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Intentiveness"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Interacinar
struct Interacinar: Codable {
    var assapan: Double
    var benefactorship: Bool
    var triseriatim: String
    var tubbing: Int
    var untrimmed: JSONNull?

    enum CodingKeys: String, CodingKey {
        case assapan = "assapan"
        case benefactorship = "benefactorship"
        case triseriatim = "triseriatim"
        case tubbing = "tubbing"
        case untrimmed = "untrimmed"
    }
}

// MARK: Interacinar convenience initializers and mutators

extension Interacinar {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Interacinar.self, from: data)
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
        assapan: Double? = nil,
        benefactorship: Bool? = nil,
        triseriatim: String? = nil,
        tubbing: Int? = nil,
        untrimmed: JSONNull?? = nil
    ) -> Interacinar {
        return Interacinar(
            assapan: assapan ?? self.assapan,
            benefactorship: benefactorship ?? self.benefactorship,
            triseriatim: triseriatim ?? self.triseriatim,
            tubbing: tubbing ?? self.tubbing,
            untrimmed: untrimmed ?? self.untrimmed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Jacutinga: Codable {
    case integerArray([Int])
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        throw DecodingError.typeMismatch(Jacutinga.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Jacutinga"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .unionMap(let x):
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
