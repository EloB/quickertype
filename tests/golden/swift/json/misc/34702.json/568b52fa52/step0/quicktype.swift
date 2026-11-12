// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let crs: CRS
    let features: [Feature]
    let totalFeatures: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case crs = "crs"
        case features = "features"
        case totalFeatures = "totalFeatures"
        case type = "type"
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
        crs: CRS? = nil,
        features: [Feature]? = nil,
        totalFeatures: Int? = nil,
        type: String? = nil
    ) -> TopLevel {
        return TopLevel(
            crs: crs ?? self.crs,
            features: features ?? self.features,
            totalFeatures: totalFeatures ?? self.totalFeatures,
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

// MARK: - CRS
struct CRS: Codable {
    let properties: CRSProperties
    let type: String

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
        case type = "type"
    }
}

// MARK: CRS convenience initializers and mutators

extension CRS {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRS.self, from: data)
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
        properties: CRSProperties? = nil,
        type: String? = nil
    ) -> CRS {
        return CRS(
            properties: properties ?? self.properties,
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

// MARK: - CRSProperties
struct CRSProperties: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

// MARK: CRSProperties convenience initializers and mutators

extension CRSProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRSProperties.self, from: data)
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
    ) -> CRSProperties {
        return CRSProperties(
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

// MARK: - Feature
struct Feature: Codable {
    let geometry: Geometry
    let geometryName: GeometryName
    let id: String
    let properties: FeatureProperties
    let type: FeatureType

    enum CodingKeys: String, CodingKey {
        case geometry = "geometry"
        case geometryName = "geometry_name"
        case id = "id"
        case properties = "properties"
        case type = "type"
    }
}

// MARK: Feature convenience initializers and mutators

extension Feature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Feature.self, from: data)
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
        geometry: Geometry? = nil,
        geometryName: GeometryName? = nil,
        id: String? = nil,
        properties: FeatureProperties? = nil,
        type: FeatureType? = nil
    ) -> Feature {
        return Feature(
            geometry: geometry ?? self.geometry,
            geometryName: geometryName ?? self.geometryName,
            id: id ?? self.id,
            properties: properties ?? self.properties,
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

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [Double]
    let type: GeometryType

    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type = "type"
    }
}

// MARK: Geometry convenience initializers and mutators

extension Geometry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geometry.self, from: data)
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
        coordinates: [Double]? = nil,
        type: GeometryType? = nil
    ) -> Geometry {
        return Geometry(
            coordinates: coordinates ?? self.coordinates,
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

enum GeometryType: String, Codable {
    case point = "Point"
}

enum GeometryName: String, Codable {
    case geom = "geom"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let division: String
    let fax: Double
    let fireBanR: FireBanR?
    let latitude: Double
    let localGovt: String
    let longitude: Double
    let no: String?
    let phone: Double
    let postcode: Int
    let psa: String
    let region: Region
    let station: String
    let street: String
    let suburb: String
    let type: PropertiesType?

    enum CodingKeys: String, CodingKey {
        case division = "division"
        case fax = "fax"
        case fireBanR = "fire_ban_r"
        case latitude = "latitude"
        case localGovt = "local_govt"
        case longitude = "longitude"
        case no = "no"
        case phone = "phone"
        case postcode = "postcode"
        case psa = "psa"
        case region = "region"
        case station = "station"
        case street = "street"
        case suburb = "suburb"
        case type = "type"
    }
}

// MARK: FeatureProperties convenience initializers and mutators

extension FeatureProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FeatureProperties.self, from: data)
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
        division: String? = nil,
        fax: Double? = nil,
        fireBanR: FireBanR?? = nil,
        latitude: Double? = nil,
        localGovt: String? = nil,
        longitude: Double? = nil,
        no: String?? = nil,
        phone: Double? = nil,
        postcode: Int? = nil,
        psa: String? = nil,
        region: Region? = nil,
        station: String? = nil,
        street: String? = nil,
        suburb: String? = nil,
        type: PropertiesType?? = nil
    ) -> FeatureProperties {
        return FeatureProperties(
            division: division ?? self.division,
            fax: fax ?? self.fax,
            fireBanR: fireBanR ?? self.fireBanR,
            latitude: latitude ?? self.latitude,
            localGovt: localGovt ?? self.localGovt,
            longitude: longitude ?? self.longitude,
            no: no ?? self.no,
            phone: phone ?? self.phone,
            postcode: postcode ?? self.postcode,
            psa: psa ?? self.psa,
            region: region ?? self.region,
            station: station ?? self.station,
            street: street ?? self.street,
            suburb: suburb ?? self.suburb,
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

enum FireBanR: String, Codable {
    case northCentral = "North Central"
    case central = "Central"
    case southWest = "South West"
    case wimmera = "Wimmera"
    case northernCountry = "Northern Country"
    case eastGippsland = "East Gippsland"
    case northEast = "North East"
    case mallee = "Mallee"
    case westSouthGippsland = "West &South Gippsland"
    case ballarat = "Ballarat"
}

enum Region: String, Codable {
    case eastern = "Eastern"
    case northernMetro = "Northern Metro"
    case western = "Western"
    case southernMetro = "Southern Metro"
}

enum PropertiesType: String, Codable {
    case street = "STREET"
    case avenue = "AVENUE"
    case road = "ROAD"
    case highway = "HIGHWAY"
    case boulevard = "BOULEVARD"
    case court = "COURT"
    case way = "WAY"
    case drive = "DRIVE"
    case south = "SOUTH"
    case hill = "HILL"
    case lane = "LANE"
    case close = "CLOSE"
    case parade = "PARADE"
    case typeRoad = "Road"
    case place = "PLACE"
    case rd = "RD"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
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
