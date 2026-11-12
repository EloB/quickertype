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
let _ZClass;
_ZClass = PropTypes.shape({
    "a": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_TopLevel = PropTypes.shape({
    "x": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null]), PropTypes.string]))]).isRequired,
    "y": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]))]).isRequired,
    "z": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.arrayOf(Integer), _ZClass, Integer]))]).isRequired,
});

export const TopLevel = _TopLevel;
