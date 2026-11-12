// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let juror: [JurorElement]
    let kongoni: [Kongoni]
    let ladronism: [LadronismElement]
    let landlubberly: [LandlubberlyElement]
    let listener: [Listener]
    let lupus: [LupusElement]
    let maslin: [Maslin]
    let monazite: [MonaziteElement]
    let monoliteral: [Monoliteral]
    let monotheistically: [MonotheisticallyElement]
    let montage: [Montage]
    let moralness: [Moralness]
    let mowra: [MonaziteClass?]
    let mulishly: [Mulishly]
    let myoscope: [Myoscope]
    let nach: [[Int?]?]
    let neuromastic: [Neuromastic]
    let noncontributing: [Noncontributing]
    let nonnervous: [Nonnervous]
    let nonvaluation: [Nonvaluation]
    let occupationalist: [OccupationalistElement]
    let outrival: [OutrivalElement]
    let paleographically: [Paleographically]
    let pamphletwise: [Pamphletwise]
    let pediatrics: [Pediatric]
    let perceptive: [Bool]
    let piaculum: [PiaculumElement]
    let piccadilly: [Piccadilly]
    let piffler: [Piffler]
    let pithful: [Pithful]
    let placuntitis: [Placuntiti]
    let plectopterous: [Plectopterous]
    let pneumocele: [Pneumocele?]
    let poliorcetic: [Poliorcetic]
    let poormaster: [Poormaster]
    let potwhisky: [PotwhiskyElement]
    let practicalizer: [Practicalizer]
    let prefreshman: [PrefreshmanElement]
    let prehensility: [Prehensility]
    let prevoidance: [Prevoidance]
    let probant: [[String: Int?]]
    let protext: [Protext]
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

