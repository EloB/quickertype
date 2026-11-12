// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

enum TopLevelUnion: Codable {
    case fluffyTopLevel(FluffyTopLevel)
    case purpleTopLevelArray([PurpleTopLevel])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([PurpleTopLevel].self) {
            self = .purpleTopLevelArray(x)
            return
        }
        if let x = try? container.decode(FluffyTopLevel.self) {
            self = .fluffyTopLevel(x)
            return
        }
        throw DecodingError.typeMismatch(TopLevelUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TopLevelUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffyTopLevel(let x):
            try container.encode(x)
        case .purpleTopLevelArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PurpleTopLevel
struct PurpleTopLevel: Codable {
    let adminregion: Adminregion
    let capitalCity: String
    let id: String
    let incomeLevel: Adminregion
    let iso2Code: String
    let latitude: String
    let lendingType: Adminregion
    let longitude: String
    let name: String
    let region: Adminregion

    enum CodingKeys: String, CodingKey {
        case adminregion = "adminregion"
        case capitalCity = "capitalCity"
        case id = "id"
        case incomeLevel = "incomeLevel"
        case iso2Code = "iso2Code"
        case latitude = "latitude"
        case lendingType = "lendingType"
        case longitude = "longitude"
        case name = "name"
        case region = "region"
    }
}

// MARK: PurpleTopLevel convenience initializers and mutators

extension PurpleTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleTopLevel.self, from: data)
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
        adminregion: Adminregion? = nil,
        capitalCity: String? = nil,
        id: String? = nil,
        incomeLevel: Adminregion? = nil,
        iso2Code: String? = nil,
        latitude: String? = nil,
        lendingType: Adminregion? = nil,
        longitude: String? = nil,
        name: String? = nil,
        region: Adminregion? = nil
    ) -> PurpleTopLevel {
        return PurpleTopLevel(
            adminregion: adminregion ?? self.adminregion,
            capitalCity: capitalCity ?? self.capitalCity,
            id: id ?? self.id,
            incomeLevel: incomeLevel ?? self.incomeLevel,
            iso2Code: iso2Code ?? self.iso2Code,
            latitude: latitude ?? self.latitude,
            lendingType: lendingType ?? self.lendingType,
            longitude: longitude ?? self.longitude,
            name: name ?? self.name,
            region: region ?? self.region
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Adminregion
struct Adminregion: Codable {
    let id: ID
    let value: Value

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
}

// MARK: Adminregion convenience initializers and mutators

extension Adminregion {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Adminregion.self, from: data)
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
        id: ID? = nil,
        value: Value? = nil
    ) -> Adminregion {
        return Adminregion(
            id: id ?? self.id,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ID: String, Codable {
    case empty = ""
    case sas = "SAS"
    case ssa = "SSA"
    case eca = "ECA"
    case lac = "LAC"
    case eap = "EAP"
    case mna = "MNA"
    case hic = "HIC"
    case lic = "LIC"
    case na = "NA"
    case lmc = "LMC"
    case umc = "UMC"
    case lnx = "LNX"
    case idx = "IDX"
    case ibd = "IBD"
    case idb = "IDB"
    case lcn = "LCN"
    case ssf = "SSF"
    case ecs = "ECS"
    case mea = "MEA"
    case eas = "EAS"
    case nac = "NAC"
}

enum Value: String, Codable {
    case empty = ""
    case southAsia = "South Asia"
    case subSaharanAfricaExcludingHighIncome = "Sub-Saharan Africa (excluding high income)"
    case europeCentralAsiaExcludingHighIncome = "Europe & Central Asia (excluding high income)"
    case latinAmericaCaribbeanExcludingHighIncome = "Latin America & Caribbean (excluding high income)"
    case eastAsiaPacificExcludingHighIncome = "East Asia & Pacific (excluding high income)"
    case middleEastNorthAfricaExcludingHighIncome = "Middle East & North Africa (excluding high income)"
    case highIncome = "High income"
    case lowIncome = "Low income"
    case aggregates = "Aggregates"
    case lowerMiddleIncome = "Lower middle income"
    case upperMiddleIncome = "Upper middle income"
    case notClassified = "Not classified"
    case ida = "IDA"
    case ibrd = "IBRD"
    case blend = "Blend"
    case latinAmericaCaribbean = "Latin America & Caribbean "
    case subSaharanAfrica = "Sub-Saharan Africa "
    case europeCentralAsia = "Europe & Central Asia"
    case middleEastNorthAfrica = "Middle East & North Africa"
    case eastAsiaPacific = "East Asia & Pacific"
    case northAmerica = "North America"
}

// MARK: - FluffyTopLevel
struct FluffyTopLevel: Codable {
    let page: Int
    let pages: Int
    let perPage: String
    let total: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perPage = "per_page"
        case total = "total"
    }
}

// MARK: FluffyTopLevel convenience initializers and mutators

extension FluffyTopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyTopLevel.self, from: data)
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
        page: Int? = nil,
        pages: Int? = nil,
        perPage: String? = nil,
        total: Int? = nil
    ) -> FluffyTopLevel {
        return FluffyTopLevel(
            page: page ?? self.page,
            pages: pages ?? self.pages,
            perPage: perPage ?? self.perPage,
            total: total ?? self.total
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias TopLevel = [TopLevelUnion]

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
