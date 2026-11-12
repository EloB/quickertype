// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let basePath: String
    let definitions: Definitions
    let host: String
    let info: Info
    let paths: Paths
    let produces: [String]
    let schemes: [String]
    let swagger: String

    enum CodingKeys: String, CodingKey {
        case basePath = "basePath"
        case definitions = "definitions"
        case host = "host"
        case info = "info"
        case paths = "paths"
        case produces = "produces"
        case schemes = "schemes"
        case swagger = "swagger"
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
        basePath: String? = nil,
        definitions: Definitions? = nil,
        host: String? = nil,
        info: Info? = nil,
        paths: Paths? = nil,
        produces: [String]? = nil,
        schemes: [String]? = nil,
        swagger: String? = nil
    ) -> TopLevel {
        return TopLevel(
            basePath: basePath ?? self.basePath,
            definitions: definitions ?? self.definitions,
            host: host ?? self.host,
            info: info ?? self.info,
            paths: paths ?? self.paths,
            produces: produces ?? self.produces,
            schemes: schemes ?? self.schemes,
            swagger: swagger ?? self.swagger
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Definitions
struct Definitions: Codable {
    let report: Report

    enum CodingKeys: String, CodingKey {
        case report = "Report"
    }
}

// MARK: Definitions convenience initializers and mutators

extension Definitions {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Definitions.self, from: data)
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
        report: Report? = nil
    ) -> Definitions {
        return Definitions(
            report: report ?? self.report
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Report
struct Report: Codable {
    let properties: Properties

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Report convenience initializers and mutators

extension Report {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Report.self, from: data)
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
        properties: Properties? = nil
    ) -> Report {
        return Report(
            properties: properties ?? self.properties
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Properties
struct Properties: Codable {
    let clickURL: ClickURL
    let country: ClickURL
    let description: ClickURL
    let expirationDate: ClickURL
    let id: ClickURL
    let industry: ClickURL
    let reportType: ClickURL
    let sourceIndustry: ClickURL
    let title: ClickURL
    let url: ClickURL

    enum CodingKeys: String, CodingKey {
        case clickURL = "click_url"
        case country = "country"
        case description = "description"
        case expirationDate = "expiration_date"
        case id = "id"
        case industry = "industry"
        case reportType = "report_type"
        case sourceIndustry = "source_industry"
        case title = "title"
        case url = "url"
    }
}

// MARK: Properties convenience initializers and mutators

extension Properties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Properties.self, from: data)
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
        clickURL: ClickURL? = nil,
        country: ClickURL? = nil,
        description: ClickURL? = nil,
        expirationDate: ClickURL? = nil,
        id: ClickURL? = nil,
        industry: ClickURL? = nil,
        reportType: ClickURL? = nil,
        sourceIndustry: ClickURL? = nil,
        title: ClickURL? = nil,
        url: ClickURL? = nil
    ) -> Properties {
        return Properties(
            clickURL: clickURL ?? self.clickURL,
            country: country ?? self.country,
            description: description ?? self.description,
            expirationDate: expirationDate ?? self.expirationDate,
            id: id ?? self.id,
            industry: industry ?? self.industry,
            reportType: reportType ?? self.reportType,
            sourceIndustry: sourceIndustry ?? self.sourceIndustry,
            title: title ?? self.title,
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

// MARK: - ClickURL
struct ClickURL: Codable {
    let description: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case type = "type"
    }
}

// MARK: ClickURL convenience initializers and mutators

extension ClickURL {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ClickURL.self, from: data)
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
        description: String? = nil,
        type: TypeEnum? = nil
    ) -> ClickURL {
        return ClickURL(
            description: description ?? self.description,
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

enum TypeEnum: String, Codable {
    case string = "string"
}

// MARK: - Info
struct Info: Codable {
    let description: String
    let title: String
    let version: String

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case title = "title"
        case version = "version"
    }
}

// MARK: Info convenience initializers and mutators

extension Info {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Info.self, from: data)
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
        description: String? = nil,
        title: String? = nil,
        version: String? = nil
    ) -> Info {
        return Info(
            description: description ?? self.description,
            title: title ?? self.title,
            version: version ?? self.version
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Paths
struct Paths: Codable {
    let marketResearchLibrarySearch: MarketResearchLibrarySearch

    enum CodingKeys: String, CodingKey {
        case marketResearchLibrarySearch = "/market_research_library/search"
    }
}

// MARK: Paths convenience initializers and mutators

extension Paths {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Paths.self, from: data)
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
        marketResearchLibrarySearch: MarketResearchLibrarySearch? = nil
    ) -> Paths {
        return Paths(
            marketResearchLibrarySearch: marketResearchLibrarySearch ?? self.marketResearchLibrarySearch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MarketResearchLibrarySearch
struct MarketResearchLibrarySearch: Codable {
    let marketResearchLibrarySearchGet: Get

    enum CodingKeys: String, CodingKey {
        case marketResearchLibrarySearchGet = "get"
    }
}

// MARK: MarketResearchLibrarySearch convenience initializers and mutators

extension MarketResearchLibrarySearch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarketResearchLibrarySearch.self, from: data)
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
        marketResearchLibrarySearchGet: Get? = nil
    ) -> MarketResearchLibrarySearch {
        return MarketResearchLibrarySearch(
            marketResearchLibrarySearchGet: marketResearchLibrarySearchGet ?? self.marketResearchLibrarySearchGet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Get
struct Get: Codable {
    let description: String
    let parameters: [Parameter]
    let responses: Responses
    let summary: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case parameters = "parameters"
        case responses = "responses"
        case summary = "summary"
        case tags = "tags"
    }
}

// MARK: Get convenience initializers and mutators

extension Get {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Get.self, from: data)
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
        description: String? = nil,
        parameters: [Parameter]? = nil,
        responses: Responses? = nil,
        summary: String? = nil,
        tags: [String]? = nil
    ) -> Get {
        return Get(
            description: description ?? self.description,
            parameters: parameters ?? self.parameters,
            responses: responses ?? self.responses,
            summary: summary ?? self.summary,
            tags: tags ?? self.tags
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let description: String
    let format: TypeEnum
    let name: String
    let parameterIn: String
    let parameterRequired: Bool
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case format = "format"
        case name = "name"
        case parameterIn = "in"
        case parameterRequired = "required"
        case type = "type"
    }
}

// MARK: Parameter convenience initializers and mutators

extension Parameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Parameter.self, from: data)
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
        description: String? = nil,
        format: TypeEnum? = nil,
        name: String? = nil,
        parameterIn: String? = nil,
        parameterRequired: Bool? = nil,
        type: TypeEnum? = nil
    ) -> Parameter {
        return Parameter(
            description: description ?? self.description,
            format: format ?? self.format,
            name: name ?? self.name,
            parameterIn: parameterIn ?? self.parameterIn,
            parameterRequired: parameterRequired ?? self.parameterRequired,
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

// MARK: - Responses
struct Responses: Codable {
    let the200: The200

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: Responses convenience initializers and mutators

extension Responses {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Responses.self, from: data)
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
        the200: The200? = nil
    ) -> Responses {
        return Responses(
            the200: the200 ?? self.the200
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - The200
struct The200: Codable {
    let description: String
    let schema: Schema

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case schema = "schema"
    }
}

// MARK: The200 convenience initializers and mutators

extension The200 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(The200.self, from: data)
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
        description: String? = nil,
        schema: Schema? = nil
    ) -> The200 {
        return The200(
            description: description ?? self.description,
            schema: schema ?? self.schema
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Schema
struct Schema: Codable {
    let items: Items
    let type: String

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case type = "type"
    }
}

// MARK: Schema convenience initializers and mutators

extension Schema {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Schema.self, from: data)
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
        items: Items? = nil,
        type: String? = nil
    ) -> Schema {
        return Schema(
            items: items ?? self.items,
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

// MARK: - Items
struct Items: Codable {
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
    }
}

// MARK: Items convenience initializers and mutators

extension Items {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Items.self, from: data)
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
        ref: String? = nil
    ) -> Items {
        return Items(
            ref: ref ?? self.ref
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
