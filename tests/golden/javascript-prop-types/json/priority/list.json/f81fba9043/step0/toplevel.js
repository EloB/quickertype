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
    "data": PropTypes.oneOfType([Integer]).isRequired,
    "next": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([(...args) => _TopLevel(...args), PropTypes.oneOf([null])])])(props, name, ...args),
});

export const TopLevel = _TopLevel;
