// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let crs: CRS
    let features: [Feature]
    let totalFeatures: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case crs = "crs"
        case features = "features"
        case totalFeatures = "totalFeatures"
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
        crs: CRS? = nil,
        features: [Feature]? = nil,
        totalFeatures: Int? = nil,
        type: String? = nil
    ) -> TopLevel {
        return TopLevel(
            crs: crs ?? self.crs,
            features: features ?? self.features,
            totalFeatures: totalFeatures ?? self.totalFeatures,
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

// MARK: - CRS
struct CRS: Codable {
    let properties: CRSProperties
    let type: String

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
        case type = "type"
    }
}

// MARK: CRS convenience initializers and mutators

extension CRS {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRS.self, from: data)
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
        properties: CRSProperties? = nil,
        type: String? = nil
    ) -> CRS {
        return CRS(
            properties: properties ?? self.properties,
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

// MARK: - CRSProperties
struct CRSProperties: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

// MARK: CRSProperties convenience initializers and mutators

extension CRSProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRSProperties.self, from: data)
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
        name: String? = nil
    ) -> CRSProperties {
        return CRSProperties(
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Feature
struct Feature: Codable {
    let geometry: Geometry
    let geometryName: GeometryName
    let id: String
    let properties: FeatureProperties
    let type: FeatureType

    enum CodingKeys: String, CodingKey {
        case geometry = "geometry"
        case geometryName = "geometry_name"
        case id = "id"
        case properties = "properties"
        case type = "type"
    }
}

// MARK: Feature convenience initializers and mutators

extension Feature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Feature.self, from: data)
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
        geometry: Geometry? = nil,
        geometryName: GeometryName? = nil,
        id: String? = nil,
        properties: FeatureProperties? = nil,
        type: FeatureType? = nil
    ) -> Feature {
        return Feature(
            geometry: geometry ?? self.geometry,
            geometryName: geometryName ?? self.geometryName,
            id: id ?? self.id,
            properties: properties ?? self.properties,
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

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [[Double]]
    let type: GeometryType

    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type = "type"
    }
}

// MARK: Geometry convenience initializers and mutators

extension Geometry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geometry.self, from: data)
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
        coordinates: [[Double]]? = nil,
        type: GeometryType? = nil
    ) -> Geometry {
        return Geometry(
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

enum GeometryType: String, Codable {
    case multiPoint = "MultiPoint"
}

enum GeometryName: String, Codable {
    case geom = "geom"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let facebookaccount: String
    let frequencyfinderurl: String
    let name: String
    let siteurl: String
    let streetaddress: String
    let twitteraccount: String

    enum CodingKeys: String, CodingKey {
        case facebookaccount = "facebookaccount"
        case frequencyfinderurl = "frequencyfinderurl"
        case name = "name"
        case siteurl = "siteurl"
        case streetaddress = "streetaddress"
        case twitteraccount = "twitteraccount"
    }
}

// MARK: FeatureProperties convenience initializers and mutators

extension FeatureProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FeatureProperties.self, from: data)
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
        facebookaccount: String? = nil,
        frequencyfinderurl: String? = nil,
        name: String? = nil,
        siteurl: String? = nil,
        streetaddress: String? = nil,
        twitteraccount: String? = nil
    ) -> FeatureProperties {
        return FeatureProperties(
            facebookaccount: facebookaccount ?? self.facebookaccount,
            frequencyfinderurl: frequencyfinderurl ?? self.frequencyfinderurl,
            name: name ?? self.name,
            siteurl: siteurl ?? self.siteurl,
            streetaddress: streetaddress ?? self.streetaddress,
            twitteraccount: twitteraccount ?? self.twitteraccount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FeatureType: String, Codable {
    case feature = "Feature"
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
