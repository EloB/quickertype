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
    let article: Article
    let center: Article
    let deMinimis: DeMinimis
    let event: Article
    let faq: FAQ
    let lead: Article
    let list: Article
    let marketIntelligence: Article
    let office: Article
    let provider: Article
    let rate: Article
    let report: Report
    let taxonomy: Taxonomy

    enum CodingKeys: String, CodingKey {
        case article = "Article"
        case center = "Center"
        case deMinimis = "DeMinimis"
        case event = "Event"
        case faq = "FAQ"
        case lead = "Lead"
        case list = "List"
        case marketIntelligence = "MarketIntelligence"
        case office = "Office"
        case provider = "Provider"
        case rate = "Rate"
        case report = "Report"
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
        article: Article? = nil,
        center: Article? = nil,
        deMinimis: DeMinimis? = nil,
        event: Article? = nil,
        faq: FAQ? = nil,
        lead: Article? = nil,
        list: Article? = nil,
        marketIntelligence: Article? = nil,
        office: Article? = nil,
        provider: Article? = nil,
        rate: Article? = nil,
        report: Report? = nil,
        taxonomy: Taxonomy? = nil
    ) -> Definitions {
        return Definitions(
            article: article ?? self.article,
            center: center ?? self.center,
            deMinimis: deMinimis ?? self.deMinimis,
            event: event ?? self.event,
            faq: faq ?? self.faq,
            lead: lead ?? self.lead,
            list: list ?? self.list,
            marketIntelligence: marketIntelligence ?? self.marketIntelligence,
            office: office ?? self.office,
            provider: provider ?? self.provider,
            rate: rate ?? self.rate,
            report: report ?? self.report,
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

// MARK: - Article
struct Article: Codable {
    let properties: [String: Property]

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Article convenience initializers and mutators

extension Article {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Article.self, from: data)
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
    ) -> Article {
        return Article(
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
    let type: FormatEnum

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
        type: FormatEnum? = nil
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

enum FormatEnum: String, Codable {
    case string = "string"
}

// MARK: - DeMinimis
struct DeMinimis: Codable {
    let properties: DeMinimisProperties

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: DeMinimis convenience initializers and mutators

extension DeMinimis {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeMinimis.self, from: data)
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
        properties: DeMinimisProperties? = nil
    ) -> DeMinimis {
        return DeMinimis(
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

// MARK: - DeMinimisProperties
struct DeMinimisProperties: Codable {
    let countries: Property
    let country: Property
    let deMinimisCurrency: Property
    let deMinimisValue: Property
    let notes: Property
    let vatAmount: Property
    let vatCurrency: Property

    enum CodingKeys: String, CodingKey {
        case countries = "countries"
        case country = "country"
        case deMinimisCurrency = "de_minimis_currency"
        case deMinimisValue = "de_minimis_value"
        case notes = "notes"
        case vatAmount = "vat_amount"
        case vatCurrency = "vat_currency"
    }
}

// MARK: DeMinimisProperties convenience initializers and mutators

extension DeMinimisProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeMinimisProperties.self, from: data)
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
        countries: Property? = nil,
        country: Property? = nil,
        deMinimisCurrency: Property? = nil,
        deMinimisValue: Property? = nil,
        notes: Property? = nil,
        vatAmount: Property? = nil,
        vatCurrency: Property? = nil
    ) -> DeMinimisProperties {
        return DeMinimisProperties(
            countries: countries ?? self.countries,
            country: country ?? self.country,
            deMinimisCurrency: deMinimisCurrency ?? self.deMinimisCurrency,
            deMinimisValue: deMinimisValue ?? self.deMinimisValue,
            notes: notes ?? self.notes,
            vatAmount: vatAmount ?? self.vatAmount,
            vatCurrency: vatCurrency ?? self.vatCurrency
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FAQ
struct FAQ: Codable {
    let properties: FAQProperties

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: FAQ convenience initializers and mutators

extension FAQ {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FAQ.self, from: data)
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
        properties: FAQProperties? = nil
    ) -> FAQ {
        return FAQ(
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

// MARK: - FAQProperties
struct FAQProperties: Codable {
    let answer: Property
    let countries: Property
    let firstPublishedDate: Property
    let id: Property
    let industries: Property
    let lastPublishedDate: Property
    let question: Property
    let topics: Property
    let tradeRegions: Property
    let url: Property
    let worldRegions: Property

    enum CodingKeys: String, CodingKey {
        case answer = "answer"
        case countries = "countries"
        case firstPublishedDate = "first_published_date"
        case id = "id"
        case industries = "industries"
        case lastPublishedDate = "last_published_date"
        case question = "question"
        case topics = "topics"
        case tradeRegions = "trade_regions"
        case url = "url"
        case worldRegions = "world_regions"
    }
}

// MARK: FAQProperties convenience initializers and mutators

extension FAQProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FAQProperties.self, from: data)
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
        answer: Property? = nil,
        countries: Property? = nil,
        firstPublishedDate: Property? = nil,
        id: Property? = nil,
        industries: Property? = nil,
        lastPublishedDate: Property? = nil,
        question: Property? = nil,
        topics: Property? = nil,
        tradeRegions: Property? = nil,
        url: Property? = nil,
        worldRegions: Property? = nil
    ) -> FAQProperties {
        return FAQProperties(
            answer: answer ?? self.answer,
            countries: countries ?? self.countries,
            firstPublishedDate: firstPublishedDate ?? self.firstPublishedDate,
            id: id ?? self.id,
            industries: industries ?? self.industries,
            lastPublishedDate: lastPublishedDate ?? self.lastPublishedDate,
            question: question ?? self.question,
            topics: topics ?? self.topics,
            tradeRegions: tradeRegions ?? self.tradeRegions,
            url: url ?? self.url,
            worldRegions: worldRegions ?? self.worldRegions
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
    let properties: ReportProperties

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
        properties: ReportProperties? = nil
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

// MARK: - ReportProperties
struct ReportProperties: Codable {
    let countries: Property
    let description: Property
    let expirationDate: Property
    let id: Property
    let industries: Property
    let itaIndustries: Property
    let reportType: Property
    let title: Property
    let url: Property

    enum CodingKeys: String, CodingKey {
        case countries = "countries"
        case description = "description"
        case expirationDate = "expiration_date"
        case id = "id"
        case industries = "industries"
        case itaIndustries = "ita_industries"
        case reportType = "report_type"
        case title = "title"
        case url = "url"
    }
}

// MARK: ReportProperties convenience initializers and mutators

extension ReportProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReportProperties.self, from: data)
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
        countries: Property? = nil,
        description: Property? = nil,
        expirationDate: Property? = nil,
        id: Property? = nil,
        industries: Property? = nil,
        itaIndustries: Property? = nil,
        reportType: Property? = nil,
        title: Property? = nil,
        url: Property? = nil
    ) -> ReportProperties {
        return ReportProperties(
            countries: countries ?? self.countries,
            description: description ?? self.description,
            expirationDate: expirationDate ?? self.expirationDate,
            id: id ?? self.id,
            industries: industries ?? self.industries,
            itaIndustries: itaIndustries ?? self.itaIndustries,
            reportType: reportType ?? self.reportType,
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

// MARK: - Taxonomy
struct Taxonomy: Codable {
    let properties: TaxonomyProperties

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
        properties: TaxonomyProperties? = nil
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

// MARK: - TaxonomyProperties
struct TaxonomyProperties: Codable {
    let annotations: Property
    let datatypeProperties: Property
    let id: Property
    let label: Property
    let subClassOf: Property
    let type: Property

    enum CodingKeys: String, CodingKey {
        case annotations = "annotations"
        case datatypeProperties = "datatype_properties"
        case id = "id"
        case label = "label"
        case subClassOf = "sub_class_of"
        case type = "type"
    }
}

// MARK: TaxonomyProperties convenience initializers and mutators

extension TaxonomyProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TaxonomyProperties.self, from: data)
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
        annotations: Property? = nil,
        datatypeProperties: Property? = nil,
        id: Property? = nil,
        label: Property? = nil,
        subClassOf: Property? = nil,
        type: Property? = nil
    ) -> TaxonomyProperties {
        return TaxonomyProperties(
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
    let businessServiceProvidersSearch: BusinessServiceProvidersSearchClass
    let consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass
    let deMinimisSearch: ConsolidatedScreeningListSearchClass
    let itaFaqsSearch: ConsolidatedScreeningListSearchClass
    let itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass
    let itaTaxonomiesSearch: BusinessServiceProvidersSearchClass
    let itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass
    let marketIntelligenceSearch: ConsolidatedScreeningListSearchClass
    let marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass
    let tariffRatesSearch: ConsolidatedScreeningListSearchClass
    let tradeArticlesSearch: ConsolidatedScreeningListSearchClass
    let tradeEventsSearch: ConsolidatedScreeningListSearchClass
    let tradeLeadsSearch: ConsolidatedScreeningListSearchClass

    enum CodingKeys: String, CodingKey {
        case businessServiceProvidersSearch = "/business_service_providers/search"
        case consolidatedScreeningListSearch = "/consolidated_screening_list/search"
        case deMinimisSearch = "/de_minimis/search"
        case itaFaqsSearch = "/ita_faqs/search"
        case itaOfficeLocationsSearch = "/ita_office_locations/search"
        case itaTaxonomiesSearch = "/ita_taxonomies/search"
        case itaZipcodeToPostSearch = "/ita_zipcode_to_post/search"
        case marketIntelligenceSearch = "/market_intelligence/search"
        case marketResearchLibrarySearch = "/market_research_library/search"
        case tariffRatesSearch = "/tariff_rates/search"
        case tradeArticlesSearch = "/trade_articles/search"
        case tradeEventsSearch = "/trade_events/search"
        case tradeLeadsSearch = "/trade_leads/search"
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
        businessServiceProvidersSearch: BusinessServiceProvidersSearchClass? = nil,
        consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass? = nil,
        deMinimisSearch: ConsolidatedScreeningListSearchClass? = nil,
        itaFaqsSearch: ConsolidatedScreeningListSearchClass? = nil,
        itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass? = nil,
        itaTaxonomiesSearch: BusinessServiceProvidersSearchClass? = nil,
        itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass? = nil,
        marketIntelligenceSearch: ConsolidatedScreeningListSearchClass? = nil,
        marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass? = nil,
        tariffRatesSearch: ConsolidatedScreeningListSearchClass? = nil,
        tradeArticlesSearch: ConsolidatedScreeningListSearchClass? = nil,
        tradeEventsSearch: ConsolidatedScreeningListSearchClass? = nil,
        tradeLeadsSearch: ConsolidatedScreeningListSearchClass? = nil
    ) -> Paths {
        return Paths(
            businessServiceProvidersSearch: businessServiceProvidersSearch ?? self.businessServiceProvidersSearch,
            consolidatedScreeningListSearch: consolidatedScreeningListSearch ?? self.consolidatedScreeningListSearch,
            deMinimisSearch: deMinimisSearch ?? self.deMinimisSearch,
            itaFaqsSearch: itaFaqsSearch ?? self.itaFaqsSearch,
            itaOfficeLocationsSearch: itaOfficeLocationsSearch ?? self.itaOfficeLocationsSearch,
            itaTaxonomiesSearch: itaTaxonomiesSearch ?? self.itaTaxonomiesSearch,
            itaZipcodeToPostSearch: itaZipcodeToPostSearch ?? self.itaZipcodeToPostSearch,
            marketIntelligenceSearch: marketIntelligenceSearch ?? self.marketIntelligenceSearch,
            marketResearchLibrarySearch: marketResearchLibrarySearch ?? self.marketResearchLibrarySearch,
            tariffRatesSearch: tariffRatesSearch ?? self.tariffRatesSearch,
            tradeArticlesSearch: tradeArticlesSearch ?? self.tradeArticlesSearch,
            tradeEventsSearch: tradeEventsSearch ?? self.tradeEventsSearch,
            tradeLeadsSearch: tradeLeadsSearch ?? self.tradeLeadsSearch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BusinessServiceProvidersSearchClass
struct BusinessServiceProvidersSearchClass: Codable {
    let searchGet: BusinessServiceProvidersSearchGet

    enum CodingKeys: String, CodingKey {
        case searchGet = "get"
    }
}

// MARK: BusinessServiceProvidersSearchClass convenience initializers and mutators

extension BusinessServiceProvidersSearchClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BusinessServiceProvidersSearchClass.self, from: data)
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
        searchGet: BusinessServiceProvidersSearchGet? = nil
    ) -> BusinessServiceProvidersSearchClass {
        return BusinessServiceProvidersSearchClass(
            searchGet: searchGet ?? self.searchGet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BusinessServiceProvidersSearchGet
struct BusinessServiceProvidersSearchGet: Codable {
    let description: String
    let parameters: [Parameter]
    let responses: PurpleResponses
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

// MARK: BusinessServiceProvidersSearchGet convenience initializers and mutators

extension BusinessServiceProvidersSearchGet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BusinessServiceProvidersSearchGet.self, from: data)
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
        responses: PurpleResponses? = nil,
        summary: String? = nil,
        tags: [String]? = nil
    ) -> BusinessServiceProvidersSearchGet {
        return BusinessServiceProvidersSearchGet(
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
    let format: FormatEnum
    let name: String
    let parameterIn: In
    let parameterRequired: Bool
    let type: FormatEnum

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
        format: FormatEnum? = nil,
        name: String? = nil,
        parameterIn: In? = nil,
        parameterRequired: Bool? = nil,
        type: FormatEnum? = nil
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

// MARK: - PurpleResponses
struct PurpleResponses: Codable {
    let the200: Purple200

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: PurpleResponses convenience initializers and mutators

extension PurpleResponses {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleResponses.self, from: data)
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
        the200: Purple200? = nil
    ) -> PurpleResponses {
        return PurpleResponses(
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

// MARK: - Purple200
struct Purple200: Codable {
    let description: String
    let schema: ItemsClass

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case schema = "schema"
    }
}

// MARK: Purple200 convenience initializers and mutators

extension Purple200 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Purple200.self, from: data)
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
        schema: ItemsClass? = nil
    ) -> Purple200 {
        return Purple200(
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

// MARK: - ItemsClass
struct ItemsClass: Codable {
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
    }
}

// MARK: ItemsClass convenience initializers and mutators

extension ItemsClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ItemsClass.self, from: data)
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
    ) -> ItemsClass {
        return ItemsClass(
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

// MARK: - ConsolidatedScreeningListSearchClass
struct ConsolidatedScreeningListSearchClass: Codable {
    let searchGet: ConsolidatedScreeningListSearchGet

    enum CodingKeys: String, CodingKey {
        case searchGet = "get"
    }
}

// MARK: ConsolidatedScreeningListSearchClass convenience initializers and mutators

extension ConsolidatedScreeningListSearchClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConsolidatedScreeningListSearchClass.self, from: data)
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
        searchGet: ConsolidatedScreeningListSearchGet? = nil
    ) -> ConsolidatedScreeningListSearchClass {
        return ConsolidatedScreeningListSearchClass(
            searchGet: searchGet ?? self.searchGet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ConsolidatedScreeningListSearchGet
struct ConsolidatedScreeningListSearchGet: Codable {
    let description: String
    let parameters: [Parameter]
    let responses: FluffyResponses
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

// MARK: ConsolidatedScreeningListSearchGet convenience initializers and mutators

extension ConsolidatedScreeningListSearchGet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConsolidatedScreeningListSearchGet.self, from: data)
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
        responses: FluffyResponses? = nil,
        summary: String? = nil,
        tags: [String]? = nil
    ) -> ConsolidatedScreeningListSearchGet {
        return ConsolidatedScreeningListSearchGet(
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

// MARK: - FluffyResponses
struct FluffyResponses: Codable {
    let the200: Fluffy200

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: FluffyResponses convenience initializers and mutators

extension FluffyResponses {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FluffyResponses.self, from: data)
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
        the200: Fluffy200? = nil
    ) -> FluffyResponses {
        return FluffyResponses(
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

// MARK: - Fluffy200
struct Fluffy200: Codable {
    let description: String
    let schema: PurpleSchema

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case schema = "schema"
    }
}

// MARK: Fluffy200 convenience initializers and mutators

extension Fluffy200 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fluffy200.self, from: data)
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
        schema: PurpleSchema? = nil
    ) -> Fluffy200 {
        return Fluffy200(
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

// MARK: - PurpleSchema
struct PurpleSchema: Codable {
    let items: ItemsClass
    let type: SchemaType

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case type = "type"
    }
}

// MARK: PurpleSchema convenience initializers and mutators

extension PurpleSchema {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PurpleSchema.self, from: data)
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
        items: ItemsClass? = nil,
        type: SchemaType? = nil
    ) -> PurpleSchema {
        return PurpleSchema(
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

enum SchemaType: String, Codable {
    case array = "array"
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