enum JurorElement: Codable {
    case bool(Bool)
    case jurorClass(JurorClass)

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct JurorClass: Codable {
    let adipsy, auxiliator, benda, benjamin: JSONNull?
    let brandling, epicurishly, eremochaetous, marten: JSONNull?
    let monocline, olea, palgat, pennyworth: JSONNull?
    let pioury, pragmatistic, stylelessness, systematical: JSONNull?
    let thready, uncontemporary, uncouched, uninhabitedness: JSONNull?

    enum CodingKeys: String, CodingKey {
        case adipsy, auxiliator, benda, benjamin, brandling, epicurishly, eremochaetous, marten, monocline
        case olea = "Olea"
        case palgat, pennyworth, pioury, pragmatistic, stylelessness, systematical, thready, uncontemporary, uncouched, uninhabitedness
    }
}

// MARK: JurorClass convenience initializers and mutators

extension JurorClass {
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

enum Kongoni: Codable {
    case integerArray([Int])
    case integerMap([String: Int])

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
        throw DecodingError.typeMismatch(Kongoni.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Kongoni"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerArray(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum LadronismElement: Codable {
    case double(Double)
    case ladronismClass(LadronismClass)
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
        if let x = try? container.decode(LadronismClass.self) {
            self = .ladronismClass(x)
            return
        }
        throw DecodingError.typeMismatch(LadronismElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LadronismElement"))
    }

    func encode(to encoder: Encoder) throws {
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
struct LadronismClass: Codable {
    let acclaimer, achree, base, conundrumize: JSONNull?
    let degerminator, describable, exasperatedly, heroine: JSONNull?
    let indazin, luteous, papular, pritch: JSONNull?
    let prodenia, seege, shopgirl, tragedietta: JSONNull?
    let unsparse, uplook, vermiformis, whafabout: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acclaimer, achree, base, conundrumize, degerminator, describable, exasperatedly, heroine, indazin, luteous, papular, pritch
        case prodenia = "Prodenia"
        case seege, shopgirl, tragedietta, unsparse, uplook, vermiformis, whafabout
    }
}

// MARK: LadronismClass convenience initializers and mutators

extension LadronismClass {
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

enum LandlubberlyElement: Codable {
    case bool(Bool)
    case integer(Int)
    case landlubberlyClass(LandlubberlyClass)

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
        if let x = try? container.decode(LandlubberlyClass.self) {
            self = .landlubberlyClass(x)
            return
        }
        throw DecodingError.typeMismatch(LandlubberlyElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LandlubberlyElement"))
    }

    func encode(to encoder: Encoder) throws {
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
struct LandlubberlyClass: Codable {
    let acropoleis, aminate, amyraldism, bipenniform: JSONNull?
    let bugre, calycule, caoutchouc, disprover: JSONNull?
    let fitroot, fulgently, kickup, laevoversion: JSONNull?
    let moter, objectivity, posterity, postnuptial: JSONNull?
    let precedentary, saddling, subcurrent, unrecriminative: JSONNull?

    enum CodingKeys: String, CodingKey {
        case acropoleis, aminate
        case amyraldism = "Amyraldism"
        case bipenniform, bugre, calycule, caoutchouc, disprover, fitroot, fulgently, kickup, laevoversion, moter, objectivity, posterity, postnuptial, precedentary, saddling, subcurrent, unrecriminative
    }
}

// MARK: LandlubberlyClass convenience initializers and mutators

extension LandlubberlyClass {
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

enum Listener: Codable {
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
        throw DecodingError.typeMismatch(Listener.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Listener"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum LupusElement: Codable {
    case integer(Int)
    case lupusClass(LupusClass)

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct LupusClass: Codable {
    let catharticalness: Double?
    let chirotherium, chlorioninae, corvinae, crassina: Int?
    let disdiapason: String?
    let exiguity, farcist, holographical: Int?
    let homocerc: Bool?
    let ichthyophagan, implacable: Int?
    let nonbookish: JSONNull?
    let outshiner, overweather, protonegroid, shallowish: Int?
    let snoke, snout, surveillance, threshingtime: Int?
    let thysanocarpus, unsignificantly, unsnap, vendible: Int?

    enum CodingKeys: String, CodingKey {
        case catharticalness
        case chirotherium = "Chirotherium"
        case chlorioninae = "Chlorioninae"
        case corvinae = "Corvinae"
        case crassina = "Crassina"
        case disdiapason, exiguity, farcist, holographical, homocerc, ichthyophagan, implacable, nonbookish, outshiner, overweather, protonegroid, shallowish, snoke, snout, surveillance, threshingtime
        case thysanocarpus = "Thysanocarpus"
        case unsignificantly, unsnap, vendible
    }
}

// MARK: LupusClass convenience initializers and mutators

extension LupusClass {
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
struct Maslin: Codable {
    let alicant: Int?
    let antiatonement: JSONNull?
    let anticorrosive: Int?
    let aphidozer, bakuninist: JSONNull?
    let be: Int?
    let catharticalness: Double?
    let chirotherium, chub, cuprosilicon, curtailedly: Int?
    let dellenite, dimitry: Int?
    let disdiapason: String?
    let edifying: JSONNull?
    let ethmoiditis: Int?
    let gastralgy: JSONNull?
    let goatherd, hammerdress: Int?
    let hangfire: JSONNull?
    let homocerc: Bool?
    let lacunosity: Int?
    let longiloquence: JSONNull?
    let mameliere: Int?
    let motherless, nonbookish, noncorrodible, nonsensicality: JSONNull?
    let oafishly: Int?
    let pfund, preadvisory, retroflexed: JSONNull?
    let saccharulmic, scowlful: Int?
    let secluded, slackage: JSONNull?
    let sphaeridial: Int?
    let spondulics: JSONNull?
    let subsecive: Int?
    let swellmobsman: JSONNull?
    let trachyglossate: Int?
    let trialogue: JSONNull?
    let unassuaged: Int?
    let ungross, unjudiciously: JSONNull?

    enum CodingKeys: String, CodingKey {
        case alicant = "Alicant"
        case antiatonement, anticorrosive, aphidozer
        case bakuninist = "Bakuninist"
        case be, catharticalness
        case chirotherium = "Chirotherium"
        case chub, cuprosilicon, curtailedly, dellenite
        case dimitry = "Dimitry"
        case disdiapason, edifying, ethmoiditis, gastralgy, goatherd, hammerdress, hangfire, homocerc, lacunosity, longiloquence, mameliere, motherless, nonbookish, noncorrodible, nonsensicality, oafishly, pfund, preadvisory, retroflexed, saccharulmic, scowlful, secluded, slackage, sphaeridial, spondulics, subsecive, swellmobsman, trachyglossate, trialogue, unassuaged, ungross, unjudiciously
    }
}

// MARK: Maslin convenience initializers and mutators

extension Maslin {
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

enum MonaziteElement: Codable {
    case double(Double)
    case monaziteClass(MonaziteClass)

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct MonaziteClass: Codable {
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

// MARK: MonaziteClass convenience initializers and mutators

extension MonaziteClass {
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

enum Monoliteral: Codable {
    case bool(Bool)
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
        throw DecodingError.typeMismatch(Monoliteral.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Monoliteral"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum MonotheisticallyElement: Codable {
    case monotheisticallyClass(MonotheisticallyClass)
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct MonotheisticallyClass: Codable {
    let blaspheme: JSONNull?
    let catharticalness: Double?
    let celiosalpingectomy: JSONNull?
    let chirotherium: Int?
    let consummativeness: JSONNull?
    let disdiapason: String?
    let egestive, enchylema, gasconade, holidayer: JSONNull?
    let homocerc: Bool?
    let intuitionalism, lophiostomate, nonbookish, nonvolition: JSONNull?
    let palatableness, pimpery, previolation, reconveyance: JSONNull?
    let registership, rhyacolite, smithereens, superedification: JSONNull?
    let trust, whitestone: JSONNull?

    enum CodingKeys: String, CodingKey {
        case blaspheme, catharticalness, celiosalpingectomy
        case chirotherium = "Chirotherium"
        case consummativeness, disdiapason, egestive, enchylema, gasconade, holidayer, homocerc, intuitionalism, lophiostomate, nonbookish, nonvolition, palatableness, pimpery, previolation, reconveyance, registership, rhyacolite, smithereens, superedification, trust, whitestone
    }
}

// MARK: MonotheisticallyClass convenience initializers and mutators

extension MonotheisticallyClass {
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

enum Montage: Codable {
    case double(Double)
    case nullArray([JSONNull?])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Montage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Montage"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Moralness: Codable {
    case double(Double)
    case nullArray([JSONNull?])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Moralness.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Moralness"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Mulishly: Codable {
    case double(Double)
    case integerArray([Int])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Mulishly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Mulishly"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Myoscope: Codable {
    case bool(Bool)
    case integer(Int)
    case nullArray([JSONNull?])

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
        if let x = try? container.decode([JSONNull?].self) {
            self = .nullArray(x)
            return
        }
        throw DecodingError.typeMismatch(Myoscope.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Myoscope"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Neuromastic: Codable {
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
        throw DecodingError.typeMismatch(Neuromastic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Neuromastic"))
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

// MARK: - Noncontributing
struct Noncontributing: Codable {
    let estevin: String
    let jolterhead: Double
    let sauternes: Int
    let sparsely: Bool
    let unrequested: JSONNull?
}

// MARK: Noncontributing convenience initializers and mutators

extension Noncontributing {
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

enum Nonnervous: Codable {
    case bool(Bool)
    case integer(Int)

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
        throw DecodingError.typeMismatch(Nonnervous.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Nonnervous"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum Nonvaluation: Codable {
    case bool(Bool)
    case double(Double)
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
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Nonvaluation.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Nonvaluation"))
    }

    func encode(to encoder: Encoder) throws {
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

enum OccupationalistElement: Codable {
    case nullArray([JSONNull?])
    case occupationalistClass(OccupationalistClass)
    case null

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct OccupationalistClass: Codable {
    let beholdable, brotuliform, chimakum, doodler: JSONNull?
    let emulsin, fin, flourishing, flueless: JSONNull?
    let furtively, gritter, interwish, monoxylic: JSONNull?
    let myristic, nightwear, peruser, theoastrological: JSONNull?
    let thumby, tingitid, trailless, unpocketed: JSONNull?

    enum CodingKeys: String, CodingKey {
        case beholdable, brotuliform
        case chimakum = "Chimakum"
        case doodler, emulsin
        case fin = "Fin"
        case flourishing, flueless, furtively, gritter, interwish, monoxylic, myristic, nightwear, peruser, theoastrological, thumby, tingitid, trailless, unpocketed
    }
}

// MARK: OccupationalistClass convenience initializers and mutators

extension OccupationalistClass {
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

enum OutrivalElement: Codable {
    case double(Double)
    case outrivalClass(OutrivalClass)
    case null

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct OutrivalClass: Codable {
    let adroitly, bridehood, castoroides, czechoslovak: JSONNull?
    let diagenesis, dihexahedron, dopester, eumerism: JSONNull?
    let flyness, fouler, laudanosine, lingulidae: JSONNull?
    let minutary, mitra, opisthorchiasis, pensively: JSONNull?
    let pubigerous, rebellious, recodify, unpaced: JSONNull?

    enum CodingKeys: String, CodingKey {
        case adroitly, bridehood
        case castoroides = "Castoroides"
        case czechoslovak = "Czechoslovak"
        case diagenesis, dihexahedron, dopester, eumerism, flyness, fouler, laudanosine
        case lingulidae = "Lingulidae"
        case minutary, mitra, opisthorchiasis, pensively, pubigerous, rebellious, recodify, unpaced
    }
}

// MARK: OutrivalClass convenience initializers and mutators

extension OutrivalClass {
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

enum Paleographically: Codable {
    case double(Double)
    case unionMap([String: Int?])

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionMap(let x):
            try container.encode(x)
        }
    }
}

enum Pamphletwise: Codable {
    case integer(Int)
    case integerMap([String: Int])
    case string(String)

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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Pamphletwise.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pamphletwise"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Pediatric: Codable {
    case bool(Bool)
    case double(Double)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Pediatric.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pediatric"))
    }

    func encode(to encoder: Encoder) throws {
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

enum PiaculumElement: Codable {
    case double(Double)
    case piaculumClass(PiaculumClass)

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct PiaculumClass: Codable {
    let alada, amphistomous, boysenberry: Int?
    let catharticalness: Double?
    let chirotherium, decardinalize, discouragement: Int?
    let disdiapason: String?
    let doitrified, hexaspermous: Int?
    let homocerc: Bool?
    let insinking, loathfulness, miasmatical, neurofibril: Int?
    let nonbookish: JSONNull?
    let phonendoscope, pilferment, predismissory, preinscription: Int?
    let quotative, sienna, thorax, yachting: Int?
    let zipper: Int?

    enum CodingKeys: String, CodingKey {
        case alada, amphistomous, boysenberry, catharticalness
        case chirotherium = "Chirotherium"
        case decardinalize, discouragement, disdiapason, doitrified, hexaspermous, homocerc, insinking, loathfulness, miasmatical, neurofibril, nonbookish, phonendoscope, pilferment, predismissory, preinscription, quotative, sienna, thorax, yachting
        case zipper = "Zipper"
    }
}

// MARK: PiaculumClass convenience initializers and mutators

extension PiaculumClass {
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

enum Piccadilly: Codable {
    case double(Double)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Piccadilly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Piccadilly"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Piffler: Codable {
    case monaziteClass(MonaziteClass)
    case nullArray([JSONNull?])

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .monaziteClass(let x):
            try container.encode(x)
        case .nullArray(let x):
            try container.encode(x)
        }
    }
}

enum Pithful: Codable {
    case bool(Bool)
    case integer(Int)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Pithful.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pithful"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Placuntiti: Codable {
    case integer(Int)
    case integerMap([String: Int])

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
        throw DecodingError.typeMismatch(Placuntiti.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Placuntiti"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerMap(let x):
            try container.encode(x)
        }
    }
}

enum Plectopterous: Codable {
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
        throw DecodingError.typeMismatch(Plectopterous.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plectopterous"))
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

// MARK: - Pneumocele
struct Pneumocele: Codable {
    let carbonarism: JSONNull?
    let catharticalness: Double?
    let chirotherium: Int?
    let cineolic, cobbly, conchyliferous, congregation: JSONNull?
    let disdiapason: String?
    let enterotomy, entophytal, fewtrils, herem: JSONNull?
    let homocerc: Bool?
    let koniga, meticulosity, micky, mismarriage: JSONNull?
    let neurotrophic, nonbookish, persuasively, replaceable: JSONNull?
    let silex, taillight, unjealous, visitorial: JSONNull?

    enum CodingKeys: String, CodingKey {
        case carbonarism = "Carbonarism"
        case catharticalness
        case chirotherium = "Chirotherium"
        case cineolic, cobbly, conchyliferous, congregation, disdiapason, enterotomy, entophytal, fewtrils, herem, homocerc
        case koniga = "Koniga"
        case meticulosity
        case micky = "Micky"
        case mismarriage, neurotrophic, nonbookish, persuasively, replaceable, silex, taillight, unjealous, visitorial
    }
}

// MARK: Pneumocele convenience initializers and mutators

extension Pneumocele {
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

enum Poliorcetic: Codable {
    case bool(Bool)
    case monaziteClass(MonaziteClass)

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .monaziteClass(let x):
            try container.encode(x)
        }
    }
}

enum Poormaster: Codable {
    case integerArray([Int])
    case integerMap([String: Int])
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Poormaster.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Poormaster"))
    }

    func encode(to encoder: Encoder) throws {
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

enum PotwhiskyElement: Codable {
    case integer(Int)
    case potwhiskyClass(PotwhiskyClass)
    case null

    init(from decoder: Decoder) throws {
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

    func encode(to encoder: Encoder) throws {
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
struct PotwhiskyClass: Codable {
    let arciform, cresolin, disheartener, disproportionable: JSONNull?
    let euchorda, ferryway, filamentiferous, flemish: JSONNull?
    let forgainst, grainering, irrevoluble, kindredship: JSONNull?
    let pinguitudinous, simpletonic, singsong, submergement: JSONNull?
    let supraoesophagal, thrashel, tyremesis, yoruba: JSONNull?

    enum CodingKeys: String, CodingKey {
        case arciform, cresolin, disheartener, disproportionable
        case euchorda = "Euchorda"
        case ferryway, filamentiferous, flemish, forgainst, grainering, irrevoluble, kindredship, pinguitudinous, simpletonic, singsong, submergement, supraoesophagal, thrashel, tyremesis
        case yoruba = "Yoruba"
    }
}

// MARK: PotwhiskyClass convenience initializers and mutators

extension PotwhiskyClass {
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

enum Practicalizer: Codable {
    case monaziteClass(MonaziteClass)
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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Practicalizer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Practicalizer"))
    }

    func encode(to encoder: Encoder) throws {
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

enum PrefreshmanElement: Codable {
    case nullArray([JSONNull?])
    case prefreshmanClass(PrefreshmanClass)
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
        if let x = try? container.decode(PrefreshmanClass.self) {
            self = .prefreshmanClass(x)
            return
        }
        throw DecodingError.typeMismatch(PrefreshmanElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PrefreshmanElement"))
    }

    func encode(to encoder: Encoder) throws {
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
struct PrefreshmanClass: Codable {
    let azorubine, choroiditis, coagulatory, cyclorama: JSONNull?
    let dolphus, duckhearted, ficus, gemaric: JSONNull?
    let jugation, myoliposis, nonnomination, palay: JSONNull?
    let pentactinal, phaet, piquant, registration: JSONNull?
    let remancipation, scutatiform, theodolite, underward: JSONNull?

    enum CodingKeys: String, CodingKey {
        case azorubine, choroiditis, coagulatory, cyclorama
        case dolphus = "Dolphus"
        case duckhearted
        case ficus = "Ficus"
        case gemaric = "Gemaric"
        case jugation, myoliposis, nonnomination, palay, pentactinal
        case phaet = "Phaet"
        case piquant, registration, remancipation, scutatiform, theodolite, underward
    }
}

// MARK: PrefreshmanClass convenience initializers and mutators

extension PrefreshmanClass {
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

enum Prehensility: Codable {
    case bool(Bool)
    case monaziteClass(MonaziteClass)
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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Prehensility.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Prehensility"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Prevoidance: Codable {
    case integer(Int)
    case integerArray([Int])
    case monaziteClass(MonaziteClass)

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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Prevoidance.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Prevoidance"))
    }

    func encode(to encoder: Encoder) throws {
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

enum Protext: Codable {
    case bool(Bool)
    case integerArray([Int])
    case monaziteClass(MonaziteClass)

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
        if let x = try? container.decode(MonaziteClass.self) {
            self = .monaziteClass(x)
            return
        }
        throw DecodingError.typeMismatch(Protext.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Protext"))
    }

    func encode(to encoder: Encoder) throws {
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
