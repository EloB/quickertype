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
    "block_index": PropTypes.oneOfType([Integer]).isRequired,
    "hash": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "height": PropTypes.oneOfType([Integer]).isRequired,
    "time": PropTypes.oneOfType([Integer]).isRequired,
    "txIndexes": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
});

export const TopLevel = _TopLevel;
