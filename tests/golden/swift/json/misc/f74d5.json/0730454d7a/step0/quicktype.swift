// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let data: [[Datum]]
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
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
        data: [[Datum]]? = nil,
        meta: Meta? = nil
    ) -> TopLevel {
        return TopLevel(
            data: data ?? self.data,
            meta: meta ?? self.meta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Datum: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Datum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Datum"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Meta
struct Meta: Codable {
    let view: View

    enum CodingKeys: String, CodingKey {
        case view = "view"
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
        view: View? = nil
    ) -> Meta {
        return Meta(
            view: view ?? self.view
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - View
struct View: Codable {
    let averageRating: Int
    let category: String
    let columns: [Column]
    let createdAt: Int
    let displayType: String
    let downloadCount: Int
    let flags: [String]
    let grants: [Grant]
    let hideFromCatalog: Bool
    let hideFromDataJSON: Bool
    let id: String
    let indexUpdatedAt: Int
    let license: License
    let licenseID: String
    let locale: String
    let metadata: Metadata
    let name: String
    let newBackend: Bool
    let numberOfComments: Int
    let oid: Int
    let owner: Owner
    let provenance: String
    let publicationAppendEnabled: Bool
    let publicationDate: Int
    let publicationGroup: Int
    let publicationStage: String
    let query: Query
    let rights: [String]
    let rowClass: String
    let rowsUpdatedAt: Int
    let rowsUpdatedBy: String
    let tableAuthor: Owner
    let tableID: Int
    let totalTimesRated: Int
    let viewCount: Int
    let viewLastModified: Int
    let viewType: String

    enum CodingKeys: String, CodingKey {
        case averageRating = "averageRating"
        case category = "category"
        case columns = "columns"
        case createdAt = "createdAt"
        case displayType = "displayType"
        case downloadCount = "downloadCount"
        case flags = "flags"
        case grants = "grants"
        case hideFromCatalog = "hideFromCatalog"
        case hideFromDataJSON = "hideFromDataJson"
        case id = "id"
        case indexUpdatedAt = "indexUpdatedAt"
        case license = "license"
        case licenseID = "licenseId"
        case locale = "locale"
        case metadata = "metadata"
        case name = "name"
        case newBackend = "newBackend"
        case numberOfComments = "numberOfComments"
        case oid = "oid"
        case owner = "owner"
        case provenance = "provenance"
        case publicationAppendEnabled = "publicationAppendEnabled"
        case publicationDate = "publicationDate"
        case publicationGroup = "publicationGroup"
        case publicationStage = "publicationStage"
        case query = "query"
        case rights = "rights"
        case rowClass = "rowClass"
        case rowsUpdatedAt = "rowsUpdatedAt"
        case rowsUpdatedBy = "rowsUpdatedBy"
        case tableAuthor = "tableAuthor"
        case tableID = "tableId"
        case totalTimesRated = "totalTimesRated"
        case viewCount = "viewCount"
        case viewLastModified = "viewLastModified"
        case viewType = "viewType"
    }
}

// MARK: View convenience initializers and mutators

extension View {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(View.self, from: data)
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
        averageRating: Int? = nil,
        category: String? = nil,
        columns: [Column]? = nil,
        createdAt: Int? = nil,
        displayType: String? = nil,
        downloadCount: Int? = nil,
        flags: [String]? = nil,
        grants: [Grant]? = nil,
        hideFromCatalog: Bool? = nil,
        hideFromDataJSON: Bool? = nil,
        id: String? = nil,
        indexUpdatedAt: Int? = nil,
        license: License? = nil,
        licenseID: String? = nil,
        locale: String? = nil,
        metadata: Metadata? = nil,
        name: String? = nil,
        newBackend: Bool? = nil,
        numberOfComments: Int? = nil,
        oid: Int? = nil,
        owner: Owner? = nil,
        provenance: String? = nil,
        publicationAppendEnabled: Bool? = nil,
        publicationDate: Int? = nil,
        publicationGroup: Int? = nil,
        publicationStage: String? = nil,
        query: Query? = nil,
        rights: [String]? = nil,
        rowClass: String? = nil,
        rowsUpdatedAt: Int? = nil,
        rowsUpdatedBy: String? = nil,
        tableAuthor: Owner? = nil,
        tableID: Int? = nil,
        totalTimesRated: Int? = nil,
        viewCount: Int? = nil,
        viewLastModified: Int? = nil,
        viewType: String? = nil
    ) -> View {
        return View(
            averageRating: averageRating ?? self.averageRating,
            category: category ?? self.category,
            columns: columns ?? self.columns,
            createdAt: createdAt ?? self.createdAt,
            displayType: displayType ?? self.displayType,
            downloadCount: downloadCount ?? self.downloadCount,
            flags: flags ?? self.flags,
            grants: grants ?? self.grants,
            hideFromCatalog: hideFromCatalog ?? self.hideFromCatalog,
            hideFromDataJSON: hideFromDataJSON ?? self.hideFromDataJSON,
            id: id ?? self.id,
            indexUpdatedAt: indexUpdatedAt ?? self.indexUpdatedAt,
            license: license ?? self.license,
            licenseID: licenseID ?? self.licenseID,
            locale: locale ?? self.locale,
            metadata: metadata ?? self.metadata,
            name: name ?? self.name,
            newBackend: newBackend ?? self.newBackend,
            numberOfComments: numberOfComments ?? self.numberOfComments,
            oid: oid ?? self.oid,
            owner: owner ?? self.owner,
            provenance: provenance ?? self.provenance,
            publicationAppendEnabled: publicationAppendEnabled ?? self.publicationAppendEnabled,
            publicationDate: publicationDate ?? self.publicationDate,
            publicationGroup: publicationGroup ?? self.publicationGroup,
            publicationStage: publicationStage ?? self.publicationStage,
            query: query ?? self.query,
            rights: rights ?? self.rights,
            rowClass: rowClass ?? self.rowClass,
            rowsUpdatedAt: rowsUpdatedAt ?? self.rowsUpdatedAt,
            rowsUpdatedBy: rowsUpdatedBy ?? self.rowsUpdatedBy,
            tableAuthor: tableAuthor ?? self.tableAuthor,
            tableID: tableID ?? self.tableID,
            totalTimesRated: totalTimesRated ?? self.totalTimesRated,
            viewCount: viewCount ?? self.viewCount,
            viewLastModified: viewLastModified ?? self.viewLastModified,
            viewType: viewType ?? self.viewType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Column
struct Column: Codable {
    let cachedContents: CachedContents?
    let dataTypeName: TypeName
    let fieldName: String
    let flags: [String]?
    let format: Query
    let id: Int
    let name: String
    let position: Int
    let renderTypeName: TypeName
    let tableColumnID: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case cachedContents = "cachedContents"
        case dataTypeName = "dataTypeName"
        case fieldName = "fieldName"
        case flags = "flags"
        case format = "format"
        case id = "id"
        case name = "name"
        case position = "position"
        case renderTypeName = "renderTypeName"
        case tableColumnID = "tableColumnId"
        case width = "width"
    }
}

// MARK: Column convenience initializers and mutators

extension Column {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Column.self, from: data)
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
        cachedContents: CachedContents?? = nil,
        dataTypeName: TypeName? = nil,
        fieldName: String? = nil,
        flags: [String]?? = nil,
        format: Query? = nil,
        id: Int? = nil,
        name: String? = nil,
        position: Int? = nil,
        renderTypeName: TypeName? = nil,
        tableColumnID: Int?? = nil,
        width: Int?? = nil
    ) -> Column {
        return Column(
            cachedContents: cachedContents ?? self.cachedContents,
            dataTypeName: dataTypeName ?? self.dataTypeName,
            fieldName: fieldName ?? self.fieldName,
            flags: flags ?? self.flags,
            format: format ?? self.format,
            id: id ?? self.id,
            name: name ?? self.name,
            position: position ?? self.position,
            renderTypeName: renderTypeName ?? self.renderTypeName,
            tableColumnID: tableColumnID ?? self.tableColumnID,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CachedContents
struct CachedContents: Codable {
    let average: String?
    let largest: String
    let nonNull: Int
    let null: Int
    let smallest: String
    let sum: String?
    let top: [Top]

    enum CodingKeys: String, CodingKey {
        case average = "average"
        case largest = "largest"
        case nonNull = "non_null"
        case null = "null"
        case smallest = "smallest"
        case sum = "sum"
        case top = "top"
    }
}

// MARK: CachedContents convenience initializers and mutators

extension CachedContents {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CachedContents.self, from: data)
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
        average: String?? = nil,
        largest: String? = nil,
        nonNull: Int? = nil,
        null: Int? = nil,
        smallest: String? = nil,
        sum: String?? = nil,
        top: [Top]? = nil
    ) -> CachedContents {
        return CachedContents(
            average: average ?? self.average,
            largest: largest ?? self.largest,
            nonNull: nonNull ?? self.nonNull,
            null: null ?? self.null,
            smallest: smallest ?? self.smallest,
            sum: sum ?? self.sum,
            top: top ?? self.top
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Top
struct Top: Codable {
    let count: Int
    let item: String

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case item = "item"
    }
}

// MARK: Top convenience initializers and mutators

extension Top {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Top.self, from: data)
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
        item: String? = nil
    ) -> Top {
        return Top(
            count: count ?? self.count,
            item: item ?? self.item
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeName: String, Codable {
    case metaData = "meta_data"
    case number = "number"
    case text = "text"
}

// MARK: - Query
struct Query: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Query convenience initializers and mutators

extension Query {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Query.self, from: data)
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
    ) -> Query {
        return Query(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Grant
struct Grant: Codable {
    let flags: [String]
    let inherited: Bool
    let type: String

    enum CodingKeys: String, CodingKey {
        case flags = "flags"
        case inherited = "inherited"
        case type = "type"
    }
}

// MARK: Grant convenience initializers and mutators

extension Grant {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Grant.self, from: data)
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
        flags: [String]? = nil,
        inherited: Bool? = nil,
        type: String? = nil
    ) -> Grant {
        return Grant(
            flags: flags ?? self.flags,
            inherited: inherited ?? self.inherited,
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

// MARK: - License
struct License: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

// MARK: License convenience initializers and mutators

extension License {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(License.self, from: data)
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
    ) -> License {
        return License(
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

// MARK: - Metadata
struct Metadata: Codable {
    let availableDisplayTypes: [String]
    let rdfClass: String
    let rdfSubject: String
    let renderTypeConfig: RenderTypeConfig
    let rowIdentifier: String

    enum CodingKeys: String, CodingKey {
        case availableDisplayTypes = "availableDisplayTypes"
        case rdfClass = "rdfClass"
        case rdfSubject = "rdfSubject"
        case renderTypeConfig = "renderTypeConfig"
        case rowIdentifier = "rowIdentifier"
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
        availableDisplayTypes: [String]? = nil,
        rdfClass: String? = nil,
        rdfSubject: String? = nil,
        renderTypeConfig: RenderTypeConfig? = nil,
        rowIdentifier: String? = nil
    ) -> Metadata {
        return Metadata(
            availableDisplayTypes: availableDisplayTypes ?? self.availableDisplayTypes,
            rdfClass: rdfClass ?? self.rdfClass,
            rdfSubject: rdfSubject ?? self.rdfSubject,
            renderTypeConfig: renderTypeConfig ?? self.renderTypeConfig,
            rowIdentifier: rowIdentifier ?? self.rowIdentifier
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RenderTypeConfig
struct RenderTypeConfig: Codable {
    let visible: Visible

    enum CodingKeys: String, CodingKey {
        case visible = "visible"
    }
}

// MARK: RenderTypeConfig convenience initializers and mutators

extension RenderTypeConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RenderTypeConfig.self, from: data)
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
        visible: Visible? = nil
    ) -> RenderTypeConfig {
        return RenderTypeConfig(
            visible: visible ?? self.visible
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Visible
struct Visible: Codable {
    let table: Bool

    enum CodingKeys: String, CodingKey {
        case table = "table"
    }
}

// MARK: Visible convenience initializers and mutators

extension Visible {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Visible.self, from: data)
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
        table: Bool? = nil
    ) -> Visible {
        return Visible(
            table: table ?? self.table
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
    let id: String
    let screenName: String

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case id = "id"
        case screenName = "screenName"
    }
}

// MARK: Owner convenience initializers and mutators

extension Owner {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Owner.self, from: data)
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
        displayName: String? = nil,
        id: String? = nil,
        screenName: String? = nil
    ) -> Owner {
        return Owner(
            displayName: displayName ?? self.displayName,
            id: id ?? self.id,
            screenName: screenName ?? self.screenName
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
