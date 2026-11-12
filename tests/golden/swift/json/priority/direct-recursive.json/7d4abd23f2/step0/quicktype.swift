// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
class TopLevel: Codable {
    let also: TopLevel?
    let bar: Bool
    let foo: Int
    let moo: Double
    let quux: String

    enum CodingKeys: String, CodingKey {
        case also = "also"
        case bar = "bar"
        case foo = "foo"
        case moo = "moo"
        case quux = "quux"
    }

    init(also: TopLevel?, bar: Bool, foo: Int, moo: Double, quux: String) {
        self.also = also
        self.bar = bar
        self.foo = foo
        self.moo = moo
        self.quux = quux
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TopLevel.self, from: data)
        self.init(also: me.also, bar: me.bar, foo: me.foo, moo: me.moo, quux: me.quux)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        also: TopLevel?? = nil,
        bar: Bool? = nil,
        foo: Int? = nil,
        moo: Double? = nil,
        quux: String? = nil
    ) -> TopLevel {
        return TopLevel(
            also: also ?? self.also,
            bar: bar ?? self.bar,
            foo: foo ?? self.foo,
            moo: moo ?? self.moo,
            quux: quux ?? self.quux
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
