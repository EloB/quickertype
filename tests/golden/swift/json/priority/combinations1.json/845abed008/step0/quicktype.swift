// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
public struct TopLevel: Codable {
    public let centrodesmose: String
    public let cerograph: [CerographElement]
    public let chemotherapeutics: [ChemotherapeuticElement]
    public let cimelia: [CimeliaElement]
    public let citrated: Int
    public let clinodome: [Clinodome]
    public let coadjust: [CoadjustElement]
    public let consilience: [Consilience]
    public let constructor: [Constructor]
    public let continuative: [Continuative]
    public let credulity: [CredulityElement]
    public let creviced: [Creviced]
    public let cubiculum: [[Int?]]
    public let deruralize: [DeruralizeElement]
    public let diaereses: [DiaereseElement]
    public let dissolution: [[JSONNull?]?]
    public let downstroke: [Downstroke]
    public let electrotautomerism: [Double?]
    public let eleutheromania: [Eleutheromania]
    public let encrust: Encrust
    public let entomoid: [Entomoid]
    public let epipaleolithic: [Epipaleolithic]
    public let expropriable: [Expropriable]
    public let faggingly: [FagginglyElement]
    public let fenks: [FenkElement]
    public let flagmaking: [FlagmakingElement]
    public let fluorometer: [Fluorometer]
    public let fulsome: [Int?]
    public let fuzzy: [Fuzzy]
    public let gardenwards: [Gardenward]
    public let generalissimo: [Generalissimo]
    public let habeas: [[String: Int]?]
    public let hemicrystalline: [Hemicrystalline]
    public let hemocoele: [HemocoeleElement]
    public let hoister: [Hoister]
    public let hyperpiesis: [Hyperpiesi]
    public let hyppish: [Hyppish]
    public let idealizer: [Idealizer]
    public let incrustator: [Incrustator]
    public let intentiveness: [Intentiveness]
    public let interacinar: Interacinar
    public let intercorrelation: [[Int]?]
    public let jacutinga: [Jacutinga]

    public enum CodingKeys: String, CodingKey {
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

