// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let averageRating: Int
    let category: String?
    let createdAt: Int
    let description: String?
    let displayType: DisplayType?
    let downloadCount: Int
    let flags: [TopLevelFlag]?
    let grants: [Grant]
    let hideFromCatalog: Bool
    let hideFromDataJSON: Bool
    let id: String
    let indexUpdatedAt: Int?
    let locale: String
    let metadata: TopLevelMetadata
    let moderationStatus: Bool?
    let modifyingViewUid: ModifyingViewUid?
    let name: String
    let newBackend: Bool
    let numberOfComments: Int
    let oid: Int
    let owner: Owner
    let provenance: Provenance
    let publicationAppendEnabled: Bool
    let publicationDate: Int?
    let publicationGroup: Int
    let publicationStage: PublicationStage
    let ratings: Ratings?
    let resourceName: String?
    let rights: [Right]
    let rowClass: String?
    let rowIdentifierColumnID: Int?
    let rowsUpdatedAt: Int?
    let rowsUpdatedBy: RowsUpdatedBy?
    let tableAuthor: TableAuthor
    let tableID: Int
    let tags: [String]?
    let totalTimesRated: Int
    let viewCount: Int
    let viewLastModified: Int
    let viewType: ViewType

    enum CodingKeys: String, CodingKey {
        case averageRating = "averageRating"
        case category = "category"
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
        case moderationStatus = "moderationStatus"
        case modifyingViewUid = "modifyingViewUid"
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
        case ratings = "ratings"
        case resourceName = "resourceName"
        case rights = "rights"
        case rowClass = "rowClass"
        case rowIdentifierColumnID = "rowIdentifierColumnId"
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

// MARK: TopLevelElement convenience initializers and mutators

extension TopLevelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelElement.self, from: data)
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
        category: String?? = nil,
        createdAt: Int? = nil,
        description: String?? = nil,
        displayType: DisplayType?? = nil,
        downloadCount: Int? = nil,
        flags: [TopLevelFlag]?? = nil,
        grants: [Grant]? = nil,
        hideFromCatalog: Bool? = nil,
        hideFromDataJSON: Bool? = nil,
        id: String? = nil,
        indexUpdatedAt: Int?? = nil,
        locale: String? = nil,
        metadata: TopLevelMetadata? = nil,
        moderationStatus: Bool?? = nil,
        modifyingViewUid: ModifyingViewUid?? = nil,
        name: String? = nil,
        newBackend: Bool? = nil,
        numberOfComments: Int? = nil,
        oid: Int? = nil,
        owner: Owner? = nil,
        provenance: Provenance? = nil,
        publicationAppendEnabled: Bool? = nil,
        publicationDate: Int?? = nil,
        publicationGroup: Int? = nil,
        publicationStage: PublicationStage? = nil,
        ratings: Ratings?? = nil,
        resourceName: String?? = nil,
        rights: [Right]? = nil,
        rowClass: String?? = nil,
        rowIdentifierColumnID: Int?? = nil,
        rowsUpdatedAt: Int?? = nil,
        rowsUpdatedBy: RowsUpdatedBy?? = nil,
        tableAuthor: TableAuthor? = nil,
        tableID: Int? = nil,
        tags: [String]?? = nil,
        totalTimesRated: Int? = nil,
        viewCount: Int? = nil,
        viewLastModified: Int? = nil,
        viewType: ViewType? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            averageRating: averageRating ?? self.averageRating,
            category: category ?? self.category,
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
            moderationStatus: moderationStatus ?? self.moderationStatus,
            modifyingViewUid: modifyingViewUid ?? self.modifyingViewUid,
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
            ratings: ratings ?? self.ratings,
            resourceName: resourceName ?? self.resourceName,
            rights: rights ?? self.rights,
            rowClass: rowClass ?? self.rowClass,
            rowIdentifierColumnID: rowIdentifierColumnID ?? self.rowIdentifierColumnID,
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

enum DisplayType: String, Codable {
    case table = "table"
    case dataLens = "data_lens"
    case fatrow = "fatrow"
    case page = "page"
}

enum TopLevelFlag: String, Codable {
    case flagDefault = "default"
    case restorable = "restorable"
    case restorePossibleForType = "restorePossibleForType"
}

