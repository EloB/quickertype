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
    "boolean": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "integer": PropTypes.oneOfType([Integer]).isRequired,
    "integers": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "number": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "string": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
