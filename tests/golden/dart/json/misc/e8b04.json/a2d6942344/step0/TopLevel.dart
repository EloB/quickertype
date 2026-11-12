// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int averageRating;
    final String? category;
    final int createdAt;
    final String? description;
    final DisplayType? displayType;
    final int downloadCount;
    final List<TopLevelFlag>? flags;
    final List<Grant> grants;
    final bool hideFromCatalog;
    final bool hideFromDataJson;
    final String id;
    final int? indexUpdatedAt;
    final String locale;
    final TopLevelMetadata metadata;
    final bool? moderationStatus;
    final ModifyingViewUid? modifyingViewUid;
    final String name;
    final bool newBackend;
    final int numberOfComments;
    final int oid;
    final Owner owner;
    final Provenance provenance;
    final bool publicationAppendEnabled;
    final int? publicationDate;
    final int publicationGroup;
    final PublicationStage publicationStage;
    final Ratings? ratings;
    final String? resourceName;
    final List<Right> rights;
    final String? rowClass;
    final int? rowIdentifierColumnId;
    final int? rowsUpdatedAt;
    final RowsUpdatedBy? rowsUpdatedBy;
    final TableAuthor tableAuthor;
    final int tableId;
    final List<String>? tags;
    final int totalTimesRated;
    final int viewCount;
    final int viewLastModified;
    final ViewType viewType;

    TopLevel({
        required this.averageRating,
        this.category,
        required this.createdAt,
        this.description,
        this.displayType,
        required this.downloadCount,
        this.flags,
        required this.grants,
        required this.hideFromCatalog,
        required this.hideFromDataJson,
        required this.id,
        this.indexUpdatedAt,
        required this.locale,
        required this.metadata,
        this.moderationStatus,
        this.modifyingViewUid,
        required this.name,
        required this.newBackend,
        required this.numberOfComments,
        required this.oid,
        required this.owner,
        required this.provenance,
        required this.publicationAppendEnabled,
        this.publicationDate,
        required this.publicationGroup,
        required this.publicationStage,
        this.ratings,
        this.resourceName,
        required this.rights,
        this.rowClass,
        this.rowIdentifierColumnId,
        this.rowsUpdatedAt,
        this.rowsUpdatedBy,
        required this.tableAuthor,
        required this.tableId,
        this.tags,
        required this.totalTimesRated,
        required this.viewCount,
        required this.viewLastModified,
        required this.viewType,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        averageRating: json["averageRating"],
        category: json["category"],
        createdAt: json["createdAt"],
        description: json["description"],
        displayType: json["displayType"] == null ? null : displayTypeValues.map[json["displayType"]]!,
        downloadCount: json["downloadCount"],
        flags: json["flags"] == null ? null : List<TopLevelFlag>.from(json["flags"]!.map((x) => topLevelFlagValues.map[x]!)),
        grants: List<Grant>.from(json["grants"].map((x) => Grant.fromJson(x))),
        hideFromCatalog: json["hideFromCatalog"],
        hideFromDataJson: json["hideFromDataJson"],
        id: json["id"],
        indexUpdatedAt: json["indexUpdatedAt"],
        locale: json["locale"],
        metadata: TopLevelMetadata.fromJson(json["metadata"]),
        moderationStatus: json["moderationStatus"],
        modifyingViewUid: json["modifyingViewUid"] == null ? null : modifyingViewUidValues.map[json["modifyingViewUid"]]!,
        name: json["name"],
        newBackend: json["newBackend"],
        numberOfComments: json["numberOfComments"],
        oid: json["oid"],
        owner: Owner.fromJson(json["owner"]),
        provenance: provenanceValues.map[json["provenance"]]!,
        publicationAppendEnabled: json["publicationAppendEnabled"],
        publicationDate: json["publicationDate"],
        publicationGroup: json["publicationGroup"],
        publicationStage: publicationStageValues.map[json["publicationStage"]]!,
        ratings: json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        resourceName: json["resourceName"],
        rights: List<Right>.from(json["rights"].map((x) => rightValues.map[x]!)),
        rowClass: json["rowClass"],
        rowIdentifierColumnId: json["rowIdentifierColumnId"],
        rowsUpdatedAt: json["rowsUpdatedAt"],
        rowsUpdatedBy: json["rowsUpdatedBy"] == null ? null : rowsUpdatedByValues.map[json["rowsUpdatedBy"]]!,
        tableAuthor: TableAuthor.fromJson(json["tableAuthor"]),
        tableId: json["tableId"],
        tags: json["tags"] == null ? null : List<String>.from(json["tags"]!.map((x) => x)),
        totalTimesRated: json["totalTimesRated"],
        viewCount: json["viewCount"],
        viewLastModified: json["viewLastModified"],
        viewType: viewTypeValues.map[json["viewType"]]!,
    );

    Map<String, dynamic> toJson() => {
        "averageRating": averageRating,
        "category": category,
        "createdAt": createdAt,
        "description": description,
        "displayType": displayTypeValues.reverse[displayType],
        "downloadCount": downloadCount,
        "flags": flags == null ? null : List<dynamic>.from(flags!.map((x) => topLevelFlagValues.reverse[x])),
        "grants": List<dynamic>.from(grants.map((x) => x.toJson())),
        "hideFromCatalog": hideFromCatalog,
        "hideFromDataJson": hideFromDataJson,
        "id": id,
        "indexUpdatedAt": indexUpdatedAt,
        "locale": locale,
        "metadata": metadata.toJson(),
        "moderationStatus": moderationStatus,
        "modifyingViewUid": modifyingViewUidValues.reverse[modifyingViewUid],
        "name": name,
        "newBackend": newBackend,
        "numberOfComments": numberOfComments,
        "oid": oid,
        "owner": owner.toJson(),
        "provenance": provenanceValues.reverse[provenance],
        "publicationAppendEnabled": publicationAppendEnabled,
        "publicationDate": publicationDate,
        "publicationGroup": publicationGroup,
        "publicationStage": publicationStageValues.reverse[publicationStage],
        "ratings": ratings?.toJson(),
        "resourceName": resourceName,
        "rights": List<dynamic>.from(rights.map((x) => rightValues.reverse[x])),
        "rowClass": rowClass,
        "rowIdentifierColumnId": rowIdentifierColumnId,
        "rowsUpdatedAt": rowsUpdatedAt,
        "rowsUpdatedBy": rowsUpdatedByValues.reverse[rowsUpdatedBy],
        "tableAuthor": tableAuthor.toJson(),
        "tableId": tableId,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "totalTimesRated": totalTimesRated,
        "viewCount": viewCount,
        "viewLastModified": viewLastModified,
        "viewType": viewTypeValues.reverse[viewType],
    };
}

