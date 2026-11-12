// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<List<dynamic>> data;
    final Meta meta;

    TopLevel({
        required this.data,
        required this.meta,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: List<List<dynamic>>.from(json["data"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "meta": meta.toJson(),
    };
}

class Meta {
    final View view;

    Meta({
        required this.view,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        view: View.fromJson(json["view"]),
    );

    Map<String, dynamic> toJson() => {
        "view": view.toJson(),
    };
}

class View {
    final String attribution;
    final int averageRating;
    final String category;
    final List<Column> columns;
    final int createdAt;
    final String description;
    final String displayType;
    final int downloadCount;
    final List<String> flags;
    final List<Grant> grants;
    final bool hideFromCatalog;
    final bool hideFromDataJson;
    final String id;
    final int indexUpdatedAt;
    final License license;
    final String licenseId;
    final String locale;
    final Metadata metadata;
    final String name;
    final bool newBackend;
    final int numberOfComments;
    final int oid;
    final Owner owner;
    final String provenance;
    final bool publicationAppendEnabled;
    final int publicationDate;
    final int publicationGroup;
    final String publicationStage;
    final Query query;
    final List<String> rights;
    final String rowClass;
    final int rowsUpdatedAt;
    final String rowsUpdatedBy;
    final Owner tableAuthor;
    final int tableId;
    final List<String> tags;
    final int totalTimesRated;
    final int viewCount;
    final int viewLastModified;
    final String viewType;

    View({
        required this.attribution,
        required this.averageRating,
        required this.category,
        required this.columns,
        required this.createdAt,
        required this.description,
        required this.displayType,
        required this.downloadCount,
        required this.flags,
        required this.grants,
        required this.hideFromCatalog,
        required this.hideFromDataJson,
        required this.id,
        required this.indexUpdatedAt,
        required this.license,
        required this.licenseId,
        required this.locale,
        required this.metadata,
        required this.name,
        required this.newBackend,
        required this.numberOfComments,
        required this.oid,
        required this.owner,
        required this.provenance,
        required this.publicationAppendEnabled,
        required this.publicationDate,
        required this.publicationGroup,
        required this.publicationStage,
        required this.query,
        required this.rights,
        required this.rowClass,
        required this.rowsUpdatedAt,
        required this.rowsUpdatedBy,
        required this.tableAuthor,
        required this.tableId,
        required this.tags,
        required this.totalTimesRated,
        required this.viewCount,
        required this.viewLastModified,
        required this.viewType,
    });

    factory View.fromJson(Map<String, dynamic> json) => View(
        attribution: json["attribution"],
        averageRating: json["averageRating"],
        category: json["category"],
        columns: List<Column>.from(json["columns"].map((x) => Column.fromJson(x))),
        createdAt: json["createdAt"],
        description: json["description"],
        displayType: json["displayType"],
        downloadCount: json["downloadCount"],
        flags: List<String>.from(json["flags"].map((x) => x)),
        grants: List<Grant>.from(json["grants"].map((x) => Grant.fromJson(x))),
        hideFromCatalog: json["hideFromCatalog"],
        hideFromDataJson: json["hideFromDataJson"],
        id: json["id"],
        indexUpdatedAt: json["indexUpdatedAt"],
        license: License.fromJson(json["license"]),
        licenseId: json["licenseId"],
        locale: json["locale"],
        metadata: Metadata.fromJson(json["metadata"]),
        name: json["name"],
        newBackend: json["newBackend"],
        numberOfComments: json["numberOfComments"],
        oid: json["oid"],
        owner: Owner.fromJson(json["owner"]),
        provenance: json["provenance"],
        publicationAppendEnabled: json["publicationAppendEnabled"],
        publicationDate: json["publicationDate"],
        publicationGroup: json["publicationGroup"],
        publicationStage: json["publicationStage"],
        query: Query.fromJson(json["query"]),
        rights: List<String>.from(json["rights"].map((x) => x)),
        rowClass: json["rowClass"],
        rowsUpdatedAt: json["rowsUpdatedAt"],
        rowsUpdatedBy: json["rowsUpdatedBy"],
        tableAuthor: Owner.fromJson(json["tableAuthor"]),
        tableId: json["tableId"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        totalTimesRated: json["totalTimesRated"],
        viewCount: json["viewCount"],
        viewLastModified: json["viewLastModified"],
        viewType: json["viewType"],
    );

    Map<String, dynamic> toJson() => {
        "attribution": attribution,
        "averageRating": averageRating,
        "category": category,
        "columns": List<dynamic>.from(columns.map((x) => x.toJson())),
        "createdAt": createdAt,
        "description": description,
        "displayType": displayType,
        "downloadCount": downloadCount,
        "flags": List<dynamic>.from(flags.map((x) => x)),
        "grants": List<dynamic>.from(grants.map((x) => x.toJson())),
        "hideFromCatalog": hideFromCatalog,
        "hideFromDataJson": hideFromDataJson,
        "id": id,
        "indexUpdatedAt": indexUpdatedAt,
        "license": license.toJson(),
        "licenseId": licenseId,
        "locale": locale,
        "metadata": metadata.toJson(),
        "name": name,
        "newBackend": newBackend,
        "numberOfComments": numberOfComments,
        "oid": oid,
        "owner": owner.toJson(),
        "provenance": provenance,
        "publicationAppendEnabled": publicationAppendEnabled,
        "publicationDate": publicationDate,
        "publicationGroup": publicationGroup,
        "publicationStage": publicationStage,
        "query": query.toJson(),
        "rights": List<dynamic>.from(rights.map((x) => x)),
        "rowClass": rowClass,
        "rowsUpdatedAt": rowsUpdatedAt,
        "rowsUpdatedBy": rowsUpdatedBy,
        "tableAuthor": tableAuthor.toJson(),
        "tableId": tableId,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "totalTimesRated": totalTimesRated,
        "viewCount": viewCount,
        "viewLastModified": viewLastModified,
        "viewType": viewType,
    };
}

class Column {
    final CachedContents? cachedContents;
    final String dataTypeName;
    final String fieldName;
    final List<String>? flags;
    final Query format;
    final int id;
    final String name;
    final int position;
    final String renderTypeName;
    final int? tableColumnId;
    final int? width;

    Column({
        this.cachedContents,
        required this.dataTypeName,
        required this.fieldName,
        this.flags,
        required this.format,
        required this.id,
        required this.name,
        required this.position,
        required this.renderTypeName,
        this.tableColumnId,
        this.width,
    });

    factory Column.fromJson(Map<String, dynamic> json) => Column(
        cachedContents: json["cachedContents"] == null ? null : CachedContents.fromJson(json["cachedContents"]),
        dataTypeName: json["dataTypeName"],
        fieldName: json["fieldName"],
        flags: json["flags"] == null ? null : List<String>.from(json["flags"]!.map((x) => x)),
        format: Query.fromJson(json["format"]),
        id: json["id"],
        name: json["name"],
        position: json["position"],
        renderTypeName: json["renderTypeName"],
        tableColumnId: json["tableColumnId"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "cachedContents": cachedContents?.toJson(),
        "dataTypeName": dataTypeName,
        "fieldName": fieldName,
        "flags": flags == null ? null : List<dynamic>.from(flags!.map((x) => x)),
        "format": format.toJson(),
        "id": id,
        "name": name,
        "position": position,
        "renderTypeName": renderTypeName,
        "tableColumnId": tableColumnId,
        "width": width,
    };
}

class CachedContents {
    final String? average;
    final int cachedContentsNull;
    final String? largest;
    final int nonNull;
    final String? smallest;
    final String? sum;
    final List<Top>? top;

    CachedContents({
        this.average,
        required this.cachedContentsNull,
        this.largest,
        required this.nonNull,
        this.smallest,
        this.sum,
        this.top,
    });

    factory CachedContents.fromJson(Map<String, dynamic> json) => CachedContents(
        average: json["average"],
        cachedContentsNull: json["null"],
        largest: json["largest"],
        nonNull: json["non_null"],
        smallest: json["smallest"],
        sum: json["sum"],
        top: json["top"] == null ? null : List<Top>.from(json["top"]!.map((x) => Top.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "average": average,
        "null": cachedContentsNull,
        "largest": largest,
        "non_null": nonNull,
        "smallest": smallest,
        "sum": sum,
        "top": top == null ? null : List<dynamic>.from(top!.map((x) => x.toJson())),
    };
}

class Top {
    final int count;
    final String item;

    Top({
        required this.count,
        required this.item,
    });

    factory Top.fromJson(Map<String, dynamic> json) => Top(
        count: json["count"],
        item: json["item"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "item": item,
    };
}

class Query {
    Query();

    factory Query.fromJson(Map<String, dynamic> json) => Query(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Grant {
    final List<String> flags;
    final bool inherited;
    final String type;

    Grant({
        required this.flags,
        required this.inherited,
        required this.type,
    });

    factory Grant.fromJson(Map<String, dynamic> json) => Grant(
        flags: List<String>.from(json["flags"].map((x) => x)),
        inherited: json["inherited"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "flags": List<dynamic>.from(flags.map((x) => x)),
        "inherited": inherited,
        "type": type,
    };
}

class License {
    final String name;

    License({
        required this.name,
    });

    factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Metadata {
    final List<String> availableDisplayTypes;
    final String rdfClass;
    final String rdfSubject;
    final RenderTypeConfig renderTypeConfig;
    final String rowIdentifier;

    Metadata({
        required this.availableDisplayTypes,
        required this.rdfClass,
        required this.rdfSubject,
        required this.renderTypeConfig,
        required this.rowIdentifier,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        availableDisplayTypes: List<String>.from(json["availableDisplayTypes"].map((x) => x)),
        rdfClass: json["rdfClass"],
        rdfSubject: json["rdfSubject"],
        renderTypeConfig: RenderTypeConfig.fromJson(json["renderTypeConfig"]),
        rowIdentifier: json["rowIdentifier"],
    );

    Map<String, dynamic> toJson() => {
        "availableDisplayTypes": List<dynamic>.from(availableDisplayTypes.map((x) => x)),
        "rdfClass": rdfClass,
        "rdfSubject": rdfSubject,
        "renderTypeConfig": renderTypeConfig.toJson(),
        "rowIdentifier": rowIdentifier,
    };
}

class RenderTypeConfig {
    final Visible visible;

    RenderTypeConfig({
        required this.visible,
    });

    factory RenderTypeConfig.fromJson(Map<String, dynamic> json) => RenderTypeConfig(
        visible: Visible.fromJson(json["visible"]),
    );

    Map<String, dynamic> toJson() => {
        "visible": visible.toJson(),
    };
}

class Visible {
    final bool table;

    Visible({
        required this.table,
    });

    factory Visible.fromJson(Map<String, dynamic> json) => Visible(
        table: json["table"],
    );

    Map<String, dynamic> toJson() => {
        "table": table,
    };
}

class Owner {
    final String displayName;
    final String id;
    final String screenName;

    Owner({
        required this.displayName,
        required this.id,
        required this.screenName,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        displayName: json["displayName"],
        id: json["id"],
        screenName: json["screenName"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "id": id,
        "screenName": screenName,
    };
}
