// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let aboveI32Max: Int
    let belowI32Min: Int
    let i32Range: Int
    let largeBounds: Int
    let onlyMaximum: Int
    let onlyMinimum: Int
    let smallNegative: Int
    let smallPositive: Int
    let unbounded: Int

    enum CodingKeys: String, CodingKey {
        case aboveI32Max = "above_i32_max"
        case belowI32Min = "below_i32_min"
        case i32Range = "i32_range"
        case largeBounds = "large_bounds"
        case onlyMaximum = "only_maximum"
        case onlyMinimum = "only_minimum"
        case smallNegative = "small_negative"
        case smallPositive = "small_positive"
        case unbounded = "unbounded"
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
        aboveI32Max: Int? = nil,
        belowI32Min: Int? = nil,
        i32Range: Int? = nil,
        largeBounds: Int? = nil,
        onlyMaximum: Int? = nil,
        onlyMinimum: Int? = nil,
        smallNegative: Int? = nil,
        smallPositive: Int? = nil,
        unbounded: Int? = nil
    ) -> TopLevel {
        return TopLevel(
            aboveI32Max: aboveI32Max ?? self.aboveI32Max,
            belowI32Min: belowI32Min ?? self.belowI32Min,
            i32Range: i32Range ?? self.i32Range,
            largeBounds: largeBounds ?? self.largeBounds,
            onlyMaximum: onlyMaximum ?? self.onlyMaximum,
            onlyMinimum: onlyMinimum ?? self.onlyMinimum,
            smallNegative: smallNegative ?? self.smallNegative,
            smallPositive: smallPositive ?? self.smallPositive,
            unbounded: unbounded ?? self.unbounded
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