enum DisplayType {
    TABLE,
    DATA_LENS,
    FATROW,
    PAGE
}

final displayTypeValues = EnumValues({
    "table": DisplayType.TABLE,
    "data_lens": DisplayType.DATA_LENS,
    "fatrow": DisplayType.FATROW,
    "page": DisplayType.PAGE
});

enum TopLevelFlag {
    DEFAULT,
    RESTORABLE,
    RESTORE_POSSIBLE_FOR_TYPE
}

final topLevelFlagValues = EnumValues({
    "default": TopLevelFlag.DEFAULT,
    "restorable": TopLevelFlag.RESTORABLE,
    "restorePossibleForType": TopLevelFlag.RESTORE_POSSIBLE_FOR_TYPE
});

class Grant {
    final List<GrantFlag> flags;
    final bool inherited;
    final GrantType type;

    Grant({
        required this.flags,
        required this.inherited,
        required this.type,
    });

    factory Grant.fromJson(Map<String, dynamic> json) => Grant(
        flags: List<GrantFlag>.from(json["flags"].map((x) => grantFlagValues.map[x]!)),
        inherited: json["inherited"],
        type: grantTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "flags": List<dynamic>.from(flags.map((x) => grantFlagValues.reverse[x])),
        "inherited": inherited,
        "type": grantTypeValues.reverse[type],
    };
}

