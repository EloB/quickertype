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
const _Kind = PropTypes.oneOf(['widget']);
_TopLevel = PropTypes.shape({
    "amount": PropTypes.oneOfType([Integer]).isRequired,
    "enabled": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "kind": _Kind,
    "ratio": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.number]).isRequired,
});

export const TopLevel = _TopLevel;
