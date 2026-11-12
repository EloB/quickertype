import * as z from "zod";


export const DisplayTypeSchema = z.enum([
    "table",
    "data_lens",
    "fatrow",
    "page",
]);
export type DisplayType = z.infer<typeof DisplayTypeSchema>;


export const TopLevelFlagSchema = z.enum([
    "default",
    "restorable",
    "restorePossibleForType",
]);
export type TopLevelFlag = z.infer<typeof TopLevelFlagSchema>;


export const GrantFlagSchema = z.enum([
    "public",
]);
export type GrantFlag = z.infer<typeof GrantFlagSchema>;


export const GrantTypeSchema = z.enum([
    "viewer",
]);
export type GrantType = z.infer<typeof GrantTypeSchema>;


export const OrderColumnFieldNameSchema = z.enum([
    "date_received",
    "agreement_date",
    "in_effect_as_of_1_1_2012",
]);
export type OrderColumnFieldName = z.infer<typeof OrderColumnFieldNameSchema>;


export const ChildColumnFieldNameSchema = z.enum([
    "product",
    "complaint_what_happened",
    "sub_product",
    "issue",
]);
export type ChildColumnFieldName = z.infer<typeof ChildColumnFieldNameSchema>;


export const MetadataOperatorSchema = z.enum([
    "EQUALS",
    "blank?",
]);
export type MetadataOperator = z.infer<typeof MetadataOperatorSchema>;


export const ChildOperatorSchema = z.enum([
    "EQUALS",
    "IS_NOT_BLANK",
]);
export type ChildOperator = z.infer<typeof ChildOperatorSchema>;


export const WhereOperatorSchema = z.enum([
    "EQUALS",
    "AND",
]);
export type WhereOperator = z.infer<typeof WhereOperatorSchema>;


export const FieldTypeSchema = z.enum([
    "columnLabel",
    "columnData",
]);
export type FieldType = z.infer<typeof FieldTypeSchema>;


export const WidthSchema = z.enum([
    "27%",
    "40%",
    "30%",
    "33%",
]);
export type Width = z.infer<typeof WidthSchema>;


export const ModifyingViewUidSchema = z.enum([
    "s6ew-h6mp",
]);
export type ModifyingViewUid = z.infer<typeof ModifyingViewUidSchema>;


export const RoleNameSchema = z.enum([
    "administrator",
    "publisher",
]);
export type RoleName = z.infer<typeof RoleNameSchema>;


export const ProvenanceSchema = z.enum([
    "official",
]);
export type Provenance = z.infer<typeof ProvenanceSchema>;


export const PublicationStageSchema = z.enum([
    "published",
]);
export type PublicationStage = z.infer<typeof PublicationStageSchema>;


export const RightSchema = z.enum([
    "read",
]);
export type Right = z.infer<typeof RightSchema>;


export const RowsUpdatedBySchema = z.enum([
    "pjxg-ve4m",
    "54a3-qyun",
    "9e3m-2843",
    "vvca-fr6g",
]);
export type RowsUpdatedBy = z.infer<typeof RowsUpdatedBySchema>;


export const ViewTypeSchema = z.enum([
    "tabular",
]);
export type ViewType = z.infer<typeof ViewTypeSchema>;

export const GrantSchema = z.object({
    "flags": z.array(GrantFlagSchema),
    "inherited": z.boolean(),
    "type": GrantTypeSchema,
});
export type Grant = z.infer<typeof GrantSchema>;

export const TestSchema = z.object({
    "CFPB1": z.string(),
});
export type Test = z.infer<typeof TestSchema>;

export const GroupSchema = z.object({
    "columnFieldName": z.string(),
});
export type Group = z.infer<typeof GroupSchema>;

export const OrderSchema = z.object({
    "ascending": z.boolean(),
    "columnFieldName": OrderColumnFieldNameSchema,
});
export type Order = z.infer<typeof OrderSchema>;

