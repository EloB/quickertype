// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let designation: String
    let discoveryDate: Date
    let hMag: String?
    let iDeg: String
    let moidAu: String
    let orbitClass: OrbitClass
    let periodYr: String?
    let pha: Pha
    let qAu1: String
    let qAu2: String?

    enum CodingKeys: String, CodingKey {
        case designation = "designation"
        case discoveryDate = "discovery_date"
        case hMag = "h_mag"
        case iDeg = "i_deg"
        case moidAu = "moid_au"
        case orbitClass = "orbit_class"
        case periodYr = "period_yr"
        case pha = "pha"
        case qAu1 = "q_au_1"
        case qAu2 = "q_au_2"
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
        designation: String? = nil,
        discoveryDate: Date? = nil,
        hMag: String?? = nil,
        iDeg: String? = nil,
        moidAu: String? = nil,
        orbitClass: OrbitClass? = nil,
        periodYr: String?? = nil,
        pha: Pha? = nil,
        qAu1: String? = nil,
        qAu2: String?? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            designation: designation ?? self.designation,
            discoveryDate: discoveryDate ?? self.discoveryDate,
            hMag: hMag ?? self.hMag,
            iDeg: iDeg ?? self.iDeg,
            moidAu: moidAu ?? self.moidAu,
            orbitClass: orbitClass ?? self.orbitClass,
            periodYr: periodYr ?? self.periodYr,
            pha: pha ?? self.pha,
            qAu1: qAu1 ?? self.qAu1,
            qAu2: qAu2 ?? self.qAu2
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum OrbitClass: String, Codable {
    case apollo = "Apollo"
    case amor = "Amor"
    case aten = "Aten"
    case comet = "Comet"
    case jupiterFamilyComet = "Jupiter-family Comet"
    case halleyTypeComet = "Halley-type Comet*"
    case parabolicComet = "Parabolic Comet"
    case orbitClassJupiterFamilyComet = "Jupiter-family Comet*"
    case enckeTypeComet = "Encke-type Comet"
}

enum Pha: String, Codable {
    case y = "Y"
    case n = "N"
    case nA = "n/a"
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
