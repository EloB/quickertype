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
let _Node;
_Node = PropTypes.shape({
    "next": PropTypes.oneOfType([_Node, PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "next": PropTypes.oneOfType([_Node, PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