enum GrantFlag {
    PUBLIC
}

final grantFlagValues = EnumValues({
    "public": GrantFlag.PUBLIC
});

enum GrantType {
    VIEWER
}

final grantTypeValues = EnumValues({
    "viewer": GrantType.VIEWER
});

class TopLevelMetadata {
    final List<DisplayType>? availableDisplayTypes;
    final CustomFields? customFields;
    final JsonQuery? jsonQuery;
    final String? rdfClass;
    final String? rdfSubject;
    final MetadataRenderTypeConfig? renderTypeConfig;
    final RichRendererConfigs? richRendererConfigs;
    final String? rowIdentifier;
    final String? rowLabel;
    final V1ArchivedProperties? v1ArchivedProperties;

    TopLevelMetadata({
        this.availableDisplayTypes,
        this.customFields,
        this.jsonQuery,
        this.rdfClass,
        this.rdfSubject,
        this.renderTypeConfig,
        this.richRendererConfigs,
        this.rowIdentifier,
        this.rowLabel,
        this.v1ArchivedProperties,
    });

    factory TopLevelMetadata.fromJson(Map<String, dynamic> json) => TopLevelMetadata(
        availableDisplayTypes: json["availableDisplayTypes"] == null ? null : List<DisplayType>.from(json["availableDisplayTypes"]!.map((x) => displayTypeValues.map[x]!)),
        customFields: json["custom_fields"] == null ? null : CustomFields.fromJson(json["custom_fields"]),
        jsonQuery: json["jsonQuery"] == null ? null : JsonQuery.fromJson(json["jsonQuery"]),
        rdfClass: json["rdfClass"],
        rdfSubject: json["rdfSubject"],
        renderTypeConfig: json["renderTypeConfig"] == null ? null : MetadataRenderTypeConfig.fromJson(json["renderTypeConfig"]),
        richRendererConfigs: json["richRendererConfigs"] == null ? null : RichRendererConfigs.fromJson(json["richRendererConfigs"]),
        rowIdentifier: json["rowIdentifier"],
        rowLabel: json["rowLabel"],
        v1ArchivedProperties: json["v1_archived_properties"] == null ? null : V1ArchivedProperties.fromJson(json["v1_archived_properties"]),
    );

    Map<String, dynamic> toJson() => {
        "availableDisplayTypes": availableDisplayTypes == null ? null : List<dynamic>.from(availableDisplayTypes!.map((x) => displayTypeValues.reverse[x])),
        "custom_fields": customFields?.toJson(),
        "jsonQuery": jsonQuery?.toJson(),
        "rdfClass": rdfClass,
        "rdfSubject": rdfSubject,
        "renderTypeConfig": renderTypeConfig?.toJson(),
        "richRendererConfigs": richRendererConfigs?.toJson(),
        "rowIdentifier": rowIdentifier,
        "rowLabel": rowLabel,
        "v1_archived_properties": v1ArchivedProperties?.toJson(),
    };
}

class CustomFields {
    final Test test;

    CustomFields({
        required this.test,
    });

    factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
        test: Test.fromJson(json["TEST"]),
    );

    Map<String, dynamic> toJson() => {
        "TEST": test.toJson(),
    };
}

class Test {
    final String cfpb1;

    Test({
        required this.cfpb1,
    });

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        cfpb1: json["CFPB1"],
    );

    Map<String, dynamic> toJson() => {
        "CFPB1": cfpb1,
    };
}

class JsonQuery {
    final List<Group>? group;
    final List<Order>? order;
    final List<Select>? select;
    final Where? where;

    JsonQuery({
        this.group,
        this.order,
        this.select,
        this.where,
    });

    factory JsonQuery.fromJson(Map<String, dynamic> json) => JsonQuery(
        group: json["group"] == null ? null : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
        order: json["order"] == null ? null : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
        select: json["select"] == null ? null : List<Select>.from(json["select"]!.map((x) => Select.fromJson(x))),
        where: json["where"] == null ? null : Where.fromJson(json["where"]),
    );

