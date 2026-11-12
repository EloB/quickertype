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
let _Query;
let _Grant;
let _License;
let _Metadata;
let _RenderTypeConfig;
let _Visible;
let _Owner;
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
_Query = PropTypes.shape({
});
_Column = PropTypes.shape({
    "cachedContents": PropTypes.oneOfType([_CachedContents, PropTypes.oneOf([null])]),
    "dataTypeName": _TypeName,
    "fieldName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "format": _Query,
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
_License = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Visible = PropTypes.shape({
    "table": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_RenderTypeConfig = PropTypes.shape({
    "visible": _Visible,
});
_Metadata = PropTypes.shape({
    "availableDisplayTypes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "rdfClass": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rdfSubject": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "renderTypeConfig": _RenderTypeConfig,
    "rowIdentifier": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Owner = PropTypes.shape({
    "displayName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "screenName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_View = PropTypes.shape({
    "averageRating": PropTypes.oneOfType([Integer]).isRequired,
    "category": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "columns": PropTypes.oneOfType([PropTypes.arrayOf(_Column)]).isRequired,
    "createdAt": PropTypes.oneOfType([Integer]).isRequired,
    "displayType": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "downloadCount": PropTypes.oneOfType([Integer]).isRequired,
    "flags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "grants": PropTypes.oneOfType([PropTypes.arrayOf(_Grant)]).isRequired,
    "hideFromCatalog": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hideFromDataJson": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "indexUpdatedAt": PropTypes.oneOfType([Integer]).isRequired,
    "license": _License,
    "licenseId": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "locale": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "metadata": _Metadata,
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
    "rowClass": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rowsUpdatedAt": PropTypes.oneOfType([Integer]).isRequired,
    "rowsUpdatedBy": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tableAuthor": _Owner,
    "tableId": PropTypes.oneOfType([Integer]).isRequired,
    "totalTimesRated": PropTypes.oneOfType([Integer]).isRequired,
    "viewCount": PropTypes.oneOfType([Integer]).isRequired,
    "viewLastModified": PropTypes.oneOfType([Integer]).isRequired,
    "viewType": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Meta = PropTypes.shape({
    "view": _View,
});
_TopLevel = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.string])))]).isRequired,
    "meta": _Meta,
});

export const TopLevel = _TopLevel;
