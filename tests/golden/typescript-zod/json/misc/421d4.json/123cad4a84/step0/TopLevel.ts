import * as z from "zod";


export const TopSchema = z.object({
    "count": z.number().int(),
    "item": z.string(),
});
export type Top = z.infer<typeof TopSchema>;

export const QuerySchema = z.object({
});
export type Query = z.infer<typeof QuerySchema>;

export const GrantSchema = z.object({
    "flags": z.array(z.string()),
    "inherited": z.boolean(),
    "type": z.string(),
});
export type Grant = z.infer<typeof GrantSchema>;

export const LicenseSchema = z.object({
    "name": z.string(),
});
export type License = z.infer<typeof LicenseSchema>;

export const VisibleSchema = z.object({
    "table": z.boolean(),
});
export type Visible = z.infer<typeof VisibleSchema>;

export const OwnerSchema = z.object({
    "displayName": z.string(),
    "id": z.string(),
    "screenName": z.string(),
});
export type Owner = z.infer<typeof OwnerSchema>;

export const CachedContentsSchema = z.object({
    "average": z.string().optional(),
    "largest": z.string().optional(),
    "non_null": z.number().int(),
    "null": z.number().int(),
    "smallest": z.string().optional(),
    "sum": z.string().regex(/^-?\d+$/).optional(),
    "top": z.array(TopSchema).optional(),
});
export type CachedContents = z.infer<typeof CachedContentsSchema>;

export const RenderTypeConfigSchema = z.object({
    "visible": VisibleSchema,
});
export type RenderTypeConfig = z.infer<typeof RenderTypeConfigSchema>;

export const ColumnSchema = z.object({
    "cachedContents": CachedContentsSchema.optional(),
    "dataTypeName": z.string(),
    "fieldName": z.string(),
    "flags": z.array(z.string()).optional(),
    "format": QuerySchema,
    "id": z.number().int(),
    "name": z.string(),
    "position": z.number().int(),
    "renderTypeName": z.string(),
    "tableColumnId": z.number().int().optional(),
    "width": z.number().int().optional(),
});
export type Column = z.infer<typeof ColumnSchema>;

export const MetadataSchema = z.object({
    "availableDisplayTypes": z.array(z.string()),
    "rdfClass": z.string(),
    "rdfSubject": z.string().regex(/^-?\d+$/),
    "renderTypeConfig": RenderTypeConfigSchema,
    "rowIdentifier": z.string().regex(/^-?\d+$/),
});
export type Metadata = z.infer<typeof MetadataSchema>;

export const ViewSchema = z.object({
    "attribution": z.string(),
    "averageRating": z.number().int(),
    "category": z.string(),
    "columns": z.array(ColumnSchema),
    "createdAt": z.number().int(),
    "description": z.string(),
    "displayType": z.string(),
    "downloadCount": z.number().int(),
    "flags": z.array(z.string()),
    "grants": z.array(GrantSchema),
    "hideFromCatalog": z.boolean(),
    "hideFromDataJson": z.boolean(),
    "id": z.string(),
    "indexUpdatedAt": z.number().int(),
    "license": LicenseSchema,
    "licenseId": z.string(),
    "locale": z.string(),
    "metadata": MetadataSchema,
    "name": z.string(),
    "newBackend": z.boolean(),
    "numberOfComments": z.number().int(),
    "oid": z.number().int(),
    "owner": OwnerSchema,
    "provenance": z.string(),
    "publicationAppendEnabled": z.boolean(),
    "publicationDate": z.number().int(),
    "publicationGroup": z.number().int(),
    "publicationStage": z.string(),
    "query": QuerySchema,
    "rights": z.array(z.string()),
    "rowClass": z.string(),
    "rowsUpdatedAt": z.number().int(),
    "rowsUpdatedBy": z.string(),
    "tableAuthor": OwnerSchema,
    "tableId": z.number().int(),
    "tags": z.array(z.string()),
    "totalTimesRated": z.number().int(),
    "viewCount": z.number().int(),
    "viewLastModified": z.number().int(),
    "viewType": z.string(),
});
export type View = z.infer<typeof ViewSchema>;

export const MetaSchema = z.object({
    "view": ViewSchema,
});
export type Meta = z.infer<typeof MetaSchema>;

export const TopLevelSchema = z.object({
    "data": z.array(z.array(z.union([z.null(), z.number().int(), z.string()]))),
    "meta": MetaSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
