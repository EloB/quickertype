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
    "minMaxLength": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 5 && [...value].length <= 5) ? null : new Error("Expected bounded string"); }]).isRequired,
    "percent": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }]).isRequired,
});

export const TopLevel = _TopLevel;
