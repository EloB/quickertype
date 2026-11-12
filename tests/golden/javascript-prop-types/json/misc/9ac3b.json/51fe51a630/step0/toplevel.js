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
let _Facets;
let _Result;
const _Status = PropTypes.oneOf(['inactive', 'active']);
const _Title = PropTypes.oneOf(['Mr', 'Ms']);
_Facets = PropTypes.shape({
});
_Result = PropTypes.shape({
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "entity": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "first_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "last_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "position": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "status": _Status,
    "title": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Title, PropTypes.oneOf([null])])])(props, name, ...args),
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "uri": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "facets": _Facets,
    "limit": PropTypes.oneOfType([Integer]).isRequired,
    "next": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "offset": PropTypes.oneOfType([Integer]).isRequired,
    "previous": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
