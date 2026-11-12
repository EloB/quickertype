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
let _Empty;
_Empty = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "empty": _Empty,
    "foo": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "bar": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});

export const TopLevel = _TopLevel;
