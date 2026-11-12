// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let bla: TopLevelBla
    let empty: Empty
    let foo: Foo
    let thisIsAToughOne: ThisIsAToughOne
    let topLevel: Int
    let topLevelEmpty: EmptyClass

    enum CodingKeys: String, CodingKey {
        case bla = "bla"
        case empty = ""
        case foo = "foo"
        case thisIsAToughOne = "ThisIsA\u{1f61c}Tough\"\n\nOne"
        case topLevel = "!"
        case topLevelEmpty = "Empty"
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
        bla: TopLevelBla? = nil,
        empty: Empty? = nil,
        foo: Foo? = nil,
        thisIsAToughOne: ThisIsAToughOne? = nil,
        topLevel: Int? = nil,
        topLevelEmpty: EmptyClass? = nil
    ) -> TopLevel {
        return TopLevel(
            bla: bla ?? self.bla,
            empty: empty ?? self.empty,
            foo: foo ?? self.foo,
            thisIsAToughOne: thisIsAToughOne ?? self.thisIsAToughOne,
            topLevel: topLevel ?? self.topLevel,
            topLevelEmpty: topLevelEmpty ?? self.topLevelEmpty
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TopLevelBla
struct TopLevelBla: Codable {
    let bar: Int

    enum CodingKeys: String, CodingKey {
        case bar = "bar"
    }
}

// MARK: TopLevelBla convenience initializers and mutators

extension TopLevelBla {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelBla.self, from: data)
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
        bar: Int? = nil
    ) -> TopLevelBla {
        return TopLevelBla(
            bar: bar ?? self.bar
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Empty
struct Empty: Codable {
    let x: Int

    enum CodingKeys: String, CodingKey {
        case x = "x"
    }
}

// MARK: Empty convenience initializers and mutators

extension Empty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Empty.self, from: data)
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
        x: Int? = nil
    ) -> Empty {
        return Empty(
            x: x ?? self.x
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Foo
struct Foo: Codable {
    let bla: FooBla
    let empty: Int
    let foo: Int

    enum CodingKeys: String, CodingKey {
        case bla = "bla"
        case empty = "_"
        case foo = "__"
    }
}

// MARK: Foo convenience initializers and mutators

extension Foo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Foo.self, from: data)
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
        bla: FooBla? = nil,
        empty: Int? = nil,
        foo: Int? = nil
    ) -> Foo {
        return Foo(
            bla: bla ?? self.bla,
            empty: empty ?? self.empty,
            foo: foo ?? self.foo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FooBla
struct FooBla: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: FooBla convenience initializers and mutators

extension FooBla {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FooBla.self, from: data)
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
    ) -> FooBla {
        return FooBla(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ThisIsAToughOne
struct ThisIsAToughOne: Codable {
    let empty: Int
    let thisIsAToughOne: Int

    enum CodingKeys: String, CodingKey {
        case empty = "\n\n\n"
        case thisIsAToughOne = "\""
    }
}

// MARK: ThisIsAToughOne convenience initializers and mutators

extension ThisIsAToughOne {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ThisIsAToughOne.self, from: data)
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
        empty: Int? = nil,
        thisIsAToughOne: Int? = nil
    ) -> ThisIsAToughOne {
        return ThisIsAToughOne(
            empty: empty ?? self.empty,
            thisIsAToughOne: thisIsAToughOne ?? self.thisIsAToughOne
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EmptyClass
struct EmptyClass: Codable {
    let y: Int

    enum CodingKeys: String, CodingKey {
        case y = "y"
    }
}

// MARK: EmptyClass convenience initializers and mutators

extension EmptyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EmptyClass.self, from: data)
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
        y: Int? = nil
    ) -> EmptyClass {
        return EmptyClass(
            y: y ?? self.y
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