export const SelectSchema = z.object({
    "aggregate": z.string().optional(),
    "columnFieldName": z.string(),
});
export type Select = z.infer<typeof SelectSchema>;

export const TableColumnIdSchema = z.object({
    "2819740": z.number().int(),
});
export type TableColumnId = z.infer<typeof TableColumnIdSchema>;

export const PurpleVisibleSchema = z.object({
    "fatrow": z.boolean().optional(),
    "table": z.boolean().optional(),
});
export type PurpleVisible = z.infer<typeof PurpleVisibleSchema>;

export const FieldSchema = z.object({
    "tableColumnId": z.number().int(),
    "type": FieldTypeSchema,
});
export type Field = z.infer<typeof FieldSchema>;

export const StylesSchema = z.object({
    "width": WidthSchema,
});
export type Styles = z.infer<typeof StylesSchema>;

export const AccessPointsSchema = z.object({
    "new_view": z.string(),
});
export type AccessPoints = z.infer<typeof AccessPointsSchema>;

export const FluffyVisibleSchema = z.object({
    "href": z.boolean(),
});
export type FluffyVisible = z.infer<typeof FluffyVisibleSchema>;

export const OwnerSchema = z.object({
    "displayName": z.string(),
    "flags": z.array(z.string()).optional(),
    "id": z.string(),
    "lastNotificationSeenAt": z.number().int().optional(),
    "profileImageUrlLarge": z.string().optional(),
    "profileImageUrlMedium": z.string().optional(),
    "profileImageUrlSmall": z.string().optional(),
    "rights": z.array(z.string()).optional(),
    "roleName": RoleNameSchema.optional(),
    "screenName": z.string(),
});
export type Owner = z.infer<typeof OwnerSchema>;

export const RatingsSchema = z.object({
    "rating": z.number().int(),
});
export type Ratings = z.infer<typeof RatingsSchema>;

export const TableAuthorSchema = z.object({
    "displayName": z.string(),
    "id": z.string(),
    "rights": z.array(z.string()).optional(),
    "roleName": RoleNameSchema.optional(),
    "screenName": z.string(),
});
export type TableAuthor = z.infer<typeof TableAuthorSchema>;

export const CustomFieldsSchema = z.object({
    "TEST": TestSchema,
});
export type CustomFields = z.infer<typeof CustomFieldsSchema>;

export const ChildMetadataSchema = z.object({
    "customValues": z.array(z.string()).optional(),
    "freeform": z.boolean().optional(),
    "includeAuto": z.number().int().optional(),
    "operator": MetadataOperatorSchema.optional(),
    "tableColumnId": TableColumnIdSchema.optional(),
    "unifiedVersion": z.number().int().optional(),
});
export type ChildMetadata = z.infer<typeof ChildMetadataSchema>;

export const MetadataRenderTypeConfigSchema = z.object({
    "visible": PurpleVisibleSchema,
});
export type MetadataRenderTypeConfig = z.infer<typeof MetadataRenderTypeConfigSchema>;

export const RowSchema = z.object({
    "fields": z.array(FieldSchema),
});
export type Row = z.infer<typeof RowSchema>;

export const V1ArchivedPropertiesRenderTypeConfigSchema = z.object({
    "visible": FluffyVisibleSchema,
});
export type V1ArchivedPropertiesRenderTypeConfig = z.infer<typeof V1ArchivedPropertiesRenderTypeConfigSchema>;

export const ChildSchema = z.object({
    "columnFieldName": ChildColumnFieldNameSchema,
    "metadata": ChildMetadataSchema.optional(),
    "operator": ChildOperatorSchema,
    "value": z.string().optional(),
});
export type Child = z.infer<typeof ChildSchema>;

export const ColumnSchema = z.object({
    "rows": z.array(RowSchema),
    "styles": StylesSchema,
});
export type Column = z.infer<typeof ColumnSchema>;

