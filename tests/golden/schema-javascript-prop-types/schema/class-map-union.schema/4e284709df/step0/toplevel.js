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
let _UnionClass;
_UnionClass = PropTypes.shape({
    "quux": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_TopLevel = PropTypes.shape({
    "union": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([PropTypes.bool, _UnionClass, PropTypes.number, PropTypes.string])), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
