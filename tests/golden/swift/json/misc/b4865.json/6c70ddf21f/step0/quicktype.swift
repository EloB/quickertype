// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let computedRegionCbhkFwbd: String?
    let computedRegionNnqa25F4: String?
    let fall: Fall
    let geolocation: Geolocation?
    let id: String
    let mass: String?
    let name: String
    let nametype: Nametype
    let recclass: String
    let reclat: String?
    let reclong: String?
    let year: Date?

    enum CodingKeys: String, CodingKey {
        case computedRegionCbhkFwbd = ":@computed_region_cbhk_fwbd"
        case computedRegionNnqa25F4 = ":@computed_region_nnqa_25f4"
        case fall = "fall"
        case geolocation = "geolocation"
        case id = "id"
        case mass = "mass"
        case name = "name"
        case nametype = "nametype"
        case recclass = "recclass"
        case reclat = "reclat"
        case reclong = "reclong"
        case year = "year"
    }
}

// MARK: TopLevelElement convenience initializers and mutators

extension TopLevelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelElement.self, from: data)
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
        computedRegionCbhkFwbd: String?? = nil,
        computedRegionNnqa25F4: String?? = nil,
        fall: Fall? = nil,
        geolocation: Geolocation?? = nil,
        id: String? = nil,
        mass: String?? = nil,
        name: String? = nil,
        nametype: Nametype? = nil,
        recclass: String? = nil,
        reclat: String?? = nil,
        reclong: String?? = nil,
        year: Date?? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            computedRegionCbhkFwbd: computedRegionCbhkFwbd ?? self.computedRegionCbhkFwbd,
            computedRegionNnqa25F4: computedRegionNnqa25F4 ?? self.computedRegionNnqa25F4,
            fall: fall ?? self.fall,
            geolocation: geolocation ?? self.geolocation,
            id: id ?? self.id,
            mass: mass ?? self.mass,
            name: name ?? self.name,
            nametype: nametype ?? self.nametype,
            recclass: recclass ?? self.recclass,
            reclat: reclat ?? self.reclat,
            reclong: reclong ?? self.reclong,
            year: year ?? self.year
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Fall: String, Codable {
    case fell = "Fell"
    case found = "Found"
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let coordinates: [Double]
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type = "type"
    }
}

// MARK: Geolocation convenience initializers and mutators

extension Geolocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geolocation.self, from: data)
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
        coordinates: [Double]? = nil,
        type: TypeEnum? = nil
    ) -> Geolocation {
        return Geolocation(
            coordinates: coordinates ?? self.coordinates,
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

enum TypeEnum: String, Codable {
    case point = "Point"
}

enum Nametype: String, Codable {
    case valid = "Valid"
}

typealias TopLevel = [TopLevelElement]

extension Array where Element == TopLevel.Element {
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
