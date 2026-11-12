// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let protrusive: [Protrusive]
    let pulpitism: [PulpitismElement]
    let pyodermia: [PyodermiaElement]
    let quebrachine: [QuebrachineElement]
    let querier: [Querier]
    let rebarbative: [Rebarbative]
    let reimagine: [Reimagine]
    let ressaut: Ressaut
    let retrocervical: [Retrocervical]
    let revert: [Revert]
    let rewrite: [RewriteElement]
    let saccoderm: [Saccoderm]
    let santir: [SantirElement]
    let saprophilous: [Saprophilous]
    let saxten: [SaxtenElement]
    let scatty: [Scatty?]
    let scoffer: [Scoffer]
    let scrampum: [Scrampum]
    let semantic: Double
    let serpentinic: [Serpentinic]
    let shadowable: [Shadowable]
    let sistering: [SisteringElement]
    let staghunting: [Staghunting]
    let stagmometer: [Stagmometer]
    let stimulability: [Stimulability]
    let strangleable: [Strangleable]
    let strenuosity: [StrenuosityElement]
    let tabaxir: [Tabaxir]
    let talpiform: [Talpiform]
    let thwack: [Thwack]
    let to: [Double?]
    let tortricine: [Tortricine]
    let truantcy: [TruantcyElement]
    let turgesce: [String]
    let unbeginning: [Unbeginning]
    let underdunged: [Double]
    let undesirability: [Undesirability]
    let unerasing: [Unerasing]
    let unguentarium: [Unguentarium]
    let unimpeachably: [UnimpeachablyElement]
    let unmortgaged: [Unmortgaged]
    let unobstructed: [Unobstructed]
    let unreceptivity: [Unreceptivity]
    let unsatisfactoriness: [Unsatisfactoriness]
    let unsecurity: [Int]
    let unstressed: [UnstressedElement]
    let untasked: [Untasked]
    let unvarying: [Unvarying]
    let vehemently: [Vehemently]
    let warriorship: [String: Bool]
    let whitepot: [Whitepot]
    let wrothy: [WrothyElement]

    enum CodingKeys: String, CodingKey {
        case protrusive = "protrusive"
        case pulpitism = "pulpitism"
        case pyodermia = "pyodermia"
        case quebrachine = "quebrachine"
        case querier = "querier"
        case rebarbative = "rebarbative"
        case reimagine = "reimagine"
        case ressaut = "ressaut"
        case retrocervical = "retrocervical"
        case revert = "revert"
        case rewrite = "rewrite"
        case saccoderm = "saccoderm"
        case santir = "santir"
        case saprophilous = "saprophilous"
        case saxten = "saxten"
        case scatty = "scatty"
        case scoffer = "scoffer"
        case scrampum = "scrampum"
        case semantic = "semantic"
        case serpentinic = "serpentinic"
        case shadowable = "shadowable"
        case sistering = "sistering"
        case staghunting = "staghunting"
        case stagmometer = "stagmometer"
        case stimulability = "stimulability"
        case strangleable = "strangleable"
        case strenuosity = "strenuosity"
        case tabaxir = "tabaxir"
        case talpiform = "talpiform"
        case thwack = "thwack"
        case to = "to"
        case tortricine = "tortricine"
        case truantcy = "truantcy"
        case turgesce = "turgesce"
        case unbeginning = "unbeginning"
        case underdunged = "underdunged"
        case undesirability = "undesirability"
        case unerasing = "unerasing"
        case unguentarium = "unguentarium"
        case unimpeachably = "unimpeachably"
        case unmortgaged = "unmortgaged"
        case unobstructed = "unobstructed"
        case unreceptivity = "unreceptivity"
        case unsatisfactoriness = "unsatisfactoriness"
        case unsecurity = "unsecurity"
        case unstressed = "unstressed"
        case untasked = "untasked"
        case unvarying = "unvarying"
        case vehemently = "vehemently"
        case warriorship = "warriorship"
        case whitepot = "whitepot"
        case wrothy = "wrothy"
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
        protrusive: [Protrusive]? = nil,
        pulpitism: [PulpitismElement]? = nil,
        pyodermia: [PyodermiaElement]? = nil,
        quebrachine: [QuebrachineElement]? = nil,
        querier: [Querier]? = nil,
        rebarbative: [Rebarbative]? = nil,
        reimagine: [Reimagine]? = nil,
        ressaut: Ressaut? = nil,
        retrocervical: [Retrocervical]? = nil,
        revert: [Revert]? = nil,
        rewrite: [RewriteElement]? = nil,
        saccoderm: [Saccoderm]? = nil,
        santir: [SantirElement]? = nil,
        saprophilous: [Saprophilous]? = nil,
        saxten: [SaxtenElement]? = nil,
        scatty: [Scatty?]? = nil,
        scoffer: [Scoffer]? = nil,
        scrampum: [Scrampum]? = nil,
        semantic: Double? = nil,
        serpentinic: [Serpentinic]? = nil,
        shadowable: [Shadowable]? = nil,
        sistering: [SisteringElement]? = nil,
        staghunting: [Staghunting]? = nil,
        stagmometer: [Stagmometer]? = nil,
        stimulability: [Stimulability]? = nil,
        strangleable: [Strangleable]? = nil,
        strenuosity: [StrenuosityElement]? = nil,
        tabaxir: [Tabaxir]? = nil,
        talpiform: [Talpiform]? = nil,
        thwack: [Thwack]? = nil,
        to: [Double?]? = nil,
        tortricine: [Tortricine]? = nil,
        truantcy: [TruantcyElement]? = nil,
        turgesce: [String]? = nil,
        unbeginning: [Unbeginning]? = nil,
        underdunged: [Double]? = nil,
        undesirability: [Undesirability]? = nil,
        unerasing: [Unerasing]? = nil,
        unguentarium: [Unguentarium]? = nil,
        unimpeachably: [UnimpeachablyElement]? = nil,
        unmortgaged: [Unmortgaged]? = nil,
        unobstructed: [Unobstructed]? = nil,
        unreceptivity: [Unreceptivity]? = nil,
        unsatisfactoriness: [Unsatisfactoriness]? = nil,
        unsecurity: [Int]? = nil,
        unstressed: [UnstressedElement]? = nil,
        untasked: [Untasked]? = nil,
        unvarying: [Unvarying]? = nil,
        vehemently: [Vehemently]? = nil,
        warriorship: [String: Bool]? = nil,
        whitepot: [Whitepot]? = nil,
        wrothy: [WrothyElement]? = nil
    ) -> TopLevel {
        return TopLevel(
            protrusive: protrusive ?? self.protrusive,
            pulpitism: pulpitism ?? self.pulpitism,
            pyodermia: pyodermia ?? self.pyodermia,
            quebrachine: quebrachine ?? self.quebrachine,
            querier: querier ?? self.querier,
            rebarbative: rebarbative ?? self.rebarbative,
            reimagine: reimagine ?? self.reimagine,
            ressaut: ressaut ?? self.ressaut,
            retrocervical: retrocervical ?? self.retrocervical,
            revert: revert ?? self.revert,
            rewrite: rewrite ?? self.rewrite,
            saccoderm: saccoderm ?? self.saccoderm,
            santir: santir ?? self.santir,
            saprophilous: saprophilous ?? self.saprophilous,
            saxten: saxten ?? self.saxten,
            scatty: scatty ?? self.scatty,
            scoffer: scoffer ?? self.scoffer,
            scrampum: scrampum ?? self.scrampum,
            semantic: semantic ?? self.semantic,
            serpentinic: serpentinic ?? self.serpentinic,
            shadowable: shadowable ?? self.shadowable,
            sistering: sistering ?? self.sistering,
            staghunting: staghunting ?? self.staghunting,
            stagmometer: stagmometer ?? self.stagmometer,
            stimulability: stimulability ?? self.stimulability,
            strangleable: strangleable ?? self.strangleable,
            strenuosity: strenuosity ?? self.strenuosity,
            tabaxir: tabaxir ?? self.tabaxir,
            talpiform: talpiform ?? self.talpiform,
            thwack: thwack ?? self.thwack,
            to: to ?? self.to,
            tortricine: tortricine ?? self.tortricine,
            truantcy: truantcy ?? self.truantcy,
            turgesce: turgesce ?? self.turgesce,
            unbeginning: unbeginning ?? self.unbeginning,
            underdunged: underdunged ?? self.underdunged,
            undesirability: undesirability ?? self.undesirability,
            unerasing: unerasing ?? self.unerasing,
            unguentarium: unguentarium ?? self.unguentarium,
            unimpeachably: unimpeachably ?? self.unimpeachably,
            unmortgaged: unmortgaged ?? self.unmortgaged,
            unobstructed: unobstructed ?? self.unobstructed,
            unreceptivity: unreceptivity ?? self.unreceptivity,
            unsatisfactoriness: unsatisfactoriness ?? self.unsatisfactoriness,
            unsecurity: unsecurity ?? self.unsecurity,
            unstressed: unstressed ?? self.unstressed,
            untasked: untasked ?? self.untasked,
            unvarying: unvarying ?? self.unvarying,
            vehemently: vehemently ?? self.vehemently,
            warriorship: warriorship ?? self.warriorship,
            whitepot: whitepot ?? self.whitepot,
            wrothy: wrothy ?? self.wrothy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Protrusive: Codable {
    case double(Double)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Protrusive.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Protrusive"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum PulpitismElement: Codable {
    case double(Double)
    case integerArray([Int])
    case pulpitismClass(PulpitismClass)

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
        if let x = try? container.decode(PulpitismClass.self) {
            self = .pulpitismClass(x)
            return
        }
        throw DecodingError.typeMismatch(PulpitismElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PulpitismElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .pulpitismClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PulpitismClass
struct PulpitismClass: Codable {
    let abnet: JSONNull?
    let buckhorn: JSONNull?
    let calciform: JSONNull?
    let chelophore: JSONNull?
    let cogitation: JSONNull?
    let decreeable: JSONNull?
    let despicable: JSONNull?
    let isodiazo: JSONNull?
    let jadedly: JSONNull?
    let leptochlorite: JSONNull?
    let nursling: JSONNull?
    let palamedean: JSONNull?
    let photoheliograph: JSONNull?
    let pipewood: JSONNull?
    let roberd: JSONNull?
    let statable: JSONNull?
    let superassume: JSONNull?
    let syllabe: JSONNull?
    let toughhead: JSONNull?
    let underburn: JSONNull?

    enum CodingKeys: String, CodingKey {
        case abnet = "abnet"
        case buckhorn = "buckhorn"
        case calciform = "calciform"
        case chelophore = "chelophore"
        case cogitation = "cogitation"
        case decreeable = "decreeable"
        case despicable = "despicable"
        case isodiazo = "isodiazo"
        case jadedly = "jadedly"
        case leptochlorite = "leptochlorite"
        case nursling = "nursling"
        case palamedean = "palamedean"
        case photoheliograph = "photoheliograph"
        case pipewood = "pipewood"
        case roberd = "roberd"
        case statable = "statable"
        case superassume = "superassume"
        case syllabe = "syllabe"
        case toughhead = "toughhead"
        case underburn = "underburn"
    }
}

// MARK: PulpitismClass convenience initializers and mutators

extension PulpitismClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PulpitismClass.self, from: data)
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
        abnet: JSONNull?? = nil,
        buckhorn: JSONNull?? = nil,
        calciform: JSONNull?? = nil,
        chelophore: JSONNull?? = nil,
        cogitation: JSONNull?? = nil,
        decreeable: JSONNull?? = nil,
        despicable: JSONNull?? = nil,
        isodiazo: JSONNull?? = nil,
        jadedly: JSONNull?? = nil,
        leptochlorite: JSONNull?? = nil,
        nursling: JSONNull?? = nil,
        palamedean: JSONNull?? = nil,
        photoheliograph: JSONNull?? = nil,
        pipewood: JSONNull?? = nil,
        roberd: JSONNull?? = nil,
        statable: JSONNull?? = nil,
        superassume: JSONNull?? = nil,
        syllabe: JSONNull?? = nil,
        toughhead: JSONNull?? = nil,
        underburn: JSONNull?? = nil
    ) -> PulpitismClass {
        return PulpitismClass(
            abnet: abnet ?? self.abnet,
            buckhorn: buckhorn ?? self.buckhorn,
            calciform: calciform ?? self.calciform,
            chelophore: chelophore ?? self.chelophore,
            cogitation: cogitation ?? self.cogitation,
            decreeable: decreeable ?? self.decreeable,
            despicable: despicable ?? self.despicable,
            isodiazo: isodiazo ?? self.isodiazo,
            jadedly: jadedly ?? self.jadedly,
            leptochlorite: leptochlorite ?? self.leptochlorite,
            nursling: nursling ?? self.nursling,
            palamedean: palamedean ?? self.palamedean,
            photoheliograph: photoheliograph ?? self.photoheliograph,
            pipewood: pipewood ?? self.pipewood,
            roberd: roberd ?? self.roberd,
            statable: statable ?? self.statable,
            superassume: superassume ?? self.superassume,
            syllabe: syllabe ?? self.syllabe,
            toughhead: toughhead ?? self.toughhead,
            underburn: underburn ?? self.underburn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum PyodermiaElement: Codable {
    case integer(Int)
    case pyodermiaClass(PyodermiaClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(PyodermiaClass.self) {
            self = .pyodermiaClass(x)
            return
        }
        throw DecodingError.typeMismatch(PyodermiaElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PyodermiaElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .pyodermiaClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PyodermiaClass
struct PyodermiaClass: Codable {
    let aphoristically: JSONNull?
    let apophyllous: JSONNull?
    let cognize: JSONNull?
    let dermonosology: JSONNull?
    let gyppo: JSONNull?
    let ither: JSONNull?
    let juglandaceous: JSONNull?
    let litho: JSONNull?
    let macropterous: JSONNull?
    let photographer: JSONNull?
    let romancing: JSONNull?
    let rumness: JSONNull?
    let somniloquist: JSONNull?
    let stressfully: JSONNull?
    let tactically: JSONNull?
    let tracheophony: JSONNull?
    let unappositely: JSONNull?
    let unclothedly: JSONNull?
    let unimplied: JSONNull?
    let unsyncopated: JSONNull?

    enum CodingKeys: String, CodingKey {
        case aphoristically = "aphoristically"
        case apophyllous = "apophyllous"
        case cognize = "cognize"
        case dermonosology = "dermonosology"
        case gyppo = "Gyppo"
        case ither = "ither"
        case juglandaceous = "juglandaceous"
        case litho = "litho"
        case macropterous = "macropterous"
        case photographer = "photographer"
        case romancing = "romancing"
        case rumness = "rumness"
        case somniloquist = "somniloquist"
        case stressfully = "stressfully"
        case tactically = "tactically"
        case tracheophony = "tracheophony"
        case unappositely = "unappositely"
        case unclothedly = "unclothedly"
        case unimplied = "unimplied"
        case unsyncopated = "unsyncopated"
    }
}

// MARK: PyodermiaClass convenience initializers and mutators

extension PyodermiaClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PyodermiaClass.self, from: data)
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
        aphoristically: JSONNull?? = nil,
        apophyllous: JSONNull?? = nil,
        cognize: JSONNull?? = nil,
        dermonosology: JSONNull?? = nil,
        gyppo: JSONNull?? = nil,
        ither: JSONNull?? = nil,
        juglandaceous: JSONNull?? = nil,
        litho: JSONNull?? = nil,
        macropterous: JSONNull?? = nil,
        photographer: JSONNull?? = nil,
        romancing: JSONNull?? = nil,
        rumness: JSONNull?? = nil,
        somniloquist: JSONNull?? = nil,
        stressfully: JSONNull?? = nil,
        tactically: JSONNull?? = nil,
        tracheophony: JSONNull?? = nil,
        unappositely: JSONNull?? = nil,
        unclothedly: JSONNull?? = nil,
        unimplied: JSONNull?? = nil,
        unsyncopated: JSONNull?? = nil
    ) -> PyodermiaClass {
        return PyodermiaClass(
            aphoristically: aphoristically ?? self.aphoristically,
            apophyllous: apophyllous ?? self.apophyllous,
            cognize: cognize ?? self.cognize,
            dermonosology: dermonosology ?? self.dermonosology,
            gyppo: gyppo ?? self.gyppo,
            ither: ither ?? self.ither,
            juglandaceous: juglandaceous ?? self.juglandaceous,
            litho: litho ?? self.litho,
            macropterous: macropterous ?? self.macropterous,
            photographer: photographer ?? self.photographer,
            romancing: romancing ?? self.romancing,
            rumness: rumness ?? self.rumness,
            somniloquist: somniloquist ?? self.somniloquist,
            stressfully: stressfully ?? self.stressfully,
            tactically: tactically ?? self.tactically,
            tracheophony: tracheophony ?? self.tracheophony,
            unappositely: unappositely ?? self.unappositely,
            unclothedly: unclothedly ?? self.unclothedly,
            unimplied: unimplied ?? self.unimplied,
            unsyncopated: unsyncopated ?? self.unsyncopated
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum QuebrachineElement: Codable {
    case bool(Bool)
    case quebrachineClass(QuebrachineClass)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(QuebrachineElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for QuebrachineElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .quebrachineClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - QuebrachineClass
struct QuebrachineClass: Codable {
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
}

// MARK: QuebrachineClass convenience initializers and mutators

extension QuebrachineClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(QuebrachineClass.self, from: data)
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
    ) -> QuebrachineClass {
        return QuebrachineClass(
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

enum Querier: Codable {
    case bool(Bool)
    case integerMap([String: Int])

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
        throw DecodingError.typeMismatch(Querier.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Querier"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Rebarbative: Codable {
    case bool(Bool)
    case double(Double)
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
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Rebarbative.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Rebarbative"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Reimagine
struct Reimagine: Codable {
    let adducible: JSONNull?
    let anabolin: JSONNull?
    let brainy: JSONNull?
    let catharticalness: Double?
    let chirotherium: Int?
    let chrysamine: JSONNull?
    let disdiapason: String?
    let fluxweed: JSONNull?
    let glaucine: JSONNull?
    let grobianism: JSONNull?
    let hermo: JSONNull?
    let hieroglyphist: JSONNull?
    let homocerc: Bool?
    let icteroid: JSONNull?
    let immortal: JSONNull?
    let impetulant: JSONNull?
    let irrigate: JSONNull?
    let myxedema: JSONNull?
    let nonbookish: JSONNull?
    let onyx: JSONNull?
    let repasser: JSONNull?
    let septomarginal: JSONNull?
    let subdie: JSONNull?
    let tibiometatarsal: JSONNull?
    let waltzlike: JSONNull?

    enum CodingKeys: String, CodingKey {
        case adducible = "adducible"
        case anabolin = "anabolin"
        case brainy = "brainy"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case chrysamine = "chrysamine"
        case disdiapason = "disdiapason"
        case fluxweed = "fluxweed"
        case glaucine = "glaucine"
        case grobianism = "grobianism"
        case hermo = "Hermo"
        case hieroglyphist = "hieroglyphist"
        case homocerc = "homocerc"
        case icteroid = "icteroid"
        case immortal = "immortal"
        case impetulant = "impetulant"
        case irrigate = "irrigate"
        case myxedema = "myxedema"
        case nonbookish = "nonbookish"
        case onyx = "onyx"
        case repasser = "repasser"
        case septomarginal = "septomarginal"
        case subdie = "subdie"
        case tibiometatarsal = "tibiometatarsal"
        case waltzlike = "waltzlike"
    }
}

// MARK: Reimagine convenience initializers and mutators

extension Reimagine {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Reimagine.self, from: data)
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
        adducible: JSONNull?? = nil,
        anabolin: JSONNull?? = nil,
        brainy: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        chrysamine: JSONNull?? = nil,
        disdiapason: String?? = nil,
        fluxweed: JSONNull?? = nil,
        glaucine: JSONNull?? = nil,
        grobianism: JSONNull?? = nil,
        hermo: JSONNull?? = nil,
        hieroglyphist: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        icteroid: JSONNull?? = nil,
        immortal: JSONNull?? = nil,
        impetulant: JSONNull?? = nil,
        irrigate: JSONNull?? = nil,
        myxedema: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        onyx: JSONNull?? = nil,
        repasser: JSONNull?? = nil,
        septomarginal: JSONNull?? = nil,
        subdie: JSONNull?? = nil,
        tibiometatarsal: JSONNull?? = nil,
        waltzlike: JSONNull?? = nil
    ) -> Reimagine {
        return Reimagine(
            adducible: adducible ?? self.adducible,
            anabolin: anabolin ?? self.anabolin,
            brainy: brainy ?? self.brainy,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            chrysamine: chrysamine ?? self.chrysamine,
            disdiapason: disdiapason ?? self.disdiapason,
            fluxweed: fluxweed ?? self.fluxweed,
            glaucine: glaucine ?? self.glaucine,
            grobianism: grobianism ?? self.grobianism,
            hermo: hermo ?? self.hermo,
            hieroglyphist: hieroglyphist ?? self.hieroglyphist,
            homocerc: homocerc ?? self.homocerc,
            icteroid: icteroid ?? self.icteroid,
            immortal: immortal ?? self.immortal,
            impetulant: impetulant ?? self.impetulant,
            irrigate: irrigate ?? self.irrigate,
            myxedema: myxedema ?? self.myxedema,
            nonbookish: nonbookish ?? self.nonbookish,
            onyx: onyx ?? self.onyx,
            repasser: repasser ?? self.repasser,
            septomarginal: septomarginal ?? self.septomarginal,
            subdie: subdie ?? self.subdie,
            tibiometatarsal: tibiometatarsal ?? self.tibiometatarsal,
            waltzlike: waltzlike ?? self.waltzlike
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Ressaut
struct Ressaut: Codable {
    let apperceptive: String
    let cuttoo: String
    let douser: String
    let drinkproof: String
    let forementioned: String
    let freesia: String
    let genevieve: String
    let hyperdiabolical: String
    let hypocone: String
    let irreverentially: String
    let jumart: String
    let mimosaceae: String
    let mollicrush: String
    let nedder: String
    let retinasphalt: String
    let sough: String
    let steading: String
    let theopaschitism: String
    let undurableness: String
    let unmingleable: String

    enum CodingKeys: String, CodingKey {
        case apperceptive = "apperceptive"
        case cuttoo = "cuttoo"
        case douser = "douser"
        case drinkproof = "drinkproof"
        case forementioned = "forementioned"
        case freesia = "Freesia"
        case genevieve = "Genevieve"
        case hyperdiabolical = "hyperdiabolical"
        case hypocone = "hypocone"
        case irreverentially = "irreverentially"
        case jumart = "jumart"
        case mimosaceae = "Mimosaceae"
        case mollicrush = "mollicrush"
        case nedder = "nedder"
        case retinasphalt = "retinasphalt"
        case sough = "sough"
        case steading = "steading"
        case theopaschitism = "Theopaschitism"
        case undurableness = "undurableness"
        case unmingleable = "unmingleable"
    }
}

// MARK: Ressaut convenience initializers and mutators

extension Ressaut {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ressaut.self, from: data)
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
        apperceptive: String? = nil,
        cuttoo: String? = nil,
        douser: String? = nil,
        drinkproof: String? = nil,
        forementioned: String? = nil,
        freesia: String? = nil,
        genevieve: String? = nil,
        hyperdiabolical: String? = nil,
        hypocone: String? = nil,
        irreverentially: String? = nil,
        jumart: String? = nil,
        mimosaceae: String? = nil,
        mollicrush: String? = nil,
        nedder: String? = nil,
        retinasphalt: String? = nil,
        sough: String? = nil,
        steading: String? = nil,
        theopaschitism: String? = nil,
        undurableness: String? = nil,
        unmingleable: String? = nil
    ) -> Ressaut {
        return Ressaut(
            apperceptive: apperceptive ?? self.apperceptive,
            cuttoo: cuttoo ?? self.cuttoo,
            douser: douser ?? self.douser,
            drinkproof: drinkproof ?? self.drinkproof,
            forementioned: forementioned ?? self.forementioned,
            freesia: freesia ?? self.freesia,
            genevieve: genevieve ?? self.genevieve,
            hyperdiabolical: hyperdiabolical ?? self.hyperdiabolical,
            hypocone: hypocone ?? self.hypocone,
            irreverentially: irreverentially ?? self.irreverentially,
            jumart: jumart ?? self.jumart,
            mimosaceae: mimosaceae ?? self.mimosaceae,
            mollicrush: mollicrush ?? self.mollicrush,
            nedder: nedder ?? self.nedder,
            retinasphalt: retinasphalt ?? self.retinasphalt,
            sough: sough ?? self.sough,
            steading: steading ?? self.steading,
            theopaschitism: theopaschitism ?? self.theopaschitism,
            undurableness: undurableness ?? self.undurableness,
            unmingleable: unmingleable ?? self.unmingleable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Retrocervical: Codable {
    case integer(Int)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        throw DecodingError.typeMismatch(Retrocervical.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Retrocervical"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum Revert: Codable {
    case bool(Bool)
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
        throw DecodingError.typeMismatch(Revert.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Revert"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum RewriteElement: Codable {
    case double(Double)
    case nullArray([JSONNull?])
    case rewriteClass(RewriteClass)

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
        if let x = try? container.decode(RewriteClass.self) {
            self = .rewriteClass(x)
            return
        }
        throw DecodingError.typeMismatch(RewriteElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RewriteElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .rewriteClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RewriteClass
struct RewriteClass: Codable {
    let accountancy: JSONNull?
    let cacotrophic: JSONNull?
    let contest: JSONNull?
    let couthily: JSONNull?
    let falculate: JSONNull?
    let foreseize: JSONNull?
    let hyades: JSONNull?
    let lemnad: JSONNull?
    let monotheistically: JSONNull?
    let nonflying: JSONNull?
    let ptenoglossa: JSONNull?
    let repatch: JSONNull?
    let rodman: JSONNull?
    let strung: JSONNull?
    let titmal: JSONNull?
    let twalpennyworth: JSONNull?
    let unblamable: JSONNull?
    let vertical: JSONNull?
    let whiggification: JSONNull?
    let yardman: JSONNull?

    enum CodingKeys: String, CodingKey {
        case accountancy = "accountancy"
        case cacotrophic = "cacotrophic"
        case contest = "contest"
        case couthily = "couthily"
        case falculate = "falculate"
        case foreseize = "foreseize"
        case hyades = "Hyades"
        case lemnad = "lemnad"
        case monotheistically = "monotheistically"
        case nonflying = "nonflying"
        case ptenoglossa = "Ptenoglossa"
        case repatch = "repatch"
        case rodman = "rodman"
        case strung = "strung"
        case titmal = "titmal"
        case twalpennyworth = "twalpennyworth"
        case unblamable = "unblamable"
        case vertical = "vertical"
        case whiggification = "Whiggification"
        case yardman = "yardman"
    }
}

// MARK: RewriteClass convenience initializers and mutators

extension RewriteClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RewriteClass.self, from: data)
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
        accountancy: JSONNull?? = nil,
        cacotrophic: JSONNull?? = nil,
        contest: JSONNull?? = nil,
        couthily: JSONNull?? = nil,
        falculate: JSONNull?? = nil,
        foreseize: JSONNull?? = nil,
        hyades: JSONNull?? = nil,
        lemnad: JSONNull?? = nil,
        monotheistically: JSONNull?? = nil,
        nonflying: JSONNull?? = nil,
        ptenoglossa: JSONNull?? = nil,
        repatch: JSONNull?? = nil,
        rodman: JSONNull?? = nil,
        strung: JSONNull?? = nil,
        titmal: JSONNull?? = nil,
        twalpennyworth: JSONNull?? = nil,
        unblamable: JSONNull?? = nil,
        vertical: JSONNull?? = nil,
        whiggification: JSONNull?? = nil,
        yardman: JSONNull?? = nil
    ) -> RewriteClass {
        return RewriteClass(
            accountancy: accountancy ?? self.accountancy,
            cacotrophic: cacotrophic ?? self.cacotrophic,
            contest: contest ?? self.contest,
            couthily: couthily ?? self.couthily,
            falculate: falculate ?? self.falculate,
            foreseize: foreseize ?? self.foreseize,
            hyades: hyades ?? self.hyades,
            lemnad: lemnad ?? self.lemnad,
            monotheistically: monotheistically ?? self.monotheistically,
            nonflying: nonflying ?? self.nonflying,
            ptenoglossa: ptenoglossa ?? self.ptenoglossa,
            repatch: repatch ?? self.repatch,
            rodman: rodman ?? self.rodman,
            strung: strung ?? self.strung,
            titmal: titmal ?? self.titmal,
            twalpennyworth: twalpennyworth ?? self.twalpennyworth,
            unblamable: unblamable ?? self.unblamable,
            vertical: vertical ?? self.vertical,
            whiggification: whiggification ?? self.whiggification,
            yardman: yardman ?? self.yardman
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Saccoderm: Codable {
    case integerArray([Int])
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Saccoderm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Saccoderm"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum SantirElement: Codable {
    case double(Double)
    case santirClass(SantirClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SantirClass.self) {
            self = .santirClass(x)
            return
        }
        throw DecodingError.typeMismatch(SantirElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SantirElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .santirClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SantirClass
struct SantirClass: Codable {
    let admiredly: JSONNull?
    let demicaponier: JSONNull?
    let epitympanic: JSONNull?
    let investitor: JSONNull?
    let lupiform: JSONNull?
    let monoflagellate: JSONNull?
    let paleoethnic: JSONNull?
    let prediscountable: JSONNull?
    let rhetoricals: JSONNull?
    let roomth: JSONNull?
    let saccharose: JSONNull?
    let septonasal: JSONNull?
    let serpenticide: JSONNull?
    let setarious: JSONNull?
    let spaework: JSONNull?
    let stylite: JSONNull?
    let suessiones: JSONNull?
    let timelily: JSONNull?
    let unprofaned: JSONNull?
    let vorticular: JSONNull?

    enum CodingKeys: String, CodingKey {
        case admiredly = "admiredly"
        case demicaponier = "demicaponier"
        case epitympanic = "epitympanic"
        case investitor = "investitor"
        case lupiform = "lupiform"
        case monoflagellate = "monoflagellate"
        case paleoethnic = "paleoethnic"
        case prediscountable = "prediscountable"
        case rhetoricals = "rhetoricals"
        case roomth = "roomth"
        case saccharose = "saccharose"
        case septonasal = "septonasal"
        case serpenticide = "serpenticide"
        case setarious = "setarious"
        case spaework = "spaework"
        case stylite = "stylite"
        case suessiones = "Suessiones"
        case timelily = "timelily"
        case unprofaned = "unprofaned"
        case vorticular = "vorticular"
    }
}

// MARK: SantirClass convenience initializers and mutators

extension SantirClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SantirClass.self, from: data)
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
        admiredly: JSONNull?? = nil,
        demicaponier: JSONNull?? = nil,
        epitympanic: JSONNull?? = nil,
        investitor: JSONNull?? = nil,
        lupiform: JSONNull?? = nil,
        monoflagellate: JSONNull?? = nil,
        paleoethnic: JSONNull?? = nil,
        prediscountable: JSONNull?? = nil,
        rhetoricals: JSONNull?? = nil,
        roomth: JSONNull?? = nil,
        saccharose: JSONNull?? = nil,
        septonasal: JSONNull?? = nil,
        serpenticide: JSONNull?? = nil,
        setarious: JSONNull?? = nil,
        spaework: JSONNull?? = nil,
        stylite: JSONNull?? = nil,
        suessiones: JSONNull?? = nil,
        timelily: JSONNull?? = nil,
        unprofaned: JSONNull?? = nil,
        vorticular: JSONNull?? = nil
    ) -> SantirClass {
        return SantirClass(
            admiredly: admiredly ?? self.admiredly,
            demicaponier: demicaponier ?? self.demicaponier,
            epitympanic: epitympanic ?? self.epitympanic,
            investitor: investitor ?? self.investitor,
            lupiform: lupiform ?? self.lupiform,
            monoflagellate: monoflagellate ?? self.monoflagellate,
            paleoethnic: paleoethnic ?? self.paleoethnic,
            prediscountable: prediscountable ?? self.prediscountable,
            rhetoricals: rhetoricals ?? self.rhetoricals,
            roomth: roomth ?? self.roomth,
            saccharose: saccharose ?? self.saccharose,
            septonasal: septonasal ?? self.septonasal,
            serpenticide: serpenticide ?? self.serpenticide,
            setarious: setarious ?? self.setarious,
            spaework: spaework ?? self.spaework,
            stylite: stylite ?? self.stylite,
            suessiones: suessiones ?? self.suessiones,
            timelily: timelily ?? self.timelily,
            unprofaned: unprofaned ?? self.unprofaned,
            vorticular: vorticular ?? self.vorticular
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Saprophilous: Codable {
    case integerMap([String: Int])
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Saprophilous.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Saprophilous"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum SaxtenElement: Codable {
    case saxtenClass(SaxtenClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(SaxtenClass.self) {
            self = .saxtenClass(x)
            return
        }
        throw DecodingError.typeMismatch(SaxtenElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SaxtenElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .saxtenClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SaxtenClass
struct SaxtenClass: Codable {
    let algarrobilla: JSONNull?
    let bowgrace: JSONNull?
    let catharticalness: Double?
    let centaurid: JSONNull?
    let chirotherium: Int?
    let disdiapason: String?
    let flix: JSONNull?
    let germanely: JSONNull?
    let homocerc: Bool?
    let inhume: JSONNull?
    let lepidote: JSONNull?
    let megalochirous: JSONNull?
    let ninepenny: JSONNull?
    let nonbookish: JSONNull?
    let nondeist: JSONNull?
    let nymphaeaceous: JSONNull?
    let parietofrontal: JSONNull?
    let sancyite: JSONNull?
    let subjectivist: JSONNull?
    let tibiad: JSONNull?
    let transonic: JSONNull?
    let tripetalous: JSONNull?
    let trunchman: JSONNull?
    let urger: JSONNull?
    let withdrawnness: JSONNull?

    enum CodingKeys: String, CodingKey {
        case algarrobilla = "algarrobilla"
        case bowgrace = "bowgrace"
        case catharticalness = "catharticalness"
        case centaurid = "Centaurid"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case flix = "flix"
        case germanely = "germanely"
        case homocerc = "homocerc"
        case inhume = "inhume"
        case lepidote = "lepidote"
        case megalochirous = "megalochirous"
        case ninepenny = "ninepenny"
        case nonbookish = "nonbookish"
        case nondeist = "nondeist"
        case nymphaeaceous = "nymphaeaceous"
        case parietofrontal = "parietofrontal"
        case sancyite = "sancyite"
        case subjectivist = "subjectivist"
        case tibiad = "tibiad"
        case transonic = "transonic"
        case tripetalous = "tripetalous"
        case trunchman = "trunchman"
        case urger = "urger"
        case withdrawnness = "withdrawnness"
    }
}

// MARK: SaxtenClass convenience initializers and mutators

extension SaxtenClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SaxtenClass.self, from: data)
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
        algarrobilla: JSONNull?? = nil,
        bowgrace: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        centaurid: JSONNull?? = nil,
        chirotherium: Int?? = nil,
        disdiapason: String?? = nil,
        flix: JSONNull?? = nil,
        germanely: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        inhume: JSONNull?? = nil,
        lepidote: JSONNull?? = nil,
        megalochirous: JSONNull?? = nil,
        ninepenny: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        nondeist: JSONNull?? = nil,
        nymphaeaceous: JSONNull?? = nil,
        parietofrontal: JSONNull?? = nil,
        sancyite: JSONNull?? = nil,
        subjectivist: JSONNull?? = nil,
        tibiad: JSONNull?? = nil,
        transonic: JSONNull?? = nil,
        tripetalous: JSONNull?? = nil,
        trunchman: JSONNull?? = nil,
        urger: JSONNull?? = nil,
        withdrawnness: JSONNull?? = nil
    ) -> SaxtenClass {
        return SaxtenClass(
            algarrobilla: algarrobilla ?? self.algarrobilla,
            bowgrace: bowgrace ?? self.bowgrace,
            catharticalness: catharticalness ?? self.catharticalness,
            centaurid: centaurid ?? self.centaurid,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            flix: flix ?? self.flix,
            germanely: germanely ?? self.germanely,
            homocerc: homocerc ?? self.homocerc,
            inhume: inhume ?? self.inhume,
            lepidote: lepidote ?? self.lepidote,
            megalochirous: megalochirous ?? self.megalochirous,
            ninepenny: ninepenny ?? self.ninepenny,
            nonbookish: nonbookish ?? self.nonbookish,
            nondeist: nondeist ?? self.nondeist,
            nymphaeaceous: nymphaeaceous ?? self.nymphaeaceous,
            parietofrontal: parietofrontal ?? self.parietofrontal,
            sancyite: sancyite ?? self.sancyite,
            subjectivist: subjectivist ?? self.subjectivist,
            tibiad: tibiad ?? self.tibiad,
            transonic: transonic ?? self.transonic,
            tripetalous: tripetalous ?? self.tripetalous,
            trunchman: trunchman ?? self.trunchman,
            urger: urger ?? self.urger,
            withdrawnness: withdrawnness ?? self.withdrawnness
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Scatty
struct Scatty: Codable {
    let aeriferous: JSONNull?
    let antical: JSONNull?
    let antighostism: JSONNull?
    let arcanum: JSONNull?
    let autotrophy: JSONNull?
    let baronial: JSONNull?
    let caffeine: JSONNull?
    let gorgoniacean: JSONNull?
    let heroical: JSONNull?
    let hydropical: JSONNull?
    let mechanology: JSONNull?
    let musicopoetic: JSONNull?
    let officiality: JSONNull?
    let oftentimes: JSONNull?
    let ophthalmotonometer: JSONNull?
    let reflectively: JSONNull?
    let springer: JSONNull?
    let tabasco: JSONNull?
    let teleianthous: JSONNull?
    let uncombated: JSONNull?

    enum CodingKeys: String, CodingKey {
        case aeriferous = "aeriferous"
        case antical = "antical"
        case antighostism = "antighostism"
        case arcanum = "arcanum"
        case autotrophy = "autotrophy"
        case baronial = "baronial"
        case caffeine = "caffeine"
        case gorgoniacean = "gorgoniacean"
        case heroical = "heroical"
        case hydropical = "hydropical"
        case mechanology = "mechanology"
        case musicopoetic = "musicopoetic"
        case officiality = "officiality"
        case oftentimes = "oftentimes"
        case ophthalmotonometer = "ophthalmotonometer"
        case reflectively = "reflectively"
        case springer = "springer"
        case tabasco = "Tabasco"
        case teleianthous = "teleianthous"
        case uncombated = "uncombated"
    }
}

// MARK: Scatty convenience initializers and mutators

extension Scatty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Scatty.self, from: data)
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
        aeriferous: JSONNull?? = nil,
        antical: JSONNull?? = nil,
        antighostism: JSONNull?? = nil,
        arcanum: JSONNull?? = nil,
        autotrophy: JSONNull?? = nil,
        baronial: JSONNull?? = nil,
        caffeine: JSONNull?? = nil,
        gorgoniacean: JSONNull?? = nil,
        heroical: JSONNull?? = nil,
        hydropical: JSONNull?? = nil,
        mechanology: JSONNull?? = nil,
        musicopoetic: JSONNull?? = nil,
        officiality: JSONNull?? = nil,
        oftentimes: JSONNull?? = nil,
        ophthalmotonometer: JSONNull?? = nil,
        reflectively: JSONNull?? = nil,
        springer: JSONNull?? = nil,
        tabasco: JSONNull?? = nil,
        teleianthous: JSONNull?? = nil,
        uncombated: JSONNull?? = nil
    ) -> Scatty {
        return Scatty(
            aeriferous: aeriferous ?? self.aeriferous,
            antical: antical ?? self.antical,
            antighostism: antighostism ?? self.antighostism,
            arcanum: arcanum ?? self.arcanum,
            autotrophy: autotrophy ?? self.autotrophy,
            baronial: baronial ?? self.baronial,
            caffeine: caffeine ?? self.caffeine,
            gorgoniacean: gorgoniacean ?? self.gorgoniacean,
            heroical: heroical ?? self.heroical,
            hydropical: hydropical ?? self.hydropical,
            mechanology: mechanology ?? self.mechanology,
            musicopoetic: musicopoetic ?? self.musicopoetic,
            officiality: officiality ?? self.officiality,
            oftentimes: oftentimes ?? self.oftentimes,
            ophthalmotonometer: ophthalmotonometer ?? self.ophthalmotonometer,
            reflectively: reflectively ?? self.reflectively,
            springer: springer ?? self.springer,
            tabasco: tabasco ?? self.tabasco,
            teleianthous: teleianthous ?? self.teleianthous,
            uncombated: uncombated ?? self.uncombated
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Scoffer: Codable {
    case integerMap([String: Int])
    case nullArray([JSONNull?])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Scoffer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Scoffer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Scrampum: Codable {
    case bool(Bool)
    case integerArray([Int])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Scrampum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Scrampum"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Serpentinic: Codable {
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
        throw DecodingError.typeMismatch(Serpentinic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Serpentinic"))
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

enum Shadowable: Codable {
    case bool(Bool)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        throw DecodingError.typeMismatch(Shadowable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Shadowable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum SisteringElement: Codable {
    case integer(Int)
    case nullArray([JSONNull?])
    case sisteringClass(SisteringClass)

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
        if let x = try? container.decode(SisteringClass.self) {
            self = .sisteringClass(x)
            return
        }
        throw DecodingError.typeMismatch(SisteringElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SisteringElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .sisteringClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SisteringClass
struct SisteringClass: Codable {
    let amphicarpic: JSONNull?
    let chianti: JSONNull?
    let frigorific: JSONNull?
    let haplomi: JSONNull?
    let hyperkinesis: JSONNull?
    let laudable: JSONNull?
    let madwoman: JSONNull?
    let maimedly: JSONNull?
    let micropterygidae: JSONNull?
    let microrhabdus: JSONNull?
    let nondense: JSONNull?
    let phlebemphraxis: JSONNull?
    let redsear: JSONNull?
    let schismatical: JSONNull?
    let tartryl: JSONNull?
    let unabhorred: JSONNull?
    let undeliberateness: JSONNull?
    let unmixable: JSONNull?
    let untruckling: JSONNull?
    let vineal: JSONNull?

    enum CodingKeys: String, CodingKey {
        case amphicarpic = "amphicarpic"
        case chianti = "Chianti"
        case frigorific = "frigorific"
        case haplomi = "Haplomi"
        case hyperkinesis = "hyperkinesis"
        case laudable = "laudable"
        case madwoman = "madwoman"
        case maimedly = "maimedly"
        case micropterygidae = "Micropterygidae"
        case microrhabdus = "microrhabdus"
        case nondense = "nondense"
        case phlebemphraxis = "phlebemphraxis"
        case redsear = "redsear"
        case schismatical = "schismatical"
        case tartryl = "tartryl"
        case unabhorred = "unabhorred"
        case undeliberateness = "undeliberateness"
        case unmixable = "unmixable"
        case untruckling = "untruckling"
        case vineal = "vineal"
    }
}

// MARK: SisteringClass convenience initializers and mutators

extension SisteringClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SisteringClass.self, from: data)
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
        amphicarpic: JSONNull?? = nil,
        chianti: JSONNull?? = nil,
        frigorific: JSONNull?? = nil,
        haplomi: JSONNull?? = nil,
        hyperkinesis: JSONNull?? = nil,
        laudable: JSONNull?? = nil,
        madwoman: JSONNull?? = nil,
        maimedly: JSONNull?? = nil,
        micropterygidae: JSONNull?? = nil,
        microrhabdus: JSONNull?? = nil,
        nondense: JSONNull?? = nil,
        phlebemphraxis: JSONNull?? = nil,
        redsear: JSONNull?? = nil,
        schismatical: JSONNull?? = nil,
        tartryl: JSONNull?? = nil,
        unabhorred: JSONNull?? = nil,
        undeliberateness: JSONNull?? = nil,
        unmixable: JSONNull?? = nil,
        untruckling: JSONNull?? = nil,
        vineal: JSONNull?? = nil
    ) -> SisteringClass {
        return SisteringClass(
            amphicarpic: amphicarpic ?? self.amphicarpic,
            chianti: chianti ?? self.chianti,
            frigorific: frigorific ?? self.frigorific,
            haplomi: haplomi ?? self.haplomi,
            hyperkinesis: hyperkinesis ?? self.hyperkinesis,
            laudable: laudable ?? self.laudable,
            madwoman: madwoman ?? self.madwoman,
            maimedly: maimedly ?? self.maimedly,
            micropterygidae: micropterygidae ?? self.micropterygidae,
            microrhabdus: microrhabdus ?? self.microrhabdus,
            nondense: nondense ?? self.nondense,
            phlebemphraxis: phlebemphraxis ?? self.phlebemphraxis,
            redsear: redsear ?? self.redsear,
            schismatical: schismatical ?? self.schismatical,
            tartryl: tartryl ?? self.tartryl,
            unabhorred: unabhorred ?? self.unabhorred,
            undeliberateness: undeliberateness ?? self.undeliberateness,
            unmixable: unmixable ?? self.unmixable,
            untruckling: untruckling ?? self.untruckling,
            vineal: vineal ?? self.vineal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Staghunting
struct Staghunting: Codable {
    let calorimetric: Int?
    let canid: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let disdiapason: String?
    let ditriglyphic: Int?
    let floriferousness: Int?
    let gamelike: Int?
    let grig: Int?
    let homocerc: Bool?
    let interloan: Int?
    let lithotomy: Int?
    let loric: Int?
    let membranocoriaceous: Int?
    let membranogenic: Int?
    let nonbookish: JSONNull?
    let overtrump: Int?
    let scotino: Int?
    let seasonable: Int?
    let sephen: Int?
    let stigmarioid: Int?
    let tired: Int?
    let trifid: Int?
    let undefeatedly: Int?
    let ungirlish: Int?

    enum CodingKeys: String, CodingKey {
        case calorimetric = "calorimetric"
        case canid = "canid"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case disdiapason = "disdiapason"
        case ditriglyphic = "ditriglyphic"
        case floriferousness = "floriferousness"
        case gamelike = "gamelike"
        case grig = "grig"
        case homocerc = "homocerc"
        case interloan = "interloan"
        case lithotomy = "lithotomy"
        case loric = "loric"
        case membranocoriaceous = "membranocoriaceous"
        case membranogenic = "membranogenic"
        case nonbookish = "nonbookish"
        case overtrump = "overtrump"
        case scotino = "scotino"
        case seasonable = "seasonable"
        case sephen = "sephen"
        case stigmarioid = "stigmarioid"
        case tired = "tired"
        case trifid = "trifid"
        case undefeatedly = "undefeatedly"
        case ungirlish = "ungirlish"
    }
}

// MARK: Staghunting convenience initializers and mutators

extension Staghunting {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Staghunting.self, from: data)
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
        calorimetric: Int?? = nil,
        canid: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        disdiapason: String?? = nil,
        ditriglyphic: Int?? = nil,
        floriferousness: Int?? = nil,
        gamelike: Int?? = nil,
        grig: Int?? = nil,
        homocerc: Bool?? = nil,
        interloan: Int?? = nil,
        lithotomy: Int?? = nil,
        loric: Int?? = nil,
        membranocoriaceous: Int?? = nil,
        membranogenic: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        overtrump: Int?? = nil,
        scotino: Int?? = nil,
        seasonable: Int?? = nil,
        sephen: Int?? = nil,
        stigmarioid: Int?? = nil,
        tired: Int?? = nil,
        trifid: Int?? = nil,
        undefeatedly: Int?? = nil,
        ungirlish: Int?? = nil
    ) -> Staghunting {
        return Staghunting(
            calorimetric: calorimetric ?? self.calorimetric,
            canid: canid ?? self.canid,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            disdiapason: disdiapason ?? self.disdiapason,
            ditriglyphic: ditriglyphic ?? self.ditriglyphic,
            floriferousness: floriferousness ?? self.floriferousness,
            gamelike: gamelike ?? self.gamelike,
            grig: grig ?? self.grig,
            homocerc: homocerc ?? self.homocerc,
            interloan: interloan ?? self.interloan,
            lithotomy: lithotomy ?? self.lithotomy,
            loric: loric ?? self.loric,
            membranocoriaceous: membranocoriaceous ?? self.membranocoriaceous,
            membranogenic: membranogenic ?? self.membranogenic,
            nonbookish: nonbookish ?? self.nonbookish,
            overtrump: overtrump ?? self.overtrump,
            scotino: scotino ?? self.scotino,
            seasonable: seasonable ?? self.seasonable,
            sephen: sephen ?? self.sephen,
            stigmarioid: stigmarioid ?? self.stigmarioid,
            tired: tired ?? self.tired,
            trifid: trifid ?? self.trifid,
            undefeatedly: undefeatedly ?? self.undefeatedly,
            ungirlish: ungirlish ?? self.ungirlish
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Stagmometer: Codable {
    case string(String)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Stagmometer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Stagmometer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum Stimulability: Codable {
    case bool(Bool)
    case integer(Int)
    case integerMap([String: Int])

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
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Stimulability.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Stimulability"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Strangleable: Codable {
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
        throw DecodingError.typeMismatch(Strangleable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Strangleable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum StrenuosityElement: Codable {
    case nullArray([JSONNull?])
    case strenuosityClass(StrenuosityClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(StrenuosityClass.self) {
            self = .strenuosityClass(x)
            return
        }
        throw DecodingError.typeMismatch(StrenuosityElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StrenuosityElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .strenuosityClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StrenuosityClass
struct StrenuosityClass: Codable {
    let bliss: Int?
    let buccate: Int?
    let bulletproof: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let crumblingness: Int?
    let disdiapason: String?
    let engagedly: Int?
    let fightable: Int?
    let hoariness: Int?
    let homocerc: Bool?
    let hypopodium: Int?
    let luxurist: Int?
    let mechanician: Int?
    let nonbookish: JSONNull?
    let onopordon: Int?
    let podgily: Int?
    let reformableness: Int?
    let scatterbrains: Int?
    let seminuria: Int?
    let sodomite: Int?
    let tramp: Int?
    let undueness: Int?
    let worthily: Int?
    let yankeeist: Int?

    enum CodingKeys: String, CodingKey {
        case bliss = "bliss"
        case buccate = "buccate"
        case bulletproof = "bulletproof"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case crumblingness = "crumblingness"
        case disdiapason = "disdiapason"
        case engagedly = "engagedly"
        case fightable = "fightable"
        case hoariness = "hoariness"
        case homocerc = "homocerc"
        case hypopodium = "hypopodium"
        case luxurist = "luxurist"
        case mechanician = "mechanician"
        case nonbookish = "nonbookish"
        case onopordon = "Onopordon"
        case podgily = "podgily"
        case reformableness = "reformableness"
        case scatterbrains = "scatterbrains"
        case seminuria = "seminuria"
        case sodomite = "Sodomite"
        case tramp = "tramp"
        case undueness = "undueness"
        case worthily = "worthily"
        case yankeeist = "Yankeeist"
    }
}

// MARK: StrenuosityClass convenience initializers and mutators

extension StrenuosityClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StrenuosityClass.self, from: data)
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
        bliss: Int?? = nil,
        buccate: Int?? = nil,
        bulletproof: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        crumblingness: Int?? = nil,
        disdiapason: String?? = nil,
        engagedly: Int?? = nil,
        fightable: Int?? = nil,
        hoariness: Int?? = nil,
        homocerc: Bool?? = nil,
        hypopodium: Int?? = nil,
        luxurist: Int?? = nil,
        mechanician: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        onopordon: Int?? = nil,
        podgily: Int?? = nil,
        reformableness: Int?? = nil,
        scatterbrains: Int?? = nil,
        seminuria: Int?? = nil,
        sodomite: Int?? = nil,
        tramp: Int?? = nil,
        undueness: Int?? = nil,
        worthily: Int?? = nil,
        yankeeist: Int?? = nil
    ) -> StrenuosityClass {
        return StrenuosityClass(
            bliss: bliss ?? self.bliss,
            buccate: buccate ?? self.buccate,
            bulletproof: bulletproof ?? self.bulletproof,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            crumblingness: crumblingness ?? self.crumblingness,
            disdiapason: disdiapason ?? self.disdiapason,
            engagedly: engagedly ?? self.engagedly,
            fightable: fightable ?? self.fightable,
            hoariness: hoariness ?? self.hoariness,
            homocerc: homocerc ?? self.homocerc,
            hypopodium: hypopodium ?? self.hypopodium,
            luxurist: luxurist ?? self.luxurist,
            mechanician: mechanician ?? self.mechanician,
            nonbookish: nonbookish ?? self.nonbookish,
            onopordon: onopordon ?? self.onopordon,
            podgily: podgily ?? self.podgily,
            reformableness: reformableness ?? self.reformableness,
            scatterbrains: scatterbrains ?? self.scatterbrains,
            seminuria: seminuria ?? self.seminuria,
            sodomite: sodomite ?? self.sodomite,
            tramp: tramp ?? self.tramp,
            undueness: undueness ?? self.undueness,
            worthily: worthily ?? self.worthily,
            yankeeist: yankeeist ?? self.yankeeist
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Tabaxir: Codable {
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
        throw DecodingError.typeMismatch(Tabaxir.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Tabaxir"))
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

enum Talpiform: Codable {
    case double(Double)
    case quebrachineClass(QuebrachineClass)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Talpiform.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Talpiform"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .quebrachineClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Thwack: Codable {
    case bool(Bool)
    case double(Double)
    case quebrachineClass(QuebrachineClass)

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
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        throw DecodingError.typeMismatch(Thwack.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Thwack"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .quebrachineClass(let x):
            try container.encode(x)
        }
    }
}

enum Tortricine: Codable {
    case quebrachineClass(QuebrachineClass)
    case unionArray([Int?])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int?].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        throw DecodingError.typeMismatch(Tortricine.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Tortricine"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .quebrachineClass(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum TruantcyElement: Codable {
    case bool(Bool)
    case truantcyClass(TruantcyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(TruantcyClass.self) {
            self = .truantcyClass(x)
            return
        }
        throw DecodingError.typeMismatch(TruantcyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TruantcyElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .truantcyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TruantcyClass
struct TruantcyClass: Codable {
    let alfiona: JSONNull?
    let ascaridiasis: JSONNull?
    let bungey: JSONNull?
    let catharticalness: Double?
    let ceroxyle: JSONNull?
    let chirotherium: Int?
    let chorology: JSONNull?
    let disdiapason: String?
    let enmarble: JSONNull?
    let epeira: JSONNull?
    let eurylaimi: JSONNull?
    let germination: JSONNull?
    let hallelujah: JSONNull?
    let homocerc: Bool?
    let lev: JSONNull?
    let mouthing: JSONNull?
    let nonbookish: JSONNull?
    let philliloo: JSONNull?
    let planetal: JSONNull?
    let poney: JSONNull?
    let punctualist: JSONNull?
    let returnlessly: JSONNull?
    let skelder: JSONNull?
    let windwaywardly: JSONNull?
    let yuman: JSONNull?

    enum CodingKeys: String, CodingKey {
        case alfiona = "alfiona"
        case ascaridiasis = "ascaridiasis"
        case bungey = "bungey"
        case catharticalness = "catharticalness"
        case ceroxyle = "ceroxyle"
        case chirotherium = "Chirotherium"
        case chorology = "chorology"
        case disdiapason = "disdiapason"
        case enmarble = "enmarble"
        case epeira = "Epeira"
        case eurylaimi = "Eurylaimi"
        case germination = "germination"
        case hallelujah = "hallelujah"
        case homocerc = "homocerc"
        case lev = "lev"
        case mouthing = "mouthing"
        case nonbookish = "nonbookish"
        case philliloo = "philliloo"
        case planetal = "planetal"
        case poney = "poney"
        case punctualist = "punctualist"
        case returnlessly = "returnlessly"
        case skelder = "skelder"
        case windwaywardly = "windwaywardly"
        case yuman = "Yuman"
    }
}

// MARK: TruantcyClass convenience initializers and mutators

extension TruantcyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TruantcyClass.self, from: data)
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
        alfiona: JSONNull?? = nil,
        ascaridiasis: JSONNull?? = nil,
        bungey: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        ceroxyle: JSONNull?? = nil,
        chirotherium: Int?? = nil,
        chorology: JSONNull?? = nil,
        disdiapason: String?? = nil,
        enmarble: JSONNull?? = nil,
        epeira: JSONNull?? = nil,
        eurylaimi: JSONNull?? = nil,
        germination: JSONNull?? = nil,
        hallelujah: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        lev: JSONNull?? = nil,
        mouthing: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        philliloo: JSONNull?? = nil,
        planetal: JSONNull?? = nil,
        poney: JSONNull?? = nil,
        punctualist: JSONNull?? = nil,
        returnlessly: JSONNull?? = nil,
        skelder: JSONNull?? = nil,
        windwaywardly: JSONNull?? = nil,
        yuman: JSONNull?? = nil
    ) -> TruantcyClass {
        return TruantcyClass(
            alfiona: alfiona ?? self.alfiona,
            ascaridiasis: ascaridiasis ?? self.ascaridiasis,
            bungey: bungey ?? self.bungey,
            catharticalness: catharticalness ?? self.catharticalness,
            ceroxyle: ceroxyle ?? self.ceroxyle,
            chirotherium: chirotherium ?? self.chirotherium,
            chorology: chorology ?? self.chorology,
            disdiapason: disdiapason ?? self.disdiapason,
            enmarble: enmarble ?? self.enmarble,
            epeira: epeira ?? self.epeira,
            eurylaimi: eurylaimi ?? self.eurylaimi,
            germination: germination ?? self.germination,
            hallelujah: hallelujah ?? self.hallelujah,
            homocerc: homocerc ?? self.homocerc,
            lev: lev ?? self.lev,
            mouthing: mouthing ?? self.mouthing,
            nonbookish: nonbookish ?? self.nonbookish,
            philliloo: philliloo ?? self.philliloo,
            planetal: planetal ?? self.planetal,
            poney: poney ?? self.poney,
            punctualist: punctualist ?? self.punctualist,
            returnlessly: returnlessly ?? self.returnlessly,
            skelder: skelder ?? self.skelder,
            windwaywardly: windwaywardly ?? self.windwaywardly,
            yuman: yuman ?? self.yuman
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Unbeginning: Codable {
    case integerMap([String: Int])
    case nullArray([JSONNull?])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Unbeginning.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unbeginning"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Undesirability: Codable {
    case integerArray([Int])
    case integerMap([String: Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
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
        throw DecodingError.typeMismatch(Undesirability.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Undesirability"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Unerasing: Codable {
    case integer(Int)
    case integerMap([String: Int])
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
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Unerasing.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unerasing"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum Unguentarium: Codable {
    case integer(Int)
    case nullArray([JSONNull?])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Unguentarium.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unguentarium"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum UnimpeachablyElement: Codable {
    case bool(Bool)
    case unimpeachablyClass(UnimpeachablyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(UnimpeachablyClass.self) {
            self = .unimpeachablyClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnimpeachablyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnimpeachablyElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .unimpeachablyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnimpeachablyClass
struct UnimpeachablyClass: Codable {
    let acerin: Int?
    let bobadil: Int?
    let catharticalness: Double?
    let chirotherium: Int?
    let chlorophylligenous: Int?
    let conversational: Int?
    let demiowl: Int?
    let disdiapason: String?
    let ectorhinal: Int?
    let gamblesomeness: Int?
    let homocerc: Bool?
    let irrorate: Int?
    let kindergartening: Int?
    let lateritic: Int?
    let mespil: Int?
    let misconfiguration: Int?
    let nonbookish: JSONNull?
    let planometry: Int?
    let quiina: Int?
    let robert: Int?
    let rot: Int?
    let subcinctorium: Int?
    let tussocker: Int?
    let ultraproud: Int?
    let unsuggestedness: Int?

    enum CodingKeys: String, CodingKey {
        case acerin = "acerin"
        case bobadil = "Bobadil"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case chlorophylligenous = "chlorophylligenous"
        case conversational = "conversational"
        case demiowl = "demiowl"
        case disdiapason = "disdiapason"
        case ectorhinal = "ectorhinal"
        case gamblesomeness = "gamblesomeness"
        case homocerc = "homocerc"
        case irrorate = "irrorate"
        case kindergartening = "kindergartening"
        case lateritic = "lateritic"
        case mespil = "mespil"
        case misconfiguration = "misconfiguration"
        case nonbookish = "nonbookish"
        case planometry = "planometry"
        case quiina = "Quiina"
        case robert = "Robert"
        case rot = "rot"
        case subcinctorium = "subcinctorium"
        case tussocker = "tussocker"
        case ultraproud = "ultraproud"
        case unsuggestedness = "unsuggestedness"
    }
}

// MARK: UnimpeachablyClass convenience initializers and mutators

extension UnimpeachablyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnimpeachablyClass.self, from: data)
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
        acerin: Int?? = nil,
        bobadil: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        chlorophylligenous: Int?? = nil,
        conversational: Int?? = nil,
        demiowl: Int?? = nil,
        disdiapason: String?? = nil,
        ectorhinal: Int?? = nil,
        gamblesomeness: Int?? = nil,
        homocerc: Bool?? = nil,
        irrorate: Int?? = nil,
        kindergartening: Int?? = nil,
        lateritic: Int?? = nil,
        mespil: Int?? = nil,
        misconfiguration: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        planometry: Int?? = nil,
        quiina: Int?? = nil,
        robert: Int?? = nil,
        rot: Int?? = nil,
        subcinctorium: Int?? = nil,
        tussocker: Int?? = nil,
        ultraproud: Int?? = nil,
        unsuggestedness: Int?? = nil
    ) -> UnimpeachablyClass {
        return UnimpeachablyClass(
            acerin: acerin ?? self.acerin,
            bobadil: bobadil ?? self.bobadil,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            chlorophylligenous: chlorophylligenous ?? self.chlorophylligenous,
            conversational: conversational ?? self.conversational,
            demiowl: demiowl ?? self.demiowl,
            disdiapason: disdiapason ?? self.disdiapason,
            ectorhinal: ectorhinal ?? self.ectorhinal,
            gamblesomeness: gamblesomeness ?? self.gamblesomeness,
            homocerc: homocerc ?? self.homocerc,
            irrorate: irrorate ?? self.irrorate,
            kindergartening: kindergartening ?? self.kindergartening,
            lateritic: lateritic ?? self.lateritic,
            mespil: mespil ?? self.mespil,
            misconfiguration: misconfiguration ?? self.misconfiguration,
            nonbookish: nonbookish ?? self.nonbookish,
            planometry: planometry ?? self.planometry,
            quiina: quiina ?? self.quiina,
            robert: robert ?? self.robert,
            rot: rot ?? self.rot,
            subcinctorium: subcinctorium ?? self.subcinctorium,
            tussocker: tussocker ?? self.tussocker,
            ultraproud: ultraproud ?? self.ultraproud,
            unsuggestedness: unsuggestedness ?? self.unsuggestedness
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Unmortgaged: Codable {
    case double(Double)
    case integerMap([String: Int])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Unmortgaged.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unmortgaged"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Unobstructed: Codable {
    case integer(Int)
    case quebrachineClass(QuebrachineClass)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Unobstructed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unobstructed"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .quebrachineClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Unreceptivity: Codable {
    case integer(Int)
    case nullArray([JSONNull?])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Unreceptivity.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unreceptivity"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Unsatisfactoriness: Codable {
    case bool(Bool)
    case integer(Int)
    case integerArray([Int])

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
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        throw DecodingError.typeMismatch(Unsatisfactoriness.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unsatisfactoriness"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

enum UnstressedElement: Codable {
    case bool(Bool)
    case string(String)
    case unstressedClass(UnstressedClass)

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
        if let x = try? container.decode(UnstressedClass.self) {
            self = .unstressedClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnstressedElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnstressedElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .unstressedClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnstressedClass
struct UnstressedClass: Codable {
    let alain: JSONNull?
    let amphirhina: JSONNull?
    let antimachinery: JSONNull?
    let coldish: JSONNull?
    let crantara: JSONNull?
    let distinguishing: JSONNull?
    let elytroposis: JSONNull?
    let gentianwort: JSONNull?
    let heliosis: JSONNull?
    let instrumental: JSONNull?
    let introinflection: JSONNull?
    let kala: JSONNull?
    let lincolnian: JSONNull?
    let metad: JSONNull?
    let sarcophilus: JSONNull?
    let swingingly: JSONNull?
    let unconformity: JSONNull?
    let undecreed: JSONNull?
    let venerable: JSONNull?
    let vowellessness: JSONNull?

    enum CodingKeys: String, CodingKey {
        case alain = "Alain"
        case amphirhina = "Amphirhina"
        case antimachinery = "antimachinery"
        case coldish = "coldish"
        case crantara = "crantara"
        case distinguishing = "distinguishing"
        case elytroposis = "elytroposis"
        case gentianwort = "gentianwort"
        case heliosis = "heliosis"
        case instrumental = "instrumental"
        case introinflection = "introinflection"
        case kala = "kala"
        case lincolnian = "Lincolnian"
        case metad = "metad"
        case sarcophilus = "Sarcophilus"
        case swingingly = "swingingly"
        case unconformity = "unconformity"
        case undecreed = "undecreed"
        case venerable = "venerable"
        case vowellessness = "vowellessness"
    }
}

// MARK: UnstressedClass convenience initializers and mutators

extension UnstressedClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnstressedClass.self, from: data)
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
        alain: JSONNull?? = nil,
        amphirhina: JSONNull?? = nil,
        antimachinery: JSONNull?? = nil,
        coldish: JSONNull?? = nil,
        crantara: JSONNull?? = nil,
        distinguishing: JSONNull?? = nil,
        elytroposis: JSONNull?? = nil,
        gentianwort: JSONNull?? = nil,
        heliosis: JSONNull?? = nil,
        instrumental: JSONNull?? = nil,
        introinflection: JSONNull?? = nil,
        kala: JSONNull?? = nil,
        lincolnian: JSONNull?? = nil,
        metad: JSONNull?? = nil,
        sarcophilus: JSONNull?? = nil,
        swingingly: JSONNull?? = nil,
        unconformity: JSONNull?? = nil,
        undecreed: JSONNull?? = nil,
        venerable: JSONNull?? = nil,
        vowellessness: JSONNull?? = nil
    ) -> UnstressedClass {
        return UnstressedClass(
            alain: alain ?? self.alain,
            amphirhina: amphirhina ?? self.amphirhina,
            antimachinery: antimachinery ?? self.antimachinery,
            coldish: coldish ?? self.coldish,
            crantara: crantara ?? self.crantara,
            distinguishing: distinguishing ?? self.distinguishing,
            elytroposis: elytroposis ?? self.elytroposis,
            gentianwort: gentianwort ?? self.gentianwort,
            heliosis: heliosis ?? self.heliosis,
            instrumental: instrumental ?? self.instrumental,
            introinflection: introinflection ?? self.introinflection,
            kala: kala ?? self.kala,
            lincolnian: lincolnian ?? self.lincolnian,
            metad: metad ?? self.metad,
            sarcophilus: sarcophilus ?? self.sarcophilus,
            swingingly: swingingly ?? self.swingingly,
            unconformity: unconformity ?? self.unconformity,
            undecreed: undecreed ?? self.undecreed,
            venerable: venerable ?? self.venerable,
            vowellessness: vowellessness ?? self.vowellessness
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Untasked: Codable {
    case double(Double)
    case integerMap([String: Int])
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
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Untasked.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Untasked"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum Unvarying: Codable {
    case bool(Bool)
    case double(Double)
    case integerMap([String: Int])

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
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Unvarying.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unvarying"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Vehemently: Codable {
    case bool(Bool)
    case nullArray([JSONNull?])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Vehemently.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Vehemently"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Whitepot: Codable {
    case double(Double)
    case quebrachineClass(QuebrachineClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(QuebrachineClass.self) {
            self = .quebrachineClass(x)
            return
        }
        throw DecodingError.typeMismatch(Whitepot.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Whitepot"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .quebrachineClass(let x):
            try container.encode(x)
        }
    }
}

enum WrothyElement: Codable {
    case nullArray([JSONNull?])
    case wrothyClass(WrothyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(WrothyClass.self) {
            self = .wrothyClass(x)
            return
        }
        throw DecodingError.typeMismatch(WrothyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WrothyElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .wrothyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - WrothyClass
struct WrothyClass: Codable {
    let aeschynanthus: JSONNull?
    let aquiferous: JSONNull?
    let cheapener: JSONNull?
    let enumeration: JSONNull?
    let ephesine: JSONNull?
    let escadrille: JSONNull?
    let estrous: JSONNull?
    let interestedly: JSONNull?
    let katakinetomer: JSONNull?
    let mortification: JSONNull?
    let morula: JSONNull?
    let orthosymmetrical: JSONNull?
    let overbark: JSONNull?
    let politist: JSONNull?
    let qualified: JSONNull?
    let sphenomalar: JSONNull?
    let throatful: JSONNull?
    let transhumance: JSONNull?
    let triandrian: JSONNull?
    let unbooked: JSONNull?

    enum CodingKeys: String, CodingKey {
        case aeschynanthus = "Aeschynanthus"
        case aquiferous = "aquiferous"
        case cheapener = "cheapener"
        case enumeration = "enumeration"
        case ephesine = "Ephesine"
        case escadrille = "escadrille"
        case estrous = "estrous"
        case interestedly = "interestedly"
        case katakinetomer = "katakinetomer"
        case mortification = "mortification"
        case morula = "morula"
        case orthosymmetrical = "orthosymmetrical"
        case overbark = "overbark"
        case politist = "politist"
        case qualified = "qualified"
        case sphenomalar = "sphenomalar"
        case throatful = "throatful"
        case transhumance = "transhumance"
        case triandrian = "triandrian"
        case unbooked = "unbooked"
    }
}

// MARK: WrothyClass convenience initializers and mutators

extension WrothyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WrothyClass.self, from: data)
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
        aeschynanthus: JSONNull?? = nil,
        aquiferous: JSONNull?? = nil,
        cheapener: JSONNull?? = nil,
        enumeration: JSONNull?? = nil,
        ephesine: JSONNull?? = nil,
        escadrille: JSONNull?? = nil,
        estrous: JSONNull?? = nil,
        interestedly: JSONNull?? = nil,
        katakinetomer: JSONNull?? = nil,
        mortification: JSONNull?? = nil,
        morula: JSONNull?? = nil,
        orthosymmetrical: JSONNull?? = nil,
        overbark: JSONNull?? = nil,
        politist: JSONNull?? = nil,
        qualified: JSONNull?? = nil,
        sphenomalar: JSONNull?? = nil,
        throatful: JSONNull?? = nil,
        transhumance: JSONNull?? = nil,
        triandrian: JSONNull?? = nil,
        unbooked: JSONNull?? = nil
    ) -> WrothyClass {
        return WrothyClass(
            aeschynanthus: aeschynanthus ?? self.aeschynanthus,
            aquiferous: aquiferous ?? self.aquiferous,
            cheapener: cheapener ?? self.cheapener,
            enumeration: enumeration ?? self.enumeration,
            ephesine: ephesine ?? self.ephesine,
            escadrille: escadrille ?? self.escadrille,
            estrous: estrous ?? self.estrous,
            interestedly: interestedly ?? self.interestedly,
            katakinetomer: katakinetomer ?? self.katakinetomer,
            mortification: mortification ?? self.mortification,
            morula: morula ?? self.morula,
            orthosymmetrical: orthosymmetrical ?? self.orthosymmetrical,
            overbark: overbark ?? self.overbark,
            politist: politist ?? self.politist,
            qualified: qualified ?? self.qualified,
            sphenomalar: sphenomalar ?? self.sphenomalar,
            throatful: throatful ?? self.throatful,
            transhumance: transhumance ?? self.transhumance,
            triandrian: triandrian ?? self.triandrian,
            unbooked: unbooked ?? self.unbooked
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
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
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
