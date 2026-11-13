// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let stringValue: String
    let dateValue: String
    let uuidValue: String
    let nameWithSpaces: JSONNull?
    let doubleValue: Double
    let intValue: Int
    let booleanValue: Bool
    let nullValue: JSONNull?
    let tuples: [[IntOrString]]
    let person: PurplePerson
    let people: [PersonElement]
    let differentThings: [DifferentThingElement]
    let mapValue: [String: Int?]
    let nullableMapValue: [String: Int?]

    enum CodingKeys: String, CodingKey {
        case stringValue = "stringValue"
        case dateValue = "dateValue"
        case uuidValue = "uuidValue"
        case nameWithSpaces = "name with spaces"
        case doubleValue = "doubleValue"
        case intValue = "intValue"
        case booleanValue = "booleanValue"
        case nullValue = "nullValue"
        case tuples = "tuples"
        case person = "person"
        case people = "people"
        case differentThings = "differentThings"
        case mapValue = "mapValue"
        case nullableMapValue = "nullableMapValue"
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
        stringValue: String? = nil,
        dateValue: String? = nil,
        uuidValue: String? = nil,
        nameWithSpaces: JSONNull?? = nil,
        doubleValue: Double? = nil,
        intValue: Int? = nil,
        booleanValue: Bool? = nil,
        nullValue: JSONNull?? = nil,
        tuples: [[IntOrString]]? = nil,
        person: PurplePerson? = nil,
        people: [PersonElement]? = nil,
        differentThings: [DifferentThingElement]? = nil,
        mapValue: [String: Int?]? = nil,
        nullableMapValue: [String: Int?]? = nil
    ) -> TopLevel {
        return TopLevel(
            stringValue: stringValue ?? self.stringValue,
            dateValue: dateValue ?? self.dateValue,
            uuidValue: uuidValue ?? self.uuidValue,
            nameWithSpaces: nameWithSpaces ?? self.nameWithSpaces,
            doubleValue: doubleValue ?? self.doubleValue,
            intValue: intValue ?? self.intValue,
            booleanValue: booleanValue ?? self.booleanValue,
            nullValue: nullValue ?? self.nullValue,
            tuples: tuples ?? self.tuples,
            person: person ?? self.person,
            people: people ?? self.people,
            differentThings: differentThings ?? self.differentThings,
            mapValue: mapValue ?? self.mapValue,
            nullableMapValue: nullableMapValue ?? self.nullableMapValue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
