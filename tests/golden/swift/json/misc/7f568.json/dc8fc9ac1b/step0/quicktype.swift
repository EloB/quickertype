// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let comments: Int
    let commentsURL: String
    let commitsURL: String
    let createdAt: Date
    let description: String?
    let files: [String: File]
    let forksURL: String
    let gitPullURL: String
    let gitPushURL: String
    let htmlURL: String
    let id: String
    let topLevelPublic: Bool
    let truncated: Bool
    let updatedAt: Date
    let url: String
    let user: JSONNull?

    enum CodingKeys: String, CodingKey {
        case comments = "comments"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case createdAt = "created_at"
        case description = "description"
        case files = "files"
        case forksURL = "forks_url"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case htmlURL = "html_url"
        case id = "id"
        case topLevelPublic = "public"
        case truncated = "truncated"
        case updatedAt = "updated_at"
        case url = "url"
        case user = "user"
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
        comments: Int? = nil,
        commentsURL: String? = nil,
        commitsURL: String? = nil,
        createdAt: Date? = nil,
        description: String?? = nil,
        files: [String: File]? = nil,
        forksURL: String? = nil,
        gitPullURL: String? = nil,
        gitPushURL: String? = nil,
        htmlURL: String? = nil,
        id: String? = nil,
        topLevelPublic: Bool? = nil,
        truncated: Bool? = nil,
        updatedAt: Date? = nil,
        url: String? = nil,
        user: JSONNull?? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            comments: comments ?? self.comments,
            commentsURL: commentsURL ?? self.commentsURL,
            commitsURL: commitsURL ?? self.commitsURL,
            createdAt: createdAt ?? self.createdAt,
            description: description ?? self.description,
            files: files ?? self.files,
            forksURL: forksURL ?? self.forksURL,
            gitPullURL: gitPullURL ?? self.gitPullURL,
            gitPushURL: gitPushURL ?? self.gitPushURL,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            topLevelPublic: topLevelPublic ?? self.topLevelPublic,
            truncated: truncated ?? self.truncated,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - File
struct File: Codable {
    let filename: String
    let language: Language?
    let rawURL: String
    let size: Int
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case filename = "filename"
        case language = "language"
        case rawURL = "raw_url"
        case size = "size"
        case type = "type"
    }
}

// MARK: File convenience initializers and mutators

extension File {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(File.self, from: data)
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
        filename: String? = nil,
        language: Language?? = nil,
        rawURL: String? = nil,
        size: Int? = nil,
        type: TypeEnum? = nil
    ) -> File {
        return File(
            filename: filename ?? self.filename,
            language: language ?? self.language,
            rawURL: rawURL ?? self.rawURL,
            size: size ?? self.size,
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

enum Language: String, Codable {
    case markdown = "Markdown"
}

enum TypeEnum: String, Codable {
    case textPlain = "text/plain"
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
