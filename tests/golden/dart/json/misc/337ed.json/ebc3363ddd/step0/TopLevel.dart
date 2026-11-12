// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int count;
    final Facets facets;
    final int limit;
    final String next;
    final int offset;
    final bool previous;
    final List<Result> results;

    TopLevel({
        required this.count,
        required this.facets,
        required this.limit,
        required this.next,
        required this.offset,
        required this.previous,
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        count: json["count"],
        facets: Facets.fromJson(json["facets"]),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "facets": facets.toJson(),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Facets {
    Facets();

    factory Facets.fromJson(Map<String, dynamic> json) => Facets(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Result {
    final int? costAbsolute;
    final int? costMax;
    final int? costMin;
    final DateTime createdAt;
    final List<CustomIncome> customIncomes;
    final dynamic directRepCostsMax;
    final dynamic directRepCostsMin;
    final DateTime endDate;
    final int eurSourcesGrants;
    final String? eurSourcesGrantsSrc;
    final int eurSourcesProcurement;
    final String? eurSourcesProcurementSrc;
    final String id;
    final dynamic newOrganisation;
    final String? noClients;
    final String? otherFinancialInformation;
    final int? otherSourcesContributions;
    final int? otherSourcesDonation;
    final int? otherSourcesTotal;
    final int? publicFinancingInfranational;
    final int? publicFinancingNational;
    final int? publicFinancingTotal;
    final String representative;
    final DateTime startDate;
    final Status status;
    final int? totalBudget;
    final int? turnoverAbsolute;
    final int? turnoverMax;
    final int? turnoverMin;
    final ResultType type;
    final DateTime updatedAt;
    final String uri;

    Result({
        required this.costAbsolute,
        required this.costMax,
        required this.costMin,
        required this.createdAt,
        required this.customIncomes,
        required this.directRepCostsMax,
        required this.directRepCostsMin,
        required this.endDate,
        required this.eurSourcesGrants,
        required this.eurSourcesGrantsSrc,
        required this.eurSourcesProcurement,
        required this.eurSourcesProcurementSrc,
        required this.id,
        required this.newOrganisation,
        required this.noClients,
        required this.otherFinancialInformation,
        required this.otherSourcesContributions,
        required this.otherSourcesDonation,
        required this.otherSourcesTotal,
        required this.publicFinancingInfranational,
        required this.publicFinancingNational,
        required this.publicFinancingTotal,
        required this.representative,
        required this.startDate,
        required this.status,
        required this.totalBudget,
        required this.turnoverAbsolute,
        required this.turnoverMax,
        required this.turnoverMin,
        required this.type,
        required this.updatedAt,
        required this.uri,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        costAbsolute: (json.containsKey("cost_absolute") ? json["cost_absolute"] : throw FormatException('Missing required property')),
        costMax: (json.containsKey("cost_max") ? json["cost_max"] : throw FormatException('Missing required property')),
        costMin: (json.containsKey("cost_min") ? json["cost_min"] : throw FormatException('Missing required property')),
        createdAt: DateTime.parse(json["created_at"]),
        customIncomes: List<CustomIncome>.from(json["customIncomes"].map((x) => CustomIncome.fromJson(x))),
        directRepCostsMax: (json.containsKey("direct_rep_costs_max") ? json["direct_rep_costs_max"] : throw FormatException('Missing required property')),
        directRepCostsMin: (json.containsKey("direct_rep_costs_min") ? json["direct_rep_costs_min"] : throw FormatException('Missing required property')),
        endDate: DateTime.parse(json["end_date"]),
        eurSourcesGrants: json["eur_sources_grants"],
        eurSourcesGrantsSrc: (json.containsKey("eur_sources_grants_src") ? json["eur_sources_grants_src"] : throw FormatException('Missing required property')),
        eurSourcesProcurement: json["eur_sources_procurement"],
        eurSourcesProcurementSrc: (json.containsKey("eur_sources_procurement_src") ? json["eur_sources_procurement_src"] : throw FormatException('Missing required property')),
        id: json["id"],
        newOrganisation: (json.containsKey("new_organisation") ? json["new_organisation"] : throw FormatException('Missing required property')),
        noClients: (json.containsKey("no_clients") ? json["no_clients"] : throw FormatException('Missing required property')),
        otherFinancialInformation: (json.containsKey("other_financial_information") ? json["other_financial_information"] : throw FormatException('Missing required property')),
        otherSourcesContributions: (json.containsKey("other_sources_contributions") ? json["other_sources_contributions"] : throw FormatException('Missing required property')),
        otherSourcesDonation: (json.containsKey("other_sources_donation") ? json["other_sources_donation"] : throw FormatException('Missing required property')),
        otherSourcesTotal: (json.containsKey("other_sources_total") ? json["other_sources_total"] : throw FormatException('Missing required property')),
        publicFinancingInfranational: (json.containsKey("public_financing_infranational") ? json["public_financing_infranational"] : throw FormatException('Missing required property')),
        publicFinancingNational: (json.containsKey("public_financing_national") ? json["public_financing_national"] : throw FormatException('Missing required property')),
        publicFinancingTotal: (json.containsKey("public_financing_total") ? json["public_financing_total"] : throw FormatException('Missing required property')),
        representative: json["representative"],
        startDate: DateTime.parse(json["start_date"]),
        status: statusValues.map[json["status"]]!,
        totalBudget: (json.containsKey("total_budget") ? json["total_budget"] : throw FormatException('Missing required property')),
        turnoverAbsolute: (json.containsKey("turnover_absolute") ? json["turnover_absolute"] : throw FormatException('Missing required property')),
        turnoverMax: (json.containsKey("turnover_max") ? json["turnover_max"] : throw FormatException('Missing required property')),
        turnoverMin: (json.containsKey("turnover_min") ? json["turnover_min"] : throw FormatException('Missing required property')),
        type: resultTypeValues.map[json["type"]]!,
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "cost_absolute": costAbsolute,
        "cost_max": costMax,
        "cost_min": costMin,
        "created_at": createdAt.toIso8601String(),
        "customIncomes": List<dynamic>.from(customIncomes.map((x) => x.toJson())),
        "direct_rep_costs_max": directRepCostsMax,
        "direct_rep_costs_min": directRepCostsMin,
        "end_date": endDate.toIso8601String(),
        "eur_sources_grants": eurSourcesGrants,
        "eur_sources_grants_src": eurSourcesGrantsSrc,
        "eur_sources_procurement": eurSourcesProcurement,
        "eur_sources_procurement_src": eurSourcesProcurementSrc,
        "id": id,
        "new_organisation": newOrganisation,
        "no_clients": noClients,
        "other_financial_information": otherFinancialInformation,
        "other_sources_contributions": otherSourcesContributions,
        "other_sources_donation": otherSourcesDonation,
        "other_sources_total": otherSourcesTotal,
        "public_financing_infranational": publicFinancingInfranational,
        "public_financing_national": publicFinancingNational,
        "public_financing_total": publicFinancingTotal,
        "representative": representative,
        "start_date": startDate.toIso8601String(),
        "status": statusValues.reverse[status],
        "total_budget": totalBudget,
        "turnover_absolute": turnoverAbsolute,
        "turnover_max": turnoverMax,
        "turnover_min": turnoverMin,
        "type": resultTypeValues.reverse[type],
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
    };
}

class CustomIncome {
    final int amount;
    final DateTime createdAt;
    final String id;
    final String name;
    final Status status;
    final CustomIncomeType type;
    final DateTime updatedAt;
    final String uri;

    CustomIncome({
        required this.amount,
        required this.createdAt,
        required this.id,
        required this.name,
        required this.status,
        required this.type,
        required this.updatedAt,
        required this.uri,
    });

    factory CustomIncome.fromJson(Map<String, dynamic> json) => CustomIncome(
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        type: customIncomeTypeValues.map[json["type"]]!,
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "type": customIncomeTypeValues.reverse[type],
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
    };
}

enum Status {
    ACTIVE,
    INACTIVE
}

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "inactive": Status.INACTIVE
});

enum CustomIncomeType {
    PUBLIC,
    OTHER
}

final customIncomeTypeValues = EnumValues({
    "public": CustomIncomeType.PUBLIC,
    "other": CustomIncomeType.OTHER
});

enum ResultType {
    FINANCIAL_DATA_NGO,
    FINANCIAL_DATA_LAWYER,
    FINANCIAL_DATA_TRADE_ASSOCIATION
}

final resultTypeValues = EnumValues({
    "FinancialDataNGO": ResultType.FINANCIAL_DATA_NGO,
    "FinancialDataLawyer": ResultType.FINANCIAL_DATA_LAWYER,
    "FinancialDataTradeAssociation": ResultType.FINANCIAL_DATA_TRADE_ASSOCIATION
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
