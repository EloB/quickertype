// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let empty: String
    let null: String
    let purpleX: String
    let topLevel: String
    let topLevelContinue: String
    let topLevelX: String
    let undefined: String
    let x: String
    let xY: String

    enum CodingKeys: String, CodingKey {
        case empty = ""
        case null = "null"
        case purpleX = "x'"
        case topLevel = "{}"
        case topLevelContinue = "continue"
        case topLevelX = "x\""
        case undefined = "undefined"
        case x = "x"
        case xY = "x y"
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
        empty: String? = nil,
        null: String? = nil,
        purpleX: String? = nil,
        topLevel: String? = nil,
        topLevelContinue: String? = nil,
        topLevelX: String? = nil,
        undefined: String? = nil,
        x: String? = nil,
        xY: String? = nil
    ) -> TopLevel {
        return TopLevel(
            empty: empty ?? self.empty,
            null: null ?? self.null,
            purpleX: purpleX ?? self.purpleX,
            topLevel: topLevel ?? self.topLevel,
            topLevelContinue: topLevelContinue ?? self.topLevelContinue,
            topLevelX: topLevelX ?? self.topLevelX,
            undefined: undefined ?? self.undefined,
            x: x ?? self.x,
            xY: xY ?? self.xY
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
