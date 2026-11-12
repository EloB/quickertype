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
    let list: List

    enum CodingKeys: String, CodingKey {
        case list = "List"
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
        list: List? = nil
    ) -> Definitions {
        return Definitions(
            list: list ?? self.list
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - List
struct List: Codable {
    let properties: [String: Property]

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: List convenience initializers and mutators

extension List {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(List.self, from: data)
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
        properties: [String: Property]? = nil
    ) -> List {
        return List(
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

// MARK: - Property
struct Property: Codable {
    let description: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case type = "type"
    }
}

// MARK: Property convenience initializers and mutators

extension Property {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Property.self, from: data)
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
    ) -> Property {
        return Property(
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
    let consolidatedScreeningListSearch: ConsolidatedScreeningListSearch

    enum CodingKeys: String, CodingKey {
        case consolidatedScreeningListSearch = "/consolidated_screening_list/search"
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
        consolidatedScreeningListSearch: ConsolidatedScreeningListSearch? = nil
    ) -> Paths {
        return Paths(
            consolidatedScreeningListSearch: consolidatedScreeningListSearch ?? self.consolidatedScreeningListSearch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ConsolidatedScreeningListSearch
struct ConsolidatedScreeningListSearch: Codable {
    let consolidatedScreeningListSearchGet: Get

    enum CodingKeys: String, CodingKey {
        case consolidatedScreeningListSearchGet = "get"
    }
}

// MARK: ConsolidatedScreeningListSearch convenience initializers and mutators

extension ConsolidatedScreeningListSearch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConsolidatedScreeningListSearch.self, from: data)
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
        consolidatedScreeningListSearchGet: Get? = nil
    ) -> ConsolidatedScreeningListSearch {
        return ConsolidatedScreeningListSearch(
            consolidatedScreeningListSearchGet: consolidatedScreeningListSearchGet ?? self.consolidatedScreeningListSearchGet
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
    let parameterIn: In
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
        parameterIn: In? = nil,
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

enum In: String, Codable {
    case query = "query"
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
