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
    final Taxonomy taxonomy;

    Definitions({
        required this.taxonomy,
    });

    factory Definitions.fromJson(Map<String, dynamic> json) => Definitions(
        taxonomy: Taxonomy.fromJson(json["Taxonomy"]),
    );

    Map<String, dynamic> toJson() => {
        "Taxonomy": taxonomy.toJson(),
    };
}

class Taxonomy {
    final Properties properties;

    Taxonomy({
        required this.properties,
    });

    factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
    };
}

class Properties {
    final Annotations annotations;
    final Annotations datatypeProperties;
    final Annotations id;
    final Annotations label;
    final Annotations subClassOf;
    final Annotations type;

    Properties({
        required this.annotations,
        required this.datatypeProperties,
        required this.id,
        required this.label,
        required this.subClassOf,
        required this.type,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        annotations: Annotations.fromJson(json["annotations"]),
        datatypeProperties: Annotations.fromJson(json["datatype_properties"]),
        id: Annotations.fromJson(json["id"]),
        label: Annotations.fromJson(json["label"]),
        subClassOf: Annotations.fromJson(json["sub_class_of"]),
        type: Annotations.fromJson(json["type"]),
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

class Annotations {
    final String description;
    final String type;

    Annotations({
        required this.description,
        required this.type,
    });

    factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
        description: json["description"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "type": type,
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
    final ItaTaxonomiesSearch itaTaxonomiesSearch;

    Paths({
        required this.itaTaxonomiesSearch,
    });

    factory Paths.fromJson(Map<String, dynamic> json) => Paths(
        itaTaxonomiesSearch: ItaTaxonomiesSearch.fromJson(json["/ita_taxonomies/search"]),
    );

    Map<String, dynamic> toJson() => {
        "/ita_taxonomies/search": itaTaxonomiesSearch.toJson(),
    };
}

class ItaTaxonomiesSearch {
    final Get itaTaxonomiesSearchGet;

    ItaTaxonomiesSearch({
        required this.itaTaxonomiesSearchGet,
    });

    factory ItaTaxonomiesSearch.fromJson(Map<String, dynamic> json) => ItaTaxonomiesSearch(
        itaTaxonomiesSearchGet: Get.fromJson(json["get"]),
    );

    Map<String, dynamic> toJson() => {
        "get": itaTaxonomiesSearchGet.toJson(),
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
    final String format;
    final String name;
    final String parameterIn;
    final bool required;
    final String type;

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
        format: json["format"],
        name: json["name"],
        parameterIn: json["in"],
        required: json["required"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "format": format,
        "name": name,
        "in": parameterIn,
        "required": required,
        "type": type,
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
    final String ref;

    Schema({
        required this.ref,
    });

    factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        ref: json["\u0024ref"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
    };
}
