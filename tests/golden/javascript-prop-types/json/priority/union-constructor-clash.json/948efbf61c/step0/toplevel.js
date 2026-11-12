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
let _BoolInUnion;
_BoolInUnion = PropTypes.shape({
    "a": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_TopLevel = PropTypes.shape({
    "BoolInUnion": _BoolInUnion,
    "union": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.bool, Integer]))]).isRequired,
});

export const TopLevel = _TopLevel;
