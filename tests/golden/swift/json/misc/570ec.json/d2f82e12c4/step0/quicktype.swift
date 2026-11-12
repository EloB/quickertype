// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let id: String
    let identifiers: [Identifier]
    let keywords: [String]
    let links: [Link]
    let name: String
    let otherNames: [OtherName]
    let supersededBy: JSONNull?
    let text: [Text]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case identifiers = "identifiers"
        case keywords = "keywords"
        case links = "links"
        case name = "name"
        case otherNames = "other_names"
        case supersededBy = "superseded_by"
        case text = "text"
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
        id: String? = nil,
        identifiers: [Identifier]? = nil,
        keywords: [String]? = nil,
        links: [Link]? = nil,
        name: String? = nil,
        otherNames: [OtherName]? = nil,
        supersededBy: JSONNull?? = nil,
        text: [Text]? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            id: id ?? self.id,
            identifiers: identifiers ?? self.identifiers,
            keywords: keywords ?? self.keywords,
            links: links ?? self.links,
            name: name ?? self.name,
            otherNames: otherNames ?? self.otherNames,
            supersededBy: supersededBy ?? self.supersededBy,
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

// MARK: - Identifier
struct Identifier: Codable {
    let identifier: String
    let scheme: Scheme

    enum CodingKeys: String, CodingKey {
        case identifier = "identifier"
        case scheme = "scheme"
    }
}

// MARK: Identifier convenience initializers and mutators

extension Identifier {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Identifier.self, from: data)
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
        identifier: String? = nil,
        scheme: Scheme? = nil
    ) -> Identifier {
        return Identifier(
            identifier: identifier ?? self.identifier,
            scheme: scheme ?? self.scheme
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Scheme: String, Codable {
    case dep5 = "DEP5"
    case spdx = "SPDX"
    case trove = "Trove"
}

// MARK: - Link
struct Link: Codable {
    let note: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case note = "note"
        case url = "url"
    }
}

// MARK: Link convenience initializers and mutators

extension Link {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Link.self, from: data)
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
        note: String? = nil,
        url: String? = nil
    ) -> Link {
        return Link(
            note: note ?? self.note,
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

// MARK: - OtherName
struct OtherName: Codable {
    let name: String
    let note: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case note = "note"
    }
}

// MARK: OtherName convenience initializers and mutators

extension OtherName {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OtherName.self, from: data)
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
        name: String? = nil,
        note: String?? = nil
    ) -> OtherName {
        return OtherName(
            name: name ?? self.name,
            note: note ?? self.note
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Text
struct Text: Codable {
    let mediaType: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case title = "title"
        case url = "url"
    }
}

// MARK: Text convenience initializers and mutators

extension Text {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Text.self, from: data)
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
        mediaType: String? = nil,
        title: String? = nil,
        url: String? = nil
    ) -> Text {
        return Text(
            mediaType: mediaType ?? self.mediaType,
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
