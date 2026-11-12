// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let features: [Feature]
    let name: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case features = "features"
        case name = "name"
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
        features: [Feature]? = nil,
        name: String? = nil,
        type: String? = nil
    ) -> TopLevel {
        return TopLevel(
            features: features ?? self.features,
            name: name ?? self.name,
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

// MARK: - Feature
struct Feature: Codable {
    let geometry: Geometry
    let properties: Properties
    let type: FeatureType

    enum CodingKeys: String, CodingKey {
        case geometry = "geometry"
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
        properties: Properties? = nil,
        type: FeatureType? = nil
    ) -> Feature {
        return Feature(
            geometry: geometry ?? self.geometry,
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
    let coordinates: [Double]
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
        coordinates: [Double]? = nil,
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
    case point = "Point"
}

// MARK: - Properties
struct Properties: Codable {
    let area: String
    let centralAssetID: String
    let featureLocation: String
    let lat: String
    let long: String
    let maintainingAuthority: MaintainingAuthority
    let number: String
    let propertiesClass: Class
    let siteName: String
    let ward: Ward

    enum CodingKeys: String, CodingKey {
        case area = "Area"
        case centralAssetID = "Central Asset ID"
        case featureLocation = "Feature Location"
        case lat = "lat"
        case long = "long"
        case maintainingAuthority = "Maintaining Authority"
        case number = "Number"
        case propertiesClass = "Class"
        case siteName = "Site Name"
        case ward = "Ward"
    }
}

// MARK: Properties convenience initializers and mutators

extension Properties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Properties.self, from: data)
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
        area: String? = nil,
        centralAssetID: String? = nil,
        featureLocation: String? = nil,
        lat: String? = nil,
        long: String? = nil,
        maintainingAuthority: MaintainingAuthority? = nil,
        number: String? = nil,
        propertiesClass: Class? = nil,
        siteName: String? = nil,
        ward: Ward? = nil
    ) -> Properties {
        return Properties(
            area: area ?? self.area,
            centralAssetID: centralAssetID ?? self.centralAssetID,
            featureLocation: featureLocation ?? self.featureLocation,
            lat: lat ?? self.lat,
            long: long ?? self.long,
            maintainingAuthority: maintainingAuthority ?? self.maintainingAuthority,
            number: number ?? self.number,
            propertiesClass: propertiesClass ?? self.propertiesClass,
            siteName: siteName ?? self.siteName,
            ward: ward ?? self.ward
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum MaintainingAuthority: String, Codable {
    case cityOfBallarat = "City of Ballarat"
}

enum Class: String, Codable {
    case noCodeAllocated = "No Code Allocated"
    case osDistrict = "OS-District"
    case osNeighbourhood = "OS-Neighbourhood"
    case osRegional = "OS-Regional"
}

enum Ward: String, Codable {
    case south = "South"
    case north = "North"
    case central = "Central"
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
