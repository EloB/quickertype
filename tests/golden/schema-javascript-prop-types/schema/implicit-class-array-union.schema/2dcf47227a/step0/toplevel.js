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
let _FooClass;
_FooClass = PropTypes.shape({
    "bar": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "foo": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(Integer), PropTypes.bool, _FooClass, PropTypes.number, Integer, PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
});

export const TopLevel = _TopLevel;
