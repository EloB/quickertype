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
_TopLevel = PropTypes.shape({
    "arrNullable": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])), PropTypes.oneOf([null])]),
    "arrOne": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "nullable": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "one": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "optional": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "unionWithBool": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.bool, PropTypes.string])]).isRequired,
    "unionWithBoolAndEnum": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.bool, PropTypes.string])]).isRequired,
});

export const TopLevel = _TopLevel;
