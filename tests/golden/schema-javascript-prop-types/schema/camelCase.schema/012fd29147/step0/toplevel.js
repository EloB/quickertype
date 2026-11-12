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
_TopLevel = PropTypes.shape({
    "myProperty": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "secondProperty": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});

export const TopLevel = _TopLevel;
