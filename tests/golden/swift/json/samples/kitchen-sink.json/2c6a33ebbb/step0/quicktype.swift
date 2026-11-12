// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let booleanValue: Bool
    let dateValue: String
    let differentThings: [DifferentThingElement]
    let doubleValue: Double
    let intValue: Int
    let mapValue: [String: Int?]
    let nameWithSpaces: JSONNull?
    let nullValue: JSONNull?
    let nullableMapValue: [String: Int?]
    let people: [PersonElement]
    let person: PurplePerson
    let stringValue: String
    let tuples: [[IntOrString]]
    let uuidValue: String

    enum CodingKeys: String, CodingKey {
        case booleanValue = "booleanValue"
        case dateValue = "dateValue"
        case differentThings = "differentThings"
        case doubleValue = "doubleValue"
        case intValue = "intValue"
        case mapValue = "mapValue"
        case nameWithSpaces = "name with spaces"
        case nullValue = "nullValue"
        case nullableMapValue = "nullableMapValue"
        case people = "people"
        case person = "person"
        case stringValue = "stringValue"
        case tuples = "tuples"
        case uuidValue = "uuidValue"
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
        booleanValue: Bool? = nil,
        dateValue: String? = nil,
        differentThings: [DifferentThingElement]? = nil,
        doubleValue: Double? = nil,
        intValue: Int? = nil,
        mapValue: [String: Int?]? = nil,
        nameWithSpaces: JSONNull?? = nil,
        nullValue: JSONNull?? = nil,
        nullableMapValue: [String: Int?]? = nil,
        people: [PersonElement]? = nil,
        person: PurplePerson? = nil,
        stringValue: String? = nil,
        tuples: [[IntOrString]]? = nil,
        uuidValue: String? = nil
    ) -> TopLevel {
        return TopLevel(
            booleanValue: booleanValue ?? self.booleanValue,
            dateValue: dateValue ?? self.dateValue,
            differentThings: differentThings ?? self.differentThings,
            doubleValue: doubleValue ?? self.doubleValue,
            intValue: intValue ?? self.intValue,
            mapValue: mapValue ?? self.mapValue,
            nameWithSpaces: nameWithSpaces ?? self.nameWithSpaces,
            nullValue: nullValue ?? self.nullValue,
            nullableMapValue: nullableMapValue ?? self.nullableMapValue,
            people: people ?? self.people,
            person: person ?? self.person,
            stringValue: stringValue ?? self.stringValue,
            tuples: tuples ?? self.tuples,
            uuidValue: uuidValue ?? self.uuidValue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum DifferentThingElement: Codable {
    case differentThingClass(DifferentThingClass)
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(DifferentThingClass.self) {
            self = .differentThingClass(x)
            return
        }
        throw DecodingError.typeMismatch(DifferentThingElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DifferentThingElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .differentThingClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DifferentThingClass
struct DifferentThingClass: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

// MARK: DifferentThingClass convenience initializers and mutators

extension DifferentThingClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DifferentThingClass.self, from: data)
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
        name: String? = nil
    ) -> DifferentThingClass {
        return DifferentThingClass(
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PersonElement
struct PersonElement: Codable {
    let intOrString: IntOrString
    let name: String
    let optionalValue: Bool?

    enum CodingKeys: String, CodingKey {
        case intOrString = "intOrString"
        case name = "name"
        case optionalValue = "optionalValue"
    }
}

// MARK: PersonElement convenience initializers and mutators

extension PersonElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PersonElement.self, from: data)
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
        intOrString: IntOrString? = nil,
        name: String? = nil,
        optionalValue: Bool?? = nil
    ) -> PersonElement {
        return PersonElement(
            intOrString: intOrString ?? self.intOrString,
            name: name ?? self.name,
            optionalValue: optionalValue ?? self.optionalValue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum IntOrString: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(IntOrString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IntOrString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PurplePerson
struct PurplePerson: Codable {
    let intOrString: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case intOrString = "intOrString"
        case name = "name"
    }
}

// MARK: PurplePerson convenience initializers and mutators

extension PurplePerson {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurplePerson.self, from: data)
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
        intOrString: Int? = nil,
        name: String? = nil
    ) -> PurplePerson {
        return PurplePerson(
            intOrString: intOrString ?? self.intOrString,
            name: name ?? self.name
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
