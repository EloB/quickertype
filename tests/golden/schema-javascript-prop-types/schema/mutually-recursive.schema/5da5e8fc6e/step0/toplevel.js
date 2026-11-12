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

let _Bar;
let _TopLevel;
_Bar = PropTypes.shape({
    "foo": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf((...args) => _TopLevel(...args)), (...args) => _TopLevel(...args)])]).isRequired,
});
_TopLevel = PropTypes.shape({
    "bar": PropTypes.oneOfType([_Bar, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
