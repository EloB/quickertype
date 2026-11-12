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
let _Errors;
_Errors = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "column_names": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "data": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.number, PropTypes.oneOf([null])])))]).isRequired,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "display_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "errors": _Errors,
    "frequency": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "from_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "premium": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "source_code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "source_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "to_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "urlize_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