// MARK: - Grant
struct Grant: Codable {
    let flags: [GrantFlag]
    let inherited: Bool
    let type: GrantType

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
        flags: [GrantFlag]? = nil,
        inherited: Bool? = nil,
        type: GrantType? = nil
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

enum GrantFlag: String, Codable {
    case flagPublic = "public"
}

enum GrantType: String, Codable {
    case viewer = "viewer"
}

// MARK: - TopLevelMetadata
struct TopLevelMetadata: Codable {
    let availableDisplayTypes: [DisplayType]?
    let customFields: CustomFields?
    let jsonQuery: JSONQuery?
    let rdfClass: String?
    let rdfSubject: String?
    let renderTypeConfig: MetadataRenderTypeConfig?
    let richRendererConfigs: RichRendererConfigs?
    let rowIdentifier: String?
    let rowLabel: String?
    let v1ArchivedProperties: V1ArchivedProperties?

    enum CodingKeys: String, CodingKey {
        case availableDisplayTypes = "availableDisplayTypes"
        case customFields = "custom_fields"
        case jsonQuery = "jsonQuery"
        case rdfClass = "rdfClass"
        case rdfSubject = "rdfSubject"
        case renderTypeConfig = "renderTypeConfig"
        case richRendererConfigs = "richRendererConfigs"
        case rowIdentifier = "rowIdentifier"
        case rowLabel = "rowLabel"
        case v1ArchivedProperties = "v1_archived_properties"
    }
}

// MARK: TopLevelMetadata convenience initializers and mutators

extension TopLevelMetadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelMetadata.self, from: data)
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
        availableDisplayTypes: [DisplayType]?? = nil,
        customFields: CustomFields?? = nil,
        jsonQuery: JSONQuery?? = nil,
        rdfClass: String?? = nil,
        rdfSubject: String?? = nil,
        renderTypeConfig: MetadataRenderTypeConfig?? = nil,
        richRendererConfigs: RichRendererConfigs?? = nil,
        rowIdentifier: String?? = nil,
        rowLabel: String?? = nil,
        v1ArchivedProperties: V1ArchivedProperties?? = nil
    ) -> TopLevelMetadata {
        return TopLevelMetadata(
            availableDisplayTypes: availableDisplayTypes ?? self.availableDisplayTypes,
            customFields: customFields ?? self.customFields,
            jsonQuery: jsonQuery ?? self.jsonQuery,
            rdfClass: rdfClass ?? self.rdfClass,
            rdfSubject: rdfSubject ?? self.rdfSubject,
            renderTypeConfig: renderTypeConfig ?? self.renderTypeConfig,
            richRendererConfigs: richRendererConfigs ?? self.richRendererConfigs,
            rowIdentifier: rowIdentifier ?? self.rowIdentifier,
            rowLabel: rowLabel ?? self.rowLabel,
            v1ArchivedProperties: v1ArchivedProperties ?? self.v1ArchivedProperties
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
    let test: Test

    enum CodingKeys: String, CodingKey {
        case test = "TEST"
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
        test: Test? = nil
    ) -> CustomFields {
        return CustomFields(
            test: test ?? self.test
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Test
struct Test: Codable {
    let cfpb1: String

    enum CodingKeys: String, CodingKey {
        case cfpb1 = "CFPB1"
    }
}

// MARK: Test convenience initializers and mutators

extension Test {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Test.self, from: data)
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
        cfpb1: String? = nil
    ) -> Test {
        return Test(
            cfpb1: cfpb1 ?? self.cfpb1
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
    let group: [Group]?
    let jsonQueryWhere: Where?
    let order: [Order]?
    let select: [Select]?

    enum CodingKeys: String, CodingKey {
        case group = "group"
        case jsonQueryWhere = "where"
        case order = "order"
        case select = "select"
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
        group: [Group]?? = nil,
        jsonQueryWhere: Where?? = nil,
        order: [Order]?? = nil,
        select: [Select]?? = nil
    ) -> JSONQuery {
        return JSONQuery(
            group: group ?? self.group,
            jsonQueryWhere: jsonQueryWhere ?? self.jsonQueryWhere,
            order: order ?? self.order,
            select: select ?? self.select
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Group
struct Group: Codable {
    let columnFieldName: String

    enum CodingKeys: String, CodingKey {
        case columnFieldName = "columnFieldName"
    }
}

// MARK: Group convenience initializers and mutators

extension Group {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Group.self, from: data)
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
        columnFieldName: String? = nil
    ) -> Group {
        return Group(
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

// MARK: - Where
struct Where: Codable {
    let children: [Child]?
    let columnFieldName: ChildColumnFieldName?
    let metadata: ChildMetadata?
    let value: String?
    let whereOperator: WhereOperator

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case columnFieldName = "columnFieldName"
        case metadata = "metadata"
        case value = "value"
        case whereOperator = "operator"
    }
}

// MARK: Where convenience initializers and mutators

extension Where {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Where.self, from: data)
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
        children: [Child]?? = nil,
        columnFieldName: ChildColumnFieldName?? = nil,
        metadata: ChildMetadata?? = nil,
        value: String?? = nil,
        whereOperator: WhereOperator? = nil
    ) -> Where {
        return Where(
            children: children ?? self.children,
            columnFieldName: columnFieldName ?? self.columnFieldName,
            metadata: metadata ?? self.metadata,
            value: value ?? self.value,
            whereOperator: whereOperator ?? self.whereOperator
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Child
struct Child: Codable {
    let childOperator: ChildOperator
    let columnFieldName: ChildColumnFieldName
    let metadata: ChildMetadata?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case childOperator = "operator"
        case columnFieldName = "columnFieldName"
        case metadata = "metadata"
        case value = "value"
    }
}

// MARK: Child convenience initializers and mutators

extension Child {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Child.self, from: data)
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
        childOperator: ChildOperator? = nil,
        columnFieldName: ChildColumnFieldName? = nil,
        metadata: ChildMetadata?? = nil,
        value: String?? = nil
    ) -> Child {
        return Child(
            childOperator: childOperator ?? self.childOperator,
            columnFieldName: columnFieldName ?? self.columnFieldName,
            metadata: metadata ?? self.metadata,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ChildOperator: String, Codable {
    case equals = "EQUALS"
    case isNotBlank = "IS_NOT_BLANK"
}

enum ChildColumnFieldName: String, Codable {
    case product = "product"
    case complaintWhatHappened = "complaint_what_happened"
    case subProduct = "sub_product"
    case issue = "issue"
}

// MARK: - ChildMetadata
struct ChildMetadata: Codable {
    let customValues: [String]?
    let freeform: Bool?
    let includeAuto: Int?
    let metadataOperator: MetadataOperator?
    let tableColumnID: TableColumnID?
    let unifiedVersion: Int?

    enum CodingKeys: String, CodingKey {
        case customValues = "customValues"
        case freeform = "freeform"
        case includeAuto = "includeAuto"
        case metadataOperator = "operator"
        case tableColumnID = "tableColumnId"
        case unifiedVersion = "unifiedVersion"
    }
}

// MARK: ChildMetadata convenience initializers and mutators

extension ChildMetadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChildMetadata.self, from: data)
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
        customValues: [String]?? = nil,
        freeform: Bool?? = nil,
        includeAuto: Int?? = nil,
        metadataOperator: MetadataOperator?? = nil,
        tableColumnID: TableColumnID?? = nil,
        unifiedVersion: Int?? = nil
    ) -> ChildMetadata {
        return ChildMetadata(
            customValues: customValues ?? self.customValues,
            freeform: freeform ?? self.freeform,
            includeAuto: includeAuto ?? self.includeAuto,
            metadataOperator: metadataOperator ?? self.metadataOperator,
            tableColumnID: tableColumnID ?? self.tableColumnID,
            unifiedVersion: unifiedVersion ?? self.unifiedVersion
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum MetadataOperator: String, Codable {
    case equals = "EQUALS"
    case blank = "blank?"
}

// MARK: - TableColumnID
struct TableColumnID: Codable {
    let the2819740: Int

    enum CodingKeys: String, CodingKey {
        case the2819740 = "2819740"
    }
}

// MARK: TableColumnID convenience initializers and mutators

extension TableColumnID {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TableColumnID.self, from: data)
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
        the2819740: Int? = nil
    ) -> TableColumnID {
        return TableColumnID(
            the2819740: the2819740 ?? self.the2819740
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum WhereOperator: String, Codable {
    case equals = "EQUALS"
    case and = "AND"
}

// MARK: - Order
struct Order: Codable {
    let ascending: Bool
    let columnFieldName: OrderColumnFieldName

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
        columnFieldName: OrderColumnFieldName? = nil
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

enum OrderColumnFieldName: String, Codable {
    case dateReceived = "date_received"
    case agreementDate = "agreement_date"
    case inEffectAsOf1_1_2012 = "in_effect_as_of_1_1_2012"
}

// MARK: - Select
struct Select: Codable {
    let aggregate: String?
    let columnFieldName: String

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case columnFieldName = "columnFieldName"
    }
}

// MARK: Select convenience initializers and mutators

extension Select {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Select.self, from: data)
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
        aggregate: String?? = nil,
        columnFieldName: String? = nil
    ) -> Select {
        return Select(
            aggregate: aggregate ?? self.aggregate,
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

// MARK: - MetadataRenderTypeConfig
struct MetadataRenderTypeConfig: Codable {
    let visible: PurpleVisible

    enum CodingKeys: String, CodingKey {
        case visible = "visible"
    }
}

// MARK: MetadataRenderTypeConfig convenience initializers and mutators

extension MetadataRenderTypeConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MetadataRenderTypeConfig.self, from: data)
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
        visible: PurpleVisible? = nil
    ) -> MetadataRenderTypeConfig {
        return MetadataRenderTypeConfig(
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

// MARK: - PurpleVisible
struct PurpleVisible: Codable {
    let fatrow: Bool?
    let table: Bool?

    enum CodingKeys: String, CodingKey {
        case fatrow = "fatrow"
        case table = "table"
    }
}

// MARK: PurpleVisible convenience initializers and mutators

extension PurpleVisible {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleVisible.self, from: data)
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
        fatrow: Bool?? = nil,
        table: Bool?? = nil
    ) -> PurpleVisible {
        return PurpleVisible(
            fatrow: fatrow ?? self.fatrow,
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

// MARK: - RichRendererConfigs
struct RichRendererConfigs: Codable {
    let fatRow: FatRow

    enum CodingKeys: String, CodingKey {
        case fatRow = "fatRow"
    }
}

// MARK: RichRendererConfigs convenience initializers and mutators

extension RichRendererConfigs {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RichRendererConfigs.self, from: data)
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
        fatRow: FatRow? = nil
    ) -> RichRendererConfigs {
        return RichRendererConfigs(
            fatRow: fatRow ?? self.fatRow
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FatRow
struct FatRow: Codable {
    let columns: [Column]

    enum CodingKeys: String, CodingKey {
        case columns = "columns"
    }
}

// MARK: FatRow convenience initializers and mutators

extension FatRow {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FatRow.self, from: data)
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
        columns: [Column]? = nil
    ) -> FatRow {
        return FatRow(
            columns: columns ?? self.columns
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
    let rows: [Row]
    let styles: Styles

    enum CodingKeys: String, CodingKey {
        case rows = "rows"
        case styles = "styles"
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
        rows: [Row]? = nil,
        styles: Styles? = nil
    ) -> Column {
        return Column(
            rows: rows ?? self.rows,
            styles: styles ?? self.styles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Row
struct Row: Codable {
    let fields: [Field]

    enum CodingKeys: String, CodingKey {
        case fields = "fields"
    }
}

// MARK: Row convenience initializers and mutators

extension Row {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Row.self, from: data)
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
        fields: [Field]? = nil
    ) -> Row {
        return Row(
            fields: fields ?? self.fields
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Field
struct Field: Codable {
    let tableColumnID: Int
    let type: FieldType

    enum CodingKeys: String, CodingKey {
        case tableColumnID = "tableColumnId"
        case type = "type"
    }
}

// MARK: Field convenience initializers and mutators

extension Field {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Field.self, from: data)
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
        tableColumnID: Int? = nil,
        type: FieldType? = nil
    ) -> Field {
        return Field(
            tableColumnID: tableColumnID ?? self.tableColumnID,
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

enum FieldType: String, Codable {
    case columnLabel = "columnLabel"
    case columnData = "columnData"
}

// MARK: - Styles
struct Styles: Codable {
    let width: Width

    enum CodingKeys: String, CodingKey {
        case width = "width"
    }
}

// MARK: Styles convenience initializers and mutators

extension Styles {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Styles.self, from: data)
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
        width: Width? = nil
    ) -> Styles {
        return Styles(
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

enum Width: String, Codable {
    case the27 = "27%"
    case the40 = "40%"
    case the30 = "30%"
    case the33 = "33%"
}

// MARK: - V1ArchivedProperties
struct V1ArchivedProperties: Codable {
    let accessPoints: AccessPoints
    let blistID: String
    let renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig

    enum CodingKeys: String, CodingKey {
        case accessPoints = "accessPoints"
        case blistID = "blist_id"
        case renderTypeConfig = "renderTypeConfig"
    }
}

// MARK: V1ArchivedProperties convenience initializers and mutators

extension V1ArchivedProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(V1ArchivedProperties.self, from: data)
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
        accessPoints: AccessPoints? = nil,
        blistID: String? = nil,
        renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig? = nil
    ) -> V1ArchivedProperties {
        return V1ArchivedProperties(
            accessPoints: accessPoints ?? self.accessPoints,
            blistID: blistID ?? self.blistID,
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

// MARK: - AccessPoints
struct AccessPoints: Codable {
    let newView: String

    enum CodingKeys: String, CodingKey {
        case newView = "new_view"
    }
}

// MARK: AccessPoints convenience initializers and mutators

extension AccessPoints {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AccessPoints.self, from: data)
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
        newView: String? = nil
    ) -> AccessPoints {
        return AccessPoints(
            newView: newView ?? self.newView
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - V1ArchivedPropertiesRenderTypeConfig
struct V1ArchivedPropertiesRenderTypeConfig: Codable {
    let visible: FluffyVisible

    enum CodingKeys: String, CodingKey {
        case visible = "visible"
    }
}

// MARK: V1ArchivedPropertiesRenderTypeConfig convenience initializers and mutators

extension V1ArchivedPropertiesRenderTypeConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(V1ArchivedPropertiesRenderTypeConfig.self, from: data)
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
        visible: FluffyVisible? = nil
    ) -> V1ArchivedPropertiesRenderTypeConfig {
        return V1ArchivedPropertiesRenderTypeConfig(
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

// MARK: - FluffyVisible
struct FluffyVisible: Codable {
    let href: Bool

    enum CodingKeys: String, CodingKey {
        case href = "href"
    }
}

// MARK: FluffyVisible convenience initializers and mutators

extension FluffyVisible {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyVisible.self, from: data)
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
        href: Bool? = nil
    ) -> FluffyVisible {
        return FluffyVisible(
            href: href ?? self.href
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ModifyingViewUid: String, Codable {
    case s6EwH6Mp = "s6ew-h6mp"
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
    let flags: [String]?
    let id: String
    let lastNotificationSeenAt: Int?
    let profileImageURLLarge: String?
    let profileImageURLMedium: String?
    let profileImageURLSmall: String?
    let rights: [String]?
    let roleName: RoleName?
    let screenName: String

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case flags = "flags"
        case id = "id"
        case lastNotificationSeenAt = "lastNotificationSeenAt"
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
        flags: [String]?? = nil,
        id: String? = nil,
        lastNotificationSeenAt: Int?? = nil,
        profileImageURLLarge: String?? = nil,
        profileImageURLMedium: String?? = nil,
        profileImageURLSmall: String?? = nil,
        rights: [String]?? = nil,
        roleName: RoleName?? = nil,
        screenName: String? = nil
    ) -> Owner {
        return Owner(
            displayName: displayName ?? self.displayName,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            lastNotificationSeenAt: lastNotificationSeenAt ?? self.lastNotificationSeenAt,
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

enum RoleName: String, Codable {
    case administrator = "administrator"
    case publisher = "publisher"
}

enum Provenance: String, Codable {
    case official = "official"
}

enum PublicationStage: String, Codable {
    case published = "published"
}

// MARK: - Ratings
struct Ratings: Codable {
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case rating = "rating"
    }
}

// MARK: Ratings convenience initializers and mutators

extension Ratings {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ratings.self, from: data)
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
        rating: Int? = nil
    ) -> Ratings {
        return Ratings(
            rating: rating ?? self.rating
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Right: String, Codable {
    case read = "read"
}

enum RowsUpdatedBy: String, Codable {
    case pjxgVe4M = "pjxg-ve4m"
    case the54A3Qyun = "54a3-qyun"
    case the9E3M2843 = "9e3m-2843"
    case vvcaFr6G = "vvca-fr6g"
}

// MARK: - TableAuthor
struct TableAuthor: Codable {
    let displayName: String
    let id: String
    let rights: [String]?
    let roleName: RoleName?
    let screenName: String

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case id = "id"
        case rights = "rights"
        case roleName = "roleName"
        case screenName = "screenName"
    }
}

// MARK: TableAuthor convenience initializers and mutators

extension TableAuthor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TableAuthor.self, from: data)
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
        rights: [String]?? = nil,
        roleName: RoleName?? = nil,
        screenName: String? = nil
    ) -> TableAuthor {
        return TableAuthor(
            displayName: displayName ?? self.displayName,
            id: id ?? self.id,
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

enum ViewType: String, Codable {
    case tabular = "tabular"
}

typealias TopLevel = [TopLevelElement]

extension Array where Element == TopLevel.Element {
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
