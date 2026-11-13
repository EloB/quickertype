// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personElement = try PersonElement(json)

import Foundation

// MARK: - PersonElement
struct PersonElement: Codable {
    let name: String
    let intOrString: IntOrString
    let optionalValue: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case intOrString = "intOrString"
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
        name: String? = nil,
        intOrString: IntOrString? = nil,
        optionalValue: Bool?? = nil
    ) -> PersonElement {
        return PersonElement(
            name: name ?? self.name,
            intOrString: intOrString ?? self.intOrString,
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
