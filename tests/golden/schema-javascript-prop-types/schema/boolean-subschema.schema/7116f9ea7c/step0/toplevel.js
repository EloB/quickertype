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
    "disallowed": PropTypes.any,
    "empty": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "foo": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "impossible": PropTypes.any,
});

export const TopLevel = _TopLevel;
