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
    case null

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
        if container.decodeNil() {
            self = .null
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
        case .null:
            try container.encodeNil()
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
    let attribution: String
    let attributionLink: String
    let averageRating: Int
    let category: String
    let columns: [Column]
    let createdAt: Int
    let description: String
    let displayType: String
    let downloadCount: Int
    let flags: [String]
    let grants: [Grant]
    let hideFromCatalog: Bool
    let hideFromDataJSON: Bool
    let id: String
    let indexUpdatedAt: Int
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
    let rowsUpdatedAt: Int
    let rowsUpdatedBy: String
    let tableAuthor: Owner
    let tableID: Int
    let tags: [String]
    let totalTimesRated: Int
    let viewCount: Int
    let viewLastModified: Int
    let viewType: String

    enum CodingKeys: String, CodingKey {
        case attribution = "attribution"
        case attributionLink = "attributionLink"
        case averageRating = "averageRating"
        case category = "category"
        case columns = "columns"
        case createdAt = "createdAt"
        case description = "description"
        case displayType = "displayType"
        case downloadCount = "downloadCount"
        case flags = "flags"
        case grants = "grants"
        case hideFromCatalog = "hideFromCatalog"
        case hideFromDataJSON = "hideFromDataJson"
        case id = "id"
        case indexUpdatedAt = "indexUpdatedAt"
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
        case rowsUpdatedAt = "rowsUpdatedAt"
        case rowsUpdatedBy = "rowsUpdatedBy"
        case tableAuthor = "tableAuthor"
        case tableID = "tableId"
        case tags = "tags"
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
        attribution: String? = nil,
        attributionLink: String? = nil,
        averageRating: Int? = nil,
        category: String? = nil,
        columns: [Column]? = nil,
        createdAt: Int? = nil,
        description: String? = nil,
        displayType: String? = nil,
        downloadCount: Int? = nil,
        flags: [String]? = nil,
        grants: [Grant]? = nil,
        hideFromCatalog: Bool? = nil,
        hideFromDataJSON: Bool? = nil,
        id: String? = nil,
        indexUpdatedAt: Int? = nil,
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
        rowsUpdatedAt: Int? = nil,
        rowsUpdatedBy: String? = nil,
        tableAuthor: Owner? = nil,
        tableID: Int? = nil,
        tags: [String]? = nil,
        totalTimesRated: Int? = nil,
        viewCount: Int? = nil,
        viewLastModified: Int? = nil,
        viewType: String? = nil
    ) -> View {
        return View(
            attribution: attribution ?? self.attribution,
            attributionLink: attributionLink ?? self.attributionLink,
            averageRating: averageRating ?? self.averageRating,
            category: category ?? self.category,
            columns: columns ?? self.columns,
            createdAt: createdAt ?? self.createdAt,
            description: description ?? self.description,
            displayType: displayType ?? self.displayType,
            downloadCount: downloadCount ?? self.downloadCount,
            flags: flags ?? self.flags,
            grants: grants ?? self.grants,
            hideFromCatalog: hideFromCatalog ?? self.hideFromCatalog,
            hideFromDataJSON: hideFromDataJSON ?? self.hideFromDataJSON,
            id: id ?? self.id,
            indexUpdatedAt: indexUpdatedAt ?? self.indexUpdatedAt,
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
            rowsUpdatedAt: rowsUpdatedAt ?? self.rowsUpdatedAt,
            rowsUpdatedBy: rowsUpdatedBy ?? self.rowsUpdatedBy,
            tableAuthor: tableAuthor ?? self.tableAuthor,
            tableID: tableID ?? self.tableID,
            tags: tags ?? self.tags,
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
    let description: String?
    let fieldName: String
    let flags: [String]?
    let format: Format
    let id: Int
    let name: String
    let position: Int
    let renderTypeName: TypeName
    let tableColumnID: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case cachedContents = "cachedContents"
        case dataTypeName = "dataTypeName"
        case description = "description"
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
        description: String?? = nil,
        fieldName: String? = nil,
        flags: [String]?? = nil,
        format: Format? = nil,
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
            description: description ?? self.description,
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
    let largest: String
    let nonNull: Int
    let null: Int
    let smallest: String
    let top: [Top]

    enum CodingKeys: String, CodingKey {
        case largest = "largest"
        case nonNull = "non_null"
        case null = "null"
        case smallest = "smallest"
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
        largest: String? = nil,
        nonNull: Int? = nil,
        null: Int? = nil,
        smallest: String? = nil,
        top: [Top]? = nil
    ) -> CachedContents {
        return CachedContents(
            largest: largest ?? self.largest,
            nonNull: nonNull ?? self.nonNull,
            null: null ?? self.null,
            smallest: smallest ?? self.smallest,
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
    case calendarDate = "calendar_date"
    case text = "text"
}

// MARK: - Format
struct Format: Codable {
    let align: String?
    let view: String?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case view = "view"
    }
}

// MARK: Format convenience initializers and mutators

extension Format {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Format.self, from: data)
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
        align: String?? = nil,
        view: String?? = nil
    ) -> Format {
        return Format(
            align: align ?? self.align,
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

// MARK: - Metadata
struct Metadata: Codable {
    let attachments: [Attachment]
    let availableDisplayTypes: [String]
    let customFields: CustomFields
    let jsonQuery: JSONQuery
    let rdfSubject: String
    let renderTypeConfig: RenderTypeConfig

    enum CodingKeys: String, CodingKey {
        case attachments = "attachments"
        case availableDisplayTypes = "availableDisplayTypes"
        case customFields = "custom_fields"
        case jsonQuery = "jsonQuery"
        case rdfSubject = "rdfSubject"
        case renderTypeConfig = "renderTypeConfig"
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
        attachments: [Attachment]? = nil,
        availableDisplayTypes: [String]? = nil,
        customFields: CustomFields? = nil,
        jsonQuery: JSONQuery? = nil,
        rdfSubject: String? = nil,
        renderTypeConfig: RenderTypeConfig? = nil
    ) -> Metadata {
        return Metadata(
            attachments: attachments ?? self.attachments,
            availableDisplayTypes: availableDisplayTypes ?? self.availableDisplayTypes,
            customFields: customFields ?? self.customFields,
            jsonQuery: jsonQuery ?? self.jsonQuery,
            rdfSubject: rdfSubject ?? self.rdfSubject,
            renderTypeConfig: renderTypeConfig ?? self.renderTypeConfig
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let assetID: String
    let blobID: String
    let filename: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case assetID = "assetId"
        case blobID = "blobId"
        case filename = "filename"
        case name = "name"
    }
}

// MARK: Attachment convenience initializers and mutators

extension Attachment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Attachment.self, from: data)
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
        assetID: String? = nil,
        blobID: String? = nil,
        filename: String? = nil,
        name: String? = nil
    ) -> Attachment {
        return Attachment(
            assetID: assetID ?? self.assetID,
            blobID: blobID ?? self.blobID,
            filename: filename ?? self.filename,
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

// MARK: - CustomFields
struct CustomFields: Codable {
    let additionalResources: AdditionalResources
    let commonCore: CommonCore
    let datasetInformation: DatasetInformation
    let datasetSummary: DatasetSummary
    let notes: Notes

    enum CodingKeys: String, CodingKey {
        case additionalResources = "Additional Resources"
        case commonCore = "Common Core"
        case datasetInformation = "Dataset Information"
        case datasetSummary = "Dataset Summary"
        case notes = "Notes"
    }
}

// MARK: CustomFields convenience initializers and mutators

extension CustomFields {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CustomFields.self, from: data)
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
        additionalResources: AdditionalResources? = nil,
        commonCore: CommonCore? = nil,
        datasetInformation: DatasetInformation? = nil,
        datasetSummary: DatasetSummary? = nil,
        notes: Notes? = nil
    ) -> CustomFields {
        return CustomFields(
            additionalResources: additionalResources ?? self.additionalResources,
            commonCore: commonCore ?? self.commonCore,
            datasetInformation: datasetInformation ?? self.datasetInformation,
            datasetSummary: datasetSummary ?? self.datasetSummary,
            notes: notes ?? self.notes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AdditionalResources
struct AdditionalResources: Codable {
    let seeAlso: String

    enum CodingKeys: String, CodingKey {
        case seeAlso = "See Also"
    }
}

// MARK: AdditionalResources convenience initializers and mutators

extension AdditionalResources {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AdditionalResources.self, from: data)
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
        seeAlso: String? = nil
    ) -> AdditionalResources {
        return AdditionalResources(
            seeAlso: seeAlso ?? self.seeAlso
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CommonCore
struct CommonCore: Codable {
    let contactEmail: String
    let contactName: String
    let publisher: String

    enum CodingKeys: String, CodingKey {
        case contactEmail = "Contact Email"
        case contactName = "Contact Name"
        case publisher = "Publisher"
    }
}

// MARK: CommonCore convenience initializers and mutators

extension CommonCore {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CommonCore.self, from: data)
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
        contactEmail: String? = nil,
        contactName: String? = nil,
        publisher: String? = nil
    ) -> CommonCore {
        return CommonCore(
            contactEmail: contactEmail ?? self.contactEmail,
            contactName: contactName ?? self.contactName,
            publisher: publisher ?? self.publisher
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DatasetInformation
struct DatasetInformation: Codable {
    let agency: String

    enum CodingKeys: String, CodingKey {
        case agency = "Agency"
    }
}

// MARK: DatasetInformation convenience initializers and mutators

extension DatasetInformation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DatasetInformation.self, from: data)
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
        agency: String? = nil
    ) -> DatasetInformation {
        return DatasetInformation(
            agency: agency ?? self.agency
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DatasetSummary
struct DatasetSummary: Codable {
    let contactInformation: String
    let coverage: String
    let dataFrequency: String
    let datasetOwner: String
    let granularity: String
    let organization: String
    let postingFrequency: String
    let timePeriod: String

    enum CodingKeys: String, CodingKey {
        case contactInformation = "Contact Information"
        case coverage = "Coverage"
        case dataFrequency = "Data Frequency"
        case datasetOwner = "Dataset Owner"
        case granularity = "Granularity"
        case organization = "Organization"
        case postingFrequency = "Posting Frequency"
        case timePeriod = "Time Period"
    }
}

// MARK: DatasetSummary convenience initializers and mutators

extension DatasetSummary {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DatasetSummary.self, from: data)
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
        contactInformation: String? = nil,
        coverage: String? = nil,
        dataFrequency: String? = nil,
        datasetOwner: String? = nil,
        granularity: String? = nil,
        organization: String? = nil,
        postingFrequency: String? = nil,
        timePeriod: String? = nil
    ) -> DatasetSummary {
        return DatasetSummary(
            contactInformation: contactInformation ?? self.contactInformation,
            coverage: coverage ?? self.coverage,
            dataFrequency: dataFrequency ?? self.dataFrequency,
            datasetOwner: datasetOwner ?? self.datasetOwner,
            granularity: granularity ?? self.granularity,
            organization: organization ?? self.organization,
            postingFrequency: postingFrequency ?? self.postingFrequency,
            timePeriod: timePeriod ?? self.timePeriod
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Notes
struct Notes: Codable {
    let notes: String

    enum CodingKeys: String, CodingKey {
        case notes = "Notes"
    }
}

// MARK: Notes convenience initializers and mutators

extension Notes {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Notes.self, from: data)
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
        notes: String? = nil
    ) -> Notes {
        return Notes(
            notes: notes ?? self.notes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONQuery
struct JSONQuery: Codable {
    let order: [Order]

    enum CodingKeys: String, CodingKey {
        case order = "order"
    }
}

// MARK: JSONQuery convenience initializers and mutators

extension JSONQuery {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONQuery.self, from: data)
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
        order: [Order]? = nil
    ) -> JSONQuery {
        return JSONQuery(
            order: order ?? self.order
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Order
struct Order: Codable {
    let ascending: Bool
    let columnFieldName: String

    enum CodingKeys: String, CodingKey {
        case ascending = "ascending"
        case columnFieldName = "columnFieldName"
    }
}

// MARK: Order convenience initializers and mutators

extension Order {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Order.self, from: data)
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
        ascending: Bool? = nil,
        columnFieldName: String? = nil
    ) -> Order {
        return Order(
            ascending: ascending ?? self.ascending,
            columnFieldName: columnFieldName ?? self.columnFieldName
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
    let profileImageURLLarge: String
    let profileImageURLMedium: String
    let profileImageURLSmall: String
    let rights: [String]
    let roleName: String
    let screenName: String

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case id = "id"
        case profileImageURLLarge = "profileImageUrlLarge"
        case profileImageURLMedium = "profileImageUrlMedium"
        case profileImageURLSmall = "profileImageUrlSmall"
        case rights = "rights"
        case roleName = "roleName"
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
        profileImageURLLarge: String? = nil,
        profileImageURLMedium: String? = nil,
        profileImageURLSmall: String? = nil,
        rights: [String]? = nil,
        roleName: String? = nil,
        screenName: String? = nil
    ) -> Owner {
        return Owner(
            displayName: displayName ?? self.displayName,
            id: id ?? self.id,
            profileImageURLLarge: profileImageURLLarge ?? self.profileImageURLLarge,
            profileImageURLMedium: profileImageURLMedium ?? self.profileImageURLMedium,
            profileImageURLSmall: profileImageURLSmall ?? self.profileImageURLSmall,
            rights: rights ?? self.rights,
            roleName: roleName ?? self.roleName,
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

// MARK: - Query
struct Query: Codable {
    let orderBys: [OrderBy]

    enum CodingKeys: String, CodingKey {
        case orderBys = "orderBys"
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
        orderBys: [OrderBy]? = nil
    ) -> Query {
        return Query(
            orderBys: orderBys ?? self.orderBys
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OrderBy
struct OrderBy: Codable {
    let ascending: Bool
    let expression: Expression

    enum CodingKeys: String, CodingKey {
        case ascending = "ascending"
        case expression = "expression"
    }
}

// MARK: OrderBy convenience initializers and mutators

extension OrderBy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OrderBy.self, from: data)
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
        ascending: Bool? = nil,
        expression: Expression? = nil
    ) -> OrderBy {
        return OrderBy(
            ascending: ascending ?? self.ascending,
            expression: expression ?? self.expression
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Expression
struct Expression: Codable {
    let columnID: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case columnID = "columnId"
        case type = "type"
    }
}

// MARK: Expression convenience initializers and mutators

extension Expression {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Expression.self, from: data)
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
        columnID: Int? = nil,
        type: String? = nil
    ) -> Expression {
        return Expression(
            columnID: columnID ?? self.columnID,
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
