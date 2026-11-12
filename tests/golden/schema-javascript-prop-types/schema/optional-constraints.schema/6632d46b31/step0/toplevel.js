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
    "optDouble": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0.5 && value <= 99.5) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "optInt": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 0 && value <= 100) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "optPattern": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("^[a-z]+$").test(value)) ? null : new Error("Expected bounded string"); }]),
    "optString": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3 && [...value].length <= 10) ? null : new Error("Expected bounded string"); }]),
    "reqZeroMin": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 0 && value <= 100) ? null : new Error("Expected bounded number"); }]).isRequired,
});

export const TopLevel = _TopLevel;
