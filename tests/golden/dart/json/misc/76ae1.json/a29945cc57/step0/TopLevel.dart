// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String basePath;
    final Definitions definitions;
    final String host;
    final Info info;
    final Paths paths;
    final List<String> produces;
    final List<String> schemes;
    final String swagger;

    TopLevel({
        required this.basePath,
        required this.definitions,
        required this.host,
        required this.info,
        required this.paths,
        required this.produces,
        required this.schemes,
        required this.swagger,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        basePath: json["basePath"],
        definitions: Definitions.fromJson(json["definitions"]),
        host: json["host"],
        info: Info.fromJson(json["info"]),
        paths: Paths.fromJson(json["paths"]),
        produces: List<String>.from(json["produces"].map((x) => x)),
        schemes: List<String>.from(json["schemes"].map((x) => x)),
        swagger: json["swagger"],
    );

    Map<String, dynamic> toJson() => {
        "basePath": basePath,
        "definitions": definitions.toJson(),
        "host": host,
        "info": info.toJson(),
        "paths": paths.toJson(),
        "produces": List<dynamic>.from(produces.map((x) => x)),
        "schemes": List<dynamic>.from(schemes.map((x) => x)),
        "swagger": swagger,
    };
}

class Definitions {
    final Article article;
    final Article center;
    final DeMinimis deMinimis;
    final Article event;
    final Faq faq;
    final Article lead;
    final Article list;
    final Article marketIntelligence;
    final Article office;
    final Article provider;
    final Article rate;
    final Report report;
    final Taxonomy taxonomy;

    Definitions({
        required this.article,
        required this.center,
        required this.deMinimis,
        required this.event,
        required this.faq,
        required this.lead,
        required this.list,
        required this.marketIntelligence,
        required this.office,
        required this.provider,
        required this.rate,
        required this.report,
        required this.taxonomy,
    });

    factory Definitions.fromJson(Map<String, dynamic> json) => Definitions(
        article: Article.fromJson(json["Article"]),
        center: Article.fromJson(json["Center"]),
        deMinimis: DeMinimis.fromJson(json["DeMinimis"]),
        event: Article.fromJson(json["Event"]),
        faq: Faq.fromJson(json["FAQ"]),
        lead: Article.fromJson(json["Lead"]),
        list: Article.fromJson(json["List"]),
        marketIntelligence: Article.fromJson(json["MarketIntelligence"]),
        office: Article.fromJson(json["Office"]),
        provider: Article.fromJson(json["Provider"]),
        rate: Article.fromJson(json["Rate"]),
        report: Report.fromJson(json["Report"]),
        taxonomy: Taxonomy.fromJson(json["Taxonomy"]),
    );

    Map<String, dynamic> toJson() => {
        "Article": article.toJson(),
        "Center": center.toJson(),
        "DeMinimis": deMinimis.toJson(),
        "Event": event.toJson(),
        "FAQ": faq.toJson(),
        "Lead": lead.toJson(),
        "List": list.toJson(),
        "MarketIntelligence": marketIntelligence.toJson(),
        "Office": office.toJson(),
        "Provider": provider.toJson(),
        "Rate": rate.toJson(),
        "Report": report.toJson(),
        "Taxonomy": taxonomy.toJson(),
    };
}

class Article {
    final Map<String, Property> properties;

