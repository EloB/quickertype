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
let _Option;
_Option = PropTypes.shape({
    "foo": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "options": PropTypes.oneOfType([PropTypes.arrayOf(_Option)]).isRequired,
});

export const TopLevel = _TopLevel;
