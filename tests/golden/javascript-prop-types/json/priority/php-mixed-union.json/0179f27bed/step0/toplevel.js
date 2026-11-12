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
let _MixedClass;
_MixedClass = PropTypes.shape({
    "nested": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "mixed": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.bool, _MixedClass, Integer, PropTypes.oneOf([null]), PropTypes.string]))]).isRequired,
});

export const TopLevel = _TopLevel;
