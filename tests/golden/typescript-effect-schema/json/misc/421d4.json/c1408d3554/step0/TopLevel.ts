import * as S from "effect/Schema";


export class Owner extends S.Class<Owner>("Owner")({
    "displayName": S.String,
    "id": S.String,
    "screenName": S.String,
}) {}

export class Visible extends S.Class<Visible>("Visible")({
    "table": S.Boolean,
}) {}

export class RenderTypeConfig extends S.Class<RenderTypeConfig>("RenderTypeConfig")({
    "visible": Visible,
}) {}

export class Metadata extends S.Class<Metadata>("Metadata")({
    "availableDisplayTypes": S.Array(S.String),
    "rdfClass": S.String,
    "rdfSubject": S.String.pipe(S.pattern(/^-?\d+$/)),
    "renderTypeConfig": RenderTypeConfig,
    "rowIdentifier": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class License extends S.Class<License>("License")({
    "name": S.String,
}) {}

export class Grant extends S.Class<Grant>("Grant")({
    "flags": S.Array(S.String),
    "inherited": S.Boolean,
    "type": S.String,
}) {}

export class Query extends S.Class<Query>("Query")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class Top extends S.Class<Top>("Top")({
    "count": S.Int,
    "item": S.String,
}) {}

export class CachedContents extends S.Class<CachedContents>("CachedContents")({
    "average": S.optional(S.String),
    "largest": S.optional(S.String),
    "non_null": S.Int,
    "null": S.Int,
    "smallest": S.optional(S.String),
    "sum": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "top": S.optional(S.Array(Top)),
}) {}

export class Column extends S.Class<Column>("Column")({
    "cachedContents": S.optional(CachedContents),
    "dataTypeName": S.String,
    "fieldName": S.String,
    "flags": S.optional(S.Array(S.String)),
    "format": Query,
    "id": S.Int,
    "name": S.String,
    "position": S.Int,
    "renderTypeName": S.String,
    "tableColumnId": S.optional(S.Int),
    "width": S.optional(S.Int),
}) {}

export class View extends S.Class<View>("View")({
    "attribution": S.String,
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
    "license": License,
    "licenseId": S.String,
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
    "rowClass": S.String,
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