    public init(centrodesmose: String, cerograph: [CerographElement], chemotherapeutics: [ChemotherapeuticElement], cimelia: [CimeliaElement], citrated: Int, clinodome: [Clinodome], coadjust: [CoadjustElement], consilience: [Consilience], constructor: [Constructor], continuative: [Continuative], credulity: [CredulityElement], creviced: [Creviced], cubiculum: [[Int?]], deruralize: [DeruralizeElement], diaereses: [DiaereseElement], dissolution: [[JSONNull?]?], downstroke: [Downstroke], electrotautomerism: [Double?], eleutheromania: [Eleutheromania], encrust: Encrust, entomoid: [Entomoid], epipaleolithic: [Epipaleolithic], expropriable: [Expropriable], faggingly: [FagginglyElement], fenks: [FenkElement], flagmaking: [FlagmakingElement], fluorometer: [Fluorometer], fulsome: [Int?], fuzzy: [Fuzzy], gardenwards: [Gardenward], generalissimo: [Generalissimo], habeas: [[String: Int]?], hemicrystalline: [Hemicrystalline], hemocoele: [HemocoeleElement], hoister: [Hoister], hyperpiesis: [Hyperpiesi], hyppish: [Hyppish], idealizer: [Idealizer], incrustator: [Incrustator], intentiveness: [Intentiveness], interacinar: Interacinar, intercorrelation: [[Int]?], jacutinga: [Jacutinga]) {
        self.centrodesmose = centrodesmose
        self.cerograph = cerograph
        self.chemotherapeutics = chemotherapeutics
        self.cimelia = cimelia
        self.citrated = citrated
        self.clinodome = clinodome
        self.coadjust = coadjust
        self.consilience = consilience
        self.constructor = constructor
        self.continuative = continuative
        self.credulity = credulity
        self.creviced = creviced
        self.cubiculum = cubiculum
        self.deruralize = deruralize
        self.diaereses = diaereses
        self.dissolution = dissolution
        self.downstroke = downstroke
        self.electrotautomerism = electrotautomerism
        self.eleutheromania = eleutheromania
        self.encrust = encrust
        self.entomoid = entomoid
        self.epipaleolithic = epipaleolithic
        self.expropriable = expropriable
        self.faggingly = faggingly
        self.fenks = fenks
        self.flagmaking = flagmaking
        self.fluorometer = fluorometer
        self.fulsome = fulsome
        self.fuzzy = fuzzy
        self.gardenwards = gardenwards
        self.generalissimo = generalissimo
        self.habeas = habeas
        self.hemicrystalline = hemicrystalline
        self.hemocoele = hemocoele
        self.hoister = hoister
        self.hyperpiesis = hyperpiesis
        self.hyppish = hyppish
        self.idealizer = idealizer
        self.incrustator = incrustator
        self.intentiveness = intentiveness
        self.interacinar = interacinar
        self.intercorrelation = intercorrelation
        self.jacutinga = jacutinga
    }
}

// MARK: TopLevel convenience initializers and mutators

public extension TopLevel {
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

public enum CerographElement: Codable {
    case cerographClass(CerographClass)
    case string(String)
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct CerographClass: Codable {
    public let apotropaion: JSONNull?
    public let casuary: JSONNull?
    public let creaker: JSONNull?
    public let disqualification: JSONNull?
    public let imperatorious: JSONNull?
    public let impermeabilize: JSONNull?
    public let metastoma: JSONNull?
    public let noctidiurnal: JSONNull?
    public let nonreserve: JSONNull?
    public let ophthalmotonometry: JSONNull?
    public let pailful: JSONNull?
    public let pigfish: JSONNull?
    public let pongee: JSONNull?
    public let prosodical: JSONNull?
    public let scrofuloderm: JSONNull?
    public let storekeeping: JSONNull?
    public let therologist: JSONNull?
    public let tolowa: JSONNull?
    public let tradeful: JSONNull?
    public let unriveting: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(apotropaion: JSONNull?, casuary: JSONNull?, creaker: JSONNull?, disqualification: JSONNull?, imperatorious: JSONNull?, impermeabilize: JSONNull?, metastoma: JSONNull?, noctidiurnal: JSONNull?, nonreserve: JSONNull?, ophthalmotonometry: JSONNull?, pailful: JSONNull?, pigfish: JSONNull?, pongee: JSONNull?, prosodical: JSONNull?, scrofuloderm: JSONNull?, storekeeping: JSONNull?, therologist: JSONNull?, tolowa: JSONNull?, tradeful: JSONNull?, unriveting: JSONNull?) {
        self.apotropaion = apotropaion
        self.casuary = casuary
        self.creaker = creaker
        self.disqualification = disqualification
        self.imperatorious = imperatorious
        self.impermeabilize = impermeabilize
        self.metastoma = metastoma
        self.noctidiurnal = noctidiurnal
        self.nonreserve = nonreserve
        self.ophthalmotonometry = ophthalmotonometry
        self.pailful = pailful
        self.pigfish = pigfish
        self.pongee = pongee
        self.prosodical = prosodical
        self.scrofuloderm = scrofuloderm
        self.storekeeping = storekeeping
        self.therologist = therologist
        self.tolowa = tolowa
        self.tradeful = tradeful
        self.unriveting = unriveting
    }
}

// MARK: CerographClass convenience initializers and mutators

public extension CerographClass {
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

public enum ChemotherapeuticElement: Codable {
    case chemotherapeuticClass(ChemotherapeuticClass)
    case integer(Int)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct ChemotherapeuticClass: Codable {
    public let angioneurotic: JSONNull?
    public let availment: JSONNull?
    public let bladelet: JSONNull?
    public let catharticalness: Double?
    public let caulis: JSONNull?
    public let chalcus: JSONNull?
    public let chirotherium: Int?
    public let disdiapason: String?
    public let enteradenological: JSONNull?
    public let homocerc: Bool?
    public let imporosity: JSONNull?
    public let insistently: JSONNull?
    public let intraparietal: JSONNull?
    public let ivied: JSONNull?
    public let maureen: JSONNull?
    public let nonbookish: JSONNull?
    public let nostochine: JSONNull?
    public let nutcracker: JSONNull?
    public let ofttimes: JSONNull?
    public let phenocryst: JSONNull?
    public let precoincident: JSONNull?
    public let ramiferous: JSONNull?
    public let stagmometer: JSONNull?
    public let tetherball: JSONNull?
    public let unshy: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(angioneurotic: JSONNull?, availment: JSONNull?, bladelet: JSONNull?, catharticalness: Double?, caulis: JSONNull?, chalcus: JSONNull?, chirotherium: Int?, disdiapason: String?, enteradenological: JSONNull?, homocerc: Bool?, imporosity: JSONNull?, insistently: JSONNull?, intraparietal: JSONNull?, ivied: JSONNull?, maureen: JSONNull?, nonbookish: JSONNull?, nostochine: JSONNull?, nutcracker: JSONNull?, ofttimes: JSONNull?, phenocryst: JSONNull?, precoincident: JSONNull?, ramiferous: JSONNull?, stagmometer: JSONNull?, tetherball: JSONNull?, unshy: JSONNull?) {
        self.angioneurotic = angioneurotic
        self.availment = availment
        self.bladelet = bladelet
        self.catharticalness = catharticalness
        self.caulis = caulis
        self.chalcus = chalcus
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.enteradenological = enteradenological
        self.homocerc = homocerc
        self.imporosity = imporosity
        self.insistently = insistently
        self.intraparietal = intraparietal
        self.ivied = ivied
        self.maureen = maureen
        self.nonbookish = nonbookish
        self.nostochine = nostochine
        self.nutcracker = nutcracker
        self.ofttimes = ofttimes
        self.phenocryst = phenocryst
        self.precoincident = precoincident
        self.ramiferous = ramiferous
        self.stagmometer = stagmometer
        self.tetherball = tetherball
        self.unshy = unshy
    }
}

// MARK: ChemotherapeuticClass convenience initializers and mutators

public extension ChemotherapeuticClass {
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

public enum CimeliaElement: Codable {
    case cimeliaClass(CimeliaClass)
    case integerArray([Int])
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct CimeliaClass: Codable {
    public let catharticalness: Double
    public let chirotherium: Int
    public let disdiapason: String
    public let homocerc: Bool
    public let nonbookish: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case homocerc = "homocerc"
        case nonbookish = "nonbookish"
    }

