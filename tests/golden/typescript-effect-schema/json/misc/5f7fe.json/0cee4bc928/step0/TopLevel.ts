import * as S from "effect/Schema";


export const TypeName = S.Literal(
    "meta_data",
    "calendar_date",
    "text",
);
export type TypeName = S.Schema.Type<typeof TypeName>;

export class Expression extends S.Class<Expression>("Expression")({
    "columnId": S.Int,
    "type": S.String,
}) {}

export class OrderBy extends S.Class<OrderBy>("OrderBy")({
    "ascending": S.Boolean,
    "expression": Expression,
}) {}

export class Query extends S.Class<Query>("Query")({
    "orderBys": S.Array(OrderBy),
}) {}

export class Owner extends S.Class<Owner>("Owner")({
    "displayName": S.String,
    "id": S.String,
    "profileImageUrlLarge": S.String,
    "profileImageUrlMedium": S.String,
    "profileImageUrlSmall": S.String,
    "rights": S.Array(S.String),
    "roleName": S.String,
    "screenName": S.String,
}) {}

export class Visible extends S.Class<Visible>("Visible")({
    "table": S.Boolean,
}) {}

export class RenderTypeConfig extends S.Class<RenderTypeConfig>("RenderTypeConfig")({
    "visible": Visible,
}) {}

export class Order extends S.Class<Order>("Order")({
    "ascending": S.Boolean,
    "columnFieldName": S.String,
}) {}

export class JsonQuery extends S.Class<JsonQuery>("JsonQuery")({
    "order": S.Array(Order),
}) {}

export class Notes extends S.Class<Notes>("Notes")({
    "Notes": S.String,
}) {}

export class DatasetSummary extends S.Class<DatasetSummary>("DatasetSummary")({
    "Contact Information": S.String,
    "Coverage": S.String,
    "Data Frequency": S.String,
    "Dataset Owner": S.String,
    "Granularity": S.String,
    "Organization": S.String,
    "Posting Frequency": S.String,
    "Time Period": S.String,
    "Units": S.String,
}) {}

export class DatasetInformation extends S.Class<DatasetInformation>("DatasetInformation")({
    "Agency": S.String,
}) {}

export class CommonCore extends S.Class<CommonCore>("CommonCore")({
    "Contact Email": S.String,
    "Contact Name": S.String,
    "Publisher": S.String,
}) {}

export class AdditionalResources extends S.Class<AdditionalResources>("AdditionalResources")({
    "See Also ": S.String,
    "See Also": S.String,
}) {}

export class CustomFields extends S.Class<CustomFields>("CustomFields")({
    "Additional Resources": AdditionalResources,
    "Common Core": CommonCore,
    "Dataset Information": DatasetInformation,
    "Dataset Summary": DatasetSummary,
    "Notes": Notes,
}) {}

export class Attachment extends S.Class<Attachment>("Attachment")({
    "assetId": S.String,
    "blobId": S.String,
    "filename": S.String,
    "name": S.String,
}) {}

export class Metadata extends S.Class<Metadata>("Metadata")({
    "attachments": S.Array(Attachment),
    "availableDisplayTypes": S.Array(S.String),
    "custom_fields": CustomFields,
    "jsonQuery": JsonQuery,
    "rdfSubject": S.String.pipe(S.pattern(/^-?\d+$/)),
    "renderTypeConfig": RenderTypeConfig,
}) {}

export class Grant extends S.Class<Grant>("Grant")({
    "flags": S.Array(S.String),
    "inherited": S.Boolean,
    "type": S.String,
}) {}

export class Format extends S.Class<Format>("Format")({
    "align": S.optional(S.String),
    "view": S.optional(S.String),
}) {}

export class Top extends S.Class<Top>("Top")({
    "count": S.Int,
    "item": S.String,
}) {}

export class CachedContents extends S.Class<CachedContents>("CachedContents")({
    "largest": S.String,
    "non_null": S.Int,
    "null": S.Int,
    "smallest": S.String,
    "top": S.Array(Top),
}) {}

export class Column extends S.Class<Column>("Column")({
    "cachedContents": S.optional(CachedContents),
    "dataTypeName": TypeName,
    "fieldName": S.String,
    "flags": S.optional(S.Array(S.String)),
    "format": Format,
    "id": S.Int,
    "name": S.String,
    "position": S.Int,
    "renderTypeName": TypeName,
    "tableColumnId": S.optional(S.Int),
    "width": S.optional(S.Int),
}) {}

export class View extends S.Class<View>("View")({
    "attribution": S.String,
    "attributionLink": S.String,
    "averageRating": S.Int,
    "category": S.String,
    "columns": S.Array(Column),
    "createdAt": S.Int,
    "description": S.String,
    "displayType": S.String,
    "downloadCount": S.Int,
    "flags": S.Array(S.String),
    "grants": S.Array(Grant),
    "hideFromCatalog": S.Boolean,
    "hideFromDataJson": S.Boolean,
    "id": S.String,
    "indexUpdatedAt": S.Int,
    "locale": S.String,
    "metadata": Metadata,
    "name": S.String,
    "newBackend": S.Boolean,
    "numberOfComments": S.Int,
    "oid": S.Int,
    "owner": Owner,
    "provenance": S.String,
    "publicationAppendEnabled": S.Boolean,
    "publicationDate": S.Int,
    "publicationGroup": S.Int,
    "publicationStage": S.String,
    "query": Query,
    "rights": S.Array(S.String),
    "rowsUpdatedAt": S.Int,
    "rowsUpdatedBy": S.String,
    "tableAuthor": Owner,
    "tableId": S.Int,
    "tags": S.Array(S.String),
    "totalTimesRated": S.Int,
    "viewCount": S.Int,
    "viewLastModified": S.Int,
    "viewType": S.String,
}) {}

export class Meta extends S.Class<Meta>("Meta")({
    "view": View,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": S.Array(S.Array(S.Union(S.Int, S.String, S.Null))),
    "meta": Meta,
}) {}
