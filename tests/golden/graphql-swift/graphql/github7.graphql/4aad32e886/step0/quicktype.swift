// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let data: DataClass?
    let errors: [Error]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case errors = "errors"
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
        data: DataClass?? = nil,
        errors: [Error]?? = nil
    ) -> TopLevel {
        return TopLevel(
            data: data ?? self.data,
            errors: errors ?? self.errors
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let viewer: User

    enum CodingKeys: String, CodingKey {
        case viewer = "viewer"
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
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
        viewer: User? = nil
    ) -> DataClass {
        return DataClass(
            viewer: viewer ?? self.viewer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - User
struct User: Codable {
    let login: String
    let starredRepositories: Connection
    let repositories: RepositoryConnection

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case starredRepositories = "starredRepositories"
        case repositories = "repositories"
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
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
        login: String? = nil,
        starredRepositories: Connection? = nil,
        repositories: RepositoryConnection? = nil
    ) -> User {
        return User(
            login: login ?? self.login,
            starredRepositories: starredRepositories ?? self.starredRepositories,
            repositories: repositories ?? self.repositories
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RepositoryConnection
struct RepositoryConnection: Codable {
    let edges: [RepositoryEdge?]?

    enum CodingKeys: String, CodingKey {
        case edges = "edges"
    }
}

// MARK: RepositoryConnection convenience initializers and mutators

extension RepositoryConnection {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RepositoryConnection.self, from: data)
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
        edges: [RepositoryEdge?]?? = nil
    ) -> RepositoryConnection {
        return RepositoryConnection(
            edges: edges ?? self.edges
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RepositoryEdge
struct RepositoryEdge: Codable {
    let node: Repository?

    enum CodingKeys: String, CodingKey {
        case node = "node"
    }
}

// MARK: RepositoryEdge convenience initializers and mutators

extension RepositoryEdge {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RepositoryEdge.self, from: data)
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
        node: Repository?? = nil
    ) -> RepositoryEdge {
        return RepositoryEdge(
            node: node ?? self.node
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Repository
struct Repository: Codable {
    let name: String
    let stargazers: Connection
    let forks: Connection
    let watchers: Connection
    let issues: Connection

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case stargazers = "stargazers"
        case forks = "forks"
        case watchers = "watchers"
        case issues = "issues"
    }
}

// MARK: Repository convenience initializers and mutators

extension Repository {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repository.self, from: data)
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
        stargazers: Connection? = nil,
        forks: Connection? = nil,
        watchers: Connection? = nil,
        issues: Connection? = nil
    ) -> Repository {
        return Repository(
            name: name ?? self.name,
            stargazers: stargazers ?? self.stargazers,
            forks: forks ?? self.forks,
            watchers: watchers ?? self.watchers,
            issues: issues ?? self.issues
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Connection
struct Connection: Codable {
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "totalCount"
    }
}

// MARK: Connection convenience initializers and mutators

extension Connection {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Connection.self, from: data)
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
        totalCount: Int? = nil
    ) -> Connection {
        return Connection(
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

// MARK: - Error
struct Error: Codable {
    let message: String

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

// MARK: Error convenience initializers and mutators

extension Error {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Error.self, from: data)
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
        message: String? = nil
    ) -> Error {
        return Error(
            message: message ?? self.message
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
