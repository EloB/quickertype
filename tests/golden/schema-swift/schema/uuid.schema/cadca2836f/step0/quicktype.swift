// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let arrNullable: [UUID?]?
    let arrOne: [UUID]?
    let nullable: UUID?
    let one: UUID
    let topLevelOptional: UUID?
    let unionWithEnum: UnionWithEnumUnion

    enum CodingKeys: String, CodingKey {
        case arrNullable = "arrNullable"
        case arrOne = "arrOne"
        case nullable = "nullable"
        case one = "one"
        case topLevelOptional = "optional"
        case unionWithEnum = "unionWithEnum"
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
        arrNullable: [UUID?]?? = nil,
        arrOne: [UUID]?? = nil,
        nullable: UUID?? = nil,
        one: UUID? = nil,
        topLevelOptional: UUID?? = nil,
        unionWithEnum: UnionWithEnumUnion? = nil
    ) -> TopLevel {
        return TopLevel(
            arrNullable: arrNullable ?? self.arrNullable,
            arrOne: arrOne ?? self.arrOne,
            nullable: nullable ?? self.nullable,
            one: one ?? self.one,
            topLevelOptional: topLevelOptional ?? self.topLevelOptional,
            unionWithEnum: unionWithEnum ?? self.unionWithEnum
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWithEnumUnion: Codable {
    case enumeration(UnionWithEnumEnum)
    case uuid(UUID)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(UnionWithEnumEnum.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(UUID.self) {
            self = .uuid(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWithEnumUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWithEnumUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .uuid(let x):
            try container.encode(x)
        }
    }
}

enum UnionWithEnumEnum: String, Codable {
    case foo = "foo"
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
