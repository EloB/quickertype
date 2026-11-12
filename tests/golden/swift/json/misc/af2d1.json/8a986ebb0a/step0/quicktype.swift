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
    let coordinates: [[[[Double]]]]
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
        coordinates: [[[[Double]]]]? = nil,
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
    case multiPolygon = "MultiPolygon"
}

enum GeometryName: String, Codable {
    case geom = "geom"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let addImprov: AddImprov?
    let area: Double
    let assetNumb: String
    let comments: String?
    let condition: Int
    let constructi: String?
    let createdate: JSONNull?
    let createuser: JSONNull?
    let disposalD: JSONNull?
    let documents: String
    let drawingNu: String?
    let fileNumbe: String?
    let folderNum: String?
    let fundingBa: FundingBa?
    let historicC: Int
    let inspection: String
    let inspectors: JSONNull?
    let lastUpdat: JSONNull?
    let levelAccu: LevelAccu?
    let material: Material
    let miPrinx: Int
    let miSymbolo: MiSymbolo
    let numberLAN: Int
    let owner: String?
    let positional: LevelAccu?
    let projectNu: String?
    let recID: Int
    let recordCre: String?
    let shapeArea: Double
    let shapeLeng: Double
    let status: Status
    let surveyNum: JSONNull?
    let toeRl: Double
    let topRl: Double
    let type: PropertiesType?
    let updateDAT: String
    let updatedate: JSONNull?
    let updateuser: JSONNull?

    enum CodingKeys: String, CodingKey {
        case addImprov = "add_improv"
        case area = "area_"
        case assetNumb = "asset_numb"
        case comments = "comments"
        case condition = "condition"
        case constructi = "constructi"
        case createdate = "createdate"
        case createuser = "createuser"
        case disposalD = "disposal_d"
        case documents = "documents"
        case drawingNu = "drawing_nu"
        case fileNumbe = "file_numbe"
        case folderNum = "folder_num"
        case fundingBa = "funding_ba"
        case historicC = "historic_c"
        case inspection = "inspection"
        case inspectors = "inspectors"
        case lastUpdat = "last_updat"
        case levelAccu = "level_accu"
        case material = "material"
        case miPrinx = "mi_prinx"
        case miSymbolo = "mi_symbolo"
        case numberLAN = "number_lan"
        case owner = "owner"
        case positional = "positional"
        case projectNu = "project_nu"
        case recID = "rec_id"
        case recordCre = "record_cre"
        case shapeArea = "shape_area"
        case shapeLeng = "shape_leng"
        case status = "status"
        case surveyNum = "survey_num"
        case toeRl = "toe_rl"
        case topRl = "top_rl"
        case type = "type"
        case updateDAT = "update_dat"
        case updatedate = "updatedate"
        case updateuser = "updateuser"
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
        addImprov: AddImprov?? = nil,
        area: Double? = nil,
        assetNumb: String? = nil,
        comments: String?? = nil,
        condition: Int? = nil,
        constructi: String?? = nil,
        createdate: JSONNull?? = nil,
        createuser: JSONNull?? = nil,
        disposalD: JSONNull?? = nil,
        documents: String? = nil,
        drawingNu: String?? = nil,
        fileNumbe: String?? = nil,
        folderNum: String?? = nil,
        fundingBa: FundingBa?? = nil,
        historicC: Int? = nil,
        inspection: String? = nil,
        inspectors: JSONNull?? = nil,
        lastUpdat: JSONNull?? = nil,
        levelAccu: LevelAccu?? = nil,
        material: Material? = nil,
        miPrinx: Int? = nil,
        miSymbolo: MiSymbolo? = nil,
        numberLAN: Int? = nil,
        owner: String?? = nil,
        positional: LevelAccu?? = nil,
        projectNu: String?? = nil,
        recID: Int? = nil,
        recordCre: String?? = nil,
        shapeArea: Double? = nil,
        shapeLeng: Double? = nil,
        status: Status? = nil,
        surveyNum: JSONNull?? = nil,
        toeRl: Double? = nil,
        topRl: Double? = nil,
        type: PropertiesType?? = nil,
        updateDAT: String? = nil,
        updatedate: JSONNull?? = nil,
        updateuser: JSONNull?? = nil
    ) -> FeatureProperties {
        return FeatureProperties(
            addImprov: addImprov ?? self.addImprov,
            area: area ?? self.area,
            assetNumb: assetNumb ?? self.assetNumb,
            comments: comments ?? self.comments,
            condition: condition ?? self.condition,
            constructi: constructi ?? self.constructi,
            createdate: createdate ?? self.createdate,
            createuser: createuser ?? self.createuser,
            disposalD: disposalD ?? self.disposalD,
            documents: documents ?? self.documents,
            drawingNu: drawingNu ?? self.drawingNu,
            fileNumbe: fileNumbe ?? self.fileNumbe,
            folderNum: folderNum ?? self.folderNum,
            fundingBa: fundingBa ?? self.fundingBa,
            historicC: historicC ?? self.historicC,
            inspection: inspection ?? self.inspection,
            inspectors: inspectors ?? self.inspectors,
            lastUpdat: lastUpdat ?? self.lastUpdat,
            levelAccu: levelAccu ?? self.levelAccu,
            material: material ?? self.material,
            miPrinx: miPrinx ?? self.miPrinx,
            miSymbolo: miSymbolo ?? self.miSymbolo,
            numberLAN: numberLAN ?? self.numberLAN,
            owner: owner ?? self.owner,
            positional: positional ?? self.positional,
            projectNu: projectNu ?? self.projectNu,
            recID: recID ?? self.recID,
            recordCre: recordCre ?? self.recordCre,
            shapeArea: shapeArea ?? self.shapeArea,
            shapeLeng: shapeLeng ?? self.shapeLeng,
            status: status ?? self.status,
            surveyNum: surveyNum ?? self.surveyNum,
            toeRl: toeRl ?? self.toeRl,
            topRl: topRl ?? self.topRl,
            type: type ?? self.type,
            updateDAT: updateDAT ?? self.updateDAT,
            updatedate: updatedate ?? self.updatedate,
            updateuser: updateuser ?? self.updateuser
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum AddImprov: String, Codable {
    case f = "f"
    case addImprovF = "F"
    case t = "t"
}

enum FundingBa: String, Codable {
    case nonGCCC = "Non GCCC"
    case capex = "Capex"
    case initial = "Initial"
    case contribute = "Contribute"
}

enum LevelAccu: String, Codable {
    case gpsCorrected10M = "GPS Corrected 1.0M"
    case approx = "APPROX"
    case gpsCOrrected10M = "GPS COrrected 1.0M"
}

enum Material: String, Codable {
    case gravel = "Gravel"
    case concrete = "Concrete"
    case bitumen = "Bitumen"
    case interlockConcBlock = "Interlock Conc Block"
    case other = "Other"
    case earth = "Earth"
}

enum MiSymbolo: String, Codable {
    case pen2265535Brush1016777215 = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"
}

enum Status: String, Codable {
    case current = "CURRENT"
}

enum PropertiesType: String, Codable {
    case boatRamp = "Boat Ramp"
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
