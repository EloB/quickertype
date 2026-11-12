// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
@objcMembers final class TopLevel: NSObject, Codable, Sendable {
    let pokemon: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case pokemon = "pokemon"
    }

    init(pokemon: [Pokemon]) {
        self.pokemon = pokemon
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TopLevel.self, from: data)
        self.init(pokemon: me.pokemon)
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
        pokemon: [Pokemon]? = nil
    ) -> TopLevel {
        return TopLevel(
            pokemon: pokemon ?? self.pokemon
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pokemon
@objcMembers final class Pokemon: NSObject, Codable, Sendable {
    let avgSpawns: Double
    let candy: String
    let candyCount: Int?
    let egg: Egg
    let height: String
    let id: Int
    let img: String
    let multipliers: [Double]?
    let name: String
    let nextEvolution: [Evolution]?
    let num: String
    let prevEvolution: [Evolution]?
    let spawnChance: Double
    let spawnTime: String
    let type: [TypeElement]
    let weaknesses: [TypeElement]
    let weight: String

    enum CodingKeys: String, CodingKey {
        case avgSpawns = "avg_spawns"
        case candy = "candy"
        case candyCount = "candy_count"
        case egg = "egg"
        case height = "height"
        case id = "id"
        case img = "img"
        case multipliers = "multipliers"
        case name = "name"
        case nextEvolution = "next_evolution"
        case num = "num"
        case prevEvolution = "prev_evolution"
        case spawnChance = "spawn_chance"
        case spawnTime = "spawn_time"
        case type = "type"
        case weaknesses = "weaknesses"
        case weight = "weight"
    }

    init(avgSpawns: Double, candy: String, candyCount: Int?, egg: Egg, height: String, id: Int, img: String, multipliers: [Double]?, name: String, nextEvolution: [Evolution]?, num: String, prevEvolution: [Evolution]?, spawnChance: Double, spawnTime: String, type: [TypeElement], weaknesses: [TypeElement], weight: String) {
        self.avgSpawns = avgSpawns
        self.candy = candy
        self.candyCount = candyCount
        self.egg = egg
        self.height = height
        self.id = id
        self.img = img
        self.multipliers = multipliers
        self.name = name
        self.nextEvolution = nextEvolution
        self.num = num
        self.prevEvolution = prevEvolution
        self.spawnChance = spawnChance
        self.spawnTime = spawnTime
        self.type = type
        self.weaknesses = weaknesses
        self.weight = weight
    }
}

// MARK: Pokemon convenience initializers and mutators

extension Pokemon {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Pokemon.self, from: data)
        self.init(avgSpawns: me.avgSpawns, candy: me.candy, candyCount: me.candyCount, egg: me.egg, height: me.height, id: me.id, img: me.img, multipliers: me.multipliers, name: me.name, nextEvolution: me.nextEvolution, num: me.num, prevEvolution: me.prevEvolution, spawnChance: me.spawnChance, spawnTime: me.spawnTime, type: me.type, weaknesses: me.weaknesses, weight: me.weight)
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
        avgSpawns: Double? = nil,
        candy: String? = nil,
        candyCount: Int?? = nil,
        egg: Egg? = nil,
        height: String? = nil,
        id: Int? = nil,
        img: String? = nil,
        multipliers: [Double]?? = nil,
        name: String? = nil,
        nextEvolution: [Evolution]?? = nil,
        num: String? = nil,
        prevEvolution: [Evolution]?? = nil,
        spawnChance: Double? = nil,
        spawnTime: String? = nil,
        type: [TypeElement]? = nil,
        weaknesses: [TypeElement]? = nil,
        weight: String? = nil
    ) -> Pokemon {
        return Pokemon(
            avgSpawns: avgSpawns ?? self.avgSpawns,
            candy: candy ?? self.candy,
            candyCount: candyCount ?? self.candyCount,
            egg: egg ?? self.egg,
            height: height ?? self.height,
            id: id ?? self.id,
            img: img ?? self.img,
            multipliers: multipliers ?? self.multipliers,
            name: name ?? self.name,
            nextEvolution: nextEvolution ?? self.nextEvolution,
            num: num ?? self.num,
            prevEvolution: prevEvolution ?? self.prevEvolution,
            spawnChance: spawnChance ?? self.spawnChance,
            spawnTime: spawnTime ?? self.spawnTime,
            type: type ?? self.type,
            weaknesses: weaknesses ?? self.weaknesses,
            weight: weight ?? self.weight
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Egg: String, Codable, Sendable {
    case the2KM = "2 km"
    case notInEggs = "Not in Eggs"
    case the5KM = "5 km"
    case the10KM = "10 km"
    case omanyteCandy = "Omanyte Candy"
}

// MARK: - Evolution
@objcMembers final class Evolution: NSObject, Codable, Sendable {
    let name: String
    let num: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case num = "num"
    }

    init(name: String, num: String) {
        self.name = name
        self.num = num
    }
}

// MARK: Evolution convenience initializers and mutators

extension Evolution {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Evolution.self, from: data)
        self.init(name: me.name, num: me.num)
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
        name: String? = nil,
        num: String? = nil
    ) -> Evolution {
        return Evolution(
            name: name ?? self.name,
            num: num ?? self.num
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeElement: String, Codable, Sendable {
    case fire = "Fire"
    case ice = "Ice"
    case flying = "Flying"
    case psychic = "Psychic"
    case water = "Water"
    case ground = "Ground"
    case rock = "Rock"
    case electric = "Electric"
    case grass = "Grass"
    case fighting = "Fighting"
    case poison = "Poison"
    case bug = "Bug"
    case fairy = "Fairy"
    case ghost = "Ghost"
    case dark = "Dark"
    case steel = "Steel"
    case dragon = "Dragon"
    case normal = "Normal"
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
