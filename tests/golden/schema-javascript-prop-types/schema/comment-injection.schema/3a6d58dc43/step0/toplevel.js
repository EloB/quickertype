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
    "trailingBackslash": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "trailingQuote": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "trailingTripleQuote": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
