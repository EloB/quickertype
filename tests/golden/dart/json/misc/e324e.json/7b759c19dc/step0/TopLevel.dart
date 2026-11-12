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
    final Rate rate;

    Definitions({
        required this.rate,
    });

    factory Definitions.fromJson(Map<String, dynamic> json) => Definitions(
        rate: Rate.fromJson(json["Rate"]),
    );

    Map<String, dynamic> toJson() => {
        "Rate": rate.toJson(),
    };
}

class Rate {
    final Map<String, Property> properties;

    Rate({
        required this.properties,
    });

    factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        properties: Map.from(json["properties"]).map((k, v) => MapEntry<String, Property>(k, Property.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "properties": Map.from(properties).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Property {
    final String description;
    final Type type;

    Property({
        required this.description,
        required this.type,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        description: json["description"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "type": typeValues.reverse[type],
    };
}

enum Type {
    STRING
}

final typeValues = EnumValues({
    "string": Type.STRING
});

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
    final TariffRatesSearch tariffRatesSearch;

    Paths({
        required this.tariffRatesSearch,
    });

    factory Paths.fromJson(Map<String, dynamic> json) => Paths(
        tariffRatesSearch: TariffRatesSearch.fromJson(json["/tariff_rates/search"]),
    );

    Map<String, dynamic> toJson() => {
        "/tariff_rates/search": tariffRatesSearch.toJson(),
    };
}

class TariffRatesSearch {
    final Get tariffRatesSearchGet;

    TariffRatesSearch({
        required this.tariffRatesSearchGet,
    });

    factory TariffRatesSearch.fromJson(Map<String, dynamic> json) => TariffRatesSearch(
        tariffRatesSearchGet: Get.fromJson(json["get"]),
    );

    Map<String, dynamic> toJson() => {
        "get": tariffRatesSearchGet.toJson(),
    };
}

class Get {
    final String description;
    final List<Parameter> parameters;
    final Responses responses;
    final String summary;
    final List<String> tags;

    Get({
        required this.description,
        required this.parameters,
        required this.responses,
        required this.summary,
        required this.tags,
    });

    factory Get.fromJson(Map<String, dynamic> json) => Get(
        description: json["description"],
        parameters: List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
        responses: Responses.fromJson(json["responses"]),
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
    final Type format;
    final String name;
    final String parameterIn;
    final bool required;
    final Type type;

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
        format: typeValues.map[json["format"]]!,
        name: json["name"],
        parameterIn: json["in"],
        required: json["required"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "format": typeValues.reverse[format],
        "name": name,
        "in": parameterIn,
        "required": required,
        "type": typeValues.reverse[type],
    };
}

class Responses {
    final The200 the200;

    Responses({
        required this.the200,
    });

    factory Responses.fromJson(Map<String, dynamic> json) => Responses(
        the200: The200.fromJson(json["200"]),
    );

    Map<String, dynamic> toJson() => {
        "200": the200.toJson(),
    };
}

class The200 {
    final String description;
    final Schema schema;

    The200({
        required this.description,
        required this.schema,
    });

    factory The200.fromJson(Map<String, dynamic> json) => The200(
        description: json["description"],
        schema: Schema.fromJson(json["schema"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "schema": schema.toJson(),
    };
}

class Schema {
    final Items items;
    final String type;

    Schema({
        required this.items,
        required this.type,
    });

    factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        items: Items.fromJson(json["items"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "items": items.toJson(),
        "type": type,
    };
}

class Items {
    final String ref;

    Items({
        required this.ref,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        ref: json["\u0024ref"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
