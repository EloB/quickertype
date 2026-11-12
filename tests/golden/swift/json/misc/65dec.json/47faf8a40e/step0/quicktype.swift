// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let booster: [String]
    let border: String
    let cards: [Card]
    let code: String
    let gathererCode: String
    let magicCardsInfoCode: String
    let mkmID: Int
    let mkmName: String
    let name: String
    let releaseDate: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case booster = "booster"
        case border = "border"
        case cards = "cards"
        case code = "code"
        case gathererCode = "gathererCode"
        case magicCardsInfoCode = "magicCardsInfoCode"
        case mkmID = "mkm_id"
        case mkmName = "mkm_name"
        case name = "name"
        case releaseDate = "releaseDate"
        case type = "type"
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
        booster: [String]? = nil,
        border: String? = nil,
        cards: [Card]? = nil,
        code: String? = nil,
        gathererCode: String? = nil,
        magicCardsInfoCode: String? = nil,
        mkmID: Int? = nil,
        mkmName: String? = nil,
        name: String? = nil,
        releaseDate: String? = nil,
        type: String? = nil
    ) -> TopLevel {
        return TopLevel(
            booster: booster ?? self.booster,
            border: border ?? self.border,
            cards: cards ?? self.cards,
            code: code ?? self.code,
            gathererCode: gathererCode ?? self.gathererCode,
            magicCardsInfoCode: magicCardsInfoCode ?? self.magicCardsInfoCode,
            mkmID: mkmID ?? self.mkmID,
            mkmName: mkmName ?? self.mkmName,
            name: name ?? self.name,
            releaseDate: releaseDate ?? self.releaseDate,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Card
struct Card: Codable {
    let artist: String
    let cmc: Int
    let colorIdentity: [ColorIdentity]?
    let colors: [Watermark]?
    let flavor: String?
    let id: String
    let imageName: String
    let layout: Layout
    let legalities: [LegalityElement]
    let manaCost: String?
    let mciNumber: String?
    let multiverseid: Int
    let name: String
    let originalText: String
    let originalType: String
    let power: String?
    let printings: [String]
    let rarity: Rarity
    let reserved: Bool?
    let rulings: [Ruling]?
    let subtypes: [String]?
    let supertypes: [String]?
    let text: String?
    let toughness: String?
    let type: String
    let types: [TypeElement]
    let variations: [Int]?
    let watermark: Watermark?

    enum CodingKeys: String, CodingKey {
        case artist = "artist"
        case cmc = "cmc"
        case colorIdentity = "colorIdentity"
        case colors = "colors"
        case flavor = "flavor"
        case id = "id"
        case imageName = "imageName"
        case layout = "layout"
        case legalities = "legalities"
        case manaCost = "manaCost"
        case mciNumber = "mciNumber"
        case multiverseid = "multiverseid"
        case name = "name"
        case originalText = "originalText"
        case originalType = "originalType"
        case power = "power"
        case printings = "printings"
        case rarity = "rarity"
        case reserved = "reserved"
        case rulings = "rulings"
        case subtypes = "subtypes"
        case supertypes = "supertypes"
        case text = "text"
        case toughness = "toughness"
        case type = "type"
        case types = "types"
        case variations = "variations"
        case watermark = "watermark"
    }
}

// MARK: Card convenience initializers and mutators

extension Card {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Card.self, from: data)
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
        artist: String? = nil,
        cmc: Int? = nil,
        colorIdentity: [ColorIdentity]?? = nil,
        colors: [Watermark]?? = nil,
        flavor: String?? = nil,
        id: String? = nil,
        imageName: String? = nil,
        layout: Layout? = nil,
        legalities: [LegalityElement]? = nil,
        manaCost: String?? = nil,
        mciNumber: String?? = nil,
        multiverseid: Int? = nil,
        name: String? = nil,
        originalText: String? = nil,
        originalType: String? = nil,
        power: String?? = nil,
        printings: [String]? = nil,
        rarity: Rarity? = nil,
        reserved: Bool?? = nil,
        rulings: [Ruling]?? = nil,
        subtypes: [String]?? = nil,
        supertypes: [String]?? = nil,
        text: String?? = nil,
        toughness: String?? = nil,
        type: String? = nil,
        types: [TypeElement]? = nil,
        variations: [Int]?? = nil,
        watermark: Watermark?? = nil
    ) -> Card {
        return Card(
            artist: artist ?? self.artist,
            cmc: cmc ?? self.cmc,
            colorIdentity: colorIdentity ?? self.colorIdentity,
            colors: colors ?? self.colors,
            flavor: flavor ?? self.flavor,
            id: id ?? self.id,
            imageName: imageName ?? self.imageName,
            layout: layout ?? self.layout,
            legalities: legalities ?? self.legalities,
            manaCost: manaCost ?? self.manaCost,
            mciNumber: mciNumber ?? self.mciNumber,
            multiverseid: multiverseid ?? self.multiverseid,
            name: name ?? self.name,
            originalText: originalText ?? self.originalText,
            originalType: originalType ?? self.originalType,
            power: power ?? self.power,
            printings: printings ?? self.printings,
            rarity: rarity ?? self.rarity,
            reserved: reserved ?? self.reserved,
            rulings: rulings ?? self.rulings,
            subtypes: subtypes ?? self.subtypes,
            supertypes: supertypes ?? self.supertypes,
            text: text ?? self.text,
            toughness: toughness ?? self.toughness,
            type: type ?? self.type,
            types: types ?? self.types,
            variations: variations ?? self.variations,
            watermark: watermark ?? self.watermark
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ColorIdentity: String, Codable {
    case w = "W"
    case r = "R"
    case b = "B"
    case g = "G"
    case u = "U"
}

enum Watermark: String, Codable {
    case white = "White"
    case red = "Red"
    case black = "Black"
    case green = "Green"
    case blue = "Blue"
}

enum Layout: String, Codable {
    case normal = "normal"
}

// MARK: - LegalityElement
struct LegalityElement: Codable {
    let format: String
    let legality: LegalityEnum

    enum CodingKeys: String, CodingKey {
        case format = "format"
        case legality = "legality"
    }
}

// MARK: LegalityElement convenience initializers and mutators

extension LegalityElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LegalityElement.self, from: data)
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
        format: String? = nil,
        legality: LegalityEnum? = nil
    ) -> LegalityElement {
        return LegalityElement(
            format: format ?? self.format,
            legality: legality ?? self.legality
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum LegalityEnum: String, Codable {
    case legal = "Legal"
    case banned = "Banned"
    case restricted = "Restricted"
}

enum Rarity: String, Codable {
    case uncommon = "Uncommon"
    case rare = "Rare"
    case common = "Common"
    case basicLand = "Basic Land"
}

// MARK: - Ruling
struct Ruling: Codable {
    let date: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case text = "text"
    }
}

// MARK: Ruling convenience initializers and mutators

extension Ruling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ruling.self, from: data)
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
        date: String? = nil,
        text: String? = nil
    ) -> Ruling {
        return Ruling(
            date: date ?? self.date,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeElement: String, Codable {
    case creature = "Creature"
    case artifact = "Artifact"
    case instant = "Instant"
    case land = "Land"
    case enchantment = "Enchantment"
    case sorcery = "Sorcery"
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
