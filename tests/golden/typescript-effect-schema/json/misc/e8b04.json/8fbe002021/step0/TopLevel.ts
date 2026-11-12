import * as S from "effect/Schema";


export const DisplayType = S.Literal(
    "table",
    "data_lens",
    "fatrow",
    "page",
);
export type DisplayType = S.Schema.Type<typeof DisplayType>;


export const TopLevelFlag = S.Literal(
    "default",
    "restorable",
    "restorePossibleForType",
);
export type TopLevelFlag = S.Schema.Type<typeof TopLevelFlag>;


export const GrantFlag = S.Literal(
    "public",
);
export type GrantFlag = S.Schema.Type<typeof GrantFlag>;


export const GrantType = S.Literal(
    "viewer",
);
export type GrantType = S.Schema.Type<typeof GrantType>;


export const OrderColumnFieldName = S.Literal(
    "date_received",
    "agreement_date",
    "in_effect_as_of_1_1_2012",
);
export type OrderColumnFieldName = S.Schema.Type<typeof OrderColumnFieldName>;


export const ChildColumnFieldName = S.Literal(
    "product",
    "complaint_what_happened",
    "sub_product",
    "issue",
);
export type ChildColumnFieldName = S.Schema.Type<typeof ChildColumnFieldName>;


export const MetadataOperator = S.Literal(
    "EQUALS",
    "blank?",
);
export type MetadataOperator = S.Schema.Type<typeof MetadataOperator>;


export const ChildOperator = S.Literal(
    "EQUALS",
    "IS_NOT_BLANK",
);
export type ChildOperator = S.Schema.Type<typeof ChildOperator>;


export const WhereOperator = S.Literal(
    "EQUALS",
    "AND",
);
export type WhereOperator = S.Schema.Type<typeof WhereOperator>;


export const FieldType = S.Literal(
    "columnLabel",
    "columnData",
);
export type FieldType = S.Schema.Type<typeof FieldType>;


export const Width = S.Literal(
    "27%",
    "40%",
    "30%",
    "33%",
);
export type Width = S.Schema.Type<typeof Width>;


export const ModifyingViewUid = S.Literal(
    "s6ew-h6mp",
);
export type ModifyingViewUid = S.Schema.Type<typeof ModifyingViewUid>;


export const RoleName = S.Literal(
    "administrator",
    "publisher",
);
export type RoleName = S.Schema.Type<typeof RoleName>;


export const Provenance = S.Literal(
    "official",
);
export type Provenance = S.Schema.Type<typeof Provenance>;


export const PublicationStage = S.Literal(
    "published",
);
export type PublicationStage = S.Schema.Type<typeof PublicationStage>;


export const Right = S.Literal(
    "read",
);
export type Right = S.Schema.Type<typeof Right>;


export const RowsUpdatedBy = S.Literal(
    "pjxg-ve4m",
    "54a3-qyun",
    "9e3m-2843",
    "vvca-fr6g",
);
export type RowsUpdatedBy = S.Schema.Type<typeof RowsUpdatedBy>;


export const ViewType = S.Literal(
    "tabular",
);
export type ViewType = S.Schema.Type<typeof ViewType>;

export class TableAuthor extends S.Class<TableAuthor>("TableAuthor")({
    "displayName": S.String,
    "id": S.String,
    "rights": S.optional(S.Array(S.String)),
    "roleName": S.optional(RoleName),
    "screenName": S.String,
}) {}

export class Ratings extends S.Class<Ratings>("Ratings")({
    "rating": S.Int,
}) {}

export class Owner extends S.Class<Owner>("Owner")({
    "displayName": S.String,
    "flags": S.optional(S.Array(S.String)),
    "id": S.String,
    "lastNotificationSeenAt": S.optional(S.Int),
    "profileImageUrlLarge": S.optional(S.String),
    "profileImageUrlMedium": S.optional(S.String),
    "profileImageUrlSmall": S.optional(S.String),
    "rights": S.optional(S.Array(S.String)),
    "roleName": S.optional(RoleName),
    "screenName": S.String,
}) {}

export class FluffyVisible extends S.Class<FluffyVisible>("FluffyVisible")({
    "href": S.Boolean,
}) {}

export class V1ArchivedPropertiesRenderTypeConfig extends S.Class<V1ArchivedPropertiesRenderTypeConfig>("V1ArchivedPropertiesRenderTypeConfig")({
    "visible": FluffyVisible,
}) {}

export class AccessPoints extends S.Class<AccessPoints>("AccessPoints")({
    "new_view": S.String,
}) {}

export class V1ArchivedProperties extends S.Class<V1ArchivedProperties>("V1ArchivedProperties")({
    "accessPoints": AccessPoints,
    "blist_id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "renderTypeConfig": V1ArchivedPropertiesRenderTypeConfig,
}) {}

export class Styles extends S.Class<Styles>("Styles")({
    "width": Width,
}) {}

export class Field extends S.Class<Field>("Field")({
    "tableColumnId": S.Int,
    "type": FieldType,
}) {}

export class Row extends S.Class<Row>("Row")({
    "fields": S.Array(Field),
}) {}