    Map<String, dynamic> toJson() => {
        "group": group == null ? null : List<dynamic>.from(group!.map((x) => x.toJson())),
        "order": order == null ? null : List<dynamic>.from(order!.map((x) => x.toJson())),
        "select": select == null ? null : List<dynamic>.from(select!.map((x) => x.toJson())),
        "where": where?.toJson(),
    };
}

class Group {
    final String columnFieldName;

    Group({
        required this.columnFieldName,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        columnFieldName: json["columnFieldName"],
    );

    Map<String, dynamic> toJson() => {
        "columnFieldName": columnFieldName,
    };
}

class Order {
    final bool ascending;
    final OrderColumnFieldName columnFieldName;

    Order({
        required this.ascending,
        required this.columnFieldName,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        ascending: json["ascending"],
        columnFieldName: orderColumnFieldNameValues.map[json["columnFieldName"]]!,
    );

    Map<String, dynamic> toJson() => {
        "ascending": ascending,
        "columnFieldName": orderColumnFieldNameValues.reverse[columnFieldName],
    };
}

enum OrderColumnFieldName {
    DATE_RECEIVED,
    AGREEMENT_DATE,
    IN_EFFECT_AS_OF_112012
}

final orderColumnFieldNameValues = EnumValues({
    "date_received": OrderColumnFieldName.DATE_RECEIVED,
    "agreement_date": OrderColumnFieldName.AGREEMENT_DATE,
    "in_effect_as_of_1_1_2012": OrderColumnFieldName.IN_EFFECT_AS_OF_112012
});

class Select {
    final String? aggregate;
    final String columnFieldName;

    Select({
        this.aggregate,
        required this.columnFieldName,
    });

    factory Select.fromJson(Map<String, dynamic> json) => Select(
        aggregate: json["aggregate"],
        columnFieldName: json["columnFieldName"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregate,
        "columnFieldName": columnFieldName,
    };
}

class Where {
    final List<Child>? children;
    final ChildColumnFieldName? columnFieldName;
    final ChildMetadata? metadata;
    final String? value;
    final WhereOperator whereOperator;

    Where({
        this.children,
        this.columnFieldName,
        this.metadata,
        this.value,
        required this.whereOperator,
    });

    factory Where.fromJson(Map<String, dynamic> json) => Where(
        children: json["children"] == null ? null : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
        columnFieldName: json["columnFieldName"] == null ? null : childColumnFieldNameValues.map[json["columnFieldName"]]!,
        metadata: json["metadata"] == null ? null : ChildMetadata.fromJson(json["metadata"]),
        value: json["value"],
        whereOperator: whereOperatorValues.map[json["operator"]]!,
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "columnFieldName": childColumnFieldNameValues.reverse[columnFieldName],
        "metadata": metadata?.toJson(),
        "value": value,
        "operator": whereOperatorValues.reverse[whereOperator],
    };
}

class Child {
    final ChildOperator childOperator;
    final ChildColumnFieldName columnFieldName;
    final ChildMetadata? metadata;
    final String? value;

    Child({
        required this.childOperator,
        required this.columnFieldName,
        this.metadata,
        this.value,
    });

