// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let complexUnionArray: [ComplexUnionArrayElement]
    let date: String
    let dateTime: Date
    let localDateClass: LocalDate?
    let offsetDateTimeClass: OffsetDateTime?
    let offsetTimeClass: OffsetTime?
    let time: String
    let unionArray: [String]

    enum CodingKeys: String, CodingKey {
        case complexUnionArray = "complex-union-array"
        case date = "date"
        case dateTime = "date-time"
        case localDateClass = "local-date-class"
        case offsetDateTimeClass = "offset-date-time-class"
        case offsetTimeClass = "offset-time-class"
        case time = "time"
        case unionArray = "union-array"
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
        complexUnionArray: [ComplexUnionArrayElement]? = nil,
        date: String? = nil,
        dateTime: Date? = nil,
        localDateClass: LocalDate?? = nil,
        offsetDateTimeClass: OffsetDateTime?? = nil,
        offsetTimeClass: OffsetTime?? = nil,
        time: String? = nil,
        unionArray: [String]? = nil
    ) -> TopLevel {
        return TopLevel(
            complexUnionArray: complexUnionArray ?? self.complexUnionArray,
            date: date ?? self.date,
            dateTime: dateTime ?? self.dateTime,
            localDateClass: localDateClass ?? self.localDateClass,
            offsetDateTimeClass: offsetDateTimeClass ?? self.offsetDateTimeClass,
            offsetTimeClass: offsetTimeClass ?? self.offsetTimeClass,
            time: time ?? self.time,
            unionArray: unionArray ?? self.unionArray
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ComplexUnionArrayElement: Codable {
    case dateTime(Date)
    case enumeration(ComplexUnionArrayEnum)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Date.self) {
            self = .dateTime(x)
            return
        }
        if let x = try? container.decode(ComplexUnionArrayEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(ComplexUnionArrayElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ComplexUnionArrayElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum ComplexUnionArrayEnum: String, Codable {
    case foo = "foo"
    case bar = "bar"
}

// MARK: - LocalDate
struct LocalDate: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: LocalDate convenience initializers and mutators

extension LocalDate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocalDate.self, from: data)
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
    ) -> LocalDate {
        return LocalDate(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OffsetDateTime
struct OffsetDateTime: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: OffsetDateTime convenience initializers and mutators

extension OffsetDateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetDateTime.self, from: data)
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
    ) -> OffsetDateTime {
        return OffsetDateTime(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OffsetTime
struct OffsetTime: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: OffsetTime convenience initializers and mutators

extension OffsetTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetTime.self, from: data)
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
    ) -> OffsetTime {
        return OffsetTime(
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
