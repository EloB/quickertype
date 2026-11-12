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
    "one": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "two": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "three": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
