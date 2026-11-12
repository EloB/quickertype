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
let _Datum;
let _Description;
_Datum = PropTypes.shape({
    "anomaly": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Description = PropTypes.shape({
    "base_period": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "missing": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.objectOf(_Datum)]).isRequired,
    "description": _Description,
});

export const TopLevel = _TopLevel;