    Article({
        required this.properties,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        properties: Map.from(json["properties"]).map((k, v) => MapEntry<String, Property>(k, Property.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "properties": Map.from(properties).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Property {
    final String description;
    final FormatEnum type;

    Property({
        required this.description,
        required this.type,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        description: json["description"],
        type: formatEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "type": formatEnumValues.reverse[type],
    };
}

enum FormatEnum {
    STRING
}

final formatEnumValues = EnumValues({
    "string": FormatEnum.STRING
});

class DeMinimis {
    final DeMinimisProperties properties;

    DeMinimis({
        required this.properties,
    });

    factory DeMinimis.fromJson(Map<String, dynamic> json) => DeMinimis(
        properties: DeMinimisProperties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
    };
}

class DeMinimisProperties {
    final Property countries;
    final Property country;
    final Property deMinimisCurrency;
    final Property deMinimisValue;
    final Property notes;
    final Property vatAmount;
    final Property vatCurrency;

    DeMinimisProperties({
        required this.countries,
        required this.country,
        required this.deMinimisCurrency,
        required this.deMinimisValue,
        required this.notes,
        required this.vatAmount,
        required this.vatCurrency,
    });

    factory DeMinimisProperties.fromJson(Map<String, dynamic> json) => DeMinimisProperties(
        countries: Property.fromJson(json["countries"]),
        country: Property.fromJson(json["country"]),
        deMinimisCurrency: Property.fromJson(json["de_minimis_currency"]),
        deMinimisValue: Property.fromJson(json["de_minimis_value"]),
        notes: Property.fromJson(json["notes"]),
        vatAmount: Property.fromJson(json["vat_amount"]),
        vatCurrency: Property.fromJson(json["vat_currency"]),
    );

    Map<String, dynamic> toJson() => {
        "countries": countries.toJson(),
        "country": country.toJson(),
        "de_minimis_currency": deMinimisCurrency.toJson(),
        "de_minimis_value": deMinimisValue.toJson(),
        "notes": notes.toJson(),
        "vat_amount": vatAmount.toJson(),
        "vat_currency": vatCurrency.toJson(),
    };
}

class Faq {
    final FaqProperties properties;

    Faq({
        required this.properties,
    });

    factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        properties: FaqProperties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
    };
}

class FaqProperties {
    final Property answer;
    final Property countries;
    final Property firstPublishedDate;
    final Property id;
    final Property industries;
    final Property lastPublishedDate;
    final Property question;
    final Property topics;
    final Property tradeRegions;
    final Property url;
    final Property worldRegions;

    FaqProperties({
        required this.answer,
        required this.countries,
        required this.firstPublishedDate,
        required this.id,
        required this.industries,
        required this.lastPublishedDate,
        required this.question,
        required this.topics,
        required this.tradeRegions,
        required this.url,
        required this.worldRegions,
    });

    factory FaqProperties.fromJson(Map<String, dynamic> json) => FaqProperties(
        answer: Property.fromJson(json["answer"]),
        countries: Property.fromJson(json["countries"]),
        firstPublishedDate: Property.fromJson(json["first_published_date"]),
        id: Property.fromJson(json["id"]),
        industries: Property.fromJson(json["industries"]),
        lastPublishedDate: Property.fromJson(json["last_published_date"]),
        question: Property.fromJson(json["question"]),
        topics: Property.fromJson(json["topics"]),
        tradeRegions: Property.fromJson(json["trade_regions"]),
        url: Property.fromJson(json["url"]),
        worldRegions: Property.fromJson(json["world_regions"]),
    );

    Map<String, dynamic> toJson() => {
        "answer": answer.toJson(),
        "countries": countries.toJson(),
        "first_published_date": firstPublishedDate.toJson(),
        "id": id.toJson(),
        "industries": industries.toJson(),
        "last_published_date": lastPublishedDate.toJson(),
        "question": question.toJson(),
        "topics": topics.toJson(),
        "trade_regions": tradeRegions.toJson(),
        "url": url.toJson(),
        "world_regions": worldRegions.toJson(),
    };
}

class Report {
    final ReportProperties properties;

    Report({
        required this.properties,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        properties: ReportProperties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
    };
}

class ReportProperties {
    final Property countries;
    final Property description;
    final Property expirationDate;
    final Property id;
    final Property industries;
    final Property itaIndustries;
    final Property reportType;
    final Property title;
    final Property url;

    ReportProperties({
        required this.countries,
        required this.description,
        required this.expirationDate,
        required this.id,
        required this.industries,
        required this.itaIndustries,
        required this.reportType,
        required this.title,
        required this.url,
    });

    factory ReportProperties.fromJson(Map<String, dynamic> json) => ReportProperties(
        countries: Property.fromJson(json["countries"]),
        description: Property.fromJson(json["description"]),
        expirationDate: Property.fromJson(json["expiration_date"]),
        id: Property.fromJson(json["id"]),
        industries: Property.fromJson(json["industries"]),
        itaIndustries: Property.fromJson(json["ita_industries"]),
        reportType: Property.fromJson(json["report_type"]),
        title: Property.fromJson(json["title"]),
        url: Property.fromJson(json["url"]),
    );

    Map<String, dynamic> toJson() => {
        "countries": countries.toJson(),
        "description": description.toJson(),
        "expiration_date": expirationDate.toJson(),
        "id": id.toJson(),
        "industries": industries.toJson(),
        "ita_industries": itaIndustries.toJson(),
        "report_type": reportType.toJson(),
        "title": title.toJson(),
        "url": url.toJson(),
    };
}

class Taxonomy {
    final TaxonomyProperties properties;

    Taxonomy({
        required this.properties,
    });

    factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        properties: TaxonomyProperties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
    };
}

class TaxonomyProperties {
    final Property annotations;
    final Property datatypeProperties;
    final Property id;
    final Property label;
    final Property subClassOf;
    final Property type;

    TaxonomyProperties({
        required this.annotations,
        required this.datatypeProperties,
        required this.id,
        required this.label,
        required this.subClassOf,
        required this.type,
    });

    factory TaxonomyProperties.fromJson(Map<String, dynamic> json) => TaxonomyProperties(
        annotations: Property.fromJson(json["annotations"]),
        datatypeProperties: Property.fromJson(json["datatype_properties"]),
        id: Property.fromJson(json["id"]),
        label: Property.fromJson(json["label"]),
        subClassOf: Property.fromJson(json["sub_class_of"]),
        type: Property.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "annotations": annotations.toJson(),
        "datatype_properties": datatypeProperties.toJson(),
        "id": id.toJson(),
        "label": label.toJson(),
        "sub_class_of": subClassOf.toJson(),
        "type": type.toJson(),
    };
}

class Info {
    final String description;
    final String title;
    final String version;

    Info({
        required this.description,
        required this.title,
        required this.version,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        description: json["description"],
        title: json["title"],
        version: json["version"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "title": title,
        "version": version,
    };
}

class Paths {
    final BusinessServiceProvidersSearchClass businessServiceProvidersSearch;
    final ConsolidatedScreeningListSearchClass consolidatedScreeningListSearch;
    final ConsolidatedScreeningListSearchClass deMinimisSearch;
    final ConsolidatedScreeningListSearchClass itaFaqsSearch;
    final ConsolidatedScreeningListSearchClass itaOfficeLocationsSearch;
    final BusinessServiceProvidersSearchClass itaTaxonomiesSearch;
    final BusinessServiceProvidersSearchClass itaZipcodeToPostSearch;
    final ConsolidatedScreeningListSearchClass marketIntelligenceSearch;
    final ConsolidatedScreeningListSearchClass marketResearchLibrarySearch;
    final ConsolidatedScreeningListSearchClass tariffRatesSearch;
    final ConsolidatedScreeningListSearchClass tradeArticlesSearch;
    final ConsolidatedScreeningListSearchClass tradeEventsSearch;
    final ConsolidatedScreeningListSearchClass tradeLeadsSearch;

    Paths({
        required this.businessServiceProvidersSearch,
        required this.consolidatedScreeningListSearch,
        required this.deMinimisSearch,
        required this.itaFaqsSearch,
        required this.itaOfficeLocationsSearch,
        required this.itaTaxonomiesSearch,
        required this.itaZipcodeToPostSearch,
        required this.marketIntelligenceSearch,
        required this.marketResearchLibrarySearch,
        required this.tariffRatesSearch,
        required this.tradeArticlesSearch,
        required this.tradeEventsSearch,
        required this.tradeLeadsSearch,
    });

    factory Paths.fromJson(Map<String, dynamic> json) => Paths(
        businessServiceProvidersSearch: BusinessServiceProvidersSearchClass.fromJson(json["/business_service_providers/search"]),
        consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/consolidated_screening_list/search"]),
        deMinimisSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/de_minimis/search"]),
        itaFaqsSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/ita_faqs/search"]),
        itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/ita_office_locations/search"]),
        itaTaxonomiesSearch: BusinessServiceProvidersSearchClass.fromJson(json["/ita_taxonomies/search"]),
        itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass.fromJson(json["/ita_zipcode_to_post/search"]),
        marketIntelligenceSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/market_intelligence/search"]),
        marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass.fromJson(json["/market_research_library/search"]),
        tariffRatesSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/tariff_rates/search"]),
        tradeArticlesSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/trade_articles/search"]),
        tradeEventsSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/trade_events/search"]),
        tradeLeadsSearch: ConsolidatedScreeningListSearchClass.fromJson(json["/trade_leads/search"]),
    );

    Map<String, dynamic> toJson() => {
        "/business_service_providers/search": businessServiceProvidersSearch.toJson(),
        "/consolidated_screening_list/search": consolidatedScreeningListSearch.toJson(),
        "/de_minimis/search": deMinimisSearch.toJson(),
        "/ita_faqs/search": itaFaqsSearch.toJson(),
        "/ita_office_locations/search": itaOfficeLocationsSearch.toJson(),
        "/ita_taxonomies/search": itaTaxonomiesSearch.toJson(),
        "/ita_zipcode_to_post/search": itaZipcodeToPostSearch.toJson(),
        "/market_intelligence/search": marketIntelligenceSearch.toJson(),
        "/market_research_library/search": marketResearchLibrarySearch.toJson(),
        "/tariff_rates/search": tariffRatesSearch.toJson(),
        "/trade_articles/search": tradeArticlesSearch.toJson(),
        "/trade_events/search": tradeEventsSearch.toJson(),
        "/trade_leads/search": tradeLeadsSearch.toJson(),
    };
}

class BusinessServiceProvidersSearchClass {
    final BusinessServiceProvidersSearchGet searchGet;

    BusinessServiceProvidersSearchClass({
        required this.searchGet,
    });

    factory BusinessServiceProvidersSearchClass.fromJson(Map<String, dynamic> json) => BusinessServiceProvidersSearchClass(
        searchGet: BusinessServiceProvidersSearchGet.fromJson(json["get"]),
    );

    Map<String, dynamic> toJson() => {
        "get": searchGet.toJson(),
    };
}

class BusinessServiceProvidersSearchGet {
    final String description;
    final List<Parameter> parameters;
    final PurpleResponses responses;
    final String summary;
    final List<String> tags;

    BusinessServiceProvidersSearchGet({
        required this.description,
        required this.parameters,
        required this.responses,
        required this.summary,
        required this.tags,
    });

    factory BusinessServiceProvidersSearchGet.fromJson(Map<String, dynamic> json) => BusinessServiceProvidersSearchGet(
        description: json["description"],
        parameters: List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
        responses: PurpleResponses.fromJson(json["responses"]),
        summary: json["summary"],
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
        "responses": responses.toJson(),
        "summary": summary,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class Parameter {
    final String description;
    final FormatEnum format;
    final String name;
    final In parameterIn;
    final bool required;
    final FormatEnum type;

    Parameter({
        required this.description,
        required this.format,
        required this.name,
        required this.parameterIn,
        required this.required,
        required this.type,
    });

    factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
        description: json["description"],
        format: formatEnumValues.map[json["format"]]!,
        name: json["name"],
        parameterIn: inValues.map[json["in"]]!,
        required: json["required"],
        type: formatEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "format": formatEnumValues.reverse[format],
        "name": name,
        "in": inValues.reverse[parameterIn],
        "required": required,
        "type": formatEnumValues.reverse[type],
    };
}

enum In {
    QUERY
}

final inValues = EnumValues({
    "query": In.QUERY
});

class PurpleResponses {
    final Purple200 the200;

    PurpleResponses({
        required this.the200,
    });

    factory PurpleResponses.fromJson(Map<String, dynamic> json) => PurpleResponses(
        the200: Purple200.fromJson(json["200"]),
    );

    Map<String, dynamic> toJson() => {
        "200": the200.toJson(),
    };
}

class Purple200 {
    final String description;
    final ItemsClass schema;

    Purple200({
        required this.description,
        required this.schema,
    });

    factory Purple200.fromJson(Map<String, dynamic> json) => Purple200(
        description: json["description"],
        schema: ItemsClass.fromJson(json["schema"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "schema": schema.toJson(),
    };
}

class ItemsClass {
    final String ref;

    ItemsClass({
        required this.ref,
    });

    factory ItemsClass.fromJson(Map<String, dynamic> json) => ItemsClass(
        ref: json["\u0024ref"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
    };
}

class ConsolidatedScreeningListSearchClass {
    final ConsolidatedScreeningListSearchGet searchGet;

    ConsolidatedScreeningListSearchClass({
        required this.searchGet,
    });

    factory ConsolidatedScreeningListSearchClass.fromJson(Map<String, dynamic> json) => ConsolidatedScreeningListSearchClass(
        searchGet: ConsolidatedScreeningListSearchGet.fromJson(json["get"]),
    );

    Map<String, dynamic> toJson() => {
        "get": searchGet.toJson(),
    };
}

class ConsolidatedScreeningListSearchGet {
    final String description;
    final List<Parameter> parameters;
    final FluffyResponses responses;
    final String summary;
    final List<String> tags;

    ConsolidatedScreeningListSearchGet({
        required this.description,
        required this.parameters,
        required this.responses,
        required this.summary,
        required this.tags,
    });

    factory ConsolidatedScreeningListSearchGet.fromJson(Map<String, dynamic> json) => ConsolidatedScreeningListSearchGet(
        description: json["description"],
        parameters: List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
        responses: FluffyResponses.fromJson(json["responses"]),
        summary: json["summary"],
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
        "responses": responses.toJson(),
        "summary": summary,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class FluffyResponses {
    final Fluffy200 the200;

    FluffyResponses({
        required this.the200,
    });

    factory FluffyResponses.fromJson(Map<String, dynamic> json) => FluffyResponses(
        the200: Fluffy200.fromJson(json["200"]),
    );

    Map<String, dynamic> toJson() => {
        "200": the200.toJson(),
    };
}

class Fluffy200 {
    final String description;
    final PurpleSchema schema;

    Fluffy200({
        required this.description,
        required this.schema,
    });

    factory Fluffy200.fromJson(Map<String, dynamic> json) => Fluffy200(
        description: json["description"],
        schema: PurpleSchema.fromJson(json["schema"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "schema": schema.toJson(),
    };
}

class PurpleSchema {
    final ItemsClass items;
    final SchemaType type;

    PurpleSchema({
        required this.items,
        required this.type,
    });

    factory PurpleSchema.fromJson(Map<String, dynamic> json) => PurpleSchema(
        items: ItemsClass.fromJson(json["items"]),
        type: schemaTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "items": items.toJson(),
        "type": schemaTypeValues.reverse[type],
    };
}

enum SchemaType {
    ARRAY
}

final schemaTypeValues = EnumValues({
    "array": SchemaType.ARRAY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
