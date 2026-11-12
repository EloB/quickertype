// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let bbox: [Double]
    let features: [Feature]
    let metadata: Metadata
    let type: String

    enum CodingKeys: String, CodingKey {
        case bbox = "bbox"
        case features = "features"
        case metadata = "metadata"
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
        bbox: [Double]? = nil,
        features: [Feature]? = nil,
        metadata: Metadata? = nil,
        type: String? = nil
    ) -> TopLevel {
        return TopLevel(
            bbox: bbox ?? self.bbox,
            features: features ?? self.features,
            metadata: metadata ?? self.metadata,
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
    let id: String
    let properties: Properties
    let type: FeatureType

    enum CodingKeys: String, CodingKey {
        case geometry = "geometry"
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
        id: String? = nil,
        properties: Properties? = nil,
        type: FeatureType? = nil
    ) -> Feature {
        return Feature(
            geometry: geometry ?? self.geometry,
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
    let alert: JSONNull?
    let cdi: JSONNull?
    let code: String
    let detail: String
    let dmin: Double?
    let felt: JSONNull?
    let gap: Int?
    let ids: String
    let mag: Double
    let magType: MagType
    let mmi: JSONNull?
    let net: String
    let nst: Int?
    let place: String
    let rms: Double
    let sig: Int
    let sources: String
    let status: Status
    let time: Int
    let title: String
    let tsunami: Int
    let type: PropertiesType
    let types: String
    let tz: Int
    let updated: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case alert = "alert"
        case cdi = "cdi"
        case code = "code"
        case detail = "detail"
        case dmin = "dmin"
        case felt = "felt"
        case gap = "gap"
        case ids = "ids"
        case mag = "mag"
        case magType = "magType"
        case mmi = "mmi"
        case net = "net"
        case nst = "nst"
        case place = "place"
        case rms = "rms"
        case sig = "sig"
        case sources = "sources"
        case status = "status"
        case time = "time"
        case title = "title"
        case tsunami = "tsunami"
        case type = "type"
        case types = "types"
        case tz = "tz"
        case updated = "updated"
        case url = "url"
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
        alert: JSONNull?? = nil,
        cdi: JSONNull?? = nil,
        code: String? = nil,
        detail: String? = nil,
        dmin: Double?? = nil,
        felt: JSONNull?? = nil,
        gap: Int?? = nil,
        ids: String? = nil,
        mag: Double? = nil,
        magType: MagType? = nil,
        mmi: JSONNull?? = nil,
        net: String? = nil,
        nst: Int?? = nil,
        place: String? = nil,
        rms: Double? = nil,
        sig: Int? = nil,
        sources: String? = nil,
        status: Status? = nil,
        time: Int? = nil,
        title: String? = nil,
        tsunami: Int? = nil,
        type: PropertiesType? = nil,
        types: String? = nil,
        tz: Int? = nil,
        updated: Int? = nil,
        url: String? = nil
    ) -> Properties {
        return Properties(
            alert: alert ?? self.alert,
            cdi: cdi ?? self.cdi,
            code: code ?? self.code,
            detail: detail ?? self.detail,
            dmin: dmin ?? self.dmin,
            felt: felt ?? self.felt,
            gap: gap ?? self.gap,
            ids: ids ?? self.ids,
            mag: mag ?? self.mag,
            magType: magType ?? self.magType,
            mmi: mmi ?? self.mmi,
            net: net ?? self.net,
            nst: nst ?? self.nst,
            place: place ?? self.place,
            rms: rms ?? self.rms,
            sig: sig ?? self.sig,
            sources: sources ?? self.sources,
            status: status ?? self.status,
            time: time ?? self.time,
            title: title ?? self.title,
            tsunami: tsunami ?? self.tsunami,
            type: type ?? self.type,
            types: types ?? self.types,
            tz: tz ?? self.tz,
            updated: updated ?? self.updated,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum MagType: String, Codable {
    case md = "md"
    case ml = "ml"
    case mb = "mb"
}

enum Status: String, Codable {
    case automatic = "automatic"
    case reviewed = "reviewed"
}

enum PropertiesType: String, Codable {
    case earthquake = "earthquake"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

// MARK: - Metadata
struct Metadata: Codable {
    let api: String
    let count: Int
    let generated: Int
    let status: Int
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case api = "api"
        case count = "count"
        case generated = "generated"
        case status = "status"
        case title = "title"
        case url = "url"
    }
}

// MARK: Metadata convenience initializers and mutators

extension Metadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Metadata.self, from: data)
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
        api: String? = nil,
        count: Int? = nil,
        generated: Int? = nil,
        status: Int? = nil,
        title: String? = nil,
        url: String? = nil
    ) -> Metadata {
        return Metadata(
            api: api ?? self.api,
            count: count ?? self.count,
            generated: generated ?? self.generated,
            status: status ?? self.status,
            title: title ?? self.title,
            url: url ?? self.url
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
