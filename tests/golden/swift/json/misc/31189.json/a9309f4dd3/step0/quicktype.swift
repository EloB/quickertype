// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let details: String
    let rates: [Rate]
    let version: JSONNull?

    enum CodingKeys: String, CodingKey {
        case details = "details"
        case rates = "rates"
        case version = "version"
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
        details: String? = nil,
        rates: [Rate]? = nil,
        version: JSONNull?? = nil
    ) -> TopLevel {
        return TopLevel(
            details: details ?? self.details,
            rates: rates ?? self.rates,
            version: version ?? self.version
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Rate
struct Rate: Codable {
    let code: String
    let countryCode: String
    let name: String
    let periods: [Period]

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case countryCode = "country_code"
        case name = "name"
        case periods = "periods"
    }
}

// MARK: Rate convenience initializers and mutators

extension Rate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rate.self, from: data)
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
        countryCode: String? = nil,
        name: String? = nil,
        periods: [Period]? = nil
    ) -> Rate {
        return Rate(
            code: code ?? self.code,
            countryCode: countryCode ?? self.countryCode,
            name: name ?? self.name,
            periods: periods ?? self.periods
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Period
struct Period: Codable {
    let effectiveFrom: String
    let rates: Rates

    enum CodingKeys: String, CodingKey {
        case effectiveFrom = "effective_from"
        case rates = "rates"
    }
}

// MARK: Period convenience initializers and mutators

extension Period {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Period.self, from: data)
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
        effectiveFrom: String? = nil,
        rates: Rates? = nil
    ) -> Period {
        return Period(
            effectiveFrom: effectiveFrom ?? self.effectiveFrom,
            rates: rates ?? self.rates
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Rates
struct Rates: Codable {
    let parking: Double?
    let reduced: Double?
    let reduced1: Double?
    let reduced2: Double?
    let standard: Double
    let superReduced: Double?

    enum CodingKeys: String, CodingKey {
        case parking = "parking"
        case reduced = "reduced"
        case reduced1 = "reduced1"
        case reduced2 = "reduced2"
        case standard = "standard"
        case superReduced = "super_reduced"
    }
}

// MARK: Rates convenience initializers and mutators

extension Rates {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rates.self, from: data)
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
        parking: Double?? = nil,
        reduced: Double?? = nil,
        reduced1: Double?? = nil,
        reduced2: Double?? = nil,
        standard: Double? = nil,
        superReduced: Double?? = nil
    ) -> Rates {
        return Rates(
            parking: parking ?? self.parking,
            reduced: reduced ?? self.reduced,
            reduced1: reduced1 ?? self.reduced1,
            reduced2: reduced2 ?? self.reduced2,
            standard: standard ?? self.standard,
            superReduced: superReduced ?? self.superReduced
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
