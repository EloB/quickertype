// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let children: [TopLevelChild]
    let flags: GetSignatureFlags
    let groups: [Group]
    let id: Int
    let kind: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case name = "name"
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
        children: [TopLevelChild]? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        name: String? = nil
    ) -> TopLevel {
        return TopLevel(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
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

// MARK: - TopLevelChild
struct TopLevelChild: Codable {
    let children: [PurpleChild]
    let comment: IndecentComment?
    let flags: PurpleFlags
    let groups: [Group]
    let id: Int
    let kind: Int
    let kindString: TentacledKindString
    let name: String
    let originalName: String
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case comment = "comment"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case originalName = "originalName"
        case sources = "sources"
    }
}

// MARK: TopLevelChild convenience initializers and mutators

extension TopLevelChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelChild.self, from: data)
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
        children: [PurpleChild]? = nil,
        comment: IndecentComment?? = nil,
        flags: PurpleFlags? = nil,
        groups: [Group]? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: TentacledKindString? = nil,
        name: String? = nil,
        originalName: String? = nil,
        sources: [Source]? = nil
    ) -> TopLevelChild {
        return TopLevelChild(
            children: children ?? self.children,
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            originalName: originalName ?? self.originalName,
            sources: sources ?? self.sources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PurpleChild
struct PurpleChild: Codable {
    let children: [FluffyChild]?
    let comment: StickyComment?
    let defaultValue: String?
    let extendedBy: [ExtendedBy]?
    let extendedTypes: [ExtendedBy]?
    let flags: IndecentFlags
    let groups: [Group]?
    let id: Int
    let implementedBy: [ExtendedBy]?
    let implementedTypes: [ExtendedBy]?
    let kind: Int
    let kindString: FluffyKindString
    let name: String
    let signatures: [StickySignature]?
    let sources: [Source]
    let type: MagentaType?
    let typeParameter: [TypeParameter]?

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case comment = "comment"
        case defaultValue = "defaultValue"
        case extendedBy = "extendedBy"
        case extendedTypes = "extendedTypes"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case implementedBy = "implementedBy"
        case implementedTypes = "implementedTypes"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
        case type = "type"
        case typeParameter = "typeParameter"
    }
}

// MARK: PurpleChild convenience initializers and mutators

extension PurpleChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleChild.self, from: data)
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
        children: [FluffyChild]?? = nil,
        comment: StickyComment?? = nil,
        defaultValue: String?? = nil,
        extendedBy: [ExtendedBy]?? = nil,
        extendedTypes: [ExtendedBy]?? = nil,
        flags: IndecentFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        implementedBy: [ExtendedBy]?? = nil,
        implementedTypes: [ExtendedBy]?? = nil,
        kind: Int? = nil,
        kindString: FluffyKindString? = nil,
        name: String? = nil,
        signatures: [StickySignature]?? = nil,
        sources: [Source]? = nil,
        type: MagentaType?? = nil,
        typeParameter: [TypeParameter]?? = nil
    ) -> PurpleChild {
        return PurpleChild(
            children: children ?? self.children,
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            extendedBy: extendedBy ?? self.extendedBy,
            extendedTypes: extendedTypes ?? self.extendedTypes,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            implementedBy: implementedBy ?? self.implementedBy,
            implementedTypes: implementedTypes ?? self.implementedTypes,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources,
            type: type ?? self.type,
            typeParameter: typeParameter ?? self.typeParameter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffyChild
struct FluffyChild: Codable {
    let children: [TentacledChild]?
    let comment: StickyComment?
    let defaultValue: String?
    let flags: StickyFlags
    let getSignature: GetSignature?
    let groups: [Group]?
    let id: Int
    let implementationOf: ExtendedBy?
    let inheritedFrom: ExtendedBy?
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let overwrites: ExtendedBy?
    let setSignature: GetSignature?
    let signatures: [FluffySignature]?
    let sources: [Source]
    let type: IndigoType?

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case comment = "comment"
        case defaultValue = "defaultValue"
        case flags = "flags"
        case getSignature = "getSignature"
        case groups = "groups"
        case id = "id"
        case implementationOf = "implementationOf"
        case inheritedFrom = "inheritedFrom"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case overwrites = "overwrites"
        case setSignature = "setSignature"
        case signatures = "signatures"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: FluffyChild convenience initializers and mutators

extension FluffyChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyChild.self, from: data)
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
        children: [TentacledChild]?? = nil,
        comment: StickyComment?? = nil,
        defaultValue: String?? = nil,
        flags: StickyFlags? = nil,
        getSignature: GetSignature?? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        implementationOf: ExtendedBy?? = nil,
        inheritedFrom: ExtendedBy?? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        overwrites: ExtendedBy?? = nil,
        setSignature: GetSignature?? = nil,
        signatures: [FluffySignature]?? = nil,
        sources: [Source]? = nil,
        type: IndigoType?? = nil
    ) -> FluffyChild {
        return FluffyChild(
            children: children ?? self.children,
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            flags: flags ?? self.flags,
            getSignature: getSignature ?? self.getSignature,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            implementationOf: implementationOf ?? self.implementationOf,
            inheritedFrom: inheritedFrom ?? self.inheritedFrom,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            overwrites: overwrites ?? self.overwrites,
            setSignature: setSignature ?? self.setSignature,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources,
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

// MARK: - TentacledChild
struct TentacledChild: Codable {
    let comment: PurpleComment?
    let defaultValue: String?
    let flags: PurpleFlags
    let id: Int
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let signatures: [PurpleSignature]?
    let sources: [Source]
    let type: TypeElement?

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case defaultValue = "defaultValue"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: TentacledChild convenience initializers and mutators

extension TentacledChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledChild.self, from: data)
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
        comment: PurpleComment?? = nil,
        defaultValue: String?? = nil,
        flags: PurpleFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        signatures: [PurpleSignature]?? = nil,
        sources: [Source]? = nil,
        type: TypeElement?? = nil
    ) -> TentacledChild {
        return TentacledChild(
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources,
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

// MARK: - PurpleComment
struct PurpleComment: Codable {
    let shortText: String

    enum CodingKeys: String, CodingKey {
        case shortText = "shortText"
    }
}

// MARK: PurpleComment convenience initializers and mutators

extension PurpleComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleComment.self, from: data)
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
        shortText: String? = nil
    ) -> PurpleComment {
        return PurpleComment(
            shortText: shortText ?? self.shortText
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PurpleFlags
struct PurpleFlags: Codable {
    let isExported: Bool?

    enum CodingKeys: String, CodingKey {
        case isExported = "isExported"
    }
}

// MARK: PurpleFlags convenience initializers and mutators

extension PurpleFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleFlags.self, from: data)
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
        isExported: Bool?? = nil
    ) -> PurpleFlags {
        return PurpleFlags(
            isExported: isExported ?? self.isExported
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum PurpleKindString: String, Codable {
    case variable = "Variable"
    case function = "Function"
    case property = "Property"
    case method = "Method"
    case constructor = "Constructor"
    case accessor = "Accessor"
    case enumerationMember = "Enumeration member"
    case module = "Module"
    case objectLiteral = "Object literal"
}

// MARK: - PurpleSignature
struct PurpleSignature: Codable {
    let comment: PurpleComment?
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: SignatureKindString
    let name: String
    let parameters: [GetSignature]
    let type: TentacledType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case type = "type"
    }
}

// MARK: PurpleSignature convenience initializers and mutators

extension PurpleSignature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleSignature.self, from: data)
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
        comment: PurpleComment?? = nil,
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: SignatureKindString? = nil,
        name: String? = nil,
        parameters: [GetSignature]? = nil,
        type: TentacledType? = nil
    ) -> PurpleSignature {
        return PurpleSignature(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
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

// MARK: - GetSignatureFlags
struct GetSignatureFlags: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: GetSignatureFlags convenience initializers and mutators

extension GetSignatureFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetSignatureFlags.self, from: data)
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
    ) -> GetSignatureFlags {
        return GetSignatureFlags(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum SignatureKindString: String, Codable {
    case callSignature = "Call signature"
    case constructorSignature = "Constructor signature"
}

// MARK: - GetSignatureType
struct GetSignatureType: Codable {
    let declaration: GetSignature?
    let elementType: ElementType?
    let name: Name?
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case elementType = "elementType"
        case name = "name"
        case type = "type"
    }
}

// MARK: GetSignatureType convenience initializers and mutators

extension GetSignatureType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetSignatureType.self, from: data)
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
        declaration: GetSignature?? = nil,
        elementType: ElementType?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil
    ) -> GetSignatureType {
        return GetSignatureType(
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            name: name ?? self.name,
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

// MARK: - IndexSignatureElement
struct IndexSignatureElement: Codable {
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let parameters: [GetSignature]?
    let type: PurpleType

    enum CodingKeys: String, CodingKey {
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case type = "type"
    }
}

// MARK: IndexSignatureElement convenience initializers and mutators

extension IndexSignatureElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndexSignatureElement.self, from: data)
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
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        parameters: [GetSignature]?? = nil,
        type: PurpleType? = nil
    ) -> IndexSignatureElement {
        return IndexSignatureElement(
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
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

// MARK: - PurpleType
struct PurpleType: Codable {
    let declaration: GetSignature?
    let name: Name?
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case name = "name"
        case type = "type"
    }
}

// MARK: PurpleType convenience initializers and mutators

extension PurpleType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleType.self, from: data)
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
        declaration: GetSignature?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil
    ) -> PurpleType {
        return PurpleType(
            declaration: declaration ?? self.declaration,
            name: name ?? self.name,
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

// MARK: - GetSignatureChild
struct GetSignatureChild: Codable {
    let comment: FluffyComment?
    let flags: FluffyFlags
    let id: Int
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let sources: [Source]
    let type: PurpleType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: GetSignatureChild convenience initializers and mutators

extension GetSignatureChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetSignatureChild.self, from: data)
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
        comment: FluffyComment?? = nil,
        flags: FluffyFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        sources: [Source]? = nil,
        type: PurpleType? = nil
    ) -> GetSignatureChild {
        return GetSignatureChild(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            sources: sources ?? self.sources,
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

// MARK: - GetSignature
class GetSignature: Codable {
    let children: [GetSignatureChild]?
    let comment: GetSignatureComment?
    let defaultValue: String?
    let flags: GetSignatureFlags
    let groups: [Group]?
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let parameters: [GetSignatureParameter]?
    let signatures: [IndexSignatureElement]?
    let sources: [Source]?
    let type: GetSignatureType?
    let typeParameter: [GetSignature]?

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case comment = "comment"
        case defaultValue = "defaultValue"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case signatures = "signatures"
        case sources = "sources"
        case type = "type"
        case typeParameter = "typeParameter"
    }

    init(children: [GetSignatureChild]?, comment: GetSignatureComment?, defaultValue: String?, flags: GetSignatureFlags, groups: [Group]?, id: Int, kind: Int, kindString: String, name: String, parameters: [GetSignatureParameter]?, signatures: [IndexSignatureElement]?, sources: [Source]?, type: GetSignatureType?, typeParameter: [GetSignature]?) {
        self.children = children
        self.comment = comment
        self.defaultValue = defaultValue
        self.flags = flags
        self.groups = groups
        self.id = id
        self.kind = kind
        self.kindString = kindString
        self.name = name
        self.parameters = parameters
        self.signatures = signatures
        self.sources = sources
        self.type = type
        self.typeParameter = typeParameter
    }
}

// MARK: GetSignature convenience initializers and mutators

extension GetSignature {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(GetSignature.self, from: data)
        self.init(children: me.children, comment: me.comment, defaultValue: me.defaultValue, flags: me.flags, groups: me.groups, id: me.id, kind: me.kind, kindString: me.kindString, name: me.name, parameters: me.parameters, signatures: me.signatures, sources: me.sources, type: me.type, typeParameter: me.typeParameter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        children: [GetSignatureChild]?? = nil,
        comment: GetSignatureComment?? = nil,
        defaultValue: String?? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        parameters: [GetSignatureParameter]?? = nil,
        signatures: [IndexSignatureElement]?? = nil,
        sources: [Source]?? = nil,
        type: GetSignatureType?? = nil,
        typeParameter: [GetSignature]?? = nil
    ) -> GetSignature {
        return GetSignature(
            children: children ?? self.children,
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources,
            type: type ?? self.type,
            typeParameter: typeParameter ?? self.typeParameter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ElementType
struct ElementType: Codable {
    let name: Name
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
    }
}

// MARK: ElementType convenience initializers and mutators

extension ElementType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ElementType.self, from: data)
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
        name: Name? = nil,
        type: TypeEnum? = nil
    ) -> ElementType {
        return ElementType(
            name: name ?? self.name,
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

enum Name: String, Codable {
    case string = "string"
    case number = "number"
    case void = "void"
    case t = "T"
    case boolean = "boolean"
    case baseClass = "BaseClass"
    case any = "any"
    case array = "Array"
    case myNumber = "MyNumber"
}

enum TypeEnum: String, Codable {
    case intrinsic = "intrinsic"
    case reflection = "reflection"
    case array = "array"
    case reference = "reference"
    case typeParameter = "typeParameter"
    case tuple = "tuple"
    case union = "union"
    case stringLiteral = "stringLiteral"
}

// MARK: - FluffyComment
struct FluffyComment: Codable {
    let text: String

    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}

// MARK: FluffyComment convenience initializers and mutators

extension FluffyComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyComment.self, from: data)
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
        text: String? = nil
    ) -> FluffyComment {
        return FluffyComment(
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffyFlags
struct FluffyFlags: Codable {
    let isOptional: Bool?

    enum CodingKeys: String, CodingKey {
        case isOptional = "isOptional"
    }
}

// MARK: FluffyFlags convenience initializers and mutators

extension FluffyFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyFlags.self, from: data)
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
        isOptional: Bool?? = nil
    ) -> FluffyFlags {
        return FluffyFlags(
            isOptional: isOptional ?? self.isOptional
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Source
struct Source: Codable {
    let character: Int
    let fileName: FileName
    let line: Int

    enum CodingKeys: String, CodingKey {
        case character = "character"
        case fileName = "fileName"
        case line = "line"
    }
}

// MARK: Source convenience initializers and mutators

extension Source {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Source.self, from: data)
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
        character: Int? = nil,
        fileName: FileName? = nil,
        line: Int? = nil
    ) -> Source {
        return Source(
            character: character ?? self.character,
            fileName: fileName ?? self.fileName,
            line: line ?? self.line
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FileName: String, Codable {
    case modulesTs = "modules.ts"
    case classesTs = "classes.ts"
    case flattenedTs = "flattened.ts"
    case accessTs = "access.ts"
    case defaultExportTs = "default-export.ts"
    case enumerationsTs = "enumerations.ts"
    case functionsTs = "functions.ts"
    case genericsTs = "generics.ts"
    case singleExportTs = "single-export.ts"
    case typescript13Ts = "typescript-1.3.ts"
    case typescript14Ts = "typescript-1.4.ts"
    case typescript15Ts = "typescript-1.5.ts"
    case variablesTs = "variables.ts"
}

// MARK: - GetSignatureComment
struct GetSignatureComment: Codable {
    let returns: String?
    let shortText: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case returns = "returns"
        case shortText = "shortText"
        case text = "text"
    }
}

// MARK: GetSignatureComment convenience initializers and mutators

extension GetSignatureComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetSignatureComment.self, from: data)
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
        returns: String?? = nil,
        shortText: String?? = nil,
        text: String?? = nil
    ) -> GetSignatureComment {
        return GetSignatureComment(
            returns: returns ?? self.returns,
            shortText: shortText ?? self.shortText,
            text: text ?? self.text
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
    let children: [Int]
    let kind: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case kind = "kind"
        case title = "title"
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
        children: [Int]? = nil,
        kind: Int? = nil,
        title: String? = nil
    ) -> Group {
        return Group(
            children: children ?? self.children,
            kind: kind ?? self.kind,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - GetSignatureParameter
struct GetSignatureParameter: Codable {
    let comment: TentacledComment?
    let flags: TentacledFlags
    let id: Int
    let kind: Int
    let kindString: ParameterKindString
    let name: String
    let type: FluffyType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case type = "type"
    }
}

// MARK: GetSignatureParameter convenience initializers and mutators

extension GetSignatureParameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetSignatureParameter.self, from: data)
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
        comment: TentacledComment?? = nil,
        flags: TentacledFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: ParameterKindString? = nil,
        name: String? = nil,
        type: FluffyType? = nil
    ) -> GetSignatureParameter {
        return GetSignatureParameter(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
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

// MARK: - TentacledComment
struct TentacledComment: Codable {
    let shortText: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case shortText = "shortText"
        case text = "text"
    }
}

// MARK: TentacledComment convenience initializers and mutators

extension TentacledComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledComment.self, from: data)
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
        shortText: String?? = nil,
        text: String?? = nil
    ) -> TentacledComment {
        return TentacledComment(
            shortText: shortText ?? self.shortText,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TentacledFlags
struct TentacledFlags: Codable {
    let isOptional: Bool?
    let isREST: Bool?

    enum CodingKeys: String, CodingKey {
        case isOptional = "isOptional"
        case isREST = "isRest"
    }
}

// MARK: TentacledFlags convenience initializers and mutators

extension TentacledFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledFlags.self, from: data)
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
        isOptional: Bool?? = nil,
        isREST: Bool?? = nil
    ) -> TentacledFlags {
        return TentacledFlags(
            isOptional: isOptional ?? self.isOptional,
            isREST: isREST ?? self.isREST
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ParameterKindString: String, Codable {
    case parameter = "Parameter"
}

// MARK: - FluffyType
struct FluffyType: Codable {
    let elementType: ElementType?
    let name: Name?
    let type: TypeEnum
    let typeArguments: [ElementType]?

    enum CodingKeys: String, CodingKey {
        case elementType = "elementType"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }
}

// MARK: FluffyType convenience initializers and mutators

extension FluffyType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyType.self, from: data)
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
        elementType: ElementType?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ElementType]?? = nil
    ) -> FluffyType {
        return FluffyType(
            elementType: elementType ?? self.elementType,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TentacledType
struct TentacledType: Codable {
    let declaration: PurpleDeclaration?
    let name: Name?
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case name = "name"
        case type = "type"
    }
}

// MARK: TentacledType convenience initializers and mutators

extension TentacledType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledType.self, from: data)
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
        declaration: PurpleDeclaration?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil
    ) -> TentacledType {
        return TentacledType(
            declaration: declaration ?? self.declaration,
            name: name ?? self.name,
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

// MARK: - PurpleDeclaration
struct PurpleDeclaration: Codable {
    let children: [GetSignature]
    let flags: GetSignatureFlags
    let groups: [Group]
    let id: Int
    let kind: Int
    let kindString: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
    }
}

// MARK: PurpleDeclaration convenience initializers and mutators

extension PurpleDeclaration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleDeclaration.self, from: data)
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
        children: [GetSignature]? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil
    ) -> PurpleDeclaration {
        return PurpleDeclaration(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
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

// MARK: - TypeElement
struct TypeElement: Codable {
    let declaration: GetSignature?
    let elementType: ElementType?
    let name: Name?
    let type: TypeEnum
    let typeArguments: [ElementType]?

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case elementType = "elementType"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }
}

// MARK: TypeElement convenience initializers and mutators

extension TypeElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TypeElement.self, from: data)
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
        declaration: GetSignature?? = nil,
        elementType: ElementType?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ElementType]?? = nil
    ) -> TypeElement {
        return TypeElement(
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StickyComment
struct StickyComment: Codable {
    let returns: String?
    let shortText: String?
    let tags: [Tag]?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case returns = "returns"
        case shortText = "shortText"
        case tags = "tags"
        case text = "text"
    }
}

// MARK: StickyComment convenience initializers and mutators

extension StickyComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickyComment.self, from: data)
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
        returns: String?? = nil,
        shortText: String?? = nil,
        tags: [Tag]?? = nil,
        text: String?? = nil
    ) -> StickyComment {
        return StickyComment(
            returns: returns ?? self.returns,
            shortText: shortText ?? self.shortText,
            tags: tags ?? self.tags,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Tag
struct Tag: Codable {
    let tag: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case tag = "tag"
        case text = "text"
    }
}

// MARK: Tag convenience initializers and mutators

extension Tag {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Tag.self, from: data)
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
        tag: String? = nil,
        text: String? = nil
    ) -> Tag {
        return Tag(
            tag: tag ?? self.tag,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StickyFlags
struct StickyFlags: Codable {
    let isAbstract: Bool?
    let isConstructorProperty: Bool?
    let isExported: Bool?
    let isPrivate: Bool?
    let isProtected: Bool?
    let isPublic: Bool?
    let isStatic: Bool?

    enum CodingKeys: String, CodingKey {
        case isAbstract = "isAbstract"
        case isConstructorProperty = "isConstructorProperty"
        case isExported = "isExported"
        case isPrivate = "isPrivate"
        case isProtected = "isProtected"
        case isPublic = "isPublic"
        case isStatic = "isStatic"
    }
}

// MARK: StickyFlags convenience initializers and mutators

extension StickyFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickyFlags.self, from: data)
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
        isAbstract: Bool?? = nil,
        isConstructorProperty: Bool?? = nil,
        isExported: Bool?? = nil,
        isPrivate: Bool?? = nil,
        isProtected: Bool?? = nil,
        isPublic: Bool?? = nil,
        isStatic: Bool?? = nil
    ) -> StickyFlags {
        return StickyFlags(
            isAbstract: isAbstract ?? self.isAbstract,
            isConstructorProperty: isConstructorProperty ?? self.isConstructorProperty,
            isExported: isExported ?? self.isExported,
            isPrivate: isPrivate ?? self.isPrivate,
            isProtected: isProtected ?? self.isProtected,
            isPublic: isPublic ?? self.isPublic,
            isStatic: isStatic ?? self.isStatic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ExtendedBy
class ExtendedBy: Codable {
    let constraint: ExtendedBy?
    let id: Int?
    let name: String
    let type: TypeEnum
    let typeArguments: [ExtendedBy]?

    enum CodingKeys: String, CodingKey {
        case constraint = "constraint"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }

    init(constraint: ExtendedBy?, id: Int?, name: String, type: TypeEnum, typeArguments: [ExtendedBy]?) {
        self.constraint = constraint
        self.id = id
        self.name = name
        self.type = type
        self.typeArguments = typeArguments
    }
}

// MARK: ExtendedBy convenience initializers and mutators

extension ExtendedBy {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ExtendedBy.self, from: data)
        self.init(constraint: me.constraint, id: me.id, name: me.name, type: me.type, typeArguments: me.typeArguments)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        constraint: ExtendedBy?? = nil,
        id: Int?? = nil,
        name: String? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ExtendedBy]?? = nil
    ) -> ExtendedBy {
        return ExtendedBy(
            constraint: constraint ?? self.constraint,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffySignature
struct FluffySignature: Codable {
    let comment: StickyComment?
    let flags: IndigoFlags
    let id: Int
    let implementationOf: ExtendedBy?
    let inheritedFrom: ExtendedBy?
    let kind: Int
    let kindString: SignatureKindString
    let name: String
    let overwrites: ExtendedBy?
    let parameters: [PurpleParameter]?
    let type: ExtendedBy
    let typeParameter: [GetSignature]?

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case implementationOf = "implementationOf"
        case inheritedFrom = "inheritedFrom"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case overwrites = "overwrites"
        case parameters = "parameters"
        case type = "type"
        case typeParameter = "typeParameter"
    }
}

// MARK: FluffySignature convenience initializers and mutators

extension FluffySignature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffySignature.self, from: data)
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
        comment: StickyComment?? = nil,
        flags: IndigoFlags? = nil,
        id: Int? = nil,
        implementationOf: ExtendedBy?? = nil,
        inheritedFrom: ExtendedBy?? = nil,
        kind: Int? = nil,
        kindString: SignatureKindString? = nil,
        name: String? = nil,
        overwrites: ExtendedBy?? = nil,
        parameters: [PurpleParameter]?? = nil,
        type: ExtendedBy? = nil,
        typeParameter: [GetSignature]?? = nil
    ) -> FluffySignature {
        return FluffySignature(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            implementationOf: implementationOf ?? self.implementationOf,
            inheritedFrom: inheritedFrom ?? self.inheritedFrom,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            overwrites: overwrites ?? self.overwrites,
            parameters: parameters ?? self.parameters,
            type: type ?? self.type,
            typeParameter: typeParameter ?? self.typeParameter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndigoFlags
struct IndigoFlags: Codable {
    let isPrivate: Bool?
    let isProtected: Bool?

    enum CodingKeys: String, CodingKey {
        case isPrivate = "isPrivate"
        case isProtected = "isProtected"
    }
}

// MARK: IndigoFlags convenience initializers and mutators

extension IndigoFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndigoFlags.self, from: data)
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
        isPrivate: Bool?? = nil,
        isProtected: Bool?? = nil
    ) -> IndigoFlags {
        return IndigoFlags(
            isPrivate: isPrivate ?? self.isPrivate,
            isProtected: isProtected ?? self.isProtected
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PurpleParameter
struct PurpleParameter: Codable {
    let comment: TentacledComment?
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: ParameterKindString
    let name: String
    let type: StickyType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case type = "type"
    }
}

// MARK: PurpleParameter convenience initializers and mutators

extension PurpleParameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleParameter.self, from: data)
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
        comment: TentacledComment?? = nil,
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: ParameterKindString? = nil,
        name: String? = nil,
        type: StickyType? = nil
    ) -> PurpleParameter {
        return PurpleParameter(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
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

// MARK: - StickyType
struct StickyType: Codable {
    let constraint: ExtendedBy?
    let declaration: GetSignature?
    let elementType: ElementType?
    let elements: [ExtendedBy]?
    let id: Int?
    let name: String?
    let type: TypeEnum
    let typeArguments: [ElementType]?

    enum CodingKeys: String, CodingKey {
        case constraint = "constraint"
        case declaration = "declaration"
        case elementType = "elementType"
        case elements = "elements"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }
}

// MARK: StickyType convenience initializers and mutators

extension StickyType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickyType.self, from: data)
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
        constraint: ExtendedBy?? = nil,
        declaration: GetSignature?? = nil,
        elementType: ElementType?? = nil,
        elements: [ExtendedBy]?? = nil,
        id: Int?? = nil,
        name: String?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ElementType]?? = nil
    ) -> StickyType {
        return StickyType(
            constraint: constraint ?? self.constraint,
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            elements: elements ?? self.elements,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndigoType
struct IndigoType: Codable {
    let constraint: ExtendedBy?
    let declaration: FluffyDeclaration?
    let elementType: ExtendedBy?
    let elements: [ElementType]?
    let id: Int?
    let name: String?
    let type: TypeEnum
    let typeArguments: [PurpleTypeArgument]?
    let types: [TypeElement]?

    enum CodingKeys: String, CodingKey {
        case constraint = "constraint"
        case declaration = "declaration"
        case elementType = "elementType"
        case elements = "elements"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
        case types = "types"
    }
}

// MARK: IndigoType convenience initializers and mutators

extension IndigoType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndigoType.self, from: data)
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
        constraint: ExtendedBy?? = nil,
        declaration: FluffyDeclaration?? = nil,
        elementType: ExtendedBy?? = nil,
        elements: [ElementType]?? = nil,
        id: Int?? = nil,
        name: String?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [PurpleTypeArgument]?? = nil,
        types: [TypeElement]?? = nil
    ) -> IndigoType {
        return IndigoType(
            constraint: constraint ?? self.constraint,
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            elements: elements ?? self.elements,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments,
            types: types ?? self.types
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffyDeclaration
struct FluffyDeclaration: Codable {
    let children: [StickyChild]?
    let flags: GetSignatureFlags
    let groups: [Group]?
    let id: Int
    let indexSignature: IndexSignature?
    let kind: Int
    let kindString: String
    let name: String
    let signatures: [TentacledSignature]?
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case indexSignature = "indexSignature"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
    }
}

// MARK: FluffyDeclaration convenience initializers and mutators

extension FluffyDeclaration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyDeclaration.self, from: data)
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
        children: [StickyChild]?? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        indexSignature: IndexSignature?? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        signatures: [TentacledSignature]?? = nil,
        sources: [Source]? = nil
    ) -> FluffyDeclaration {
        return FluffyDeclaration(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            indexSignature: indexSignature ?? self.indexSignature,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StickyChild
struct StickyChild: Codable {
    let comment: FluffyComment?
    let flags: FluffyFlags
    let id: Int
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let sources: [Source]
    let type: IndecentType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: StickyChild convenience initializers and mutators

extension StickyChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickyChild.self, from: data)
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
        comment: FluffyComment?? = nil,
        flags: FluffyFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        sources: [Source]? = nil,
        type: IndecentType? = nil
    ) -> StickyChild {
        return StickyChild(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            sources: sources ?? self.sources,
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

// MARK: - IndecentType
struct IndecentType: Codable {
    let declaration: GetSignature?
    let elements: [ElementType]?
    let name: Name?
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case elements = "elements"
        case name = "name"
        case type = "type"
    }
}

// MARK: IndecentType convenience initializers and mutators

extension IndecentType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndecentType.self, from: data)
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
        declaration: GetSignature?? = nil,
        elements: [ElementType]?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil
    ) -> IndecentType {
        return IndecentType(
            declaration: declaration ?? self.declaration,
            elements: elements ?? self.elements,
            name: name ?? self.name,
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

// MARK: - IndexSignature
struct IndexSignature: Codable {
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let parameters: [GetSignature]
    let type: HilariousType

    enum CodingKeys: String, CodingKey {
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case type = "type"
    }
}

// MARK: IndexSignature convenience initializers and mutators

extension IndexSignature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndexSignature.self, from: data)
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
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        parameters: [GetSignature]? = nil,
        type: HilariousType? = nil
    ) -> IndexSignature {
        return IndexSignature(
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
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

// MARK: - HilariousType
struct HilariousType: Codable {
    let declaration: GetSignature
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case type = "type"
    }
}

// MARK: HilariousType convenience initializers and mutators

extension HilariousType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HilariousType.self, from: data)
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
        declaration: GetSignature? = nil,
        type: TypeEnum? = nil
    ) -> HilariousType {
        return HilariousType(
            declaration: declaration ?? self.declaration,
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

// MARK: - TentacledSignature
struct TentacledSignature: Codable {
    let comment: IndigoComment?
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: SignatureKindString
    let name: String
    let parameters: [FluffyParameter]?
    let type: ExtendedBy

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case type = "type"
    }
}

// MARK: TentacledSignature convenience initializers and mutators

extension TentacledSignature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledSignature.self, from: data)
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
        comment: IndigoComment?? = nil,
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: SignatureKindString? = nil,
        name: String? = nil,
        parameters: [FluffyParameter]?? = nil,
        type: ExtendedBy? = nil
    ) -> TentacledSignature {
        return TentacledSignature(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
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

// MARK: - IndigoComment
struct IndigoComment: Codable {
    let returns: String
    let shortText: String

    enum CodingKeys: String, CodingKey {
        case returns = "returns"
        case shortText = "shortText"
    }
}

// MARK: IndigoComment convenience initializers and mutators

extension IndigoComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndigoComment.self, from: data)
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
        returns: String? = nil,
        shortText: String? = nil
    ) -> IndigoComment {
        return IndigoComment(
            returns: returns ?? self.returns,
            shortText: shortText ?? self.shortText
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffyParameter
struct FluffyParameter: Codable {
    let comment: FluffyComment?
    let flags: FluffyFlags
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let sources: [Source]?
    let type: ElementType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: FluffyParameter convenience initializers and mutators

extension FluffyParameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyParameter.self, from: data)
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
        comment: FluffyComment?? = nil,
        flags: FluffyFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        sources: [Source]?? = nil,
        type: ElementType? = nil
    ) -> FluffyParameter {
        return FluffyParameter(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            sources: sources ?? self.sources,
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

// MARK: - PurpleTypeArgument
struct PurpleTypeArgument: Codable {
    let target: ElementType
    let type: String
    let typeArgumentOperator: String

    enum CodingKeys: String, CodingKey {
        case target = "target"
        case type = "type"
        case typeArgumentOperator = "operator"
    }
}

// MARK: PurpleTypeArgument convenience initializers and mutators

extension PurpleTypeArgument {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleTypeArgument.self, from: data)
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
        target: ElementType? = nil,
        type: String? = nil,
        typeArgumentOperator: String? = nil
    ) -> PurpleTypeArgument {
        return PurpleTypeArgument(
            target: target ?? self.target,
            type: type ?? self.type,
            typeArgumentOperator: typeArgumentOperator ?? self.typeArgumentOperator
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndecentFlags
struct IndecentFlags: Codable {
    let hasExportAssignment: Bool?
    let isAbstract: Bool?
    let isConst: Bool?
    let isExported: Bool?
    let isLet: Bool?
    let isPrivate: Bool?
    let isProtected: Bool?

    enum CodingKeys: String, CodingKey {
        case hasExportAssignment = "hasExportAssignment"
        case isAbstract = "isAbstract"
        case isConst = "isConst"
        case isExported = "isExported"
        case isLet = "isLet"
        case isPrivate = "isPrivate"
        case isProtected = "isProtected"
    }
}

// MARK: IndecentFlags convenience initializers and mutators

extension IndecentFlags {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndecentFlags.self, from: data)
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
        hasExportAssignment: Bool?? = nil,
        isAbstract: Bool?? = nil,
        isConst: Bool?? = nil,
        isExported: Bool?? = nil,
        isLet: Bool?? = nil,
        isPrivate: Bool?? = nil,
        isProtected: Bool?? = nil
    ) -> IndecentFlags {
        return IndecentFlags(
            hasExportAssignment: hasExportAssignment ?? self.hasExportAssignment,
            isAbstract: isAbstract ?? self.isAbstract,
            isConst: isConst ?? self.isConst,
            isExported: isExported ?? self.isExported,
            isLet: isLet ?? self.isLet,
            isPrivate: isPrivate ?? self.isPrivate,
            isProtected: isProtected ?? self.isProtected
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FluffyKindString: String, Codable {
    case module = "Module"
    case kindStringClass = "Class"
    case variable = "Variable"
    case function = "Function"
    case interface = "Interface"
    case enumeration = "Enumeration"
    case objectLiteral = "Object literal"
    case typeAlias = "Type alias"
}

// MARK: - StickySignature
struct StickySignature: Codable {
    let comment: StickyComment
    let flags: IndigoFlags
    let id: Int
    let kind: Int
    let kindString: SignatureKindString
    let name: String
    let parameters: [TentacledParameter]?
    let type: CunningType
    let typeParameter: [GetSignature]?

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case parameters = "parameters"
        case type = "type"
        case typeParameter = "typeParameter"
    }
}

// MARK: StickySignature convenience initializers and mutators

extension StickySignature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickySignature.self, from: data)
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
        comment: StickyComment? = nil,
        flags: IndigoFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: SignatureKindString? = nil,
        name: String? = nil,
        parameters: [TentacledParameter]?? = nil,
        type: CunningType? = nil,
        typeParameter: [GetSignature]?? = nil
    ) -> StickySignature {
        return StickySignature(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            parameters: parameters ?? self.parameters,
            type: type ?? self.type,
            typeParameter: typeParameter ?? self.typeParameter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TentacledParameter
struct TentacledParameter: Codable {
    let comment: TentacledComment?
    let defaultValue: String?
    let flags: TentacledFlags
    let id: Int
    let kind: Int
    let kindString: ParameterKindString
    let name: String
    let originalName: String?
    let type: AmbitiousType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case defaultValue = "defaultValue"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case originalName = "originalName"
        case type = "type"
    }
}

// MARK: TentacledParameter convenience initializers and mutators

extension TentacledParameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledParameter.self, from: data)
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
        comment: TentacledComment?? = nil,
        defaultValue: String?? = nil,
        flags: TentacledFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: ParameterKindString? = nil,
        name: String? = nil,
        originalName: String?? = nil,
        type: AmbitiousType? = nil
    ) -> TentacledParameter {
        return TentacledParameter(
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            originalName: originalName ?? self.originalName,
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

// MARK: - AmbitiousType
struct AmbitiousType: Codable {
    let declaration: TentacledDeclaration?
    let elementType: ElementType?
    let id: Int?
    let name: String?
    let type: TypeEnum
    let typeArguments: [ElementType]?

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case elementType = "elementType"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }
}

// MARK: AmbitiousType convenience initializers and mutators

extension AmbitiousType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AmbitiousType.self, from: data)
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
        declaration: TentacledDeclaration?? = nil,
        elementType: ElementType?? = nil,
        id: Int?? = nil,
        name: String?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ElementType]?? = nil
    ) -> AmbitiousType {
        return AmbitiousType(
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TentacledDeclaration
struct TentacledDeclaration: Codable {
    let children: [IndigoChild]?
    let flags: GetSignatureFlags
    let groups: [Group]?
    let id: Int
    let indexSignature: IndexSignatureElement?
    let kind: Int
    let kindString: String
    let name: String
    let signatures: [GetSignature]?
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case indexSignature = "indexSignature"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
    }
}

// MARK: TentacledDeclaration convenience initializers and mutators

extension TentacledDeclaration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TentacledDeclaration.self, from: data)
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
        children: [IndigoChild]?? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        indexSignature: IndexSignatureElement?? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        signatures: [GetSignature]?? = nil,
        sources: [Source]? = nil
    ) -> TentacledDeclaration {
        return TentacledDeclaration(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            indexSignature: indexSignature ?? self.indexSignature,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndigoChild
struct IndigoChild: Codable {
    let comment: FluffyComment
    let defaultValue: String?
    let flags: FluffyFlags
    let id: Int
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let sources: [Source]
    let type: IndecentType

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case defaultValue = "defaultValue"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: IndigoChild convenience initializers and mutators

extension IndigoChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndigoChild.self, from: data)
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
        comment: FluffyComment? = nil,
        defaultValue: String?? = nil,
        flags: FluffyFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        sources: [Source]? = nil,
        type: IndecentType? = nil
    ) -> IndigoChild {
        return IndigoChild(
            comment: comment ?? self.comment,
            defaultValue: defaultValue ?? self.defaultValue,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            sources: sources ?? self.sources,
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

// MARK: - CunningType
struct CunningType: Codable {
    let declaration: PurpleDeclaration?
    let id: Int?
    let name: Name?
    let type: TypeEnum
    let typeArguments: [ElementType]?

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
    }
}

// MARK: CunningType convenience initializers and mutators

extension CunningType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CunningType.self, from: data)
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
        declaration: PurpleDeclaration?? = nil,
        id: Int?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [ElementType]?? = nil
    ) -> CunningType {
        return CunningType(
            declaration: declaration ?? self.declaration,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MagentaType
struct MagentaType: Codable {
    let declaration: StickyDeclaration?
    let elementType: ElementType?
    let elements: [ExtendedBy]?
    let id: Int?
    let name: String?
    let type: TypeEnum
    let typeArguments: [FluffyTypeArgument]?
    let types: [ExtendedBy]?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case elementType = "elementType"
        case elements = "elements"
        case id = "id"
        case name = "name"
        case type = "type"
        case typeArguments = "typeArguments"
        case types = "types"
        case value = "value"
    }
}

// MARK: MagentaType convenience initializers and mutators

extension MagentaType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MagentaType.self, from: data)
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
        declaration: StickyDeclaration?? = nil,
        elementType: ElementType?? = nil,
        elements: [ExtendedBy]?? = nil,
        id: Int?? = nil,
        name: String?? = nil,
        type: TypeEnum? = nil,
        typeArguments: [FluffyTypeArgument]?? = nil,
        types: [ExtendedBy]?? = nil,
        value: String?? = nil
    ) -> MagentaType {
        return MagentaType(
            declaration: declaration ?? self.declaration,
            elementType: elementType ?? self.elementType,
            elements: elements ?? self.elements,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            typeArguments: typeArguments ?? self.typeArguments,
            types: types ?? self.types,
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

// MARK: - StickyDeclaration
struct StickyDeclaration: Codable {
    let children: [IndecentChild]?
    let flags: GetSignatureFlags
    let groups: [Group]?
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let signatures: [GetSignature]
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
    }
}

// MARK: StickyDeclaration convenience initializers and mutators

extension StickyDeclaration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StickyDeclaration.self, from: data)
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
        children: [IndecentChild]?? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        signatures: [GetSignature]? = nil,
        sources: [Source]? = nil
    ) -> StickyDeclaration {
        return StickyDeclaration(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndecentChild
struct IndecentChild: Codable {
    let flags: FluffyFlags
    let id: Int
    let kind: Int
    let kindString: PurpleKindString
    let name: String
    let sources: [Source]
    let type: FriskyType

    enum CodingKeys: String, CodingKey {
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case sources = "sources"
        case type = "type"
    }
}

// MARK: IndecentChild convenience initializers and mutators

extension IndecentChild {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndecentChild.self, from: data)
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
        flags: FluffyFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: PurpleKindString? = nil,
        name: String? = nil,
        sources: [Source]? = nil,
        type: FriskyType? = nil
    ) -> IndecentChild {
        return IndecentChild(
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            sources: sources ?? self.sources,
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

// MARK: - FriskyType
struct FriskyType: Codable {
    let declaration: IndigoDeclaration?
    let name: Name?
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case declaration = "declaration"
        case name = "name"
        case type = "type"
    }
}

// MARK: FriskyType convenience initializers and mutators

extension FriskyType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FriskyType.self, from: data)
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
        declaration: IndigoDeclaration?? = nil,
        name: Name?? = nil,
        type: TypeEnum? = nil
    ) -> FriskyType {
        return FriskyType(
            declaration: declaration ?? self.declaration,
            name: name ?? self.name,
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

// MARK: - IndigoDeclaration
struct IndigoDeclaration: Codable {
    let children: [GetSignature]?
    let flags: GetSignatureFlags
    let groups: [Group]?
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let signatures: [GetSignature]?
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case flags = "flags"
        case groups = "groups"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case signatures = "signatures"
        case sources = "sources"
    }
}

// MARK: IndigoDeclaration convenience initializers and mutators

extension IndigoDeclaration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndigoDeclaration.self, from: data)
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
        children: [GetSignature]?? = nil,
        flags: GetSignatureFlags? = nil,
        groups: [Group]?? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        signatures: [GetSignature]?? = nil,
        sources: [Source]? = nil
    ) -> IndigoDeclaration {
        return IndigoDeclaration(
            children: children ?? self.children,
            flags: flags ?? self.flags,
            groups: groups ?? self.groups,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
            signatures: signatures ?? self.signatures,
            sources: sources ?? self.sources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FluffyTypeArgument
struct FluffyTypeArgument: Codable {
    let type: TypeEnum
    let types: [ElementType]

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case types = "types"
    }
}

// MARK: FluffyTypeArgument convenience initializers and mutators

extension FluffyTypeArgument {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyTypeArgument.self, from: data)
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
        type: TypeEnum? = nil,
        types: [ElementType]? = nil
    ) -> FluffyTypeArgument {
        return FluffyTypeArgument(
            type: type ?? self.type,
            types: types ?? self.types
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TypeParameter
struct TypeParameter: Codable {
    let comment: PurpleComment?
    let flags: GetSignatureFlags
    let id: Int
    let kind: Int
    let kindString: String
    let name: String
    let type: MischievousType?

    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case flags = "flags"
        case id = "id"
        case kind = "kind"
        case kindString = "kindString"
        case name = "name"
        case type = "type"
    }
}

// MARK: TypeParameter convenience initializers and mutators

extension TypeParameter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TypeParameter.self, from: data)
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
        comment: PurpleComment?? = nil,
        flags: GetSignatureFlags? = nil,
        id: Int? = nil,
        kind: Int? = nil,
        kindString: String? = nil,
        name: String? = nil,
        type: MischievousType?? = nil
    ) -> TypeParameter {
        return TypeParameter(
            comment: comment ?? self.comment,
            flags: flags ?? self.flags,
            id: id ?? self.id,
            kind: kind ?? self.kind,
            kindString: kindString ?? self.kindString,
            name: name ?? self.name,
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

// MARK: - MischievousType
struct MischievousType: Codable {
    let id: Int?
    let name: Name?
    let target: ElementType?
    let type: String
    let typeOperator: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case target = "target"
        case type = "type"
        case typeOperator = "operator"
    }
}

// MARK: MischievousType convenience initializers and mutators

extension MischievousType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MischievousType.self, from: data)
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
        id: Int?? = nil,
        name: Name?? = nil,
        target: ElementType?? = nil,
        type: String? = nil,
        typeOperator: String?? = nil
    ) -> MischievousType {
        return MischievousType(
            id: id ?? self.id,
            name: name ?? self.name,
            target: target ?? self.target,
            type: type ?? self.type,
            typeOperator: typeOperator ?? self.typeOperator
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IndecentComment
struct IndecentComment: Codable {
    let shortText: String
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case shortText = "shortText"
        case tags = "tags"
    }
}

// MARK: IndecentComment convenience initializers and mutators

extension IndecentComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IndecentComment.self, from: data)
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
        shortText: String? = nil,
        tags: [Tag]?? = nil
    ) -> IndecentComment {
        return IndecentComment(
            shortText: shortText ?? self.shortText,
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

enum TentacledKindString: String, Codable {
    case externalModule = "External module"
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
