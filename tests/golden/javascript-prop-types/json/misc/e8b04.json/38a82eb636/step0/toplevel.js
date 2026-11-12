// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Grant;
let _TopLevelMetadata;
let _CustomFields;
let _Test;
let _JSONQuery;
let _Group;
let _Order;
let _Select;
let _Where;
let _Child;
let _ChildMetadata;
let _TableColumnID;
let _MetadataRenderTypeConfig;
let _PurpleVisible;
let _RichRendererConfigs;
let _FatRow;
let _Column;
let _Row;
let _Field;
let _Styles;
let _V1ArchivedProperties;
let _AccessPoints;
let _V1ArchivedPropertiesRenderTypeConfig;
let _FluffyVisible;
let _Owner;
let _Ratings;
let _TableAuthor;
const _DisplayType = PropTypes.oneOf(['table', 'data_lens', 'fatrow', 'page']);
const _TopLevelFlag = PropTypes.oneOf(['default', 'restorable', 'restorePossibleForType']);
const _GrantFlag = PropTypes.oneOf(['public']);
const _GrantType = PropTypes.oneOf(['viewer']);
const _OrderColumnFieldName = PropTypes.oneOf(['date_received', 'agreement_date', 'in_effect_as_of_1_1_2012']);
const _ChildColumnFieldName = PropTypes.oneOf(['product', 'complaint_what_happened', 'sub_product', 'issue']);
const _MetadataOperator = PropTypes.oneOf(['EQUALS', 'blank?']);
const _ChildOperator = PropTypes.oneOf(['EQUALS', 'IS_NOT_BLANK']);
const _WhereOperator = PropTypes.oneOf(['EQUALS', 'AND']);
const _FieldType = PropTypes.oneOf(['columnLabel', 'columnData']);
const _Width = PropTypes.oneOf(['27%', '40%', '30%', '33%']);
const _ModifyingViewUid = PropTypes.oneOf(['s6ew-h6mp']);
const _RoleName = PropTypes.oneOf(['administrator', 'publisher']);
const _Provenance = PropTypes.oneOf(['official']);
const _PublicationStage = PropTypes.oneOf(['published']);
const _Right = PropTypes.oneOf(['read']);
const _RowsUpdatedBy = PropTypes.oneOf(['pjxg-ve4m', '54a3-qyun', '9e3m-2843', 'vvca-fr6g']);
const _ViewType = PropTypes.oneOf(['tabular']);
_Grant = PropTypes.shape({
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(_GrantFlag)]).isRequired,
    "inherited": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": _GrantType,
});
_Test = PropTypes.shape({
    "CFPB1": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CustomFields = PropTypes.shape({
    "TEST": _Test,
});
_Group = PropTypes.shape({
    "columnFieldName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Order = PropTypes.shape({
    "ascending": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "columnFieldName": _OrderColumnFieldName,
});
_Select = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "columnFieldName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TableColumnID = PropTypes.shape({
    "2819740": PropTypes.oneOfType([Integer]).isRequired,
});
_ChildMetadata = PropTypes.shape({
    "customValues": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "freeform": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "includeAuto": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "operator": PropTypes.oneOfType([_MetadataOperator, PropTypes.oneOf([null])]),
    "tableColumnId": PropTypes.oneOfType([_TableColumnID, PropTypes.oneOf([null])]),
    "unifiedVersion": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_Child = PropTypes.shape({
    "columnFieldName": _ChildColumnFieldName,
    "metadata": PropTypes.oneOfType([_ChildMetadata, PropTypes.oneOf([null])]),
    "operator": _ChildOperator,
    "value": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Where = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_Child), PropTypes.oneOf([null])]),
    "columnFieldName": PropTypes.oneOfType([_ChildColumnFieldName, PropTypes.oneOf([null])]),
    "metadata": PropTypes.oneOfType([_ChildMetadata, PropTypes.oneOf([null])]),
    "operator": _WhereOperator,
    "value": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_JSONQuery = PropTypes.shape({
    "group": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "order": PropTypes.oneOfType([PropTypes.arrayOf(_Order), PropTypes.oneOf([null])]),
    "select": PropTypes.oneOfType([PropTypes.arrayOf(_Select), PropTypes.oneOf([null])]),
    "where": PropTypes.oneOfType([_Where, PropTypes.oneOf([null])]),
});
_PurpleVisible = PropTypes.shape({
    "fatrow": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "table": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_MetadataRenderTypeConfig = PropTypes.shape({
    "visible": _PurpleVisible,
});
_Field = PropTypes.shape({
    "tableColumnId": PropTypes.oneOfType([Integer]).isRequired,
    "type": _FieldType,
});
_Row = PropTypes.shape({
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(_Field)]).isRequired,
});
_Styles = PropTypes.shape({
    "width": _Width,
});
_Column = PropTypes.shape({
    "rows": PropTypes.oneOfType([PropTypes.arrayOf(_Row)]).isRequired,
    "styles": _Styles,
});
_FatRow = PropTypes.shape({
    "columns": PropTypes.oneOfType([PropTypes.arrayOf(_Column)]).isRequired,
});
_RichRendererConfigs = PropTypes.shape({
    "fatRow": _FatRow,
});
_AccessPoints = PropTypes.shape({
    "new_view": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FluffyVisible = PropTypes.shape({
    "href": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_V1ArchivedPropertiesRenderTypeConfig = PropTypes.shape({
    "visible": _FluffyVisible,
});
_V1ArchivedProperties = PropTypes.shape({
    "accessPoints": _AccessPoints,
    "blist_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "renderTypeConfig": _V1ArchivedPropertiesRenderTypeConfig,
});
_TopLevelMetadata = PropTypes.shape({
    "availableDisplayTypes": PropTypes.oneOfType([PropTypes.arrayOf(_DisplayType), PropTypes.oneOf([null])]),
    "custom_fields": PropTypes.oneOfType([_CustomFields, PropTypes.oneOf([null])]),
    "jsonQuery": PropTypes.oneOfType([_JSONQuery, PropTypes.oneOf([null])]),
    "rdfClass": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "rdfSubject": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "renderTypeConfig": PropTypes.oneOfType([_MetadataRenderTypeConfig, PropTypes.oneOf([null])]),
    "richRendererConfigs": PropTypes.oneOfType([_RichRendererConfigs, PropTypes.oneOf([null])]),
    "rowIdentifier": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "rowLabel": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "v1_archived_properties": PropTypes.oneOfType([_V1ArchivedProperties, PropTypes.oneOf([null])]),
});
_Owner = PropTypes.shape({
    "displayName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "lastNotificationSeenAt": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "profileImageUrlLarge": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "profileImageUrlMedium": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "profileImageUrlSmall": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "rights": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "roleName": PropTypes.oneOfType([_RoleName, PropTypes.oneOf([null])]),
    "screenName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Ratings = PropTypes.shape({
    "rating": PropTypes.oneOfType([Integer]).isRequired,
});
_TableAuthor = PropTypes.shape({
    "displayName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rights": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "roleName": PropTypes.oneOfType([_RoleName, PropTypes.oneOf([null])]),
    "screenName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "averageRating": PropTypes.oneOfType([Integer]).isRequired,
    "category": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "createdAt": PropTypes.oneOfType([Integer]).isRequired,
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "displayType": PropTypes.oneOfType([_DisplayType, PropTypes.oneOf([null])]),
    "downloadCount": PropTypes.oneOfType([Integer]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(_TopLevelFlag), PropTypes.oneOf([null])]),
    "grants": PropTypes.oneOfType([PropTypes.arrayOf(_Grant)]).isRequired,
    "hideFromCatalog": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hideFromDataJson": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "indexUpdatedAt": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "locale": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "metadata": _TopLevelMetadata,
    "moderationStatus": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "modifyingViewUid": PropTypes.oneOfType([_ModifyingViewUid, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "newBackend": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "numberOfComments": PropTypes.oneOfType([Integer]).isRequired,
    "oid": PropTypes.oneOfType([Integer]).isRequired,
    "owner": _Owner,
    "provenance": _Provenance,
    "publicationAppendEnabled": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "publicationDate": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "publicationGroup": PropTypes.oneOfType([Integer]).isRequired,
    "publicationStage": _PublicationStage,
    "ratings": PropTypes.oneOfType([_Ratings, PropTypes.oneOf([null])]),
    "resourceName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "rights": PropTypes.oneOfType([PropTypes.arrayOf(_Right)]).isRequired,
    "rowClass": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "rowIdentifierColumnId": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "rowsUpdatedAt": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "rowsUpdatedBy": PropTypes.oneOfType([_RowsUpdatedBy, PropTypes.oneOf([null])]),
    "tableAuthor": _TableAuthor,
    "tableId": PropTypes.oneOfType([Integer]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "totalTimesRated": PropTypes.oneOfType([Integer]).isRequired,
    "viewCount": PropTypes.oneOfType([Integer]).isRequired,
    "viewLastModified": PropTypes.oneOfType([Integer]).isRequired,
    "viewType": _ViewType,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
