import * as z from "zod";


export const TypeNameSchema = z.enum([
    "meta_data",
    "calendar_date",
    "text",
]);
export type TypeName = z.infer<typeof TypeNameSchema>;

export const TopSchema = z.object({
    "count": z.number().int(),
    "item": z.string(),
});
export type Top = z.infer<typeof TopSchema>;

export const FormatSchema = z.object({
    "align": z.string().optional(),
    "view": z.string().optional(),
});
export type Format = z.infer<typeof FormatSchema>;

export const GrantSchema = z.object({
    "flags": z.array(z.string()),
    "inherited": z.boolean(),
    "type": z.string(),
});
export type Grant = z.infer<typeof GrantSchema>;

export const AttachmentSchema = z.object({
    "assetId": z.string(),
    "blobId": z.string(),
    "filename": z.string(),
    "name": z.string(),
});
export type Attachment = z.infer<typeof AttachmentSchema>;

export const AdditionalResourcesSchema = z.object({
    "See Also": z.string(),
});
export type AdditionalResources = z.infer<typeof AdditionalResourcesSchema>;

export const CommonCoreSchema = z.object({
    "Contact Email": z.string(),
    "Contact Name": z.string(),
    "Publisher": z.string(),
});
export type CommonCore = z.infer<typeof CommonCoreSchema>;

export const DatasetInformationSchema = z.object({
    "Agency": z.string(),
});
export type DatasetInformation = z.infer<typeof DatasetInformationSchema>;

export const DatasetSummarySchema = z.object({
    "Contact Information": z.string(),
    "Coverage": z.string(),
    "Data Frequency": z.string(),
    "Dataset Owner": z.string(),
    "Granularity": z.string(),
    "Organization": z.string(),
    "Posting Frequency": z.string(),
    "Time Period": z.string(),
});
export type DatasetSummary = z.infer<typeof DatasetSummarySchema>;

export const NotesSchema = z.object({
    "Notes": z.string(),
});
export type Notes = z.infer<typeof NotesSchema>;

export const OrderSchema = z.object({
    "ascending": z.boolean(),
    "columnFieldName": z.string(),
});
export type Order = z.infer<typeof OrderSchema>;

export const VisibleSchema = z.object({
    "table": z.boolean(),
});
export type Visible = z.infer<typeof VisibleSchema>;

export const OwnerSchema = z.object({
    "displayName": z.string(),
    "id": z.string(),
    "profileImageUrlLarge": z.string(),
    "profileImageUrlMedium": z.string(),
    "profileImageUrlSmall": z.string(),
    "rights": z.array(z.string()),
    "roleName": z.string(),
    "screenName": z.string(),
});
export type Owner = z.infer<typeof OwnerSchema>;

export const ExpressionSchema = z.object({
    "columnId": z.number().int(),
    "type": z.string(),
});
export type Expression = z.infer<typeof ExpressionSchema>;

export const CachedContentsSchema = z.object({
    "largest": z.string(),
    "non_null": z.number().int(),
    "null": z.number().int(),
    "smallest": z.string(),
    "top": z.array(TopSchema),
});
export type CachedContents = z.infer<typeof CachedContentsSchema>;

export const CustomFieldsSchema = z.object({
    "Additional Resources": AdditionalResourcesSchema,
    "Common Core": CommonCoreSchema,
    "Dataset Information": DatasetInformationSchema,
    "Dataset Summary": DatasetSummarySchema,
    "Notes": NotesSchema,
});
export type CustomFields = z.infer<typeof CustomFieldsSchema>;

export const JsonQuerySchema = z.object({
    "order": z.array(OrderSchema),
});
export type JsonQuery = z.infer<typeof JsonQuerySchema>;

export const RenderTypeConfigSchema = z.object({
    "visible": VisibleSchema,
});
export type RenderTypeConfig = z.infer<typeof RenderTypeConfigSchema>;

export const OrderBySchema = z.object({
    "ascending": z.boolean(),
    "expression": ExpressionSchema,
});
export type OrderBy = z.infer<typeof OrderBySchema>;

export const ColumnSchema = z.object({
    "cachedContents": CachedContentsSchema.optional(),
    "dataTypeName": TypeNameSchema,
    "description": z.string().optional(),
    "fieldName": z.string(),
    "flags": z.array(z.string()).optional(),
    "format": FormatSchema,
    "id": z.number().int(),
    "name": z.string(),
    "position": z.number().int(),
    "renderTypeName": TypeNameSchema,
    "tableColumnId": z.number().int().optional(),
    "width": z.number().int().optional(),
});
export type Column = z.infer<typeof ColumnSchema>;

export const MetadataSchema = z.object({
    "attachments": z.array(AttachmentSchema),
    "availableDisplayTypes": z.array(z.string()),
    "custom_fields": CustomFieldsSchema,
    "jsonQuery": JsonQuerySchema,
    "rdfSubject": z.string().regex(/^-?\d+$/),
    "renderTypeConfig": RenderTypeConfigSchema,
});
export type Metadata = z.infer<typeof MetadataSchema>;

export const QuerySchema = z.object({
    "orderBys": z.array(OrderBySchema),
});
export type Query = z.infer<typeof QuerySchema>;

export const ViewSchema = z.object({
    "attribution": z.string(),
    "attributionLink": z.string(),
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
