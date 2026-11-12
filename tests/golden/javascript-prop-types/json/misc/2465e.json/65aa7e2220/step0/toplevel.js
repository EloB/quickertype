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

let _TopLevel;
let _Definitions;
let _Taxonomy;
let _Properties;
let _Annotations;
let _Info;
let _Paths;
let _ItaTaxonomiesSearch;
let _Get;
let _Parameter;
let _Responses;
let _The200;
let _Schema;
_Annotations = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Properties = PropTypes.shape({
    "annotations": _Annotations,
    "datatype_properties": _Annotations,
    "id": _Annotations,
    "label": _Annotations,
    "sub_class_of": _Annotations,
    "type": _Annotations,
});
_Taxonomy = PropTypes.shape({
    "properties": _Properties,
});
_Definitions = PropTypes.shape({
    "Taxonomy": _Taxonomy,
});
_Info = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Parameter = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "format": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "in": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "required": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Schema = PropTypes.shape({
    "$ref": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_The200 = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "schema": _Schema,
});
_Responses = PropTypes.shape({
    "200": _The200,
});
_Get = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_Parameter)]).isRequired,
    "responses": _Responses,
    "summary": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
});
_ItaTaxonomiesSearch = PropTypes.shape({
    "get": _Get,
});
_Paths = PropTypes.shape({
    "/ita_taxonomies/search": _ItaTaxonomiesSearch,
});
_TopLevel = PropTypes.shape({
    "basePath": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "definitions": _Definitions,
    "host": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "info": _Info,
    "paths": _Paths,
    "produces": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "schemes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "swagger": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
