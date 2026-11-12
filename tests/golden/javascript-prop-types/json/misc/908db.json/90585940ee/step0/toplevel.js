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

let _TopLevel;
let _StateElement;
let _StateState;
_StateState = PropTypes.shape({
    "state_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "state_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_StateElement = PropTypes.shape({
    "state": _StateState,
});
_TopLevel = PropTypes.shape({
    "states": PropTypes.oneOfType([PropTypes.arrayOf(_StateElement)]).isRequired,
});

export const TopLevel = _TopLevel;
