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
    let taxonomy: Taxonomy

    enum CodingKeys: String, CodingKey {
        case taxonomy = "Taxonomy"
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
        taxonomy: Taxonomy? = nil
    ) -> Definitions {
        return Definitions(
            taxonomy: taxonomy ?? self.taxonomy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Taxonomy
struct Taxonomy: Codable {
    let properties: Properties

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Taxonomy convenience initializers and mutators

extension Taxonomy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Taxonomy.self, from: data)
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
    ) -> Taxonomy {
        return Taxonomy(
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
    let annotations: Annotations
    let datatypeProperties: Annotations
    let id: Annotations
    let label: Annotations
    let subClassOf: Annotations
    let type: Annotations

    enum CodingKeys: String, CodingKey {
        case annotations = "annotations"
        case datatypeProperties = "datatype_properties"
        case id = "id"
        case label = "label"
        case subClassOf = "sub_class_of"
        case type = "type"
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
        annotations: Annotations? = nil,
        datatypeProperties: Annotations? = nil,
        id: Annotations? = nil,
        label: Annotations? = nil,
        subClassOf: Annotations? = nil,
        type: Annotations? = nil
    ) -> Properties {
        return Properties(
            annotations: annotations ?? self.annotations,
            datatypeProperties: datatypeProperties ?? self.datatypeProperties,
            id: id ?? self.id,
            label: label ?? self.label,
            subClassOf: subClassOf ?? self.subClassOf,
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

// MARK: - Annotations
struct Annotations: Codable {
    let description: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case type = "type"
    }
}

// MARK: Annotations convenience initializers and mutators

extension Annotations {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Annotations.self, from: data)
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
        type: String? = nil
    ) -> Annotations {
        return Annotations(
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
    let itaTaxonomiesSearch: ItaTaxonomiesSearch

    enum CodingKeys: String, CodingKey {
        case itaTaxonomiesSearch = "/ita_taxonomies/search"
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
        itaTaxonomiesSearch: ItaTaxonomiesSearch? = nil
    ) -> Paths {
        return Paths(
            itaTaxonomiesSearch: itaTaxonomiesSearch ?? self.itaTaxonomiesSearch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ItaTaxonomiesSearch
struct ItaTaxonomiesSearch: Codable {
    let itaTaxonomiesSearchGet: Get

    enum CodingKeys: String, CodingKey {
        case itaTaxonomiesSearchGet = "get"
    }
}

// MARK: ItaTaxonomiesSearch convenience initializers and mutators

extension ItaTaxonomiesSearch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ItaTaxonomiesSearch.self, from: data)
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
        itaTaxonomiesSearchGet: Get? = nil
    ) -> ItaTaxonomiesSearch {
        return ItaTaxonomiesSearch(
            itaTaxonomiesSearchGet: itaTaxonomiesSearchGet ?? self.itaTaxonomiesSearchGet
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
    let format: String
    let name: String
    let parameterIn: String
    let parameterRequired: Bool
    let type: String

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
        format: String? = nil,
        name: String? = nil,
        parameterIn: String? = nil,
        parameterRequired: Bool? = nil,
        type: String? = nil
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
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
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
        ref: String? = nil
    ) -> Schema {
        return Schema(
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
