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
    "value": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0.1 && value <= 0.9) ? null : new Error("Expected bounded number"); }]).isRequired,
});

export const TopLevel = _TopLevel;
