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
    "above_i32_max": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 0 && value <= 2147483648) ? null : new Error("Expected bounded number"); }]).isRequired,
    "below_i32_min": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= -2147483649 && value <= 0) ? null : new Error("Expected bounded number"); }]).isRequired,
    "i32_range": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= -2147483648 && value <= 2147483647) ? null : new Error("Expected bounded number"); }]).isRequired,
    "large_bounds": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= -9007199254740991 && value <= 9007199254740991) ? null : new Error("Expected bounded number"); }]).isRequired,
    "only_maximum": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value <= 0) ? null : new Error("Expected bounded number"); }]).isRequired,
    "only_minimum": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 0) ? null : new Error("Expected bounded number"); }]).isRequired,
    "small_negative": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= -100 && value <= 0) ? null : new Error("Expected bounded number"); }]).isRequired,
    "small_positive": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 0 && value <= 100) ? null : new Error("Expected bounded number"); }]).isRequired,
    "unbounded": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = _TopLevel;
