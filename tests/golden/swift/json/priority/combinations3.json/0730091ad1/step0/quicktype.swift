// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
public struct TopLevel: Codable {
    public let juror: [JurorElement]
    public let kongoni: [Kongoni]
    public let ladronism: [LadronismElement]
    public let landlubberly: [LandlubberlyElement]
    public let listener: [Listener]
    public let lupus: [LupusElement]
    public let maslin: [Maslin]
    public let monazite: [MonaziteElement]
    public let monoliteral: [Monoliteral]
    public let monotheistically: [MonotheisticallyElement]
    public let montage: [Montage]
    public let moralness: [Moralness]
    public let mowra: [MonaziteClass?]
    public let mulishly: [Mulishly]
    public let myoscope: [Myoscope]
    public let nach: [[Int?]?]
    public let neuromastic: [Neuromastic]
    public let noncontributing: [Noncontributing]
    public let nonnervous: [Nonnervous]
    public let nonvaluation: [Nonvaluation]
    public let occupationalist: [OccupationalistElement]
    public let outrival: [OutrivalElement]
    public let paleographically: [Paleographically]
    public let pamphletwise: [Pamphletwise]
    public let pediatrics: [Pediatric]
    public let perceptive: [Bool]
    public let piaculum: [PiaculumElement]
    public let piccadilly: [Piccadilly]
    public let piffler: [Piffler]
    public let pithful: [Pithful]
    public let placuntitis: [Placuntiti]
    public let plectopterous: [Plectopterous]
    public let pneumocele: [Pneumocele?]
    public let poliorcetic: [Poliorcetic]
    public let poormaster: [Poormaster]
    public let potwhisky: [PotwhiskyElement]
    public let practicalizer: [Practicalizer]
    public let prefreshman: [PrefreshmanElement]
    public let prehensility: [Prehensility]
    public let prevoidance: [Prevoidance]
    public let probant: [[String: Int?]]
    public let protext: [Protext]

    public enum CodingKeys: String, CodingKey {
        case juror = "juror"
        case kongoni = "kongoni"
        case ladronism = "ladronism"
        case landlubberly = "landlubberly"
        case listener = "listener"
        case lupus = "lupus"
        case maslin = "maslin"
        case monazite = "monazite"
        case monoliteral = "monoliteral"
        case monotheistically = "monotheistically"
        case montage = "montage"
        case moralness = "moralness"
        case mowra = "mowra"
        case mulishly = "mulishly"
        case myoscope = "myoscope"
        case nach = "nach"
        case neuromastic = "neuromastic"
        case noncontributing = "noncontributing"
        case nonnervous = "nonnervous"
        case nonvaluation = "nonvaluation"
        case occupationalist = "occupationalist"
        case outrival = "outrival"
        case paleographically = "paleographically"
        case pamphletwise = "pamphletwise"
        case pediatrics = "pediatrics"
        case perceptive = "perceptive"
        case piaculum = "piaculum"
        case piccadilly = "piccadilly"
        case piffler = "piffler"
        case pithful = "pithful"
        case placuntitis = "placuntitis"
        case plectopterous = "plectopterous"
        case pneumocele = "pneumocele"
        case poliorcetic = "poliorcetic"
        case poormaster = "poormaster"
        case potwhisky = "potwhisky"
        case practicalizer = "practicalizer"
        case prefreshman = "prefreshman"
        case prehensility = "prehensility"
        case prevoidance = "prevoidance"
        case probant = "probant"
        case protext = "protext"
    }

