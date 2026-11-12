// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let centrodesmose: String
    let cerograph: [CerographElement]
    let chemotherapeutics: [ChemotherapeuticElement]
    let cimelia: [CimeliaElement]
    let citrated: Int
    let clinodome: [Clinodome]
    let coadjust: [CoadjustElement]
    let consilience: [Consilience]
    let constructor: [Constructor]
    let continuative: [Continuative]
    let credulity: [CredulityElement]
    let creviced: [Creviced]
    let cubiculum: [[Int?]]
    let deruralize: [DeruralizeElement]
    let diaereses: [DiaereseElement]
    let dissolution: [[JSONNull?]?]
    let downstroke: [Downstroke]
    let electrotautomerism: [Double?]
    let eleutheromania: [Eleutheromania]
    let encrust: Encrust
    let entomoid: [Entomoid]
    let epipaleolithic: [Epipaleolithic]
    let expropriable: [Expropriable]
    let faggingly: [FagginglyElement]
    let fenks: [FenkElement]
    let flagmaking: [FlagmakingElement]
    let fluorometer: [Fluorometer]
    let fulsome: [Int?]
    let fuzzy: [Fuzzy]
    let gardenwards: [Gardenward]
    let generalissimo: [Generalissimo]
    let habeas: [[String: Int]?]
    let hemicrystalline: [Hemicrystalline]
    let hemocoele: [HemocoeleElement]
    let hoister: [Hoister]
    let hyperpiesis: [Hyperpiesi]
    let hyppish: [Hyppish]
    let idealizer: [Idealizer]
    let incrustator: [Incrustator]
    let intentiveness: [Intentiveness]
    let interacinar: Interacinar
    let intercorrelation: [[Int]?]
    let jacutinga: [Jacutinga]
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
    let apotropaion, casuary, creaker, disqualification: JSONNull?
    let imperatorious, impermeabilize, metastoma, noctidiurnal: JSONNull?
    let nonreserve, ophthalmotonometry, pailful, pigfish: JSONNull?
    let pongee, prosodical, scrofuloderm, storekeeping: JSONNull?
    let therologist, tolowa, tradeful, unriveting: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apotropaion, casuary, creaker, disqualification, imperatorious, impermeabilize, metastoma, noctidiurnal, nonreserve, ophthalmotonometry, pailful, pigfish, pongee, prosodical, scrofuloderm, storekeeping, therologist
        case tolowa = "Tolowa"
        case tradeful, unriveting
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
    let angioneurotic, availment, bladelet: JSONNull?
    let catharticalness: Double?
    let caulis, chalcus: JSONNull?
    let chirotherium: Int?
    let disdiapason: String?
    let enteradenological: JSONNull?
    let homocerc: Bool?
    let imporosity, insistently, intraparietal, ivied: JSONNull?
    let maureen, nonbookish, nostochine, nutcracker: JSONNull?
    let ofttimes, phenocryst, precoincident, ramiferous: JSONNull?
    let stagmometer, tetherball, unshy: JSONNull?

    enum CodingKeys: String, CodingKey {
        case angioneurotic, availment, bladelet, catharticalness, caulis, chalcus
        case chirotherium = "Chirotherium"
        case disdiapason, enteradenological, homocerc, imporosity, insistently, intraparietal, ivied
        case maureen = "Maureen"
        case nonbookish, nostochine, nutcracker, ofttimes, phenocryst, precoincident, ramiferous, stagmometer, tetherball, unshy
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
    let amidosulphonal, benny: JSONNull?
    let catharticalness: Double?
    let chirotherium: Int?
    let disdiapason: String?
    let ensnare: JSONNull?
    let homocerc: Bool?
    let hybridizer, leastwise, lof, monkhood: JSONNull?
    let netherlandish, nonbookish, peonism, phonelescope: JSONNull?
    let porphyrogeniture, preindemnify, rosal, scalenous: JSONNull?
    let scopine, sedaceae, suberinize, symbiot: JSONNull?
    let tablefellow, unchargeable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amidosulphonal
        case benny = "Benny"
        case catharticalness
        case chirotherium = "Chirotherium"
        case disdiapason, ensnare, homocerc, hybridizer, leastwise, lof, monkhood
        case netherlandish = "Netherlandish"
        case nonbookish, peonism
        case phonelescope = "Phonelescope"
        case porphyrogeniture, preindemnify, rosal, scalenous, scopine
        case sedaceae = "Sedaceae"
        case suberinize, symbiot, tablefellow, unchargeable
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
    let ammonolytic, bushmaster, considering, consuetudinary: JSONNull?
    let embarras, fineness, flaithship, flavia: JSONNull?
    let gruffly, hedychium, leadwort, overseriously: JSONNull?
    let parabola, pectinatodenticulate, popean, pornocrat: JSONNull?
    let quadrisect, seriality, vamphorn, wharp: JSONNull?

    enum CodingKeys: String, CodingKey {
        case ammonolytic, bushmaster, considering, consuetudinary, embarras, fineness, flaithship
        case flavia = "Flavia"
        case gruffly
        case hedychium = "Hedychium"
        case leadwort, overseriously, parabola, pectinatodenticulate
        case popean = "Popean"
        case pornocrat, quadrisect, seriality, vamphorn, wharp
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
    let bockerel, boulder, churrus, counterdigged: JSONNull?
    let dialogite, digenic, dunbird, ergatogyne: JSONNull?
    let fiendful, jackrod, jehovistic, paninean: JSONNull?
    let panther, placentigerous, romney, sparm: JSONNull?
    let tocsin, unnicked, unstavable, windfirm: JSONNull?

    enum CodingKeys: String, CodingKey {
        case bockerel, boulder, churrus, counterdigged, dialogite, digenic, dunbird, ergatogyne, fiendful, jackrod
        case jehovistic = "Jehovistic"
        case paninean = "Paninean"
        case panther, placentigerous
        case romney = "Romney"
        case sparm, tocsin, unnicked, unstavable, windfirm
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
    let amoreuxia, ani, bernicle, blackwasher: JSONNull?
    let blowhard, broma, closecross, congregationalism: JSONNull?
    let grayly, historically, hoast, irretentive: JSONNull?
    let parcener, pedder, pseudoanatomic, rhizocarpian: JSONNull?
    let samel, silker, subdentated, subobscure: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amoreuxia = "Amoreuxia"
        case ani, bernicle, blackwasher, blowhard, broma, closecross, congregationalism, grayly, historically, hoast, irretentive, parcener, pedder, pseudoanatomic, rhizocarpian, samel, silker, subdentated, subobscure
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
    let comradely, diacanthous, feminineness, gossamered: JSONNull?
    let hibernia, hibiscus, lepidosauria, lollingly: JSONNull?
    let manager, mechanic, overminuteness, papelonne: JSONNull?
    let plebification, pugmiller, recoveror, spermatoblastic: JSONNull?
    let syllidae, ungyved, whirlabout, woodenware: JSONNull?

    enum CodingKeys: String, CodingKey {
        case comradely, diacanthous, feminineness, gossamered
        case hibernia = "Hibernia"
        case hibiscus = "Hibiscus"
        case lepidosauria = "Lepidosauria"
        case lollingly, manager, mechanic, overminuteness, papelonne, plebification, pugmiller, recoveror, spermatoblastic
        case syllidae = "Syllidae"
        case ungyved, whirlabout, woodenware
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
    let abranchian, aculeiform, adiaphoristic, adoptionism: JSONNull?
    let anglic, antrotomy, coerciveness, decorist: JSONNull?
    let duckhood, heteromeri, hypochnose, lochage: JSONNull?
    let melee, nonconformitant, poinsettia, putatively: JSONNull?
    let semivolatile, soleas, unfastenable, unmillinered: JSONNull?

    enum CodingKeys: String, CodingKey {
        case abranchian, aculeiform, adiaphoristic, adoptionism
        case anglic = "Anglic"
        case antrotomy, coerciveness, decorist, duckhood
        case heteromeri = "Heteromeri"
        case hypochnose, lochage, melee, nonconformitant
        case poinsettia = "Poinsettia"
        case putatively, semivolatile, soleas, unfastenable, unmillinered
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
    let apoise, astronomize, cockhorse, copular: JSONNull?
    let dagomba, draffy, foreigner, guyandot: JSONNull?
    let neurogliosis, osmious, palpitate, rebukeable: JSONNull?
    let reinwardtia, reservatory, scalt, scripturalize: JSONNull?
    let tintometer, tritoness, undergrade, undermountain: JSONNull?

    enum CodingKeys: String, CodingKey {
        case apoise, astronomize, cockhorse, copular
        case dagomba = "Dagomba"
        case draffy, foreigner
        case guyandot = "Guyandot"
        case neurogliosis, osmious, palpitate, rebukeable
        case reinwardtia = "Reinwardtia"
        case reservatory, scalt, scripturalize, tintometer
        case tritoness = "Tritoness"
        case undergrade, undermountain
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
    let albarco, bunodonta, hornify, hydrocorisae: JSONNull?
    let hypoglossus, inexpiably, ingratitude, ladyfly: JSONNull?
    let medicament, monogrammatic, nobbut, notacanthidae: JSONNull?
    let polyplacophore, proexercise, protoplast, puzzling: JSONNull?
    let splanchnoskeleton, unloveliness, unquarantined, unrenounceable: JSONNull?

    enum CodingKeys: String, CodingKey {
        case albarco
        case bunodonta = "Bunodonta"
        case hornify
        case hydrocorisae = "Hydrocorisae"
        case hypoglossus, inexpiably, ingratitude, ladyfly, medicament, monogrammatic, nobbut
        case notacanthidae = "Notacanthidae"
        case polyplacophore, proexercise, protoplast, puzzling, splanchnoskeleton, unloveliness, unquarantined, unrenounceable
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
    let acrogamy, amelification, autobiographic, berat: JSONNull?
    let catharticalness: Double?
    let chirotherium: Int?
    let disdiapason: String?
    let disproportionably, erythrite, graphic, hepatological: JSONNull?
    let homocerc: Bool?
    let incommensurably, misaffirm, nonbookish, pocketbook: JSONNull?
    let sclerometric, stambouline, stickpin, tubulure: JSONNull?
    let undelated, unsalt, untutelar, vagrant: JSONNull?
    let walt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acrogamy, amelification, autobiographic, berat, catharticalness
        case chirotherium = "Chirotherium"
        case disdiapason, disproportionably, erythrite, graphic, hepatological, homocerc, incommensurably, misaffirm, nonbookish, pocketbook, sclerometric, stambouline, stickpin, tubulure, undelated, unsalt, untutelar, vagrant
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
    let assapan: Double
    let benefactorship: Bool
    let triseriatim: String
    let tubbing: Int
    let untrimmed: JSONNull?
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