    public init(catharticalness: Double, chirotherium: Int, disdiapason: String, homocerc: Bool, nonbookish: JSONNull?) {
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.homocerc = homocerc
        self.nonbookish = nonbookish
    }
}

// MARK: CimeliaClass convenience initializers and mutators

public extension CimeliaClass {
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

public enum Clinodome: Codable {
    case double(Double)
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum CoadjustElement: Codable {
    case coadjustClass(CoadjustClass)
    case double(Double)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct CoadjustClass: Codable {
    public let amidosulphonal: JSONNull?
    public let benny: JSONNull?
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let disdiapason: String?
    public let ensnare: JSONNull?
    public let homocerc: Bool?
    public let hybridizer: JSONNull?
    public let leastwise: JSONNull?
    public let lof: JSONNull?
    public let monkhood: JSONNull?
    public let netherlandish: JSONNull?
    public let nonbookish: JSONNull?
    public let peonism: JSONNull?
    public let phonelescope: JSONNull?
    public let porphyrogeniture: JSONNull?
    public let preindemnify: JSONNull?
    public let rosal: JSONNull?
    public let scalenous: JSONNull?
    public let scopine: JSONNull?
    public let sedaceae: JSONNull?
    public let suberinize: JSONNull?
    public let symbiot: JSONNull?
    public let tablefellow: JSONNull?
    public let unchargeable: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(amidosulphonal: JSONNull?, benny: JSONNull?, catharticalness: Double?, chirotherium: Int?, disdiapason: String?, ensnare: JSONNull?, homocerc: Bool?, hybridizer: JSONNull?, leastwise: JSONNull?, lof: JSONNull?, monkhood: JSONNull?, netherlandish: JSONNull?, nonbookish: JSONNull?, peonism: JSONNull?, phonelescope: JSONNull?, porphyrogeniture: JSONNull?, preindemnify: JSONNull?, rosal: JSONNull?, scalenous: JSONNull?, scopine: JSONNull?, sedaceae: JSONNull?, suberinize: JSONNull?, symbiot: JSONNull?, tablefellow: JSONNull?, unchargeable: JSONNull?) {
        self.amidosulphonal = amidosulphonal
        self.benny = benny
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.ensnare = ensnare
        self.homocerc = homocerc
        self.hybridizer = hybridizer
        self.leastwise = leastwise
        self.lof = lof
        self.monkhood = monkhood
        self.netherlandish = netherlandish
        self.nonbookish = nonbookish
        self.peonism = peonism
        self.phonelescope = phonelescope
        self.porphyrogeniture = porphyrogeniture
        self.preindemnify = preindemnify
        self.rosal = rosal
        self.scalenous = scalenous
        self.scopine = scopine
        self.sedaceae = sedaceae
        self.suberinize = suberinize
        self.symbiot = symbiot
        self.tablefellow = tablefellow
        self.unchargeable = unchargeable
    }
}

// MARK: CoadjustClass convenience initializers and mutators

public extension CoadjustClass {
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

public enum Consilience: Codable {
    case double(Double)
    case integerMap([String: Int])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

public enum Constructor: Codable {
    case bool(Bool)
    case unionMap([String: Int?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

public enum Continuative: Codable {
    case integerMap([String: Int])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum CredulityElement: Codable {
    case credulityClass(CredulityClass)
    case integer(Int)
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct CredulityClass: Codable {
    public let ammonolytic: JSONNull?
    public let bushmaster: JSONNull?
    public let considering: JSONNull?
    public let consuetudinary: JSONNull?
    public let embarras: JSONNull?
    public let fineness: JSONNull?
    public let flaithship: JSONNull?
    public let flavia: JSONNull?
    public let gruffly: JSONNull?
    public let hedychium: JSONNull?
    public let leadwort: JSONNull?
    public let overseriously: JSONNull?
    public let parabola: JSONNull?
    public let pectinatodenticulate: JSONNull?
    public let popean: JSONNull?
    public let pornocrat: JSONNull?
    public let quadrisect: JSONNull?
    public let seriality: JSONNull?
    public let vamphorn: JSONNull?
    public let wharp: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(ammonolytic: JSONNull?, bushmaster: JSONNull?, considering: JSONNull?, consuetudinary: JSONNull?, embarras: JSONNull?, fineness: JSONNull?, flaithship: JSONNull?, flavia: JSONNull?, gruffly: JSONNull?, hedychium: JSONNull?, leadwort: JSONNull?, overseriously: JSONNull?, parabola: JSONNull?, pectinatodenticulate: JSONNull?, popean: JSONNull?, pornocrat: JSONNull?, quadrisect: JSONNull?, seriality: JSONNull?, vamphorn: JSONNull?, wharp: JSONNull?) {
        self.ammonolytic = ammonolytic
        self.bushmaster = bushmaster
        self.considering = considering
        self.consuetudinary = consuetudinary
        self.embarras = embarras
        self.fineness = fineness
        self.flaithship = flaithship
        self.flavia = flavia
        self.gruffly = gruffly
        self.hedychium = hedychium
        self.leadwort = leadwort
        self.overseriously = overseriously
        self.parabola = parabola
        self.pectinatodenticulate = pectinatodenticulate
        self.popean = popean
        self.pornocrat = pornocrat
        self.quadrisect = quadrisect
        self.seriality = seriality
        self.vamphorn = vamphorn
        self.wharp = wharp
    }
}

// MARK: CredulityClass convenience initializers and mutators

public extension CredulityClass {
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

public enum Creviced: Codable {
    case bool(Bool)
    case integerMap([String: Int])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum DeruralizeElement: Codable {
    case bool(Bool)
    case deruralizeClass(DeruralizeClass)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct DeruralizeClass: Codable {
    public let bockerel: JSONNull?
    public let boulder: JSONNull?
    public let churrus: JSONNull?
    public let counterdigged: JSONNull?
    public let dialogite: JSONNull?
    public let digenic: JSONNull?
    public let dunbird: JSONNull?
    public let ergatogyne: JSONNull?
    public let fiendful: JSONNull?
    public let jackrod: JSONNull?
    public let jehovistic: JSONNull?
    public let paninean: JSONNull?
    public let panther: JSONNull?
    public let placentigerous: JSONNull?
    public let romney: JSONNull?
    public let sparm: JSONNull?
    public let tocsin: JSONNull?
    public let unnicked: JSONNull?
    public let unstavable: JSONNull?
    public let windfirm: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(bockerel: JSONNull?, boulder: JSONNull?, churrus: JSONNull?, counterdigged: JSONNull?, dialogite: JSONNull?, digenic: JSONNull?, dunbird: JSONNull?, ergatogyne: JSONNull?, fiendful: JSONNull?, jackrod: JSONNull?, jehovistic: JSONNull?, paninean: JSONNull?, panther: JSONNull?, placentigerous: JSONNull?, romney: JSONNull?, sparm: JSONNull?, tocsin: JSONNull?, unnicked: JSONNull?, unstavable: JSONNull?, windfirm: JSONNull?) {
        self.bockerel = bockerel
        self.boulder = boulder
        self.churrus = churrus
        self.counterdigged = counterdigged
        self.dialogite = dialogite
        self.digenic = digenic
        self.dunbird = dunbird
        self.ergatogyne = ergatogyne
        self.fiendful = fiendful
        self.jackrod = jackrod
        self.jehovistic = jehovistic
        self.paninean = paninean
        self.panther = panther
        self.placentigerous = placentigerous
        self.romney = romney
        self.sparm = sparm
        self.tocsin = tocsin
        self.unnicked = unnicked
        self.unstavable = unstavable
        self.windfirm = windfirm
    }
}

// MARK: DeruralizeClass convenience initializers and mutators

public extension DeruralizeClass {
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

public enum DiaereseElement: Codable {
    case bool(Bool)
    case diaereseClass(DiaereseClass)
    case integerArray([Int])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct DiaereseClass: Codable {
    public let amoreuxia: JSONNull?
    public let ani: JSONNull?
    public let bernicle: JSONNull?
    public let blackwasher: JSONNull?
    public let blowhard: JSONNull?
    public let broma: JSONNull?
    public let closecross: JSONNull?
    public let congregationalism: JSONNull?
    public let grayly: JSONNull?
    public let historically: JSONNull?
    public let hoast: JSONNull?
    public let irretentive: JSONNull?
    public let parcener: JSONNull?
    public let pedder: JSONNull?
    public let pseudoanatomic: JSONNull?
    public let rhizocarpian: JSONNull?
    public let samel: JSONNull?
    public let silker: JSONNull?
    public let subdentated: JSONNull?
    public let subobscure: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(amoreuxia: JSONNull?, ani: JSONNull?, bernicle: JSONNull?, blackwasher: JSONNull?, blowhard: JSONNull?, broma: JSONNull?, closecross: JSONNull?, congregationalism: JSONNull?, grayly: JSONNull?, historically: JSONNull?, hoast: JSONNull?, irretentive: JSONNull?, parcener: JSONNull?, pedder: JSONNull?, pseudoanatomic: JSONNull?, rhizocarpian: JSONNull?, samel: JSONNull?, silker: JSONNull?, subdentated: JSONNull?, subobscure: JSONNull?) {
        self.amoreuxia = amoreuxia
        self.ani = ani
        self.bernicle = bernicle
        self.blackwasher = blackwasher
        self.blowhard = blowhard
        self.broma = broma
        self.closecross = closecross
        self.congregationalism = congregationalism
        self.grayly = grayly
        self.historically = historically
        self.hoast = hoast
        self.irretentive = irretentive
        self.parcener = parcener
        self.pedder = pedder
        self.pseudoanatomic = pseudoanatomic
        self.rhizocarpian = rhizocarpian
        self.samel = samel
        self.silker = silker
        self.subdentated = subdentated
        self.subobscure = subobscure
    }
}

// MARK: DiaereseClass convenience initializers and mutators

public extension DiaereseClass {
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

public enum Downstroke: Codable {
    case bool(Bool)
    case nullArray([JSONNull?])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Eleutheromania: Codable {
    case double(Double)
    case integerMap([String: Int])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct Encrust: Codable {
    public let comradely: JSONNull?
    public let diacanthous: JSONNull?
    public let feminineness: JSONNull?
    public let gossamered: JSONNull?
    public let hibernia: JSONNull?
    public let hibiscus: JSONNull?
    public let lepidosauria: JSONNull?
    public let lollingly: JSONNull?
    public let manager: JSONNull?
    public let mechanic: JSONNull?
    public let overminuteness: JSONNull?
    public let papelonne: JSONNull?
    public let plebification: JSONNull?
    public let pugmiller: JSONNull?
    public let recoveror: JSONNull?
    public let spermatoblastic: JSONNull?
    public let syllidae: JSONNull?
    public let ungyved: JSONNull?
    public let whirlabout: JSONNull?
    public let woodenware: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(comradely: JSONNull?, diacanthous: JSONNull?, feminineness: JSONNull?, gossamered: JSONNull?, hibernia: JSONNull?, hibiscus: JSONNull?, lepidosauria: JSONNull?, lollingly: JSONNull?, manager: JSONNull?, mechanic: JSONNull?, overminuteness: JSONNull?, papelonne: JSONNull?, plebification: JSONNull?, pugmiller: JSONNull?, recoveror: JSONNull?, spermatoblastic: JSONNull?, syllidae: JSONNull?, ungyved: JSONNull?, whirlabout: JSONNull?, woodenware: JSONNull?) {
        self.comradely = comradely
        self.diacanthous = diacanthous
        self.feminineness = feminineness
        self.gossamered = gossamered
        self.hibernia = hibernia
        self.hibiscus = hibiscus
        self.lepidosauria = lepidosauria
        self.lollingly = lollingly
        self.manager = manager
        self.mechanic = mechanic
        self.overminuteness = overminuteness
        self.papelonne = papelonne
        self.plebification = plebification
        self.pugmiller = pugmiller
        self.recoveror = recoveror
        self.spermatoblastic = spermatoblastic
        self.syllidae = syllidae
        self.ungyved = ungyved
        self.whirlabout = whirlabout
        self.woodenware = woodenware
    }
}

// MARK: Encrust convenience initializers and mutators

public extension Encrust {
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

public enum Entomoid: Codable {
    case cimeliaClass(CimeliaClass)
    case integer(Int)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

public enum Epipaleolithic: Codable {
    case double(Double)
    case integerArray([Int])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

public enum Expropriable: Codable {
    case cimeliaClass(CimeliaClass)
    case double(Double)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum FagginglyElement: Codable {
    case double(Double)
    case fagginglyClass(FagginglyClass)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct FagginglyClass: Codable {
    public let abranchian: JSONNull?
    public let aculeiform: JSONNull?
    public let adiaphoristic: JSONNull?
    public let adoptionism: JSONNull?
    public let anglic: JSONNull?
    public let antrotomy: JSONNull?
    public let coerciveness: JSONNull?
    public let decorist: JSONNull?
    public let duckhood: JSONNull?
    public let heteromeri: JSONNull?
    public let hypochnose: JSONNull?
    public let lochage: JSONNull?
    public let melee: JSONNull?
    public let nonconformitant: JSONNull?
    public let poinsettia: JSONNull?
    public let putatively: JSONNull?
    public let semivolatile: JSONNull?
    public let soleas: JSONNull?
    public let unfastenable: JSONNull?
    public let unmillinered: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(abranchian: JSONNull?, aculeiform: JSONNull?, adiaphoristic: JSONNull?, adoptionism: JSONNull?, anglic: JSONNull?, antrotomy: JSONNull?, coerciveness: JSONNull?, decorist: JSONNull?, duckhood: JSONNull?, heteromeri: JSONNull?, hypochnose: JSONNull?, lochage: JSONNull?, melee: JSONNull?, nonconformitant: JSONNull?, poinsettia: JSONNull?, putatively: JSONNull?, semivolatile: JSONNull?, soleas: JSONNull?, unfastenable: JSONNull?, unmillinered: JSONNull?) {
        self.abranchian = abranchian
        self.aculeiform = aculeiform
        self.adiaphoristic = adiaphoristic
        self.adoptionism = adoptionism
        self.anglic = anglic
        self.antrotomy = antrotomy
        self.coerciveness = coerciveness
        self.decorist = decorist
        self.duckhood = duckhood
        self.heteromeri = heteromeri
        self.hypochnose = hypochnose
        self.lochage = lochage
        self.melee = melee
        self.nonconformitant = nonconformitant
        self.poinsettia = poinsettia
        self.putatively = putatively
        self.semivolatile = semivolatile
        self.soleas = soleas
        self.unfastenable = unfastenable
        self.unmillinered = unmillinered
    }
}

// MARK: FagginglyClass convenience initializers and mutators

public extension FagginglyClass {
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

public enum FenkElement: Codable {
    case fenkClass(FenkClass)
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct FenkClass: Codable {
    public let apoise: JSONNull?
    public let astronomize: JSONNull?
    public let cockhorse: JSONNull?
    public let copular: JSONNull?
    public let dagomba: JSONNull?
    public let draffy: JSONNull?
    public let foreigner: JSONNull?
    public let guyandot: JSONNull?
    public let neurogliosis: JSONNull?
    public let osmious: JSONNull?
    public let palpitate: JSONNull?
    public let rebukeable: JSONNull?
    public let reinwardtia: JSONNull?
    public let reservatory: JSONNull?
    public let scalt: JSONNull?
    public let scripturalize: JSONNull?
    public let tintometer: JSONNull?
    public let tritoness: JSONNull?
    public let undergrade: JSONNull?
    public let undermountain: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(apoise: JSONNull?, astronomize: JSONNull?, cockhorse: JSONNull?, copular: JSONNull?, dagomba: JSONNull?, draffy: JSONNull?, foreigner: JSONNull?, guyandot: JSONNull?, neurogliosis: JSONNull?, osmious: JSONNull?, palpitate: JSONNull?, rebukeable: JSONNull?, reinwardtia: JSONNull?, reservatory: JSONNull?, scalt: JSONNull?, scripturalize: JSONNull?, tintometer: JSONNull?, tritoness: JSONNull?, undergrade: JSONNull?, undermountain: JSONNull?) {
        self.apoise = apoise
        self.astronomize = astronomize
        self.cockhorse = cockhorse
        self.copular = copular
        self.dagomba = dagomba
        self.draffy = draffy
        self.foreigner = foreigner
        self.guyandot = guyandot
        self.neurogliosis = neurogliosis
        self.osmious = osmious
        self.palpitate = palpitate
        self.rebukeable = rebukeable
        self.reinwardtia = reinwardtia
        self.reservatory = reservatory
        self.scalt = scalt
        self.scripturalize = scripturalize
        self.tintometer = tintometer
        self.tritoness = tritoness
        self.undergrade = undergrade
        self.undermountain = undermountain
    }
}

// MARK: FenkClass convenience initializers and mutators

public extension FenkClass {
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

public enum FlagmakingElement: Codable {
    case bool(Bool)
    case double(Double)
    case flagmakingClass(FlagmakingClass)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct FlagmakingClass: Codable {
    public let albarco: JSONNull?
    public let bunodonta: JSONNull?
    public let hornify: JSONNull?
    public let hydrocorisae: JSONNull?
    public let hypoglossus: JSONNull?
    public let inexpiably: JSONNull?
    public let ingratitude: JSONNull?
    public let ladyfly: JSONNull?
    public let medicament: JSONNull?
    public let monogrammatic: JSONNull?
    public let nobbut: JSONNull?
    public let notacanthidae: JSONNull?
    public let polyplacophore: JSONNull?
    public let proexercise: JSONNull?
    public let protoplast: JSONNull?
    public let puzzling: JSONNull?
    public let splanchnoskeleton: JSONNull?
    public let unloveliness: JSONNull?
    public let unquarantined: JSONNull?
    public let unrenounceable: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(albarco: JSONNull?, bunodonta: JSONNull?, hornify: JSONNull?, hydrocorisae: JSONNull?, hypoglossus: JSONNull?, inexpiably: JSONNull?, ingratitude: JSONNull?, ladyfly: JSONNull?, medicament: JSONNull?, monogrammatic: JSONNull?, nobbut: JSONNull?, notacanthidae: JSONNull?, polyplacophore: JSONNull?, proexercise: JSONNull?, protoplast: JSONNull?, puzzling: JSONNull?, splanchnoskeleton: JSONNull?, unloveliness: JSONNull?, unquarantined: JSONNull?, unrenounceable: JSONNull?) {
        self.albarco = albarco
        self.bunodonta = bunodonta
        self.hornify = hornify
        self.hydrocorisae = hydrocorisae
        self.hypoglossus = hypoglossus
        self.inexpiably = inexpiably
        self.ingratitude = ingratitude
        self.ladyfly = ladyfly
        self.medicament = medicament
        self.monogrammatic = monogrammatic
        self.nobbut = nobbut
        self.notacanthidae = notacanthidae
        self.polyplacophore = polyplacophore
        self.proexercise = proexercise
        self.protoplast = protoplast
        self.puzzling = puzzling
        self.splanchnoskeleton = splanchnoskeleton
        self.unloveliness = unloveliness
        self.unquarantined = unquarantined
        self.unrenounceable = unrenounceable
    }
}

// MARK: FlagmakingClass convenience initializers and mutators

public extension FlagmakingClass {
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

public enum Fluorometer: Codable {
    case integer(Int)
    case string(String)
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Fuzzy: Codable {
    case integer(Int)
    case unionMap([String: Int?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

public enum Gardenward: Codable {
    case bool(Bool)
    case integerArray([Int])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Generalissimo: Codable {
    case bool(Bool)
    case integerMap([String: Int])
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Hemicrystalline: Codable {
    case cimeliaClass(CimeliaClass)
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cimeliaClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum HemocoeleElement: Codable {
    case hemocoeleClass(HemocoeleClass)
    case integerArray([Int])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct HemocoeleClass: Codable {
    public let acrogamy: JSONNull?
    public let amelification: JSONNull?
    public let autobiographic: JSONNull?
    public let berat: JSONNull?
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let disdiapason: String?
    public let disproportionably: JSONNull?
    public let erythrite: JSONNull?
    public let graphic: JSONNull?
    public let hepatological: JSONNull?
    public let homocerc: Bool?
    public let incommensurably: JSONNull?
    public let misaffirm: JSONNull?
    public let nonbookish: JSONNull?
    public let pocketbook: JSONNull?
    public let sclerometric: JSONNull?
    public let stambouline: JSONNull?
    public let stickpin: JSONNull?
    public let tubulure: JSONNull?
    public let undelated: JSONNull?
    public let unsalt: JSONNull?
    public let untutelar: JSONNull?
    public let vagrant: JSONNull?
    public let walt: JSONNull?

    public enum CodingKeys: String, CodingKey {
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

    public init(acrogamy: JSONNull?, amelification: JSONNull?, autobiographic: JSONNull?, berat: JSONNull?, catharticalness: Double?, chirotherium: Int?, disdiapason: String?, disproportionably: JSONNull?, erythrite: JSONNull?, graphic: JSONNull?, hepatological: JSONNull?, homocerc: Bool?, incommensurably: JSONNull?, misaffirm: JSONNull?, nonbookish: JSONNull?, pocketbook: JSONNull?, sclerometric: JSONNull?, stambouline: JSONNull?, stickpin: JSONNull?, tubulure: JSONNull?, undelated: JSONNull?, unsalt: JSONNull?, untutelar: JSONNull?, vagrant: JSONNull?, walt: JSONNull?) {
        self.acrogamy = acrogamy
        self.amelification = amelification
        self.autobiographic = autobiographic
        self.berat = berat
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.disproportionably = disproportionably
        self.erythrite = erythrite
        self.graphic = graphic
        self.hepatological = hepatological
        self.homocerc = homocerc
        self.incommensurably = incommensurably
        self.misaffirm = misaffirm
        self.nonbookish = nonbookish
        self.pocketbook = pocketbook
        self.sclerometric = sclerometric
        self.stambouline = stambouline
        self.stickpin = stickpin
        self.tubulure = tubulure
        self.undelated = undelated
        self.unsalt = unsalt
        self.untutelar = untutelar
        self.vagrant = vagrant
        self.walt = walt
    }
}

// MARK: HemocoeleClass convenience initializers and mutators

public extension HemocoeleClass {
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

public enum Hoister: Codable {
    case cimeliaClass(CimeliaClass)
    case string(String)
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Hyperpiesi: Codable {
    case cimeliaClass(CimeliaClass)
    case nullArray([JSONNull?])
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Hyppish: Codable {
    case bool(Bool)
    case string(String)
    case null

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Idealizer: Codable {
    case cimeliaClass(CimeliaClass)
    case integer(Int)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Incrustator: Codable {
    case integer(Int)
    case integerArray([Int])
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public enum Intentiveness: Codable {
    case cimeliaClass(CimeliaClass)
    case double(Double)
    case string(String)

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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
public struct Interacinar: Codable {
    public let assapan: Double
    public let benefactorship: Bool
    public let triseriatim: String
    public let tubbing: Int
    public let untrimmed: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case assapan = "assapan"
        case benefactorship = "benefactorship"
        case triseriatim = "triseriatim"
        case tubbing = "tubbing"
        case untrimmed = "untrimmed"
    }

    public init(assapan: Double, benefactorship: Bool, triseriatim: String, tubbing: Int, untrimmed: JSONNull?) {
        self.assapan = assapan
        self.benefactorship = benefactorship
        self.triseriatim = triseriatim
        self.tubbing = tubbing
        self.untrimmed = untrimmed
    }
}

// MARK: Interacinar convenience initializers and mutators

public extension Interacinar {
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

public enum Jacutinga: Codable {
    case integerArray([Int])
    case unionMap([String: Int?])

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public class JSONNull: Codable, Hashable {

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
