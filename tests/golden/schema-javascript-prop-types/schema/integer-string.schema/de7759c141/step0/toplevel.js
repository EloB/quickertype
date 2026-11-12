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
    "arrNullable": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])), PropTypes.oneOf([null])]),
    "arrOne": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "nullable": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "one": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "optional": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "unionWithInt": PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.string])]).isRequired,
    "unionWithIntAndEnum": PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.string])]).isRequired,
});

export const TopLevel = _TopLevel;
