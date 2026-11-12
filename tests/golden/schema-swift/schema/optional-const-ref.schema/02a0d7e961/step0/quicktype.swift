// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let coordinates: [Coordinate]?
    let count: Int?
    let label: String?
    let requiredCoordinates: [Coordinate]
    let requiredCount: Int
    let requiredLabel: String
    let weight: Double?

    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case count = "count"
        case label = "label"
        case requiredCoordinates = "requiredCoordinates"
        case requiredCount = "requiredCount"
        case requiredLabel = "requiredLabel"
        case weight = "weight"
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
        coordinates: [Coordinate]?? = nil,
        count: Int?? = nil,
        label: String?? = nil,
        requiredCoordinates: [Coordinate]? = nil,
        requiredCount: Int? = nil,
        requiredLabel: String? = nil,
        weight: Double?? = nil
    ) -> TopLevel {
        return TopLevel(
            coordinates: coordinates ?? self.coordinates,
            count: count ?? self.count,
            label: label ?? self.label,
            requiredCoordinates: requiredCoordinates ?? self.requiredCoordinates,
            requiredCount: requiredCount ?? self.requiredCount,
            requiredLabel: requiredLabel ?? self.requiredLabel,
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

// MARK: - Coordinate
struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

// MARK: Coordinate convenience initializers and mutators

extension Coordinate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Coordinate.self, from: data)
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
        latitude: Double? = nil,
        longitude: Double? = nil
    ) -> Coordinate {
        return Coordinate(
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude
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
