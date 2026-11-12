// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
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
        count: Int? = nil,
        next: String? = nil,
        previous: JSONNull?? = nil,
        results: [Result]? = nil
    ) -> TopLevel {
        return TopLevel(
            count: count ?? self.count,
            next: next ?? self.next,
            previous: previous ?? self.previous,
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Result
struct Result: Codable {
    let code: String
    let english: String
    let fav: Bool
    let group: Group
    let location: Location
    let minScreens: Int
    let numViews: Int
    let showtimes: String
    let stars: Int
    let tel: Tel
    let thai: String
    let todayScreens: Int
    let url: String
    let website: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case english = "english"
        case fav = "fav"
        case group = "group"
        case location = "location"
        case minScreens = "min_screens"
        case numViews = "num_views"
        case showtimes = "showtimes"
        case stars = "stars"
        case tel = "tel"
        case thai = "thai"
        case todayScreens = "today_screens"
        case url = "url"
        case website = "website"
    }
}

// MARK: Result convenience initializers and mutators

extension Result {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Result.self, from: data)
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
        code: String? = nil,
        english: String? = nil,
        fav: Bool? = nil,
        group: Group? = nil,
        location: Location? = nil,
        minScreens: Int? = nil,
        numViews: Int? = nil,
        showtimes: String? = nil,
        stars: Int? = nil,
        tel: Tel? = nil,
        thai: String? = nil,
        todayScreens: Int? = nil,
        url: String? = nil,
        website: String? = nil
    ) -> Result {
        return Result(
            code: code ?? self.code,
            english: english ?? self.english,
            fav: fav ?? self.fav,
            group: group ?? self.group,
            location: location ?? self.location,
            minScreens: minScreens ?? self.minScreens,
            numViews: numViews ?? self.numViews,
            showtimes: showtimes ?? self.showtimes,
            stars: stars ?? self.stars,
            tel: tel ?? self.tel,
            thai: thai ?? self.thai,
            todayScreens: todayScreens ?? self.todayScreens,
            url: url ?? self.url,
            website: website ?? self.website
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Group
struct Group: Codable {
    let code: Code
    let english: English
    let thai: Thai
    let website: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case english = "english"
        case thai = "thai"
        case website = "website"
    }
}

// MARK: Group convenience initializers and mutators

extension Group {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Group.self, from: data)
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
        code: Code? = nil,
        english: English? = nil,
        thai: Thai? = nil,
        website: String? = nil
    ) -> Group {
        return Group(
            code: code ?? self.code,
            english: english ?? self.english,
            thai: thai ?? self.thai,
            website: website ?? self.website
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Code: String, Codable {
    case sf = "sf"
}

enum English: String, Codable {
    case sf = "SF"
}

enum Thai: String, Codable {
    case เอสเอฟ = "เอสเอฟ"
}

enum Location: String, Codable {
    case empty = ""
    case the5ThFLEmporium = "5th Fl. Emporium"
}

enum Tel: String, Codable {
    case empty = ""
    case the022688899 = "02-268-8899"
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