export class Column extends S.Class<Column>("Column")({
    "rows": S.Array(Row),
    "styles": Styles,
}) {}

export class FatRow extends S.Class<FatRow>("FatRow")({
    "columns": S.Array(Column),
}) {}

export class RichRendererConfigs extends S.Class<RichRendererConfigs>("RichRendererConfigs")({
    "fatRow": FatRow,
}) {}

export class PurpleVisible extends S.Class<PurpleVisible>("PurpleVisible")({
    "fatrow": S.optional(S.Boolean),
    "table": S.optional(S.Boolean),
}) {}

export class MetadataRenderTypeConfig extends S.Class<MetadataRenderTypeConfig>("MetadataRenderTypeConfig")({
    "visible": PurpleVisible,
}) {}

export class TableColumnId extends S.Class<TableColumnId>("TableColumnId")({
    "2819740": S.Int,
}) {}

export class ChildMetadata extends S.Class<ChildMetadata>("ChildMetadata")({
    "customValues": S.optional(S.Array(S.String)),
    "freeform": S.optional(S.Boolean),
    "includeAuto": S.optional(S.Int),
    "operator": S.optional(MetadataOperator),
    "tableColumnId": S.optional(TableColumnId),
    "unifiedVersion": S.optional(S.Int),
}) {}

export class Child extends S.Class<Child>("Child")({
    "columnFieldName": ChildColumnFieldName,
    "metadata": S.optional(ChildMetadata),
    "operator": ChildOperator,
    "value": S.optional(S.String),
}) {}

export class Where extends S.Class<Where>("Where")({
    "children": S.optional(S.Array(Child)),
    "columnFieldName": S.optional(ChildColumnFieldName),
    "metadata": S.optional(ChildMetadata),
    "operator": WhereOperator,
    "value": S.optional(S.String),
}) {}

export class Select extends S.Class<Select>("Select")({
    "aggregate": S.optional(S.String),
    "columnFieldName": S.String,
}) {}

export class Order extends S.Class<Order>("Order")({
    "ascending": S.Boolean,
    "columnFieldName": OrderColumnFieldName,
}) {}

export class Group extends S.Class<Group>("Group")({
    "columnFieldName": S.String,
}) {}

export class JsonQuery extends S.Class<JsonQuery>("JsonQuery")({
    "group": S.optional(S.Array(Group)),
    "order": S.optional(S.Array(Order)),
    "select": S.optional(S.Array(Select)),
    "where": S.optional(Where),
}) {}

export class Test extends S.Class<Test>("Test")({
    "CFPB1": S.String,
}) {}

export class CustomFields extends S.Class<CustomFields>("CustomFields")({
    "TEST": Test,
}) {}

export class TopLevelMetadata extends S.Class<TopLevelMetadata>("TopLevelMetadata")({
    "availableDisplayTypes": S.optional(S.Array(DisplayType)),
    "custom_fields": S.optional(CustomFields),
    "jsonQuery": S.optional(JsonQuery),
    "rdfClass": S.optional(S.String),
    "rdfSubject": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "renderTypeConfig": S.optional(MetadataRenderTypeConfig),
    "richRendererConfigs": S.optional(RichRendererConfigs),
    "rowIdentifier": S.optional(S.String),
    "rowLabel": S.optional(S.String),
    "v1_archived_properties": S.optional(V1ArchivedProperties),
}) {}

export class Grant extends S.Class<Grant>("Grant")({
    "flags": S.Array(GrantFlag),
    "inherited": S.Boolean,
    "type": GrantType,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "averageRating": S.Int,
    "category": S.optional(S.String),
    "createdAt": S.Int,
    "description": S.optional(S.String),
    "displayType": S.optional(DisplayType),
    "downloadCount": S.Int,
    "flags": S.optional(S.Array(TopLevelFlag)),
    "grants": S.Array(Grant),
    "hideFromCatalog": S.Boolean,
    "hideFromDataJson": S.Boolean,
    "id": S.String,
    "indexUpdatedAt": S.optional(S.Int),
    "locale": S.String,
    "metadata": TopLevelMetadata,
    "moderationStatus": S.optional(S.Boolean),
    "modifyingViewUid": S.optional(ModifyingViewUid),
    "name": S.String,
    "newBackend": S.Boolean,
    "numberOfComments": S.Int,
    "oid": S.Int,
    "owner": Owner,
    "provenance": Provenance,
    "publicationAppendEnabled": S.Boolean,
    "publicationDate": S.optional(S.Int),
    "publicationGroup": S.Int,
    "publicationStage": PublicationStage,
    "ratings": S.optional(Ratings),
    "resourceName": S.optional(S.String),
    "rights": S.Array(Right),
    "rowClass": S.optional(S.String),
    "rowIdentifierColumnId": S.optional(S.Int),
    "rowsUpdatedAt": S.optional(S.Int),
    "rowsUpdatedBy": S.optional(RowsUpdatedBy),
    "tableAuthor": TableAuthor,
    "tableId": S.Int,
    "tags": S.optional(S.Array(S.String)),
    "totalTimesRated": S.Int,
    "viewCount": S.Int,
    "viewLastModified": S.Int,
    "viewType": ViewType,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
