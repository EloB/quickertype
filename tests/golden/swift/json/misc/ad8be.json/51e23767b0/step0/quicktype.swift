// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let id: String
    let identifiers: [Identifier]
    let keywords: [Keyword]
    let links: [Link]
    let name: String
    let otherNames: [OtherName]
    let supersededBy: String?
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
        keywords: [Keyword]? = nil,
        links: [Link]? = nil,
        name: String? = nil,
        otherNames: [OtherName]? = nil,
        supersededBy: String?? = nil,
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
    case spdx = "SPDX"
    case trove = "Trove"
    case dep5 = "DEP5"
}

enum Keyword: String, Codable {
    case osiApproved = "osi-approved"
    case discouraged = "discouraged"
    case redundant = "redundant"
    case miscellaneous = "miscellaneous"
    case nonReusable = "non-reusable"
    case obsolete = "obsolete"
    case popular = "popular"
    case permissive = "permissive"
    case retired = "retired"
    case specialPurpose = "special-purpose"
    case copyleft = "copyleft"
    case international = "international"
}

// MARK: - Link
struct Link: Codable {
    let note: Note
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
        note: Note? = nil,
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

enum Note: String, Codable {
    case osiPage = "OSI Page"
    case tlDRLegal = "tl;dr legal"
    case wikipediaPage = "Wikipedia page"
    case noteWikipediaPage = "Wikipedia Page"
    case mozillaPage = "Mozilla Page"
    case osetFoundationPage = "OSET Foundation Page"
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
    let mediaType: MediaType
    let title: Title
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
        mediaType: MediaType? = nil,
        title: Title? = nil,
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

enum MediaType: String, Codable {
    case textHTML = "text/html"
    case textPlain = "text/plain"
    case applicationPDF = "application/pdf"
}

enum Title: String, Codable {
    case html = "HTML"
    case plainText = "Plain Text"
    case pdf = "PDF"
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
