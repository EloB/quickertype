// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let birthDate: Date?
    let birthDateIsProtected: Bool
    let genderTypeID: Int
    let notes: String
    let parliamentaryName: String
    let personID: Int
    let photoURL: String
    let preferredName: String

    enum CodingKeys: String, CodingKey {
        case birthDate = "BirthDate"
        case birthDateIsProtected = "BirthDateIsProtected"
        case genderTypeID = "GenderTypeID"
        case notes = "Notes"
        case parliamentaryName = "ParliamentaryName"
        case personID = "PersonID"
        case photoURL = "PhotoURL"
        case preferredName = "PreferredName"
    }
}

// MARK: TopLevelElement convenience initializers and mutators

extension TopLevelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelElement.self, from: data)
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
        birthDate: Date?? = nil,
        birthDateIsProtected: Bool? = nil,
        genderTypeID: Int? = nil,
        notes: String? = nil,
        parliamentaryName: String? = nil,
        personID: Int? = nil,
        photoURL: String? = nil,
        preferredName: String? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            birthDate: birthDate ?? self.birthDate,
            birthDateIsProtected: birthDateIsProtected ?? self.birthDateIsProtected,
            genderTypeID: genderTypeID ?? self.genderTypeID,
            notes: notes ?? self.notes,
            parliamentaryName: parliamentaryName ?? self.parliamentaryName,
            personID: personID ?? self.personID,
            photoURL: photoURL ?? self.photoURL,
            preferredName: preferredName ?? self.preferredName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias TopLevel = [TopLevelElement]

extension Array where Element == TopLevel.Element {
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