    public init(juror: [JurorElement], kongoni: [Kongoni], ladronism: [LadronismElement], landlubberly: [LandlubberlyElement], listener: [Listener], lupus: [LupusElement], maslin: [Maslin], monazite: [MonaziteElement], monoliteral: [Monoliteral], monotheistically: [MonotheisticallyElement], montage: [Montage], moralness: [Moralness], mowra: [MonaziteClass?], mulishly: [Mulishly], myoscope: [Myoscope], nach: [[Int?]?], neuromastic: [Neuromastic], noncontributing: [Noncontributing], nonnervous: [Nonnervous], nonvaluation: [Nonvaluation], occupationalist: [OccupationalistElement], outrival: [OutrivalElement], paleographically: [Paleographically], pamphletwise: [Pamphletwise], pediatrics: [Pediatric], perceptive: [Bool], piaculum: [PiaculumElement], piccadilly: [Piccadilly], piffler: [Piffler], pithful: [Pithful], placuntitis: [Placuntiti], plectopterous: [Plectopterous], pneumocele: [Pneumocele?], poliorcetic: [Poliorcetic], poormaster: [Poormaster], potwhisky: [PotwhiskyElement], practicalizer: [Practicalizer], prefreshman: [PrefreshmanElement], prehensility: [Prehensility], prevoidance: [Prevoidance], probant: [[String: Int?]], protext: [Protext]) {
        self.juror = juror
        self.kongoni = kongoni
        self.ladronism = ladronism
        self.landlubberly = landlubberly
        self.listener = listener
        self.lupus = lupus
        self.maslin = maslin
        self.monazite = monazite
        self.monoliteral = monoliteral
        self.monotheistically = monotheistically
        self.montage = montage
        self.moralness = moralness
        self.mowra = mowra
        self.mulishly = mulishly
        self.myoscope = myoscope
        self.nach = nach
        self.neuromastic = neuromastic
        self.noncontributing = noncontributing
        self.nonnervous = nonnervous
        self.nonvaluation = nonvaluation
        self.occupationalist = occupationalist
        self.outrival = outrival
        self.paleographically = paleographically
        self.pamphletwise = pamphletwise
        self.pediatrics = pediatrics
        self.perceptive = perceptive
        self.piaculum = piaculum
        self.piccadilly = piccadilly
        self.piffler = piffler
        self.pithful = pithful
        self.placuntitis = placuntitis
        self.plectopterous = plectopterous
        self.pneumocele = pneumocele
        self.poliorcetic = poliorcetic
        self.poormaster = poormaster
        self.potwhisky = potwhisky
        self.practicalizer = practicalizer
        self.prefreshman = prefreshman
        self.prehensility = prehensility
        self.prevoidance = prevoidance
        self.probant = probant
        self.protext = protext
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
        juror: [JurorElement]? = nil,
        kongoni: [Kongoni]? = nil,
        ladronism: [LadronismElement]? = nil,
        landlubberly: [LandlubberlyElement]? = nil,
        listener: [Listener]? = nil,
        lupus: [LupusElement]? = nil,
        maslin: [Maslin]? = nil,
        monazite: [MonaziteElement]? = nil,
        monoliteral: [Monoliteral]? = nil,
        monotheistically: [MonotheisticallyElement]? = nil,
        montage: [Montage]? = nil,
        moralness: [Moralness]? = nil,
        mowra: [MonaziteClass?]? = nil,
        mulishly: [Mulishly]? = nil,
        myoscope: [Myoscope]? = nil,
        nach: [[Int?]?]? = nil,
        neuromastic: [Neuromastic]? = nil,
        noncontributing: [Noncontributing]? = nil,
        nonnervous: [Nonnervous]? = nil,
        nonvaluation: [Nonvaluation]? = nil,
        occupationalist: [OccupationalistElement]? = nil,
        outrival: [OutrivalElement]? = nil,
        paleographically: [Paleographically]? = nil,
        pamphletwise: [Pamphletwise]? = nil,
        pediatrics: [Pediatric]? = nil,
        perceptive: [Bool]? = nil,
        piaculum: [PiaculumElement]? = nil,
        piccadilly: [Piccadilly]? = nil,
        piffler: [Piffler]? = nil,
        pithful: [Pithful]? = nil,
        placuntitis: [Placuntiti]? = nil,
        plectopterous: [Plectopterous]? = nil,
        pneumocele: [Pneumocele?]? = nil,
        poliorcetic: [Poliorcetic]? = nil,
        poormaster: [Poormaster]? = nil,
        potwhisky: [PotwhiskyElement]? = nil,
        practicalizer: [Practicalizer]? = nil,
        prefreshman: [PrefreshmanElement]? = nil,
        prehensility: [Prehensility]? = nil,
        prevoidance: [Prevoidance]? = nil,
        probant: [[String: Int?]]? = nil,
        protext: [Protext]? = nil
    ) -> TopLevel {
        return TopLevel(
            juror: juror ?? self.juror,
            kongoni: kongoni ?? self.kongoni,
            ladronism: ladronism ?? self.ladronism,
            landlubberly: landlubberly ?? self.landlubberly,
            listener: listener ?? self.listener,
            lupus: lupus ?? self.lupus,
            maslin: maslin ?? self.maslin,
            monazite: monazite ?? self.monazite,
            monoliteral: monoliteral ?? self.monoliteral,
            monotheistically: monotheistically ?? self.monotheistically,
            montage: montage ?? self.montage,
            moralness: moralness ?? self.moralness,
            mowra: mowra ?? self.mowra,
            mulishly: mulishly ?? self.mulishly,
            myoscope: myoscope ?? self.myoscope,
            nach: nach ?? self.nach,
            neuromastic: neuromastic ?? self.neuromastic,
            noncontributing: noncontributing ?? self.noncontributing,
            nonnervous: nonnervous ?? self.nonnervous,
            nonvaluation: nonvaluation ?? self.nonvaluation,
            occupationalist: occupationalist ?? self.occupationalist,
            outrival: outrival ?? self.outrival,
            paleographically: paleographically ?? self.paleographically,
            pamphletwise: pamphletwise ?? self.pamphletwise,
            pediatrics: pediatrics ?? self.pediatrics,
            perceptive: perceptive ?? self.perceptive,
            piaculum: piaculum ?? self.piaculum,
            piccadilly: piccadilly ?? self.piccadilly,
            piffler: piffler ?? self.piffler,
            pithful: pithful ?? self.pithful,
            placuntitis: placuntitis ?? self.placuntitis,
            plectopterous: plectopterous ?? self.plectopterous,
            pneumocele: pneumocele ?? self.pneumocele,
            poliorcetic: poliorcetic ?? self.poliorcetic,
            poormaster: poormaster ?? self.poormaster,
            potwhisky: potwhisky ?? self.potwhisky,
            practicalizer: practicalizer ?? self.practicalizer,
            prefreshman: prefreshman ?? self.prefreshman,
            prehensility: prehensility ?? self.prehensility,
            prevoidance: prevoidance ?? self.prevoidance,
            probant: probant ?? self.probant,
            protext: protext ?? self.protext
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum JurorElement: Codable {
    case bool(Bool)
    case jurorClass(JurorClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(JurorClass.self) {
            self = .jurorClass(x)
            return
        }
        throw DecodingError.typeMismatch(JurorElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JurorElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .jurorClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JurorClass
public struct JurorClass: Codable {
    public let adipsy: JSONNull?
    public let auxiliator: JSONNull?
    public let benda: JSONNull?
    public let benjamin: JSONNull?
    public let brandling: JSONNull?
    public let epicurishly: JSONNull?
    public let eremochaetous: JSONNull?
    public let marten: JSONNull?
    public let monocline: JSONNull?
    public let olea: JSONNull?
    public let palgat: JSONNull?
    public let pennyworth: JSONNull?
    public let pioury: JSONNull?
    public let pragmatistic: JSONNull?
    public let stylelessness: JSONNull?
    public let systematical: JSONNull?
    public let thready: JSONNull?
    public let uncontemporary: JSONNull?
    public let uncouched: JSONNull?
    public let uninhabitedness: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case adipsy = "adipsy"
        case auxiliator = "auxiliator"
        case benda = "benda"
        case benjamin = "benjamin"
        case brandling = "brandling"
        case epicurishly = "epicurishly"
        case eremochaetous = "eremochaetous"
        case marten = "marten"
        case monocline = "monocline"
        case olea = "Olea"
        case palgat = "palgat"
        case pennyworth = "pennyworth"
        case pioury = "pioury"
        case pragmatistic = "pragmatistic"
        case stylelessness = "stylelessness"
        case systematical = "systematical"
        case thready = "thready"
        case uncontemporary = "uncontemporary"
        case uncouched = "uncouched"
        case uninhabitedness = "uninhabitedness"
    }

    public init(adipsy: JSONNull?, auxiliator: JSONNull?, benda: JSONNull?, benjamin: JSONNull?, brandling: JSONNull?, epicurishly: JSONNull?, eremochaetous: JSONNull?, marten: JSONNull?, monocline: JSONNull?, olea: JSONNull?, palgat: JSONNull?, pennyworth: JSONNull?, pioury: JSONNull?, pragmatistic: JSONNull?, stylelessness: JSONNull?, systematical: JSONNull?, thready: JSONNull?, uncontemporary: JSONNull?, uncouched: JSONNull?, uninhabitedness: JSONNull?) {
        self.adipsy = adipsy
        self.auxiliator = auxiliator
        self.benda = benda
        self.benjamin = benjamin
        self.brandling = brandling
        self.epicurishly = epicurishly
        self.eremochaetous = eremochaetous
        self.marten = marten
        self.monocline = monocline
        self.olea = olea
        self.palgat = palgat
        self.pennyworth = pennyworth
        self.pioury = pioury
        self.pragmatistic = pragmatistic
        self.stylelessness = stylelessness
        self.systematical = systematical
        self.thready = thready
        self.uncontemporary = uncontemporary
        self.uncouched = uncouched
        self.uninhabitedness = uninhabitedness
    }
}

// MARK: JurorClass convenience initializers and mutators

public extension JurorClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JurorClass.self, from: data)
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
        adipsy: JSONNull?? = nil,
        auxiliator: JSONNull?? = nil,
        benda: JSONNull?? = nil,
        benjamin: JSONNull?? = nil,
        brandling: JSONNull?? = nil,
        epicurishly: JSONNull?? = nil,
        eremochaetous: JSONNull?? = nil,
        marten: JSONNull?? = nil,
        monocline: JSONNull?? = nil,
        olea: JSONNull?? = nil,
        palgat: JSONNull?? = nil,
        pennyworth: JSONNull?? = nil,
        pioury: JSONNull?? = nil,
        pragmatistic: JSONNull?? = nil,
        stylelessness: JSONNull?? = nil,
        systematical: JSONNull?? = nil,
        thready: JSONNull?? = nil,
        uncontemporary: JSONNull?? = nil,
        uncouched: JSONNull?? = nil,
        uninhabitedness: JSONNull?? = nil
    ) -> JurorClass {
        return JurorClass(
            adipsy: adipsy ?? self.adipsy,
            auxiliator: auxiliator ?? self.auxiliator,
            benda: benda ?? self.benda,
            benjamin: benjamin ?? self.benjamin,
            brandling: brandling ?? self.brandling,
            epicurishly: epicurishly ?? self.epicurishly,
            eremochaetous: eremochaetous ?? self.eremochaetous,
            marten: marten ?? self.marten,
            monocline: monocline ?? self.monocline,
            olea: olea ?? self.olea,
            palgat: palgat ?? self.palgat,
            pennyworth: pennyworth ?? self.pennyworth,
            pioury: pioury ?? self.pioury,
            pragmatistic: pragmatistic ?? self.pragmatistic,
            stylelessness: stylelessness ?? self.stylelessness,
            systematical: systematical ?? self.systematical,
            thready: thready ?? self.thready,
            uncontemporary: uncontemporary ?? self.uncontemporary,
            uncouched: uncouched ?? self.uncouched,
            uninhabitedness: uninhabitedness ?? self.uninhabitedness
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Kongoni: Codable {
    case integerArray([Int])
    case integerMap([String: Int])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Kongoni.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Kongoni"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

public enum LadronismElement: Codable {
    case double(Double)
    case ladronismClass(LadronismClass)
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
        if let x = try? container.decode(LadronismClass.self) {
            self = .ladronismClass(x)
            return
        }
        throw DecodingError.typeMismatch(LadronismElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LadronismElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .ladronismClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LadronismClass
public struct LadronismClass: Codable {
    public let acclaimer: JSONNull?
    public let achree: JSONNull?
    public let base: JSONNull?
    public let conundrumize: JSONNull?
    public let degerminator: JSONNull?
    public let describable: JSONNull?
    public let exasperatedly: JSONNull?
    public let heroine: JSONNull?
    public let indazin: JSONNull?
    public let luteous: JSONNull?
    public let papular: JSONNull?
    public let pritch: JSONNull?
    public let prodenia: JSONNull?
    public let seege: JSONNull?
    public let shopgirl: JSONNull?
    public let tragedietta: JSONNull?
    public let unsparse: JSONNull?
    public let uplook: JSONNull?
    public let vermiformis: JSONNull?
    public let whafabout: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case acclaimer = "acclaimer"
        case achree = "achree"
        case base = "base"
        case conundrumize = "conundrumize"
        case degerminator = "degerminator"
        case describable = "describable"
        case exasperatedly = "exasperatedly"
        case heroine = "heroine"
        case indazin = "indazin"
        case luteous = "luteous"
        case papular = "papular"
        case pritch = "pritch"
        case prodenia = "Prodenia"
        case seege = "seege"
        case shopgirl = "shopgirl"
        case tragedietta = "tragedietta"
        case unsparse = "unsparse"
        case uplook = "uplook"
        case vermiformis = "vermiformis"
        case whafabout = "whafabout"
    }

    public init(acclaimer: JSONNull?, achree: JSONNull?, base: JSONNull?, conundrumize: JSONNull?, degerminator: JSONNull?, describable: JSONNull?, exasperatedly: JSONNull?, heroine: JSONNull?, indazin: JSONNull?, luteous: JSONNull?, papular: JSONNull?, pritch: JSONNull?, prodenia: JSONNull?, seege: JSONNull?, shopgirl: JSONNull?, tragedietta: JSONNull?, unsparse: JSONNull?, uplook: JSONNull?, vermiformis: JSONNull?, whafabout: JSONNull?) {
        self.acclaimer = acclaimer
        self.achree = achree
        self.base = base
        self.conundrumize = conundrumize
        self.degerminator = degerminator
        self.describable = describable
        self.exasperatedly = exasperatedly
        self.heroine = heroine
        self.indazin = indazin
        self.luteous = luteous
        self.papular = papular
        self.pritch = pritch
        self.prodenia = prodenia
        self.seege = seege
        self.shopgirl = shopgirl
        self.tragedietta = tragedietta
        self.unsparse = unsparse
        self.uplook = uplook
        self.vermiformis = vermiformis
        self.whafabout = whafabout
    }
}

// MARK: LadronismClass convenience initializers and mutators

public extension LadronismClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LadronismClass.self, from: data)
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
        acclaimer: JSONNull?? = nil,
        achree: JSONNull?? = nil,
        base: JSONNull?? = nil,
        conundrumize: JSONNull?? = nil,
        degerminator: JSONNull?? = nil,
        describable: JSONNull?? = nil,
        exasperatedly: JSONNull?? = nil,
        heroine: JSONNull?? = nil,
        indazin: JSONNull?? = nil,
        luteous: JSONNull?? = nil,
        papular: JSONNull?? = nil,
        pritch: JSONNull?? = nil,
        prodenia: JSONNull?? = nil,
        seege: JSONNull?? = nil,
        shopgirl: JSONNull?? = nil,
        tragedietta: JSONNull?? = nil,
        unsparse: JSONNull?? = nil,
        uplook: JSONNull?? = nil,
        vermiformis: JSONNull?? = nil,
        whafabout: JSONNull?? = nil
    ) -> LadronismClass {
        return LadronismClass(
            acclaimer: acclaimer ?? self.acclaimer,
            achree: achree ?? self.achree,
            base: base ?? self.base,
            conundrumize: conundrumize ?? self.conundrumize,
            degerminator: degerminator ?? self.degerminator,
            describable: describable ?? self.describable,
            exasperatedly: exasperatedly ?? self.exasperatedly,
            heroine: heroine ?? self.heroine,
            indazin: indazin ?? self.indazin,
            luteous: luteous ?? self.luteous,
            papular: papular ?? self.papular,
            pritch: pritch ?? self.pritch,
            prodenia: prodenia ?? self.prodenia,
            seege: seege ?? self.seege,
            shopgirl: shopgirl ?? self.shopgirl,
            tragedietta: tragedietta ?? self.tragedietta,
            unsparse: unsparse ?? self.unsparse,
            uplook: uplook ?? self.uplook,
            vermiformis: vermiformis ?? self.vermiformis,
            whafabout: whafabout ?? self.whafabout
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum LandlubberlyElement: Codable {
    case bool(Bool)
    case integer(Int)
    case landlubberlyClass(LandlubberlyClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(LandlubberlyClass.self) {
            self = .landlubberlyClass(x)
            return
        }
        throw DecodingError.typeMismatch(LandlubberlyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LandlubberlyElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .landlubberlyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LandlubberlyClass
public struct LandlubberlyClass: Codable {
    public let acropoleis: JSONNull?
    public let aminate: JSONNull?
    public let amyraldism: JSONNull?
    public let bipenniform: JSONNull?
    public let bugre: JSONNull?
    public let calycule: JSONNull?
    public let caoutchouc: JSONNull?
    public let disprover: JSONNull?
    public let fitroot: JSONNull?
    public let fulgently: JSONNull?
    public let kickup: JSONNull?
    public let laevoversion: JSONNull?
    public let moter: JSONNull?
    public let objectivity: JSONNull?
    public let posterity: JSONNull?
    public let postnuptial: JSONNull?
    public let precedentary: JSONNull?
    public let saddling: JSONNull?
    public let subcurrent: JSONNull?
    public let unrecriminative: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case acropoleis = "acropoleis"
        case aminate = "aminate"
        case amyraldism = "Amyraldism"
        case bipenniform = "bipenniform"
        case bugre = "bugre"
        case calycule = "calycule"
        case caoutchouc = "caoutchouc"
        case disprover = "disprover"
        case fitroot = "fitroot"
        case fulgently = "fulgently"
        case kickup = "kickup"
        case laevoversion = "laevoversion"
        case moter = "moter"
        case objectivity = "objectivity"
        case posterity = "posterity"
        case postnuptial = "postnuptial"
        case precedentary = "precedentary"
        case saddling = "saddling"
        case subcurrent = "subcurrent"
        case unrecriminative = "unrecriminative"
    }

    public init(acropoleis: JSONNull?, aminate: JSONNull?, amyraldism: JSONNull?, bipenniform: JSONNull?, bugre: JSONNull?, calycule: JSONNull?, caoutchouc: JSONNull?, disprover: JSONNull?, fitroot: JSONNull?, fulgently: JSONNull?, kickup: JSONNull?, laevoversion: JSONNull?, moter: JSONNull?, objectivity: JSONNull?, posterity: JSONNull?, postnuptial: JSONNull?, precedentary: JSONNull?, saddling: JSONNull?, subcurrent: JSONNull?, unrecriminative: JSONNull?) {
        self.acropoleis = acropoleis
        self.aminate = aminate
        self.amyraldism = amyraldism
        self.bipenniform = bipenniform
        self.bugre = bugre
        self.calycule = calycule
        self.caoutchouc = caoutchouc
        self.disprover = disprover
        self.fitroot = fitroot
        self.fulgently = fulgently
        self.kickup = kickup
        self.laevoversion = laevoversion
        self.moter = moter
        self.objectivity = objectivity
        self.posterity = posterity
        self.postnuptial = postnuptial
        self.precedentary = precedentary
        self.saddling = saddling
        self.subcurrent = subcurrent
        self.unrecriminative = unrecriminative
    }
}

// MARK: LandlubberlyClass convenience initializers and mutators

public extension LandlubberlyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LandlubberlyClass.self, from: data)
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
        acropoleis: JSONNull?? = nil,
        aminate: JSONNull?? = nil,
        amyraldism: JSONNull?? = nil,
        bipenniform: JSONNull?? = nil,
        bugre: JSONNull?? = nil,
        calycule: JSONNull?? = nil,
        caoutchouc: JSONNull?? = nil,
        disprover: JSONNull?? = nil,
        fitroot: JSONNull?? = nil,
        fulgently: JSONNull?? = nil,
        kickup: JSONNull?? = nil,
        laevoversion: JSONNull?? = nil,
        moter: JSONNull?? = nil,
        objectivity: JSONNull?? = nil,
        posterity: JSONNull?? = nil,
        postnuptial: JSONNull?? = nil,
        precedentary: JSONNull?? = nil,
        saddling: JSONNull?? = nil,
        subcurrent: JSONNull?? = nil,
        unrecriminative: JSONNull?? = nil
    ) -> LandlubberlyClass {
        return LandlubberlyClass(
            acropoleis: acropoleis ?? self.acropoleis,
            aminate: aminate ?? self.aminate,
            amyraldism: amyraldism ?? self.amyraldism,
            bipenniform: bipenniform ?? self.bipenniform,
            bugre: bugre ?? self.bugre,
            calycule: calycule ?? self.calycule,
            caoutchouc: caoutchouc ?? self.caoutchouc,
            disprover: disprover ?? self.disprover,
            fitroot: fitroot ?? self.fitroot,
            fulgently: fulgently ?? self.fulgently,
            kickup: kickup ?? self.kickup,
            laevoversion: laevoversion ?? self.laevoversion,
            moter: moter ?? self.moter,
            objectivity: objectivity ?? self.objectivity,
            posterity: posterity ?? self.posterity,
            postnuptial: postnuptial ?? self.postnuptial,
            precedentary: precedentary ?? self.precedentary,
            saddling: saddling ?? self.saddling,
            subcurrent: subcurrent ?? self.subcurrent,
            unrecriminative: unrecriminative ?? self.unrecriminative
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Listener: Codable {
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
        throw DecodingError.typeMismatch(Listener.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Listener"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum LupusElement: Codable {
    case integer(Int)
    case lupusClass(LupusClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(LupusClass.self) {
            self = .lupusClass(x)
            return
        }
        throw DecodingError.typeMismatch(LupusElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LupusElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .lupusClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LupusClass
public struct LupusClass: Codable {
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let chlorioninae: Int?
    public let corvinae: Int?
    public let crassina: Int?
    public let disdiapason: String?
    public let exiguity: Int?
    public let farcist: Int?
    public let holographical: Int?
    public let homocerc: Bool?
    public let ichthyophagan: Int?
    public let implacable: Int?
    public let nonbookish: JSONNull?
    public let outshiner: Int?
    public let overweather: Int?
    public let protonegroid: Int?
    public let shallowish: Int?
    public let snoke: Int?
    public let snout: Int?
    public let surveillance: Int?
    public let threshingtime: Int?
    public let thysanocarpus: Int?
    public let unsignificantly: Int?
    public let unsnap: Int?
    public let vendible: Int?

    public enum CodingKeys: String, CodingKey {
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case chlorioninae = "Chlorioninae"
        case corvinae = "Corvinae"
        case crassina = "Crassina"
        case disdiapason = "disdiapason"
        case exiguity = "exiguity"
        case farcist = "farcist"
        case holographical = "holographical"
        case homocerc = "homocerc"
        case ichthyophagan = "ichthyophagan"
        case implacable = "implacable"
        case nonbookish = "nonbookish"
        case outshiner = "outshiner"
        case overweather = "overweather"
        case protonegroid = "protonegroid"
        case shallowish = "shallowish"
        case snoke = "snoke"
        case snout = "snout"
        case surveillance = "surveillance"
        case threshingtime = "threshingtime"
        case thysanocarpus = "Thysanocarpus"
        case unsignificantly = "unsignificantly"
        case unsnap = "unsnap"
        case vendible = "vendible"
    }

    public init(catharticalness: Double?, chirotherium: Int?, chlorioninae: Int?, corvinae: Int?, crassina: Int?, disdiapason: String?, exiguity: Int?, farcist: Int?, holographical: Int?, homocerc: Bool?, ichthyophagan: Int?, implacable: Int?, nonbookish: JSONNull?, outshiner: Int?, overweather: Int?, protonegroid: Int?, shallowish: Int?, snoke: Int?, snout: Int?, surveillance: Int?, threshingtime: Int?, thysanocarpus: Int?, unsignificantly: Int?, unsnap: Int?, vendible: Int?) {
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.chlorioninae = chlorioninae
        self.corvinae = corvinae
        self.crassina = crassina
        self.disdiapason = disdiapason
        self.exiguity = exiguity
        self.farcist = farcist
        self.holographical = holographical
        self.homocerc = homocerc
        self.ichthyophagan = ichthyophagan
        self.implacable = implacable
        self.nonbookish = nonbookish
        self.outshiner = outshiner
        self.overweather = overweather
        self.protonegroid = protonegroid
        self.shallowish = shallowish
        self.snoke = snoke
        self.snout = snout
        self.surveillance = surveillance
        self.threshingtime = threshingtime
        self.thysanocarpus = thysanocarpus
        self.unsignificantly = unsignificantly
        self.unsnap = unsnap
        self.vendible = vendible
    }
}

// MARK: LupusClass convenience initializers and mutators

public extension LupusClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LupusClass.self, from: data)
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
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        chlorioninae: Int?? = nil,
        corvinae: Int?? = nil,
        crassina: Int?? = nil,
        disdiapason: String?? = nil,
        exiguity: Int?? = nil,
        farcist: Int?? = nil,
        holographical: Int?? = nil,
        homocerc: Bool?? = nil,
        ichthyophagan: Int?? = nil,
        implacable: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        outshiner: Int?? = nil,
        overweather: Int?? = nil,
        protonegroid: Int?? = nil,
        shallowish: Int?? = nil,
        snoke: Int?? = nil,
        snout: Int?? = nil,
        surveillance: Int?? = nil,
        threshingtime: Int?? = nil,
        thysanocarpus: Int?? = nil,
        unsignificantly: Int?? = nil,
        unsnap: Int?? = nil,
        vendible: Int?? = nil
    ) -> LupusClass {
        return LupusClass(
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            chlorioninae: chlorioninae ?? self.chlorioninae,
            corvinae: corvinae ?? self.corvinae,
            crassina: crassina ?? self.crassina,
            disdiapason: disdiapason ?? self.disdiapason,
            exiguity: exiguity ?? self.exiguity,
            farcist: farcist ?? self.farcist,
            holographical: holographical ?? self.holographical,
            homocerc: homocerc ?? self.homocerc,
            ichthyophagan: ichthyophagan ?? self.ichthyophagan,
            implacable: implacable ?? self.implacable,
            nonbookish: nonbookish ?? self.nonbookish,
            outshiner: outshiner ?? self.outshiner,
            overweather: overweather ?? self.overweather,
            protonegroid: protonegroid ?? self.protonegroid,
            shallowish: shallowish ?? self.shallowish,
            snoke: snoke ?? self.snoke,
            snout: snout ?? self.snout,
            surveillance: surveillance ?? self.surveillance,
            threshingtime: threshingtime ?? self.threshingtime,
            thysanocarpus: thysanocarpus ?? self.thysanocarpus,
            unsignificantly: unsignificantly ?? self.unsignificantly,
            unsnap: unsnap ?? self.unsnap,
            vendible: vendible ?? self.vendible
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Maslin
public struct Maslin: Codable {
    public let alicant: Int?
    public let antiatonement: JSONNull?
    public let anticorrosive: Int?
    public let aphidozer: JSONNull?
    public let bakuninist: JSONNull?
    public let be: Int?
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let chub: Int?
    public let cuprosilicon: Int?
    public let curtailedly: Int?
    public let dellenite: Int?
    public let dimitry: Int?
    public let disdiapason: String?
    public let edifying: JSONNull?
    public let ethmoiditis: Int?
    public let gastralgy: JSONNull?
    public let goatherd: Int?
    public let hammerdress: Int?
    public let hangfire: JSONNull?
    public let homocerc: Bool?
    public let lacunosity: Int?
    public let longiloquence: JSONNull?
    public let mameliere: Int?
    public let motherless: JSONNull?
    public let nonbookish: JSONNull?
    public let noncorrodible: JSONNull?
    public let nonsensicality: JSONNull?
    public let oafishly: Int?
    public let pfund: JSONNull?
    public let preadvisory: JSONNull?
    public let retroflexed: JSONNull?
    public let saccharulmic: Int?
    public let scowlful: Int?
    public let secluded: JSONNull?
    public let slackage: JSONNull?
    public let sphaeridial: Int?
    public let spondulics: JSONNull?
    public let subsecive: Int?
    public let swellmobsman: JSONNull?
    public let trachyglossate: Int?
    public let trialogue: JSONNull?
    public let unassuaged: Int?
    public let ungross: JSONNull?
    public let unjudiciously: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case alicant = "Alicant"
        case antiatonement = "antiatonement"
        case anticorrosive = "anticorrosive"
        case aphidozer = "aphidozer"
        case bakuninist = "Bakuninist"
        case be = "be"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case chub = "chub"
        case cuprosilicon = "cuprosilicon"
        case curtailedly = "curtailedly"
        case dellenite = "dellenite"
        case dimitry = "Dimitry"
        case disdiapason = "disdiapason"
        case edifying = "edifying"
        case ethmoiditis = "ethmoiditis"
        case gastralgy = "gastralgy"
        case goatherd = "goatherd"
        case hammerdress = "hammerdress"
        case hangfire = "hangfire"
        case homocerc = "homocerc"
        case lacunosity = "lacunosity"
        case longiloquence = "longiloquence"
        case mameliere = "mameliere"
        case motherless = "motherless"
        case nonbookish = "nonbookish"
        case noncorrodible = "noncorrodible"
        case nonsensicality = "nonsensicality"
        case oafishly = "oafishly"
        case pfund = "pfund"
        case preadvisory = "preadvisory"
        case retroflexed = "retroflexed"
        case saccharulmic = "saccharulmic"
        case scowlful = "scowlful"
        case secluded = "secluded"
        case slackage = "slackage"
        case sphaeridial = "sphaeridial"
        case spondulics = "spondulics"
        case subsecive = "subsecive"
        case swellmobsman = "swellmobsman"
        case trachyglossate = "trachyglossate"
        case trialogue = "trialogue"
        case unassuaged = "unassuaged"
        case ungross = "ungross"
        case unjudiciously = "unjudiciously"
    }

    public init(alicant: Int?, antiatonement: JSONNull?, anticorrosive: Int?, aphidozer: JSONNull?, bakuninist: JSONNull?, be: Int?, catharticalness: Double?, chirotherium: Int?, chub: Int?, cuprosilicon: Int?, curtailedly: Int?, dellenite: Int?, dimitry: Int?, disdiapason: String?, edifying: JSONNull?, ethmoiditis: Int?, gastralgy: JSONNull?, goatherd: Int?, hammerdress: Int?, hangfire: JSONNull?, homocerc: Bool?, lacunosity: Int?, longiloquence: JSONNull?, mameliere: Int?, motherless: JSONNull?, nonbookish: JSONNull?, noncorrodible: JSONNull?, nonsensicality: JSONNull?, oafishly: Int?, pfund: JSONNull?, preadvisory: JSONNull?, retroflexed: JSONNull?, saccharulmic: Int?, scowlful: Int?, secluded: JSONNull?, slackage: JSONNull?, sphaeridial: Int?, spondulics: JSONNull?, subsecive: Int?, swellmobsman: JSONNull?, trachyglossate: Int?, trialogue: JSONNull?, unassuaged: Int?, ungross: JSONNull?, unjudiciously: JSONNull?) {
        self.alicant = alicant
        self.antiatonement = antiatonement
        self.anticorrosive = anticorrosive
        self.aphidozer = aphidozer
        self.bakuninist = bakuninist
        self.be = be
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.chub = chub
        self.cuprosilicon = cuprosilicon
        self.curtailedly = curtailedly
        self.dellenite = dellenite
        self.dimitry = dimitry
        self.disdiapason = disdiapason
        self.edifying = edifying
        self.ethmoiditis = ethmoiditis
        self.gastralgy = gastralgy
        self.goatherd = goatherd
        self.hammerdress = hammerdress
        self.hangfire = hangfire
        self.homocerc = homocerc
        self.lacunosity = lacunosity
        self.longiloquence = longiloquence
        self.mameliere = mameliere
        self.motherless = motherless
        self.nonbookish = nonbookish
        self.noncorrodible = noncorrodible
        self.nonsensicality = nonsensicality
        self.oafishly = oafishly
        self.pfund = pfund
        self.preadvisory = preadvisory
        self.retroflexed = retroflexed
        self.saccharulmic = saccharulmic
        self.scowlful = scowlful
        self.secluded = secluded
        self.slackage = slackage
        self.sphaeridial = sphaeridial
        self.spondulics = spondulics
        self.subsecive = subsecive
        self.swellmobsman = swellmobsman
        self.trachyglossate = trachyglossate
        self.trialogue = trialogue
        self.unassuaged = unassuaged
        self.ungross = ungross
        self.unjudiciously = unjudiciously
    }
}

// MARK: Maslin convenience initializers and mutators

public extension Maslin {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Maslin.self, from: data)
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
        alicant: Int?? = nil,
        antiatonement: JSONNull?? = nil,
        anticorrosive: Int?? = nil,
        aphidozer: JSONNull?? = nil,
        bakuninist: JSONNull?? = nil,
        be: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        chub: Int?? = nil,
        cuprosilicon: Int?? = nil,
        curtailedly: Int?? = nil,
        dellenite: Int?? = nil,
        dimitry: Int?? = nil,
        disdiapason: String?? = nil,
        edifying: JSONNull?? = nil,
        ethmoiditis: Int?? = nil,
        gastralgy: JSONNull?? = nil,
        goatherd: Int?? = nil,
        hammerdress: Int?? = nil,
        hangfire: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        lacunosity: Int?? = nil,
        longiloquence: JSONNull?? = nil,
        mameliere: Int?? = nil,
        motherless: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        noncorrodible: JSONNull?? = nil,
        nonsensicality: JSONNull?? = nil,
        oafishly: Int?? = nil,
        pfund: JSONNull?? = nil,
        preadvisory: JSONNull?? = nil,
        retroflexed: JSONNull?? = nil,
        saccharulmic: Int?? = nil,
        scowlful: Int?? = nil,
        secluded: JSONNull?? = nil,
        slackage: JSONNull?? = nil,
        sphaeridial: Int?? = nil,
        spondulics: JSONNull?? = nil,
        subsecive: Int?? = nil,
        swellmobsman: JSONNull?? = nil,
        trachyglossate: Int?? = nil,
        trialogue: JSONNull?? = nil,
        unassuaged: Int?? = nil,
        ungross: JSONNull?? = nil,
        unjudiciously: JSONNull?? = nil
    ) -> Maslin {
        return Maslin(
            alicant: alicant ?? self.alicant,
            antiatonement: antiatonement ?? self.antiatonement,
            anticorrosive: anticorrosive ?? self.anticorrosive,
            aphidozer: aphidozer ?? self.aphidozer,
            bakuninist: bakuninist ?? self.bakuninist,
            be: be ?? self.be,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            chub: chub ?? self.chub,
            cuprosilicon: cuprosilicon ?? self.cuprosilicon,
            curtailedly: curtailedly ?? self.curtailedly,
            dellenite: dellenite ?? self.dellenite,
            dimitry: dimitry ?? self.dimitry,
            disdiapason: disdiapason ?? self.disdiapason,
            edifying: edifying ?? self.edifying,
            ethmoiditis: ethmoiditis ?? self.ethmoiditis,
            gastralgy: gastralgy ?? self.gastralgy,
            goatherd: goatherd ?? self.goatherd,
            hammerdress: hammerdress ?? self.hammerdress,
            hangfire: hangfire ?? self.hangfire,
            homocerc: homocerc ?? self.homocerc,
            lacunosity: lacunosity ?? self.lacunosity,
            longiloquence: longiloquence ?? self.longiloquence,
            mameliere: mameliere ?? self.mameliere,
            motherless: motherless ?? self.motherless,
            nonbookish: nonbookish ?? self.nonbookish,
            noncorrodible: noncorrodible ?? self.noncorrodible,
            nonsensicality: nonsensicality ?? self.nonsensicality,
            oafishly: oafishly ?? self.oafishly,
            pfund: pfund ?? self.pfund,
            preadvisory: preadvisory ?? self.preadvisory,
            retroflexed: retroflexed ?? self.retroflexed,
            saccharulmic: saccharulmic ?? self.saccharulmic,
            scowlful: scowlful ?? self.scowlful,
            secluded: secluded ?? self.secluded,
            slackage: slackage ?? self.slackage,
            sphaeridial: sphaeridial ?? self.sphaeridial,
            spondulics: spondulics ?? self.spondulics,
            subsecive: subsecive ?? self.subsecive,
            swellmobsman: swellmobsman ?? self.swellmobsman,
            trachyglossate: trachyglossate ?? self.trachyglossate,
            trialogue: trialogue ?? self.trialogue,
            unassuaged: unassuaged ?? self.unassuaged,
            ungross: ungross ?? self.ungross,
            unjudiciously: unjudiciously ?? self.unjudiciously
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum MonaziteElement: Codable {
    case double(Double)
    case monaziteClass(MonaziteClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(MonaziteElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MonaziteElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .monaziteClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MonaziteClass
public struct MonaziteClass: Codable {
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

// MARK: MonaziteClass convenience initializers and mutators

public extension MonaziteClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MonaziteClass.self, from: data)
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
    ) -> MonaziteClass {
        return MonaziteClass(
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

public enum Monoliteral: Codable {
    case bool(Bool)
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
        throw DecodingError.typeMismatch(Monoliteral.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Monoliteral"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum MonotheisticallyElement: Codable {
    case monotheisticallyClass(MonotheisticallyClass)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(MonotheisticallyClass.self) {
            self = .monotheisticallyClass(x)
            return
        }
        throw DecodingError.typeMismatch(MonotheisticallyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MonotheisticallyElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .monotheisticallyClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MonotheisticallyClass
public struct MonotheisticallyClass: Codable {
    public let blaspheme: JSONNull?
    public let catharticalness: Double?
    public let celiosalpingectomy: JSONNull?
    public let chirotherium: Int?
    public let consummativeness: JSONNull?
    public let disdiapason: String?
    public let egestive: JSONNull?
    public let enchylema: JSONNull?
    public let gasconade: JSONNull?
    public let holidayer: JSONNull?
    public let homocerc: Bool?
    public let intuitionalism: JSONNull?
    public let lophiostomate: JSONNull?
    public let nonbookish: JSONNull?
    public let nonvolition: JSONNull?
    public let palatableness: JSONNull?
    public let pimpery: JSONNull?
    public let previolation: JSONNull?
    public let reconveyance: JSONNull?
    public let registership: JSONNull?
    public let rhyacolite: JSONNull?
    public let smithereens: JSONNull?
    public let superedification: JSONNull?
    public let trust: JSONNull?
    public let whitestone: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case blaspheme = "blaspheme"
        case catharticalness = "catharticalness"
        case celiosalpingectomy = "celiosalpingectomy"
        case chirotherium = "Chirotherium"
        case consummativeness = "consummativeness"
        case disdiapason = "disdiapason"
        case egestive = "egestive"
        case enchylema = "enchylema"
        case gasconade = "gasconade"
        case holidayer = "holidayer"
        case homocerc = "homocerc"
        case intuitionalism = "intuitionalism"
        case lophiostomate = "lophiostomate"
        case nonbookish = "nonbookish"
        case nonvolition = "nonvolition"
        case palatableness = "palatableness"
        case pimpery = "pimpery"
        case previolation = "previolation"
        case reconveyance = "reconveyance"
        case registership = "registership"
        case rhyacolite = "rhyacolite"
        case smithereens = "smithereens"
        case superedification = "superedification"
        case trust = "trust"
        case whitestone = "whitestone"
    }

    public init(blaspheme: JSONNull?, catharticalness: Double?, celiosalpingectomy: JSONNull?, chirotherium: Int?, consummativeness: JSONNull?, disdiapason: String?, egestive: JSONNull?, enchylema: JSONNull?, gasconade: JSONNull?, holidayer: JSONNull?, homocerc: Bool?, intuitionalism: JSONNull?, lophiostomate: JSONNull?, nonbookish: JSONNull?, nonvolition: JSONNull?, palatableness: JSONNull?, pimpery: JSONNull?, previolation: JSONNull?, reconveyance: JSONNull?, registership: JSONNull?, rhyacolite: JSONNull?, smithereens: JSONNull?, superedification: JSONNull?, trust: JSONNull?, whitestone: JSONNull?) {
        self.blaspheme = blaspheme
        self.catharticalness = catharticalness
        self.celiosalpingectomy = celiosalpingectomy
        self.chirotherium = chirotherium
        self.consummativeness = consummativeness
        self.disdiapason = disdiapason
        self.egestive = egestive
        self.enchylema = enchylema
        self.gasconade = gasconade
        self.holidayer = holidayer
        self.homocerc = homocerc
        self.intuitionalism = intuitionalism
        self.lophiostomate = lophiostomate
        self.nonbookish = nonbookish
        self.nonvolition = nonvolition
        self.palatableness = palatableness
        self.pimpery = pimpery
        self.previolation = previolation
        self.reconveyance = reconveyance
        self.registership = registership
        self.rhyacolite = rhyacolite
        self.smithereens = smithereens
        self.superedification = superedification
        self.trust = trust
        self.whitestone = whitestone
    }
}

// MARK: MonotheisticallyClass convenience initializers and mutators

public extension MonotheisticallyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MonotheisticallyClass.self, from: data)
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
        blaspheme: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        celiosalpingectomy: JSONNull?? = nil,
        chirotherium: Int?? = nil,
        consummativeness: JSONNull?? = nil,
        disdiapason: String?? = nil,
        egestive: JSONNull?? = nil,
        enchylema: JSONNull?? = nil,
        gasconade: JSONNull?? = nil,
        holidayer: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        intuitionalism: JSONNull?? = nil,
        lophiostomate: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        nonvolition: JSONNull?? = nil,
        palatableness: JSONNull?? = nil,
        pimpery: JSONNull?? = nil,
        previolation: JSONNull?? = nil,
        reconveyance: JSONNull?? = nil,
        registership: JSONNull?? = nil,
        rhyacolite: JSONNull?? = nil,
        smithereens: JSONNull?? = nil,
        superedification: JSONNull?? = nil,
        trust: JSONNull?? = nil,
        whitestone: JSONNull?? = nil
    ) -> MonotheisticallyClass {
        return MonotheisticallyClass(
            blaspheme: blaspheme ?? self.blaspheme,
            catharticalness: catharticalness ?? self.catharticalness,
            celiosalpingectomy: celiosalpingectomy ?? self.celiosalpingectomy,
            chirotherium: chirotherium ?? self.chirotherium,
            consummativeness: consummativeness ?? self.consummativeness,
            disdiapason: disdiapason ?? self.disdiapason,
            egestive: egestive ?? self.egestive,
            enchylema: enchylema ?? self.enchylema,
            gasconade: gasconade ?? self.gasconade,
            holidayer: holidayer ?? self.holidayer,
            homocerc: homocerc ?? self.homocerc,
            intuitionalism: intuitionalism ?? self.intuitionalism,
            lophiostomate: lophiostomate ?? self.lophiostomate,
            nonbookish: nonbookish ?? self.nonbookish,
            nonvolition: nonvolition ?? self.nonvolition,
            palatableness: palatableness ?? self.palatableness,
            pimpery: pimpery ?? self.pimpery,
            previolation: previolation ?? self.previolation,
            reconveyance: reconveyance ?? self.reconveyance,
            registership: registership ?? self.registership,
            rhyacolite: rhyacolite ?? self.rhyacolite,
            smithereens: smithereens ?? self.smithereens,
            superedification: superedification ?? self.superedification,
            trust: trust ?? self.trust,
            whitestone: whitestone ?? self.whitestone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Montage: Codable {
    case double(Double)
    case nullArray([JSONNull?])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Montage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Montage"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum Moralness: Codable {
    case double(Double)
    case nullArray([JSONNull?])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Moralness.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Moralness"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum Mulishly: Codable {
    case double(Double)
    case integerArray([Int])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Mulishly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Mulishly"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum Myoscope: Codable {
    case bool(Bool)
    case integer(Int)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        throw DecodingError.typeMismatch(Myoscope.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Myoscope"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum Neuromastic: Codable {
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
        throw DecodingError.typeMismatch(Neuromastic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Neuromastic"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Noncontributing
public struct Noncontributing: Codable {
    public let estevin: String
    public let jolterhead: Double
    public let sauternes: Int
    public let sparsely: Bool
    public let unrequested: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case estevin = "estevin"
        case jolterhead = "jolterhead"
        case sauternes = "sauternes"
        case sparsely = "sparsely"
        case unrequested = "unrequested"
    }

    public init(estevin: String, jolterhead: Double, sauternes: Int, sparsely: Bool, unrequested: JSONNull?) {
        self.estevin = estevin
        self.jolterhead = jolterhead
        self.sauternes = sauternes
        self.sparsely = sparsely
        self.unrequested = unrequested
    }
}

// MARK: Noncontributing convenience initializers and mutators

public extension Noncontributing {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Noncontributing.self, from: data)
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
        estevin: String? = nil,
        jolterhead: Double? = nil,
        sauternes: Int? = nil,
        sparsely: Bool? = nil,
        unrequested: JSONNull?? = nil
    ) -> Noncontributing {
        return Noncontributing(
            estevin: estevin ?? self.estevin,
            jolterhead: jolterhead ?? self.jolterhead,
            sauternes: sauternes ?? self.sauternes,
            sparsely: sparsely ?? self.sparsely,
            unrequested: unrequested ?? self.unrequested
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Nonnervous: Codable {
    case bool(Bool)
    case integer(Int)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        throw DecodingError.typeMismatch(Nonnervous.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Nonnervous"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

public enum Nonvaluation: Codable {
    case bool(Bool)
    case double(Double)
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
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Nonvaluation.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Nonvaluation"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum OccupationalistElement: Codable {
    case nullArray([JSONNull?])
    case occupationalistClass(OccupationalistClass)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(OccupationalistClass.self) {
            self = .occupationalistClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(OccupationalistElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OccupationalistElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .occupationalistClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - OccupationalistClass
public struct OccupationalistClass: Codable {
    public let beholdable: JSONNull?
    public let brotuliform: JSONNull?
    public let chimakum: JSONNull?
    public let doodler: JSONNull?
    public let emulsin: JSONNull?
    public let fin: JSONNull?
    public let flourishing: JSONNull?
    public let flueless: JSONNull?
    public let furtively: JSONNull?
    public let gritter: JSONNull?
    public let interwish: JSONNull?
    public let monoxylic: JSONNull?
    public let myristic: JSONNull?
    public let nightwear: JSONNull?
    public let peruser: JSONNull?
    public let theoastrological: JSONNull?
    public let thumby: JSONNull?
    public let tingitid: JSONNull?
    public let trailless: JSONNull?
    public let unpocketed: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case beholdable = "beholdable"
        case brotuliform = "brotuliform"
        case chimakum = "Chimakum"
        case doodler = "doodler"
        case emulsin = "emulsin"
        case fin = "Fin"
        case flourishing = "flourishing"
        case flueless = "flueless"
        case furtively = "furtively"
        case gritter = "gritter"
        case interwish = "interwish"
        case monoxylic = "monoxylic"
        case myristic = "myristic"
        case nightwear = "nightwear"
        case peruser = "peruser"
        case theoastrological = "theoastrological"
        case thumby = "thumby"
        case tingitid = "tingitid"
        case trailless = "trailless"
        case unpocketed = "unpocketed"
    }

    public init(beholdable: JSONNull?, brotuliform: JSONNull?, chimakum: JSONNull?, doodler: JSONNull?, emulsin: JSONNull?, fin: JSONNull?, flourishing: JSONNull?, flueless: JSONNull?, furtively: JSONNull?, gritter: JSONNull?, interwish: JSONNull?, monoxylic: JSONNull?, myristic: JSONNull?, nightwear: JSONNull?, peruser: JSONNull?, theoastrological: JSONNull?, thumby: JSONNull?, tingitid: JSONNull?, trailless: JSONNull?, unpocketed: JSONNull?) {
        self.beholdable = beholdable
        self.brotuliform = brotuliform
        self.chimakum = chimakum
        self.doodler = doodler
        self.emulsin = emulsin
        self.fin = fin
        self.flourishing = flourishing
        self.flueless = flueless
        self.furtively = furtively
        self.gritter = gritter
        self.interwish = interwish
        self.monoxylic = monoxylic
        self.myristic = myristic
        self.nightwear = nightwear
        self.peruser = peruser
        self.theoastrological = theoastrological
        self.thumby = thumby
        self.tingitid = tingitid
        self.trailless = trailless
        self.unpocketed = unpocketed
    }
}

// MARK: OccupationalistClass convenience initializers and mutators

public extension OccupationalistClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OccupationalistClass.self, from: data)
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
        beholdable: JSONNull?? = nil,
        brotuliform: JSONNull?? = nil,
        chimakum: JSONNull?? = nil,
        doodler: JSONNull?? = nil,
        emulsin: JSONNull?? = nil,
        fin: JSONNull?? = nil,
        flourishing: JSONNull?? = nil,
        flueless: JSONNull?? = nil,
        furtively: JSONNull?? = nil,
        gritter: JSONNull?? = nil,
        interwish: JSONNull?? = nil,
        monoxylic: JSONNull?? = nil,
        myristic: JSONNull?? = nil,
        nightwear: JSONNull?? = nil,
        peruser: JSONNull?? = nil,
        theoastrological: JSONNull?? = nil,
        thumby: JSONNull?? = nil,
        tingitid: JSONNull?? = nil,
        trailless: JSONNull?? = nil,
        unpocketed: JSONNull?? = nil
    ) -> OccupationalistClass {
        return OccupationalistClass(
            beholdable: beholdable ?? self.beholdable,
            brotuliform: brotuliform ?? self.brotuliform,
            chimakum: chimakum ?? self.chimakum,
            doodler: doodler ?? self.doodler,
            emulsin: emulsin ?? self.emulsin,
            fin: fin ?? self.fin,
            flourishing: flourishing ?? self.flourishing,
            flueless: flueless ?? self.flueless,
            furtively: furtively ?? self.furtively,
            gritter: gritter ?? self.gritter,
            interwish: interwish ?? self.interwish,
            monoxylic: monoxylic ?? self.monoxylic,
            myristic: myristic ?? self.myristic,
            nightwear: nightwear ?? self.nightwear,
            peruser: peruser ?? self.peruser,
            theoastrological: theoastrological ?? self.theoastrological,
            thumby: thumby ?? self.thumby,
            tingitid: tingitid ?? self.tingitid,
            trailless: trailless ?? self.trailless,
            unpocketed: unpocketed ?? self.unpocketed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum OutrivalElement: Codable {
    case double(Double)
    case outrivalClass(OutrivalClass)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(OutrivalClass.self) {
            self = .outrivalClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(OutrivalElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OutrivalElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .outrivalClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - OutrivalClass
public struct OutrivalClass: Codable {
    public let adroitly: JSONNull?
    public let bridehood: JSONNull?
    public let castoroides: JSONNull?
    public let czechoslovak: JSONNull?
    public let diagenesis: JSONNull?
    public let dihexahedron: JSONNull?
    public let dopester: JSONNull?
    public let eumerism: JSONNull?
    public let flyness: JSONNull?
    public let fouler: JSONNull?
    public let laudanosine: JSONNull?
    public let lingulidae: JSONNull?
    public let minutary: JSONNull?
    public let mitra: JSONNull?
    public let opisthorchiasis: JSONNull?
    public let pensively: JSONNull?
    public let pubigerous: JSONNull?
    public let rebellious: JSONNull?
    public let recodify: JSONNull?
    public let unpaced: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case adroitly = "adroitly"
        case bridehood = "bridehood"
        case castoroides = "Castoroides"
        case czechoslovak = "Czechoslovak"
        case diagenesis = "diagenesis"
        case dihexahedron = "dihexahedron"
        case dopester = "dopester"
        case eumerism = "eumerism"
        case flyness = "flyness"
        case fouler = "fouler"
        case laudanosine = "laudanosine"
        case lingulidae = "Lingulidae"
        case minutary = "minutary"
        case mitra = "mitra"
        case opisthorchiasis = "opisthorchiasis"
        case pensively = "pensively"
        case pubigerous = "pubigerous"
        case rebellious = "rebellious"
        case recodify = "recodify"
        case unpaced = "unpaced"
    }

    public init(adroitly: JSONNull?, bridehood: JSONNull?, castoroides: JSONNull?, czechoslovak: JSONNull?, diagenesis: JSONNull?, dihexahedron: JSONNull?, dopester: JSONNull?, eumerism: JSONNull?, flyness: JSONNull?, fouler: JSONNull?, laudanosine: JSONNull?, lingulidae: JSONNull?, minutary: JSONNull?, mitra: JSONNull?, opisthorchiasis: JSONNull?, pensively: JSONNull?, pubigerous: JSONNull?, rebellious: JSONNull?, recodify: JSONNull?, unpaced: JSONNull?) {
        self.adroitly = adroitly
        self.bridehood = bridehood
        self.castoroides = castoroides
        self.czechoslovak = czechoslovak
        self.diagenesis = diagenesis
        self.dihexahedron = dihexahedron
        self.dopester = dopester
        self.eumerism = eumerism
        self.flyness = flyness
        self.fouler = fouler
        self.laudanosine = laudanosine
        self.lingulidae = lingulidae
        self.minutary = minutary
        self.mitra = mitra
        self.opisthorchiasis = opisthorchiasis
        self.pensively = pensively
        self.pubigerous = pubigerous
        self.rebellious = rebellious
        self.recodify = recodify
        self.unpaced = unpaced
    }
}

// MARK: OutrivalClass convenience initializers and mutators

public extension OutrivalClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OutrivalClass.self, from: data)
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
        adroitly: JSONNull?? = nil,
        bridehood: JSONNull?? = nil,
        castoroides: JSONNull?? = nil,
        czechoslovak: JSONNull?? = nil,
        diagenesis: JSONNull?? = nil,
        dihexahedron: JSONNull?? = nil,
        dopester: JSONNull?? = nil,
        eumerism: JSONNull?? = nil,
        flyness: JSONNull?? = nil,
        fouler: JSONNull?? = nil,
        laudanosine: JSONNull?? = nil,
        lingulidae: JSONNull?? = nil,
        minutary: JSONNull?? = nil,
        mitra: JSONNull?? = nil,
        opisthorchiasis: JSONNull?? = nil,
        pensively: JSONNull?? = nil,
        pubigerous: JSONNull?? = nil,
        rebellious: JSONNull?? = nil,
        recodify: JSONNull?? = nil,
        unpaced: JSONNull?? = nil
    ) -> OutrivalClass {
        return OutrivalClass(
            adroitly: adroitly ?? self.adroitly,
            bridehood: bridehood ?? self.bridehood,
            castoroides: castoroides ?? self.castoroides,
            czechoslovak: czechoslovak ?? self.czechoslovak,
            diagenesis: diagenesis ?? self.diagenesis,
            dihexahedron: dihexahedron ?? self.dihexahedron,
            dopester: dopester ?? self.dopester,
            eumerism: eumerism ?? self.eumerism,
            flyness: flyness ?? self.flyness,
            fouler: fouler ?? self.fouler,
            laudanosine: laudanosine ?? self.laudanosine,
            lingulidae: lingulidae ?? self.lingulidae,
            minutary: minutary ?? self.minutary,
            mitra: mitra ?? self.mitra,
            opisthorchiasis: opisthorchiasis ?? self.opisthorchiasis,
            pensively: pensively ?? self.pensively,
            pubigerous: pubigerous ?? self.pubigerous,
            rebellious: rebellious ?? self.rebellious,
            recodify: recodify ?? self.recodify,
            unpaced: unpaced ?? self.unpaced
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Paleographically: Codable {
    case double(Double)
    case unionMap([String: Int?])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: Int?].self) {
            self = .unionMap(x)
            return
        }
        throw DecodingError.typeMismatch(Paleographically.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Paleographically"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

public enum Pamphletwise: Codable {
    case integer(Int)
    case integerMap([String: Int])
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
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
        throw DecodingError.typeMismatch(Pamphletwise.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pamphletwise"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum Pediatric: Codable {
    case bool(Bool)
    case double(Double)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Pediatric.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pediatric"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum PiaculumElement: Codable {
    case double(Double)
    case piaculumClass(PiaculumClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(PiaculumClass.self) {
            self = .piaculumClass(x)
            return
        }
        throw DecodingError.typeMismatch(PiaculumElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PiaculumElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .piaculumClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PiaculumClass
public struct PiaculumClass: Codable {
    public let alada: Int?
    public let amphistomous: Int?
    public let boysenberry: Int?
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let decardinalize: Int?
    public let discouragement: Int?
    public let disdiapason: String?
    public let doitrified: Int?
    public let hexaspermous: Int?
    public let homocerc: Bool?
    public let insinking: Int?
    public let loathfulness: Int?
    public let miasmatical: Int?
    public let neurofibril: Int?
    public let nonbookish: JSONNull?
    public let phonendoscope: Int?
    public let pilferment: Int?
    public let predismissory: Int?
    public let preinscription: Int?
    public let quotative: Int?
    public let sienna: Int?
    public let thorax: Int?
    public let yachting: Int?
    public let zipper: Int?

    public enum CodingKeys: String, CodingKey {
        case alada = "alada"
        case amphistomous = "amphistomous"
        case boysenberry = "boysenberry"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case decardinalize = "decardinalize"
        case discouragement = "discouragement"
        case disdiapason = "disdiapason"
        case doitrified = "doitrified"
        case hexaspermous = "hexaspermous"
        case homocerc = "homocerc"
        case insinking = "insinking"
        case loathfulness = "loathfulness"
        case miasmatical = "miasmatical"
        case neurofibril = "neurofibril"
        case nonbookish = "nonbookish"
        case phonendoscope = "phonendoscope"
        case pilferment = "pilferment"
        case predismissory = "predismissory"
        case preinscription = "preinscription"
        case quotative = "quotative"
        case sienna = "sienna"
        case thorax = "thorax"
        case yachting = "yachting"
        case zipper = "Zipper"
    }

    public init(alada: Int?, amphistomous: Int?, boysenberry: Int?, catharticalness: Double?, chirotherium: Int?, decardinalize: Int?, discouragement: Int?, disdiapason: String?, doitrified: Int?, hexaspermous: Int?, homocerc: Bool?, insinking: Int?, loathfulness: Int?, miasmatical: Int?, neurofibril: Int?, nonbookish: JSONNull?, phonendoscope: Int?, pilferment: Int?, predismissory: Int?, preinscription: Int?, quotative: Int?, sienna: Int?, thorax: Int?, yachting: Int?, zipper: Int?) {
        self.alada = alada
        self.amphistomous = amphistomous
        self.boysenberry = boysenberry
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.decardinalize = decardinalize
        self.discouragement = discouragement
        self.disdiapason = disdiapason
        self.doitrified = doitrified
        self.hexaspermous = hexaspermous
        self.homocerc = homocerc
        self.insinking = insinking
        self.loathfulness = loathfulness
        self.miasmatical = miasmatical
        self.neurofibril = neurofibril
        self.nonbookish = nonbookish
        self.phonendoscope = phonendoscope
        self.pilferment = pilferment
        self.predismissory = predismissory
        self.preinscription = preinscription
        self.quotative = quotative
        self.sienna = sienna
        self.thorax = thorax
        self.yachting = yachting
        self.zipper = zipper
    }
}

// MARK: PiaculumClass convenience initializers and mutators

public extension PiaculumClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PiaculumClass.self, from: data)
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
        alada: Int?? = nil,
        amphistomous: Int?? = nil,
        boysenberry: Int?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        decardinalize: Int?? = nil,
        discouragement: Int?? = nil,
        disdiapason: String?? = nil,
        doitrified: Int?? = nil,
        hexaspermous: Int?? = nil,
        homocerc: Bool?? = nil,
        insinking: Int?? = nil,
        loathfulness: Int?? = nil,
        miasmatical: Int?? = nil,
        neurofibril: Int?? = nil,
        nonbookish: JSONNull?? = nil,
        phonendoscope: Int?? = nil,
        pilferment: Int?? = nil,
        predismissory: Int?? = nil,
        preinscription: Int?? = nil,
        quotative: Int?? = nil,
        sienna: Int?? = nil,
        thorax: Int?? = nil,
        yachting: Int?? = nil,
        zipper: Int?? = nil
    ) -> PiaculumClass {
        return PiaculumClass(
            alada: alada ?? self.alada,
            amphistomous: amphistomous ?? self.amphistomous,
            boysenberry: boysenberry ?? self.boysenberry,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            decardinalize: decardinalize ?? self.decardinalize,
            discouragement: discouragement ?? self.discouragement,
            disdiapason: disdiapason ?? self.disdiapason,
            doitrified: doitrified ?? self.doitrified,
            hexaspermous: hexaspermous ?? self.hexaspermous,
            homocerc: homocerc ?? self.homocerc,
            insinking: insinking ?? self.insinking,
            loathfulness: loathfulness ?? self.loathfulness,
            miasmatical: miasmatical ?? self.miasmatical,
            neurofibril: neurofibril ?? self.neurofibril,
            nonbookish: nonbookish ?? self.nonbookish,
            phonendoscope: phonendoscope ?? self.phonendoscope,
            pilferment: pilferment ?? self.pilferment,
            predismissory: predismissory ?? self.predismissory,
            preinscription: preinscription ?? self.preinscription,
            quotative: quotative ?? self.quotative,
            sienna: sienna ?? self.sienna,
            thorax: thorax ?? self.thorax,
            yachting: yachting ?? self.yachting,
            zipper: zipper ?? self.zipper
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Piccadilly: Codable {
    case double(Double)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Piccadilly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Piccadilly"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum Piffler: Codable {
    case monaziteClass(MonaziteClass)
    case nullArray([JSONNull?])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Piffler.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Piffler"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .monaziteClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum Pithful: Codable {
    case bool(Bool)
    case integer(Int)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Pithful.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pithful"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum Placuntiti: Codable {
    case integer(Int)
    case integerMap([String: Int])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([String: Int].self) {
            self = .integerMap(x)
            return
        }
        throw DecodingError.typeMismatch(Placuntiti.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Placuntiti"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

public enum Plectopterous: Codable {
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
        throw DecodingError.typeMismatch(Plectopterous.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plectopterous"))
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

// MARK: - Pneumocele
public struct Pneumocele: Codable {
    public let carbonarism: JSONNull?
    public let catharticalness: Double?
    public let chirotherium: Int?
    public let cineolic: JSONNull?
    public let cobbly: JSONNull?
    public let conchyliferous: JSONNull?
    public let congregation: JSONNull?
    public let disdiapason: String?
    public let enterotomy: JSONNull?
    public let entophytal: JSONNull?
    public let fewtrils: JSONNull?
    public let herem: JSONNull?
    public let homocerc: Bool?
    public let koniga: JSONNull?
    public let meticulosity: JSONNull?
    public let micky: JSONNull?
    public let mismarriage: JSONNull?
    public let neurotrophic: JSONNull?
    public let nonbookish: JSONNull?
    public let persuasively: JSONNull?
    public let replaceable: JSONNull?
    public let silex: JSONNull?
    public let taillight: JSONNull?
    public let unjealous: JSONNull?
    public let visitorial: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case carbonarism = "Carbonarism"
        case catharticalness = "catharticalness"
        case chirotherium = "Chirotherium"
        case cineolic = "cineolic"
        case cobbly = "cobbly"
        case conchyliferous = "conchyliferous"
        case congregation = "congregation"
        case disdiapason = "disdiapason"
        case enterotomy = "enterotomy"
        case entophytal = "entophytal"
        case fewtrils = "fewtrils"
        case herem = "herem"
        case homocerc = "homocerc"
        case koniga = "Koniga"
        case meticulosity = "meticulosity"
        case micky = "Micky"
        case mismarriage = "mismarriage"
        case neurotrophic = "neurotrophic"
        case nonbookish = "nonbookish"
        case persuasively = "persuasively"
        case replaceable = "replaceable"
        case silex = "silex"
        case taillight = "taillight"
        case unjealous = "unjealous"
        case visitorial = "visitorial"
    }

    public init(carbonarism: JSONNull?, catharticalness: Double?, chirotherium: Int?, cineolic: JSONNull?, cobbly: JSONNull?, conchyliferous: JSONNull?, congregation: JSONNull?, disdiapason: String?, enterotomy: JSONNull?, entophytal: JSONNull?, fewtrils: JSONNull?, herem: JSONNull?, homocerc: Bool?, koniga: JSONNull?, meticulosity: JSONNull?, micky: JSONNull?, mismarriage: JSONNull?, neurotrophic: JSONNull?, nonbookish: JSONNull?, persuasively: JSONNull?, replaceable: JSONNull?, silex: JSONNull?, taillight: JSONNull?, unjealous: JSONNull?, visitorial: JSONNull?) {
        self.carbonarism = carbonarism
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.cineolic = cineolic
        self.cobbly = cobbly
        self.conchyliferous = conchyliferous
        self.congregation = congregation
        self.disdiapason = disdiapason
        self.enterotomy = enterotomy
        self.entophytal = entophytal
        self.fewtrils = fewtrils
        self.herem = herem
        self.homocerc = homocerc
        self.koniga = koniga
        self.meticulosity = meticulosity
        self.micky = micky
        self.mismarriage = mismarriage
        self.neurotrophic = neurotrophic
        self.nonbookish = nonbookish
        self.persuasively = persuasively
        self.replaceable = replaceable
        self.silex = silex
        self.taillight = taillight
        self.unjealous = unjealous
        self.visitorial = visitorial
    }
}

// MARK: Pneumocele convenience initializers and mutators

public extension Pneumocele {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pneumocele.self, from: data)
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
        carbonarism: JSONNull?? = nil,
        catharticalness: Double?? = nil,
        chirotherium: Int?? = nil,
        cineolic: JSONNull?? = nil,
        cobbly: JSONNull?? = nil,
        conchyliferous: JSONNull?? = nil,
        congregation: JSONNull?? = nil,
        disdiapason: String?? = nil,
        enterotomy: JSONNull?? = nil,
        entophytal: JSONNull?? = nil,
        fewtrils: JSONNull?? = nil,
        herem: JSONNull?? = nil,
        homocerc: Bool?? = nil,
        koniga: JSONNull?? = nil,
        meticulosity: JSONNull?? = nil,
        micky: JSONNull?? = nil,
        mismarriage: JSONNull?? = nil,
        neurotrophic: JSONNull?? = nil,
        nonbookish: JSONNull?? = nil,
        persuasively: JSONNull?? = nil,
        replaceable: JSONNull?? = nil,
        silex: JSONNull?? = nil,
        taillight: JSONNull?? = nil,
        unjealous: JSONNull?? = nil,
        visitorial: JSONNull?? = nil
    ) -> Pneumocele {
        return Pneumocele(
            carbonarism: carbonarism ?? self.carbonarism,
            catharticalness: catharticalness ?? self.catharticalness,
            chirotherium: chirotherium ?? self.chirotherium,
            cineolic: cineolic ?? self.cineolic,
            cobbly: cobbly ?? self.cobbly,
            conchyliferous: conchyliferous ?? self.conchyliferous,
            congregation: congregation ?? self.congregation,
            disdiapason: disdiapason ?? self.disdiapason,
            enterotomy: enterotomy ?? self.enterotomy,
            entophytal: entophytal ?? self.entophytal,
            fewtrils: fewtrils ?? self.fewtrils,
            herem: herem ?? self.herem,
            homocerc: homocerc ?? self.homocerc,
            koniga: koniga ?? self.koniga,
            meticulosity: meticulosity ?? self.meticulosity,
            micky: micky ?? self.micky,
            mismarriage: mismarriage ?? self.mismarriage,
            neurotrophic: neurotrophic ?? self.neurotrophic,
            nonbookish: nonbookish ?? self.nonbookish,
            persuasively: persuasively ?? self.persuasively,
            replaceable: replaceable ?? self.replaceable,
            silex: silex ?? self.silex,
            taillight: taillight ?? self.taillight,
            unjealous: unjealous ?? self.unjealous,
            visitorial: visitorial ?? self.visitorial
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Poliorcetic: Codable {
    case bool(Bool)
    case monaziteClass(MonaziteClass)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Poliorcetic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Poliorcetic"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .monaziteClass(let x):
            try container.encode(x)
        }
    }
}

public enum Poormaster: Codable {
    case integerArray([Int])
    case integerMap([String: Int])
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
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
        throw DecodingError.typeMismatch(Poormaster.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Poormaster"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

public enum PotwhiskyElement: Codable {
    case integer(Int)
    case potwhiskyClass(PotwhiskyClass)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(PotwhiskyClass.self) {
            self = .potwhiskyClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(PotwhiskyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PotwhiskyElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .potwhiskyClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - PotwhiskyClass
public struct PotwhiskyClass: Codable {
    public let arciform: JSONNull?
    public let cresolin: JSONNull?
    public let disheartener: JSONNull?
    public let disproportionable: JSONNull?
    public let euchorda: JSONNull?
    public let ferryway: JSONNull?
    public let filamentiferous: JSONNull?
    public let flemish: JSONNull?
    public let forgainst: JSONNull?
    public let grainering: JSONNull?
    public let irrevoluble: JSONNull?
    public let kindredship: JSONNull?
    public let pinguitudinous: JSONNull?
    public let simpletonic: JSONNull?
    public let singsong: JSONNull?
    public let submergement: JSONNull?
    public let supraoesophagal: JSONNull?
    public let thrashel: JSONNull?
    public let tyremesis: JSONNull?
    public let yoruba: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case arciform = "arciform"
        case cresolin = "cresolin"
        case disheartener = "disheartener"
        case disproportionable = "disproportionable"
        case euchorda = "Euchorda"
        case ferryway = "ferryway"
        case filamentiferous = "filamentiferous"
        case flemish = "flemish"
        case forgainst = "forgainst"
        case grainering = "grainering"
        case irrevoluble = "irrevoluble"
        case kindredship = "kindredship"
        case pinguitudinous = "pinguitudinous"
        case simpletonic = "simpletonic"
        case singsong = "singsong"
        case submergement = "submergement"
        case supraoesophagal = "supraoesophagal"
        case thrashel = "thrashel"
        case tyremesis = "tyremesis"
        case yoruba = "Yoruba"
    }

    public init(arciform: JSONNull?, cresolin: JSONNull?, disheartener: JSONNull?, disproportionable: JSONNull?, euchorda: JSONNull?, ferryway: JSONNull?, filamentiferous: JSONNull?, flemish: JSONNull?, forgainst: JSONNull?, grainering: JSONNull?, irrevoluble: JSONNull?, kindredship: JSONNull?, pinguitudinous: JSONNull?, simpletonic: JSONNull?, singsong: JSONNull?, submergement: JSONNull?, supraoesophagal: JSONNull?, thrashel: JSONNull?, tyremesis: JSONNull?, yoruba: JSONNull?) {
        self.arciform = arciform
        self.cresolin = cresolin
        self.disheartener = disheartener
        self.disproportionable = disproportionable
        self.euchorda = euchorda
        self.ferryway = ferryway
        self.filamentiferous = filamentiferous
        self.flemish = flemish
        self.forgainst = forgainst
        self.grainering = grainering
        self.irrevoluble = irrevoluble
        self.kindredship = kindredship
        self.pinguitudinous = pinguitudinous
        self.simpletonic = simpletonic
        self.singsong = singsong
        self.submergement = submergement
        self.supraoesophagal = supraoesophagal
        self.thrashel = thrashel
        self.tyremesis = tyremesis
        self.yoruba = yoruba
    }
}

// MARK: PotwhiskyClass convenience initializers and mutators

public extension PotwhiskyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PotwhiskyClass.self, from: data)
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
        arciform: JSONNull?? = nil,
        cresolin: JSONNull?? = nil,
        disheartener: JSONNull?? = nil,
        disproportionable: JSONNull?? = nil,
        euchorda: JSONNull?? = nil,
        ferryway: JSONNull?? = nil,
        filamentiferous: JSONNull?? = nil,
        flemish: JSONNull?? = nil,
        forgainst: JSONNull?? = nil,
        grainering: JSONNull?? = nil,
        irrevoluble: JSONNull?? = nil,
        kindredship: JSONNull?? = nil,
        pinguitudinous: JSONNull?? = nil,
        simpletonic: JSONNull?? = nil,
        singsong: JSONNull?? = nil,
        submergement: JSONNull?? = nil,
        supraoesophagal: JSONNull?? = nil,
        thrashel: JSONNull?? = nil,
        tyremesis: JSONNull?? = nil,
        yoruba: JSONNull?? = nil
    ) -> PotwhiskyClass {
        return PotwhiskyClass(
            arciform: arciform ?? self.arciform,
            cresolin: cresolin ?? self.cresolin,
            disheartener: disheartener ?? self.disheartener,
            disproportionable: disproportionable ?? self.disproportionable,
            euchorda: euchorda ?? self.euchorda,
            ferryway: ferryway ?? self.ferryway,
            filamentiferous: filamentiferous ?? self.filamentiferous,
            flemish: flemish ?? self.flemish,
            forgainst: forgainst ?? self.forgainst,
            grainering: grainering ?? self.grainering,
            irrevoluble: irrevoluble ?? self.irrevoluble,
            kindredship: kindredship ?? self.kindredship,
            pinguitudinous: pinguitudinous ?? self.pinguitudinous,
            simpletonic: simpletonic ?? self.simpletonic,
            singsong: singsong ?? self.singsong,
            submergement: submergement ?? self.submergement,
            supraoesophagal: supraoesophagal ?? self.supraoesophagal,
            thrashel: thrashel ?? self.thrashel,
            tyremesis: tyremesis ?? self.tyremesis,
            yoruba: yoruba ?? self.yoruba
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Practicalizer: Codable {
    case monaziteClass(MonaziteClass)
    case nullArray([JSONNull?])
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Practicalizer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Practicalizer"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .monaziteClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public enum PrefreshmanElement: Codable {
    case nullArray([JSONNull?])
    case prefreshmanClass(PrefreshmanClass)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(PrefreshmanClass.self) {
            self = .prefreshmanClass(x)
            return
        }
        throw DecodingError.typeMismatch(PrefreshmanElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PrefreshmanElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nullArray(let x):
            try container.encode(x)
        case .prefreshmanClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PrefreshmanClass
public struct PrefreshmanClass: Codable {
    public let azorubine: JSONNull?
    public let choroiditis: JSONNull?
    public let coagulatory: JSONNull?
    public let cyclorama: JSONNull?
    public let dolphus: JSONNull?
    public let duckhearted: JSONNull?
    public let ficus: JSONNull?
    public let gemaric: JSONNull?
    public let jugation: JSONNull?
    public let myoliposis: JSONNull?
    public let nonnomination: JSONNull?
    public let palay: JSONNull?
    public let pentactinal: JSONNull?
    public let phaet: JSONNull?
    public let piquant: JSONNull?
    public let registration: JSONNull?
    public let remancipation: JSONNull?
    public let scutatiform: JSONNull?
    public let theodolite: JSONNull?
    public let underward: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case azorubine = "azorubine"
        case choroiditis = "choroiditis"
        case coagulatory = "coagulatory"
        case cyclorama = "cyclorama"
        case dolphus = "Dolphus"
        case duckhearted = "duckhearted"
        case ficus = "Ficus"
        case gemaric = "Gemaric"
        case jugation = "jugation"
        case myoliposis = "myoliposis"
        case nonnomination = "nonnomination"
        case palay = "palay"
        case pentactinal = "pentactinal"
        case phaet = "Phaet"
        case piquant = "piquant"
        case registration = "registration"
        case remancipation = "remancipation"
        case scutatiform = "scutatiform"
        case theodolite = "theodolite"
        case underward = "underward"
    }

    public init(azorubine: JSONNull?, choroiditis: JSONNull?, coagulatory: JSONNull?, cyclorama: JSONNull?, dolphus: JSONNull?, duckhearted: JSONNull?, ficus: JSONNull?, gemaric: JSONNull?, jugation: JSONNull?, myoliposis: JSONNull?, nonnomination: JSONNull?, palay: JSONNull?, pentactinal: JSONNull?, phaet: JSONNull?, piquant: JSONNull?, registration: JSONNull?, remancipation: JSONNull?, scutatiform: JSONNull?, theodolite: JSONNull?, underward: JSONNull?) {
        self.azorubine = azorubine
        self.choroiditis = choroiditis
        self.coagulatory = coagulatory
        self.cyclorama = cyclorama
        self.dolphus = dolphus
        self.duckhearted = duckhearted
        self.ficus = ficus
        self.gemaric = gemaric
        self.jugation = jugation
        self.myoliposis = myoliposis
        self.nonnomination = nonnomination
        self.palay = palay
        self.pentactinal = pentactinal
        self.phaet = phaet
        self.piquant = piquant
        self.registration = registration
        self.remancipation = remancipation
        self.scutatiform = scutatiform
        self.theodolite = theodolite
        self.underward = underward
    }
}

// MARK: PrefreshmanClass convenience initializers and mutators

public extension PrefreshmanClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PrefreshmanClass.self, from: data)
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
        azorubine: JSONNull?? = nil,
        choroiditis: JSONNull?? = nil,
        coagulatory: JSONNull?? = nil,
        cyclorama: JSONNull?? = nil,
        dolphus: JSONNull?? = nil,
        duckhearted: JSONNull?? = nil,
        ficus: JSONNull?? = nil,
        gemaric: JSONNull?? = nil,
        jugation: JSONNull?? = nil,
        myoliposis: JSONNull?? = nil,
        nonnomination: JSONNull?? = nil,
        palay: JSONNull?? = nil,
        pentactinal: JSONNull?? = nil,
        phaet: JSONNull?? = nil,
        piquant: JSONNull?? = nil,
        registration: JSONNull?? = nil,
        remancipation: JSONNull?? = nil,
        scutatiform: JSONNull?? = nil,
        theodolite: JSONNull?? = nil,
        underward: JSONNull?? = nil
    ) -> PrefreshmanClass {
        return PrefreshmanClass(
            azorubine: azorubine ?? self.azorubine,
            choroiditis: choroiditis ?? self.choroiditis,
            coagulatory: coagulatory ?? self.coagulatory,
            cyclorama: cyclorama ?? self.cyclorama,
            dolphus: dolphus ?? self.dolphus,
            duckhearted: duckhearted ?? self.duckhearted,
            ficus: ficus ?? self.ficus,
            gemaric: gemaric ?? self.gemaric,
            jugation: jugation ?? self.jugation,
            myoliposis: myoliposis ?? self.myoliposis,
            nonnomination: nonnomination ?? self.nonnomination,
            palay: palay ?? self.palay,
            pentactinal: pentactinal ?? self.pentactinal,
            phaet: phaet ?? self.phaet,
            piquant: piquant ?? self.piquant,
            registration: registration ?? self.registration,
            remancipation: remancipation ?? self.remancipation,
            scutatiform: scutatiform ?? self.scutatiform,
            theodolite: theodolite ?? self.theodolite,
            underward: underward ?? self.underward
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

public enum Prehensility: Codable {
    case bool(Bool)
    case monaziteClass(MonaziteClass)
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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Prehensility.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Prehensility"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .monaziteClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

public enum Prevoidance: Codable {
    case integer(Int)
    case integerArray([Int])
    case monaziteClass(MonaziteClass)

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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Prevoidance.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Prevoidance"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .monaziteClass(let x):
            try container.encode(x)
        }
    }
}

public enum Protext: Codable {
    case bool(Bool)
    case integerArray([Int])
    case monaziteClass(MonaziteClass)

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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Protext.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Protext"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .monaziteClass(let x):
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
