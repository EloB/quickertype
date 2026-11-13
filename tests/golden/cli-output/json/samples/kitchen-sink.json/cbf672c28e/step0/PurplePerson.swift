// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let purplePerson = try PurplePerson(json)

import Foundation

// MARK: - PurplePerson
struct PurplePerson: Codable {
    let name: String
    let intOrString: Int

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case intOrString = "intOrString"
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
        name: String? = nil,
        intOrString: Int? = nil
    ) -> PurplePerson {
        return PurplePerson(
            name: name ?? self.name,
            intOrString: intOrString ?? self.intOrString
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
