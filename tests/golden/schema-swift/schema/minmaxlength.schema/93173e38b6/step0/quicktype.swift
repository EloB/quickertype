// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let intersection: String
    let inUnion: InUnion
    let maxlength: String
    let minlength: String
    let minMaxIntersection: String
    let minmaxlength: String
    let minMaxUnion: String
    let union: String

    enum CodingKeys: String, CodingKey {
        case intersection = "intersection"
        case inUnion = "inUnion"
        case maxlength = "maxlength"
        case minlength = "minlength"
        case minMaxIntersection = "minMaxIntersection"
        case minmaxlength = "minmaxlength"
        case minMaxUnion = "minMaxUnion"
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
        intersection: String? = nil,
        inUnion: InUnion? = nil,
        maxlength: String? = nil,
        minlength: String? = nil,
        minMaxIntersection: String? = nil,
        minmaxlength: String? = nil,
        minMaxUnion: String? = nil,
        union: String? = nil
    ) -> TopLevel {
        return TopLevel(
            intersection: intersection ?? self.intersection,
            inUnion: inUnion ?? self.inUnion,
            maxlength: maxlength ?? self.maxlength,
            minlength: minlength ?? self.minlength,
            minMaxIntersection: minMaxIntersection ?? self.minMaxIntersection,
            minmaxlength: minmaxlength ?? self.minmaxlength,
            minMaxUnion: minMaxUnion ?? self.minMaxUnion,
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

enum InUnion: Codable {
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
        throw DecodingError.typeMismatch(InUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for InUnion"))
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
