// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let prizes: [Prize]

    enum CodingKeys: String, CodingKey {
        case prizes = "prizes"
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
        prizes: [Prize]? = nil
    ) -> TopLevel {
        return TopLevel(
            prizes: prizes ?? self.prizes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Prize
struct Prize: Codable {
    let category: Category
    let laureates: [Laureate]
    let overallMotivation: String?
    let year: String

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case laureates = "laureates"
        case overallMotivation = "overallMotivation"
        case year = "year"
    }
}

// MARK: Prize convenience initializers and mutators

extension Prize {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Prize.self, from: data)
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
        category: Category? = nil,
        laureates: [Laureate]? = nil,
        overallMotivation: String?? = nil,
        year: String? = nil
    ) -> Prize {
        return Prize(
            category: category ?? self.category,
            laureates: laureates ?? self.laureates,
            overallMotivation: overallMotivation ?? self.overallMotivation,
            year: year ?? self.year
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Category: String, Codable {
    case physics = "physics"
    case chemistry = "chemistry"
    case medicine = "medicine"
    case literature = "literature"
    case peace = "peace"
    case economics = "economics"
}

// MARK: - Laureate
struct Laureate: Codable {
    let firstname: String
    let id: String
    let motivation: String?
    let share: String
    let surname: String

    enum CodingKeys: String, CodingKey {
        case firstname = "firstname"
        case id = "id"
        case motivation = "motivation"
        case share = "share"
        case surname = "surname"
    }
}

// MARK: Laureate convenience initializers and mutators

extension Laureate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Laureate.self, from: data)
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
        firstname: String? = nil,
        id: String? = nil,
        motivation: String?? = nil,
        share: String? = nil,
        surname: String? = nil
    ) -> Laureate {
        return Laureate(
            firstname: firstname ?? self.firstname,
            id: id ?? self.id,
            motivation: motivation ?? self.motivation,
            share: share ?? self.share,
            surname: surname ?? self.surname
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
