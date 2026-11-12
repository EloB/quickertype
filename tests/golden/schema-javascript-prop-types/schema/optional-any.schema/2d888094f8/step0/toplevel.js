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
    "bar": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "foo": PropTypes.any,
});

export const TopLevel = _TopLevel;
