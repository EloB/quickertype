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
    let costAbsolute: Int?
    let costMax: Int?
    let costMin: Int?
    let createdAt: Date
    let customIncomes: [CustomIncome]
    let directRepCostsMax: JSONNull?
    let directRepCostsMin: JSONNull?
    let endDate: Date
    let eurSourcesGrants: Int
    let eurSourcesGrantsSrc: String?
    let eurSourcesProcurement: Int
    let eurSourcesProcurementSrc: String?
    let id: String
    let newOrganisation: JSONNull?
    let noClients: String?
    let otherFinancialInformation: String?
    let otherSourcesContributions: Int?
    let otherSourcesDonation: Int?
    let otherSourcesTotal: Int?
    let publicFinancingInfranational: Int?
    let publicFinancingNational: Int?
    let publicFinancingTotal: Int?
    let representative: String
    let startDate: Date
    let status: Status
    let totalBudget: Int?
    let turnoverAbsolute: Int?
    let turnoverMax: Int?
    let turnoverMin: Int?
    let type: ResultType
    let updatedAt: Date
    let uri: String

    enum CodingKeys: String, CodingKey {
        case costAbsolute = "cost_absolute"
        case costMax = "cost_max"
        case costMin = "cost_min"
        case createdAt = "created_at"
        case customIncomes = "customIncomes"
        case directRepCostsMax = "direct_rep_costs_max"
        case directRepCostsMin = "direct_rep_costs_min"
        case endDate = "end_date"
        case eurSourcesGrants = "eur_sources_grants"
        case eurSourcesGrantsSrc = "eur_sources_grants_src"
        case eurSourcesProcurement = "eur_sources_procurement"
        case eurSourcesProcurementSrc = "eur_sources_procurement_src"
        case id = "id"
        case newOrganisation = "new_organisation"
        case noClients = "no_clients"
        case otherFinancialInformation = "other_financial_information"
        case otherSourcesContributions = "other_sources_contributions"
        case otherSourcesDonation = "other_sources_donation"
        case otherSourcesTotal = "other_sources_total"
        case publicFinancingInfranational = "public_financing_infranational"
        case publicFinancingNational = "public_financing_national"
        case publicFinancingTotal = "public_financing_total"
        case representative = "representative"
        case startDate = "start_date"
        case status = "status"
        case totalBudget = "total_budget"
        case turnoverAbsolute = "turnover_absolute"
        case turnoverMax = "turnover_max"
        case turnoverMin = "turnover_min"
        case type = "type"
        case updatedAt = "updated_at"
        case uri = "uri"
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
        costAbsolute: Int?? = nil,
        costMax: Int?? = nil,
        costMin: Int?? = nil,
        createdAt: Date? = nil,
        customIncomes: [CustomIncome]? = nil,
        directRepCostsMax: JSONNull?? = nil,
        directRepCostsMin: JSONNull?? = nil,
        endDate: Date? = nil,
        eurSourcesGrants: Int? = nil,
        eurSourcesGrantsSrc: String?? = nil,
        eurSourcesProcurement: Int? = nil,
        eurSourcesProcurementSrc: String?? = nil,
        id: String? = nil,
        newOrganisation: JSONNull?? = nil,
        noClients: String?? = nil,
        otherFinancialInformation: String?? = nil,
        otherSourcesContributions: Int?? = nil,
        otherSourcesDonation: Int?? = nil,
        otherSourcesTotal: Int?? = nil,
        publicFinancingInfranational: Int?? = nil,
        publicFinancingNational: Int?? = nil,
        publicFinancingTotal: Int?? = nil,
        representative: String? = nil,
        startDate: Date? = nil,
        status: Status? = nil,
        totalBudget: Int?? = nil,
        turnoverAbsolute: Int?? = nil,
        turnoverMax: Int?? = nil,
        turnoverMin: Int?? = nil,
        type: ResultType? = nil,
        updatedAt: Date? = nil,
        uri: String? = nil
    ) -> Result {
        return Result(
            costAbsolute: costAbsolute ?? self.costAbsolute,
            costMax: costMax ?? self.costMax,
            costMin: costMin ?? self.costMin,
            createdAt: createdAt ?? self.createdAt,
            customIncomes: customIncomes ?? self.customIncomes,
            directRepCostsMax: directRepCostsMax ?? self.directRepCostsMax,
            directRepCostsMin: directRepCostsMin ?? self.directRepCostsMin,
            endDate: endDate ?? self.endDate,
            eurSourcesGrants: eurSourcesGrants ?? self.eurSourcesGrants,
            eurSourcesGrantsSrc: eurSourcesGrantsSrc ?? self.eurSourcesGrantsSrc,
            eurSourcesProcurement: eurSourcesProcurement ?? self.eurSourcesProcurement,
            eurSourcesProcurementSrc: eurSourcesProcurementSrc ?? self.eurSourcesProcurementSrc,
            id: id ?? self.id,
            newOrganisation: newOrganisation ?? self.newOrganisation,
            noClients: noClients ?? self.noClients,
            otherFinancialInformation: otherFinancialInformation ?? self.otherFinancialInformation,
            otherSourcesContributions: otherSourcesContributions ?? self.otherSourcesContributions,
            otherSourcesDonation: otherSourcesDonation ?? self.otherSourcesDonation,
            otherSourcesTotal: otherSourcesTotal ?? self.otherSourcesTotal,
            publicFinancingInfranational: publicFinancingInfranational ?? self.publicFinancingInfranational,
            publicFinancingNational: publicFinancingNational ?? self.publicFinancingNational,
            publicFinancingTotal: publicFinancingTotal ?? self.publicFinancingTotal,
            representative: representative ?? self.representative,
            startDate: startDate ?? self.startDate,
            status: status ?? self.status,
            totalBudget: totalBudget ?? self.totalBudget,
            turnoverAbsolute: turnoverAbsolute ?? self.turnoverAbsolute,
            turnoverMax: turnoverMax ?? self.turnoverMax,
            turnoverMin: turnoverMin ?? self.turnoverMin,
            type: type ?? self.type,
            updatedAt: updatedAt ?? self.updatedAt,
            uri: uri ?? self.uri
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CustomIncome
struct CustomIncome: Codable {
    let amount: Int
    let createdAt: Date
    let id: String
    let name: String
    let status: Status
    let type: CustomIncomeType
    let updatedAt: Date
    let uri: String

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case createdAt = "created_at"
        case id = "id"
        case name = "name"
        case status = "status"
        case type = "type"
        case updatedAt = "updated_at"
        case uri = "uri"
    }
}

// MARK: CustomIncome convenience initializers and mutators

extension CustomIncome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CustomIncome.self, from: data)
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
        amount: Int? = nil,
        createdAt: Date? = nil,
        id: String? = nil,
        name: String? = nil,
        status: Status? = nil,
        type: CustomIncomeType? = nil,
        updatedAt: Date? = nil,
        uri: String? = nil
    ) -> CustomIncome {
        return CustomIncome(
            amount: amount ?? self.amount,
            createdAt: createdAt ?? self.createdAt,
            id: id ?? self.id,
            name: name ?? self.name,
            status: status ?? self.status,
            type: type ?? self.type,
            updatedAt: updatedAt ?? self.updatedAt,
            uri: uri ?? self.uri
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

enum CustomIncomeType: String, Codable {
    case typePublic = "public"
    case other = "other"
}

enum ResultType: String, Codable {
    case financialDataNGO = "FinancialDataNGO"
    case financialDataLawyer = "FinancialDataLawyer"
    case financialDataTradeAssociation = "FinancialDataTradeAssociation"
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
