// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let arr: [Arr]?
    let topLevelFor: String?
    let gve: Gve
    let lvc: Lvc?
    let otherArr: [OtherArr]?

    enum CodingKeys: String, CodingKey {
        case arr = "arr"
        case topLevelFor = "for"
        case gve = "gve"
        case lvc = "lvc"
        case otherArr = "otherArr"
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
        arr: [Arr]?? = nil,
        topLevelFor: String?? = nil,
        gve: Gve? = nil,
        lvc: Lvc?? = nil,
        otherArr: [OtherArr]?? = nil
    ) -> TopLevel {
        return TopLevel(
            arr: arr ?? self.arr,
            topLevelFor: topLevelFor ?? self.topLevelFor,
            gve: gve ?? self.gve,
            lvc: lvc ?? self.lvc,
            otherArr: otherArr ?? self.otherArr
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Arr: Codable {
    case enumeration(OtherArr)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(OtherArr.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(Arr.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Arr"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum OtherArr: String, Codable {
    case foo = "foo"
    case bar = "bar"
    case otherArrIf = "if"
}

enum Gve: String, Codable {
    case good = "good"
    case neutral = "neutral"
    case evil = "evil"
}

enum Lvc: String, Codable {
    case lawful = "lawful"
    case neutral = "neutral"
    case chaotic = "chaotic"
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
