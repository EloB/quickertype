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
    final String attributionLink;
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
        required this.attributionLink,
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
        attributionLink: json["attributionLink"],
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
        "attributionLink": attributionLink,
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
    final Format format;
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
        format: Format.fromJson(json["format"]),
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
    final String largest;
    final int nonNull;
    final String smallest;
    final String? sum;
    final List<Top> top;

    CachedContents({
        this.average,
        required this.cachedContentsNull,
        required this.largest,
        required this.nonNull,
        required this.smallest,
        this.sum,
        required this.top,
    });

    factory CachedContents.fromJson(Map<String, dynamic> json) => CachedContents(
        average: json["average"],
        cachedContentsNull: json["null"],
        largest: json["largest"],
        nonNull: json["non_null"],
        smallest: json["smallest"],
        sum: json["sum"],
        top: List<Top>.from(json["top"].map((x) => Top.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "average": average,
        "null": cachedContentsNull,
        "largest": largest,
        "non_null": nonNull,
        "smallest": smallest,
        "sum": sum,
        "top": List<dynamic>.from(top.map((x) => x.toJson())),
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

class Format {
    final String? align;
    final String? noCommas;
    final String? precisionStyle;
    final String? view;

    Format({
        this.align,
        this.noCommas,
        this.precisionStyle,
        this.view,
    });

    factory Format.fromJson(Map<String, dynamic> json) => Format(
        align: json["align"],
        noCommas: json["noCommas"],
        precisionStyle: json["precisionStyle"],
        view: json["view"],
    );

    Map<String, dynamic> toJson() => {
        "align": align,
        "noCommas": noCommas,
        "precisionStyle": precisionStyle,
        "view": view,
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

class Metadata {
    final List<Attachment> attachments;
    final List<String> availableDisplayTypes;
    final CustomFields customFields;
    final JsonQuery jsonQuery;
    final String rdfSubject;
    final RenderTypeConfig renderTypeConfig;

    Metadata({
        required this.attachments,
        required this.availableDisplayTypes,
        required this.customFields,
        required this.jsonQuery,
        required this.rdfSubject,
        required this.renderTypeConfig,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        availableDisplayTypes: List<String>.from(json["availableDisplayTypes"].map((x) => x)),
        customFields: CustomFields.fromJson(json["custom_fields"]),
        jsonQuery: JsonQuery.fromJson(json["jsonQuery"]),
        rdfSubject: json["rdfSubject"],
        renderTypeConfig: RenderTypeConfig.fromJson(json["renderTypeConfig"]),
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "availableDisplayTypes": List<dynamic>.from(availableDisplayTypes.map((x) => x)),
        "custom_fields": customFields.toJson(),
        "jsonQuery": jsonQuery.toJson(),
        "rdfSubject": rdfSubject,
        "renderTypeConfig": renderTypeConfig.toJson(),
    };
}

class Attachment {
    final String assetId;
    final String blobId;
    final String filename;
    final String name;

    Attachment({
        required this.assetId,
        required this.blobId,
        required this.filename,
        required this.name,
    });

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        assetId: json["assetId"],
        blobId: json["blobId"],
        filename: json["filename"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "assetId": assetId,
        "blobId": blobId,
        "filename": filename,
        "name": name,
    };
}

class CustomFields {
    final AdditionalResources additionalResources;
    final CommonCore commonCore;
    final DatasetInformation datasetInformation;
    final DatasetSummary datasetSummary;
    final Notes notes;

    CustomFields({
        required this.additionalResources,
        required this.commonCore,
        required this.datasetInformation,
        required this.datasetSummary,
        required this.notes,
    });

    factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
        additionalResources: AdditionalResources.fromJson(json["Additional Resources"]),
        commonCore: CommonCore.fromJson(json["Common Core"]),
        datasetInformation: DatasetInformation.fromJson(json["Dataset Information"]),
        datasetSummary: DatasetSummary.fromJson(json["Dataset Summary"]),
        notes: Notes.fromJson(json["Notes"]),
    );

    Map<String, dynamic> toJson() => {
        "Additional Resources": additionalResources.toJson(),
        "Common Core": commonCore.toJson(),
        "Dataset Information": datasetInformation.toJson(),
        "Dataset Summary": datasetSummary.toJson(),
        "Notes": notes.toJson(),
    };
}

class AdditionalResources {
    final String additionalResourcesSeeAlso;
    final String seeAlso;

    AdditionalResources({
        required this.additionalResourcesSeeAlso,
        required this.seeAlso,
    });

    factory AdditionalResources.fromJson(Map<String, dynamic> json) => AdditionalResources(
        additionalResourcesSeeAlso: json["See Also "],
        seeAlso: json["See Also"],
    );

    Map<String, dynamic> toJson() => {
        "See Also ": additionalResourcesSeeAlso,
        "See Also": seeAlso,
    };
}

class CommonCore {
    final String contactEmail;
    final String contactName;
    final String publisher;

    CommonCore({
        required this.contactEmail,
        required this.contactName,
        required this.publisher,
    });

    factory CommonCore.fromJson(Map<String, dynamic> json) => CommonCore(
        contactEmail: json["Contact Email"],
        contactName: json["Contact Name"],
        publisher: json["Publisher"],
    );

    Map<String, dynamic> toJson() => {
        "Contact Email": contactEmail,
        "Contact Name": contactName,
        "Publisher": publisher,
    };
}

class DatasetInformation {
    final String agency;

    DatasetInformation({
        required this.agency,
    });

    factory DatasetInformation.fromJson(Map<String, dynamic> json) => DatasetInformation(
        agency: json["Agency"],
    );

    Map<String, dynamic> toJson() => {
        "Agency": agency,
    };
}

class DatasetSummary {
    final String contactInformation;
    final String coverage;
    final String dataFrequency;
    final String datasetOwner;
    final String granularity;
    final String organization;
    final String postingFrequency;
    final String timePeriod;
    final String units;

    DatasetSummary({
        required this.contactInformation,
        required this.coverage,
        required this.dataFrequency,
        required this.datasetOwner,
        required this.granularity,
        required this.organization,
        required this.postingFrequency,
        required this.timePeriod,
        required this.units,
    });

    factory DatasetSummary.fromJson(Map<String, dynamic> json) => DatasetSummary(
        contactInformation: json["Contact Information"],
        coverage: json["Coverage"],
        dataFrequency: json["Data Frequency"],
        datasetOwner: json["Dataset Owner"],
        granularity: json["Granularity"],
        organization: json["Organization"],
        postingFrequency: json["Posting Frequency"],
        timePeriod: json["Time Period"],
        units: json["Units"],
    );

    Map<String, dynamic> toJson() => {
        "Contact Information": contactInformation,
        "Coverage": coverage,
        "Data Frequency": dataFrequency,
        "Dataset Owner": datasetOwner,
        "Granularity": granularity,
        "Organization": organization,
        "Posting Frequency": postingFrequency,
        "Time Period": timePeriod,
        "Units": units,
    };
}

class Notes {
    final String notes;

    Notes({
        required this.notes,
    });

    factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        notes: json["Notes"],
    );

    Map<String, dynamic> toJson() => {
        "Notes": notes,
    };
}

class JsonQuery {
    final List<Order> order;

    JsonQuery({
        required this.order,
    });

    factory JsonQuery.fromJson(Map<String, dynamic> json) => JsonQuery(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
    };
}

class Order {
    final bool ascending;
    final String columnFieldName;

    Order({
        required this.ascending,
        required this.columnFieldName,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        ascending: json["ascending"],
        columnFieldName: json["columnFieldName"],
    );

    Map<String, dynamic> toJson() => {
        "ascending": ascending,
        "columnFieldName": columnFieldName,
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
    final String profileImageUrlLarge;
    final String profileImageUrlMedium;
    final String profileImageUrlSmall;
    final List<String> rights;
    final String roleName;
    final String screenName;

    Owner({
        required this.displayName,
        required this.id,
        required this.profileImageUrlLarge,
        required this.profileImageUrlMedium,
        required this.profileImageUrlSmall,
        required this.rights,
        required this.roleName,
        required this.screenName,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        displayName: json["displayName"],
        id: json["id"],
        profileImageUrlLarge: json["profileImageUrlLarge"],
        profileImageUrlMedium: json["profileImageUrlMedium"],
        profileImageUrlSmall: json["profileImageUrlSmall"],
        rights: List<String>.from(json["rights"].map((x) => x)),
        roleName: json["roleName"],
        screenName: json["screenName"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "id": id,
        "profileImageUrlLarge": profileImageUrlLarge,
        "profileImageUrlMedium": profileImageUrlMedium,
        "profileImageUrlSmall": profileImageUrlSmall,
        "rights": List<dynamic>.from(rights.map((x) => x)),
        "roleName": roleName,
        "screenName": screenName,
    };
}

class Query {
    final List<OrderBy> orderBys;

    Query({
        required this.orderBys,
    });

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        orderBys: List<OrderBy>.from(json["orderBys"].map((x) => OrderBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orderBys": List<dynamic>.from(orderBys.map((x) => x.toJson())),
    };
}

class OrderBy {
    final bool ascending;
    final Expression expression;

    OrderBy({
        required this.ascending,
        required this.expression,
    });

    factory OrderBy.fromJson(Map<String, dynamic> json) => OrderBy(
        ascending: json["ascending"],
        expression: Expression.fromJson(json["expression"]),
    );

    Map<String, dynamic> toJson() => {
        "ascending": ascending,
        "expression": expression.toJson(),
    };
}

class Expression {
    final int columnId;
    final String type;

    Expression({
        required this.columnId,
        required this.type,
    });

    factory Expression.fromJson(Map<String, dynamic> json) => Expression(
        columnId: json["columnId"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "columnId": columnId,
        "type": type,
    };
}
