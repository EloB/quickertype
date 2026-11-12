// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let meta: Meta
    let objects: [Object]

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case objects = "objects"
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
        meta: Meta? = nil,
        objects: [Object]? = nil
    ) -> TopLevel {
        return TopLevel(
            meta: meta ?? self.meta,
            objects: objects ?? self.objects
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
    let limit: Int
    let offset: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case limit = "limit"
        case offset = "offset"
        case totalCount = "total_count"
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
        limit: Int? = nil,
        offset: Int? = nil,
        totalCount: Int? = nil
    ) -> Meta {
        return Meta(
            limit: limit ?? self.limit,
            offset: offset ?? self.offset,
            totalCount: totalCount ?? self.totalCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Object
struct Object: Codable {
    let caucus: JSONNull?
    let congressNumbers: [Int]
    let current: Bool
    let description: String
    let district: Int
    let enddate: String
    let extra: Extra
    let id: Int
    let leadershipTitle: String?
    let party: Party
    let person: Person
    let phone: String
    let roleType: RoleType
    let roleTypeLabel: RoleTypeLabel
    let senatorClass: JSONNull?
    let senatorRank: JSONNull?
    let startdate: String
    let state: String
    let title: Title
    let titleLong: RoleTypeLabel
    let website: String

    enum CodingKeys: String, CodingKey {
        case caucus = "caucus"
        case congressNumbers = "congress_numbers"
        case current = "current"
        case description = "description"
        case district = "district"
        case enddate = "enddate"
        case extra = "extra"
        case id = "id"
        case leadershipTitle = "leadership_title"
        case party = "party"
        case person = "person"
        case phone = "phone"
        case roleType = "role_type"
        case roleTypeLabel = "role_type_label"
        case senatorClass = "senator_class"
        case senatorRank = "senator_rank"
        case startdate = "startdate"
        case state = "state"
        case title = "title"
        case titleLong = "title_long"
        case website = "website"
    }
}

// MARK: Object convenience initializers and mutators

extension Object {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Object.self, from: data)
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
        caucus: JSONNull?? = nil,
        congressNumbers: [Int]? = nil,
        current: Bool? = nil,
        description: String? = nil,
        district: Int? = nil,
        enddate: String? = nil,
        extra: Extra? = nil,
        id: Int? = nil,
        leadershipTitle: String?? = nil,
        party: Party? = nil,
        person: Person? = nil,
        phone: String? = nil,
        roleType: RoleType? = nil,
        roleTypeLabel: RoleTypeLabel? = nil,
        senatorClass: JSONNull?? = nil,
        senatorRank: JSONNull?? = nil,
        startdate: String? = nil,
        state: String? = nil,
        title: Title? = nil,
        titleLong: RoleTypeLabel? = nil,
        website: String? = nil
    ) -> Object {
        return Object(
            caucus: caucus ?? self.caucus,
            congressNumbers: congressNumbers ?? self.congressNumbers,
            current: current ?? self.current,
            description: description ?? self.description,
            district: district ?? self.district,
            enddate: enddate ?? self.enddate,
            extra: extra ?? self.extra,
            id: id ?? self.id,
            leadershipTitle: leadershipTitle ?? self.leadershipTitle,
            party: party ?? self.party,
            person: person ?? self.person,
            phone: phone ?? self.phone,
            roleType: roleType ?? self.roleType,
            roleTypeLabel: roleTypeLabel ?? self.roleTypeLabel,
            senatorClass: senatorClass ?? self.senatorClass,
            senatorRank: senatorRank ?? self.senatorRank,
            startdate: startdate ?? self.startdate,
            state: state ?? self.state,
            title: title ?? self.title,
            titleLong: titleLong ?? self.titleLong,
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

// MARK: - Extra
struct Extra: Codable {
    let address: String
    let contactForm: String?
    let fax: String?
    let office: String
    let rssURL: String?

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case contactForm = "contact_form"
        case fax = "fax"
        case office = "office"
        case rssURL = "rss_url"
    }
}

// MARK: Extra convenience initializers and mutators

extension Extra {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extra.self, from: data)
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
        address: String? = nil,
        contactForm: String?? = nil,
        fax: String?? = nil,
        office: String? = nil,
        rssURL: String?? = nil
    ) -> Extra {
        return Extra(
            address: address ?? self.address,
            contactForm: contactForm ?? self.contactForm,
            fax: fax ?? self.fax,
            office: office ?? self.office,
            rssURL: rssURL ?? self.rssURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Party: String, Codable {
    case republican = "Republican"
    case democrat = "Democrat"
}

// MARK: - Person
struct Person: Codable {
    let bioguideid: String
    let birthday: String
    let cspanid: Int
    let firstname: String
    let gender: Gender
    let genderLabel: GenderLabel
    let id: Int
    let lastname: String
    let link: String
    let middlename: String
    let name: String
    let namemod: Namemod
    let nickname: String
    let osid: String
    let pvsid: String?
    let sortname: String
    let twitterid: String?
    let youtubeid: String?

    enum CodingKeys: String, CodingKey {
        case bioguideid = "bioguideid"
        case birthday = "birthday"
        case cspanid = "cspanid"
        case firstname = "firstname"
        case gender = "gender"
        case genderLabel = "gender_label"
        case id = "id"
        case lastname = "lastname"
        case link = "link"
        case middlename = "middlename"
        case name = "name"
        case namemod = "namemod"
        case nickname = "nickname"
        case osid = "osid"
        case pvsid = "pvsid"
        case sortname = "sortname"
        case twitterid = "twitterid"
        case youtubeid = "youtubeid"
    }
}

// MARK: Person convenience initializers and mutators

extension Person {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Person.self, from: data)
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
        bioguideid: String? = nil,
        birthday: String? = nil,
        cspanid: Int? = nil,
        firstname: String? = nil,
        gender: Gender? = nil,
        genderLabel: GenderLabel? = nil,
        id: Int? = nil,
        lastname: String? = nil,
        link: String? = nil,
        middlename: String? = nil,
        name: String? = nil,
        namemod: Namemod? = nil,
        nickname: String? = nil,
        osid: String? = nil,
        pvsid: String?? = nil,
        sortname: String? = nil,
        twitterid: String?? = nil,
        youtubeid: String?? = nil
    ) -> Person {
        return Person(
            bioguideid: bioguideid ?? self.bioguideid,
            birthday: birthday ?? self.birthday,
            cspanid: cspanid ?? self.cspanid,
            firstname: firstname ?? self.firstname,
            gender: gender ?? self.gender,
            genderLabel: genderLabel ?? self.genderLabel,
            id: id ?? self.id,
            lastname: lastname ?? self.lastname,
            link: link ?? self.link,
            middlename: middlename ?? self.middlename,
            name: name ?? self.name,
            namemod: namemod ?? self.namemod,
            nickname: nickname ?? self.nickname,
            osid: osid ?? self.osid,
            pvsid: pvsid ?? self.pvsid,
            sortname: sortname ?? self.sortname,
            twitterid: twitterid ?? self.twitterid,
            youtubeid: youtubeid ?? self.youtubeid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Gender: String, Codable {
    case male = "male"
    case female = "female"
}

enum GenderLabel: String, Codable {
    case male = "Male"
    case female = "Female"
}

enum Namemod: String, Codable {
    case empty = ""
    case jr = "Jr."
    case ii = "II"
    case iii = "III"
    case iv = "IV"
}

enum RoleType: String, Codable {
    case representative = "representative"
}

enum RoleTypeLabel: String, Codable {
    case representative = "Representative"
    case delegate = "Delegate"
    case residentCommissioner = "Resident Commissioner"
}

enum Title: String, Codable {
    case rep = "Rep."
    case commish = "Commish."
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