export const V1ArchivedPropertiesSchema = z.object({
    "accessPoints": AccessPointsSchema,
    "blist_id": z.string().regex(/^-?\d+$/),
    "renderTypeConfig": V1ArchivedPropertiesRenderTypeConfigSchema,
});
export type V1ArchivedProperties = z.infer<typeof V1ArchivedPropertiesSchema>;

export const WhereSchema = z.object({
    "children": z.array(ChildSchema).optional(),
    "columnFieldName": ChildColumnFieldNameSchema.optional(),
    "metadata": ChildMetadataSchema.optional(),
    "operator": WhereOperatorSchema,
    "value": z.string().optional(),
});
export type Where = z.infer<typeof WhereSchema>;

export const FatRowSchema = z.object({
    "columns": z.array(ColumnSchema),
});
export type FatRow = z.infer<typeof FatRowSchema>;

export const JsonQuerySchema = z.object({
    "group": z.array(GroupSchema).optional(),
    "order": z.array(OrderSchema).optional(),
    "select": z.array(SelectSchema).optional(),
    "where": WhereSchema.optional(),
});
export type JsonQuery = z.infer<typeof JsonQuerySchema>;

export const RichRendererConfigsSchema = z.object({
    "fatRow": FatRowSchema,
});
export type RichRendererConfigs = z.infer<typeof RichRendererConfigsSchema>;

export const TopLevelMetadataSchema = z.object({
    "availableDisplayTypes": z.array(DisplayTypeSchema).optional(),
    "custom_fields": CustomFieldsSchema.optional(),
    "jsonQuery": JsonQuerySchema.optional(),
    "rdfClass": z.string().optional(),
    "rdfSubject": z.string().regex(/^-?\d+$/).optional(),
    "renderTypeConfig": MetadataRenderTypeConfigSchema.optional(),
    "richRendererConfigs": RichRendererConfigsSchema.optional(),
    "rowIdentifier": z.string().optional(),
    "rowLabel": z.string().optional(),
    "v1_archived_properties": V1ArchivedPropertiesSchema.optional(),
});
export type TopLevelMetadata = z.infer<typeof TopLevelMetadataSchema>;

export const TopLevelElementSchema = z.object({
    "averageRating": z.number().int(),
    "category": z.string().optional(),
    "createdAt": z.number().int(),
    "description": z.string().optional(),
    "displayType": DisplayTypeSchema.optional(),
    "downloadCount": z.number().int(),
    "flags": z.array(TopLevelFlagSchema).optional(),
    "grants": z.array(GrantSchema),
    "hideFromCatalog": z.boolean(),
    "hideFromDataJson": z.boolean(),
    "id": z.string(),
    "indexUpdatedAt": z.number().int().optional(),
    "locale": z.string(),
    "metadata": TopLevelMetadataSchema,
    "moderationStatus": z.boolean().optional(),
    "modifyingViewUid": ModifyingViewUidSchema.optional(),
    "name": z.string(),
    "newBackend": z.boolean(),
    "numberOfComments": z.number().int(),
    "oid": z.number().int(),
    "owner": OwnerSchema,
    "provenance": ProvenanceSchema,
    "publicationAppendEnabled": z.boolean(),
    "publicationDate": z.number().int().optional(),
    "publicationGroup": z.number().int(),
    "publicationStage": PublicationStageSchema,
    "ratings": RatingsSchema.optional(),
    "resourceName": z.string().optional(),
    "rights": z.array(RightSchema),
    "rowClass": z.string().optional(),
    "rowIdentifierColumnId": z.number().int().optional(),
    "rowsUpdatedAt": z.number().int().optional(),
    "rowsUpdatedBy": RowsUpdatedBySchema.optional(),
    "tableAuthor": TableAuthorSchema,
    "tableId": z.number().int(),
    "tags": z.array(z.string()).optional(),
    "totalTimesRated": z.number().int(),
    "viewCount": z.number().int(),
    "viewLastModified": z.number().int(),
    "viewType": ViewTypeSchema,
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
