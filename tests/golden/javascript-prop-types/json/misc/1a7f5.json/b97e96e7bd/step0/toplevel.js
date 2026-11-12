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
const _Country = PropTypes.oneOf(['United States']);
_TopLevel = PropTypes.shape({
    "age": PropTypes.oneOfType([Integer]).isRequired,
    "country": _Country,
    "females": PropTypes.oneOfType([Integer]).isRequired,
    "males": PropTypes.oneOfType([Integer]).isRequired,
    "total": PropTypes.oneOfType([Integer]).isRequired,
    "year": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