    factory Child.fromJson(Map<String, dynamic> json) => Child(
        childOperator: childOperatorValues.map[json["operator"]]!,
        columnFieldName: childColumnFieldNameValues.map[json["columnFieldName"]]!,
        metadata: json["metadata"] == null ? null : ChildMetadata.fromJson(json["metadata"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "operator": childOperatorValues.reverse[childOperator],
        "columnFieldName": childColumnFieldNameValues.reverse[columnFieldName],
        "metadata": metadata?.toJson(),
        "value": value,
    };
}

enum ChildOperator {
    EQUALS,
    IS_NOT_BLANK
}

final childOperatorValues = EnumValues({
    "EQUALS": ChildOperator.EQUALS,
    "IS_NOT_BLANK": ChildOperator.IS_NOT_BLANK
});

enum ChildColumnFieldName {
    PRODUCT,
    COMPLAINT_WHAT_HAPPENED,
    SUB_PRODUCT,
    ISSUE
}

final childColumnFieldNameValues = EnumValues({
    "product": ChildColumnFieldName.PRODUCT,
    "complaint_what_happened": ChildColumnFieldName.COMPLAINT_WHAT_HAPPENED,
    "sub_product": ChildColumnFieldName.SUB_PRODUCT,
    "issue": ChildColumnFieldName.ISSUE
});

class ChildMetadata {
    final List<String>? customValues;
    final bool? freeform;
    final int? includeAuto;
    final MetadataOperator? metadataOperator;
    final TableColumnId? tableColumnId;
    final int? unifiedVersion;

    ChildMetadata({
        this.customValues,
        this.freeform,
        this.includeAuto,
        this.metadataOperator,
        this.tableColumnId,
        this.unifiedVersion,
    });

    factory ChildMetadata.fromJson(Map<String, dynamic> json) => ChildMetadata(
        customValues: json["customValues"] == null ? null : List<String>.from(json["customValues"]!.map((x) => x)),
        freeform: json["freeform"],
        includeAuto: json["includeAuto"],
        metadataOperator: json["operator"] == null ? null : metadataOperatorValues.map[json["operator"]]!,
        tableColumnId: json["tableColumnId"] == null ? null : TableColumnId.fromJson(json["tableColumnId"]),
        unifiedVersion: json["unifiedVersion"],
    );

    Map<String, dynamic> toJson() => {
        "customValues": customValues == null ? null : List<dynamic>.from(customValues!.map((x) => x)),
        "freeform": freeform,
        "includeAuto": includeAuto,
        "operator": metadataOperatorValues.reverse[metadataOperator],
        "tableColumnId": tableColumnId?.toJson(),
        "unifiedVersion": unifiedVersion,
    };
}

enum MetadataOperator {
    EQUALS,
    BLANK
}

final metadataOperatorValues = EnumValues({
    "EQUALS": MetadataOperator.EQUALS,
    "blank?": MetadataOperator.BLANK
});

class TableColumnId {
    final int the2819740;

    TableColumnId({
        required this.the2819740,
    });

    factory TableColumnId.fromJson(Map<String, dynamic> json) => TableColumnId(
        the2819740: json["2819740"],
    );

    Map<String, dynamic> toJson() => {
        "2819740": the2819740,
    };
}

enum WhereOperator {
    EQUALS,
    AND
}

final whereOperatorValues = EnumValues({
    "EQUALS": WhereOperator.EQUALS,
    "AND": WhereOperator.AND
});

class MetadataRenderTypeConfig {
    final PurpleVisible visible;

    MetadataRenderTypeConfig({
        required this.visible,
    });

    factory MetadataRenderTypeConfig.fromJson(Map<String, dynamic> json) => MetadataRenderTypeConfig(
        visible: PurpleVisible.fromJson(json["visible"]),
    );

    Map<String, dynamic> toJson() => {
        "visible": visible.toJson(),
    };
}

class PurpleVisible {
    final bool? fatrow;
    final bool? table;

    PurpleVisible({
        this.fatrow,
        this.table,
    });

    factory PurpleVisible.fromJson(Map<String, dynamic> json) => PurpleVisible(
        fatrow: json["fatrow"],
        table: json["table"],
    );

    Map<String, dynamic> toJson() => {
        "fatrow": fatrow,
        "table": table,
    };
}

class RichRendererConfigs {
    final FatRow fatRow;

    RichRendererConfigs({
        required this.fatRow,
    });

    factory RichRendererConfigs.fromJson(Map<String, dynamic> json) => RichRendererConfigs(
        fatRow: FatRow.fromJson(json["fatRow"]),
    );

    Map<String, dynamic> toJson() => {
        "fatRow": fatRow.toJson(),
    };
}

class FatRow {
    final List<Column> columns;

    FatRow({
        required this.columns,
    });

    factory FatRow.fromJson(Map<String, dynamic> json) => FatRow(
        columns: List<Column>.from(json["columns"].map((x) => Column.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "columns": List<dynamic>.from(columns.map((x) => x.toJson())),
    };
}

class Column {
    final List<Row> rows;
    final Styles styles;

    Column({
        required this.rows,
        required this.styles,
    });

    factory Column.fromJson(Map<String, dynamic> json) => Column(
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
        styles: Styles.fromJson(json["styles"]),
    );

    Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "styles": styles.toJson(),
    };
}

class Row {
    final List<Field> fields;

    Row({
        required this.fields,
    });

    factory Row.fromJson(Map<String, dynamic> json) => Row(
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
    };
}

class Field {
    final int tableColumnId;
    final FieldType type;

    Field({
        required this.tableColumnId,
        required this.type,
    });

    factory Field.fromJson(Map<String, dynamic> json) => Field(
        tableColumnId: json["tableColumnId"],
        type: fieldTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "tableColumnId": tableColumnId,
        "type": fieldTypeValues.reverse[type],
    };
}

enum FieldType {
    COLUMN_LABEL,
    COLUMN_DATA
}

final fieldTypeValues = EnumValues({
    "columnLabel": FieldType.COLUMN_LABEL,
    "columnData": FieldType.COLUMN_DATA
});

class Styles {
    final Width width;

    Styles({
        required this.width,
    });

    factory Styles.fromJson(Map<String, dynamic> json) => Styles(
        width: widthValues.map[json["width"]]!,
    );

    Map<String, dynamic> toJson() => {
        "width": widthValues.reverse[width],
    };
}

enum Width {
    THE_27,
    THE_40,
    THE_30,
    THE_33
}

final widthValues = EnumValues({
    "27%": Width.THE_27,
    "40%": Width.THE_40,
    "30%": Width.THE_30,
    "33%": Width.THE_33
});

class V1ArchivedProperties {
    final AccessPoints accessPoints;
    final String blistId;
    final V1ArchivedPropertiesRenderTypeConfig renderTypeConfig;

    V1ArchivedProperties({
        required this.accessPoints,
        required this.blistId,
        required this.renderTypeConfig,
    });

    factory V1ArchivedProperties.fromJson(Map<String, dynamic> json) => V1ArchivedProperties(
        accessPoints: AccessPoints.fromJson(json["accessPoints"]),
        blistId: json["blist_id"],
        renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig.fromJson(json["renderTypeConfig"]),
    );

    Map<String, dynamic> toJson() => {
        "accessPoints": accessPoints.toJson(),
        "blist_id": blistId,
        "renderTypeConfig": renderTypeConfig.toJson(),
    };
}

class AccessPoints {
    final String newView;

    AccessPoints({
        required this.newView,
    });

    factory AccessPoints.fromJson(Map<String, dynamic> json) => AccessPoints(
        newView: json["new_view"],
    );

    Map<String, dynamic> toJson() => {
        "new_view": newView,
    };
}

class V1ArchivedPropertiesRenderTypeConfig {
    final FluffyVisible visible;

    V1ArchivedPropertiesRenderTypeConfig({
        required this.visible,
    });

    factory V1ArchivedPropertiesRenderTypeConfig.fromJson(Map<String, dynamic> json) => V1ArchivedPropertiesRenderTypeConfig(
        visible: FluffyVisible.fromJson(json["visible"]),
    );

    Map<String, dynamic> toJson() => {
        "visible": visible.toJson(),
    };
}

class FluffyVisible {
    final bool href;

    FluffyVisible({
        required this.href,
    });

    factory FluffyVisible.fromJson(Map<String, dynamic> json) => FluffyVisible(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

enum ModifyingViewUid {
    S6_EW_H6_MP
}

final modifyingViewUidValues = EnumValues({
    "s6ew-h6mp": ModifyingViewUid.S6_EW_H6_MP
});

class Owner {
    final String displayName;
    final List<String>? flags;
    final String id;
    final int? lastNotificationSeenAt;
    final String? profileImageUrlLarge;
    final String? profileImageUrlMedium;
    final String? profileImageUrlSmall;
    final List<String>? rights;
    final RoleName? roleName;
    final String screenName;

    Owner({
        required this.displayName,
        this.flags,
        required this.id,
        this.lastNotificationSeenAt,
        this.profileImageUrlLarge,
        this.profileImageUrlMedium,
        this.profileImageUrlSmall,
        this.rights,
        this.roleName,
        required this.screenName,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        displayName: json["displayName"],
        flags: json["flags"] == null ? null : List<String>.from(json["flags"]!.map((x) => x)),
        id: json["id"],
        lastNotificationSeenAt: json["lastNotificationSeenAt"],
        profileImageUrlLarge: json["profileImageUrlLarge"],
        profileImageUrlMedium: json["profileImageUrlMedium"],
        profileImageUrlSmall: json["profileImageUrlSmall"],
        rights: json["rights"] == null ? null : List<String>.from(json["rights"]!.map((x) => x)),
        roleName: json["roleName"] == null ? null : roleNameValues.map[json["roleName"]]!,
        screenName: json["screenName"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "flags": flags == null ? null : List<dynamic>.from(flags!.map((x) => x)),
        "id": id,
        "lastNotificationSeenAt": lastNotificationSeenAt,
        "profileImageUrlLarge": profileImageUrlLarge,
        "profileImageUrlMedium": profileImageUrlMedium,
        "profileImageUrlSmall": profileImageUrlSmall,
        "rights": rights == null ? null : List<dynamic>.from(rights!.map((x) => x)),
        "roleName": roleNameValues.reverse[roleName],
        "screenName": screenName,
    };
}

enum RoleName {
    ADMINISTRATOR,
    PUBLISHER
}

final roleNameValues = EnumValues({
    "administrator": RoleName.ADMINISTRATOR,
    "publisher": RoleName.PUBLISHER
});

enum Provenance {
    OFFICIAL
}

final provenanceValues = EnumValues({
    "official": Provenance.OFFICIAL
});

enum PublicationStage {
    PUBLISHED
}

final publicationStageValues = EnumValues({
    "published": PublicationStage.PUBLISHED
});

class Ratings {
    final int rating;

    Ratings({
        required this.rating,
    });

    factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
    };
}

enum Right {
    READ
}

final rightValues = EnumValues({
    "read": Right.READ
});

enum RowsUpdatedBy {
    PJXG_VE4_M,
    THE_54_A3_QYUN,
    THE_9_E3_M_2843,
    VVCA_FR6_G
}

final rowsUpdatedByValues = EnumValues({
    "pjxg-ve4m": RowsUpdatedBy.PJXG_VE4_M,
    "54a3-qyun": RowsUpdatedBy.THE_54_A3_QYUN,
    "9e3m-2843": RowsUpdatedBy.THE_9_E3_M_2843,
    "vvca-fr6g": RowsUpdatedBy.VVCA_FR6_G
});

class TableAuthor {
    final String displayName;
    final String id;
    final List<String>? rights;
    final RoleName? roleName;
    final String screenName;

    TableAuthor({
        required this.displayName,
        required this.id,
        this.rights,
        this.roleName,
        required this.screenName,
    });

    factory TableAuthor.fromJson(Map<String, dynamic> json) => TableAuthor(
        displayName: json["displayName"],
        id: json["id"],
        rights: json["rights"] == null ? null : List<String>.from(json["rights"]!.map((x) => x)),
        roleName: json["roleName"] == null ? null : roleNameValues.map[json["roleName"]]!,
        screenName: json["screenName"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "id": id,
        "rights": rights == null ? null : List<dynamic>.from(rights!.map((x) => x)),
        "roleName": roleNameValues.reverse[roleName],
        "screenName": screenName,
    };
}

enum ViewType {
    TABULAR
}

final viewTypeValues = EnumValues({
    "tabular": ViewType.TABULAR
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
