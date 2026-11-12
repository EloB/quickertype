// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let category: Category
    let details: Details
    let match: String
    let page: Int
    let product: [ProductElement]
    let schk: Bool
    let totallooseoffers: Int
    let totalpages: Int
    let totalresultsavailable: Int
    let totalresultsreturned: Int

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case details = "details"
        case match = "match"
        case page = "page"
        case product = "product"
        case schk = "schk"
        case totallooseoffers = "totallooseoffers"
        case totalpages = "totalpages"
        case totalresultsavailable = "totalresultsavailable"
        case totalresultsreturned = "totalresultsreturned"
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
        category: Category? = nil,
        details: Details? = nil,
        match: String? = nil,
        page: Int? = nil,
        product: [ProductElement]? = nil,
        schk: Bool? = nil,
        totallooseoffers: Int? = nil,
        totalpages: Int? = nil,
        totalresultsavailable: Int? = nil,
        totalresultsreturned: Int? = nil
    ) -> TopLevel {
        return TopLevel(
            category: category ?? self.category,
            details: details ?? self.details,
            match: match ?? self.match,
            page: page ?? self.page,
            product: product ?? self.product,
            schk: schk ?? self.schk,
            totallooseoffers: totallooseoffers ?? self.totallooseoffers,
            totalpages: totalpages ?? self.totalpages,
            totalresultsavailable: totalresultsavailable ?? self.totalresultsavailable,
            totalresultsreturned: totalresultsreturned ?? self.totalresultsreturned
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Category
struct Category: Codable {
    let concatenatecategoryname: Bool
    let hasoffer: Bool
    let id: Int
    let isfinal: Bool
    let links: [LinkElement]
    let name: String
    let parentcategoryid: Int
    let thumbnail: CategoryThumbnail

    enum CodingKeys: String, CodingKey {
        case concatenatecategoryname = "concatenatecategoryname"
        case hasoffer = "hasoffer"
        case id = "id"
        case isfinal = "isfinal"
        case links = "links"
        case name = "name"
        case parentcategoryid = "parentcategoryid"
        case thumbnail = "thumbnail"
    }
}

// MARK: Category convenience initializers and mutators

extension Category {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Category.self, from: data)
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
        concatenatecategoryname: Bool? = nil,
        hasoffer: Bool? = nil,
        id: Int? = nil,
        isfinal: Bool? = nil,
        links: [LinkElement]? = nil,
        name: String? = nil,
        parentcategoryid: Int? = nil,
        thumbnail: CategoryThumbnail? = nil
    ) -> Category {
        return Category(
            concatenatecategoryname: concatenatecategoryname ?? self.concatenatecategoryname,
            hasoffer: hasoffer ?? self.hasoffer,
            id: id ?? self.id,
            isfinal: isfinal ?? self.isfinal,
            links: links ?? self.links,
            name: name ?? self.name,
            parentcategoryid: parentcategoryid ?? self.parentcategoryid,
            thumbnail: thumbnail ?? self.thumbnail
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LinkElement
struct LinkElement: Codable {
    let link: LinkLink

    enum CodingKeys: String, CodingKey {
        case link = "link"
    }
}

// MARK: LinkElement convenience initializers and mutators

extension LinkElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LinkElement.self, from: data)
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
        link: LinkLink? = nil
    ) -> LinkElement {
        return LinkElement(
            link: link ?? self.link
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LinkLink
struct LinkLink: Codable {
    let type: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}

// MARK: LinkLink convenience initializers and mutators

extension LinkLink {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LinkLink.self, from: data)
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
        type: String? = nil,
        url: String? = nil
    ) -> LinkLink {
        return LinkLink(
            type: type ?? self.type,
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

// MARK: - CategoryThumbnail
struct CategoryThumbnail: Codable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

// MARK: CategoryThumbnail convenience initializers and mutators

extension CategoryThumbnail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CategoryThumbnail.self, from: data)
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
        url: String? = nil
    ) -> CategoryThumbnail {
        return CategoryThumbnail(
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

// MARK: - Details
struct Details: Codable {
    let applicationid: String
    let applicationversion: String
    let code: Int
    let date: DateClass
    let elapsedtime: Int
    let message: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case applicationid = "applicationid"
        case applicationversion = "applicationversion"
        case code = "code"
        case date = "date"
        case elapsedtime = "elapsedtime"
        case message = "message"
        case status = "status"
    }
}

// MARK: Details convenience initializers and mutators

extension Details {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Details.self, from: data)
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
        applicationid: String? = nil,
        applicationversion: String? = nil,
        code: Int? = nil,
        date: DateClass? = nil,
        elapsedtime: Int? = nil,
        message: String? = nil,
        status: String? = nil
    ) -> Details {
        return Details(
            applicationid: applicationid ?? self.applicationid,
            applicationversion: applicationversion ?? self.applicationversion,
            code: code ?? self.code,
            date: date ?? self.date,
            elapsedtime: elapsedtime ?? self.elapsedtime,
            message: message ?? self.message,
            status: status ?? self.status
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    let day: Int
    let eonandyear: Eonandyear
    let hour: Int
    let millisecond: Int
    let minute: Int
    let month: Int
    let second: Int
    let timezone: Int
    let valid: Bool
    let xmlschematype: Xmlschematype
    let year: Int

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case eonandyear = "eonandyear"
        case hour = "hour"
        case millisecond = "millisecond"
        case minute = "minute"
        case month = "month"
        case second = "second"
        case timezone = "timezone"
        case valid = "valid"
        case xmlschematype = "xmlschematype"
        case year = "year"
    }
}

// MARK: DateClass convenience initializers and mutators

extension DateClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateClass.self, from: data)
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
        day: Int? = nil,
        eonandyear: Eonandyear? = nil,
        hour: Int? = nil,
        millisecond: Int? = nil,
        minute: Int? = nil,
        month: Int? = nil,
        second: Int? = nil,
        timezone: Int? = nil,
        valid: Bool? = nil,
        xmlschematype: Xmlschematype? = nil,
        year: Int? = nil
    ) -> DateClass {
        return DateClass(
            day: day ?? self.day,
            eonandyear: eonandyear ?? self.eonandyear,
            hour: hour ?? self.hour,
            millisecond: millisecond ?? self.millisecond,
            minute: minute ?? self.minute,
            month: month ?? self.month,
            second: second ?? self.second,
            timezone: timezone ?? self.timezone,
            valid: valid ?? self.valid,
            xmlschematype: xmlschematype ?? self.xmlschematype,
            year: year ?? self.year
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Eonandyear
struct Eonandyear: Codable {
    let lowestsetbit: Int

    enum CodingKeys: String, CodingKey {
        case lowestsetbit = "lowestsetbit"
    }
}

// MARK: Eonandyear convenience initializers and mutators

extension Eonandyear {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Eonandyear.self, from: data)
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
        lowestsetbit: Int? = nil
    ) -> Eonandyear {
        return Eonandyear(
            lowestsetbit: lowestsetbit ?? self.lowestsetbit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Xmlschematype
struct Xmlschematype: Codable {
    let localpart: String
    let namespaceuri: String
    let xmlschematypePrefix: String

    enum CodingKeys: String, CodingKey {
        case localpart = "localpart"
        case namespaceuri = "namespaceuri"
        case xmlschematypePrefix = "prefix"
    }
}

// MARK: Xmlschematype convenience initializers and mutators

extension Xmlschematype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Xmlschematype.self, from: data)
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
        localpart: String? = nil,
        namespaceuri: String? = nil,
        xmlschematypePrefix: String? = nil
    ) -> Xmlschematype {
        return Xmlschematype(
            localpart: localpart ?? self.localpart,
            namespaceuri: namespaceuri ?? self.namespaceuri,
            xmlschematypePrefix: xmlschematypePrefix ?? self.xmlschematypePrefix
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let product: ProductProduct

    enum CodingKeys: String, CodingKey {
        case product = "product"
    }
}

// MARK: ProductElement convenience initializers and mutators

extension ProductElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProductElement.self, from: data)
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
        product: ProductProduct? = nil
    ) -> ProductElement {
        return ProductElement(
            product: product ?? self.product
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductProduct
struct ProductProduct: Codable {
    let categoryid: Int
    let currency: Currency
    let eco: Bool
    let fulldescription: Bool
    let hasmetasearch: Bool
    let id: Int
    let links: [LinkElement]
    let numoffers: Int
    let pricemax: String
    let pricemin: String
    let productname: String
    let quantity: Int
    let rating: Rating
    let specification: Specification
    let thumbnail: FormatsClass
    let totalsellers: Int

    enum CodingKeys: String, CodingKey {
        case categoryid = "categoryid"
        case currency = "currency"
        case eco = "eco"
        case fulldescription = "fulldescription"
        case hasmetasearch = "hasmetasearch"
        case id = "id"
        case links = "links"
        case numoffers = "numoffers"
        case pricemax = "pricemax"
        case pricemin = "pricemin"
        case productname = "productname"
        case quantity = "quantity"
        case rating = "rating"
        case specification = "specification"
        case thumbnail = "thumbnail"
        case totalsellers = "totalsellers"
    }
}

// MARK: ProductProduct convenience initializers and mutators

extension ProductProduct {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProductProduct.self, from: data)
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
        categoryid: Int? = nil,
        currency: Currency? = nil,
        eco: Bool? = nil,
        fulldescription: Bool? = nil,
        hasmetasearch: Bool? = nil,
        id: Int? = nil,
        links: [LinkElement]? = nil,
        numoffers: Int? = nil,
        pricemax: String? = nil,
        pricemin: String? = nil,
        productname: String? = nil,
        quantity: Int? = nil,
        rating: Rating? = nil,
        specification: Specification? = nil,
        thumbnail: FormatsClass? = nil,
        totalsellers: Int? = nil
    ) -> ProductProduct {
        return ProductProduct(
            categoryid: categoryid ?? self.categoryid,
            currency: currency ?? self.currency,
            eco: eco ?? self.eco,
            fulldescription: fulldescription ?? self.fulldescription,
            hasmetasearch: hasmetasearch ?? self.hasmetasearch,
            id: id ?? self.id,
            links: links ?? self.links,
            numoffers: numoffers ?? self.numoffers,
            pricemax: pricemax ?? self.pricemax,
            pricemin: pricemin ?? self.pricemin,
            productname: productname ?? self.productname,
            quantity: quantity ?? self.quantity,
            rating: rating ?? self.rating,
            specification: specification ?? self.specification,
            thumbnail: thumbnail ?? self.thumbnail,
            totalsellers: totalsellers ?? self.totalsellers
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Currency
struct Currency: Codable {
    let abbreviation: String

    enum CodingKeys: String, CodingKey {
        case abbreviation = "abbreviation"
    }
}

// MARK: Currency convenience initializers and mutators

extension Currency {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Currency.self, from: data)
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
        abbreviation: String? = nil
    ) -> Currency {
        return Currency(
            abbreviation: abbreviation ?? self.abbreviation
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Rating
struct Rating: Codable {
    let useraveragerating: Useraveragerating

    enum CodingKeys: String, CodingKey {
        case useraveragerating = "useraveragerating"
    }
}

// MARK: Rating convenience initializers and mutators

extension Rating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rating.self, from: data)
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
        useraveragerating: Useraveragerating? = nil
    ) -> Rating {
        return Rating(
            useraveragerating: useraveragerating ?? self.useraveragerating
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Useraveragerating
struct Useraveragerating: Codable {
    let links: [LinkElement]
    let numcomments: Int
    let rating: String

    enum CodingKeys: String, CodingKey {
        case links = "links"
        case numcomments = "numcomments"
        case rating = "rating"
    }
}

// MARK: Useraveragerating convenience initializers and mutators

extension Useraveragerating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Useraveragerating.self, from: data)
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
        links: [LinkElement]? = nil,
        numcomments: Int? = nil,
        rating: String? = nil
    ) -> Useraveragerating {
        return Useraveragerating(
            links: links ?? self.links,
            numcomments: numcomments ?? self.numcomments,
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

// MARK: - Specification
struct Specification: Codable {
    let links: [LinkElement]

    enum CodingKeys: String, CodingKey {
        case links = "links"
    }
}

// MARK: Specification convenience initializers and mutators

extension Specification {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Specification.self, from: data)
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
        links: [LinkElement]? = nil
    ) -> Specification {
        return Specification(
            links: links ?? self.links
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Format
struct Format: Codable {
    let formats: FormatsClass

    enum CodingKeys: String, CodingKey {
        case formats = "formats"
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
        formats: FormatsClass? = nil
    ) -> Format {
        return Format(
            formats: formats ?? self.formats
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FormatsClass
struct FormatsClass: Codable {
    let formats: [Format]?
    let height: Int
    let url: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case formats = "formats"
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

// MARK: FormatsClass convenience initializers and mutators

extension FormatsClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FormatsClass.self, from: data)
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
        formats: [Format]?? = nil,
        height: Int? = nil,
        url: String? = nil,
        width: Int? = nil
    ) -> FormatsClass {
        return FormatsClass(
            formats: formats ?? self.formats,
            height: height ?? self.height,
            url: url ?? self.url,
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
