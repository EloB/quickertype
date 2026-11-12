// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

/// The top-level class.
/// Its description has two lines.
// MARK: - TopLevel
struct TopLevel: Codable {
    /// A pretty boolean
    let bar: Bool?
    /// An enumeration
    let topLevelEnum: Enum
    let foo: Double?
    let objectOrString: ObjectOrStringUnion
    /// Either a number or a string
    let union: Union

    enum CodingKeys: String, CodingKey {
        case bar = "bar"
        case topLevelEnum = "enum"
        case foo = "foo"
        case objectOrString = "object-or-string"
        case union = "union"
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
        bar: Bool?? = nil,
        topLevelEnum: Enum? = nil,
        foo: Double?? = nil,
        objectOrString: ObjectOrStringUnion? = nil,
        union: Union? = nil
    ) -> TopLevel {
        return TopLevel(
            bar: bar ?? self.bar,
            topLevelEnum: topLevelEnum ?? self.topLevelEnum,
            foo: foo ?? self.foo,
            objectOrString: objectOrString ?? self.objectOrString,
            union: union ?? self.union
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ObjectOrStringUnion: Codable {
    case objectOrStringClass(ObjectOrStringClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ObjectOrStringClass.self) {
            self = .objectOrStringClass(x)
            return
        }
        throw DecodingError.typeMismatch(ObjectOrStringUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ObjectOrStringUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .objectOrStringClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ObjectOrStringClass
struct ObjectOrStringClass: Codable {
    /// This must not get lost
    let prop: Double

    enum CodingKeys: String, CodingKey {
        case prop = "prop"
    }
}

// MARK: ObjectOrStringClass convenience initializers and mutators

extension ObjectOrStringClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectOrStringClass.self, from: data)
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
        prop: Double? = nil
    ) -> ObjectOrStringClass {
        return ObjectOrStringClass(
            prop: prop ?? self.prop
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An enumeration
enum Enum: String, Codable {
    case foo = "foo"
    case bar = "bar"
}

/// Either a number or a string
enum Union: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Union.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Union"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
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
