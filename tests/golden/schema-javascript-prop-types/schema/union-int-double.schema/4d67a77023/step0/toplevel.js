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
    "value": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.number, PropTypes.string])]).isRequired,
});

export const TopLevel = _TopLevel;
