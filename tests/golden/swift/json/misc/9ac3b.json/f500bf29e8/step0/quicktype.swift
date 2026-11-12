// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let count: Int
    let facets: Facets
    let limit: Int
    let next: String
    let offset: Int
    let previous: Bool
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case facets = "facets"
        case limit = "limit"
        case next = "next"
        case offset = "offset"
        case previous = "previous"
        case results = "results"
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
        count: Int? = nil,
        facets: Facets? = nil,
        limit: Int? = nil,
        next: String? = nil,
        offset: Int? = nil,
        previous: Bool? = nil,
        results: [Result]? = nil
    ) -> TopLevel {
        return TopLevel(
            count: count ?? self.count,
            facets: facets ?? self.facets,
            limit: limit ?? self.limit,
            next: next ?? self.next,
            offset: offset ?? self.offset,
            previous: previous ?? self.previous,
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Facets
struct Facets: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Facets convenience initializers and mutators

extension Facets {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Facets.self, from: data)
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
    ) -> Facets {
        return Facets(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Result
struct Result: Codable {
    let createdAt: Date
    let entity: String
    let firstName: String
    let id: String
    let lastName: String
    let name: String
    let position: String?
    let status: Status
    let title: Title?
    let updatedAt: Date
    let uri: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case entity = "entity"
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case name = "name"
        case position = "position"
        case status = "status"
        case title = "title"
        case updatedAt = "updated_at"
        case uri = "uri"
    }
}

// MARK: Result convenience initializers and mutators

extension Result {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Result.self, from: data)
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
        createdAt: Date? = nil,
        entity: String? = nil,
        firstName: String? = nil,
        id: String? = nil,
        lastName: String? = nil,
        name: String? = nil,
        position: String?? = nil,
        status: Status? = nil,
        title: Title?? = nil,
        updatedAt: Date? = nil,
        uri: String? = nil
    ) -> Result {
        return Result(
            createdAt: createdAt ?? self.createdAt,
            entity: entity ?? self.entity,
            firstName: firstName ?? self.firstName,
            id: id ?? self.id,
            lastName: lastName ?? self.lastName,
            name: name ?? self.name,
            position: position ?? self.position,
            status: status ?? self.status,
            title: title ?? self.title,
            updatedAt: updatedAt ?? self.updatedAt,
            uri: uri ?? self.uri
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Status: String, Codable {
    case inactive = "inactive"
    case active = "active"
}

enum Title: String, Codable {
    case mr = "Mr"
    case ms = "Ms"
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
