// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let city: String
    let delay: String
    let iata: String
    let icao: String
    let name: String
    let state: String
    let status: Status
    let weather: Weather

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case delay = "delay"
        case iata = "IATA"
        case icao = "ICAO"
        case name = "name"
        case state = "state"
        case status = "status"
        case weather = "weather"
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
        city: String? = nil,
        delay: String? = nil,
        iata: String? = nil,
        icao: String? = nil,
        name: String? = nil,
        state: String? = nil,
        status: Status? = nil,
        weather: Weather? = nil
    ) -> TopLevel {
        return TopLevel(
            city: city ?? self.city,
            delay: delay ?? self.delay,
            iata: iata ?? self.iata,
            icao: icao ?? self.icao,
            name: name ?? self.name,
            state: state ?? self.state,
            status: status ?? self.status,
            weather: weather ?? self.weather
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Status
struct Status: Codable {
    let avgDelay: String
    let closureBegin: String
    let closureEnd: String
    let endTime: String
    let maxDelay: String
    let minDelay: String
    let reason: String
    let trend: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case avgDelay = "avgDelay"
        case closureBegin = "closureBegin"
        case closureEnd = "closureEnd"
        case endTime = "endTime"
        case maxDelay = "maxDelay"
        case minDelay = "minDelay"
        case reason = "reason"
        case trend = "trend"
        case type = "type"
    }
}

// MARK: Status convenience initializers and mutators

extension Status {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Status.self, from: data)
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
        avgDelay: String? = nil,
        closureBegin: String? = nil,
        closureEnd: String? = nil,
        endTime: String? = nil,
        maxDelay: String? = nil,
        minDelay: String? = nil,
        reason: String? = nil,
        trend: String? = nil,
        type: String? = nil
    ) -> Status {
        return Status(
            avgDelay: avgDelay ?? self.avgDelay,
            closureBegin: closureBegin ?? self.closureBegin,
            closureEnd: closureEnd ?? self.closureEnd,
            endTime: endTime ?? self.endTime,
            maxDelay: maxDelay ?? self.maxDelay,
            minDelay: minDelay ?? self.minDelay,
            reason: reason ?? self.reason,
            trend: trend ?? self.trend,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weather
struct Weather: Codable {
    let meta: Meta
    let temp: String
    let visibility: Double
    let weather: String
    let wind: String

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case temp = "temp"
        case visibility = "visibility"
        case weather = "weather"
        case wind = "wind"
    }
}

// MARK: Weather convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
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
        meta: Meta? = nil,
        temp: String? = nil,
        visibility: Double? = nil,
        weather: String? = nil,
        wind: String? = nil
    ) -> Weather {
        return Weather(
            meta: meta ?? self.meta,
            temp: temp ?? self.temp,
            visibility: visibility ?? self.visibility,
            weather: weather ?? self.weather,
            wind: wind ?? self.wind
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Meta
struct Meta: Codable {
    let credit: String
    let updated: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case credit = "credit"
        case updated = "updated"
        case url = "url"
    }
}

// MARK: Meta convenience initializers and mutators

extension Meta {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Meta.self, from: data)
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
        credit: String? = nil,
        updated: String? = nil,
        url: String? = nil
    ) -> Meta {
        return Meta(
            credit: credit ?? self.credit,
            updated: updated ?? self.updated,
            url: url ?? self.url
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
