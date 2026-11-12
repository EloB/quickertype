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
    "date": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "validity": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});

export const TopLevel = _TopLevel;
