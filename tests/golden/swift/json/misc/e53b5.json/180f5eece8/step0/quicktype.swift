// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

enum TopLevelUnion: Codable {
    case fluffyTopLevel(FluffyTopLevel)
    case purpleTopLevelArray([PurpleTopLevel])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([PurpleTopLevel].self) {
            self = .purpleTopLevelArray(x)
            return
        }
        if let x = try? container.decode(FluffyTopLevel.self) {
            self = .fluffyTopLevel(x)
            return
        }
        throw DecodingError.typeMismatch(TopLevelUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TopLevelUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffyTopLevel(let x):
            try container.encode(x)
        case .purpleTopLevelArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PurpleTopLevel
struct PurpleTopLevel: Codable {
    let country: Country
    let date: String
    let decimal: String
    let indicator: Country
    let value: String

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case date = "date"
        case decimal = "decimal"
        case indicator = "indicator"
        case value = "value"
    }
}

// MARK: PurpleTopLevel convenience initializers and mutators

extension PurpleTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleTopLevel.self, from: data)
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
        country: Country? = nil,
        date: String? = nil,
        decimal: String? = nil,
        indicator: Country? = nil,
        value: String? = nil
    ) -> PurpleTopLevel {
        return PurpleTopLevel(
            country: country ?? self.country,
            date: date ?? self.date,
            decimal: decimal ?? self.decimal,
            indicator: indicator ?? self.indicator,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Country
struct Country: Codable {
    let id: ID
    let value: Value

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
}

// MARK: Country convenience initializers and mutators

extension Country {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Country.self, from: data)
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
        id: ID? = nil,
        value: Value? = nil
    ) -> Country {
        return Country(
            id: id ?? self.id,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ID: String, Codable {
    case idIN = "IN"
    case spPopTotl = "SP.POP.TOTL"
}

enum Value: String, Codable {
    case india = "India"
    case populationTotal = "Population, total"
}

// MARK: - FluffyTopLevel
struct FluffyTopLevel: Codable {
    let page: Int
    let pages: Int
    let perPage: String
    let total: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perPage = "per_page"
        case total = "total"
    }
}

// MARK: FluffyTopLevel convenience initializers and mutators

extension FluffyTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyTopLevel.self, from: data)
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
        page: Int? = nil,
        pages: Int? = nil,
        perPage: String? = nil,
        total: Int? = nil
    ) -> FluffyTopLevel {
        return FluffyTopLevel(
            page: page ?? self.page,
            pages: pages ?? self.pages,
            perPage: perPage ?? self.perPage,
            total: total ?? self.total
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias TopLevel = [TopLevelUnion]

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
