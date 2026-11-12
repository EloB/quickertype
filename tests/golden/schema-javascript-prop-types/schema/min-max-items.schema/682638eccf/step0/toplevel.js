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
    "maxOnly": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (false || value.length > 3)) return new Error("Expected bounded array"); return PropTypes.arrayOf(Integer)(props, name, ...args); }]).isRequired,
    "minAndMax": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 1 || value.length > 4)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.number)(props, name, ...args); }]).isRequired,
    "minOnly": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 2 || false)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.string)(props, name, ...args); }]).isRequired,
    "plain": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "unionItems": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 2 || false)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.string]))(props, name, ...args); }]).isRequired,
});

export const TopLevel = _TopLevel;
