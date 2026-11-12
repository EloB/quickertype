// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let query: Query

    enum CodingKeys: String, CodingKey {
        case query = "query"
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
        query: Query? = nil
    ) -> TopLevel {
        return TopLevel(
            query: query ?? self.query
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Query
struct Query: Codable {
    let count: Int
    let created: Date
    let lang: String
    let results: Results

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case created = "created"
        case lang = "lang"
        case results = "results"
    }
}

// MARK: Query convenience initializers and mutators

extension Query {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Query.self, from: data)
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
        created: Date? = nil,
        lang: String? = nil,
        results: Results? = nil
    ) -> Query {
        return Query(
            count: count ?? self.count,
            created: created ?? self.created,
            lang: lang ?? self.lang,
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

// MARK: - Results
struct Results: Codable {
    let channel: Channel

    enum CodingKeys: String, CodingKey {
        case channel = "channel"
    }
}

// MARK: Results convenience initializers and mutators

extension Results {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Results.self, from: data)
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
        channel: Channel? = nil
    ) -> Results {
        return Results(
            channel: channel ?? self.channel
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Channel
struct Channel: Codable {
    let astronomy: Astronomy
    let atmosphere: Atmosphere
    let description: String
    let image: Image
    let item: Item
    let language: String
    let lastBuildDate: String
    let link: String
    let location: Location
    let title: String
    let ttl: String
    let units: Units
    let wind: Wind

    enum CodingKeys: String, CodingKey {
        case astronomy = "astronomy"
        case atmosphere = "atmosphere"
        case description = "description"
        case image = "image"
        case item = "item"
        case language = "language"
        case lastBuildDate = "lastBuildDate"
        case link = "link"
        case location = "location"
        case title = "title"
        case ttl = "ttl"
        case units = "units"
        case wind = "wind"
    }
}

// MARK: Channel convenience initializers and mutators

extension Channel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Channel.self, from: data)
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
        astronomy: Astronomy? = nil,
        atmosphere: Atmosphere? = nil,
        description: String? = nil,
        image: Image? = nil,
        item: Item? = nil,
        language: String? = nil,
        lastBuildDate: String? = nil,
        link: String? = nil,
        location: Location? = nil,
        title: String? = nil,
        ttl: String? = nil,
        units: Units? = nil,
        wind: Wind? = nil
    ) -> Channel {
        return Channel(
            astronomy: astronomy ?? self.astronomy,
            atmosphere: atmosphere ?? self.atmosphere,
            description: description ?? self.description,
            image: image ?? self.image,
            item: item ?? self.item,
            language: language ?? self.language,
            lastBuildDate: lastBuildDate ?? self.lastBuildDate,
            link: link ?? self.link,
            location: location ?? self.location,
            title: title ?? self.title,
            ttl: ttl ?? self.ttl,
            units: units ?? self.units,
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

// MARK: - Astronomy
struct Astronomy: Codable {
    let sunrise: String
    let sunset: String

    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: Astronomy convenience initializers and mutators

extension Astronomy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Astronomy.self, from: data)
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
        sunrise: String? = nil,
        sunset: String? = nil
    ) -> Astronomy {
        return Astronomy(
            sunrise: sunrise ?? self.sunrise,
            sunset: sunset ?? self.sunset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Atmosphere
struct Atmosphere: Codable {
    let humidity: String
    let pressure: String
    let rising: String
    let visibility: String

    enum CodingKeys: String, CodingKey {
        case humidity = "humidity"
        case pressure = "pressure"
        case rising = "rising"
        case visibility = "visibility"
    }
}

// MARK: Atmosphere convenience initializers and mutators

extension Atmosphere {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Atmosphere.self, from: data)
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
        humidity: String? = nil,
        pressure: String? = nil,
        rising: String? = nil,
        visibility: String? = nil
    ) -> Atmosphere {
        return Atmosphere(
            humidity: humidity ?? self.humidity,
            pressure: pressure ?? self.pressure,
            rising: rising ?? self.rising,
            visibility: visibility ?? self.visibility
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Image
struct Image: Codable {
    let height: String
    let link: String
    let title: String
    let url: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case link = "link"
        case title = "title"
        case url = "url"
        case width = "width"
    }
}

// MARK: Image convenience initializers and mutators

extension Image {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Image.self, from: data)
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
        height: String? = nil,
        link: String? = nil,
        title: String? = nil,
        url: String? = nil,
        width: String? = nil
    ) -> Image {
        return Image(
            height: height ?? self.height,
            link: link ?? self.link,
            title: title ?? self.title,
            url: url ?? self.url,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Item
struct Item: Codable {
    let condition: Condition
    let description: String
    let forecast: [Forecast]
    let guid: GUID
    let lat: String
    let link: String
    let long: String
    let pubDate: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case condition = "condition"
        case description = "description"
        case forecast = "forecast"
        case guid = "guid"
        case lat = "lat"
        case link = "link"
        case long = "long"
        case pubDate = "pubDate"
        case title = "title"
    }
}

// MARK: Item convenience initializers and mutators

extension Item {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Item.self, from: data)
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
        condition: Condition? = nil,
        description: String? = nil,
        forecast: [Forecast]? = nil,
        guid: GUID? = nil,
        lat: String? = nil,
        link: String? = nil,
        long: String? = nil,
        pubDate: String? = nil,
        title: String? = nil
    ) -> Item {
        return Item(
            condition: condition ?? self.condition,
            description: description ?? self.description,
            forecast: forecast ?? self.forecast,
            guid: guid ?? self.guid,
            lat: lat ?? self.lat,
            link: link ?? self.link,
            long: long ?? self.long,
            pubDate: pubDate ?? self.pubDate,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Condition
struct Condition: Codable {
    let code: String
    let date: String
    let temp: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case date = "date"
        case temp = "temp"
        case text = "text"
    }
}

// MARK: Condition convenience initializers and mutators

extension Condition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Condition.self, from: data)
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
        date: String? = nil,
        temp: String? = nil,
        text: String? = nil
    ) -> Condition {
        return Condition(
            code: code ?? self.code,
            date: date ?? self.date,
            temp: temp ?? self.temp,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let code: String
    let date: String
    let day: String
    let high: String
    let low: String
    let text: Text

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case date = "date"
        case day = "day"
        case high = "high"
        case low = "low"
        case text = "text"
    }
}

// MARK: Forecast convenience initializers and mutators

extension Forecast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Forecast.self, from: data)
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
        date: String? = nil,
        day: String? = nil,
        high: String? = nil,
        low: String? = nil,
        text: Text? = nil
    ) -> Forecast {
        return Forecast(
            code: code ?? self.code,
            date: date ?? self.date,
            day: day ?? self.day,
            high: high ?? self.high,
            low: low ?? self.low,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Text: String, Codable {
    case sunny = "Sunny"
}

// MARK: - GUID
struct GUID: Codable {
    let isPermaLink: String

    enum CodingKeys: String, CodingKey {
        case isPermaLink = "isPermaLink"
    }
}

// MARK: GUID convenience initializers and mutators

extension GUID {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GUID.self, from: data)
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
        isPermaLink: String? = nil
    ) -> GUID {
        return GUID(
            isPermaLink: isPermaLink ?? self.isPermaLink
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Location
struct Location: Codable {
    let city: String
    let country: String
    let region: String

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case region = "region"
    }
}

// MARK: Location convenience initializers and mutators

extension Location {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Location.self, from: data)
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
        country: String? = nil,
        region: String? = nil
    ) -> Location {
        return Location(
            city: city ?? self.city,
            country: country ?? self.country,
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

// MARK: - Units
struct Units: Codable {
    let distance: String
    let pressure: String
    let speed: String
    let temperature: String

    enum CodingKeys: String, CodingKey {
        case distance = "distance"
        case pressure = "pressure"
        case speed = "speed"
        case temperature = "temperature"
    }
}

// MARK: Units convenience initializers and mutators

extension Units {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Units.self, from: data)
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
        distance: String? = nil,
        pressure: String? = nil,
        speed: String? = nil,
        temperature: String? = nil
    ) -> Units {
        return Units(
            distance: distance ?? self.distance,
            pressure: pressure ?? self.pressure,
            speed: speed ?? self.speed,
            temperature: temperature ?? self.temperature
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Wind
struct Wind: Codable {
    let chill: String
    let direction: String
    let speed: String

    enum CodingKeys: String, CodingKey {
        case chill = "chill"
        case direction = "direction"
        case speed = "speed"
    }
}

// MARK: Wind convenience initializers and mutators

extension Wind {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Wind.self, from: data)
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
        chill: String? = nil,
        direction: String? = nil,
        speed: String? = nil
    ) -> Wind {
        return Wind(
            chill: chill ?? self.chill,
            direction: direction ?? self.direction,
            speed: speed ?? self.speed
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
