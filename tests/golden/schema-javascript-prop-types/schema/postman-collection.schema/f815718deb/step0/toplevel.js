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
let _Response;
_Response = PropTypes.shape({
    "body": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "item": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _TopLevel(...args)), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "response": PropTypes.oneOfType([PropTypes.arrayOf(_Response), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
