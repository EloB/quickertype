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
let _IssPosition;
_IssPosition = PropTypes.shape({
    "latitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "longitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "iss_position": _IssPosition,
    "message": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "timestamp": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = _TopLevel;
