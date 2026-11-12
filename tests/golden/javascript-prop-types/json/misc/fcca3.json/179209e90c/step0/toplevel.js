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
let _Meta;
let _View;
let _Column;
let _CachedContents;
let _Top;
let _Format;
let _Grant;
let _ViewMetadata;
let _Attachment;
let _CustomFields;
let _CommonCore;
let _DatasetInformation;
let _DatasetSummary;
let _Disclaimers;
let _FilterCondition;
let _Child;
let _ChildMetadata;
let _TableColumnID;
let _FilterConditionMetadata;
let _JSONQuery;
let _Order;
let _RenderTypeConfig;
let _Visible;
let _Owner;
let _Query;
let _OrderBy;
let _Expression;
const _TypeName = PropTypes.oneOf(['meta_data', 'number', 'text']);
_Top = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "item": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CachedContents = PropTypes.shape({
    "average": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "largest": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "non_null": PropTypes.oneOfType([Integer]).isRequired,
    "null": PropTypes.oneOfType([Integer]).isRequired,
    "smallest": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sum": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "top": PropTypes.oneOfType([PropTypes.arrayOf(_Top)]).isRequired,
});
_Format = PropTypes.shape({
    "align": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "noCommas": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "precisionStyle": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Column = PropTypes.shape({
    "cachedContents": PropTypes.oneOfType([_CachedContents, PropTypes.oneOf([null])]),
    "dataTypeName": _TypeName,
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fieldName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "format": _Format,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "position": PropTypes.oneOfType([Integer]).isRequired,
    "renderTypeName": _TypeName,
    "tableColumnId": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_Grant = PropTypes.shape({
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "inherited": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Attachment = PropTypes.shape({
    "assetId": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "blobId": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "filename": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CommonCore = PropTypes.shape({
    "Contact Email": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Contact Name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Publisher": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_DatasetInformation = PropTypes.shape({
    "Agency": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_DatasetSummary = PropTypes.shape({
    "Contact Information": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Coverage": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Granularity": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Organization": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Posting Frequency": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Time Period": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Disclaimers = PropTypes.shape({
    "Disclaimer": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Limitations": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CustomFields = PropTypes.shape({
    "Common Core": _CommonCore,
    "Dataset Information": _DatasetInformation,
    "Dataset Summary": _DatasetSummary,
    "Disclaimers": _Disclaimers,
});
_TableColumnID = PropTypes.shape({
    "703610": PropTypes.oneOfType([Integer]).isRequired,
});
_ChildMetadata = PropTypes.shape({
    "customValues": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.string))]).isRequired,
    "operator": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tableColumnId": _TableColumnID,
});
_Child = PropTypes.shape({
    "metadata": _ChildMetadata,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FilterConditionMetadata = PropTypes.shape({
    "advanced": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "unifiedVersion": PropTypes.oneOfType([Integer]).isRequired,
});
_FilterCondition = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_Child)]).isRequired,
    "metadata": _FilterConditionMetadata,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Order = PropTypes.shape({
    "ascending": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "columnFieldName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_JSONQuery = PropTypes.shape({
    "order": PropTypes.oneOfType([PropTypes.arrayOf(_Order)]).isRequired,
});
_Visible = PropTypes.shape({
    "table": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_RenderTypeConfig = PropTypes.shape({
    "visible": _Visible,
});
_ViewMetadata = PropTypes.shape({
    "attachments": PropTypes.oneOfType([PropTypes.arrayOf(_Attachment)]).isRequired,
    "availableDisplayTypes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "custom_fields": _CustomFields,
    "filterCondition": _FilterCondition,
    "jsonQuery": _JSONQuery,
    "rdfSubject": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "renderTypeConfig": _RenderTypeConfig,
    "rowLabel": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Owner = PropTypes.shape({
    "displayName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "profileImageUrlLarge": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "profileImageUrlMedium": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "profileImageUrlSmall": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rights": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "roleName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "screenName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Expression = PropTypes.shape({
    "columnId": PropTypes.oneOfType([Integer]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_OrderBy = PropTypes.shape({
    "ascending": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "expression": _Expression,
});
_Query = PropTypes.shape({
    "orderBys": PropTypes.oneOfType([PropTypes.arrayOf(_OrderBy)]).isRequired,
});
_View = PropTypes.shape({
    "attribution": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "averageRating": PropTypes.oneOfType([Integer]).isRequired,
    "category": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "columns": PropTypes.oneOfType([PropTypes.arrayOf(_Column)]).isRequired,
    "createdAt": PropTypes.oneOfType([Integer]).isRequired,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "displayType": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "downloadCount": PropTypes.oneOfType([Integer]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "grants": PropTypes.oneOfType([PropTypes.arrayOf(_Grant)]).isRequired,
    "hideFromCatalog": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hideFromDataJson": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "indexUpdatedAt": PropTypes.oneOfType([Integer]).isRequired,
    "locale": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "metadata": _ViewMetadata,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "newBackend": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "numberOfComments": PropTypes.oneOfType([Integer]).isRequired,
    "oid": PropTypes.oneOfType([Integer]).isRequired,
    "owner": _Owner,
    "provenance": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "publicationAppendEnabled": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "publicationDate": PropTypes.oneOfType([Integer]).isRequired,
    "publicationGroup": PropTypes.oneOfType([Integer]).isRequired,
    "publicationStage": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "query": _Query,
    "rights": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "rowsUpdatedAt": PropTypes.oneOfType([Integer]).isRequired,
    "rowsUpdatedBy": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tableAuthor": _Owner,
    "tableId": PropTypes.oneOfType([Integer]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "totalTimesRated": PropTypes.oneOfType([Integer]).isRequired,
    "viewCount": PropTypes.oneOfType([Integer]).isRequired,
    "viewLastModified": PropTypes.oneOfType([Integer]).isRequired,
    "viewType": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Meta = PropTypes.shape({
    "view": _View,
});
_TopLevel = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null]), PropTypes.string])))]).isRequired,
    "meta": _Meta,
});

export const TopLevel = _TopLevel;
