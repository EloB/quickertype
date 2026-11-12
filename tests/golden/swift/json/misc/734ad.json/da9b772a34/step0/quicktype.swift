// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let count: Int
    let facets: Facets
    let limit: Int
    let next: String
    let offset: Int
    let previous: Bool
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case facets = "facets"
        case limit = "limit"
        case next = "next"
        case offset = "offset"
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
        facets: Facets? = nil,
        limit: Int? = nil,
        next: String? = nil,
        offset: Int? = nil,
        previous: Bool? = nil,
        results: [Result]? = nil
    ) -> TopLevel {
        return TopLevel(
            count: count ?? self.count,
            facets: facets ?? self.facets,
            limit: limit ?? self.limit,
            next: next ?? self.next,
            offset: offset ?? self.offset,
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

// MARK: - Facets
struct Facets: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Facets convenience initializers and mutators

extension Facets {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Facets.self, from: data)
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
    ) -> Facets {
        return Facets(
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
    let acronym: String?
    let activityConsultCommittees: String
    let activityEuLegislative: String
    let activityExpertGroups: String
    let activityHighLevelGroups: String
    let activityIndustryForums: String
    let activityInterGroups: String
    let activityOther: String?
    let activityRelevantComm: String
    let beOfficeCountry: String?
    let beOfficeLat: Double?
    let beOfficeLon: Double?
    let beOfficePhone: String?
    let beOfficePostCode: String?
    let beOfficePostbox: String?
    let beOfficeStreet: String?
    let beOfficeTown: String?
    let codeOfConduct: String
    let contactCountry: Int
    let createdAt: Date
    let entity: String
    let goals: String
    let head: String
    let headOfficeCountry: String
    let headOfficeLat: Double?
    let headOfficeLon: Double?
    let headOfficePhone: String
    let headOfficePostCode: String?
    let headOfficePostbox: String?
    let headOfficeStreet: String
    let headOfficeTown: String
    let id: String
    let identificationCode: String
    let infoMembers: String
    let lastUpdateDate: Date
    let legal: String
    let legalStatus: String
    let mainCategory: Int
    let mainCategoryTitle: String
    let members: Int
    let members100: Int?
    let members25: Int?
    let members50: Int?
    let members75: Int?
    let membersFte: Double
    let name: String
    let nativeName: JSONNull?
    let networking: String?
    let numberOfNaturalPersons: Int?
    let otherCodeOfConduct: String?
    let registrationDate: Date
    let status: Status
    let structureMembers: String
    let subCategory: Int
    let subCategoryTitle: String
    let updatedAt: Date
    let uri: String
    let webSiteURL: String?

    enum CodingKeys: String, CodingKey {
        case acronym = "acronym"
        case activityConsultCommittees = "activity_consult_committees"
        case activityEuLegislative = "activity_eu_legislative"
        case activityExpertGroups = "activity_expert_groups"
        case activityHighLevelGroups = "activity_high_level_groups"
        case activityIndustryForums = "activity_industry_forums"
        case activityInterGroups = "activity_inter_groups"
        case activityOther = "activity_other"
        case activityRelevantComm = "activity_relevant_comm"
        case beOfficeCountry = "be_office_country"
        case beOfficeLat = "be_office_lat"
        case beOfficeLon = "be_office_lon"
        case beOfficePhone = "be_office_phone"
        case beOfficePostCode = "be_office_post_code"
        case beOfficePostbox = "be_office_postbox"
        case beOfficeStreet = "be_office_street"
        case beOfficeTown = "be_office_town"
        case codeOfConduct = "code_of_conduct"
        case contactCountry = "contact_country"
        case createdAt = "created_at"
        case entity = "entity"
        case goals = "goals"
        case head = "head"
        case headOfficeCountry = "head_office_country"
        case headOfficeLat = "head_office_lat"
        case headOfficeLon = "head_office_lon"
        case headOfficePhone = "head_office_phone"
        case headOfficePostCode = "head_office_post_code"
        case headOfficePostbox = "head_office_postbox"
        case headOfficeStreet = "head_office_street"
        case headOfficeTown = "head_office_town"
        case id = "id"
        case identificationCode = "identification_code"
        case infoMembers = "info_members"
        case lastUpdateDate = "last_update_date"
        case legal = "legal"
        case legalStatus = "legal_status"
        case mainCategory = "main_category"
        case mainCategoryTitle = "main_category_title"
        case members = "members"
        case members100 = "members_100"
        case members25 = "members_25"
        case members50 = "members_50"
        case members75 = "members_75"
        case membersFte = "members_fte"
        case name = "name"
        case nativeName = "native_name"
        case networking = "networking"
        case numberOfNaturalPersons = "number_of_natural_persons"
        case otherCodeOfConduct = "other_code_of_conduct"
        case registrationDate = "registration_date"
        case status = "status"
        case structureMembers = "structure_members"
        case subCategory = "sub_category"
        case subCategoryTitle = "sub_category_title"
        case updatedAt = "updated_at"
        case uri = "uri"
        case webSiteURL = "web_site_url"
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
        acronym: String?? = nil,
        activityConsultCommittees: String? = nil,
        activityEuLegislative: String? = nil,
        activityExpertGroups: String? = nil,
        activityHighLevelGroups: String? = nil,
        activityIndustryForums: String? = nil,
        activityInterGroups: String? = nil,
        activityOther: String?? = nil,
        activityRelevantComm: String? = nil,
        beOfficeCountry: String?? = nil,
        beOfficeLat: Double?? = nil,
        beOfficeLon: Double?? = nil,
        beOfficePhone: String?? = nil,
        beOfficePostCode: String?? = nil,
        beOfficePostbox: String?? = nil,
        beOfficeStreet: String?? = nil,
        beOfficeTown: String?? = nil,
        codeOfConduct: String? = nil,
        contactCountry: Int? = nil,
        createdAt: Date? = nil,
        entity: String? = nil,
        goals: String? = nil,
        head: String? = nil,
        headOfficeCountry: String? = nil,
        headOfficeLat: Double?? = nil,
        headOfficeLon: Double?? = nil,
        headOfficePhone: String? = nil,
        headOfficePostCode: String?? = nil,
        headOfficePostbox: String?? = nil,
        headOfficeStreet: String? = nil,
        headOfficeTown: String? = nil,
        id: String? = nil,
        identificationCode: String? = nil,
        infoMembers: String? = nil,
        lastUpdateDate: Date? = nil,
        legal: String? = nil,
        legalStatus: String? = nil,
        mainCategory: Int? = nil,
        mainCategoryTitle: String? = nil,
        members: Int? = nil,
        members100: Int?? = nil,
        members25: Int?? = nil,
        members50: Int?? = nil,
        members75: Int?? = nil,
        membersFte: Double? = nil,
        name: String? = nil,
        nativeName: JSONNull?? = nil,
        networking: String?? = nil,
        numberOfNaturalPersons: Int?? = nil,
        otherCodeOfConduct: String?? = nil,
        registrationDate: Date? = nil,
        status: Status? = nil,
        structureMembers: String? = nil,
        subCategory: Int? = nil,
        subCategoryTitle: String? = nil,
        updatedAt: Date? = nil,
        uri: String? = nil,
        webSiteURL: String?? = nil
    ) -> Result {
        return Result(
            acronym: acronym ?? self.acronym,
            activityConsultCommittees: activityConsultCommittees ?? self.activityConsultCommittees,
            activityEuLegislative: activityEuLegislative ?? self.activityEuLegislative,
            activityExpertGroups: activityExpertGroups ?? self.activityExpertGroups,
            activityHighLevelGroups: activityHighLevelGroups ?? self.activityHighLevelGroups,
            activityIndustryForums: activityIndustryForums ?? self.activityIndustryForums,
            activityInterGroups: activityInterGroups ?? self.activityInterGroups,
            activityOther: activityOther ?? self.activityOther,
            activityRelevantComm: activityRelevantComm ?? self.activityRelevantComm,
            beOfficeCountry: beOfficeCountry ?? self.beOfficeCountry,
            beOfficeLat: beOfficeLat ?? self.beOfficeLat,
            beOfficeLon: beOfficeLon ?? self.beOfficeLon,
            beOfficePhone: beOfficePhone ?? self.beOfficePhone,
            beOfficePostCode: beOfficePostCode ?? self.beOfficePostCode,
            beOfficePostbox: beOfficePostbox ?? self.beOfficePostbox,
            beOfficeStreet: beOfficeStreet ?? self.beOfficeStreet,
            beOfficeTown: beOfficeTown ?? self.beOfficeTown,
            codeOfConduct: codeOfConduct ?? self.codeOfConduct,
            contactCountry: contactCountry ?? self.contactCountry,
            createdAt: createdAt ?? self.createdAt,
            entity: entity ?? self.entity,
            goals: goals ?? self.goals,
            head: head ?? self.head,
            headOfficeCountry: headOfficeCountry ?? self.headOfficeCountry,
            headOfficeLat: headOfficeLat ?? self.headOfficeLat,
            headOfficeLon: headOfficeLon ?? self.headOfficeLon,
            headOfficePhone: headOfficePhone ?? self.headOfficePhone,
            headOfficePostCode: headOfficePostCode ?? self.headOfficePostCode,
            headOfficePostbox: headOfficePostbox ?? self.headOfficePostbox,
            headOfficeStreet: headOfficeStreet ?? self.headOfficeStreet,
            headOfficeTown: headOfficeTown ?? self.headOfficeTown,
            id: id ?? self.id,
            identificationCode: identificationCode ?? self.identificationCode,
            infoMembers: infoMembers ?? self.infoMembers,
            lastUpdateDate: lastUpdateDate ?? self.lastUpdateDate,
            legal: legal ?? self.legal,
            legalStatus: legalStatus ?? self.legalStatus,
            mainCategory: mainCategory ?? self.mainCategory,
            mainCategoryTitle: mainCategoryTitle ?? self.mainCategoryTitle,
            members: members ?? self.members,
            members100: members100 ?? self.members100,
            members25: members25 ?? self.members25,
            members50: members50 ?? self.members50,
            members75: members75 ?? self.members75,
            membersFte: membersFte ?? self.membersFte,
            name: name ?? self.name,
            nativeName: nativeName ?? self.nativeName,
            networking: networking ?? self.networking,
            numberOfNaturalPersons: numberOfNaturalPersons ?? self.numberOfNaturalPersons,
            otherCodeOfConduct: otherCodeOfConduct ?? self.otherCodeOfConduct,
            registrationDate: registrationDate ?? self.registrationDate,
            status: status ?? self.status,
            structureMembers: structureMembers ?? self.structureMembers,
            subCategory: subCategory ?? self.subCategory,
            subCategoryTitle: subCategoryTitle ?? self.subCategoryTitle,
            updatedAt: updatedAt ?? self.updatedAt,
            uri: uri ?? self.uri,
            webSiteURL: webSiteURL ?? self.webSiteURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
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
