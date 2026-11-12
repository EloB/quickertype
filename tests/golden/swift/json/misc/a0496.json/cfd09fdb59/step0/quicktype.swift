// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let code: String
    let columnNames: [String]
    let data: [[Datum]]
    let description: String
    let displayURL: String
    let errors: Errors
    let frequency: String
    let fromDate: String
    let id: Int
    let name: String
    let premium: Bool
    let sourceCode: String
    let sourceName: String
    let toDate: String
    let type: String
    let updatedAt: Date
    let urlizeName: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case columnNames = "column_names"
        case data = "data"
        case description = "description"
        case displayURL = "display_url"
        case errors = "errors"
        case frequency = "frequency"
        case fromDate = "from_date"
        case id = "id"
        case name = "name"
        case premium = "premium"
        case sourceCode = "source_code"
        case sourceName = "source_name"
        case toDate = "to_date"
        case type = "type"
        case updatedAt = "updated_at"
        case urlizeName = "urlize_name"
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
        code: String? = nil,
        columnNames: [String]? = nil,
        data: [[Datum]]? = nil,
        description: String? = nil,
        displayURL: String? = nil,
        errors: Errors? = nil,
        frequency: String? = nil,
        fromDate: String? = nil,
        id: Int? = nil,
        name: String? = nil,
        premium: Bool? = nil,
        sourceCode: String? = nil,
        sourceName: String? = nil,
        toDate: String? = nil,
        type: String? = nil,
        updatedAt: Date? = nil,
        urlizeName: String? = nil
    ) -> TopLevel {
        return TopLevel(
            code: code ?? self.code,
            columnNames: columnNames ?? self.columnNames,
            data: data ?? self.data,
            description: description ?? self.description,
            displayURL: displayURL ?? self.displayURL,
            errors: errors ?? self.errors,
            frequency: frequency ?? self.frequency,
            fromDate: fromDate ?? self.fromDate,
            id: id ?? self.id,
            name: name ?? self.name,
            premium: premium ?? self.premium,
            sourceCode: sourceCode ?? self.sourceCode,
            sourceName: sourceName ?? self.sourceName,
            toDate: toDate ?? self.toDate,
            type: type ?? self.type,
            updatedAt: updatedAt ?? self.updatedAt,
            urlizeName: urlizeName ?? self.urlizeName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Datum: Codable {
    case double(Double)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Datum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Datum"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - Errors
struct Errors: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Errors convenience initializers and mutators

extension Errors {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Errors.self, from: data)
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
    ) -> Errors {
        return Errors(
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
