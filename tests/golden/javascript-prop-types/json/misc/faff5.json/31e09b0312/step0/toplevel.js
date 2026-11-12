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
let _Response;
_Response = PropTypes.shape({
    "player_count": PropTypes.oneOfType([Integer]).isRequired,
    "result": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "response": _Response,
});

export const TopLevel = _TopLevel;
