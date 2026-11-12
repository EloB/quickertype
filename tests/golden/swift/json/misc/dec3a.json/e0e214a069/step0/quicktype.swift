// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let metadata: Metadata
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
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
        metadata: Metadata? = nil,
        results: [Result]? = nil
    ) -> TopLevel {
        return TopLevel(
            metadata: metadata ?? self.metadata,
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

// MARK: - Metadata
struct Metadata: Codable {
    let executionTime: Double
    let responseInfo: ResponseInfo
    let resultset: Resultset

    enum CodingKeys: String, CodingKey {
        case executionTime = "executionTime"
        case responseInfo = "responseInfo"
        case resultset = "resultset"
    }
}

// MARK: Metadata convenience initializers and mutators

extension Metadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Metadata.self, from: data)
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
        executionTime: Double? = nil,
        responseInfo: ResponseInfo? = nil,
        resultset: Resultset? = nil
    ) -> Metadata {
        return Metadata(
            executionTime: executionTime ?? self.executionTime,
            responseInfo: responseInfo ?? self.responseInfo,
            resultset: resultset ?? self.resultset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ResponseInfo
struct ResponseInfo: Codable {
    let developerMessage: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case developerMessage = "developerMessage"
        case status = "status"
    }
}

// MARK: ResponseInfo convenience initializers and mutators

extension ResponseInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ResponseInfo.self, from: data)
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
        developerMessage: String? = nil,
        status: Int? = nil
    ) -> ResponseInfo {
        return ResponseInfo(
            developerMessage: developerMessage ?? self.developerMessage,
            status: status ?? self.status
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Resultset
struct Resultset: Codable {
    let count: Int
    let page: Int
    let pagesize: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case page = "page"
        case pagesize = "pagesize"
    }
}

// MARK: Resultset convenience initializers and mutators

extension Resultset {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Resultset.self, from: data)
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
        page: Int? = nil,
        pagesize: Int? = nil
    ) -> Resultset {
        return Resultset(
            count: count ?? self.count,
            page: page ?? self.page,
            pagesize: pagesize ?? self.pagesize
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
    let aboutOffice: String
    let applicationProcess: String
    let body: String
    let changed: String
    let created: String
    let deadline: JSONNull?
    let hiringOffice: JSONNull?
    let hiringOrg: HiringOrg
    let jobID: JSONNull?
    let language: String
    let location: Location
    let numPositions: String
    let position: String
    let practiceArea: String
    let qualifications: String
    let relocationExpenses: JSONNull?
    let salary: String
    let title: String
    let travel: String
    let url: String
    let uuid: UUID
    let vuuid: UUID

    enum CodingKeys: String, CodingKey {
        case aboutOffice = "about_office"
        case applicationProcess = "application_process"
        case body = "body"
        case changed = "changed"
        case created = "created"
        case deadline = "deadline"
        case hiringOffice = "hiring_office"
        case hiringOrg = "hiring_org"
        case jobID = "job_id"
        case language = "language"
        case location = "location"
        case numPositions = "num_positions"
        case position = "position"
        case practiceArea = "practice_area"
        case qualifications = "qualifications"
        case relocationExpenses = "relocation_expenses"
        case salary = "salary"
        case title = "title"
        case travel = "travel"
        case url = "url"
        case uuid = "uuid"
        case vuuid = "vuuid"
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
        aboutOffice: String? = nil,
        applicationProcess: String? = nil,
        body: String? = nil,
        changed: String? = nil,
        created: String? = nil,
        deadline: JSONNull?? = nil,
        hiringOffice: JSONNull?? = nil,
        hiringOrg: HiringOrg? = nil,
        jobID: JSONNull?? = nil,
        language: String? = nil,
        location: Location? = nil,
        numPositions: String? = nil,
        position: String? = nil,
        practiceArea: String? = nil,
        qualifications: String? = nil,
        relocationExpenses: JSONNull?? = nil,
        salary: String? = nil,
        title: String? = nil,
        travel: String? = nil,
        url: String? = nil,
        uuid: UUID? = nil,
        vuuid: UUID? = nil
    ) -> Result {
        return Result(
            aboutOffice: aboutOffice ?? self.aboutOffice,
            applicationProcess: applicationProcess ?? self.applicationProcess,
            body: body ?? self.body,
            changed: changed ?? self.changed,
            created: created ?? self.created,
            deadline: deadline ?? self.deadline,
            hiringOffice: hiringOffice ?? self.hiringOffice,
            hiringOrg: hiringOrg ?? self.hiringOrg,
            jobID: jobID ?? self.jobID,
            language: language ?? self.language,
            location: location ?? self.location,
            numPositions: numPositions ?? self.numPositions,
            position: position ?? self.position,
            practiceArea: practiceArea ?? self.practiceArea,
            qualifications: qualifications ?? self.qualifications,
            relocationExpenses: relocationExpenses ?? self.relocationExpenses,
            salary: salary ?? self.salary,
            title: title ?? self.title,
            travel: travel ?? self.travel,
            url: url ?? self.url,
            uuid: uuid ?? self.uuid,
            vuuid: vuuid ?? self.vuuid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HiringOrg
struct HiringOrg: Codable {
    let name: String
    let uuid: UUID

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case uuid = "uuid"
    }
}

// MARK: HiringOrg convenience initializers and mutators

extension HiringOrg {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HiringOrg.self, from: data)
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
        uuid: UUID? = nil
    ) -> HiringOrg {
        return HiringOrg(
            name: name ?? self.name,
            uuid: uuid ?? self.uuid
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
    let administrativeArea: String
    let country: String
    let faxNumber: String
    let locality: String
    let mobileNumber: String
    let phoneNumber: String
    let phoneNumberExtension: String
    let postalCode: String
    let subPremise: JSONNull?
    let thoroughfare: String

    enum CodingKeys: String, CodingKey {
        case administrativeArea = "administrative_area"
        case country = "country"
        case faxNumber = "fax_number"
        case locality = "locality"
        case mobileNumber = "mobile_number"
        case phoneNumber = "phone_number"
        case phoneNumberExtension = "phone_number_extension"
        case postalCode = "postal_code"
        case subPremise = "sub_premise"
        case thoroughfare = "thoroughfare"
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
        administrativeArea: String? = nil,
        country: String? = nil,
        faxNumber: String? = nil,
        locality: String? = nil,
        mobileNumber: String? = nil,
        phoneNumber: String? = nil,
        phoneNumberExtension: String? = nil,
        postalCode: String? = nil,
        subPremise: JSONNull?? = nil,
        thoroughfare: String? = nil
    ) -> Location {
        return Location(
            administrativeArea: administrativeArea ?? self.administrativeArea,
            country: country ?? self.country,
            faxNumber: faxNumber ?? self.faxNumber,
            locality: locality ?? self.locality,
            mobileNumber: mobileNumber ?? self.mobileNumber,
            phoneNumber: phoneNumber ?? self.phoneNumber,
            phoneNumberExtension: phoneNumberExtension ?? self.phoneNumberExtension,
            postalCode: postalCode ?? self.postalCode,
            subPremise: subPremise ?? self.subPremise,
            thoroughfare: thoroughfare ?? self.thoroughfare
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
