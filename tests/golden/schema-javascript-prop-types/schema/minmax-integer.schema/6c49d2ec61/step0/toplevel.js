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
_TopLevel = PropTypes.shape({
    "free": PropTypes.oneOfType([Integer]).isRequired,
    "intersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 4 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "max": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "min": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 3) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minmax": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 3 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minMaxIntersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 3 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minMaxUnion": PropTypes.oneOfType([Integer]).isRequired,
    "union": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 3 && value <= 6) ? null : new Error("Expected bounded number"); }]).isRequired,
});

export const TopLevel = _TopLevel;
