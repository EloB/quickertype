// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let anEasyOne: Int
    let isMNISTLetter: Bool
    let prettyEasyToo: Bool
    let shouldKnowThatIDIsAnInitialism: String
    let spacesAreSeparatorsToo: Bool
    let topLevelJSONString: String
    let zsrHhDemo3Delmatnr: Bool

    enum CodingKeys: String, CodingKey {
        case anEasyOne = "anEasyOne"
        case isMNISTLetter = "isMNISTLetter"
        case prettyEasyToo = "PrettyEasyToo"
        case shouldKnowThatIDIsAnInitialism = "should_know_that_id_is_an_initialism"
        case spacesAreSeparatorsToo = "   spaces are separators  too  "
        case topLevelJSONString = "JSONString"
        case zsrHhDemo3Delmatnr = "ZSR_HH_DEMO3_DELMATNR"
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
        anEasyOne: Int? = nil,
        isMNISTLetter: Bool? = nil,
        prettyEasyToo: Bool? = nil,
        shouldKnowThatIDIsAnInitialism: String? = nil,
        spacesAreSeparatorsToo: Bool? = nil,
        topLevelJSONString: String? = nil,
        zsrHhDemo3Delmatnr: Bool? = nil
    ) -> TopLevel {
        return TopLevel(
            anEasyOne: anEasyOne ?? self.anEasyOne,
            isMNISTLetter: isMNISTLetter ?? self.isMNISTLetter,
            prettyEasyToo: prettyEasyToo ?? self.prettyEasyToo,
            shouldKnowThatIDIsAnInitialism: shouldKnowThatIDIsAnInitialism ?? self.shouldKnowThatIDIsAnInitialism,
            spacesAreSeparatorsToo: spacesAreSeparatorsToo ?? self.spacesAreSeparatorsToo,
            topLevelJSONString: topLevelJSONString ?? self.topLevelJSONString,
            zsrHhDemo3Delmatnr: zsrHhDemo3Delmatnr ?? self.zsrHhDemo3Delmatnr
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
