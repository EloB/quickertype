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
const _Value = PropTypes.oneOf(['c0\u0001\u001b\u001f', 'c1\u007f\u0080\u0085\u009f']);
_TopLevel = PropTypes.shape({
    "#{1+1}": PropTypes.oneOfType([Integer]).isRequired,
    "literal": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "values": PropTypes.oneOfType([PropTypes.arrayOf(_Value)]).isRequired,
});

export const TopLevel = _TopLevel;
