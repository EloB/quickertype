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
let _PC;
_PC = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "label": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "peak24": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "pc": _PC,
    "ps3": _PC,
    "ps4": _PC,
    "xbox": _PC,
    "xone": _PC,
});

export const TopLevel = _TopLevel;
