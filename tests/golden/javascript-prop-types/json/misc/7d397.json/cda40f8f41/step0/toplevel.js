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
let _List;
let _Property;
let _Info;
let _Paths;
let _ConsolidatedScreeningListSearch;
let _Get;
let _Parameter;
let _Responses;
let _The200;
let _Schema;
let _Items;
const _Type = PropTypes.oneOf(['string']);
const _In = PropTypes.oneOf(['query']);
_Property = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _Type,
});
_List = PropTypes.shape({
    "properties": PropTypes.oneOfType([PropTypes.objectOf(_Property)]).isRequired,
});
_Definitions = PropTypes.shape({
    "List": _List,
});
_Info = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Parameter = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "format": _Type,
    "in": _In,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "required": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": _Type,
});
_Items = PropTypes.shape({
    "$ref": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Schema = PropTypes.shape({
    "items": _Items,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
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
_ConsolidatedScreeningListSearch = PropTypes.shape({
    "get": _Get,
});
_Paths = PropTypes.shape({
    "/consolidated_screening_list/search": _ConsolidatedScreeningListSearch,
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
