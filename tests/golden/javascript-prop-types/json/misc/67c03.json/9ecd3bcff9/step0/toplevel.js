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
let _Person;
_Person = PropTypes.shape({
    "craft": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "message": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "number": PropTypes.oneOfType([Integer]).isRequired,
    "people": PropTypes.oneOfType([PropTypes.arrayOf(_Person)]).isRequired,
});

export const TopLevel = _TopLevel;
